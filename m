Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA622740C6C
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Jun 2023 11:09:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237188AbjF1JIz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 28 Jun 2023 05:08:55 -0400
Received: from mga04.intel.com ([192.55.52.120]:40137 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235274AbjF1I5S (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 28 Jun 2023 04:57:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687942638; x=1719478638;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=V7XjONqXLIyYu6gij8BYeNtaZgZpHNfr9xnr9PaoIkU=;
  b=NlC1HYbyq1pWChOHS2KekT9eeZgJP7bwHwFcWOkcjVFSNwgTiyblQY28
   A5j1S6C6YNv2p6ySVaWqZ2Xy4iwe2T8Nl9XzG6MuHa4zdB9QGyHomqdeU
   oY4oX8J8TeRaittAGtNgH7NfCc8WpCHVlX7SXnIIdb63ACV8LE+Q4REIf
   4hyLCR4WWS92FxW9ArVBhNsnpREkNvz9oZay7tQzhOQp6xw30kTZhfGSn
   uaYBydT7cWVc6jVvFqUm3aEqY48RMqmGfVE+2LRRgsvNQSbMj+5KlxsHK
   zXt9mUQu5nd8l3yszhI+7wXc+BT0sshC8Aa7yNeO/E0ThvjZGJE34Qq9s
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10754"; a="360644358"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; 
   d="scan'208";a="360644358"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2023 01:56:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10754"; a="840989319"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; 
   d="scan'208";a="840989319"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga004.jf.intel.com with ESMTP; 28 Jun 2023 01:56:35 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 28 Jun 2023 01:56:34 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 28 Jun 2023 01:56:34 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 28 Jun 2023 01:56:34 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.46) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 28 Jun 2023 01:56:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lFZbEnFR46RXQGBodpo/DWmgYSDpR31cJzAxsYnKAkq+5Vy7HhpFeDW/YJV/byAibLWMIT4J4XsdFGO7QUSxoFmYbfOMmBr0qC3HFTlmFQGBUpmnszopQsjFRvGW7nGiTIC8uTketHuxjE3AXAXgaqsGh5Hxe1lWML5Ipnaw0OVD1tncGWcWAVkjcpAQeczggIypgw3HauRBSRjRvXwnS6YWa8N+IhAsmHzQFh0wRZI7kuQpI9c7zZEjK0p6rftGsA+MmPquk7hmx8Lh13qIJEngsMzOjGGXqOJrrISmRqAwB+NoaUpsAEubfcXAouG07jNlYAZqQRNNCCzOO5QcNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V7XjONqXLIyYu6gij8BYeNtaZgZpHNfr9xnr9PaoIkU=;
 b=cppvQNLDMY5YPeMcRE3C++KrJtoUZRixnal3EPUSqsEpmr7F8SC/NRlJ6WCTSKQGxELfHbX4NkEjKe3jDmCYYJtVi9ctOE6WuEqZZIw6Z2aglEMHKGz//+KrH5hPTMRFjR9PKOlHvVfZF51zmjRotoK5zl8DUDegSklaTQYN6RTeBQ1oVgoX/UOrdPFLlRMhPeTfin1OlAp+fSfk+bWl70LzFJ6BaXtnOoQiOcPLHcfLB+IucGoDf7cjaQxS7rqd01Iot63G4R2wPQYMRR0hW5E2JmvNLz4fynMHDKRrEoAPf9p5UaHP276NpazPTxOIIF6iOfjmmrmq4DkHuoL+EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by SA0PR11MB4750.namprd11.prod.outlook.com (2603:10b6:806:9d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Wed, 28 Jun
 2023 08:56:30 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::19b7:466f:32ac:b764]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::19b7:466f:32ac:b764%3]) with mapi id 15.20.6521.026; Wed, 28 Jun 2023
 08:56:30 +0000
From:   "Huang, Kai" <kai.huang@intel.com>
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "corbet@lwn.net" <corbet@lwn.net>,
        "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "Yu, Guorui" <guorui.yu@linux.alibaba.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "joey.gouly@arm.com" <joey.gouly@arm.com>,
        "dionnaglaze@google.com" <dionnaglaze@google.com>,
        "qinkun@apache.org" <qinkun@apache.org>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Du, Fan" <fan.du@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "wander@redhat.com" <wander@redhat.com>,
        "atishp@rivosinc.com" <atishp@rivosinc.com>,
        "Aktas, Erdem" <erdemaktas@google.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "chongc@google.com" <chongc@google.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "brijesh.singh@amd.com" <brijesh.singh@amd.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "dhowells@redhat.com" <dhowells@redhat.com>
Subject: Re: [PATCH v3 3/3] selftests/tdx: Test GetQuote TDX attestation
 feature
Thread-Topic: [PATCH v3 3/3] selftests/tdx: Test GetQuote TDX attestation
 feature
Thread-Index: AQHZhjUev+9U/9vzEkKqwBILfHYrRq+HtK4AgBGCl4CAA3KQAIABCfuAgAHp14CAABfAgIAAC1WAgABLSQCAACRpgA==
Date:   Wed, 28 Jun 2023 08:56:30 +0000
Message-ID: <e30fb40d736ccc60672316c5d20aaf1ab7c94dcf.camel@intel.com>
References: <cover.1684048511.git.sathyanarayanan.kuppuswamy@linux.intel.com>
         <972e1d5c5ec53e2757fb17a586558c5385e987dd.1684048511.git.sathyanarayanan.kuppuswamy@linux.intel.com>
         <64876bf6c30e2_1433ac29415@dwillia2-xfh.jf.intel.com.notmuch>
         <64961c3baf8ce_142af829436@dwillia2-xfh.jf.intel.com.notmuch>
         <9437b176-e15a-3cec-e5cb-68ff57dbc25c@linux.intel.com>
         <CAAH4kHa85hCz0GhQM3f1OQ3wM+=-SfF77ShFAse0-eYGBHvO_A@mail.gmail.com>
         <649b7a9b69cb6_11e68529473@dwillia2-xfh.jf.intel.com.notmuch>
         <CAAH4kHY1-N+HOxPON6SuXE3QPowAGnwTjc5H=ZnNZwh7a+msnQ@mail.gmail.com>
         <c85324480053af20e6f0409e28fbc5e156c54143.camel@intel.com>
         <2023062805-drove-privatize-ae2c@gregkh>
In-Reply-To: <2023062805-drove-privatize-ae2c@gregkh>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.2 (3.48.2-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|SA0PR11MB4750:EE_
x-ms-office365-filtering-correlation-id: c92ac5e6-ae17-444e-90dc-08db77b5908a
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Dz6NRsyK99+NqUKIqWJxF1RrCB7VETfxyxKOAT8u1GPbk3leDvWZMqCicGnOZqungFVxF0qD0cvwwLYJC0YV5ThMdb1Kk+K+M3KUNVjgeLjAlsh7K3lKJi6RSdMpt7loCKvw+9HcGNsw24Iba+bKl04SiVUd27Tgl8kBYWOTMxJ/KfZwb2eSNN1CLyT1wh5ezmPjY/5bWkmvCVFW+IRnLo8Zd7V4X2/hNWUDBLVIqfnf/s0RDRdrRCO/6h2UNeaovPc+3GRfOzjd8VO20rp5jLVZ8pjY+05KEde1Yb4Rg8P6MCx8lyAndBg6CJ1TXlUPMmh32pNNxMwGsN6Wb2gy24DY2i/wrV3VtFPvyjEXngeNWbWL5seBp3bPGr8DhQlIVMAN4sMK1U18vLrcqO/PGCYTJX60/EmHk0CY7/Y6IxfI6TsFA3K604J8tBie4woGWOurBz+jvwcRuSXfbXEfSa1z2MQcr5HdXQdKmUhG+ojfTjpnuH5dHe+MDA4hzgGT2+q9bhtUrNdO3ZcAAvPCu9crC1I4I9hw/SJO9SZqXJH9L8cNJhdj4826OVni130v6rxT2FKR5T0zAxYoR953JWPygLSsnahfksVhzOn9VW4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(346002)(39860400002)(396003)(376002)(366004)(451199021)(66446008)(966005)(6486002)(2616005)(83380400001)(71200400001)(54906003)(6512007)(6506007)(26005)(2906002)(186003)(478600001)(6916009)(122000001)(5660300002)(7416002)(36756003)(64756008)(4326008)(66946007)(316002)(38100700002)(8936002)(76116006)(41300700001)(82960400001)(38070700005)(66476007)(91956017)(8676002)(86362001)(66556008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cUh2SnM4UWlYeU1LeXgxc2w2NEdOUUlPK1dxV3VhSXpDRWZQR3VzL0hLTFJu?=
 =?utf-8?B?cEpoemhTQ01hb0RCYTFwajdUTUI0ZjJ5SFhXczBRM2k4MVpsaTNmblRVTlBK?=
 =?utf-8?B?Sk1RODAvMEhhTG1YTUNvQ1F3U2VzcmRiQXJuakExSlA2cEliTjQ0ODEwc01R?=
 =?utf-8?B?WWRLOTIxazJwZi9vdW9oK2VPQ20zcEhCYXp3elRtNWFieUNaVU5GOUkrVzc2?=
 =?utf-8?B?K2JPR3FpMmFObEdtWkkwU0FhWmMrWFBWbDZ1c2EwVzVXWUhqL0dxVGg4RzVL?=
 =?utf-8?B?QW13RW4vOWlEelYrL2tRN0p2V1BNcngvSU84SDIrQTNHVHl0WjhrRnNjMU1T?=
 =?utf-8?B?V050R1c0OEUyb2dWUDBaTnprMHlvZytsZ0M5OUhtK3JTTndXcTROaWNFMW5Y?=
 =?utf-8?B?a01qbEJPT2Z0VlYvYUJqaHpVTmhZeTgzcWVTejZjN1JIUVlWdWZZY1kxWkg4?=
 =?utf-8?B?NnN4TWIrTzFJUnp2U2NvdXhwZytmaDJBeWV6TXlEQmEwSm02K3E3REpvdlZ1?=
 =?utf-8?B?YWg0dUhlbmsxV2FoWkJERlRCT1JNWmFOVjQrTHVIM3ZsQVFpYXU2ZTQ3OFhx?=
 =?utf-8?B?Tkk5eUZVNXZWRERwcHhLVkQrYmdmZHd5OGhab3ZVL1RPL2graEZJcTNLSkU5?=
 =?utf-8?B?azgrZTZ2bUoxY2RYcHdJWE9FUEV2elphMTVUaXgzWXZ5ZDBRWnZFRHhDbXFP?=
 =?utf-8?B?a0pZTGJCWVROaWcvN1hMUW5JMmdkYzVoRFNqeHNsWE1iZnlMSzdaSDlJWEJh?=
 =?utf-8?B?UWZOUmE4WlJMY2JYSFFxNUhPWVl2RDE3RXJHVlpWT2w5aGlYb0VOY3RZQmRa?=
 =?utf-8?B?clQ0ZllrYnNlaHNwT2F2Q21aUkNTNFNBUjdYZzI1b2hobjd6MFZ2TjVnckhE?=
 =?utf-8?B?SkZzczR2T2hqdWhDc2lrZ3hET3B1Z042VjErenNsYXNmSWZXekMzRzVvamhO?=
 =?utf-8?B?V2tsWVBwWHEvZm9zbE55cmQyZXd2SHZDSzlaVDdxNlk3eDN5enI3VFI2WFN2?=
 =?utf-8?B?ZUQzc3J1bForaXhmSEhraGV6R0RCWW1CNjNqRmtqK2xlbHZBTlAvOE81Qkwz?=
 =?utf-8?B?cEF4QnB2RjRDanlFeUhRWForK283aEhlczM1d0hMOWovWFRXWFQ0ZXUrQTF2?=
 =?utf-8?B?ZThrMXkvNlk2ZlJlb3NxcE0xd3hnQWZKZFFtbnU0dVgyUWZOc0dTZkZzN2R1?=
 =?utf-8?B?VUhNSXBhWEpsY0Z0N3M1SE9ZdWFad0thalZ2L05UZmVCbU9JSTJLcjMvMmpq?=
 =?utf-8?B?dnNNNjNueCtnazd2WGNKVlpQTWtPUXJ0V1RlbDNwU0JGcFpYWHFGWmxZcGkz?=
 =?utf-8?B?dDd0SHdhUzBaa1dJRE5rZ09MRWV1bGNJSEpuOElHNVpaQUVDbzVFMFB4Y1FB?=
 =?utf-8?B?K0o0alJlSklWK3ZUbEFLT1NXbWJsTFZhTDM1dXBLV2V1K0Yxa0dlRWlWeWU5?=
 =?utf-8?B?Z3lXYVFIalNrbE5QdUtvdXNJQ3Z3VitOWE9RSThhWWhFVkRiMjV6cjVINTln?=
 =?utf-8?B?V3ViaVR3Uldkanp5djRXRXc5OU5Vb01acFJSNm8xTUQrTHZWUDd0bjRVUFdW?=
 =?utf-8?B?SS9WRzh6cDNoRjlUNVBjTjJmNzhRcVEvTzVvRHNDZ0h2WHBOK09SRi9UeHUr?=
 =?utf-8?B?dWpUK09zNEU4M0lWa3R3cE03QXI0TG1JODVPVVQzN0ZDdmpqRjBvelBxZk1S?=
 =?utf-8?B?RWJsc2hIYmRySXJ1ZTA1T015OXE1bHdLcVRrdVFCZ0NJTEpnOW5FUmZ0OFRi?=
 =?utf-8?B?czBqQU14aDh4eTdsQm5RQmpWdlVKWUpId2ZUdEVzWjhWdTdmMUEwQmh1NEVn?=
 =?utf-8?B?SE5LbG9kNFdSckpGQUlteUh0OFVRMXdvS0VKZ3RhbUVrYjdlc0FvSUdiK0VQ?=
 =?utf-8?B?K2NDdUIrbHl0RnQyckVDbE10YXRpRXQvUUtRT1dzc1p1YzZJNFNRWGVFeFdn?=
 =?utf-8?B?WE1TUXdVTUtTdnViOTM3cnl6dmlJL0FrOWlxZkxNN3JXeTNncFlpSHBRZHY1?=
 =?utf-8?B?WnlFcG94NGt3d3lrVDNKMnNVQmUvK2RodkRpL0ZyeHdKYUZudXdIZzlyQkFu?=
 =?utf-8?B?V0NKcHhubUU2TUFDR05zYzdOcFJFQmFPM2lXL2EydFBRcER4cDQwZDMrN0ZW?=
 =?utf-8?B?VnVzaFE0aTA3ek5nWEl1TVRrZVVaMHJhakx4aU45MkNQRDA2eWdEb0h1bWti?=
 =?utf-8?B?ZEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <ED5080F17F9057479736042631A99323@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c92ac5e6-ae17-444e-90dc-08db77b5908a
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2023 08:56:30.0282
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: d+uwAFCLSGdRqlAE/befOtn/BxPPIyhh57KUqHzL0gjpg9Z8erIw7ul+Q4nukc7Ni6QohVcAi2lFodSRFWysSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4750
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

T24gV2VkLCAyMDIzLTA2LTI4IGF0IDA4OjQ2ICswMjAwLCBncmVna2hAbGludXhmb3VuZGF0aW9u
Lm9yZyB3cm90ZToNCj4gT24gV2VkLCBKdW4gMjgsIDIwMjMgYXQgMDI6MTY6NDVBTSArMDAwMCwg
SHVhbmcsIEthaSB3cm90ZToNCj4gPiA+IFlvdSByZWFsbHkgc2hvdWxkbid0IGJlIHB1dHRpbmcg
YXR0ZXN0YXRpb24gdmFsaWRhdGlvbiBsb2dpYyBpbiB0aGUNCj4gPiA+IGtlcm5lbC4NCj4gPiAN
Cj4gPiBBZ3JlZWQuICBUaGUgZGF0YSBibG9iIGZvciByZW1vdGUgdmVyaWZpY2F0aW9uIHNob3Vs
ZCBiZSBqdXN0IHNvbWUgZGF0YSBibG9iIHRvDQo+ID4gdGhlIGtlcm5lbC4gIEkgdGhpbmsgdGhl
IGtlcm5lbCBzaG91bGRuJ3QgZXZlbiB0cnkgdG8gdW5kZXJzdGFuZCB0aGUgZGF0YSBibG9iDQo+
ID4gaXMgZm9yIHdoaWNoIGFyY2hpdGVjdHVyZS4gIEZyb20gdGhlIGtlcm5lbCdzIHBlcnNwZWN0
aXZlLCBpdCBzaG91bGQgYmUganVzdA0KPiA+IHNvbWUgZGF0YSBibG9iIHRoYXQgdGhlIGtlcm5l
bCBnZXRzIGZyb20gaGFyZHdhcmUvZmlybXdhcmUgb3Igd2hhdGV2ZXIgZW1iZWRkZWQNCj4gPiBp
biB0aGUgcm9vdC1vZi10cnVzdCBpbiB0aGUgaGFyZHdhcmUgYWZ0ZXIgdGFraW5nIHNvbWUgaW5w
dXQgZnJvbSB1c3JzcGFjZSBmb3INCj4gPiB0aGUgdW5pcXVlIGlkZW50aXR5IG9mIHRoZSBibG9i
IHRoYXQgY2FuIGJlIHVzZWQgdG8sIGUuZy4sIG1pdGlnYXRlIHJlcGxheS0NCj4gPiBhdHRhY2ss
IGV0Yy4NCj4gDQo+IEdyZWF0LCB0aGVuIHVzZSB0aGUgY29tbW9uICJkYXRhIGJsb2IiIGFwaSB0
aGF0IHdlIGhhdmUgaW4gdGhlIGtlcm5lbA0KPiBmb3IgYSB2ZXJ5IGxvbmcgdGltZSBub3csIHRo
ZSAiZmlyd21hcmUgZG93bmxvYWQiIGFwaSwgb3IgdGhlIHN5c2ZzDQo+IGJpbmFyeSBmaWxlIGFw
aS4gIEJvdGggb2YgdGhlbSBqdXN0IHVzZSB0aGUga2VybmVsIGFzIGEgcGFzcy10aHJvdWdoIGFu
ZA0KPiBkbyBub3QgdG91Y2ggdGhlIGRhdGEgYXQgYWxsLiAgTm8gbmVlZCBmb3IgY3JhenkgY3Vz
dG9tIGlvY3RscyBhbmQgYWxsDQo+IHRoYXQgbWVzcyA6KQ0KPiANCg0KSSBndWVzcyBJIHdhcyB0
YWxraW5nIGFib3V0IGZyb20gImtlcm5lbCBzaG91bGRuJ3QgdHJ5IHRvIHBhcnNlIGF0dGVzdGF0
aW9uIGRhdGENCmJsb2IiIHBlcnNwZWN0aXZlLiAgTG9va2luZyBhdCBBTUQncyBhdHRlc3RhdGlv
biBmbG93IChJIGhhdmUgbm8gZGVlcA0KdW5kZXJzdGFuZGluZyBvZiBBTUQncyBhdHRlc3RhdGlv
biBmbG93KSwgdGhlIGFzc3VtcHRpb24gb2YgIm9uZSByZW1vdGUNCnZlcmlmaWFibGUgZGF0YSBi
bG9iIiBpc24ndCBldmVuIHRydWUgLS0gQU1EIGNhbiByZXR1cm4gImF0dGVzdGF0aW9uIHJlcG9y
dCINCihyZW1vdGUgdmVyaWZpYWJsZSkgYW5kIHRoZSAiY2VydGlmaWNhdGUiIHRvIHZlcmlmeSBp
dCBzZXBhcmF0ZWx5Og0KDQpodHRwczovL2RvY3MuYXdzLmFtYXpvbi5jb20vQVdTRUMyL2xhdGVz
dC9Vc2VyR3VpZGUvc25wLWF0dGVzdGF0aW9uLmh0bWwNCg0KT24gdGhlIG90aGVyIGhhbmQsIEFG
QUlDVCBJbnRlbCBTR1gtYmFzZWQgYXR0ZXN0YXRpb24gZG9lc24ndCBoYXZlIGEgbWVjaGFuaXNt
DQoiZm9yIHRoZSBrZXJuZWwiIHRvIHJldHVybiBjZXJ0aWZpY2F0ZShzKSwgYnV0IGNob29zZSB0
byBlbWJlZCB0aGUNCmNlcnRpZmljYXRlKHMpIHRvIHRoZSBRdW90ZSBpdHNlbGYuICBJIGJlbGll
dmUgd2UgY2FuIGFkZCBzdWNoIG1lY2hhbmlzbSAoZS5nLiwNCmFub3RoZXIgVERWTUNBTEwpIGZv
ciB0aGUga2VybmVsIHRvIGdldCBjZXJ0aWZpY2F0ZShzKSBzZXBhcmF0ZWx5LCBidXQgQUZBSUNU
IGl0DQpkb2Vzbid0IGV4aXN0IHlldC4NCg0KQnR3LCBnZXR0aW5nICJyZW1vdGUgdmVyaWZpYWJs
ZSBibG9iIiBpcyBvbmx5IG9uZSBzdGVwIG9mIHRoZSBhdHRlc3RhdGlvbiBmbG93Lg0KRm9yIGlu
c3RhbmNlLCBiZWZvcmUgdGhlIGJsb2IgY2FuIGJlIGdlbmVyYXRlZCwgdGhlcmUgbXVzdCBiZSBh
IHN0ZXAgdG8NCmVzdGFibGlzaCB0aGUgYXR0ZXN0YXRpb24ga2V5IGJldHdlZW4gdGhlIG1hY2hp
bmUgYW5kIHRoZSBhdHRlc3RhdGlvbiBzZXJ2aWNlLiANCkFuZCB0aGUgZmxvdyB0byBkbyB0aGlz
IGNvdWxkIGJlIHZlcnkgZGlmZmVyZW50IGJldHdlZW4gdmVuZG9ycyB0b28uDQoNClRoYXQgYmVp
bmcgc2FpZCwgd2hpbGUgSSBiZWxpZXZlIGFsbCB0aG9zZSBkaWZmZXJlbmNlcyBjYW4gYmUgdW5p
ZmllZCBpbiBzb21lDQp3YXksIEkgdGhpbmsgdGhlIHF1ZXN0aW9uIGlzIHdoZXRoZXIgaXQgaXMg
d29ydGggdG8gcHV0IHN1Y2ggZWZmb3J0IHRvIHRyeSB0bw0KdW5pZnkgYXR0ZXN0YXRpb24gZmxv
dyBmb3IgYWxsIHZlbmRvcnMuICBBcyBFcmRlbSBBa3RhcyBtZW50aW9uZWQgZWFybGllciwgInRo
ZQ0KbnVtYmVyIG9mIENQVSB2ZW5kb3JzIGZvciBjb25maWRlbnRpYWwgY29tcHV0aW5nIHNlZW1z
IG1hbmFnZWFibGUiLg0K
