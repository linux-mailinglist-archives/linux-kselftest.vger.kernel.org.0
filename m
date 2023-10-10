Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14EFF7BF592
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Oct 2023 10:20:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442726AbjJJIUD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 10 Oct 2023 04:20:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442767AbjJJITx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 10 Oct 2023 04:19:53 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F080ED;
        Tue, 10 Oct 2023 01:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696925982; x=1728461982;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=9fcMhMd+ocAIkL7qD4WqJZ49LFI9MekQgsuAPnD0qJY=;
  b=f1tXzC5mltrlsNgy1IpL669w91L7WM/lrjRzhIyl+LLnhbCBuPGMU+Be
   BbADLKA0luMDI3UVFYTCPqLBM2klQ6R6tRdpkwDDtodIrgJHW9kfqlTVN
   NUIkKWKnRQkPNwjf0GiOXIG7hRdGMEYMIsf5PimUxxvmm6mZtQeGzVaWQ
   oEN3sdgay6ULN2ME+cbe3ehZQzRd2r8THiWQGKdfADhmn/MUlwOZXmzGR
   QqkJtNWGYYfc1ev1nzLO7qBhOF/8hBBjRzH58awluY/kwfBbG8zCvnB0L
   1ZOmGzYrP/bf/KE7dzejJ4L+unNupAWdBWzKQ0fI6Yt5pO5UG6WroWwXM
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="415342300"
X-IronPort-AV: E=Sophos;i="6.03,212,1694761200"; 
   d="scan'208";a="415342300"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2023 01:19:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="703220587"
X-IronPort-AV: E=Sophos;i="6.03,212,1694761200"; 
   d="scan'208";a="703220587"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Oct 2023 01:19:41 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 10 Oct 2023 01:19:41 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 10 Oct 2023 01:19:41 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 10 Oct 2023 01:19:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IdpMyPEMBcfB1DO2xg8MyRJPfUTHwgtwpKAubAU2rfhwK8apcD2y9m81SySr+eX64cmWtZHoUDQzEVT0qvZ1XYvb61XCXHGwUlnfaFYuHri6l5tqrSl7NXqPrv9xTTiIiJp+BNFPDFQcpMQF9kOwgrm6nZod383GTb7LMaOMDSzgZiJ54iksOQ8fbl0KvQosGNVsazxEAribkaA92pQFKzlThoDqv5saNKXIB1GWb8kclj2e/2zYRIq4nIrcg3936L7gZsj/IhcWSW9M+wcVlhCSPrsSccfVmYYf5CRN2mVNGEmp/V6dVtdsB9oOIm4Q5Ie9VatnrZTGKtEu4LtLWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QFO6GZrfrMqpgzELEe/2s+a5NqGk1mZupb8fvJkEPjU=;
 b=WGyrGO8axuTB8drfm2UbM9T+DmgdI0aJ2W8oqg/phWIYt6mjLJKrDVW1B8r537Sak73GgDS+t10uRy13xqt/q2xZSb000ZGh2Nj7HekDOhUWK9cRmAWtv7VQde8eyo84PHZR25aheXxt4zeh1rfxBUzRvf4LIVvkwufodO2a5PmZLZlwDDrIUkjOfxu7JZfe3TGpE/mEUJZuqnvjglmCHZhnctjzo4yOUaK9O3lNolzS3rth78OhQbpstJGqy/mG9/P2N7GtI9QDd99+tmNHeUpDYUo9rv85g1Uk2U3TOh+AxKly3akj+1ii/uL6SBFNJHvYKuxnuTmlLBXrarguRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SJ2PR11MB7425.namprd11.prod.outlook.com (2603:10b6:a03:4c0::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Tue, 10 Oct
 2023 08:19:37 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::7116:9866:8367:95b4]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::7116:9866:8367:95b4%3]) with mapi id 15.20.6863.032; Tue, 10 Oct 2023
 08:19:37 +0000
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
Subject: RE: [RFC 3/7] iommufd: Add iommufd_device_bind_pasid()
Thread-Topic: [RFC 3/7] iommufd: Add iommufd_device_bind_pasid()
Thread-Index: AQHZ+o3RxhI7HHkgwkmih2zPzlCqT7BCrnxA
Date:   Tue, 10 Oct 2023 08:19:36 +0000
Message-ID: <BN9PR11MB5276BCF486E9E4F24913883E8CCDA@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20231009085123.463179-1-yi.l.liu@intel.com>
 <20231009085123.463179-4-yi.l.liu@intel.com>
In-Reply-To: <20231009085123.463179-4-yi.l.liu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SJ2PR11MB7425:EE_
x-ms-office365-filtering-correlation-id: 30280b16-291d-4f19-574b-08dbc969a463
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SfXIpyVuz0VsH+XKc8q0nN0EUWEMlEd9bGhiftQR/wrHURS1e5RxVHJpmokS+7SGXLq0SZjWC3OETwVb3JV9XJj537gUuuV2DjyZ+LysrgPCg9HYpR0z/ZJGb4hI578gfJtmc0VbqKUcr2kyHUKu3FXze/r0df4cxVcpdYvv798dJIFbFoFsdIbOc3QTf/B7GlsdI7MP04ueGGpEKjn7g+aRM+ApofXdCj14BJ8/5BFUd/damMBUoY/qnY/OLYG/5M3Ds/ncWq2yDgXQVrj0L6JMQwO8oomQM9GLJzvZHwV+Fh4qiMiFYVBKXZ/uWCcdqFFPPAWJ/skyl265Ht5zYptvWoI0uR+Yq1/+UFjb+5VL6UIYM1g9EEqnD5O86ThFwyUIvrBvHCi0m3kSJm0RC+YrMjX3rlCZ1jXlaC2fRD1SCKhdLbkPaboRRPuCm9K/t8G4oFsede2JHexnP2VrZ0CTVDoWvZHVFVm0J0N3OH5Qu97la5eCLyyxzBogoI1VS4LTy4XjVrc7/1ZJU9IjTvjR1bu5zflwBaLJwML9UNegoRK5RMSybBkz2FL9zmsvMppWz6Fg5ndMmTTFK7wkHuQL4IkUnHfN0XgwUGSrfHkwvJ50Z2xG5ASl1Q7a8JQW
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(366004)(346002)(376002)(39860400002)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(55016003)(9686003)(66899024)(83380400001)(5660300002)(26005)(76116006)(66556008)(66476007)(7416002)(66946007)(66446008)(54906003)(110136005)(64756008)(52536014)(71200400001)(7696005)(8676002)(41300700001)(2906002)(478600001)(316002)(6506007)(8936002)(4326008)(33656002)(82960400001)(86362001)(38070700005)(38100700002)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Vu8mq/mUZHUr6yV8BpUJvaqBdf5Xn/w0JV5qH+xwK/4kG74CEk34dYm/bDfz?=
 =?us-ascii?Q?YOeobH67uIm+DVnksZ+RUA1Sp30mV15wKIhG9G9osJG+9IIkYbdEU+QJHEqO?=
 =?us-ascii?Q?Wst42UJU0StuxCDtWKoP93SQ4LmYiRwFxrh/OtFgYAZEFSk3i7XLb/HYuZeB?=
 =?us-ascii?Q?A48KMa05W4fgA6PN8FNP3rLFI63rxlxiunB/woiFvi3ookYLv2iuLKeJYsJM?=
 =?us-ascii?Q?EKWFgRi1LMyLmnoHGOcAZjrCEGq5PRPqr66gDRvX/uCxnW5SvkzrvCDygzOR?=
 =?us-ascii?Q?Ur07XDE5NzOtgENaUUDtF3P4UjaY1zPO6KRlH83xamusoAhRHJ3NCNujhXx6?=
 =?us-ascii?Q?AW/cKhmFVrIEKQpdA5syOmttRrK3NS4/xnOLdqfKIOFuaXb1098rL3galbo+?=
 =?us-ascii?Q?0tcukHHpqqOPfK6mYX4wKIOJACj2yml/K9ZUsFGltS1tnnC7CIUWaOa9y3JG?=
 =?us-ascii?Q?OZLJywrnyQpTv+CUXIfTrVuj6qRUwBZ8I2HSfldvShCQDn0j8YSqcI4B+5su?=
 =?us-ascii?Q?XMzVO7NI89viVjw39fPSjULH6EDyzg0iy+j67BPw9tcP0ScraCNhI6kMy/hj?=
 =?us-ascii?Q?3o6yUTsrXzDGWinSfs37JgT/2mDvnJ/oO9tozt5Ezimh7zRCW3E2JM+XRw3o?=
 =?us-ascii?Q?9+Fb+NHsPstew4XLDzPdiMUN3CucHZcG0XR+c/40YV83cUD8PUnTApPRgTxm?=
 =?us-ascii?Q?AidW+kNK1UgXAlDf4SV9rfDXswtrQXsRySgZk8zuVSyYiAZp4vMAYh/PhlOx?=
 =?us-ascii?Q?M40h/f2pY+gDmqeHGeOZ+ftSdVuxLLlp11z+DQhXxfwdcuyn9UP167q4qtD1?=
 =?us-ascii?Q?nb31gmwD1lj/Jsp9hIrOLurL2h7lSG+QDK3c8Sh7IxKL4/wok+SVyOKbAKAw?=
 =?us-ascii?Q?HJM+UXdNWK50lIFPZM+EjbtzmQiJ0GdohCC1sJqh2CV9J9GfUK8xidV1C/Yf?=
 =?us-ascii?Q?jb4xCNjJwwfE1/C1Gn+Nkc8U1Mb1LKcYv2N5R/TdXTA33sG/XKcWGG1VwLou?=
 =?us-ascii?Q?cKKr19RvLg7hH0/XWH2zMDze31eGKnTjNcThzcUEAYJ2EKBLUT6Xw0jueS6v?=
 =?us-ascii?Q?HlE7K9CMr4t9z0gvX/073qltS+nk1tod7dV1adirQbPJmRk3QflufPO0YrHx?=
 =?us-ascii?Q?ZuwPFSZNw8An419GACTCmKiKL6eRQdIAph9cKQqGxhpYWKn4F4MNv4QZ9Htf?=
 =?us-ascii?Q?cadcnIbxC8LgiMXF1yv+N3MaMz761DaCTpZ79ULBKP6wodq/tgXlcCSgePOa?=
 =?us-ascii?Q?0OqPqfFL7DWeDMecJ+9l5r4RT61C357JggcgJQUg/D9ob6ByOoWlTyleBtft?=
 =?us-ascii?Q?l1F8a9HGXrZq+aal0oU+BkXkTGg3BiwJ//Gl4lHKWqfF3vQ0TNqP8M5Q5NPT?=
 =?us-ascii?Q?crly3xpUJWwfAPd2ONKOGbc6x6Im5vqClXQA7wTGXWspVb373mIZ+qnMAh8w?=
 =?us-ascii?Q?MJ377tBATMTRdL/uwJw7l+ojXKgEJWhhLZKNSohKqpKOIQ99zNHn0PpKHnPO?=
 =?us-ascii?Q?ZZvlLFypMoJeqU3+dGHywpnv/D6QnHpZBAEYkE397qKzfhdDK71MDfZwO3Zt?=
 =?us-ascii?Q?QqXWCagkQY9IsuWOgSlkphCUmRAqtEbC+h7LSqcf?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30280b16-291d-4f19-574b-08dbc969a463
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2023 08:19:36.9549
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yhbAfhf2A8Iz/NwsA1KrsAM6rdfrj69Nk3JNFe+Ebzz9hkA933fsphGRDzjOF8OO0T1djzRxTlqVbxp1caGLNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7425
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
>
> +struct iommufd_device *iommufd_device_bind_pasid(struct iommufd_ctx
> *ictx,
> +						 struct device *dev,
> +						 u32 pasid, u32 *id)
> +{
> +	struct iommufd_device *idev;
> +	int rc;
> +
> +	/*
> +	 * iommufd always sets IOMMU_CACHE because we offer no way for
> userspace
> +	 * to restore cache coherency.
> +	 */
> +	if (!device_iommu_capable(dev, IOMMU_CAP_CACHE_COHERENCY))
> +		return ERR_PTR(-EINVAL);
> +
> +	/*
> +	 * No iommu supports pasid-granular msi message today. Here we
> +	 * just check whether the parent device can do safe interrupts.
> +	 * Isolation between virtual devices within the parent device
> +	 * relies on the parent driver to enforce.
> +	 */
> +	if (!iommufd_selftest_is_mock_dev(dev) &&
> +	    !msi_device_has_isolated_msi(dev)) {
> +		rc =3D iommufd_allow_unsafe_interrupts(dev);
> +		if (rc)
> +			return ERR_PTR(rc);
> +	}
> +

Only MemWr w/o pasid can be interpreted as an interrupt message
then we need msi isolation to protect.

But for SIOV all MemWr's are tagged with a pasid hence can never
trigger an interrupt. From this angle looks this check is unnecessary.
