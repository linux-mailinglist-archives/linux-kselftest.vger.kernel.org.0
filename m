Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D2DD481812
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Dec 2021 02:28:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233970AbhL3B2L (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 29 Dec 2021 20:28:11 -0500
Received: from mga02.intel.com ([134.134.136.20]:50458 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233914AbhL3B2K (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 29 Dec 2021 20:28:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640827690; x=1672363690;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=dZE0sj/xpHRsQ0esnyGEgHrp1HwrLDrT4AkIVVVc+ig=;
  b=C0zV/7VjV3WxYh9ipJSfITQlhfUmJ79cGossSaBOrfFvPKrYLqp8oL2G
   kmQI1elMf+REw2SebjhIyc3dED9Z+Bhnb+45S5WjbSLoVW6tZ2mSbxuuq
   ab2Xtql6X0dLjaqlm/g3IJMY2p9//GYiPEblyxMsSRNYPhbke1GXWoP9m
   GXfXUmL2MEyWSmkJzwAk0YJvXbWNG8COTyWSfJLpL8NAeuY5OTmMIIYeH
   IYr11K4/YJkhDZtVdElZmhrC8TMSnZP4u/q9juqdBiMY/cL4wcIC/TpOK
   /4o4Ww0qtuLEdQEsJFBvJbc9Rjiw/OT0uY77qelvNtsRsDpKMumfLoqGs
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10212"; a="228906122"
X-IronPort-AV: E=Sophos;i="5.88,247,1635231600"; 
   d="scan'208";a="228906122"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2021 17:28:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,247,1635231600"; 
   d="scan'208";a="589420958"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga004.fm.intel.com with ESMTP; 29 Dec 2021 17:28:06 -0800
Received: from fmsmsx604.amr.corp.intel.com (10.18.126.84) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 29 Dec 2021 17:28:06 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Wed, 29 Dec 2021 17:28:06 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Wed, 29 Dec 2021 17:28:06 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NGqnXI7W3WJgem8PJCgZ8T6T4KzzCrv3yVObC/Z2x+jaROjPfOkLXtl6l3JGPI4QqCJMtsQbNWAzVV7r2c9pC2qQ3m1jaN8nEUPlZzfNWCBh/dJdF+I5k19L0gskUqrRTBbBPpmGlwzYdbO/Us3+cU2FMhq04fZaTs3qNL5tqFhQCRcwTWIdS09xFoOasu/+PEqs4L15O9flLN8fektFk6a+k/Ta0o291tES9oCLg6S+bwEo0LkaE9vvVdZ+j2WWUIrWH4StOnYfreWcZtUDQn7joLRo2Dsk341iAdFKGSN1APxd4X0Sz9YP1oFD9n4Yl6UMDtiJmyeznogS0MBieg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dZE0sj/xpHRsQ0esnyGEgHrp1HwrLDrT4AkIVVVc+ig=;
 b=cLZAz8zxKJwxpXiPL9mvDaQivhliqOPB4Dp9GQDoTpsPpJclM7cD1Wj1Y20n9uhWVpss8Nwmc6vr8IK4HjdYrtJGD+ZBh3b09e2EJL8C83cQmWWo/1vdhh19ly9QM3Z/WVwMn/6fLIT8fy4K2mPQWGY9N5i5h26jmImwtF/OBp4NpwWARy8lTXxsX6GzeiSL2QlqNjzxK6K+7OXueNl35BRnaC8fNFDzq4mpELSJVXTOZ+KDJf4Nr7oVn3CobCkpzwJ0nH/MefqFjOnXVi86nAVInxmQqlGk3EVNLn8LIVwWhc7ieIloRl09FXTAJryfC8BQWXBrk1mZ98f429vBMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by BN6PR11MB1571.namprd11.prod.outlook.com (2603:10b6:405:d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.19; Thu, 30 Dec
 2021 01:28:02 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::5c8a:9266:d416:3e04]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::5c8a:9266:d416:3e04%2]) with mapi id 15.20.4844.014; Thu, 30 Dec 2021
 01:28:02 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     "Christopherson,, Sean" <seanjc@google.com>
CC:     "Liu, Jing2" <jing2.liu@intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "Nakajima, Jun" <jun.nakajima@intel.com>,
        "jing2.liu@linux.intel.com" <jing2.liu@linux.intel.com>,
        "Zeng, Guang" <guang.zeng@intel.com>,
        "Wang, Wei W" <wei.w.wang@intel.com>,
        "Zhong, Yang" <yang.zhong@intel.com>
Subject: RE: [PATCH v3 22/22] kvm: x86: Disable interception for IA32_XFD on
 demand
Thread-Topic: [PATCH v3 22/22] kvm: x86: Disable interception for IA32_XFD on
 demand
Thread-Index: AQHX9zE4gQJMQm2XFEKlfvGX4m1Fn6xIsbuAgAAjG3CAAD2qsIAAsXqAgAB7lVA=
Date:   Thu, 30 Dec 2021 01:28:01 +0000
Message-ID: <BN9PR11MB5276C27CFB068B7CB8CFD3908C459@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20211222124052.644626-1-jing2.liu@intel.com>
 <20211222124052.644626-23-jing2.liu@intel.com> <Ycu0KVq9PfuygKKx@google.com>
 <BN9PR11MB5276CE5635898CE13BFC57FC8C449@BN9PR11MB5276.namprd11.prod.outlook.com>
 <YcyaN7V4wwGI7wDV@google.com>
In-Reply-To: <YcyaN7V4wwGI7wDV@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.6.200.16
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c47145f2-f449-4347-aa53-08d9cb339f05
x-ms-traffictypediagnostic: BN6PR11MB1571:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <BN6PR11MB1571422BD335555C1B69A17F8C459@BN6PR11MB1571.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Qw5M1mDoETA7qd+/s3W+mFP4W8yR8XKGQy2nkBFpUjRyoGaKHryTFv2o9xyHFSOut0FmXfmbMX1wymRB0jTeI6N0J5Lm8oChvJNcAVwJqkMxw/0zdlDAzbyeh/U5bgHSmaFI3HrM2rDO2ce+aUgcM3TCRjXoDLa5YTgBrhu2ZwuMxRr8VZyIlMzH/jNFfB55qWgOIixV+etluliyIsGK+zAXPUTqPxwOfgNe+YDVo/G/hJaeB3WqAXmY2/HDmaB8FpCkFjDNQyK7Dcaa8QTheAnsUftUUiEHa95sm2BlvmNL9duZbgzdPVtJfw3BY75REmkDoR4lvXF6aA614pV3aDO1nhCkhuMOczijSIRqx6RTCuEq9bGc/KPtaPs76BCk/4+ItTTBB7nCxTOgi8OmK1wGDDWP+pNDqW6MdMsC4DoW7Wfa9AFJvpOAGIA+WuUDVFhAZHMlpAU7V+ltHpjJGEIFUGRXJH4I5Y83h5m3p1ZjOne73hchistZi6ZGqdLI8Gjz+dMtb7UcFkgGBfU/HJIKqd73EGVmyRdM7SuzvQ03pAznJze1oQB9tBZEoZj4dwdr/DFKJFhLQXcQj6sd18QYYWaoIO2Y1bTMpLPxgl4pPnyYOOs9SKBdWROi374p/TL+JnJLcl3qdwGi0WLtftHnMvOIycaGzgo/B5etCQTiznUcxkIizc5T3hsZbF2xb9v+Nb41xoD2Zgwth87PSw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(52536014)(186003)(86362001)(5660300002)(7416002)(54906003)(9686003)(83380400001)(82960400001)(71200400001)(6916009)(6506007)(316002)(4326008)(2906002)(66556008)(66946007)(26005)(64756008)(66476007)(38070700005)(38100700002)(7696005)(66446008)(76116006)(508600001)(8936002)(8676002)(122000001)(33656002)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bmdVUXE3b3V0N2ozZHd5VHF6RnExaHBLdmYxTCs5L3pKcFprWXc5Q05La2k2?=
 =?utf-8?B?TEhjdDN2QnpHemJlNEdaWnE5K3BDMkQ1QWc4NHAzOEs1RGsvRjRMWUM4dmtu?=
 =?utf-8?B?U2VaSjZoRXVxQWR3M3JPdjUraThEZGxXVk56cjdDVHB0SmZDT05kSTFzaWFX?=
 =?utf-8?B?QjYxZUtrRnFmbEk1R3hpMytTcUpjTzMvTEpSWmlHNzZzSktROFNITXJaKzhP?=
 =?utf-8?B?K2VUNHRYTHJnV3FOMWE0WWJ0YkdlK3RNUG5LaHNyUDRyblpOTVNnK3FVdHBk?=
 =?utf-8?B?UzFOMnJ4WDhSMlhIY0dtTVRscGhWOHgxTGNIT091ZHBtOUdkazNnZmUrRmdt?=
 =?utf-8?B?Mnd5UDczc0FVRHY1V3psTkx1UmMybUdCL3RleHRoREFSaXE0dy9PdTBkZkFi?=
 =?utf-8?B?YVlmYXpYd1NGTGdsNWYzbU1Eb0tXT1d0SSswZHhOc203dlBuNVZnRWRiNis3?=
 =?utf-8?B?cnJ4ODdzbW4wZ2hRT1FaSXV3QVZkbGpkc2dYVi9KZWEzT0tpMndMVys1dmoz?=
 =?utf-8?B?NVJkY2hYbVRoMzRyblNYODVRWnhSVGY5enp2WVNCWnlVRUJiaFpDZnlqY2wx?=
 =?utf-8?B?NkQwS3A1U2U5R3Z0dXQ5N2hoQk03T0FKcGcxOXVvUjM3b0ZBQUV6MDVFQXo1?=
 =?utf-8?B?YnVVMTM0ek5zOXJIbExMb2dQWlVvRzR0Q0F2MTlPYndMNUhvdUVpNVlJdmJ0?=
 =?utf-8?B?SUV1WG8yWUNCRHEzU2FTWGVVWWZUYzcyTDdjakF5c0VzOERCcHY1aDhzd1FM?=
 =?utf-8?B?bHluUFpsUU1IRGJSazJMYndEZkZjdG9JZGpHT3VoSGsvY0VvSThhOHhhYTQr?=
 =?utf-8?B?S3NXU3lkUmtHSXRBOVJnc2J3aTZSWEZIUUQxRTAxTkd3OWpUMHZrT0x5UUhI?=
 =?utf-8?B?aDF5czVsQTAxNzF4RjBNVDNncGQxb0JnRS9nRHphakxXUlpOTWlXeU4zQ3Jz?=
 =?utf-8?B?SjlMUkxMeHpGWUJwbmlTSmt2cGkwYVdCMWhpaFYwOGY1VGU1ZUxnalB6bHkz?=
 =?utf-8?B?azkrdXJlZGV3dVlLcnQxZWYxWU5mSzNaQmVYU1B1NkZFeHM0SFMwenBSQkE4?=
 =?utf-8?B?eFpDN0JUMmY3TXNHVXdhYk1wM082QllWeFNOaE1mcEhiWFVkSWdZY2hWWHlP?=
 =?utf-8?B?NWZWQVA2a1FpWnNBbjRiOEw3dzRHZDA1QlpFMnZ1V3lCcnBrWEMyaGNxWlFU?=
 =?utf-8?B?MkduL1JReFZPaWFJeHlHVnhDY01YWFlzWW9yblZBRHEydDJ2dWxxc0ZYbFhX?=
 =?utf-8?B?VHJLR055ZU1Fbmhma1QycVRCN2lPVlhXY3hMb3hNTXJySENYMUlYN1FrSi9F?=
 =?utf-8?B?bUtnRGlPSHVndUltKzlXdTdLK3pNbmRTaTNDMVlIMUpQc2J1ZnFyTnk3TjRt?=
 =?utf-8?B?TkVDa0NIbUp2Rm1BR2ZJblFkSGFNcSt2UTNLa2RrS2h3SWhybmtTSWprdVVw?=
 =?utf-8?B?VTV2bTVYdzVVV2FteXJZcjVMTCtCbno1SFJlUzB4VVRENUoxQ1VtUno2RHB6?=
 =?utf-8?B?Wml3MTBEUGR6VGdLZEMwV3dFMTBRYTU5T3ExcmNWZm1WblhaQ05QOXVpWmRy?=
 =?utf-8?B?TmoyY05IeUJNZjNBcXVwMExHVW1EM1VQNUp1TGY2R3hpcWNKaUJMbm14d05q?=
 =?utf-8?B?Q0NTRUc5VTNjY3NYT2hGa0ZJMHhKOUN5VTJ2bnJxelphQzhIMEJycExuc2dm?=
 =?utf-8?B?U1liblg3VE5jdDR5eU1Lc2FPSS9vbVFoN0NCNC8yY1lnZnoxaXdFQTYwbzNC?=
 =?utf-8?B?bnpyM1lWZEtDc1B0ZVB3WEFNMWtpTFlLa0hTQnREVDFPeXNieEFWWDBYLzNL?=
 =?utf-8?B?ZmdjRW0wSVdCUFpaRzdvOGRCdWpRUnM4RDZqeGdHdWwzZTdSeVQxVzFVS0s1?=
 =?utf-8?B?K1NyaWxGaFl3eWRDc1IwUVU2ZEd0a0tnZFJhL0VQUHNnQjczbWpaSlg4bGsw?=
 =?utf-8?B?WUlWVWc3dUhEbzZ4U3dPajJyMlJsMXRCK2ZMK0xuRllmWFFkMWY3UUR4c1c5?=
 =?utf-8?B?VDc5MTlzSE14VmhORW9uNTQzODhONXIzcEx0eHZHMGxCZjFMbHhHWDc0cHY4?=
 =?utf-8?B?YThjTUo2eHFkZlg4UU5McUNJTm0yTGt0MTFvSzlTaTB1SjNrRDBiaGR3MURr?=
 =?utf-8?B?eGdjVXVlY1lXRCs5a0FnKzB1SHdhSEFLSzFSZmRWdmFWN1E0WGZFVGh2V01L?=
 =?utf-8?Q?FKNpjr9rBed8U/mqpanoFcI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c47145f2-f449-4347-aa53-08d9cb339f05
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Dec 2021 01:28:01.9602
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XJvZJ0rUhfkuYj8M26loqVnaGzGgDftOGCtmqeWeB/V4FcMq5gBzaiEb8nhf1Buxk21QLNfOOm7cUrnAsnNQMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1571
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

PiBGcm9tOiBTZWFuIENocmlzdG9waGVyc29uIDxzZWFuamNAZ29vZ2xlLmNvbT4NCj4gU2VudDog
VGh1cnNkYXksIERlY2VtYmVyIDMwLCAyMDIxIDE6MjYgQU0NCj4gDQo+IE9uIFdlZCwgRGVjIDI5
LCAyMDIxLCBUaWFuLCBLZXZpbiB3cm90ZToNCj4gPiA+IEZyb206IFRpYW4sIEtldmluDQo+ID4g
PiBTZW50OiBXZWRuZXNkYXksIERlY2VtYmVyIDI5LCAyMDIxIDExOjM1IEFNDQo+ID4gPiA+DQo+
ID4gPiA+IFNwZWFraW5nIG9mIG5lc3RlZCwgaW50ZXJjZXB0aW9uIG9mICNOTSBpbg0KPiA+ID4g
dm14X3VwZGF0ZV9leGNlcHRpb25fYml0bWFwKCkNCj4gPiA+ID4gaXMgd3JvbmcNCj4gPiA+ID4g
d2l0aCByZXNwZWN0IHRvIG5lc3RlZCBndWVzdHMuICBVbnRpbCBYRkQgaXMgc3VwcG9ydGVkIGZv
ciBMMiwgd2hpY2ggSQ0KPiBkaWRuJ3QNCj4gPiA+ID4gc2VlDQo+ID4gPiA+IGluIHRoaXMgc2Vy
aWVzLCAjTk0gc2hvdWxkIG5vdCBiZSBpbnRlcmNlcHRlZCB3aGlsZSBMMiBpcyBydW5uaW5nLg0K
PiA+ID4NCj4gPiA+IENhbiB5b3UgcmVtaW5kIHdoYXQgYWRkaXRpb25hbCB0aGluZyBpcyByZXF1
aXJlZCB0byBzdXBwb3J0IFhGRCBmb3IgTDI/DQo+ID4NCj4gPiBvaywgYXQgbGVhc3Qgd2UgcmVx
dWlyZSBhZGRpdGlvbmFsIHdvcmsgb24gd2hlbiB0byBkaXNhYmxlIHdyaXRlDQo+IGludGVyY2Vw
dGlvbi4NCj4gPiBJdCBjYW4gYmUgZG9uZSBvbmx5IHdoZW4gYm90aCBMMCBhbmQgTDEgbWFrZSB0
aGUgc2FtZSBkZWNpc2lvbiwganVzdCBsaWtlDQo+ID4gd2hhdCB3ZSBkaWQgZm9yIG1hbnkgb3Ro
ZXIgVk1DUyBzZXR0aW5ncy4uLg0KPiANCj4gSSdtIG5vdCB0ZXJyaWJseSBjb25jZXJuZWQgd2l0
aCBleHBvc2luZyBYRkQgdG8gTDIgcmlnaHQgbm93LCBJJ20gbXVjaCBtb3JlDQo+IGNvbmNlcm5l
ZCB3aXRoIG5vdCBicmVha2luZyBuVk1YIHdoZW4gWEZEIGlzIGV4cG9zZWQgdG8gTDEuDQo+IA0K
PiA+ID4gSWYgb25seSBhYm91dCBwZXJmb3JtYW5jZSBJIHByZWZlciB0byB0aGUgY3VycmVudCBj
b25zZXJ2YXRpdmUgYXBwcm9hY2gNCj4gPiA+IGFzIHRoZSBmaXJzdCBzdGVwLiBBcyBleHBsYWlu
ZWQgZWFybGllciwgI05NIHNob3VsZCBiZSByYXJlIGlmIHRoZSBndWVzdA0KPiA+ID4gZG9lc24n
dCBydW4gQU1YIGFwcGxpY2F0aW9ucyBhdCBhbGwuIEFkZGluZyBuZXN0ZWQgaW50byB0aGlzIHBp
Y3R1cmUNCj4gZG9lc24ndA0KPiA+ID4gbWFrZSB0aGluZ3MgYSBsb3Qgd29yc2VyLg0KPiA+DQo+
ID4gQWxsIHlvdXIgY29tbWVudHMgaW5jb3Jwb3JhdGVkIGV4Y2VwdCB0aGlzIG9uZS4gQXMgc2Fp
ZCBhbHdheXMgdHJhcHBpbmcNCj4gPiAjTk0gZm9yIEwyIGlzIG5vdCBhIGJpZyBwcm9ibGVtLCBh
cyBsb25nIGFzIGl0J3MgcmFyZSBhbmQgZG9uJ3QgYnJlYWsNCj4gZnVuY3Rpb24uDQo+ID4gVXN1
YWxseSBhIHJlbGF0aXZlbHkgc3RhdGljIHNjaGVtZSBpcyBzYWZlciB0aGFuIGEgZHluYW1pYyBv
bmUgaW4gY2FzZSBvZg0KPiA+IGFueXRoaW5nIG92ZXJsb29rZWQgZm9yIHRoZSBpbml0aWFsIGlt
cGxlbWVudGF0aW9uLiDwn5iKDQo+IA0KPiBJIHN0cm9uZ2x5IGRpc2FncmVlLCBpdCdzIG5vdCBh
dXRvbWFnaWNhbGx5IHNhZmVyLiAgRWl0aGVyIHdheSwgd2UgbmVlZCB0bw0KPiB2YWxpZGF0ZQ0K
PiB0aGF0IEtWTSBkb2VzIHRoZSBjb3JyZWN0IHRoaW5nIHdpdGggcmVzcGVjdCB0byB2bWNzMTIu
ICBFLmcuIGRvZXMgS1ZNDQo+IGNvcnJlY3RseQ0KPiByZWZsZWN0IHRoZSAjTk0gYmFjayB0byBM
MiB3aGVuIGl0J3Mgbm90IGludGVyY2VwdGVkIGJ5IEwxPyAgRG9lcyBpdA0KPiBzeW50aGVzaXpl
IGENCj4gbmVzdGVkIFZNLUV4aXQgd2hlbiBpdCBpcyBpbnRlcmNlcHRlZCBieSBMMT8gIFRoZSB0
ZXN0aW5nIHJlcXVpcmVkIGRvZXNuJ3QNCj4gbWFnaWNhbGx5DQo+IGdvIGF3YXkuDQo+IA0KPiBB
cyBwb3N0ZWQsIHRoZXJlIGlzIHplcm8gY2hhbmNlIHRoYXQgdGhlIHBhdGNoZXMgY29ycmVjdGx5
IGhhbmRsaW5nICNOTSBpbiBMMg0KPiBiZWNhdXNlIG5lc3RlZF92bXhfbDBfd2FudHNfZXhpdCgp
IGRvZXNuJ3QgcHJldmVudCBhbiAjTk0gZnJvbSBiZWluZw0KPiBmb3J3YXJkZWQNCj4gdG8gTDEu
ICBFLmcuIGlmIEwwIChLVk0pIGFuZCBMMSBib3RoIGludGVyY2VwdCAjTk0sIGhhbmRsZV9leGNl
cHRpb25fbm0oKQ0KPiB3aWxsDQo+IHF1ZXVlIGEgI05NIGZvciBpbmplY3Rpb24gYW5kIHRoZW4g
c3ludGVoc2l6ZWEgbmVzdGVkIFZNLUV4aXQsIGkuZS4gdGhlICNOTQ0KPiBmcm9tDQo+IEwyIHdp
bGwgZ2V0IGluamVjdGVkIGludG8gTDEgYWZ0ZXIgdGhlIG5lc3RlZCBleGl0Lg0KDQpZZXMsIGl0
J3MgaW5jb3JyZWN0IGJlaGF2aW9yLg0KDQo+IA0KPiBUaGF0IGFsc28gbWVhbnMgaGFuZGxlX2V4
Y2VwdGlvbl9ubWlfaXJxb2ZmKCkgPT4gaGFuZGxlX2V4Y2VwdGlvbl9ubSgpDQo+IGlzIGZhdGFs
bHkNCj4gYnJva2VuIG9uIG5vbi1YRkQgaGFyZHdhcmUsIGFzIGl0IHdpbGwgYXR0ZW1wdCBSRE1T
UihNU1JfSUEzMl9YRkRfRVJSKQ0KPiBpZiBMMQ0KPiBpbnRlcmNlcHRzICNOTSBzaW5jZSBoYW5k
bGVfZXhjZXB0aW9uX25taV9pcnFvZmYoKSB3aWxsIHJ1biBiZWZvcmUNCj4gX192bXhfaGFuZGxl
X2V4aXQoKSA9PiBuZXN0ZWRfdm14X3JlZmxlY3Rfdm1leGl0KCkgY2hlY2tzIHdoZXRoZXIgTDAg
b3INCj4gTDEgc2hvdWxkDQo+IGhhbmRsZSB0aGUgZXhpdC4NCg0KRGl0dG8uIFRoYW5rcyBmb3Ig
cG9pbnRpbmcgb3V0IHRob3NlIGZhY3RzIHRoYXQgd2Ugb2J2aW91c2x5IG92ZXJsb29rZWQuDQoN
ClNvIGhhbmRsZV9leGNlcHRpb25fbm0oKSBzaG91bGQgbmVpdGhlciBibGluZGx5IHJlYWQgeGZk
X2VyciAoI05NIG1pZ2h0IGJlIA0KY2F1c2VkIGJ5IEwxIGludGVyY2VwdGlvbiBvbiBhIG5vbi14
ZmQgcGxhdGZvcm0pIG5vciBibGluZGx5IHF1ZXVlIGEgI05NIA0KZXhjZXB0aW9uICh0cmlnZ2Vy
ZWQgaW4gTDIpIHRvIEwxIHdoaWNoIGludGVyY2VwdHMgI05NICh0aGVuIGV4cGVjdHMgdm0tZXhp
dCkNCg0KVGhlIGZvcm1lciBzdWdnZXN0cyB0aGF0IHJlYWRpbmcgeGZkX2VyciBzaG91bGQgYmUg
bWFkZSBjb25kaXRpb25hbGx5DQpzaW1pbGFyIHRvIHdoYXQgd2UgZGlkIGluIHZteF91cGRhdGVf
ZXhjZXB0aW9uX2JpdG1hcCgpLiBUaGUgbGF0dGVyDQpzdWdnZXN0cyB0aGUgYWN0dWFsIGV4Y2Vw
dGlvbiBpcyBiZXR0ZXIgcG9zdHBvbmVkIHVudGlsIF9fdm14X2hhbmRsZV9leGl0KCkuDQoNCldl
IGFyZSBsb29raW5nIGF0IHRoaXMgY2hhbmdlIG5vdy4NCg0KQW5kIG9uY2UgI05NIGhhbmRsZXIg
d29ya3MgY29ycmVjdGx5IHRvIGhhbmRsZSBpbnRlcmNlcHRpb24gYnkgZWl0aGVyIEwwDQpvciBM
MSwgSSdtIG5vdCBzdXJlIHdoZXRoZXIgd2Ugc3RpbGwgd2FudCB0byBzcGVjaWFsIGNhc2UgTDEg
dnMuIEwyIGluIA0Kdm14X3VwZGF0ZV9leGNlcHRpb25fYml0bWFwKCksIHNpbmNlIGluIHRoZSBl
bmQgTDAgd2FudHMgdG8gaW50ZXJjZXB0IA0KI05NIHRvIHNhdmUgeGZkX2VyciBmb3IgYm90aCBM
MSBhbmQgTDIgKGlmIGV4cG9zZWQgd2l0aCB4ZmQgY2FwYWJpbGl0eSBieSBMMSkuDQoNClRoYW5r
cw0KS2V2aW4NCg==
