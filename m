Return-Path: <linux-kselftest+bounces-16907-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95D56967697
	for <lists+linux-kselftest@lfdr.de>; Sun,  1 Sep 2024 15:28:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E27A1F21F1F
	for <lists+linux-kselftest@lfdr.de>; Sun,  1 Sep 2024 13:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F3951779A9;
	Sun,  1 Sep 2024 13:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g4kKVZwV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D8E216F265;
	Sun,  1 Sep 2024 13:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725197290; cv=fail; b=E5SPmuaKgehJH2CNbnQ61ttwsprlDN10bnVjShxE1U5F1G82CG89wPva2E7YGKp8ni/monvVgltPluo92VlEnHEo+u18FSlfhwY3eH5tiOKKLHuOtGB/a6Nd+bLKnz05t3r+dpMCv2bb9+ygd/2a/l+xVL+W8Q3wS6uJm7NGHPs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725197290; c=relaxed/simple;
	bh=WYWipFXwAsmhBkWFk5jQHzi36sOuvvfRsddFfniMwsY=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=g2VSGxaeAfq0ac4nZGgIM6v05BqpOn51CbW14XQKXY6061+xHc2/Fs1Ze2MShDrltl433F5Sb3CIekhUQF9cJDnUqidCkdh1VzZIu1Ru6nXzmQu1dzqrqRog4SCgUD9QhaJoeBGwmWM52+KrG28M/TkHjUChssi9Z3DKlkWINMI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g4kKVZwV; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725197288; x=1756733288;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=WYWipFXwAsmhBkWFk5jQHzi36sOuvvfRsddFfniMwsY=;
  b=g4kKVZwVXWHFcicis+h1t5B6wwFBI6Lpx/fVXQSkBY/EWpAJiLxrriDE
   jm0MncIbiILskJrMj/xFA480WJabMUzLDKj8CSYyt4d/SggqF9dXUsGAH
   BGDiLl3OeK5C71ki6nwjLszWmHhkzN+hb/nJnkLli0YJfR5s/GIdSbg5E
   ryw81p3mObo2Phj/VUsM4GTjGi/WJn6KmJ7zUl9GSB6MEkMIa0ZA8GskH
   7uLPAkRCA5WMIHF7O443PqKAxg7AAy59+rtrq4xdgyhPo4RzIVa58S9V5
   Zn2iSjEztTbIe55iYBXhivKvy1uV+lsR9SfCjkzamf6O+LwzjEN2C4cs+
   g==;
X-CSE-ConnectionGUID: rRKOgTeQQBC4e8DbnHhg7Q==
X-CSE-MsgGUID: q26eXY40TVODVWtoKsPvmg==
X-IronPort-AV: E=McAfee;i="6700,10204,11181"; a="34350342"
X-IronPort-AV: E=Sophos;i="6.10,194,1719903600"; 
   d="scan'208";a="34350342"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2024 06:28:07 -0700
X-CSE-ConnectionGUID: oYjBL0PuTS+Jb5371JQs2A==
X-CSE-MsgGUID: ZfeLMWViR+ObkMeKCKLyog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,194,1719903600"; 
   d="scan'208";a="68749946"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Sep 2024 06:28:06 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 1 Sep 2024 06:28:06 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sun, 1 Sep 2024 06:28:06 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.172)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 1 Sep 2024 06:28:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l/UAtiUQ+DA2DY+Z0zo+/VFe3UE/KfxgxglINr7+DlzaZ3bFAHighx19q9ALgNx6zNkgPCLM7PFt0C4V4JVlAt22SSiUJ4v5Pd85UhrKiyJbFAJLqN9QSJR266HfjijGVhi33ugndJla4R0E6hvUFSonb+faNEAX1Si9x/LkJ8tpgZakAv7jOcKs1MEsiffdxuaE5bD1ff5nP9aoEV/fxarVmw21/lPvq5oRyO8YVAyVA5ZhBi0JWvPn8x3intO+lNNFN5EB9+cEPjKwbvKQ15GPvh+ZOwi95prXKNEfKR9hmHLSi67WBcHZ5KEHwVUvP5daLS7OFq09/skPLrIdDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ut0lZgBnKWSHjHETEVIOY7c9AalOmsK5Z326ZBCwd+w=;
 b=e8/CcH0p8wxkH/A0Yv2XCN2o5s7Y3bmIWd2RLAbAPOdbaUpXPILjtWe1o21FFDanvRjBE7gZJETUnTn0HrJvT2xfWs4FDKTDWr4bAUDxrv6I3rckhISmbr13FjHVbYpfrjtVX2mwlL+42/ByCrtbyweoPq1T0m0hv3oYN9m5fXmkS9S/3Bzh8w/A/a341qD8YLAJ2+OGTMFYc+tyK8gx2/6+ncROk7LxlE0CUBYXmNFty89w2lpF2Y21wvcINvkD6lrq5YZw4HsKA4q/NVhZHu/yxA21xsyyxA9+7l97yi5n66th1+Ap/5CQNxoCIFZsWQVW387rcIuI6MChiQFjkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB5423.namprd11.prod.outlook.com (2603:10b6:5:39b::20)
 by MN0PR11MB5987.namprd11.prod.outlook.com (2603:10b6:208:372::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.23; Sun, 1 Sep
 2024 13:28:03 +0000
Received: from DM4PR11MB5423.namprd11.prod.outlook.com
 ([fe80::dffa:e0c8:dbf1:c82e]) by DM4PR11MB5423.namprd11.prod.outlook.com
 ([fe80::dffa:e0c8:dbf1:c82e%5]) with mapi id 15.20.7918.020; Sun, 1 Sep 2024
 13:28:03 +0000
Date: Sun, 1 Sep 2024 21:27:52 +0800
From: kernel test robot <lkp@intel.com>
To: Christophe Leroy <christophe.leroy@csgroup.eu>, "Jason A . Donenfeld"
	<Jason@zx2c4.com>
CC: <oe-kbuild-all@lists.linux.dev>, Christophe Leroy
	<christophe.leroy@csgroup.eu>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, Adhemerval Zanella
	<adhemerval.zanella@linaro.org>, Xi Ruoyao <xry111@xry111.site>
Subject: Re: [PATCH] selftests: vDSO: Do not rely on $ARCH for
 vdso_test_getrandom && vdso_test_chacha
Message-ID: <ZtRr2MJ2Qzf4xQn3@rli9-mobl>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ddf594c81787dba708fc392cb03027470dee64fb.1725124064.git.christophe.leroy@csgroup.eu>
X-ClientProxiedBy: SG2PR04CA0154.apcprd04.prod.outlook.com (2603:1096:4::16)
 To DM4PR11MB5423.namprd11.prod.outlook.com (2603:10b6:5:39b::20)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB5423:EE_|MN0PR11MB5987:EE_
X-MS-Office365-Filtering-Correlation-Id: 38a8d3f1-e16c-4640-8737-08dcca89e79f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?oQR5YTF/YxzWwYbjeiTLL/QJSVOQ9QWKBL00C9O8u6xBATK0DQwXoFA2Ns1u?=
 =?us-ascii?Q?gFhVhNmhIBmQfVlrfl6p/bd6Wt3oTO//mM/eo01JqqHPAgBHSM5/WLwPEqkX?=
 =?us-ascii?Q?Dr36S3aqPG3jjd3yWrfkRYR19P2geC7r3uGWmBWHju66yozp2HRxqHgPs5TI?=
 =?us-ascii?Q?LUtGe2jrpY891dhN+0vOI4saZPQTZvjMTDP5i0wKfSkbLXfAFjh8BK7NIakW?=
 =?us-ascii?Q?AzVxtzWcbEGJctbLHNu/O5BHSPaTUKT1Bc/AsB0xN6Tc4q3BhHR/1ckqwreq?=
 =?us-ascii?Q?bfB96kS9H24EuTmvpFBFPSrAEpXp6NLROndSFM4raLsXDEgw9PC8qLFCT42o?=
 =?us-ascii?Q?ZHTONy+Vl1ZV9ozwvL8tvk8PTAa/LfAt3RbnBIuORWqkqLyCQqYMEJuAqP8d?=
 =?us-ascii?Q?deU2n60F5h+LhNNV/lQ7XmAMmFOQNbzNN4i3R97jkdPPdipuRUB1lJ2U2XQS?=
 =?us-ascii?Q?XHkcz9pity6ivv4zGhF6SsWubSf0TufOzXnaEDMYZU740evLgmTsLy/ZMVLB?=
 =?us-ascii?Q?WZGsR3/S3Sjd2MiQyTgeOckCSdcDx2BfT5s98wBA2w7DpE4rVTPTLY/HmRiO?=
 =?us-ascii?Q?cRSErals0wuyM9LjTWAhp3hviI5jJjuRxQABgMta5z/uZdXPz7YvzHVjVG64?=
 =?us-ascii?Q?uwo3BpBd9SVoD4hiJyl9NiHf0vzifb33Ipodpnne8ABi2/xvQMwTfyfKCz9N?=
 =?us-ascii?Q?EBYZncMEshbsiDGvwFqhG5oWT2uQUfV6HOpMHe4OZJZrMnHPbdoLIci6XnbJ?=
 =?us-ascii?Q?Vz8Xxw87T74B5L7qjwpD4MCMqXdZcoIpJAFc0MHv+iVxkcEVaKN+MvU5ZM0x?=
 =?us-ascii?Q?zC6BrgMeQdMCMn8WDOeHIqw0xYd1bw2cAJiAoxx8VzdoklKs0LC889hjl4V/?=
 =?us-ascii?Q?SyjTCEWOaOjrUxAPSHpOhdGuzEzkTcFhntH1ARpm3vt3ROfK+90Qostf816F?=
 =?us-ascii?Q?2DiUurbY2BndK2VY/0gMn40Usmixeo8gt0oA3Gin42ZUAsZrWnQpQoLHfCAz?=
 =?us-ascii?Q?AuNg7aeltXlZsUD2Ffa4UJ2ur762+N7A6MsNrunFgR7YXaIc8zhGiM7ZS6W9?=
 =?us-ascii?Q?mujQFIfBlRgQTn+jVfJC4d6iJZSfiA5sl9GfCwlxnpJnFGpzRZK6z2IxoWye?=
 =?us-ascii?Q?CsX49LK8CT8oKpwDQRHC/Dn65Ym/cPtR4WmxG5TcNeaPN5Sb4kfe9SWC1f0U?=
 =?us-ascii?Q?Ht4iF+DJjeH7W/4RRmW91Y/UkszVeVWKT7OuHeMpxkHV3LSmndUeCnDik2kl?=
 =?us-ascii?Q?b0EnETEqdwCMqCRE7v2wcg4Sg7fa5MnxejGr5+3ACX0g87ki4dSJtauwErJh?=
 =?us-ascii?Q?eXc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5423.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?31AbjiJXNyivMTNqRpuORIcMEJn5NLAlavadRg/OqPgPw8gRExOLGKc7Ft1K?=
 =?us-ascii?Q?BZ95z+wH0t7EGXup08ey0l5Oo0qhGzgfJ5Sj2ClQBQxnsYSg1C7mSt+WAg7v?=
 =?us-ascii?Q?rSEXhfiIAPKRWGHf066wKHjLa9Dv912HSwxwGzaFD/bx415QHk9/dcOgZ1B/?=
 =?us-ascii?Q?bY4DEnguy2K7g1V4ctK0tXeAGXp0A+E77AF6ZDYrxVhFsYKgxAPgoBSgtE6R?=
 =?us-ascii?Q?Gubh4S5Tti3/S19GqkIl3CT/6TYrjhVrfqAPa9bV7UDLuOHk/eeb8s4FidfP?=
 =?us-ascii?Q?H99kUS0oBEwgBFwjUWqrJLeXQJ7RFEZDGiEDxH7LXp3FwWVqav0QWVBDyzGq?=
 =?us-ascii?Q?anoBhPKxqDIbmZDSumu5oj5stN7qZrp0DbiFhX0BzLewwSMPwCBUKTqpcgeI?=
 =?us-ascii?Q?FZgpJ1gchnuBQVnim3o18C3p6AGYRYIYNZMYGqWbOALE9mn3w1GmzRClEOQi?=
 =?us-ascii?Q?QkgC8OrrAz48qA0/ePWMyVhiRxFjtjXGR4UFQKnJUZ5bmF9Q9FCPaWvrn+k2?=
 =?us-ascii?Q?Mu54aig7DpcoLxOxHAPHwgCm/UKPyeEnT/QEngAxniPyQOmmXrA/t5MjT0aK?=
 =?us-ascii?Q?OUquKMU+AlGMl4sChVgZdL47GAA41BdCeQ6BgKa0EBIK5JTTr6H6okZAadKI?=
 =?us-ascii?Q?uOLQAOKdXbJhg6z8/mODtBf4GCH25MykRvAYboX4opnJ7QBKqe25+PgUp/Ck?=
 =?us-ascii?Q?8yMtYBFHdCDNbG+MQzPDNLbJG29htR01c4Eb+GHfmP1pRMCdC9p0J7yxUdrC?=
 =?us-ascii?Q?TGkrZ5qAlSvaLQdXKj6FcxNN10QV74pGWN7KzDtti2MwH7XOLoL2iD9u8coL?=
 =?us-ascii?Q?t8bcLXkN/WpQMowz6b1xdmPDhXxfIKnlc6YFb++AJiZxSYEvkGEeCox0wLQj?=
 =?us-ascii?Q?gTlg+OCyIM5vcKRinsRiCSqvRJ/EOSiG68vE6h/aBW04h5Rdb1NHPQLmIRx0?=
 =?us-ascii?Q?uPx9NRTU2PbctSLuL6R/TClEeET+FRdX4JKbANdCfsIVgSUhCM8f0fmiZr8N?=
 =?us-ascii?Q?hqIDUmLQeh67PALYmo551uEaQzskK9b70TeWZ3FsQnPQCkCDBacFBfX9hh8s?=
 =?us-ascii?Q?NOtuDQTAQLkzyLrtc5/pCEQc8ks3r3+c/Kib/+8/TmFsd94IsE7PtrYVlbe9?=
 =?us-ascii?Q?DSUvp2roLyT2rhkUDGoA23lt1sFEAUQto4suQXmkszKFvKknSQiX6KPvgN/P?=
 =?us-ascii?Q?8K+ZJ5yf4dhfJR1NZpAWDqiiOgklJD+bIElwDiZrFS3KYb4u1JprmyOfjiHi?=
 =?us-ascii?Q?Rnw/hj86sW/CFP0hVKK6iIl9HYn94p63Dt0pPi44NgDz//kyc5iTAaGxk69D?=
 =?us-ascii?Q?blslp/N0XG0Jgue8+UGWo0edxaupAc0UYzwGKLXGTcsgIKrad1LxQcwm3wjF?=
 =?us-ascii?Q?zWgA24vYA2kLyd7BR2AxjxERiY2Ou2/tGDrdDiI4YIrCuj8+VWszybqWJ8ed?=
 =?us-ascii?Q?LTdWYdwVvDagg+GhCMDtNcMTVqMYsY7puVu8mB4tbFL71oTLjslWhTQ7D43K?=
 =?us-ascii?Q?kKQxt6iEdGZ7r6rJgKPb28noz23EYKiqINj+k5tWGSS8wl+zalIXlzf2ci17?=
 =?us-ascii?Q?eLU5QkcSWWIXxRJyRI+8kmvKMtLvSldZAHAPzAI3QXxhoF5XUC87GcOuBKwq?=
 =?us-ascii?Q?qA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 38a8d3f1-e16c-4640-8737-08dcca89e79f
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5423.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2024 13:28:03.0982
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ChhXVk2kpcZQEcWDidfQkCIdDInFuLrQAR0MHQuukxQRork3F3RCXVFOofphrQtSF9Hcth5jtgjmgd1ZJO14Gw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB5987
X-OriginatorOrg: intel.com

Hi Christophe,

kernel test robot noticed the following build errors:

[auto build test ERROR on crng-random/master]
[cannot apply to shuah-kselftest/next shuah-kselftest/fixes linus/master v6.11-rc6 next-20240830]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Christophe-Leroy/selftests-vDSO-Do-not-rely-on-ARCH-for-vdso_test_getrandom-vdso_test_chacha/20240901-011346
base:   https://git.kernel.org/pub/scm/linux/kernel/git/crng/random.git master
patch link:    https://lore.kernel.org/r/ddf594c81787dba708fc392cb03027470dee64fb.1725124064.git.christophe.leroy%40csgroup.eu
patch subject: [PATCH] selftests: vDSO: Do not rely on $ARCH for vdso_test_getrandom && vdso_test_chacha
:::::: branch date: 20 hours ago
:::::: commit date: 20 hours ago
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240901/202409012034.hcMbZCrE-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/r/202409012034.hcMbZCrE-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from vdso_test_chacha-asm.S:5:
>> ./../../../../arch/x86/entry/vdso/vgetrandom-chacha.S:7:10: fatal error: 'asm/frame.h' file not found
       7 | #include <asm/frame.h>
         |          ^~~~~~~~~~~~~
   1 error generated.


vim +7 tools/testing/selftests/vDSO/./../../../../arch/x86/entry/vdso/vgetrandom-chacha.S

33385150ac456f6 Jason A. Donenfeld 2022-11-18 @7  #include <asm/frame.h>
33385150ac456f6 Jason A. Donenfeld 2022-11-18  8  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


