Return-Path: <linux-kselftest+bounces-10230-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A8E68C6017
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 May 2024 07:15:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF4AA1F226D3
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 May 2024 05:15:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7840D39FD7;
	Wed, 15 May 2024 05:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G5M37Mj3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A04C236AF5;
	Wed, 15 May 2024 05:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715750152; cv=fail; b=dK0arWzeZs8krGKHj+Ch6Lz+K2KgODrsD81iFT0RJnRMMBCqNmnLO27VUXdKRkJ4wV3Tkjkft2ntE341pNz6bIP3Y7wdMPmRDTASBfzgICjRvZ4I+8cZc0av9kLPk2Nk8Xf8f/QsZXdYe8NmEn73yppcNL5qDxiQxwy04OkDzIE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715750152; c=relaxed/simple;
	bh=ttpIQDMGlDFaHeljES9gMBVTDVpRLlY1+Ph5ZXJ1sW8=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NHvhPb6vQSjU/UO3JLTYsEjQAS4NW2ml+CG0TUeK5hONpqcD6YCIEV7DFA+wFoeL/gZuZ7Rw3s42kd86TFcubc2z2n4roJYk1IWiCE7lixRXasVsoH0BHSYmeOjL4qUq0Hg8ifMqEsgQlVFZBlhVloAmzRYqTV/ZW2R1UdBHbVY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G5M37Mj3; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715750150; x=1747286150;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ttpIQDMGlDFaHeljES9gMBVTDVpRLlY1+Ph5ZXJ1sW8=;
  b=G5M37Mj3y+rD/v73E/qEfjQiLNOp8i/b0dyq+5K7kKoP555MJvLxvcy8
   6yFrvJpy4ZvYJJi5P6c3t4Z/TV1PCzQkCflcDXToHZKs4H/H/MlbE9Jfv
   8cmu+I/MkKD/q8cj3NkhhOqaAiaVSsbhPzKflw4J67i7abtMIpM9ALJGx
   gNRn0aUadmGHGXKpfYuYppQZzFIVmJH0w+gJsUsGhWHEbLxjSP2T2LIMR
   fFxTi4xJvkd/WY9gtdqcOgJDk/tQvwj+38EBLDeSKhFIHQ5F72C6Lvl8b
   iBc3TEgKK7Ke9JMn2qmu4RiI+3/7qpytx0v4NwcuYv2i1yLUpY3Jh6Pjn
   w==;
X-CSE-ConnectionGUID: vKr+qmz3QCyTQY9UDuhSFw==
X-CSE-MsgGUID: WeKEk7bdQWiLboMUL6gbIA==
X-IronPort-AV: E=McAfee;i="6600,9927,11073"; a="15564187"
X-IronPort-AV: E=Sophos;i="6.08,160,1712646000"; 
   d="scan'208";a="15564187"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2024 22:15:50 -0700
X-CSE-ConnectionGUID: xT8Ez7cHTLaIY1EuX44wVA==
X-CSE-MsgGUID: eMhrojmsTtGnzTAHDuPCdw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,160,1712646000"; 
   d="scan'208";a="30756705"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 May 2024 22:15:50 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 14 May 2024 22:15:49 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 14 May 2024 22:15:49 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 14 May 2024 22:15:49 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.172)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 14 May 2024 22:15:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K594UA9GfhR14e5bdNLnrVX1tbgMvEIx5pu1mVWIUlXjYGjBycpfBgCiiZsm2jT/G9unJ11iKe3/kQN4hQ45pbo48x+pbSe5cH9IDPS4nEl/MTtmOhbbI0PodE7X4MtGkZHyo+9fcGErBjoR8UrBuHkXpVddaM+IzfVA7mQplxWDEnPON06zWP5w1M8VGWdZUMaoCFeogfIdrjnLtAUX7g/cB6WcPVri7MHUMiR0484wUrmOQv2nClgWbjEVAZNBMJZRN0wshMTfc3qrqkRRES4HAWv8iuu6EIDZiQo/CxI4/fnOm7w5qVSdH4Z/j7ISpaWH4a1CEZ15Snpb2k/s3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5+5uv57hLqc0j4vHJ82JlKuKHTmJJGkbwPF26H9hX0I=;
 b=AC2RCV0pgF7XO2GuN2Jqr2nciYWRk8GeKCfxepWx71iFe8UN6pntcjPplhr4LkQae7s8kaUXnMkzMGv28kQkP5y03atXyg7YUREEzWZ2D9KyLtiE3HXhHnzoWVHmmD4lZfND+hphT/jw8jJRZDjeqPW8LOi+TDhGo43k2mlJxuz6YBII+vhm9CV5aNCUJBkeNdPA/YtpONqmCT9p8A8DPQGqaQcpANVJA7rQjQc/7sQrWGBUBfEej0hjIU0hx2wQwNe+NUw9B+EsplBRse1bV9QMWwDJmxJ3dwF8YMCAJEDRWbk+tOuKPDAnum3FIS66lmFLY8bgQsVFHtJ0XKtWPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4839.namprd11.prod.outlook.com (2603:10b6:510:42::18)
 by DS0PR11MB6375.namprd11.prod.outlook.com (2603:10b6:8:c9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Wed, 15 May
 2024 05:15:46 +0000
Received: from PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::2c61:4a05:2346:b215]) by PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::2c61:4a05:2346:b215%7]) with mapi id 15.20.7587.026; Wed, 15 May 2024
 05:15:46 +0000
Date: Wed, 15 May 2024 13:15:56 +0800
From: Pengfei Xu <pengfei.xu@intel.com>
To: "Kuppuswamy, Sathyanarayanan" <sathyanarayanan.kuppuswamy@intel.com>
CC: Shuah Khan <skhan@linuxfoundation.org>, <shuah@kernel.org>,
	linux-kselftest <linux-kselftest@vger.kernel.org>, linux-kernel
	<linux-kernel@vger.kernel.org>, <jithu.joseph@intel.com>,
	<ashok.raj@intel.com>
Subject: Re: [PATCH v1 0/4] add tests to verify IFS (In Field Scan) driver
 functionality
Message-ID: <ZkRFDEgjOg0whpVa@xpf.sh.intel.com>
References: <cover.1714447026.git.pengfei.xu@intel.com>
 <d3e4761e-a44a-400e-9aea-df5322169c87@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <d3e4761e-a44a-400e-9aea-df5322169c87@intel.com>
X-ClientProxiedBy: SI1PR02CA0043.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::19) To PH0PR11MB4839.namprd11.prod.outlook.com
 (2603:10b6:510:42::18)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4839:EE_|DS0PR11MB6375:EE_
X-MS-Office365-Filtering-Correlation-Id: ddeb6809-b987-4f5a-0750-08dc749e13a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Ix9BG/6Dfy01uslQLYgH/iA4vow3v2qPHxnY+kv4yjipUhx49itlIVT433sx?=
 =?us-ascii?Q?JvwOO4Nv+yScfmAYNdgeVLf9yI6NKiSDuhLlpanLff82BS/+b0/Wb22EqyjQ?=
 =?us-ascii?Q?rOkWOTCwO1XbLyx0d8Ot/NsKomXOLlO+PYgSfZBktA+VG7FS1Wo5I09gFIvp?=
 =?us-ascii?Q?k3gUXFx6EeLj7PmsxqRhTf08yMVH+YMy3d0IruMoiqEa/hWPfyOkFEgHWThh?=
 =?us-ascii?Q?qvnF0E8sdc3uRolcNEtZ8ok0BpPHYQX8tTZrcoy9iLwLhkdkOnnaniIJs8G/?=
 =?us-ascii?Q?HonLLuBbyL6BmbVnTtPioW3Vg+ALGpl/dg3a0NiZVfeG+tioQUNVSa50e/gM?=
 =?us-ascii?Q?lddEd7FGBFs7tJ0ZBrZ4FNKE5Akeu4mLwgFLg8GmHpV69sKaRwqUPVnf3UhK?=
 =?us-ascii?Q?IRbEviJY4eIfNgwlTV5dDUU5T8NRT2bj6U6EyZnEOPYNsedbyeDKyNucjhIX?=
 =?us-ascii?Q?wEFqWF+QoPxy8ID3a7TX2jHWy2vt1xeKtpYtou3X26IhsE6He1DETZpQv8Ps?=
 =?us-ascii?Q?FwumoadGeny7PLuX4sGiTmxY6aZpufBwmObZqZ1UjmKA9g4lelFY3BwEQIl6?=
 =?us-ascii?Q?NeuawN9dapCpS+8Btiz3gpLerKEspQ3ejQUedGnGocjgVeRw2lhQN8c3jfkN?=
 =?us-ascii?Q?RpqjJZR2SR3uLW79Oy1bwM78XdUNfMgj2LFBDHez/S4aAMi+A0n1x6nY7dds?=
 =?us-ascii?Q?ljLaCm2ynlKsn7MaT3KBq+HSK+PV/KN8dE5g1e4kty6RnkiJBDTOb3H0ED0G?=
 =?us-ascii?Q?NJSihTKOWmof3FMjaO93xBy3quAnfRxDzfOrcVEdMKMrzeonhpWdpa0Eovl7?=
 =?us-ascii?Q?2OjPLSdknMfAaqxm0Q2/MPTgkD8VxzXVTkcaCy0g/WDQfiftjOVM2LX9SoqO?=
 =?us-ascii?Q?t2wilu6y2cH8DdBUKoQwTqmp08F6S/lJyGqngOr8u0LMtUiEJgoMHEr3kYW4?=
 =?us-ascii?Q?73/gFvHh5HvPcZ5cswBV7HH+LyDrdiexnjSaTjhCCXNJNFtlB59EHvshWSqK?=
 =?us-ascii?Q?t8zIEh4xQJhunlxGKntMDfnDAKGgRsFExGUgno3a57NuDNtDP/KTLM7u1zYe?=
 =?us-ascii?Q?I26OpDzi9D/LcgyN2qM7q0PFOKaJGYfE5LVYSDqF6f4aznao5HTdbrq/k+Fr?=
 =?us-ascii?Q?yK0xFp+RK5XANEsjGD2qbvRRrQObL44zRq59bcipaTeTXaKkABmLo2CbEaFL?=
 =?us-ascii?Q?37TKbkcQh2jhLlSM+usxJdzEAbsiWA0YMIjzMGm3ZYSqlFVpmeVyEDOiXug?=
 =?us-ascii?Q?=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4839.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LGnnjrSOcviIgTycBKr6PrRUdpe5BCzJqeTC3MYqr5qkCUImyGarTn2pf1Bg?=
 =?us-ascii?Q?aOAeqP9yaEsxb7yXjNq1Su5odOxNgLmIjQTkOzW9omg6GVtRAD3fgQXbC9tf?=
 =?us-ascii?Q?VPywYBd7q1vd4LPI21cy+7zUofM1tfCpLuMqln3yClXDDb+mJdc8mTVqykIi?=
 =?us-ascii?Q?CwJMgPTcAF4ri9b2Xs7TwrlXyw2nQUycLWCqiUHY490cJghBqrjGRd7YNy7t?=
 =?us-ascii?Q?hfYJUMOOg8IQRJlZuGvVTjf5p932wcNSXAdmP600XL/Qxs+y/EpaSeNYRR8Y?=
 =?us-ascii?Q?gQGW7zos4+8OGPsS2mBBcyhBq+QLI9zYQ/bS87E970lbVds3sZoVI7HpFzGV?=
 =?us-ascii?Q?U3jXyQ8otbMhrQCcyXYffnfJ4OZ7gwk6k6MOZr51Gbtjmb/nE15N2HawG/MT?=
 =?us-ascii?Q?3AVAoQiH//cVt+1pX1hiHirvl7gQR0NXOEABolJF2pkFyRWz85SZyelq2hyN?=
 =?us-ascii?Q?CbhWQdtn9BDLfgJFZcpgqf9suI3mMyBuR48cR9jJqbcJivewo4KDjY0NoXT4?=
 =?us-ascii?Q?VOuY8orDNzGjiv69YpGQraPUtJ13NEAtYsMIjfkwYbJFhv0l8gIZMt5yVFlg?=
 =?us-ascii?Q?SKbLNeT4j9IPo4/tOej6HUvwBCPc8yALYh+VobknTT6RVwWEMF9bsxFpAQBS?=
 =?us-ascii?Q?I6FlmmUmH9tBhCvan1lZRYSwZromaTwWFT/T/wcxBhZ1NK61/mnQ+WeTQC83?=
 =?us-ascii?Q?zChAVasiTMhRWaHKxbnXwpwrzKm2txATE2dJvAO3Y1I0K3L530vZMMsjgGMR?=
 =?us-ascii?Q?2bXOGresYTKHsnIBw+BgNZJsdhXp7Psv4IHTEm3F/lAAp6QsfYIm+x+Cu3FS?=
 =?us-ascii?Q?cDwJLDo4KIHsEFkHeP0RisEEsjRcm92VxbIlDatjS/2NT5U/XuS2yhIjRXPw?=
 =?us-ascii?Q?l3skRuUffzPFJwV9FR9E4n+kgtUIG5v4AGcBZhSdH183c1IUQvTDI3UngLXT?=
 =?us-ascii?Q?QPlZy1dYaZ61ceW7AxGBSN80ZqSK2Vt+Am7wgGhS44aj52nZ98k4kKf6Lu/o?=
 =?us-ascii?Q?NYCwjb5BnDsOVXVFOb7IWvMcJzN4EBwV6FSN3BiZIvmrKbeTxbsAU8A9dzWb?=
 =?us-ascii?Q?lc7exT48Yo6EV4B8jZBeb3ze76cBsCBnUX4zsCYaQ4xocCyxhqNCej5lwMuM?=
 =?us-ascii?Q?GsnnQ02bnN0mq+q/01uzk9/uOOF+0Et8DPiMwsq4wHEzd/B3auF6aDGXqt0G?=
 =?us-ascii?Q?5k36IXt4KbUaeqybLgyD7qjPZWoKX5yaLrWwbrjwNhCJIrrj1Htft8om0osp?=
 =?us-ascii?Q?fhJuYI55N4lQheABrwhg12c41qGKRE/Y/M8G8ZF2bY5b42HBgwRVgD6B+ezc?=
 =?us-ascii?Q?mDfJYhX+LrAKykpo3r9VwLoZSmvYadu1otGFGE6ArLo/emJ75PxYYgdONf9l?=
 =?us-ascii?Q?iZ6GvLXM5L+bYF8NZwR9p3tc4sJTUuTlL0EMWPKtSJMNSkygvUwJg0uOvu4Z?=
 =?us-ascii?Q?smRu4tAZUbeqAQbos8zDJkSoI6wiii/Is2pg03H2/5JbZPAoSDGP+gimwv33?=
 =?us-ascii?Q?dwIIz0Ch6qVUN2BN6JCs0CVDgbpZBE2iPwrpxC0tkElCt0LJlQgrwkqltIFJ?=
 =?us-ascii?Q?K1n4mUCkRYE9xzrWrVJz+huHwYN1Yo2LxNLA+Y90?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ddeb6809-b987-4f5a-0750-08dc749e13a5
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4839.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2024 05:15:46.3910
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xgSbgMsBPWfBt3nkpLU23A4oeWTGIzTCGVebnCFq+35MMYVceV97WbRjNWW+NUkFqZO2Pp7xFrTOMKzND/84ag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6375
X-OriginatorOrg: intel.com

On 2024-05-14 at 20:55:11 -0700, Kuppuswamy, Sathyanarayanan wrote:
> 
> On 4/29/24 8:31 PM, Pengfei Xu wrote:
> > To verify IFS (In Field Scan [1]) driver functionality, add the following 6
> > test cases:
> >   1. Verify that IFS sysfs entries are created after loading the IFS module
> >   2. Check if loading an invalid IFS test image fails and loading a valid
> >      one succeeds
> >   3. Perform IFS scan test on each CPU using all the available image files
> >   4. Perform IFS scan with first test image file on a random CPU for 3
> >      rounds
> >   5. Perform IFS ARRAY BIST(Board Integrated System Test) test on each CPU
> >   6. Perform IFS ARRAY BIST test on a random CPU for 3 rounds
> >
> > These are not exhaustive, but some minimal test runs to check various
> > parts of the driver. Some negative tests are also included.
> >
> > [1] https://docs.kernel.org/arch/x86/ifs.html
> 
> Looks good to me.
> 
> Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

Thanks for Sathya's tag, and thanks Shuah and Jithu also.

Best Regards,
Thanks!

> 
> > Pengfei Xu (4):
> >   selftests: ifs: verify test interfaces are created by the driver
> >   selftests: ifs: verify test image loading functionality
> >   selftests: ifs: verify IFS scan test functionality
> >   selftests: ifs: verify IFS ARRAY BIST functionality
> >
> >  MAINTAINERS                                   |   1 +
> >  tools/testing/selftests/Makefile              |   1 +
> >  .../drivers/platform/x86/intel/ifs/Makefile   |   6 +
> >  .../platform/x86/intel/ifs/test_ifs.sh        | 496 ++++++++++++++++++
> >  4 files changed, 504 insertions(+)
> >  create mode 100644 tools/testing/selftests/drivers/platform/x86/intel/ifs/Makefile
> >  create mode 100755 tools/testing/selftests/drivers/platform/x86/intel/ifs/test_ifs.sh
> >
> -- 
> Sathyanarayanan Kuppuswamy
> Linux Kernel Developer
> 

