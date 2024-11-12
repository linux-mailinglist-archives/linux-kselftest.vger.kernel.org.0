Return-Path: <linux-kselftest+bounces-21860-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C2E09C58AA
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Nov 2024 14:10:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 222C92800F4
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Nov 2024 13:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65AD713E02D;
	Tue, 12 Nov 2024 13:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="msYB+OHY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 365C6136358;
	Tue, 12 Nov 2024 13:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731417037; cv=fail; b=Mic3ZEDnhf869c2VFC76k6caQXKWrDHu35X76nUm4YadXBK8hrq8qcq2VR9HKTqUYmi/I0JnnDjM3D+4MBjFlPTPN3d+xFFgfF04mxao/wH6jZAfbjbkJ5RaMUDrcN61QJCHEG8fylEtH4SV5VBoRcGoKI1VJ3MuphxNTbi0CsM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731417037; c=relaxed/simple;
	bh=NcNrG8rmcLFBTs1HZq+Ww+oXf07b8AfxzyeXcgbzjko=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sEWquj8EEcIFsNVjFwPmIcjstVoj1pd3zuFEGTuGhVf0wL/KLpNaQ/Te/eERi6TJVDBydkGeLcfwIGLNZ3dC8rz3+LZlBsZ+oTEi2AaF1nVqg2Fkm+vHUSw4c2UnTrw316xjIX7MWLpiLhInXjLffVuDmPvFn7L7ecJSdgMDMTU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=msYB+OHY; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731417036; x=1762953036;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=NcNrG8rmcLFBTs1HZq+Ww+oXf07b8AfxzyeXcgbzjko=;
  b=msYB+OHYyvczD9AT9BpZfqpt4gfp5VlmMqzvTkMpDn7x2TrM3XlE6Vlq
   AKjI43NA7c/IpL4uh9n3vRk60xgBF8DB7GB9krqvJJafkivVbLPLzZ8rU
   bmAWPuSS3/2iS/qKA9z939EBBCIneIy18kFIrhGsZZwMUbptRrxvb1XK4
   liwpb9cP29nDsrni8yLVx3GQPHiryuc+NaslcxwOBqTjZkyjfAofnDSmg
   DGYVtiW52qncxb10YS8lrVWFS0vdffEAN2IfW4FUD7oUn2VyzMkS2W7xn
   I8TsOIUSjcLX0GQfRh4gtb0KQVQF+QzeX+JVKDsUWgiP1auB75DFrooLQ
   Q==;
X-CSE-ConnectionGUID: nUL9nqQhRl2e88km1CQ+Dg==
X-CSE-MsgGUID: izXEsmkhT8mSyDHRltJ41w==
X-IronPort-AV: E=McAfee;i="6700,10204,11253"; a="35181213"
X-IronPort-AV: E=Sophos;i="6.12,148,1728975600"; 
   d="scan'208";a="35181213"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2024 05:10:33 -0800
X-CSE-ConnectionGUID: zZBcXR/qQOieJpHggFqbwA==
X-CSE-MsgGUID: qkvldZOjRQyJdHlZ8OPmQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,148,1728975600"; 
   d="scan'208";a="92532550"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Nov 2024 05:10:33 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 12 Nov 2024 05:10:32 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 12 Nov 2024 05:10:32 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.171)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 12 Nov 2024 05:10:31 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TZLNTi+JJRIrXXjOd/yYja9Mp6IGbT3qypMwUXd1urbsXV8mO480tnS3fzTtmjK2LS69AItWQJhB0KyPvIw3Dq+cEp1Hyc0xwmJ32N+Zu1J1X68R76z5Wv6e2gYKQim3PE5H8Wgr56uQtf7ZcXFLgGU16GRtZTU3NwJFe0S0MqDi3glu9Ad+XdxkkS6QWLqLrG5y6LOBmtIuYCbiacNvJT8OldTp0dJu+CMN5aXt1A+I9FXuE1DPB//emLbPZcQ6mtPs/C6cztqjQCFmYCwcuNpZbsZEOx8aVnPOA49VL6aPk1F+FipiRmSmveRItXOtgS9Uz0CeolAkGxruAuJkSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mfapXwFotbGhMxBIhosnly+1H023C1qFrYjJhPCKJkQ=;
 b=ZKs5dfnI8JjSAmNWMUUd51PSW6uO9sIZ6Iw07hBFrLimw3MuXxVS43sXjNC2eVinmooguia8cR/L/Db49tbyh8CkP6pBpSqlWNwhBVJdVOLFTX4Z2t7tV70xh5w0docPe+yrmXxRh9eprbQdkXALZYCEryL0OAobAxNjovIh23IHECEur8OGQSviuQOl3pTJjTsTpexmOB3zkBpTfdP8COSEsyCoWAhojsbKq6o3YnaKx/SgEhfP4rgrrf/+lw1xoxOjVvohuyy1wx3qO3tuK4W2C96j4o6d84mtx0A5mgiMcwmuSIJc8v/aEaMhzk1oPeZEZlNlUWor+wowZisuxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by SA1PR11MB7699.namprd11.prod.outlook.com (2603:10b6:806:338::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Tue, 12 Nov
 2024 13:10:29 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%5]) with mapi id 15.20.8158.013; Tue, 12 Nov 2024
 13:10:29 +0000
Message-ID: <f0c45d5b-b8cd-4f75-a9d7-21808f18583d@intel.com>
Date: Tue, 12 Nov 2024 21:15:02 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 13/13] Documentation: userspace-api: iommufd: Update
 vIOMMU
To: Nicolin Chen <nicolinc@nvidia.com>, <jgg@nvidia.com>,
	<kevin.tian@intel.com>, <corbet@lwn.net>
CC: <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>, <will@kernel.org>,
	<robin.murphy@arm.com>, <dwmw2@infradead.org>, <shuah@kernel.org>,
	<iommu@lists.linux.dev>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<baolu.lu@linux.intel.com>, <eric.auger@redhat.com>,
	<jean-philippe@linaro.org>, <mdf@kernel.org>, <mshavit@google.com>,
	<shameerali.kolothum.thodi@huawei.com>, <smostafa@google.com>, <aik@amd.com>,
	<zhangfei.gao@linaro.org>, <patches@lists.linux.dev>
References: <cover.1730836219.git.nicolinc@nvidia.com>
 <7e4302064e0d02137c1b1e139342affc0485ed3f.1730836219.git.nicolinc@nvidia.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <7e4302064e0d02137c1b1e139342affc0485ed3f.1730836219.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0083.apcprd02.prod.outlook.com
 (2603:1096:4:90::23) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|SA1PR11MB7699:EE_
X-MS-Office365-Filtering-Correlation-Id: e94bb2b7-7080-4b21-a2be-08dd031b6116
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RjI5ZnpGc3VDM2hYdGk1NmJlWTUvVVBpeTAwY1R6bVZML2NFUktBenVQUkZD?=
 =?utf-8?B?RHJ1WWNaemxPckg1ZlF5SVBnU1h6Q2x5aXJkNUE1K0JZdzd3b0JXbjhTaFNk?=
 =?utf-8?B?dDJQbUVBeW1kMmN5d0psQjZlZm42SzNiREozdm94LzdzQUNLM2kyV0dLK0RR?=
 =?utf-8?B?RjcrUnBEZkJ3R3NUU2ZPczlIcFQ0ZGtiYUYwM3pHS3NNc012cDhxUjdHQkxU?=
 =?utf-8?B?OEdhaHhnVGZNMFUvdUNOQ0NZVURMU0trbXp6V2tKRURPRFB6MndqMGRCWmdx?=
 =?utf-8?B?WHpudTZ3WXg2d1l5ZUF5UXhsOXg0REZhdWczSXJHV1JrTStHYjVYTEN5R1VK?=
 =?utf-8?B?NFhoVXNpck1wWmgzWEszTXRzeGhDYUt5OVJlZFhtTE5kbXdjamVXRFV4Sks1?=
 =?utf-8?B?dHppdWVlSmY4UEFDQ2haVWlvVzFlSExYODlIRVBYdldRRTVUMEc1bSticGdl?=
 =?utf-8?B?L0gvcG1tZ2JoQW41V3pCUmx3eW5XT2h3SWlhOEtlbjF2a3RBbEI3MDFadFFY?=
 =?utf-8?B?MVovbHN2VHVEMnp5Z3EyMURnanlQeXZDQzAzN2t4N2xjQmQ1ODAxNGNkQlNj?=
 =?utf-8?B?aDRGNERZMjdVVFp3bll4ckFXbkZXOHdUbEFOWCtaazlkZVFOVDJta1BCVDNv?=
 =?utf-8?B?U25DQ0pQSXE4UGhWR0pEalpQWVE1R2pxTE5Hbnc5MEExQXl3Y1dUUHZ4SlVL?=
 =?utf-8?B?UDZKb05YclFUd1NhaTIrVWs4NndRKzVkVzM4Q3FaZUxhRnA1Q0VObERNZXVD?=
 =?utf-8?B?RGwxRldGZmJEdHFPQmxVSkkzNGVyMXVvOStYODlaN1kyc0Q0b0E1ejU4SlU2?=
 =?utf-8?B?UlJOOFFQaGNlOE1hWVYwQmtRdnk4VlhkK2hCSWN1RVhVM1VyenFFelUxb25F?=
 =?utf-8?B?MXlRc2JwUHJKV2gyZ3ZxYTUyYVV3dURFMDBURTlRTUs5N2hjbVJGdTdGM3lZ?=
 =?utf-8?B?dHBXVGdWL1FHUzI5WmM2R0Y3QU9pQlppam5aWWJyMGE0RmxvYlduTFNhTWRj?=
 =?utf-8?B?R0pveEl0dEkwb1haLzZJT1VSbFVBK3haa3BZUEI2UmJ0M3NKZGM3azBud2lO?=
 =?utf-8?B?RGxKcU9VMjB3VGo5dStxMzZNNEpYempGOGJZZy90cDNsWGd0UDlkblpGMWFR?=
 =?utf-8?B?eExQR0xuR3JXS1FxNkFocEhLM1RLbW1sYzBYOGZ1dVNOR2l0d0tUdXZ1ZnRH?=
 =?utf-8?B?eEwwZ2ZNV1VTY2VCUUluWS9HU0hHbzJsTDN6eVRoeGNhM2RKdVN4SXlJZmw4?=
 =?utf-8?B?eXo0UWlWck1FdDFWNmhuRG82eHQzUFVUWHFtbk41MVVFZmN2K0w5Yi9iR1V3?=
 =?utf-8?B?OERUUkEzc1Y0MUp2R2k0QklDb0NUN1VHWkovdERkclFMdit3ZkYrT1VncWN3?=
 =?utf-8?B?R2NKei9UUmpHRlk0ck81WGZCK1JzeEFoRnE4WmNoUEU0azVyL0FtOHp3RGZC?=
 =?utf-8?B?OWhpRkxzQkZqa3NvNmh3Rk5LR2JKMDAwMmxweVkyNjFCdWFRYUZrS3U0NzZi?=
 =?utf-8?B?SnA1c29IazBtRVlvYitFYkRDaFJtUDFFdVVhRGt3dE5nQUMrVGgvclRWZmhC?=
 =?utf-8?B?U2tZQXVyLzk2U2pZUnUrZ2djWFBXeHNLQi9sQmZiNDhYaXVxSzB0SFFSa1JE?=
 =?utf-8?B?OXVKWjRJUkZyRzlzRHRhL0tFWEh4VXBuVGJhelArdXF3WVhiN3ZianRBWmNm?=
 =?utf-8?B?OWFIYlMzNjRPWUZWTWRUMlRUaU5aZmlSMXI2d3A4bW45R05pT21rWTFKRnkw?=
 =?utf-8?Q?2/icYIsqqLZgZz//j0kQXESR3XuxTn2q8OceY8e?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NjRoL0dXZHowZXZjTFJnOVJIZFRhcGpPK0ZrOGxSRW9sYzJtNmdVUVJCci9u?=
 =?utf-8?B?d0tmSW5XeUNIMUZlOTFvcnpsYXB5TXNsNkw2TE5pdUw1LzN1UmIyOUs0TkR2?=
 =?utf-8?B?N0ZsR1Y0aDFwcUdEdmhYU0JoUnFJVmhLUEsrSjhsTTEwaWtlcEdrVGUrc3Jr?=
 =?utf-8?B?L29iYk8wM0pYdGJUR05WMm5iejUyQlh4UkluNG0yWUJsOXZKTkhDdnNVb0ts?=
 =?utf-8?B?dzZaRkdSNHd4dzNmZlRuT05RZXFmOXR0WWxCeGlONFdKNWt6d1N1N3pVellT?=
 =?utf-8?B?NzNXRzl1YTZ3R0Z4ZDMzV0p5MzVoek9EV3FkZVZ5Tklaa3lRVzBLaXdZSW11?=
 =?utf-8?B?M1BuWXRwU3ZBVGFhNUhNSmxXdGxIZXM0bHVJSFBlQWNwTW9BSUQzKzhHazJp?=
 =?utf-8?B?cE4xeEw5Rk5oWnExRHZqZmpJNHI5a2laZnl3dVNpeUJzaGdOWG1ibURWN1ZP?=
 =?utf-8?B?NmNVbHd3eEZucGtERmdQYzFSd1Fia3ZNZzFRekQ5NHllU1lFSlE4VkQ3eTVO?=
 =?utf-8?B?dmd3WkdTMWpZQ0V0N2o0SUh0UldhaGpaVVlpVTl4L0tkT1hrY2xwa2xnNW5E?=
 =?utf-8?B?cTM2VDVjOUlaT0dYU3NaUy9XQTNIU2o0WjFVME03ZGtTcmZ2N05IRGlNcXRv?=
 =?utf-8?B?SFZLZ1A5VjFCWjQyeEhySXJpRDdPU0ZDNDEzKzZZdkt2QnNRRGhCcjdydzNq?=
 =?utf-8?B?MDAzUEhkT1I2TGlObm43MWNLMnVSbjVlMmJZdUY2YjV0aTZDSWRnSERBdU94?=
 =?utf-8?B?Tm5NUjcrWmtYa3RrOGRGVGNxb3pTN0prSzQvK1krODYwdFVjL3VzdDZacXcx?=
 =?utf-8?B?MVZRSjd5bmdGWEoxUXdwWGczekFYYkNTejNvejRKRFNjRTRldEFZTVhPcVFF?=
 =?utf-8?B?SGFld3hSV0F3Zk5Ob2JncGRSems4cExoY0ZvTmNZNW1idm1FNy9vbCsvczFl?=
 =?utf-8?B?UC9sMTExOUdMc2U3SDl6Rk5LQ09xVkFvQVRWbHRKVFQ1a2JpRDlacnprRzhz?=
 =?utf-8?B?cGI4L2ZXR1djblBTQno4WnZRdC9KY0NPckx1dU5lSm4wNXVvM0xGNjU1UmtZ?=
 =?utf-8?B?WWhTUjNKaGZZTlFRcVNpRUsza3ZBemw4Mi9ncVFuK2hMSlVUdE9zUnl0NWRk?=
 =?utf-8?B?eDQvbWQzay8rcEZRMG1zdVNjcWk2RG1kUCsyaGJCWnE3dVVnYlo3bFB1Nk5T?=
 =?utf-8?B?UmVqa1BFdEMzMzVSRWsxZ2d1dzVTYzNxNnlZT3k4VHBJOVdXN2cwWFZrMUlS?=
 =?utf-8?B?NjNObDJ1cVR0cEhtRkhEMytXVFJrOWliVXIyckVSTGtCQ29jWjRXUzFaR1lL?=
 =?utf-8?B?bjVBMVFnVDZRbitDam9tNW54WkNjd2c4cC9FUUxMOTE4K3VMdjQxSW85cFNp?=
 =?utf-8?B?R1l2bFJKNVhSUytCOVVKTE1mWnVYM2FSQytNMW9LMkxTbTBUMElESnFERTB1?=
 =?utf-8?B?bGMxaDN4RVVIUjFWbUtVL2F5WER6TUtpZmlpR0IvSytUbHJadm15WjJMRzBI?=
 =?utf-8?B?NGhFTzlQenhqVllXUlJkK3pxMEowZnJNMEY1TlM0WHJTbjJSbHE0d1RjbmJq?=
 =?utf-8?B?NEF1d0RRN1ltL3IrRVVialB4VWdtcnpmTy8xYk1ReTB2SkwyNW85eXdQMGdK?=
 =?utf-8?B?YnJrVTZzcTFTVGo3d1NBYmFFR2Z3QmJUMGdWRVd6VXNoMzFYTlYzMllhQUli?=
 =?utf-8?B?TUJDcFA0N3U5MVVmeHVVVkVHK3dLZ21jb1c2WE4wc0hrUHQrRG5vVGtuOC9R?=
 =?utf-8?B?UXdyNzZPQ1hvQjJWeGhmZ0trd3M4dVlUWHh6cmptY3ZyOE5VZHF3K3FaUTlx?=
 =?utf-8?B?aVdZaGlaSXJvaGFQb0V5bHJaY0cxTEZTSnhrTGtoYVZQR0hFRjNabkkwcGhx?=
 =?utf-8?B?UW5GamZhSm1malkzQmFCS2JNeDNMT0h6V0hFODlKWUJQbzFrOWtJclREZW9m?=
 =?utf-8?B?QlBFeWJPWmRsUGZMbVFQL0lOZTh3TFBRd3VGckdFbHNTRHJpWE9oZTBjZVpm?=
 =?utf-8?B?ZXBZanRYR2xWaDZjZTNydDFzR2VJazNneTBEb0N2RTQ3c0FSc3QwRno2TXho?=
 =?utf-8?B?akRmYzlzV1Z2L210eGVhOHlMQXlpNnpRTkZPM0I4WkpRY2g1SklwSy9wS2tq?=
 =?utf-8?Q?qbNwOEC8jlxM+tnvVU4XAMXWi?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e94bb2b7-7080-4b21-a2be-08dd031b6116
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2024 13:10:29.1990
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OOmhJjMGbNW+aRWyV85+s5yOXVFsvML4uw4DoQXZr7N2w7QQAaXCRjwqiFwKUf3cscJdnW25iQ0k6h80+w3c8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB7699
X-OriginatorOrg: intel.com

On 2024/11/6 04:04, Nicolin Chen wrote:
>   
>   The diagrams below show relationships between user-visible objects and kernel
> @@ -101,6 +132,28 @@ creating the objects and links::
>              |------------>|iommu_domain|<----|iommu_domain|<----|device|
>                            |____________|     |____________|     |______|
>   
> +  _______________________________________________________________________
> + |                      iommufd (with vIOMMU)                            |
> + |                                                                       |
> + |                             [5]                                       |
> + |                        _____________                                  |
> + |                       |             |                                 |
> + |      |----------------|    vIOMMU   |                                 |
> + |      |                |             |                                 |
> + |      |                |             |                                 |
> + |      |      [1]       |             |          [4]             [2]    |
> + |      |     ______     |             |     _____________     ________  |
> + |      |    |      |    |     [3]     |    |             |   |        | |
> + |      |    | IOAS |<---|(HWPT_PAGING)|<---| HWPT_NESTED |<--| DEVICE | |
> + |      |    |______|    |_____________|    |_____________|   |________| |
> + |      |        |              |                  |               |     |
> + |______|________|______________|__________________|_______________|_____|
> +        |        |              |                  |               |
> +  ______v_____   |        ______v_____       ______v_____       ___v__
> + |   struct   |  |  PFN  |  (paging)  |     |  (nested)  |     |struct|
> + |iommu_device|  |------>|iommu_domain|<----|iommu_domain|<----|device|
> + |____________|   storage|____________|     |____________|     |______|
> +
>   1. IOMMUFD_OBJ_IOAS is created via the IOMMU_IOAS_ALLOC uAPI. An iommufd can
>      hold multiple IOAS objects. IOAS is the most generic object and does not
>      expose interfaces that are specific to single IOMMU drivers. All operations
> @@ -132,7 +185,8 @@ creating the objects and links::
>        flag is set.
>   
>   4. IOMMUFD_OBJ_HWPT_NESTED can be only manually created via the IOMMU_HWPT_ALLOC
> -   uAPI, provided an hwpt_id via @pt_id to associate the new HWPT_NESTED object
> +   uAPI, provided an hwpt_id or a viommu_id of a vIOMMU object encapsulating a
> +   nesting parent HWPT_PAGING via @pt_id to associate the new HWPT_NESTED object
>      to the corresponding HWPT_PAGING object. The associating HWPT_PAGING object
>      must be a nesting parent manually allocated via the same uAPI previously with
>      an IOMMU_HWPT_ALLOC_NEST_PARENT flag, otherwise the allocation will fail. The
> @@ -149,6 +203,18 @@ creating the objects and links::
>         created via the same IOMMU_HWPT_ALLOC uAPI. The difference is at the type
>         of the object passed in via the @pt_id field of struct iommufd_hwpt_alloc.
>   
> +5. IOMMUFD_OBJ_VIOMMU can be only manually created via the IOMMU_VIOMMU_ALLOC
> +   uAPI, provided a dev_id (for the device's physical IOMMU to back the vIOMMU)
> +   and an hwpt_id (to associate the vIOMMU to a nesting parent HWPT_PAGING). The
> +   iommufd core will link the vIOMMU object to the struct iommu_device that the
> +   struct device is behind. 

It looks to be reasonable to share the viommu_obj between devices behind 
the same physical IOMMU. This design seems no enforcement for it. So it's
all up to userspace from what I got. :)

-- 
Regards,
Yi Liu

