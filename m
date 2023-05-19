Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66C4F70929A
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 May 2023 11:06:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231271AbjESJGa (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 19 May 2023 05:06:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231322AbjESJG0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 19 May 2023 05:06:26 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4623110C9;
        Fri, 19 May 2023 02:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684487184; x=1716023184;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ToU5xSGvYNSCbSB6vjoRxSr/NbuM0IKehVpa/NLf2F8=;
  b=eX6hsojl/00l3cQukJfJrPQItHcHDRmFQsdChhvPTQ7hXMjfptgsagva
   rpEOSG9/R76yC4JRutlXR1DaGfz7kJpwTkYmGbyH6nquOsFXUZL3X778l
   e9em5sLVIsaGmkmFh2zqbKcQvprybssClQRKGPi1JYKOLjXsYjhOwITOW
   xOGGmsGSVNOD5Rd92c5Frh1lMD+QyKFe2/tw5Z/9NdUaEbV8rudOQskTJ
   GdwuKvf1Kw/HYkQ3nml3bxaUnmi1sadTG4mYRseiM3n4/FMBHbK/F2MgX
   LB4ljRV+hOs5NWQl3MGq7cZ7EHy/b8glJJXdyIxXiQpxBz+jVaM93SxhB
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10714"; a="352342719"
X-IronPort-AV: E=Sophos;i="6.00,176,1681196400"; 
   d="scan'208";a="352342719"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2023 02:06:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10714"; a="814650645"
X-IronPort-AV: E=Sophos;i="6.00,176,1681196400"; 
   d="scan'208";a="814650645"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga002.fm.intel.com with ESMTP; 19 May 2023 02:06:23 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 19 May 2023 02:06:22 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Fri, 19 May 2023 02:06:22 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.46) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Fri, 19 May 2023 02:06:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qc2V17EDT98LNOoTQ75bwpJeShMFRuAnAw2oPt/Fq4Xnq7MFmG9OCW9VnuNMUZujOzwJ3YDMBkn0MmQ6yXGOPYYaMcVf1tqqINPz1LKbCUNMQfrJoZ7ppMjEI0UQQYBVpUsEZzIxd8MQIduqTawrJWW37YUzhyW0Rqmv+cQaqT7Xa+R4eTvCXxeCeyj3yxLFf6JCnzVNEdsMwMTzm6LcELEJvFt4/u4sSg8+Oe/VyKGGOIOfIiFxSdwnEpRn0ovUC/voHRw08pD11n3RFa41/1DXhFA4WAb5gX3zSuv83pK8vwGQ30/VOwQyTZ6RSdTkrkQ+b6y+RAa1hkGaLQcBcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rop1w4mU07atgJyP5sUuAhGC+5gOaR5eBXuH8MUaSBg=;
 b=K4dPOq891en4d2zoPR7tgnAh6223yRUsYZqt6XpUr8YjOrxFxPRZVi9CqUMRs7qbCwQBMYSh/S/lPBXyGLjZASDfXD4Syp5ILZo2rQVx5W8cFQECwv5f5Oqw6faIiBVNmNSZbmTHDmJSUaB5ycF2X85sDbwcowCELc0vvvYtXzzWRdORjQe5WqOUSMraP/22f/96415w3wWhQRln2Wbd078GBztcuONv+GbpDtjxWwj+v3Vs76JBfwNiboQhrCCvo0SDFiM2bwJaNYvsdPNqrUoV/alkcO/WhjrajGgoLT2CxPMzkpG5qganCt4s3wtdzLUXPYot5/HBuxGcpv7RIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SN7PR11MB7512.namprd11.prod.outlook.com (2603:10b6:806:345::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.21; Fri, 19 May
 2023 09:06:20 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::73e9:b405:2cae:9174]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::73e9:b405:2cae:9174%6]) with mapi id 15.20.6411.021; Fri, 19 May 2023
 09:06:20 +0000
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
Subject: RE: [PATCH v2 04/11] iommufd: Pass parent hwpt and user_data to
 iommufd_hw_pagetable_alloc()
Thread-Topic: [PATCH v2 04/11] iommufd: Pass parent hwpt and user_data to
 iommufd_hw_pagetable_alloc()
Thread-Index: AQHZhBZVjU0+oTnptEmcGUc2PW+bOK9hWOSw
Date:   Fri, 19 May 2023 09:06:20 +0000
Message-ID: <BN9PR11MB527662C871DD8351E9F507D18C7C9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230511143844.22693-1-yi.l.liu@intel.com>
 <20230511143844.22693-5-yi.l.liu@intel.com>
In-Reply-To: <20230511143844.22693-5-yi.l.liu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SN7PR11MB7512:EE_
x-ms-office365-filtering-correlation-id: e5c4e515-cd9a-4b0e-9113-08db58484fd7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sEwYfy9mstsNNiTNdn/IHo/LowOIBo6e2QixITJqQ52H1G50ggTvdbiIGFK3zZZ83oUjqk9MUFKug/PXfKACRF99tU9nzcK2KflQLBe3vm6eMLmiqtHhWXZ2iwisYBNfS8msIbHahMfo45R3tm+4YE0/f0tAmrVmeH3Uwh1WDAtdxiokJvk9sBD+fx5vBqrAMKW1Jb0hMsTs2dmPIkd/FHBnooKOM+8S50xsslnpxAFB0WFLnHrnTDHGkO3AYrnBzzUPmrmYYZRt2wA36M593dcQkk68MoxoDUnQdRmagkg7AU4Trv3/s2OyTYgFvPlnMltBUZ/EOGMbDzl0VYeOANzTxvUr3yH43kWMYIB4AiyidvBLOjQVdS9H1SnKe8QqHDhKX4lnIFKBcV/nXc4ehWc6d8h89odw5JKeSJNm2yEedcSuW8mnVy7DcOSqn5gd3tSkDW2iTT5NONb1xqBOwcOKQGVpC/WgQLI6m1aaFPPVaugfeVxrL24maCgm5GZH2NJvquirRrBhpO9tff+1OGY6ZjkcBiouDgI5vauIeaiXr//3M98oBxEu0geCsB65U2arrqwQ87nkEXIp8mwl2NTq7M5rLq1TnbODxmm0oqeXudlN6IIhJfhQ8O3SgeAi
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(366004)(376002)(346002)(136003)(396003)(451199021)(33656002)(122000001)(82960400001)(8676002)(8936002)(52536014)(5660300002)(7416002)(41300700001)(38070700005)(64756008)(66556008)(316002)(38100700002)(4326008)(66946007)(55016003)(86362001)(76116006)(66476007)(66446008)(83380400001)(110136005)(6506007)(26005)(9686003)(186003)(2906002)(7696005)(71200400001)(478600001)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?EYAdzUJaCXCa29Cj/lK1okhkYRDBeMo3bI2izZ6RydYtDFdhXnov+qlwojcQ?=
 =?us-ascii?Q?Tcacnqh9AAhvhLoRy4n+Cys7dXMMDYgCZjWdu32hUt+WecIoDJkHoWyi0TQu?=
 =?us-ascii?Q?WdvtEzMcabN2mm16BarsAMk1LWZuNUIt5OokplPgmYk4Al48N0s6ZKpsoNOX?=
 =?us-ascii?Q?zOmY/EfOtuT3U3foS2IT39FRrxnd92paDIG1J7eKbWUSzXOuwv7N+PcZz6oL?=
 =?us-ascii?Q?lvIGjkA1hbztjYhJ0hXgaVdZT1uLiTkXdqPwAX8QLubd/R4ti3PtWLjeXQg2?=
 =?us-ascii?Q?rZAQIkDGyXzbt4CJbNlqjpLo7X6iGT1jw0eYv/D5wc7wJjp1GsEFt0RnXcJd?=
 =?us-ascii?Q?TTpRCuCpweVLlf2CzL6rUGb1UUKNCIsduQDyZD5FjGJS+0HtQAOSylwYEbiE?=
 =?us-ascii?Q?Y6BQ+hviLaDpW9HffNKSeEx5WuoBU+5fD+ZKCVxNu19RzrYV60QNtSqKqrYa?=
 =?us-ascii?Q?csQUDRcJFRwEVZrVZ1lyjOVMJNqXhtn2fXT7kbhzn2PpWYAcJFhWAllmWJv5?=
 =?us-ascii?Q?HR9Pb/FYiq+JP/VIEYhya7MD5YJHRnslUKTK/50+FiuPod8We0eLtpujfzUN?=
 =?us-ascii?Q?DV2OQ8gRL6O7O7h+dg2x/HDQIDf+2EpJIhEXek05I7ysQekMjK2hi8v5LzTj?=
 =?us-ascii?Q?it2/ou19D8PcfqNC1S5qLarzypm/ZEqhoP+4ymTQBjgipFfZrMcEwXCZi1BA?=
 =?us-ascii?Q?OFBZHWVmEmDhvxkI7DU9Wpgre2/z3qDImzAvUF8ZI9SRv6bIK3JMdYa91e6f?=
 =?us-ascii?Q?4xU1li56kY75uFNKRlUNEXJ8TvmmoXE/RNYuKCxCEf0CspykvxcXSwLQ5tQq?=
 =?us-ascii?Q?d2wbl7MkXXAMz61M1ryefbsfniCQe0viIdAXEpuGDX0cPoo9JUB6wPIJplo2?=
 =?us-ascii?Q?LDnURb8KV+/qZTVcbBEloLjeIdu2bruMklgkNF/NXtRpRtekke9gefC29z7I?=
 =?us-ascii?Q?y4hfEDpvwRGgme7w9wF/RgPI40xhvHwUMfruMlOgEueXsItbqhR47agrZNzD?=
 =?us-ascii?Q?hYErcIH91Oj35iB7OSEIJXvFE+7EeuhvybJBsad3uAdfJgBtNJaGcOzPBzWb?=
 =?us-ascii?Q?5oHPDbFqn6inwOydWu5g8+JGcxaxmkjkvy1d5/FLt14RUvYPonymfGQuBtzQ?=
 =?us-ascii?Q?Is7gnJETv4YLDBU0xM3g4FaPnivj2a6pG6Psaj4eko1InQUSKOQ64rWn88SE?=
 =?us-ascii?Q?/KIroqItTaSlLHZRKKctwgPM94tru9Lb8mTQkXlHIez+v/Lc12dZJZukiQoX?=
 =?us-ascii?Q?7rFi6KH9lMZ/vw20yR0tfcNAqExuJT36oqsuIa0CeHq7GmRNPxa2oD9wh23o?=
 =?us-ascii?Q?4gy3y9Pta7Bbew0xXBDoNVKORQ/hLlvC4W6hZQ6lYHW6l+iPja5ZI7AwaQX6?=
 =?us-ascii?Q?tbsK1mZBpRCPGKIb8rHF1mm5yBD/XblJv6tQunX6X/8KL+ZsOjTQjmUW8RY6?=
 =?us-ascii?Q?+zVjU8VCqEU7PSmEB2xZWvJewPWdyn4BnxEjYwGpqH0+EpSEBgbbzgioB7Rg?=
 =?us-ascii?Q?jckH1Rcq1AylgWdHf5UK3mw2sOUp4da1FmpSz4YvKpKdHx9jQvSMT9mNNqxK?=
 =?us-ascii?Q?eMA0uLva6UoapQYu8qW6r1i1S2AtAucr43H3M1vI?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5c4e515-cd9a-4b0e-9113-08db58484fd7
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2023 09:06:20.3283
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1VJV1ehfkJpeVcfn1RDES4xM3amp9tYHL7JiJLvsoWm/wMJGh04SOZKU0UU1+mJ+JUproK8CA4O8elwSsOSJwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7512
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> From: Liu, Yi L <yi.l.liu@intel.com>
> Sent: Thursday, May 11, 2023 10:39 PM
> @@ -61,6 +63,8 @@ int iommufd_hw_pagetable_enforce_cc(struct
> iommufd_hw_pagetable *hwpt)
>   * @ictx: iommufd context
>   * @ioas: IOAS to associate the domain with
>   * @idev: Device to get an iommu_domain for
> + * @parent: Optional parent HWPT to associate with the domain with

remove the trailing "the domain with"

> @@ -73,14 +77,22 @@ int iommufd_hw_pagetable_enforce_cc(struct
> iommufd_hw_pagetable *hwpt)
>   */
>  struct iommufd_hw_pagetable *
>  iommufd_hw_pagetable_alloc(struct iommufd_ctx *ictx, struct
> iommufd_ioas *ioas,
> -			   struct iommufd_device *idev, bool
> immediate_attach)
> +			   struct iommufd_device *idev,
> +			   struct iommufd_hw_pagetable *parent,
> +			   union iommu_domain_user_data *user_data,
> +			   bool immediate_attach)
>  {
>  	const struct iommu_ops *ops =3D dev_iommu_ops(idev->dev);
> +	struct iommu_domain *parent_domain =3D NULL;
>  	struct iommufd_hw_pagetable *hwpt;
> +	bool type_unmanaged, type_nested;
>  	int rc;
>=20
>  	lockdep_assert_held(&ioas->mutex);
>=20
> +	if ((user_data || parent) && !ops->domain_alloc_user)
> +		return ERR_PTR(-EOPNOTSUPP);

Do we allow specifying parent w/o user_data?

> @@ -99,6 +117,15 @@ iommufd_hw_pagetable_alloc(struct iommufd_ctx
> *ictx, struct iommufd_ioas *ioas,
>  		goto out_abort;
>  	}
>=20
> +	/* It must be either NESTED or UNMANAGED, depending on
> parent_domain */
> +       type_nested =3D hwpt->domain->type =3D=3D IOMMU_DOMAIN_NESTED;
> +       type_unmanaged =3D hwpt->domain->type =3D=3D
> IOMMU_DOMAIN_UNMANAGED;

no need of one-time used variables. Just put the conditions directly
in WARN_ON.

> +       if (WARN_ON((parent_domain && !type_nested) ||
> +                   (!parent_domain && !type_unmanaged))) {
> +		rc =3D -EINVAL;
> +		goto out_abort;
> +	}
> +

probably just WARN_ON_ONCE() to mark that driver has problem?

