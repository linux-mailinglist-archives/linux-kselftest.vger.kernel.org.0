Return-Path: <linux-kselftest+bounces-25096-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5D84A1B6C7
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Jan 2025 14:27:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2D1C16C9A8
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Jan 2025 13:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8A6D35979;
	Fri, 24 Jan 2025 13:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EDzJhJYS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 292CC35952;
	Fri, 24 Jan 2025 13:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737725218; cv=fail; b=CIWMMzljWiCbyIuOLjzlMcwDRpDPbi8GP6cVN0hB/97s7YFIXmpH67H0TgslT5hCL2qKIehMMgTkBfjOhhxGHJOW4uF81X0ntuhVuY3yeAbTbI03nQ7Gdm6+Y2gwf1mWg5I2ap9DFnfrdpjY6aEmWuI/aizw/V0GZ27Dnw4TZUM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737725218; c=relaxed/simple;
	bh=dLVhE9alcTRDKxrLk9cHnFW3U8OGQrNZd51D3ZxttIs=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YRigvDWTDxxF9ivYkRjXRTkobA9eM4Wr8IaD52G4yJEsBAHr3j/YY0EN2qBroZopvYdieM/1dDNEXsHexnVys8YReVCEDCG5PHkbyB+v2KwaSNg6T4XvkI7/soMNWxhZIId8Y5xh8UnPxpXbKQ6goWAzkFaa7L1cnETTHWH80II=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EDzJhJYS; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737725218; x=1769261218;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=dLVhE9alcTRDKxrLk9cHnFW3U8OGQrNZd51D3ZxttIs=;
  b=EDzJhJYSpFLfvbYssYlV/e4m3nW5yxzeaSckOO7aLF4+Vkqn3S+tJzCs
   2nl47S+zTgef9XfCnds9znHDvDNs5Uf4EMt5FeZgvi4ZXwtEABxtnJTZf
   Yr0AC1DxguxmaryATD2hWRlXxZh5MevbDtjgYRWkKWDQ8QmrIo8k4eUG7
   sO2jdWy15PWHTpp2VAE6Wn4C+Zb/azxgcOce0vNFkFtV8kM5nnDpwn4ss
   kjv0dkHe7oKI/bNhqxTKn86w0J982VNLYO2Jt+jRQAkoZfihPnRFwrsDv
   2skfpILyKZpnlvtTuh1lrXcS5lN+Ct7dnctVKS/u7lXQt7nTU/RWzdqzn
   Q==;
X-CSE-ConnectionGUID: i73cDnb5TQS+fM/13tTMRQ==
X-CSE-MsgGUID: OnQ+yG6nS3CN+HsCs1QmdA==
X-IronPort-AV: E=McAfee;i="6700,10204,11325"; a="55670893"
X-IronPort-AV: E=Sophos;i="6.13,231,1732608000"; 
   d="scan'208";a="55670893"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2025 05:26:57 -0800
X-CSE-ConnectionGUID: ZmYRnUCvT0SaTDOCu02fLQ==
X-CSE-MsgGUID: 7n2VO1ZNRf2X4038zk8j8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,231,1732608000"; 
   d="scan'208";a="138640865"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Jan 2025 05:26:56 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 24 Jan 2025 05:26:55 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Fri, 24 Jan 2025 05:26:55 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.49) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 24 Jan 2025 05:26:55 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MLir8fv7l79N85PzEuSDpzJdi2/X/PZyPE4Em66B42VcGUt2qNaiC5+U8zlw04k27xWpt01hDPIoxOHpgNM81Qb4ZjqgeE/D/hC4xbuHu+X42gegaeyyRCg0k/z1QgHy+mjSh1ElisJmfG+aeQHfuxpg/PbbtfmoAxPB5htg5A0egYNcet+/Kom+v15Mg5u6MdSoX+xdYsK7FeDZF9nJgu213e35tujKOZhZ9magKrnzvyQyqUtZW+8H2uGlpN19ERpw3osr0Y9Tg7Eo/wlP7bifAHCPWAQFCpa0GGYDxgX7hZOudlGymUTkS102+oHbuZYkF0CMhHlWM6mBO5Nj2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L3gd6DTnQCkipaKyWTEOX5J5zoQBsMquc6yboH8QzeE=;
 b=NuIA9Nw6Vqq24tgm8b/y49LM/3/n5YrMDIgRjIEXXBTwU70wnyJ8Acd53Ju3/5u/w4ZZc8R3nsihMXZw++0ecTYU5B6pQNn4kHx9RZta35Ht5LkgudSMM99wzT/bAVhAK2rowtTHuOzNkrK0KO8pMKyuBfLzYUrg7GYOcomoAUwNA8uwbADWWTdzRBxVZ7lbbKlsZb++RKZswG/aFg/7pT5GA3g92WrZhjdSYX5RZMTdtRkzgxJnaYVkPHtsVb9uN/umlO0kIYxdI4X1+gnV703UwzkSH75FjTgGpZPI4R9gpwyuULhi4vKSEYl0J5jg4NtVapXZTQJVMUELhVQtuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by PH7PR11MB6331.namprd11.prod.outlook.com (2603:10b6:510:1fd::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.18; Fri, 24 Jan
 2025 13:26:54 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%4]) with mapi id 15.20.8377.009; Fri, 24 Jan 2025
 13:26:53 +0000
Message-ID: <84f9ab89-483f-4659-8e7c-5b69748d83b8@intel.com>
Date: Fri, 24 Jan 2025 21:31:59 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFCv2 06/13] iommufd: Make attach_handle generic
To: Nicolin Chen <nicolinc@nvidia.com>
CC: <jgg@nvidia.com>, <will@kernel.org>, <robin.murphy@arm.com>,
	<kevin.tian@intel.com>, <tglx@linutronix.de>, <maz@kernel.org>,
	<alex.williamson@redhat.com>, <joro@8bytes.org>, <shuah@kernel.org>,
	<reinette.chatre@intel.com>, <eric.auger@redhat.com>, <yebin10@huawei.com>,
	<apatel@ventanamicro.com>, <shivamurthy.shastri@linutronix.de>,
	<bhelgaas@google.com>, <anna-maria@linutronix.de>, <yury.norov@gmail.com>,
	<nipun.gupta@amd.com>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<kvm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<patches@lists.linux.dev>, <jean-philippe@linaro.org>, <mdf@kernel.org>,
	<mshavit@google.com>, <shameerali.kolothum.thodi@huawei.com>,
	<smostafa@google.com>, <ddutile@redhat.com>
References: <cover.1736550979.git.nicolinc@nvidia.com>
 <c708aedc678c63e2466b43ab9d4f8ac876e49aa1.1736550979.git.nicolinc@nvidia.com>
 <62ccc75d-3f30-4167-b9e1-21dd95a6631d@intel.com>
 <Z4wP8ad/4Q5wMryd@nvidia.com>
 <2b6c52f6-037f-43d9-8384-7b48764a3e81@intel.com>
 <Z43lMrJDdFEDaArW@nvidia.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <Z43lMrJDdFEDaArW@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR04CA0007.apcprd04.prod.outlook.com
 (2603:1096:4:197::19) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|PH7PR11MB6331:EE_
X-MS-Office365-Filtering-Correlation-Id: f066dfd5-022e-4a99-681b-08dd3c7ac422
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RzRjbTZhNWdyZkNrN0NoZDM1ZjFxUlNiOG0wTlJtTDdYU1R3YzE4NlBoU2U1?=
 =?utf-8?B?UkxCVmVlNWVpR21LdEEvNDNsanpRTWZGeE1DSUZTcEtsYVBqQkJPSFI1OHMr?=
 =?utf-8?B?VGNETWR3djZwQVQxOVNXNW9PS3dkTTRXUDhCNy9xVzBqalRydFF2MjRwMDFL?=
 =?utf-8?B?M1padHZ6czdDb3BWUWZtaHZUQVdveDBUMityQ0pvSkQwTk5wM3A1MzBFMHAr?=
 =?utf-8?B?V0JiNGZiTzNHUVI3bm40cExUQmNFYjk0WjBnY092ZHlHOHZjRlo2Y09YZEwx?=
 =?utf-8?B?anlwUDA3QTQvOUIyaExJMisxcWswekZySkJ4d0pTaFV5NHRpNzlDTWFBTTBB?=
 =?utf-8?B?bXRQa0R2WXluVERjMGlIRVVrNnh5c3BFdVdheUlDRDh1SHExL1Bqa1VteG5B?=
 =?utf-8?B?V1dJYWtGVmttMUR3blduUDRrVEExOEZNakdYTVA1Tlk0aUFIM1hwTm1DOGly?=
 =?utf-8?B?RGhST2I2cTlia2Q2WWdNOTIxMldHVFFVVWdONHc0Ky9UT2ttMGtOSE5hNHcx?=
 =?utf-8?B?ald3WElVanhmN1N2RUFkTFJrc3Z1Tk9yWS9zdm9OcVRJTjAvTjlFWmhtZFZI?=
 =?utf-8?B?TU5wSUwzN1Y3NlE2LzRXWlpOWWdUc2R6bmlud25KNEF1bThuamtXZ3hSdHZt?=
 =?utf-8?B?alkvc0FtRVJianFqZ2dwdnFoaWZtdGZMYVZ2eEtKUG9zV3g3c0xlVGtabEtO?=
 =?utf-8?B?azk3eVZOY3ZHUzIyMnM2bXVieG5jbm4yVVZiQ0lrYm9sVzFHYVlzaWNybmd4?=
 =?utf-8?B?dE9uS05XZ3RjR1lGSEYvMFR2dnplME9MQ2tueitQdDdpWjNJVXY2SUJwSXF4?=
 =?utf-8?B?VjExdjdoZ2RjcmNxKzBGczN3cDJ6SWJXK2dxbGJpZFh2b20yZ0xVNDVpZGlC?=
 =?utf-8?B?UzhENVdCa09CTmpnK2taT2Z0d3FuK3NsN3hIcFR5eXFHbjJuQW9lbEs4bTA4?=
 =?utf-8?B?QnR1WDMwYmw5TUFPTHNiVVpMbjZVajg4QklDVEZTcExXWGQ2dWFLbFJUbitS?=
 =?utf-8?B?TEI0YWMybVd1dFkzeXpEbTB6bk5BN0FlWUNMbXRzekRGYUZLcUdvSjNmUFZw?=
 =?utf-8?B?dUw5eS9DS3UweUJpOThSZ2plVnF1cSs5bGVCSWVUdEhkV3B6VlFXRVZLYXE0?=
 =?utf-8?B?NmYxaGdjTlMzNWNESEhVR2VLWWtHM2l3QWZ6YklkeCtrWTlXTGlyV2t3WlRx?=
 =?utf-8?B?VWlkcXJPSXJhMndLd3BuK0I5L2hUdnpmNEhPZjFxdHJiSXhjZ0dQbmcrR0dR?=
 =?utf-8?B?dytjVnZBTWdiL0ZSelFHODVyQk1EUTBiSGtEWWRqOFozWjRxWkhFb3kzTkVy?=
 =?utf-8?B?VVBBOVh2SDNjL092ZWliTTRiR2JlaVUyQXNPaURCcjd1WmVNemhMTGlFUUs5?=
 =?utf-8?B?VjRENldORkV2a0EzZE1SbU5kMEYxUmFKeXJmb1hJdUsrdHM1SzIxdHZGSlVv?=
 =?utf-8?B?eXJBb2g5WTdOSTBHSDkvbG9BaGtZZXQrbnQ0QVdsN1h1aGdlMkp6a0ZhMDVD?=
 =?utf-8?B?Nm05Ukl2M3NjSTVrcjNoaXYyeWxhMmdCOTFtb3pneDVLMEYxbkVmdis1QmZp?=
 =?utf-8?B?SkxXcnpSYWNTNFBQQlNuV08rNzZRRkYrYlhBV3RzZ3phSGZudW5CWElYNjBx?=
 =?utf-8?B?aXZVeVZPY1dDanFMbW9ZV3NsTmQ2Mng5enJBR1F1L1AxVHIzWEFITmVEek9v?=
 =?utf-8?B?Z2ovdVpVV1FwMUVOWGh1aFAxRE4yREdFUW0xVmh3WXAxekxTeUhWekJSMW5w?=
 =?utf-8?B?cDhCNHNkOG9qcy9KTUNPWi9MU0ZjM0UyZVpxcHo4WCtKNkpuSkQyS1hnRDJK?=
 =?utf-8?B?MmVkVnRzV01vUmJMSG8yb0UvVUFQRkdMNTdacWNlSXBqZzhyNkh5WlY4M2Uv?=
 =?utf-8?Q?eR8Z2nrIL0XYE?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q2lET2dpRyt6QXVXSlhwc1lsenkwdFNOQmE0UWhQYmVWRy9iazk1dElqQ0NE?=
 =?utf-8?B?NkV5a3VJMDgwNVpSS3ljZVl0TnJURlhZY3pmdTJNRlpHNENNQndyQUVWOWcv?=
 =?utf-8?B?eHNacU4vNjZidkdCOHVjYU1BcmthUXF6ZzVUY0l4QlBvNHFyT3RqRktpS2tl?=
 =?utf-8?B?Mmp4VGVuZDBWUDE0QkZxWjhLSjFPVURNbjZlSHJteGVNV3Z3TlZ2d0theFE2?=
 =?utf-8?B?NWFrMzhkNHlKMVdyMGptL1I2TUJFSEMwYWl4dXhtRHEvOXo1WjUzQ3J3QzVM?=
 =?utf-8?B?dWxsYkl4RFNXeUJVR0JRYkFnMUNQRkJBa0pKenc4R1ZhM2FjQW9NWjNzL1RV?=
 =?utf-8?B?VFF5UTBJTFJic2dBSmxIaVdoc2w2WnM0NXJBOFV4Q05JWVhuSVRMSFVqTWRt?=
 =?utf-8?B?NmMreDNnQ3pZeWJCOUJ2eXBRdjA5VkQzM0owRTB2RjdiWjFtNFNEcEZsaTBD?=
 =?utf-8?B?dVNaQjN0UElCcS9LUTB5aEVncFNiazBKL3pjRmNPMXJJU1ZubGVnVFZyV2dK?=
 =?utf-8?B?bHhOOVdlNHBZWHhvOXZBSG13T2kxT3hLK04zS05Od1IxdHVpa1o5NUhPTHZ4?=
 =?utf-8?B?Q3dUc0xYM0ZrSXNicXQ1Ly9LNExET1F6VTZhWmowa0tza1M0N2pMZjIwdGsw?=
 =?utf-8?B?U1JyTWVzZFVzVVdoZzgybmpuaVB3eUNJajVmWTdxa1NLZzR6cWREZTVxMnRr?=
 =?utf-8?B?VzkrRXdwTFVXdm9QMnBROEN4bWd6a3E1bW92Ky9ic0dYa1MvUlREemcvZFRJ?=
 =?utf-8?B?SURnaUNoVmt4bFNmQzJwTUxqSWZRTGwrNE1WZ0pIZ1ZBbkc1NmFTZHVRMng0?=
 =?utf-8?B?a04xcTNZaGc4YkZKYXIzUW9XMENqYmNjdE5LSDcyaktIUDJyUFRpUno0Rklw?=
 =?utf-8?B?Mnh6ZWF0cWpjTWdjTGQxenVPVWRhL3Z1Qll4anRrbDRRbVlteXFUdHBINnNV?=
 =?utf-8?B?S0REYjZoRGNwYmRUc2N3L2xPMUpxbHZHTithczJaN0cweU42OTR0cmhPRjVr?=
 =?utf-8?B?T1ZmV0Zwcmhha3orRDdJalpuRzlkYWR3KzM2aWRndlJPRE8xSUdBaENqM3ZI?=
 =?utf-8?B?cVdQc05YZUZlbjNHa3QrWk5PdmVja1NqZ2RDb3ZZOG5TczlvZVJVbTNUQlZk?=
 =?utf-8?B?TzVSbGN4ZFowOTJpSzNOWkZhbjdyR1RUOFZObkI4L3VPaUd3NWJvTlpXYnBt?=
 =?utf-8?B?L2pIQ3p2R1QzSUtJSERKM2dINTBlUkVUeTVnOFJ1bzNpVG5Db3NzS1pkbll6?=
 =?utf-8?B?RG9IbHR2L1o5TmdDb3JxN1NJMUpDcFFpazlMVEovby8vVExMQm5oN2pNcU1M?=
 =?utf-8?B?bkk1K0x0V3FlVm9RUDM0U3k5cUt5UGhOb3dWb0VMc25PZHN1dmVNdDArUDY5?=
 =?utf-8?B?a1J1NFlUKzhDWUN3TkM0SFN2dytqdW9kRFZTeEtEQnNkMnBPazFmbkxKeUlF?=
 =?utf-8?B?SmR6MHpuZEQzUU5jbXBxV3pibXRHY0tTZzZaQ2FzbUJNTkh1d2Q3RTUwaEw0?=
 =?utf-8?B?QmJHK21RRTZWaFVtMG9Mczg4WUxzUkxXdy9GOTFXOFJIQVg1RWFOSThVcXIv?=
 =?utf-8?B?NCtqTHZidCt2V0o4dk5tMTM1dlFBdjl0NnMzeUtXa0c0QVkxam5Fbi9NUUhM?=
 =?utf-8?B?cWVQMlJCVVFNeWlMM0E3TTU4dUtOVHRBbGNUaDN5TGl2RTJoUmk0MjBpVUt4?=
 =?utf-8?B?VnFYN1FPRXFORSsrNW9IeHR1aGFjaWdIYjRwUEd4WHVRNFVVZGJNV296WHNq?=
 =?utf-8?B?Mm55T3FUTFh4NHA2U2VueEp3Z05yVGNvUEM4WnpKTkdaQ3JpeWIweUlXalpk?=
 =?utf-8?B?MVZpT0tVejhZRktEVXpYc0pONHVpRHcxdXRWU1hwTUUwZjA4L3AyOXhuT3Z5?=
 =?utf-8?B?d2loaGFIMHgrMHQzS3U4ajM0NGpMS21pVGk5MFp4V3YrK1ZxaEhwMzJaUWd0?=
 =?utf-8?B?eXB5Y1JHbEJWZndVbnlUY0xNQnllWlRsVG9LbEk3eVN4UkdPWkR4MUhzdHlw?=
 =?utf-8?B?OVRHK2RGYWtiSnlsRzJjdW1UQ2xMOXVGOGtaTXIvWXFmWURsa3J2eW5RZ2h6?=
 =?utf-8?B?ZG5EanoxRFcxZTlRSjYrMFpNS25BVS9WVzYvLzM0ZWx6RmpmWVYyUXdVVjlI?=
 =?utf-8?Q?9/s9IRRwfL09YzLF+gnAE5d+1?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f066dfd5-022e-4a99-681b-08dd3c7ac422
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2025 13:26:53.4324
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w/ELXWnrVZsGcFK6OCsoDHWrjRVAYNN6zt7dP5TbiiL8whrTgsssmZw8tkfl1mQGEtk/+Q04ReN5AreE/jXnOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6331
X-OriginatorOrg: intel.com

On 2025/1/20 13:54, Nicolin Chen wrote:
> On Sun, Jan 19, 2025 at 06:40:57PM +0800, Yi Liu wrote:
>> On 2025/1/19 04:32, Nicolin Chen wrote:
>>> On Sat, Jan 18, 2025 at 04:23:22PM +0800, Yi Liu wrote:
>>>> On 2025/1/11 11:32, Nicolin Chen wrote:
>>>>> +static int iommufd_hwpt_attach_device(struct iommufd_hw_pagetable *hwpt,
>>>>> +				      struct iommufd_device *idev)
>>>>> +{
>>>>> +	struct iommufd_attach_handle *handle;
>>>>> +	int rc;
>>>>> +
>>>>> +	if (hwpt->fault) {
>>>>> +		rc = iommufd_fault_domain_attach_dev(hwpt, idev, true);
>>>>> +		if (rc)
>>>>> +			return rc;
>>>>> +	}
>>>>> +
>>>>> +	handle = kzalloc(sizeof(*handle), GFP_KERNEL);
>>>>> +	if (!handle) {
>>>>> +		rc = -ENOMEM;
>>>>> +		goto out_fault_detach;
>>>>> +	}
>>>>> +
>>>>> +	handle->idev = idev;
>>>>> +	rc = iommu_attach_group_handle(hwpt->domain, idev->igroup->group,
>>>>> +				       &handle->handle);
>>>>> +	if (rc)
>>>>> +		goto out_free_handle;
>>>>> +
>>>>> +	return 0;
>>>>> +
>>>>> +out_free_handle:
>>>>> +	kfree(handle);
>>>>> +	handle = NULL;
>>>>> +out_fault_detach:
>>>>> +	if (hwpt->fault)
>>>>> +		iommufd_fault_domain_detach_dev(hwpt, idev, handle, true);
>>>>> +	return rc;
>>>>> +}
>>>
>>> Here the revert path passes in a handle=NULL..
>>
>> aha. got it. Perhaps we can allocate handle first. In the below thread, it
>> is possible that a failed domain may have pending PRIs, it would require
>> the caller to call the auto response. Although, we are likely to swap the
>> order, but it is nice to have for the caller to do it.
>>
>> https://lore.kernel.org/linux-iommu/f685daca-081a-4ede-b1e1-559009fa9ebc@intel.com/
> 
> Hmm, I don't really see a point in letting the detach flow to
> scan the two lists in hwpt->fault against a zero-ed handle...
> which feels like a waste of CPU cycles?

I meant you may call iommufd_fault_domain_attach_dev() after allocating
handle. Then in the error path, the handle is not zeroed when calling
iommufd_fault_domain_detach_dev(). The cpu circle will not be wasted if
if the two lists are empty. But it would be required if the lists are not
empty. :)

> And I am not sure how that xa_insert part is realted?

Maybe I failed to make it clear. That thread had discussed a case that the
PRIs may be forwarded to hwpt before the attach succeeds. But it is needed
to flush the PRIs in htwp->fault. Although I would swap the order of
xa_insert() and __iommu_set_group_pasid(), it is still nice if iommufd side
flushes the two lists in the error handling path.

Regards,
Yi Liu

