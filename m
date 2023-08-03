Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29D7676DE98
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Aug 2023 04:56:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230195AbjHCC4c (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 2 Aug 2023 22:56:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233788AbjHCC43 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 2 Aug 2023 22:56:29 -0400
Received: from mgamail.intel.com (unknown [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C76119B9;
        Wed,  2 Aug 2023 19:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691031386; x=1722567386;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=wGuVodoFhYtyB1Bmchndvucd9XeL7RDD+8Q6GjZnnRA=;
  b=CeStGnV7Zi83GVV+M/E+DrJB/YDRsLwkAa3davndZjCXmowqMdbrKGg9
   RSx2oNq9J/q5CTdlbeXO/JXo/FCHdm9LMX/yeF0DJ6CoSj2zd9h7Yzmp/
   vMzfIQVlOGd/MtzGY1nePmz/i47AXynbyl1dNIdLsnrUE+xdhsAYX0dr+
   ngIEtKycAP3Ln29Hrd0y52BoIDoXVx7UNosveBFZQloU0r0wqom2u+w0V
   l5P+7fQV5JxVMv9YWC1JVOihL5uosrnqfdOXokfcP4iwcbwjRuXkhSidG
   rMk2dU7J1R7KC3gGiKzTcKPtjoqpOkzpq7glxtkWg2wiomY4h4667UWZE
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10790"; a="372490578"
X-IronPort-AV: E=Sophos;i="6.01,250,1684825200"; 
   d="scan'208";a="372490578"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2023 19:56:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10790"; a="706385852"
X-IronPort-AV: E=Sophos;i="6.01,250,1684825200"; 
   d="scan'208";a="706385852"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga006.jf.intel.com with ESMTP; 02 Aug 2023 19:56:24 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 2 Aug 2023 19:56:24 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 2 Aug 2023 19:56:24 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 2 Aug 2023 19:56:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T/AQnqA20yqH2fDZJ1H5Wl8Lpd1X9hBdsEHE/GgXiqL+NX/DEA+Mb2IjXqVsDHcR5snO7894LCVXxyBdlj3gLIMZnNcMQtMFiJfa4plDhAZg0q/p1fQ9CjCvSbags1mfeyWBWw3dGUXZw7aPOJOjHqMqyRRg1a1AvMj5THpendbKmNSPvYJ4cEylqXi9/Gg99GXo74BrjV4/gwyj6asoQ9oV9R7ed7WWfVA1WN2o6pz70jhhyoXilZLy5bKcgohbsCVNbfFDKlvvvSLhZdpBOsze1pvfdUQXbgZdnB4JSivWUMxxMO2Ik9nVmeB7QNRpTbjyH8yNsU7uKPS+I5ybLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vTY/RPIM8debl3FyKqOraauJ5NZeGokNvZYeORonFGk=;
 b=oO+dTR7WeGcOXip9S7yF7avSv1Na4JDu/fl5kG5RmYnQufu6lMm6gKyxHNX36RW18CFOvYL8qBB/j11HNLUVworPettt9SNS5K4p1BHfAnjG5aPIx2oshG4AQLuVrxy5oPlVWV+AUWqHaA8Mo6x9jIw+75/wgfxFvMq/NpCJWBSeHlCpGKqSDKrMfmA0ohhcTkWCMWa1jYDW0v4IZpcWbu1ObPK7KP0jf54We9+MIWrYH5gikH70zypgNPSrVD0Z5C/fFGSo4I/9+u/qLKS/IEzeOrhyF6NLrzoAvtldnol2sm2nCwcOLtWWjxWKzdKM1/inu1GXnVAydJY35hlKnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by PH7PR11MB8504.namprd11.prod.outlook.com (2603:10b6:510:2fe::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.44; Thu, 3 Aug
 2023 02:56:22 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::b556:42c4:772f:d47e]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::b556:42c4:772f:d47e%7]) with mapi id 15.20.6609.032; Thu, 3 Aug 2023
 02:56:22 +0000
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
Thread-Index: AQHZvh6oi+POLB7tyEyJT6RvyneQWq/PfyuAgAQvXCCAADhpgIACzE8w
Date:   Thu, 3 Aug 2023 02:56:22 +0000
Message-ID: <DS0PR11MB75299A86DAD5030BC88C8CC3C308A@DS0PR11MB7529.namprd11.prod.outlook.com>
References: <20230724110406.107212-1-yi.l.liu@intel.com>
 <20230724110406.107212-10-yi.l.liu@intel.com> <ZMQCw2iiIqa4CXNG@nvidia.com>
 <DS0PR11MB7529696366A4447EF0945E87C305A@DS0PR11MB7529.namprd11.prod.outlook.com>
 <ZMe0zQ/29/gLGBwZ@nvidia.com>
In-Reply-To: <ZMe0zQ/29/gLGBwZ@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB7529:EE_|PH7PR11MB8504:EE_
x-ms-office365-filtering-correlation-id: 584e4785-bf89-4fff-141d-08db93cd385d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: phZP9Z+8G6pRLQfqieU/+O9C8Na/7DPJ8iPqfUXt4Wn3ZpAXaYZ7GC4iNz+h9vx0U1f7YR8lSKvo1CuEYDHKG4Prc9DCIkZEEbLQjDL6VlTQDdVaXV4GLSOIOwiyezDN4U0oH6o4xb9F9Yf8fw5B6g3t71TYf64fJzjLKsfqemJCI9iF3lMT2tvceYKGVc7CjXoo4lb1pt6kviqH6iSAkM0fe2+e3p3VxHu/f/MbJw/h/Xs57gRqNbykr0ckAKw9a7PtL7kD1E0ogzveAyfy46nnRWSPG7/yeaHfCITJQwJ7rA/cNNkHme+pxJ3HsX/H0JsTaLkD6V8jos5VBRZeqG2OLEwdafb8sBBkRqzah2tNP+qy9n3aMQ1NSCw8RmtJ5Pyz/FkGB6k5oSJdiR3PCz+yAKFchQzGPl6KTvLHMt9Gqx94oP4ZToGKS3hHdtp9xvCxLmuhhv9pMV+yb+SInGtcnBHL2WvDy7Tj8dErpQsqjgjYbyA8PczkIeNRHK0hPiGSAVRnxjnPgToK+vYj2QdQv8TLrBjCQUrX7TbtuCVssa7dI3sbGqh1YKE9TGDwyVwmSu3g43iD5gV2V5Fu61GtG8+kpY2peqRSjkfLzRLzEDVRU74tBHV6+VaTEJHPnh5h3Z+XfSmTAoSb2U3f9g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(39860400002)(376002)(366004)(346002)(136003)(451199021)(52536014)(5660300002)(7416002)(76116006)(66946007)(66446008)(66476007)(66556008)(6916009)(64756008)(4326008)(2906002)(316002)(41300700001)(54906003)(8676002)(8936002)(82960400001)(478600001)(86362001)(9686003)(38070700005)(38100700002)(71200400001)(7696005)(966005)(6506007)(26005)(33656002)(122000001)(55016003)(186003)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?KmcgMXd0TME1YY5bc9rY+rMkZzU+jlelBuVumFJeSDPwZS4T/5hZtGaWI8HA?=
 =?us-ascii?Q?boVt++ZfXYJSYDf0dE0x4H5PfdBz9+lleQI2gcls2qyRKjgUQVIyFNiio3KJ?=
 =?us-ascii?Q?yD6va8wEXLQ6voyvjfc7WBO8U3hAdWUhfnaEi7gDIJO4s+Ne7T4cbNpyLbki?=
 =?us-ascii?Q?6RANwWLaRxq6eIgGPExSuXRw5xy/ts2P0r25G5+5l7dD7VZdqN8rAPp3pFpS?=
 =?us-ascii?Q?W1OkljaVQuOcXEv9XpG375iTAeNs1rS/ftJp9l5PzU5Bh0mUtpqzee7Le+qr?=
 =?us-ascii?Q?X/u8iSB6Sdep63+odvov+MFOvFTevtMHMBPgzP1md98+sSDgz7htYCI0jwcp?=
 =?us-ascii?Q?InFDJgrUoWXdWqhI3KpbIsZdrf7EfXCS0d7V8+F1W8NH7sub3qi4rPDmBQii?=
 =?us-ascii?Q?Y5IsWWYYoibdzFp8SmWl/JXtS/35kaGrrZH/wVXAGzfMKGuQobf46V7v2pPm?=
 =?us-ascii?Q?CIvYzPufrIvNIE0i9yJPbpBQHAP3OEexHJbl3OhEIr7A8I1t0obYu4c1VVdI?=
 =?us-ascii?Q?UgAeyGjn7pzQqV3mAtM4r9ETBjjrA3uFOC1XI/GpOsaqw8+n5ebus/b8rw6r?=
 =?us-ascii?Q?o9zORjtrEidZA+4u9/+J0kJR62ejWKDTTGgMsfMImdMgP6c9mvIp/3rKsuuP?=
 =?us-ascii?Q?aP0sEs6TQtTzK88INbKvrDCDI1GaXguPeZTazeddhkqOAmssEFU36hThQSma?=
 =?us-ascii?Q?ojxO6LvO+fXsvNFJmsvF61BSxutQbNKj1bwHKHaHj9I20kAQJkaoXc7DsTka?=
 =?us-ascii?Q?3J0C4/p34cDgiFWWTJHN7ZsYap2Zgs+Y1Gpsx/rR2+LHbMDsdA8gK9GaD4tc?=
 =?us-ascii?Q?TJttydlUnmA6LWyRD3sYi+y5ZiFd0FMwGJvR+OtSDyR3eQqyQzUeoeIyYj8e?=
 =?us-ascii?Q?PYMYsO35oudFOkfq8nSjQ81HrgjIye2Ctr83UX/bozlm5+32zL63kC6lAh+s?=
 =?us-ascii?Q?u4P99vwIZS1zUAW4x6+eC9PK8Pc4a4Is11Otv5v9CCwH0cTA+Jp7k8h6Dk+O?=
 =?us-ascii?Q?PvmDrIlrvZLFauTbkeZsiJh/XZSWPgq22WaIFqeq2qV/JwgHygz/GqT1u3Qk?=
 =?us-ascii?Q?dmQhiRHWmTw1zv12it0hqB/NEL6H+7r8If3enZ5+BOjnoeSxfdU1Ogt5fnQn?=
 =?us-ascii?Q?Mb4pRaCXtwfXgXiRBJ07cb5wm9/6t6lHtYkMgbL/BeNxxJN1yoBpmvmsEl55?=
 =?us-ascii?Q?SQriPTqQ5Rxv8kdBGoUq9ekAXummjf760BtTPhUhDfN81U2GhyJcqbz802KG?=
 =?us-ascii?Q?op2VLSE5qs4W3RCSceWLo8rhE+pDm/LDIb9ULnBlMISp2GbwiPB8N3zu+ola?=
 =?us-ascii?Q?eDFuyBmqcLpepUoHnu2qCJbV8UmTIlj3o/J+gL4OJRDcCo5CCNAHh5axzGxn?=
 =?us-ascii?Q?UdoxqgvynKXHMYLI8TdEORs+CBroHr8ADLPCNOnkwJq93E8XSwBUPvF/B8jH?=
 =?us-ascii?Q?19n9QPDtPP/6gCQYt7cLCKIfAX0/jrcCBhmulQksRneSxxMZ2VR6q7o27HdN?=
 =?us-ascii?Q?tFpEkA3tEVQWeIxkVw+U4kqLh0AIUaa6UZ4E080vCnsj0NMc2HDLT1N2h5Mc?=
 =?us-ascii?Q?MVRumFfnGqVKe22t2+M=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 584e4785-bf89-4fff-141d-08db93cd385d
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Aug 2023 02:56:22.5817
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EWvD5UN8xyHzKbqWJVWhuaeS8Y1LLo9ZdA7Re3qJ+r65z+Tnw5X89MkBSirswAYc6GviwOnkTghgU504zS0CTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8504
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Monday, July 31, 2023 9:19 PM
>=20
> On Mon, Jul 31, 2023 at 10:07:32AM +0000, Liu, Yi L wrote:
> > > > +		goto out_put_hwpt;
> > > > +	}
> > > > +
> > > > +	/*
> > > > +	 * Copy the needed fields before reusing the ucmd buffer, this
> > > > +	 * avoids memory allocation in this path.
> > > > +	 */
> > > > +	user_ptr =3D cmd->data_uptr;
> > > > +	user_data_len =3D cmd->data_len;
> > >
> > > Uhh, who checks that klen < the temporary stack struct?
> >
> > Take vtd as an example. The invalidate structure is struct
> iommu_hwpt_vtd_s1_invalidate[1].
> > The klen is sizeof(struct iommu_hwpt_vtd_s1_invalidate)[2].
> iommu_hwpt_vtd_s1_invalidate
> > is also placed in the temporary stack struct (actually it is a union)[1=
]. So the klen should
> > be <=3D temporary stack.
>=20
> Ohh, I think I would add a few comments noting that the invalidate
> structs need to be added to that union. Easy to miss.

Sure. Actually, there are some description as below in patch [1]. Would
add some as well here.

"Cache invalidation path is performance path, so it's better to avoid
memory allocation in such path. To achieve it, this path reuses the
ucmd_buffer to copy user data. So the new data structures are added in
the ucmd_buffer union to avoid overflow."

[1] https://lore.kernel.org/linux-iommu/20230724111335.107427-8-yi.l.liu@in=
tel.com/

> > It's not so explicit though. Perhaps worth to have a check like below i=
n this patch?
> >
> > if (unlikely(klen > sizeof(union ucmd_buffer)))
> > 	return -EINVAL;
>=20
> Yes, stick this in the domain allocate path with a WARN_ON. The driver
> is broken to allocate a domain with an invalid size.

Ok. so if any mistake on the data structure, the allocation fails in the fi=
rst place.

Regards,
Yi Liu
