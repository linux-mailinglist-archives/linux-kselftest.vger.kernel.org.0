Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 296E577E109
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Aug 2023 14:04:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244413AbjHPMEJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 16 Aug 2023 08:04:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244938AbjHPMEC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 16 Aug 2023 08:04:02 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C5962121;
        Wed, 16 Aug 2023 05:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692187441; x=1723723441;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+cRcR7HHdWtWlDtnHdT+310tb+0ELSMZF8vAn2gNvWc=;
  b=W650ITPKvkexhwdCk19zptVsJ93skaueVkc/xiYoAEMCuwV9eUQRB6GO
   T4gkfVMZZuT0/qTo0eLqtixcx71GMTv827ui5IkQQ4EtckqVY8F0WXIgZ
   F89vxUjR+19bkBtNwiuxio3DOyh+nqrhKvhcIMxpIVo5yv5htTUjiOUbb
   tLXrJm8WJJXQezmAXRV4EjxgKiQqEH0Uext+pPEAcRrEwH0Srz/tVQuUO
   ti40+XRCt70dirH96gxzerGdLOC7OgTDpN/m28g/0C4OhAIhTGGLrJb6s
   EnEM4J+YcHiMlgOeLrFVp2AnFqzzd09cWYGHx6yJZL73XrKsLNtDm005Z
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="352103070"
X-IronPort-AV: E=Sophos;i="6.01,176,1684825200"; 
   d="scan'208";a="352103070"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2023 05:03:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="737283945"
X-IronPort-AV: E=Sophos;i="6.01,176,1684825200"; 
   d="scan'208";a="737283945"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga007.fm.intel.com with ESMTP; 16 Aug 2023 05:03:49 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 16 Aug 2023 05:03:48 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 16 Aug 2023 05:03:48 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.174)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 16 Aug 2023 05:03:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M1Clm6FrQTMzAzq2uANcaVpwgp5SdLeGU3A/uAdKO+DrhfcHs7SQ6unWqaIBbr/poxlowzUhHijzS51n8AbhbS1J1zjHyHNOxpws2/SZznhecPbriDgH/TyIzow96HQJXS7fLOQ4n0Msh1hP1FdhUBBGZ8LkZca6yvNvQa1GpnTIxPrpVYR5j9VK0/9z/pkYLK0aGDpiyQaoRTLj2XB3CV+pmePXKS5SOHQiu35vEIQ+SSMjVYWz9E+RN0M4expVlm9/OrJw2JuFHx/dGAUnFt+3x0nfTDTeFZ4e/mz7eOCyvUYJpbQJVE2E4cIJ58fLcEDfBwSpUENLR8q3bemhgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+cRcR7HHdWtWlDtnHdT+310tb+0ELSMZF8vAn2gNvWc=;
 b=j5MtW0iRGrTlx/Gv0w0KlyXRpRxU/XJShhco4k4wA2TnYOrJzvTRbI2FO/UNIlnsmGqGVgztFrIbMY8NRks/I9p8BYSwp3+geVvvMrdg9m+ZxZw6+yxezu/GTq6l2WBRTaXgLp0KRCFY7LR3jRi/w09po5wCscrq4bEbfLhmf9rEPZxhuzxkOBPnqX+ZFQTx2Ue0Vx1ndmZsQR9x/0vTwMscsxvAw/S4bsVZ0Zl4Fx1sQk5N1BwsGhYrfDZEbdIztbRteaMnNzuNki8VmUqu1WLdGsbJpXNDKUqmHslWEMuEme2w0XQTSg8Z1zUjMvj+MrReElD3GG8rcOZtLWSfQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by PH7PR11MB7478.namprd11.prod.outlook.com (2603:10b6:510:269::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.30; Wed, 16 Aug
 2023 12:03:44 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::88db:59ea:ce73:7705]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::88db:59ea:ce73:7705%7]) with mapi id 15.20.6678.025; Wed, 16 Aug 2023
 12:03:44 +0000
From:   "Liu, Yi L" <yi.l.liu@intel.com>
To:     Baolu Lu <baolu.lu@linux.intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>
CC:     "joro@8bytes.org" <joro@8bytes.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
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
Subject: RE: [PATCH v4 11/12] iommu/vt-d: Implement hw_info for iommu
 capability query
Thread-Topic: [PATCH v4 11/12] iommu/vt-d: Implement hw_info for iommu
 capability query
Thread-Index: AQHZvh/wEGmQROGA/kmA4ZglwG+1xa/rr5mAgACHIQCAALuCgIAAAMGAgAAD5YA=
Date:   Wed, 16 Aug 2023 12:03:44 +0000
Message-ID: <DS0PR11MB75298006F2D6F3F6720AB71DC315A@DS0PR11MB7529.namprd11.prod.outlook.com>
References: <20230724111335.107427-1-yi.l.liu@intel.com>
 <20230724111335.107427-12-yi.l.liu@intel.com> <ZNuoWRH/HthxsLMd@nvidia.com>
 <c6c6a390-d1d1-a5f7-cbdb-2120043eceec@linux.intel.com>
 <ZNy2/4D9AqjtUAnF@nvidia.com>
 <faa5a247-c42f-8399-0f70-79d0459773b5@linux.intel.com>
In-Reply-To: <faa5a247-c42f-8399-0f70-79d0459773b5@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB7529:EE_|PH7PR11MB7478:EE_
x-ms-office365-filtering-correlation-id: 55ff9f95-2f4b-4264-b40b-08db9e50d6c4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OXslkoll+JTG/ya4R3mGlvkJPeSWm67gTsqFhRponloSHNjf5TI5bSq2gbJXymjiPJhX3b/Q63v4ixJ2R9RB0HLY50rbmfItq8eOKbhCYgpiIKn1413RD/9izOVfQ2dKA1BKRlBe3u+MgpgbAdIyZduJv1Tw2MoR2O//yuXZMvDIH3qi58Z20NcCPgmMIL6QKyrxrPEyEad9lU1rMO7v5J7jav8Vq5m6ADqKs5M3FX9RR/qOFTdMLXYNflER/H+kHallp0/hJcyRlJY3z9k0c1YXYvLDwZR4P2T0EkyTlx+JzH848yrdhg77nNbYWyNvEHRt6WVGQVnb78g0MYYx2LjxW89o3mwyWs2A/AkkdHN16hqsNbKU4lbbv/Idr4DM57NfgjGknS+o/md5/r9QH7ydFgSGtTbbIKrdv6405KV5URg5Up5739Hl2Cdv2XC+pcpTq9TZ7ME3m+5TSK7M5Xmkflrh8Ead17oSDBUWrxvJfW8qM9m+wjTSYr3dqY3Ow8dEBBA5kP75s+e7EoX0jcN1ZetiWhiuiHPEn5oO+2lTw1dqcyb1HiLCElT7hA8QoceeKTg3uRvN71s0aGlCwr1kiVamn1aqg6G3WWIxpXYVnEdgM9xPjuceCF+rrAV7
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(346002)(396003)(136003)(366004)(186009)(1800799009)(451199024)(55016003)(38070700005)(38100700002)(66946007)(66556008)(66476007)(66446008)(64756008)(54906003)(76116006)(82960400001)(110136005)(316002)(478600001)(122000001)(7416002)(2906002)(41300700001)(52536014)(5660300002)(8936002)(8676002)(4326008)(9686003)(71200400001)(6506007)(7696005)(53546011)(26005)(86362001)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aTVPZVhsNkwwR2pLeFE2UE9CcENUTzdiQytEeFA4b2ZMcjdEVlNBMm8yRWUz?=
 =?utf-8?B?ejVqV2VtTEVTTHdEQVI1WmNoK3FHUDN2KzBvcGtPTlhXbGc1VWZyRDVQTExB?=
 =?utf-8?B?elNiOFJpWmRkbXliZUN0MGtLQmVRVXJBNXdyYndMNVZtNlFzT1VkYXpBd1B2?=
 =?utf-8?B?ajZNdlUzQ3NhNkY1cWFFMERUY1BrbHFiN0NEVkxBOGd2bXlnU2pUb3pYQi9s?=
 =?utf-8?B?bFZKd0Zqbm5aSjRNSXZMaHBJSWI1RWpCTExJSUduL3l1d0laNlUweVlYaDVX?=
 =?utf-8?B?YzI5dW1nQzJScXFiKzBNdVVrL3NPQW5aRUZpRnJtdS8zUWZEekZpYXpBZEZv?=
 =?utf-8?B?NkRVT0EreUE3eFpMZ0ZzTUs2NHRrWE5yUEhjVzJtVzB2b2RsTDJkRG1NWnJ5?=
 =?utf-8?B?blNxTkFsazh5dHRqRVBQQ1h0N0RhZ1BpSWVoUkNXT0NvY2k3TGNLZWZMZC9r?=
 =?utf-8?B?M0JNQ0VsT1RJZ3VPVFBPQjJpa0J1SmZ1QTBYOGNkNkFXaWZaaEFRVTRoOWRI?=
 =?utf-8?B?Q0wvdTBWRlp1QVNuU042TnlJcEZJS1F6amNSMWMzbDlqa21ETmdyY1lIK0Vp?=
 =?utf-8?B?SjJ5eEJCWUZKaSs0bjk1TGNKMllqakt3MjRpdUVTMitxaHZ0dHlIRnkraUNw?=
 =?utf-8?B?R3JYS3ptRnlCcDZlb3VWWlhtWHBGYk5La25kY3J5QmNjMUl3dkFESitxM2R6?=
 =?utf-8?B?b3hFTjY2SmVWQjFkbGcvVkFaUUdDZHNpT0JmSVY5d2RHa3g5b2dEVmtsVE4r?=
 =?utf-8?B?cE14SGFhelRaNlRsUjVvVWRoNVByMlR6Sy9SeGdpQVZsb3k1WDVQc0dpYUt5?=
 =?utf-8?B?NjBBaWgyM1JTUTN0bkhiSkRxM2RJZjBEL2JVamxxd015M1BmTEZ2bkRFWlpk?=
 =?utf-8?B?QWxmL3VKc0Z1dzNSY1JseHVSMWQzOExBdlRlMGRSdUxlVDIxeXhpOUd5eUlw?=
 =?utf-8?B?RVljN2J1a0pmZjRTRExsdGJpc3BoajM0ZUFNRjVJNkZoZHFqVHplaE1NU05D?=
 =?utf-8?B?RXhCcUZ5YngxVmhzWUtId3RMaGthKzFzN2R2M0RMTEkvTVE0YVg0R1l1M3lw?=
 =?utf-8?B?M2NvRERWbWFib0FVQXZmRzBtYTFzUk56MnZscU90RjIyWEdRLzVjdGJTYVlE?=
 =?utf-8?B?ZW5lSWlVTlJ6WmdzVWRXZlVUVThZSVFhb0RPR3lJVEhsV3F0b1FhdldTbS9P?=
 =?utf-8?B?MW5sUXA5RFBKWFpDWnQ4ZlpXWkR6K1NXM2c4ek15TmVyT0MrTXE2UDk4ZDJv?=
 =?utf-8?B?L1ZJc2h3d1NwKzVodGNtZVNMOVNNWm5WZEtKWW01MlRHMk1BUlQ4OHZsM2Fz?=
 =?utf-8?B?M3lwUzBPREVUOGJRM0tEZFREcW5TTGMraExZbVV3dWpJYUN4akRIU1Bva3JX?=
 =?utf-8?B?dFEwWUZ3Yiswekh4VEZOVER2dm5DVExPclYzVVBHeFZVejFzNXE0NEJXeWgy?=
 =?utf-8?B?SG13eHNiRkdvNTNYU2ZVbEgzS1BacVR6K2V2MlVUMTJvemVJbW5sM2dqajdx?=
 =?utf-8?B?M1ZZTkRUZ3pGc1hEYmltTkU2U052emE4SkVXRmF0b1ZoM3VnOE43cmJDaWVJ?=
 =?utf-8?B?TFZLSVVLc0VQYTFnNXpDWThDd3c5bTJVVU41WTZwNkZSSFVhNUJYays2V1Ur?=
 =?utf-8?B?M0lYZEQ3ZXN4akZXdkdzVVJ2a05KV2dCOHB3eFBCRlZTdWNXdWdzek4yVE9P?=
 =?utf-8?B?SENNVlpFaENlajJrZnRjNmxyc0YyaVVPVzRvL04ySlBiZlRaUk1FNlJ3YUxa?=
 =?utf-8?B?ajRWS1EyL29KUFVmdWQ1OWFJbVdhYW9xWVI2dnVEZGoyRnplcGQyUFljemYw?=
 =?utf-8?B?R3ZYR3hnL3hyS2Y2ZTIybno1Vkgvc1RLSnU5THhLUTdsYjkrbzNpWEVXRjFC?=
 =?utf-8?B?bVNNeVFxSGRPQUZZMEVWdE1SZW13SFhialRQU3F2Tnp6WVZnTkI3VjBieFpp?=
 =?utf-8?B?VEl4MFQ3MlVPWUk0TXJoVXFyaDcxSFU3dU91WEVBT3Fqclk3Y1ErVjFYMy9R?=
 =?utf-8?B?a3pWRW9zWjhmV2pSeFlZSHpXbzRNUXYzVmViVEtKZ3hqSHZORnlZbk9OYXox?=
 =?utf-8?B?eldyZWsvbnN4dGNpRGpOL0ZwL2N1UzBMUEYzcWJjOGtySzJ4OWE4d3NiTUM2?=
 =?utf-8?Q?iik4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55ff9f95-2f4b-4264-b40b-08db9e50d6c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2023 12:03:44.0649
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vAQRBtxPDCiKULy2U+0h/TIAm3/B4y/S8PUe4eyJmoR44y98yitBpC12x1J9dexDeIx5b/MxRzYtwYvazbv3hQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7478
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

PiBGcm9tOiBCYW9sdSBMdSA8YmFvbHUubHVAbGludXguaW50ZWwuY29tPg0KPiBTZW50OiBXZWRu
ZXNkYXksIEF1Z3VzdCAxNiwgMjAyMyA3OjQ5IFBNDQo+IA0KPiBPbiAyMDIzLzgvMTYgMTk6NDYs
IEphc29uIEd1bnRob3JwZSB3cm90ZToNCj4gPiBPbiBXZWQsIEF1ZyAxNiwgMjAyMyBhdCAwODoz
NTowMEFNICswODAwLCBCYW9sdSBMdSB3cm90ZToNCj4gPj4gT24gMjAyMy84LzE2IDA6MzEsIEph
c29uIEd1bnRob3JwZSB3cm90ZToNCj4gPj4+IE9uIE1vbiwgSnVsIDI0LCAyMDIzIGF0IDA0OjEz
OjMzQU0gLTA3MDAsIFlpIExpdSB3cm90ZToNCj4gPj4+PiBBZGQgaW50ZWxfaW9tbXVfaHdfaW5m
bygpIHRvIHJlcG9ydCBjYXBfcmVnIGFuZCBlY2FwX3JlZyBpbmZvcm1hdGlvbi4NCj4gPj4+Pg0K
PiA+Pj4+IFNpZ25lZC1vZmYtYnk6IEx1IEJhb2x1PGJhb2x1Lmx1QGxpbnV4LmludGVsLmNvbT4N
Cj4gPj4+PiBTaWduZWQtb2ZmLWJ5OiBOaWNvbGluIENoZW48bmljb2xpbmNAbnZpZGlhLmNvbT4N
Cj4gPj4+PiBTaWduZWQtb2ZmLWJ5OiBZaSBMaXU8eWkubC5saXVAaW50ZWwuY29tPg0KPiA+Pj4+
IC0tLQ0KPiA+Pj4+ICAgIGRyaXZlcnMvaW9tbXUvaW50ZWwvaW9tbXUuYyAgfCAxOSArKysrKysr
KysrKysrKysrKysrDQo+ID4+Pj4gICAgaW5jbHVkZS91YXBpL2xpbnV4L2lvbW11ZmQuaCB8IDIz
ICsrKysrKysrKysrKysrKysrKysrKysrDQo+ID4+Pj4gICAgMiBmaWxlcyBjaGFuZ2VkLCA0MiBp
bnNlcnRpb25zKCspDQo+ID4+PiBJIHdvdWxkIGxpa2UgdG8gcGljayB0aGlzIHBhdGNoIG91dCBv
ZiB0aGlzIHNlcmllcyB0byBnbyB3aXRoIHRoZSBtYWluDQo+ID4+PiBnZXRfaW5mbyBzdHVmZiBz
byB0aGF0IHdlIGhhdmUgZHJpdmVycyBpbXBsZW1lbnRpbmcgd2hhdCBpcyBtZXJnZWQuIEkNCj4g
Pj4+IG1hZGUgdGhlIHRyaXZpYWwgZml4dXAuDQo+ID4+Pg0KPiA+Pj4gTHUgYXJlIHlvdSBPSz8N
Cj4gPj4gWWVzLg0KPiA+Pg0KPiA+PiBSZXZpZXdlZC1ieTogTHUgQmFvbHU8YmFvbHUubHVAbGlu
dXguaW50ZWwuY29tPg0KPiA+IEkgY2hhbmdlZCB0aGlzIHRvIGFuIGFja2VkLWJ5IHNpbmNlIHlv
dSBoZWxwZCB3cml0ZSB0aGUgcGF0Y2gg8J+YhA0KPiANCj4gT2theSwgZmluZSB0byBtZS4NCg0K
SSdtIGdvaW5nIHRvIHNlbmQgaHdfaW5mbyB2OCB3aGljaCBpbmNsdWRlcyB0aGlzIHBhdGNoLCBz
byB3aWxsIGFkZCBiZWxvdw0KdGFnLCB0aGFua3MuDQoNCkFja2VkLWJ5OiBMdSBCYW9sdSA8YmFv
bHUubHVAbGludXguaW50ZWwuY29tPg0KDQpSZWdhcmRzLA0KWWkgTGl1DQo=
