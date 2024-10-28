Return-Path: <linux-kselftest+bounces-20775-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46D269B2320
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Oct 2024 03:48:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A88F1C20C10
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Oct 2024 02:48:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 033C615B54C;
	Mon, 28 Oct 2024 02:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DNLMTPYi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03E1F42AA0;
	Mon, 28 Oct 2024 02:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730083731; cv=fail; b=Q+Bt5chftwzexBEHqmQyHtMXGwxiBYPsUgjn0IvA6J6IsoCjlIB1z7uNVvd6P0shaszk3/0/ErL5GmN9Lzj3TXx8OxSfjAVASsbI/l7Vexly4SinGuj5jH0hf3P00bfpe2lV5qjswOuu3O9rtZIa4uTL8Q/m1Re8j9ijKsf1AOQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730083731; c=relaxed/simple;
	bh=ys5/TLswavGyu+Y+geYhl+9mmzwniTEXjVLUYEhTGS4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SqgfkZrieaWNR8sJtmxeUUbO9GWaml5tLBcmM3FwEJV7QIMYWOrXFJ8Igkf2bi9ZpRhp/8KpKbL4Egh9UcHXOmrogSlEH8G//QP4sj7ems3S0d93W0CaXJspQkEOBgpOp3bXHa9m8mP/pRAb+8QTqVctJtWsa+EsoFd+8hgW2pM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DNLMTPYi; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730083730; x=1761619730;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ys5/TLswavGyu+Y+geYhl+9mmzwniTEXjVLUYEhTGS4=;
  b=DNLMTPYilByNscZScLiuPNLHHxX06sbiZomfxL3aqahR1MP0Nu3GnJYW
   EJqngJ3C5nimS2qc6HNGvsrVWVwOPPBKYESDckISB6EWr/5fmIdkZ4KR/
   AZbBLtPrgd5sdGznHJTn8a4hePNNAAn4Ai9LfjHALxsSirQEC0yDzI5wJ
   Y4BJ9C44rbJjFCuEuLv4Rv8Y4++vCfeNcsT35N0NkKiXabnNn+hcqAwW1
   YiY01Yu5AqrN7wG/clqN/1+7HX2wCWtUKa9ZLXxxNlk3VJV4QtY00D1Y/
   gIkwmwlB7M5DDKuQL/dZ66XCfijzNA8Bf7QFcxmttF27QdJfHOzVHp+/G
   w==;
X-CSE-ConnectionGUID: p3J7mFXQRg6HTbFwlN2HCQ==
X-CSE-MsgGUID: EGLsnImjQX6EPTkRfGJ9RQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11238"; a="41066741"
X-IronPort-AV: E=Sophos;i="6.11,238,1725346800"; 
   d="scan'208";a="41066741"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2024 19:48:49 -0700
X-CSE-ConnectionGUID: x6nWGz+OTGmb9N4hXPtCdg==
X-CSE-MsgGUID: gvMP+alDQz2FqRdGPBlmxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,238,1725346800"; 
   d="scan'208";a="85417924"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Oct 2024 19:48:49 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 27 Oct 2024 19:48:48 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sun, 27 Oct 2024 19:48:48 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.176)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 27 Oct 2024 19:48:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dp/o5mT26l3zqMxFrYjlnB91UBQ1+tI+HYoW2ZPI/LRPMgllRMPxESyVkPOYLUYiALM7AId7zqk1ae4XlYft1eaM0EuKWQMz5vw8cCNoRo0gaqLpseeD6tLqE6ikqgdx9j5Y6QjOCovyF4fLNti4gJ79d+E5/pjPYoJdAusdYvFA10wsuaHNxSAJphEaB/ozLymtPY9HPBZrDdltZz2bF+vmIRWthAfyloj4uUGVSjMl07NMLLwKJ1QbOSaCBXsGCxlC3PhKKHZbJFIr9aRsKIdSOKTqa4J+5aX0nQysSMveqIOVc+arY52JgYKY6Ow4cHIYDh8Fva6GIF/4D7b6Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ys5/TLswavGyu+Y+geYhl+9mmzwniTEXjVLUYEhTGS4=;
 b=gnjuSRxEPccQcKBPxxwxmqgtdfd1iJQRFM8M7aPzsaT1ykj91yPLmF6JRkQJYBnABqu3KdGc+1/0c0NmbaXHK5tukpSVHU5HlNgQDrwClLMk+F6/n99THHN4SMulN3iDC7SA3BvVkkPaK1rm1KbA2LiQvvkCo7MilReFuiAhwfp9GMyil7v3Tz7XyYjMOTJew2vaWskUEeMdt4LgxrRkXGtdZDWVMxiP2KgiqLLRS8gz12alqJ7dbENpXeZivu/Zzde2HXozTURBX75vPgeYFATg5I0ZKCgJ6uAyZyFU+odJXnI9yENh1Nj8lMfB6Xg6pCFJPzQnru0W4gr/nLgHCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SN7PR11MB7567.namprd11.prod.outlook.com (2603:10b6:806:328::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.23; Mon, 28 Oct
 2024 02:48:41 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%6]) with mapi id 15.20.8093.024; Mon, 28 Oct 2024
 02:48:41 +0000
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
Subject: RE: [PATCH v5 08/13] iommufd/selftest: Prepare for
 mock_viommu_alloc_domain_nested()
Thread-Topic: [PATCH v5 08/13] iommufd/selftest: Prepare for
 mock_viommu_alloc_domain_nested()
Thread-Index: AQHbJziyu7ovWSRFQ062mImzd+5hUrKbeUOA
Date: Mon, 28 Oct 2024 02:48:41 +0000
Message-ID: <BN9PR11MB52762CC1E19941B3F85A7A968C4A2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1729897352.git.nicolinc@nvidia.com>
 <f080c65265372b56942e6d1008ee114654a23f91.1729897352.git.nicolinc@nvidia.com>
In-Reply-To: <f080c65265372b56942e6d1008ee114654a23f91.1729897352.git.nicolinc@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SN7PR11MB7567:EE_
x-ms-office365-filtering-correlation-id: da7d0375-c68b-48c2-3622-08dcf6fb081e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?VvXRmCtuv1YB/SbzIbWAE7klAruicqyX9zw6C2SDeqWoHkU+dudQ+7kGB9JG?=
 =?us-ascii?Q?a/ScLxUhY330XkGHqtu3tpUQHf78zZ6zdnwTwAajp0FZZ3hbRPLXpKZ83dd5?=
 =?us-ascii?Q?U1tTS8YuZJI9icSIqyb9cKB1zeocpRKUJsvztJDdBm0hGztNaF0CBsR3MUF0?=
 =?us-ascii?Q?UcpYXN6OZef5zmXvQOdZJjsKxUwpQoVjRSxOWVEGg0dUdQHcVWUg6DhBD3lK?=
 =?us-ascii?Q?lfvN2KvqaqFW1xVOO1XpuB4v5TuV3Sb44pcFEmgekrnZoLjs55xgJ8WCMiwf?=
 =?us-ascii?Q?ZKVyWp+kx7un870KeGg6W650OYYxjgXVYlrx8NMXfVztMQFJI/jebRobZKOq?=
 =?us-ascii?Q?dTgQ5oAlS8PMHwFz3m1i1BAv+xS/3kaWI8ML75dikOuJBS5eySRROWQdT/6T?=
 =?us-ascii?Q?XDjSNQSqGWDbHrba5FQwaEuviT7Uz+HVGBcw+ViehffUK0gwaFJ1TfrtdySu?=
 =?us-ascii?Q?Uc40g4UDY+0dR1FBCv8rMr5MVaG+Yw+1PSKeFvdrpUNV48vUbxbYUn3A6Lau?=
 =?us-ascii?Q?lYNyFq/ALWGBFTy8Erlx+qAoHLFQ/BSEUTA6xV2zX0PE84sWM8Q9OYPjUBPh?=
 =?us-ascii?Q?Sc5itjNqJj2iVe/x/B1+rn68X0G8E3OAkIvrSR5C/Xy8qg3NZiLOHKI473pL?=
 =?us-ascii?Q?OEKnxmsO4IcIfqCkpjfbusqF6M12TK87z+hMuGMzTY2Z7EAZPEyGwBGNukc7?=
 =?us-ascii?Q?6upts9oELBfnIAp8XSYMkBAcHnY7ImOOzkd9/dJuKnmisHFPsvB3XDnV37Ba?=
 =?us-ascii?Q?vNC8jKLQGxE4vxSbvos0lyRhgndumF5bTrDdjt7+UfE1abGU7w3wuik13peT?=
 =?us-ascii?Q?DXRvdSQ7Ylcxywvo7+BnRmC3yrERT61dyVRVGnBX3lh5PBL1vjj8NKMzBHtQ?=
 =?us-ascii?Q?bBpRlISvpwdJm1v/WnBeww+BOTRlgv4bKtGGlVD79yKk+vAE71eDHBXiioS+?=
 =?us-ascii?Q?x+hfN3yU5Cojy12M8NqpbKmH4EcNd1lW/BLsHDOp7bO7tyWD5yqxqmCi7eXH?=
 =?us-ascii?Q?yY0jFwwgkbC4ZNPWYYZkJKxUESVdRaR6asp2dLh1Kb78fae6hDsgyA8Cxm0W?=
 =?us-ascii?Q?3Ow+gvsYwM4JeeUFKeKOduoXHPmwjP2dcz7zhy+0OQ31S13ywK/YNm9NAf7I?=
 =?us-ascii?Q?ikkpzDaXayCBz0Hg/HUReqh3/qmhAcshgM6MOeo2w3OH/FP2lHLizDvlndjH?=
 =?us-ascii?Q?Kw6rSM9KVoH4qLLK9ldNTTSyhnnVmaEeN+kPJUTZDSEalL2Rk6EChYP1ZrHP?=
 =?us-ascii?Q?8NoTz6xhfl0mbK0VGJ14+anrD5ARh+ZE8JtacBcQfAgCnkIjks3v7N3z6K6h?=
 =?us-ascii?Q?a/D6A/v5Mp2gJTYvybced9Ok/jrbn0zoBOOEbCXelQFm51mG0cNjcEx6UClg?=
 =?us-ascii?Q?4uvR2FM=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?PIfEHtALkoArLSJzgGtyUl5cKlp8bruKn0Wn5x7oLCXCpp0Y4XV0aapPqrLu?=
 =?us-ascii?Q?N/3IGjbVJIjphp5pQPXkouyoQExCXS1PJ90IUL7ZsZ5aZ/wWDtNXKLMSdNhD?=
 =?us-ascii?Q?3KULEHKABlcMMzp2NyjCUy+CC7uNG8yDJtezG5xc9KTIxeiq+q1NyA4qY0uy?=
 =?us-ascii?Q?4GIK1/dZl3S7gt5Pdt4nuEefKr9W62Qz3zALzx2QAyGdL7PJi2UNvlFRXLy7?=
 =?us-ascii?Q?CulUrG+Xbf2X+RrF/P/MgtZoG8TPQENw0iy0jwVPAKJ186sZlI1UvY6cshC/?=
 =?us-ascii?Q?/q0NdtU6cc0u0j2uX4oVOWNYSjeDjnfDU2yGbY0Q4Cyqyudiufv2jngs7IMq?=
 =?us-ascii?Q?zFvM6nn2IRV0m+d9KbltoFk4fTrf5h+NM4AxONGM2BrYlbLQPTur88QHoiHJ?=
 =?us-ascii?Q?xDfo3uSB9Qzguxa8rozWsJqUtsvuNIP9gfrQWJPl6kgRMcdNyDnbCaDqpWbG?=
 =?us-ascii?Q?Fuh5od4AZ0HtSma+EWaKqxinwaH7JghjETIBJ69cnbBYqlsxhIz093qkalMF?=
 =?us-ascii?Q?d2MOskFzDmdRo4NA75qU6Rr0sYhriCfVpSB57fneX0vVNTUJPFhR+lXweYXo?=
 =?us-ascii?Q?DgNuKvD+g/d4z9ftIXO6yAh2h8W5ajgsfvEdNTVKqllofCFodXL5hcIzmtUw?=
 =?us-ascii?Q?L46BdBquTMarIyjeJFNY5lwpS+4BXLWpL47srkM5zxv5MJNuImrmLKwQWFQL?=
 =?us-ascii?Q?3LVSw702ONy/7XB465qcaTAStdsuKPegYZHxhBZuyxk7jsYH/YyvNYFWli2e?=
 =?us-ascii?Q?V5Sc8oaiN/gQpzqu9ntLTsyH5lO1FMJyGpKcMJwGyf/CVfPfSymr1UzCdvsM?=
 =?us-ascii?Q?Vd0i5ncSSHAOBGKtAD6LYOWuGKYh49YRXfCaFKmAy6a84xfbRe+AtlSOZjpG?=
 =?us-ascii?Q?xXJJargSZ3KztfrlibLWoFs8CS/XPsNurGLP4fU/g882clTO0yQiugkZv/J/?=
 =?us-ascii?Q?kEMwy1PWl3FgXCWdgISqZlzGt3HR9+DtKQa+s1fIUnMCd1qaQFb8coME2td0?=
 =?us-ascii?Q?rcryWw3rgRgKmjm3yfa2neuludD0Wwjkmtm+YgioHW/q4XOxYWail9Gu4fwd?=
 =?us-ascii?Q?nHHdpwQmp3F1IAGrkJKy6OI0i4nBmlRr9gHRDs7QCnTHV1H/Gd6wJN0G/35Q?=
 =?us-ascii?Q?7ypMT5NMENrAJ16kgMd+O2IXIzf+AmiLLVq/yoYxS1mxafKxJjhnzBLETJfu?=
 =?us-ascii?Q?D0soqawwY1iH0kpvhuasA5LmVNQ3yY/ldOaVcF8Hk06rzdwkYwpVlOlp1aYn?=
 =?us-ascii?Q?br2MTsXqIfn2llijGhk1Q0WTc3KZg0kMWtGvN8WKv70YzefGKFzu202uSHXO?=
 =?us-ascii?Q?F9CzORWftWxhXf89sB5pJ1Zce6JU+o+bbGwYXBsRURzlCjNr6SkraWXDJhV9?=
 =?us-ascii?Q?pjWDKmYUWw0IqHbeYdcImi23sL7p37Ggn1Ot0Idpc8LdtOAVvlV19tmZfA0o?=
 =?us-ascii?Q?P5ZMHXYLs/6DilDSnkCt+8jyW3DldAHtog/NsDMq7MpHVljcu8ugDA6HXBLf?=
 =?us-ascii?Q?EgWacfsoRHXFt4HavVW4mJYH/Y3lQdwreiMPS1bMXIHdjE12FSEzSMQJvJWS?=
 =?us-ascii?Q?0HHpxVILGpna84sf77oBxPpgoitHCOc/Nd4uQ/SP?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: da7d0375-c68b-48c2-3622-08dcf6fb081e
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2024 02:48:41.2974
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7IYMNlACrV5mTm/yzL0oSGdoIvgVFBS3TlELIea1J830NbiFGaEj1/dHXZ2lJYXDnIKOdUQLKiqln7viFcOJAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7567
X-OriginatorOrg: intel.com

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Saturday, October 26, 2024 7:50 AM
>=20
> A nested domain now can be allocated for a parent domain for a vIOMMU
> object. Rework the existing allocators to prepare for the latter case.
>=20
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>

