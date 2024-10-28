Return-Path: <linux-kselftest+bounces-20781-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34E8D9B2375
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Oct 2024 04:11:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2179280CC6
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Oct 2024 03:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3FD11885BE;
	Mon, 28 Oct 2024 03:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DrVAl5aE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBE3B155312;
	Mon, 28 Oct 2024 03:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730085107; cv=fail; b=qhBnOeIMHv9SQFX7//c7sZflH5tClwYqYF95+J1aT8j+u5kUKtWuN7i69GUgwuW9RpNKBunSw+adr1fit5BzuPwDTuW+RYPYtbKzGeOvf0IccxtACOO2fSJTbkoB6winehlBD5k7NCOo0RoFlGEZixNBKHxYWT6ZCPr1Djaa300=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730085107; c=relaxed/simple;
	bh=9tcuLy7dNEmJaQAoKnu126zja+vjCubNlnmwbC8AhFs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=p9SuBPAbscbsLPfGm489LmQ+mbpQeS6zwSDSPKTOYBe5V7OTSw6w4XmqSQFo3LDfUTRw/UZv7/eozMbRZL53yySEzq/527CV3KEBtCkIvxXM0nNuPDXP8fjvc0IecOqq4Gf0aIAji7LjTxDTTy7/XbK3kJLJQZcIIkpjXvtcfzg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DrVAl5aE; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730085105; x=1761621105;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=9tcuLy7dNEmJaQAoKnu126zja+vjCubNlnmwbC8AhFs=;
  b=DrVAl5aE+AueZwffaROxqktJ5RxArN/iHs56V7TeBx4Ce9jeupc89FJ0
   bKx/6fULO38nXi4kXLyE/xI3XJ/3JXtpwht3BsN0/UNO/2rFxb3Lrl3W5
   P8atSsXfC1R+SEsBAT0Jqo2+2MCZjz1Nk1n5v5p7HV7UObvq1Qr/Zz+V6
   dM1U+SGN5XbknJ07o5rgLEavCFg/jocalVpjjD0+VkF8tAjUY1eEUerPu
   4PUesGsg750ImRvjLhWzuH4LlQKw6YfhEHAgqJjyNhwNCckmSiINePhZb
   D32kIIZ4N333Yr39qnZ0Smojj4hyH63mS6H22Qk/qDN2yuKz04cth3+TU
   w==;
X-CSE-ConnectionGUID: b2uYOTAqQbSYpJipJ1Vm5Q==
X-CSE-MsgGUID: hJ1rQbk9Ta2s5oaWXiv2VQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11238"; a="29777569"
X-IronPort-AV: E=Sophos;i="6.11,238,1725346800"; 
   d="scan'208";a="29777569"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2024 20:11:45 -0700
X-CSE-ConnectionGUID: ZEdb+JkYStau4zNe1SmQBQ==
X-CSE-MsgGUID: qg9GsLeYQsakfi18GuEGWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,238,1725346800"; 
   d="scan'208";a="81789855"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Oct 2024 20:11:43 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 27 Oct 2024 20:11:35 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sun, 27 Oct 2024 20:11:35 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.42) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 27 Oct 2024 20:11:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ClPY35EGhL1rMJLIlenQTfEtzduIXUwiRiUjFsk18Op7kDu8zduQRbLGdU2kAwkdfs9ebmLifMZ3LvqkqHFYvejRXtGR0+hugnGvEfXoIimWhEfP4pb+2QOWktpJbjih+Pgatn+pCaicsMiCzW2Ce/0yjQ62gHPrcg3KWtbwZRFjUgPXmluAIX4ptXLa6Vch9MLLZyPqxx8Te6U/HSLnKsNLzc039AoyGi1IRnvUSzVYQiFxpI4NJcHK96IhLXvmnIR/UQEb8NA+KlFPCqpaeWtx1lhI3eekc2rL8WjkVs833j2pIU/lNTjhiexXwCKEV3gJvaX5AvjOtuG0aadgaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rgd5AObqRzPJUSrIQm7k2snO1kvf9PGZochkFQNwluE=;
 b=HHVJGnTXwrRiKDtP1G3xz/SSk7F2aJC9KpXA2wlc+TGHiwPDGcj6ctXEDN2ZpHhJvLnMwdIUVoxf2xHRYPG3iP+KXrlNsq5lQKCn31wvaPQvjWuaiCYfsm11RoTMn9gKC+hzba1iPRYOFLMAaRXU3nF0gNdf7pKw4EKmWU8500x7paBYI8YQobBcW1HjmpX4X6A97EY1W5j8503nwWThVj4DYFAsN8Hc1u1PdYAUDBB5VzPvlV2AG/qvyJlFpoHH2zc29tGHYIR16oFlz7+46zpaZjKBHY9NpvZmRsW5Pl1wKPIrMLCX6fwFQ5erwgmRGQbT6ngzxB+/TgFIXL5EjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by CH3PR11MB7937.namprd11.prod.outlook.com (2603:10b6:610:12c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25; Mon, 28 Oct
 2024 03:11:33 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%6]) with mapi id 15.20.8093.024; Mon, 28 Oct 2024
 03:11:32 +0000
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
Subject: RE: [PATCH v5 01/13] iommufd/viommu: Add IOMMUFD_OBJ_VDEVICE and
 IOMMU_VDEVICE_ALLOC ioctl
Thread-Topic: [PATCH v5 01/13] iommufd/viommu: Add IOMMUFD_OBJ_VDEVICE and
 IOMMU_VDEVICE_ALLOC ioctl
Thread-Index: AQHbJzjDzfA7RKAUxEmBXn6ucyplmrKbfz6g
Date: Mon, 28 Oct 2024 03:11:32 +0000
Message-ID: <BN9PR11MB52765EED4209A26DC60F138D8C4A2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1729897278.git.nicolinc@nvidia.com>
 <53025c827c44d68edb6469bfd940a8e8bc6147a5.1729897278.git.nicolinc@nvidia.com>
In-Reply-To: <53025c827c44d68edb6469bfd940a8e8bc6147a5.1729897278.git.nicolinc@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|CH3PR11MB7937:EE_
x-ms-office365-filtering-correlation-id: 8078cc1a-37c8-48a6-4287-08dcf6fe3957
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?tE/DORFsR2bhJuMoicQMV9Mw2TelGQySUnbA4Z6lavm/qRRQv5AUIhpXuI8F?=
 =?us-ascii?Q?plKuzYmpZY3z6wcPc4hAfp2htiU34Q/s3ZtXV7EuFeCT5vpCBrLMK2H0C6wz?=
 =?us-ascii?Q?pAJoPWHei6mth8a5z6zEpXdBYE/HwnDXn+YGGG3kuULVSpdpmCkQkTwKkNns?=
 =?us-ascii?Q?HNcTRFk02px7/Cg0J14T+aNnbPCRKW+kkzHmypgURiMu1cEsMtsqq5zXwBse?=
 =?us-ascii?Q?aUUD3OonC31IAUvzQ1IrJ5TsDRE5suLo14UVeyzMuYrozhxJ3JfcSiqcwsoz?=
 =?us-ascii?Q?CTLqMWyWh5uLsAjKdu8/lTxdV3PPeVsLLW/QXLUMgGIlReeWmW0ZM1Etm0WN?=
 =?us-ascii?Q?4dvYiH2eXfTumJ7kCkST6EPs64sgf2cD2kw3RM4A46pmcrdpITb4adH5/aoZ?=
 =?us-ascii?Q?Ttr8yXiQL/Rg+a/qdgg2n6OeeREm8CtwIaFnxT8aVZPrxm1NMkjzo5V4Y/i3?=
 =?us-ascii?Q?J/Tz8FNsSibBr3ZSEzG5SdOfIx/WAfjUoXThdvEHrSIUN4dmpVSMDWkOjgrT?=
 =?us-ascii?Q?X45Qn2eZUNiIYokFr2Xkpm9IPNxxKfxlgzsRERA/aA5vpEYWNvad6G0gKvKw?=
 =?us-ascii?Q?e5KX+X3GqRoQhexRSQ77ve8tnc4dTqXxSA3eUWFisxfJnjhu+WioUhXjnb8C?=
 =?us-ascii?Q?IgXg1yIYLne70nrZ6FGGDag5ZNT9EK1KoP/dsMwU4WJIKu5lsb2XQy3OFi3R?=
 =?us-ascii?Q?GuEaH4u40fkIDTp6pIN5Jcdz0lsGBXReUFIXJktyZ1erI7eQ8RZiD4D3FYlf?=
 =?us-ascii?Q?JH55P4nk1+GgHkGrEOBzyKOX4xFxLBUJU/9vmYYIbRK5MSrZkd8JiLdhj06t?=
 =?us-ascii?Q?CorLJN3Yo/DXpI1ioTtlpXX8iWPT1Fixz9IiGNtaDonXq5gCYhjIU0CAum7P?=
 =?us-ascii?Q?czZeIbA6GQVyZg/um1kHvVp1M6OFj5uyn4Ca4YbHpOE0qtpZvTVO3+MZtyyo?=
 =?us-ascii?Q?9eKy1udPn8DYUJh4X43UgUuUPeKJVF/2p8Aee3bwCcJymyrgF9x9Ly6phxoM?=
 =?us-ascii?Q?fgx/fn7Ama3ZHZSTKoAxs5n6GKCAOvsRo330YK9RegJK/YNLbqSiYHtisoyL?=
 =?us-ascii?Q?BaPrFlqpr3OC+RJxB846Vh9vNCUX1n34T9NEPmtFr2ZtS9F9HVa1s+5d0bWF?=
 =?us-ascii?Q?mGOWiKZcIwjzeHTYQ7L4kbyYDvgcSYwkhv86TeG8gFN5wwdnsc9GxDbTd90b?=
 =?us-ascii?Q?1/suQnrz3p9C6i+tjTKFVOGnTBwZCafEwxrsozGyKgvYixN494dK4QUMEWZm?=
 =?us-ascii?Q?Ih6mYtlFdmEY7Xz/uGW4Zbt3OiKDFXMaBy3o28lUC98bHY6uIXb9kG594xCK?=
 =?us-ascii?Q?66bT4pKWQvc+OOzXHctDbEDLpJwbNxfvXRHqBrmzD+BYQvFydOeRH7uJ1JMe?=
 =?us-ascii?Q?6MHmjms=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ulN0Vg6TnjNwJ1BWWF1oj/Cj58mb9yskevaPrXAaqpM9GlZPSNd9mvL3Ibft?=
 =?us-ascii?Q?6iItSogka0x8kml4rsitX5M/Sx9jeR1GcrW+uj0dAGinTXmA3oLnRiaRmblH?=
 =?us-ascii?Q?9h8SHjYFAqRvehD5AI47XfJwlnEc2cHndEUTlf/46FoQSFvCDSF6zRv6o6rq?=
 =?us-ascii?Q?JWnWrvIIa+39XAH50XEM/7IiGv24MucI8zuuKH4siMcPLOAN16KbVifFZLV5?=
 =?us-ascii?Q?keCJp8bGGaAdkTuz+aU7yUfvfKf9V6Ztpx7PU9j4HvtdmqzhUkMfsTRbpeMx?=
 =?us-ascii?Q?/Ib3AnIhQTdryrDasANbPWLR2LSnvyzuYZwI4cvkmoKPZn5JG9k9PL8lMlLJ?=
 =?us-ascii?Q?zQvZ2W47lsrqi/B21DzLIogbFNsb6bWbnu7te0OvGSp9FY+9Lgs44NhofBAg?=
 =?us-ascii?Q?LcN1NdYJl6ibob0N+lSn4idc6XOvVin8uIqoBfVz+gggVaRUNiLeuSAwgMWx?=
 =?us-ascii?Q?++XeyvOhn9atnNaVhO4yVTMyhSnIAw3+B6V1LKTekDISoiQchBNMmgZ3+3RN?=
 =?us-ascii?Q?/+Y0pBr2AaPXz94UoeQGxBMkwl8vqNSO4pQS5QqPSgOMUwNFlE4rDlOKYfCZ?=
 =?us-ascii?Q?5CW+38D7yqWzVypKrKv+6GtJKzY6Dtx1djbn6/ssQ0ykqS21eK1lRaMsGCEa?=
 =?us-ascii?Q?1mjsz3h5zU2BPQeY5VfWv1wVAzc8zqEReVRtnEPou7OpvQbHb8wD12d6D8Rl?=
 =?us-ascii?Q?l5X1lrFIecaYhWJmMxirwY7fU/sbRqQLecLG4PPsJqWcL/bjVcdnhnzYjE5k?=
 =?us-ascii?Q?VoyjZh4YcI9xaTr0GhdgTMu3aiCh6wtQmnzFtsz9gm72nYNUs1iWOgIkA10q?=
 =?us-ascii?Q?qYUJH0JIowr0nAj02nqA6mXjWRKLW07TIu0tC7/vDXw570kaIQgcqtOteSGr?=
 =?us-ascii?Q?lWLXye9/k/GZLQzZyGbX7IVjbAEPReqOAasaTkccckRbegS8WU8Q7ljqxAZ+?=
 =?us-ascii?Q?i1rrVcKj8OkjgCq8UKT1yk6N5H4XsKc1e1g4mOJVF7s3QlKvtTm4EbbcJfaj?=
 =?us-ascii?Q?5GEADzmh8lMi6KldKIHwhp7XoX0V2WL0LKsx8r56p195RKe/6M28cJ1CTc1q?=
 =?us-ascii?Q?sKni+YMG+Qva5vSQtHXKMXeUh0jgHG2V35OYKOOiq8Qu3wNG1FLfrKOHgXdF?=
 =?us-ascii?Q?V0ZGYbfppuBymRkiq7vaIKVgoaCL/UeegjcLRCtpF/ILyw1aJDEQeo0y9jBM?=
 =?us-ascii?Q?P0UR7FBfC+LBSg16hGd5zLNEIJm0MX5vgOyO8fVLqjxspGj5QGhYBb3GYtL0?=
 =?us-ascii?Q?HNVfA4/U7euDAavzazH08NJ5xYUqkHyKzKqXzx9/+EcQzWYk7uh5+rxxWvVN?=
 =?us-ascii?Q?NAiC2Zrsrv3i3+nHc/vakXjAa8Xo39jq2zSy87xp/ivRFykNvFJ8iwgQXjvD?=
 =?us-ascii?Q?73ysEAH1vbcAn+uNXjONz+Qo6nTSdYesXyGc/Hf/uPxoSR5EPmHpysWq0mLk?=
 =?us-ascii?Q?XZ2P4uJZXRrqFMot1JYZxzERh51apHWmIWcq6v6wn1rEARGZF84Ln2R0/nwm?=
 =?us-ascii?Q?OefWFR+3hX4m3nG/edHfofR7NmMC/whTlGVc7FJFnJ9u2MDiKH3UZ/CT706D?=
 =?us-ascii?Q?rAZh+0qouLVl0w9eipJxu/7Yi991s9JVfCLq3EnI?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 8078cc1a-37c8-48a6-4287-08dcf6fe3957
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2024 03:11:32.3665
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OLXdnPXBi8fmGWY7M3Z9iKqm/HQyHKQZrdZGbLN42gnepMC8EVIXxLqinhV81uUyOzFLnRsjnoKv/4AEY3vPyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7937
X-OriginatorOrg: intel.com

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Saturday, October 26, 2024 7:51 AM
>=20
> +
> +/**
> + * struct iommu_vdevice_alloc - ioctl(IOMMU_VDEVICE_ALLOC)
> + * @size: sizeof(struct iommu_vdevice_alloc)
> + * @viommu_id: vIOMMU ID to associate with the virtual device
> + * @dev_id: The pyhsical device to allocate a virtual instance on the
> vIOMMU

s/pyhsical/physical/, or just say 'iommufd device"

> +
> +int iommufd_vdevice_alloc_ioctl(struct iommufd_ucmd *ucmd)
> +{
> +	struct iommu_vdevice_alloc *cmd =3D ucmd->cmd;
> +	struct iommufd_vdevice *vdev, *curr;
> +	struct iommufd_viommu *viommu;
> +	struct iommufd_device *idev;
> +	u64 virt_id =3D cmd->virt_id;
> +	int rc =3D 0;
> +
> +	if (virt_id > ULONG_MAX)
> +		return -EINVAL;
> +
> +	viommu =3D iommufd_get_viommu(ucmd, cmd->viommu_id);
> +	if (IS_ERR(viommu))
> +		return PTR_ERR(viommu);
> +
> +	idev =3D iommufd_get_device(ucmd, cmd->dev_id);
> +	if (IS_ERR(idev)) {
> +		rc =3D PTR_ERR(idev);
> +		goto out_put_viommu;
> +	}
> +
> +	mutex_lock(&idev->igroup->lock);
> +	if (idev->vdev) {
> +		rc =3D -EEXIST;
> +		goto out_unlock_igroup;
> +	}
> +
> +	vdev =3D iommufd_object_alloc(ucmd->ictx, vdev,
> IOMMUFD_OBJ_VDEVICE);
> +	if (IS_ERR(vdev)) {
> +		rc =3D PTR_ERR(vdev);
> +		goto out_unlock_igroup;
> +	}
> +

also need to check that the device and the viommu are associated
to a same physical iommu.

> +	rc =3D iommufd_verify_unfinalized_object(ucmd->ictx, &vdev->obj);
> +	if (rc) {
> +		kfree(vdev);
> +		goto out_unlock_igroup;
> +	}
> +
> +	vdev->idev =3D idev;
> +	vdev->id =3D virt_id;
> +	vdev->viommu =3D viommu;
> +
> +	idev->vdev =3D vdev;
> +	refcount_inc(&idev->obj.users);
> +	refcount_inc(&viommu->obj.users);
> +
> +	curr =3D xa_cmpxchg(&viommu->vdevs, virt_id, NULL, vdev,
> GFP_KERNEL);
> +	if (curr) {
> +		rc =3D xa_err(curr) ?: -EBUSY;
> +		goto out_abort;
> +	}
> +
> +	cmd->out_vdevice_id =3D vdev->obj.id;
> +	rc =3D iommufd_ucmd_respond(ucmd, sizeof(*cmd));
> +	if (rc)
> +		goto out_abort;
> +	iommufd_object_finalize(ucmd->ictx, &vdev->obj);
> +	goto out_unlock_igroup;
> +
> +out_abort:
> +	iommufd_object_abort_and_destroy(ucmd->ictx, &vdev->obj);
> +out_unlock_igroup:
> +	mutex_unlock(&idev->igroup->lock);
> +	iommufd_put_object(ucmd->ictx, &idev->obj);
> +out_put_viommu:
> +	iommufd_put_object(ucmd->ictx, &viommu->obj);
> +	return rc;
> +}
> --
> 2.43.0


