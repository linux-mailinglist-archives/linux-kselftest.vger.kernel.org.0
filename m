Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BF9B7AFBA4
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Sep 2023 09:04:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbjI0HEi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 27 Sep 2023 03:04:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjI0HEg (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 27 Sep 2023 03:04:36 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9B14D6;
        Wed, 27 Sep 2023 00:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695798275; x=1727334275;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ObhmNIX4B/8L5NuHAfH529GKdit5+xcrRdsmm5KDqbY=;
  b=g76X/l3U9ZgJE0vaUjPb7lH6Wb24azi7C/glPr/MJ4o0zlKXtae6W9Vk
   Wvpjq3Vng2kePgpfBNbk+Q6lH/teZ/8mFo8rUQvW5Ju+zhaT2JJhE2gUr
   HEtFn0tbyN336IBKzVgwp5pLcQIFG2QDMiXGeqQTTYYwtyKKKryaT9ABD
   hAJOcgjdb7kca34x0EjNgsblcdx+2unBog7EiUK/GIdu5ZMfKpvF0Pwt0
   10WWsmEyX8eo5oSnjddoaE8dsfnME6RrUBPnZ3gasriAIqhd3JI5QkJfZ
   Howx6IKWpESTHPh4wtDKmpszYMdmxmSNj1gA9yRRghIo8A8I0+wZ7/qAg
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="381648677"
X-IronPort-AV: E=Sophos;i="6.03,179,1694761200"; 
   d="scan'208";a="381648677"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2023 00:04:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="1080016698"
X-IronPort-AV: E=Sophos;i="6.03,179,1694761200"; 
   d="scan'208";a="1080016698"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Sep 2023 00:04:34 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 27 Sep 2023 00:04:33 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 27 Sep 2023 00:04:33 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 27 Sep 2023 00:04:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gLs5kbrv37aztfhy7kVbrT4K+Bh5ocHwt39PMA9GswtiXoEXZPeoiWlprqY2jtUfUw3bERVRmP4VBSEiymefym6sW3U6Y3sEu2nTRPD1md5RIZ2hnnqapS8KvWjRGT+Y4tUNyRs//tlUpYrvwcq3bosNwFPqAe6PvZ6AcyQHFXV2OXXAalFvDwMqkW/qwdAO2VDArg0sglZxiQYvjuM5Xz2+TWeimR/cAwB6vodWfDOqpJudXalFfKJW4SpGNV7yRYhY9FUyO3cagLNGQyqGWrtAeTCZTWCO14VZVDAQdNKh/DAQPhEfzUxRv4pjN8zm8MAyzBKemC6tcKMajhKduQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ObhmNIX4B/8L5NuHAfH529GKdit5+xcrRdsmm5KDqbY=;
 b=U4QWooq2BfR1PcVdlNSD3Wer185ZyOG38SOuYEPqlO5WCsp4W0/vP6a3u5agRG7ZwErpjuFb3BaRwsBNEvIbU9RSYjAaUJn5Ol9iOLhvwKDNwfW3J+XnmEzxt4r24cHqPOJFlb1ZO3yE1Q5rhRjRswCWROK78m3jdJu9+Ic78QiHonDcSSHLu1141cCfaEc3axjg+qM1fxCiJWP8mff+cglz/LEwbJhvz7ljt9LLlsRKQ6w4d7cCnwosulR4ckZ5R2GubXAaJJpoTcF41aSXC0jl2+oL9O39IhMZZSVmIdUJac5TgsOuYpP4awDR+qiH3XBtd6RFVnoXFFnvTAkttw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by CY8PR11MB7267.namprd11.prod.outlook.com (2603:10b6:930:9a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Wed, 27 Sep
 2023 07:04:32 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1bfc:7af0:dc68:839d]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1bfc:7af0:dc68:839d%4]) with mapi id 15.20.6813.017; Wed, 27 Sep 2023
 07:04:31 +0000
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
Subject: RE: [PATCH v5 11/11] iommu/vt-d: Disallow read-only mappings to nest
 parent domain
Thread-Topic: [PATCH v5 11/11] iommu/vt-d: Disallow read-only mappings to nest
 parent domain
Thread-Index: AQHZ7GDx4grbuXbuGUS8prD2gWWqDLAuSNxA
Date:   Wed, 27 Sep 2023 07:04:31 +0000
Message-ID: <BN9PR11MB5276E140C0BFAF35D8E7CB4E8CC2A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230921075431.125239-1-yi.l.liu@intel.com>
 <20230921075431.125239-12-yi.l.liu@intel.com>
In-Reply-To: <20230921075431.125239-12-yi.l.liu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|CY8PR11MB7267:EE_
x-ms-office365-filtering-correlation-id: b4b703ab-6851-47a1-90e1-08dbbf27ffcb
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 94zmkhUcQaXc8zWwx4tKMmdiWOn9AssZad4f/aenmpraoX4pDAWA2MOvbTFqcs7c5ki/7SVBl8ZoFBdB7JPkvLJyDzHk6z0WURTiqRjCUuEGLwW4AvtXTN+kBM7iObDqPDE8nAjnkDraw41Xw7m4QR3YRq5UmuokC24PB9qgatnhG4Dwp0yjpJ5cSE+sjmFL51zItvhn3CJYlspuFtOjdwped+wsUq2icyC2EUlLta3fLtO00PHBWc4qK1MC6ckkdch8vLwoP0DnAmKaoyqNQLZgknuOnCO+skQhpAtl/iFMhNuD/K6i5SV1RCW1c9dTEIJIMR8KNx42G90LEstC7q0RqKbRLco/5kPKxBOzMoogoJStzKdORyVHDMDEc69CMxK+QC5eRZuA4fFxX4cc3jGPVcoGN7mXqR9BxWxgRbOxW4QFQafHngK9KilkC4yojzpYGX8HYRkgGKrnbPfFQ6puJH+ChmQeacYTB9XOun3dTT/8mtJCQvQpueIaP95e3TqxC7v+PHbwRk7HEYUY734QHHC0htS26NpeWP/ASOxk4FWm58lhYVcrf+kHdEmhBbQiZRXSH0wWYW1zuH4m7YKc/sej+IehzEJG+SQzrvQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(396003)(346002)(376002)(136003)(230922051799003)(451199024)(1800799009)(186009)(7416002)(2906002)(5660300002)(52536014)(4326008)(38100700002)(82960400001)(38070700005)(55016003)(41300700001)(8936002)(26005)(8676002)(122000001)(66476007)(66556008)(110136005)(66446008)(66946007)(64756008)(76116006)(6506007)(9686003)(7696005)(86362001)(316002)(83380400001)(966005)(71200400001)(33656002)(478600001)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?h+uKAdkGHRu23E1hS3Jp6ABP4Rey4JYLmIhjLlpr+n2qoN9gJ7I2x/HtK/37?=
 =?us-ascii?Q?3dLgps/SaDoLz+YDAMECZOc5PX070xezQ3ugsAvqLo7NIi8dP37/yWGU8sS1?=
 =?us-ascii?Q?qIFkaJMnG/eazsPRFiQaxbHyA98vBFyOrn5JH6DF7NsfnozCV9Z+/8GQwLcn?=
 =?us-ascii?Q?Nrevlpb1EJkJKW+qEbk+v7QXinNQeItWqW2POEsWOBna2tzbu7bBSGb+7Q1D?=
 =?us-ascii?Q?GZ+EkKDirrfqJnAIXmGYMPm8TPaGoSC1y+8bqQtXPvn8yxU9+qgigv++WZn6?=
 =?us-ascii?Q?mIIRoPF4ggrJApYzEoMRguunn3HErM+7pDr0ZanavJp7Z2lFbcZzMica44Ra?=
 =?us-ascii?Q?by33VgBySuPP1NOH3eA1csVXEShv6uq6pARxVtDBjY4um1f5NErqL7BpGcr9?=
 =?us-ascii?Q?HScbakyPtx3wsQT5V3yenhf1MU8WG60C3bRkb04gS6YOs536qKDt6MHWpIJT?=
 =?us-ascii?Q?yODTkCN/3oHG4t695ZPxjqsr9uvfA3i4uNTaSy3zkpPpqO03Xy4Kl/TDKKHc?=
 =?us-ascii?Q?y36k1Q6/l4eQ72UVOXXmzVO+GqhMS4EdoHOqBtGq8/qCBKAqCeFwA8gErSwc?=
 =?us-ascii?Q?MWG+qgLsrVW3BE04LPkPOQKoR2nvUYJIdtkL/L9BfdA6YkMBJBvqB+tRQ237?=
 =?us-ascii?Q?JwdYaGtVZvNt+5/OuJqW+W0MbLq4DIVWGuTPKRE7DouFXRquo/e2jrpB+5BA?=
 =?us-ascii?Q?bOlCsTUt9xOQL5qYKvesaaHnmun+C+AOvVd14qWL0kL49ASmFQOc6KGa404r?=
 =?us-ascii?Q?slc7fKP0qq0Dz7K3IIzH+xhKSMIZ77c6gwRSGpjd7pUqqe0VlfMFkw2rtRv4?=
 =?us-ascii?Q?ynpKcTky6PivVFruOk/fnhkUiuAnuE2BHlnZIx9LpkmWphD88NTNisvDEHFk?=
 =?us-ascii?Q?WrwbusTcQyDaxcapETG2gXlv+nmiMTHxZ2niW4M0Vtf2fhs29eXAsNV2TDNR?=
 =?us-ascii?Q?+VFTURw+/R1hlx6Ii85exoRgM7e032ba9+P+O/aA0nFrQQCYILOVxv1EBqaq?=
 =?us-ascii?Q?t7YB5mP8uY6QSlfptHo0zfzla60tqqTIjGX1ymnezZj/l7ZXDIjJy3cUb/Gz?=
 =?us-ascii?Q?FGhymACV/c1En0QcwzWvZ9uouSkQtn7Q0lFcRQ3YVM+VCdy9VPfgHujqBhFM?=
 =?us-ascii?Q?ihyxT8AESqHIoOp/r0UHyhu4KxUnL7rP3X1BuFAIaNwmn3741LkG8VzaFTEb?=
 =?us-ascii?Q?PS403lGtS2V/SiS2KljVnJsNLLLg2gbnYBWN5l+oQoFkXP8D4bgYTm+QLVX8?=
 =?us-ascii?Q?pEtWwxjk9QjVKEKTH+M/CGDtzOcAx/o1aIh+XEyMT1z5gttQPDeJR/Bc7D2Z?=
 =?us-ascii?Q?7j6pm/arVDzl5fOMkC+2tP7Vzp0Nsb67y17rszurez0KD7bJIvzRNSi+F8IB?=
 =?us-ascii?Q?RyklHuHK7oZbPfL3t6z+ZNBL2mAfCxYWM2N/LW8jPkQoCZkjqDXQbIl7dPH1?=
 =?us-ascii?Q?Y/jBDdeGKI0HGG4MIzBaCLs3avx364XJ8ZGBWf5SJDf9gwWY852gVYb+9Idc?=
 =?us-ascii?Q?w2DWzUZd5sNdCFpKEWn74jikNvn11tLs7sdMalFjy7ASyCZYYLleKzoffudE?=
 =?us-ascii?Q?WjLcGYoEyAE4xEzB5Py22RmpLiheeUQ+gES12nPD?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4b703ab-6851-47a1-90e1-08dbbf27ffcb
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2023 07:04:31.8979
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lhYR5zAoUR51reJVhno9ba8P5EFbQhADal5I4K/gEPIet8n66bLi+jzVGcKre2iKUi4MQhJRHRmLHEcT+z9arA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7267
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> From: Liu, Yi L <yi.l.liu@intel.com>
> Sent: Thursday, September 21, 2023 3:55 PM
>=20
> From: Lu Baolu <baolu.lu@linux.intel.com>
>=20
> When remapping hardware is configured by system software in scalable
> mode
> as Nested (PGTT=3D011b) and with PWSNP field Set in the PASID-table-entry=
,
> it may Set Accessed bit and Dirty bit (and Extended Access bit if enabled=
)
> in first-stage page-table entries even when second-stage mappings indicat=
e
> that corresponding first-stage page-table is Read-Only.
>=20
> As the result, contents of pages designated by VMM as Read-Only can be
> modified by IOMMU via PML5E (PML4E for 4-level tables) access as part of
> address translation process due to DMAs issued by Guest.
>=20
> This disallows read-only mappings in the domain that is supposed to be us=
ed
> as nested parent. Reference from Sapphire Rapids Specification Update [1]=
,
> errata details, SPR17. Userspace should know this limitation by checking
> the IOMMU_HW_INFO_VTD_ERRATA_772415_SPR17 flag reported in the
> IOMMU_GET_HW_INFO
> ioctl.
>=20
> [1] https://www.intel.com/content/www/us/en/content-
> details/772415/content-details.html
>=20
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
