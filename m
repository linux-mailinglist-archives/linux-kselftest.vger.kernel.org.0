Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21329732548
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Jun 2023 04:29:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240805AbjFPC3l (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 15 Jun 2023 22:29:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231244AbjFPC3k (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 15 Jun 2023 22:29:40 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7956E2719;
        Thu, 15 Jun 2023 19:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686882579; x=1718418579;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=tPqen7bI/Qp3dtb2hfn9c/mBoYmn6ingfsJJK3PZL08=;
  b=iknrUglgxI0auyy+hFgoOippHhLBfalu8lzjLOe2K62+V13j7JrHtbCk
   t1t4Fra3btBSn8I3x8J3qW3XYzC3MjK66iIQz2UiM7cWKa4EqDzNRnTNn
   fc8iKhL6XfUbdASMdNai/l3cnTefkExlhQpQolnT7xJbzexpm15jXIWK4
   2xiuRyf3ML2oHFZAXhVH3LMxNu9zlp+nVkksn8i2tRAv5jabXUrS4RwwR
   Nkw9zlRv+ky8q6SXFt+ngiJ3HC2xImVaKucKt1lcFLlWuY0ImfPZ4avaX
   6O4NGD9foHCD5hi6/z7ATV4KSKk8H1qgbY07FI8P0+MhvY8Ug+wJZd9KL
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="357970737"
X-IronPort-AV: E=Sophos;i="6.00,246,1681196400"; 
   d="scan'208";a="357970737"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2023 19:29:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="742473810"
X-IronPort-AV: E=Sophos;i="6.00,246,1681196400"; 
   d="scan'208";a="742473810"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga008.jf.intel.com with ESMTP; 15 Jun 2023 19:29:37 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 15 Jun 2023 19:29:37 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 15 Jun 2023 19:29:36 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 15 Jun 2023 19:29:36 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.171)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 15 Jun 2023 19:29:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZezX5DoZxiaRhM9O/1FfBOvFMh1IkLjoCNaHbwMoaMcGR/NiMKGhk7faZiad/Nx+bM7/o36dCK4WvS7XPdtRHNZFRgXslC210XMYOYSqkqVRPyQ9RK2QMjNN+xKSUrFQfHTwPpSK9CsrE8ANWpaHBCOw+Ff5rLamFL+gK9IxCGhqt85zjrp5m/YX2SSbkcRGbc7vhU3U7XDeqmBRiOStoFJltE6J0bHWK+CH1WCrkGjssQeif1P/XVvmez3uKCV+efzi313hiBbH41m7LYaNT1hGuGDsp0oaaFsUO14RG1A+6iBTF+QTG0gADernOOQb7EpRmkfbWlEkxNNuTxGsmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tPqen7bI/Qp3dtb2hfn9c/mBoYmn6ingfsJJK3PZL08=;
 b=g7iekAW2DQrKUNC2fFfo1tYJrQQF3zYF7NgDQXd15nmRH4PS5mzdBJGYzWY8LEeR2jI0ILwB+Z/W/p7140nhBE6KH9wCI17WYKQSbpIYG6im0VRHvsiAZVgMEl74yfm2wztb/a195QRCQJvDy1sy5/8fhqaPxhJhWdElOJt2YbOhL7dG6IPzYYxzn5411SkBc2E30FewJ0c/W6pGEgH4rYXvFba+6DqL3oxezThvRdr7aSKyYabJMzyqiIb4+iDtylPqjU3lVWFz0ZcMD6H8iju2n4ruhoMePRsSVR78DAaY6tfLUKWDpJHCHpWwLyzJ93VfHrWtZW6u5xZAvbaxPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by MN2PR11MB4533.namprd11.prod.outlook.com (2603:10b6:208:264::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.37; Fri, 16 Jun
 2023 02:29:34 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::4f05:6b0b:dbc8:abbb]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::4f05:6b0b:dbc8:abbb%7]) with mapi id 15.20.6500.026; Fri, 16 Jun 2023
 02:29:34 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     "Liu, Yi L" <yi.l.liu@intel.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
        "cohuck@redhat.com" <cohuck@redhat.com>,
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
Thread-Index: AQHZhBgNtWChyqGR00+u6nwW5Oa+KK9pLIFQgAiGGgCAGHH8MIAAQLSAgAKGnzA=
Date:   Fri, 16 Jun 2023 02:29:34 +0000
Message-ID: <BN9PR11MB5276281676BAC321CB08D1048C58A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230511145110.27707-1-yi.l.liu@intel.com>
 <BN9PR11MB52765FA8255FB8F8A1A6F11B8C419@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZHTyNgnjj/bOkIgi@nvidia.com>
 <BN9PR11MB5276B15B4709F595B2A5A84A8C5AA@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZImqERPS0UV6mBsG@nvidia.com>
In-Reply-To: <ZImqERPS0UV6mBsG@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|MN2PR11MB4533:EE_
x-ms-office365-filtering-correlation-id: 61bcc35f-94e8-42b9-c6ce-08db6e1185cf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: q4VUhh8yF92vrcBIh/EkX3hASWLS0purYPWXXJkYdl8QRWkFJEvuR5+8UBC64YMCA1s1BmVMsDItdwLbitdD6JqGOOheLV/IfkVad1xOvqmAD7iuFosZsqUCVJa7uRN7eLKpxC0ShtQtqOpv/UdHBdlWCGC1HLRsJzwG252wBF1EsAVGRMCK2VVZmA5ckpI9vNgjXX20bxYAnusKUbjRBxC9ht2LTfeMq/4MxJ+5rUj9z+qGA/k6FxqV/PAkVCSQWlh/+XZadjW5pDU8ONlvscMNXkBQh/qiEjSfF99erP64HIW87Am7zoStx59seniwdhteu/AGB9hAAOLIisIoODq+c/n5eim0Ej7x4ipHKmGj5Z8I5ltSSxr9QkfuirrVUhPU8PfMKfrXzFENibg/wFsz4GcH+li7ron+M4xqtFWNlqVJCeeQmyAvqjm10/hc+mfrx8lp1g1Zgh+7WMvfukne/NA7HLjz5c/N0DyxwBBRpaOjamTcghHb0AIetlLL3afw47AaoYDeqMMIq5xqjCqV549ct4tt7TXPkKetioBZk5QixgRy9ldwnVvxcl/KxQdMKNDC4JyRXP1edHl7qL4mb5GRIRsxA8lK+d+z8vJbSpPhX2N2u3qTDlh7wK8p
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(396003)(366004)(136003)(346002)(39860400002)(451199021)(186003)(38070700005)(2906002)(33656002)(38100700002)(4744005)(7416002)(86362001)(26005)(55016003)(9686003)(6506007)(122000001)(82960400001)(66446008)(4326008)(316002)(71200400001)(66476007)(64756008)(76116006)(66556008)(6916009)(7696005)(66946007)(478600001)(41300700001)(54906003)(8676002)(5660300002)(8936002)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dHk3WC9OalpoVUNCaHhnZFNDdEVjRFdvTkcwcUkwMW9URFovOFZUblZPdzJG?=
 =?utf-8?B?cWtYZWRjYWs5UXl0V3laUitwWGxhdENqVVNYbUVEcUZwRzU2N0NlU2pFR0RU?=
 =?utf-8?B?MStpRyt1ZHhkL1F1RkJxd2p0WnkxaGt6NExpdkpwMTh3ZkFDeDZEUnJuWnh1?=
 =?utf-8?B?ZGxyblFRQURQaW52NENVSnJ5S091OWdXTEJUaUd5TkY4bVM4Tmk3dWxzNnI4?=
 =?utf-8?B?bmRhZXlNU1hvSnRmSjBhMEFCeisrckVVS1NuUldFZ1JvQ2J3NW1aWkJLVEc5?=
 =?utf-8?B?QkRlRGYzTXZySk1yQitoNXpIcjlyU0RTL0Yvc1QwMGNzemkwaEQrU1Z4M2xU?=
 =?utf-8?B?d1lNdVpCaXczZkpWRWtjY3N2MWtCVTc2bVFqdnBlSWR1bU5WWk0xWFYzOGpX?=
 =?utf-8?B?eXNwNndnVFUxRHpJbWZjb3NiOWJCbjVrMklqQ1dVL1JSRnk5MFE3c2NORzBw?=
 =?utf-8?B?RGJudFRoOExRU1JVT3NFNEx0MFJNSVJ0cTdpUWRaRlEwWFJ3YUhkY28rMkZS?=
 =?utf-8?B?emd1aVMzMkwvMEpEYWk5RUNZdEhxaFdwb0xGM1dUanI4T29YclJxMlNzWmEx?=
 =?utf-8?B?RG5hRnlodG9pamM4TE1WRTY2NVMyTVo4MWMyc20xL1Y0V0NZdVp5T0RMZnVN?=
 =?utf-8?B?bHArK0RsM3B3d28vMmU1K2JHajMvOFpwbGpPSGpoSzhub3RjenNlY2RlNFov?=
 =?utf-8?B?WXcyQ2c1UVpwRDhCMXZONHNRUVJMakZJOUxmMHhwS2FaUDdsQWt2Wlk1VnR5?=
 =?utf-8?B?UFo5MDJyNFlkRzNvN0xMcTM1M3gybDFSMEh3dVJBNG5ibTR1N2kvcEdqR1VE?=
 =?utf-8?B?TlpaWXZtOU1RTXlxZkR1S2taa1ZRU1ZTanJaYktXdk5pWFpXTW8yUEFxYnoy?=
 =?utf-8?B?djQ2Wk54cjQwaGcveUsxOVpyank1QUNtUTN5Z1BPVHRtczlwSjZXcG1JOGEz?=
 =?utf-8?B?SXBGK1JxQnZ1ZFE5eHdncVB6V0c3eWRYVmdOU2hVUXhxYjBXNFdJcHp5eENB?=
 =?utf-8?B?R3F1aU9Tc1dNaTdvUFREYkZIWlhUQU8vU2E5MEJrc2prQ0l6UCtXMCsvRFIw?=
 =?utf-8?B?YmlSeVYyU2lGREEzb1NJY0JtWnFHV2U5TnJIUHNVWG5lOGI5NSs0VVZwdUIv?=
 =?utf-8?B?OHpxODZydlV1dU5yV1UrL0ZBYmpMMUM1YjBKY0JSdkRqdWhsNEk2QWplcjBt?=
 =?utf-8?B?Ry9zOXZzWXFnM1pNUTdscXR6cTRwWW5wTW9mMWFrTEtoZVZRWEZraTdWNGpk?=
 =?utf-8?B?TWtZb1liRCtXemI4dUlmUU9uUUhFOWRpTEI5UytGa3E3Zm5waTg1T24venFx?=
 =?utf-8?B?NGtlQ1pDZ0cwZ3BLL1JvT0I2REg4SFZpb1FNSHowSk9DQzArV2Vab0pNRjha?=
 =?utf-8?B?TnAxRUtNYjFoMTkreWtETG0wMitVVVMwVDRQNi9idUlYUk5vUVg1Wk1PMmZY?=
 =?utf-8?B?YXlTUVV5NHNwWWlzSFlCTDRpVG9zS3lMcFJ4SXJkejJ3REtad1hUaFhNY3Vm?=
 =?utf-8?B?ZkpOWWpyWHczNlZ6RldxRWxoQmZCSVlEU09DOTQzbVpocGFlMjA3NnJlMHJ3?=
 =?utf-8?B?NkZ0SHdXcHBKZzZWcWx6eFNybk0wd284STlCTHJiSkdNeUhxY2JEaHB0MUNP?=
 =?utf-8?B?dGRtZXl6R0ljOW1xMHkzYkU4MGlLaEh1enhIaU9jaVM1bnFWMmxTb3paMkpy?=
 =?utf-8?B?ajREVkZBeDBLbENPSnFYSUNuN3d1VzZKZlJrWGJEa3lnSXNML0oxMGUvU3Fv?=
 =?utf-8?B?ZE9ncG1sdzYwZXFBWEdYKzBvQ1Y1VzdEWXhYL2NJemZ4WUxrekFJeUNzREJt?=
 =?utf-8?B?MUtZNzNnNE9YenMzRS92Z0xSVFR3QWZYNEd1U1k3blV3SHFiQ1Brcm94c0I2?=
 =?utf-8?B?L0FXbXpDNHV0WU9kanMrK2ZEeFFQOVJ2YnFCZ29yMENNUUhXZGRKTnFidkYy?=
 =?utf-8?B?S3hMQzc4R2src2hYTnMvNHJGdzN3VE4vcnRFenhFZnBjREpPTWVYeklCaThW?=
 =?utf-8?B?WEhrWmpDWlE2YUlHSU1Ya1JtNTlKZFFUNHhNZ1VvSEdmOUk1N2srNm92bU54?=
 =?utf-8?B?Q01sUjJ3V2t3b1VSclpyME10WHVmc3g0TlFVK2RYSHVTdDRKYWFjYUVTd3Ru?=
 =?utf-8?Q?hlbF+L/s9Bwk6IdyfVhyM95C5?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61bcc35f-94e8-42b9-c6ce-08db6e1185cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2023 02:29:34.1483
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Kn2dC6pIBKJskX+BS0UUoq438i4PPB3BO2rehI80Y0ehjIm2etWC6d5j0zFwPO3+hSSgH1/MW5I0CagrQEOjtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4533
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

PiBGcm9tOiBKYXNvbiBHdW50aG9ycGUgPGpnZ0BudmlkaWEuY29tPg0KPiBTZW50OiBXZWRuZXNk
YXksIEp1bmUgMTQsIDIwMjMgNzo1MyBQTQ0KPiANCj4gT24gV2VkLCBKdW4gMTQsIDIwMjMgYXQg
MDg6MDc6MzBBTSArMDAwMCwgVGlhbiwgS2V2aW4gd3JvdGU6DQo+IA0KPiA+IHRoaW5rIG9mIGEg
c2NlbmFyaW8gd2hlcmUgdGhlIHZiaW9zIG1lbW9yeSBpcyBzaGFyZWQgYnkgbXVsdGlwbGUgcWVt
dQ0KPiA+IGluc3RhbmNlcyB0aGVuIFJXIGFsbG93cyBhIG1hbGljaW91cyBWTSB0byBtb2RpZnkg
dGhlIHNoYXJlZCBjb250ZW50DQo+ID4gdGhlbiBwb3RlbnRpYWxseSBhdHRhY2tpbmcgb3RoZXIg
Vk1zLg0KPiANCj4gcWVtdSB3b3VsZCBoYXZlIHRvIG1hcCB0aGUgdmJpb3MgYXMgTUFQX1BSSVZB
VEUgV1JJVEUgYmVmb3JlIHRoZQ0KPiBpb21tdQ0KPiBzaWRlIGNvdWxkIG1hcCBpdCB3cml0YWJs
ZSwgc28gdGhpcyBpcyBub3QgYSByZWFsIHdvcnJ5Lg0KPiANCg0KTWFrZSBzZW5zZS4NCg0KYnV0
IElNSE8gaXQncyBzdGlsbCBzYWZlciB0byByZWR1Y2UgdGhlIHBlcm1pc3Npb24gKFJPLT5OUCkg
dGhhbiBpbmNyZWFzaW5nDQp0aGUgcGVybWlzc2lvbiAoUk8tPlJXKSB3aGVuIGZhaXRoZnVsbHkg
ZW11bGF0aW5nIGJhcmUgbWV0YWwgYmVoYXZpb3INCmlzIGltcG9zc2libGUsIGVzcGVjaWFsbHkg
d2hlbiB0aGVyZSBpcyBubyByZWFsIHVzYWdlIGNvdW50aW5nIG9uIGl0LiDwn5iKDQo=
