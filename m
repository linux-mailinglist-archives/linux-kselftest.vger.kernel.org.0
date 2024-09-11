Return-Path: <linux-kselftest+bounces-17711-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B2EA974A5D
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Sep 2024 08:25:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FC071C21C58
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Sep 2024 06:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A69157DA9C;
	Wed, 11 Sep 2024 06:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D9OLegJd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D21D182D2;
	Wed, 11 Sep 2024 06:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726035921; cv=fail; b=nNqVtaNEkjCPokugyleDkFsFmbBCtXCNM3PDQzSZDNq+SqzLNKyXZbobs4x08iNGDEgtgVhGgw3WRi5ylngTLc9KokBAU/Mw4sd1lfRE/WTV3TuKMK6NF/qvV2hivfCxg5TbDpl8at9+h5TIZPFCSR04JYgAFtx9+gQqL2X5ItM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726035921; c=relaxed/simple;
	bh=fWR0wLN8MB50KBMpE3fnm43fpBl8S4QDJ0j6H6zbqdg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FSZSPnPblvFNHDbcT60yR50iGOck4TdNIBtp9la+VBOqtJnrwGdtuaR+Bcww+rseyEFSmQPKSCpS6j4lkkLU+0JZuT7USLVmIPwuJQvOEdgw2MbcEHpSIHbS52djhqFWnqZR6tWoaUTF9S//htrIJMXXOLLP3sYNUzbdVJoc2LY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D9OLegJd; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726035920; x=1757571920;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=fWR0wLN8MB50KBMpE3fnm43fpBl8S4QDJ0j6H6zbqdg=;
  b=D9OLegJdM2Nwt1pB6mKwdM8sfevY8kan7T82Jjh7iKw5CnRHQtCQ2+Pd
   SIpNzO0qcp5gt2z7Fe7HdmYwLOkzXRzdX5plfeAoofZrBQiQlPUQw4W3x
   zydzv/f6r2vdnC/bYx/GBDQnkjKwusE2pcAQJ+msADc8pyh24sng7Xykc
   LR9G90eHVczsyvfkJcmtVUg0oEr90+LpjHbctrkdeNxn/vuC2u2C3c2tc
   jLiRfEHb4JNmrGMiOZ/pdkQX5Xx3t+4zpDf4NBxkY32ma3F8jcTl7hYen
   jBnrbk9tLTVQ0Ep9eyGj5gbBonoacJEC8Ev/3gB0yFf1IpYRkgR9gPGCA
   g==;
X-CSE-ConnectionGUID: RVO40FrsSv2qVUWXUM1vKg==
X-CSE-MsgGUID: f0wjbnnmT6+nMXqD83h7cw==
X-IronPort-AV: E=McAfee;i="6700,10204,11191"; a="28556030"
X-IronPort-AV: E=Sophos;i="6.10,219,1719903600"; 
   d="scan'208";a="28556030"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2024 23:25:19 -0700
X-CSE-ConnectionGUID: fGqT+tK+Tp6/GTINKjGq+g==
X-CSE-MsgGUID: eLeWgye5RWKOUYcnsSTOXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,219,1719903600"; 
   d="scan'208";a="67107237"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Sep 2024 23:25:19 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 10 Sep 2024 23:25:19 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 10 Sep 2024 23:25:18 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 10 Sep 2024 23:25:18 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 10 Sep 2024 23:25:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tpkeH9MRAJQ+TDNWKKDTZqfsgY/9cS0880WU2EmOGrRLFKgk8DlN6zH4pT4PsnXpNNfXVPneAd1azGkvVQqBE1BPcToPhM3/mFDg6JnrpT2GySx5XUl/ufUXPeWnSdQo1gtKD77KL9GEYnNLVBRFj3wsdyJX6JXRvade/u6ZlfLYed1HzGB3KEZk12vg8tnFLsIwI9DnPKf3m/4F/a8wTdwvv49X9WiyZg+2O4X1REf9srRbZWhAA/MWyuOjP+F9J5ytPWrzPwal3ILB0czROySUkLiCw1Z0tHRGsZpAMrrSMnP3WDOTKB2x3usN4QawzpMSYfpsYVsvdhlXWZwKYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D866SP+rBFjxa0PI3txqLKupf37CC2xet5jnG3b8jGM=;
 b=Xy3FXItWrBWlbtah4WFJ26BmFZxA2Yx5PKHFJOUzu3gGIB5bABhhZpyy8TfbAopgLyacX+9g0V55ToAJXnksWne2sHbyHSS/8mroreD2W53d26hCyEEXRnzRPg0IoRE4zVvKmnC5kR8uhjGMh7zVSn47AvxKMEE5s2pzUD5Ph0pqJ07UDZm8fl2hAlGGszNgT1NfwwFrW/OuJW5NpFED5si6CM45qb9BqcXFJgC7etpp8fiJpYoY24gXDnVdWqftnsI8Pr+U6G0PqbwytTacm/HwwVz+BzCjeMCnA2tKPinh8TvzCnQ0JaUu2Ep+CxsDoV0pgKxHFfZA0QQUSsfv3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5271.namprd11.prod.outlook.com (2603:10b6:208:31a::21)
 by CY5PR11MB6366.namprd11.prod.outlook.com (2603:10b6:930:3a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.33; Wed, 11 Sep
 2024 06:25:16 +0000
Received: from BL1PR11MB5271.namprd11.prod.outlook.com
 ([fe80::5616:a124:479a:5f2a]) by BL1PR11MB5271.namprd11.prod.outlook.com
 ([fe80::5616:a124:479a:5f2a%2]) with mapi id 15.20.7939.022; Wed, 11 Sep 2024
 06:25:16 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>
CC: "will@kernel.org" <will@kernel.org>, "joro@8bytes.org" <joro@8bytes.org>,
	"suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>, "dwmw2@infradead.org"
	<dwmw2@infradead.org>, "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
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
	<smostafa@google.com>, "Liu, Yi L" <yi.l.liu@intel.com>
Subject: RE: [PATCH v2 17/19] iommu/arm-smmu-v3: Add
 arm_smmu_viommu_cache_invalidate
Thread-Topic: [PATCH v2 17/19] iommu/arm-smmu-v3: Add
 arm_smmu_viommu_cache_invalidate
Thread-Index: AQHa+KLw6F1nSDclIE+ushKsvSKoLbJJbdGAgAAb/YCAAAXcAIAIpC/Q
Date: Wed, 11 Sep 2024 06:25:16 +0000
Message-ID: <BL1PR11MB52712F4AAF7D1388A080A49E8C9B2@BL1PR11MB5271.namprd11.prod.outlook.com>
References: <cover.1724776335.git.nicolinc@nvidia.com>
 <4b61aba3bc6c1cce628d9db44d5b18ea567a8be1.1724776335.git.nicolinc@nvidia.com>
 <20240905162039.GT1358970@nvidia.com> <Ztnx0c4BpGt6umrM@nvidia.com>
 <20240905182148.GA1358970@nvidia.com>
In-Reply-To: <20240905182148.GA1358970@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5271:EE_|CY5PR11MB6366:EE_
x-ms-office365-filtering-correlation-id: d531f5c5-6a12-42a0-f82e-08dcd22a807f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?3Q1PNzswB7S1tS+uYmEIrgY1eM8OUt9QA/4y8I/eR4gJr/8/RAVRLJ63sS4Z?=
 =?us-ascii?Q?WH9fIB010y5LUYAxlA+FvNrXzGVL2NP68ErlCmgGOac964H1vQv11zizODpa?=
 =?us-ascii?Q?ICkzsPKXLhbKoNtpwkTr5fuBAWkaClW2Cxk0gkSMrksNEFCxU5osjbYPsnps?=
 =?us-ascii?Q?mpG3Whs3E7ET5Z3Rx2NrEZruQec8sY0lpN+EenU5EYTSPu6MBM0heu+AUMni?=
 =?us-ascii?Q?Qp9Mepdh+0dzDM58XHXI2UCnN8uvrXI6/dzEfWCos8Up/Lo3xcwPUY7DcYWw?=
 =?us-ascii?Q?zs38ADthSY7VTlUI4tabV5+OtPE/cqmMNLJomRkkgBMdoAQgoVCnaX1zMhIz?=
 =?us-ascii?Q?gkd7I2PhuzdQLxJRC+42pPlEoeixK+Jg19GnzjZfz34Mo65Y04m8BqOwnokf?=
 =?us-ascii?Q?3zj4uQHCjMXdA5m4vQiHBWDYJ0PoNxT5pbbthoZPY7tZIvdJZ+U9f7usGQWb?=
 =?us-ascii?Q?YFWDTItH4/IAn1Pz4HOOEHf0kPMBtNu3lNgZu8RMYbCY7H0XasbrBEPBIzkm?=
 =?us-ascii?Q?EIo/VIMSy3ooL2R5byyxghZZ2E/aDFyO8khhFkTrHmKbwMVzQr1dnL1yc9gL?=
 =?us-ascii?Q?lofadVjae0ad8LLijx4iciGXcIhkX90BRIwldyPpoGuy9id4P7TjUdP3O8MX?=
 =?us-ascii?Q?Emfnu7dpERS5ghszOV+WNxs9DqMTSVxkxakarqhITvyYCmyGu9RE1QnmsEJM?=
 =?us-ascii?Q?WbCv1gHDWL4YgE/mX+/lINPHxfmAJ4jI1rGgOok3RqWTY+UKTDkP04lQUIKg?=
 =?us-ascii?Q?tG6mQ/xoVDtMSwzaGp/1mPdF5TLdPKH6I+ayrJQ5gwfdEi9EjgGBrcz0o0S8?=
 =?us-ascii?Q?CIjqu2IjMKLKtCOmxeVnkaGR/Mc6WDksKTrZVnZwQQM5BRjdLgdzr0ajc96c?=
 =?us-ascii?Q?b876IQWuohmBA44FDkbeUuXeFEV9odeH86xrj0YEedg5Bh6LY5LnvKtinzCx?=
 =?us-ascii?Q?vXHeabv/L/NgcKMqucdFObc4cJLvJc0UveyplgLFoT3Nu6iwG/y7rbBBJ3u7?=
 =?us-ascii?Q?CPNaF18aShITeefe8t4f3k7sd59QaPgeq1VUh4zu/AnBWwz/cdssx0m74yx2?=
 =?us-ascii?Q?Yq53oE9ghnv6/rEUQe3d4nsQeR7mbd/acPEb+XdozPMSLJUfli75z7lgtfPC?=
 =?us-ascii?Q?COxtIiuzR7n2SVZZnwRWHqhTeSCxzzbALriC2N6g1m5aWZbd0J69nunnhid7?=
 =?us-ascii?Q?HWS8q4w1lLmHwhxjtOhVhRmVaXMalsyPfH7i0i2r7+CKVWbnKpLiaUhaAan6?=
 =?us-ascii?Q?CIH/bAvKmglv2+MGB1KCK2zaSp7vEclcaO0CAvAyuL3T7/b318ZudQuNMUA4?=
 =?us-ascii?Q?fYQldAvpp5g2v+LSevwYfpf25zmCqUA0GULdDfhRb0BRnyvjncH4CiOuphNM?=
 =?us-ascii?Q?GobOGExRFtvcHQaU+M7j9zwra3l3yOtk6qeORaD5pVNTMMUe9g=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5271.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?iUmOTBEsr8AUF6aQ72UI1KD0PLMjlP6qiihgus6RstqcA5d8um6johmCN9cH?=
 =?us-ascii?Q?1GP3CldvOVwpi3UJG8j/XEkfaBUpLM2QKZTe0d1tp90kw6m4Tr5D7BEW11KH?=
 =?us-ascii?Q?a1Xa9OpfsbDYa033NO0+kwa8F9UDXDwfX5GI/yjc0OcLqNUr12MFlGwXnCAm?=
 =?us-ascii?Q?W/Ng7Agg8DTAdEf2u4gO4wAopx1BT4p93WqESMMFH03KfhGYoOLxIGC027ed?=
 =?us-ascii?Q?YazFUvcF3uer65G7Gm6N6MxgKKK4j+xoGqOKqYUdhpAIYxcBGKd5dsHrqYSU?=
 =?us-ascii?Q?DR9sXSpZdMsrfcnU2R0PMEB7tje7bL1abULvY9guCJrlUjpFy4wJEnLJEbPP?=
 =?us-ascii?Q?rmukwd3vzkRYXdpUm67cm41/GEvA99Ovanvoz+KrEeD7VZsISolUI5KrhjzT?=
 =?us-ascii?Q?PVkhW3Rv4ZMIQxP7+mKaXrN1lIWpIRBXCiB+hkgc9cCs6lC5jJ1L3I2gFkeK?=
 =?us-ascii?Q?lM3qKSFa06XDyUUtusMol4m35v8HAhnmqwom5cvFo0vVovuwaJYdJGZTaHCW?=
 =?us-ascii?Q?AJddYcJaw7q6xi4m3zdWlNX8Lhf/QxyWcaikiclloawuqRanpGPUBn012AiE?=
 =?us-ascii?Q?rbTQhprr8KJ8IB4EGsyi4Fdz5fN/XIcgUUwmrhknQF02Qgu1rnRvNWXyI+5l?=
 =?us-ascii?Q?XZyq6hIWTOlibDkUNdqP1xROn+bGxqoj8vfi9qX38xwXZERRbmgY5T9UG5E8?=
 =?us-ascii?Q?2EkK7tyWxQaN7UYVC+2xQb330R3i85DjEsM1WX09Ostdh5vbAWhLy+AGFPtP?=
 =?us-ascii?Q?WEQFVBM6tKHhc+N75dXrwM/ONN1iz3i+FSneaznNIIGTDhS6tU+meVu1TOsF?=
 =?us-ascii?Q?/+ao7z3nRDGIlg3J91xklTPyZ8rGOl1hj/jM3BuhTQtww6kaBT8OOYac8ArD?=
 =?us-ascii?Q?RMCJ1vNwxuGgt3h5aM5VIipVTMd79WqIhY9sobrOBeVG/MYLc+dnDZYn13jA?=
 =?us-ascii?Q?FhiNDHK31IYNlv6argl+pjK6OS6D5lbGN9l3NI5vVDx89qV2p94EceZhPq+t?=
 =?us-ascii?Q?ylxRslL1qIWWQ9Rb/3YRo+TbegzUtGY0C1ZxxzqS87DDcz+iZU/XM03ny8/B?=
 =?us-ascii?Q?9k6nCAOWtW5DSue2yMmMCoaBsETI2B87pZ/5xD2zoh/scrP9KEmiR3a70/lg?=
 =?us-ascii?Q?+fUuFlcDikvzjLeO+vS1mhzBxB97p14FnRsm73Mu/YnXSJ9QDv3Z51WThd+A?=
 =?us-ascii?Q?KONP8rm5uAf6jKFL8AT8Ubp/OHxEKrNREFXoqz6gofZEHEOhEXkWet60wcTt?=
 =?us-ascii?Q?O5KrGYaVqEHuQc+uFYVQWLeM41AAPiQl8CofMKvo0b7n7i3eugmd/LzHjamq?=
 =?us-ascii?Q?dJfon8Fhni8sFLk0fbrt6yhN5GmTpXT5r+HfeH8K1hXpjrTDpFv4jYynj7BT?=
 =?us-ascii?Q?p5L4Fc+zSUDj2XRZ12iYunj/9S7bBW6zGk7ZeXalVNKyqgBD1uvOS345ymDn?=
 =?us-ascii?Q?Mc7ZI703JFpf47ZnJbgH8mzPP8kiuk6RecaY4IqzEitdzbYTre4q7BlwtkIx?=
 =?us-ascii?Q?jn0o03ssiisi54J+y3lqRzN1vWXbBCVtNzcrkvXJBJyNPvT/+J3ZGZ3T/pKj?=
 =?us-ascii?Q?AQrVVWRubcRH/66ySx+McS2wvSWFoFkDQpD9XFLf?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5271.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d531f5c5-6a12-42a0-f82e-08dcd22a807f
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2024 06:25:16.5913
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VxWdRwzXvp99Z6ODu2kpZTrHeGblOYLtRimHakPHJS4B6wIwuCWqT+BdbVNV4VNHgAhU4EuRrZoF90WVc/FzKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6366
X-OriginatorOrg: intel.com

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Friday, September 6, 2024 2:22 AM
>=20
> On Thu, Sep 05, 2024 at 11:00:49AM -0700, Nicolin Chen wrote:
> > On Thu, Sep 05, 2024 at 01:20:39PM -0300, Jason Gunthorpe wrote:
> > > On Tue, Aug 27, 2024 at 09:59:54AM -0700, Nicolin Chen wrote:
> > >
> > > > +static int arm_smmu_viommu_cache_invalidate(struct
> iommufd_viommu *viommu,
> > > > +					    struct iommu_user_data_array
> *array)
> > > > +{
> > > > +	struct iommu_domain *domain =3D
> iommufd_viommu_to_parent_domain(viommu);
> > > > +
> > > > +	return __arm_smmu_cache_invalidate_user(
> > > > +			to_smmu_domain(domain), viommu, array);
> > >
> > > I'd like to have the viommu struct directly hold the VMID. The nested
> > > parent should be sharable between multiple viommus, it doesn't make
> > > any sense that it would hold the vmid.
> > >
> > > This is struggling because it is trying too hard to not have the
> > > driver allocate the viommu, and I think we should just go ahead and d=
o
> > > that. Store the vmid, today copied from the nesting parent in the vmi=
d
> > > private struct. No need for iommufd_viommu_to_parent_domain(), just
> > > rework the APIs to pass the vmid down not a domain.
> >
> > OK. When I designed all this stuff, we still haven't made mind
> > about sharing the s2 domain, i.e. moving the VMID, which might
> > need a couple of more patches to achieve.
>=20
> Yes, many more patches, and don't try to do it now.. But we can copy
> the vmid from the s2 and place it in the viommu struct during
> allocation time.
>=20

does it assume that a viommu object cannot span multiple physical
IOMMUs so there is only one vmid per viommu?

