Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D18786C2A6A
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Mar 2023 07:31:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230114AbjCUGbz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 21 Mar 2023 02:31:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230187AbjCUGbx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 21 Mar 2023 02:31:53 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14D3B13D6D;
        Mon, 20 Mar 2023 23:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679380307; x=1710916307;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=58W2k+3hh4tfuX+IFFty/ZdrTqBOWmnjrgsW3YemN58=;
  b=PCc5gfvOkNAbXZwEixyD/weCdblQzkT/tHIxOlXxjZFD3io01WyI82N6
   rqA39dyAkOWh3H1eV/XYp6LrpO+TMPJNFyU9WdCkS+kwWjJN8eLnwtTUy
   +I8sSiCu0niXVZpt+1JvGTZMC0uyO5a+jIGEbzZzvp1xcKQ2HXGScP/EU
   CzLwaDTP55211JTsC7W9Bo68k2Qmu8lAmMOdYyDpkMuUMQ5Ok4Wb4uvtH
   4fYwuFPDqOnTg7BS1KE768UQeZkXu78doHvK2sm0pHnlu1zYZKX4zAD9I
   iuoYq5BC7VHNcOWntgPj6pMlBuVkLBowZr62/UCXomP+yYOO8GgiHzWuP
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10655"; a="318512240"
X-IronPort-AV: E=Sophos;i="5.98,278,1673942400"; 
   d="scan'208";a="318512240"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2023 23:31:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10655"; a="824799424"
X-IronPort-AV: E=Sophos;i="5.98,278,1673942400"; 
   d="scan'208";a="824799424"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga001.fm.intel.com with ESMTP; 20 Mar 2023 23:31:44 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 20 Mar 2023 23:31:44 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Mon, 20 Mar 2023 23:31:44 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.170)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Mon, 20 Mar 2023 23:31:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ePWnPIv6LZfCbpv44wk4GnIxgDvfAYaGzh7bu9f2WX31QqBbPQoM98LvMyS7uxg6K3r9epNYlI4iPs6z0EP6WvLRC+Kz34Vh7F/UdDFNemkjo8C9K2ruo1EWJy6ECSZFriyAJU7IGadAhMEMHiBYO2jCLhp2UzoOSKYA3kFIMgt5TWsxABJsL4PNxGCbc2Gh7nRXI3d6pCmW12TJirKgsP+8asWQcpAqEJJdkdvuJOLwjjMoE/nYlb9z4LYla26r+gQpKVv8B+k8KR+vcY9BhkIayEaAPvvhhPllDFaA2Wl9US6MSeYs+uLtKCTqCQrDjc0FKEnX20QabxnR1kPPeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=58W2k+3hh4tfuX+IFFty/ZdrTqBOWmnjrgsW3YemN58=;
 b=EXMp/fhOmo6NiblE1CtOTESa/mU0yLxyIiY8m8LqkE4JNvL/jSV+//M9wtf/qx+q8eyCSg8uisKLDANVOCaiq7q4fWjfAktx7lIt1/A5cTjCHazCyNpkqCcADOhVUYk/N2CVFNOOgnpKqwvFld+xk8Omt2UFD1BUpd7ft4+Isa+vqYuX+AFnptH4DJdGWFnO0l2qAVw8FmBMubXxnjuz+mj1E+YhMBKVNXDmds/oAR+kL37MEX3koNTpn/WWmbeC7dqab7bf2iOQ/dJ5hAwuyegvuIfTKzD5L3/rx4ryzODIukX9GWJTJ8QmKz0eza0C6SmBRDvyq3BVbxAuRLm9Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by PH7PR11MB6332.namprd11.prod.outlook.com (2603:10b6:510:1fc::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Tue, 21 Mar
 2023 06:31:42 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::6f7:944a:aaad:301f]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::6f7:944a:aaad:301f%8]) with mapi id 15.20.6178.037; Tue, 21 Mar 2023
 06:31:42 +0000
From:   "Liu, Yi L" <yi.l.liu@intel.com>
To:     "Liu, Jingqi" <jingqi.liu@intel.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
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
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Subject: RE: [PATCH v2 1/5] iommufd: Add nesting related data structures for
 Intel VT-d
Thread-Topic: [PATCH v2 1/5] iommufd: Add nesting related data structures for
 Intel VT-d
Thread-Index: AQHZUmBbUDr/lqYncEGY8NQoQwlnI6775YSAgAjzMEA=
Date:   Tue, 21 Mar 2023 06:31:41 +0000
Message-ID: <DS0PR11MB752972C93CFF0DB623623604C3819@DS0PR11MB7529.namprd11.prod.outlook.com>
References: <20230309082207.612346-1-yi.l.liu@intel.com>
 <20230309082207.612346-2-yi.l.liu@intel.com>
 <6c8e55e0-e699-d199-87b7-04c81e7e2493@intel.com>
In-Reply-To: <6c8e55e0-e699-d199-87b7-04c81e7e2493@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB7529:EE_|PH7PR11MB6332:EE_
x-ms-office365-filtering-correlation-id: 57aa4105-12d2-4471-4b95-08db29d5ef0c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HPVlkb1e6lI8UgVgbFoQodccNJuTsZZYcrE7HjSMzX9glPaQwtqAcyOYdOWSFeftZODcC9Mx5zRJH+4Hp9plpqBjLdmOEBqMGELN+UIvr2hAaoUAfd6k/fNi2MBPOuXW6c84SUCLWXrBpukAuWnw8c/OVlYRK2kXebzF+2Iepj/1s/HGLINTGxthFC1su1z1/laggnFLQCTOe19o8kYPEXJPKVXvX8CIfozy6R8NEXlmvmL+McVkqG/BVciuQbMtZ5WVB2e0Mk/kMzk+vSBVFFEr7SsTtrIBaJ66e49AGt3OBhTibFOoiRH1nPy29NAL/9nVYPoiTl2c/iwSmeqxmUialVlW6kHo5DRoiN9JLD7fhln8gSFZUn99kTjEW/kVQNHBm5Wd9bOWYEzS4ZUiMwbp+w4xuGeY1OnvWfMl1BhK5TNz3QQhF5gfYguMxPnJeZz5ZW2BiTLxLnfEIGAf+CT7uKGUEnCyhy3HnkNglFL2KELjZz8KWaUzRJVqA6GZCdEHGoSR3Pw782R3xvZZHj+Pr53MAR1bxvmUukiaxwjkM5pzgWfIvZGZpLtq9Ad1tHjy2pK8cFtLArc/rOHYjwY1fjflMJmI7Yg4C5+tBSBJlyxRHIsJ8RI3I6bYGjerSqZVZhuY8BY/dgYab6cwb0p9IrRqbxHh4K8s99srT+jLml/fRq+NnoH6wkHeTrO+nRzObHhH9FE+GfHn4G5Svw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(346002)(376002)(366004)(39860400002)(396003)(451199018)(86362001)(7696005)(83380400001)(478600001)(110136005)(54906003)(316002)(6506007)(33656002)(71200400001)(9686003)(53546011)(26005)(122000001)(55016003)(38100700002)(82960400001)(38070700005)(7416002)(52536014)(2906002)(66476007)(66446008)(8936002)(66556008)(64756008)(66946007)(41300700001)(76116006)(8676002)(5660300002)(186003)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bHFoQWpkbmdycXZCVWRYWTllYjlEZHp3KytZVmtSRWQ0MU9xZTZFMVdGM1NZ?=
 =?utf-8?B?VVA5bkY3T04xQzdkZ0ozQ2dWOUllczh3RXpSWUZuc1ZjQjlrU092aXFuK285?=
 =?utf-8?B?QUZnSHZPRHVFQ1ZVdnI0MU9naW9taU91N0hPUlMyUTB3Y0xrUnJpRk03emJn?=
 =?utf-8?B?RXNJMkRZSTlIZnduUFRqcWJGMEF5Z2JRU2FUcmFjNFI0UGJxYmtOcUM2VzEy?=
 =?utf-8?B?S3U1TGpkcFo3S0VwSnJ0RzJHRmNxRW9aMy8rNjFON29qeElQMHV2ZGdDWDlD?=
 =?utf-8?B?QUJXVXd0bkxUNmxkWXE2c1Q2cTZXNWFYK2ROaU1nYTFQZDA2K3RELzV1MUQr?=
 =?utf-8?B?VVZ2bjhUQzl0bFpRVVl0bElzcVNheHkyd0lHVVk4UUFXbEc1VlRlQWxJSEdj?=
 =?utf-8?B?OUtXSzFtY2dNaFM4SFJIaHJ4d2M2dXdHRGtKdVhObUNPakZFNUJrK1RDa2lm?=
 =?utf-8?B?TVE0TzNxT0JhcVJyOXlvenJaRUhjMnI1ZnFUa1l6VFhOSVFNdTVhZWVSejJm?=
 =?utf-8?B?NlRLNkFLeVJJRGttNEM1bHNYMjcxQTFjem5OVUpCeDYvVnFoTU5DLzlMdXZV?=
 =?utf-8?B?ejZZcWhVL1o5VWpEcTNEeVh3TlN5Y3FBd3U1RmNwanVnMmZiS1J6bXJQOU9y?=
 =?utf-8?B?R3pxeExpQXRFQW8zN0RtRURQeTJ0eDZ3Y2pQUU5VVDNhWDg4WlZ1Zy95Q2tx?=
 =?utf-8?B?QnJkS0pYUTdDODd6ektXNG54VXhHNzhxNExpa2lUYlBvU3J4SjZEQytSejFk?=
 =?utf-8?B?QkxtcWhwTUMzVzhyTEpBeW5kM3htM083SHo4VDBEZEVnTk4yUWxDZzVYUTI5?=
 =?utf-8?B?L1g1Z2pJTEpPZGpqaEtkd2F1aEd4N0RrNXlTbnVUdU5VQ3dnNmtsblV5bzgz?=
 =?utf-8?B?RUUxaXNWUVlla09ualFES3hHcFBwNmtwRlo0R3czTFRIL2tqWUJ5SGdUYVo0?=
 =?utf-8?B?Um9qWWl0NFk5WTZaMmkxaE9Ec1QwMjE4Nm1LTWVXbXgxendmY25rSGR1bXZG?=
 =?utf-8?B?UjFYWmNyUWJZUzZCMHIvSlBoNU9tazhGUU5tT1RWUzNSQWMyVHM5ZnJZcG5V?=
 =?utf-8?B?Q25jZlowTW1qZlZrSUl2cnpWUkJnemF4d1VSeTJVdEZ1NlZjU3lNLzM5aERG?=
 =?utf-8?B?Q2VxVXJEZkJIQXNobGNlemxPV3U1TFQ3MFlGbk1yUnZIQmJ6aHN0RnBsdSth?=
 =?utf-8?B?QllvM3FDU3F6cTdSS0w1aUxvSVh2NmlaK2R2a2pSRXZXa1ZyRElhUmZXaDNI?=
 =?utf-8?B?cFpsMWhiVlVZdzQ3b2lJQ3VWQkZkaHRhaHlDVkYyMi90djdNMEpSc3ppVXli?=
 =?utf-8?B?elFLWklOV0dkc2FBY2pIZVlQWVZQTjJySDN3MUdDaWVUUTFkR3RXYWg0ZGpK?=
 =?utf-8?B?K1UyMFpxbVgyZ280cENHUnpweDlESTBLV1JqRkw0ZWordEtCbGtEOUEvbXVy?=
 =?utf-8?B?MmtjRHMwblZLMXdrU3NJbml2UGZSdlI4VWhQakxxajFLalN1SWNBYUdMV0dM?=
 =?utf-8?B?R09vMHRsdFNaeW84eUk3SFRoWStFenk2dUxCUUJRSm13NkhXalRhY0EraU0v?=
 =?utf-8?B?amVIVFNBTDlnUUFWOFkraGllTTdYY1FLMlFBTXFuMEhnaUp6ZFBNeUZJWEJK?=
 =?utf-8?B?b1JQbS91eUVVRE1XaUVxTVoyZ0k1S0p5alAxaHJsOXZabndNcCtHWlVvenYw?=
 =?utf-8?B?ejhyaStpUE90RHo5WStmcXhyVVl4eGpSbXRqYmI0TndRV0tRRVJHNDVpT2ZJ?=
 =?utf-8?B?d0NEcFFXTGdKa1lvcXBlalBDNWVOU0lPYlBZbEFxQlZNQ0pIeVZrTzNlRk1s?=
 =?utf-8?B?VjM0SFM0RzVObGFhM0QwdE40NGFVYmU3QzBkaXJBZXlQeU1CemxFWWJxcXU4?=
 =?utf-8?B?WFY0N2tURG9ZRUxXZzVpenl0QTVlSUQrVVNYd3MxcjA4R21FZVRnZ1RHL2xW?=
 =?utf-8?B?bmswVHI1VXVNRFIyMTdsay9MS0xLb3JsZUs1R3h1ekwrNCt4L2owYlp6Nm5w?=
 =?utf-8?B?TnBXcm0zYnlCK0EreWxlek5Lci90ajYzSU9BTm8xVDh3UmJzUjdsY0Z2NGR0?=
 =?utf-8?B?MmdyWmdkVHlHUjBOWEdDK3pVaHo2emFIWDkrU1RMNllsaGdIOVBRTTNuWHA0?=
 =?utf-8?Q?VJTjmHP4+RwRh2EvD+h6k9FeX?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57aa4105-12d2-4471-4b95-08db29d5ef0c
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2023 06:31:41.8078
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5O9104n17qDBMRshiM0CzB4uUL68zGy+chhm1W/5cUeOMzS/oHl4xaXPJLOE/j+MW5kIC4HGsidRGWj9i/XQIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6332
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

PiBGcm9tOiBMaXUsIEppbmdxaSA8amluZ3FpLmxpdUBpbnRlbC5jb20+DQo+IFNlbnQ6IFdlZG5l
c2RheSwgTWFyY2ggMTUsIDIwMjMgOTo1MSBQTQ0KPiANCj4gDQo+IE9uIDMvOS8yMDIzIDQ6MjIg
UE0sIFlpIExpdSB3cm90ZToNCj4gPiBBZGQgdGhlIGZvbGxvd2luZyBkYXRhIHN0cnVjdHVyZXMg
Zm9yIGNvcnJlc3BvbmRpbmcgaW9jdGxzOg0KPiA+ICAgICAgICAgICAgICAgICBpb21tdV9od3B0
X2ludGVsX3Z0ZCA9PiBJT01NVV9IV1BUX0FMTE9DDQo+ID4gICAgICAgICAgICAgICAgaW9tbXVf
aHdfaW5mb192dGQgPT4gSU9NTVVfREVWSUNFX0dFVF9IV19JTkZPDQo+ID4gICAgICBpb21tdV9o
d3B0X2ludmFsaWRhdGVfaW50ZWxfdnRkID0+IElPTU1VX0hXUFRfSU5WQUxJREFURQ0KPiA+DQo+
ID4gQWxzbywgYWRkIElPTU1VX0hXX0lORk9fVFlQRV9JTlRFTF9WVEQgYW5kDQo+IElPTU1VX0hX
UFRfVFlQRV9WVERfUzEgdG8gdGhlDQo+ID4gaGVhZGVyIGFuZCBjb3JyZXNwb25kaW5nIHR5cGUv
c2l6ZSBhcnJheXMuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBZaSBMaXUgPHlpLmwubGl1QGlu
dGVsLmNvbT4NCj4gPiAtLS0NCj4gPiAgIGRyaXZlcnMvaW9tbXUvaW9tbXVmZC9od19wYWdldGFi
bGUuYyB8ICAgNyArLQ0KPiA+ICAgZHJpdmVycy9pb21tdS9pb21tdWZkL21haW4uYyAgICAgICAg
IHwgICA1ICsNCj4gPiAgIGluY2x1ZGUvdWFwaS9saW51eC9pb21tdWZkLmggICAgICAgICB8IDEz
Ng0KPiArKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gPiAgIDMgZmlsZXMgY2hhbmdlZCwg
MTQ3IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gPg0KPiBbLi4uXQ0KPiANCj4gPiAr
DQo+ID4gKy8qKg0KPiA+ICsgKiBzdHJ1Y3QgaW9tbXVfaHdwdF9pbnRlbF92dGQgLSBJbnRlbCBW
VC1kIHNwZWNpZmljIHVzZXItbWFuYWdlZA0KPiA+ICsgKiAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBzdGFnZS0xIHBhZ2UgdGFibGUgaW5mbw0KPiA+ICsgKiBAZmxhZ3M6IENvbWJpbmF0
aW9uIG9mIGVudW0gaW9tbXVfaHdwdF9pbnRlbF92dGRfZmxhZ3MNCj4gPiArICogQHBndGJsX2Fk
ZHI6IFRoZSBiYXNlIGFkZHJlc3Mgb2YgdGhlIHVzZXItbWFuYWdlZCBzdGFnZS0xIHBhZ2UNCj4g
dGFibGUuDQo+ID4gKyAqIEBwYXQ6IFBhZ2UgYXR0cmlidXRlIHRhYmxlIGRhdGEgdG8gY29tcHV0
ZSBlZmZlY3RpdmUgbWVtb3J5IHR5cGUNCj4gPiArICogQGVtdDogRXh0ZW5kZWQgbWVtb3J5IHR5
cGUNCj4gPiArICogQGFkZHJfd2lkdGg6IFRoZSBhZGRyZXNzIHdpZHRoIG9mIHRoZSB1bnRyYW5z
bGF0ZWQgYWRkcmVzc2VzIHRoYXQNCj4gYXJlDQo+ID4gKyAqICAgICAgICAgICAgICBzdWJqZWN0
ZWQgdG8gdGhlIHVzZXItbWFuYWdlZCBzdGFnZS0xIHBhZ2UgdGFibGUuDQo+ID4gKyAqIEBfX3Jl
c2VydmVkOiBNdXN0IGJlIDANCj4gPiArICoNCj4gPiArICogVGhlIEludGVsIFZULWQgc3BlY2lm
aWMgZGF0YSBmb3IgY3JlYXRpbmcgaHdfcGFnZXRhYmxlIHRvIHJlcHJlc2VudA0KPiA+ICsgKiB0
aGUgdXNlci1tYW5hZ2VkIHN0YWdlLTEgcGFnZSB0YWJsZSB0aGF0IGlzIHVzZWQgaW4gbmVzdGVk
IHRyYW5zbGF0aW9uLg0KPiA+ICsgKg0KPiA+ICsgKiBJbiBuZXN0ZWQgdHJhbnNsYXRpb24sIHRo
ZSBzdGFnZS0xIHBhZ2UgdGFibGUgbG9jYXRlcyBpbiB0aGUgYWRkcmVzcw0KPiA+ICsgKiBzcGFj
ZSB0aGF0IGRlZmluZWQgYnkgdGhlIGNvcnJlc3BvbmRpbmcgc3RhZ2UtMiBwYWdlIHRhYmxlLiBI
ZW5jZQ0KPiB0aGUNCj4gPiArICogc3RhZ2UtMSBwYWdlIHRhYmxlIGJhc2UgYWRkcmVzcyB2YWx1
ZSBzaG91bGQgbm90IGJlIGhpZ2hlciB0aGFuIHRoZQ0KPiA+ICsgKiBtYXhpbXVtIHVudHJhbnNs
YXRlZCBhZGRyZXNzIG9mIHN0YWdlLTIgcGFnZSB0YWJsZS4NCj4gPiArICoNCj4gPiArICogVGhl
IHBhZ2luZyBsZXZlbCBvZiB0aGUgc3RhZ2UtMSBwYWdlIHRhYmxlIHNob3VsZCBiZSBjb21wYXRh
aWJsZSB3aXRoDQo+IA0KPiBzL2NvbXBhdGFpYmxlL2NvbXBhdGlibGUNCj4gDQo+ID4gKyAqIHRo
ZSBoYXJkd2FyZSBpb21tdS4gT3RoZXJ3aXNlLCB0aGUgYWxsb2NhdGlvbiB3b3VsZCBiZSBmYWls
ZWQuDQo+ID4gKyAqLw0KPiA+ICtzdHJ1Y3QgaW9tbXVfaHdwdF9pbnRlbF92dGQgew0KPiA+ICsJ
X191NjQgZmxhZ3M7DQo+ID4gKwlfX3U2NCBwZ3RibF9hZGRyOw0KPiA+ICsJX191MzIgcGF0Ow0K
PiA+ICsJX191MzIgZW10Ow0KPiA+ICsJX191MzIgYWRkcl93aWR0aDsNCj4gPiArCV9fdTMyIF9f
cmVzZXJ2ZWQ7DQo+ID4gICB9Ow0KPiA+DQo+IA0KPiBbLi4uXQ0KPiANCj4gPiArDQo+ID4gKy8q
Kg0KPiA+ICsgKiBzdHJ1Y3QgaW9tbXVfaHdwdF9pbnZhbGlkYXRlX2ludGVsX3Z0ZCAtIEludGVs
IFZULWQgY2FjaGUNCj4gaW52YWxpZGF0aW9uIGluZm8NCj4gPiArICogQGdyYW51bGFyaXR5OiBP
bmUgb2YgZW51bSBpb21tdV92dGRfcWlfZ3JhbnVsYXJpdHkuDQo+ID4gKyAqIEBmbGFnczogQ29t
YmluYXRpb24gb2YgZW51bQ0KPiBpb21tdV9od3B0X2ludGVsX3Z0ZF9pbnZhbGlkYXRlX2ZsYWdz
DQo+ID4gKyAqIEBfX3Jlc2VydmVkOiBNdXN0IGJlIDANCj4gPiArICogQGFkZHI6IFRoZSBzdGFy
dCBhZGRyZXNzIG9mIHRoZSBhZGRyZXNzZXMgdG8gYmUgaW52YWxpZGF0ZWQuDQo+ID4gKyAqIEBn
cmFudWxlX3NpemU6IFBhZ2UvYmxvY2sgc2l6ZSBvZiB0aGUgbWFwcGluZyBpbiBieXRlcy4gSXQg
aXMgdXNlZCB0bw0KPiA+ICsgKiAgICAgICAgICAgICAgICBjb21wdXRlIHRoZSBpbnZhbGlkYXRp
b24gcmFuZ2UgdG9nZWh0ZXIgd2l0aCBAbmJfZ3JhbnVsZXMuDQo+IA0KPiBzL3RvZ2VodGVyL3Rv
Z2V0aGVyDQo+IA0KDQpBbGwgYWJvdmUgcmVjZWl2ZWQuIFRoYW5rcy4NCg0KUmVnYXJkcywNCllp
IExpdQ0K
