Return-Path: <linux-kselftest+bounces-16232-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C864195E866
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Aug 2024 08:21:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 531531F2102E
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Aug 2024 06:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5973481723;
	Mon, 26 Aug 2024 06:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n0Yx7J9X"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA27480BFC
	for <linux-kselftest@vger.kernel.org>; Mon, 26 Aug 2024 06:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724653259; cv=fail; b=kLmWMXWnEmFfXNyp+FkV54mNr8IUjinGsXIrlCbBCEjNV9aLYi7u8ku8TGXefOn01cs98Gz3FoKFmDCEnG0bGYwcLczAVQATKRTiS47wNX1tiF7t/lVDnOkeVjkV4kL3ikzhKlRmOG6y4c22WVUB2P1Ro4hHBdb+3gpsBrXaAoc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724653259; c=relaxed/simple;
	bh=mTExXTok57T3pbCv2o6erNKsNePndFlEPEYX8DyvYnw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DGMtK4LrVNthUoPVnPWIlqiq2CyrjrxUy/Yf2fwoUd7n7JrI/9XlfZo5gCuK+R1H/cdYOhGFlTu+pPRcLDFRuZGXE2zsUCAwpYOL3J86tF2ZdUZoScms0ZQLxvghxr8/cUpG7OQZAoTOUzkrnX2ikQaeg3b9RkVegWdPJWL30lI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n0Yx7J9X; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724653258; x=1756189258;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=mTExXTok57T3pbCv2o6erNKsNePndFlEPEYX8DyvYnw=;
  b=n0Yx7J9XDCb+bQMrWP7+YDy7JC/7p732dqR/v8hRU2q67LKppdBOGQKg
   4HpK0xUUsrJShaZV5Cicg8v0+0yZF9hewZdPsWtsn9ty5oHIj5kJzibcW
   +rAAVpOXStdgNiTLPkG9kVH9s/29caB4HN/keyOqDbWLerNA7dn1SAgxq
   AHCYW7Nsd4mcmI9g57+H/bnCjIqXfc3As+hunTn+zlRI5B9gPvEkoF9Ux
   iy67QsWgX412zb84//3cQaCC+5+vt3jCqgrS7dCwolQUtZ5el/Vbri6xY
   TRn+gEXVbuPICtZPv/OEYHUTIwu3bIxMRnryAWqps/geCU6OfeE6PQKW9
   Q==;
X-CSE-ConnectionGUID: dmjP4bE3TkiOU6boYgLO4Q==
X-CSE-MsgGUID: 0YzrS0MsQca/wieQHZG9zA==
X-IronPort-AV: E=McAfee;i="6700,10204,11175"; a="23225117"
X-IronPort-AV: E=Sophos;i="6.10,176,1719903600"; 
   d="scan'208";a="23225117"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2024 23:20:57 -0700
X-CSE-ConnectionGUID: 5iiyN694T/uAlyJ+mE7yXQ==
X-CSE-MsgGUID: ltVdGYpTTBmYVi5kqvwPXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,176,1719903600"; 
   d="scan'208";a="93132179"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Aug 2024 23:20:56 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 25 Aug 2024 23:20:56 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sun, 25 Aug 2024 23:20:56 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.170)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 25 Aug 2024 23:20:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qkZeGl9nx791D5bGir+7N3GKOd6SZVJwYiowrn3KnWgYV+UlLHVpQ0bZrcKmHE2V8M4Hj/DICYxrCjPqBMd3pNF2+um3buNCkUQq5CYmpYz01oP22URlUrmzt9m4JMX5yCEhBvFCmIgur4w8MLqflNeWXkD0cWqFhHr7LIFFyJKnHPuFPVZHsSZ9X/9nKz8lzdd/dj44HTCbkPXav8wJXHpSqqlAYm4jwwie2yD+0R43X8D7I15Z8Ia/Tech5pLr1Sw1psU11b1XFjU0B94KtgiObAsrYgL8SVr/ZEzPpDMfnPuYO1A9BoBDsoWT5Dn2y+gefkN9k7CoVVG4ZqrZxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mTExXTok57T3pbCv2o6erNKsNePndFlEPEYX8DyvYnw=;
 b=MlvAHrPl587cTQCmGV/GQVaSPtIo/q77HuCdFAnny2fo6EgPn/GLUErBLgSOLlYFmmRdY2dJ56zSi1oIBgs5d+oTuw+lg2Rg56Lahxnb5igm4lrGxfQJEtrYbxqKtaFj4Nf9fMYvDRBI9eRmkC625WXrh2dRbVIB5OP7VrdcIReixIKtjzOK8vmxU4YPtX3NQjQAI1InDa+k7HNRdOfiXYCqPhsjvkL+kdHMeEgo5kq1wLvZlbNDZBP8NPTU6TykIW2yd/KbJt9UbPdhGj2pvJUWQ6TELChsNRDuWwR86LSEb6QPcnxytLPdj3Lvn8QOTwUFScE3GjzbS/fGt08vhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SJ2PR11MB8497.namprd11.prod.outlook.com (2603:10b6:a03:57b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24; Mon, 26 Aug
 2024 06:20:53 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%3]) with mapi id 15.20.7897.021; Mon, 26 Aug 2024
 06:20:53 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>, Alyssa Rosenzweig
	<alyssa@rosenzweig.io>, "asahi@lists.linux.dev" <asahi@lists.linux.dev>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, Joerg Roedel
	<joro@8bytes.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, Robin Murphy <robin.murphy@arm.com>, Shuah
 Khan <shuah@kernel.org>, Will Deacon <will@kernel.org>
CC: Eric Auger <eric.auger@redhat.com>, Janne Grunau <j@jannau.net>, "Rodel,
 Jorg" <jroedel@suse.de>, Laurent Pinchart
	<laurent.pinchart@ideasonboard.com>, Lixiao Yang <lixiao.yang@intel.com>,
	Hector Martin <marcan@marcan.st>, Matthew Rosato <mjrosato@linux.ibm.com>,
	Nicolin Chen <nicolinc@nvidia.com>, "patches@lists.linux.dev"
	<patches@lists.linux.dev>, Sven Peter <sven@svenpeter.dev>, Will Deacon
	<will.deacon@arm.com>, "Liu, Yi L" <yi.l.liu@intel.com>, Yong Wu
	<yong.wu@mediatek.com>
Subject: RE: [PATCH rc 2/2] iommu: Do not return 0 from map_pages if it
 doesn't do anything
Thread-Topic: [PATCH rc 2/2] iommu: Do not return 0 from map_pages if it
 doesn't do anything
Thread-Index: AQHa9KIM2G3fWYOkNEKTlw/lmdpRkLI5Frwg
Date: Mon, 26 Aug 2024 06:20:53 +0000
Message-ID: <BN9PR11MB52767D9405A79F801788BFA28C8B2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <0-v1-1211e1294c27+4b1-iommu_no_prot_jgg@nvidia.com>
 <2-v1-1211e1294c27+4b1-iommu_no_prot_jgg@nvidia.com>
In-Reply-To: <2-v1-1211e1294c27+4b1-iommu_no_prot_jgg@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SJ2PR11MB8497:EE_
x-ms-office365-filtering-correlation-id: efbb22c6-019e-440d-6089-08dcc5973d1f
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|7416014|1800799024|376014|921020|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?rVIDdxFjfDK6N9Zuayc0Kj1ou40h0eMVRUVqPjE08X4VEwSEbnlf9KzrZHYT?=
 =?us-ascii?Q?/08eoHjNSJBBXnaV1Oce10TNV2C2NvrtGVHUO2MwcNhX/S3oaIyv7lY08wxb?=
 =?us-ascii?Q?2P4qYj8WfctWF5e7ffC/qILh391f+raaytAF8Hl8UY0pW+UE9q57egOrGxRO?=
 =?us-ascii?Q?JOOFRNmAgLhPQYerStojsBKgFHBwyVeyb3el2la1p8TcLOsWIX9+qMObmk6e?=
 =?us-ascii?Q?nHTY1tnYQ0FeK0h7eI/o9o70VnH3r3yyI7kNiPcxHVznT/lh1QHbL7y4htd5?=
 =?us-ascii?Q?s4mTzR2+TSeVVvwsKgLwvRkg0JobRkN84rsqAgtaG5cp69ltbPdPQ2/05zwP?=
 =?us-ascii?Q?rnFaEzB24E3f/Msv4yuxmVBBAYCLBAHS3Vs+xm7sEgvPimISHm2MPtX9HqHq?=
 =?us-ascii?Q?opy9Y/6WC4ja17If5wTbOj7Rg7Wdp9V8ag4fVp7I1iOBDqF06kcxcUALKvJ3?=
 =?us-ascii?Q?Ja/8iXkm8tTkTgvmgA4JOEH5/w6EpJg8T80OIvDJpJEOmIN5yFvwcOYIX/TW?=
 =?us-ascii?Q?FEcK60w2y1CAN8Dcri0mFEC/rEdScRuJMuNugxlB5E2vX8C26sftB72DpWxI?=
 =?us-ascii?Q?HaVH1NsiWO1yelQQkq6Scwj2qC29AEguTSGAbjQFUCcHsdyOD4m+HcBy/wQT?=
 =?us-ascii?Q?RyikDrYDv7WUiz4RcdEnf5I3+5ZEyQNePAEmmY7QXq6fz/sDTdIk5iZPuXr4?=
 =?us-ascii?Q?F/Q2iQw0udLlDaEsKI7uvV5QxdvSe62Ic0V5/feyKUcFac2OIkyded0Q59jS?=
 =?us-ascii?Q?NHwYswIwX3Yl3pbrr9YwDAiio6ZiSNdDDcTyb3gc3xUq43yA6Pr9ZgLI0vgx?=
 =?us-ascii?Q?ePFhIJqrZIsgYv/iCF9eJYsV/4Onl3nYR1fAs95mg9GOYb8+8kVXqvVLexub?=
 =?us-ascii?Q?KxQ0PRIBGRXPTMcLHSk6DJ7E+pD/YYs0gmzEhiamrqREK4cUHqLhV2LtO0Sn?=
 =?us-ascii?Q?NQzZLXDkoqd/NPiuwyEFkMF6tcU+Lx1dDPQEInsz59AMzfOIk9ERHRM/Rt35?=
 =?us-ascii?Q?219i8YFGHgNf+fLMlPyPkz15VH/+lOb2XHae9mAsn4Q98IdLid+WjK9aEuXh?=
 =?us-ascii?Q?U1enYV8xKUxKTLEqh9RRJl5+aPgkPOrLFWtbRc78kH9wX72xqo5jxw1VVHb7?=
 =?us-ascii?Q?97zW0ZoD9GkpgnlG/bmhg/QfuytcXkFRUoEDJEQ/MXIfOerKuojOJMhABayl?=
 =?us-ascii?Q?TCLB23kD+bvCL46TckpRW2+U1RHX0YAd4sYSv4BwuW0w1JkVNbcLoS5BcMde?=
 =?us-ascii?Q?t+1VjAv3Ma5QMAgPbI3YpJExvoNo5lvllmEKmwDBi9mua9/lULLoXffe8UeF?=
 =?us-ascii?Q?6F3c5Mi30ql+Fi/SWz7i4KDWhpvo82GTrvVcG5ISLfDhUbn0cGqewp3J1Qfl?=
 =?us-ascii?Q?82N17ngXSuBiqzM0xNKSGHWyWpATSfFRvbFfVRVCUqu10ltlVqzhOW1U0KKY?=
 =?us-ascii?Q?qIq1DYGSCT8=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014)(921020)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?exyAoiHpDeMcdjJ+4hLpeOGs67bYdwsH1cIm6XLuX727uJrEyKD2MKzfnshe?=
 =?us-ascii?Q?jhoA6Vf+oziym8wh3nHAEy1rjlV6NHt6zVyf+8KaCtZBfng2/otpoUvPGB5d?=
 =?us-ascii?Q?gPn9e7v2eSXFvyO6mUggsPdpT+ZaXnCUE+2/HeaVFJ+kklXPLAx0NDUcus8p?=
 =?us-ascii?Q?6poitgY/GtUQCyCkTbXu/mTQ3Aqc36izw6OJ0PNdIcZaVVY//SvkbPgYh8rQ?=
 =?us-ascii?Q?S7iNFOVZdx2CTZCBYBSdJWZzHaXCvtbwOnLtxqfcO6fX7/a3oEZq+GVaJYoR?=
 =?us-ascii?Q?f1emtdMCGqa83LtmJND29rfMztFSELzyYtEVoBcMyY8sCzZ/4axQUPJb0H2X?=
 =?us-ascii?Q?QnDhken1ePrINTB9ILOfyXgf4HDatrGfwkmeONPO0xh9ro74wwb9o20uEoFY?=
 =?us-ascii?Q?ojbYuMKxbKQYqHWw4efRhdsirNkPyORTyHGkIjRqtblNWfgO8uYOhS/po8b4?=
 =?us-ascii?Q?0CqrTITxwuUGw0cKedEi4dWPDV0DsBtzDSssTyuNrH8BuaJ3ogjJrCrSrUQz?=
 =?us-ascii?Q?MflgNALmV9h9LvYrPtWNcvOAsMNr47k9lCsxME022rz26GiQSj4CbsJXO5/B?=
 =?us-ascii?Q?WzuzHtcSIrSMp3d6gByRIYIivVeKX0yLo87pB8UZK40Vafsm/KeuvT7Z2XhJ?=
 =?us-ascii?Q?AHICUTFqseteNij2+E8X1AVQ2UhrbfqMZrq/cmpEiez/lLi75FxdGH8rNFa/?=
 =?us-ascii?Q?c4A0GQ5zezBAK8MpYXlxCgNdq25TqOTU8qsrB3tCabwXzRT3M+3bQpHoqQuM?=
 =?us-ascii?Q?sI91l2VHAIVPTdW9ybrdnKuK6M/jKfWVSsO+PpaihGLUg1HDpIYMH9DHgazi?=
 =?us-ascii?Q?rN1e+3hJJUHC8xgzu82PkkiQBlUfYFPchBXhRRU84gexkI1ZHZnUpC7UThHq?=
 =?us-ascii?Q?hHiur2SHmOy7SEvlgCM4NqkpI6l0pfoTMKcqjsxVz2Ig2GAM2L8VPxcqPv1k?=
 =?us-ascii?Q?SJRNJefo/2iytO5Xu91pXxwrdklO7jeDPkAlQHnW4nxNFCdBeKvEQzCEA8ZE?=
 =?us-ascii?Q?RoM2uUZ0yoG8AlApcEt6tyzvrhEOKTVTyEuZadpaoOCcnzVtorv/MElaF9pG?=
 =?us-ascii?Q?tlzHaZbbdxZEdlzH5/BAstTYDGk1DXlra6qHoXAOeNpVqH6bEAqnqgSaaRRm?=
 =?us-ascii?Q?FpeYCt2MUH+ftiUNumjhfBj2md9+iD3W6e1wLGZE2624WtQ5fBjUZJeDV/Bs?=
 =?us-ascii?Q?V3RR+cbHgOwbvsIGmOai1APfClb09Vj/CzIahPHABUEtri4M4P1FC9yyPS8K?=
 =?us-ascii?Q?MCskfkWbWSZobyQSi6SyYfjEM2fyYnRtAEIxkiRd0RFzY7LgMdq61hC2fI+z?=
 =?us-ascii?Q?+kvvMAlOckmA6aGwQWSpDwWE2tkeCi/iGGErMJTuRPCWTKNCJsU6jx5GjC6p?=
 =?us-ascii?Q?EdMqz0T6G8V5ujQzXN4Py677ZMqN2qg6CdiKf0aT7KF/pC7JDQtlpY+cvBTz?=
 =?us-ascii?Q?xHWz4oTX7so7iHAEUpeC0YI9JdqIIC2ubLrfMHEdYMIlqCD3zdtUu8V9Onoo?=
 =?us-ascii?Q?NWu1Ngkpg2tg8tFkMIpvz56KhEVdR/8x0Mu9viAzKk0tIorvo+zluFfSt7zD?=
 =?us-ascii?Q?jo3cpYY6StXxfZVFiaT1ldIYEg+GaFMKRdJY/7zY?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: efbb22c6-019e-440d-6089-08dcc5973d1f
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2024 06:20:53.5874
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Jnh0CGKtZq46ZoqEwBpk1Of+ZKwJO2v5L/DXFKjEX3gYy0lPND7OSPgg5wju9dK4iQifWL2FarsO8KD7siXyNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8497
X-OriginatorOrg: intel.com

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Thursday, August 22, 2024 10:46 PM
>=20
> These three implementations of map_pages() all succeed if a mapping is
> requested with no read or write. Since they return back to __iommu_map()
> leaving the mapped output as 0 it triggers an infinite loop. Therefore
> nothing is using no-access protection bits.
>=20
> Further, VFIO and iommufd rely on iommu_iova_to_phys() to get back PFNs
> stored by map, if iommu_map() succeeds but iommu_iova_to_phys() fails
> that
> will create serious bugs.
>=20
> Thus remove this never used "nothing to do" concept and just fail map
> immediately.
>=20
> Fixes: e5fc9753b1a8 ("iommu/io-pgtable: Add ARMv7 short descriptor
> support")
> Fixes: e1d3c0fd701d ("iommu: add ARM LPAE page table allocator")
> Fixes: 745ef1092bcf ("iommu/io-pgtable: Move Apple DART support to its
> own file")
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>

