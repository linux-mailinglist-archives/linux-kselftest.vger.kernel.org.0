Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF4223DB925
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Jul 2021 15:16:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238925AbhG3NQu convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 30 Jul 2021 09:16:50 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3540 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231140AbhG3NQt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 30 Jul 2021 09:16:49 -0400
Received: from fraeml710-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Gbng004Snz6L9ZH;
        Fri, 30 Jul 2021 21:04:44 +0800 (CST)
Received: from fraeml714-chm.china.huawei.com (10.206.15.33) by
 fraeml710-chm.china.huawei.com (10.206.15.59) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 30 Jul 2021 15:16:42 +0200
Received: from fraeml714-chm.china.huawei.com ([10.206.15.33]) by
 fraeml714-chm.china.huawei.com ([10.206.15.33]) with mapi id 15.01.2176.012;
 Fri, 30 Jul 2021 15:16:42 +0200
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
Thread-Index: AQHXgjzPxJ6WuoGgH0KyG3D/y7w0xqtaWSsAgADBDpCAAD+ygIAAIhjQ
Date:   Fri, 30 Jul 2021 13:16:42 +0000
Message-ID: <555bf01bee4b4ea7a9bee658366d535a@huawei.com>
References: <20210726163700.2092768-1-roberto.sassu@huawei.com>
         <20210726163700.2092768-7-roberto.sassu@huawei.com>
         <c9dffd9d29df095660beaa631ff252c4b33629a0.camel@linux.ibm.com>
         <ef7c85dcb096479e95c8c60ccda4d700@huawei.com>
 <1ef95096bee13578b3f906dd9f708c6af9d6ff18.camel@linux.ibm.com>
In-Reply-To: <1ef95096bee13578b3f906dd9f708c6af9d6ff18.camel@linux.ibm.com>
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

> From: Mimi Zohar [mailto:zohar@linux.ibm.com]
> Sent: Friday, July 30, 2021 2:40 PM
> Hi Roberto,
> 
> On Fri, 2021-07-30 at 07:16 +0000, Roberto Sassu wrote:
> > > From: Mimi Zohar [mailto:zohar@linux.ibm.com]
> > > Sent: Thursday, July 29, 2021 11:21 PM
> > >
> > > On Mon, 2021-07-26 at 18:36 +0200, Roberto Sassu wrote:
> > > > /*
> > > > + * digest_list_read: read and parse the digest list from the path
> > > > + */
> > > > +static ssize_t digest_list_read(char *path, enum ops op)
> > > > +{
> > > > +       void *data = NULL;
> > > > +       char *datap;
> > > > +       size_t size;
> > > > +       u8 actions = 0;
> > > > +       struct file *file;
> > > > +       char event_name[NAME_MAX + 9 + 1];
> > > > +       u8 digest[IMA_MAX_DIGEST_SIZE] = { 0 };
> > > > +       enum hash_algo algo;
> > > > +       int rc, pathlen = strlen(path);
> > > > +
> > > > +       /* Remove \n. */
> > > > +       datap = path;
> > > > +       strsep(&datap, "\n");
> > > > +
> > > > +       file = filp_open(path, O_RDONLY, 0);
> > > > +       if (IS_ERR(file)) {
> > > > +               pr_err("unable to open file: %s (%ld)", path, PTR_ERR(file));
> > > > +               return PTR_ERR(file);
> > > > +       }
> > > > +
> > > > +       rc = kernel_read_file(file, 0, &data, INT_MAX, NULL,
> > > > +                             READING_DIGEST_LIST);
> > > > +       if (rc < 0) {
> > > > +               pr_err("unable to read file: %s (%d)", path, rc);
> > > > +               goto out;
> > > > +       }
> > > > +
> > > > +       size = rc;
> > > > +
> > > > +       snprintf(event_name, sizeof(event_name), "%s_file_%s",
> > > > +                op == DIGEST_LIST_ADD ? "add" : "del",
> > > > +                file_dentry(file)->d_name.name);
> > > > +
> > > > +       rc = ima_measure_critical_data("diglim", event_name, data, size,
> false,
> > > > +                                      digest, sizeof(digest));
> > > > +       if (rc < 0 && rc != -EEXIST)
> > > > +               goto out_vfree;
> > >
> > > The digest lists could easily be measured while reading the digest list
> > > file above in kernel_read_file().  What makes it "critical-data"?  In
> > > the SELinux case, the in memory SELinux policy is being measured and
> > > re-measured to make sure it hasn't been modified.  Is the digest list
> > > file data being measured more than once?
> >
> > Hi Mimi
> >
> > yes, the digest lists can be measured with kernel_read_file().
> > I didn't send the change yet, but I added a DIGEST_LIST_CHECK
> > hook mapped to READING_DIGEST_LIST, so that digest lists
> > can be easily measured or appraised.
> >
> > The point was that the digest of the digest list must be always
> > calculated, as it is added to the hash table. Instead of duplicating
> > the code, I preferred to use ima_measure_critical_data().
> >
> > The advantage is also that, if the use case is to just measure
> > digest lists, ima_measure_critical_data() could do both at the
> > same time.
> >
> > Digest lists can be seen as "critical data" in the sense that
> > they can affect the security decision on whether to grant
> > access to a file or not, assuming that an appropriate rule is
> > added in the IMA policy.
> 
> Of course the integrity of files containing the digest lists is
> important, but that doesn't make them "critical data".  If the
> integrity of these files is important, then the digest lists not only
> need to be measured, but they need to be signed and the resulting
> signature verified.  Without signature verification, there is no basis
> on which to trust the digest lists data.

The reason of storing the actions performed by IMA on the
digest lists helps to determine for which purpose they can be
used. If digest lists are used only for measurement purpose,
it should be sufficient that digest lists are measured. The
same applies for appraisal.

> Adding the kernel_read_file() "READING_DIGEST_LIST" support in IMA does
> not seem to be optional.  IMA would then be calculating the digest list
> file hash twice, once in kernel_read_file() and then, again, in
> ima_measure_critical_data().

I didn't include also this part: I retrieve the integrity_iint_cache for
the opened file descriptor and I get the flags from there. If the
IMA_MEASURED flag is set, it is not necessary to call also
ima_measure_critical_data().

> > > I understand that with your changes to ima_measure_critical_data(),
> > > which are now in next-integrity-testing branch, allow IMA to calculate
> > > the file data hash.
> >
> > Yes, correct. But actually there is another useful use case.
> > If digest lists are not in the format supported by the kernel,
> > the user space parser has to convert them before uploading
> > them to the kernel.
> >
> > ima_measure_critical_data() would in this case measure
> > the converted digest list (it is written directly, without
> > sending the file path). It is easier to attest the result,
> > instead of determining whether the user space parser
> > produced the expected result (by checking the files it
> > read).
> 
> The application to properly convert the digest list file data into the
> appropriate format would need to be trusted.  I'm concerned that not
> requiring the converted data to be signed and the signature verified is
> introducing a new integrity gap.  Perhaps between an LSM policy,
> limiting which files may be read by the application, and an IMA policy,
> requiring all files read by this application to be measured and the
> signature verified, this integrity gap could be averted.

It is the weakest point in the chain, yes. Relying on existing LSMs
didn't seem to me a good idea, as:
- a new policy must be installed
- we must be sure that the policy is really enforced
- we need to support different LSMs (SELinux for Fedora,
  Apparmor for SUSE)
- there might be no LSM we can rely on

For these reasons, I developed a new LSM. Its purpose is to
identify the user space parser and for each file it opens, ensure
that the file has been measured or appraised by IMA. If one of
these actions are missing, it will not be set in the digest list the
user space parser uploads to the kernel (which means that IMA
will ignore the digest list for that specific action).

> "critical data", in this context, should probably be used for verifying
> the in memory file digests and other state information haven't been
> compromised.

Actually, this is what we are doing currently. To keep the
implementation simple, once the file or the buffer are uploaded
to the kernel, they will not be modified, just accessed through
the indexes.

I could send the second part of the patch set, so that it becomes
more clear how digest lists are used by IMA and how the
integrity gap is filled.

Thanks

Roberto

HUAWEI TECHNOLOGIES Duesseldorf GmbH, HRB 56063
Managing Director: Li Peng, Li Jian, Shi Yanli

> thanks,
> 
> Mimi

