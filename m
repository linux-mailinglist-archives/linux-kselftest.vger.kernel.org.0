Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 395A468E998
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Feb 2023 09:13:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231202AbjBHINE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 8 Feb 2023 03:13:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbjBHINC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 8 Feb 2023 03:13:02 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE2233BD84;
        Wed,  8 Feb 2023 00:13:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675843980; x=1707379980;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=WrJD8z3vWyZ86FtjmOjknPhvHu/g/LFm6BYRlGdg7B8=;
  b=aHiPvMJIjBgZ8eUiDF4Un7g3UZnNAe8LsaoQ9HXaGR+zF1b8kbgwbIqy
   OwxbbJ2sWqDiZrt+ZoOTOWOagXFS7OFTQGl7Z4qMNnnSFRVtKq8PDqfkH
   VZ9e3n28eewwS6sSWFIViGunOtXbZ5iRRK7sjNgcjKQJYfe/ueBuHWk/h
   SgYP6J0StzdKPB2a9RZzurMVqhZEzdnETdjyK309SG4tPubMpA9R4XF4j
   8D3XZDQ1i27etwwpxhE8krZHAyVo6RT1pIWOlw0BysOpbk+6dVM7CleVt
   Pi21gjPkdDcVspUOibWz/bBEpKyh1axl2IFBYfEi919QpK8vd4Hl3iiRo
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10614"; a="331872276"
X-IronPort-AV: E=Sophos;i="5.97,280,1669104000"; 
   d="scan'208";a="331872276"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2023 00:13:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10614"; a="617124603"
X-IronPort-AV: E=Sophos;i="5.97,280,1669104000"; 
   d="scan'208";a="617124603"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga003.jf.intel.com with ESMTP; 08 Feb 2023 00:13:00 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 8 Feb 2023 00:12:59 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 8 Feb 2023 00:12:59 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 8 Feb 2023 00:12:59 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.107)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 8 Feb 2023 00:12:57 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rvxj27a1zM9TSmf6whts2p0Hanfy+tRxnLuLLd+c9PnDud58rU04sq8sp+UU8dVlBilmv9arDGzr4gHt/8i0GZiCYQQCZPtbrLtVFWcXdCZdH6MFJ6/CEs3WUa9NdgO+zOHOJAgPgb3tIX9wkZ6zhVgrfpLpPBIessnuqXhCasj1Df1UZzEOeQCbeAFGcl2q6hMcfy9gnuscyqOIhLBlhSfhodHTLOZCAMDEX9GTG62NwA2Q/NAYOxYngHBcJmNBudJPNfGWw4GGDJSc0kRIPzZHBapy3okEk2UWKYBc7cdQSJdw5cTXiIBkIAsJJ8ERgZF1vJ4PiOknIy3MvIiDQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WrJD8z3vWyZ86FtjmOjknPhvHu/g/LFm6BYRlGdg7B8=;
 b=gjvwyX+W1+q0WVsRWPyAC0AbCpKf0IG659eDW60Q1LeAgzQgqiMv6WntQCHktorocoUhSQHcJ6qrgOnFw+osBAZmS6QxuOuKAd8ApJ6WnUZkSAIr/+27LdLwLUbGIn7dSC/wmesr7QKE6jxjvAG3QVvERv8RWnBByUpWdnICoh9yPEpWzKYdT5wNH6Y+ZA+IbgovwHTPcOzBnr5OqlwlCbK6rMUVSiUStkcJeHv28VP7DbBTSlCLZPFWecSxuv8EdUoIYoBVOHPwFMYCYA25SZ/IRgyRVbm5ojLfFiy7FcbvHKHIRQMMkvZ1GyFwMGzdcKpTHyNHvZVvrPPsqWwp/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by PH0PR11MB7494.namprd11.prod.outlook.com (2603:10b6:510:283::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.36; Wed, 8 Feb
 2023 08:12:56 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::e1fa:abbe:2009:b0a3]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::e1fa:abbe:2009:b0a3%3]) with mapi id 15.20.6064.034; Wed, 8 Feb 2023
 08:12:55 +0000
From:   "Liu, Yi L" <yi.l.liu@intel.com>
To:     Nicolin Chen <nicolinc@nvidia.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "will@kernel.org" <will@kernel.org>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "shuah@kernel.org" <shuah@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>
Subject: RE: [PATCH v2 08/10] iommufd/device: Use iommu_group_replace_domain()
Thread-Topic: [PATCH v2 08/10] iommufd/device: Use
 iommu_group_replace_domain()
Thread-Index: AQHZOzoWMUUVTAZYTEmJ999vMYX83q7Es4Xg
Date:   Wed, 8 Feb 2023 08:12:55 +0000
Message-ID: <DS0PR11MB7529AFED1A0F681F8C5A52B9C3D89@DS0PR11MB7529.namprd11.prod.outlook.com>
References: <cover.1675802050.git.nicolinc@nvidia.com>
 <4653f009c3dacae8ebf3a4865aaa944aa9c7cc7e.1675802050.git.nicolinc@nvidia.com>
In-Reply-To: <4653f009c3dacae8ebf3a4865aaa944aa9c7cc7e.1675802050.git.nicolinc@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB7529:EE_|PH0PR11MB7494:EE_
x-ms-office365-filtering-correlation-id: 941fec8e-f174-4eed-f916-08db09ac482c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: omvcrc9SczzA9C5+S43xkhq2O4r0JJBWZdEaCM420MS9QJpY67gbBd5S67GpjvfNjCaSyefuaf2lTVrAlyk4MgQpVfdimfL/qNi6BsjhPBN0t/7YDb4FpIEIEMWrkbTzKrl4Kwzxy7R+M6VpU5jZqVr+oHDMKutyIQTfS6Gu6mp5CWUKoglLHgrm7/b4WPxwGxcu2inxvDMNB3Ox+JMV+CvnQuThRAszawIgT8o2vGGPpjY4Dqs71PKCFHJtzp8uqx8OiQxkgaaHES1dhEoNKWzpfcloWCu+CKWMvtwKVKiEj+ML0MOm8uilgNWlWM7mbI9dGdxNc/WL/o0iYsTBPUFgms2jDWHYs1t+qXcQqGzJS4eJWVJhqBwTB6j8mWR43hsn2Vi4I0o3TcfJpDay7zs1jHA8dcWFYw+TfWLyt/68GA4GJi6Bad92hh5b2RepIvVvfaNfhPIIg8DJjX47KHtl2yVN7VX1N7bbsevSYm6ekw59J2i7r1AZqmj4AOq6xPWonxqYK+KE2eF26ooPs4aCeVrKqcSNWiDV9hFli3VQlS8hvra9/h8YeqAbecz6C/hdHVKKja227fUDda7g/04bT7xpzecV5wXVC4AZQtvzLekrnHm/dxA5ID+IuBOFsoPnPu1PN++YQzBv+Ds2qgYnbI/yCosgHi3RCm+ubD+DakFRN/oiVPKRb0KKOrx6tpJTgvSwiudTGTJhiVRKPQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(136003)(376002)(39860400002)(366004)(396003)(451199018)(186003)(478600001)(9686003)(33656002)(86362001)(558084003)(5660300002)(8676002)(4326008)(26005)(2906002)(7416002)(52536014)(8936002)(55016003)(41300700001)(6506007)(64756008)(66556008)(66446008)(76116006)(66946007)(66476007)(38070700005)(71200400001)(122000001)(7696005)(38100700002)(82960400001)(316002)(110136005)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?tktyfoq7Q/Or7EidwppXyw4Yls/ZdlWgaQDHDVRmeYbqwV6u0FVhnJVFx6ze?=
 =?us-ascii?Q?P31a2zlqfUHuzhnK9v5iUi2T1QCFILvyOy9axKOr5OJ9R+Tb8ov77S007gnV?=
 =?us-ascii?Q?p4J/iPLGqm8n5VJ06wSeO+R+A9rWQZEMk2QQfJgRp1jHY0nlEJfiLURHfUrf?=
 =?us-ascii?Q?3ZMxkJse2npBM57ldsqm/r4mZ0Sk1HPG2XWWkPdZe45vhuXgufBwa9E67Ie1?=
 =?us-ascii?Q?1WweQCkfIWuS1FJF42xnnnP3Foa3LsM6d+4sf74LzAPzzzl+ULsfVBIxV8z1?=
 =?us-ascii?Q?UVip4D6CnV47JRDwV2kDe3fpXvxCcICThJdkWniSPHj5R0irfldiYfyI8hfQ?=
 =?us-ascii?Q?nDACj1ZdxXvzTpuC+B73oPSo7es5QrjxXdg2SDTJlPFY2hCvMvcSlv9AENYa?=
 =?us-ascii?Q?8AXoBGj+9KuXwJRn+z3/NGjpfSbTL10tHbim+Rfv2DlKsjZ5lcoQrCuK4DRA?=
 =?us-ascii?Q?TJZr2aMwS7OiB5pGdzkPnjMhHLdWEE8wdxhDOpo5BcHYpRtid7O/G0n60Oo/?=
 =?us-ascii?Q?XXZ3cAPpwg7GlXYHXpBnLSpT7t2LZ5BlcwNQHDRs8/OFKieKsVHn11sPmvM3?=
 =?us-ascii?Q?bvwOXw5TfFQ1kqPkXhRM4CE8v67Sx+OUAWm4d2e3W5kxQQrdnUK2kYWRW1Hq?=
 =?us-ascii?Q?QY0pjCarKK9FuEeNeAezv0DWV8u9X/hmCFfKsUMj2aL19BFTz8MgDZdKk74M?=
 =?us-ascii?Q?ByQysTjE7G2xFoPvffGhKD6m+ofjNkwdHwecJUSLNDtGHMyjhlqBrgWdKNVm?=
 =?us-ascii?Q?fIqVGdWTEIaS8KZe/ro0EqPgftGg+ojp2BWRJ6/nnZjaThTYE3BtVR2Y4Hry?=
 =?us-ascii?Q?l05Soyzcbooe9w7orXJqxx9TRlJlX6WLCkZQTo5XV0CTNE8LjbmsvsuzowT3?=
 =?us-ascii?Q?e1YXPLxleTzPX+mwc06SQfc4Gv959b0Bdx7nfp841UMjruV86XoSiiwYv/c4?=
 =?us-ascii?Q?6wxtCjF5Yts+l48zinXSJJ14Gn7aeMS4RNHWi4Q9iAYtIz7mA4cl7/fyjD2m?=
 =?us-ascii?Q?L75nqgGYPR8Ez/9S2Y+uu8qaj8AsM3ti/ZOBYvJ5gXglMNTqQleYVy1NoAOk?=
 =?us-ascii?Q?4iBNiKbQyDr3p6ctdbbye7j74y29AK+ZiREiv+4Jj54lhHxJJ07GBrQ+/Hwz?=
 =?us-ascii?Q?jBkKe19BjUgzdZxmacJRlQp8ATARAfJXoyzHqCy5OKq+r9I1Zr6Fs2BUxXyZ?=
 =?us-ascii?Q?K9W1ToQ4mups4PQ52uDsCqm6FQMq1fDe/rtPGA//VLqUTan6MInbPZbZ2f9t?=
 =?us-ascii?Q?cxBcYusMgO6m5XjObnFz2pCK0m5AOQB19gmMcTBbMENFHKAqCdIa7STudj8r?=
 =?us-ascii?Q?yHfTZ11RDuLcrKTKMP8WcmPI3somAzUzsbsDrOxZTSmDszdFooyQFekug4zz?=
 =?us-ascii?Q?9lFmffZK6pUeega1jxr/kGs4fSwwKlcN9nEToZZQlrBGPHStZrgs7gcCuwmP?=
 =?us-ascii?Q?98cZAZcV5B/fH9n6dn3Do0gPeH0KD0yeY6yOjTkascgzKzWYfNrknxhDA9Ks?=
 =?us-ascii?Q?XGKHOGAIhnVQLLS3eik2jjJsGr7/Q6JdcloFmII2eLmkOsi9iDobxH79/CjN?=
 =?us-ascii?Q?0pc9HuPrihc4DJjj/bAHSawSQdEKkKaJt4tLPGuK?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 941fec8e-f174-4eed-f916-08db09ac482c
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2023 08:12:55.2399
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Tpz908NcrBGnJ9VLc3UKjmeJrCJ+Gv7jNsXY4i5nIWEavMxbrApN5nv+ffVoIyJguWK2THbrqA30/HgOlTLedg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7494
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Wednesday, February 8, 2023 5:18 AM
>=20
> +/**
> + * __iommmufd_device_detach - Detach a device from idev->hwpt to

Nit: s/_iommmufd/__iommufd

Regards,
Yi Liu

