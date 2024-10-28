Return-Path: <linux-kselftest+bounces-20776-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B500D9B2328
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Oct 2024 03:50:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D884C1C218F4
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Oct 2024 02:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2B2F17A584;
	Mon, 28 Oct 2024 02:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h1bdj9DP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3268156F3C;
	Mon, 28 Oct 2024 02:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730083806; cv=fail; b=N4m8832SEf9Xh3I0jSdxP5lG9K3vNfIJCK2OyXChFWEbDzZ3N+ZrCiTNyOR5tqNx+ULVliWBEVHxtLkd5V/EaVEBe2AQFcFn2P9Z64lxqNIuxhyTD/0aWI0LcKcXsqGQERDYIZDMorKlsODUEHLG/+OE0woZiF3V60VHKRYBzWw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730083806; c=relaxed/simple;
	bh=9MSZmV+lMyNk5TRbkIvRFu5Z36PPrDjNODNJ2zQ/Y7c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=R/GngibPU+GNReF77FlcMQ8YPNW918y3EdUnuet+utx4ZPEKd2bw02jY1mMszYyimSGvD54ZtJNuJCkTn1JDGUb2TUgyQQ2ZOX75g7LLqyQ1EYA1GL3qdFdQYZ8nbvgngoZF2DM9Pf0f2914kaP7euup8BGNKeEbLx/tSQxQHa4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h1bdj9DP; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730083805; x=1761619805;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=9MSZmV+lMyNk5TRbkIvRFu5Z36PPrDjNODNJ2zQ/Y7c=;
  b=h1bdj9DPGqW4tWAuHRflkBrVcPFyFRa5YSW8IsxaiM+bCYKPFK8j/y2W
   RNt0r7KZV4K0OPOoV9lSEIdqUX9rtkh1hnBOiUAPXzG/mRaxl5O9uzHnB
   rgQmtjhGjeLFhYSjnNjoGuX5G0GrCT03IOcxkc5E+uSh8FQvw56VNUkLr
   7HG1rZzrA2m3g2qiEKS0yqzLSJGNKHzoIae3ZEu+2VqmgfhrkFIokOTQ5
   A77SQLz07YvUjI2yJpbF2L7Hkx5j81tB+0c+SUPfw8PNfvq5yoCe2L9Tc
   FMl/++LfGp1n1u3QEnGdIZ6Wlgt7IlHXgxR9SxMAM7D3SDpwxN+RzIR5l
   w==;
X-CSE-ConnectionGUID: 31TZMtNlQ6mlad4Gx/BCpQ==
X-CSE-MsgGUID: 9iuV0HMQTZeDMETO/dBt/w==
X-IronPort-AV: E=McAfee;i="6700,10204,11238"; a="29131029"
X-IronPort-AV: E=Sophos;i="6.11,238,1725346800"; 
   d="scan'208";a="29131029"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2024 19:50:04 -0700
X-CSE-ConnectionGUID: wzOo57wFS2qybsYdMatk+g==
X-CSE-MsgGUID: uUqEEKI1Qw6j0bQm2zcH4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,238,1725346800"; 
   d="scan'208";a="81052379"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Oct 2024 19:50:04 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 27 Oct 2024 19:50:02 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sun, 27 Oct 2024 19:50:02 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.173)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 27 Oct 2024 19:50:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lB1rRoLsR0WKFePcYyiybZEugL9C7z8FcqDMY5mWnrE4t8+A/io4YaV6AAGvn/X7p46vivPrRbPFc5pUZvNFITgYgR+0E2+7mVVcyfj3XUqdpaLGu3HFzoA2N0D8E8j5gINL5qN1tjhoWlFAoizO6Wns5W1o+dwt9LNnqi2cp0aVEK1/Mm5P9n+/kQecG4zpTzn316ARsg3OX7zd/3ObKvkOjS31Q4KW+A+/HgcC6JFzieEFlmyFjlUIcGQkuJxPzfSvwbkJdEloOEblGKX3FHvMF+YC5IspG6q0AFZ6adcuDYKwqsIWvcE+8M3ttMmnucLrr3YIOCli5J/p3cNK9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9MSZmV+lMyNk5TRbkIvRFu5Z36PPrDjNODNJ2zQ/Y7c=;
 b=moRzlnhBP+tqjSP9afmb4FdByueCysIVojT0ShXT0xpOlyS6+kLQXpSP6qM7N2LgSi9OuFW6tRCj2gi0BYQSqBhXYN05ty3RzOnft66HaDkMPCem2TMKf1ClM97XVVis4vFRmvtwA7Kfqmv+uR653DVKOzo8MC2pt59aPrp+xU7h1Z/2l3RCyR5OD3C+ZgUSY5DXV6nInt9jfDVd6d36a9qNLhRpA28bDtxEeyRBz1f+j2VFwvSOaXoPwMfsxtsAopahiuo5/zau58Dryuz4uDU/OPtvBVTwR4+GiqEOYjZs8oKBmAeMqo+wFRFmsTYRkoP6ov6t8koYmmCw/tjjHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SN7PR11MB7567.namprd11.prod.outlook.com (2603:10b6:806:328::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.23; Mon, 28 Oct
 2024 02:50:00 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%6]) with mapi id 15.20.8093.024; Mon, 28 Oct 2024
 02:49:59 +0000
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
Subject: RE: [PATCH v5 09/13] iommufd/selftest: Add refcount to
 mock_iommu_device
Thread-Topic: [PATCH v5 09/13] iommufd/selftest: Add refcount to
 mock_iommu_device
Thread-Index: AQHbJzi9F11+MrlLUkqLTE2hQtoHY7KbeaFQ
Date: Mon, 28 Oct 2024 02:49:59 +0000
Message-ID: <BN9PR11MB5276FD0E6D0BAB2318ACFCB88C4A2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1729897352.git.nicolinc@nvidia.com>
 <f91cc278a173a95969af16c46442f18b639d4ea9.1729897352.git.nicolinc@nvidia.com>
In-Reply-To: <f91cc278a173a95969af16c46442f18b639d4ea9.1729897352.git.nicolinc@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SN7PR11MB7567:EE_
x-ms-office365-filtering-correlation-id: 1feefdaa-ebec-4449-8d24-08dcf6fb36fb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?c3rgKxB9+3ywYBEk8IQEi3LlP/IhPzN+nMzZI0OaB+Gb/rJUV7YSH7SPlLgD?=
 =?us-ascii?Q?KLy2HFUivTm5Xb8Geu10JdT0D6+JE4+2juTR26HSqntz3o6uXwRT7lGh2X8T?=
 =?us-ascii?Q?6kQD1gd98ttXiIZq4CmNOyXtvEe5I1guUwsF5qJpTwC7EYkxpaCkI2bM1jG5?=
 =?us-ascii?Q?dgHqcjw7oTWWp3n7fv9yo6u8UMVzZm60gX5cyJVk4E3BNHAtS3f9tn9CgvjT?=
 =?us-ascii?Q?CbBERI6w8XZP47bp2tNOXo6tfnEmbQeAPq9bD2aG/qVm5F/UiEsfgd0IUpFC?=
 =?us-ascii?Q?Em97nOaBji6MlMdHPI/zKIgTn6c6ZOD2KAGV4e5glm1VGN7svsVPX0ZSumc1?=
 =?us-ascii?Q?duYrWSmmFpRTrp2mE9ObkZq9Uj2KjSRl9vbLMdraY5Pg4uJRCQjE9nBGlI45?=
 =?us-ascii?Q?3VL9s0FaKAz+SpcaYxT2V92deEpCxNsdUJ5HdIAMdfNzS0q6p0w5Nx6VQSuK?=
 =?us-ascii?Q?nItX3POHdjH6hChUvA92vMeKM+q4iAa+t0HTPxUCLsPBxC8XHXqGsq/S/MUS?=
 =?us-ascii?Q?mkT77MJgWT9E+X3z+4X3cEz9HqctZkBIRTWjQkMvw7jvrTAZeCuAJOpmsQ8Q?=
 =?us-ascii?Q?appxW1sgR8DVrjNTittrU7wrLIGfzf6e8TtieC8abFHm97Ayw9JPzi0v88d2?=
 =?us-ascii?Q?ctlWZBxbSIwzqgwjhYh5Opf5eNGEm19OV6NCGRvFySbwHxGLB4uoyBw1Mkqz?=
 =?us-ascii?Q?2wpdVROkgZQFfPh2EZI7ICMvjmIpJMwigyvSBl9lGEcxA+TdKH2xQHaBm6I5?=
 =?us-ascii?Q?7Rh3wZSxJF/KvFkwTg9Og1rlwoPx7eTaK0EGHzqGOgFvtZFDFzC1IID/W661?=
 =?us-ascii?Q?FCiALMbvnk3+yTzNL8FnlrWyJ9icxpgC8ZvDsD6Xqa0YYincUXB576rIwChO?=
 =?us-ascii?Q?GOIeVQXQ/yMlk0FdNre3xyT9tlFUyHHVYah3k4eqWaahuJQ5BlTs22YP6yFm?=
 =?us-ascii?Q?uqz+5vWNtOZk9X8iRVWJ5Tn2Hjf62ITJZpTEOd5ci8axvMN5VsLDfzceRuHt?=
 =?us-ascii?Q?ZAdVpWibPV7VhS24VjB4OGl777waB+ckmu28jiUVPAUlk1nWjVToK1X0+gsn?=
 =?us-ascii?Q?7GluYbsqG90FGDDszSaA8tbnKK1Zi8Ms5LUecAn14HavCqtylVleQdHz7fjt?=
 =?us-ascii?Q?0c/cibHHQ9KVGX0lxhnxGPvB5ISYDfoi8Q19GzRC2YawbbYp1LslvPcjW4Rh?=
 =?us-ascii?Q?Ss9JNEoO3gEAVtj0tKbl1yTwabyzjmJTwKJuLrJpPYbdnkxbXOTcHG2ulb88?=
 =?us-ascii?Q?pmpqXlJ7hiugy/TB3W7FADdwj2AzyLr+ToZpa0fWhdBK5OzoUaQdhrPpkqkq?=
 =?us-ascii?Q?HQMcMxDDB9D10ztXpci59dgKVAHPeCZuvEpXg8bPRkmLo73diMZeH9YChEYC?=
 =?us-ascii?Q?ncXE5h0=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?C25X4dcROtLGR6/fSl+pxghADMVF3pfZCk0528X0OWPfvfybBW8FDcKyLPdR?=
 =?us-ascii?Q?tCgy7Zvbu9XYJgDUbQIryrKUuJYBmmAVXqADxexlE0GIWzSAc0yV94T1Slit?=
 =?us-ascii?Q?VO5kHnCXWB67oczsMPUREoq2qeLusS54u4Tq7Hr1t5p/XoV0HbmwidM44PW5?=
 =?us-ascii?Q?h4Xu9wabbxnHWtXahucuPkw4YbFoIhp3f1d8E1Xqadf7l/oTs19Tp+SCFj6f?=
 =?us-ascii?Q?GGKTv359Xbk1mDIWoKtMR92R486pX8A7AOS7UuvijrRJ6OQhVxvWoyABDsRr?=
 =?us-ascii?Q?sJT5qlnetXhTS5lFtXZqu+QSFFqgqPFNi9O9emFGpcwbhi27uLS28OG7q5nj?=
 =?us-ascii?Q?Nboa1Ono69NnD6+u/AwLFpnPBlr2q6F716g6rhabqhrAUpNfU9N2R1WZWSW5?=
 =?us-ascii?Q?qnUYqm2LUGZ1Qk1M2XDGHLKPEIuAt3YI8PE0d2aEDbGjIYq4pt87+m0zS+ic?=
 =?us-ascii?Q?wHXgrkyIAraDfrEyD69LH3HXK4EdhyhNLnl+9GGDlotNRK9mR0rnqZz/WV3c?=
 =?us-ascii?Q?03rSntn8DLx0H4nU08kaMVZudCU78zHjHxQp8RLTAwYKnDB6e0HlBqPQVTuj?=
 =?us-ascii?Q?4KuLE061rYt3V9NLFXl3FK0gTX4H0rN4GH7gQ/Mz5T9yn4GpVXKhHQuYc1rF?=
 =?us-ascii?Q?JicB+O89kgo4XVEVhpvSTPMx+H98fiNmaNhxk5NNtIFsBUaBsWdZ8PENFAXI?=
 =?us-ascii?Q?BJ4kaiCohaUPqGusrJEg6Lw7SUlaHFhos3aciJRoZt6HtKxClqxI/72TfkeW?=
 =?us-ascii?Q?QpfDljUon8Ncjn0+wxT3hzRPVzTPiDw5k+4rrUZ2ocNHVwZp76+/fvf8N5Wg?=
 =?us-ascii?Q?+BuZ54Yt1khzCXRzxg2BIUo+oXrE89jmpvjdfA68S3CEaCMfYrMck+QOHGET?=
 =?us-ascii?Q?4/EZ+V5s9xKQjCzet2UgSdoAkVUzHb/FBNlL3T2Ycmu3yQnnCubOXbE4ftp3?=
 =?us-ascii?Q?VVBSlmko5LOuFot9UaNvjBd9qrB8giN8N04BbNHDavHePo7XrJ0uEmEp7ekP?=
 =?us-ascii?Q?clqsgTde+sLSazq8e9uPPZO8N2txyoMZwYPjKSJor6TpPZP4wt3OKmoqSjka?=
 =?us-ascii?Q?eUpzeSEFaMW9DpE5SoTupje0Of/a2gChmGXgCALbtlf1mhe5qBSfLp7vhQOz?=
 =?us-ascii?Q?qyE7bXs0C+ZmVayLQm1Z1e0YPpHwkqnhyRzdCuvam05q2heBpKvIbeNANVn+?=
 =?us-ascii?Q?PBvCQ4YpxUCzqulcW8nPuOYRunkr3Ade/9NH22OjybdoCXgKTwORKWK6XQyC?=
 =?us-ascii?Q?zQM+t870JZnVfAXZX0lAEg0UPBjxCMWqdOt8rqlvapAwwR8xk0UqT2au7BoO?=
 =?us-ascii?Q?JRO/Jjo4QYG86WLGMy4u5OS0T26pGzSvKYbqA/tJT8KHuzdlMLZ3vyPkEOPG?=
 =?us-ascii?Q?SqKt4pek9RAD1zeVTRAGB2QKqDXND+JPm6PdiGrTUxZXXxrb/8fE1gegskd5?=
 =?us-ascii?Q?Yl2I1MXFXeA9P7LybjK1KKKxAyHzDDVGbCVbP/x0JLxr/7ugkao3Q/ox98JI?=
 =?us-ascii?Q?1+ZHlV0qJ78Q5ICTnLVHWO2DjWtPTf7zsRtruZJ78rzJCaeP3OyBM8WdzeEn?=
 =?us-ascii?Q?vdWyZza7yGimdgMFp5x2u8bXhYzrnfDFhedlVuGe?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 1feefdaa-ebec-4449-8d24-08dcf6fb36fb
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2024 02:49:59.9030
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iXKqI9GaoffsTBFKyYCRAjxymNn+n7jfzq8H9XUw6N7uqjv5WDTP5V6OQXJkEJj8DEq511zb7mcubvKNrQyzyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7567
X-OriginatorOrg: intel.com

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Saturday, October 26, 2024 7:50 AM
>=20
> For an iommu_dev that can unplug (so far only this selftest does so), the
> viommu->iommu_dev pointer has no guarantee of its life cycle after it is
> copied from the idev->dev->iommu->iommu_dev.
>=20
> Track the user count of the iommu_dev. Postpone the exit routine using a
> completion, if refcount is unbalanced. The refcount inc/dec will be added
> in the following patch.
>=20
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>

