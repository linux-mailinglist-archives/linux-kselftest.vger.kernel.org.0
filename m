Return-Path: <linux-kselftest+bounces-22582-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C23499DACB6
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Nov 2024 18:48:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1302DB215DF
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Nov 2024 17:48:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F8B21F9EDC;
	Wed, 27 Nov 2024 17:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WQKSPh0X"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5945819;
	Wed, 27 Nov 2024 17:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732729694; cv=fail; b=RdjjpO5LcHintT/nJdrgQkZkAqtV0RbLomK+OYawakXDiB1NBTAvYQnOqxnBD/7DRJwydI2Vz47gcQEWfXTjh9EfhVxj1LzkBPFAAks9rnky84HjkJmMuoC5Tdbu8zgnaUCi/ZAbmMWB+5iae8IgUIlbvP8bLLmMtw49XSKqC2Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732729694; c=relaxed/simple;
	bh=3y8kKJyhWf4wIagK9Iko/Xa1flRVuOaHVFprlRmMaOc=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=d+LlUDPSjkda5GKpNv9/8F5I2vr67InkT5Mcl7bFSvYBdoKQLO5Kta7MO5WvI5rjQ/8RbK3YIBtvqanqzW2ou+fhOZnrdnJoPmh13HitLmqgtHJWCI6+R2pIvU08CXO7YtZf4NClBzz0QUqoXwFlPCmfzAYuA6EzPozg/o5bhs8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WQKSPh0X; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732729693; x=1764265693;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=3y8kKJyhWf4wIagK9Iko/Xa1flRVuOaHVFprlRmMaOc=;
  b=WQKSPh0XPVRegFUMmInK44wSYq8C2bCtiFUTvaWg+7WQbkzsHGCeeE/0
   1WygoetbU8cQeEY7CBpxiL25QLXzPfLKhQexbLmAf15ItRVsqSqD+6z0A
   xs0ZH3lBAvc33SQPnRg6/jSp17CKWU6DJY9nnOnSJLj1AAAF4m5LF52sr
   Raul0LT0CjvwkRSKl1Trf8ggPS2s+PyTSqxuLg5tSLk5XRnFMNuKY4MnR
   7xdAYlf7dmS93MaUxExKD94+LxSsxs5eHaWpJFcUkBIRRA32QMwGpo0Vf
   9j4EiE74k0icvs/ZtN5P/db3vgPn8bY/I2nN6scATyI7eoM5Cq9UjAsYJ
   w==;
X-CSE-ConnectionGUID: 9ZjyrpUNSjydAqDlOoPN7w==
X-CSE-MsgGUID: ySGUdUmTTcOpewvbUmaZtQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11269"; a="58352828"
X-IronPort-AV: E=Sophos;i="6.12,189,1728975600"; 
   d="scan'208";a="58352828"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2024 09:48:09 -0800
X-CSE-ConnectionGUID: sKZLptItTCek6GzXP910qA==
X-CSE-MsgGUID: nFuSwi3bQH+wctMeWOf/pw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,189,1728975600"; 
   d="scan'208";a="96451956"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Nov 2024 09:48:08 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 27 Nov 2024 09:48:08 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 27 Nov 2024 09:48:08 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.46) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 27 Nov 2024 09:48:03 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p4NR/Rtz6IW1ffc2fmIOkVIwH3bCDyw2TshBqimp1eXCQAfMSokWT5tvNlEpBpigEsErkp+FVNi/yrMNHTbJqGOfa6XykZnsM0jBazNa42JzLjfjdRv4IN57oPOuz/Ou3kR14vlkdjXX8axUS6ihnLgtP79QaWpF6fWM67EYRgBUuUcZavVpb3XDprvlSjF+RGLVXoTxvBlKRae5kkNgrfBWGFADDjtJ4hOBEM837kg2FXo1iusqC6OTwbxeHsl4KzwJSbCUGAea3dJbKhWYhq4uKecO2Y93cdZn3WEQockbR22sZE2yK1jfHFKQhabqkIworiWwm4yk5CsKGfDXrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XJmRFgudGOzH/EJTje8qVc12xTY/61caHPDHdz0eY/s=;
 b=jtRoLn0UyoTTkhZoJlq4a5I8M97oKFRLDUkFJY8Q5EROlTTy2JVm9bt9SyRkkdc9R5hGc8MeiLnLS1OHPRmJ76E4xND0/C2Az+M5KeYw3ZjHbj5MQHLh7Nt6JWEfZGP1+y+PV0TlM94TnyakPvWDw76EVqVVjwJiUwC0hPMlo5O3uS5G8VWbrMV70H5uEV1PnthWu6DJY57nDFKkDJIF/Z2Pbny6Bg3t6451SDyM6/1PbmVuiNL8VLGe082BQwgg+SIM+64Se6BVfYCya5857HqjxuYR31yoJm/UNPCcpXXz7Ds3BTG77viZbF/i4TUloOcdJaf1DPTK7FJFmJVYIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6231.namprd11.prod.outlook.com (2603:10b6:208:3c4::15)
 by PH7PR11MB5983.namprd11.prod.outlook.com (2603:10b6:510:1e2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.14; Wed, 27 Nov
 2024 17:48:00 +0000
Received: from MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::a137:ffd0:97a3:1db4]) by MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::a137:ffd0:97a3:1db4%3]) with mapi id 15.20.8182.019; Wed, 27 Nov 2024
 17:48:00 +0000
Date: Wed, 27 Nov 2024 18:47:38 +0100
From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To: Shuah Khan <skhan@linuxfoundation.org>
CC: <shuah@kernel.org>, <hpa@zytor.com>, <x86@kernel.org>,
	<dave.hansen@linux.intel.com>, <bp@alien8.de>, <mingo@redhat.com>,
	<tglx@linutronix.de>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <kirill@shutemov.name>
Subject: Re: [PATCH v4 0/3] selftests/lam: get_user additions and LAM enabled
 check
Message-ID: <rzn6qnbyf6ug4ahjdiq2wmjgcqwr4m3fegfihfnovg5h44upu6@gb77ttnfarnj>
References: <cover.1732627541.git.maciej.wieczor-retman@intel.com>
 <2cff1613-9fd0-4c9e-ad02-970ac8614cec@linuxfoundation.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2cff1613-9fd0-4c9e-ad02-970ac8614cec@linuxfoundation.org>
X-ClientProxiedBy: DB9PR05CA0019.eurprd05.prod.outlook.com
 (2603:10a6:10:1da::24) To MN0PR11MB6231.namprd11.prod.outlook.com
 (2603:10b6:208:3c4::15)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6231:EE_|PH7PR11MB5983:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fdcc662-6539-49db-8eb7-08dd0f0ba2ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?ZoM1WilN2UjiDg/EL4/Q3LResw7IE1f7ooSzNJO8H90w8Yp329aymkbxbg?=
 =?iso-8859-1?Q?TRe43PEiRuim2S1FkOEvqOArFPIy24SqwZYdjDCGR5PhNolbhnRr8nUt9X?=
 =?iso-8859-1?Q?Ml4K4060MUjnTPm0yWTVvhr7NfnS4d6PUOq7KD8twNMRYppI5RMyRwoCS1?=
 =?iso-8859-1?Q?Y20LQb/KxzPK/gjlb7hgc82z6+ylO4GBBCZKUGWvAksQRcbkGRuoMgBoIh?=
 =?iso-8859-1?Q?1NJwK5ORxnK6YMifM5KDCidj47ovQQT60lUL1q9JEZZpC5aihKyXUO50SU?=
 =?iso-8859-1?Q?LjD6yChqJ65WMkF+WeK8AEp+ECi0D/cxIZwCOX/NwCkbd4qqXTLkVBJemx?=
 =?iso-8859-1?Q?7nifJoAuJ6yxTUmx1J2mDuJarXKv1hSiu9iuLt24Q2E7UmOC8k5N6sX54H?=
 =?iso-8859-1?Q?rU2i/YN+R+Y0SkMeuizpeoNvEvjKX8k/wrxzWfZHlYKZihA3YfM5Wb8fFn?=
 =?iso-8859-1?Q?4eSumBYa0sQXBzXoTvvQ2luquGFo+YcgUTGxfr/LL0l2/unVM5JZAhNYp+?=
 =?iso-8859-1?Q?7vQbLL/RK2/SLQeh71reGYbc1vO8Pt8uxWlWvhH8jUibIvDSbxKy7L6uEE?=
 =?iso-8859-1?Q?QYxEwMq6UX1Ix7jHijSQg4RuhQlWLqzzy5H1P8ib+7Kikgwjr6J1mtfcF/?=
 =?iso-8859-1?Q?oRfTUI3MQ/b4BP1gQrZ6IS9OYkXav+cJl4TKkT7GD1amJl2LwiTqqiD04S?=
 =?iso-8859-1?Q?U4Zit4/qh0natkCjAY+lc0Cteqjhop3g93G2oe5bPw2Jg/Q1TwFKEOyZwL?=
 =?iso-8859-1?Q?bxtgUPg8xZ76+CLyfgI3TzDBmCXrEip05Ias0wTCnD6Gr2fGdfN6ZHhSD3?=
 =?iso-8859-1?Q?HsnmAUuySYWLNRs1kvdjibcVYBnWPzgShTsrT8DtRQCWK5U4cDKo1fUK/X?=
 =?iso-8859-1?Q?gZATh5hJykdM6XoQOgikWwgXeHBlccGif4LQhrx/NlJHNINLqQkeksAjxZ?=
 =?iso-8859-1?Q?4SLe40TN/se0HM17kv156R9QMbhftT9TwMIGfXviUwGDSSZwmx+3Hsgrb3?=
 =?iso-8859-1?Q?e+mWdOSj+2ULF7eAjsQraYOpdbMCUhKjrHcdAi8gEWJq/IilwYW/9ASW5e?=
 =?iso-8859-1?Q?Ma2ZB2CDt4/x4w+5oATiyB6TYAtU3xftBnGZi6jYVSJAJ2uE63EPZbXQqP?=
 =?iso-8859-1?Q?05wdSVPsxToPDwoK3x+2suMehygsPDpHkoOA+2qFbpPTWkubDRLb5vooRV?=
 =?iso-8859-1?Q?+piiOj/ZNRo9oWE3FN7iawSVdzV+QWKF4MaCEryzdJMv9fVVwLvhientOd?=
 =?iso-8859-1?Q?DSyqi2r7hEi1urTACZb3dh+tuGkNK5FIHCxI2/4zO2hwG0y+a0M+3PPdu+?=
 =?iso-8859-1?Q?nAL3ZmCH8EcmrbzL6bL7QBglcQniAcvPCv+mHuLV1KiH18A=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6231.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?LkeyIWch4vJ9DaiqkyDYJXeRPLZhQLzoSSAH4W9Fg79UHRKlf3NUVWEi4S?=
 =?iso-8859-1?Q?ezA8VisUQwWkyYQWgUZYgBlncm8BKd3554R+nG1tlyxMd7+3Z0OjMU8NxH?=
 =?iso-8859-1?Q?de55CtdkpVtD7RcpM5VXwZ0aRSGeSPbJbuVzZmdKl0jIJ+/p+8iXgluKPq?=
 =?iso-8859-1?Q?rrsMpIf5SDBRWQ3pbhi7WNxnvZUjiX2+3N7SIoAL2jpt8XrbDPtgHV19AL?=
 =?iso-8859-1?Q?6RHAYoi7N5ThXybIvrX+c13AzFEm7iOyt14cn/N6s+7nh9J+SydoOX0jMr?=
 =?iso-8859-1?Q?vXkN4BE32b0odu+elh+iWFFI1P3qvrav2RPNKOLJ9VC3qYCya88spDWu3t?=
 =?iso-8859-1?Q?OJI9mDBLBoX8r3HEbiwP2Vq+DrpDoOL7h7ShqMsHWgMCuao2mZ5k962MmH?=
 =?iso-8859-1?Q?hrly5r9hTtNKVvobpimxtVXlaEfDS+C6Dw6g5FRfvRYIVs5vemIxiiXvk6?=
 =?iso-8859-1?Q?E7FJSlNYzvELLWlarYGDFTw5FqmS+SrWiWFw9SpRSftu4ysb4B08UHtmqW?=
 =?iso-8859-1?Q?3JVEFHTmGcDWcoqglW/RRrOgxK4gc8WfLz2TvlAYsV7seI523j4U4l/RH9?=
 =?iso-8859-1?Q?6KhxjeW5xh9vs1SNiHFXH5DZbRadoGQ8iw4XxWd81CKYfp5yzJJY9x2SGS?=
 =?iso-8859-1?Q?Qex4ihtP2x/J+zrYgBmNFgAUxk5CPCY4p998lyYJnCBRCJ4WNaLERwdPCN?=
 =?iso-8859-1?Q?6iJRm3xB5SMbQPFl7I6B1cWmm06NPgA6d2HCXiRTAoKRJISPow1eWaR2ia?=
 =?iso-8859-1?Q?MEOIC4Id3tNHdzjOvGWJUV6mxr5XtbIy4JNtYmejw1qfw3hZwr7uIzqrOC?=
 =?iso-8859-1?Q?s5YiP4gqeGNepV82pgHo8RdYGeg5b5jppu1dHsWKsc6IPpu1at6c+Bs9Ue?=
 =?iso-8859-1?Q?3arPQOp/1aGNmUhcug0HaJBKooye3wC1C/j51ai2NcHFfgITe6q3I7L0+k?=
 =?iso-8859-1?Q?RyIgsCy83TYMhH48ugrYtl35SzpyJLhLwVY7g8bsQlYJ/cjMl+tmdQG7zP?=
 =?iso-8859-1?Q?TYL4tPRDXF23fLoU+HHVPBL1w9YHpXjNgs5D0DnQfinhgwEs/Jbf5W7v1e?=
 =?iso-8859-1?Q?NQCtBvMy3BkF67Me4mTi2NnPRdSIsX5Opv8i3jZKYnsrRWXh9viHu4L/rX?=
 =?iso-8859-1?Q?OG4QKv4e2fjHQUQ6Ml/WSI1b9MCwg8b8Dozh0sSqyHiKj8HkXoh2ICg1lP?=
 =?iso-8859-1?Q?BtJDUlkAjd5iQcjRcCTcrxn1gtsQmDFl9KPadCh6gvGEpb2UGztrrERMbt?=
 =?iso-8859-1?Q?s7mYkxPuh0Et4R1p/A2HvVqt584Sq2Ae49rOF15ajqymkldl+7PobYm/Wg?=
 =?iso-8859-1?Q?agYL1Ha7kLE/RAqXVTjzYV52AddLc/3OxB+JbzlENbIWYJ+RWCrC45sn6p?=
 =?iso-8859-1?Q?3ZZll3xgSpC9Pe1+XVhKdRJoLbavKOSVugSVE2pjsAQOaxvtZJnhcMM3Pg?=
 =?iso-8859-1?Q?smPsAT+R0eqrOAbSgSUvqvFdxM+1z1IqQ1OAxgQhNAJHpoCNWbBXP3WcPW?=
 =?iso-8859-1?Q?sBy5xntAnEk54qfPUnriZ2duIhwpHemEaUd5R9N+RqCLTfvkDy+a/Bv24P?=
 =?iso-8859-1?Q?HwxZy3ZCkXV9CGj1DbDsLULMaVzvRTk3ywPtOwsE+oSKvmPb+wBiS8GjUB?=
 =?iso-8859-1?Q?Ksk7Q+5vxKkYdfE9cU8lFLAEQV2x/z9kNoknM+K+0ckgPdCBkMWgVUdTyi?=
 =?iso-8859-1?Q?Lii2IyNmE8hLclIJu4s=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fdcc662-6539-49db-8eb7-08dd0f0ba2ce
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6231.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2024 17:48:00.8742
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QuqN655XPkOTgFz87c7Jscs/Jkh/chNzzmddMIlX8VGRGk0NoiPcs+ltYw0OM6WOek7saej7BwD7J869JgG7fswEnb6zRutoQmi5GI1QGuE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5983
X-OriginatorOrg: intel.com

On 2024-11-26 at 09:34:36 -0700, Shuah Khan wrote:
>On 11/26/24 06:34, Maciej Wieczor-Retman wrote:
>> Recent change in how get_user() handles pointers [1] has a specific case
>> for LAM. It assigns a different bitmask that's later used to check
>> whether a pointer comes from userland in get_user().
>> 
>> While currently commented out (until LASS [2] is merged into the kernel)
>> it's worth making changes to the LAM selftest ahead of time.
>> 
>> Modify cpu_has_la57() so it provides current paging level information
>> instead of the cpuid one.
>> 
>> Add test case to LAM that utilizes a ioctl (FIOASYNC) syscall which uses
>> get_user() in its implementation. Execute the syscall with differently
>> tagged pointers to verify that valid user pointers are passing through
>> and invalid kernel/non-canonical pointers are not.
>> 
>> Also to avoid unhelpful test failures add a check in main() to skip
>> running tests if LAM was not compiled into the kernel.
>> 
>> Code was tested on a Sierra Forest Xeon machine that's LAM capable. The
>> test was ran without issues with both the LAM lines from [1] untouched
>> and commented out. The test was also ran without issues with LAM_SUP
>> both enabled and disabled.
>> 
>> 4/5 level pagetables code paths were also successfully tested in Simics
>> on a 5-level capable machine.
>> 
>> [1] https://lore.kernel.org/all/20241024013214.129639-1-torvalds@linux-foundation.org/
>> [2] https://lore.kernel.org/all/20241028160917.1380714-1-alexander.shishkin@linux.intel.com/
>> 
>> Maciej Wieczor-Retman (3):
>>    selftests/lam: Move cpu_has_la57() to use cpuinfo flag
>>    selftests/lam: Skip test if LAM is disabled
>>    selftests/lam: Test get_user() LAM pointer handling
>> 
>>   tools/testing/selftests/x86/lam.c | 122 ++++++++++++++++++++++++++++--
>>   1 file changed, 117 insertions(+), 5 deletions(-)
>> 
>
>Looks good to me. For selftests if it is going through x86 tree.
>
>Acked-by: Shuah Khan <skhan@linuxfoundation.org>
>
>If you want me to take this through selftest tree, I can do that.
>
>thanks,
>-- Shuah

Thank you, yes, that'd be great!

I also just resent v5 [1] fixing the small mistake that Kirill pointed out in
"selftests/lam: Move cpu_has_la57() to use cpuinfo flag" [2]. Could you please
pull that fixed version?

[1] https://lore.kernel.org/all/cover.1732728879.git.maciej.wieczor-retman@intel.com/
[2] https://lore.kernel.org/all/6kfafs7wio7ruth3p54pezqwcultxqqpnjvehjzaz7hlba4rp3@6kb5zdqfglsl/

-- 
Kind regards
Maciej Wieczór-Retman

