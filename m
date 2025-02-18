Return-Path: <linux-kselftest+bounces-26834-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65B7BA39293
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Feb 2025 06:24:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC1C63A68A8
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Feb 2025 05:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C0BE1B0F19;
	Tue, 18 Feb 2025 05:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BvsRf0i1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 868341AF0C0;
	Tue, 18 Feb 2025 05:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739856268; cv=fail; b=GmxZO56gxb+2tAHOEu3wTiRtp3yck8Ehrp8oYKVrh/MQFP/RxoTl7KR9khyEvUuwmvv63IWQCfVMukT6rYU8kHsoeyaJBMpUeG0pZ6+F4QY7g9y/OIrz0ESY5I/oarpMpdb5PJJqd3XHklRiVTfhOvSmr0dq7JcRvdJ7irh9lUk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739856268; c=relaxed/simple;
	bh=HFgXxVFwfEyNavnicJ3EknQxOggj8QvBURt7T/2hEqw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FB6n5N66I7W9EAthds33vitBQPWd6fMSXx19GxZVgHt9EWbxqnVAGBwL9uD/aqWzIE2HYztTbcb8dnsKIoItvcugpmdAni6k4Pt+EV6YgaWd+P4XxRNSr2GzXfdTMwtjH7DcYopXq8jZ3DxOQZYi9m6/pYB7hJLcot5qIZ65Nxs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BvsRf0i1; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739856267; x=1771392267;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=HFgXxVFwfEyNavnicJ3EknQxOggj8QvBURt7T/2hEqw=;
  b=BvsRf0i12xQTOVsPpqOc/dPfr1dgMkhQ0Lt/cSJ1oAu0QNnAS5XnlGzU
   RPpoLMFUkyygQ1in075ro7tUL4yA/ERWtjv2EQIGQoJcaKt2p/4npPidf
   QZmVUd2+2W2tubJ3gEXbBlBUJNkYnx/c5Umkrqx16ZXmtMaoddU6Auplq
   tKGd/4nOlWlFd3BDvM3Q2YlBBIKthmz5KU6uXixXha7jK5sRjE33b2sl/
   mkSJK2iqd/4W5vLSOxWXuYuSPVJr3t+CfBxqD5HDd50KO+Vpl1xJtdwVp
   II8t2Y9Xb/lSNl3trL0aGe0LnlHd089wvGHTjQLITPc4haBhhbwRFoHr+
   w==;
X-CSE-ConnectionGUID: J3Wcw3y3SMmkCLVNmBSZ4A==
X-CSE-MsgGUID: Kb+pskCbTIOVZCoNs2K1vQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="40405235"
X-IronPort-AV: E=Sophos;i="6.13,295,1732608000"; 
   d="scan'208";a="40405235"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2025 21:24:26 -0800
X-CSE-ConnectionGUID: ByMEcyVETtiCwV6i1QjxZw==
X-CSE-MsgGUID: mnh7xK8PQK+JGT3Rcf2GNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,295,1732608000"; 
   d="scan'208";a="114218875"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Feb 2025 21:24:26 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 17 Feb 2025 21:24:25 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Mon, 17 Feb 2025 21:24:25 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 17 Feb 2025 21:24:24 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P/pU30CMyqiKWUQpT1kzjnZd4GEcvhUS3GbCB579MvbyNQtn+DwmLWrNLEaKu60JZb6Xhcb5q9TxhoJAdhB2TxvKSIQKvSe+i475wZfRczPqpC29aTagGpMdtpF/Dm5u6IgS8uxjmqCEDEga8yA7Z7BAHHT12EZswv14J7eUlSD36JzPrvw6A5EoivaPHhHWrRCmPknQo+yJbMtLkGIqLNv5aGJfPg91oYB0tAcfq2iMJDbo+DtDxFkQKubDSWZgb1c8NiPzvvCbbJZNFs2+sYuHFOXAkgvmyPjASUCaPMBg42rabuQ/HwzcWkRCqLWNSpngYuUDq2JaDVVCMQKTxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HFgXxVFwfEyNavnicJ3EknQxOggj8QvBURt7T/2hEqw=;
 b=bb/GTmMlGCB+GIFXAe8o/zzTH017857nMxz8WBj88Odao04YDyl1tkKWFrvaML/CgLLKQPHC3S5TDpG93M/s3XNegy6wjObKRa3gZr5FsTAwkrlE21F8RFRNLlFlSrjdX2QmCQJRyiuVCB0VU2IU4H751B7PMcQpP3r4otdJCAnqZ5NH2ySEzvbO1Ag2d+X3ZAtdSIKKQw7Q6HBu3PLWgwo47rGrh4kKIIdL+vGNyiwcceLRLQT7v/lLADXGhdPrYwEsUqvuGa4IVZh4pIa3rxmf5wRUxuS2xykXFlmKgCAfDHVrV643eMhLkI3zKm7pw5YQ1CuZRFMw8/2KuoDNPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DM4PR11MB6142.namprd11.prod.outlook.com (2603:10b6:8:b2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.20; Tue, 18 Feb
 2025 05:24:08 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%6]) with mapi id 15.20.8445.017; Tue, 18 Feb 2025
 05:24:08 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Nicolin Chen <nicolinc@nvidia.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
	"corbet@lwn.net" <corbet@lwn.net>, "will@kernel.org" <will@kernel.org>
CC: "joro@8bytes.org" <joro@8bytes.org>, "suravee.suthikulpanit@amd.com"
	<suravee.suthikulpanit@amd.com>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>, "dwmw2@infradead.org" <dwmw2@infradead.org>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>, "shuah@kernel.org"
	<shuah@kernel.org>, "linux-kernel@vger.kernel.org"
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
	<yi.l.liu@intel.com>, "patches@lists.linux.dev" <patches@lists.linux.dev>
Subject: RE: [PATCH v6 14/14] iommu/arm-smmu-v3: Set MEV bit in nested STE for
 DoS mitigations
Thread-Topic: [PATCH v6 14/14] iommu/arm-smmu-v3: Set MEV bit in nested STE
 for DoS mitigations
Thread-Index: AQHbbsCFs6lMlaYX2ECY7z55PmzT+LNMrIOw
Date: Tue, 18 Feb 2025 05:24:08 +0000
Message-ID: <BN9PR11MB5276291C74E2DF0C8821BE718CFA2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1737754129.git.nicolinc@nvidia.com>
 <436ac2021bb3d75114ca0e45f25a6a8257489d3b.1737754129.git.nicolinc@nvidia.com>
In-Reply-To: <436ac2021bb3d75114ca0e45f25a6a8257489d3b.1737754129.git.nicolinc@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|DM4PR11MB6142:EE_
x-ms-office365-filtering-correlation-id: 50fb4ca8-727e-4178-9492-08dd4fdc784a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?xjbwI/41ezeHErJ4/B8sTliwv43AbQbTCLiRpEptM0DWpMqctAgbjadZylCd?=
 =?us-ascii?Q?a7QduaqD5xrtH6W7AHt82jCyf+pontZhHA3Ob7nNl4sfzJk7BzSvpEm6l2K9?=
 =?us-ascii?Q?Hr7h4GbI18NTP6T2pEWyyjHA7rQ5B8JaBLI2IKTcuAJfFa8tjMZSw+k/qmh8?=
 =?us-ascii?Q?9MCNx/KYnGxpJ0xLzekYgttT6uz5ujU1tBHGjXDWF3iU9XDm0LUmk1MUhY+L?=
 =?us-ascii?Q?n3vtO8eJi9n31swE+LoHxMjpmdipSFRvqIF9SMErpIY9GzD4mw8EJkkSnqqW?=
 =?us-ascii?Q?0zHSh+6M2DL3GEzeHu79o3LUHkUjTX82fbt3utS/zk/llnu7bWak2GDYnEoh?=
 =?us-ascii?Q?doSLE7Oyu4DOzEY4AASW+mmosmVZb8SP+m20ZX17bSqN/Mw+leARKOrHMNE6?=
 =?us-ascii?Q?kCwqN4pAfb15PizqeL38DtmvyRchBrQykQZ4TUeW8Nsq+IagtWtHyX0YH5c7?=
 =?us-ascii?Q?7IY5tD0Fx9advtvwqWS+0t6OjFvfJCOY1VIPIhAiofch/mhDGfH+u2C1S0QT?=
 =?us-ascii?Q?qx4hGl8W3BH1fMX8a2uHCkLgxzD22Phvp4y6VvBH+xn8Y95kK31qbwGEZBm/?=
 =?us-ascii?Q?HHg0cIKlII/q73tc8HGpEdVFK0tsMOk4/VXpFnlCJp62ecgRjbbqvUEKJk/K?=
 =?us-ascii?Q?jLy7m8b/t/8a2s8g32jY6jieR4sYHNSpewUfCde3lnbry3cdHDEvmPAvL3rn?=
 =?us-ascii?Q?GV+EdDLwaTXJdjQQkUSg7E2rHzB9JAjsqGL6Jl+2KsB3NDuzsN+hEf2ig1Xl?=
 =?us-ascii?Q?/DZaPjm4oL5SrWN4t2Qfi3kNlmfwxyd1Hs0yWO/shqZDxRsFIlDEjGX2hN3F?=
 =?us-ascii?Q?d0FDPihj3Z0c8U72CqgbpiRmtrTxLkUMPYPPCAlw2ttzrYkjrIBgvDt8qZeS?=
 =?us-ascii?Q?+bFDmQNqbN4/NYy2E8ry0DNmnvDstC4vm9NyHPs2qSFu1QWsAQMBhGNi+FIY?=
 =?us-ascii?Q?HQXw+9EvV2VrXNgHAvV+LmJyGfMUnAiZTVbVe0rdim2kKZoI74t3eC1Jb8FW?=
 =?us-ascii?Q?50VHkNDVIAWfW2Jf6R11DPE+PXCQiYJsSjp59ldD4EYCL1bEag0PRCZR34mL?=
 =?us-ascii?Q?EmhwYrmHYH3CtdolRERvpZ9oNVVp7O0RZSVWrPCfr9eRGEWv7CtA15p3uvNk?=
 =?us-ascii?Q?JwjJxMyhVEf2yQqD91E77jhHGaJmqi5CNLUsB40SDCR5f3mwxzcb5w1jns39?=
 =?us-ascii?Q?LlGuSJq/JEGfGuhh/SWyKDQEtTm3j3FyBWPKbydBnNgNuxmoAtk08YWSNiz/?=
 =?us-ascii?Q?O4z7K7D0cxyDq70b+WnFjGW79CEEjk7vgQQj76TvKwNuv0xUSm68tL8UNARx?=
 =?us-ascii?Q?gwvJR9Mt3VpdZbl1O9pp5UAxk9Vh5gSAmZ7TS0huo+KPx9l4BFY4eV2LKMvs?=
 =?us-ascii?Q?qNID8yrJdHwbh/xjIjm+Snrl3NnVhba8/eV0Mg9aI79BoV2UecH+80NRUIg8?=
 =?us-ascii?Q?dPdpe5d+p2fQzc3HQDjU2JLi0KK9E3my?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?wjlVcuJXGz5pYUT+lTlg4quY70sEO7KLR+TI0yJKjX0xl80tmyecJ6rp3eab?=
 =?us-ascii?Q?+hsNZk27i/y1VZ+QNyaZIY1kU0whZBGgfJm4foGq54tKhaPB+c6UzRgNfvQr?=
 =?us-ascii?Q?/dEtP1wAUHDZ+naARKv32SXiy+n+t2MGEReb4C+N3fujlEn6t/qxGUmuj/Q9?=
 =?us-ascii?Q?vTyWjZ/AfNP8UX88N7VVW8MOpW05DI+uOxiBOeub9d+hnxTLGdQszDyiryFd?=
 =?us-ascii?Q?/ltvH2VaSBXwsi3SwShH5E3iDRn2rO3EvmRhLXxhkrMeMnUpCleTZSFASuo/?=
 =?us-ascii?Q?abDYku+OvV1HYFvi5LjGRlGeA8sg0DCpW4OUfZy9rCZ6Oj3hL1Up3pERTyNi?=
 =?us-ascii?Q?zrHU3DTnOBe2trrXjJ8p08qMkEIC1hd3ctV0oI57L55sipPvdAvs7v+4UqAQ?=
 =?us-ascii?Q?58627pw/rdUF462oTiJs3GZoz+GIElGHXHN2UL6sOFhTHVSXF4ymiK4WEHuq?=
 =?us-ascii?Q?seT+Y8NBIvwbWc776fS4qu8Xqp/poGH97Y3LDCsnAv1PTDa1vMa2zsibAXYo?=
 =?us-ascii?Q?Ln6qBazjIpDvKRPdkG8BYEKp+XD/L44KwsSQCfSUuVfqS8mdtMf3bXet07oC?=
 =?us-ascii?Q?wx13eyaLk0uSDm1OnHyFVsZLDGF0E2xtFnI1Vh0P3AnVO1H8bW2j4jzYfSIW?=
 =?us-ascii?Q?HPnzODDypmqOmkSAxclJVLQLo8ZTwQC7hlDNtGh0OEd0qN+iHjQduccc6a/J?=
 =?us-ascii?Q?CzQAUGZQfwi0IrtC7VbwArUGrDzR0+nIRjuko0d9905pipdQCjm2fPj44aBq?=
 =?us-ascii?Q?ceKhza1nT+TTztgysB6v3ZxNuoz9jJ3opTGPpL7HMw3nWf3/Jc1aJt5OC63z?=
 =?us-ascii?Q?6XXz5l7jqhDsosiWu2fW2kUyiLA8SEbZp3FRsfak7vdWairdL0nx9U62sUOP?=
 =?us-ascii?Q?BkNytTogfYdoRrZdkwT5jaXHWFIP9B+sZFZNhNpxcC670QqWVIO4VPnUGkRk?=
 =?us-ascii?Q?z3zRUGrBkVj+N6Sc0I4I3v3Im3cCERoW9LMPOkdqrGfpBAOLVPb+lec+zsHf?=
 =?us-ascii?Q?11Yi28dkqUzBUsxyJahMI8JL+WNoHul4ou2UtIARKkAqm0o6pHf6zHfx2gMW?=
 =?us-ascii?Q?/RGH2sQJeVCUcayPH4ci3rcex7j+4VNm57X6MwrDr2Z1OS4ZyLATKJwRt/rx?=
 =?us-ascii?Q?CO6+24Ir+yS3dm64BOksKiA6csdc4G/UXm63gJabBkciTMVDyxE3Xp6nibWF?=
 =?us-ascii?Q?57FxYTnfYllh4DFnxIYxyeC0/xybROeQtyOBEZKMZWUxzG8UGaGOOdM0+azP?=
 =?us-ascii?Q?eVSiCZX9xWi8JC3vMXPseJwAJmHQiiWYZEyafZk0bwU5eM/8tABqLbcVAQUX?=
 =?us-ascii?Q?AEtoxheF+L8f3l1as3E4qs7egOEbageUOBgjPvKpv5lQdEFdkEQYxqUTg0yi?=
 =?us-ascii?Q?5C8Ys/g7i344NHD4OVb7ruIkHFaThUuNz/28h3iGN4NGDInR6JNwteOEwzUS?=
 =?us-ascii?Q?w0CYKyh9hfbaKR7ztZy6u5L0sC9tzTSAVfUzK47C4ZlyaGjUT+h9fK4qi9Mv?=
 =?us-ascii?Q?92h4HUXKdg3+KtVK4TvlGx+HU1Po5SuLLRcwk/hw3HRBpIqKBodUBVZArUHq?=
 =?us-ascii?Q?8nHDkMKpev4kppnmOsjMoEs0otiu4NpfiwA6ZUAZ?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 50fb4ca8-727e-4178-9492-08dd4fdc784a
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2025 05:24:08.6011
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HXRPC60Qo/FUiELsv12aDNeMB4detAKvbiansPT/zJP0vP78qSJXsF/GUYDxloNRamfIYeZtFU85ff7eLNHl9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6142
X-OriginatorOrg: intel.com

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Saturday, January 25, 2025 8:31 AM
>=20
> There is a DoS concern on the shared hardware event queue among devices
> passed through to VMs, that too many translation failures that belong to
> VMs could overflow the shared hardware event queue if those VMs or their
> VMMs don't handle/recover the devices properly.

This statement is not specific to the nested configuration.

>=20
> The MEV bit in the STE allows to configure the SMMU HW to merge similar
> event records, though there is no guarantee. Set it in a nested STE for
> DoS mitigations.

Is MEV available only in nested mode? Otherwise it perhaps makes
sense to turn it on in all configurations in IOMMUFD paths...

