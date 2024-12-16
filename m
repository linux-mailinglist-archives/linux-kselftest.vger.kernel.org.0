Return-Path: <linux-kselftest+bounces-23410-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1E609F3034
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Dec 2024 13:13:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C6D37A35F3
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Dec 2024 12:12:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92ECE2066C9;
	Mon, 16 Dec 2024 12:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="hTuOrGKX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D47E62063FC
	for <linux-kselftest@vger.kernel.org>; Mon, 16 Dec 2024 12:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734351021; cv=none; b=B92iZMH2yO2d7e8obDmpG3FvHRhXaHh9Fb1mytaaOEODa/sIDdDmyxbYmD+ZigW7sa5BBhxPHgdnmzY/TtGo6iIrPJnDulxcxeqi+eICsBq1q7iLh1K3xGYwyVHHClGb96OAzpymYxD9mKrsfP9I6IKMec1jwoCElpJ0S4QYaq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734351021; c=relaxed/simple;
	bh=Mv9bQcn1kYATlWFk6BJz8+v05DI+PCwrlooQUq6aKxE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dnSGUGyt/DGvKaIbUnXoz0wWMYF/UDEpIo8fi+SazQpfxFVaDDQ5WA2xOjhuQBcgyH4vPwSviXDnJ61NX2LoOJSy73IIqqARRSZUaSE7k1X/OaQVNZPXPUXRrCWalTD2ss41W/KEya/Im9ZFvCw1aJkMfoncJwDg+87HFtJQen8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=hTuOrGKX; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BG85hw2027071;
	Mon, 16 Dec 2024 12:10:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Wuz4gs
	KVaW4DjMAwLiESzy6Gs2u+27zCq+IljvVahwM=; b=hTuOrGKXqsvYnUAx7PhGZa
	sR++lIF8lx1bIIqTOO8U67dWMALzhitm3U4nxBYpSRcEQz1Ssjo8GtyjH0MrUnbO
	Nxwj/HRYISMaV7XxOa256v1tmCt3AFkrd8tSUc6JR5yflKRqEp0RIll/oOnTiM3w
	9VoCuFj4oDh91OcsK+AMHjtE9V+DI+FiCqZqdaHy5wNepzxzjY6NdXd/vRkM6Wld
	5Y5Wk3oZGh1MmHpUz2ZXgvnEo0t7jOwLTxfBc2z9+QPoA4DwpcaEpo/k1vN9KYE4
	Uxg+lgg0JZ3xj/vmGVoc0O8w1oQhOHspl8T17mjmtXwXsglU1ZhWgXZ1769W+5Tg
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43jgd292nx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Dec 2024 12:10:05 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4BGC8lDZ014414;
	Mon, 16 Dec 2024 12:10:05 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43jgd292nv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Dec 2024 12:10:04 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BGAMUCl011256;
	Mon, 16 Dec 2024 12:10:04 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 43hpjjwjex-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Dec 2024 12:10:04 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4BGCA3HK2163444
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Dec 2024 12:10:03 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4A7FA5805D;
	Mon, 16 Dec 2024 12:10:03 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5412758052;
	Mon, 16 Dec 2024 12:09:58 +0000 (GMT)
Received: from [9.43.70.111] (unknown [9.43.70.111])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 16 Dec 2024 12:09:57 +0000 (GMT)
Message-ID: <a47e9b87-c461-4e8f-8503-944e5324d6a7@linux.ibm.com>
Date: Mon, 16 Dec 2024 17:39:55 +0530
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] selftest/powerpc/ptrace/ptrace-pkey: Remove duplicate
 macros
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, mpe@ellerman.id.au,
        npiggin@gmail.com, christophe.leroy@csgroup.eu, naveen@kernel.org,
        shuah@kernel.org
Cc: linuxppc-dev@lists.ozlabs.org, linux-kselftest@vger.kernel.org
References: <20241209151418.348085-1-maddy@linux.ibm.com>
 <20241209151418.348085-2-maddy@linux.ibm.com> <87msgv524l.fsf@gmail.com>
Content-Language: en-US
From: Madhavan Srinivasan <maddy@linux.ibm.com>
In-Reply-To: <87msgv524l.fsf@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: uxUcUh5mBRklgrIaJNXlElt6Xe7wzHJN
X-Proofpoint-GUID: wp9P2SLpaF_k94JAp7siJABrMF5bUWwR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 suspectscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015
 mlxlogscore=697 priorityscore=1501 malwarescore=0 impostorscore=0
 mlxscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412160101



On 12/16/24 4:24 PM, Ritesh Harjani (IBM) wrote:
> Madhavan Srinivasan <maddy@linux.ibm.com> writes:
> 
>> ptrace-pkey.c test has macros defined which
>> are part of "pkeys.h" header file. Remove those
>> duplicates and include "pkeys.h"
>>
>> Signed-off-by: Madhavan Srinivasan <maddy@linux.ibm.com>
>> ---
>>  .../testing/selftests/powerpc/ptrace/ptrace-pkey.c | 14 +-------------
>>  1 file changed, 1 insertion(+), 13 deletions(-)
>>
> 
> Similar to previous patch. Cleanup looks good to me. 
> 
> Please feel free to add - 
> Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com> 
> 

Thanks

> -ritesh


