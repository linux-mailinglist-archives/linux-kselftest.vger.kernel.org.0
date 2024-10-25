Return-Path: <linux-kselftest+bounces-20623-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 016D29AFD73
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Oct 2024 11:00:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84C461F2120F
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Oct 2024 09:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C86B91D3567;
	Fri, 25 Oct 2024 09:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ggvL/1nI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D9E1B6CF6;
	Fri, 25 Oct 2024 09:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729846820; cv=fail; b=OdtCupRlIK/G6De95deMo++1L1m0/AL1fQetBpGHzVh3FGktcW8Pr3FYjH2HkZLESC9yejvtmOIq7SzfUkuxm40Z1nTalBN5Ncu7Ib6ly2QRflgF+AaYC10uXoQ1ykkhZytzaoTCOvDy3PglPzETTHjmX1a5aWpB1Ron8YlnaZ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729846820; c=relaxed/simple;
	bh=ifxo10Zpp5/sazohbm4xqR6m+ht0jjsRCgaImPRjeJM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ot3ky0HKmF6gocnIaABzPdIeCQBTSAJ3faogpS1wF/rU4Ze6ic5tGUR6ZQnMQf9n9IiEXhMzf/gA7mNNZRQaqyK6psNEU2TFhJQ7IppKZTeIREjQef6ZqQE1STRgBlrVgGvIw6ZWbc+2/jC/Cx3A5DMUM+qRQaOaau4cJctFTwM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ggvL/1nI; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729846819; x=1761382819;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ifxo10Zpp5/sazohbm4xqR6m+ht0jjsRCgaImPRjeJM=;
  b=ggvL/1nIJhRktt4/3XCFVSqNmvhJTIyrncUPy7tFW/ZBmhyXYrxzGNst
   NmkM1yMiGFi24pQXZLtktIgzJdWshsK+Sx3UAE8dauWhKDyq/OH9qPneb
   MjnkHRjjrY3837QHeGngiTD1f36ztIq8W+kabVk3gjduYjf1tRhDmf2aT
   +yXo2MLgit5y0EX7KnQOVrqWMv3tj2BZtymW3ahWvu48/fTPdnKX/49aP
   UZLoJmkuJcmTb/+4BOJ6Qf04/+FsTZ4Cqeo7phDKJBAMI/9RjXvHZXTAw
   rFL8UBmg305LlPKVyd8iscCFYtybslOf16cmwmqiGl+j4loR4PLxyuSfO
   w==;
X-CSE-ConnectionGUID: 2lVfXWbwQDOW8A0I1qYyZw==
X-CSE-MsgGUID: 4ae75BQlTSa5wlpR/qnKEw==
X-IronPort-AV: E=McAfee;i="6700,10204,11235"; a="28963299"
X-IronPort-AV: E=Sophos;i="6.11,231,1725346800"; 
   d="scan'208";a="28963299"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2024 02:00:18 -0700
X-CSE-ConnectionGUID: PhFIgassQVydPj8WYWJcHg==
X-CSE-MsgGUID: bmamKMAoR2u1qP0HLp4PNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,231,1725346800"; 
   d="scan'208";a="85416783"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Oct 2024 02:00:10 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 25 Oct 2024 02:00:08 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 25 Oct 2024 02:00:08 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.43) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 25 Oct 2024 02:00:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OG+njwIy/bxugEbu2Aptw6xspR/SxREbevRh3UlE55nUsf86qsAwsF7LG0dQrn45H5Rt9k6Dn4aOeQrqbdMY21jP3Oirtjk8CRd/wS9nS+TXusJYQ3MO69L7oLbOxHtqwppYGY5H661ehU9GeZO4VFUL2LE2KbAty1iR+bTSFaWgGr/jja/kwKmgCOUFz+FrQlWSf9d+25GKSDAzm07+Irhr1sBlQv/7h5E9p23tWH0uB4528NHfkrMzPiG0kriGr+61PkiuPFN1+fMOgybXOxgMexj2Duilcj4YMGpb+D6XpjpkXpJX8EsOiwsMxM4wDuuXZUPKbl3RiZXLaT3IZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ifxo10Zpp5/sazohbm4xqR6m+ht0jjsRCgaImPRjeJM=;
 b=Kfci/P/Irb2pJEpLMk9PNEQ47MZabBeqPH8TVnyPFkpq1uIjiwdk8fuOEoc92+grVm0FfW7XrNTywDFa+cOVo1IjCSuoBUpIfn7NabxmJ9I8iX05ZNik0ErQKLZ0v4hu8TOoJuNhXWMEBOGEhpWN4dohYa7PRQq4YbgNWf7rEALB+XVkhun63ncN2zdu1Es9qi2PDH9/roYubfFSZDRKeMriZ5u4CdUHgzrN1ExOsqyWYhCjjOUfOWucpA/ZJQPDYaBzdB7+Lu7E5VDo0jGN1csAMffHyGlRNIuYyrNTsGSh+EnNRW+XRit/vk9Kciiw6+z/gAcnznYuGzoK04rU1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SA3PR11MB7433.namprd11.prod.outlook.com (2603:10b6:806:31e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.20; Fri, 25 Oct
 2024 09:00:06 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%6]) with mapi id 15.20.8093.018; Fri, 25 Oct 2024
 09:00:06 +0000
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
Subject: RE: [PATCH v4 05/11] iommufd: Add domain_alloc_nested op to
 iommufd_viommu_ops
Thread-Topic: [PATCH v4 05/11] iommufd: Add domain_alloc_nested op to
 iommufd_viommu_ops
Thread-Index: AQHbJBhEStT9b4gACkql+Wf5TY/XjrKXMESg
Date: Fri, 25 Oct 2024 09:00:05 +0000
Message-ID: <BN9PR11MB5276309246336B450AC4E9058C4F2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1729553811.git.nicolinc@nvidia.com>
 <1314e12b76edd84a8c9d0f14a6598538c8eeb50e.1729553811.git.nicolinc@nvidia.com>
In-Reply-To: <1314e12b76edd84a8c9d0f14a6598538c8eeb50e.1729553811.git.nicolinc@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SA3PR11MB7433:EE_
x-ms-office365-filtering-correlation-id: 240dba4c-a5f2-4b8d-6760-08dcf4d36b95
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?DBzATnCOL9gEAYz+Y585aPZaG8PsUVLJMSngg0cV7+OJHMwSBOKYTFHjW/Bp?=
 =?us-ascii?Q?29q6xzcY3KCQZ7x4Twmm6uiaOUTH6WyOKKm1Md7ugRAjeo+G5I/yHiCUKl1W?=
 =?us-ascii?Q?fiUGuDE1c5QPZcYmtRh0OqGhJDdWEebmTFh9rgWCmcaSXqI+Rt5g444bf87f?=
 =?us-ascii?Q?X1rxdZRrLQy3//S8vz0sutDu7aXuTYv/h4uTPN9JI1KBqhTa+EzUjl4tXErk?=
 =?us-ascii?Q?EQOWl2tfzMwmNz1QkU64pyYmfrD2JVmtEYJvLWf0X4rOe/h+EcCdMX02FmG4?=
 =?us-ascii?Q?YaFtX+l4yFg1ibaVyFgGHXfYEMCLssTTqAf0Z5Cj44ndWk8sNAykJ51WXkN2?=
 =?us-ascii?Q?izZkJE+I9pCvPxFiOfoT8KWBplWme7oqAugcrkH4Qgk044G7m9s1T9Wd/lRG?=
 =?us-ascii?Q?9daLTvgdpEe1MKsCKp4kgSBp5VfBj6Xv4/Xt4xHwBn9Ipn6rz2s8IojktJSm?=
 =?us-ascii?Q?K9rp6xrtE8JDN6HXTJlh+LTineDjAuCFMQ65EjsHUDkOB6rVTAd7pj7o25SU?=
 =?us-ascii?Q?zxZqdb27VQDsWQUpM2xrUxznBJ9eoRjWCFu6UB6NnsnU0aJO+tpwnUYRZYYZ?=
 =?us-ascii?Q?I/NnIHI1HGRUQdfosV7riS7NrqSl/NM7SFIwIZ02Cdel4KPg2WcI/+21f8SY?=
 =?us-ascii?Q?kzJ5/0By2qR0f9IHnHORLdOg59jhGezPSatGiTo8p5SSu4mZ3UrjexHv0diM?=
 =?us-ascii?Q?9wpSX+8zONn3ASJuH0MIIimEzUndKUrlnDK70dXx5CY+UWQ1G4hMwHzMvEUi?=
 =?us-ascii?Q?tW+4adahG4ofYqJ8lEUD+pTIoVveewr/4dzIX2Fm9ABxYt5OjGlDSIhtbwjr?=
 =?us-ascii?Q?9SsFfwNYrxfYvIIF3DLqkV30Lb3imgQ2fguiiiQ2zfaJVra67SnVKr8Kuh4Z?=
 =?us-ascii?Q?Z6ip9D6TxtFtJoeVLVuRWYr5kil+8MDdzIXHpABtS1jwkjG3NrYEhfJWz+6L?=
 =?us-ascii?Q?/8pwFAMSUguwwrpMam+B4D4Kk9gldcgNncpM46bbg+AX2sGMvY3uZXgAI+Ln?=
 =?us-ascii?Q?G8cgnERxtIBW6QT1Vbmy2j44v4eljV6VS4QkosWt3B8bV4oAjlILN5fttl76?=
 =?us-ascii?Q?v7eM9blfmhJGVtoqY3uDw4kbGpCVfGaIxQaix5clwj7MlQejWmVNgrUrLjiL?=
 =?us-ascii?Q?JlkvNZ7clWXT4SxBAS/DvFvYHlbhvWEKM+iiRx3/Y25dpFubkPA+QoEzIVYY?=
 =?us-ascii?Q?shtgklHdxp3cx3GGvIgqfdb+Chnc4LGAJrsm8Tgnyr0FIA9ENORoiEZGB0Z2?=
 =?us-ascii?Q?wuXZkMtqUFTyFqL35vOrvoaVehe34XMQlnVfuq5fG4CWL0v6fvW8aPDdmCcJ?=
 =?us-ascii?Q?gyE5X8wN75CKzG+XtrxhJnEvWZz004Jm8WrEEdfJF5LvS4gB5XD1VSuot6LS?=
 =?us-ascii?Q?eupUtSk=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?fieeJrey2OX3Lq0/CGF4HBdC7oY7PUuaYUKb2xICtWrz2HIn26CL1se/jo+H?=
 =?us-ascii?Q?eAtxuMejDlxKZQi4C8S2wZRdzfTQ12LgOlvTS4TkEJc2f2vPUNgqOx66BrvE?=
 =?us-ascii?Q?DYy1MaYWUKnB72ZMSow6XqmdK4PlFcA2FfPNTbPgH7kkihkPKUA3s7iy+qXQ?=
 =?us-ascii?Q?vIgRPvocNOeA89nNhVXbXAkdqBEF6XGxnDce3mT29vGPVTiaDd7pKVePX0zN?=
 =?us-ascii?Q?PEaR+GLwqWpSKpo3VMIIUPw+9q2Vuy5qlfAcvEnZggGYuBrzOonhSgPsRKIK?=
 =?us-ascii?Q?uBmZUWDX7P20bQsHq/7GAK7MyuVWmbUvu+/ZTckZ7BJpQn6dl8wCi8M37xd5?=
 =?us-ascii?Q?q+OLgL2PFnlxK6yrsABmcvge8W3hScuS53mPRtLFi2G2AoZp2T8r5bACfc87?=
 =?us-ascii?Q?ovBksaAQcZq7JpXpqWOjmhbHPa6SLDfnHjdQ1V8CmqDlSeWLNScthjkO2dOW?=
 =?us-ascii?Q?w8vNOpihQRvl7yzyP1h56RM9tb8+lGjcbvWa8vB8AF6j4O6z29FR1HPDzpbK?=
 =?us-ascii?Q?bawUbkxK3H6SJHYMnnC8lGvanwgbviGw3lBfoJcDAuMS3boCi/jqHVqj2vEh?=
 =?us-ascii?Q?bpnls/LIP4kY2QJU0Sa1xRNdWMLnEwQtOFlmaaM3qjtz4kW/WGyvQGpe2YPt?=
 =?us-ascii?Q?3grF0LX4807kjXQ/X83TwUSVG4dRaLRPp2uvLLQeoAKuLTFIxRZMmO/qCE3U?=
 =?us-ascii?Q?mUfWKMljqd9w31CBVqpA14DsvJA1bu1XEW942iZCtFIwhFPNPZZP/A1GBDyy?=
 =?us-ascii?Q?wAszCfMCnTQAweF1Fp6crAwV0t/+C75i5NxohLVgHRtv16l8F7xLOFMyCxpd?=
 =?us-ascii?Q?shXzZhLxWXN+YsdVBDo7bx3XmWuQjKXOhzdBu0490EFM5ehnm1Z7ExpFp9uh?=
 =?us-ascii?Q?q4yaDTQaYaJZOF5der4SILBv29JVzUGj1nT8Hvg2Y2ValG1aCBtZcEOoC0GV?=
 =?us-ascii?Q?Cr8leGiLThHuOi64ZPQ7DLF8zx7J7ovo++a4gZFqsxHDu0CRK/O7iJDcIJQw?=
 =?us-ascii?Q?cpEz9VAH+lbVMbi/qVgmDjPcoeVZcas+t6ansqzRFWVGFPfxPGqNenWYy6az?=
 =?us-ascii?Q?UTvNTFdBJlDqjfN2jMySt+q22CjK9QKkRlB0F23habT7LGO/dQ+5QERlPRZD?=
 =?us-ascii?Q?qXJ6cdg6nieq+jSeAhumCANzsA5kh0ZFQ0wRUPA6RBL1mp56srfzfrAFV8sJ?=
 =?us-ascii?Q?flH0e7EguJFESXycXGlxDOt2iVCwwLpuwtDHS7kXao/0BVCBGPkBhW2Mu/CC?=
 =?us-ascii?Q?Y6KcMvAKA6UX56Q1F+2HSlxonBqg6gvoGl6ueVSvyVthYUSgBDJeXyoEjXQa?=
 =?us-ascii?Q?8sAIjxZqmj3F7gFheu0OXUQfK0ldjTE3LaE7gdzViBYo/V77wSD/C6xkZfJi?=
 =?us-ascii?Q?9CyIDqm/mLj4HdDC/R6Cj0X5nmokpQfWvLeuiqKNYGt7eojCxe1+dOIOlIQo?=
 =?us-ascii?Q?WUN7hkMICF+pMwLfm7r9ucTHhXVKz2g1OIXo/sObhRNtxxpnadowAu2reBF1?=
 =?us-ascii?Q?S5dMx1j5Q4DQledmVKKUOcJuj5z/dlb6+tjKVjvlEryqNzdiUvA+MW+zbMOC?=
 =?us-ascii?Q?dPwYL42fog2ekolk27ZG64oCasz06ogJgzyu7C3B?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 240dba4c-a5f2-4b8d-6760-08dcf4d36b95
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2024 09:00:05.9428
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b5f6ZPzBnAd08LYDf6fF0qZzWF5n9RyUfcgAxXH3gTUu0hq6lurVFUWzoXlrfOW+YkqidFEj0ViSqDPT+mB9iw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7433
X-OriginatorOrg: intel.com

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Tuesday, October 22, 2024 8:19 AM
>=20
> Allow IOMMU driver to use a vIOMMU object that holds a nesting parent
> hwpt/domain to allocate a nested domain.
>=20
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>

