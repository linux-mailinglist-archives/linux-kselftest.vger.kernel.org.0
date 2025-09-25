Return-Path: <linux-kselftest+bounces-42323-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 418DBB9F96D
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Sep 2025 15:33:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 39E204E3367
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Sep 2025 13:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2415E271479;
	Thu, 25 Sep 2025 13:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KgsjnI1g"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CCE1265CBB;
	Thu, 25 Sep 2025 13:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758807200; cv=fail; b=G4kbffflzzVSUszaxKJncAXtvEjb1CImWvX/CU8q5dpfcY3gEGg3Ta26FoA9N/WeN2yHLZmLijyapqQi9BnUlKfjTpWlheN3JXDSjrRkyE7WzyuRoS5XchXsCKiNtb0w0Q82XQYNIyoBUIDzIaHId115b+aMvsz4oUU2a7jEXOU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758807200; c=relaxed/simple;
	bh=kfYpdoUMusko5z8WIWhYokCNVhwIlvLAw/lt0jqIDEI=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ih4FfH3uxbZjdy3tJBxZmwA3J2pUa1laKT18hyT38pACMb4JH3bJOc6b7K6ImTOdK9c+NlN6PvO9LXUQxL0Q0dh9/VthExXBUZrsTg9QVLG0p+hrdv9LZu2rq+l9GnaViLvmSW7YOoGccFFe2yOoFlBY5g3sw8PxfFoYvTcNPwA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KgsjnI1g; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758807198; x=1790343198;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=kfYpdoUMusko5z8WIWhYokCNVhwIlvLAw/lt0jqIDEI=;
  b=KgsjnI1g0/vjTMqZlOgDVauz7nXT5Hj5KyDOqn50AJ77M3Rtaje+7U/N
   MLMxukoZ6SJ0GoRw2t+BQLcAdnkFCwR+r0XuG89N/SjrZ7pdBgBalmKB3
   mMI/7hSAxgge0Zzpma6yFSBjIC3VoM+K8dlFeTo5YK6XhSVncKhkdZCp4
   Aivq7CLFNznsPzeyvkRZLD5lkS5LuQsKAP4TF8IsqXqQ7nnjYk3MnnX/T
   H9o2GWZonDs1fAFYr1GnJvmX1/PV/+1GHUAlCFriqNO6q8N+flNnFjNIe
   rt+6bWgf9ovRBYEBK4F+5n7xYMfc0DcCbYfHAhKHf+ZeCTtqVMErZVAoz
   A==;
X-CSE-ConnectionGUID: 5Aeswf2oRz2fvwK0WwL9lw==
X-CSE-MsgGUID: /QBdqTpOTc6Uc+9C6d8auQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11563"; a="60823634"
X-IronPort-AV: E=Sophos;i="6.18,292,1751266800"; 
   d="scan'208";a="60823634"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2025 06:33:11 -0700
X-CSE-ConnectionGUID: GZXIeu7ZQqmbkkH0uNjq5Q==
X-CSE-MsgGUID: XkXjyTHLT2irQ1BcxalPdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,292,1751266800"; 
   d="scan'208";a="177173412"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2025 06:33:10 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 25 Sep 2025 06:33:10 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 25 Sep 2025 06:33:10 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.32) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 25 Sep 2025 06:33:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ajb3pSafAxbWHZviHk5TYkJSbrUwMoIbgmDIXRuL6RxUZSDXaaIVW7vmUgXPx+SPW384DUgcE1ikkCrUBENoo5WeEwIiHIIG0hEg88UgFJBttf/icr4YGjDJUsyjgU7kNNRWfxarpmAw+MQPsjIkLdOwbnqftC9rtjaWNd1EkCVRskv1Jk7jzXQPU/nifUy1qBSwohxeGEGTNtw6iXt1D3BQkkzo7AIbGkTB2YmezzORc1yqu4rmOnuiT/R1kuQ9D1T+EjiJWwXg7lXZ0gaRbOoXCCWZ5imlaHqaY782jNFW7ZzBWqCdnSr9Z0Rx+aQwqiZ+ZR4MafN+AWEwpDPYdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Qq26iVSSIBEF2IUqvDI4qJfGqyn8XYY3trEh/8s3IM=;
 b=C8ErAm3n0m3O8WgMaaJ3/S+eaZF0QzJNcsYruYHW9XdJ2QwZYFazeOU0N3NqLIDyizLrKVIGUrZm68cOi2awHlW+8qi8Uo4iJ5SBtQdqIRoVpT6liQmtohXMFtB8BqjXRU8nduub3Lkw56Zq0pVOYG64ctqtYVfuIEVtYU1SRilG60ELT6krLVW2v3n3Aqp72qxuDdbIW062HapLx/nQLrqnYcnGPK5Mn5GEWQNY2CVOqYPcsjZUq1KiVeXqRZ3eXAegUzcPexS11QAVMUoUZRiOFKn+ommTqZcZyOU71gjACmKztZdO+Feh/z5W6vZca5LLYQ9zkAdKtsvo9dgm/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 PH8PR11MB8064.namprd11.prod.outlook.com (2603:10b6:510:253::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.10; Thu, 25 Sep 2025 13:33:07 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%4]) with mapi id 15.20.9160.008; Thu, 25 Sep 2025
 13:33:07 +0000
Date: Thu, 25 Sep 2025 15:32:57 +0200
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
Subject: Re: [PATCH bpf-next v4 04/15] selftests/bpf: test_xsk: fix memory
 leak in testapp_stats_rx_dropped()
Message-ID: <aNVEiTJywHNJeEzL@boxer>
References: <20250924-xsk-v4-0-20e57537b876@bootlin.com>
 <20250924-xsk-v4-4-20e57537b876@bootlin.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250924-xsk-v4-4-20e57537b876@bootlin.com>
X-ClientProxiedBy: VI1PR0102CA0098.eurprd01.prod.exchangelabs.com
 (2603:10a6:803:15::39) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|PH8PR11MB8064:EE_
X-MS-Office365-Filtering-Correlation-Id: 25ed1044-b27d-4675-260e-08ddfc381004
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Mc6sIMBs1SUwL12v18R5Jh1izgQ+Y4rLst+7J8o0x6jFQ53iCmUZh7FygHc6?=
 =?us-ascii?Q?LVNMrgtQ6+vRSYwJr0YozKs3L27c11RljY320E7u6WwVAe7P4sC7H/tz1Eut?=
 =?us-ascii?Q?kVwH9p1MfWDsZx1KiJHTxQgLtyAKud/6u/vlo/BcqJK/FO3qRFp79AVSCsSC?=
 =?us-ascii?Q?FO+rF/GefH33w0SDrIbbSQTrsfsZw1qdI66+i0KbWgXutPpGp9aazoOS9otp?=
 =?us-ascii?Q?aQvEEhMToED1/reqKVfkuD2o0KTLL10mjZ9RYKVZ4NQ3ygbTUgzd7/htxa/s?=
 =?us-ascii?Q?O9n+D6pm8qfDDh08Bg7K8kBs0+5FtFGb8s0RPHICDArFpAgx0MYcvhom0YFf?=
 =?us-ascii?Q?A+DhCroG54QYgBBKSCpOGBEuup64FFghS60rPY+ZYAuqwqFiU/eWwvlswWfH?=
 =?us-ascii?Q?1dpE6wh3OFtBU0GV/bxzUk9+KYqnji48FIWuvf5iGLEvA6YOOK7cCDX7JGP1?=
 =?us-ascii?Q?KJ2+tX+JUaoe4mFE8W5Qc0pW7xq6cEY/Xi7vBp1U73CujZTYBwHVlyOi238C?=
 =?us-ascii?Q?XrHvGfgNugdl2uR9UI4nKo9AQ85qyJ+loq8XPF6Je9R2B8YxCnYKVoonUhtP?=
 =?us-ascii?Q?yRbxa7ozGcnvC9ZWVbxnmtrDmd+A/UETEnl7d5WNoVGrkltFBSuYGTnchm9o?=
 =?us-ascii?Q?r9BPIjBdF/J9DSZ6qo7Mex1pDxEJ6aOoC7NU0iTBW/LOVoNU84SWnalKIF7e?=
 =?us-ascii?Q?ld/WPfiD+YFKgfXAsT2IK16kzQaZ0w7GlzZfGvtrcnW7Ac2ielxaAra7gHBt?=
 =?us-ascii?Q?VSKWIp4ePBG4DGfZQNCbFz8GCnIPUCGisgL9SG+S0ugqRrZDf3L4MK4gKTSQ?=
 =?us-ascii?Q?g8f7PBsEl0Y4O425+1BnUGnmGWp8qO7DVVNwj68CS9tmePgUwrB/CAfPWh/J?=
 =?us-ascii?Q?uYmJnvdLpAXFnTuz5duev1wxQNeJPzPX+Me87wQOIRRRCwaLiXaNtbI+VUEK?=
 =?us-ascii?Q?2gIIGKHj5vUbtoHAtltZEqRbE4gBWdWvyehjD64hcDP2h8VhstiMJLO2f+XV?=
 =?us-ascii?Q?u9j3XV+c23q4uZTM5vC4/Eb2a8IAhC2XNBI924HRfAs7IEbYDn7yAumpWkRK?=
 =?us-ascii?Q?7ya7BEDPGyGkRuISNVNWM6oCODecXg6WN/gDo0+QO2oVoe9ioLARv6BKt5mu?=
 =?us-ascii?Q?B8H5+PHZ91kdtTV4/fzILQ18FS4Xe8LKa5zrCUerQUqQ91AppipE6nhDcyr7?=
 =?us-ascii?Q?GieHaQTEOh7H+7FJSXEia1gj6rRpla8tS0FAcqew0PPDC1YZzujsDVIpA6RM?=
 =?us-ascii?Q?GR1z5PUr2bUVDarTtUD4h5CuOccqZ+plQmZTJ/5Uqe7dkM/bht2LcbZ3o4Zx?=
 =?us-ascii?Q?V/nsMt0lY+643aweZfReFNlIfeYvdSdkqRo5miiOTwwTxlUEEQKytByA79qa?=
 =?us-ascii?Q?r9+R6Js9nAKbhpdgX1jAet5ZYJUlHBADUZRKYpMywjg0MVwDUOwpNlfPYF2W?=
 =?us-ascii?Q?wvGeiUHVZpM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4dMfRnN1W1pJFbKEQzZhIws+aBQ7tVB+n8fuR29/oJ5Mj14Ve/ZfedaTQPN/?=
 =?us-ascii?Q?rQ80yDPufse3pfz6vypayNubavb0PA4QOh48ZAOc3VqRnUwukausRvTTipxm?=
 =?us-ascii?Q?NWa8xji/vgbApuJyFL+SjbhYI3mxYzs0hLyuWKLXnfQCsrByvKxBEGDpdBFG?=
 =?us-ascii?Q?0E9cSuq/m+TN/hv8jM7wds0uLmUgqVKv3kAtFdAEUHUwyEnE17lKxqWaqwzR?=
 =?us-ascii?Q?fjfpHLxtF0pMUadnrF4W3ObjwoYFw9D0duRH564L+lISCl80M3pRWc2rKphu?=
 =?us-ascii?Q?jm/MEqgsvvhGZMwed1DTrsfq1jaDgzkp18Uhx+wtLdy4OOaFJSbtrKKtGuZ5?=
 =?us-ascii?Q?8y/BUAyyXMB8rObRJ/eTSr/ozsO9jqj79IspHHI1RT8yH5IJfuHeiOQW7Gdm?=
 =?us-ascii?Q?t50x4/wqx3GdoxWPF4YV0x8y+t16Hgqq0g3S/rKQ23IdsiqKmnRDJiEBwzo5?=
 =?us-ascii?Q?ti6Mi/e1jy7bWhnq8Pwoq0U7omC7DjAMZRZQmd9ivETypepZ+kNrfBtCP80W?=
 =?us-ascii?Q?b+zumtEH46adMp3veSToSXDqb5TpTqFWlj2+dFtGI84D6Lee8lnJPbDJ7qeU?=
 =?us-ascii?Q?4ofijrJj88r2nR/miVdgkYdFg78KGAXqBXOfl31VfeScVtZ/3aek1kYx6qO9?=
 =?us-ascii?Q?eiG3Ix4QG2NF/IxdgiPbHlTA63a5zSgcN5aVN7osSlH0ixzXjKtzEMZry0Fq?=
 =?us-ascii?Q?11nDRtwE0sbj7RqIhe2rMwLlUhOOMwXRfFNVPX3nDvinTTNz9RbymlxIREj3?=
 =?us-ascii?Q?3Znv+dedNDZcKEPoe5tFEoiddpp37sIVWXTapGSUjeKUA/ebOeT66J4+pGFH?=
 =?us-ascii?Q?k9k3/QrBm8ki83/KADEaZYgN+OEDXrqIkWVITbS/qexOQS5hqCO8fugsSeYA?=
 =?us-ascii?Q?DUKEbbUncS0t+uB+aUJA4rPaMcux1JLBbv9o+gp72RgvAxp7lcavwJ+hkYIX?=
 =?us-ascii?Q?dsFar4gMrQ3Po5iR03LZ1fP0i9GckfShcwk0zmnwAC4660kO0MMm/fk3yrED?=
 =?us-ascii?Q?wPO+Qjw4a8eo+Qvx86wA7LfU3xKden9mJH/qNTWSa6p8SAFFiH4uqtsluYqH?=
 =?us-ascii?Q?8GUu0Z6GsQbuzjwlPNAt1tw1H7fJKtR84xo04apyNF6YrxwR8egfTbNkn1/g?=
 =?us-ascii?Q?iHlHKUoeO7LPQfTLLn+HSyCxulqTAMBMzymwBbEzwcL8BiyZD5fKerYoVCXC?=
 =?us-ascii?Q?0Gd+tZ37aFN2fO/QzBEgBEYERgirgVDP5vr7ArwV4x1jHgaUeTSkYJNGCAQn?=
 =?us-ascii?Q?LyriirT0+GlF4an/NOKmgvWik0hmsaI9tC6QZGJrA4fS8dGG9ZvGuj4+fkiE?=
 =?us-ascii?Q?66576bZXbY+6V6zLqm7oUAEqhMdVudpovqe+yujUO2vtwNF3wVdDXZmUAVP/?=
 =?us-ascii?Q?x/B0+/QcmgFugBTi8/eoxvjaIc889QrjCGcUgn1uyst8wiqeKEGau5P0DsKC?=
 =?us-ascii?Q?0ts1/+DzMwk7grsN4ZCGW7q93Aw5gmZ7gLevBGipgnfei7DYQxW0GiqKUHam?=
 =?us-ascii?Q?5jQ2PVdNIw0WJJvM/zuLCDIfW/IBIF9BAojbrmtF0jMm5LxQpJfNG6mgGz9B?=
 =?us-ascii?Q?ngocY5p5Kf0bj+Km8H+cTrFw/CX6aq6ieqmnYxFlwziiITva8wLk23P2jCDI?=
 =?us-ascii?Q?TQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 25ed1044-b27d-4675-260e-08ddfc381004
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 13:33:07.6049
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bafCb/au6uYpsCj+xdklljQUMpCFjNlGt58T5ujOpkcnS25Id3mVdQsyo/nvdU8TN0Ld6+nmm9KuGG3eKgyXD3h8mWLWuc14/GAIymcczCw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB8064
X-OriginatorOrg: intel.com

On Wed, Sep 24, 2025 at 04:49:39PM +0200, Bastien Curutchet (eBPF Foundation) wrote:
> testapp_stats_rx_dropped() generates pkt_stream twice. The last
> generated is released by pkt_stream_restore_default() at the end of the
> test but we lose the pointer of the first pkt_stream.
> 
> Release the 'middle' pkt_stream when it's getting replaced to prevent
> memory leaks.
> 
> Signed-off-by: Bastien Curutchet (eBPF Foundation) <bastien.curutchet@bootlin.com>
> ---
>  tools/testing/selftests/bpf/test_xsk.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/tools/testing/selftests/bpf/test_xsk.c b/tools/testing/selftests/bpf/test_xsk.c
> index 8d7c38eb32ca3537cb019f120c3350ebd9f8c6bc..eb18288ea1e4aa1c9337d16333b7174ecaed0999 100644
> --- a/tools/testing/selftests/bpf/test_xsk.c
> +++ b/tools/testing/selftests/bpf/test_xsk.c
> @@ -536,6 +536,13 @@ static void pkt_stream_receive_half(struct test_spec *test)
>  	struct pkt_stream *pkt_stream = test->ifobj_tx->xsk->pkt_stream;
>  	u32 i;
>  
> +	if (test->ifobj_rx->xsk->pkt_stream != test->rx_pkt_stream_default)
> +		/* Packet stream has already been replaced so we have to release this one.
> +		 * The newly created one will be freed by the restore_default() at the
> +		 * end of the test
> +		 */
> +		pkt_stream_delete(test->ifobj_rx->xsk->pkt_stream);

I don't see why this one is not addressed within test case
(testapp_stats_rx_dropped()) and other fix is (testapp_xdp_shared_umem()).

Besides I have no further comments on this set, thanks!

> +
>  	test->ifobj_rx->xsk->pkt_stream = pkt_stream_generate(pkt_stream->nb_pkts,
>  							      pkt_stream->pkts[0].len);
>  	pkt_stream = test->ifobj_rx->xsk->pkt_stream;
> 
> -- 
> 2.51.0
> 

