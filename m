Return-Path: <linux-kselftest+bounces-14075-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B901939E15
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jul 2024 11:40:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C90B1C21BF2
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jul 2024 09:40:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB7EE14D2A0;
	Tue, 23 Jul 2024 09:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="sPlKS1cp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C95014A4FF;
	Tue, 23 Jul 2024 09:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721727647; cv=none; b=hE+JBDIbEWIoWmHPI2I73acAEq/aM7akLPwVeIW1aJflunh0/3fuZXD/VwfFSTrMmjaUpPZv3qc40ixTV07Tydyn7KwKNL9EaZLYTKcYCunHOn+LeIeQdW1Lm1i/925ZnEDmrJfP2bG8+45UaTQDWOql1450QLA5T9TyGfsucE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721727647; c=relaxed/simple;
	bh=EjbEpXoO6uENSqPvtORiG6eB9zCuVB1boyuXN7L/CI8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AVt//tyVzQqw1fKcTvvnulbM85hoT+fm0XAGP5imvyAm40dmu2zm3BJca7HKJi6o9fs7s9hvxnkZLWdH0iKanD+rApl0TcE/OxuM6u86MUJf87RiDHIpDVC2wP+L+IOhTZbj1wJhaUPj/OY6Uyk2TLDf6xTRHNqlZaN4HJA3EnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=sPlKS1cp; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46N8nr3U027485;
	Tue, 23 Jul 2024 09:40:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=d
	BmXDh/Okkh7uTImIeHO0DeIOFhsCrwUbHlBXT3dMtU=; b=sPlKS1cpcmSpR2vRX
	7/Cfa4OfuE+Pe6ZctuGR9vczQEfdgNLkJ+VS/Tyo93TRsviJdSAgWPcdd22ULV56
	4Dv7hKaUfGghhrlV2bTAVrpbBMxLdfCeVobDawwdV9c08GXtuTuLckP3bhfO8ie9
	8gafqtC5R9fX8wcLJKlV3GZhKAFiZwQoVyX9MIJuaKfCTMas1A3maN+13SX+N/L0
	Ild+cbUxRyfJ6q1w9PIQgNEpn/9wVpoN0arkaQWdhZwfLHUdWf4TPrgQoiXp19ik
	Lg0zsJ3GksLmfgR2Hkdc6clArt0tyQWo1O2VZrQRdnBXOvBiYxBReJThfESxvWXV
	uQyGw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40hwma1ekr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jul 2024 09:40:43 +0000 (GMT)
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 46N9egkB006203;
	Tue, 23 Jul 2024 09:40:42 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40hwma1ekk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jul 2024 09:40:42 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 46N9IIGr007979;
	Tue, 23 Jul 2024 09:40:41 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 40gxn9sse7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jul 2024 09:40:41 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 46N9eart15728996
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Jul 2024 09:40:38 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1CF142004E;
	Tue, 23 Jul 2024 09:40:36 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D93B520043;
	Tue, 23 Jul 2024 09:40:35 +0000 (GMT)
Received: from [9.152.224.131] (unknown [9.152.224.131])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 23 Jul 2024 09:40:35 +0000 (GMT)
Message-ID: <9cc8f685-70b2-4c31-9be5-e822ae52797a@linux.ibm.com>
Date: Tue, 23 Jul 2024 11:40:35 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/10] s390: Enable KVM_S390_UCONTROL config in
 debug_defconfig
To: Christoph Schlameuss <schlameuss@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Nina Schoetterl-Glausch <nsg@linux.ibm.com>
References: <20240723093126.285319-1-schlameuss@linux.ibm.com>
 <20240723093126.285319-11-schlameuss@linux.ibm.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <20240723093126.285319-11-schlameuss@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: QQkZbPHeifuHCj9qxLvN5SkolUWMgx6x
X-Proofpoint-GUID: lE_n-syipvQMAh0NpFNENtr2x2JVuZOU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-22_18,2024-07-23_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 mlxscore=0
 bulkscore=0 spamscore=0 phishscore=0 suspectscore=0 lowpriorityscore=0
 mlxlogscore=856 adultscore=0 priorityscore=1501 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407230065



Am 23.07.24 um 11:31 schrieb Christoph Schlameuss:
> To simplify testing enable UCONTROL KVM by default in debug kernels.
> 
> Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
> ---
>   arch/s390/Kconfig.debug | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/arch/s390/Kconfig.debug b/arch/s390/Kconfig.debug
> index c4300ea4abf8..4798dded6d76 100644
> --- a/arch/s390/Kconfig.debug
> +++ b/arch/s390/Kconfig.debug
> @@ -20,3 +20,6 @@ config CIO_INJECT
>   	  This option provides a debugging facility to inject certain artificial events
>   	  and instruction responses to the CIO layer of Linux kernel. The newly created
>   	  debugfs user-interfaces will be at /sys/kernel/debug/s390/cio/*
> +
> +config KVM_S390_UCONTROL
> +	def_bool y

Isnt that enabling ucontrol for all configs? YOu probably wanted to patch
arch/s390/configs/debug_defconfig

