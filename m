Return-Path: <linux-kselftest+bounces-2276-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A612B81A792
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Dec 2023 21:20:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64BDA1F234BB
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Dec 2023 20:20:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46D064185C;
	Wed, 20 Dec 2023 20:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="kXUecUJV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 532314879E;
	Wed, 20 Dec 2023 20:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BKKCuIK014269;
	Wed, 20 Dec 2023 20:19:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pp1; bh=qU+MmoOX8bO6nzDTOb/mKbnzAX/Sq7DnJWv7dLgpGaY=;
 b=kXUecUJVgYEUNaW1d8vLNcQO2Pna20YqDykgHn6Z9eSQAhpe/JmlQy0PUwiLoUMl8Fle
 R3s8jQOif597n65+8VdZ19udFUNaVK1BjsAcUC9pEq3z9pV5SOtltLKdFTR4ObdnsnTG
 13gQ5lq/syI2tmZJNv9HUJRpq4PiWtZ9N3T8QLoprq0OsY3AMAs3aM1GW45pzVdfpKm/
 Wyl/Jrefc2fODSCLC6pDcKlWQkf1kqLS3n3uuZ9P9iyo3AcFsES2qzGZdkK//HhErhpA
 NuwoL+WAvqreP7f0ct8uuhC2bKOHgUPg4LrIYlKGNtBF36utkKRYa1E3BhwMt9VFhneF UQ== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3v42q70n8e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Dec 2023 20:19:55 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3BKK9kpe000803;
	Wed, 20 Dec 2023 20:19:55 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3v42q70n81-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Dec 2023 20:19:55 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3BKJiRxe013882;
	Wed, 20 Dec 2023 20:19:54 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3v1qqkgm6m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Dec 2023 20:19:54 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3BKKJqOO17695398
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 Dec 2023 20:19:52 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8312120043;
	Wed, 20 Dec 2023 20:19:52 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EF81D20040;
	Wed, 20 Dec 2023 20:19:51 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.171.57.36])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 20 Dec 2023 20:19:51 +0000 (GMT)
Date: Wed, 20 Dec 2023 21:19:50 +0100
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Joe Lawrence <joe.lawrence@redhat.com>
Cc: live-patching@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-s390@vger.kernel.org, Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH] selftests/livepatch: fix and refactor new dmesg message
 code
Message-ID: <ZYNMZnRAgAXcvbqq@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
References: <20231220151151.267985-1-joe.lawrence@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231220151151.267985-1-joe.lawrence@redhat.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: _D7p9tLr9mXAASAv28qoXDGD7WPj5Jgq
X-Proofpoint-ORIG-GUID: TybPbBRBiIUrE3Zde0ssiufcO2-qzrid
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-20_13,2023-12-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0
 malwarescore=0 clxscore=1015 adultscore=0 mlxscore=0 priorityscore=1501
 spamscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312200143

On Wed, Dec 20, 2023 at 10:11:51AM -0500, Joe Lawrence wrote:
> The livepatching kselftests rely on comparing expected vs. observed
> dmesg output.  After each test, new dmesg entries are determined by the
> 'comm' utility comparing a saved, pre-test copy of dmesg to post-test
> dmesg output.
> 
> Alexander reports that the 'comm --nocheck-order -13' invocation used by
> the tests can be confused when dmesg entry timestamps vary in magnitude
> (ie, "[   98.820331]" vs. "[  100.031067]"), in which case, additional
> messages are reported as new.  The unexpected entries then spoil the
> test results.
> 
> Instead of relying on 'comm' or 'diff' to determine new testing dmesg
> entries, refactor the code:
> 
>   - pre-test  : log a unique canary dmesg entry
>   - test      : run tests, log messages
>   - post-test : filter dmesg starting from pre-test message
> 
> Reported-by: Alexander Gordeev <agordeev@linux.ibm.com>
> Closes: https://lore.kernel.org/live-patching/ZYAimyPYhxVA9wKg@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com/
> Signed-off-by: Joe Lawrence <joe.lawrence@redhat.com>
> ---
>  .../testing/selftests/livepatch/functions.sh  | 37 +++++++++----------
>  1 file changed, 17 insertions(+), 20 deletions(-)

Acked-by: Alexander Gordeev <agordeev@linux.ibm.com>

