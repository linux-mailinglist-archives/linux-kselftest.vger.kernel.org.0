Return-Path: <linux-kselftest+bounces-16369-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A02E896021F
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2024 08:46:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2D3EB21CE6
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2024 06:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C57A757FC;
	Tue, 27 Aug 2024 06:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ga+/d4F7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A291E10A3E;
	Tue, 27 Aug 2024 06:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724741168; cv=fail; b=OPBqvfENLW6BvCyr4P0t6LQJwcFy8VRo+PYmqs9EgFKESAZsOR923JCAoH3spsM2PF9uRHG60cwKRBrKv2HlAQ9kU1HA/vjN7C+D7yB4aKdpO9i9FKzDD3tFRpArSEsfjbJ2l9VwuT3377cMJCXc36tFOnJSbtQCZ+peaFXWGZY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724741168; c=relaxed/simple;
	bh=RsTrqO/nD7QIWRbAG2ua22BT7GVYI/r7X9IAJZYcjxs=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=IpU2IBjjRXrweR4g41Ac1X6K+PgXtHLBKFMmN8qvO+MGFjHk6KjI4dyMarsxq/5N2KFF2CXlqsfcZEpZMmWIqgST9oro4ijgiYmU9IQ+EebBHzDDa2AcIhYInSYS4kyKWRdq6QkO6dgSQtB0iQ7tr55ib0/DOVG8TqlZTiCU8Fg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ga+/d4F7; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724741165; x=1756277165;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=RsTrqO/nD7QIWRbAG2ua22BT7GVYI/r7X9IAJZYcjxs=;
  b=ga+/d4F7atjE+XLzVM8Ge7ZjE1L4TX44msWwdcpQtCjxuyCd+xtLx1ai
   /aEbuNCYuuXX43+brBbPS29Zm34H79Qd8EcP8pkiK2Nzp4vlWdJbnZZUW
   awlXrRP5EnYN0vBIs/aFQcgrz4V1vEyzjZH4c9o81xjykw70AIPVYIMzF
   icnpoh7BXeNNJQD9nxTp6bsuVZTnXdg22O0ryx5vHc/hgPqVFphxxKYFW
   KEIZRtGXm+3Cl5GLBYQ79neEtI6O+WoUr1KPTJ3LmKr37qhEPVBWhkAWx
   nNhr0t34SZzcrZJC5LfirT8ukpzwKVw85Lr9UdJ4TH45jFvgIABBNOgQW
   g==;
X-CSE-ConnectionGUID: S3o01FT+QiuPHxwyAtLHPA==
X-CSE-MsgGUID: 6VIvUZ7XTe6nFSwpdhos4A==
X-IronPort-AV: E=McAfee;i="6700,10204,11176"; a="26993994"
X-IronPort-AV: E=Sophos;i="6.10,179,1719903600"; 
   d="scan'208";a="26993994"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2024 23:46:04 -0700
X-CSE-ConnectionGUID: ZXcWecQVQuyWbwIxdHFRzA==
X-CSE-MsgGUID: MZIVcx9tQb+JotSjtsgp1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,179,1719903600"; 
   d="scan'208";a="63275361"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Aug 2024 23:46:04 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 26 Aug 2024 23:46:03 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 26 Aug 2024 23:46:03 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.175)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 26 Aug 2024 23:46:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=owjn8pnWChojQp69dZvk3g2AqUivLut2YvmvHwpkwMT2ufP1uXfq1l4m0lcustdzjwj5rvS/aJDthSE7saohggGtxRtYLMNWWUdWYOe7emfr3/Kof5RtuJvBmGsuckosQ29MyDtbdvvwLAyrbx3yc75Ez1sjvMLPV8okivjxhUQfrvvG31HzW2w2Wg9WbITEj1OkipuJ4wf2H/vZCnwNM7k6R1hrr59PqOdqQpk2EsBlvNPoXj6rYvKoMzlXmyp1qfAfDKyvhCpe1c2gO7qjME7+Lg1ggc+a7tVMkAcpOEOFIjh1E57B3kcq0DCQwIAB5dqPuJK00WYrPRAtL148Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=skb+I3PpVWmdgUNxpaaax1Qg51JW7sqR6Bw/J04uohA=;
 b=RNCemRFso3wp15PTrKiA2EQ4BO10deTxOZH4OLaqbesNoy563gCeWsMswLqI9ki70/3Je7sfsCi4ZwOB3mcD2CEPhxg6z0IzkRjM3rfticbmHJnkJl6FAKscYpwlzmTzu6sg5NY3Oz0tNZSUNZtYS9N2MGzIEc8lfKM/ZohlAyLcqcFKSsiODTOd0VdiGU5tkuvqsw5zIcvxH/dK+SDNOhH/Xqzi5Wtx2zxjftvMyhJv+euFkGMczqgcCM3xoC9LqoXXXGZ4w4tx9ckcu7TUTpHLa/x2M1/A9SIdHZ/7hAPe/la6MNR8Nc2+xej//XsIRh9sgC922xb78u5A0WwrfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6231.namprd11.prod.outlook.com (2603:10b6:208:3c4::15)
 by CH3PR11MB7273.namprd11.prod.outlook.com (2603:10b6:610:141::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Tue, 27 Aug
 2024 06:46:01 +0000
Received: from MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::a137:ffd0:97a3:1db4]) by MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::a137:ffd0:97a3:1db4%6]) with mapi id 15.20.7897.021; Tue, 27 Aug 2024
 06:46:01 +0000
Date: Tue, 27 Aug 2024 08:45:44 +0200
From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To: Reinette Chatre <reinette.chatre@intel.com>
CC: <fenghua.yu@intel.com>, <shuah@kernel.org>,
	<linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<ilpo.jarvinen@linux.intel.com>, <tony.luck@intel.com>
Subject: Re: [PATCH v4 1/2] selftests/resctrl: Adjust effective L3 cache size
 with SNC enabled
Message-ID: <lzt657mqtw5ga2eaz6ou3bb4q3wxquc52ist34k5dn5rxo54av@3hr55qnyouyz>
References: <cover.1720774981.git.maciej.wieczor-retman@intel.com>
 <e5f2fbe4f492d37569c389aebcb91168f98783ba.1720774981.git.maciej.wieczor-retman@intel.com>
 <a132356d-d129-4cab-9c71-723d40869eda@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a132356d-d129-4cab-9c71-723d40869eda@intel.com>
X-ClientProxiedBy: DUZPR01CA0001.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:3c3::10) To MN0PR11MB6231.namprd11.prod.outlook.com
 (2603:10b6:208:3c4::15)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6231:EE_|CH3PR11MB7273:EE_
X-MS-Office365-Filtering-Correlation-Id: 24e2e472-90c4-4d52-5d5d-08dcc663ea13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?J4wpyXxSdnFf3KH66EnqN5Hld25OwDXdcZtghKEVS7kxMpS6S7pUy1/D3B?=
 =?iso-8859-1?Q?srv61z39dUMfILnRRZ4fy+n3KnFWR15H72u4TkNbExUp+asM/zw7c/kqoU?=
 =?iso-8859-1?Q?46fqqBq5O0T/NWgNawxv8QoSITPgGeVtLXYyZTn0I6cSCUUGzs/BYnfMhx?=
 =?iso-8859-1?Q?Yi6fthzHcWPRAirAiqq9/oUmp292WLIFr1SGDakUeevGK6tuHNPsLXr+DV?=
 =?iso-8859-1?Q?4HP85wfJdrDXtWW7sE3388VwGqkkyTAlNd6qJZlo/ugFLgBKPma8JN96/J?=
 =?iso-8859-1?Q?w2ubSUHnbK4FLgMuWTGpC2LOZh3sATJrJ7CjiY6DMOij7aUMR0n2Ej8LYO?=
 =?iso-8859-1?Q?FqqR/CWQcSCcndkRy1HQkTWZAlBrBYcB+1I9UertmbDFhDZIwNYLwObPhM?=
 =?iso-8859-1?Q?3E0LKaUObK8BDAxtYYSkDFkzO256c0iwGgkTQ+3wgsQJ3m+/ZyR6u/Xnly?=
 =?iso-8859-1?Q?WK4q+zLqNHWRPXJHGGz2/1R5vfiAhibB8YbbLPFQvvmEAOI2E0R03ebnd9?=
 =?iso-8859-1?Q?dHqqY/rEpuKOGjVxnSQt3GVu+m7VwnMLJnAYeIF4gwTPMN8jeD7D4FKjn3?=
 =?iso-8859-1?Q?RqUIATFvHhIIKapr48OdAOFDjf5o80Z9Vt30atmbj2FMETO10S423ttf3u?=
 =?iso-8859-1?Q?HcynHXgZbkzo75P5Vmd80JJvPvPEZnsucW9FZFzC+XTza/udveL0CkoacU?=
 =?iso-8859-1?Q?W5Qxcyrpkb3JnrtrbRcgKgO1pR6dQVNZalP94ozJt8OGqI+zDVM3WqRZZQ?=
 =?iso-8859-1?Q?Q7cfBT5n/vGja/TPvJ/KC9kK8OYN2FyVaaDIW/zKmQJr0FwkPbcJjQEnUZ?=
 =?iso-8859-1?Q?S+VWicT3URN6xwEgjKc0jhgYaSqeCJu8I0dlx8O6L6VhKbnEe7g7i7Bmvl?=
 =?iso-8859-1?Q?Fe5bMd/Fa+e0FBkVf5imZj7T0uP7QiYRpjiBTheOC58Jn0OaLVMLo7qm4+?=
 =?iso-8859-1?Q?BVjwZU03nfSdnN8+5Eml1pCMMOayhGWlhMB9kPNX2C4CsNka8rD4OWqJSw?=
 =?iso-8859-1?Q?GSG+CBddMzlU6ZduEbn65dCIejikHHMNTmAioUfbmRY5hRYyGKA+h6y5jH?=
 =?iso-8859-1?Q?c5w0g03Y9uUyG/ZPG1wVKNGRlpZSbo4Ec+dgES5DTqeX69XwOVdxW8K1oj?=
 =?iso-8859-1?Q?OQlzJM065o9nVnxKgXXjvd94jtTDEIITJOtIbyOgdVLHVM5zaAZU1nC2Vq?=
 =?iso-8859-1?Q?iASoxc6ahds64yZxzmVEbL52TY3geOsr12yPQu9/yEBCrhfXtU8m+1Pyiy?=
 =?iso-8859-1?Q?0SSQ15FFdaNgptFZ2wKj0CgrNYWkwH59/fy5d/wUFKIbaMTLTp3kotYMqV?=
 =?iso-8859-1?Q?DNV9rAu9QK4oBxFVgFouKDAy518Xy9TMU5gLGZEqUQpLBym//ZPEfSR7ns?=
 =?iso-8859-1?Q?/0BfIHwfmhhn29ycntK0jbPzPFCjkRsQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6231.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?IN4S1j5S/7Fp/eDpYdG4sKiZZoDKLKTK/u6XwZJ0+DhtOG8znBGA3IwcID?=
 =?iso-8859-1?Q?69gb8tt9r5aRS/bCH5uV712mgdPwI1UsAEF3b/GckAKbXIo0t8NwoEsBfd?=
 =?iso-8859-1?Q?hyXPFdxWobe/dLi2Ldy6+JKyZ45ZRruNLflQ9iRTaGZ5ILnu/j1wJC4is2?=
 =?iso-8859-1?Q?Pzh9Rx3hoWsHh/ALRNiAnxpYtno5ja+Jy0UXFDDUlniiJ/kLhS5s7OewpE?=
 =?iso-8859-1?Q?IP+WjnPxOdwTaC1YchAKw1uxbkBAmA4EDQxEbqSfK/uODcNsWyIMiZ17TZ?=
 =?iso-8859-1?Q?Q04Bqi6GhSVuforBfoZnok6khVPqq7W6zG3AG8Ff6KYLl4EuePjIb8poYh?=
 =?iso-8859-1?Q?VAbl6E2MOHynGG9hQBHemCOsL3Brp7YEY6dAbPGbwBBRcFmc56Cl6PCqsa?=
 =?iso-8859-1?Q?HhwrIlJ4skihXnuO+cNrvj5Eo9YGK20sfZmvO4O8ScmKeATTWUl0o73BP6?=
 =?iso-8859-1?Q?EcJ59KFEBWTQuF7U67OeKX5OgvvyP1eavRt+uC9LkmAE4XgeNzBScSfQLe?=
 =?iso-8859-1?Q?P5Sp05I7z5QtlVt8um8XdjS8JVOTmH8QrpYJmwywI1You0dspzG7913DT+?=
 =?iso-8859-1?Q?27Asg78YnohXcQPw7fu3GcpFTQ16tNfd719VMGg6xjSVKafwTqumAbUPAY?=
 =?iso-8859-1?Q?4Ar2qjRYg1rAmSzzG/FOmcedaidxU2YDUG/ODvGZQuC3H3GtWnn/Myp/CK?=
 =?iso-8859-1?Q?S2EfBDZibedDlNBN87wNzghlQRkMbaq3kNZwlQPno/xF7HN0bFPS3eLVUb?=
 =?iso-8859-1?Q?Rvk1OFc1DUoGF2q2Q9tZxSUZRfssQfyvx+5tzJRww7f0X5vmYtKSAqjfcl?=
 =?iso-8859-1?Q?17ITQJct70hyK/MiM7MJC2Q7HjcCCcJi+BzW6ow65Qx07YO6BzRNK68Lrm?=
 =?iso-8859-1?Q?pcdc4UDgAaZLkgWcVKBLl1R/xlDo3gxFOyET6OOTZdamE2ZZXbsmU4jqfJ?=
 =?iso-8859-1?Q?K979EYH69cMb8myZwwtj+XnzvNigJWs6vj9pmgD03DJrkypCfqLmbirnUe?=
 =?iso-8859-1?Q?4sb6scyFRUsyxePwyfgV2SjovQQNVIaqi85+v4GkVgVvHWSj696o/Oklvk?=
 =?iso-8859-1?Q?JeVrtEv6de0/YkdNPgteaDP2oKpk+N3jIuJ53u/3LhivBIv3JGdAbd8sH/?=
 =?iso-8859-1?Q?U9qIZL51exURpyyqN7PbFcEVlHX9bQ+opyAwMP6qr12Ki7GJ5ouaLZmRFm?=
 =?iso-8859-1?Q?pFcWVk24ajScGwMSOG8e0biav+sfzd6qURRwo2w1LlJ71vg/RE4O3TjFs9?=
 =?iso-8859-1?Q?M4GuhRuwnSKflak4IewrhJxgZ4ljKr84+lrcJA4bwb0fRPId5n9UNaXWJQ?=
 =?iso-8859-1?Q?bm2rBupFw0cMvHLhNPtYAA/xdS4C9VhPu5bDsgTX5wrf8MNQ2br5EAVRGo?=
 =?iso-8859-1?Q?O6mBlt29xs1L8sxB2o9xxtzMPsmuZ6AhT27MQZpqcRwC9EtnHFnd0twzxt?=
 =?iso-8859-1?Q?Z10/K71VqIasjmKWyeu3uBKGPVfviGSd+ywA/qJju0HAp7Wcr+Qrk5In6+?=
 =?iso-8859-1?Q?r+9lEWhg+X2hsi26NXvFYrgZzM7LQSOFN8O4zVdG7ObSbpy8B40zkOvtbw?=
 =?iso-8859-1?Q?uIQqCqu5TER1mRVLDuBMzRQUtAn6wOGBloOgGrcPGaMpsB3lBldE86/oqn?=
 =?iso-8859-1?Q?cCozcxNEZ9TF4H63yFpIfaQrsxax1/+/W2xw60hwYrKfb7YKkzh2un15Lb?=
 =?iso-8859-1?Q?DOOP6o8G4CLo0zxZekU=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 24e2e472-90c4-4d52-5d5d-08dcc663ea13
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6231.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 06:46:01.2538
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4edDLY9dqxxpVAKrpQRBN5Mv+TXTevpw+AbA0jTkLpakOAvdsh0EMfYcuXoGFSG7OwWp1wBP7BTQBKVAQUEE0ADbnWL1IJa4Pgz38XF8Lpg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7273
X-OriginatorOrg: intel.com

Hi, thanks for the review,

On 2024-08-12 at 16:40:00 -0700, Reinette Chatre wrote:
>Hi Maciej,
>
>On 7/12/24 2:04 AM, Maciej Wieczor-Retman wrote:
>> Sub-NUMA Cluster divides CPUs sharing an L3 cache into separate NUMA
>> nodes. Systems may support splitting into either two, three or four
>> nodes.
>> 
>> When SNC mode is enabled the effective amount of L3 cache available
>> for allocation is divided by the number of nodes per L3.
>> 
>> Detect which SNC mode is active by comparing the number of CPUs
>> that share a cache with CPU0, with the number of CPUs on node0.
>> 
>> Signed-off-by: Tony Luck <tony.luck@intel.com>
>> Co-developed-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
>> Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
>
>Since you are "From:" author there is no need for a "Co-developed-by"
>for you. Tony does need one. Please check: "When to use Acked-by:, Cc:,
>and Co-developed-by:" in Documentation/process/submitting-patches.rst
>(checkpatch.pl also warns about this).

Thanks, I changed patch's author at some point and I think I forgot to change
the tags.

>
>> ---
>> Changelog v4:
>> - Make returned value a static local variable so the function only runs
>>    the logic once. (Reinette)
>> 
>> Changelog v3:
>> - Add comparison between present and online cpus to test if the
>>    calculated SNC mode is credible. (Reinette)
>> - Added comment to cache size modification to better explain why it is
>>    needed there. (Reinette)
>> - Fix facts in patch message. (Reinette)
>> - Change snc_ways() to snc_nodes_per_l3_cache(). (Reinette)
>> 
>>   tools/testing/selftests/resctrl/resctrl.h   |  4 ++
>>   tools/testing/selftests/resctrl/resctrlfs.c | 73 +++++++++++++++++++++
>>   2 files changed, 77 insertions(+)
>> 
>> diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
>> index 2dda56084588..851b37c9c38a 100644
>> --- a/tools/testing/selftests/resctrl/resctrl.h
>> +++ b/tools/testing/selftests/resctrl/resctrl.h
>> @@ -11,6 +11,7 @@
>>   #include <signal.h>
>>   #include <dirent.h>
>>   #include <stdbool.h>
>> +#include <ctype.h>
>>   #include <sys/stat.h>
>>   #include <sys/ioctl.h>
>>   #include <sys/mount.h>
>> @@ -43,6 +44,8 @@
>>   #define DEFAULT_SPAN		(250 * MB)
>> +#define MAX_SNC		4
>> +
>>   /*
>>    * user_params:		User supplied parameters
>>    * @cpu:		CPU number to which the benchmark will be bound to
>> @@ -120,6 +123,7 @@ extern volatile int *value_sink;
>>   extern char llc_occup_path[1024];
>> +int snc_nodes_per_l3_cache(void);
>>   int get_vendor(void);
>>   bool check_resctrlfs_support(void);
>>   int filter_dmesg(void);
>> diff --git a/tools/testing/selftests/resctrl/resctrlfs.c b/tools/testing/selftests/resctrl/resctrlfs.c
>> index 250c320349a7..803dd415984c 100644
>> --- a/tools/testing/selftests/resctrl/resctrlfs.c
>> +++ b/tools/testing/selftests/resctrl/resctrlfs.c
>> @@ -156,6 +156,68 @@ int get_domain_id(const char *resource, int cpu_no, int *domain_id)
>>   	return 0;
>>   }
>> +/*
>> + * Count number of CPUs in a /sys bit map
>
>"bit map" -> "bitmap"

Will do.

>
>> + */
>> +static unsigned int count_sys_bitmap_bits(char *name)
>> +{
>> +	FILE *fp = fopen(name, "r");
>> +	int count = 0, c;
>> +
>> +	if (!fp)
>> +		return 0;
>> +
>> +	while ((c = fgetc(fp)) != EOF) {
>> +		if (!isxdigit(c))
>> +			continue;
>> +		switch (c) {
>> +		case 'f':
>> +			count++;
>> +		case '7': case 'b': case 'd': case 'e':
>> +			count++;
>> +		case '3': case '5': case '6': case '9': case 'a': case 'c':
>> +			count++;
>> +		case '1': case '2': case '4': case '8':
>> +			count++;
>> +		}
>> +	}
>> +	fclose(fp);
>> +
>> +	return count;
>> +}
>> +
>> +/*
>> + * Detect SNC by comparing #CPUs in node0 with #CPUs sharing LLC with CPU0.
>> + * If some CPUs are offline the numbers may not be exact multiples of each
>> + * other. Any offline CPUs on node0 will be also gone from shared_cpu_map of
>> + * CPU0 but offline CPUs from other nodes will only make the cache_cpus value
>> + * lower. Still try to get the ratio right by preventing the second possibility.
>
>This all seems unnecessary since the next patch sets snc_mode to 1 if there
>are any offline CPUs.
>Seems more appropriate to move the offline CPU handling to this patch.

Okay, I'll move it here.

>
>> + */
>> +int snc_nodes_per_l3_cache(void)
>> +{
>> +	int node_cpus, cache_cpus, i;
>> +	static int snc_mode;
>> +
>> +	if (!snc_mode) {
>> +		node_cpus = count_sys_bitmap_bits("/sys/devices/system/node/node0/cpumap");
>> +		cache_cpus = count_sys_bitmap_bits("/sys/devices/system/cpu/cpu0/cache/index3/shared_cpu_map");
>> +
>> +		if (!node_cpus || !cache_cpus) {
>> +			ksft_print_msg("Could not determine Sub-NUMA Cluster mode.\n");
>> +			return 1;
>> +		}
>> +
>> +		for (i = 1; i <= MAX_SNC ; i++) {
>
>(nit: unnecessary space)

Will fix.

>
>> +			if (i * node_cpus >= cache_cpus) {
>> +				snc_mode = i;
>> +				break;
>> +			}
>
>This is irrelevant after the subsequent patch but note that there are scenarios
>where above loop cannot set snc_mode and the function will thus return 0 since
>snc_mode is not initialized. This is a problem in division done by following hunk.

Oh right, I'll set initial value to 1.

>
>> +		}
>> +	}
>> +
>> +	return snc_mode;
>> +}
>> +
>>   /*
>>    * get_cache_size - Get cache size for a specified CPU
>>    * @cpu_no:	CPU number
>> @@ -211,6 +273,17 @@ int get_cache_size(int cpu_no, const char *cache_type, unsigned long *cache_size
>>   			break;
>>   	}
>> +	/*
>> +	 * The amount of cache represented by each bit in the masks
>> +	 * in the schemata file is reduced by a factor equal to SNC
>> +	 * nodes per L3 cache.
>> +	 * E.g. on a SNC-2 system with a 100MB L3 cache a test that
>> +	 * allocates memory from its local SNC node (default behavior
>> +	 * without using libnuma) will only see 50 MB llc_occupancy
>> +	 * with a fully populated L3 mask in the schemata file.
>> +	 */
>> +	if (cache_num == 3)
>> +		*cache_size /= snc_nodes_per_l3_cache();
>>   	return 0;
>>   }
>
>Reinette

-- 
Kind regards
Maciej Wieczór-Retman

