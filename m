Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C854570F1B9
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 May 2023 11:04:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240579AbjEXJEK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 24 May 2023 05:04:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240561AbjEXJD6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 24 May 2023 05:03:58 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 157AB18E;
        Wed, 24 May 2023 02:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684919032; x=1716455032;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=zRWYFoZf7ZEbTkRkS8JvQNJyFqvckQuPB6Ev0hnbDf8=;
  b=mCDl/SZOycxzT6arg2wXRlpIf+vCe6hJcblRG681PAJdiHdBaU+wgXKb
   SvSwNITMsmwOiLS3CvIHD9ZUejIJNFS3gbhZw5mWYtIkiI59k9dTw5sPI
   k4arzPFRgDLq/kbHfq0UiLAzH9YaemYahO7Zx/dQn5LFYFTdoJk5Duv1j
   8pcRba6In3DYrClxpayrtncgJt5fCBS2za3hZCad3L/XHjJw2hGJJTouQ
   DehjTMiGxW/Dsl7YD4NHtyzZFm4ay9odF/UX76+aIQFByCQ41vPaY/FcI
   gPCXZcd1qxGkW68rSwXRlpLI657bfkf4yEOUyBQWejxoGz105CxP5gyfo
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10719"; a="439860157"
X-IronPort-AV: E=Sophos;i="6.00,188,1681196400"; 
   d="scan'208";a="439860157"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2023 01:59:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10719"; a="950923951"
X-IronPort-AV: E=Sophos;i="6.00,188,1681196400"; 
   d="scan'208";a="950923951"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga006.fm.intel.com with ESMTP; 24 May 2023 01:59:46 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 24 May 2023 01:59:46 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Wed, 24 May 2023 01:59:46 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.172)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Wed, 24 May 2023 01:59:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MgEFqKVuOem0Udh/qwNKHELhLtKAvniCqt1MRfwEL4ORvyJeFnynuPQy+1Z9+QNuzxmqsy4otqwsqnLhYoyDU/kMgFRrA931Cmj8CAF0NtGBIcOr1/skTzPVQTkhNesnVHksKy92QiHcwufr0zvzlyqh7U8bLSnVk/wlBJAJgBMEFWDB5AOA80+CdfAIwBF9VQH7ahlKTDQg3tWHAaUtYN220uHqRClgVL1lQ5tt3HbM6VAo0iec4wBTzN2ddz7Ufx9b7Cu253HN2fAbKHtI5IB4Dv7Q2I8XR4cPfosZhN0VLe28MMwaYn0BFjxJe8YYL8xCPrJqY+V4+VUQm5rBaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zRWYFoZf7ZEbTkRkS8JvQNJyFqvckQuPB6Ev0hnbDf8=;
 b=jIxJjCULkHTsnHAVxuhxvOf/8YDCzIA+t9M3XAgM7Wd986QZocE8sjccDSGKT5WXGV8qgQvKgsi2HJl5OSyT7UWl3tAERhjtpnmb6Lo4TdVpBn9rMMBA0SpDZfTv+T/wWUGstDKKLlaY+nMlp51HgI3TAPdAx525ldpd54t82zPBRfJ+eMYmoz21F3fIj3MBG555a+/Hno4uUozk3/STlP1+jhycDnFZiLGEKjAvboD4U9vpa3DVFOuK5I4NkZRdAuqke2dLjA3oUMijyi2tsIOYIQCpaf5IZLloMf8yQ79PIC+R6T6Yp5kfZOf07GhzX7zLPPSPG1MKnYElVcl+LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DM4PR11MB6261.namprd11.prod.outlook.com (2603:10b6:8:a8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Wed, 24 May
 2023 08:59:44 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::dd3:4277:e348:9e00]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::dd3:4277:e348:9e00%3]) with mapi id 15.20.6433.015; Wed, 24 May 2023
 08:59:43 +0000
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
        "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
Subject: RE: [PATCH v3 00/10] Add Intel VT-d nested translation
Thread-Topic: [PATCH v3 00/10] Add Intel VT-d nested translation
Thread-Index: AQHZhBgNtWChyqGR00+u6nwW5Oa+KK9pLIFQ
Date:   Wed, 24 May 2023 08:59:43 +0000
Message-ID: <BN9PR11MB52765FA8255FB8F8A1A6F11B8C419@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230511145110.27707-1-yi.l.liu@intel.com>
In-Reply-To: <20230511145110.27707-1-yi.l.liu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|DM4PR11MB6261:EE_
x-ms-office365-filtering-correlation-id: aa8b2cf8-ba04-4596-8494-08db5c353789
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lu1wbTgiimL200fkMjzcHhagdJ8G7pQVZ8f+4rTq8P70Ay/JlF8q9ltBf+5PeAo3/4vh7YoMtlhJIMZLFZjl086s2bNdPzA4NCXcVQnhM+rgYLG2IiYVtaINx9T1ThWHduY6g4PdjFOnq5tFXChZhV/nNqa7WTqVsOSsncblTFzFDDcLAHEexmRsC836VAZbHvyluLv0MKoJFJsN1chT0Zfi++F9GSj01p0pQpwrQHdOR2Tq6lUrFIpteavvFkOWgTlwxanxd0K+sAPJEQSEWj5KaDTQIQ0CFHLr+wPwLvwoRiLMdk8kkYY4Fk+Uu4kYoLwYzlZWa6aWCx4KnCgNnGRf/H7rOUxHGkS+oSv24qDoI6m3ed2MR9Oiv0EYt07blIVhd4S7liqCICaUggWZ1PgVwpLG5CBmrW03QYrpb8P2XEIUk6AXfWG0+UWHZKQMSMN1zJ+MHZ8EEaSidx0DEk1C5WAxeiCO9ziTUjwP+Tt/WCma+nIdnzlTxOOxV05I/b1vKv9lu49GQzOg5K+C6Bwnip3Es2xCU+chrYbbTiSKu2qoPKqj7SLee2rs75XtsSTwNnJp0NoMoi7ikXdX5fcvqDt+0P2H6IAhobo4KJb+1H1UCLp117pLDu5QvGT+
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(366004)(376002)(39860400002)(136003)(346002)(451199021)(122000001)(38100700002)(8676002)(8936002)(5660300002)(38070700005)(7416002)(52536014)(82960400001)(26005)(9686003)(55016003)(186003)(6506007)(2906002)(86362001)(33656002)(4326008)(316002)(76116006)(64756008)(66446008)(66476007)(66946007)(66556008)(71200400001)(54906003)(110136005)(478600001)(41300700001)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eWx4UjNRbEtKNmIxd0g4bjhRdS8rUTI3QzFHYk5Va0oybzVESGo0YTZJaGlW?=
 =?utf-8?B?NWNtK21LR2psVjcrT3pyNHJHc1dYcWJVZUVQUXlQNmVTM0phMStORStJeUhi?=
 =?utf-8?B?bE5iZm1sa3pJbDYxOEdtMWd3Z1p5NzhaL3QwbVduOWRyUmRtTXR6YVJvMVVS?=
 =?utf-8?B?bk5maXFwb1A5YmQxNDBNU3FYWmxXMXVwK2k4SWRLMER5V09BZ3BUc1lZREZh?=
 =?utf-8?B?NFJsalZlZGNTQisxaGRuak1zZy8vMzIvOXJMcms0RmgzNkxkbTBFcENLMUxj?=
 =?utf-8?B?SU9RK1hydEc0SG04RHF2OVVRa1J6bWRvM2E4ekVUamtxaHRXRllKZE9xb2xy?=
 =?utf-8?B?Z0h5VFNxMjBFbnc3NzRwenVrQlJJSjNGd0l3alN2d29iVWxKajJQamFvVGJD?=
 =?utf-8?B?eGYwdHJZWmcvc1NLMGFLYTAyYVBFdDd1WHd2SVZSekZMeW4vT1IrMEJacDVW?=
 =?utf-8?B?Q2N6MmkrNDJvNnRLamlXQXMvTTFoTEJhMElSOG5vMnBTbWxtdm9pSm9CSnhO?=
 =?utf-8?B?eS9wWmk2SUFxd3RCM3NOVU1BVzRRRUFvR040ZHdXUU9JODJsUDJ1b3JKWHBN?=
 =?utf-8?B?eGF5czNHNzRjVXdVZnlRTmlneEJmd01zdkVhV3U0MTdJTGZLb2NHazJoNW5G?=
 =?utf-8?B?Y24wTWV2K0xXc0Y2V012enJVSVBEcWIrcjVIdDBIY1Y3eGhBelBIWnp4aWRF?=
 =?utf-8?B?Q1dGb1p3Z1A5ejFRa0crc2dhVXB1dWEvTkY0NnR4QTZMN1BhaG8xRENWYjFP?=
 =?utf-8?B?azJENmJNNWEzNWtzTXRQc1k2aG1pSUVaQjlSMzNLS0tPZElSaTRsVDZJWERQ?=
 =?utf-8?B?alZIbkdEcnJ0NHZjWGVsempSbUtlMFFteHlFYUY2UzNOV1JYbTliZnlGbzBL?=
 =?utf-8?B?akgzSHRUbUxqeEREVWoydG5KVnRobEhLR3QvZ3dxbDZXMTF6OERDemFUMWFH?=
 =?utf-8?B?TUQzTUYwdEVWTjFIVklRNDF5NVpRM2VxQzlIYWN4OHo3VTlhejJqSGo1MFZt?=
 =?utf-8?B?SDg2MEU2UlBXY2psbEhFTGNCQnpEMkFGa3lwOTRpLzFaTzljZVpEekprSVFv?=
 =?utf-8?B?TEpRWVlxMEIvKzJIeHR2WUZrRWdoZS9tYis2VVR1bVUzcTBvcUErckU3eGUr?=
 =?utf-8?B?a0lIK2hMazNyS3FqdUNvaVloSUQ3NnJENzFZQWZkaElxbjYxYnJtbkZGd2VI?=
 =?utf-8?B?NmxEbHNZQnV0STd5ZXBzMjByVm5ZWWhFNWx1YWpUS0hBcE56VFpQd3NROGlW?=
 =?utf-8?B?Zis4VjU5STVNTEhvcis0eGwvb3Nqcm54RGVsQ29FUVF0bXowWWtKemdiZFM0?=
 =?utf-8?B?VTNveGV0VDJYNjg0TFo5OW5ObURBUkJoWnkrTnBVbGRqOUFrMHh0VjBhZ01V?=
 =?utf-8?B?WGdrbGIvMnJPcnJJSzRwZnpsNzl6RGRlT2MzbVlOdjc4eUhlMHR2S3lVNlNt?=
 =?utf-8?B?MzljRldBVlNGM3Y4eDhqd2VvcjBHUllaWHppQkI3VkJvTkc4U0hGRzQ1NlA0?=
 =?utf-8?B?am8rbDl6WjZUczJTcmlCb2R2bC9OQlFjMXpRVGtEeHdYTGNVbjdsRVNvSENt?=
 =?utf-8?B?TytLNkJvZXlEdVNCbXZHR3ZVUTI0U0RRbFhYblJ1Y2ZmOWVRTEVLQ3pzMThX?=
 =?utf-8?B?UXhzYUVTa0tUWERKVStSMW1ieGFaMDluK3d2SXJES3FqWVYwTE9QdWRiMDJ5?=
 =?utf-8?B?dHhwTmFPcTBaUkpkOGJIYlpNY1dIV1ZjTWxpMCtOc2Q2YXIwYUhJUU1aQlRy?=
 =?utf-8?B?eURqMytuVUNKR3ltbG12a1RqVHluZGJja0dkNTl3UHh0aXVzMzY2Y25wT2pB?=
 =?utf-8?B?VXVsOStsWkszdlNxZEJpeVBXQkdRR2tuemlMbWhJV0hWSXF5aVlWWTRuWHNK?=
 =?utf-8?B?alQySjFLOVdJSzBIb2dzbEQ0aXo3R0xNVXZJWnFZNEowZ2RiKzFzY0FnRVNU?=
 =?utf-8?B?YzZRSkJBbEJSSElLTE5Na2N5T0NvMEJUTkRmM2M5T083ZEpMQzhKL0FNN0dU?=
 =?utf-8?B?UEh3V0tQS09LaTZxaFlrRkY2SzNac2dIMzdPOElmOTUrLzB5MmJna2xaM3E1?=
 =?utf-8?B?TFE4VlBjRmMrU2EzVmlpWnYxSDB6OE9VT3puR2NmL0xOZlhXRDBRY3Zaamli?=
 =?utf-8?Q?SeZwrNhy3NXYN0o2odpyLy+4F?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa8b2cf8-ba04-4596-8494-08db5c353789
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2023 08:59:43.7218
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DN3V3xOxYWe/En5nD58tODh/KwbPeuv/V1f8vUOlXm1WHmwZ0mfJJHGBpmelZiKLXnvQTv3XFNUPK1FokSFAsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6261
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

PiBGcm9tOiBMaXUsIFlpIEwgPHlpLmwubGl1QGludGVsLmNvbT4NCj4gU2VudDogVGh1cnNkYXks
IE1heSAxMSwgMjAyMyAxMDo1MSBQTQ0KPiANCj4gVGhlIGZpcnN0IEludGVsIHBsYXRmb3JtIHN1
cHBvcnRpbmcgbmVzdGVkIHRyYW5zbGF0aW9uIGlzIFNhcHBoaXJlDQo+IFJhcGlkcyB3aGljaCwg
dW5mb3J0dW5hdGVseSwgaGFzIGEgaGFyZHdhcmUgZXJyYXRhIFsyXSByZXF1aXJpbmcgc3BlY2lh
bA0KPiB0cmVhdG1lbnQuIFRoaXMgZXJyYXRhIGhhcHBlbnMgd2hlbiBhIHN0YWdlLTEgcGFnZSB0
YWJsZSBwYWdlIChlaXRoZXINCj4gbGV2ZWwpIGlzIGxvY2F0ZWQgaW4gYSBzdGFnZS0yIHJlYWQt
b25seSByZWdpb24uIEluIHRoYXQgY2FzZSB0aGUgSU9NTVUNCj4gaGFyZHdhcmUgbWF5IGlnbm9y
ZSB0aGUgc3RhZ2UtMiBSTyBwZXJtaXNzaW9uIGFuZCBzdGlsbCBzZXQgdGhlIEEvRCBiaXQNCj4g
aW4gc3RhZ2UtMSBwYWdlIHRhYmxlIGVudHJpZXMgZHVyaW5nIHBhZ2UgdGFibGUgd2Fsa2luZy4N
Cj4gDQo+IEEgZmxhZyBJT01NVV9IV19JTkZPX1ZURF9FUlJBVEFfNzcyNDE1X1NQUjE3IGlzIGlu
dHJvZHVjZWQgdG8NCj4gcmVwb3J0DQo+IHRoaXMgZXJyYXRhIHRvIHVzZXJzcGFjZS4gV2l0aCB0
aGF0IHJlc3RyaWN0aW9uIHRoZSB1c2VyIHNob3VsZCBlaXRoZXINCj4gZGlzYWJsZSBuZXN0ZWQg
dHJhbnNsYXRpb24gdG8gZmF2b3IgUk8gc3RhZ2UtMiBtYXBwaW5ncyBvciBlbnN1cmUgbm8NCj4g
Uk8gc3RhZ2UtMiBtYXBwaW5nIHRvIGVuYWJsZSBuZXN0ZWQgdHJhbnNsYXRpb24uDQo+IA0KPiBJ
bnRlbC1pb21tdSBkcml2ZXIgaXMgYXJtZWQgd2l0aCBuZWNlc3NhcnkgY2hlY2tzIHRvIHByZXZl
bnQgc3VjaCBtaXgNCj4gaW4gcGF0Y2gxMCBvZiB0aGlzIHNlcmllcy4NCj4gDQo+IFFlbXUgY3Vy
cmVudGx5IGRvZXMgYWRkIFJPIG1hcHBpbmdzIHRob3VnaC4gVGhlIHZmaW8gYWdlbnQgaW4gUWVt
dQ0KPiBzaW1wbHkgbWFwcyBhbGwgdmFsaWQgcmVnaW9ucyBpbiB0aGUgR1BBIGFkZHJlc3Mgc3Bh
Y2Ugd2hpY2ggY2VydGFpbmx5DQo+IGluY2x1ZGVzIFJPIHJlZ2lvbnMgZS5nLiB2Ymlvcy4NCj4g
DQo+IEluIHJlYWxpdHkgd2UgZG9uJ3Qga25vdyBhIHVzYWdlIHJlbHlpbmcgb24gRE1BIHJlYWRz
IGZyb20gdGhlIEJJT1MNCj4gcmVnaW9uLiBIZW5jZSBmaW5kaW5nIGEgd2F5IHRvIGFsbG93IHVz
ZXIgb3B0LW91dCBSTyBtYXBwaW5ncyBpbg0KPiBRZW11IG1pZ2h0IGJlIGFuIGFjY2VwdGFibGUg
dHJhZGVvZmYuIEJ1dCBob3cgdG8gYWNoaWV2ZSBpdCBjbGVhbmx5DQo+IG5lZWRzIG1vcmUgZGlz
Y3Vzc2lvbiBpbiBRZW11IGNvbW11bml0eS4gRm9yIG5vdyB3ZSBqdXN0IGhhY2tlZCBRZW11DQo+
IHRvIHRlc3QuDQo+IA0KDQpIaSwgQWxleCwNCg0KV2FudCB0byB0b3VjaCBiYXNlIG9uIHlvdXIg
dGhvdWdodHMgYWJvdXQgdGhpcyBlcnJhdGEgYmVmb3JlIHdlDQphY3R1YWxseSBnbyB0byBkaXNj
dXNzIGhvdyB0byBoYW5kbGUgaXQgaW4gUWVtdS4NCg0KT3ZlcmFsbCBpdCBhZmZlY3RzIGFsbCBT
YXBwaGlyZSBSYXBpZHMgcGxhdGZvcm1zLiBGdWxseSBkaXNhYmxpbmcgbmVzdGVkDQp0cmFuc2xh
dGlvbiBpbiB0aGUga2VybmVsIGp1c3QgZm9yIHRoaXMgcmFyZSB2dWxuZXJhYmlsaXR5IHNvdW5k
cyBhbiBvdmVya2lsbC4NCg0KU28gd2UgZGVjaWRlIHRvIGVuZm9yY2UgdGhlIGV4Y2x1c2l2ZSBj
aGVjayAoUk8gaW4gc3RhZ2UtMiB2cy4gbmVzdGluZykNCmluIHRoZSBrZXJuZWwgYW5kIGV4cG9z
ZSB0aGUgcmVzdHJpY3Rpb24gdG8gdXNlcnNwYWNlIHNvIHRoZSBWTU0gY2FuDQpjaG9vc2Ugd2hp
Y2ggb25lIHRvIGVuYWJsZSBiYXNlZCBvbiBpdHMgb3duIHJlcXVpcmVtZW50Lg0KDQpBdCBsZWFz
dCB0aGlzIGxvb2tzIGEgcmVhc29uYWJsZSB0cmFkZW9mZiB0byBzb21lIHByb3ByaWV0YXJ5IFZN
TXMNCndoaWNoIG5ldmVyIGFkZHMgUk8gbWFwcGluZ3MgaW4gc3RhZ2UtMiB0b2RheS4NCg0KQnV0
IHdlIGRvIHdhbnQgdG8gZ2V0IFFlbXUgc3VwcG9ydCBuZXN0ZWQgdHJhbnNsYXRpb24gb24gdGhv
c2UNCnBsYXRmb3JtIGFzIHRoZSB3aWRlbHktdXNlZCByZWZlcmVuY2UgVk1NIQ0KDQpEbyB5b3Ug
c2VlIGFueSBtYWpvciBvdmVyc2lnaHQgYmVmb3JlIHB1cnN1aW5nIHN1Y2ggY2hhbmdlIGluIFFl
bXUNCmUuZy4gaGF2aW5nIGEgd2F5IGZvciB0aGUgdXNlciB0byBvcHQtb3V0IGFkZGluZyBSTyBt
YXBwaW5ncyBpbiBzdGFnZS0yPyDwn5iKDQoNClRoYW5rcw0KS2V2aW4gDQo=
