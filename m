Return-Path: <linux-kselftest+bounces-44360-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B2D9C1D6CB
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Oct 2025 22:25:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E228C4E27E2
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Oct 2025 21:25:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91E47319619;
	Wed, 29 Oct 2025 21:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ntwdh9jE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A2C299A8F;
	Wed, 29 Oct 2025 21:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761773091; cv=fail; b=Q3/Th/5Argkr70G/HWDow+i9bM4JNjZ4Js5RyNxwVVq4CeWgG74zMK0VSbqZrsIZ4NTpri7dHdsFY1CnozLPV4oyV/eEYKmobgg+fsGSyyPo08T6CUxQRg9vkcZzlcxVglepZka01Oot4TwaXAY9g+68Zs0sFWLiLfIWzneQW/4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761773091; c=relaxed/simple;
	bh=2xAVKTig7kHT/VekESm8nSW0uJ0zTxE2Ha/ITdfpfqo=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DGEd6EgxaNeOftHSLExeXyNQF0Y38vnQkXYhYVvarNs1g4dCF1sYVq3tGiBKEOdQr66aXfcBAeZZYGBcwkBdNwYCVSALPneq10Td61jAa/p2AYuJBvQcj9XniEUS5PCAVkdVV6I7qalxWIJ/tqHRffbUmYtN1eurvoMblynFio0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ntwdh9jE; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761773090; x=1793309090;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=2xAVKTig7kHT/VekESm8nSW0uJ0zTxE2Ha/ITdfpfqo=;
  b=Ntwdh9jE/5N006E0ZAzVPJJJEYloAwzYc8WuZYe6pUehP6XLyOIcb0h5
   TlhYndYK+X4ijmuja1NoufHFUbKmPg1NxNRsLShn5dXH1+deXZoHCGHlF
   EIXRKgOqX/evlws4j4KUv8JODgemvuC72fLJgbDEuy/GdbCBskRwMsjQ7
   oTfL0l6YBpDGo3FSGXCTQejl8l8EJLXYZHp6rkXF3YzCF2FCHmPgNIDZ1
   yg3g3V3h/iRDsZ6WiuHjkjbmvzwqXznOS1PxdC24qoUwBDqXrmJtsF7Hp
   uRqzEBCn95Sqlbt+AES3xCeeOxo3ryVSb/T39pTW68yhWv5y91XBMc2mt
   Q==;
X-CSE-ConnectionGUID: 3gsAGVBbTFujM9B9PySIGw==
X-CSE-MsgGUID: xWgv4oBnQLy/LB7zhtY64Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11597"; a="63791194"
X-IronPort-AV: E=Sophos;i="6.19,265,1754982000"; 
   d="scan'208";a="63791194"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2025 14:24:48 -0700
X-CSE-ConnectionGUID: 2eWB77pNRmm31CbYXN+uMg==
X-CSE-MsgGUID: g2nPNuCfRWOMsml/B2qopQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,265,1754982000"; 
   d="scan'208";a="185653315"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2025 14:24:47 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 29 Oct 2025 14:24:46 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 29 Oct 2025 14:24:46 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.28)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 29 Oct 2025 14:24:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bDwlbjHDjZm/A7gKAdmTLigeNhScNLgFcw5pGTuPVp/9yWi9AFkvm/XfgFnq/UNIEAtSuFWv6zJ3CUwEyG8B4P2u5Nn62LnH68GyiafBvbDvH4OuZHuBAhdd2m0HMpcJdKxUfDKGCRVLyCHxkUPwAcl/9mIKDtZF0YPDInEI+25e/N4rK8xJtge37Lmp4t65dg9lOPgwCa0KbBoWyXaWG4tBJ+YzfV6yH+OzeIClkQH9xzU3ZGVSqV8JEtrp2kaQVVheXIL4We3mhSZT2/f8uqlAbqq1E+DmsBlUaUjzY8kinkLa4JLdhAAKf5Xm8LvYl+spWznn9HDQm9IQYHsgzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rxwrHKSHjUX/nfJLGSPLUXRRFwH+gz+pZYc2hUmI3ZI=;
 b=wnA7FHnscg76mIzAluhWSAESa1gJkF3MMnT39WU0BvZcBvYhpNCtApy4sVf/whtQZCY8d46YbAmyZKGYTOxC7g8+JuJ7/BwtxNEorDuA1BkdkWhI0hOlTWbHOgCyIls/5Rg6d9aZ1AfCWjqZ3341Yp95YjcpmbE0AhEK2+Owehfj0+fU8pfyQ8OW9vRtKnT5qdivmLOZjKxfqDswMBQNk0MqhBNy+s4fiEulEM3+Fb+Wem8D2qm6q8Da0IR1Bt1afmb95s4qfC1JuUMQTp+v90iVQwP8mxK8huNX42MO2/JnlIicETC27wnjqgTbY+IaBJ87uLm2Ec3wG1rOwL9vrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH3PPF9E162731D.namprd11.prod.outlook.com
 (2603:10b6:518:1::d3c) by CY8PR11MB6937.namprd11.prod.outlook.com
 (2603:10b6:930:5b::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Wed, 29 Oct
 2025 21:24:43 +0000
Received: from PH3PPF9E162731D.namprd11.prod.outlook.com
 ([fe80::8289:cecc:ea5b:f0c]) by PH3PPF9E162731D.namprd11.prod.outlook.com
 ([fe80::8289:cecc:ea5b:f0c%8]) with mapi id 15.20.9275.011; Wed, 29 Oct 2025
 21:24:43 +0000
Date: Wed, 29 Oct 2025 16:27:04 -0500
From: Ira Weiny <ira.weiny@intel.com>
To: Sagi Shahar <sagis@google.com>, <linux-kselftest@vger.kernel.org>, "Paolo
 Bonzini" <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, "Sean
 Christopherson" <seanjc@google.com>, Ackerley Tng <ackerleytng@google.com>,
	Ryan Afranji <afranji@google.com>, Andrew Jones <ajones@ventanamicro.com>,
	Isaku Yamahata <isaku.yamahata@intel.com>, Erdem Aktas
	<erdemaktas@google.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, "Roger
 Wang" <runanwang@google.com>, Binbin Wu <binbin.wu@linux.intel.com>, "Oliver
 Upton" <oliver.upton@linux.dev>, "Pratik R. Sampat"
	<pratikrajesh.sampat@amd.com>, Reinette Chatre <reinette.chatre@intel.com>,
	Ira Weiny <ira.weiny@intel.com>, Chao Gao <chao.gao@intel.com>, Chenyi Qiang
	<chenyi.qiang@intel.com>
CC: <linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>
Subject: Re: [PATCH v12 14/23] KVM: selftests: Add helpers to init TDX memory
 and finalize VM
Message-ID: <690286a88f75_21ab52100de@iweiny-mobl.notmuch>
References: <20251028212052.200523-1-sagis@google.com>
 <20251028212052.200523-15-sagis@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251028212052.200523-15-sagis@google.com>
X-ClientProxiedBy: BY3PR04CA0019.namprd04.prod.outlook.com
 (2603:10b6:a03:217::24) To PH3PPF9E162731D.namprd11.prod.outlook.com
 (2603:10b6:518:1::d3c)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH3PPF9E162731D:EE_|CY8PR11MB6937:EE_
X-MS-Office365-Filtering-Correlation-Id: 811e9f67-d37e-4353-f55f-08de1731939e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|921020|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5F+UZp4GuT8axN3M9jCCeVkSuhyh5edfPiZize5BBn8O5NlM4XkeV9cVlK1c?=
 =?us-ascii?Q?vkd5kwAiRlmvsTFGGHtSFPov1LQ+nBOQMbt9jY1qZPrI3TyaZ4Y9HS6xPWPV?=
 =?us-ascii?Q?zB43UGd3o0prLCUwXYTaCCzdjuchNbG0nw3q6m8n8sDKAsElygBBuVsnr35/?=
 =?us-ascii?Q?UH+T55VmQQJlcQqdxAe876xd3nW9QmKx66ZDb7Pm6/tQXVRO43OzILcQksiH?=
 =?us-ascii?Q?T+qJ59SkUqC8VCkEs+rL+CzZ8xGP64XPlg+b860vGE9FIfqx24Ae8cfiRDjm?=
 =?us-ascii?Q?DxaHTbIThZ2d0MAFaMsAhn5Th8kZD6XV7SmaqH62blstNSo2hSnwjIaGG2nZ?=
 =?us-ascii?Q?y26pmM6P+sc1wdK2rBZioxQkkITgAHF+Y8O5nDjfiN54o3pLXKeW11ohQqUg?=
 =?us-ascii?Q?VBj00rnXLBVJ7noiFKMKfd4DZ0PEqILjFGvTwK1uv90nd3HZgJjFmw1nCgyQ?=
 =?us-ascii?Q?L5QSJZcCe6wCfFJTfYGHtLeuq67ejDUmiJaDQbre9PpdI9hERdfje2r8HRfP?=
 =?us-ascii?Q?iEDhEAWHsgWVQNHtsqWfAGtX/Y4ztPuBJlrnwEhe8Fug2PpQD1cC2ecTwaaO?=
 =?us-ascii?Q?YxRy3A9CiC6lkRczkKQsYxPaD0g2RL8LaLSeEJX3I5b32qbBOe6ToMclApNt?=
 =?us-ascii?Q?pLRsci/tJaSrQFcs6ly1020amtEQgzqyllRoyznJh7g8URoB+8NGKAGzwTQo?=
 =?us-ascii?Q?O9oOYljNk6Qq1/AFOmWkFQt6CrPdWv1Ba7U2k5Z+rk9JZCgCbLkrMt4NHYTB?=
 =?us-ascii?Q?vhh9moTX2ZhyveIUOufYdE7k0vxhG+mvuVOqfMnUhOE/h9hzdC6+Qt7QMHU2?=
 =?us-ascii?Q?61Hw0Zun930FjnIdTsjMPsgngNg0ZazCtaIa6DvYPTxriJCeEAaeflTx1/4Q?=
 =?us-ascii?Q?xO/KNNiN9Osw5YTHtcLv/m5cMTyKWwEsYKK4AnffsqrZbyuzuXLF0WKbPtC0?=
 =?us-ascii?Q?+BAPKceDBnZfnSeMx370maPiA7ObVuleSMhNG0HCszTLhQw+OBgPHKmv9Hqn?=
 =?us-ascii?Q?8sHfdZKKtm6jCTKfUdveqf8BLRsZcqasM0Jjm/VAzi2TtT4iuurrmpAE6c26?=
 =?us-ascii?Q?sH6wB8Sf2ehhsPTLQKhmI5jpEtslOEtTRhBAWaxdYCgB9jdjPCkapP2AKBtJ?=
 =?us-ascii?Q?Ul/EvPYG8Knw7hVR2p+J9HafEWf2YolZ+1e7bdg2fvPBzWXG/qkDv7gUfLj6?=
 =?us-ascii?Q?2JMvggZYeCkSI/ouDC1WRBRzidVvkDICMa9BOZ8/gmkENp9IfE93ayrob3qN?=
 =?us-ascii?Q?mtCxYiDLbZuqLvF7POq3MrASfXZFAvR61/mgKtC82tbiq2BaIBdoAJeUmgHo?=
 =?us-ascii?Q?rOXa+yDgsOqfTkvkh8uIehGv395S7Y/xJ/oZhY0phJt6OF00/plaEfoavQLk?=
 =?us-ascii?Q?8T1lFRxPMak3x1Izy8hHnPBisgIIZeFIIOzsn7kqNzTCdbN1FIySUuuGb7PA?=
 =?us-ascii?Q?B094eYk8xHX2CnMsIZXedo6b22wL+DPn3R70KxP2I4fN3/kRwVvOnjZn7Huq?=
 =?us-ascii?Q?5z4gAtJl1mYvKJc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH3PPF9E162731D.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TuxkrzSdXeiW8EtsjBLJ09uUFwYz4jWjR46Hbpl5oCycmtHcn3rNwa361uXP?=
 =?us-ascii?Q?YoNYaTWVxMDNN/eHbb8fhgQWH9Y4PX4E1X46MjKQ7K+YFIxmNLAbqyJXrmAS?=
 =?us-ascii?Q?G5afwfDmDNrB+OsFyGiwotqJSa8fBnrL/Aw5tN8PxqgZg7JnPuCj6P5mUal4?=
 =?us-ascii?Q?1cqOKqwXWti4rKnsw1wY9p34cAsCw6ks5XMFyYbas0YwJpKnlCXcqzOa/RzF?=
 =?us-ascii?Q?pRLalwI3+fMD/6/LR+bxtRsQ1MXHKgIGPBAxHmENUW7BNe1PL5nte8fL6Q0l?=
 =?us-ascii?Q?UJsVTwEDu3WyDHnn/Xm4AjYRmw0eu2R910odnslNVPyoWgW6wtCMuzF9ysXB?=
 =?us-ascii?Q?SWhWz41YBHZrbZC/gzUBH+jrMI/xogebGWzaUhatZJQQ7GUGR8ZzpeURbXgP?=
 =?us-ascii?Q?uUw//OhamRu0Iigz1PJb7dhmGbw+AQWNebiBx/Q1RYo0Guo53UdD4J3K90jq?=
 =?us-ascii?Q?ye93W6V/Nramg3y2ZxdkqXnh30hBbzRvtRT/XfhU/Eq2KmI72OopOzkp2GJ3?=
 =?us-ascii?Q?XIaPSIctaXf+G9QLRPhFojt4inQfSPQrd/mN5zfiCc4P7dZoCSIPJah7nB+x?=
 =?us-ascii?Q?trpaGO2CkJ1CpNg1yiQ4DfxM/G0P2YvWfeUVsyAN6eKCHWvsZRTMcz89SoJE?=
 =?us-ascii?Q?CokXA1DCaBUAavDBeMbYl2TancaMnECTxNWhlHDEXOfu4U4Zrt0/I5H8Mj6t?=
 =?us-ascii?Q?bWjcD6V9O6nOMokahl43ETgm9btisRVFl+dn27uX59w95ILEu+cT/YAW46HD?=
 =?us-ascii?Q?NynxssGAJbcqop9MdIyGlZq5fqW18IzMAutsDnlXw9mOkVsGo+QYhkncwKV5?=
 =?us-ascii?Q?UZGme9yiRHd1M1fMjnEIJUPUKzY/Q/NNVKIX0L5tcH+mI5QCa7jrsIEXvgqn?=
 =?us-ascii?Q?PyiUZz48wvGRkLru46JRfpPadOgH2VH1tlL7DnSxMqmIEnGKcAXanG5xID/D?=
 =?us-ascii?Q?cIPmgHfdJe56A88dsg08UQKK2iB6OQUSskqpaKagE/7+K0Un9oFXpn8UmAAa?=
 =?us-ascii?Q?eGfS4E2EP4uwdAl6zrQW6q8YjKgWo9/9gqpv1ywRUfRq8z/0ZqioH6q1hC2m?=
 =?us-ascii?Q?GRvlFwcS/y4VIL8IomWqPIQrAFxafZrFPea4qWkwNYsLB3FsvIJhE2p+BSxz?=
 =?us-ascii?Q?lJKHuMNfFP6WIUrKgtZ7czt37+IinOvJf5Obp9an2batEo2xwXxrOlYbeBs2?=
 =?us-ascii?Q?rSCPowoWkRDHuK983HBTh7M0ZctfQn5r7QCbTYSKN5rRMMKS0TI39i0cdo2/?=
 =?us-ascii?Q?CG7Go6k5hB9SlXxRwPXcPQ6PMBk5/V59VqgTnXi+Zw9bvg505bvUKY2Z2rc5?=
 =?us-ascii?Q?nl02+cclz6BBYdnZJbaxkPrWR7hHxtfAuBq+o2DUlPbprgC6xE1OL0IYO2lm?=
 =?us-ascii?Q?RkZcP25b3cDdsoE39ODFUNT7zNKOqB1evxZcYMW7AP8kmG3gyUOt0QbndjCx?=
 =?us-ascii?Q?6YKVpe5xVzgcWVndvXdKsEI8hI3TAHpE128oGrUuKI4L1ifR2dmBzfyhuHcb?=
 =?us-ascii?Q?vlmKbZHlJE9CDevSWcHTZTVtDUv/eNNRfh+h4eVfmwgZIvzIITKWfmld5nrN?=
 =?us-ascii?Q?neTQRV9FWtnM2vwq4UJQ1S0NTUgWHp6JBpyzkUVa?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 811e9f67-d37e-4353-f55f-08de1731939e
X-MS-Exchange-CrossTenant-AuthSource: PH3PPF9E162731D.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 21:24:43.2355
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T4gkhiY20OpA6oz+BRdGbJehpG8HxtSA2ZBtxJ1mjOxMfqAoDLl5R5BQseu3PfK/i50xDs3sjNIgZqCycBx2eg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6937
X-OriginatorOrg: intel.com

Sagi Shahar wrote:
> From: Ackerley Tng <ackerleytng@google.com>
> 
> TDX protected memory needs to be measured and encrypted before it can be
> used by the guest. Traverse the VM's memory regions and initialize all
> the protected ranges by calling KVM_TDX_INIT_MEM_REGION.
> 
> Once all the memory is initialized, the VM can be finalized by calling
> KVM_TDX_FINALIZE_VM.
> 
> Signed-off-by: Ackerley Tng <ackerleytng@google.com>
> Co-developed-by: Erdem Aktas <erdemaktas@google.com>
> Signed-off-by: Erdem Aktas <erdemaktas@google.com>
> Co-developed-by: Sagi Shahar <sagis@google.com>
> Signed-off-by: Sagi Shahar <sagis@google.com>
> ---
>  .../selftests/kvm/include/x86/tdx/tdx_util.h  |  2 +
>  .../selftests/kvm/lib/x86/tdx/tdx_util.c      | 58 +++++++++++++++++++
>  2 files changed, 60 insertions(+)
> 
> diff --git a/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h b/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h
> index a2509959c7ce..2467b6c35557 100644
> --- a/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h
> +++ b/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h
> @@ -71,4 +71,6 @@ void vm_tdx_load_common_boot_parameters(struct kvm_vm *vm);
>  void vm_tdx_load_vcpu_boot_parameters(struct kvm_vm *vm, struct kvm_vcpu *vcpu);
>  void vm_tdx_set_vcpu_entry_point(struct kvm_vcpu *vcpu, void *guest_code);
>  
> +void vm_tdx_finalize(struct kvm_vm *vm);

FWIW this is not what I was expecting to see based on the previous
discussion.  Knowing that this call is needed later I'm inclined to let it
go but generally it would have been better to separate out this call
when/if the follow on tests require it; rather than defining this call
here without context.

That said:

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

[snip]

