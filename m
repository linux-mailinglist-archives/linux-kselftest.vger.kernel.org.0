Return-Path: <linux-kselftest+bounces-14600-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DA6F6944699
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Aug 2024 10:28:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E0EBB21D4F
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Aug 2024 08:28:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D51B16DC20;
	Thu,  1 Aug 2024 08:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ntc1lV2D";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="KeGsfJ+w"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F74216CD09;
	Thu,  1 Aug 2024 08:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722500891; cv=fail; b=AmEABm8Urr1lk26jwua/B7Nj+dmp21MLmsYcoxw2WKXm/xt8LH7mgiNDM0wP8DDq5s3p8VPQhYT0vquaFkvpWODxzQ2PUm3GyBYMVJtBY5IIFvtLLvxXwOBaYC54Xo6DJynP7BQAfF+lh95VRCwdh46V1hBPXmB8CZMDT0NXOmc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722500891; c=relaxed/simple;
	bh=H5Fb9HKtlDRR8DVyJsC4b8GYFoOResx53of7V/J1Mdw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Rb/CuQ0ERY4IXbK1z+2/AuNg3xdUNMo3VvQoF3ef7JoKYSmtPKX0jBco//efOX/S9XFuKdLPjIkUNGtB2f03s5KL3y0V/+OQbZeebHDB6To0ccnNywxnx/fQwVVFyyIgc2A4R2kQIhKqxKwSQ1wvp6JllzJU+8X7WoZeeIOa/zU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ntc1lV2D; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=KeGsfJ+w; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4717tVxY030723;
	Thu, 1 Aug 2024 08:27:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=6S1TZ2xa4CknKgpFa+ProJxdnSsFYm5wiI8HkUH4ILo=; b=
	ntc1lV2DtNvxF1IDAR8G0kAnDd+z8asXGH0vo3FoNaPpkhVf86LQWS80FDzgwkFv
	GjX0/1KHVTZzELS1GQ2u9w7ttMpkvrfjMGn90D5ig12WaBhxs/gFEXHjv99KBX3y
	qgRLtEwnCZHxf++cI0rH8JEa1wM7ffe2BjpBxbatxe434BpRVJzhdMQUFJg/nqjG
	U4OXbicTCYaasqs2m6vSq7HFmLNcPfBTcpf55X+Zxgly62H+3z9dWyuhj7BYVjvf
	KN39G0YuwmaIkRVCOtHLlTTewA5G5KHQF3yR/pI+dv0OS3m0G/yiBTgw/ksHPFbi
	c6BLVQ+TicXj8k9JPCJD+Q==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40msess6tj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 01 Aug 2024 08:27:44 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 4716uW39030739;
	Thu, 1 Aug 2024 08:27:43 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2040.outbound.protection.outlook.com [104.47.57.40])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 40qmpspqyq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 01 Aug 2024 08:27:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r1JBgN3mDW/kFcRtIrXuMIw+9vGP2FuNhILVBSuGvJbEKVAhzhrIZ16nBgEzdnqj5FDdnO1Xd30305rFyI8V7jZU+EUSwUYtcKaRZlrQpcvzAje6J+UACtLf+97FlPXccNSfQxit+8E7PttnAhDqoAfd8qBrFzKuH9Fk/aVBBQIZ/1u/StAwskwc0j3yiLmhBsJ18wmkmmNcNjp3DYIC+NYGD/l+H8Bp3GNtTjsB7O7clAjXC180Ea4LK2ugYuwfM4p/h8iKERESH+XuKrv6M2oNBP91ppTIaSh3RqoCiv+shoMTl8FCfq/VPINb0ddZvy3syOxi1caZQvi57TVrJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6S1TZ2xa4CknKgpFa+ProJxdnSsFYm5wiI8HkUH4ILo=;
 b=qWZtaXNxWtcqrqLgPKnFOMziy2tIClwXGd6eCR49iontcZyggR3W7AXcMvBpKGWtXCQLS0/ERmB89Yi+5DhKZkpZ+omzcyNjafK7aOO2WHnzRCbK2xJl+i7ch0wpGIpPDDT7FGdPfq0MSjp4DxvMR0sChzMzGv6PFVoIY+dVmfK5YSYkFeoMWe8a8koIgrjXvTCF44ghlSUk+VNgIVAjjeHqY+0pp+CLPn1rMUy7id4tqX/9ZkjoENw7uzezlCpJYsvQ3ncWHeDie55QQ6W/HgOmVYie7IoU5YkcYZ+YWHivcSnJatLW8cMZiDm23a0dh3/O8zVsfpPy2N5FHocNpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6S1TZ2xa4CknKgpFa+ProJxdnSsFYm5wiI8HkUH4ILo=;
 b=KeGsfJ+wldqCHb4SGbvs96/3NN+KJi5ca8qGLTBw3IJYm1Ljdopwk4YkeyykTKbCq+//rDVr8AojyjY0it+J4TehVTZU6HYvgNIX6AyWu3yDFtu4tpQsKHmiIn1ua9y7bq3N2eFDJkGL46OFYv7rUJ7aynODS/PmrLHkRDCF7II=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by DS0PR10MB7479.namprd10.prod.outlook.com (2603:10b6:8:164::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.21; Thu, 1 Aug
 2024 08:27:41 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f%7]) with mapi id 15.20.7828.021; Thu, 1 Aug 2024
 08:27:41 +0000
Message-ID: <295cb8d1-89cc-4528-b255-f7d815f20a24@oracle.com>
Date: Thu, 1 Aug 2024 09:27:28 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 2/4] selftests/bpf: convert test_cgroup_storage
 to test_progs
To: =?UTF-8?Q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?=
 <alexis.lothore@bootlin.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>
Cc: ebpf@linuxfoundation.org, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-kselftest@vger.kernel.org
References: <20240731-convert_cgroup_tests-v1-0-14cbc51b6947@bootlin.com>
 <20240731-convert_cgroup_tests-v1-2-14cbc51b6947@bootlin.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <20240731-convert_cgroup_tests-v1-2-14cbc51b6947@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO2P123CA0005.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:a6::17) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|DS0PR10MB7479:EE_
X-MS-Office365-Filtering-Correlation-Id: e3e8d53e-a1d6-4286-6e92-08dcb203cf2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Vk1GeUd4Y2F6WXhLcEV2dk9wdkVQck5OTlRmQ3ZXRHM5aVZXQnRYdDUrSm5m?=
 =?utf-8?B?WGp2L0pOZzFIUHJ5S284RlJSaGNFVjZXNU1wZDhlQWx0aSs4WXdKTlgxcEkx?=
 =?utf-8?B?YVZveG9ObGMranJsb2hyMUtFUlNQMy9HNmhiVmZHalMrdFl2UHZoMDFYYVBU?=
 =?utf-8?B?ZlhNbWdJWmxienNSVXE1T0VRLzhqRWN6Qzhtai9VRm55Y3N2Qi80dUk5WHBG?=
 =?utf-8?B?VFpHU1MvM2RKam5sa09lWng2Q21pTlBUVUpTM0RqSXRPbDZScE1IMzUxM2hO?=
 =?utf-8?B?aURYTmVtbWV5U21nVVhVVU10OXQzQlh5UzVueXNQM1gvOUQ0dlBTNnMxUW5x?=
 =?utf-8?B?L3dwamtLekdQRXN3anNpMnlWWXp6MHphQTFkOTZmY0JNVUpCbDZVRC83dXNY?=
 =?utf-8?B?b2tzRWJHZHlMOTg3Qm83MFRwQVdIRTFPNTRoWS9uOUpBK2xCaXNobHI3QjM4?=
 =?utf-8?B?RkR2cnA3QWVMdzRBWmNtUEx6WXN6ZDZxZ2hqTC9hMmlrN0dEK3Z4MTVGbWpN?=
 =?utf-8?B?cGJEc2cwME9oT3Z6cWVmSmZqczV1R2JPd3hJTFFsZHo0QXkvd1Q2SU1mRTB5?=
 =?utf-8?B?dy9JNEc0b2NkSnU4d0t3aFROWDdrbHd5WjN6UlhHaXRidmJyQUZaenRmVXM0?=
 =?utf-8?B?aGdXdDd0RkpRRGtWWDU3VnpuaHlnYWl6UmJONXdpcmh0bmFaSkQ2KzRFVkxD?=
 =?utf-8?B?cFFLcktGMG5tNXpWcnNXTG5QMWR1OG5LT0ZrSGJRc09CUFJjRUZKK0tWMWdJ?=
 =?utf-8?B?ZUphZHJzNE1jbjJWaXJKZmlUVmFUSXlBeFdVb2xCc3U2VFNWaEgrL1VKdGor?=
 =?utf-8?B?QlRVTkVNQXdvTUowVVNxOENKVnVuUzYyWUJZVE9vcUc1b0dkaHpyQ1l4dVBE?=
 =?utf-8?B?V0lXVFo3NGdUd3lZYUJQNVhER3gzcnFwQlBWa090WGpySXY5SXQ1MTArM0Y2?=
 =?utf-8?B?Nks2Smo3TzNLV3FyM1FtdWV6elFTZWJwK0pZb2N5OEVwbGlvOElhTjByUXlY?=
 =?utf-8?B?TVpjOVhzeTJrZXpIdytVQXBHdTlhY29COWZhRmptSjRONklTY0NFeUpzY1ZV?=
 =?utf-8?B?Zk1ueDRJbnZBK29wUTRZdE1xdTh5QU8xS3dtaDdITDBLeWZRdndqR1o4K3BW?=
 =?utf-8?B?U21lT2xLUWgvQncxamIrK01Tb2JaQ003ejZ6Q2p5Wkl4OTRPbExJaTFncCsr?=
 =?utf-8?B?LzVyY1QvNkdvbm5DZkY2b0V4eUhxdEJpaCs5UFBMZGRwYkdlei9BakozS0lC?=
 =?utf-8?B?RmJhZ3NKM1dtUE9ORWJHWDMxN09PNzFQelR6aWVkNURKeU1na25oa2lKbGVr?=
 =?utf-8?B?Vk1sWDVXU2NvR2ZCaVhmdVNmTFBiaWpQTlJuSitZb2MwbnZ5OGZvZmJPYzNB?=
 =?utf-8?B?Sld3YVZHajE2Y1B0ZXpEQWd3TUltaHllaGN3UHpOaTN2RUtxMFpwWHNhU0tt?=
 =?utf-8?B?eTc1ejhWQjV6MHRMVittdkx5bnBZbUljT0pTc0xhRzYzdGVTLzRSc3A0MitV?=
 =?utf-8?B?TmxvSW11dC9jUmU0NzU5Wng0SE9QRUk5NlFtOThFUXJWSjJBWmh6MzJFVHZC?=
 =?utf-8?B?QTEwVkczZHhoazVldFpzb2NjcjVTSTJiMVIvSzgzQk5yRTJyY1V5UllNNUJO?=
 =?utf-8?B?U1NXK3czNnphZzByZ2szell0R1c2dDQ3WmExZm1Nb1FHcHFEQjVrbEZEQ0JY?=
 =?utf-8?B?Ym1kUmNFdFZoVGUzTndiWnE3alI2Q2JPRFF4alpFME9iV3A0WC94RXdjZmlC?=
 =?utf-8?B?TXdVbkFZOFB2a1BrS3N6dkp0WW1JNDBOc1R3VG15ZzhLK2xVZE95R3ZRdVdn?=
 =?utf-8?B?M255UXFUL1dTUVM4aGt0OTRxUlc0L0kxYWFlR0kzT09uUWlPRUN1UkRtaW9C?=
 =?utf-8?Q?9q7Gb4fUPjFhX?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VVg1WGorODRYV1FuNXRMWFN3WlBVd29BcStST2htZ0RUTERORFh4c1lKN2sv?=
 =?utf-8?B?ejRGcC8zY0ZDS0RObnZQT0F4U0lRZ2ZJSGt0cEF3NnY5RmhMaGlyNS9wL1ZM?=
 =?utf-8?B?RVJBY0JIQzBoazkvK0lHMnVZWkVEQXRURTVTKzJFY1lmNlo5dXU4RkZzL3pF?=
 =?utf-8?B?Wkl1eklTMzFJaWdLVU91OEJLaXh0em5kaTE0S3hhdEJMK1pxNnE0Wk5hWXUy?=
 =?utf-8?B?NldBQ1JwZ3RqeEhWT3cyUS9kTG9GcWNtSFpCMkt3enp1dlBvRGxmSHE5N0dJ?=
 =?utf-8?B?RUJMaWM5dW9LdWFzMElhM3VpcFZIN2wwSjIxK05TVlUzbjdJc0pvL2hDdHFP?=
 =?utf-8?B?MlJacHlIM1QxUDVFUHdpNEJtWStkQS94aFFuK1dmTmJ2U3JQMjRPTmU4UmVo?=
 =?utf-8?B?VU9kRmFVTXRpNCtuTmZ3Ly9rcGtKUXExaWlzRndRcXpzTGVnMHJCTk84REFY?=
 =?utf-8?B?WUp3T2FzS0w1MkwxaGNGK0h4UHJ3N09obndrN0tZOCs0a0tEQm9IZUhxSkM2?=
 =?utf-8?B?Mkx3ZTlqWnRHc0gwenc3UGVGQ01IdmozZmV3MFZRaDFLWFcxSUpOQTQrZGZr?=
 =?utf-8?B?cFZFUjhkZ0RkZmFwZVFEYXVEekxrSFNNMmh5L1hBUU9BNTlVVzUxeUF1WHMy?=
 =?utf-8?B?NGhxeDVNL1k5VVNQWEV2SWtQak50OE50MFpMV3RJK0FubCtrcGFrSFRoZmk3?=
 =?utf-8?B?NndXQlMrb2pWWWhEdDBBRFJXKzY4ZkxwRkVQU0lwZGRkdmZqcVJXK0ZmZmgx?=
 =?utf-8?B?KzZxZU16dHBLWk1WZE45WkZJRWs0OU5pdEtvbXpVREtpWDVJRjJVMzJMUy9z?=
 =?utf-8?B?aS9iSVNnZ0Y4OGhGajdxQjJFMktoMXI1b0dXSHRYYXBZS00yOGt6SEo0YU5p?=
 =?utf-8?B?ODRmQkRDSGI2SnVYYlFrWGNhZmg2UGJiRy80eVkva25ZVnk0QndYUDNOMW80?=
 =?utf-8?B?NXRGcDVPamd5dkRqRXMzTnpQVWFSV29pZjFrN0dCM0hLaUFKeTB3aDVtUkJw?=
 =?utf-8?B?bElDYnBMVE5LN1VCREhIeUpWVVhSY2NDRlVGSnZxNjg1U2hUM1QvUWc0cjFC?=
 =?utf-8?B?TzJFbG1DWDFiU2dISFovYUt3OXkyZ0piWGdnOFk4dG5FOG5uc1c3UUVGK1JT?=
 =?utf-8?B?TDMzeDVsZUlReVhPK1hBbHM5aVM5YWxLemZrZHRhWEFXcDFpWUJlQm0vWlZu?=
 =?utf-8?B?aFlDZDhCNHFBNGlsTi81cjhMWkdhUGZBTnFyTk13aVBOQXVpZVVHZTRwTDBS?=
 =?utf-8?B?ZVFRbVNhalJWS1owaFErNzdQMG56d3FrVE5RTHgyNFVhUFJ5TTZqYVJZMmtY?=
 =?utf-8?B?dGVpVDd6MWFJV3lPK3QrTEFac1RkNXY4UmVoclp5cEtwNlR2UnNaUTRWYkRa?=
 =?utf-8?B?VmNSeG1YaUR0cU53UTg3Sks5bWI4RVEwSzVwbWlabWRMeTVpc0x4aDh6ZkJT?=
 =?utf-8?B?OUxmN29BVzRYVVZRRGlUWURMZVpkZ2pxV0N1azZCZ0g0c3N0SUtLSlZ6ZytG?=
 =?utf-8?B?N3NBNldNUnJRZ0ZncVRFVStPOXU0SHpieGlmVEFjMjZxd2w2RjlpTVdnQUE4?=
 =?utf-8?B?NUdldFF4RkY2S2NNTnBsQlhYcFFqM2xCcWhUSFhHZ2ZZbG1QQzhDYW80aXZz?=
 =?utf-8?B?UlZDSGJ6SzZlZ3Q0THQ2Nm56VSt3b1RHT0dVYVVuRm9ncTNnTzZrdkN3VnJj?=
 =?utf-8?B?SVB1V1lTS0Z0NTBTUW0vNldubmliQ1Y2eW9XemJEeTJDaTQyWkgreUwxcDBX?=
 =?utf-8?B?NGRXb2R5S2VNUG56VktLMUFiakVWa21vNjBWU0ZnTXg1dUVhSVN6cjJRTTZj?=
 =?utf-8?B?UVk5UlFybTg1djAxbG45REUvN1VuNnRLeFJPMW4xY3IzMUNyK044QUhQTkND?=
 =?utf-8?B?YWlvRUxZRysxTzN6U2hXWTU0Y0ZJOXNDWEVGRVhMUmpCMHZCOEN2YWpacEJ0?=
 =?utf-8?B?ek1PcWFWNlRPTTBIT09kZUVrTVRwekw1TUtEaHF6a3pVdHlqTGlmRi9RRU9x?=
 =?utf-8?B?YU9DM2NPZWViWEFYODZuOHpwbEdUaWZmVGlWdFVyYUliU1lWWWsxd2F5eitO?=
 =?utf-8?B?NUVOSFFkRzM2MGdLS09EMDBpdm9tWkpyQjdvd2dtajVlRkhWL2N1TlY0bFNY?=
 =?utf-8?B?T2p4SjNvVitRcWQwM3dNWUE3YVFLL3FTdWNndkF2dlA0OFhSU3FzYXhhQmdo?=
 =?utf-8?Q?woJSSODSZwxpUgAMw31U5FI=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	eVqZpSK+8UHu6RWJZ31PpvOLJ7shWmHKrWxAz9MATF445pZcx7tcuPPcf41ItSFyerOikav541a1rdqqn4OPRdFjtI70EV5ze/alVfIU91xGnFkeqsldMQFZNpf7HHJayURlPLH3ubrssJL9LN4aNZZ5CccilYFVclwfH35AJTm113XBQOyi8yiTG2jYelNnMRSlfVBIsXMD5li8JJ3/zJKj8V/oZLAz1s4A/68PRIP5YZ6lytNdhDeS/mlojLg7HqzElh/oGEaTbkuuHcnULSxw2DCFfDsaedOGhhgeNdoXfaFb6b4C5x7z7cdP5e8kp+8yCiljU0DPojqnW+9N5AuL87KWKJ86DyDLQz5Dkf+OCZ86Eg9XS2wOprlH4kdXKiuJ5lD6RnUBungLR/cU/qLdl2KcA//1L+3oF1voF8NCrz5Buqjuh+6GUO4t3hzHzEvGBoOM2PE97lh2LaIIbXgTYW/WnSv6jx+7p4R1kBtBKVNENBeZ9Y4BfdYcywOUGBMtvDRpe9vb09xFm3EZHPdYCRphCBQysb62CLy3wrkrdsHdzFzhYc+Eta1FBWL0sKQlkjDWETAL4OptbcMJ8FEkPoeufkTfiMduwek0D1o=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3e8d53e-a1d6-4286-6e92-08dcb203cf2c
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2024 08:27:41.1963
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3R9tTcP+OwweFUdOQhtkO9YY5/Kr8Zq5iWvP9E54inwAZvbi1ac+E1WW/feB3+N9RqFVEZgl31cy9Dy92LsfKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7479
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-01_05,2024-07-31_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999 mlxscore=0
 malwarescore=0 suspectscore=0 phishscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408010050
X-Proofpoint-ORIG-GUID: eZnP056oGPOe9kGzKksWLYch3AtLoGDI
X-Proofpoint-GUID: eZnP056oGPOe9kGzKksWLYch3AtLoGDI

On 31/07/2024 11:38, Alexis Lothoré (eBPF Foundation) wrote:
> test_cgroup_storage is currently a standalone program which is not run
> when executing test_progs.
> 
> Convert it to the test_progs framework so it can be automatically executed
> in CI. The conversion led to the following changes:
> - converted the raw bpf program in the userspace test file into a dedicated
>   test program in progs/ dir
> - reduced the scope of cgroup_storage test: the content from this test
>   overlaps with some other tests already present in test_progs, most
>   notably netcnt and cgroup_storage_multi*. Those tests already check
>   extensively local storage, per-cpu local storage, cgroups interaction,
>   etc. So the new test only keep the part testing that the program return
>   code (based on map content) properly leads to packet being passed or
>   dropped.
> 
> Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>

Two small things below, but

Reviewed-by: Alan Maguire <alan.maguire@oracle.com>

> ---
> Tested in a local qemu environment:
> 
>   ./test_progs -a cgroup_storage
>   53      cgroup_storage:OK
>   Summary: 1/0 PASSED, 0 SKIPPED, 0 FAILED
> ---
>  tools/testing/selftests/bpf/.gitignore             |   1 -
>  tools/testing/selftests/bpf/Makefile               |   2 -
>  .../selftests/bpf/prog_tests/cgroup_storage.c      |  65 ++++++++
>  tools/testing/selftests/bpf/progs/cgroup_storage.c |  24 +++
>  tools/testing/selftests/bpf/test_cgroup_storage.c  | 174 ---------------------
>  5 files changed, 89 insertions(+), 177 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/.gitignore b/tools/testing/selftests/bpf/.gitignore
> index 108eb10626b9..a45f11f81337 100644
> --- a/tools/testing/selftests/bpf/.gitignore
> +++ b/tools/testing/selftests/bpf/.gitignore
> @@ -21,7 +21,6 @@ urandom_read
>  test_sockmap
>  test_lirc_mode2_user
>  test_skb_cgroup_id_user
> -test_cgroup_storage
>  test_flow_dissector
>  flow_dissector_load
>  test_tcpnotify_user
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> index 8d8483f81009..0ac0f9dbc2f8 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -69,7 +69,6 @@ endif
>  TEST_GEN_PROGS = test_verifier test_tag test_maps test_lru_map test_lpm_map test_progs \
>  	test_dev_cgroup \
>  	test_sock test_sockmap \
> -	test_cgroup_storage \
>  	test_tcpnotify_user test_sysctl \
>  	test_progs-no_alu32
>  TEST_INST_SUBDIRS := no_alu32
> @@ -297,7 +296,6 @@ $(OUTPUT)/test_skb_cgroup_id_user: $(CGROUP_HELPERS) $(TESTING_HELPERS)
>  $(OUTPUT)/test_sock: $(CGROUP_HELPERS) $(TESTING_HELPERS)
>  $(OUTPUT)/test_sockmap: $(CGROUP_HELPERS) $(TESTING_HELPERS)
>  $(OUTPUT)/test_tcpnotify_user: $(CGROUP_HELPERS) $(TESTING_HELPERS) $(TRACE_HELPERS)
> -$(OUTPUT)/test_cgroup_storage: $(CGROUP_HELPERS) $(TESTING_HELPERS)
>  $(OUTPUT)/test_sock_fields: $(CGROUP_HELPERS) $(TESTING_HELPERS)
>  $(OUTPUT)/test_sysctl: $(CGROUP_HELPERS) $(TESTING_HELPERS)
>  $(OUTPUT)/test_tag: $(TESTING_HELPERS)
> diff --git a/tools/testing/selftests/bpf/prog_tests/cgroup_storage.c b/tools/testing/selftests/bpf/prog_tests/cgroup_storage.c
> new file mode 100644
> index 000000000000..c116fc22b460
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/cgroup_storage.c
> @@ -0,0 +1,65 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <test_progs.h>
> +#include "cgroup_helpers.h"
> +#include "cgroup_storage.skel.h"
> +
> +#define TEST_CGROUP "/test-bpf-cgroup-storage-buf/"
> +#define PING_CMD "ping localhost -c 1 -W 1 -q"

other tests seem to redirect ping stdout output to /dev/null ; might be
worth doing that too.

> +
> +void test_cgroup_storage(void)
> +{
> +	struct bpf_cgroup_storage_key key;
> +	struct cgroup_storage *skel;
> +	unsigned long long value;
> +	int cgroup_fd;
> +	int err;
> +
> +	cgroup_fd = cgroup_setup_and_join(TEST_CGROUP);
> +	if (!ASSERT_OK_FD(cgroup_fd, "create cgroup"))
> +		return;
> +
> +	skel = cgroup_storage__open_and_load();
> +	if (!ASSERT_OK_PTR(skel, "load program"))
> +		goto cleanup_cgroup;
> +
> +	skel->links.bpf_prog =
> +		bpf_program__attach_cgroup(skel->progs.bpf_prog, cgroup_fd);
> +	if (!ASSERT_OK_PTR(skel->links.bpf_prog, "attach program"))
> +		goto cleanup_progs;
> +
> +	/* Check that one out of every two packets is dropped */
> +	err = SYS_NOFAIL(PING_CMD);
> +	ASSERT_OK(err, "first ping");
> +	err = SYS_NOFAIL(PING_CMD);
> +	ASSERT_NEQ(err, 0, "second ping");
> +	err = SYS_NOFAIL(PING_CMD);
> +	ASSERT_OK(err, "third ping");
> +
> +	err = bpf_map__get_next_key(skel->maps.cgroup_storage, NULL, &key,
> +				    sizeof(key));
> +	if (!ASSERT_OK(err, "get first key"))
> +		goto cleanup_progs;
> +	err = bpf_map__lookup_elem(skel->maps.cgroup_storage, &key, sizeof(key),
> +				   &value, sizeof(value), 0);
> +	if (!ASSERT_OK(err, "first packet count read"))
> +		goto cleanup_progs;
> +
> +	/* Add one to the packet counter, check again packet filtering */
> +	value++;
> +	err = bpf_map__update_elem(skel->maps.cgroup_storage, &key, sizeof(key),
> +				   &value, sizeof(value), 0);
> +	if (!ASSERT_OK(err, "increment packet counter"))
> +		goto cleanup_progs;
> +	err = SYS_NOFAIL(PING_CMD);
> +	ASSERT_OK(err, "fourth ping");
> +	err = SYS_NOFAIL(PING_CMD);
> +	ASSERT_NEQ(err, 0, "fifth ping");
> +	err = SYS_NOFAIL(PING_CMD);
> +	ASSERT_OK(err, "sixth ping");
> +
> +cleanup_progs:
> +	cgroup_storage__destroy(skel);
> +cleanup_cgroup:
> +	cleanup_cgroup_environment();
> +}
> diff --git a/tools/testing/selftests/bpf/progs/cgroup_storage.c b/tools/testing/selftests/bpf/progs/cgroup_storage.c
> new file mode 100644
> index 000000000000..db1e4d2d3281
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/cgroup_storage.c
> @@ -0,0 +1,24 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/bpf.h>
> +#include <bpf/bpf_helpers.h>
> +
> +struct {
> +	__uint(type, BPF_MAP_TYPE_CGROUP_STORAGE);
> +	__type(key, struct bpf_cgroup_storage_key);
> +	__type(value, __u64);
> +} cgroup_storage SEC(".maps");
> +
> +SEC("cgroup_skb/egress")
> +int bpf_prog(struct __sk_buff *skb)
> +{
> +	__u64 *counter;
> +
> +	counter = bpf_get_local_storage(&cgroup_storage, 0);

don't we need a NULL check for counter here? Or does the verifier know
bpf_get_local_storage never fails?

