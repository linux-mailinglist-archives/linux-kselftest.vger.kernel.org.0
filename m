Return-Path: <linux-kselftest+bounces-42175-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B114B9921B
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Sep 2025 11:29:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1CC017CE8F
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Sep 2025 09:29:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84A2B2D6409;
	Wed, 24 Sep 2025 09:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ViwUU/Af"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0563F2D8783;
	Wed, 24 Sep 2025 09:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758706108; cv=fail; b=GCvogERNkn+OOE4IRvVG4iExBamNLvAQLLUIB2qZXCsYxvxJQdx5ox14Cc6YgxeIKBNRUQVKNVhVN4mO1G4YJm5Jb5AqJmtk+ZCHF/VM40XbDVAN6RW552BYG7P3Y/3M2Y84W5E3TdYpnI0+/1yqZP5gtJ0uz0mAa52hF6PTIl0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758706108; c=relaxed/simple;
	bh=m9UxCSrM0WgBkNkWILZmmGGNzHb1uyj3bx+zgInGjq0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HODcskfpArpidWGa/jpTGihlEPGdYltRKwJSRGNilTGiOm3a99AlTiq1vaRiwa+JHTowdShWv230yeT7n8D0J8dQQAxCnSl8uWlyZuH2gbjHCw/TXKCw2WltOBStNtZker8visMDenKTWy3j4sH+U0S1IFB+8X3zPXwhbNlp8Sc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ViwUU/Af; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758706103; x=1790242103;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=m9UxCSrM0WgBkNkWILZmmGGNzHb1uyj3bx+zgInGjq0=;
  b=ViwUU/AfAxBX5ibzmcp6eoPGieTmDcH0i776qPd3nzbrXHPkasGpmV/t
   vG3h2kltpqIM8w1qsTYLW2LDwoOazLu20OYXW6kuPWGnOq62bGZ+X61OZ
   dB41BWS6mMZaWBFrPF+L4obhmnhEhNwdbTu4slzgjcW3iH3PA28ZKYv19
   bpcecL6RSe69iIfV+gtm/jSr42QmlcPLATInojEXV8PvRuY9xTDjBdM31
   Wt3aMEp4eMC2mhuK6f5icarglbVqrikzlOQvn9BhZIEi1iU4jgO+P+JM9
   2MBj6zGIroZtkI81pm3eE6+NVq4WFj0UGeRXOwSb6HwALEX3umEtKzSet
   A==;
X-CSE-ConnectionGUID: KHcvtLF7Szyk+YqXPU1dCQ==
X-CSE-MsgGUID: Qw6Tg9kGQFmqqYYo3g6uug==
X-IronPort-AV: E=McAfee;i="6800,10657,11561"; a="63624472"
X-IronPort-AV: E=Sophos;i="6.18,290,1751266800"; 
   d="scan'208";a="63624472"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2025 02:28:22 -0700
X-CSE-ConnectionGUID: j0UvwIpHTPCMijPoTE9pSA==
X-CSE-MsgGUID: mpV1PvnhSBOwZuGOLTACRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,290,1751266800"; 
   d="scan'208";a="181004603"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2025 02:28:21 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 24 Sep 2025 02:28:20 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 24 Sep 2025 02:28:20 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.69) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 24 Sep 2025 02:28:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PyphZWGeZ0aRcuyA2xI4d6NkqJXqyvQqv6CVKoSYowPqHXoJ+E8twj8alspUiaaS3IF/wvFtEzsoeF3H1PrylviOmiJ9YKAHih99IqRYWRGRwbLJDfM4QTCa6JfWdksWHQlDU2eBLwD2SA6GlLAmPHAdqbKqTYhyS52gBGSRS2UV0jwNzm+ud91I8Ild00edez8+nztescuu/ljFfChbYxzw2Cxo6+xlSSCY14z53uBzlCb07jonzSBNdptxk3whyDZEJ5KxyxnG6O1RGKPpnjvptD7/Ty3iPH1xUl9dCwawhWcGxGXvZIkdhaaPts3q+25dB3BY92IUDStTh6wy3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uBQUSx+MDcFY019aLELI+ivrIB20/hHGZe9YW6wBsPI=;
 b=YW1wr11qd7gDcngTujAIq6Y2QN0HK2aBlgaGsHVFIJofpvwilWSs3yGAQWd5PS8wFZ6jLNM75epmeDtpni3A/wazMW3rlN6cSLqDWUJYjlxVNFEtuqaWCNi/hlXVfYK0nsvdLUv9u8md7xOrwUmky9w+nW2U6W8P1yiSGuR/EEODylsciJbuul/oXNhKOKf7CO+hyA6AtMDm9CYqGqMRUuNddb6Etl8GR2naTA/NPzdFuBhdVFkbgCflVjmBsDCCUACiuXVIZdUPgjw389vcAhf1HrjujtT0dSOrsV4xlCmUzTquiXcdb5Q8uI+T8E2RHswEqbiSLs3YQzMLtSkVUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SN7PR11MB6897.namprd11.prod.outlook.com (2603:10b6:806:2a5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.20; Wed, 24 Sep
 2025 09:28:12 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%5]) with mapi id 15.20.9160.008; Wed, 24 Sep 2025
 09:28:12 +0000
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
Subject: RE: [PATCH v5 06/15] iommupt: Add unmap_pages op
Thread-Topic: [PATCH v5 06/15] iommupt: Add unmap_pages op
Thread-Index: AQHcHPrE6YwNV5JzRkqrJQzB9dWsZrSiMBrA
Date: Wed, 24 Sep 2025 09:28:12 +0000
Message-ID: <BN9PR11MB5276277E4171547C0B5F247D8C1CA@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <0-v5-116c4948af3d+68091-iommu_pt_jgg@nvidia.com>
 <6-v5-116c4948af3d+68091-iommu_pt_jgg@nvidia.com>
In-Reply-To: <6-v5-116c4948af3d+68091-iommu_pt_jgg@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SN7PR11MB6897:EE_
x-ms-office365-filtering-correlation-id: ba99fce0-70b5-46df-58c5-08ddfb4caeff
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|7416014|366016|376014|921020|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?vJsMVoHGiSiympNViPDyRRSxOJSrsw1Krglu5OLj4iyw88J5c6ZUlkiZE/ce?=
 =?us-ascii?Q?hjFLquKQejsA18GamMcSeI8+KNXAbvgfLA8OL97PZbghjv+1SXDjG9aSVDw9?=
 =?us-ascii?Q?UBhALPKxT0bOR9TLMfbioisqTOsAz+mbV/lasM9VdhcrZq9r80RRCwREXGC5?=
 =?us-ascii?Q?s7J4//W8bsOiidQu2Jr2EuKkHKKH/5Hcp8c75+FL7KgySgDTcBeH/6v3I1jM?=
 =?us-ascii?Q?iNr6PaQqsQLhecP7KtRU4d2uAKoQ+9nMn2Dhm/E4nGW/0p+CGG/3qvnl9h1I?=
 =?us-ascii?Q?tRhfgombtT5huyzD8kK4xZJvCxZer8vy0wjA+lZrWfWl0iyHk9DstKRDauiA?=
 =?us-ascii?Q?DTAmm60jsBlgjlb7kBiPSkh+BE4f66BZW7GL+k1M24uGbt41FRpo9L7Xm0fF?=
 =?us-ascii?Q?lLdaRwodvZk72ZogAFSsgz7Ox5B2bLmah3G6v6qTeB5WMYj6Yc0Twf0JiAl3?=
 =?us-ascii?Q?b3rVZxYBqKfbm8/p+Al7azNJuPbzogR0yP9dpebrIIsybY27AWuyjGsRSflg?=
 =?us-ascii?Q?bio2Mv+i3OMl7/H10D4+yxPpgXbYGJhvv49i0iWeDQDALlpTyrwBsu5710mI?=
 =?us-ascii?Q?ina+Gs6bTkhX720zSuA5ZoMEnRX/hpQ4XbTMAAguGrY1DKYe/HtsvAGkx9ql?=
 =?us-ascii?Q?BHr0CvjT8s0LH74NIaFj+o2hwouFrStX05PyYAI9sb75YF+Bh220b2gjDZ2T?=
 =?us-ascii?Q?NMQIExCckCQb/LV7Qsl2ALmt/vJO4PomHN55p2A64Vo3sjlWJkmZKk/j47p6?=
 =?us-ascii?Q?xvLcriIVVz6znpeHXYE8ri/lUpXV9Hj9az0cvGQwh2lzlNZaAzxFK0y+wV2O?=
 =?us-ascii?Q?7kT3DSGVXqokyhe0K1vrAweh6jmzM6LZWRsbF49IvSGN8TpOGSt5d7YMGMOs?=
 =?us-ascii?Q?RwzlPeUA/p1SSjBflu8scb1+JxXulD/bzTgPal9vNMZp4n2+D1gcB0SUVymd?=
 =?us-ascii?Q?+nMqb8Nxw3nEdkC0ZdtAPfoIBduWACDkxSGO2pn+1RIIvN63nJJxRgovvmgk?=
 =?us-ascii?Q?IxCWqRfU0Kpmu2h/ZY7OKIk48XrmkvRrSLtPByzp2kPH6rHJNxCQ2x99qtj4?=
 =?us-ascii?Q?n6zMzGzX6/pTaoZqBigT36AjLF0u4eTOZnzd78bF812O6/jC5wS8uvrSEg8o?=
 =?us-ascii?Q?yMpwcVK2745T6dPwhb5ARGFbOUt/qDek/jodowj+SZ3xp1U37i17NDS6xGaD?=
 =?us-ascii?Q?QlHw9nzCQJ/SqV/beh2zwqRQ2QeVODbH1d8Bg+M6g5PJnb3w9eesRAkXl7kh?=
 =?us-ascii?Q?EeiELOI8yy2pYmPFQhU1pLb7kaVjXoR26DadZtEbaLRzt/W18HqpfqrpzYPd?=
 =?us-ascii?Q?0u8W4h7PoPYeUXSB31aj4azn9n2zycKkeZDavDHmZhxyHVoAdbq+8B9FF/7y?=
 =?us-ascii?Q?HhJKTmvOfOexNTh4s+X+8cCwdFYnfUW+9dsFp3UAzYKEhf1C5980JKo8KqX3?=
 =?us-ascii?Q?p3ZglM0Mx37zeMPQxe9rf+0x8LKK6aawHAFhBu0ycXXJppQnaL+mh1lJKBFy?=
 =?us-ascii?Q?skWpEKKQUtUP+XM=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014)(921020)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/KcKLHXeXmVC6kCjPkGTMqNjGkWEM95YuRgvaJ6ktw8RF0sATV0yfYxYwpiu?=
 =?us-ascii?Q?pK4cIt3cNizOAtRnlscC0UBo7BbiFptAdD+6tGvKj5/1ftDoU8da+ToxRYEH?=
 =?us-ascii?Q?XNoawE9IGlmrrHuqPAPiQHwZqrMDijevgcySQyMzoCbbL1iZO/g/QFUp0Wlf?=
 =?us-ascii?Q?lt2h+ITsoR9sIzCCWX9FhbHH15x3F9JESBc8HD29nSdNJYzSgVmBuslVXNB/?=
 =?us-ascii?Q?Y38RHnSdfqAQ6OJFdTtYRcHCLT6q54uVCWL7ay0jx5KfMYXKCPob9bvr2RB1?=
 =?us-ascii?Q?1e9dzT82oL0mEgv/0Io2hw6kUfzlsbamhfsBPz83hkUWB44dKwdTHWmnmCwq?=
 =?us-ascii?Q?36RzKdoReeCIBb9UANIgi8DutHEDSGTd0s3i2iuwRhZ0beRLBYKr2dOW6o8e?=
 =?us-ascii?Q?bV1Yqav/1VTSUdm5Ayvk8w8l6QuSZtcAf3dh2LYzvLnHnDcntok1xx57Qs5P?=
 =?us-ascii?Q?dChuW3G6FAl8RIOLrKSZRoH7bcB7ECZGY3NgjRbJqw+yyvJNb856hS1PMLO0?=
 =?us-ascii?Q?KM0ce4kXr/lurrka5QKQlbZRHvYqpyMw/Hbfv9VO/SpIUCvIo2eArRkwvuei?=
 =?us-ascii?Q?Lko1LYvGkFFb7PbhmmuyskoOdkYTuXuZr8EFjZ8zr6nh7T5sNARaaRDyWvt7?=
 =?us-ascii?Q?6747TCtuLgQUipu2iyCSehbzoHMJlF7TCz0ITkGi83GvPiU9QqPje6ZVEaPD?=
 =?us-ascii?Q?Vdxmd/sOG+8PmChH9uv4+tVrVUf1X5Oc4V8srdBzNiyDWII3amSmReBWjLeE?=
 =?us-ascii?Q?ON7iaXr3fueyyVKq5uFmipOzihkCEjpKBW2Abi21X9xo+PDCBFp9lrOpLNq8?=
 =?us-ascii?Q?gUr00L4rdcGlvO6J1nW6hIFVAy228Lu78WQxJDZ0R5mGx7D73mb3hM5vwqxr?=
 =?us-ascii?Q?W5rXgrIFTAXdRAA+Vjd9JwQbT6auneEpfaGhiQrEksAwk4fg5R4zIDUKTEoq?=
 =?us-ascii?Q?4b+GRbFYnvSXiRcIq8iXTwcOwlV1OSqYtN0LLAEqpdmGHeDxHm10YtYX4w2x?=
 =?us-ascii?Q?SRQRku3OwJqwnXDJBTFpizwN1Ii3VG4jl5ONHeLk1pB80cKR4USpEAXH3o29?=
 =?us-ascii?Q?+9k5NbfvuYhqhvw2DTuG6o2Ah7Y+FaZ2iycak2ondhdehmCCVqSzb2BIBnUV?=
 =?us-ascii?Q?EtbZBuLdP5SXvJZBXara8g6hlKNWxpXpDpqEGebdD7DR5iFS4gqPutWYAvyv?=
 =?us-ascii?Q?UVlUt+zMAAXuku6kBB+ofkNNDkua7n0H3Zuu6QyF41xZoz7L+zFopo5I8Xou?=
 =?us-ascii?Q?+ri3D2pqidw792gVptmqbb9pN7ehYmUDf9bxkC06Gbl+VGQyO8b5+1VRr54Y?=
 =?us-ascii?Q?yigrlGHn094ZLEtmxpi7OxCMqFecvxkF+esAaftOiWeJvbOsftyWHr1a50+d?=
 =?us-ascii?Q?CwZHO3aEQxBSRgzWNSwovrg7TM0LkmjrmeAVQPqGUiV8ivFJABW05Zrwtl/8?=
 =?us-ascii?Q?x9ZfaqzCnGkYuMXeQfAtbPZ/Wqlsf2Z4J3UWLAi44eszeeaA7876PTRYg1KE?=
 =?us-ascii?Q?1g6IJHVezRqetp4gwwj4fp64rc7/3RDhBVJ0oQntSrNAU3dJsmtHQCWqbxB5?=
 =?us-ascii?Q?s+lHHp9R50p44o9Ooc6HIeIux+gl+xNoyXQCDDiK?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ba99fce0-70b5-46df-58c5-08ddfb4caeff
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2025 09:28:12.8077
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZWxd2SvozmR125Ow31WmG5lZ1pcNsMaOCRGxp+yitVAWDHizmWmrsv2DUlSU3o9slAU6vEwLvlExSPz4Z549+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6897
X-OriginatorOrg: intel.com

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Thursday, September 4, 2025 1:47 AM
>=20
> +static __maybe_unused int __unmap_range(struct pt_range *range, void
> *arg,
> +					unsigned int level,
> +					struct pt_table_p *table)
> +{
> +	struct pt_state pts =3D pt_init(range, level, table);
> +	struct pt_unmap_args *unmap =3D arg;
> +	unsigned int num_oas =3D 0;
> +	unsigned int start_index;
> +	int ret =3D 0;
> +
> +	_pt_iter_first(&pts);
> +	start_index =3D pts.index;
> +	pts.type =3D pt_load_entry_raw(&pts);
> +	/*
> +	 * A starting index is in the middle of a contiguous entry
> +	 *
> +	 * The IOMMU API does not require drivers to support unmapping
> parts of
> +	 * large pages. Long ago VFIO would try to split maps but the current
> +	 * version never does.
> +	 *
> +	 * Instead when unmap reaches a partial unmap of the start of a
> large
> +	 * IOPTE it should remove the entire IOPTE and return that size to the
> +	 * caller.
> +	 */
> +	if (pts.type =3D=3D PT_ENTRY_OA) {
> +		if (log2_mod(range->va, pt_entry_oa_lg2sz(&pts)))
> +			return -EINVAL;
> +		goto start_oa;
> +	}

it's not typical goto a location inside a loop.

Actually even w/o that goto, the flow will continue to...

> +
> +	do {
> +		if (pts.type !=3D PT_ENTRY_OA) {
> +			bool fully_covered;
> +
> +			if (pts.type !=3D PT_ENTRY_TABLE) {
> +				ret =3D -EINVAL;
> +				break;
> +			}
> +
> +			if (pts.index !=3D start_index)
> +				pt_index_to_va(&pts);
> +			pts.table_lower =3D pt_table_ptr(&pts);
> +
> +			fully_covered =3D pt_item_fully_covered(
> +				&pts, pt_table_item_lg2sz(&pts));
> +
> +			ret =3D pt_descend(&pts, arg, __unmap_range);
> +			if (ret)
> +				break;
> +
> +			/*
> +			 * If the unmapping range fully covers the table then
> we
> +			 * can free it as well. The clear is delayed until we
> +			 * succeed in clearing the lower table levels.
> +			 */
> +			if (fully_covered) {
> +				iommu_pages_list_add(&unmap->free_list,
> +						     pts.table_lower);
> +				pt_clear_entry(&pts, ilog2(1));
> +			}
> +			pts.index++;
> +		} else {
> +			unsigned int num_contig_lg2;

...here naturally.

> +start_oa:
> +			/*
> +			 * If the caller requested an last that falls within a
> +			 * single entry then the entire entry is unmapped and
> +			 * the length returned will be larger than requested.
> +			 */
> +			num_contig_lg2 =3D pt_entry_num_contig_lg2(&pts);
> +			pt_clear_entry(&pts, num_contig_lg2);
> +			num_oas +=3D log2_to_int(num_contig_lg2);
> +			pts.index +=3D log2_to_int(num_contig_lg2);
> +		}
> +		if (pts.index >=3D pts.end_index)
> +			break;
> +		pts.type =3D pt_load_entry_raw(&pts);
> +	} while (true);
> +
> +	unmap->unmapped +=3D log2_mul(num_oas,
> pt_table_item_lg2sz(&pts));
> +	return ret;
> +}
> +

the rest looks good:

Reviewed-by: Kevin Tian <kevin.tian@intel.com>

