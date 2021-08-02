Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D4EB3DDB48
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Aug 2021 16:42:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234179AbhHBOmr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 2 Aug 2021 10:42:47 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:47612 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233925AbhHBOmq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 2 Aug 2021 10:42:46 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 172EY0ek175070;
        Mon, 2 Aug 2021 10:42:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=zGdVNd5qiQPcDVl6mMtFFxl5zES7mJ2fWwcpoYDbjYI=;
 b=Xmgi6/5nP2wKA75iFEg5HepcKfmEaXnHuXYSX/6O/kMoQM6iSd0eBGvxjNrnpdY5GiaI
 ShoEbWrNKRjDB/IBtrBroctogujun0iUGuYiVSPdix/Ethd+17dUDQOpvCV34HS5+23w
 TO9h/d3htxCJ60TiZenh56O84L8xV1td++C+FarQwM2Wz+YLUOfI5J39CHSIPtfLcywc
 UwImDknN0nlUhtYQoJlbnQ5WUlo5k8ljxphaQk9kAWACF0D8Dy40/9yk12PdIXE0Xl+A
 LOBTY6+msJZJaDG1CQKt25lbd1kAxQTNJYe0+UkuY2GchpzG2/JniB0S+R4FYYUNFtCa 8Q== 
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3a5u8bpr7j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 02 Aug 2021 10:42:31 -0400
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 172EItAq007062;
        Mon, 2 Aug 2021 14:42:29 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma01fra.de.ibm.com with ESMTP id 3a4x58mf0k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 02 Aug 2021 14:42:29 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 172EgRoK27066814
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 2 Aug 2021 14:42:27 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0F18CA4060;
        Mon,  2 Aug 2021 14:42:27 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1ED9CA405B;
        Mon,  2 Aug 2021 14:42:25 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.118.203])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  2 Aug 2021 14:42:24 +0000 (GMT)
Message-ID: <3e6a54d4be87a3eafc45c85d013250d17aa0835e.camel@linux.ibm.com>
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
Date:   Mon, 02 Aug 2021 10:42:24 -0400
In-Reply-To: <555bf01bee4b4ea7a9bee658366d535a@huawei.com>
References: <20210726163700.2092768-1-roberto.sassu@huawei.com>
         <20210726163700.2092768-7-roberto.sassu@huawei.com>
         <c9dffd9d29df095660beaa631ff252c4b33629a0.camel@linux.ibm.com>
         <ef7c85dcb096479e95c8c60ccda4d700@huawei.com>
         <1ef95096bee13578b3f906dd9f708c6af9d6ff18.camel@linux.ibm.com>
         <555bf01bee4b4ea7a9bee658366d535a@huawei.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-16.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: -2W2DK9FB2gKjhGHJSLsQWGmbfpdoMVt
X-Proofpoint-GUID: -2W2DK9FB2gKjhGHJSLsQWGmbfpdoMVt
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-02_05:2021-08-02,2021-08-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 impostorscore=0 spamscore=0 mlxscore=0 phishscore=0 suspectscore=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 clxscore=1015
 malwarescore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108020094
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Roberto,

On Fri, 2021-07-30 at 13:16 +0000, Roberto Sassu wrote:

> The reason of storing the actions performed by IMA on the
> digest lists helps to determine for which purpose they can be
> used. If digest lists are used only for measurement purpose,
> it should be sufficient that digest lists are measured. The
> same applies for appraisal.

Is that assumption correct?   How would you know if the digests lists
are only being used one way and not the other.  For example, assuming
that the digest lists are stored on protected media, the digest lists
could be measured, but would not necessarily be appraised.

> > Adding the kernel_read_file() "READING_DIGEST_LIST" support in IMA does
> > not seem to be optional.  IMA would then be calculating the digest list
> > file hash twice, once in kernel_read_file() and then, again, in
> > ima_measure_critical_data().
> 
> I didn't include also this part: I retrieve the integrity_iint_cache for
> the opened file descriptor and I get the flags from there. If the
> IMA_MEASURED flag is set, it is not necessary to call also
> ima_measure_critical_data().

Right, assuming the file is in policy, the digest would already be
stored in the iint cache.

> > > > I understand that with your changes to ima_measure_critical_data(),
> > > > which are now in next-integrity-testing branch, allow IMA to calculate
> > > > the file data hash.
> > >
> > > Yes, correct. But actually there is another useful use case.
> > > If digest lists are not in the format supported by the kernel,
> > > the user space parser has to convert them before uploading
> > > them to the kernel.
> > >
> > > ima_measure_critical_data() would in this case measure
> > > the converted digest list (it is written directly, without
> > > sending the file path). It is easier to attest the result,
> > > instead of determining whether the user space parser
> > > produced the expected result (by checking the files it
> > > read).
> > 
> > The application to properly convert the digest list file data into the
> > appropriate format would need to be trusted.  I'm concerned that not
> > requiring the converted data to be signed and the signature verified is
> > introducing a new integrity gap.  Perhaps between an LSM policy,
> > limiting which files may be read by the application, and an IMA policy,
> > requiring all files read by this application to be measured and the
> > signature verified, this integrity gap could be averted.
> 
> It is the weakest point in the chain, yes. Relying on existing LSMs
> didn't seem to me a good idea, as:
> - a new policy must be installed
> - we must be sure that the policy is really enforced
> - we need to support different LSMs (SELinux for Fedora,
>   Apparmor for SUSE)
> - there might be no LSM we can rely on
> 
> For these reasons, I developed a new LSM. Its purpose is to
> identify the user space parser and for each file it opens, ensure
> that the file has been measured or appraised by IMA. If one of
> these actions are missing, it will not be set in the digest list the
> user space parser uploads to the kernel (which means that IMA
> will ignore the digest list for that specific action).

Properly identifying (all) user space parser(s) would be critical.  It
would be simpler and  safer to require the converted data be signed.

thanks,

Mimi

