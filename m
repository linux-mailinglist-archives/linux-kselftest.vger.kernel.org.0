Return-Path: <linux-kselftest+bounces-21106-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7818B9B6548
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Oct 2024 15:08:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36C4728163D
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Oct 2024 14:08:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11BC01EF0B0;
	Wed, 30 Oct 2024 14:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LzFHmedg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D3631EE021;
	Wed, 30 Oct 2024 14:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730297310; cv=fail; b=AZfji4TeSsMmkdMLMsu+fPrWbXnr0hDdzdrjD5dDnXyktgO32zaUTwQwFTb8xTjAU74CrY3K40C/bK1ZgoK8yajunGjoKDC3T2Y47RMcApPWO9VhLlVPnVJ96v32sPGQ4Po30qlStONW7pgEzaHyK9TpzKVgVC7OE5WhKY0nh5o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730297310; c=relaxed/simple;
	bh=BhlQMLgeKj6gacN0MKuc7y2kZ0uzJBEbURGZKjsdVZQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=omqgYqoHX8ITxQ5WZHk63qtcT+ltwg0czPNpvorROk59Aaw3kZQaIqAd7mo2WA+n5I/wihlhjOzstlscc6r5/3udqDSppQFNM9woPDW+/5SSwgwkdvx9EvLJ2Xnh4aJytFw6odDKlH1fbsrvF4t2BL0QYvaKBFKHJdEk+9W/WlM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LzFHmedg; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730297307; x=1761833307;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=BhlQMLgeKj6gacN0MKuc7y2kZ0uzJBEbURGZKjsdVZQ=;
  b=LzFHmedg6CDZM7n1mzSq0PRaEQjpAIkoReb8FCn7gAtv14LRP+hostFX
   6fjL+lRVv1DY9AlVJeJmBynv+xNmQBUTBF4i7sHwMX29APxT2B71uzgWe
   EHxHCKtC/y+IwCov1XvZiIL5CZ3ePoc9aZfg775F83SBj0rrKY6MbGrjD
   YaaI7uSvLkXJNdVpcbv83woe4QTqR2XMk2V2R84e+SD7+xiwvI457QGE0
   36pPHSD0juPFUYkvNI4q6/NIiqkGjXo5PimSd52u7t4uo9oxv9jAuX5vh
   b8jSYBR8NY/6PI6VPB9HUXdClUqC6/C2SW4aNDc2ZXDwlGl/eiPifNJN7
   w==;
X-CSE-ConnectionGUID: ydJ9NlrFRY+boTnf+wtssg==
X-CSE-MsgGUID: LRxGjzyYS2WP2BSvIRmYlw==
X-IronPort-AV: E=McAfee;i="6700,10204,11241"; a="29417959"
X-IronPort-AV: E=Sophos;i="6.11,245,1725346800"; 
   d="scan'208";a="29417959"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2024 07:08:26 -0700
X-CSE-ConnectionGUID: bNB7APclSAyw/UkzLXSp/g==
X-CSE-MsgGUID: p8quXWQlSxaUQ2ChtWHpsw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="87113840"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Oct 2024 07:08:23 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 30 Oct 2024 07:08:19 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 30 Oct 2024 07:08:19 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.46) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 30 Oct 2024 07:08:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SCxzcXzc8trWlPKDGZTuJHHq/QYZ6F6RbLQ5yCeLkgekx+N1v7HM+EHvt+uZSI+flTQ+JB5jMdHh+0boRQT2BOfZb7nyo+cAymR3vh1DzFVzErg2LQPnMaarKAh+7NJemCHBeapPzZdFWtRjTstU2nGr4LI55787XcnIauh09e2yLykZsMZ+JvqjI08QT8GfF+wizXo5Iepr0PWG3mwRA9z+Bf3dffl6M8/TYiegJgD4grlrfcWy5JCx4/VPZi3dSyiuaV7SI+avMoet/he/nbispww+x4Ydc6rY+/RQnRCOyTkCrpeMxNnfEOcN0YAAieHmMGiYHquxQG1zY2SZaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+9dfeGMA1p2z0NeurHuugRmdlzVPNggzICVPnDYN4Yc=;
 b=Lnu8n3FM59ePHx80StOv0g4hCURUEE2sIpeRc1GtHF7egKM1rKqNwANxWjGi4GL3tisidXKffXN8BSS3yY4EdJ1coUJqJ2vPIgBxwyObkS0Uvx5UEEP9Qe3TJZpVZ7KgVMm48PfPiGThu5HMpweBhn67OYymDx3hXsMnbJ0c9I4UszJZ/oTCNOITcYGQJPsrOfi9+1+aOH5EF7pP/S93gbFBtPyK7aZc2wSESqT2MltJ0H0CeS3fnDn7b5lDUaIpTQlZf4TVXgsosuOEkGZBqsJTV2H43aDYfVD4aMn9Dwfvw3GrLRM1fkuXTkcrfXRV+eAMId8W/CDqiEoemTQnog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6231.namprd11.prod.outlook.com (2603:10b6:208:3c4::15)
 by CH2PR11MB8777.namprd11.prod.outlook.com (2603:10b6:610:283::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Wed, 30 Oct
 2024 14:08:13 +0000
Received: from MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::a137:ffd0:97a3:1db4]) by MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::a137:ffd0:97a3:1db4%3]) with mapi id 15.20.8093.027; Wed, 30 Oct 2024
 14:08:12 +0000
Date: Wed, 30 Oct 2024 15:08:07 +0100
From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To: "Kirill A. Shutemov" <kirill@shutemov.name>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Shuah Khan
	<shuah@kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH] selftests/lam: Test get_user() LAM pointer handling
Message-ID: <36yf4cvahtsavqaa5hzmfg6udde6geqw3cpr3hr45rx44qnfa2@53p2wvysdusg>
References: <20241029141421.715686-1-maciej.wieczor-retman@intel.com>
 <6va3r22jkgpk2kah7d3au7euiqrdeuooegezaguk4j4djfydop@3dpbdrl7akrp>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6va3r22jkgpk2kah7d3au7euiqrdeuooegezaguk4j4djfydop@3dpbdrl7akrp>
X-ClientProxiedBy: DU7P195CA0029.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:10:54d::12) To MN0PR11MB6231.namprd11.prod.outlook.com
 (2603:10b6:208:3c4::15)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6231:EE_|CH2PR11MB8777:EE_
X-MS-Office365-Filtering-Correlation-Id: f3bf2f4c-4ebd-4217-ab34-08dcf8ec4a2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?CwtPdwFykts1h6wY6aNMcHS4OP009EA5bfSIHYrTFHd+sxxrsQBn8SPF3R?=
 =?iso-8859-1?Q?fx0WuEXGPpvtXT7gvkiZlg4QGE5//Z+EpiEhXUGIhXTNMrkCpbsZgl1x4g?=
 =?iso-8859-1?Q?gaFCoDkVJLiuMXU0oe5QyU15ptsUXUIF/IvAxNVChYDTsSVeVV41ou2ISI?=
 =?iso-8859-1?Q?OWTWvKL7UE6qHlio/EE2rGrgY7iBHzWpKDZwJIvPLsfkOYQWTnsrWWC1HD?=
 =?iso-8859-1?Q?qkx8yHteDkvC3voweVzejr3FjdDs/znicrkYD2wuUL0CzNtI4bwc34UOrS?=
 =?iso-8859-1?Q?jlezdU5t4tVzSEWBq9JM5W0KduZBVWCjXKuu20BPvLW21k/IZ/MLif4oSw?=
 =?iso-8859-1?Q?QqGtuzgium3dBP+C/GI7fkTWSEDxt+XngvNFSjuWPplKERDb4SCrmk6AIg?=
 =?iso-8859-1?Q?bS+9sSjypyyxV3UOLAmq/+TsM0kNAgkdc9GJ1uvf+J5AholPjyZAN2zZKg?=
 =?iso-8859-1?Q?TcrDUgwg66D1Avm9V75SEY1syxdLyAZjw+O9+XHcF4szGaBehtKXXh79Xl?=
 =?iso-8859-1?Q?TzedO7EH/qOmkV+XELGcNvA32fPg7hRE+7a2isVPY+90WUjSZZGiuDiR79?=
 =?iso-8859-1?Q?5GSD+Kl6O1hpdBKq5gSBD5AeKWec5lHcni5TS8QHnlsrMV8ooBGKjDYC6M?=
 =?iso-8859-1?Q?0po8x1HwK12P1dyV+iYC/NtAVFpUx4g0ExSAjpHJ/TVT4KWa/fDMOXgSM4?=
 =?iso-8859-1?Q?4hk4F5JFg7RSv34a34EKZhOlJmN30YCe7H9nXfWnvUYjD8frNse9rHskwj?=
 =?iso-8859-1?Q?X+QaU63hWAZB8/uBTVzh2rbOJ8lo77nkizvZ8UyLN8rUEls4x1mCTrUUKm?=
 =?iso-8859-1?Q?2y2pGMf5Kk1vu986d+jJIFtGmG4M6gaNlBM2bKYd1hPfY7ZAEbsw8g5KyT?=
 =?iso-8859-1?Q?uyxy2nJaItf3mmlIcGEf+d+8gn2SuTZgJQ7TpiZCBU8EUJYU5WtGVmFoFj?=
 =?iso-8859-1?Q?894MiLp1VWbn7ndqSCmLRkItcXJmj0I1x2Ynj5Raa3zk7N1hsHx2vsd9j7?=
 =?iso-8859-1?Q?V5nJ/WKmyb/nGp+KHjBw8xDfKba1LGbZWifd9UW+pTaia6oI0y9LdOIVDp?=
 =?iso-8859-1?Q?hKDCckNpFYDtzH2QLLvU7NCNYLbWdveNXeG36DAfQ8Qa+dXw0kgf5+sNKc?=
 =?iso-8859-1?Q?0e3A2LeyIpUfOBjkD8U9DVxTY7blJ0Ozdwz+vD4ZexPM68Vq5XtuzFZ4Sy?=
 =?iso-8859-1?Q?ysUAp68oAz2iIyTY0vS04vTMNimbdiF6+B6ZbWradBAFJdg96ck1jNkrzq?=
 =?iso-8859-1?Q?/TQ2NLlQSTtKi7BK3oRvRVErP86gO513v8a9rDECvDzMbQn33GmtCBTwrq?=
 =?iso-8859-1?Q?Z878di4vTnK0Qc7ZLe2kgvbF2u9CYjbkZ3xG6e0v3boSUic2k5vfP/vYhG?=
 =?iso-8859-1?Q?KHrQtrQEDH?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6231.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?GhX0BJP1CvWRqnnZPxEcc7SqhsYT3goM/CKhdHj4ZzHfdPAafzKAAw3I6O?=
 =?iso-8859-1?Q?5BfReAmM2gCkTAjGWONkJHI64x8G4WXGdylAFGTDdVd1uF9bCCbY1xDsrM?=
 =?iso-8859-1?Q?sYePhsXtSXxn0LmIyHwGLUecAMlEbVwnAfojFwEC1Y6zO+dBauCw1RDaXx?=
 =?iso-8859-1?Q?aopCcGVU1it3bBho/+FSiNwP7RcWit5TECVE/VEUJaJghu88io2E8JhQel?=
 =?iso-8859-1?Q?1048HSthnOQ1ThnskPvOCb1pVr9eYyq/Qras1CCjFKmH/rzEa+HXkeK9ex?=
 =?iso-8859-1?Q?vg7Pg9rJZg3gX2rCewG0sZ/yPoVwb8BwLeZme03t4l3w5+jSnOKtJyZGGu?=
 =?iso-8859-1?Q?wHckmjE/+9K6ISdvww1T3hEft7QLbAO1JoGNzJLG1TAfM22SkRfU8AjkqF?=
 =?iso-8859-1?Q?UFUxJZ/8GK57iJOEGT4pDVuV/9gy/+YEi+TnId89JAnHlMBrIELIb9um2H?=
 =?iso-8859-1?Q?LnaWNAfkxNWKLj1fcaUBmJip2vZB47nNMlNpLq+Uls2bM6CsE9WoOWNZoZ?=
 =?iso-8859-1?Q?Lp8SuucFZjBWSbQn563meMhwParaEXs0y+5t1BItTPUVGCeKC00TjQ2QJi?=
 =?iso-8859-1?Q?Gd2btYNglHO1JWdd5K43F3BXOXOUuRJ7p5EA6qiV/f1xG5f5mczA9ibCxv?=
 =?iso-8859-1?Q?wo6BgUT8bkunwtiIfxsC7SM6DzweY0l8LoUFo+DQX3TVFhyuv7rCilop0/?=
 =?iso-8859-1?Q?ZdfaXj/GOgRfGCp/AewAaExZ8WU1u2faLKWSyQ+Ehu0F23CLC5KGILKicD?=
 =?iso-8859-1?Q?OCcYzlwrpziHhi9ZftSAz5t5iDju0JeTViKo8YReF2PASragjT9fdHJW3J?=
 =?iso-8859-1?Q?sHZ4lmEmdubWkpZuiJl7+OfamaoFLqfqLRT/5wMOQfkSOvH+XDdi1Mw0YM?=
 =?iso-8859-1?Q?8+UAxZfDZhrGsGu2OB8e+rFiCQDarZuPWmGkYzJOxYQx/6HjSEN7UFHOkw?=
 =?iso-8859-1?Q?6BCYno1dknTs3XaIcqzZGaveyhishbj2GXwRpmORZc5lxtZG6U7w9F/nhb?=
 =?iso-8859-1?Q?MJWQW63KIVrxWQx/Zy4BGs2lW+glT3LVGOosVYfQXAH6htYRGU+3xV6hpX?=
 =?iso-8859-1?Q?sxSrH+DQkQQN7Ypwd3Q3/cws/sW6QSykixLic8MkVt2VpjsgRFtctbwba9?=
 =?iso-8859-1?Q?/18uxJa8KtATEFruCgjeJkqmj6XMCQkpzcGeV+SdNcfw+HHeyZ5zmOYan8?=
 =?iso-8859-1?Q?1gIGFsOnX+9x8CR2JLbipujqZp/IbXmFH7kPZLVjyVkVRhVr5XZbhwWO/w?=
 =?iso-8859-1?Q?Ovj6dql2iZO6iNupqMedsl3ZOCjlEJyv/EBK9ysQyUFG+ag5dMvkUCIWeP?=
 =?iso-8859-1?Q?9ZWbvZFVKyAJ2BoiPMns8CC9kb+IHZqH2kcoauJbA/1ka4z1OFYAiIoVoV?=
 =?iso-8859-1?Q?XL+YsBVuohzEk0wBmx//nTdYsTH2sdJrzmhcnZ+4F492oEjWwLqkjdKC2m?=
 =?iso-8859-1?Q?qDgbyzvl7ehYKteB/Guossk/tofQZ90jyrwiAv9bhpQljyMUisVmi1vDRs?=
 =?iso-8859-1?Q?04Ax2iDxwPjvKHYQKB1USWxQu4K2u9Earzg44dyNN70Sjg+p9l7nJ5fZ/u?=
 =?iso-8859-1?Q?WHzUEsjMe2B3SvxVtgX8L57ZK1XQDn5u6R5oN5ocuaRJfmo18IuUnp1TLY?=
 =?iso-8859-1?Q?QxjaljYpKfbXCypxS2OfYPa7wRHRuork/pl2+57aHl8x6HvW3mf8f1iQnG?=
 =?iso-8859-1?Q?IPfeCPVIZLX1I3NS9ng=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f3bf2f4c-4ebd-4217-ab34-08dcf8ec4a2d
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6231.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2024 14:08:12.2524
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nvelDijjAfQwtO+0WJB5Nzu4Wvuq7++o0YaouNbZgWV4BTi8gEd97zy1WS0WYgPSmZYpjG0BvkM9OxAYQUnplKzf/U0Wx0S5xLL67pPL9XQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR11MB8777
X-OriginatorOrg: intel.com

On 2024-10-30 at 14:31:51 +0200, Kirill A. Shutemov wrote:
>On Tue, Oct 29, 2024 at 03:14:20PM +0100, Maciej Wieczor-Retman wrote:
>> Recent change in how get_user() handles pointers [1] has a specific case
>> for LAM. It assigns a different bitmask that's later used to check
>> whether a pointer comes from userland in get_user().
>> 
>> While currently commented out (until LASS [2] is merged into the kernel)
>> it's worth making changes to the LAM selftest ahead of time.
>> 
>> Add test case to LAM that utilizes a ioctl (FIOASYNC) syscall which uses
>> get_user() in its implementation. Execute the syscall with differently
>> tagged pointers to verify that valid user pointers are passing through
>> and invalid kernel/non-canonical pointers are not.
>> 
>> Code was tested on a Sierra Forest Xeon machine that's LAM capable. The
>> test was ran without issues with both the LAM lines from [1] untouched
>> and commented out. The test was also ran without issues with LAM_SUP
>> both enabled and disabled.
>> 
>> [1] https://lore.kernel.org/all/20241024013214.129639-1-torvalds@linux-foundation.org/
>> [2] https://lore.kernel.org/all/20240710160655.3402786-1-alexander.shishkin@linux.intel.com/
>> 
>> Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
>> ---
>>  tools/testing/selftests/x86/lam.c | 85 +++++++++++++++++++++++++++++++
>>  1 file changed, 85 insertions(+)
>> 
>> diff --git a/tools/testing/selftests/x86/lam.c b/tools/testing/selftests/x86/lam.c
>> index 0ea4f6813930..3c53d4b7aa61 100644
>> --- a/tools/testing/selftests/x86/lam.c
>> +++ b/tools/testing/selftests/x86/lam.c
>> @@ -4,6 +4,7 @@
>>  #include <stdlib.h>
>>  #include <string.h>
>>  #include <sys/syscall.h>
>> +#include <sys/ioctl.h>
>>  #include <time.h>
>>  #include <signal.h>
>>  #include <setjmp.h>
>> @@ -43,10 +44,19 @@
>>  #define FUNC_INHERITE           0x20
>>  #define FUNC_PASID              0x40
>>  
>> +/* get_user() pointer test cases */
>> +#define GET_USER_USER           0
>> +#define GET_USER_KERNEL_TOP     1
>> +#define GET_USER_KERNEL_BOT     2
>> +#define GET_USER_KERNEL         3
>> +
>>  #define TEST_MASK               0x7f
>> +#define L5_SIGN_EXT_MASK        (0xFFUL << 56)
>> +#define L4_SIGN_EXT_MASK        (0x1FFFFUL << 47)
>>  
>>  #define LOW_ADDR                (0x1UL << 30)
>>  #define HIGH_ADDR               (0x3UL << 48)
>> +#define L5_ADDR                 (0x1UL << 48)
>>  
>>  #define MALLOC_LEN              32
>>  
>> @@ -370,6 +380,54 @@ static int handle_syscall(struct testcases *test)
>>  	return ret;
>>  }
>>  
>> +static int get_user_syscall(struct testcases *test)
>> +{
>> +	int ret = 0;
>> +	int ptr_value = 0;
>> +	void *ptr = &ptr_value;
>> +	int fd;
>> +
>> +	uint64_t bitmask = ((uint64_t)ptr & L5_ADDR) ? L5_SIGN_EXT_MASK :
>> +						       L4_SIGN_EXT_MASK;
>
>Emm. Do you expect stack to be above at the very top of address space on
>5-level paging machines? It is not true. We don't allocate any memory
>above 46-bit unless asked explicitly.

Right, I'm not sure why I thought that would work here.

>See tools/testing/selftests/mm/va_high_addr_switch.c

Thanks for the tip, I'll use mmap/munmap to determine the enabled pagetable level.

>
>-- 
>  Kiryl Shutsemau / Kirill A. Shutemov

-- 
Kind regards
Maciej Wieczór-Retman

