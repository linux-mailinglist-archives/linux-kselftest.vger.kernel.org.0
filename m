Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF1C2709249
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 May 2023 10:57:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230113AbjESI5G (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 19 May 2023 04:57:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbjESI5F (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 19 May 2023 04:57:05 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BE20A2;
        Fri, 19 May 2023 01:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684486624; x=1716022624;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=bRMIqB9G/d68YqwPWe2Kt7YWIHIdc8Udc/QfW3D5/sc=;
  b=OB7lLBXWE9FPNkIst6rg3djQObYDJAw+dWMJRy7m0sHIcupelgbqeAql
   iTz3fDo836uh20RkzX3CU9OPlLQk9JaTgAaFYv0v5iaz0X/c6I3kdQXvK
   RXartoa8roojyyPwY4InGqcjwbZsVrrCSHLk6h3DI7kH+MBB92pUpOa2K
   3AFmvo093oY6sILqssIhLNaq6l7439b5b7PgxsP/cNA6ppuI1kd3Q0cMv
   BbJBicJWN//HVuZj1TbhM+oYyTPj8HXl7dn7OuR7QqXskG9+CiSeXIlZw
   ApHPrnSmScVD9Dw/djrkBXIENgtg7reNrIk3jLhq/OCG8UXBhZ8GuR+QU
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10714"; a="341756575"
X-IronPort-AV: E=Sophos;i="6.00,176,1681196400"; 
   d="scan'208";a="341756575"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2023 01:57:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10714"; a="696630094"
X-IronPort-AV: E=Sophos;i="6.00,176,1681196400"; 
   d="scan'208";a="696630094"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga007.jf.intel.com with ESMTP; 19 May 2023 01:56:31 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 19 May 2023 01:56:31 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 19 May 2023 01:56:30 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Fri, 19 May 2023 01:56:30 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.174)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Fri, 19 May 2023 01:56:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YbyVw6LxIxCNgN9lbctCvkyUw4u+j4EaMejubHtFbGh/aPY783cOmdlyM/Fh/oYV2p0yEWnLncvaKKtP3bPT0JBqZaa9N3qZ5H9qPX5SxpouV6ltm31FAvhUHLplSU6v9WXefgujmWYTrvBARO0XM4Ru9P94dAGruIM9xikX4J47OHg+UeiFRX6+zohMkYl0iluUp3Dg9UaHgNCwrTuszGU3ba2tHbWXzG9WTjkiYNp0D2YrPZ/qNEAWv5RcKB8D+6B743Z2KQyqV/7XYLsa9Vbium77SY1Rb7JiSI5544pSmte4x2oJFxFtNb2D6LYPz3KeMh6dhYhm+qnkPe88wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SF6hNpKjRrINZ1pd6zGIeWjQ/k3YSw70Ze/Zralh15M=;
 b=N//vPgXDpGGyXg3mfjAqhamTSbkZl+d2xVdwQjfb60r7+5UQf+GamUrzH5Tmpkc6OUZ3b74FOxVFjYRsauQzXZiLj8w2ADJRq1gtPnmyXIjLqRQk71AkOI5hEpQ+kbnRmMtWPJT+SgMEAU/20hqIcmAOBlDJd/nKItNIT3Tnf05NCD7rudGX63+q6m0K2+nj4KGAXCLQ7hNVGa2JGWpLeK2pvGAqm7vWOWbCTfWT2iX0YQN9yqlXF/Z57XW1EE57CWOvJlc4ovIPhDaR56hUS1CDayQOnjh73bF4GlUj1wh1O5GU5vtz5YKzIWKINz8HoIu+g3eORctf/0JfSvMsRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by PH0PR11MB4920.namprd11.prod.outlook.com (2603:10b6:510:41::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.21; Fri, 19 May
 2023 08:56:26 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::73e9:b405:2cae:9174]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::73e9:b405:2cae:9174%6]) with mapi id 15.20.6411.021; Fri, 19 May 2023
 08:56:26 +0000
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
        "Liu, Yi L" <yi.l.liu@intel.com>,
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
Subject: RE: [PATCH v2 03/11] iommufd/hw_pagetable: Use domain_alloc_user op
 for domain allocation
Thread-Topic: [PATCH v2 03/11] iommufd/hw_pagetable: Use domain_alloc_user op
 for domain allocation
Thread-Index: AQHZhBZWuzKsMmALyU6hSy4chTQw+K9hVrvA
Date:   Fri, 19 May 2023 08:56:25 +0000
Message-ID: <BN9PR11MB5276FADBA5E22DCF3FFA2F838C7C9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230511143844.22693-1-yi.l.liu@intel.com>
 <20230511143844.22693-4-yi.l.liu@intel.com>
In-Reply-To: <20230511143844.22693-4-yi.l.liu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|PH0PR11MB4920:EE_
x-ms-office365-filtering-correlation-id: 0ecaff4c-4712-4620-e330-08db5846ed93
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 71dyXQTTMyVYa0+XiWR/kP7H/dQoJdsaAGMsEyHpNq7qucqHsQLikUMD/K4B6+AcsSWJonxcJ9zm4tTUSAGljLnhuAiTlbLGfQXtPnKYxKUzjZbSOhJbrdRbbH+s8BpxETLC2zvD0waypbRnoAg8JRdjW9yRhYx7e6aAoM9z9ipBnu4muqSUR2NuuW82cHFTMiji3Mf5Mf+xUW/2X/O5Z4TRmJENaSYhq/YDw4IOHsbtZitXX6akogz5eMygUFWzzXG7X9tlt2qBmCM1jNjkhfYu/1Pd0ELtgtqsMoY1ub7VnG19nH/XuJdODEnSNsOn0FqqGxSeEluOJhGOU2w1XrMciPOtSz6H0V4qempLsCuN59vvYKnlBvXpJ6PGT2/DrlXLuhzurNPC4Lv/Yz/0/lw3nSZzuOPEjioaoiBdPak+BXh+Pch0JAYYW5ovicQ+Y1G2aypUVZfgHYl1jCSv94AuyRCv0Vfvnc0lqCmvnRCtp/Im2gtOvesJyBCO0b65JkLQ3eYYRa9E8nRho2E6vw0F6PCli8TVtpxiFPyKH6TqYKGbWfeVAgNfrOFWXL4l19+Oi/Lq9vIz0WuvBt2UHAXtujcWLhGq52lW09VAs7V9W8B9ZZcQBdNNudrMY98F
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(136003)(39860400002)(366004)(346002)(376002)(451199021)(82960400001)(38100700002)(122000001)(55016003)(33656002)(38070700005)(86362001)(52536014)(7416002)(5660300002)(8936002)(8676002)(26005)(6506007)(9686003)(4744005)(2906002)(186003)(478600001)(110136005)(54906003)(316002)(76116006)(66556008)(71200400001)(66946007)(66476007)(66446008)(64756008)(4326008)(7696005)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?zOGvHWE5ueT+yY6XpVtnVZh5lmKclVCEwVXW/Tmjjtc2DQ8j4HXMtRgmHxqM?=
 =?us-ascii?Q?ylnY2ble2rORGSll50PVU79aXsJ3mEA4iS0C1t7smgkEuj4QC42z8TDUu5ff?=
 =?us-ascii?Q?p9JS+EDay4GTWlPNMQLN9oWoEp+MnVHG2jiJFPZjegdJY73p02rG95x0rWB5?=
 =?us-ascii?Q?vRNIJZue3tRxYNJQT+jaREy3s+QQaUCuHQIyiu+uLFgEAZba/akqk499W7Lb?=
 =?us-ascii?Q?ikAZ9xQQ7dJ58B8dioD+w41lhVVUbiSQfuW6c++LIJ0Fbf2V4WfRn/ojLsBd?=
 =?us-ascii?Q?MixJzlBkafaM/QO0YEJyNDipx8+//i0PFl37QMADkLtOzZy1lO3MgUJouL3g?=
 =?us-ascii?Q?7UM7vfOzKWv+YhQSTcjpx0Cj19+sIlyVL54XVEZWCNqNLFtCflZL6bWgYM3/?=
 =?us-ascii?Q?xD8AawLy4bFLBIT8Y7z90eMcb/6YkfOFH9Xk/eOMZRnGAtoRDh1koObtW5Ny?=
 =?us-ascii?Q?yY42DULaDcqskho5mZrfkM+hCNZWEoSQd6CISYPAHaUowOZxvgq4QALkzFSG?=
 =?us-ascii?Q?aKbhFTO7o3RflMMKyImw28pwzZWG5/MUBXjZrLC8NVOrF1I6e0240kqbgxyg?=
 =?us-ascii?Q?LNoxaKuBScUg6txGqyHvBpbCDaZuDMWXRbEj/9ZwQpbPittziiZwAsWaierb?=
 =?us-ascii?Q?I+xrPu7I8PyBNYOwwQSGeRHN0nwZ84CQ+QTpaAPEbBvVAoJXsw8hi7JkmmTF?=
 =?us-ascii?Q?8SLaSlXEaPwsXSeANBG0na9L4RwGQKUXmzOCNR1GvX+X6d9NJHFU+czx5ajn?=
 =?us-ascii?Q?IbTQS4By4mvS3/UyTybGpleTDIEBl0gksVnmeBvzZF8LxV58LK86IbJMgO+f?=
 =?us-ascii?Q?yD664nnwUbHhkSBzWGbGF0k0OPOBKMPwrTr1jOTohWD1Q2PHukdjQqbvv6aO?=
 =?us-ascii?Q?Sx5AVVpyAQ9/Yv3SSJNhZRNFCdtaRRT/pmX2CcC/9sc7zrR+vSPQ6Od1qUxe?=
 =?us-ascii?Q?LlyPuNkhMwv3LjBFJF7+4p51gPCN5vdFO1N8LFssYKZEBVp1YuXtDFL5gHd9?=
 =?us-ascii?Q?TUrVmsj1eH7qplVEoYA6Zx7BcdncYGtrdBeyA7GHS3jewcbllhFzP2ki+Foa?=
 =?us-ascii?Q?/EElFHZWTtYO5CmJSwDBbNNQdM4ElQqUisOW8Nxl8mwyz9ZPV27O5nSJI5+C?=
 =?us-ascii?Q?Bi1n6VvSI3Nx6RaGMyS1CfPPv181Owc8jX2twuHkR7COgxfKA4OTWI3H4Cf7?=
 =?us-ascii?Q?l560uV7J/2OaRZyjWC9hok99T16xkn72/LI/oPIPtOCN1z6mn87DaDCS712D?=
 =?us-ascii?Q?C3S493XMbREcXD1hRoFjRAGO5cWALFdrDDGJvF5n9rYo/mpPGbycYZGKFQrW?=
 =?us-ascii?Q?CjyKNRSoK+gZXh1C/7PWSnHJ0QZKgvvAzEQiFY8lE+P2XEcA+4bXqgRhDv1z?=
 =?us-ascii?Q?+ArqECvn/IP7FW4f1uUc3LTgevqF8kAKJI7r3Wrwq32ZzC/jM+o4Nw4NLOS9?=
 =?us-ascii?Q?BJgNfuMl24I3xNKVN8f0gpUBStFh7HYTKgroXlNZ9PXrCflA+F+1JFhbTeP1?=
 =?us-ascii?Q?ve82lviO+/BBB00LwW9N9UTWAe00u22tekRPB1BNOzQM9rrMdJ8ls/IMh+yx?=
 =?us-ascii?Q?cMZ7lSIKxEy9vKbQ/nOkrNRPvJ4NTh7E0x/TW8HW?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ecaff4c-4712-4620-e330-08db5846ed93
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2023 08:56:25.9888
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yAgzERJ5H4TREAFtuadoNDa+Lbc1GsifJgVB+Pi9uffs0l559i5ye9pFbij8JQl9e1p37atLvFKvBlozZL5lwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4920
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

> From: Yi Liu <yi.l.liu@intel.com>
> Sent: Thursday, May 11, 2023 10:39 PM
>=20
>=20
> @@ -88,7 +90,10 @@ iommufd_hw_pagetable_alloc(struct iommufd_ctx
> *ictx, struct iommufd_ioas *ioas,
>  	refcount_inc(&ioas->obj.users);
>  	hwpt->ioas =3D ioas;
>=20
> -	hwpt->domain =3D iommu_domain_alloc(idev->dev->bus);
> +	if (ops->domain_alloc_user)
> +		hwpt->domain =3D ops->domain_alloc_user(idev->dev, NULL,
> NULL);
> +	else
> +		hwpt->domain =3D iommu_domain_alloc(idev->dev->bus);

this reminds the comment for @domain_alloc_user() should clarify
that UNMANGED domain type is assumed when no user data is=20
provided, to be compatible with iommu_domain_alloc().
