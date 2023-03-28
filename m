Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C05C56CB5D4
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Mar 2023 07:16:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbjC1FP6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 28 Mar 2023 01:15:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229971AbjC1FP4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 28 Mar 2023 01:15:56 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D43610DE;
        Mon, 27 Mar 2023 22:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679980556; x=1711516556;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=WNyyRBu2izUpoJm41Cc9ZqXLKZVePFCFR7d4HSDu9Z4=;
  b=XKDYalSfi11IjQJXNs1HqkXRf7YyFlIHYmxmrTIDzl2FBnt5y9gBeYXQ
   ECJz4af+25+xqtZmgoTqhPAmT1NwTq00JKts0IDg+pj2TekdtxL7DRKVm
   qNn3t1/NjJ7BElTDBVhrEwCQtcxonA3ogI0Bk9n0Xmao4/bi2t/msXUz7
   dU26eseHdva/kAohzjA5YTv6/MUTH0W73SRxyNb2xHqIw/Of9rySVoARE
   ngroWIc086hK6VAnMu/DVwe647rSTdoH+scMB1nbPUqEoigriC/ywwwGb
   ROYWL8aT6tOGGYUSyIM6SmPjidIy4ZTb4wqNZFHAYuBZN267c00nCgUFz
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="340498571"
X-IronPort-AV: E=Sophos;i="5.98,296,1673942400"; 
   d="scan'208";a="340498571"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2023 22:15:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="794643773"
X-IronPort-AV: E=Sophos;i="5.98,296,1673942400"; 
   d="scan'208";a="794643773"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga002.fm.intel.com with ESMTP; 27 Mar 2023 22:15:54 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 27 Mar 2023 22:15:54 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 27 Mar 2023 22:15:53 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Mon, 27 Mar 2023 22:15:53 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.102)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Mon, 27 Mar 2023 22:15:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tb49/kZfPYH6TuFoIay2bvA3Mx+M7u4ASXC/2SZerKzUDPFF8qvFDhDwjO/lxSYQhz0iqXnUwdBoBIAp5Jn4eQQukocaPZNB+ECdgjVamUA1wqxsmirSD6HXg/y/mHo90Rn9ppvWcpcnRU79ht7UXxKDpJ16KBwlNSxKRNPKbav4ALJKIBKbEHUieT6SEfx3w8E8qlpXTPFH/QktP+H3naI8mNuU22/LKIBtEKUoj/K1PSiXHfKP1nTpFCQMeNAS5F85+4+zmvRvQRTlSONJ2wbw0ktQ88fMtqaAuDUAfnyP+jDLatoHs4Ow7+uFhw5EgNoVEgaZBrUIixPi+jMuuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WNyyRBu2izUpoJm41Cc9ZqXLKZVePFCFR7d4HSDu9Z4=;
 b=SqrHeOziDf7QnX7fEgfZtqnFFtt72z6aomb0Rp3KCJSrIZVGqgrxQxpgemjLk86feiaMP1StKaB2jTu3t3gkQyYiNMN0yBnoVYHA8mR5jxdBJ2CzUS0L2BYyGNTTOJG32IgJKpV/ZnD8sLPzbJVPmues8gL4jBfTQT4TUebGWViR/tbLUxnTa/qT44hDoFEl80clIQTXU6E0+vhP86WpAN6fc5lfC09NlBFmhbK8G57KfL24mXT3kGPtykIV7QkIyEZ6mG1PCXWxWuce9oNkoaAyC5ng9VErMwMk2sUB82Qq2Z/wpYqgJSArPSoUZZ5VMHxKtzHtvetIpvIMaE+RAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DS0PR11MB6494.namprd11.prod.outlook.com (2603:10b6:8:c2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.28; Tue, 28 Mar
 2023 05:15:51 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::73e9:b405:2cae:9174]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::73e9:b405:2cae:9174%8]) with mapi id 15.20.6222.032; Tue, 28 Mar 2023
 05:15:51 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
CC:     Lu Baolu <baolu.lu@linux.intel.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        Nicolin Chen <nicolinc@nvidia.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>
Subject: RE: [PATCH v4 14/17] iommufd/selftest: Test iommufd_device_replace()
Thread-Topic: [PATCH v4 14/17] iommufd/selftest: Test iommufd_device_replace()
Thread-Index: AQHZYNtZrdCMvx7t2kOxylU56wDdma8PpucA
Date:   Tue, 28 Mar 2023 05:15:51 +0000
Message-ID: <BN9PR11MB5276A6137B681ACE47AB34008C889@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <0-v4-9cd79ad52ee8+13f5-iommufd_alloc_jgg@nvidia.com>
 <14-v4-9cd79ad52ee8+13f5-iommufd_alloc_jgg@nvidia.com>
In-Reply-To: <14-v4-9cd79ad52ee8+13f5-iommufd_alloc_jgg@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|DS0PR11MB6494:EE_
x-ms-office365-filtering-correlation-id: 053a7909-670d-49d1-c464-08db2f4b7fac
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RoQR0Et/nSH1I1y/6yPW3LxOCiVnCE/v+jxpvPKKlTlyZ0AuWlFOZvJUkwSc9+f5GYR4BFr+5+kyz+IPEoRJwRWgG7Ec2AESsCNL29w/MPtRo+SpXdnOwznQ/J+HTDbOCqadEsfPptRGoR8lMgtrERWsZI1Wct2zwPXn64dOAnL7NuyRFytH//VRJxm7bqWW01eBf3gCGZbvQDZiWAMDvKU+k49D7pIkzmKTfVHee7rwaxoiieyEkUhtrrbPDu2e7SVn+zjJaoA9pVQPY7NKfGobImOczqHfFdPjhVA+MZgYeyip5akNU1MzI8aVp88jITupEVEnf9dAb4pzvyTTak3PacB4pB2c9BGPLEP3VKgf4LckET9AF/w11dk/UKD6eci9equwrWORDgwqyHdb+oddHAb+cayrHw8zd88IReo/aOFewFYxCWRl7FZr+jlONVYSvwcZ96aEoKrC3WdfwIWvQtMrfsKicNaYAYs6HmKQNhe4VXeasZD5Qu87fiaVEVaT6i//edYYIQe8gvJ8RSrcFCLHqsHEYk6TGrARQP5n9u0rfuskmxAGfyb9tW+CxjFj6aS85qjBftvGBrHc5/ergcR+N5PAKLyDGD+q92w6ZBHWkxIX72hOTUEFrBqT
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(136003)(366004)(346002)(396003)(39860400002)(451199021)(8676002)(66946007)(66556008)(64756008)(2906002)(4326008)(66476007)(76116006)(54906003)(478600001)(71200400001)(7696005)(38070700005)(9686003)(316002)(186003)(26005)(110136005)(55016003)(6506007)(66446008)(558084003)(86362001)(52536014)(41300700001)(8936002)(122000001)(82960400001)(38100700002)(33656002)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?avjvWy3qixpQ3B1gcXRgm2Ncc/sjaAhF7DBe505PkZNbSeZUuYgQimF6lD1K?=
 =?us-ascii?Q?UseO+gM899OOfWn0A6bBo6yAmj1u4KGIfZJ1StV/KuJ/eNV8zCQA3hoi0HgH?=
 =?us-ascii?Q?Qilg63zkQli+EX+4/5HOXNjT2zmTVmqmGLLdXhgndSNSJk6w9NQNigp1UvQ8?=
 =?us-ascii?Q?hSxwmkcPOj6NmjnRbosLrS9i6fboNhc3Ihj1dKaf2W6NKa5FH5T4/RVh9fD7?=
 =?us-ascii?Q?ben23R5t3kvU02ur4+ya/s18d6qTdN5FSKasYlTY45Ls0zCHn9FtVkB4/rk2?=
 =?us-ascii?Q?4SVV4bmWQl6ww2msCgoYsnyyBJRA0Sz5pt9suqTgHb/vnAzm8fNHKvnACQwy?=
 =?us-ascii?Q?joshrCqAxHWUX+ec46h+45i/RPF0BIRCiqX4YJChHLll2CRaxs8X/R428/RD?=
 =?us-ascii?Q?kNXrI+7nWOOefuqqhCoi/cPf6xBDEcCF7FkmDnjggHSShaF9cBYXcBFAusGu?=
 =?us-ascii?Q?GHXJyXw256GuddgIJr3B/TXHGSIRVUHnlZvKzsS+KeStP18vYMQL19eQxmtz?=
 =?us-ascii?Q?7TBVRoYjZdUNcdJYrQxbrH9SDqnNRp5ZQygA7sMGaFEXh5RP7PRzgrr201S0?=
 =?us-ascii?Q?MexBLehlUuZz6L3JaYaF3mZoaAAjsEcGb7vLyg/2KJI9dFrqFVIHXcSJHPo+?=
 =?us-ascii?Q?n2DDI7lE3r9IBV/yrX/sGXa+aTXJhKo4vva+krwOgBLstnJ5xOn3NScFWGKA?=
 =?us-ascii?Q?WNFXpF6g4MI6FSgkZZEnDVdt2djc2FHyrn0ZXJFfTi5NMi94sNMGOCA8M+Ox?=
 =?us-ascii?Q?QMEwe6j8i59HwAmbquqj6i6afLmoXMFTuuG2N9Cd0qLPlxGFJsU8sEca1iI3?=
 =?us-ascii?Q?9vxcjQTowXzryLNhh60ZFqaIKoxtLETkXZOTPKs9SKlxNUY2mgC1iZn0Zeyi?=
 =?us-ascii?Q?mQ8ciEFDwXrHSqpc+iLdNLZTYi8sEM3hWMjiTrw/1uRwu3suC2mlUziN66ut?=
 =?us-ascii?Q?BVnnraFskGw9+v64UrhI6WEx1qMTN8eK3wlZjS6HT/HO7V2+2clqedtMINRy?=
 =?us-ascii?Q?+roYmXvvnBVBWqCSR9vYIvYbOTM6uhBHJKQqUyk74df0yJdPgyYMk72TPDOZ?=
 =?us-ascii?Q?0v3U1fVDDzksIu3BrdQhIKaYw+/MIVTYg97s7DoOn+vRp9wx/dmb336S4TyQ?=
 =?us-ascii?Q?+OqehRDPRCumJyMONHu8j3itv0s79JVMw94fh8ybrA5D3pr7oCrdmbMLJ85B?=
 =?us-ascii?Q?e2HDt1TwWtfHyiJmWk/EAwcNyXAEE6SnoCY9ycs0ejLceu+gwJCut++jIIke?=
 =?us-ascii?Q?hsVk/NjWUzlCE5T+IAOn5Hq3PyhFSL4FS9Hwch4bvUMGOe2B30Enn54hrDZb?=
 =?us-ascii?Q?mrGrTvKry/slA7OFvC4YuVF/PD4bGuQBopckQeN06maQxI5j5x18Q44iDGF1?=
 =?us-ascii?Q?Vj47d9PYxFRRc0bTlFBjeNYsrR2JVXp9WRgid/CgxqJcsTnOHrS6TOjNj9TI?=
 =?us-ascii?Q?Uz/CyoMj/ngpEddcRDNP1uUbf7QQCuwqtIfJnLA0FnQ6gxYry4KivJUuNdc9?=
 =?us-ascii?Q?WiQSIxehGDcAScf7+I/8kuttBTpTPTWmvuzJQK8uXfXkFClz0j6lUEhYNgX7?=
 =?us-ascii?Q?ysh5Kn+8Vh4RNK3BYlmlRm8GyOmiqdO/6ri40Qij?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 053a7909-670d-49d1-c464-08db2f4b7fac
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2023 05:15:51.3721
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: msTBZpslJ3EYGGU7bh9Tg+KJ3Q96CUhqwJ1c8jL1fay5NWhJy/Y5x3OKSwZBV52ShO3DTdY8+JhddtZUU1qzfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6494
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
> Sent: Tuesday, March 28, 2023 2:38 AM
>=20
> From: Nicolin Chen <nicolinc@nvidia.com>
>=20
> Allow the selftest to call the function on the mock idev, add some tests
> to exercise it.
>=20
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
