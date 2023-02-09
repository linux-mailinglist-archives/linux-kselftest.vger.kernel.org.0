Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 481AE68FE2F
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Feb 2023 05:03:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232978AbjBIEC6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 8 Feb 2023 23:02:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232918AbjBIEBM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 8 Feb 2023 23:01:12 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 174F72E819;
        Wed,  8 Feb 2023 20:01:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675915266; x=1707451266;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=CvuYadfx4swDbmvyjDyIJPNs4tqwJUnKjW+8chMpGtw=;
  b=jzfl3OentaLXTan8hVlvQqhf98qbyt1sipkqW38Y7YhB9ONuReAAzvI+
   LliJXSfUI8V+iUTp37+sHaJbtpZeHHxB8aRRdPVXvNLDf72rloD3PDpJN
   cYpalS2tUQN7/3cjZvNUoSzF/B59t2LNUdFbDunzXEpnl3d+BHjQDrWj8
   YSocBkK3qAw69MJSU5UEH14FQmpEujUQjsN/uS8uEjm042qobsnAnetNY
   tFbyd0kIuB7FlMB21R5GMVqj17UsY1Gh2a89zK2lL2fKtrrbfBorbOY57
   BvCxBPGLKDdti6c0MlZvYKrBo88M9lSC5o3wqhjNzKNimtV9YqGRgTJ9/
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="357407096"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="357407096"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2023 20:00:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="667492269"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="667492269"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga002.jf.intel.com with ESMTP; 08 Feb 2023 20:00:56 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 8 Feb 2023 20:00:55 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 8 Feb 2023 20:00:55 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 8 Feb 2023 20:00:54 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mc6tmVX2OX/8zZNB9y0AuiE1LOx/jh/4lDQTQHFue+boYmjlRpspOKNJ6GAlWLb5aFK64wGWg9zdtCAJqhhoEh8HWH1ryWEXKn+d3+NyNgDukn/zze2in9Im7A9+TXnT63lIegmveJBwDw1HuJv+RUqEeMHQ35jUMxbLhpq1eZGy0qr0ocy061y93NCT3tTqMk1M5qN53b5BT2SagvgwDhRYIp5ps6zxfoDSR8rkhisglzUhZWb0phbk0ubwVuhv7nwykA2V27wVrWeUh/Go2wEEjkwJfFW0TCauytvEdgz+F/Af58sTLEiEztgNO56qU6lGcqfZldbuWuz5SDJErA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nfaVk8pg8GUFNoM/MZqh9DwlMSX6ChYkbok1ajfdrwg=;
 b=n+2YCWSxz1by7Kw0fCbKpBkOlfHedBz3qcSvcjV/ZL7VMKxnldfHv+bs9dQTcandO9QCgi2aI0B3170vz66s/6GUZNJLkeqNWAd1tdWni+BKDUysWYW0p+Gu+oFW8dXuEC3g8BTsPjniW+XbZzcYfF2WOyWvAKF/MkLiVe+rlLjjhHCKGn6pilPfi3aDTcUvysT05isEJvGLdDGD8dbkpkXNkaNwSUPmuC0FZVopTUr5mPJ6DjIgdCqxSTw0Yp6s+aOS2n0uKBTVaGgS5kD/AWWtHl0ppBXDfb061MPEtOIAU80OwevGv2l4fDuGBPnoTVqEYP8CXXFgX+gfBgnHNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SN7PR11MB7437.namprd11.prod.outlook.com (2603:10b6:806:348::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.17; Thu, 9 Feb
 2023 04:00:53 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6a8d:b95:e1b5:d79d]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6a8d:b95:e1b5:d79d%8]) with mapi id 15.20.6064.034; Thu, 9 Feb 2023
 04:00:52 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Nicolin Chen <nicolinc@nvidia.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "will@kernel.org" <will@kernel.org>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "shuah@kernel.org" <shuah@kernel.org>
CC:     "Liu, Yi L" <yi.l.liu@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>
Subject: RE: [PATCH v2 08/10] iommufd/device: Use iommu_group_replace_domain()
Thread-Topic: [PATCH v2 08/10] iommufd/device: Use
 iommu_group_replace_domain()
Thread-Index: AQHZOzoV+UAbwLQwnEuO17sJd5b+0K7F+Nzg
Date:   Thu, 9 Feb 2023 04:00:52 +0000
Message-ID: <BN9PR11MB5276C1807B710CAD3E5820D78CD99@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1675802050.git.nicolinc@nvidia.com>
 <4653f009c3dacae8ebf3a4865aaa944aa9c7cc7e.1675802050.git.nicolinc@nvidia.com>
In-Reply-To: <4653f009c3dacae8ebf3a4865aaa944aa9c7cc7e.1675802050.git.nicolinc@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SN7PR11MB7437:EE_
x-ms-office365-filtering-correlation-id: 4677f5da-c290-44e7-4976-08db0a523cbe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: M+8M6mLSKCSfzc83s4LJQ9Z9hqalAAcZF6ZOLrAlSkrcIcxWcL9yeWJEUEZ9kRov0I2b9gtJZ3UKOZusqZq1Cqr1v1qWGbDSxyuI7d6Zc2he+BeSqRrsf4p8mQhqCSv34aHc1CqvopFSs8sNQhEVr7OSoofV/fUGJW/JFtVS2HprSCCapXL7UMtdkIFovzDM6iJtt/jdusCCLSjNjXqh+5LvDMeotbsIB2AjCYNBtiqijx3oNMyDJetvTLwg9KxpFgYuuLWFCCw/7ZkJ1Z3Sud2ZvcRf7PsZagL90bV1eJg2SO+wSuBWY/WAm6liSPN/QynoSGko4jnbxODEsbu8HlCyct8emXh4OCIP3+esQQU83nZVuBNL7wvpK4bYTB01cRLJPqdHBGF79zEg/ULcJXrjCSVz+JXyKeHTsXuhTSPkOPxUc6o+RgigMIaEgxnwtALeYfyHhf3CP8nVYBlxXOKCfRoYhR5ll+D2WyJ69A66JVQ/jvszNH23KZHRoReZeDFljx0jzkUb/9vY99zuZJtEyGCvVXQm35iQpFLEt5qFBjpG/yIDSHLuHvaHKs2M3mo3/ePMingCHYkVSvp9BNMwLECvWtBj9a397z4K0PLuhZ/uW0lVclz7U9/nIMrDuDYA6CaCIOGZ9Mf1/6LAvbO1xrLioGikh0jPr1ZINemv3eYTv71PO5PWegRql6lnP2ITDDgTlBK4nd+XOrVw0A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(346002)(366004)(376002)(396003)(39860400002)(451199018)(83380400001)(55016003)(54906003)(2906002)(316002)(76116006)(110136005)(38070700005)(478600001)(38100700002)(82960400001)(71200400001)(122000001)(66556008)(41300700001)(66946007)(4326008)(52536014)(6506007)(8676002)(8936002)(5660300002)(26005)(7416002)(64756008)(86362001)(33656002)(66446008)(9686003)(186003)(7696005)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?m+vNmmdPtfC6rt/j9ncFQtW0sz5czAMMzUUXeH0j0Kn82gINKYHRdy3s4Q4f?=
 =?us-ascii?Q?l7/lT9klzVr7uNfGbevOCQ2dUFhrdu40zCfnKzDhMgLaYY2ApzKcgOzxyJh/?=
 =?us-ascii?Q?WCS1w4+bAkoDMOT4WNm2jZzLKOfje29UjGdVeIqKRkwK4rHae3mDOXYRKlKa?=
 =?us-ascii?Q?QGe5SsqbQPDMtQy5MNu/TgY7umxQk0G+e65WgXHs2ozVQ2TTL7uwUVg8luRV?=
 =?us-ascii?Q?21dm3ImzGdr9gOfF7O8mZetu8+nWnRO+/FmSHo+fxVpi69qkMGkfrC4F+pv9?=
 =?us-ascii?Q?va9vw9keRTuHeW2gwZHyOyC/YjkHX+OiHPwNw5dF+5OUp3V1wUsxSsbGVZe4?=
 =?us-ascii?Q?UJhsu7rzY1cfmV8ziR7xuZGf79IwnGwwcfliwn++K9Qcr9MbmybnZhUqXbjy?=
 =?us-ascii?Q?XmORnwzzRTe9iJgeUXyGODfJpgfe6sAV2/lYwrWsjYWEwkTyI+6RoLo+nNks?=
 =?us-ascii?Q?cVrQh1AlUigshfjB8J9DI9ksgruwsSt2kUdK8W0/EbiiuatqbhSoROFSBpYM?=
 =?us-ascii?Q?4aP6tn7PKS4SQrgkHwXMgZb2N23hdBvsa4pzvHgzk6DQpHsQZMpxf7C5jcZS?=
 =?us-ascii?Q?WMks2gtLnQLbQth5nHkYDkHhmJEBEzb3F8QCnu0gOUsyWklKPR3GbkRWGuTU?=
 =?us-ascii?Q?wC+l9mKVNw25RHzHWJykmcM7M2fZ+CajcIJ9QgjlJmTVO2VGD1mfqfelUsm6?=
 =?us-ascii?Q?9Pn55PnOmi4w5hMrjO3IFqMSA8Zbs+rZ9XDHCdkJoeMmh/NlHT/njNSy4PXp?=
 =?us-ascii?Q?1KVclz3oKyVkcqQr4uo+k0ccGZkJiBrIIGCl0YO6U8jTDntYUZTxsTtC6oao?=
 =?us-ascii?Q?jRc2wNUIqVwO4HWZZ6VY9Uh5QTNMr9FgR9gZ6/7zWGgbVXS+Vtw+uB7KalOd?=
 =?us-ascii?Q?2kBM8yHHmpA6dGhYw5vX7V+DOLC7GEIvPgRDwWZMVl0jZuTR6KcUef4Dvaj8?=
 =?us-ascii?Q?DTRsB2WPolzsr+EM2SESfQLO0FrmjkVjPvAV2GFAdeHuqJlNumWGQN+ik1cB?=
 =?us-ascii?Q?Dy1UCz7zbxCwH6gfH3K5VPL8OCTd8Xq+i9N6q7DrrKvY5aNERye+L7J1xRGU?=
 =?us-ascii?Q?W61lCpAtIG4vOx5pGU03bneD4Epq9g56p177cp/k9fLFILGsgPMkEw5fyXwp?=
 =?us-ascii?Q?g6NsXUNGfdrL6Di5AgB5Xf601GtPzpUQh72OvHZ+1SH+ed3B6B/GHHCVkXrs?=
 =?us-ascii?Q?TTjxSVO64aM/tm6Dvkdq3C4gGg26x+ve1vMgg0DPvH0wnCRXlbXjXxRy3E3I?=
 =?us-ascii?Q?6g0fYwtfHK79pc+jzJ6rKYyxiOMBZaOqci6Raf6MPMCH6Jn73nP+G9q2qGwV?=
 =?us-ascii?Q?4C6eGGrfwbUZYkFbPC//AWwRJgUvTMFD0COKnwrcMmyHz0catCX62UAJSoxy?=
 =?us-ascii?Q?vnHQ9NttQKjAzSf55TrBi5PDZlymGisuv30lgugU7wdXUuCfahxy6E3pEl1B?=
 =?us-ascii?Q?maD8Y04FrKrcNCIWdK0TUx0/opm+Dm3+/OnaFbapImNv/M0mglmAmrv603yz?=
 =?us-ascii?Q?9druF9fMs+DmL2Q6w5kifMpIRo8Nbgx1CloIe/JqAx01XLMz1myng9ED5434?=
 =?us-ascii?Q?HLT5MhmmQ6qaEsN8JGwdJWJjQGcukkcexp5iSFUj?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4677f5da-c290-44e7-4976-08db0a523cbe
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2023 04:00:52.5288
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AkKrMifcskQCogfBDtYRlbfm3s+Ub1L66zNaePWfRijYpIb8s9KMUzH81AY/HoxvBwq6SNjpWzp/BjFap/bbjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7437
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Wednesday, February 8, 2023 5:18 AM
>=20
> iommu_group_replace_domain() is introduced to support use cases where
> an
> iommu_group can be attached to a new domain without getting detached
> from
> the old one. This replacement feature will be useful, for cases such as:
> 1) vPASID mode, when a guest wants to replace a single pasid (PASID=3D0)
>    table with a larger table (PASID=3DN)
> 2) Nesting mode, when switching the attaching device from an S2 domain
>    to an S1 domain, or when switching between relevant S1 domains.
> as it allows these cases to switch seamlessly without a DMA disruption.
>=20
> So, call iommu_group_replace_domain() in the iommufd_device_do_attach().
> And add a __iommmufd_device_detach helper to allow the replace routine
> to
> do a partial detach on the current hwpt that's being replaced. Though the
> updated locking logic is overcomplicated, it will be eased, once those
> iopt_table_add/remove_ioas and list_add/del calls are moved to hwpt's
> allocation/destroy() functions in the coming nesting series, as that'll
> depend on a new ->domain_alloc_user op in the iommu core.

then why not moving those changes into this series to make it simple?

>=20
> Also, block replace operations that are from/to auto_domains, i.e. only
> user-allocated hw_pagetables can be replaced or replaced with.

where does this restriction come from? iommu_group_replace_domain()
can switch between any two UNMANAGED domains. What is the extra
problem in iommufd to support from/to auto domains?

>=20
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  drivers/iommu/iommufd/device.c          | 101 +++++++++++++++++-------
>  drivers/iommu/iommufd/iommufd_private.h |   2 +
>  2 files changed, 76 insertions(+), 27 deletions(-)
>=20
> diff --git a/drivers/iommu/iommufd/device.c
> b/drivers/iommu/iommufd/device.c
> index b8c3e3baccb5..8a9834fc129a 100644
> --- a/drivers/iommu/iommufd/device.c
> +++ b/drivers/iommu/iommufd/device.c
> @@ -9,6 +9,8 @@
>  #include "io_pagetable.h"
>  #include "iommufd_private.h"
>=20
> +MODULE_IMPORT_NS(IOMMUFD_INTERNAL);
> +
>  static bool allow_unsafe_interrupts;
>  module_param(allow_unsafe_interrupts, bool, S_IRUGO | S_IWUSR);
>  MODULE_PARM_DESC(
> @@ -194,9 +196,61 @@ static bool
> iommufd_hw_pagetable_has_group(struct iommufd_hw_pagetable *hwpt,
>  	return false;
>  }
>=20
> +/**
> + * __iommmufd_device_detach - Detach a device from idev->hwpt to
> new_hwpt

'from ... to ...' means a replace semantics. then this should be called
iommufd_device_replace_hwpt().

> + * @idev: device to detach
> + * @new_hwpt: new hw_pagetable to attach (pass in NULL for a simple
> detach)
> + * @detach_group: flag to call iommu_detach_group
> + *
> + * This is a cleanup helper shared by the replace and detach routines.
> Comparing
> + * to a detach routine, a replace routine only needs a partial detach
> procedure:
> + * it does not need the iommu_detach_group(); it will attach the device =
to a
> new
> + * hw_pagetable after a partial detach from the currently attached
> hw_pagetable,
> + * so certain steps can be skipped if two hw_pagetables have the same IO=
AS.
> + */
> +static void __iommmufd_device_detach(struct iommufd_device *idev,
> +				     struct iommufd_hw_pagetable
> *new_hwpt,
> +				     bool detach_group)
> +{
> +	struct iommufd_hw_pagetable *hwpt =3D idev->hwpt;
> +	struct iommufd_ioas *new_ioas =3D NULL;
> +
> +	if (new_hwpt)
> +		new_ioas =3D new_hwpt->ioas;
> +
> +	mutex_lock(&hwpt->devices_lock);
> +	list_del(&idev->devices_item);
> +	if (hwpt->ioas !=3D new_ioas)
> +		mutex_lock(&hwpt->ioas->mutex);

I think new_ioas->mutext was meant here.

> +	if (!iommufd_hw_pagetable_has_group(hwpt, idev->group)) {
> +		if (list_empty(&hwpt->devices)) {
> +			iopt_table_remove_domain(&hwpt->ioas->iopt,
> +						 hwpt->domain);
> +			list_del(&hwpt->hwpt_item);
> +		}

I'm not sure how this can be fully shared between detach and replace.
Here some work e.g. above needs to be done before calling
iommu_group_replace_domain() while others can be done afterwards.
