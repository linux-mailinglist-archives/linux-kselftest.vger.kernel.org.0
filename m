Return-Path: <linux-kselftest+bounces-9003-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DCF68B5182
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Apr 2024 08:33:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8A7B2812AA
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Apr 2024 06:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D58E6FCB;
	Mon, 29 Apr 2024 06:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P69xiAwX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C26FB11C85;
	Mon, 29 Apr 2024 06:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714372335; cv=fail; b=SmK1pZluRjYLR2wIHIKM7zx2ADhNybosv0nz5I0q9VJgRH6zexs8J6X3bbBRT4Lx4l+pMSH7ciWbaV/HBNTA3jOI+g65DbwfM/B5FLlZKcGB+SWjkIW3BsePSSNaotE7Rws9LJCIgxkUpA3MmTzFbbsLuLxnFxnA7w/xgmbHbzs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714372335; c=relaxed/simple;
	bh=wrOHosYx5rIaFP4Nm3t9DJE9pkxJD3tO9j8gvwA+DzM=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Xg0wXVeH9l87TK6Q/OfocWH9ZMYJE5Eqf0JbMeOI2tNQarbvKFedmFd2lmybymO4ad6QSPis/j2j8QWoXBHLhf0Iy9vlH/IvIuILfD8uw2ptJG+INwSXNHvW6kDEmHhrduUpiUXrIGhgfaBXttdt7kdDwmx6TauLf+bTCHfJSpA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P69xiAwX; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714372334; x=1745908334;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=wrOHosYx5rIaFP4Nm3t9DJE9pkxJD3tO9j8gvwA+DzM=;
  b=P69xiAwXHrbfObzoxo0ypC4XRvybU+E49A70TxDLioX7pl1lESkz6Hcx
   dhAzv/DhK5tK5l+4m98004qwuD1zJ9klMHf29L+lJF3iQZnRDTtkWcl9A
   4Z9L+HRbzjyxu1V+GbaSKrIB3iDPQY9XJhoaCbjRymiNZYSHrb8eHfOwX
   UrVH5EqUtDaVfpm0koJZijjEeO3YOwtO6tP1hvmd7lDobvs86lFdVB9Yt
   Q2n92HM+jBXaQLRp7BuTktZ/Xg4Vx1ggfnaGaDNcYhVFP2ShFSqxIp+2X
   tuWqMzZIURJjGKc0LZdQ0ZibtHqre7BU5kLjIdsAbSnexHsqiahs9EBUk
   A==;
X-CSE-ConnectionGUID: JUM+0bobSQigVVbZsPSAZg==
X-CSE-MsgGUID: jRMuvjAgSVmEX94EeRZtLA==
X-IronPort-AV: E=McAfee;i="6600,9927,11057"; a="35413603"
X-IronPort-AV: E=Sophos;i="6.07,238,1708416000"; 
   d="scan'208";a="35413603"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2024 23:32:11 -0700
X-CSE-ConnectionGUID: qaIzAEx/RAehsRcPFROUbQ==
X-CSE-MsgGUID: UprZxY5PQMiLtP2AGwINww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,238,1708416000"; 
   d="scan'208";a="26001364"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Apr 2024 23:32:10 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 28 Apr 2024 23:32:10 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sun, 28 Apr 2024 23:32:10 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sun, 28 Apr 2024 23:32:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zor/eJZpxx+JRybLRg5RT8ykyalrxZbTp7mPYkbyDDq7MGVM0n0kHrKg8vU7Xn069eH2gsfQCaRSH4GSXo/uTs1BzRAsr6bUnb1gxWGEh3b6sYDvK61T6/T824FZwC6PtaNK2spH/eTG57L7KQmeyWm8cxfIPVrZMz6CzhdZcBJIKae9zHUfkPzF9VaErQtpELirIpvzQD+SPdVJl9KlwwzKHixkxe3iy+jkLQQK4mDqKBXe9YIl8ahVr0zim1HQ0+cdCmeXjIrC1uo5BjrHkVxf3NNMCU1N6PjaOCcEfIc6RhhZxn2IhmYWNnOm2NgPN54migAOLsuiH3cTcWFZbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LfrfebsiW9cQVBkfJiafNyxKm3uY9SDb8qWju3ci5xE=;
 b=mAFFrzbOGMW7NG4yVcYwXYSwvVtg1oT/s24VqrMPLWMYIfSoCq31vnyVFfFTQWpzWHA1wF6CpxEujIuG2WLdlhlcOYk1+/GcBsngI2xwMUmKCYGb91H7ek/pBvfA1fPECvbqjqQVOBMoN6nz0IL0R4GZUT1vW4gv7VUdWEq+bthDBXD9JJpwZVp8kcPdRJujCb2uZ09gOu8wqal6y8WxJyDxmSa25jhKJ8xZ4TKbgoEz60HoQ+oZyBZxdsIBVScq5J1JGwx+JsvsgFhzAtSwqsN6+gycCobLX4RIlWa2TwKSlLD06Q4FaQYXhBTLoZNUE/TVzMJQ1dswffdNoyDiKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB8660.namprd11.prod.outlook.com (2603:10b6:610:1ce::13)
 by SA2PR11MB5036.namprd11.prod.outlook.com (2603:10b6:806:114::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Mon, 29 Apr
 2024 06:32:03 +0000
Received: from CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::5135:2255:52ba:c64e]) by CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::5135:2255:52ba:c64e%4]) with mapi id 15.20.7519.031; Mon, 29 Apr 2024
 06:32:03 +0000
Date: Mon, 29 Apr 2024 14:31:51 +0800
From: Chao Gao <chao.gao@intel.com>
To: Xin Li <xin3.li@intel.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "seanjc@google.com" <seanjc@google.com>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "corbet@lwn.net"
	<corbet@lwn.net>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>, "shuah@kernel.org"
	<shuah@kernel.org>, "vkuznets@redhat.com" <vkuznets@redhat.com>,
	"peterz@infradead.org" <peterz@infradead.org>, "Shankar, Ravi V"
	<ravi.v.shankar@intel.com>, "xin@zytor.com" <xin@zytor.com>
Subject: Re: [PATCH v2 10/25] KVM: VMX: Add support for FRED context
 save/restore
Message-ID: <Zi8+1wpOWAXDABbm@chao-email>
References: <20240207172646.3981-1-xin3.li@intel.com>
 <20240207172646.3981-11-xin3.li@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240207172646.3981-11-xin3.li@intel.com>
X-ClientProxiedBy: SGAP274CA0023.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::35)
 To CH3PR11MB8660.namprd11.prod.outlook.com (2603:10b6:610:1ce::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB8660:EE_|SA2PR11MB5036:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a99fa9b-f4d7-448a-9e0b-08dc681614d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|7416005|1800799015;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?DhzgDeZzwETijEcvJqOVxLjvLXpU1Dz6YAlQRRYLSGAL/FdykXTRIM2OsEol?=
 =?us-ascii?Q?kn1qp7jy5uQEIueDismLUsLkzFvNDkvPqlEQRyFqBsCnZNT60EL4jBSAfwbo?=
 =?us-ascii?Q?HvVmk9ZVOfHiskZ5iPB1XmHQkL219dpGChE8eoy5MEjysTh1rN3cH2b85wnm?=
 =?us-ascii?Q?27b+JzzhnboAVVL97+8ApCeuUAOP2BACLJ2r3vQzqqz8fYd8wiDfxdiD1hwM?=
 =?us-ascii?Q?U2ctadqTMnpVe53Jwijm5DLrj+/Tnzad8bEvrqr1QLcXTcSWHZkiJv3CbyyF?=
 =?us-ascii?Q?mT3CZgo2xKTTGDbDeqY9eJDHB4mIID6EeDKMbF1bc0V9wvcK9mW/+08IdTai?=
 =?us-ascii?Q?eB1WH2GB8N9S/rHl5XjDKXMRn/q6fVwhCbSVLXfApQ/5QsZhWFF9BOck4xk6?=
 =?us-ascii?Q?CBoP9JGKxYzm5cZI1f5k/rW2tASzjR9As+bhGvesuxMu3XuLxHE1xlJvVoUc?=
 =?us-ascii?Q?RsZtfCDVRzfxqGuuvmZElzfRh/kqmTPYu0HIVsJcZ3oF+oMJl4hTd9/eUexk?=
 =?us-ascii?Q?+mBJhXUExIqMx6chikTNjDauEi6jFs8gzmNKV7z80oJ20f89MmXyMwwdpKP+?=
 =?us-ascii?Q?2LMEb4hZ0Xd+Gag3caoTACYo2Kuwlyf3BRnbGBZ8FwmdX4rPW8IOjmxpVaeH?=
 =?us-ascii?Q?+v5TxM29DHkFYzbNE4AWPnYF6NW3qGa1WzIV9KA5ouJvId7N0nRicu0xcq5j?=
 =?us-ascii?Q?ZM317ilKWsNxO2v8WKs8rqerSofejqJ4KT9Iebs5tiBfspsLJjY5e96BBbWL?=
 =?us-ascii?Q?j0Nd7gPfAFq9sP1W5Mrr75vKWMRyT/kRInSV3OUI9G67lecotFhNHgo9oLsq?=
 =?us-ascii?Q?IKwHCM2jZLasRzxvNkmScf9TDAEDjhz3994jydTMgxST9jrOS5UTVARMlqG3?=
 =?us-ascii?Q?QRqMzygRI3U49bzciZpFF+JBQU9TaQEwBelB5wPx8ry09KtykU42lrXlgvUJ?=
 =?us-ascii?Q?hWBgSEPX4dCjBc6qTR2OrzPL9Jlmpt2PhQ/rSt7do5Rg6qeUXfvM8QXh6l56?=
 =?us-ascii?Q?xuKtsgdONIAOaaPv9wkyYMzyA1RA2rg7oiENB7f2SyE2ra8lcszhjfvZSWQ0?=
 =?us-ascii?Q?qXUJmdYLIwxpMRte+R5yg5onlkxQFyFYo52cXzTqCASjSqT3ARUWjE8/aXKc?=
 =?us-ascii?Q?cdio3LdFYcDQRoPFgNFunSjTWLfqm5ShouuAh4/0TINk1EXDYHVJZAKOFdAb?=
 =?us-ascii?Q?44YE5icrPn7j9ltFCjoViLY6nZqGmdypMokFHgRoCg38jWVHvucHRExnlYg?=
 =?us-ascii?Q?=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8660.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(7416005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2JhdFyEs/M2DgdEJuunxS2D+30JaqgPws5S2rSnDqbE+lR0IGXeH0uILJJYl?=
 =?us-ascii?Q?4qK5ZlAtF1hV3VpvsMB36JojFd94fusHMO6UuTgikFs8v+Ortr+ry5M2cQ7X?=
 =?us-ascii?Q?HFQDL3CEAqTfGr/t9Td0SuDmIzc1BXOt/Zw4+QAu008Uuf8SP3clk9+bcj7l?=
 =?us-ascii?Q?58eWacnBkWLHK1vaZdvArko8kL3MJqQM8qaMLpJmrA7Jb5cz9RWp6yyJUO8F?=
 =?us-ascii?Q?KbqPny9BnfqLU8+mtDkSyiJFvtIcHAj5v0ZSXCPeoFOq86z7Pp11OwNyWdCY?=
 =?us-ascii?Q?KjR0r3Yp330GKmDdH1MKr02VnOTK9yz1EgDVb1YjVoTyQyOsQyZXWwSLSGij?=
 =?us-ascii?Q?hfpLylNlt8Dmjx3aPzeLplbnBvMlxozq+UwEtbN6d7uNWpfgVINw0k1fevNm?=
 =?us-ascii?Q?5Gm/r+CkkJXwFk/5537jyg46mLnv/uzmUMFEuum8opUlgZqTKBoR/xfxp4/X?=
 =?us-ascii?Q?2v8YQICgGoM4wrKgZc9clH2nUtifDM9hh+9PF1Mivpo4gMenFRElVKTt969G?=
 =?us-ascii?Q?UmqheGdjXdkEk2R1zArsFwpcXqo4+Y5TbtZiLaSZ0V6mMPCPNc4b0nW8wKJw?=
 =?us-ascii?Q?gF4Gk8/45/bihLg/4J1Vk15iT8uNUq+N406KG5BVnmSAloALhoiHK7vrbYlF?=
 =?us-ascii?Q?0J5XKkW1ysgiALfWsbakpzGOCQzpMler+7FQSmxkSpMqBqa+nqGLIhnpCDlr?=
 =?us-ascii?Q?0LE84h0DB3nO5Ir2lHj2OL6HzzGAIhtNJg+5oJ/xfy0f6uOIl8nTJLVd3wTv?=
 =?us-ascii?Q?IK5lnxsmUOFfHxFyLGLa+4ZdgtPuq0+3oLV1/q4FK14WzW/OQ+SNNQcz2NDf?=
 =?us-ascii?Q?7XqGLowpqscC/wrcqBFjodwglSd42RIhg+l01xBF6Ec31fIZfg01X/53/N9y?=
 =?us-ascii?Q?pYFH16/JTgoHxaZYgctnLm6gnzV9q2IuT0nv9jSEtEMgNCdLnXCfV4ScNrfN?=
 =?us-ascii?Q?KvZutyoXTtpnTnDVBLWTaHta6c9QqjBmgQdTPlmhBuHzqf7p23CQmeutCk45?=
 =?us-ascii?Q?FAAaaQvq43eDVOmoSdeTXMMVZ2DbMqaYxIy+3P15Bmo0nmRW/n0tqSDuReZw?=
 =?us-ascii?Q?rkldIMsI5Q9/rc072tztAh65bcSBP0xHTCkW/egi9levB1XioTzId8uGOyPI?=
 =?us-ascii?Q?HdeyaidHya/6OjZZmcCMVDrNxbtuuRBYkHUXEelANpyAzup9bQPiLCzKwKZs?=
 =?us-ascii?Q?l6SjHpW7h6OtRhNxoGKyS1wGx7wEwo9BNBPvQ8vIb08jdQjFxNCR7CC/rlZ9?=
 =?us-ascii?Q?EA8d6T73qM33s5OUGfhBKZdIgi+HcAOsGk/uIUIgXNcBCD5cLgGouI09r72q?=
 =?us-ascii?Q?ORhWUBQHnhttBq41ycGU3Wxl5CGDTkkVu+zYM7Jpw2KMJKAOLjbySXNVdQtg?=
 =?us-ascii?Q?hEwYZ1PJ+4CtOSj/Hf60ltWs5FFL3/Mrj2ebK83FbotQ8lvmSSOWx+GjdoFr?=
 =?us-ascii?Q?VkJrgXKVSIiSWpNv31B/sXpGF7+Bv+5kfccs9if2C8G/yGKYMlOhsIMfSKmx?=
 =?us-ascii?Q?WEu4Li66fRiMpMTO/wNv2bfCEfhI8lnYWy4/CuDBZ7P3c+4TDr6WfvBGr0OP?=
 =?us-ascii?Q?W4eKwkHIS9U53giYyHqXPMUvEuUHD3M3dB1OtLGw?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a99fa9b-f4d7-448a-9e0b-08dc681614d3
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8660.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2024 06:32:03.1264
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N6dWaqLhsFy1TRB9h6M4iDt5/qdNjY+byHzBPF4zu9Gtg08kvMpN9jaqN6DAuKbVmKFKjBqmLa4UVeGhuGl+Ug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5036
X-OriginatorOrg: intel.com

On Thu, Feb 08, 2024 at 01:26:30AM +0800, Xin Li wrote:
>Handle host initiated FRED MSR access requests to allow FRED context
>to be set/get from user level.
>

The changelog isn't accurate because guest accesses are also handled
by this patch, specifically in the "else" branch.

	>+		if (host_initiated) {
	>+			if (!kvm_cpu_cap_has(X86_FEATURE_FRED))
	>+				return 1;
	>+		} else {



> void vmx_vcpu_load_vmcs(struct kvm_vcpu *vcpu, int cpu,
>@@ -2019,6 +2037,33 @@ static int vmx_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
> 	case MSR_KERNEL_GS_BASE:
> 		msr_info->data = vmx_read_guest_kernel_gs_base(vmx);
> 		break;
>+	case MSR_IA32_FRED_RSP0:
>+		msr_info->data = vmx_read_guest_fred_rsp0(vmx);
>+		break;
>+	case MSR_IA32_FRED_RSP1:
>+		msr_info->data = vmcs_read64(GUEST_IA32_FRED_RSP1);
>+		break;
>+	case MSR_IA32_FRED_RSP2:
>+		msr_info->data = vmcs_read64(GUEST_IA32_FRED_RSP2);
>+		break;
>+	case MSR_IA32_FRED_RSP3:
>+		msr_info->data = vmcs_read64(GUEST_IA32_FRED_RSP3);
>+		break;
>+	case MSR_IA32_FRED_STKLVLS:
>+		msr_info->data = vmcs_read64(GUEST_IA32_FRED_STKLVLS);
>+		break;
>+	case MSR_IA32_FRED_SSP1:
>+		msr_info->data = vmcs_read64(GUEST_IA32_FRED_SSP1);
>+		break;
>+	case MSR_IA32_FRED_SSP2:
>+		msr_info->data = vmcs_read64(GUEST_IA32_FRED_SSP2);
>+		break;
>+	case MSR_IA32_FRED_SSP3:
>+		msr_info->data = vmcs_read64(GUEST_IA32_FRED_SSP3);
>+		break;
>+	case MSR_IA32_FRED_CONFIG:
>+		msr_info->data = vmcs_read64(GUEST_IA32_FRED_CONFIG);
>+		break;

how about adding a helper function to convert MSR index to the VMCS field id?
Then do:

	case MSR_IA32_FRED_RSP1 ... MSR_IA32_FRED_STKLVLS:
	case MSR_IA32_FRED_SSP1 ... MSR_IA32_FRED_CONFIG:
		msr_info->data = vmcs_read64(msr_to_vmcs(index));
		break;

and ...

> #endif
> 	case MSR_EFER:
> 		return kvm_get_msr_common(vcpu, msr_info);
>@@ -2226,6 +2271,33 @@ static int vmx_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
> 			vmx_update_exception_bitmap(vcpu);
> 		}
> 		break;
>+	case MSR_IA32_FRED_RSP0:
>+		vmx_write_guest_fred_rsp0(vmx, data);
>+		break;
>+	case MSR_IA32_FRED_RSP1:
>+		vmcs_write64(GUEST_IA32_FRED_RSP1, data);
>+		break;
>+	case MSR_IA32_FRED_RSP2:
>+		vmcs_write64(GUEST_IA32_FRED_RSP2, data);
>+		break;
>+	case MSR_IA32_FRED_RSP3:
>+		vmcs_write64(GUEST_IA32_FRED_RSP3, data);
>+		break;
>+	case MSR_IA32_FRED_STKLVLS:
>+		vmcs_write64(GUEST_IA32_FRED_STKLVLS, data);
>+		break;
>+	case MSR_IA32_FRED_SSP1:
>+		vmcs_write64(GUEST_IA32_FRED_SSP1, data);
>+		break;
>+	case MSR_IA32_FRED_SSP2:
>+		vmcs_write64(GUEST_IA32_FRED_SSP2, data);
>+		break;
>+	case MSR_IA32_FRED_SSP3:
>+		vmcs_write64(GUEST_IA32_FRED_SSP3, data);
>+		break;
>+	case MSR_IA32_FRED_CONFIG:
>+		vmcs_write64(GUEST_IA32_FRED_CONFIG, data);
>+		break;

	case MSR_IA32_FRED_RSP1 ... MSR_IA32_FRED_STKLVLS:
	case MSR_IA32_FRED_SSP1 ... MSR_IA32_FRED_CONFIG:
		vmcs_write64(msr_to_vmcs(index), data);
		break;

The code will be more compact and generate less instructions.  I believe CET
series can do the same change [*]. Performance here isn't critical. I just
think it looks cumbersome to repeat the same pattern for 8 (and more with
CET considered) MSRs.

[*]: https://lore.kernel.org/kvm/20240219074733.122080-21-weijiang.yang@intel.com/

> #endif
> 	case MSR_IA32_SYSENTER_CS:
> 		if (is_guest_mode(vcpu))
>diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
>index 363b1c080205..4e8d60f248e3 100644
>--- a/arch/x86/kvm/x86.c
>+++ b/arch/x86/kvm/x86.c
>@@ -1451,6 +1451,9 @@ static const u32 msrs_to_save_base[] = {
> 	MSR_STAR,
> #ifdef CONFIG_X86_64
> 	MSR_CSTAR, MSR_KERNEL_GS_BASE, MSR_SYSCALL_MASK, MSR_LSTAR,
>+	MSR_IA32_FRED_RSP0, MSR_IA32_FRED_RSP1, MSR_IA32_FRED_RSP2,
>+	MSR_IA32_FRED_RSP3, MSR_IA32_FRED_STKLVLS, MSR_IA32_FRED_SSP1,
>+	MSR_IA32_FRED_SSP2, MSR_IA32_FRED_SSP3, MSR_IA32_FRED_CONFIG,
> #endif
> 	MSR_IA32_TSC, MSR_IA32_CR_PAT, MSR_VM_HSAVE_PA,
> 	MSR_IA32_FEAT_CTL, MSR_IA32_BNDCFGS, MSR_TSC_AUX,
>@@ -1892,6 +1895,30 @@ static int __kvm_set_msr(struct kvm_vcpu *vcpu, u32 index, u64 data,
> 			return 1;
> 
> 		data = (u32)data;
>+		break;
>+	case MSR_IA32_FRED_RSP0 ... MSR_IA32_FRED_CONFIG:
>+		if (index != MSR_IA32_FRED_STKLVLS && is_noncanonical_address(data, vcpu))
>+			return 1;
>+		if ((index >= MSR_IA32_FRED_RSP0 && index <= MSR_IA32_FRED_RSP3) &&
>+		    (data & GENMASK_ULL(5, 0)))
>+			return 1;
>+		if ((index >= MSR_IA32_FRED_SSP1 && index <= MSR_IA32_FRED_SSP3) &&
>+		    (data & GENMASK_ULL(2, 0)))
>+			return 1;
>+
>+		if (host_initiated) {
>+			if (!kvm_cpu_cap_has(X86_FEATURE_FRED))
>+				return 1;

Should be:
			if (!kvm_cpu_cap_has(X86_FEATURE_FRED) && data)

KVM ABI allows userspace to write only 0 if guests cannot enumerate the
feature. And even better, your next version can be on top of Sean's series

https://lore.kernel.org/kvm/20240425181422.3250947-1-seanjc@google.com/T/#md00be687770e1e658fc9fe0eac20b5f0bd230e4c

this way, you can get rid of the "host_initiated" check.

