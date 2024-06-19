Return-Path: <linux-kselftest+bounces-12263-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 80E4490F62A
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Jun 2024 20:38:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 323032832AD
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Jun 2024 18:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C3CC1581F3;
	Wed, 19 Jun 2024 18:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="QFIZ9FS6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C034315748C;
	Wed, 19 Jun 2024 18:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718822329; cv=none; b=hVFauMqb0F/IuP8duf4T+u/kOk/VWsvLD7OyNXl993fF8vdIyxRYwQOKmXqU/+0pU4tjFFL1q0OS+tMsrigHpHir8/7019moQcLWbf3ic6m7INSn/vEPUumMACpDBMK3rUQZTS+8ccE4MCH92UhPO5Fqyaggm1/FV/eWNMoanq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718822329; c=relaxed/simple;
	bh=CLulv+F6AfNeTOO6KvrB+UAA0kz4EaRiJ5NQ78Qp/Ik=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Jw+u4kivmMawP2lOdxckXkFH1ovVDJGaxLbMm05TlAGaoHYPsc8PjqcwRcnyqdwYgzvOVxlB9vMz1oVOWZzU2XY9/f+1yVsDeAq6lrhrSH9T3vQmLiurgEN7CZikdAaiRNTgdYw9WjCOjxz73hBygc5MXJQISaVFVT7IcFt7Mo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=QFIZ9FS6; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45J9jAq7016044;
	Wed, 19 Jun 2024 18:38:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	pQi4cEGMKplahCMAtCGNOa8fyNL1P8ZRu9NQMbNyKBA=; b=QFIZ9FS6ZKtdEjJM
	V/sG6dL5Fe1cD2bordNaC910PqXBZuqFLgJIoc0RsMrUJS0CBAf+YHjkMht1DdP2
	az1y3pL+ThG6LKYg1eZzLrpF/3ogDhjmBrh5zih00zDGma1tr8f4Kk8sYWj5iI2/
	KWCnCLM6+TOYc9hQkQvo9eQPXwJ74XwB6n/q68R/Gb941TslXlJ/dEjta0VpHwpe
	k/Mx37iWxGBX99nICfSitHA3uwoHOeDqvZu+KArJ7413cmS1y7E4/cWJeyvOu2fM
	Fs6NCOtKkztTZtiSmBIXZ1EhjVisORRzeQXUNjsW05AMBOs/zifSEMJEbTXaIe17
	pYfJRw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yuja52fgu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Jun 2024 18:38:34 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45JIcWKP006906
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Jun 2024 18:38:32 GMT
Received: from [10.81.24.74] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 19 Jun
 2024 11:38:32 -0700
Message-ID: <e91728af-83e7-453e-816f-add3b0011a66@quicinc.com>
Date: Wed, 19 Jun 2024 11:38:31 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] usercopy: Convert test_user_copy to KUnit test
To: Kees Cook <kees@kernel.org>, Mark Rutland <mark.rutland@arm.com>
CC: Vitor Massaru Iha <vitor@massaru.org>,
        Ivan Orlov
	<ivan.orlov0322@gmail.com>,
        David Gow <davidgow@google.com>,
        Brendan Higgins
	<brendan.higgins@linux.dev>,
        Rae Moar <rmoar@google.com>,
        "Gustavo A. R.
 Silva" <gustavoars@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        <kunit-dev@googlegroups.com>, <linux-hardening@vger.kernel.org>
References: <20240612195412.make.760-kees@kernel.org>
 <20240612195921.2685842-2-kees@kernel.org>
Content-Language: en-US
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240612195921.2685842-2-kees@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: BxSyBGdf2KXEaNU80wT485Y1kHpPWMz4
X-Proofpoint-GUID: BxSyBGdf2KXEaNU80wT485Y1kHpPWMz4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-19_02,2024-06-19_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 suspectscore=0
 adultscore=0 impostorscore=0 clxscore=1011 mlxscore=0 spamscore=0
 bulkscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406190140

On 6/12/24 12:59, Kees Cook wrote:
> Convert the runtime tests of hardened usercopy to standard KUnit tests.
> 
> Additionally disable usercopy_test_invalid() for systems with separate
> address spaces (or no MMU) since it's not sensible to test for address
> confusion there (e.g. m68k).
> 
> Co-developed-by: Vitor Massaru Iha <vitor@massaru.org>
> Signed-off-by: Vitor Massaru Iha <vitor@massaru.org>
> Link: https://lore.kernel.org/r/20200721174654.72132-1-vitor@massaru.org
> Tested-by: Ivan Orlov <ivan.orlov0322@gmail.com>
> Reviewed-by: David Gow <davidgow@google.com>
> Signed-off-by: Kees Cook <kees@kernel.org>
> ---
...
> +kunit_test_suites(&usercopy_test_suite);
> +MODULE_AUTHOR("Kees Cook <kees@kernel.org>");
>   MODULE_LICENSE("GPL");

Can you add the missing MODULE_DESCRIPTION() to remove the W=1 warning?

The fix to the current file is part of:
https://lore.kernel.org/all/20240601-md-lib-test-v1-1-a728620e37d8@quicinc.com/

