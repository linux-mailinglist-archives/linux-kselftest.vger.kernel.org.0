Return-Path: <linux-kselftest+bounces-11292-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F0738FE847
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Jun 2024 15:59:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 226C41C24508
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Jun 2024 13:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ED33196C6F;
	Thu,  6 Jun 2024 13:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="roeL9wHu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97541196456;
	Thu,  6 Jun 2024 13:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717682357; cv=none; b=U7ND0sXSczdGmDEpbYqeUzMog4mp5u/ZawUPuGfzAX2QuHYEhUAfrZi6395wyRm51tGb25cr6SLr74U0aGC/xH79drrdi4CF4v7lc9QRgpH4ACIhJ9V6zJRbE1dAatkjlpzeJ858xaGk5bs9+JuJ7mKMA/xPT1AJCBkPhVbDD4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717682357; c=relaxed/simple;
	bh=DmOMiIjbrQUbLc+fS9w2SijXg8UZYWX9YmlObtBW1Bs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PgAB08Oc8Qh49FH4+3PlQ+4bn84IjKsGJzPHsHOlKNAWilx9oke7QRDwHG2aKC5cm9oKVPDNTs4m+xSRG4Y/O6sLY9NrZjI7flXOmKJ2pKdM60tiWdm//6kIkKYSZhGBGYfxDGNUgd2HQMjz0A9lLkCkfqMr+iXs8bkhgoowtjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=roeL9wHu; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 456DjchQ004065;
	Thu, 6 Jun 2024 13:58:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc :
 content-transfer-encoding : content-type : date : from : in-reply-to :
 message-id : mime-version : references : subject : to; s=pp1;
 bh=0XrutT6mLZuu53qQauJy0ICKhvEuE23LhIYHOVtselU=;
 b=roeL9wHuNHOVifN0/IKBQ6ANvmeqlnIgzqy82t7knSTk19pyE1YzRigmohXNMPRgriKS
 FUS5FyVKkaVRwY6AKhzBGr5guyvp9QSYHuIcESTmVqKbUz/qny6dvHntFSvhycbgsmee
 1YUCwHcuFnYk7J2uW16gOL9eQdhz2Y9YuhEgQoVqZC807kW6KuAOrKIiS2FDYQFotAYx
 6XP9nBFrBY5r+o8rULvyA+sUKmIip0Xy2Cknm8uPtu/HLQ9sUm7CaP6sn+2337OknopA
 ZGOg76HsEQYP3CHaOBVv4wevAOUfSH53XdnI3qYZZUg8+b2WTMFfrHvCbE5FPuGT4vWs Lw== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yke5xr22r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Jun 2024 13:58:41 +0000
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 456DwfPg026289;
	Thu, 6 Jun 2024 13:58:41 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yke5xr22m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Jun 2024 13:58:41 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 456Ae5Oe026509;
	Thu, 6 Jun 2024 13:58:40 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3yggp3acqy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Jun 2024 13:58:40 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 456Dwcpt9044526
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 6 Jun 2024 13:58:40 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 92CB758058;
	Thu,  6 Jun 2024 13:58:36 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 79A6558076;
	Thu,  6 Jun 2024 13:58:32 +0000 (GMT)
Received: from [9.109.245.191] (unknown [9.109.245.191])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  6 Jun 2024 13:58:32 +0000 (GMT)
Message-ID: <d0938d2d-dcb9-43c4-b5a3-2fad9de161b8@linux.ibm.com>
Date: Thu, 6 Jun 2024 19:28:30 +0530
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftest: mm: Test if hugepage does not get leaked during
 __bio_release_pages()
To: Pankaj Raghav <p.raghav@samsung.com>
Cc: akpm@linux-foundation.org, david@redhat.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        ritesh.list@gmail.com, rppt@kernel.org, shuah@kernel.org,
        songmuchun@bytedance.com, tonyb@cybernetics.com, willy@infradead.org
References: <20240604132801.23377-1-donettom@linux.ibm.com>
 <20240606131436.592793-1-p.raghav@samsung.com>
Content-Language: en-US
From: Donet Tom <donettom@linux.ibm.com>
In-Reply-To: <20240606131436.592793-1-p.raghav@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Yb7zQ8oy9ZSTaBxNQ3IIcYO3I3G1AC5K
X-Proofpoint-ORIG-GUID: Jt3fCppTgPHM1ILa5KzCxDNzf_Wwh0MN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-06_01,2024-06-06_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=799
 impostorscore=0 phishscore=0 mlxscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 clxscore=1011 bulkscore=0 spamscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2406060101


On 6/6/24 18:44, Pankaj Raghav wrote:
>> +void run_dio_using_hugetlb(unsigned int start_off, unsigned int end_off)
>> +{
>> +	int fd;
>> +	char *buffer =  NULL;
>> +	char *orig_buffer = NULL;
>> +	size_t h_pagesize = 0;
>> +	size_t writesize;
>> +	int free_hpage_b = 0;
>> +	int free_hpage_a = 0;
>> +
>> +	writesize = end_off - start_off;
>> +
>> +	/* Get the default huge page size */
>> +	h_pagesize = default_huge_page_size();
>> +	if (!h_pagesize)
>> +		ksft_exit_fail_msg("Unable to determine huge page size\n");
>> +
>> +	/* Open the file to DIO */
>> +	fd = open("/tmp", O_TMPFILE | O_RDWR | O_DIRECT);
> I encountered a build error as follows in NixOS:
>
> In file included from /nix/store/fwh4fxd747m0py3ib3s5abamia9nrf90-glibc-2.39-52-dev/include/fcntl.h:342,
>                   from hugetlb_dio.c:15:
> In function ‘open’,
>      inlined from ‘run_dio_using_hugetlb’ at hugetlb_dio.c:41:7:
> /nix/store/fwh4fxd747m0py3ib3s5abamia9nrf90-glibc-2.39-52-dev/include/bits/fcntl2.h:50:11: error: call to ‘__open_missing_mode’ declared with attribute error: open with O_CREAT or O_TMPFILE in second argument needs 3 arguments
>     50 |           __open_missing_mode ();
>
>
> I saw a commit that fixed similar issues with open syscall before:
> 8b65ef5ad486 ("selftests/mm: Fix build with _FORTIFY_SOURCE")
>
> So something like this should fix the issue?
>
> -       fd = open("/tmp", O_TMPFILE | O_RDWR | O_DIRECT);
> +       fd = open("/tmp", O_TMPFILE | O_RDWR | O_DIRECT, 0664);

Thank you Pankaj.

I am able to reproduce this error with "-D_FORTIFY_SOURCE=2 -O2".  I will post v3 with this fix.

-donet


>
>> +	if (fd < 0)
>> +		ksft_exit_fail_msg("Error opening file");
>> +

