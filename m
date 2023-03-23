Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C99486C615D
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Mar 2023 09:12:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230172AbjCWIMX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 23 Mar 2023 04:12:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbjCWIMW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 23 Mar 2023 04:12:22 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A5C320A12;
        Thu, 23 Mar 2023 01:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679559141; x=1711095141;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=xMkFHctrcHQp/KWaSOgccQzFpJSof6OSOJPSQEcU+XA=;
  b=fOuVchrXNwHbDUBkp1JirziRRAGbEVy1XDidKtwvivH5jVuLKJQg1hch
   NzQ6N7nl3Clj7YhT1YwNR4tzcePTKd5HYv9OcafBqhN0kmb7erKEZywkW
   AHBcQp+iEFiCu4jsO4eYl3R4D3tKcTbyVGnIdrF/GrCbAN3mJ8J7gSkFk
   W15y0qjoxAHkr54XryWMfS8ff9DDffVGwXmre9W4YJQfuSRNB5VJAkl23
   zDaJYtilOLCNikGJHII/1bxVOsCjSOm1A6RG0+5XfGbnJH4Bw356trBpI
   ucJ+PBVMalqXrLvxKqYGPAKdR7RPHC7jJLhy7cHbK/KQNNgPdUO1lHpj+
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10657"; a="336928558"
X-IronPort-AV: E=Sophos;i="5.98,283,1673942400"; 
   d="scan'208";a="336928558"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2023 01:11:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10657"; a="632304347"
X-IronPort-AV: E=Sophos;i="5.98,283,1673942400"; 
   d="scan'208";a="632304347"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga003.jf.intel.com with ESMTP; 23 Mar 2023 01:11:52 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 23 Mar 2023 01:11:51 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 23 Mar 2023 01:11:51 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Thu, 23 Mar 2023 01:11:51 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.177)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Thu, 23 Mar 2023 01:11:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bVYLBBU+hj4qCf5REtaCSkxyprYFkq82NPPK3+BM2CsUJ51ZWPITSwDhJTdM5Q+8sfkMu3EVqJIy2bWql2GkRxJ4c77EUsEWOKbfByeunkQm7zn7NukbMYa1wy0OaNxnh56LJqMvmrlsgNs4ytsoOhdPe6T5xr3htZLaoVE6pc/oEb0z8xBR8LfWQMaZJKBwq2N9meATj9Os8E7DA9ylmUTdtzRgiX9XBSRF/v44kw+mwFMmh/WE51F8xYFhGfC83hq1mMyNhbCMqY+9PHy7aGfPb8hZRp2qYmoVlywmiYrXO5/3rJ3lQG4zNvzDXe8yHapW2wBMGF14iWTDm06C/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xMkFHctrcHQp/KWaSOgccQzFpJSof6OSOJPSQEcU+XA=;
 b=kxqMHWWzDSPlz5jXqplEIlOgDym5653bqEmg9NHVVRPQu937keSw7qROq5ZCYF8O9RudTnDcsdBM84/c963XnHlo/PPJWw2O4V9qUYNvDlAL7WZgKbBipNqlGaZRamRKTU5eutYhEtldK0Kvcq9sDSVqnUXEJ/uj6Br1Rlro+00xeHZ9YADzA+9yqngKXddKzuZUDRnCdHm69qK1OFLzNezkCq+mMMlMNlmtxYGVbGoDqtFHGKIlfbPgLxHq7j7+SB95LEIGHKo0d1U5Vy0pbv7xxkGMywxRDtQjMM0SCTgbFZv5nttaX2tGvQMJHFdFi1VnLdstzsM5AtFYnP6XzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by CYYPR11MB8330.namprd11.prod.outlook.com (2603:10b6:930:b8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Thu, 23 Mar
 2023 08:11:48 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::6f7:944a:aaad:301f]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::6f7:944a:aaad:301f%8]) with mapi id 15.20.6178.037; Thu, 23 Mar 2023
 08:11:48 +0000
From:   "Liu, Yi L" <yi.l.liu@intel.com>
To:     Baolu Lu <baolu.lu@linux.intel.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>
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
Subject: RE: [PATCH 06/12] iommufd: IOMMU_HWPT_ALLOC allocation with user data
Thread-Topic: [PATCH 06/12] iommufd: IOMMU_HWPT_ALLOC allocation with user
 data
Thread-Index: AQHZUl5+Xwf0Y6ZcG0awNjw0BgcSa67zVK4AgBTD8ZA=
Date:   Thu, 23 Mar 2023 08:11:48 +0000
Message-ID: <DS0PR11MB7529230A7938A12CD9106284C3879@DS0PR11MB7529.namprd11.prod.outlook.com>
References: <20230309080910.607396-1-yi.l.liu@intel.com>
 <20230309080910.607396-7-yi.l.liu@intel.com>
 <a388e79e-2547-a1f3-9e7f-4959c9ccb4e1@linux.intel.com>
In-Reply-To: <a388e79e-2547-a1f3-9e7f-4959c9ccb4e1@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB7529:EE_|CYYPR11MB8330:EE_
x-ms-office365-filtering-correlation-id: 13ecba4d-1173-425a-47fc-08db2b763fe1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RVAJCZHRiCdo2ocBsm1wsSYv9ViZs+Ig8sdogvJOyoOc6DqJgLZU5a/3tJjJm9Mr6B1uxDPJ61aOsjK0wxP3K3R1rqQ0JICGlUTs5WfL7NcU09eTNsHOd5h/EcXEIHnsq3jXCvXajEfh4cAYI5nOQU31Jliwa2cLOlbJ+Gjv5PPpzKpstwNwy0Z+cTGU+ehI3d1FPANZmLQq88xIu1fSCO9f/Ip1ePLwbzg+mVlqa/HEc5Eyaq4Yd6m7GeGXEp8hFT/w7tcy2XhX0XKUZFMxOB7omnAo2Ay4cng2c74kfkKVqaa3yf3FtnLScZ20iYKUM1HxBtoPzgEa4u/ZXN1owlpOjKXB5LLjpKCvshzyHdHoKzi1G4zBy1iYGSookbt9Bb41+d1x/cm71mdC6smts0Znkc7SvtcKGn+bA/2C8Kwk6gVnPXPu7IDj8QAKOyHwZyzfSv8FyN4+AEjBmK4psMwLb82pVWDAFskIpU0oTeSEhtTBX6AGgtpyndamkSrP+K7Z2LbvjNryRXKg65sjNHl/kH68ecqwYNCl5/ulhrlTj0nBbo79dlzJQ6/+i0GRp7CRRWuJcTIe+1wesbtfZOu7qdGrAwYQBYh3R4GG1JVpbDZwyn6i1DVoJtPlVnqEIjcqiuDR1y1igAQrALKAUrsGuzK0AT5qTgzUKZE9jbhIh8mLhNtd+JHS9nnfs1s29mclsJOL7D9/C/9PpDqiZw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(376002)(39860400002)(366004)(346002)(396003)(451199018)(71200400001)(38100700002)(82960400001)(38070700005)(54906003)(66476007)(76116006)(66556008)(66946007)(66446008)(2906002)(33656002)(86362001)(478600001)(110136005)(8676002)(316002)(64756008)(4326008)(55016003)(26005)(186003)(7696005)(122000001)(41300700001)(52536014)(5660300002)(9686003)(6506007)(83380400001)(7416002)(8936002)(53546011);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QlVQcmtUcllzRVBRaW1wNVUrSjRPdzRoN3psUDVGckl4UUJXVEM3ZEJUNXVt?=
 =?utf-8?B?Z0xUS29YblZHN05oMUg3YnI1cUtvODMvUTkxUFRLazdRR0MxTkVQY3RJNERE?=
 =?utf-8?B?bVpUZWtkYzVQTmprbFN5RjZKdXZxTVdXR0dnQmoxVTEycUNyUGVMRWtSNS95?=
 =?utf-8?B?dmFwTGJyRVMvSkFFZWc3aWpVNFR2S2dFcVlxT3hVRHF2MEVPZm9EM25Ya3gr?=
 =?utf-8?B?a2MxZzROR0lGdHluaDFjcWdGWDhndWdPcjFkYnlWYVJoTUsrMVlOT2p6SlRP?=
 =?utf-8?B?RUNieDBXUUxmSnNuVStLNGJCZFFDUnZWY05HbExWZ2FUMFpzMnpzTDliRHNZ?=
 =?utf-8?B?dWpxd0srajNaRDdiOE9uZ0FnTWxPKzhlNndQeklFYTRPUFB2Q0toanZRZGJP?=
 =?utf-8?B?NitYS2s5NFZNVjljNDBtQW81d1BUekk3ZnJYVHNPVWsrNnZQSm1MTDJ5VzIx?=
 =?utf-8?B?bitJN2dEUXlyaEtFRUVHa2xnSXJ2N05lUWQrR2tzWnk0R3RrazlVZSs0RG1L?=
 =?utf-8?B?bmtWTWRkb0JGQmRVbVIrYnJWZFlGakxUcVVkb3pWdnkxTjMvc3dQVEk2NEkv?=
 =?utf-8?B?bmY2a29INm5yZDhyaUR6UHN1am9JcGlMSEpKVzNIRTdOdUs1MytJZXNabUp5?=
 =?utf-8?B?NEJiTnRhWmNuNmxPZlpkV2NvYTBEcDY5OExrY2pFSnNKVmN3R2pVMHk2a0Zu?=
 =?utf-8?B?VHNUaCtkVjNObDBWaWxiSkxWcGtnak1UaDBndFY2czd3UHVBT2VEOUlXc2Fo?=
 =?utf-8?B?bmNjc1BFYkxuNTIrSVk4d0xLWk5vWTlTZUROSzh4T01zalZLOE9kYTJsM3R3?=
 =?utf-8?B?eklhbXVLVlFmbDJFVDArWGREZ0tnZW84UW9ibTVSRVBUUmZqdnZOVG5LclpY?=
 =?utf-8?B?YUhRK2N1d2V1V1R4RHRobUdoeTNuNHV6UzVKSkhnSDBldEhjdEpWTkgxUE5z?=
 =?utf-8?B?RWMxeTBOdldZMGIzQjdhU2VnUVB1VjVJS2VWcXRjaUU0MVhNcTBWRm9IMkcw?=
 =?utf-8?B?UjR3TjdXQXdYODN2SzVkYjdWMWRFTW1xR01RWUVXVTQ3aWFMN3p1UTF0VDFD?=
 =?utf-8?B?dG8rekUvNTZ5N3dabjAwOHhpZDFYTENJR0NkNWgwVmtzVk9oS2dyTE5XYjln?=
 =?utf-8?B?QnVhN2x6WTQxWkErdmxJbm1TWkJ2eXdUblpDY0VMUDVXVDVOb2c3Y0dLTW9H?=
 =?utf-8?B?YXNKYkhoUTIyTWt4YzB2L1hBMkluTnBkelZLLzdFWXZpbWZiQThlM3RUQzNo?=
 =?utf-8?B?Z1prYWVzS0RsckJiK2l0Mys3REgzUDZnL2FoQ2lkWlcrWjVTTFlTT0h0QVNM?=
 =?utf-8?B?VDg5ZUx3VDdJcG50VzBVMUhXTU9tK2hQRVJIckVPeklVOUxQYXltT1pJcUJW?=
 =?utf-8?B?VnIvK3pQN00zUFNnWUo5czRvQXpoR3ZSRjBsQkRIV1B3RGJHWGdLbzVzbzhW?=
 =?utf-8?B?YTM3TUN5R1pPUklJd3UxWHJKV2VIWjhwMkQyclFvcVY5QlljMmJWUDZXRXlq?=
 =?utf-8?B?eUxObGxNbHJ0OU9TVURUcVkxcENrNm53a1lFUTdyUHZZOTF5TVh6WFh4NTRB?=
 =?utf-8?B?cGlEOUdDNGs0L3ZtaFpnQ1RmQUJBUHhIL0VpTjNqRUM0K0pRRStYSUtVbk9I?=
 =?utf-8?B?bE9JQVdlcGJrWm1IemFzRXRVbmIwTnIzVERRL09OaURVbmdWenozUlFHUkJl?=
 =?utf-8?B?SjFMKzJZK0RQSjdiQ1RTN0pmYmdWV2lSbDMzQ1QySkt3Z2FvaitMSmcxdG9o?=
 =?utf-8?B?U05UVytLdCt5eVJLVGZXby9GUC81Q1lOeWY0QTh2NHpKQitac2NCM0FqaG5G?=
 =?utf-8?B?WEJwOHJRQjRBalJtT0xHY1ZVQWhKYjBVejZPMW9SYVpsYWlISSs2cDRrMU45?=
 =?utf-8?B?eUx3R2RScmI5enhVZFpCRDZLa2JXMU5IRUgwYTVGMUZIa1gzVllkaUlZSUl6?=
 =?utf-8?B?dnZyNS81cjVTUzYxNkh1T2RqV1lXSm93bFk2YWVxdU1nNmhXRGZyZ1N0UXlZ?=
 =?utf-8?B?bDdDMUVMOElGSlhDM0hoOGdXSSs5Q1p6R0ZXc3N4NDd0UUh6NDlxbjk4dlY5?=
 =?utf-8?B?MGJYYUNtckhEenk5V3JGelZZeVRHbndNUEloV1FNRGp3bHB5R1VOWE9hTzls?=
 =?utf-8?Q?umoJT9wC0IPGH87IZ+qI/54hS?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13ecba4d-1173-425a-47fc-08db2b763fe1
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2023 08:11:48.0452
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HsAKLdhV2nhXlSNXHDIFdq8DjSQ3ACT71xfy1QY+cyaWgVUBYwx30XioR+8zU8C/+dqyz14ln4v/21/eWGkV3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR11MB8330
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

PiBGcm9tOiBCYW9sdSBMdSA8YmFvbHUubHVAbGludXguaW50ZWwuY29tPg0KPiBTZW50OiBGcmlk
YXksIE1hcmNoIDEwLCAyMDIzIDExOjAyIEFNDQo+IA0KPiBPbiAzLzkvMjMgNDowOSBQTSwgWWkg
TGl1IHdyb3RlOg0KPiA+IElPTU1VX0hXUFRfQUxMT0MgYWxyZWFkeSBzdXBwb3J0cyBpb21tdV9k
b21haW4gYWxsb2NhdGlvbiBmb3INCj4gdXNlcnNhcGNlLg0KPiA+IEJ1dCBpdCBjYW4gb25seSBh
bGxvY2F0ZSBod19wYWdldGFibGVzIGxpbmtlZCB3aXRoIElPQVMuIFRoZXJlIGFyZSBuZWVkcw0K
PiA+IHRvIHN1cHBvcnQgaHdfcGFnZXRhYmxlIGFsbG9jYXRpb24gd2l0aCBwYXJhbWV0ZXJzIHNw
ZWNpZmllZCBieSB1c2VyLiBGb3INCj4gPiBleGFtcGxlLCBpbiBuZXN0ZWQgdHJhbnNsYXRpb24s
IHVzZXIgbmVlZHMgdG8gYWxsb2NhdGUgaHdfcGFnZXRhYmxlIGZvcg0KPiA+IHRoZSBzdGFnZS0x
IHRyYW5zbGF0aW9uIChlLmcuIGEgc2luZ2xlIEkvTyBwYWdlIHRhYmxlIG9yIGEgc2V0IG9mIEkv
TyBwYWdlDQo+ID4gdGFibGVzKSB3aXRoIHVzZXIgZGF0YS4gSXQgYWxzbyBuZWVkcyBwcm92aWRl
IGEgc3RhZ2UtMiBod19wYWdldGFibGUNCj4gd2hpY2gNCj4gPiBpcyBsaW5rZWQgdG8gdGhlIEdQ
QSBJT0FTLg0KPiA+DQo+ID4gVGhpcyBleHRlbmRzIElPTU1VX0hXUFRfQUxMT0MgdG8gYWNjZXB0
IHVzZXIgc3BlY2lmaWVkIHBhcmFtZXRlcg0KPiBhbmQgaHdwdA0KPiA+IElEIGluIEBwdF9pZCBm
aWVsZC4gU3VjaCBhcyB0aGUgdXNlci1tYW5hZ2VkIHN0YWdlLTEgaHdwdCwgd2hpY2ggcmVxdWly
ZXMNCj4gPiBhIHBhcmVudCBod3B0IHRvIHBvaW50IHRvIHN0YWdlLTIgdHJhbnNsYXRpb24uDQo+
ID4NCj4gPiBlbnVtIGlvbW11X2h3cHRfdHlwZSBpcyBkZWZpbmVkIHRvIGRpZmZlcmVudGlhdGUg
dGhlIHVzZXIgcGFyYW1ldGVycw0KPiB1c2UNCj4gPiBieSBkaWZmZXJlbnQgdXNhZ2VzLiBGb3Ig
dGhlIGFsbG9jYXRpb25zIHRoYXQgZG9uJ3QgcmVxdWlyZSB1c2VyIHBhcmFtZXRlciwNCj4gPiBJ
T01NVV9IV1BUX1RZUEVfREVGQVVMVCBpcyBkZWZpbmVkIGZvciBiYWNrd2FyZCBjb21wYXRpYmls
aXR5Lg0KPiBPdGhlciB0eXBlcw0KPiA+IHdvdWxkIGJlIGFkZGVkIGJ5IGZ1dHVyZSBpb21tdSB2
ZW5kb3IgZHJpdmVyIGV4dGVuc2lvbnMuDQo+ID4NCj4gPiBDby1kZXZlbG9wZWQtYnk6IE5pY29s
aW4gQ2hlbiA8bmljb2xpbmNAbnZpZGlhLmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBOaWNvbGlu
IENoZW4gPG5pY29saW5jQG52aWRpYS5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTogWWkgTGl1IDx5
aS5sLmxpdUBpbnRlbC5jb20+DQo+ID4gLS0tDQo+ID4gICBkcml2ZXJzL2lvbW11L2lvbW11ZmQv
aHdfcGFnZXRhYmxlLmMgfCA5NA0KPiArKysrKysrKysrKysrKysrKysrKysrKysrLS0tDQo+ID4g
ICBkcml2ZXJzL2lvbW11L2lvbW11ZmQvbWFpbi5jICAgICAgICAgfCAgMiArLQ0KPiA+ICAgaW5j
bHVkZS91YXBpL2xpbnV4L2lvbW11ZmQuaCAgICAgICAgIHwgMzAgKysrKysrKysrDQo+ID4gICAz
IGZpbGVzIGNoYW5nZWQsIDExNSBpbnNlcnRpb25zKCspLCAxMSBkZWxldGlvbnMoLSkNCj4gPg0K
PiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lvbW11L2lvbW11ZmQvaHdfcGFnZXRhYmxlLmMNCj4g
Yi9kcml2ZXJzL2lvbW11L2lvbW11ZmQvaHdfcGFnZXRhYmxlLmMNCj4gPiBpbmRleCA2ZTQ1ZWMw
YTY2ZmEuLjY0ZTdjZjcxNDJlMSAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2lvbW11L2lvbW11
ZmQvaHdfcGFnZXRhYmxlLmMNCj4gPiArKysgYi9kcml2ZXJzL2lvbW11L2lvbW11ZmQvaHdfcGFn
ZXRhYmxlLmMNCj4gPiBAQCAtMTY1LDM0ICsxNjUsMTA2IEBAIGlvbW11ZmRfaHdfcGFnZXRhYmxl
X2FsbG9jKHN0cnVjdA0KPiBpb21tdWZkX2N0eCAqaWN0eCwgc3RydWN0IGlvbW11ZmRfaW9hcyAq
aW9hcywNCj4gPiAgIAlyZXR1cm4gRVJSX1BUUihyYyk7DQo+ID4gICB9DQo+ID4NCj4gPiArLyoN
Cj4gPiArICogc2l6ZSBvZiBwYWdlIHRhYmxlIHR5cGUgc3BlY2lmaWMgZGF0YSwgaW5kZXhlZCBi
eQ0KPiA+ICsgKiBlbnVtIGlvbW11X2h3cHRfdHlwZS4NCj4gPiArICovDQo+ID4gK3N0YXRpYyBj
b25zdCBzaXplX3QgaW9tbXVmZF9od3B0X2FsbG9jX2RhdGFfc2l6ZVtdID0gew0KPiA+ICsJW0lP
TU1VX0hXUFRfVFlQRV9ERUZBVUxUXSA9IDAsDQo+ID4gK307DQo+ID4gKw0KPiA+ICAgaW50IGlv
bW11ZmRfaHdwdF9hbGxvYyhzdHJ1Y3QgaW9tbXVmZF91Y21kICp1Y21kKQ0KPiA+ICAgew0KPiA+
ICAgCXN0cnVjdCBpb21tdV9od3B0X2FsbG9jICpjbWQgPSB1Y21kLT5jbWQ7DQo+ID4gLQlzdHJ1
Y3QgaW9tbXVmZF9od19wYWdldGFibGUgKmh3cHQ7DQo+ID4gKwlzdHJ1Y3QgaW9tbXVmZF9od19w
YWdldGFibGUgKmh3cHQsICpwYXJlbnQgPSBOVUxMOw0KPiA+ICsJc3RydWN0IGlvbW11ZmRfb2Jq
ZWN0ICpwdF9vYmo7DQo+ID4gICAJc3RydWN0IGlvbW11ZmRfZGV2aWNlICppZGV2Ow0KPiA+ICAg
CXN0cnVjdCBpb21tdWZkX2lvYXMgKmlvYXM7DQo+ID4gKwljb25zdCBzdHJ1Y3QgaW9tbXVfb3Bz
ICpvcHM7DQo+ID4gKwl2b2lkICpkYXRhID0gTlVMTDsNCj4gPiArCXUzMiBrbGVuOw0KPiA+ICAg
CWludCByYzsNCj4gDQo+IFJldmVyc2UgQ2hyaXN0bWFzIHRyZWUgZm9ybWF0LiBEaXR0byB0byBv
dGhlciBwbGFjZXMgaW4gdGhpcyBmaWxlLg0KDQpHb3QgaXQuDQoNCj4gPg0KPiA+IC0JaWYgKGNt
ZC0+ZmxhZ3MpDQo+ID4gKwlpZiAoY21kLT5fX3Jlc2VydmVkIHx8IGNtZC0+ZmxhZ3MpDQo+ID4g
ICAJCXJldHVybiAtRU9QTk9UU1VQUDsNCj4gPg0KPiA+ICAgCWlkZXYgPSBpb21tdWZkX2dldF9k
ZXZpY2UodWNtZCwgY21kLT5kZXZfaWQpOw0KPiA+ICAgCWlmIChJU19FUlIoaWRldikpDQo+ID4g
ICAJCXJldHVybiBQVFJfRVJSKGlkZXYpOw0KPiA+DQo+ID4gLQlpb2FzID0gaW9tbXVmZF9nZXRf
aW9hcyh1Y21kLCBjbWQtPnB0X2lkKTsNCj4gPiAtCWlmIChJU19FUlIoaW9hcykpIHsNCj4gPiAt
CQlyYyA9IFBUUl9FUlIoaW9hcyk7DQo+ID4gKwlvcHMgPSBkZXZfaW9tbXVfb3BzKGlkZXYtPmRl
dik7DQo+ID4gKwlpZiAoIW9wcykgew0KPiA+ICsJCXJjID0gLUVPUE5PVFNVUFA7DQo+ID4gICAJ
CWdvdG8gb3V0X3B1dF9pZGV2Ow0KPiA+ICAgCX0NCj4gDQo+IE5vIG5lZWQgdG8gY2hlY2suIGRl
dl9pb21tdV9vcHMoKSB3aWxsIG5ldmVyIHJldHVybnMgYSBOVUxMLg0KDQpHb3QgaXQuDQoNCj4g
Pg0KPiA+ICsJLyogT25seSBzdXBwb3J0IElPTU1VX0hXUFRfVFlQRV9ERUZBVUxUIGZvciBub3cg
Ki8NCj4gPiArCWlmIChjbWQtPmRhdGFfdHlwZSAhPSBJT01NVV9IV1BUX1RZUEVfREVGQVVMVCkg
ew0KPiA+ICsJCXJjID0gLUVJTlZBTDsNCj4gPiArCQlnb3RvIG91dF9wdXRfaWRldjsNCj4gPiAr
CX0NCj4gPiArDQo+ID4gKwlwdF9vYmogPSBpb21tdWZkX2dldF9vYmplY3QodWNtZC0+aWN0eCwg
Y21kLT5wdF9pZCwNCj4gSU9NTVVGRF9PQkpfQU5ZKTsNCj4gPiArCWlmIChJU19FUlIocHRfb2Jq
KSkgew0KPiA+ICsJCXJjID0gLUVJTlZBTDsNCj4gPiArCQlnb3RvIG91dF9wdXRfaWRldjsNCj4g
PiArCX0NCj4gPiArDQo+ID4gKwlzd2l0Y2ggKHB0X29iai0+dHlwZSkgew0KPiA+ICsJY2FzZSBJ
T01NVUZEX09CSl9JT0FTOg0KPiA+ICsJCWlvYXMgPSBjb250YWluZXJfb2YocHRfb2JqLCBzdHJ1
Y3QgaW9tbXVmZF9pb2FzLCBvYmopOw0KPiA+ICsJCWJyZWFrOw0KPiA+ICsJY2FzZSBJT01NVUZE
X09CSl9IV19QQUdFVEFCTEU6DQo+ID4gKwkJLyogcHRfaWQgcG9pbnRzIEhXUFQgb25seSB3aGVu
IGRhdGFfdHlwZQ0KPiBpcyAhSU9NTVVfSFdQVF9UWVBFX0RFRkFVTFQgKi8NCj4gPiArCQlpZiAo
Y21kLT5kYXRhX3R5cGUgPT0gSU9NTVVfSFdQVF9UWVBFX0RFRkFVTFQpIHsNCj4gPiArCQkJcmMg
PSAtRUlOVkFMOw0KPiA+ICsJCQlnb3RvIG91dF9wdXRfcHQ7DQo+ID4gKwkJfQ0KPiA+ICsNCj4g
PiArCQlwYXJlbnQgPSBjb250YWluZXJfb2YocHRfb2JqLCBzdHJ1Y3QNCj4gaW9tbXVmZF9od19w
YWdldGFibGUsIG9iaik7DQo+ID4gKwkJLyoNCj4gPiArCQkgKiBDYW5ub3QgYWxsb2NhdGUgdXNl
ci1tYW5hZ2VkIGh3cHQgbGlua2luZyB0bw0KPiBhdXRvX2NyZWF0ZWQNCj4gPiArCQkgKiBod3B0
LiBJZiB0aGUgcGFyZW50IGh3cHQgaXMgYWxyZWFkeSBhIHVzZXItbWFuYWdlZCBod3B0LA0KPiA+
ICsJCSAqIGRvbid0IGFsbG9jYXRlIGFub3RoZXIgdXNlci1tYW5hZ2VkIGh3cHQgbGlua2luZyB0
byBpdC4NCj4gPiArCQkgKi8NCj4gPiArCQlpZiAocGFyZW50LT5hdXRvX2RvbWFpbiB8fCBwYXJl
bnQtPnBhcmVudCkgew0KPiA+ICsJCQlyYyA9IC1FSU5WQUw7DQo+ID4gKwkJCWdvdG8gb3V0X3B1
dF9wdDsNCj4gPiArCQl9DQo+ID4gKwkJaW9hcyA9IHBhcmVudC0+aW9hczsNCj4gPiArCQlicmVh
azsNCj4gPiArCWRlZmF1bHQ6DQo+ID4gKwkJcmMgPSAtRUlOVkFMOw0KPiA+ICsJCWdvdG8gb3V0
X3B1dF9wdDsNCj4gPiArCX0NCj4gPiArDQo+ID4gKwlrbGVuID0gaW9tbXVmZF9od3B0X2FsbG9j
X2RhdGFfc2l6ZVtjbWQtPmRhdGFfdHlwZV07DQo+ID4gKwlpZiAoa2xlbikgew0KPiA+ICsJCWlm
ICghY21kLT5kYXRhX2xlbikgew0KPiA+ICsJCQlyYyA9IC1FSU5WQUw7DQo+ID4gKwkJCWdvdG8g
b3V0X3B1dF9wdDsNCj4gPiArCQl9DQo+IA0KPiBJcyB0aGUgdXNlcl9kYXRhIHN0aWxsIHZhbGlk
IGlmIChjbWQtPmRhdGFfbGVuIDwga2xlbik/DQoNClllcywgb25lIGRheSBpZiBrZXJuZWwgaGFz
IG5ldyBmaWVsZHMgYWRkZWQgaW4gdGhlIGVuZCBvZiB0aGUgdWFwaQ0Kc3RydWN0dXJlIGJ1dCBx
ZW11IGlzIHVzaW5nIGFuIG9sZCB1YXBpIGhlYWRlci4gSW4gc3VjaCBjYXNlLCB0aGUNCmV4dHJh
IGJ5dGUgc2hvdWxkIGJlIHplcm9lZC4NCg0KPiANCj4gPiArDQo+ID4gKwkJZGF0YSA9IGt6YWxs
b2Moa2xlbiwgR0ZQX0tFUk5FTCk7DQo+ID4gKwkJaWYgKCFkYXRhKSB7DQo+ID4gKwkJCXJjID0g
LUVOT01FTTsNCj4gPiArCQkJZ290byBvdXRfcHV0X3B0Ow0KPiA+ICsJCX0NCj4gPiArDQo+ID4g
KwkJcmMgPSBjb3B5X3N0cnVjdF9mcm9tX3VzZXIoZGF0YSwga2xlbiwNCj4gPiArCQkJCQkgICB1
NjRfdG9fdXNlcl9wdHIoY21kLT5kYXRhX3VwdHIpLA0KPiA+ICsJCQkJCSAgIGNtZC0+ZGF0YV9s
ZW4pOw0KPiA+ICsJCWlmIChyYykNCj4gPiArCQkJZ290byBvdXRfZnJlZV9kYXRhOw0KPiA+ICsJ
fQ0KPiA+ICsNCj4gPiAgIAltdXRleF9sb2NrKCZpb2FzLT5tdXRleCk7DQo+ID4gICAJaHdwdCA9
IGlvbW11ZmRfaHdfcGFnZXRhYmxlX2FsbG9jKHVjbWQtPmljdHgsIGlvYXMsIGlkZXYsDQo+ID4g
LQkJCQkJICBOVUxMLCBOVUxMLCBmYWxzZSk7DQo+ID4gKwkJCQkJICBwYXJlbnQsIGRhdGEsIGZh
bHNlKTsNCj4gPiAgIAltdXRleF91bmxvY2soJmlvYXMtPm11dGV4KTsNCj4gPiAgIAlpZiAoSVNf
RVJSKGh3cHQpKSB7DQo+ID4gICAJCXJjID0gUFRSX0VSUihod3B0KTsNCj4gPiAtCQlnb3RvIG91
dF9wdXRfaW9hczsNCj4gPiArCQlnb3RvIG91dF9mcmVlX2RhdGE7DQo+ID4gICAJfQ0KPiA+DQo+
ID4gICAJY21kLT5vdXRfaHdwdF9pZCA9IGh3cHQtPm9iai5pZDsNCj4gPiBAQCAtMjAwLDEyICsy
NzIsMTQgQEAgaW50IGlvbW11ZmRfaHdwdF9hbGxvYyhzdHJ1Y3QgaW9tbXVmZF91Y21kDQo+ICp1
Y21kKQ0KPiA+ICAgCWlmIChyYykNCj4gPiAgIAkJZ290byBvdXRfaHdwdDsNCj4gPiAgIAlpb21t
dWZkX29iamVjdF9maW5hbGl6ZSh1Y21kLT5pY3R4LCAmaHdwdC0+b2JqKTsNCj4gPiAtCWdvdG8g
b3V0X3B1dF9pb2FzOw0KPiA+ICsJZ290byBvdXRfZnJlZV9kYXRhOw0KPiA+DQo+ID4gICBvdXRf
aHdwdDoNCj4gPiAgIAlpb21tdWZkX29iamVjdF9hYm9ydF9hbmRfZGVzdHJveSh1Y21kLT5pY3R4
LCAmaHdwdC0+b2JqKTsNCj4gPiAtb3V0X3B1dF9pb2FzOg0KPiA+IC0JaW9tbXVmZF9wdXRfb2Jq
ZWN0KCZpb2FzLT5vYmopOw0KPiA+ICtvdXRfZnJlZV9kYXRhOg0KPiA+ICsJa2ZyZWUoZGF0YSk7
DQo+ID4gK291dF9wdXRfcHQ6DQo+ID4gKwlpb21tdWZkX3B1dF9vYmplY3QocHRfb2JqKTsNCj4g
PiAgIG91dF9wdXRfaWRldjoNCj4gPiAgIAlpb21tdWZkX3B1dF9vYmplY3QoJmlkZXYtPm9iaik7
DQo+ID4gICAJcmV0dXJuIHJjOw0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lvbW11L2lvbW11
ZmQvbWFpbi5jDQo+IGIvZHJpdmVycy9pb21tdS9pb21tdWZkL21haW4uYw0KPiA+IGluZGV4IGYw
NzljMGJkYTQ2Yi4uN2FiMWUyYzYzOGExIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvaW9tbXUv
aW9tbXVmZC9tYWluLmMNCj4gPiArKysgYi9kcml2ZXJzL2lvbW11L2lvbW11ZmQvbWFpbi5jDQo+
ID4gQEAgLTI5NSw3ICsyOTUsNyBAQCBzdHJ1Y3QgaW9tbXVmZF9pb2N0bF9vcCB7DQo+ID4gICBz
dGF0aWMgY29uc3Qgc3RydWN0IGlvbW11ZmRfaW9jdGxfb3AgaW9tbXVmZF9pb2N0bF9vcHNbXSA9
IHsNCj4gPiAgIAlJT0NUTF9PUChJT01NVV9ERVNUUk9ZLCBpb21tdWZkX2Rlc3Ryb3ksIHN0cnVj
dA0KPiBpb21tdV9kZXN0cm95LCBpZCksDQo+ID4gICAJSU9DVExfT1AoSU9NTVVfSFdQVF9BTExP
QywgaW9tbXVmZF9od3B0X2FsbG9jLCBzdHJ1Y3QNCj4gaW9tbXVfaHdwdF9hbGxvYywNCj4gPiAt
CQkgX19yZXNlcnZlZCksDQo+ID4gKwkJIGRhdGFfdXB0ciksDQo+ID4gICAJSU9DVExfT1AoSU9N
TVVfREVWSUNFX0dFVF9IV19JTkZPLA0KPiBpb21tdWZkX2RldmljZV9nZXRfaHdfaW5mbywNCj4g
PiAgIAkJIHN0cnVjdCBpb21tdV9od19pbmZvLCBfX3Jlc2VydmVkKSwNCj4gPiAgIAlJT0NUTF9P
UChJT01NVV9JT0FTX0FMTE9DLCBpb21tdWZkX2lvYXNfYWxsb2NfaW9jdGwsDQo+ID4gZGlmZiAt
LWdpdCBhL2luY2x1ZGUvdWFwaS9saW51eC9pb21tdWZkLmggYi9pbmNsdWRlL3VhcGkvbGludXgv
aW9tbXVmZC5oDQo+ID4gaW5kZXggNGFjNTI1ODk3YjgyLi40ODc4MWZmNDBhMzcgMTAwNjQ0DQo+
ID4gLS0tIGEvaW5jbHVkZS91YXBpL2xpbnV4L2lvbW11ZmQuaA0KPiA+ICsrKyBiL2luY2x1ZGUv
dWFwaS9saW51eC9pb21tdWZkLmgNCj4gPiBAQCAtMzQ3LDYgKzM0NywxNCBAQCBzdHJ1Y3QgaW9t
bXVfdmZpb19pb2FzIHsNCj4gPiAgIH07DQo+ID4gICAjZGVmaW5lIElPTU1VX1ZGSU9fSU9BUyBf
SU8oSU9NTVVGRF9UWVBFLA0KPiBJT01NVUZEX0NNRF9WRklPX0lPQVMpDQo+ID4NCj4gPiArLyoq
DQo+ID4gKyAqIGVudW0gaW9tbXVfaHdwdF90eXBlIC0gSU9NTVUgSFdQVCBUeXBlDQo+ID4gKyAq
IEBJT01NVV9IV1BUX1RZUEVfREVGQVVMVDogZGVmYXVsdA0KPiA+ICsgKi8NCj4gPiArZW51bSBp
b21tdV9od3B0X3R5cGUgew0KPiA+ICsJSU9NTVVfSFdQVF9UWVBFX0RFRkFVTFQsDQo+ID4gK307
DQo+ID4gKw0KPiA+ICAgLyoqDQo+ID4gICAgKiBzdHJ1Y3QgaW9tbXVfaHdwdF9hbGxvYyAtIGlv
Y3RsKElPTU1VX0hXUFRfQUxMT0MpDQo+ID4gICAgKiBAc2l6ZTogc2l6ZW9mKHN0cnVjdCBpb21t
dV9od3B0X2FsbG9jKQ0KPiA+IEBAIC0zNTUsMTIgKzM2MywzMSBAQCBzdHJ1Y3QgaW9tbXVfdmZp
b19pb2FzIHsNCj4gPiAgICAqIEBwdF9pZDogVGhlIElPQVMgdG8gY29ubmVjdCB0aGlzIEhXUFQg
dG8NCj4gPiAgICAqIEBvdXRfaHdwdF9pZDogVGhlIElEIG9mIHRoZSBuZXcgSFdQVA0KPiA+ICAg
ICogQF9fcmVzZXJ2ZWQ6IE11c3QgYmUgMA0KPiA+ICsgKiBAZGF0YV90eXBlOiBPbmUgb2YgZW51
bSBpb21tdV9od3B0X3R5cGUNCj4gPiArICogQGRhdGFfbGVuOiBMZW5ndGggb2YgdGhlIHR5cGUg
c3BlY2lmaWMgZGF0YQ0KPiA+ICsgKiBAZGF0YV91cHRyOiBVc2VyIHBvaW50ZXIgdG8gdGhlIHR5
cGUgc3BlY2lmaWMgZGF0YQ0KPiA+ICAgICoNCj4gPiAgICAqIEV4cGxpY2l0bHkgYWxsb2NhdGUg
YSBoYXJkd2FyZSBwYWdlIHRhYmxlIG9iamVjdC4gVGhpcyBpcyB0aGUgc2FtZQ0KPiBvYmplY3QN
Cj4gPiAgICAqIHR5cGUgdGhhdCBpcyByZXR1cm5lZCBieSBpb21tdWZkX2RldmljZV9hdHRhY2go
KSBhbmQgcmVwcmVzZW50cyB0aGUNCj4gPiAgICAqIHVuZGVybHlpbmcgaW9tbXUgZHJpdmVyJ3Mg
aW9tbXVfZG9tYWluIGtlcm5lbCBvYmplY3QuDQo+ID4gICAgKg0KPiA+ICAgICogQSBub3JtYWwg
SFdQVCB3aWxsIGJlIGNyZWF0ZWQgd2l0aCB0aGUgbWFwcGluZ3MgZnJvbSB0aGUgZ2l2ZW4gSU9B
Uy4NCj4gPiArICogVGhlIEBkYXRhX3R5cGUgZm9yIGl0cyBhbGxvY2F0aW9uIGNhbiBiZSBzZXQg
dG8NCj4gSU9NTVVfSFdQVF9UWVBFX0RFRkFVTFQsIG9yDQo+ID4gKyAqIGFub3RoZXIgdHlwZSAo
YmVpbmcgbGlzdGVkIGJlbG93KSB0byBzcGVjaWFsaXplIGEga2VybmVsLW1hbmFnZWQNCj4gSFdQ
VC4NCj4gPiArICoNCj4gPiArICogQSB1c2VyLW1hbmFnZWQgSFdQVCB3aWxsIGJlIGNyZWF0ZWQg
ZnJvbSBhIGdpdmVuIHBhcmVudCBIV1BUIHZpYQ0KPiBAcHRfaWQsIGluDQo+ID4gKyAqIHdoaWNo
IHRoZSBwYXJlbnQgSFdQVCBtdXN0IGJlIGFsbG9jYXRlZCBwcmV2aW91c2x5IHZpYSB0aGUgc2Ft
ZSBpb2N0bA0KPiBmcm9tIGENCj4gPiArICogZ2l2ZW4gSU9BUy4gVGhlIEBkYXRhX3R5cGUgbXVz
dCBub3QgYmUgc2V0IHRvDQo+IElPTU1VX0hXUFRfVFlQRV9ERUZBVUxUIGJ1dCBhDQo+ID4gKyAq
IHByZS1kZWZpbmVkIHR5cGUgY29ycmVzcG9uZGluZyB0byB0aGUgdW5kZXJseWluZyBJT01NVSBo
YXJkd2FyZS4NCj4gPiArICoNCj4gPiArICogSWYgdGhlIEBkYXRhX3R5cGUgaXMgc2V0IHRvIElP
TU1VX0hXUFRfVFlQRV9ERUZBVUxULCBib3RoIHRoZQ0KPiBAZGF0YV9sZW4gYW5kDQo+ID4gKyAq
IHRoZSBAZGF0YV91cHRyIHdpbGwgYmUgaWdub3JlZC4gT3RoZXJ3aXNlLCBib3RoIG9mIHRoZW0g
bXVzdCBiZQ0KPiBnaXZlbi4NCj4gPiArICoNCj4gPiArICoNCj4gKz09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PSs9PT09PT09PT09PT09PT09PT09PT09PT09PT09PQ0KPiA9PT09PT09PSs9
PT09PT09PT09PSsNCj4gPiArICogfCBAZGF0YV90eXBlICAgICAgICAgICAgICAgICAgIHwgICAg
RGF0YSBzdHJ1Y3R1cmUgaW4gQGRhdGFfdXB0ciAgICAgfCAgIEBwdF9pZA0KPiB8DQo+ID4gKyAq
ICstLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0rLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLSstLS0tLS0tLS0tLSsNCj4gPiArICogfCBJT01NVV9IV1BUX1RZUEVfREVG
QVVMVCAgICAgIHwgICAgICAgICAgICAgICBOL0EgICAgICAgICAgICAgICAgICAgfCAgICBJT0FT
DQo+IHwNCj4gPiArICogKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLSstLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tKy0tLS0tLS0tLS0tKw0KPiA+ICAgICovDQo+ID4g
ICBzdHJ1Y3QgaW9tbXVfaHdwdF9hbGxvYyB7DQo+ID4gICAJX191MzIgc2l6ZTsNCj4gPiBAQCAt
MzY5LDYgKzM5Niw5IEBAIHN0cnVjdCBpb21tdV9od3B0X2FsbG9jIHsNCj4gPiAgIAlfX3UzMiBw
dF9pZDsNCj4gPiAgIAlfX3UzMiBvdXRfaHdwdF9pZDsNCj4gPiAgIAlfX3UzMiBfX3Jlc2VydmVk
Ow0KPiA+ICsJX191MzIgZGF0YV90eXBlOw0KPiA+ICsJX191MzIgZGF0YV9sZW47DQo+ID4gKwlf
X2FsaWduZWRfdTY0IGRhdGFfdXB0cjsNCj4gPiAgIH07DQo+ID4gICAjZGVmaW5lIElPTU1VX0hX
UFRfQUxMT0MgX0lPKElPTU1VRkRfVFlQRSwNCj4gSU9NTVVGRF9DTURfSFdQVF9BTExPQykNCj4g
DQo+IEJlc3QgcmVnYXJkcywNCj4gYmFvbHUNCg==
