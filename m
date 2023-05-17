Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87E9B706029
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 May 2023 08:33:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232675AbjEQGdn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 17 May 2023 02:33:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232752AbjEQGdl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 17 May 2023 02:33:41 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 313523AB1;
        Tue, 16 May 2023 23:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684305214; x=1715841214;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=CJt1OlkTaxZmxogA40znnWEtn8Pz9uAOYthyAeCUVIY=;
  b=cik3Hgx1BH/bkFB+Zo7uP7aSqGr72LuIRE/un1wgxKoXSzWKjy4InnMk
   2NQzkkB9d0XpSXm+a8m7vDXKObNGRL9GGse03LA6wbGmAiIAt/fkK0FBr
   xt3XdistTHTOPp2pKYWb3gF43VUAU2Bv2i4swS0UwdJ7RL6lGyJPzyqLy
   3O+9A87Dkv9wVBWf6pPslQfWunBIF3jNW1EP8wF78UGO9SC/u/go6SWnG
   8JkmfY7j05oM7gSG0s2lmmHlVQCNaqt/O4gQ54HyFX/D+EsK0X+Xzi6Hd
   mEg1tmu5PPC+o4pzHknGqz5U9GJlahIxImesLVSnBMisfHHALaeBUiUem
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10712"; a="379868527"
X-IronPort-AV: E=Sophos;i="5.99,281,1677571200"; 
   d="scan'208";a="379868527"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2023 23:33:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10712"; a="704704372"
X-IronPort-AV: E=Sophos;i="5.99,281,1677571200"; 
   d="scan'208";a="704704372"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga007.fm.intel.com with ESMTP; 16 May 2023 23:33:33 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 16 May 2023 23:33:33 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 16 May 2023 23:33:33 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Tue, 16 May 2023 23:33:33 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.170)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 16 May 2023 23:33:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dCQdeOdkfG1pNFO45bJNYSDcIrzBQiV/2JdmNTQbtA972mJdIms3dzpGj/iHLEjpaUmY6iOMYtAKpXPrZiAPeeNeu9s+yV8/XGG0DokjRGUbFWt8ODD0UK1FfLUctGZxGhCJiSgEAcMWwFUPz4UIxyiwRe6daUcmZcz0mTaTlbgy/6mpd3sJdT4LE/9l1YaZpWBXltNz4kZ2TxCXvZEoC1BIG43mjwTSvyZuHsFHItVES/cZHi+8UymC5DghWIOlvpfG0SFekOHu7vbG/V9CGnn7ZZx3R64+JXWsVN91hJ1yCNpMzwxSZ2pTx5W2ou8ADr66XHrL/uLHXN/AaBb05g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CJt1OlkTaxZmxogA40znnWEtn8Pz9uAOYthyAeCUVIY=;
 b=UqsewhOJoOJ5pO+3YmJVc/EjTaivjraVAKi/Nxqx1cgiqHgtY2FaO3YMrkpb0TRIw9ebwmajMgwaTjgUFCFarPBitVHL27dXfs4kKBdSLrIU74w2CHTryyR44Dj4Z5TeZtx7u3BtoZaSU5z+bjOd7k7lR6apSKV7sE8G1kj0YKJiKFsl/cpYdqJByoFaLsgXltyEicrXc4Yr17Mhrz44I2wB4eGQJf5aZCD6OFnSZf9EK9H5eNuqcVY184iBRViyNVEvlfpgS3JU18Cilkvxq/brXHeIjhnZIO6+coUC3lHS3enO9H5DD/GQk3OeoBFNVexPW+RhtCMbuIIim5FmAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SA1PR11MB6568.namprd11.prod.outlook.com (2603:10b6:806:253::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Wed, 17 May
 2023 06:33:30 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::73e9:b405:2cae:9174]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::73e9:b405:2cae:9174%5]) with mapi id 15.20.6387.033; Wed, 17 May 2023
 06:33:30 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Baolu Lu <baolu.lu@linux.intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>
CC:     "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        Lixiao Yang <lixiao.yang@intel.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        "Nicolin Chen" <nicolinc@nvidia.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>
Subject: RE: [PATCH v7 03/19] iommufd: Replace the hwpt->devices list with
 iommufd_group
Thread-Topic: [PATCH v7 03/19] iommufd: Replace the hwpt->devices list with
 iommufd_group
Thread-Index: AQHZhzWsuSojdONTVkS/71F/KrGa6a9cNqkAgACemACAAQifgIAAJcFA
Date:   Wed, 17 May 2023 06:33:30 +0000
Message-ID: <BN9PR11MB5276DE1BC30E90B1032C0E468C7E9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <3-v7-6c0fd698eda2+5e3-iommufd_alloc_jgg@nvidia.com>
 <569b959e-a702-fc19-3d67-0dde4e77251a@linux.intel.com>
 <ZGN2yvhpIvrvu74r@nvidia.com>
 <852e85b3-9fd2-bfc2-6080-82cea7ab6abd@linux.intel.com>
In-Reply-To: <852e85b3-9fd2-bfc2-6080-82cea7ab6abd@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SA1PR11MB6568:EE_
x-ms-office365-filtering-correlation-id: 1cb2976d-94be-4654-69a3-08db56a0a159
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: N5I+XhAJ7sdUZn4WNtsyvjnToj6GnzW6JiNw4EGn79DhBjevjeCPJeSchhSEe5DOWaow1rpMab1MkXNd4MdGnppYtlabnAE/h94hHPithssNSDEaBbPqaAx3VepYPTdVR+MpCuSSjd38i3Cl636sAwu2ljwmqx3X0CEPDCBZi6+rubyAHVIZxrfD+aMy9mzbpLZKcAwsU5ZPozgyoeSpDDxOpRaWwSqT5pukJvGAOqcj0j6fy9eegt+UlYHGcF7yy8lou6plu9hjoIZHI3J72mdrTLynAXEeFqoil5to8vZc351DDkWOT+5Y86BO7U93FVf6dlJZtcJdkKsxFOZETNUcVqkzMHfbumsGwG+8A1okTaVb9EJPkTwchTOkL6aq4JFyjzNexZwG1/9E51d5YANJsofZS6kNuHyWuN7kaQAL0CMozCtFotqAlYJzq5pO2E4uRIvslaBrCdpR6oGvG0ynVYaw06UO0zZVn4JQdSv0wyoMwUdOlTwHreYyFbUZfRjivkQj5BhD/bQn5gqAMZQxSOyhT5OPDkbhRkmrveafD6m6Sz5/DXIPcguab/Ta2cWvisr3THT8NLCO6BvzLCbO2NPQJpaDXiv6J4JR/MCHDjSmznwLwt6Rtl04qNRM
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(136003)(376002)(39860400002)(366004)(396003)(451199021)(478600001)(54906003)(110136005)(52536014)(86362001)(8676002)(5660300002)(8936002)(2906002)(33656002)(38070700005)(76116006)(64756008)(66556008)(4326008)(66476007)(66446008)(82960400001)(66946007)(122000001)(316002)(41300700001)(38100700002)(186003)(26005)(53546011)(83380400001)(9686003)(55016003)(6506007)(7696005)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bUo4RkFzdytqM21UZlBxNmdLNG0ySGJjNmpIbHluY0VrYytWZkVkOURwSWhB?=
 =?utf-8?B?N0ZuNWxEL0h3RUR3Z3I1UGd3bUZHK2oxN2dKWnUzYzFaZm1ISzE3clFVLzlz?=
 =?utf-8?B?QVZqam9oWStXcFhVazhGNWlJbFJ6cEQwUncza3FET2dGMmZFaW1ZeVBPZ2hy?=
 =?utf-8?B?clUzRVNDRTZpR1FuSUdMMS82WGp1eTRtVXQ0UnRsUmZMM2VWbUhDVHp3VnNm?=
 =?utf-8?B?azNmVm1KZVJTUzBaWlcyMTVDYVIxLzZ0cFZUYjRWL1BjTEFDQ0p6TmM4REIr?=
 =?utf-8?B?ekFzcTk5Vk1vUUVQWXE2TVJkcitJUmxzbHFHUHVPUFEwK01YYVhPUW1BcVM2?=
 =?utf-8?B?OG9GT1RiZGNYSzI3OUVxemtDTWV2aFhkK0JtNXhjVEpIanR5aE1ZTjl6MXpT?=
 =?utf-8?B?Smh5dUF2NWZxL3FpSXVvN0F4VElCVjltWG5HdE5mWndMVWIrSUlDaFpiV0xt?=
 =?utf-8?B?dHBoUmx3RTM2QU96ZHhrc25tNXB3ZCtYayswZUlzMnFLaUQrZnVMSmJUaWJT?=
 =?utf-8?B?aThKWEtGVTJ5NnJxQnNjSDg5ZFFNR1R0cjh0eUhiVlMrNC9hYnRNUi9pMmJu?=
 =?utf-8?B?OXFEVnErSjJFRjVndy9CZVBFVERPaUlPR0NOM3MxOTZuWS9sUGs3QkM3aFJi?=
 =?utf-8?B?d1JxWk1uVG1WVm1HbFNEd2VGd1hMTm1nZkRKZ3QvaFNlMXUrK3U2U0NnUC9J?=
 =?utf-8?B?dUxvTEpEaUdxaC9yajVEZHZmRDdoNC9iZUFZR1ZOTFBsODdIUWIxdCs2Vzhn?=
 =?utf-8?B?cXFXelFyazhVblp0U1VWSjloU3Jyb09IL3pETnE0ZExVOGZUQlRhOE9YQnRU?=
 =?utf-8?B?LzVnb2ROOWFNMWtzMTFzQkVPbk4yNWdmMDd0ZW9ERHJvVjlPbFVqam9QUXVv?=
 =?utf-8?B?TXJxZzNoSTgxVXhsZjk1RFRnZ0N0Vlp6dXBMc0h6ZThib1dGSDNrNlE1V0RD?=
 =?utf-8?B?VWc3TEVtWjI5UCtMMzQ4aUN2L3BOamNXVGp3aW9iVk04bElnZkRZRktFb0hl?=
 =?utf-8?B?ai82ajB2YmM4cC96MkpTRXRlRTU4VytZY3lmeStWY0VPRGFCS2Q0VUxRYkFr?=
 =?utf-8?B?QUljZUZOZ2xUaFBBZ0lndnQ0VHd5dDJkUk91MHh1cTZ1dkk1U3BOT0FBc2xS?=
 =?utf-8?B?M1dMT2h4SjgxUDgyMXorY0t0NlpwUU82UGJCWER5LzF1SyttSng0Sld4SWZY?=
 =?utf-8?B?M0ZpWmZyYXUrWkY1NStlNGpBQjRSY1FXZDZIWUU4RENNWlU4NU5HRnNHVGpu?=
 =?utf-8?B?N3NnMDdiaWM0c3pCcGtvWVAxRmxrNnFGYVZyY0hVdXJ1V0xXdVFxbURIMlFB?=
 =?utf-8?B?SThNV1ZSWFQzU2lKL1FqZENkNWFnT0Mrck82TnpXZWk1dU5EMDhDSSttT1FO?=
 =?utf-8?B?TkVxLzZ3QzhkTmM2NHFlV2xQRno0aVU4QjNFWGlRSFBxZy9vMHJ1eGNtMThU?=
 =?utf-8?B?Ni8vSHB3cWM3dFZ2azM5bUYydzI2Mk8wWXNaZ0lvWkFNYStyMS9Md3JLQk5X?=
 =?utf-8?B?aldKVUpRbXhpcVV0OFQyeGU1ZnpIemZzTGRaQWlDQmVERXNibXFRcG0rQnI1?=
 =?utf-8?B?MUp5Yk5vZTlLY0IvWUthS3I4OWVRTVkwVkQ3amhqMVd3QUQzSUNxMmJPN0lt?=
 =?utf-8?B?VEZ5Qmt0L293QjlHS1lsTVhPdGxjNUo3eXVITzhQMDF6ZmNsbXlsekVtVHRx?=
 =?utf-8?B?a2F1elBndjlTbUVwaWRsQ3dZWnFzaG5iQzlGY1haNGJINTNkTlJMTDFxNVNJ?=
 =?utf-8?B?M05QZHptQmNTMjk2RzZwcW1VWC9jalBIMGJCbElZUGlSZmJ3eHJOdWg3eUV3?=
 =?utf-8?B?cUhSNDNkMkdyMElaMUdsbDRnbFd0QUZUYXQ5TVErWTI0UjBMVjVQSzczMDRq?=
 =?utf-8?B?blBRZzl6d2d5OG5pU2hVcGg4cHY0aFlQWFBhSnhXRHlva0YxWWgyZk52clUw?=
 =?utf-8?B?QzV1YXFqRnJqSzJCcXAxTjVhc1B4U3hvUnFRRE03RDAyS0FDaG0rTGh3OExM?=
 =?utf-8?B?RXNCcnltZzBGQVBzTVdwZFlNK1RseVRjRFFxcGU4S3FIZVBoVm9sejM0ZWZh?=
 =?utf-8?B?dHhhT0lUNzZ2ZGk1Zkp6UlllZTF4aFRTay94TWt5emRXb2kxVFFEZSs3eEpD?=
 =?utf-8?Q?QnOSADshX57me8VHku2TDyv73?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cb2976d-94be-4654-69a3-08db56a0a159
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2023 06:33:30.4521
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YRgOxXK7aba+DCEMaERTVN+SBMZpCRugict+vV7eTTbb6MsHedsMRsn8SPtO3cNgZ1dmSd/B4LIZX1s+0pICig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6568
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

PiBGcm9tOiBCYW9sdSBMdSA8YmFvbHUubHVAbGludXguaW50ZWwuY29tPg0KPiBTZW50OiBXZWRu
ZXNkYXksIE1heSAxNywgMjAyMyAxMjoxNSBQTQ0KPiANCj4gT24gNS8xNi8yMyA4OjI3IFBNLCBK
YXNvbiBHdW50aG9ycGUgd3JvdGU6DQo+ID4gT24gVHVlLCBNYXkgMTYsIDIwMjMgYXQgMTE6MDA6
MTZBTSArMDgwMCwgQmFvbHUgTHUgd3JvdGU6DQo+ID4+IE9uIDUvMTUvMjMgMTA6MDAgUE0sIEph
c29uIEd1bnRob3JwZSB3cm90ZToNCj4gPj4+IFRoZSBkZXZpY2VzIGxpc3Qgd2FzIHVzZWQgYXMg
YSBzaW1wbGUgd2F5IHRvIGF2b2lkIGhhdmluZyBwZXItZ3JvdXANCj4gPj4+IGluZm9ybWF0aW9u
LiBOb3cgdGhhdCB0aGlzIHNlZW1zIHRvIGJlIHVuYXZvaWRhYmxlLCBqdXN0IGNvbW1pdCB0bw0K
PiA+Pj4gcGVyLWdyb3VwIGluZm9ybWF0aW9uIGZ1bGx5IGFuZCByZW1vdmUgdGhlIGRldmljZXMg
bGlzdCBmcm9tIHRoZSBIV1BULg0KPiA+Pj4NCj4gPj4+IFRoZSBpb21tdWZkX2dyb3VwIHN0b3Jl
cyB0aGUgY3VycmVudGx5IGFzc2lnbmVkIEhXUFQgZm9yIHRoZSBlbnRpcmUNCj4gZ3JvdXANCj4g
Pj4+IGFuZCB3ZSBjYW4gbWFuYWdlIHRoZSBwZXItZGV2aWNlIGF0dGFjaC9kZXRhY2ggd2l0aCBh
IGxpc3QgaW4gdGhlDQo+ID4+PiBpb21tdWZkX2dyb3VwLg0KPiA+Pg0KPiA+PiBJIGFtIHByZXBh
cmluZyB0aGUgcGF0Y2hlcyB0byByb3V0ZSBJL08gcGFnZSBmYXVsdHMgdG8gdXNlciBzcGFjZQ0K
PiA+PiB0aHJvdWdoIGlvbW11ZmQuIFRoZSBpb21tdWZkIHBhZ2UgZmF1bHQgaGFuZGxlciBrbm93
cyB0aGUgaHdwdCBhbmQNCj4gdGhlDQo+ID4+IGRldmljZSBwb2ludGVyLCBidXQgaXQgbmVlZHMg
dG8gY29udmVydCB0aGUgZGV2aWNlIHBvaW50ZXIgaW50byBpdHMNCj4gPj4gaW9tbXVmZCBvYmpl
Y3QgaWQgYW5kIHBhc3MgdGhlIGlkIHRvIHVzZXIgc3BhY2UuDQo+ID4+DQo+ID4+IEl0J3MgZmlu
ZSB0aGF0IHdlIHJlbW92ZSB0aGUgaHdwdC0+ZGV2aWNlcyBoZXJlLCBidXQgcGVyaGFwcyBJIG5l
ZWQgdG8NCj4gPj4gYWRkIHRoZSBjb250ZXh0IHBvaW50ZXIgaW4gaW9hcyBsYXRlciwNCj4gPj4N
Cj4gPj4gc3RydWN0IGlvbW11ZmRfaW9hcyB7DQo+ID4+ICAgICAgICAgIHN0cnVjdCBpb19wYWdl
dGFibGUgaW9wdDsNCj4gPj4gICAgICAgICAgc3RydWN0IG11dGV4IG11dGV4Ow0KPiA+PiAgICAg
ICAgICBzdHJ1Y3QgbGlzdF9oZWFkIGh3cHRfbGlzdDsNCj4gPj4gKyAgICAgICBzdHJ1Y3QgaW9t
bXVmZF9jdHggKmljdHg7DQo+ID4+ICAgfTsNCj4gPj4NCj4gPj4gYW5kLCB1c2UgYmVsb3cgaGVs
cGVyIHRvIGxvb2sgdXAgdGhlIGRldmljZSBpZC4NCj4gPj4NCj4gPj4gK3UzMiBpb21tdWZkX2dl
dF9kZXZpY2VfaWQoc3RydWN0IGlvbW11ZmRfY3R4ICppY3R4LCBzdHJ1Y3QgZGV2aWNlICpkZXYp
DQo+ID4+ICt7DQo+ID4+ICsgICAgICAgc3RydWN0IGlvbW11X2dyb3VwICpncm91cCA9IGlvbW11
X2dyb3VwX2dldChkZXYpOw0KPiA+PiArICAgICAgIHUzMiBkZXZfaWQgPSBJT01NVUZEX0lOVkFM
SURfT0JKX0lEOw0KPiA+PiArICAgICAgIHN0cnVjdCBpb21tdWZkX2dyb3VwICppZ3JvdXA7DQo+
ID4+ICsgICAgICAgc3RydWN0IGlvbW11ZmRfZGV2aWNlICpjdXI7DQo+ID4+ICsgICAgICAgdW5z
aWduZWQgaW50IGlkOw0KPiA+PiArDQo+ID4+ICsgICAgICAgaWYgKCFncm91cCkNCj4gPj4gKyAg
ICAgICAgICAgICAgIHJldHVybiBJT01NVUZEX0lOVkFMSURfT0JKX0lEOw0KPiA+PiArDQo+ID4+
ICsgICAgICAgaWQgPSBpb21tdV9ncm91cF9pZChncm91cCk7DQo+ID4+ICsgICAgICAgeGFfbG9j
aygmaWN0eC0+Z3JvdXBzKTsNCj4gPj4gKyAgICAgICBpZ3JvdXAgPSB4YV9sb2FkKCZpY3R4LT5n
cm91cHMsIGlkKTsNCj4gPj4gKyAgICAgICBpZiAoIWlvbW11ZmRfZ3JvdXBfdHJ5X2dldChpZ3Jv
dXAsIGdyb3VwKSkgew0KPiA+PiArICAgICAgICAgICAgICAgeGFfdW5sb2NrKCZpY3R4LT5ncm91
cHMpOw0KPiA+PiArICAgICAgICAgICAgICAgaW9tbXVfZ3JvdXBfcHV0KGdyb3VwKTsNCj4gPj4g
KyAgICAgICAgICAgICAgIHJldHVybiBJT01NVUZEX0lOVkFMSURfT0JKX0lEOw0KPiA+PiArICAg
ICAgICB9DQo+ID4+ICsgICAgICAgIHhhX3VubG9jaygmaWN0eC0+Z3JvdXBzKTsNCj4gPj4gKw0K
PiA+PiArICAgICAgIG11dGV4X2xvY2soJmlncm91cC0+bG9jayk7DQo+ID4+ICsgICAgICAgbGlz
dF9mb3JfZWFjaF9lbnRyeShjdXIsICZpZ3JvdXAtPmRldmljZV9saXN0LCBncm91cF9pdGVtKSB7
DQo+ID4+ICsgICAgICAgICAgICAgICBpZiAoY3VyLT5kZXYgPT0gZGV2KSB7DQo+ID4+ICsgICAg
ICAgICAgICAgICAgICAgICAgIGRldl9pZCA9IGN1ci0+b2JqLmlkOw0KPiA+PiArICAgICAgICAg
ICAgICAgICAgICAgICBicmVhazsNCj4gPj4gKyAgICAgICAgICAgICAgIH0NCj4gPj4gKyAgICAg
ICB9DQo+ID4NCj4gPiBJIGRpc2xpa2UgaG93IHNsb3cgdGhpcyBpcyBvbiBzb21ldGhpbmcgcmVz
ZW1ibGluZyBhIGZhc3Rpc2ggcGF0aCA6XA0KPiANCj4gWWVzLCBhZ3JlZWQuDQo+IA0KPiA+IE1h
eWJlIHdlIHNob3VsZCBzdGFzaCBzb21ldGhpbmcgaW4gdGhlIGRldl9pb21tdSBpbnN0ZWFkPw0K
PiA+DQo+ID4gT3IgY2FuIHRoZSBQUkkgc3R1ZmYgcHJvdmlkZSBhIGNvb2tpZSBwZXItZGV2aWNl
Pw0KPiANCj4gV2UgYWxyZWFkeSBoYXZlIGEgcGVyLWRldmljZSBmYXVsdCBjb29raWU6DQo+IA0K
PiAvKioNCj4gICAqIHN0cnVjdCBpb21tdV9mYXVsdF9wYXJhbSAtIHBlci1kZXZpY2UgSU9NTVUg
ZmF1bHQgZGF0YQ0KPiAgICogQGhhbmRsZXI6IENhbGxiYWNrIGZ1bmN0aW9uIHRvIGhhbmRsZSBJ
T01NVSBmYXVsdHMgYXQgZGV2aWNlIGxldmVsDQo+ICAgKiBAZGF0YTogaGFuZGxlciBwcml2YXRl
IGRhdGENCj4gICAqIEBmYXVsdHM6IGhvbGRzIHRoZSBwZW5kaW5nIGZhdWx0cyB3aGljaCBuZWVk
cyByZXNwb25zZQ0KPiAgICogQGxvY2s6IHByb3RlY3QgcGVuZGluZyBmYXVsdHMgbGlzdA0KPiAg
ICovDQo+IHN0cnVjdCBpb21tdV9mYXVsdF9wYXJhbSB7DQo+ICAgICAgICAgIGlvbW11X2Rldl9m
YXVsdF9oYW5kbGVyX3QgaGFuZGxlcjsNCj4gICAgICAgICAgdm9pZCAqZGF0YTsNCj4gICAgICAg
ICAgc3RydWN0IGxpc3RfaGVhZCBmYXVsdHM7DQo+ICAgICAgICAgIHN0cnVjdCBtdXRleCBsb2Nr
Ow0KPiB9Ow0KPiANCj4gUGVyaGFwcyB3ZSBjYW4gYWRkIGEgQGRldl9pZCBtZW1vcnkgaGVyZT8N
Cj4gDQoNCndoYXQgYWJvdXQgU0lPVj8gVGhlcmUgaXMgb25seSBvbmUgY29va2llIHBlciBwYXJl
bnQgZGV2aWNlLg0K
