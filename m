Return-Path: <linux-kselftest+bounces-44277-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3C34C1B413
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Oct 2025 15:37:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5EAC461DE8
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Oct 2025 13:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16DF733B6C3;
	Wed, 29 Oct 2025 13:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LIX0jxzc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 620631EF09D;
	Wed, 29 Oct 2025 13:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761743767; cv=fail; b=lNgPFrBDnVZbt+OOD2CDTHhGh+LFoAgchQwm+ADDD8v73hfenADkLD0kKmDyNUkDK/G0VLeG7n71HKFCApK/qZTPIPTR9cbdHzYcUBDHxC9f8jww93q3G36tY06HucMNkb6I1ZeitN2BEioco5zBw6AHh/IdeEb2Lnpdf8w+brw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761743767; c=relaxed/simple;
	bh=Y5Ud/WmWKndXTYeWK8CyzocUou2sPcGjlEDAyPU0coQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ReLWj8xXvWGQVZ1uE8TA0BXDVmfbfz9v4ZojDn7qKHIwY8hM9B0BXQPL8UOuUph0XP9V19bk8jEXfbotsiWbdJKpIyjW7Pu7nq0IJkXNBfPPW4EOS0Txvpv31Z184mJBHV/VZ5ltYL+Lkr8fgK/ddF4eBp0W3+bhAL9ERCkWo9k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LIX0jxzc; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761743762; x=1793279762;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Y5Ud/WmWKndXTYeWK8CyzocUou2sPcGjlEDAyPU0coQ=;
  b=LIX0jxzc5UHSd3oq2Y9ylyAlYoC9MY/Yx1jcxZzrTyKHv+72HLefxaPC
   oEU5MwQP7pZeBjUxlmgpEJkgQ3L24HgqeG5hmmIsrF6evTnvb3CdoOfDN
   QeCG3pUbleEYM/nDH8woI8zN/6CtZjEQRs97o1ah5iod3r92mG5sZ2Wu3
   R4jzFP1QV5hyUX+8jHD57rNa7kUFHcT1Ad7R3VEkSdtlTir4wKzIgktkF
   PM/180MlJooPD1vL+tKdLEPy+x6jhrDS6PRp4LiZ67N8zMNSA2g2OSA4f
   3W3aGO0KLDfy5TT0sSXcOwHAOR+V3CQlOgCmJJkCVvxKPbbb6J3LGTQKf
   w==;
X-CSE-ConnectionGUID: qwdKPkVHTZKi+9sqQH+9aw==
X-CSE-MsgGUID: iV2hyYFwRFeEALt/WWpDmQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11596"; a="51437933"
X-IronPort-AV: E=Sophos;i="6.19,264,1754982000"; 
   d="scan'208";a="51437933"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2025 06:16:01 -0700
X-CSE-ConnectionGUID: klCA6QWdSZWpZxer+scjxw==
X-CSE-MsgGUID: +zSv7eB+TGG1L+jP6s7rUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,264,1754982000"; 
   d="scan'208";a="222882393"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2025 06:16:02 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 29 Oct 2025 06:16:00 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 29 Oct 2025 06:16:00 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.24) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 29 Oct 2025 06:16:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s1LyZ9MfAoLMy7YVQj6MJhKfeEOc7LCpj40VWY0jjL3Mc8TGft92vyHcw2k6cAwo0XwObsvOepwXK+zfOcLh7AgROk/CoR6PY3AETt7XJ9k2dznJozywucOGMuShvi4gDM1GGB+sj1Ktj0wvvURrMpa+ZwZCiWln/j2xBh+umxNtlV8wAvoXzPfKXwp2h10bjLFXNal9BkPyW/L+w8ZtMF8ozQjGG9OF20RcoCeOOjn8ahr1nq82k3CLEm7s1XOtm96FIKAYfYh/PRko7sLPiVQyG6riVBUtPmddofA7H2Tn8eHgWsgZxUoxoRe2+eP3fL8lZa6xFvscsecigB6WoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dR6nL1mPtaRJDs6IEg7mSR+7wWn7z7nQ5y8z2wmndhM=;
 b=YLFItN9Xlxep04qqN5CSHX2wvx2yUEhMvslK2+vkcwjXyo5opY0ZslWF5jEEZf92vvQL0x9QkKAFKsTseIZpzXfx2AYGUaSYaGq+FYc0W9KRV+9eD8uL/jvSRVdmTPIbJZ7IRSLJaic4rlRJcQUlLIMkrWUSaghgbv0uHmKhXMjRGhnWSj8G29tl5mNm/nLCqgcSNKgNWQQ3fMe9th4/2/iLMODUhX+XFAsbrptnrcvgSV6PqC/sMu8mYBhLvqHFd/NYAEdqnW9o3WYgLp3CJoZ0lfcfBldfwt/szWmnAZC7SZuJ2njgUqv8kiAYONixBrrDCNYENd1G7Hyv3Kdg1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH3PPF9E162731D.namprd11.prod.outlook.com
 (2603:10b6:518:1::d3c) by PH7PR11MB7570.namprd11.prod.outlook.com
 (2603:10b6:510:27a::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.16; Wed, 29 Oct
 2025 13:15:54 +0000
Received: from PH3PPF9E162731D.namprd11.prod.outlook.com
 ([fe80::8289:cecc:ea5b:f0c]) by PH3PPF9E162731D.namprd11.prod.outlook.com
 ([fe80::8289:cecc:ea5b:f0c%8]) with mapi id 15.20.9275.011; Wed, 29 Oct 2025
 13:15:54 +0000
Date: Wed, 29 Oct 2025 08:18:14 -0500
From: Ira Weiny <ira.weiny@intel.com>
To: Sagi Shahar <sagis@google.com>, <linux-kselftest@vger.kernel.org>, "Paolo
 Bonzini" <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, "Sean
 Christopherson" <seanjc@google.com>, Ackerley Tng <ackerleytng@google.com>,
	Ryan Afranji <afranji@google.com>, Andrew Jones <ajones@ventanamicro.com>,
	Isaku Yamahata <isaku.yamahata@intel.com>, Erdem Aktas
	<erdemaktas@google.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, "Roger
 Wang" <runanwang@google.com>, Binbin Wu <binbin.wu@linux.intel.com>, "Oliver
 Upton" <oliver.upton@linux.dev>, "Pratik R. Sampat"
	<pratikrajesh.sampat@amd.com>, Reinette Chatre <reinette.chatre@intel.com>,
	Ira Weiny <ira.weiny@intel.com>, Chao Gao <chao.gao@intel.com>, Chenyi Qiang
	<chenyi.qiang@intel.com>
CC: <linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>
Subject: Re: [PATCH v12 16/23] KVM: selftests: Setup memory regions for TDX
 on vm creation
Message-ID: <6902141659442_20bb411003c@iweiny-mobl.notmuch>
References: <20251028212052.200523-1-sagis@google.com>
 <20251028212052.200523-17-sagis@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251028212052.200523-17-sagis@google.com>
X-ClientProxiedBy: SJ0PR03CA0291.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::26) To PH3PPF9E162731D.namprd11.prod.outlook.com
 (2603:10b6:518:1::d3c)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH3PPF9E162731D:EE_|PH7PR11MB7570:EE_
X-MS-Office365-Filtering-Correlation-Id: be8a4ac6-56dd-4ddf-e563-08de16ed49fc
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024|921020|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?a6oOA++5z+C0gGXhgUaubPa9OmcSRxOrnzOZBHbMtU3zctxYnh7sZhvULFK/?=
 =?us-ascii?Q?mehLggWbQaWkcko2cj6zfUUGWag+2YwAQi8rt3K3Ls4/eHssPxbUEoLu2Nh0?=
 =?us-ascii?Q?FqRH4iaOfM3nhoH1LTU9kq1kx8sWUkzojT2UEp4dryvjQ7ROrY3vdqGlRxuh?=
 =?us-ascii?Q?elbWaDed9TTzAXdAXHGz+1YoqOZpZiLOO9V84SL1n+VhJZj+m6/pFms0bVh7?=
 =?us-ascii?Q?K8LmoI6hsYijVF4+2TOy+Mjwfx6+TTIoEP0NEhdHQAgRZkQ1NUkpyqJ1CzN5?=
 =?us-ascii?Q?s8FUcAMajGeUaftdOkO5YTkfq0Y+y/fwEaN55sgGXyxDTBuZ5cKyHEklAG+5?=
 =?us-ascii?Q?sepkWmw7+/okyx9nE2ZphQcyJFpmr9jWef2mnd0pFSDdwizbGC8iBd7mrZuS?=
 =?us-ascii?Q?MHc7HJ0foxPaObAraoY9xSPtEHwG0Ys+UOa53btizQdxdSIK8WVkaU6vSJno?=
 =?us-ascii?Q?wuK3ApPw5FYcBniOPjP0eT+DiOy/MnifKUY0hMvKuARwJ5nUXoxtsj7ESHKd?=
 =?us-ascii?Q?lZjt/KJlHj8REUvH/3bEJlNDBX0zqfT/XZD1iEHT9yFmAr/L30jd1IcRMYn2?=
 =?us-ascii?Q?2WMjvazboOiblQsAmS4CJgjlde3uro0xT1uagWBu/wwXySKhzVCl1CCt2QdO?=
 =?us-ascii?Q?7NFYOUdjOJsdfWM9q56EcL4MPh0OcmDiMKkrw/1gUg5afaP3dxtzxHc5t0d1?=
 =?us-ascii?Q?eL3ojnCYF2b/6tk9DSc5yxiLQpP63mYKcvwYdeyU1l/ImaapyZXUIW6irkvg?=
 =?us-ascii?Q?3DASKVjyh7g9aEQhF+k03DIuR5faP/CY2dwtGI+s1rViWFB1YWE36UjUYx6S?=
 =?us-ascii?Q?5OIUts9SIi7fBR+29CFqjkyUW5C6Z9H3uo8Tks0h0eXFYoENObfg8i9yi7zG?=
 =?us-ascii?Q?XLw1hLQqrrlHGq0GA8mkR4q5GnUEOjxwRZDapshy50IiPhUyzmgYmVJbqtDL?=
 =?us-ascii?Q?MeyGtOOdd3DImbtzubmi/pKnf+RRCghzxP7SZpC4KDzxMkpP+B1oAeAihRQV?=
 =?us-ascii?Q?yGboXmbdq+hKBSdGflJ67AwQijrKGOSF70HEEgTKWcPmhWLkiJGy+lymirqT?=
 =?us-ascii?Q?3S6fn0lBoTBt4ugnnQaoZAFu2tn/rMWhNHRzK5jSCfH4kUPwHWyLvqVezD15?=
 =?us-ascii?Q?9VoCbtV5obbADslQZfzmmPx9UrTUZoYMp3Ffxif+bg/eBbkWPLXZBC3PdxYT?=
 =?us-ascii?Q?k1FIIVEVOpPBeUoi53hsDnpL/8GjKi3fWdbMxRzUCJ+elYK2F4D3OaE+jjNQ?=
 =?us-ascii?Q?GRzgx6hHdbxbJo4lEZpf3CBW1wbC3JA1lOJHfTqrz43CTQXkJkjpIGQmS+uL?=
 =?us-ascii?Q?SSlGvM2OGywheqFmByRaSs1WCRq0mLXVME7pEnsPBAXP5eQJxIbauPGeIh2T?=
 =?us-ascii?Q?orDM2d9yiDTw8oXrqq7Z2vy4UBaIw4vdBi6p5A/40cX0XnBE/oLSoIx6jtHt?=
 =?us-ascii?Q?4baNiBM9JvorrclwTcNDM1EBHz2nPLY4YCJXX/CTuJFwgBBLCnajTeVm40WM?=
 =?us-ascii?Q?QaX0nFvjUbqYqB4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH3PPF9E162731D.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WK+0YLFWq2WOBVzQwGMfWTaGynLE6Jqsy7EDZW3W94+O179ntl+LVhbkuBgS?=
 =?us-ascii?Q?bOsDUWFZWaiCWDyRAjoNLt2vW9MuBcFFmFFgJLQQin/9j3MvJgEAgtjRv7pO?=
 =?us-ascii?Q?sCdJw4JGvWrMis00e1KqKdh76T/lQdtUylSsY+zKIWvF1PZKggLjhvp8bdY+?=
 =?us-ascii?Q?h8+wES2ZbgLg7ZtTiF7K/tZtu469AukaJavFcmp89/HAwy5p4cqiTdOzN5mx?=
 =?us-ascii?Q?Dm9Ku95Z/Eo2YB6eYIr6hDfJVoqfmS6jplHmNrkxbThZBN6HqzAlcIAqB/5g?=
 =?us-ascii?Q?zMuTgc+IaIyclCQBEVLcufuo2tNU7gKle93cbO42ItTshp56P+4v4PyAxD0D?=
 =?us-ascii?Q?kPialw64OrrpbFRwQg88LKslPQGWmNP2bb0c1Vx/WNm7P30bMfAGCI1zOrKg?=
 =?us-ascii?Q?nm+wXvNhgBUl8kTSxtk2g5k6b8DxSBKt6ko/FWNxAviQ/8Z0dPa55Mz6Pwu1?=
 =?us-ascii?Q?8Nd/Nq/Ri6f44rqK7zXy0CDwti2jzpSe3O6mR9bPxnOkIdUQj6woJ48+UoYd?=
 =?us-ascii?Q?6cliAJ9kjfcNdG3mUb24Sz7/NmBqilvsgcqk7kPH7RHc0g28KCSs2y1vznCi?=
 =?us-ascii?Q?wLmBj3mwjLr47woA02u3IrlrTtsaeU1x+gxANBLWec5xG26OtrJYlSzubZGG?=
 =?us-ascii?Q?VOooWhM4reElxBbnCZa5glrJg6usswvYPhGTqc2OZJw82Ov9Y7fQF73m9kMJ?=
 =?us-ascii?Q?HaicHsakplS8bOJpVrHu4z6gXJdG47tnZTADIRFnQoPXNjaEV/xZrBmhfM5M?=
 =?us-ascii?Q?1rcYJ4XY2Cxysh6ysggrymxMQiWHutaGdtoix37w05xIS4HpX033cY38dJg0?=
 =?us-ascii?Q?p8Vn5vL0MOv0/C1aA+pSp4S8G0nD+WE4It+Yk/dGKueXbvodt3meO9t/i9qa?=
 =?us-ascii?Q?/Gbh7caT3QFW6Dr8FQRccKPRp4U31GL3Ut/mYE0VHnD+WYzy32sQrMFYt/Ae?=
 =?us-ascii?Q?WwKKUAp9ABG+5TprzX8VbSH7319O4LjrQw1hwJMveddlZ72F/EA5z82t9U3S?=
 =?us-ascii?Q?WUmNafjmYQqqoESUxuatKcSUD1L1hDTCdOAgXp9otltp6FuQf5qM1zP2SYg5?=
 =?us-ascii?Q?67bP2+3oNHRaxS0qrOdtcEcgIYTwLX7gFyRMxF9RElQqlaCHwewf38ZZOnSV?=
 =?us-ascii?Q?zmHG+hS0coa3pb6RakrYP5zTZvs3LtYPmaoDgze8G4a1IenTNqzQJB/9FzUE?=
 =?us-ascii?Q?aJv8rUp68gIWec+Os2KYxUisEhiRCGkvIY2jJWEijFkvLmrn2zjHP+tVEDts?=
 =?us-ascii?Q?gwNzX4tclhF2s7pyYQA6qVuxPSNJkdCdmARTSdqjLmu/gxtNNPb/HNOpwXzU?=
 =?us-ascii?Q?3G+mfCqE/AgWQUKsMwXZ2v4QG8Vf37XFoyBCzZR5B2DppA2tj4wShKcdxAeC?=
 =?us-ascii?Q?SBkRpsRGO+01hp852yHGIILMKZ0LsZPd7+0lgETkM19SH+gJMzYaItbGOqZG?=
 =?us-ascii?Q?heZEr178DYRp/y1kjaffHo7WkrrhGolunSMNs3TaGfq01WBEVmSKwYgvGalx?=
 =?us-ascii?Q?aLdFcvDyo/WlZ8kTe81iDnx29MWazn6xzPzHx4152ocpMBpQgdx0UuXEZlNS?=
 =?us-ascii?Q?ssy5oVeBKAe56lfiwLDYssAiMasj/OX7h5rE4nL8?=
X-MS-Exchange-CrossTenant-Network-Message-Id: be8a4ac6-56dd-4ddf-e563-08de16ed49fc
X-MS-Exchange-CrossTenant-AuthSource: PH3PPF9E162731D.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 13:15:54.1870
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9sjqZcBenKGTKo0CKjdEq+4UnaDwyWwRJM2epBNj0R/pReNc3g1KvTmmI8hJfAwMGWtI4uKSsN38/PZqUO12cQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7570
X-OriginatorOrg: intel.com

Sagi Shahar wrote:
> Guest registers are inaccessible to kvm for TDX VMs. In order to set
> register values for TDX we use a special boot code which loads the

NIT: who is 'we'?

> register values from memory and write them into the appropriate
> registers.
> 
> This patch sets up the memory regions used for the boot code and the
> boot parameters for TDX.

NIT: This is not needed.  Use imperative mood.

> 
> Signed-off-by: Sagi Shahar <sagis@google.com>
> ---
>  tools/testing/selftests/kvm/lib/kvm_util.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
> index 0e6a487ca7a4..086e8a2a4d99 100644
> --- a/tools/testing/selftests/kvm/lib/kvm_util.c
> +++ b/tools/testing/selftests/kvm/lib/kvm_util.c
> @@ -4,6 +4,7 @@
>   *
>   * Copyright (C) 2018, Google LLC.
>   */
> +#include "tdx/tdx_util.h"
>  #include "test_util.h"
>  #include "kvm_util.h"
>  #include "processor.h"
> @@ -435,7 +436,7 @@ void kvm_set_files_rlimit(uint32_t nr_vcpus)
>  static bool is_guest_memfd_required(struct vm_shape shape)
>  {
>  #ifdef __x86_64__
> -	return shape.type == KVM_X86_SNP_VM;
> +	return (shape.type == KVM_X86_SNP_VM || shape.type == KVM_X86_TDX_VM);

This caused me to dig a bit to understand why this hunk was needed given
the commit message only discusses guest registers.  I did not recall any
use of is_guest_memfd_required() in the vm_tdx_setup_*() calls so I was a
bit confused.

With this hunk considered the changelog should read something like:

<commit message>

Guest memfd is required for the primary memory region of TDX VMs.

Furthermore, guest registers are inaccessible to kvm for TDX VMs.  TDX
must use use special boot code which loads the register values from memory
and writes them into the appropriate registers.

Use guest_memfd for the primary memory regions and call the TDX boot code
functions for TDX VMs.

</commit message>

This clearly explains why the change to is_guest_memfd_required() is
needed.

In addition, the structure of this series is a bit odd to me.  I assume
this patch exists after the setup calls were added to ensure
bisect-ability?

Ira

>  #else
>  	return false;
>  #endif
> @@ -469,6 +470,12 @@ struct kvm_vm *__vm_create(struct vm_shape shape, uint32_t nr_runnable_vcpus,
>  	for (i = 0; i < NR_MEM_REGIONS; i++)
>  		vm->memslots[i] = 0;
>  
> +	if (is_tdx_vm(vm)) {
> +		/* Setup additional mem regions for TDX. */
> +		vm_tdx_setup_boot_code_region(vm);
> +		vm_tdx_setup_boot_parameters_region(vm, nr_runnable_vcpus);
> +	}
> +
>  	kvm_vm_elf_load(vm, program_invocation_name);
>  
>  	/*
> -- 
> 2.51.1.851.g4ebd6896fd-goog
> 



