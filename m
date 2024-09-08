Return-Path: <linux-kselftest+bounces-17447-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A6C99704C4
	for <lists+linux-kselftest@lfdr.de>; Sun,  8 Sep 2024 04:24:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07614B21CDA
	for <lists+linux-kselftest@lfdr.de>; Sun,  8 Sep 2024 02:24:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFB50134B6;
	Sun,  8 Sep 2024 02:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Oq3CsNEn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AE7824B28;
	Sun,  8 Sep 2024 02:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725762265; cv=fail; b=phu/H89TWlH27KxpY58Vy0NqaSnugtMadXhFr4NKA/ZdfaDvBQInK/uiSI/QF2/WLqScaEqca0jeWh7EN1++5emiGSDTnlay5f5W1d8X2MeeiEwgVukH+o2zL2mb3MOWwOMIwiw6RkD4k2hPXulZkgHKxEszHvDXyZYV9ObgNx4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725762265; c=relaxed/simple;
	bh=CQTH29FyN34M3Q6s36wMjJnh2SoLx9BSd4aLbr7qfS4=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bWASlZykB/xf9vmhXK5NeuqY2+ABYgqzJifrkNpUdZjjdhZ/w1ue0p7l5pg1SOK2tdJBBTOfD2sGDJf5wjfRYM4KDfoLGkrYZP3t63JmmpXrBQ/WjP87vgDDwubIT5CkuqGfvLS4xV3bvmlmwyDzRGRRvIFhqM1iN1dg8X93xic=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Oq3CsNEn; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725762263; x=1757298263;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=CQTH29FyN34M3Q6s36wMjJnh2SoLx9BSd4aLbr7qfS4=;
  b=Oq3CsNEnXHZDQ5uF4lKSAJWGisg+tq0rUjrVnKKcIkcK3BQby8a7UoIJ
   /mCrjh4+IV7a72fFjzhZXeLMB6CHaLQc8xZusbNu/SxBGztOCE3wu3IXI
   Z+wQ76FhXi69O+IVUAkgfiFPQRbj+eLMYzbKFF0CmPdR7OOhle2diX/VG
   gLYXy60hO67To4SGbLawPDsFmRof030A744jnoEtFroV/uIPT9z9TwQ4o
   Ma+EEuP9dNCLMgiZImvDc7AtdT8XBZBBEWgk/VFwNDF3CmFnR/+OJcAaM
   ZXhRwLiZh+ywzW3s2J4rBs6IDXSTlFWIHFzDudKgxxprQhSEPxEBVIfUh
   A==;
X-CSE-ConnectionGUID: lT44jyGRTHCwF2u1vT76gw==
X-CSE-MsgGUID: iIdZevbuQuyPGEvXdmJk/Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11188"; a="28223751"
X-IronPort-AV: E=Sophos;i="6.10,211,1719903600"; 
   d="scan'208";a="28223751"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2024 19:24:23 -0700
X-CSE-ConnectionGUID: crAB66qwTcK421bPOAon9g==
X-CSE-MsgGUID: ird9zRqeRG+9uR9tHHlzKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,211,1719903600"; 
   d="scan'208";a="70442671"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Sep 2024 19:24:22 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sat, 7 Sep 2024 19:24:21 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sat, 7 Sep 2024 19:24:21 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sat, 7 Sep 2024 19:24:21 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.172)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sat, 7 Sep 2024 19:24:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QpUJMV4yQ2BBtte4i3qHG4PUtACTQeJYk3Y12x5VvTamrWje35H6/pV1QzAdp2hulzfEgs60RD4GgyhtR6gapWGEDTb7pa9s8UujkCax0JE2egMFhwPsjsnHWrWlIv+t4Swg9cfl8UrclNbERsUnRL04pOXud53489wmWdIzzw01FFg/9IGotnG7xwNOmgw93LfZQBCbOeZvsexBNrX2EKF53/t5XNnJGC8NImA8oTD9JkzilKVvBcbtxETtlb7/fSs0sljoLCsFleEjo3dach/glJq2nRoLSnqdqmJJeTG5QGk1bedU3OQ5cKt9Z5EXB+rwCSmVdB/nQ0QPKLpZsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kJzaCHnlGFDKi60nRIg6Bc5nzu64aX+gwpMjnkOZUcM=;
 b=rQ6PY04y8ILHsYY5dTiWPtFg6W3Qto+HRaNcbNyRmUaRreSkm8Jf+Kc/rq+D4TXKJU7ZsxFSy2NItkewJqHJgUk9zSgYON87rkPo+yUiyIfYrBwKgpvoKPpk0tFT9+C60ZNwnKlYQV7D/YAztaWNphSvXnTvKrWaMqo0K0opnWh1MZ+N3mwk/VK3Bd6HueSZYEpLJgI+xz11JRdUWDDhJMVVXChQP2QqOcxCk0inM7maROu42uRC93K8rGeJFzgevOde4/dOy987V8TflbPyvoqlMPZfMjBgthBrwRccBWiw7HVS3h/RtcjncceFD8LuDotFEGHSg7muIeSoRKRA/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB5423.namprd11.prod.outlook.com (2603:10b6:5:39b::20)
 by PH0PR11MB5208.namprd11.prod.outlook.com (2603:10b6:510:3b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Sun, 8 Sep
 2024 02:24:18 +0000
Received: from DM4PR11MB5423.namprd11.prod.outlook.com
 ([fe80::dffa:e0c8:dbf1:c82e]) by DM4PR11MB5423.namprd11.prod.outlook.com
 ([fe80::dffa:e0c8:dbf1:c82e%5]) with mapi id 15.20.7918.024; Sun, 8 Sep 2024
 02:24:18 +0000
Date: Sun, 8 Sep 2024 10:24:05 +0800
From: kernel test robot <lkp@intel.com>
To: =?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>, Thomas Gleixner
	<tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra
	<peterz@infradead.org>, Darren Hart <dvhart@infradead.org>, Davidlohr Bueso
	<dave@stgolabs.net>, Shuah Khan <skhan@linuxfoundation.org>
CC: <oe-kbuild-all@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <kernel-dev@igalia.com>,
	=?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>
Subject: Re: [PATCH v2] selftests/futex: Create test for robust list
Message-ID: <Zt0KxQlpXXGvugV9@rli9-mobl>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240903134033.816500-1-andrealmeid@igalia.com>
X-ClientProxiedBy: SG2PR04CA0170.apcprd04.prod.outlook.com (2603:1096:4::32)
 To DM4PR11MB5423.namprd11.prod.outlook.com (2603:10b6:5:39b::20)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB5423:EE_|PH0PR11MB5208:EE_
X-MS-Office365-Filtering-Correlation-Id: a79a1222-40b0-438c-d73d-08dccfad572e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7416014;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?u78KV0YOo1tUCyyNxvW0Kbf8FwYrn3+FzwEVbc2BDhm93R/4alJzcD2rFX?=
 =?iso-8859-1?Q?lynn6jT9A802Efrg0YDuaMyUnwUMlNZKvxYjKWJr0YCoSI8heqY+C5XMdG?=
 =?iso-8859-1?Q?6sM71dlzsDYqFcIZwAUPW0fObIWEe22vrPYu/Yk/SpPejikzibCsWs/IVs?=
 =?iso-8859-1?Q?Lgh1NmlN+9+oo7m19TZ6HGPIEYann+dqXl4E66l8jfvdSX0kzCckUSkpRh?=
 =?iso-8859-1?Q?Ja8Q1j5mG6LMDxWjOkAgms2OMbvovguLQUowfnUeB0K5FS27Q310fEoV9a?=
 =?iso-8859-1?Q?04vamN7M0FIyh/qq39lmM+mhpBBNi05gvDvE7d+Namo/hafPXIGmOfMY5+?=
 =?iso-8859-1?Q?g0Gvw2Y+j764RJQzpxY886SuIddJgG5xlxhiLWiA/617u+i5RK9GQDrFUC?=
 =?iso-8859-1?Q?FFaxRcsd8GYayGOxH8LBWENHlY2mfP0oMgkxI21jMYHUd7LtZaqOnvyhcR?=
 =?iso-8859-1?Q?f9twPykE+Y22mLC8bHC3VDhOQywy7f6Zm9ahtg8UCs3aEXR/Sii2aZ3Rbd?=
 =?iso-8859-1?Q?Knkj5xYGOiG2D9y3usXZeWax+eqE2VTbx71apYaEwzvyQ3PzhAohWTfzJ7?=
 =?iso-8859-1?Q?/Rx9Qs3N8a6ze0F83s7MQLg3yksBYgEe2XGamsOMOO0cYM2awmIAwm31v4?=
 =?iso-8859-1?Q?oY1QLIgXUdZtb7rXVeXnRkjThjRmqRA1VgeLBZGQdXiIVcZAs+Pk8bPgUS?=
 =?iso-8859-1?Q?z0VeKJs2FCXzD2g2vtuA5XVVDkSJrCapEVMHYCnomEUPrp9EXh1iugeF7o?=
 =?iso-8859-1?Q?Pym1lcmBSh43IzXklJxAhyYcVC9l6X0vLN5Gk3oL8TjrP8sQ+znhlxM5rX?=
 =?iso-8859-1?Q?1eMeIZcYUgbMTPq22lb35KBJTDFUakv2nrrtv/xqcWwuNBAGRMoEuyexHd?=
 =?iso-8859-1?Q?ujJop+4WGtkOfOJMCXWXTJG2sKnLCb8jAEGIphjPzXnN0RDr6jQyzXDMdu?=
 =?iso-8859-1?Q?MMcxxwWkS6SiJBsqOvMV+U5u9RgIi6bQhok1DIU8Ik68jDYQwQrB9UvPF+?=
 =?iso-8859-1?Q?KFuMfsQS+ICg9ghcIEFHh9LUx8F/DAo732QBHExLVLwT65caJ+qDM++hg5?=
 =?iso-8859-1?Q?1CQGdvUeRUdXi2DlKtp8HdGYdJnTR5T88A8fzsOVLt5jDlCY1GgCQWs1wC?=
 =?iso-8859-1?Q?+mmGa70+3mYe65pyub2GgwdD9ipVQltO+B2mBSE+AaIbUhCU1KYqb9IBj/?=
 =?iso-8859-1?Q?N89xoy0LsnlvxOWuhu1sHDZ1TkfrAB6inX0Q1mUr1x8znZ6fxXwPSbKY0+?=
 =?iso-8859-1?Q?PvkOtFiWcE32kU8qU5zQIUH9/Z9IYfuhtsKrjkDLHheDiOFCjDKUm0npGK?=
 =?iso-8859-1?Q?jw/yu1Bfd1yzQkyWXHyYk294Y4RgIP2nbDR9V12pVUTDWGDXYm+PAeU0pW?=
 =?iso-8859-1?Q?zgGSitSdOg?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5423.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?v3et1sgMc6vYVfuaJJW+689sNdVPSCdIwvnwgECzDES4z9+hGSdPDZYoaA?=
 =?iso-8859-1?Q?MHrk9iDF+XHmwTNpWvvkckfdCMYZF7XnIkWRX0uBv/8qQajUcUhm9QEoOr?=
 =?iso-8859-1?Q?YlBMX9CLpRA5MWdtEpJ0cmu4lOdtv4zB0whjZmO95uHl0aZq2B0Eva1dU1?=
 =?iso-8859-1?Q?YSCTx7ihHZA6hbUBq/+gxO+C0pMiE7oCsi1VAntZENLouMg9P/1CT935Zn?=
 =?iso-8859-1?Q?K4YKy9Z8IZc3IneJGTS4eg9PxQ5Bd0dYXZAN8tVSFcINJ4npdBDh8sW+/x?=
 =?iso-8859-1?Q?0V7AAQgr9wdyhOflJ37jmvC2QXDFdIBiKzAZTorJHxVY297BB9Q4xNL0zX?=
 =?iso-8859-1?Q?W/mhCGJfYjQFBQ2qMtrzQA5WrYX6pFXPh5pFWoY+YU+/aKC63xknPq/Gvx?=
 =?iso-8859-1?Q?0MVBK2JXEUGT9w5UKZykND4kTZJNFPGJ0rjUCB8wTLSk05r1sfIyCSiGuW?=
 =?iso-8859-1?Q?gjxK3bgSsm28xtlg83PDk5wZCkTRiFLPokCpLK5u/y3NbSaAHy/AK1tTls?=
 =?iso-8859-1?Q?CYslM5PL9dyW1OouOSMkkS9rEHmfs7eTU5QSRfCH7JUiNi5Sp3VlBF+UVA?=
 =?iso-8859-1?Q?qdX+Nj5RYcngG0VK+Q06EjSZuKhBMYMuHp+YwOl6iK74FbuD5xlkRJuD/b?=
 =?iso-8859-1?Q?94XZcVRV35VEkaEY+ccKUMZiUCzCnDZxTUISiRDJzm5vyYhB/CnKdE/T4Z?=
 =?iso-8859-1?Q?ZemJYAVa9HC79oB5at8P6qD3rbP38wJGbC+vzj00vTxHyifAybzzNxqf/m?=
 =?iso-8859-1?Q?zi2wijLQmJn9Rn0FwdunDTA+Dq93nXV6YEz3G87AvYEKZE2jmQ/KiNZlKZ?=
 =?iso-8859-1?Q?SQ2z+oQdBRVzGDANJJ2pLLreCU0qvq6DDNAZ6y4rnzUG4CIy9/oUubCGZH?=
 =?iso-8859-1?Q?HuQImmiP2bMGvT2kQW5sHl39wgh8k7SHklsYXYcMjeJkE+PIRCBM0iV1Md?=
 =?iso-8859-1?Q?vrtu1/c+xRbYcHgdBXD4bBaAu8Lanbv5QgosiGmxemBlF3eT+4J5FYej1E?=
 =?iso-8859-1?Q?njKgqEEVnIWNbppuULbkny7+xPAeQnIrX7VjpbjYNOxoivF4Jk14ipVroW?=
 =?iso-8859-1?Q?m/aU0pSiWwyozv63XexZPBEaXRKS1BO3yzg21NkQRqNgiToh2fETSEjMP0?=
 =?iso-8859-1?Q?WDXVoBBrusMTq1wgnxx7r3lWaFufkKU2bNtn8s1jc6IozhQ5z++zp4aRvN?=
 =?iso-8859-1?Q?HhkCCSXLQie2AdiNx0FXgf+S/Rs3Axlq1un8auUlwI1P8/DBDJjUIqw13S?=
 =?iso-8859-1?Q?EtHp2f54qr8UAY/Dc5Lbgz2rW3p5NL3iW99UxXHR5Vl4P6A4/sT+LyBVtg?=
 =?iso-8859-1?Q?h02CjO1gA75zpRwTCKPBF/+0jCX283MpDt2jGjkyw4AK2XkdxRtTijsCkJ?=
 =?iso-8859-1?Q?Ktyc4PzktLSLDjcRVd7WgIbBCQl2+3SB73lqUkLOMxNssffvrg81Wh9dNz?=
 =?iso-8859-1?Q?Cneio7n+SZPM5iAHi49lvkzEDT6bavOT8BdtOLabsQy4gGga/9HZkqqMRU?=
 =?iso-8859-1?Q?ou1tFENf1YFHfMtZ+fj5ztW3IsT6b5y5LQgeaOKuh6s7KLWVfS2l4QIhIB?=
 =?iso-8859-1?Q?NcZM1LROFYrVfPDv2VcCcitjAoekn9sypRitC3nbAa5CUBybxRRIwgMR51?=
 =?iso-8859-1?Q?5KBNdydZLIlZzdekKSV8yV+awVlbNot+w6?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a79a1222-40b0-438c-d73d-08dccfad572e
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5423.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2024 02:24:18.0830
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oUUHE9dzouwzKOhk10I1hlcDfysYnCff2kwwYb4h/kRIqpYhnP1Cqi7hPcD3Q2MsCKcWYOkcO4owvqH4KfdbJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5208
X-OriginatorOrg: intel.com

Hi André,

kernel test robot noticed the following build warnings:

[auto build test WARNING on tip/locking/core]
[also build test WARNING on linus/master v6.11-rc6 next-20240906]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Andr-Almeida/selftests-futex-Create-test-for-robust-list/20240903-214428
base:   tip/locking/core
patch link:    https://lore.kernel.org/r/20240903134033.816500-1-andrealmeid%40igalia.com
patch subject: [PATCH v2] selftests/futex: Create test for robust list
:::::: branch date: 4 days ago
:::::: commit date: 4 days ago
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240907/202409071354.clW9RcwR-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/r/202409071354.clW9RcwR-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> robust_list.c:117:44: warning: passing 'int *' to parameter of type 'unsigned int *' converts between pointers to integer types with different sign [-Wpointer-sign]
     117 |         if (atomic_compare_exchange_strong(futex, &zero, tid)) {
         |                                                   ^~~~~
   /opt/cross/clang-617a15a9ea/lib/clang/18/include/stdatomic.h:144:112: note: expanded from macro 'atomic_compare_exchange_strong'
     144 | #define atomic_compare_exchange_strong(object, expected, desired) __c11_atomic_compare_exchange_strong(object, expected, desired, __ATOMIC_SEQ_CST, __ATOMIC_SEQ_CST)
         |                                                                                                                ^~~~~~~~
   1 warning generated.


vim +117 tools/testing/selftests/futex/functional/robust_list.c

32807b4449f353 André Almeida 2024-09-03  101  
32807b4449f353 André Almeida 2024-09-03  102  /*
32807b4449f353 André Almeida 2024-09-03  103   * A basic (and incomplete) mutex lock function with robustness
32807b4449f353 André Almeida 2024-09-03  104   */
32807b4449f353 André Almeida 2024-09-03  105  static int mutex_lock(struct lock_struct *lock, struct robust_list_head *head, bool error_inject)
32807b4449f353 André Almeida 2024-09-03  106  {
32807b4449f353 André Almeida 2024-09-03  107  	_Atomic(unsigned int) *futex = &lock->futex;
32807b4449f353 André Almeida 2024-09-03  108  	int zero = 0, ret = -1;
32807b4449f353 André Almeida 2024-09-03  109  	pid_t tid = gettid();
32807b4449f353 André Almeida 2024-09-03  110  
32807b4449f353 André Almeida 2024-09-03  111  	/*
32807b4449f353 André Almeida 2024-09-03  112  	 * Set list_op_pending before starting the lock, so the kernel can catch
32807b4449f353 André Almeida 2024-09-03  113  	 * the case where the thread died during the lock operation
32807b4449f353 André Almeida 2024-09-03  114  	 */
32807b4449f353 André Almeida 2024-09-03  115  	head->list_op_pending = &lock->list;
32807b4449f353 André Almeida 2024-09-03  116  
32807b4449f353 André Almeida 2024-09-03 @117  	if (atomic_compare_exchange_strong(futex, &zero, tid)) {
32807b4449f353 André Almeida 2024-09-03  118  		/*
32807b4449f353 André Almeida 2024-09-03  119  		 * We took the lock, insert it in the robust list
32807b4449f353 André Almeida 2024-09-03  120  		 */
32807b4449f353 André Almeida 2024-09-03  121  		struct robust_list *list = &head->list;
32807b4449f353 André Almeida 2024-09-03  122  
32807b4449f353 André Almeida 2024-09-03  123  		/* Error injection to test list_op_pending */
32807b4449f353 André Almeida 2024-09-03  124  		if (error_inject)
32807b4449f353 André Almeida 2024-09-03  125  			return 0;
32807b4449f353 André Almeida 2024-09-03  126  
32807b4449f353 André Almeida 2024-09-03  127  		while (list->next != &head->list)
32807b4449f353 André Almeida 2024-09-03  128  			list = list->next;
32807b4449f353 André Almeida 2024-09-03  129  
32807b4449f353 André Almeida 2024-09-03  130  		list->next = &lock->list;
32807b4449f353 André Almeida 2024-09-03  131  		lock->list.next = &head->list;
32807b4449f353 André Almeida 2024-09-03  132  
32807b4449f353 André Almeida 2024-09-03  133  		ret = 0;
32807b4449f353 André Almeida 2024-09-03  134  	} else {
32807b4449f353 André Almeida 2024-09-03  135  		/*
32807b4449f353 André Almeida 2024-09-03  136  		 * We didn't take the lock, wait until the owner wakes (or dies)
32807b4449f353 André Almeida 2024-09-03  137  		 */
32807b4449f353 André Almeida 2024-09-03  138  		struct timespec to;
32807b4449f353 André Almeida 2024-09-03  139  
32807b4449f353 André Almeida 2024-09-03  140  		clock_gettime(CLOCK_MONOTONIC, &to);
32807b4449f353 André Almeida 2024-09-03  141  		to.tv_sec = to.tv_sec + FUTEX_TIMEOUT;
32807b4449f353 André Almeida 2024-09-03  142  
32807b4449f353 André Almeida 2024-09-03  143  		tid = atomic_load(futex);
32807b4449f353 André Almeida 2024-09-03  144  		/* Kernel ignores futexes without the waiters flag */
32807b4449f353 André Almeida 2024-09-03  145  		tid |= FUTEX_WAITERS;
32807b4449f353 André Almeida 2024-09-03  146  		atomic_store(futex, tid);
32807b4449f353 André Almeida 2024-09-03  147  
32807b4449f353 André Almeida 2024-09-03  148  		ret = futex_wait((futex_t *) futex, tid, &to, 0);
32807b4449f353 André Almeida 2024-09-03  149  
32807b4449f353 André Almeida 2024-09-03  150  		/*
32807b4449f353 André Almeida 2024-09-03  151  		 * A real mutex_lock() implementation would loop here to finally
32807b4449f353 André Almeida 2024-09-03  152  		 * take the lock. We don't care about that, so we stop here.
32807b4449f353 André Almeida 2024-09-03  153  		 */
32807b4449f353 André Almeida 2024-09-03  154  	}
32807b4449f353 André Almeida 2024-09-03  155  
32807b4449f353 André Almeida 2024-09-03  156  	head->list_op_pending = NULL;
32807b4449f353 André Almeida 2024-09-03  157  
32807b4449f353 André Almeida 2024-09-03  158  	return ret;
32807b4449f353 André Almeida 2024-09-03  159  }
32807b4449f353 André Almeida 2024-09-03  160  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


