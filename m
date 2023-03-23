Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E3166C6142
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Mar 2023 09:03:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbjCWIDP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 23 Mar 2023 04:03:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjCWIDO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 23 Mar 2023 04:03:14 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E41E4BDE0;
        Thu, 23 Mar 2023 01:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679558593; x=1711094593;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=W+aKVQywhQCqscd4beVlIC4fgtXrfbo2C/9wPQ5066c=;
  b=j59qXOeHpStoo8M9iQJZCfVK3TMgLf1QsEej9AkTuh5q0hNJUvULFWVd
   tm9vkF8b8dumbqZfQowQs5TaMEb0L5dYYNRQMu/uBidROCC0i+bQd35f/
   qgN9mW/i2YncXZQvsmYT/E6VJ3oaAGOgIPR9+Cb14DwbTHnL7hRj5trNb
   LeQ/gZZfrwSVmopLZkl8cXIqViqXIxr00LN3Diil0XQhATU1O7XRLw6Au
   5692GAM1vyGkOrEFhsxDv4ZZNwLK6YbwN45G+wqLnR6raKniHHkj6Z3kA
   AXm28JVsQp2X61AK2OcQE1s2J9M+wMV/GKJafKm0kitpovozyjsFgDl+k
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10657"; a="339458319"
X-IronPort-AV: E=Sophos;i="5.98,283,1673942400"; 
   d="scan'208";a="339458319"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2023 01:03:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10657"; a="746620165"
X-IronPort-AV: E=Sophos;i="5.98,283,1673942400"; 
   d="scan'208";a="746620165"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga008.fm.intel.com with ESMTP; 23 Mar 2023 01:03:12 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 23 Mar 2023 01:03:12 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Thu, 23 Mar 2023 01:03:12 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.176)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Thu, 23 Mar 2023 01:03:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PgkghH9nO+qJbxI9CRF190TisjYjDPrMhKcYyglbOXvuGRbJ/n+7FaPpgSlzouEDUUKdH9id2SrkgFKPXLqfSu1fMizwO5AhcCQ6h9F1MOTwrE5UZoJKGyGI3d2TIM30SykvaP6MKXlRzZT/sbP5YyCqsyrORnLjC9cmoi9vbKBLaXB3cjhn1ci+tTY96mU4TTPPRdkDo/f7KzD4Lvwqwf7WglObt1q5q4ukRCHHuUgSGd5ZlQkcJ3fbHYTdoWPPrpe4emFTHP//iY6lHaoiuiOYXNiX300UndTXHeF2f8faPrLIYFbDDVQPskEJyglQ8y/M5OP7Qp+Zz9jLWZAA6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W+aKVQywhQCqscd4beVlIC4fgtXrfbo2C/9wPQ5066c=;
 b=hAoTZg5Ue6HSiCARj2Cv6FaxE+8XERGpAOWfb5FBFoWWxVlcoX3Pv1scRPZIjf2S2tnN2qX1pWLdBLGroO2mVBD+6ZPAxpeZqF4uy/atVwRL90mraHwF4j2LBydFR/s+E+gsHpovR79uY5okutZ6vPoxbWN+D94FDUELNb5V4vO8e46lirm0JA4pnFfpOq/vvQUuwO9zjkW0IDSK6coekKnPbIoNaLG3Q/y4+mmw86NfIM+UJukooad4d50ZIpAJB1ScoFVR2qRxIWXYu7Uu0S5T3IVk/qDbWwuaUVjGCkQgBqtcoLmnfoFw1QkyLCKdJ14CTXuluzguTK/ebNx12Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by MN0PR11MB6208.namprd11.prod.outlook.com (2603:10b6:208:3c4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Thu, 23 Mar
 2023 08:03:07 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1aac:b695:f7c5:bcac]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1aac:b695:f7c5:bcac%8]) with mapi id 15.20.6178.038; Thu, 23 Mar 2023
 08:03:07 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
CC:     Lu Baolu <baolu.lu@linux.intel.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        Nicolin Chen <nicolinc@nvidia.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>
Subject: RE: [PATCH v3 17/17] iommufd/selftest: Add a selftest for
 IOMMU_HWPT_ALLOC
Thread-Topic: [PATCH v3 17/17] iommufd/selftest: Add a selftest for
 IOMMU_HWPT_ALLOC
Thread-Index: AQHZXCmDBy4I9MSy1UK2P/GFvJO5Zq8IA2BA
Date:   Thu, 23 Mar 2023 08:03:07 +0000
Message-ID: <BN9PR11MB52766681EA82A10D38ADFD808C879@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <0-v3-61d41fd9e13e+1f5-iommufd_alloc_jgg@nvidia.com>
 <17-v3-61d41fd9e13e+1f5-iommufd_alloc_jgg@nvidia.com>
In-Reply-To: <17-v3-61d41fd9e13e+1f5-iommufd_alloc_jgg@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|MN0PR11MB6208:EE_
x-ms-office365-filtering-correlation-id: d4e753ed-fda4-4e7d-1770-08db2b750985
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FMgKo/AuCcTfgk2iSU68OCyVhnMv9aHJ+qMLGAHVB/PrER8Dg2CedpUpYX2h5KDeLMGJ8dA0P+yxRL+T00De7Nh8q23NAwWwFN/HNtjiDe31teZlHMwlf+ljkAYrMq7TXqnJUilufimyPYM7Z4lNn9ufTDociDBuJX01Tuup1Oy6WpNq686Jf3Qg6PWoN9KzwLpwKQrVxsS4XOmaW+is4nw6wbaho1V3aPsLz3Wfba1I1CczVzSD0MrZAUx++gpBmlRWEjsmnCsG1Jm+Du51m2Dbwul+m3MQkHbM38kVrMM5kBA2c3DNktkEyHHqrIxxExo4xZWy2Ucm07zu21p76cpl7Vi+lD9iNd4JH0Zl6nIxNFZU4CgWcZ6SqQ6/Dg0AEyZMrgUEf66TfHD9RNCwaKJTqbEYXdveCKMG4t/+qkNTxp6xmI1z1grWTGSnGjDpqvm82LYz0dU8dPMcLYL8iYeMGlXP+YBfcXz3mwaPVVWZbHG+vC2KvkP53E+i0IG9STTbn9n6yxC0TItn9PIBDnoFfDnnqMuXlrE1cc9j0uwhOC7W4pziYwmjfWtKZ0iRlHrI+X8s5xfcVWOGkbt25rLckXzT12Di4BeV8LA0l0pMojklkqJRJk0AoH46Auiwf7Z2SwGEnhrnDf3mNrOHezgsU9yanbwCpITWDrHJDEB9cYUfAomZY78CTES4AYoxaHlxAqLWoaaqQdevPHvukQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(346002)(376002)(396003)(39860400002)(136003)(451199018)(7696005)(478600001)(33656002)(38070700005)(6506007)(71200400001)(558084003)(110136005)(186003)(316002)(54906003)(9686003)(86362001)(26005)(5660300002)(8676002)(38100700002)(66946007)(4326008)(76116006)(66446008)(66556008)(64756008)(66476007)(41300700001)(8936002)(122000001)(2906002)(55016003)(52536014)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?LtQNkgN1yAasTY+Wxs3JvnoOTELWQXfA1pUDbMQBPsyUNOQG3HnQMi1B2N4k?=
 =?us-ascii?Q?Rym+gVDXxKvutkhkViO8qgxRx3OJvt4doJTLiQ905XqqB3alNatnk5urIMPC?=
 =?us-ascii?Q?jT+sUzKLlHp8F715IuafurZg38xgPD5HPBp8Hksg+f9DVpO1TbgxqmrpYAfl?=
 =?us-ascii?Q?TG+6hn73mRrtePHwr7SOronvP43z5y5QtXhm824mr7laJvuGzx0bQ8idcqRg?=
 =?us-ascii?Q?Ln05DVw/0t5GWEzd3+QlhiinGcxD//qe5hZcPr2RsuGWvrNJ4EfKGQCBlNsS?=
 =?us-ascii?Q?lWGRF/KgRSFj+0rbCJ8Um3Xb0nOYSH6wuYqB0ave4M+DWMTLUeFw0SlCipC5?=
 =?us-ascii?Q?JOr4Gc+VwSMlTWu+zdMwwPlYoEPnRvZeoszwETbU/6LKmWjPYlo8k49zPVuW?=
 =?us-ascii?Q?PCnedDisbEGb1eES9o1OysxXHjza4EwJH1pYX3DufGEC093Mg5+eOowzlSII?=
 =?us-ascii?Q?KsL5ZuQ+TaQ8j0GPM7x1e9Gj+WxYSsNRHfsmWsMjV5HxiJfFVUJtHUmUh9VI?=
 =?us-ascii?Q?cAWyw0AX/Qy4MhxjYrzBjLDsDkr18aJW6df3cxanhpQKJ5u0KIiHFKfp8g/w?=
 =?us-ascii?Q?c8sTrRGnO1vmnKCBFIIHpatJ1TIaqzvHjzGz/NQ4jKKRuPwWtU6N3ze9FOGb?=
 =?us-ascii?Q?ycb4vNEfBeTxYynPkrnzm9JDiXlPAAasWZAuoH3POYybWCNvlripEXQM2q69?=
 =?us-ascii?Q?bZzFjUB/mM6R1L0Srk5+wMeI4HuCqatCOKFXpSxM2mesHDbqdc3QYttdEWRx?=
 =?us-ascii?Q?0juCbUtu32ipa+XNI2+8jjXn032Q4ZE+5DafecHcQzimmL5/H+b3lrLYO0s1?=
 =?us-ascii?Q?muAukPBG/0qVEpGqv3tWN/Isn79VxgG4NuZ4H3GX3rylM1YMHZaziF1fYk/E?=
 =?us-ascii?Q?Q2nJFVIPWBLZB0h3XS2sGPjyfuXnuqiW1q2i5s0qYnNnf2e2gIMsm2sALeYB?=
 =?us-ascii?Q?zS9rtZmfUvTkMKzXbYrSe1G2pLIMw22znwgbOdjDtnbnJC+AuJnzml/WX3SQ?=
 =?us-ascii?Q?2WzNuF6s7UC2E0CwKlpIWa5bk2rwJDnNbqQ8JiTcKsF73TKLwxKELzTkBZ41?=
 =?us-ascii?Q?8bOw6AsokxGJI5Zac3Ze8A9fHBSlfSPhUBSuqDB2bY9VNpbCuULbridLo3/K?=
 =?us-ascii?Q?cLw0JiZKdWyipN9QJWKQToUuGSmKtSAscXbSAoPNReujjIdHrZO4WI9lTCFl?=
 =?us-ascii?Q?C/mVR5d3UFzdtVKTK/MZmBV5jjYE4+H+WKYdL0ZZCRIqaNDf8mFxzptDNZec?=
 =?us-ascii?Q?sy8bvdpoxp+kxR7S0vRjGWIlX9ZGmLVgXXPqiY4TsF/qON88m8VH+In3H2gV?=
 =?us-ascii?Q?l9uBpPR1JVHytjoYr6Q2gZaMZOsu/9LOulJiuzv2xH+pTLd56np0iZv9AAkD?=
 =?us-ascii?Q?Tzu677Hg3fU5dF7rl/m3PH/w7sGj4ZFlx0nBsBcZ8Evf0uEjSu7/SzDwDXcG?=
 =?us-ascii?Q?L0NVSxR103OGAduJgjJRvt6cDKkc9aDzLUmoNuHIlWa8J41oN0pTW27r9Dwz?=
 =?us-ascii?Q?HHKngJDq/YLLdSuKVY+oknSjNtw0Jr9kouDpnkz7cT0O0QiKJ79kAw0HxZzM?=
 =?us-ascii?Q?9au/doAHpSFeGngexLThBg3I5lVCtmrrolzrRKrf?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4e753ed-fda4-4e7d-1770-08db2b750985
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2023 08:03:07.3473
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GPgo0h1r0Ya3sz30iDQH0HqsdIOMrF9K9PWQQ9bUGRFHIgsfsDisnnauVIWEDd3ToyTv5UaHb80ITstZEHNYOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6208
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Wednesday, March 22, 2023 3:15 AM
>=20
> Test the basic flow.
>=20
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
