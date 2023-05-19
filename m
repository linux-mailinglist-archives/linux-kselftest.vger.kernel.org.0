Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AA0C70943A
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 May 2023 11:56:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231749AbjESJ4k (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 19 May 2023 05:56:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231806AbjESJ4X (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 19 May 2023 05:56:23 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6984E19A1;
        Fri, 19 May 2023 02:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684490173; x=1716026173;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=bA6xTPjJWUKZWPg2wPr+vSNupomsV5n/m4iZWxQPank=;
  b=W6QGo9jEJ38mVjW5fpFZA6RqXM9n8KaQJxLBek8JiOl87vnDYUaxxDSU
   pjuZCq+tDhNxsYrHzWS7w9XsgVl4h6usy11U3l9qAUzHwL/lMYZyPOnrO
   4HCmR21h1ejWnvLd5mWUlIXjxUCE6GKy/3A3M4k6jkC+jLODcNioA4IbB
   PO/C0oYb/E2fQg2msQz8SgFJA+PKZqmFOLyukXO1P9di+4k6gEwwYtJ/p
   NiZ6eVRkfso9suNrz8u9v0aKuxnSXqRUjYnMa+zNMzq/5HVyf+w8Nzhgr
   TcqNASOScwiEhUOQmbgnhGbWNTiGChO/8Iu2hwU73WgRF52jHFkyeQtPe
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10714"; a="336925858"
X-IronPort-AV: E=Sophos;i="6.00,176,1681196400"; 
   d="scan'208";a="336925858"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2023 02:56:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10714"; a="733243985"
X-IronPort-AV: E=Sophos;i="6.00,176,1681196400"; 
   d="scan'208";a="733243985"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga008.jf.intel.com with ESMTP; 19 May 2023 02:56:12 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 19 May 2023 02:56:12 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 19 May 2023 02:56:11 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Fri, 19 May 2023 02:56:11 -0700
Received: from outbound.mail.protection.outlook.com (104.47.56.174) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Fri, 19 May 2023 02:56:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RA7nEAKrC5l9hEs4Sqa19yzWmEPiHIvb236sIJFburjJYL7wYfOpBnT5WPGHa4CIRuPQ4PIFAuwMO1Rl5Gpy/GOQU4whCTa8t7+AeHTgLs54PRaIcy3jqIrkTzBqO3Pfns2tCPVsr4FqWOPiYw9ccer2GJuLJZJc+3VCDTzod9K9pPQiZ5H0NBxfLh9U8Q4rSqLYmrDqYBHO3gmkNaCr88OFJv1c0gkQDvKmxyizwS9qioINgdQXQvjiiqP1jbpzWg2QvNKO51zr+FQb0N1MABAlVlV3bf6aNX9L9B2hrejEmFuLnpA5iQWwKVyO3/qVJoNojNXvFlB843LldCQgmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fwJ11oKIYRRhCEnD6KXjsRBlWj0V4fVFELfAPpXTupU=;
 b=UiUVpRqCJdc1jtYG3ICtAivS/3QKNIPWbyN2mvz1HF8iay91WJPOrs+HANpoQs0yAj9WbmQQmK+5g5rbws7g/06Lmg62uV7k3ZavK/o0xNje35WDIrq9AgZuZX9ahswtaWVDZCwmBllhbBmn6Haz3thEmd7/yQAnPklobBKGgT8nNoUUWC5yRkfxiGVmJ/eVUw1T80G9G6qthwu/lT22gyx4L2UtyNHfVuKlQFh1e3PJ+m0R4sFBccUYg9hZ9OC30xPN4JV9ZywP4lAfkV/T3dwq/RhCsIyloOrbJhMAwl91sNAe+L1is5xkh+DEc1vCZ3sGvooKfJ0WI2DmL3thSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SJ0PR11MB5677.namprd11.prod.outlook.com (2603:10b6:a03:37e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.21; Fri, 19 May
 2023 09:56:04 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::73e9:b405:2cae:9174]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::73e9:b405:2cae:9174%6]) with mapi id 15.20.6411.021; Fri, 19 May 2023
 09:56:04 +0000
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
        "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
Subject: RE: [PATCH v2 00/11] iommufd: Add nesting infrastructure
Thread-Topic: [PATCH v2 00/11] iommufd: Add nesting infrastructure
Thread-Index: AQHZhBZTNX7dDuLMFEel2CdlG13MGq9hZYMw
Date:   Fri, 19 May 2023 09:56:04 +0000
Message-ID: <BN9PR11MB5276DAF0A11809CF8433EE338C7C9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230511143844.22693-1-yi.l.liu@intel.com>
In-Reply-To: <20230511143844.22693-1-yi.l.liu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SJ0PR11MB5677:EE_
x-ms-office365-filtering-correlation-id: d89eef5b-c5b2-4c78-f299-08db584f42b0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: e5IPL9Xasa904AhmajE7Qx9TPk2bTr9pbBhPe90pqTHDg+KtN/6OvWbokJBKTNFmiVsQLHsx9wPyud0YavRP7BPoxxHUlR9K+9nJ5IWPXZWRG7Q57iV+6Z4M/jbhiGzHZoIKu3sEZokJBeZgRvmzD28gHQbTS6c+IhvnsG9RhmtGE3NXFw8EOB8qdgT4ZFqwO5Utwc4Uf6MNHXoVw3REubLCUGOsyRwLlwIKaHOUWVvL3RdbrcilrQAcb31wJK1fS7f37Q0vxU1wlT89AU7Hj/NLGLGFp52I9U48FZsTd0urs2KgAAJ6K0AEuqobQNRVZjyE58c4kFZHBtpUlupjNAIG/1q+gov+GN2DF6686yyEWXxgHsQxdNDPmMxvu2v4sI5B1q+bBXQWbY1OnAcEzXv44EXr85qe5s0UkXPdXH0HZZBqTQgUsz2y3Tk4LD52IRT0W/kZzGwTILThHsuqic6lKHZN6SXyT3CzjlmBGfmcn3bFvM3xv2TZopTDdQoHQkpjlZQbukvwcv+0+LOo5UMi2TV4DC1HmFLt+eSIb8TJG61yd51ocsCS2kxCbqnBOdcK4Vks9QOaJ3vleqffvn1kZ5ponhm9kCswN2txSTfttsuuSdqcHPzwBnC4do/+
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(366004)(376002)(396003)(136003)(39860400002)(451199021)(71200400001)(7696005)(41300700001)(38100700002)(26005)(9686003)(6506007)(5660300002)(7416002)(52536014)(83380400001)(38070700005)(186003)(2906002)(86362001)(33656002)(122000001)(8936002)(8676002)(55016003)(82960400001)(478600001)(76116006)(64756008)(66556008)(66946007)(66446008)(66476007)(4326008)(54906003)(110136005)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?dDYdR7irgtvnkZAGoikuzXgPeXf3KaVzxujNGQHi58nO33uaWUVCCLCx2g84?=
 =?us-ascii?Q?yMLJgc97SFJ2iE9OgtRbEZihe58Yr8rKS9xVIKpRXx7+mcnT3/kIuYy8/t8z?=
 =?us-ascii?Q?tDrdu9GXnoG2nC6I9eEyi/xI8QZBAKOwbYI5Sug9aWkIxEaCq4Gm28dNbJ0K?=
 =?us-ascii?Q?m3VLgeXPOLuuEGc2E1LsDDL4zW5tAv1ylhVAMhFhuZVHr9WEBIuHNnBCdqrO?=
 =?us-ascii?Q?waMH9lfyUpb0b29XVWpk9ufVz3josymDi/wFOJB7W6GthEd5Loh/r9NNN/t2?=
 =?us-ascii?Q?CFGi7+stzudaIlxtN+eF3Ec1JuCAyx/ZXcLACThBQKrulNvX8hGa6zCOBnXs?=
 =?us-ascii?Q?VKYHFO0vmYSy8sRiaM0RY+sQ9Q3XeOnKEi02ZO8JFbapLyIww+se7LYTAUfM?=
 =?us-ascii?Q?XYtInF4CZR4K2nB+lANPBjW9hS+nNCQGPA6pup6g/GyiQvlhsnQuCkl2TpZ/?=
 =?us-ascii?Q?FRXIBAyMSjbv7rrcO9MwwjPXhq5uaW5fPygOvGpiqsKvEqS3GL8F0ac08e+x?=
 =?us-ascii?Q?7tPO5sdwtstEU+MlYds0WgVoapdhQhufYr9CaTH38BmKiWrobE6GpgPzUWum?=
 =?us-ascii?Q?ZVhl0HxzO3K7VM0CxED+2XIRwK3+g4IKRonlCsyjTNI3kcPwMZJAMY32mrNP?=
 =?us-ascii?Q?s6TkG+whL1XR8JE7dzouH1C4og6/6+jLjmjEYdgOf2nHbwvZan6C3OtCiJHb?=
 =?us-ascii?Q?71r1oFEE4KqNjr4ku1Y3pUGrNRvrrgepN8b+HZ9VLSn5zLuR9cbbyagoRQUX?=
 =?us-ascii?Q?7Kxsph119wqsY9+iakPZ7AB/zgM45Ta/vXP1uamvS4TNXaBIpoWVCK15K630?=
 =?us-ascii?Q?GCBVNXxzj5rY/DuBsYkYVqIgASMQqHQsY3rEt/OU8e/AHLaK4UzrykWijvov?=
 =?us-ascii?Q?fJbkO4V4J0Qj9mcgtunK31J2FFXeY99qAG0j1wRuM2Z34wh9WufJA16X0Uu9?=
 =?us-ascii?Q?E/kcLyZkxJa3JUS5NJPSZYesDl24vkS2fW78iXngo/AQx/adlxBGN57NhFqR?=
 =?us-ascii?Q?e+9Ylh8eTWlKCPt/pDvsH72A5LzCuKzpAAzeYTgz7yXjw0502R5hSwANLCNU?=
 =?us-ascii?Q?o9Z6WHiXryEw9/hADl/6mnE1zVHJj1iFVpWXjXJ4EJG6/ob8NBPrCR6pVV9a?=
 =?us-ascii?Q?rlaXxRJj2b6OECuFcOSn1RJdT0g7q5II2MVd1xPKN3uQg5R2vOdu2dV+2xlM?=
 =?us-ascii?Q?MLF1fKhTMdCZyMK1FAAgDRTCmq0e/oYfHBAevfbChpSg1kC9nkPNpeMiUi3L?=
 =?us-ascii?Q?u6OZZxm4iX3kEJ0F7r+EK+S8FD7OjXel94MyQ/Y9HBx5zkOX9zbszwhrfJYK?=
 =?us-ascii?Q?nfZa2GNXhrHGJOTKaPrb1J1akP0A0dZI+kWAUFhp8AvG/q+bmuawYqTE18+E?=
 =?us-ascii?Q?t6/29+oeoi55PjO28IR48yoOBZywvDQWRpSmNPtrgNKlf66VTPw78ZS2ckJ2?=
 =?us-ascii?Q?V+79ekIdeJ9mq8UHQc8WwkndH0VFG3IVMOQx0+w4bqkdWUldIb0DJpPqz5ip?=
 =?us-ascii?Q?xw2RuR/vO8lb1lnDKNCx1MrvrL8ohECpcueC6XHXqikUgYFoEgvdbcEZzuOK?=
 =?us-ascii?Q?m8bpm5I2A2HHYJJqzWt49nnPuiNHgUrS4YcinLoQ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d89eef5b-c5b2-4c78-f299-08db584f42b0
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2023 09:56:04.7151
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BprduyGMSoon85P9X4pmU2SQmdMM/J3INcSN84c73N0wcDVKWvM3J34G9/Vl76aCFnZs+d1vJytAQCw7etPhDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5677
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> From: Liu, Yi L <yi.l.liu@intel.com>
> Sent: Thursday, May 11, 2023 10:39 PM
>=20
> Lu Baolu (2):
>   iommu: Add new iommu op to create domains owned by userspace
>   iommu: Add nested domain support
>=20
> Nicolin Chen (5):
>   iommufd/hw_pagetable: Do not populate user-managed hw_pagetables
>   iommufd/selftest: Add domain_alloc_user() support in iommu mock
>   iommufd/selftest: Add coverage for IOMMU_HWPT_ALLOC with user data
>   iommufd/selftest: Add IOMMU_TEST_OP_MD_CHECK_IOTLB test op
>   iommufd/selftest: Add coverage for IOMMU_HWPT_INVALIDATE ioctl
>=20
> Yi Liu (4):
>   iommufd/hw_pagetable: Use domain_alloc_user op for domain allocation
>   iommufd: Pass parent hwpt and user_data to
>     iommufd_hw_pagetable_alloc()
>   iommufd: IOMMU_HWPT_ALLOC allocation with user data
>   iommufd: Add IOMMU_HWPT_INVALIDATE
>=20

I didn't see any change in iommufd_hw_pagetable_attach() to handle
stage-1 hwpt differently.

In concept whatever reserved regions existing on a device should be
directly reflected on the hwpt which the device is attached to.

So with nesting presumably the reserved regions of the device have
been reported to the userspace and it's user's responsibility to avoid
allocating IOVA from those reserved regions in stage-1 hwpt.

It's not necessarily to add reserved regions to the IOAS of the parent
hwpt since the device doesn't access that address space after it's
attached to stage-1. The parent is used only for address translation
in the iommu side.

This series kind of ignores this fact which is probably the reason why
you store an ioas pointer even in the stage-1 hwpt.=20

Thanks
Kevin
