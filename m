Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA08C76A7B5
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Aug 2023 05:59:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230481AbjHAD65 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 31 Jul 2023 23:58:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbjHAD64 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 31 Jul 2023 23:58:56 -0400
Received: from mgamail.intel.com (unknown [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FBAA1986;
        Mon, 31 Jul 2023 20:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690862334; x=1722398334;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=rf1RJnpMm93lZ/jrloipo0pLJA+ksmkm9cipBPjZse0=;
  b=egOuF2a9+H18nr5hRdHW9UCfGNGg541UMQXcr3/lbwZmQRv8mVUZ3p8/
   fbAiHg+VpH0cTSpR7bhGHC5bq1uPnvXhgimMiTQBkzMveprD4+HooTJA4
   QAiCv17Qfie1TB8CHNk8ay9nyGiLd+n1NLXFBc0hU1aoToqgT1aj6d4Lx
   2jJ/UkZ+jg962X8MS3TkV4m65JBUNDpjhX6S19BsBp+CWel/aD8q8uUnD
   SkW+q8bu6A8brjWoXon4zl8NmmTi1LYUVDo/dzjoybhy6al4jnl8Xxz5w
   OebornOFV5i6LlrnW8T/UBip+J0lDwFpGcrsDTc6YkRyD535QbXio++tq
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="400140311"
X-IronPort-AV: E=Sophos;i="6.01,246,1684825200"; 
   d="scan'208";a="400140311"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2023 20:58:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="678545488"
X-IronPort-AV: E=Sophos;i="6.01,246,1684825200"; 
   d="scan'208";a="678545488"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga003.jf.intel.com with ESMTP; 31 Jul 2023 20:58:53 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 31 Jul 2023 20:58:53 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 31 Jul 2023 20:58:53 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 31 Jul 2023 20:58:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rrp78N6vwvNG1SFUj9+R8laTTH+KQFzaQHyLym3NTS+nJ91BRsTyL5GT/ORf4tubpYpxoieU59B2UhzSkqGXaGd7A2tlthOXJWMOzrKXPpDnrNumkZ+CoKOvX4WUj5eNpo+d2U83XcHvkWvGw2grfZXTBHel+0LsMoXKaA5tzRjB4BbNlBC6PMVwweadLh/nX3UTwD1kenH3dxo0/xEN1QVCem8eqh07HLg8s7WCKAOV57gpf5GEepYYdWTsaUaHsRzXM/2SOjP0biEPskSCK9UfW/+5u2RObiMXHWWN0aRtiBk3qhLZz8AvPMjV1M7zYw1I3IU7v9LRPWQ0KxQKiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/1+7EE6ZwwoGEGZeuHltn2HLXQbT9chhV7ECxdYgNf8=;
 b=TkYhPTC93ZXbQBm2laKGygymGkQ5AhAFxBHF5uam8K2mTUNGvDc2FrC+Dc3hJfCN0lsQsD6qhY3Ab6eKs7nIDJFP49j+2PQRdYUG6M6m5QgHBMoZyGdxYRYm83BkLn8WpNeQSBoWCq3uuKrRiIp7GHocgcNB63XwihH3fBiN39bbHRzcac2qaT4ZV8sPd+9EHF5PfvMoUdWicSfiFdkK4jygIKqcE/ABZB8pTrTZeFaNtF7ohWfTfClXE4JwddylZkPe+hehxzgGe6DtctmYpDcn+viVHmGaSL7v7p7q/pwgty+6yH1cAJVDEt4h09eZpgmh8FvK36zGT11F2IfvWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by DS0PR11MB8069.namprd11.prod.outlook.com (2603:10b6:8:12c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.42; Tue, 1 Aug
 2023 03:58:51 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::b556:42c4:772f:d47e]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::b556:42c4:772f:d47e%7]) with mapi id 15.20.6609.032; Tue, 1 Aug 2023
 03:58:51 +0000
From:   "Liu, Yi L" <yi.l.liu@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     "Tian, Kevin" <kevin.tian@intel.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
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
Subject: RE: [PATCH v4 2/4] iommu: Add new iommu op to get iommu hardware
 information
Thread-Topic: [PATCH v4 2/4] iommu: Add new iommu op to get iommu hardware
 information
Thread-Index: AQHZvh38uw2j1Ty0jkmb0/Y/kPed8q/NQ+CAgABxL4CABeBmMIAAWOiAgADotQA=
Date:   Tue, 1 Aug 2023 03:58:50 +0000
Message-ID: <DS0PR11MB75295BB6AE592AA6625C9F13C30AA@DS0PR11MB7529.namprd11.prod.outlook.com>
References: <20230724105936.107042-1-yi.l.liu@intel.com>
 <20230724105936.107042-3-yi.l.liu@intel.com>
 <BN9PR11MB527625066E23A1C4968905D68C01A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZMKCd5S9VpNGf631@nvidia.com>
 <DS0PR11MB7529F6D703B42835B0F8A92FC305A@DS0PR11MB7529.namprd11.prod.outlook.com>
 <ZMe7B8s1tzLsZmIz@nvidia.com>
In-Reply-To: <ZMe7B8s1tzLsZmIz@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB7529:EE_|DS0PR11MB8069:EE_
x-ms-office365-filtering-correlation-id: 2891c3fb-96ff-401f-03c7-08db92439dc2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: h6D5VVNRMTuFu7D5wWSVARQFfB9JJgCnLR/2Sl408YUu2jh2hBBJUEN7sMN3pVitNWmBR30J2kSoTOACvFFX/7d5X91MOE9Lc7gAUpaw20YFkxS7bcTNsnfe2BHlQib5Njx+b15lAyT+2VcHjXHZSVwrWNu1QTk/rxfn+/yWkKT4xuv/d+bVe5lVvmRfpZ5hi59pGyD7/QkfdClHQgm3Pdy9nf25o/Bxyk340C1EU+esoAXta38XMJaQMxpusWEEyERRAOQtxj3ezbPijZF2kjXBJEsGLbX+Gx9zQPTm0PVeyCmfp5SFIjVpdYOtdmUgR7tVh0YB5/zjsA65wGgZ2CmhO7zPBBxNCy7mWT9r4yxKQSuhPlKHtjKFpsMtOqPh9QexW9IpEvZNBWrn9vFXQmawVMquoFKMDzmCuxOKqN8hhOwE4PlinCBlmH6l+JgGFXq+h/BUq/3bjeuhkWs6TPJEJF9VdYrLbO7dLvmqwRZC+gndaPU92ktH/NQby+3gBsSN1EsRyoeIaZEr2dpFBZW6K9xNntu1aQLGqD/n2IfydGAf7w/sdhdYydx/WT/EOojjVDeAKEkIEdNuh9wFq0Y9Nav0TRA55Bamvx/Dbln+hnTLGuLfz8ja8QfUCP+M7Ok4GcOcKeau1noKb9s+hg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(366004)(39860400002)(376002)(136003)(396003)(451199021)(966005)(9686003)(7696005)(55016003)(6506007)(26005)(83380400001)(186003)(76116006)(33656002)(66946007)(52536014)(66556008)(7416002)(54906003)(122000001)(82960400001)(38070700005)(41300700001)(38100700002)(86362001)(66476007)(316002)(5660300002)(66446008)(6916009)(4326008)(8676002)(8936002)(64756008)(2906002)(71200400001)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?jlnHFBTouHptFqwlK4vEWsfKztoHbIttJIwa7XzEAE3njv6lwyxKITQsFU3Q?=
 =?us-ascii?Q?mTg9NZR5cwucLAm+t9GSS8LVlnnvglUr61zp6kGj5+Ik07MNX5vvAGvoF4US?=
 =?us-ascii?Q?wtDtrsSDY9XUYLbS7VJTaqUJYJfrhSP8ftQqrFZzEyNw0lJselsZP6gn8j8R?=
 =?us-ascii?Q?QOg7CTT8tOS6sG+pnyr2UibKnJ0WeFlRCu2cgaoXU+qvjK/CU/Y4Y0T91bKi?=
 =?us-ascii?Q?syZgjBkfu/E4zqw2bigMv0AwmrDIG2F3tCEzCvqMv0fQdploSqr5Z0Xtcn3B?=
 =?us-ascii?Q?KIcjEUUMPhopNzGHgYoBMrVDk0GIRwHvh+QISXXpEEbfMIDypgMI3hTdFopP?=
 =?us-ascii?Q?ZC8yNnh6tkWJM7VPucV5YjmrcIcPUm/WXeFSYDUM+iz8Nb+oB0aMiGV9Y7KW?=
 =?us-ascii?Q?xM0pPGFaeZAbRxKf6lSkb8nzIKi3KETy/XtLVCSQQSNnNJrqcMSDRzC8K66W?=
 =?us-ascii?Q?xN4OXNGnKM346HRy9QiD/4r4LWGd8AluqRfs4EB3t9tmIZicaGw7B9Gfwzx9?=
 =?us-ascii?Q?qRghvzETRo0bKDTFc1GBWSJ9c1xs0HgunGr28v+qJzMUF9Y3R7SWMqHo/DZe?=
 =?us-ascii?Q?cgwmlNT+3pAqltz8nmJHpY/nZyLjNAAGQSuFPZT/4M2kG5l4SSErH5QPpJPM?=
 =?us-ascii?Q?+Nw4qx7PPy920GTwpURnfcHL27JQwwKhsWxlp3xjBrTDErA+8ga4rFn9Nmjw?=
 =?us-ascii?Q?E6Ue3XVIm8JJJKdJJOK1/2tXyECtvD9r7IO9OHhMSs+nU+usAzo3YTNkZmM5?=
 =?us-ascii?Q?r1IEBd2jhOPopTWzDNNm74IAHdksUY15p8MGN2gwJyzMvGWMXWPdPddLxYzu?=
 =?us-ascii?Q?Mt9Hxgs47pZJcikv123RShZfkq8eWsI4np6MU/h1ynM2iZ8lPNav7JcKKpD/?=
 =?us-ascii?Q?KnW+MLzmtb+Sh1y0G4W0nFk1tKR11Td4MP18Si/cdTmO2X4SK8d9nWB6sJfh?=
 =?us-ascii?Q?VmoccBQPTKBj6iASgIL1ncRcR60ICq2fJKLPJPc93/mD9d/sh8t+K89G6rT7?=
 =?us-ascii?Q?cVE8xXRqqs3rfsMbSgDCl5gNMWEIXS9380c/o03g13HjlXZqpbSCBtTgPKP7?=
 =?us-ascii?Q?OYhpAEUhAwrzRy2Tq1ZQVeo9vFlG5RDk2+FTxclujEB9irjSCSOMYv7gwvs2?=
 =?us-ascii?Q?L/3IvYqALP4Hn4oi5KhuUdp6g9P7v2PXGSruXy7kSaITJJjxBnNsyVLdXNyL?=
 =?us-ascii?Q?VegGKLxe+mrT72MSGsMY71D3VmtrMhAVpc59i5I3HcYywVJCOcMn62BQm8oM?=
 =?us-ascii?Q?1hUwJi1u0PW1rXvkQ6VVXN3QjT6WoXSw8PQwmq4VtC3QqQLhjnsN9ieeQGO0?=
 =?us-ascii?Q?GPSlRBembCFYO9tQjoaz4R+OCkyhtoe38Z4m5e92saVF641Ddoiexdh0zFYc?=
 =?us-ascii?Q?PQVw1EoX5pBd+CyWaddRsVkizNB63lQr5/wrSRZWhrIb6Zk/TE9GfcktIvVO?=
 =?us-ascii?Q?IzuBmIe2zBfysJwYh2OzIDfDPRn9UKFuEDV5xuDV8GEMT79CskyjDM8J4qI2?=
 =?us-ascii?Q?PneuJnwdNS2S4Gbqi9rWdsFgSxIJ0FahVoWU8BBGOA6vGHiU/+yY3T6nIXNO?=
 =?us-ascii?Q?LcE3XNHWmpV/ZndnSxc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2891c3fb-96ff-401f-03c7-08db92439dc2
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2023 03:58:51.0088
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tSgZzTI4kpBWO7wh569P/DiZwD5BXopfB/paNJ2wWiL/QFW1S1t1Phqc7jv/4SW19Jhv6j7qfHI+dfIQc+3jzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8069
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

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Monday, July 31, 2023 9:46 PM
>=20
> On Mon, Jul 31, 2023 at 08:33:55AM +0000, Liu, Yi L wrote:
> > > From: Jason Gunthorpe <jgg@nvidia.com>
> > > Sent: Thursday, July 27, 2023 10:43 PM
> > >
> > > On Thu, Jul 27, 2023 at 07:57:57AM +0000, Tian, Kevin wrote:
> > > > > From: Liu, Yi L <yi.l.liu@intel.com>
> > > > > Sent: Monday, July 24, 2023 7:00 PM
> > > > >
> > > > > @@ -252,11 +258,20 @@ struct iommu_iotlb_gather {
> > > > >   * @remove_dev_pasid: Remove any translation configurations of a=
 specific
> > > > >   *                    pasid, so that any DMA transactions with t=
his pasid
> > > > >   *                    will be blocked by the hardware.
> > > > > + * @hw_info_type: One of enum iommu_hw_info_type defined in
> > > > > + *                include/uapi/linux/iommufd.h. It is used to ta=
g the type
> > > > > + *                of data returned by .hw_info callback. The dri=
vers that
> > > > > + *                support .hw_info callback should define a uniq=
ue type
> > > > > + *                in include/uapi/linux/iommufd.h. For the drive=
rs that do
> > > > > + *                not implement .hw_info callback, this field is
> > > > > + *                IOMMU_HW_INFO_TYPE_NONE which is 0. Hence, suc=
h drivers
> > > > > + *                do not need to care this field.
> > > >
> > > > every time looking at this field the same question came out why it =
is required
> > > > (and looks I forgot your previous response).
> > > >
> >
> > The major reason is that not every driver implements the hw_info
> > callback.
> >
> > > > e.g. why cannot the type be returned in @hw_info():
> > > >
> > > > 	void *(*hw_info)(struct device *dev, u32 *length, int *type);
> > >
> > > u32 *type
> > >
> > > > NULL callback implies IOMMU_HW_INFO_TYPE_NONE.
> > >
> > > If every one of these queries has its own type it makes sense
> > >
> > > Though, is it not possible that we can have a type for the entire
> > > driver?
> >
> > Not quite sure if I got your point. Is it acceptable to define the
> > callabck in the current version? or Kevin's suggestion makes
> > more sense?
>=20
> I'm trying to remember if there is a reason we need unique types for
> the domain and the invalidation or if we can get bye with a single
> type just for the whole iommu driver.

I see. Seems like your comment is more related to the below patches.

https://lore.kernel.org/linux-iommu/20230724110406.107212-2-yi.l.liu@intel.=
com/
https://lore.kernel.org/linux-iommu/20230724110406.107212-10-yi.l.liu@intel=
.com/
https://lore.kernel.org/linux-iommu/20230724111335.107427-2-yi.l.liu@intel.=
com/
https://lore.kernel.org/linux-iommu/20230724111335.107427-8-yi.l.liu@intel.=
com/

I think we unique types fort the domain and invalidation.
E.g. IOMMU_HWPT_TYPE_VTD_S1. The reason is that different vendors have
different stage1 format, and require different user parameters to allocate.
So needs to define unique types.

> I suppose if we ever want to to "virtio-iommu invalidation" we'd want
> to use a new type for it?

Yes. needed in the domain allocation path as well. IIRC, there was a
discussion on whether have a general cache invalidation data structure
or not[1], and the conclusion was to have separate invalidation data
structures instead of a generic structure for all types of stage1 page tabl=
es.

[1] https://lore.kernel.org/linux-iommu/20230309134217.GA1673607@myrica/

Regards,
Yi Liu
