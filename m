Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 508526B3C18
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Mar 2023 11:30:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230488AbjCJKaO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 10 Mar 2023 05:30:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230206AbjCJKaM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 10 Mar 2023 05:30:12 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 863D1F8286;
        Fri, 10 Mar 2023 02:30:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678444211; x=1709980211;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=d4ssliP/tqc0e5zhKHt+KgtBVk8hV9bL+LIa9nHMq4k=;
  b=B7JYWSm79BZbqurQL24eJY6JNSdZuXupfgzOzDyUT5ce7Y+IZ9EsE5/l
   9B34jUUOJHRDBeDvsCVRZCWUuAB+7gLLCrTW/I0vhpEIlxCBU3MlUXZ7r
   fyOz3T1IF+17h3Fh642g4edzW3cJxXmu5MvB0XzJjXINwbQP6uTfN1D4w
   tIRdeuC35z5f4GramB07vvmTlPNpOR75luaYoAkcHGE2rR6Fg5RGEJ70K
   Rluw1EqVZ/+npaMYhcAXy2SG1qmYrpGFLp/BOmx+MPlBbt2hroys+rXdx
   QWnxDCuP1oOdMz1GdxtpW+4oe5i9BdPerYEyj2TW4KfUIul7MJYdJ0Q+t
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10644"; a="338250796"
X-IronPort-AV: E=Sophos;i="5.98,249,1673942400"; 
   d="scan'208";a="338250796"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2023 02:30:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10644"; a="680156924"
X-IronPort-AV: E=Sophos;i="5.98,249,1673942400"; 
   d="scan'208";a="680156924"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga007.fm.intel.com with ESMTP; 10 Mar 2023 02:30:09 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 10 Mar 2023 02:30:08 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Fri, 10 Mar 2023 02:30:08 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.42) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Fri, 10 Mar 2023 02:30:08 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LFd+5ee/JKZz8y+GgX8UvU5jf2xGFuRrA2Z8aU2s/s4jAjHGHcKaqHJpMl1rU45DSudAuRESxNTQzLf8jQYgCmzFcHgdzR59fV5biwmMf1ZYjtfE9WDAkkSiB40ua+Pl/lSeP2zuNtut5sFYmYQNRO6F26EKE8L/4cSAQyKFkD3qperFCYETbD7gywIrM6OIs88FK+Tt/MuhgR7yAnCayoJlxuwWsLEhUIesGPvqqV0KG05BsoBBFlcu9r12ZFAhsXNqIxXKzonmpckUBj0HaZeAnF1E264cHM3H/QiPiUDkqklPFpQJUHCJdiQ8yFXZmYDVVdyVH5v28+Y3YxpqoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d4ssliP/tqc0e5zhKHt+KgtBVk8hV9bL+LIa9nHMq4k=;
 b=LqVhmGlzMBpVX0LCb4ykNtGPpQEbF0vbFc+SCuX1Oyqhd7QP89VAK78+9szmrwsryh5hk8k5/WBeYkFHcXjgqBztX5GuxNcCwpFQGA0esFLVXOy2aByAdjKrcZ6UqTRHoUE6hMZk1lEYb36qTzXibcYl6JNzs/FN6oCokyd0RfJSm5CLZjg5oEDfg/+YI/ZBKesSvrkJKhT8WOBBlvqUE8mrIumR9+oA6EypVuTou/Z/sl1iuUoz8CIvQ8SDfdWeo0RoFWNOukLpPvVJI6RbwXalmcWBj4Vom4cWg311i/FBVrvJB75oeKhKT0nYX5ad/dzytx25pulXDkGgXgzdaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by PH7PR11MB7515.namprd11.prod.outlook.com (2603:10b6:510:278::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.20; Fri, 10 Mar
 2023 10:30:06 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1aac:b695:f7c5:bcac]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1aac:b695:f7c5:bcac%8]) with mapi id 15.20.6178.020; Fri, 10 Mar 2023
 10:30:05 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
CC:     "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        Nicolin Chen <nicolinc@nvidia.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>
Subject: RE: [PATCH v2 02/17] iommufd: Add iommufd_group
Thread-Topic: [PATCH v2 02/17] iommufd: Add iommufd_group
Thread-Index: AQHZUVX6TKlQlqx6eU+ggsNomAB6Ea7z03YA
Date:   Fri, 10 Mar 2023 10:30:04 +0000
Message-ID: <BN9PR11MB5276C05B73D475CA3D4B6A7A8CBA9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <0-v2-51b9896e7862+8a8c-iommufd_alloc_jgg@nvidia.com>
 <2-v2-51b9896e7862+8a8c-iommufd_alloc_jgg@nvidia.com>
In-Reply-To: <2-v2-51b9896e7862+8a8c-iommufd_alloc_jgg@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|PH7PR11MB7515:EE_
x-ms-office365-filtering-correlation-id: 9e2a0b74-8b69-4af5-3c21-08db215269e1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: D4rBiyGTWrkQDzJFLqlkwUqjP6FaDgYlt2uszFjh3ddbZD0mcdQBwKYRrvktLCfrbsq75WfKMktsjVi5kw48yZyhcW5zLIyFh914EQq9MgjmFYHcqVVVBdT7SKnCXfWQF4E9S8WzUYyWUPrUAuvyndzF9I+S68HYRK6htlZdVfe9xFeYSA/8IXxEi0NGORzKtD7KFEgL1JpG2idBdKGHI1xsezccwOToiYNToKpV7xA5Gg83EFUWYQCeDvMcE/lBMkJlI43SbipS3r4eyBsIs3ZmXuJKVofmFXMX1O/2iZvU4jIu8bba+x8RtQeT0rIIY6Yx80BEC+qQPpNt5O9llTsmaTYMICvp5hsjfpJ8AbF/1wOq77ZxcfC4Kt5w0jY96z25umWX6C6xbCfojTnlUoiipKZ9/LuxavfSR50gxGuzW/U36QJEtgvj9Bi3Lql+A8hcaP6yk5tVtI3I/CaU7XqPyRy3237VOqh7NLUEP//HakIcSurDeyZl5OxT5lmcHUjj7BteR9pnwJo8nEHc132jLMb6Din+kfBpkOxhWEYAFOAV0iIhQlxBmb0dEFa/xIBrgVnhBpOwGqR3yExWuVJyXLjJroQHFP2oY4ilJVWss+Pcq5wIfgzpS5DGzre3SEeXYeIhKiX0CQCR8b2ltuEKhI8M5Z2042Nsbd8SAbKxKYR0oefEcqLaK9IhpCE5b+SMsRabp14A0bfNtLn/VA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(396003)(346002)(136003)(39860400002)(376002)(451199018)(82960400001)(107886003)(33656002)(478600001)(110136005)(54906003)(122000001)(38070700005)(55016003)(316002)(38100700002)(71200400001)(6506007)(9686003)(7696005)(186003)(26005)(2906002)(5660300002)(4744005)(8676002)(66446008)(66476007)(66556008)(66946007)(64756008)(41300700001)(52536014)(8936002)(76116006)(4326008)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?EZjZuluZnI2Wtz/iMnJye4H53fs/5w9Mui6KrVnzbSI+Q/81O7YFwRfiCgsZ?=
 =?us-ascii?Q?pk7ww0vQdGzh4GRzAvAdJPbOgKRybijmRj4dl3IZgABC5ICKK4euYezmSA24?=
 =?us-ascii?Q?DmbBWtj3gl1GbeJkG/1dIAgtJiNsxfwHz9Fsyi3nGAsLtzPtWwnx1E8xeYXS?=
 =?us-ascii?Q?jg0hr4I9TKvz+cTh56dQv66PHBVIN8vGQlUL1Bt555SeWyDCTYer1yQVlPNR?=
 =?us-ascii?Q?9XLl6b4QUwj/pzCvPTtzIzEQz8WTtbY4oTbHbREOU6L0Jf3mg6azNE//CZ30?=
 =?us-ascii?Q?XHp04SSN/wQgN5jUJK5YaAvK9mxliR5cgYFCYOV6I2jI7njBmSxICqcJxu7i?=
 =?us-ascii?Q?y3hsLQNBRVaBv5QBHL3TpxS76V23veIiimNNh0heAgyW6QQGKT83Map1Gxhu?=
 =?us-ascii?Q?eO8RLFKFHLhu2B7j3zoggzPLRzAj2k0MQ8kvnVr5bf0XbNPyWu4HPlJGkIcp?=
 =?us-ascii?Q?lr/JCFgb8zZsTqgDpL2MAjOm/o6jw+RfpzPsqAkcDeImBCdMG9t6khfgbkKX?=
 =?us-ascii?Q?4sBnv+7EI2IblsdVo+9p0FYQDwIfGJn/t27E7n8yHDO7FYS8ObzMn9Q59cL0?=
 =?us-ascii?Q?lzgkUZsXSaCBfIvI+poTJIW74NrW5IHkbZEQctFEVdwsLUCOw2T+tRhNf319?=
 =?us-ascii?Q?hmTGZ7WxAss15MH14io6+6D78mI2iVN8scAYLDOUGUfu3Oiplc23Y5dl8zuF?=
 =?us-ascii?Q?0/0WJonWscNbjVCoce33Yl0jB50D0cessjUeucbjoU/Jpi+tDziFatL2kpx+?=
 =?us-ascii?Q?TzgN5ZARDGh9bDTaklesakG6jVDxUUZ7CGDWEeOLnWUKku1SgdIWutZmYPMZ?=
 =?us-ascii?Q?BRsPfBe5h2EgPzGgSFhmBpcO0lTXdTpq8NS4w51f0LozhfjSv8xJIZMNKzGF?=
 =?us-ascii?Q?CCrnjgoegFfrJYpwYTcfZeSKULq+nG2WLFYpcVXNHAChI/2J4BP3tyPs4WmR?=
 =?us-ascii?Q?Mc6LytIWb17toDuitxstcyQNChNGk4TAU63Z/oxUGo86HKYrHZVonmXwenYZ?=
 =?us-ascii?Q?dZlYqoQsPq58o0D/LBXHelcieIsUDoB91g64t1zyVqivTCigFImuc3urhyTz?=
 =?us-ascii?Q?2sgUNOlzKpYiLtYCnEYRcFYHAixQyF+XLfjm6TZZsXzAH4rV2IAR9O2V5Oyr?=
 =?us-ascii?Q?yimb0cKdy+H7WRfM1EL8cc0i/HOb0xm4zLX1UwLcUxa7uof/ZQzIV5lhj2R1?=
 =?us-ascii?Q?JaL0VnaFC+WMM5rOrAzUxpajSILHoOYKEorVyC7QiSWIbCH84p1KEsv78PFC?=
 =?us-ascii?Q?jfuRO3vNmpoWjmJ3hyX4JKLULhUaCozRLGRMWqe1rZNCPFHk7Gx+0AifLBOV?=
 =?us-ascii?Q?H3PKW8fZTxsNjE9vvdwhk/D7PEY0A2T+EGITMAl72ClC3aQi4oCQftkvVg/7?=
 =?us-ascii?Q?6X2R+/kMH9F2bExBbxiT4jmflE3kflPf/enPZ37W+6tx57djyarH/zrYBJLz?=
 =?us-ascii?Q?YhLtbatJHbC/7yuHVr3TVBvZZYs9QR1fWoF6tIQW7xf8LYPtcKnSoLSbTq56?=
 =?us-ascii?Q?B2F5TVFmqvK0cxTpoj/oPMRt50xPZSmO22XKCFj857l5bG2RvrkRrztm+MiL?=
 =?us-ascii?Q?NnX7jLRXOEZFXD7ns9Mai9vi1COmwFK14tzajqT2?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e2a0b74-8b69-4af5-3c21-08db215269e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2023 10:30:05.0304
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gQb7x2Lt9jmFHx+66y6hVATLgBVuxHsD1+UamZwtjQMpkHXRfT4eA63y2q7HF+alFAl3zBWzhP3uppK7FiSAoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7515
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Wednesday, March 8, 2023 8:36 AM
>=20
> When the hwpt to device attachment is fairly static we could get
> away with the simple approach of keeping track of the groups via a
> device list. But with replace this is infeasible.
>=20
> Add an automatically managed struct that is 1:1 with the iommu_group
> per-ictx so we can store the necessary tracking information there.
>=20
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
