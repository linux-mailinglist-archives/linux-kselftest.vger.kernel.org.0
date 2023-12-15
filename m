Return-Path: <linux-kselftest+bounces-2084-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B376814DC3
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Dec 2023 18:02:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D44E0285E97
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Dec 2023 17:02:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F09193EA78;
	Fri, 15 Dec 2023 17:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="PQkTfPy1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E9C93FB28;
	Fri, 15 Dec 2023 17:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BFGwALZ020777;
	Fri, 15 Dec 2023 17:02:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=B2YPCL9awtaXdHC9oWXUXcPCAxjjCJr0Vn0rYyQXOJo=;
 b=PQkTfPy19H+mSenEhnpAiTSvzh99ikxC/N8xceArJNxfudZcsbS0iOFt+hC3Kj8ja6T8
 UPTff1wKw+WBjX3WrJhILb3ZQ14r22XUASmkpKxeUEQsYdVMco2e6feitgRiI+kTQIZZ
 B8djZ5swFOcvuTSZFpj3MMJQDkE1ClPmW/fmCAhkm7pO/x/xjyys/Zh0zHmMH+HLc+CX
 /SCEsUAPPyX3MBoZYp0tUJOxo7e2lpW+SyN+vnlQ1oow7pFzKfzV7As2MYeNy76kpKjG
 7jJFh/woJavBz8s9wXz23TkFkX4pRSiLGsIIbFnsnyoDE7l6JbVMDcLZuX44bwbZlFAY gw== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3v0tft8qpg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Dec 2023 17:02:13 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3BFGjUjK006288;
	Fri, 15 Dec 2023 17:02:12 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3v0tft8qnu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Dec 2023 17:02:12 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3BFFXtGX013937;
	Fri, 15 Dec 2023 17:02:11 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3uw592rwft-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Dec 2023 17:02:11 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3BFH28GG27853434
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Dec 2023 17:02:08 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8CD1B20043;
	Fri, 15 Dec 2023 17:02:08 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5FF8A20040;
	Fri, 15 Dec 2023 17:02:08 +0000 (GMT)
Received: from p-imbrenda (unknown [9.152.224.66])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 15 Dec 2023 17:02:08 +0000 (GMT)
Date: Fri, 15 Dec 2023 18:02:06 +0100
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Janosch Frank <frankja@linux.ibm.com>,
        Christian Borntraeger
 <borntraeger@linux.ibm.com>,
        kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: s390: selftest: memop: Fix undefined behavior
Message-ID: <20231215180206.740df738@p-imbrenda>
In-Reply-To: <20231215161125.943551-1-nsg@linux.ibm.com>
References: <20231215161125.943551-1-nsg@linux.ibm.com>
Organization: IBM
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: p_xIXzpWKEXFMQuEJFyjrgTdOUj5Kojn
X-Proofpoint-GUID: sAFCq5iOnK_QJcqwHmouXldvP6Q9_rtw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-15_10,2023-12-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 adultscore=0 mlxscore=0 mlxlogscore=999 spamscore=0
 malwarescore=0 clxscore=1011 impostorscore=0 phishscore=0 bulkscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312150118

On Fri, 15 Dec 2023 17:11:25 +0100
Nina Schoetterl-Glausch <nsg@linux.ibm.com> wrote:

> If an integer's type has x bits, shifting the integer left by x or more
> is undefined behavior.
> This can happen in the rotate function when attempting to do a rotation
> of the whole value by 0.

is 0 the only problematic value? because in that case... 

> 
> Fixes: 0dd714bfd200 ("KVM: s390: selftest: memop: Add cmpxchg tests")
> Signed-off-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
> ---
>  tools/testing/selftests/kvm/s390x/memop.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/s390x/memop.c b/tools/testing/selftests/kvm/s390x/memop.c
> index bb3ca9a5d731..2eba9575828e 100644
> --- a/tools/testing/selftests/kvm/s390x/memop.c
> +++ b/tools/testing/selftests/kvm/s390x/memop.c
> @@ -485,11 +485,13 @@ static bool popcount_eq(__uint128_t a, __uint128_t b)
>  
>  static __uint128_t rotate(int size, __uint128_t val, int amount)
>  {
> -	unsigned int bits = size * 8;
> +	unsigned int left, right, bits = size * 8;
>  

...why not just:

if (!amount)
	return val;

?

> -	amount = (amount + bits) % bits;
> +	right = (amount + bits) % bits;
> +	/* % 128 prevents left shift UB if size == 16 && right == 0 */
> +	left = (bits - right) % 128;
>  	val = cut_to_size(size, val);
> -	return (val << (bits - amount)) | (val >> amount);
> +	return (val << left) | (val >> right);
>  }
>  
>  const unsigned int max_block = 16;
> 
> base-commit: 305230142ae0637213bf6e04f6d9f10bbcb74af8


