Return-Path: <linux-kselftest+bounces-17716-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B143C974B17
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Sep 2024 09:18:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5EB51C23DC2
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Sep 2024 07:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9234156742;
	Wed, 11 Sep 2024 07:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gv37HsTT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0235F82876;
	Wed, 11 Sep 2024 07:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726039100; cv=fail; b=kZ5cHEdT+wpzjFFjGKv55SmINQPO2VH7Kp1uLvnxYgMVFKMmfBIrTW3Dma6vd6AEHt+buf7xXHLj8VCniR1JxY33Y6rMHT/n2f34eK7yZp9aWzaRuvGHHBP4u4ps22Id3fIa8M59DO7yv/TO4M1LDYJdYkw5jVSm341e6qMP020=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726039100; c=relaxed/simple;
	bh=wPVV86Wz/A/wTu9rO0VFf3ZI7/O6jy2iVj5U8c5ddOg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HjiKShx8p3m647ZOOcoOLh/+/eT+F5aD5TbNEszBCE7G1/fMnFXkajpJVcRI8+RTsgdvLMjhSoDtYNcfdhIybyZBak6bzHF5YX86et03pt5bjYQ6fPoUZxMIwohhGzztTqp5hwjr2xoc+LA7L5c8ZO3aRiL/j5/+0zSmiyGg9bc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gv37HsTT; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726039100; x=1757575100;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=wPVV86Wz/A/wTu9rO0VFf3ZI7/O6jy2iVj5U8c5ddOg=;
  b=gv37HsTT+TWViOie4nz2NSBzfmsfaB5xwchqtq+5uuaGVCMFQ2q2n+AA
   MIJivsDgFizBUhDSuPGsMd5AvGYktZXnoJX1z7q8fbL4F0NvgIzrq3HXf
   cd3Fc+xDIwGnDnhpEV61CEtBCZxK9N57qnIu8NYRnK4BRnfYTyZbcm1JG
   YeLhe5hv3grpWtArVH8buTvoz1uheXplADHApN4MlJGlOLbIo5X465qbs
   ILFzD6zknu4gRCzKq/xoioQbw/mjhYXXslMJCJCVN9BaFeHfCY72l//8C
   1aBx/Ds8YT3uBFWhocuXCKrAZ7fJkuL1bfJMT9fe8ueoOCektAU+7CIU7
   g==;
X-CSE-ConnectionGUID: O5STiWXTQYm1EjN45koLmA==
X-CSE-MsgGUID: SGdmx6EXQQyCFWjB1i0aLQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11191"; a="24643893"
X-IronPort-AV: E=Sophos;i="6.10,219,1719903600"; 
   d="scan'208";a="24643893"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2024 00:18:16 -0700
X-CSE-ConnectionGUID: +UAGC98gSHqLslA10PmIXw==
X-CSE-MsgGUID: 0eM4gJhgSPquL+ejVCGQTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,219,1719903600"; 
   d="scan'208";a="67298759"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Sep 2024 00:18:15 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 11 Sep 2024 00:18:14 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 11 Sep 2024 00:18:14 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 11 Sep 2024 00:18:14 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.42) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 11 Sep 2024 00:18:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rElZkrCF+u8DN1rIW2Fq2vYj/zPf0QuZcvt4bm7HSqbVY1GyapOnOiAhjIA5zWq0NfPvly3Yr/ughe98pywG91fOSIoyOe3Zr+z1H8xtqQUCoqA+rVRuGWW+vZbFlCYATUb/omdvOFEuK2CfRblwzCrPbo5J1pIUcinmu5tePXyyqO6ra6BQxGryeOg2k2UsawW9D8dlkytmKBwhVdN4BFD2YLaMCNLzCCJYZl7FWdnE6+uEdQY9xaO1WEu/I6+Nm2bWPMmJWg2+uni5+lF4D2aZ/nsiDYVh/RS7SMa41A6BDQ3TLxi8jOoDvMRf1Yq83na7XEcxoiDzQCkLCU2gFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wPVV86Wz/A/wTu9rO0VFf3ZI7/O6jy2iVj5U8c5ddOg=;
 b=rBOYBsk/R0x2aOi8UHwYovOf1z6b5d8cTnDboAFYcjlDEhcW7mfR4JxyUDvrZwKBx6sCMzVH55DotB8tlYezqBfc2J6VETPP6hrexKXnTsUqnGnP0qJTi1D7M+c/ytsBiS6S7rAV51o3F1s04xCYAhaUm+54BXRHY8DPdz2NEI9dzAqep1a7TCSNJSNjD3e8RmMqiclWBTJCfpU9+wBzgzwjFejzEENJGB+aC9FbwRznJpuRO60kPgbyvTvg2Gd401ASAJ8lKdAtlVdp7Dh+KV+TGhOJoHmHlQyeu1sd2X+o9afLyrFGohLlGizJYyqD/Weh5ChcxxKbtQdJrQLfHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by PH8PR11MB6681.namprd11.prod.outlook.com (2603:10b6:510:1c4::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.22; Wed, 11 Sep
 2024 07:18:11 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%5]) with mapi id 15.20.7962.016; Wed, 11 Sep 2024
 07:18:10 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Nicolin Chen <nicolinc@nvidia.com>
CC: "jgg@nvidia.com" <jgg@nvidia.com>, "will@kernel.org" <will@kernel.org>,
	"joro@8bytes.org" <joro@8bytes.org>, "suravee.suthikulpanit@amd.com"
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
	<smostafa@google.com>, "Liu, Yi L" <yi.l.liu@intel.com>
Subject: RE: [PATCH v2 00/19] iommufd: Add VIOMMU infrastructure (Part-1)
Thread-Topic: [PATCH v2 00/19] iommufd: Add VIOMMU infrastructure (Part-1)
Thread-Index: AQHa+KLdGUnDM+C8EEu4QYu86AlEobJSMNBggAAQmYCAAAEN4A==
Date: Wed, 11 Sep 2024 07:18:10 +0000
Message-ID: <BN9PR11MB5276554A016C2A54C41C64808C9B2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1724776335.git.nicolinc@nvidia.com>
 <BL1PR11MB5271EF54689B9666360A0F188C9B2@BL1PR11MB5271.namprd11.prod.outlook.com>
 <ZuFB06X7ZTg6ZhWT@nvidia.com>
In-Reply-To: <ZuFB06X7ZTg6ZhWT@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|PH8PR11MB6681:EE_
x-ms-office365-filtering-correlation-id: c9139335-f9b9-4f24-41b1-08dcd231e48c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?r+yoPdBg9rsuxfS4oN8kj96YuOqgKBeKCMCvUEMxGHDuTL10S8eNG4PJg5Op?=
 =?us-ascii?Q?fHEdCgj38ZAcKaTO1ZgzKd605CwLnR/RpBy315VOHpGCh1pkUxnSvIyym8l9?=
 =?us-ascii?Q?n8eh/HEU1AiOh9/jpmvMsiIY8eEjj4cD/rh7wF7Uep6DtLk4S5kudf47Dj9p?=
 =?us-ascii?Q?X5SOdTrnAxgJlnABcCjunWXpX2v2oXJducSMmWERaBXM4i16ogopeDicDVQp?=
 =?us-ascii?Q?y1ceJSItTbKGUtF2avx/P7wpsGxBG7KHKq9KmTVKDQKmYZ0qqkjfs3K/9rRY?=
 =?us-ascii?Q?vMvc+Jy+fyRKesF3dvrYXWHv1gEku9LrtS45cROWXknwe9Xq8sPvJOPb5Dax?=
 =?us-ascii?Q?dbW4MbidtezKDrBoLe3GfI5p4zoYPY74wX5BevA0cSWMATOoK/iEf0Jq/MtW?=
 =?us-ascii?Q?XQnrWNZWUO0TqZv6JNNvFknyjEf4qyZXPgU4Q9+w1MzZ4ASFsh3tQvWBEska?=
 =?us-ascii?Q?vmpDtmAXoJzWynF8VGTsWaMjZNYfWOHyWnoLgAV42lpcsaJSaWLV5mXo0cFs?=
 =?us-ascii?Q?TgnwhCawzUJa5NRle6mIrnZSlToGPdwmtf2LbHd2xfc2W7HoVY/xP63gWzHD?=
 =?us-ascii?Q?AcoBwSEVfxivHozuLCfqjqE/aKl6eC9aRM2FRlqYRYEmroLjojrDEdkcI11+?=
 =?us-ascii?Q?8fhMBtSmftrMAWVaqEGlIkbjNyBod9fPTveQX72B6kKrADpSY/oZ9YQYc3/T?=
 =?us-ascii?Q?1l0+7IEQXWssWgxsVoCPLaFRcXoesUOzWZzzl/y7ja5UcVbp4ZLiACOpmo9F?=
 =?us-ascii?Q?tzhdm0sVjQL32qiaFZ90CIs5RWoF+TrB/oSb4qx+06u9UwhVHlG8D0XQh62k?=
 =?us-ascii?Q?hZU0d2ADXxLyAiROwDk131AvGLii3Fg0089RvKxoBhkOCEMbZs2YfdHopf+R?=
 =?us-ascii?Q?1csZ6wmCPEH2ivEG7C8fCqphvWSkeXQ2/3tszcW3Tecrwe0OGwXy+Iws4I9/?=
 =?us-ascii?Q?6JNQK4dYKWhoGQ6pXETycgvh5UoiNqre5OolanAnVtdBzeGcp3FySu6rLhaI?=
 =?us-ascii?Q?Qy5cyn31VT7vcC+Xtseg9m/D1uNG4NdryHo8KIioBT7hiTN1FKqh2zTt7YUf?=
 =?us-ascii?Q?kkGO1SWwWi7rbctMYBFbj0vqFZ3vV3+rqmBtS95bVqara9FKVe/8LDrJOB27?=
 =?us-ascii?Q?sxvVkX8SO4SVaa7Flg4HRNiuUt81meReFpAswFbuZ6aHhnEdF18ryesMnm9/?=
 =?us-ascii?Q?SvOGJenbLGhD/MunU5QgmHGYM7wgyc8SCL47HkL168gAX2hOfMHg1t7UnIlE?=
 =?us-ascii?Q?FIMR9aU8VlmpyAt5wJBrmK3qAGfRhk3H1zRCBKwMmK0Eh+WnPwvY+13tDFTY?=
 =?us-ascii?Q?xcJMbWTNxGWXjv+G0f3iyLQviSe3FIuaEX5ZiB/FJTZbcoyG4G97IvOeVD2S?=
 =?us-ascii?Q?mykWgw3X2Jgi22sEq6nh/qOhdh0GweV+VCCLZz/qtYVvHbuw1g=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?0jai50UDtxuMs1DYOdXtFwKf8pBmNSc6SyDH1ZgMQMfCYdErY9kgkUfz2XiM?=
 =?us-ascii?Q?xgMr06ZrOGkxBgT0YPhhofLtAD/E8YWbYn9OkHVDaeAYofVynCaeefrgw9Pm?=
 =?us-ascii?Q?gD+RPksMyJmEf4fJTqxwMs3Z1xodB94ODHj3xDsiqCgqHU4nZXc1VXsQBgtm?=
 =?us-ascii?Q?+WP6hk59Dw5V6kBd+h0bKdjduwNrkNF6aDigPPicmbV2kjZG7A8RrUEbAsbG?=
 =?us-ascii?Q?1cXtEhVF4Iia9620/kPRRKSu7sjXLcZWl9Di2T3zrByXy9+FJQgtpo/oqleZ?=
 =?us-ascii?Q?ogsLbfr2gNiCKHJN/WkSlMqVbipQJiwBC+DwU0pV4WjxnEV+kIL19QvzgPQi?=
 =?us-ascii?Q?uAP0QeaShF97XDuw2w9lakLtPtXAZMk/ETMYk89Dm6hkCARNli0Spqt4xzzE?=
 =?us-ascii?Q?/v9uOoY4IexZ60IDZn31H0HYM736KqHCYLP/DNMqHpaRE/2nkGumqyc6A9K5?=
 =?us-ascii?Q?uC5uKUQjQdqpnmqdD25lz96S86KMA0ZOQAADAg1CzqoWy9ebrV26/FCAsbFw?=
 =?us-ascii?Q?x794KHrBLsuCra/ynRyZ5mi5xSbprYk7CH+Dl7xR1b/MGdP47ZykwEgI6v0b?=
 =?us-ascii?Q?7KpWLn/leQiSx1js+SC7TqpoSprUFjAWUPpzbAl7IjLAaH22g8srzlBT4cl0?=
 =?us-ascii?Q?I5PcCYT4TODLJsVnZuQW+iWaaeonWlbo38lvmEW5ItBct9HNseJC0zsIMvLu?=
 =?us-ascii?Q?0U+1tiO5JNhSIZUpPJvECPHFpxH6wrlv5RSGynJj1bOCWNWCR+9uYdZ6320l?=
 =?us-ascii?Q?cyXws6pLFEkROONGRJlOx6/DqiHU38Y7j0VIPFzvNykZoMl7iNERmXsjpaxc?=
 =?us-ascii?Q?+UAyB2PWh5p6j6l3URTMmoiHDbPXrDRsOj8rehGCbAzrcYDDBdTq31KzXPmH?=
 =?us-ascii?Q?+aiTtli3GWJlRUx4oAPxqZdLxO3T20LoUkvoG39M9h788CI9HAV1bVffCITn?=
 =?us-ascii?Q?gaqKkf8dR2yfB+LZ4Zbuh2i1WM4hcHteAJtypYV02D8sVNRiI5nqR1UjOfOe?=
 =?us-ascii?Q?0xBe5DbzBd3g95xEATdnAYjCqwZCSXCz7gFIpZB8KC3SMZaqLtyGQIvrwfwa?=
 =?us-ascii?Q?ghEKyhAADFP+X3oikttFDZFGcv0aAnmtME43WkHqF00GSE6joJ0rMyN3Kzo1?=
 =?us-ascii?Q?Vfi9ipKDBfohXBkSHgOqPXeRtnuevHjvo00yogE2YsL6znE9QAWzJt9BtsXe?=
 =?us-ascii?Q?ZSJNHDtLiMI9UR6fnaRyfE5P4jGnDVRwah+jdlfO39xi2ebNW4/pF3knz26l?=
 =?us-ascii?Q?2W6OaMfBOqJI/bsBqgLFuhWRS4++iGNg0Yr2zvM9nf8O/B6hbJF33yQljlcz?=
 =?us-ascii?Q?7elOOCRIMvSMk+3CFn1VdsrFB/76L4KT1ueP3pLYs6RaskccpaAnbO7MpFTI?=
 =?us-ascii?Q?XYN8atgXw7GTLNwsiFORjLLlyX+gjxhDOZO5PH2e1Uu2u+cXOomeeXd7FtZd?=
 =?us-ascii?Q?W7UEeNpgMQ2ieoedhN2wbQobtdq2PI/fprsTnO11LU3zHi7Akdoo4fqfWKzZ?=
 =?us-ascii?Q?aavDNyrltc9z+N8yvXYi4SKMfDykxYaLeJli4WUmcN1/f3pQoUJ8ajdp+PpN?=
 =?us-ascii?Q?0f5CugApcaqf3+EGt/d/HaqZY/SEOK8RW2WfLB9S?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9139335-f9b9-4f24-41b1-08dcd231e48c
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2024 07:18:10.8839
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p1YoYzabeCpKlbg8WWV2681o98Rg1VwTdm8STguBtKVEeLNHTR6bCdEQrz92M7Kxc/Hef7v9zpbP8BR/HDHzag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6681
X-OriginatorOrg: intel.com

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Wednesday, September 11, 2024 3:08 PM
>=20
> On Wed, Sep 11, 2024 at 06:12:21AM +0000, Tian, Kevin wrote:
> > > From: Nicolin Chen <nicolinc@nvidia.com>
> > > Sent: Wednesday, August 28, 2024 1:00 AM
> > >
> > [...]
> > > On a multi-IOMMU system, the VIOMMU object can be instanced to the
> > > number
> > > of vIOMMUs in a guest VM, while holding the same parent HWPT to
> share
> > > the
> >
> > Is there restriction that multiple vIOMMU objects can be only created
> > on a multi-IOMMU system?
>=20
> I think it should be generally restricted to the number of pIOMMUs,
> although likely (not 100% sure) we could do multiple vIOMMUs on a
> single-pIOMMU system. Any reason for doing that?

No idea. But if you stated so then there will be code to enforce it e.g.
failing the attempt to create a vIOMMU object on a pIOMMU to which
another vIOMMU object is already linked?

>=20
> > > stage-2 IO pagetable. Each VIOMMU then just need to only allocate its
> own
> > > VMID to attach the shared stage-2 IO pagetable to the physical IOMMU:
> >
> > this reads like 'VMID' is a virtual ID allocated by vIOMMU. But from th=
e
> > entire context it actually means the physical 'VMID' allocated on the
> > associated physical IOMMU, correct?
>=20
> Quoting Jason's narratives, a VMID is a "Security namespace for
> guest owned ID". The allocation, using SMMU as an example, should

the VMID alone is not a namespace. It's one ID to tag another namespace.

> be a part of vIOMMU instance allocation in the host SMMU driver.
> Then, this VMID will be used to mark the cache tags. So, it is
> still a software allocated ID, while HW would use it too.
>=20

VMIDs are physical resource belonging to the host SMMU driver.

but I got your original point that it's each vIOMMU gets an unique VMID
from the host SMMU driver, not exactly that each vIOMMU maintains
its own VMID namespace. that'd be a different concept.

