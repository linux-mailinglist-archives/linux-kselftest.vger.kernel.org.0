Return-Path: <linux-kselftest+bounces-46073-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 782CCC72A6A
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Nov 2025 08:49:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 4132D2A217
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Nov 2025 07:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F2D424169D;
	Thu, 20 Nov 2025 07:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QqD19COE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E62611C7012;
	Thu, 20 Nov 2025 07:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763624986; cv=fail; b=lXVKz+/IIM5/Pad4ZZp3SB924lhEvsDmwqBOHEF7BZ9lqNXxonBxMSEI0pc96EjT9yXqr/6n7GfPZdme+wUOo3hWhB0fmg3L7R3fbp+fkLQj4BmydDHYLPC38jtsLSfcjZRgOX/CCImtS9koyfJ2RC1PrJvnTRsQIb25StzIOyI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763624986; c=relaxed/simple;
	bh=+Nzvf7my1iueLtv/OpPAeGaalOa2f6AeSMB29A3bHeM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lA9wgJ13eu7liaumQLdg6+Jd8o5RitEWwlaeXToWAExQY+KcKdtvV/beW24vN35hOkGlTssTjbXPGmLs8jUSAeDjQnmWumyGYOI/ctp0o+nrA8q2YFBHUBM6+/noqVgNZtyViXxvStBwfcZHp5p5AN5eyae5UI8nvW78u7ve/qc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QqD19COE; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763624984; x=1795160984;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+Nzvf7my1iueLtv/OpPAeGaalOa2f6AeSMB29A3bHeM=;
  b=QqD19COEwJCpqz/e83AxG0lwjb+U9vy3Czb3FsNGl9q6NOYdue0sU7Yv
   FxMwHFEiClEgWX+KsiFsHxzh92tHB4m/kOiBBWX27LP4IvDHcP1qT7MbG
   pAOcl+6MW3zWPsIq3bZ2ljlHlUK3JxrZ8uW6GOsYabzq7ee356c5U9Ft9
   5yTVQg2g/pASkxfOgV2eJ/tM81GHmUWyjscfgrWZO21UOT3Uk9jBQzigM
   N1QJ9RgiVrkWJTbqjN/8iZvl9eKCO5QE0JUEhR1TBW7Eh0bTRA9LHPOiO
   m9rLR9A4gsxrn2yt8jH5qITAmq7P9dsWsa1Xxv9/s829HVDQU6FWj4ljQ
   w==;
X-CSE-ConnectionGUID: mFlwxyI+Q7K+hLbWlISHvA==
X-CSE-MsgGUID: S8cTFzkeSq+M3f69ZATEIw==
X-IronPort-AV: E=McAfee;i="6800,10657,11618"; a="76361416"
X-IronPort-AV: E=Sophos;i="6.19,317,1754982000"; 
   d="scan'208";a="76361416"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2025 23:49:43 -0800
X-CSE-ConnectionGUID: ei71bP+1R2G+o1XJV57zoA==
X-CSE-MsgGUID: G6N4Bsc4QmOUQgdHVUI5xw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,317,1754982000"; 
   d="scan'208";a="190965619"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2025 23:49:42 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 19 Nov 2025 23:49:42 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 19 Nov 2025 23:49:42 -0800
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.11) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 19 Nov 2025 23:49:42 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HlyJ2L/FjA3kZ2AnmvrQkVHf2161VP6RpjyMNl3cggnJSlrwB9henDy/fLoqCiUkEKlQHhAV62KO7Em898QRvJltXuJQSV5hhfaAW1OEBIYlDD0TVmZ7o+lN16sg9MJinCaa2IGaEOvqDMlOnwvTYulR6qcQH0C7uLN2xMIBdSOzT+RxJCmXZLEwLXGhBbeiSKiEte5w9eqM87gZg2d4iQmj8EpAnGoalZmoE7K1589VJrMcNosg7E4LXYFLcsyq9+2fJjwTmK18G0T5Ct3KfitXwnr8Yjtd/c2cTsqGmkEMKnTOCTSkqr35UYgBra8qLd6zT0XElg8o921mHZKy1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mMVhUPCoUbnUZufXv98Va51xCpLncgwWg4QO3NVZD7o=;
 b=YVpwdR3A4sb41Y0awd7BPR8EkjFCOjCi+l5DJx5P1D0CjrZ/aN6mR/avAC0Y66fUyms64jQ4TZZTaHoorK3elnAoX6qcZqTblXgedda7P8q+EVDC3hkS4Q3hnqfpgq1HJnmW1mgsU2UmSBwIHoK3D2oW6kYwuElzA6r0bL5CLe+zqnfuop+KXv4AxmmRfLqAbe7+A6Hw50lxHeWLO0kj/xgrsukss/1BMwi+EkfV4xZKQRY3Aw2QQanfj6HYbusLHdQz8ChZBWj0HNHACWIwqi0z3yRl9mk+PAquEoCHCzrecs/j538GeZzDe2SxQlPuC/3Bmr9CJXo5APtPZpxQNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by LV4PR11MB9489.namprd11.prod.outlook.com (2603:10b6:408:2e4::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Thu, 20 Nov
 2025 07:49:40 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%5]) with mapi id 15.20.9343.011; Thu, 20 Nov 2025
 07:49:40 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>, Alex Williamson <alex@shazbot.org>,
	=?iso-8859-1?Q?Christian_K=F6nig?= <christian.koenig@amd.com>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, Joerg Roedel
	<joro@8bytes.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linaro-mm-sig@lists.linaro.org" <linaro-mm-sig@lists.linaro.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"linux-media@vger.kernel.org" <linux-media@vger.kernel.org>, Robin Murphy
	<robin.murphy@arm.com>, Shuah Khan <shuah@kernel.org>, Sumit Semwal
	<sumit.semwal@linaro.org>, Will Deacon <will@kernel.org>
CC: Krishnakant Jaju <kjaju@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Matt Ochs <mochs@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>,
	"patches@lists.linux.dev" <patches@lists.linux.dev>, Simona Vetter
	<simona.vetter@ffwll.ch>, "Kasireddy, Vivek" <vivek.kasireddy@intel.com>, "Xu
 Yilun" <yilun.xu@linux.intel.com>
Subject: RE: [PATCH 1/9] vfio/pci: Add vfio_pci_dma_buf_iommufd_map()
Thread-Topic: [PATCH 1/9] vfio/pci: Add vfio_pci_dma_buf_iommufd_map()
Thread-Index: AQHcUAaPRHdOuxW1NU2WkK6IzuFHr7T7RBNw
Date: Thu, 20 Nov 2025 07:49:39 +0000
Message-ID: <BN9PR11MB5276F64B32E92D048F46C3B98CD4A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <0-v1-af84a3ab44f5+f68-iommufd_buf_jgg@nvidia.com>
 <1-v1-af84a3ab44f5+f68-iommufd_buf_jgg@nvidia.com>
In-Reply-To: <1-v1-af84a3ab44f5+f68-iommufd_buf_jgg@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|LV4PR11MB9489:EE_
x-ms-office365-filtering-correlation-id: 620ea855-4d7f-4c11-2b5f-08de28095c46
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|7416014|366016|376014|921020|38070700021;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?g623rUtU2LUhYc+M/lcKTACVrxdg8Y/9MZAegBsFD+1adN+5JY1LWkkjSX?=
 =?iso-8859-1?Q?CQobfdIzZWTGWFg4Od7MKe7+1g7y1aMnL7nsAhWTBt+t9obHJgC5fjJHIg?=
 =?iso-8859-1?Q?+euF5ksb4l/Ng+U44pD+VIiiPPsOQHEwqJ1FA+D3NZuEb7GVU1PaYG8GRc?=
 =?iso-8859-1?Q?UglbuLcbS3PZjAcvhAZnI8jIw16ekhncHu9h3pd24AHKLGeVLJtmp8ygRQ?=
 =?iso-8859-1?Q?GyzMa4MzXVObVhz3mp1FuLVM+7/3Tvsh96QeptpyyHdclrhmXa9A/zND0J?=
 =?iso-8859-1?Q?ZHitrevCFpAH8jp3RoGSSPYohPH7vDqLoDaUj33JUS7lnmJFSGBkbVKA21?=
 =?iso-8859-1?Q?HBmwnM+++MDAJT3HMDyeTI3zxViGNNeqbDXPukZA+Zl5Yl1eM8EXu4Dr8b?=
 =?iso-8859-1?Q?YJkaw1ldn1F1PNMxOjpKIJtzkL2oUVNl+Zj75TGKS2dOcL2MnzNbQBw62D?=
 =?iso-8859-1?Q?5f9qW9fCpRDQHrrEg//Pc++Q4eSE3vIxjeMqhsabkwsy/p6+FKTUcXAZmH?=
 =?iso-8859-1?Q?RBHv4uMZ2zG4t/6wCVJwdqW3FtYBvvhZwgMxrBTLnWsyKbuDrzl87r6U5C?=
 =?iso-8859-1?Q?cVhIG2UQSdeFAZd9u1ksf5diDNx9Yz/Sl4frHSAqoWk+QjcVZBnwHjDsK2?=
 =?iso-8859-1?Q?QKPb0BltEsWrD+61e6jZNRxvR1LIM0wF1f8lxGdG5DzMtEDqwHcWAmeiP/?=
 =?iso-8859-1?Q?qJjKzOzziGq9pSF2u4nHp7a27R8APgHSsXJFyZVKaBgwkPNCxCmwHyVjkb?=
 =?iso-8859-1?Q?L3EWhasAJcKmkDYWipCOkkkIogkT38ffXrU06yhUIYyyCWjtOLlpT6pGws?=
 =?iso-8859-1?Q?2gO0HvsER14hRCTnWNGgucaMHSH8YpfI3fwyAn05M23vZVQnjLAc9aA/Hx?=
 =?iso-8859-1?Q?xWTOGnfyJT/ygY6NwFWCYWcHoITV7L+Fa9VdPQMPxa8XUktOUZVnFUmCHV?=
 =?iso-8859-1?Q?9mk5CIpW9zNKFsrro2PL9Jv9WZsVG5oUyryWORYoH63qY4UZRVuI2VXWWw?=
 =?iso-8859-1?Q?UHJ1ilxcApftcM0faNbSNM7CvBduBI84SVKkUIpd9FO/AsmPaWIusMNqfC?=
 =?iso-8859-1?Q?HPpkC4eiLECBtZWojAFfwKPRl+kkh1fux2JuZppgxiqo3GmbhJbzEaltn7?=
 =?iso-8859-1?Q?R9IeqYI/4w2OAI3tVGnYIYO6Qr9I/7WtKFmMxQbJdo/dB5kPgBH16+7tK6?=
 =?iso-8859-1?Q?c6T94BeTcjYQjOzHOT+XfAblg12PF7YdisIBv42GGaq6TQhK8yzGlVTEQQ?=
 =?iso-8859-1?Q?HmWgG8gj2AyMjPtrLbRs4n5GV+N9MCJEKBefDfEFDXoU+vAwcLRzCM+uLI?=
 =?iso-8859-1?Q?2W8k+HYyf7cfwamSjRfA+CWXte7Eahyos9c6Gliuecwehmvd6A9SSsUW4o?=
 =?iso-8859-1?Q?iNPcBKojaRpQnHDCvQYRNiUPWH7nQtslokgime/lB8hQky0aATWrl83Zpt?=
 =?iso-8859-1?Q?Msaz5y0ieAu3tvs5phs0mub3VYndNZU+HWRpUoyLPo2qL54RlsF1YaLXy+?=
 =?iso-8859-1?Q?P4dYrmtyFDaNl+CDuwomFWRt+DVqi+RoqIYPV/6DNpKQGIftQ4Lc9Sj947?=
 =?iso-8859-1?Q?iPaY+yUNIPu5HJCQ9WXSKCcsMgOnCrh/h1/+QnqGilCYd+EttA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014)(921020)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?UHjcryLLZgDCkt5L29LDckpcSGMGoUmd0jVq7rEwJv5g+yBmoGKuW/N0D9?=
 =?iso-8859-1?Q?3POopY8WOf5xEqRWob2gknnbq4rlsgAmtTUw0Ji2GC9f4eWdIWtu5sme/4?=
 =?iso-8859-1?Q?ww2E4RrC85zwPlQjK9pFwk7r+o3GwjKdeAc9ECmCIQ6gveVh8bPclG0t+D?=
 =?iso-8859-1?Q?7BR/8P0CdQd+ShBfbfLQq2OFy2AHwH91yIpJWyDwNoxmTvdU1Kk2NdU8p1?=
 =?iso-8859-1?Q?g6hJYnM1G2YJF/u6Mveksy1ErRwgB3vk++TyaC087j/sMTn6q8W+M9FeH1?=
 =?iso-8859-1?Q?GXgqOTorRiebeRqrGUKN9xccEFsTTOVKbPVMdL3BvZnuf6p6msy5QPz4ff?=
 =?iso-8859-1?Q?9kOgeGdVyWXqSmGBistAC8iCUCG5hQmaztAxRMaeCzq6Jm+gJXCdtXH2Rk?=
 =?iso-8859-1?Q?ls7qHEzwKygAlk4uNRRN/mua+BFIUqcauE+u9xFgRm/N+0oiP3KWJHyCT0?=
 =?iso-8859-1?Q?1UgoGaypnaQT1n1h8jp5JBYxRReA7bPiioqSED2nvZ++vSfA8k9K31GAgo?=
 =?iso-8859-1?Q?7Jq25L5iInbVZ9DYeOQEDmzJE+Pwz12ssvhHfuKIwXYvOXi2mrS2OmWkZB?=
 =?iso-8859-1?Q?gGjoA7hwvwRD8JXvQajh2s6sVQBjNSNgj0EhSSFCT7tZLsK08hql7xQeCS?=
 =?iso-8859-1?Q?gPq8WJx8DEhplU4AqMdYS1Op8DHOftOWJkrJTPFqjquWy3dZ9DQfasTx8t?=
 =?iso-8859-1?Q?do3oOGCSpJvwbuwzqwNXRfAHyknk2Dxpcs+46gH89f7ky4dui6RLOS+Xt+?=
 =?iso-8859-1?Q?kAeuGEZdQHZz/2AL9mBZc2SjBgzdhlfWaKHrbXMAvGmNOwrKi3Y6zY30LV?=
 =?iso-8859-1?Q?jONt6fk8Ky91RKYXD2UEVGJw/PASWfT2LJSOXkqe9oSfpb2U2S+C3+7U80?=
 =?iso-8859-1?Q?IihlfS/a7pOTBZJq7qlcbB0bQVpS+eImrNheSM3lUhpquZ39+RJ+wOvJ+d?=
 =?iso-8859-1?Q?QBmROlv++dsYloOh3aTD1FpMp+nO+07SW1y4QC+9jUAYNAgS1oyJVPvbAt?=
 =?iso-8859-1?Q?kP3YrHLZeA+Wd/bCVu2aEdMWlVufOqmd0Zt5YuDaX43YHN/a3YZydET3t8?=
 =?iso-8859-1?Q?O+Y8TmZKz35vHUpE34fC4iQgzM4YZMxbirs2EnSqvCycyzuRwWnJIEFaX8?=
 =?iso-8859-1?Q?15zcQQ2eARjoo73eE/g2CdEPG+iOBocsbygi84InoS97IU49ThbPLDdffw?=
 =?iso-8859-1?Q?q39hg+X913fFRuJn7qksuTh+f/pQvLDhoktq52+Qvj50cQNuqzJclcKpiH?=
 =?iso-8859-1?Q?pB0fry9TsWMOvR90H8TRrXFGOuo0t9vY/bQljO/fxS6FZB54AHSuIczkHQ?=
 =?iso-8859-1?Q?NxOdaWHHFZN9Gj0KSeDEuSl0tnUXAfEwZ5vNY8syf60v2dNATGMcwMU84m?=
 =?iso-8859-1?Q?r1aAsbl8tV4wm/nZizWHu1xumxpgx5kGj3nGyXccimfJDyPxaBq19/Hbgn?=
 =?iso-8859-1?Q?Zojzl7NMyQ7Eo/Uci6vv7kMsOhR0qFpHvTjflhhRH1mEfEx5get4k08bKk?=
 =?iso-8859-1?Q?Wo4SP6dYZQe3U2b+dOqYeF2bYcU3i9SuHtbQXhBmzP85BqGZY9EiAiGNjP?=
 =?iso-8859-1?Q?cMKRw1ztTuFvHu+ETeEq5oxcPeZbiAkPNSSE8GAJiwZk2QhnXYB8vcUqlz?=
 =?iso-8859-1?Q?H2lT94aSwbbgkg07qSGcNNllqjOzPR/xle?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 620ea855-4d7f-4c11-2b5f-08de28095c46
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2025 07:49:40.0433
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2OYqgWrc+uxpcIbnChPT2+fNkZQMHa1ALaiwdeol8sbquxU4EgJUWVH9TnarduiZZ3/VEEC2yxoNsnagizYdvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV4PR11MB9489
X-OriginatorOrg: intel.com

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Saturday, November 8, 2025 12:50 AM
>=20
> This function is used to establish the "private interconnect" between the
> VFIO DMABUF exporter and the iommufd DMABUF importer. This is
> intended to
> be a temporary API until the core DMABUF interface is improved to nativel=
y
> support a private interconnect and revocable negotiation.
>=20
> This function should only be called by iommufd when trying to map a
> DMABUF. For now iommufd will only support VFIO DMABUFs.
>=20
> The following improvements are needed in the DMABUF API to generically
> support more exporters with iommufd/kvm type importers that cannot use
> the
> DMA API:
>=20
>  1) Revoke semantics. VFIO needs to be able to prevent access to the MMIO
>     during FLR, and so it will use dma_buf_move_notify() to prevent
>     access. iommmufd does not support fault handling so it cannot
>     implement the full move_notify. Instead if revoke is negotiated the
>     exporter promises not to use move_notify() unless the importer can
>     experiance failures. iommufd will unmap the dmabuf from the iommu
> page
>     tables while it is revoked.
>=20
>  2) Private interconnect negotiation. iommufd will only be able to map
>     a "private interconnect" that provides a phys_addr_t and a
>     struct p2pdma_provider * to describe the memory. It cannot use a DMA
>     mapped scatterlist since it is directly calling iommu_map().
>=20
>  3) NULL device during dma_buf_dynamic_attach(). Since iommufd doesn't
> use
>     the DMA API it doesn't have a DMAable struct device to pass here.
>=20
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>

