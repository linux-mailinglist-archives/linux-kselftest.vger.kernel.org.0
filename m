Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02E9E3DB454
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Jul 2021 09:16:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237558AbhG3HQI convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 30 Jul 2021 03:16:08 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3535 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230273AbhG3HQI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 30 Jul 2021 03:16:08 -0400
Received: from fraeml713-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Gbdfp5sqqz6LBk7;
        Fri, 30 Jul 2021 15:04:02 +0800 (CST)
Received: from fraeml714-chm.china.huawei.com (10.206.15.33) by
 fraeml713-chm.china.huawei.com (10.206.15.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 30 Jul 2021 09:16:00 +0200
Received: from fraeml714-chm.china.huawei.com ([10.206.15.33]) by
 fraeml714-chm.china.huawei.com ([10.206.15.33]) with mapi id 15.01.2176.012;
 Fri, 30 Jul 2021 09:16:00 +0200
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
Thread-Index: AQHXgjzPxJ6WuoGgH0KyG3D/y7w0xqtaWSsAgADBDpA=
Date:   Fri, 30 Jul 2021 07:16:00 +0000
Message-ID: <ef7c85dcb096479e95c8c60ccda4d700@huawei.com>
References: <20210726163700.2092768-1-roberto.sassu@huawei.com>
         <20210726163700.2092768-7-roberto.sassu@huawei.com>
 <c9dffd9d29df095660beaa631ff252c4b33629a0.camel@linux.ibm.com>
In-Reply-To: <c9dffd9d29df095660beaa631ff252c4b33629a0.camel@linux.ibm.com>
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
> Sent: Thursday, July 29, 2021 11:21 PM
> Hi Roberto,
> 
> On Mon, 2021-07-26 at 18:36 +0200, Roberto Sassu wrote:
> > /*
> > + * digest_list_read: read and parse the digest list from the path
> > + */
> > +static ssize_t digest_list_read(char *path, enum ops op)
> > +{
> > +       void *data = NULL;
> > +       char *datap;
> > +       size_t size;
> > +       u8 actions = 0;
> > +       struct file *file;
> > +       char event_name[NAME_MAX + 9 + 1];
> > +       u8 digest[IMA_MAX_DIGEST_SIZE] = { 0 };
> > +       enum hash_algo algo;
> > +       int rc, pathlen = strlen(path);
> > +
> > +       /* Remove \n. */
> > +       datap = path;
> > +       strsep(&datap, "\n");
> > +
> > +       file = filp_open(path, O_RDONLY, 0);
> > +       if (IS_ERR(file)) {
> > +               pr_err("unable to open file: %s (%ld)", path, PTR_ERR(file));
> > +               return PTR_ERR(file);
> > +       }
> > +
> > +       rc = kernel_read_file(file, 0, &data, INT_MAX, NULL,
> > +                             READING_DIGEST_LIST);
> > +       if (rc < 0) {
> > +               pr_err("unable to read file: %s (%d)", path, rc);
> > +               goto out;
> > +       }
> > +
> > +       size = rc;
> > +
> > +       snprintf(event_name, sizeof(event_name), "%s_file_%s",
> > +                op == DIGEST_LIST_ADD ? "add" : "del",
> > +                file_dentry(file)->d_name.name);
> > +
> > +       rc = ima_measure_critical_data("diglim", event_name, data, size, false,
> > +                                      digest, sizeof(digest));
> > +       if (rc < 0 && rc != -EEXIST)
> > +               goto out_vfree;
> 
> The digest lists could easily be measured while reading the digest list
> file above in kernel_read_file().  What makes it "critical-data"?  In
> the SELinux case, the in memory SELinux policy is being measured and
> re-measured to make sure it hasn't been modified.  Is the digest list
> file data being measured more than once?

Hi Mimi

yes, the digest lists can be measured with kernel_read_file().
I didn't send the change yet, but I added a DIGEST_LIST_CHECK
hook mapped to READING_DIGEST_LIST, so that digest lists
can be easily measured or appraised.

The point was that the digest of the digest list must be always
calculated, as it is added to the hash table. Instead of duplicating
the code, I preferred to use ima_measure_critical_data().

The advantage is also that, if the use case is to just measure
digest lists, ima_measure_critical_data() could do both at the
same time.

Digest lists can be seen as "critical data" in the sense that
they can affect the security decision on whether to grant
access to a file or not, assuming that an appropriate rule is
added in the IMA policy.

> I understand that with your changes to ima_measure_critical_data(),
> which are now in next-integrity-testing branch, allow IMA to calculate
> the file data hash.

Yes, correct. But actually there is another useful use case.
If digest lists are not in the format supported by the kernel,
the user space parser has to convert them before uploading
them to the kernel.

ima_measure_critical_data() would in this case measure
the converted digest list (it is written directly, without
sending the file path). It is easier to attest the result,
instead of determining whether the user space parser
produced the expected result (by checking the files it
read).

Thanks

Roberto

HUAWEI TECHNOLOGIES Duesseldorf GmbH, HRB 56063
Managing Director: Li Peng, Li Jian, Shi Yanli

> thanks,
> 
> Mimi
> 
> > +
> > +       algo = ima_get_current_hash_algo();
> > +
> 

