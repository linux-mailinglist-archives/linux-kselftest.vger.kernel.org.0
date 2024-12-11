Return-Path: <linux-kselftest+bounces-23166-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A82A19EC6CB
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Dec 2024 09:16:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB2B9188A342
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Dec 2024 08:16:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B33E71D7985;
	Wed, 11 Dec 2024 08:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nHBGxx4M"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D33FE1C5F06;
	Wed, 11 Dec 2024 08:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733904961; cv=fail; b=ivFy0WdCV+1m5XkwiWfHjr+3w+zCf+YYXGlSz0GgUvW8nmD1l+CpD+SFo96oziV6tFyuf/B0f24zw7mpt0asP30aWi4I7JIY7qEBHsUNUzoLEhuB3s3f63axCu30btwOtA/nTbxP/vX9iN4qLADyQH+gEbD5/Leg78ccHUAwHac=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733904961; c=relaxed/simple;
	bh=BkaefTtwt5bGh2gW4IoolSUl2iO4oNRPSg91sywOT6k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nHQos2H7dSRL2bgkfTRBNU9Wwhiy3fclI3uTbQmknhl/pyZldljGFNcbs4+64hUBHylXsGGslYOiST1WVHVuH1YClbjg0F8kODOO4uVlDyLLLA+mjGm2tdbFV203MGa+aXZSbTOY+ufVtfjl3CHTNwJdZuWbUbeVp7luK7LPlJA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nHBGxx4M; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733904959; x=1765440959;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=BkaefTtwt5bGh2gW4IoolSUl2iO4oNRPSg91sywOT6k=;
  b=nHBGxx4MuerLn73dyVmllSVcetcHRKYvSSw1JZ9UzaOt5unMco1CovN3
   YKR10PY+yb0hABC4Q0CisZoC1kVAXZkDH0qjJVmjkB/PawZwWKKLtC8NT
   CtWO2TOGEBq53oZjeLpp+Nyc0t/9GV1P73fmt4Hgl31AyK3GVjXmzR4IE
   lmkDvKpFRm4H1QDrryJ1Yk9UK3dKOQtg1Nj/zoMAIQmq3z0KAluhLKqp0
   YmoqLCKt9MdEqX8A1CQAYuU/fBOLNclH58cuePsuDs2naG72ODm1utqpC
   uKWQKUUM7bPE1ijmc1CJsBXV89vYwprtdEK+K5O081A2OPAGMAiwkM9tH
   g==;
X-CSE-ConnectionGUID: 9Pv++WqLS1SFmkzwHPUt8w==
X-CSE-MsgGUID: W4lq9ZFGQyed3eeSQFXCLQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11282"; a="34414078"
X-IronPort-AV: E=Sophos;i="6.12,225,1728975600"; 
   d="scan'208";a="34414078"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2024 00:15:59 -0800
X-CSE-ConnectionGUID: 9mUTepg3T0+h0pp+AfBFtw==
X-CSE-MsgGUID: lea7YmXNT1eyETI91+TCGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,225,1728975600"; 
   d="scan'208";a="95573560"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Dec 2024 00:15:58 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 11 Dec 2024 00:15:57 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 11 Dec 2024 00:15:57 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 11 Dec 2024 00:15:56 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sZF0R6Decs6jNEahkH+9Ve9kNJdgbt28hx5v0R7nx3odoB1AX1hTIwhLUgxKo+CHwBsmIpgvdwxgex+sKb1v6KOYQNcJx6mTQS9s/MAbKok4plKUzxuG89VU80zfXrgoHI4HkZfcIPOvjQRu893gcodudz1o+ABsvPqMuBKaM7bQdFD52/SQtVm4LMMCH8NrXG86RAl1PRJqbHrnytEPvyMhPMNjVfy3hBIGDUNWBV9Yp70c3BLllQ0LJqBsmWFJvkNcTLmP8chMx4oOX53BqXbpk+1vFND/NtsPHwVzPEVBFxaT+EzRrpQAh+oc8Lzc2tYzVY5jHF45m1LbwFlVhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BkaefTtwt5bGh2gW4IoolSUl2iO4oNRPSg91sywOT6k=;
 b=Oih/o31ruzOQt4H5bHlDW9lhNG10XUvrkhfSCmK68+UZw3MLccRr+ydAxXzYrmlK8dN1wxq89fejF/rakyMRrRhXpUCcY4KFSv0ntYSFHTC1FlBb8hv2G7AvlcQvtO8KtZy6x4jM0RboebZX3j2mu093Q6elb2aXaS6MGZuzgPTRoTizQmnxwuBdZkD3lwqTu+1YQWoWeiqKiXD9e2DD3mlf/QvwLI8YHcXCin3AELACRda7AUX+uOApWUFZeMb2UEf48d7a1dmScHsriFkvMQqg0VJb12YB8mc0RzmCkVbDMaInh2pEIkpQQrlJUeb7OfgGmZzSAY8ZZtdgRxy/zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by PH0PR11MB7634.namprd11.prod.outlook.com (2603:10b6:510:28d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Wed, 11 Dec
 2024 08:15:36 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%5]) with mapi id 15.20.8251.008; Wed, 11 Dec 2024
 08:15:36 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Nicolin Chen <nicolinc@nvidia.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
	"will@kernel.org" <will@kernel.org>
CC: "corbet@lwn.net" <corbet@lwn.net>, "joro@8bytes.org" <joro@8bytes.org>,
	"suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>, "dwmw2@infradead.org"
	<dwmw2@infradead.org>, "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"shuah@kernel.org" <shuah@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
	"jean-philippe@linaro.org" <jean-philippe@linaro.org>, "mdf@kernel.org"
	<mdf@kernel.org>, "mshavit@google.com" <mshavit@google.com>,
	"shameerali.kolothum.thodi@huawei.com"
	<shameerali.kolothum.thodi@huawei.com>, "smostafa@google.com"
	<smostafa@google.com>, "ddutile@redhat.com" <ddutile@redhat.com>, "Liu, Yi L"
	<yi.l.liu@intel.com>
Subject: RE: [PATCH v2 12/13] iommu/arm-smmu-v3: Introduce struct
 arm_smmu_vmaster
Thread-Topic: [PATCH v2 12/13] iommu/arm-smmu-v3: Introduce struct
 arm_smmu_vmaster
Thread-Index: AQHbRdBWljBTs1DfXkWuxKfInVx12rLgvbgw
Date: Wed, 11 Dec 2024 08:15:35 +0000
Message-ID: <BN9PR11MB527669503B30B7C67907DE398C3E2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1733263737.git.nicolinc@nvidia.com>
 <6270c905fc8537ffc51f6f2ab2db0601c9f08a8d.1733263737.git.nicolinc@nvidia.com>
In-Reply-To: <6270c905fc8537ffc51f6f2ab2db0601c9f08a8d.1733263737.git.nicolinc@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|PH0PR11MB7634:EE_
x-ms-office365-filtering-correlation-id: 3d6c5b7f-6d92-4fbc-bd06-08dd19bbfd92
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?FaaASwtTOuwE8daQAOS6KcHnK/L5fwm+bjAB3AXTpUqbg17OSFh3Qu+QQpor?=
 =?us-ascii?Q?OmOHH2En7OEhgSf6sW3Hq623dqHixd3gTmS7PBZTffMlOZfEI2xgYRzj67GC?=
 =?us-ascii?Q?2sGJTVMBdaFhZTNPKhTR8H9F2jd/dGFFGJsZc+1EPyljZYpnUYbDjzrh9bnf?=
 =?us-ascii?Q?BZ5qtqeu5lNfvocqz0yuh0dbx0hEHRCj7cFgEDgs5Tlo50vMtwEzkY62FjrO?=
 =?us-ascii?Q?EMGh4NaTi+LHn9WrytX+BPtSswr+xiWcTaekMQmibSaHOe3djHjzD6x4DwEv?=
 =?us-ascii?Q?0m4z00xczshntFKoTvuqnd00u1lpFiwVlNv4gshcHP+3zqsjvXoz1tIxifzg?=
 =?us-ascii?Q?nRRGrpkpGRMHBZb1d7oRCPvxcaqn82zHLkW2lLxKwB0MxJjUS2FDqaL6Ss4Q?=
 =?us-ascii?Q?sMtX8isUKjGbpatTuD9osRs1wlDcgAddqzZskjOkDqrlLhgxq7Flt9mGAQj0?=
 =?us-ascii?Q?nyyolzHyRPidKKkW60grrQe1SmpBg8aiyMa94GPNz7NPI1VjRk44K1c82trZ?=
 =?us-ascii?Q?fVLD1LojWzghgRkI/i1/uLE5cjv12+NO5aeGwNBcEE5ukmVgLCOOJGTxnEug?=
 =?us-ascii?Q?Cleb3cgYMnZCIBmIZTGO8f4KqF/0ualSbJeMT+WYM8dbvQVdGTc0Fcus3NAi?=
 =?us-ascii?Q?jc0UiN25/LIsLEJ+8vMDRg8m5C0/IDukC3voGtEcu7CjARr8dvllLpm6ilNR?=
 =?us-ascii?Q?uIZVE6aJ/rjE+0iG0HUFJQfdfF1qVZzwlwVX5QYDMtYFNT7EVingENBHJNey?=
 =?us-ascii?Q?fpmMPxHud7k1zqGi0GL3m6R5bS/jFKl6JFtVtORg9JTTLFud7Ly8ahSsUy2d?=
 =?us-ascii?Q?Wbpd5tVlFQeRq7brp7FftJq1mD81ZuQAmxUsfSitr1jEppArEuANbEFJ6BzO?=
 =?us-ascii?Q?tsA3n6kw+eBim3g8jLaIYLeO5cAe1E7AiVaLy+ZvhjYctk7xPp6LFICfQCbT?=
 =?us-ascii?Q?4NDdsE69CFhAtrLfyqerlGDfPMCy+QWo4v/+HedA+AeIXthiEvB772PS8b3K?=
 =?us-ascii?Q?SXozPQ6SSdEtuELv9Zf4gTcGSeLEcrY6TrsZc71I3cNK1DOLPxkmI1InGN/6?=
 =?us-ascii?Q?k0PPZRa86Y0QrZcF/uIBqdAGM8SLKO6SVU6xXaWE6bBhMuKrtIwVRSror94m?=
 =?us-ascii?Q?phI02sSwhKWVf1j+67ktDtjJ7dvMInUllhPgwGppKydNlC7nn1MyyOXCsSEb?=
 =?us-ascii?Q?bPqzspgHWpm/mkprQ6TIT46P9OOYb5Cow6U5XrdrtjEDbh58BTpfbUYDRz9i?=
 =?us-ascii?Q?Eyvn2AtIZgYYwfWELuC5OH315zpRbZ+nKFDn7WjaBw+ROUt6aRfg56jIl+EA?=
 =?us-ascii?Q?UDWmLjAstO0oOmJnMDpOzUeaOMaQfrj618JzCGOfkd12ocLnfeeSlJipfepS?=
 =?us-ascii?Q?Sx8u2sr5fnOoQF8FgTF95jgxTn7Vctbvbndsqp/jDElrGXGpjA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?stPxFkvHah+rXFel9ysQ0jFFkqkis1Xvu/7LHME79J61/d5fLLnWC41s+WlF?=
 =?us-ascii?Q?VGKrHMwSGxlnpzFx3n47vWKj316VoFtuEjSX69xgrilowmqEL9VFWatM5cSK?=
 =?us-ascii?Q?3VVU6A+K19WUA6nAQ2gtgrNhn9asUBOQkf2xg470pYFv0oY7GvuxD2rHPMNx?=
 =?us-ascii?Q?UX/NPIJ/pfoqVkOCnuDDu4AViOAqBYGbr/l3eo9vNPrfB9BIo1YWzXUtDHwr?=
 =?us-ascii?Q?EEWZy9MmYSl9UbyQWQzB0aIhERd42rL5Gjk2PPu3+dFBG92HDtPpfyz7U76h?=
 =?us-ascii?Q?YKvw4JuXcJRz6YicGQb8yp4dBuADpGQiOne7q3w785VEeIwxT0koib3KPUv4?=
 =?us-ascii?Q?FbOI86G6TPrZNZ/mqbVKC0etP3VOcsZb9NRQbAU2MAeC3UkYvltfFOs3h+II?=
 =?us-ascii?Q?HtTQnO5fn/5vecy3d6hCAsofSooFuI8s6CRmrvpLHkrxZ51+zp8ygU+k2rLM?=
 =?us-ascii?Q?OACAfVnD5eOjOiNn1kmmZrGsxfQs25trw1GjQL5AUTC9XB+aN+QmYC1iMTcZ?=
 =?us-ascii?Q?jnRG5ws1EUFiOZH/HviixATEjs7bR+2YKYuXfhPFBu/lG02gpGJSOjXQrvlI?=
 =?us-ascii?Q?8xAAQC7v21MVlEyJSYuGzoW+Vlxm3Vei/U8t99FbUe4QWcW0c7dx5IV31DhY?=
 =?us-ascii?Q?hI45gBUQm73osd947Yi/yey+q+nUFZNCHGkPjHp3CXMraxl0KzSbHk08IZti?=
 =?us-ascii?Q?8E/S2U+jHv0ddGrIW9L4pDuKweo8SKfp3bT+5wNhlNig5Dn329CVc8Fj2iYz?=
 =?us-ascii?Q?OSgNRhcr6noyF9aiTeIACtcCGXqP/9Ie3FPdk6QjcJmmbPQnpN8cdQ7C3b0w?=
 =?us-ascii?Q?eG6Z/229BwDNzzZanzFqOb0WZTIb/M2uB7FxJB5MRwsBmjb0j2VSB33B5xJ+?=
 =?us-ascii?Q?HVn4B/oL/bIXr7//TZ34yn6qA534GyA3oTHTpWnNF73BVzwYlTg5DJtbmRK3?=
 =?us-ascii?Q?s3Od58dTFHldvcFU8yJo+vyA9m13+JzfTr7CrmIXklpj/fq6nPHfdgpWzRwV?=
 =?us-ascii?Q?yueIf9UtvGCZBlejLM85Oc1xbTf1IJ7XL2SFdA8cibRFcKMs/CXDlMFlAyKu?=
 =?us-ascii?Q?cMMduo1qgRXy230dRmE0IqbKKpOqR7ezjg7ybPMVDyoPelGeW5YvSPxD1Zmq?=
 =?us-ascii?Q?9nSh2rbBbV9ZOtkZFEm7p51Tkulx4DmDBDsGZPnQdgMK7UfQ0DQbFq0/BpLg?=
 =?us-ascii?Q?K4+SjrNZ7hNN841aFbugqEZGIJvye2RQOLbSFr1qaxMC64VOK9YqfWph84G2?=
 =?us-ascii?Q?PFWNX35Pk+gUfboMoCek5TUUdbH9TYvki7W/nhNsTtl6sxtZn417ump3GcGX?=
 =?us-ascii?Q?NRmVa9qr4j861bat+wC9zhp/J0nRzk7PGBbJ+OOBow/Ekc9XOTUM9s5AsAiE?=
 =?us-ascii?Q?YkmXnchPCW+TdIgvUo3+Ca10VXtQ1qpb73hZ56QA9K8UuTabuZ0pmNuDil00?=
 =?us-ascii?Q?U6rReGs0ZU5VHC0OWB/PkbQEuOqACUIJFO+/GaEK11VtirxxJedAMwlLB2d0?=
 =?us-ascii?Q?aW0037MDOZyev2z03zJe4yh4rkU070mxgGpXC2QzGorfZprOQM/G+StuIfdH?=
 =?us-ascii?Q?ZupjCdtsHneZNbvtByoiTyCvMk6mR7kOXN9z8Y/I?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d6c5b7f-6d92-4fbc-bd06-08dd19bbfd92
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2024 08:15:36.0021
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q7/yvl7k2heoEyvvhknYHzYZUyK3D36W0p7xAds/UhzEiRjbrXBg4MjAhVq5X6+6LiSfobfJ7G+1yBpI8xsa6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7634
X-OriginatorOrg: intel.com

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Wednesday, December 4, 2024 6:10 AM
>=20
> Use it to store all vSMMU-related data. The vsid (Virtual Stream ID) will
> be the first use case. Then, add a rw_semaphore to protect it.
>=20
> Also add a pair of arm_smmu_attach_prepare/commit_vmaster helpers and
> put
> them in the existing arm_smmu_attach_prepare/commit(). Note that identity
> and blocked ops don't call arm_smmu_attach_prepare/commit(), thus
> simply
> call the new helpers at the top.

Probably a dumb question. viommu is tied to a nested parent domain
which cannot be identity or blocked. Why do we need to change them
too?


