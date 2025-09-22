Return-Path: <linux-kselftest+bounces-42049-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EDD36B8FF54
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Sep 2025 12:16:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1ABB116230F
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Sep 2025 10:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6C9E287277;
	Mon, 22 Sep 2025 10:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Bisi2xW+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EE532AE99;
	Mon, 22 Sep 2025 10:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758536192; cv=fail; b=mXQ/nN4NEkej4KG3PDZ/V/8ddIzaTY2q66yC1BYyIV7HYf8A+suI/FijIV6+bHvey5heQ0zhri0px3hUfVMJvMEv2LCuWtoHaAUTB7Azv2cQwF9QNtRm//iN96oakyd708i6HNWXsCNUqh3Xv996vmFCJWlXIkIR0zIpeVH4IQc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758536192; c=relaxed/simple;
	bh=qgXQWOeWBUCztso+g3zt3YRKeELrA8CPRid9NsVjtso=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=g4OWLghFCtTsx30Ia7iT63bmReIuOMIf9aIBmfDgZO9KZ3uTk4rSblvISB13rpnaStd5LKmBkAliURZjWFByccVK91Xzr/jrEynA1aIfb4JhEhSXDHTUWLGDB88fiSbqrKe3UCuNqunAGGQvIsAJHR6UXWZz6CkwYUa365ePfOo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Bisi2xW+; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758536191; x=1790072191;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=qgXQWOeWBUCztso+g3zt3YRKeELrA8CPRid9NsVjtso=;
  b=Bisi2xW+i0fSWIVdPWg38Px7AWtgqmKvkCMnH1BVgXU5wuVSYehv2cUT
   zH1I2sHTozTzGbVeMO+uLRm0DQI+PZXhvTbcxrdL9GXcvlmgkLDWynt1J
   Tb0Gu6irgdzSVvn/LeV+J76gw1vi4Kzjy2VS5AaLj9S/dnDVbfq82+4Hy
   ieZc+ExUXVzW0c4P7izkyLgJnwNltQi4iDh1XLMRzZGXW2gkBNlhwgmrp
   56xob/XSH3dcAu8vzuf4OUU1DkrJC+0VqqByKCdJ9nI0JiEWxgHuXOa3O
   oJmUblm0fzUJ1XePj73f0BGjMtfeRL63uU+Pp8sImbLqStbDZzYtSC0Pd
   g==;
X-CSE-ConnectionGUID: xfQ+9WKOStq7aqj/43Mf6g==
X-CSE-MsgGUID: 3axnVynmS5O5ggNZ20d5ig==
X-IronPort-AV: E=McAfee;i="6800,10657,11560"; a="72219748"
X-IronPort-AV: E=Sophos;i="6.18,284,1751266800"; 
   d="scan'208";a="72219748"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2025 03:16:30 -0700
X-CSE-ConnectionGUID: fjZ8MQhfTGGxZ4KACshT7g==
X-CSE-MsgGUID: Fo0HzdArRuajsWFfKhcHpw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,284,1751266800"; 
   d="scan'208";a="180852849"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2025 03:16:29 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 22 Sep 2025 03:16:28 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Mon, 22 Sep 2025 03:16:28 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.37) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 22 Sep 2025 03:16:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WKS6poqbM0Lpq7p6Y5CTVjj5rzzfhXBqK7r2DNM0IGFuMfoX5G8Ng6UxkViXLTWQ6W+G02Rvs1COd7g6O7B5iAp/U1HgWxY+gLSiND7bkBM109tsSjgs6hHaAlsDUYKTq/Xd/3/h/d+CeU0hI1H0cf0aeF/uaNXAWLq7u2Ti6hzpps8jmCFjwNDMx2TmFban2docq2VTNwW0KrUpUW49OOiKsLBXs6R51bME1GTxp5rsqJKgoqsQgUu94yn9O9uAJWu+0UAu/hihg+h02Dluf/zvHvzRLHwXLJkX8k9hZfMW20U619QVNL0oerLS1CJYvmHN3Lbcuxmk5GzF+WkvsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WuVcjPQIWa8RATW74vNModhAjRIMQJyyMJYiIkVJT88=;
 b=Wkkj2MdnTCgIOPOmvv21aI4VUv03GHeiiATKwCOXogH94Da4JJP3f/lv8WLu//4XRRBIFVM/mVTnIzEONJ/Ong+g6sWHDKxZ93GcJr43M+r7MVDePpDQO9mpb6D/U0tML//UcOYaLWYBAyPQ6HRiPHALznyUoYtGxSoZQm5vFPmCRyv9a5AdGaYAHrv4MqUl/cxlSVkd0iVFlSG+gi3fKl1Wmr3LQzNzXHkwpqph10x0SLy0y37+fg0vNVlTIlF4sBeywqASNYbWfG1Mp4mL2WG2Sywsz+3C8eAwgafSx4jDU7PLu8T9gWA6R/c6pJ5ivCktNIaIuR03LU1IcpUdOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 PH3PPFD80FA6330.namprd11.prod.outlook.com (2603:10b6:518:1::d52) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Mon, 22 Sep
 2025 10:16:21 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%4]) with mapi id 15.20.9137.018; Mon, 22 Sep 2025
 10:16:21 +0000
Date: Mon, 22 Sep 2025 12:16:05 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>
CC: Donald Hunter <donald.hunter@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, "Alexei
 Starovoitov" <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
	"Jesper Dangaard Brouer" <hawk@kernel.org>, John Fastabend
	<john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, Andrew Lunn
	<andrew+netdev@lunn.ch>, Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek
 Kitszel <przemyslaw.kitszel@intel.com>, Alexander Lobakin
	<aleksander.lobakin@intel.com>, Andrii Nakryiko <andrii@kernel.org>, "Martin
 KaFai Lau" <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
	"Song Liu" <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, KP
 Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>, Jiri Olsa
	<jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, <netdev@vger.kernel.org>,
	<bpf@vger.kernel.org>, <intel-wired-lan@lists.osuosl.org>,
	<linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH RFC bpf-next 4/6] net: ice: Add xmo_rx_checksum callback
Message-ID: <aNEh5Q1c93J0p9TN@boxer>
References: <20250920-xdp-meta-rxcksum-v1-0-35e76a8a84e7@kernel.org>
 <20250920-xdp-meta-rxcksum-v1-4-35e76a8a84e7@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250920-xdp-meta-rxcksum-v1-4-35e76a8a84e7@kernel.org>
X-ClientProxiedBy: TL0P290CA0008.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:5::19) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|PH3PPFD80FA6330:EE_
X-MS-Office365-Filtering-Correlation-Id: 375bb455-2314-4eb2-3a7f-08ddf9c113ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?qZ5mfRlJ7onR8ehZzbweaq9Um825BNNf0JSnGo5KWy53drtHBzrgFyyDNzm5?=
 =?us-ascii?Q?etKj/zic1QvZbH7z5njMfdKIDuAsPEHC7fH8HuG1idjNUhUQ7AAGX9ISUELL?=
 =?us-ascii?Q?b89AJUJl8IJ9nX1O0SmQe9o+JECTZSwPNbUQoarncKvtOUROvZDcrpv2nqA9?=
 =?us-ascii?Q?BfF1JgnLDUVdD6Q2b82TvkZGSsfwuiFm/Zq6Vgv07NFhlPjpKSC2i6mWA4Ik?=
 =?us-ascii?Q?kenLG24A+B0Tnvr6xLAAGG58CuuO/eK503azsev7ONFxXMxR49HUx7BvqhTM?=
 =?us-ascii?Q?RtFdvp3tIrGqRQf1Hwh6U3teYUiUwo0BMh6y2f8BOOK7YTxrnHSuBVD5WQh6?=
 =?us-ascii?Q?hwNJp8cp4ZRk1eHEsRrIVSVsLyG90al+GWK43JjregmavT9TmpZb2ZRJC3Jd?=
 =?us-ascii?Q?34I8O3zgfPh2VnSjR7KS8hMqa034pLQ3gfdHQL0HuJyeOLpBdvepCoassUWV?=
 =?us-ascii?Q?hUiyxep+5E8iyj5h+55xgFwOZzc1wt80Q+lekviph0TmD0uJ6jh0k2zSA/7t?=
 =?us-ascii?Q?5Ub7a7crAMWzxa0uVtkRyhXmPGgmQL5eJ7ukVtghG3DV/Yq25163+RQ0x7xW?=
 =?us-ascii?Q?Q/e8sbvTSQZn+g5/wx+/Z14NUBH7xM+/hp/42zPvc9XrLBWZd/POaPSXylUD?=
 =?us-ascii?Q?cfsIC9JEXgayBFxL82NHt3hlMAOTVPFWLjeL/9NUb/R+0bzGmsqqEevSos/I?=
 =?us-ascii?Q?39RQX/Vr/2fnzHzX8JmylDdLMIfYqjbvE0j1HTZTSSNRvl0gc0DImFGO5jjg?=
 =?us-ascii?Q?vD8m9TUUn5isYdP9CJhFS2YSxQgov6QJ70ZtbuJcOxqDf5g1jXHIHTkakaof?=
 =?us-ascii?Q?flXUkzzyLutHkndtfEmL36rtijmfF1bi5TvJhcjjLB+Df9zr0pFGQ/v9cIfz?=
 =?us-ascii?Q?gXw0y6s93XS7Kg2jrD+J5BhQ8RE8a7F/wQa0nvEH7w0lH3LyceMI7qvExdbh?=
 =?us-ascii?Q?jBUlxBQgPAz/M5ccRlDOg3Swa5mcYmmcnQp57pW6/8gI6xnvAFpsJ41m8Rj7?=
 =?us-ascii?Q?VdcG8iptrOhI/Ey1plBn6dPtO6lEf72p/ZUhfGXsZgNMgaLkvH6V3AhyAERn?=
 =?us-ascii?Q?RkChnBkiF9fCyJjw8fbtPAgx2q7AhMEGHtbMmO1mFK/3uMlDjnJrDOVfbznG?=
 =?us-ascii?Q?3owxNNN8wqb85Q8E9b5rPmrhLurhd3ybb7xL1kVTNTM1TsRLin2+NMTXMsPs?=
 =?us-ascii?Q?yHiO4i5RpjwFmjbdz5vcY4sD13TsiyX9ggauMAIPFACBnkyJtaOhQWBPADMT?=
 =?us-ascii?Q?uEqM++u0S7arRJnSJDogCTu8L6io6+X5a3rKa2aQjV35Mk5pbQaJXRwtymmA?=
 =?us-ascii?Q?jAUAOcVtlENadkO+P/EbfKuAvJT3qM+el2OyYqbbaTMkn9Y90Zg1rGZvi9aV?=
 =?us-ascii?Q?bDOvAvLl8YA1GpAHE8j2ZKGcXSI+7zXPLfpVBdydbJSzV8UO4V4pH9GpEp8i?=
 =?us-ascii?Q?lHbXuSYshJs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MYa2P2avse2Ya9udv2Dg/nuZN9r5Ge3SxUSVlVWNcrMO6tT4BXjpTlnhKdKp?=
 =?us-ascii?Q?DP35hW2kNSMHOkooHwQnZmg1Wq4xXb/GkPTVDeeP6UE9gb7nCxdv6vycM7h1?=
 =?us-ascii?Q?7FyUmyglpeGlnHRRgLpTDBReOVJ7PA9MnOdnuCm/NBuF2kWZq7ybPwL4zRGU?=
 =?us-ascii?Q?ffsC9p2hGvu8DpIWTX5NYsD4jALpoCSXS3/GN0TRCqaadC9se/Yw49MPRnyj?=
 =?us-ascii?Q?c8Ra03AgYJ73OQiZf1HC6zxjzTO5oI3DhxCRrHaZNcl/4ReZGD/wJ+wOQrYR?=
 =?us-ascii?Q?D9kaSEpOFeYHFwnr0ZnC6BqtRSzmDr29jxQ3AAEWlahustrQ/jkSriVojVIQ?=
 =?us-ascii?Q?TXjgn6/484L9/yNYv0BCjZnSUyivFGrWUx63X4jLDoOcC64BYYJV7JtMJ+d6?=
 =?us-ascii?Q?mph71kgGYjXticVUL5AS1A9WhZOJ07Znp5A5PjTpOivoUY5F7Iv2EthFG7Nw?=
 =?us-ascii?Q?Gs9u0vP42S9hXa7LSHx/ZqV1Cmf1Aus4JV/qg20qis6ar/raEBOpD5XwvDEI?=
 =?us-ascii?Q?4wB+zMPdBStThak+c4zsxpR1xLCJNt32JKxVuDXs9jD1ekbdBYYGDRBg4vtZ?=
 =?us-ascii?Q?Cvu0dVv3jxiJ0UpAN5eoKH2Qrp4NF88B1P/M7USDysO/fUb0ElNoLnhMDk6+?=
 =?us-ascii?Q?bx3Wspq6bcy8hCyIOOuVqmzEDuVl0O07UYmVieixOYYnlWEQoVM1p2lr1+Mi?=
 =?us-ascii?Q?p1joCk6xExbdNNssonUcSz3JY1bkKmL9tAZLJtNsgjSW3LTbDKsIe7Pawfx+?=
 =?us-ascii?Q?pyXJkksdWWgsuS5bdANXBE/i7Vqt0R5nsAFIEKhpfiLrZETFnQ7uIEUWuLO/?=
 =?us-ascii?Q?Xuu4lZ1RMMDNfAnNjNZmWvnHyxfx7lUqUH6zjtLA0L0Z5OFjmPgfkvSqi0Kj?=
 =?us-ascii?Q?MVjj6aujWnx8D+WHd7Neh+gi9ElzneyE/UUwnmaa8QDLPS3CfdKeNNgww8V7?=
 =?us-ascii?Q?Y/J2932SlP42zh7KO0kqAf+41ZewxGh5mxDxynDRhwWXjE0Zw20yP0rrzW6Q?=
 =?us-ascii?Q?TV8loLFfw9YEOYxYH4nInQnRNvTBDMzs4EmnPIl+YkYe65sXdEUdWS9JJXXw?=
 =?us-ascii?Q?QrBHzXcVixXzfKsAtcGz3tNpIwtVzr4zqHJZULmnKDMMTigpuXmiF6JmReNg?=
 =?us-ascii?Q?airakNNe0PnId2OJNyFT+aaUGHXV1BW2BdIazRDmUr5N17+r2OBroB3AX5C3?=
 =?us-ascii?Q?H/5g80zleRBvHAWK+zj48Ga1W+d93Mu7UG93/v2H7eJMXdGDcpJLuzSHA7OB?=
 =?us-ascii?Q?RGZqO8V0e8Ako5dtyd88tKqbYyCrjde0cZ0irbFwT9YxVmpPxCs9dUgYvTIg?=
 =?us-ascii?Q?Q3wREikUszNNDEuKumGVvQkI2QFO1TwlG9NORIrPzp4hy67HyAGYHlpeave+?=
 =?us-ascii?Q?CyepLbVkveYPvR64WKNqulOkHBbPkpyFYVJ+YJTY/CsXal6w1qyv9k5kr1Xr?=
 =?us-ascii?Q?xysbeJLAjhBL6LjEOa4lbtd8vyV9W7TbgYhx8W9Hk6VirYB1xxnrZcuT95cF?=
 =?us-ascii?Q?cWZRCsun1KsaAmf28k7gEGUVWgd5ZDliXpoSiznqF1aNmckJkqUd3jLrD6Sz?=
 =?us-ascii?Q?iFNCa23m81cU25NYpfPGGB3GKwb1VQl8TW2bFeUBQk+l3d1I0N+sMctKOuLr?=
 =?us-ascii?Q?Fw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 375bb455-2314-4eb2-3a7f-08ddf9c113ae
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2025 10:16:21.2158
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aW4YxaGcUIs30Hu3v2O+EtnN5y9ue8fZt+CF5cEyQs5tsy4KFqsR/0pIYFFMFc3XZ47eDzjMOQZRdjeEfTC9b1g5CacU2wpyuPDbffZrYhQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPFD80FA6330
X-OriginatorOrg: intel.com

On Sat, Sep 20, 2025 at 02:20:30PM +0200, Lorenzo Bianconi wrote:
> Implement xmo_rx_checksum callback in ice driver to report RX checksum
> result to the eBPF program bounded to the NIC.
> 
> Tested-by: Jesper Dangaard Brouer <hawk@kernel.org>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  drivers/net/ethernet/intel/ice/ice_base.c     |  1 +
>  drivers/net/ethernet/intel/ice/ice_txrx.h     |  1 +
>  drivers/net/ethernet/intel/ice/ice_txrx_lib.c | 82 +++++++++++++++++++++++++++
>  3 files changed, 84 insertions(+)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_base.c b/drivers/net/ethernet/intel/ice/ice_base.c
> index c5da8e9cc0a0e5551b340e70628813999059bcfe..e8ec419bdc98cb1f01e3c088698b0c4c0f97748f 100644
> --- a/drivers/net/ethernet/intel/ice/ice_base.c
> +++ b/drivers/net/ethernet/intel/ice/ice_base.c
> @@ -591,6 +591,7 @@ static int ice_vsi_cfg_rxq(struct ice_rx_ring *ring)
>  		}
>  	}
>  
> +	ring->pkt_ctx.rxq_flags = ring->flags;
>  	xdp_init_buff(&ring->xdp, ice_get_frame_sz(ring), &ring->xdp_rxq);
>  	ring->xdp.data = NULL;
>  	ring->xdp_ext.pkt_ctx = &ring->pkt_ctx;
> diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.h b/drivers/net/ethernet/intel/ice/ice_txrx.h
> index 2fd8e78178a271c15fc054ef553bd509b1c8f8f3..96a2bb79e5e95fa0b9c6287eb9769bdecf47dec1 100644
> --- a/drivers/net/ethernet/intel/ice/ice_txrx.h
> +++ b/drivers/net/ethernet/intel/ice/ice_txrx.h
> @@ -260,6 +260,7 @@ enum ice_rx_dtype {
>  struct ice_pkt_ctx {
>  	u64 cached_phctime;
>  	__be16 vlan_proto;
> +	u8 rxq_flags;
>  };
>  
>  struct ice_xdp_buff {
> diff --git a/drivers/net/ethernet/intel/ice/ice_txrx_lib.c b/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
> index 45cfaabc41cbeb9b119a0e95547e012e0df1e188..5327b0389ec1a3708a469fa9986a1e565b20ecf7 100644
> --- a/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
> +++ b/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
> @@ -555,6 +555,87 @@ static int ice_xdp_rx_hash(const struct xdp_md *ctx, u32 *hash,
>  	return 0;
>  }
>  
> +/**
> + * ice_xdp_rx_checksum - RX checksum XDP hint handler
> + * @ctx: XDP buff pointer
> + * @ip_summed: RX checksum result destination address
> + * @cksum_meta: XDP RX checksum metadata destination address
> + *
> + * Copy RX checksum result (if available) and its metadata to the
> + * destination address.
> + */
> +static int ice_xdp_rx_checksum(const struct xdp_md *ctx, u8 *ip_summed,
> +			       u32 *cksum_meta)

Hi Lorenzo,

any chance we could have some common code used both here and in
ice_rx_csum() ?

> +{
> +	const struct ice_xdp_buff *xdp_ext = (void *)ctx;
> +	const union ice_32b_rx_flex_desc *rx_desc = xdp_ext->eop_desc;
> +	u16 rx_status0, rx_status1, ptype = ice_get_ptype(rx_desc);
> +	struct libeth_rx_pt decoded = libie_rx_pt_parse(ptype);
> +	bool ipv4, ipv6;
> +
> +	if (!libeth_rx_pt_has_checksum(xdp_ext->xdp_buff.rxq->dev, decoded))
> +		goto checksum_none;
> +
> +	rx_status0 = le16_to_cpu(rx_desc->wb.status_error0);
> +	rx_status1 = le16_to_cpu(rx_desc->wb.status_error1);
> +	if ((xdp_ext->pkt_ctx->rxq_flags & ICE_RX_FLAGS_RING_GCS) &&
> +	    rx_desc->wb.rxdid == ICE_RXDID_FLEX_NIC &&
> +	    (decoded.inner_prot == LIBETH_RX_PT_INNER_TCP ||
> +	     decoded.inner_prot == LIBETH_RX_PT_INNER_UDP ||
> +	     decoded.inner_prot == LIBETH_RX_PT_INNER_ICMP)) {
> +		const struct ice_32b_rx_flex_desc_nic *desc;
> +		u16 csum;
> +
> +		desc = (struct ice_32b_rx_flex_desc_nic *)rx_desc;
> +		*ip_summed = CHECKSUM_COMPLETE;
> +		csum = (__force u16)desc->raw_csum;
> +		*cksum_meta = csum_unfold((__force __sum16)swab16(csum));
> +		return 0;
> +	}
> +
> +	/* check if HW has decoded the packet and checksum */
> +	if (!(rx_status0 & BIT(ICE_RX_FLEX_DESC_STATUS0_L3L4P_S)))
> +		goto checksum_none;
> +
> +	ipv4 = libeth_rx_pt_get_ip_ver(decoded) == LIBETH_RX_PT_OUTER_IPV4;
> +	if (ipv4 && (rx_status0 & (BIT(ICE_RX_FLEX_DESC_STATUS0_XSUM_EIPE_S))))
> +		goto checksum_none;
> +
> +	if (ipv4 && (rx_status0 & (BIT(ICE_RX_FLEX_DESC_STATUS0_XSUM_IPE_S))))
> +		goto checksum_none;
> +
> +	ipv6 = libeth_rx_pt_get_ip_ver(decoded) == LIBETH_RX_PT_OUTER_IPV6;
> +	if (ipv6 && (rx_status0 & (BIT(ICE_RX_FLEX_DESC_STATUS0_IPV6EXADD_S))))
> +		goto checksum_none;
> +
> +	/* check for L4 errors and handle packets that were not able to be
> +	 * checksummed due to arrival speed
> +	 */
> +	if (rx_status0 & BIT(ICE_RX_FLEX_DESC_STATUS0_XSUM_L4E_S))
> +		goto checksum_none;
> +
> +	/* check for outer UDP checksum error in tunneled packets */
> +	if ((rx_status1 & BIT(ICE_RX_FLEX_DESC_STATUS1_NAT_S)) &&
> +	    (rx_status0 & BIT(ICE_RX_FLEX_DESC_STATUS0_XSUM_EUDPE_S)))
> +		goto checksum_none;
> +
> +	/* If there is an outer header present that might contain a checksum
> +	 * we need to bump the checksum level by 1 to reflect the fact that
> +	 * we are indicating we validated the inner checksum.
> +	 */
> +	if (decoded.tunnel_type >= LIBETH_RX_PT_TUNNEL_IP_GRENAT)
> +		*cksum_meta = 1;
> +
> +	*ip_summed = CHECKSUM_UNNECESSARY;
> +	return 0;
> +
> +checksum_none:
> +	*ip_summed = CHECKSUM_NONE;
> +	*cksum_meta = 0;
> +
> +	return 0;
> +}
> +
>  /**
>   * ice_xdp_rx_vlan_tag - VLAN tag XDP hint handler
>   * @ctx: XDP buff pointer
> @@ -584,4 +665,5 @@ const struct xdp_metadata_ops ice_xdp_md_ops = {
>  	.xmo_rx_timestamp		= ice_xdp_rx_hw_ts,
>  	.xmo_rx_hash			= ice_xdp_rx_hash,
>  	.xmo_rx_vlan_tag		= ice_xdp_rx_vlan_tag,
> +	.xmo_rx_checksum		= ice_xdp_rx_checksum,
>  };
> 
> -- 
> 2.51.0
> 
> 

