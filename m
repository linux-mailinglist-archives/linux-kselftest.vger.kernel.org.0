Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18FF27BF5FB
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Oct 2023 10:34:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442898AbjJJIeK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 10 Oct 2023 04:34:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442915AbjJJIeA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 10 Oct 2023 04:34:00 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D74219F;
        Tue, 10 Oct 2023 01:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696926838; x=1728462838;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Kcxj7cZWSM2OS1A1OaCCLn7MF2on63bpWMxds8wKgwA=;
  b=AEWysyLojFhe7WrmNJ6Q2xZCTqW12OAon4ZbMOUWqFsgzV6VVYLoCQIu
   FyVKOlo6MS408uXzY9R8wuPZPifB/SqtoVVz2kfNfwZQuSXzPwc4lOkRy
   /l/PgS8gjpLEwsOiPpam8H/wEJHBs48FZkRfME7GcAbqUQP4gmyeLIP2B
   Vm4c6BvvMNJDcxI/zHI7izQMLFshtxjXxZiKsGBLfKSWwQDF1azCVshCC
   dNwf3SwgzylkIGw7e43lJvGkKwRgqXo+Yfa+olucoUPFeBkkuJx4Hlo1+
   IqIkkQut6Oi8ICsDqjatQKSh0Dtyl8kabltKYORBHPwPKlaWQvDcbJZSP
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="374685362"
X-IronPort-AV: E=Sophos;i="6.03,212,1694761200"; 
   d="scan'208";a="374685362"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2023 01:33:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="877144149"
X-IronPort-AV: E=Sophos;i="6.03,212,1694761200"; 
   d="scan'208";a="877144149"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Oct 2023 01:33:58 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 10 Oct 2023 01:33:57 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 10 Oct 2023 01:33:57 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 10 Oct 2023 01:33:57 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.41) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 10 Oct 2023 01:33:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nb+8Gs9oS6oysYnCrf6dxKSuKsVps7Y02J6W0ZxaXk5lRVDcMSOBc0rMSNuXbKyHSQzrjM8AMKch8sqpR2iNuIHXA7TizAs2zDLsoK655W3fJ4ypfP6yPSUaYh2Gm0t0GhDVzdocYgOiMvbsgSjA+CaJRH+f2JqOl+fzIdR1LmfR+7ZoaNRVzRy8T2CiSN8MEFuPg6UKwL+c0BWWU1puS2RAHZwMu5LM3SczvkvRIN2bGYOkdHgvKvU7l3CxpSrhIsEs5Q51XGq3BXMhpI7o0pXxDsLEeQsaQJBbH+gF2+z+uXJRI2GD6f7hFaiaUwLOn1vt4P3n2SpWqJ2nkMbv/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kcxj7cZWSM2OS1A1OaCCLn7MF2on63bpWMxds8wKgwA=;
 b=GElT7AN2l7olgE0AdSrjmJIPklagbN43Zs/AQ8I9aD9TaHwZRGBcruMYsb/Fz5KDt1vz3oGlQuVFTVzy3WjkWEWdx+Ch53e6CJokSdCY47bD102dGTd6M/6lLMyPKv6ok4AqKYZniDtrnxnY4dTLkFbuZGqYLWblTD8ZeXjLVC+2359JUHCIulij/xQF25RnVr+JRn7zBUnEZcXW695XhDT3B1PqKHTbdm5ni73em6BaTLuPav6JAxOpymW78Zf+xggsqTJAZigpLCz46wkar7nu6W0692CfNp+7AjaJongQqwjIjG3+/Z18L0aPtMwsWVI8plVcUIaW+ATbbm2j7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by CH0PR11MB5705.namprd11.prod.outlook.com (2603:10b6:610:ec::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Tue, 10 Oct
 2023 08:33:55 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::7116:9866:8367:95b4]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::7116:9866:8367:95b4%3]) with mapi id 15.20.6863.032; Tue, 10 Oct 2023
 08:33:55 +0000
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
Subject: RE: [RFC 7/7] vfio: Add vfio_register_pasid_iommu_dev()
Thread-Topic: [RFC 7/7] vfio: Add vfio_register_pasid_iommu_dev()
Thread-Index: AQHZ+o3ZhQduZ+T030mKo+5fLXvrlbBCs3Uw
Date:   Tue, 10 Oct 2023 08:33:55 +0000
Message-ID: <BN9PR11MB52767FED0A5AE43AE86C4F568CCDA@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20231009085123.463179-1-yi.l.liu@intel.com>
 <20231009085123.463179-8-yi.l.liu@intel.com>
In-Reply-To: <20231009085123.463179-8-yi.l.liu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|CH0PR11MB5705:EE_
x-ms-office365-filtering-correlation-id: 8a9eddb8-b707-429b-bdb0-08dbc96ba3f7
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nRGhu/yu1s2OnIP0kSEPzJHDaNF8KLqNTXFrLcfx3Lk9fzwGbIrnfna/HvnGg5LcCJzN9DIkWfXVPXtuZyUspPsSmyV1wbDKJ9LOb0IarBTIJTJZffFZyOTTbGyUavBTsOIHCSOHttYGcQfQNXsrubD6HMwijwZLbAQpDGy0TWuXhPjUIEs6FuS5amtdvPvyZQoEHPEUyhOpywXnsfP8IfnA5twqXRbI2BugB5Wg8KklznokCKwKcs8peoIB5vNU2vkLMkCjmU4rnbFlKEqpAE/6LPh5ai5vhB8pPcr7oNfkP7zr82l4rRjmQVdnAu+Nt7qoegvYfEs81YOdFUx/Oz24ldyj/SkpGkDakYtoQCa8Z0mnelqiwmbLX9YvGrF5DDnUnBekovFmQ9E86+DiXu6rrsZdbuKCevQ6aqcA2D2U9F5S52d521I/++lJWsv4kzAxg8JwD1GE3zd/ZQoKHM2Q/O4H7met0+Ky6mKseALzRvrnMqucNEAfprgGH27IS8U6XPpUsCs1XAeIHoYlA2xJSloLkMA8NuVstoNV4PMImK7UxKuB1Pc2gGNBpl/7BJX5hKTxsEvjAhomoRs8+cDPDUjfniOGSd8bVDSeeeE9EKulIN56bkCvn/vXI7HP
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(396003)(136003)(366004)(39860400002)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(9686003)(33656002)(86362001)(55016003)(38100700002)(38070700005)(82960400001)(122000001)(26005)(7416002)(2906002)(71200400001)(7696005)(6506007)(478600001)(4326008)(8936002)(8676002)(52536014)(41300700001)(5660300002)(76116006)(110136005)(66446008)(66476007)(66946007)(66556008)(64756008)(54906003)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2Pw99fnd15+nWTvsp5r4mWE7tpaZn4JiW6iuhFOiKhzqzydLdHbT3MbPH6WM?=
 =?us-ascii?Q?uIbdmoHI2Baf8Flh547MgG/SSuUXNCFp9AB8iDCJkUV7/RuAv5Lcq3AfelzD?=
 =?us-ascii?Q?fv+pqv24Yklw33J6k4IverCyWn2Sd+oEeNGz1yrwSyEHf6Sd3OVkjXDtUxEb?=
 =?us-ascii?Q?VBevJeHEjiuu3RgGM/3HRKD0/oAvws9vNewGLKFRQKphEeA/1vpfRXhr1lVT?=
 =?us-ascii?Q?u6tjcrIHT7zUkn4IMQZmL4UixKJG8FyLNZ7lPYiXOuThXclUV7dPnxCqpMlH?=
 =?us-ascii?Q?tcynqh9J1sKmdsXtlvJJaUmtSwHxJ47iHQR9BCkVL0aLCTWH3VzvaiGXh9mA?=
 =?us-ascii?Q?4h+ILRYl99qoVUak/SWx4P//ee9IiJPlEQIjc5jfN6iHgRC6q/0SnKzxFh+y?=
 =?us-ascii?Q?FM0KTDfZVnDFrVI9wx9lwbYmRcWMXorjsvruU+Iw8SJIp2h62tnMn86viSkM?=
 =?us-ascii?Q?35e6zVWT13E0U0LZD9HbHSdPPhmRdb9S00UD7dvlWyAewv2J/zbK9HCdbOfm?=
 =?us-ascii?Q?Al6Yr1GFeotoWaEQGoF1h+oxz/oGYgZFNOcfj0UJD6YKPfMUYJekq5jw63Ri?=
 =?us-ascii?Q?mF2K1XC6ix5191mAgVQ9PXhRigihSXEQqEwG4xy8Eykl6SdA/izPItp6mF1g?=
 =?us-ascii?Q?D+vo2W/XH0+vNDESZLM0gIJ6X36+pGmjn7uZowkgQD6I3SmIucMfcxTu2XrN?=
 =?us-ascii?Q?Me2xbyZ6p/xBwYC/NrWDv3Lt1Gcr4OrT5xyv85AVNZTJzdgKtLHZK/4PxBtH?=
 =?us-ascii?Q?RVz/MzTYJH/L1FD3T2SbV7lqPbvA+8tN8jmgZP/eD8VMEvD+wlu4gDCu5OcK?=
 =?us-ascii?Q?1Tps1emqVlgXb9EQjIU8BsoEE8ClR1Jy+J/aKMPv/D6c+ElCcLX5Ia6QDtBU?=
 =?us-ascii?Q?vzcmEkBfmxS6IaoqaNJzG2qXBnwg0Hr1/U8v3fT0Jt9I943dY64k4yju2PuE?=
 =?us-ascii?Q?i686mlUKSHEJVk/9L4Ja8asfXRmQcIRjLU48BoPiRYvwMy0JcEORaXTfu+8H?=
 =?us-ascii?Q?1GQJJEdUA0nFOvYroUvDm7FKIheBTgPMl3+XYqlbkfOrF0hGFwFxqLC3covS?=
 =?us-ascii?Q?3g+aPEznsIfcfO33t/0uu3R/ckE3mZc3tL5uCUnVIZorxrOBRBN+SPPZPq2X?=
 =?us-ascii?Q?LNIWH5csGFK4UuC6iGZivQPxStHwspaO2XsiYMK3RLPRfpC8ZC9J4zOgTbNX?=
 =?us-ascii?Q?d4vD1I5jcFnG3kUgGU5MA7QuZmSc7XUDToE62ngt/bzpv0cbPSXRlSZxudwN?=
 =?us-ascii?Q?f/DCr9rMRwc6rhuF+vrDqvLT34I4yFxcMceYNC7HLS98geMeV5cUQ2mnU2Ah?=
 =?us-ascii?Q?ZghE4XNAsdqHPDY/DfB62M4w4p54s2qUD+u+Hk15zZZujecXN7Yq1Bnw8H+O?=
 =?us-ascii?Q?2+BMA8k7T8+YtpewUTFtZXPvFuyhmACcSJtKbBLj6TP+cawE60kF8c59EMOn?=
 =?us-ascii?Q?zJTAyJ0eFVxIUUf5317jJzEEEMIVhGp6Nih3UKKoEReQaQPPJZVh186hbTE0?=
 =?us-ascii?Q?mfBYDxD9zbhKHN2FBwEb5XVFg+binLiB0A6vAOSbGfltvD47KR8DOlz6HQwQ?=
 =?us-ascii?Q?zepbLOXI3+L9lyfHFZQcCWscE8XwqgbwcIknHHr/?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a9eddb8-b707-429b-bdb0-08dbc96ba3f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2023 08:33:55.2349
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BJF/GkR6iutm7nw4x/+Roo8qzf4iblQ4n2nAR6t06gYf8TcPrpTpoVBGzNEuFt5ggH2MfijoAy8VO9d+dYVvqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5705
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> From: Liu, Yi L <yi.l.liu@intel.com>
> Sent: Monday, October 9, 2023 4:51 PM
>=20
> From: Kevin Tian <kevin.tian@intel.com>
>=20
> This adds vfio_register_pasid_iommu_dev() for device driver to register
> virtual devices which are isolated per PASID in physical IOMMU. The major
> usage is for the SIOV devices which allows device driver to tag the DMAs
> out of virtual devices within it with different PASIDs.
>=20
> For a given vfio device, VFIO core creates both group user interface and
> device user interface (device cdev) if configured. However, for the virtu=
al
> devices backed by PASID of the device, VFIO core shall only create device
> user interface as there is no plan to support such devices in the legacy
> vfio_iommu drivers which is a must if creating group user interface for
> such virtual devices. This introduces a VFIO_PASID_IOMMU group type for
> the device driver to register PASID virtual devices, and provides a wrapp=
er
> API for it. In particular no iommu group (neither fake group or real grou=
p)
> exists per PASID, hence no group interface for this type.
>=20

this commit msg needs some revision. The key is that there is no group
per pasid *in concept* so it doesn't make sense to fake a group...
