Return-Path: <linux-kselftest+bounces-20619-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E7669AFD04
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Oct 2024 10:47:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 591951C2247E
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Oct 2024 08:47:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C9D11D2B13;
	Fri, 25 Oct 2024 08:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l5r7bZM/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C8E322B666;
	Fri, 25 Oct 2024 08:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729846067; cv=fail; b=PQBQ7AVKfv/rnaFwpA0NMCDy3nb9aQKUq+tZXyiTTpvelBG0cy7RWosfIc+yLDpV0MvbU3MrdfEUbOtau4tP/YPr6AxGyiFLpiVSGSsfqWYdxQfibGPqtkZyDUzUasUBem7m0yx82YJeDWTL0TSNCxoEExWAh1GVNVsGYLnOANk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729846067; c=relaxed/simple;
	bh=YdcnHMDrYhz63kn3WJrf1Q1N8FuTSdoZZZXsKjNCtFQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Y8xDX5ht2MaJnLfiRNPDrQiMNWXoQO9JQA3L3Bp2AtcR2KJEBw1MMpyepueV+GCwC2wFM7PBTAadbofi3qEYAOnC2gQHHglsCyZYBX0Avs3Td/irNTjLNalyIGQYRexOreyauNOx0FWtFR46A8qCJzRoi0AmoV8Dn4fr4cZweeo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l5r7bZM/; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729846065; x=1761382065;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=YdcnHMDrYhz63kn3WJrf1Q1N8FuTSdoZZZXsKjNCtFQ=;
  b=l5r7bZM/TyP5M9HZpMzFGJB5M2uvNccDQZcrjeXj50VmzQXKMgjang9D
   7izQncQ7PPsYCf0ZwRc2EHweFig4HvA9EF34S7T18KCj5spLsVXTQ2n5J
   vPn3HShCbIQtYgeBJ/r6A3jMsgKBnSLGZLSWRu5KaYYZhVlAZiz/LXcVd
   +scnquVyySReYpRmIB23RHHqoqbAdPD8GoNx3Fuygep7toCr7//CemF2e
   tvHHTBwIo7gBUgzIkuwqv77A4WZYgln9kodHTUJcrYR5/YLyHJ41yNfpO
   IoXbnCBJKk+3urOpflEKqYLegrwkOgnWxrWApwD19tHUZJYDcsHa4W3Bi
   A==;
X-CSE-ConnectionGUID: VUoDUolLT7i/PTW0VSOk2A==
X-CSE-MsgGUID: 8Y/epmMjQZSOrWi3IL3x6A==
X-IronPort-AV: E=McAfee;i="6700,10204,11235"; a="17140393"
X-IronPort-AV: E=Sophos;i="6.11,231,1725346800"; 
   d="scan'208";a="17140393"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2024 01:47:44 -0700
X-CSE-ConnectionGUID: 1uVrRbdERzyEBms8dJ21EQ==
X-CSE-MsgGUID: ofThDch/StSgLuz8vSdn7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,231,1725346800"; 
   d="scan'208";a="111670887"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Oct 2024 01:47:44 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 25 Oct 2024 01:47:43 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 25 Oct 2024 01:47:43 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 25 Oct 2024 01:47:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZH70u449lbiiJkkPbYzKG4AqgnnpmvTbTwbIOA26nqr76lf5aOdsRSXUnDiq8sSgYuiyBajxbqvjO5CYE3OCceeOmtIn5QeFqK4jUTVVJPVVeavmcurVpPyMPyR2YSzoebFNyxFNNr8R2j3/5MQXMbeJqPc4nA3hLO2gIpKwfThBqUdx25whJniAxuuy15RIWI0vEjuhDF0LPJOxzxyJDWcCkFRBKr3rhsQ/Kmvzd8BCWuv0CUwa9NQU1Q/RaHYvKJXe5VsuLdzY24SKB9gVo3v0ELYNLSEw0E+j2aeSGgfcZgF3kkkFzlMljFQTmuKNtCJKF1Fwh4onNCtkZqbYmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YdcnHMDrYhz63kn3WJrf1Q1N8FuTSdoZZZXsKjNCtFQ=;
 b=KbnosFF1C+vWNOqAGMgVRIpgvyfo7iLqEqYknO1azG2bG6E49O32JBsB8rP8ayjAvM/Or3pwtujTheO36Z5dq2l5NqCXlGSuwO1MecSmaGPCItwEkclz07vddwtPk+ELtexjXVFVA9dt58B46KALszy+JVJdTzV/VFLgkL/C2cu+qVwMRELGAuAPodny3NvPdBvVDhmKI3Wv7Ummy1yWMgI43KPMoHwHu/Sq/insNFzUDGUe/1PuVwuNiONq5shjPHFUCK1LbFFsdrWMXgZfTU3GLJJwMt2rJwGRzzzzZxgYudPKAsDfMZdBFvLVfJFTBgNfvM/Ul2SUGEzUoWekTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SA2PR11MB5210.namprd11.prod.outlook.com (2603:10b6:806:fa::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.22; Fri, 25 Oct
 2024 08:47:40 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%6]) with mapi id 15.20.8093.018; Fri, 25 Oct 2024
 08:47:40 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>, Baolu Lu <baolu.lu@linux.intel.com>
CC: Nicolin Chen <nicolinc@nvidia.com>, "will@kernel.org" <will@kernel.org>,
	"joro@8bytes.org" <joro@8bytes.org>, "suravee.suthikulpanit@amd.com"
	<suravee.suthikulpanit@amd.com>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>, "dwmw2@infradead.org" <dwmw2@infradead.org>,
	"shuah@kernel.org" <shuah@kernel.org>, "linux-kernel@vger.kernel.org"
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
Subject: RE: [PATCH v4 02/11] iommufd: Introduce IOMMUFD_OBJ_VIOMMU and its
 related struct
Thread-Topic: [PATCH v4 02/11] iommufd: Introduce IOMMUFD_OBJ_VIOMMU and its
 related struct
Thread-Index: AQHbJBg7FXDUaWdZv0ygWScRExsQ57KSC/kAgAAkxICAAEhfgIAAR78AgARpA/A=
Date: Fri, 25 Oct 2024 08:47:40 +0000
Message-ID: <BN9PR11MB527637A495A46F32F722FB9C8C4F2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1729553811.git.nicolinc@nvidia.com>
 <74fec8c38a7d568bd88beba9082b4a5a4bc2046f.1729553811.git.nicolinc@nvidia.com>
 <b2c75705-2998-4e51-90f4-00b8bab785f5@linux.intel.com>
 <ZxcspVGPBmABjUPu@nvidia.com>
 <dd7eb37f-13c6-4c6e-8adc-954ad9974b93@linux.intel.com>
 <20241022131554.GF13034@nvidia.com>
In-Reply-To: <20241022131554.GF13034@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SA2PR11MB5210:EE_
x-ms-office365-filtering-correlation-id: 779898db-806a-48c3-1fc0-08dcf4d1aef5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?cGxHQmYwSWZmemp3TWdDTUtramhyMXRWSnFKYS9RMUx3eUZFdTJqem1ja0Q2?=
 =?utf-8?B?UElMN1FXQk1pUWl3dkxkQTVZNXZYNkdvQkRLdnBpUFRESE0yZTVzSXBDWk52?=
 =?utf-8?B?NDJic00wZGpHUEFvbkVIMWV6VWFwUzJ3TlhmbFJuNDNNd2R0U2d0YzRFb1ZE?=
 =?utf-8?B?ZEVOSnNDQWJpdElzRlYwRkhNemhiWDljdDJzUDhaaU90SXc4MXJqRzU3K1Jl?=
 =?utf-8?B?aG5sQVczdC9PcDJhM05jYStSUGszQXR5VnlIM2JCRExuTk01aGVaMm9qVllE?=
 =?utf-8?B?ZzFuS0t6Sml5dk5iak5GekloTGY3VkxHaHlTc1YzWEF5NGNvdEFFeUVDbEdU?=
 =?utf-8?B?RTNiejhISi9GZmJKOG1SeHlHN1F5blZuUG00UVdPbmYyc2wraVhDa2Y1VHN2?=
 =?utf-8?B?TGZ5dmU3RyttYWhUQldFa3U2M0J5SG5BTHNPSnczYzVmdEFGMmNoMHRCcC9l?=
 =?utf-8?B?cDNKRnZSb3hJK2ZUVGZZbGRRV0JSTVMrMlJjeGRRQ0ZCQXRGU1Q1UVBwTDdH?=
 =?utf-8?B?OTlEN0MxM3o3WG5PUE1YZ0pwZU9CRGdaV1IrTUVTY1EzOUxBR1hwQUZXTGlW?=
 =?utf-8?B?Q3lvNEF0NmJMbDNWUWxqVkp6MHU4VGUwc3Z6TVlIUzNab1NRaHczOERNcVNQ?=
 =?utf-8?B?c1FzQjd3MjF6ZDZYMzN4RGltVkN0NjlDMHRkT0kvZ3VOckZXeUUrSGZKMU9L?=
 =?utf-8?B?UDNpcnRCUEdqSDBOQkZFOVE4enF6a0p1NUtwYjQ5VnNrT1AzS2g3OCtlSXZ1?=
 =?utf-8?B?VElrTWNWV1RFVnhJNlNUN2dmejZQOXVac3lSZW1nbm53VUFsNE93UVphc0Fm?=
 =?utf-8?B?bW05VHBaellTN29nK20wYURoKzJLQU4xd2w0TGhsRDZSdmtvVTEvT0xlbTI4?=
 =?utf-8?B?TkF5bkdyMVpTb3NHVVdUaHFpa3YzeWN4RzRodlRzWFRWay9rcG5BMHBEZm81?=
 =?utf-8?B?bmppMmJkNlRqOFpXYmtwU0VkY2FLUncvOHJDUWFLNzYvVXU5cFovM1pBclU1?=
 =?utf-8?B?SGw4Qm9XWlJPemJQREZzdHFyVVNsME9oSndEc08wS1QyT0dNQXp5NGJzTHMz?=
 =?utf-8?B?ODNwYVFCeGExK0sraDVoZ1hTTjFxSXRGZmxwMFRIbHdQSzVDc29mY2ova1dT?=
 =?utf-8?B?TTFHSVF3WUErUkpYM05IdUV3QTFBSTRrcHJmbXdiMDdKd3RNYm1TMjFqMVVS?=
 =?utf-8?B?VmRtK1BuRDh5NlhHTVZmdkxmNUFYanpINjVJZDM0a2RhekpEdTFtMG41Nlc4?=
 =?utf-8?B?cVZpRSt0QXJYMVNrYkV2cmo3M050MElpcEhHVFB6SDJCdHlOY3AvSEdIamZP?=
 =?utf-8?B?RCt0c3hoa2FkenNsSnhGcjFlSkRzcU96UTlHNkhkZy93UHpCU1BKR3dhb2E5?=
 =?utf-8?B?dU56Rmp1MC9GWWRGNDZ0dzdhVkhDS0x3a3h0S3ZOczhEOEg2VmF5bWE4b1Zh?=
 =?utf-8?B?Q2pDUkN4QmlUajEwV0ZpR2syTGl2N3dhbUVGVDB1S3VHajhTajRBYnZvRS9I?=
 =?utf-8?B?dU5VYWw4NGw4c01RM0NYdVpSVWY0MElTYmh6YXhlTEF3U1ZramtrVm16L1hE?=
 =?utf-8?B?ZjBSS3ZDUExWWVY0RnVhMlJsME1RSnIvQU1kUmlkbVlWUllGcHhhNVg3dkIx?=
 =?utf-8?B?Y0tYWXNpY1VreDZRdnZGT201YVBGNjQ0cFd2Uk85cUFsamErdlRaMDExcE92?=
 =?utf-8?B?L013SmY5eHFNYngxY3l4YjBPbElrVFpWMXZ5dS8wNnBnRXRYZ3lQWnNKUnQ0?=
 =?utf-8?B?R3dDWWk2Q3V6Z3AvT2xKNDNGS0YxRTRya3VVbDdseUtvTTFuNTBVWDhaV2hD?=
 =?utf-8?Q?ZAaklfTyGEGteG15EpNtj1WNkhkYzfOD/NF80=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cHBBbUNDTkZRSmpEUU5IcTJpZy9yZXd5S0E0YWRsb2J0bEVER09uK3pDYmxF?=
 =?utf-8?B?c0QwQWRhSlpwcXVRalVXTERiRXI5enVUL3Z2MTI1SEd2bGdsTTFXYmptcEJQ?=
 =?utf-8?B?VXFjZ1RkV3lCbURvQjNkcENSc3pKclJtSmdESUdPcWtlT0VPbFFPdFJCY2xO?=
 =?utf-8?B?cXEzc0lFd0RrSy9VUE9JK1h0WndueVZrcDFDK0w3d3NXV2NGanY0R1VNSnRD?=
 =?utf-8?B?V3pPS2Z3Ky9KZXZlY3hYZEtGWkVTTDZEOWo5aDNOMks0Mko2dXYrb1A0bnZs?=
 =?utf-8?B?QjlQRW9rU1BMRGUyM1Uwa3lxa3VvcE1YdG96S1dySTc3SXJMcVVTTEJwQUhR?=
 =?utf-8?B?K0QrTjNKLzJBYkk0K08zSUxuR1RJTVFraU1MY3RMVkxKcFNreGdoTksvRWcz?=
 =?utf-8?B?cXo2OWFkOGNRWUxlTVYzbDludWpzUlhseWFFaytRWVVMZ2pyeXA2U0J0bUlD?=
 =?utf-8?B?TXZvdWFWZHN3alRXVGJMQU5STEk0eEFjUGJZU2Q1VDVKVHZzMFZlNzh6TmV3?=
 =?utf-8?B?Kzg1NE9aR2pFSm83U3pzMmgvTWxJcjJjSmhwUVh3bWcvcHBMbTZJbGRTSWFz?=
 =?utf-8?B?MEk0WS90TjNBcWJzVjhvU05HTjFXQ3c5bG0wTmQyNDFPaDhSMmNlRmZSRTVN?=
 =?utf-8?B?TnA5UWc3aXZNMUEvUVBsaEc1REl4TmdNYWY2Ny9pNG1MYlpxZSs1SHpDNnp4?=
 =?utf-8?B?ZTFweTlsSEV4MkpSU2NsQkY3UnFzRmduWXdWRTBTelZCckNLYnNSQkh1Sitx?=
 =?utf-8?B?aS9IVjZqZm5NN09oMmx4cGhhK281RjNSclVHQUlSU01BT0xjckhGaUkyc2ho?=
 =?utf-8?B?Z21vR205emRKcUJkelR4dlVxUkhUeG4xT0VhdmtlOVFpVFBURWF1ZXgzbENj?=
 =?utf-8?B?MnVNdTM2SmpRQVB5UDNiKzM1eDJUaUpJQUp1NGQ3NjcwNlhEa3d0UGx5eG5M?=
 =?utf-8?B?VFppOGQ5b2hlOXpLakV3ZmpZMTBHL3duTFNVaVRHd0RBcElRcyt5c2ZyNERR?=
 =?utf-8?B?c2pldEtNcmhrMS9VNWt1UnRnS2ZqVU4rY3lVaUJ5Mk44cDhtTnhGSWczV2Qy?=
 =?utf-8?B?bDV0RzRYQ1l0STRyOUpZQURKZjFBWWd1anVta1dHK0NBaXFJa3ZQSWhOYXh6?=
 =?utf-8?B?cE5zNEw2UWhGejFNc3lIUXZRUVhId0VUaitMNDI4SzdrN1VMMmFjZDZDcVRZ?=
 =?utf-8?B?RS8yaXdxZmFMb25RK3NFelRDL2s3T1Z0K01xUXpsdkNEYUtCTFlsOW4rNk9N?=
 =?utf-8?B?K1JLakdGbk1iTW1Da0hvZ1RSQzVJc1FLNzlOdGt0b2lpL3g5VGN5YTRkRTl4?=
 =?utf-8?B?Mm81cmkxUzIvNC92eHFWRFl5dHRPOWkwM1NrK1MvN0dzb1pYL3VaZEQ4WjFF?=
 =?utf-8?B?ZFZMSzBic3MxL3lGTThHR05WUitBbjBwSHlHUVNUalRyT2tmenBINXJiQUIx?=
 =?utf-8?B?MXRmdThMTmNJOG1rWDBlSmxRbWtSYThRK3JpNnpuNzZiTkZXQzRrQ0dJY2Vw?=
 =?utf-8?B?MzRkelZiM293R0VMaGlWUHNVTW1aQnB4MXZ0T0pYYytRdHo2YVVtUG4wUU9i?=
 =?utf-8?B?TmtueVNJTGp6NmFhNnBFN2hMcnFQbVFYblFmUUF3WitIUkJXbHZheUpRY2pW?=
 =?utf-8?B?TDZLR2NwNGZienU0eExzV1Avb0xjTHZVUzZWOWJ4VjlPQk5PTWRzSDJwWTFt?=
 =?utf-8?B?SDVxM0dXekZ1dTkrdFc0N21KZmR0Z1VqVHd4MmNlMm1ySjBCVnhEalFXbmhj?=
 =?utf-8?B?MjhCMVRCcWRuOHhPMHFlZnN0My85WlJ1clRYQlFtR29hcHpETzl4a2FjZjM0?=
 =?utf-8?B?ZTdYNE5DVlplYjJoRnBVbVZRcEpleDd5dGlkTVMvOXlnSXBOV2FXLzhpd3NY?=
 =?utf-8?B?eUFyaUFBa0gwVEwzR1NJQnpUUmNKRlZWaUIxbVBad0MvTi9iMVBZZFlSZEFj?=
 =?utf-8?B?OStNYTNMT3R5bnk5cjV5YmpjSzZzKzA3RVF6emFqTXg3eGE4b3NCVWJ5akdo?=
 =?utf-8?B?dUo3UFdTMENoYUllelZYU1VpR280WERXeFZ6aXpQUjR2VXA5UDBaZUhWM2Fh?=
 =?utf-8?B?d1hqTEpmeXlYQ1YyVmNCM2hyVHpwWWl4ZG5CSGZsVVFhbkNiZitvY1ljOVJ5?=
 =?utf-8?Q?Solero2/cNaxCZ2Cp3BUldNRt?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 779898db-806a-48c3-1fc0-08dcf4d1aef5
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2024 08:47:40.0227
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fokfyIUDDSCJGi2Edd06cbFq9uwbj6fBti3i9OacXNt1z6hCo7BeOHmYDbts3rIjCHmhrOP4zSPb7eMqG4kmLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5210
X-OriginatorOrg: intel.com

PiBGcm9tOiBKYXNvbiBHdW50aG9ycGUgPGpnZ0BudmlkaWEuY29tPg0KPiBTZW50OiBUdWVzZGF5
LCBPY3RvYmVyIDIyLCAyMDI0IDk6MTYgUE0NCj4gDQo+IE9uIFR1ZSwgT2N0IDIyLCAyMDI0IGF0
IDA0OjU5OjA3UE0gKzA4MDAsIEJhb2x1IEx1IHdyb3RlOg0KPiANCj4gPiBJcyBpdCBmZWFzaWJs
ZSB0byBtYWtlIHZJT01NVSBvYmplY3QgbW9yZSBnZW5lcmljLCByYXRoZXIgdGhhbiBzdHJpY3Rs
eQ0KPiA+IHR5aW5nIGl0IHRvIG5lc3RlZCB0cmFuc2xhdGlvbj8gRm9yIGV4YW1wbGUsIGEgbm9y
bWFsIHBhZ2luZyBkb21haW4gdGhhdA0KPiA+IHRyYW5zbGF0ZXMgZ1BBcyB0byBoUEFzIGNvdWxk
IGFsc28gaGF2ZSBhIHZJT01NVSBvYmplY3QgYXNzb2NpYXRlZCB3aXRoDQo+ID4gaXQuDQo+ID4N
Cj4gPiBXaGlsZSB3ZSBjYW4gb25seSBzdXBwb3J0IHZJT01NVSBvYmplY3QgYWxsb2NhdGlvbiB1
QVBJIGZvciBTMiBwYWdpbmcNCj4gPiBkb21haW5zIGluIHRoZSBjb250ZXh0IG9mIHRoaXMgc2Vy
aWVzLCB3ZSBjb3VsZCBjb25zaWRlciBsZWF2aW5nIHRoZQ0KPiA+IG9wdGlvbiBvcGVuIHRvIGFz
c29jaWF0ZSBhIHZJT01NVSBvYmplY3Qgd2l0aCBvdGhlciBub3JtYWwgcGFnaW5nDQo+ID4gZG9t
YWlucyB0aGF0IGFyZSBub3QgYSBuZXN0ZWQgcGFyZW50Pw0KPiANCj4gV2h5PyBUaGUgbmVzdGVk
IHBhcmVudCBmbGF2b3VyIG9mIHRoZSBkb21haW4gaXMgYmFzaWNhbGx5IGZyZWUgdG8NCj4gY3Jl
YXRlLCB3aGF0IHJlYXNvbiB3b3VsZCBiZSB0byBub3QgZG8gdGhhdD8NCj4gDQo+IElmIHRoZSBI
VyBkb2Vzbid0IHN1cHBvcnQgaXQsIHRoZW4gZG9lcyB0aGUgSFcgcmVhbGx5IG5lZWQvc3VwcG9y
dCBhDQo+IFZJT01NVT8NCj4gDQoNCk5vdyBpdCdzIGFncmVlZCB0byBidWlsZCB0cnVzdGVkIEkv
TyBvbiB0b3Agb2YgdGhpcyBuZXcgdklPTU1VIG9iamVjdC4NCmZvcm1hdC13aXNlIHByb2JhYmx5
IGl0J3MgZnJlZSB0byBhc3N1bWUgdGhhdCBuZXN0ZWQgcGFyZW50IGlzIHN1cHBvcnRlZA0Kb24g
YW55IG5ldyBwbGF0Zm9ybSB3aGljaCB3aWxsIHN1cHBvcnQgdHJ1c3RlZCBJL08uIEJ1dCBJJ20g
bm90IHN1cmUNCmFsbCB0aGUgY29uZGl0aW9ucyBhcm91bmQgYWxsb3dpbmcgbmVzdGVkIGFyZSBz
YW1lIGFzIGZvciB0cnVzdGVkIEkvTywNCmUuZy4gZm9yIEFSTSBuZXN0aW5nIGlzIGFsbG93ZWQg
b25seSBmb3IgQ0FOV0JTL1MyRldCLiBBcmUgdGhleQ0KYWx3YXlzIGd1YXJhbnRlZWQgaW4gdHJ1
c3RlZCBJL08gY29uZmlndXJhdGlvbj8NCg0KQmFvbHUgZGlkIHJhaXNlIGEgZ29vZCBvcGVuIHRv
IGNvbmZpcm0gZ2l2ZW4gaXQgd2lsbCBiZSB1c2VkIGJleW9uZA0KbmVzdGluZy4g8J+Yig0K

