Return-Path: <linux-kselftest+bounces-20903-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDD9A9B4413
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Oct 2024 09:23:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05D09B21B40
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Oct 2024 08:23:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38FB82038BA;
	Tue, 29 Oct 2024 08:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k+3XnVxM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 388DB2038A1;
	Tue, 29 Oct 2024 08:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730190169; cv=fail; b=ENhAd5mFhyTZS0iMhlEZSIR61on24am2w2KQTAob6DTKB8LKNBUcqWxr46qff3B3y9uFD0nJRtXxxKb7Ne14f+tTdN16zDunzQrrHPSi9KWaplR9cHpUAWcwkR07HHhbzPeUlWP2fzHDpAEB9xafvUgnG5K0rmgGix7duGdcHos=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730190169; c=relaxed/simple;
	bh=8wO+GzXUyK28vMBX4kkfVyBrHDFKtLqzmO9FlI/yyWM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=G0NfW1fi8mD5vj5vf1wgBXa4AU0CoIFoIfne9Wa7kyU2kZw439hvu29uxtUTyJZAXHdNE4xRjrMSuPVBKzF1fEu44+dmoTmtpNJKQyTxCthJWSMFvjFIGiUBILsA+qqIxdNq7MQ6uSZVYRKmajnahRAAr++HUCOS+ZHV72fpgyA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k+3XnVxM; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730190167; x=1761726167;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=8wO+GzXUyK28vMBX4kkfVyBrHDFKtLqzmO9FlI/yyWM=;
  b=k+3XnVxMhpHqvFFvSgigHpIlLUedbN9FvcJIZf4m17ojrlSNeQyxy2Gc
   79JscoZv+7CPHcwVEnKfs6hTCTi4AyDhRANmykglfhfjYrqf3qr4G9qSB
   iVL2VW5geRNU0T3Ps0VewZcinFn6qTV+V5HayVLDTaou2xGsZfNos3+UH
   5IffyWEFvq4TRLXWXZYWrcEFEpdYc/opok9O7exQZ3psVjJjSParCTcIg
   ekZYXqkh/DRuCCUh5x5JUoUQqSqs3L9kKxa9C9RbIrYj/PAtnZOCgH4yC
   AwpR5bqyAN3qEBs0B1Qw6k07g64NSO5A8+pBYm/V6/cbT4cOq/vniY7rh
   g==;
X-CSE-ConnectionGUID: OaiiiUcmQV2E9jUz3VLTwQ==
X-CSE-MsgGUID: C1iuD7o3Rp6b5ZAHLAQ41A==
X-IronPort-AV: E=McAfee;i="6700,10204,11239"; a="40396914"
X-IronPort-AV: E=Sophos;i="6.11,241,1725346800"; 
   d="scan'208";a="40396914"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2024 01:22:46 -0700
X-CSE-ConnectionGUID: hnEJib28RYG1kvQcStLCXQ==
X-CSE-MsgGUID: NOnPU4FnTwulI+2FOVtiDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,241,1725346800"; 
   d="scan'208";a="86493269"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Oct 2024 01:22:46 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 29 Oct 2024 01:22:45 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 29 Oct 2024 01:22:45 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 29 Oct 2024 01:22:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G2rICtUhXkrr3krUML1HV8IhKl8Xe2njR7kBsf0ofvUA+ORSDw/bAe/w6lPUNZUxY79/6glejOytFzDcnm2KMF/XzDMkjxV6XX3GDcJG5DWANGHWCwYnFTOs1ktYYwcE7F5kPx0IVv+h2oE5hhuAiBpRPLvNlPkKvkEofkDNnXyaJadReKqo9hzRRW+G/3pAOI22pBHafuDOI4AuB+2tJN+HXQu1CW57+eK5CGt08Xc4dMxH11phcT6FqTqvGjUYgjtCaMM24p5FkkwhVSuVbWam4oB7tDA95x2qc0bZ0FZhFUFk1dloQpJl5Q/AG5Y8MdiUUln2MOwkJU8C9jZ+LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FtJhPIjhSOX3qqrEzaFVuH9DXW4Af+0YZP5X9Gj/izo=;
 b=xx2lKmzFb3Yy4XQec1IDpeMXGBgSTpxOh9kccLbr7q6lk+jybW+Iq9awGPcQ0/ag0oOycX0HMJODRjUDG+cJSppUpL1+CkIxWuRIvDoOpO1+nf89nTEXLnsy9M2hdwyqLImife34w8MlphNYzloNKZsNWqFIomhO9QBhTLfUXTUYMQidi7mvci2Rnb5RzEBAkdZnlyrl0lthisxRHNCQrCOyeWNFJ6bRLZ9QmyMJehUj6/s2+U/V9fE6VXFCsClJ/UZZgckGtPziIvmX8CGUAyh4t+nkmCXqNct0T3I1t8uVa5aMIv17s1Nbh35H6KGq494f3iga9o3hkX0qCCf6zQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SJ0PR11MB5133.namprd11.prod.outlook.com (2603:10b6:a03:2ac::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25; Tue, 29 Oct
 2024 08:22:43 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%6]) with mapi id 15.20.8093.025; Tue, 29 Oct 2024
 08:22:43 +0000
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
Subject: RE: [PATCH v5 04/13] iommufd/hw_pagetable: Enforce invalidation op on
 vIOMMU-based hwpt_nested
Thread-Topic: [PATCH v5 04/13] iommufd/hw_pagetable: Enforce invalidation op
 on vIOMMU-based hwpt_nested
Thread-Index: AQHbJzjNUAV67+f8cECZZB3t9YlZFrKdaC0g
Date: Tue, 29 Oct 2024 08:22:43 +0000
Message-ID: <BN9PR11MB5276EC0C0CBA3AAF700B57238C4B2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1729897278.git.nicolinc@nvidia.com>
 <d0cae90d891d93f4fb45731a23697c06581fe434.1729897278.git.nicolinc@nvidia.com>
In-Reply-To: <d0cae90d891d93f4fb45731a23697c06581fe434.1729897278.git.nicolinc@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SJ0PR11MB5133:EE_
x-ms-office365-filtering-correlation-id: 67be7ac8-b5a5-43ef-a7a1-08dcf7f2dcae
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?iZetMul/qBWX4p1/FH5he3B8EbHR5pR/o2LxI7JndZ1U72rSKcrriCtNap0t?=
 =?us-ascii?Q?iz+qKEhsk32y+PKDGpyRdRDZc3yU7uXaDrxFFanyOOWJMF6Jpaw7GHrCB8+Q?=
 =?us-ascii?Q?c/Vv8wOSctRY1BqkoVxnQv+RR5td75TMYbRp2OlYV5v18A2pqgmcI+4LmM2D?=
 =?us-ascii?Q?QcAy0Meq44hF15FInH5huRlwdkgrsHDdrfnwm2T6t1BHF1yCTcK2Fz4Xrn+i?=
 =?us-ascii?Q?YPB2YSprELriohgNW+oIaZDSa7Aavo8f+AbwNF9ROY3pkXw23FC66b4eHbsL?=
 =?us-ascii?Q?3d2YJLuT/VK9/For3rpTcpwIt87Uc1iWSHLO/1NFPkfN/WlfLL6XZXF7D22F?=
 =?us-ascii?Q?wqRw+LyrIrpfqEcFxCiPnu0TtpUgINh5m3/C3HCHxSGcvCucF0fO2pWzc/Ey?=
 =?us-ascii?Q?xc5LcJYQQVdJoc5byL2QaqlFZ09BvXP7I9LwhqYwdRjczJzdJ+p+vF+8HJdL?=
 =?us-ascii?Q?h1peAHMjcHpXbuUuDqSo10cUZd0r9jVOwt0mf5Kmm+yyrN6IbhtBElWOw6uJ?=
 =?us-ascii?Q?+XsEBxiYSjx3FmxlCyB7IcQHfVgqgOzEXuonCnP+x+Xpev5Z6vGGCVjlF6JG?=
 =?us-ascii?Q?AvZWuBQW4KlH/6VwrIjqbSi/+qXGvcY5Vw4u6QaRFgGo97SQEooV0EYxzy/A?=
 =?us-ascii?Q?tbfLoqmPtpExN8IMtKnoQ3E5xVq1d7Ax3YlTD7o+2oMh0aBMClPct8rnJEvd?=
 =?us-ascii?Q?X7NiHk7LC9Pk92eqGrZq4nfZZh+1w4Kc67aQcLDKrBTqpTA5HRQMcWlGJagS?=
 =?us-ascii?Q?BXs9OARHj8Va0cNqbU1UhLPeyZ5V717A92POr10mpWOeP0jJpLggZfdEBjgC?=
 =?us-ascii?Q?p8T+4knpathylUzDdpm7p5ZNNWzRuYBymJiZKQrqVeIJffwwq2WFDGKoTzaA?=
 =?us-ascii?Q?8QzB2U0jsGBEiUt4QjitMTQM9fa4XLFxzwMu0XKgm0WNdcMeLmpH4cQiHw6I?=
 =?us-ascii?Q?VtOXdeZTmB41Id0yc6G90MmbBi56t1UE7Ykvet7iakyzl8+i+w2xmskRwmPm?=
 =?us-ascii?Q?usQbWO+kUuKCHMgd6qG9iZUfotd1C5RaJY/ho8zmOqxnS4SNgF5qUhcmO+/5?=
 =?us-ascii?Q?R3uby0lalLmStNRoEPui07FupqGmEnDSn5WmMJDBOzEveSSdD1hoTLZ7GI0x?=
 =?us-ascii?Q?a3Uq4CFz8WD6PbgGaHXInjdNy++GaKuApJOeuUw1Cb8kDlZhhzhTFcUqdSC3?=
 =?us-ascii?Q?9Ejj5TsgM92fn3Odi2BFPirQ34dqfljiAGEltgHcM4V+635Und8P5gfCIpeM?=
 =?us-ascii?Q?gUw+lkxnHU2WNaIOD3loyjE0hLW2AhOVMhRjAEjixYS3LFU4c7T2VnMCuxf9?=
 =?us-ascii?Q?uRA7YIV99ZBLYFFVAck5QYU505YUpgTECZ7e8U+58D2u/f9vzHtWnxJx04/+?=
 =?us-ascii?Q?cFEdl4o=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?0cDAS055JdRi02C9TIcI5Rm8BkuU4HUwHrbfeHH7LK70TWtWyxvvQO2kzQtX?=
 =?us-ascii?Q?RCo9eyOQD3eys5HS+VgMh71H4nS8APdrHIjOjqaILouDMHrgLrpt//ATIwzs?=
 =?us-ascii?Q?QjPgAMBPwKggAV5lv04KcaU4edgl0IfZrFUfENLi895b5B9ekF048eM4h8a/?=
 =?us-ascii?Q?sfpLQuuralmIyL8F6xlDyiI89TpXG7CRW824Tgk90p2exK2fD7CoxFfFjaFc?=
 =?us-ascii?Q?bQgYkUz3ipxzPCNyWcK/bYPWiiwirH0X7J6VJjp1JP7EK6/u54sPZyJMGXl5?=
 =?us-ascii?Q?+WGYaCMUgIpN1O3fONi0LgRrIBc37ibVO037o0MohfvtR16vhyMtnuvpijA3?=
 =?us-ascii?Q?puTkPwYsTYH1kYyameVGpXf9Uy6ofEIf+SXxOjfZ2O3tv/9m+DKoChEVnDVb?=
 =?us-ascii?Q?NyIGpJtqfj+hFmlmcJPq8tWpHu44L3vU9JcGTnTOekfZ9Fgyt7slT1mVogDh?=
 =?us-ascii?Q?9kQlHZleQwidU5JpZDjHGyu16HVeGH4Jsv1kCZ4p6vlWa43MJDK1IS9Uchan?=
 =?us-ascii?Q?9frOBaya37Hp/LljfvjixrA20GIFF/PIdR2RO/8tlluEZkdCLHgOcD7EjIMo?=
 =?us-ascii?Q?INQDE0H5fulwPOV/XX5diAr3lGCswipHA4NMQfD21HSQN/zjhWh6qXvKeQNx?=
 =?us-ascii?Q?9QkuBNUKbPcXUD7+QCkJFEWu7CiXyALHE3zseYbBiDxw5qsZFxOHcKWefy/f?=
 =?us-ascii?Q?ipEJ7fmZ0rFQdyoqTAd/+OIe7JAwnfPbrUJ9ATku5Mgpk6RJb89ql2RaaiP4?=
 =?us-ascii?Q?fN+vAP0XrkPw4pALc0tnFFYVQidLgOGp/csUML2hGSWITSmPGX4sQYztJKH4?=
 =?us-ascii?Q?3kFE0zS7eO25oCutqZ3Ps9THKCAFNl7lI7RoyWyCUBpcwedXxPz5IHxquCG2?=
 =?us-ascii?Q?kcW6qZy4z4j7HQU0avv8SX54aIoPfQg84jSNvylSDcJwqfdYac5xaK0r2R65?=
 =?us-ascii?Q?hvEiOYg4skeMi8wS4+5BmnV3Tkhc9/1T8mKwD27E6odnoH73kjX0NSl4l0o8?=
 =?us-ascii?Q?8EDQ2rIX0FuXJ096ClGdYZXXQ6yCU41soQmPcx9hoYaKqcsy1P0ms4mD5uoz?=
 =?us-ascii?Q?piH/9WEBoVRWgBFqa5Uiz+EKMYzZ5R8O9C21Qnb/mA1HX3sV+d7k3EuuEdz5?=
 =?us-ascii?Q?Dx8d217Q70SHnhQiam32Klpd+wsbKSqpF9AQ4HrbaepQYQtaLod2/+ToOEJB?=
 =?us-ascii?Q?qsXtUoA+tjWnXN/nLGbeCczgfJkjSoVN81q+k65I4NcB4YoqHSjPbvdP6Vp2?=
 =?us-ascii?Q?rip8uE8QrylchvxiL+96sy5/oLcpHpGqBCnP3k6OOYZk9VcuaIQ/sg3E+Y0b?=
 =?us-ascii?Q?nweF4r6MJYdEpsnskgaKCDrWiPsguKXYmIiggBOpvxKdMl0Z1K1DzHqtPnpg?=
 =?us-ascii?Q?oFCO4pCCZYqZYwhtYESQENNbLUQswn8tChrJvkCn1WF+f5PWicGNRLE672e3?=
 =?us-ascii?Q?5a0Emt3QSCIcC3jmjgsZ14gyekjNMuh2cEimSnZ0HnEpHTqPAR7wlT6ndZEe?=
 =?us-ascii?Q?DQ5pFHxE3OLiAgrcwntxmyqSCNM5nRp31MjoQlaTfe31xAitJXnxFj4hspFJ?=
 =?us-ascii?Q?BPGRpZCuE/my0hFGazlY5y74gubbmN3b/s1NstJf?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 67be7ac8-b5a5-43ef-a7a1-08dcf7f2dcae
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2024 08:22:43.6205
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OYrgtLyK8d1aEoGTLq+f00Xy49R78OfUVWXpn7XAbiLMhYSWF0+SP0OU0Aot/BSxgI9JFqubDfZHFjzzy8ipsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5133
X-OriginatorOrg: intel.com

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Saturday, October 26, 2024 7:51 AM
>=20
> @@ -302,7 +302,9 @@ iommufd_viommu_alloc_hwpt_nested(struct
> iommufd_viommu *viommu, u32 flags,
>  	}
>  	hwpt->domain->owner =3D viommu->iommu_dev->ops;
>=20
> -	if (WARN_ON_ONCE(hwpt->domain->type !=3D
> IOMMU_DOMAIN_NESTED)) {
> +	if (WARN_ON_ONCE(hwpt->domain->type !=3D
> IOMMU_DOMAIN_NESTED ||
> +			 (!viommu->ops->cache_invalidate &&
> +			  !hwpt->domain->ops->cache_invalidate_user))) {
>  		rc =3D -EINVAL;
>  		goto out_abort;
>  	}

According to patch5, cache invalidate in viommu only uses
viommu->ops->cache_invalidate. Is here intended to allow
nested hwpt created via viommu to still support the old
method?

