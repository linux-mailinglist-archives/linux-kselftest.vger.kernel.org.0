Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E552676FA33
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Aug 2023 08:37:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233311AbjHDGhR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 4 Aug 2023 02:37:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233344AbjHDGhB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 4 Aug 2023 02:37:01 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 144C146A8;
        Thu,  3 Aug 2023 23:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691131013; x=1722667013;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Je63kurmjyA/vAtMTAnDLQswSWkn2HEqNz1j/hPqaMA=;
  b=SwhKU+SdXBKjR5bE8o5fWBCjngKWk5badcLmAhYteWfMmhjqr9vX0Vc4
   FzZf2UU9BN9h9TEehhiNVxFYUJ7Ah3oZpmmYf0zSzaNeJuzRBgeqZsT6G
   C6Xds7viZyGaVuZU0vwhyMt1GVFP7cAqqOLBK1nKBdd5uhqoRDRkKLc8J
   5BBmcW+oGFV89O9aFEQ0+sEug7HvOiDdNvbuJJdCoJpYXNCMPp4pqCg2b
   e3EO4oOWoQpHVioWqxUd/tvWdNbVx+R/I9Mdk2APR4YIQez+dDhQpU32j
   LqXEwPdJiOprHrEKAJXyeJ78PcSzpttjWi+UAemRtuI0cP6b8dlwBZcyW
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10791"; a="373728412"
X-IronPort-AV: E=Sophos;i="6.01,254,1684825200"; 
   d="scan'208";a="373728412"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2023 23:36:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10791"; a="679792001"
X-IronPort-AV: E=Sophos;i="6.01,254,1684825200"; 
   d="scan'208";a="679792001"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga003.jf.intel.com with ESMTP; 03 Aug 2023 23:36:39 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 3 Aug 2023 23:36:38 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 3 Aug 2023 23:36:38 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 3 Aug 2023 23:36:38 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.175)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 3 Aug 2023 23:36:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mtjpNfdJIvfbPZCeuqt08tRzbacAOwMecKpA+dgfn9DfAVrQK/t/s6O41dKLWZoPwuDL8LDQ7yunPao8haPZniizawmWt9TPjNMpzWxlcwpH2jszdeLOq9QPneRD0snDmLvV3ngg3Ks0uaIZZbc75hkAriu7wEM8EJywCnFcCBP+ENj47Ma81uqedfjTuTqsTiU2DpR28EklaEZc8ZpGdUdEeX8mGrkj0yxa9LOGqpSk9BWv0JJ92ZlXCJ5ldD7R8CVbklFCD1l6/fQYJmZgFNC1GsEOUhThyq/ZSdQXb9QQe/letW16umHg1PLuMXNVWfzG9bCFjmHrTcTgjKXdpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Je63kurmjyA/vAtMTAnDLQswSWkn2HEqNz1j/hPqaMA=;
 b=bRD7l34njjwRUvs9Iz+wxpJcGuKtjFmTy0OKvSVAnLmpbte1GzO7ghlaLJTs4ZwwVfiBa8c/P/WM5jlJhNxd/k1h4Ni+cEcewTf2jN5rARzHG45v0YLo5/NqBUHx+s6OYLWlm79AQdsf6ll6+/TUXEmaKlLhOTqVV2HoSFeiGnTohVW9Rtjy1d5bVgZzKFuQOmPEqLfzksG77ehvsnrTs2eO5P+cR6v+oPDUZQhZcuLeUZvMnRiasEGJ3gzXz6/RPH2+fOIE+eptQNDGfGC6KnEvqgjCYqWqHcSp7qU6ZPKeiMBZYrp7hG7345tXYfjLiRQPChmeyXOEZswhmanXcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by DS0PR11MB7558.namprd11.prod.outlook.com (2603:10b6:8:148::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.21; Fri, 4 Aug
 2023 06:36:36 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::b556:42c4:772f:d47e]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::b556:42c4:772f:d47e%7]) with mapi id 15.20.6609.032; Fri, 4 Aug 2023
 06:36:36 +0000
From:   "Liu, Yi L" <yi.l.liu@intel.com>
To:     "Liu, Jingqi" <jingqi.liu@intel.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
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
Subject: RE: [PATCH v5 2/4] iommu: Add new iommu op to get iommu hardware
 information
Thread-Topic: [PATCH v5 2/4] iommu: Add new iommu op to get iommu hardware
 information
Thread-Index: AQHZxhdAeyQAUZYpokOwdR2C5Dk4XK/ZctkAgAA80kA=
Date:   Fri, 4 Aug 2023 06:36:36 +0000
Message-ID: <DS0PR11MB75297FC544E151D7A8840A27C309A@DS0PR11MB7529.namprd11.prod.outlook.com>
References: <20230803143144.200945-1-yi.l.liu@intel.com>
 <20230803143144.200945-3-yi.l.liu@intel.com>
 <fa0f5283-fdc6-1cd5-b34d-dcdc86856ad1@intel.com>
In-Reply-To: <fa0f5283-fdc6-1cd5-b34d-dcdc86856ad1@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB7529:EE_|DS0PR11MB7558:EE_
x-ms-office365-filtering-correlation-id: 2fc3a40e-bd18-4fd1-108e-08db94b526d6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: T3aDjmHLnYHemXu+EahxVcHPVTSkbdlVJj9CCakOX1F/1lxTWw40+SAk4suBJryhFgQ62QqgdVJJ33tkMDJlBcBxGu7LMkyWO0NkUASxKCoHw05v7N3fVysnQn2dP2j5ch11SWqqvLa8BjKXSqNWyahKiMbtgQWTmiPdYBAH84/c7PFNkV/U9Jo1L5qM7gtpIgffUx/dOfbcauOSZ1EOdRGtgiAQHnSxG+GLtQshkQ/Bj4QPmhkFcTBh+AIxGeteazvviXKnJcgDIxVf79plJUnhnNC80c2i6jQBcXVG9KRHWbixxmsTb3lJNodvLwlh01ALDvYEmTMWqKoallPn+qfAWjQQ3Ia1lODGwOZaRbTWS9D7G4KI9/5jroaDu67+xtQKx2Yukoxam6BD2juUBqbVptxkwlnu5Qx6APCg0yCQ/HXXmyNpSYP/tpPpaT+oKoNME5uLUhAVmkImgWSLF74sMHTgwc7WRmyqEHwGvkEYIGN/LtaOUtAWq29plCYM0CBKy5SMzoVPEOzL36N9j9uknjoSKY9ewyqmdYvYGdH3sqi3o0dfUgWiMR7lUs2j6ADKoulcOWSWEUZO9Y9yNaabMQ4R/gSbKz3Mf/FvnAU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(39860400002)(396003)(376002)(366004)(346002)(451199021)(186006)(1800799003)(7696005)(38070700005)(558084003)(9686003)(86362001)(71200400001)(55016003)(6506007)(26005)(38100700002)(122000001)(82960400001)(33656002)(66556008)(66476007)(66446008)(66946007)(4326008)(76116006)(64756008)(2906002)(316002)(5660300002)(7416002)(52536014)(41300700001)(8936002)(8676002)(478600001)(110136005)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?enBNdkRSK0t1VzhtQ0lCRXRDeS84NU9HVm1DZHh3Y3lTaFhMOUp6d2JmekhU?=
 =?utf-8?B?SjE4bVpXRFIrOUlmakx5bmxTcm9UTUVwZzFLZ01IWVp0dm9ZTzR3d1g1ZTkr?=
 =?utf-8?B?NmVyM0R2dExjOXlsWlRTazVyc2M4WjBrSTRrUVQ3V3F3bXNWUHlFZkF6VU4v?=
 =?utf-8?B?Q1JoVmhOcWRpMjBDaDE3eDArQ1NpQlRUc3lKSU5NeDQrK1JnT1dKQlg0STFz?=
 =?utf-8?B?Rm50ZnBhSDcvbVkxS0JXcUp0K3RmMy84Nk9sRlNEemRCRHlPOXdoQ0pYZWIx?=
 =?utf-8?B?cStQa0M2SzduMjc5WUpFZmJQRkVpTGdEUHBkOEtWN0tJMGJIZG5XTDlFOVIv?=
 =?utf-8?B?dFBNZzFINFhyMHdrSmpVMkhvSXlQQk1CSGhCL0VRajh4QzZTT29odVlGM3RH?=
 =?utf-8?B?U0RRRjRkUlpGLzcwRWtrZ2VueXNlWEtjcXJ3alVDZVA5cmNoaHJZaFo2Ri9x?=
 =?utf-8?B?K0FtTkVYcHB0NGEyNCsyajdjZ3BHRmhLdCt2U0V3MUhncWw3RzBLTVV4UE40?=
 =?utf-8?B?bHJLRGxYZEpTZ1FGTU1DeGdTUFdwbDB2K0lEdXV2eUgranJQbEFXRTh2WjJh?=
 =?utf-8?B?NUJuTE5aS0tDSGdwbEFXWUlRdDlwakx2ZVpXWUxUUGRrbDFZcFVja01rc1dH?=
 =?utf-8?B?WUwrK3BsM2FQZ1JiQzA0YnZibHgwZllpWG1BQ05aQXZCWWNTS21qeUJMb3k3?=
 =?utf-8?B?RWNwOTRDR3JuOGIvY21oY3Q5V0VNd09icUFFaW03MG1aZC9raE5MVGJDVi9K?=
 =?utf-8?B?RmFVVXI3WHpIZytuWEV2TkFoQXhraktGUysvRHBML2pBOEk0ckxJcnVLcy82?=
 =?utf-8?B?aThieS95YU85b1doRWZxQWdDdmdxVTc4VXJDay84c2JKQzVocUVCVzI0UmFQ?=
 =?utf-8?B?elRiYWp2Rm00OFBOUERlTnY4Zm5PQzV0UHRHVDh4b0NBMDZJeERRM1VuKzlN?=
 =?utf-8?B?YnFkTyt1N1czQnZvdy9ydk9OZ2s5SnA5T3dQMjlTU0VMTDFXakpxVVIxNHhY?=
 =?utf-8?B?OWVGV0E2SlhMeXR0QnJ2Z2p1L2ZEaU4rUTFtcDRBOUwvcEtYUDlUcUpycGlk?=
 =?utf-8?B?K0VLczVFMDgwdGlBNDZHWXZuYjRYRHVoNzY4Y3BXdnVtY2ZuSzd3L2NRckFT?=
 =?utf-8?B?azZiUEF2c2JaWVVzY0hPRnJqNUhzZ2diYmVHTkljOS92N0E0S3BzREUyTlAw?=
 =?utf-8?B?ZG1BNWdzSElhWjBFSDBBaTdmZkVsMzJxYWdtQ0VDNVF3RDdSZ01vK0VyOENl?=
 =?utf-8?B?TUVvaXZNTU5LM2NOc2pVWFBIY2lIdG9xTjhicWdQTUxISW43Q0xmVmlpT3Zw?=
 =?utf-8?B?WXB2aXNJd1hrZGRISHN3SmE1M295WWNWQU8xdU4rc2ZidVNyS0dpUVlRM25h?=
 =?utf-8?B?dkJ3WUVMbi9Dc0FHVERiaXpOdURIbVdHK21pdXZiRDR1S1RteElNaDNPaVhv?=
 =?utf-8?B?N2JlSnUwdWhPcVBzY0ovLzdidERpdmNYa3JkZm56T1I4VTRLTG9KQWhjMjQ4?=
 =?utf-8?B?K1BNOXg0OFROczl2R0R3Sk1IRlZrbytrakUxSjd5N0hNSmJIV0xkR2d1TnVk?=
 =?utf-8?B?SzNuK2VWb0ZnZDlzcnRQS2dsaDJlbm5Tbm9ObWZIME12aWlwTEpzR3BjQ2Ni?=
 =?utf-8?B?UC9Fd2x0Q3RxMWRaRnJScElPMHZLT01EOGlrbG9qN1N6RDc3Qm5Id3ZKKzBD?=
 =?utf-8?B?WmpmMzRwNDlCQ1FTZ3o3djcxYmdNR2w5RlU4UzZxeFdkdDNKZC9jK2tKWjNu?=
 =?utf-8?B?NWxWQUdUbEMzVTJ5MGpUNFovM0t1MDFBb0hMQStwRGVPMGdvRk8yTXdEWDZN?=
 =?utf-8?B?MzJrSWswSTNIZFdPN0hoQk01T2tSTUNhUStVTTR6MkRpcFJqQ1RCeDRmZVky?=
 =?utf-8?B?NElUR3NwZjBRZHhqTi9HcmlIRVcxNWpraG9JUmE3K0tuRjZiSVcrOWNtRnhw?=
 =?utf-8?B?V01zWkc2OHJSZ1kraktNaytFSHJmTlFSMkw3aTRlV3hTSjJQYXlZaWl0ZDJR?=
 =?utf-8?B?eWE1Q05RZnRRTTRSVlV3R2FlTUk0OEdmbFdQbG1LUmFIeHdZU3h0SmNjNmg1?=
 =?utf-8?B?a2VjajBPbndaeTV1dnprWDY4U1hySWoyVjFqQ3A4ajRwK0tUN2J6M3cwMDFq?=
 =?utf-8?Q?Wsbk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fc3a40e-bd18-4fd1-108e-08db94b526d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Aug 2023 06:36:36.4478
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kRul5jOIaVZOcNQeMvjEXgcF2qaK6qbwM4uEZd8mzbXK2JCCJqVD/PPX1b4tsdiTlKuirD9yk2ZZ44wDQ61L9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7558
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

PiBGcm9tOiBMaXUsIEppbmdxaSA8amluZ3FpLmxpdUBpbnRlbC5jb20+DQo+IFNlbnQ6IEZyaWRh
eSwgQXVndXN0IDQsIDIwMjMgMTA6NTggQU0NCg0KPiA+ICsvKioNCj4gPiArICogZW51bSBpb21t
dV9od19pbmZvX3R5cGUgLSBJT01NVSBIYXJkd2FyZSBJbmZvIFR5cGVzDQo+ID4gKyAqIEBJT01N
VV9IV19JTkZPX1RZUEVfTk9ORTogVXNlZCBieSB0aGUgZHJpdmVycyB0aGF0IGRvZXMgbm90IHJl
cG9ydA0KPiBoYXJkd2FyZSBpbmZvDQo+IEl0IGxvb2tzIGxpa2UgdGhpczoNCj4gL3MvZG9lcy9k
bw0KDQpZZXMuDQoNClJlZ2FyZHMsDQpZaSBMaXUNCg==
