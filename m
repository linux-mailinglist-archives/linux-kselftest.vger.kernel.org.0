Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92B647AE7E3
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Sep 2023 10:18:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbjIZISL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 26 Sep 2023 04:18:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234083AbjIZIR5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 26 Sep 2023 04:17:57 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F8EC1BD8;
        Tue, 26 Sep 2023 01:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695716224; x=1727252224;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=C9Buz+7874wRd9as9EkXZ4rGnrCazZbfJe7M4dztzq8=;
  b=UC2zx9cktmfRC9kh21Cf2l5nv5verLawkf/6fozPScQopVZ0A8mvQX3G
   fGCdwv1De4lOXt2N/MPvmKN0AwbQ6h3893UwkN3mCw/y9eFLb4+9ttm9o
   +nSlGPHkyYgq20uaAUothdgFGZ7KPIRzJY6jf84ud1Lyiozt/4PRLMl7e
   OgbxiskxxuMLS5Mzp/7nwbGXoW9QTobAoPz7fiNHlD9GUlQ5UsVuMtpyb
   FTzeM2uxtqhhfIn+eAQ9R9hX8vrqh2aqErpVViKEcldXsuWGMVcYBA1mW
   vWzjt1zNkvsib1x+UL/yCPgV+Qld2tfv1jmoKKEwhn6Ol1kTbXf8ItPLg
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="371849062"
X-IronPort-AV: E=Sophos;i="6.03,177,1694761200"; 
   d="scan'208";a="371849062"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 01:16:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="922331976"
X-IronPort-AV: E=Sophos;i="6.03,177,1694761200"; 
   d="scan'208";a="922331976"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Sep 2023 01:16:38 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 26 Sep 2023 01:16:37 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 26 Sep 2023 01:16:37 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.105)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 26 Sep 2023 01:16:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W09vSEsymc0U70kH4JPmkZvVHgJAXlhlNHDbpEQy99n1pPdMZUswCpcoAqaA3Z4cdCeyzBmgsZ+PFYX3klpfFORlbflIXY+Xpn5a7A/+2wSYyzGSptfM473cXivFgAB3xp7UBHK39Tre5ukJafCZzampQsaVjHtzPedPlpkXaDuqO01XlIcprSkL5Er3SxCnwIONPgXanGdg3U06B6t1Nj1pkeKcAHnavq/aIPjMOKofnWEMUOivB+vl40x9WnBc0rJuR1M5oT4RXQwP4laqJncrqXC4PreXgdvXklfAoThMWlZHrxQkfTzyGOeT4AX8JHGYxHu4rTrDiiN6VjJmaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C9Buz+7874wRd9as9EkXZ4rGnrCazZbfJe7M4dztzq8=;
 b=j5x7mGw1Po0BuD+snQsIdschrCOX1zNYXxlvyxEWgeSabSxQyabXKMsga2dU+2eljbZBG53g/jnxSqqmsLCEDGi6fDaTynkCHVFG+lIsikRqe94WrI8HbfylTnD8CLIqabiRhHcmuNjOVBQbhxgdzhXqGrXsvOJ8JSWQAv1H+ZVR6eIioL//V3d34Jx8gDkAb6qFgFtQisOisPafMoln9+C9LGlGfwUXdooxziduM8zPgfNJyD5jg5KGfTQw0LgIHrlnC+HrT/oTzGxpvOQ3nGhBpv4O6hzM8K/2SInyuLfi51AKb26w+hHTX/8F30hRUehxhSCgrb3428g49PGJmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by CO1PR11MB5108.namprd11.prod.outlook.com (2603:10b6:303:92::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.23; Tue, 26 Sep
 2023 08:16:35 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1bfc:7af0:dc68:839d]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1bfc:7af0:dc68:839d%4]) with mapi id 15.20.6813.017; Tue, 26 Sep 2023
 08:16:35 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     "Liu, Yi L" <yi.l.liu@intel.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>
CC:     "cohuck@redhat.com" <cohuck@redhat.com>,
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
        "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
        "Martins, Joao" <joao.m.martins@oracle.com>
Subject: RE: [PATCH v4 08/17] iommufd: Always setup MSI and anforce cc on
 kernel-managed domains
Thread-Topic: [PATCH v4 08/17] iommufd: Always setup MSI and anforce cc on
 kernel-managed domains
Thread-Index: AQHZ7GCNzWxyrCHnVkqPkBvqOzEqrbAsylxg
Date:   Tue, 26 Sep 2023 08:16:35 +0000
Message-ID: <BN9PR11MB527658EAF017FF3576667EEA8CC3A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230921075138.124099-1-yi.l.liu@intel.com>
 <20230921075138.124099-9-yi.l.liu@intel.com>
In-Reply-To: <20230921075138.124099-9-yi.l.liu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|CO1PR11MB5108:EE_
x-ms-office365-filtering-correlation-id: 9304585c-4046-498a-b77b-08dbbe68e67e
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dJYEE6prsK09QNFsXMtsxGpj0EKexrqrTci1exAy29M8WsKYH/EBojQRXT1zAhNxH41TCTVT39zlFh1H/n8YIxN1I/AM0epsC91KFn81n6qpis7OiVvzpVJEXXeS7F+EDnpyOhnux+k4T2FF+06JwADtaIZAUSD9xbCVp11cDUAf5oGKkOUqlx3esliNzr9C5JdYuRJneNtfJAZxMnhTV8iCmU+3nh6nldEJ5Objetzbj084i7T5prhoeb23jNC2nQRPrg3b/xUcfQE2UwJsNF25jkZKRx5gTetJdaTmYC+WcGWf1tjpbqd1Yr36fMD1b2WVWFR4Xr59JzuNSFiBanxShpyZEG3sgP/cQb9IkbslcHghIY9je4/IKS4/JzMduDKP3scb89UPUuOjLGsLCthCP4a27MF9cQ73XO61mic12PS6C5IjYozRqBj9oHvXiLvVHVAkQ7l6S5o/LlDEWVKL5n0sM2lC4C4RfhdaGSOI0P81zH6Ct280t13YU9P4XunJoi6Dm8cXWgFWyByMxshWS5L2B/9OOFpIa+EAEi1AyUuhPmMZu1HYOzAeK++VwTb68+NnFw0mm+Oro/qrKDZgwRnLFXUr7xkokyC9WQo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(376002)(39860400002)(366004)(396003)(230922051799003)(186009)(1800799009)(451199024)(9686003)(122000001)(55016003)(82960400001)(7696005)(6506007)(26005)(71200400001)(66476007)(66946007)(110136005)(64756008)(33656002)(76116006)(66446008)(66556008)(8936002)(2906002)(7416002)(54906003)(86362001)(8676002)(4744005)(4326008)(5660300002)(52536014)(38100700002)(41300700001)(316002)(478600001)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?GkOpyiS9IO21/chQ5D0RPLqv81a7iFndNcgwR3v0YYxqtSrghT/r14CyfGYe?=
 =?us-ascii?Q?FGOvpPraS81or9zEuYXfBqc/kJ3M96j6/HwghXdRCAKOlTgRx+5VMWQI9C0M?=
 =?us-ascii?Q?6vQIQWOv0rLiAhjDGvfWoUl0gswkqIkQj2NANl9OOBi19nYrgZuVUvdIOnt8?=
 =?us-ascii?Q?v5BmJt8nlR4GfDt0TABdZ6bYT9af5TAvZsL54gJSwaIP1dXKLPAT/kCfTIc0?=
 =?us-ascii?Q?8IB+EsYMAfXh6jufcS2wdSSwQ6wlzn6ELqrY+t0F5tokjjAgiHpSBVJpAwDx?=
 =?us-ascii?Q?mCixm91gkUYhFPnDxd2aYRyWVtEskdr/mdM4KxkH7DhUMJ8A1ert15n4K/84?=
 =?us-ascii?Q?pgHN8s6D1HlGyG51VBGCAbm+VnW/bV6gAo9rGIaAwvcg+k6ornfumx0SNESO?=
 =?us-ascii?Q?R2R8F7zhBqXcvND2ElZI+dAc+yQupzL/tVsjl+l9A/ep7DjCMqcoWJYv3LFD?=
 =?us-ascii?Q?E1oTBw+FXa7NlXE6V0ZvDkphyYmzAq+Cns0Ulu0W+Dd1+bV5WJk1jA2a+FkS?=
 =?us-ascii?Q?TI+6XCJxEC9kL0ZA47rQSq8kqLDnpcVvVHWk5PlnrIC7NX6tTiJSvxLYl87I?=
 =?us-ascii?Q?AZNWr38ozmsd2taWBLO4D6L0Wio0Zp0HFOvyLHyIn4SiMrbcMoxSoalFGyC0?=
 =?us-ascii?Q?eqIeVTB8Drb7bXhCLycVNNOroWAx8vzaBR/z1RtJlILi6ORPPQqGx/yilfOx?=
 =?us-ascii?Q?FYPjyvjOS0ZNbofqxWeXuNsSdEXSfbL1USieIZBXyQbE2p5J0Z8MHK2Wy2D8?=
 =?us-ascii?Q?Tfhikx/PEk8JidiyPRQ3CqTfwwHbiw7x683e3z9nJtg5U2EGOTI9+phAQAm7?=
 =?us-ascii?Q?CNccnnEwaC1fSIP97fgKPr5GS5QhTdqY8dlM3r2VE/WsDvLSRD1F8MW3w9Ht?=
 =?us-ascii?Q?gRzhsq6aXnlZRGP+wFWoVkTqebeRDhu5xe38nNRqj5PVTBzSP6qn1ddBc1JX?=
 =?us-ascii?Q?Xkd3T7ulv3cNkfB13v5+mqaiHSCfnaiZV8h7T2U/mtTsZ2cwkZNNuwszCSFx?=
 =?us-ascii?Q?51Nd+MTwh5zVMnnrGiJHhMm1m8rucSB3TESsQu1ALKqYFvdJm0qqvnOgUqaS?=
 =?us-ascii?Q?w9xmh1yjJDmZe75WhNP6sdqmvZPzBaBXEKVfeL5niTOjLx3qm7XYl0RVCUzf?=
 =?us-ascii?Q?jqTWPlTk2oqfed0PMUj6jtSTmeaQ9he38f6mW7Swd23b6nBztUI495GA8A9m?=
 =?us-ascii?Q?ttiSnx3JTaDlsOBpoXa2Zs4poFz7XBjY/HkQuE8gIu8dkPrwFnPOIscbsNGj?=
 =?us-ascii?Q?ACZYytv8lFSlwA9Xt1Q1g77lVez39i9tIPI9adZHtJZ0L8pU1l9aSj12zrze?=
 =?us-ascii?Q?SmcUtHi/IMgBJGaBi5SLS1fTlylzhgpEiLXqPWAdJXXTwmJVFOtt1dpZfv9z?=
 =?us-ascii?Q?yG2y6BsMkWTY5Wv3bvCidouxMTJggoCJ3KlZqkXCHV+kaPcJMhpdbhOY+to+?=
 =?us-ascii?Q?oNWxYWXLhBKW/1gd8YNNfEXgq2rExH6z9G3OXG0x8lpVSa8iKCA77mN0GMjv?=
 =?us-ascii?Q?E7ZEf/EjbuD3ZtgCk6oW/YOOMmcP4Q+4/552y0rFTtB+BwEHW4vJtuiu4V5g?=
 =?us-ascii?Q?BH9qbIA4IU7yehUe5ntLVd0ya5jlLJuFKqw1u2F7?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9304585c-4046-498a-b77b-08dbbe68e67e
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2023 08:16:35.5468
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BMTesl2UdON4rVm9wtzrJ1O46D6g8mL+leOXHMzR7ynGOvST9knM45C5pqwdAilpx3RIqW1rQwvqS/OA1/oBcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5108
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> From: Liu, Yi L <yi.l.liu@intel.com>
> Sent: Thursday, September 21, 2023 3:51 PM
>=20
> From: Nicolin Chen <nicolinc@nvidia.com>
>=20
> Now enforce_cache_coherency and msi_cookie are kernel-managed hwpt
> things.
> So, they should be only setup on kernel-managed domains. If the attaching
> domain is a user-managed domain, redirect the hwpt to hwpt->parent to do
> it correctly.
>=20

No redirection. The parent should already have the configuration done
when it's created. It shouldn't be triggered in the nesting path.
