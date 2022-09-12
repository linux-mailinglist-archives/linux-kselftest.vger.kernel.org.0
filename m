Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 516915B553E
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Sep 2022 09:20:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbiILHT7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 12 Sep 2022 03:19:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230005AbiILHS5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 12 Sep 2022 03:18:57 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C31CB2F39B;
        Mon, 12 Sep 2022 00:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662967031; x=1694503031;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=6D9MT7Awf2gfI0NvviigEnvCwK5hBgpIQbp5C/fwMRA=;
  b=d2VKICyWKXMyB5bdNsFN4vVZ4TxIRR2wXR++G7iBDYLvf2aIrBdpVXIJ
   NaEfldLEGscM0G6mSLfEWmtjOjvPCNAzuhdIchF2XNK96ZguOd8/GgJgs
   x9fWFVj3UVaeKrbIJUzjQ/tPnsKFqIayBpuiBzyzYaA1QzM5091noh4pF
   glVoJFDRyoo0JITxhOpRmFIDMsWXLyznH5N1Ap99DxRZuDfCJJmUdk2uS
   yQcBZ0RA9HY/462Amp7VueuJnyUvLEQR3Q3BgrQVlRSSTTIS64/H7xJ0u
   CYZoS0WAGTlUXycITCrjFSMRkZyYb9cJOJ/wGURj0dPNWXDkHemjTfVLh
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10467"; a="324031195"
X-IronPort-AV: E=Sophos;i="5.93,308,1654585200"; 
   d="scan'208";a="324031195"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2022 00:17:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,308,1654585200"; 
   d="scan'208";a="861063566"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga006.fm.intel.com with ESMTP; 12 Sep 2022 00:17:10 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 12 Sep 2022 00:17:10 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 12 Sep 2022 00:17:09 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Mon, 12 Sep 2022 00:17:09 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Mon, 12 Sep 2022 00:17:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CGfA5Xoc70jcJjxhWyqS9OEKbL11JDOZv/DMMI46gLTX3vcpfp/xvhCql/uu5BDwo4FlmlWh2QIbW1FuPNI8hgEPc7IBryStMd4UtoksDtt3ajP95hr/9Lf4dzET9WI1hRKyzy+4GLBI4xSqrTXAaxtz6Q3A8GjLY5+n/mqQkQcimn4VSZfefm0t49k+3wzORVPtT4BBrw8mE3UyUGMGzWwlyKi4s/1GRWrk6r7foDPJL+Xl+VALJzxz+RzrZusR8rcOeLIwZWHSs4TimZbGxfJS2Jh3aNsylvThEeNzA+wIOyd4K1F5W83MfKDmFocLyuj57MO5xY6Q13bVDwMdGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6D9MT7Awf2gfI0NvviigEnvCwK5hBgpIQbp5C/fwMRA=;
 b=OLRPPsS05m2hRYnYLuvhiLdY2cc1FxUx1dpyvKu3XarUKsthi/I8Xmpe0vDFk6iRhdiR/tH+3HLt0Wd//gXJZb6wFrpiwKQJoSXdkdnoshydkhk9u72OqMN7Q0kS0VwvkSSLcX/Hqn/NSpYUwULD6cYpph6zMeMr4xKqfZWEhgUWwkdhi6yUM1GMLcflSA5hREt5fgfK1vZ761V1DrMStMPp+rCIGBRBO8ZABwkExpHVr+CzoWLsyxDwhP6e2G0ee5fy1/r3eDNZADN4B56YbxymRoevl9cDsQzAfddpZUmHbOG0WeuAfMbmoMQIOUKyDyemgf4xQILpZqqQJVt1YA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by SA1PR11MB6989.namprd11.prod.outlook.com (2603:10b6:806:2be::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.20; Mon, 12 Sep
 2022 07:17:06 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::e03d:fd3:dad2:2248]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::e03d:fd3:dad2:2248%6]) with mapi id 15.20.5612.022; Mon, 12 Sep 2022
 07:17:06 +0000
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
Subject: Re: [PATCH v13 2/3] selftests: tdx: Test TDX attestation GetReport
 support
Thread-Topic: [PATCH v13 2/3] selftests: tdx: Test TDX attestation GetReport
 support
Thread-Index: AQHYxII0tYXIMKuy6U6cCAuVrVQNk63bZk6A
Date:   Mon, 12 Sep 2022 07:17:06 +0000
Message-ID: <73c43175226bb0f9a9dcae8ba953b213db47fbc8.camel@intel.com>
References: <20220909192708.1113126-1-sathyanarayanan.kuppuswamy@linux.intel.com>
         <20220909192708.1113126-3-sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20220909192708.1113126-3-sathyanarayanan.kuppuswamy@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4 (3.44.4-1.fc36) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|SA1PR11MB6989:EE_
x-ms-office365-filtering-correlation-id: 32c9c346-b7be-430a-a660-08da948ecc64
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Uaw0UKb3hER2hHEY7588QEey2lIcCFb1L82R+VujrXvfEBxLFPbeVzVFutK1xqT+Xjd3mkqsRw17+5AVclisXiK8nRn5Y7L5c37+S3vH4VGlbDkdqnoXvEKjiA7wXm/EjVarNVM3du3WhWep6Zza6hKheMeNkoYx+iU2iX+KdI/eQDlC/Zj+n9pcMIXENFNzaE1v/Y0XF5pUESMYXZLwLyqmswDbZyNeq6poAFWB+Jsm/j57L2RaUnz96S4H1U6xQ6ayWAx9NuvxFHelkb8tXLqrjWLmmbNOjcoc0/Q+sKbo59L5lBxqUAaF26DKQRhgfS1BXT2a0yTsd1ao53GD6TIq9Kjg287zwjCDPNjVZxa25nbxD2UfUjHWTxm83cndutJvn/2xdFPCIxg9LmSY7Vy2+Tgce/bUNuHFLXePzxJRWInLsr+RHuc2UsMEiew/7XkNDi63DFwM1RewUzQHElF1PjAPja1fZmepgLReKPIM/yubjSFlhC6nqnFIvz7g0fOgEJWAt11RJkKurqIWcoYP/01KmMIAz8eld27fWWRxaB9R1BlvNMK3URqwzXL+lHtGsjihpZN/FGevm6WpweFeIIQTSIBfXqWmksZ4Md7iTS7bOaW0PF6Y1vyuntPhqAgQkDz1F3Zy4cfe0bgPRgHai4XusHwEAz3IVMeTx109rLQKKlxduSLTuKo3aDFjvHaV6daRl4X+hg1atHyBq17j0MnwvEt9yZ3fYFQ/UWnlWx29arIOiGmfWiyqhHsu4gg/rbHBjM7m49BI6eDJFw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(366004)(136003)(39860400002)(396003)(346002)(38100700002)(8676002)(122000001)(82960400001)(86362001)(66446008)(66476007)(91956017)(76116006)(66946007)(64756008)(66556008)(36756003)(38070700005)(83380400001)(2616005)(71200400001)(6512007)(41300700001)(6486002)(6506007)(478600001)(26005)(54906003)(316002)(110136005)(8936002)(2906002)(4326008)(186003)(7416002)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bWQ5MnFIMDI1UHRFeWdsSGlmRDVGWk9VUG1VeGptRVdvcWhXeFRIQ0EvWGJs?=
 =?utf-8?B?UW43SE5IYTFoWUhDNTVUdFYyaXVUdnJsS1IybGY5NHl3N2lUUW4zSFFad0Zy?=
 =?utf-8?B?Wmpmd2t2N1hyV3NQdlJvOXYreCtCVk5KNmJ5TS9VakEveTZDVC9iNlJYWjFz?=
 =?utf-8?B?WlBuZGMzNHhzd0dVNXZZSlVQUGgvNlZtUkVPL0tEWGVrRlhubi9zSmk3azhy?=
 =?utf-8?B?dmV6Y1crN2R4ZDZXa1A5NVRQaUthekxlRE9VYmRzUTV0aHNiSU5SZW5pTDNs?=
 =?utf-8?B?d3dzTnRHMitGZWcxK290WkFjWFJ3UUxkV0VIZHRlYTcrU0h0anV5RkZJN2Nx?=
 =?utf-8?B?TVlNR05EMklONFM2bjREeXZlbmJQRlBDYm5oS09DcG1wZDU3QjRlWlhNWDRh?=
 =?utf-8?B?S1ZEQkNlTUZ5dHV0bmNybjg4OEtmaEdnMTBGeklEMDIzRmEzWnZ0VlJtWm45?=
 =?utf-8?B?akxQazJJa21TNjI0S3VKU2JUSnVNSVR6dWlOZlVXZjh5STRBSjZYN1FQVHRV?=
 =?utf-8?B?ZFhXZWIyZkcrS2gzTUZ4dityc3RCUmlXRkNqbDFhVWM4Sm1FakJQMkpmTlB1?=
 =?utf-8?B?eFVVem9CajJ6ajN3b3R0NjRsYy95ZWJrOVRkMmdRTGFqRVd3cHY5aUprZkcr?=
 =?utf-8?B?V3VvQ1I3bERXNzhlMGRiOUpINW9mSmJ3VTNhYWloMW1yWUhHUElRQVVPTzB3?=
 =?utf-8?B?RE1uc2h5Um5xMnNKQmhLT0lyNkFmMGdqczRPa2EwUFpob1hmOG5DalpLM3FL?=
 =?utf-8?B?UUNIcGpWb1hFbWdUZjFyZGxzbUxRR1NBM0RjRXliMmY2M3o3YUJ4R2oyMnNi?=
 =?utf-8?B?blBMS2M3MG93V1ZubVIwNDZST3krWTZGejRPTGZBcEtXUHo0cGhUWVIyRFF3?=
 =?utf-8?B?dmFlSk83Z2lSVUN4N2lFSm96S2VjOEhBQzlhWHBUN0QxL2xhOU5HSzdveTFj?=
 =?utf-8?B?Y1NyZnZUbUl0ZmVPSUhvNWNHSTVwZkJuNnJDMTJXRkNvUjd0K2cwdVlnbnM3?=
 =?utf-8?B?cDV0NWI3ZmdVMjNmR1drVWdvYi9kdEZ2cnlQVG10LzZtU3N1YngrZkMwV2p0?=
 =?utf-8?B?U1RJcFNLRWtxSTVGdi9oNlhzRk1ZckhhV09qMXBoa2pvZm5Md094b2RHNnFF?=
 =?utf-8?B?VGVHYTJkRnZxZXZDb1pEWmEwbm1OVDUrc1hhS3Y1RVh0dGpIUFZJZld4Si9R?=
 =?utf-8?B?a2ZTNmxTdnlYdE1IMnlhQnkzalZxbmFTRkFISldOaW0rRlJjVy9GTWQ0U2Rl?=
 =?utf-8?B?QUhlcHZaTTlESHZySkZaZ0ZOMWFhZWlVZmFCZ1d5RUdrV0p1TS9VS210VnJ4?=
 =?utf-8?B?QnVZZCtWQWFBUHY3azJITXZ6VG9NbktPdm9iT0taNTFSbnFUbVFUN25jc2J0?=
 =?utf-8?B?bFV4MzRoditNbTRZVWtXZzkrR0k4NDVhalViTjRUVVJjWHprcCt4SUtOZGJD?=
 =?utf-8?B?VVBGMVFqOTAzN3VsZVJNMWc1a2l6MkJQZXVEcTd5WE1vZWVwdS9qVmk1RjN5?=
 =?utf-8?B?UTJoVXRLZzc3MG9uM3VyR1p0dGVpT1lHcVp2akFvcVFjeHQreS9YaFd2cGdH?=
 =?utf-8?B?THIzeGUzdVoxMThEdGJhQS9BZ3cwTVEvdi93bWxyTFppbzRrMVlVM3ZZOURK?=
 =?utf-8?B?aC81bHdPQU9UMnNNMzdnTHpRV0JVM2NtNkdYUGNIWmcyR1NxVWtDVGVGVkJI?=
 =?utf-8?B?T3NHVWY3R3RsMDQxR1JxbSt0cHNFT1NKdUpLdVlHTCtqaXdOMHltVEk2cVdR?=
 =?utf-8?B?cFc0d0RLMFMxZDZ3R3gyRU96ZmdnTDBsMTNvL0NDY1BiUEdUb01XKzJXVGpz?=
 =?utf-8?B?R0dBTCtzNHVQSnltVDBWemZlRlA5bFBjbVlmQVJ6eGpqMDlvNXYxRlkxTXA1?=
 =?utf-8?B?L3MxQXlDemkzanpuMm9uVWUrN3JESTA2TnA3WkhDcFdhSWJrQzZ6VVplUXlq?=
 =?utf-8?B?R2lLaG9EMGZtaG1aWXNQWTQxR2U4TTdkUE5YT1Y1MDNRMXdHekw2N0U4Qllr?=
 =?utf-8?B?d1VpdkdPVHE4aithQ05nd3JnUk14N2YzSDh0dzBZMUZtTEdNRDR6VXo4MSt2?=
 =?utf-8?B?ZG9PVDJlT1YrTjlQbnB6UUhNRWsrek1XRUplRW1rZVJEV2o5M2tTV0sybTVz?=
 =?utf-8?B?aE1LSnQ4bXRVcVJja283SUd1V053S3h4cU12RUl5MkZrU012Sy8rUmEzRXFI?=
 =?utf-8?B?TEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1E3740FBE6B89A479B73891DAE17241E@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32c9c346-b7be-430a-a660-08da948ecc64
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2022 07:17:06.1605
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CmSx9cmvr6QZcYMOLa1TbrZkh/8quYVpTb9ftK+Wsll8oTzGhAJD9Q4Kpq1MINT+tmsXrYw9y07gAKtyFjEAOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6989
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

T24gRnJpLCAyMDIyLTA5LTA5IGF0IDEyOjI3IC0wNzAwLCBLdXBwdXN3YW15IFNhdGh5YW5hcmF5
YW5hbiB3cm90ZToNCj4gQXR0ZXN0YXRpb24gaXMgdXNlZCB0byB2ZXJpZnkgdGhlIHRydXN0d29y
dGhpbmVzcyBvZiBhIFREWCBndWVzdC4NCj4gRHVyaW5nIHRoZSBndWVzdCBicmluZy11cCwgSW50
ZWwgVERYIG1vZHVsZSBtZWFzdXJlcyBhbmQgcmVjb3Jkcw0KPiB0aGUgaW5pdGlhbCBjb250ZW50
cyBhbmQgY29uZmlndXJhdGlvbiBvZiB0aGUgZ3Vlc3QsIGFuZCBhdCBydW50aW1lLA0KPiBndWVz
dCBzb2Z0d2FyZSB1c2VzIHJ1bnRpbWUgbWVhc3VyZW1lbnQgcmVnaXN0ZXJzIChSTVRScykgdG8g
bWVhc3VyZQ0KPiBhbmQgcmVjb3JkIGRldGFpbHMgcmVsYXRlZCB0byBrZXJuZWwgaW1hZ2UsIGNv
bW1hbmQgbGluZSBwYXJhbXMsIEFDUEkNCj4gdGFibGVzLCBpbml0cmQsIGV0Yy4gQXQgVERYIGd1
ZXN0IHJ1bnRpbWUsIEludGVsIFNHWCBhdHRlc3RhdGlvbg0KPiBpbmZyYXN0cnVjdHVyZSBpcyBy
ZS11c2VkIHRvIGF0dGVzdCB0byB0aGVzZSBtZWFzdXJlbWVudCBkYXRhLg0KDQpTaW1pbGFyIHRo
ZSBjb21tZW50IHRvIHBhdGNoIDMsIEkgZG9uJ3QgcGFydGljdWxhcmx5IGxpa2UgInRvIGF0dGVz
dCIgcGFydCBhcw0Kb25seSB0aGUgdmVyaWZpY2F0aW9uIHNlcnZpY2UgY2FuIHRydWx5IF9hdHRl
c3RfIHNvbXRoaW5nIChJIHN1cHBvc2UgdGhlICJTR1gNCmluZnJhc3RydWN0dXJlIiBoZXJlIHlv
dSBtZWFuIFNHWCBRRSB0byBnZW5lcmF0ZSB0aGUgUXVvdGUpLiANCg0KSSB0aGluayB5b3UgY2Fu
IGp1c3Qgc2F5IHNvbWV0aGluZyBsaWtlICJURFggbGV2ZXJhZ2VzIFNHWCBRdW90ZSBtZWNoYW5p
c20gdG8NCnN1cHBvcnQgcmVtb3RlIGF0dGVzdGF0aW9uIG9mIFREWCBndWVzdHMiLiAgQW5kIHlv
dSBjYW4gY29tYmluZSB0aGlzIHdpdGggYmVsb3cNCnBhcmFncmFwaC4NCg0KPiANCj4gRmlyc3Qg
c3RlcCBpbiB0aGUgVERYIGF0dGVzdGF0aW9uIHByb2Nlc3MgaXMgdG8gZ2V0IHRoZSBURFJFUE9S
VCBkYXRhLg0KPiBJdCBpcyBhIGZpeGVkIHNpemUgZGF0YSBzdHJ1Y3R1cmUgZ2VuZXJhdGVkIGJ5
IHRoZSBURFggbW9kdWxlIHdoaWNoDQo+IGluY2x1ZGVzIHRoZSBhYm92ZSBtZW50aW9uZWQgbWVh
c3VyZW1lbnRzIGRhdGEsIGEgTUFDIHRvIHByb3RlY3QgdGhlDQo+IGludGVnZXJpdHkgb2YgdGhl
IFREUkVQT1JULCBhbmQgYSA2NC1CeXRlIG9mIHVzZXIgc3BlY2lmaWVkIGRhdGEgcGFzc2VkDQo+
IGR1cmluZyBURFJFUE9SVCByZXF1ZXN0IHdoaWNoIGNhbiB1bmlxdWVseSBpZGVudGlmeSB0aGUg
VERSRVBPUlQuDQo+IA0KPiBJbnRlbCdzIFREWCBndWVzdCBkcml2ZXIgZXhwb3NlcyBURFhfQ01E
X0dFVF9SRVBPUlQgSU9DVEwgaW50ZXJmYWNlIHRvDQo+IGdldCB0aGUgVERSRVBPUlQgZnJvbSB0
aGUgdXNlciBzcGFjZS4NCj4gDQo+IEFkZCBhIGtlcm5lbCBzZWxmdGVzdCBtb2R1bGUgdG8gdGVz
dCB0aGlzIEFCSSBhbmQgdmVyaWZ5IHRoZSB2YWxpZGl0eQ0KPiBvZiBnZW5lcmF0ZWQgVERSRVBP
UlQuDQo+IA0KPiBSZXZpZXdlZC1ieTogVG9ueSBMdWNrIDx0b255Lmx1Y2tAaW50ZWwuY29tPg0K
PiBSZXZpZXdlZC1ieTogQW5kaSBLbGVlbiA8YWtAbGludXguaW50ZWwuY29tPg0KPiBBY2tlZC1i
eTogS2lyaWxsIEEuIFNodXRlbW92IDxraXJpbGwuc2h1dGVtb3ZAbGludXguaW50ZWwuY29tPg0K
PiBTaWduZWQtb2ZmLWJ5OiBLdXBwdXN3YW15IFNhdGh5YW5hcmF5YW5hbiA8c2F0aHlhbmFyYXlh
bmFuLmt1cHB1c3dhbXlAbGludXguaW50ZWwuY29tPg0KDQpBbnl3YXkgKGFsdGhvdWdoIHN0aWxs
IG5vdCBzdXJlIGFsbCB0aGUgZGVmaW5pdGlvbnMgb2YgVERYIGFyY2hpdGVjdHVyYWwgZGF0YQ0K
c3RydWN0dXJlcyBhcmUgbmVlZGVkKToNCg0KQWNrZWQtYnk6IEthaSBIdWFuZyA8a2FpLmh1YW5n
QGludGVsLmNvbT4NCg0KDQoNCi0tIA0KVGhhbmtzLA0KLUthaQ0KDQoNCg==
