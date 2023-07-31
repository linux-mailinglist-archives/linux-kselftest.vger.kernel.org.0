Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1C4C7692B5
	for <lists+linux-kselftest@lfdr.de>; Mon, 31 Jul 2023 12:07:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229966AbjGaKHk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 31 Jul 2023 06:07:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbjGaKHi (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 31 Jul 2023 06:07:38 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F4D7A4;
        Mon, 31 Jul 2023 03:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690798057; x=1722334057;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=3RX3ySIGqAOuUdUKznWkHaX7NmoO3A/lVEf9S57XpeE=;
  b=RZm16LOSsTKP9eWg/ly6Atp/+p5CEqEGGiF//OH8NFjnn4HEUDqvwvVS
   MA5iwr7S3jfEl6Wrk/hOx8NRf4H/RsnMQ16y6HOlqqXLGFGXsCGfMsUvs
   hn3PXFf1d+aYTnH1BLh//b1beuDcSZ9cbGu0TGjnJW8wvk7Ky9z6W555S
   GUyBvEKe4f0XeKL3Id7qCev6F1rFAYH+odvMwph1UOKC2O8YkolxkJ8pC
   hFFeKMSou16D6bZ8ZN5TN4p9si7wwM3zCuri3PNRojy9Bsz6uocCPK2dQ
   hQT4YVwp5Nt3X5DYomTp9bVq2tDaDODKHGvjNpZevAvw1sg8Q4C2y/EdM
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10787"; a="368988628"
X-IronPort-AV: E=Sophos;i="6.01,244,1684825200"; 
   d="scan'208";a="368988628"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2023 03:07:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10787"; a="763336902"
X-IronPort-AV: E=Sophos;i="6.01,244,1684825200"; 
   d="scan'208";a="763336902"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga001.jf.intel.com with ESMTP; 31 Jul 2023 03:07:35 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 31 Jul 2023 03:07:34 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 31 Jul 2023 03:07:34 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 31 Jul 2023 03:07:34 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.170)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 31 Jul 2023 03:07:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=atLQoghFbtyf72xoBVTij+z0ULizAFd0GOBvAAkTXTyRi/4FaC/9hCJasMsoh32g5xuo5Xn+ZpkzK3DBprbg04DRRJFQWJ32hJisAEtZfNZLTiNwDtIsEytYjEdivkN+TqKWPYI5wetmyqDK9OBs22hexBgAg0rUIDJQaSByfVOE92A+L7r7NR7p1jdFW+WkjbDh+c1Kv/d0Wyuxz+mu7NNpqwGu1VGYBmzPsvAD9r1tDDoJEHGXdmwbhWUCqmW88+FLQQaBx58PRLxseeXxkDsYLD+JADTk1mhctMAxFzuzggWaRM4f6Apx0xLE4UGLNFsBtdxz9C/PqsywLkm+Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d/FQTiq1PY8FI+EpNHIqT0nTSsXKqAh7kcbN2z1gYe4=;
 b=DA/s0faf40u4ptiwCkuat5c9pbqyjD8a7y/C0nPtDrVxITR5a9Iy3FZeJcZ26mh5AD6QR+zI6Umqz2JcDKWisjrr6DRKG7HAFFSp87KPQQ7lQToXl1jr6+XUjSTlieuBFoGg3nD5w0LwGipKU2oEDaooKJ5UOudwd6Na68of8Y0RxXSdieytz1rrfFsHvZMElW4AVtsbei77VwYxWIHhZtFXUobOTNPG950V9RRPy0lgXS31kJuHaPzmzygVckvs6GkVI4PX7r8O5WVavfxLZzYSZlGj4V27BYp/JUmqZ3GXU3DMiApP9A3nrJolbAuLXfHE256cIJvDLwYKEGUVOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by DM4PR11MB8160.namprd11.prod.outlook.com (2603:10b6:8:189::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.42; Mon, 31 Jul
 2023 10:07:32 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::b556:42c4:772f:d47e]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::b556:42c4:772f:d47e%7]) with mapi id 15.20.6609.032; Mon, 31 Jul 2023
 10:07:32 +0000
From:   "Liu, Yi L" <yi.l.liu@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     "joro@8bytes.org" <joro@8bytes.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
        "cohuck@redhat.com" <cohuck@redhat.com>,
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
Subject: RE: [PATCH v3 09/17] iommufd: Add IOMMU_HWPT_INVALIDATE
Thread-Topic: [PATCH v3 09/17] iommufd: Add IOMMU_HWPT_INVALIDATE
Thread-Index: AQHZvh6oi+POLB7tyEyJT6RvyneQWq/PfyuAgAQvXCA=
Date:   Mon, 31 Jul 2023 10:07:32 +0000
Message-ID: <DS0PR11MB7529696366A4447EF0945E87C305A@DS0PR11MB7529.namprd11.prod.outlook.com>
References: <20230724110406.107212-1-yi.l.liu@intel.com>
 <20230724110406.107212-10-yi.l.liu@intel.com> <ZMQCw2iiIqa4CXNG@nvidia.com>
In-Reply-To: <ZMQCw2iiIqa4CXNG@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB7529:EE_|DM4PR11MB8160:EE_
x-ms-office365-filtering-correlation-id: 02f60ff7-6c48-46e7-1c12-08db91adf48c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FNkaOLndtLNo6/CF2z88H/sJ+a+II0OnglRa4C6Os+ev0oBa2ne/A+b0c4Y1Aydk9Qx9Cwnn/NEgI+ewMOzv/DdwhiHv5RZb2vqntxQ4gEwxs83grloVdl3RFHaL99oN/oFyi6bMKeIKKsP2rqaHO7/1RsBOVpwnQxs6epZSiU9FVg/sDo8F2Iw7g01Mbc2Hcx4D/4VIJycwWEMCH3TDNAFbpdZz6xx2549EDz3pGkSMhuEQhdEwLAhCull/+EMoEpxtWZMiQU38dciV7uR+x/Kd6iuu6eCwtCMgRZ8vhlrvWOA6x7NUGHyxxXjvkXvuVGrUwhYnZSDW0lGEEWGjxsUpZWMTQtit1VrcKgMC5EmXpMaTSJh0DUDhwMUOlVUqw3EKI5ZyCm14z/JuNKHiTgPprOF9yaGwZ8CsndBhx5WthHsi7VbzuTLddubggKAujEAvLhgc/VIB12I5SYp3Af3k0yCfFwW/0PFft/evGSVfFV51jMjnN+viKq0/yAF4OvkciQBhpprRxL2RVSLS9sQOd9r16oQE92JXlKP4gqyOEWxqX9M68kjWu+Cb77BqdacY80JEMV8Ozrp1PPcMY09caAfrzG2lYzE+hGFTfCq9UZizN4+1SjADfElhSG+JFOyVGyXYfOdJiNaNT2xNyA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(136003)(346002)(366004)(39860400002)(396003)(451199021)(38100700002)(82960400001)(122000001)(55016003)(86362001)(38070700005)(33656002)(9686003)(966005)(478600001)(71200400001)(7696005)(186003)(26005)(8676002)(8936002)(6506007)(7416002)(52536014)(5660300002)(76116006)(4326008)(6916009)(64756008)(66446008)(66476007)(66556008)(66946007)(2906002)(54906003)(41300700001)(316002)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?l7VkffsokZNYMWqL1DybgRhMRKAbOeAv4YfT0YOWa32+9vjumcC2wSKEopo2?=
 =?us-ascii?Q?Qdg5ZNqet0FVS2BD6+Vr35rPpVKcTOmkRxsWNg4W+el57PP4McgeusIFvKvd?=
 =?us-ascii?Q?YFd94zIPdo0byEmESknOTQxX3p4aiPW4dhAIH1mHzojeAyr7TansL0fv+MA1?=
 =?us-ascii?Q?JR5DgR2htlv1uD1xNP0Po1VK0/HHhF/blL580ANwX0S1mtgDDTqQIm30pu7/?=
 =?us-ascii?Q?4kfQiwrQh2gMdCPp7vp+9TlDPMy4cQvuK4cIg1hf0sY4pU2o3rt/qmOuMQqV?=
 =?us-ascii?Q?ofRuc7GfjPH2AXCeLhZ0/W14F92wK/lK5ZRiPBjUTOh/9j0VRBNZXP7ds9pw?=
 =?us-ascii?Q?Iy79xVE2cSFQCvV7t9EVJ4y7JgzFoU2UHXeD/6c/gBlvi7kuL9EC2p9uf2T0?=
 =?us-ascii?Q?+iV4ZVV4lxcdWO44O7OGC4WrqaeeRudywazpufZtP2guqDeawTdmGWqXyTgI?=
 =?us-ascii?Q?spAua+1/CxXxWHCaGxePthsoN5Grv51ZvOxoMO+us1FKrAPJeg6FNxlfVYLj?=
 =?us-ascii?Q?603tVZfJQEURu5ez6YaJfgEWwMxWuRO9T2lh9oElHt1BB6NZNaEqiKoPwlls?=
 =?us-ascii?Q?X8aj2CSXjPXlvXmXuyqfaaEnb7LqxKyqgWZ3Ad18U8YwSSfnFMkcnM+psPWt?=
 =?us-ascii?Q?vh8puoXGwsp07toBM71FKqeYdAhF6Jnkt+4JIWJgIYs+nomWpdYkzrdgqomR?=
 =?us-ascii?Q?LSi/AG6yVg5ed7qGkeMK8PAaclEcbvX3ML7jZx0rDLBa4DP7Eq37YUyJ2v4b?=
 =?us-ascii?Q?Tiej8GkRPKob6UOL+3D1LwrRhiTRM43g4kQovFIfZdKuB43yTSNmgqOOEJmi?=
 =?us-ascii?Q?SPg+WKffXUPQQCXVFplWeGPMReZnnkECBxE7nh953JqL9H4zSSapkCLK/D5Y?=
 =?us-ascii?Q?H//4n9teU+dFM38RMujy8X/iPy2tbTeoYMcnkkjxX7mNSvEeE9m0iLRPL/VD?=
 =?us-ascii?Q?7e89ssegXOVaZH3lkfbgqg32b+Ld4HtUrcdsyOVatIemotD7eAkS5c+vKQe2?=
 =?us-ascii?Q?LgBTrqynFf/zvWLuBrJH4MsiZw2p5Ztg37iGu6hGM3p5k1orrXSiAhWdgNDD?=
 =?us-ascii?Q?jRLgTjibIzfQdEsSgyQlORKeVum3iJZ9YD5gFwVEw0w9izyHZNGwU8mYp9in?=
 =?us-ascii?Q?/7R6RPJyHhlb0JaIzjjGY0rD004k6D+P6XWiQX7uHR5j67J1M/BvyHLti2Ba?=
 =?us-ascii?Q?Dd9tqKYu6yHZeFS8kN26SBq9FD3ht+eo794QbcZc3rBrw1VOT+5mlMsbUWC5?=
 =?us-ascii?Q?ecHn3vA17odQahsHzrSEX9bwZhfL0D/wWFcllXHbgw6bghHPkS9vFa8ETv6I?=
 =?us-ascii?Q?Q3GRBMJOE7+Pcnl0ueR0rLomZwGMDqEOeUNLXhHTs8mc7V0uKO7VHOrgjtUR?=
 =?us-ascii?Q?AJdJuaQjWq36hUcOIvNhqhVsErBOUfrb368JkJksGd6KQXMTiFkG99RRqww5?=
 =?us-ascii?Q?qBfYIghwC57/ylzx16A5gdzBNVGdm/BPb6ovcHaMBVmmJfCV+4W/7pg2oU1s?=
 =?us-ascii?Q?KknvxMQvTeFbVYrMOKNbYpFqVFf9Zsz+hiMZvtKUeq4qYIj1Bf3QOmJ1QXzD?=
 =?us-ascii?Q?HhzW5pJhCXVpkPkoA6Nd2YUOsCsZ+XFpAP9z5pBM?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02f60ff7-6c48-46e7-1c12-08db91adf48c
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2023 10:07:32.0867
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aNON4Z5BgKTuHFJfc4q+UlJ1KxYnaGsTIpYmnz9ejT2uSMgbxWFI89jSnH2szuT7ipGR0h3IofUL/eMJN2a5Fw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB8160
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Saturday, July 29, 2023 2:03 AM
>=20
> On Mon, Jul 24, 2023 at 04:03:58AM -0700, Yi Liu wrote:
> > In nested translation, the stage-1 page table is user-managed and used =
by
> > IOMMU hardware, so update of any present page table entry in the stage-=
1
> > page table should be followed with an IOTLB invalidation.
> >
> > This adds IOMMU_HWPT_INVALIDATE for stage-1 IOTLB invalidation.
> >
> > Co-developed-by: Nicolin Chen <nicolinc@nvidia.com>
> > Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> > Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> > ---
> >  drivers/iommu/iommufd/hw_pagetable.c    | 45 +++++++++++++++++++++++++
> >  drivers/iommu/iommufd/iommufd_private.h |  9 +++++
> >  drivers/iommu/iommufd/main.c            |  3 ++
> >  include/uapi/linux/iommufd.h            | 22 ++++++++++++
> >  4 files changed, 79 insertions(+)
> >
> > diff --git a/drivers/iommu/iommufd/hw_pagetable.c
> b/drivers/iommu/iommufd/hw_pagetable.c
> > index 97e4114226de..9064e6d181b4 100644
> > --- a/drivers/iommu/iommufd/hw_pagetable.c
> > +++ b/drivers/iommu/iommufd/hw_pagetable.c
> > @@ -286,3 +286,48 @@ int iommufd_hwpt_alloc(struct iommufd_ucmd *ucmd)
> >  	iommufd_put_object(&idev->obj);
> >  	return rc;
> >  }
> > +
> > +int iommufd_hwpt_invalidate(struct iommufd_ucmd *ucmd)
> > +{
> > +	struct iommu_hwpt_invalidate *cmd =3D ucmd->cmd;
> > +	struct iommufd_hw_pagetable *hwpt;
> > +	u32 user_data_len, klen;
> > +	u64 user_ptr;
> > +	int rc =3D 0;
> > +
> > +	if (!cmd->data_len || cmd->__reserved)
> > +		return -EOPNOTSUPP;
> > +
> > +	hwpt =3D iommufd_get_hwpt(ucmd, cmd->hwpt_id);
> > +	if (IS_ERR(hwpt))
> > +		return PTR_ERR(hwpt);
> > +
> > +	/* Do not allow any kernel-managed hw_pagetable */
> > +	if (!hwpt->parent) {
>=20
> I don't think this is needed because:
>=20
> > +		rc =3D -EINVAL;
> > +		goto out_put_hwpt;
> > +	}
> > +
> > +	klen =3D hwpt->domain->ops->cache_invalidate_user_data_len;
> > +	if (!hwpt->domain->ops->cache_invalidate_user || !klen) {
> > +		rc =3D -EOPNOTSUPP;
>=20
> We need to get to a place where the drivers are providing proper ops
> for the domains, so this op should never exist for a paging domain.

Yes.

>=20
> And return EINVAL here instead.

Sure.

>=20
> > +		goto out_put_hwpt;
> > +	}
> > +
> > +	/*
> > +	 * Copy the needed fields before reusing the ucmd buffer, this
> > +	 * avoids memory allocation in this path.
> > +	 */
> > +	user_ptr =3D cmd->data_uptr;
> > +	user_data_len =3D cmd->data_len;
>=20
> Uhh, who checks that klen < the temporary stack struct?

Take vtd as an example. The invalidate structure is struct iommu_hwpt_vtd_s=
1_invalidate[1].
The klen is sizeof(struct iommu_hwpt_vtd_s1_invalidate)[2]. iommu_hwpt_vtd_=
s1_invalidate
is also placed in the temporary stack struct (actually it is a union)[1]. S=
o the klen should
be <=3D temporary stack.

[1] https://lore.kernel.org/linux-iommu/20230724111335.107427-8-yi.l.liu@in=
tel.com/
[2] https://lore.kernel.org/linux-iommu/20230724111335.107427-10-yi.l.liu@i=
ntel.com/

It's not so explicit though. Perhaps worth to have a check like below in th=
is patch?

if (unlikely(klen > sizeof(union ucmd_buffer)))
	return -EINVAL;

Regards,
Yi Liu
