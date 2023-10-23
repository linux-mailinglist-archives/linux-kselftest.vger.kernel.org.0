Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 980817D31AF
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Oct 2023 13:12:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233119AbjJWLMC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 23 Oct 2023 07:12:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233608AbjJWLMB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 23 Oct 2023 07:12:01 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFA7F101;
        Mon, 23 Oct 2023 04:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698059518; x=1729595518;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/zmhACeoMkXncXmESuV2wibz9X9jNzCPCfwFPGLqMOg=;
  b=XofpmBfmWcdMnjLSvuzTqkcHlpwyd9PH2pEoM6vkxrc5svketS5zY4Nk
   ZyoVDn5NA2qa31xfXu1tNCaYwRZzhGLPiBuDT6eU8jk8IeZ07tYiKMhth
   vHq0vM3n0HQJlMYIHqo8QXBrqoxszFaoFGfPTZ7eERvLUPnqRL830ukXS
   csx9NbXQUqEBBzNvWaXPvGm8N0SNTP1GKgUM/bDLXnrZRcvczTMm7Un+D
   XcD3k2GU7e/HI9OmTPIv4UTv/pQUEL6IVr/dajAYTSH3yij0Y0Sfk3UH1
   +SPyVyDUlI0PVIdOIU2FYg5WOF83B4Wphj4gVEHN8hhSSCNU0ioCykvXt
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10871"; a="366164203"
X-IronPort-AV: E=Sophos;i="6.03,244,1694761200"; 
   d="scan'208";a="366164203"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2023 04:11:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10871"; a="734635782"
X-IronPort-AV: E=Sophos;i="6.03,244,1694761200"; 
   d="scan'208";a="734635782"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Oct 2023 04:11:57 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 23 Oct 2023 04:11:56 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 23 Oct 2023 04:11:56 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 23 Oct 2023 04:11:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fRKjG13+Zc8/sL2Sr0JxLRTcdRYT5Nqmkp0ZdME57y6bdvyE7gbG2ylKGgMxQB/hKrAngG3lTlm28zpyu8qjytJv577+eQiLWI2WPTfN3aViXJdmfhdE9MNjzWMADLKPdRyuENDUQon0gapqd2WDzW9jnr0A0FZoz5r1eCxXFQ2kkelYOLzDAniFMobu4kKapifFThQxiEkS4No1+3maeQKNGwUspMdYgn42QsAoihjBkohfXmSkK7IH9kleBtHu7GlTEIZ0IoxEeSx6+KG0DHDun1x8jTvH6ZSIqW6DFznQE6y9bbXj4Ew5MoOw+8J23IE9SOzwbH1dFqA6pDVj8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/zmhACeoMkXncXmESuV2wibz9X9jNzCPCfwFPGLqMOg=;
 b=EqZMzX+NVSEHz/9Z+eKbyP6i2IlOyLnfvjrFCyACNiGz3hjXywp76hv+/2yb5q5l/6ZpVxN/HoTyKlfs1frZn6o21Xiv90YzS7kqQbLE0cdP2DWfCGyXi/V6giEEVNxa3NbVOoxJUSWsHb8+lKYdD1xheSTngy86KIVEekC2DkQptwKnl3AWuypOETmUXOyBIWy93xVpDfe/VyIgMN05NWEJNbbL1MIdn4UGh6Dns/b6iny5BF+wd3YCk77Bq+NbW1ORb2HoqEGbG+OLMQlg1HGk1suOdnAowdqSCIrLJ8PwWMKCADdov4vxIwlrF/r8eFb/akCnRnxge+YkqfmNiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by CY5PR11MB6139.namprd11.prod.outlook.com (2603:10b6:930:29::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.31; Mon, 23 Oct
 2023 11:11:53 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::f8f4:bed2:b2f8:cb6b]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::f8f4:bed2:b2f8:cb6b%3]) with mapi id 15.20.6907.025; Mon, 23 Oct 2023
 11:11:53 +0000
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
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
        "Martins, Joao" <joao.m.martins@oracle.com>,
        "Zeng, Xin" <xin.zeng@intel.com>
Subject: RE: [PATCH v6 7/8] iommu/vt-d: Add nested domain allocation
Thread-Topic: [PATCH v6 7/8] iommu/vt-d: Add nested domain allocation
Thread-Index: AQHaAzhu3nomK84rn0eS5cQggIJFcbBTkQmAgAOpCQA=
Date:   Mon, 23 Oct 2023 11:11:53 +0000
Message-ID: <DS0PR11MB7529C791D2B89E1DED570C5EC3D8A@DS0PR11MB7529.namprd11.prod.outlook.com>
References: <20231020093246.17015-1-yi.l.liu@intel.com>
 <20231020093246.17015-8-yi.l.liu@intel.com>
 <20c7880b-613e-4efe-a43b-c3b9c601ba1c@linux.intel.com>
In-Reply-To: <20c7880b-613e-4efe-a43b-c3b9c601ba1c@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB7529:EE_|CY5PR11MB6139:EE_
x-ms-office365-filtering-correlation-id: 46ed295b-9492-4e77-5a70-08dbd3b8dcc6
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NA/oT/j6FvUIDx14KxjGwP6rIBzdxi8IjSLYgEMOTfTrSus1821eHx2+MwpMzlAs1o4RHuaeBkeV/GBxLgF2wS2RhP+ATYoRBfEtqYWHjAYM50R/603kSP5Nd1iJ7yjoE+m0/9pC9iBOOOBd1j0GNp0mKvhdFaoT6gf0n4Q6VnGcvQM79UO8B1vmaZ39X7dK2d7h2kf+jsJfmyndy55gY29yFEa65yxq6/O9wUN3+YpDStWe7yBCFXcwo7BS3KQssZj+an4lHINBsfvyUnVwyaBUDuNr5E9y7S0kpWJJrxG6PLVB9ttZlJ3h69Bgg1NHzshtTkgkkDT3PqlMfgtKpVdvAAJrQoXZlgPHH5AxrJ/lrLdLzeZL6rhIvoKhB5k7TbLfaEDc1g0P1jLwbODksD5qGM/ekV8BTmMOfyr5GkMpmaz0Nv9a9nYUPaMLuA9DLwiA2ap025aqzMDOU6jhOiyjtnk64vyziLr9cDkP/dg1axV0gqP91XHYlxzkQMhF0OsFm5PE8g5+I7+x1Fvvgf2TK4wrNUHcWmY5k1+Aqt49P4HGY3b6pGzmZvkSLBd6TxeyknDll6CAKrXxlZI4wfaD0AfR8zo7IvCC775tyfUFznvLcWILVRVk2gu0qg69
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(366004)(376002)(136003)(39860400002)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(55016003)(2906002)(38100700002)(110136005)(76116006)(66446008)(316002)(64756008)(66556008)(54906003)(66476007)(82960400001)(122000001)(66946007)(7696005)(6506007)(71200400001)(478600001)(53546011)(9686003)(83380400001)(41300700001)(7416002)(52536014)(86362001)(5660300002)(4326008)(33656002)(8936002)(8676002)(38070700009)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dkhiUHJKdVN2RUZFQmVzc2gzanRoalZjM0NGRWhVek4ySzFiNU02cjN5SndS?=
 =?utf-8?B?ajNpeUVwSlZyTjB3dGNDbVZ6azFCZHZMQ2R6d2FicEppYk9jdDhSUFgvZVU5?=
 =?utf-8?B?VEwvYmVacDNIWkw4Uk9ibFFjVHdHSVZrNTRUaVRtUlFSMzYxdTVEQStadXRH?=
 =?utf-8?B?NnM0TGNxMEw5WlRXOFVIdDdZVGpEbHFiMmtJZmlOSG9DMzlBc0xoVTB3dmw2?=
 =?utf-8?B?V1JyZ2UzZWFDMWQ2M1I4VGllTFNJdzVxKzlURUpRMm1ZTE9YTC8vMmxleHN1?=
 =?utf-8?B?eDZKRGE3RmtaRjZ4SFA3SFhXT1ZaaktuaFhIZWxOUVZqZHF1V0Z0UVN4NEJq?=
 =?utf-8?B?Vnl5TGhsbiswcE5Oam5VYm5sQm5xV0tDVmhoRmswcUVBKzFWdFVVL3docmNR?=
 =?utf-8?B?TysyWlNFa0VVcHFHMGpsajZsamVKTm4rWkZqekFUNFIrWW5jald2Z3NtRGRu?=
 =?utf-8?B?SnNYRXBpSGEzQkVkUVJsQ1lxUzBkMVYvV3JiUjllbHovS1Y0cTNwY2kxcVBi?=
 =?utf-8?B?c0tzcTg5anFoTDZTb0ROTHFUekNaR3pCMEVyRzBpNUhwY21NZHhkTU8vU1hh?=
 =?utf-8?B?VGEwWVpVdHcvL0xDTjI4eEZPbmVxZ0dPME1OeGgzbDA5Q1JXR2EwaWN4Ym9E?=
 =?utf-8?B?aWdnRU1LV0NwNllZQVRMV3pLK3hmTURqQlhIQlZFcTVKc1RSdDl1d1JkbEpT?=
 =?utf-8?B?c29GRi9KanpLUXFaWjRhTDEzV0RyUDFZNkptamdiQng4RTlzRk1jWWFZczlq?=
 =?utf-8?B?SnM0eU4ybzFIUm00U2tLTVRYazYxNDA4eGEzczZSc3RTdDBiVngvS1lRWEs2?=
 =?utf-8?B?VkJwaWRpSUErOHZFYzIrWmZuVGEyWDhRQkNFeVlrV1hrY05UTUI2SHR0eXNE?=
 =?utf-8?B?ZENhN2FtZmJqSDZJTkRMZ1d1MnllZGNvYUZIQ0YrN3BSOTZzNWFBRnV4aHI0?=
 =?utf-8?B?NWJ2ZW1XL21OcXUwSlRnbGRmSk5YbjJ0aHRVSzJWeXZ6K0tjRjRFNEZnay9w?=
 =?utf-8?B?YVBGVGUrODdERzN6d0pDb3g5SDBrRWpmMjVKMU0xM2RYeEw5Ry9XUVkyai9I?=
 =?utf-8?B?SnRGYS90V2JRK2R3U0N2blFzYVJoTWgxQkJrSWtWSEZkakxieUtPbGNGejg3?=
 =?utf-8?B?OVVvVm1GQ3dwZk8zMGFqbEJmaUhkRlJOeVRTOXljRzZzWGd0SXJKT2liL09M?=
 =?utf-8?B?VEJEYmNuMmZiTEN4OGh0VU1yaDN6djFGOUJvSFE5cjJTdEVoWnB2Vmlobzda?=
 =?utf-8?B?TC8rS1RqQzZVbDBWazZXT1BIUkorMXN0Z2ZVQ1VRdmUxVzFFN1pVT2FFeGdQ?=
 =?utf-8?B?SDZNNG9YOVFMNDZZdG1sb0dzc2lIZ3FKYTk1c1BEVk5QZlBoQUFLcnlFU1NH?=
 =?utf-8?B?aFpVd25nTWg1YWZrMG9DZUFCVWFmNlhENGtZVXdsdDdLK3BITHA2c0F3cnhN?=
 =?utf-8?B?VzF4Uko3ZW41L21pVUdXOHR3T3dVK01OYlIxdnBOc0VjdE1XYmNWTzN3akkr?=
 =?utf-8?B?d0tzajQ2OFErdzZCM1d2SVdmME9pSjN3SVo1Unowa0puTFdsYURsTlBsWE53?=
 =?utf-8?B?OFNOWTQ3NUp5OCthbHlMb2dNUVZvNmd1cmdkUmRtZGJwa1JFQTBOeVFna1o4?=
 =?utf-8?B?Y2xjajdKdXdndVZ5S2RUSlA1V2NHVkJhTmdqdGhJeS91ME9Ib3FDQ0dEa1ZP?=
 =?utf-8?B?VnZBS0xmaCtFMUkrUW92eU5SQlY5STF4TlFRNElFblZqQWdkbDVSM2FOSjNO?=
 =?utf-8?B?MkUzV0RWdVpiVCtNYUVDNm9zZG4zRDVNT29Tb1NoeE5PMmVML0wwSFRQUmZQ?=
 =?utf-8?B?bHVGWXhXZWZ1V2tERUhmcUR1c2RxVUxiZ2VNeWYvMEhRaEV6Q0xqbHphTlpG?=
 =?utf-8?B?blV5MDJObGtSb0JkbTFXdy85TGZvWSt2RHRrN2RqQVBXU3plQmFneUR6bkw0?=
 =?utf-8?B?MHJJVUlHK0h0SGF2QUVPdFVjYkFxemF2RVRPTE5FbnI5V2JmUktWZExEOGRO?=
 =?utf-8?B?WFR0dml2SVZUbmVDQjBUcjhPT3lub2RPU25Oc0tPTUkvVFArWSt3Z1VZcjVn?=
 =?utf-8?B?VFhFakNtMEVuYUxnQzBCT0Y3YWMvRlRrQXFKVVhXSUFhSjE2bWhIUC91bTJO?=
 =?utf-8?Q?d2V7is+0wV/WrzbNCqz97x60v?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46ed295b-9492-4e77-5a70-08dbd3b8dcc6
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2023 11:11:53.4047
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tUnFB0qiN5UcYtHAH60TJafmsHv1+hBkLk7HkImwptysDZR1BwsSkGDLj+WK9DCH34Npk5P9Q2OuIrRQrpjKLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6139
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

PiBGcm9tOiBCYW9sdSBMdSA8YmFvbHUubHVAbGludXguaW50ZWwuY29tPg0KPiBTZW50OiBTYXR1
cmRheSwgT2N0b2JlciAyMSwgMjAyMyAxMTowOCBBTQ0KPiANCj4gT24gMTAvMjAvMjMgNTozMiBQ
TSwgWWkgTGl1IHdyb3RlOg0KPiA+IEZyb206IEx1IEJhb2x1IDxiYW9sdS5sdUBsaW51eC5pbnRl
bC5jb20+DQo+ID4NCj4gPiBUaGlzIGFkZHMgdGhlIHN1cHBvcnQgZm9yIElPTU1VX0hXUFRfREFU
QV9WVERfUzEgdHlwZS4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEx1IEJhb2x1IDxiYW9sdS5s
dUBsaW51eC5pbnRlbC5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTogWWkgTGl1IDx5aS5sLmxpdUBp
bnRlbC5jb20+DQo+ID4gLS0tDQo+ID4gICBkcml2ZXJzL2lvbW11L2ludGVsL2lvbW11LmMgfCAz
OSArKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tDQo+ID4gICAxIGZpbGUgY2hh
bmdlZCwgMjggaW5zZXJ0aW9ucygrKSwgMTEgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9pb21tdS9pbnRlbC9pb21tdS5jIGIvZHJpdmVycy9pb21tdS9pbnRlbC9p
b21tdS5jDQo+ID4gaW5kZXggYjQ3MDI1ZmJkZWE0Li5jNzcwNGU3ZWZkNGEgMTAwNjQ0DQo+ID4g
LS0tIGEvZHJpdmVycy9pb21tdS9pbnRlbC9pb21tdS5jDQo+ID4gKysrIGIvZHJpdmVycy9pb21t
dS9pbnRlbC9pb21tdS5jDQo+ID4gQEAgLTQwNzYsNyArNDA3Niw3IEBAIGludGVsX2lvbW11X2Rv
bWFpbl9hbGxvY191c2VyKHN0cnVjdCBkZXZpY2UgKmRldiwgdTMyDQo+IGZsYWdzLA0KPiA+ICAg
CQkJICAgICAgc3RydWN0IGlvbW11X2RvbWFpbiAqcGFyZW50LA0KPiA+ICAgCQkJICAgICAgY29u
c3Qgc3RydWN0IGlvbW11X3VzZXJfZGF0YSAqdXNlcl9kYXRhKQ0KPiA+ICAgew0KPiA+IC0Jc3Ry
dWN0IGlvbW11X2RvbWFpbiAqZG9tYWluOw0KPiA+ICsJYm9vbCByZXF1ZXN0X25lc3RfcGFyZW50
ID0gZmxhZ3MgJiBJT01NVV9IV1BUX0FMTE9DX05FU1RfUEFSRU5UOw0KPiA+ICAgCXN0cnVjdCBp
bnRlbF9pb21tdSAqaW9tbXU7DQo+ID4NCj4gPiAgIAlpZiAoZmxhZ3MgJiAofklPTU1VX0hXUFRf
QUxMT0NfTkVTVF9QQVJFTlQpKQ0KPiA+IEBAIC00MDg2LDE4ICs0MDg2LDM1IEBAIGludGVsX2lv
bW11X2RvbWFpbl9hbGxvY191c2VyKHN0cnVjdCBkZXZpY2UgKmRldiwgdTMyDQo+IGZsYWdzLA0K
PiA+ICAgCWlmICghaW9tbXUpDQo+ID4gICAJCXJldHVybiBFUlJfUFRSKC1FTk9ERVYpOw0KPiA+
DQo+ID4gLQlpZiAoKGZsYWdzICYgSU9NTVVfSFdQVF9BTExPQ19ORVNUX1BBUkVOVCkgJiYgIWVj
YXBfbmVzdChpb21tdS0NCj4gPmVjYXApKQ0KPiA+ICsJaWYgKCF1c2VyX2RhdGEpIHsgLyogTXVz
dCBiZSBQQUdJTkcgZG9tYWluICovDQo+ID4gKwkJc3RydWN0IGlvbW11X2RvbWFpbiAqZG9tYWlu
Ow0KPiA+ICsNCj4gPiArCQlpZiAocmVxdWVzdF9uZXN0X3BhcmVudCAmJiAhZWNhcF9uZXN0KGlv
bW11LT5lY2FwKSkNCj4gDQo+IEhhcmR3YXJlIGNhcGFiaWxpdHkgaXMgbm90IHN1ZmZpY2llbnQu
IEhvdyBhYm91dCBhZGRpbmcgYmVsb3cgaGVscGVyOg0KDQpZZXMuIEJ1dCB0aGUgc21fc3VwcG9y
dGVkKCkgc2VlbXMgYSBiaXQgY29uZnVzaW5nLiBJcyBpdD8gYWN0dWFsbHksIGl0J3MNCmEgY29t
YmluZWQgY2hlY2sgb2YgdGhlIHNtIGNhcGFiaWxpdHkgYW5kIHNvZnR3YXJlIGNob2ljZSAodXNl
IHNtIG9yDQpub3QpLiBIb3cgYWJvdXQgcmVuYW1pbmcgaXQgdG8gYmUgc21fZW5hYmxlZCgpPyBB
bHRob3VnaCB0aGUgYmVzdA0KZW5hYmxlIHN0YXR1cyBjaGVjayBpcyB0byByZWFkIHRoZSBTTSBi
aXQgaW4gcm9vdCBhZGRyZXNzIHJlZ2lzdGVyLiBObyBodXJyeQ0KaW4gdGhpcyBjaXJjbGUsIGJ1
dCBtYXkgYmUgbmljZSB0byBoYXZlLg0KDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lvbW11L2lu
dGVsL2lvbW11LmggYi9kcml2ZXJzL2lvbW11L2ludGVsL2lvbW11LmgNCj4gaW5kZXggYjVmMzNh
N2MxOTczLi5iMDRiYmFiY2Q2OTYgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvaW9tbXUvaW50ZWwv
aW9tbXUuaA0KPiArKysgYi9kcml2ZXJzL2lvbW11L2ludGVsL2lvbW11LmgNCj4gQEAgLTU0MCw2
ICs1NDAsOCBAQCBlbnVtIHsNCj4gICAjZGVmaW5lIHNtX3N1cHBvcnRlZChpb21tdSkgICAgKGlu
dGVsX2lvbW11X3NtICYmDQo+IGVjYXBfc210cygoaW9tbXUpLT5lY2FwKSkNCj4gICAjZGVmaW5l
IHBhc2lkX3N1cHBvcnRlZChpb21tdSkgKHNtX3N1cHBvcnRlZChpb21tdSkgJiYgICAgICAgICAg
ICAgICAgIFwNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGVjYXBfcGFzaWQo
KGlvbW11KS0+ZWNhcCkpDQo+ICsjZGVmaW5lIG5lc3RlZF9zdXBwb3J0ZWQoaW9tbXUpICAgICAg
ICAoc21fc3VwcG9ydGVkKGlvbW11KSAmJg0KPiAgICAgICAgIFwNCj4gKyAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgZWNhcF9uZXN0KChpb21tdSktPmVjYXApKQ0KPiANCj4gICBzdHJ1
Y3QgcGFzaWRfZW50cnk7DQo+ICAgc3RydWN0IHBhc2lkX3N0YXRlX2VudHJ5Ow0KPiANCj4gQW5k
LCB1c2UgbmVzdGVkX3N1cHBvcnRlZCgpIGhlcmUgYW5kIGJsZW93DQo+IA0KPiA+ICsJCQlyZXR1
cm4gRVJSX1BUUigtRU9QTk9UU1VQUCk7DQo+ID4gKwkJaWYgKHBhcmVudCkNCj4gPiArCQkJcmV0
dXJuIEVSUl9QVFIoLUVJTlZBTCk7DQo+ID4gKwkJLyoNCj4gPiArCQkgKiBkb21haW5fYWxsb2Nf
dXNlciBvcCBuZWVkcyB0byBmdWxseSBpbml0aWFsaXplIGEgZG9tYWluDQo+ID4gKwkJICogYmVm
b3JlIHJldHVybiwgc28gdXNlcyBpb21tdV9kb21haW5fYWxsb2MoKSBoZXJlIGZvcg0KPiA+ICsJ
CSAqIHNpbXBsZS4NCj4gPiArCQkgKi8NCj4gPiArCQlkb21haW4gPSBpb21tdV9kb21haW5fYWxs
b2MoZGV2LT5idXMpOw0KPiA+ICsJCWlmICghZG9tYWluKQ0KPiA+ICsJCQlyZXR1cm4gRVJSX1BU
UigtRU5PTUVNKTsNCj4gPiArCQlyZXR1cm4gZG9tYWluOw0KPiA+ICsJfQ0KPiA+ICsNCj4gPiAr
CS8qIE11c3QgYmUgbmVzdGVkIGRvbWFpbiAqLw0KPiA+ICsJaWYgKCFlY2FwX25lc3QoaW9tbXUt
PmVjYXApKQ0KPiANCj4gLi4uaGVyZS4NCj4gDQo+ID4gKwkJcmV0dXJuIEVSUl9QVFIoLUVPUE5P
VFNVUFApOw0KPiA+ICsJaWYgKHVzZXJfZGF0YS0+dHlwZSAhPSBJT01NVV9IV1BUX0RBVEFfVlRE
X1MxKQ0KPiA+ICAgCQlyZXR1cm4gRVJSX1BUUigtRU9QTk9UU1VQUCk7DQo+ID4gKwlpZiAoIXBh
cmVudCB8fCBwYXJlbnQtPm9wcyAhPSBpbnRlbF9pb21tdV9vcHMuZGVmYXVsdF9kb21haW5fb3Bz
KQ0KPiA+ICsJCXJldHVybiBFUlJfUFRSKC1FSU5WQUwpOw0KPiA+ICsJaWYgKHJlcXVlc3RfbmVz
dF9wYXJlbnQpDQo+ID4gKwkJcmV0dXJuIEVSUl9QVFIoLUVJTlZBTCk7DQo+ID4NCj4gPiAtCS8q
DQo+ID4gLQkgKiBkb21haW5fYWxsb2NfdXNlciBvcCBuZWVkcyB0byBmdWxseSBpbml0aWFsaXpl
IGEgZG9tYWluDQo+ID4gLQkgKiBiZWZvcmUgcmV0dXJuLCBzbyB1c2VzIGlvbW11X2RvbWFpbl9h
bGxvYygpIGhlcmUgZm9yDQo+ID4gLQkgKiBzaW1wbGUuDQo+ID4gLQkgKi8NCj4gPiAtCWRvbWFp
biA9IGlvbW11X2RvbWFpbl9hbGxvYyhkZXYtPmJ1cyk7DQo+ID4gLQlpZiAoIWRvbWFpbikNCj4g
PiAtCQlkb21haW4gPSBFUlJfUFRSKC1FTk9NRU0pOw0KPiA+IC0JcmV0dXJuIGRvbWFpbjsNCj4g
PiArCXJldHVybiBpbnRlbF9uZXN0ZWRfZG9tYWluX2FsbG9jKHBhcmVudCwgdXNlcl9kYXRhKTsN
Cj4gPiAgIH0NCj4gPg0KPiA+ICAgc3RhdGljIHZvaWQgaW50ZWxfaW9tbXVfZG9tYWluX2ZyZWUo
c3RydWN0IGlvbW11X2RvbWFpbiAqZG9tYWluKQ0KPiANCj4gQmVzdCByZWdhcmRzLA0KPiBiYW9s
dQ0K
