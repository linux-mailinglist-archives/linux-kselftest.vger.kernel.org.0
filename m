Return-Path: <linux-kselftest+bounces-13874-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A5E29349DD
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Jul 2024 10:27:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D4011C210D0
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Jul 2024 08:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F1FB7AE5D;
	Thu, 18 Jul 2024 08:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bvbUhsxy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A29017A15A;
	Thu, 18 Jul 2024 08:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721291270; cv=fail; b=eAvRcm7riUbxpzlbfGS2N99Xgk2XN+qBxYXpIpx47wfaCGTKkBh0ftaBZ/tSVTSMcEHHgh4MvKspsNrhov07qaLU+UxupTeb7fGnBU1nH+4LXRFQFuzAuPSmzNlj1ClNbVlD6EwrvLb0keh0GjQgx8l/lsIecIcKQO/2KboyVUk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721291270; c=relaxed/simple;
	bh=lWL3N/SwqG/MPd/k6iEp/wcuumN5NMSAfGELJtu/U9U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=A36nsNOtY1gP6K8VS1+7R2U85zeLX39GUSdZfZ2X3w88urBtrqqzMPfo8RSLNNs5Teypbg2lwWK+C8leOhfgrDT2TqtwPFe3nhMuCba8+CXLzkGK2Qeyk5kdB1pN/jL/jUzwg2f30tDQUgsP8uWglB5yaoxZBg2b2CmZF/w76GA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bvbUhsxy; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721291269; x=1752827269;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=lWL3N/SwqG/MPd/k6iEp/wcuumN5NMSAfGELJtu/U9U=;
  b=bvbUhsxy9LK/CpLmB1ZRa3V+UOa8a0H+dakbqGCBNHAdZc4RtYiynIiL
   2CcZOFRWLDq/sSFPZ2tG1oCPRjV5/GN1cEOQPzscEApA8pVTJYxuKslkA
   QlPa40O569hZQUlwKZh4s/3i96gP5DhTl23I55vGtUgJ5RDB1DTSYRIWi
   zhFbAZD6d8aUq4Ucsg6xUMlA+yNSYoUt3yvyHXcUvM1uagrkCjs4R0dBK
   EJcDZzNJFzjgsCafv6fRxG4rcLzTBfUslOvYkM/Kf+skzzo4n4z1Cdyt9
   Hmi/uWvSvF1RlMHySk546mmFRA37f/UY24ZeP5neU6mX50UJ15N6i5KIQ
   Q==;
X-CSE-ConnectionGUID: iARUqPyxRMWRvckrTBiv2w==
X-CSE-MsgGUID: +y1QdaDgRpCPaizBVSMh+g==
X-IronPort-AV: E=McAfee;i="6700,10204,11136"; a="29419832"
X-IronPort-AV: E=Sophos;i="6.09,217,1716274800"; 
   d="scan'208";a="29419832"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2024 01:27:48 -0700
X-CSE-ConnectionGUID: rv+BtFxLRymnhrhuBgkOZw==
X-CSE-MsgGUID: 57muWBqVTK6ZBA5QcQB41A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,217,1716274800"; 
   d="scan'208";a="50444146"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Jul 2024 01:27:47 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 18 Jul 2024 01:27:46 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 18 Jul 2024 01:27:46 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 18 Jul 2024 01:27:46 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.47) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 18 Jul 2024 01:27:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SNf/BUykiiDbLUYUKEuHXyFC8sqqY7E0ON5VJSfT54PR7j7NLmHzCw+UI8YnbBPGJgOSD307mhyKt8rJu39fMxp6QwuND66xsTjQYA54F64KUQOCv3I/HK3PAgYtdNijR98zK0ybaYzW7OM14s0vGNCvlDftOlchu1YQAfi6Iogh7WH17ccxLCJFCVtj6uex7O7iRpP/Z2HpTQGIx+67lgKGqyhR0g8IFrZybg3hJ8E/VERUWgOxyKtnPBZg53QCGGNQNnTr3NU4gs2mt0EUE9cztmDT3lTZimGeERmFw+iFCpm+ZOXz2kS6RkYgoHfWJ37hN3UR2kvJ1Pi1maoU9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z01AwvGEHfbnspdpLXOUHb+jrWrlH1O96XvSBQRZD4A=;
 b=oHGrPu13imezOEaHvDVUWMJ3SS9BhhvNAuFRmaKe4a0AGvJlm4KncwycEYajcNnqyubt39Ba2T1mNdzJM6OPy8p2Rg//1i9NHC3DrbzQbSI3JZgR+KrfyXL/8I+Ti61MWmVlr6nNimlmSoKrmnuh9lV5/tUVjT8FDrTsQEOFtw/irAOQzN0WdMXDKob7WKgkJ14ltqzNjcu/KbKHsxz113cAUC6suV3qvlQfzN0ZTDEZdxNqmauXzcOTXRAbC/YOFC4ouBVGw7+tECpTu9nDBIpvA7/AXnzm0j3OCcBSNrY4Ji8/qDE5sDv68oVEvMAUrs9l94fBrTGsJJq0ODIEZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by PH8PR11MB6706.namprd11.prod.outlook.com (2603:10b6:510:1c5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28; Thu, 18 Jul
 2024 08:27:42 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%3]) with mapi id 15.20.7784.016; Thu, 18 Jul 2024
 08:27:42 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>, "joro@8bytes.org" <joro@8bytes.org>,
	"jgg@nvidia.com" <jgg@nvidia.com>, "baolu.lu@linux.intel.com"
	<baolu.lu@linux.intel.com>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>, "eric.auger@redhat.com"
	<eric.auger@redhat.com>, "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "chao.p.peng@linux.intel.com"
	<chao.p.peng@linux.intel.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Subject: RE: [PATCH v3 1/7] iommu: Introduce a replace API for device pasid
Thread-Topic: [PATCH v3 1/7] iommu: Introduce a replace API for device pasid
Thread-Index: AQHayTprRlqY/WmeSEKYr6B757/3V7H8RTRQ
Date: Thu, 18 Jul 2024 08:27:42 +0000
Message-ID: <BN9PR11MB5276B4AF6321A083C3C2D2648CAC2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20240628090557.50898-1-yi.l.liu@intel.com>
 <20240628090557.50898-2-yi.l.liu@intel.com>
In-Reply-To: <20240628090557.50898-2-yi.l.liu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|PH8PR11MB6706:EE_
x-ms-office365-filtering-correlation-id: 8a277c00-0b56-40e1-ddd7-08dca7037e5d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?F7HPSegbRvqLn32o5sAtuvLlSXr+gktsMLq7IPvq0rD05D56JsHVqFXbrs4f?=
 =?us-ascii?Q?YFQyH7wUUpCGoSuJVrgk6eUNkc9H5ok2mRPhQtnHEespmm1IQ5qcQU9WMyhC?=
 =?us-ascii?Q?Wb2IL6rJlF7QbpZcgnVexcEPRyE4ptZhQgvxfqCU3lEfCeCmX+Vxr75mESSa?=
 =?us-ascii?Q?1P3nPH8mR3IwfBvBOlxeuX92Cpuuo8APNVk8x8tKy9nWtqAkvcl5OChIaXlQ?=
 =?us-ascii?Q?m2bxplClqMB7lykohJlPehF9/AcgcP6kdZlam15SHWsbZj0iFtOnXQAD+yq2?=
 =?us-ascii?Q?8VAdRqi/BNyMOQN6yTairz8r6IFwM4bX6u1GYRh3VcAe9L/Pt+L0dovJOla3?=
 =?us-ascii?Q?BscHtkkq6I0wGObA/ke/5q14S5gLhojqjYtTcYYP3IE6OWyzS+vw4v1exQyB?=
 =?us-ascii?Q?MqmCZPEXLOt/KKHmoIoJCRAHMWYJTWnKbxd9nU5/O/Rlp35lvPllB4UUjgSP?=
 =?us-ascii?Q?dmdi3a+vwBZdWTV/DpQfC75DEdvJRmmY1QbtbiWijLTP525jVdAoeobHZQB4?=
 =?us-ascii?Q?lzmtqsFEf6OoMck0gFGI3tySznm/IVt1g99i5WuqL7PWkrU3PMeU2u/6SNUV?=
 =?us-ascii?Q?TiZ+49Vnpw1hJM7w+vsKBs8Ob6fVJE1A+pvUzJuLmRh/1Ot0cEcEHjt4G3S9?=
 =?us-ascii?Q?FiIXjFEZvDFnkvGlLJVXB9IfLyZVrzLmfVVK12kC4LWyoG4c7yn3rKAHh3yZ?=
 =?us-ascii?Q?/la+RE2Qf9bdKKfsA2tO7N8AjcaPMNdZHzHVJAOrm7oUb4+i7l+Wzmc4Uhug?=
 =?us-ascii?Q?rVpABL2ea2xBn252zluC8aj9peoNoim3tSsfuGtIe9wd8S8fUwKeVTbhIwOY?=
 =?us-ascii?Q?VSb4JQgXO7q/g4lN0gYjwnZ3Rnm72hRDcMnWXOWwtqfsQKdJC2bjm7zb7N4b?=
 =?us-ascii?Q?3e8aKbnwuBGeqt8byBygSCtmnBCNA0myGHLUdEsll2lgCmHCSCyVAD6+f1Yt?=
 =?us-ascii?Q?N9JCv7Iz1KYeZ1r0N+QUy9RCaHgzFV4Bs3P4wc/d6/jsauxK/tfiVc8XpAk5?=
 =?us-ascii?Q?rLYkZ7Zx998r+KNvdzaDjQLwouew5QF5SKk4xJaVGj9vQ/YZ5fGO3DHsauJk?=
 =?us-ascii?Q?IKdrloBWUnMBJHO0GYFbd2InAVFVFZmzSNyvi/tBCIJd1WJbd+N6LxYdh4EK?=
 =?us-ascii?Q?JT7eelvXwn/gOJr81zVPBaiL21kw8cYOtK9RKVJ2NScmju27R9cXybn/DcCr?=
 =?us-ascii?Q?ozVdJ1wg6PoOefNNTRjVgt4IutHKpLpOK7PBCg605UL/XpXy+7uowYIerdT9?=
 =?us-ascii?Q?MhJk+pR7ROhzgAQNMyqwX4Q1X1tJl6bcklvT5jbdV7rMa75DA4KUjTUqgwLt?=
 =?us-ascii?Q?sWEus9vlb3eoe2tx7+Yzt/ew2qeD0tiwLTB4nS4c/hGqMRI4DN/PjynyaGSC?=
 =?us-ascii?Q?R9wwOJkwnkT4WuIvSKAlDT+nq6zQ1wre9tZasHghU1LiIkdf7g=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?kb9YAU5RySFaYqjTZkCx1mHhYxQBcQaMI6a5AD4QN2oTSnVIXtQvL8faCYw3?=
 =?us-ascii?Q?UK/ZwqX/uhMTiyVmSDKOdFSnJFXC1p0QGecVGlQtTBi5KfLMyy1y2FRfCMWx?=
 =?us-ascii?Q?ouPynA/QNAj0EieoA7b8wX58auruN+ScxC3C9noleRVYK6JuUYUTf4VYOU+Z?=
 =?us-ascii?Q?AnpOE0yPCVkH1t0yCLQT5L8Y2xHg6gSNlwfID/ouWdfZ4m0XdCI1RY47vK7T?=
 =?us-ascii?Q?5hcmP5MSybNEN1PMzbUqxlkG5FrOQJkZqNzS6IOMb7SzTbVxm3g2kvCANjit?=
 =?us-ascii?Q?QzBmO4hPBuqdSDXko9LYhWYkV/VM/SJc4pCj8QTlpLdemnYYfNuZTtEa9gw8?=
 =?us-ascii?Q?MPXF6BwWO1f/8l1LdIxDgZtrJJ4ZfB8Cn/zHQVXgfhHRoK3pvA2/U4p0Qpm4?=
 =?us-ascii?Q?xEgGtGJQmV9Fj7ppdqiP/THbhy7bf7EX14JV3W5eH7YGybvJOu3sovlUAJHa?=
 =?us-ascii?Q?KUZjhDZZItDLcgDTJh6klhFkj59qGDWnNP11QYFgnYU/OgwemLFDx5oegAqw?=
 =?us-ascii?Q?N/rr2Wr+lFZRxArcIZQ9pkG3WaJz4TyV/i18tZ+MoFGnaETgTyffAwED0Ru7?=
 =?us-ascii?Q?U8iTTDrURWy8aZdkFhRPriB4oHv70DJstlPYBsMYeVT7nO/RIQVugumdgWDQ?=
 =?us-ascii?Q?h6uw+9pe5vLJ0e1rkYELbiIZ3ZWlyIulVZcdRMd8O9ybt2IcMudL2MaLfjQ4?=
 =?us-ascii?Q?3HTujW8mpFk+ohP/C0tuZtf04ZQoo39E5gFg13lUXCc5S9NQct7CZFvQMClo?=
 =?us-ascii?Q?gKZGiI2iujlZT16qUFdKkWhs/QFC1JI1lrt4eqXGaWx7LHkc2XXgvlw2yZkC?=
 =?us-ascii?Q?CIh57yzUaR7m9ydxI8oZr35AJqEV2AjJeF1TM5aLbh+3eCAXgtiV77zFTzo2?=
 =?us-ascii?Q?GxCjIe2ZOlJwvu4IAmxLpwGgVWr0Q8GwW7FqEyNJvPnwgoYnRy60mmwO+MBv?=
 =?us-ascii?Q?hWjiQMZJsIJqYbKp2BydNjw/vTQ9IYEC9llwTLRLx7a6gkASuDhVpt507+L9?=
 =?us-ascii?Q?tMhdDvEif/9o/glZLY4Cegaco3aQIG1WrVH8jEZZqQhRP6p9cX0TIXEJEGM2?=
 =?us-ascii?Q?g7VECjEso3kdTD9KjRqu5oV1qLaEU++EZ4pjhNyQSWyCZm5v4Y7HVE8ROycb?=
 =?us-ascii?Q?Dj/dYs3gbxG2caI2o+pZNd9yWqBWxyjLayagX1XDH/F1eLW0XKB6Xe2XQyX0?=
 =?us-ascii?Q?KRjph9vuQytsUMznIQvYaEKn1ZAlBEt+otL8NR719pqW6kbZmM1GsErQ/gzZ?=
 =?us-ascii?Q?3t3atbH0jHkkpwOua9sfEkAdl7ge3GOsDihYOYaLQ4IGznHchM0VBp/wfU/5?=
 =?us-ascii?Q?4CjlK0hIkAycn8day7kKMgVxztr871JguBuXxQbilx1VZhs+SL8PesBU1K/S?=
 =?us-ascii?Q?szPL0upYFRTcDZLCDppkFo/w6FIWyFMN+FLCEFb2HxcnuYN+Vo+qlsA61df+?=
 =?us-ascii?Q?QsiK8oNikQeaB5e4de6vKOalauJw7+vb+fI/QYxITaAeG7cE2rdPtVcLRsli?=
 =?us-ascii?Q?AL3su2/WAmQ9WAJMKDfpA4WwGhxLz2pGpek6ydUaDl99vtMM8BN7HodKbVGR?=
 =?us-ascii?Q?pCUL9sb76ls1njw0oGwKO/ozP8Sn6jGu9o8dMNsH?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a277c00-0b56-40e1-ddd7-08dca7037e5d
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2024 08:27:42.6562
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ypfPgXWI5G+5q9YjCSmWlaBgNOPqN84GvNtjp25bM/KFTxpL/h+RUmkhg5iwT5CLQBAJLHcB3hGQPgQZZ4HHnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6706
X-OriginatorOrg: intel.com

> From: Liu, Yi L <yi.l.liu@intel.com>
> Sent: Friday, June 28, 2024 5:06 PM
>=20
> @@ -3289,7 +3290,20 @@ static int __iommu_set_group_pasid(struct
> iommu_domain *domain,
>=20
>  		if (device =3D=3D last_gdev)
>  			break;
> -		ops->remove_dev_pasid(device->dev, pasid, domain);
> +		/* If no old domain, undo the succeeded devices/pasid */
> +		if (!old) {
> +			ops->remove_dev_pasid(device->dev, pasid, domain);
> +			continue;
> +		}
> +
> +		/*
> +		 * Rollback the succeeded devices/pasid to the old domain.
> +		 * And it is a driver bug to fail attaching with a previously
> +		 * good domain.
> +		 */
> +		if (WARN_ON(old->ops->set_dev_pasid(old, device->dev,
> +						    pasid, domain)))
> +			ops->remove_dev_pasid(device->dev, pasid, domain);

I wonder whether @remove_dev_pasid() can be replaced by having
blocking_domain support @set_dev_pasid?

> +int iommu_replace_device_pasid(struct iommu_domain *domain,
> +			       struct device *dev, ioasid_t pasid)
> +{
> +	/* Caller must be a probed driver on dev */
> +	struct iommu_group *group =3D dev->iommu_group;
> +	void *curr;
> +	int ret;
> +
> +	if (!domain->ops->set_dev_pasid)
> +		return -EOPNOTSUPP;
> +
> +	if (!group)
> +		return -ENODEV;
> +
> +	if (!dev_has_iommu(dev) || dev_iommu_ops(dev) !=3D domain-
> >owner ||
> +	    pasid =3D=3D IOMMU_NO_PASID)
> +		return -EINVAL;
> +
> +	mutex_lock(&group->mutex);
> +	/*
> +	 * The recorded domain is inconsistent with the domain pasid is
> +	 * actually attached until pasid is attached to the new domain.
> +	 * This has race condition with the paths that do not hold
> +	 * group->mutex. E.g. the Page Request forwarding.
> +	 */

so?

> +	curr =3D xa_store(&group->pasid_array, pasid, domain, GFP_KERNEL);
> +	if (!curr) {
> +		xa_erase(&group->pasid_array, pasid);
> +		ret =3D -EINVAL;
> +		goto out_unlock;
> +	}
> +
> +	ret =3D xa_err(curr);
> +	if (ret)
> +		goto out_unlock;
> +
> +	if (curr =3D=3D domain)
> +		goto out_unlock;
> +
> +	ret =3D __iommu_set_group_pasid(domain, group, pasid, curr);
> +	if (ret)
> +		WARN_ON(domain !=3D xa_store(&group->pasid_array, pasid,
> +					   curr, GFP_KERNEL));

above can follow Jason's suggestion to iommu_group_replace_domain ()
in Baolu's series, i.e. doing a xa_reserve() first.

