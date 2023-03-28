Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 071FF6CB42C
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Mar 2023 04:32:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232349AbjC1Cc3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 27 Mar 2023 22:32:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232276AbjC1Cc2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 27 Mar 2023 22:32:28 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56DB826A2;
        Mon, 27 Mar 2023 19:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679970747; x=1711506747;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Ya2lxFQSkR1HZcAePucAuOWG0QMlIY3TIss94hCVNDM=;
  b=XbedYl1U9s+eELZMLgnP2lGt2q4LKaQYw10RlQ1ABSqk/gaM+1kBQ7r0
   LOvEyaUeGiSZ5wopUIHNKVDoCNWI7CTDib0ezupDiqWBhH97isOtF5iyx
   b9yh5np5/6j8iBCC2ZUW3S//a9N1+jyJBnRRsPdOQHzdTsSJnKC4vZDdS
   ioOnwlOzPp8lB2azpsIpEpHirAmWyfFTP+WOvzei0VZMFlh5csPukLnVR
   1IRMTpol/Zm1tmFMA3AowLL4Zutq2reWxp7YKeHxpRFfMDtRXueTHkrq6
   kkC9499L2y3L9AUpu2IAgs9WU4Am9RZrfjGJ3WXp754M9MfHp+0kanayb
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="320103749"
X-IronPort-AV: E=Sophos;i="5.98,295,1673942400"; 
   d="scan'208";a="320103749"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2023 19:32:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="677186125"
X-IronPort-AV: E=Sophos;i="5.98,295,1673942400"; 
   d="scan'208";a="677186125"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga007.jf.intel.com with ESMTP; 27 Mar 2023 19:32:26 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 27 Mar 2023 19:32:25 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Mon, 27 Mar 2023 19:32:25 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.102)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Mon, 27 Mar 2023 19:32:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pj/XthS0oH2/IrzJDQDwq73O2YOMQmGyb9dd6pxT+YckZrZbT/ne5fDNt1PtgKaktVeIFqp05FRVmz0tNA8jwqkaXoJaBE8rGP0umXAHAExXddTAZUiJroudwPumprm8xqjYArRvc2GogNAHPhWggrsK+kD04aYvkSfksm2HXC1Gbsxh+MITZdkQelEys24y8G/4d/Lugxpo3nX6dvTQXfoPiwtB5leBHgwGE5iiVIUrvfRLNePyBEhFUsj1khnEEMoKbDBuvWwWznX9AwT15WpsyS97iv5Q5ZoAEnCPpo6wm+1jBN82Vg4oI/ioSOuHWYazg5S7xJtR+g1djLXepw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+AEAbIxlBFMZIcjLxX4EbsVXcaIubAk33s6YW4dgAOA=;
 b=AInZO3nLHe4/66y3WQ4SFbkqTwQDXt6qMyMcAy69ulB5f9Qzgl7G3fAwaJ1823YOIgQc4dwE3Slz4gL7PLwmsdwOQd9vFiR9ZZ10zWTu3WNnCGxtVMrxo0G3KGAQfBrIQk6b2rxiKJshlMVPk53yzKinOXzcXTCAgbj/8xjBubYuTWj/0wAjuMpHGRuSTQ/+IIofF3zfKidkgZ4ykErh6DTi3WbisZ9X/wqnHL9X2BoEbbBRjbaOLcRtBMUsg+NURkbP/fHMMbqEBT1vMOuGNkCz8cV+nB9IfNCL/oL4g67qRikvlOGCv0Amnp2G//XmINHIDpRitpw9jhZTLo2mBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SJ0PR11MB7155.namprd11.prod.outlook.com (2603:10b6:a03:48d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.41; Tue, 28 Mar
 2023 02:32:22 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::73e9:b405:2cae:9174]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::73e9:b405:2cae:9174%8]) with mapi id 15.20.6222.032; Tue, 28 Mar 2023
 02:32:22 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        Nicolin Chen <nicolinc@nvidia.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>
Subject: RE: [PATCH v3 03/17] iommufd: Replace the hwpt->devices list with
 iommufd_group
Thread-Topic: [PATCH v3 03/17] iommufd: Replace the hwpt->devices list with
 iommufd_group
Thread-Index: AQHZXCmFXuCDj8eADEa48b1mh4jx9a8H8avggAB8LYCAAK8/AIAA7fKAgAV2LmA=
Date:   Tue, 28 Mar 2023 02:32:22 +0000
Message-ID: <BN9PR11MB52768F348A2814083BC5F5328C889@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <0-v3-61d41fd9e13e+1f5-iommufd_alloc_jgg@nvidia.com>
 <3-v3-61d41fd9e13e+1f5-iommufd_alloc_jgg@nvidia.com>
 <BN9PR11MB5276E42B629C3E5AF019B6748C879@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZBxg9cRIpsozB15G@nvidia.com>
 <BN9PR11MB52767DA03C240F040929A2398C849@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZB27ke/vQxsCngtC@nvidia.com>
In-Reply-To: <ZB27ke/vQxsCngtC@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SJ0PR11MB7155:EE_
x-ms-office365-filtering-correlation-id: 2aae690d-01d6-4be4-b8d7-08db2f34a925
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: O7mYT3ePW3mCmz9BEf7xjmXA60KKpIiiReHJuIG2YT0ZItu8eQTwJP5Y8GoDSFPb2Qqx9cvJVY0sD1/EhMtNU8fxeh8/NGwHw6OQoAx2zN0zSMedSnBIYXet7J7GDPe1dMBJBjfiI6lkk98LjTFlE6l9qE5I1LSgm1LB+IiArjH3aLZ75JE6Ht1inT1EBAa1/GUxNtLfvgIZ4VH24MB7I0xO3rsCX9ZXtFa/9fL0kChOJSLA710ImZIoopSvo3+YfLYJo7tyhf51E7RbiZVCZi280EFO3oEwzbIvuAJgDyJq+sddgcmgk2N+SyD9q5bhEXYeZs/CY97W2EH7i1ITUCUKTznSkqLzqdXYWL8dv2vCHwFjLMGDWGP1xUzmzeI4wcyYKoCV7V4tvFP6egwedHX12zJBeB0H0+1vMrW/qL7SX2l7KNcoL2EzNZDWxwssR8DtieC0ymBZSTm5OFHST7ahu4Yt5MGn0sE4rTKDJ9VOO+rg19CJuKNzM9D8Dfm/b6NBVjbRjkfWZwhPxPv/OfLLr7jw+ZL5GPengxwLvssxM7l+SD7IUbMQ4hJdgQxLMnIOqnJJNi2ufYUGtIcrQRtV3lrtX0TMNF/uGORfeNENI3QlkDcyFElkYCA0uieO
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(39860400002)(366004)(376002)(346002)(396003)(451199021)(6916009)(26005)(66476007)(66556008)(82960400001)(122000001)(8676002)(66946007)(64756008)(66446008)(76116006)(4326008)(316002)(38100700002)(5660300002)(52536014)(41300700001)(8936002)(54906003)(186003)(6506007)(9686003)(7696005)(71200400001)(83380400001)(478600001)(38070700005)(86362001)(33656002)(2906002)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?niFclcxgBeUrRWvOn4ixN2PbWA2DlDW5tgbaLXI/zApP/QSHezPTRXsllJS5?=
 =?us-ascii?Q?Jr3flop7KNfjossO3iCIAUsnVmRFfcI2ewAFCxNWeiVp8+CMuZCbVS6bjgvh?=
 =?us-ascii?Q?+q/dImFCVqz0dfRRMQyVkIHROQEu6ZNftKqgayKhfwBUa1p5eBBofdrlbQ9W?=
 =?us-ascii?Q?EFz1rNeG0rB4rKoGyhsKkGcttYNlNkWy7RzwtmqRuCkwQuuRUruE37O9bIkr?=
 =?us-ascii?Q?0CYfNvxA3ItvVDdEL/JHFuKqns8RFkFcTs/OmjiiqflezPE5aRWEuMNPo0X/?=
 =?us-ascii?Q?GYRwlj9Lr1XgKpiWBlRduSUMSE2SGIt54V5dG7eiL8yMaH71JePm42F2fxN4?=
 =?us-ascii?Q?Z8oQs2sa3b9WPFZ+X/HHF1Y4Vzt0C5jTdYo7qdHkdABvCr/jQzthg41Z9dgH?=
 =?us-ascii?Q?YK8B5eADT6mvFCxXM1H9wcezZh+nYgou6SpP2AFxQNSmBEFRPss5LjY7MObu?=
 =?us-ascii?Q?NYhDLbrY/UGDk95ZiMRVvqTC96ARdB4inxI9Bnxda9xKoWRBgVhX7HZ8sAaP?=
 =?us-ascii?Q?IH1tqihqIA8t0IiOHGml2eC0AUaU/E79Dp4C8RgT/tYLY1pzqHx/0MzfSqch?=
 =?us-ascii?Q?tdrCxhtjXv3+YBp6U3q+MlgwBA35PA4xfiUvjAfQvZPblui+B7a/sJJrOh4j?=
 =?us-ascii?Q?IQByK3Pngod8r1KCMw67zECWTUw1C4FIEfIW5qWYoW87rtk+qoQhQnyX5Tuk?=
 =?us-ascii?Q?3ySL4sbSatsqaJenPpHgN8bsxOrrYjsyjqcRKaAtqmdfobe3tA2jdqjKM83B?=
 =?us-ascii?Q?c7IKgpnNgHorVT7FmmltStT3Kiepbhb+K8Mg0glaRq9M8BAQEFRLnpWLdIe4?=
 =?us-ascii?Q?ZruhzAU4YY34cicbJNr5BgT1zBTneGlYkNWlQM12xMhiLy0b+AWKdc7YTE4h?=
 =?us-ascii?Q?5OVrSUY26dFrn1af9Skzo4sFzzf43nqEvM4QNJAA7nmpB4i9B22jKNzZf/bV?=
 =?us-ascii?Q?P2+y1Yc0iZJicG4CbMQ1WQTrTagmndrT7R4T5RS4/WwyFnddXOXtDhaXWHJS?=
 =?us-ascii?Q?uT+punflSqBZ1FO8IHKBtmS21t1OSfocUGGRMgOzuL0PdAkWv7R6qGFdf/1Z?=
 =?us-ascii?Q?CQDvQba3L3r9TuIHWmTDEEm6WYXCkp7y4KvqXeRQfpQvrNBKQoTJIA8Ptp2z?=
 =?us-ascii?Q?nuYgljP8QJu4klazfHD7rHmyMAdQjuwBveC9bAM5U2wTFEnNfIJBJ8Nf01SY?=
 =?us-ascii?Q?Fdw8iOvbhuHHHfaRpgHaEZCdi4nbPDBLNTXjh3oFKxov2yAnyBdPZ8KXeaMY?=
 =?us-ascii?Q?YTfDu44JPgcHDFtK1JI6oYo0+dZ28e7l6vCqWBZ+Jmd+R55meMMwne8fYhsX?=
 =?us-ascii?Q?K7/htuKhRSIe/Ph+VGQeVabCvvpnq266KA684qGOASANfAs6FZPCl1ykCGWV?=
 =?us-ascii?Q?l8X/5TRXntrcauJiOKqMtPenb6eGn6HLfY6BtwGdcfodHJKEoD0PpN/0MJWZ?=
 =?us-ascii?Q?sw7ywjxpdLb/aQmfErGC0qN9/IfPsYb7xJQAMBUbvhXn6OL56DfiupA8/GgS?=
 =?us-ascii?Q?AH6KpRoioT8n8hj9B9tEacJxhkNpZUZ/RfbodaxwAyrtyQ0nGhubjBFSYJfc?=
 =?us-ascii?Q?x58IXtxVuzZMFQLiC40hHDpCUKbhezvtCvK+/A+g?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2aae690d-01d6-4be4-b8d7-08db2f34a925
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2023 02:32:22.5190
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sAYmV0+gr1oxrpCyvSISpcVnOM1KOixTwjmi/zV/jYjrTNNJWNkNdG1i6kG352eFbxkUDQEszW6pNwSs6GNYXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB7155
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Friday, March 24, 2023 11:03 PM
>=20
> On Fri, Mar 24, 2023 at 01:37:51AM +0000, Tian, Kevin wrote:
>=20
> > If vfio races attach/detach then lots of things are messed.
> >
> > e.g. iommufd_device_detach() directly calls list_del(&idev->group_item)
> > w/o checking whether the device has been attached.
>=20
> Yeah, you obviously can't race attach/detach or detach/replace
>=20
> > And with that race UAF could occur if we narrow down the lock scope
> > to iommufd_hw_pagetable_attach():
> >
> >               cpu0                                cpu1
> > vfio_iommufd_attach()
> >   iommufd_device_attach()
> >     iommufd_device_auto_get_domain()
> >       mutex_lock(&ioas->mutex);
> >       iommufd_hw_pagetable_alloc()
> >         hwpt =3D iommufd_object_alloc() //hwpt.users=3D1
> >         hwpt->domain =3D iommu_domain_alloc(idev->dev->bus);
> >         iommufd_hw_pagetable_attach() //hwpt.users=3D2
> >                                           vfio_iommufd_detach()
> >                                             iommufd_device_detach()
> >                                               mutex_lock(&idev->igroup-=
>lock);
> >                                               hwpt =3D iommufd_hw_paget=
able_detach()
> >                                               mutex_unlock(&idev->igrou=
p->lock);
> >                                               iommufd_hw_pagetable_put(=
hwpt)
> >                                                 iommufd_object_destroy_=
user(hwpt)
> //hwpt.users=3D0
> >                                                   iommufd_hw_pagetable_=
destroy(hwpt)
> >                                                     iommu_domain_free(h=
wpt->domain);
> >         iopt_table_add_domain(&hwpt->ioas->iopt, hwpt->domain); //UAF
>=20
> You didn't balance the refcounts properly, the cpu1 put will get to
> hwpt.users=3D1
>=20

iommufd_object_destroy_user() decrements the count twice if the value
is two:

	refcount_dec(&obj->users);
	if (!refcount_dec_if_one(&obj->users)) {
