Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C36C6C2A30
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Mar 2023 07:07:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbjCUGHH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 21 Mar 2023 02:07:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbjCUGHG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 21 Mar 2023 02:07:06 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E2522B62A;
        Mon, 20 Mar 2023 23:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679378825; x=1710914825;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=q1uNIayphFD5viyr4cF9zkm4qPwcm9Q4kvp3yDt0hw0=;
  b=CbBiWln2/pn8l0LZM1ohRFUAWiaLWtvfNirm8FC3U0oe8YXNcGS3XGAT
   936AM3V9jJUaapCNv1lsDsCbfbyGlfpi4cusQkib4aIFgi0qGhwKQtldE
   Sz1jjrWEiZVT1sWJDardrdAGs6vy0qxo24KdeNZZQsdLBE6sv+6QOo0Jh
   VxUDuXrgAvJg7oWdSfg5iWa8BzUfbsp5FBwpdLsijD4bCkEU5X9ZyiB2q
   aawSIJmn+xKrROIDbvlj6WTW54NgH3kMhHMDJeS7o0MW2ek3JGo+flCNi
   e97cN05yPoe3HMQ0DOOKN9ZPBi7zF+L6GWtUQ4lmNXJONKkpgXaoQUwLL
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10655"; a="341215224"
X-IronPort-AV: E=Sophos;i="5.98,278,1673942400"; 
   d="scan'208";a="341215224"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2023 23:07:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10655"; a="855562985"
X-IronPort-AV: E=Sophos;i="5.98,278,1673942400"; 
   d="scan'208";a="855562985"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga005.jf.intel.com with ESMTP; 20 Mar 2023 23:06:40 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 20 Mar 2023 23:06:28 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Mon, 20 Mar 2023 23:06:28 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.173)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Mon, 20 Mar 2023 23:06:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LG+I/neYw0jd43hjzpA/x4XQyqZGbQP+KSSsABPcyOoegRI4KtxCqz5gAXGTL3Yq2p6Wp/SnnV5jB5l65hsB6hZ1FI/5UhGMzAKjNKafZtxvi7ce7Hv9PvL7AoOIn5qU20euiEem+/r9GPRWkb0pMHZy7gWeYNIfwboTlvks3xwO2+tfnu0oR9F1D/tPutn1pLhtM6IAOSWy9ysgxZ5OPUF/R46paARBkUFQmToDlX1G2H2fUhgBngFasNaTbDWJWR1cgvNnVbJ/I/fl9lgN2iwMc9J9GmeTF8YAd1VyB9rxaYUI17fX4tRjvbnSmOXKV3HeWlhHedzlRig63/4W2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m97aZ7O/pJ8s8L9z91VbOEvnFuMVW7cxR7YNy4MdXXU=;
 b=eaI7WqVQURb7Sbgko2b7OkXQAeli3OUQLHuRKj2sqoTy8v84+77IXmAb5TZTYHMju3lLRvbVqDk0aXeUBby2CvhBp/Q0RU2ZDLFplffokYoY09wvgAZC9/mWP8lFPJ//rz0o6qOWeReoVT+OgkYUqfj2Z0G4Z1AxQmYpL4M0NW3+v6kAUOKJFdNeNUFQ5y0bAndCoyMSIynlVgbOqotmNi5KIAhOeh6fRcLkk3ma6rFpqrl3CKlgd27NP/JOOJJNWoADYXLRB7V5u7RDQD0QPjDMlUdAcxmHUv/seBnZoVfXbyy5JbXqg3sLQYOFINy3TQwS8KARGOCBWTSg7rCRAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by CY8PR11MB7686.namprd11.prod.outlook.com (2603:10b6:930:70::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Tue, 21 Mar
 2023 06:06:26 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::6f7:944a:aaad:301f]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::6f7:944a:aaad:301f%8]) with mapi id 15.20.6178.037; Tue, 21 Mar 2023
 06:06:26 +0000
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
Subject: RE: [PATCH v2 1/5] iommufd: Add nesting related data structures for
 Intel VT-d
Thread-Topic: [PATCH v2 1/5] iommufd: Add nesting related data structures for
 Intel VT-d
Thread-Index: AQHZUmBbUDr/lqYncEGY8NQoQwlnI68DwO6AgAEOuLA=
Date:   Tue, 21 Mar 2023 06:06:25 +0000
Message-ID: <DS0PR11MB752963483E616EC55F372D82C3819@DS0PR11MB7529.namprd11.prod.outlook.com>
References: <20230309082207.612346-1-yi.l.liu@intel.com>
 <20230309082207.612346-2-yi.l.liu@intel.com> <ZBhkf8ugXFPi8dej@nvidia.com>
In-Reply-To: <ZBhkf8ugXFPi8dej@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB7529:EE_|CY8PR11MB7686:EE_
x-ms-office365-filtering-correlation-id: aeaf3349-7e0e-4276-a8e9-08db29d26792
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vgjr0AsfoT7wHJLhOmh296BOBUXzr4M43IAXISO6IQwIZSTlSnFCJue19OCUZriOOmD9sDZv/GzuCqPuT/3SAzdEpOstggik8T+OInAaSObF3/Nwy/z+sJhRdsxvRQROWeTACqCdfml1+LmhaGnUlBWCRNjNHInx10xeJrais61LdMsvEiUJl7vAQc4MrgUPNxdNLcDfW8yK+yufNdR+l+kffDlwIpwuOPan32cbcPmt4+diQmOH0RsocEwPUVwKVNdRE9Fx8dbkrWveKN36puNKdCfPJhgOv4mzMPC6kUXnv3/t2SeHpIOSgNA6m34Z1rNyC/7UHaNUqJN5gbQ5lmCkqWjaGx8kJddV7BJP2a5G2xbL8gpjEvzwMRK4ewEOGFxBdbAx8eDiVArY2JGdslKls8uvk5VtXaMzYHOWBqyhXACQhQdeS5sLME5+D0nBCGg5Y4Kd5UoE0qrp11megY3YZ+MpJjmV2WqzbFMOO/y5rywaNA7O8losFW41dBSd+292kgcmI9xnQFFpWRtyMvee3434g2T9tMcwEqPaiF6kUTPh+/pA4qfvqRENQj99tmu+X0rKNSYxm7rJsWGJPvHGl2YLgFOdHUQvUhPfFNRjhgWi0NYJV6aXwp+lVAfsDUod5kQQ7uWheEnTVzC/3/V7md0FwJG06Mdxg6HBmEgwTZK0PEkfi+OlZFuUczKHg4qzfu5IfOUnJcHRdvNvCw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(346002)(396003)(366004)(376002)(39860400002)(451199018)(82960400001)(38070700005)(6506007)(9686003)(186003)(26005)(71200400001)(86362001)(7696005)(38100700002)(2906002)(52536014)(478600001)(83380400001)(122000001)(55016003)(316002)(33656002)(54906003)(4744005)(8676002)(66946007)(4326008)(5660300002)(7416002)(41300700001)(8936002)(66446008)(64756008)(66476007)(6916009)(66556008)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?UDnNex9tz2zN17F3UAWK+5I2v8wmSPqrqOfBMKt8zWXSPeukmafhX+r8q3vl?=
 =?us-ascii?Q?DnY4dj4lAyjNLyA8E5DYBTYkdqrT4L3vqzS9sl1eUkq03MNENkEHKlba2O5L?=
 =?us-ascii?Q?Yf0m3DvzBSfUndkGXTiCts0PQv2Jeq42YOS7C0mpzOQzrBkkpqFafPaV5yuf?=
 =?us-ascii?Q?DNf6HjEJSbMv8Xqm5eiVQDczG+W9RjTZrdrvJM2Yq0ukJgVrc58gzypGML08?=
 =?us-ascii?Q?jNCjj9vGCjmkeol7qJlRqXw6PxUHmgJFwnZy2u8qLNFhyVYnXj1D3DAXNoaQ?=
 =?us-ascii?Q?xY/N8RFq51qzrvweycWl+7572DtHtkPGl3bLgPH+fD8tzEAwlaYfaWdrTq4k?=
 =?us-ascii?Q?FLPP+DP607DEbzX3y8fJgxxiFD2Yir20f6DXCanGlkN7r3nrbh0UwIZ9yPZF?=
 =?us-ascii?Q?5wRsScGEXgEDDHbD3qeu12mcr16Bzyfda7vT+7VFoXgMARMpPb5UDe6c1vyG?=
 =?us-ascii?Q?kVEHrc8mO50PV4X8Dgc1NE0wv4PEJWTRGXQ6hqMneJFXEoV86ExIHB0aKV7X?=
 =?us-ascii?Q?2eFAHPLIlEBRxFZ0mqK3BxBwGhNlgA6UjEatbkbXHx004MQY+Fo0lQiny9FS?=
 =?us-ascii?Q?OIQiLiKhFTGy4OFAueU8LlNre41j7ry6pNZpeer4twqYDByDV1JvzScMATIy?=
 =?us-ascii?Q?077iGzJmIHnf/Xu9S8FDamdOaZqJEvUXe8A3O/oO5cyqhmrtOi6aXQs3jBy3?=
 =?us-ascii?Q?zkBmQRCgwE19qZ4dWiS+RKXOrR2G/5P0XCtJ1WZ10rwU50bwoC1Ckm/+lPZe?=
 =?us-ascii?Q?+n8ZfTUAV/DtUUUxEiH03Z40UPQRU1VFEij6g36pnEESkO8RHiUIw2jwH2+l?=
 =?us-ascii?Q?sSRlDhL4accqAxi8zHd5KqiEgMiu225pMFT6LoZjgHeMnNtiwGlD2FrgKwGr?=
 =?us-ascii?Q?qX0xNDItDJocxUGXolVnDfrbqnYE1YHN31oSiN1hEZF9Vcnn+xJYOGW5YdIv?=
 =?us-ascii?Q?oEMTEba/6wHzX+Y3FHeMAkAWUG7z0i669atCTwI0eU8aBvSxePf+15vvUqa8?=
 =?us-ascii?Q?IoTHJej3/dRU64XeRHo8L1evjxgRpDIXdhQUvoEhhmdABWiFZLxsoOTcjJtM?=
 =?us-ascii?Q?mB/CTYuLiCrzb14T2Q1fbmibb4YyaqJ+U3DU5bLmAyR6BGvjL7IfMxCzfpX7?=
 =?us-ascii?Q?gBHCu22/4JtNibct5AIQkF/ToRqtWrJDhGZquvKMv20wQw1Cfe1BE4muFHc+?=
 =?us-ascii?Q?DfWTVPeVSTCU+kOjRHjKE+RuLTMGuWtGE7vol01qnbH1Sc5uekBN0bQfA7sx?=
 =?us-ascii?Q?nTHSMlLvyioai3xHfh0SIF4ZLBctuX/AETogPkHa1lggBI+QIMcM3o37ECRg?=
 =?us-ascii?Q?UO/tXGVg0XEWSRt/aQVHMcFI67Kx6bTIAl9habTcyVPermKpyR0WjBtCBmu/?=
 =?us-ascii?Q?YRdP2TwWffAEU7ZHJtBNokEK8vNzshlN4auvwI7dH7WZWup/HrOMKNwmqVC3?=
 =?us-ascii?Q?oH3ey20hEz1nmpWeu9/ZVYTSwi70A+yIZvTnn90O8XsZqLmyMi+A1V/PQ4CA?=
 =?us-ascii?Q?YVjfFuE6PwTM/Yf/8qReAjk52Q3U3gSJPC+16Tsso2Nwq76NkG1YHlZY0jxv?=
 =?us-ascii?Q?PCKGtvFxJOgP3jTsLBaTZqoKA/k7NehSLL+I3O5B?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aeaf3349-7e0e-4276-a8e9-08db29d26792
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2023 06:06:26.0437
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yDFr2IPmog3y8bg5ElX+JtOyInmXHHhhv8GQE1eu9Js4yukBwrWlLbNR9Ih022sAemK3lFItG7wzJABQdc/Ebw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7686
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Monday, March 20, 2023 9:50 PM
>=20
> On Thu, Mar 09, 2023 at 12:22:03AM -0800, Yi Liu wrote:
>=20
> > +struct iommu_hwpt_invalidate_intel_vtd {
> > +	__u8 granularity;
> > +	__u8 padding[7];
> > +	__u32 flags;
> > +	__u32 __reserved;
> > +	__u64 addr;
> > +	__u64 granule_size;
> > +	__u64 nb_granules;
> > +};
>=20
> Is there a reason this has such a weird layout? Put the granularity in
> the __reserved slot?

No special reason. This layout was from the previous merged version.
Will modify it as you suggested.

> Consider the discussion on ARM if you prefer to use the native HW
> command structure instead?

Yes, will think about it. at least granule_size and nb_granules are not
necessary. They was added in the previous abstracted invalidation
uapi structure.

Regards,
Yi Liu
