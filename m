Return-Path: <linux-kselftest+bounces-27136-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 575B3A3EBDA
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Feb 2025 05:28:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77A573A1FE3
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Feb 2025 04:28:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 367831FAC4F;
	Fri, 21 Feb 2025 04:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TNRbtJ6c"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DECA1D6DDC;
	Fri, 21 Feb 2025 04:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740112092; cv=fail; b=gVspT0oaQ2B1eh7f5v65uf8hZmqKMT4hYBjLNYhzmTwWtLPuncCAuc2A5KCCr4dZWB0azX3jzB8vszLwd7F6Vg547+AQe7/s4RglbuOB6nmS3riK8vrrA1GXDz0E9vmE87KNNI9JFi4HVe8uiXE+DGFCKCS5Efb8GgRYxGlqEo8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740112092; c=relaxed/simple;
	bh=JgRoB+omr0+lB1XurtZeoeBEmse9GRXma1+mrIzDrSQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RwafHjqFF12xii6oESGnoIguRoTZkuC5mIYYHIbYcweBkQLsB8bmksPdiAy5n4o20nPoJdxfK8AGrlWlY2G9GJXNJPtvFpU+lGQ+3JZyvVfrow6S2EIaXZ9Ev50meqTaJw9iFSFYe+D9ydoIG7UVKQ2op5VAo6gQq+Wbhp16Cuk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TNRbtJ6c; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740112091; x=1771648091;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=JgRoB+omr0+lB1XurtZeoeBEmse9GRXma1+mrIzDrSQ=;
  b=TNRbtJ6cROws98Z1Gm0w3jbzLIapdJdV28LW64CghZM8jfpvDU1E3gF2
   V1gVvHssPAVMs0t+og/t5WIiCdHCpb73gtPt3bh4+E5XAAQ99xvaIdXYP
   VkiUJ03jWKu3iaGPVsFEyjBltknV8/cL81amd9bUJfgplBI4CQWLmnBO2
   yUHLvU+0toLL578V0IOh95bfbMANc6dXiCHjhtaOb/gHX3IXukWBrycPG
   EBuGbBLY+E7Mc+8RSMg/Xlwt8NJlIfWgvRwJkHWF/o5mU1In18D7lR8xB
   2Z5r6ldyVVDnc1HOU/J5bnHAzAUNYSnQ2AOtGSThGvNu4WXC8CG+2bOic
   w==;
X-CSE-ConnectionGUID: x2S6Vh97TcuZ2FgjUPkYDw==
X-CSE-MsgGUID: +8aTQ1waTj+QeteEjzWupQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11351"; a="40787742"
X-IronPort-AV: E=Sophos;i="6.13,303,1732608000"; 
   d="scan'208";a="40787742"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2025 20:28:10 -0800
X-CSE-ConnectionGUID: RskD2pveSJ2+fCvu/lmWmA==
X-CSE-MsgGUID: m16OYREkQM+5LDTC+W8zLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="152453681"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2025 20:28:09 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.14; Thu, 20 Feb 2025 20:28:09 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 20 Feb 2025 20:28:09 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 20 Feb 2025 20:28:08 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q/7YQ+wnN/R9VzQxaFkpDgDoIJJiG+a/fkk0MBv9lpviFRN5mAwMdvlJa18TLiRolYA7at31EYLFStc4OmFQQPCD+l+kxLGf9W5P8sd1MoF/oy5kAZ7Lw2/ZVL22xiTFWGE2Ei9yb9+dwZkG/yIIAclCqUuOAs6o4QjrqG9dzX3DlA7BwhkwjMLLqxRd7vCSF9g4r6QU+wGAWtaBdkly+ZbjzJ8wYNoH/Y3pmBdoeELuMwgoRmswvBqJwtFRBGCqH3PBoiwSBd8j/hrIY5Qq1tLX1257/k74ltn1mYHPN2568lHcIzadk2Av9WqMzEo19mija0VqzaxqcAfTyWqiuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sAQDgi4vXXkwyM7miBlaLqD8hwRP2hIQQCIJ9490ZQ0=;
 b=kkcTN2jAz9SsjGKbGdxQBMo7V4ntjCVUxZaJ7SsV7YP9kW4C/mzOw/CyO3wksPPOTMSMfFYAUOlfXEAvAPkVScAmS22c0wAeKxZiau0UnyDYJb2Il41ShbPp9HnZJNA4wfY7r8JJ8FV9TLORtLVS4xB1RQ1S/HUqW5bkVrko6qVavB2MWT/PfhL0ygfCjC7Fnup5zx3jksnWNxu8YC06nVc7s9Yqz43TE4vzvpnaZaSonUtU+J0YJwPOznyTkp6I/jQhrCCrE37bOW5x/tW5FxsXFbdcxZ910TIk2Lsii87aNUrKG+d/VWrXhrFVXC+K5ZRcxn+EBeBNfSCJ4iKrmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.14; Fri, 21 Feb
 2025 04:27:32 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%6]) with mapi id 15.20.8466.016; Fri, 21 Feb 2025
 04:27:32 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Nicolin Chen <nicolinc@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>
CC: "corbet@lwn.net" <corbet@lwn.net>, "will@kernel.org" <will@kernel.org>,
	"joro@8bytes.org" <joro@8bytes.org>, "suravee.suthikulpanit@amd.com"
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
Subject: RE: [PATCH v6 07/14] iommufd/viommu: Add iommufd_viommu_report_event
 helper
Thread-Topic: [PATCH v6 07/14] iommufd/viommu: Add iommufd_viommu_report_event
 helper
Thread-Index: AQHbbsB7HR9yJhey206dG82i6PAMFLNNWAeAgAEBU/CAAoKLAIAAdlig
Date: Fri, 21 Feb 2025 04:27:32 +0000
Message-ID: <BN9PR11MB5276DCBA230A17136BEDB7FE8CC72@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1737754129.git.nicolinc@nvidia.com>
 <3d952137a7935608f9cc6b05bd561a58a0c5da16.1737754129.git.nicolinc@nvidia.com>
 <20250218153541.GD4099685@nvidia.com>
 <BN9PR11MB52766CE9C579D3EE1CE1A7058CC52@BN9PR11MB5276.namprd11.prod.outlook.com>
 <Z7ebqtJUwzgOIeSC@Asurada-Nvidia>
In-Reply-To: <Z7ebqtJUwzgOIeSC@Asurada-Nvidia>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|DS0PR11MB7529:EE_
x-ms-office365-filtering-correlation-id: 66da3038-83fe-47ff-3524-08dd52300f32
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?rtSFt0thXK/iBfrpaTUyNfSUdWxTof3mcLudjLdm7FJjXFLrWxXSWaB/FWti?=
 =?us-ascii?Q?fBiXFL1PpDPxETed1H6dtcJASKLaKtF2yk1ans2cC7KWPqH26I5V2EM0/+YA?=
 =?us-ascii?Q?LfWbMrUOZEzcXEq+m5I5EzKPUgeXY2Oyhb0jOTQLJ8BQskXR6ERAdRlKzDxI?=
 =?us-ascii?Q?cjCShSNEXbphMgv00geved+x74b92ReFzlZGLSM7EWGVKMa2zTHJDot09p6c?=
 =?us-ascii?Q?iH12b8p0Byj47RpPpV3GtOgFrfxVSwUCku6i+uH4q/E5V43B5im+IGfc0Jup?=
 =?us-ascii?Q?ILNSJR1KnO41pXbkqlMK0mAl6kzKbRUnW3+8jUnkzLooY3EfTbVj4U0IHRZ0?=
 =?us-ascii?Q?ykALf3g2tHC1/lKeFtwzuz4w0pTu1/qoKZbIBhkcfqwkjLsjzwMz2mAs22Io?=
 =?us-ascii?Q?+/VEW2DXpGE0os16KuhW6jn+gjem2oWy9KKBQdZnZImbFE2HO1bFwIQDNIyC?=
 =?us-ascii?Q?SdlMpq7xYPHA74it7A8QbdmsSqXbHiu8DW+6krrxpD2CMsjenNTHUuBPEi+A?=
 =?us-ascii?Q?/6jYXcs+Ey3luK61jfTypJYbWxBq1hTL3sZ9i1ODkVK2wQdGW0kp6X1pg/Xp?=
 =?us-ascii?Q?rdhBRYQQ2KPeKFmLGQIrb5q7DVyE6mtHMRUdVnpdch2FG45CbpmCMWJLnZC2?=
 =?us-ascii?Q?3pxW9XSQdt4LGP0ZRvxiv1YclQr+m/8lRrVAWhXed4TVW63Hq0IRih24Jtkd?=
 =?us-ascii?Q?qvaiVyiqp9gAWUXPSNr/xySYP4kpc0Smz+ajS4tJiAdYXZ5eo6Wobq1KEWPX?=
 =?us-ascii?Q?m4eURIqQ8xnhV/u7GNEY4L52+4dPpNQ3Uasj8S+GKk3sJc0Z+gdtdi+65M4s?=
 =?us-ascii?Q?Es7MK4H/wZlg4HoLG+3u60iOz8izVCer4YDCaZzwl09bEFL8KqrMr5f3Rjqi?=
 =?us-ascii?Q?nGoswfVe+1mcDztUnRQpUHU3X9vlDUnfBe1bKgXqO+qqb/SnftIE79ji7r2J?=
 =?us-ascii?Q?9aAjC6MaL49dxu2v4lmHAaSGpfQ9Tlt1zLDl/KmX6w3Vu6iP++kICkYJx2Ij?=
 =?us-ascii?Q?5qNGhtN/4TSam6meSbAHEQzBccmB13cEdHELS5+rq6Ml+EMRbPIdEmNrlsv8?=
 =?us-ascii?Q?XAUV7xy/dKfoNYKXS0JbgwV7YYewQnYWYUYHMrKnE8nwvQdcTiM7mzw6GxCJ?=
 =?us-ascii?Q?owCnFI2WU6teeG0YrLM1DTQXQaGWTbMfVipRcYzW3NAbuAvG9nwQkE/o8YEQ?=
 =?us-ascii?Q?5ECJzwHS1M+6EcIpjI4pgXwYnOgeJ19DnU7lszh4agvScCqE0LXE4IJvIxU/?=
 =?us-ascii?Q?WWq7Wq40L5cQ70Xd8OS9af41Uxo+SI6O9aczHNLGWRbMhy8QZOw2X8QiH/PW?=
 =?us-ascii?Q?UkWJhR6alVzrBgpxT/Jy4ip4woB+uWzDjCMKRLuCzpnN5oxdIymU9y+oP/h0?=
 =?us-ascii?Q?kV8Cef6VhoDqaMVFEED3PKDHTJx0TnS2kEcYKh3RdZwmKbKNG9clBH1gYeEr?=
 =?us-ascii?Q?Jrsh3Kg6j5v9ULnYfBcjRYWmHSXcukC0?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?M+tVfxA03WHCcJ3STm22wsc3COWaSBPIjZMCtTEQ2jQIGuZFSNfKFrATcT22?=
 =?us-ascii?Q?cHlIXABa+vLKaLrOU2P2SMVFqIpsg5+ANmLi7p+KHg3qN81lSR971K4nySd3?=
 =?us-ascii?Q?0Sx8GhmQr/uRNWUF9uCKEh2DTKUdV550Zda+/SKU+vEsE8KQlHDaGrTGso2O?=
 =?us-ascii?Q?QRsb8kb3lTRO/GwfgOAerZnFUGxRariLZmkqpX6dp5GcsNHp5umgMAA3U/1/?=
 =?us-ascii?Q?3XKt85fJmGOiN2qRp7QDU5UWWPYxpWLUZVGoMzfNvqryNgu5yDNe8fOhG/aB?=
 =?us-ascii?Q?n+/pQB62Q1QwE9kGnRqyBJGcz0yEWo4hTS5SZ1MSr5gQyEbEMn82eTMF9ZHK?=
 =?us-ascii?Q?SkR7hf8w727cQo1NaQ2kOJNo1jrGP48U+30yW+/eDvTtPw55mUwa3UXn7hLA?=
 =?us-ascii?Q?0lutG7YJg/cd6uHmJ/IcSXMr5jQ12DGHKYf6ldos1cdxko16i1uljz6HZ3Ue?=
 =?us-ascii?Q?IwLAq6XLCTMv2QbcJHkcueuf4K4Yi4vob1RA71kPKZSoH6TYhhQPqTWEZ63Q?=
 =?us-ascii?Q?MEQXNz6lf0fWETMHKY7o5aQgkSadMfh0Bl+qCkMjOZ05hj1iCJA4I4TFp+Ht?=
 =?us-ascii?Q?dcqA84KeFoNmMfQBO2oauq08vbbneVDTV6Pznxr4vBHPQHYypNARyClOQpLN?=
 =?us-ascii?Q?8u/fWP5YBpYa72BaW0gZkL+yydeNlIDdoBwLoSE3kG1bihH8eEwtMYzfaV75?=
 =?us-ascii?Q?RcoLkToAxz+1TtPYx3pyErLtn74gocAYKIzA2JHDp79evRr7G45QKAkPElcg?=
 =?us-ascii?Q?IscjvvJ/+ehXEfAibP3UwniLw1d/0ewpnLl3fac/df/XPYdDbPggaiqVqn+j?=
 =?us-ascii?Q?jBbP/wO3reba46dTwzXysze/fLIcQMYmJjzBDc1xgsYZIavLKNlhtnBGcneH?=
 =?us-ascii?Q?ZXxlmjrEgGy6vO0wLdJ4DXpXXPKdDwt3h5uBnZu0D6VOpvsil5b6H8dWQqd6?=
 =?us-ascii?Q?N8T0N7zcDfUixMa2DCtB1Y8xN+tt5gky7bH1DqbKoUySYiGbJrc2TMD1B6+k?=
 =?us-ascii?Q?fQDbS8fjCOc6o85V+dLn8ErnUoVWGuofTVopDFuw5RDOFs5lsru4iDKnYfmZ?=
 =?us-ascii?Q?gy2mR6DIE2cYtnnUB3yr6Rcxd5QMLu+SjPzr2mSDVj0xwxGb/WjrxyErjIfE?=
 =?us-ascii?Q?JpOc/742KE0MLluxkHvqpY1HTe9PC6lcxFXSvmP/LQQd+J9FgL3XSDCgaNiW?=
 =?us-ascii?Q?r2mkw6inmANsczStZIjYnC2E7Z8jzndkGWOhZoRWyuBxwSBp8KLYMc9OXvxQ?=
 =?us-ascii?Q?aaPC5RZ02A6UwiWra8prTw/rpLWa8osjqv1+FLf7TVzks26/zVmGNeWXI2E0?=
 =?us-ascii?Q?5KwRSo7MRI+CZn1Cet+8A27KYOaiNXvUugww7L48JLO2PeTsXtSo6RtAvFSA?=
 =?us-ascii?Q?ogbZIfKvSyCPrhoD0L3p2LKioqe0pcsrWDqRXH2Rgn9w9ipsrcniEDACmrmq?=
 =?us-ascii?Q?KWAF5YcTYZruF+M/73LA3sB0HeJ38DOthOP47w9I0QF5YMxiGslKBv25Z9jb?=
 =?us-ascii?Q?IGBdxTIclxkDkxxbH3CJaJ5p+c7F0BphsnfbQBpzrloDrUA1U5E+J9bNZ5Jq?=
 =?us-ascii?Q?+VzU7UnMSfUnR6/j82y1p7nD9QGOq12L/6mKOS99?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 66da3038-83fe-47ff-3524-08dd52300f32
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2025 04:27:32.2728
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gg4lyOA63WwtU11awQQyJr7awnUKQD5HjlNbwvUnEheHTCIV5YP7HDdG2EuzPrr5vR7fTFiNpANGysiVTVAlyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7529
X-OriginatorOrg: intel.com

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Friday, February 21, 2025 5:16 AM
>=20
> On Wed, Feb 19, 2025 at 06:58:16AM +0000, Tian, Kevin wrote:
> > > From: Jason Gunthorpe <jgg@nvidia.com>
> > > Sent: Tuesday, February 18, 2025 11:36 PM
> > >
> > > On Fri, Jan 24, 2025 at 04:30:36PM -0800, Nicolin Chen wrote:
> > > > +int iommufd_viommu_report_event(struct iommufd_viommu
> *viommu,
> > > > +				enum iommu_veventq_type type, void
> > > *event_data,
> > > > +				size_t data_len)
> > > > +{
> > > > +	struct iommufd_veventq *veventq;
> > > > +	struct iommufd_vevent *vevent;
> > > > +	int rc =3D 0;
> > > > +
> > > > +	if (WARN_ON_ONCE(!data_len || !event_data))
> > > > +		return -EINVAL;
> > > > +
> > > > +	down_read(&viommu->veventqs_rwsem);
> > > > +
> > > > +	veventq =3D iommufd_viommu_find_veventq(viommu, type);
> > > > +	if (!veventq) {
> > > > +		rc =3D -EOPNOTSUPP;
> > > > +		goto out_unlock_veventqs;
> > > > +	}
> > > > +
> > > > +	if (atomic_read(&veventq->num_events) =3D=3D veventq->depth) {
> > > > +		vevent =3D &veventq->overflow;
> > > > +		goto out_set_header;
> > > > +	}
> > > > +
> > > > +	vevent =3D kmalloc(struct_size(vevent, event_data, data_len),
> > > GFP_KERNEL);
> > > > +	if (!vevent) {
> > > > +		rc =3D -ENOMEM;
> > > > +		goto out_unlock_veventqs;
> > >
> > > This should record an overflow too
> > >
> >
> > In that case probably we want to rename 'overflow' to 'lost_event'
> > which counts lost events for whatever reasons (overflow, oom, etc.)
>=20
> Naming-wise, I think it may sound better to call the overflow node
> just an 'exception' that concludes with lost eventsfor different
> reasons.
>=20
> A complication is that this 'exception' would give userspace a very
> implicit reason as the node just report the number of lost events
> v.s. providing the reason to each lost event.
>=20
> With this, maybe the IOMMU_VEVENTQ_FLAG_OVERFLOW in the uAPI
> should
> be just IOMMU_VEVENTQ_FLAG_EXCEPTION? Any better idea?
>=20

'Exception' is broader compared to lost events.

We may view it in this way. When the overflow node is not used, the
user detects the sequence gap between two event entries. In that
case the gap literally reveals about the number of lost events. No
reason for why those events are lost.

With that in mind we don't need provide reason for the static node,
and IOMMU_EVENTQ_FLAG_LOST_EVENTS sounds closer to the
real intention.

Given it's a renaming, let's have consensus from Jason before you
make a change.

Thanks
Kevin

