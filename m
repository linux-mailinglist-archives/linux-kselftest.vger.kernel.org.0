Return-Path: <linux-kselftest+bounces-10283-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA0968C7185
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 May 2024 08:01:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8CDE1C2103C
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 May 2024 06:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4084E1DFCE;
	Thu, 16 May 2024 06:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Yezi5NUn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81EF1847C;
	Thu, 16 May 2024 06:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715839294; cv=fail; b=jXdxU3tDWPb6lj/4GB538vRyYDMFAYhS3kKPrXnSna8wegLA82qQQzciQvnaTc83QQyGOoSWxtGS0jhONPfCQbGlBDEaIFDvmoalNbeaKNK42nU3er/NeqEf0OqXKuFmVDCOqVWSAUwmchiqQv5qDozczx3gV96vz6SZC8u9o3A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715839294; c=relaxed/simple;
	bh=eWBVm7BVOrOcZffgVY3yBbsaFnm3h4BNrXsMJbGq6Ic=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=E6RSy89tLHtd/Y9oKMzIIVMb5XmjYYaTYh/9GeLNTC493KDanDnl+bZ55Yv4YqVGPX6PFp9ZXnWTf1CkS0BeQ34EH3ua1iLgy2Hd7iWLvoyyQp70vxtLHz8tzD6g7JVk8n2ulKV1jQwnJnCFWjCLglgOvcAaXpy5kDN9mNWFjPo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Yezi5NUn; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715839292; x=1747375292;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=eWBVm7BVOrOcZffgVY3yBbsaFnm3h4BNrXsMJbGq6Ic=;
  b=Yezi5NUnWxbv6QK08Fp+fEQA3IVFBXz+9uBTTd5o39rSleOmf0bYZSnR
   MB6JbMFOLK4xPv2aMDg/6MwdfTCFNLWcdRGkh4IpxMwcizAsZE1iStnvO
   TSUuLGFSgefaaYVqjKhP2EygBs/vhJPPyHkbyl6DQCL18hHBKVFg5LWvN
   6O8DTJhUJxeh2RBjpunFK77INvZs2jPhDbF0DZhyYJl37PQch0ZR5AhQC
   C2GprSXRzC54dN8Yze8UdShbUmzks7pvhTgNWfs7IZ8OD9rZccR6bKW3E
   ohHbrkp8pkOfb1QfpLlpbeYi5SHwgZXg3+nqkOEubLMSNEICKVKo7cqn7
   w==;
X-CSE-ConnectionGUID: OVIB2FyqT6aklF5TFyWq0w==
X-CSE-MsgGUID: mPMcSfDGSpuhFyWoIHlu4A==
X-IronPort-AV: E=McAfee;i="6600,9927,11074"; a="12090770"
X-IronPort-AV: E=Sophos;i="6.08,163,1712646000"; 
   d="scan'208";a="12090770"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2024 23:01:32 -0700
X-CSE-ConnectionGUID: VL0LYJSfTzehEqPR5UYqsw==
X-CSE-MsgGUID: SPxuYjdDSo+fPMKT2UceaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,163,1712646000"; 
   d="scan'208";a="31137173"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 May 2024 23:01:32 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 15 May 2024 23:01:31 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 15 May 2024 23:01:31 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 15 May 2024 23:01:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c8jFXgQY087UHiM8FMphIHHmTeIpsRwvSBOJmT6MkCAa6B7jC9wDyw4vItxQ0kYuPrwnWWd+irc/SSUDDnetjmare1oTEiKt51+/LEy8PG8PJOP6OGYjMpRHoPFMPz8JzIyYK6TpX79BUJPoZAxdInmiW71LVTvxE8qKXw67fOza9d3lPJ43oF45ZRuIfeHB8LqdsVI7Ch798COIlwzHViWFYuYXHYtKbj1n8freOiO5qfXE9eCrPojp2PfXu9sB2jBvszaFvC2pu7y8TQVZxkQPeNog8nfqI4ZuzY+VzTurbEL/XWiKSlCLexb05sQ4O5WDS3YbBZjRSn2g0j4aLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jPJr18JHNfb7Bjk6NpI8FZXs8QSuWJaQ05KuhmqlwmU=;
 b=XSYtfRWENfowpdVcy9jK9weHTLLiY0uLUPyqTsJm6cN1P5SXs5jOyOf7QZNuGJo+QITpvmxnVg3Oc9L1MyxDpeo4r2PlMooJezR3q6R/7fvRXGwuWVJBMIAWrTCHaAzqHRVhl9IDGh7aNO5X3bIzYfIZPXH2LdAeAHVzR1HTJt25Th0mlFsnsJQApJstTb0l9CihdKsS02IhJZHNZZc/q/q4P4O/3mhv5s7bXYy8AK+5mFSL3F7QuD3ZCWa0MkLEFwumQDIjX5MKc9URh3eeN/1HRleQQuconJLU2rZ1H+8uPnmPYkDdoBcIn9QIKs8LiSc2sv9xs5qzGrY++MxI/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6231.namprd11.prod.outlook.com (2603:10b6:208:3c4::15)
 by MN2PR11MB4710.namprd11.prod.outlook.com (2603:10b6:208:262::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.27; Thu, 16 May
 2024 06:01:30 +0000
Received: from MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::a137:ffd0:97a3:1db4]) by MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::a137:ffd0:97a3:1db4%3]) with mapi id 15.20.7544.052; Thu, 16 May 2024
 06:01:30 +0000
Date: Thu, 16 May 2024 08:01:17 +0200
From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To: "Luck, Tony" <tony.luck@intel.com>
CC: "Yu, Fenghua" <fenghua.yu@intel.com>, "shuah@kernel.org"
	<shuah@kernel.org>, "Chatre, Reinette" <reinette.chatre@intel.com>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"ilpo.jarvinen@linux.intel.com" <ilpo.jarvinen@linux.intel.com>
Subject: Re: [PATCH v2 1/2] selftests/resctrl: Adjust effective L3 cache size
 with SNC enabled
Message-ID: <7apqfgfcb3mns3dmnmvwlvuhbqn6yht3tprrcd4lyavt27u5bw@bxulqnh6blle>
References: <cover.1715769576.git.maciej.wieczor-retman@intel.com>
 <fe9295c6be677d187b1607185e23993dbfe74761.1715769576.git.maciej.wieczor-retman@intel.com>
 <SJ1PR11MB6083320F30DBCBB59574F0BDFCEC2@SJ1PR11MB6083.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <SJ1PR11MB6083320F30DBCBB59574F0BDFCEC2@SJ1PR11MB6083.namprd11.prod.outlook.com>
X-ClientProxiedBy: DUZPR01CA0181.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b3::22) To MN0PR11MB6231.namprd11.prod.outlook.com
 (2603:10b6:208:3c4::15)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6231:EE_|MN2PR11MB4710:EE_
X-MS-Office365-Filtering-Correlation-Id: b9261b90-37e4-4ff1-da87-08dc756da15a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?fHhJ6Ac0BH/KbqO0GMM0vHK6s2vliHo56/RiWdnRI624/pDJf9+iuPYIfd?=
 =?iso-8859-1?Q?uVM2iSuDiz5nNEToO3l9h+hSLIRUXDRH69svitjMTrkfQx64tiiW5atA7U?=
 =?iso-8859-1?Q?Cpb5N2Rgi5+BRq36gvtIoi+bLY4F0e9aFnX9GPUTljSpZefQvgg00+MprB?=
 =?iso-8859-1?Q?D6fKx4+tvZGwoqsfpEoDk9c1t/yb0BrFpWLsq8rv8yktintF9wyv3MnZLu?=
 =?iso-8859-1?Q?CHDsxH26io/n+mSrbrrQS64Eb2I/OHzsYBUIXO1UeeF7PAB584D5fSEVrV?=
 =?iso-8859-1?Q?/fwxK9tsg1uE2Cwu8Qv+74CS5u0Wmho2fiu3cV/IKfDhyjuFfXj4oc8OD1?=
 =?iso-8859-1?Q?6I34l+b4x55OFbk+58Ho5va0b/Yt/xTb++l5m87b0VCb43GEXEhjhjkmjn?=
 =?iso-8859-1?Q?RAx4Mm/O5XoOcKL8gwm+JOCYFSpW4C9CPsU3WF2zCuVIEgMAZUTGFn15fT?=
 =?iso-8859-1?Q?p6UjuFCrEqFFTaSiXcNNTuud+KpcV8eCdRGXJhyN40zRoGZglXIrKkM+4U?=
 =?iso-8859-1?Q?CfEJtF7l/XrhCPADv12dsItr2VitphqOVAJDPUOIP9bvK1dRzo40LSV/dr?=
 =?iso-8859-1?Q?n6ZFeBA8J2VCrlKSFNusGD6SUQkIwHLei1Mf7ls/tLC5stnWXRFoKAR94r?=
 =?iso-8859-1?Q?zdup2ZGB07JvfdOapwMcSU7YZtOl3DcwA/I94ATK/ZCckC5NJI/+0NFvyW?=
 =?iso-8859-1?Q?rQuhrYIVbmtIQ11iDoKiMa+Ce/6RpAw2YMnWir2NvAFx6vcP0FmXMJ1m8Q?=
 =?iso-8859-1?Q?HNZQ2jAiiYrHHLjoe2LqK6Jw+RxkXU7N4QSRjR0JTti+4VKqluTVqz76xc?=
 =?iso-8859-1?Q?eY2dpaGlx+qKAeooC7Ag9J78kDI+tC9oEVcg7wNVf/IZojixGuEm8mOrXm?=
 =?iso-8859-1?Q?pLma+bYt6uGi5OzccJfJ1nHlalo3tdlgtUQR+Lp3A6ns+99ZAKJLq/1Pha?=
 =?iso-8859-1?Q?gY1/V1kf5mTz0fvM6mSu8GEiAy9VQy/P5u5UnTKzkoeK0M6ylk9TZoULNw?=
 =?iso-8859-1?Q?DQlMBnH50+vYRZaZRWyDTO2dr8NR41fDm+wFBfcu/ZpY0S1Ai+7O9af7gJ?=
 =?iso-8859-1?Q?dGlYlkHMk71DWeh+FNR9m3c2rTrq4VshXxAoq9rYS5uVFKfMN5vEc7e1Zn?=
 =?iso-8859-1?Q?CvUD7k/sPvNf3CvpI8DwE4Ounj9wrzvRj9gJ7RqKeCEN0cdpEayPKoLCG5?=
 =?iso-8859-1?Q?DFQJWWbWC0fc8K5X+Zbb7bdMMYuIyDq883VkIRrM9gT8aMLYbReGzynlLS?=
 =?iso-8859-1?Q?9R71lmqUuuwPBicy61+ldAGg7me/iNB0tW5T/5pA+8zhO7+JjbwX3ZJolg?=
 =?iso-8859-1?Q?pu3Xsmt31Nsmf9F9FRlDbuSb2A=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6231.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?LgJq/XBNxVNfdk293Itr7gPOrD8gF9Dzpl9UO4gPYtRj5WcOzOhJJCY9Er?=
 =?iso-8859-1?Q?x6rH4HxVLv0t6QzxKAMzjRWBmZi4kfjHIaHChSNgf/klP3cHALpARWpah0?=
 =?iso-8859-1?Q?0NohRJGavwlV7Gh+PRRmonin+HNqIWrho/2HXWIQwcDd3obbg0TfE9IAWQ?=
 =?iso-8859-1?Q?crQHWqL5w+K9PgMZhqiXskC2iQ4LEcO5Uab743hQ1GEilw+a348PFGkvXc?=
 =?iso-8859-1?Q?+WbDfCOPdEVknWVY8zmJZbskNWPG9ZrcH+KhoahJ8EGjObmcHwjVv4Hzx2?=
 =?iso-8859-1?Q?CG3N+D5cA+QPtnRDLGCLikrRsn++/7ZgYr/iYaU+E1Hn30YhpQ+Zp2Pm+m?=
 =?iso-8859-1?Q?zIqE9yJYrx+MOu80EZ80db9vZ9MgFIp1dbMQf0gUeJNPJeybEtDlb3cZUU?=
 =?iso-8859-1?Q?TVlohmS2lsouIqIw5zDjVU1mXBv+taOOy3KOtGUNfJvDm3trsWF7nSXoGg?=
 =?iso-8859-1?Q?CUdBTEocJPGwsdA3qzlZ6ZoQcGBNOdJHp2524ILsujsLXXHcWdzVnBQevK?=
 =?iso-8859-1?Q?m5Dp72eOwrZtD6kkaXFPXWXbqAwWwzkMuJ40DvcmT/RcfRnlEBzeNNtAJC?=
 =?iso-8859-1?Q?OAnDjvOe3evSDVuYXFeAZL+HLbvbRfjYMLbE4D9Tm1JwL1IPObOlFSQArs?=
 =?iso-8859-1?Q?W07Ut3x9+N7BjQQw7vuQyaViFkIp4XrrAKFcS30XNzWarpIiJVptLF1bO0?=
 =?iso-8859-1?Q?jX+qhsY+Q9G8uBSfGxQU5BvV/r0QOkGJfilROAEOC+PVXCPLWamgcmxVuD?=
 =?iso-8859-1?Q?ALexI6F17/L4XaY6dsM+/uQGuyuuBr4Y+wK/bqJ6LTXDBVYvC5N1hRL7vy?=
 =?iso-8859-1?Q?1bcvHjJ+2zZNRGUnF6EqoXZ3v86f+0NbMIeJzUkfK4QVXd6eCZgBic1SRq?=
 =?iso-8859-1?Q?R/8NmE2gR6KA5jtgsCbTm5PvXCq6IT8dzNivaIRjN5Rqg0xH+0mTDtQqvv?=
 =?iso-8859-1?Q?cqVirkqOXtHs8HPDt7E/YDxRZFyScAaH5EqTeAd38Flqpgnu/zErUfQ4EX?=
 =?iso-8859-1?Q?sEIegoAJh96ZloeYy0PWbdVUUbyzZKwtd1lbuMmso1QVbXKsXPKeT5Ft6g?=
 =?iso-8859-1?Q?52TPJoGFLkisskmDYPeLv3+6QLQTn8QYxa4dKdZetV1w3/1/BNIms1KAZy?=
 =?iso-8859-1?Q?XEhUik/7+iZtScHxouJKtgBhDKcBrwl96quLBZn6gm6dCyae2UA0iFN9rq?=
 =?iso-8859-1?Q?/SInC69HoncYfquJ5hbEhnwAA/XtTGRkKg34Z+VK6uOOeXWS+j0qfHycls?=
 =?iso-8859-1?Q?FRLap5hT/mVNegRupXJX8g8sk7YCljk7TDydy6aZvSgYYNUBvpHifKsDdp?=
 =?iso-8859-1?Q?RwveceWyY4ZffsvG2oupSZSSQDpsaRAt4NDPh7D/LKh4VbD9FiOMz8bxyZ?=
 =?iso-8859-1?Q?yAnKRMHJk39reBwtTYEEEeqeaweYmbQvLvqiv7Ec2BQP/q57+Layu9WE9F?=
 =?iso-8859-1?Q?WcGqys87On/H/o31DCFbE1FfnceR2Gxh1yCESN0KSvjRjI2eNYz0Ag3PH6?=
 =?iso-8859-1?Q?jg5QrasFEdmxMePNx2+xR5UX5ketIxTyR3Vflwz1Mnd/QlhYHPpqXFJtkO?=
 =?iso-8859-1?Q?PX+/OiZLLZFsUQCYeBu4YS2voPSUcV1Ek5ysM5jjYMj0rNxepbudFB3l4Z?=
 =?iso-8859-1?Q?dj1aBLAoJ0iSq0uCc7MpEtebL9kSzb6X8Dm7dGqad1zcLNb4+IWTd9na/o?=
 =?iso-8859-1?Q?JYCTnOpQWEyKo05aciU=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b9261b90-37e4-4ff1-da87-08dc756da15a
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6231.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2024 06:01:30.0223
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wxlyqT0RGRpt9FJQzHYD++/VNFt7qAgLdgoATnxQqrXFZhTclJRj2Fb9elhSZTPa5sRp4/XohBeMQpzE7jAf806GbZRzdutZEXHkhwa9u0E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4710
X-OriginatorOrg: intel.com

On 2024-05-15 at 16:48:44 +0000, Luck, Tony wrote:
>If/when my SNC patches go upstream the SNC check could become:
>
>snc_ways=$(ls -d /sys/fs/resctrl/mon_data/mon_L3_00/mon_sub_L3_* 2>/dev/null | wc -l)

But this won't work without your kernel patches right? 

If they are already in the kernel used by the person launching the selftests
then there shouldn't be any problems to report. The idea was that if the
CMT/MBM/MBA selftests fail, the message with "SNC is the problem" is only
displayed if SNC is enabled and there is no kernel support for SNC.

>
>assuming you have /sys/fs/resctrl mounted.
>
>-Tony

-- 
Kind regards
Maciej Wieczór-Retman

