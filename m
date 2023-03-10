Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1188E6B3825
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Mar 2023 09:08:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230296AbjCJIIq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 10 Mar 2023 03:08:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230303AbjCJIIe (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 10 Mar 2023 03:08:34 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1746412BD1;
        Fri, 10 Mar 2023 00:07:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678435678; x=1709971678;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=1v/jcpqlJUijiHjDPfflLeSh+UEicZ9U43BduHZVWrc=;
  b=TaIV6BFySftMUpZBbq4GsOXlU7RU5n+BFSkIDpYiJdPwdwfW/tvJV2dZ
   qaCmCXIEVakEEqVh7Q7lhcZCYKXZcw2TpC7BeQ/faxaoAbm19mFiBNCc6
   b54daDMlWdqaswq7Fi7cGsjm+6tFpvdmW03Kx5LDuKQ3mWrs9u6iv7yle
   bUHcp6cRRW5L4DyC9CWoMO+4ZrIPbbnVmaM2/WC8S82aWjhyObJDhGNyg
   9IqKs3Wt9WlSlkSavCW8eOgqhh8H35Jg2+DE5akCRQMQkG6fa8rvOVGlY
   mJ9UtvukUpxuJ3frNa5ySWiNS275kC1Js+VMeMdSLqC25kB80nbOpeFBn
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10644"; a="364329697"
X-IronPort-AV: E=Sophos;i="5.98,249,1673942400"; 
   d="scan'208";a="364329697"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2023 00:07:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10644"; a="671005557"
X-IronPort-AV: E=Sophos;i="5.98,249,1673942400"; 
   d="scan'208";a="671005557"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga007.jf.intel.com with ESMTP; 10 Mar 2023 00:06:49 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 10 Mar 2023 00:06:49 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Fri, 10 Mar 2023 00:06:49 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.105)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Fri, 10 Mar 2023 00:06:48 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZVGplVy/Nr3drCgh60+lr+smqxjHVyh9CDOUzg2VY0Gin8A913Aj/LmY2PC817YM0GMo/t9nqA+4RhLjOUL9N9066/9QlqYbPOBel/s9tGWZAH8jv0ibEfRed6towhgj5OJ8Pp2tXDhl2z96CH8tel4uwjhzDz09RA2GKsGU/H5F3zeINFckc1IZwABEOmSlMto5UWxxBtRlvorUQ2LQAr5GwVsUKT5xR2hRInEBrlPBiIhzpA45OX1yKWEWwF+4wr/fLKPXF/9TlYhfxWJ8XvKn2n7CWN8XhOMMWisrc3ZAEu/b0CbrgHxtLUAbHjEqRu3LrGw1C8yof9KVQ3vIwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mNm5hvpbiaZ1BYBFFhbh5BRqksWS+n409mQIHXOxPrw=;
 b=nKeXr3WZjW78nsYNTLrYdJTqAWWf8P1QE4InMbF/fiFjsabrrzEsW2XeevXp+QNVXyd98+pfL1Cv3wovoECpJH9z5/JiBwoSU8Z8h/B1SQ8KPgQHPoa81Aq0/uRIWYKUK7swaIIEmptPpDZRYDt55TcztZgNed5If+PgxtblUJ/lay0hsrjj1w+1/zqHrKliWuweYI8iaaQC/+51AhaU7HIDweFmRb0BlpDZNp3P888eU0i9rB+CJOdR8KEP/7U12qq45Qwkk5I3sPegVSiDLKy78UJWrJb6GJ348Dv+tTTFTHEARBssnsHdUbz1yl1mSAPLlSzDzYwTKoYj5wj0Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by DS0PR11MB6422.namprd11.prod.outlook.com (2603:10b6:8:c6::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28; Fri, 10 Mar
 2023 08:06:46 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::6f7:944a:aaad:301f]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::6f7:944a:aaad:301f%8]) with mapi id 15.20.6178.019; Fri, 10 Mar 2023
 08:06:46 +0000
From:   "Liu, Yi L" <yi.l.liu@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Baolu Lu <baolu.lu@linux.intel.com>
CC:     "joro@8bytes.org" <joro@8bytes.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
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
Subject: RE: [PATCH v2 3/4] iommufd: Add IOMMU_DEVICE_GET_HW_INFO
Thread-Topic: [PATCH v2 3/4] iommufd: Add IOMMU_DEVICE_GET_HW_INFO
Thread-Index: AQHZUlxVx+4zLu+vX0G6zMa5rtiTvq7yd3EAgAA63ACAAPc3gA==
Date:   Fri, 10 Mar 2023 08:06:46 +0000
Message-ID: <DS0PR11MB75292ED5DC2BE338E1B4A078C3BA9@DS0PR11MB7529.namprd11.prod.outlook.com>
References: <20230309075358.571567-1-yi.l.liu@intel.com>
 <20230309075358.571567-4-yi.l.liu@intel.com>
 <6c1b221e-df8d-4b82-10e5-aa3027819d45@linux.intel.com>
 <ZAoVemZoGpx16P9E@nvidia.com>
In-Reply-To: <ZAoVemZoGpx16P9E@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB7529:EE_|DS0PR11MB6422:EE_
x-ms-office365-filtering-correlation-id: b784d607-d58e-4722-f629-08db213e64cf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5umBm/KNC8Sz83At7MRROgh2wt9CcPFFMo/pC/91y5GadC05gXZuXStbkTpjBvptE7U6/sANZ/1e+UnthHIYu/GCBjFNKrhED7Yjr0UBiy8Z1igNjqs4g36gumLOHHu01bGfbFLxyLkVXK1jylrEBp9c48eBPQiKPfXWc/NQbslwAS3IHRYYUHQThHXt7gMAe0V5mHHIsd1hYvg4CLlA+5PQHxyDhFrYW02G1/2+GivK5uMRN7K7R/Q/se4fQCaLEFtU0otj310zDvzYICJu4xO3rbQ7lrlOf4oBtbTLRo+MW/Et6Y9kVnq+LIWP8HG1c2NkQiiQbF6xwIVkmCK8fWn2+VMc130eL7wbZkCSdwfP3BSoYPn1jV3vmHqOvnEzXmqpbtGTN3aoD0evvFSvmCghFl9JK88lZUW7MQCZEOb+EBVObhBihyoR4livQmT0kjg6E36LjEqyXwFHgH5yN9A58t9Stl9MEYRsDGBKhNzr+8UXJkWD/3HNaCeKencmYaktWTkfFjtm9C43288JHOqvT59eoeXiW+RPq7NVUIdvoW0Ht0p/haprHN915b7w2JOpkPBTSF+UwaXB4n84UKGQph/swoEzKUZ5wcjoY/wCmNxPiA8V1lappfs20xEAB5CVfq4A9XPrUNCZlghn3cIdyibsqFybhwotO0FUn+xgpAJvTTt3WUilsqKjNusYpQYYHAKYpJSatcAcnW4bneD2fRBQ0XWZjr+4PaFk2lo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(346002)(376002)(366004)(136003)(396003)(451199018)(316002)(33656002)(54906003)(110136005)(86362001)(55016003)(9686003)(4744005)(186003)(64756008)(41300700001)(82960400001)(26005)(5660300002)(4326008)(66476007)(2906002)(66556008)(7696005)(478600001)(6506007)(7416002)(66946007)(8676002)(8936002)(71200400001)(76116006)(38100700002)(122000001)(52536014)(38070700005)(66446008)(13296009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?0vx665uWr2RqPpkYy5gNOwVUJ7gpJipqFWjDsEWX3HrsqAghA0JPwkWPiWL0?=
 =?us-ascii?Q?2jTHncO9NrE7etXt7ohReUw7ILWPu5jY1FPBqtYNgyTJplw5ZB6uyMwpjNIv?=
 =?us-ascii?Q?YA5ujCKkn2hRagZqpSsT/+y0KCsx6zUdqG/U2UAwYfIXzADwSCYZtJswpIt6?=
 =?us-ascii?Q?DqlYjcvgaU0FrYZVVePICPybrLMqsD30DC0i7bqBm4iBIcA3XV1/JLNjJS8q?=
 =?us-ascii?Q?IY1sk1kMPsnKNvtrbmFQvr3ZMf648GQJNt0rrJCuhB+sJ3Xne7X3Xw3M4G8b?=
 =?us-ascii?Q?5bLkjfOh3rR/9KPFUjiGvocvD9tCAyDUBue898AWm1TLX/7eR3SiAQXIJZ3n?=
 =?us-ascii?Q?BSXsrbVt6KzdAQ+kaGq5BWyomXA5NDEzC/S7vLeF95U1Sch/Mt8lcriSBcE/?=
 =?us-ascii?Q?Ptl6uiY6UtbwOx3Sy+Yz3P3pQ2WKeC9u46rE7iPoQbUHtl1buIFVGlIM3FIR?=
 =?us-ascii?Q?QBKMrjWL8YAU3tTGVhcQsloNKHMdX5//55VGEXedWhhRKcOd2vsP5IK3a4kc?=
 =?us-ascii?Q?cDFf3uWdO4EzUhSdfhEvja8GgRErSbaJ9b2pH1a8aD/ziBCrX4Q5bvKiHMdf?=
 =?us-ascii?Q?iLNhoRi0Xegrf/HoRa85q68DhSu+fQ6AqksPWCg4hN8CTXJZyppItPStOEvn?=
 =?us-ascii?Q?702JqQy5xSvIuX9SwC7asTCoS/bspyc3VMoFpE7OlSVcbmlOojFZ4MIsQlE3?=
 =?us-ascii?Q?8tCyomR4DhOkBmho8R6qHh7opyFsH3iPOHo7tj/o6cLqUMnnOmMtwQoX2eTP?=
 =?us-ascii?Q?yTSUoalbpF9KxuAmWEs6UNG6ofQjzUMPuqdY1HtKpjRmMRQwkTzePelB3STJ?=
 =?us-ascii?Q?Suo7m05Zi9OwgLWkosXFXEJCp4DWz+WFrB41ys4I8U/Heh4D6f4vgqiScny6?=
 =?us-ascii?Q?Zy3XBwnubQ7ftAa7VNxXWrGNj6lQYz9sA3BjM/81u7ciLcQycGe+JX1avhxN?=
 =?us-ascii?Q?QS3dDd3f0QwqRM5ADVVpycVi1I2m2lq9W2gPopxygQ0SAd1Xu9ukmvipgotg?=
 =?us-ascii?Q?uXAa+dI/RH8gQFl6I7IgiP5aW9zatVm4K3v4w+b6wTL31DVJ2E3VWfeyAsfG?=
 =?us-ascii?Q?uaX9HXadKi6QQcf8BcZ7Yq4MfZkrcBkCX+pZLJX8b5eJRNoNScR1rCcVnA5A?=
 =?us-ascii?Q?llzwNjqVAsNrhzw5QbZo62L8SsxMknJ/yzRhPn3JrGRu6Qx6L9Vjkz5dYYN0?=
 =?us-ascii?Q?TZy3QB1tIuR5TpPEE2ap/jikKvbXt3OnlYBedWln6HeAiQxPveMdfWATyDBu?=
 =?us-ascii?Q?fsIwF8pnegk/B3mg790sromSs5Ak1w0HznYZkcZpQ+p42SCyXuOgx1Fznuht?=
 =?us-ascii?Q?wefZl3yNbhJZvYYMb0BNx+1wJNnkdsfrgy+77/giafwnWREbCF7yBYilx+Pu?=
 =?us-ascii?Q?45XpzPCWvxhBsu4DWyilsKAzdbkQZ93CaErNtHZXA8UYX2r0FY0ow9anETeX?=
 =?us-ascii?Q?g4iF6gQLuqc6DWVqH5k+UYKpQpEe3SSoYeRbksRr/RwoAa+FJ5NPTJ/zVtfG?=
 =?us-ascii?Q?HtpMqSMkVQxIOgeh8Mwnwfbxaf5D5iQv6f2ocO7QyLujzH80CXItm7qgIvY7?=
 =?us-ascii?Q?OfaQoVQKgGVtKAo+sDh8Ow3P413vGGDyJSAfKVlr?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b784d607-d58e-4722-f629-08db213e64cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2023 08:06:46.5472
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1FlEejnN2Q6hq5KBpPtkMkxZJEvoGBRnHLtCLGcJsnGnH0QsCrGG3O+4LYwf02UmiBWaHpCO/zIjGFWuqpFTxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6422
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

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Friday, March 10, 2023 1:21 AM
>=20
> On Thu, Mar 09, 2023 at 09:50:18PM +0800, Baolu Lu wrote:
>=20
> > > +	if (cmd->flags || cmd->__reserved || !cmd->data_len)
> > > +		return -EOPNOTSUPP;
> > > +
> > > +	idev =3D iommufd_get_device(ucmd, cmd->dev_id);
> > > +	if (IS_ERR(idev))
> > > +		return PTR_ERR(idev);
> > > +
> > > +	ops =3D dev_iommu_ops(idev->dev);
> > > +	if (!ops || !ops->hw_info) {
> >
> > dev_iommu_ops() will never return a NULL.
> >
> > Need below check
> >
> > 	dev->iommu && dev->iommu->iommu_dev
> >
> > before dev_iommu_ops(). Perhaps something like below?
> >
> > 	if (!dev->iommu || !dev->iommu->iommu_dev)
> > 		return -EINVAL;
>=20
> At this point the device has become owned through the ownership API,
> it absolutely has to have an iommu and an ops. No need to check
> anything.

ok. so just needs to check hw_info callback.
