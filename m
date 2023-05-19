Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55E7A709107
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 May 2023 09:52:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbjESHw2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 19 May 2023 03:52:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231495AbjESHwL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 19 May 2023 03:52:11 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB089AF;
        Fri, 19 May 2023 00:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684482707; x=1716018707;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=FVhh73q+zmVgrnAYb4N/PvFZOcNAyGY0QTbDMamxplA=;
  b=Jt08PsALoF+KMxo3JcbMiExf/iqj5ui4Q5kRQ9LT9bCmoL5JBxRctiXE
   jsEAoIeHfOYiGvEJQJbe7XS4PgXgjG8p1GLxQy8nryICe9GhAqMAz4GFb
   Q8XxpGxsRBNyYQnjkB1Tv/DiHMX8IXwKq9368CGaaTjSTqdWmij/GIc7p
   RmENIC6KbQoukWymOguba/2puzOHfkiDGpwlka0PD1TAVQhD87DSvYCFc
   6TCnJLerMyBaA8jFce6Mit27JKIdrduvTTF/tPJDeeIPyMfiL0aP78CEE
   HfwZSY7LfAbl2mLluLeGgbriLbuwMNYl/G0ow8pr2OBNXK6YmZXYBCkMM
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10714"; a="336901470"
X-IronPort-AV: E=Sophos;i="6.00,176,1681196400"; 
   d="scan'208";a="336901470"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2023 00:51:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10714"; a="814630499"
X-IronPort-AV: E=Sophos;i="6.00,176,1681196400"; 
   d="scan'208";a="814630499"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga002.fm.intel.com with ESMTP; 19 May 2023 00:51:31 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 19 May 2023 00:51:30 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 19 May 2023 00:51:30 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Fri, 19 May 2023 00:51:30 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.170)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Fri, 19 May 2023 00:51:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TfGBaUy1SoEY+10zMutE5Jr0/FMjhAThhCFpF0VxW+qva8Hm4rIhPjiVFRUm5jmI8ZBM71IsPiiR2tNj0KDURL1CjRbi01XT4WTWCxtaahFX+bm27LdLo43hpVh8zDQ8cMGTmbsvh1C0x1ERhpzOjlP6LVJkDhqURYc2/2JkmLUweV7ovdjS7qeH+MCX9vi+FhHiSqrUhWz6GBpMX5kAo3uvEpvHZOzeHJDp4fhGct/ntZzBuuWh0Ah0iG5Q7JhERhjHlyps9X9jO7eTWvPz+rQN05Bti3eoDO33tnTwBzZnIyj9LJGdw+C61Lzqywm1xxzBu4YW5AhGK0fXS/9s2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FVhh73q+zmVgrnAYb4N/PvFZOcNAyGY0QTbDMamxplA=;
 b=aYVCdqU+OyDRel6Pe0LDU8Z3q5PDtmKVsXeZdLtN1sViPLzAS3P+1aWPAyxg4aujCfIiovc71I2zbmF8I3uHe5q8LW7KPZ0adtKXPba8sioLdOgZwscGGqP0pZmpRQl+BL7x+zIhsMW+K6Kf+iC+m/SEJIESRtfe7WxY7zwAUwDBFNf51ABfV+t3lWHOTpn5yh5Nnzo/IqnA9aUUvWwC+L0H4ady0IDhyR049yhp/vUS+WM77L6bkWxrEfdVxRlFZKzn+rfX49oaNXgo6LksJ1zG09uFlCq+5sHLIuNmknIwdGp/a1Rj3yb2FbACYBhZjozVH4Ks8RgaIQWtdCbGJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by CH0PR11MB5505.namprd11.prod.outlook.com (2603:10b6:610:d4::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.21; Fri, 19 May
 2023 07:51:28 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::73e9:b405:2cae:9174]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::73e9:b405:2cae:9174%6]) with mapi id 15.20.6411.019; Fri, 19 May 2023
 07:51:27 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Baolu Lu <baolu.lu@linux.intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>
CC:     "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        Lixiao Yang <lixiao.yang@intel.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        "Nicolin Chen" <nicolinc@nvidia.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>
Subject: RE: [PATCH v7 03/19] iommufd: Replace the hwpt->devices list with
 iommufd_group
Thread-Topic: [PATCH v7 03/19] iommufd: Replace the hwpt->devices list with
 iommufd_group
Thread-Index: AQHZhzWsuSojdONTVkS/71F/KrGa6a9cNqkAgACemACAAQifgIAAJcFAgABobICAATPCgIAAUyOAgADq+YCAAF65oA==
Date:   Fri, 19 May 2023 07:51:27 +0000
Message-ID: <BN9PR11MB5276AD3BF723E6002FA45E7F8C7C9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <3-v7-6c0fd698eda2+5e3-iommufd_alloc_jgg@nvidia.com>
 <569b959e-a702-fc19-3d67-0dde4e77251a@linux.intel.com>
 <ZGN2yvhpIvrvu74r@nvidia.com>
 <852e85b3-9fd2-bfc2-6080-82cea7ab6abd@linux.intel.com>
 <BN9PR11MB5276DE1BC30E90B1032C0E468C7E9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZGTMCSJKvgpyYxG/@nvidia.com>
 <5cdc1a83-f29b-6862-d513-dbfd5c500807@linux.intel.com>
 <ZGYT8RmGM+vwNzDa@nvidia.com>
 <d99e284d-31b1-6d04-cf14-d7b160ee3f44@linux.intel.com>
In-Reply-To: <d99e284d-31b1-6d04-cf14-d7b160ee3f44@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|CH0PR11MB5505:EE_
x-ms-office365-filtering-correlation-id: 4621d18a-0be8-4433-7a0a-08db583dda02
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4Bq+6Wml/36x9+D6KXeRtPNp8A1/v5T7i4pkx0EMCsgOvzAVs9SYhJcBZ2Fvf9MG4vaefxbD+eK7kGOYCrcpB8pP/5NqZYHFHB83AV4m8nPOQy/+YoTxgGqYwf76J+t8rpBZgAeR+N2D4HaevXbyGrlAHL2btu+MBGvMIqbqQSMESm6A8EkY4w37GlBm1JP4iHj5Lslb7FeTltwORbtiHFZRRvfq5imID5ZtOkANakPIwJMiVKr6s5YsxxG19+lMwugOnBk25SfhDoNMn7LbT7qZ2GNNAH0NEKu6Wr2C+BZaczE9wakR/xyi90xqhqgqW7mKMqNHyn3tth44U+inCl+5l7+5MT9wYyzz1xCw/a8B4wxK0D5f6Xl7eLNRjLbk3nFzvxOS4tpjjTd3X3uAAEnEKz2IBbfjIzEUYmDS3yko0AFyYL5E43hT9NRuHevENPwNb2H7kwrrc/z3GA8D1H31Lsv6UAep/GeDl5L3f77UpphP+sH0o53n7hYfROOmIZgoaJQdegLNRQs/icmuH0yAO7Zz2FwqrHuETz+qW9ktCMCsao1xk5e4OXJSfvcHV+gQHePlkHp2t6DkRLsrE7F5LQIwXBL99oCRATP8IuinC21doDv9CAYW3vf1q5uq
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(39860400002)(396003)(136003)(346002)(376002)(451199021)(86362001)(38070700005)(33656002)(110136005)(54906003)(316002)(4326008)(76116006)(66946007)(66556008)(66476007)(66446008)(64756008)(478600001)(7696005)(71200400001)(55016003)(8936002)(8676002)(5660300002)(52536014)(41300700001)(2906002)(38100700002)(122000001)(82960400001)(6506007)(26005)(9686003)(186003)(53546011)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V1V0TXBLZ1BDdU5mVlNnMUZNRStud0h1ZXpra1Y5Y1ZCV3FiYTZydVdCTmp4?=
 =?utf-8?B?QkxzUFpBSDlSUTJwQnBQSkkvUzRmWjJkYlhzTWpxWE1SMytHaXNBdGVDMTdJ?=
 =?utf-8?B?WnFKVUQwNjlra2prYTJJVnV1SHpnK1hOZnovdXViVWlWcm9yUnJTbjVVeUZx?=
 =?utf-8?B?YS9iOVVaOW83OTNHa2tRWjRJSWNhcHg3M3FGT25nSFRLVmMrUU52WjNFeTcv?=
 =?utf-8?B?aVpCbzl5VTBNVEtBQ2dhUW8vYmIwNk82RHdCMEdVbUM2b1B2SWtGdWdpNkJW?=
 =?utf-8?B?anpUZmp2cE9vU1Z5MDBIUjAyUFZWeld2azA4T21oNkpFbnM1UkZPeWJiT0Nn?=
 =?utf-8?B?UjVYQ3VDTDVKdG9BeUdIWDB2dFUrb1NxUUpubWlJY2lYcnhPTnBPSjh2RlRR?=
 =?utf-8?B?UHllTy9FdG1wTE9WUTA5N0F2VVpzNW8zVmo0OURFNW0vN2ZKUVNZQzl5N21E?=
 =?utf-8?B?ZktwZE5jZXhXeWx0c1FhL2cvbG92ck1aVlFvcXJ6K2JQVHJ2UjFYNUhMYWVV?=
 =?utf-8?B?RDltYUxiS3QwOW9vcUd1WTdNd1NzWnlHNVdZek8yLzNWb1hydGNRRVNpMjRy?=
 =?utf-8?B?Zll1SFlvd1dtcXhGWHV3MlhOdUdHSWFRTXQ4ZXVhTWdyRzJpZW40aHRtbGJE?=
 =?utf-8?B?bWdSbXdRM3VpSlNqTmEycW1VL0xFWjZFN1hNdE5zU296WnFrTmRHNy9aM2pK?=
 =?utf-8?B?bXhyNFhaY3FIdmpQUnVOOStyTS9PaG8yR0dydkZuNzVyQldKZTR0MzQrUkxK?=
 =?utf-8?B?Sk8rWCt2clJPN0dtaXhqTzM1Nmc3WlFJdFBNai9DL2NvelFBTWlvMTFrdHl0?=
 =?utf-8?B?MDhtTkdkVi9Rd0hpVnNMaTVUa0hVMTZnQnI2UmdVblBPRGlWeDQ0ajhDWllC?=
 =?utf-8?B?OW1BVGUwTWdpdUNhUklGUWJSNEx5dFVLSEgyV3ZObzZBbmxrYjlkelNLREhJ?=
 =?utf-8?B?SHFDMkNjUmJBTXZJTis4VUJmc2tGTzBCY1g3TllxeTFEaGcwVm4zU1o5TGp6?=
 =?utf-8?B?dmJpZzZsZEpKcktUc0ZWVlMxaU9iOFdxRnN4R1ZnNDcrUVpGOGxXTWlET0xv?=
 =?utf-8?B?eHAyMFNiS2JiZXpYUStvVUpicnd3bHJmaURNWTJzOEROTE52Y2pobFhlbUNt?=
 =?utf-8?B?SzRhVEZIWEwzRlJUYzJtWGVXWHB1SUlvclNYYmh5UkpkdS9NZ0t4eXF6TWow?=
 =?utf-8?B?aVpHVmlPQ2JVNVZOOE1HeTNqN0JPUGdTRkxiLzhEbGRZSFpDWjFYZVE5QW1o?=
 =?utf-8?B?VHdPMTNycUhML1pkYlJ1ckNlN0J3Z2c4bkR0QU1WWTM2QjExaFA2NDdRdTYz?=
 =?utf-8?B?MTVtNTUvN1ZUVkxwUURpOFl2cXh4RWxNckhVYk1Eb0c0N0NHRHBLNnVleHV5?=
 =?utf-8?B?SkM4alkzejZNekE4VDA4Z0xIbElPdEFRanFMQm9uTVFRZ2VCMktGTGk0K3Rx?=
 =?utf-8?B?Tk56amFZYXozQWNQMVJnQWg3L0NHaFJ1aTBFbVFLSXIrV01tY1ZpaEVrRFFa?=
 =?utf-8?B?UnhPRy9hWFR2VDBFQ3dFMGlpanRFVmpBM2FSSHBzM2ZaMVhucHoydmVBMWVP?=
 =?utf-8?B?ZmZGenZoZ0szZWlLOGdWUkw4L2pMVU9TaGFyMERsQUNsdzAySUc0c1RlU1VE?=
 =?utf-8?B?OWxlNkhaWEZyb2xHRE55bzdIYWd6dlg4RDBVbUpIeHF4dHlBRHJxR2phTlUx?=
 =?utf-8?B?R2U3TnQxY25JdXp5R3BKRTVCWUxlL1NtaERWYU1OSlI5RHFVSkVLdGlUZlhN?=
 =?utf-8?B?MlV0c2ttWnpGdTEyYWhFU2lSU1QzbldUeW5KOEJ2dkEwMlJyVkllNjFjdVlY?=
 =?utf-8?B?blZ5YlVqc0RJUVNZajNQT2NvRkdXZUpDdGwyOEtjUFhFTVZzMno0OTNXS055?=
 =?utf-8?B?dDk5UWlQTDRNbzN4bUtmaXRmUE1FRk91cW5nRy85RHg1cHlVcHB1UmJRcERy?=
 =?utf-8?B?WCtiZUlaSEJhY3llNDRBV0NTUUJZK3NPRDE2WmFadkNNVEdZNk9NK3pFRmw4?=
 =?utf-8?B?OU9nK3hkRWJWd0NxaUxET3BuYmh3d3F4MDRqUzF4clZjdmRnQVJGam53MVNt?=
 =?utf-8?B?NTFJbjNtVzJmeWJZbzBTd3FXUW95czhCTVlqd2hGTDZFMVNQVVV6eUlQR3dm?=
 =?utf-8?Q?HLq0xdCwQnWTrkDGhRqQRpjZO?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4621d18a-0be8-4433-7a0a-08db583dda02
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2023 07:51:27.6806
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2Szn84B8EaQN3UurvVMzTjTH3buZbSkEXhIYZgTSjvo7ikXA42+X2PcEgvcGZjsDx1KOIziJqZxnOQBJosAsjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5505
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

PiBGcm9tOiBCYW9sdSBMdSA8YmFvbHUubHVAbGludXguaW50ZWwuY29tPg0KPiBTZW50OiBGcmlk
YXksIE1heSAxOSwgMjAyMyAxMDowNCBBTQ0KPiANCj4gT24gMjAyMy81LzE4IDIwOjAyLCBKYXNv
biBHdW50aG9ycGUgd3JvdGU6DQo+ID4gT24gVGh1LCBNYXkgMTgsIDIwMjMgYXQgMDM6MDU6MjNQ
TSArMDgwMCwgQmFvbHUgTHUgd3JvdGU6DQo+ID4NCj4gPj4gSWYgc28sIHBlcmhhcHMgd2UgbmVl
ZCBzb21lIHNwZWNpYWwgdHJlYXRtZW50IGZvciBBUk0gYXMgYSB1c2VyIGh3cHQNCj4gPj4gYWN0
dWFsbHkgcHJlc2VudHMgdGhlIFBBU0lEIHRhYmxlIG9mIHRoZSBkZXZpY2UgYW5kIHRoZSBndWVz
dCBzZXR0aW5nDQo+ID4+IHBhc2lkIHRhYmxlIGVudHJ5IHdpbGwgbm90IGJlIHByb3BhZ2F0ZWQg
dG8gaG9zdC4gVGhlbiwgdGhlIEBwYXNpZCBpbg0KPiA+PiBhYm92ZSBpbnRlcmZhY2VzIGlzIG1l
YW5pbmdsZXNzLg0KPiA+DQo+ID4gQXMgYWJvdmUsIHdoZW4gYXR0YWNoaW5nIHRvIGEgUklEIHlv
dSdkIHN0aWxsIHBhc3MgaW4gdGhlICpkYXRhDQo+IA0KPiBZZXMhIE1lcmdpbmcgdGhlc2Ugd2l0
aCBod3B0IGF0dGFjaC9kZXRhY2ggd291bGQgYmUgbW9yZSBsb2dpY2FsLg0KDQpQcm9iYWJseSB3
ZSBzdGlsbCBuZWVkIGEgd2F5IGluIGlvbW11IGNvcmUgdG8gZGlmZmVyZW50aWF0ZSB3aGV0aGVy
DQp0byBsb29rIGF0ICpkYXRhIGFjY29yZGluZyB0byB7UklEfSBhbG9uZSBvciB7UklELCBQQVNJ
RH0gd2hlbiByZWNlaXZpbmcNCmEgZmF1bHQgcmVxdWVzdCB0YWdnZWQgYnkge3N0cnVjdCBkZXZp
Y2UsIHBhc2lkfSBmcm9tIHRoZSB1bmRlcmx5aW5nDQppb21tdSBkcml2ZXIuDQoNClRoYXQgbWln
aHQgYmUganVzdCBpbXBsZW1lbnRhdGlvbiBkZXRhaWwsIHRob3VnaC4NCg0KPiANCj4gPg0KPiA+
PiAxKSBNb3ZlIGlvbW11IGZhdWx0cyB1YXBpIGZyb20gdWFwaS9saW51eC9pb21tdS5oIHRvIHVh
cGkvbGludXgNCj4gPj4gICAgL2lvbW11ZmQuaCBhbmQgcmVtb3ZlIHRoZSBmb3JtZXIuDQo+ID4N
Cj4gPiBQbGVhc2Ugbm8sIGRlbGV0ZSBhbGwgdGhlIGRlYWQgY29kZSBmcm9tIGhlcmUgYW5kIG1v
dmUgd2hhdGV2ZXIgaXMNCj4gPiBzdGlsbCBpbiB1c2UgaW50byBpbmNsdWRlL2xpbnV4Lw0KPiA+
DQo+ID4gVGhlbiB3ZSBjYW4gdGFsayBhYm91dCB3aGF0IHBhcnRzIG9mIGl0IGJlY29tZSB1QVBJ
IGFuZCBob3cgYmVzdCB0bw0KPiA+IG1hbmFnZSB0aGF0IG9uIGEgcGF0Y2ggYnkgcGF0Y2ggYmFz
aXMuDQo+IA0KPiBPa2F5LCBsZXQncyByZWJ1aWxkIGl0IGZyb20gdGhlIGdyb3VuZCB1cC4NCj4g
DQoNCnllcy4gQWN0dWFsbHkgdGhhdCB1YXBpIGlzIGluY29tcGxldGUuIEl0IGNvbnRhaW5zIG9u
bHkgZGVmaW5pdGlvbnMgb2YNCmRhdGEgc3RydWN0dXJlcyBidXQgbm8gYWN0dWFsIGNvbW1hbmQu
IEl0J3MgaGFyZCB0byBzYXkgdGhhdCBkZWZpbml0aW9uDQppcyBzdWZmaWNpZW50IHcvbyBhY3R1
YWxseSBpbnZvbHZpbmcgdGhlIGNvbW1hbmQuDQo=
