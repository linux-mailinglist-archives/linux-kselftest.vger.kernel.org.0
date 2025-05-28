Return-Path: <linux-kselftest+bounces-33920-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60E0DAC641B
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 May 2025 10:20:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 967F83B62FE
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 May 2025 08:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F165024DD1D;
	Wed, 28 May 2025 08:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dis3hZt/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3820024DD0F;
	Wed, 28 May 2025 08:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748420013; cv=fail; b=jbeP9XFWyi/a5gT2wGXIR9gHr9kOnFX0WBjzem7bvYePRg7K6BXJZcHg2TbZ/PLh3SvVL6fQ4nj0INNthglXrnLy3fsoE0Oqjd9WfrSLf13j0JRVLtDbwzwMsHMYmyagnFTL0SaFgwaEOFcnLzoFRHu/3nKA7fyAjwo4IV/X098=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748420013; c=relaxed/simple;
	bh=yWbOpVSjtdKfnB43h1E8caKm4stj2HAnY8CcnLZn8Sg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eeTIcGjx5B0c5KC72KhSP5Nfu1w+LVDmr6pLclS//2t2xT4xyKdjMZKSkkFYRE744Pajm7u6iSUM9JhabvPWWXBHgYx96G/M+pDJKyspiCGjqehLrtM4aRgheh9oISWBHzR25gwLufapIa1BXzDKB0YbMGY0owk8XxGpLTZqMRA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dis3hZt/; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748420012; x=1779956012;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=yWbOpVSjtdKfnB43h1E8caKm4stj2HAnY8CcnLZn8Sg=;
  b=dis3hZt/9YfDh7iNLacC/+3r1BPNJ2p/XuDHVoxQnJxcFrUHzlKf5TgD
   nlXfEFQZ+YBz9UcwpnvFLRrFDfoUFVajdzJqm2NmHbmkHpeIVj6PaGInQ
   QgeDWQ7N9tQX7PFiomEU6w/wzfBQc0Xm8j3MmbdBPv5zJ2fUisXIG3xpo
   lhUdoBEGMUKCNTTSx4zDnoSEIbagokusCpeny1QPYlOzgfIbfXz+FpNbW
   eIG7yq4memTNYrfkeORK43q3qCzzCAmx/CPC6zYqJLaXJ8GZrxkApsMlP
   7P0AqR4sqC1pGDVc2kJQnZuWYAU3n74AUQlJDDvDGgcsnvF51YuVGwNTf
   g==;
X-CSE-ConnectionGUID: 1GW1WiIYRuiS5+W5MZiQyQ==
X-CSE-MsgGUID: v9eQpArtS7q+1Cw1ThqWgQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11446"; a="38059912"
X-IronPort-AV: E=Sophos;i="6.15,320,1739865600"; 
   d="scan'208";a="38059912"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2025 01:13:31 -0700
X-CSE-ConnectionGUID: Jr/oHg5eSpuUpIlE7mAoiA==
X-CSE-MsgGUID: tGPC1/i1SlCc1en+I4B3Vg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,320,1739865600"; 
   d="scan'208";a="148298115"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2025 01:13:30 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 28 May 2025 01:13:30 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 28 May 2025 01:13:30 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (40.107.94.44) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Wed, 28 May 2025 01:13:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O29SYSdiED7+sGCeO4+kQlMfI891Z0Z48rKLDyebMvZhOuvdV2uQLzmdRG9OMcxujkueSLGMfoNj418t98kU4KssgK9WCHX08uw4/aQNeftGLQGi16sAPR4uh+yYKn52ViGyqY6U15KmntiGst7jHcVMIccK57xefDDQgpSPT53kgb4axdmf4OmVzjd6yoH8odm315Fbg2uP8LYuDSrm3eD2mn+QnSkjtqP/Us38nmd91uv0Jc3EYoan7zazmAp7XdC1zQ/ekOImP4jErMdSU1WZGCUjIrW0hIWfHbGzmoOaXho/JYYpt9IMuoSvF36Wkgu4nuc2WzmXj9SRsUrlqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6iNzHLDbP9Wx9sY7RSvt/trhjWO60Y5U4SrirZzERNI=;
 b=vr2//2HYpdEONtSjOkuhYCy+PAmqtVcwfDDYlOvF9QbAHODGORW4vggbxy4r0X+JtUzCSq6IpxMhTGVlMm7zDwt+qmZu7SkvXYuscoQxtridHNEG0rBYQuIpbrItzUDOFTcadvke72QLDm7g3rdUB8HDWtn/d9zXoDw20ZBqAjNreBqS+5NW1m65PlOGaqytMKkgfdZoCMLmLjOOHOSERqEKOJCK/RiwIsNKTBwraTWmZPqjN4GAo7SOqSN+Si9tdhQDEBvaRcboHZVcan1WkDI8UwNft0ASpKSKhzVrYKTqo7VkP//s0HD1lCe+Z8Z5uOYfqf0AD6VS7M/PGZ3GFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SJ2PR11MB8498.namprd11.prod.outlook.com (2603:10b6:a03:56f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.26; Wed, 28 May
 2025 08:12:42 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%4]) with mapi id 15.20.8769.022; Wed, 28 May 2025
 08:12:42 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Nicolin Chen <nicolinc@nvidia.com>
CC: "jgg@nvidia.com" <jgg@nvidia.com>, "corbet@lwn.net" <corbet@lwn.net>,
	"will@kernel.org" <will@kernel.org>, "bagasdotme@gmail.com"
	<bagasdotme@gmail.com>, "robin.murphy@arm.com" <robin.murphy@arm.com>,
	"joro@8bytes.org" <joro@8bytes.org>, "thierry.reding@gmail.com"
	<thierry.reding@gmail.com>, "vdumpa@nvidia.com" <vdumpa@nvidia.com>,
	"jonathanh@nvidia.com" <jonathanh@nvidia.com>, "shuah@kernel.org"
	<shuah@kernel.org>, "jsnitsel@redhat.com" <jsnitsel@redhat.com>,
	"nathan@kernel.org" <nathan@kernel.org>, "peterz@infradead.org"
	<peterz@infradead.org>, "Liu, Yi L" <yi.l.liu@intel.com>,
	"mshavit@google.com" <mshavit@google.com>, "praan@google.com"
	<praan@google.com>, "zhangzekun11@huawei.com" <zhangzekun11@huawei.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-tegra@vger.kernel.org"
	<linux-tegra@vger.kernel.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "patches@lists.linux.dev"
	<patches@lists.linux.dev>, "mochs@nvidia.com" <mochs@nvidia.com>,
	"alok.a.tiwari@oracle.com" <alok.a.tiwari@oracle.com>, "vasant.hegde@amd.com"
	<vasant.hegde@amd.com>, "dwmw2@infradead.org" <dwmw2@infradead.org>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>
Subject: RE: [PATCH v5 13/29] iommufd/viommu: Introduce IOMMUFD_OBJ_HW_QUEUE
 and its related struct
Thread-Topic: [PATCH v5 13/29] iommufd/viommu: Introduce IOMMUFD_OBJ_HW_QUEUE
 and its related struct
Thread-Index: AQHbx6QeTkbifu9CFkeHNnpRlXIZnbPf4FyQgADofYCABvgqIA==
Date: Wed, 28 May 2025 08:12:41 +0000
Message-ID: <BN9PR11MB52767BB0CA36643D957BD2CC8C67A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1747537752.git.nicolinc@nvidia.com>
 <580a36f629402506d232052ddd20ef21ec91d5bc.1747537752.git.nicolinc@nvidia.com>
 <BN9PR11MB5276C599F23964E423CCA2738C98A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <aDDslV6ZJpxJNuaG@Asurada-Nvidia>
In-Reply-To: <aDDslV6ZJpxJNuaG@Asurada-Nvidia>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SJ2PR11MB8498:EE_
x-ms-office365-filtering-correlation-id: f82d5469-ecc9-4182-af3d-08dd9dbf6b38
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?1ZuUkwlrnVMBObuOuTs2apTs2COyf7IeMb5MVaUd6djWmhlQw00sW/XcMegW?=
 =?us-ascii?Q?MDJAq1p2bygek0IkSVZoixVBfVtwCLS2ftpFh8haS0FgLbF7eiEJL0RCL1mI?=
 =?us-ascii?Q?+zThpFtQa78uRk4UmmXinfKzvw+Tnqeub6faGJ2trIchpQKSvMKYLaPDGrDc?=
 =?us-ascii?Q?fgrtdBrVJSQ3lIP6HyBIMZIufOkEoUhgvYzGtFsMPo2U1F893dHlno7Klio0?=
 =?us-ascii?Q?9/0B4MfSigG3pu/umX3KtyjXfbkAoqRvk/FXEvM3nqhdtpfD3P004FKGN0Fd?=
 =?us-ascii?Q?OTJOZGybIRNaDgIbYPCWURGJk384QLJ5zArzFzUrVzukHS2suJZ/XjNMyGUU?=
 =?us-ascii?Q?aWrXIaSBpsbRQP6nM86HaVCFaTSSCRjp8su1HqqIqwF4B94t8Zg5D15cLGSI?=
 =?us-ascii?Q?vu1EAGj4jVFjyw0gQS+Q4KYPbpSfu7TEyBLjXFGjXmsDrAc1DjbWRjnaxond?=
 =?us-ascii?Q?k1qI8iyEQvp2zgg3i0w714M/2IR9CQf/AfNhbdbFtHtRuHLFbLIE1W1U87aR?=
 =?us-ascii?Q?TACE8wn1KwO8QRLLoV/GMiU4bGOp8bFmHufc/RhcWZfAvmrG4i9ioMQOgiTN?=
 =?us-ascii?Q?n5APMftG4EFIPbILKXoqkvW2hnN32rdHLhuJuUwcugstVXtsxYUIyZWJyKVY?=
 =?us-ascii?Q?ve/CoP69OgRkoI+seIHDjM77ogtbOwiS2GGlHbm/SuFtNiY022zXq7MmcZbq?=
 =?us-ascii?Q?mIkT6BMR5XpHfR5A1nEYitt7eDnzQUoPOJea/ov9aMq8Cx8yH8Pc+gAnuXbQ?=
 =?us-ascii?Q?hOEGE2NHOjXGbOHP9PkdtyN4qW1vPdFGNrK1PgsVD0ELqOILCxi+tvUZANf5?=
 =?us-ascii?Q?x44FTepnMtYb7tiDHV2a0pC2ecBw5BnAxh8MIfrcdw36zqIZXykoUNoy9VdX?=
 =?us-ascii?Q?Rp9MQwVay9vmuimaaddd2udR1bzbyhjIkNE6bi4E5O8Ua5w9meHIZgYW41dp?=
 =?us-ascii?Q?ftteIZ+RFrobxDBgXNc30kcUkuz4OxO0xaR0tvlMIQMrwHgsfHlhbm5ukiRY?=
 =?us-ascii?Q?2H4deJ0blzH3qj85xad2eNwsGs44iwM86i3v2GkaQsDs3xEUyO1stbksPwDr?=
 =?us-ascii?Q?mNfaknnQ8WlWcdYKG59wtGo6F6ieAKoiPv1bJj7lwHKNkoFKeuruY3DePjfr?=
 =?us-ascii?Q?+ITu1OuCqIgkP0wz6TSdciFYJpobazvHYUp9GFPDMd5sSwJCCMYb7KDGPw7z?=
 =?us-ascii?Q?6EIA80Hkt1omQcp0HuUnN/UGzxHnB5+y3VmaJMCEeCCcAwmUp+acAy/ixH5T?=
 =?us-ascii?Q?R9rConB+opdso4nX3wRf7HkGfTfWYk5oa/ww1bPtw7FKK/pnXesIiLixQ50y?=
 =?us-ascii?Q?KXhluHj8/rPy2gS3yjENAPhDRno0WGkI7M42Z/nwwKEvYiyEdaurnutHrOUE?=
 =?us-ascii?Q?kzTf6avEdxVVjUJjTHp3mZh/6GVwKbagT7mACL7UKz7Qv8++ZYE6vJ+/wqTx?=
 =?us-ascii?Q?9+53SutnJXiAewDIMWth3FEQ+XQGO0SC/deMHvEeLAkPNwHw37aON4acmR3z?=
 =?us-ascii?Q?CEbFZV+u6fkkd2A=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?29+mpyGWd7UHdxGHjzNU0x9mJN7AYjLmSBQ3NkO88LBDyqCIaFWtI6TISKJO?=
 =?us-ascii?Q?e7AWpniu99UUxWTh+wUvImfUcPR6W1kS5myxDu44dpA1llSkcGWGbcWSJe+Z?=
 =?us-ascii?Q?qBRdQLpPrAjP9U+2hmOn4fX+yc/vBbyumbkerzgJWcRQ4Raua1gDolTDADvH?=
 =?us-ascii?Q?TWDAMTscOM8gmXwUCwPzm6SwfZKyPXXvLmMhFunDR0ONeB9dJNuSLhlnmYyy?=
 =?us-ascii?Q?u4c7GROK54uo6VHe7gJh+JZGBuv31axGP8oEOquuehGQCdk0Aoc1o/3M9GDG?=
 =?us-ascii?Q?7SE6uQPnA4iW01OSODxVhC5nHUXuL1geAJHnxi3eoQ1vLzOQ1Mdz/Mu+DbGO?=
 =?us-ascii?Q?PI/IcJ+cwigwkiYujzOfl+0MBKZayd4Ax1QGcT54m6RrxLnANmfhoBmOBpmg?=
 =?us-ascii?Q?/15/jC6nFpYyHT0TSGI9wvu6V8j9ZIEV5C2ysYp50OvYOWrk1AQ7CjHw+VHX?=
 =?us-ascii?Q?4fTT6LbB4W1bLgi6Fwr2k9Z32aZWQLFTkOaSDgCdyO5Sx7emsS2CKJW56YaD?=
 =?us-ascii?Q?tHNp/7CJF5q8SQsQ9qJ9rcL/nGeEHyEdR5fh5MZaFzhlKLoF+NNTuhG8aEHh?=
 =?us-ascii?Q?5eA6jWg5898D+NK8awYYojNx95E3Br40AE3y65xnlqrLPUG2eS7V08frSh5x?=
 =?us-ascii?Q?gkCLq2r1KpZQPyI4k8XmeEc5k9Vr0LvYTgBzdbjkhWxwAL8TZ5c5TR5xlr0Y?=
 =?us-ascii?Q?piMXFm+Hfn/rJkqYrWoAQ0QtllUcVAUaPxvbCw2/FFsffIe94hZSN2DraGQv?=
 =?us-ascii?Q?PuXwOuJ5RZyXrl+gLv+NbuXsvXyKYlxDBibX/YXV9EnPZhMgdSZ1CL0PR3/O?=
 =?us-ascii?Q?dvBwOG3zCuAvMYoxJT4E8ssvCd66UlaOU91rntRkb8vaRB5dJUWMSp47/5wQ?=
 =?us-ascii?Q?oRSEOT5NJVuA12FdvBssw60YkYYIU4bb80QokDdIgt3CLJ2m6QVNdbqfX3tq?=
 =?us-ascii?Q?kf0giKbegM1UY7jJDXVgyZi1c/wrmP7XythrpOOU4rMvOKQAbJMIxW0CLjDA?=
 =?us-ascii?Q?19ffNduZ56G1K0so8gaCCH3NicFnJgJpLZvjuu+pSMkeD7Qarys54TY+xM/b?=
 =?us-ascii?Q?TAE4jDygRvVw5gOB8+EClzA0NV7jfqW2Y52Ho3zaIk2UkSzuINwI0LLndv9x?=
 =?us-ascii?Q?lBBujDv1dHkPENMvGzmISfy/029M/bWX/WVRCLj47aYtz0TORxjhO9dj3E5o?=
 =?us-ascii?Q?UDj/AGIT8vJzrnJXlr+W0/DbU1+8LVQlgUlf6Sh0Uw03ik1tLURsRyg05GAT?=
 =?us-ascii?Q?IVXVhEyroVzuSz+e3LGW9vAEvdKO4V/jLVH0BMiSA5Gl9flMRLshsMVFTqo3?=
 =?us-ascii?Q?/KUXg5KVGDwX3j55rqezc7WLbCr2eSpJMU4Rl09N8V5FTt5R6uvzgxPO5XX5?=
 =?us-ascii?Q?QHXJt6WMTmu/2BByk0pPMTjWRzm6DKONFeSex28+mVQB7qdlKPGWNI4Np692?=
 =?us-ascii?Q?05JzZkh5g33kpXvf8xefNtrvGAWXO/xb9YOr1+CJpY9yH5/jw12lZr6YM0T4?=
 =?us-ascii?Q?/TIS/nXpUhN9MMNB7TN65+9X1hclrt4GRutvDHHeReErxRXzXnRIpTG1+dVv?=
 =?us-ascii?Q?PaByjYCOlZBF8eP+y9S1ats4k7sPhcIG8oCN3C91?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f82d5469-ecc9-4182-af3d-08dd9dbf6b38
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2025 08:12:41.9236
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HNvb+FrVnfHmxIajKpkg01yb/W+kqKMfxOCeYH9kJF7g05yPrmkTx56Fw1iYlnzI1HvmN8twkr0J334IBbwmvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8498
X-OriginatorOrg: intel.com

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Saturday, May 24, 2025 5:46 AM
>=20
> On Fri, May 23, 2025 at 07:55:18AM +0000, Tian, Kevin wrote:
> > > From: Nicolin Chen <nicolinc@nvidia.com>
> > > Sent: Sunday, May 18, 2025 11:22 AM
> > >
> > > +
> > > +enum iommufd_viommu_flags {
> > > +	/*
> > > +	 * The HW does not go through an address translation table but
> > > reads the
> > > +	 * physical address space directly: iommufd core should pin the
> > > physical
> > > +	 * pages backing the queue memory that's allocated for the HW
> > > QUEUE, and
> > > +	 * ensure those physical pages are contiguous in the physical space=
.
> > > +	 */
> > > +	IOMMUFD_VIOMMU_FLAG_HW_QUEUE_READS_PA =3D 1 << 0,
> > > +};
> >
> > The queue itself doesn't read an address.
> >
> > What about 'QUEUE_BASE_PA'?
>=20
> But the HW queue object represents the HW feature, not the guest
> queue memory. So, it is accurate to say that it reads an address?
>=20
> We have this in doc:
> - IOMMUFD_OBJ_HW_QUEUE, representing a hardware accelerated queue,
> as a subset
>   of IOMMU's virtualization features, for the IOMMU HW to directly read o=
r
> write
>   the virtual queue memory owned by a guest OS. This HW-acceleration
> feature can
>   ...
>=20

Okay. Then ACCESS_PA means both read/write?

