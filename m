Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EE547D3203
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Oct 2023 13:15:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233721AbjJWLPr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 23 Oct 2023 07:15:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233715AbjJWLPq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 23 Oct 2023 07:15:46 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D6E7C5;
        Mon, 23 Oct 2023 04:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698059743; x=1729595743;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=J2DFTH9VL/B5GJkFC+hD96PuZNskoqZTpLSQixK6+xE=;
  b=YCwGRSERzQQ5QUStvrv2Fv85uO8/enrp3jGqmZBya6SxC0gB68d6TXP2
   nBfM4eZ9S7uAKHvCHnoVe72LQkZtJL/mv9zRIilo9LrSn5LKTDq0ptZ/g
   nL3sjc1i+72JJEunIfNp+q+ofAz4FTadQGBtP25btVcjTYzO22cLlslr+
   rFTXzqmFI79mwUNm6+lOBZDUcIfzDCoQ1mZQqqRYwlkE1LoAOSNuJ88Ry
   cBG7BD9+ECBZbqwAJ3YLodCjHKDIKG+61mHNYmjv3ZcFHUfd9NSYCxFm4
   qT0rIzd6JClpl/lwlezcLQxg8uIwKIDTwD06FvQRqa2J9MR79pGGAzmTG
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10871"; a="384015494"
X-IronPort-AV: E=Sophos;i="6.03,244,1694761200"; 
   d="scan'208";a="384015494"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2023 04:15:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10871"; a="1005280628"
X-IronPort-AV: E=Sophos;i="6.03,244,1694761200"; 
   d="scan'208";a="1005280628"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Oct 2023 04:15:43 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 23 Oct 2023 04:15:42 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 23 Oct 2023 04:15:42 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 23 Oct 2023 04:15:42 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 23 Oct 2023 04:15:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D4ufEwEsz8EwUkuzqHRHq+09lwZlbOJL+t7Pu5tSclDV+Y4ww0yOaqhnSNRTPuzMDb+i9Hu+AM0kWZTGt9j7iEL1uQAIL54SxpQNTqgNhS2BAOpd5znPg1unLwMWPgSSV7SDLNlNx0gCHFBt+U4QMrdcOvk6xcqH8hD1RSf91RapdZAgKpoyNyAJPWtWav0iEg73/DuVVxuZxWN/Y273yP5bf7kVpDCagCyXHIDuctLSXP1jSM1YVJ8gV6HH2vHkM271vHyg70otYnW8wpDGTrGn6PMCGJFKBj/rZWj1/e4HmiF7C55LviCdC8NTPtZoE0uI1Seutifd0Lry7gH4uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J2DFTH9VL/B5GJkFC+hD96PuZNskoqZTpLSQixK6+xE=;
 b=BELT2pTH0FePrFR0sxTLJ8slT9sqsXlYyX5HtVVYdsIjR35AdMs5sdmgK9CojmujMwE4ViAULvdpSoKgWq7SqNTeTQETkbgNxuC+UggA+bM0v0xDmceagOSDD9vIIYj9jcoxwpXwE5VOc8U7SEsPJpzfQM6uP9oWgxir/RPdRYrXHDnzQ+DVUsuKYV/L/9zANO9HhEFL8NIDOuyrb6Lw3kIjBE5fFRH7lgaRQ5i21lKJvHcWexJFmyqqheS2YFCZvAeZyuoi8h1EhhDHRa3G6eaLnRhKB7zYvaRMuS+uqQJOL6Vzx20lkZQExhdbODOZoWcjmHwpJv/Hs3jBvE6NsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by MN2PR11MB4567.namprd11.prod.outlook.com (2603:10b6:208:26d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.31; Mon, 23 Oct
 2023 11:15:38 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::f8f4:bed2:b2f8:cb6b]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::f8f4:bed2:b2f8:cb6b%3]) with mapi id 15.20.6907.025; Mon, 23 Oct 2023
 11:15:38 +0000
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
Subject: RE: [PATCH v6 8/8] iommu/vt-d: Disallow read-only mappings to nest
 parent domain
Thread-Topic: [PATCH v6 8/8] iommu/vt-d: Disallow read-only mappings to nest
 parent domain
Thread-Index: AQHaAzhwl7VoudF1h0uHI7SB5pBrdbBTlbGAgAOntGA=
Date:   Mon, 23 Oct 2023 11:15:38 +0000
Message-ID: <DS0PR11MB752977275A0791296C115FE6C3D8A@DS0PR11MB7529.namprd11.prod.outlook.com>
References: <20231020093246.17015-1-yi.l.liu@intel.com>
 <20231020093246.17015-9-yi.l.liu@intel.com>
 <23133231-c6d7-469e-8f55-2e7667acb097@linux.intel.com>
In-Reply-To: <23133231-c6d7-469e-8f55-2e7667acb097@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB7529:EE_|MN2PR11MB4567:EE_
x-ms-office365-filtering-correlation-id: 75f911fc-4c0e-465e-a7a3-08dbd3b962f3
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +PvspjbTsgQGK4imYR1c3Y9zoDoaWorqRdl9IBCNWv5eVbspQjspDwEEal4dwszA5SbA4rsjAYSe1Yfm0yU/FpEYoI73y9FCosE5LuFsChOl1JgbB2qb1fMKLziQ+QGFFMaeFQSeyvSNPqUtsO8p2+IXJhNLCWyMC8hNLNLcVzZ2cn0VQmf934wYyTuRo1we2NqG/n8o4YBCeyKW5nhZOd9Pohq3JId4sUGIaFef9CMMiYGEkvofnHeptioPfeJara8TS3snGkT37hSSczltLO9pQa3BgrLCgs3FIQPdv9shPi6PCnCqN+VsB7lmyNllRTiOATZsYvA/zANRXFW6dMcBx1pq+2rxvTH1KBppazHR3woOltifkYWDm0JFdW0AqOEs3CY8g4uEFXyJ7YrYfuTJMjRLLo8J7JfgIAJ1pQY5014quxUpvstFLksz1aJPBgXMATwh62iSJ0/odW8ShT+eIScbqfI7yaLTj+c3myxcP0QqIxZYyiwFxvL6EYMVziV24NfpsnLlDCU4zLqjBI+F4/B7sXhUorg08cEDM6qELYszRKocpwIdDooL/sPj0JdaU1DCyEDkubViPIc2GWqmG24krgV7khs7WB1prfwp/isrMTxvpe3GIYpPqcHZRFtO0ww8B7tJeAUmL5P/hQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(346002)(136003)(39860400002)(376002)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(2906002)(38100700002)(55016003)(66476007)(110136005)(316002)(66446008)(64756008)(76116006)(66556008)(54906003)(122000001)(66946007)(82960400001)(7696005)(6506007)(71200400001)(478600001)(966005)(53546011)(9686003)(83380400001)(7416002)(86362001)(52536014)(4326008)(5660300002)(33656002)(8936002)(8676002)(41300700001)(38070700009)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YmJjTkhHN2xlUFB4Z2lxN3FsYjJIdDVsLy9sUUlQM1VrYk1IVEdHbVNFYnBk?=
 =?utf-8?B?NnU4OVNLZmE1ZUtidnplU2hUS1FlS2tZaCs0L0JWeDVoUDkyMGd5Qm1pR21I?=
 =?utf-8?B?TjVFZVU5QkUveHY2cDFIVUlyZVF0L2kzVkFQalJjYzNRZUZIMmIwczBWRmRw?=
 =?utf-8?B?U25CSHJZek9SWWFoYThoTGd4aTFMZGxzbFNtbEl1U0FScE9KVmI4N1QxSjRu?=
 =?utf-8?B?ZlVjMy9ta1BlMzU1dGZMMmxwOEIydlpMc3Exc3dRdVcva0YyZVRJOThPclZz?=
 =?utf-8?B?MTJFMkVtdkZ4VGRRbjdReUU3UDV0N3cvQU1VWWIrVzNVRExwSDUyWWV1SUcy?=
 =?utf-8?B?N2tPVFllcUJOWk9LTXhEa0QwTVkwUlF2OW5ibHFScjVrd3Y4eFdvZlRVa3ly?=
 =?utf-8?B?TnV0ZGtpRGVLd0ZUQjdCb3hSTEk5NXBhc1QwQ09lemlsTDUvc3NJM1BEK1Fm?=
 =?utf-8?B?UlJFdU5CdXJpUktuYWw4M0lObi9FbWMwT0F2VW5oT251aGVLTk5jOTNuZ1Ji?=
 =?utf-8?B?VnlXby9BaEFjaXNFZ3NnV1BvbFRjbmExNGlvbnNCYmVXUTRLVzFsVDYzY25M?=
 =?utf-8?B?S2szandzK2ZyOWtmb3FkcnhkL1JJWTlJQ1dESEYxL2hQOGJHczl1WHE5VXlk?=
 =?utf-8?B?bit6bFVrN0pWaFMyUUtvZmRBOG1sNmx0NTdlUk56SmxBTkZzZkd4KzJSQU9k?=
 =?utf-8?B?cFBoMzBFTFh6YkFNK3F3WUtrR1JMeXhwSUNqMW5MS0NyeCtUSzhoYjMxQW9H?=
 =?utf-8?B?M0N1cCtjOUN3WXVtcFhtcjArdVVRRk51U0NrcEZMMzd5bFJqSTZGemRmSk9y?=
 =?utf-8?B?N0lKN3J0UXB5Zno2c1FRQkxKeTVtdVVsOVJrUm1taExOTy94YzI2c2luQ25F?=
 =?utf-8?B?QWdRUE5XcnJuMTVHbStjb082RWVBL1lDMUc2N0Y3ajBrZzlaei81TnBUL0d0?=
 =?utf-8?B?TFhKMVpVUlpkQTIrdWZnTlR3bHY1alNNRUlDWGpOYTJPQjQrWUJ0TUl4ckhB?=
 =?utf-8?B?QUc4MkVjaU5jUXlhWFRVdVJkUWk4TVdONDJXVGlFeTFUMUpmckhMR0U5dGtK?=
 =?utf-8?B?YnBNOUtxVGN1citsYWF6ZE1DdDdxa0pZYWtwOE14a0Z6WnY4N29mZ0NCT2lX?=
 =?utf-8?B?UEE4Q3Frd1JuaHF2NVg4WWZtL3RRci9kNjNTNzBCWnBoOUtHTlB4cFowdVVm?=
 =?utf-8?B?dHpaYXlKWUIyRzdML1ZlK0UzY1ZnRWdTU1ZZckE5cVZabTNZakRmTnViUEdU?=
 =?utf-8?B?TGh6QXp0UytHZzdOSEVScjNhNTEyWFZXZFpEQ0FWeDRad0ZhMTh2bjlNQ3My?=
 =?utf-8?B?Y0l5SlArR1BQNGxPdFBIUDhiR3M2bmFoN3MxS1hHMHpvVlh1RjU1aU56M3Mz?=
 =?utf-8?B?cDIzajM0enU0eGpHdmJMZVZHcCtTZDdaWW80Z0ZHQVdKTy9XMUwxZXF5TXFP?=
 =?utf-8?B?UGdQTkJwR2NTWjE1V3lna1ZOam9JMm0wbTVQTkZOMW5oWGs3Vm4xNDlLTlFs?=
 =?utf-8?B?cEhNUzYzc3U0MnZZWGZzL1ZJL1g5Zjd1bnF4YVk5ZTVMRzFKNkdwWXVHcHlh?=
 =?utf-8?B?QTd6MkRqMUozSFYrUnh6YW5GNmR1aGh1UlFqN1FndmhrT015WFhTU0NmRis4?=
 =?utf-8?B?d3VXZVh3VmdPWE1JeG04WW1PMnVNeDdZUmVhMXFXcEJQeElyMFVkN3FHaW51?=
 =?utf-8?B?MnRKaE9JSUJWZndmSGpZcnlpRWFzenJrY3Rjem9Fb1lLc1lYNFU3KzZZR2lq?=
 =?utf-8?B?TlhPODhWTmJZbk85bzgxaUhCM0s3V21CeTE1b0I3Y3JMSWxad01XRDV1OHV0?=
 =?utf-8?B?bFVhZ2NmekhJb1k2TTBQQ0xCL3BzVVlmeFpMdktrdnViQWZNcWYwWG5HS01W?=
 =?utf-8?B?b05uV093RzV5K0lycmIwWTU0NDFhT2Q3WVNmOEdJTUtsckRzcEpVRjNPdjNk?=
 =?utf-8?B?SEdEWFA1WGpaSmpOZi9YdXJzcEZEQkJFRWxkVzdkdTVadGorb1pRT28wS3o5?=
 =?utf-8?B?OVc1MGoxTEtDVnN4Wm9mbWxoYmpoaERSZ1dhM0NlaE9JU0Izeno5YjNrVk9l?=
 =?utf-8?B?bVR3TlpjZlJDUUhneUFIbndZRHJneUtTUmpVWG8xcDhGRmFKdDIrNWZNNWQx?=
 =?utf-8?Q?0SjoRRK+9XJdSTKJ8lO8MhMW8?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75f911fc-4c0e-465e-a7a3-08dbd3b962f3
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2023 11:15:38.5224
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ErGaPoeXpQDMn+je7hKreq37StkGP9ckG26W1xKrmnoZc7/Iff8yG4u1GFiGYzhkR+FTG2mfH4N/+T2ZDMzUyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4567
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

PiBGcm9tOiBCYW9sdSBMdSA8YmFvbHUubHVAbGludXguaW50ZWwuY29tPg0KPiBTZW50OiBTYXR1
cmRheSwgT2N0b2JlciAyMSwgMjAyMyAxMToyNCBBTQ0KPiANCj4gT24gMTAvMjAvMjMgNTozMiBQ
TSwgWWkgTGl1IHdyb3RlOg0KPiA+IEZyb206IEx1IEJhb2x1IDxiYW9sdS5sdUBsaW51eC5pbnRl
bC5jb20+DQo+ID4NCj4gPiBXaGVuIHJlbWFwcGluZyBoYXJkd2FyZSBpcyBjb25maWd1cmVkIGJ5
IHN5c3RlbSBzb2Z0d2FyZSBpbiBzY2FsYWJsZSBtb2RlDQo+ID4gYXMgTmVzdGVkIChQR1RUPTAx
MWIpIGFuZCB3aXRoIFBXU05QIGZpZWxkIFNldCBpbiB0aGUgUEFTSUQtdGFibGUtZW50cnksDQo+
ID4gaXQgbWF5IFNldCBBY2Nlc3NlZCBiaXQgYW5kIERpcnR5IGJpdCAoYW5kIEV4dGVuZGVkIEFj
Y2VzcyBiaXQgaWYgZW5hYmxlZCkNCj4gPiBpbiBmaXJzdC1zdGFnZSBwYWdlLXRhYmxlIGVudHJp
ZXMgZXZlbiB3aGVuIHNlY29uZC1zdGFnZSBtYXBwaW5ncyBpbmRpY2F0ZQ0KPiA+IHRoYXQgY29y
cmVzcG9uZGluZyBmaXJzdC1zdGFnZSBwYWdlLXRhYmxlIGlzIFJlYWQtT25seS4NCj4gPg0KPiA+
IEFzIHRoZSByZXN1bHQsIGNvbnRlbnRzIG9mIHBhZ2VzIGRlc2lnbmF0ZWQgYnkgVk1NIGFzIFJl
YWQtT25seSBjYW4gYmUNCj4gPiBtb2RpZmllZCBieSBJT01NVSB2aWEgUE1MNUUgKFBNTDRFIGZv
ciA0LWxldmVsIHRhYmxlcykgYWNjZXNzIGFzIHBhcnQgb2YNCj4gPiBhZGRyZXNzIHRyYW5zbGF0
aW9uIHByb2Nlc3MgZHVlIHRvIERNQXMgaXNzdWVkIGJ5IEd1ZXN0Lg0KPiA+DQo+ID4gVGhpcyBk
aXNhbGxvd3MgcmVhZC1vbmx5IG1hcHBpbmdzIGluIHRoZSBkb21haW4gdGhhdCBpcyBzdXBwb3Nl
ZCB0byBiZSB1c2VkDQo+ID4gYXMgbmVzdGVkIHBhcmVudC4gUmVmZXJlbmNlIGZyb20gU2FwcGhp
cmUgUmFwaWRzIFNwZWNpZmljYXRpb24gVXBkYXRlIFsxXSwNCj4gPiBlcnJhdGEgZGV0YWlscywg
U1BSMTcuIFVzZXJzcGFjZSBzaG91bGQga25vdyB0aGlzIGxpbWl0YXRpb24gYnkgY2hlY2tpbmcN
Cj4gPiB0aGUgSU9NTVVfSFdfSU5GT19WVERfRVJSQVRBXzc3MjQxNV9TUFIxNyBmbGFnIHJlcG9y
dGVkIGluIHRoZQ0KPiBJT01NVV9HRVRfSFdfSU5GTw0KPiA+IGlvY3RsLg0KPiA+DQo+ID4gWzFd
IGh0dHBzOi8vd3d3LmludGVsLmNvbS9jb250ZW50L3d3dy91cy9lbi9jb250ZW50LWRldGFpbHMv
NzcyNDE1L2NvbnRlbnQtDQo+IGRldGFpbHMuaHRtbA0KPiA+DQo+ID4gUmV2aWV3ZWQtYnk6IEtl
dmluIFRpYW4gPGtldmluLnRpYW5AaW50ZWwuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEx1IEJh
b2x1IDxiYW9sdS5sdUBsaW51eC5pbnRlbC5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTogWWkgTGl1
IDx5aS5sLmxpdUBpbnRlbC5jb20+DQo+ID4gLS0tDQo+ID4gICBkcml2ZXJzL2lvbW11L2ludGVs
L2lvbW11LmMgIHwgIDkgKysrKysrKysrDQo+ID4gICBkcml2ZXJzL2lvbW11L2ludGVsL2lvbW11
LmggIHwgIDEgKw0KPiA+ICAgaW5jbHVkZS91YXBpL2xpbnV4L2lvbW11ZmQuaCB8IDEyICsrKysr
KysrKysrLQ0KPiA+ICAgMyBmaWxlcyBjaGFuZ2VkLCAyMSBpbnNlcnRpb25zKCspLCAxIGRlbGV0
aW9uKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pb21tdS9pbnRlbC9pb21tdS5j
IGIvZHJpdmVycy9pb21tdS9pbnRlbC9pb21tdS5jDQo+ID4gaW5kZXggYzc3MDRlN2VmZDRhLi5h
MDM0MWEwNjlmYmYgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9pb21tdS9pbnRlbC9pb21tdS5j
DQo+ID4gKysrIGIvZHJpdmVycy9pb21tdS9pbnRlbC9pb21tdS5jDQo+ID4gQEAgLTIxOTMsNiAr
MjE5MywxMSBAQCBfX2RvbWFpbl9tYXBwaW5nKHN0cnVjdCBkbWFyX2RvbWFpbiAqZG9tYWluLA0K
PiB1bnNpZ25lZCBsb25nIGlvdl9wZm4sDQo+ID4gICAJaWYgKChwcm90ICYgKERNQV9QVEVfUkVB
RHxETUFfUFRFX1dSSVRFKSkgPT0gMCkNCj4gPiAgIAkJcmV0dXJuIC1FSU5WQUw7DQo+ID4NCj4g
PiArCWlmICghKHByb3QgJiBETUFfUFRFX1dSSVRFKSAmJiBkb21haW4tPmlzX25lc3RlZF9wYXJl
bnQpIHsNCj4gPiArCQlwcl9lcnJfcmF0ZWxpbWl0ZWQoIlJlYWQtb25seSBtYXBwaW5nIGlzIGRp
c2FsbG93ZWQgb24gdGhlIGRvbWFpbg0KPiB3aGljaCBzZXJ2ZXMgYXMgdGhlIHBhcmVudCBpbiBh
IG5lc3RlZCBjb25maWd1cmF0aW9uLCBkdWUgdG8gSFcgZXJyYXRhDQo+IChFUlJBVEFfNzcyNDE1
X1NQUjE3KVxuIik7DQo+ID4gKwkJcmV0dXJuIC1FSU5WQUw7DQo+ID4gKwl9DQo+ID4gKw0KPiA+
ICAgCWF0dHIgPSBwcm90ICYgKERNQV9QVEVfUkVBRCB8IERNQV9QVEVfV1JJVEUgfCBETUFfUFRF
X1NOUCk7DQo+ID4gICAJYXR0ciB8PSBETUFfRkxfUFRFX1BSRVNFTlQ7DQo+ID4gICAJaWYgKGRv
bWFpbi0+dXNlX2ZpcnN0X2xldmVsKSB7DQo+ID4gQEAgLTQxMDEsNiArNDEwNiw5IEBAIGludGVs
X2lvbW11X2RvbWFpbl9hbGxvY191c2VyKHN0cnVjdCBkZXZpY2UgKmRldiwgdTMyDQo+IGZsYWdz
LA0KPiA+ICAgCQlkb21haW4gPSBpb21tdV9kb21haW5fYWxsb2MoZGV2LT5idXMpOw0KPiA+ICAg
CQlpZiAoIWRvbWFpbikNCj4gPiAgIAkJCXJldHVybiBFUlJfUFRSKC1FTk9NRU0pOw0KPiA+ICsJ
CWNvbnRhaW5lcl9vZihkb21haW4sDQo+ID4gKwkJCSAgICAgc3RydWN0IGRtYXJfZG9tYWluLA0K
PiA+ICsJCQkgICAgIGRvbWFpbiktPmlzX25lc3RlZF9wYXJlbnQgPSByZXF1ZXN0X25lc3RfcGFy
ZW50Ow0KPiANCj4gSG93IGFib3V0DQo+IAkJdG9fZG1hcl9kb21haW4oZG9tYWluKS0+aXNfbmVz
dGVkX3BhcmVudCA9IC4uLjsNCj4gPw0KDQpZZXMuDQoNCj4gDQo+IEkgd291bGQgYWxzbyBwcmVm
ZXIgdG8gaW50cm9kdWNlIGlzX25lc3RlZF9wYXJlbnRfZG9tYWluIHRvIHRoZSB1c2VyDQo+IGRv
bWFpbiBhbGxvY2F0aW9uIHBhdGNoIChwYXRjaCA3LzgpLiBUaGlzIGZpZWxkIHNob3VsZCBiZSBj
aGVja2VkIHdoZW4NCj4gYWxsb2NhdGluZyBhIG5lc3RlZCB1c2VyIGRvbWFpbi4NCg0KQSBjdHVh
bGx5LCBubyBuZWVkLiBUaGlzIHNob3VsZCBiZSBhIGNvbW1vbiBjaGVjaywgc28gaW9tbXVmZCBj
b3JlIGFscmVhZHkNCmhhcyB0aGUgY2hlY2suIFNvIHRoZSBwYXJlbnQgc2hvdWxkIGJlIGEgbmVz
dCBwYXJlbnQgZG9tYWluLCBvdGhlcndpc2UgYWxyZWFkeQ0KcmV0dXJuZWQgaW4gaW9tbXVmZC4N
Cg0KKwlpZiAoIXBhcmVudC0+bmVzdF9wYXJlbnQpDQorCQlyZXR1cm4gRVJSX1BUUigtRUlOVkFM
KTsNCg0KaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtaW9tbXUvMjAyMzEwMjAwOTE5NDYu
MTIxNzMtOC15aS5sLmxpdUBpbnRlbC5jb20vDQoNCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW9t
bXUvaW50ZWwvaW9tbXUuYyBiL2RyaXZlcnMvaW9tbXUvaW50ZWwvaW9tbXUuYw0KPiBpbmRleCA4
ZjgxYTVjOWZjYzAuLmQzZjZiYzFmNjU5MCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9pb21tdS9p
bnRlbC9pb21tdS5jDQo+ICsrKyBiL2RyaXZlcnMvaW9tbXUvaW50ZWwvaW9tbXUuYw0KPiBAQCAt
NDEyMSw2ICs0MTIxLDggQEAgaW50ZWxfaW9tbXVfZG9tYWluX2FsbG9jX3VzZXIoc3RydWN0IGRl
dmljZSAqZGV2LA0KPiB1MzIgZmxhZ3MsDQo+ICAgICAgICAgICAgICAgICAgcmV0dXJuIEVSUl9Q
VFIoLUVJTlZBTCk7DQo+ICAgICAgICAgIGlmIChyZXF1ZXN0X25lc3RfcGFyZW50KQ0KPiAgICAg
ICAgICAgICAgICAgIHJldHVybiBFUlJfUFRSKC1FSU5WQUwpOw0KPiArICAgICAgIGlmICghdG9f
ZG1hcl9kb21haW4ocGFyZW50KS0+aXNfbmVzdGVkX3BhcmVudCkNCj4gKyAgICAgICAgICAgICAg
IHJldHVybiBFUlJfUFRSKC1FSU5WQUwpOw0KPiANCj4gICAgICAgICAgcmV0dXJuIGludGVsX25l
c3RlZF9kb21haW5fYWxsb2MocGFyZW50LCB1c2VyX2RhdGEpOw0KPiAgIH0NCj4gDQo+IEJlc3Qg
cmVnYXJkcywNCj4gYmFvbHUNCg==
