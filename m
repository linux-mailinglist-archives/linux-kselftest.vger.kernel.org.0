Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E5DD766319
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Jul 2023 06:23:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232805AbjG1EXv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 28 Jul 2023 00:23:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231280AbjG1EXt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 28 Jul 2023 00:23:49 -0400
Received: from mgamail.intel.com (unknown [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 814D41BFA;
        Thu, 27 Jul 2023 21:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690518214; x=1722054214;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=nPonS+cZ19cvLbrE54usQAHvUdeTzy3tUCRpmf0JPo4=;
  b=Z0OEUiH2ny5/tT3+AbkdYFpUzG3x56GUyGwtFyP6me/2fVbDyOhjGVmN
   ZhdT4v4uXbra1BrK988UjuRYio4Mjd6XjHMNzMlvrU3hkEc4mbaX1gBgl
   gg0idXYHefeo6Q+pGgsaPss+Pvxjb87DgPbicabY75Dwd5iWkxQijTpyt
   0Ohm96X/Molsp//RjjCqgm6DqA9l5I3ZqOjo6lkC5YEkE9RaeoieuNnAx
   EB6aq8GSlrHW0pTqft70z4C75jZ635O8v1YC5P08eUoabFrXWu64RnYGA
   UONnHLdcTG7zND14/kpy69P2oWUcT5JpNbIKxX26oACAVHMvXtZPNwsXM
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="371202495"
X-IronPort-AV: E=Sophos;i="6.01,236,1684825200"; 
   d="scan'208";a="371202495"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2023 21:23:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="973885748"
X-IronPort-AV: E=Sophos;i="6.01,236,1684825200"; 
   d="scan'208";a="973885748"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga006.fm.intel.com with ESMTP; 27 Jul 2023 21:23:33 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 27 Jul 2023 21:23:33 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 27 Jul 2023 21:23:33 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.173)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 27 Jul 2023 21:23:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TK1sJezL43fC4IE0nVeFv8TDoqe5ZpNLxRAo9Sm1PmuemXxJCZUC8cuXkB7RczAHPsry6Ugrz/pF9ZJ5Qm3Dx10bwyceSzx5+YObJNySg9VSbWrPAjGxl5E3FnC9xyySET5RE/PqS2D8YGR2ufA45+F1qQ0H9aHmw9mWIaIIYZUwqaPOxeawv2alHo6Mzp7Ms9sVJ8yw647xMJAXT9QARElmeBbV2cylxDYm2/527Qo0i2D7G5I/uPIXEnasOOF1OtKlM6W1XLFZxcEmmg85BNJBNOlkHqGMZOKfmtXARD3Juro1DrSAyYyEKVe9jykRc2h842XXpm8zaqeejqt4CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nPonS+cZ19cvLbrE54usQAHvUdeTzy3tUCRpmf0JPo4=;
 b=QrUAKZuG2pdFY61pEMcPLK3biVVFH0hz5Y06sGjdyLUeHPEU4SKGyi4Nck5tE2XRo8MneDGXw8gjwzVj2eg9QQgiD7U8XoGElpLlcGsw9la0Mh+LPritP81lrKHQ6ZLiuXg8UCK3TNuYHqC9nTlzkIsKf4vVtixdDZKNcs7vt6fCdbK5rB/lWEcDE212ld1s+7iGW1TaEVp7CII8HYHOB0N3I4+8rSpuw3+2CBln6YAn/k2JOP0oJWtCbCay/DBkxXT4RGKpUFADNZm42RA+Yevxywrm6OPa1uzICCqnwx0KsioveYs3nK93QTsiYankdgVasITMf1miKgff4d3epA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SA0PR11MB4653.namprd11.prod.outlook.com (2603:10b6:806:94::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Fri, 28 Jul
 2023 04:23:31 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::8b87:d7d:f095:e3f9]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::8b87:d7d:f095:e3f9%6]) with mapi id 15.20.6631.026; Fri, 28 Jul 2023
 04:23:31 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Nicolin Chen <nicolinc@nvidia.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>
CC:     "Liu, Yi L" <yi.l.liu@intel.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "will@kernel.org" <will@kernel.org>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "mjrosato@linux.ibm.com" <mjrosato@linux.ibm.com>,
        "farman@linux.ibm.com" <farman@linux.ibm.com>
Subject: RE: [PATCH v10 4/6] iommufd: Add iommufd_access_replace() API
Thread-Topic: [PATCH v10 4/6] iommufd: Add iommufd_access_replace() API
Thread-Index: AQHZwMh7HtBVdFimekmQIHc+Kpogkq/OlNxA
Date:   Fri, 28 Jul 2023 04:23:31 +0000
Message-ID: <BN9PR11MB52764C7FE0349740358931D58C06A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1690488745.git.nicolinc@nvidia.com>
 <50da1150e2a4b7bfb51db91f72db9a4dacd4f918.1690488745.git.nicolinc@nvidia.com>
In-Reply-To: <50da1150e2a4b7bfb51db91f72db9a4dacd4f918.1690488745.git.nicolinc@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SA0PR11MB4653:EE_
x-ms-office365-filtering-correlation-id: b886d999-0c2b-4657-71d9-08db8f22668e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XrgblEYPXxsbWqZrAsUmXNjhYn8Xm4z219h1wbxol1CwN97BZknf2NDT+NVx/a/o3xgs1i5PTbw0NSo5eVgyzuWcPNHMVbu8pf66hqNtt8PucZXMaK2lXEXjyNeR6m9QZm4QkObn9j5cUm6kzGcLG3LI47J94ts19a8IzHViDMzkFOUMvXofFRIrKDJZoyCp7CxHnBYkWkwD1rrlCB7yXrxjGGd5HjBjBQEH5uY2IDdLEPS6IonswnDV2cO/mo6udL8xXpE0qS5XiAup7TxrBdtfL+1vzw41GCT09MXdPHZxKyYFBDWP0R6Vwp9JDQjS8FrNZ0NO10f+U2VjCobWgqhSMcbwhbxvQWip/eHSlebuqYCgV4kJMAKA1xq9QrUjySI2GhSgLN/YibhhXtYeJtUJvnwOPHe5a0NimSdC9eaFqp+Ug85kgnD1S7wQvdu9PqL+9aZp+mmnNLgxwloM66oi4ZIIDPvjSnU7jJrBJKUhyjeLJB35iVj9xmMh8cd25CDOQhNl3xAzorW9vGs56HCF9IyCVqBFt5jfqZXM8lJwX9Fi4DQJsEzot+xIAALupmQQvr3EVuljn+As8ipDym055ItmnDzPwpBpJkwauMxkwtl8CMREDUynUF1foDdA
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(39860400002)(366004)(396003)(346002)(376002)(451199021)(55016003)(110136005)(4326008)(7696005)(41300700001)(122000001)(54906003)(478600001)(71200400001)(9686003)(38100700002)(82960400001)(66556008)(52536014)(8676002)(316002)(66946007)(64756008)(66446008)(8936002)(76116006)(66476007)(5660300002)(186003)(83380400001)(6506007)(26005)(86362001)(2906002)(33656002)(558084003)(38070700005)(7416002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?0Cyw/SepXzmddqoBrX+FQ3WuQIFk141+07PSllxJLI9Xi3Y56/QHF9k3hu8s?=
 =?us-ascii?Q?mwW3FdEiSodwdkj2Cz80yb+dwT17V6SnI+Lwmrdq/Yx9FROkpQGc5YqytJRF?=
 =?us-ascii?Q?EEB78N141rICwm0PyBE7K3CS1yZJkuPWDGZiTSuQ+TGKIvUvg0agPhaJdbBF?=
 =?us-ascii?Q?Vt2HJRUi0kC/C/I3tbQ9eNaXKjQIhfRwDs31onoYeXoaEze30X7h7mfpTMJ7?=
 =?us-ascii?Q?FgcUsziaKiidhYrKvJTZy7XzcFDR6x3MNI8Vtm10eRs07pDdiQQmukAX3FD9?=
 =?us-ascii?Q?jJWjDkYyLPOnZ4CHcLueLavDuMTNMBT7pcBHoAz7UfWQDVhR5CULPcc4d9nF?=
 =?us-ascii?Q?XrrCCU2lDPE+9X5pAK17jQ1RcSkxlgnmrd0LkCf365rJgWvEWyRT62W0hNKp?=
 =?us-ascii?Q?3M4EQ2Lf7tAAErexANy1RBbf7uXUnHbwf8Wgs1+Jzr6Q0aOEs/6eeQ7Fe4/H?=
 =?us-ascii?Q?kUG/onOPDIXyYbs6dQiTwANKiZlJUlhJJTQhRiq+NMb3GqyMxlDQnksrLg8f?=
 =?us-ascii?Q?U9Xzk9hlP7ihH4UIDfWv87NbHEABSRizbgXCr5zHhFLIniUivKqfSrbMjQfo?=
 =?us-ascii?Q?r994aFpijypY9HXyMEO9NLm2R8WDRZRTyBLPsmeB6wcuHSTYuOlQQMyx4+dj?=
 =?us-ascii?Q?jfvqkEckr03d3k1KuxcfEXFdeKhHWZAChBEajB+phzoZHgcwvo1qkauw+Sz9?=
 =?us-ascii?Q?wwU+qlSzzzvutSyeuOEKkuoGr3WHxlzEKlOqbF9gmWPSo9lXpEFsymhxruBN?=
 =?us-ascii?Q?Bhr7S7mjcHznq7DcIShUB2CeMo+y3gsW2UhIgJH5ju6n3GjOEygi+5vWaLry?=
 =?us-ascii?Q?ImJq0ybs7XrugpZWksCJrp04ftlNPWjzFD1q8neJtV8rb9J3Toi+bkA1t/BA?=
 =?us-ascii?Q?DedC6zW7te1kjXBSiaiQ5xHUajMH+mm8ar+9EgTmZmSVmLRMGljs4j5IXgCw?=
 =?us-ascii?Q?I3VAyOa9aTndFLyenFrzDPeOWaKhBub1CUKQllgDS64dk2wzNB5F8KvnDuqG?=
 =?us-ascii?Q?rbFlqsbwA7Ix/PK9itcRcc6qQWscLEoasXSBkW8WGq4NqD+yk/PdbgoScTP/?=
 =?us-ascii?Q?mJDjFaiFU8tsmwCfu6ubJ5THw4i/HYqgMxA8kgmnjNs/jTu3ETUPw6Sr9PYX?=
 =?us-ascii?Q?MjCutV27uLaG+kNB+iv64JCpzNmOd8kFkYudfpBgcVSx2akVAdryMQ/gH1v9?=
 =?us-ascii?Q?50yQVNrAkYQeFyCicJiq7UPeckUi1LrgkkALO1X1jBLGDg4XZDSOSd/NqfPV?=
 =?us-ascii?Q?uYX4an9hw5rsGnGpPClQOKLgM2tL2ehLQTctx+AK9js3GVZykK25/Z5FaaMH?=
 =?us-ascii?Q?MB8AKAvMEECwqDASmKxF7qPzf/sRbzvKxAId7W7349jOHaYpE73gZhf9QB2f?=
 =?us-ascii?Q?8hdZNAXXOmCCrokHj6R1Vo50vK5fbYajHtHkTD62ayVRbhEm8BSEDqTwj49p?=
 =?us-ascii?Q?LM/VCOcaHH4QIPxCsVuD/jPP9keb4yGxEA55BNSHgoE/QJ6xsMaFPS2JWPeO?=
 =?us-ascii?Q?Gz3cjB8wO+QrPGwbtXHLhJnEN3+sBYzOtmeE9Ut6xc5yEFxpxKGRcFGaqtiw?=
 =?us-ascii?Q?G9Glr99GB/kfZS80dIJw2xgH2Or475tIGXQP/Uoj?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b886d999-0c2b-4657-71d9-08db8f22668e
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2023 04:23:31.5281
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VeJEACLT2BAlcNAan97SjP3mkfSYXX+BkH6cgYqKb409JdGVH/AFzixIUZ8UWJB82R4e2d+ksRmBuZQX/kENgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4653
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Friday, July 28, 2023 4:25 AM
>=20
> Taking advantage of the new iommufd_access_change_ioas_id helper, add
> an
> iommufd_access_replace() API for VFIO emulated pathway to use.
>=20
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
