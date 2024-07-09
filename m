Return-Path: <linux-kselftest+bounces-13381-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2F2A92BD6C
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Jul 2024 16:50:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60A712895A7
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Jul 2024 14:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A3DC1684AE;
	Tue,  9 Jul 2024 14:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="LyGZp5l/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEDC61E864;
	Tue,  9 Jul 2024 14:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720536599; cv=none; b=BvAON9oVAGDp6p9U1srZFJN2llws3uyvw4sU4NTAoyjY+MCBP57t0Et+Gv+MPvlJcRKG3cTJu4ZAhBXTCNEoV+uy3UThf2NBO1FaS9PzhUZhQtex99HgSg0IWVErxAdGdrC/fHi3KTBVJ7hAl5OBs9cAS4xZ9oYsSxDAyzn9ylM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720536599; c=relaxed/simple;
	bh=eUc+cFJM93ToUxIeXBBcTJX5lkcVp3Njq6FM8ite3AA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=IaeHde/PXKlwt+4JeLJ1bqcfY9kaUS3bnmnq8TaIfdRBwjuPsypeJEG+LYEBabTpSl+mh9eBKGer4PXzp5OHuonP1oBug7CUpfM2n83MAV0PKariSy5JsJwIDdsFZU0eZLDsMvP7/OkRIJrz3+HonbReSwN/LgLq9dZ/Ym3TKuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=LyGZp5l/; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 469AS6md013357;
	Tue, 9 Jul 2024 14:49:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	OBm02fxuS7z1vUEhqNdVoOYXznK1XRbcSRWqIJsv2XQ=; b=LyGZp5l/1Scu4Dfv
	aZOcPyX9nbvWaP3MMjCtE9I15eIaRsWpwnX163dRdu8TRGOAFDxLaDUFeZCT+ydJ
	RQ9aVMOvvi3ukoiL1xibMCwJpU1wvTpq7fF8iEXXOA3koUrmXcSAbF/koNUEBFgT
	Givr1Dt7m2RGfXTIpkHmtiyySX1wjIHFDT0kllAlwTXS6BFlxT9Unj8RbXB4J0Ix
	3MUqk2NzUACL8ZzEV7S5AGWwL2CAEitcB5QzDG4cqtPrKEHxaFnTDXjLQwV/Mh8S
	KkqjaLBFTcybUm5jtI6bVPsX9GrfOdr78fZ/aA6X+dAlObTDmVBTxKrneKcpT6hJ
	bZS9zA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 406x0t702b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jul 2024 14:49:43 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 469Enfqg015379
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 9 Jul 2024 14:49:41 GMT
Received: from [10.81.24.74] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 9 Jul 2024
 07:49:41 -0700
Message-ID: <dd7278f5-8da9-46c5-8db2-6d3882f7d674@quicinc.com>
Date: Tue, 9 Jul 2024 07:49:40 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 4/8] of: Add a KUnit test for overlays and test managed
 APIs
To: Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette
	<mturquette@baylibre.com>
CC: <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <patches@lists.linux.dev>, <kunit-dev@googlegroups.com>,
        <linux-kselftest@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Brendan
 Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>, Rae
 Moar <rmoar@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>,
        Daniel Latypov <dlatypov@google.com>,
        Christian Marangi <ansuelsmth@gmail.com>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Maxime Ripard <maxime@cerno.tech>
References: <20240706045454.215701-1-sboyd@kernel.org>
 <20240706045454.215701-5-sboyd@kernel.org>
Content-Language: en-US
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240706045454.215701-5-sboyd@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: sVmcQBlxh3ZJarXvw8zoA9zj2IvZgBlK
X-Proofpoint-ORIG-GUID: sVmcQBlxh3ZJarXvw8zoA9zj2IvZgBlK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-09_04,2024-07-09_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 bulkscore=0
 lowpriorityscore=0 impostorscore=0 adultscore=0 suspectscore=0
 phishscore=0 mlxlogscore=999 priorityscore=1501 malwarescore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407090096

On 7/5/24 21:54, Stephen Boyd wrote:
> Test the KUnit test managed overlay APIs. Confirm that platform devices
> are created and destroyed properly. This provides us confidence that the
> test managed APIs work correctly and can be relied upon to provide tests
> with fake platform devices and device nodes via overlays compiled into
> the kernel image.

...

> +kunit_test_suites(
> +	&of_overlay_apply_kunit_suite,
> +);
> +MODULE_LICENSE("GPL");

Multiple patches in this series introduce new instances of 
MODULE_LICENSE() without an accompanying MODULE_DESCRIPTION().

Building a module without a MODULE_DESCRIPTION() will result in a 
warning when building with make W=1.

/jeff

