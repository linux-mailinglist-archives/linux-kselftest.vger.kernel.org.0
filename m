Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1BE36B895C
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Mar 2023 05:15:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbjCNEO6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 14 Mar 2023 00:14:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjCNEO5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 14 Mar 2023 00:14:57 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A82B2CC5B;
        Mon, 13 Mar 2023 21:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678767295; x=1710303295;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=OAXyYswaXZK1wF7nHwbnymZy5BfG8s34KbOspir5JbA=;
  b=nbvf5vS2MlkKVQaN6UFI4aYKWqyJRIUhP9rnsBFZP7mqH3uYeLs0uQ9u
   BE98smxc3Y9qaqHcIgwq3VzoSnhvj8XTrL7vqc5MO7dTGfZaVTZl/fHhr
   IqkdJ1xJV9S2LbqpaYtmI9CGdrA/2QB3njgLqNOq9VV0d4b1+LwaBm+QL
   +vLajYaRYNWIfwi6kl7qcKPz2j1MWPr0NcexCKaikid71KFpkTE40vwXS
   z0xW6X6TZp63z/Aya7wmCYYmVwpGgAdtry3XiB+u4nC9c1WExbXgJCT7C
   N6cIXS4yr9awzCoQTrawBtEAdeUPJmG+XvGc6Z87nQGgAxS++xTAsl1ag
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="321181013"
X-IronPort-AV: E=Sophos;i="5.98,258,1673942400"; 
   d="scan'208";a="321181013"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2023 21:14:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="656199693"
X-IronPort-AV: E=Sophos;i="5.98,258,1673942400"; 
   d="scan'208";a="656199693"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga006.jf.intel.com with ESMTP; 13 Mar 2023 21:14:54 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 13 Mar 2023 21:14:54 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Mon, 13 Mar 2023 21:14:54 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.42) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Mon, 13 Mar 2023 21:14:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RTfcbJuTjKuKtt942/xZUi3SHp9d1mmWh0D99Rgo2m7xj+ow6NU0SLpQHBiNReoBJ3Hzmww2Uf1GTnkMFyehxiJ4JXWEARbHxCEq68bgry16+bYo2U7J86waQ4R4VjPVIgqUpWdjEXMcJCSUYAhGR3yTViknPyR2zERAlHaz0/VWcjbNfszbbngk0xMUBCYIApHM4+rbG2jRtlpchd3GEnszwXK5hwvm78BxWx9ak4NmsnrWCaHjklKeOmpKTbtYGEoUPB4rm6GKqXF6maANcRrKs6rL4l3sbssy39evRw6bVBe9qoo/8uSwHFpMtUnOFNEdkK9bOhw3LrMg2pz4ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OpePMopBw1jO6kMr+Cz3FXCAU/d+hF5uf43DuS0UDmU=;
 b=JPrirAbDz56EYUnbdBMu04jwK6lOuVnrijcUNRvevnFnNBhK5RIKBYTebe/17C/jkZXvvCcEFLJDJt0YfQCLh22jDikqD6eNB63k1DYT9u82BJwg8O9AGQGSBWV3tlFYVqPv/ioGbhuXz6p68OdCgNIzo0EZDLvcVRFGerPAqoaAJTXcEST7XpULGR0g20S7te19scwoKROkmfB3dovumWYbfqlNkSSPCdrd7P3rlzfeQcMJzRl1QhgP15qrbnykosbaXxmJ+z1UaFa6ps7pdvf5mrNn4f/idyngcJbx2BBpo2VBBYYNfbtJqq2wA0sA0sbfe1FF5Wy/rhgePXuITA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by DM4PR11MB5469.namprd11.prod.outlook.com (2603:10b6:5:399::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.25; Tue, 14 Mar
 2023 04:14:47 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::6f7:944a:aaad:301f]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::6f7:944a:aaad:301f%8]) with mapi id 15.20.6178.026; Tue, 14 Mar 2023
 04:14:47 +0000
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
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Subject: RE: [PATCH 07/12] iommufd: Add IOMMU_HWPT_INVALIDATE
Thread-Topic: [PATCH 07/12] iommufd: Add IOMMU_HWPT_INVALIDATE
Thread-Index: AQHZUl6BWo8K/M9cuUy0397Pqa8aG670TNcAgAVk8tA=
Date:   Tue, 14 Mar 2023 04:14:47 +0000
Message-ID: <DS0PR11MB7529686C6B7FD1FF877B9C23C3BE9@DS0PR11MB7529.namprd11.prod.outlook.com>
References: <20230309080910.607396-1-yi.l.liu@intel.com>
 <20230309080910.607396-8-yi.l.liu@intel.com> <ZAtt4F9zSZxptyZh@nvidia.com>
In-Reply-To: <ZAtt4F9zSZxptyZh@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB7529:EE_|DM4PR11MB5469:EE_
x-ms-office365-filtering-correlation-id: c19c42c8-0d64-470b-b6b9-08db2442a60f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: auAjR7lmDNkGz2oSrsKEg/l+18knXNPCsSf07wUbWpaC4CgZCMicQrMTnSpGV3PXdC402ZC2yfRqJQTYdFno/iDF5MG0V1Rvg44L9oN4YgFW4bwlTFgcrsMB1mfRg4StgmfC2fiwD+Buvmf5PB872F3etHOq8GKjvfCagVwChaHtDfE+xfweWpBZ4ZVSeTRNIBlE+PNYtfXfp/n+y25fBmK/uGqtF9i1Pxmi4Hij9Zk0B79o9x8kjA1AuoDoK/xjG+fzhsGCkh4PV4jBxz2y7YYDjBaWL6VWC448kYE0rG5hKThDLqecJ2I5SDbmAorfg6T+oD9YkFNvgGVtdwP80q0kWaMhWVvqoj0AB16gS0W+JpbSXxxOKAtizyOIxducCqvc3LSbJJn1/WPv4lhSt+U0jtPHMVnxHKzBUvn+76Z1DAJVHiKcVSfZKJ2LdLkfLQXYj8EYKq8NfLEJr0Lv6xw/ZUVh6RkyFkOycwwKN2NIw7/fGz1rRfJDENHfEHsi6D3ZgbH0e1DaHQtuWXTOaNvFjvPXUvzz/xnm5q04opPkzxXonl6EwkNuChHGi89wDNJB7u3qjqSbl1vA/OBFW83JXrC5N8HAo8QwJU4Do863Bi12DHelxK12Ag7RnAYQY6wlb75ARcIE58PgK5gibha6TtcicVXFzc21Xqy4ODjKw5ZAScZrQkYQKHb2/A2UkS1uL1iY1GG02nHn1z0/fw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(346002)(366004)(136003)(39860400002)(376002)(451199018)(82960400001)(122000001)(2906002)(83380400001)(4744005)(7416002)(5660300002)(52536014)(66556008)(64756008)(66946007)(41300700001)(6916009)(8936002)(76116006)(33656002)(4326008)(54906003)(8676002)(66476007)(38070700005)(38100700002)(55016003)(86362001)(316002)(478600001)(186003)(66446008)(9686003)(26005)(71200400001)(6506007)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?DzW7ftQVy7rbuq0tI/76xOLdQ881HLjbz7PU2GD3xt+V3FzqpAC7CsCSW3Tq?=
 =?us-ascii?Q?KuTHFkpB5LzObyLavdLWiNeyprOPodB0WUUBpM3xZbbGB8qsMEyezTwQkfEo?=
 =?us-ascii?Q?JhKWmgmD4bJJ7pjvbadPWjxSTSRhNN3+NU5Xr01CNYlXJ0WrvYWCSz1zIX7N?=
 =?us-ascii?Q?oklc/YwQ5RDHyx6trI+di/JY42ZjBMuLGmfYWjBFS4ww6PXfaUR/SIqOw408?=
 =?us-ascii?Q?/jJkbhnLA6+CowIDdX47veYFKRYvH8XPqsPGg/X6+fBf4Qoy192Wj6jGWYYZ?=
 =?us-ascii?Q?E/3xXgw4X7nZCwTe1SiOxghVTNse85/cF8l/iFzigVQYR4kSJpTXiKjyaLYI?=
 =?us-ascii?Q?dK9MPR/PgvUhDBBPYQH3NPwbntwecEU1ztM1fKwYkOrouKWAPZZ6H/aI7O7S?=
 =?us-ascii?Q?btEuVqEWup7QzH9jJtQ6fmQF8KIb/yw46VQ/uGqhwuWGJAdMy4WW6d6SMs1b?=
 =?us-ascii?Q?z0EBK3QwSANK9j3Z8zRSTU0+DWCwj9ygUfjHUQ04O8PxTiLkOvVOJbirpz9o?=
 =?us-ascii?Q?pg+jCtfvgzzebqe3A2YRUmaFyAk8f8YCml8OfzrQx1xMeWlwETp5kIh30BpN?=
 =?us-ascii?Q?CEuejFYTNFKzg8MFN2EnHgNmg3sHxbUOPwA1o6QneoLzRgbeF0yPczrh3xSp?=
 =?us-ascii?Q?hBpiZCf9cXwA3WzWRS4QDab+9koHSo+O2DKKvib30Kw7oVj1vAsExPoCXTZN?=
 =?us-ascii?Q?hNXrcrNjsK3ddMjWIq+FdvTpCyJfVFnUTC2AW0E6rCzkhssFjz7oGZjkkWxA?=
 =?us-ascii?Q?LGfXcPwayrd+J+c7yQamoao36QCPOt04akhjpzsgl0yg+knIK4nl87lZXhUU?=
 =?us-ascii?Q?/QQelscsGcoy1uj/l9aSecKZJzv7ROvqnn3ThP81agmhv6jr8aYxepcLye8A?=
 =?us-ascii?Q?Bc+WvnG3K9K7lNOyJPuK8SIRkE4ZhUAU5ybvGFqS5470FUJZAi9aNOkbzFFC?=
 =?us-ascii?Q?W2XwuKyHhKz8reDEowL7cA79gQYYpvD954SC+Xum2p90Xq4H923YeOS8mg+A?=
 =?us-ascii?Q?bB1jkzCf4S4EL/8Mrqk0sY1S6QGOzCghNiP3EChOid5y7waLKJ66qbkslg/e?=
 =?us-ascii?Q?UZwIHt5IfCqkOFehz4uiZlq2Mt9ppzqf3PTLJAQpRVI2pc41LoxmoW4U4Ld0?=
 =?us-ascii?Q?mqeYWz5LHMc1H5mbXOpcSBslVSPPHbez+rZQgSr6yNI/z169YdYt4hxiYryI?=
 =?us-ascii?Q?fy33/ZeqMstzK9yl/SeYMMbigvYEolYyzg6bYK9DPF2pPz+EYNwK4lauwgRw?=
 =?us-ascii?Q?30sGPQ6XeD83i6tk+1i382Pv7sUIVRmISzLpMhuewzwIwaYVMOh74/5/Yop8?=
 =?us-ascii?Q?X9g2LaStbDvY2A1hY8wAkY7Us9o3CXt2T1ktItBuoQr+iA+khGRa5cdW4wc6?=
 =?us-ascii?Q?fsvW2XG07ZstsmPVhQuT9VJko0jaPbU2r6C0qgrwIbioRiNXqgpWcsF5QDRW?=
 =?us-ascii?Q?2r1FT/0tshDSmQZQEoSwguMqqjQ+Gy67C+Pk8pUTyZF6ACnJbpfB5KuXginR?=
 =?us-ascii?Q?wOZZdCmiYxR4uabaSqQfIUgdgb5oqAwHwAbiXqbWQ/eXvdpNbGKaUH6rrszW?=
 =?us-ascii?Q?YlOLjjPuml5KRDBmzDNcVQTNPWckKreb+mTo1r1b?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c19c42c8-0d64-470b-b6b9-08db2442a60f
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2023 04:14:47.5389
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1fyW5QFs2yVZLQemjTSPqPrWjkgQXRYdFAzWpJnLN4WYMX2Vv8h1dUYyIqvgkTaEFrXZ+ulKTaVvsiq7Cw17VA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5469
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Saturday, March 11, 2023 1:50 AM
>=20
> On Thu, Mar 09, 2023 at 12:09:05AM -0800, Yi Liu wrote:
> > +int iommufd_hwpt_invalidate(struct iommufd_ucmd *ucmd)
> > +{
> > +	struct iommu_hwpt_invalidate *cmd =3D ucmd->cmd;
> > +	struct iommufd_hw_pagetable *hwpt;
> > +	u64 user_ptr;
> > +	u32 user_data_len, klen;
> > +	int rc =3D 0;
> > +
> > +	/*
> > +	 * For a user-managed HWPT, type should not be
> IOMMU_HWPT_TYPE_DEFAULT.
> > +	 * data_len should not exceed the size of
> iommufd_invalidate_buffer.
> > +	 */
> > +	if (cmd->data_type =3D=3D IOMMU_HWPT_TYPE_DEFAULT || !cmd-
> >data_len ||
> > +	    cmd->data_type >=3D
> ARRAY_SIZE(iommufd_hwpt_invalidate_info_size))
> > +		return -EOPNOTSUPP;
>=20
> This needs to do the standard check for zeros in unknown trailing data
> bit. Check that alloc does it too

Yes. would add it in both path.

Regards,
Yi Liu
