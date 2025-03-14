Return-Path: <linux-kselftest+bounces-29054-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E241A61536
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Mar 2025 16:46:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51478462865
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Mar 2025 15:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 974EE1FAC3D;
	Fri, 14 Mar 2025 15:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OJNsVB7w"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2236A3594C;
	Fri, 14 Mar 2025 15:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741967184; cv=fail; b=re/T15fbmxYJaSGBsCFM1g029XG7idaekDEFt/cwVCjdQwEd+M+3kZ7bfWymiPditVCGEnXUtjRJ7iv612g7Si1vb4IiKWjoZVD0SYAb34uSbxgwW3peROnB32WQMi7qrwHp09Jwpk+SVJU5OdXK25m+WJS6RfXAVNZedWHQETE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741967184; c=relaxed/simple;
	bh=s8WV32kXVM381WZTA/h2MIFMcQ7VcYRQBmUtDplDFFs=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Zju2FD1Nyv8VZ6r1YhtQqYH0IjPpxYz1WOpZ6Cc4/IJeTRqLkdyoJCfAYT6MHynDXZ6AA9Rh2tN+nsvq6xSBr1NJ7fBNCymi0r/IhzU9NAfyYLJRfz2bpsmJ1q/l1EuiWHzsRkg09NNw4f9FOdBrWuTvLs0SUr5bexj+P1U1Qe0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OJNsVB7w; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741967182; x=1773503182;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=s8WV32kXVM381WZTA/h2MIFMcQ7VcYRQBmUtDplDFFs=;
  b=OJNsVB7wQuTOm47uGJEZmQrccDkGUUCQENeBsPL2R67BVD+0cF5ydvGW
   xih3mJiCEeufNrIHh/t5J4cRGdcfH28WWYg8DXHwyyTcZySR0MLpvoGoo
   y/ht3bJykEiBR9McNQCxDcIFUWRa5x1t3uY9oXJtwLxud+hK8FexXzmca
   gGhYPdnzF8Mu2b31V06BJmkh3El05ouHI/sbo9tUn0nFJcJd1fGZht4Vz
   kPM+jedd+DlBZI9VnjdnN8qPQ+PYbPVL0CFPFNuN7xYqpCpmrLDD9TahE
   7pKitJFQ/QIafYuamA2DMQP3OLm6BjSEGXojjTZUNsgst30+wonZ2mBa5
   Q==;
X-CSE-ConnectionGUID: I7CS85FARoyVrAnImrUbkA==
X-CSE-MsgGUID: eRvBD/EQQp+iNNf9ellpag==
X-IronPort-AV: E=McAfee;i="6700,10204,11373"; a="43013073"
X-IronPort-AV: E=Sophos;i="6.14,246,1736841600"; 
   d="scan'208";a="43013073"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2025 08:46:21 -0700
X-CSE-ConnectionGUID: cGUqaVf9Q2Wh2CLStwyV0g==
X-CSE-MsgGUID: UiSbdWe9SW2hBjN17Z/7EA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,246,1736841600"; 
   d="scan'208";a="126185724"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2025 08:46:20 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.14; Fri, 14 Mar 2025 08:46:19 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Fri, 14 Mar 2025 08:46:19 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 14 Mar 2025 08:46:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tn138woEap9mlpBopUL5OInLteelNloMS7pRpPwMD5uD2C0fUXsoDuhLhIMpCJSzIBGMV2HpBTZFOF4WbNJCF0T9ndFXgdaVnFJpBQYHvadz1XK95nqn0rtAHTgJOMWKO+W5amYGHBB+96TCYm6+cHoyHiWA9Y43Z+UAAueDeWIW/gLBU9aZCwq8FPgPBXo2WmNJg4JWEbbGU+6gilrCcXnuY7zEpX5JE70JwKPfDu6xiJ1ri9waU+Kyg8YXj8+MOl0+TvuR6EU6pjnTod+V5sW9rHZ6Z2sgw2MeKEUmKBGRtUFf4aI8TevwedV4AE8t7wnS/LvVBJSC5dYIECSMRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ee8nSwHcBNN9hkG7t/c5daE6cWBNNbmr+vn8L7MtCqI=;
 b=NOFIvWFFC6EeaB8oUaWJoegCkboYpkbW+nYRp/GiUK3aD88VYfTxXxiLn+P0u/7bl0hiOn2bpFgE9ZfvcFLoIVDljV9WKcOMLF3t52EyQrs1Sz71/q/hoejsJlIG1r8nMbyXTu2PpLTOe4C9MmvCWw0Xwf/Cm6z3Fcj9eL7P0XCMgRubppy5FBRldrIMWeG64XyaXp1XIcE2EIBazLheZXwo+5bbbeXmYf69Mxpi3jgHjiVhoDTupV4+tJAfbQ3F4sPa9TGbVXTLo+BmB7yrR8P2wWOcbTsUV23oCDhGbRmaToiCEC/2HTd71zUa/iwwQIBjsO8Kxe8oTBdWoWuGQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 IA1PR11MB7679.namprd11.prod.outlook.com (2603:10b6:208:3f1::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.27; Fri, 14 Mar 2025 15:46:13 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%3]) with mapi id 15.20.8511.026; Fri, 14 Mar 2025
 15:46:13 +0000
Date: Fri, 14 Mar 2025 16:45:59 +0100
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
Subject: Re: [PATCH 00/13] selftests/bpf: Integrate test_xsk.c to test_progs
 framework
Message-ID: <Z9RPNzJtBgheiTeS@boxer>
References: <20250313-xsk-v1-0-7374729a93b9@bootlin.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250313-xsk-v1-0-7374729a93b9@bootlin.com>
X-ClientProxiedBy: MI0P293CA0005.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::19) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|IA1PR11MB7679:EE_
X-MS-Office365-Filtering-Correlation-Id: b3bfaa4f-b0a8-424b-2f58-08dd630f5998
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?irW0ICDC+MLo4nG8CN0nQsN4/FVFSS60PiHeAph3Z8uiimRDTfk2TsT42rNW?=
 =?us-ascii?Q?3okgxzDRif/o85SFeNc/YRC/ywQqxaj+UTPQjQlZrwCfU+NrGgQjL3cOSD6c?=
 =?us-ascii?Q?cS+op/q5LIaTjwzsYOzh1tu2zSdM4XZCj9eeVuy2oEdKdfcA4u8kSasxqgEk?=
 =?us-ascii?Q?D031OgVfOhERhNvFhstjE+1z8z8av3YoitrNl55k2R27o4ixl6N4mfct6r3s?=
 =?us-ascii?Q?yP7xetTkTNrJXXCGdq/iUO6moopRjugXzwESnjEDBgnoEzLM+9XmlIc+k/+G?=
 =?us-ascii?Q?YIw3JcaOkR5ez4/yvYQd7zSPIZuSJPIef1H3Na1l37lejaC5kyRzKjWFpX/D?=
 =?us-ascii?Q?WVGawqnW+7YTO5MaFSJayCGsQQz8MLQirzYo6rP1ap1WFtq/t3a/sFvsmIj7?=
 =?us-ascii?Q?HrP82uUNr2D47t8O8Tg2E5fmDoJWS+f+h/4hiDdDIKB+NGrS+Y+LjD131XRl?=
 =?us-ascii?Q?YKIoqyvTpiCP/3BcMN+W1y9GuUaFJAT7/4MXpv+Gd0DG2wHrklu8wK67JN0V?=
 =?us-ascii?Q?VIOxAbkSPSPcpm8mdZvUpA1SOHEdMpGUI4ZMBAb+hWbqYluns2YwwQmE8CLt?=
 =?us-ascii?Q?ymE3wyrnD3g9SfuezDZXjJYlr0oXmbQIHkRn8g/Nr4uaUDwQXoQMEFd4NsDu?=
 =?us-ascii?Q?AGFNbm2satFFuuzjRkcrxsjJTdKhDDenNlj8lA4QnLz6z0Qp0xXuYdKQXN85?=
 =?us-ascii?Q?azJPTkqo7syM1cIm9CraVJLd4/fMlrVSuOmmzRL8WzjXbda9h+PPnGWz6VHV?=
 =?us-ascii?Q?UqsAoEBkIU4IMy4RaE4xecGWmcI/3Ej7JYL2yDYeI6mRUjDMzggdDpwn2FLU?=
 =?us-ascii?Q?HZSNDtNlcvMuVY17cWiSBnk9LTePukHs+QBZ6I7obwFCJu9eafqhWHYMMHQy?=
 =?us-ascii?Q?i/0BVlEn2+wRQIIf2a1GH2j/xJ8JjnZOzaDN2+u61IxClEuU11oZAslvnSr8?=
 =?us-ascii?Q?cRFDzQUEDkAvonkKFBDwARte1DRgtgzkvgFnJ9tOCIxXlY5631BfpMKbCxAt?=
 =?us-ascii?Q?9pGebGOF6Lzdst4s8p0NTvQGBj1dompamt9GJ2hgaZypLP+vTsHfyrIfkHJb?=
 =?us-ascii?Q?Xir6Ds8Sri3fFRE6ShKZ51UuwbuOnwcTQL1erNbBjWyExW2HBDezxqcaOYQf?=
 =?us-ascii?Q?5oKwhtBpmZrp9FVcQkyRGuPaEb73rJrO5uY8+mviMbKRgsGUWRs+o4hfd1wl?=
 =?us-ascii?Q?60JE9xvcJcKJ2V244TGM7KemozWdYzrdbxx41HoRAkWKdYs+CGZOLEb1kGrY?=
 =?us-ascii?Q?5/ZRozR8o4a8cWz942ghmiEHHA12pJCVurRLQjyhIHnaesrOB1fxVSlLrHu6?=
 =?us-ascii?Q?zGQp1A0W6iI7ZVp7cP+m7/uJQEcuFHjB5pTANOw3H4SGozuZ6ld36FHtC4WO?=
 =?us-ascii?Q?ZG2XiwYTPwJCc17D8u3G1EzrGFgq?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WqY/tq4koZB0SO7sfIISsej+dHDyLcCr9B1HoXExHHFLfX1NGzm1nM/NOdr1?=
 =?us-ascii?Q?zTf4gCbbYoQAq43NabUrW5i58HkIcxfdRM2ddyrZEvNqoCOEVpRweqp7tuwA?=
 =?us-ascii?Q?eQmCVA4HKTmN6nMA65FXlvfoUIklHqR2yeA/z2zK5w6NVHp/lEn5w5bZunFF?=
 =?us-ascii?Q?du3fT4K/YKjdKOHNW4UOQPZkX2T9vycCP0TNrS4IjL5At4I0dO4uKu0rPTU9?=
 =?us-ascii?Q?fODgt5rPrux8BWpCEZfv9WUEJhsjTCTl6/veE4Bo5EoRDTLPSfK1sNcY7OF+?=
 =?us-ascii?Q?dNj2jDmMMMBzjIHLv7QCtrcYvxwlGc5wRjobCtLRroDKPatXVXg/5pMKeXhx?=
 =?us-ascii?Q?7Qas2EydPjkAl3SqkIx7YXoo5xxkZCEsOY1CmgXqDOw+dlF8qU2uUdXSYTPD?=
 =?us-ascii?Q?vV6NurwWuz+zwOUrGGtMD/6CVcdgRwuCrUXSvuMFexf+gP41cLatt6RA9bp0?=
 =?us-ascii?Q?cL4SaCRx0eG43PSvOtmHHc8UoR6+TzweGJi9O/6BbbS8L0BuGpU4l6QX5sQE?=
 =?us-ascii?Q?JSkQQ7i5DIfpU1vaqI0XdBZeKHCNLyYH7oiqcu7mN4H7bnJf1gkqyS44GN4k?=
 =?us-ascii?Q?zHr0XX/ChNHorB365gXG0+9wyfhTgivLrc8kLQqOOdYyCj0qVN0qM4GqMZYy?=
 =?us-ascii?Q?v53p9p+IvsAMXQu4Q8fnEfk1jatWf5D1aB6fMW67Mm4yS+z8XT7BAcNlQwhc?=
 =?us-ascii?Q?pwkMDSxZKsu+U8+RHVkf95QFeCgRbdFYJsBNZHr63qqxcNaBHsPOAF5DuO35?=
 =?us-ascii?Q?guJ9F7Pb4OPfUEfqU1tFQhI9clwr65/e6xdRsBznb86IkC/JKR/XotLEcf8Q?=
 =?us-ascii?Q?MPLgUYM5auQCmxJaIyHqnEWQ161UaNZWip0stuEfs9ssV4Jj+ZOnCx8ksKoy?=
 =?us-ascii?Q?yIXJLgX0eEmkKt3VUQgIi9lnerpSPMJ2FduVvXjGk8b7jOfSkhPJ1TBd7OMO?=
 =?us-ascii?Q?E2vqZJ5aAXrdAkkPiKIq1a7HK9oox4tKaqo6iUrdHnFwgHFLLq4JiPjLofmB?=
 =?us-ascii?Q?VVg8DvbJETbOYwkBn+pUP+Ax6PzwL+cF2RPGV7HqLcOgvqqenuUNW4mGVM2c?=
 =?us-ascii?Q?10OWCnP0LII9DwoYJQuOq8ebHjkQC0g5AW5THB6oGNluplHjjdk56fPMOvlZ?=
 =?us-ascii?Q?yvCYcd4VCpfqlZKn2um0l7k3j1F9/hX1sS5s+o50lRPmXvO/Mlke780mDBXh?=
 =?us-ascii?Q?pk7i6z2vyuBw5dJyw913WzoJbsNkYiQ+BAu3jfepMARgJjHK/s5AaMaSrELE?=
 =?us-ascii?Q?NHTuVl8oGM8RMqV4iDns7CeMhyX7VXnBDbr+QdSr+0ijP2sRdAgMs3NXPaDs?=
 =?us-ascii?Q?aZbmNucrosgFpqy8xVhWbKASoL1BQsncmnFP2NhKpHx6yFrWgU/9fyJ+M46R?=
 =?us-ascii?Q?I6iPUaw1N2755RBVMIeDbxZ8grJpKOqNUiyD3PEeB5MvXMYJF11fCC+uxHRO?=
 =?us-ascii?Q?mBkEpUs/f8I2ZA9xWgx5NSEkmpESGggA545rvre0f7bsO07wCkUwRTHNqyMA?=
 =?us-ascii?Q?GpgYcHlEcz/4VJg+Phgk2mGkh4hFEdRYFWeP/WjHVsXiKNmSOsWDEYFeYU+3?=
 =?us-ascii?Q?vFS6LnmGudcPYZ6LfJ8LSBofxR6HCLRtxipbt1Y0wjdFENebpmb5Vb6DLApD?=
 =?us-ascii?Q?Yw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b3bfaa4f-b0a8-424b-2f58-08dd630f5998
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2025 15:46:13.7187
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mFgjTWsbsoUNOFsXaRomTchvCaXTMJ9bnzquYpv12QqGjjmM09yBq3UxXHDFfNGRLZ0PMQ3rg7OlMtJzaq73oIRO06tzgyrofNsAsIx2oIg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7679
X-OriginatorOrg: intel.com

On Thu, Mar 13, 2025 at 11:47:58AM +0100, Bastien Curutchet (eBPF Foundation) wrote:
> Hi all,
> 
> This patch series continues the work to migrate the script tests into
> prog_tests.

Hi Bastien,

the sole purpose of this is a cleanup of some sort?

> 
> The test_xsk.sh script tests lots of AF_XDP use cases. The tests it uses
> are defined in xksxceiver.c. As this script is used to test real
> hardware, the goal here is to keep it as is and only integrate the
> tests on veth peers into the test_progs framework.

We're doubling the functionality for no additional benefits? Or the
benefit of this set would be the veth xsk tests execution within BPF CI?

> Three tests are flaky on s390 so they won't be integrated to test_progs
> yet (I'm currently trying to make them more robust).
> 
> PATCH 1 & 2 fix some small issues xskxceiver.c
> PATCH 3 to 9 rework the xskxceiver to ease the integration in the
> test_progs framework. Two main points are addressed in them :
>  - wrap kselftest calls behind macros to ease their replacement later
>  - handle all errors to release resources instead of calling exit() when
>    any error occurs.
> PATCH 10 extracts test_xsk[.c/.h] from xskxceiver[.c/.h] to make the
> tests available to test_progs
> PATCH 11 enables kselftest de-activation
> PATCH 12 isolates the flaky tests
> PATCH 13 integrate the non-flaky tests to the test_progs framework

I didn't bisect but this set breaks the HW tests for me which *is* what we
care about. I'll dig onto that on monday and will get back to you.

sudo ./test_xsk.sh -i enp24s0f1np1
PREREQUISITES: [ PASS ]
1..93
ok 1 PASS: SKB SEND_RECEIVE
ok 2 PASS: SKB SEND_RECEIVE_2K_FRAME
ok 3 PASS: SKB SEND_RECEIVE_SINGLE_PKT
ok 4 PASS: SKB POLL_RX
ok 5 PASS: SKB POLL_TX
ok 6 PASS: SKB POLL_RXQ_FULL
ok 7 PASS: SKB POLL_TXQ_FULL
ok 1 # SKIP No huge pages present.
ok 8 PASS: SKB ALIGNED_INV_DESC
ok 9 PASS: SKB ALIGNED_INV_DESC_2K_FRAME_SIZE
ok 2 # SKIP No huge pages present.
ok 3 # SKIP No huge pages present.
ok 10 PASS: SKB UMEM_HEADROOM
ok 11 PASS: SKB BIDIRECTIONAL
ok 12 PASS: SKB STAT_RX_DROPPED
ok 13 PASS: SKB STAT_TX_INVALID
ok 14 PASS: SKB STAT_RX_FULL
ok 15 PASS: SKB STAT_FILL_EMPTY
ok 16 PASS: SKB XDP_PROG_CLEANUP
ok 17 PASS: SKB XDP_DROP_HALF
ok 18 PASS: SKB XDP_SHARED_UMEM
ok 19 PASS: SKB XDP_METADATA_COPY
ok 20 PASS: SKB XDP_METADATA_COPY_MULTI_BUFF
ok 21 PASS: SKB ALIGNED_INV_DESC_MULTI_BUFF
ok 4 # SKIP No huge pages present.
ok 22 PASS: SKB TOO_MANY_FRAGS
ok 23 PASS: SKB HW_SW_MIN_RING_SIZE
not ok 5 FAIL: SKB TEARDOWN
not ok 6 FAIL: SKB SEND_RECEIVE_9K_PACKETS
ok 7 # SKIP No huge pages present.
not ok 8 FAIL: DRV SEND_RECEIVE
not ok 9 FAIL: DRV SEND_RECEIVE_2K_FRAME
not ok 10 FAIL: DRV SEND_RECEIVE_SINGLE_PKT
not ok 11 FAIL: DRV POLL_RX
not ok 12 FAIL: DRV POLL_TX
ok 24 PASS: DRV POLL_RXQ_FULL
ok 25 PASS: DRV POLL_TXQ_FULL
ok 13 # SKIP No huge pages present.
not ok 14 FAIL: DRV ALIGNED_INV_DESC
not ok 15 FAIL: DRV ALIGNED_INV_DESC_2K_FRAME_SIZE
ok 16 # SKIP No huge pages present.
ok 17 # SKIP No huge pages present.
not ok 18 FAIL: DRV UMEM_HEADROOM
not ok 19 FAIL: DRV BIDIRECTIONAL
not ok 20 FAIL: DRV STAT_RX_DROPPED
not ok 21 FAIL: DRV STAT_TX_INVALID
not ok 22 FAIL: DRV STAT_RX_FULL
not ok 23 FAIL: DRV STAT_FILL_EMPTY
not ok 24 FAIL: DRV XDP_PROG_CLEANUP
not ok 25 FAIL: DRV XDP_DROP_HALF
not ok 26 FAIL: DRV XDP_SHARED_UMEM
not ok 27 FAIL: DRV XDP_METADATA_COPY
not ok 28 FAIL: DRV XDP_METADATA_COPY_MULTI_BUFF
not ok 29 FAIL: DRV ALIGNED_INV_DESC_MULTI_BUFF
ok 30 # SKIP No huge pages present.
not ok 31 FAIL: DRV TOO_MANY_FRAGS
ok 32 # SKIP Failed to change HW ring size.
not ok 33 FAIL: DRV HW_SW_MAX_RING_SIZE
not ok 34 FAIL: DRV TEARDOWN
not ok 35 FAIL: DRV SEND_RECEIVE_9K_PACKETS
ok 36 # SKIP No huge pages present.
not ok 37 FAIL: ZC SEND_RECEIVE
not ok 38 FAIL: ZC SEND_RECEIVE_2K_FRAME
not ok 39 FAIL: ZC SEND_RECEIVE_SINGLE_PKT
not ok 40 FAIL: ZC POLL_RX
not ok 41 FAIL: ZC POLL_TX
ok 26 PASS: ZC POLL_RXQ_FULL
ok 27 PASS: ZC POLL_TXQ_FULL
ok 42 # SKIP No huge pages present.
not ok 43 FAIL: ZC ALIGNED_INV_DESC
not ok 44 FAIL: ZC ALIGNED_INV_DESC_2K_FRAME_SIZE
ok 45 # SKIP No huge pages present.
ok 46 # SKIP No huge pages present.
not ok 47 FAIL: ZC UMEM_HEADROOM
not ok 48 FAIL: ZC BIDIRECTIONAL
ok 49 # SKIP Can not run RX_DROPPED test for ZC mode
not ok 50 FAIL: ZC STAT_TX_INVALID
not ok 51 FAIL: ZC STAT_RX_FULL
not ok 52 FAIL: ZC STAT_FILL_EMPTY
not ok 53 FAIL: ZC XDP_PROG_CLEANUP
not ok 54 FAIL: ZC XDP_DROP_HALF
not ok 55 FAIL: ZC XDP_SHARED_UMEM
not ok 56 FAIL: ZC XDP_METADATA_COPY
not ok 57 FAIL: ZC XDP_METADATA_COPY_MULTI_BUFF
not ok 58 FAIL: ZC ALIGNED_INV_DESC_MULTI_BUFF
ok 59 # SKIP No huge pages present.
not ok 60 FAIL: ZC TOO_MANY_FRAGS
ok 61 # SKIP Failed to change HW ring size.
not ok 62 FAIL: ZC HW_SW_MAX_RING_SIZE
not ok 63 FAIL: ZC TEARDOWN
not ok 64 FAIL: ZC SEND_RECEIVE_9K_PACKETS
ok 65 # SKIP No huge pages present.
# Planned tests != run tests (93 != 27)
# Totals: pass:27 fail:0 xfail:0 xpass:0 skip:0 error:0

(same for BUSY-POLL).

> 
> Signed-off-by: Bastien Curutchet (eBPF Foundation) <bastien.curutchet@bootlin.com>
> ---
> Bastien Curutchet (eBPF Foundation) (13):
>       selftests/bpf: test_xsk: Initialize bitmap before use
>       selftests/bpf: test_xsk: Fix memory leaks
>       selftests/bpf: test_xsk: Wrap ksft_*() behind macros
>       selftests/bpf: test_xsk: Add return value to init_iface()
>       selftests/bpf: test_xsk: Don't exit immediately when xsk_attach fails
>       selftests/bpf: test_xsk: Don't exit immediately when gettimeofday fails
>       selftests/bpf: test_xsk: Don't exit immediately when workers fail
>       selftests/bpf: test_xsk: Don't exit immediately if validate_traffic fails
>       selftests/bpf: test_xsk: Don't exit immediately on allocation failures
>       selftests/bpf: test_xsk: Split xskxceiver
>       selftests/bpf: test_xsk: Make kselftest dependency optional
>       selftests/bpf: test_xsk: Isolate flaky tests
>       selftests/bpf: test_xsk: Integrate test_xsk.c to test_progs framework
> 
>  tools/testing/selftests/bpf/Makefile              |   13 +-
>  tools/testing/selftests/bpf/prog_tests/test_xsk.c | 2416 ++++++++++++++++++++
>  tools/testing/selftests/bpf/prog_tests/test_xsk.h |  299 +++
>  tools/testing/selftests/bpf/prog_tests/xsk.c      |  178 ++
>  tools/testing/selftests/bpf/xskxceiver.c          | 2543 +--------------------
>  tools/testing/selftests/bpf/xskxceiver.h          |  153 --
>  6 files changed, 3021 insertions(+), 2581 deletions(-)
> ---
> base-commit: 720c696b16a1b1680f64cac9b3bb9e312a23ac47
> change-id: 20250218-xsk-0cf90e975d14
> 
> Best regards,
> -- 
> Bastien Curutchet (eBPF Foundation) <bastien.curutchet@bootlin.com>
> 

