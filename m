Return-Path: <linux-kselftest+bounces-13988-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E883C93907D
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Jul 2024 16:20:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A44832820FB
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Jul 2024 14:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 187A71EB3D;
	Mon, 22 Jul 2024 14:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="YRqILlj0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F58ABE5E;
	Mon, 22 Jul 2024 14:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721658009; cv=none; b=u5+XKCBrSNDBF7P/esw3Ojd3Ut6iKGB+Gf26u7QrZWVtcIgcw1S0TYZUXqEQSqtXkVYjUTD0QDRe4bmlFC109ZbQDFxzV/re7XwRZ3Bpb383BFH1OJ5jJCnyp+UGOy/DwDPYdO+xfq04EpTp7Lp9+Lp9AodCNgEZOx9QOpCbVA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721658009; c=relaxed/simple;
	bh=3ikSZtRWRbHPaYQO0owQju8+aleRJhnRFox3GfSIPmQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Zos8K21OhxnIeRQun1MlxKB+DAR0WemFmeFiyyeLoaZOBGtwdULVn2eCc68FYs9eA7VEAznkb47I0XfByjkkJFnleR9R4QreQ6foA5ObboSwKP61VHUJ7hhIotqT/VSpFn4hCanUqr4id6x5VQvqLKQRWeqz2R7QXjmdFOL0+a8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=YRqILlj0; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46MAtolV021658;
	Mon, 22 Jul 2024 14:19:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wLDVRtZNpbHVEXaHjGX7U65bki1FOcvOCJ32Q2SKgN0=; b=YRqILlj0IfHW67RM
	y6EDzM49FzugcYHz+a6iLnbVNNQvFasPmGy1X/dV5+k8k05xOTGaEuf019PgXGac
	bZoKQPqVCt2FrRoH1DEaCKMOp6yiAs/pG/4q/lqPuWS9sib2VlqjlcVnjTngnfR5
	VjUx2hO5wsoczZSM8hGII5pjKacAf4qWUs92G3o4k2REPsnxonCXj4UI4om9YJCY
	XKjb9CXhTAP4z3srXhX6MMUM7LlZVMVC+EqEuBCR5tOThOTYfmcaAcBxUCaUw6Gf
	7giTNvScNliPgT64A8axCmUHEPeGw5nWy6hJAblsSRhIVFeF+LR7lLwTkos36vKv
	nV9vJg==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40g60juw4s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Jul 2024 14:19:47 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46MEJkgI005838
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Jul 2024 14:19:46 GMT
Received: from [10.81.24.74] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 22 Jul
 2024 07:19:46 -0700
Message-ID: <7fa38eba-97ca-4bbc-b585-f646a26a2c29@quicinc.com>
Date: Mon, 22 Jul 2024 07:19:45 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] lib/kfifo-test.c: add tests for the kfifo structure
To: Diego Vieira <diego.daniel.professional@gmail.com>,
        Andrew Morton
	<akpm@linux-foundation.org>,
        <linux-kernel@vger.kernel.org>,
        Brendan Higgins
	<brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>, Rae Moar
	<rmoar@google.com>,
        <linux-kselftest@vger.kernel.org>, <kunit-dev@googlegroups.com>
CC: <n@nfraprado.net>, <andrealmeid@riseup.net>, <vinicius@nukelet.com>
References: <20240722001804.8120-1-diego.daniel.professional@gmail.com>
 <20240722001804.8120-2-diego.daniel.professional@gmail.com>
Content-Language: en-US
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240722001804.8120-2-diego.daniel.professional@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: n-u0Zv6yMeg-XsE9BkKBtBEv_D6DbPJo
X-Proofpoint-GUID: n-u0Zv6yMeg-XsE9BkKBtBEv_D6DbPJo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-22_10,2024-07-22_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=681
 priorityscore=1501 bulkscore=0 impostorscore=0 lowpriorityscore=0
 mlxscore=0 suspectscore=0 phishscore=0 clxscore=1015 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407220107

On 7/21/24 17:18, Diego Vieira wrote:
> Add KUnit tests for the kfifo data structure.
> They test the vast majority of macros defined in the kfifo
> header (include/linux/kfifo.h).
> 
> These are inspired by the existing tests for the 'list' doubly
> linked in lib/list-test.c [1].
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/lib/list-test.c
> 
> Signed-off-by: Diego Vieira <diego.daniel.professional@gmail.com>
> ---
>   lib/Kconfig.debug |  14 +++
>   lib/Makefile      |   1 +
>   lib/kfifo-test.c  | 222 ++++++++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 237 insertions(+)
>   create mode 100644 lib/kfifo-test.c
...
> +MODULE_LICENSE("GPL");

Since commit 1fffe7a34c89 ("script: modpost: emit a warning when the 
description is missing") a module without a MODULE_DESCRIPTION() will 
result in a warning with make W=1

Multiple developers, including myself, have been fixing the existing 
warnings for 6.11 so please don't introduce a new one :)

/jeff

