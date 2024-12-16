Return-Path: <linux-kselftest+bounces-23411-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CBF29F303E
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Dec 2024 13:13:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B238616789D
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Dec 2024 12:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 957B7205500;
	Mon, 16 Dec 2024 12:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="h+oE9KTC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD55204C14
	for <linux-kselftest@vger.kernel.org>; Mon, 16 Dec 2024 12:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734351063; cv=none; b=iBlYu799zvMob0zUl83H6bUr7x5jiLRlL9cQoumywTBlToHA/QNhYm1H8Ss12dI9eX4pF9J/kIIYqX7xZDCcYjIg5mZzBbwFhVqjLFCpgz4btUZJ/hlY1P8fWZl7e2VW9oUD0g0DRoxbvy4w7UpfUoaghLie4i+kykelwh+eF84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734351063; c=relaxed/simple;
	bh=mDCZHQbOCeTqOJK5O8yuuK0trVcDKtWsInIz9OKt9Sg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=on/+uoUNql6YcVdSVqTTZGhNOqUkbpluL5Nk4AzzXjQBoEGTqZIxKQDCHZAzg2Wz8sSXquY5AVdWeB6ZnIblQUwKs8rax5jdRIByg9VNTbfjn5FcuxxmtRuuwuCU6t1msZtUs/gtpW4OErnf6V74yyy88ZeyosLtlRv76Vc4Ywk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=h+oE9KTC; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BG8dsZG007099;
	Mon, 16 Dec 2024 12:10:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ClZtK3
	mMvsr7AVybM8tkBamqH7g5AIBNqnhgAu16474=; b=h+oE9KTC1AU2a0LEbCiQVz
	8aCiCp2I35XSWgJy8cEIT66bq7VkcnFOreeKiytouWp8DTC/gp2FBNKOeP+fQD/3
	6RnnXFkosGGbwEbLVPayWzbICHiqA8ilf1b8/oQtnSfYIfxlEn2UZusXpfxrv6Bj
	KB7JoyvsMt8+k8oGt7rip1BssN2u6n65Ti+a77Q7vCcwrnIJkEoODKIkKfZ7fRvY
	VdvFew0iR21epRO1NvEImoxF5bHNx2YLBzPef8PpvxfK7Eyyd30otrwkTjiqp04z
	nBBoL5xcLVRuZl2v4oVSqLmhQmaZQ6fo1m4wD4zBdST52G3SaJC5twQp0UTuYUOg
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43j0k4bv41-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Dec 2024 12:10:47 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4BGCAlKj019031;
	Mon, 16 Dec 2024 12:10:47 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43j0k4bv40-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Dec 2024 12:10:47 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BGBQ0pD014412;
	Mon, 16 Dec 2024 12:10:46 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 43hq21de4a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Dec 2024 12:10:46 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4BGCAk9h27787854
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Dec 2024 12:10:46 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 18C4F5805D;
	Mon, 16 Dec 2024 12:10:46 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5E55B58052;
	Mon, 16 Dec 2024 12:10:41 +0000 (GMT)
Received: from [9.43.70.111] (unknown [9.43.70.111])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 16 Dec 2024 12:10:40 +0000 (GMT)
Message-ID: <694d99f3-cef2-4eb4-8248-6a01b5ddf4f7@linux.ibm.com>
Date: Mon, 16 Dec 2024 17:40:38 +0530
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] selftest/powerpc/ptrace/core-pkey: Remove duplicate
 macros
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, mpe@ellerman.id.au,
        npiggin@gmail.com, christophe.leroy@csgroup.eu, naveen@kernel.org,
        shuah@kernel.org
Cc: linuxppc-dev@lists.ozlabs.org, linux-kselftest@vger.kernel.org
References: <20241209151418.348085-1-maddy@linux.ibm.com>
 <87pllr52g3.fsf@gmail.com>
Content-Language: en-US
From: Madhavan Srinivasan <maddy@linux.ibm.com>
In-Reply-To: <87pllr52g3.fsf@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Vj_INFJjcZ0oYEQFLcfoJDMpJqOdyJqO
X-Proofpoint-ORIG-GUID: MF0g3TMi7soBnOS_x2ZsX2W0uHbP_c7P
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 malwarescore=0 bulkscore=0 mlxlogscore=950
 clxscore=1015 suspectscore=0 adultscore=0 phishscore=0 mlxscore=0
 spamscore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2411120000 definitions=main-2412160101



On 12/16/24 4:17 PM, Ritesh Harjani (IBM) wrote:
> Madhavan Srinivasan <maddy@linux.ibm.com> writes:
> 
>> core-pkey.c test has couple of macros defined which
>> are part of "pkeys.h" header file. Remove those
>> duplicates and include "pkeys.h"
>>
>> Signed-off-by: Madhavan Srinivasan <maddy@linux.ibm.com>
>> ---
>>  .../selftests/powerpc/ptrace/core-pkey.c      | 19 +------------------
>>  1 file changed, 1 insertion(+), 18 deletions(-)
> 
> .../powerpc/ptrace/Makefile includes flags.mk. In
> .../powerpc/flags.mk we anyways add -I$(selfdir)/powerpc/include in
> CFLAGS - so it will pick up the header files defined in powerpc/include.
> 
> It make sense to clean this up and consolidate the common header definitions
> into pkeys.h header file. The changes looks good to me. Please feel free
> to add - 
> 
> Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

Thanks

> 
> -ritesh


