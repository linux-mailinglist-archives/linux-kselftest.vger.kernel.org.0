Return-Path: <linux-kselftest+bounces-44521-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EDB58C2584B
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Oct 2025 15:17:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 80E924F6A8E
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Oct 2025 14:09:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20AC034B69A;
	Fri, 31 Oct 2025 14:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lEsiIHGY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5690934B67B;
	Fri, 31 Oct 2025 14:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761919742; cv=fail; b=K0fQvcTY0fn/HdwFHG93Dxs+l87fjw6Hh+nGqd1XWMCpHAREYL3gSEV0/hC8mBoFkEWjqEkOVPGQcS0pPFiTrwbZZKgnxn6oxtOR3RL3h6tLGi7X/rAQ1X54qAMlgRRenDcRIPG9Fy4r8+NXQoWcLCdxNcbfe1S/xKH1Fh9E6wk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761919742; c=relaxed/simple;
	bh=aIVggA4rUjQqaN7+pVkLr8s4ZvBtMvgnU7HLbkX8q5c=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KcdIdFjStiYu5RhJSySyCu2A5r+aqcrQIHRA3YcKhe75XWULMo7yMPcO8Nou7r4i2smfeXmhZZCj1fnhSifwwUyxqLHDgkT9li+N3ezDVhJI2C+gzcXN25gKKuC3lbBoppTMo2SksseSCfWJ3h50XO8it2kvrUWvjoB8rsUYxoA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lEsiIHGY; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761919740; x=1793455740;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=aIVggA4rUjQqaN7+pVkLr8s4ZvBtMvgnU7HLbkX8q5c=;
  b=lEsiIHGYlccAzlosHpzkGc3p+ye3J/1qF5ZV7eMTGHUk7qBXMZ8xx+VR
   4S+fFfTupqc3cHgTIsBUDWLe1bITwYjlvzVBB8UvLPfC/HyUR1LA4iIBF
   qTsZcaGtxFbOd8EWGdD3zdXoRIlNoz5WXdJLEQa8+FeW1HT8mtgkDOEiZ
   sS703dNNlD8nPE24S3gCorroZ90QtuQMmvYcXNzWYU4U66ZNL+WG3Dgeu
   o7LbRqyyHr1LY3kCXZl+LPkz8/ZfKyQBk676OA/zpOCegpRg2aKVC70x0
   hkxuUifuQOwdd1fa6MaOj0DGaF5QYGcEewVupOFTG9rg0HgCQHY8HR1Pb
   Q==;
X-CSE-ConnectionGUID: fKvRcGc8Qietd2cvjE8wAg==
X-CSE-MsgGUID: jpweWiicQuiPKEGJkaOmFg==
X-IronPort-AV: E=McAfee;i="6800,10657,11598"; a="51652116"
X-IronPort-AV: E=Sophos;i="6.19,269,1754982000"; 
   d="scan'208";a="51652116"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2025 07:08:59 -0700
X-CSE-ConnectionGUID: UF/k9UDTR12I7kRYptoaCg==
X-CSE-MsgGUID: +frnYOIbSkeLM0bOpbQEeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,269,1754982000"; 
   d="scan'208";a="186699244"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2025 07:08:59 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 31 Oct 2025 07:08:58 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Fri, 31 Oct 2025 07:08:58 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.42) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 31 Oct 2025 07:08:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=skv6XTYp9Lf7T4ReaXyC5qH6/NDz/nGnmbPeI//sLB45XaSb7Cy2m/uY5nmuNAX1RYgqRwjfBz2Ssg2WppqHp8oVRRjAr6hnvBHJ8mUs0b+8lts+Gt1OYIXakVC1dCawYZc5Ar+AKcpWBBKqKeXR64uJG9bTvW6h8lIIedZ9/wz3hiJ66TmdaZc2JRKn66SxN7xU/D6LIXd8x4DbJ4cH/fnKn+ypKsyXPkH451PQwWPoEeLBLfvSGgsEa/gmnRaBCL4rVIyO89Gi6fv7hcgrI6ha3fan0kouDFae7xMC1k7ACtXjyF/2SZ/Sb+hbpxN4Cmsbpz3HomQjUBn48I4mNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s2oN745Lg2RNSYHG6eX+AqAh6g1FOVsGJZTwGFUthdc=;
 b=xKZcSnJi5acGJM8eXaAzM1Nk6Rn731MvLDBToM63IJbh4NECcoj3ZDhjfVxRjPagAU7Da51lAeWPajvZS34uVWU45TsP0dHLYH93XDddrz8jV6SOmgwYvi/cv2yJGenKPDkA7Y4S1jBRlxAGR8T8KjHvOC6BoQWdSzBBjNALvfoCXpdsp5psulMyTTZLZthOrbYuZq59NRBgfTBPhEwTpG7qp+2xkM74yiDxkutBnAqdxayaR0ZB3CcVihtPzA3ib8XD91dp5ukK7TJjAksaSBnJPmQMfBA0Lwzv3bpsnRUth612xnBRJme6UMVbeCeGb/olLnj1o4twdbtxTSJC8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH3PPF9E162731D.namprd11.prod.outlook.com
 (2603:10b6:518:1::d3c) by SA1PR11MB8253.namprd11.prod.outlook.com
 (2603:10b6:806:250::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Fri, 31 Oct
 2025 14:08:54 +0000
Received: from PH3PPF9E162731D.namprd11.prod.outlook.com
 ([fe80::8289:cecc:ea5b:f0c]) by PH3PPF9E162731D.namprd11.prod.outlook.com
 ([fe80::8289:cecc:ea5b:f0c%8]) with mapi id 15.20.9275.013; Fri, 31 Oct 2025
 14:08:54 +0000
Date: Fri, 31 Oct 2025 09:11:15 -0500
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
Subject: Re: [PATCH v12 20/23] KVM: selftests: Add support for TDX TDCALL
 from guest
Message-ID: <6904c3834e3c0_231474100ca@iweiny-mobl.notmuch>
References: <20251028212052.200523-1-sagis@google.com>
 <20251028212052.200523-21-sagis@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251028212052.200523-21-sagis@google.com>
X-ClientProxiedBy: BYAPR02CA0035.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::48) To PH3PPF9E162731D.namprd11.prod.outlook.com
 (2603:10b6:518:1::d3c)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH3PPF9E162731D:EE_|SA1PR11MB8253:EE_
X-MS-Office365-Filtering-Correlation-Id: 576603d5-9d78-4029-b6e8-08de1887063e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|921020|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?JB9MfhpSH3Yx+QjuDMZX+9uztv0mwcVP9uMBQT2u+8qzOK/CFQNorpXZbWCG?=
 =?us-ascii?Q?wybraFdu5coJjHpWDrPH6izNq2T560ri4FvOg/kYYPJaMMkubspkytDFrM30?=
 =?us-ascii?Q?7UJJj8mgEiYbRlJb7z2eVB+ZhyvgXITPQotkrBAib29k0+Efb9Eux4yXrfnQ?=
 =?us-ascii?Q?U0CgwBJ8iqkDJM2nLu655xWp+M2fvQDwee/AkOMg/Y99gJY78gEbJd72K5GH?=
 =?us-ascii?Q?mZ6QM9ETdilriCb9sVTd98BMfDgX9JuWBjWOfCbYJ1iA7eW+WUhd8sF/LHhH?=
 =?us-ascii?Q?2V8csK4h/Hgio/vGcVtQDZ0HzYjnEqiIm92cTpXtZBStExmIWEwDQy5gaA/d?=
 =?us-ascii?Q?MmCMcNdi5vuBiwPRXuHOu5KAAdF58Iqb7GQMeAn4YJ3+ckCp+LfgKP4IO+Ti?=
 =?us-ascii?Q?DgJIFyoQ9SECD1qyLwookp6YGPX8XygyVEZmdh48o4MuyT+lkD5dr2o3iJ+v?=
 =?us-ascii?Q?GjO0TPzT9kOF2LuTS4fPf1ggGEF0nU17TAWHuppdbj5J32xYKArxGkRwC/ny?=
 =?us-ascii?Q?b2H5Iibf/pPeFGZPIr2HXxwZCYqEV2JgXQ0EbDLDOO1qRBTEQjjCmdPUetSx?=
 =?us-ascii?Q?BeY+IAukbttkIpAux9/3o0HH4Wkm5OlanWL2p45VmpE5vWPiphtJ10D2dZRn?=
 =?us-ascii?Q?h7ZCFxOgk8wchbrqObFC2fSTLYZKUl2G0Q1hN8vc0eSRbGfeiwgL5wcv3kYD?=
 =?us-ascii?Q?CkoXPIuaHu42I8HmhG3/peM8QYCthPLOmNxyBBdxI7zh102GO4Zc8qr+qKsV?=
 =?us-ascii?Q?vxXLeCtp6dHfIfTTjT+4DZpK+HtRa/SdyQLazgelK7S9TVJ3R7cRUPYs2hB8?=
 =?us-ascii?Q?leSM9sFxpvUL1cK2g3z2XWOo0TriIozr2qGIFh9Vc2Bysvurxye5vgP75cRR?=
 =?us-ascii?Q?Pbwf1CNn6nP2/AicLDIuyA8b6OnYjsDOtmYlqq9V35cAEANQB+vnvjYYhzsD?=
 =?us-ascii?Q?X8aGK+jjOVpkoYyudDlNoI1PNIHmp4/CyRMLB2RSwrxNDs/FizdJRW/K+17s?=
 =?us-ascii?Q?FMnbccqcSTkSo1A1LPVfrnkSfAspxkMsitTjOdP11PtGzLhI1sETOxOVJi1T?=
 =?us-ascii?Q?/iH3wd89BGM3kWaNYb7CS8xe8V5CUN14r4D/ZEpu2cqr8B2y1e3iu3zQR4Z+?=
 =?us-ascii?Q?QCzWISqqBpWLIJCxsfY4Ob2e1/OQ7C6YKbSTuO12ZJOQsWEGRnMhoYqGQeLK?=
 =?us-ascii?Q?3NejZRbLZI1IsA3e4m9w0hKVJ3HICe6UK+YpJbfF7fyQUUPZVwidU1p+PXgm?=
 =?us-ascii?Q?4djPzD7pOkLXZvXo6Yl64E1g0yHxCa8sWcY1YD5PAZ6Ku4UpRpMgcbqjfn/a?=
 =?us-ascii?Q?G/9UfLaWKNyL16Y4rSzmT10CSAxpmBp4dcY7qcFgkTkW47BBDfAlv5G+1ltG?=
 =?us-ascii?Q?1X8+SMR5FgabYHDfY4FBFT0ONssEWOlrppzs9XWAb8Wfi4IO49puyC8ao10d?=
 =?us-ascii?Q?uaXDDm/2yeniDjTqm68UXzhs6yWlQcFBfRpWcnzjTekdPM3ejA2Lqafue/Be?=
 =?us-ascii?Q?ryy8n/W3fQXTZaE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH3PPF9E162731D.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CL0o/LbS+yDfsf4HRas7+eTVRkM433NjvfKPZ2sAiIxESVitkkKv+aP9H3Fs?=
 =?us-ascii?Q?X3ShDsOiUCzmoI4MoSLX76jd9nYijbrQUDUKYqj2q+BHHN1cDhIg4hjfdkTo?=
 =?us-ascii?Q?EfpeRDu+/QQW5BzyfYt9dPYMIean5VPIaXyU4HWKs1oMMhm+gjCg4XCfs+CG?=
 =?us-ascii?Q?nGCGIT6dWOz16wlgix60+lCBshZsqJt2mE9YvK4deuxs8HU+BxAg76cZ8Y/P?=
 =?us-ascii?Q?Jl/9b0yaBwJSJpAMx6vD84n2rTY+abyHn4Xj1PY28TT89EmrguhyYwfBEXjk?=
 =?us-ascii?Q?rx6t7f27v85MK7ZeQy+0UyZwXqc/N7ajH+ZPPNIbj1BSJPYEmFF4Y+aYmGGc?=
 =?us-ascii?Q?AQJKJYyw5WeMCkeDF7k0u2cI+umLcQv5XEhkEz2QSWZmAmRZsmZdcuQ3C7ow?=
 =?us-ascii?Q?yo8feuLXsmR59TIO45UlqFfH2ZQvKCroTFvEwmlt69+p0nl3GG7nBBgqnGw9?=
 =?us-ascii?Q?GBcYtooEcT6duMWphJSIsTvVnaDp984TrcwFaxtGvrgtCs77hbZzWSkayQ8u?=
 =?us-ascii?Q?Ag4Tl22flEV+NNIL8EOf2QC0qHLDujcu0ZucDZ9En2F1ii0BEsbNJdB8+cw6?=
 =?us-ascii?Q?dZodt/pwL1W+Dy2TYmF4QexGST4rhWd2/xH/TZ+hd3tvfuEe0/JnSxZ8xJqY?=
 =?us-ascii?Q?kMpMBtIPnL2oK+pZ02Qxq+mLt9ik/28BWeym1LE5JeiKMNw9AyFn2o0ng/GS?=
 =?us-ascii?Q?KLPhyK6N4Sz29Q4Z+KwiRPH8Y4KJrSw94oSYu1/feojrjmzN6KIbD24I9B+p?=
 =?us-ascii?Q?l9LMImlAfHrDWrY6lwRgVuPWVWSVUITehQe355Oe4ba/1MWyF9CIZ/K5OYu6?=
 =?us-ascii?Q?3urd2s3TSAqGWzx0dam5zn1kXo6pl28icoDo/EA8+GWJhv177agPQSylZewL?=
 =?us-ascii?Q?SdHax0PDLJQjylSbiSsVzFLIAgFt8rEms3zb3wLlI/l1q48rig8zMW9KGC+i?=
 =?us-ascii?Q?jtjWeH2xEtfRkKtPHantXT4HAT7XVlnfIP12w7H6Qp+eFOuVQUXvz2BcA6nC?=
 =?us-ascii?Q?He139MSlpROwn1hf6/Tus9NIhsamQlyNrgaWqECedbOQTThGv1IdiTBJWa6r?=
 =?us-ascii?Q?KL+a5QkU8ZAOOMxjVvBsUUlkWU5LmY39mJWH0DK3qTuvhdxct3Q/7HqPcEj9?=
 =?us-ascii?Q?QXx+vjson38AJ1hDlzxPw0NiMDkKboMATiXADOmR3nRfY2lvLLkPZCInZZ7G?=
 =?us-ascii?Q?AyP464roMWuIit23gBfEQTYYSDlloS0MyiJMp/agK5WqfYhC4i+jToUFHgO7?=
 =?us-ascii?Q?fvE3Ef7AKz+Zk41oLRC2ICF1hMFMUZj9JLhTRGwn9U3/D95lb4elPl3hwbcW?=
 =?us-ascii?Q?xVzJ/6NxPWXB7B9oCJth71Evto/mJtM+meMx+VpcN3boKv9lCueqsv75Zo3L?=
 =?us-ascii?Q?dhfF9uazygXAPKh+ibNv5zwqK7vKRrIDovOyGmVCvf4WmdhM1pRjJhu8+pYU?=
 =?us-ascii?Q?RdS2vf0rKqnhms/o98hLRkr9LlCZElwzkroAMsPcGuInJncwJe1w86dE4Oj7?=
 =?us-ascii?Q?wKkFI6MHCuR+VZcRSe2jG73t9V9mqtUdpuv69zI0voEeHoHJfPDWFxybOVzr?=
 =?us-ascii?Q?JYnfE3rj3Kf2m9ZzbDkfsWgK627pWeZiGGhCjYsz?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 576603d5-9d78-4029-b6e8-08de1887063e
X-MS-Exchange-CrossTenant-AuthSource: PH3PPF9E162731D.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 14:08:53.9858
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VBy2m4QBThWkdxKCSXEppp4MtHXHhOo0WR6KrNV6B+ufvpJfYtm+cRXupjpo7Fu1lg8/j2IEG2xu/lRisr3qxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8253
X-OriginatorOrg: intel.com

Sagi Shahar wrote:
> From: Erdem Aktas <erdemaktas@google.com>
> 
> Add support for TDX guests to issue TDCALLs to the TDX module.

Generally it is nice to have more details.  As someone new to TDX I
have to remind myself what a TDCALL is.  And any random kernel developer
reading this in the future will likely have even less clue than me.

Paraphrased from the spec:

TDCALL is the instruction used by the guest TD software (in TDX non-root
mode) to invoke guest-side TDX functions.  TDG.VP.VMCALL helps invoke
services from the host VMM.

Add support for TDX guests to invoke services from the host VMM.

> 
> Signed-off-by: Erdem Aktas <erdemaktas@google.com>
> Co-developed-by: Sagi Shahar <sagis@google.com>
> Signed-off-by: Sagi Shahar <sagis@google.com>
> ---

[snip]

> diff --git a/tools/testing/selftests/kvm/include/x86/tdx/tdcall.h b/tools/testing/selftests/kvm/include/x86/tdx/tdcall.h
> new file mode 100644
> index 000000000000..60c70646f876
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/include/x86/tdx/tdcall.h

[snip]

> +
> +/*
> + * Used in __tdx_tdcall() to pass down and get back registers' values of
> + * the TDCALL instruction when requesting services from the VMM.
> + *
> + * This is a software only structure and not part of the TDX module/VMM ABI.

This is a good comment.

> + */
> +struct tdx_tdcall_args {
> +	u64 r10;
> +	u64 r11;
> +	u64 r12;
> +	u64 r13;
> +	u64 r14;
> +	u64 r15;
> +};
> +

[snip]

> +
> +/*
> + * Bitmasks of exposed registers (with VMM).
> + */
> +#define TDX_R10		BIT(10)
> +#define TDX_R11		BIT(11)
> +#define TDX_R12		BIT(12)
> +#define TDX_R13		BIT(13)
> +#define TDX_R14		BIT(14)
> +#define TDX_R15		BIT(15)
> +
> +/*
> + * These registers are clobbered to hold arguments for each
> + * TDVMCALL. They are safe to expose to the VMM.

I'm not sure what this comment means by being 'safe to expose to the VMM'?
They are all overwritten per the data specified correct?

> + * Each bit in this mask represents a register ID. Bit field
> + * details can be found in TDX GHCI specification, section
> + * titled "TDCALL [TDG.VP.VMCALL] leaf".

TDX GHCI specification v1.5, March 2023
2.4.1 TDCALL [TDG.VP.VMCALL] leaf

This nails down any issues which may arise if the module/spec changes.

Ira

[snip]

