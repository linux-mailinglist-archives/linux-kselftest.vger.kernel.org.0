Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E43973DB8BF
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Jul 2021 14:39:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238742AbhG3MkA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 30 Jul 2021 08:40:00 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:19286 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238847AbhG3Mj6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 30 Jul 2021 08:39:58 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16UCXpYe013366;
        Fri, 30 Jul 2021 08:39:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=U599//0JyZmLKEmd3MR7tR+iffcSLIaUx0v3MxKtdUc=;
 b=Nx8eU9WdcdXtQ+bLLxaRbOuCWllI0QQH4DK4kWtHUVuBhx7JGD1lLg7ammDnvUs4C/Ww
 +C7B37GomYQ9cOn3gDGSNN/8EAI2qE2YzwmXzn4BRks8KlwVkl7ZhIGWFGNYDCqOy6K0
 fYy2kWe1XDe9u9WDdf1CvoZ7ixvYuL5zfjdxlRZmGP5NPI9mvxqhU+f8TORNS5pcWLCd
 jHcXinM0evOz1kQvuO5XxUwV4JR99qn9D1VRqZZND/CB4fQLDl3SbvdK/cFNLb60Brzw
 9BzFpDb/szCWV2V1Ecoxv4SVUbh9HA/gFgfbQ2A3gGqZpSYlysfaTMmrumTQL/Nb3KCX iA== 
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3a4ha20j2x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 30 Jul 2021 08:39:47 -0400
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 16UCWH8D026250;
        Fri, 30 Jul 2021 12:39:45 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma01fra.de.ibm.com with ESMTP id 3a417phjde-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 30 Jul 2021 12:39:44 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 16UCatni21430726
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 30 Jul 2021 12:36:55 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 72417A4051;
        Fri, 30 Jul 2021 12:39:42 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BA6FFA4040;
        Fri, 30 Jul 2021 12:39:40 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.54.226])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 30 Jul 2021 12:39:40 +0000 (GMT)
Message-ID: <1ef95096bee13578b3f906dd9f708c6af9d6ff18.camel@linux.ibm.com>
Subject: Re: [RFC][PATCH v2 06/12] diglim: Interfaces - digest_list_add,
 digest_list_del
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Roberto Sassu <roberto.sassu@huawei.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "mchehab+huawei@kernel.org" <mchehab+huawei@kernel.org>
Cc:     "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Fri, 30 Jul 2021 08:39:39 -0400
In-Reply-To: <ef7c85dcb096479e95c8c60ccda4d700@huawei.com>
References: <20210726163700.2092768-1-roberto.sassu@huawei.com>
         <20210726163700.2092768-7-roberto.sassu@huawei.com>
         <c9dffd9d29df095660beaa631ff252c4b33629a0.camel@linux.ibm.com>
         <ef7c85dcb096479e95c8c60ccda4d700@huawei.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-16.el8) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: JxRxN94aXl7CUrw6a5Ls7_93MeTyiIp9
X-Proofpoint-ORIG-GUID: JxRxN94aXl7CUrw6a5Ls7_93MeTyiIp9
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-30_05:2021-07-30,2021-07-30 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 bulkscore=0
 mlxlogscore=999 suspectscore=0 spamscore=0 lowpriorityscore=0 mlxscore=0
 priorityscore=1501 clxscore=1015 adultscore=0 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2107300081
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Roberto,

On Fri, 2021-07-30 at 07:16 +0000, Roberto Sassu wrote:
> > From: Mimi Zohar [mailto:zohar@linux.ibm.com]
> > Sent: Thursday, July 29, 2021 11:21 PM
> > 
> > On Mon, 2021-07-26 at 18:36 +0200, Roberto Sassu wrote:
> > > /*
> > > + * digest_list_read: read and parse the digest list from the path
> > > + */
> > > +static ssize_t digest_list_read(char *path, enum ops op)
> > > +{
> > > +       void *data = NULL;
> > > +       char *datap;
> > > +       size_t size;
> > > +       u8 actions = 0;
> > > +       struct file *file;
> > > +       char event_name[NAME_MAX + 9 + 1];
> > > +       u8 digest[IMA_MAX_DIGEST_SIZE] = { 0 };
> > > +       enum hash_algo algo;
> > > +       int rc, pathlen = strlen(path);
> > > +
> > > +       /* Remove \n. */
> > > +       datap = path;
> > > +       strsep(&datap, "\n");
> > > +
> > > +       file = filp_open(path, O_RDONLY, 0);
> > > +       if (IS_ERR(file)) {
> > > +               pr_err("unable to open file: %s (%ld)", path, PTR_ERR(file));
> > > +               return PTR_ERR(file);
> > > +       }
> > > +
> > > +       rc = kernel_read_file(file, 0, &data, INT_MAX, NULL,
> > > +                             READING_DIGEST_LIST);
> > > +       if (rc < 0) {
> > > +               pr_err("unable to read file: %s (%d)", path, rc);
> > > +               goto out;
> > > +       }
> > > +
> > > +       size = rc;
> > > +
> > > +       snprintf(event_name, sizeof(event_name), "%s_file_%s",
> > > +                op == DIGEST_LIST_ADD ? "add" : "del",
> > > +                file_dentry(file)->d_name.name);
> > > +
> > > +       rc = ima_measure_critical_data("diglim", event_name, data, size, false,
> > > +                                      digest, sizeof(digest));
> > > +       if (rc < 0 && rc != -EEXIST)
> > > +               goto out_vfree;
> > 
> > The digest lists could easily be measured while reading the digest list
> > file above in kernel_read_file().  What makes it "critical-data"?  In
> > the SELinux case, the in memory SELinux policy is being measured and
> > re-measured to make sure it hasn't been modified.  Is the digest list
> > file data being measured more than once?
> 
> Hi Mimi
> 
> yes, the digest lists can be measured with kernel_read_file().
> I didn't send the change yet, but I added a DIGEST_LIST_CHECK
> hook mapped to READING_DIGEST_LIST, so that digest lists
> can be easily measured or appraised.
> 
> The point was that the digest of the digest list must be always
> calculated, as it is added to the hash table. Instead of duplicating
> the code, I preferred to use ima_measure_critical_data().
> 
> The advantage is also that, if the use case is to just measure
> digest lists, ima_measure_critical_data() could do both at the
> same time.
> 
> Digest lists can be seen as "critical data" in the sense that
> they can affect the security decision on whether to grant
> access to a file or not, assuming that an appropriate rule is
> added in the IMA policy.

Of course the integrity of files containing the digest lists is
important, but that doesn't make them "critical data".  If the
integrity of these files is important, then the digest lists not only
need to be measured, but they need to be signed and the resulting
signature verified.  Without signature verification, there is no basis
on which to trust the digest lists data.

Adding the kernel_read_file() "READING_DIGEST_LIST" support in IMA does
not seem to be optional.  IMA would then be calculating the digest list
file hash twice, once in kernel_read_file() and then, again, in
ima_measure_critical_data().

> 
> > I understand that with your changes to ima_measure_critical_data(),
> > which are now in next-integrity-testing branch, allow IMA to calculate
> > the file data hash.
> 
> Yes, correct. But actually there is another useful use case.
> If digest lists are not in the format supported by the kernel,
> the user space parser has to convert them before uploading
> them to the kernel.
> 
> ima_measure_critical_data() would in this case measure
> the converted digest list (it is written directly, without
> sending the file path). It is easier to attest the result,
> instead of determining whether the user space parser
> produced the expected result (by checking the files it
> read).

The application to properly convert the digest list file data into the
appropriate format would need to be trusted.  I'm concerned that not
requiring the converted data to be signed and the signature verified is
introducing a new integrity gap.  Perhaps between an LSM policy,
limiting which files may be read by the application, and an IMA policy,
requiring all files read by this application to be measured and the
signature verified, this integrity gap could be averted.

"critical data", in this context, should probably be used for verifying
the in memory file digests and other state information haven't been
compromised.

thanks,

Mimi

