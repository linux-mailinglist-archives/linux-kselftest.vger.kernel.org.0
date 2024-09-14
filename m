Return-Path: <linux-kselftest+bounces-17973-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FFB1978CF7
	for <lists+linux-kselftest@lfdr.de>; Sat, 14 Sep 2024 05:03:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 034D01F25640
	for <lists+linux-kselftest@lfdr.de>; Sat, 14 Sep 2024 03:03:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3672ED528;
	Sat, 14 Sep 2024 03:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kjOnwpFR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A383BC2C6
	for <linux-kselftest@vger.kernel.org>; Sat, 14 Sep 2024 03:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726283028; cv=fail; b=fmI6JJVezrAyScXeS5YWylA2DJd9bKAUTVcVH9MmKuBYYGeAkyjodD42tdxOhof0E2bpcrdpb8afzY/JKiUsY+uLVdl2sf0ZhH1xCcpaHtu8XZF8svDt6wbMn+3mBplcUvhXfXcQrXe8Qyg5B9AjtHqn9CXzTFrMl8P3O2fLmbk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726283028; c=relaxed/simple;
	bh=PLHuqC6Y8p4Kyi60WGLsiM/TB3N5RCGnIHCR+HSCM5w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XdTqxoYzNsYAEc7Yc2i5nj9cKlqIXuMkoi0QEzAOQk2Iy4tdzfSuzIMhtIsbO+EaJfaaz4W0slD3480xUrDL2+n0CvE9E+BjEg43akRDVEZ0PwXE1cnw4vhGF6tFt0OO5SKabnukCEnvnD0Pq/e0EBvEzt3XPV3msPbAcFeUsb4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kjOnwpFR; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726283027; x=1757819027;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=PLHuqC6Y8p4Kyi60WGLsiM/TB3N5RCGnIHCR+HSCM5w=;
  b=kjOnwpFRT/s883mV3DQqyg9USGOUQZTrf15a2JKWC2Zp0CK3qDV4Httx
   DA4g1kO39H2J5khRDqN+C2xN9A6aQFobAWRfHrUPd9lRuIqJPtPQcgQJM
   +xze7YE8VnLtjjBL9g4rC5Klo9ICAEKNNGIi+n/0BcTMKrYI4TWkY/lUY
   9v0KqdkeHI0et2p/ir2UVvTRMQDl966zlVoccWQh1IRy5CAb6YSkv6AgD
   Ntmp1N6JanRjhNRXhkJFY53wD3in0Vef1eOdr2rtogbVDc4y+i4b8EC9u
   twCZlocGUB1aVQTPCgJH9PcXdK0hoTT/7JVSRsiOwgnz0loBj3qDhE270
   g==;
X-CSE-ConnectionGUID: JqA/fXdSRemltZB6Kj9sZA==
X-CSE-MsgGUID: lmd89kZ8QLSDAoMH5LU1RQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11194"; a="35771024"
X-IronPort-AV: E=Sophos;i="6.10,228,1719903600"; 
   d="scan'208";a="35771024"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2024 20:03:46 -0700
X-CSE-ConnectionGUID: T+AzrifbTlSV15hrVOynxQ==
X-CSE-MsgGUID: UdA2XSWzRz+/ONNQi+Lh/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,228,1719903600"; 
   d="scan'208";a="91562482"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Sep 2024 20:03:46 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 13 Sep 2024 20:03:45 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 13 Sep 2024 20:03:45 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 13 Sep 2024 20:03:45 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 13 Sep 2024 20:03:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YXZ2/nORS4hZCwQ6ZGpKzh3oGA3ML4G1kiV8rcnpQiIxZ3gj0mRHOstLVP8VS5RwwcLOrSWb/mjJ/qPbGiUn3JE+JpwU6JyR1kYJ7pFnVGq+3UPVqLVcEN3Uw+MgQsUfVFmDP9/Mdlgbqw85tZTWxlrxvKFLgMH20CNJVbj0AfOnC6WP6CC6UjxUprrQFz6y72OQlU/yt8Eox9MbBlRIestZ/FqHF1TFK6SOikjGPJARxlgq9XGBJFuiDJMecqmIWN0xJvHTlLkSre0e+c+hT/cMNh09CA5W01ZDh9VTUgYs7YhHylphayK+UbIUb2vmJaGmugvuMZCioEmOScxR/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PLHuqC6Y8p4Kyi60WGLsiM/TB3N5RCGnIHCR+HSCM5w=;
 b=Pc4xA2WuFaTYiKn6TOFDMo1545nJpJe7e9Q9HrIP1/jJFZEhtwWcxklXHvmEuN6u0ApSh8PZHWv/5b/bhyd9dY/RNvXRwxFcn9lSISl148b55pCnlHrUycfpZxv1mrGPYPf4UsNLNIFViBsS1JCT6KDLlPp37l2QFoGw8pmSk0YiN4PrMUrjX5jCye8a4Xienz9bkzECou33wt03hzuJSF14gUo7dTwizmRB5c6arDOTNtssEkVQ1xcZYXCczEU2p2qmNXEIwjgN9FqvDEdXr66kMr7GqKRXZ3uYNpUKRD6yXPeIByQnWn6euegMir0O2sYoRw1DVt7pTSLD/keyYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by CY8PR11MB7290.namprd11.prod.outlook.com (2603:10b6:930:9a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.18; Sat, 14 Sep
 2024 03:03:43 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%4]) with mapi id 15.20.7962.018; Sat, 14 Sep 2024
 03:03:43 +0000
From: "Liu, Yi L" <yi.l.liu@intel.com>
To: Baolu Lu <baolu.lu@linux.intel.com>
CC: "joro@8bytes.org" <joro@8bytes.org>, "jgg@nvidia.com" <jgg@nvidia.com>,
	"Tian, Kevin" <kevin.tian@intel.com>, "alex.williamson@redhat.com"
	<alex.williamson@redhat.com>, "eric.auger@redhat.com"
	<eric.auger@redhat.com>, "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
	"chao.p.peng@linux.intel.com" <chao.p.peng@linux.intel.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, "Duan, Zhenzhong"
	<zhenzhong.duan@intel.com>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "vasant.hegde@amd.com"
	<vasant.hegde@amd.com>
Subject: Re: [PATCH v2 3/6] iommu/vt-d: Make intel_iommu_set_dev_pasid() to
 handle domain replacement
Thread-Topic: [PATCH v2 3/6] iommu/vt-d: Make intel_iommu_set_dev_pasid() to
 handle domain replacement
Thread-Index: AQHbBRRZwSQ1AsREnke3q1YngEr8v7JU8k4AgACyg4CAANT4AIAAIXix
Date: Sat, 14 Sep 2024 03:03:43 +0000
Message-ID: <7917E9CA-82E2-496B-A2DD-161C9506FC90@intel.com>
References: <20240912130427.10119-1-yi.l.liu@intel.com>
 <20240912130427.10119-4-yi.l.liu@intel.com>
 <08e6739e-762f-4552-adbe-52259747c813@linux.intel.com>
 <69398a64-6c2a-40a0-a088-5fdde956f9da@intel.com>
 <735498cd-1e5a-496e-8f0c-09c09ffb7db2@linux.intel.com>
In-Reply-To: <735498cd-1e5a-496e-8f0c-09c09ffb7db2@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB7529:EE_|CY8PR11MB7290:EE_
x-ms-office365-filtering-correlation-id: 12b5b695-6777-49b9-722b-08dcd469d774
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?YjM1My9iTmUwY2ZTSnQ4UExIYTRmb1dtM3MrVm9tTld6MmZoTDVwUVIxcEl5?=
 =?utf-8?B?SVNodXVFMTRjZjJYTE9PWis5cGU3Zit5UnE1bGNpbkF5SWVvNEtiaWlvWS9P?=
 =?utf-8?B?RTJPR3FSTkIxVmlCMlFiUXlPUzhQTDJIK0FndHE5OTdTTEMweGs0ZHJJTWhL?=
 =?utf-8?B?THpWZzc0b2c1eHdRRnlzenc4aUtpQzJyQWo1d1RPWW14cENuYUpiR0phU3pN?=
 =?utf-8?B?UGxySTBPZUtrRldwaFI2NGlicWxFTy9Rcjk2RnpWZWZoK05peHU3MlpvZjBn?=
 =?utf-8?B?d3VzVk9KZm9CdzQ2WWhFYnNMdFNPTm9oQ3dzR3RzUkdXaDMxRW80aWhTbFJZ?=
 =?utf-8?B?TTl2RS9pbUd6S2F0V211NWxaRU9zNm1XeFFqSW81dWpqZTFYdlhNS3FiTWR0?=
 =?utf-8?B?QW1vcEw4TGlLM1BpRk9CcmltMHdEbi80SzgvNkJKbGF2OUJqdlhjRFhPOWVJ?=
 =?utf-8?B?NS9YU0VvUFFab0JtaGl3c3NmU2dQMXZ6L0VJSzJseGFiWk1JbzB0VFA5bnYz?=
 =?utf-8?B?dlIrTVBjL1BGRHRBeFF0Z0NDV3RCaU9EYy9nMU5zU1lIZXNkdE1rQU1OY0tB?=
 =?utf-8?B?T3VrRTFTRG5qMU1OMzFXRG5WNnIvWmFDendOQkx5eHJ1SWhtYy9jMTUrbVVF?=
 =?utf-8?B?NnduNm51SFlrVHpBUzZjTEdGQXRFQkU2NTFjcGtwVmovcUFNN3ZtQW9sUXRh?=
 =?utf-8?B?cmYzVjVIYVdFNTdmbjJvZlJqQmpZV2tBb0h1M0ljbXhGMzgzK3NzQ3VmSG1v?=
 =?utf-8?B?T042VGg2bVN3dFBWcFBXL0Zlbzd3MU1WMXcrZDJraG1vN3dnbEhxNzg5YUIv?=
 =?utf-8?B?ZndNaHdqcmwvb2NxbGpjNWJrUkptZlM5aEp6cnJWQjFMTkJxbjAvQkZGeFNF?=
 =?utf-8?B?MEJ5N05wY1A5WUw3ZVU2c3B5RVBsR2RBYWhXOEgzTkxJVklVd1o1MW52UnBU?=
 =?utf-8?B?YUpsdG1ESEswZ1d0eWdYV2IzM0hzcDZYV1lFYmdsaXhNcHFqUkxXNEZlQldB?=
 =?utf-8?B?VUw2TVpYQUFUMW4weEJUajN2MUswK1NNVlJUTkVUaytPR1E0LzY4Rncremp1?=
 =?utf-8?B?S0tpYUFrVFVlVjZSYzNSV2szd0F1U21NWW5lNGVGT3RwNVdtMG1kSmxKZkxO?=
 =?utf-8?B?bnpqeDlMOVJ2eVJKTEl6NmNpaWJFWWFTSzRVaFhiZ1E3TDdDRlNOcy9uYWhw?=
 =?utf-8?B?YVhRTGtTSVgvOXljbHJyNkN0QmVmcG1WbE80eXQ2ZDBneVJoQTQ3T29QUjFP?=
 =?utf-8?B?S2FxSUt0WHMvNlBzM205QnM3UGdyaVQvUDNUYWQ5akp5SlhWQy9nbTBZUXd4?=
 =?utf-8?B?Si9qOCs1ME5iWmlMRmZ4T2FrbC9EZ3BXWVhROE5wWWN4bTBlVnRlbDBaa2Fu?=
 =?utf-8?B?WUR4OHJBSkRBNGNCQ0prdmxLWmFSUGY1RGxpZUVpQm04NzlWWGtGeStiYVgr?=
 =?utf-8?B?Nnp6SWVwUUJTRVZpaWpjeGlnUlJNQWNhaUJDTm1nMXR4VFBja01nUEdkYk85?=
 =?utf-8?B?aE1Yb0ViaEdHWDgydEQwR1FwZ0RBd1lwOVR1aUVUbWhkajMzUW84QXhWNGhh?=
 =?utf-8?B?aWl3UWhqT3VrRExHVW9zek5GelpFVHhKcHVsR1RLZm12TmpFWlVIVXAxcWJJ?=
 =?utf-8?B?R1NvaXBvRHE0R1RvM0tmNkN1VklxeXdycnEzWm12R0p5Ymc2WnpBTDdSQlh1?=
 =?utf-8?B?MnpKTnBUNjY3QWR0azlzbElMSHFoV2hTc3l0RmRNUlYzbEhSWGdRRnhKTDND?=
 =?utf-8?B?UXZZQlEvUTFFM25adFRUa1NSOGJlWi8rYVJ4NGR1a3FGelFNaEpMYnZtYmZU?=
 =?utf-8?B?dVJsQk9DU0o5NnNpM0JpR0Z4S1FGZGRhTEthVHJQbXdkUExqTFVYMjN0eVox?=
 =?utf-8?B?VVlZOGF2YUZwdlZjalhhZ2ZOL1lsdHJWQm9Bbmt1TU5PN2c9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V05XWW9mTGJ2c2FsYjlaaXFLdWsyeWZ0WUsxNHFPSG5xZnk4ajNVSVh5d2hJ?=
 =?utf-8?B?OTlpQ1NMRDdRQlIrc3V4NHlsNU9ERWZtNEhEL2lYc3hDS1FJY3VZY3psUUpZ?=
 =?utf-8?B?OXFyMURHcWRTTUJHaWZjT2xjRHI1RnNwRXJaODNWRTJlamVaSWo5V0c4dzc5?=
 =?utf-8?B?NkhQQWRwbVZmQXBZRFBFNG0yK2RGVE40ZkU4cnNaZ0tNbldjQkNnMWdYaXo2?=
 =?utf-8?B?TzNRMjlHLzkxaTBRb3NCZThTWWEvdDlqdFJySnpLbnYzS3plcFBhOFM5MjVJ?=
 =?utf-8?B?TFJFYTRqbnpmbmwzdEpWSUNZMzloRkdDWnF5R1pMbnEzVmRtdDdmeW9lTExz?=
 =?utf-8?B?akZBSmp2TWNockJiTUlFZkQ2MEsrSWU5bE9NNGViVHVmNXRyNWEzQm1Ybncv?=
 =?utf-8?B?TEdwcDl1bU5JVlJvZEV0NTExNExkOUlaVUM3bGFtWXNRUVZ4ZXFRa3V5LzJL?=
 =?utf-8?B?Tisxc2RzV3Roc1R5VHl1dittWFpYekZwR0YvWlpudDZMb1YrMTh5WEpGTFJD?=
 =?utf-8?B?ay83eUR3QlhEUnhwcHhua2h5M0tNTDdhSnJuUG05ZGQ1V0ZYMHVMSWMzQUdp?=
 =?utf-8?B?UGdPLzFLRjVCUHlZckJLVzNJa0pxcm1uNGNzSHJ2WWs4V0RydUFwRGFTQ0Vk?=
 =?utf-8?B?WklsYmVUQkJPMzJ2VW1IaSt0UDE0ejh3TTVUWnYweExFYUdSS2pFeUh2bjc2?=
 =?utf-8?B?eTkxbkg3dEtrSTBpNDBTb3BIYU5yRVhpMjBmb1o1dHFFMjh4K2xKU1RwSi81?=
 =?utf-8?B?OEpZY2tLOUlSdGNHQ2tMSnV3aHVDVEhPWjB5RnY1UER5a2M5dG9ZS3RRMlAx?=
 =?utf-8?B?RENBUHp1QjZJeWJ0ZURaYTBIQ0oxSC9UcUNKSUl1aldVdzB2Rlo0N2Rhd2c1?=
 =?utf-8?B?L3pVSDVBdS9BUHB0RkhzVHhYTzJKRVZ0Y1F6aExlbWcraXBOblg4R216ZGdj?=
 =?utf-8?B?ellCNE5Zb0RXaHpTTk9MdUsyTi80dHU5K1JoV08zNFNNTElWTnBKQ0tXVlVK?=
 =?utf-8?B?ajNXRnYyZEZsWC9zTzB6Nno3SVVYeTdiQkpydDdJN20xYWxlYThCYjlSbUEw?=
 =?utf-8?B?eU9kSjhTVVZmcjlTQ21GTCs5bUpuTGNqMjBab04xdjNBM1VBS0pteU42bUNZ?=
 =?utf-8?B?dk9odWdsbDFZbElpRUNyM1JTeHV5Yi9BRWl6V1JrUWM3SWhzb28yMm9pSWxa?=
 =?utf-8?B?R2lHWS90VDVtT1JPZnZhYmpvYTE2a1ZCejNiZHp6VUU1ODJ5aWRiZEEwY0ZG?=
 =?utf-8?B?RDBSWm5RdVVoQkZaTG9TVC9wVHVyNld1KzQxS0pkVk9aWTU2ZVh6UVloU3Ra?=
 =?utf-8?B?OUlVeTgrVkZMVUo1Vmt2aGNUckNlck5zNEN3U1U2MFU3MHF2cCtoT01UaGJk?=
 =?utf-8?B?TmJCV0ROTkJKdk9HYU8xRzY1ZEJaQWp4RHI4ajJYQzFNT2lkcThFWEYwME5D?=
 =?utf-8?B?RkZvcU9VNC9mVHJPMjBDQzE0c0VneXBLZmdXZTcraHJOczhRTms5eFlQTHJ0?=
 =?utf-8?B?OVdhbjVhV2VoK1Rhb0ZFL3BTem1XczlXYUh4WDJtQW1LM3pPU0QwbXBQamtO?=
 =?utf-8?B?WHl4RHNXaVc0WEJIZVBHZ2hVZVZNb2JIVHNwcTBveVF3SDcwTTJMdkNqeDkz?=
 =?utf-8?B?SlgvN1QzdzhlbmZadFBSSkRFbmZqSVZLdGRYS0lPV005NldISDdjK2l2Tmsz?=
 =?utf-8?B?UjI4YTNOTkoyQXNTc2ZSZms4QmF6MzVvNlBCcWIxdDRVTU9rVmdoQ2thdHhm?=
 =?utf-8?B?VnpxRDVnUFYrZndXcm16TU5rYVBHVWUyenIwREFLbXYvVi9hZmp0ZkJlTUJm?=
 =?utf-8?B?d3BXNEVVR3BvL2F2WmEybllBTTdpd1cyejN5blRhMUs4Ui9VU3VLNW1UZUpl?=
 =?utf-8?B?KzUwZmpKMGdJUE9XbjAyVGp0a3ljQ0luT3U1WWdsM0kwWm5QWnlSOTFsVVUr?=
 =?utf-8?B?VDVKVnlleVV5Sm1nTmtMTjV5b2ZwTjRvZzNRUEdKZlFXcVpRaFRwR3c0U1BF?=
 =?utf-8?B?R1gxcnJQa0Q2SGFnMlNWRzdvUlErTzdXTkgxaEtaN0JDVktjMFBHOXBEejF0?=
 =?utf-8?B?ODZNdnNjNXNsd2NMYUNzclZ6T2QvSmFGajFFSk95VUtjUXUyQnZvcEZDLzNH?=
 =?utf-8?Q?PBl2IYYwr34EkasEcAyl/gNW9?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12b5b695-6777-49b9-722b-08dcd469d774
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Sep 2024 03:03:43.1136
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hyqIDymqgZoqlh6ImFUkYTwCfDMQHTQNlScg4SGZn61pngrel9QzNke6gqDr79S33krHBvVp5sUifckI6xmotQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7290
X-OriginatorOrg: intel.com

DQo+IE9uIFNlcCAxNCwgMjAyNCwgYXQgMDk6MDgsIEJhb2x1IEx1IDxiYW9sdS5sdUBsaW51eC5p
bnRlbC5jb20+IHdyb3RlOg0KPiANCj4g77u/T24gOS8xMy8yNCA4OjIxIFBNLCBZaSBMaXUgd3Jv
dGU6DQo+Pj4gT24gMjAyNC85LzEzIDA5OjQyLCBCYW9sdSBMdSB3cm90ZToNCj4+PiBPbiA5LzEy
LzI0IDk6MDQgUE0sIFlpIExpdSB3cm90ZToNCj4+Pj4gQEAgLTQzMjUsMjQgKzQzNjMsMTggQEAg
c3RhdGljIGludCBpbnRlbF9pb21tdV9zZXRfZGV2X3Bhc2lkKHN0cnVjdCBpb21tdV9kb21haW4g
KmRvbWFpbiwNCj4+Pj4gICAgICAgICAgIHJldCA9IGludGVsX3Bhc2lkX3NldHVwX3NlY29uZF9s
ZXZlbChpb21tdSwgZG1hcl9kb21haW4sDQo+Pj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBkZXYsIHBhc2lkKTsNCj4+Pj4gICAgICAgaWYgKHJldCkNCj4+Pj4gLSAgICAgICAgZ290
byBvdXRfdW5hc3NpZ25fdGFnOw0KPj4+PiArICAgICAgICBnb3RvIG91dF91bmRvX2Rldl9wYXNp
ZDsNCj4+Pj4gLSAgICBkZXZfcGFzaWQtPmRldiA9IGRldjsNCj4+Pj4gLSAgICBkZXZfcGFzaWQt
PnBhc2lkID0gcGFzaWQ7DQo+Pj4+IC0gICAgc3Bpbl9sb2NrX2lycXNhdmUoJmRtYXJfZG9tYWlu
LT5sb2NrLCBmbGFncyk7DQo+Pj4+IC0gICAgbGlzdF9hZGQoJmRldl9wYXNpZC0+bGlua19kb21h
aW4sICZkbWFyX2RvbWFpbi0+ZGV2X3Bhc2lkcyk7DQo+Pj4+IC0gICAgc3Bpbl91bmxvY2tfaXJx
cmVzdG9yZSgmZG1hcl9kb21haW4tPmxvY2ssIGZsYWdzKTsNCj4+Pj4gKyAgICBpZiAob2xkKQ0K
Pj4+PiArICAgICAgICBkb21haW5fcmVtb3ZlX2Rldl9wYXNpZChvbGQsIGRldiwgcGFzaWQpOw0K
Pj4+PiAgICAgICBpZiAoZG9tYWluLT50eXBlICYgX19JT01NVV9ET01BSU5fUEFHSU5HKQ0KPj4+
PiAgICAgICAgICAgaW50ZWxfaW9tbXVfZGVidWdmc19jcmVhdGVfZGV2X3Bhc2lkKGRldl9wYXNp
ZCk7DQo+Pj4+ICAgICAgIHJldHVybiAwOw0KPj4+PiAtb3V0X3VuYXNzaWduX3RhZzoNCj4+Pj4g
LSAgICBjYWNoZV90YWdfdW5hc3NpZ25fZG9tYWluKGRtYXJfZG9tYWluLCBkZXYsIHBhc2lkKTsN
Cj4+Pj4gLW91dF9kZXRhY2hfaW9tbXU6DQo+Pj4+IC0gICAgZG9tYWluX2RldGFjaF9pb21tdShk
bWFyX2RvbWFpbiwgaW9tbXUpOw0KPj4+PiAtb3V0X2ZyZWU6DQo+Pj4+IC0gICAga2ZyZWUoZGV2
X3Bhc2lkKTsNCj4+Pj4gKw0KPj4+PiArb3V0X3VuZG9fZGV2X3Bhc2lkOg0KPj4+PiArICAgIGRv
bWFpbl9yZW1vdmVfZGV2X3Bhc2lkKGRvbWFpbiwgZGV2LCBwYXNpZCk7DQo+Pj4+ICAgICAgIHJl
dHVybiByZXQ7DQo+Pj4+ICAgfQ0KPj4+IA0KPj4+IERvIHlvdSBuZWVkIHRvIHJlLWluc3RhbGwg
dGhlIG9sZCBkb21haW4gdG8gdGhlIHBhc2lkIGVudHJ5IGluIHRoZQ0KPj4+IGZhaWx1cmUgcGF0
aD8NCj4+IHllcywgYnV0IG5vLiBUaGUgb2xkIGRvbWFpbiBpcyBzdGlsbCBpbnN0YWxsZWQgaW4g
dGhlIHBhc2lkIGVudHJ5DQo+PiB3aGVuIHRoZSBmYWlsdXJlIGhhcHBlbmVkLiA6KQ0KPiANCj4g
SSBhbSBhZnJhaWQgbm90LiBUaGUgb2xkIGRvbWFpbiBoYXMgYWxyZWFkeSBiZWVuIGNsZWFuZWQg
dXAgYnkNCj4gaW50ZWxfcGFzaWRfdGVhcl9kb3duX2VudHJ5KCkuIE9yIG5vdD8NCg0Kb29wcywg
eWVzLiBUaGUgdGVhciBkb3duIHdhcyBsaWZ0ZWQgdG8gdGhpcyBmdW5jdGlvbiBub3cgaW5zdGVh
ZCBvZiBpbiB0aGUgc2V0dXAgaGVscGVycy4gSSBtYXkgbW92ZSB0aGVtIGJhY2sgdG8gdGhlIHNl
dHVwIGhlbHBlcnMganVzdCBsaWtlIHYxIGRvZXMuDQoNCkdvb2QgY2F0Y2ghDQoNClJlZ2FyZHMs
DQpZaSBMaXU=

