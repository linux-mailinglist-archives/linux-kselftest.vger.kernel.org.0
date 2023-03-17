Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 576676BE696
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Mar 2023 11:24:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbjCQKYF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 17 Mar 2023 06:24:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230238AbjCQKYC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 17 Mar 2023 06:24:02 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D978E4C59;
        Fri, 17 Mar 2023 03:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679048638; x=1710584638;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=y2TekW9W3HGOU8vLgDJslh0t+i9ak/UAbwwK1u9siYg=;
  b=WynBOIVYur+cYIjuVk622LTdDh4JH7MG0uHy/Z4/EY7vD5ui2lq/J14i
   G2QMYhFw23ZSwoTojEpi8SrY4FyhCwP4bHhFv9ejanFgvr2BdpoFy4Bja
   cnQtUDMAInybVciKkpve0jdmZeTBHEJPfBHHiAyUkXBOa893Bnp2ttnBY
   15NEE7N1rIkn/IzKQ4DBGDgidO4bkNTpUfWJSv7RGrZMszBvU4jtBvDQw
   cf/ON7XCWDV50QNHoGIPLF/FP0AG2pfYMSbkR6p86C6d90UB1q6+nDkb2
   vx3vTYSdz0lsk/xgrJSYu21SQdiI6h4tl6xm9keK1bYkhYmg5zp4oPmS0
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10651"; a="365931519"
X-IronPort-AV: E=Sophos;i="5.98,268,1673942400"; 
   d="scan'208";a="365931519"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2023 03:23:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10651"; a="712704119"
X-IronPort-AV: E=Sophos;i="5.98,268,1673942400"; 
   d="scan'208";a="712704119"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga001.jf.intel.com with ESMTP; 17 Mar 2023 03:23:57 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 17 Mar 2023 03:23:56 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Fri, 17 Mar 2023 03:23:56 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.173)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Fri, 17 Mar 2023 03:23:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IkDmonflp2LKEdz0xRHFsj6JH15fez/AS2NULCgSay2QaLqw7mduOPvgCwLe6G9H9UnxF/dMb/z5Ebo/TqbJQKwRnivkrD6zdEfpVANji3s/AFjvZ6sBBBIoMCmBgwJd9UewQynBi3aMz+MmXfnahT+ls7coE99QvOrYxWBPjD4RAsoAoA82jynwswjwiKBupIJ2NC6l/Ts6mtdVtdfgXGYNLXmFo8PCoLuDEh3jqFEGl3rTHIgbr+KuR1Z0mfjWIUneOOKp2dbTbzM8wYL3gT4c9K0B6cqr/NCmVnRwuzZsPzoi8Edt9r570HfKJVc0aVC8QWKR0WUQ+z0qEqWfyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SI/uFNrnTYQFM+5YAuht5CVXL72yLmFNkbN+D4GO3Gs=;
 b=kE4MEpXYhwLQUk+wGedrOLOxJzlEyZrbYkreE0mz+euygUJIQc86N0zFrqIEwaf0F4Sl9e1SVz44exfJJyoB/tls/3K6jB2xL2TXGotNNu1I1pXgagG1urtYB0+Bq0DV6++FPr5IqQC7EI2PRIRp2+p64NQQxfcO9Uwai2MeZiB3IDvq3s3lzvxdD1oADDvPCStXP25DdE2U2zSYsy5XXxPxiQU5RyCQMhnVpZvWnzmV4HFOczj73PkZ2OTMLKguViPcuHH9zNfrE9TYo8Jn+0F7pHiksBgVAk6fHDU4lVD5uEDQk9oJiXDXr/fLTxqH0s2bRETMVm+2MFSn0oOsBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by IA1PR11MB8150.namprd11.prod.outlook.com (2603:10b6:208:44c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.24; Fri, 17 Mar
 2023 10:23:55 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1aac:b695:f7c5:bcac]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1aac:b695:f7c5:bcac%8]) with mapi id 15.20.6178.035; Fri, 17 Mar 2023
 10:23:54 +0000
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
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Subject: RE: [PATCH 04/12] iommufd: Pass parent hwpt and user_data to
 iommufd_hw_pagetable_alloc()
Thread-Topic: [PATCH 04/12] iommufd: Pass parent hwpt and user_data to
 iommufd_hw_pagetable_alloc()
Thread-Index: AQHZUl5+74r99ujM3k2mVNy7XlBGXK7+0CWQ
Date:   Fri, 17 Mar 2023 10:23:54 +0000
Message-ID: <BN9PR11MB5276815B943E2232F158C0128CBD9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230309080910.607396-1-yi.l.liu@intel.com>
 <20230309080910.607396-5-yi.l.liu@intel.com>
In-Reply-To: <20230309080910.607396-5-yi.l.liu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|IA1PR11MB8150:EE_
x-ms-office365-filtering-correlation-id: 205af8fd-87a8-40cc-799d-08db26d1b617
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ATukMtmqNQ6ORBDTuEdpU+vf3Vpz1/kHJe564/Z/j7VOvKYc6oh0JKpoA2tnmav+3hFcnjY392tkK+G8HgfOMWRxTB0A5pDdP0ndNWegBBpLzeVH+HdnQi/1f+2GClTg6sNYdn9KRiJrjuJQhhgHMxDam6rsTDXQGTPpmnx4h+pjLmxRu+L48i469naI3LuPWu2/6DJEQMonSUIEgKd7HPpm2oNHif5hZvCrQwVWggCXYfj6Xa54jiGYKSGadHyvUDChvjK2hEWTlr67T53eVoX9uPDBgjltT0aNCFYDhZ8O3C5swtxho70KwSZp8VDw+JsaMmlJzfiW+xSko+Gdx2rT2pilY1D1PsCKPazmsv23KZvkVV+4KBPtptXwrpQUGOKr+RW4rjhywcEL3dUEIBFNXmhCGxY2zwW02GbAc3ZFB/AhOilYWEA51XwUOQaWmxNKL50xwkWTcRGeHH0cGJxOveUwGFZqhPMoXGYDXM5+CMLtvHjL+qZ5L0glPDi8xouWPnLN/AIEEdqz7WI5n6PcOYadJbHcgQlMRTKcSNFmMEwP8KgIKYtGa7TrmeXutvpJuzamwBmjn+RMFxvi+9xw3OES7kdRQJry5GEIaWwTB+vAuSmq1rRa4hxJyavziQp7NaG12/B9cKBW0fjLxW46F65pGwDLKtdhs43D3KKKsKdkrj0vZPCEIfmUCROtz2x31TUgzgLK4dvM1T8wzg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(39860400002)(396003)(136003)(366004)(376002)(451199018)(122000001)(82960400001)(186003)(5660300002)(4744005)(7416002)(52536014)(38070700005)(8936002)(66476007)(41300700001)(38100700002)(66946007)(4326008)(76116006)(2906002)(316002)(64756008)(9686003)(54906003)(478600001)(55016003)(110136005)(66446008)(7696005)(86362001)(66556008)(33656002)(8676002)(26005)(71200400001)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?dy968F4mpFpJRCuIpGLOw4xYzQUvxaadqv+GcHg8u9LSbXuRh1qGDtH3KsP+?=
 =?us-ascii?Q?uhklnWLdWv1D5Z/m6HAHtpq7AnNcUA4SYG+88cxw7GYnxy03vYkaggOe9wZL?=
 =?us-ascii?Q?7lekLuhsDcYJT21cAskB6q7feNX9wvFVI1XgLm6hjsCIWG2+nZ6gvgl8pnt7?=
 =?us-ascii?Q?VhY42YhZJYBKp2HrQpf+nqXo8MQ4TeOvh4cytuP9Lv905/syZYhbIgtPwSTs?=
 =?us-ascii?Q?ShV1ko4vuBkVvXI/kB3elW4YnslAgIgE7HPeBoaVF8nysYbvJzjkIs8ozAPe?=
 =?us-ascii?Q?SDcgXm941gO1I0FtCDTpvlQnx8HxON7wy+VfoQSCNR64nGDyDZ1pEzOEcYu6?=
 =?us-ascii?Q?fsxDJTSt+PDeHpVyBo5fXMK+qoJplSE8Bc3+200CNVwiKxniKHJ7rCo2TNJ9?=
 =?us-ascii?Q?Yx6AYzi4lz4xrTr9qeMNqh0cPDTi+WcnaiTjL2MkcJ9AmhGqrUh98TJcnxnz?=
 =?us-ascii?Q?C1S0cRnOE61rgBEb4+fG0u8GtRRrUyZYmqlCnuJUv38ISBfDz/JG8iBune+y?=
 =?us-ascii?Q?Y1ETosl0bZHfGzTR1hwwhVFP4l+6puCrvxcXJcwXKDyjyWozQJJfbyXLuvrP?=
 =?us-ascii?Q?TymyiYO4pQNI0L2Y4LGKHPSRfvz6Qqp/SqXezIG6WEPigiSe7k5dpdKdkIek?=
 =?us-ascii?Q?v6AZH//PJhHEoaiI6VVVOa4LRRzoyFVC2TJYXNUBbRJZ1Tbbo++f+kH7ooQT?=
 =?us-ascii?Q?FyPPVj6bdaVsnvnTbc8SIgpm0Xp42HuNfJd4pyS96tUkQ+qVZF6Lgoy++SR5?=
 =?us-ascii?Q?i7/f1GZogY5khFS3mqEKiKaHsr6LxptTfkQZHKCSeAEDWsFuLwUDIRgBPIgv?=
 =?us-ascii?Q?y6l53HB34zbp3KPTKl8EYB3o8lV6TJghQvvy8RdZcaCCtHcasdQrhbup38Yt?=
 =?us-ascii?Q?okKTFJcF1AclfhzYHUZ7ghfv7DaXqsBQ+FdpSmyL/cJtKyVf4+vEQhutjZKE?=
 =?us-ascii?Q?pnd3NzWOuHlq17Jj8QHK4HvpLogiQae3h1XI1PgApNfLLKe+tRoTClW0HfVp?=
 =?us-ascii?Q?dlS62DWZ/Zv2mvtrlV+FIgiH6RZfvqieHGmJnxLtbc9mxRPLuqSzWNGt8gD+?=
 =?us-ascii?Q?Rm7jrMuPZPubQWM+gkBR94uj4sEYc9D7PFd0orbkFoK6DS//L+EaFR0R+FiJ?=
 =?us-ascii?Q?hfTdv6EhXmlgfzXDEGGjFHpSXajeHfAr3sbX6vfltTP1Uf3FdGo7FG95GDXa?=
 =?us-ascii?Q?8Tg5g3eOujIzPPKIzscCcwzMLkMNBWm+OawU4PxlVUjlStB1V+HNDYQUseo3?=
 =?us-ascii?Q?Kq4V418/6/fPEQTxRu04IVQvN5L2Vc/rF7Oaelog09qopjKKeLQDg5Bkqu2G?=
 =?us-ascii?Q?8aolu9cyjGyyk6Gaq8TYgJ6aXf4FrkBCAwvPnKXcDU5WVQJHXyNGj1y4dJCj?=
 =?us-ascii?Q?/xE5jHKTMavr2Lts+VWapEEezGxxeVgMql17PzjfK9sPGS3p5erfPqQvsACp?=
 =?us-ascii?Q?pe8LvSAWxmZu9CYa9GFAKuGJCiiM3+kBi0YafjROlT2fH4esfWatOfejbil+?=
 =?us-ascii?Q?PevlZpkDWRNXcKQFAglKHfsh3d6D4FEye+oE+jKzPHQAG7lhla4cSI8D9TpJ?=
 =?us-ascii?Q?GYlEMRiLMv8n8i+m8CTG/G45aDNLkrIdW2juIxq0?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 205af8fd-87a8-40cc-799d-08db26d1b617
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2023 10:23:54.7913
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HxMcyj/VCcHL96OaTOK70pkxR/0ZAZ7a7CexuCnq6Z0ap9fTCUpaehiXTRdhy+XICv+luf9Mo/MJkCX1AHUqiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8150
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> From: Liu, Yi L <yi.l.liu@intel.com>
> Sent: Thursday, March 9, 2023 4:09 PM
>=20
> +	/* It must be either NESTED or UNMANAGED, depending on
> parent_domain */
> +	if ((parent_domain && hwpt->domain->type !=3D
> IOMMU_DOMAIN_NESTED) ||
> +	    (!parent_domain && hwpt->domain->type !=3D
> IOMMU_DOMAIN_UNMANAGED))
> +		goto out_abort;
> +

WARN_ON()
