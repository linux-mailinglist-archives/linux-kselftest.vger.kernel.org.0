Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1371B7A8303
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Sep 2023 15:15:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234531AbjITNPW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 20 Sep 2023 09:15:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234638AbjITNPV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 20 Sep 2023 09:15:21 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67333AB;
        Wed, 20 Sep 2023 06:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695215716; x=1726751716;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=uTkVMcgaONqKlEwV4a+RnVZRziVQBLvcXKoTDgWaDzc=;
  b=l7JGpnGNTBE6cZVRS0iPJeXiY3Yp+61gNjvGdx5Ag2j6XMq50u2uAa5W
   Yoz8dkZS5W4tAyhWUs1+gSUZVjLRIF9B2pq3/7vbVcNoHfgnQQQ5ueS/M
   qVuyV5TCIN3oSFvgFSFV4yr4u1qayLE9T5x2JfjS6YMvAzurWBIxabOor
   qO/ryOLZFp48iF7XEhR4JPADTd/7q5wlN/RDe1NiUZlrH5rIh6cqYMsEC
   C3wtZNyFsIpJCYhQGzNF8MjwgWLsA9mgl/zP58oAP4YwqsFelIF/3L4hs
   3R5aAFry6YmzF4uf4cglwpuGQ6+mW1aIYH9r1BdQxAi164vYtK+juLXna
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="360474623"
X-IronPort-AV: E=Sophos;i="6.03,162,1694761200"; 
   d="scan'208";a="360474623"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2023 06:15:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="816896070"
X-IronPort-AV: E=Sophos;i="6.03,162,1694761200"; 
   d="scan'208";a="816896070"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Sep 2023 06:15:15 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 20 Sep 2023 06:15:14 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 20 Sep 2023 06:15:14 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 20 Sep 2023 06:15:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JNjM4yyUpZ87ZnGgp0hrw0eKVeEtev6GpDBzWumnU64YA0oJMgRUwYTCYCCWvFnvevWw7+UxvkwuIKqzn0FA6Ayd7yDRDRQiJSPFYsQ2tsR08wtGa6zPszY4Q57XWsatLavhMF6DkLT+t5HazOCluNBPZwj/jwcTOHjZqEfKDspTBZzHXDM5TADG35moDOHpzTBm1VuotnQg1e7W+LPE2rQEdmGAFJ3Ejmx1Lzj5IkmNA2aRINdGf1Ao/WYDI7VVEBvG7gxITVBPI0HTxRp2wSWkkngKB1gkpqWA5iE8BI5WDXjsXLW1q/JcuwIBnadB+hadRuyZz7V7bRPTC498Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uTkVMcgaONqKlEwV4a+RnVZRziVQBLvcXKoTDgWaDzc=;
 b=QS141RUCsxTOO0HSfmfR6gXzExkYlaBru3kz3nlLOoF3YTZpkyWy3xklqwuSvDm0v7/0ANhoCZiYMQ7PSz0UCQqDCjsjr/oCThHXRTzczEfCYeHKc83pWYsrVhLEj7fDBn2YTnoBe0K5aH+sB9e2qvNjCuZvKKsZRhjVV/c6Rg0nO5zzBeGw8fHU06Zk2UPle2TDIqq87IR7wY2TTYAqs0/CGbIMpPIKz91j7vWgATk7MuH2oF+BhDrH/C6BrDAzFOlt9ORwRRcmJ2AOt61N0sbRT990fAZ+NzOoCyIP9uh2MUh2a2L+UJ+1I6TcLwl93x3C3v+V3F7akvYZEMqYbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by PH7PR11MB6979.namprd11.prod.outlook.com (2603:10b6:510:207::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.20; Wed, 20 Sep
 2023 13:15:10 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::f8f4:bed2:b2f8:cb6b]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::f8f4:bed2:b2f8:cb6b%3]) with mapi id 15.20.6792.026; Wed, 20 Sep 2023
 13:15:10 +0000
From:   "Liu, Yi L" <yi.l.liu@intel.com>
To:     "Yang, Weijiang" <weijiang.yang@intel.com>,
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
        "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
        "Martins, Joao" <joao.m.martins@oracle.com>
Subject: RE: [PATCH 6/6] iommu/vt-d: Add domain_alloc_user op
Thread-Topic: [PATCH 6/6] iommu/vt-d: Add domain_alloc_user op
Thread-Index: AQHZ6ttUqZRrjysqnUa2j9no88GC0rAjNGOAgAB+cjA=
Date:   Wed, 20 Sep 2023 13:15:10 +0000
Message-ID: <DS0PR11MB75290582F647AB035FB3E301C3F9A@DS0PR11MB7529.namprd11.prod.outlook.com>
References: <20230919092523.39286-1-yi.l.liu@intel.com>
 <20230919092523.39286-7-yi.l.liu@intel.com>
 <74533792-7dcd-d745-dc07-671260bc9e22@intel.com>
In-Reply-To: <74533792-7dcd-d745-dc07-671260bc9e22@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB7529:EE_|PH7PR11MB6979:EE_
x-ms-office365-filtering-correlation-id: 215c84ed-4efb-4b0a-0f8f-08dbb9db9e35
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5+/gBzVkGz4wak1uJ6zIWqfS3AjtbCZ98DLUYMZvLuKWFFLRljXXAEU21WGh/1nILXWERVlLCCznz03faYayES0R5D4esahieZGCQwKzwhqf7dorFI7iJj/O7TqABZI5ERin/s7JDdtYm+wTYrpj08YnF3Lp5mpSOMmIOOqFo+zTG/wqLMu2JsroGkqAvDzQvxSZ370UJ20HWzOEhccsMe7zMmkclUsAKGq5ZU5wAtKosx3f1zdptHt6UVJLZnXGqEFcYI3Ip/nf8nF8u51moCBIjLG/sv55kI9POR3JBtgdulepslHF7bpxW8Xw3LRw9ri0Soh+J17GRmjrKdyqlu+Uli8hEdGdgRye9Y6kZ74YNJzCSOBEwiOoR4cBl2ZXNXxuF+spJqbBU6pPz3Op9oz+Bqf+PYDV7hpmF10DQHh8NVsuW5/qVJ7lZqs8PRdM7kOm2JAGJqav5ARU47N1ajnwLJO7ZSUoizds7f4pbd/Z58ue7tMBx3JlJc68s+dPSEYcBtzjuMuj1jOAGQEiRbQ1vkd19Xa55Ss5ny9HADx7wn5Tn5DQiyAC26ZPmDGch7T3h8j1aG7JKkFB9XWiKUBjTEa5YHK39pt2TAyxfs0RpcjKCXvxsHVbbpkZxP54
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(39860400002)(366004)(346002)(376002)(186009)(1800799009)(451199024)(38070700005)(6506007)(26005)(66476007)(53546011)(9686003)(71200400001)(7696005)(66946007)(66556008)(2906002)(8936002)(41300700001)(54906003)(8676002)(76116006)(4326008)(66446008)(5660300002)(52536014)(7416002)(55016003)(86362001)(33656002)(316002)(82960400001)(122000001)(38100700002)(478600001)(110136005)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eDF5c1NZY0wxUzNsa2s2NDFsWk4zQUYxL2ZRWmJxcDlrSTVIWFNqZkNHQnNw?=
 =?utf-8?B?NEJ5dkRmeTJJRmlkaFFWYnF1WWlpdXBDZGJ3NTRRckRTMVMyVFpPZitma3VO?=
 =?utf-8?B?NjF4S0ZKMDNEM1B1NTV1SlhjRThqcjE3NTBIcHBWcDZJdEczTUJuYnhvZzZ2?=
 =?utf-8?B?SXF4V2Q0YytPQkdZL3ZmNEZXUFB3eEtxNWkxczV2Uit0WCtBNnFRcEJ3SFdR?=
 =?utf-8?B?T1NvTWJ0RTBKSTd1enFXVEhlSndyZVYzQjc1ZmcxOXc1NDd0S3Y5emVHUDlw?=
 =?utf-8?B?QVEvRVRUcGdnQ1RGaDhNZ3dwVlljWFJvckNKNGUvV2ZoNUxXVjRHamxQdDdn?=
 =?utf-8?B?aFFFUTRNb2dpbHNNMWJlYzFubjNQZVZSVkFmMGM2K3NBclBralNZQTZZeTI0?=
 =?utf-8?B?aHhqbjVucyt0ZXRYbFovMkpaYmxraUttb0tTbFZqQ0VoZWdSYmE5TDhsUVZX?=
 =?utf-8?B?cDlPbTN0aEhaT2p4TFF3VkxhbUNmSHFCTWVzNGNoeE1OeWtlRVJQQnF3UXR0?=
 =?utf-8?B?SGRwdVl5NGNTczNDUWk3RGdUN0RYVDhsSWl5d01BTkVkS2lDWlg3cE05elVj?=
 =?utf-8?B?Q1ovU003MGRaMnltV2crS3h6NzJ1NEJQQmNRdlFNOUwxVUJoeHlpNERYcGwy?=
 =?utf-8?B?bkZGMDRWREtZRDRJUEJ2SFFpWmYrdlpjTTFraWFlUzF2T05lalBxVjl3QVlU?=
 =?utf-8?B?NVBFTCs3ZHl5clp2clJEWE9SaXl0czRKYkxkY1hPRHVCZC85UDFRNmdZeDEx?=
 =?utf-8?B?L0d2Q0Exdk1Sb3V0SEEwNEFXTTZQZWZzRGVZZkZBem1DR2lJSzdRamJrWFdB?=
 =?utf-8?B?QStWaEFFbkh0N25NU0xqY1dWRDI4bC90d1drUkorNVRUMlFsNEpHa1BaNlJl?=
 =?utf-8?B?NTMvb0pQMzJkWDZvaUw2N0pRbWp1MlVrVXQ2V081U1o3UGFTTktTaXJ1T0Rh?=
 =?utf-8?B?aXFTZU9vV01FTFY5ZEl4M0VEK3Mvd3E3dDJUWlNMTUxVSTVtcHJoZ3FnWVp2?=
 =?utf-8?B?cThjWkxkc0FyVmVnemNqSjUzbThTWTE3VjRieVd2V2JoT0hRTEFNeVYwL0R5?=
 =?utf-8?B?d29zMWpoS1pQTW1lQXRkTEJrY3Ywb2ZMVUVTalVrdVAzQ3YxdEhtTksvbmY1?=
 =?utf-8?B?ejRaYjl5b0RFTEwvbjlOSEw4b1FWYWRXdG44Y1NlOThJVmR6K1RrbDRVODdU?=
 =?utf-8?B?QTNXNzlaQ1VUZzJYdDYrNkRqSFgzaWpLVmxMYy9Zd1g3V3J2WmMvK2VDSDNo?=
 =?utf-8?B?eGJTNUM4SklBdzhiRXZXbUVFaWNHd1RZTXhqWE9qZENGRUd5M1UzQU9PT0sy?=
 =?utf-8?B?QVBITDRXNk9YMUwxK3E0SDRSUUVPNWtreVZoRVhaeWZ4SmxVcVJhSDNoK2du?=
 =?utf-8?B?bGNrMVg3L1N4bExXM2hOM28vY29MUk1xeDZ5OXU4YytaWjZFem13RmxmTFc3?=
 =?utf-8?B?TjZ2VkZrQUFERkwwY0kwRXZacVpTeTA5bVg3M21YWER3R3d4c0V0Z2RMVHBw?=
 =?utf-8?B?TjBCWXNpd09SeHJ2VFIveHlCemIrZG53bnJ6b3k0SGtTTS9OYUprS1lsbHA3?=
 =?utf-8?B?RUdheWVmWmtkbFJBQVJ2T0VBcU1Cc3RnNktCNkxabEltelhCWFUwYS9BMHlH?=
 =?utf-8?B?anlUQ0dHMnFSOVhWSGFFTmZaenhGcG93eEdVOGZMdzFnaWhMZEFsc2VCTHBW?=
 =?utf-8?B?ak43SCttdXpSUHg1ei9SSTFCTVZVOU11MlZqT1pDQ2FDRG9DdU1PMWtNSlpq?=
 =?utf-8?B?ejFQRVdVeHFBZTBISS9Fd2lDdlF4K0VlYllpSThEYkdtNk90UU5qbVhhN3gz?=
 =?utf-8?B?ZEJNTzZRNVloK3g0U0VjNWdGMXBTczlHQURSWXlwQWxHNkVvcklZaGZzWm9L?=
 =?utf-8?B?M3pDRGI1Y3RKT1RHRnMyM1hJVkkyYU1rR04vRUdJOFpwQXFMdmthcU9IeTQy?=
 =?utf-8?B?R0NBWXNzT2htT0NIVVpwZjFRclUzQlZqN0JOVm5WcXpnWWdYNlN3NjVtWXlW?=
 =?utf-8?B?WlJJTDhieUttazFlejMwVytBSXE4VGFNWGhWVGlwc1Z5V29mL1A3YnJMWWN1?=
 =?utf-8?B?ZFJYb1VYMTVma1g2ODBWelUzM1E4cE5yMHR0M0FibFd6aTAvQnVvam1CQno4?=
 =?utf-8?Q?prrg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 215c84ed-4efb-4b0a-0f8f-08dbb9db9e35
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2023 13:15:10.6035
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BKdQmG54kxTUutmNi4X0FYlf4pIw0JmWBnM7+tZ5mLiuCBgGw5/KeipAdrhWa7jhxQY9pkvLyEtJD4sXusSAqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6979
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

PiBGcm9tOiBZYW5nLCBXZWlqaWFuZyA8d2VpamlhbmcueWFuZ0BpbnRlbC5jb20+DQo+IFNlbnQ6
IFdlZG5lc2RheSwgU2VwdGVtYmVyIDIwLCAyMDIzIDE6NDEgUE0NCj4gT24gOS8xOS8yMDIzIDU6
MjUgUE0sIFlpIExpdSB3cm90ZToNCj4gPiBUaGlzIGFkZHMgdGhlIGRvbWFpbl9hbGxvY191c2Vy
IG9wIGltcGxlbWVudGF0aW9uLiBJdCBzdXBwb3J0cyBhbGxvY2F0aW5nDQo+ID4gZG9tYWlucyB0
byBiZSB1c2VkIGFzIHBhcmVudCB1bmRlciBuZXN0ZWQgdHJhbnNsYXRpb24uDQo+ID4NCj4gPiBT
aWduZWQtb2ZmLWJ5OiBZaSBMaXUgPHlpLmwubGl1QGludGVsLmNvbT4NCj4gPiAtLS0NCj4gPiAg
IGRyaXZlcnMvaW9tbXUvaW50ZWwvaW9tbXUuYyB8IDIwICsrKysrKysrKysrKysrKysrKysrDQo+
ID4gICAxIGZpbGUgY2hhbmdlZCwgMjAgaW5zZXJ0aW9ucygrKQ0KPiA+DQo+ID4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvaW9tbXUvaW50ZWwvaW9tbXUuYyBiL2RyaXZlcnMvaW9tbXUvaW50ZWwvaW9t
bXUuYw0KPiA+IGluZGV4IDVkYjI4M2MxN2UwZC4uNDkxYmNkZTFmZjk2IDEwMDY0NA0KPiA+IC0t
LSBhL2RyaXZlcnMvaW9tbXUvaW50ZWwvaW9tbXUuYw0KPiA+ICsrKyBiL2RyaXZlcnMvaW9tbXUv
aW50ZWwvaW9tbXUuYw0KPiA+IEBAIC00MDc0LDYgKzQwNzQsMjUgQEAgc3RhdGljIHN0cnVjdCBp
b21tdV9kb21haW4NCj4gKmludGVsX2lvbW11X2RvbWFpbl9hbGxvYyh1bnNpZ25lZCB0eXBlKQ0K
PiA+ICAgCXJldHVybiBOVUxMOw0KPiA+ICAgfQ0KPiA+DQo+ID4gK3N0YXRpYyBzdHJ1Y3QgaW9t
bXVfZG9tYWluICoNCj4gPiAraW50ZWxfaW9tbXVfZG9tYWluX2FsbG9jX3VzZXIoc3RydWN0IGRl
dmljZSAqZGV2LCB1MzIgZmxhZ3MpDQo+ID4gK3sNCj4gPiArCXN0cnVjdCBpb21tdV9kb21haW4g
KmRvbWFpbjsNCj4gPiArCXN0cnVjdCBpbnRlbF9pb21tdSAqaW9tbXU7DQo+ID4gKw0KPiA+ICsJ
aW9tbXUgPSBkZXZpY2VfdG9faW9tbXUoZGV2LCBOVUxMLCBOVUxMKTsNCj4gPiArCWlmICghaW9t
bXUpDQo+ID4gKwkJcmV0dXJuIEVSUl9QVFIoLUVOT0RFVik7DQo+ID4gKw0KPiA+ICsJaWYgKChm
bGFncyAmIElPTU1VX0hXUFRfQUxMT0NfTkVTVF9QQVJFTlQpICYmICFlY2FwX25lc3QoaW9tbXUt
DQo+ID5lY2FwKSkNCj4gPiArCQlyZXR1cm4gRVJSX1BUUigtRU9QTk9UU1VQUCk7DQo+IA0KPiBU
aGUgb3V0ZXIgY2FsbGVyIGhhcyBjaGVja2VkIChmbGFncyAmIElPTU1VX0hXUFRfQUxMT0NfTkVT
VF9QQVJFTlQpIGJlZm9yZSBpdA0KPiBjb21lcyBoZXJlLg0KPiBJZiB0aGlzIGNhbGxiYWNrIGlz
IGRlZGljYXRlZCBmb3IgbmVzdGVkIGRvbWFpbiBhbGxvY2F0aW9uLCB0aGVuIHlvdSBtYXkgb21p
dCB0aGUNCj4gY29uZGl0aW9uIGhlcmUuDQoNClRoaXMgY2hlY2sgaXMgZGlmZmVyZW50LiBJdCBh
aW1zIHRvIGZhaWwgdGhlIGNhbGwgaWYgaW9tbXUgaHcgZG9lcyBub3Qgc3VwcG9ydCBuZXN0ZWQu
DQpJIGp1c3QgcmVhbGl6ZWQgdGhhdCBpdCBtYXkgbmVlZCB0byBjaGVjayBpZiBzY2FsYWJsZSBt
b2RlIGlzIGVuYWJsZWQuIFRoaXMgc2hvdWxkDQpiZSBtb3JlIGFjY3VyYXRlLg0KDQpSZWdhcmRz
LA0KWWkgTGl1DQo=
