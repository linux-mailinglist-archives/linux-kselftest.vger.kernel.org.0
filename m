Return-Path: <linux-kselftest+bounces-13124-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 841FD9253E0
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Jul 2024 08:44:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CBF77B23C0D
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Jul 2024 06:44:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F313E13247D;
	Wed,  3 Jul 2024 06:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m9EacrWT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73461131BDD;
	Wed,  3 Jul 2024 06:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719989092; cv=fail; b=XBAyK353Hy4AmRm5Jw6pvXeTCnx3FJnSsaydU26DYHKq/c3W6YroLtsiHjdSqFtzJmNm+Gng5Sgf+jR5YVAJ1b/pSys7lSzuOEDIhlq/rfsHmn5EnsxijBcwNPYdT1fEJrtaVfzMw8sHhAUGUNryTf3f2mhqQ//kMMnLuqeffaQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719989092; c=relaxed/simple;
	bh=19S9PWnnT88Tde+VuqLcX6vkI/TH1LmLg65DWiVdZ1A=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MIDYGtHChT7uoNWHjASa6jqA4nBMRXYu+9ccuLHJFL9KecRt8yFq3RswyDE431CgGNr14lhXQ8PVWCM0vDVbsnREcJvg9Wyix/4Wcm/pPD+M+O+GzR+F1pNpw8eZSfqbd0Z1pgR2XPEG7ZNCsFjy7azyq9xNAEiX8WfmcIgI9E4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m9EacrWT; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719989091; x=1751525091;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=19S9PWnnT88Tde+VuqLcX6vkI/TH1LmLg65DWiVdZ1A=;
  b=m9EacrWTJdR9/sMRPBXiwusm8+lXMZQWX8z+vC6nQRetHTwAfqHpuNpe
   N4yxxzoFdJOtGfYK0bGXgLEbILfes39BuPmhHOBoi+M7x4+Fi9zoxy2V1
   KumqXTMziuI1sdheRm06KtKm4aFv18Ra6iVdDa253dxUl/6Ncr5/C+w/R
   Gj5xmMwGzD32DXyebCa08BMcASDPIDcz8z/mb8PwQVkpyBInC17Dmyvbf
   D7gWK3SwOpV9J+B1vde3wVHFVQPOkGym7EQA11rIWIxXSDLzyTzpQlOed
   SS/fh1aHfR8DdlYFaIZRxuyMucMoFi8xlII604xC464/U0QlYkv+Qrmrw
   g==;
X-CSE-ConnectionGUID: 7apJmRHKQTWk/+k30FeQWg==
X-CSE-MsgGUID: kNrqI3TWRD6JqXZEvNajoQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11121"; a="39717443"
X-IronPort-AV: E=Sophos;i="6.09,181,1716274800"; 
   d="scan'208";a="39717443"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2024 23:44:51 -0700
X-CSE-ConnectionGUID: LBWscAL7TlCbUZUGnseUXQ==
X-CSE-MsgGUID: WM0qa8BHQJqg1U+p9a1heQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,181,1716274800"; 
   d="scan'208";a="46800988"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Jul 2024 23:44:51 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 2 Jul 2024 23:44:50 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 2 Jul 2024 23:44:50 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 2 Jul 2024 23:44:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fVczau5ROMLom0q8K5UwCdGezC6wvBiTGsfpKSzwB4uU40g9iKCskAqQ7LsYuI+7GLCcn6hUnSJAvO5BRU7ljWXha8EFfdMTOzwN6ZXOZn+BYf8kueVggkJ15QVO8Zf4ukbQGd1J+s4+Y9eCoZPm3mjfI9FzSc+jWefjivn2b8ABi7ncadOyDR1zP/4h9lcx1ckGOOJLBgIfsLnyr8n7XQCtGwQxb/nCN7JRD5dUmi9hpynW+Insu5eeIv1mC/NbID72SU5+UBTmF+PxU2A1UX5e+riuZwVo/MiDK+7hz9N1pSmWJ+iJYKTC1gcL24WGsQMO7ZTgQBry1mayteLVWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kn10tTJGiWoh3v0uXJnt0cT0PPyesDQJIrWOIBw8ZIk=;
 b=LGTW1YbWVZr2ZkSUur05y90d6O31qcxkdEzkCa013sWKTmgy2hh4hPITIzFa6mH+xuN6l6wN0ONdqE6aLRvSoHnB6qi/bRSprbsntWz72AV539IR1sGeiIuoTmjzTaiYcko7X2FXJDJk9E+mVDqh6FGAAg29lCp8rV0erEuLp4Mz/WaxDXGnbMit+lYAYWlZQ9tnQfkofiNV5pmhPByqttx5tirr7pB5pTm9F5S9paAfyYMMBJg5f8Q3noDG1GJq7UpCCgc52a/DzE8eo8drx6NeerudtPvY0Ir+4TH0RUYhTvGm6HJsDhE6sXpy7wTHu1L/ar2FdeealPp61XDbCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6231.namprd11.prod.outlook.com (2603:10b6:208:3c4::15)
 by BL3PR11MB6361.namprd11.prod.outlook.com (2603:10b6:208:3b4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.25; Wed, 3 Jul
 2024 06:44:48 +0000
Received: from MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::a137:ffd0:97a3:1db4]) by MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::a137:ffd0:97a3:1db4%3]) with mapi id 15.20.7741.017; Wed, 3 Jul 2024
 06:44:48 +0000
Date: Wed, 3 Jul 2024 08:44:43 +0200
From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To: "Luck, Tony" <tony.luck@intel.com>
CC: "Chatre, Reinette" <reinette.chatre@intel.com>, "shuah@kernel.org"
	<shuah@kernel.org>, "Yu, Fenghua" <fenghua.yu@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"ilpo.jarvinen@linux.intel.com" <ilpo.jarvinen@linux.intel.com>
Subject: Re: [PATCH v3 2/2] selftests/resctrl: Adjust SNC support messages
Message-ID: <ynz2lum5mbka3p4ouwmgrkmk2mk5k7z7qtaatfkigiajcldnys@d357bzhfaocx>
References: <cover.1719842207.git.maciej.wieczor-retman@intel.com>
 <484aef5f10e2a13a7c4f575f4a0b3eb726271277.1719842207.git.maciej.wieczor-retman@intel.com>
 <SJ1PR11MB6083D0D8AF9D1A7864084F0EFCD32@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <4fdc8cc0-0b04-4879-9337-9eda3b83f603@intel.com>
 <ZoR1GSV4_IWrNMK3@agluck-desk3.sc.intel.com>
 <a206cbfe-83a1-4c9d-8cc9-5cff1598a6d2@intel.com>
 <SJ1PR11MB6083B0251209AC52D91DA3FDFCDC2@SJ1PR11MB6083.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <SJ1PR11MB6083B0251209AC52D91DA3FDFCDC2@SJ1PR11MB6083.namprd11.prod.outlook.com>
X-ClientProxiedBy: DU7PR01CA0026.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:50e::22) To MN0PR11MB6231.namprd11.prod.outlook.com
 (2603:10b6:208:3c4::15)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6231:EE_|BL3PR11MB6361:EE_
X-MS-Office365-Filtering-Correlation-Id: 67ec6b3e-e304-4a84-fef1-08dc9b2ba21f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?F7C1X1lcM9lCvlU86NhDiHw6vQ1O/5UvnXf/ZpglxRF0dtFV53L+kfzxEC?=
 =?iso-8859-1?Q?pYqSkogyCJXQyG6/oSEtdijHIHp7G5Cx4yFnR7Wiggnc0Sj1LIvPcOwONE?=
 =?iso-8859-1?Q?gweJ8Q2Ngi6e/shRoNXJKHWUZGVwTSoaB3wZpi0xC654lgVpOTpMsvSUFt?=
 =?iso-8859-1?Q?ivldXc4IryvVvviBTjGy4/Nyc77WRZeCAgi7C2P1hC80evhEwdPJfkq1vR?=
 =?iso-8859-1?Q?VWWAQaeQ9eI0qsjwyHsjv/S10LGhkW9OHYOFxJ9W37lSSq6b4bQBO4p6y0?=
 =?iso-8859-1?Q?2fPDjXocnX3rgIOpj1RGqQ+H3CMxEzzpbdOlzNH76hGzdKr56OKphymqjq?=
 =?iso-8859-1?Q?PI7m+JoL/DAsrTpVoeb5DKDZefFsiwnQ/mJqhQcHFCavFI29U3TQ8xFyyK?=
 =?iso-8859-1?Q?/rXYAj5149fis+O2IaHHng6b6psVRNAZ0Y5EfmsgVLWm6oJVu4mgf/oDYF?=
 =?iso-8859-1?Q?RDTceCBB0fpxWrfJ7fBlPaqgA2RDtZNm1TwVh0GQ38dgwmk6io8ws8z0j4?=
 =?iso-8859-1?Q?1Igu9ZtUwj1GGUtWZQP13mzStoEYaVGPvRTbqcKg+Ywsv6u32daZKzwNyq?=
 =?iso-8859-1?Q?ZDAk5qntgsLL/wiSwiXO7ZEhW9NSYg7OokW5h6vnHQ8kyfBxp6UipQDKyb?=
 =?iso-8859-1?Q?alvy2u909/2lVon7U9ot56yAP21GRzaNRHjrJIO0wXZvhEcRWzDxSlBt8s?=
 =?iso-8859-1?Q?XePaxQ3reYq2kh2Tm8N6mhtFc3h8SmYo/079U3tnShtt/qyOLJ71AgEUXA?=
 =?iso-8859-1?Q?Gpl7PmGXkyli4GQPLmZl8f6Slh7ya8mYdVvL8BB+9lz2vW1O01TTK0X4pb?=
 =?iso-8859-1?Q?iwxbZwxs7l8hWQOfAo9R7WhA4ucV62GvD7eD3lKIfSIgrC4THx8siws/mD?=
 =?iso-8859-1?Q?AsRKgKwMU65On9SS91FS0ZEIIUNSbCUEcZqpT9X//xehwUyINJd3HsZJWV?=
 =?iso-8859-1?Q?zlyAujctCdRFyJFY8WUTiMqUzRTs/qix6+llInl667sbOCQiUj4EhLdR/R?=
 =?iso-8859-1?Q?qDpVtH0+uxZTMgO0DdgchyPadH7lfQ0l+OJtB45flIJtYWu+p2yDuFgjP1?=
 =?iso-8859-1?Q?VagpuJn11KmBGzcGa7YD9kFv48avTgOWJvXAEwwP+cz5Pfyl8G3WgXrwis?=
 =?iso-8859-1?Q?KwALj1ZLvz6luHBNIMYH/zIv6CGstymVOEwNRCeruE21oi89o0oGQeDkSX?=
 =?iso-8859-1?Q?GjAKVO5Ue0yBzGSD5MNgAlaYYEUQsrlW8DtpZjPfrFJkbmlKqfono2UYdI?=
 =?iso-8859-1?Q?e/Mr2iIVJystTBTUs5y4NRjgtfqzCWwqeMZjpJo2W2lt/c6n9iT9jqTmiA?=
 =?iso-8859-1?Q?XpibtuLF9uoL7E8IRGmCBlAp40LUhkGtGCgdXz+tqrfrQrEF0ms5HhCjGe?=
 =?iso-8859-1?Q?mE+jhN4lrYiBspchYaaS67/imlNByK8Q=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6231.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?zXgNsQcmJFOCNfC+TZ3D2rZprplDA7AtLy1gmjAuddRFnkWQhWuOsBQi9D?=
 =?iso-8859-1?Q?FgFda+ZGVkJCXdvA7EoW1uq/c9R67nmVuIr3ebnhHkyDihQoKqEJ1Xz5MJ?=
 =?iso-8859-1?Q?ZZdNddd0/GvtWakJJz0q9x1mvTwBxCri7iq5TKTmyiUP9dEoBmI+txArfE?=
 =?iso-8859-1?Q?gG+AthdkCYxbKBfAngVsacHSXBHCXQmaR6bHm1GwBZ36MASvUOpj4/syiJ?=
 =?iso-8859-1?Q?c6E7OaI2DLg0dmWqxFG58AmnyKLpZKAq9USZAWP7Ec0OZ3hllbLI/uWqoD?=
 =?iso-8859-1?Q?O/W0ItRkUcFQBmrY+ZX98SP9hx+zUtAwj2uePqxz0Hm0ZnwWCzXjev4VyQ?=
 =?iso-8859-1?Q?qkVtUXwAc/CQXNOgY+FQ251QKC3B5wc/kNt576zSxPzXR71uU1DaYoXIMw?=
 =?iso-8859-1?Q?kFu6JK76YuW0vtFaKz6eO3fif/k+3BiVV80Rbcfcero/g8K4MB8XvZ42fM?=
 =?iso-8859-1?Q?Ann5z4BhjVvnCsWfWHHPR3SPP1cWNTQdCxiBJyuoywn4xDh+9R41lfqsgj?=
 =?iso-8859-1?Q?UcV1OXg4aFvpZ5eAFX3ZczV7nNSM43Ldm8geeyu1yIdnpKiwr2HYCC0JNP?=
 =?iso-8859-1?Q?C4O0VVhgaQO+D0pMFvwd0iCjTqzzqIBA1HVr4lKidEHzK5wYWKvwpkB9oM?=
 =?iso-8859-1?Q?TrEGhImq0U74SZSGp/i+6qDVh81bCwMGS/xxNNXp7Bu3N/9uCWJgvj+AmN?=
 =?iso-8859-1?Q?vqhcDEREx1mH2D312PaiDGzSEEzhb8MNgFt41FsvaeiZaBkbbiUgU7nCDq?=
 =?iso-8859-1?Q?byhfdN5NUpUUz6zXvlzBxo2A/dxYHTtj2kA2hHH3Sx5k05rRUWz0aPaR/I?=
 =?iso-8859-1?Q?sAKgX5a81nqr1URSvcuO9splr3h2BxNaX8sf5cbQRYQxBx4RMgFt2mvV/j?=
 =?iso-8859-1?Q?Ar1jyovLjJtU8+HkY6e4NQ9XQdVZOhM9oBj3dJIsyfrS5DxkJi9XSX8309?=
 =?iso-8859-1?Q?QY4Tg9MGlLssXRIpG8vLUDZiRG7eyNaRs7dbMVOnKgZxLs4JFr4IuI4vFU?=
 =?iso-8859-1?Q?dQoObqh6/L+JhyoY7i2Xioz+eF1Buz/ENyZ9btXUBZMlZWwos4h5b2C+8N?=
 =?iso-8859-1?Q?HDTHw9RTQ7SkpLIUmVKI667KDMnTOnf16QROnXHUUmn/wDI8A6zbL2lyg7?=
 =?iso-8859-1?Q?UGApvVCBJRU8Xb31gLo9ZOo9Jm92rNn412H2VYWT+LYC7sJBwx1s8v5X8x?=
 =?iso-8859-1?Q?HGpq6gUjD87VXtK14JYtqF3AmDyqwP14jphsOXTCVVRze/ho9SnahjGDdV?=
 =?iso-8859-1?Q?dJ0kXv1CgmQ6c52Afzchlq5ERklEyYZe6ut45Ruy1Xo4r8FOBY05EVupg4?=
 =?iso-8859-1?Q?ZbUaMqn/AtVqXr934exVFqFNA4sqFSZ7fIDOsxMUgb2kcSToLQ4QDtCIWD?=
 =?iso-8859-1?Q?uBjh8ZnGtu9sS+LE6C2c819bRKncUNidqf3K3yu9oB7VGk9MLxjxxGEhdV?=
 =?iso-8859-1?Q?ZqChh9eegicGlDvLRs/gsdzZFl1PaqXZequvKanqQ8tDd/TtVOOsGov6N9?=
 =?iso-8859-1?Q?u8a+Kepgwt3JJNAdt7FBN84st+CeaODbrHdlhQqHkYNMC5CIdx8v8JeiMK?=
 =?iso-8859-1?Q?1sjofyim6Cf+UO/J/3SOBI9Xu6MHon3W6p/PzlIse8o8C0gpJCATyMo4S3?=
 =?iso-8859-1?Q?E20yrahQ7Dy7sCLnO7sd/fR08tXG5uOxzVtCPrZ35b6PThLLmtT+IYLIS4?=
 =?iso-8859-1?Q?epzfN3R+WgEOddqYLYk=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 67ec6b3e-e304-4a84-fef1-08dc9b2ba21f
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6231.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2024 06:44:48.6409
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /jZPjMRjJg5ks2LNJF3kJe1EHy0/yZN4suoR1PUiG2PVZYbvFh94v2/6Ni11WlGCbh+SncWIA9ueHJHwF2VUxVktQqjTGNAxi0Vmxi7SUb0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6361
X-OriginatorOrg: intel.com

On 2024-07-03 at 00:03:58 +0200, Luck, Tony wrote:
>>> So fgets( ...) followed with "if (offline_cpus_str[0] == '\n') "?
>>
>> How about simplifying it more to "if (fgetc(fp) == '\n')" ?
>
>Reinette,
>
>Even better.
>
>-Tony

Thanks, I'll try using this instead of fscanf.

-- 
Kind regards
Maciej Wieczór-Retman

