Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E57EC7275CE
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Jun 2023 05:36:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234121AbjFHDgT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 7 Jun 2023 23:36:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234078AbjFHDgG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 7 Jun 2023 23:36:06 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D3942D53;
        Wed,  7 Jun 2023 20:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686195354; x=1717731354;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=JavdvjgwAVGJ+mnNjUEb76E+CwiNhI8HEaCaF5dnUeA=;
  b=iBJa25YTn2jPW+KW+q5WpBpQ9q7YvXqbJe8rI92aji3o5ti/oPggH3xt
   ECiRWF1eNsIrxiyHXWbSBMFDYt4L1N3k2XHZOjwn6O4ptbQ/yVGCuWmjT
   tXUB75M3xP8pzFXpmUCZa008GvaVtUBitWM9EXa4KOookcE0mdTJ0uQYT
   sfl3i7eebdCY/R96USbjy73MfLuGezk/ltL5kj1r0tknxJbhJdTxPH6Jk
   lqixT5OUtXUZJ7Xo5pBfxpmuPk7wJBBQaoW7txWVHF8akH9mkkdfUZ3qL
   pmDIF0DWmr25Rksj8L1F1kuXkL8YGSe6F7GmYICnvmiMvXrWlhfEvpJKd
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10734"; a="443552471"
X-IronPort-AV: E=Sophos;i="6.00,226,1681196400"; 
   d="scan'208";a="443552471"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2023 20:35:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10734"; a="703918620"
X-IronPort-AV: E=Sophos;i="6.00,226,1681196400"; 
   d="scan'208";a="703918620"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga007.jf.intel.com with ESMTP; 07 Jun 2023 20:35:53 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 7 Jun 2023 20:35:53 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 7 Jun 2023 20:35:52 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Wed, 7 Jun 2023 20:35:52 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.47) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Wed, 7 Jun 2023 20:35:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KIwrb5nh6pjD4IoqGPN5cCaZc4CNVeb4hbjSUFC/3y+xWn2OPJn6fJxXkzHxNcr1wPZR8kpUfUZzHjnYvPc65MNYzgE0ekKE6JFQRlTawBLWPedJdQ6Q6WZIvGHM0ABzrqYW04heYum7BZO3K+mdcFjNIu8M6W4nk/0eDM1iAUy20LzHvhUMRyllw++mYvm/URo+BxuoTAJbqJ3Qw76fl2bKRLeGaK4d8VT41HayVkanyR5W0WfkbAun9B0T5/ViGJEIxcqtZaeBt+xrtcI3HR5LacR1R9RsZsyD7Mj7QfLDFx2h+d0QRcAY4LO6YqOI1+OcywRkQCEGmI1aQnbNyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JavdvjgwAVGJ+mnNjUEb76E+CwiNhI8HEaCaF5dnUeA=;
 b=OWqUicMnN3XLYaObn1ZKq2BfGKMElsyNdgUnoP8Dj/yO+9dho9Aj1NxbqgdqSdcOOEqX84GD5bG8uXv8msSN3jFdIETq0cNSZleu200s/+5hDnCCOTCwYE8z27jpTRbLcf2lod2ybcFp2e/sTDVrCn0C7mo/dZgvi7zSyyp1KIfItxw8cWThaSHmfqYDYxaKcmEEM4M5QSpwckCihBj7uZRvmjjHQ9ZaMLRAvE+EoVYYxpjEIKLWQ2BbbJpI5LlkzYy5zMGw3qQfOU4S8e4bwooOVcmWAe+tjSU8EaYDAv96T/PCedG+ZPLO5xp3TyU6HAPROF1hpgz5dQSoTnbJ/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by MN6PR11MB8244.namprd11.prod.outlook.com (2603:10b6:208:470::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.36; Thu, 8 Jun
 2023 03:35:50 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::5b44:8f52:dbeb:18e5]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::5b44:8f52:dbeb:18e5%3]) with mapi id 15.20.6455.030; Thu, 8 Jun 2023
 03:35:50 +0000
From:   "Liu, Yi L" <yi.l.liu@intel.com>
To:     Baolu Lu <baolu.lu@linux.intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
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
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: RE: [PATCH v3 04/10] iommu/vt-d: Add helper to setup pasid nested
 translation
Thread-Topic: [PATCH v3 04/10] iommu/vt-d: Add helper to setup pasid nested
 translation
Thread-Index: AQHZhBgTX2uvl5TO/kuvRR0OMeFUCq9pFzmAgALyQQCAFGKdAA==
Date:   Thu, 8 Jun 2023 03:35:50 +0000
Message-ID: <DS0PR11MB752906AEC0AF9081454A2FFAC350A@DS0PR11MB7529.namprd11.prod.outlook.com>
References: <20230511145110.27707-1-yi.l.liu@intel.com>
 <20230511145110.27707-5-yi.l.liu@intel.com>
 <BN9PR11MB5276A52907EDD2155D42B3C08C419@BN9PR11MB5276.namprd11.prod.outlook.com>
 <6fbf021b-5f53-0290-d565-f9e765b51f88@linux.intel.com>
In-Reply-To: <6fbf021b-5f53-0290-d565-f9e765b51f88@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB7529:EE_|MN6PR11MB8244:EE_
x-ms-office365-filtering-correlation-id: bb81c15f-8850-4da6-8b12-08db67d1746b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HiJbbsipsGvN115oA8ME2wcgxMsPKAS9sajV2HFm17hc7FJug96m9GKZE1ty7vHxAaVzAXQjkL8pLWJN18Frq2zueNv39QR+EJ+4vxdv4uqynwnp+PFkZSG3NA+jn8CnhxBcJxcVU1+a8z5USo0ljiMkpVNOReZUi4iKuPVhgBqKzNlTIq6fPEHna4fprhmOlSJZb/gIZK/QsXdYyydv9yOlO/WryJXkKhF1UIdsLVCw65LFLmouZ+cibfTAnVO3432uWk5iMlAwVsVEg78rySxmKs9eiFk0vesqQfQZE1N/92nuPZCQdaw17J8a9dgBIF6VIqoxF+sKST6Z4wPeUMwGq/b6/b4B4gWYUFRnD6wigsJ+BTKd5yWLUtlus9UqQsPIqg6o/oKOpIGFOhwRHuj4zu88G7tFtKKxpn3kaDyL+QgzEAFH/F4OeD4cGXWF547dsw4N9XnF1lZmgzSI1SRjpoXbdTq2UeAeO/112ZpdbZVDdJXflwAVWvDBA0FQLRsY6P/0Ghzvy9XKjUS1pUMqOUqTJi4bS6zuQvAW7IeZd/7fGc3t3cQOgehlIxUMxWb9L7lNunJj3kwk/LoBT9VxwR/U6FGfX07e65gMkBnphV/51l4IYvgC5b1StP9BGzBU7ysVYHtCLs3k0xzr9w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(376002)(366004)(136003)(346002)(396003)(451199021)(33656002)(55016003)(26005)(52536014)(6506007)(41300700001)(186003)(5660300002)(9686003)(53546011)(8676002)(8936002)(83380400001)(110136005)(54906003)(478600001)(66446008)(66476007)(76116006)(4326008)(71200400001)(66946007)(64756008)(66556008)(7696005)(316002)(82960400001)(38100700002)(122000001)(4744005)(38070700005)(86362001)(2906002)(7416002)(13296009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MmZZV001RTJ0SlczYVM0cSt3ZTZuQ1RrSnlwS3BaVkZQVUhyVXlaQ3ZBckVv?=
 =?utf-8?B?azc5blBSbXNPNWpHOGloOXpmVFhuekdHOUFhR292Y2x3bitzeGNmL0VhZ1VC?=
 =?utf-8?B?ZFRUblpwcUxhMGhvSC9aQUF6SDFUbCtzUmp6ZlhvYTZ5eHJwUXpOUVdFSk51?=
 =?utf-8?B?aXFqRklkK0xhUENONGhOTUVkYTJ5aUFjc09aSEViMGJjd1NyU0RWTm9naWIv?=
 =?utf-8?B?SEN2VkZpM201V2Iyc2JoWkpBc1k4M2pUOHNtc2FvcWFhZGJEdW10ajlVeXpV?=
 =?utf-8?B?bEZyeXZOWXBOUGtTSlRHbWt4dEh0Z3FQTUNMMU4yczhPbk96VnZsYkxpQnFN?=
 =?utf-8?B?QjFIVCtsWEFZRXVtbTRSbi8zZUpDSW45a2ZZY25PZzVPVFY4Q3YzZ2dOZUJY?=
 =?utf-8?B?NHJNVWRVQnNSaWZvRzRCR3pqUjhIT285d1ljSjJJaG5meG5WVTBPSE83b0RS?=
 =?utf-8?B?c0FVa2Uxc1JiNWpvU2dmQ0J6ckpXb1g1cnJ2VlFxVmFFZ0Z0NVcyU3FpcGI4?=
 =?utf-8?B?MWtGdG9OYkFxeHNQaGJYTE1Za1RkcU1IRjlmWElNM1dVMVRPdE9iSDd0Z2hW?=
 =?utf-8?B?MjZ6bmliczlzRjlyUW9taE9iMlBGdVRTZDE4TWlYYVVWeWpFMlhIRnUra2V3?=
 =?utf-8?B?dFhyNTVZLzByS0pVZ2orMG83bDk4WnFrZzVsdTRuR1lacVB1NDRvVlY3L09D?=
 =?utf-8?B?WThzWmtZd1JIWUtwcGVpanBlRm9wcjNKeGowNFI2SWVQQ1dabWR3Q1NmY2tq?=
 =?utf-8?B?bm0rc1k2UkVlYmF4c3daRzhMdHJFS3hOZ0JWSWk3ZTg2Y3BFUXltRmluL2Zt?=
 =?utf-8?B?RlZULzVyY0lDMzhYOEM3U1hrVUhhem5uZUJ1aDliVTNtdG51dHQ4OHF1RjRV?=
 =?utf-8?B?SStKZlUveXp5REVtdW52dnBlOENKTU5iVm5vdG9XR2w0bmE3S05TWmR6dG45?=
 =?utf-8?B?SUhPdVZ4Z0xZRVUyN1hVRlQ5SnorT0RnVE8wUmo2bUxMQUg0ckcwNWtUSnl6?=
 =?utf-8?B?WmZFKy83b1ZXaWU4Y3lkd3orK1hickhDdUxZM1oxZzdKaTZxUThFTjR3V0VU?=
 =?utf-8?B?M2htYVpxM0NtbnJSTG94YUVhR3pTUlN5YnRKc2p6TDEzc25jTnRGWlMrWEhn?=
 =?utf-8?B?MENPV3R2U016N2d5RjVFZXFadVZUZXI2amdHYlNmRDU2UUl1VHpqMUJLb0c2?=
 =?utf-8?B?Z2VxWGgxQi80R0VGZGpjK1dZbkJhTVpsc3U1S1A5R1h3b1pKaWNzUEord3dF?=
 =?utf-8?B?MXNhdVgwM25VVi94ZDBUSGpIQUhXblBNNFcyald2OUZuWlZsT1pUQTZTeEhY?=
 =?utf-8?B?MzdlTmRoWTB6Q3NjL0VudnNON0NVVll1U281Qm91ZjhZaHNDSWxmS0pNNG1h?=
 =?utf-8?B?bDJwaDlLN1M1OERLc1JwdXIrdHJuS2dZT1dMTnRDNHZ2M3lsTkdWSStVRjF5?=
 =?utf-8?B?VW05T3JRV2lRVVFoOWkyNlZoTmh5N2pGdEtEemNJZ0dWSXRRckM0cWFRZzZh?=
 =?utf-8?B?b3hObWpMck43OE9iUS9TVzJOMVY4U3BKTXAyRXJFRG16d3VxSzZYSlQ3N1d2?=
 =?utf-8?B?VEdGbGUyZkFXaDJ4QWYvTzJHQzVmalFQQS9SNUpnSGpzTmVJUk9tenVwaUNt?=
 =?utf-8?B?dmJicUxYWEhtcjhBSFgrYWpMVFdJOWN0SlpRUXI5cTcyOUVvOUZ6akx2c2ZG?=
 =?utf-8?B?SjRnQVV3Y0dpd1RZbTR6NE92NDE4ZTl0NUV4VjhLRmtldEEwWGl2MmxyRnZh?=
 =?utf-8?B?Y0FqVmhBazlZaHlkdFZ3TWxPZSt3TEdUMWFqK0o5Tm1sSkRvZUk2S1N6M1Ra?=
 =?utf-8?B?OWZiMmt2aFlHYlFoZTJxaVJoUnpSMyt2V01qa09BZG16VXZmejRhZ083ZmEv?=
 =?utf-8?B?TlZzSEpiUlBYMnhjR2YzeXFwNDdzL0pkMU5hY3lKbFU0YVFwSGI3cG96OGI0?=
 =?utf-8?B?MXBSZ2RPaTNoakRYcGU1ZE1XNjNrbFRJMVN4ejJGK3lld1ptTUdRRXczSXVD?=
 =?utf-8?B?N3IvUnoxNzM0ZXhmK1JhRjBiRFlGUCtsSzJqT1NERTJxUllVVFIzTGg3a0tM?=
 =?utf-8?B?K2U5ZkdrRnhkR0RTT2k3THFWU0ZEV25vZ0J1akVLaG10aGRpQ1BQQkdUOVhP?=
 =?utf-8?Q?uN3ouDO2VLl3a3tvOHB7G/rB9?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb81c15f-8850-4da6-8b12-08db67d1746b
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2023 03:35:50.1702
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cX9sYYA1CVgAF29+83isNz2LDrS+3Iki5nN1T3FIPYJVGuLTsJyXqVjrXkdkiQ0Rfmp0aUiVY42SJgSNyxKBZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR11MB8244
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

PiBGcm9tOiBCYW9sdSBMdSA8YmFvbHUubHVAbGludXguaW50ZWwuY29tPg0KPiBTZW50OiBGcmlk
YXksIE1heSAyNiwgMjAyMyAxMjoxNiBQTQ0KPiBPbiA1LzI0LzIzIDM6MTYgUE0sIFRpYW4sIEtl
dmluIHdyb3RlOg0KPiA+PiBGcm9tOiBZaSBMaXUgPHlpLmwubGl1QGludGVsLmNvbT4NCj4gPj4g
U2VudDogVGh1cnNkYXksIE1heSAxMSwgMjAyMyAxMDo1MSBQTQ0KPiA+Pg0KPiA+PiArCS8qDQo+
ID4+ICsJICogTWVtb3J5IHR5cGUgaXMgb25seSBhcHBsaWNhYmxlIHRvIGRldmljZXMgaW5zaWRl
IHByb2Nlc3Nvcg0KPiA+PiBjb2hlcmVudA0KPiA+PiArCSAqIGRvbWFpbi4gV2lsbCBhZGQgTVRT
IHN1cHBvcnQgb25jZSBjb2hlcmVudCBkZXZpY2VzIGFyZSBhdmFpbGFibGUuDQo+ID4+ICsJICov
DQo+ID4+ICsJaWYgKHMxX2NmZy0+ZmxhZ3MgJiBJT01NVV9WVERfUEdUQkxfTVRTX01BU0spIHsN
Cj4gPj4gKwkJcHJfd2Fybl9yYXRlbGltaXRlZCgiTm8gbWVtb3J5IHR5cGUgc3VwcG9ydCAlc1xu
IiwNCj4gPj4gKwkJCQkgICAgaW9tbXUtPm5hbWUpOw0KPiA+PiArCQlyZXR1cm4gLUVJTlZBTDsN
Cj4gPj4gKwl9DQo+ID4NCj4gPiBJZiBpdCdzIHVuc3VwcG9ydGVkIHdoeSBleHBvc2luZyB0aGVt
IGluIHRoZSB1QVBJIGF0IHRoaXMgcG9pbnQ/DQo+IA0KPiBBZ3JlZWQuIFdlIGNhbiByZW1vdmUg
dGhpcyBmbGFnIGZvciBub3cuDQoNClNvIHdlIHNoYWxsIHJlbW92ZSB0aGUgYmVsb3cgZmxhZ3Mg
aW4gdWFwaSBhcyB3ZWxsLCBpcyBpdD8NCg0KKyNkZWZpbmUgSU9NTVVfVlREX1BHVEJMX01UU19N
QVNLCShJT01NVV9WVERfUEdUQkxfQ0QgfCBcDQorCQkJCQkgSU9NTVVfVlREX1BHVEJMX0VNVEUg
fCBcDQorCQkJCQkgSU9NTVVfVlREX1BHVEJMX1BDRCB8IFwNCisJCQkJCSBJT01NVV9WVERfUEdU
QkxfUFdUKQ0KDQpSZWdhcmRzLA0KWWkgTGl1DQo=
