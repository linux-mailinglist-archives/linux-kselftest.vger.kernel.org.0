Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D68D7726EB
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Aug 2023 16:04:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232147AbjHGOEP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 7 Aug 2023 10:04:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235169AbjHGODt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 7 Aug 2023 10:03:49 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7AE81FE4;
        Mon,  7 Aug 2023 07:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691416973; x=1722952973;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=CvYMilWXhftGiNbs0zmYaPfZE4y554HvHzlmByODIvc=;
  b=iX45k3uywezKf7Buszj9UUs416QVF61nLBwC/kojszFGJgu9UHQK7CJd
   g6jZCBi29/moRkVu5sEddw65XxXnAEVk+2EMCh8r07z7kPGkPVenFNpUx
   CHsc4w2MtBIHxmmZeoownMgGZKcV/+z+ZegdSiY/P+iIS6czl/KK9CvmU
   1XiQtBoEDwfSjXtbh8i10rMvo51yBLRW2nfwpVfApr1gfqlym1vq+jPly
   d/dtEKw3f7rPSOYALB0Km3K2nDPiXRME1MiqENTRJ78Zvjl9VfbGp/59K
   cky6qGMzNpjse28gC4FVKrar95QS9qDyushoJzjoSR84ba6fTAOqoH2kB
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="434396995"
X-IronPort-AV: E=Sophos;i="6.01,262,1684825200"; 
   d="scan'208";a="434396995"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2023 07:02:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="854669981"
X-IronPort-AV: E=Sophos;i="6.01,262,1684825200"; 
   d="scan'208";a="854669981"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga004.jf.intel.com with ESMTP; 07 Aug 2023 07:02:37 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 7 Aug 2023 07:02:37 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 7 Aug 2023 07:02:37 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 7 Aug 2023 07:02:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VTfRtc60UhnsluPMaReCAi6WLZS/LcaCfj4BQVN/igMsp8myDymU22zT7J7tKPUDqGNRReyW1B7iviQZ0coCs+e422km9E6A7xPUFWUmMiK+6CD1ac9aVKWdkv+GQjc95ewk1Ovuzn9CZDHKPxkuTA1ddagk7uO40bzgUSdbCj1HcJfBcYkcMJeiZJEC6DrCz0/zyPfdBkjEcRGOzFoM6u8QOijbK7ADtkn5vuOxnWsyjA++ZgGm03sa2vTxq3E264K9VukdvAC1zlEkdUAP0GcqPOpN3qcqG3e90PR8UjLjkc3Aq/0hzOFXG/XSIIvkiBJBG/h6BPGcWzLw/yEBHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CvYMilWXhftGiNbs0zmYaPfZE4y554HvHzlmByODIvc=;
 b=MfYFoVDh5pA7PziCHLQLVPf8eshbTN6AIQsbonvVCSDw/lJnWpZuRAfjhJ8ks3kzQorSfKT+1NaqaRtKdeBgCQ7y/CzPjvh0sjWemXa1TelG8KqkG6dC//qei2wKUNZBo+sbPK5YIfuFa5zxxSMkGlSSzzIwzNBYSdt9f3fLQulCP0Wk4MiyeyBC31emDymiDOnQXBtwmfKjdVbQWacXr+6u+tcQVDP2np+4m8iUQIabAyg230mxQjtl4Q4B/0iD64N0DfLZ+P4f3CJNrNKUOB3/d8oMigsiUVwY5k1XAJkl2K6rx9QvYqAvnTzDaRKbMHA9EMIXfe3QVJT/3p01hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by CY8PR11MB7396.namprd11.prod.outlook.com (2603:10b6:930:87::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.26; Mon, 7 Aug
 2023 14:02:35 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::b556:42c4:772f:d47e]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::b556:42c4:772f:d47e%7]) with mapi id 15.20.6652.025; Mon, 7 Aug 2023
 14:02:35 +0000
From:   "Liu, Yi L" <yi.l.liu@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     "Tian, Kevin" <kevin.tian@intel.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
        "cohuck@redhat.com" <cohuck@redhat.com>,
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
        "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
Subject: RE: [PATCH v4 07/12] iommufd: Add data structure for Intel VT-d
 stage-1 cache invalidation
Thread-Topic: [PATCH v4 07/12] iommufd: Add data structure for Intel VT-d
 stage-1 cache invalidation
Thread-Index: AQHZvh/vmslv1BsHJ0KI1gktitpb2K/WrSKAgABmfoCAALXhgIACYSNwgAASEoCABK1qoA==
Date:   Mon, 7 Aug 2023 14:02:35 +0000
Message-ID: <DS0PR11MB75290C3742DB3A7AD3BE6796C30CA@DS0PR11MB7529.namprd11.prod.outlook.com>
References: <20230724111335.107427-1-yi.l.liu@intel.com>
 <20230724111335.107427-8-yi.l.liu@intel.com>
 <BN9PR11MB52763681308D7950A51E18438C0BA@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZMpei2/CffaW97iU@nvidia.com>
 <BN9PR11MB5276035683CE2AFB7B0F36D28C08A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <DS0PR11MB75295187EE9B4EB64D8797CFC309A@DS0PR11MB7529.namprd11.prod.outlook.com>
 <ZM0FQW9qo3RoNKmX@nvidia.com>
In-Reply-To: <ZM0FQW9qo3RoNKmX@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB7529:EE_|CY8PR11MB7396:EE_
x-ms-office365-filtering-correlation-id: ef9ee540-65b4-4b43-7966-08db974ef386
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: D366J5c5I9wntjS9fp+BgwMHpXO38dLIVlY1marSBBiwH5Ol2wBLwTywf6yMP5GbpVdUUmFiSvP5lC+QXOVW9sWcVGP2tldut2M75AnKyMAsecOL1ybwnWDjzwylEsrVd2MIGPu6FW7Ruob6oxCpBQ0K+vOtthC/WV061simy8Ki9KNEq0JoKqtLaKND0CwNZxi/VSwQE/NMo1QMGybQHPfa8oW5oK2+CD49WBk6/jpXR+jgITVAp8Z9tPj4YNrjvaEG3BGW8/J/8kyBq7auLLP7uUVrWsXO9AkrHau/f8/olgi3RdtPHnVZyJDHUSo0GMlyMhCcKlZR46wBXLFZUhosY9/EgaqU+B6zIdXpHpHNiwBj8pu+UWATT9HIApKCFYUwr9J4jSU87bKeT+58+35auaDBUvYgbOmHvvHr+Z3mITA2eXWzB/CaFkzdKkz+AP9qRKYLUsAj8Xll+wJkjA8H/O0oPRe6PT3t6MV72MJ/Wa+r4vavEs2jr9BwYSkhaBauqShlwqq4ZSQr9uN6gA21/trJEVHWYJGJTccHDLE4Rc/o0GH9WAJwOJ6HSs0YQGPY2LDJgxP7ILzXm86jFfSOrbzOxbT9QXSI78ZuhBS7KJhCbpNiBq2wk4e2jFj+
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(366004)(376002)(136003)(346002)(39860400002)(451199021)(186006)(1800799003)(55016003)(9686003)(4326008)(316002)(6916009)(86362001)(122000001)(478600001)(54906003)(38100700002)(76116006)(66946007)(71200400001)(66556008)(66476007)(66446008)(64756008)(33656002)(7696005)(6506007)(82960400001)(41300700001)(52536014)(38070700005)(8676002)(8936002)(2906002)(83380400001)(7416002)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c0xHVWlReTZRTjgyMXMrWkVNRkpVSUVLVTBWMVdCdWEvVFBpZEMzd1lKemdU?=
 =?utf-8?B?U2pCV1Q3VERqemhjOUdvbEZtVkZMUFVCTExBRE1DVG9iVWJ5bUpyS0pPcjJi?=
 =?utf-8?B?U1g1VXZyQ1hyenJKOWd1TGEwUUVnazFQSkM0QUU5SFBqUUdWRmNWRGFXNGhN?=
 =?utf-8?B?S21LMUZVTmxjZjhyWHVyTEhqWGh0MVlLaUtJajUvaUV0cUM1SGFIN0lxSzEw?=
 =?utf-8?B?Tm02dVIwcm9PU0EycWZYa3Y5UkpFK2Z6ZEZGcWx6VlhFcnNCMENOS3dveDFR?=
 =?utf-8?B?d1Jobi9yb0oyekVPYlhtUDVwbnRhdno0QkNFbjZRaVpETjZJUVJKeGhQL0VI?=
 =?utf-8?B?RjJhSmVXOW4yQ0JLa2YyOTlxVjl1ZWdmTlJKWE9oL2hiNDFVaFBCank5NlBN?=
 =?utf-8?B?SkRLZmRWajg2SnNVQXpwL1V2NEQvek1HSDF1N2tYeHZZQ214V013b1FhMUV3?=
 =?utf-8?B?RUUwdlR1blFRSFpIbGowSjV5QTlMWmMwK0dVV002ZHhvalI3SSs1SGsyTit1?=
 =?utf-8?B?UG5Td2JYc2E2ZEZlL1M3dk9BNnlaOVlCNjhoOUlHYkVOa2hkbnFXcTRYZG9r?=
 =?utf-8?B?Qi9XdHZ3b3V3eG92S1ZRQmgyVGFtcUJ6UHFHempLV0tjVk1jTDMzQktIeHVV?=
 =?utf-8?B?Q2xCOWtCUjluRmVVa1JZbUVOQnA5c3phd2tIQ3gvL0M4dlo0R09oeW9nMFpz?=
 =?utf-8?B?YmdCZ29LbkRwbW9kajBLdkhiQWc4UHNsZmtYUWU0SkNibEdpaDU2K3lZbmJk?=
 =?utf-8?B?a2NtdytTU3diR1JHQ2ZSc0hoa08vMElUUi9FTFpoQ3F3L01rSWFTcWR6cXUz?=
 =?utf-8?B?cHQ3RGg4WC91TGJQRmdoNWhWclRFdWRjTEVDY0s5QlpkM0xiWmtTN0N2a1h4?=
 =?utf-8?B?ZjdSL01HREJZa2VDekQ5S05yWnBheVdzbnJrTkt2T3ZERmM4SHQ1cnFlNlIv?=
 =?utf-8?B?VnhVNjBxTFUxU3NRcVFvYjlaSDE3cmlDVzVHSExCbTBhdUMxcnEyZXNWQ0V3?=
 =?utf-8?B?QW4vTEFJQ2xJN3FsK0RZd1pjbHdQU1JBTEtZNG9BL0JJSmVSSTRWeTdhZ3Fw?=
 =?utf-8?B?dTJ4c0l4c3NPOHF1UFVLdU9HQ0pEYU5wUTBnYUcva3BGVnJSK01oaGcrd0Fa?=
 =?utf-8?B?ODFrazUxNWF2NUpWZVFQNjFLUHNGaElUUWdOYmVrdmtSUHJsamM0b3ZLQUUy?=
 =?utf-8?B?a0U2dlc4cFc2c2lQOENRZkZJbmIyUEo1QjhiTkphSE53dTRhazVvUHpQMDZh?=
 =?utf-8?B?RlkyRVMvMThPL3Q5UFJUQU9ZSXJZOXF5SjJXeDJ3dVEwZElDdU96RWVUNmVN?=
 =?utf-8?B?NUZXT3phNWIyU1BJQy9RcmRiM0xuMnA2M2FlTVgrMjk0VE5IN2JBdmNKUk1z?=
 =?utf-8?B?SXQzK3JQVGZ0UW9aOEpUV2dCam5Iamo0TVhyT0xpejB4dDBRQVozZE9hSEJq?=
 =?utf-8?B?d3dUNGoreWtOalZJMUFCWWRoV0FCendtZFdad1VLeDRTOW9LVWlMN0R0M2Y2?=
 =?utf-8?B?VXhMdm1wSHpaTFNqZ0Z3ZWpwMDEyazRJRVg1WTNqaFRpbkJqMy9mK3EwQzA3?=
 =?utf-8?B?ZlpVb0VxeVRRbVc1czNFVU9EanlNQUJ6RFR2cFRUekl1Q01pV2JvOHh1MEF2?=
 =?utf-8?B?SEN2N2VuRWl5NU1yOCtSR1MxcjhMZ05RY1lPZjhLcUcvbjJUOU95UHpXZzBp?=
 =?utf-8?B?eU1yRTIzL3ZpUzlYS2VqMmNaYU5xMXMraG9HOHIzOXVtWkVSOVhtaElXTlBr?=
 =?utf-8?B?NVFwTjhLVEduNmUxeVMzRUVVMlpGek1lbkFkNXlaYzFvb0pGK0t6d3JqQTYy?=
 =?utf-8?B?NTdYcTY2K3Y0M29vT1Z6YnFiOUZ2aFlsNnJVZnQ3UEVHWjVtOHkxMXhSUERa?=
 =?utf-8?B?c0pGRmNHeXBQMk40RXB3YytJV3FKc2dFU3JUbmlNS3FpUW8vUFkrSisvL3pv?=
 =?utf-8?B?TkEvUU9PY3E1UmFyMnBZU0QrOGNjdm9pQVpEZWNGODVaakt1Z3pDWkszV3J6?=
 =?utf-8?B?YzVKSjBRangwSHB1bjF6TUtXOGRxcjFjMEpnWDlMYm5MR2ZLV0poV3R3Q09T?=
 =?utf-8?B?Nzk4ZitYYWk4cVpJOVRUMFRxKy9aU1BFaEV3QT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef9ee540-65b4-4b43-7966-08db974ef386
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2023 14:02:35.1487
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XuBqs9kw/a73TiJXV3g326K06UY/fcJQGP0bg9weVYolBZ4FMB0XyLpiRhONQcEJrwOWdSxr0/P7fvrtYGFyTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7396
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

PiBGcm9tOiBKYXNvbiBHdW50aG9ycGUgPGpnZ0BudmlkaWEuY29tPg0KPiBTZW50OiBGcmlkYXks
IEF1Z3VzdCA0LCAyMDIzIDEwOjA0IFBNDQo+IA0KPiBPbiBGcmksIEF1ZyAwNCwgMjAyMyBhdCAw
MTowNDo1N1BNICswMDAwLCBMaXUsIFlpIEwgd3JvdGU6DQo+ID4gPiA+IEhhdmluZyB0aGUgZHJp
dmVyIGNvcHkgaW4gYSBsb29wIG1pZ2h0IGJlIGJldHRlcg0KPiA+ID4gPg0KPiA+ID4NCj4gPiA+
IENhbiB5b3UgZWxhYm9yYXRlPw0KPiA+DQo+ID4gSSB0aGluayBKYXNvbiBtZWFucyB0aGUgd2F5
IGluIHBhdGNoIDA5Lg0KPiANCj4gWWVhaCwgeW91IGNhbid0IHJldXNlIHRoZSBzdGFjayBidWZm
ZXIgZm9yIGFuIGFycmF5LCBzbyBwYXRjaCA5IGNvcGllcw0KPiBlYWNoIGVsZW1lbnQgdW5pcXVl
bHkuDQo+IA0KPiBUaGlzIGlzIG1vcmUgY2FsbHMgdG8gY29weV90b191c2VyLCB3aGljaCBoYXMg
c29tZSBjb3N0DQo+IA0KPiBCdXQgd2UgYXZvaWQgYSBtZW1vcnkgYWxsb2NhdGlvbg0KDQpZZXMu
DQoNCj4gUGF0Y2ggOSBzaG91bGQgbm90IGFidXNlIHRoZSB1c2VyX2RhdGEsIGNhc3QgaXQgdG8g
dGhlIGludl9pbmZvIGFuZA0KPiBqdXN0IHB1dCByZXEgb24gdGhlIHN0YWNrOg0KPiANCj4gCXN0
cnVjdCBpb21tdV9od3B0X3Z0ZF9zMV9pbnZhbGlkYXRlICppbnZfaW5mbyA9IHVzZXJfZGF0YTsN
Cj4gCXN0cnVjdCBpb21tdV9od3B0X3Z0ZF9zMV9pbnZhbGlkYXRlX2Rlc2MgcmVxOw0KDQpTdXJl
LiBUaGUgd2F5IGluIHBhdGNoIDA5IGlzIGEgYml0IHRyaWNreS4gVGhlIGFib3ZlIGlzIGJldHRl
ciBhbmQgY2xlYXJlci4g8J+Yig0KDQo+IEJ1dCBJJ20gbm90IHN1cmUgYWJvdXQgdGhpcyBlbnRy
eV9zaXplIGxvZ2ljLCB3aGF0IGhhcHBlbnMgaWYgdGhlDQo+IGVudHJ5X3NpemUgaXMgbGFyZ2Vy
IHRoYW4gdGhlIGtlcm5lbCBzdXBwb3J0cz8gSSB0aGluayBpdCBzaG91bGQNCj4gZmFpbC4uDQoN
Clllcy4gc2hvdWxkIGZhaWwuIEl0IHNob3VsZCBiZSBmYWlsZWQgaW4gY29weV9zdHJ1Y3RfZnJv
bV91c2VyKCkgYXMgSSB1c2UNCml0IHRvIGNvcHkgdGhlIHN0cnVjdCBpb21tdV9od3B0X3Z0ZF9z
MV9pbnZhbGlkYXRlX2Rlc2MuDQoNCiogLUUyQklHOiAgKEB1c2l6ZSA+IEBrc2l6ZSkgYW5kIHRo
ZXJlIGFyZSBub24temVybyB0cmFpbGluZyBieXRlcyBpbiBAc3JjLg0KDQpSZWdhcmRzLA0KWWkg
TGl1DQo=
