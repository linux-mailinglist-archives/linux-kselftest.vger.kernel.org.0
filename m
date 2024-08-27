Return-Path: <linux-kselftest+bounces-16410-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DC09960E45
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2024 16:47:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5618D286831
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2024 14:47:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A34AC1C6881;
	Tue, 27 Aug 2024 14:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e5aweuVf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00A1D73466
	for <linux-kselftest@vger.kernel.org>; Tue, 27 Aug 2024 14:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724770000; cv=fail; b=P/YxLemWwf7giO/06NDMlpWxOXHYDSlslqnLCCjcBYnDISr3mXgc01ERyoJRPqpbz6ui2bhjHVqqOPGLYAhIgaeHMYoGcKgihRaOnRxPyCemmwwlKVNuSgQhP7zZZxociFpw3dKLEqhjyVuh0BbCPwGD8YxQnzo3UO6WJohufQk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724770000; c=relaxed/simple;
	bh=W2oENvYtHcOK897JOwtWF4B/JRiRLHmv2KLqLdDkojs=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DD6zGnbgMFiuOryDib/g70wBQd05hnQ60bK+HDpuMx8e305StIKp1zRR94EI1LgAEvgVRHmmjIcOWFfHs9NVF6JXv7j7npAVEw9FoncirDfp3OuuvJBTZt+zAnyXGG7bZzpzbk4AGuaV1dkztLXmpfMzUkkTb/IvoA84Jt7Nr9o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e5aweuVf; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724769998; x=1756305998;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=W2oENvYtHcOK897JOwtWF4B/JRiRLHmv2KLqLdDkojs=;
  b=e5aweuVf5NED31AjcGFU/M7q1VG4caZvKyk+SJ1ahayPNT6u/IVhgVN7
   hyhDEWxe1XzhGXhdLGGNvqkABMQnni/H96xhFj4o/lFqyK+I0YcNfz+/j
   wkHwbbknBOMVrMbxfYsvf9aZH68ECXzyFFbbjZT7VDv9Clmd7Eo4E4bs3
   m1Z61erWrzFVsDf9/RGfbAdTHOzGNNKchk5pZHuBO5Pk9I1t1pQlWJtdt
   f1FEJtlLJpKpZf+wM+I0l0RH4pibxvH6NPZ8s8k/gCZcfVs9hhTNLr+d0
   dZ4LI2+W3VQ+i+4nWJVdZTOLdq8Hd4WjNmwc8LSCAvb7FqjJdawyvZWSz
   w==;
X-CSE-ConnectionGUID: XFZqUK/bStmtH14VFHkmMw==
X-CSE-MsgGUID: fAdXQFjxTA6y2JigkC56rQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11177"; a="22845039"
X-IronPort-AV: E=Sophos;i="6.10,180,1719903600"; 
   d="scan'208";a="22845039"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2024 07:46:37 -0700
X-CSE-ConnectionGUID: GaJeSRCcS4m07zkKiCKCBA==
X-CSE-MsgGUID: Bg5k/5zkTKaj843xzu/flA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,180,1719903600"; 
   d="scan'208";a="67231673"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Aug 2024 07:46:38 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 27 Aug 2024 07:46:36 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 27 Aug 2024 07:46:36 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 27 Aug 2024 07:46:36 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.170)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 27 Aug 2024 07:46:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zN+WB0zXzXrZb6boQpdbIjj/jAJqpYvTzfzwbwFtJdaGu6TFuljOLqBZNqt4OxC3NZi/myxISMAlBKeCMMxBtUXP2rygNS7/Gk25Hd3pfc/a8iVBiMGOIJmwb3ybDB37MtNby+DdFqMId3278/OQ6t/3TQV/wmUSD/kdoEeZTMAi8BolJsBjaOk+KpFt59huw06yTUmrKq8vNBsnMRFkX3EkljwyvaFB5n1cyr0GQMP5guYOXUBoka60rx8TYWpvOTLQMrShdwyFlOxhn/HXtCFm1qPKfhaWqmWmPI6GitdMoDb9okoE6+f0lPgs6EIEHWkywJn8InkUH4lekncnIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=II0WaEVBL/QguNCaexX0mFSszVNxZdpxb+qbt07pe/Q=;
 b=OhdYAYvg9BL0NhyA5eR6RG47+xIoyk54f/jEG4jkFl6D3Wvv8pQt9A+Lz32untvk86XACLLfBq6pc6km4YPxDR5+ouTQRly8FRujKYIjGJx0Ojg2DwhzQP3sY6frrPHIybGcsM798ef/f/wp1zcuZMSUMHmXZS/Qk97RSsSObTKbSmw2PdCsQj6ts2XPPmLgmsje0qwUR5SHtmKK2XwrPPSuo5w/XlnRoDxcEffaMnxjkQIUCttc6cZ5s+EviHq4bAbi6bY5Ls3yY2QPdx4aqfpkfac4b+piqoTRss6k1fu+W5vo2kEmhjorgYriJLe1eK6dol9B1eKWhAM46hY3BA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6139.namprd11.prod.outlook.com (2603:10b6:930:29::17)
 by PH7PR11MB8251.namprd11.prod.outlook.com (2603:10b6:510:1a9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Tue, 27 Aug
 2024 14:46:32 +0000
Received: from CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::7141:316f:77a0:9c44]) by CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::7141:316f:77a0:9c44%7]) with mapi id 15.20.7897.021; Tue, 27 Aug 2024
 14:46:32 +0000
Date: Tue, 27 Aug 2024 09:46:28 -0500
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: Michal Wajdeczko <michal.wajdeczko@intel.com>
CC: <linux-kselftest@vger.kernel.org>, <kunit-dev@googlegroups.com>, Rae Moar
	<rmoar@google.com>, David Gow <davidgow@google.com>, Daniel Latypov
	<dlatypov@google.com>
Subject: Re: [PATCH v2 4/6] kunit: Allow function redirection outside of the
 KUnit thread
Message-ID: <xhciaodcnfjqe633zly2zkijzbi3ltfozewkyvkanpycclccte@ifoydlvgdnui>
References: <20240826222015.1484-1-michal.wajdeczko@intel.com>
 <20240826222015.1484-5-michal.wajdeczko@intel.com>
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Disposition: inline
In-Reply-To: <20240826222015.1484-5-michal.wajdeczko@intel.com>
X-ClientProxiedBy: MW4PR04CA0101.namprd04.prod.outlook.com
 (2603:10b6:303:83::16) To CY5PR11MB6139.namprd11.prod.outlook.com
 (2603:10b6:930:29::17)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6139:EE_|PH7PR11MB8251:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e1f5f2c-bcda-4fb8-6b50-08dcc6a70a77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?bxrlfxevDK+f4zeZFm41jQaOOLsqtgART8Pv0DeXIDIWdzRyWSnOlY5ABnZw?=
 =?us-ascii?Q?5a4rWxnyxxJvuaH/yiGzryIaIleCS6EopNplTetb9GZYedrfW5V78sMRQur+?=
 =?us-ascii?Q?x+iw4xs4JeRZUIuUM62Tpi6XxpnSFtAALR9IL8SU/v1CENiY4fdr/I8GYZv7?=
 =?us-ascii?Q?vcx8Wo8S3yCIUxD2Luz+Pf2Xw8lZ8jrSVkkK4IVsX2nsBFpGQuTxe8XXzKCB?=
 =?us-ascii?Q?5CNcWGe5I4Klj+uba1xwwdBEJA+qLcyXyeUnqV+p7cJA0IxNK0b1Ht9miWJk?=
 =?us-ascii?Q?nP+/SWRdYRNdt5pKH8cA0x9WGY7oeO8WaTkYH3JXzq+e/TU31kxllEcD9RRe?=
 =?us-ascii?Q?MZC71Ml9s4MRudHfLEa/6+7ZB6PUWaF3Y9HOAVSAJszZVMKenD9bl5ZN/I5D?=
 =?us-ascii?Q?4g6Q0E6A3g33bI7qDEc3D3CXJhqJto1A5d8Lh2HsdZzi8nSwYR26L5iXJ9zh?=
 =?us-ascii?Q?YEMHGDRaMqovmLwLTui4HfDrlTkYfN3+CSwjS9qTNnsUEcJ4kKjKU7MpE57t?=
 =?us-ascii?Q?pcCk2OKWTnXadl6NTR03SWQc9YM7Q0ml7JR7lgZldnXjFIq7zo/2a+ZwKEmi?=
 =?us-ascii?Q?+8zbfL5uX9sU/UUaCxZgaXiaKnMtMiGbB0oBlgeQgFYBYAA+iOwNheUNLu5I?=
 =?us-ascii?Q?UE2GP6RYVs6OKUmw3xrdFBtXn2WFTbsLkY3MR3daU94pdhmcALxqo86fWkJ7?=
 =?us-ascii?Q?wC/EymOnNe3FimcSOB5qZvzsZUZAgTDbqhd/+z7IvhSHDjlauxW4/KwQbmUf?=
 =?us-ascii?Q?elkP+Lt+qeVbUWq9OORAHdNh48tOAuJTVMD5E09Sfr8FpbCcLDBSU75hTmA4?=
 =?us-ascii?Q?OHZhpa6zUobJDBQPGSh0CPsF0oYM5VKy6zYmQFt/UDAVVworJaltpZNHNJm/?=
 =?us-ascii?Q?FlCDqmqL1gxqebOXRRbqmNdrniOxDKO3mEPekCHKuj1myh7zd5uUoI7lzT+v?=
 =?us-ascii?Q?C9k5VcecVpAsRDTVU5n6+unNCsR1KY8ObiKZLV4mjgMIuSqTazHj/evB4Sf0?=
 =?us-ascii?Q?o4goDq1lKHIVjzLrUZ4TkDQYQbBrAkzCwSvr3XZYuPqXvS31vd4qlYkhPECW?=
 =?us-ascii?Q?TgRL1qn4+vp9wMJ++d1kaqxsehZDn7B1FY2xD5I5BZty07te6qmqs4L4R9IA?=
 =?us-ascii?Q?WvfZ5mi3o29pVL9Jm8IH6SBnAP3G4k/4c/2ouB+Qx4cy+emfRJpgCKCHZBs0?=
 =?us-ascii?Q?i+tFVSRBwQt13zHE5uvcCT4earz5UfelrU3za1V92/KTOKVKu+kC2b/v4uPx?=
 =?us-ascii?Q?ALi1fZMpHTsvsRKebRHR7uj+s0mEDLNKa6t+d0jJ5g+aadIRDQHkHOkHmx/B?=
 =?us-ascii?Q?CMziOcpFtj/k4eY0mVwzHYCBna66OCBqUc54Gj7LVBZfkQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6139.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?U2wNHVGd8pEhIcllAKR0LuthfyiYuwl0iaBvqEjGWvukoTQ6uI/wBhQ5FEIY?=
 =?us-ascii?Q?G5xsw+faadr/xrx7fuIAwbGR6K09Z/yV6i5k4J73MVZ2S2v3/sF3QVf0NxAI?=
 =?us-ascii?Q?SZoFxfTDrlspT8E6RQyPAW9A7NxXQsNzc/8LrTOPZLU3ajuDv0EkvpRK/cwG?=
 =?us-ascii?Q?GY0PQEe5fMfnWIzAzPNjsS/OIwfl2lJmNgm+3JXf/YxBz3FWrcBraLiranPA?=
 =?us-ascii?Q?G8AcC/nHoovc3uSCbFMLyc9HYr/iiNRWMzw9oxb2ogZDvSZgw1XPO9az6Dil?=
 =?us-ascii?Q?igosbFlW9WceXYue7sBdtXfD2CFPj4GtxLIuUKEpMTZhVbd1TkuedDGaww66?=
 =?us-ascii?Q?TUplMS5N+WnE7NSiquHEwfRiLn1/3zCMwM4HNTDbNbmDXG68n4glE+WPzeMB?=
 =?us-ascii?Q?kNH+F6pQN80uEXLYYs7YOPUBW8aCOY4clJua50Blm5ulnotgL8AzfQ/9cjIi?=
 =?us-ascii?Q?AxusII0ByCxTvfLejudquL5wDl4P9DzxKqQV3NZUXmGyFhIadlJWoWUs5WJc?=
 =?us-ascii?Q?T+UE4ClnU2ic1DAQH+mUXWbc0CHXtwdP/59uP0b9sWuDUaOmvz7MwgqqngoZ?=
 =?us-ascii?Q?h7fh4yw2QC1Qd7EHXmhUY71z7oGLCfAOUWmR9i62jlKw8umfrWecdWqHtFKp?=
 =?us-ascii?Q?3nRU0MQBa10uqs1e0HdlfHxiFAOGEIIZhBj6wy/ztCXwgbxklWHx9jxJBMBB?=
 =?us-ascii?Q?9f2RtoCSBwXzeMAptZmBxzYJ7KNCU7I9966sEFOI666xkuzbOdLdq2XpxHU1?=
 =?us-ascii?Q?9/7Decp68QDgwhU74Wn4+J0rumIYJFD3ER8sB/XpBFW4SdArAZ6WWS2Jsg66?=
 =?us-ascii?Q?tjFA6MKtIhdUovY7PQO7AS+gjxmhBTUyftoNJLXZoZbBtmOofLBrRqFHE1/x?=
 =?us-ascii?Q?RiQ9p1dKnwHmnxO58sFZo+nOJxyx5tRa85ijtcMoxUdswvmMqyCHuEuPLan2?=
 =?us-ascii?Q?fQXxOi3eduvcSBxAL2pgrh+utwwfreKFhhthn3ZYxpo4y072TrOzvvOkxWwp?=
 =?us-ascii?Q?9BCNI5PtjvLtepWyLsrR7Olwxb4eYeFLOMxjNB1OyHm7+VsAJILYHGBizWtk?=
 =?us-ascii?Q?XoVun1n9q7VeTujMXCRV66jTfvJ3V2fF/ahBCBQLwfY9sevO9Q9KeOhvz80X?=
 =?us-ascii?Q?te5Dtm8ThLB/kt5+ptgkKQYiuUaiDttBzFRvOpf/uOv+1pYpPdRNC/d3nXMi?=
 =?us-ascii?Q?4O3ZAaaVxCHobL6+bLxeYL3w7gxWZez7+RzuVx2mle2Igo+4tLJNjiwDqAMv?=
 =?us-ascii?Q?CQ7JfEzAr49bkFUquL19Yo6i69sAHOpjs5Vfsi8ZTJ/OYQUt5GcUrjhTv781?=
 =?us-ascii?Q?zHu+i6dYrhF5qB9thOaWEF59GKIWtZsn4HsjrskOJV2iZLpaecPs1SChTwvR?=
 =?us-ascii?Q?QQLFGKhCNAUfaiNhPrgRQfXDS1UpnQWJMTTzF0ZN73Xs/fPcAlyOwANF1vKk?=
 =?us-ascii?Q?8uPuL0YsGanCu9FRBlSSiNJf0ASIz8uWsi7EJWoaeivRAaKlHPUHES1rEKpX?=
 =?us-ascii?Q?22qMjcBUEEb76QhZzoC2lyFarJjZmrwrZQMv+XGIeCDvUa2WtyJyGXcT78bK?=
 =?us-ascii?Q?1GBo9uHB+BP46DI6dmtaYvIflDpwbH8loRT/DQ8jWHFRcXm81KgSMygVG8Xy?=
 =?us-ascii?Q?uw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e1f5f2c-bcda-4fb8-6b50-08dcc6a70a77
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6139.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 14:46:31.9119
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T8KfhrWYGXsPcB/lAlSSfdjSWNS45tMsIGuBcYhgs0UQlM5v2HukZFwN5GsKIvWdf93KYt2U/itzkpYoFgPQwTTgxGyUThF5CSF/B9ibdTY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8251
X-OriginatorOrg: intel.com

On Tue, Aug 27, 2024 at 12:20:13AM GMT, Michal Wajdeczko wrote:
>Currently, the 'static stub' API only allows function redirection
>for calls made from the kthread of the current test, which prevents
>the use of this functionality when the tested code is also used by
>other threads, outside of the KUnit test, like from the workqueue.
>
>Add another set of macros to allow redirection to the replacement
>functions, which, unlike the KUNIT_STATIC_STUB_REDIRECT, will
>affect all calls done during the test execution.
>
>These new stubs, named 'global', must be declared using dedicated
>KUNIT_DECLARE_GLOBAL_STUB() macro and then can be placed either as
>global static variables or as part of the other structures.
>
>To properly maintain stubs lifecycle, they can be activated only
>from the main KUnit context. Some precaution is taken to avoid
>changing or deactivating replacement functions if one is still
>used by other thread.
>
>Signed-off-by: Michal Wajdeczko <michal.wajdeczko@intel.com>
>---
>Cc: Rae Moar <rmoar@google.com>
>Cc: David Gow <davidgow@google.com>
>Cc: Daniel Latypov <dlatypov@google.com>
>Cc: Lucas De Marchi <lucas.demarchi@intel.com>
>---
>v2: s/FIXED_STUB/GLOBAL_STUB (David, Lucas)
>    make it little more thread safe (Rae, David)
>    wait until stub call finishes before test end (David)
>    wait until stub call finishes before changing stub (David)
>    allow stub deactivation (Rae)
>    prefer kunit log (David)
>---
> include/kunit/static_stub.h | 158 ++++++++++++++++++++++++++++++++++++
> lib/kunit/static_stub.c     |  49 +++++++++++
> 2 files changed, 207 insertions(+)
>
>diff --git a/include/kunit/static_stub.h b/include/kunit/static_stub.h
>index bf940322dfc0..42a70dcefb56 100644
>--- a/include/kunit/static_stub.h
>+++ b/include/kunit/static_stub.h
>@@ -12,12 +12,15 @@
>
> /* If CONFIG_KUNIT is not enabled, these stubs quietly disappear. */
> #define KUNIT_STATIC_STUB_REDIRECT(real_fn_name, args...) do {} while (0)
>+#define KUNIT_GLOBAL_STUB_REDIRECT(stub_name, args...) do {} while (0)
>+#define KUNIT_DECLARE_GLOBAL_STUB(stub_name, stub_type)
>
> #else
>
> #include <kunit/test.h>
> #include <kunit/test-bug.h>
>
>+#include <linux/cleanup.h> /* for CLASS */
> #include <linux/compiler.h> /* for {un,}likely() */
> #include <linux/sched.h> /* for task_struct */
>
>@@ -109,5 +112,160 @@ void __kunit_activate_static_stub(struct kunit *test,
>  */
> void kunit_deactivate_static_stub(struct kunit *test, void *real_fn_addr);
>
>+/**
>+ * struct kunit_global_stub - Represents a context of global function stub.
>+ * @replacement: The address of replacement function.
>+ * @owner: The KUnit test that owns the stub, valid only when @busy > 0.
>+ * @busy: The stub busyness counter incremented on entry to the replacement
>+ *        function, decremented on exit, used to signal if the stub is idle.
>+ * @idle: The completion state to indicate when the stub is idle again.
>+ *
>+ * This structure is for KUnit internal use only.
>+ * See KUNIT_DECLARE_GLOBAL_STUB().
>+ */
>+struct kunit_global_stub {
>+	void *replacement;
>+	struct kunit *owner;
>+	atomic_t busy;
>+	struct completion idle;
>+};
>+
>+/**
>+ * KUNIT_DECLARE_GLOBAL_STUB() - Declare a global function stub.
>+ * @stub_name: The name of the stub, must be a valid identifier
>+ * @stub_type: The type of the function that this stub will replace
>+ *
>+ * This macro will declare new identifier of an anonymous type that will
>+ * represent global stub function that could be used by KUnit. It can be stored
>+ * outside of the KUnit code. If the CONFIG_KUNIT is not enabled this will
>+ * be evaluated to an empty statement.
>+ *
>+ * The anonymous type introduced by this macro is mostly a wrapper to generic
>+ * struct kunit_global_stub but with additional dummy member, that is never
>+ * used directly, but is needed to maintain the type of the stub function.
>+ */
>+#define KUNIT_DECLARE_GLOBAL_STUB(stub_name, stub_type)				\
>+union {										\
>+	struct kunit_global_stub base;						\
>+	typeof(stub_type) dummy;						\
>+} stub_name
>+
>+/* Internal struct to define guard class */
>+struct kunit_global_stub_guard {
>+	struct kunit_global_stub *stub;
>+	void *active_replacement;
>+};
>+
>+/* Internal class used to guard stub calls */
>+DEFINE_CLASS(kunit_global_stub_guard,
>+	     struct kunit_global_stub_guard,
>+	     ({
>+		struct kunit_global_stub *stub = _T.stub;
>+		bool active = !!_T.active_replacement;

I'd call this `bool active_replacement` as it's not the same thing as
the active below.

>+
>+		if (active && !atomic_dec_return(&stub->busy))
>+			complete_all(&stub->idle);
>+	     }),
>+	     ({
>+		class_kunit_global_stub_guard_t guard;
>+		bool active = !!atomic_inc_not_zero(&stub->busy);
>+
>+		guard.stub = stub;
>+		guard.active_replacement = active ? READ_ONCE(stub->replacement) : NULL;
>+
>+		guard;
>+	     }),
>+	     struct kunit_global_stub *stub)
>+
>+/**
>+ * KUNIT_GLOBAL_STUB_REDIRECT() - Call a fixed function stub if activated.
>+ * @stub: The function stub declared using KUNIT_DECLARE_GLOBAL_STUB()
>+ * @args: All of the arguments passed to this stub
>+ *
>+ * This is a function prologue which is used to allow calls to the current
>+ * function to be redirected if a KUnit is running. If the KUnit is not
>+ * running or stub is not yet activated the function will continue execution
>+ * as normal.
>+ *
>+ * The function stub must be declared with KUNIT_DECLARE_GLOBAL_STUB() that is
>+ * stored in a place that is accessible from both the test code, which will
>+ * activate this stub using kunit_activate_global_stub(), and from the function,
>+ * where we will do this redirection using KUNIT_GLOBAL_STUB_REDIRECT().
>+ *
>+ * Unlike the KUNIT_STATIC_STUB_REDIRECT(), this redirection will work
>+ * even if the caller is not in a KUnit context (like a worker thread).
>+ *
>+ * Example:
>+ *
>+ * .. code-block:: c
>+ *
>+ *	KUNIT_DECLARE_GLOBAL_STUB(func_stub, int (*)(int n));
>+ *
>+ *	int real_func(int n)
>+ *	{
>+ *		KUNIT_GLOBAL_STUB_REDIRECT(func_stub, n);
>+ *		return n + 1;
>+ *	}
>+ *
>+ *	int replacement_func(int n)
>+ *	{
>+ *		return n + 100;
>+ *	}
>+ *
>+ *	void example_test(struct kunit *test)
>+ *	{
>+ *		KUNIT_EXPECT_EQ(test, real_func(1), 2);
>+ *		kunit_activate_global_stub(test, func_stub, replacement_func);
>+ *		KUNIT_EXPECT_EQ(test, real_func(1), 101);
>+ *	}
>+ */
>+#define KUNIT_GLOBAL_STUB_REDIRECT(stub, args...) do {					\
>+	if (kunit_is_running()) {							\
>+		typeof(stub) *__stub = &(stub);						\
>+		CLASS(kunit_global_stub_guard, guard)(&__stub->base);			\
>+		typeof(__stub->dummy) replacement = guard.active_replacement;		\
>+		if (unlikely(replacement)) {						\
>+			kunit_info(__stub->base.owner, "%s: redirecting to %ps\n",	\
>+				   __func__, replacement);				\
>+			return replacement(args);					\
>+		}									\
>+	}										\
>+} while (0)
>+
>+void __kunit_activate_global_stub(struct kunit *test, struct kunit_global_stub *stub,
>+				  void *replacement_addr);
>+
>+/**
>+ * kunit_activate_global_stub() - Setup a fixed function stub.

s/fixed/global/ here and every where else below

>+ * @test: Test case that wants to activate a fixed function stub
>+ * @stub: The location of the function stub pointer
>+ * @replacement: The replacement function
>+ *
>+ * This helper setups a function stub with the replacement function.
>+ * It will also automatically deactivate the stub at the test end.
>+ *
>+ * The redirection can be disabled with kunit_deactivate_global_stub().
>+ * The stub must be declared using KUNIT_DECLARE_GLOBAL_STUB().
>+ */
>+#define kunit_activate_global_stub(test, stub, replacement) do {		\
>+	typeof(stub) *__stub = &(stub);						\
>+	typecheck_fn(typeof(__stub->dummy), (replacement));			\
>+	__kunit_activate_global_stub((test), &__stub->base, (replacement));	\
>+} while (0)
>+
>+void __kunit_deactivate_global_stub(struct kunit *test, struct kunit_global_stub *stub);
>+
>+/**
>+ * kunit_deactivate_global_stub() - Disable a fixed function stub.
>+ * @test: Test case that wants to deactivate a fixed function stub
>+ * @stub: The location of the function stub pointer
>+ *
>+ * The stub must be declared using KUNIT_DECLARE_GLOBAL_STUB().
>+ */
>+#define kunit_deactivate_global_stub(test, stub) do {				\
>+	typeof(stub) *__stub = &(stub);						\
>+	__kunit_deactivate_global_stub((test), &__stub->base);			\
>+} while (0)
>+
> #endif
> #endif
>diff --git a/lib/kunit/static_stub.c b/lib/kunit/static_stub.c
>index 92b2cccd5e76..799a7271dc5b 100644
>--- a/lib/kunit/static_stub.c
>+++ b/lib/kunit/static_stub.c
>@@ -121,3 +121,52 @@ void __kunit_activate_static_stub(struct kunit *test,
> 	}
> }
> EXPORT_SYMBOL_GPL(__kunit_activate_static_stub);
>+
>+static void sanitize_global_stub(void *data)
>+{
>+	struct kunit *test = kunit_get_current_test();
>+	struct kunit_global_stub *stub =  data;
>+
>+	KUNIT_EXPECT_NE(test, 0, atomic_read(&stub->busy));

shouldn't sanitize_ be unconditional and do nothing in this case?

>+	KUNIT_EXPECT_PTR_EQ(test, test, READ_ONCE(stub->owner));
>+
>+	reinit_completion(&stub->idle);
>+	if (!atomic_dec_and_test(&stub->busy)) {
>+		kunit_info(test, "waiting for %ps\n", stub->replacement);
>+		KUNIT_EXPECT_EQ(test, 0, wait_for_completion_interruptible(&stub->idle));

what's preventing stub->busy going to 1 again after this?

Lucas De Marchi

>+	}
>+
>+	WRITE_ONCE(stub->owner, NULL);
>+	WRITE_ONCE(stub->replacement, NULL);
>+}
>+
>+/*
>+ * Helper function for kunit_activate_global_stub(). The macro does
>+ * typechecking, so use it instead.
>+ */
>+void __kunit_activate_global_stub(struct kunit *test,
>+				  struct kunit_global_stub *stub,
>+				  void *replacement_addr)
>+{
>+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, stub);
>+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, replacement_addr);
>+	if (atomic_read(&stub->busy))
>+		kunit_release_action(test, sanitize_global_stub, stub);
>+	else
>+		init_completion(&stub->idle);
>+	WRITE_ONCE(stub->owner, test);
>+	WRITE_ONCE(stub->replacement, replacement_addr);
>+	KUNIT_ASSERT_EQ(test, 1, atomic_inc_return(&stub->busy));
>+	KUNIT_ASSERT_EQ(test, 0, kunit_add_action_or_reset(test, sanitize_global_stub, stub));
>+}
>+EXPORT_SYMBOL_GPL(__kunit_activate_global_stub);
>+
>+/*
>+ * Helper function for kunit_deactivate_global_stub(). Use it instead.
>+ */
>+void __kunit_deactivate_global_stub(struct kunit *test, struct kunit_global_stub *stub)
>+{
>+	if (atomic_read(&stub->busy))
>+		kunit_release_action(test, sanitize_global_stub, stub);
>+}
>+EXPORT_SYMBOL_GPL(__kunit_deactivate_global_stub);
>-- 
>2.43.0
>

