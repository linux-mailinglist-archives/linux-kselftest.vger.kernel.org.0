Return-Path: <linux-kselftest+bounces-38804-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19573B23A58
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Aug 2025 23:04:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED4ED7A52AD
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Aug 2025 21:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8CAC1DE2D7;
	Tue, 12 Aug 2025 21:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CoRQ6Z22"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B2A12F0661;
	Tue, 12 Aug 2025 21:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755032655; cv=fail; b=H5T4rVXt+5Zoite4fEMLoD2n5f35xTI3906PxNi8s6S/2K8j0ytPKo2DzhvjxeGXdsjUgkCWYiIP9P4Ey5s+S3ia4OklHFpAdhIFCQcd245lPuTG5xmVc8zrlhVY5HYtDIwCeNxbH2U4VISOafOYBhHAiw9nNr+huCuKResnELU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755032655; c=relaxed/simple;
	bh=s8DBPBBoMEfcJtb3LAZj24H7IyvcHSrFgRpYi2+kJv0=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JJOA8XYzwI7yF3ASy2CNp7GwueaTxW1mZNiY5IG8/JdfNcsjpQnVknQjMoiK3W7ylwpxfoXSZaWJSXmF4rFXiRywmkf4IIHP+yl5x6CNqekcCBsJO/LYjR43HN6+YK7C8UKG3jR0jy7jtvgeXk3e+pVv0MBWfsss+dxdjIjtCk4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CoRQ6Z22; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755032655; x=1786568655;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=s8DBPBBoMEfcJtb3LAZj24H7IyvcHSrFgRpYi2+kJv0=;
  b=CoRQ6Z22+eeBJWumBhw0jRZhiww51seN0DUuCq+qek7L3NSHzPw3fl0l
   O6dUJYNE3v2Bil1dqvZyifOXAwcEuy4UmhSIWhWIqccxMuCULC/5+corj
   nkKL9MBYQuUO8/pzw5V9e74AEF3Zio42VLlBCCFDJABAeEIzBfMhl9nWP
   h0sApYGIU8T1ijVJh/fPpfb1BwfjukZC+3eb5gPH+PvokR3kkTRixB1sG
   qbU1O4iK7u0lV50Xs1JkA54SW2+w6KSapQJ6H0V+qzcXRBytvkS5vHoNJ
   DIPe18x+cfQ+m0RFZSdC9rAKoJ7THYv2QMCBLQotqdyTjjVw+luGys6v3
   A==;
X-CSE-ConnectionGUID: DzhkckVSSK6rVSn6n+yusQ==
X-CSE-MsgGUID: qSKoY8wWTDW7WoribB4EQQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11520"; a="61162118"
X-IronPort-AV: E=Sophos;i="6.17,285,1747724400"; 
   d="scan'208";a="61162118"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2025 14:04:14 -0700
X-CSE-ConnectionGUID: gBFZaPbRT0CfGAn0DNRdgw==
X-CSE-MsgGUID: 8SGVJ00GSO68+Zu9q2jftQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,285,1747724400"; 
   d="scan'208";a="165800565"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2025 14:04:08 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 12 Aug 2025 14:04:06 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Tue, 12 Aug 2025 14:04:06 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (40.107.93.53) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 12 Aug 2025 14:04:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WOKLIIWDz8WzQ8MDWLDywi3hCielazFyj3AByTyrcM73kvcJcsvRvWUvj+B8Dw0Ezz9dugBIpsK8iQil8ba+7eThhnu76eIu5SA1g6IDGCh0996ONlUUUHofCxXgcvN11pL/0oCsBO0e1xmk5v7OTI/lGb5nsKDmoiucxKoSC5Nal2SOGOMv259V1glU+InbKetSTw8viZTGaSr5XfSx7ZiJlm4/ifZwoiVL6qk3yDNWKCZo9kSw4Tq6eLOXsrniBDieTQ1dkyVihSscZFKaAQ9X38KMvYy6y0i2I4yzmjrpgK7K/+BSHLaRMKwi/gVtq2DTOc5dTjXeWsx0qNfBqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KWLeVlsfV3FPUVtZBsiO/3Zam9yx7NgverFMfXOb2Xw=;
 b=ZmdOSFeI8q1q3scxk9E42KOl6o8pSkj4yXDaFrgU/XaEULRKFmL8r7mGEyh5SdgKOs8OH4vE4AC8hKvpAvvArp61U/FKQTgdUuINbiGuo9yl5cd8+aIJxZfU7XN8m7XP0GQNYWeM9X04oxcsv8QgxCskH3X9AhNQ8E4wvK4SeWiOHb7eDFaWMJm0HsWlIyT6WNetXgWRbD6P5hb0Goa5TuE2c6cCCkBgA+NhjeYtK34grJ+5eAnUekmD3pp4MHZ5oZWkNNRT1aoe36BdG9bofj0IM22L4Ac5BWJeh30NR9fc0lsM6EZJjDJPPmWnw4wVZpZBHG4h8TQO87Lmdt3tsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH3PPF9E162731D.namprd11.prod.outlook.com
 (2603:10b6:518:1::d3c) by BN9PR11MB5306.namprd11.prod.outlook.com
 (2603:10b6:408:137::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.21; Tue, 12 Aug
 2025 21:03:57 +0000
Received: from PH3PPF9E162731D.namprd11.prod.outlook.com
 ([fe80::bbd5:541c:86ba:3efa]) by PH3PPF9E162731D.namprd11.prod.outlook.com
 ([fe80::bbd5:541c:86ba:3efa%7]) with mapi id 15.20.9031.012; Tue, 12 Aug 2025
 21:03:57 +0000
Date: Tue, 12 Aug 2025 16:05:34 -0500
From: Ira Weiny <ira.weiny@intel.com>
To: Sean Christopherson <seanjc@google.com>, Sagi Shahar <sagis@google.com>
CC: <linux-kselftest@vger.kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
	Shuah Khan <shuah@kernel.org>, Ackerley Tng <ackerleytng@google.com>, "Ryan
 Afranji" <afranji@google.com>, Andrew Jones <ajones@ventanamicro.com>, "Isaku
 Yamahata" <isaku.yamahata@intel.com>, Erdem Aktas <erdemaktas@google.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Roger Wang
	<runanwang@google.com>, Binbin Wu <binbin.wu@linux.intel.com>, Oliver Upton
	<oliver.upton@linux.dev>, "Pratik R. Sampat" <pratikrajesh.sampat@amd.com>,
	Reinette Chatre <reinette.chatre@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	<linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>
Subject: Re: [PATCH v8 06/30] KVM: selftests: Add helper functions to create
 TDX VMs
Message-ID: <689bac9eb9b43_20a6d929445@iweiny-mobl.notmuch>
References: <20250807201628.1185915-1-sagis@google.com>
 <20250807201628.1185915-7-sagis@google.com>
 <aJpO_zN3buvaQoAW@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aJpO_zN3buvaQoAW@google.com>
X-ClientProxiedBy: MW4PR04CA0327.namprd04.prod.outlook.com
 (2603:10b6:303:82::32) To PH3PPF9E162731D.namprd11.prod.outlook.com
 (2603:10b6:518:1::d3c)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH3PPF9E162731D:EE_|BN9PR11MB5306:EE_
X-MS-Office365-Filtering-Correlation-Id: 97eb605c-b1cd-4a9b-a7e5-08ddd9e3c095
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?DKGtaAI04GiYPkfgrZLvRDqbDnbwZzh15OgLuHD03IpjH3iRDBiOtfdqHkf+?=
 =?us-ascii?Q?5TGcDa+51jRHbN5YRF5s89/7MFxP7HGQ3GtXz2/D63VeN6jwYtspBd2jVHk9?=
 =?us-ascii?Q?R7a51lov+4Jfjo1hFqfDPzLNBZzKTPuJTFopM0nNIVv2BhWnnbxCnLsR0yrw?=
 =?us-ascii?Q?7zsWhlefPtfgriXMxKBjHmEyZXust1xvotkrUbi0FztzkZb5j0H4C2ZYFhDw?=
 =?us-ascii?Q?eG39XoTYH8KacGplhQ7N+jcRHzhuxa0s+ono5FpWPVNFj1nplXJHKEWCg9ZL?=
 =?us-ascii?Q?4w3Z9tEJlXzRfNBS5dFj7BNqmjhNMimPjonjqEX+NBTOanxIdkuNWJHrCOhw?=
 =?us-ascii?Q?4vYFoSZMRyOuz2fTRY2nPrcR8Qi6xOYig+HcG4EiBY3UJ/EE/nmate3C00Uo?=
 =?us-ascii?Q?vKGtafySXjQWlb3Ua6r59lvjgWGS8mAHd0kyy9niGPeGQ/3cDJkwDutxcKdb?=
 =?us-ascii?Q?HE2BP/TEMH6EMeL+pPigJdWm39DxjraAnC5+c8cwYgg1BxuXlPYlzrm/f4qT?=
 =?us-ascii?Q?J1tpjtlUXvTX407u8/cL97Ord4Q5PLafywOAeYiMimKqi9HhljghV5F/RAXP?=
 =?us-ascii?Q?RFYYxSzfYu0RRZmduKiu2d7S8NrOEwdFWi08rhPSawzl7cslXncKUSsIKa7P?=
 =?us-ascii?Q?CGwH0r23yilXirLlWM9S5hj4iQ4PKeHvMfwZvf2VBigOd39Dxo/wX0Fywi0v?=
 =?us-ascii?Q?DLCMFtRHkFwQHaDIwzZihS0O+55H0Vv/DJjB55cmope/X+FEp+lV9P3MRkai?=
 =?us-ascii?Q?HNfPt5WYbnkU4Wq+nDEVMwQqkpGDuzvhmKhknXfqLEGmtxS144tgAcW/67ir?=
 =?us-ascii?Q?TDSXFE5Nx37vdsRU7D3tNANwIL6WF2lxqy1L3TB7v6XeHKd08e+Y1alSDegI?=
 =?us-ascii?Q?SR1PXwPbaaCkLAScDie+EVVxwomRf5lVjOs1Wp+Zn3oN4NHP6WNkvS5sC8Oa?=
 =?us-ascii?Q?WRXfD4U3p4hU7LmYBp7C4FdnbcMwLpq7SAwb8SXPgueWnu2LSczKMiea4X5a?=
 =?us-ascii?Q?M+1P/ooqOPf5N2o79fLl41u0ox2njaFIuke3+4GceLIfaOLksPnmOn2xvWuJ?=
 =?us-ascii?Q?yW/AWokRB4p09M+gx1rdGfOMFgua1juGF4v9Fb7r8k5Q3xrPZALijtcEAJeM?=
 =?us-ascii?Q?/nmGmSbgmNdvRZHkNBH4/thcTRWGeC+fajLz5lPQWA7hNUdUmloQoItffnAP?=
 =?us-ascii?Q?aVKRwcyvOvCq8RxqplzXsQ2N/0WQxDkk/HrBJ6vPiCHwX/nKO+ps4nGadKWp?=
 =?us-ascii?Q?/07NJbgti9l58+9uo+I3QKPWZVldFU9I6nBepeabhA/4qoxZg04re78WaL0z?=
 =?us-ascii?Q?/zkyTWIvebuzoGKgTTk93I1nbcq64zW9LsFNE7FxQpnf3TbtJ0I/zQAkWvk/?=
 =?us-ascii?Q?ZejnJAZIHk6ZM0UVGds1+1aSP/8YxFkTK//1j39YS7bFtzG8upaMCpI/kY4X?=
 =?us-ascii?Q?7bp4XYPYgLk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH3PPF9E162731D.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZYjSJvE9wca2xvhCEubjp84OJzNvTZb0jZNkEoRkcYjBPNTw+oeVIxDtRfV2?=
 =?us-ascii?Q?bCSeikxdl635pN61gH70TwhDPYEmzNG3oXq+D5TsCujzuCrHL86w7b7V0PaS?=
 =?us-ascii?Q?dWPsE64Ye2A8DBBWlzrJASgNgKWaSTbkcj4JzhaJXfwsxxNQugSi8lE6q8hi?=
 =?us-ascii?Q?MFlP5Q7PoHq63cTtyQ7fH2o6v7gPPImtI3abe+iBDRNpumwEGcZ2h7IANg8k?=
 =?us-ascii?Q?9Jr7hje65YM2/7Vjl/srQ+iEmBxEOeKTm+can6UWawEXVcexuKfL2FFBfQ+S?=
 =?us-ascii?Q?7PMOw0GDr/RLQeevUs496Lx8QNzMgoCxwdtiQWAybcx58zp3cXYB0DWu1HK1?=
 =?us-ascii?Q?teBM1ARs4iUITFG/6ML97jY3CGR/6ArEtgI8cGd7otjs2gmPpKKyMMDAB7Bc?=
 =?us-ascii?Q?Wz4n2GF26N9cKmc/d+cXtv7qB55wjLIqCwj9QecMvMnnWsKH6x1AAHwIvwW6?=
 =?us-ascii?Q?CMTQF1MwLZ80iX7wq3jv3sJz6okJIxYD54GB/3c9bmWAJEKVSLE4D8JMETq0?=
 =?us-ascii?Q?D3NvlGfsmuRZpodo09BTtBm1vuKb20R1hiqNFrXKMYpPz4g/nXrMeU2UAYBY?=
 =?us-ascii?Q?AXcXGbMI0wDe9uPXecf8ax5zDo2HdC4JZPV7cWN+DaLzHVGfe0MNtOewBdE8?=
 =?us-ascii?Q?Q62wYKZfVvzKYMf1vbQbOrCtYWoNcKOJ6MMKSu0hsIxdLKNvhhCpeeKiyHMz?=
 =?us-ascii?Q?Oh5+Iv15MiEjXexV3Rj/f9rteGMxCb/8hskwGOqUVp1/ZF5to//7fH7e3EGN?=
 =?us-ascii?Q?aVP9RMlvG2/1Uxie+Ox8djC0Xn6ShRJVT6ptPGPlcMkqL+ZFsFaoJhQt5Jqb?=
 =?us-ascii?Q?VFyifo2Vnc5vxieF3ycQgYB4/O6vyyIb1TKZOufIQeTLWFXlqWYl/2Jr1vbJ?=
 =?us-ascii?Q?HRy2q3poIPBS4JowutV67GVe8PrmEr5xVveqwLnFnGHB33I0S4AQgkzZ7w/T?=
 =?us-ascii?Q?GiFXFL6Bi+mBhAiL+8cASUhJpBNAlRY1G0x01+o4xpXm1xPt6xzfRYBK4gEl?=
 =?us-ascii?Q?DVpi7HsYFEPCWvT9WNRwAsjBfOggWIy7UEJH1K4rGKaYyPlhgVGpfWOVn+wg?=
 =?us-ascii?Q?BkpvjQ8bLvKtjnmr9GZlHnx7yaptZFVD123m785HVQOm92XEpn6VdPacmy0d?=
 =?us-ascii?Q?xs5DvJaSnet9p1loJC9wkFo4urQoD4Lvy6855nf9SYOYcW+wfG/C1re015Pv?=
 =?us-ascii?Q?SsPGCyavjxGj7MFiKoDf3mb93FOcn0k+IKyeJuiDosHVTSSLfTh+ISRH2Xi9?=
 =?us-ascii?Q?F9se+rnWW64uIv8bmfx+S/zfCSTNsrFQr3Fwp6B7y2IKv2juKcTl7UvOWU9J?=
 =?us-ascii?Q?xszKjoZ9+RPQDxDpua09xw7qXk0JT2j3i+nRLcsgD0k2Ed8EYgLPOwdi4U+R?=
 =?us-ascii?Q?nKvlGq5kMWO46JrBiR+O2jIeH9GZyFpi4d0kkaZWZwhSrh0BwnHw496b1VT+?=
 =?us-ascii?Q?ciIMDc2G3xHzPbVChZ27N9DuQ2w6C9+CD/ShcB03zAWPyH+Nbl2GFqfwbdUo?=
 =?us-ascii?Q?7/kVkf96yrkXwfjTIaN38eLJRZULYspJA5c7Ta/ivHKaZPDrbyUNT/0kPqaa?=
 =?us-ascii?Q?IIWWJAV+YpgsA+IPUxOQvcxuNt7bQeTCwS8/F0zv?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 97eb605c-b1cd-4a9b-a7e5-08ddd9e3c095
X-MS-Exchange-CrossTenant-AuthSource: PH3PPF9E162731D.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 21:03:57.0455
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IbeQ7HoXbzg7aFj+N+uyoj5N0y5UgNkSXgbLHiGWqyaHtmrLc+cSlKvdAI3ghIsYT8JbiJ2U3W3fjJ/pBWdhlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5306
X-OriginatorOrg: intel.com

Sean Christopherson wrote:
> On Thu, Aug 07, 2025, Sagi Shahar wrote:
> > From: Erdem Aktas <erdemaktas@google.com>

[snip]

> > +
> > +static void load_td_memory_region(struct kvm_vm *vm,
> > +				  struct userspace_mem_region *region)
> > +{
> > +	const struct sparsebit *pages = region->protected_phy_pages;
> > +	const vm_paddr_t gpa_base = region->region.guest_phys_addr;
> > +	const uint64_t hva_base = region->region.userspace_addr;
> > +	const sparsebit_idx_t lowest_page_in_region = gpa_base >> vm->page_shift;
> > +
> > +	sparsebit_idx_t i;
> > +	sparsebit_idx_t j;
> > +
> > +	if (!sparsebit_any_set(pages))
> > +		return;
> > +
> > +	sparsebit_for_each_set_range(pages, i, j) {
> > +		const uint64_t size_to_load = (j - i + 1) * vm->page_size;
> > +		const uint64_t offset =
> > +			(i - lowest_page_in_region) * vm->page_size;
> > +		const uint64_t hva = hva_base + offset;
> > +		const uint64_t gpa = gpa_base + offset;
> > +		void *source_addr;
> > +
> > +		/*
> > +		 * KVM_TDX_INIT_MEM_REGION ioctl cannot encrypt memory in place.
> 
> We should really fix that.

I'm working on it.

This code will change with those changes.  But I'd like this to land, or
be close to landing, first.

Ira

[snip]

