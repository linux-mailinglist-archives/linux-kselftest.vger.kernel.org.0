Return-Path: <linux-kselftest+bounces-5493-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68913869D8A
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Feb 2024 18:27:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C87E3284CA5
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Feb 2024 17:27:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E7F613F016;
	Tue, 27 Feb 2024 17:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ZCTy7ll7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D55F13A884;
	Tue, 27 Feb 2024 17:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709054572; cv=none; b=HbA2pVsKoRScba5O0uzcSYs188CmyA/eVnD+Z7/LPyyCvnhuBez94u75iue/afQKxKBf1FBNnZOEh+jgQLJR8ZVs1ybYQI2YbkRmiZHnUatVpDWZP+Rsf8nHkPXNcnOURNX6ePwIUIaDGZSoBdPuMebgoXjtgPkh5LSlUg06f4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709054572; c=relaxed/simple;
	bh=OZd+QJFTU/LwgL/Zknn60/sBgfvG6r1OawibkMwoaGU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=XbZE8uL7AGM6Vgk6U4wEpVhROd/dBvPlfLT6nV7wGt1tGKaUDhohMKffXNosS8wcErA4elPeJRW7s++SQf/TqRSFjh6Uqth4mBXP9zZaQOe9KbtNJ0dDraNhS1vQUra26JQlZwr+zB4rjyiuo17KN5k1Ef6L/S9q4E+5YM1OvNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ZCTy7ll7; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41RBX79s001966;
	Tue, 27 Feb 2024 17:22:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=g5/OtNFrU+q0HQTPqi/YEqGkmh+JvEMc5GWZqEAuWTI=; b=ZC
	Ty7ll71rN8DODt66sNrLm4IsEKMm6JRxG05CVnpfRXo6OegPCKDvFzQ4GxX0CMA7
	4HNUafYKe5AudJDKFjmcea1gMW0KGeT6PdWPywzN1AVEplxwVG0CooOWxTp/myOt
	2mjU2d+DqRe2gTvEHJH23s5DgpDKagmG76roSWmoOHbXcJ+Svi3c2aE5FNC5/HgH
	aFhE3aMXbor6h74LbXirvAOe7/ZsQPsAPM2netNnHAdy0bdZLdhLkcwKAt6Jqqo6
	SCMqsHjNKWyeU7bOtGu69TrxoBzgWC/IxrmU5iFyQKYepTgcuOKquSWi7keqMaIQ
	pneMgdpWLPJqaymHobug==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wh64h22ex-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Feb 2024 17:22:23 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41RHMMUH001769
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Feb 2024 17:22:22 GMT
Received: from [10.71.110.192] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 27 Feb
 2024 09:22:21 -0800
Message-ID: <9336c99d-ca56-4d01-b9b2-18539ef0b725@quicinc.com>
Date: Tue, 27 Feb 2024 09:22:13 -0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/7] arm64: Unconditionally call
 unflatten_device_tree()
Content-Language: en-US
To: Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <patches@lists.linux.dev>,
        <linux-um@lists.infradead.org>, <linux-arm-kernel@lists.infradead.org>,
        <kunit-dev@googlegroups.com>, <linux-kselftest@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Frank Rowand <frowand.list@gmail.com>,
        Catalin
 Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Mark
 Rutland <mark.rutland@arm.com>
References: <20240217010557.2381548-1-sboyd@kernel.org>
 <20240217010557.2381548-6-sboyd@kernel.org>
From: Oreoluwa Babatunde <quic_obabatun@quicinc.com>
In-Reply-To: <20240217010557.2381548-6-sboyd@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: U-zGZIHscjx7uttOwzY-n83UKqVrV9ux
X-Proofpoint-GUID: U-zGZIHscjx7uttOwzY-n83UKqVrV9ux
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-27_03,2024-02-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1011
 bulkscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0
 mlxlogscore=999 priorityscore=1501 adultscore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2402120000
 definitions=main-2402270134

On 2/16/2024 5:05 PM, Stephen Boyd wrote:

> Call this function unconditionally so that we can populate an empty DTB
> on platforms that don't boot with a firmware provided or builtin DTB.
> When ACPI is in use, unflatten_device_tree() ignores the
> 'initial_boot_params' pointer so the live DT on those systems won't be
> whatever that's pointing to. Similarly, when kexec copies the DT data
> the previous kernel to the new one on ACPI systems,
> of_kexec_alloc_and_setup_fdt() will ignore the live DT (the empty root
> one) and copy the 'initial_boot_params' data.
>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Frank Rowand <frowand.list@gmail.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: <linux-arm-kernel@lists.infradead.org>
> Signed-off-by: Stephen Boyd <sboyd@kernel.org>

This change looks good to me. I am working on a patch set that will benefit from this.
Reviewed-by: Oreoluwa Babatunde <quic_obabatun@quicinc.com>

Regards,
Oreoluwa

> ---
>  arch/arm64/kernel/setup.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
> index 42c690bb2d60..0d210720d47d 100644
> --- a/arch/arm64/kernel/setup.c
> +++ b/arch/arm64/kernel/setup.c
> @@ -351,8 +351,7 @@ void __init __no_sanitize_address setup_arch(char **cmdline_p)
>  	/* Parse the ACPI tables for possible boot-time configuration */
>  	acpi_boot_table_init();
>  
> -	if (acpi_disabled)
> -		unflatten_device_tree();
> +	unflatten_device_tree();
>  
>  	bootmem_init();

