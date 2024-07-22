Return-Path: <linux-kselftest+bounces-13987-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C9C9A93906F
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Jul 2024 16:16:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 078371C21615
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Jul 2024 14:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE821D2F5;
	Mon, 22 Jul 2024 14:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="PWrzdmgE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 098D5BE5E;
	Mon, 22 Jul 2024 14:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721657799; cv=none; b=cXzakW5WRskZgeDx+wwjFemonpKnB2m5FabNMbmRzPF32CBqUDfWGL1j9iv+fIA6xbGAT83D5249o8hykqU0x4WxFisvoLt+GvelRJx72rf7B4q/VqGpl1tDv6uRk9oOBpVMJinZp+L11u0nZD1uu4RJ1OPNd02Nconlx+CPTc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721657799; c=relaxed/simple;
	bh=nTXDt+l4Zuc6S41Z8e98PXIq3CzXrwpHhQdfJG+SCBg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=IibBhJU1whxP780MJhL2YMUj2E4xht47tnQ4zgz2TG7ORnTKsUdiNw/BFR9uhqq+c4kBQRJjUuSjEN6lHdGbIW4Jg0MgC09Hb3sQyIfSTsOgI5MBQaO6KSs6lFK4AWSNnp4rRFjGSqTRVGOaJRIeT9Lefnqge5kDuEAgR+kPrN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=PWrzdmgE; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46MAlKa0024464;
	Mon, 22 Jul 2024 14:16:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PNR2ywxLBRAwgL+RND1uxuDJVf3sbd5jqUguxEb0BIQ=; b=PWrzdmgE5P2xLC84
	Aqzrli9W2EcPmdMicBCy+1NzrCtJJ7o4y2993LC+HskJrWmUK7eIGGjcKtBE/KPW
	nVVOzjCqaJbk+DnJzT4ONFvB02Gv/MNqVC1CVI9srm8MbuR+sFTgHrgoYn8mWI0q
	r0yxJy+/2OW/bcBdraizC3EexPwXlglveafMU5Fgawwf02ZBpB99PDS328jrF5iu
	+TFGjgN/NTVgwph1P15CLQ8yrozev2qVhJnqbwRH50mIT4RJZslnW4KKaYVtlcjy
	aJ8Q0EXQbD0hAQT7EdRfo5qQDTp+AuUwjXfJI/8/reFnEef/KIObNH5Ju7c7+f8J
	qrtcWg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40g487c2f1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Jul 2024 14:16:19 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46MEGHmk023813
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Jul 2024 14:16:17 GMT
Received: from [10.81.24.74] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 22 Jul
 2024 07:16:17 -0700
Message-ID: <d1a7c02f-2a13-4319-be33-fc7f613b7e8a@quicinc.com>
Date: Mon, 22 Jul 2024 07:16:17 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] lib/llist_kunit.c: add KUnit tests for llist
To: Artur Alves <arturacb@gmail.com>,
        Andrew Morton
	<akpm@linux-foundation.org>,
        <linux-kernel@vger.kernel.org>,
        Brendan Higgins
	<brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>, Rae Moar
	<rmoar@google.com>,
        <linux-kselftest@vger.kernel.org>, <kunit-dev@googlegroups.com>
CC: <n@nfraprado.net>, <andrealmeid@riseup.net>, <vinicius@nukelet.com>,
        <diego.daniel.professional@gmail.com>
References: <20240721234317.7935-1-arturacb@gmail.com>
 <20240721234317.7935-2-arturacb@gmail.com>
Content-Language: en-US
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240721234317.7935-2-arturacb@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: vGvAOY6yclgHRv8anmsyWCn4Gozh1RBK
X-Proofpoint-GUID: vGvAOY6yclgHRv8anmsyWCn4Gozh1RBK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-22_10,2024-07-22_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 suspectscore=0 phishscore=0 priorityscore=1501 mlxlogscore=551
 malwarescore=0 adultscore=0 impostorscore=0 clxscore=1011
 lowpriorityscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2407110000 definitions=main-2407220107

On 7/21/24 16:43, Artur Alves wrote:
> Add KUnit tests for the llist data structure. They test the vast
> majority of methods and macros defined in include/linux/llist.h.
> 
> These are inspired by the existing tests for the 'list' doubly
> linked in lib/list-test.c [1]. Each test case (llist_test_x)
> tests the behaviour of the llist function/macro 'x'.
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/lib/list-test.c
> 
> Signed-off-by: Artur Alves <arturacb@gmail.com>
> ---
>   lib/Kconfig.debug |  11 ++
>   lib/Makefile      |   1 +
>   lib/llist_kunit.c | 360 ++++++++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 372 insertions(+)
>   create mode 100644 lib/llist_kunit.c

...

> +MODULE_LICENSE("GPL v2");

Since commit 1fffe7a34c89 ("script: modpost: emit a warning when the 
description is missing") a module without a MODULE_DESCRIPTION() will 
result in a warning with make W=1.

Multiple developers, including myself, have been fixing the existing 
warnings for 6.11 so please don't introduce a new one :)

/jeff

