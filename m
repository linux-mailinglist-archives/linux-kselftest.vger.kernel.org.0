Return-Path: <linux-kselftest+bounces-44539-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BAA5C261C2
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Oct 2025 17:28:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F9E6466DC6
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Oct 2025 16:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC3352EDD72;
	Fri, 31 Oct 2025 16:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BJ13Lrwc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D84F2ED86F;
	Fri, 31 Oct 2025 16:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761926730; cv=fail; b=oDcBQWUaFztGYsLaTKUYsLUrWKX6YRF/uKMZZ+N+Nf9hePg/t1np1bCoRBS+Dz53yLspweBs9lBO0AhMkw7+KdU71JNWC7fH1inAg8M8Ai9xcxm1WZtpsvdlc38JiEoeXJ/nY68jjB34td4FekKLV5Yzfsqb46WMGtEuqVaf84g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761926730; c=relaxed/simple;
	bh=JTrko/Txc+uyZpWXeUdiqPDPY6jyiqrnYocEFPkM8cY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=p4BCj0UZId8ZhmEjM3fVAj0juKj9+zc+EL806iw6mTeGEWoBBakaAKnxxTVhAcdd6HYQ87H2astps+CpjQ2AnbbBbFpA9uubd1LbVTJhCb6vCZ3sU6AKmw47bRW53/OQQM3/Xr3Y3blU2KxF76HbvBcd2TQFSbtcv05wlQgf5iU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BJ13Lrwc; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761926729; x=1793462729;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=JTrko/Txc+uyZpWXeUdiqPDPY6jyiqrnYocEFPkM8cY=;
  b=BJ13Lrwc41O77EVktZnPvPFEfEwzLVZ+jsopdx9UTuVnXew87bo84NsB
   eLQqadDKjFkKXHXmmrkBkGb5g+xekjjI9OW7yMFBWykxakV17gEBLqZAA
   JTnlLpN7uUXzY63uviJvSOSkVhGI/EymkzeK00SFfX72uGV701Hl1RfGY
   SJvJXjghmpK/BC2ASeuVR0daHLuZD5MHbk0V0jab+9hJM0846Vdh0ys8/
   mbZmH6Pnbzxh5OJfCe3way3Add/raFtZgUSy3Jc4V7aC+bQAF35Fq+bjz
   C3A5KvGbLw16yRE4sU2Xr/wvdE8nIhlo0xcRkAjYrmK+00aSegnYUKbwB
   Q==;
X-CSE-ConnectionGUID: KOpbVn9VQqmjCPA4xeWM6Q==
X-CSE-MsgGUID: rILqUqdkRgOjBFcQ118EOA==
X-IronPort-AV: E=McAfee;i="6800,10657,11599"; a="51662339"
X-IronPort-AV: E=Sophos;i="6.19,269,1754982000"; 
   d="scan'208";a="51662339"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2025 09:05:28 -0700
X-CSE-ConnectionGUID: ovtPTlzWTAiX+Hijigi4lw==
X-CSE-MsgGUID: 6jN03M6kTrGe6uf78YX+ow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,269,1754982000"; 
   d="scan'208";a="185484123"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2025 09:05:28 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 31 Oct 2025 09:05:27 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Fri, 31 Oct 2025 09:05:27 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.4) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 31 Oct 2025 09:05:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LWAkfRdAbPs2Um1EdN0S6xfOdSwCB3285qzvTOQe37EPN4tRZ0uYViLkJ0WD3bblvNU8wE7+8vRPdtdCIZlBcafx7yIvtJ50QMq+eycQo/1AwsBhLleunLMdqzV6JMWHmLhdvRof6IIsrKCS9SMTq9y68kIwE9aUlZqP3GQcHRLsi+w7nNTxNcRSdbiQkU51FKVcv7QtmrhFobii1BQq9Oa/pL8LSC3tYtvZ7IVJJtV2Td8/XOALcX2gh3Ja6YCFTDr5FtHFUg6BM9UQarbE5JeXrfKet2BdeWxdvrZNnzMyAYr14rdD/HBhsisP/se/HMWPU0hhcfJIT3S54dbVBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7SCW8LUi+Nk2NyFVvP7yJhdkkaG27oZZwKCtCdgqT+8=;
 b=p3ZMZcxpE85Pqb6T2RRasoKjXFpzBCaHR3sDzIkZ17+1MkznqpPDUcCnNdeA7wsdb36/hS7KxBeQugf0vbbJH8nkKC1juNn6HwAuK/TqkaO+LVEHJVkeG53smL821czHTnDXJTcoq5+4z1MBZ0XZVv/vRtIeePL3ZHW97LCFLsjToUQll4QdfvtNzOcO403EHJ7rnJaYeulSopR+sWbCnFyQtGhGu3sHw32Agd3FqNtWm+6OLGcNJA4NyZ9GZ0jovb5JTfrk3RWjqQ1cez0k3/2FOoyHO+3cTfGJpU3rNEoY5B5Udn2y8W3ce/yzyfFuEXsvWVGgt96F3PTPZXEmPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DM4PR11MB8226.namprd11.prod.outlook.com (2603:10b6:8:182::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Fri, 31 Oct
 2025 16:05:25 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.9228.015; Fri, 31 Oct 2025
 16:05:25 +0000
Message-ID: <32ae07aa-33b1-427b-bd51-394f231ea3e8@intel.com>
Date: Fri, 31 Oct 2025 09:05:22 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 19/23] KVM: selftests: Finalize TD memory as part of
 kvm_arch_vm_finalize_vcpus
To: Sagi Shahar <sagis@google.com>, <linux-kselftest@vger.kernel.org>, "Paolo
 Bonzini" <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, "Sean
 Christopherson" <seanjc@google.com>, Ackerley Tng <ackerleytng@google.com>,
	Ryan Afranji <afranji@google.com>, Andrew Jones <ajones@ventanamicro.com>,
	Isaku Yamahata <isaku.yamahata@intel.com>, Erdem Aktas
	<erdemaktas@google.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, "Roger
 Wang" <runanwang@google.com>, Binbin Wu <binbin.wu@linux.intel.com>, "Oliver
 Upton" <oliver.upton@linux.dev>, "Pratik R. Sampat"
	<pratikrajesh.sampat@amd.com>, Ira Weiny <ira.weiny@intel.com>, Chao Gao
	<chao.gao@intel.com>, Chenyi Qiang <chenyi.qiang@intel.com>
CC: <linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>
References: <20251028212052.200523-1-sagis@google.com>
 <20251028212052.200523-20-sagis@google.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <20251028212052.200523-20-sagis@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0124.namprd04.prod.outlook.com
 (2603:10b6:303:84::9) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DM4PR11MB8226:EE_
X-MS-Office365-Filtering-Correlation-Id: 39d6cedd-e1b9-4d17-68c9-08de18974d3f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|7053199007|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cGVTclY2VCtDalZwamk5RUJvaGk4Y00zOE5nUmlzd3puM0RJYlQwR2QxNXhK?=
 =?utf-8?B?V3N6WUpjVTBTYW02RmpQejcwYkEzbEVROWtFVy81Y3RkL0JoVmk1WlF3NGJr?=
 =?utf-8?B?U1Z4TUdSdFBGZWkybmdjRXIyQnYwakZEUWRVZFJ2WTFWekRGeGZXWUVCczdW?=
 =?utf-8?B?YWMxdVdDYjFMRjFjQ2NlcHB3Z2M2dlpJeDlsU1F5Z2dXMkZyV0RPTUx5Rlp4?=
 =?utf-8?B?UXU1RHozajlWNHZkaHYzSVZrMHBrNi9BQVYvR0lpL2lYSnl6Mm5ocGRidnBp?=
 =?utf-8?B?VHJTbWxqUTlXY0xSQURDV3FsUkw2U1NnYlVHcGZmVEdTTTFRRlo2aGdYUEtp?=
 =?utf-8?B?VVlUMUs4aGkwWnlLYXRXaDR3TGMrUklZeTlsZHJKWFdlYkdUUXRkcHVsV1RR?=
 =?utf-8?B?WGZoU1ZTOWp0eHljYWJycGpacDdkYlBRVmp0anQzVldKM2I1bUl0djJyYitr?=
 =?utf-8?B?L1pCZkRNNlNERTdQZ2ZsN1YwS3BhcUkzZE9GbTB2N3lqMmRxRHFiWG5HZzF0?=
 =?utf-8?B?eVRUVlZmY0VVN0VTeEN5dlFwT1YrVDVRTGdUcjlDdW9LMFV5MnkzUWlIV3BF?=
 =?utf-8?B?aVpEakNtOVJhSGdMQkNTU21LT1VOcXIxd0RCQ3czN05pMVYrQy9MR1MwTzh6?=
 =?utf-8?B?QTFNKzdIamFUZVRZbkdSR0FVd1B1Qy9PNXBVRFRIMEZrZVhWVGZmMlc0WG00?=
 =?utf-8?B?ejJqRDJ4MGlUb2ZTR3MzRnJNdGZKUnNLYW1TZlJFekNsNnRqMXdaOGZtd0V1?=
 =?utf-8?B?VzVpbHFESG1kRzZBQ2htdTl6K2gzaTF0cUUwcUFkVHVUUVVQbGhkaThJK3B3?=
 =?utf-8?B?S2g3Rnp6aXpLR2ZFYUliY3NlZkxaTE00Sy9QSnptY01pZHB4U3pTaDVDS1Z4?=
 =?utf-8?B?TmRPMEtxSFhtSmRYbVBaSEtFR3loYkxPQy9Ca2xBRFV2bzV4K013UGl1THpW?=
 =?utf-8?B?NzFUeVR0Ulk2MUJGcjVaNEFqRFdXT3BydnBxNVEzMVBWMytPOXhJMmJXT3cz?=
 =?utf-8?B?MDBCWVlmelJCaEFQTnlSUkFMVURKL2xDejZ0OWs4Qk84WUdRMVFKWUoyREdR?=
 =?utf-8?B?NWtQb3c4d3ViZ1c1NkRJQk5FdnhtNFlQSVhjSjF2ZWVuQkU2R1FTN0dIQWtH?=
 =?utf-8?B?UzlnZmVCZncrcVV3Q2F3djFDV21wZzhJZEtZbTNNREV3aWRlekY2VGY1ZkFT?=
 =?utf-8?B?ZTlQTVZJdHlZVk15dDZsS05lMm14T3l4NldxdHJrUzhPSnhRTGZFVm8vdlRT?=
 =?utf-8?B?dTIrY2tuOVN4dWxYYk42b24zVStJWkR2YlozcEJBWWVaK1JVKzRCemxlWUNE?=
 =?utf-8?B?TldUenZnc0V6QnplR2wvWmdiSmhrV21tREl4ZE5NUU1LSzNFYVN5Q0U4SDNP?=
 =?utf-8?B?VEFGSmZVQk53alIreC8yNWZNcGdyVkx4MHg1S2VodmhqVlkzakZjamtScFIw?=
 =?utf-8?B?ditob2RlZVpMMmVoS1NMTE1NNkw4WVFHUzNDUGx5cnZJcWwwTnZtUDZOT0NF?=
 =?utf-8?B?U2x2YU1pUFNNT3JDS0FoQnljUnZQdWNYREord2VLbUExcTNDSFlpK2ltbXFx?=
 =?utf-8?B?R2loUmZQbWNieGZoS0luekczNkY4R0k3MDhKaEJIUzhCakRnMUh5MTN5NzUr?=
 =?utf-8?B?d2c2a09hNVQxTmM3dW5CaE1vd0x0Yis0QndjRFNQcFVlcTI1WG16VHdCVzRw?=
 =?utf-8?B?cVdrc2ZTYXNUeWFtamdaWk4xUG5pcmpMSC9YdFl0eWdOVGltejBhYm9xK3I0?=
 =?utf-8?B?c3FFZzZBbW12SlRCZ3BIQ3JscWRocGpWZ0o1THl2elRaaS9wZWhYTTZtcXJz?=
 =?utf-8?B?VThwTVR2c3pHWlpHaVBQbU05VnFQekFwRTJpMzFJMjRsd0F1NUd0VDJLNy96?=
 =?utf-8?B?Z0FVTTlpNnZodXFDTHUzY25DTG0yNmdHRFEzSGdtTmZpVzAwWHZsMW9HMHh6?=
 =?utf-8?B?VnRlRWViNUk2YUJlUkY0SHJNTVdRa3Roc2dCK0J3NVZ5SlJsZERzSEo2bEU2?=
 =?utf-8?Q?khiTSPWnwiM3g8PBtl2p38AC/Rpt9E=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(7053199007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T085eDR1SG53UzlaTGowbE1udFowQWk3aXFsc1ZvTnhucTd4S2VGUEZwNnZI?=
 =?utf-8?B?WmI2anZXUkREQzV6OUIxRTVGK1Blbkd4dyszMU1VZmRLQThFbE5tZUtjRjlv?=
 =?utf-8?B?b29FdHF4Nm01aWgwcXY0dmZPV29QUlBBTHFnMlk0M2FPM2FSQkdReXdRdXNo?=
 =?utf-8?B?WmlVY2pYa3lXREN0Q3dUbFNEaWxXdkduT2xoWnB6QTZUeHB3azJKRFR1MElq?=
 =?utf-8?B?dTJaenBNVE9peVRyNW9ZdEg5K3hpQXVQdDdlWVlNNDg0ODhoS1VSaUsrK1Jr?=
 =?utf-8?B?NzdWWTJDQXAxMVRic1NiYmYwbGEySjNFa2ozM2JMaWlQNXUreEQ5S1pVVEdE?=
 =?utf-8?B?bVJMUlk1NEdjMytwOHd3RDNUYnJEWDJWSk5vSVFvMmdmU3dMNnRHSGI3MU1i?=
 =?utf-8?B?djBXT1JDMEt2UGM3SDN0U1NvUjlFdkR4Ky9EQmxmUFFJN0FUOUxjaUN1cnVU?=
 =?utf-8?B?cCtnVkNFUklTOWl6VlZPT1JocDlwcXBVSVhsLzRUR3BqblJrTk15b1ZGU0d3?=
 =?utf-8?B?ZEI5NGxnWU01ck1wNXRzYzNmcUFob2cyRkFYRHJQNi9MTmZyOUNuQkxlSnFt?=
 =?utf-8?B?V2hPbTFOOTRKek42UndsTjZUYlYxRmlPZjdsaTh0bm43bEpmRWtLTFhJOVVu?=
 =?utf-8?B?Y081TElPMUtjRlA0WGxMRWw1MW9qS3ZKSDZXYm9UUmUyM3k2SjJkbVNnZFcv?=
 =?utf-8?B?UnZYMVBtenQwWTdOT0ZGb0YrZ1V1WlRkaGZSZUhTWHFGMktCbUpUc3EvS3RE?=
 =?utf-8?B?bTFnckx5RlAxUWNBWmZKTDIxT290Yk52T29odUk1aVJZV1ZXeUNRRXZRYlB1?=
 =?utf-8?B?RUtLdGtlS0dsQU9WM2l2dnlUOTY1Q1UxRFoxSmwrWmxKMml2WG9CNzJiZ1Ry?=
 =?utf-8?B?TlZ1VkYySU9TcE43VUkyeXJjWm1jRTNTc2w5Q1luaVVnZVMzYWJkTDE0d0lH?=
 =?utf-8?B?U3pzYTZjMHV5ZjB0TDlxRldsRTA4Qnp0bW96empncnFBT2pqeDJGNnBnSTJM?=
 =?utf-8?B?UVdHaFd5K3RkaEpEemE5UjF2N2ROYXVXOVJKd0d3aUR1cHgwbWFxNHlzUitn?=
 =?utf-8?B?cEtRNlA0UkE0VVhmWnQ5RENyZHBoRW5KRnhTZlczZmpEdUZ1OVI1SU51VWJW?=
 =?utf-8?B?eGhBN2FPdnpqMkhlM1RWYllTYkNhbWF3dldFR2h2a09XUVVhS0lmaFlEenZl?=
 =?utf-8?B?a2RNZEJrNXgzQ3QwTVgyMkRRUG5tYnRab1NtSjZoWlgybDd6L0RUaGV5RkFR?=
 =?utf-8?B?anR6T0c0dHZBQXZwSlYzSW5LZXRwY3R0cURrZVU4N013NU9SdWg3TzhMajhj?=
 =?utf-8?B?a240RmJTTmNZTmY3NTJHZGJqVEtHOENBZFNCMk5HRVBobFI2QVBQN1RnUGxX?=
 =?utf-8?B?MXNLTi9neXFMazdGQ0xFUjJndStzY0N2WHFIdzFrdXVnS1JkVi9ET001ak9i?=
 =?utf-8?B?NzBsbTRaNEh6czNvOVN4RDJKbHBPYU5CZEorL2RzaHVTUy9wdTFNdzF4cVRB?=
 =?utf-8?B?SVVPQ3d4djkreUlsMkFVc0QrMXFQdWZPY2RIZ2lPaVBaMlFtMjg0ZEl0M2Np?=
 =?utf-8?B?N2x6Tm0zK1EwK1VHbEFMbUpKdVhQSHRSMXFQcFdCaVQwclZUWHo3VjFmS0lU?=
 =?utf-8?B?VC90cG5ZT2JTc0R3Y2Zvb2l3cFVkeUY5Y3BIaHVGSWpNZmxpMXpHbzBxNFV0?=
 =?utf-8?B?SXI5TFhXcUlrbEJJOTlZZU9jcis4WXVXYTVIVmZBakFCNXJsZmNxRERueWJk?=
 =?utf-8?B?Zlh2Vlg3RjU2UVptbjNDQ3FuVktkWkhSZGZsdk10MWRqV2NnTTU2THVyK0Jl?=
 =?utf-8?B?TXdIcERHUzQ4RzdEWHVzWnpjdkY3aENpK21ITXNKWlg0TTROZmdIQ3FSRVp4?=
 =?utf-8?B?YmpiWkZ1RXRYbjdXRlMrWUlaNUVaNCtNVmZaeFlvNFdZS25SQkRrNEVwL3N4?=
 =?utf-8?B?OCtYVjJGdkRRamtkcW9peUdIS25Ldnl0NkgzMGdGRkM0eC9PUXl5NHcrK1ZV?=
 =?utf-8?B?RlAyTll4OGUwSk1pa0d3MTNXTll1TjZVL1BmTU9tRXFORjc5ZFcxeTRZcHhB?=
 =?utf-8?B?YjRhN1A5NEdVT25Rc3FKYW0xWWZ2eWtVcFRWaS9SbjFmdHQzS1lNaHYzTGtD?=
 =?utf-8?B?aWc1Qy9TSDl0WlMrRFg3cndJRjBabUlnVVFSdFRYMUNwRFFhaU1aOWpwa1VB?=
 =?utf-8?B?K3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 39d6cedd-e1b9-4d17-68c9-08de18974d3f
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 16:05:24.9518
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 31f/8pOgjvmlJqHuo7OTzAIjivDPQpVZCMUoFjVtWQU/S0/PbwVDB+4PAzc+2xStJLN2cMvKtZ4JJIVgZi/40fDDUs+YxNQva0t51EWd5e4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB8226
X-OriginatorOrg: intel.com

Hi Sagi,

In subject, use () to indicate a function name: kvm_arch_vm_finalize_vcpus().
Even so, I think the subject can be improved to describe what the patch does
instead of describing what function is changed. For example,
	"Finalize TDX VM after creation to make it runnable"

On 10/28/25 2:20 PM, Sagi Shahar wrote:
> Call vm_tdx_finalize() as part of kvm_arch_vm_finalize_vcpus if this is
> a TDX vm

This needs a proper changelog. Above just writes out in words exactly what can be
seen from the patch.

> 
> Signed-off-by: Sagi Shahar <sagis@google.com>
> ---
>  tools/testing/selftests/kvm/lib/x86/processor.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/tools/testing/selftests/kvm/lib/x86/processor.c b/tools/testing/selftests/kvm/lib/x86/processor.c
> index 17f5a381fe43..09cc75ae8d26 100644
> --- a/tools/testing/selftests/kvm/lib/x86/processor.c
> +++ b/tools/testing/selftests/kvm/lib/x86/processor.c
> @@ -1360,3 +1360,9 @@ bool kvm_arch_has_default_irqchip(void)
>  {
>  	return true;
>  }
> +
> +void kvm_arch_vm_finalize_vcpus(struct kvm_vm *vm)
> +{
> +	if (is_tdx_vm(vm))
> +		vm_tdx_finalize(vm);
> +}

Reinette

