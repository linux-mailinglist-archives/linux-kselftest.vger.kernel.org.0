Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C9497E75B6
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Nov 2023 01:13:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234817AbjKJAND (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 9 Nov 2023 19:13:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjKJANC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 9 Nov 2023 19:13:02 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2949C4680;
        Thu,  9 Nov 2023 16:13:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699575180; x=1731111180;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=p8K7mN8+jXP5DDvxl0zPdfRv7L6g0orcLM+FriTJBcw=;
  b=gt5ICco61+4wN0DWWBIFpHD48cqyuWGKbm2f8vMb9ML6JcIjCnOzzDgM
   rymAqeCxxa6geSKwahqV4Pj06kp8LZNcLtDrybx5gnfoircXlkItQb1cs
   K9yV3l+JJy69MzRDjdELqmNVL5vKYDBg5bk1Eh7EpvNz0hYnRdXQADOHZ
   dQoqOImsY6suLY97kitSkv1HXa+LaBw3rBiQxxhPogqLnSzkme8hnsTrf
   GjB9W9FyefWgXOVdvDIe4fZnzdZEPHjDCCk9r+NbhK3iDJ8YGB9hQIAfC
   RwZJupEKYKKcbc87XSKpXRlFiLXLOwLNY7XAaYniJcuouDPoMcSdY/ryh
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10889"; a="370309753"
X-IronPort-AV: E=Sophos;i="6.03,290,1694761200"; 
   d="scan'208";a="370309753"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2023 16:12:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10889"; a="880786747"
X-IronPort-AV: E=Sophos;i="6.03,290,1694761200"; 
   d="scan'208";a="880786747"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Nov 2023 16:12:58 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 9 Nov 2023 16:12:58 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 9 Nov 2023 16:12:57 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Thu, 9 Nov 2023 16:12:57 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Thu, 9 Nov 2023 16:12:57 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i4P2qK8rWiJ5MA6iHhdp5vSSoxBraycpXWASRZ30rF6WYG5zv9goxmqNDanMMyl/7MJwJ6G7crbJ2xvFPvQ5wYRRQIn1u5NhyOESlrd4CiV4+H+qNR0f98RY/bFNGUozN6wU2ApIo/k3vlU3owxLT1pUxoXsfvmeGWxbeeGPPVkHrnFmkWUGRIPokt6YroghpQw5sktSlTJUDpdzx6aCNVGCSDO1x302tpN84RGB03HpXhkl3F5HWAQpRiGVlw3pcpD0pWSIiwCMNmwGTBJle27cPCD0A16wJf3eSLmBaxAksqIRDGNi/N0Bh1VHsOKlpXYETAvgMjgMzcSxklTpPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p8K7mN8+jXP5DDvxl0zPdfRv7L6g0orcLM+FriTJBcw=;
 b=JvzwIhbrmWO9tNo+8FgKyFFUWzKg1mUH/F8uAfuomt4Jvk0mfFsyUQQv4NJIiPMrI/hgIDHuUPvWp48NmoWNyK8glNT7+jaHMbjbxwV//rMUdRpRHVfHno/+t0jQ7URysXZ+/Kd+tQkiJTi6gJjpqaJ82ittTeNZ8ojF1tz9ZKyrE+kjkgJ+/MVB9nIHfN4R21mQkIYZtAaHx9hFwA6VC3dcMo5+2xmcW26qi+/qnfYC7TI5MnqsU3C8CniuFJKVsByxcii7vFO5JCNmk8mpXlHnTERr9WoOjVQ7FG60fhaguN9nQLgyndA8wtqRKKWoxDum9NR0EoJ+bdWfbN1ymg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA1PR11MB6734.namprd11.prod.outlook.com (2603:10b6:806:25d::22)
 by SA0PR11MB4560.namprd11.prod.outlook.com (2603:10b6:806:93::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.29; Fri, 10 Nov
 2023 00:12:54 +0000
Received: from SA1PR11MB6734.namprd11.prod.outlook.com
 ([fe80::3d98:6afd:a4b2:49e3]) by SA1PR11MB6734.namprd11.prod.outlook.com
 ([fe80::3d98:6afd:a4b2:49e3%6]) with mapi id 15.20.6954.028; Fri, 10 Nov 2023
 00:12:54 +0000
From:   "Li, Xin3" <xin3.li@intel.com>
To:     Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
CC:     "Christopherson,, Sean" <seanjc@google.com>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "kys@microsoft.com" <kys@microsoft.com>,
        "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        "Cui, Dexuan" <decui@microsoft.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>
Subject: RE: [PATCH v1 15/23] KVM: nVMX: Add support for the secondary VM exit
 controls
Thread-Topic: [PATCH v1 15/23] KVM: nVMX: Add support for the secondary VM
 exit controls
Thread-Index: AQHaEnYCzFnG3GUP+kCaRbBMUKVZALBxpomAgAEHtIA=
Date:   Fri, 10 Nov 2023 00:12:53 +0000
Message-ID: <SA1PR11MB67349FBF8DBB1004FEC9CB3CA8AEA@SA1PR11MB6734.namprd11.prod.outlook.com>
References: <20231108183003.5981-1-xin3.li@intel.com>
 <20231108183003.5981-16-xin3.li@intel.com>
 <02faa42b-7b10-40b4-8442-5f95a2934f5f@linux.microsoft.com>
In-Reply-To: <02faa42b-7b10-40b4-8442-5f95a2934f5f@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB6734:EE_|SA0PR11MB4560:EE_
x-ms-office365-filtering-correlation-id: 8153bbed-5a8a-4c23-6c8d-08dbe181c8af
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0CmEUwl3WZ7VtlBJ1sKY+E9hPthy40RFKY/lyOi0xMXgOCP9aKlO4PwDpMSyq4WmeUGO3bvOsXexOyVOKrR6SCWLl9q5sYlwdb2kajjmRLIKKY/UKqFIj06WBnTPR0Uzyq0jz3V3rj3dYnx0gKxauj/A8A49JKgwPSMtlkgq69ttM3arXogyy/0FJE8eKTAXdnNorsk/9jUmZcQlGLnpju+ko/jiAAUApXwU9TfwmYc4WwXbGN96eQ79l4REWLXQoK78dsbmNLRcDQfzrL+aaWoy3wj481bFN2abVLJwsk3G7N8aPJ/WC5FVgTX1bHVi6uLRSB5WKhfqTxIz4KAM5ueG+fCa+q6MzAVFF482OsPRlqU7zsCXt7Pa4CYku8OpkmASmOlaL6htb2LHS7kN0oL5uGH1ype+4njuA2Hy/U8YTLdLn4BPUQb7pIfuiUQPP7R9mlBSI0jfxHK2SlM+xRH4urjwHiBMi7PJOJRxc89Z2BW3xVjng0j2rlTXcEWswg72+tCDI70UMPcl7WA+I14Uh9Rm2M63UwYa3mQWzZaUEnKgni4oe828hTbYnyup57EMzv677pld+JsNPOHSMMaCOXB+g9ew52JC0ZCgqb6UDgZmT85b70e9hBh0gVoJ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6734.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(366004)(346002)(396003)(136003)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(9686003)(478600001)(6506007)(71200400001)(26005)(8676002)(2906002)(66556008)(66446008)(8936002)(54906003)(41300700001)(5660300002)(64756008)(76116006)(66946007)(110136005)(4326008)(316002)(7416002)(38070700009)(33656002)(38100700002)(52536014)(82960400001)(122000001)(86362001)(66476007)(7696005)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TG9YY2N1RE1UYzNxZ2NFL1RCa01VWnl1WmI3SnBZSVZZeG14Uk9GcmhMdmIy?=
 =?utf-8?B?emxFYVpzdmpma3BvSGVic1NndjNEUmRCYkFqVndjMzdKSVB6S05pMDN5STky?=
 =?utf-8?B?N3pDN2NLamY5alRhalhxKzFoVllKbTZsWHdwWFQrK2orNnFySnhiMlhWdzhL?=
 =?utf-8?B?YU42ZGRpeUpVemFQQ0Y2SjBoSXVoTHlwd0RtMTVYTnNPYUd4eFVoY0lMUFZv?=
 =?utf-8?B?WkQ1blc1THdXSDhDamN1ZU91eTloQ01UMVRsekR0TUpRL05ONFFaRlExUlpk?=
 =?utf-8?B?ak9DYmdtazZINVpNQUFyVmUrS2ZKMStVK21BeHgwdFV5ZDlUVUFsNGtsVmpR?=
 =?utf-8?B?bWFzRVZrZmVoSW9UWGM2RG9adzhLK21PRENhaDluYkIvcFppb0crbEI0RjFn?=
 =?utf-8?B?QmkzL3poNGJYRnRCUTR6UU00bHdWWnRwQis5WVB0V2dOZG9TeHZnUDA2NHV6?=
 =?utf-8?B?bnNEa1dqSlZFV0xCRitka2xRYWMzSjAvVGNwUXliTFQ1YWQwdlpycE1adXFG?=
 =?utf-8?B?THpNbDF6QldwVmNGalB3VmZPOXJwK3pFVzJBcWlqVEg2VzVQTDl0MEErL0dS?=
 =?utf-8?B?YW56S09heTNQR0k0K2pJcG9UM0lhZUZqYUdJQm9lV053MStvQmNOQktrZW1z?=
 =?utf-8?B?clBEWVhlTFRwRlhKSnlCbGVpV3hrNUt6ZWxRaVdrU2VZdkpHeEd5WDJqMW9l?=
 =?utf-8?B?QU5xb2RuelRMS1BCQ0V4TnJDT2JWRExJKzhoUjI3OHAwaXZyMWdxRDJsa1Fy?=
 =?utf-8?B?czFobU9mOUtkbjFldUVUSkZuQ0VzVjVoVmloakcyN1lNbWdyU24xY0Y0TDFE?=
 =?utf-8?B?Sm1INjVJL2tsdXh0bGUwQVZLTmZCOUtBb3o5MGpIVGFjdno5LzluQXRyUjFF?=
 =?utf-8?B?WiszeVpNK2RsM3NNdExiamJBYmhKN2dtY01zQ0hOVDdBaUZ3T0JlY0NLL3pG?=
 =?utf-8?B?czAzdDBwbGFyRE53bWV5aGpsY20veG1MTTlDQ0UvMkZPREkwWXV4NkJqMWk0?=
 =?utf-8?B?L0VId1BDMzBIZTN4aHpJYTVNOWVUQ0xZWkorSCtpL2Y3S0kxVVpjUGJKOUYw?=
 =?utf-8?B?bVVhVG5PVjc2NDNvZjZRNzdUNFNFZkYwQmdPVWFNcW1pMGpXV1duaXFheDRS?=
 =?utf-8?B?ZjdmUGlxdy9WNXN6K3g2WksrVTAwSFcwTWdyeE5XY2FNeU45aEJoM0VLMUtD?=
 =?utf-8?B?bW1ETE1nb2szWHM4cW9NWlRDUVI1eHNVeW56dWUyYjdNaGlJcXhIQnhvL2Z3?=
 =?utf-8?B?MUxMZkxpUzBWVWdJRi9IcUU0aWlNajJldzZyLzZ1cWsvRXZXSkVERGJ4VHdh?=
 =?utf-8?B?UlVUdVMrK2ZKa2Zqem96Y2NicWNSTXl5cUx3RDlMb3Z5MEtMQTRDNllGSUtn?=
 =?utf-8?B?YjlMOS9LNTQ5TlZvVnc0Nmx3MXhMa3d3enRKckVaRFFsY1dKQkc4aXB1TUcv?=
 =?utf-8?B?ZDFnQ2c4YXJDbG41Ky93cjNKNFRKY1dGMGlZcDZCN014ZUlXNDMzNmNMRHJS?=
 =?utf-8?B?UU40eFRPSXF2d2JGQTZMV0ZqT1ZaNmtjV005RGdJR1gzUzhBcS94M0FpY2hv?=
 =?utf-8?B?VTNLRUxsY2kzdDJEVlBUWWw2UjFlSm9nL3YzYzVKbGRtVEY0MWxJY1JtL2c3?=
 =?utf-8?B?Z1dEYytvcHRjMEc2WGpFK0JCSTBvQktJdS8zcE5OQksxa0hDZ0RHZEVxWWE4?=
 =?utf-8?B?aHlPNEF2MnE3M1FDYWcxdmoyQkRGUkRoSlpnVmRpMlZoSkRnVnZPc2xTSHRY?=
 =?utf-8?B?TTBka3dMWkJKUnBubXQrdkJpckxiY0tydHlmZjdFdlNwcENMSkdxc0ZEVXo3?=
 =?utf-8?B?Q0wzS0Z5UG5IdmxHczBGeEJuY2swSTd0c2pHZzZGVTJWaVFwUjlxNjNVaVdQ?=
 =?utf-8?B?a3YvZjRmQlYyMDhGY09XRUNrbG9XWFUzNUVHTWJlOTlTM3VDdHJDNlcwZTI4?=
 =?utf-8?B?VUo4cE9ydmJwMDlnYzZ1VHdITnlBaWlnZjZXbkQ3aHlCOWs4MG4wMXZaWm13?=
 =?utf-8?B?RitjZ3dwZEdPNm9UR0dWSmUxcm1pbXBCalNVS09QK3NPOEtvYjEwM3FybjRq?=
 =?utf-8?B?VWtCZmw5bXBsNTBUcW1iSUJLRll1WFVJZ0U3UVNhZHFpd2Z3NUQzeXFTM3k0?=
 =?utf-8?Q?fJ2E=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6734.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8153bbed-5a8a-4c23-6c8d-08dbe181c8af
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2023 00:12:53.6533
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ww4KOnC6tH5dN4USxScRi/2vcuXaFhlVbH7twebWcJau28TXHnyXx1ojy3UHl45e3tYbnR0+PpAUjxSxbK2/dQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4560
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

PiA+IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9oeXBlcnYtdGxmcy5oDQo+ID4g
Yi9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9oeXBlcnYtdGxmcy5oDQo+ID4gaW5kZXggMmZmMjZmNTNj
ZDYyLi4yOTk1NTQ3MDhlMzcgMTAwNjQ0DQo+ID4gLS0tIGEvYXJjaC94ODYvaW5jbHVkZS9hc20v
aHlwZXJ2LXRsZnMuaA0KPiA+ICsrKyBiL2FyY2gveDg2L2luY2x1ZGUvYXNtL2h5cGVydi10bGZz
LmgNCj4gPiBAQCAtNjE2LDYgKzYxNiw3IEBAIHN0cnVjdCBodl9lbmxpZ2h0ZW5lZF92bWNzIHsN
Cj4gPiAgCXU2NCBob3N0X3NzcDsNCj4gPiAgCXU2NCBob3N0X2lhMzJfaW50X3NzcF90YWJsZV9h
ZGRyOw0KPiA+ICAJdTY0IHBhZGRpbmc2NF82Ow0KPiA+ICsJdTY0IHNlY29uZGFyeV92bV9leGl0
X2NvbnRyb2xzOw0KPiA+ICB9IF9fcGFja2VkOw0KPiA+ID4gICNkZWZpbmUgSFZfVk1YX0VOTElH
SFRFTkVEX0NMRUFOX0ZJRUxEX05PTkUJCQkwDQo+IA0KPiBIaSBYaW4gTGksDQo+IA0KPiBUaGUg
Y29tbWVudCBhdCB0aGUgdG9wIG9mIGh5cGVydi10bGZzLmggc2F5czoNCj4gIlRoaXMgZmlsZSBj
b250YWlucyBkZWZpbml0aW9ucyBmcm9tIEh5cGVyLVYgSHlwZXJ2aXNvciBUb3AtTGV2ZWwgRnVu
Y3Rpb25hbA0KPiBTcGVjaWZpY2F0aW9uIChUTEZTKSINCj4gDQo+IFRoZXNlIHN0cnVjdCBkZWZp
bml0aW9ucyBhcmUgc2hhcmVkIHdpdGggdGhlIGh5cGVydmlzb3IsIHNvIHlvdSBjYW4ndCBqdXN0
IGFkZCBmaWVsZHMNCj4gdG8gaXQuDQo+IFNhbWUgY29tbWVudCBmb3IgcGF0Y2ggMTYuDQoNCkkg
dHJpZWQgbm90IHRvIHRvdWNoIGFueSBoeXBlcnYgc3R1ZmYgYnV0IGhpdCBzb21lIHByb2JsZW1z
Lg0KDQo+IA0KPiBXb3VsZCBGUkVEIHdvcmsgaW4gbmVzdGVkIHZpcnR1YWxpemF0aW9uIGlmIHRo
ZSBMMCBoeXBlcnZpc29yIGRvZXMgbm90IHN1cHBvcnQgaXQNCj4gKG9yIGRvZXNuJ3Qga25vdyBh
Ym91dCBpdCk/DQoNCkkgZG9uJ3QgdGhpbmsgc28gQUZBSUNULiAgQnV0IEkgY291bGQgYmUgd3Jv
bmcsIHNheSBhIFZNTSBpbXBsZW1lbnRzIEZSRUQNCmNvbXBsZXRlbHkgaW4gc29mdHdhcmUuICBP
dGhlcndpc2UgTDAgbmVlZHMgdG8gYWRkIGNvZGUgdG8gaGF2ZSBoYXJkd2FyZQ0KdG8gc3dpdGNo
IEZSRUQgY29udGV4dCBiZXR3ZWVuIGhvc3QgYW5kIGd1ZXN0LCB3aGljaCBjYW4ndCBiZSBkZWxh
eWVkLg0KDQpUaGFua3MgYSBsb3QgZm9yIHlvdXIgcXVpY2sgcmV2aWV3IQ0K
