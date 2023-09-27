Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 358C17AFB78
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Sep 2023 08:57:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbjI0G5Q (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 27 Sep 2023 02:57:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjI0G5P (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 27 Sep 2023 02:57:15 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E355A3;
        Tue, 26 Sep 2023 23:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695797834; x=1727333834;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=B+o2Mp8Waxvj8gtzeIo2cM7FTxKuVQFJuKHHBuAu9DE=;
  b=dvXE+iTpiuTfWWbZnXQq50qSlDUjhJiSZGiw3xEVawPffe82b/lbVSzv
   6ciUDxxp/s/2+iZtFUK69gWpao5EHJaJok77XYk4lRJwPV5508UUOlFhO
   nXDbeSLzdNuvyR6hp9lUPQ5oMC/cc9l8pP6bVxyh/aNEuWdllNjYRvx5V
   jkO5/5WYi0athbN4QnDNiibBwIraTwkuPg9EtqXojUbqDXWEfQeD6pHAn
   yIp2zXirx9xE28XbZldtwdvgvsj+KhDVd7wY6P2keNdrEX/szZg5oWUlb
   TA6niffbSdSDSh0gtvRjvvvqzLh40c0GtPzJSR4bZNOJK4qAyT2RYUdD2
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="361132692"
X-IronPort-AV: E=Sophos;i="6.03,179,1694761200"; 
   d="scan'208";a="361132692"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 23:56:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="784214490"
X-IronPort-AV: E=Sophos;i="6.03,179,1694761200"; 
   d="scan'208";a="784214490"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Sep 2023 23:56:53 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 26 Sep 2023 23:56:49 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 26 Sep 2023 23:56:49 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 26 Sep 2023 23:56:49 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.46) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 26 Sep 2023 23:56:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i1cniRQxwZKt4H4sSG+YeSytTKfZlPMgC568EjVZIO6ET6nS8bnPD9OAmTzbyiJZGkZZpoZFNEV+DWsoGQPN7AOwniwhnQn6/1b/ZLp1iVbg0dadBPmeojFCYHCECG5Vjf9BaWRqV4CZSZntwtXcyLJqfVlg54DK7uBvdg+DRHlkNZjtH7Ewdhqf4IcIO4tfe2MqjI9U8jAwOke7GMCqJbj/H2c7hP8IQC815pIEOSGWErzobXkKCbEB3vPCIq22wcUS78vZTZbqQ3jqxMYs4kxKmhb7kXtfFpps6e/LqvBbXdxs5kyF6Bczm0y2is2MlulmM0hx/Yp0eOKEmjlnRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Aca2/vM5ouj2vATM+jdeQ9apT4y4Gi28dJ5m3+byIu4=;
 b=afqWDF8Hw2cwnkGLb5is1XHpzpH2AoQaIuLiLgXdYC7nVeGGqIR54ANI7290hX6ErY9sZkuOXJ2NDtPXvycnwpLwcPjI1UwwZld2JOsPRsNdYKUjSroAaoNehgLl1zIOKb77H2ddpRo8q0zj92vHTCK4SxPgttdlmxGHsCrL5rgO40dOIQdvjPhI2LtlEj+DE6M/o1375DtHe6pNnW9BfVcj7rb5juL3tN99qnOOMI/B+hjJhfkUIDDUGrVyjQLvlnt82lPSTeIcoPW5F3PMGJnfzIYZkzYcqmqKsnU8IHsf4q9RjaqonWVG1gPX8wS7Iflowr7kxStWd7xX4te1ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DM4PR11MB6501.namprd11.prod.outlook.com (2603:10b6:8:88::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6813.28; Wed, 27 Sep 2023 06:56:46 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1bfc:7af0:dc68:839d]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1bfc:7af0:dc68:839d%4]) with mapi id 15.20.6813.017; Wed, 27 Sep 2023
 06:56:46 +0000
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
Subject: RE: [PATCH v5 10/11] iommu/vt-d: Add nested domain allocation
Thread-Topic: [PATCH v5 10/11] iommu/vt-d: Add nested domain allocation
Thread-Index: AQHZ7GDrjeYLNxdr8Eee9XQGFZYhi7AuRkjA
Date:   Wed, 27 Sep 2023 06:56:46 +0000
Message-ID: <BN9PR11MB527619427F9C41061FB3CA408CC2A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230921075431.125239-1-yi.l.liu@intel.com>
 <20230921075431.125239-11-yi.l.liu@intel.com>
In-Reply-To: <20230921075431.125239-11-yi.l.liu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|DM4PR11MB6501:EE_
x-ms-office365-filtering-correlation-id: 416cf112-f958-486a-d680-08dbbf26ea65
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OHLWwgumggqoAODHGhvvRiwb8cIOZBbH42IKBAyARUxy5yksihcl7V0BFBMMpHhkgegA1kpDQTW8yowiBgr/dUcg2JgugFN67GSaHJFTk3dyVgksvSwqu3Bz5xQ62C1JDr9FidPgkhJYH7VhKJHP/T1Eqm28/hp4SOe6QxEwU7xehcTvUX4L/644T3+MKtl6RZyO1xdnyTef/0dulTL4b1rzLNtx8SEcf8zUerfvD29WowYHuxD44IdsI/nnj+X3OL3MsKPiTqhD1XS6gC9X6/otlClO7qj2ihzgcPJ+UJ/59eqvQlN0I5u19RtU6oU5LumNDO0Xap/ZcaJ68f9zK8HXcnXugSls4zfxO8YOGht2lwFmGN3Kn1ZaCxa/YMnn3aZq+jQ7fiAYAf8zyNu8GdsAq7Bsw3OAku6MuMfJpZlaijgTqdw50gqRC2EDXnzHrARS8rIEOGkUJ/Fvqsm392IwliwKf6Omi1UlfqHYGHRZjISqOnRlrAMn4bBQHRwxu4mT3s1oCnQ0HvvMwBW9O/BhRZdQCLifXIBvxZ0Fvv4wTJnvYoGhsT9eNkFN89XgR3vxkgd7VK+hYV5pJiMWUqPMW0scffr26OOoJon3JuOk1rG2wkbM8bXB4C/fVqgwRJFP7CyexoR6iGdNcYiYzw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(366004)(39860400002)(346002)(376002)(230922051799003)(186009)(451199024)(1800799009)(4744005)(7416002)(2906002)(8936002)(66446008)(66946007)(66476007)(76116006)(64756008)(54906003)(316002)(110136005)(66556008)(52536014)(4326008)(55016003)(8676002)(41300700001)(5660300002)(83380400001)(26005)(33656002)(86362001)(82960400001)(38100700002)(122000001)(38070700005)(478600001)(7696005)(9686003)(6506007)(71200400001)(309714004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+gcf0ZaBnzsRdvrV3Wn/+0FWKlbWkDxg4v+Itf1Qp/C/tf8PCafbPkOr7sUt?=
 =?us-ascii?Q?a23rPin1ypSMnAb5twlzTareqZJ/h5QcKlwXn+Uq+Pj6JX7x2V+Ri9m6Isan?=
 =?us-ascii?Q?RrwH3c1sRqe0xYJRZVa3zMosTuzgfekhUCM2eobEnozwHz0N40yWrmnvZfsC?=
 =?us-ascii?Q?VMrNygZ0IZ5Ti+B12XjZXutOMUIV2bzA5NivY2WxGGlb7P3MXbVwJnCe/4iu?=
 =?us-ascii?Q?+oPpe6X0cU1Y7RGjMjUwgVuewycCzeCWP9I7D2xO3FPMYBTJUAn0cUk2FEmi?=
 =?us-ascii?Q?4KnXF/xV5ISeuyPdLnl7DSXsL3D2MEQTwTVELUN1sQ1UlkzU7R/pNbKjWnJV?=
 =?us-ascii?Q?pQCcD5X11DS8uEE2lGphzNJxAWxUeQh58KyJn8NqNYV5jJw6OA98aMyqBFTN?=
 =?us-ascii?Q?/oqcYDF26IDK+UCRiIwW6A/JB5whg/cX7WP/JcA9nU0J3qH9xgKNsGs7C00m?=
 =?us-ascii?Q?bLnagbqNEBKZmssxXEtdUWVUO2yZaQqw0OXVFya6s6jiRjFL9fT+O+3z6RlR?=
 =?us-ascii?Q?OObpqa7ATMi94Q1clp1VvVuepWxITcOwOw/JFz2Jr13jkFAlLf2x0fjsfYYp?=
 =?us-ascii?Q?Tdd30Mgknsn0POsf8SAMownx5L79rZH588psXdaXtMeajQHPvGqS8LoiR6+i?=
 =?us-ascii?Q?atUKFaZKM0ck9e+0yIKPoAGkcxxow0IWGYLoAR8eAuGS/7tthgghdxm3Z1GY?=
 =?us-ascii?Q?/36PlhWctnwo5UzfpjbXqEuINc2wP8rtDrj1N3ErHxDvkiruWI+DNfK37IeS?=
 =?us-ascii?Q?NsIEfNQm3/96Wnhi2Ub7OunTOcq9WKeOV0J+dXHUOJlRqtGFTxqH8s4H3+P/?=
 =?us-ascii?Q?rCZJ/fTvnmrUFXWie54IEaxTl7db7DBfgnWeu5JLnJVOiZfmrLR0fHOFPPsx?=
 =?us-ascii?Q?t8pTqmaw5up3M9oKXzyqT002l+XY1GvQBlH8YRsBn8NmddCHHsqMyc46buL9?=
 =?us-ascii?Q?bH6yWxt21epzV8e3AKe1Gh2U2XFMT23C2V2h/kD0v79Q4s0AqvgW4cGU5CcE?=
 =?us-ascii?Q?L8Ay89FMxcgiRE/Evo6z1QC4/zDNWGOMXdMrzXfOyuxdtzLsZa8oddjJUXmh?=
 =?us-ascii?Q?eK+IHeOAymsHvYVEwmxs24dRb7l1sdlGUnnGtCbQ0Q6vhHACuryElnPGRhnE?=
 =?us-ascii?Q?KAs/RGm7+QnjUu9GtRTjlo4yUS1pEnauThg6tfgQHFyJy77ifZV3WlegFisv?=
 =?us-ascii?Q?PBFFLX6llysfacPYd6+qbTZA6t+2Zjvp0M7e2Cm/SIPh/MKjiwSesgfHiMFH?=
 =?us-ascii?Q?JHcA4Ay5FTRJac4ov8oS2QMDfygIrKrvOj8fWrQUgOpvVZUO1hwrmieEkMuP?=
 =?us-ascii?Q?uzkAyfcTzslOndODpb2jqq86XHHm29a82Wq1yfDCn6toQwUv+nWmrwpT1ZH8?=
 =?us-ascii?Q?xN+0OSNAJ11RyGBvX600VznulNo6HRJg1CiWzwmHcziGODfQnANAOLo05kCP?=
 =?us-ascii?Q?R2soEogzGpCNJmx1u2aCv0ceol5gafGgzQJoC3+NUpti2ph86MSEzH1+w57/?=
 =?us-ascii?Q?qaYAPeGVve9freeCKXuyAnvN2Wt6TCitg23sBEaZC6L0cUnrAkXD5r0BXI6G?=
 =?us-ascii?Q?iGi92YCJtUSzQUOZJHDHAo/3VaUu5JqFg4UU8M6Z?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 416cf112-f958-486a-d680-08dbbf26ea65
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2023 06:56:46.5000
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TGQvQhNRT75OYKi6k2uuB9vqH2kQyC0z4hc/rKqV/uRZcnYAUed8+3n47ESIJvM5Q4EPW6vH+1rQbUYgWnN6vA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6501
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
>=20
> +	if (hwpt_type !=3D IOMMU_HWPT_TYPE_DEFAULT &&
> +	    hwpt_type !=3D IOMMU_HWPT_TYPE_VTD_S1)
> +		return ERR_PTR(-EINVAL);
> +
> +	if ((hwpt_type =3D=3D IOMMU_HWPT_TYPE_DEFAULT) =3D=3D !!parent)
> +		return ERR_PTR(-EINVAL);

this is probably too strict. What about intel-iommu driver supports a
IOMMU_HWPT_TYPE_VTD_S2 later for some tweak w/o nesting?

let's make the parent match specific to VTD_S1 type.

> +
> +	if (parent && request_nest_parent)
> +		return ERR_PTR(-EINVAL);

this check should be moved to iommufd?

