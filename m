Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 625755B2D12
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Sep 2022 05:48:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230360AbiIIDsf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 8 Sep 2022 23:48:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229896AbiIIDs0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 8 Sep 2022 23:48:26 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A5C51203F6;
        Thu,  8 Sep 2022 20:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662695305; x=1694231305;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=7hy3wHOyMefroaXLr2w0cSJuhh6SixVIXSbJpuhHPdo=;
  b=SGSLDdf318JkRraWQpJmxxMoewiwKd3lZuS4aeufWzl8Zp83uk+v3NvL
   LH3f6qBxyBH1a6LFAnzdI0j2bJovP80k8OaUErYxo7doydzy7/bC2/WRA
   NQWIWAA6e6b7EcXreP8MO7MVA60jsBzs7OOdrW4hA0t8fWGSEIoMzAb63
   jyrObO1cmgNFWveM05QWfW6YhZWMJxq8Xz99qx3uTZDhQaGBUwK4aVbPj
   R1jJYoBNlMgb4Rf3VAC+s2Y6SVhOkmQfpBT0kS0iGod5DhWC9rpmph+uC
   b44feMLUrLfIWpaR7ngr37Fg0cz2aeox96p2sKxlX0gyK/rAyDLZgMeny
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10464"; a="383683860"
X-IronPort-AV: E=Sophos;i="5.93,302,1654585200"; 
   d="scan'208";a="383683860"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2022 20:48:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,302,1654585200"; 
   d="scan'208";a="645375451"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga008.jf.intel.com with ESMTP; 08 Sep 2022 20:48:24 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 8 Sep 2022 20:48:23 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Thu, 8 Sep 2022 20:48:23 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.49) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Thu, 8 Sep 2022 20:48:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h3i023qBLTycm078ZE1bMdNaies4s/nmpTcIZA/YH2DDoaEtoPxqi/zsUF4qBn+jCkS5wETs9VldEE/wpfKJSna1utIgElA60JjB5/i9SxmGz5UnhyS4ZpLVox+8JjdYjpzW/sz3gyuDUcOuxYvc4aQO3wwV28DFXTPxS+J/DYcNSm7qvBZBysSo8UDFburjwXLnr9JU3N8IQv1g88OWl67qjug7gfh5z3p7p2xX5zFlIWYSHtkS2O/WAtMiAnlZQ/25qn4nG+QlDjODnlSNXcf2UavNr7Nwe8a5IHMZvKbCpk3ryJtPDn+vl4JdzSnfc8nXMMsabTEe3+P6GoD8ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7hy3wHOyMefroaXLr2w0cSJuhh6SixVIXSbJpuhHPdo=;
 b=Vx6xGmiNk0Y1ha6gLYPw4aYWuzVrH9v0Mt++xggkFgYMCv5r8YqKm8ntp2oYbL/aqBACIIuurYD/q8aFUVZwHSVmWOKDpbeoBlSq3b10hOzEVfpL6CtbRsYWFUnqKl0vsXBVaE8KKap25R3Ar2X46aFXz4slgo1BvPl4xRZ7MRRuHfLZoyBQhngeLzi93XwmpHwU8YdNbKuPfKNw+edR5qnbTk8Iv/xoLLo6OYy4uy+q/wAK7sOgKDuQEZHmA9M6a9e2ofn6a8HeNVtThMcyl3iHiZovX/RsJqTdJPRLeqhb7cfB3ViC7mIywEmMVnQITRUg+/ukepQ9bxe3KfntPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by SN7PR11MB6800.namprd11.prod.outlook.com (2603:10b6:806:260::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.12; Fri, 9 Sep
 2022 03:48:08 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::fce1:b229:d351:a708]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::fce1:b229:d351:a708%9]) with mapi id 15.20.5588.015; Fri, 9 Sep 2022
 03:48:08 +0000
From:   "Huang, Kai" <kai.huang@intel.com>
To:     "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "x86@kernel.org" <x86@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ak@linux.intel.com" <ak@linux.intel.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "wander@redhat.com" <wander@redhat.com>,
        "tim.gardner@canonical.com" <tim.gardner@canonical.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "isaku.yamahata@gmail.com" <isaku.yamahata@gmail.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        "khalid.elmously@canonical.com" <khalid.elmously@canonical.com>,
        "marcelo.cerri@canonical.com" <marcelo.cerri@canonical.com>,
        "Cox, Philip" <philip.cox@canonical.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH v12 2/3] selftests: tdx: Test TDX attestation GetReport
 support
Thread-Topic: [PATCH v12 2/3] selftests: tdx: Test TDX attestation GetReport
 support
Thread-Index: AQHYwxnXMVccQj8iy0OLPdFiiAdE5K3Wd72A
Date:   Fri, 9 Sep 2022 03:48:08 +0000
Message-ID: <449b29a40dcbafc9c0b81d19ed5c377b290b0ab5.camel@intel.com>
References: <20220908002723.923241-1-sathyanarayanan.kuppuswamy@linux.intel.com>
         <20220908002723.923241-3-sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20220908002723.923241-3-sathyanarayanan.kuppuswamy@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4 (3.44.4-1.fc36) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a8a664d5-4243-4506-23fd-08da92161bd9
x-ms-traffictypediagnostic: SN7PR11MB6800:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xNyFJ+AvTKbUQ/gcObpVb1Fe05LfufKzoI30Tzczf7kXz/lXM8+WvsWsoEP+sHnDwhNnJkcFM/QplmhmMKobjDWXC2eRyCDh8l07u3nHy6wnbczuXMl40K1ajz2rg800t1E1WpHiNQ6BSYdaxRkrBaDplBiSdgh5AALd3ucdcNZe5cKu1tOlBWPX1SzetxnfwiFR0xMIYw/YzEuhkQJWrTVOicYdYjwVWX/6AlU6E9a5CBL1YE7VDKMEgY/7nyAV6R2p4nDBJ905ou9UO6PF7rnA4kaHB+C0CMhBVcidn+X4+CZz6qq2SW7IM2MIikgVZVpdp4V59vEn5zRwVpzWw/5cye8kSMnCZGGpKXWf38uFE1P15v774J5BBpOPJfV9bSIe+j+GTYAXrBU/f9wKzb0vZbBNk0GBz3hWSvsPooPKIZJCkAoqLvAWMJT4d49BkdnOHUUKT0SDL8v8GeHabHHkA6LaFmH9pUPLvWhr1dnUHhiFJpOw3hgNpCYLPV6/rfKb/rlq2DA7wY76aRJc6GBK09DfUFJjLsXEwsvU4PKnfq5znM1tUDons6rlKpab3L4BXNArLMw/H41AcPSCcBVVRR0tqYwcnXx/hrI340wehgihZFgI0pzPaN/M4UC8iCQPyoX6UZZmn9v4SJxLrCWsklOhXD+0QxDo2HxZWsTlzwb1bn0NYKkMFaGF7q1NpPokyxEDcPePylkMgUUhFzjWPzdYBDUWos6zr3dp5CcXrT4kVZWzD2Wa7qUtEF5C74ELVA8ji++MLsvJdTISzw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(136003)(39860400002)(376002)(346002)(396003)(36756003)(2906002)(6506007)(66946007)(122000001)(38100700002)(71200400001)(6512007)(110136005)(316002)(54906003)(6486002)(7416002)(41300700001)(8936002)(76116006)(91956017)(82960400001)(5660300002)(478600001)(186003)(66446008)(86362001)(66476007)(38070700005)(66556008)(8676002)(4744005)(26005)(2616005)(4326008)(64756008)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UUlrMEQ4VC84WjlaaDVxdDdIQTdGTkhZVDZVdVFESHdMdlJTOVA0SFkxeDgx?=
 =?utf-8?B?aFI3RjIwM3gxNk5QdFhvUWx6YXNOR2YrbUNtMklRUnBMRURIR000TTAyOEx2?=
 =?utf-8?B?TXVwbmhNRkQwb1luc2NvNjE2cUdyT3U4ZnFYZmJyd0htTldHWmNVUDg2MHhR?=
 =?utf-8?B?Q1F2M0dYaWJnbGJIMzNHaDZ6ZVV3bC9Qa3pVNm91eXA1ZmZMYjFEUWhNbkdy?=
 =?utf-8?B?ejhXT1NxOXZkV1EzeUpHekpNSEZlYmVvNDZrZThoNm5lelhLcU9qNzY1VVNT?=
 =?utf-8?B?SEV1NEZwQVRvbHY2ODhnR0FjVTlIdmZtaXlubmdLYUhVZ1lGdTkwVU9FcG5K?=
 =?utf-8?B?OGozMlNyWnBrWW9oZjN6bW0xc3VwOVdOcHdNd2dweUt4N2V1V1I0WkVMblBX?=
 =?utf-8?B?SzQ3dTBCZ2c2SWpQU1UrMnJ4VXNEQ01sTnhGK0V4VmNtdHdtWFJ0UnNXdkdF?=
 =?utf-8?B?Z0JxTzdhaGRXVjdxNjA2TG9MSjNzeUppMWRRdmtYd0hlWFBYeE81bW9rUFk1?=
 =?utf-8?B?U1dyUUNKQlRkSHFVaVdHcWo1NFVQUiswbGdINmRWdi9CUEpzajlrNXh0MGdn?=
 =?utf-8?B?eW5hK2pUTG5ia0F5bHZoVFg4eU5YODJDWkxFVEdGS0VuUGlqLyt1TllYT3pL?=
 =?utf-8?B?YUYvaHJaNGg0UVFQNkNVSCtjcFhMR2g0K3Z4U1l6ZHBNSmMxWVAyWkdhWHli?=
 =?utf-8?B?Umd3SWY0RGZ3NC8wcExNcFhVclZMN2VKdzNWbVdlK1NrMGgyVUhqZXh6dU94?=
 =?utf-8?B?ekJ1d3FKMzV4bER4NEFwVGtSUjNJTlZHcXNCNFNOeGxNbFNoVCs5VjJ5WkZE?=
 =?utf-8?B?dlFxdFpVM2VDbkVleTBpdkZlR1JWQk14MUhJS1YwVWc5cEdHNlpaa2ZCRjJr?=
 =?utf-8?B?SnNmazJ5Y29JVngzbXVXNUMrekdwVWtMaUJBWUVaenZETnA0MGFSUldxYjlD?=
 =?utf-8?B?T0gremhtVVNDR2U1aVM5ajRnOGNINzE5RW5XT01hYk96NjR2UTY1QmNrRGVo?=
 =?utf-8?B?N2cwUU9ENU9UeDFNRnpCZm9XWE9ZVVVqQXdRNXR4aURlWjJLSTJ0NFh6eCtH?=
 =?utf-8?B?d1FlQjRZdmlxclV1V3NOMC9CZk1MQXFHSmdOUVVvWXNaSHVHaVVSLzdBYkhB?=
 =?utf-8?B?VzBjNWV1Q3lGeEZ4bHh2L2NmYjJ4UkNCNmtxLzRVSkhPSER2VVc1L0NjTW9B?=
 =?utf-8?B?UnNTRHZSVVZ0V01KNWt6b0JEbWI5WGluK0dhZ090Y3RZbXA2V05ORnduaFFV?=
 =?utf-8?B?WUxSNWxTNEtDbThqVkdzMXRRSXA3U0YxNnE2ZlNRd1RvWlluWWxrelVHNXU5?=
 =?utf-8?B?VFBZWXhUc3NJVE9JS056RTd3QU05WmdOR2xjb3NHNkh5dHY3Um96VW5KdFdy?=
 =?utf-8?B?YVI5YjIwRllkZ015aDNNa0c4K1ZzbGdnMjZQTkZUNXF5WFJ1aG9PV1R4c2NF?=
 =?utf-8?B?clpUbGlzSnExckc5blRZczNyZ1JNWjloMDNiYlk2TTNFRW1Cc2NlOTFON0dt?=
 =?utf-8?B?WnAzb3JVYkNPcFpqQnVnWEt5K1BwNXY1SGwxYXg0OFhkNnRETThONUtPQW8x?=
 =?utf-8?B?Ymtib1kwb2U5QzRXNW1Gd3dxZ1hpU2cvVXo2d2h3Mk9wamRicjJDZnhpVjds?=
 =?utf-8?B?MHA1T0htRjNMUVlMRDltZ3VtS2Y0cDVEOU9oV0plemQ4dFRqR25FbzdhU0V0?=
 =?utf-8?B?WTFpZTlJMlN5amhVWDhmY3oxbjdLUGdKN1M4cUQ5TWQyb0t3VUtvNEZjdjlp?=
 =?utf-8?B?VEN4YU1LajhSOGF4ZTcyYko0ckdla2ZzVjZMd3NGK3lsTXpuZ3ZhYUNMREx1?=
 =?utf-8?B?VThBOWp1cEQzWEhhb3g0b2MzME9zTFhIY1NqaWxTaXg2TWhiWXI5VEhaUGt0?=
 =?utf-8?B?M0tLVHc0VmNUMHhoTG4yNkYwaU5xT3BqTEhNZ3dKWHpIL253VWNHTGs5bDNk?=
 =?utf-8?B?Z0VVcWdEMkxWNDV5NXRSZ2NPa1pUMWR0M2FXbG5kM2FmS0MzMVYyTThqRENP?=
 =?utf-8?B?SjR5czRnUkhuaHo1NGl5dHJjR29VTmlUQnhQTGtuZ0VrdVA5Nzg1WGprTnZ6?=
 =?utf-8?B?RFFXN0MrY0U3ZzZqSlJBUGE5VWIzV3ZKNHYzOEtvbk1GcExXdWZjWHJWK3Ew?=
 =?utf-8?B?S05xYkdYZXdYc25VV3p2R1JKSFpwVnJqaUVyQVhlMEhtMjJnUlFEQ3ZFUWEv?=
 =?utf-8?B?SWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <73B07AF8C0FDB643ADDBC2D9E169D35A@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8a664d5-4243-4506-23fd-08da92161bd9
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2022 03:48:08.0341
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mJg7SM3pAZCCScPMnhr/s8LyfhFT4k7js0XaiWwi89KUUZnuZMOlo1u8k+4OAk36R8ev4oUR8x1RE2KWfwTezQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6800
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

T24gV2VkLCAyMDIyLTA5LTA3IGF0IDE3OjI3IC0wNzAwLCBLdXBwdXN3YW15IFNhdGh5YW5hcmF5
YW5hbiB3cm90ZToNCj4gK1RFU1QodmVyaWZ5X3JlcG9ydCkNCj4gK3sNCj4gKwlfX3U4IHJlcG9y
dGRhdGFbVERYX1JFUE9SVERBVEFfTEVOXTsNCj4gKwlzdHJ1Y3QgdGRyZXBvcnQgdGRyZXBvcnQ7
DQo+ICsJc3RydWN0IHRkeF9yZXBvcnRfcmVxIHJlcTsNCj4gKwlpbnQgZGV2ZmQsIGk7DQo+ICsN
Cj4gKwlkZXZmZCA9IG9wZW4oVERYX0dVRVNUX0RFVk5BTUUsIE9fUkRXUiB8IE9fU1lOQyk7DQo+
ICsNCj4gKwlBU1NFUlRfTFQoMCwgZGV2ZmQpOw0KPiArDQo+ICsJLyogR2VuZXJhdGUgc2FtcGxl
IHJlcG9ydCBkYXRhICovDQo+ICsJZm9yIChpID0gMDsgaSA8IFREWF9SRVBPUlREQVRBX0xFTjsg
aSsrKQ0KPiArCQlyZXBvcnRkYXRhW2ldID0gaTsNCj4gKw0KPiArCS8qIEluaXRpYWxpemUgSU9D
VEwgcmVxdWVzdCAqLw0KPiArCXJlcS5zdWJ0eXBlwqDCoMKgwqAgPSAwOw0KPiArCXJlcS5yZXBv
cnRkYXRhwqAgPSAoX191NjQpcmVwb3J0ZGF0YTsNCj4gKwlyZXEucnBkX2xlbsKgwqDCoMKgID0g
VERYX1JFUE9SVERBVEFfTEVOOw0KPiArCXJlcS50ZHJlcG9ydMKgwqDCoCA9IChfX3U2NCkmdGRy
ZXBvcnQ7DQo+ICsJcmVxLnRkcl9sZW7CoMKgwqDCoCA9IHNpemVvZih0ZHJlcG9ydCk7DQo+ICsN
Cg0KJ3JlcScgaXMgYSBsb2NhbCB2YXJpYWJsZSwgd2hpY2ggaXNuJ3QgZ3VhcmFudGVlZCB0byBi
ZSB6ZXJvLiBMb29rcyB5b3UgbmVlZCB0bw0KZXhwbGljaXRseSBjbGVhciAncmVxJyBvdGhlcndp
c2UgdGhlIHJlcS5yZXNlcnZlZFs3XSBtYXkgbm90IGJlIHplcm8uDQoNCi0tIA0KVGhhbmtzLA0K
LUthaQ0KDQoNCg==
