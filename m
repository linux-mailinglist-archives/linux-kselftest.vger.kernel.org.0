Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A485262907E
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Nov 2022 04:07:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235905AbiKODHw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 14 Nov 2022 22:07:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235865AbiKODHL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 14 Nov 2022 22:07:11 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1658311D;
        Mon, 14 Nov 2022 19:07:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668481629; x=1700017629;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=V35rOfBgRmlwsx7oMapNmea9Flf00WAELVkvDVPNPbw=;
  b=H+xKBZrqKGFrR0Y0a6vXov5puSpwO3kK4IYSpwPACPF3f56WLBrLkCpS
   uyaobP+HheNhEMsAsgbNpnaPIGQ6uae6nKZtBcdnXqhSocQ+VoQBaCNgA
   GtOuFWr7XETlImiI1x9l1g7eSA4orgo5veY/04vmu/xz+Nmz6wRUvv9xg
   4o8YXxH0wq71HIrefoHCwAGblg3xWP6qsnf21L23wSxbft+A7uaMwB1Rj
   e7Ll2nCnLGaqRDKF2w+A0IWjUfAh/xew82L/+LyqsX/MMFNwxCAybMwZB
   rTJIZP9Yl052c1zuMuHs+ik55uDhXEsKDuoFkUEIIE8JciRtjSiQ2R7lK
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10531"; a="374276196"
X-IronPort-AV: E=Sophos;i="5.96,164,1665471600"; 
   d="scan'208";a="374276196"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2022 19:07:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10531"; a="744405692"
X-IronPort-AV: E=Sophos;i="5.96,164,1665471600"; 
   d="scan'208";a="744405692"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga002.fm.intel.com with ESMTP; 14 Nov 2022 19:07:07 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 14 Nov 2022 19:07:07 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Mon, 14 Nov 2022 19:07:07 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.49) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Mon, 14 Nov 2022 19:07:06 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Az31loaddQC7h9PMPmlV4YDVA+jBVbxkFl4KAx8NQLj5wUAXFm7Wh9TH/ZG+vY7kx4wySbRKOFvISKcCALJS4MSphd3SztBWeU1zRO0sFanP9RjyUjsX0lFrRP+ppvyeicSB7+9WmbxkyxSqIQzMT3u8rngJn05lmKZ6ml4CXTNF5bvlxrBhqGP+wdxDu9E7BqiiRSAAlC2y+EuV11NghrJpiSvM9sydNW2zkEhpSt5alXms8k7zrpu5Y+0sIHulRusQ1bvyT84bLrBOuKtJc2twHxJkg5IPgbNTYQQbG0CpZBgtY0jPSieuodZy2M9fllUu2rtaFGnB4i9ReYMdLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V35rOfBgRmlwsx7oMapNmea9Flf00WAELVkvDVPNPbw=;
 b=lCufD+pmFVW2EdeHVLZk3+8SmPiwyjH9b5b3K2qqfrQCI9cIOCT+RAoDf70FjteHAPrq60Bqal+QQIDhfSJV6KkkzanvGuYjRFlnfia2jpFbTdjDHNEz4VnFVF8oN/CM3EkJ98zuy43ZLJ2H3MZhFF4VlMYpCVtT0re4SURebUCERHeKAp6KgDb+0RHmLkBoK28bP8Rx85YkIJCfi72GHZwTjgY8VQEbaeygIxwcml0lfGRKTs4scMdXKmGlqSyMUSVUDnUiHKk/8eNtUE2YO9lC3qDIK+UEYkmXdzx2gNF4wqb8NA8GPJAYhlK1oybuLXi6RWiRfNc3Q1y+TwwC0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DS7PR11MB6150.namprd11.prod.outlook.com (2603:10b6:8:9d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Tue, 15 Nov
 2022 03:06:58 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::737e:211a:bb53:4cd7]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::737e:211a:bb53:4cd7%5]) with mapi id 15.20.5813.017; Tue, 15 Nov 2022
 03:06:58 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        David Woodhouse <dwmw2@infradead.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        Joerg Roedel <joro@8bytes.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Shuah Khan <shuah@kernel.org>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Tom Rix <trix@redhat.com>, Will Deacon <will@kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        "Chaitanya Kulkarni" <chaitanyak@nvidia.com>,
        Cornelia Huck <cohuck@redhat.com>,
        "Daniel Jordan" <daniel.m.jordan@oracle.com>,
        David Gibson <david@gibson.dropbear.id.au>,
        Eric Auger <eric.auger@redhat.com>,
        "Eric Farman" <farman@linux.ibm.com>,
        Jason Wang <jasowang@redhat.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        "Martins, Joao" <joao.m.martins@oracle.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Nicolin Chen <nicolinc@nvidia.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        Keqian Zhu <zhukeqian1@huawei.com>
Subject: RE: [PATCH v4 08/17] iommufd: Algorithms for PFN storage
Thread-Topic: [PATCH v4 08/17] iommufd: Algorithms for PFN storage
Thread-Index: AQHY8wv0HC8jKTqbBk2RHRrOWTCfU649tSKQgAELVQCAAJclYA==
Date:   Tue, 15 Nov 2022 03:06:57 +0000
Message-ID: <BN9PR11MB5276E1EFCCDBDFA8D6C58FF78C049@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <0-v4-0de2f6c78ed0+9d1-iommufd_jgg@nvidia.com>
 <8-v4-0de2f6c78ed0+9d1-iommufd_jgg@nvidia.com>
 <BN9PR11MB52762E5ACAAE7D7B398730D78C059@BN9PR11MB5276.namprd11.prod.outlook.com>
 <Y3KCvnLOZpGXAGhU@nvidia.com>
In-Reply-To: <Y3KCvnLOZpGXAGhU@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|DS7PR11MB6150:EE_
x-ms-office365-filtering-correlation-id: f50d2f2f-7028-4eae-d53b-08dac6b67546
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hIvb1KukqqRBP8WKKHyoXz+lfLNsomqopwuCQKs6P2y+2fSOrTAtuaz/Rwpd6wmAGpSbb3bcHIECTUx3MlgFyQYPnPO9leiyhbYsunhbpvIGoxbacZWf1bs0D46pMInbeoBBmCGdlFJT8SZ+FfvGiiHSXJ2yTVyw3wK1+oBWm9LnypVDVsmo6Gf30kHDdietrRMRinBouhl66hXarBDk7icr43XoxbnsdP14bq+eMTC7BgMOEaTNc6nAmWfFuUhAjN22Z3Xwh0rJNxH5bkXgsMrK93OUPimf0OnfK7+AIytKs74bF0SCxx5941Lz4AIDveWo3xB4w3aPwH2Q1y6E6PFoyxkKVvzCAH90KmaYINDLKDZeUpY2KP2K3nAW8zRbNZ94aYECC8BTGyWMe0QnG6ayhZDqYLw5ML0IYfDWlwdD1QeOJjb7Wpfb+KJ+brWqCWtwRoqjkkp4c1Z8FWT+vxSskc6k+IJeH/fsuVjTAZuJRP9ugtzLLq7OpmH6SIbxZkXsWWoHQLmMRN2ec0Yt+CBbdGJ3ZMCK22w4gQrhzxndPCL25MNyYC9zOopPXHU0e6eyfw2bo59MFd/E+CqP6nVc22G0sl+OIpgbPbGgHXpW64usr/FzQ3y7BOkq1PEVYbLmLvSfqm4rXSvSLJRW01Q3mQSSjLdl50YUlnZP43fPNnkTSeK/DwmU/7ORQ2EmC6UntqUvvfxyZImVZHLVLn8iHR9f425w6JeRhm3oCLRV2cSMzm32pQ31g3LTT+l8VV/eSC83lrCE6io9fJKFBw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(366004)(376002)(136003)(39860400002)(346002)(451199015)(82960400001)(9686003)(26005)(122000001)(316002)(86362001)(55016003)(4744005)(83380400001)(4326008)(33656002)(2906002)(8936002)(38100700002)(66556008)(41300700001)(8676002)(66446008)(64756008)(66946007)(52536014)(5660300002)(76116006)(7406005)(186003)(7416002)(66476007)(71200400001)(478600001)(6506007)(7696005)(6916009)(54906003)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U3B6WXR6anV4MSs0MXhvc3JYNERzRHU1RStLd25CUE1RZFd5eUVISVhibXN0?=
 =?utf-8?B?QmtRSyswYW4zYUNFMldMTVhHaTc0L1RlNXdiK0ErVno4eFI5NGpvemppbDRE?=
 =?utf-8?B?emcwTCtOS2dFemsxc2wvS2ZsdFNjR2FtOHZaZ0hqNFo1bnFNNFpkTUVGSlZF?=
 =?utf-8?B?SnM4VWJCazIwYVV6cldUYjJmWEZQZ2NVRk1MeG1NM0RpQUpHeHd4azhBZjNX?=
 =?utf-8?B?MElBSGI2SzZBSzNJRS9WTVZyR1EwOExQa1NGL3N1NlJET09wOEpoZzJXTk5Z?=
 =?utf-8?B?bnNVaU1TODhOb1JjR05EaWFIZHc5a29aZFhWVGZRaXZZcVNGQ2xwSDE0YWM1?=
 =?utf-8?B?Mm0vOS9IWjJxS0prSWpGa0Z0T1BwK0FZK3BwcFo1MitRV2c5UHBMMTBHeU4w?=
 =?utf-8?B?NmtSSWcvclNHMitIOXRSS2JHRzZFYkFxQXB0QThDaURnaXo3THZ3REl0cWdK?=
 =?utf-8?B?SjFTTjlJRTJtMis0RURMUUgzeHpxcHhoeXM3bkd2bGNjdTBXc3AwcGhzQWt5?=
 =?utf-8?B?TCszOWFJU0RlR1hDSUxiUWJYME8walVnZzByT1NNRlk3NjNaVlhYeHBpQWpF?=
 =?utf-8?B?aTVzWStiVjROcGFzMlViYy9iV2NtRy9JNkgreEJ0NGc0bXlBL1V3N2RVWFNB?=
 =?utf-8?B?cUcyeGtoMmlYMnY2WEs4bElybmZJNHJZcXJuUy92NkZUK1lpb3hhT0w3dGlZ?=
 =?utf-8?B?K0FSM245UDFJWkljQVgvNU5rMWFCKzJHelNiWi9taXZaa1Fudnh5K0pRdEIz?=
 =?utf-8?B?S3c0RVBVNFBpME5ob3lHN213VGd3NHQ5amJ1SEQwY0ZPNHVRWHkyL2lhSVNi?=
 =?utf-8?B?cGF2MjY0SjVSUmxMZ0VPaUk0dTQvNUtNZm8yKzZnZHVuYmZUdWxEbjc1NWxi?=
 =?utf-8?B?NUcrTlZWVFdSalRkc3k0cmFyVjlZbGlsZVg1VU93SzFWdi83OTlLSFBvUXo3?=
 =?utf-8?B?cEdIZ0p3RjM0d1cwR0g3Z0t6dVYwTjVHbllteHpwNi9TMko1QURGaStmOVlI?=
 =?utf-8?B?VUhBWWNXK1ZUWGF1RElVNE1UYlMxT2o2SllwYWw0Wit4dGtvUzhoZ3RWTXc5?=
 =?utf-8?B?cDJ6bkZHK2pBTGVQcE9XcHpaVndoR3lOeHM2SmU0eG9ndFV2aDltNUZKOG9T?=
 =?utf-8?B?NnZ2QXJVTlJrek1ITDB5UDNwSVhpeDVSLzBZUFd3Q2NodnJkM1gxa1VKa3R0?=
 =?utf-8?B?VWZ6bmowc2pBZGdFUXlEYUE0ays1RlQ1b1J2VVlGQ3Nvems2YVpIL0JDNjl3?=
 =?utf-8?B?RU5uaHBrclhyOHlvT01LMU01MjhzR2ZqWDZTQ2xhTkwvQldZekJsN3lrYnNu?=
 =?utf-8?B?UE5CdVcrbXFIbXhvSmN3Y3NOblBJcmZWNmhuWDN6SzZvYzhMY2V4bGVGQ1hI?=
 =?utf-8?B?K0VLZEtmMHN6TjBTQXNFY2RoUEk4U21WTXM2UHcwZWdwOWp6Wkw4dTV6cXJQ?=
 =?utf-8?B?Rm5lYWNaTlNBd0ZGYnZaQ0pVcDVqVC9DSEJmQlpqNjRYL2llbk9BTmZkOFcv?=
 =?utf-8?B?T05OcW05Qlg2Q2VNWjBTUWlNYTRuZXQwdzdLV3BGbCszb0xoOXh4dlJ5YmdE?=
 =?utf-8?B?N290ODZ0NnFtZXdJSXIxemNzazN6b2xWeklZbVo4azRaTVNWOWJPbDdWVHZJ?=
 =?utf-8?B?MUdYN3E1aXI4MUx5MlY0OG8yTWN0SmxqR1dGZ3V4b0djVndzc0ZqaW8vYlBq?=
 =?utf-8?B?cEhMdFE5cURNTW5nZzBGbHkyR3VaSmJUeElYb3ZOUVVGQWFKcU5WNmV3N21B?=
 =?utf-8?B?ZFdJbkV2V3lIMk5zZGZ3YUg1NDRvdVgrK3I3eFlKQUJkbHpNMEpnS3QxbEdo?=
 =?utf-8?B?L05ESDhPMFVZdTNzRENhSGkxT0lXNjBhaWdObGZpQlhZZWpuQzgxVVBPeklj?=
 =?utf-8?B?UDQyeTNaQW1KcWxaS3NUTi9oSFFhNEZCOFk4R0NnVVdzZ1FTS0F4RXVhTzlK?=
 =?utf-8?B?WnJyaHRkWlAwSkpoZ0I0cDd1RlROeFI0VWFVcVdYNUE4YVg4V2ZGL285OGVt?=
 =?utf-8?B?ZXVUVTE4Rkg1NFc0YnNQYmZnbHZPd0lXbVEvTlpUS1dvblViTkVUbWhGYnBN?=
 =?utf-8?B?ODlESmErN2s2U005aWpVcjF2M0ljMFFkMm9FVDRwUVJFMnk0d200WDBqNDlt?=
 =?utf-8?Q?9mf4F5SQFV6tz/cpJ0FXazyJX?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f50d2f2f-7028-4eae-d53b-08dac6b67546
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2022 03:06:57.9957
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uN/H0BADpKXjINLrA+5MpzGaTX8ty7iHA5bilbsiSlDjGxEd9R/zVelp1ME5rQEjxUv2jblygcfk733LskhF7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6150
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

PiBGcm9tOiBKYXNvbiBHdW50aG9ycGUgPGpnZ0BudmlkaWEuY29tPg0KPiBTZW50OiBUdWVzZGF5
LCBOb3ZlbWJlciAxNSwgMjAyMiAyOjAzIEFNDQo+IC0JCW11dGV4X2xvY2soJmFyZWEtPnBhZ2Vz
LT5tdXRleCk7DQo+IC0JCXJjID0gaW9wdF9wYWdlc19hZGRfYWNjZXNzKGFyZWEtPnBhZ2VzLCBp
bmRleCwgbGFzdF9pbmRleCwNCj4gLQkJCQkJICAgb3V0X3BhZ2VzLCBmbGFncyk7DQo+IC0JCWlm
IChyYykgew0KPiAtCQkJbXV0ZXhfdW5sb2NrKCZhcmVhLT5wYWdlcy0+bXV0ZXgpOw0KPiArCQly
YyA9IGlvcHRfcGFnZXNfYWRkX2FjY2VzcyhhcmVhLCBpbmRleCwgbGFzdF9pbmRleCwNCj4gb3V0
X3BhZ2VzLA0KPiArCQkJCQkgICBmbGFncyk7DQo+ICsJCWlmIChyYykNCg0KaW9wdF9hcmVhX2Fk
ZF9hY2Nlc3MoKSwgd2hpY2ggSSBzdXBwb3NlIHlvdSBoYXZlIGFscmVhZHkgZml4ZWQgd2hlbg0K
Y29tcGlsaW5nIHRoaXMgY2hhbmdlLiBidXQganVzdCBpbiBjYXNlLi4uIPCfmIoNCg0KPiBAQCAt
MTgxOSw0MCArMTgzOCw0OSBAQCBpb3B0X3BhZ2VzX2dldF9leGFjdF9hY2Nlc3Moc3RydWN0IGlv
cHRfcGFnZXMNCj4gKnBhZ2VzLCB1bnNpZ25lZCBsb25nIGluZGV4LA0KPiAgICoNCj4gICAqIFRo
aXMgc2hvdWxkIGJlIHVuZG9uZSB0aHJvdWdoIGEgbWF0Y2hpbmcgY2FsbCB0bw0KPiBpb3B0X3Bh
Z2VzX3JlbW92ZV9hY2Nlc3MoKQ0KDQppb3B0X2FyZWFfcmVtb3ZlX2FjY2VzcygpDQoNCj4gQEAg
LTE4NjUsMTEgKzE4OTMsMTEgQEAgaW50IGlvcHRfcGFnZXNfYWRkX2FjY2VzcyhzdHJ1Y3QgaW9w
dF9wYWdlcw0KPiAqcGFnZXMsIHVuc2lnbmVkIGxvbmcgc3RhcnRfaW5kZXgsDQo+ICAgKiBVbmRv
IGlvcHRfcGFnZXNfYWRkX2FjY2VzcygpIGFuZCB1bnBpbiB0aGUgcGFnZXMgaWYgbmVjZXNzYXJ5
LiBUaGUNCg0KaW9wdF9hcmVhX2FkZF9hY2Nlc3MoKQ0KDQp3aXRoIGFib3ZlLA0KDQpSZXZpZXdl
ZC1ieTogS2V2aW4gVGlhbiA8a2V2aW4udGlhbkBpbnRlbC5jb20+DQo=
