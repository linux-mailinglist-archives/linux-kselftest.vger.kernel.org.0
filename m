Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26EC25B626C
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Sep 2022 23:01:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbiILVBx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 12 Sep 2022 17:01:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbiILVBu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 12 Sep 2022 17:01:50 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4C602AC4A;
        Mon, 12 Sep 2022 14:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663016509; x=1694552509;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=rrxcJXygPByYVLAFIMjhJB6if0RJI6fbo0k+Qriv9jI=;
  b=cUTQ4zWBHevlr0V8mLfFPiYLmoZpruHccLkEYrqF2xpBfAYoaMfJhVMP
   aLYfh8cCRcyxEjwYx1Sv/vV3L7ih1anQwwOGp+7p1IbfTQR1qkMyMq9Yw
   l/kN2uXCG4Ss5NJmcRQUH785WI/HKfIltGyZxgcVqMhJFcX/bBUZaGJwo
   R6KmircR+Etukz1hZxtdbxUlTbixz714tvalyn37puZ/Y7QEJ4yvBtldu
   cy/yDP666SPlzfbukT2XRha7oMozGIY3io1uQXdk+h+LMKwJC0a84lWBI
   VO3nsILr4zLyuz3xRYdP2UiX5OTSeV/NNhtz7uv+g2ZMfCu7sPBXJ580s
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10468"; a="324208518"
X-IronPort-AV: E=Sophos;i="5.93,310,1654585200"; 
   d="scan'208";a="324208518"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2022 14:01:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,310,1654585200"; 
   d="scan'208";a="684583244"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga004.fm.intel.com with ESMTP; 12 Sep 2022 14:01:48 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 12 Sep 2022 14:01:47 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Mon, 12 Sep 2022 14:01:47 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Mon, 12 Sep 2022 14:01:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TYGuUmDQJ6t1j89I0qovRsLepHwB51RDrozAqkeolX4BIxmTrV8JPdviUD1nh4TnSKewPVRth/jzKl3EHsRhOE9P+N+gDDkBs7x9jZE9ElEQYCNz7Vgkor1hzCdQWyF1oBEhPqMZ0fipRM3Nk7xDXaLqrsvlXgnD9r9qQtNBtY2vebi/1iOMjkU+VlWU1cDQwnmOD+jXvfdqr7HjdmMaA5gWZoIZdvqfDz8ct99Vj2kV/MvRbnm5ByrvzGPBuJmRV5lVg+2XrdzefEEez4OBKlEBoV/cXmQ9iFXRs9cguHIvtSzeD7ANafZZSnDQPMjUdrPYcaN56X4AXNne/SFIOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rrxcJXygPByYVLAFIMjhJB6if0RJI6fbo0k+Qriv9jI=;
 b=nokiUUqrZVavLc+/zcfRUq9nLwFEvuSY4N3iIBueDNfeAXFzueg9BOnVZI2Lgog0jBBWB5Fjmlsv6TMXXL22q3AgItsu01CIZWDhRbVfi5eWD3920kFUwBl3hP7X2+IOCtR7PsqwtCT+U9xTn0j7v2mg33GP57l/lqDOOxxHXeB+ZtxyD38L4ZFMjgQMyztA2nnjDxjXoBquZSoh9FDp7su/6FMbXXUS0uTbm6tAf1WIGMVaTF3dy3qawZQMMgHWTGEyi9TLAY/O/9pKQa+sF/qRJNpPdR2NxK4Tn4hGOUu6M5SFrEvQJNGvtGswlQ+inW4i7HQlu3E0HgYdTLpetA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by PH7PR11MB5819.namprd11.prod.outlook.com (2603:10b6:510:13b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14; Mon, 12 Sep
 2022 21:01:44 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::e03d:fd3:dad2:2248]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::e03d:fd3:dad2:2248%6]) with mapi id 15.20.5612.022; Mon, 12 Sep 2022
 21:01:43 +0000
From:   "Huang, Kai" <kai.huang@intel.com>
To:     "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "bp@alien8.de" <bp@alien8.de>
CC:     "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "ak@linux.intel.com" <ak@linux.intel.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "wander@redhat.com" <wander@redhat.com>,
        "tim.gardner@canonical.com" <tim.gardner@canonical.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "isaku.yamahata@gmail.com" <isaku.yamahata@gmail.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        "marcelo.cerri@canonical.com" <marcelo.cerri@canonical.com>,
        "Cox, Philip" <philip.cox@canonical.com>,
        "khalid.elmously@canonical.com" <khalid.elmously@canonical.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v13 3/3] Documentation/x86: Document TDX attestation
 process
Thread-Topic: [PATCH v13 3/3] Documentation/x86: Document TDX attestation
 process
Thread-Index: AQHYxII0umFKXJIJT0imMnKpHHEJMa3bYscAgAB4egCAAHFyAA==
Date:   Mon, 12 Sep 2022 21:01:43 +0000
Message-ID: <39c0a7dd85b3385b21ce53d9d7d31301bbbc5ac4.camel@intel.com>
References: <20220909192708.1113126-1-sathyanarayanan.kuppuswamy@linux.intel.com>
         <20220909192708.1113126-4-sathyanarayanan.kuppuswamy@linux.intel.com>
         <8cb035b4e2cb1e5a49bab23ca7d06920e1585ec8.camel@intel.com>
         <8c699191-a424-32a1-8434-7b9b706ed6a4@linux.intel.com>
In-Reply-To: <8c699191-a424-32a1-8434-7b9b706ed6a4@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4 (3.44.4-1.fc36) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|PH7PR11MB5819:EE_
x-ms-office365-filtering-correlation-id: a3fa8e16-9ebb-4bf0-0f70-08da9501ff61
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PuQZun/KTC458E97d+Kce/PJk9aLmMK/1E3UKt8Rcqq6zEFLIozoE+tpzEvf7C1ps790VSAwMJlPpjyfdh0iN3Y41vLZVwgOMwhZ8AsRHiSDmuESgU7tl0k+f1WEYi40oxQssy1ZqI8Td4BtWPQE0+lHE82yUnz1T6hagGT8hzzbnUpIKH96HxZAsVYTJ+dfVuoeGyl3oX1JZ3Pq7mUhlNBD1xhXJAP0LBwlCEGHiHJJTVXZ5MNV6HLxUiDiChBoQ3dHWFzkKen8hooOIo0PHwLASv1jzY05o+iJqwufzV20wCmhiDkxp8+dmMWa26md4MictO8dXubUd/al27rDBgJdKZ6kbFjZG0jpgnFIJjVcPrKU6K7a24F5kPPjXbOfQFCd5T5qaw6n+G8vr+8WDNfrZgKW0RHyH0kYKTy/iMdewp1L3wnL3Zs2pgXIYcZJTYyEeT/LggC411WP4773ohJBQMv6O7EEfqmRTy0w2d3x3JTfpXLPtO+fDhgmvImCD5m50NmLH/c0sjv1qvDjewTcJXWDVIjTQLHJQFkufbSD6B0abWf38vYdKbUn4QQWVhKOjKgXHzRDhx5opayD1c8Pe3SZ7i7gf5fNp+aCmIN7Uh0Fhm4mM3MiJcLyAlVHe9uph+U8smUcUycpjU/jTUwL7Z0DH4S/vdVuvJ0IB6FyvCTixGc3Vz+hsvrer8Zc39krjuVY7IONRSRhRm5oTBfWDjKe0IzZcxhxkL4YaZn/vrkbW7q9C8x2Rmkzpp9lqfjF6cuO9BMJFm8Qy+HvvA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(346002)(396003)(39860400002)(136003)(366004)(451199015)(82960400001)(316002)(71200400001)(110136005)(66556008)(6512007)(66476007)(41300700001)(478600001)(122000001)(91956017)(6506007)(38070700005)(76116006)(4326008)(36756003)(53546011)(26005)(38100700002)(54906003)(86362001)(2906002)(8936002)(2616005)(7416002)(64756008)(66946007)(66446008)(186003)(6486002)(5660300002)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bytXSzd5UXhjTHBwb2NlclgzVktXOWsxc21BcENYcGVZaVc1UCszb3B2SjNH?=
 =?utf-8?B?N2YwaVlXWGJDeW9sM0FTT0tldWhiZnNsL1dBc1B6RW84eE9GTDVsZjBqTXAv?=
 =?utf-8?B?Z2RIOVd3c1hGbkFsR01USHJHL3FuWDJnSmE2UW8xSy9tWnlOMVJ5R0lpSWt1?=
 =?utf-8?B?a1RpUS90UEpPclB3bVhzNlBlUndIenVlc1ZZSlJ1QnpabTVSd2ZWb0drWjh2?=
 =?utf-8?B?ZnFuaTFoWFBLM3YxYjZDZFZ0VExEaEFLYWNBVSs3d0NTWGxybGlKUHk3OUt1?=
 =?utf-8?B?Rk9kTmJUSE1iVzhGbmZDOURpV3VBK0xaOEF6YldSUERjRktDdFc1bWd5Smhl?=
 =?utf-8?B?bWpUdUs4T2NBanZCZzNkVGd0YXJuNVVlclhWOTk4ODJpcjExY2lVU1oyUlAw?=
 =?utf-8?B?S20ycG1GWDBpbEowdXRPNlpDcUx2WEZ4T3ZOY21YaFZxRklSR0sybWUrdzRE?=
 =?utf-8?B?SUY4M0pZSm5XWGNHK0QyS3l4Z2ZDWVRnbXdPcERPY253elU4SGFyc3FmWGw4?=
 =?utf-8?B?VUd2Yml6YW12VEp4eFJ4UW13Zm5VbHRYRWR3MmVOWnV2eGk4dTlCMXhHOGZB?=
 =?utf-8?B?aW9xQXMyM1hRMWVWaDBQSUdaZE80Z21HZGs3SnlqdGlDWnRQNmlBc0Q5SGZx?=
 =?utf-8?B?VFVLaWlpRG9VTjZacktlQVNTMTJDRGRHU3pLN3hVTTdPb1ZFTUZndXVPVDN2?=
 =?utf-8?B?cnp5eUhNMWJNYndmNStUSlVpaHhOWjNwOXRjTzdHUk9Sc1RRR1k2VTlYSnU3?=
 =?utf-8?B?bzZmbHdnMnBjcWlZOHZIanlhQWp1bDJRVGhOc1dFQVBiSUFVSmp6TFlZVThm?=
 =?utf-8?B?Z2NySnpxWkxldm9nb1dzY3BCWlNBM2hvYSt5RkJ0dnY2MEZaQWxWbytLU2sz?=
 =?utf-8?B?NW93dzdsTFRwdGtuUGt1OW5ld1NyVkh2a2J2aGJwUkg5VmFxaFB6WFkyR1hX?=
 =?utf-8?B?dmpzVlBuckprS1BQNllKRlZDU2lsNW92b1drNkZRZUhuWXFxSFFUSUx0R01L?=
 =?utf-8?B?dlJ4d0s1STFRMENhWWlhRjdpSUVwNjgyMDFHbEdtTjhWcFp4YnVNbXZTeUFW?=
 =?utf-8?B?Q2lVVkRva3NqZDRNT21TQTRlVEt3NGQ1YTJYR3RSanM0WDFtaExvazdnU21t?=
 =?utf-8?B?bzBGT1BCWnQ0TjdTc1BMVXZlQnFTTlAydDF5eHduaExWbEYwdHlHVXZJa0RL?=
 =?utf-8?B?cDBzcVM4Z0paa1ltVE1ETU9uTjAxT3VtRHZsUVBBVlU2Tmc0RUZBK0RRWWlB?=
 =?utf-8?B?UVVlOEtySHcrVFQydjk3Um1KUzd2b3luS2dTSTBsT0pyR2k4M1ljOUhENkFZ?=
 =?utf-8?B?ZzgvSkU0TDhVZGVSOHRhcytKb1dSaEdLZEdaN2JMaVBDOGhkeXFGdU5tNzJx?=
 =?utf-8?B?a01NMldMTnJxYWd2RGc4RVlWWDNsY1dJL0hQcTdVREtCTEgwc1B3OG9Vc1lK?=
 =?utf-8?B?RnQ5dW5uWk9sdDl6NmhoN3NpK2VPWFVxOVBnanQ1TVY2aitjMEpYN3F1OHFM?=
 =?utf-8?B?WUxoY1NFY1lCd3YrRXN5b1VobGVzdC9jOUp2VklpeGpiL25iWDVNY0ZTVjZK?=
 =?utf-8?B?bFpyYVcwOFVTR2pzNUNFTnhHQVpaSktvQjc4VXhFM2pSSmM5a3NwZDNwb0g3?=
 =?utf-8?B?ODg3SlZUTEFlbVpBbThCRFV0U3ZwZHh3UWlqVkd3a2lpNHFpajlhUmNvVG5w?=
 =?utf-8?B?ZFY0VzBnWVlEM3dCdWVjQ3NNaUtWTndlN2VJeDVZN0JkRmhBcWI5dTVrWThQ?=
 =?utf-8?B?ZlVEZDRQaWV3NThzY2dtNEFHRHRiOWdSalIrd1ZvWjVQSXhvWlk5aVhIVVFC?=
 =?utf-8?B?RWk0QmxWcVZFQ1ZENVdWbHV0RFRWZUFQaCtaek5haVk0Q2xpUHh1YUJWdDJk?=
 =?utf-8?B?YnkvU0ZpZkx4T2pwb091QjlLQVRIVEhOQ3YxOTVmRG8vZmVqZXpkZ1d6bmRw?=
 =?utf-8?B?SWZuS2RldGk2YUdMVFNXdWpIYXc2ZE1oQ2MxUnBBTm9GOXdBV0JTUjJsbUJ4?=
 =?utf-8?B?eXBUNFMrK0VWeGJDbHRpUWU4OHRTTWVZODlmQjR2TERJWnlUYmVFNEZsTldp?=
 =?utf-8?B?ZjFLYzduY3RtUmtVSGFETlE0OFQ3VUcxajREaHZNUG5OQlYyVGZ0OWw3MHZU?=
 =?utf-8?B?TWRUL1RCMHQxd051VWNveUt0U2E2K2wvYTdNMXVoZ2EveUI2R2Z2a0lmOXpp?=
 =?utf-8?B?N0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DB74D8F30C05D14E9F4C500E21091C3D@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3fa8e16-9ebb-4bf0-0f70-08da9501ff61
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2022 21:01:43.8247
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mhzcy1BklmzpPb+ywPSf6kAo6UBYUD4q+RsUNf2hk6Ot10ubAQLmGA8l7KMiJ/hq0T7trF74b7iaB3dXuCndtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5819
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

T24gTW9uLCAyMDIyLTA5LTEyIGF0IDA3OjE1IC0wNzAwLCBTYXRoeWFuYXJheWFuYW4gS3VwcHVz
d2FteSB3cm90ZToNCj4gDQo+IE9uIDkvMTIvMjIgMTI6MDQgQU0sIEh1YW5nLCBLYWkgd3JvdGU6
DQo+ID4gPiArDQo+ID4gPiArVERYIEd1ZXN0IGRyaXZlcg0KPiA+ID4gKz09PT09PT09PT09PT09
PT0NCj4gPiA+ICsNCj4gPiA+ICtUaGUgVERYIGd1ZXN0IGRyaXZlciBleHBvc2VzIElPQ1RMIGlu
dGVyZmFjZXMgdmlhIC9kZXYvdGR4LWd1ZXN0IG1pc2MNCj4gPiA+ICtkZXZpY2UgdG8gYWxsb3cg
dXNlciBzcGFjZSB0byBnZXQgY2VydGFpbiBURFggZ3Vlc3Qgc3BlY2lmaWMgZGV0YWlscw0KPiA+
ID4gKyhsaWtlIGF0dGVzdGF0aW9uIHJlcG9ydCwgYXR0ZXN0YXRpb24gcXVvdGUgb3Igc3RvcmFn
ZSBrZXlzLCBldGMpLg0KPiA+IE9ubHkgVERYX0NNRF9HRVRfUkVQT1JUIGlzIHN1cHBvcnRlZCBu
b3cuICBXaGV0aGVyIEdldFF1b3RlIFREVk1DQUxMIHNob3VsZCBiZQ0KPiA+IHN1cHBvcnRlZCwg
b3IgaG93IHNob3VsZCBpdCBiZSBzdXBwb3J0ZWQgaXMgdW5rbm93biBub3cuICBOb3QgdG8gbWVu
dGlvbiAiZ2V0DQo+ID4gdGhlIHN0b3JhZ2Uga2V5cyIuDQo+IA0KPiBUaGUgcmVhc29uIGZvciBh
ZGRpbmcgdGhlbSBpcyB0byBnaXZlIGFuIGlkZWEgdGhhdCB0aGlzIGRyaXZlciBpbiBmdXR1cmUg
Y291bGQNCj4gYmUgdXNlZCBmb3IgdXNlIGNhc2VzIG90aGVyIHRoYW4gR2V0UmVwb3J0LiBRdWVy
eSBhYm91dCBwb3NzaWJsZSB1c2UgY2FzZXMgY2FtZSB1cA0KPiBpbiBhIHByZXZpb3VzIHJldmll
dyBhYm91dCAvZGV2L3RkeC1ndWVzdCBkZXZpY2UgbmFtZSB1c2FnZS4gU28gSSB0aG91Z2h0IGl0
IGlzDQo+IGJldHRlciB0byBnaXZlIGEgY2xlYXIgaWRlYSBvbiBob3cgdGhpcyBkZXZpY2UgbWF5
IGJlIHVzZWQgaW4gdGhlIGZ1dHVyZS4NCg0KQnV0IEkgZG9uJ3QgdGhpbmsgImF0dGVzdGF0aW9u
IHF1b3RlIG9yIHN0b3JhZ2Uga2V5cyIgYXJlIGdvb2QgZXhhbXBsZSwgYXMgaXQncw0KdW5jZXJ0
YWluLCBpLmUuIGNhbiBiZSB3cm9uZyB0byBwdXQgaGVyZS4NCg0KPiANCj4gTWF5YmUgSSBjYW4g
YWRkIGEgbm90ZSB0aGF0IGN1cnJlbnRseSBvbmx5IGF0dGVzdGF0aW9uIHJlcG9ydCBpcyBzdXBw
b3J0ZWQuDQoNCk1heWJlIHNvbWV0aGluZyBsaWtlIHRoaXM/DQoNCiINClRoZSBURFggZ3Vlc3Qg
ZXhwb3NlcyAvZGV2L3RkeC1ndWVzdCB0byB1c2Vyc3BhY2UgdG8gc3VwcG9ydCBhbGwgVERYIGd1
ZXN0DQpzcGVjaWZpYyBvcGVyYXRpb25zIGluIG9uZSBkcml2ZXIuICBDdXJyZW50bHkgb25seSBU
RFhfQ01EX0dFVF9SRVJQT1JUIElPQ1RMIGlzDQpzdXBwb3J0ZWQgdG8gcmV0dXJuIHRoZSBURFJF
UE9SVCB0byB1c2Vyc3BhY2UgdG8gc3VwcG9ydCBhdHRlc3RhdGlvbiBmb3IgdGhlIFREWA0KZ3Vl
c3QuDQoiDQoNCi0tIA0KVGhhbmtzLA0KLUthaQ0KDQoNCg==
