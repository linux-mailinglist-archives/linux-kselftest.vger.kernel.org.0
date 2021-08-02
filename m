Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31C483DDE09
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Aug 2021 18:54:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233160AbhHBQy3 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 2 Aug 2021 12:54:29 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3564 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232322AbhHBQy3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 2 Aug 2021 12:54:29 -0400
Received: from fraeml709-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4GdkcL0Zbqz6BBS9;
        Tue,  3 Aug 2021 00:54:10 +0800 (CST)
Received: from fraeml714-chm.china.huawei.com (10.206.15.33) by
 fraeml709-chm.china.huawei.com (10.206.15.37) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 2 Aug 2021 18:54:17 +0200
Received: from fraeml714-chm.china.huawei.com ([10.206.15.33]) by
 fraeml714-chm.china.huawei.com ([10.206.15.33]) with mapi id 15.01.2176.012;
 Mon, 2 Aug 2021 18:54:17 +0200
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     Mimi Zohar <zohar@linux.ibm.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "mchehab+huawei@kernel.org" <mchehab+huawei@kernel.org>
CC:     "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [RFC][PATCH v2 06/12] diglim: Interfaces - digest_list_add,
 digest_list_del
Thread-Topic: [RFC][PATCH v2 06/12] diglim: Interfaces - digest_list_add,
 digest_list_del
Thread-Index: AQHXgjzPxJ6WuoGgH0KyG3D/y7w0xqtaWSsAgADBDpCAAD+ygIAAIhjQgAS3MgCAACHtEIAAD/Dg
Date:   Mon, 2 Aug 2021 16:54:17 +0000
Message-ID: <f7adeb81bab24b689c3e1aa61d83c6f5@huawei.com>
References: <20210726163700.2092768-1-roberto.sassu@huawei.com>
         <20210726163700.2092768-7-roberto.sassu@huawei.com>
         <c9dffd9d29df095660beaa631ff252c4b33629a0.camel@linux.ibm.com>
         <ef7c85dcb096479e95c8c60ccda4d700@huawei.com>
         <1ef95096bee13578b3f906dd9f708c6af9d6ff18.camel@linux.ibm.com>
         <555bf01bee4b4ea7a9bee658366d535a@huawei.com>
 <3e6a54d4be87a3eafc45c85d013250d17aa0835e.camel@linux.ibm.com> 
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.221.98.153]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> From: Roberto Sassu
> Sent: Monday, August 2, 2021 5:13 PM
> > From: Mimi Zohar [mailto:zohar@linux.ibm.com]
> > Sent: Monday, August 2, 2021 4:42 PM
> > Hi Roberto,
> >
> > On Fri, 2021-07-30 at 13:16 +0000, Roberto Sassu wrote:
> >
> > > The reason of storing the actions performed by IMA on the
> > > digest lists helps to determine for which purpose they can be
> > > used. If digest lists are used only for measurement purpose,
> > > it should be sufficient that digest lists are measured. The
> > > same applies for appraisal.
> >
> > Is that assumption correct?   How would you know if the digests lists
> > are only being used one way and not the other.  For example, assuming
> > that the digest lists are stored on protected media, the digest lists
> > could be measured, but would not necessarily be appraised.
> 
> Hi Mimi
> 
> the actions performed by IMA on the digest lists are recorded
> in the digest_list_item structure. These can be retrieved when
> IMA calls diglim_digest_get_info() (actually it is the OR of the
> actions for the digest lists that contain the digest passed as a
> query).
> 
> At the moment, DIGLIM can only know whether a digest list
> has been measured or not (with the return value of
> ima_measure_critical_data()). In the next patch set, I add the
> changes to get the actions from the integrity_iint_cache().
> 
> > > > Adding the kernel_read_file() "READING_DIGEST_LIST" support in IMA
> > does
> > > > not seem to be optional.  IMA would then be calculating the digest list
> > > > file hash twice, once in kernel_read_file() and then, again, in
> > > > ima_measure_critical_data().
> > >
> > > I didn't include also this part: I retrieve the integrity_iint_cache for
> > > the opened file descriptor and I get the flags from there. If the
> > > IMA_MEASURED flag is set, it is not necessary to call also
> > > ima_measure_critical_data().
> >
> > Right, assuming the file is in policy, the digest would already be
> > stored in the iint cache.
> >
> > > > > > I understand that with your changes to ima_measure_critical_data(),
> > > > > > which are now in next-integrity-testing branch, allow IMA to calculate
> > > > > > the file data hash.
> > > > >
> > > > > Yes, correct. But actually there is another useful use case.
> > > > > If digest lists are not in the format supported by the kernel,
> > > > > the user space parser has to convert them before uploading
> > > > > them to the kernel.
> > > > >
> > > > > ima_measure_critical_data() would in this case measure
> > > > > the converted digest list (it is written directly, without
> > > > > sending the file path). It is easier to attest the result,
> > > > > instead of determining whether the user space parser
> > > > > produced the expected result (by checking the files it
> > > > > read).
> > > >
> > > > The application to properly convert the digest list file data into the
> > > > appropriate format would need to be trusted.  I'm concerned that not
> > > > requiring the converted data to be signed and the signature verified is
> > > > introducing a new integrity gap.  Perhaps between an LSM policy,
> > > > limiting which files may be read by the application, and an IMA policy,
> > > > requiring all files read by this application to be measured and the
> > > > signature verified, this integrity gap could be averted.
> > >
> > > It is the weakest point in the chain, yes. Relying on existing LSMs
> > > didn't seem to me a good idea, as:
> > > - a new policy must be installed
> > > - we must be sure that the policy is really enforced
> > > - we need to support different LSMs (SELinux for Fedora,
> > >   Apparmor for SUSE)
> > > - there might be no LSM we can rely on
> > >
> > > For these reasons, I developed a new LSM. Its purpose is to
> > > identify the user space parser and for each file it opens, ensure
> > > that the file has been measured or appraised by IMA. If one of
> > > these actions are missing, it will not be set in the digest list the
> > > user space parser uploads to the kernel (which means that IMA
> > > will ignore the digest list for that specific action).
> >
> > Properly identifying (all) user space parser(s) would be critical.  It
> > would be simpler and  safer to require the converted data be signed.

When a process directly uploads a buffer to the kernel, the actions are
added to a digest list depending on the result of ima_measure_critical_data()
and from the actions attached to the process credentials and set by the
new LSM.

If a process fails the identification, the actions in the process credentials
remain zero and the digest lists the process uploads will be ignored by IMA.

The actions in the process credentials are set with the actions performed
on the executable by IMA, only if the digest of the executable is found in
a digest list and the digest list type is COMPACT_PARSER. The parser is
statically linked.

The digest list for the parser can be generated at the end of the
building process and signed similarly to kernel modules (for SUSE,
with pesign-obs-integration). This is the only exception to handle,
other packages are not affected.

After the parser has been identified, each file operation is monitored.
The LSM has to explicitly perform a second open to ensure that
the file is measured/appraised before the integrity_iint_cache structure
is retrieved (because IMA is called after all LSMs).

If an action is missing from the integrity_iint_cache structure, it
will be cleared by the LSM in the actions attached to the process
credentials, and will not be added to the digest list being uploaded.

Roberto

HUAWEI TECHNOLOGIES Duesseldorf GmbH, HRB 56063
Managing Director: Li Peng, Li Jian, Shi Yanli

> I agree, it would be much easier. However, it would require changes
> to the building infrastructure of Linux distribution vendors, which
> might limit the applicability of DIGLIM.
> 
> With the user space parser taking care of the conversion, distributions
> can do appraisal of executables and shared libraries with an update of:
> - the kernel: to add DIGLIM
> - dracut: to add required digest lists in the initial ram disk
> - rpm (plugin): to extract the RPM header and its signature and write
>   them to a file that is uploaded to the kernel by the user space parser
> 
> I'm planning to append the signature at the end of the RPM header
> (and use appraise_type=modsig) to avoid the dependency on the
> 'initramfs: add support for xattrs in the initial ram disk' patch set
> (which I might try to resume in the future).
> 
> Thanks
> 
> Roberto
> 
> HUAWEI TECHNOLOGIES Duesseldorf GmbH, HRB 56063
> Managing Director: Li Peng, Li Jian, Shi Yanli
> 
> > thanks,
> >
> > Mimi

