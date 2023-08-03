Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95A2A76DF3B
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Aug 2023 06:01:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231318AbjHCEBJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 3 Aug 2023 00:01:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232109AbjHCEAu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 3 Aug 2023 00:00:50 -0400
Received: from mgamail.intel.com (unknown [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C9BB30C7;
        Wed,  2 Aug 2023 21:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691035239; x=1722571239;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ovyNsH0tgcN8A/DMY8J2TBfvTtlZtWGLS+iN9bp2eUg=;
  b=i0l9XJ1DkJqD8xICfx6j7r0PrMVpGQJc8YHK53BLqEbAMvaOg1GGFmiJ
   +PRthos1zeK4wMf3t1KhbXxKyCicdew3uzcPtGlvg4hrQC50yEimNur3J
   kUpgWRceyewHvOt71FXYzZ9Wg2unqVEoPzOXttIVCstMgJBiBKfB/tjID
   CB5BSfq4uNiGyfEHYMMTjY3Pyp1/XxRIsrAIhLr5xbKhTcIL5LwDiK3DU
   vrrii+0j95sa5cNs8ipAdBJNtnTarI7Roux1f2hW1zWHln/lLZnARzEak
   QeUp0AglXcH3BirtvDzIVLmkWftjJ9z4rIpYu5wC4nMIrvrKx2dQ9E805
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10790"; a="373396077"
X-IronPort-AV: E=Sophos;i="6.01,251,1684825200"; 
   d="scan'208";a="373396077"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2023 21:00:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10790"; a="853092987"
X-IronPort-AV: E=Sophos;i="6.01,251,1684825200"; 
   d="scan'208";a="853092987"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga004.jf.intel.com with ESMTP; 02 Aug 2023 21:00:38 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 2 Aug 2023 21:00:37 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 2 Aug 2023 21:00:37 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 2 Aug 2023 21:00:37 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.173)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 2 Aug 2023 21:00:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rl2Fq2aWbUjIowMQPLR+mu/ulfiC3uB7E3oJenoVC5JwvwJ+9pfdzx9ItUtS8nnEZDK1mPxph8VtmuyNQW0nHMZfUwNXmKpeTAoXFLTZ1krJcrFpTtmUOZhIp/1/Lw/TiyDo8v93gYoeRt4fEVIFRiVPBqJKlcQfbtr2XYCYBoRfxoHLTg81zp+eM4QKfTo7JcepjOfNeSJw1rEFfdLKD70FvzkucCBjDycXnoWNfRijC9MdBesfPf7UndZQ9w5uQu8eY2dsHSeHhGXG1xeKUtpG3z3kLyumgAyFEoiIWfChFY8QM7QCbwnu88lqcDLHul8ixguUDVSmWBXv5J6vXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ovyNsH0tgcN8A/DMY8J2TBfvTtlZtWGLS+iN9bp2eUg=;
 b=A0DosVilNSEb0BiRdOhGeL5uCf+++/HwxtqsQ65v/VZYkYmh61EwJ9V2qvRdz7WjxP27XRQhEf3uh23N9Pnf7OMHiu7E6U0c9VOzKCKUOXMTjxJk0lBrwtbSbBVMkNeMfboap1vGoHJzhIYz+rBKVVrDfT2cG7JhjWHLBa9Ep+16rC9w6Cf8tmWz3uNMhd44+ukxYj0/ugUQZYl/NpBG8cVF2N5zHl9BD8IwoAMAy+DwWCGAvRKKyBPTnYq8edLpZY4MrmNvm6z4cSiIX+6IUOOfld9sE5QketCwjY4qx6eNZ2SQjB6UuDOkmwpDbMpRV616M6s3xnG1AlmrdvtlqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DS0PR11MB8763.namprd11.prod.outlook.com (2603:10b6:8:1bb::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.47; Thu, 3 Aug
 2023 04:00:35 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::dcf3:7bac:d274:7bed]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::dcf3:7bac:d274:7bed%4]) with mapi id 15.20.6652.020; Thu, 3 Aug 2023
 04:00:35 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Baolu Lu <baolu.lu@linux.intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
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
        "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
Subject: RE: [PATCH v4 12/12] iommu/vt-d: Disallow nesting on domains with
 read-only mappings
Thread-Topic: [PATCH v4 12/12] iommu/vt-d: Disallow nesting on domains with
 read-only mappings
Thread-Index: AQHZvh/xpJ4WurReCk6xBF9LLfi+N6/Wr/7AgAFIfYCAAAlG8A==
Date:   Thu, 3 Aug 2023 04:00:35 +0000
Message-ID: <BN9PR11MB5276E14F132C58BD6C50C9218C08A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230724111335.107427-1-yi.l.liu@intel.com>
 <20230724111335.107427-13-yi.l.liu@intel.com>
 <BN9PR11MB52767DF0C8F25AB893B38B678C0BA@BN9PR11MB5276.namprd11.prod.outlook.com>
 <b099a333-65b1-de9e-742d-d12f4fb58f67@linux.intel.com>
In-Reply-To: <b099a333-65b1-de9e-742d-d12f4fb58f67@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|DS0PR11MB8763:EE_
x-ms-office365-filtering-correlation-id: 20770cb3-dc16-458f-b9e1-08db93d630f7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DIyYb5XtnDiqT+FZ35BtfS5F1c/kxf0AgKftrjdpx6emLj3JYnd/TXRptXflN7uDb9N8lHN+q5M7N6Pnj9NkIbQmL+KjQqWW9z13a0hZzw9irxsyF3kmoSi6N8qKVXov8L344spvOp2VBM25aNoDH9TNKwRwlZp+t6qasfy8l/mGYt4TX4Pwq/xtJNyGNBiTyUB69AqAjtsq+g7Kl/aQMC/WnQ2bZN2NNP4hWDCrQqwtkkUNt2fCng6Smnu+VIcH7AIL14HpGh684FqQvXj36Badt3tsZHarTnZgs3Wqx/mAsuw7FTNNFNHGXtRJ83WNU8oH9yyVHlFmzhjYG+Haw6N3TsKZ+Wnr14sEqIvf/uCgBGkVI6Jq6rLSLIRuUM6W6ZTH5KrSKENdZH4M82OzcqcWP3hvM6ERDwj5oZkDYjQOk14p4nQmhGKfIc6prlUamA3hpU1wRUGEKC1z4mjOWOwPNkO1KG37m2oi8GwhhWTUOKMbTGhRJWcfZbrYXfaSDL9mRoPXdWMS5FuQoLvF4kffLwS7xQXMw7yYSICpEKqhG/NRRaBFkyAIPVnybsBWexjFF0+o26jQIu+jAl3mLe6Q3uUrkMhNIagwsV/s+63C45bX/J7fgutUksD/xzvQ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(396003)(39860400002)(376002)(366004)(136003)(451199021)(55016003)(7696005)(9686003)(71200400001)(38100700002)(82960400001)(66556008)(66476007)(66446008)(64756008)(4326008)(66946007)(76116006)(5660300002)(316002)(41300700001)(54906003)(478600001)(110136005)(38070700005)(26005)(6506007)(53546011)(186003)(122000001)(52536014)(33656002)(7416002)(8676002)(8936002)(2906002)(86362001)(4744005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bDR2WnNQRHd5dGFlLzlrY0lmb2RDa2VHSC80Y1BVVDRGaWo3TW4yQW1aWWhr?=
 =?utf-8?B?TlRRWU1tS2ZpM1NZYThNcEdRVFZpYmQvNlZnaVlXa1libzlqRm9CVDV0Q3Ix?=
 =?utf-8?B?SUNrTmFOK2FEWFFjS1hLM0VjaWtWU0Ryclp0Uzh6K21KSWdRWnZMUTE4azUw?=
 =?utf-8?B?NUpMV1J1aURDWDBJYnl0SkpBdUpPQmFScXMxODdXRkppR3cyRUJGWVNQWUtv?=
 =?utf-8?B?b0hkUWFscjQ2WlY0MWdyZ29SMG9ZQkp3U3FMT0FjcTcva0hJOUFRUEJVeHVp?=
 =?utf-8?B?c0ZQNFhnV2NkRCt2U2FDaCtueTVRczcvSVhXWTEzRUp1UzVLRkFrNG1YWUNE?=
 =?utf-8?B?bXFmd0sxSzd4UmtiMkFkbXIrSEE2UDdURVBIdmJvUzhOSEx1Z1RZQkllYklW?=
 =?utf-8?B?bHVGQlE1N0xEd0xxZEJYZ3l5YU9TaS9EalBMN1FSd3Z4L2NhYVE3SmEwT2hF?=
 =?utf-8?B?VVNMVFRwZldrU0ZRK1FXbDdSQWZlakxRNmxnOG9QaWxDZ0RqeDBLMnRjV01J?=
 =?utf-8?B?YzRkUm14MlZrZS9sbmxlQVVlMFRPNUs2MTlienJzREhKSHQrbWNjNTFvY1ZX?=
 =?utf-8?B?Z0c1aUFyY2tnQXpGaFBZWEIwNGtGajFpU2hDZG9BNTVBNHh3cStyU09Jeklh?=
 =?utf-8?B?WWdLNDQ5WGFrQ1l1aUxpcXdCL3BLT1huRUNvUmNqLyt5K1N6akJpTUtreWRP?=
 =?utf-8?B?dVFYMGV4OXZ0dm15MndqNVR5dzcvVHoxbThQWjl1cU01emJwTTBydWlwRGov?=
 =?utf-8?B?Z2xGMkRISVBMT3BWM3FRell3RkNEako5QTZMRGttamdNc1RsZngrcnpQbGdZ?=
 =?utf-8?B?KzBKQWRKcVNPaThCbWJDQmxLYmdsQWJBYzcrZll4YTJsOEhYV2NsYTNyNWVY?=
 =?utf-8?B?MU5YN2ZnUE1ySHBjbEpFUS9nUHF0UTdKS2pUaUNJOEgwbGl5RE4rVXg4QjlY?=
 =?utf-8?B?VHpuWkttUzhpOWJoL1FEcjl2QWtmaEpIaHU3bWhHbHNxZUMwZW12RVNHdkcw?=
 =?utf-8?B?WVJCdnl1Sng4Y0FTWUlLeUtOYll0ZWdyVENJZVEyVTZVVGtMOUt0WEdHL0xz?=
 =?utf-8?B?RXVWeHJiMGRydUhrbnRNVkdVVkFwM2RJRW80SDVmNzFZd3pJVDJsTW5VSE5M?=
 =?utf-8?B?RExXczl5NDdISHhUWEtmM0tWWHI5UWF5NmRXcjkxMzZwb0JNZ041L3Y4Ylg5?=
 =?utf-8?B?VVYyNXM5ZFowS1NONXhGSjloRFgwa0ZHdk00OE9ISFA2bU83SHkwcW1XcFBP?=
 =?utf-8?B?SmRlN0RacDlERVAwWnhzWDdzMFIwR01LV3hRdDlWOFpMTTk5b2M2N1ZIZ1o5?=
 =?utf-8?B?QWxJdnF1QXJuOVhkL2hsWXgxNU51SURsdXNiVkt5eXZSR2pESWxwUC9FYXN5?=
 =?utf-8?B?dXQrcGVvSEhzQkxkajAvTGJlQzVRVXJjNDVJbXFXVFNQWGFLQVZrODczRnY4?=
 =?utf-8?B?d3hKRkVHMEg1dUNEa3JvcjlaWVRhMU9Eb1Y0U3p1SHRudld2OUN0S1dCS3FI?=
 =?utf-8?B?Q1ZPYnRSemYyWUNVdmZ4MVREL0lSd0xyTmdkT29LTENTSnY5bk1qbXIwbHRp?=
 =?utf-8?B?N2hEck1LYzkrdTJoT2kyWWc5S2p6SkdqVjk2ck9kekpWK0EyNHFkRzVkTE5P?=
 =?utf-8?B?M3VWT3JnSXFKN0xwOEpYcVpxWEhRWHhvQTRXNENqMXBVbUg4bTlrcEJadUgy?=
 =?utf-8?B?NTlKdVVTSUtnV2VtT2VpVjJIOE5haDdzTzVSRjA2VFgwamwyQ0lyY3hlSmVk?=
 =?utf-8?B?NUNyaGpxTUl2ODRvMllzS0pMaXpZQ21tZmY5ZFlTbGZaNXFpWElCakl5c0xx?=
 =?utf-8?B?Z3dBUEl0bjl2dEFLRVRHeExxYTJEVkNHcUcwM3RFd0FwQkp4andvdU1lWnRJ?=
 =?utf-8?B?b1hUWEQwYzhCYUFhMDI0VmpYcVRaMit0TmtFMTJlSy9TRXJHVzJST29MdW1C?=
 =?utf-8?B?ODkzcnFjbmI1cmJzdzU5M3NoUE0rMGs5MzJpaGVXSDhHVHl1NmVzbFQ3SW1R?=
 =?utf-8?B?Q2dnTTdLemd1K1ZXVFBxZ01TMDdXQlBRTmdOOU5kRnh0bWxhc0lsSFdRWk9r?=
 =?utf-8?B?RW5uNWF3L1Z2Zm5GQXA0Y2hoN0JEUkgvUEMxMVlualFYTDdxTWpSeHBzeWgz?=
 =?utf-8?Q?hNqnj9AWmq/CcSatJUQXNPn+r?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20770cb3-dc16-458f-b9e1-08db93d630f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Aug 2023 04:00:35.6353
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: whCjOYXWS3m9+NH8g0wwjhiji+wRUHabHZvzpwQQEnssxglbsTwVOYsOzQU2SZR+VPuETBRYtHsnWksKleSzhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8763
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

PiBGcm9tOiBCYW9sdSBMdSA8YmFvbHUubHVAbGludXguaW50ZWwuY29tPg0KPiBTZW50OiBUaHVy
c2RheSwgQXVndXN0IDMsIDIwMjMgMTE6MjcgQU0NCj4gDQo+IE9uIDIwMjMvOC8yIDE1OjU5LCBU
aWFuLCBLZXZpbiB3cm90ZToNCj4gPj4gRnJvbTogTGl1LCBZaSBMIDx5aS5sLmxpdUBpbnRlbC5j
b20+DQo+ID4+IFNlbnQ6IE1vbmRheSwgSnVseSAyNCwgMjAyMyA3OjE0IFBNDQo+ID4+DQo+ID4+
ICsJdTggcmVhZF9vbmx5X21hcHBlZDoxOwkJLyogZG9tYWluIGhhcyBtYXBwaW5ncyB3aXRoDQo+
ID4+IHJlYWQtb25seQ0KPiA+PiArCQkJCQkgKiBwZXJtaXNzaW9uLg0KPiA+PiArCQkJCQkgKi8N
Cj4gPj4gKwl1OCBzZXRfbmVzdGVkOjE7CQkvKiBoYXMgb3RoZXIgZG9tYWlucyBuZXN0ZWQgb24g
aXQgKi8NCj4gPg0KPiA+IHdoYXQgYWJvdXQgImlzX3BhcmVudCI/DQo+IA0KPiAiaXNfcGFyZW50
IiBpcyBzdGlsbCBhIGJpdCBnZW5lcmljLiBIb3cgYWJvdXQgImlzX25lc3RlZF9wYXJlbnQiPw0K
PiANCg0KbG9va3MgZ29vZC4NCg==
