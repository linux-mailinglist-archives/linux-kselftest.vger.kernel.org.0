Return-Path: <linux-kselftest+bounces-27046-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2210A3D293
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Feb 2025 08:47:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B309189AFF9
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Feb 2025 07:46:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 259C11DDC14;
	Thu, 20 Feb 2025 07:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="g2odZFGl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 691F822F11;
	Thu, 20 Feb 2025 07:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740037557; cv=none; b=Z44OQBpuHbYomAlS7Nkz4C1jgShvFTl+6SsXiZpSivElDiZlSCw7fB0OTNLOy5rUd/dodn76mdc2bh1bYTR0c8RaIA/ZUkWthHqLqnFvn51umXNcO1lfg90cb2NqLSgFnMGvoUxGsNP7sh9x47XUfrRUuhldV3MRWASRSgqD/Gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740037557; c=relaxed/simple;
	bh=y5g3F1Le/41CmpzEWqBi9nMV6VrPaIqZ7vVUOTU807o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jo2lo9REGqg3crNBKQYDJiDqJzw8/1sga2EeghFSHSF7bYRWNXcSFftef3xc41QaGAA/EiQBDvJ9hlrxS46InRWiADqtdVRcWB00x04QzjXOoT7SMpL4bGKe6V9HQc7azNsbPnN7/XVXvgvNhPcx3f1SHWb0Je/mvY9giRX5gBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=g2odZFGl; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51K1Act6006165;
	Thu, 20 Feb 2025 07:45:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=THnapr
	/xdmKpYJVnyumG675qIuSfCpRNBda0PrI90mo=; b=g2odZFGlIJAZ2ifLKOfL4A
	YxqfrSNn9NZCRqbrv14O5NPZuj2Mp+lYDIwRk3BJWNppu+jygb+eMidJ9PgleUOQ
	z4LTu144RHzjWZA+1++7ixQdJ+G/Iup2N9HrDFmKfpcuwjbt1ShSMPG8ZzeRBOSh
	yHT/+pFp857OLwd5VQaLh5RaEYIKt6DqlTmYJcmXvedMo4QpXnBHFs9bA16Ro7bN
	5EFCnTxw0hdpwyg3xIQIwlMWKbekfS906/NhGxo6104q6FIGES688YOoC+G2IToH
	oNQdrcJrJOsZecQmXrc7KAMSgChecto1QaPw2+/G+z6G2sFoOwiRTOra3ZmbJs2A
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44wtfa1f55-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Feb 2025 07:45:49 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51K4MTWK029293;
	Thu, 20 Feb 2025 07:45:48 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44w024grna-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Feb 2025 07:45:46 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51K7jija48300310
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Feb 2025 07:45:44 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 68A7E2004E;
	Thu, 20 Feb 2025 07:45:44 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1DD7E20040;
	Thu, 20 Feb 2025 07:45:43 +0000 (GMT)
Received: from [9.39.30.67] (unknown [9.39.30.67])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 20 Feb 2025 07:45:42 +0000 (GMT)
Message-ID: <74dddd26-4a0e-4bb6-958a-229cca3c24d1@linux.ibm.com>
Date: Thu, 20 Feb 2025 13:15:42 +0530
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests: sched: add sched as a default selftest target
To: Sinadin Shan <sinadin.shan@oracle.com>, chris.hyser@oracle.com
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        shuah@kernel.org
References: <20250219064658.449069-1-sinadin.shan@oracle.com>
From: Shrikanth Hegde <sshegde@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20250219064658.449069-1-sinadin.shan@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: NFnzcOZmzNNjnEcUzq55RgR1_srdLVU2
X-Proofpoint-GUID: NFnzcOZmzNNjnEcUzq55RgR1_srdLVU2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-20_03,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 suspectscore=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 mlxlogscore=999
 bulkscore=0 phishscore=0 malwarescore=0 mlxscore=0 adultscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502200052



On 2/19/25 12:16, Sinadin Shan wrote:
> The sched tests are missing a target entry and hence out-of-tree build
> support.
> 
> For instance:
> make -C tools/testing/selftests install INSTALL_LOCATION=/foo/bar
> 
> is expected to build the sched tests and place them at /foo/bar.
> But this is not observed since a TARGET entry is not present for sched.
> 
> This was suggested by Shuah in this conversation
> Link: https://lore.kernel.org/linux-kselftest/60dd0240-8e45-4958-acf2-7eeee917785b@linuxfoundation.org/
> 
> Add support for sched selftests by adding sched as a default TARGET
> 
> Signed-off-by: Sinadin Shan <sinadin.shan@oracle.com>
> ---
>   tools/testing/selftests/Makefile | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
> index 8daac70c2f9d2..e2d0d389ad912 100644
> --- a/tools/testing/selftests/Makefile
> +++ b/tools/testing/selftests/Makefile
> @@ -91,6 +91,7 @@ TARGETS += rlimits
>   TARGETS += rseq
>   TARGETS += rtc
>   TARGETS += rust
> +TARGETS += sched
>   TARGETS += sched_ext
>   TARGETS += seccomp
>   TARGETS += sgx

There is only one test currently in sched: i.e cs_prctl_test.c. to see 
the cookies validation when core scheduling is in effect.

If CONFIG_SCHED_CORE=n, the test fails. So you might end up seeing 
default selftests failing on such systems? or this is only compiling?

Likely the selftests/sched needs to modified for CONFIG_SCHED_CORE=n

When CONFIG_SCHED_CORE=n
./cs_prctl_test

## Create a thread/process/process group hierarchy
Not a core sched system
...
Not a core sched system
(283) FAILED: get_cs_cookie(0) == 0

