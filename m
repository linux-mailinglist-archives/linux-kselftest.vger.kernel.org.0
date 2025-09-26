Return-Path: <linux-kselftest+bounces-42462-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E7B35BA388B
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Sep 2025 13:48:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F8753BD5C7
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Sep 2025 11:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAE312EAD18;
	Fri, 26 Sep 2025 11:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U2JCnOYd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB8E72EAB6E;
	Fri, 26 Sep 2025 11:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758887274; cv=fail; b=Vv/+moH0CMUHxJ9D8Z60PosYAF1zGkbvGF6hNPoT9toDK4oEWPqujevL2X+XQR2UYddSdBNkim+mCdzd30/N5KcFzg39EtTa+6QRKcVgthUgS63Ns4A9GECnexwotAT8yvESncRRWXA47xpUL0wlqUfHx7aqLejwexsChgUs38E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758887274; c=relaxed/simple;
	bh=9Ozcp4e9g87uyCyPrrLbikNRUCQaIA383lNBYJYMlZ8=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OSdicXoRBlZoxmjQkAdisWfoziWdpyTgEaAAZ1FvvPdIOUzvsNwBcAwvSJHJlyJSFI+ZQPlwm9BP0K+FRcXap9i17fzc1UBLNCkUDJnIa9cHGUDoA7mSUgx65yitGQ7XC/w+mV2PKiuuGJq99u5ShMwaCzSYtLa0/QjudS72/dY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U2JCnOYd; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758887273; x=1790423273;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=9Ozcp4e9g87uyCyPrrLbikNRUCQaIA383lNBYJYMlZ8=;
  b=U2JCnOYdLDJqaPYv986RfHmNZLWGlOaXj611vqomufO36nlZ3SOsKpJU
   hkDbOhdcaXx9fydHjVOkvq/yYyjqe9SDqoJeiSn1irOM8NKAjOxew9p+H
   +vgLMaghyhbIi024UP83i7cTBJNNNdGnPq9YR4FCMrjrgfuq9sCiGz5HE
   X5HE+jF8RQFHdRPiSznNiiFZO2cct038FLKGg1vzQUDANhAZ6U7hk0WsC
   NwzJygJvATsmFi+F28wVd+w9DBdqkQ0xjxvNYbuWw3AdaDJrpOfxkzUmJ
   Te3X0xdSHOo5QF/jMIl57rlM1fztQOdsAfH6xGQPksW9LqBwx0G0bdXYY
   g==;
X-CSE-ConnectionGUID: vI5SwA+eSviJeO/0TJd4kw==
X-CSE-MsgGUID: t9h0sHQ2QHmr5iMhLjr4/w==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="61271745"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="61271745"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2025 04:47:52 -0700
X-CSE-ConnectionGUID: ByEgb0EXRdmsocpeND/yww==
X-CSE-MsgGUID: h3rxgXCYSD+TNX2sDXv+6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,295,1751266800"; 
   d="scan'208";a="181900897"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2025 04:47:52 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 26 Sep 2025 04:47:50 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Fri, 26 Sep 2025 04:47:49 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.59) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 26 Sep 2025 04:47:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kyoGWZEZdabYMLFGbkjALV5ouFnPJa4+UtpDXs6gIpl7u1VfdnhH4m0H1BgTG8oxDpoNmrdG19UeOHGwP8yr6xyThBAxt6CfmK6SV9tJoBjnAHeoRTCvi14xgfRbI+Zhoytn2diYQ85+8IQsZtAv8dAHp2hHtqjJIZHKIqPSSGwCvhnAzs5TBSfXH5f5bzla8YwPbLoDrz0OVZnl5t3Yp/2EY1nAEVmjiZH5cLXUgB2ynU5x8KlF1xMEphi2w776YxFEVmZOtY8dPUOMc5ulsEfgJXFgr3u1wAlNi+PdDJoFmvMriTIQ1u+smZoIh6iz5K5QS33ZTT9mnJwKx4Ee+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=muoXoAYCXZbmEK3CwpadRLuv10m6IcMoDX08LhFU+gM=;
 b=X67mLrKqAXOzH0OoYo7mP2QA4uTM47P2UyBE+Ca/5y7iQGISjWAuHBQV7SgMSRPTvhWPHrtfEZ9LRNgs9K3uer7Y5zxowIMOQqdmWGlbEwKSTvLOEv4ekn1RtX7gB4b73XR2yDnzbm15sJwV3usAY6SLiVbrnIPqh4y9bNxJKNvhgs4GVYy/K5A2/StVNWgKmjU1VdH85BB/MvzxIynijCnH6QinKioufbRTxwWwLtk+jDU0KG4SdZuy2qW8xtMx2i6S1HZm+TXpeUAlhmZZl0kskN1Ra8JMe5VaLygepzTmm3Sbc41SHtS9IX55P60KoX7Vc9ConJWAV6xwAHFSzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 IA1PR11MB7725.namprd11.prod.outlook.com (2603:10b6:208:3fd::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.10; Fri, 26 Sep
 2025 11:47:46 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%4]) with mapi id 15.20.9160.008; Fri, 26 Sep 2025
 11:47:46 +0000
Date: Fri, 26 Sep 2025 13:47:33 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Bastien Curutchet <bastien.curutchet@bootlin.com>
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
Message-ID: <aNZ9VWLgNGHQg1Tv@boxer>
References: <20250924-xsk-v4-0-20e57537b876@bootlin.com>
 <20250924-xsk-v4-4-20e57537b876@bootlin.com>
 <aNVEiTJywHNJeEzL@boxer>
 <fd600cd5-062e-4806-9e8e-b7f6aacad242@bootlin.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <fd600cd5-062e-4806-9e8e-b7f6aacad242@bootlin.com>
X-ClientProxiedBy: WA2P291CA0047.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::16) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|IA1PR11MB7725:EE_
X-MS-Office365-Filtering-Correlation-Id: 0cba3c49-b048-44bc-7efd-08ddfcf282e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?jkKQLLIZV0MzYZYjRMwQi1aBaMBEQVmQnSGUlcXLgSizu4FROyrqzQ9cW3b1?=
 =?us-ascii?Q?4iBAoFihLS8tH0jax2Ryi2kXnmGLa6smieOJQ4rXC8CFxQJzRd/b3qHgNlD0?=
 =?us-ascii?Q?5oAwk/z/iUICmfcz1mlkXz/VsnDt0AwoG5siM+rmIKQ4DediKLxW7T7EHOcU?=
 =?us-ascii?Q?03Ydhi5K2H8qmhHJgixUKgGn39jXdIR1XTe1T6K0iZ+zO1PdX2V5r64jJNYc?=
 =?us-ascii?Q?iQ8CR7cqNAR+K9gf7H7ZLuhyFpv81X9cai9Uv7FdAaW99tBxovK46o4KZ5ng?=
 =?us-ascii?Q?CcJxTicSwIbKVWOmRYq+2wIL3ZWzZszxIdi3EJoLN0uWdVZvmskg2l8aoWd1?=
 =?us-ascii?Q?y1P90NxcuyLP8+Ofoh2uZEwOsgYmSAgMx4y0RjoTYEm+EJWIA09JEMfj/VXn?=
 =?us-ascii?Q?ZW31hYjzEj2VpDktTAltC8kJlkM/A/tD3Q0qvfP352AHmyIUV1wRf282nDfn?=
 =?us-ascii?Q?acpysXTBWszhTnRQiF/iWxdscITlFyEZss4mpyo6yZDU+uZaZCXDoZue6+LM?=
 =?us-ascii?Q?RICjbLID6il2PEc0Xy0tkvNeeX7SUv1DXZdALBAoPRbsA15oQek0SvJD1qsp?=
 =?us-ascii?Q?OMChGslv6tXaLAelHqE0JeEFVvvjC06GRRF0u0YW5fd2+IVaN3GXvRHRRNOL?=
 =?us-ascii?Q?iup4OuyVuTlVbnM+KgptKhuH+z6cCniRYkpJ1zTNnOlL35CZvyv7J75AW+Px?=
 =?us-ascii?Q?1a+bqNN8AjcUvxQ2YGMexJX6tm84zRBwvH0uzYapd7V5eBSdxJyGImQxuHVD?=
 =?us-ascii?Q?yJ8P8xnY12T1P9y3xDswweKDG7MY1jLQRFG9CFTlxCQTl/5bdc83/axjB/tu?=
 =?us-ascii?Q?k1YMzDV4WArGJL6yJUpA1ZbO77pTu/+qZ4W0zBM9E+kDwpgo2YFYC19//+2J?=
 =?us-ascii?Q?W/jd8m4QUxbNn+0/eMZGDEpoSs9FTZ/TTvec+CU+hzl0X1tXt+zyBy/+QFjL?=
 =?us-ascii?Q?LYpjbAW/GKCigYavvEYy5HBz/C70XapwveLz15aAbRMySskKaCCj7F3bz1U/?=
 =?us-ascii?Q?vK8EV8uHUG+1g8M9f7Ple70pRH1YQ5zxQTJhEj4bGcjyFLbzY3FSBPU2GmSR?=
 =?us-ascii?Q?dMQUSShN/TF8YMmq3cWwVAHbn+Uj9Ffr142xTq2IAn9AtJFhTOnv2dBTUJZq?=
 =?us-ascii?Q?1WZ3com9WXJNDQdYH710rhVUaki5JahQ+sY2nu9LQ6e6FZsYdoq1sATnAEYJ?=
 =?us-ascii?Q?n8PE1yXJy2vEWyWtuIS1mrbN+WxVhlVPEEWvZMGLFhXUOZUqimZc5wiogjfY?=
 =?us-ascii?Q?+CyK1YvALpZqys5Xoge1EogMxkGYk8maqi3NoXvUYGvYfSW30FVNRDukU6fX?=
 =?us-ascii?Q?FKSppAcl13EsRZKzxy/J0PvcT929BHmOd7SHJbELkQ8874ILiIxT8viLIBCV?=
 =?us-ascii?Q?UrZ5MKz7aPMl4MrMay3KhHxCIhJ0Rksrsf04S9+VGBnzPaxmSA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xktrEyK09XLtIRgHN5kq22mO+Zs0YPC3I10pjjpTV3rcvS7hvj+WtECUsCiJ?=
 =?us-ascii?Q?ZQXuNwJYGS/omS69RPKUHIYPXrydWRmCiLm9e4o9GiD0ULq3x2oeOLeUAG2P?=
 =?us-ascii?Q?iVQ8bx+Vjw//I29WdIXLfvqN/KbZzfzTOkeWM2CZkjH61O9EhL7kAmY2l0te?=
 =?us-ascii?Q?gVAlJWVC0Xj0eREe1LMyipgvnFJF9YYGXM8dOVhbzRXDgHAPsEPC+SXtBIoN?=
 =?us-ascii?Q?XpwoaWy1hC9tTWDq8ce8DnEofdrjd6i47lejTsk1feBJUsv2Mr6VVe5Ar6w5?=
 =?us-ascii?Q?e/CYHW+8CbwL31At1vubDTpod+jo6c2vP/FnNUAbKV9Bh17ImpwSyDoAEBDy?=
 =?us-ascii?Q?u3c0EBmwfqpDz1odAO8ntOYdSv6/aFYsc5j2XumHY7pa1OQq8hnIWl3WuXfd?=
 =?us-ascii?Q?VnuOoMTpTEkZbeXrengDeCXno7IjBZ+urI9Ff1agiUQfcXMUWR7VDoRGv6D9?=
 =?us-ascii?Q?SJkvzrOlfn0FeBU+9mgBHiYTCO2+tJiXTGiFbF1S1KmXW5Hjg48K/9FvWLBT?=
 =?us-ascii?Q?ZqR1W5D6VUMf309/l76+c1mmkHXFuujml7GvrK0DOdYKWOhbgchh7npRqWj4?=
 =?us-ascii?Q?bgwEFXWkadpoClmH9QKQVJhiXRguALpDK5dLelb7f4CMz11oZbjzO3ecJnIP?=
 =?us-ascii?Q?RbLgs2ZucOkeyDC0hpXuKC53Vmo9vOUA4CorAsH2p+Nap5eemhrpxmqFYGR0?=
 =?us-ascii?Q?CqpTb4ovXm+KR318WzLeyzBfm7Q5idjvp3Thchf+fDOO9Lw1dXBHiljDWTEZ?=
 =?us-ascii?Q?Mi5E6fEJansXzHhi4PlL/W68L2+2VscLPBFUjBL0qKmo+Ou5C0BRnmPuQiH+?=
 =?us-ascii?Q?CnU/Mg1nw0p2upddgrdExL4s0GWwGGwD0iDWUaunQHbgcSt6gKw4Px3GcVH0?=
 =?us-ascii?Q?icFHH8XdlcL6UzVPKdtgZ4eMCHKizx2HVHczs8SfRn403sm0Wl+xtH48PpqW?=
 =?us-ascii?Q?/EyiG84fq0Vx/+3q71Wt4oF8SN+QwDYtjPOPmtO0rmJS60r81DO28fWw2aZ1?=
 =?us-ascii?Q?TAXqxXy/kJdIvOPdE2xhsnXVAfb5BcYoePhYGnXU90nl2OXN6/JBkjeARD1l?=
 =?us-ascii?Q?amv++HrrdGqblkhLBa/DVGg+KxZ3KVdaxnI9GbeakKE71E5eE8n5sXp63mxh?=
 =?us-ascii?Q?UM1EfhqWvAGvhHkDqWeI6A9mJsORiA+XxvGvqXERftggNq4iEiRMKybXeFg9?=
 =?us-ascii?Q?1UNys8GY9diH/OsBRTTCh8ff1cMUtHsQJFaVk8ygcXO9YJK2ryh44HmFzGiA?=
 =?us-ascii?Q?ET03+HdEa/rYsZTcmvnqjnAxLqtaG5k4q0hzRNm1/oET+LFjZtWAMPdv3CGK?=
 =?us-ascii?Q?7y6XUZolXTQy96MDiTXS3tvyz58u8CM5JJMxvqRizYCRBNC6Wfb+LPqTdX5f?=
 =?us-ascii?Q?okL6121SFn4L7F0KJkB+OZ01sVcszPpha4pud8IM2cyfIJbE/gAOMWIOqe9e?=
 =?us-ascii?Q?1RipvKrMsvoWb89WTZYLtU2Ixe2IwrUBQ53kKI+56gEhCh8a2hPGJ796O1iA?=
 =?us-ascii?Q?eexynAvcr7nuhhNEz/YFlyiRCe5m99clY1JLL0g85HG2xbgJoSeJcsAAlR19?=
 =?us-ascii?Q?LAL3QgLoZ3xkBLgbFHSE0qhEjteG6WBMYA/UZXHyAcV05z4OACB/QF2KfBJO?=
 =?us-ascii?Q?rQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cba3c49-b048-44bc-7efd-08ddfcf282e2
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2025 11:47:46.6385
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oLZ4MBCcxXUnds1w6H2YMI3cEXcxtNhLEXhx3HCXPB1xqyhU/Betbs2/G/rwLbyHhTryhRZWkilelazER2S4DChSmzN/SCPy+7AJ1AY/gKA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7725
X-OriginatorOrg: intel.com

On Fri, Sep 26, 2025 at 08:39:28AM +0200, Bastien Curutchet wrote:
> Hi Maciej,
> 
> On 9/25/25 3:32 PM, Maciej Fijalkowski wrote:
> > On Wed, Sep 24, 2025 at 04:49:39PM +0200, Bastien Curutchet (eBPF Foundation) wrote:
> > > testapp_stats_rx_dropped() generates pkt_stream twice. The last
> > > generated is released by pkt_stream_restore_default() at the end of the
> > > test but we lose the pointer of the first pkt_stream.
> > > 
> > > Release the 'middle' pkt_stream when it's getting replaced to prevent
> > > memory leaks.
> > > 
> > > Signed-off-by: Bastien Curutchet (eBPF Foundation) <bastien.curutchet@bootlin.com>
> > > ---
> > >   tools/testing/selftests/bpf/test_xsk.c | 7 +++++++
> > >   1 file changed, 7 insertions(+)
> > > 
> > > diff --git a/tools/testing/selftests/bpf/test_xsk.c b/tools/testing/selftests/bpf/test_xsk.c
> > > index 8d7c38eb32ca3537cb019f120c3350ebd9f8c6bc..eb18288ea1e4aa1c9337d16333b7174ecaed0999 100644
> > > --- a/tools/testing/selftests/bpf/test_xsk.c
> > > +++ b/tools/testing/selftests/bpf/test_xsk.c
> > > @@ -536,6 +536,13 @@ static void pkt_stream_receive_half(struct test_spec *test)
> > >   	struct pkt_stream *pkt_stream = test->ifobj_tx->xsk->pkt_stream;
> > >   	u32 i;
> > > +	if (test->ifobj_rx->xsk->pkt_stream != test->rx_pkt_stream_default)
> > > +		/* Packet stream has already been replaced so we have to release this one.
> > > +		 * The newly created one will be freed by the restore_default() at the
> > > +		 * end of the test
> > > +		 */
> > > +		pkt_stream_delete(test->ifobj_rx->xsk->pkt_stream);
> > 
> > I don't see why this one is not addressed within test case
> > (testapp_stats_rx_dropped()) and other fix is (testapp_xdp_shared_umem()).
> > 
> 
> pkt_stream_receive_half() can be used by other tests. I thought it would be

So is pkt_stream_replace_half() and other routines that eventually call
pkt_stream_generate() and overwrite the pkt_stream, right?

It just feels odd to have a special treatment in one function and other
are left as-is just because currently we don't have another abusive test
case.

Maybe it's enough of bike-shedding here, just wanted to clarify on my POV.

In the end don't get me wrong here, this interface is a bit PITA for me
and thanks for whole effort!

> more convenient for people writing testapp_*() functions if they didn't have
> to worry about releasing these kind of pointer themselves.
> 
> The same approach can't be used in testapp_xdp_shared_umem(), because we
> need to wait for the test to complete before releasing the pointers.
> 
> 
> -- 
> Bastien Curutchet, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
> 

