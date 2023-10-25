Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C8B67D63CD
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Oct 2023 09:45:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233692AbjJYHpt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 25 Oct 2023 03:45:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233814AbjJYHpQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 25 Oct 2023 03:45:16 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4BD21BE1;
        Wed, 25 Oct 2023 00:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698219342; x=1729755342;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=RK3XZgC89iZ96wT0PtM5wDAh1usO8X22ZvBAYbnzz1I=;
  b=FsuVx+zOEiNIUQSqoDIrPBTWj1cVK1Ks19BHGeILFEAIiMkOkwXuBVAz
   6NSy0+U1HcmKqI3OQwFMzyxYbNi1vyxVaiTZzcjvYC2WSqDPOGwGQVaeU
   Ui1mKhd4kbcdxSqxxZVXa2xd/kh3sB0Zw6CQuM0kcbw9xwayfANL5HiHD
   YHjFwG0geuVvHQGZ1FrT0wBWvjsA1RaVG2bwLdmMD08ADpma+U7ziLkOy
   C2CQ8eF6L8suqJu6VVuTKhunWCvzoisp6zs4gZ1yCpZ52H7v1PUAKtORM
   nNT/FyKotXAew3Tg7poAxjWMAiaWFAPB5cInX8cUICCcsPQboYV+NV5uU
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="384465782"
X-IronPort-AV: E=Sophos;i="6.03,250,1694761200"; 
   d="scan'208";a="384465782"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2023 00:35:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="824571195"
X-IronPort-AV: E=Sophos;i="6.03,250,1694761200"; 
   d="scan'208";a="824571195"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Oct 2023 00:35:42 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 25 Oct 2023 00:35:41 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Wed, 25 Oct 2023 00:35:41 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 25 Oct 2023 00:35:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jbnzh3kE1EA/lyzhQUNZqACgF4xH2xPrh3ssBcs45FfhVPlxEWHUrjKrQPc1/UhERqmYrN2wZvbnUdLzv0DDaIajmyL4pGRxzJRx7skIGRFfSqsWgZFzq9LhgUl78Dhq8n7yOxC2Z8tt2xsrSJ4nnb/aGhqOq6oZJIzdUt/M/8ubHAv1JBng7nXYo6lLuRmKEa34lCPrzTMu9/kdMbWq0GbWxBnzx7+LvbG0oiqqK//Df89LyZnolHAd2+FwvYLXJhEl2UU09KYJps5B13aveJSX6K7SzYkQg3fSPTvrtAdGL94wLcgKYjU5QXgZC9Lj87S/MOXkk4oI14B0tywhQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MV8eWhQkB+zxIwjRaNTgQLbGN6dbJB51uJr4k4+bloc=;
 b=RII3f8ByZzL1b1LJk09MKovV5YQuuZ03Yt0AoPg2gnRRrZZPHec2tvkqGX9nI8e93zBurpyHMZvk2oYyGXtjGZti4jD4PiI20ffRVHXFXVXdcIYHKI/Sj5UIFgs6z/n5MkH7k59bsk7mk360pWQKpEkITTuBIlXSjxjr3Vfm3C7CK2f8uuwMToyqU7Ry01uz6/EM0fxoKSkBW/2S19/Oyb86cwmGdhwVRbjY7aPbc3bQut5YEY7LudSUn+UcDZusYGrx7CIUYt5bH4cccXheOnA0NYxs1/4dVqzVhCleNk+IfZ5bZZEzc5tT4l8GETvSgRspV0agSuu+obuKtbLw1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DS7PR11MB7740.namprd11.prod.outlook.com (2603:10b6:8:e0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19; Wed, 25 Oct
 2023 07:35:33 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::e7a4:a757:2f2e:f96a]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::e7a4:a757:2f2e:f96a%3]) with mapi id 15.20.6907.032; Wed, 25 Oct 2023
 07:35:33 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     "Liu, Yi L" <yi.l.liu@intel.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>
CC:     "cohuck@redhat.com" <cohuck@redhat.com>,
        "eric.auger@redhat.com" <eric.auger@redhat.com>,
        "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "mjrosato@linux.ibm.com" <mjrosato@linux.ibm.com>,
        "chao.p.peng@linux.intel.com" <chao.p.peng@linux.intel.com>,
        "yi.y.sun@linux.intel.com" <yi.y.sun@linux.intel.com>,
        "peterx@redhat.com" <peterx@redhat.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "shameerali.kolothum.thodi@huawei.com" 
        <shameerali.kolothum.thodi@huawei.com>,
        "lulu@redhat.com" <lulu@redhat.com>,
        "suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
        "Martins, Joao" <joao.m.martins@oracle.com>
Subject: RE: [PATCH v7 8/8] iommu/vt-d: Disallow read-only mappings to nest
 parent domain
Thread-Topic: [PATCH v7 8/8] iommu/vt-d: Disallow read-only mappings to nest
 parent domain
Thread-Index: AQHaBozLQMNtQpVGt0+9MBdVYq4nwrBaHj/w
Date:   Wed, 25 Oct 2023 07:35:33 +0000
Message-ID: <BN9PR11MB52766B032686E89E960426D98CDEA@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20231024151412.50046-1-yi.l.liu@intel.com>
 <20231024151412.50046-9-yi.l.liu@intel.com>
In-Reply-To: <20231024151412.50046-9-yi.l.liu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|DS7PR11MB7740:EE_
x-ms-office365-filtering-correlation-id: 93b0b58e-50e3-47ce-f96b-08dbd52cf919
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jLEQzPIPdu6bztVaqkhK797eM8jNTXxho6Vigg4tskQ3nejNoomRHqtGvQO11kTMeq0eVVhifaZwovSAdrk/6fm4ZvLrqKyuwmS68zeffucT6xxF0fIRy9esmyXGbic2aCAvlUDEJpBjA8qL1Y1dBizYbCDpU2bNGLfMHuyHLiq2eso0phCklMoAbnr7v1sEw8RTcP4W/O0VtLWOr9kJRFwmWzhs+QAiKG7s5rWk6Tbxhxun4M7xlxZlLZbfvC8J2wvv7CYZr5wvLU2EiuryWhdr/qfk5rJWg6Kc7E6YfOeKheI7lcT2ovWkB34l+lzUPg4cnlXc6Wufw/lag3bxcz7xXSA46wgW/1nlLPGQZTweDZeRvkzCC28sK6fbO08XW+RXQDlEvLCjHqgVteMYQw1pPrBdjSBNJlI7RwOGtHv9i8GnpUHhuPxt35X3hKF8iDU7SAUOLrHEjUTPNxu+CvhI4RMCzxmJ5y/WsZb5hSo3lyTwbq9Z4JJJ3739fLiDqx1eAA+5joCNM7+RgZBqG6chWWJ3+Hf1ZzKu2LD8pnv9ZrNBqTV+Q6ubj2JkBdAi0MCDA2byO/LNxerdOuiv7OaQI+8ZSO4J6oh2lPekovyVqGbzDoMxhw9GCHr8LTna
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(39860400002)(366004)(396003)(346002)(230922051799003)(64100799003)(1800799009)(451199024)(186009)(110136005)(26005)(478600001)(76116006)(86362001)(6506007)(316002)(7696005)(54906003)(64756008)(66476007)(66446008)(66946007)(66556008)(38100700002)(38070700009)(33656002)(52536014)(2906002)(4744005)(8676002)(122000001)(71200400001)(7416002)(4326008)(8936002)(82960400001)(5660300002)(41300700001)(55016003)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?v+DPtWleTVFjaH8oBiLe4/0hYyNE7YLfRuapCemnXxGTrMEpHC4qf/5NkNEJ?=
 =?us-ascii?Q?nW2+lNWVDKl9Y7p3JOvkNLO8pISbaky8i24ccvgQWwejIIPbjSEu0tVi/cWI?=
 =?us-ascii?Q?EH78IRg/FyaEtpazRx8cKTPRpfrC2Imbdmt7m57i43UT1EAqOVChSCQ3Npvm?=
 =?us-ascii?Q?wleol92BoVxZo8ujzkr+pHMlU5XKyH7Aw/wOvemZVBBu1KBc0VlQ/Q5VRRKy?=
 =?us-ascii?Q?cudx2T7McEs4Ij3goh58vqGvhuO0rkpEcaCDgoUf5SdWYdmp7KIR9nyXHt33?=
 =?us-ascii?Q?QZjJrUANyaKjvJ3NibhmRl5XPj+xeg2twfRTvjJWRmFIM5fnzaFqVbMn7C/o?=
 =?us-ascii?Q?BlJf02EdnIMlmSsGsFLS6WAsLPnL2jFjPFoXFTL0qO+1oWJ54vic0bwwt9id?=
 =?us-ascii?Q?7vg4+1OdzpOKw4ErHQe+10DIZHChmQeZCVaePzSSgs0i54TWFrYZC6RZ5OGZ?=
 =?us-ascii?Q?AC6miw2/4dZjRX+URwZhzintjdPyJL1F7Upw+xMBbZMJAWsFo6m54wdwmS6K?=
 =?us-ascii?Q?AHVpb9Vhpo8HIiThb4qS+ynyNFYPFLBdpw4nKu9oct7ke5fSgEQ9gwD6dNTp?=
 =?us-ascii?Q?a+a5ceR8Hww7FNNdKwXO5p8zqPIHJcoAzVN9XsALmnXHZQqIA1cxvfS3efoP?=
 =?us-ascii?Q?d0Ycj2ynCOFF0RUMvFZx+320Mcagz5zpqUo65Wv5tMOBtvroBZO1YO8XTv1z?=
 =?us-ascii?Q?WbzBfLZTb6if3LlwigCo6ffXMpc+4ABIHtumI7ZJuxQy/5olRqvLXdRv5GwT?=
 =?us-ascii?Q?0q9yvnOBa/DJrv1GX7xE9b9e7pEEv6i+INXOeh0JKsPluCxZ5oytiuLABhPM?=
 =?us-ascii?Q?LEba7X8m2w1nvLxBiM4bALzbYdab512D8o5EwhIY7Pl/kc8BekYKfrzrLs05?=
 =?us-ascii?Q?wUJWWY4kP3obca0C8s9dx28fb+cYERa0F1UgX8FlBb5W5OpYXE4IUJrWe6xA?=
 =?us-ascii?Q?9KKkTm0OD0kw9r8DJwyIY9HMogwkWlb54q3GYxkLmxkUBk3tplYaBdtnx3VU?=
 =?us-ascii?Q?5umgithEMCcNSWdpr48HfwUOcRvkGd7b9Bv7rwn7cc7wqS9xB5+ZpmYDWfix?=
 =?us-ascii?Q?FzVO93975kiavtQOjhmn7/ehoIYGP5iVi4eI1coj1iqkVDwR+07AmDgk/ND2?=
 =?us-ascii?Q?/J1sXM2bAu24E3xYexuFmp2DvKbUPz9aLJEejK3Df1dBJ0qW9YIEZGTTbi1g?=
 =?us-ascii?Q?YV4GMd6xx7YY5DFw15hD9cG81wrglOeJJiW5qxQhn84+0Qr+YFFw4D9LU+Z+?=
 =?us-ascii?Q?rvAZut65BFWYMKNsg/BRmb0CrYoiAYpABGP/NoFl3kdkUL9Ghn88E6GHUY5X?=
 =?us-ascii?Q?DwCzQ8KW7g2M5DA8C3t02/nwntJPpIzJMgtB3GY4x/Hns1hgcu3lxG8JvPE2?=
 =?us-ascii?Q?tbm6kl3/btmYMqxZNMwsY6Q7qSHWe6NxJkTRJtcBb96GTxiL8MwDXl9TPz2m?=
 =?us-ascii?Q?7DOZZ0FRJ1XNizr9tLrViTW9BTuvfXI/ewipl3fA9tMhfLrPjpUI943mZk36?=
 =?us-ascii?Q?1Hzzga2m+NwNguzv+AcdThSpWxL+KXlk0nDfe5NKdCbEnJZ0dwJzJQTgpyeq?=
 =?us-ascii?Q?qSYbOOJ9tyiErgyAdgMXO1r3urqMvaV4mQBWJ4EJ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93b0b58e-50e3-47ce-f96b-08dbd52cf919
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2023 07:35:33.7397
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /OkARME3h9NmHlrsKWXpz58PfYBCFUwt9Rf0gGErXiT2HOMYU9bMesdOXWBP4Emj9+/UKya8FgZ1TCzDuMWhAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7740
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> From: Liu, Yi L <yi.l.liu@intel.com>
> Sent: Tuesday, October 24, 2023 11:14 PM
>
> +/**
> + * enum iommu_hw_info_vtd_flags - Flags for VT-d hw_info
> + * @IOMMU_HW_INFO_VTD_ERRATA_772415_SPR17: If set, disallow
> nesting on domains
> + *                                   with read-only mapping.

with how it's implemented now the description should be revised to:

"If set, disallow read-only mappings on a nested_parent domain"
