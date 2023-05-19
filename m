Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FE857093F1
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 May 2023 11:46:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231620AbjESJqX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 19 May 2023 05:46:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231589AbjESJp7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 19 May 2023 05:45:59 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E65641FC8;
        Fri, 19 May 2023 02:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684489497; x=1716025497;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=RneTVowWppDhFoWAUwiuJ3Ps+OyyQipF8vin5CF3eCU=;
  b=gVt5/Y1IHD+FLXQpG+KKmoH4C+Y0Uv2SRSIauKm8HitCt1Kv7UeiBe7O
   ePgYLp/bT3B8YpFv27MQGYJqXF/d+ZuLVjg9BZ7WS1RFcPHt5ElGYH9K7
   zC5p+HE07/OfmYFcUlj2XAS8DVt3OaVXQUd9ArfdoYS4XWM4hWQCGqkKm
   d6akfi8xJc1/F9P/g6/d2fth8VX+hDZxouDsn9EpqHLH+Ah7HNt1EijEB
   bQAkmvVcYNWB/QrpOMq5psdHUf5SStX0iuA1PVmeoBx1R/drd79PcV7VZ
   jWIKKM1w4Jgz1Hyu5f8GPuOOAc86vcVlqGwkKBvRc8YieIVSGKXvcnDzp
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10714"; a="336923149"
X-IronPort-AV: E=Sophos;i="6.00,176,1681196400"; 
   d="scan'208";a="336923149"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2023 02:41:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10714"; a="792317140"
X-IronPort-AV: E=Sophos;i="6.00,176,1681196400"; 
   d="scan'208";a="792317140"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by FMSMGA003.fm.intel.com with ESMTP; 19 May 2023 02:41:13 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 19 May 2023 02:41:12 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 19 May 2023 02:41:12 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Fri, 19 May 2023 02:41:12 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.49) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Fri, 19 May 2023 02:41:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LE9iYIj9GNWF6EnpJeH5DpRAHwvmxfjLMf1u8VBQXiv2eo/Qg693sPR7VbQp08VFnDI9U4cotqy3Gma+u8CopSRMW7XryO3Fu4lprzIy71OtnKbUxd+j4Fy8wuUEbEvo9LDgDCfjo1xKhc05i/qr6pAopX2qkwi5jg3+OvzX7uEWQA9EDiF/xQ6dmphCoxoQDpY9pElMI2Lo96om5ZnZLxOTCz+eDZJgPQPHLi5ffqlpsgvlXYCFxph25ZYXLcK3eWhEQFFARjt8EfCF2dfNT29J7aXFFdOc+d8btArRR6gZnkQ4UjSIN6loTHZ+ZfyuJxhHTUoE2JUgyvGvVf6Aeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UBEkiO+JmbdLlmBSiyRSYRE3/Px3PUndNVtZ6RFLvs4=;
 b=D0GBB6ttWUlUsMBKdrVAnXaWb7Vg0E5PFeYThWwbbaGSdv1ePgt0iw1AiVAIz63xCKTWaRd5Cx+AyeQ3D1KZyCXrKkwM5GbZpCpmQCWFk+bNsKLD979HNQo1PC1WypO+W31yHAY/CexQNd6E8ZHpLLlMMIyB/CoXfGBTu6uHDB6NxBXpDY7h5aRKO7BMr5qiPzgmuguFoX9Pr9do31GOuPQtefhMMvFbZIW3R+exbV+Hv+1KNPe42oeeuNl1x3KcI/sLPtM3exFd6bt2Gk7pxNFXGyTFo2C1zlspgUAXODctjE7u1KqbQc3KPcdC6kOBac37JErJMplKgNnHoOnASQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by MN2PR11MB4549.namprd11.prod.outlook.com (2603:10b6:208:26d::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.21; Fri, 19 May
 2023 09:41:01 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::73e9:b405:2cae:9174]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::73e9:b405:2cae:9174%6]) with mapi id 15.20.6411.021; Fri, 19 May 2023
 09:41:01 +0000
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
Subject: RE: [PATCH v2 06/11] iommufd: IOMMU_HWPT_ALLOC allocation with user
 data
Thread-Topic: [PATCH v2 06/11] iommufd: IOMMU_HWPT_ALLOC allocation with user
 data
Thread-Index: AQHZhBZXnOm7clyQUE+6OxnZdoaXBa9hYn+Q
Date:   Fri, 19 May 2023 09:41:00 +0000
Message-ID: <BN9PR11MB52767257B1AC401121F3B24F8C7C9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230511143844.22693-1-yi.l.liu@intel.com>
 <20230511143844.22693-7-yi.l.liu@intel.com>
In-Reply-To: <20230511143844.22693-7-yi.l.liu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|MN2PR11MB4549:EE_
x-ms-office365-filtering-correlation-id: 08b08c3a-c7d3-4c12-5030-08db584d280b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oErwepYK4d0IhKwt7+BhIhPT3o794y3jGNl3ifrrhbZAAdIpYIX9ZqmmNZuLFUS1sFBKtV6Tx3RAhAYwqRTqXjbhxaKMaFYtZ6vifDltVTfmtR/Sf0KV2Cv1G4okDHnLatEv19Io+u9LSXYxRPO5KoWpbGiaYuDX6rulqggfJJT3xX3iQlaQxbQyZobNBXEiDbWJ7id0rkNORDAQe4cklONWzs8VIQQ6YO3gMzZfKztwtJgGuX3Lxr5tOELFzAl0jJ6IebLVFXVSYbvrO1UTBWKIN/23Vm4Trp02q6QTUi+3+fQekK86Ujz7W9T79gBW3wENIQU4hCgHOpajbA6O1iLFNuW3rdWbQNH0p7jwjNtwopO1zEh5F9GdcvsaGamxzS4MVEkLwmaGodRbiD1SfuMhN0kxI90JX4UDhQ50c6yB9wvoB9GVYAgT6qGADHzprWszz1MJqVTgvmJKlImZxi0QgHmLT/opyc+MA54nlYUA8LkDHO6T9ToFYSqPR5CaITWQXemyEyb0nuO0ICSs9FVn5EvxYDt0WOCxBpxQ5RZbo+DyY+p0a+fsggVIa3fs36lII9zCd2OoNfk0wOPtXql8preYjOu3VqWyelArJtOhymzSb5bz2HEDkK9Uuw67
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(346002)(136003)(396003)(376002)(366004)(451199021)(4326008)(66946007)(66556008)(66476007)(66446008)(64756008)(76116006)(478600001)(54906003)(316002)(110136005)(33656002)(86362001)(38070700005)(9686003)(26005)(186003)(6506007)(52536014)(41300700001)(5660300002)(8936002)(8676002)(7416002)(7696005)(2906002)(55016003)(71200400001)(122000001)(82960400001)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2lm8LQZweg/X7rA5E/H78Ds2xhKGDZTmnAnqkn4HP05A8AXYlk4ZckACa1dZ?=
 =?us-ascii?Q?14D06uVRA3L35D8EYitKBOXj8UvxL63tqcLcomctQhak4STlifQaKUFhuHnk?=
 =?us-ascii?Q?KPb0ZSvxa/N5E2xLfarP54i8QCobgWxxYV8ab0JMi+RBWgolOpyKAa/8JDNI?=
 =?us-ascii?Q?5kfJVmGG+QrNd5J3/QFSd5ZfNzhco/TqfVipj/hi8M0MBs+kfL/eGDb6Kc3x?=
 =?us-ascii?Q?VaRUGXN+zFYRVHqsKgDEiVJK+i+b6+gKloeywi3I5jREyP/UhSB4v5EoCSoc?=
 =?us-ascii?Q?PyKGJfqWrIXJaykAEYtFO9jugglWn57JmSp2f2OTCe393iz+GB+epEKo1Osp?=
 =?us-ascii?Q?vEzDqnqqlbJpbXQu4UWgfWGkX+/iTnGq+dvoGoVziOJZigqWF/F79h5xWvcR?=
 =?us-ascii?Q?9C/gI1yrSbxbBKS6ukY5wDJxMGLIvWFs/86EE4ohCrH0oJhNt+nKRQQ5X3LN?=
 =?us-ascii?Q?dCPaj0WyJ683BrZH+dXyUL5maFf1peJ6QpJdMvC3EeuD/fcq/6razLuOX3E3?=
 =?us-ascii?Q?q2FLxNkbwTZ+DwvRsz0AZrgrYdfOT2TsvuJdoRaud/kh62FiL6stRozWN0Sq?=
 =?us-ascii?Q?Ja8iPnhTe3qESEmL2clUPnmLMtcMNolXndiFF6WiTVIua/WNbDoNg01IqUkm?=
 =?us-ascii?Q?y13fTfvgrzTGaGOmPgmx6oIZJTSLu4nOga+79+j6l6goC9dNgSoWCO+Sd0Z1?=
 =?us-ascii?Q?tdrQjYfHDcvZBwyQlRMk4W7iGIyUM8NzDbdw+cgysjSCSaLskWj3v7TCkrih?=
 =?us-ascii?Q?8HOgz28IwkIAbkRMeK1cmqWzQ96hdFIahfXZ0nvh8EQoM6P6kw5pT6ePO088?=
 =?us-ascii?Q?QpmPerC9yP1/V6r7ARDtUy1YOmX3W6s+6ev0eSg7y5t5g39Bk6+JYmFjOefx?=
 =?us-ascii?Q?Oxp9vt0/ihHIz9bn9+CPAzYOe4QxLLkq5yxDPw4aFFVT0kU9MEWINatHM9Xf?=
 =?us-ascii?Q?ody7fQn3ttAbBWIPmE/UTBa8oeo+pbetnDzzFlrelhi8lHz4p08yy/wmXLrs?=
 =?us-ascii?Q?N0paqnZNMONVSsnYXKST3xFhPsnMcFC+LuX2fjT6oKNJcj3sNiLcCDhXjqLO?=
 =?us-ascii?Q?Ejuoy8UONH58JGTiBgxRa8EzAcwbp9VNoImwdko+JYhVXHoYTqcmT9/f1bt0?=
 =?us-ascii?Q?RYgsyBSqmCGOuMAbvMZjZvvFBbHSwj/PBLiOkctBMCqaIZ56FxdMrjGH3cb6?=
 =?us-ascii?Q?zcY+mMG4YnZKZgR2KyxID8fbSPREaUaR2SzHQn0B6BJBUE49dQepbgELsQrG?=
 =?us-ascii?Q?hqcOBv5gNdJbFJseqso9DXRSgSt5xWv8ubWPj7UOtDqhRq+HWWDNNHbEGFSd?=
 =?us-ascii?Q?ZKqPmvo4daAKivbYcXOjUKye8Lj4qqG3q5Mis5oD0LCVKdawRRTBVFRTObjm?=
 =?us-ascii?Q?PZffHZUZ5Gxg64k4r/zCQdgCz9g7DKZvOuaJblblbdta+XwYSc9xkIxqWSxZ?=
 =?us-ascii?Q?kIFhfWlKJLh0Ex8dpCzRliDGzdvhk7YzrIGi1ttXH2s2Vlz+ITTuJWiEcvaD?=
 =?us-ascii?Q?3dBCrLqUoAh6/j1zCVGi4HpL8T0fAgLsjhEhkyDuu+pxZPfrHUeUTNXEdQ5H?=
 =?us-ascii?Q?HOcu4MPWIRWQkCdeOF0xn9oi020w4bv8xiupNrit?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08b08c3a-c7d3-4c12-5030-08db584d280b
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2023 09:41:01.0044
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fESXhpqEeCUNyxvdrLSoxSsh8KvMw5dzMW802ew8mesU1DG2vU0QtNWvvN4l0RHKfOwG08/oMopf17cJGDlCqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4549
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

> From: Yi Liu <yi.l.liu@intel.com>
> Sent: Thursday, May 11, 2023 10:39 PM
> +	if (cmd->hwpt_type !=3D IOMMU_HWPT_TYPE_DEFAULT) {
> +		if (!ops->domain_alloc_user_data_len) {
> +			rc =3D -EOPNOTSUPP;
> +			goto out_put_idev;
> +		}
> +		klen =3D ops->domain_alloc_user_data_len(cmd->hwpt_type);
> +		if (WARN_ON(klen < 0)) {
> +			rc =3D -EINVAL;
> +			goto out_put_pt;
> +		}
> +	}

What about passing the user pointer to the iommu driver which
then does the copy so we don't need an extra @data_len()=20
callback for every driver?

>=20
> +	switch (pt_obj->type) {
> +	case IOMMUFD_OBJ_IOAS:
> +		ioas =3D container_of(pt_obj, struct iommufd_ioas, obj);
> +		break;

this should fail if parent is specified.

> +	case IOMMUFD_OBJ_HW_PAGETABLE:
> +		/* pt_id points HWPT only when hwpt_type
> is !IOMMU_HWPT_TYPE_DEFAULT */
> +		if (cmd->hwpt_type =3D=3D IOMMU_HWPT_TYPE_DEFAULT) {
> +			rc =3D -EINVAL;
> +			goto out_put_pt;
> +		}
> +
> +		parent =3D container_of(pt_obj, struct iommufd_hw_pagetable,
> obj);
> +		/*
> +		 * Cannot allocate user-managed hwpt linking to
> auto_created
> +		 * hwpt. If the parent hwpt is already a user-managed hwpt,
> +		 * don't allocate another user-managed hwpt linking to it.
> +		 */
> +		if (parent->auto_domain || parent->parent) {
> +			rc =3D -EINVAL;
> +			goto out_put_pt;
> +		}
> +		ioas =3D parent->ioas;

for nesting why is ioas required? In concept we can just pass NULL ioas
to iommufd_hw_pagetable_alloc() for this hwpt. If within that function
there is a need to toggle ioas for the parent it can always retrieve it
from the parent hwpt.

