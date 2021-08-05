Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A8E43E1832
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Aug 2021 17:38:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242167AbhHEPit (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 5 Aug 2021 11:38:49 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:3572 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242193AbhHEPij (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 5 Aug 2021 11:38:39 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 175FYZX8157844;
        Thu, 5 Aug 2021 11:38:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=gbPRBdQ5D/dvU7ZGp0Sjf2GZZjty5tvCwrApzPJwGgU=;
 b=r9RYjSvOQ1O/zFmGNzcEqdL1G9KSO/UcvTg43leoThVevYwohtcc8A5RgR65cqFNJqjE
 Ol/UuGMQsnngf96EMQSSkPbqYrne8kXrc7DfEUVJr23/xGNlTnca3aCZkTf1uFch7qJ/
 OyiO00ql6h34p0sUxyLftMCGgVYFsoQsK6Aa6PPgjt3dUF/C2MBlCV7APzxBd+QgR6R5
 GEMs8kxR0Nmg5oH/CV0FoKNrw3gbl7QsQck+CcE+CC70Bhu50JpiMbwDdWxR4txW2TVl
 CPm7PoRjXlV+5UJzkYrMbNC5taSa4BmtslXNMTc8KbdE+tjr6Ibewnqm2Q5yUA46sTnZ 6A== 
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3a89fmrpmv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 05 Aug 2021 11:38:16 -0400
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 175FVgHi005638;
        Thu, 5 Aug 2021 15:38:14 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma05fra.de.ibm.com with ESMTP id 3a4x58j994-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 05 Aug 2021 15:38:13 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 175FcBQV56951276
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 5 Aug 2021 15:38:11 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3B003AE04D;
        Thu,  5 Aug 2021 15:38:11 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6CE86AE056;
        Thu,  5 Aug 2021 15:38:09 +0000 (GMT)
Received: from sig-9-65-205-127.ibm.com (unknown [9.65.205.127])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  5 Aug 2021 15:38:09 +0000 (GMT)
Message-ID: <e886224b50195a2c1324c91b39514395e9780b06.camel@linux.ibm.com>
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
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Eric Snowberg <eric.snowberg@oracle.com>
Date:   Thu, 05 Aug 2021 11:38:08 -0400
In-Reply-To: <f7adeb81bab24b689c3e1aa61d83c6f5@huawei.com>
References: <20210726163700.2092768-1-roberto.sassu@huawei.com>
         <20210726163700.2092768-7-roberto.sassu@huawei.com>
         <c9dffd9d29df095660beaa631ff252c4b33629a0.camel@linux.ibm.com>
         <ef7c85dcb096479e95c8c60ccda4d700@huawei.com>
         <1ef95096bee13578b3f906dd9f708c6af9d6ff18.camel@linux.ibm.com>
         <555bf01bee4b4ea7a9bee658366d535a@huawei.com>
         <3e6a54d4be87a3eafc45c85d013250d17aa0835e.camel@linux.ibm.com>
          <f7adeb81bab24b689c3e1aa61d83c6f5@huawei.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-16.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: V-f5mjXJ8d7cNiHxSBkH_kofO_HzxkAX
X-Proofpoint-GUID: V-f5mjXJ8d7cNiHxSBkH_kofO_HzxkAX
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-05_05:2021-08-05,2021-08-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 priorityscore=1501 bulkscore=0 phishscore=0 adultscore=0 malwarescore=0
 impostorscore=0 mlxscore=0 mlxlogscore=999 lowpriorityscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108050094
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

[Cc'ing Eric Snowberg]

Hi Roberto,

On Mon, 2021-08-02 at 16:54 +0000, Roberto Sassu wrote:

> > > Properly identifying (all) user space parser(s) would be critical.  It
> > > would be simpler and  safer to require the converted data be signed.
> 
> When a process directly uploads a buffer to the kernel, the actions are
> added to a digest list depending on the result of ima_measure_critical_data()
> and from the actions attached to the process credentials and set by the
> new LSM.
> 
> If a process fails the identification, the actions in the process credentials
> remain zero and the digest lists the process uploads will be ignored by IMA.
> 
> The actions in the process credentials are set with the actions performed
> on the executable by IMA, only if the digest of the executable is found in
> a digest list and the digest list type is COMPACT_PARSER. The parser is
> statically linked.
> 
> The digest list for the parser can be generated at the end of the
> building process and signed similarly to kernel modules (for SUSE,
> with pesign-obs-integration). This is the only exception to handle,
> other packages are not affected.

Ok, so to boot strap the set of permitted digest list parsers, the
digest list signature is an appended signature, generated by the build
process.  The key needed for verifying the signature would already be
loaded on the builtin keyring.

> 
> After the parser has been identified, each file operation is monitored.

Does the new LSM need to monitor all file opens?

> The LSM has to explicitly perform a second open to ensure that
> the file is measured/appraised before the integrity_iint_cache structure
> is retrieved (because IMA is called after all LSMs).
> 
> If an action is missing from the integrity_iint_cache structure, it
> will be cleared by the LSM in the actions attached to the process
> credentials, and will not be added to the digest list being uploaded.
> 
> > I agree, it would be much easier. However, it would require changes
> > to the building infrastructure of Linux distribution vendors, which
> > might limit the applicability of DIGLIM.
> > 

I understand, but instead of the distros signing the compact digest
lists, with Eric's  "Enroll kernel keys thru MOK" patch set, the
customer/end user could have more control over which file digests are
permitted on a per system basis.

> > With the user space parser taking care of the conversion, distributions
> > can do appraisal of executables and shared libraries with an update of:
> > - the kernel: to add DIGLIM
> > - dracut: to add required digest lists in the initial ram disk
> > - rpm (plugin): to extract the RPM header and its signature and write
> >   them to a file that is uploaded to the kernel by the user space parser
> > 
> > I'm planning to append the signature at the end of the RPM header
> > (and use appraise_type=modsig) to avoid the dependency on the
> > 'initramfs: add support for xattrs in the initial ram disk' patch set
> > (which I might try to resume in the future).

Based on your explanation above, I surmised as much.

thanks,

Mimi

