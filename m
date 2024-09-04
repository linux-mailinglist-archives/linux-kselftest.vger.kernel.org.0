Return-Path: <linux-kselftest+bounces-17093-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DCAC96AE9F
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Sep 2024 04:32:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7867C1C2128D
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Sep 2024 02:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64CC847772;
	Wed,  4 Sep 2024 02:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jJEMd3ZV";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="mI2I0Kl/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63EAF44374;
	Wed,  4 Sep 2024 02:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725417119; cv=fail; b=BSTrbPQm8M3YBuUXlEGlY/FVUNzBh/tMs6b4PMjh3ZkIxcg4FmIO3TEX7EwdzoXO2pnXsEaYVLPqfkWYAIJbkzQdONNzAYMu1vcL6+Tnwc0B9LZz3OVEMXS9ZsWLbH5L2zykIAkJVQgKbkmK6hhTvCM17VPuzWrfH+wOW9vAetA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725417119; c=relaxed/simple;
	bh=hppYsGtfFeiIzCS2Ps07Uy7+xEINcEOsqXFjzAoj2uQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Do8vM4PZVWudwl6YTdZHuEwIsKt4m2XnpkBuv3ZZgAaCnAhT6SnYy3/2UqGjpkRBDFzMuVLJArsvc8M5kmKWXKoSusCn81gifYnll/Y2ur+S9SOQhalWLld6q4CqNdm5bFSI0nKnCDQpXMwjemMvdnj57Gw+TUfwBxm0LxoHlwE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=jJEMd3ZV; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=mI2I0Kl/; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4841Mvqg008088;
	Wed, 4 Sep 2024 02:31:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=5nt6yWzlvDprde6
	ClEbLLuSoWJ1XL7dcFiybsQJk244=; b=jJEMd3ZV0SUofLDzuLeVqWLi/f+MxWU
	6HonaniiLGlSULgrst0WkTcTVWCp4X5tMK4D+nagqOqlgPcVkYADDvxZy+shgzIu
	elnrtrphwjcD7Ur69Vv/zVeLfq8/YM3mvLwVuQKply3OiamFE1Df5GSk6R/voKBu
	TiylHJZVQ11xfeDpbGbCtHAhr78P/jjOisWdh4atOMKGY/xEe8ueshm8Ppw6ldcJ
	iU/e5yqoQkEQ1HPPAsG4E9SbDj6HGQBt5L3Sn7arliFDjq5lupNHCj9BObavdePn
	awjKc8qgbXlRKGxNXvnOjymXVgEZoR/CkhVIedEMtqg3OadJFaHotYA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41dk84k1ga-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 04 Sep 2024 02:31:26 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4842UL6R018369;
	Wed, 4 Sep 2024 02:31:25 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 41bsmfh50j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 04 Sep 2024 02:31:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tHUpkttaMp38oxpdEoLpT3rMxuF8hHevc21mjDjtSkFFE/pMlF1IMdKymgRr/C3OZAU8erMNTSUc3P3tpfOI7YdnqIZC2aVxiaS/4X1csLHn6X3C1Zl3O8CvNFzr7iQsofADpeH7nNQ7GY0wMQqvBEzgiMUSbOawan5IRvqhMCX7owunZAzjaAqxZtrcvQT2mNYYf08EupqTgBQbFva2+2h2OSStSqq4dmVVkA75pSh3jaAUc3Ej8CwrrOtbQT6U/Qs/OmIhJcah6m1GExqoYdMbjkko7RsjQobRYnG0RCTXe9svIg+1STY8M2I1Yv78jqttxsdyFN+ZWPWJYzP6Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5nt6yWzlvDprde6ClEbLLuSoWJ1XL7dcFiybsQJk244=;
 b=CRmwUbIbsBUhTr4BaB2N7nQg/KsrnNkGnXufJUdYr+ryEmHkboANeW3qp+sT0FO58rE/2aPqgh7z+0SPOybJ8DZRj9Q/EMWPBkIxcVzlAdChjGTfbau92sK6zkJnw3djzQPZZuIk32X1V4r8FiS5KLf482D19M4xI0slZ4xPsjXTI+UFkAWW8kaqcoo/3sTJ6kdRQO+TweASDs0pi9+lKXPaJAMm4IPTLWOEz39gLcEWN1fX9w0GevquGT1CNlNw3xnefVtnuqqoVFyy9PGHHqr2qgoqVDihWqy2cixVy5tdYBYSejWzDHceRXUgHZ3+PmgotYQGCDpkTdWLObWWrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5nt6yWzlvDprde6ClEbLLuSoWJ1XL7dcFiybsQJk244=;
 b=mI2I0Kl/I94qsV5AmF+YI6DMUP2tiJa55h9sUildqflao24Aq3mzykHGV1A+lUyPmlObI12JkwxT/MFH83Qx5um0Vbi/QZI3jPVttW9RTfsMxKrtFDFnJIzFnEy+f+LfX03mp07uAC3W41YsJYkppfDH2NGjwtqHQRNQoBoQ6WQ=
Received: from LV8PR10MB7943.namprd10.prod.outlook.com (2603:10b6:408:1f9::22)
 by DM4PR10MB5918.namprd10.prod.outlook.com (2603:10b6:8:ab::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.24; Wed, 4 Sep 2024 02:31:23 +0000
Received: from LV8PR10MB7943.namprd10.prod.outlook.com
 ([fe80::a8ec:6b6b:e1a:782d]) by LV8PR10MB7943.namprd10.prod.outlook.com
 ([fe80::a8ec:6b6b:e1a:782d%7]) with mapi id 15.20.7918.020; Wed, 4 Sep 2024
 02:31:23 +0000
Date: Tue, 3 Sep 2024 22:31:21 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        David Gow <davidgow@google.com>, damon@lists.linux.dev,
        linux-mm@kvack.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] mm/damon/tests/vaddr-kunit: don't use mas_lock for
 MM_MT_FLAGS-initialized maple tree
Message-ID: <whdjeq6qpccj6ms4wgiyjcnizht4nl5qbt7rbaeqfwzt67smxt@vvduwpqcuizl>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	SeongJae Park <sj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, David Hildenbrand <david@redhat.com>, 
	Brendan Higgins <brendanhiggins@google.com>, David Gow <davidgow@google.com>, damon@lists.linux.dev, 
	linux-mm@kvack.org, kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>
References: <20240904005815.1388-1-sj@kernel.org>
 <20240904011840.973-1-sj@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240904011840.973-1-sj@kernel.org>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT3PR01CA0111.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:85::12) To LV8PR10MB7943.namprd10.prod.outlook.com
 (2603:10b6:408:1f9::22)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR10MB7943:EE_|DM4PR10MB5918:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d01b7c2-b7f5-4138-b703-08dccc89aafa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|27256017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?16yvAw1LaeTdSbvV1IQ4b9Xtg2oihjRMTSbU90fgBVxv3s2Tu9uXj8qUKibW?=
 =?us-ascii?Q?OOhGvlnsljpTApOxAW1aypgfzsUXVLoiAvWJl3D0cW49+lpZRcin2YFCSod/?=
 =?us-ascii?Q?xKhvdOjnMN2yAm7iZ4dmTEkSHltmaHMwsX4UsdmXreYHam+NsDIbc9wGDzhm?=
 =?us-ascii?Q?VrcY5QCzXz6K0PHTDV35hum7A684hmTp7qKaHjEXitk79nVHeOnwCBTrh587?=
 =?us-ascii?Q?/3pKjUtJ13TEE1SbfHuboD3pQVCcrKBm0LxzLa7K8Y/TBGrpW6yGQkHihbQC?=
 =?us-ascii?Q?kcj8gsFFl+xsUOh0J+jL06ryulu7/Y/JdOyhmX8zjg5xLWsUfUFlfLGU1ADl?=
 =?us-ascii?Q?J4BsqBmT2uh1EpOoj63nDVHEj+JZVLABz0fRp90LxD6l+wyWUBYkD6pBWKu1?=
 =?us-ascii?Q?owc98LHVpMGqZFUnLxeQLTMFEskFOD0ifIE6CLVFXcSJwwOUjGjL9RpnoDnY?=
 =?us-ascii?Q?18QJoDNx4PsHZT7a5MuUboitcFyi3C8DquV/tuDvjoIUhMJqVQO6kmKAMOOt?=
 =?us-ascii?Q?QKxkBM/w9/1XnmXmCXU/NL8Dt9e/jd6BNhgirSPAfJV+6Iowfl3hUmeTnJzi?=
 =?us-ascii?Q?hleKS3cQRg+zXoLTh+GHqwNg70qP1V+eZuGi6h59fErSeQxwBVgYW4IHG1U2?=
 =?us-ascii?Q?6b2ay53FCJvT1i6NMQ6XjXoPU4jBCCNNBfH/o5cnhmNfMjXcXHHE9zdB4pNa?=
 =?us-ascii?Q?yh/e6IoAAEk7CAoVbXU5B+GoR/YujWPZKoNOY5zRGX7HG+tK0Ylcl8779h5N?=
 =?us-ascii?Q?/FVataymK7i/nPqAQgzEVi4qX6f5BjuQWykBKSmLhAx7d13hL2/IkJrkVkMu?=
 =?us-ascii?Q?lmO8T2VVC6U0/FfOz4qEgPescQmf+f0IhnuIlkCJdhPSNYxV9yV/iqZc++gH?=
 =?us-ascii?Q?8sa6d0GaLob65OcizBSOfDDfL/1AkXgAkfPnw4TK4NEFwW/DsiITCW5OPTOJ?=
 =?us-ascii?Q?ESnX+vUyvV8ZRD7pti2rTuP/CCjNzqc+TdHhN4CJ6yUUmujhOUJa6gmfJWLf?=
 =?us-ascii?Q?9B7s9nZ8yug22DByrAF7A88Y3dLLPrB8BHljYQ/Hxs0KhUWvkUeUww27STCM?=
 =?us-ascii?Q?BlERXJeNVME2RE8tRgYpTTigGmx8XtMDyQsSNQ1UXAzdfyYTzgSh8l7iXw3w?=
 =?us-ascii?Q?8vKy+Rz5ZKg8pnCeNnRaoNSWlkheu6ofNMG9yD9qOGPR1eCJ1Jx5Xk39Kcmv?=
 =?us-ascii?Q?8qZgh+gBMMFnXGqlsl1KV2KMq/4ljzlhdkcxGfkjJXQRRIv97Ph21u8MGYYX?=
 =?us-ascii?Q?2TRoiPy68yk8YI7tnR6xaAunyaW5xeg7+F5XJhtClBuW2twMo2gjtCg3a18u?=
 =?us-ascii?Q?Elv2HdwLB8bkJ7eZ0YaliopNoaNu2CyZ43B019MDdHQABLf+rrTLLzbRVx5e?=
 =?us-ascii?Q?6VAFFZHFLk5PdxZbGI71pWIRkdhubavbX9Vq+AZGa2O5fna5MQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR10MB7943.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(27256017);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zE4yA3Cr5SIO7mZNWzicGMUZC0VAp2SLfNa6lA/FDep2XE21187vGnZJOULI?=
 =?us-ascii?Q?f0WBNLcSlOjvq4HpcLpfu0M1pn0yMBC2CAM4Nni+34WIuKwtizDVeFU938ts?=
 =?us-ascii?Q?L0n/h+TamkvPfY/xsTQKZpUsmJORtfhwq75hsOo4PRphTLV0iQvrxiiYxwkp?=
 =?us-ascii?Q?EDIHXTyaHkDeTnd7MdOYBTL05hKAIC3OvCbk380knZRMc/YCdn6z98LNW0Go?=
 =?us-ascii?Q?OH8z6lHgLFghD1uPdrQG+TtnBADauiADCen6kxxsjHupWDOU2xKH2HZjVbP1?=
 =?us-ascii?Q?TBYDbY9PH/6c01t58aMDn/KJWgKRQy4d+P1/1CVlX3VW2/1GdPVt7m2lwNuA?=
 =?us-ascii?Q?Zs53k8gefD9S+VPgq8RQy3SuJOyn6AbaHbwNBuq9frr75kDaKkwQ6JjKfZJ4?=
 =?us-ascii?Q?UzwSQiKjLDhGNUqEG4HRO6CZAH12aKkTM9JJeGe3uY6KzhtZwgnVANOikW52?=
 =?us-ascii?Q?QJbJ3r56xysnswbipgphoC/bFI1XCmgSVUVAh1h0G7Y1XQCehMs5hbGDyXNu?=
 =?us-ascii?Q?kHs7mBohQcktkMtYDdOSw0Ic51+n1MqcXFkW/cT/1pOlA3aJJ+slqps0OCjD?=
 =?us-ascii?Q?LjSAeLOwnrbQZpriOWIVrR/zrf1Cp76div0Omdyd+uUR6Wee05f/VAYgYNjT?=
 =?us-ascii?Q?DyGCx2Rb00UrpQx8lFMyU0cIiRjFqHM2kAw4xj6GTpTJl3ZLs5G01emgfqNF?=
 =?us-ascii?Q?1wDrgyEBAUz14tHREGsPEuA/W0bwpGMgo0K2f2egcwN29r3GwfjeEueowj+X?=
 =?us-ascii?Q?d5PN7izvB+zDjEY3tw1rFpCzo7vu57Gyks9QRbrPFc2Lj47cvx89KCDX3SbX?=
 =?us-ascii?Q?XFDXj2F/RxrrMpCKmo4ITN2zt4UnlB5WlKDKkiNULsRvhmWpDdhP2pNLxNVB?=
 =?us-ascii?Q?gaEOJQrGprGxtu869UHv5Jtg8x/6iC4W6JkRcawvhUECtkicNLUMBktQwVsj?=
 =?us-ascii?Q?5jwFmggqqrg7AiFGNU3XdGWNIfgiDbBhOzCJSWp8KlrNwyJe5uig1Wr9QbR4?=
 =?us-ascii?Q?hPovMBQ5moMYgawAdVtwBSW6cXZAmfLw+H8y5gcN9KQnNhHYdzho+uL1rw0V?=
 =?us-ascii?Q?OxU9ztHxiq9zM7ELte2DHiWqzEvtsOJIYBvbn5gTxIfawG5wkOY4fsIFB7r6?=
 =?us-ascii?Q?ZXX/MhG597s9GPSMY51uVEyNOaDCQAd1o2S3b+33EFTaz9X1GUIZOw2etrQy?=
 =?us-ascii?Q?+E4xNjq0h0fFyoro2XT2VP47qg73UG122vStAXzqmQLF2nEDWXdECeCmqrBm?=
 =?us-ascii?Q?4Q1vCMvfUxfUEwJHJsaZTtclbZfcR5wsIDPPBSTAv6G//p8xWNunVRwgD5HB?=
 =?us-ascii?Q?uMQmpMuxn+o/DKJCS49rfGQgf4iPFWqQLr70hcGnd/C6+WE2L6p4yLytnibP?=
 =?us-ascii?Q?fgqHQvqJ71H0iBqZb28KOB/dxbcK8ArHhUVD5v6c8x5l5sXChrglgJeHyv5G?=
 =?us-ascii?Q?sRLkl8fmFmdSbJGShA9M5yhwWlR5bMHC0L5348puZazXH8bVc7zRely94iEf?=
 =?us-ascii?Q?nl81VKye2Q10VfP5ZTcMvlgg0fxdvX1SBAsDs7g16tKkxqtJ+LyF/qJNJ83t?=
 =?us-ascii?Q?ihzA916ExiR8+U42Chqf0K9QDjaSRh7IydbNoHjZpPCMHffqUW9dDlAb4E0c?=
 =?us-ascii?Q?xg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	13nNTHUmdbYjHCTbPkYVkvI2U2jetQMGaUDCWTEwLlZOI585WL0Ix/JUg40efljAjTdpWdekr0bG+qxnQaF3GtfZ1PXJ2Mfu0JhfYhj9W8443Yv27xiYWIizEO69uj1QYw5uDWWq7B5+aOtVNR88Sr2TNWahGuUvZw2t2rsbr59xiu83I3JnDilpnAHvpPsDOfhP6JVKoT2qUo5YLrjs3gJMfCLoJVVCu0zrQl9WHMhzHIvrzu1uRGNZchjQbRm6w2nUyVgufVHJacrl4XebuKZPCR+AzEWfniq2DZa11yHBKKsOwRJI9P+3Vv1XstRZp4gXMgKcUpU6010uR5EZEEGn7MQyz3FgOt7VAlY4/M8JLHe165XHyUNkEKNvgshz/Nzskz/KUDXnYkF0w7eF0DWEGiCxsh/7aSU2naIU/F6MoDBCbmn+Qo9LYU1fxCDzYY0/J92VuhtTxnATYkbyHLQwkvuy64DSf8oslYntD4fDvNGM2hjn19DLD+Ci+xFGRwlepm8ZE1Y+7uvFemCpoQq/Dby56DKU9FqWvBRb2FLk03etGkudIG2jxAQhH7jIYISgWMgLaWolIfRKW4vTvnIFtFbflUR/hHFsSpxjGGc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d01b7c2-b7f5-4138-b703-08dccc89aafa
X-MS-Exchange-CrossTenant-AuthSource: LV8PR10MB7943.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2024 02:31:23.1696
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BXswJJfcdIpeXGyvxTVuN1UYM/V/zXCQ9ehV8tOqYr7IqioyeEw5v7ZbfRaLRV8I/Non69s0w5P5T5Hlf3U+CQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB5918
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-04_01,2024-09-03_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 mlxscore=0
 mlxlogscore=999 suspectscore=0 malwarescore=0 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2409040016
X-Proofpoint-GUID: 0eZJab7f145CFAG6xD99R8EUeuITEWk8
X-Proofpoint-ORIG-GUID: 0eZJab7f145CFAG6xD99R8EUeuITEWk8

* SeongJae Park <sj@kernel.org> [240903 21:18]:
> On Tue,  3 Sep 2024 17:58:15 -0700 SeongJae Park <sj@kernel.org> wrote:
> 
> > On Tue, 3 Sep 2024 20:48:53 -0400 "Liam R. Howlett" <Liam.Howlett@oracle.com> wrote:
> > 
> > > * SeongJae Park <sj@kernel.org> [240903 20:45]:
> > > > damon_test_three_regions_in_vmas() initializes a maple tree with
> > > > MM_MT_FLAGS.  The flags contains MT_FLAGS_LOCK_EXTERN, which means
> > > > mt_lock of the maple tree will not be used.  And therefore the maple
> > > > tree initialization code skips initialization of the mt_lock.  However,
> > > > __link_vmas(), which adds vmas for test to the maple tree, uses the
> > > > mt_lock.  In other words, the uninitialized spinlock is used.  The
> > > > problem becomes celar when spinlock debugging is turned on, since it
> > > > reports spinlock bad magic bug.  Fix the issue by not using the mt_lock
> > > > as promised.
> > > 
> > > You can't do this, lockdep will tell you this is wrong.
> > 
> > Hmm, but lockdep was silence on my setup?
> > 
> > > We need a lock and to use the lock for writes.
> > 
> > This code is executed by a single-thread test code.  Do we still need the lock?
> > 
> > > 
> > > I'd suggest using different flags so the spinlock is used.
> > 
> > The reporter mentioned simply dropping MT_FLAGS_LOCK_EXTERN from the flags
> > causes suspicious RCU usage message.  May I ask if you have a suggestion of
> > better flags?

That would be the lockdep complaining, so that's good.

> 
> I was actually thinking replacing the mt_init_flags() with mt_init(), which
> same to mt_init_flags() with zero flag, like below.

Yes.  This will use the spinlock which should fix your issue, but it
will use a different style of maple tree.

Perhaps use MT_FLAGS_ALLOC_RANGE to use the same type of maple tree, if
you ever add threading you will want the rcu flag as well
(MT_FLAGS_USE_RCU).

I would recommend those two and just use the spinlock.

> 
> ```
> --- a/mm/damon/tests/vaddr-kunit.h
> +++ b/mm/damon/tests/vaddr-kunit.h
> @@ -77,7 +77,7 @@ static void damon_test_three_regions_in_vmas(struct kunit *test)
>                 (struct vm_area_struct) {.vm_start = 307, .vm_end = 330},
>         };
> 
> -       mt_init_flags(&mm.mm_mt, MM_MT_FLAGS);
> +       mt_init(&mm.mm_mt);
>         if (__link_vmas(&mm.mm_mt, vmas, ARRAY_SIZE(vmas)))
>                 kunit_skip(test, "Failed to create VMA tree");
> ```
> 
> And just confirmed it also convinces the reproducer.  But because I'm obviously
> not familiar with maple tree, would like to hear some comments from Liam or
> others first.
> 
> FYI, I ended up writing v1 to simply remove lock usage based on my humble
> understanding of the documetnation.
> 
>     The maple tree uses a spinlock by default, but external locks can be used for
>     tree updates as well.  To use an external lock, the tree must be initialized
>     with the ``MT_FLAGS_LOCK_EXTERN flag``, this is usually done with the
>     MTREE_INIT_EXT() #define, which takes an external lock as an argument.
> 
> (from Documentation/core-api/maple_tree.rst)
> 
> I was thinking the fact that the test code is executed in single thread is same
> to use of external lock.  I will be happy to learn if I missed something.
> 
> 
> Thanks,
> SJ
> 
> > 
> > 
> > Thanks,
> > SJ
> > 
> > > 
> > > > 
> > > > Reported-by: Guenter Roeck <linux@roeck-us.net>
> > > > Closes: https://lore.kernel.org/1453b2b2-6119-4082-ad9e-f3c5239bf87e@roeck-us.net
> > > > Fixes: d0cf3dd47f0d ("damon: convert __damon_va_three_regions to use the VMA iterator")
> > > > Signed-off-by: SeongJae Park <sj@kernel.org>
> > > > ---
> > > >  mm/damon/tests/vaddr-kunit.h | 10 +++-------
> > > >  1 file changed, 3 insertions(+), 7 deletions(-)
> > > > 
> > > > diff --git a/mm/damon/tests/vaddr-kunit.h b/mm/damon/tests/vaddr-kunit.h
> > > > index 83626483f82b..c6c7e0e0ab07 100644
> > > > --- a/mm/damon/tests/vaddr-kunit.h
> > > > +++ b/mm/damon/tests/vaddr-kunit.h
> > > > @@ -17,23 +17,19 @@
> > > >  static int __link_vmas(struct maple_tree *mt, struct vm_area_struct *vmas,
> > > >  			ssize_t nr_vmas)
> > > >  {
> > > > -	int i, ret = -ENOMEM;
> > > > +	int i;
> > > >  	MA_STATE(mas, mt, 0, 0);
> > > >  
> > > >  	if (!nr_vmas)
> > > >  		return 0;
> > > >  
> > > > -	mas_lock(&mas);
> > > >  	for (i = 0; i < nr_vmas; i++) {
> > > >  		mas_set_range(&mas, vmas[i].vm_start, vmas[i].vm_end - 1);
> > > >  		if (mas_store_gfp(&mas, &vmas[i], GFP_KERNEL))
> > > > -			goto failed;
> > > > +			return -ENOMEM;
> > > >  	}
> > > >  
> > > > -	ret = 0;
> > > > -failed:
> > > > -	mas_unlock(&mas);
> > > > -	return ret;
> > > > +	return 0;
> > > >  }
> > > >  
> > > >  /*
> > > > -- 
> > > > 2.39.2
> > > >

