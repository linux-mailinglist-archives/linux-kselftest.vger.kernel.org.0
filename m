Return-Path: <linux-kselftest+bounces-20778-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12FE29B2335
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Oct 2024 03:52:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6FBC281107
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Oct 2024 02:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7689817E015;
	Mon, 28 Oct 2024 02:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X2Ch8GOn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 818C1178CC5;
	Mon, 28 Oct 2024 02:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730083937; cv=fail; b=Hv8Q2lAO21eVpWXsiCBhF3vjyPsJ1BhBt3E7lohE+vRbqdV0K1IzC3M9AeIeG8sF/7MJCmzvhgopFlfzwHN4qDivxh3d187rLK8rFNYzK7iZhb/6EZKd40EVV201FoAXzrPmDbgoEaFZ4rOYCrwIAS7Zlf7NFvm7cNYiNfRAFj8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730083937; c=relaxed/simple;
	bh=/f5cctLjp4PidTxCvmMs4Qp/G9FhB5zEU3spgyrPRGk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=c3cinL7jl5p1FykFXLqa+a1Q+8PwkGIyo0GTDHEx56EoiwAAcGPEzgC1Z6ofoJ2DuW2kZzpfUZmONAbGtOF4MoalJ4TkObK4rYFkUgxmfkPb0qF4mtZtUywVu6WnjAS8R3Bop03UZFbwuhQ6+CWOoSxwt19GYKQiogDqndcHYsk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X2Ch8GOn; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730083936; x=1761619936;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/f5cctLjp4PidTxCvmMs4Qp/G9FhB5zEU3spgyrPRGk=;
  b=X2Ch8GOnaC7zznsgXQJOH6qe0y67YIGgeLAkKpiXM9FbO8NQuI/9e6x1
   WsuDgZWICayslbGyx8WvNQ4j/aUomNXBpDO9ftwwuNpYsT5/2FaDxDUaj
   YjoTBIQgHeFVsWpH5RtvjwlMWntyyMB1BnmYsCfSIPilO+wj0NeQCTSLn
   j2/R6Us98oxfLE4rhejFOv0uOb8AvwgdztIpyb2Sqh/7CSZvVISw95NEx
   N/MpNsfCmhGPGVdRXNXgSZZ+w/dlgDSUQkVQTna2MMaeJC63PWKOwlwG/
   v23AYos8PrWjnIenuvytoN/O2fasPaxCshJIfVjzG/P6vd/u0rMinI3fl
   g==;
X-CSE-ConnectionGUID: Uzh8k4EnSYGxxt6ahbJINg==
X-CSE-MsgGUID: D2JboDF/RWWAWMIg7j3tNA==
X-IronPort-AV: E=McAfee;i="6700,10204,11238"; a="32533835"
X-IronPort-AV: E=Sophos;i="6.11,238,1725346800"; 
   d="scan'208";a="32533835"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2024 19:52:15 -0700
X-CSE-ConnectionGUID: 9OtQrGtXTpaxFgDRQ9hyJQ==
X-CSE-MsgGUID: 5rxwXY8OS+Sn1NPjtESOBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,238,1725346800"; 
   d="scan'208";a="81635792"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Oct 2024 19:52:14 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 27 Oct 2024 19:52:14 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sun, 27 Oct 2024 19:52:14 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.48) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 27 Oct 2024 19:52:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rk0cmY3bsaaKGsQcGh5lrc4AISDlW8dQDqYgWPuNhQg/ZLx0Os+1AKqN7l/mA2UolbwpQDcsZUTQYYBef/zKSE8u8+Uag9SzaYFvgl2L80FGaN69Ruez62OCzOZg+9liHk9zx0TC1Zu7zUhmZB5PSMvwILnj66dbexwMf7OGfW6RJZQpQ8T/+dylqGQbv1obk55SuJDgqNe9NrGLX0scSBNQAZXFBSmteqy8LC8mVRxGLPERhtGk4X5xpVJQOysS69tHyfVlC1Hp0nmcj/aDQRQzOFISlXG3HIQTVk2hT2Yp7T128lc4SuNBFIj+BURZVZbWzWB8Nn0huF2BKx7y1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/f5cctLjp4PidTxCvmMs4Qp/G9FhB5zEU3spgyrPRGk=;
 b=VDE+HZCXtNTaz7YtICStjNTHvIEbSlUKijWBe3f7dxJUZD3CV/yun2am68q2rL68yhGKbZB9kCHpvnjVZhgmz0Wuf63QE5grVUopq/1h3dvSSGufqD/8rHBOd/Ts5O3p9dunldRMUhkQVTqhRuD76yNAaxbJm2Kn29vP9sWP2MfB2xkVUJYHqfzGRslKChPk3P/m+zJkl4DMjru+T8L9ehhoG4lseKhkz97Z4hx0Pipb0e36Cjh5bJM3UTVhGrVoKUSfTIsKlTyGJP85eztj9hJxTJ1GRz4qcCyTezCZMEmCo/PIQPcbQHjkWlwFBZi5M7UY3mJcLirkAoK0A8RVDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by MW5PR11MB5810.namprd11.prod.outlook.com (2603:10b6:303:192::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25; Mon, 28 Oct
 2024 02:52:10 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%6]) with mapi id 15.20.8093.024; Mon, 28 Oct 2024
 02:52:10 +0000
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
Subject: RE: [PATCH v5 11/13] iommufd/selftest: Add IOMMU_VIOMMU_ALLOC test
 coverage
Thread-Topic: [PATCH v5 11/13] iommufd/selftest: Add IOMMU_VIOMMU_ALLOC test
 coverage
Thread-Index: AQHbJzjB1K65MMWN+EmjvbTbwXmIzbKbejng
Date: Mon, 28 Oct 2024 02:52:09 +0000
Message-ID: <BN9PR11MB52761A434B7D8A135BA883FD8C4A2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1729897352.git.nicolinc@nvidia.com>
 <db4c0aa6e95f46f8af040af847139a54e57c29d2.1729897352.git.nicolinc@nvidia.com>
In-Reply-To: <db4c0aa6e95f46f8af040af847139a54e57c29d2.1729897352.git.nicolinc@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|MW5PR11MB5810:EE_
x-ms-office365-filtering-correlation-id: 53acf24c-a391-4afb-9193-08dcf6fb8481
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?pWFMGuTz/3cs6Kq3S+yzBpp8R6xoGoyo/1+RNOzkO7m4/MkUizfPnTwyCi0j?=
 =?us-ascii?Q?pkszIyWaBqQ8Fx0JN6EtWF2RxoCtbNXjxJnCdBShRISSSfqCJoOBye1byhGz?=
 =?us-ascii?Q?wn0y4HR9j3zvBjua75ju6derZhnLVK5Ot6GpwLTJ7dkNHi1pZIFXzwwCIQad?=
 =?us-ascii?Q?NISBlEOSPKIF6C/PjoC3aMzdUsR07A4fTxptSpPWZhHv+gc2gla/2t+tyu7F?=
 =?us-ascii?Q?NdOoe8dsOU9jlB03F8hoYT2GUwSGbr0Qk0SyW70x2DjHpXbX/tp1bD/zsobr?=
 =?us-ascii?Q?1O//Tyvvo08vUT77FFF+rFDBYQ2+hoxoNfvhv2InmEvLUizCZfDC9oKef2o3?=
 =?us-ascii?Q?BjnHeBhLAwfNWjMVKi02nb7CLpPzKUyc8klnNiEMCT99RJLkw0NPcwtOBYlA?=
 =?us-ascii?Q?2ysoB5PIqVKyfDRCVxpLOceyiQRtL8H5BBoTVzBprM1PLNAqPgtlgaQzlFhm?=
 =?us-ascii?Q?ghxgmkXfkROxmbitTjQg70s4xTgjKZB005EaTEymltLNnbx/fkKT0y+WZSb6?=
 =?us-ascii?Q?f9nUhnpjDUpB8DG6Vi7AI25p8JEv93vueqOyIOL9urtz0nK6bj8V7cWF6FWn?=
 =?us-ascii?Q?igV89fLoSg7RmmETdbrJW0gIZnIRDdiXg5ieMYXC7f+p9bVcVRNUdeh+Lv3B?=
 =?us-ascii?Q?sNwe8gqFLHObmJXA5iu7fyF5LjTlV/Z8oHmvM2XztKHGXMSu/qXEw3qr+qfz?=
 =?us-ascii?Q?KleYYg2Obcf6wPgy8PoGPkoVAGK85qLN3tweivo9Fn2ssJYuZyOLkFYiE9UF?=
 =?us-ascii?Q?oCHQ2IBsxDoWBsf5pKjiS+hUzjEHbwg8WDV/MG92erD6XXOSNvBSSUZ38PFC?=
 =?us-ascii?Q?osN0ipe/VWTlsGY4uCMUl4EDOFswBlQuyS1fJ05vFgz/sm47tLZ77Maueozr?=
 =?us-ascii?Q?iPZ+9CywC3f/8LZb2e1KRlytDl18ohQvEiEcQdSd2vuIQqq39Va7AOJgSB3q?=
 =?us-ascii?Q?SDeDO3ZUoxClf5jqZ+YgBNbFyBGsiZl8QdUL8hKsm6iB/QhK3vRMLqkKL4oi?=
 =?us-ascii?Q?6wAw1yGGW4w3j4pbN8aS7mQWx2oY6Gjt7g/SQY+w6pN8qFMZwylUeo47QW18?=
 =?us-ascii?Q?SUe4smj3BxUFhLn6iPbpa0UT8nV2JwgBsjZMTgOTB8J7Q1HZ/YHunZZSYgF+?=
 =?us-ascii?Q?I4+CeIasmIj5NWKmNfYfUs9/2alVM9MdZHojO+BHHxU6awPv871YSIarj4dY?=
 =?us-ascii?Q?ojIBYhn49Z18jQK4EOZCVRDLkoH3XMYWb6EyS1kkoTUYdEquJBxKunhnueju?=
 =?us-ascii?Q?YtJAeR0Q7pdyFPZnlnxWXvXB8TLskMuxBk0bcQYGKCt8B1nCD3AHUiACKbSl?=
 =?us-ascii?Q?jRcpuUeNaoU9W+Oo09OLRNRVWnjAGDws8WaOc5qszOEKNLgMqy2z+iCjlyRT?=
 =?us-ascii?Q?MYQxSqk=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Szzo1aXY+lHnIyJJ3cJu4Nyhu8Bo1qrRCcudpBJ6PXIzynyJUA4BByVSyElG?=
 =?us-ascii?Q?yO0MCLoChL9NFn0ihU/Y/z/6aOhBf3OD6iH3aO9Ql/xVE539MM147ZBIfHIj?=
 =?us-ascii?Q?f3wI/bfZqy9Rlc7rHTm195vS5s1ybKHV89n4i1UEvu5bzGGVWeS6fHTQJAcS?=
 =?us-ascii?Q?3WgT9S6vC8/nA8ygyIkeMOORDRSvmCPC5mm7IAUfQV5NmtKrWWl0FBB2kbx9?=
 =?us-ascii?Q?mRf7j+VSD4UfjhTiugQD7vLs+LuY4Ya0PWMDCz/Zpo8tTM4SFkDqYbxmRFQs?=
 =?us-ascii?Q?3kZTz/31fwVZ4nzVzdnjKz6dEfziI6o4nMrGpaypKJfgEZqbPn4GiDQjLxQG?=
 =?us-ascii?Q?5j+tzI0VcLr7aJk4x4fjBKRsEVb0obwb6I0jdPG2xkr2QBEoOzznDv6qyoWx?=
 =?us-ascii?Q?Wwb1Vv+t2L6kPP+GP8fr8b1YcyevlF015cJ1SH/GuDTervN26mbDCCacfjDT?=
 =?us-ascii?Q?kc87toLPteQCzEcLPmB5SEClPdTvDpkJd5dk63h1RV2BVazCZJoL9tkbdKbm?=
 =?us-ascii?Q?Yef2l5i29WdpQwQqw0u1yVwhlYX1bqWrGm4VFvqaArJ1TYeJ07WkLekwl920?=
 =?us-ascii?Q?HP5hKnrenKv1ONC7n5Umet0E4RfSVRaKYlgLIr2Oho5nWkx/Yn3bnUok4ROq?=
 =?us-ascii?Q?46+XkhklJhsz8OfQEIOtwAbhMX4hghrWrK78II3nm529K0ekRvpzz99Monz2?=
 =?us-ascii?Q?5G5inwfO4hTPXvNICHUdacVrQHraA2yXP29iv8quQKB5UxRCrLy+rrJ8uwTX?=
 =?us-ascii?Q?8jRPpSh+nlv6IUzX3AGUBNZZluT4auTBr2Fldp4H6BPb9OyaaNDB27MIDboC?=
 =?us-ascii?Q?RWL4ST+dJ61ekvliYpXwzteg4Ns0xeOWzdfuyQQa/ZVgV1zAlu7NKz07QxPu?=
 =?us-ascii?Q?nFIt+YcslBE1lsTCAnzjDADH4EOtsGdbWgjYfo1Hmo5A4slRj4TaWTd4x0KG?=
 =?us-ascii?Q?pZzLxaHYY5B+JLE+V6yft2gBFh57Tqmwar74jOJ5RDnyJnH7FszGcxm06trR?=
 =?us-ascii?Q?8WUwwGCb6GNfZPSwpnVkAbMxWtAhTBOYEEXO3yh22YDJZ93/5oY2c7z/mLpt?=
 =?us-ascii?Q?KvYwf18ClkTyezbdZhNrgjPG3QeZ0QzMgaWF8kCuen3Go7jfpzFXB5Vfx0o5?=
 =?us-ascii?Q?uIJbvHND+86W3pJf5yyi+KZ2cDK4xqutGllUpClCMV/xZzfcPqP2rT00qpho?=
 =?us-ascii?Q?rvmUnlDY0id8nda7fCJss4cJGQ/DUecOmAEIrMyEc7MDiQu/TEfrvNr41Pjg?=
 =?us-ascii?Q?lZ+k7PIl4Wt3egTAX8aLYJa4TDGYQxRLmH5+HCLRhrnYuGllVDWZorLHmJ/0?=
 =?us-ascii?Q?Zl2xMUNEhPUa/c+Auh+1NfOKxdlTPEdHGf+IPt4IxGAi7zbJCL+GNIBu5zt/?=
 =?us-ascii?Q?bD9KeMxMYmsIS74rxC4k/PH7hazXgJI8kn/HVt1YqblwDrLFpdlP1QDpSDhE?=
 =?us-ascii?Q?gs40YbAvm90L9bY0C3i7DjQfXB/kLnEpLn2PLLdcNbhIWsB07PRgC6dOeB8C?=
 =?us-ascii?Q?b9VIIjEavB12tI3VszFkSB+7ZSPqA9ZSsNM61wiHwkx7e83o7C0kGC2mJYmy?=
 =?us-ascii?Q?m+BdIsfkjXQjzmn7SHEH5R9FmXxW6SHYsWAqB3o3?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 53acf24c-a391-4afb-9193-08dcf6fb8481
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2024 02:52:09.9679
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4szeaGPHhfc7V4gLlrkUTVGVkxlHfkurQHpnDq92IAr+uER/lzpS9AJwtxRrcq4Q37yisyvbr1KD92qRHnuoFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5810
X-OriginatorOrg: intel.com

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Saturday, October 26, 2024 7:50 AM
>=20
> Add a new iommufd_viommu FIXTURE and setup it up with a vIOMMU object.
>=20
> Any new vIOMMU feature will be added as a TEST_F under that.
>=20
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>

