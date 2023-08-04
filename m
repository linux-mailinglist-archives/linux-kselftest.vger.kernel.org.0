Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B896976FA28
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Aug 2023 08:35:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231843AbjHDGfl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 4 Aug 2023 02:35:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbjHDGfi (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 4 Aug 2023 02:35:38 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 806B54684;
        Thu,  3 Aug 2023 23:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691130937; x=1722666937;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=RDwTItM/Kw3KqC2MrQHGW5o8qFCfFqz9u+dCEhR9Jro=;
  b=PeT6T1B9wUvhSE8VavmmJrJK8au2NhEGh/RjZcLOUU4hcXPV7lAKZm/B
   0dNrVTDa56OClEM7Gshv96yMrPNnoLBoI79f3LRf33gUrL8h9PHJkAG62
   NodStUryD/KUULjkVUJtwLzftEsqPHTeMmHvCN0wnK+H8yhWL2bPUEsR0
   4iVEvrZ1jnkQgjjTRXhKfh5l1cmuBKI8r+mqgFLBeCVJXCTVoMuOUhjdJ
   TJoEgH5r2YU5gwD2jYXGIb/0hSWgWnifChMyRBf32RvlDCSiNCaZ8NEF8
   ih9R9+wKBfx9jwZKEQbYnjMnGGVujvPAvdPW/Uweqlo/Q7ZFyysoPg2Ky
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10791"; a="373728102"
X-IronPort-AV: E=Sophos;i="6.01,254,1684825200"; 
   d="scan'208";a="373728102"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2023 23:35:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10791"; a="679791771"
X-IronPort-AV: E=Sophos;i="6.01,254,1684825200"; 
   d="scan'208";a="679791771"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga003.jf.intel.com with ESMTP; 03 Aug 2023 23:35:35 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 3 Aug 2023 23:35:35 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 3 Aug 2023 23:35:34 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 3 Aug 2023 23:35:34 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.42) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 3 Aug 2023 23:35:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bSXHVcPMi6LAJaZ28Qr0Fy3Ha1B9ZKkSGeJgr/L7NUmaBnbjm25Ijd3Rub7kuqhJFzowNWSLpnbvLmVIEcizkF8pFrTJMxC8h1E0EJA/4Fs66clhnmwAkMVdTNYSrosFeo3cHQR1HKsSsI+0g7O5k2c/IqKIw+e3E7DgmkMPbhnMKEPMGCKI9iqsSnCDYvojbCS7UKGxrQaPbsowvyciT5aDl6JQQ9IiRKAMTiUM/KzRRE96/T7ksyB5+KoVe0qSB4/FaBFLr66yJoSG5Jmqqzk5hof2g/dOWJ7Ldodyzn1OVaC/Od+ZFC5W/RZ/soPghwt5EehqsYsg1o2Ad//DMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RDwTItM/Kw3KqC2MrQHGW5o8qFCfFqz9u+dCEhR9Jro=;
 b=bfGG6NtNgs67AmFPODcRibIw30a+47DKiLWEUPTI1eV6XxOEPBAa8kPcQ3qnpC57u2nGEiQ9CVnoy6oyQkY+eaiOsvwIU3Ac2dS+c6LwRlDXljw711TqxVnWsrtuv+Z1gOWw6fawhzhjRAN7y3SurE9deq/9MCGjAilZAUyUVeN1QiYKUlbqkpGxDxXSe4gW+f1Ezx1UBy+Vbmyh2NEIDW19HZvPpUTqDWvCz6Bpav4K2GRPTnOCsDx1akPn6KiChx3gqW10/jMUxD7iPxIzNMF/g+64Qneooy2eRrmME9XmR2NyN6vtOgMFbvj7axbQHUoo0XwrEOzy//QKk6Re8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by DS0PR11MB7558.namprd11.prod.outlook.com (2603:10b6:8:148::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.21; Fri, 4 Aug
 2023 06:35:27 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::b556:42c4:772f:d47e]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::b556:42c4:772f:d47e%7]) with mapi id 15.20.6609.032; Fri, 4 Aug 2023
 06:35:27 +0000
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
        "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
Subject: RE: [PATCH v5 3/4] iommufd: Add IOMMU_GET_HW_INFO
Thread-Topic: [PATCH v5 3/4] iommufd: Add IOMMU_GET_HW_INFO
Thread-Index: AQHZxhdBKtNyRcHbIEGMXGrFUJBCcK/ZYleAgABM/6A=
Date:   Fri, 4 Aug 2023 06:35:27 +0000
Message-ID: <DS0PR11MB75291A3E7A8EBE0EEF64BA53C309A@DS0PR11MB7529.namprd11.prod.outlook.com>
References: <20230803143144.200945-1-yi.l.liu@intel.com>
 <20230803143144.200945-4-yi.l.liu@intel.com>
 <51418f60-db2f-8ee3-ed9c-1a97d89774cf@linux.intel.com>
In-Reply-To: <51418f60-db2f-8ee3-ed9c-1a97d89774cf@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB7529:EE_|DS0PR11MB7558:EE_
x-ms-office365-filtering-correlation-id: f1ba0e57-16b7-41f9-549b-08db94b4fd91
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rDk8TNQqn1Ol8EnvsbEozmTEAzHxtZpeCASeOjWOymtq3MjYClxqbOm4bkQg672IwPp6lX0X0Sav+S7nl6rHeX13e1YX5l/lEb7bw2VQrUv5LFL9heSb3KFQb6xhYmwC/idhHV4ybY8oGRb8WXBTL6/ieuMZhRdE4SCIKQVvbraB8yCkd9POBL8H0PWjwnYRtPdacRHCOlLQFSIiHg+vewH2EFoi2tIeu0C//wdfqrBZvt6iM2FkDR32q3KyxlehaG8PuE6vJeh81nqKRf4nAHKIEeGGl6W9w1N+mSZk4eHdE/7UpB0o47qLp4G4m0DFgk4KyvIuYd/0Tf+J8yydjvbkR47J8B94dlPFyzdkP5SvAwphgA+mLjjHbD7ZictgZ9vr1CI/8ePKkE98hxjg82a9CeenYFdxcmaQP1c25ZL15FJ9Ij/IYssAFvLi2Qsk4g5WM8RM6wvOqb70xGW0kEK0R5ji+nPWkbof3GNNp8ttfCjZfVVGBTDR77jqs9imV/DsdD9NCpRAOUywDVDBP6BMF+LwRM6VNQRNadxSC2PZG21IuJEMfoWOBL8RnIVlk1dpcqGhRmQkmYj+n5KX6Tf/P67038+nMPDJI9UPyPoEoeHnGgnYhrk8hL0QVvxV
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(39860400002)(396003)(376002)(366004)(346002)(451199021)(186006)(1800799003)(7696005)(38070700005)(9686003)(86362001)(71200400001)(55016003)(6506007)(26005)(53546011)(38100700002)(122000001)(82960400001)(33656002)(66556008)(66476007)(66446008)(66946007)(4326008)(76116006)(64756008)(2906002)(316002)(5660300002)(7416002)(52536014)(41300700001)(8936002)(8676002)(478600001)(110136005)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N3Bud0tVYVVTd1lwM0VjN3dOa25jM3huWWw0Mjd1cHFEM0RWR3lKLzFjaWFW?=
 =?utf-8?B?N1hqbDZwQWNOZjBxczY3SHBBay9aNkZtcjc4a0N5bzNtejVnSHY5TFlONzUv?=
 =?utf-8?B?NWU5ZHJPVEM1ZTJLOHRNa0JaRjNZRHdralV0cTU5N0xZVHorOXVxNGF5L2l2?=
 =?utf-8?B?dnpmdlFaN2JQZkZJS0pmellsUUxQeEVZa1VPbGlnSVhhSGVaQVE0VHIxQ0tU?=
 =?utf-8?B?cjVwOC9Jb2l4ZGFqUTNRdnc2S0NIUUM0aVExdjE5VHZoTmltWW9MM09WVWlG?=
 =?utf-8?B?bWdxaDVXRGtKdVJ1UWM5S3hpYkgzTHVKT2tUTmZkd1R1VkVRT3lWVVNOdzRr?=
 =?utf-8?B?bUVlb1gweE51NWpQQlBKNjM1dlZ0bmR2L1RXWUJWdmVpOG45bTF6dDdOUURv?=
 =?utf-8?B?RnFKL1F6OFJ5QzFSNEpSenluOU5QM1NlYU0zZGFScEFTMHRyNWYrMFphR0FU?=
 =?utf-8?B?eXRmc0d6WVV4NDFCbC90TWVTditsMXZLbUZycEtkd3Z5Vk9oMHdLSlVHdnFR?=
 =?utf-8?B?VUFZWkxWbFdpdWdDNlA1ekZQVTRtZHlZQTFrKzRlazVxYXY5NjU2V0VhOVVQ?=
 =?utf-8?B?K0grNFhuK1lyQkp0V0VrWExWT1EzQm9Oak1LM0J5RlEwZnFsU29ubXZPaTBU?=
 =?utf-8?B?Q0tzRmFFaUVCL1ZqUzJmNyt2NkliaEd3b2YzdFNrWU16aHZVL1dtK0FJdUhL?=
 =?utf-8?B?WlgvOXNxdnNjTlp3N05QWEc4b3pzVlMzbFN0bVdocEJKaEtDQkdlOStpZWtV?=
 =?utf-8?B?WVpVSmFBTUloWW5OUGNaR1l2Y0RFQmlVNm1oQ2lEbjdYRWFIRk9YdWpGckIw?=
 =?utf-8?B?RkRrclloditlMjFybk8wTlhXaFcxMDMyOStmYUp3Z241N2FIeW8remsvUS9B?=
 =?utf-8?B?VVN0TWtld25mUVE5djVwdDhpUzhrVXJ0OTRlV1Y3VDNWM25ha1J3dTZaSmVu?=
 =?utf-8?B?cFNtTE50RWNkd1NUTWtIU3RLQUcwK05OMHBTeGMvTFJHK0xKUmpVQmNSMS9E?=
 =?utf-8?B?Qk4waUIvQjVVdG9uTmVrUFREU3ltV1djZU5sMXdGcWdtYUhBNEN5MWdTSFAy?=
 =?utf-8?B?YmxpeEdMS0IwUUZYamx6WU5tOGt2d0k2a2JkUmR6ZUZjbE5ibmhpMkRjUFAr?=
 =?utf-8?B?bUJzeWd0QW1IcEhIcW8xbCtCd2VSaFJUT29aSzlrQUM1QlIyVFY0anJiSmZ6?=
 =?utf-8?B?TmlRU2FaTzk1S2hGMU1uYUx4U2xBaWc0ODF1ZnBsNVp4YXB1MU5Rd3lGbVFF?=
 =?utf-8?B?bCtaTHdER1Z4clhIeTB5eUMvOTFadzNFNWRnTWJ4cnRMWEFkc0plSnB0Y1Yr?=
 =?utf-8?B?Nm9mSDI0WXI2NFdnLy92OVRqMHhrUFBZbFJZaU1BRG4wQzV3UFpYU0NyNGIy?=
 =?utf-8?B?d0ZVWXNTdVNsTmZHQW5pcUZOZCtrNlVHS1ZqdG1veE5VOUVFcGxXdUkvTFFw?=
 =?utf-8?B?c1ZlbS9RTTZSUVU0Q3FGVTNMTlpabXlnelNxRFpGbER6TWtlWmhXMVdrM3Ra?=
 =?utf-8?B?Qi80Y2Y2YlVlRTN6cDdtUDFFOWlSV1N1MVJNeGJ5UWhieXY1TU45VmZoK0VZ?=
 =?utf-8?B?N3Y5ZE5ZK0MwdzRaTzJ4czVQcjlWVldMYUZISittdkM1Z3Y0d010dC9KamM4?=
 =?utf-8?B?OUM4RE1JNndnbTgxTXhZR3huN0p5UHptc2VEYTVET0hmSXdwRldmbEFpR0pp?=
 =?utf-8?B?L0w0eEZOOTBOcWtTNkJCL0lvd1dINi9SRGduaHFlNERoRVY0dUh4bDZlSk9J?=
 =?utf-8?B?RnZTeFVCaHpuaW9Ta1Z1YXJwalhrSTdDZ0ZIT0xNak9MZ3F3VGcwN2pMK25F?=
 =?utf-8?B?QzhsZ2lQV0ltUjVRK1dvdWlSdlZXdytBaWFhdmVlZ3RWdDVkc1c1K20waEdM?=
 =?utf-8?B?dVZEZjFQZlRLMWRqSnZzSnRxREJRNElGUjRrWkY5MFcyZlo0SUdkb1dneWpV?=
 =?utf-8?B?QmlnMGxwVnpRd3JTbG5uRFdHSm5aNHdyclNkUUh4M2dIRDI1a09oWUdmRHB6?=
 =?utf-8?B?b1pyY0FwWnJobnhlTlFRUDlxTzN1L1RwZzcxa1luL1Y2Q1p1d21sc1cvSG1J?=
 =?utf-8?B?MkdNVkc2bFBQb1djQjRvKzNqMW0veHdQNENIeVpubFY0N1dUZTRJOS82bXZJ?=
 =?utf-8?Q?bCM8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1ba0e57-16b7-41f9-549b-08db94b4fd91
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Aug 2023 06:35:27.2208
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: woSxynKCrySd/FGCPWIMDBARRxmIjgVYzZ0jK+ohK9g+u79JRIYEi5j6qv5DzkqIbSUt4QESVK35rs+tHb9zUw==
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

PiBGcm9tOiBCYW9sdSBMdSA8YmFvbHUubHVAbGludXguaW50ZWwuY29tPg0KPiBTZW50OiBGcmlk
YXksIEF1Z3VzdCA0LCAyMDIzIDk6NTkgQU0NCj4gDQo+IE9uIDIwMjMvOC8zIDIyOjMxLCBZaSBM
aXUgd3JvdGU6DQo+ID4gVW5kZXIgbmVzdGVkIElPTU1VIHRyYW5zbGF0aW9uLCB1c2Vyc3BhY2Ug
b3ducyB0aGUgc3RhZ2UtMSB0cmFuc2xhdGlvbg0KPiA+IHRhYmxlIChlLmcuIHRoZSBzdGFnZS0x
IHBhZ2UgdGFibGUgb2YgSW50ZWwgVlQtZCBvciB0aGUgY29udGV4dCB0YWJsZQ0KPiA+IG9mIEFS
TSBTTU1VdjMsIGFuZCBldGMuKS4gU3RhZ2UtMSB0cmFuc2xhdGlvbiB0YWJsZXMgYXJlIHZlbmRv
ciBzcGVjaWZpYywNCj4gPiBhbmQgbmVlZCB0byBiZSBjb21wYXRpYWJsZSB3aXRoIHRoZSB1bmRl
cmx5aW5nIElPTU1VIGhhcmR3YXJlLiBIZW5jZSwNCj4gDQo+ICAgICAgICAgICAgICAgICAgIGNv
bXBhdGlibGUNCg0KWWVzLg0KDQo+ID4gdXNlcnNwYWNlIHNob3VsZCBrbm93IHRoZSBJT01NVSBo
YXJkd2FyZSBjYXBhYmlsaXR5IGJlZm9yZSBjcmVhdGluZyBhbmQNCj4gPiBjb25maWd1cmluZyB0
aGUgc3RhZ2UtMSB0cmFuc2xhdGlvbiB0YWJsZSB0byBrZXJuZWwuDQo+ID4NCj4gPiBUaGlzIGFk
ZHMgSU9NTVVfR0VUX0hXX0lORk8gaW9jdGwgdG8gcXVlcnkgdGhlIElPTU1VIGhhcmR3YXJlIGlu
Zm9ybWF0aW9uDQo+ID4gKGEuay5hIGNhcGFiaWxpdHkpIGZvciBhIGdpdmVuIGRldmljZS4gVGhl
IHJldHVybmVkIGRhdGEgaXMgdmVuZG9yIHNwZWNpZmljLA0KPiA+IHVzZXJzcGFjZSBuZWVkcyB0
byBkZWNvZGUgaXQgd2l0aCB0aGUgc3RydWN0dXJlIG1hcHBlZCBieSB0aGUgQG91dF9kYXRhX3R5
cGUNCj4gPiBmaWVsZC4NCj4gPg0KPiA+IEFzIG9ubHkgcGh5c2ljYWwgZGV2aWNlcyBoYXZlIElP
TU1VIGhhcmR3YXJlLCBzbyB0aGlzIHdpbGwgcmV0dXJuIGVycm9yDQo+ID4gaWYgdGhlIGdpdmVu
IGRldmljZSBpcyBub3QgYSBwaHlzaWNhbCBkZXZpY2UuDQo+ID4NCj4gPiBDby1kZXZlbG9wZWQt
Ynk6IE5pY29saW4gQ2hlbiA8bmljb2xpbmNAbnZpZGlhLmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5
OiBOaWNvbGluIENoZW4gPG5pY29saW5jQG52aWRpYS5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTog
WWkgTGl1IDx5aS5sLmxpdUBpbnRlbC5jb20+DQo+ID4gLS0tDQo+ID4gICBkcml2ZXJzL2lvbW11
L2lvbW11ZmQvbWFpbi5jIHwgNzkgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
DQo+ID4gICBpbmNsdWRlL3VhcGkvbGludXgvaW9tbXVmZC5oIHwgMzYgKysrKysrKysrKysrKysr
Kw0KPiA+ICAgMiBmaWxlcyBjaGFuZ2VkLCAxMTUgaW5zZXJ0aW9ucygrKQ0KPiA+DQo+ID4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvaW9tbXUvaW9tbXVmZC9tYWluLmMgYi9kcml2ZXJzL2lvbW11L2lv
bW11ZmQvbWFpbi5jDQo+ID4gaW5kZXggOTRjNDk4YjhmZGY2Li5hMDMwMmJjYWE5N2MgMTAwNjQ0
DQo+ID4gLS0tIGEvZHJpdmVycy9pb21tdS9pb21tdWZkL21haW4uYw0KPiA+ICsrKyBiL2RyaXZl
cnMvaW9tbXUvaW9tbXVmZC9tYWluLmMNCj4gPiBAQCAtMTcsNiArMTcsNyBAQA0KPiA+ICAgI2lu
Y2x1ZGUgPGxpbnV4L2J1Zy5oPg0KPiA+ICAgI2luY2x1ZGUgPHVhcGkvbGludXgvaW9tbXVmZC5o
Pg0KPiA+ICAgI2luY2x1ZGUgPGxpbnV4L2lvbW11ZmQuaD4NCj4gPiArI2luY2x1ZGUgIi4uL2lv
bW11LXByaXYuaCINCj4gPg0KPiA+ICAgI2luY2x1ZGUgImlvX3BhZ2V0YWJsZS5oIg0KPiA+ICAg
I2luY2x1ZGUgImlvbW11ZmRfcHJpdmF0ZS5oIg0KPiA+IEBAIC0xNzcsNiArMTc4LDgxIEBAIHN0
YXRpYyBpbnQgaW9tbXVmZF9kZXN0cm95KHN0cnVjdCBpb21tdWZkX3VjbWQgKnVjbWQpDQo+ID4g
ICAJcmV0dXJuIDA7DQo+ID4gICB9DQo+ID4NCj4gPiArc3RhdGljIGludCBpb21tdWZkX3plcm9f
ZmlsbF91c2VyKHZvaWQgX191c2VyICpwdHIsIHNpemVfdCBieXRlcykNCj4gPiArew0KPiA+ICsJ
aW50IGluZGV4ID0gMDsNCj4gPiArDQo+ID4gKwlmb3IgKDsgaW5kZXggPCBieXRlczsgaW5kZXgr
Kykgew0KPiA+ICsJCWlmIChwdXRfdXNlcigwLCAodWludDhfdCBfX3VzZXIgKikocHRyICsgaW5k
ZXgpKSkNCj4gPiArCQkJcmV0dXJuIC1FRkFVTFQ7DQo+ID4gKwl9DQo+ID4gKwlyZXR1cm4gMDsN
Cj4gPiArfQ0KPiA+ICsNCj4gPiArc3RhdGljIGludCBpb21tdWZkX2dldF9od19pbmZvKHN0cnVj
dCBpb21tdWZkX3VjbWQgKnVjbWQpDQo+ID4gK3sNCj4gPiArCXUzMiBod19pbmZvX3R5cGUgPSBJ
T01NVV9IV19JTkZPX1RZUEVfTk9ORTsNCj4gPiArCXN0cnVjdCBpb21tdV9od19pbmZvICpjbWQg
PSB1Y21kLT5jbWQ7DQo+ID4gKwl1bnNpZ25lZCBpbnQgbGVuZ3RoID0gMCwgZGF0YV9sZW47DQo+
ID4gKwlzdHJ1Y3QgaW9tbXVmZF9kZXZpY2UgKmlkZXY7DQo+ID4gKwljb25zdCBzdHJ1Y3QgaW9t
bXVfb3BzICpvcHM7DQo+ID4gKwl2b2lkIF9fdXNlciAqdXNlcl9wdHI7DQo+ID4gKwl2b2lkICpk
YXRhID0gTlVMTDsNCj4gPiArCWludCByYyA9IDA7DQo+ID4gKw0KPiA+ICsJaWYgKGNtZC0+Zmxh
Z3MgfHwgY21kLT5fX3Jlc2VydmVkIHx8ICFjbWQtPmRhdGFfbGVuKQ0KPiA+ICsJCXJldHVybiAt
RU9QTk9UU1VQUDsNCj4gPiArDQo+ID4gKwlpZGV2ID0gaW9tbXVmZF9nZXRfZGV2aWNlKHVjbWQs
IGNtZC0+ZGV2X2lkKTsNCj4gPiArCWlmIChJU19FUlIoaWRldikpDQo+ID4gKwkJcmV0dXJuIFBU
Ul9FUlIoaWRldik7DQo+ID4gKw0KPiA+ICsJdXNlcl9wdHIgPSB1NjRfdG9fdXNlcl9wdHIoY21k
LT5kYXRhX3B0cik7DQo+ID4gKw0KPiA+ICsJb3BzID0gZGV2X2lvbW11X29wcyhpZGV2LT5kZXYp
Ow0KPiA+ICsJaWYgKCFvcHMtPmh3X2luZm8pDQo+ID4gKwkJZ290byBkb25lOw0KPiA+ICsNCj4g
PiArCWRhdGEgPSBvcHMtPmh3X2luZm8oaWRldi0+ZGV2LCAmZGF0YV9sZW4sICZod19pbmZvX3R5
cGUpOw0KPiA+ICsJaWYgKElTX0VSUihkYXRhKSkgew0KPiA+ICsJCXJjID0gUFRSX0VSUihkYXRh
KTsNCj4gPiArCQlnb3RvIG91dF9lcnI7DQo+IA0KPiBDYW4ga2ZyZWUoKSBoYW5kbGUgYSBFUlJf
UFRSIGlucHV0PyBJIGFtIGFmcmFpZCBub3QsDQo+IA0KPiAvKioNCj4gICAqIGtmcmVlIC0gZnJl
ZSBwcmV2aW91c2x5IGFsbG9jYXRlZCBtZW1vcnkNCj4gICAqIEBvYmplY3Q6IHBvaW50ZXIgcmV0
dXJuZWQgYnkga21hbGxvYygpIG9yIGttZW1fY2FjaGVfYWxsb2MoKQ0KPiAgICoNCj4gICAqIElm
IEBvYmplY3QgaXMgTlVMTCwgbm8gb3BlcmF0aW9uIGlzIHBlcmZvcm1lZC4NCj4gICAqLw0KPiB2
b2lkIGtmcmVlKGNvbnN0IHZvaWQgKm9iamVjdCkNCj4gew0KPiAgICAgICAgICBzdHJ1Y3QgZm9s
aW8gKmZvbGlvOw0KPiAgICAgICAgICBzdHJ1Y3Qgc2xhYiAqc2xhYjsNCj4gICAgICAgICAgc3Ry
dWN0IGttZW1fY2FjaGUgKnM7DQo+IA0KPiAgICAgICAgICB0cmFjZV9rZnJlZShfUkVUX0lQXywg
b2JqZWN0KTsNCj4gDQo+ICAgICAgICAgIGlmICh1bmxpa2VseShaRVJPX09SX05VTExfUFRSKG9i
amVjdCkpKQ0KPiAgICAgICAgICAgICAgICAgIHJldHVybjsNCj4gDQo+IFNvLCBwZXJoYXBzIHdl
IHNob3VsZCBhZGQNCj4gDQo+IAlkYXRhID0gTlVMTDsNCj4gDQo+IGJlZm9yZQ0KPiAJZ290byBv
dXRfZXJyOw0KPiANCj4gPw0KDQpZZXMuDQoNCj4gDQo+ID4gKwl9DQo+ID4gKw0KPiA+ICsJLyog
ZHJpdmVyIGhhcyBod19pbmZvIGNhbGxiYWNrIHNob3VsZCBoYXZlIGEgdW5pcXVlIGh3X2luZm9f
dHlwZSAqLw0KPiA+ICsJaWYgKFdBUk5fT05fT05DRShod19pbmZvX3R5cGUgPT0gSU9NTVVfSFdf
SU5GT19UWVBFX05PTkUpKSB7DQo+ID4gKwkJcmMgPSAtRU5PREVWOw0KPiA+ICsJCWdvdG8gb3V0
X2VycjsNCj4gPiArCX0NCj4gPiArDQo+ID4gKwlsZW5ndGggPSBtaW4oY21kLT5kYXRhX2xlbiwg
ZGF0YV9sZW4pOw0KPiA+ICsJaWYgKGNvcHlfdG9fdXNlcih1c2VyX3B0ciwgZGF0YSwgbGVuZ3Ro
KSkgew0KPiA+ICsJCXJjID0gLUVGQVVMVDsNCj4gPiArCQlnb3RvIG91dF9lcnI7DQo+ID4gKwl9
DQo+ID4gKw0KPiA+ICtkb25lOg0KPiA+ICsJLyoNCj4gPiArCSAqIFplcm8gdGhlIHRyYWlsaW5n
IGJ5dGVzIGlmIHRoZSB1c2VyIGJ1ZmZlciBpcyBiaWdnZXIgdGhhbiB0aGUNCj4gPiArCSAqIGRh
dGEgc2l6ZSBrZXJuZWwgYWN0dWFsbHkgaGFzLg0KPiA+ICsJICovDQo+ID4gKwlpZiAobGVuZ3Ro
IDwgY21kLT5kYXRhX2xlbikgew0KPiA+ICsJCXJjID0gaW9tbXVmZF96ZXJvX2ZpbGxfdXNlcih1
c2VyX3B0ciArIGxlbmd0aCwNCj4gPiArCQkJCQkgICAgY21kLT5kYXRhX2xlbiAtIGxlbmd0aCk7
DQo+ID4gKwkJaWYgKHJjKQ0KPiA+ICsJCQlnb3RvIG91dF9lcnI7DQo+ID4gKwl9DQo+ID4gKw0K
PiA+ICsJY21kLT5kYXRhX2xlbiA9IGxlbmd0aDsNCj4gPiArCWNtZC0+b3V0X2RhdGFfdHlwZSA9
IGh3X2luZm9fdHlwZTsNCj4gPiArCXJjID0gaW9tbXVmZF91Y21kX3Jlc3BvbmQodWNtZCwgc2l6
ZW9mKCpjbWQpKTsNCj4gPiArDQo+ID4gK291dF9lcnI6DQo+ID4gKwlrZnJlZShkYXRhKTsNCj4g
PiArCWlvbW11ZmRfcHV0X29iamVjdCgmaWRldi0+b2JqKTsNCj4gPiArCXJldHVybiByYzsNCj4g
PiArfQ0KPiA+ICsNCj4gDQo+IE90aGVycyBsb29rIGdvb2QgdG8gbWUsIGZlZWwgZnJlZSB0byBh
ZGQ6DQo+IA0KPiBSZXZpZXdlZC1ieTogTHUgQmFvbHUgPGJhb2x1Lmx1QGxpbnV4LmludGVsLmNv
bT4NCj4gDQo+IGFmdGVyIGFib3ZlIGFyZSBhZGRyZXNzZWQuDQoNClJlZ2FyZHMsDQpZaSBMaXUN
Cg==
