Return-Path: <linux-kselftest+bounces-20106-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93CB19A358D
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Oct 2024 08:38:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2188D1F225FC
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Oct 2024 06:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94AAD17DFEB;
	Fri, 18 Oct 2024 06:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Qg43y9Yx";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="X5aHslJa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85CB520E33E;
	Fri, 18 Oct 2024 06:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729233501; cv=fail; b=RFvY/zXkxqukkI61un47+EHJ7rWk/YkZp1ubofWokObYj76E6e2Y2OJOmFfcJMobfL9kKfP5s1T7LQIP27G2fUhi8R/RSW8XlDqlAUDo9mduYWLbD8CmmrunTGbuVchzCHAObpVFhhA1xatrZMIvDze4/vfgRUKd5NdgGnzsOKs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729233501; c=relaxed/simple;
	bh=OuygJ4SdquSyIq7JxIgFEnCgSuRVe0EijKLrSp6pi4k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=K0EI8XxmO3j1RltYVno+VlYGtzUQGLhPE3qCohCz87mPGk7tp95a84w/L+UtWwGFf9TXBJOlH5fAY5q/J9ndwlZi5JpQfzf8lCC8nEx8UAyBcl1E58yc3ar2CJgorNxCebavmvFgPNUh4WUuXLLmqvzVRDfsgf7JdDsaeJVTEI8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Qg43y9Yx; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=X5aHslJa; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49HNnPkD002832;
	Fri, 18 Oct 2024 06:38:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=DkejRWbyavecanRnkRsl1sUZjGTfP4QY8aHRuz5NLfE=; b=
	Qg43y9Yx3g6GjyxSzsYAmLUJ/C7T6o7W3jHYfFEAVI9GIlq6SKvRKgur0sdDnpiO
	m8Q8Eei/RFpmyfjWUi6bYHMgxkkEKYEdp8h/8KNrf7HJC/XrMB/3Wj1qOyFMUc9d
	H62q+A3zSkh9/ymvg5hHTebMctd8iZ3pgikLttbmFkebmtzgcPInRL9LWytzU8yf
	F6xN3NlozxDwHjTH2N5Ea0RsXx2XPuiWLJUJfh88CsCxitW8oMha6du8dPMh/2d9
	WhifjRLK4jYRS4xEJVgS8oo4rUW3F4ejgiSKu0UIsMzB6Bvh70Ua4gOxyWTXApH1
	YP7qx7r5dAIeKSYmwtm9kw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427h09qfdf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Oct 2024 06:38:00 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49I6L8BF010367;
	Fri, 18 Oct 2024 06:37:59 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 427fjhjmh3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Oct 2024 06:37:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dMXPuSGeWTcJRlTRBViKUt+Jp9GBMtHUnb33dhKDup8Cdgg9tvkXClFLEzsw9rmq/tdABKYrpLYUKubKFOj9vsmzNW/XmYLmrU3Kdrhg/PE1pRJ/s3fgxfLGCLAF3Df+A2I83V0FQpUgGcjAwXyRMD8eszow4P+0SA7JsDLpUdvpTB+qLE7JTb/SfCFtrZK60tOvcSqLFXZD7mJnxpGFBIkr6nLYROh4Kvw8W/N8WlMD8bf5GJExEsrjczItZc2iWruj422giKD6+i6kW9YAg7NhoiqaGRo15/LZPluLaXrrlX+BucwX7Dzh1lp/5a4t6xY80cFeRS5+zqbb2dkYww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DkejRWbyavecanRnkRsl1sUZjGTfP4QY8aHRuz5NLfE=;
 b=Uvgu1QC2d+VkCijbYMJ1l3j0zfjJKTxrO93tBB+6Iv/Wxs+0J+NNnkY6SoI/JmUtwZ/XsEnLcLngKihYILaEnTWP9qP/E52Xofs736Mc0gOF/+yOwI7rmxfqeGh2G6sL+5EpeS47aa/nK4yEyffgJTCYRpp9Y8JkdrtF5o8o41sZg5HAwCJReWX8ZnaLTximnA9mLeaWU1dTZszI06HlZ553WeMd2OywF/6qDR1s9nsVKD0bXo2FKuZXhWwUV9Pbwobi+1IBd+hjWRvY9myo0QXVqkC7A6U3XXBs7L+Iqbl8O7JV8DNIrLfhn7q70TsLKcdpsZpI5BnJAQG1/mgQ5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DkejRWbyavecanRnkRsl1sUZjGTfP4QY8aHRuz5NLfE=;
 b=X5aHslJaeNrRbhiD3W+Q3SG7Hrq2bLf7bphW9ofpOA5X87pD4vm3hEouvUOXkiaXwOPKhOc55efh2xHO75BHAa9/zlBg17wsmCLVZyS5Z+BOxUUobjuav0Eju5oDGfrvMRl0TQL4/bs4XiRzv/xpk6nfGqUsGAgvURYDCbhImYM=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by CH0PR10MB7411.namprd10.prod.outlook.com (2603:10b6:610:187::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Fri, 18 Oct
 2024 06:37:56 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.8069.016; Fri, 18 Oct 2024
 06:37:56 +0000
Date: Fri, 18 Oct 2024 07:37:53 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Jeff Xu <jeffxu@chromium.org>
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
        akpm@linux-foundation.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, linux-hardening@vger.kernel.org,
        linux-kernel@vger.kernel.org, pedro.falcato@gmail.com,
        willy@infradead.org, broonie@kernel.org, vbabka@suse.cz,
        Liam.Howlett@oracle.com, rientjes@google.com, keescook@chromium.org
Subject: Re: [PATCH v3 4/5] selftests/mseal: add more tests for mmap
Message-ID: <c56aac50-83b5-45f2-8ddb-6980c22c059b@lucifer.local>
References: <e7ea2b84-8d10-40fe-a14f-837bca851ea9@lucifer.local>
 <fd927106-2fc3-4b96-8014-2c517229bc99@lucifer.local>
 <CABi2SkUpCf+aOa2sPED8CosG5ccqjFd7ouot8gXi9ECqsHiZhw@mail.gmail.com>
 <4944ce41-9fe1-4e22-8967-f6bd7eafae3f@lucifer.local>
 <CABi2SkUgDZtJtRJe+J9UNdtZn=EQzZcbMB685P=1rR7DUhg=6Q@mail.gmail.com>
 <CABi2SkVEMRHV3swrbb6M5RA6GQpFVVx855CGwdQ1xiz3tygiqA@mail.gmail.com>
 <f9b9422c-216d-422e-94b4-d8814b0b277e@lucifer.local>
 <CABi2SkWAv4LXvR1Wb1e31eyZ35JfyieXhDOq1bp_ZvHPLLg-qA@mail.gmail.com>
 <e0f440b0-5a45-4218-8c51-27f848c0617b@lucifer.local>
 <CABi2SkWNRTCC0LzDSuzgjC1tO=KF==5FXUnPHOrPzEG5abAeDg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABi2SkWNRTCC0LzDSuzgjC1tO=KF==5FXUnPHOrPzEG5abAeDg@mail.gmail.com>
X-ClientProxiedBy: LO2P265CA0023.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:62::35) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|CH0PR10MB7411:EE_
X-MS-Office365-Filtering-Correlation-Id: f3495f57-679f-4d5d-b77a-08dcef3f66b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?d3BkeXF0TU9LT2NHRWJxcXlkTDdhelFJZ3pYeEFpaU1jVjJCV3Mvd2UzN3Jz?=
 =?utf-8?B?OSs2ZUE4cEhtUTlKNGhNKytrZm83MDlteHV4RHVyQWJQcEkwdDRSdlUrbzY0?=
 =?utf-8?B?OUF3aWlTQy9CN3RzT3BJQVI0NTdmaUlxTnVzWWdyR21tODNsVldpMkI1MGdY?=
 =?utf-8?B?NGcvMnhKcUY5blhWWE43MGZDY2JHZzFBOFVzU1cySHpYaXBlWTRiNEhyS1Av?=
 =?utf-8?B?alZVdXQ0MmkzZUFpZE01RjhmeDZpbnF4aHNIYlNmaWpDVEhmZHBMbDZNTEVo?=
 =?utf-8?B?OHFoQ1gvNmJBQi9vcTREakNyaVhHR2poci8zRVVyRXE1Z3lmVngySjN5bVVu?=
 =?utf-8?B?VTh3aHNBMmFGc0NjWDQ2ZnZEdmdYYTVPUXJVU3Y3MDBtbk53NXJPei8rYU1m?=
 =?utf-8?B?d3R1TnVKL29rU0twWHh4QTlBRVFFN1haNXNYMWtlUzhMTFd6T2QwSDhaR2pz?=
 =?utf-8?B?U1Y0NlZEL1dpOGFoWlEyNDZYNXp1Q0M2SjVkQ3pkUEhYVE9lMm9aU2dwUFBw?=
 =?utf-8?B?MkdHVFJCK1poU0I2WGY1VWorV2VJU1BYVFlzMldRNjBPcmI3R0t1OVRyUzFm?=
 =?utf-8?B?T0ZkNFVHVTJoS3hIV0plUzAyN3JaTVpKREtaT0lnMnBMRDNjZTFYK3crY0ti?=
 =?utf-8?B?cERQVVRtSUFrd3BZUlhENWZoRFIyNTMzZW9NS2tFNEExY25HNVhxV1k5NkZ2?=
 =?utf-8?B?S1lGVEIrT3BmYmxRaVpaQitYWGo0S0tFMlIwUzc3TUw5U3lCN2d5ZWlJd0dn?=
 =?utf-8?B?ZkoxTHJmZlZvMHAxdUp1N0lJN2dZblJ6MVRHQW9BdlJDZEJ0ZXdVN3dPOHV5?=
 =?utf-8?B?YjNIeVBBcGlWOEhkSm51YTVXSzZ0RFc4Z0hWbVZVZjRHUjF5cHdldGVmRlEw?=
 =?utf-8?B?TGpuVVJiV1ZtTEtMNTJNYSt2QnN1NW44enN0eVhuenFHNnlVdjFkUzZhbjV6?=
 =?utf-8?B?amVVSk9jcjhPSmJDU1BaVWpMK3BEWjdHZEFXZ1QvUkVWaUZYQzQ2SFF4UXVJ?=
 =?utf-8?B?a1BDS0RDdDhjR1djUnljK0JWZi83S2J3Y2huMGRpWW1iMDJDSk9ucjVkbWUz?=
 =?utf-8?B?eTFDR2ZDZ0F0RlN3SCtzUG44ZFhqRGRkT0l0MHkwcEx1bzJLRi9KZmM5NnJC?=
 =?utf-8?B?SU9SelhEVHBLckdaeTdPWHV1SEhoN2xndW1yY1BhUVRnNHdTNEYraFZQM0tT?=
 =?utf-8?B?ZlFmZDF3aFQvNkFWVDRtWHZCeTd6Mmk4cm01VXZQcENNUFozU1NpOGp2YTkv?=
 =?utf-8?B?MVNQWkNQMVE5UHY2VGMwVFkwMW1QUXhiTG4xaGF4aXNOeHhUNmpjZzR5U1FF?=
 =?utf-8?B?bVNTaTdwWWNoK1RqRkYyWkxMQ0x3R3NiY1BEeDZWSlNxc1cyMitZcFNiWWJY?=
 =?utf-8?B?djl4M3d6TkVMQXBNa0lGaU05bjRuTXhSUFIzUHZ3WDNGUk5BUUIzWHFtWm4r?=
 =?utf-8?B?VzVhT1QwMGRLNGlIbnJRRXVmeDBEcU9YU2ZFYklFa1hsMmFoZ1dweGtUWE03?=
 =?utf-8?B?L2lDSWp3cHA4MUx4SFZuZVJ2ZzZzY0VOODE0Rm15VW03TFk1alVhbEJaYW9s?=
 =?utf-8?B?TnlUeTVzdUhLcHhEQUxqZ1NGQlJiMnNGODNITXEzN09yM3RMZmdNNjVZalEw?=
 =?utf-8?B?Uk1vRXZJbmsxOTlSVE5peFQ0bmYxc1Y5OTg5L1FENkFmMWMwMlZ3dWhiaTJq?=
 =?utf-8?B?R2FpczZ3MHpWZ2NLUGFtc2NyQnZOTm1oUmswVFh2NHo0alRNa0xYRUc4V29E?=
 =?utf-8?Q?LK/Qa8xFiAkZ1D0k9SiqcfZnzOn8kcuxsI8sCvO?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RU90cTJucjFJTHlJZ05RTmZyc21nWDUwSG9kWW9xZzlRU0ZmUlRiY1l3TjAz?=
 =?utf-8?B?VE5oUnBsNjFKVWdGSHRQTnFIakxvWnE0T3pTaGI2TFZkTnMrUS94NGdoaEZ6?=
 =?utf-8?B?ZXpCUlcrQS9ZSUJUeThUeVVES0hwQzY2NXhHYmxBa25rT0xCa05BLzNad0pE?=
 =?utf-8?B?REpXS0pLWDZ3UVhyZEVzajN3dFl1NGoxSGNYMGxmWUtXU084RFBodUNZbTFV?=
 =?utf-8?B?U0phVWNiTHRSYmtHdkhYNVZNOE8xL21rQjlqZFBzUnRKbzlhb0x5WUE2NDlW?=
 =?utf-8?B?ZVQzZCsxdVFrQy9DOVR1R25ybmRINmF2UkdZbkplM2RlTTFuQVlzSmhtS0ln?=
 =?utf-8?B?Vlk4Mk1tKy9aaWRuT3RWSlJ1WWtraHRONXllSmJwR1piSERlSDc4YUdacGVj?=
 =?utf-8?B?bGo5VmtrY25VdVFmem1Yck5pK2hzT1VtK1JaK2FaZkErMEZSR21QMHFVQVZz?=
 =?utf-8?B?Qkc4WVFEa1g4OVRWS3A1SmlaUjkvNjlhcFNkQkhkUlhPVVllZWxxdy9QOUQ3?=
 =?utf-8?B?NkVJVUZCeFJPUGx1UVpGcEdkM1J3TnhSTzN5aDlnQW9zbEx3Nzl6amRUSjRX?=
 =?utf-8?B?aVhISWV3eHFvZWRQcjFQQXkybFE1eGxSSFNLN2hBb0FaRmFHT0ZPamVQOXFY?=
 =?utf-8?B?Z3dEd1ZwekRvL05aNjQ4ZGtMQnMxc0VRR2U4M25nNjkrTWk2Y2RoOFNUVnE0?=
 =?utf-8?B?YzF1WHJadFlrQk1IMnFxOHFacDRPeWFDZ1BQdTdaVDRTaUw1Yng5eUd5dE5v?=
 =?utf-8?B?MWg4Y3dZb2Z5dTZkczdybWhWWk1UZElZWWlqNnBxVHVZd0tNK1MrTUcvOGlZ?=
 =?utf-8?B?WEpsOFBESmdmVVYxUHBQdUZ5NHZrZkVvVFNWNGJnK040Mm9yL01JbEUzUmNp?=
 =?utf-8?B?N1k1a0ZITExLcjkwNXFac1ROODBvNVhJNXE2ajNuMnRaakEyd3dMMUxJVERQ?=
 =?utf-8?B?UmhPM0k1eGcxK2FLcDBpaXlWWTVtcnVTRFFoU1NnUkZjak0vY3BhdFp0OHRP?=
 =?utf-8?B?L2tSVXhMTDkvODluMkFhdGxwRXR2WXU2Qk5nM3NHblZrc2VubTlHUkk3YXNC?=
 =?utf-8?B?NWJGOS9ydm9JRDBlWWhvTU1OYUV0NGhwMHVwK2U2MHlBL3RsVW56cFpHaG1p?=
 =?utf-8?B?SE84dlloWkQ5aWFTRlY5TG5zZTZNSXN3bmtlUmw4Z3FncHVZbFc5SDYyczQw?=
 =?utf-8?B?aUEralRlVk9zazhHYkRtYVNlNVpxRnF0aWwrVk4vZkdIdnBYbG13ZXVsdEp0?=
 =?utf-8?B?Tm9Gdy9YZnlPOXNFOEZBeXl0YmcyenpOZHEvZkk4blJ1MXBhWmpWTEgwN2NY?=
 =?utf-8?B?UU8zKzVyRVdWT2ZZZmtUb3hnYVdDYThGa3V4NTEzT2pCNmpEVFhuT1RTOERO?=
 =?utf-8?B?Z3F1enk4WlgzR3c3NGJyRTF5cHNiRFRITEUvU1dxZUNjTlZSRlE3Z3E2UDBI?=
 =?utf-8?B?ckpHZVorM2lQVmFtTFNkaEZTSGR2Vk41T0wrQVJvQ2NmdFRtNFJKZ2dwRVpE?=
 =?utf-8?B?a3JGV1AwUTQxclk3bm9wNk9iRW55Q3JIOXZKMGUzbVhNYmRObURHaEtlZExE?=
 =?utf-8?B?eTJoU2ltVlZGRkpJa3pac09UcENTQjRZZk42ZTcxR1FIQmhFYlRONm4wQmR3?=
 =?utf-8?B?d0pNMVRndWFIK21uNU03RElZanM2TzN6TWR3My9aWmRCQkdPbm9BR0JXSDd3?=
 =?utf-8?B?VzhFeFdGR1NjMzc0VWovU3U1eEZ4OEJ4Sko0Vll4Z0JKYmhPSjljN1B5OGV5?=
 =?utf-8?B?eFF5WTRHRkJaUm1zRnRrU2xMQmUyTFhhMkJ5UmFLdFhXQ002b3pJV3FjRlpL?=
 =?utf-8?B?RDlaYTQrRG8zbGRoVnlRa0l3REhnR2MvbzhMVG10ZmQrTVJvQ0dpQ09IL3ox?=
 =?utf-8?B?Zis1eXF3dUVaR1pieC9SMU9Cc3M2V29STGFKYThwRnJ1Z1F4L3U0bFh1VXRH?=
 =?utf-8?B?TjZrSzlidjNCbzd3Um1sT1pPVm5qSjRzYjEvd05QclhaeldpVHZMUWZvMDBH?=
 =?utf-8?B?UXZHZUtRR1R1a0ZUU3ByOUJWMTJDc2dqanZIUndJNTlZOGNPclJxMCt3QU1V?=
 =?utf-8?B?c2tTa1l0aS9PZHpscElrcTBGaVdQNmMxb0hYSTM3R0ZLL3p6aExDM1YvNlRv?=
 =?utf-8?B?K1cwYzVqSGliR3B4Y2tuTlRuK2c0eVZqVWFSTkp4eEJrOXNObDFCdmpCY05V?=
 =?utf-8?B?S21wSjhrWG1USUg4Y3NtanVBSjhZRHBFV0dFVmVWZVZmTUNuM3B1Q3FoNDN5?=
 =?utf-8?B?REE0VEZpM2lBRGdsRGc1ZjJ2MXVBPT0=?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	nq407mRsOn0oqjjZ+CJCQ4FREVy+j/EbBr2Dcr/juPmi4KWjGDUpnn5PaBfdI1e/C8NBF3qp7JO3yp5yOAw86W98wv9dFBuV850LKe+h4F/tpMUXFVYGtw4lyHtlefey2eQqg0Wz9S35NdnhVCDP5ms/YAQAE6lPn4LUF6FaCM0VXWvLkBJdUh+JGWnVG46/MwDXALhv+wlSGPlmpkAspJQ2CRq+ObtACnTmBGm04EPz6FkHREHa/0o+jHCrqX9Ep+7PR2nxnB3+KjE3hzjVSN3Fg5cVU+95s/zsc9jVPqy+lVxXzAcvHfQKIua9iwwNbKcP5AzDVvudigZhtdlzKX6rCUZU6GdeCZoR54JFNnAXpeO3/1p/nWq2AdLHo9RvxWY/Jkdu7fW2LY2DXi5tvZTtIF5wcw9Ol+zwLsf/DYqOnsrn5gBKg7/jFz1IWqLYt7v7QuVKoma38sus5tqzA4aQw1e2CeqnRsdQYBxvCaealox4Q60341yJtIRxzeXhHQyLXxRgjh/2cqTMlNnJC0Ld1i0L+ORQPqZkD6l3w+a/WgjYQjNjOVUJzMsPGXc5GmKOhhH7MA/kP+7QeCZ4cXVZhKUkjJrOjfCvyJK53oU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3495f57-679f-4d5d-b77a-08dcef3f66b9
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2024 06:37:56.6529
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bYPywF164T8nVUSN3rVZqsL7qsZbKGljPHbDzWbYRQe4zyPvdQjdDrw0reiCgjDxFZjKHmPmyTqVqv3BdoX+R0O4aB1/hf6YvJiDmN8tTmc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB7411
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-18_02,2024-10-17_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 adultscore=0 spamscore=0 mlxscore=0 suspectscore=0 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410180040
X-Proofpoint-GUID: msZM7E0IUVu-cN32UJNMRsd_mMq0QpYu
X-Proofpoint-ORIG-GUID: msZM7E0IUVu-cN32UJNMRsd_mMq0QpYu

On Thu, Oct 17, 2024 at 12:49:40PM -0700, Jeff Xu wrote:
> On Thu, Oct 17, 2024 at 12:00 PM Lorenzo Stoakes
> <lorenzo.stoakes@oracle.com> wrote:
> >
> > On Thu, Oct 17, 2024 at 11:47:15AM -0700, Jeff Xu wrote:
> > > On Thu, Oct 17, 2024 at 11:29 AM Lorenzo Stoakes
> > > <lorenzo.stoakes@oracle.com> wrote:
> > > >
> > > > On Thu, Oct 17, 2024 at 11:14:20AM -0700, Jeff Xu wrote:
> > > > > Hi Lorenzo and Muhammad
> > > > >
> > > > > Reviving this thread since the merging window is closed and we have
> > > > > more time to review /work on this code in the next few weeks.
> > > > >
> > > > > On Fri, Sep 13, 2024 at 3:50 PM Jeff Xu <jeffxu@chromium.org> wrote:
> > > > > >
> > > > > > Hi Lorenzo
> > > > > >
> > > > > > On Sat, Sep 7, 2024 at 12:28 PM Lorenzo Stoakes
> > > > > > <lorenzo.stoakes@oracle.com> wrote:
> > > > > > >
> > > > > > >
> > > > > > > I also suggest we figure out this FAIL_TEST_IF_FALSE() thing at this point
> > > > > > > too - I may be missing something, but I cannot for the life me understand
> > > > > > > why we have to assert negations only, and other self tests do not do this.
> > > > > > >
> > > > > > My most test-infra related comments comes from Muhammad Usama Anjum
> > > > > > (added into this email), e.g. assert is not recommended.[1] ,
> > > > > >
> > > > > > [1] https://lore.kernel.org/all/148fc789-3c03-4490-a653-6a4e58f336b6@collabora.com/
> > > > > >
> > > > > Specifically regarding Lorenzo's comments about FAIL_TEST_IF_FALSE
> > > > >
> > > > > Muhammad Usama Anjum doesn't want assert being used in selftest (see
> > > > > [1] above), and I quote:
> > > > > "We don't want to terminate the test if one test fails because of assert. We
> > > > > want the sub-tests to get executed in-dependent of other tests.
> > > > >
> > > > > ksft_test_result(condition, fmt, ...);
> > > > > ksft_test_result_pass(fmt, ...);"
> > > > >
> > > > > FAIL_TEST_IF_FALSE is a wrapper for ksft_test_result macro, and
> > > > > replacement of assert.
> > > > >
> > > > > Please let me know if you have questions on this and Muhammad might
> > > > > also help to clarify the requirement if needed.
> > > > >
> > > > > Thanks
> > > > > -Jeff
> > > >
> > > > Right this is about not failing the test i.e. equivalent of an expect
> > > > rather than an assert, which makes sense.
> > > >
> > > > What I'm saying is we should have something more like
> > > >
> > > > EXPECT_TRUE()
> > > > EXPECT_FALSE()
> > > >
> > > > etc.
> > > >
> > > > Which would avoid these confusing
> > > >
> > > >         FAIL_TEST_IF_FALSE(!expr)
> > >
> > > FAIL_TEST_IF_FALSE(expr) is the right way to use this macro.
> >
> > But you don't only test position conditions, you also test negative ones.
> >
> So it is not a problem with the MACRO, but where is it used ?
>
>         ret = sys_mseal(ptr, size);
>         FAIL_TEST_IF_FALSE(!ret);
>
> Take this example, it would be
> assert(!ret)
>
> The syscall return usually returns 0 to indicate success, where a
> negative comes from, but dev should be so used to (!ret), it is a
> common pattern to check syscall return code. e.g assert(!ret)
>
> Or do you have specific examples of code that caused confusion ?
>
>
> > 'Fail test if false false thing' is really confusing and hard to read.
> >
> > I struggle to understand your tests as a result.
> >
> > I understand 'fail test if false' is expressive in a way, but it's really hard
> > to parse.
> >
> If you just read it  as assert(), would that be easier ? (or you don't
> like assert() ?)
>
> > Obviously it's also misleading in that you're saying 'fail the test _later_
> > if false', which I hadn't even realised...
> >
> > It's well established in basically all normal test suites that:
> >
> > * assert = fail test _here_ if this fails (actually a valid thing to do if
> >            you assert something that means the test simply cannot
> >            reasonably continue if that condition is false).
> > * expect = the test will now fail, but carry on.
> >
> > I mean you work for a company that does this :) [0] this is a very well
> > established precedent.
> >
> > [0]:https://github.com/google/googletest
> >
> Let's use expect as an example, let's say I create a new Macro:
> TEST_EXPECT_TRUE, which basically is same syntax as
> FAIL_TEST_IF_FALSE, I'm not sure how it is different: you still have
> !ret in the code.
>
>  ret = sys_mseal(ptr, size);
>  TEST_EXPECT_TRUE(!ret);
>
> Or is the FAIL_xxx_IF_FALSE pattern more un-readable than  EXPECT_TURE
> ? maybe ..
>
> > >
> > > It is same syntax as assert(expr), e.g:
> > >
> > > man assert(expr)
> > >        assert - abort the program if assertion is false
> > >
> > > FAIL_TEST_IF_FALSE is a replacement for assert,  instead of aborting
> > > the program, it just reports failure in this test.
> >
> > So doesn't at all do what assert does, because that _does_ terminate
> > execution on failure...
> >
> I don't know what you mean, the test case will fail, but the next test
> case will run. This the point, the mseal_test continues to run all
> test cases to finish, even if one of the test cases is failed.
>
> > We are writing unit tests in a test framework, let's use very well
> > established industry practices please.
> >
> > Also note that you don't even need to reinvent the wheel, there is a
> > fully-featured test harness available in
> > tools/testing/selftests/kselftest_harness.h with both ASSERT_xxx() and
> > EXPECT_xxx() helpers.
> >
> The EXPECT_xxx() doesn't take care of reporting though,  or maybe it
> needs to be combined with FIXTURE_SETUP, FIXTURE_TEARDOWN. I haven't
> spent much time on those, but on brief look, it seems it is for
> repeating some tests, which doesn't exactly fit into what I needed,
> e.g. the sealed memory won't be unmapped.
> It is possible that those tests can be adopted to use test fixtures,
> but I don't see significant gain for that.
>
> > I've used it extensively myself and it works well.
> >
> > I'd basically suggest you use that. Though moving existing tests to that
> > would be some churn.
> >
> > On the other hand I really can't accept patches which are totally
> > unreadable to me, so you'll need to fix this one way or another, and the
> > churn is worth it as a one-time cost to be honest.
> >
> > >
> > > Is this still confusing ?
> > > (The FAIL_TEST_IF_FALSE is already a descriptive name, and the syntax
> > > of assert is well known.)
> >
> > It's a super misleading name as it says nothing about _WHEN_ the test
> > fails. Also the syntax of assert() may be well known but you don't call
> > this function assert, you don't reference assert anywhere, and you don't do what
> > assert() does so, you know, That's not a great example.
> >
> > The semantics of unit test frameworks are very well known, and already
> > implemented for you, and also do not require you to do unreadable double
> > negations for no reason, so let's use those please.
> >
> As stated previously, I'm not sure whether the test fixture is
> benefiting mseal_test at this moment.  But I'm open for future
> conversion when I have time for this. For now, I like to get those
> tests in so we can properly detect  possible regression for memory
> sealing.
>
> What will help you better review this code? Would the below help ?
>
> s/FAIL_TEST_IF_FALSE/TEST_EXPECT_TRUE/g

Jeff, you're falling into your usual pattern of being unreasonably
argumentative for apparently no reason and I really don't have time to
constantly respond inline when you're just ignoring what I tell you.

You do this on nearly all code review and this just isn't working. If you
want to effectively be involved in mseal you need to LISTEN.

The more you do this the less patient everybody gets with you and the less
likely your series will ever get merged. This is not good for mseal or
anybody involved.

On this issue - either use sensible macros that YOU ARE DEFINING, not
assert.h, but YOU, that allow you to evaluate whether a condition is true
or false - or I will not accept your unreadable test code.

It's that simple and I'm done discussing this.

