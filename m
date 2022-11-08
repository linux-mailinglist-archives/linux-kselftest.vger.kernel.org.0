Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7B77620673
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Nov 2022 03:05:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232932AbiKHCFu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 7 Nov 2022 21:05:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232196AbiKHCFt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 7 Nov 2022 21:05:49 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE30213CEE;
        Mon,  7 Nov 2022 18:05:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667873149; x=1699409149;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=YPFazzdgDBRKSlwyuS9HBqiOt1DafxZEynCO/zERrjE=;
  b=fh2uv7EKZXzfdRCo/zr/l9J2bQU6Ude1dBDOeZi5qoRCUzjUZIPcMm0D
   5lhS2ZooJarjOGGFtG9AAyrAE2eiLsHRkM5t9rzSh5yHH+cFqr5O1JOth
   /OK5XstKBpT2GbYtdk6uqj0SCIX/e914D7XJXqWY1YoEDu5xoWwoVDWAx
   iKxlleAsP6b8XCCtN5e/YONjba2wCqXD5K+mUrnfPz/8MFhvhLQE2gNnC
   KgDGMOoW8TQvm6/7JkMh/HsWr0Welt6zdFq9PmoxwuaLsj+zRQp0/BP5E
   MTg5CtD/AUoJFrXirS4oMBcNjduNKylg0sxWgmnLtwaNERdL0R3Wrm1VD
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="374850582"
X-IronPort-AV: E=Sophos;i="5.96,145,1665471600"; 
   d="scan'208";a="374850582"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2022 18:05:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="741750678"
X-IronPort-AV: E=Sophos;i="5.96,145,1665471600"; 
   d="scan'208";a="741750678"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga002.fm.intel.com with ESMTP; 07 Nov 2022 18:05:24 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 7 Nov 2022 18:05:24 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Mon, 7 Nov 2022 18:05:24 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.43) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Mon, 7 Nov 2022 18:05:24 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AYaucjoCpaqRJUWlsrOChin8hZzTixouOjxBJI9i/PFGeoH/QKcnlzO9GXOqmD9miTZ5BIBN1vn4wlKV3EgbhXPA6WQa7p0UA6g7qo4OjoNXCRM/TqfYIQZ/curPBnynoBqVwh3UTKTyZ56N2VRpmEBuqSvckzCAgjcRoKbXSrh8WBw5XXsKLd411qWsHEH287L90lg7eSuOI/C8wzrYTClhUaOrh29OC/AZlSZfUWM7WsMuI9gwYTe37qbxdsF9xA0q4Rgp/Du4er9pUyaiLDJEnS5cDONIfdIM/+riqLkQl6EzPUUycXUEswNhX5XBsVrf1k2PdNw5lO/b+PEaIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YPFazzdgDBRKSlwyuS9HBqiOt1DafxZEynCO/zERrjE=;
 b=UnrmGrEoXnf0k9aU0ZGYJo+x1I3QcbeqFv5ZaZ/SfSSkrejXhWGQuHGr5obDlo8B8WAfayFcYhlFnp1+X+mSRaNY6iJRsgTkHDShC+rgCdMnpieeAGyFm3mL5cdBfP9DDX2KAUjluMZRO/rXGNuk37dTzHt8lWpMxPyYl9oOvxpClEqX63WYxyG9YqHIAFgOOrOA/l7PURluR3Ci2CHd1HIkUqd1VEma4gluDpt3NEwSaMdCKmqxbw4jtFQv/x99qJtRRhFsLOl1s4YER7d2T/hyjxIek1b8A5pVxy8t/g+Mbr5sBo4Ls3pOQ5/yfu7MtZk/dTWFzPIsIyKhxWTJWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by PH8PR11MB6682.namprd11.prod.outlook.com (2603:10b6:510:1c5::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27; Tue, 8 Nov
 2022 02:05:20 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::737e:211a:bb53:4cd7]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::737e:211a:bb53:4cd7%5]) with mapi id 15.20.5791.026; Tue, 8 Nov 2022
 02:05:20 +0000
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
Thread-Index: AQHY6J1k/MYko282jUa1sWU0zIDdtq4uXG3ggAVGNgCAALiD8A==
Date:   Tue, 8 Nov 2022 02:05:20 +0000
Message-ID: <BN9PR11MB5276706B744018EC6E36E1128C3F9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <0-v3-402a7d6459de+24b-iommufd_jgg@nvidia.com>
 <10-v3-402a7d6459de+24b-iommufd_jgg@nvidia.com>
 <BN9PR11MB52765289F880B8A7297077318C3B9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <Y2kd/Ptt0iR6SGsh@nvidia.com>
In-Reply-To: <Y2kd/Ptt0iR6SGsh@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|PH8PR11MB6682:EE_
x-ms-office365-filtering-correlation-id: 0ab8c162-237c-4247-5a76-08dac12db04b
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Dy9YuDWBJOqGCv88uR9/9PGLDvAIDZyZ+K9oEJ+Q7yCB1+XG4B5PrlD+hJa9bS5obBoDhKDb5BpLb4b5pkRNAQfRxXOOTnnAbjbTLVbQE7n7k+tSeh6m7M0JXd1TvNgPduvkrnQvfjBP6o4lKyLhrnifn0GV6L76SgOUD4x20PE0XWvKgSoHK6MeVB7jDlMHZzzpzhAyq7SFH6YSjZirdYEg4YQWvrwbPkS6lFW2m4BKNXw0Du1V8vq71el7pM7tCrLMZQAFSAkQoHHoEYIj1mg2diaWxOmx8fGbKpe6LwDIv5wwp5KQjGjGzwPAuw2YwQxWl4Xd0z+kdeGWBmJ0I//lCzrHdVk05TwCz7lag3OPLUsxaQiiqvZ7qneRb3casSXJqhRwyYEvXI1YrY7ch0IdpBaO6zF7JUgNefRY6Jgw7dydlqz2VSfbhbKxsyByTYhZFlzI+GSpwBClRb1e4eFUpn51ykiP1B+pwQ37AUyyl1ghuLmmpmMynaatjqZhTwiNKkk5Ms+/fQvIVE0Cqa0FKAfPe14D6H5dcRsTqJiCbbMagTi5chZW3BSY+vRQPq38lsLyC7PemdDuAt5M5QSyV/Q42GFD4Yl3L1YTEXt+WMm0uIFhNheeJaIejevuJ+Zgs7WBML8qnsCenjEzt0Q9b4UPpMYymR8y0rM+p3J7uQhF3OSMdXaWzyR28+xOs92rLQJen0v6p4uS1OhKt8pfytrsqFiL3JiT5m9D7RqPsC5LiThY6+cYCXhLc6Bo7rEAmS9b013w9qwJR88m7w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(396003)(366004)(376002)(136003)(346002)(451199015)(86362001)(55016003)(66446008)(64756008)(66476007)(66556008)(8676002)(66946007)(76116006)(7416002)(7406005)(5660300002)(6916009)(54906003)(41300700001)(8936002)(52536014)(71200400001)(2906002)(33656002)(186003)(478600001)(26005)(122000001)(9686003)(4326008)(316002)(7696005)(6506007)(83380400001)(38100700002)(38070700005)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?mbiF8itD6POeqnbtiRt9DlR5AyImd1+zR/fahV1q/ZYgT6tuC1MJHmSZZA8w?=
 =?us-ascii?Q?Fn1Z+i5mfz1N1VE4Eqdi0CtCiNVco/hXVTeE2WiXy4Qat4hZmhn0HSPKuLMr?=
 =?us-ascii?Q?tCC7ELpeYxNjQNvMe+gPwWeyb+DFq60rPPV5z+EoKeFPxiQ1lTQH3iPoNcNY?=
 =?us-ascii?Q?t2Dsr8U6an1RRSiQ//RmJew8kg+dtiivMPa3opelYVa3ZPUhigMpXt/bJbzH?=
 =?us-ascii?Q?2ZemXbl69e25aUGipXwv4pRG9g+KHfgayUGlfec0QFtTnxiksjXoL5njNu5Z?=
 =?us-ascii?Q?ljrMRfrqyspKe5ksTSljAsP9Fk035y5fXmqajaTyhiY2505QQ3fyMGE0IvfD?=
 =?us-ascii?Q?t3kJ4a+OPKUv8N8U0VPoDAmUWwfsBqGlGKilNFfTYcEtQcK/FrNv8mU8zvoM?=
 =?us-ascii?Q?MZL2t9f6hVn3hxEhn/PcNS+2IUaZG8eJBm3oyQH1YCLAEx/Vlz+oqdWSqicg?=
 =?us-ascii?Q?NiE5zBLoF2VKNYGFJNPZnPm7m9YLvwPN6NhkgDgfsbv3juzDdRiWEQeBQWeu?=
 =?us-ascii?Q?wYbeeyiS5/k6K1o9YURSR5p1PWuc/KStsnvWlBLdN+BqbaZH+Q7qrsNrBhXr?=
 =?us-ascii?Q?2Up+3tEY8pTtUCDLJQjyayqSEov7CpOWTXR82UzYGQWj+p4FFquurU5r0RWe?=
 =?us-ascii?Q?dWlzrqoofjZ7hpvWYt3jysxSP6Lvye2KCHTy/lz44CLw0JrMy56dA+g9BwnH?=
 =?us-ascii?Q?3YsnUy98w2O/Y4uJGrPG4ml9rUnYIfisivCvArQ4+dVsQhrBrNJkJ4VmUUkI?=
 =?us-ascii?Q?VdBJHYvpnfjSdct2hQE9Dzsn9HbapkoTm9Yj1U2BcNHP6bAuyrZHDuS5Tozr?=
 =?us-ascii?Q?nJgT7EOuAc6KbiaX+FWE5bgdQeC7mbvjT0yKa3/0vVHsFczkLwFYGG/QVxJW?=
 =?us-ascii?Q?9rqdts/C7qnAHWkNaT1ZcmbS1bS5C9Xti92TxLKTo0bCp9hqPdtiNngL0e2t?=
 =?us-ascii?Q?YgDi3VSNM3ViiFEFuz4bX/P/axiROKUU+BBgfdDAX02QKTcFtW0vqksPDrR2?=
 =?us-ascii?Q?Xcp6T4GKAarbhUHBGMDSyfv15lmeA1nyAwHUHKyGtCuWcYlbLPNq9SsV+3Hk?=
 =?us-ascii?Q?w4LFWhrUgPnNrOe5boNd1pQXdxUD40kT+R2xXikZqe3gzp4KGSlFukgMr6Qj?=
 =?us-ascii?Q?oJaX7XA2RkeiggUcyQKoZm3BIXphxBxkpcOZSpxGM058EhO9F2SFiJafvVNg?=
 =?us-ascii?Q?EHgziZzuHN7Ci3B+QKsJ55BsCMLRM7ShwrvXDJzmZWiDtr0CzKNoBBdAcFIm?=
 =?us-ascii?Q?NlQlNL0gsBxQZF7QGbSw870fNVsyXWFoXNaXATFHtTR1xpAfXIHDQp3jWl5H?=
 =?us-ascii?Q?n1vYtvXhsOYJBwb+tNUAHzMCoek29fEEV6V05kqLGQcVw9sMQ32lN+oY7f8X?=
 =?us-ascii?Q?8wjALvQZpLY+UiJUw338G/ajbBD5PEMp210XWNYudw157MpIsOzvKuv/04Jb?=
 =?us-ascii?Q?N/uGMMOqaQpkPmzrfl2hldGHW4Y8ouYsan0xIGA8K+hF17lT/VNVC3O1C/eo?=
 =?us-ascii?Q?KGy1KGmR8dSV4T54i0ODH44ognrUtKvap9JTG5MyejLM7PEG4tw+Ll7sPbzb?=
 =?us-ascii?Q?a55UfV+GwLoY6MLuHVD5kx6Hfgs9BlelyuQPVKmT?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ab8c162-237c-4247-5a76-08dac12db04b
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2022 02:05:20.1294
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LCZhvUageWVyY88BpvN3rE0SRvDg46uXvyJYoeiS9ILI8Axx+N93GutyQEA8VP8JH6lwFwstwd9SV0yGpPibXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6682
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
> Sent: Monday, November 7, 2022 11:02 PM
> > > + * @allowed_iovas: Pointer to array of struct iommu_iova_range
> > > + *
> > > + * Ensure a range of IOVAs are always available for allocation. If t=
his call
> > > + * succeeds then IOMMU_IOAS_IOVA_RANGES will never return a list of
> > > IOVA ranges
> > > + * that are narrower than the ranges provided here. This call will f=
ail if
> > > + * IOMMU_IOAS_IOVA_RANGES is currently narrower than the given
> ranges.
> > > + *
> > > + * When an IOAS is first created the IOVA_RANGES will be maximally
> sized,
> > > and as
> > > + * devices are attached the IOVA will narrow based on the device
> > > restrictions.
> > > + * When an allowed range is specified any narrowing will be refused,=
 ie
> > > device
> > > + * attachment can fail if the device requires limiting within the al=
lowed
> > > range.
> > > + *
> > > + * Automatic IOVA allocation is also impacted by this call. MAP will=
 only
> > > + * allocate within the allowed IOVAs if they are present.
> >
> > According to iopt_check_iova() FIXED_IOVA can specify an iova which
> > is not in allowed list but in the list of reported IOVA_RANGES. Is it
> > correct or make more sense to have FIXED_IOVA also under guard of
> > the allowed list (if violating then fail the map call)?
>=20
> The concept was the allow list only really impacts domain
> attachment. When a user uses FIXED they have to know what they are

it also impacts automatic IOVA

> doing. There is not a good reason to deny the user to use any IOVA
> that is not restricted by the reserved list.
>=20

I just didn't get why different restrictions are applied to automatics vs.
fixed allocation.
