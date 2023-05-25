Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB9737102EB
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 May 2023 04:30:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229489AbjEYCaj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 24 May 2023 22:30:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233576AbjEYCag (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 24 May 2023 22:30:36 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52B0F189;
        Wed, 24 May 2023 19:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684981835; x=1716517835;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=GwGKzAaubtZd74qRHVt7bC8iEmOkTw7gy+yWes+SSdo=;
  b=VIru/iogbraGjopUolUgaE/e9DAWo057tLPzXa6fxnU3rszdGiS50VNN
   fwOsl8fADOEiPt5lP3nm+PjtF5YvMmwIuQelg4iJdJmcyj9qH5JOWbPb8
   YVt881YcTZ8uEtIkNXvIP2dsMVcRFnTaPa0+XPNR2p35L1TX6HT9gREKY
   JhF8MnmEQ2BIfQTpQWjqVeDaLv69888MK9e7t1IY0R5cdED9o4eX1bnkA
   +H8IUcl3AjYMnzDldDs21uAy3sEdox2lxeflGBkEduk/z0pRnFLzrGIFr
   EXieoKDgPkgrmjlE5BkmD4SBTX2dCXTc5aEpwg+R5+277PPfaWxhQVHCs
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10720"; a="352599013"
X-IronPort-AV: E=Sophos;i="6.00,190,1681196400"; 
   d="scan'208";a="352599013"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2023 19:28:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10720"; a="655028716"
X-IronPort-AV: E=Sophos;i="6.00,190,1681196400"; 
   d="scan'208";a="655028716"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga003.jf.intel.com with ESMTP; 24 May 2023 19:28:25 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 24 May 2023 19:28:25 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 24 May 2023 19:28:24 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Wed, 24 May 2023 19:28:24 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.49) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Wed, 24 May 2023 19:28:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f1HUFxW0fGdp4y5YGeuWSt7eFWx2QEp15LBVL6GU7cYTtA/kV6GFeiBMjyGPHUnN2qBExtYXb0L7XANbAEig6q6gEh0/W6XEVIT7NGXDdOqqSr8Jg5cDXkyGmWFo5gME2ITPdFtFKfU7EZ8rE72Z4jzvXAxPlmnS1F5qsvToIyYk5dRd8ojLsCUGbIyJ1kFmesTVCiV+SuZBM4k6DUwqBc6u61VQDqzbGZje/LgNnAxShcR9Jw/rRP/0bqLgVB84OWv7ejZfZ7PyqGOZ5NDo1D4vYzU2geyqdXOXk1aErEf9mViTH61nc91dl8KHE+qDXxYdorRLbaBEp+rpkal5kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6yZ9tO/KQFhGCm81wY3fr8WeI3S0VSxWqPX6A57hRM0=;
 b=AWECLK3dpx0bVkmkOr9kceymYG5EuzIdk0NIe4NKMvpq6627KtCYUq0fCHZBGAJ5JfgdJQY5V9cf+sG8sZkji4/D3E9v9w6zhuCHRznKcrz5OaaSqjBAvH1ltrH+9PKnMiiM1kCagI1M4zQVsBghoTssxdi+TLXnD8pekCJvJuDfKIo2TbkF4rJBrb+P4c+aWvZUbTcqe/7ohlglx+/mbxNot3hFJZtO/8xDfs69hqi0kVT746tqGQ1bZFFKR/MAwlhnQiFo8m8gwmO4LTLNB7hAzHiQbqp1JJm/ZvmmGqovxEZoviAU33Y5J+h/YCqWxWyP5JxNA3zEp6udPw0FkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW5PR11MB5881.namprd11.prod.outlook.com (2603:10b6:303:19d::14)
 by PH0PR11MB4902.namprd11.prod.outlook.com (2603:10b6:510:37::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.16; Thu, 25 May
 2023 02:28:18 +0000
Received: from MW5PR11MB5881.namprd11.prod.outlook.com
 ([fe80::a284:d072:336c:f233]) by MW5PR11MB5881.namprd11.prod.outlook.com
 ([fe80::a284:d072:336c:f233%4]) with mapi id 15.20.6433.015; Thu, 25 May 2023
 02:28:18 +0000
From:   "Zhang, Tina" <tina.zhang@intel.com>
To:     "Liu, Yi L" <yi.l.liu@intel.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
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
Subject: RE: [PATCH v3 01/10] iommufd: Add data structure for Intel VT-d
 stage-1 domain allocation
Thread-Topic: [PATCH v3 01/10] iommufd: Add data structure for Intel VT-d
 stage-1 domain allocation
Thread-Index: AQHZhBgUs9pDDOk/NEG33iLtnrQuO69qVPJA
Date:   Thu, 25 May 2023 02:28:18 +0000
Message-ID: <MW5PR11MB5881B1B7C7B14F776F0FD3F489469@MW5PR11MB5881.namprd11.prod.outlook.com>
References: <20230511145110.27707-1-yi.l.liu@intel.com>
 <20230511145110.27707-2-yi.l.liu@intel.com>
In-Reply-To: <20230511145110.27707-2-yi.l.liu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR11MB5881:EE_|PH0PR11MB4902:EE_
x-ms-office365-filtering-correlation-id: d252629c-26dd-4451-049f-08db5cc7b368
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /kaAAgozRj5f6OuO5h9ki/PKo7gBVafxeA2x/Z+l+jKXnDZe3zJmLRC6u0bO3VTYHPTC5edpUm3o02CSQjJTBzYs++LcCE+745UITx9iRx7L8AyJtcXjeRrAFMZEzTK2UVFw9GiDjCgnlaXgUpw1AgPY2RWkdQJdVtugbvnQPraBa5QBo1wm5OUlezK1RY5Ekme1IqVxsysK4BwqXEItnJWCHPInT25J5ZmatdK46a1XDlJ191UvGfqL7mo49XlOPfeVhYIsO/Bdx4qKnVawSNaDd/goh8c48J+82pYiY7KCnka5p0qGCquKFexZniwtERmsk8GCDeErn/H248Cj6lvpNWUz1wtOgAA1ArKh4EqfK6zRA8HgcS/3ZDsXaWRmpURTIRWU4P/4krotFkFGM1nXyMlpba2GIxzn1Rrdanv84MFu6hIStDYwklEbbZcqXJh3z6iC/qExcfTK5W8rri2wF8JRVtCr017bF9ANdf6c2V1SE8vUOC1uapjp2uSivpigQMdByVOJme6g32gLXULw0MPa9iykTQmuWtrH4+2yv8HqFQ5L7grp7PQ/oam57mmIop2ZRvj4Kq8fNdKvdVQt4r7jBJIkFLmD1XSOfpPTrwnFUrXn53uN3MPUHFM0
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5881.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(136003)(39860400002)(376002)(396003)(366004)(451199021)(71200400001)(7696005)(41300700001)(7416002)(26005)(53546011)(9686003)(6506007)(8936002)(8676002)(52536014)(38100700002)(5660300002)(83380400001)(38070700005)(2906002)(186003)(33656002)(86362001)(55016003)(122000001)(82960400001)(4326008)(64756008)(76116006)(66946007)(66446008)(66476007)(66556008)(54906003)(478600001)(110136005)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?s90osqtwNFwE8RE4WKEIN1HL4nrAaPZMAUZFDPEXfp7H9697xGv3FErtodEA?=
 =?us-ascii?Q?Q0HsE1xqLj7f+1FMnN3nVAtVCs2BhTzQzD6HRxL+9PPakxXWN5ZJ83+zeDUa?=
 =?us-ascii?Q?k3DbGPBV6nabPJ2dVt9VuJACj3zY+sD7uJFIwCMM2m+GawqqQKwqHuQ4Rn+A?=
 =?us-ascii?Q?QuRB5X6y0Sf6yin9Yyp/WthDzlnfdFNpRYYVFgRrV1DxCdHUtCEc8U9tcC/e?=
 =?us-ascii?Q?lGfg2ZGHZLDuSmsvcTOpeTIiAyU9wsgpSlDDv9C2YkMLC6Aeg87+9AgvpYZK?=
 =?us-ascii?Q?/mI8GGWPoRpGkGW5BoBkcMqma4Ghecihp0E/trWY9P1IOkNxHy6od2xttYY2?=
 =?us-ascii?Q?ufFZgxr/pgZNIwswbWZZxzUN1gPdT766iQlYUPYYu+wKoztxGE550fZua26u?=
 =?us-ascii?Q?tw/fXrqwAwbBkU5ZlO2l1gCDSOsFTOAD0KBVjYrEmz2cXRWdkwB7rVbtfrQv?=
 =?us-ascii?Q?5cG/WXTatoxdOPbgvAjvLkiC6bOTiEPtbpqB71nH1tfNIJg96UbhAbCUIvyC?=
 =?us-ascii?Q?I+VmFto7MGEVdKqJu7LMKa35Upi8jMOOLQYQFXr245BmWqQp0SHWOQ6iLtt1?=
 =?us-ascii?Q?8LphvI9/n+rggQRz6p1RCebYfoUI1nRWbgvPV2jXM/ZCycZoo1Q3Q8lSzeOK?=
 =?us-ascii?Q?NByO7/NnyxeLoch0c07Ay9MScB7bOX03jQZCilokJ2D/2/975YPbKUzrdA7f?=
 =?us-ascii?Q?w0Cwq2J/TFJyyfqzDvtezp8haM6S0qmocADqkrq09L8UCiiYWcxQaidH92MH?=
 =?us-ascii?Q?tY6+0+qr3TPB/KmY+WU8otBH8hOATuneSM+NxDPHlN9m+mG7YflppGtXcl04?=
 =?us-ascii?Q?pS0mbJuT6CJe0xuGu9c5ImFd51d9inhNlM8aKAknKKMkWXgvZN48cYkwUpXt?=
 =?us-ascii?Q?i5cw54ZJlO7M9IbEd4bmu779FKhdYXJSnHr4F2Cv01uBVnKXcjBEHM/R2Wf3?=
 =?us-ascii?Q?EZxVAZmV6j+nq0ig2d682ClQl8ihCLqtQdtryL1kWO6FkU4m/yLdO+5qQYG0?=
 =?us-ascii?Q?q91XNvE7bR0/wkLKPk+214zH/zlPiv+BZKvUtpMyRX5CwwrjUXlsbfNs3jbu?=
 =?us-ascii?Q?ptcx6ijMShKLcRgP1ha2pisOad+jSh6iSwpVEENlzvghbr7SDKawYxUqSEmE?=
 =?us-ascii?Q?jRoSmFT+09V3lXu1COHFk6P5yRQzebrCCN302a/HUJvDAmzPIx/6lUvjeNjj?=
 =?us-ascii?Q?aqiZfB4dh5CGrFpLmcxoOQdsS9WSxO3Joh6ld9qJaFcfmYJD5nRYZETLUOE+?=
 =?us-ascii?Q?H8LFR1NIFySHHZCk2ySDf1PKDLrlF5Nqtot6+PrE7eCl6ga6WuNXTtxsTMW8?=
 =?us-ascii?Q?+J1FHgmu1RitpNyoGPNV8CZZi/yPA431WohFp0H/uwjkLZoSfbA45N2w5Tcy?=
 =?us-ascii?Q?5U9utlqn1EwTmTuUY+d79tyH2dT2kKRh3cvkFvhXFQZmlM010i/jBNm1WMzi?=
 =?us-ascii?Q?V2Hg8PW0PM6moCmY8DTKmN6qZdhvnn2mSso5ouoXjQ/I/KkBrAH1BvdR+EoH?=
 =?us-ascii?Q?mbwaM/8XMaa6KEshW9lYlPxSg1Wak3m5dpM64cpbQSCGok+9tVX5RTF8vR43?=
 =?us-ascii?Q?nNOSljASl8iGKTT7EtLY4pbdotAqdk33HYPD1+Ax?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5881.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d252629c-26dd-4451-049f-08db5cc7b368
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2023 02:28:18.0755
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5NqqhwNuNLIwVBT5aCEmQHJtGDSxtKdOpP9eFgJL8yMODbnRtXdSf0djuFdjGgETZmc6l0t6DoKSHV6lTr1qUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4902
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi,

> -----Original Message-----
> From: Yi Liu <yi.l.liu@intel.com>
> Sent: Thursday, May 11, 2023 10:51 PM
> To: joro@8bytes.org; alex.williamson@redhat.com; jgg@nvidia.com; Tian,
> Kevin <kevin.tian@intel.com>; robin.murphy@arm.com;
> baolu.lu@linux.intel.com
> Cc: cohuck@redhat.com; eric.auger@redhat.com; nicolinc@nvidia.com;
> kvm@vger.kernel.org; mjrosato@linux.ibm.com;
> chao.p.peng@linux.intel.com; Liu, Yi L <yi.l.liu@intel.com>;
> yi.y.sun@linux.intel.com; peterx@redhat.com; jasowang@redhat.com;
> shameerali.kolothum.thodi@huawei.com; lulu@redhat.com;
> suravee.suthikulpanit@amd.com; iommu@lists.linux.dev; linux-
> kernel@vger.kernel.org; linux-kselftest@vger.kernel.org; Duan, Zhenzhong
> <zhenzhong.duan@intel.com>
> Subject: [PATCH v3 01/10] iommufd: Add data structure for Intel VT-d stag=
e-1
> domain allocation
>=20
> This adds IOMMU_HWPT_TYPE_VTD_S1 for stage-1 hw_pagetable of Intel VT-
> d and the corressponding data structure for userspace specified parameter
> for the domain allocation.
>=20
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> ---
>  include/uapi/linux/iommufd.h | 57
> ++++++++++++++++++++++++++++++++++++
>  1 file changed, 57 insertions(+)
>=20
> diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
> index 06dcad6ab082..c2658394827a 100644
> --- a/include/uapi/linux/iommufd.h
> +++ b/include/uapi/linux/iommufd.h
> @@ -353,9 +353,64 @@ struct iommu_vfio_ioas {
>  /**
>   * enum iommu_hwpt_type - IOMMU HWPT Type
>   * @IOMMU_HWPT_TYPE_DEFAULT: default
> + * @IOMMU_HWPT_TYPE_VTD_S1: Intel VT-d stage-1 page table
>   */
>  enum iommu_hwpt_type {
>  	IOMMU_HWPT_TYPE_DEFAULT,
> +	IOMMU_HWPT_TYPE_VTD_S1,
> +};
> +
> +/**
> + * enum iommu_hwpt_intel_vtd_flags - Intel VT-d stage-1 page
> + *				     table entry attributes
> + * @IOMMU_VTD_PGTBL_SRE: Supervisor request
> + * @IOMMU_VTD_PGTBL_EAFE: Extended access enable
> + * @IOMMU_VTD_PGTBL_PCD: Page-level cache disable
> + * @IOMMU_VTD_PGTBL_PWT: Page-level write through
> + * @IOMMU_VTD_PGTBL_EMTE: Extended mem type enable
> + * @IOMMU_VTD_PGTBL_CD: PASID-level cache disable
> + * @IOMMU_VTD_PGTBL_WPE: Write protect enable  */ enum
> +iommu_hwpt_intel_vtd_flags {
> +	IOMMU_VTD_PGTBL_SRE =3D 1 << 0,
> +	IOMMU_VTD_PGTBL_EAFE =3D 1 << 1,
> +	IOMMU_VTD_PGTBL_PCD =3D 1 << 2,
> +	IOMMU_VTD_PGTBL_PWT =3D 1 << 3,
> +	IOMMU_VTD_PGTBL_EMTE =3D 1 << 4,
> +	IOMMU_VTD_PGTBL_CD =3D 1 << 5,
> +	IOMMU_VTD_PGTBL_WPE =3D 1 << 6,
> +	IOMMU_VTD_PGTBL_LAST =3D 1 << 7,
> +};
> +
> +/**
> + * struct iommu_hwpt_intel_vtd - Intel VT-d specific user-managed
> + *                               stage-1 page table info
> + * @flags: Combination of enum iommu_hwpt_intel_vtd_flags
> + * @pgtbl_addr: The base address of the user-managed stage-1 page table.
> + * @pat: Page attribute table data to compute effective memory type
> + * @emt: Extended memory type
> + * @addr_width: The address width of the untranslated addresses that are
> + *              subjected to the user-managed stage-1 page table.
> + * @__reserved: Must be 0
> + *
> + * The Intel VT-d specific data for creating hw_pagetable to represent
> + * the user-managed stage-1 page table that is used in nested translatio=
n.
> + *
> + * In nested translation, the stage-1 page table locates in the address
> + * space that defined by the corresponding stage-2 page table. Hence
> +the
> + * stage-1 page table base address value should not be higher than the
> + * maximum untranslated address of stage-2 page table.
> + *
> + * The paging level of the stage-1 page table should be compatible with
> + * the hardware iommu. Otherwise, the allocation would be failed.
> + */
> +struct iommu_hwpt_intel_vtd {
> +	__u64 flags;
> +	__u64 pgtbl_addr;
> +	__u32 pat;
> +	__u32 emt;
Do we need the emt field as part of the stage-1 page table info? IIUC, acco=
rding to vt-d spec, the emt field is in stage-2 page table entries. Since i=
n nested mode we only expose stage-1 page table to guest vt-d driver, I'm c=
urious how does guest vt-d driver populate this EMT?

Thanks
-Tina
> +	__u32 addr_width;
> +	__u32 __reserved;
>  };
>=20
>  /**
> @@ -391,6 +446,8 @@ enum iommu_hwpt_type {
>   * +------------------------------+-------------------------------------=
+-----------+
>   * | IOMMU_HWPT_TYPE_DEFAULT      |               N/A                   =
|    IOAS   |
>   * +------------------------------+-------------------------------------=
+-----------+
> + * | IOMMU_HWPT_TYPE_VTD_S1       |      struct iommu_hwpt_intel_vtd    =
|
> HWPT   |
> + *
> + +------------------------------+-------------------------------------+
> + -----------+
>   */
>  struct iommu_hwpt_alloc {
>  	__u32 size;
> --
> 2.34.1
>=20

