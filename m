Return-Path: <linux-kselftest+bounces-47350-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A1ADCB16F4
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Dec 2025 00:42:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6577F3011F80
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Dec 2025 23:42:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E506A2FBE0D;
	Tue,  9 Dec 2025 23:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XuN50c9k"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 190E3258CE5;
	Tue,  9 Dec 2025 23:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765323736; cv=fail; b=PXwHrdOJFzuZwg2a+LAcoNCD2Kamn/Ofigp16CaTC9CwpsNhRQzpRmXabcBxuHcuk4e76xmTBE38/+j+/hPcCmK4PPBGgDPcZbwhQtCCDsJqW2eu01D+k4uBl1rr57EMIh/Yy0wQ4huqOCDyZoTV7oimrH7wugH6/bnMoGlmGNk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765323736; c=relaxed/simple;
	bh=0NbgWZzb5CbLi/uTf+9KYE0MsoLZW/ar8gVqH/Us1XE=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Gi9/KsqiQE0IrFARXapV7Vx9ilML1s3zVt57XWCh4vcTzDCeWixpGVU6R5SmEAHCfqwiV/V3zmbAN35Sa0LOpaICUT6+dIYJGT8YA2YQ/eL0bSo5ctk/91q2vUQozF4NyKfSXYDWJY568DAvLJ+pa8iEbka2PglcommW13GXGl4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XuN50c9k; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765323735; x=1796859735;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=0NbgWZzb5CbLi/uTf+9KYE0MsoLZW/ar8gVqH/Us1XE=;
  b=XuN50c9kqK9eVg0HzEXe5xENwtlwS8IUM4mWqT1mhxsde2/K442EbEmJ
   Euicnrye+grTDDNkomhCdpzHjfxg0VYJ/P/RCa52Hy1vodVuWbpZYPCze
   Bpao3hq6nuO8rmAesPipZKkntx6QGpDlIyUO/8GcAvMiFRAMGztboWOfN
   +TBO9FpYATfJgxrqSkI/cs4PsQSk4Kohjj8nk/X0CWYkelPfneRluiClF
   voNs9laLMzJzRharMtRsu22zcxp0kMJhuxgak3njtZVZRxHgdgYLamKBq
   G4Osz8HVWN7QfY/ZaAqQV0jEXij3PfOwmff66ojrGRl8FUA2E7u1NOW4U
   w==;
X-CSE-ConnectionGUID: HYCngsjiRWubrHUZx8YHcw==
X-CSE-MsgGUID: MekrpkpYTlGNJu64BAD5yw==
X-IronPort-AV: E=McAfee;i="6800,10657,11637"; a="77980745"
X-IronPort-AV: E=Sophos;i="6.20,262,1758610800"; 
   d="scan'208";a="77980745"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2025 15:42:13 -0800
X-CSE-ConnectionGUID: e+wh2u4DTEedGwUuzHJ0sw==
X-CSE-MsgGUID: kPmd06DwRGmjtyLZjKkwcA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,262,1758610800"; 
   d="scan'208";a="196351583"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2025 15:42:12 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 9 Dec 2025 15:42:11 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Tue, 9 Dec 2025 15:42:11 -0800
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.67) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 9 Dec 2025 15:42:04 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AsaOY4fl6bPs5tSvNqh+PJaexARXrWxCGvEfTxxU0dxqc2+rXBddb7dnHRLP5oRXRulUGQzdBwk56uS7ixzxEvn1te4ypncDfSPok21nd6+oeZcCD6Ilv7cFT3+ha/smeZFLGiGc3cOXKLS0Lm4uUyxfaynPuOOjO6b/ZEki272GPgrfNw5Kzf0hS24j7aorlQAIPSE858aiexuUsDEvIkS8BeuPvgvuzj8UOiJBj4sVvttpos39zGgSjg1H5q8nvmZvQ56OoG+UHLJ1Yh0d52k1pzCmw16KsrEddJe26hyCDXUokoxrkx+9pvZ3A36qmD4zx9IZ5EKQI1QtMnOudA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qMC8PBiey4a3fcBgMaoCyFK8v1E5HqFOsQPh+gkzbw0=;
 b=RAHn5au0CricXYT3TBw6TtVHVvcr+XxzLTg72Ea5EcZO7tPLSFCZAIQBvw/42lkJ2U0FV4ywlM+wbtMei5eY0qt3MC2zOWHIEwyNWBhKOEhredi6fVgLHYAXFYoHt6UPnVLbEEtDy3abltSKK7Pkt/hrx/oDOj9R3Mi40Qtj9Zl1rkbx0ZZXUHxRdlOr8llTsPc1mC3d/tdtL1OSsBAniu9mpch9iVdMg87uTmDcZehm4K0KN8vZNxJf+su287hsqZVP89y2+VDfeWJrJxx+ZcQsH9yBRnVD5PGTcrX2eHXBE6r0r0fdn9K1ogE2N3rcUogllBpnL6jkbrkNDaHehw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by SA2PR11MB4780.namprd11.prod.outlook.com (2603:10b6:806:11d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Tue, 9 Dec
 2025 23:42:02 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361%7]) with mapi id 15.20.9412.005; Tue, 9 Dec 2025
 23:42:02 +0000
Date: Tue, 9 Dec 2025 15:42:01 -0800
From: "Luck, Tony" <tony.luck@intel.com>
To: Reinette Chatre <reinette.chatre@intel.com>
CC: Xiaochen Shen <shenxiaochen@open-hieco.net>, Fenghua Yu
	<fenghuay@nvidia.com>, <bp@alien8.de>, <shuah@kernel.org>,
	<skhan@linuxfoundation.org>, <babu.moger@amd.com>, <james.morse@arm.com>,
	<Dave.Martin@arm.com>, <x86@kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH v2 1/3] selftests/resctrl: Add CPU vendor detection for
 Hygon
Message-ID: <aTizyW7R8Mqj-lSJ@agluck-desk3>
References: <20251205092544.2685728-1-shenxiaochen@open-hieco.net>
 <20251205092544.2685728-2-shenxiaochen@open-hieco.net>
 <6d68f2c5-4011-4188-bdb4-27f0e6a4d13e@nvidia.com>
 <f2e30c0b-018f-4988-a1ad-9ead6af7994d@open-hieco.net>
 <ca161ef9-c9e3-498a-9e6a-aefcfec46dea@intel.com>
 <1ce7ea26-6e97-4640-86df-c8dd3e623002@open-hieco.net>
 <d713c903-b8fd-4909-a520-6426fabc003a@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <d713c903-b8fd-4909-a520-6426fabc003a@intel.com>
X-ClientProxiedBy: SJ0PR03CA0179.namprd03.prod.outlook.com
 (2603:10b6:a03:338::34) To SJ1PR11MB6083.namprd11.prod.outlook.com
 (2603:10b6:a03:48a::9)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR11MB6083:EE_|SA2PR11MB4780:EE_
X-MS-Office365-Filtering-Correlation-Id: ed29a09a-ff3f-4a74-7d4a-08de377c8d8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?zJGk39Hwz/c+F+ib+O5CzUVqQzJU+DiH1o0jzKqoSA1MUVd0jCSU0a7kTWOQ?=
 =?us-ascii?Q?hIXgAa/KBGt6HyESqx9dROQevThbw+fHHq2mJT6AVRE5Y04k6WvIXnnY6Rjt?=
 =?us-ascii?Q?r9c/zHTrgthCPqCVFc0gdAoDD4d4GhUy4Gj4pFtBtlgPEsqAJFLJhyb3fRVN?=
 =?us-ascii?Q?2UAsWawIUIi32mDDl/wNl65oxwVzJce1bHr2r1jqzRN6LScQKRFgyxq9gzwo?=
 =?us-ascii?Q?bZiTw1uigUbOYsk57WDXctPuanZf5wfnnwV3dSy088Ye82a0b/SRYotcibaj?=
 =?us-ascii?Q?1meaMVNtv9KUBd+3P0UG6NHKPNAto27x0ibF/BJ7Wn/GJy7bJ0jTOA93s6NL?=
 =?us-ascii?Q?gVI+JxduLv3yKtXdyrMcjfiq1HH9DoDfoMdyus4KVRYbFpuVsoKVejwI5svL?=
 =?us-ascii?Q?0YkDIVGJX6ujI0ziTMj8fW8pX8nhjYWEL1Ym4uOvuGb8/dUi4C98xhjEkbnq?=
 =?us-ascii?Q?dfCI6pzbg31HgPnpOr54ZKEsFWf/qsZaj97tEiafEKuhdZbJQHN+wHVBYZl4?=
 =?us-ascii?Q?9XE1YJdRIiCg8uEAvo/LSKu+NxG1+SPIUEVBABYj7GhGzoqEv/RjFygi++R5?=
 =?us-ascii?Q?D+Pn0BczHz9aXQ/7nxc1JgBXl111tzX/qdT7xuxalvYTo/LKkocMTKDwO+o+?=
 =?us-ascii?Q?jmW0dTtjrkblF0xrAQL/9Xd0WEAafWf5m8eJoKdLBzddm6sxaPeD2/j0THqa?=
 =?us-ascii?Q?VCXHPK0WhzN9WMv9uFta5Xa4PKlMkeENjR+6zU09o8d4Cl87R1ppZ5vURM8v?=
 =?us-ascii?Q?jETgnkUqvliYPNpll2W4iq6EQNE5f9QX9UAz+dkZDkC8ZYuYfoMNpOqatgWM?=
 =?us-ascii?Q?87c0QNY7w0qGCLDbE8f8v54FvPLMYR3rrTndCiI99BhgNAC90LUnBN+wggVu?=
 =?us-ascii?Q?3Np0N5g3gCyLqYGDekbOxZEVBns2VDpWeAltsFv/zoVEGoUlzjBB4TNUbtHP?=
 =?us-ascii?Q?l8Ajo4slzLZ9xgjSyG39uJDUp7Jf6PNVLDPb8rTmZY5flQ6YAdDWlcNVql6Y?=
 =?us-ascii?Q?sFS+OmSsvUcILkI6GLTVQ8dP/13+xrDpADdfdm1hqC3CkUiuaGs1Ic4JPsTG?=
 =?us-ascii?Q?SNOYSm8eHsJv3DhCDbc92FfjMCbRkCZy9bozIdMTJWF3AZ5//yiRC5QDYhaj?=
 =?us-ascii?Q?gBzbZjiFh61T3x6ToKbsND/e0+p7RM32QvOYyb5l9LhhD91152FDBKSpptUN?=
 =?us-ascii?Q?Euf9psHnhRP94u/SAxnAGjBkDQIz9nZ3Q+oHfKQILPwwy0CPd+/EpEoFPsjz?=
 =?us-ascii?Q?505pk1zzHtie9AcLldtz+/o2A2dPnQKNLs/s/0mVzU6A0toIT33cu3Riz8DD?=
 =?us-ascii?Q?FhjrqQrHWF9smKjLBEtRXnw6RUKag5ykHCPhyASSkAQg6Ir737MqYRNstehN?=
 =?us-ascii?Q?i2JKFBLDifsu9xxtoSs2RAHW6C8Z2bPE4/T79JXIUEJ/M2hWez3oGUYm8h4u?=
 =?us-ascii?Q?RsOznHjgEkX/orSKm/JvK4wRqTHlNPHt?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JfW9gP9bHMpKzQMOHL9auLarCEYMhJQe/Zuv15eWF3HWQiEn+DbRAlcBeyZJ?=
 =?us-ascii?Q?eS41AxrXmhdpm9zB0q76Bn3ho/1/6qWCNUei2/wMQ+8ixz0KHoCfv/h/VbUH?=
 =?us-ascii?Q?3Nn5reJLSB3okj/2Gn6hNxxve6CcGKo8mLbULNLVURhS2Xgohvgz9ojBexl4?=
 =?us-ascii?Q?7xoUqlq1ok2GgdKR/Thh+1cnfzbM+fwZVE3ybKk0lTeihuym+L/aLc94KCRu?=
 =?us-ascii?Q?qO9t/WkbM68z9usHg1mJ7YTPRftLW1YJsjfj2uci0Iw/C1Z6CZILuOWCioDz?=
 =?us-ascii?Q?OB+SPnnS9Q/6/B7x1+I3N6eSUuqj7EXDw9qDl9vjgoz3PyVrarI+CapOjIZJ?=
 =?us-ascii?Q?VM5haACXJIfch5rzpHIiNl/DRJ5uxVDOh5uaG54kyMYRU6cB84sIq+IS8nFL?=
 =?us-ascii?Q?ZdW1aDrwjHFL89T5fH5GTxKPvlq8daMEiD1syfd9QIcqZKdz9TBXlrEGw7xr?=
 =?us-ascii?Q?FQlnIodHJNaPYQniztGqrtaFdqOcXSgqM/LUfb0REfRQ7MQGY4zxYYALnSLi?=
 =?us-ascii?Q?RpwJ4o/iY2qeT9ZEpUAGXg+31BGE/AzHj52XEkAepqR8laxQ+B+eRfvB0Brq?=
 =?us-ascii?Q?5rLi5AmN19msoarFn79fG5jR3+owqODIke/ekZ3DYBZ3eUKHxBMxxjh301mz?=
 =?us-ascii?Q?0JZJ3DV27Gl9noicW9XU/oQCMC8sZPo3NujeFyDTvtTgCb/qFPkUC5JwjOpt?=
 =?us-ascii?Q?MZgk6+XFhmlQIsXG+xtRbsAgjIep5rZwBD5nYTYijwmM/0vXpuqhsccGGdIR?=
 =?us-ascii?Q?PO2G4/yGAcS1zSfNlgVRUU9k++hMJ4tHmZXjsK4EhwhriW4oIqi73QXY8hR3?=
 =?us-ascii?Q?210E8bI8C6IopMK4fD7HQh2K7NeDKBVnJuUkWvLeyAxu09Feb8Q4L0EVRCxW?=
 =?us-ascii?Q?1+15k3Fa8PekUORyaTKayGLjdDqXPsBJWRfRvVeBFtkBdy8Ttm3cEnhyiBJX?=
 =?us-ascii?Q?T5+pbJeva47+tdsBMNjz6KBGf8KJ95WZKuCui8jedAXH0o4VJQxaPyfAK22j?=
 =?us-ascii?Q?/2+pY8rAuOAzIgpUP1nxHbkrMoMquq4qWT2ofzuUQlPP36KvYkulCKQAH8wS?=
 =?us-ascii?Q?IwRk1J0VHw+L7DJXJvWtPwHRUXfHQ6oTAjF1bZgDB94AgdjSmJ0SUu/kehG1?=
 =?us-ascii?Q?JONHsg6iTafA6PMl7EUzEN+GCr5UzLQh/K/tSh/UgBo/HeX2U0WzF+MQAbAU?=
 =?us-ascii?Q?D03SrLrMr2NapdiewNDkezzyGHT/RS6u2NKIQHhT8xT6BaCtvVjxoieOAqre?=
 =?us-ascii?Q?CWs4u5FQbOgy8bIi8qqKjNxFpH5q7xa+YOEdFTckDaKOsUhxojLQ/qX75up1?=
 =?us-ascii?Q?ox7m2SkNNl/GqZOyO0LXkus1mwkiEqpn0mmg1N2JfFR0UrGEZF+UqSAxc6S/?=
 =?us-ascii?Q?DF/EpujQmHo0KhKlcQu5pGBJYABIuEGqxaw4a7BrlwYHSzHK4envJ5nkIDIB?=
 =?us-ascii?Q?yXjGROwvjEcGLBmqmD82I/Z63C1w58E7QssIBggXfvmXdVTIuqkQ9nNCWPtU?=
 =?us-ascii?Q?xav6xaLTJLh+tp1NVG1WjCGAfIGiHDRp1M6OjO6G7J0V0nMds2kWuL8yZo23?=
 =?us-ascii?Q?FHOXDpFoqHauNzjK811K0XgU83VoS6OnZXzh0toZ?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ed29a09a-ff3f-4a74-7d4a-08de377c8d8e
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2025 23:42:02.5487
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rn6B09TPcQKUtc6mbwpUuVOoS4/AOhjcW4HS9dfEHzF1sfExzrHbUVhK0V7wFFyKNss/CxaW/VEf/rnkcCXhAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4780
X-OriginatorOrg: intel.com

On Tue, Dec 09, 2025 at 03:02:14PM -0800, Reinette Chatre wrote:

> I suggest this be simplified to not have the vendor ID be used both as a value and as a state.
> Here is some pseudo-code that should be able to accomplish this:
> 
> 
> 	unsigned int detect_vendor(void)
> 	{
> 		static bool initialized = false;
> 		static unsigned int vendor_id;
> 		...
> 		FILE *inf;
> 
> 
> 		if (initialized)
> 			return vendor_id;
> 
> 		inf = fopen("/proc/cpuinfo", "r");
> 		if (!inf) {
> 			vendor_id = 0;
> 			initialized = true;
> 			return vendor_id;
> 		}
> 
> 		/* initialize vendor_id from /proc/cpuinfo */
> 
> 		initialized = true;
> 		return vendor_id;
> 	}
> 
> 	unsigned int get_vendor(void)
> 	{
> 		unsigned int vendor;
> 		
> 		vendor = detect_vendor();
> 
> 		if (vendor == 0)
> 			ksft_print_msg(...);
> 
> 		return vendor;
> 	}

If detect_vendor() failed, this you'd get the ksft_print_msg() for every
call to get_vendor().

Why not split completly.

static unsigned int vendor_id;

void detect_vendor(void)
{
	FILE *inf = fopen("/proc/cpuinfo", "r");

	if (!inf) {
		... warning unable to get vendor id ...
	}

	... initialize from /proc/cpuinfo ...

	... warn if doesn't find a known vendor ...
}

Call detect_vendor() at the beginning of main() in each test.

Then just use "vendor_id" whenever you need to test for some vendor
specific feature.

-Tony

