Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0FFF62223F
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Nov 2022 03:51:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbiKICvL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Nov 2022 21:51:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230100AbiKICuy (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Nov 2022 21:50:54 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F10E201B5;
        Tue,  8 Nov 2022 18:50:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667962241; x=1699498241;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=AbW9osQOTzAM+ke81Hh+lwKBqG0fQ5rxu44+oxQdjCA=;
  b=dAh6ZeL9ZHq36wCsqTYQSVAY7RW093hEbgwDlleqtsQRkWJu2U62AK7x
   0FFPaMV3MgEJiI34ov445XOyPZ5d+l2eDvpjv/Ia0dd4LkxWKPy5kmzMS
   bAOSi6lTocf2hoeEN7VYK/at0hl++Vp1P/clwqn3eo7XAsnRgj/RbN4kz
   ZueSRIh/ljz9G0SyqT8LIBm2t/5QbhP4wZ/ZNshknkRMcUo620UwkHW3E
   UZWHgo7dbgTXJJWWatRQxn4JtJcIspTCFX7lBDKaN3Pi1ls+19jM6cZmX
   dHyIJEMlQUpZLHfBQ3uM27dNcmcLMlNdXmszxeCDotA1MD/WmaHMCcbFT
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10525"; a="291259711"
X-IronPort-AV: E=Sophos;i="5.96,149,1665471600"; 
   d="scan'208";a="291259711"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2022 18:50:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10525"; a="700174676"
X-IronPort-AV: E=Sophos;i="5.96,149,1665471600"; 
   d="scan'208";a="700174676"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga008.fm.intel.com with ESMTP; 08 Nov 2022 18:50:40 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 8 Nov 2022 18:50:39 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 8 Nov 2022 18:50:39 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.45) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 8 Nov 2022 18:50:39 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F1zq5iG5attuzt2GoMQ4EO8/y/Hy4JDyZ2RTUm1us6/mrC0NSNj+rYjsZkocbMN0rPzMaYWDJLdputFdIH1VQ7Vpjl5S/L6/jaGPgsCatnyK7DTEuOhtiGdbpfwSV/pfXjVoHlks++GA99C3Q3lni7TTfvkqzrKx6lOIV7FNZ3c5Q2YdW30lEz3b2bCix9wpCqgNvGqWe3dn35I9CIo9Zw78LO++y9j6b1zIg3hlJpDXqlDble5A8MmQOx8oFknDUbXRfkIgNhzLSFMvexlD5FmdgnRORcAwLR5zUpuYoyZPZRNYNM8pOogxSlMUxwxDcl/4mP7RlIPCM5FGfDFEHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+7WFaccRrinM5nJv/xwSpce8BNjAKaVgQIHNtAhnez4=;
 b=bWovByJsp4qzHGWpV4HTX4KubNdpKePm95X0eRtS2g1zGFVa0LYxCxfs/+YG6HP1wNvW6X8vLg/yV39Pwjrn4VOuUnrX9Ap9r9g+afuWl0S5MEX+UQEiFXyBxn51VLatG5MonCxYAmICm86jJxNM3FfTSgrvn+XykLsLaQFJzMnF391Nv/IfQxWipJDp5Wj6b24oNIBXHGMCjPARs1pIoFHgIFwHDCIdALpBLvUVhupUIz5CDXrwZd5n9W7yt0aAn65U5l+9g/dSpiSyfqTV7HCLTMJVJsNCiTpD3eCOYmM2CiQmYL74DXDacI26qsiGadgpnclbn1xcP1D+usof0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by MW4PR11MB6617.namprd11.prod.outlook.com (2603:10b6:303:1ed::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26; Wed, 9 Nov
 2022 02:50:34 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::737e:211a:bb53:4cd7]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::737e:211a:bb53:4cd7%4]) with mapi id 15.20.5791.027; Wed, 9 Nov 2022
 02:50:34 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     Lu Baolu <baolu.lu@linux.intel.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        David Woodhouse <dwmw2@infradead.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        Joerg Roedel <joro@8bytes.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>,
        Nathan Chancellor <nathan@kernel.org>,
        "Nick Desaulniers" <ndesaulniers@google.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Shuah Khan <shuah@kernel.org>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Tom Rix <trix@redhat.com>, Will Deacon <will@kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        David Gibson <david@gibson.dropbear.id.au>,
        Eric Auger <eric.auger@redhat.com>,
        Eric Farman <farman@linux.ibm.com>,
        Jason Wang <jasowang@redhat.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        "Martins, Joao" <joao.m.martins@oracle.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Nicolin Chen <nicolinc@nvidia.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        "Shameerali Kolothum Thodi" <shameerali.kolothum.thodi@huawei.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        Keqian Zhu <zhukeqian1@huawei.com>
Subject: RE: [PATCH v3 10/15] iommufd: IOCTLs for the io_pagetable
Thread-Topic: [PATCH v3 10/15] iommufd: IOCTLs for the io_pagetable
Thread-Index: AQHY6J1k/MYko282jUa1sWU0zIDdtq4uXG3ggAVGNgCAALiD8IABAwuAgACWn7A=
Date:   Wed, 9 Nov 2022 02:50:34 +0000
Message-ID: <BN9PR11MB5276DAAAB20671B6DCC135728C3E9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <0-v3-402a7d6459de+24b-iommufd_jgg@nvidia.com>
 <10-v3-402a7d6459de+24b-iommufd_jgg@nvidia.com>
 <BN9PR11MB52765289F880B8A7297077318C3B9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <Y2kd/Ptt0iR6SGsh@nvidia.com>
 <BN9PR11MB5276706B744018EC6E36E1128C3F9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <Y2qSEVu91SOfvVmO@nvidia.com>
In-Reply-To: <Y2qSEVu91SOfvVmO@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|MW4PR11MB6617:EE_
x-ms-office365-filtering-correlation-id: d8ca317f-04d7-475a-ce26-08dac1fd2c92
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OG5VT8uZZ681oboBMgDsOetwqGzQQ1IR+hnOwB6vK4dr0jR85elhOWIsIL4GzLH0UndlvrgStb7UFM539Q7geQjNAXL7QtO3HGLKLhCcaWdg8vLGdueeWtMr3vNhPhCUcPVdrZbzqoFnjxdwcHaDaQIJWC2WPS+J2OEzsqiuhouwURQABHY12YSjdEljmExPihU1mJ4rbH3JT6MZajtLwM+1nJ3pZ8dY4TgE1Tkpy46be0GL0HTv02yyMYcVtkyYveBZr3kA8JYo2XjX2FRUX+b2RIaaGWyBZXPV2Rfr4Z2nYwmr9Wd4Jh3XApw16t72CLbBWZba9Je9OMjXN2Y4CKp+lIxwPue2oTCQoitvK4aTba9VoZXrxDIhwAZMOn2JCoSeJQIPBjYz3tsyptttQF4Kfo8DA0B2+QeYHiPcspH7S5dBFBAu3pKhGPW1wg2qa4mPNSFKxbxUJHU2EUT05p9ENRCFiX5GAC+76Lq5Ixg5gALQsAL1AAD+Hx8XSwYUfgqNPzmSaYvRvVRdbE8NQ+7J79lEcF7SBiCMHwhjDlGdNemYrDFGmkcNHPkDNtyZwMAS6p92gdXC5OUAyvm96bBEmj1+hLFfkG5SwDXpWWPHjtKHsGd8lhuglDaNpUVAqfUxv3dJfNEfjtiRexW7TQVJO38V4xO+vzK9EIEqzgcejSpldWGuXzS3eoyuAVsnx7j1izAn5WrLKrvuo0T/V/s/N0T50NbKUgMJi2Kme/bZxcInXXnX58Mw3rN5J2LIYXHaVy8tunWzoizak1zGsA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(376002)(136003)(39860400002)(366004)(396003)(451199015)(7406005)(8936002)(7416002)(5660300002)(41300700001)(82960400001)(86362001)(71200400001)(8676002)(66556008)(54906003)(316002)(2906002)(6916009)(4326008)(66946007)(76116006)(66476007)(66446008)(64756008)(478600001)(122000001)(186003)(38070700005)(9686003)(26005)(33656002)(52536014)(83380400001)(7696005)(6506007)(55016003)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?E0Gq/l4oJCY+XpnV2I5vicMH+L2MugA+UXgYlwBUpqFu0azsfqaL0pMgFyHh?=
 =?us-ascii?Q?i+i/sNSBTi4PhHjz0j3AcLsQhEsoHp8qhZ30xIlmzRoLiliycqo4KWMPZ5Yg?=
 =?us-ascii?Q?kAWrK2C+k9Vhr9I7omO6c+jbHAUaUSgQZIGsqANlOs//o3MrCO06+8foABNl?=
 =?us-ascii?Q?H8jLIvhSoceXDyDEkgujACpmh1kQVKKUlPJoxBVJUiUwVW2MQRBxKlJ7/sbr?=
 =?us-ascii?Q?1gGfjIE6FS94NI5crVn/wEDOR1Py90b3MF3uPnUp3UmJIdBCpBAKB1w0ApQF?=
 =?us-ascii?Q?xiu0BUkp90CiEOEnKAkOFzPgz/WeupMnOQrvnLWWEs45Hqgt83iaOjW9ouvR?=
 =?us-ascii?Q?IOfTco6KhuyaxEmaLTpgpnow1XZuTv6VvPJ2RWDgBO6RpktBbaGqTNPl1fmC?=
 =?us-ascii?Q?8haZksrLWA7LzfTsqHuTNBFyPGMXl8l4yCQ/SEAm003GaHl5D9g4hrEM2/8P?=
 =?us-ascii?Q?zrywLKafUEFoaRNd983WVhONM31Wy2aO59Hh6zWf2mSWFPEX1kz7fk9v3eM7?=
 =?us-ascii?Q?UMrM/nXLHpjvOISyY7erxIB6JEpp28JzuL4dUGVh5Mgk0JuISFKK6IQ789l8?=
 =?us-ascii?Q?nT7YwvqZySWsClJEe/mhNXX23a7pcShy496xvpksrMz0qwxVo+oNNIv+USmw?=
 =?us-ascii?Q?qz201YntixWtXMubxDxkyBdANtv1Uw3Jbm6PIHl4kKtaDVEUUOv2PaOdkEvr?=
 =?us-ascii?Q?ZjSVGpJSfGTA09VsBZ5JtBHH6FF1g5y5NiDcc8M1ZFB2tMoN6Gh1q+8rhCb2?=
 =?us-ascii?Q?/uHgS1g3R5BVK0asyjxqMN+sCOrzM7LjbUGnPIjejTANjl5RD7PN8CR39cAI?=
 =?us-ascii?Q?kf6mSHx++OE6U3xldx7+3HRvATzagoYH3IwZP8YGovIx++YEcxCxkJlJFJtN?=
 =?us-ascii?Q?ub44xVsbm0uCfRTM7yIsAN84VKvNH7aBsVraxVRAuwveB7I62wBYqZBv9I+r?=
 =?us-ascii?Q?mH+qRr2SRfK2/oueACH2FTBbmi0PCH4so/c0ZPr/kv5KvuN60nODZlfUoe0A?=
 =?us-ascii?Q?g+LJTweCJlJK92/6kaBIV+HaAmmjlo6LcoR4vPvUjanQGDxkF3zF6SYcWh75?=
 =?us-ascii?Q?OyVnN1tv/v+1T8uqQGbFQMUwXGCX12qwtDzMDSltGqg1kK/JafiR4pKMxmYU?=
 =?us-ascii?Q?1P/HiwAYqGYsbfMhynKArZd/BgJSFcYOZOV2P0rkVnKcJVw5o7TRk9fsL1cE?=
 =?us-ascii?Q?mTC6FseT6wSMvPWsyDl1IRmb7DMESceAheikLt326sXtkUUzRaNuZCQpYWbR?=
 =?us-ascii?Q?tH0/jxRthls82HkuXxSpbIxCoVhDRgGtJFLqF0bJB+YP3aLbThbjR0JLmTnK?=
 =?us-ascii?Q?Wgh21U3xiyT1CyjK1bLIFDs2nhXh0Y7EKE6Inzv/fQsdJ2aI/ZQxo6da9YMJ?=
 =?us-ascii?Q?xvrurMeg6s3rYXm1iCRHnslwuqTPs6DYlwzvPeDaWj7pvZVdjXSFORRZRgDM?=
 =?us-ascii?Q?mBbAv1xhlW2P0y7BY/41s+uuHjU8nHNGhhQNouT2YhthhmCGf1GJe6Ws6JXn?=
 =?us-ascii?Q?RMqsCQ/1pzPg89AvK81BDSn0DKeHa/QnGGVmRTnSz+Vaq0INuGrMF3rF1Cr3?=
 =?us-ascii?Q?1j2NSJqV1WjOQ08I5Z6Ol+rUbhhC6OVRKzUn/P43?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8ca317f-04d7-475a-ce26-08dac1fd2c92
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2022 02:50:34.4583
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AeAV3S+BsadRXUSUtxaOiOHfzM78foTSiW9mrOJwjiSof3+DtAxYG8WKbUfI+wvzWkz2edwQXIDmXLWIg3q1vw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6617
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Wednesday, November 9, 2022 1:30 AM
>=20
> On Tue, Nov 08, 2022 at 02:05:20AM +0000, Tian, Kevin wrote:
> > > The concept was the allow list only really impacts domain
> > > attachment. When a user uses FIXED they have to know what they are
> >
> > it also impacts automatic IOVA
> >
> > > doing. There is not a good reason to deny the user to use any IOVA
> > > that is not restricted by the reserved list.
> >
> > I just didn't get why different restrictions are applied to automatics =
vs.
> > fixed allocation.
>=20
> Because it isn't a restriction on allocation, it is a restriction on
> domain attachment. (and this is a bit confusing and subtle, but it is
> what it was built for)
>=20
> The purpose is to allow the IOMMU driver to allocate a domain with
> knowledge of what the user would like to do. For instance a small
> allowed range may allow the driver to allocate fewer hops in the IO
> page table, and a create a domain with a smaller aperture.

if a domain can be created with a smaller aperture according to
allowed ranges then the impact is not just on future domain
attachment. a fixed IOVA outside of the allowed ranges will
find error on current domain too.

Should a driver which does this update the reserved ranges too?

>=20
> "automatic" is supposed to find a good IOVA that is the best IOVA for
> that mapping. We have defined the best IOVA as one that doesn't reach
> into areas that future domains are allowed to mark as reserved.

'good' or 'best' just implies that the allocation prefers to permitted
ranges over reserved ranges. then when permitted ranges are used
up the allocator can then go to find less-favorable holes outside of
the permitted ranges if not reserved. same as what FIXED IOVA allows.

But the behavior in this uAPI is that automatic IOVAs can be only
in permitted ranges. This is a restriction on allocation instead of
preference.

IMHO I'd like this uAPI clearly defined as either of below:

1) only related to domain attach then automatic IOVA can be allocated
   outside of permitted ranges after the latter are used up;

2) applied to both domain attach and IOVA allocation which then applied
   to both automatic IOVA and fixed IOVA;

>=20
> fixed can do anything legal, including violate the allowances if it
> wants. This just means a future domain attachment might fail. Domain's
> won't look at any currently mapped IOVA, only the allowance ranges
> when they size themselves.
>=20
> Jason

