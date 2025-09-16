Return-Path: <linux-kselftest+bounces-41611-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F6EEB59FE0
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Sep 2025 19:58:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD0E646720D
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Sep 2025 17:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8A8D276022;
	Tue, 16 Sep 2025 17:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mSGU7dDy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1797D2905;
	Tue, 16 Sep 2025 17:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758045522; cv=fail; b=GvG4F2tGYMJRgt1F/jLuxop1jDdxeOBmBA5VBKNRmFbv8+n4I0+Rt66NbubYjIeBLcvImPTt1lISVrEDkT/0LIHuwT0puHR03Vqv7y9jRoGTqiyRCxzuPVIPNXppPcKWs/pcGwc5TwBz8gA3XCPZH8BEMttx2wRSKMwcpO4Xyac=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758045522; c=relaxed/simple;
	bh=cQHfA4NSiqf0juV8VcZ8AyaHw9XVVbmo93MQMHw1Wak=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=p0AuBa3q8E5LVVC/W5oZEQX3rStQKFHpYYZWEFon/sDbrbnYbyJ8Lnmoj3OxHBeT1DJS/QTl75rk3Fmv/o1pDSmI3KlKxrcDQStj5fSof/uGHUi90VwZgIwCDvq5QJKtsZlwAGUDSEMIL+BcrpgETNwnXfsu6R7G6S/ORj+cGjU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mSGU7dDy; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758045521; x=1789581521;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=cQHfA4NSiqf0juV8VcZ8AyaHw9XVVbmo93MQMHw1Wak=;
  b=mSGU7dDySXP4Lhw6vK0hcvEh76Zy+OemI12zLyDDsXuF0GsyNtQcruco
   gZJjPo161etGm795kbWcbxlO3RPZsnng5xubqDX0720yk+kukwp7R1r5l
   T/r2rf9sVgdja2xWb4xYlWxMgI3Rq6ftVvFfUNMQsGz6MtAmsVO5z/2O0
   nBaacF66K9cjrlUa9i2+Xnz+68X5tzWFQihpFtuviwmBLCx+zvyV8ITnB
   Kkrr3qC32YHPm+D59XqUVfRLgrKOkdG9iCxkfPWl+1Dxqagato6TH9rZm
   eER8wAaCZk3BvfOH8N/qpR0bOm5ifZsF3ybU+gAuzohD8xwKG6Y/2eKoX
   w==;
X-CSE-ConnectionGUID: xo2SoKSNS/O4RfQcCFZ/Mw==
X-CSE-MsgGUID: amBVhaPTQsKb4FHtQdwqJg==
X-IronPort-AV: E=McAfee;i="6800,10657,11555"; a="60479517"
X-IronPort-AV: E=Sophos;i="6.18,269,1751266800"; 
   d="scan'208";a="60479517"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2025 10:58:40 -0700
X-CSE-ConnectionGUID: Vue2AJAtRqSTROCTiJKEHQ==
X-CSE-MsgGUID: WBPTA/sPSXmckBc0G+YNuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,269,1751266800"; 
   d="scan'208";a="205797890"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2025 10:58:39 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 16 Sep 2025 10:58:38 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Tue, 16 Sep 2025 10:58:38 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.67) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 16 Sep 2025 10:58:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d0pM6qxeFHLbm3fwlPeVpFMZHjyReQbpAcPf4ccTjAS38Jfz7IJe/6gBErK0Ib8z5LjYiZ0U8buNKNed7j9j5Lzjm8E1FIjlBHJ3YLPYvGB5YXBFEoQdlpc60Ujt1FpPpaDXD7e3ScpGif/DvTHxVtBxJ8yZgg7gCeMoBIc2Fe0y/OyrGCrrrplcUE215pPDvFFYMVPn8xyCDl5VLelZh4s3yD3OKxd4HdRIwxozU/LYElgdwAzzezW+TfAqvhHqIXgl5wHzZYJoaTMcUTjqVwoQWZa5hV/TLjLBQZpONdU9kFUtnTpwD0cioACGAIdb9pLzNFQtVbFSWrVYEAse1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2nRRCgv00SGdYmg5rkwxgWlPkuKRRZSS8TDvbCHr274=;
 b=qGwaBYuJLtQnHcf/nVGeXzwE+whGmbYcnffhSRNc85fkhcOJygnfhHnntRjMf15qAGUbKbDETVu40UJtYa0Qx+5gi+vVui4Qr3UG+etab8kreKLAMRVBtMJoGFyz1/1jVAOWf7RM3FJT7L+e1fo14jHKAPBNB9gMmMnvVOkR2jfgfcRYRoJYNYS6AN318rHpEHAlPUek9b8h21Y37xdZ9aRhZWzjuDV7DFmDO9SoSi0rdgHkPmd7Ry/jBI7gCSxoE4oXFD7V38nFz/D4H4McsltoRdcm1IQIDq3upTT/mg0MX6kPNNoX7DCU8RzSKjhCfODuYH2Ecbvx3zNKBmPvvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 PH0PR11MB5950.namprd11.prod.outlook.com (2603:10b6:510:14f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Tue, 16 Sep
 2025 17:58:31 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%4]) with mapi id 15.20.9115.020; Tue, 16 Sep 2025
 17:58:31 +0000
Date: Tue, 16 Sep 2025 19:58:13 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>
CC: =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>, Magnus Karlsson
	<magnus.karlsson@intel.com>, Jonathan Lemon <jonathan.lemon@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, "Yonghong
 Song" <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>,
	"KP Singh" <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao
 Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko
	<mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, "David S. Miller"
	<davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, "Jesper Dangaard
 Brouer" <hawk@kernel.org>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Alexis Lothore <alexis.lothore@bootlin.com>, <netdev@vger.kernel.org>,
	<bpf@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next v3 03/14] selftests/bpf: test_xsk: Fix memory
 leaks
Message-ID: <aMmlNc1z5ULnOjJY@boxer>
References: <20250904-xsk-v3-0-ce382e331485@bootlin.com>
 <20250904-xsk-v3-3-ce382e331485@bootlin.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250904-xsk-v3-3-ce382e331485@bootlin.com>
X-ClientProxiedBy: TLZP290CA0014.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::13) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|PH0PR11MB5950:EE_
X-MS-Office365-Filtering-Correlation-Id: e2848111-4eec-4d4b-4ec7-08ddf54aa5a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?p36QRdlpcQgU9+b/jLE48qZXsqQ5KSGDqkVV+cKQZYWjebqndcCI/jVzswbO?=
 =?us-ascii?Q?2IzsucFk4RbAnC5JDi5PWqh1bj3WD9JXuVrJMduUG/EdiEz/nezW6JurVEu5?=
 =?us-ascii?Q?wJhinMV+oa1Hq0EktO0g+RMNydKISBx093dvqx12SG0kRWPmOM5WG3dw709m?=
 =?us-ascii?Q?mTXX2l+mSKvRzXo6NdCpgjvybYfogLyx0iQl9gw/wqD54uGJfdR71i2kGhzL?=
 =?us-ascii?Q?geOBTFej0iAOJpTUERasbKVCfNsDjocPtrLEP9ZcCH1KreeIhHnxogwrza0v?=
 =?us-ascii?Q?d6wt+h01BksCgA8596YT3e9oGQ99TIgyc4iYRoVc4FFrEfAqksUFmIPVf2sw?=
 =?us-ascii?Q?aaVJcsnolgX8JTl71LPQ5keWLLReqc+f/FHtpLaHJ+x1UKVrPct4IfU9z8QD?=
 =?us-ascii?Q?cwSu9R4OTOh6TFMs/GUQpHLLNnR5FdlmAEW2hxuVX1jvsCncpxHXGHfBZ8t5?=
 =?us-ascii?Q?biAo5YZIguQQo9kv1BqaKfY2UpCXIfph0cFnFMQv+5TGB1iVsnVmUIFWvd6W?=
 =?us-ascii?Q?UIpShSSL0XITvriXBPPhgE45hOXb4a60qLI0E7kBDm2Y4ciUDxXFFc+HfWHA?=
 =?us-ascii?Q?eU9EAUJvljJn9AjBWA+4dTgnlfaotWsNgLOLAAUzFW2cSR0TCQgZMUEqEDzz?=
 =?us-ascii?Q?FRB2pXsxUP5dI6HPVCY5Y2ZpKXajWzX2JODRDXLcCMJexn1XJBivCG4yD/7M?=
 =?us-ascii?Q?WKiILaT2y3Sl8h25NYPCzsXqmwlSgIAopGi/iYqBsLA51b36y1JNx/G9RhXQ?=
 =?us-ascii?Q?jaJ70YOlONth2g7U9NxdBkiD7CYORjsahY8mNz0+XT3Y+485xDkUwvheJfwm?=
 =?us-ascii?Q?MqbpXWib5wBHot9TzUg68lE6vbwmw7SMzvJGY44H1CdaaPsuMeev2/JWRjBY?=
 =?us-ascii?Q?dkInP+HVwHHb2UEQGTV6HNgvKE1t0SEn6V8fE15/RyTHq7NVJHyKK5o9OIW5?=
 =?us-ascii?Q?5bkltibsiSIL6k1Heofc4KoCobHTTNEg9hTSCtdYfxnHbsQlFI3whMxc0WE3?=
 =?us-ascii?Q?HOy9eYT7oW30Q3YROHxWTxjWKO6EfJpr8WfJ60VhFtwUyFuUhVQBQTOz9sF+?=
 =?us-ascii?Q?CiGVJ1O040HxZYlX8N9LAPdbiUxF22zl2lhWjTbDoi1gA79okDe+M8SrdIFM?=
 =?us-ascii?Q?8cpyJ6G6/19CrZCuFPrnaqbFgwtHoLbTE/WUxAFfrRvYvrnlfW+r9hhAYj50?=
 =?us-ascii?Q?DJciKMaY5pRBat6yGMOze4jkpNlXB7ws5QZ1W2raHR7VEqK0GDwHrDrlfr1/?=
 =?us-ascii?Q?6hDG8uW51MmoVgvXq6T5t92ITx08YBTdEaiPfu+NU3SvrRvI3q8e7UWsDD3s?=
 =?us-ascii?Q?OIQ9gcwksTl8ekNvIANjeYwcOrZm3ErA2XKC/35Kg/+wjRB5U1jE/W4q6uLW?=
 =?us-ascii?Q?zVNfr7J3PUoKttsaTSNMKee1FDjP+45OexfweZxqRCalrCz1F4bJVMT0AnDU?=
 =?us-ascii?Q?FI/ozy7LOJE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Q51s9Upv7GdduXbvm/KbBfA94p4abZ5N1uxIDycS2Mj9T8FMP650PsZxsioR?=
 =?us-ascii?Q?3IQ037jvjwYgQCez6hoOZXq1/btHRy9DOXtmjc3/zGjVqdYR1wzi9/J4l/oU?=
 =?us-ascii?Q?3hiFozShu47pCZTAkhYrj0GQEMpHkawr8+64ZMDaUE2AK3eR7uueOEE950yn?=
 =?us-ascii?Q?tnhMfXrO4LrP4ADvkNqiymbLZr6n50QYuYzQ+YZoO3DkYB6lmBkHtXaQNSZx?=
 =?us-ascii?Q?cPP2IrliSbhHoztj3hpMLWsn8t77j38YhmZJgqJ8HG1iRHcIkvEOF8qx1Zix?=
 =?us-ascii?Q?/sICQa9QBKLf+myEkYVHRhQw4to/nhB+D/JLnVormxtG6BGvQUUcFlHOW909?=
 =?us-ascii?Q?W1QLi9nuIQAyC5iuZCUjBmElXH0rwhARb6zP0CkDCw8GzjQNgwmplWrpotiK?=
 =?us-ascii?Q?FvPxHDh7xNOvokU+pHfCcRNE1vnIBDNPKn87gjHB2cPRFX1pcyHLs6lD8+gO?=
 =?us-ascii?Q?a/mMuICZLTqQ0iZNcMuxbpeosPzOkoisJBoOK/Lcema0DiYxxDmN4ugF4RFH?=
 =?us-ascii?Q?BZlvBMaEOAlI93C9peGzo1UmHiiEBlZxYvLAMYrFxDIsKl8kilnjyLgW8QkX?=
 =?us-ascii?Q?C7A2kmgGTGuiQI/R91NQqrx7vWSxqRuQMRcK/XMuiSo1RgT+02XszFMs4hNl?=
 =?us-ascii?Q?V/VwecfH5Lkk51P3U/hl/8wiX2w/MobvySVVK9wBO2ANflhK/dy/P9bfMLvg?=
 =?us-ascii?Q?p2Vh4StNO+Q4gH3DNIL9GooX7bwZxhdR0ZNcB5C6YcG26uDIiPCouCv8qbxW?=
 =?us-ascii?Q?dMPl12BI2De/WzINXCTxAGD87XiN/QFdy9XBZHfplyNW0ZhBvnXsFtRhGVt6?=
 =?us-ascii?Q?2fctEIX5g9Oy9ijE62+AnPkK+iAYplw7rbLhyrzhwbfIqQvaxj8AgG2ZiENs?=
 =?us-ascii?Q?o7XYSmEH6E0xTBQf6NvszvdVyHyNzVJPDRKn2ww1vwSMR60TdRpvtBFe7qQc?=
 =?us-ascii?Q?mu7TPHYWmUpPYJngriUhBQqP/wLSEq4Z0XwUQ8eLRWF+6pvTsTVHtDkL7trC?=
 =?us-ascii?Q?te9hoJI4GB2gROkrfVtLgsgqOJOzfoJB7ZdJdOArZbryO/8KVs53NuiS99Cc?=
 =?us-ascii?Q?IoHJbKGvIZS0C9qPW8x0j419H5aogASm8zby4Arb1zD+IPR0rhdInbsT/Z+H?=
 =?us-ascii?Q?I1ynh9ylVvqXFwr8cxrxPnIMcjURA7Q00PWwLFkdAdwlghKQjk8NVdRcyi6D?=
 =?us-ascii?Q?oStx0fCpU+apxGjezVs7i62LUwv+4rHLiNyeBS+AuTASef75hl8VdHhCaK9u?=
 =?us-ascii?Q?8PLTIX2wt81AHbbqoLiORBeJiNLnaCGEJD0U0ywzazAw2jqLXuL99b0R1uex?=
 =?us-ascii?Q?yxc782jZHhKUWugpvoxBBctPO/x6y+01jWT79d3m9uA+Y+ex9N+Lm+SgmLpy?=
 =?us-ascii?Q?8NJPYl34Z5oKxXNxJCws2vc8bDsLrpD4ZnFg3whCVD7obtWJO6BsDb7WqnQD?=
 =?us-ascii?Q?D83mdTvgose4wdOyDl2uL8342dghR9Mp+QXlLQeI+U1e3rVvg5g5yuAqCjmj?=
 =?us-ascii?Q?hjX24Rz8BIgQgsNDjccvvnr4lyhWmlUEWJ2KAHPeJCHIMt5fRd7bhoBJMj+v?=
 =?us-ascii?Q?gTGY/lcetcWOO863/7Enus5Q+8kYFuaFkcOJRdxPXrLrowD6BF5CZl8FwM3c?=
 =?us-ascii?Q?Bw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e2848111-4eec-4d4b-4ec7-08ddf54aa5a9
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2025 17:58:31.6171
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u3sA+/TGGRkqtYu1dRFzhHJFlWG4y4Bze7V5TNaj/YM2aMXUMd6rfydz15SW594NJK7D2dzUdiXuHuquR2VRnI4FbXue67iJChrx8XYNSGQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5950
X-OriginatorOrg: intel.com

On Thu, Sep 04, 2025 at 12:10:18PM +0200, Bastien Curutchet (eBPF Foundation) wrote:
> Some tests introduce memory leaks by not freeing all the pkt_stream
> objects they're creating.
> 
> Fix these memory leaks.

I would appreciate being more explicit here as I've been scratching my
head here.

From what I see the problem is with testapp_stats_rx_dropped() as it's the
one case that uses replace and receive half of pkt streams, both of which
overwrite the default pkt stream. So we lose a pointer to one of pkt
streams and leak it eventually.

Rest of cases should be ok with pkt_stream_restore_default() being called
after each ->test_func() in run_pkt_test().

Anyways let me hear more on your reasoning, thanks! I'm gonna have a
second look tomorrow, I might be missing something.

> 
> Signed-off-by: Bastien Curutchet (eBPF Foundation) <bastien.curutchet@bootlin.com>
> ---
>  tools/testing/selftests/bpf/test_xsk.c | 32 +++++++++++++++++++++++++++++++-
>  1 file changed, 31 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/bpf/test_xsk.c b/tools/testing/selftests/bpf/test_xsk.c
> index 37752b2dad651b36d155051931d7b3b902fac403..e4059c7d0a289449a6b73669fa87f7440b7f55c0 100644
> --- a/tools/testing/selftests/bpf/test_xsk.c
> +++ b/tools/testing/selftests/bpf/test_xsk.c
> @@ -546,6 +546,13 @@ static void pkt_stream_receive_half(struct test_spec *test)
>  	struct pkt_stream *pkt_stream = test->ifobj_tx->xsk->pkt_stream;
>  	u32 i;
>  
> +	if (test->ifobj_rx->xsk->pkt_stream != test->rx_pkt_stream_default)
> +		/* Packet stream has already been replaced so we have to release this one.
> +		 * The newly created one will be freed by the restore_default() at the
> +		 * end of the test
> +		 */
> +		pkt_stream_delete(test->ifobj_rx->xsk->pkt_stream);
> +
>  	test->ifobj_rx->xsk->pkt_stream = pkt_stream_generate(pkt_stream->nb_pkts,
>  							      pkt_stream->pkts[0].len);
>  	pkt_stream = test->ifobj_rx->xsk->pkt_stream;
> @@ -573,6 +580,22 @@ static void pkt_stream_even_odd_sequence(struct test_spec *test)
>  	}
>  }
>  
> +static void release_even_odd_sequence(struct test_spec *test)
> +{
> +	struct pkt_stream *later_free_tx = test->ifobj_tx->xsk->pkt_stream;
> +	struct pkt_stream *later_free_rx = test->ifobj_rx->xsk->pkt_stream;
> +	int i;
> +
> +	for (i = 0; i < test->nb_sockets; i++) {
> +		/* later_free_{rx/tx} will be freed by restore_default() */
> +		if (test->ifobj_tx->xsk_arr[i].pkt_stream != later_free_tx)
> +			pkt_stream_delete(test->ifobj_tx->xsk_arr[i].pkt_stream);
> +		if (test->ifobj_rx->xsk_arr[i].pkt_stream != later_free_rx)
> +			pkt_stream_delete(test->ifobj_rx->xsk_arr[i].pkt_stream);
> +	}
> +
> +}
> +
>  static u64 pkt_get_addr(struct pkt *pkt, struct xsk_umem_info *umem)
>  {
>  	if (!pkt->valid)
> @@ -1874,6 +1897,7 @@ int testapp_stats_tx_invalid_descs(struct test_spec *test)
>  int testapp_stats_rx_full(struct test_spec *test)
>  {
>  	pkt_stream_replace(test, DEFAULT_UMEM_BUFFERS + DEFAULT_UMEM_BUFFERS / 2, MIN_PKT_SIZE);
> +	pkt_stream_delete(test->ifobj_rx->xsk->pkt_stream);
>  	test->ifobj_rx->xsk->pkt_stream = pkt_stream_generate(DEFAULT_UMEM_BUFFERS, MIN_PKT_SIZE);
>  
>  	test->ifobj_rx->xsk->rxqsize = DEFAULT_UMEM_BUFFERS;
> @@ -1885,6 +1909,7 @@ int testapp_stats_rx_full(struct test_spec *test)
>  int testapp_stats_fill_empty(struct test_spec *test)
>  {
>  	pkt_stream_replace(test, DEFAULT_UMEM_BUFFERS + DEFAULT_UMEM_BUFFERS / 2, MIN_PKT_SIZE);
> +	pkt_stream_delete(test->ifobj_rx->xsk->pkt_stream);
>  	test->ifobj_rx->xsk->pkt_stream = pkt_stream_generate(DEFAULT_UMEM_BUFFERS, MIN_PKT_SIZE);
>  
>  	test->ifobj_rx->use_fill_ring = false;
> @@ -2043,6 +2068,7 @@ int testapp_xdp_shared_umem(struct test_spec *test)
>  {
>  	struct xsk_xdp_progs *skel_rx = test->ifobj_rx->xdp_progs;
>  	struct xsk_xdp_progs *skel_tx = test->ifobj_tx->xdp_progs;
> +	int ret;
>  
>  	test->total_steps = 1;
>  	test->nb_sockets = 2;
> @@ -2053,7 +2079,11 @@ int testapp_xdp_shared_umem(struct test_spec *test)
>  
>  	pkt_stream_even_odd_sequence(test);
>  
> -	return testapp_validate_traffic(test);
> +	ret = testapp_validate_traffic(test);
> +
> +	release_even_odd_sequence(test);
> +
> +	return ret;
>  }
>  
>  int testapp_poll_txq_tmout(struct test_spec *test)
> 
> -- 
> 2.50.1
> 

