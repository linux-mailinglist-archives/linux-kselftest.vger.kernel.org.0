Return-Path: <linux-kselftest+bounces-20617-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 351929AFCA0
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Oct 2024 10:34:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B84DA1F240FA
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Oct 2024 08:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C49471D2234;
	Fri, 25 Oct 2024 08:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A3Mlg5fd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9878B1D1E92;
	Fri, 25 Oct 2024 08:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729845254; cv=fail; b=a2liYNGVkl2ilYWk+f2qc7ORe3wUYUA/7KUoIxHANHYCWFNaglqwBAh3jGJKOmqTCUo6mWDEwMs17Ziq6WEnIdBulMgt4UknlLS+noC8VCygRIYHZkMZegwuYNcYcwIOZYMJgValHFEcYNduUNloBoAYdfC8vd/7yd7teZKGE48=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729845254; c=relaxed/simple;
	bh=oN//FeKcnXKH1gZw8ojJznHv6hU0hiX4P8VhxBzknlU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JF6hTJfaZoBgYiiwxv9S1cyR+OxqqitTy8p15xZhfN32IqZViT+8An1djTx6AQdpqYLRmzO2NonJChs9k0EFcATOCvpYMo9iTOqQ8B4FOrWVLuQuokS98HFqG1YgVXTYBJeq/NGeH/0uBOuvX1Au76J5GdujiV67BrX0Rq6h2wk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A3Mlg5fd; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729845251; x=1761381251;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=oN//FeKcnXKH1gZw8ojJznHv6hU0hiX4P8VhxBzknlU=;
  b=A3Mlg5fd4Yp6BecvUtbSqgVl/iQMpxn2eRUVDBhRumTYR0B6jWFQKUlR
   okCGrzWeEGiRjCdzvB3I6l/5fSO3mALVC+l6ihLgWK/22L+6Dxc13OzKt
   uaJgzWhRfxbEjuiaPeSnCQU/CfCTxrsCGPF+lBzJf3DxGbnLpJD90N4XY
   CTgVCG8AIuQ/T0+McxLVVbgOsR8giTiS3saJvrRBpbZueOluaT8YJck7z
   EXvjqGnbAC+DGokyIS43JD7exKX/udcJm/60P22UkAxVngYuDkbiw3DAB
   jxdhYeinZRzvxSQb2Z5ndGPo1uF6XVP09s76ES0T9PZnaJNRDLkYY83Pc
   g==;
X-CSE-ConnectionGUID: Jac9NkKERPaAeoSa7XXYrQ==
X-CSE-MsgGUID: 2MW84r6VQWOICSmAcmYWPg==
X-IronPort-AV: E=McAfee;i="6700,10204,11235"; a="29624800"
X-IronPort-AV: E=Sophos;i="6.11,231,1725346800"; 
   d="scan'208";a="29624800"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2024 01:34:10 -0700
X-CSE-ConnectionGUID: 1jJqcQQfRR6Jzc4pzCDetQ==
X-CSE-MsgGUID: 6pgCSOrQRkmnDoZ0ieTr/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="85614151"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Oct 2024 01:34:10 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 25 Oct 2024 01:34:09 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 25 Oct 2024 01:34:09 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.43) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 25 Oct 2024 01:34:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FoxKXlCKbvALczcaNwlS8vPd4uNSe0lZMurFt8yhllpyCkH10AEubWlfJt0CjwaVCxxYT48hHjCvpG/1vcdiN3PDOgCICV2V1Jyx+IMyvaYb7ug27R265J5VU6kg3TVhRfIDpU7HEhnD22GIl2EiDHvXJ//P8HeTTXxeEMhg5+R6QseEQ9m8s01TVJU5SpYxcs0fP4AqmUVkYbPujzOUalkJqXhVnWV/CPUNuHiAd7quZwS+DtFOODcRzPPNfD77eUfArJzTinDglkIeExP5FKE1ayuE2HZxa7tu+1iakR34zK5iLrWOK3NR5IJkhGF6j66g/twsRxprSQvmdFC9wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oN//FeKcnXKH1gZw8ojJznHv6hU0hiX4P8VhxBzknlU=;
 b=drj3nKHzRruVunLL0j3GguD/GKi4kYmxrza+mxPLv9HSt+IRxpXQV3EEkGrYqKhTlBzxXnm++q1Lruq3EYKrPG0hvLKUkisnMV2YsTZonQqzH/i8Sit6LTfhn2AeZx1+64Yv5rrsQ4Xe67hNNXCHKMCjI3Oj82s/sGybycLOqOfK5c70EH4aWfGsNOCJ/cEoML1IYW5y3de9P+TtXnVgFJSVRU7PjVrm9uKYvASc0V7EgXaWJX9qS+m8WubquDtxvl92O1fEAinXDtgmAgIAY2xURogRTcCe+WeIJD9s9wT89CReo3GvZbu5bQA8UsxVThVR4s6Ac9lLwP91MgeZSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by PH0PR11MB4951.namprd11.prod.outlook.com (2603:10b6:510:43::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.21; Fri, 25 Oct
 2024 08:34:06 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%6]) with mapi id 15.20.8093.018; Fri, 25 Oct 2024
 08:34:05 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Nicolin Chen <nicolinc@nvidia.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
	"will@kernel.org" <will@kernel.org>
CC: "joro@8bytes.org" <joro@8bytes.org>, "suravee.suthikulpanit@amd.com"
	<suravee.suthikulpanit@amd.com>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>, "dwmw2@infradead.org" <dwmw2@infradead.org>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>, "shuah@kernel.org"
	<shuah@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "eric.auger@redhat.com"
	<eric.auger@redhat.com>, "jean-philippe@linaro.org"
	<jean-philippe@linaro.org>, "mdf@kernel.org" <mdf@kernel.org>,
	"mshavit@google.com" <mshavit@google.com>,
	"shameerali.kolothum.thodi@huawei.com"
	<shameerali.kolothum.thodi@huawei.com>, "smostafa@google.com"
	<smostafa@google.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "aik@amd.com"
	<aik@amd.com>, "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
	"patches@lists.linux.dev" <patches@lists.linux.dev>
Subject: RE: [PATCH v4 00/11] iommufd: Add vIOMMU infrastructure (Part-1)
Thread-Topic: [PATCH v4 00/11] iommufd: Add vIOMMU infrastructure (Part-1)
Thread-Index: AQHbJBg8fdD1Yoa/lEC5WIlmiKckcrKXJuEQ
Date: Fri, 25 Oct 2024 08:34:05 +0000
Message-ID: <BN9PR11MB52769BCEED1DC36DBCA75AF98C4F2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1729553811.git.nicolinc@nvidia.com>
In-Reply-To: <cover.1729553811.git.nicolinc@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|PH0PR11MB4951:EE_
x-ms-office365-filtering-correlation-id: 1e677e2c-e304-4590-ea06-08dcf4cfc9b4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?aGZnbkxpYkpBYVRJeG1EaXhwejgwQnFHbnIzdEF2Ti9BN1NybVRuRXBKUWwz?=
 =?utf-8?B?VThEZ2E5Ry9ZbldaWEJKbFZoMHEzV25idWJIUjM1NU1ZK2c3ME1HQmhjQ1ZG?=
 =?utf-8?B?Y01XQStrY3JOaVVzdmZrZlV4ZkJaa0NGWXFuWmRWRFJrT3RkSWwxcVZxYjhM?=
 =?utf-8?B?K3U1YmRxR3NrK0tpdmFhLzJNdUVIVFY4eHY0MTh5MDNVNGw1WDM0WWplVGEy?=
 =?utf-8?B?dEhSVFV0YkNhS2k3UGRFaFhYM3kvcWJYeldyZ0tnVE00QU5HU2svM2hpR0NV?=
 =?utf-8?B?ZTVJRFdTYkMyTkRvT1RKcjlMWlEweWRGUjBneVpudmwyTjArUUk0dkJZNzcy?=
 =?utf-8?B?SVVubDVQcTNFY1A2UklQRGhLYURGMm1pUjgzZTY1MWE3NSs0SWNzZlZ4SHhl?=
 =?utf-8?B?WjRTb0NjNDJxbnE1QWFYdTFxbGUrZDQ5UmZEanNYTjdWaldxZTRoRUNZZU1q?=
 =?utf-8?B?TkpDQk1zSDlpL3p2dGlOSnFRNzdyOXkwaVMyT0hYRW42NWFiU0dQaEFpTllk?=
 =?utf-8?B?ZlhJaHlsa3lrVHpiWWNZQjVyZGp0dDZJdTY0aElUT3EvWThvNTE0L21ZTWlD?=
 =?utf-8?B?Mkd4eDM1TmJra1k5Sm8zaStKblpoTEE4cGQ0OTYrZm1tZVd2VTM5bXhkUlZl?=
 =?utf-8?B?V0czMXo0eDhna1kxR1YrcURBdWZ1K3lNdVNVc2N2cWhhZ2JsV0lOUlhMYVE0?=
 =?utf-8?B?a0pueGV6c0VQVjNJL3VoT1lCcnc1cVl4ckU2TlN0N0tia2tPUHgrTytoaEtz?=
 =?utf-8?B?eVl6SzdBMFpkUXJDaXJrNUc4dnFkRmE1K3c2dGxDa0lFb1BGWTVNNCttREI5?=
 =?utf-8?B?bysyV09zeWk1YU5vdERaRS9WSTB2N08zSXBtMnpXVXFvLzhXWUVMekV4eFIz?=
 =?utf-8?B?RnRIdUdvRnVBM2xLRjBTQXcxeUUzbDNoNW9MQ3YrUFpmWnd4UmdCc0g0UXli?=
 =?utf-8?B?ZlNjaDRTU2h5V3gwQ0JTbkJWZGJaeHg5MXdhK2QwQU91clhLQXg4Z3hzS1dr?=
 =?utf-8?B?cUhtMWdRSGtncmxOWkliZWlEYTZ2NzFyNk4ybWxDekJhMGh0TEh2akEyYy9X?=
 =?utf-8?B?TFdFM3BHejU2eTVHMG5rU0JUTHRJVlRPTDdybkc3bTNCSjdBaXMxWXhrWmY0?=
 =?utf-8?B?V2wrUXB5N212d21rQlZCN2RQTDJ4Uk8zTXVLbUxKMmNUZnZzZVFxSlFYa09P?=
 =?utf-8?B?dGRwa0pEdEtOTklSZEpjVXp1bHQzVUpHa3hDdTJYdURUNWpybklubVZybGJw?=
 =?utf-8?B?TkxXZFpDS0dvbTMxNENvQlBxZ0h5RzJUWUZmb3ZKL3RwN2lFSmszSUJDWWxj?=
 =?utf-8?B?bzhQOXNhczRmZC9EV0Z2Z2JGdlpWbk10TVBuSFA4VlFqcysvQ2E3UEpIdHF5?=
 =?utf-8?B?NTNCcnk0Rml6aGtCQ1JpQlNxVjRtVGdDLzU3Rm5teVR5Vi9EQTJXeS9ZQ2VU?=
 =?utf-8?B?eGE5RmFXRFNkbW1BOHBPZ3ZlTnFxSld1azZhYmhDOWk2bi80dW9zN0tvY3FI?=
 =?utf-8?B?VG1xK2F0RXNBTWpKOVVLbmZTM2NlOUg2elhpejJHdlUxblJvSlAzaHpWdFEz?=
 =?utf-8?B?NnJnK3FnK2ZaaFY4VTdEWmNYWE5PRm4zZmxpUGt1RmxaeUJ4VFE0a2VYR1dR?=
 =?utf-8?B?Tkw1a2E3UFJiNkF1YUJOdVJrRTd0eWs2dmV0aUFIKzR1OVZXUHJsaWFkMFVR?=
 =?utf-8?B?WWhTUS90UGdHTS9Odi91SkIydnRFSDhQWFVXOXE3L1N5WXE4SElDbkd1aGkx?=
 =?utf-8?B?bDF6Z2FzRGVoK1I4azZuMCtTTWJacXBPc0EyMFlSVDJkTTczS0N3R2hwWFFO?=
 =?utf-8?B?STEyb1hUN1lrRG4rUWpwZz09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aXZHak9sVkRCWFRVMGJVWW40eXBKTFducmlHZ3ZaR2k5VXMzRVNHbWJpMDlX?=
 =?utf-8?B?RGZYS1poa2lOVTBSdWNGQ0FYd0FBblhCTm4zV1lJcW5CZEJXUTVRblJZV2Zv?=
 =?utf-8?B?WExtVXhsNE1nVzJ3bFlsZ1lvUzZteUZWUkZNNDlPZEl3RGljUklkNERxbzc4?=
 =?utf-8?B?QnNHdENDb01vZVBFSHZWVzE0VTJrNk81TmcxcXd3bTNtNlRjY0Z1N1JvVG10?=
 =?utf-8?B?STQ5K21vZHFyQW5QSWo0ZCtldy9KT0ZDYyt5ZXZlSTI3b1BEUkNxNmY2Q2RU?=
 =?utf-8?B?UXpLMmhCYlNMUkRrWE9hbzBSbGFRVjFiUnF5aWpqcmNjbDJzMDRRQTVRZkZH?=
 =?utf-8?B?V3g0YVZNRGI0Zkx1WWVPUEpUMjZ0REZYb3B4UVQ4MktBLzVWLy9pZmFybm5v?=
 =?utf-8?B?N3lwWkxmT21hSWJGVHUzN3VuaFQ4RG5vSW5jN1BpYXhiQlViWlk0ZHA2QTFz?=
 =?utf-8?B?SUxKRXN5WGp6UHhrOW1TWWVobFBsYXZySmN4K3lWN21xNUtkdFlUTG40amF5?=
 =?utf-8?B?TmRGWXlQTVhVaW5ucy9hWUpobTRJUXpkT2ZYeldIdEoyNnh2UVNlUllFNEt1?=
 =?utf-8?B?YVArUnpuMGtEcHNaRzIwQVp3MWdhVGE1Wk11VE56MlU3KzVydGdxSUliUVFs?=
 =?utf-8?B?WTA2bWl1akpIVDM3cTlkaHR5UXRJNFJFRENOdlZkOGNUbXJRb1lTcmJiL204?=
 =?utf-8?B?Um9uTFZ3ZWdXY251Wk41YkM2djMzZHRFZDMwRi9CRTVEc0ZHejRmSTBkckd3?=
 =?utf-8?B?UVEvdlVYdEtOcXZFOERVMmNoS01jSDRrYTdIRFR3ZlBNK0JlMEpLdVV6ejdy?=
 =?utf-8?B?dm5QK3k0b0dDUklPajFRRXVaME5waUlEeXAySkJGbUJSM3Y3SFB5NWhKUDh3?=
 =?utf-8?B?VDJuU0lYejkzbk0xQnhSWWpkOVo2cHpCRkdBazduMUpaQ1VnMkFnRGw3czdq?=
 =?utf-8?B?YVN1dzNEeGIwV1VFV0FwY1RWR0JSc25idjQwSk01TGJ2TFZTdXhVaVVSWjQ0?=
 =?utf-8?B?dlI2Z1NMckdYcFc1eXB5SlR1REVLVnd5TkdwM3RWcUxZVzVFeDhkQkF2V0N0?=
 =?utf-8?B?aFlDYlp0Slo1bGRYUmd1ZCt4ZkloUzd5Y0taZ08reUJINDF5MzlWc3FHd29u?=
 =?utf-8?B?WXFzZW1ZUnZyek1pOFBVR3dTR2JJOERlMy9PZEJ4YUdrRlJjRE1tdVN3b20v?=
 =?utf-8?B?eEVrWmNXZVJyaFJzNjF1WFV5ZEo2RXB2c0cwS1FpdW9qMld4ZlduNXorNGc1?=
 =?utf-8?B?WTN1bDYwQ2loNzFybUlrcmZYRDFTY2g2TFVjQ2pyeUdCT1FBL00xUmJsSUdu?=
 =?utf-8?B?bUgzVy9tN0l2SzV4UndYRUxJR05WREhxZ3JqNms4Vy9UZWxoQ29iRThMMEJm?=
 =?utf-8?B?VVRSdmF1cHRyRUF3UGhMaDlLN2paU1BKT0JXVlVKRVlmRnlvVzdORFVId2k5?=
 =?utf-8?B?MGNXYW1SNW1oK2hCOGZTQWRGY0V4Yzc1S3A4bE1oem9DYld4dStzOVQyZ09o?=
 =?utf-8?B?cGlibVpwdGthRmlXUUYwandZd3MrM3M4QVhsK08rMHRuN055elR6ams1ZVNQ?=
 =?utf-8?B?dHk3RmFIZWNhZmlhQkRpS1NPRUxUYmk0eENDdjFvUUsrRUM3eTFNTEdOTlVW?=
 =?utf-8?B?bUxLR1hWYXpuZWFvMlEvcjUzUy9PT3dUVk51T0pGdEIrYVB6OXZWNGpSVjlD?=
 =?utf-8?B?K0sxTldmcTIvQXhjKzNmTEdXSEZ0QjkzRmVUTDl3dDM5c0dET2NqRTFRdzNm?=
 =?utf-8?B?UlZaQ0UwU3VSZFJPbkxpamFITGJxT2pmSXoyZEZLc01SREhVZEJBeUlYblls?=
 =?utf-8?B?SlFtTlJ2SDdMMTQreGpoTmFHL2p4VGhSR2UzTkVoT1k1aWdkQTlrMGxLVUJK?=
 =?utf-8?B?TGpNa3ROdHhEWjBneWFlNnd2M2t3aTZ6V0ZuTVczdzRISGJDK245b1E3ZFZv?=
 =?utf-8?B?NW9IU1FEYUVvNjh2MmhaaUtOK0paYUdRU29oV2QrbFdJa1RKcEVVNnN2M1Z2?=
 =?utf-8?B?MXhMZkxKcUhScWpBZE1qV3gvYkE4djlGcWJPWmZtYnBTaG13MXhhMXV4ellH?=
 =?utf-8?B?RE44emhtbzhXNHN2MDlJRGJBVlF5TVNobVl3ZFBiQnhlNDF6NVZGNmpocHRI?=
 =?utf-8?Q?fViQkIlTAITSO+puYP14hrvdX?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e677e2c-e304-4590-ea06-08dcf4cfc9b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2024 08:34:05.8785
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +h3OqCcxKJFNdz3ezqErX/0igtWUfyivCszZ6xbb77FKgz47jhoccStw9IDOJXDtXAK394UD4Z+Qnx5xv0DK7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4951
X-OriginatorOrg: intel.com

PiBGcm9tOiBOaWNvbGluIENoZW4gPG5pY29saW5jQG52aWRpYS5jb20+DQo+IFNlbnQ6IFR1ZXNk
YXksIE9jdG9iZXIgMjIsIDIwMjQgODoxOSBBTQ0KPiANCj4gVGhpcyBzZXJpZXMgaW50cm9kdWNl
cyBhIG5ldyB2SU9NTVUgaW5mcmFzdHJ1Y3R1cmUgYW5kIHJlbGF0ZWQgaW9jdGxzLg0KPiANCj4g
SU9NTVVGRCBoYXMgYmVlbiB1c2luZyB0aGUgSFdQVCBpbmZyYXN0cnVjdHVyZSBmb3IgYWxsIGNh
c2VzLCBpbmNsdWRpbmcgYQ0KPiBuZXN0ZWQgSU8gcGFnZSB0YWJsZSBzdXBwb3J0LiBZZXQsIHRo
ZXJlJ3JlIGxpbWl0YXRpb25zIGZvciBhbiBIV1BULWJhc2VkDQo+IHN0cnVjdHVyZSB0byBzdXBw
b3J0IHNvbWUgYWR2YW5jZWQgSFctYWNjZWxlcmF0ZWQgZmVhdHVyZXMsIHN1Y2ggYXMNCj4gQ01E
UVYNCj4gb24gTlZJRElBIEdyYWNlLCBhbmQgSFctYWNjZWxlcmF0ZWQgdklPTU1VIG9uIEFNRC4g
RXZlbiBmb3IgYSBtdWx0aS0NCj4gSU9NTVUNCj4gZW52aXJvbm1lbnQsIGl0IGlzIG5vdCBzdHJh
aWdodGZvcndhcmQgZm9yIG5lc3RlZCBIV1BUcyB0byBzaGFyZSB0aGUgc2FtZQ0KPiBwYXJlbnQg
SFdQVCAoc3RhZ2UtMiBJTyBwYWdldGFibGUpLCB3aXRoIHRoZSBIV1BUIGluZnJhc3RydWN0dXJl
IGFsb25lOiBhDQo+IHBhcmVudCBIV1BUIHR5cGljYWxseSBob2xkIG9uZSBzdGFnZS0yIElPIHBh
Z2V0YWJsZSBhbmQgdGFnIGl0IHdpdGggb25seQ0KPiBvbmUgSUQgaW4gdGhlIGNhY2hlIGVudHJp
ZXMuIFdoZW4gc2hhcmluZyBvbmUgbGFyZ2Ugc3RhZ2UtMiBJTyBwYWdldGFibGUNCj4gYWNyb3Nz
IHBoeXNpY2FsIElPTU1VIGluc3RhbmNlcywgdGhhdCBvbmUgSUQgbWF5IG5vdCBhbHdheXMgYmUg
YXZhaWxhYmxlDQo+IGFjcm9zcyBhbGwgdGhlIElPTU1VIGluc3RhbmNlcy4gSW4gb3RoZXIgd29y
ZCwgaXQncyBpZGVhbCBmb3IgU1cgdG8gaGF2ZQ0KPiBhIGRpZmZlcmVudCBjb250YWluZXIgZm9y
IHRoZSBzdGFnZS0yIElPIHBhZ2V0YWJsZSBzbyBpdCBjYW4gaG9sZCBhbm90aGVyDQo+IElEIHRo
YXQncyBhdmFpbGFibGUuDQoNCkp1c3QgaG9sZGluZyBtdWx0aXBsZSBJRHMgZG9lc24ndCByZXF1
aXJlIGEgZGlmZmVyZW50IGNvbnRhaW5lci4gVGhpcyBpcw0KanVzdCBhIHNpZGUgZWZmZWN0IHdo
ZW4gdklPTU1VIHdpbGwgYmUgcmVxdWlyZWQgZm9yIG90aGVyIHNhaWQgcmVhc29ucy4NCg0KSWYg
d2UgaGF2ZSB0byBwdXQgbW9yZSB3b3JkcyBoZXJlIEknZCBwcmVmZXIgdG8gYWRkaW5nIGEgYml0
IG1vcmUgZm9yDQpDTURRViB3aGljaCBpcyBtb3JlIGNvbXBlbGxpbmcuIG5vdCBhIGJpZyBkZWFs
IHRob3VnaC4g8J+Yig0KDQo+IA0KPiBGb3IgdGhpcyAiZGlmZmVyZW50IGNvbnRhaW5lciIsIGFk
ZCB2SU9NTVUsIGFuIGFkZGl0aW9uYWwgbGF5ZXIgdG8gaG9sZA0KPiBleHRyYSB2aXJ0dWFsaXph
dGlvbiBpbmZvcm1hdGlvbjoNCj4gDQo+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18NCj4gX19fX19fXw0KPiAgfCAgICAgICAg
ICAgICAgICAgICAgICBpb21tdWZkICh3aXRoIHZJT01NVSkgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgfA0KPiAgfCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgfA0KPiAgfCAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgWzVdICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfA0KPiAgfCAg
ICAgICAgICAgICAgICAgICAgICAgIF9fX19fX19fX19fX18gICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgfA0KPiAgfCAgICAgICAgICAgICAgICAgICAgICAgfCAgICAgICAgICAgICB8
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfA0KPiAgfCAgICAgIHwtLS0tLS0tLS0t
LS0tLS0tfCAgICB2SU9NTVUgICB8ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfA0K
PiAgfCAgICAgIHwgICAgICAgICAgICAgICAgfCAgICAgICAgICAgICB8ICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgfA0KPiAgfCAgICAgIHwgICAgICAgICAgICAgICAgfCAgICAgICAg
ICAgICB8ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfA0KPiAgfCAgICAgIHwgICAg
ICBbMV0gICAgICAgfCAgICAgICAgICAgICB8ICAgICAgICAgIFs0XSAgICAgICAgICAgICBbMl0g
ICAgfA0KPiAgfCAgICAgIHwgICAgIF9fX19fXyAgICAgfCAgICAgICAgICAgICB8ICAgICBfX19f
X19fX19fX19fICAgICBfX19fX19fXyAgfA0KPiAgfCAgICAgIHwgICAgfCAgICAgIHwgICAgfCAg
ICAgWzNdICAgICB8ICAgIHwgICAgICAgICAgICAgfCAgIHwgICAgICAgIHwgfA0KPiAgfCAgICAg
IHwgICAgfCBJT0FTIHw8LS0tfChIV1BUX1BBR0lORyl8PC0tLXwgSFdQVF9ORVNURUQgfDwtLXwg
REVWSUNFIHwgfA0KPiAgfCAgICAgIHwgICAgfF9fX19fX3wgICAgfF9fX19fX19fX19fX198ICAg
IHxfX19fX19fX19fX19ffCAgIHxfX19fX19fX3wgfA0KPiAgfCAgICAgIHwgICAgICAgIHwgICAg
ICAgICAgICAgIHwgICAgICAgICAgICAgICAgICB8ICAgICAgICAgICAgICAgfCAgICAgfA0KPiAN
Cj4gfF9fX19fX3xfX19fX19fX3xfX19fX19fX19fX19fX3xfX19fX19fX19fX19fX19fX198X19f
X19fX19fX19fXw0KPiBfX3xfX19fX3wNCj4gICAgICAgICB8ICAgICAgICB8ICAgICAgICAgICAg
ICB8ICAgICAgICAgICAgICAgICAgfCAgICAgICAgICAgICAgIHwNCj4gICBfX19fX192X19fX18g
ICB8ICAgICAgICBfX19fX192X19fX18gICAgICAgX19fX19fdl9fX19fICAgICAgIF9fX3ZfXw0K
PiAgfCAgIHN0cnVjdCAgIHwgIHwgIFBGTiAgfCAgKHBhZ2luZykgIHwgICAgIHwgIChuZXN0ZWQp
ICB8ICAgICB8c3RydWN0fA0KPiAgfGlvbW11X2RldmljZXwgIHwtLS0tLS0+fGlvbW11X2RvbWFp
bnw8LS0tLXxpb21tdV9kb21haW58PC0tLS0NCj4gfGRldmljZXwNCj4gIHxfX19fX19fX19fX198
ICAgc3RvcmFnZXxfX19fX19fX19fX198ICAgICB8X19fX19fX19fX19ffCAgICAgfF9fX19fX3wN
Cj4gDQoNCm5pdCAtIFsxXSAuLi4gWzVdIGNhbiBiZSByZW1vdmVkLg0KDQo+IFRoZSB2SU9NTVUg
b2JqZWN0IHNob3VsZCBiZSBzZWVuIGFzIGEgc2xpY2Ugb2YgYSBwaHlzaWNhbCBJT01NVSBpbnN0
YW5jZQ0KPiB0aGF0IGlzIHBhc3NlZCB0byBvciBzaGFyZWQgd2l0aCBhIFZNLiBUaGF0IGNhbiBi
ZSBzb21lIEhXL1NXIHJlc291cmNlczoNCj4gIC0gU2VjdXJpdHkgbmFtZXNwYWNlIGZvciBndWVz
dCBvd25lZCBJRCwgZS5nLiBndWVzdC1jb250cm9sbGVkIGNhY2hlIHRhZ3MNCj4gIC0gQWNjZXNz
IHRvIGEgc2hhcmFibGUgbmVzdGluZyBwYXJlbnQgcGFnZXRhYmxlIGFjcm9zcyBwaHlzaWNhbCBJ
T01NVXMNCj4gIC0gVmlydHVhbGl6YXRpb24gb2YgdmFyaW91cyBwbGF0Zm9ybXMgSURzLCBlLmcu
IFJJRHMgYW5kIG90aGVycw0KPiAgLSBEZWxpdmVyeSBvZiBwYXJhdmlydHVhbGl6ZWQgaW52YWxp
ZGF0aW9uDQo+ICAtIERpcmVjdCBhc3NpZ25lZCBpbnZhbGlkYXRpb24gcXVldWVzDQo+ICAtIERp
cmVjdCBhc3NpZ25lZCBpbnRlcnJ1cHRzDQo+ICAtIE5vbi1hZmZpbGlhdGVkIGV2ZW50IHJlcG9y
dGluZw0KDQpzb3JyeSBubyBpZGVhIGFib3V0ICdub24tYWZmaWxpYXRlZCBldmVudCcuIENhbiB5
b3UgZWxhYm9yYXRlPw0KDQo+IA0KPiBPbiBhIG11bHRpLUlPTU1VIHN5c3RlbSwgdGhlIHZJT01N
VSBvYmplY3QgbXVzdCBiZSBpbnN0YW5jZWQgdG8gdGhlDQo+IG51bWJlcg0KPiBvZiB0aGUgcGh5
c2ljYWwgSU9NTVVzIHRoYXQgYXJlIHBhc3NlZCB0byAodmlhIGRldmljZXMpIGEgZ3Vlc3QgVk0s
IHdoaWxlDQoNCid0byB0aGUgbnVtYmVyIG9mIHRoZSBwaHlzaWNhbCBJT01NVXMgdGhhdCBoYXZl
IGEgc2xpY2UgcGFzc2VkIHRvIC4uLiINCg0KPiBiZWluZyBhYmxlIHRvIGhvbGQgdGhlIHNoYXJl
YWJsZSBwYXJlbnQgSFdQVC4gRWFjaCB2SU9NTVUgdGhlbiBqdXN0DQo+IG5lZWRzDQo+IHRvIGFs
bG9jYXRlIGl0cyBvd24gaW5kaXZpZHVhbCBJRCB0byB0YWcgaXRzIG93biBjYWNoZToNCj4gICAg
ICAgICAgICAgICAgICAgICAgLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiAgLS0tLS0t
LS0tLS0tLS0tLSAgICB8ICAgICAgICAgfCAgcGFnaW5nX2h3cHQwICB8DQo+ICB8IGh3cHRfbmVz
dGVkMCB8LS0tPnwgdmlvbW11MCAtLS0tLS0tLS0tLS0tLS0tLS0NCj4gIC0tLS0tLS0tLS0tLS0t
LS0gICAgfCAgICAgICAgIHwgICAgICBJRHggICAgICAgfA0KPiAgICAgICAgICAgICAgICAgICAg
ICAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+ICAgICAgICAgICAgICAgICAgICAgIC0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gIC0tLS0tLS0tLS0tLS0tLS0gICAgfCAgICAg
ICAgIHwgIHBhZ2luZ19od3B0MCAgfA0KPiAgfCBod3B0X25lc3RlZDEgfC0tLT58IHZpb21tdTEg
LS0tLS0tLS0tLS0tLS0tLS0tDQo+ICAtLS0tLS0tLS0tLS0tLS0tICAgIHwgICAgICAgICB8ICAg
ICAgSUR5ICAgICAgIHwNCj4gICAgICAgICAgICAgICAgICAgICAgLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLQ0KPiANCj4gQXMgYW4gaW5pdGlhbCBwYXJ0LTEsIGFkZCBJT01NVUZEX0NNRF9W
SU9NTVVfQUxMT0MgaW9jdGwgZm9yIGFuDQo+IGFsbG9jYXRpb24NCj4gb25seS4gQW5kIGltcGxl
bWVudCBpdCBpbiBhcm0tc21tdS12MyBkcml2ZXIgYXMgYSByZWFsIHdvcmxkIHVzZSBjYXNlLg0K
PiANCj4gTW9yZSB2SU9NTVUtYmFzZWQgc3RydWN0cyBhbmQgaW9jdGxzIHdpbGwgYmUgaW50cm9k
dWNlZCBpbiB0aGUgZm9sbG93LXVwDQo+IHNlcmllcyB0byBzdXBwb3J0IHZERVZJQ0UsIHZJUlEg
KHZFVkVOVCkgYW5kIHZRVUVVRSBvYmplY3RzLiBBbHRob3VnaCB3ZQ0KPiByZXB1cnBvc2VkIHRo
ZSB2SU9NTVUgb2JqZWN0IGZyb20gYW4gZWFybGllciBSRkMsIGp1c3QgZm9yIGEgcmVmZXJlY2U6
DQo+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC9jb3Zlci4xNzEyOTc4MjEyLmdpdC5uaWNv
bGluY0BudmlkaWEuY29tLw0KPiANCj4gVGhpcyBzZXJpZXMgaXMgb24gR2l0aHViOg0KPiBodHRw
czovL2dpdGh1Yi5jb20vbmljb2xpbmMvaW9tbXVmZC9jb21taXRzL2lvbW11ZmRfdmlvbW11X3Ax
LXY0DQo+IChwYXJpbmcgUUVNVSBicmFuY2ggZm9yIHRlc3Rpbmcgd2lsbCBiZSBwcm92aWRlZCB3
aXRoIHRoZSBwYXJ0MiBzZXJpZXMpDQo+IA0KPiBDaGFuZ2Vsb2cNCj4gdjQNCj4gICogQWRkZWQg
IlJldmlld2VkLWJ5IiBmcm9tIEphc29uDQo+ICAqIERyb3BwZWQgSU9NTVVfVklPTU1VX1RZUEVf
REVGQVVMVCBzdXBwb3J0DQo+ICAqIERyb3BwZWQgaW9tbXVmZF9vYmplY3RfYWxsb2NfZWxtIHJl
bmFtaW5ncw0KPiAgKiBSZW5hbWVkIGlvbW11ZmQncyB2aW9tbXVfYXBpLmMgdG8gZHJpdmVyLmMN
Cj4gICogUmV3b3JrZWQgaW9tbXVmZF92aW9tbXVfYWxsb2MgaGVscGVyDQo+ICAqIEFkZGVkIGEg
c2VwYXJhdGUgaW9tbXVmZF9od3B0X25lc3RlZF9hbGxvY19mb3JfdmlvbW11IGZ1bmN0aW9uIGZv
cg0KPiAgICBod3B0X25lc3RlZCBhbGxvY2F0aW9ucyBvbiBhIHZJT01NVSwgYW5kIGFkZGVkIGNv
bXBhcmlzb24gYmV0d2Vlbg0KPiAgICB2aW9tbXUtPmlvbW11X2Rldi0+b3BzIGFuZCBkZXZfaW9t
bXVfb3BzKGlkZXYtPmRldikNCj4gICogUmVwbGFjZWQgczJfcGFyZW50IHdpdGggdnNtbXUgaW4g
YXJtX3NtbXVfbmVzdGVkX2RvbWFpbg0KPiAgKiBSZXBsYWNlZCBkb21haW5fYWxsb2NfdXNlciBp
biBpb21tdV9vcHMgd2l0aCBkb21haW5fYWxsb2NfbmVzdGVkIGluDQo+ICAgIHZpb21tdV9vcHMN
Cj4gICogUmVwbGFjZWQgd2FpdF9xdWV1ZV9oZWFkX3Qgd2l0aCBhIGNvbXBsZXRpb24sIHRvIGRl
bGF5IHRoZSB1bnBsdWcgb2YNCj4gICAgbW9ja19pb21tdV9kZXYNCj4gICogQ29ycmVjdGVkIGRv
Y3VtZW50YXRpb24gZ3JhcGggdGhhdCB3YXMgbWlzc2luZyBzdHJ1Y3QgaW9tbXVfZGV2aWNlDQo+
ICAqIEFkZGVkIGFuIGlvbW11ZmRfdmVyaWZ5X3VuZmluYWxpemVkX29iamVjdCBoZWxwZXIgdG8g
dmVyaWZ5IGRyaXZlci0NCj4gICAgYWxsb2NhdGVkIHZJT01NVS92REVWSUNFIG9iamVjdHMNCj4g
ICogQWRkZWQgbWlzc2luZyB0ZXN0IGNhc2VzIGZvciBURVNUX0xFTkdUSCBhbmQgZmFpbF9udGgN
Cj4gdjMNCj4gIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC9jb3Zlci4xNzI4NDkxNDUzLmdp
dC5uaWNvbGluY0BudmlkaWEuY29tLw0KPiAgKiBSZWJhc2VkIG9uIHRvcCBvZiBKYXNvbidzIG5l
c3RpbmcgdjMgc2VyaWVzDQo+ICAgIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC8wLXYzLWUy
ZTE2Y2Q3NDY3ZisyYTZhMS0NCj4gc21tdXYzX25lc3RpbmdfamdnQG52aWRpYS5jb20vDQo+ICAq
IFNwbGl0IHRoZSBzZXJpZXMgaW50byBzbWFsbGVyIHBhcnRzDQo+ICAqIEFkZGVkIEphc29uJ3Mg
UmV2aWV3ZWQtYnkNCj4gICogQWRkZWQgYmFjayB2aW9tbXUtPmlvbW11X2Rldg0KPiAgKiBBZGRl
ZCBzdXBwb3J0IGZvciBkcml2ZXItYWxsb2NhdGVkIHZJT01NVSB2LnMuIGNvcmUtYWxsb2NhdGVk
DQo+ICAqIERyb3BwZWQgYXJtX3NtbXVfY2FjaGVfaW52YWxpZGF0ZV91c2VyDQo+ICAqIEFkZGVk
IGFuIGlvbW11ZmRfdGVzdF93YWl0X2Zvcl91c2VycygpIGluIHNlbGZ0ZXN0DQo+ICAqIFJld29y
a2VkIHRlc3QgY29kZSB0byBtYWtlIHZpb21tdSBhbiBpbmRpdmlkdWFsIEZJWFRVUkUNCj4gICog
QWRkZWQgbWlzc2luZyBURVNUX0xFTkdUSCBjYXNlIGZvciB0aGUgbmV3IGlvY3RsIGNvbW1hbmQN
Cj4gdjINCj4gIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC9jb3Zlci4xNzI0Nzc2MzM1Lmdp
dC5uaWNvbGluY0BudmlkaWEuY29tLw0KPiAgKiBMaW1pdGVkIHZkZXZfaWQgdG8gb25lIHBlciBp
ZGV2DQo+ICAqIEFkZGVkIGEgcndfc2VtIHRvIHByb3RlY3QgdGhlIHZkZXZfaWQgbGlzdA0KPiAg
KiBSZXdvcmtlZCBkcml2ZXItbGV2ZWwgQVBJcyB3aXRoIHByb3BlciBsb2NraW5ncw0KPiAgKiBB
ZGRlZCBhIG5ldyB2aW9tbXVfYXBpIGZpbGUgZm9yIElPTU1VRkRfRFJJVkVSIGNvbmZpZw0KPiAg
KiBEcm9wcGVkIHVzZWxlc3MgaW9tbXVfZGV2IHBvaW50IGZyb20gdGhlIHZpb21tdSBzdHJ1Y3R1
cmUNCj4gICogQWRkZWQgbWlzc2luZyBpbmRleCBudW1uYmVycyB0byBuZXcgdHlwZXMgaW4gdGhl
IHVBUEkgaGVhZGVyDQo+ICAqIERyb3BwZWQgSU9NTVVfVklPTU1VX0lOVkFMSURBVEUgdUFQSTsg
SW5zdGVhZCwgcmV1c2UgdGhlIEhXUFQNCj4gb25lDQo+ICAqIFJld29ya2VkIG1vY2tfdmlvbW11
X2NhY2hlX2ludmFsaWRhdGUoKSB1c2luZyB0aGUgbmV3IGlvbW11IGhlbHBlcg0KPiAgKiBSZW9y
ZGVyZWQgZGV0YWlscyBvZiBzZXQvdW5zZXRfdmRldl9pZCBoYW5kbGVycyBmb3IgcHJvcGVyIGxv
Y2tpbmdzDQo+IHYxDQo+ICBodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvY292ZXIuMTcyMzA2
MTM3Ny5naXQubmljb2xpbmNAbnZpZGlhLmNvbS8NCj4gDQo+IFRoYW5rcyENCj4gTmljb2xpbg0K
PiANCj4gTmljb2xpbiBDaGVuICgxMSk6DQo+ICAgaW9tbXVmZDogTW92ZSBzdHJ1Y3QgaW9tbXVm
ZF9vYmplY3QgdG8gcHVibGljIGlvbW11ZmQgaGVhZGVyDQo+ICAgaW9tbXVmZDogSW50cm9kdWNl
IElPTU1VRkRfT0JKX1ZJT01NVSBhbmQgaXRzIHJlbGF0ZWQgc3RydWN0DQo+ICAgaW9tbXVmZDog
QWRkIGlvbW11ZmRfdmVyaWZ5X3VuZmluYWxpemVkX29iamVjdA0KPiAgIGlvbW11ZmQvdmlvbW11
OiBBZGQgSU9NTVVfVklPTU1VX0FMTE9DIGlvY3RsDQo+ICAgaW9tbXVmZDogQWRkIGRvbWFpbl9h
bGxvY19uZXN0ZWQgb3AgdG8gaW9tbXVmZF92aW9tbXVfb3BzDQo+ICAgaW9tbXVmZDogQWxsb3cg
cHRfaWQgdG8gY2FycnkgdmlvbW11X2lkIGZvciBJT01NVV9IV1BUX0FMTE9DDQo+ICAgaW9tbXVm
ZC9zZWxmdGVzdDogQWRkIHJlZmNvdW50IHRvIG1vY2tfaW9tbXVfZGV2aWNlDQo+ICAgaW9tbXVm
ZC9zZWxmdGVzdDogQWRkIElPTU1VX1ZJT01NVV9UWVBFX1NFTEZURVNUDQo+ICAgaW9tbXVmZC9z
ZWxmdGVzdDogQWRkIElPTU1VX1ZJT01NVV9BTExPQyB0ZXN0IGNvdmVyYWdlDQo+ICAgRG9jdW1l
bnRhdGlvbjogdXNlcnNwYWNlLWFwaTogaW9tbXVmZDogVXBkYXRlIHZJT01NVQ0KPiAgIGlvbW11
L2FybS1zbW11LXYzOiBBZGQgSU9NTVVfVklPTU1VX1RZUEVfQVJNX1NNTVVWMw0KPiBzdXBwb3J0
DQo+IA0KPiAgZHJpdmVycy9pb21tdS9pb21tdWZkL01ha2VmaWxlICAgICAgICAgICAgICAgIHwg
IDUgKy0NCj4gIGRyaXZlcnMvaW9tbXUvYXJtL2FybS1zbW11LXYzL2FybS1zbW11LXYzLmggICB8
IDI2ICsrKy0tLQ0KPiAgZHJpdmVycy9pb21tdS9pb21tdWZkL2lvbW11ZmRfcHJpdmF0ZS5oICAg
ICAgIHwgMzYgKystLS0tLS0NCj4gIGRyaXZlcnMvaW9tbXUvaW9tbXVmZC9pb21tdWZkX3Rlc3Qu
aCAgICAgICAgICB8ICAyICsNCj4gIGluY2x1ZGUvbGludXgvaW9tbXUuaCAgICAgICAgICAgICAg
ICAgICAgICAgICB8IDE0ICsrKw0KPiAgaW5jbHVkZS9saW51eC9pb21tdWZkLmggICAgICAgICAg
ICAgICAgICAgICAgIHwgODkgKysrKysrKysrKysrKysrKysrKw0KPiAgaW5jbHVkZS91YXBpL2xp
bnV4L2lvbW11ZmQuaCAgICAgICAgICAgICAgICAgIHwgNTYgKysrKysrKysrKy0tDQo+ICB0b29s
cy90ZXN0aW5nL3NlbGZ0ZXN0cy9pb21tdS9pb21tdWZkX3V0aWxzLmggfCAyOCArKysrKysNCj4g
IC4uLi9hcm0vYXJtLXNtbXUtdjMvYXJtLXNtbXUtdjMtaW9tbXVmZC5jICAgICB8IDc5ICsrKysr
KysrKystLS0tLS0NCj4gIGRyaXZlcnMvaW9tbXUvYXJtL2FybS1zbW11LXYzL2FybS1zbW11LXYz
LmMgICB8ICA5ICstDQo+ICBkcml2ZXJzL2lvbW11L2lvbW11ZmQvZHJpdmVyLmMgICAgICAgICAg
ICAgICAgfCAzOCArKysrKysrKw0KPiAgZHJpdmVycy9pb21tdS9pb21tdWZkL2h3X3BhZ2V0YWJs
ZS5jICAgICAgICAgIHwgNjkgKysrKysrKysrKysrKy0NCj4gIGRyaXZlcnMvaW9tbXUvaW9tbXVm
ZC9tYWluLmMgICAgICAgICAgICAgICAgICB8IDU4ICsrKysrKy0tLS0tLQ0KPiAgZHJpdmVycy9p
b21tdS9pb21tdWZkL3NlbGZ0ZXN0LmMgICAgICAgICAgICAgIHwgNzMgKysrKysrKysrKysrKy0t
DQo+ICBkcml2ZXJzL2lvbW11L2lvbW11ZmQvdmlvbW11LmMgICAgICAgICAgICAgICAgfCA4NSAr
KysrKysrKysrKysrKysrKysNCj4gIHRvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2lvbW11L2lvbW11
ZmQuYyAgICAgICB8IDc4ICsrKysrKysrKysrKysrKysNCj4gIC4uLi9zZWxmdGVzdHMvaW9tbXUv
aW9tbXVmZF9mYWlsX250aC5jICAgICAgICB8IDExICsrKw0KPiAgRG9jdW1lbnRhdGlvbi91c2Vy
c3BhY2UtYXBpL2lvbW11ZmQucnN0ICAgICAgIHwgNjkgKysrKysrKysrKysrKy0NCj4gIDE4IGZp
bGVzIGNoYW5nZWQsIDcwMSBpbnNlcnRpb25zKCspLCAxMjQgZGVsZXRpb25zKC0pDQo+ICBjcmVh
dGUgbW9kZSAxMDA2NDQgZHJpdmVycy9pb21tdS9pb21tdWZkL2RyaXZlci5jDQo+ICBjcmVhdGUg
bW9kZSAxMDA2NDQgZHJpdmVycy9pb21tdS9pb21tdWZkL3Zpb21tdS5jDQo+IA0KPiAtLQ0KPiAy
LjQzLjANCj4gDQoNCg==

