Return-Path: <linux-kselftest+bounces-44196-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D6EE5C1612F
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Oct 2025 18:13:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52B7C189ACD9
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Oct 2025 17:11:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58C30348467;
	Tue, 28 Oct 2025 17:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iJ9yicSX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD8C347FD2;
	Tue, 28 Oct 2025 17:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761671438; cv=fail; b=cgG5w0x95pNf7IrNIbqFvFrsxrSlu9c7GtKP+vRWDXsZsliCjwfmhsCFDu6xLhnfa4qXT5nxNiy6TL7Ht2fRDtttTFEJsBTF3vMPKm81BZ+J8b1RvTLDHU4cQJM6UQ0XP6NtM/BBLgw8mGjqhl279Dp63MDiN1pFaPzkIYzXUZA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761671438; c=relaxed/simple;
	bh=+/sIXUKZorgsGSjHtb636cwWCjV37JCY016RbE26RAY=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=UWeHIBhXgs2eBdNNSYSHmagYaga7S1dIgaSxAmc/FTI8fjiry+29b8L5GmAlK90xansDngHplQLESER6oel3z6tp2uxuE01JyVWRcJeOld8VfnYgMp/J1jv/4ogD+7I2lEV1V12JOn89X5HNoKv1ZEfNkc22Ou3dsbaeRDef888=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iJ9yicSX; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761671437; x=1793207437;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=+/sIXUKZorgsGSjHtb636cwWCjV37JCY016RbE26RAY=;
  b=iJ9yicSXNiH3k6DgbH3ok2IvxdNyc7mcpxpt8f4CVRdIJj/MqKlY/ZcE
   TR3VGT6QbpSpdfaUwWx+AG61PAnuKC2jHFBXtQF402AsOiGH4dXTmH2IP
   PiNKhPPBVgPjYdeBRPubtkVy0narf1xjzSliT3joslbHO290ylufFOq8i
   C61X5rC8Wwak48YfRcvjG1tO88r7kWdPEm9Cuq+gDgXJbuGLFpR+xThho
   7wyU5JVCzc1IlGlrncuoaJQ7RD/+xKlLA7eqeBhfdQkprb48yqN/6QcUu
   db4CEeKDmUk+nHdI4uS0MDXxjwIXMHQIiUtJD0VQW1ekXS4GOvmB1RPI6
   A==;
X-CSE-ConnectionGUID: rDrY9/4AR6WO1VyG8LNW5A==
X-CSE-MsgGUID: 4ZMQNQ3FTR+VMjvAf6V1tQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="75227405"
X-IronPort-AV: E=Sophos;i="6.19,261,1754982000"; 
   d="scan'208";a="75227405"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2025 10:10:36 -0700
X-CSE-ConnectionGUID: jURyKQIzR+aLNAzXqyu9vg==
X-CSE-MsgGUID: V7B+Du8jSm6gcXn3D3HLMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,261,1754982000"; 
   d="scan'208";a="184652551"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2025 10:10:36 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 28 Oct 2025 10:10:35 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 28 Oct 2025 10:10:35 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.43) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 28 Oct 2025 10:10:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LbIvQepGGLmy2N7oucLkI5osXwmkgE7RDVeo+5zf9SnVkx7LKOo4bXh//w59HvrNX3B/1F+s5oXG2cmJrUb7v+WmRoDFrOf817eCzA5hqSWKn0tTIuBxSVanOQvC2C+bEyJtNUk2wD/cS9vmcK4qHJuTBNQjnsM1PhikQh1eXBTRfV4uaHP4jgTo4wVBHx7UbP3KG4b3cwQ5KhChBWBDGYqMoonNjkvQXz1xCAVwILmAO5BCTFAJpeOgDaCs8xTdLzc0I2z24cquc/+P6KwffaMVQNYV7ATxtJUSGwB+M7TdAVSnldo5m3sM6Azb2ax8kvwjDeqp5nXIVvGc6JiUiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CQT2q2S5zEp48IZXPb187ji5PvN2iW7bqoENN7YJgSY=;
 b=VR3JhNHxj0RKtNa+oEb+4AoxUzZCBf1LQm6OlSmYEq3zsmSa/yGIUXkj6CcZxqvXkvttYEOWd3YxCm/FqY9+ikA0bAcf1rHF6oKp2kPkmzMJUAKp5ZLjFHly8MgDZS/IL8EWqQ6EdqHvxZJUMp+eJEh23gNy048kambyxIbiGJTmCHEQLRVkSNi/8Tz33whekZKw6acpOjztnxQid0slBvq+iLkE8eSTHRfHHHTC4IZNP+5Qp2ObQDiGHEfgjW4ZfQ1079uEauXiqtzj9RGSv7WKkSJRl+9i3sfglR7BIapon4u4PbEXb2vuxvh9Q0Xr2TsDIup7gUsHUCYoNnarzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH3PPF9E162731D.namprd11.prod.outlook.com
 (2603:10b6:518:1::d3c) by DS0PR11MB7381.namprd11.prod.outlook.com
 (2603:10b6:8:134::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Tue, 28 Oct
 2025 17:10:32 +0000
Received: from PH3PPF9E162731D.namprd11.prod.outlook.com
 ([fe80::8289:cecc:ea5b:f0c]) by PH3PPF9E162731D.namprd11.prod.outlook.com
 ([fe80::8289:cecc:ea5b:f0c%8]) with mapi id 15.20.9275.011; Tue, 28 Oct 2025
 17:10:32 +0000
Date: Tue, 28 Oct 2025 12:12:52 -0500
From: Ira Weiny <ira.weiny@intel.com>
To: Sagi Shahar <sagis@google.com>, Sean Christopherson <seanjc@google.com>
CC: Ira Weiny <ira.weiny@intel.com>, <linux-kselftest@vger.kernel.org>, "Paolo
 Bonzini" <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, Ackerley Tng
	<ackerleytng@google.com>, Ryan Afranji <afranji@google.com>, Andrew Jones
	<ajones@ventanamicro.com>, Isaku Yamahata <isaku.yamahata@intel.com>, "Erdem
 Aktas" <erdemaktas@google.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Roger Wang <runanwang@google.com>, Binbin Wu <binbin.wu@linux.intel.com>,
	Oliver Upton <oliver.upton@linux.dev>, "Pratik R. Sampat"
	<pratikrajesh.sampat@amd.com>, Reinette Chatre <reinette.chatre@intel.com>,
	Chao Gao <chao.gao@intel.com>, Chenyi Qiang <chenyi.qiang@intel.com>,
	<linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>
Subject: Re: [PATCH v11 21/21] KVM: selftests: Add TDX lifecycle test
Message-ID: <6900f9948ece3_205652100ec@iweiny-mobl.notmuch>
References: <20250925172851.606193-1-sagis@google.com>
 <20250925172851.606193-22-sagis@google.com>
 <aPum5qJjFH49YVyy@google.com>
 <68fff9328b74_1ffdeb100d8@iweiny-mobl.notmuch>
 <aQADUmrDSRAydBhI@google.com>
 <CAAhR5DGAOsv-SiLkCziazy4Q9qG_iNqn5Zb9ik+KQ63KDzJsAA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAhR5DGAOsv-SiLkCziazy4Q9qG_iNqn5Zb9ik+KQ63KDzJsAA@mail.gmail.com>
X-ClientProxiedBy: BYAPR02CA0058.namprd02.prod.outlook.com
 (2603:10b6:a03:54::35) To PH3PPF9E162731D.namprd11.prod.outlook.com
 (2603:10b6:518:1::d3c)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH3PPF9E162731D:EE_|DS0PR11MB7381:EE_
X-MS-Office365-Filtering-Correlation-Id: c40c4a59-10da-4bdd-016e-08de1644e6cd
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bHBuMHFURmdpNmNPRUFsVFlUdXhwNDBOc3RERzB2N0crSCt1WkVQYUpYSjF5?=
 =?utf-8?B?WXRNeGlmWk1SZE8yNHZ5OFZvWTdiOVFKdGNJbUFEamMzQlZRNzQvVENyckI5?=
 =?utf-8?B?eW5ybWhKb1IwREk2ajdWV1hlVFhWUGxzSlllcDRXQWN5V3dYbWtmREdUS3NL?=
 =?utf-8?B?S1NFaVlyRmtDeGpCMnlmRDVkSkRqTE0vMXArMjVsVVBmQjdqVlV2UktVQVEy?=
 =?utf-8?B?S2hRMWlvYmdwR0MvRTZTM3pRQUlRd3ErRm5Rb1BTT0VrbkRmZnlWZkg5VW51?=
 =?utf-8?B?aGdJaUhyclJOck01dFU4UTcrZEp3R0daamxITHB5VkNpcWFRQ0lPQi9MWHZS?=
 =?utf-8?B?eEs1TmVwNS9BejJTeXdsVEwzeFcxaGx5Rzg3WkovbzNMMGlWdXNFdnB0V1pJ?=
 =?utf-8?B?R0xBVDdETGlaS0lqVnFxK3JRVUxzU0cyaVUzVEFHZy9MbVRjbENlay8yQk1o?=
 =?utf-8?B?S0tVdWk5MmlCT2RPb1k3b1cwWVN5R2pKOHg2d0FEbmlxV2dMTVFTWHNEcm9q?=
 =?utf-8?B?RDFxWWlzSE42MGZpQTZjVm4ySTdWcVZwRXZRMnRJNW9iYVg0YUJXdmQ2TFdp?=
 =?utf-8?B?RGpIZ2QzeTMrNHBHRVViNUc2U3ZNKzRyYkgzdGo1U21VdDliTW9wSjVGaWpG?=
 =?utf-8?B?QTdpNUppUG9uQ1UwdUZtVEJkOHJDckpTS1NNVjhkRDIyd00rdTM5dTZFcnRD?=
 =?utf-8?B?ZGNzY1AwdEFoSndHRHdXR3ZEUGZWVVpkc0JvOGZqVUZtSmpQNmR6VzJqOUMw?=
 =?utf-8?B?b3dhR2l0aDI4aWsyUFo3bWJrVnBHWnYrOGRFb0xmVDljZW5MRmg1MzVld1Nr?=
 =?utf-8?B?NUNvYWxlQUhFYkdJcS9teGxaS3BFS3F3T3hWeC9lb1BqQmExYWNoblpsdWtX?=
 =?utf-8?B?L2JmMFNEN05nNUJHVG44VDBxNjFsU3hUN1RwS2JRMkUrNldHN2FlQnhhS2gv?=
 =?utf-8?B?eS92QjVyTDJNL3JFb2VIbmd1SnBlN3ZFZ3hqbTI2VHlvRnlscUVUUmh5RHJ5?=
 =?utf-8?B?a2JNMnNCb3FUNGI5aWRmalV1Ukl1eGVpNXN5eWtOSno0dUdRWHkxYXZtUGVx?=
 =?utf-8?B?dndIVGFnWGJHZi9yRFN3R0poeU1qSE5LRWhyV1VvSks3R05xeXo3RkJ3dzRS?=
 =?utf-8?B?WXZNWHY4YkJhV2NCbTh2Wk56S2diTG1hMUZkNWYvbE1vWE05dWpPTUJIWi8v?=
 =?utf-8?B?TGJqYnVhY05YYllsd0o0cVkrbE1JcmZjTWxKNjhScGhNdGgyTXRUblI0Mk9Y?=
 =?utf-8?B?TFNuaDQrMEtjekYrQU9Wa1I4anlQU1RWVldRNUVTRXJEMDN6YUJ3akkvYzFm?=
 =?utf-8?B?cFVibDlMVFdIcHk3VHdCdUN2MG14RlB0dWtwU3lyaDc5dGpJZHdTekNkbENr?=
 =?utf-8?B?S0JDeVNLWnpNVlNWVFlodkgyZ0N6dm9Dd3duN09jRkpITkdXTTlGc2ZPb09G?=
 =?utf-8?B?U3NTRFlvTkVsenYwYjdZNGorTnZyb1NZT3FZMDR6ZkM4ZlhFRjdBN2w4RWxa?=
 =?utf-8?B?enBlRFJFOUFKUFlzR2paMDJlMml5dWdaL1IvcGsvQzVuaEhPdVpDdDc5VUpC?=
 =?utf-8?B?MitrQUM1c1BJejlMY1EyNzBocE9wcFNBQ3U0SGpUSnBHRGpHQ0twYkVXZVlP?=
 =?utf-8?B?Vk0ySnJMN0JMdEZOb05CQkRuZjV0ZDU3WlY4c2JzajljS0UybGIxdlgyVTM2?=
 =?utf-8?B?d2JwZHpEc1pMUlJwVHcvdkNZeHhCdWxWclpDdnQwc0dRMFhrNTlYck42THBu?=
 =?utf-8?B?Q0U3MGk2cnpPVFg4K0Vpb1lJaWVyZHZoakRTdDQ3Q3hHZStUWTdWbFA0N0Fn?=
 =?utf-8?B?cXFaUThGN3U3RC9XRU1lS0M3eFp2d1Brd2psT1BySzBNam1LN0lLcE5jOGsx?=
 =?utf-8?B?VHNsTTR6S05rNTNEOVUxMTNDdTVBMVA0RTA2NHBrZjYyanREQithUjJHYkdh?=
 =?utf-8?Q?5DaFZOVhiUWeBZu2L/tlSmNCGQ1HY4h5?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH3PPF9E162731D.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dmRmcDhySnhlQ2Vpb29ESUlEeWFVb1B4MzZ0bFJtczlqUmdZQVNIQldvWGNO?=
 =?utf-8?B?QnY0ZTM5OElNeGNaSHJrVm5iUlg1N0MzNnFQUEg3TjVOMXlNaDIvTUViWDl6?=
 =?utf-8?B?OVUzZzZOT0d5bFB0QTIrVEVzd1AvbGtURnZOWTJadDZmRWhBZlIwZkk2TEJn?=
 =?utf-8?B?L2FRQnFxSHZRM3lsTnNJdkpqQ0FvK0xUNkZ4VHJReEpJdm5oR29VVVp0N1lD?=
 =?utf-8?B?WHRBSC9GZ2M2eTl3bE1uUUp3dVhQRzF1Wmp3b3k4WnhsR096VGRPWnZ1VXFN?=
 =?utf-8?B?eXVzbkdzN3FrN0l6OE9jSTZKVVBJblMwd1E5aWs4azIxVWFzbm5UUDY1WWUw?=
 =?utf-8?B?SjduTEdRTVlnWVU1S1BxVG1aZHZMalpmMGt6TitIS290RUVpRXJuSzZ5S2pT?=
 =?utf-8?B?N09BVzY5TzZ6Ung2TDIyV1RZcSszcUpwQklTQ0djR01BUWlWZWhJcjNPOFRn?=
 =?utf-8?B?ampEK0pGSnFBdDlmdUVUdTM4VWord0E0eWcxZVFiODhWZXRRakFtNnQ3Q0JM?=
 =?utf-8?B?Z3NmVGtQVnM0M0hPMnA5dHNDZ1dGWHJVRzYwVHp6R0l1Zzd3ZVYzSXRzMWta?=
 =?utf-8?B?ODZadEFReGNIaVJ6UStvOGpOVVhTSmhlVFNvT0VuRFgwNmRxVUg0TkQ4b1Nl?=
 =?utf-8?B?UkZ0TE9mbEdXRnQvREd6YTVWYnJpSGxoMlRiZm5RWHhGOWZPVWFSZEQwaWMz?=
 =?utf-8?B?Q2xkWTVBNzVuUUxpUE5WU0dnLzIyVjE3MDF2ZkgwWVpWeUtSRnlGMkE3YmlD?=
 =?utf-8?B?Yy9OSHBDaTQzNlNVdTdqUTBVRW1QWDZmWVFsRC83c1NDeENIYXB6bk1VZjMv?=
 =?utf-8?B?ZG51dXRkdmJENTBQY3lNZk5uSmVNTm5NT1dQSCthK09jQ1RUcTBwRXdGRU1E?=
 =?utf-8?B?NEg3TmZ5ZGJqUXloZEplRXhmQkZjbFZBVmdnZjhtTGNyQXJveWhqTWhUYWNx?=
 =?utf-8?B?S2dvZERIOG9vQlB2enhSOVRjNFRWMzRsUzFXVUtxYnE0MjNPaERtblFGcEdM?=
 =?utf-8?B?US9oVWdNdVIwdUZzeUpyK044R3p3S0VPb2llUEhkaitDbUhUWDY2bGV1MGZQ?=
 =?utf-8?B?RU90MXFjdzJIQm02cWI2bno1L0VyaTRLK1FuUHM4ZEJmcmlCYzRILzBXODRW?=
 =?utf-8?B?Y1U5cC9zUDY3MjFwdDZXQjNQYzc5SjJXemUyZkVTV3ZQUTNNM1czWjVQK0Nu?=
 =?utf-8?B?bWhSRWRWbXNwU1BaR0pWblBVcnladWRsSUJKVytBbGxUTS9ZTjZKR0QrSHcx?=
 =?utf-8?B?bTRHWklTMC9LeUt0SDRLUE8wV09GY29vaUVEU2Q3c0dlajBRWjEwMzdVRW5q?=
 =?utf-8?B?MThLVUdEV1J3b2ZqdkVqN2ljQVdQN3VWUEc5dmJFN1pDLzJoR0daM1VKOENN?=
 =?utf-8?B?dy9RSVdGQ0xGRFNGY2NSZlhZMTR0MUNKMWQ2YUlJZmZ2OXYyMzdzMkczV1Nr?=
 =?utf-8?B?NmdVZjE5cmFLMjhJa0szc0d4VTBVL0Q0cDB3OS9naGFpVkIrUit3a2oxdnhr?=
 =?utf-8?B?Sm8xQW8zK3RhNklEaDBKTWJTU1VlOExrYm5yQ3FHdUY3TmdvY21mRytlTUxI?=
 =?utf-8?B?Qm9EcFVzWnpibU56SkZ2NXBvVUh0RHVibSswek54czRGNWhYYy9JUTB5SlJh?=
 =?utf-8?B?YjRma0tQQTNBTTlPMjVESWl0V3BPU3gxR1JwdWoyOVZsL3p2a0NCN2p0c0FV?=
 =?utf-8?B?cDVxZ1ZFcG5BRkxoZ2JxL0FaN25RR1BHVXRrclZyTEF2a2NKd05ZRGp1WjQ2?=
 =?utf-8?B?bndJL3Y1WmlJTENpYkxxeW5sUlNBa29EVFMvVTRLZldpRVhRLzBSTThSYWhx?=
 =?utf-8?B?MkNXZ04vZ1l1cW9VekFuNUZ2ajhndEI4d0dzUGRXMzZyeGY2czkwRjRvUmdY?=
 =?utf-8?B?cStiZHBlRlBiRUdCdzRsU1RaWjZIbERXb2xkNFZiekc4aWhrbXFVNzltZ1Z3?=
 =?utf-8?B?dVp3TWlSeVV3b1FZSVpna3N5czNQb213b3NzVCtKVjRYY1NHYjh1Qm9HYlVD?=
 =?utf-8?B?SVJ0U25aMzFtaTF4Rnp1b1VNUTJpTnhwcGVUTWt5Z0h2Ty9xeWFVQW94UjhN?=
 =?utf-8?B?MjA0ZVA1MTRUZk1QdVNEVjlyTE9nSll1dWU0NlQ0cXBvS0g3QUJBdmdINFFt?=
 =?utf-8?Q?g4M1FTwxBu9LIozvh0p/JRH78?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c40c4a59-10da-4bdd-016e-08de1644e6cd
X-MS-Exchange-CrossTenant-AuthSource: PH3PPF9E162731D.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 17:10:32.2892
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xebXBEM5eiF1OdBOzp2RJUhHtAeeNicIxlxynyL+Z+CS2IFnn6ZczsMczm7XlJi2AIRkG8W6gMjvp2rL9YIC8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7381
X-OriginatorOrg: intel.com

Sagi Shahar wrote:
> On Mon, Oct 27, 2025 at 6:42 PM Sean Christopherson <seanjc@google.com> wrote:
> >
> > On Mon, Oct 27, 2025, Ira Weiny wrote:
> > > Sean Christopherson wrote:

[snip]

> > > > diff --git a/tools/testing/selftests/kvm/include/x86/processor.h b/tools/testing/selftests/kvm/include/x86/processor.h
> > > > index 51cd84b9ca66..dd21e11e1908 100644
> > > > --- a/tools/testing/selftests/kvm/include/x86/processor.h
> > > > +++ b/tools/testing/selftests/kvm/include/x86/processor.h
> > > > @@ -362,6 +362,10 @@ static inline unsigned int x86_model(unsigned int eax)
> > > >     return ((eax >> 12) & 0xf0) | ((eax >> 4) & 0x0f);
> > > >  }
> > > >
> > > > +#define VM_SHAPE_SEV               VM_TYPE(KVM_X86_SEV_VM)
> > > > +#define VM_SHAPE_SEV_ES            VM_TYPE(KVM_X86_SEV_ES_VM)
> > > > +#define VM_SHAPE_SNP               VM_TYPE(KVM_X86_SNP_VM)
> > >
> > > FWIW I think the SEV bits should be pulled apart from the TDX bits and the
> > > TDX bits squashed back into this series with the SEV as a per-cursor patch.
> >
> > Ya, that's my intent, "officially" post and land this SEV+ change, then have the
> > TDX series build on top.  Or did you mean something else?
> 
> I've got v12 mostly ready to be sent for review. I was thinking of
> incorporating this change as part of that series. Do you prefer that I
> wait until this patch lands before I post v12?

I can't speak for Sean directly.  Buy my interpretation was you should
make this SEV change a lead in patch of v12.  IOW v12 patch 1/X is this
SEV change which sets up the new VM_TYPE() macro to be used subsequently
by the TDX code.

Then if there are further issues with the TDX stuff Sean can pick this off
as a clean up.  But my hope is that this series is pretty close to being
acceptable and it will land.  Then we can focus on building the tests on top of
this new architecture.

Ira

