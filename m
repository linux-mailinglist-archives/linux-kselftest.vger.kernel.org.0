Return-Path: <linux-kselftest+bounces-9102-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7E748B681E
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Apr 2024 05:02:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4C7D1C214A4
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Apr 2024 03:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 071AFDDA9;
	Tue, 30 Apr 2024 03:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YUb+APby"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D11CDF58;
	Tue, 30 Apr 2024 03:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714446176; cv=fail; b=jCma6RMaZMod4zjY4ZsyRVWmlc3/2wLrsTNBnr2N4Wk0HiVJx5qyFmBy4pKzw15R2msKmtQTTmVzVlesUszFeJZs6dAEZ2q/wEebu97lvqMRZPdvgD0eNoGf9xkERI24xhMjnH82vlPBDDCvHeQL3iQnuzobC3NtBhT1hBfd1a0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714446176; c=relaxed/simple;
	bh=iDjf0GDR1GuwtnE+6BfA7jYrkdfBcsu/Gdz+kVUyMIk=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=rxkwnpiZ5ZbqinogMAE5yK3/T9frezIvXA87V1LR7439VW92pOJgjffbsFAFxxomgUk3yz7JF4J4UIGmMOBhsqhIqfhbuswgCoFLXDf+4kVu8Fnyl189Aw+oiLAjF99oYe5dXZI8ANlMdJFmqBZBqM3Si1uELxo5mpfpyUPKuus=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YUb+APby; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714446174; x=1745982174;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=iDjf0GDR1GuwtnE+6BfA7jYrkdfBcsu/Gdz+kVUyMIk=;
  b=YUb+APby2aFZHU/W6mfGAApr9/KQ4sDe2HA6zrNh407eOK2fHMPdDlxA
   /a/Id19b4jDMnmq6WtFWSSVYcFac/cLqIupCEIZNmMjIyJ3KnNJ6/J9Rd
   1XA8STRIBAFQaHt2nj7SKM9Wc/sKjEF8RIaxq1//643EO7ekQP3bTIuTk
   XSC6oVvW20UsaUXYEM1ee0pNsjyWZTmJAYDXOvO44upZGXd2poHNBO8DH
   q6PM5UBZPTCroaeaeMvCOpms3BpN8vaGfIZDmO9iZFaMh6or0ZBxqw8Nz
   0eTeP86gUPa4GV/XED+Qg6+v3mjPoEBNop7R/0ZtAphu9m1peRf5AcrZA
   A==;
X-CSE-ConnectionGUID: K0jK07h0QoWFcWO4b3vvCg==
X-CSE-MsgGUID: o/Ki9z/bQxCu7I09EpiPzA==
X-IronPort-AV: E=McAfee;i="6600,9927,11059"; a="27579695"
X-IronPort-AV: E=Sophos;i="6.07,241,1708416000"; 
   d="scan'208";a="27579695"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2024 20:02:54 -0700
X-CSE-ConnectionGUID: efbXWTyJT+uMo9U4qziHTQ==
X-CSE-MsgGUID: FTnRwzzxQ0mXlOqOQAlRbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,241,1708416000"; 
   d="scan'208";a="57180869"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Apr 2024 20:02:54 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 29 Apr 2024 20:02:52 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 29 Apr 2024 20:02:52 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.41) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 29 Apr 2024 20:02:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f2y25T4T2+uw4sfVjuBtDlGdYjjBxMNji/C1afekhkeavWcanFOPoL02BFpkIRg7RjJqLNHR7yXeL1EObz/WsKj2eeWAIdybNb9Ec2CbLg0RVYpBX9Rd97YFgfRK+m1sJ8y6ugC88yIN6dFGpmf5gGPNBbXk/HihrDCTo+AS5+P+86aQUnAHJWD0jnYVBM/DRrovx3SQvnaEphZ6Z11S4KVulgSemAC7xl1SwR6XFiUUR+R/GvzfjrxaZgOd1ZwyH4M9tYbchnRQvamVpisk/gLH2N66Td6ea07+LTmaK6ej73SyKo1ZAiqmvrRvokfqMq5rgTzly0K+LzsABLxNDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mZigv1MXjfSai4bF1hf806er989KRlDElQm3PflYSrc=;
 b=KeA0udgZRaFh1ffC7lHvBFOgC397ZcXD9L457TwjbNFiWtG76DQqbmtok66XrP1/L1gnvngXpC2IRtpSEZyh8GmN/64+r0Q4nXUK3DITjvOJ5K8si2iic9j/AKIx8DH3s2AXYz26K/G6Tw5ohI20cXFDblH6jSPBXRWrjl9yS+D7NLhFoCdsNyn+5ZstwetR0YuqhWA+M2IwhVLXIQRPeySKwTCKwTzhS/WubleJd0WokZNYsD8zYedO4M/OBBv2k2r5nnqv/AFmtR00kHCM4x7jGjqNyKtQ53k/HjAGDgsSHrSYQP0d0wM3RG1h2oZ4qGpwTGTyiiywtg8b0WZomA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by LV3PR11MB8580.namprd11.prod.outlook.com (2603:10b6:408:1ae::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Tue, 30 Apr
 2024 03:02:50 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::58dd:99ca:74a6:2e3e]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::58dd:99ca:74a6:2e3e%3]) with mapi id 15.20.7519.035; Tue, 30 Apr 2024
 03:02:49 +0000
Date: Tue, 30 Apr 2024 11:02:36 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Edward Liaw <edliaw@google.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>, Muhammad Usama Anjum
	<usama.anjum@collabora.com>, Andy Lutomirski <luto@amacapital.net>, "Axel
 Rasmussen" <axelrasmussen@google.com>, Bill Wendling <morbo@google.com>,
	"David Hildenbrand" <david@redhat.com>, Justin Stitt
	<justinstitt@google.com>, "Kees Cook" <keescook@chromium.org>, "Mike Rapoport
 (IBM)" <rppt@kernel.org>, "Nathan Chancellor" <nathan@kernel.org>, Nick
 Desaulniers <ndesaulniers@google.com>, Peter Xu <peterx@redhat.com>, Shuah
 Khan <shuah@kernel.org>, Will Drewry <wad@chromium.org>,
	<linux-kselftest@vger.kernel.org>, <linux-mm@kvack.org>,
	<oliver.sang@intel.com>
Subject: [linus:master] [selftests/harness]  8092162335:
 kernel-selftests.sgx.make.fail
Message-ID: <202404301040.3bea5782-oliver.sang@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2P153CA0028.APCP153.PROD.OUTLOOK.COM (2603:1096:4:190::9)
 To LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|LV3PR11MB8580:EE_
X-MS-Office365-Filtering-Correlation-Id: f6a8c924-709d-412c-2fa0-08dc68c204e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|7416005|376005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UWw1MEVISmQ1MnowazhOYi90VUZReFFibHRPbUJFUG5TVWVNNk1kZVdkVDF2?=
 =?utf-8?B?UDhuTVVBQW1WTEVsVGcybkY1d09yS2VhN1VpbWE4U0JmN1k5NitWR2RPUUhY?=
 =?utf-8?B?WU5EbmM0eTdodnRwNm1Vd3FUUzVrOVJTSFVNSlorL0FWVENMcFU5SFRwckYy?=
 =?utf-8?B?Z3VLM3VyQWU3OEFIUGhoV21YenJzUEdqSStEVmxJdVhPVDhZWjFTREtZK3RI?=
 =?utf-8?B?TU1UM1NzbnFxQklhUUtnSXZzTUdBNVVtUzBPc29td2lEMTU0SVJuQitjVWM0?=
 =?utf-8?B?N2Jmc1pPKzZyZllqcDlPVDY0OExjT2pZWStUWmZQaUJwNWFzUVNTL3A1eTJ2?=
 =?utf-8?B?Kzg1b21Qd3dXWEpUaTZ1RWVKSk5lbm1mYlVZdmF4cmYxWHR0dkhKQk9abXE5?=
 =?utf-8?B?bUthOTRNRkpqOXhyZ0QvYllHTmczZVhKOEYycEpldkh2WEdqNm5OWEgrdWZB?=
 =?utf-8?B?c2NiRFVlbUU0SDdKaVJEeWtQNnRiK0NaUnBRNTVJU2EzTHhOa01uRDRkL3dT?=
 =?utf-8?B?dXh1Q1FrUmxRa0FoVGZFREkwZmpldmtuN3c2Umx5TUFtUnk1ekRXMSt0dGdj?=
 =?utf-8?B?UnBXMDlCcVBXeVMyOEVWT0JjRk9WQVA3dDR6V0RoUDJidlVsdHdYbTdGdFpI?=
 =?utf-8?B?amh3V1p2SllVWGpGUjJUa0xEdVY4bThXM3RyR2FzY2oxWTZkQkJXZ0tmTUtz?=
 =?utf-8?B?cG5wVjN2M2QrQURRQXBXZm91Wk5JQU15Nk1mZ2FsY1VFcXNwZnowU3ByYWxz?=
 =?utf-8?B?QTh4aVpyQkRmdGhRdDFkaDkwTmVjSXNibStkdFJYN3BhOURER0hhUzNldXo2?=
 =?utf-8?B?NzFLeFJGbXJZT3ZNYzNNM0E1SEhzNDdraS9rYUkzL2ViYis0Qk45M2xpOGdB?=
 =?utf-8?B?dUVieE5NWEJRNEp5K1FvVis2TnBnaE5tNGtBem4vYkRsNFRkVkIzWklKbVRw?=
 =?utf-8?B?S2g0d0NlU3RTakZGenk3T1lSWHM5UjlDZW5MOTRZWk9aVis0YXpBWS9BTHF5?=
 =?utf-8?B?U0lQRzZmcFFrMEdoRFIvU3BYK3pua3M4akF0aFVnczMyWWtndWpEYlh5SVFJ?=
 =?utf-8?B?YnVRV0lqYzZaWk9xb0xGV3pENVFFOG9mZThpY0ZWL3BBeklVc0pwcm5FUkE4?=
 =?utf-8?B?VVFaUjVKNDVFbVRUMTdNc0xaV1Jrd3plVjdXU2h4YkZsMzVlcERmSGdMdmFH?=
 =?utf-8?B?TjJpZVFiY09Fbk85MkM3Z213U2wzVXczbTVpTXFuaytEZndCRWZEdStLN3hN?=
 =?utf-8?B?b0c2MUpBelE1cVpTME5CK2l6emw4cUlOK3FCS2dPSHNMOElpVGJpTkZmTjh3?=
 =?utf-8?B?VDZ0Q0Z2SDBWNE5iZ2pSY3hzUEpDekR0eTV1TkxtY3FxeldoZ1VxMk5YdlN0?=
 =?utf-8?B?ejl2UUV1VXlZeUxEUUx0MU5FeThaMzBUQzh3SS9CZjdkZVNjaW42aUk2OGUx?=
 =?utf-8?B?T3d0OHBhc3dnODNtZFhxNmpKOWlVOUNnbmRaUzd5d0dELzVmTXdQbVBsU1pE?=
 =?utf-8?B?SFRzMDUvbitOMXVuUzBVek9yVkp4MU5Ta1FBOUVQZHcrWTAwRnFjT2d6MlFl?=
 =?utf-8?B?RXdXeWhwWE1Eb3JxTWJ3Z2JrYkFsbGNnMDBzbUNiMW5KUjZ0ZGIzR05EcnBB?=
 =?utf-8?Q?rILXXQBSrzOwDORH/chFAvl7udtgphao2IoWgsoJDrX8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(7416005)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VG1WL3JTMkdIR25pRzIwalFzaDU1aGZMR284NFhQQ0xGRUQxV2xOWGkzS1RZ?=
 =?utf-8?B?VExvdG9peTBzeXBVRVdBOFUweFVXZVU4TDFFU1czanVLWHpBMnhkdXRvOVZM?=
 =?utf-8?B?VkxxQWdaSkJEbnlHUnN6MnZBNFZPSGVVakFML0U0OE1YYUczSVFYWXdCVTJU?=
 =?utf-8?B?RzMyeHVoaTZTbHcyV1Z4d1FscDdUNlhydHVyWmE0VlNyVHNwQW81TVQzWlZR?=
 =?utf-8?B?eHZnR0tVZXlTR0pDL2UydHhTK2NDV0ZrM1cxWEF0SW1HSTVmVHBlQVArYjNi?=
 =?utf-8?B?b0RXd08xT3lLRXNCUm9MU3JKOVd3MXRycU9ZVi8yZW4zYnlGUG45cEtNQUth?=
 =?utf-8?B?Vzg5R2pxTU8rK1RlOXlKOG5pWWs0aDh5OS9xRy9BY2M2M2pKZkVEUldpSUtD?=
 =?utf-8?B?eEdId3ZSQVVYT1NLQi9WWFNFUTVOLzBIdHRuQ1B6eVJhZGpSMEdkY1g3Y0tC?=
 =?utf-8?B?cWlxZ3lCOENxc3pWR090TnpzUnM1U1hnYzBEUVJnZzd0bmFxUnQzdGttSUcw?=
 =?utf-8?B?Y0djUndETlQ3a1A5OXk0SXNoczRFZENRTGVrU0JlOXFZbnZPVllERDdieDBt?=
 =?utf-8?B?UXJITkxFNU5zUHJTYWk4WDZiZUhyMlhEY0xaVU1xWUVlYk55RmRpd2I3WGov?=
 =?utf-8?B?QzZXcmlxVEJ1aTVMVGcxK3hBc3FJZWplYUlqb0xlMlpCd3FSODExSWlTbVhs?=
 =?utf-8?B?Q0h1QW02MmNTNmFkWkxNL2h0UGVFOUhKek5OK3k5NGduN3BRUWF1bkFZWEZq?=
 =?utf-8?B?eGlIOWt1dmlxV0podU54UExwNjV1MUxKWXIrYm1icXl3SmhyRXR4ai9XMExB?=
 =?utf-8?B?citMdnRMdVpQVGN4cFNOaWFFUDMzcEFLYmVxT011M2Rlbldqb0tyUDBOQWZK?=
 =?utf-8?B?dmVmVXNMM3MzdVpueFFwRTlXazFPdkUrMjlDeDFyZGpHa01lRmFoSE9ETnFt?=
 =?utf-8?B?emd5TkplZTZCdHRsUGhpdzJmd3gySTQyVmZabVNCbGlKeERHYUdZdDJLemlt?=
 =?utf-8?B?V3dRQndtd293Mkl3MGpLSWlNa3BUaFY4NDJjUGh4SVhqR1RSckJycGdwbmZr?=
 =?utf-8?B?TGx1KzVZbmJFLzIwL3RyQy9jSVlhT24xK01KM2lUMms0dDJRYmFqTmV1MlVl?=
 =?utf-8?B?ejc5YUMwMzJkV3hhZTZ6MjBMdGxlVE8ycU1sYVRiTlljTFJCVGVjc2VHQkNZ?=
 =?utf-8?B?RmdVeUR3aEFFSlVYYVJQNmRuWUU3S1JrTWdDczkwZmtuMXZCeFRRdGN4cVhs?=
 =?utf-8?B?YllEOGpnSFB4dHdnQkFsVW9meWxMN3ZBOEVINUJFVHYxaGZOZU1iNXJpZ09F?=
 =?utf-8?B?R0V1MjREOGhmd2xCWW50L0hWaWwxNzV6UnNzczNIUnE1aGVtTlNvWHM0K1FU?=
 =?utf-8?B?eU55SlR5VVREVHIxSThLakhMSm4xdEtkWHNBQUxDbDFNdFdsWE1NSE8yTVBP?=
 =?utf-8?B?TGJCMUZnRkt1c2dWRUdobG04UFFFN0VaNFQvUGsxOTZRZGpDMm81MkhvSGlE?=
 =?utf-8?B?RHB1TCtVSFRyaTI3NXM4ZVp2S2FOQU1OK3hqRnJMK3FVSHNnblZxamZzdGph?=
 =?utf-8?B?bzhmVE9Mdy9pWXhZN3AwUnJTbWtab3dsTzVoa3psV0c1QnFsaisvQ2xCbklo?=
 =?utf-8?B?NDVGb2x2Z2J1YzE5ZHdLNzdWRHB2SlRpelZ6Ty9sT0Z6KzhsMm9qREFmS3Iw?=
 =?utf-8?B?dkpBcFZKdDZiUlNpYUNIOTcvSjRkV0JaYXJOYlpWZ1JpbXpUQWRvUlBXNjZN?=
 =?utf-8?B?Uis4VVZpbFRya09ELzN6a3NWUVhXUk9IUS9ucWJzTHJZTGpZUC9UODlOc2Zh?=
 =?utf-8?B?SW1USDRVc0NQRngvY0N1R1I5RnNjMFpWSml4ZFVnSHRuak4ralVnamVHaytR?=
 =?utf-8?B?MnRxMmdoVmZtYlVLZmp4V2Q3NWplaG5vZmRvdGZaUnJKNkZQV1hnRXlFenBL?=
 =?utf-8?B?MTdYR0p0TFl4c1FpeGtlUXdkbDNMSHp2QnZTekhLQ0VJOHdLZ0tVQVQ2MVBS?=
 =?utf-8?B?a0JjRUszN3NUdFI5M2dmWnhIVUdDMHN0dEZUa2xYRnNqNXNpQjBzNkFOMFZV?=
 =?utf-8?B?MnNtenR2ZTZGWWNRaXVqeUF3R1l4YkFuZGw3bWJVV1NLcG9maG9CbUd2Wnl2?=
 =?utf-8?B?THMwRmJyMzg0dVFpZVpWdG0yNE1ZUE5ZQ1l1WTEyNzhFNzhnSTByam9OL3J0?=
 =?utf-8?B?TVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f6a8c924-709d-412c-2fa0-08dc68c204e9
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2024 03:02:49.8106
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WKCD30VTPNTO+z4ql5teTam81d07jMSMEJHImHezXjuWIe2Z/DszxxSFL9iDdS0JNb/mRHKyUP2aq7cNfHKLAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8580
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "kernel-selftests.sgx.make.fail" on:

commit: 8092162335554c8ef5e7f50eff68aa9cfbdbf865 ("selftests/harness: remove use of LINE_MAX")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

[test failed on linus/master 98369dccd2f8e16bf4c6621053af7aa4821dcf8e]
[test failed on linux-next/master b0a2c79c6f3590b74742cbbc76687014d47972d8]

in testcase: kernel-selftests
version: kernel-selftests-x86_64-c7864053-1_20240419
with following parameters:

	group: sgx



compiler: gcc-13
test machine: 16 threads 1 sockets Intel(R) Xeon(R) E-2278G CPU @ 3.40GHz (Coffee Lake) with 32G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)




If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202404301040.3bea5782-oliver.sang@intel.com

KERNEL SELFTESTS: linux_headers_dir is /usr/src/linux-headers-x86_64-rhel-8.3-kselftests-8092162335554c8ef5e7f50eff68aa9cfbdbf865
2024-04-29 15:02:59 ln -sf /usr/sbin/iptables-nft /usr/bin/iptables
2024-04-29 15:02:59 ln -sf /usr/sbin/ip6tables-nft /usr/bin/ip6tables
2024-04-29 15:02:59 sed -i s/default_timeout=45/default_timeout=300/ kselftest/runner.sh
2024-04-29 15:02:59 make -j16 -C sgx
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-8092162335554c8ef5e7f50eff68aa9cfbdbf865/tools/testing/selftests/sgx'
gcc -Wall -Werror -g -I/usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-8092162335554c8ef5e7f50eff68aa9cfbdbf865/tools/testing/selftests/../../../tools/include -fPIC -c main.c -o /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-8092162335554c8ef5e7f50eff68aa9cfbdbf865/tools/testing/selftests/sgx/main.o
gcc -Wall -Werror -g -I/usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-8092162335554c8ef5e7f50eff68aa9cfbdbf865/tools/testing/selftests/../../../tools/include -fPIC -c load.c -o /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-8092162335554c8ef5e7f50eff68aa9cfbdbf865/tools/testing/selftests/sgx/load.o
gcc -Wall -Werror -g -I/usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-8092162335554c8ef5e7f50eff68aa9cfbdbf865/tools/testing/selftests/../../../tools/include -fPIC -c sigstruct.c -o /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-8092162335554c8ef5e7f50eff68aa9cfbdbf865/tools/testing/selftests/sgx/sigstruct.o
gcc -Wall -Werror -g -I/usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-8092162335554c8ef5e7f50eff68aa9cfbdbf865/tools/testing/selftests/../../../tools/include -fPIC -c call.S -o /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-8092162335554c8ef5e7f50eff68aa9cfbdbf865/tools/testing/selftests/sgx/call.o
gcc -Wall -Werror -g -I/usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-8092162335554c8ef5e7f50eff68aa9cfbdbf865/tools/testing/selftests/../../../tools/include -fPIC -c sign_key.S -o /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-8092162335554c8ef5e7f50eff68aa9cfbdbf865/tools/testing/selftests/sgx/sign_key.o
gcc -Wall -Werror -static-pie -nostdlib -ffreestanding -fPIE -fno-stack-protector -mrdrnd -I/usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-8092162335554c8ef5e7f50eff68aa9cfbdbf865/tools/testing/selftests/../../../tools/include test_encl.c test_encl_bootstrap.S -o /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-8092162335554c8ef5e7f50eff68aa9cfbdbf865/tools/testing/selftests/sgx/test_encl.elf -Wl,-T,test_encl.lds,--build-id=none
/usr/bin/ld: warning: /tmp/lkp/cct4g3SV.o: missing .note.GNU-stack section implies executable stack
/usr/bin/ld: NOTE: This behaviour is deprecated and will be removed in a future version of the linker
In file included from main.c:21:
../kselftest_harness.h: In function ‘__run_test’:
../kselftest_harness.h:1166:13: error: implicit declaration of function ‘asprintf’; did you mean ‘vsprintf’? [-Werror=implicit-function-declaration]
 1166 |         if (asprintf(&test_name, "%s%s%s.%s", f->name,
      |             ^~~~~~~~
      |             vsprintf
cc1: all warnings being treated as errors
make: *** [Makefile:36: /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-8092162335554c8ef5e7f50eff68aa9cfbdbf865/tools/testing/selftests/sgx/main.o] Error 1
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-8092162335554c8ef5e7f50eff68aa9cfbdbf865/tools/testing/selftests/sgx'
2024-04-29 15:03:00 make quicktest=1 run_tests -C sgx
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-8092162335554c8ef5e7f50eff68aa9cfbdbf865/tools/testing/selftests/sgx'
gcc -Wall -Werror -g -I/usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-8092162335554c8ef5e7f50eff68aa9cfbdbf865/tools/testing/selftests/../../../tools/include -fPIC -c main.c -o /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-8092162335554c8ef5e7f50eff68aa9cfbdbf865/tools/testing/selftests/sgx/main.o
In file included from main.c:21:
../kselftest_harness.h: In function ‘__run_test’:
../kselftest_harness.h:1166:13: error: implicit declaration of function ‘asprintf’; did you mean ‘vsprintf’? [-Werror=implicit-function-declaration]
 1166 |         if (asprintf(&test_name, "%s%s%s.%s", f->name,
      |             ^~~~~~~~
      |             vsprintf
cc1: all warnings being treated as errors
make: *** [Makefile:36: /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-8092162335554c8ef5e7f50eff68aa9cfbdbf865/tools/testing/selftests/sgx/main.o] Error 1
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-8092162335554c8ef5e7f50eff68aa9cfbdbf865/tools/testing/selftests/sgx'



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240430/202404301040.3bea5782-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


