Return-Path: <linux-kselftest+bounces-11975-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EF13909266
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Jun 2024 20:37:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A1A528ACA4
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Jun 2024 18:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 925F919E7D0;
	Fri, 14 Jun 2024 18:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nAgClZYZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B44526ACC;
	Fri, 14 Jun 2024 18:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718390272; cv=fail; b=UtvquymgB84Tuk/mh1b6gMIJ2teQ0/9Jwh3BhujNXBlLd30iU5y+KS0yxdBTYkUNMglkRDbXesGDwSwNRnDFHQNKskG7rfv3v6IfTDC0/oGPvUJll/Y6iDlZ8sClHa4SWbJvF0HGppNrSVtt6wnUs8zX6goMrJv0dy2t5l0bJc8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718390272; c=relaxed/simple;
	bh=0nUq/UtTy0CNSAxFhX3jUfMuK5SE5g2tkuN9I9O6w1g=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bR9j0QTkvFBzipieOt24sGXiaNMfbi+MlrtKqWITeWaY3uV7oWP+kLXmGxLAPdX6rlLwtlphCsiB1cc4P4W1k8DvdA3+2gXU8fHuJk6vzn9HRoHLIVQnaxf0SgLeyKHNqE8aw9Z4hzm5SyNtIPgIJ2OjekmHDDMo41ZWeKXa/pc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nAgClZYZ; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718390270; x=1749926270;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=0nUq/UtTy0CNSAxFhX3jUfMuK5SE5g2tkuN9I9O6w1g=;
  b=nAgClZYZZ/e1hZ02rYmmnGrJ2jSeHaXU4UYvW1mKOD1wdLEvZmXj0QNo
   r8AXPQzvUHZT4iLRJotW6ad+UlLdBAigEnUyNpGQbUwX9fLwKuqd0xZQ8
   jaRjxdkezF7LA7XyUI1JVwnsJlqzHsYHBvaPCXq3UJQf3T6NTKotZ5Uih
   od+3RrQnNz9SLTghdCCBYExYPSXfMgAODyGtYg78wvE+FQQ6HEuV+lOgH
   owZ2h7AXh1wiF38FH4kFHom60x85gdmop3wgQegqQlyNzYJHh+Hnb4gYb
   nap1g/E1YsK5sHw64uJuEm/L6H7mfuQssfvkf6zJpZ/LzQVJMe8bblSgp
   A==;
X-CSE-ConnectionGUID: IKq3Jyn/Q7q/nCY3Oai9QQ==
X-CSE-MsgGUID: s9i5w4htTM2xkjjM8dWVlQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11103"; a="15128933"
X-IronPort-AV: E=Sophos;i="6.08,238,1712646000"; 
   d="scan'208";a="15128933"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2024 11:37:50 -0700
X-CSE-ConnectionGUID: cE4e7IEET5abIgPbLkq5ZQ==
X-CSE-MsgGUID: MhNPjMwVSUKGieQz1r+hcw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,238,1712646000"; 
   d="scan'208";a="40453755"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Jun 2024 11:37:49 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 14 Jun 2024 11:37:48 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 14 Jun 2024 11:37:48 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.172)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 14 Jun 2024 11:37:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VXgnzuMSaWrkA+Q5HFbdTnd9gWEkNJ/KgsTyXClQMqMf6s1fni2H5zrFh+qdsDtaQbtDlp5e5lCHoEPo5f8yuDneXhdRr3ndNFFAy7iWl+2yZyzFkf6F/DJnT/gee+K+aG9U3jXS8I9LqmdhSggG1sTu0RRz5aSJINrZk8hkR4YKFaXc5V3Jw3hmd/E602QbUuK7AogaUWG9h+HR2B57IIGA7cKUMo0h2kVZrDFMKYhBdfuWBN4ekr5dzhRWMQ+Xs+rQz1m8yVNeLs9Y2QpqQc1RztMqERPD0DckWu5WsvM/zHmYYY2rkVEln4Y0nr6mAJlu6IMs5Bre/xvPcYsd3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dad4x2ZRMtnHkhuEt53ART+u4WfK9/lYWgzcxaQm+HA=;
 b=cZRJSfemFmsfrlFF+iYQ6uTuu7eVguy234PRvQSheRSMx1xKQdHsvakJbGTglDnw6IlrBANrdMwrVk0l/sztq11JAEw8izKuAWXJQjxzuAZ8Szd/kXzEoJiHixSJOMry0iCg2U4mMZxgMZvYEOeyQ+DWbqJfZ0elr5Q4N1WHEkulRTAKznQ/Gg59oq2KfpqQbzOuU5kqc8LJoKv9rEY+qQLe79ymhAqiAxOzxNIR9+NqmjUsZuQn8RtRq89CCA2eXOEWu+eBnusP/fibpp8u5pitcR+BJPp+DIPEGQ7KT5k6YgiayzalG8irabaFJvzchMNfjCvdt5/dWtRIQsNNeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by CO1PR11MB4929.namprd11.prod.outlook.com (2603:10b6:303:6d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.25; Fri, 14 Jun
 2024 18:37:45 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7677.019; Fri, 14 Jun 2024
 18:37:44 +0000
Message-ID: <7cff31f8-f94f-4b76-beb9-073c369e5080@intel.com>
Date: Fri, 14 Jun 2024 11:37:42 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/4] selftests/resctrl: Rename variables and functions
 to generic names
To: Babu Moger <babu.moger@amd.com>, <fenghua.yu@intel.com>,
	<shuah@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<ilpo.jarvinen@linux.intel.com>, <maciej.wieczor-retman@intel.com>,
	<peternewman@google.com>, <eranian@google.com>
References: <cover.1717626661.git.babu.moger@amd.com>
 <c1b9905b5fd6b80933fddd6c576e5d34a78b2b90.1717626661.git.babu.moger@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <c1b9905b5fd6b80933fddd6c576e5d34a78b2b90.1717626661.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0357.namprd03.prod.outlook.com
 (2603:10b6:303:dc::32) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|CO1PR11MB4929:EE_
X-MS-Office365-Filtering-Correlation-Id: e0347f82-7ffc-46e3-ae11-08dc8ca114ab
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|376011|1800799021;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MnVvQWpaQ1RuU2VXVlZvMXRvcEhUeElCeGFXdmhJbmt0bXQrNDhsNXZ6bElW?=
 =?utf-8?B?NEd3bjdPakRBRkppYWhWbmlRWXpaYmN5Z0FINFlwc1A5aUducEF3Tk95UE5q?=
 =?utf-8?B?bzVQNG5acGpMNHRGaUZ3bDN2Q1g2Tk4rVWZnb1k0K0VhMkdTcnp4TUNoMTJa?=
 =?utf-8?B?M3ZEb2tVb0Jrb2c0Z2lONDRVdzQ5U1JncDcrUzNqQkY1NElVWE5MU01iQ2N6?=
 =?utf-8?B?UHpKem9SSGw3MVBkUFVMYUs2eEozbGtLelFGS2tBSndlU09sTE03OFI2RjVG?=
 =?utf-8?B?K1pjYVd0dEc5QXhvbENjdkxTUVBxN21PcWc2RUVMQjZiQm9BZzQvZjZwMHps?=
 =?utf-8?B?N29KdFlvaGh2SkFkQkpWZzlhRWtVd3Z6dTc4eFFuSTdqZEJxVUNuOVdJYmR3?=
 =?utf-8?B?dVIwdTFPODk3K0VtVkYvd2I2eXI0aHUvWjNpRlNCNnJzNHlJeGpsSVNsQUIw?=
 =?utf-8?B?WG5zYTVFOG54aDZQRE5Yc3hjRitxZm13QVc5LzRCbnYweUY4d1RNb2tDZGY1?=
 =?utf-8?B?Vlluc040MVEyY3prMk81Q04vcFcrcVV5VW9OME8wWjFFK09MVy9hdTh4NGJ3?=
 =?utf-8?B?M3hrKzJ2ajFjcmtTVjVzUG53RThwVFlOSHdwRFRWaVk5TEJ2YXNQNXNBMno3?=
 =?utf-8?B?SUllWFBxTDlEWXQ2WnorVHFTckp1UDJucUtMdkJTRDkwQXMwZCtXc2RPZjRq?=
 =?utf-8?B?OW5FWHc5eFVGQVBVUmx2ZCtVelk0QndQVzBZMVZiT2F5a01qRUNLanJNQlY5?=
 =?utf-8?B?bnhLWVdUL1ZwNTcwUnNIYTNCT2haMDRKY1U5VmhINnZzTjJYQ05rd1ZrZmMy?=
 =?utf-8?B?S3E1MnlTUitEVmNsdkxTSTB5R1NIOWZKVGdqMUVoQWZZQTNERXN2Q0JHR21Z?=
 =?utf-8?B?L2RkSzNGb2ZyRWFJcEgxbXVTeFE3b3lOaUl6TDBpSnNDb2tPeFE4OURmNWl6?=
 =?utf-8?B?RDFaZlU0SE1JWmROSm1PU3ljUmVWb01BYnhFOUpRa0NPd2ZmV2hpeTNUZnlD?=
 =?utf-8?B?UGR4MjM5Rnl4M3hSMnpIZG8vTEo3cUtFb09yZElJY0VGUkx6b3Y1R1IrMFU4?=
 =?utf-8?B?dVB0ajdrWFpQU0N6d0cwYTZuaGZjOFpXUks0SkNjeFN6Q3pjRTRzMTdLY01v?=
 =?utf-8?B?Vy9Kc0RUb0lmSmdDUVptdWpuOFRwclJ6cXRUT2U2Z3E3WWpUb0krQytTWjM1?=
 =?utf-8?B?WTZsb1lPQnJ1b1VERFV6T1p2RFZGajdITmJ1dWxHaFgvb1ZXOXhCYVFwVXFE?=
 =?utf-8?B?TXZOeE4wa0tCQkJjRlo4RmlwU2ZhZGczU25MbVI1dzhWTFBja2NJNTRnKzJ1?=
 =?utf-8?B?bmJmY2hsaXNRUENiMWowUmFBbzVPdW1wa1F6dUVTVzFqQlVvVUxCdUxSaUJF?=
 =?utf-8?B?eWR5ampxVVlsUmFyMnF5QVNLSnZILzFMU1lQMDFwWFpqS0k3MDhsWWlWMnVh?=
 =?utf-8?B?Zjk3NGVObWRjUHJ0OFBmbUU5VXV3UVR3K0tUMEo3MVJUenRkVGtrZXVzV0Iw?=
 =?utf-8?B?cmhjMGt6U09odmNOQ0Y4Y1dHQ1RrYWl1dis5a01CdVc3QzRCeHpDNWo4c3hh?=
 =?utf-8?B?c2xpdWJ4SDR2QUhqa0tNait5eXhpdEh1N3JUclBSaVp6eVpCRUM0dllYVmV2?=
 =?utf-8?B?OTBKS0lSV2NyY1k0VW1QbTFWK3dvZ2pPTnNTTnp0UVJITFV6cXJ0cEIyZll2?=
 =?utf-8?B?T2FKVnJnd2NXNEFtNE1vZXB5eTMwU08xN1RGbmdyMzhldXJENS95SmQ3VU1h?=
 =?utf-8?Q?eGA2qM7/zcTlGX4omXx3vp8qorZWXsqDIcKFcu+?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(376011)(1800799021);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aDk2TFlxWjMyZHg5b1lQVCtmYStzNlo4bjZ5V3dnZ0NtbW4zdHBpcVo3VE1D?=
 =?utf-8?B?OFJPWjRyaDZWeHRXNllIRWc4dXVUU2dSRGZUZ3oycHVVMEtlM3Z4TlBjUmsv?=
 =?utf-8?B?R0hBNnB4Y1lydE5BZzZQRFdsUkZHci9SYlhGOFJLbFRONTFhN0JJUzFuYVJ2?=
 =?utf-8?B?T0RPbWNVS1NtOEZEUGQybVEwR0RaZ0thRGJ1WDZ5MzBjeUFPbWxDSjRiRVg4?=
 =?utf-8?B?Q2ZwVzUycDI3QWxLZ21Zc0MwUzRXUkRwNC9WWUxKbkxid29GcElqczlJQ3hK?=
 =?utf-8?B?OXZIQ2xJOUxMR2pNN21wM252NEdHSzlncUpZR3YxUWxmSEtKV1U4OHo4V0Rs?=
 =?utf-8?B?UktLTHJRMm5lVkRZMkJnV2piUHZMNGpHYWRoT0R4dG1vMmlBWXlndlUySnhs?=
 =?utf-8?B?QnZDbkY3a011UjlSNGxvQTRtOW8ySDZ2VmZ5aUlzZm56UU0zOUhCT0hMbTl2?=
 =?utf-8?B?WWxKODdncTl4SFgvaDBOY0xoRWl5MnhMYWtSTitUbW5KNHVOZW0wOWZOR2ti?=
 =?utf-8?B?VkxMSVJ0cmJLaXRJcy9vRFpGMUYzaHRyY2NFbGhQKzdaQkVMOEZvTDJIOTNj?=
 =?utf-8?B?dzJEd0s2ZGpqdG4xK0pTWlE1UnpReVQ5bm1tL2toRWUzZ05RTkxHelJuVnk4?=
 =?utf-8?B?RVlROVBTVitOUWFES1BnSW1rcDZxNFpFWE1hdk9JbnhhZmtsQ1V5bXU2S0hF?=
 =?utf-8?B?UmJyREVjeGVCWVZ0M1ZLVUpkbUc0Y29vem1FSUZSblZGblVrdUlJaU5VcWFX?=
 =?utf-8?B?TjVkbXRxMG9vMG10WmY2SDI0MWV1SXVVRHY1VEtFdjF6aTBQOTAzVmxxTE9q?=
 =?utf-8?B?b0FQSjZCUk9zd2hZWHBrT1gwcmtwaU9QTmRPa2JscTNWZ0NLanVIdlJDMXB5?=
 =?utf-8?B?ZTNIb043M09qVGlMckh2bTFHZDl5cm1Ma2p2Q0ZJUWhVRXJMT3dLVWtxd1RC?=
 =?utf-8?B?bDNYaHoxT3ZTcUJDK1dWWnNoeFBWa2VxekFXQjFIMC9iSCtzQ2x0SjdReEIv?=
 =?utf-8?B?VmFFZnZES1B5T1RGRHBYT3k1bU40TEtjWlg5NkhzbmpsRW56RVhtZlBaODVR?=
 =?utf-8?B?RzJkbHZybHl3VmZjVGVuSVVMRkhKcGdXQzRreVpQdUo1eVpJWDJkRHpXcHZV?=
 =?utf-8?B?ejYyVFZXWmYvdDQ0bkI3Vm1yeG5hRzhsb1hxeitlMHdOY0pZOGRvREdSbit0?=
 =?utf-8?B?QW5raXcvOEllcExZWkRTNHlmSXVjV2RFMW5wUXBXQ0hWTnN6NFRBbnVJeVRJ?=
 =?utf-8?B?VVdkOCtQQytEWUxrUkxiVlBJR2thdmhndXlxYmhTeElyclVHb1RrQkYyTVlP?=
 =?utf-8?B?WklBT1N6VUZ4aEVEMUQyd1pWS2VQcUlnMkVZR1d1OURBbWlJaGZsSkpHR1pn?=
 =?utf-8?B?OHkzUGFMS0xBczA0WXU0NUpyUnJleFRjaEJaaHFNK2VVRnNlNkVBUzF1UVR3?=
 =?utf-8?B?bFVmMTZGNS9rSzk3SVpZV2ZiOEhlS1BrZnYwekNSUUlocTdFZUVDeVRYTzhC?=
 =?utf-8?B?cDVWWUZHeXgyS1FlMlV5aEdWbWtLWFdIbWZVUzk0VlM1TDdxT25kUjhCTlRt?=
 =?utf-8?B?cmVZMEg0NDh2UThZSHRpeGFSTmVIc0NXbnhGNitxQm42Zy94c0c3RERYUXVV?=
 =?utf-8?B?VlRjVTNwNmtnY2dZS2lDVFdoNVVYd3BzS09XdUpudHFXN1kzVmlUS1RqWi9z?=
 =?utf-8?B?NTNpTWl5SkwwajR6UjFzcVR5M0NZNjEvcjNlS3Z2c2E1cFQ0US9HbUVSeFhU?=
 =?utf-8?B?Z0I5ZVptTWRZTE5oemdhMktvYnhBWGEwTDllaG1sR0xJSlUxb1dmN2J0cXZG?=
 =?utf-8?B?SEtUcDI0NWl3RTljYy93dUZ0MTFmQnZtd1laeFBud1NTK2NHZ1RwbTNXWmNR?=
 =?utf-8?B?eXh3aTVJMVJjYW5haXdkRVJJeks5NmR0WFQxd2V3dzVkZzNvTUY4Zit0V0Nw?=
 =?utf-8?B?bXFweUtZWTdUTkRyS0N3UVZXVGxCRlFlWFZlb0FSbCsyR2FXZStBTUNxUnEx?=
 =?utf-8?B?V3AvaVVYZHVHRWUwbENXbEJoV3RVa1NuMTcyc2JWSjVWeEdUU3ZxakhQTjNB?=
 =?utf-8?B?b3g2RlNVamIyR1U2T2VyQ2JhOHJkWnVJTUhQSFJPSlUxTXpKMW14WGdVV1lh?=
 =?utf-8?B?amRKU04rQ0dPVVJhM3ZTS0J3RFhkRk8zVkhBcXVVT21ESXRnT2RkeFhPUTda?=
 =?utf-8?B?b3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e0347f82-7ffc-46e3-ae11-08dc8ca114ab
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2024 18:37:44.6415
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 73TSVqxjtBY0+LTYI0TMuus677OSf4oPH1JaRzdRddFjNDtsvd0YDtuXCiy7NIjCY+RevizGxTELA/iBVz7LdSUySjydTuRDW1A2jBELlZo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4929
X-OriginatorOrg: intel.com

Hi Babu,

On 6/5/24 3:45 PM, Babu Moger wrote:
> In an effort to support MBM and MBA tests for AMD, renaming for variable
> and functions to generic names. For Intel, the memory controller is called

Changelog usually starts with some context and then problem to be solved. What
the patch does follows that. Maybe just something like:

	For Intel, the memory controller is called Integrated Memory
	Controller (IMC). For AMD, it is called Unified Memory Controller (UMC).
                                                                                 
	Change the names of variables and functions from imc to mc in preparation
	for support of MBM and MBA tests for AMD.
                                                                                 
	No functional change.

> Integrated Memory Controllers (IMC). For AMD, it is called Unified
> Memory Controller (UMC).
> 
> Change the names of variables and functions from imc (Integrated memory
> controller) to mc(Memory Controller). No functional change.
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---

...

> @@ -349,10 +350,10 @@ static void do_imc_mem_bw_test(void)
>    *
>    * Return: = 0 on success. < 0 on failure.
>    */
> -static int get_mem_bw_imc(const char *bw_report, float *bw_imc)
> +static int get_mem_bw_mc(const char *bw_report, float *bw_mc)

The name of the function is expected to be changed in the function comments
also.

>   {
>   	float reads, writes, of_mul_read, of_mul_write;
> -	int imc;
> +	int mc;
>   
>   	/* Start all iMC counters to log values (both read and write) */

Was this intended to be MC?

>   	reads = 0, writes = 0, of_mul_read = 1, of_mul_write = 1;
> @@ -361,21 +362,21 @@ static int get_mem_bw_imc(const char *bw_report, float *bw_imc)
>   	 * Get results which are stored in struct type imc_counter_config
>   	 * Take overflow into consideration before calculating total bandwidth.
>   	 */

In below snippet imc_counter_config is renamed to mc_counter_config yet the
comment above was not changed to match.

> -	for (imc = 0; imc < imcs; imc++) {
> -		struct imc_counter_config *r =
> -			&imc_counters_config[imc][READ];
> -		struct imc_counter_config *w =
> -			&imc_counters_config[imc][WRITE];
> +	for (mc = 0; mc < mcs; mc++) {
> +		struct mc_counter_config *r =
> +			&mc_counters_config[mc][READ];
> +		struct mc_counter_config *w =
> +			&mc_counters_config[mc][WRITE];
>   

I noticed a couple of misses by just looking at this patch. You can
use grep to ensure that this patch does what you intend.

Reinette

