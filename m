Return-Path: <linux-kselftest+bounces-36450-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FA28AF78A9
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Jul 2025 16:52:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FB7F188C37F
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Jul 2025 14:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0A712EE287;
	Thu,  3 Jul 2025 14:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Xb7GqeE0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C14B2ED85E;
	Thu,  3 Jul 2025 14:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751554247; cv=none; b=XB/wDj5HOXBTK9b1fJiBVxd7uLKeNM2tXim9tfg94f3lJrHmAVeJdvesdSa52qskbao1MeLaA2Nix3XYINzFsxjV3F/ub84SyAHbAswsmdXgV5A1k2Dm1vmH/TRhlNyosemLdcCFVcpBU8gvCNbYM4vAsOnfSFqumM9tpzJKtLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751554247; c=relaxed/simple;
	bh=uk6nLy8qmqW49ZT/udjHfsqtbcPLKiTAsnFtafAEi9g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fL9NnTQfo8iptBbRXIWDFreN8pA59Cp8CmqWAPtfEhNRWJ5kZKeVIgd5/csf9oMejkAyZmQ724ij9F50FVFS21K2uo4uy1dy3pIyh1hu09DChrr7dupCHr/0xa7jaOjcPFw3+cU4Q3gV53h07kkP2IP6yCjzqjIAQvl5AOTsVbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Xb7GqeE0; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5637tVk2024499;
	Thu, 3 Jul 2025 14:50:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=9YMey3
	siK0wqCW94xx52T29gHvYnSHgMxewAlTL36Sc=; b=Xb7GqeE0Ka16QsK2x1h1/g
	kjn6/hLU2kGhaMO8qHz8vqnpzA05xGuJoFeohppV9BCfk6wmetUaUPLPNRZDXBwo
	sTI+bHEzHnI2tXdlpHnCXZQlhcdGnL574YN0e/mPJnj7De+LHG8ZEVPZaoZzIe6N
	It84Lnhn7sFQU5NhwA8Qu/c29J2D1oMIp8cSSMXkTWJ029am+UJN1fIiR5/CO3tS
	LEQDA8rd23vvX8fLe8h95REamA14wQygQNzzvu4C94Hb2gfH9Tsn3iNALrEx03xu
	euuHIzgF0mhMR+yqEgCj0SR7dk2ma2OkDycjY967FQ2aA9VRffg7kyRGoCTCdZWg
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47j8314fm0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 03 Jul 2025 14:50:25 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 563EmXvm009354;
	Thu, 3 Jul 2025 14:50:24 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47j8314fkx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 03 Jul 2025 14:50:24 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 563EmbvK021385;
	Thu, 3 Jul 2025 14:50:23 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 47jwe3n49w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 03 Jul 2025 14:50:23 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 563EoMZB25952806
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 3 Jul 2025 14:50:22 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7ADD258059;
	Thu,  3 Jul 2025 14:50:22 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2C0FA58043;
	Thu,  3 Jul 2025 14:50:17 +0000 (GMT)
Received: from [9.109.245.113] (unknown [9.109.245.113])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  3 Jul 2025 14:50:16 +0000 (GMT)
Message-ID: <8e7dbebe-59c5-42cc-bc44-570842b8e82c@linux.ibm.com>
Date: Thu, 3 Jul 2025 20:20:15 +0530
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/7] selftests/mm: Add support to test 4PB VA on PPC64
To: Zi Yan <ziy@nvidia.com>, Aboorva Devarajan <aboorvad@linux.ibm.com>
Cc: akpm@linux-foundation.org, Liam.Howlett@oracle.com,
        lorenzo.stoakes@oracle.com, shuah@kernel.org, pfalcato@suse.de,
        david@redhat.com, baolin.wang@linux.alibaba.com, npache@redhat.com,
        ryan.roberts@arm.com, dev.jain@arm.com, baohua@kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, ritesh.list@gmail.com
References: <20250703060656.54345-1-aboorvad@linux.ibm.com>
 <20250703060656.54345-3-aboorvad@linux.ibm.com>
 <5FA05361-1FA8-4CAA-AF23-7BB0974DA78B@nvidia.com>
Content-Language: en-US
From: Donet Tom <donettom@linux.ibm.com>
In-Reply-To: <5FA05361-1FA8-4CAA-AF23-7BB0974DA78B@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: TfIyuWwW6FDd5tr5QLsQNmpp_EvBf-eo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAzMDEyNSBTYWx0ZWRfX7to6koSyXMzN J3j2/Lz/QeMgvqWVX5bwlcBr5cZzYCoJKFka6CrYoNdojMfbyrsThtsgfhiuFOnYVTUUS5ksOJ0 LkXGbEoNgSUFjjGX5/6Biqca8V8E6tW7YSN8+1HpgLbLoAT5iiYPAAQ/Ki0OazoPQBF5r/eq+pz
 bcX2VJiYxh1ioG4OW23S/Uyd11R4/UP6Kn+fSvh0zvf55dudBvGRA+gbW4Wcw6O7npjj3b48qjE JTj9rOv4Op/WFZcN6mOsJ3m9rh3Ca2l9+Zey/4AL/RfOZdOjq77x7GRvdcotA0tB+/jpu37FU98 ExeLt+HA0kNL00yX8BcF8h0njI/IR/ONMjFQMjK4eSW27AosBXZe8sI5+nThbdem2RyDaV0XnZR
 pcAYxlGyN6KnJK0CFZWSJlvtZ8U3z0b0WFIDbP2v+YNQ28Sh5mCngWduFqG+NkTgdFlxRq07
X-Authority-Analysis: v=2.4 cv=MOlgmNZl c=1 sm=1 tr=0 ts=686698b1 cx=c_pps a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VnNF1IyMAAAA:8 a=Ikd4Dj_1AAAA:8 a=R9CAwAD-EEtMngcwLj8A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: lgvv0nC3QP17oZr9MFbZFZXwQiTKAVGo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-03_04,2025-07-02_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 adultscore=0 suspectscore=0 bulkscore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 mlxlogscore=999 spamscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507030125


On 7/3/25 8:11 PM, Zi Yan wrote:
> On 3 Jul 2025, at 2:06, Aboorva Devarajan wrote:
>
>> From: Donet Tom <donettom@linux.ibm.com>
>>
>> PowerPC64 supports a 4PB virtual address space, but this test was
>> previously limited to 512TB. This patch extends the coverage up to
>> the full 4PB VA range on PowerPC64.
>>
>> Memory from 0 to 128TB is allocated without an address hint, while
>> allocations from 128TB to 4PB use a hint address.
>>
>> Signed-off-by: Donet Tom <donettom@linux.ibm.com>
>> Signed-off-by: Aboorva Devarajan <aboorvad@linux.ibm.com>
>> ---
>>   tools/testing/selftests/mm/virtual_address_range.c | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/tools/testing/selftests/mm/virtual_address_range.c b/tools/testing/selftests/mm/virtual_address_range.c
>> index e24c36a39f22..619acf0b9239 100644
>> --- a/tools/testing/selftests/mm/virtual_address_range.c
>> +++ b/tools/testing/selftests/mm/virtual_address_range.c
>> @@ -50,6 +50,7 @@
>>   #define NR_CHUNKS_256TB   (NR_CHUNKS_128TB * 2UL)
>>   #define NR_CHUNKS_384TB   (NR_CHUNKS_128TB * 3UL)
>>   #define NR_CHUNKS_3840TB  (NR_CHUNKS_128TB * 30UL)
>> +#define NR_CHUNKS_3968TB  (NR_CHUNKS_128TB * 31UL)
>>
>>   #define ADDR_MARK_128TB  (1UL << 47) /* First address beyond 128TB */
>>   #define ADDR_MARK_256TB  (1UL << 48) /* First address beyond 256TB */
>> @@ -59,6 +60,11 @@
>>   #define HIGH_ADDR_SHIFT 49
>>   #define NR_CHUNKS_LOW   NR_CHUNKS_256TB
>>   #define NR_CHUNKS_HIGH  NR_CHUNKS_3840TB
>> +#elif defined(__PPC64__)
>> +#define HIGH_ADDR_MARK  ADDR_MARK_128TB
>> +#define HIGH_ADDR_SHIFT 48
>> +#define NR_CHUNKS_LOW   NR_CHUNKS_128TB
>> +#define NR_CHUNKS_HIGH  NR_CHUNKS_3968TB
>>   #else
>>   #define HIGH_ADDR_MARK  ADDR_MARK_128TB
>>   #define HIGH_ADDR_SHIFT 48
> Could you also update the comment above this code to say PowerPC64 also
> supports 4PB virtual address space?


Sure. I will add


>
>  From the comment, arm64 supports 4PB but its NR_CHUNKS_HIGH is only 3840TB,
> whereas PowerPC64 here can get to 3968TB. I do not know why arm64’s
> 4PB is smaller. ;)
>
> Otherwise, the patch looks good to me.
>
> Reviewed-by: Zi Yan <ziy@nvidia.com>
>
> Best Regards,
> Yan, Zi

