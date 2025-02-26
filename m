Return-Path: <linux-kselftest+bounces-27632-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A181EA46786
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Feb 2025 18:10:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C8841893109
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Feb 2025 17:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8340922068F;
	Wed, 26 Feb 2025 17:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kTaN4nFU";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="J/CMPfUm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE71F21C9E9;
	Wed, 26 Feb 2025 17:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740589291; cv=fail; b=Ufw0znAiBwrVwaC0xVCdpB2potBPC6kyoHTAIiPXB7XUnn1GQ/oMUggxbNlVhWMRvJ1hWCbj6PMxgfcOla+YP0VQHhfyg5ef+7cYsg5mJn4lDn2VSoxRwjrDeGjGTQvqli+J+owgP25DM+PzmbVIiFzkF31aerVgRdyPyfV3AWs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740589291; c=relaxed/simple;
	bh=nz4rxr0ZjoFVxV2NSU3gyK+HfRpfBpNmhbaXQHiO53o=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HxfWky8EG4p3kCD0ShQVRDUtYh8ExaeGyc+gFk4aeBCsncTKjcjlmVwLn884GI78ECM3hXpPGjmo2GX9mlse2oplBmJ7Xcnv6+NNK/jboI7PHIjKdsfMr+fevfRyOiCHqjAzxEgUI7TjYvnLI3HgohL+L4Eqyeg3YSftJHV09yk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=kTaN4nFU; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=J/CMPfUm; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51QEtaaw002641;
	Wed, 26 Feb 2025 17:01:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=WAj35AtMNxdX390RFuEwDVLOr7BLvGtaxopxdiq0ti4=; b=
	kTaN4nFUdIdMeqdLXM2HKs5AX4GlXEXIxAChAxTEP516VCNpSttTde6u1EyXSNN/
	XKmAzOMi5g9kuP0i7soWuKaA2ur+QwLktglDdsKRH8J7nbkr3EVD+zc6GJlTpo0M
	lNfZgXTACUxc+npVLCUu1HEjXlqYLM3sHrC7LvE+3w0XkstmWTr0hcQ7T9FJB2cz
	ATe1k+8wxMJLonmfVTRIRtO3XC+FteUaCDXLD/R+l+bViHTqeF7OwbQnHwQen3yc
	oebfLe8yU/IxfroB54/l2AE2B+PzPJevpD5XqQBrgI5QZSaaUTxjwCFQdl0tVZSi
	VSCy9z3/E9kN7dBsztGN6Q==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 451psfsk41-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Feb 2025 17:01:25 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51QGVwjv007528;
	Wed, 26 Feb 2025 17:01:23 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44y51h04bk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Feb 2025 17:01:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cP9QpM2xiXevORTxChe59VKvn3Ahm0s1l6P5A3kC0BJ6mCF3UbXZMWbFbJlVhNbOFdplklBzyP0uzybtOXs8/rhIcNSDZHFJKgdYa5miKWM+IoweUzNCDUsSgKHCl9ZfjcpyQ0UrMncP2rn+dOyD1GeaKBGD7PUVRcIqD/jaJXpdwryaRIrER6TqJ4l6nQuHsmdj/faUU1B9vHDo1vmdURUg03EbellPdS6TbasxLiLuCurMxPbuCp2dUtfJMl/bGUMizNuf5TskohCMvnjSU4Q3mAZjo93burSyTsbai9AiaV3CSAr2MriMUnTdm6fFmDkr+9wXWuCUCTpsuNkvHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WAj35AtMNxdX390RFuEwDVLOr7BLvGtaxopxdiq0ti4=;
 b=T7tkRXqc5bfUxVuZXUdpADk32fkEj6xRrlDoV/LKoDpta+zn7nj9Zd5qCukGG5gIS4pbbnfPG/7/fJ6wVRF8f7SBaKFcQY43DptQpV12lqRrWfRUf0bFk/iagA4LzdQLtE/2MdBoGTrsfHO+ZWEiekpmrzXS6DLpoH6AiVW6N+4Ufw+DqvjH1LMnwIFxXS2AKF0hWx2dOiuNuJ0dqmX1FgWe91ozkLg4AGqBig2d2YglZSoV6SHvCk90UZlg49Ph137aujpjeoxT27rcV5f6gTnroXsnDymfxhV6j/NKRy4G6Pa+HsYIpilVLFSFm/DG/GdwIXdFN/TZ9zBrAxE73Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WAj35AtMNxdX390RFuEwDVLOr7BLvGtaxopxdiq0ti4=;
 b=J/CMPfUmDNcboywvfgC01zpVytlrEe7Jssw0nKtArZqWzBEG65e2NvO5zqQmzq9MgmuHKUsXruaUkWajRy/Hwku3HxL7J5UjPAlgtkUkOuO0YUeuN6WIYP5HG594oclEBssfY6jqaZUk1stAh3AbXHR0VCZhQSDb4dKk3s4sTW0=
Received: from CO1PR10MB4705.namprd10.prod.outlook.com (2603:10b6:303:96::11)
 by SA2PR10MB4489.namprd10.prod.outlook.com (2603:10b6:806:11a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Wed, 26 Feb
 2025 17:01:21 +0000
Received: from CO1PR10MB4705.namprd10.prod.outlook.com
 ([fe80::10db:799:49cf:f735]) by CO1PR10MB4705.namprd10.prod.outlook.com
 ([fe80::10db:799:49cf:f735%3]) with mapi id 15.20.8466.020; Wed, 26 Feb 2025
 17:01:21 +0000
From: Chris Hyser <chris.hyser@oracle.com>
To: Shrikanth Hegde <sshegde@linux.ibm.com>,
        Sinadin Shan
	<sinadin.shan@oracle.com>,
        "shuah@kernel.org" <shuah@kernel.org>
CC: "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] selftests: sched: skip cs_prctl_test for systems
 with core scheduling disabled
Thread-Topic: [PATCH v3 2/2] selftests: sched: skip cs_prctl_test for systems
 with core scheduling disabled
Thread-Index: AQHbh8ExG7kgt587w0eH3dEZdarMmrNZjtAAgAA91e0=
Date: Wed, 26 Feb 2025 17:01:21 +0000
Message-ID:
 <CO1PR10MB47054DBFCB3BCF4D43AC19AA9BC22@CO1PR10MB4705.namprd10.prod.outlook.com>
References: <20250225200910.260569-1-sinadin.shan@oracle.com>
 <20250225200910.260569-3-sinadin.shan@oracle.com>
 <93e10bcf-3537-45f0-b282-ae4fd4573c6e@linux.ibm.com>
In-Reply-To: <93e10bcf-3537-45f0-b282-ae4fd4573c6e@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR10MB4705:EE_|SA2PR10MB4489:EE_
x-ms-office365-filtering-correlation-id: 78a8b75c-d6d6-461b-abb9-08dd568731bf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?veTg38oklvtr9oCceFS0rAOuke21Z7zhnGDTcGR3cgyx8cTneNVF2Ee+i1?=
 =?iso-8859-1?Q?wOpfIt0kY1Op2e8/5Lciqv2p55ukeueUZJSHRzg7ZsE92L68UmVrKWDMl9?=
 =?iso-8859-1?Q?0+PdFSi18YadW9vP9VGZUKPmWwNCMBC17txyFNC3DnpI8XiTye6Ep+FH62?=
 =?iso-8859-1?Q?aIq1WDCyRKVesV1Xd23gtB0K9TifpHvK+KS17hip9hQ5X3deg8cqlz+4Wt?=
 =?iso-8859-1?Q?LzaWQUFlzJ8RZ9ffl8xeS5t304Y4hlGVWHix4WKrl/N0qdOMRkhkVpOtAD?=
 =?iso-8859-1?Q?GoThKVSLJpHRl2QsUW4c7ttof3yFaHFgH9BB5oRL/iLF4bM9P4XUfUxBLm?=
 =?iso-8859-1?Q?OyWcfDJjfmO87NWCu4yuPpOOpN5RJPZ4zNoI8V71fwICuHLd5ow+wmGzoM?=
 =?iso-8859-1?Q?1JYErt5SRvc6kJMoGE8F2VGGr8R8qgK+zTqA6xOdZ0Oc5A2lm7LOuSI7tT?=
 =?iso-8859-1?Q?KIQCNSh4QR/lvNLU8taDjqZjMmXSnNpy7a3XNxalAXTpxsrYQXlIx6IOvX?=
 =?iso-8859-1?Q?9fHGCEJ4ksDlNhR4BCjQLV6gv+KH4KwNNGud3gw1aCMAqjyfKSPwNc3WM7?=
 =?iso-8859-1?Q?J5KZUXzc7GAW6R/x/DinmJXXfXUkLtOqojFl0UpnAY/t+Wh9WnKzIyhZaZ?=
 =?iso-8859-1?Q?M41OHWUjHr9LU2lYSd29JZZroC7cZylGYmc4B6l7TmyXU4PGAyy4nYzXob?=
 =?iso-8859-1?Q?NoZameIrJoDRenM0lmH2cIKmughJBMm0XxvpapflD06SDHwIwezrUkAkSh?=
 =?iso-8859-1?Q?PeekEjpVk3jZ1Hse6AmDD304gjT8CYUrBfIToWV0LDf+31id8fIGwCRlTZ?=
 =?iso-8859-1?Q?W21f2Y5BrY2Qbss10QtsHPxEgWOaUKkVFg0y6x4V3EQswjUe9COUK7Vivv?=
 =?iso-8859-1?Q?FSo/3eydjlYhsMS+NBoEHC3rM64OOs4ZCH+kg6dcfVwREuRP9x5YesjX0I?=
 =?iso-8859-1?Q?dBe6Qqhf0625H6NUGTxwRRLGLmr9+cZOrbhl13fY8K9fVmv7PZIkktJQX7?=
 =?iso-8859-1?Q?uAwdZjDsdd5hmEX+ZFLyhLwc1VcUqLL50swkiaRZRPSxyvExqw+EQAg4Rx?=
 =?iso-8859-1?Q?dHkyeWowjdk5j+wZdCPBi+RI02S1nVTihFGRHDMNwscLgInhb4bkL188+5?=
 =?iso-8859-1?Q?9xHSo4rcXCWKbtGuH/W8ow0Tt8cIVBdBJo7Y7ZMlONhAVV7iE7vU+DMCPx?=
 =?iso-8859-1?Q?tev3xNWY9q0573qVf/x6F8icbZjiaTkm+GKA4wGfElFmYz87VI56npgRU8?=
 =?iso-8859-1?Q?ai+zYfAAhPfTdTJP4FEEY6bTheGd47DVWBDnQHoeVQKHuhbFu5omFWYVqf?=
 =?iso-8859-1?Q?k7oT6VBvQrcTQyW30BDvUqp6DRmKraW1YXdP1ctj1OVOiujesAKLfZLJXR?=
 =?iso-8859-1?Q?yHIIBFkNp9Q/0qCaz/IULc0Ea8GXrQFTJ8iC532dtYU/nYjrOBzaHxZRCt?=
 =?iso-8859-1?Q?/Y1BalCOiOIiJC7qjb1NuKRk7mpPqJkENKLahQ3u8UiC7fXRocZs4D4xDC?=
 =?iso-8859-1?Q?+gkW/BNcibA0uxSng8lU+h?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4705.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?SycouYawSa2g2R8buxoj/UQE+84RbdD+r1KM/embkJ4mKMtcap4A3eauCs?=
 =?iso-8859-1?Q?IznVVb1YJYaiFS7D+XfbBdINligR3Nwc9YNhG85yGHjh4TIEFggm13utRU?=
 =?iso-8859-1?Q?TEC6Li8DHEWHhEqS15TW50Y9M7kmtBsBZJLubobzEuf13CgHVR/WTytURp?=
 =?iso-8859-1?Q?6whUMYGH3+PBCSblwvs9BMfhvGI+2t4hkZ7CDVSuC3vcdbpoxumOAXt3k9?=
 =?iso-8859-1?Q?ZyAcglKih0A5uzH5w792bI5zmeczwl0GFYTTZcpHKdNznLiavsLLPT0d3h?=
 =?iso-8859-1?Q?br0mkLe1Eg6LSdDw7u2arXAYLc2ti/8HwNiyRL8CJ54YHlzzGzRuR7cEmO?=
 =?iso-8859-1?Q?py53cKrwfLlxwk1ZVt7sENTJgMr1MrGN+VtkXlXPH52tV4qbyvKmXvonSS?=
 =?iso-8859-1?Q?Qa7RIpMIyOi8HXBucRBI+BFhff3v5Q+YI8DAu9ZlkcAusqNtvkN/dCD2eu?=
 =?iso-8859-1?Q?w9A/Ow7uF5+Ddl7YqZxcFhrOuQhJ1LYHs0BM0C9cUi7T2F9vzrF1mKvBQs?=
 =?iso-8859-1?Q?e3lBFhI7QIdMtYG7d4VbY4jNEIybafhNUfK568Jx6Sw2LkL+WZ2nmKui3H?=
 =?iso-8859-1?Q?vb/iAFZptq0NM/hCPVXAQ2Kb/vBcwTTR3WpM5MkbZoebrV6IQm7nc2Cfu+?=
 =?iso-8859-1?Q?OiFHq6XysXM+R6EMb/LYDMsCCXHaLpDD6H6vZJ4hRUlJgI6W8FfNdVcHDw?=
 =?iso-8859-1?Q?klZQRHAPaEH4rjjtsm9XD3oqDw5cyXCOTLTTDoUsBAJ/ATF+CmoOlLEBrh?=
 =?iso-8859-1?Q?744CDaQXSkB17+BQ8rrJ6+iayISs3E4oR+raEZeaoJjQisDnwwBT/qHShw?=
 =?iso-8859-1?Q?K5ZFwJgQnJE+vdTUFwqx+QulBLHTM310Y/eQvGgDRfFLvffUJuk3+b2TRA?=
 =?iso-8859-1?Q?oLEziriT8m1ThewkWYz9lzHpXwUJ/g1lydlr5ZaZFLQFOqDux1sheFknWa?=
 =?iso-8859-1?Q?5ez3xzFxuwjXVQKh6TAtbn8eZKUu7h/CRKUbr7R5V280TobQgkK9vKnijI?=
 =?iso-8859-1?Q?uZf0lfm0jEaSF4b4YjPH+7HNlMLF14CmY58Pt1GF8Lrv6pInErAL9Ga124?=
 =?iso-8859-1?Q?RnL7SN+Jn8ROOOcud7XR0BctuYSny4B5vERz7+B4NsbxJDrSzRE9WVrkHX?=
 =?iso-8859-1?Q?okuSE/Q/5bI9S0Behjtw6VpuwI3xApomSEb7hQ66++SmaRnTzS/HTsM5B/?=
 =?iso-8859-1?Q?6TW1fqawSoyjWj03rX9DGkSYHShvIA2ryunjBeLFAFGpuLNjjKQc9GWtCq?=
 =?iso-8859-1?Q?ahAxuChvkKw9++jLn2dbA5hNOCuqQoi5j/076sVif7365HWKKCbFWHUCRO?=
 =?iso-8859-1?Q?0Irem8I6YZg1FhWEOKZF+U3ojFgLIrdcjpqlsHfWUi9LBczocRVoBqZabB?=
 =?iso-8859-1?Q?MOdWBQFt6A1p7/7yUO4w9+yW8gGzyIcG/wB9F8rKbabiJh/kywaLHfNjkj?=
 =?iso-8859-1?Q?6kjlLkh9gZc1Ubhuv5iV3PHyoQ7s7wvX2L9CvQE323RuAVHnaRuTohNkGI?=
 =?iso-8859-1?Q?2bJcvRDNvendyj+m+HcRay5mKqkhIc9Eh7wtf0RummWLBcTFieUVtc7O1a?=
 =?iso-8859-1?Q?Vf3OQ8O/dc9m+DavidacgF2G3sITsjnHEXcZ1ZrjdzutUG/qKFWlnay0vb?=
 =?iso-8859-1?Q?B53FEGT/LOBlNsjHsyp53Gk7QcmCgwVHDc?=
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
	qyUv7SW9bknCwfCs1HFUBU5jsbB/Yf1JmISeVOzdkSHojwB7uJ5FuJ3XwEv0V4vU2xhXQqOQOggW6mkTxqLdOlxUVd9Pz0iZ9hWasAJK0MobfnTUMt8P8IQt0otCneGyd7MIufTMthaLllb/zfpxoo+VF8jfH5PyQUWrpysyS1e57/t4y77NpIZE4hA657xgrqli5/KS/9rEaSdQrd8AUKOTI3fjj0jVtCIENwEDEyyr2a3nNX60d4xS8bgwSAVXp6dgud/6jvs1F4uxwclwty1PhejnfzwI1AONbHTwei+ITsfue1Um90F6qGRHOpvKqdEmYFSL7njxqujfkqwQHja56tgq6qO1Kn7LbLWj3UxG/EJDQRD12GF7pv9mpvnhids9Swp0qwzLBGz51H67D7gsPbViy/NncZNrYU5hnQgVTNtqmHgw9xF/xqIcICQNd+dlqOQKV3pLJfd0G+Pi97yRMBwlJXbH8wxE2caHaA2maSnNrI9i226Pc64PO37iFv05MABE5gj/qZcr6FDUa34klmUnyDWTJcSRm8KssXy1Kwv9tdAl4GpCm+6+rEGs7+H39eHfZTHmTvU56iUM8aEnIR6svhgMELXP8GzCbZs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4705.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78a8b75c-d6d6-461b-abb9-08dd568731bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2025 17:01:21.1118
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rKUiKqa56D87QUN8qFZxUuhDbDMx2YGvgiYbqit9FZGzw/vo2qXm3ypC1jfHFluWObMLiv+t0nPh36xhCgYWqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4489
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-26_04,2025-02-26_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 suspectscore=0 adultscore=0 phishscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502100000 definitions=main-2502260134
X-Proofpoint-ORIG-GUID: kJzqdk_qyaKOseE0QyMtnMYKDMyEKC2A
X-Proofpoint-GUID: kJzqdk_qyaKOseE0QyMtnMYKDMyEKC2A

On 2/26/25 01:39, Sinadin Shan wrote:=0A=
> For kernels with CONFIG_SCHED_CORE=3Dn, the sched selftest cs_prctl_test=
=0A=
> fails with "Not a core sched system" error. Change this to gracefully=0A=
> skip the test for systems with core scheduling disabled. Exiting early=0A=
> would also ensure failures reported in obtaining cookie are valid=0A=
> failures and not because core scheduling isn't supported.=0A=
> =0A=
> Skip cs_prctl_test for systems with CONFIG_SCHED_CORE=3Dn=0A=
> =0A=
> Signed-off-by: Sinadin Shan <sinadin.shan@oracle.com>=0A=
> ---=0A=
>  tools/testing/selftests/sched/cs_prctl_test.c | 34 ++++++++++++++++++-=
=0A=
>  1 file changed, 33 insertions(+), 1 deletion(-)=0A=
> =0A=
> diff --git a/tools/testing/selftests/sched/cs_prctl_test.c b/tools/testin=
g/selftests/sched/cs_prctl_test.c=0A=
> index 52d97fae4dbd8..5b0047b50e640 100644=0A=
> --- a/tools/testing/selftests/sched/cs_prctl_test.c=0A=
> +++ b/tools/testing/selftests/sched/cs_prctl_test.c=0A=
> @@ -109,6 +109,36 @@ static void handle_usage(int rc, char *msg)=0A=
>          exit(rc);=0A=
>  }=0A=
>  =0A=
> +static void check_core_sched(void)=0A=
> +{=0A=
> +       unsigned long long cookie;=0A=
> +       int ret, num_max_process;=0A=
> +       char buffer[32];=0A=
> +=0A=
> +       FILE *fp =3D fopen("/proc/sys/kernel/pid_max", "r");=0A=
> +=0A=
> +       if (fp =3D=3D NULL) {=0A=
> +               perror("Failed to obtain max process number");=0A=
> +               exit(EXIT_FAILURE);=0A=
> +       }=0A=
> +=0A=
> +       if (fgets(buffer, sizeof(buffer), fp) =3D=3D NULL) {=0A=
> +               fclose(fp);=0A=
> +               exit(EXIT_FAILURE);=0A=
> +       }=0A=
> +=0A=
> +       num_max_process =3D atoi(buffer);=0A=
> +       fclose(fp);=0A=
> +=0A=
> +       ret =3D prctl(PR_SCHED_CORE, PR_SCHED_CORE_GET, num_max_process+1=
, PIDTYPE_PID,=0A=
> +                       (unsigned long)&cookie);=0A=
> +       if (ret =3D=3D -1 && errno !=3D ESRCH) {=0A=
> +               perror("prctl failed");=0A=
> +               printf("Core sched not supported, hence skipping tests\n"=
);=0A=
> +               exit(4);=0A=
> +       }=0A=
> +}=0A=
> +=0A=
>  static unsigned long get_cs_cookie(int pid)=0A=
>  {=0A=
>          unsigned long long cookie;=0A=
> @@ -117,7 +147,7 @@ static unsigned long get_cs_cookie(int pid)=0A=
>          ret =3D prctl(PR_SCHED_CORE, PR_SCHED_CORE_GET, pid, PIDTYPE_PID=
,=0A=
>                      (unsigned long)&cookie);=0A=
>          if (ret) {=0A=
> -               printf("Not a core sched system\n");=0A=
> +               printf("Failed to get cookie\n");=0A=
>                  return -1UL;=0A=
>          }=0A=
>  =0A=
> @@ -270,6 +300,8 @@ int main(int argc, char *argv[])=0A=
>          if (keypress)=0A=
>                  delay =3D -1;=0A=
>  =0A=
> +       check_core_sched();=0A=
> +=0A=
>          srand(time(NULL));=0A=
>  =0A=
>          /* put into separate process group */=0A=
> --=0A=
> 2.43.5=0A=
=0A=
So assuming a return code of 4 means skip (and I believe you stated that af=
firmatively before), then this=0A=
should solve the problem. Thanks for fixing this.=0A=
=0A=
Reviewed-by: Chris Hyser <chris.hyser@oracle.com>=0A=
=0A=
-chrish=

