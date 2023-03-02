Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 977C56A7C30
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 Mar 2023 09:02:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbjCBICb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 2 Mar 2023 03:02:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjCBICa (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 2 Mar 2023 03:02:30 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94F462CFE7;
        Thu,  2 Mar 2023 00:02:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677744148; x=1709280148;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=MTNiweTU2mX2bmkYbIcsGoWBLPjWGiMS75gGWeL3Vao=;
  b=QG29zvG6BtJ0gvDZa4xwnmhlXHZvjnV9dyFcH7M8PraGUIeY/jvnMj+v
   ejhowhkdBVnBE8TCdPl34SosRP/2FuOEVTqcQfBH6QFYssSnbwbOmkeBL
   TLHMgH90dMIvastyYWCM2EjDDDhGM6SKOuNicuzZycIQ6CEdxSukqpTfS
   B8jpSyUdwqITXOGN0z5yN64jpkXoC2CogUS8+Hr+3tpvKPhoNh566RAD6
   iWZ/P0N7ivB/n3CrXroKDn6LEYvavjvW3hCIuHMNchFnLLz6Lm51TEtHs
   ocgarmnad/r7zD96KHDWfJkcWt/q3rZ2Lq2M9kInmP3GiCcMjLYwg59Nj
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="420910032"
X-IronPort-AV: E=Sophos;i="5.98,227,1673942400"; 
   d="scan'208";a="420910032"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2023 00:01:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="652315426"
X-IronPort-AV: E=Sophos;i="5.98,227,1673942400"; 
   d="scan'208";a="652315426"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga006.jf.intel.com with ESMTP; 02 Mar 2023 00:01:03 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 2 Mar 2023 00:01:03 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 2 Mar 2023 00:01:02 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Thu, 2 Mar 2023 00:01:02 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.47) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Thu, 2 Mar 2023 00:01:02 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fWYm1g7w8w+GtU32V1vMFfk/Ael2+rhsob/YXKmxzYXFTSKNMFjaEIdxgTSG/MaK9bAq4ZtrjQpiBChmrm72LAf41oTPBX+Frh5LfAQ7HLO+v1yGeJooAh7gNJrcsYX+cKpLV3Z8CnG0e+kKRPVJAE5icnW0oXsqO4x4sIsZEggKwe2UzYyOvdeNhqhWJOH2aJpEL/mbj9EBAzXv+o4DBrW6kyhEZSvJzZfT7YvTLBq2qhpzDohmHFBi1bP9bsyizZyPKJxRmmJYo34FiZO23eicjvM5DibFTCGjzR71w+oEvidB5KOsdtZylpCwHPNXbI6wfniWUFQ0JxDgAT2jAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JaBnD5XJXZGJ0MJWfWKoZ4dp2tids4wyiDhXnN9Uuu0=;
 b=E0QxF3CWPuYGAitqhvk83n191/0otzRuVaaHFRYuTGwU8/gTU3DVY/hmgRZBl1AoihzJmdueQpDUKTqS91LGVSfHG9TipzCgTp3vSRg+weknOl3PEgviMxzjFnGQiMWQccllbhj9cIGLfni4Ew9v4inh91uZQoWptQWGCt0a1gusYQnIdSvviiZa9bsx/MlDIHbMGFqOc41/7G2KbsiBllBSC2QLzdkmNnNRufaCnPa6EFg791pIQtzMnmytaCWjmaQwFjP+zK7zsdXMSfTWRuWt8kUw39bh6go+mgahGNslCtRnCeabzMC8/zyLfNWqvggbcO4y5iR+66ghv3OiPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by MN0PR11MB6278.namprd11.prod.outlook.com (2603:10b6:208:3c2::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.17; Thu, 2 Mar
 2023 08:01:01 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1aac:b695:f7c5:bcac]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1aac:b695:f7c5:bcac%9]) with mapi id 15.20.6156.019; Thu, 2 Mar 2023
 08:01:00 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
CC:     "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        Nicolin Chen <nicolinc@nvidia.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>
Subject: RE: [PATCH 03/14] iommufd: Replace the hwpt->devices list with
 iommufd_group
Thread-Topic: [PATCH 03/14] iommufd: Replace the hwpt->devices list with
 iommufd_group
Thread-Index: AQHZSLAPp+svwc7r8E67jgTrC/2K1K7nJ05g
Date:   Thu, 2 Mar 2023 08:01:00 +0000
Message-ID: <BN9PR11MB52761557D23695475CCCF3B18CB29@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <0-v1-7612f88c19f5+2f21-iommufd_alloc_jgg@nvidia.com>
 <3-v1-7612f88c19f5+2f21-iommufd_alloc_jgg@nvidia.com>
In-Reply-To: <3-v1-7612f88c19f5+2f21-iommufd_alloc_jgg@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|MN0PR11MB6278:EE_
x-ms-office365-filtering-correlation-id: 6f786b04-85ee-4a63-bcac-08db1af4436a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Chx4rg5nXVKLK5pgwCMzfUCT6utn5KNnEgs2NJDfeWaf+qSOZwAvZ65pG/78hpRz0/FmTNA15+HBIWNsykt4TLeAllccJfAUPgGqMU6nNKeCUGIMRI5SAyjfkbzcableltuqXSKHNmkKP4bnf8+E3m9foAo3+JqFEyjD4bM3dL0JZI1dt3OZGmunDrdPXdKI9ZI7DS9lLilo2+0KcTHvf1KaU0Cxrfi/PcW4fspK8e8uj0yF0zSampZCz6lAcc1Qm+mMd6QbXwv7ClH3aaKwt+e1OGzxBSSfw1ChUUyxj8DHwaiTjPsWcHjUhUzsST3yZhBQ3hGy29i0Y/TOgta6hWxoweh5ua8oeGlKPNNoSo/tKW4E8Sr4y7HCGBqwLoeXUdNHX9yj/dE/mMZIQ92L5vZHMVnfiQhj/p6oOal/+p6nk07TiQKSassV4GgiSBjIGWb9LtjN1ukald+q1eFMNQIKoDf0Cb+k8fT9yqQvi0IF72cdgWMxeqgvwJSHZvKztyB1kgC4hVpxtwCLZd3JG9XDwkiK4lkdfIB8CVR96ak1MClxiE7LrR7bGDYI4BkBPWl5H2M4nDmczxsnQHEBg60puDOnfQGdThyGAsHEytvP6ME1E6mhri8LJvNyBczjMPeISYNez84sx4l1leslwg70WwJyGHHcjm03au4jI4m1VGpC2CYLseXhmGPQ1ccogGkQAsx1U5E5n3F93wz6Fw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(136003)(346002)(396003)(39860400002)(366004)(451199018)(33656002)(86362001)(2906002)(66556008)(66476007)(66446008)(66946007)(55016003)(41300700001)(8676002)(64756008)(38070700005)(82960400001)(122000001)(38100700002)(5660300002)(8936002)(4326008)(71200400001)(107886003)(7696005)(52536014)(478600001)(316002)(54906003)(76116006)(83380400001)(26005)(110136005)(9686003)(6506007)(186003)(21314003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?AOXZbW8D7iTtbLygwUrS8GBKd895tt2Q2zmqAci882VZcOflMFW0g8pbeopf?=
 =?us-ascii?Q?W0tyI0k63B0TzQkjRetyBjMRz5uOOo1lzgTZ+BQkFGDc/3w8IRaCnGythYEP?=
 =?us-ascii?Q?v8NVuqD0eacDNB/534luNRQa+FH7f/C0LsXr/vjTEwJJ3N+UXt5WUMcO/XEQ?=
 =?us-ascii?Q?q1KMqBH70cyJVq01WnHiM2r+1M8/9YhPnxBaykQUQNlfUR/wgH5quThH1Lai?=
 =?us-ascii?Q?io1IlkanFdKML+NZsLaB0fog9XrjGblAndUU+78eDBjMKkyaM7DShS1Wx+GM?=
 =?us-ascii?Q?OKTeJBpdbfj8qh1JOajRfkuy7K/fTRpTkPZ1h1MTdaQaD1dmKNZsbc6oXH2U?=
 =?us-ascii?Q?vI2pHRD8EqHE+hbA8de++xCj6q9s/+JSlrMMZ5Iw/JdAh+yO7rVyvrXOGe6e?=
 =?us-ascii?Q?3m5UjFAXasflpXkD/dBzL096nosakRbY38iyI4eVYBRxlw5AOPZStp9qmKLK?=
 =?us-ascii?Q?3ubSCUcQliS+OFtiUxRdm0gNhjTcQEXkJtPztviuldGU2AyW/97IG4XgSpcR?=
 =?us-ascii?Q?k00EX68lROYwjNfnicPGvGZnGIb+U0xAkjfAD2ufpBqjeW1K4dQ97dzRh5hi?=
 =?us-ascii?Q?1gDvhtybN8aVzzfpdqbJ2isMPYpKceEsoOQZ+hM+MBd6z/M+IwdWs+Rs8wFB?=
 =?us-ascii?Q?jhIA1F0G81Gal28km8UAk496EaSAlMBwkJHCRiUrzXSa+VDnwx15yPMM21Qx?=
 =?us-ascii?Q?AgZxWvat9SgZlBn645ttcN7fecm5Rq+Qi/Lb2DhVIdYXnxzANVIgNkH0BAe7?=
 =?us-ascii?Q?xDL9v9VPIvh2Ygf/2+ssxXTLldeEida+xMCUeoo1mGZre02lt1bXos9llJWQ?=
 =?us-ascii?Q?hxWEI5x/eovjG/ivEeQvbpqch+9NEo/Mg7CZa8gEQKg3FcckwLuZghMvJ7T/?=
 =?us-ascii?Q?+dmLciu/0uDwji3NWBn4RkJm4YwMTKN7RZoLImdUL8rQPz0h3I1IWSyssBTx?=
 =?us-ascii?Q?eiDCod2ZRkDGT8Hr1ksPISw0EeXCj+zBwfu8WX2dOD3FEId3w2iqdZS5weCU?=
 =?us-ascii?Q?t610AtSKA1PcdgoTSycbMpR1D6lub/ktC7ADP5pn2gKfZ34c5Oi9Uyp4xZDV?=
 =?us-ascii?Q?55UumobhNc/au8cHpq6BuJQ+Ht6eDjVObl3wxYkMoV5hwi+oBHcAXQLoJ2Ub?=
 =?us-ascii?Q?YJUIpPE+vGBZrXI/rdcZe/sdb4V4CIPYrqhqCeZYDInL9RV7THHYaq9OMAOc?=
 =?us-ascii?Q?gWFoLUD78Lnnhqvysgnh+DL8fUNP4+obcMdpW/qwcy1F+FBMTDdbC0lEc2nT?=
 =?us-ascii?Q?ou5+aChmQiL1OvEbXAxE30xHkvLPs2khBrHFb3BArltgXiITr8DmvQ+ntACe?=
 =?us-ascii?Q?30QOME2B6CxsCfBDPxy0EVZ/8aV4XzoJeExCe5KqNodsv/QNcANdeSWuKQkM?=
 =?us-ascii?Q?yueJThSC6HZrEWsCnYxqHZKBbrjfsFq25lWhjOZ9CBqLVs/5mi4JCP//OlyG?=
 =?us-ascii?Q?XvZpqcsMZFEOAKh+iiIKmE99Fkx1+N3VS23ulfp6ToSDYgvAWBfupr8O4Hip?=
 =?us-ascii?Q?JwiPiZdOq4znsFeC/nIVKvcEX9zBay1nqWaZo5N2WEl6WL94Iy0QA8iG6Viu?=
 =?us-ascii?Q?CRfx9CIUegOTECupwcZ07EJqCCRcjZWyGKKLh/4U?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f786b04-85ee-4a63-bcac-08db1af4436a
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2023 08:01:00.7361
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iDRRu04YpJdlggha2Or0IJhYiMWefMvw3CugFQ1hrZZTaaRcH1wJDXAGoJ/vUD8k6aRHn2q1DZjS83A57m6nAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6278
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Saturday, February 25, 2023 8:28 AM
>=20
> +struct iommufd_hw_pagetable *
> +iommufd_hw_pagetable_detach(struct iommufd_device *idev)
>  {
> -	if (!iommufd_hw_pagetable_has_group(hwpt, idev->igroup))
> +	struct iommufd_hw_pagetable *hwpt =3D idev->igroup->hwpt;
> +
> +	lockdep_assert_held(&idev->igroup->lock);
> +
> +	idev->igroup->devices--;
> +	if (!idev->igroup->devices) {
>  		iommu_detach_group(hwpt->domain, idev->igroup->group);
> +		idev->igroup->hwpt =3D NULL;

hwpt->obj.users should be decremented here instead of leaving it
in iommufd_device_detach().

>  void iommufd_device_detach(struct iommufd_device *idev)
>  {
> -	struct iommufd_hw_pagetable *hwpt =3D idev->hwpt;
> +	struct iommufd_hw_pagetable *hwpt;
>=20
> -	mutex_lock(&hwpt->devices_lock);
> -	list_del(&idev->devices_item);
> -	idev->hwpt =3D NULL;
> -	iommufd_hw_pagetable_detach(hwpt, idev);
> -	mutex_unlock(&hwpt->devices_lock);
> +	mutex_lock(&idev->igroup->lock);
> +	hwpt =3D iommufd_hw_pagetable_detach(idev);

the only parameter is idev while the name is called hw_pagetable_xxx.

is it cleaner to get hwpt here and then pass into the detach function?

