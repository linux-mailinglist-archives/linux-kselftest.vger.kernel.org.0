Return-Path: <linux-kselftest+bounces-43156-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B820BDC184
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Oct 2025 04:03:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 73FA14EAFA9
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Oct 2025 02:03:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD5632F619B;
	Wed, 15 Oct 2025 02:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K9gkrXmu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5AF91DED64;
	Wed, 15 Oct 2025 02:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760493809; cv=fail; b=kiR497Xk7Hoo8xCLTtSFheoHEodygb7/gXcLloV0cYgI91CWgudbBM1w9cPgEZzZQCJEjDREa5ID3S02ZWAz4KfqRINST9PrfU00pvIr+3nhRWCbHb0EqftlqFacqtyU74hRaxrlcRpYSCq4Tb7mRZpeslAYSPk5FFOwvvdf1dY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760493809; c=relaxed/simple;
	bh=DTlDTjEklG/1HUGXuOa/mWmaF5MXE6pb+81vmGTt/+Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cVXOQ7amd3P0ohHDcSVgvSP723YLIA3fHfqH1zT6d+OymZ1BxE3U3RwN2Mw8NjkrYdzAVUvfDslCkXQKUQQg8DiMMbBJpjX1zf7kZYeSCtke2ipHiAl2+jmylYsKyON95VQO0AftuxIlPfqzqAsj/IGd914df/VTLVzB18Ywy0g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K9gkrXmu; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760493808; x=1792029808;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=DTlDTjEklG/1HUGXuOa/mWmaF5MXE6pb+81vmGTt/+Y=;
  b=K9gkrXmugAsXh5bbSmBpPC0Qib9PgkYauQaCIrYLjgyEs4U3kwET4f0Z
   IiEFtY33WAspWhV0gbfKW1nlsvecozLiFAusDPPiJ1VPUWWhNQFCqT3SB
   VoIVb2vIz4y5/tjGayVHjvxT3or+yy0OCS6wTfEDiFLTtKwXvZoZzGAFx
   s8CW00Smz7ldJhRHgqvzSuESH3NXGY5Tm/83r4FKI7Cz03yntjyhPv7QJ
   0VssuPlWZv8pBai6dV2m02wGqbwrlkrr3jQO3dsoG10lI4iQ1bCkPIXqY
   HHfAr9fcKdxJuY2LQKWz3L4tM8umGOM6WRq+tO3qayIBWkJl7HUQTyyG0
   g==;
X-CSE-ConnectionGUID: DHOk714FRv+7PqNsKRqJng==
X-CSE-MsgGUID: egmkygUYSg2rHqMxScikwg==
X-IronPort-AV: E=McAfee;i="6800,10657,11582"; a="73763371"
X-IronPort-AV: E=Sophos;i="6.19,229,1754982000"; 
   d="scan'208";a="73763371"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2025 19:03:27 -0700
X-CSE-ConnectionGUID: 7k96qOVvQGmmYyctQSgc5w==
X-CSE-MsgGUID: 3Dya0iUlS22lLMovfov02w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,229,1754982000"; 
   d="scan'208";a="212649847"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2025 19:03:27 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 14 Oct 2025 19:03:26 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 14 Oct 2025 19:03:26 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.64) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 14 Oct 2025 19:03:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TsU8yT5UpPlYy2Ias91KYU5bMpWWIfaEejsH04hC/C0BeNz6Me/bjJbwl5FX8HTPMuc1YimWYpjII2o2ve5dSrXbWk84XrmfF9VyiTzviMoBJaxi3VNeYFxwSQ+M8q5UuVEK3q+GvgB1FAAxi67ZmyN1FRmpWrohfM00Aj1Wek7cyoTaI6EcHB+yM4qjrp3jKM+Cl6IcWJiqv6XTve2s+5d4YYXaVUGJHWwvo3xuJ5NMs3u7s/iR7bt3Ypjk3ptIn7oJJ6+2qL9jSN6uAvjhNwLku9b3RCO0dTwHhJZW11POMnB84zLAdelOTL0moaVZj8+SQ8HmxvmCY6+E7h5GoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LQhJtcudh45qCR1qizrJJAzSvGCSOVn5SI0dtxc5Ask=;
 b=texzMn3v/Z+v5B66yBSWFn+JpDB+XQbGUuZDWFzvz2los7b4zZR0GYmHIDEcBf8syGfdrp6W7aNLt5sDFZ/JNtfFGfH3O8+qIWkKRt0t8CIs5h+cRcjH0niylv155T1w9P7BelfMaRNVXsvIVKVezfjTyKZedlDqZb2LjAwNekaGz1zR525M8DSNmMeaKLGYZrcCrz5aPoQnIQedlkWHULwt+U3blKZTKnOQry+T08T4/NXhDulmn254u7dzuGS3RExpEV0nsU2sNUfHVkHi4MxWGIiisyO1KRXO4/U1X4GYXR6g8l1uy+IbBmziAUs3sh8tAGUtsycxhkOTiDNIdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by PH8PR11MB7141.namprd11.prod.outlook.com (2603:10b6:510:22f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.10; Wed, 15 Oct
 2025 02:03:17 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%5]) with mapi id 15.20.9228.009; Wed, 15 Oct 2025
 02:03:17 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>, Jonathan Corbet <corbet@lwn.net>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, Joerg Roedel
	<joro@8bytes.org>, Justin Stitt <justinstitt@google.com>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"llvm@lists.linux.dev" <llvm@lists.linux.dev>, Bill Wendling
	<morbo@google.com>, Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers
	<nick.desaulniers+lkml@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, "Robin
 Murphy" <robin.murphy@arm.com>, Shuah Khan <shuah@kernel.org>, "Suravee
 Suthikulpanit" <suravee.suthikulpanit@amd.com>, Will Deacon <will@kernel.org>
CC: Alexey Kardashevskiy <aik@amd.com>, Alejandro Jimenez
	<alejandro.j.jimenez@oracle.com>, James Gowans <jgowans@amazon.com>, "Michael
 Roth" <michael.roth@amd.com>, Pasha Tatashin <pasha.tatashin@soleen.com>,
	"patches@lists.linux.dev" <patches@lists.linux.dev>
Subject: RE: [PATCH v6 01/15] genpt: Generic Page Table base API
Thread-Topic: [PATCH v6 01/15] genpt: Generic Page Table base API
Thread-Index: AQHcN6U2FMyzYEXmqESRnAP8lhrZhrTCfluQ
Date: Wed, 15 Oct 2025 02:03:17 +0000
Message-ID: <BN9PR11MB5276C2E12A8DE1BF73352A9C8CE8A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <0-v6-0fb54a1d9850+36b-iommu_pt_jgg@nvidia.com>
 <1-v6-0fb54a1d9850+36b-iommu_pt_jgg@nvidia.com>
In-Reply-To: <1-v6-0fb54a1d9850+36b-iommu_pt_jgg@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|PH8PR11MB7141:EE_
x-ms-office365-filtering-correlation-id: af941b9b-88a6-466a-552c-08de0b8f023d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|921020|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?fezCiiTMN7KM3xyY76bC0ueNL0eHCR30j2yx2Qe/IqoP6N2+mZG+s6vd1+c8?=
 =?us-ascii?Q?ggV5mKXzDJa47g7vQN6eWbq7nt1afecF0dlJ+IZcDPeC4RkW5fQg6zE+5JWh?=
 =?us-ascii?Q?6qFjrVViWWi8HM5WZgayJpqrGQCb/bdjuASm0FguS2lksCWYGptlRtE1Ij2g?=
 =?us-ascii?Q?9JElIKyA29akoyd215Uz/UMJolmzqqU2hLzmK+dOCK/fIHMCLzqLMWk4zkxE?=
 =?us-ascii?Q?cwmXB3Lps8C17gXqCn5uLbiBnHyyM9umm1B/2WDWhdqTzRDoJgZ2q3k0FQdT?=
 =?us-ascii?Q?JvdKhMFjpg5D/ZCu1liLd2wuTKayvQOiBdRZoRyEsmvZ9Tcgyi3N39SVnEDs?=
 =?us-ascii?Q?I0d5OUqMbZZnEUWzpTUmigBgFQwioypCFlUY5iU9sV8JFoMVS3MwFPL3eNFF?=
 =?us-ascii?Q?nhqa9Y5B3XTguUsTz1EWq2Gxxnkj3d2SbMfdpGEn72uPWV4CMeRDUt175loH?=
 =?us-ascii?Q?B11vbIYjt9WY7wA+1Kt5ZfVwC8I3c/oexbG46rsaL+/cPK2rMU9fi1B1pIa0?=
 =?us-ascii?Q?Gil+DZYBSLQPWmp1vbvXAU2FJPt3ZpbXUUT8vcs9IZfypTO+fm+MemLby+T+?=
 =?us-ascii?Q?Y/Zk55lagcPmNDMWvmToRaZval8s4mnt/qNn5ezxHablbM4kqXkkYIZiU+ki?=
 =?us-ascii?Q?GbPJtK4nhVjktSF3mL2xE90iyka8KSVntzMjXTkd74FzspMwNM7MZMM0Bm0O?=
 =?us-ascii?Q?fWiDPZ3ZJIZ7IuEVcRAuaGS/xSDbvLx4Hg1DReUENiAxaoK5yHHDTt3fia/S?=
 =?us-ascii?Q?9Hc0y+/44i8LFsHJNoVaRcdLBxD1OnCf6s84EkRyLt+o/K7jNA1fw03hZWH3?=
 =?us-ascii?Q?ppOwYeYIA3njaYUMtuxgo3gY+D6odtaBijzvIJYlC6fWwcT+F8baAwF2qFZ9?=
 =?us-ascii?Q?1VryGTeDDNk1LVg7hUly396K8wBHLJKeUTLKnoh839TCR7T7rs87wgnYew8Q?=
 =?us-ascii?Q?74T5+bBTOPnZflqasucN0KRQTw4GLz1f/ukpQzCIWsVkpYPyOOOgXzIRsvJC?=
 =?us-ascii?Q?3C3RZemBSmNDiD5nfjJzsdkAYUMbsEWyl0jvYKZn/KZHBc3/4wYNE6/lkGT6?=
 =?us-ascii?Q?rNmKY0Gv03plxg8bdPgwTKsDBiMkltQZY0brIMaBSjDcCulwc3rGEhjBUW7G?=
 =?us-ascii?Q?JLJX3XLtzqTbrTvba8QTHygCJBc0xwbSASuwQqyTbVaTiosRGagjL4f9cw/K?=
 =?us-ascii?Q?TOcGAhdBK9jpRFUCZQyILTrPSMh0uAHRAaGtU8JHZ50YKjluTnjgnBeelh4a?=
 =?us-ascii?Q?FNUzaZDHTVQwE9Z5VDvbCABgCo/U+N9K85xKpOVLWpdjVlHVK5BmqgtS17Ou?=
 =?us-ascii?Q?O5ZKQz9NXfR7UkT5P43iN+fiTquYWud2g3p5aPHHZF6SM28hq8ue4FBx1BnL?=
 =?us-ascii?Q?XhtdOznDnLz/yGnD2atDaQ4z7lM99StroXk6g2aHPEsAOCPK0DTNUwHXxF5P?=
 =?us-ascii?Q?L/Tzr3iuzByq8J4aReoUa8YFvH1UUbT0k8Uc3Z+nXD5biP7Ba9tl/+YzcX3X?=
 =?us-ascii?Q?tSV6w9N4Ua1MJxyO1JtAJixZ+NhHfAqVeN4K?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?eG0MW5KhI168KOD+2WwLQQSSwg4+uK354amhOCuuNwZmXa+XPCkEk+3Rckkr?=
 =?us-ascii?Q?OZuuggZv+bEqN54iJ9wHCle4dkIfj86U/QHTS8FEY4mzzGNH3cZoca1r+ZFq?=
 =?us-ascii?Q?c0SvsFGn3Q0yyPCeJfndt0qzHcpP8f9ppAnt0K7SCWLj6KF19U1kt1yTh3r6?=
 =?us-ascii?Q?y8ctaQKyzmk1PGFQXig/VXqcUxKXfC6d4xlOtKOSPxOV+Fa8shF4GT3IePMY?=
 =?us-ascii?Q?82oWFP7UGWnnOuAN4eWYPDD6Vc9vH0Cb970ompbHjonTYHvnuamJZhdXXCGW?=
 =?us-ascii?Q?1N5aH2qMPXMlMWetAZstzMRYRQDfBK/CypCHlDIvXBZYfgO/q4Gmv4tvY0Lc?=
 =?us-ascii?Q?V8+R9mMOi+gp5FuVaImmJNJixDL+UqS5z8Q4716Z7MZZr7G/32XKl+ncrWHF?=
 =?us-ascii?Q?iZtmmFXuAFAwVX+lKeXTu8pYa5xle0aXHmijGvincZw0TmL1tyjRHj59y5gU?=
 =?us-ascii?Q?SZmPDNoFGTTjenFrlxClgeF4phABf4jfkFrjWlUNpMLUnrrk6YAKbdtsNw6f?=
 =?us-ascii?Q?rUVv09C6oJPGv7S9Ji4BYtySgFZvYc4UI3K76DlVUx4nvE5Lss/9nHKKOWEP?=
 =?us-ascii?Q?ZjMqHG2ZMqeKkAvB26VageRED9jYrcJRRWase/rtHaJRMmBLQoAQG/FUCbx5?=
 =?us-ascii?Q?zF/6jqu9pzYWau+O4AUJ5+Z7zzhghi7XdfjHVZZQVfl49B3A61UAMFYjEolH?=
 =?us-ascii?Q?+ofrUUARPlu/ht9Y7S+trNcSZ2kwINp8xZkTaH560U/eKWigTviJqRWbhJZM?=
 =?us-ascii?Q?BjMbyHGlNYxnTPCHXIUhSgLgB0mTsOk8P93J2gwuJIwNty8RL/cH7cqiRUsJ?=
 =?us-ascii?Q?bHRq296ZyvEMnsrPQAdnD5vEBo7k5KGgHfLiD/I3yJip4aivW+9yh0k65Crv?=
 =?us-ascii?Q?VKe5W5j3THlIEZMeFyuNvOvt52Lm8eM3LWP4yQcq/VprAC/NX5P4Lytr04Xm?=
 =?us-ascii?Q?oxXB0s+KScCTkGV0X0ohyeiyAKFuTwxlrFWn8GP8yzpXBcR4s7xZhCJ5Q8zd?=
 =?us-ascii?Q?/G6vBjaGD8q3ZUVX0RmcXxTYDnoHziIuRZI9vp6HH0bBZyHL0QgZmONoTUtq?=
 =?us-ascii?Q?0PmAnp/JxKfSO1DO546GMxzjMVALCacobwt8Q0ozXxTIxurik5ipBJWSjEoy?=
 =?us-ascii?Q?FHXSm69/xYy37JVZA84Kbg4DhDZJnI2EaZwfRQ6t1uz4urZh0WY4EC5axZJO?=
 =?us-ascii?Q?1FugE9HGfMVfqOW4sSKhgLPmVdjF6D+0xPQZdArtQa93hn6wCyc6DzsL1Qc/?=
 =?us-ascii?Q?Ye1s7CAVKQVqC8cje+oD3h2uQq1PWeIMxKcFnYZ3y4FYb9PpJsvXQNfcl1uw?=
 =?us-ascii?Q?bDy3HSHxdgoxNhHqXryXBVjLeYPSUXu1KPpPafNh84Df4MFYcjyFlNNqJrUU?=
 =?us-ascii?Q?MYjblktdWPgJAIR7C0K6GYUAS2lV0KAEWPtMA5/+/714DmYcg7I/HSrFHF8b?=
 =?us-ascii?Q?rDOs2Y5toe2irZkMe1HFN9sK9kmCzDamU9eeSwcumGvAQmYX1zKCV2Dcmr20?=
 =?us-ascii?Q?MEyzsx98BUpcdd7U6bnr5UeXTTrWiO5aV2VcDfSiXiT0IwaBWi0/WEc/M6Uv?=
 =?us-ascii?Q?Q7niJMqiRdZnwuYUQsGnLjLoyb5zjHv64jGsyk8d?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: af941b9b-88a6-466a-552c-08de0b8f023d
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2025 02:03:17.8911
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4LW73rL0viKAtTYCriwls1xY7uuS+sG016HoUI7dcM1cJfR/V6Hdo3Hub5c57cnFZ9b+Pg2hgCzidsPD9I6iSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7141
X-OriginatorOrg: intel.com

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Wednesday, October 8, 2025 12:12 AM
>=20
> +
> +/**
> + * pt_clear_entry() - Make entries empty (non-present)
> + * @pts: Starting table index
> + * @num_contig_lg2: Number of contiguous items to clear
> + *
> + * Clear a run of entries. A cleared entry will load back as PT_ENTRY_EM=
PTY
> + * and does not have any effect on table walking. The starting index mus=
t be
> + * aligned to num_contig_lg2.
> + */
> +static inline void pt_clear_entry(struct pt_state *pts,
> +				  unsigned int num_contig_lg2);

better call it 'pt_clear_entries'. If it's single the size can be retrieved
from pts then num_contig_lg2 is not required.

> +
> +/**
> + * pt_entry_make_write_dirty() - Make an entry dirty
> + * @pts: Table entry to change
> + *

...

> +
> +/**
> + * pt_entry_set_write_clean() - Make the entry write clean
> + * @pts: Table entry to change

'pt_entry_make_write_clean', on par with pt_entry_make_write_dirty()

also put them together instead of mixing other unrelated helpers
in between.

> +
> +/**
> + * pt_entry_write_is_dirty() - True if the entry has been written to
> + * @pts: Entry to query
> + *
> + * "write dirty" means that the HW has written to the OA translated
> + * by this entry. If the entry is contiguous then the consolidated
> + * "write dirty" for all the items must be returned.

'pt_entry_is_write_dirty' to keep 'write dirty' as a term.

> +
> +/**
> + * pt_install_leaf_entry() - Write a leaf entry to the table
> + * @pts: Table index to change
> + * @oa: Output Address for this leaf
> + * @oasz_lg2: Size in VA for this leaf

s/VA/OA/, though the size is same in both spaces.

> +/* Returned by pt_load_entry() and for_each_pt_level_entry() */
> +enum pt_entry_type {
> +	PT_ENTRY_EMPTY,
> +	/* Item points to a lower table level */

/* Entry is valid and points to a lower table level */

> +	PT_ENTRY_TABLE,
> +	/* Entry is valid and returns an output address */
> +	PT_ENTRY_OA,
> +};
> +

[...]

> +/**
> + * PT_MAKE_LEVELS() - Build an unwound walker
> + * @fn: Name of the walker function
> + * @do_fn: Function to call at each level
> + *
> + * This builds a function call tree that can be fully inlined.
> + * The caller must provide a function body in an __always_inline functio=
n::
> + *
> + *  static __always_inline int do(struct pt_range *range, void *arg,
> + *         unsigned int level, struct pt_table_p *table,
> + *         pt_level_fn_t descend_fn)

s/do/do_fn/

Reviewed-by: Kevin Tian <kevin.tian@intel.com>

