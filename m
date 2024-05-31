Return-Path: <linux-kselftest+bounces-10981-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F58C8D5A95
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 May 2024 08:40:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02AAD1F21634
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 May 2024 06:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFFED7FBCE;
	Fri, 31 May 2024 06:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Zav4Y0JQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB18A249F5;
	Fri, 31 May 2024 06:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717137609; cv=fail; b=Aqjrrwo4QlziTSYyua917AVZUIozeaPcOpbT0D75+5BatkvyBeH4pl92pE1t1u/qk8rZubXJxjI5W/2lYa0n/a+6CQdkesnb/WqQiRy2FKxFdNmgfpdKtiGAFJCdI9xOGaoLIGR0cX31Ug3wcQbpSmw11dJbC3UTloWQCG6JouM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717137609; c=relaxed/simple;
	bh=n64AvCPT4IsniUq93Yy2PDLJCicwa0+zNyrSBluq3DA=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jb5mJpTdtcmg6/v+8ANnCsZNGMieVdNkTxRX24NqqAa/2qMctagCFbHPevsGX5PQXhY5CeRItJYEhozOmy09Ksb7m01jSzwdZP0o0YQIFN75vEIdX/75PJzdrcJfIqmNWSUPoJ1kneIw1Vpm+AqaDYFhFUlSBUD4sOCdXxJmEQU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Zav4Y0JQ; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717137607; x=1748673607;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=n64AvCPT4IsniUq93Yy2PDLJCicwa0+zNyrSBluq3DA=;
  b=Zav4Y0JQo3Xu9PYQNYuh6wBPtUdCO/O+a3C51qG37HqDRM6S2pJUoiul
   ZqvaluRKX2LsEkVAsndkhzC2K53yeTwwLkFvPc4drnrfOr6mjvfnokcMB
   oxnLSYksLB4sYBvFNO859I2+sUGMYE4j9Gn+bNHWFnJzzq5GMyj9K/ArJ
   pp5QDCy/zYsWzur00qnNFZ0Q+ViqhQkXP+rumCA+3Tpke8uRp1DyilvR6
   gyzKqhfidNoa3QrqNm/1mL7S2EMenCaZHuFiwh9W9/+/F2DJ3JYtixcXL
   rYHY6F5sK64qi3X/jQlT7tmnIU0k5ot7ZG00JUWk1A7MyB+6VgpodtXys
   w==;
X-CSE-ConnectionGUID: XmoZr4HmRjuNUvR2xKVLUw==
X-CSE-MsgGUID: crThXCp9QlWssvIb0e2sFg==
X-IronPort-AV: E=McAfee;i="6600,9927,11088"; a="25067983"
X-IronPort-AV: E=Sophos;i="6.08,203,1712646000"; 
   d="scan'208";a="25067983"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2024 23:40:07 -0700
X-CSE-ConnectionGUID: i919I+baRBe9Vi2x6vT7jw==
X-CSE-MsgGUID: Dd9g4cmBSnGuXdut8oQmsg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,203,1712646000"; 
   d="scan'208";a="40990534"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 May 2024 23:40:07 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 30 May 2024 23:40:06 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 30 May 2024 23:40:06 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 30 May 2024 23:40:06 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.40) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 30 May 2024 23:40:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NsnkYUcD6aLua2vZquuuj8Q0J3MBn2FSLdOFhrV5LnZ9CdkKs5aRFLtd6pVw7IEMEhbwL9e26sH0mg6GPPdU7OFMWMcNHE4KYPa6hmLp0aAbMdcSOHHl8YuI44FTne3GyH1UWEUJuBl8ZMy+FSnaeqLgTyp150AoM5x/GZYKb65nqKiTtREMXg32VWUn1m3jzfNESkYiA8azalcnDHaGUTXtq3ZJrsAYSqso7oPcfe4Gl1TXb7tn3qzTlIPLj8tvBfjfdXMCnFeD5WESV6OduVext4OOCJbCjL3RuLpNfQ5mPzSiMnzHIBkaVAKooJgentiTt0YdLyq7ILE0HDMcvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g5fi05VHHzigryPOPysmCCW1Si2Iemx+6r0k4tJ70r8=;
 b=nulQBt+DqJ7ZC4Q/lp86C1E+EJ0gRLWENKNFnTi7vAFY3JgRkMJZ2KP5GsRFOBn8WMvnT40gpgcKdqKzgmQJa/5nIu1/Of4f6oJ2f7ZmlSG1vjO6B+8cxxD7Zn10L5JGUrkfeLsb2/ryHLtAfFalOg64YiKQo4H62yVNcSFBP+xvKljylzPVD0t13MhHit6L7Nkby1SVsj7mRNvPUwOK8+yaAIZ0oQbWMVK9SbQBlZQBI1VyvT0HYjvzFZ6fkf6yRT00RditPyOZFCQvDugUg9FxatPV7p+u/0h7LwWzPf/7gk9We379UlpUGJ7x2PLwoNK1A1/wb6qOXQIt61wz5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6231.namprd11.prod.outlook.com (2603:10b6:208:3c4::15)
 by MN0PR11MB6254.namprd11.prod.outlook.com (2603:10b6:208:3c5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.24; Fri, 31 May
 2024 06:40:03 +0000
Received: from MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::a137:ffd0:97a3:1db4]) by MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::a137:ffd0:97a3:1db4%3]) with mapi id 15.20.7633.018; Fri, 31 May 2024
 06:40:03 +0000
Date: Fri, 31 May 2024 08:39:47 +0200
From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To: Reinette Chatre <reinette.chatre@intel.com>
CC: <fenghua.yu@intel.com>, <shuah@kernel.org>,
	<linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<ilpo.jarvinen@linux.intel.com>, <tony.luck@intel.com>
Subject: Re: [PATCH v2 2/2] selftests/resctrl: Adjust SNC support messages
Message-ID: <foz3qzdremrnxzfwltucbyugkiieyoxg4vhml3csu2yodnfld4@bxvyu44msaxc>
References: <cover.1715769576.git.maciej.wieczor-retman@intel.com>
 <16764746e8f9f42cbd45d61210764a9b67085cbf.1715769576.git.maciej.wieczor-retman@intel.com>
 <d8396d97-5000-4ffb-aaba-e71de5d6d909@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d8396d97-5000-4ffb-aaba-e71de5d6d909@intel.com>
X-ClientProxiedBy: BY3PR04CA0025.namprd04.prod.outlook.com
 (2603:10b6:a03:217::30) To MN0PR11MB6231.namprd11.prod.outlook.com
 (2603:10b6:208:3c4::15)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6231:EE_|MN0PR11MB6254:EE_
X-MS-Office365-Filtering-Correlation-Id: f9b83dbe-5581-4990-e37c-08dc813c80a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?OFsVFHHHxItMm9JYJXTwP0xEhpnc3WpSU1Rtr0G1uudE+pKHPpn93HHDVW?=
 =?iso-8859-1?Q?fnWcTDUd6GdkqI/uvJYzChj/jzWZxY22wp06mIzqjeGy6U98fUzl3cInoi?=
 =?iso-8859-1?Q?Z3/t1qCqV++EPnIlssc70ri6xUwuShafAXmaG5j/lynTHek1evuL84fAs/?=
 =?iso-8859-1?Q?BWi/0TvAsKxrUd0ncKMldt9K0lG9fa6o79vF8TJdPmXA+jB9YsnwfOTRUy?=
 =?iso-8859-1?Q?zZC62PPiGap0PIK0gHit6DswhbO5zfN1BumlDjGVo/o1BJuw64/rIIs+x6?=
 =?iso-8859-1?Q?Cy+Cxty+992Iaf83n2OIbPMFwF9JdRcY76aPDU6kh51NBM3cIWXh7+v3kH?=
 =?iso-8859-1?Q?+/rVO9K92K1cgQTYwMuggO5qGzSlj0/vc9Psre0FVUPErBMGC1NOR27rED?=
 =?iso-8859-1?Q?5VTvH73932KvgpKrmk821UFdCoiSE/k7ZLl0JUiXkcLoBcSAXNQuYwAAWn?=
 =?iso-8859-1?Q?dcFX5Qh6mKRu3cjXUX0/o57HHG8CBHwZprpC1fhyKeqk6MBV3ukPM07OJS?=
 =?iso-8859-1?Q?dVgmwEZGY1EvEmYk+kG4qNRhxtb9+y+Md1ONEUehojkXWlss7Yq7Y5APD3?=
 =?iso-8859-1?Q?+Bfes9EVlE6aU/h9CjngvjK9Nr68BJOTB4/IcEmXRyZUV4Dzih0fPCQXqn?=
 =?iso-8859-1?Q?mPgFxJhlr/QiuFrzRr+3476jp/T4LAqYVLZ9ad1OBhDYVwTBLVJYfDB8ju?=
 =?iso-8859-1?Q?C2AZ9fU386/ZK7I4Exah5l1aPVxEy7rFlV+kg2wYtnL2mb5ZJoDVrkuIzR?=
 =?iso-8859-1?Q?B88cdeobyNjsmAjmlxu2KcFpajtTYMqQ0WfY3msFW2Hs1VMFOqnACvS8bp?=
 =?iso-8859-1?Q?2ctdsdk+eyfsyInpJYDXCVGKTmMQFIGTMqIPuGCI1hYL1ZIRQOiYBuaviy?=
 =?iso-8859-1?Q?xZoVl2tNNNdi2VDcCPEq7sdsUK1Zfghb8XrK4Cj+zdSijGt7hp2BatnJW6?=
 =?iso-8859-1?Q?pBp3aQbOWC4Q4rsHV2dZqWLYuo1mkGL2iM6rcx27Dt7qEAQeEX6Cdte43C?=
 =?iso-8859-1?Q?0UQj4cizguQRcUdRU/eZqP4Cm8RKEhy247px2WrF4Q9qABL6huIIfRde2S?=
 =?iso-8859-1?Q?MgimyC7WwNADRGWm5JwDKPMYSryfmneW9jDXBghTD6ZJQcqVdQNNqnwdQ7?=
 =?iso-8859-1?Q?U44fvQvOh2A/EoFg6SkRyf1CnobIN7vs2k8Nxu3cvqDz9ncnYYEr7FM/sS?=
 =?iso-8859-1?Q?E8a3RYYC7zyAgdZm2ee2LfUb4Xp9IuhP7Us95NqKy0A+VXfj86t9J+4bYK?=
 =?iso-8859-1?Q?CSdwPdEWG5FB+uGUJZA11TcfQKPDrsRdBkLvfDdOA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6231.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?Q0a4WsRMiwqB3PVAbglWoRaa7fOTgBhbYYHMcRixocV9l/qYrUV8EX6TzL?=
 =?iso-8859-1?Q?MVbq8JpKox593VkWA/oysV+AaE2VbD7tWow7taejHPuOF6uhiI1XctkNHE?=
 =?iso-8859-1?Q?JNLeLIezi5TJ9QV452mI4C1VPHurT1desmWexQKsXK5wMHjw5z2sbBy64/?=
 =?iso-8859-1?Q?F4ug2gAoMc9SduXtica8s/Cm32Ho0EkBWy3U1x2mTalTzuLkHhDtLfBorS?=
 =?iso-8859-1?Q?9g/Hzw3Nw9x+9t4OaKxbXNFOEJ4Xbb/YSp5j+b+Bz6q+IN/pwl4ZU7qGJD?=
 =?iso-8859-1?Q?A80hCA1mx6P22kEywmGuPiOqFgYwRLy2fv2wMwFcNGDptrD0hUAvVucRdd?=
 =?iso-8859-1?Q?wiVyzABqi4N8im6IKN+Awg9S5lhCFhn/XX9dKHU6aDZClI5JXZI9MLOLZA?=
 =?iso-8859-1?Q?cjfIS/rp1uQuMGhz2QDYUXfi1XUPPd+Q0J3tvCzy72iD4x2o93umyJQ0jC?=
 =?iso-8859-1?Q?aQoAX4LWzn9BvecyVhPOi2V+pt4RRAw8kM9Lk43QnM25DGEjxHyD0EcX5S?=
 =?iso-8859-1?Q?sSTj4mNee5jmh79LjZ40AXI0kssgQRV4zjVtikUQxNK1dJPdntG4im4NgI?=
 =?iso-8859-1?Q?Fb03fszMNK/b4R56AMVZkh5DpPgiaVse1tE2pRTgNJYdS0JNtGVQZrSg+/?=
 =?iso-8859-1?Q?5A2AGm8xLfbGbRj4CR1ROEcoPYo7OKpzSMTareydRJK08ve0ZjWnYGU9Kk?=
 =?iso-8859-1?Q?6n7iL8LMRgHSiNlSXTBJn1murLL7dALwh9kJkzbsgV+jm32ivVc5VTd/IW?=
 =?iso-8859-1?Q?+SstrXbgIQn4fWVrpgJF1c8OZE5VnTwuo6N51j9gz14dj56mYoxwzCjDY6?=
 =?iso-8859-1?Q?pkt4XqDoSsydUlYVwwqhQLt4029BlCeYePnrWIPkOIHhu3QwrpCYh7XJi9?=
 =?iso-8859-1?Q?TET6NPDav5cZpPSSI/xDcqFqWzf9Pjt0gn6LpZLZlJxqZbMasp5u8udXEK?=
 =?iso-8859-1?Q?c3JKCSCck57n1ZUC6AvzjIYYqGQXKEuiEs5KfnpObnpB88IOrktNgs/YEc?=
 =?iso-8859-1?Q?PSXbKkaK1Xlh/DpbiJ+eRCTtl1SFWLpF5Vpn1KcmHc1Kpn5UAnLC3un1Zw?=
 =?iso-8859-1?Q?DF9PszHQvkxlWu0/6R1N9C7I4pUe61AzaeUlZWFVOfxr6PiILzXqBGnhXb?=
 =?iso-8859-1?Q?MSwZsZyh37yhDXMSI44SwQKoHHDkeJvJEZBHb8XQ46NGzeA3qcQDBeRB64?=
 =?iso-8859-1?Q?bUuHYw4x5VVU09+fARpQmolDxy1e8oMzDtfp4tzhOI2jQUbpk6ZBceQQ6V?=
 =?iso-8859-1?Q?KVEFnbUpSgZALZgN+CDx/2FdUhKedIZy4p7KL/d5Yx4CyR8sWnda2EWgp+?=
 =?iso-8859-1?Q?QGLYPb82KrXWEmrJXixqvFb65bSHFYGJwLLhgz8LXVSkvvXnJJYlwVCaLP?=
 =?iso-8859-1?Q?2hvJHdt/2+wT+PpWqjORjkvF9rnuZoJvV2ODu4Hvy2qOCOIoV5G9wcia3A?=
 =?iso-8859-1?Q?T+LhsNY7CNoHiqNljdGRRS90Gc8/6nCeHJzx3EIp7fJKX9swXsyO1n6Bk1?=
 =?iso-8859-1?Q?AcWTSvvgW7+t4bgYljG8sOmvP0bGLLRFSk4HJ9O4AvIqPJYgns9CJYlBnq?=
 =?iso-8859-1?Q?l9i5V4oiLepCeLTAATGhr71d8HD4mpnNoq5Al9ZKfXbMVoYQTlfbLET/5h?=
 =?iso-8859-1?Q?qpwXK38xx43uwK8xH7IUx97kLcGramTn2MLBQIVPrmyLw1X10YW9xGr8J9?=
 =?iso-8859-1?Q?7zE5SnNr4Qlv4RlXND0=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f9b83dbe-5581-4990-e37c-08dc813c80a3
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6231.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2024 06:40:03.7165
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1XqMerG50Kl04PoCFwQOrpxOJFU7L0gaCDsnGSWj+KNHb3akafZxZe+ig22XZJMznOkpb7HGFJqIGoNHTbrC4frAwI0PP64GfqK+g2IZhPY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6254
X-OriginatorOrg: intel.com

Hello!

On 2024-05-30 at 16:07:34 -0700, Reinette Chatre wrote:
>Hi Maciej,
>
>On 5/15/24 4:18 AM, Maciej Wieczor-Retman wrote:
>> Resctrl selftest prints a message on test failure that Sub-Numa
>> Clustering (SNC) could be enabled and points the user to check theirs BIOS
>> settings. No actual check is performed before printing that message so
>> it is not very accurate in pinpointing a problem.
>> 
>> Figuring out if SNC is enabled is only one part of the problem, the
>> other being whether the kernel supports it. As there is no easy
>> interface that simply states SNC support in the kernel one can find that
>> information by comparing L3 cache sizes from different sources. Cache
>> size reported by /sys/devices/system/node/node0/cpu0/cache/index3/size
>> will always show the full cache size even if it's split by enabled SNC.
>> On the other hand /sys/fs/resctrl/size has information about L3 size,
>> that with kernel support is adjusted for enabled SNC.
>> 
>> Add a function to find a cache size from /sys/fs/resctrl/size since
>> finding that information from the other source is already implemented.
>> 
>> Add a function that compares the two cache sizes and use it to make the
>> SNC support message more meaningful.
>
>Please note that the new version of SNC kernel support ([1]) that this
>series is based on no longer adjusts the cache size. Detecting kernel support
>for SNC (if the new solution is accepted) can be done with the test for the
>existence of the files Tony mentioned in [2].

Thank you for your comments on both patches, I don't know how I missed this
fact. I'll revise my patches accordingly.

>
>> 
>> Add the SNC support message just after MBA's check_results() since MBA
>> shares code with MBM and also can suffer from enabled SNC if there is no
>> support in the kernel.
>> 
>> Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
>> ---
>
>Reinette
>
>[1] https://lore.kernel.org/all/20240503203325.21512-1-tony.luck@intel.com/
>[2] https://lore.kernel.org/lkml/SJ1PR11MB6083320F30DBCBB59574F0BDFCEC2@SJ1PR11MB6083.namprd11.prod.outlook.com/
>

-- 
Kind regards
Maciej Wieczór-Retman

