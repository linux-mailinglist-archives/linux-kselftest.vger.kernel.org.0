Return-Path: <linux-kselftest+bounces-12634-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64BD69165B6
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jun 2024 13:05:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E39E51F20F01
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jun 2024 11:05:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB2AA14A624;
	Tue, 25 Jun 2024 11:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Zq7e4D0Q"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C237F1095B;
	Tue, 25 Jun 2024 11:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719313503; cv=fail; b=rpIXnkvqIOr0cXdzhF6U7/y4dZ5iOnd/wPcyUbDHVAvxyhLIpR5wmEZ1kod5UYu6Jp3xAayrIl9C8G+us6XHsDIP6ogKuR29hzvhZ/I5qKUGa1oD6MS0V7i95WCesKMMZVS+44a1kyzoBLmHn0jHCfl2qPQ7x/Ju6DxIN6Ld2s8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719313503; c=relaxed/simple;
	bh=55EZyhJojugOUSd5rophhaTExUHMS1HND0J9hF3Y2LM=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NYHv4OAj34skpWU/yXav7AM+S/xS1aUKcioIwDhFmQFk1+GcS1lY2wB070Qb/ucdsbZ5U+Zk7Z01FT7HpUWGD4/oqwkNavKK37uni34jYlNQ99mKTeMBbd2Sk9bQ5LPtNTO/Dr6fZFvG+0lNixHG/wr/D1KulZueKjnbFlXiJjc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Zq7e4D0Q; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719313502; x=1750849502;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=55EZyhJojugOUSd5rophhaTExUHMS1HND0J9hF3Y2LM=;
  b=Zq7e4D0Qq/QOUd3kki8PFgRQqjxtL2DRCPaCCzbv9YXUsfdhGcFbfNjr
   ovkpW/HSRl0upqNn5Oaa9Jo+5SHGat4Z1O+cf4eVFAMJ1Acprs/+O2TaQ
   KkM2ifwEkehHtaaXYMcgMgxFmFnT3X2y3n4y+G15Ft8CfAQvOhFkaA66+
   gHi7FfiX0bL4LyyuzfD4TMTQykMa4jxVF/8d51dwSiFiVo1k8i8mJDTjB
   RSIIR7Rld9oIspSYZB6e6WOCC8xm4inHXYY4uAonWwbkDcBb0i01WWYyH
   mUM46Sbmt5jkmpcyRFmyVx+G+47+KuR1WCawYxkQc5ewz29o7q1CXwQ+Y
   Q==;
X-CSE-ConnectionGUID: xCU833zUTEuXundGMqQ5Jw==
X-CSE-MsgGUID: DkRj7S3IRUeadQrw//qZUA==
X-IronPort-AV: E=McAfee;i="6700,10204,11113"; a="12236171"
X-IronPort-AV: E=Sophos;i="6.08,263,1712646000"; 
   d="scan'208";a="12236171"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2024 04:05:01 -0700
X-CSE-ConnectionGUID: M1fqusF6TJ6gQR0KdX3hmA==
X-CSE-MsgGUID: qsolqGzaSVyrAcpbsimJDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,263,1712646000"; 
   d="scan'208";a="48170373"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Jun 2024 04:05:01 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 25 Jun 2024 04:05:00 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 25 Jun 2024 04:05:00 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 25 Jun 2024 04:05:00 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.172)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 25 Jun 2024 04:05:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NA1jiGukwvRjVSZpyiCoL/ALcLj1/DonYsqZdf4D6F5uuogQRkq8L318ZK7tbLgFxa9mR2CbP6cBnYcyMYkTzPsvDT9hAD7o7+iJHU7+6D8iMspyq0nkanhEI7+4weDGZLkNU9quqg3d6AnMF/SURL1xL7TXJ0c2FAJjTSH8NLbsqiQGhLe9sJJMuhiJdmBEPyyuZOHkCxx01lCn3POPQ00imc8DT67Ub/3VVz6sTl3S/W/opMLSYwM/rh4ML9gV25jPNNXsZRrMYq2PyR0K4ueiBei2uRUA3rpM9CcHEYicp0aw2u8npX43amzfOJ7KtGi6Mnp5hj5oYfMlslWp/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S5+UMy1U9vtV0f1g0oqCvXHaQGDkj3yRb/PahpHxqVc=;
 b=NmlGyWiayMAJC7Lb/qJ+/2iWcNUIujgSN6wLmlenImGyyhb6AFkRo0e5jfq6M5n9hz0wlNRQiOFnFPTy3Lqk4pVna3WL2SHas7tmqbknpLt+AR6B/nZ/Xsbzmj312xP6s6oUCRkssT9BUB/gp2ZzBMC48grED8WEwJveZFWraYBV5dlEJT3xUyME7kdX9fAxJnFuz0GTxBCseBYbxD21WYulP13F3yg/OPcqXI5c12SeJg5lbkIz9G63In/Xddz0l2XLb4w+JOSW8Y2Ri2gLLa+nxDbVXNvC8W1hqbG/CbE7DJwtAVH/sViWT98IKIAGCS3qfyEbtGTUgHzWMHjjRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6231.namprd11.prod.outlook.com (2603:10b6:208:3c4::15)
 by CH0PR11MB5236.namprd11.prod.outlook.com (2603:10b6:610:e3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.30; Tue, 25 Jun
 2024 11:04:58 +0000
Received: from MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::a137:ffd0:97a3:1db4]) by MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::a137:ffd0:97a3:1db4%3]) with mapi id 15.20.7698.025; Tue, 25 Jun 2024
 11:04:58 +0000
Date: Tue, 25 Jun 2024 13:04:42 +0200
From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To: Reinette Chatre <reinette.chatre@intel.com>
CC: <fenghua.yu@intel.com>, <shuah@kernel.org>,
	<linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<ilpo.jarvinen@linux.intel.com>, <tony.luck@intel.com>
Subject: Re: [PATCH v2 1/2] selftests/resctrl: Adjust effective L3 cache size
 with SNC enabled
Message-ID: <n2el3evhluilmjhrwgpkkb7ld2g26zhmctxvm77b3ome6u6egf@hym7rnr3h2o7>
References: <cover.1715769576.git.maciej.wieczor-retman@intel.com>
 <fe9295c6be677d187b1607185e23993dbfe74761.1715769576.git.maciej.wieczor-retman@intel.com>
 <9fa47acf-86b1-4602-8790-39ed80fd775a@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9fa47acf-86b1-4602-8790-39ed80fd775a@intel.com>
X-ClientProxiedBy: DB9PR01CA0013.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:1d8::18) To MN0PR11MB6231.namprd11.prod.outlook.com
 (2603:10b6:208:3c4::15)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6231:EE_|CH0PR11MB5236:EE_
X-MS-Office365-Filtering-Correlation-Id: 19a050ca-909c-4e50-e88d-08dc9506a6eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|376011|1800799021|366013;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?4eMnvhmj0lqkg79uOkVBRKtpXF82D3wuJpy/kfD6zvhZFEo9aoYvKA66ZL?=
 =?iso-8859-1?Q?88ORZ1P1qTr/AkISLorbF2pqhO7VEx5wikHGzD+JwVnyexE7l4Yc7XGcBj?=
 =?iso-8859-1?Q?Kz1+AEnFgI8JrKKX0K28tKeliTaePdFIKZfZssyF9ycHky3BnVw86x1uQ+?=
 =?iso-8859-1?Q?+ZUwQs3FXRToSICehSbhOA5ehcGhzDtY8c1i0x0tjOOlBGNPHgImDEFh9j?=
 =?iso-8859-1?Q?pHcUMUTxE1S2JY5Q1gAIQeZt/f2QL2R+vb+ODoVuWdcHCP4pdEBdX6Mpv0?=
 =?iso-8859-1?Q?cIvcNKMgXCU2xE6OU/Wmhm5nCyQVJ4D/s1s8MxbTaptKPcJokUMpEZn69p?=
 =?iso-8859-1?Q?ribnX6kb2srusvNBDXlDK1H8WYKkT2F6qlJ1Gp1586A82Yurbp04irlmWp?=
 =?iso-8859-1?Q?BzcZerq0f/+oQNL6V5qlbMFDDlWh8juKPLf3vwKcimz+hr6wMHLEaiHyEo?=
 =?iso-8859-1?Q?igAZ9Gbeb1EAbL79V0/GccbCfPaSnyTRYO2UfYAOuoNIVWOjtkgtCbmK8Y?=
 =?iso-8859-1?Q?0dKw7RjAm7rYDMaHdj645v7Kg4WG4khANlWwxoNGthNqX6L5Wc/8yP1j3f?=
 =?iso-8859-1?Q?ooVlIHshAnSnR/dC0SPR2q3Hi0FyYfGRuLpfaRab0sq8LC/9SOzHcNuZon?=
 =?iso-8859-1?Q?tPiexDU9vOyeSwzF5pS01omoLMW+Li0BN+MoZfqLVT67Zic77o3sQklfJd?=
 =?iso-8859-1?Q?2njEmuegFLkMNZUdazU47ObaAAbVKs2pXy9xSM7kmR6hhsta/GVW66QOcs?=
 =?iso-8859-1?Q?noqUAXlTgP5NVgfjMPrpCJKuKLx5rH2n+Q4imd4WcltL6VTB0Eef+R/Qw6?=
 =?iso-8859-1?Q?QWXfv603XeMm8LOo2eQZdgo8OwGUvA5Mmg7shMbHLdEZrlGRCPjMyRxUtC?=
 =?iso-8859-1?Q?H4aJsRDQQnOiDY0qhY6X/v2v/4cVZPJ28tK/z+TkusN6vhiwh1RpLp/acK?=
 =?iso-8859-1?Q?kCLtGWTABaeXJoTZvaB6wpXTnpE+/2ozHHBoTtfi7jUDQGsJxFRVmIaG9p?=
 =?iso-8859-1?Q?4E6FlsYgm4S0dLKV/cWG0Bs+fG3g7MutmaWCL4o2Yo5JSFYgdf2MQooBHj?=
 =?iso-8859-1?Q?chuqubGaC265Ho67lJXwM3uKkGc9fazZO2kb4IMW8l1TPULlJ/wt3l0ZYz?=
 =?iso-8859-1?Q?hm8Ec1d4bkyWKhEg5Wmv1Rw0v9heTbjDAX9vFobDQZ9BoemOLaejbPlZDC?=
 =?iso-8859-1?Q?EsJ0UBeJFqHuYtP1VW0VDsYghQQAIlIGIrFDdnSdcycm5lpLgaG30h1oH5?=
 =?iso-8859-1?Q?XnM9ZWzphExKDHuvVLhxwY756lAGORk9pt6buSBU5AB3K7MZlTnAzmmtkf?=
 =?iso-8859-1?Q?f3w3dOrxaKtmnWZ2G4qSV7Vw1q68CRr7Poa/jMsi1j/fHoaQ4Ek6gzkdmD?=
 =?iso-8859-1?Q?JPC/5gan5EaivG10G7LhFTwbhUFz8kyQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6231.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(1800799021)(366013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?fGjred/OL3wrPZM5hneHk9m8QOGy+pBBZ6miy0oBFhYObZrbJzg77I7WB6?=
 =?iso-8859-1?Q?xuJykumVujb4x5VcEOK2hLQTEQUYfRGw+6oMy4rXL601AV7l18Ca5MH91y?=
 =?iso-8859-1?Q?AA3a3nk9JyrNEXa45dzCL0qkRNTGG6u3kdrk7kyazTAeU83yBhu9USehgt?=
 =?iso-8859-1?Q?0zejlYYH1XPEv2H0e+bsx3RggIh2y01EEeq7ne82u5FaIrcqKIvQPZbTaN?=
 =?iso-8859-1?Q?sijfVsOLzsWHrb4gfYeHSNTtwGFr/WHCpHfDP4EWXlNGO3BoWPlS0E6eYA?=
 =?iso-8859-1?Q?y1tjuUUuCL6D/n1Q6Xz25U71WECG28NFWmtc4nGJlUAOWE7bIkbDyo+jUb?=
 =?iso-8859-1?Q?y+hdS6ZkVPfwA2k/B/J21+cF+wBW1JMAcpJmwLhyxzO3hk3wmPpU2kbYsJ?=
 =?iso-8859-1?Q?WVyroYvK4mQ2GkV+bb57lMUyRkcS8HA3vI33Bjnh3SdV9asXTWNsqDEoAN?=
 =?iso-8859-1?Q?9cpllZJoMR43FWkQtYdU0KI+m8vPIOQf1qNRIiyeIa/qfLRC8Nf/DQrwGH?=
 =?iso-8859-1?Q?+L0xz9IcA+TRuNLlFqpdAEYAaCGfedJkSvZrt2XceiMkDTDyW6ZwjaUKVj?=
 =?iso-8859-1?Q?4bqfJKuvXRYQyqzpwZrMGalzoUiMfezho8bwpcGF/dFO1Rqz4Wx8Oygezy?=
 =?iso-8859-1?Q?BUKUmEZs5yry5BDI7HoeNeYdsPIPBK6sRWkE8xD0nPBn4Ttbgk7DiR3ye6?=
 =?iso-8859-1?Q?M37pQ5S2UoBGFZS8SrKDjz9zazML9l0uuAURBthfk7tznEEW2onKZ3e9M8?=
 =?iso-8859-1?Q?3WVnzIfP2wyymocMGtywYKWKKUcBguo6N9IXTu7R6K7ybFJcuLsjgx9gIy?=
 =?iso-8859-1?Q?DmzbqyvOHJ8fbxv692GW5vVdYeHZeiHCebN8nLnySAC5zfMFXgmctPv7l9?=
 =?iso-8859-1?Q?gbyXZV93jpKHLU6DaeRTaz7N7UWBSC4ZTn7+P5tAKnGkc0TJZamF2ZS9Uw?=
 =?iso-8859-1?Q?jC4gggeNTeGZXIGUl0QlHyvR/YNmPFI+WFu2104K/MyEWMqs2rl3btWHuw?=
 =?iso-8859-1?Q?/n4z+bbMvfg3ht9xLsSkLOPQSbJ2EMfKvLs6Jcsc4dilhoTacE7SNuSE8+?=
 =?iso-8859-1?Q?T1Mkhz0L5AeEevbva6h3kK0wM/QIrxY5HG0UtxclNcr8M+egvSzTObJ+oN?=
 =?iso-8859-1?Q?Grpin52EY6NkzR0vnd5viJyHvrKJfVsCxpPuyUmTZUAP0r4BoChetSFeCM?=
 =?iso-8859-1?Q?+FMZ7YJoZP52CDiqWsb1tgpcGQnJMfm9P8Ut3KXYS3nev4SPeJVzbcUimS?=
 =?iso-8859-1?Q?dowSz1zPLq8LQ877M41eNo2jU/Vhg2EJf72JknXbB+YxhddL74ejx/qzG2?=
 =?iso-8859-1?Q?IW+5YjKcq2//7IVnhxq6rlcS5SMDsuebv9hbij3N/0Ww8O41Q0lgbTOUKk?=
 =?iso-8859-1?Q?SCk+Fo1mHVPN1h1pao0Bs0WTZWuqd9z93NGdvkb6gqyUyesRYlxPbFuOUj?=
 =?iso-8859-1?Q?Cz5Cr09/RRz8/UDfV4kT52DrM9G9tDa/25o98UHxj/RBlsVL0iko6a+RaA?=
 =?iso-8859-1?Q?chN7TqxO9kh9S25JzXOBJoczK79+u/3eMAycql5gX56N47kOnrYPSpCCk3?=
 =?iso-8859-1?Q?kLkE68UssSW1wdTlM/JTdqh9dOwrhV0v1IyBKyJC0OdP18CiCzxysFD/dg?=
 =?iso-8859-1?Q?kvnO6KxsC/xXfVAFdAtOgIwvvqKpijLaWLBbSEDBa563KDFrJ9bNyE/aqw?=
 =?iso-8859-1?Q?db6jeqG6rjGr6ZRPtOM=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 19a050ca-909c-4e50-e88d-08dc9506a6eb
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6231.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2024 11:04:58.5588
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BlCJtLFigDwWGAEF1PZD5uASAHAZC/5HyWgXU2aYQEijf4OTyuxySq7td5EkxDKbkLJ8qgkG/Z8ztmhn0YYgYX8ALESPp9rbiB+EVFIQyew=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5236
X-OriginatorOrg: intel.com

Hello,
sorry it took me so long to get back to this. I prepared the next version with
your comments applied and Tony's replies taken into account.

I wanted to briefly discuss this before posting:

On 2024-05-30 at 16:07:29 -0700, Reinette Chatre wrote:
>On 5/15/24 4:18 AM, Maciej Wieczor-Retman wrote:
>> +		return 1;
>> +	}
>> +
>> +	for (i = 1; i <= MAX_SNC ; i++) {
>> +		if (i * node_cpus >= cache_cpus)
>> +			return i;
>> +	}
>
>This is not obvious to me. From the function comments this seems to address the
>scenarios when CPUs from other nodes are offline. It is not clear to me how
>this loop addresses this. For example, let's say there are four SNC nodes
>associated with a cache and only the node0 CPUs are online. The above would
>detect this as "1", not "4", if I read this right?
>
>I wonder if it may not be easier to just follow what the kernel does
>(in the new version).
>User space can learn the number of online and present CPUs from
>/sys/devices/system/cpu/online and /sys/devices/system/cpu/present
>respectively. A simple string compare of the contents can be used to
>determine if they are identical and a warning can be printed if they are not.
>With a warning when accurate detection cannot be done the simple
>check will do.
>
>Could you please add an informational message indicating how many SNC nodes
>were indeed detected?

Should the information "how many SNC nodes are detected?" get printed every time
(by which I mean at the end of CMT and MBM tests) or only when we get the error
"SNC enabled but kernel doesn't support it" happens? Of course in the first case
if there is only 1 node detected nothing would be printed to avoid noise.

-- 
Kind regards
Maciej Wieczór-Retman

