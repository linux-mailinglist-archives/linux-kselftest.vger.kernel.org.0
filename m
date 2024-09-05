Return-Path: <linux-kselftest+bounces-17297-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FE4F96E0C4
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Sep 2024 19:05:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F1AE289ADB
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Sep 2024 17:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 395BE1A0AE1;
	Thu,  5 Sep 2024 17:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="f3hgaQx4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86D1D54F87;
	Thu,  5 Sep 2024 17:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725555896; cv=none; b=gSrPGdEVdo+CITEHQI8IftGgx4/SPBe5G9eec+Ecq+d5Fyb5XEUyvJhC4sAsZdZxog+NQG47OggZR0XJp/0DyAXW4HcjA3SumsrCWkwwD+2eE7Ll8kdNSkW8Mz1VDUT24tjZh3fIdsx+eaq+l6uKrcYl3mNXkIkpyZ497R5srXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725555896; c=relaxed/simple;
	bh=dszasaLQ5F2bOpdRX6ozfhPf0Kh1rM87y0FL2yxR4h8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=YlK63jEKMu4urJL2iW9rNXuiYA5xuj5QushuFlJeL4ypSzvgzLy4kai71hh3yIUwjhhq83XzKS4iJ75MWu5nTWEKPKdezMWqa1OnM1JIfSTUhUfQkrtBFPgBJdQ0wAnl+d+rNnPrY2ENQA23QZYh4saWwF3GiL392yEzpjYQC1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=f3hgaQx4; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48597LPe026135;
	Thu, 5 Sep 2024 17:02:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	dszasaLQ5F2bOpdRX6ozfhPf0Kh1rM87y0FL2yxR4h8=; b=f3hgaQx4NdOewLhD
	hhaHl2ZN1VHZHeP3W6Ts/wlyKkLxO287pf5DJ57U02vt+LjCIW99qsQhHl98ltVv
	s9Kfz83W8E3/mxf0Z5QZWltukw0oZQ/wKfXqelC14ueojYROEWqRPUUzbnPmdU2u
	sNC7VCGCvvcyN8ek6SbJSwyW7r6BOWRcvbS8mE+u0vCY9vQdBkfRQcHuPyR5qkcK
	sYFI6efbP0OC0B6Pven119lJ7pJIL20DL0IBbkb4K5mt8IVpw6QnBCXYOZOdpQD5
	dSk1d94nLG01U9llv17kiiugw226nY7C+qtwZH5AcMnEKzNPxCGzpE1WyLPFfysM
	v+ASWw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41drqe93ud-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Sep 2024 17:02:05 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 485H23qG015981
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 5 Sep 2024 17:02:03 GMT
Received: from [10.81.24.74] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 5 Sep 2024
 10:02:03 -0700
Message-ID: <c6ac95bd-df49-4db7-8f5c-1281a9f95ecd@quicinc.com>
Date: Thu, 5 Sep 2024 10:02:02 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 13/14] selftests/digest_cache: Add selftests for the
 Integrity Digest Cache
To: Roberto Sassu <roberto.sassu@huaweicloud.com>, <zohar@linux.ibm.com>,
        <dmitry.kasatkin@gmail.com>, <eric.snowberg@oracle.com>,
        <corbet@lwn.net>, <akpm@linux-foundation.org>, <paul@paul-moore.com>,
        <jmorris@namei.org>, <serge@hallyn.com>, <shuah@kernel.org>,
        <mcoquelin.stm32@gmail.com>, <alexandre.torgue@foss.st.com>
CC: <linux-integrity@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>, <wufan@linux.microsoft.com>,
        <pbrobinson@gmail.com>, <zbyszek@in.waw.pl>, <hch@lst.de>,
        <mjg59@srcf.ucam.org>, <pmatilai@redhat.com>, <jannh@google.com>,
        <dhowells@redhat.com>, <jikos@kernel.org>, <mkoutny@suse.com>,
        <ppavlu@suse.com>, <petr.vorel@gmail.com>, <mzerqung@0pointer.de>,
        <kgold@linux.ibm.com>, Roberto Sassu <roberto.sassu@huawei.com>
References: <20240905150543.3766895-1-roberto.sassu@huaweicloud.com>
 <20240905150543.3766895-14-roberto.sassu@huaweicloud.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Content-Language: en-US
In-Reply-To: <20240905150543.3766895-14-roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: IWHkMbE2UMqP4SDX7b2uvUjjfPgW9-Pc
X-Proofpoint-ORIG-GUID: IWHkMbE2UMqP4SDX7b2uvUjjfPgW9-Pc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-05_12,2024-09-04_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 phishscore=0 adultscore=0 suspectscore=0 priorityscore=1501 clxscore=1011
 impostorscore=0 spamscore=0 mlxlogscore=983 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2409050127

On 9/5/24 08:05, Roberto Sassu wrote:
...
> +module_init(digest_cache_test_init);
> +module_exit(digest_cache_test_fini);
> +MODULE_LICENSE("GPL");

Missing MODULE_DESCRIPTION()

Since commit 1fffe7a34c89 ("script: modpost: emit a warning when the
description is missing"), a module without a MODULE_DESCRIPTION() will
result in a warning when built with make W=1. Recently, multiple
developers have been eradicating these warnings treewide, and very few
are left, so please don't introduce a new one :)


