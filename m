Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ACDA7755E0
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Aug 2023 10:50:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbjHIIug (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 9 Aug 2023 04:50:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbjHIIuf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 9 Aug 2023 04:50:35 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3374310C8;
        Wed,  9 Aug 2023 01:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691571035; x=1723107035;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=3U9PKV28AM3mf38ivsx19roAzxImYshZYobVDLxHSSA=;
  b=c+nVYlfp2jZYOWFfLXYB9iWCV/TfRQcpm/WxII3kLw4cYO+bjILwuKnT
   QNsk+HcPngTzv6klFmODaMasGTFr+gMtt3a+YApimYFBJP2GnOmY4dk1U
   hUOw0PmeMa8JsXJvD6Pk9OUAMunGKECsUCfs+IWOR9VoOxTtZtiKmWl1r
   BSVj8KIAxPDcjouOP90p+Z9e5DG4CcimIj2BE0vtEvKj04ZCRg9+jn2Fl
   JGCsEK/Uw0AtcA4ppHdU1dbGx4aI931erhFuJ4uOs/XAoxeCcywdyz1eF
   sZC+fKFHzGheHEBhTmFJ0aRLJEXkYk5rXWB0jmRcY0ln7TLepaTwWFBLO
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="402032832"
X-IronPort-AV: E=Sophos;i="6.01,158,1684825200"; 
   d="scan'208";a="402032832"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2023 01:50:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="821760742"
X-IronPort-AV: E=Sophos;i="6.01,158,1684825200"; 
   d="scan'208";a="821760742"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by FMSMGA003.fm.intel.com with ESMTP; 09 Aug 2023 01:50:30 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 9 Aug 2023 01:50:29 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 9 Aug 2023 01:50:29 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 9 Aug 2023 01:50:29 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.171)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 9 Aug 2023 01:50:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NYJojQyDndVRvZvErUzNFHfA2xGejKBFe6JRHiAC7k9DpFm7aZKWYz8FP0xHaOFSgFtMfw3LI16lZhmMut5z28pB7MNNt/3qJrQWCvmQxedpkRRiI0Z/GtERalwXV0z6IR61vJuE4oRlLkRZzhy/Ip2B8CLBrOWRSf/sqvFOb7Y5HRYZZxiJhgOdlvfKHQqsrPslAsuonMjQ3nmKdutJFYXMFVz/BgmX3lpZwNSUvG+AimuwuBI7QNInqj8v8LJzDx8e6X3xWKrGNR4z/kbliAdWJXCwnZ4RvZmqNgLx3BUbY5uX6wuB48AA70Gc/hLhq8Pz64PqxNn2gHiqbbsc6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v0mJaIQpBFbekzzHxtHiCZQ2W28nD6saEzoEppSo6wk=;
 b=BXfSijVpH6JlEutr1ubitGF3XBumGNwNcnebNgBdHrNcWECrVykRH+qvvpgJL1bM419ABicUE8ySuJZn4r+YFdA1GbIIpIiLzQXtJGNDwwWdL/6ZHUAD+ngUUv7OQVf63G783o5Dmh3yR5GKWIJMejYEVEer/653K1bD+Eum4c2M5qpPIy7vIyj+01BqsefIlG79c9K48YQNIUBE2HB4MTnu+Hzo3nbA01mWaXr1AxtfzTam3MgMPBMMk61l12FxecNb+Ff+OVKjUAzuOrjj+z+QRgWozLD852dYuhATbWox4XUqXcV5dWmEqlzeBDNrEzL6tQiU5L6Mn6xIJZ0rEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by SA2PR11MB4875.namprd11.prod.outlook.com (2603:10b6:806:11a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.28; Wed, 9 Aug
 2023 08:50:26 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::b556:42c4:772f:d47e]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::b556:42c4:772f:d47e%7]) with mapi id 15.20.6652.026; Wed, 9 Aug 2023
 08:50:26 +0000
From:   "Liu, Yi L" <yi.l.liu@intel.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>,
        Nicolin Chen <nicolinc@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>
CC:     "joro@8bytes.org" <joro@8bytes.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
        "cohuck@redhat.com" <cohuck@redhat.com>,
        "eric.auger@redhat.com" <eric.auger@redhat.com>,
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
Subject: RE: [PATCH v4 09/12] iommu/vt-d: Add iotlb flush for nested domain
Thread-Topic: [PATCH v4 09/12] iommu/vt-d: Add iotlb flush for nested domain
Thread-Index: AQHZvh/uqwr3PK6FO0KhG3jtetteiK/WrrGAgAhNwpCAANOqgIAAnN2AgABV8ACAAPYtAIAABp4Q
Date:   Wed, 9 Aug 2023 08:50:25 +0000
Message-ID: <DS0PR11MB7529C3646E38542457D7B75DC312A@DS0PR11MB7529.namprd11.prod.outlook.com>
References: <20230724111335.107427-1-yi.l.liu@intel.com>
 <20230724111335.107427-10-yi.l.liu@intel.com>
 <BN9PR11MB527690EBAA872A16AE8926F88C0BA@BN9PR11MB5276.namprd11.prod.outlook.com>
 <DS0PR11MB7529F4D4DABBE29E9B7BF5C9C30CA@DS0PR11MB7529.namprd11.prod.outlook.com>
 <ZNGypUee/U9d68TZ@Asurada-Nvidia> <ZNI2O4Upyna5AWDA@nvidia.com>
 <ZNJ+Uv/WJwngosjJ@Asurada-Nvidia>
 <BN9PR11MB5276BFFEC7E12EEBD4503BF08C12A@BN9PR11MB5276.namprd11.prod.outlook.com>
In-Reply-To: <BN9PR11MB5276BFFEC7E12EEBD4503BF08C12A@BN9PR11MB5276.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB7529:EE_|SA2PR11MB4875:EE_
x-ms-office365-filtering-correlation-id: 83f763ed-49db-45a2-334c-08db98b5acd5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZDoIa+7ksxC+8RlqWnQ6g6R7azVZDci9XgPn5HGxPUxR/pLaUE0feYWNf4m6vsG8xCJVeLyzBp7TKEHoy9MzwNlU/egvMIpYFi0TryFBxWF6PJlljHGw50pPBYwyjvloYQ2OF9qYF46P2lJF/qODgA5VKA3QxjE7x0vR9OJDSHwCcRW4aTmj72y6osO8dREkRYNfhPmER9ZDJpvFyXh40Uhn8scxLuk2qkEs11jIcgD0C7aou/d9ttPZh4ZDCtk+aqFc5d3UpSVxGm/nj8ptFD5lXnYUTywlfmONB7M7zV/Tvjr0qaDNWH9QqjnowJ1KRZqJnVdxae5eSbZx+8RiU1904+P7RcHH6N1o1ZfU7ZMqodrFmGQacSO7mVISYYYgZK55xinywk8KJcIpHOPsHbHpwqBj4doUwe+g41KB4jC3u+V3uHOyylE6i0H1cbDnaBBUzCUc1GQuSXLxVdLP92coMBYQ42goVkGU9U8v6j3/FQJ55T6/SYVHEpScakqQk1GOSiJVzHIlJC4L4ep3xpnpkM5a7ZIy2PZIZrkX87xC7kzLSk87rCRH65uW10prKU1UWIqEjNkdMTPwqP3PZBS0CRqiXKoRxt06DBMBj/ZN6IamK3IDbigP24zQkJbT
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(346002)(39860400002)(396003)(136003)(376002)(451199021)(1800799006)(186006)(33656002)(478600001)(71200400001)(110136005)(76116006)(66946007)(54906003)(66556008)(66476007)(66446008)(64756008)(6506007)(7696005)(9686003)(4326008)(2906002)(41300700001)(8936002)(8676002)(316002)(7416002)(122000001)(5660300002)(52536014)(38100700002)(38070700005)(86362001)(82960400001)(83380400001)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?UyhUo+7O1nxwzv95vAkduJk1lmCPAPtqeTHt1wvNFq7MCpXYBulwk+P4rExP?=
 =?us-ascii?Q?bb/HjOjejQnE3B0AF1EbkpPgACEd6P/tej2iFXP7KLyImCemm5rIiTqyjbl7?=
 =?us-ascii?Q?Qul23DfE592BBxpnaesh4YahwndJnS4x0ByuUOzqpbvW3uwyhoYwN+Lwqj6d?=
 =?us-ascii?Q?gUGKaaa37IeiY/2mjPFl1taw4tYweZ3c8OKvhRw72Z9fs4EEi1R2DQs1TBT7?=
 =?us-ascii?Q?iGr8ZGz6G4Vm4O7iYeR2GalcTK5jNfw1A2K2puRiKrZFRrfSd8VXEX7Fv65R?=
 =?us-ascii?Q?MeKUMG8joTaybE073My8g+8rJdQFdeXrc0piC+wwedXucq8wNTS5W4YFkAs8?=
 =?us-ascii?Q?5yVYltQsWe5SXV5ZUwNHTdSi9ESujXyA5HU//L6V8bxQFtBy8IbWXosp/FrK?=
 =?us-ascii?Q?r8YgxG93hwefDWf2yREah17YXPCtSi8QRbfDYO3nYcPxhuIIcRzm4KY0b0qX?=
 =?us-ascii?Q?CYXyRz7OStQIcrStSIw0TpOWFRVVxZcM0Hl5NreIy9G2qQ+BuJ1Kdi1M3Eog?=
 =?us-ascii?Q?kSId0btXIagFLepk4W5hEWCT1S6xuHkWKii6hFY01AGXhPC7rjTUXERehq4E?=
 =?us-ascii?Q?RItMueUUD2fXx8ICNUWkMZIzLsqQoi1tIeKfJyVaWGa3p4BpntzI/kVKANHA?=
 =?us-ascii?Q?VTXQt7OtVAkhkEP5ea629fl2cKx1wek24sW47Mfgy+lXVTT2yVKWrQj4NKji?=
 =?us-ascii?Q?UNwGreXNlF54RkqHwiVN/qUS3b3zzIleNpORDmCmOjGyCaU4BbW+6v5H3YLB?=
 =?us-ascii?Q?igp7eLmn7cqODscd71hGo8vLkJcN7DdyokFDO2hQzsu9L+mAczjedCZdMeyt?=
 =?us-ascii?Q?aWy3NcawB5Y3H7ABNQeNnyfZm+cNwN9lOnpgtqzG7/jcdIUjXS6E+jxGVxwb?=
 =?us-ascii?Q?uN0kTaJUENs0SL+4zthoq6UelwhaaHVAO6L2I5OzJi7IxTQ8teBf1w0tsPjA?=
 =?us-ascii?Q?UbDipsoy/06Bd6DvkKd0drDf6cVJ/m9n4tVjhOn0LzrZJw/eEXUklVRHFCJD?=
 =?us-ascii?Q?PR5/D8EOfx06N8yOoXo80a3a8u1dEqBERXVN2UKiJD7tHD7Obx25m6rQXIjT?=
 =?us-ascii?Q?2Fid1xikuQAGG3DR7CMtk6sKlOvQJ4q3FlIvZLfnORR10P8J+AXwdol1Cy1i?=
 =?us-ascii?Q?+RtKT1CEZbvM3r/nEsvB679D5lY6JhhtPzpxKW1iNtZZNsXO4vGCG5Dg13Fj?=
 =?us-ascii?Q?l97RAOAs5MHN2Kwo19rUQ5R7ac8tH6qlkPlS/mqy1Evbbhx45wNDJ/G1qdAU?=
 =?us-ascii?Q?4Azbo6TBcqlfSkMnv0RwLJXYajtakNQq0WwZuIuXeFnl44Vd8Tfm9NWjZ43c?=
 =?us-ascii?Q?iyF1etF6aZvl+It59UwApnnvhRLLcOFOkBv5KpqWk+V3+Ukx31JVf+LmuY7/?=
 =?us-ascii?Q?jK5uX79YmJM2P631YyE7k+5DhVCd3jfm+UOf47GFntKEGdtaWNU1b9aHNJvO?=
 =?us-ascii?Q?bG5/DcUbNKm3LjpeH6P2hkuU04VRMDm2YpbMgI72arHx2MD+BtiQ+BuUHzBU?=
 =?us-ascii?Q?BYco1anK5tjtBhnD2e3w4Vw6n8UjDnHMKPR/U0/JAvL7x9O2npXzMLW5pQ?=
 =?us-ascii?Q?=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83f763ed-49db-45a2-334c-08db98b5acd5
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2023 08:50:25.9117
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mZCQ9xF7t4PUIBl+DeyYEaSBR3a6GUMuEw3L/kqSL2irOi3Su8SWv5N4KPL2jDvQtln9kF3jCr8aRFJ7Zc02lA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4875
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

> From: Tian, Kevin <kevin.tian@intel.com>
> Sent: Wednesday, August 9, 2023 4:23 PM
>=20
> > From: Nicolin Chen <nicolinc@nvidia.com>
> > Sent: Wednesday, August 9, 2023 1:42 AM
> >
> > On Tue, Aug 08, 2023 at 09:34:03AM -0300, Jason Gunthorpe wrote:
> > > On Mon, Aug 07, 2023 at 08:12:37PM -0700, Nicolin Chen wrote:
> > > > On Mon, Aug 07, 2023 at 03:08:29PM +0000, Liu, Yi L wrote:
> > > > > > > From: Liu, Yi L <yi.l.liu@intel.com>
> > > > > > > Sent: Monday, July 24, 2023 7:14 PM
> > > > > > >
> > > > > > > +static int intel_nested_cache_invalidate_user(struct
> > iommu_domain
> > > > > > > *domain,
> > > > > > > +                                         void *user_data)
> > > > > > > +{
> > > > > > > +   struct iommu_hwpt_vtd_s1_invalidate_desc *req =3D user_da=
ta;
> > > > > > > +   struct iommu_hwpt_vtd_s1_invalidate *inv_info =3D user_da=
ta;
> > > > > > > +   struct dmar_domain *dmar_domain =3D to_dmar_domain(domain=
);
> > > > > > > +   unsigned int entry_size =3D inv_info->entry_size;
> > > > > > > +   u64 uptr =3D inv_info->inv_data_uptr;
> > > > > > > +   u64 nr_uptr =3D inv_info->entry_nr_uptr;
> > > > > > > +   struct device_domain_info *info;
> > > > > > > +   u32 entry_nr, index;
> > > > > > > +   unsigned long flags;
> > > > > > > +   int ret =3D 0;
> > > > > > > +
> > > > > > > +   if (get_user(entry_nr, (uint32_t __user
> > *)u64_to_user_ptr(nr_uptr)))
> > > > > > > +           return -EFAULT;
> > > > > > > +
> > > > > > > +   for (index =3D 0; index < entry_nr; index++) {
> > > > > > > +           ret =3D copy_struct_from_user(req, sizeof(*req),
> > > > > > > +                                       u64_to_user_ptr(uptr =
+ index *
> > > > > > > entry_size),
> > > > > > > +                                       entry_size);
> > > > > >
> > > > > > If continuing this direction then the driver should also check =
minsz etc.
> > > > > > for struct iommu_hwpt_vtd_s1_invalidate and
> > iommu_hwpt_vtd_s1_invalidate_desc
> > > > > > since they are uAPI and subject to change.
> > > > >
> > > > > Then needs to define size in the uapi data structure, and copy si=
ze first
> > and
> > > > > check minsz before going forward. How about the structures for hw=
pt
> > alloc
> > > > > like struct iommu_hwpt_vtd_s1? Should check minsz for them as wel=
l?
> > > >
> > > > Assuming that every uAPI data structure needs a min_size, we can
> > > > either add a structure holding all min_sizes like iommufd main.c
> > > > or have another xx_min_len in iommu_/domain_ops.
> > >
> > > If driver is doing the copy it is OK that driver does the min_size
> > > check too
> >
> > Ah, just realized my reply above was missing a context..
> >
> > Yi and I are having a concern that the core iommu_hpwt_alloc()
> > and iommu_hwpt_cache_invalidate(), in the nesting series, copy
> > data without checking the min_sizes. So, we are trying to add
> > the missing piece into the next version but not sure which way
> > could be optimal.
> >
> > It probably makes sense to add cache_invalidate_user_min_len
> > next to the existing cache_invalidate_user_data_len. For the
> > iommu_hwpt_alloc, we are missing a data_len, as the core just
> > uses sizeof(union iommu_domain_user_data) when calling the
> > copy_struct_from_user().
> >
> > Perhaps we could add two pairs of data_len/min_len in the ops
> > structs:
> > 	// iommu_ops
> > 	const size_t domain_alloc_user_data_len; // for sanity&copy
> > 	const size_t domain_alloc_user_min_len; // for sanity only
> > 	// iommu_domain_ops
> > 	const size_t cache_invalidate_user_data_len; // for sanity&copy
> > 	const size_t cache_invalidate_user_min_len; // for sanity only
> >
>=20
> What about creating a simple array to track type specific len in
> iommufd instead of adding more fields to iommu/domain_ops?
> anyway it's iommufd doing the copy and all the type specific
> structures are already defined in the uapi header.

Then index the array with type value, is it? Seems like we have defined
such array before for the length of hwpt_alloc and invalidate structures.
but finally we dropped it the array may grow largely per new types.

>=20
> and a similar example already exists in union ucmd_buffer which
> includes type specific structures to avoid memory copy...

Not quite get here. ucmd_buffer is a union used to copy any user
data. But here we want to check the minsz of the the user data.
Seems not related.

Regards,
Yi Liu

