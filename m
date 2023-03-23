Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 552056C613F
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Mar 2023 09:02:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231261AbjCWICL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 23 Mar 2023 04:02:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbjCWICG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 23 Mar 2023 04:02:06 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B40B22018;
        Thu, 23 Mar 2023 01:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679558526; x=1711094526;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ZL5UpzhXQ6oz0HVKjQuJh5uaVNmMKDlqraEupWKkQPc=;
  b=ddJrQ0BQGXGJQFw0bNRMfdqp17tKNAVEIj14v5wOawYCferYA27bSUbp
   obfi9yiu2yPGKoBj45Z9Bjs86kx8o7qLmGsg0HLipnJv3/DankInWIvth
   +9AzTX3MxtF8C6KXV/ERNibnaFD2nVHwagb8Mk/oN2LNsnPVpmRM08piW
   YbNyqrYWUORmRaIRePN51WMn+LPBwj4dtMX0/Oee1zUd9Cvk0X+Z2Wofi
   6N4jmhCRIY7P4+hNjDhri6xL1vPvJD16GHg0BJ4XAldir6u4n0qGU0mb3
   emnp0Eg+Os2fIFZdAVjzTlwSYtwJafyw6g1zlln4I1F0kiXRWjLuGo4jM
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10657"; a="338145802"
X-IronPort-AV: E=Sophos;i="5.98,283,1673942400"; 
   d="scan'208";a="338145802"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2023 01:02:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10657"; a="1011687767"
X-IronPort-AV: E=Sophos;i="5.98,283,1673942400"; 
   d="scan'208";a="1011687767"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga005.fm.intel.com with ESMTP; 23 Mar 2023 01:02:04 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 23 Mar 2023 01:02:04 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 23 Mar 2023 01:02:04 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Thu, 23 Mar 2023 01:02:04 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.175)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Thu, 23 Mar 2023 01:02:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f4bAmHjUOH7+aVmFCxZCdcbcP1/quKXpPMHK+hem2RxORlwrzrYMW5Ty/7o3WRwAVKaGjkb53Q9Gc7WiB9jRSrOU7Wx3GLBXn1C30BWdfEYW1PNa/O5nl4zD4Ptay4Daf+5YXTHCmRgHnWcEOtjGzjeiEBxzJnx4AqsICRys89361AhNZsW3C6SUwX0tDfk7oARCLBLDSqk3vuLJIcQWXUuhKC3minNfT0gvqJR0Sx+wQIoi/+Z0WR4rQqMu1iXNY/z1umVIhMp7/4gB8eF/914fOvzOE62p4rzbDoSaD/KrFv2zG3BecAyjvYnaGSXRCjeBse2TOafRerk+KVUM7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZL5UpzhXQ6oz0HVKjQuJh5uaVNmMKDlqraEupWKkQPc=;
 b=MZBKTrq6IoLnwoEsemc2kkCaUbZSuUBW9Md9LV5bcB1ssKlJCC7YeWaHbbgoXe6C1X71rH2GD1mzwZAhxUkMPmPG69LDLCqqtRbRTmARrLT6kpTVQoc9IvTHejzXsW8Fq2wzyf050mU2ApFVcyf9m3LJOR/O8d4qd7dPuvz+QVeMJmbyPt6JtTmcnM6gvMtOD40aCL3TkMwGbAPzq3YJbjjHhkfukI5H14FVuveKasaLdCA6YuBVlPhlampuHE8K5VS09b6ZxI6tdKWqDule9miPgtwcKbylTlCi88XxT+okqb0T3j3wsWj7MpvO9ri0ye0uFJ/j+eGYIyv7WpwMEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by PH7PR11MB6676.namprd11.prod.outlook.com (2603:10b6:510:1ae::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Thu, 23 Mar
 2023 08:02:02 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1aac:b695:f7c5:bcac]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1aac:b695:f7c5:bcac%8]) with mapi id 15.20.6178.038; Thu, 23 Mar 2023
 08:02:02 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
CC:     Lu Baolu <baolu.lu@linux.intel.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        Nicolin Chen <nicolinc@nvidia.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>
Subject: RE: [PATCH v3 16/17] iommufd/selftest: Return the real idev id from
 selftest mock_domain
Thread-Topic: [PATCH v3 16/17] iommufd/selftest: Return the real idev id from
 selftest mock_domain
Thread-Index: AQHZXCl8wnhKYzKEQ0WYT3xrjFpJt68IAxvA
Date:   Thu, 23 Mar 2023 08:02:01 +0000
Message-ID: <BN9PR11MB52760C4A615BE69DB92519EF8C879@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <0-v3-61d41fd9e13e+1f5-iommufd_alloc_jgg@nvidia.com>
 <16-v3-61d41fd9e13e+1f5-iommufd_alloc_jgg@nvidia.com>
In-Reply-To: <16-v3-61d41fd9e13e+1f5-iommufd_alloc_jgg@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|PH7PR11MB6676:EE_
x-ms-office365-filtering-correlation-id: ff3d7ea1-903b-4328-9c07-08db2b74e28b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NtUElpR8F+1GamgmFVm4rekXqE/ESa6Emc3i261XShD1D3Ja07Epqq6XzL4jhDyURgp5SheyrvNEv7b9Ld6GJ/aFoKMwyaRpEPRzJSJwyC8qgJDppYk2hupl7eXChHNWPTNsuDxUm8jn7wNZaaaJ9HT63CbEak7senb5dw6k/2a3S1Kz6BYeL0830J2N2dFPDNnEABgoU3H0FDKw0EW6oV0w+EB46ALjlEvjPV0evDud4A2aiHEyOI8bs2EvhQcf2PFIA+3Zouh1B3Jw+RH0gkpm/oX3SGtDoD5BdJ2/dyD1VmuAIXdA3sxLK/FV4QD0Ispa1k3qJL7gbXede2ZxFFzyOiu0x21emm4/OS0CjycPPq5BA46aIQsE8c1UtSfxmbADvQ9k/YYnokIqy2TNyAQ+983Uah1co7ebym1ZvbAm4lPP9vIH63d/HSRmUrP01p126OcPHdgkFDTYmwWDKmpztl+pmcgQXzAHaHz6RCHpH1TPsYPZfqHcgnu6Dtqmzub4Hu9MNE4K//CPjifZGl0wh/PpGK0+MkViF/iQFnRPPW0zsloY86CUF4tjWZhLo/XPYxApta17NekwbXN8C2kGeqgQqym1vAeRRWjMTdCe+9TqlI//rwAbZBOzjyK+cmjOFEjOuZoFB3ijIrOs+iG59EBsSzQiqVBurT55Xqfr3vPrSOtiuEgiKJL1s66RvCSg6yDPV0dU5lKG3qNPTQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(136003)(346002)(376002)(396003)(366004)(451199018)(6506007)(26005)(558084003)(33656002)(9686003)(186003)(55016003)(316002)(122000001)(2906002)(110136005)(38100700002)(54906003)(41300700001)(52536014)(8936002)(66476007)(8676002)(64756008)(76116006)(66556008)(66946007)(4326008)(66446008)(82960400001)(5660300002)(7696005)(71200400001)(86362001)(38070700005)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?U1y6s3DKTACdaD5eSz3UGGsIoHUNqqFtF5dNJZB1qGHPNFR9KlcvZ2mDMmMx?=
 =?us-ascii?Q?W+MMTd2DfBnx0uNK5tbdipkHJGFvDFz06/8uGM/2tPHD/l9QYlLqiOOsLx81?=
 =?us-ascii?Q?jqGNE13QcArf8MLk+LAiq0nxbCpe0uubpwOu0WJUAOVm+p1Nf0woBAlXk7+s?=
 =?us-ascii?Q?DyXDs+0Fggp2OEBvYrHXm0uwtFvtLo/ebkuhcf9R6wVdZnqtofZu2f0Q/GTW?=
 =?us-ascii?Q?OTX1DhNYOJ1nwBMjKG4EuXeMAq9qlBwmugAcj2ag0rDHSM5xR9uMDWJo2UzD?=
 =?us-ascii?Q?KpKaKegvBz+zZHDPXjhsVPigX6yS1fGXv3DD2pi7mQkdt+MuMJ7PetjuKc1f?=
 =?us-ascii?Q?bfkOAUT/8wqn0EpXImEma9RLiukWZW1z9U7FDEubr9iRqVhldVueLpYd24lH?=
 =?us-ascii?Q?bC9o5wbqw2oPe8KS4YQtJSkbBNAJZlxbjxkTSiwQxaTsLarGMS6+XlorxsoS?=
 =?us-ascii?Q?myZpZX6fYm3a1oP61P2w5B61SHOZBAVan1P+G/fMdX/Lcj2ef0YG2E3r3hfH?=
 =?us-ascii?Q?uDZqnDbGpGKOu7Ykh4sgIT4rNyedkjvAORr+lSpLCzgTEcwXFXAULsODc+rN?=
 =?us-ascii?Q?c7OoorThojqDVzEKX2nmzp8M+gAp4eaMR76uqghQ3MORI2O0lX+Nw8V4v2Kh?=
 =?us-ascii?Q?QdQIwu30mf9QLqYirYCVuqRRQcoL+o/pGjAPJt16uGEwOrE/DLGxOm9/nYqb?=
 =?us-ascii?Q?fpK0j5O7UTTg6YtG9FeKaTp+op4EkcCUeAOoc/gVXdm6SR1o2bM5ZUMHVpI9?=
 =?us-ascii?Q?PNmReM96as5hLFfDBTJOiQ3iCtT3znXRsxYbH8LuedfxrqOksHHN+9aP2f7w?=
 =?us-ascii?Q?SlRVEHcUONU+x3V3SnLmjtOFp2Ict/0GBvS84yU+bVfVBN9/Dp5hDf4KQH5J?=
 =?us-ascii?Q?PAn6DTKwzjhF+BLFCZqGIl2LuOmeiPOsxm0Vs8Z5Hh15JwgLQR5kLz9i8jxb?=
 =?us-ascii?Q?NcgaJSx60pXUOQez4uqgfPfiiWvpoSTcyAL4QMmJaiWUXkdAAq7RB/UgTrT9?=
 =?us-ascii?Q?L+IDHdLGUpUOtbbYmc1M12n4j34JvT6+6nffBSL1NxLRfjwK0xLE3ufLZgVW?=
 =?us-ascii?Q?ie3lfgcf0cu4V+6FlXenWugQjpjkfJ8ZkL4+z6jzH2sfbrobUemjgaxIFg1v?=
 =?us-ascii?Q?vmcScNa8uCX69+p4bj7/rx0Ce+SG3GTeqlj7m3FKK5bb3IJM3Vbcw+XHduZH?=
 =?us-ascii?Q?LwULdL4rsZ0IctWeX+1WFark8g7DiBuxFckXNHRPqMtWj3siEYMiB4jSvnY1?=
 =?us-ascii?Q?xofrzNT8+YD+dk1CyXn+0j8v88RpE7WijQ3iSRSolbsQ2S5IelkshH+M/1sK?=
 =?us-ascii?Q?/dIV1jGafCovuw8im4UJzFuTcrYsb7v9A72l7QRg/aatRAGu3r5ln30FNuGK?=
 =?us-ascii?Q?Z/dr5GbsTuYvU03du588bmXA2FZ69DMZHINT5aW8vJs6gvpty3ZESeW3RjmW?=
 =?us-ascii?Q?9xON41/fm8QpJAeq3mbQqiE98fI/VJBpGy2CW1T4V9tg+zvs6Gspt5gwS9e5?=
 =?us-ascii?Q?WuklqFERO55p8GSKEHBYR0LqtK/fDp9q7/BLBHiL1KJkw+QhLbII5/UTkVbl?=
 =?us-ascii?Q?253FdKLapZOq1tHTjOypHDO103Kh4Nyl2zanqv/D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff3d7ea1-903b-4328-9c07-08db2b74e28b
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2023 08:02:01.9901
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x4AjM4P5+yYMluTrPPYjDoLpBrhaKAZv0DGD0RFX21cvWaOU/rlfaidqWvrV3WsSp5c9Usg+sg2lw/Li3uBRcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6676
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Wednesday, March 22, 2023 3:15 AM
>=20
> Now that we actually call iommufd_device_bind() we can return the
> idev_id from that function to userspace for use in other APIs.
>=20
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
