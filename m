Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62487776E83
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Aug 2023 05:28:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230114AbjHJD2R (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 9 Aug 2023 23:28:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbjHJD2Q (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 9 Aug 2023 23:28:16 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91D9E1B6;
        Wed,  9 Aug 2023 20:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691638095; x=1723174095;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=xCNzXjdxdpUxDbKZ+ih+p079Q+yFggihVgiBCiB0d+o=;
  b=fdxMjjVCLvyH2rSpPLwdJBO9obWiTNG2tIaoYneTXYiiYQ9PFml3aK2B
   vllO9ZnHsIancDNrylK9PFR0fJGXFuAtNRqR9dPsY1DRpC0+1Bm/9rL2I
   dKfPfWfjMDwOZVUDUoQuX7F39BqWYlHMSldyI4h4LRFQwCWI6IOUCasdU
   4w8Qmnc54Ev38WFphbjrgnllCSeVaR6Y2C8vuZBO59A3LA+nUjGEZj1dd
   FNh1kC7eaLwYCUWYPh5SzTthkHZFhCJHh5lyAu3m/xikKVdYL3W8xVhVU
   G73Vd6DypPxFS/SpatFaGsICqAIosD1lunEWuOF+xoQcHOo4j/zFM8AE0
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10797"; a="435182193"
X-IronPort-AV: E=Sophos;i="6.01,161,1684825200"; 
   d="scan'208";a="435182193"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2023 20:28:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10797"; a="802006861"
X-IronPort-AV: E=Sophos;i="6.01,161,1684825200"; 
   d="scan'208";a="802006861"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga004.fm.intel.com with ESMTP; 09 Aug 2023 20:28:14 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 9 Aug 2023 20:28:13 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 9 Aug 2023 20:28:13 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.173)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 9 Aug 2023 20:28:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oW+YI0u9WFJuo+rNN3dUXDYYU90z+P7EhfcMD8iHPkx4a86SrW8sCupaFZtNKnRPPzdvCZDnnrjvJ0zkHQCONXmn5giwn12WTogXdPMFQAP4teKn6ri5qazq1iu1bu4yYhGFQIipN/XQFAWmu7mfHEleXFmCOScfioQvFTCs20PVuEE+ZED9xF8LCHAlgwn51biz/JfpPgQvIqQ0UKdqxKaZ7wy9DU0IXLsMC7D25a/QNLqrkWNHp1hOKChge1HPDqlcmKbPX82FMfFZHEkVWxYUo1P8D/RN1B82s/r1vedF5E/ZvghqWrEQ5ci5M1Rf2M+iSRDEa9dnlmg8OZ0uEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xCNzXjdxdpUxDbKZ+ih+p079Q+yFggihVgiBCiB0d+o=;
 b=IeOld9e3DH5fFAdpAOWqo37MnO785CYjh/dtp3Idn40QSFGAfGLxdqW2ymZ6veP6RSIJTaoErzqhdb69PrI8tt5MZTOnOMW9QeW4esvWBlNXMHSlxtiW4WKHfM7YI4pHM6PFPruXkDS940Y7hZ2N/R3BHINllJmtZeVYEqigp2v/kDPUHz+/06NOXFpGQOK0a+t2NdWVZBsUZLST+JECmSNLJhYk76eoAOGz35VnFbUj4HlXNqQuTMLCKQA19/oxlChW4EBJKhTNOa87pYVydsRi856kPS2FwRyLbpBqlA+KbjKWeyTEMQaz7+bg+Rz9K9Kpm+09F5dQMJSMZsDEiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by BL3PR11MB6338.namprd11.prod.outlook.com (2603:10b6:208:3b2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Thu, 10 Aug
 2023 03:28:11 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::b556:42c4:772f:d47e]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::b556:42c4:772f:d47e%7]) with mapi id 15.20.6652.026; Thu, 10 Aug 2023
 03:28:10 +0000
From:   "Liu, Yi L" <yi.l.liu@intel.com>
To:     Nicolin Chen <nicolinc@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>
CC:     "Tian, Kevin" <kevin.tian@intel.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
        "cohuck@redhat.com" <cohuck@redhat.com>,
        "eric.auger@redhat.com" <eric.auger@redhat.com>,
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
        "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
Subject: RE: [PATCH v4 09/12] iommu/vt-d: Add iotlb flush for nested domain
Thread-Topic: [PATCH v4 09/12] iommu/vt-d: Add iotlb flush for nested domain
Thread-Index: AQHZvh/uqwr3PK6FO0KhG3jtetteiK/WrrGAgAhNwpCAANOqgIAAnN2AgABV8ACAAPYtAIAABp4QgAADR4CAAAcG8IAAdc8AgAAuy4CAAAHYgIAAEEsAgAB3RPA=
Date:   Thu, 10 Aug 2023 03:28:10 +0000
Message-ID: <DS0PR11MB7529819E78B7F04D99069701C313A@DS0PR11MB7529.namprd11.prod.outlook.com>
References: <ZNGypUee/U9d68TZ@Asurada-Nvidia> <ZNI2O4Upyna5AWDA@nvidia.com>
 <ZNJ+Uv/WJwngosjJ@Asurada-Nvidia>
 <BN9PR11MB5276BFFEC7E12EEBD4503BF08C12A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <DS0PR11MB7529C3646E38542457D7B75DC312A@DS0PR11MB7529.namprd11.prod.outlook.com>
 <BN9PR11MB5276912120F662498910A1D48C12A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <DS0PR11MB7529C310FAEA61B6E7988629C312A@DS0PR11MB7529.namprd11.prod.outlook.com>
 <ZNO92PIx2IQ70+DY@nvidia.com> <ZNPlGd4/72dahSs4@Asurada-Nvidia>
 <ZNPmpW3/zDnjqxyU@nvidia.com> <ZNP0UKGU6id5wfc6@Asurada-Nvidia>
In-Reply-To: <ZNP0UKGU6id5wfc6@Asurada-Nvidia>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB7529:EE_|BL3PR11MB6338:EE_
x-ms-office365-filtering-correlation-id: 4fc45492-4735-4cf8-0085-08db9951d2a1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MG5EW6c1OVbm7+A1O8o99sdZcJNZmdxBdFGTyICv86hYkgEFB41Bp29ZavShlkns2DiBhfmi4I3h+Yw7iuKn5QX/YQUmBQQLrRNN28513mpLN2/c8qlPaVmUIoGsqRtovWeHSQdpa+BcSsWmr8TG1eUwYd8hHbIa4jfQb0225c8gLTyOiNUNF1HknzzVDwY0Jo0+XTzWsiciJ2GpEnd1adMQd//2lUSoxfFSkIID457XdWXlapAWb12w7xuCJxHydmNyh/ZhKatNlVqPBySSmQo0bQ6l8fJi2s+8pjNg2uEGjSNEieFAo1PLhWfRTjsUEYweptzYlwMDnyaAPrgWnqYIOI0zxr8aBJaWDdCKOIz2HPSM2GGLhF/BrbQSsbIlvLK018vPL1qBkiM7SO+Q2SjVAPvZJb+9viDimGDjG4rpJGMydbbsM2lLO0c28h5PyZn0oYBXk5JrvMM0XrXhieG5yO6HIfG2MlbcSC11oBypRxuvNvTsWEZL9dGucJOqcPNWFe1D/GhU50w0XMIKdCB9ZGkC9Pw57X36Ze/c70Qx71xSu2HrsQdNX1pKQV6bBSoJ1b0M4e5KCGoWLKSqxsOY22CrTDQiLHGksKacSFo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(346002)(366004)(136003)(39860400002)(186006)(1800799006)(451199021)(64756008)(76116006)(66946007)(66556008)(66476007)(66446008)(4326008)(33656002)(966005)(478600001)(9686003)(41300700001)(316002)(6506007)(7416002)(7696005)(54906003)(52536014)(8936002)(8676002)(5660300002)(86362001)(38070700005)(38100700002)(110136005)(71200400001)(83380400001)(2906002)(122000001)(82960400001)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eHRiakRMbHM0ZS9XWEthOU0wVlBCSWNPZkpqTUpJZG04VG5wK0hxTkV4eHpZ?=
 =?utf-8?B?OG1nNWFwQ2ZTVXZOOEJyQUlGQ09ONmxlUGRlcHdzUTJOQ0NNSUEzOXBiSFNr?=
 =?utf-8?B?ejJWUStGcjRRMVZ5NFB2OXU1bzZmblNPcmZpYnVqalNnZExKQlRsN1dOT0F3?=
 =?utf-8?B?VXBHbHVRQkVuTXZpNTdhZGw1S2drRXl4WHU1cmdSZ0hyUWc2bUEyNElabC9n?=
 =?utf-8?B?RklCY3RtNGRLYVN4emxBK1hIU0toRkhCTlZYUTZZMnh4VlhUMWx2ZjJqZ2pT?=
 =?utf-8?B?STJISEhUSE83U0hZSXM0WjdraWZuOHJMemJZc1B1bmhkUWkxQWkxWGVYRFE3?=
 =?utf-8?B?Qnc2WlI2dXlCUklvbFJ4aU5mYWRuZlJRME9vRjBXendRMWVWazg3ZmVRNG5P?=
 =?utf-8?B?MHBUQVM5dmpmT2xnS01Hbi9FZ0p0ZDJGRlAzRWpvc0hndmRBSy93ejVvSzBG?=
 =?utf-8?B?QVZyOUFRNnd1dEZaM2F3NUVldWlIN01XaHB5Wm9URVE4UysraWd0Nk9hank5?=
 =?utf-8?B?bmwrMHJUcFp3L3NrZUwzRkdsWFJUN3lrVjdxbC83YVJOdHJqUmp5OC9aOWg2?=
 =?utf-8?B?dVNrWFVlVE8wNXNDanBuMm5RVDNCVW1zblB2K2lzUitaOERSK3l1OHoxNjRq?=
 =?utf-8?B?ckIzZHZodzR4MlJrb1N5YTNMK3kxWXRET0FQVnQydDk1aWVwY0puTjNJVkJP?=
 =?utf-8?B?Qk9wSld5SzJHdHVaQ3BmK3F0M2x0dXFxTFJ1VHVuS3JxSFF1R2d4cVZIMDFX?=
 =?utf-8?B?ZFlIZUxuSnAyK1R2Yk5EbmtHUGpCNXE1T2NCaHVBSlZWTzRMaThhSEZlY0xR?=
 =?utf-8?B?emttNjNmNEVyZzlQcDNJMWd4R29wOU5yQzBqN281SEt0ZWtnOTA1bXNUZmtk?=
 =?utf-8?B?cnZQRHRvNWdhc01qODlGNXM0RHczV3dMUTRsNndxVXNWNURlcGt5TTJGWDBK?=
 =?utf-8?B?N3FzVkN1cnh3MWYzREpsMnFtYnRCTGl3YlJpYXZ6cnd6eVg4c3BKdUdyYlhW?=
 =?utf-8?B?YmRBd1lBemxqaGFVMWloSzI0dHc1WFRoOVF4OW9yRkhCb0Q0bHJZbFhZTFha?=
 =?utf-8?B?cDNXQ0NYRTlOZzNrRjd0WjN3Z3pKVjdPM1BZWGdYM3p4Z280Y09aR2JEc2ZW?=
 =?utf-8?B?T09IK0ZGUFo0dGF6aXk4bGdROThVdGZzaTc3ZWZkZUxZTjBpZ2lIbXJZT3Mw?=
 =?utf-8?B?OVdtYzVRNlFJZmNEcjhZYUorYlhYM0ZScloxT0VEYWtVQnN2MmJScm5UL1Fn?=
 =?utf-8?B?S3RXVThrTG0wa3BzVkhPZitvNGRyUVhxT1VqQUdBOUt4T1BHcmlzUXkrVnJQ?=
 =?utf-8?B?R0V2bGh2RGhVRWZjaU0wT0pCZStmVTQwV2NqSXVRdjYybjYrVlFDU1RZQ0RH?=
 =?utf-8?B?NU9lZVhqb3JVWjZaL3VnU1Rpa2NlLzAvKzJBZ3FaemNGQVZZeE9vU3I2OUpF?=
 =?utf-8?B?SVI4Z3Fzd3dDaG9VbDd6Q052R0NRcldicnM3Z2prYTFxZExwWnVMV1NMQ1pS?=
 =?utf-8?B?SGY3YjUyeFBVcUJsTERSSUJHcGFadGxuOFBhOVd1QnplRFloRnFzTEJpUzlm?=
 =?utf-8?B?c3pFejE1REZJb1V5bVp4ek1MUGNWdldkRTVDTHdsREZxMlBpeHg4R2JsRTla?=
 =?utf-8?B?czVVaEFBZFI4akJkUERaWndOUFp0WHhDdkk2a0o5eUlCdloyQUV1TlJZQXpt?=
 =?utf-8?B?Z2FwMFpZK3VKK29PbmhyTHJ0Ynl3My9qTXgwSEc4cWJjcXdubUhNU1R6S1Zw?=
 =?utf-8?B?Y0dhVVRQQ1l5cVA5T0JsQVpFcW0zd3ZpRHp3M2RXMUVJb09ieEg3K1lqaFdt?=
 =?utf-8?B?YXFDOGtlaFBuM0lUemtEYTVNa2pIY04xV1NjUzBFMnlzYVNnRjhEVjRsOVdQ?=
 =?utf-8?B?VktBUWhIN0dWR1lWWC8xdlFzaEc5ZHVYS1BaWFMxZ0pCQmR6TWE1MkVCS1Vt?=
 =?utf-8?B?MUNLV29Eais0OHR4VDVYZ0JaQ2xmK2NpOTZXODB2ZUZuQW44NTFZYytWSDBB?=
 =?utf-8?B?T0Fkanl4MkV0YVZCeG42aklKZHF6dlF4d05Wc05XRldWM0VlQmVhbFlvOG5y?=
 =?utf-8?B?b1A3UFF5UkNrc0R1akkxMWdydEsyRHM4dlJCQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fc45492-4735-4cf8-0085-08db9951d2a1
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Aug 2023 03:28:10.7803
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V0t3JHCScBcQKDpbqq6jEHraJOecY6aQI1vW5dybQS72U9PpNdCoKXmqxElq8AKPtg7LiLArUiz+AdClvYqKGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6338
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

PiBGcm9tOiBOaWNvbGluIENoZW4gPG5pY29saW5jQG52aWRpYS5jb20+DQo+IFNlbnQ6IFRodXJz
ZGF5LCBBdWd1c3QgMTAsIDIwMjMgNDoxNyBBTQ0KPiANCj4gT24gV2VkLCBBdWcgMDksIDIwMjMg
YXQgMDQ6MTk6MDFQTSAtMDMwMCwgSmFzb24gR3VudGhvcnBlIHdyb3RlOg0KPiA+IE9uIFdlZCwg
QXVnIDA5LCAyMDIzIGF0IDEyOjEyOjI1UE0gLTA3MDAsIE5pY29saW4gQ2hlbiB3cm90ZToNCj4g
PiA+IE9uIFdlZCwgQXVnIDA5LCAyMDIzIGF0IDAxOjI0OjU2UE0gLTAzMDAsIEphc29uIEd1bnRo
b3JwZSB3cm90ZToNCj4gPiA+ID4gT24gV2VkLCBBdWcgMDksIDIwMjMgYXQgMDk6MzA6MTJBTSAr
MDAwMCwgTGl1LCBZaSBMIHdyb3RlOg0KPiA+ID4gPg0KPiA+ID4gPiA+IFllYWgsIGFkZGluZyBu
ZXcgc3RydWN0dXJlcyB0byB1Y21kX2J1ZmZlciBtYXkgaW5jcmVhc2UgdGhlIHNpemUgYXMNCj4g
PiA+ID4gPiB3ZWxsIGlmIHRoZSBuZXcgb25lIGlzIGxhcmdlci4gV2hpbGUgZm9yIGFuIGFycmF5
LCBpZiB0aGVyZSBpcyBuZXcgZW50cnksDQo+ID4gPiA+ID4gaXQgaXMgZm9yIHN1cmUgdG8gaW5j
cmVhc2UgdGhlIHNpemUuIEkgcmVtZW1iZXIgdGhlcmUgaXMgb25lIHRyaWNreSB0aGluZw0KPiA+
ID4gPiA+IHdoZW4gaGFuZGxpbmcgdGhlIHNlbGZ0ZXN0IHR5cGUuIEUuZy4gaXQgaXMgZGVmaW5l
ZCBhcyAweGJhZGJlZWYsIGlmIHVzaW5nDQo+ID4gPiA+ID4gaXQgdG8gaW5kZXggYXJyYXksIGl0
IHdvdWxkIGV4cGlyZS4gU28gd2UgaGF2ZSBzb21lIHNwZWNpYWwgaGFuZGxpbmcgb24NCj4gPiA+
ID4gPiBpdC4gSWYgZGVmaW5pbmcgdGhlIHRoaW5ncyBpbiBpb21tdV9vcHMsIGl0IGlzIHNpbXBs
ZXIuIFNlbGZ0ZXN0IG1heSBiZQ0KPiA+ID4gPiA+IG5vdCBzbyBjcml0aWNhbCB0byBkZXRlcm1p
bmluZyB0aGUgZGlyZWN0aW9uIHRob3VnaC4NCj4gPiA+ID4NCj4gPiA+ID4gTWF5YmUgd2UgYXJl
IHRyeWluZyB0b28gaGFyZCB0byBtYWtlIGl0ICJlYXN5IiBvbiB0aGUgZHJpdmVyLg0KPiA+ID4g
Pg0KPiA+ID4gPiBDYW4ndCB3ZSBqdXN0IGhhdmUgdGhlIGRyaXZlciBpbnZva2Ugc29tZToNCj4g
PiA+ID4NCj4gPiA+ID4gZHJpdmVyX2lvbW11ZmRfaW52YWxpZGF0ZV9vcCg/Pz8gKm9wYXF1ZSkN
Cj4gPiA+ID4gew0KPiA+ID4gPiAJc3RydWN0IGRyaXZlcl9iYXNlX3N0cnVjdCBhcmdzOw0KPiA+
ID4gPg0KPiA+ID4gPiAgICAgICAgIHJjID0gaW9tbXVmZF9nZXRfYXJncyhvcGFxdWUsICZhcmdz
LCBzaXplb2YoYXJncyksDQo+ID4gPiA+IAkgICAgIG9mZnNldG9mKGFyZ3MsIGxhc3QpKTsNCj4g
PiA+DQo+ID4gPiBPSy4gU28sIElJVUlDLCB0aGUgb3BhcXVlIHNob3VsZCBiZToNCj4gPiA+DQo+
ID4gPiBzdHJ1Y3QgaW9tbXVfdXNlcl9kYXRhIHsNCj4gPiA+IAl2b2lkIF9fdXNlciAqZGF0YV91
cHRyOw0KPiA+ID4gCXNpemVfdCBkYXRhX2xlbjsNCj4gPiA+IH11c2VyX2RhdGE7DQo+ID4gPg0K
PiA+ID4gQW5kIGNvcmUgZG9lcyBiYXNpYyBzYW5pdHkgb2YgZGF0YV91cHRyICE9IE5VTEwgYW5k
IGRhdGFfbGVuICE9MA0KPiA+ID4gYmVmb3JlIHBhc3NpbmcgdGhpcyB0byBkcml2ZXIsIGFuZCB0
aGVuIGRvIGEgZnVsbCBzYW5pdHkgZHVyaW5nDQo+ID4gPiB0aGUgaW9tbXVmZF9nZXRfYXJncyAo
b3IgaW9tbXVmZF9nZXRfdXNlcl9kYXRhPykgY2FsbC4NCj4gPg0KPiA+IERvbid0IGV2ZW4gbmVl
ZCB0byBjaGVjayBkYXRBX3VwdHIgYW5kIGRhdGFfbGVuLCB0aGUgaGVscGVyIHNob3VsZA0KPiA+
IGNoZWNrIHRoZSBzaXplIGFuZCBudWxsIGlzIGNhdWdodCBieSBjb3B5IGZyb20gdXNlcg0KPiAN
Cj4gSSBzZWUuIEkgd2FzIHdvcnJpZWQgYWJvdXQgdGhlIGFsbG9jIHBhdGggc2luY2UgaXRzIGRh
dGEgaW5wdXQgaXMNCj4gb3B0aW9uYWwgdXBvbiBJT01NVV9ET01BSU5fVU5NQU5BR0VELiBCdXQg
dGhpcyBoZWxwZXIgc2hvdWxkIHdvcmsNCj4gZm9yIHRoYXQgYWxzby4NCj4gDQo+IEluIHRoYXQg
Y2FzZSwgd2UgbWlnaHQgbm90IGV2ZW4gbmVlZCB0byBkZWZpbmUgdGhlIHVuaW9uIHdpdGggYWxs
DQo+IHN0cnVjdHVyZXMsIGluIGlvbW11LmguDQo+IA0KPiA+ID4gPiBTaW1pbGFybHkgZm9yIG1h
bmFnaW5nIHRoZSBhcnJheSBvZiBpbnZhbGlkYXRpb24gY29tbWFuZHMuDQo+ID4gPg0KPiA+ID4g
WW91IG1lYW4gYW4gZW1iZWRkZWQgdXB0ciBpbnNpZGUgYSBkcml2ZXIgdXNlciBkYXRhIHN0cnVj
dCByaWdodD8NCj4gPiA+IFN1cmUsIHRoYXQgc2hvdWxkIGdvIHRocm91Z2ggdGhlIG5ldyBoZWxw
ZXIgdG9vLg0KPiA+DQo+ID4gSWYgd2UgYXJlIGNvbW1pdHRlZCB0aGF0IGFsbCBkcml2ZXJzIGhh
dmUgdG8gcHJvY2VzcyBhbiBhcnJheSB0aGVuIHB1dA0KPiA+IHRoZSBhcnJheSBpbiB0aGUgdG9w
IGxldmVsIHN0cnVjdCBhbmQgcGFzcyBpdCBpbiB0aGUgc2FtZSB1c2VyX2RhdGENCj4gPiBzdHJ1
Y3QgYW5kIHVzZSBhbm90aGVyIGhlbHBlciB0byBhbGxvdyB0aGUgZHJpdmVyIHRvIGl0ZXJhdGUg
dGhyb3VnaA0KPiA+IGl0Lg0KPiANCj4gSSBzZWUuIEJvdGggVlREIGFuZCBTTU1VIHBhc3MgdXB0
ciB0byB0aGUgYXJyYXlzIG9mIGludmFsaWRhdGlvbg0KPiBjb21tYW5kcy9yZXF1ZXN0cy4gVGhl
IG9ubHkgZGlmZmVyZW5jZSBpcyB0aGF0IFNNTVUncyBhcnJheSBpcyBhDQo+IHJpbmcgYnVmZmVy
IG90aGVyIHRoYW4gYSBwbGFpbiBvbmUgaW5kZXhpbmcgZnJvbSB0aGUgYmVnaW5uaW5nLg0KPiBC
dXQgdGhlIGhlbHBlciBjb3VsZCB0YWtlIHR3byBpbmRleCBpbnB1dHMsIHdoaWNoIHNob3VsZCB3
b3JrIGZvcg0KPiBWVEQgY2FzZSB0b28uIElmIGFub3RoZXIgSU9NTVUgZHJpdmVyIG9ubHkgc3Vw
cG9ydHMgb25lIHJlcXVlc3QsDQo+IHJhdGhlciB0aGFuIGEgYXJyYXkgb2YgcmVxdWVzdHMsIHdl
IGNhbiB0cmVhdCB0aGF0IGFzIGEgc2luZ2xlLQ0KPiBlbnRyeSBhcnJheS4NCj4gDQo+IFRoZW4s
IHRoZSBkcml2ZXItc3BlY2lmaWMgZGF0YSBzdHJ1Y3R1cmUgd2lsbCBiZSB0aGUgYXJyYXkgZW50
cnkNCj4gbGV2ZWwgb25seS4NCj4gDQo+IEBZaSwNCj4gVGhpcyBzZWVtcyB0byBiZSBhIGJpZ2dl
ciByZXdvcmsgdGhhbiB0aGUgdG9wIGxldmVsIHN0cnVjdC4gQWxvbmcNCj4gd2l0aCBKYXNvbidz
IHJlcXVlc3QgZm9yIGZhaWxfbnRoIGJlbG93LCB3ZSdkIG5lZWQgdG8gYmlzZWN0IHRoZQ0KPiB3
b3JrbG9hZCBiZXR3ZWVuIHVzLCBvciBjYW4ganVzdCBjb250aW51ZSBlYWNoIG90aGVyJ3MgZGFp
bHkgd29yay4NCj4gTGV0IG1lIGtub3cgd2hpY2ggb25lIHlvdSBwcmVmZXIuDQo+IGh0dHBzOi8v
bG9yZS5rZXJuZWwub3JnL2xpbnV4LWlvbW11L1pOUEN0UFRjSHZJVHQ2ZmtAbnZpZGlhLmNvbS8N
Cg0KTGV0IG1lIGFkZHJlc3MgdGhlIGZhaWxfbnRoIHJlcXVlc3QgZmlyc3QuIFlvdSBtYXkgcmV3
b3JrIHRoZQ0KaW9tbXVmZF9nZXRfdXNlcl9kYXRhKCkuIElmIEkgY2FuIGZpbmlzaCB0aGUgZmFp
bF9udGggc29vbiwNCnRoZW4gbWF5IGhlbHAgdG8gbGlmdCB0aGUgYXJyYXkgdG8gdGhlIHRvcCBs
ZXZlbC4gSWYgbm90LCB5b3UNCm1heSBtYWtlIGl0IGFzIHdlbGwuIPCfmIogSSBndWVzcyBJIG5l
ZWQgc29tZSBzdHVkeSBvbiBudGgNCmFzIHdlbGwuDQoNClJlZ2FyZHMsDQpZaSBMaXUNCg==
