Return-Path: <linux-kselftest+bounces-27137-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B89AA3EC6D
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Feb 2025 07:00:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BE34188ED97
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Feb 2025 06:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB0811F7561;
	Fri, 21 Feb 2025 06:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YsPYqKNr";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="REWWFLCn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 359D91917E3;
	Fri, 21 Feb 2025 06:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740117655; cv=fail; b=KspKI7NSn/SZ+W0WZq+kM2FqcaMVWCrPjmzo40205/GoQcjBIaEGzYuvRQxKv4JDYrrmj1ugI5VBtoF2upKBcAYE4I+JNgQ9wFJaJkgnK0DRl7tzm2aXjvL6B3XtK3zNeK0i4nWxtuhVcm2SoZrzYGuXbK9TK1BP+yKW9bGc6u4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740117655; c=relaxed/simple;
	bh=y9JVWTucxW+6/fOcalf2dAonYdVnD+WqkZQWMCbWDl8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LwUWxjGY9U5ThsMuFKoooswLBPGsGbaMHPh0uzziuJp5QASPU7IAnXzZgjvzIDZwbHA8r5bG5Jq5xajfKVbKD+p3jLwjCWQYw4L3MOpjIvGy7v8AmKhf4FuUKJWFMs3xdUdJgWhOrZY2D+rEFEugvTbLoHhDVfNPc16sdPwdPMM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=YsPYqKNr; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=REWWFLCn; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51KLrYtp013945;
	Fri, 21 Feb 2025 06:00:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=ylFbh3S+rshmCVYrqfPpjeNkUoUgnWCS1OVQ/97IEGs=; b=
	YsPYqKNrkvkzyDdUlxV5pRbNWxBTa06I7Um+eiTZ4OVHnwoJyWmvdZJrgpdQr3EC
	nxHPAz3H85KO4PhxUHHAzyuPtTuO1XApfhOYdX6utTqhiCc6DBvV+bdSAGmfxIzt
	0cXKBlrRfKR+XXk3eReuWLsQoJ5uUWO9YksCwcB+yU+eU2u/BM0lf/ltZafJKyXz
	CXPrud8bHZc0y7NeX0U91iUjHUaOrMvQjZxMgHj+akFCeWHf4pKeQtAzKEkWRAEo
	kO4kXQZGFWJkK6pUsrbV9elJvmolAmkLS9oNy5jF6ODVlIQyd5H9KnkjAErd1/X1
	kyPrpJZRvMMktV/hbPRnJQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44w00nnpsk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Feb 2025 06:00:48 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51L5K43g002136;
	Fri, 21 Feb 2025 06:00:46 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2046.outbound.protection.outlook.com [104.47.55.46])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44w0tp9uqm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Feb 2025 06:00:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lm+rYUe9Eks1trT8ZplzvXvijbxYzVWJ/hctCEfiGv1CYnElylbqw4UZZ/HR6caRe1dqwKNzYGKTX2wKHIz4i5ibi9l9adMTdRK8HDNlULyBRNMwxNLQbmk7vAIsO2gvfXRbtjTjy5AWTybHBbuMkl/Ae7K1BGjv/kCo58PTsB6G6CjHlI88fWBtJQ9QtVRDJu5YDwTzj53lKgYhAcKUVxBa2BwWKQXEE6iZTSSN7w51jt5eL9TMu8gOIrPm898wMnZ68gYNkQnw4ANYbZf2PkkB+PdflYEy4mII6XyYYREd+gOkwcK4UIHD6ukiH+12yVkmfNWvvlicd46vxMF9Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ylFbh3S+rshmCVYrqfPpjeNkUoUgnWCS1OVQ/97IEGs=;
 b=OTkgeho5eGZh8unuAObhlPAwHQg5zQ9oQw2XYF1AhI76+xebuRUY1A5yai/OYGL7BWbyqpUBhBisRO1PY5GYM5p/1WkmyTyZkLxM8gUgDNT2IzEUPNOCbi7eXNmcA/AMWmxZGlUmRWTPi5I/6ALrFeZfSQECsqDamaTwRnWM9Vq4uIKRkOgyfBj0lt8QrUoRk0XO9MipmrfDDsr3HkvBGBo0OSHWVaE2lheV+2P85ylKZVU+Ksp786oCuKWExdexfCENMJhfTKl8ovoE2Wqi90fGVk9jYzAE0XxmkKlcr+F2w6fX8L1Qf2OE0VcYo8DBiP9KLzO0nWU/eJ4hNP2fNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ylFbh3S+rshmCVYrqfPpjeNkUoUgnWCS1OVQ/97IEGs=;
 b=REWWFLCn9/AY9GlvrLJFE8e0JNtPRSj6nAPr5lsF8t6KViPzY1EsnuYHowQ/UyVHNuvADvnALLtKhR+gYW/6C0EW0hMraF/MV7PQtC3paWx3krYWIM5F/Qob0ZhXfeIjrO+HKRp8Z1CyLTh1xul6aEKhD9+XCCK7FVUvMIw2Oik=
Received: from CO1PR10MB4705.namprd10.prod.outlook.com (2603:10b6:303:96::11)
 by DS7PR10MB5904.namprd10.prod.outlook.com (2603:10b6:8:84::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.15; Fri, 21 Feb 2025 06:00:44 +0000
Received: from CO1PR10MB4705.namprd10.prod.outlook.com
 ([fe80::10db:799:49cf:f735]) by CO1PR10MB4705.namprd10.prod.outlook.com
 ([fe80::10db:799:49cf:f735%3]) with mapi id 15.20.8466.016; Fri, 21 Feb 2025
 06:00:44 +0000
From: Chris Hyser <chris.hyser@oracle.com>
To: Sinadin Shan <sinadin.shan@oracle.com>,
        Shrikanth Hegde
	<sshegde@linux.ibm.com>
CC: "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "shuah@kernel.org" <shuah@kernel.org>
Subject: Re: [PATCH] selftests: sched: add sched as a default selftest target
Thread-Topic: [PATCH] selftests: sched: add sched as a default selftest target
Thread-Index:
 AQHbgpobAwexZNUbBkmXCDWzivovC7NP0a4AgAB3QoCAAAjatYAAELEAgADHpzOAABpvSg==
Date: Fri, 21 Feb 2025 06:00:44 +0000
Message-ID:
 <CO1PR10MB470557AF5FC26790CB8FB2FE9BC72@CO1PR10MB4705.namprd10.prod.outlook.com>
References: <20250219064658.449069-1-sinadin.shan@oracle.com>
 <74dddd26-4a0e-4bb6-958a-229cca3c24d1@linux.ibm.com>
 <a3b5bbc0-f875-451f-8528-38a7eafc4949@oracle.com>
 <CO1PR10MB4705883FED10DAE126DEC9D59BC42@CO1PR10MB4705.namprd10.prod.outlook.com>
 <0d22f89a-d896-44ed-b4a9-c860c63450fa@oracle.com>
 <CO1PR10MB47051B268FCBD44E24B281439BC72@CO1PR10MB4705.namprd10.prod.outlook.com>
In-Reply-To:
 <CO1PR10MB47051B268FCBD44E24B281439BC72@CO1PR10MB4705.namprd10.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR10MB4705:EE_|DS7PR10MB5904:EE_
x-ms-office365-filtering-correlation-id: bcfbe977-a7d9-4f61-e031-08dd523d1422
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?HI1EaUnWRyMa3tTquQ83OeV41VfiDE0URPzk5l2OghjATO0L+sc+hg04rz?=
 =?iso-8859-1?Q?tc6K46V1HM/MFeJlsrk4C/+kzeUUtk0gtt7Hzd3djIDrblUxTG5S1XA2Zr?=
 =?iso-8859-1?Q?006uRCo3T48u0LzbIA4Q6g6TcxZNFH/1TBbCxuv+USCTmdY9quV3Ldl3ps?=
 =?iso-8859-1?Q?z4+m2+RZ6o2S2zznbl7qpnJkASqK11PO1rH88Kxxsr5zPLoSD86lSRALZK?=
 =?iso-8859-1?Q?SP+/XEhiuxioKJdBTGUOCLMqsrqGovFuTJvRyK6VOUHch8aSAIxTkSOK08?=
 =?iso-8859-1?Q?L9lj2mrBTqvI52EdLX7ditUXbNSzSN9E+pUQazeMaaiuzHHPvK0mi+kqBu?=
 =?iso-8859-1?Q?aucmLWKp/g/qzNg9AyrOsD8PJbEfdEi9uB9MGB1LSdlMgqaHAo6toRBEQL?=
 =?iso-8859-1?Q?awU8hu1QGGoWIBgSW13m8vppZ2UlB/HygEAM5pguxaYZuaHwFlCdV3jfdm?=
 =?iso-8859-1?Q?nWRxJgDHFyAm4AOd6caRyrd9wWD9Dv7hki/MKXQAMLLondYJLeoik4sUNm?=
 =?iso-8859-1?Q?eC2iLQupIcvT4iP/SCjfurwEJiXzGw/8GKTOAi8JnJY6WHU0pO4ObEdDfo?=
 =?iso-8859-1?Q?S/waUygG32Pw9eG4pCk5WWt/4mPlvbDbulgF9jZtQibJojd1343Lh92W2f?=
 =?iso-8859-1?Q?ko9GR+dVOEpDSwzRFQD+ujfdFzOCnt880D1+XpBSmH5yKDwF9hkFIlX5ix?=
 =?iso-8859-1?Q?1GVm7XlTxbevi2L5Be2wvA3jKCrhppshFYyxH49i0caz5zsGOYvq/8QFcQ?=
 =?iso-8859-1?Q?38s96CbaODKU2tEKaJtVaf8FSFlYh2ZNeA8UjF1wQUoML3EM3dWyfWoz3C?=
 =?iso-8859-1?Q?0XXxlFSYZ28HidRVy3LkYD9fnYhg/wZ7I/2AA8NyxQskDxmqUv7pI3MEnq?=
 =?iso-8859-1?Q?UR5nYI7pReQZ+5dzb+0tu1YOXbCo4DOiGoawTs0M9Meq0XMY6pqOZcR/Ub?=
 =?iso-8859-1?Q?9i0r77KWqNnubezJTCqMErvjlBSZFxtmbY1bW25firpvXixgl5wdOZ2UZW?=
 =?iso-8859-1?Q?FSaIm6fjWcEycoaug1M4PgGT6tD0H9obMw+K5A+mKtazoJNyWg+m1SADEK?=
 =?iso-8859-1?Q?QHTp4KQG++KSW+wIE579PR5Kq8ah7HBxvHFMuH2kEDE/LKkjYAmoIsxQ/d?=
 =?iso-8859-1?Q?MzdxMoFpSZfu9l0iYemGLt5BndsA6F1Id8Q8xrfnEkylrIzLA4kGie606T?=
 =?iso-8859-1?Q?NpOneFGj6FUBLJBHcWy5v1/RBcQcfGO1brVMGAPa7F/absdqt7uLyAr/Va?=
 =?iso-8859-1?Q?w8zZ4OZkASkz1YQ2h35KjluOikhk/GEKp8nlqFhoOARE93IHfMNOMVEBeV?=
 =?iso-8859-1?Q?nI3E+FgChPJHcYcNBL7YO0LPZbKpKpo4JOX7KaW+w1OjyLixtoT9hyu7Ql?=
 =?iso-8859-1?Q?sMU/Ey/Ax4nupkCQ6KGqeK7SUGx+/uH7U+oFPfGbc85melclv/aCG6Z2/c?=
 =?iso-8859-1?Q?mpRC+Q27YpKIXa8NDtFwuY83wK1sUhm3dxkJk2do6M7YiHycHEKClY0a4i?=
 =?iso-8859-1?Q?6/oGwGtFciAPGjXRERlTPk?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4705.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?+7eOi3CXyYcJ3wrfV1Evce2EjD4zso55sig7LKHaewn94OKgxgAoTJFEQ6?=
 =?iso-8859-1?Q?YoV27QVRQ6RrJCLMiRtOBy6pJoX6iVTzSzXOm+BxkUHv8in4aLDkMkfh/L?=
 =?iso-8859-1?Q?SDydHn6a2chMGhu9cZ2ynO35/HKYuaWkxCRSCL3FAuMIyQS6Ne2kQbWBBW?=
 =?iso-8859-1?Q?u7uwkRtkzIiIwz9MQzi3GvYeYbpI8w6qG4tXP4q6YemsNtI6JBJILPr4Z7?=
 =?iso-8859-1?Q?SnNQP2ObzRLhFne99NkEEaibBin0q3a+2GTCcW/AbuZoP29HwE3/mHeX62?=
 =?iso-8859-1?Q?oAnEMNG7Q64VHlC2sVr/zcWm5MgD+kGAW5+3h0GBfoat1tkKaW3J1xxEDR?=
 =?iso-8859-1?Q?bYLBMFWMeL8LYqKkv8eIpxIbKIWuyS2fjvUWFyB4Od14rxY4rTuqJ003JS?=
 =?iso-8859-1?Q?sVo61TkBnorMplBehgGE3YRGhxCs3pG/E41xaDlSIjEqAaWNOyY6fkH6ik?=
 =?iso-8859-1?Q?2hmCNgQNEiWD8yQUwoPhsyBr9GyRGDSFSSfedaQs2GJQ37T9uNTC7umBB+?=
 =?iso-8859-1?Q?Iruvedmf7DyL2FZLmS7VBzspQoFzYO6LXixp3rzGEcljjuS6jwcxX/y2AC?=
 =?iso-8859-1?Q?5m7JplgyR5d5EBPPwXtVZuWefJ0JYwgLQt1BsjV0DqpE1c7TNunoigsSOR?=
 =?iso-8859-1?Q?FYkceNT85bEXVnpd09WpTpevkVyaXYqkuskOnvqN5VOCkmyDMnkvIOmEF+?=
 =?iso-8859-1?Q?omfwhORHOu8S3I/1Y4uagYzeQ0987JMhdxbk22KNSKJTznNTbUyogn6X+d?=
 =?iso-8859-1?Q?+I7ZK2pYeUKEwziOUi+B7QHMkqMUE69e9lYW7pKWDTRce6s0ZdLHw1SIW3?=
 =?iso-8859-1?Q?IL2i3BkLZkJizoXyvPodE+a2jq1Bp0agnoCyT/vDznID9rhKxTROYcnKp0?=
 =?iso-8859-1?Q?Ew4sVk+Q+DttL3pghdl1ZiFkeu1lx0w0zDljkFdeOVB20SXeUne+0kG0Fo?=
 =?iso-8859-1?Q?UaTdHaXMBvURE7FnZQy/sfwZgYcg0y9udFmn9+jEboyTlhjioEsK+P9YTO?=
 =?iso-8859-1?Q?ENUJTZco55HgqR9CfHOv3J1ZoRh6BRaB5XQPXNfTNKpw7PrnfDI49DnCFl?=
 =?iso-8859-1?Q?wnsiAIencSXdk7Ke0sqrp4HXkq+z/cllIBQMHKGsAIH2KsXLLiv9d5CY5X?=
 =?iso-8859-1?Q?FOUnPQ8ZqvAKTS8/TPSjTe0o06dA8Df7z8csG2VZSm4DP4OcM8mRFkKH+f?=
 =?iso-8859-1?Q?R5fKGZHYprPlVa7nhSpUlCEEV201SXFkrtK/Okxuy1qPUnrUgFSAvZEJJA?=
 =?iso-8859-1?Q?mVxMARY4DIr6z7rmTt725NHm8PC6nFtR1ZTX0a08Xtp2auHTA5DBYRJKWq?=
 =?iso-8859-1?Q?Gp4oSOzjvJSgxYPcFzaMIxPjjzdTtJ1/cGHqrRT0HLTnjsRKIlDyLsUGcZ?=
 =?iso-8859-1?Q?A5K0cn+MRUds7IEiXHs1Z95epKkgSwdyXJKpMkEs61ueX+zfJNFVGz4u0+?=
 =?iso-8859-1?Q?/ZmAxINTcylku1MbE0Oi/UYkn+IU9AWPhizzJOrWnKEWxnCsZxx8VcI4fg?=
 =?iso-8859-1?Q?y2P0oHwIr+bCLg5yTuuhXP8y+7HRAr/Dij0/H1XxF8vb98EZnIpKOMZWmX?=
 =?iso-8859-1?Q?28iFmRF3KdDvWrnxQmy+C3TLvEAAqa2Z7T29FHZ47NvT0gvzc33X5raLTx?=
 =?iso-8859-1?Q?545yoMiE3t20OFLEMMpeZkFmmn3MsveWM5?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	zDZYrTDx7XZyXSRrbZx1GwbBs3HBlPHnXrRnbNZut7B4jp+B8yMsy9zrOLAW+SWP//OYD16Ynf0/6B7cru5lBOl4EJpCy9Nm5d1YHSMjtRf3HnCVJtNR5ci1CMH7biSzFRTEukkVFdCthNlbJEr53P8A/NeuVQvq2+R7BJhxuapjsmN/xdpSLd8XJSyQiqas4vsaSBILyLNypSEhB0iF+UMBFWZPhgF4kxd0RPL4LapxR/ujWnvnTrR9+P5DBM14ObKoFsZ4U7/7Jon8PCWPQiW8t+newY2jBAhQ8BQMP7S/+ANx3OPHlaj7uC4o3fXNwCzBKixCqN5iew5712TI2ZLTYfmAX88UCSUtoOx2hHnLMTXpV9f3jIH2aX3m5rIsEfDsJkCcDehd419ps0hjMzc/bsHwzuo80sBsMC6SxNHhnfpCbpx7whQh+nBswxNfmrR2QbP+aBFK1zj/fEcy37tHBlSLPjEfYHZrHibzDHhEpduauuHA20s0r3HwONVKv9W8XwhLvDXfD5dNjrFQW/Q73LRyOpKxHL6LaaZMI4J37cp39n6ObrO8l17c/OnTNGSNXL3PUuQ3KGaeoF8M9R3ObXlUVNbodsFy9DjiOf8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4705.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcfbe977-a7d9-4f61-e031-08dd523d1422
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2025 06:00:44.0477
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OX5uqphqKPv+YHnbOf38ddIxnkNNXFvsJSCmB+EM9s4Ny9RXxpSwK8Tj27yOcIWjFUfyH+nWuiqnm/IoNAuWxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5904
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-21_01,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 spamscore=0 phishscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2502210043
X-Proofpoint-GUID: 5-YJf8dGLluYdCiUuR4znuqIUFJjC7fJ
X-Proofpoint-ORIG-GUID: 5-YJf8dGLluYdCiUuR4znuqIUFJjC7fJ

From: Chris Hyser <chris.hyser@oracle.com>=0A=
Sent: Thursday, February 20, 2025 11:21 PM=0A=
To: Sinadin Shan; Shrikanth Hegde=0A=
Cc: linux-kselftest@vger.kernel.org; linux-kernel@vger.kernel.org; shuah@ke=
rnel.org=0A=
Subject: Re: [PATCH] selftests: sched: add sched as a default selftest targ=
et=0A=
>=0A=
> From: Sinadin Shan <sinadin.shan@oracle.com>=0A=
> Sent: Thursday, February 20, 2025 11:23 AM=0A=
> To: Chris Hyser; Shrikanth Hegde=0A=
> Cc: linux-kselftest@vger.kernel.org; linux-kernel@vger.kernel.org; shuah@=
kernel.org=0A=
> Subject: Re: [PATCH] selftests: sched: add sched as a default selftest ta=
rget=0A=
>=0A=
>>> I guess my question is what if SCHED_CORE was supposed to be configed i=
nto=0A=
>>> the test kernel?  Silently burying the error might be bad. I'm not stro=
ngly tied to=0A=
>>> that, just looking for opinions. At the same time, if you put the orig =
change in,=0A=
>>> people w/o SCHED_CORE on will start seeing "failures" they didn't see b=
efore,=0A=
>>> yes? and that seems bad.=0A=
>>=0A=
>> Yes, that seems bad as rightly pointed out by Shrikant. I have a patch=
=0A=
>> that does the above mentioned skip, and if skipping is a right option to=
=0A=
>> take here I can send it in the next version.=0A=
>=0A=
> If that is the plan, I prefer to fix it myself.=0A=
=0A=
Ok. Here is a better plan. I suspected there must be some convention for al=
l=0A=
these tests (that you are obviously familiar with), I just feel bad for how=
 this test=0A=
originally got jammed in here. If you already have a patch, we should just =
go with =0A=
that and yes adding that code seems like the exact right thing to do. =0A=
=0A=
-chrish=0A=
=0A=

