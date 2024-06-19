Return-Path: <linux-kselftest+bounces-12262-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8884890F5C0
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Jun 2024 20:09:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EC401F229D7
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Jun 2024 18:09:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0F59156F28;
	Wed, 19 Jun 2024 18:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="jXLZEavk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39AC91DA24;
	Wed, 19 Jun 2024 18:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718820586; cv=none; b=rwsbcurF3bdHz+VmmJ4YATlNRSnrDDvCCS4TFMW00GIofg1dBrmCTdcb2jCFmZRtWU3xL59mDpAxm099hEvsdx+BwTLprgzTyW4DgY7OPC/IixXDDX0Jn+pALDph3tDHdd5/8ShXzFp9Mwz4B+SQn7FHXFySh9oSJosq2TZ6EKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718820586; c=relaxed/simple;
	bh=e1uybXOkF6pRw8DC5PXYWsYvoYWX7ig40cuY1jQC+2s=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=JQZFMIvF8fwRpAkDged9GZ+hx39fYmkBugUnRke5c5mZPlra3zDVjHXE5YWXf0sudMUKbq4+skCoJ7bsxQr+Y6BKa8QJuHwlowag8AO2Zi47ET5EtN0hqFrzHJKMrs3ozYGyzWliLGwZWCQaieosjmnHlSCkGHNXU5+HCeFQcxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=jXLZEavk; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45JGXnqb019233;
	Wed, 19 Jun 2024 18:09:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3DFMz1yDZygHSTY0eYqdWf8oZ2E55u7MPxXggmGszdk=; b=jXLZEavkUBHVBmo7
	WHizc102VzbEOzjR/h/qr3g6C9pnwxS1VeId6ZgHRQSv18n/jY9xpmPIO04+9idm
	TUQ4HoxB6nvUg7BARBHpWF1WkCffJB9TAFebmQJ5mRQ1EYL2DC1ZbxXMVIqABzFm
	EoJ5/TI6CH+3NR2Hyybhq412U/baTt8B2XTPt7fUmQicjTb8K41UCVxKCDDjCLou
	IfhNABF02yYNJP1mW6LK45aA8CKTxAtxk8DRXuSJEQ6LmlBbcbZJnnoBAXfapqLv
	9/M9g27IaW8OhIel+KfIaaMwIaCOUCHus/73fiVEwqIF8F2OveNI2qNf0/hCLRfo
	itMimQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yv2xu86p3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Jun 2024 18:09:34 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45JI9X2h000617
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Jun 2024 18:09:33 GMT
Received: from [10.81.24.74] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 19 Jun
 2024 11:09:33 -0700
Message-ID: <dd58758a-7689-48a3-bc89-2cef3858c4b4@quicinc.com>
Date: Wed, 19 Jun 2024 11:09:14 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] kunit: string-stream-test: Make it a separate
 module
To: Ivan Orlov <ivan.orlov0322@gmail.com>, <brendan.higgins@linux.dev>,
        <davidgow@google.com>, <rmoar@google.com>
CC: <linux-kselftest@vger.kernel.org>, <kunit-dev@googlegroups.com>,
        <linux-kernel@vger.kernel.org>, <skhan@linuxfoundation.org>
References: <20240618170331.264851-1-ivan.orlov0322@gmail.com>
 <20240618170331.264851-4-ivan.orlov0322@gmail.com>
Content-Language: en-US
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240618170331.264851-4-ivan.orlov0322@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: vkPCN_1FJWj3eICRaYJA6h3vi0L0Mlsr
X-Proofpoint-ORIG-GUID: vkPCN_1FJWj3eICRaYJA6h3vi0L0Mlsr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-19_02,2024-06-19_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 malwarescore=0
 impostorscore=0 suspectscore=0 mlxlogscore=999 spamscore=0
 lowpriorityscore=0 priorityscore=1501 clxscore=1011 adultscore=0
 mlxscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406190136

On 6/18/24 10:03, Ivan Orlov wrote:
> Currently, the only way to build string-stream-test is by setting
> CONFIG_KUNIT_TEST=y. However, CONFIG_KUNIT_TEST is a config option for
> a different test (`kunit-test.c`).
> 
> Introduce a new Kconfig entry in order to be able to build the
> string-stream-test test as a separate module. Import the KUnit namespace
> in the test so we could have string-stream functions accessible.
> 
> Reviewed-by: David Gow <davidgow@google.com>
> Signed-off-by: Ivan Orlov <ivan.orlov0322@gmail.com>
> ---
> V1 -> V2:
> - No changes
> 
>   lib/kunit/Kconfig              | 8 ++++++++
>   lib/kunit/Makefile             | 2 +-
>   lib/kunit/string-stream-test.c | 2 ++
>   3 files changed, 11 insertions(+), 1 deletion(-)
> 
...

> diff --git a/lib/kunit/string-stream-test.c b/lib/kunit/string-stream-test.c
> index 7511442ea98f..d03cac934e04 100644
> --- a/lib/kunit/string-stream-test.c
> +++ b/lib/kunit/string-stream-test.c
> @@ -534,3 +534,5 @@ static struct kunit_suite string_stream_test_suite = {
>   	.init = string_stream_test_init,
>   };
>   kunit_test_suites(&string_stream_test_suite);
> +MODULE_IMPORT_NS(EXPORTED_FOR_KUNIT_TESTING);
> +MODULE_LICENSE("GPL");

missing MODULE_DESCRIPTION()
this will cause a warning with make W=1


