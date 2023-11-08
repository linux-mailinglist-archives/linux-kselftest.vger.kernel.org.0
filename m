Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 710EE7E521E
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Nov 2023 09:46:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232221AbjKHIqq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 8 Nov 2023 03:46:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232606AbjKHIqp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 8 Nov 2023 03:46:45 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16529197;
        Wed,  8 Nov 2023 00:46:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699433203; x=1730969203;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/VNzWNbI07K3ftFdPr1b6Z9pnv0n9UKwZ0IhGkY0QBY=;
  b=SdLXMQoLXz3nTrY/2+aTt/CwDgqv8Tlkggb3nEz8AXnKMV3nZOgNtH7y
   vDDo4PyYjDT7VV7Nm7JHuX68RKyWTmQ/JvWzDDN4FE0FLCgsAfzSLmgk/
   xJYzBwOO4VoGUET2KG13ThaqHmUBWiS6XXtJM4aQbidnYEEuiWlj95TIF
   GmkMRp+XzPIGvyqNjwwJIh6bZuF5AY4hoFbHJpySEJXAxtIYJ7v6iHVEg
   jgrnvf7YSK3s88cFfzpxu6kCiDSCNKFss5psGZRVbAA7r/Kx54s6xUDKP
   lhnK67GZPQvIGxVop/gwc2Pgm0OOE5maCSwIKAfQyS71hduIve4p3lO/+
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10887"; a="475950378"
X-IronPort-AV: E=Sophos;i="6.03,285,1694761200"; 
   d="scan'208";a="475950378"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2023 00:46:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10887"; a="712868203"
X-IronPort-AV: E=Sophos;i="6.03,285,1694761200"; 
   d="scan'208";a="712868203"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Nov 2023 00:46:32 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 8 Nov 2023 00:46:32 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 8 Nov 2023 00:46:31 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Wed, 8 Nov 2023 00:46:31 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.40) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Wed, 8 Nov 2023 00:46:31 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W71zq4OSIo6aR0F8LOXKFQmqqWdBX/MtvvfsQVAt9uWTl+Ao2X1gLDXUVSBY9xyiNvvpLOoqtV6IAH59sSdPDcte8V2GmhdFmiMMfeJ97XGPtDWDMxHbQVp1YC8RndSRYiOrER12hsFJKGfypqiEFafpf+88SIH4Ixd8PULfV2g6BACY29RK/V/3cYWV99MBGtDyCciKiUfywxqNR4OcZjNcBHhMXxytvYpIJ9yHWzfHGJB3NmxauOCNnrwT+SrGlArJqPQk+zNIO/xLBy3OvKBAzf1GzTBq5Amqs73POK2e07hrAdWDSvUjwvZFxF5cMgqowdIIYswH+WV4WJVbTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/VNzWNbI07K3ftFdPr1b6Z9pnv0n9UKwZ0IhGkY0QBY=;
 b=lRRRs3cpawP8C1e3415coBwOfbN7fZgrp/FhdX1JMq3D9HU0RIpiDStCuwe/FIJ9Szms8cUIUfEb2O/xO7X5C2iiyX0aqUhsBTg1LiHA/qXAhaEOBUnKXgK8N+ybs0E7nwKNwwKUuhP6W+8zvMkZUUwuJMZoAKCmzEt1KXBX6ASYBnPo6vC4rJtCRtdxDQhpJn7zMDjvGyh0Yy/sWvqJquxm8knCK9qx/cBwDJle03NbSXL7DFKsSrlkWrRfPJw8Dz3GWqspECZD3rIojzCF7zZJ7pIWzI6zaFeLADNzwAQP2q8jqD45efDUVo8C74h6kCzVKULImYnA2xuNMmukyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SA1PR11MB5801.namprd11.prod.outlook.com (2603:10b6:806:23d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Wed, 8 Nov
 2023 08:46:28 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::e7a4:a757:2f2e:f96a]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::e7a4:a757:2f2e:f96a%3]) with mapi id 15.20.6954.029; Wed, 8 Nov 2023
 08:46:27 +0000
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
Subject: RE: [RFC 3/7] iommufd: Add iommufd_device_bind_pasid()
Thread-Topic: [RFC 3/7] iommufd: Add iommufd_device_bind_pasid()
Thread-Index: AQHZ+o3RxhI7HHkgwkmih2zPzlCqT7BCrnxAgC2LcICAAA6UMA==
Date:   Wed, 8 Nov 2023 08:46:27 +0000
Message-ID: <BN9PR11MB5276A47616E386F00AC50D728CA8A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20231009085123.463179-1-yi.l.liu@intel.com>
 <20231009085123.463179-4-yi.l.liu@intel.com>
 <BN9PR11MB5276BCF486E9E4F24913883E8CCDA@BN9PR11MB5276.namprd11.prod.outlook.com>
 <0ea819d9-1169-48b1-8579-3a054a0bd077@intel.com>
In-Reply-To: <0ea819d9-1169-48b1-8579-3a054a0bd077@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SA1PR11MB5801:EE_
x-ms-office365-filtering-correlation-id: 9ded1eb7-7964-40b6-09dc-08dbe0373285
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: av1YvQsvJ9sZGj2+vy3WhYgRqykisWXGbT2sqaUQ4VE+z14BMp4UVSNoTvRKDnnJQ+Ty416Fi+dn/8PcWlC0xGTtSG+ODLNoE432d22/Op6n2yOZCSkXOgX90WMExo9GvAiPbnveO4ZoBIJexnAMSlVaRYlOFdx+09EeweAMBsn8eyOhbEbkt16uacGxQLcDEMgEXSX0sH9QZDcsHGYQCiYWEAMEZvlKMxCtr3AdvHxI7t5TzWnD3RpERrZls2mKZXBEXwAACnmV/IOYFDLoj/hLR2cCbwPsTsWXbi8HnRt2/G5MdzsbYHVsYsWhh+9Y088Pp0Yiewsj+rXvajBwATxJVT3Q8IGOuHsGFazNZCBThNoi008yzoKn1baCdUFnwxIGJ+ehLysSEz3DrpuADIW8jGv9QkWbrRuBbgjb+fej32O1f4yx5bS1XdpI7L8a+e/i6wjCcFi33lew0KXvJEQIYUiL4QgM9mF6wrMv/r0JrUj/B5PmlZESKjKX46R0NCGlHn86+krtSojZAq8T6Br2fEIIYPeM1AM+5VkX9cYvsTBQeF6XRfSssDSBQ6QIZlp0VqTDcoXf48+s7QE208bTVTOsV5oOkCzmbbyuHUlQ460wgJquC0qBtmB8XNc9
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(39860400002)(346002)(376002)(396003)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(66899024)(5660300002)(7416002)(2906002)(478600001)(33656002)(52536014)(41300700001)(26005)(9686003)(82960400001)(316002)(6506007)(7696005)(53546011)(122000001)(55016003)(38100700002)(83380400001)(4326008)(8676002)(8936002)(86362001)(38070700009)(71200400001)(66556008)(66476007)(66446008)(64756008)(54906003)(76116006)(66946007)(110136005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MXlBa1kzU21WRXVLUGs1b0lqWmtPcUdUZTU4d20xRU52S2RRdDN2SElWbEQz?=
 =?utf-8?B?MWQzYVk5anl5cGxnRWw2WGpDQ0hHNTR3NkprOGxvdW00UzZoZC95QWxWT3lM?=
 =?utf-8?B?RGdId28xdHNHWkkwbU9oWlc3ZnNoOTFGL01uajBJeWpxQi9wci9WdG9aWXha?=
 =?utf-8?B?SUpqVWljdHpPekFoRzZ0elJmMUMvMC9jNGQ1TjlCZWNFaWw2RGtqanhzSUdC?=
 =?utf-8?B?V1N1N0JNTm8wKy80NzR1Q083NUZkNlNheEhhMFVxdTNVWko5R01BeFhLbUR6?=
 =?utf-8?B?K21GR2ZRbmV1OHcxbWVQdWpZcWI1OTlmYjhEbncxR05lK1FHODIzaGtYSkNx?=
 =?utf-8?B?L3R0T1JPbDRyTFc4MEN2eGNocUJNREltb3UrVERFWDhPcWhyZ2x1TEQxQmpl?=
 =?utf-8?B?aGRoakorQ2g2RlpGVVYxSU83R09WQi9TNUU2Zm1sYUV5N3FZS1BxYkFoRE1y?=
 =?utf-8?B?THJoSTBUNE1FNWJQKzEraEp4aTNCcDg3ZjduVUc4YUhwRkhDRHFXc3ZRaHFt?=
 =?utf-8?B?dFNOeEgycWxnd1RzdXMxMy9CdFJhelN1Wm9QTm1KSTdqWVFFb2RFTldWMk43?=
 =?utf-8?B?ODM3KzE2VGFCYTJ3Qlo5MkVPbGtURmU4N2ROb1IzNE5zMHpEWGNyQXBVQmJ4?=
 =?utf-8?B?NVQ0YUVHVTJDaDdzUzBtUTRpNlg1TXQ4bjIzNVJmY1NHNDR6c29OYXVJdDc2?=
 =?utf-8?B?dFFTeEErQStnWmJCN0Zqc2NMRHdOZS9MR1c2OWZHUnc3UzlLd3lVblhDaE9T?=
 =?utf-8?B?NnUvS0kzUmRXRG1FZ081VW1wU2JUdGN3QnVUaXR5dmI1L3gzQUpPaWhhRk1m?=
 =?utf-8?B?TTVNUGs3Tk53NnJ4UVFMS3dhbldJMGpLQmNKY0JmRjNmMXBnU2lwNTEwYWQ0?=
 =?utf-8?B?czVuK2dsMFFyeS84VTkrQnpoY1dRSUlNOHEzWnFtVjNkSVhmWDEySWhoVzAz?=
 =?utf-8?B?anhQYWJLN1l4N3FXeFNib1AxVzlSQUd3TXNCaEhjVnhldlJBZWNTMmdvYkN6?=
 =?utf-8?B?L2x1ampvTW9kckwwVEZNQnBlRkxPWVdlUlRraW9qTHdBNklZRFZtT2lCcXpB?=
 =?utf-8?B?T1VQMDlHRzUxYk1UUno0R2s3L3FmMzkwdkVHQnkvcXF3V0w5TDhRY0EvZnRw?=
 =?utf-8?B?N2tRa2Z4bTdKK1N5eFFPVEx1WGtHYXhrUURTVHgzRTdvTzczNGdiV2VYUXZv?=
 =?utf-8?B?cFA5MmZuMjZpa2dLeU5NTFhqcDdySms1VjJjaHhaK3pFaFdtQkh1eG5hN3V2?=
 =?utf-8?B?WjZyeS92MERTNzczSlA1anFEUHhTMnAwUW1mcEc1dUxtRDNEeGd3OU9BeExy?=
 =?utf-8?B?T2ozbVhpWTdoZDc3THRibGEvNXZhMDdKOFZXSVVKOXZ2ZFBDQllsOXdPRld1?=
 =?utf-8?B?UExXVWlpbW5EcmNHTzlpSk56YTNOd3poWmljYktWWVBHa0ZWMDlFamMzUDc3?=
 =?utf-8?B?dXlxVU5rUmNNcERESjRWb2JUU0hsdDYrT1R4VEZyajBhWXdIUXlGTHduOGRa?=
 =?utf-8?B?RitoaUlZa0NTSGU2OEF6aW9kcHlxT3FDTS9KcHBncEx3UHFLWEt5Q2hUZ09E?=
 =?utf-8?B?NXhhVk9TRkxRbURHdE1VSUwzZE5xbmRjMVdWWmt5TU5FOHBwWnpGWWduMG1K?=
 =?utf-8?B?WUJ4V1BsdlVrRU9DSDA1L2s4WUtMaWNtNDIzemM3YWVVaFNwcGF2TnZDMER6?=
 =?utf-8?B?cUFHdWE4NllRaWVzTWd2Z1FhUWt2ekIrL2ttT3NyZVBOSGpDRkpNclR1Q0x1?=
 =?utf-8?B?emZNVnppL0E3MVg5aFhpYWxRd2Z3VTRQcW8xRG5uRXpjVTFDVEVyT1Y3Qml5?=
 =?utf-8?B?MjB3aDdoS3djSkd6K2Z6aW40ZVcwdkMxTG8zT2MxUzJpejN5UXE2WTFJN1I0?=
 =?utf-8?B?SEhpejYwbWcvMFlkV0hZT0JKNDZxZWlhNm5WV1ZMclZWcnJ6WjRnMDgraGJV?=
 =?utf-8?B?eVhFNHlNblhKdU0zL2RwdTBGMm9TRUhOakROb3crUGt3KzFRRXpMZkVlMzMz?=
 =?utf-8?B?R01PdzNVQzRhVDdEVEU1bVRleWltQ1l5TXNaMzhORG4rUU4zT1d1c0R3Ym8w?=
 =?utf-8?B?d2ZXNXYvL29iOWlJeGdRbXppNFRDRkZhZWZaZjN6bjN2UStsVEFBSjA1K3lE?=
 =?utf-8?Q?Q+AGbqfVgoRNs9SOoPsOJPChH?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ded1eb7-7964-40b6-09dc-08dbe0373285
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2023 08:46:27.8277
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gIcfErP+yVu5OLz/hQcQEUDNQW8qSMBpasYJgUhUDVHGE3RM1Dn7iqj5p3By+l99qC8bfBhdW4YN9DcVClMtRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5801
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

PiBGcm9tOiBMaXUsIFlpIEwgPHlpLmwubGl1QGludGVsLmNvbT4NCj4gU2VudDogV2VkbmVzZGF5
LCBOb3ZlbWJlciA4LCAyMDIzIDM6NDUgUE0NCj4gDQo+IE9uIDIwMjMvMTAvMTAgMTY6MTksIFRp
YW4sIEtldmluIHdyb3RlOg0KPiA+PiBGcm9tOiBMaXUsIFlpIEwgPHlpLmwubGl1QGludGVsLmNv
bT4NCj4gPj4gU2VudDogTW9uZGF5LCBPY3RvYmVyIDksIDIwMjMgNDo1MSBQTQ0KPiA+Pg0KPiA+
PiArc3RydWN0IGlvbW11ZmRfZGV2aWNlICppb21tdWZkX2RldmljZV9iaW5kX3Bhc2lkKHN0cnVj
dA0KPiBpb21tdWZkX2N0eA0KPiA+PiAqaWN0eCwNCj4gPj4gKwkJCQkJCSBzdHJ1Y3QgZGV2aWNl
ICpkZXYsDQo+ID4+ICsJCQkJCQkgdTMyIHBhc2lkLCB1MzIgKmlkKQ0KPiA+PiArew0KPiA+PiAr
CXN0cnVjdCBpb21tdWZkX2RldmljZSAqaWRldjsNCj4gPj4gKwlpbnQgcmM7DQo+ID4+ICsNCj4g
Pj4gKwkvKg0KPiA+PiArCSAqIGlvbW11ZmQgYWx3YXlzIHNldHMgSU9NTVVfQ0FDSEUgYmVjYXVz
ZSB3ZSBvZmZlciBubyB3YXkgZm9yDQo+ID4+IHVzZXJzcGFjZQ0KPiA+PiArCSAqIHRvIHJlc3Rv
cmUgY2FjaGUgY29oZXJlbmN5Lg0KPiA+PiArCSAqLw0KPiA+PiArCWlmICghZGV2aWNlX2lvbW11
X2NhcGFibGUoZGV2LCBJT01NVV9DQVBfQ0FDSEVfQ09IRVJFTkNZKSkNCj4gPj4gKwkJcmV0dXJu
IEVSUl9QVFIoLUVJTlZBTCk7DQo+ID4+ICsNCj4gPj4gKwkvKg0KPiA+PiArCSAqIE5vIGlvbW11
IHN1cHBvcnRzIHBhc2lkLWdyYW51bGFyIG1zaSBtZXNzYWdlIHRvZGF5LiBIZXJlIHdlDQo+ID4+
ICsJICoganVzdCBjaGVjayB3aGV0aGVyIHRoZSBwYXJlbnQgZGV2aWNlIGNhbiBkbyBzYWZlIGlu
dGVycnVwdHMuDQo+ID4+ICsJICogSXNvbGF0aW9uIGJldHdlZW4gdmlydHVhbCBkZXZpY2VzIHdp
dGhpbiB0aGUgcGFyZW50IGRldmljZQ0KPiA+PiArCSAqIHJlbGllcyBvbiB0aGUgcGFyZW50IGRy
aXZlciB0byBlbmZvcmNlLg0KPiA+PiArCSAqLw0KPiA+PiArCWlmICghaW9tbXVmZF9zZWxmdGVz
dF9pc19tb2NrX2RldihkZXYpICYmDQo+ID4+ICsJICAgICFtc2lfZGV2aWNlX2hhc19pc29sYXRl
ZF9tc2koZGV2KSkgew0KPiA+PiArCQlyYyA9IGlvbW11ZmRfYWxsb3dfdW5zYWZlX2ludGVycnVw
dHMoZGV2KTsNCj4gPj4gKwkJaWYgKHJjKQ0KPiA+PiArCQkJcmV0dXJuIEVSUl9QVFIocmMpOw0K
PiA+PiArCX0NCj4gPj4gKw0KPiA+DQo+ID4gT25seSBNZW1XciB3L28gcGFzaWQgY2FuIGJlIGlu
dGVycHJldGVkIGFzIGFuIGludGVycnVwdCBtZXNzYWdlDQo+ID4gdGhlbiB3ZSBuZWVkIG1zaSBp
c29sYXRpb24gdG8gcHJvdGVjdC4NCj4gDQo+IHllcy4NCj4gDQo+ID4NCj4gPiBCdXQgZm9yIFNJ
T1YgYWxsIE1lbVdyJ3MgYXJlIHRhZ2dlZCB3aXRoIGEgcGFzaWQgaGVuY2UgY2FuIG5ldmVyDQo+
ID4gdHJpZ2dlciBhbiBpbnRlcnJ1cHQuIEZyb20gdGhpcyBhbmdsZSBsb29rcyB0aGlzIGNoZWNr
IGlzIHVubmVjZXNzYXJ5Lg0KPiANCj4gQnV0IHRoZSBpbnRlcnJ1cHRzIG91dCBmcm9tIGEgU0lP
ViB2aXJ0dWFsIGRldmljZSBkbyBub3QgaGF2ZSBwYXNpZCAoYXQNCj4gbGVhc3QgdG9kYXkpLiBT
ZWVtcyBzdGlsbCBuZWVkIGEgY2hlY2sgaGVyZSBpZiB3ZSBjb25zaWRlciB0aGlzIGJpbmQgZm9y
DQo+IGEgU0lPViB2aXJ0dWFsIGRldmljZSBqdXN0IGxpa2UgYmluZGluZyBhIHBoeXNpY2FsIGRl
dmljZS4NCj4gDQoNCnRoaXMgY2hlY2sgYXNzdW1lcyB0aGUgZGV2aWNlIGlzIHRydXN0ZWQuIGFz
IGxvbmcgYXMgdGhlcmUgaXMgbm8gd2F5DQpmb3IgbWFsaWNpb3VzIGd1ZXN0IHRvIGdlbmVyYXRl
IGFyYml0cmFyeSBpbnRlcnJ1cHQgbWVzc2FnZXMgdGhlbg0KaXQncyBmaW5lLg0KDQpmb3IgcGh5
c2ljYWwgZGV2aWNlIGEgTWVtV3IgY2FuIGJlIGludGVycHJldGVkIGFzIGludGVycnVwdCBzbw0K
d2UgbmVlZCBtc2kgaXNvbGF0aW9uLg0KDQpmb3IgU0lPViBhbGwgTWVtV3IgaGFzIHBhc2lkIHRo
ZW4gd2UgZG9uJ3QgaGF2ZSBzdWNoIHdvcnJ5Lg0KSU1TIGlzIHVuZGVyIGhvc3QncyBjb250cm9s
IHNvIGludGVycnVwdCBtZXNzYWdlcyBhcmUgYWxyZWFkeQ0Kc2FuaXRpemVkLg0K
