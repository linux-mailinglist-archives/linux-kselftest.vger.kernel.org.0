Return-Path: <linux-kselftest+bounces-13123-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C2FEC9253D9
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Jul 2024 08:44:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 006AE1C21BFA
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Jul 2024 06:44:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91A9313247D;
	Wed,  3 Jul 2024 06:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BKJqAjrD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF1D813210B;
	Wed,  3 Jul 2024 06:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719989048; cv=fail; b=GsyIopYgaR/NBwRDvEHr1v4U5Wtw2MfEMnTB4N4aadM5KdNtJpPsrnXe4AfCIZOC8yt+Y3Ov3aFARcwpOK10DJYkvsRYRC+jhwwqqUmBeN3Kj2Rbyw0EvFfrr/4//RbEB2qj6Uf4pQDJDBm/iBxXREBd7DznXYmqkmzoV9b8KL8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719989048; c=relaxed/simple;
	bh=FQjiHJ7J7N8qrgpvIJhbmJbRfEdL+j7LHyg101IUKZU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kneJ4OZjQvv4/Viak2/n9m1cw9Bwvip2qyyp9UUSK98hPTT2ZpFahzgs/aqL+SnwoDAVjBVIadMiG8m+M7AxmkHnxuwbDu7uUy7siVPkTfyyAarEv2UhiOTqUgr3kt1xgpdE1VrgIYyTwvrYLcJXe9lfYgtEPufDJCc+9E7o3BA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BKJqAjrD; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719989047; x=1751525047;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=FQjiHJ7J7N8qrgpvIJhbmJbRfEdL+j7LHyg101IUKZU=;
  b=BKJqAjrDklSpilX7YRTWqXszBrKFAavCyutE54qyNGfdlKCdnNn9He5a
   QOzcod0SZS3jSlbcrIIFH2+SXK6px9sd+6wAh7vE4Wh6L8dUj4WRsO4Fc
   8oKu9T+2zX/udkOfLh/vef9pxR2MY2BUHRozJZx2zb99u8QVYeo+02FgH
   Sp6dQW1lYdIytcuOTqVwhxOlGRffLzw0L5DT7fUn0qIEfQBIHH9dlpfIY
   V3pejZ5mpPpZT69A6hZsF7Y+G20lf+FrzHostyvujHvE9V/KzLsX4JzuZ
   9+zbTigYT1mTYRsMfO/eu3ZrHW9y1fWKtaYmkwrVf3fLj7/eGB2V8nGgl
   g==;
X-CSE-ConnectionGUID: iLcm62yWR4K5WExuE7mulA==
X-CSE-MsgGUID: 26YAKWE7Sj22E06kIlWHFQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11121"; a="34735546"
X-IronPort-AV: E=Sophos;i="6.09,181,1716274800"; 
   d="scan'208";a="34735546"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2024 23:44:06 -0700
X-CSE-ConnectionGUID: y0swnAGrSqKJOpLfXCvNVA==
X-CSE-MsgGUID: k29rVrgySC2vY5Ha9s+UPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,181,1716274800"; 
   d="scan'208";a="50760753"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Jul 2024 23:44:06 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 2 Jul 2024 23:44:05 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 2 Jul 2024 23:44:05 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 2 Jul 2024 23:44:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FO1FDTvHAAc9JpgmZXnGXfGaPXaGKGnPHFIkoIlZjgt818XxJ8wvXElW3mZg8qABeMc6ClADfBEMfDhp/Rs+HH9qmEEdUQZJSzsbGAzbwQbnSyrJxC7us2uBgKlBAJ+LvA5qaQxN7diNXVTys6ry7tP6s0jXe0VHI6Qm/JAs55mWkK787Ym9Tklh2owGFJM0G5NNWhJi+7AJTLzGJysNjnwl+OKuinpwmkMV2zYRjZSpzKEUGjLj1kFwyBLZNSuCcBn/y1IbBuoNnBOGv4KuHf+JzdKbBrWwB0N/KTFN9STciRC1qVrv3MZFYG0ODLg4K3EuYDXQiGR7xs4EmqJR7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j27liu6475gAQPWJ1HpWkftXvUk9B6yI4c+fhMjZ1O8=;
 b=MEVHS3GzECqXvgqz5CED1IYbcv09O28G0eGwXUKO2QQdppPrR3ey8W2YhVP6pBxZv6E8b5cC497giii5pBYwRKcKYtDkqdWJBh+wppl7zlNyV1Hqpjf1qkKxOrFbu030GUc96GPP9MmGDVHdSJ12wBwjhpFOdJ1sPP1ThKE0l0u9oMfQAzDA0vd0Y/60iuiCmL7fTl4MwKpMru1lh01Fb+9JKRmLCuNhIeR6L+vMkpFJeC55ZE2+jr8IErsejSdPu0iOjoHNTLE6hdUw0nqdk4/86eO1bBP9U8/HTWJuXw24o0El8HpBprZ4S33BNkASKTT8WvHIwBEfiOq6Z5+ncQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6231.namprd11.prod.outlook.com (2603:10b6:208:3c4::15)
 by BL3PR11MB6361.namprd11.prod.outlook.com (2603:10b6:208:3b4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.25; Wed, 3 Jul
 2024 06:43:58 +0000
Received: from MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::a137:ffd0:97a3:1db4]) by MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::a137:ffd0:97a3:1db4%3]) with mapi id 15.20.7741.017; Wed, 3 Jul 2024
 06:43:58 +0000
Date: Wed, 3 Jul 2024 08:43:53 +0200
From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To: Reinette Chatre <reinette.chatre@intel.com>
CC: <shuah@kernel.org>, <fenghua.yu@intel.com>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<ilpo.jarvinen@linux.intel.com>, <tony.luck@intel.com>
Subject: Re: [PATCH v3 1/2] selftests/resctrl: Adjust effective L3 cache size
 with SNC enabled
Message-ID: <ocgoqu6hyouc37bes6drvnp2x4qvoiasz4wtckzeveeqgmxac6@e3spe5xyrvce>
References: <cover.1719842207.git.maciej.wieczor-retman@intel.com>
 <1e6ed2bbbc7716a1606865b8e890afdfcea7ca1d.1719842207.git.maciej.wieczor-retman@intel.com>
 <c4e4d913-2bdb-4451-be7d-0fee80ae0c66@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c4e4d913-2bdb-4451-be7d-0fee80ae0c66@intel.com>
X-ClientProxiedBy: DUZPR01CA0004.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:3c3::20) To MN0PR11MB6231.namprd11.prod.outlook.com
 (2603:10b6:208:3c4::15)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6231:EE_|BL3PR11MB6361:EE_
X-MS-Office365-Filtering-Correlation-Id: 3437027f-3f74-4d1a-952f-08dc9b2b8406
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?6RkctNrNINuWRbpERbBU/PQfSCJbCoOhVMlEV1OwTdUvIDMgn0zGZUxcYC?=
 =?iso-8859-1?Q?3t+jZxZAMmg3IKtZKe7uylu3Nz89GhDNhQvxKR73WJgwAHzsxS/jv0XHce?=
 =?iso-8859-1?Q?Y652XBBe0uBHEdg7IuySsHWXdOuiHq/9NK0gA3Pfcne7XQWGfuugX9CQwA?=
 =?iso-8859-1?Q?bVVUMk9ddSO9WEHQ0MbstO+taZOlSokHpn8XllqWHAb7SUnX4s/oKlLRDW?=
 =?iso-8859-1?Q?vdokr66xkgRb2b6PvOVFZ+r3jhV9HGgHnbKmKGqGlIinxSP6tD9/3yC7y+?=
 =?iso-8859-1?Q?Xzyn5PCA69IELHgpf2i0XbLI01K8DYC46JcPhlTPWblDkYA1M7c3P3oAc3?=
 =?iso-8859-1?Q?+JcCIrX16/zsJmn2/iv8ETzPvogzCqapaRL3y4Cij0yPm2xRpzoGyEOPd1?=
 =?iso-8859-1?Q?HR7Q4eAycpPATgUlHdmYKfj0cEryq9RircCceke/I5LR3SyiuZRLoXBrpC?=
 =?iso-8859-1?Q?gaKBikstqQtaFzq07/ZzzG1qb9y7zAKb+O61wM4zwvxnRF9CiKTrTgtN1n?=
 =?iso-8859-1?Q?6fDRmFMhkLD/JYMJd2KBjGfhvYyrtsyD5u3ZD9umejhpLZHa8zg8xDtM7W?=
 =?iso-8859-1?Q?bbquDZnOWvZLu5J34g5uuOYcgwvLFZJlBTyvKkqlGVSUzMnFPAcqQoHNGX?=
 =?iso-8859-1?Q?TKV930lclRuoW5qpR9fYzRTc9zmZHkjFeoAnZavRzHoJDV3YXqGy4xvZFM?=
 =?iso-8859-1?Q?ozeEto+qiKZClzOd6TokdX3qHnlsFi6yOkheLOrFOmetXxFFtYpwCvozeB?=
 =?iso-8859-1?Q?Y2CCe062+T/eeRghcQViyN48iLPhZhVo5SESQLlarOndD0qzkZV5Asa+uX?=
 =?iso-8859-1?Q?qZzM/UdElKFOdQ/7nSqLH25kwswH6OZC51z5XBlp6u1/CQUhzB58Po7XEa?=
 =?iso-8859-1?Q?Lb+6TaK/YQNcPXKmCWQPEhMca+QZ/w06C/fC6AeLpOneza69tbfOWfJB+G?=
 =?iso-8859-1?Q?hj8KZN3cClegqcM6JrF/l1AkcgHgKEmfO5R63u6wDpY1kyGnlpmJoqatGp?=
 =?iso-8859-1?Q?AsV1GFWs4/YOmTGih9/H6JVqWEmz0tr0XWdi0XADI3FKMnfILH3JtT0Jv7?=
 =?iso-8859-1?Q?wkMbw6P53y+K4j9VPd5tCaD2cX+rGxJ7XjZJ37qfz2FDdiyFINSvWS+hdt?=
 =?iso-8859-1?Q?fyQsty7QH7uI7xafqGTdFjyIRGwbnp5L9qssb1dA9VjPXtIbGhxi7VsGvZ?=
 =?iso-8859-1?Q?c0gwQ7YGoPNoy0AeDI2Ma0xbD+xTeE9HQ5k9QUZA9Hyof59RbNZ/t9VP20?=
 =?iso-8859-1?Q?yuIdYdZwQPUsAm2znHQ+d36SCrVBMqygrhCovxctAJx2GUjeZ8gb8Wa/Pk?=
 =?iso-8859-1?Q?8k6s04Vo+XIhgVZXJ8VpNJ2IGSkmfu26naFckkbzOyP0vgUSCVQlvt8jfM?=
 =?iso-8859-1?Q?T2rAQyC7Q5z6gTqCRnwn+njagdmvZnOA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6231.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?87EnLftcXoY2IgEmbC2fEFLjidV4v2j+3gYLgCSMBW0YCDF6AUO5d4W535?=
 =?iso-8859-1?Q?pQiOPCyeFE18Zl6yqLe0WArXT1QpT/KufY5sgw7CuavgoCXqFXzUYs3Xgs?=
 =?iso-8859-1?Q?Z3qICUxgwtOtVy5aAs8+r9eUz8xIt0KdQ9m+yZAoN7AEHz13Zrfe/2Xdqi?=
 =?iso-8859-1?Q?VqxiVNrDxCHMvRQbxqPUGllCLnX2AjJg5I9LHf+xw4WOo3AoJZkC2HZdZq?=
 =?iso-8859-1?Q?lsBHf8zS/70JTln2L8wPxlcW4Rp55D2L2Ow4zaaBr/ZEwn9C6Qb2SbXZxp?=
 =?iso-8859-1?Q?IKmIFoNeKZEnq8EvpjKeXhsG18ib5BMcsHbyTCTMTSfazaKQQLBMhhvd0q?=
 =?iso-8859-1?Q?Mb5sY4lH/BGPLdRzA1HbN7Egc7KKzeG2S/UEqjFjK8Lk2Kh2cWj/Hwx8FD?=
 =?iso-8859-1?Q?n5LnVN0lpXdMnqs8KPN3MCVe3KJvlLzTpxD78cpSOJSJoLq9RocNadCw4A?=
 =?iso-8859-1?Q?m4f+fx/lXh568YB2o6Ap0jz1Dt5f8Y+w3Kxfj7Z+6ey3FO1V3QELa8IvHk?=
 =?iso-8859-1?Q?Re0d58mXHSC9oQpf7Tmohuen0q5bR8KHA8QhYFyeDczQB8ZHY65KPPJ8v6?=
 =?iso-8859-1?Q?D3AfvzS6OMNWN8P4hNKAs2+wey8TlS6pGVtBHoM0AVhWdUeAeF6JIZ4sUt?=
 =?iso-8859-1?Q?kNveDwurGRStWfRUzFsSYxtLYyu/UIXTp9KkDZqW5qb+qCjc4N0+Op7uyt?=
 =?iso-8859-1?Q?1h5VxtTfoNaJwP2UU9KisUyY79NmiskCQYgGDWTTe1HL/jZOFVC5zh4BVZ?=
 =?iso-8859-1?Q?5xXDqZY7JEduKCN1WMEFqxcv4yHb6zE6103ViiAAlFlxnlNWrOA+raO8t3?=
 =?iso-8859-1?Q?jGnffMQ+4YErVpOQAwAQ+CwgiBXhMXqprw0i+PPdHMJicPUFrkROqqLQeA?=
 =?iso-8859-1?Q?hCvvz0ybyXxvM5r2OfiTF4Ge9cbZA2LQjbnwneUE2fJ1HeaaH2xnX1mSc4?=
 =?iso-8859-1?Q?gWEjl8fqUQJ1w1zGfj8RkUBQrIFCfF16P9qZ4PM0V+SFCnnLYy1W3XhAaS?=
 =?iso-8859-1?Q?wqTpT3hGK98SeabKn790gXnNPVoHsI0fTRWkctLe+heneLVLcSMdUTZEWz?=
 =?iso-8859-1?Q?uLtUnITkPZUN9mOiTVsNTmC2M7R5EqgL1YHnL0+iX5NIuAZ2mNtSf2Un9z?=
 =?iso-8859-1?Q?w/UAI17DAwxkurDMpZi83sacQASHIMAySgNJsRFpfD1+63RXkpElYx9p/R?=
 =?iso-8859-1?Q?d4FiMKdmba6C72PkpOs+QkFi55tGait1uQsUkpjVxCny75bOiGwdN02LYU?=
 =?iso-8859-1?Q?5ZToIZ0hwEIa5r1njwQHembR+G1ZlTMaLL4GLC6hp1syd8EJ133JuGRooQ?=
 =?iso-8859-1?Q?pCOn2URCQKlUeyK0vHBV4PgmbBoDtEafsGeo1f1vAlAYhR5w1LpANJbk/2?=
 =?iso-8859-1?Q?XXZye+5YQnNtmOlrqGQqrzBS4SeHMesGf+iBby/0v1HETOfqBfSPZSUgkL?=
 =?iso-8859-1?Q?ykxUE1Gcb7jWWJSHPlwTzWmD290jy48BprHdxxVnm4RqOxFNP8wT8AJ8py?=
 =?iso-8859-1?Q?t+KFbDo4UDuauJWpvbgvtK8ly6MKx9h/+6BxRF/RgbB20F/B09Fp63CBYb?=
 =?iso-8859-1?Q?lG9SK9/dPzUyte4A18Kg/kaKJuSJ8BaqF2PL0/upt7hHOfhcDaPDquo2ze?=
 =?iso-8859-1?Q?hHk0qnUiqwApYlPwOGOIDv4ztBJOi7WxGghpeuMWoasOxGYaiI4frx/oOH?=
 =?iso-8859-1?Q?Qg1pHHiP1IXoYQlPFPw=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3437027f-3f74-4d1a-952f-08dc9b2b8406
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6231.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2024 06:43:58.1676
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g6iAS4oDtGezOgICf5owSvccj6+G0otqEjM9d5+XqvjsfpvVgp3aQjoIPd0whV2qcjJtkcYepd7Ec9dvLFu6+fmtZnKM4yRr03PLqW3WZLg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6361
X-OriginatorOrg: intel.com

On 2024-07-02 at 15:20:22 -0700, Reinette Chatre wrote:
>Hi Maciej,
>
>On 7/1/24 7:18 AM, Maciej Wieczor-Retman wrote:
>...
>> +int snc_nodes_per_l3_cache(void)
>> +{
>> +	int node_cpus, cache_cpus, i, ret = 1;
>> +
>> +	node_cpus = count_sys_bitmap_bits("/sys/devices/system/node/node0/cpumap");
>> +	cache_cpus = count_sys_bitmap_bits("/sys/devices/system/cpu/cpu0/cache/index3/shared_cpu_map");
>> +
>> +	if (!node_cpus || !cache_cpus) {
>> +		ksft_print_msg("Could not determine Sub-NUMA Cluster mode!\n");
>
>nit: could you please check this series and remove exclamation marks from the messages
>printed to user space? Just stating the error should be sufficient.

Sure, will do.

>
>Reinette

-- 
Kind regards
Maciej Wieczór-Retman

