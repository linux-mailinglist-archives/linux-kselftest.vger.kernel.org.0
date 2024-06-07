Return-Path: <linux-kselftest+bounces-11422-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 510B7900A99
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jun 2024 18:40:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD204283FFA
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jun 2024 16:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE82C6D1B9;
	Fri,  7 Jun 2024 16:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Zh6E1cN2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E44314005;
	Fri,  7 Jun 2024 16:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717778418; cv=none; b=Yt75EXuM9b7m8cpke0eFqDrgd8WhLsLMUl5fcrfR9IeUPA/ruwIdgUKavvdE2o70JFaPj0t5CwfZUemkp7jnLUdb1SzDPi9NqSLf1WRwi+IUpGPx1SPBQSrAFBxdtNijQYznau239alGOeOq9fROEH5T4GAIgfRWE2yyNFi2dJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717778418; c=relaxed/simple;
	bh=DOVZjtAvC8y78Pfw/JQa1q6RqfvKyXIDSmVM/ckfzLE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hIuYWGkjZPc/109r6eCOFcq6krwH/KkE9MvmEOMI08OMo7OPax8GFYmsH0DKHh8pJNfS6Nh7ErwVJlw4iOyJpl1SIv07B1WydP0ipk3P9jtDAoe67PIdshddGUXzQPia6eOwETfWnppImY4ytzHWkdgSq8nrmQ4/JiWZA8GOSZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Zh6E1cN2; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 457GGsNF025819;
	Fri, 7 Jun 2024 16:39:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc :
 content-transfer-encoding : content-type : date : from : in-reply-to :
 message-id : mime-version : references : subject : to; s=pp1;
 bh=2uZzyQOne4vvcQd+VB26qiwAoV22xvHCRpDn+SEvL3s=;
 b=Zh6E1cN2VTAZ+3ICCQ8IsPZ0je71uRabhIbzQyoMTxLnAYtIGS9QK5b2YvQPNw7sbCcD
 1eLCTcfudsxfP0CRoEaV9hwD/Q0QmgeA7yrFpXWWHIxCPN3Ksie+gRPr0meZhs/oeR9L
 k0FJMzlAZGOnhgG+a9XRA8G55KI8gW+D6crlMwf9pG2+E2TcT+2pZ78S8rAHOwsAP7mY
 YGgNl4XaJVIEGjevPgSv3DZLcOg904H2CT1aSZGF9FFijAwpCt4Xge94De6ulStyNtW/
 qpdSvAOV8HlHmpFjYV1S76gc9nn0r7EJuLLDSM9qVF9rIduwjawj04zzHvu+RteX1NLd rA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ym5kbg2af-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Jun 2024 16:39:53 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 457GdrJW029756;
	Fri, 7 Jun 2024 16:39:53 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ym5kbg2ac-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Jun 2024 16:39:53 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 457FFeLv008479;
	Fri, 7 Jun 2024 16:39:51 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3ygec19yqn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Jun 2024 16:39:51 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 457GdnoB10158632
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 7 Jun 2024 16:39:51 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 297E65803F;
	Fri,  7 Jun 2024 16:39:49 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6361358060;
	Fri,  7 Jun 2024 16:39:43 +0000 (GMT)
Received: from [9.171.64.207] (unknown [9.171.64.207])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  7 Jun 2024 16:39:42 +0000 (GMT)
Message-ID: <a0a04983-2fd8-46f2-b41c-eaeac3bc6f93@linux.ibm.com>
Date: Fri, 7 Jun 2024 22:09:41 +0530
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] selftest: mm: Test if hugepage does not get leaked
 during __bio_release_pages()
To: Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, Matthew Wilcox <willy@infradead.org>,
        Tony Battersby <tonyb@cybernetics.com>
Cc: linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ritesh Harjani <ritesh.list@gmail.com>,
        Mike Rapoport <rppt@kernel.org>,
        Muchun Song <songmuchun@bytedance.com>,
        David Hildenbrand <david@redhat.com>, p.raghav@samsung.com
References: <20240607055046.138650-1-donettom@linux.ibm.com>
 <5ce292b6-179c-48e0-9079-ea07defbe178@collabora.com>
 <9e54991c-3f9b-446c-8825-c0754eca1f90@linux.ibm.com>
 <207129fd-4220-4410-b3d9-bfad8d9831ff@collabora.com>
Content-Language: en-US
From: Donet Tom <donettom@linux.ibm.com>
In-Reply-To: <207129fd-4220-4410-b3d9-bfad8d9831ff@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 10gSxo0kX0_g19BMtKMLahkswfJBS3Sm
X-Proofpoint-GUID: Qd91FC2d_s6Pft1kivFw6DsS0EXlgcct
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-07_10,2024-06-06_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 mlxlogscore=999 spamscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0
 mlxscore=0 impostorscore=0 priorityscore=1501 clxscore=1015 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2406070123


On 6/7/24 22:02, Muhammad Usama Anjum wrote:
> On 6/7/24 9:30 PM, Donet Tom wrote:
> ...
>>>>    tools/testing/selftests/mm/Makefile      |   1 +
>>>>    tools/testing/selftests/mm/hugetlb_dio.c | 118 +++++++++++++++++++++++
>>> Missed my feedback on adding the test to vm_test.sh
>> I was not able to find vm_test.sh file to add this test in selftests/mm.
>> could you please help me to get the correct vm_test.sh to add this?
> Here is the file path: tools/testing/selftests/mm/run_vmtests.sh
Thanks I will add this.
>

