Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80D0D76C73E
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Aug 2023 09:43:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233265AbjHBHnn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 2 Aug 2023 03:43:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233721AbjHBHnI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 2 Aug 2023 03:43:08 -0400
Received: from mgamail.intel.com (unknown [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9469949E0;
        Wed,  2 Aug 2023 00:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690962074; x=1722498074;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=61qqszoerukUUD2N9E/nHWZH6DjfxDTSCR6GyZSjXIM=;
  b=TRWkSfEdt8BUR5oDuKkVdtAJlpIPQIFipb33YZhI76L36v1y7Zm0iC/J
   k6Y6P/DL9uF5DKCwJWSr9HblGatVqNLbravnHwFt3ItwJFQQ2hLXQlNjO
   gcFf/rz/lVaF/walrjbpoHgHqucwx9//6lJkOeZhFDrOGYIIsCrDJfBuO
   MbR771UrBWhP7FBHDqOQHOLQB1Ra3YGK5A/qItd3kxfXzuPS4xrkhKlsy
   8a7wbuLrlMzpcGiPqA5Cd4nCNKEPfIdF7UokBkSG4hHAX4a1BDe2R9E2Q
   lkm+qGKa0jKJ0vUexM6t57JeyRl7D1222f9Q5TZSqZaDJ5bfM99QVydWI
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="400452619"
X-IronPort-AV: E=Sophos;i="6.01,248,1684825200"; 
   d="scan'208";a="400452619"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2023 00:41:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="852784125"
X-IronPort-AV: E=Sophos;i="6.01,248,1684825200"; 
   d="scan'208";a="852784125"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga004.jf.intel.com with ESMTP; 02 Aug 2023 00:41:13 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 2 Aug 2023 00:41:13 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 2 Aug 2023 00:41:13 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.46) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 2 Aug 2023 00:41:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=deW20q8ISyCiYX+rkuRPNiOe+JFQ3gRPDPIL1u3D7goBPnUISWrx80IJQohMU2OfwFHzec8Wcj6XLilmPdSzVqx/wuITRTh0nFpd2tZf4u45v4jbKAVgw8Zqq9nzwj//YUi3wE2ZlEPqm+q6I28zvhgR5IF4d0zl3cnPglNyaGGb9lxpIlFBVmpZBYy7iZsxGMhPcIBKOTMf4EoLAI8LcPfbBJfbjnWf6G8YfSK3Zx0vMOo57/k9fUTueF3+eecTMQ+QKVICAnXtRm4wpenRmSDDw8NyNPpsuJqlyN7NwkYe4dJ6Y2UxWMccokzyB1mXCrwpI5R/aeJFARAyPoGKiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sJxeVh+Gq4slBgBeKSOzxjrag+YaWUtjTnsj+sPAWK4=;
 b=nQm55Pj80fCbQRe2aL4BiiFmIlGqS0FmJFeBW482XOmYnehIZHGCAv9Ltei74ee3iSUf9x/E6Pyo23XNKVhyDq0Ezt9uDc0ZK1vtjihlzS7dO4rjiwJTXpNmbAKw2JZPQu1aK+4f5VcYqDFwAN296/zbx6sC/+1p6cylkzP4jVhrrjWKH4vZVnSGIYXGzT4w4+azNwXjkbnRKwBF3MBZBNgRENEAdEtFgoStNGx84j/CASswnP6tcZQqZqF01S5vU4tiMg+yxUEBIq5CJra2SAJv0aTUj51U/fEY1WlAo2irqqsQjowQzy83y9RtJ9f+WMMq9GAI85fotJvoAErLdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by CH3PR11MB8433.namprd11.prod.outlook.com (2603:10b6:610:168::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45; Wed, 2 Aug
 2023 07:41:11 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::dcf3:7bac:d274:7bed]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::dcf3:7bac:d274:7bed%4]) with mapi id 15.20.6631.045; Wed, 2 Aug 2023
 07:41:05 +0000
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
Subject: RE: [PATCH v4 07/12] iommufd: Add data structure for Intel VT-d
 stage-1 cache invalidation
Thread-Topic: [PATCH v4 07/12] iommufd: Add data structure for Intel VT-d
 stage-1 cache invalidation
Thread-Index: AQHZvh/vvq7opaI5PkGCKntULu5FEK/WqARw
Date:   Wed, 2 Aug 2023 07:41:05 +0000
Message-ID: <BN9PR11MB52763681308D7950A51E18438C0BA@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230724111335.107427-1-yi.l.liu@intel.com>
 <20230724111335.107427-8-yi.l.liu@intel.com>
In-Reply-To: <20230724111335.107427-8-yi.l.liu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|CH3PR11MB8433:EE_
x-ms-office365-filtering-correlation-id: 6281059e-c681-4991-367a-08db932bd424
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jYZiplBCfY6AER730fy7SMkPMbQe325YnXhCw2+cJV/2UFEaogvsJyOhazEaWeV0FJEue0jFkF9iGSSClT6DQkWW/GmDfFwTaHweip/8CubHvXq9vg4R2eZ2dpLqZQdR5h+AQckr7VY702I0yXFufF68l5XWBNDhKhdzOsDJhg4vtXOr+ekgLipEVInjGMJggWignp7hWvJQlj+f0za+cU1EGqvF1EnrytyAeT+BNe4rChO5HEmK/XadqlPX+QGsjeC0BuLWxSJst3Ova552akYyu1PWnhptozPcEbT/iLginDnO26Sr7KkIQ80W56kKwBOS9vsoV+9yMVy/mJhxzQMCYkEqIPsCPR2R5u+qFhofzq7Yf1FPzJT9VZMRaTiNC9TVdo5F1PiVc3o1xw+Kgs3Hdxs7blvh7V/GPdONFN0ibaic2ZD8OianF0p57JMNVDdIfDi8QLiAoB3jXm9RpdgQUVjTn6w1e4aFxHwwpHeqdy5Q9CilVcFplK1tE3Wj2/rLbvXDXZZoY4Zf8e+/LrlG2V0GZcwLNhZRLrYifh4NxXj8ZJ7LMrhFN8Av+yfhO3ggGJs2ZNaBQoTjN7WEJx5Wj7UwD4IdD7KWs7IB8kenk/sFmYJlg3yFP3g4aDsL
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(39860400002)(376002)(346002)(396003)(366004)(451199021)(122000001)(6506007)(38100700002)(26005)(82960400001)(186003)(38070700005)(83380400001)(2906002)(5660300002)(8676002)(52536014)(7416002)(8936002)(33656002)(54906003)(478600001)(110136005)(86362001)(9686003)(71200400001)(7696005)(55016003)(41300700001)(316002)(66476007)(66556008)(76116006)(64756008)(4326008)(66946007)(66446008)(66899021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9dc6oHiIm9MvoBiRFdlnTY/vlKMwp9DTJMMxnEOttxR97Egqn9W6JJ+/Y/yD?=
 =?us-ascii?Q?EEvI0YHD36w73g8AAH+HKhQqKaEInS90wVyiUNpEpK7+aKdszs+8wp0chbSB?=
 =?us-ascii?Q?TYcSdZi1f0Q5VnXdU3ddhIVAg3BWouwlNius6I0pXf32cthdg1hP8rCrZUKZ?=
 =?us-ascii?Q?1KZnRXlt14MFAtUw7Vz234nLCIy2gI/NGNmpGihxZSRYHwgAFYLx2A8/8JDG?=
 =?us-ascii?Q?ok3moP5zCTZZjP0PptFk5IaMCrnKzjWV84t0Zx2CWTZDBxmap1zNtwCClkNq?=
 =?us-ascii?Q?lsChcRV2DviS4uPiIeoF6Ll5SQ6X4TTxklR0fsfYCYdrWet64e0KD2diD67b?=
 =?us-ascii?Q?Z6wxMOTSUZ8ezmqxtErV/RJf97uQw7OlU22UYjzIUxZBMcfCH4PiRF/c61an?=
 =?us-ascii?Q?3zYjKkkqxtk2vhwcfPMGwUldGUPT5IQaOXzFSJ7xJ6dV2pXtyzdQe/jUlzzy?=
 =?us-ascii?Q?QVpCoJg8LhVv6qKpVHDi/BTpwMxCZJhWKZcOECrSYra+zBW+5PQJSryJ2fK0?=
 =?us-ascii?Q?00rxfM5rm6ERGGN47A4fChgpKoZNSSqopdcbZhcjwzByATyd+CN9s1/m/i8a?=
 =?us-ascii?Q?9pIW0B/slUIpjS61CaP6fUjSc1g+oWJqueL/mqrLKYFOVoBJZgfFuSTJyDlF?=
 =?us-ascii?Q?pnKTZXt3WoAjVggHLkUC8CnVc9vC30UbBEmR8vOO1XjtpZbczzfWPYjqoYTh?=
 =?us-ascii?Q?1nhIs1htzyxFQCLiPGkrqOOUpegHcqQxumsZj8eNctSXPnuwBs6job+kwIe8?=
 =?us-ascii?Q?fdV2cqLpH45SoSa1pXXFccZghjZWQZw5hh8oEE7gS+8AWoGWUbntBXj9tWn3?=
 =?us-ascii?Q?YyWc3Nq4HpQvdc4obE+exMPA9rzHfAfNySlR7/4lvv6Bt+66Y/277WrxTs1Y?=
 =?us-ascii?Q?VISOoMQLgIKaO5Q8PivK572Q5mj9SWDFY+gGVnKjVbNl19Nbm2lQbfkJGuPI?=
 =?us-ascii?Q?zrDNoKCNDftXCXJZ8G6B10pRl+VDdBWIQ2qTrVvtyg+1CGC3hs2iOJdqGsLk?=
 =?us-ascii?Q?zAJyEehek7XlmRmd+W+znt59SPgahGYIsV9Rx5ksUmkRH17ihse2XpwH4vEG?=
 =?us-ascii?Q?jfr1oUUPw18REqNCFj2bahCMX4da7zatZ1IszvO+PUUwjhA7t/7eBQAkeWRG?=
 =?us-ascii?Q?IaPNpVSnvbysEE2+BoSQB2G17dliWNkDwgxl40KN/ri3uY+0nmS2u7rzbjxj?=
 =?us-ascii?Q?/B9Nu+VbhbViMCUqfJMshX2/5JoENTpUF86NdwSRLw/EYjg0l35Rl9RI34+X?=
 =?us-ascii?Q?NE7fmuYvu3NEvh25JdaUUJV93yx94uFukF2Dsz+2B3ELaL3kLs1NcJaFpsOp?=
 =?us-ascii?Q?ldctp6Ne6TCoDebuzchWhA73Mm7lcW1wZaldrIoChc5dDjwmEYTjdbi7DNz2?=
 =?us-ascii?Q?pWBbDNEVu9z3lpcf3yE0wFblTTYUetHnFvBY00HgLUthy/zbS3DOIRUTQfqd?=
 =?us-ascii?Q?n7nOOkXA34gDoXXN/FJ0etnds1zIZ5obYMLspLAUsajg7vcFjuZeWFBFM7ol?=
 =?us-ascii?Q?OjZqYwYGSObjZRBjHUSVNsuQeWBdmqnvkcZS6y4JJ2ZVJ8u8S448JJqpKsxD?=
 =?us-ascii?Q?1COs4XSiNcvhryvZYqKJoMVDYSy3yBZZkqVHZ3of?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6281059e-c681-4991-367a-08db932bd424
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2023 07:41:05.4769
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YIzxGXtHboFbMKNFQZ7+f8Q3LNeQAz6ImSw0V+78j5QJzeRtwyPrJgR0nGNgxoBKycoGR5lZeOW5TPhAl0rhxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8433
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> From: Liu, Yi L <yi.l.liu@intel.com>
> Sent: Monday, July 24, 2023 7:13 PM
>=20
> This adds the data structure for flushing iotlb for the nested domain
> allocated with IOMMU_HWPT_TYPE_VTD_S1 type.
>=20
> Cache invalidation path is performance path, so it's better to avoid
> memory allocation in such path. To achieve it, this path reuses the
> ucmd_buffer to copy user data. So the new data structures are added in
> the ucmd_buffer union to avoid overflow.

this patch has nothing to do with ucmd_buffer

> +
> +/**
> + * struct iommu_hwpt_vtd_s1_invalidate - Intel VT-d cache invalidation
> + *                                       (IOMMU_HWPT_TYPE_VTD_S1)
> + * @flags: Must be 0
> + * @entry_size: Size in bytes of each cache invalidation request
> + * @entry_nr_uptr: User pointer to the number of invalidation requests.
> + *                 Kernel reads it to get the number of requests and
> + *                 updates the buffer with the number of requests that
> + *                 have been processed successfully. This pointer must
> + *                 point to a __u32 type of memory location.
> + * @inv_data_uptr: Pointer to the cache invalidation requests
> + *
> + * The Intel VT-d specific invalidation data for a set of cache invalida=
tion
> + * requests. Kernel loops the requests one-by-one and stops when failure
> + * is encountered. The number of handled requests is reported to user by
> + * writing the buffer pointed by @entry_nr_uptr.
> + */
> +struct iommu_hwpt_vtd_s1_invalidate {
> +	__u32 flags;
> +	__u32 entry_size;
> +	__aligned_u64 entry_nr_uptr;
> +	__aligned_u64 inv_data_uptr;
> +};
> +

I wonder whether this array can be defined directly in the common
struct iommu_hwpt_invalidate so there is no need for underlying
iommu driver to further deal with user buffers, including various
minsz/backward compat. check.=20

smmu may not require it by using a native queue format. But that
could be considered as a special case of 1-entry array. With careful
coding the added cost should be negligible.

Jason, your thought?
