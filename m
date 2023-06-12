Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9D9B72C4E7
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Jun 2023 14:50:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbjFLMuS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 12 Jun 2023 08:50:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230467AbjFLMuR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 12 Jun 2023 08:50:17 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96F53E4C;
        Mon, 12 Jun 2023 05:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686574208; x=1718110208;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=m9BG6EW4Pkgc+pRg/5q6/TKbtFBWmjv+fWZcSPec5rI=;
  b=DZxMVQIcSLX2JS/0eYbR/iK/yl3z3UXY9QG1Qm8G9H1s8ixS0wgnt9RY
   FeBUJOXpNLZurFKWtU0OjU7dBnf4LUgi1xSrEOv7ih8GDQRCiqPGQQAtS
   UPdT0bvl4shYoxiT3T/5RVHByOf56FEpMqtCI5s5Zfq2Ez3Tdallppvkk
   inRo9FKdmqmT8TTDp9GAmL7LBBrLSPg/eEhs2MPTEPdFp2XUrXmZNZMCl
   WXPBPD272P9hlFIz129Ry9ddoBPYMvvTME/ATZP4yP3gWUrb9CDQnAs3i
   kQIDppFzYmxYirZmmLHUT/nBhxhag5DU6+mU54h+2TK52B2vg9rsTql3a
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="386411933"
X-IronPort-AV: E=Sophos;i="6.00,236,1681196400"; 
   d="scan'208";a="386411933"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2023 05:50:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="801011022"
X-IronPort-AV: E=Sophos;i="6.00,236,1681196400"; 
   d="scan'208";a="801011022"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by FMSMGA003.fm.intel.com with ESMTP; 12 Jun 2023 05:50:06 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 12 Jun 2023 05:50:06 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Mon, 12 Jun 2023 05:50:06 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.105)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Mon, 12 Jun 2023 05:50:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XP8aPkBRZVErKJ46mkPb2qNe+PMsP3lCak1ZR7utPMdNx3ycYX90qCvtWvL/UlfkyskeO3ZsJmL09aefbj4palU5iRfGiNQVnuKp+eZI6fkyRXr1OrFtkTvHiSInnyXLt6dLH87MsXPI0iPVo1p0/nmVHOrQ/CBWUGuKXWP6n8aOKY2HIUcdQ92DBpmk59JWZxTtftWtYlSrL6e/fXgWFxkX6pfF6QlaIOWMvgSrO6IsKxhaOzW1UZLFpvRqliVXpbbd1mJDgDlmwd9eqFl+p0zJCYp4GYzohT6WwPO38Jy9yRjicmmRupKwS7yGVXeIzKM6aUjBHa9IZz75/bmW3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m9BG6EW4Pkgc+pRg/5q6/TKbtFBWmjv+fWZcSPec5rI=;
 b=P8xB2Dr3EbEx4Q0WzZFg82XTQc+Y382f5Ur1w+krgSCuWACKhXR2cZUxogAFYketALJDs3/8+7kJhIDSlY27S6rWn3muhEenb21t8PeDf+1iVyE4OoG6P078ST/5MzFBYjzea8F05yVQzT/ytxynkHTldxdrJER+/mNH23b87NrFplRmtseIn5XY4ISV+KKBpwA+CQNzPNtI9zvcALCNFa77nxDnqRZC4Eb4f+vx3raAIsOL4JGoFd/iYNmiCN4F//bq+BZgRzcxdPTMRxvau7taYPF64pWfJoeW/JwocbwWXjRkGB80z+WkkPx7h5PQqa84cFu8UOlKGVmL8ZaRlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by PH0PR11MB4951.namprd11.prod.outlook.com (2603:10b6:510:43::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.29; Mon, 12 Jun
 2023 12:50:03 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::19b7:466f:32ac:b764]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::19b7:466f:32ac:b764%3]) with mapi id 15.20.6455.043; Mon, 12 Jun 2023
 12:50:03 +0000
From:   "Huang, Kai" <kai.huang@intel.com>
To:     "corbet@lwn.net" <corbet@lwn.net>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "x86@kernel.org" <x86@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>
CC:     "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "Yu, Guorui" <guorui.yu@linux.alibaba.com>,
        "qinkun@apache.org" <qinkun@apache.org>,
        "wander@redhat.com" <wander@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "chongc@google.com" <chongc@google.com>,
        "Aktas, Erdem" <erdemaktas@google.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        "dionnaglaze@google.com" <dionnaglaze@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "Du, Fan" <fan.du@intel.com>
Subject: Re: [PATCH v3 2/3] virt: tdx-guest: Add Quote generation support
Thread-Topic: [PATCH v3 2/3] virt: tdx-guest: Add Quote generation support
Thread-Index: AQHZhjUlMubrgQftj06dVPs0zcs/Ma+HTGKA
Date:   Mon, 12 Jun 2023 12:50:03 +0000
Message-ID: <e99330db8d37b179a69f3ea85bda06eb09338cee.camel@intel.com>
References: <cover.1684048511.git.sathyanarayanan.kuppuswamy@linux.intel.com>
         <3c1716d095cfca1903a1ebe9d1541d19b62e480e.1684048511.git.sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <3c1716d095cfca1903a1ebe9d1541d19b62e480e.1684048511.git.sathyanarayanan.kuppuswamy@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.2 (3.48.2-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|PH0PR11MB4951:EE_
x-ms-office365-filtering-correlation-id: 9660d20a-c03e-4b2f-f92c-08db6b438abd
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xE0gALyNT6JA5LkPkA64sGau2XS8RxbHiFEbT+UuwSGBv7bDXo0c2IFNH8kRAPq6/c91p/5bDAS7qnOditqlC/QO2VkokN9RATKovgl/cPACbVOA/ZbHsn2oKD/eato3pOXzCVJESkP/2YViPB+yP5eysd/EhBL87FN2nufdufHWjYTX0CEb2jLaUwP4lR4gO3qaJ/SgZVtIrrM7b5gEgfLJ1GLqGOHf1omoRb6Vb1s49G/+kF27YYejrg2W4feAYHLpAdOgK+evcAkIg8xixEbLRjCE1Q3vslICC1Sc+bYn4rGMshWgkmi2euPCCWn92CjZU/EL35nJsCCyYMHQyw3ICxM0FCoqbOUdl3XlnobqgbB66l098JKYw/MwghMdNe9/QGak/CCydrIxErfCs0kNR1fn+rxQ2LPb/BWNzF4eXBYNw2wtHyEbs5KMJLPKwE3AJvCLd75sa71lJsS6pHcdhSUakxRzV9SgeiKibeqtwYBsza2GsWrhOGTKHsQ0PlxQq+GBazd53dr2x8RFXoDcxyCIWpk8ULGHQjA9OfJgJWeg7YaEOe2RvjzxO90C6kQrABvUYnEp5AsR/WD63btBF75PtHdtlknQULJy5ZNCZuTDU3so1wDyP+1tRrxe
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(376002)(39860400002)(136003)(366004)(396003)(451199021)(4326008)(91956017)(64756008)(66476007)(66556008)(316002)(7416002)(66446008)(41300700001)(76116006)(186003)(110136005)(2906002)(54906003)(478600001)(66946007)(8676002)(8936002)(5660300002)(71200400001)(6486002)(6512007)(6506007)(122000001)(26005)(83380400001)(36756003)(38070700005)(86362001)(82960400001)(2616005)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MXRYTFptbzhWNjgzcnU2S25oVXNwVlBDRzYrc3NFZEczN1NmVUpuUUFlQmI3?=
 =?utf-8?B?TkFrWUN0T2RONWhRQ2tIbXNUVm5uNXBQTWFuby8yOUNIaExZU3dVeVh4b0lO?=
 =?utf-8?B?ZWl2Y0o5MVBEQWc4bDgxaTUwWkdkWXRiV2cveGhLclczRFRnbXQxVzBjNlFF?=
 =?utf-8?B?MFNUYm1XZm92NXdveFF4UXBWS0UySnVld0w0MVNRZmVueWpzUUhrN21mUlRv?=
 =?utf-8?B?bC9PVnFKR29kR29FU0lJbDIvS1ZvWEsybEFBN0NKbk13enZVL1V2aWovd0Ra?=
 =?utf-8?B?T0ZMeDZhcFZ0Zk0rUld6ZGg3K21SOEdMZzVkcnFZV25mMTlmcW44bG5pNVNW?=
 =?utf-8?B?dlhCSEZkN2Z5clliRDl4YUNwZWlBTHZlOUg5M0I0V3p5Tm0xWW5tUlA1RjBW?=
 =?utf-8?B?L3pkR1psbm1vQjJMcEV0VGt1bDk0Z2hoTWl4WEpwZ3o1a3pZTDBBM3ZHWHVG?=
 =?utf-8?B?Wmp4a280TFVhaDlEOWhWcUxnZFY2UUtvazZLdmhPY29JTHRJY1gxd1JXbDAr?=
 =?utf-8?B?Ky9jRXRLTXF3N0dPQVFUOEV0QTZYSFgwbFBMLzdrY2RibHpqRXhCY055MmQv?=
 =?utf-8?B?UURIRWE5Y0U0cDYzZG9wMUN6ZFoyTVhHVTJwaDFFWXcrN2xCdXZWWENyWUpp?=
 =?utf-8?B?TEpXQ1dKcERiWkVGVFl0WkE2YjQxQ2pFeDN3TDR4UE1ybGcrVDhJN2pieTBV?=
 =?utf-8?B?MVppbkVWL0xyWWVjcFhCSm5IT1Z0RkhOelBraC9oaGVLTWRHckVONktsMG91?=
 =?utf-8?B?cVhWZTZrcmFaS2ROa1M2Tzg1bTV3Ukc2MWM3T1IvdFJ2WWpQY0V5TUo3bWdW?=
 =?utf-8?B?SDY1MWRENHMrWjVjQXVWdzBBb1hpdElUNnF4WlByTzdxbzZYaXBZSENMYUFh?=
 =?utf-8?B?eFFwR21WeGpYeHpjV25weUlvY3BrckorT2dJYjJZU2dWR3l1bytxVWlzekVq?=
 =?utf-8?B?NlVqZ05zVDM2WEROTlRiVGtFWGhBQS9Xek00SUJBRW5aaVRROWJTWWVja2Vm?=
 =?utf-8?B?QnBNMEUvUTM5UWlLUEplTXA0WE9LUCtqeTgwUkZEbEJHVFJWTWN5MlY2ck1R?=
 =?utf-8?B?QXBnbHllUmMvV2tnWjNJRndNV25wNUxQUHV4L2Q3aVRnQkpubkJVUWU3UDJU?=
 =?utf-8?B?YktJLzZ0RlRiRElYWnNRdHd0U2JyQVN4d0pibVlwV0g2ckgrcWJQbGJpZnhQ?=
 =?utf-8?B?S3BJZ1RlQytRK0U3OVVWQmJYMDZYeHgxY3NaMENFNG1QenNqTTl0anlSNGp1?=
 =?utf-8?B?a2NEeitPU1ZUZVdkbXRKK0JFbWFGVHNCWmxaZGRTZUhWK3FlVTNHSjZqdU9a?=
 =?utf-8?B?V1lqYmJ5UVFvMENYcjVmVnpnV3VZSXFJWHRjZFhrMjcrcnE1Rnh0dmdoSDVT?=
 =?utf-8?B?a0xDSmI5SU5pTEhQOE5HdFpqSTUrUUdPMnpMSm5rbW13L2FETmdncDBxS3RB?=
 =?utf-8?B?VElhZ1JhMjdqZEZNMm1xU1cvam1nTUk5R2l3SndJa0JiL1g2OCtjU0tsc3R6?=
 =?utf-8?B?OUdoY0JXSWgvRFM1REI4R296a1ZWQzBCNGxMQk1MQVdIb0N1UUFjNmxkR1Rh?=
 =?utf-8?B?SVBSWjNhdEpiMWFXaEQwdW5EbHV2T3hvTkhRbUtPcG1MYUVEbWEySzE5aVhB?=
 =?utf-8?B?SldEQ2lLODlWQUh1UUxZTUdRUjFOVUg3UytyUlk5WUVndEpLd1VWSGI3NXVy?=
 =?utf-8?B?U2tockI2TEU4QkZnQzlsUWdDcEpiVG9SUmZlY25GMENmQ1BwVWpXajNPVDlI?=
 =?utf-8?B?N1JNb2JMKzZyYkU0aFRNUUFGeUpXcHNBTmF5TzlFT3RGOUNaKzMzaXB3SFdO?=
 =?utf-8?B?SVIrU0pKSzhXSjBkTVoxdnUrSk92WmZ0MFVGL2Y4L29EcGVTcWUwbGY1KzlD?=
 =?utf-8?B?alJ0WjcvSG5xSkRXZ0ZNQ0F6R1pEUHBnWVZTSzZKUkhhaHdXU2x1cndUM0Rx?=
 =?utf-8?B?dVJsTUhPNnFIdXVEUTYwbUFFenY3bWFxQUF5K3NnOEtXUi9HTzlSMGZYNDFE?=
 =?utf-8?B?S2U5RVVLVDN2U2EvbHIzb00zbTI5dFc2TWJxcGIvaFNUNVlFdzlLL0RBZFVC?=
 =?utf-8?B?K09CaXoyK3IrMjBUcmt1VkdkbmM3WlQ4QnQ0L2tuYmh1aVMxYWRveTRtaXRu?=
 =?utf-8?B?NlJtY0YxMzNMTDh5MG5BcnNVaUsybHBlYmZMQWVhWSs1NEh0L3BkUk1wK1FX?=
 =?utf-8?B?Y1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0668DEFE4528E443A0D31609831EC93F@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9660d20a-c03e-4b2f-f92c-08db6b438abd
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jun 2023 12:50:03.7633
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mdZUfmRYPsjllRsfExtHVfWxFns3iuY9z3OOWIocOrZB9hG9+LRx4FayVHIt5ghyKZrk7O5tDk0sa++RhrQd4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4951
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

T24gU3VuLCAyMDIzLTA1LTE0IGF0IDAwOjIzIC0wNzAwLCBLdXBwdXN3YW15IFNhdGh5YW5hcmF5
YW5hbiB3cm90ZToNCj4gSW4gVERYIGd1ZXN0LCB0aGUgYXR0ZXN0YXRpb24gcHJvY2VzcyBpcyB1
c2VkIHRvIHZlcmlmeSB0aGUgVERYIGd1ZXN0DQo+IHRydXN0d29ydGhpbmVzcyB0byBvdGhlciBl
bnRpdGllcyBiZWZvcmUgcHJvdmlzaW9uaW5nIHNlY3JldHMgdG8gdGhlDQo+IGd1ZXN0LiBUaGUg
Rmlyc3Qgc3RlcCBpbiB0aGUgYXR0ZXN0YXRpb24gcHJvY2VzcyBpcyBURFJFUE9SVA0KPiBnZW5l
cmF0aW9uLCB3aGljaCBpbnZvbHZlcyBnZXR0aW5nIHRoZSBndWVzdCBtZWFzdXJlbWVudCBkYXRh
IGluIHRoZQ0KPiBmb3JtYXQgb2YgVERSRVBPUlQsIHdoaWNoIGlzIGZ1cnRoZXIgdXNlZCB0byB2
YWxpZGF0ZSB0aGUgYXV0aGVudGljaXR5DQo+IG9mIHRoZSBURFggZ3Vlc3QuIFREUkVQT1JUIGJ5
IGRlc2lnbiBpcyBpbnRlZ3JpdHktcHJvdGVjdGVkIGFuZCBjYW4NCj4gb25seSBiZSB2ZXJpZmll
ZCBvbiB0aGUgbG9jYWwgbWFjaGluZS4NCj4gDQo+IFRvIHN1cHBvcnQgcmVtb3RlIHZlcmlmaWNh
dGlvbiBvZiB0aGUgVERSRVBPUlQgKGluIGEgU0dYLWJhc2VkDQo+IGF0dGVzdGF0aW9uKSwgdGhl
IFREUkVQT1JUIG5lZWRzIHRvIGJlIHNlbnQgdG8gdGhlIFNHWCBRdW90aW5nIEVuY2xhdmUNCj4g
KFFFKSB0byBjb252ZXJ0IGl0IHRvIGEgcmVtb3RlIHZlcmlmaWFibGUgUXVvdGUuIFNHWCBRRSBi
eSBkZXNpZ24gY2FuDQo+IG9ubHkgcnVuIG91dHNpZGUgb2YgdGhlIFREWCBndWVzdCAoaS5lLiBp
biBhIGhvc3QgcHJvY2VzcyBvciBpbiBhDQo+IG5vcm1hbCBWTSkgYW5kIGd1ZXN0IGNhbiB1c2Ug
Y29tbXVuaWNhdGlvbiBjaGFubmVscyBsaWtlIHZzb2NrIG9yDQo+IFRDUC9JUCB0byBzZW5kIHRo
ZSBURFJFUE9SVCB0byB0aGUgUUUuIEJ1dCBmb3Igc2VjdXJpdHkgY29uY2VybnMsIHRoZQ0KPiBU
RFggZ3Vlc3QgbWF5IG5vdCBzdXBwb3J0IHRoZXNlIGNvbW11bmljYXRpb24gY2hhbm5lbHMuIFRv
IGhhbmRsZSBzdWNoDQo+IGNhc2VzLCBURFggZGVmaW5lcyBhIEdldFF1b3RlIGh5cGVyY2FsbCB3
aGljaCBjYW4gYmUgdXNlZCBieSB0aGUgZ3Vlc3QNCj4gdG8gcmVxdWVzdCB0aGUgaG9zdCBWTU0g
dG8gY29tbXVuaWNhdGUgd2l0aCB0aGUgU0dYIFFFLiBNb3JlIGRldGFpbHMNCj4gYWJvdXQgR2V0
UXVvdGUgaHlwZXJjYWxsIGNhbiBiZSBmb3VuZCBpbiBURFggR3Vlc3QtSG9zdCBDb21tdW5pY2F0
aW9uDQo+IEludGVyZmFjZSAoR0hDSSkgZm9yIEludGVsIFREWCAxLjAsIHNlY3Rpb24gdGl0bGVk
DQo+ICJUREcuVlAuVk1DQUxMPEdldFF1b3RlPiIuDQo+IA0KPiBBZGQgc3VwcG9ydCBmb3IgVERY
X0NNRF9HRVRfUVVPVEUgSU9DVEwgdG8gYWxsb3cgYW4gYXR0ZXN0YXRpb24gYWdlbnQNCj4gdG8g
c3VibWl0IEdldFF1b3RlIHJlcXVlc3RzIGZyb20gdGhlIHVzZXIgc3BhY2UgdXNpbmcgR2V0UXVv
dGUNCj4gaHlwZXJjYWxsLg0KPiANCj4gU2luY2UgR2V0UXVvdGUgaXMgYW4gYXN5bmNocm9ub3Vz
IHJlcXVlc3QgaHlwZXJjYWxsLCBWTU0gd2lsbCB1c2UgdGhlDQo+IGNhbGxiYWNrIGludGVycnVw
dCB2ZWN0b3IgY29uZmlndXJlZCBieSB0aGUgU2V0dXBFdmVudE5vdGlmeUludGVycnVwdA0KPiBo
eXBlcmNhbGwgdG8gbm90aWZ5IHRoZSBndWVzdCBhYm91dCBRdW90ZSBnZW5lcmF0aW9uIGNvbXBs
ZXRpb24gb3INCj4gZmFpbHVyZS4gU28gcmVnaXN0ZXIgYW4gSVJRIGhhbmRsZXIgZm9yIGl0Lg0K
PiANCj4gR2V0UXVvdGUgVERWTUNBTEwgcmVxdWlyZXMgVEQgZ3Vlc3QgcGFzcyBhIDRLIGFsaWdu
ZWQgc2hhcmVkIGJ1ZmZlcg0KPiB3aXRoIFREUkVQT1JUIGRhdGEgYXMgaW5wdXQsIHdoaWNoIGlz
IGZ1cnRoZXIgdXNlZCBieSB0aGUgVk1NIHRvIGNvcHkNCj4gdGhlIFREIFF1b3RlIHJlc3VsdCBh
ZnRlciBzdWNjZXNzZnVsIFF1b3RlIGdlbmVyYXRpb24uIFRvIGNyZWF0ZSB0aGUNCj4gc2hhcmVk
IGJ1ZmZlciwgYWxsb2NhdGUgYSBsYXJnZSBlbm91Z2ggbWVtb3J5IGFuZCBtYXJrIGl0IHNoYXJl
ZCB1c2luZw0KPiBzZXRfbWVtb3J5X2RlY3J5cHRlZCgpIGluIHRkeF9ndWVzdF9pbml0KCkuIFRo
aXMgYnVmZmVyIHdpbGwgYmUgcmUtdXNlZA0KPiBmb3IgR2V0UXVvdGUgcmVxdWVzdHMgaW4gVERY
X0NNRF9HRVRfUVVPVEUgSU9DVEwgaGFuZGxlci4NCj4gDQo+IEFsdGhvdWdoIHRoaXMgbWV0aG9k
IHJlc2VydmVzIGEgZml4ZWQgY2h1bmsgb2YgbWVtb3J5IGZvciBHZXRRdW90ZQ0KPiByZXF1ZXN0
cywgc3VjaCBvbmUtdGltZSBhbGxvY2F0aW9uIGlzIHByZWZlcmFibGUgdG8gdGhlIGFsdGVybmF0
aXZlDQo+IGNob2ljZSBvZiByZXBlYXRlZGx5IGFsbG9jYXRpbmcvZnJlZWluZyB0aGUgc2hhcmVk
IGJ1ZmZlciBpbiB0aGUNCj4gVERYX0NNRF9HRVRfUVVPVEUgSU9DVEwgaGFuZGxlciwgd2hpY2gg
d2lsbCBkYW1hZ2UgdGhlIGRpcmVjdCBtYXANCj4gKGJlY2F1c2UgdGhlIHNoYXJpbmcvdW5zaGFy
aW5nIHByb2Nlc3MgbW9kaWZpZXMgdGhlIGRpcmVjdCBtYXApLiBUaGlzDQo+IGFsbG9jYXRpb24g
bW9kZWwgaXMgc2ltaWxhciB0byB0aGF0IHVzZWQgYnkgdGhlIEFNRCBTRVYgZ3Vlc3QgZHJpdmVy
Lg0KPiANCj4gU2luY2UgdGhlIFF1b3RlIGdlbmVyYXRpb24gcHJvY2VzcyBpcyBub3QgdGltZS1j
cml0aWNhbCBvciBmcmVxdWVudGx5DQo+IHVzZWQsIHRoZSBjdXJyZW50IHZlcnNpb24gZG9lcyBu
b3Qgc3VwcG9ydCBwYXJhbGxlbCBHZXRRdW90ZSByZXF1ZXN0cy4NCj4gDQo+IFJldmlld2VkLWJ5
OiBUb255IEx1Y2sgPHRvbnkubHVja0BpbnRlbC5jb20+DQo+IFJldmlld2VkLWJ5OiBBbmRpIEts
ZWVuIDxha0BsaW51eC5pbnRlbC5jb20+DQo+IFJldmlld2VkLWJ5OiBNaWthIFdlc3RlcmJlcmcg
PG1pa2Eud2VzdGVyYmVyZ0BsaW51eC5pbnRlbC5jb20+DQo+IFJldmlld2VkLWJ5OiBFcmRlbSBB
a3RhcyA8ZXJkZW1ha3Rhc0Bnb29nbGUuY29tPg0KPiBBY2tlZC1ieTogS2lyaWxsIEEuIFNodXRl
bW92IDxraXJpbGwuc2h1dGVtb3ZAbGludXguaW50ZWwuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBL
dXBwdXN3YW15IFNhdGh5YW5hcmF5YW5hbiA8c2F0aHlhbmFyYXlhbmFuLmt1cHB1c3dhbXlAbGlu
dXguaW50ZWwuY29tPg0KPiANCg0KQWNrZWQtYnk6IEthaSBIdWFuZyA8a2FpLmh1YW5nQGludGVs
LmNvbT4NCg==
