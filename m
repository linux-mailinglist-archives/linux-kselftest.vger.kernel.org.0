Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA4CB7D9D92
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Oct 2023 17:55:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346304AbjJ0Pz7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 27 Oct 2023 11:55:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346249AbjJ0Pz5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 27 Oct 2023 11:55:57 -0400
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 603F8121;
        Fri, 27 Oct 2023 08:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698422156; x=1729958156;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=cuaMUbtl3GmUnHY0iGj/fC0kxNEoSSt24nilv7hZgvM=;
  b=DrysAPq1Pmmx23PN8Et78RUiB0qD3tAZ497tqNFxCETiSUdpahhOvPo/
   MzOZWe83YJQ/H1VzEPclNV7k4oDswA73kZCNN/yQPIFVKarwoAW2NhaEQ
   MCezP0bsOx2yrHrGdNYK4ppLym2zf6m0LJRrA/3OKwarpVPhnYTIQ7ttZ
   OrNSLpoJQfqVgcUvg5wAWWrIqeXL7yZKzp4Iymx4keqD6Xc9aKxFzX5Bw
   UJk8u/2P5MQw3YUWJv3V7qJQW6Rfb01GY9yKTvoRSvYraTGXk4eYm22Op
   zDelt5IY8rUZMRh9yJ6xIm/O2VSqQZu1s8CsjZ5SLItIsJj8+XnCO8qRR
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10876"; a="626423"
X-IronPort-AV: E=Sophos;i="6.03,256,1694761200"; 
   d="scan'208";a="626423"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2023 08:55:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10876"; a="788847980"
X-IronPort-AV: E=Sophos;i="6.03,256,1694761200"; 
   d="scan'208";a="788847980"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Oct 2023 08:55:54 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 27 Oct 2023 08:55:53 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 27 Oct 2023 08:55:53 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Fri, 27 Oct 2023 08:55:53 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Fri, 27 Oct 2023 08:55:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hV2NEGzmAkuhEzLzAXUyZaOuhQvatfDpftJLUsKunJ54vtiG7ryYdPQ6HYuLcsjX4ojfiFDqwxtpGN6DVfjDzl1uz646i7VpZbyGmcAn1PSQG/6qnjWP0Iro98H9wy2xPrNDFRwZ7xBhn8aIOaEvDKLLxD/58i0B7vqmgedIybnrR6/4KxKuHVIR1Sb/D1DiJorzhTCGB4G6+qiTHxBGEtRghF7/pBau5Ujybiaj2yMOsWkLHkr/GOSOJLA5FZ03OheV3CKtA6ty/rCB2qmFZO1OoWOwYC/JnTqORb78KUM6eMNZl9iKbdgwGdu978y/zhw1UJAyVljRwey/DCR3Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cuaMUbtl3GmUnHY0iGj/fC0kxNEoSSt24nilv7hZgvM=;
 b=bO01B67KrK+g+hgKtLsRb/DWVxVwwKHvwMDFE981XB39W8BQ846c+PMB0dldg2EC9J+UQZqGrwu6iB3Wjsqw9mHHl1XjfsVyr8d+sMTWyoE072U0PXWewuCLSQgRz7njzXfIKEVSLfoIk0z/SA6fSInvbyO74mpJ1ZQnsiSfrXqc7H64HDqTk6uIWDjMzJHbSxlrtBZwC5y4Tt4ot31MZBMQxLYXvw4tQ61eXwoNSiHN2Q6h9Di0K/CDEaEFRLwEcNyPI+3Qw0NBqBh7ngC27fLlWJf84ANmfVPgriQhePpZxpsO/iF9sGBR2yRgjOeinNHmgoDs61RZqrOM6FYsJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by CY8PR11MB7059.namprd11.prod.outlook.com (2603:10b6:930:51::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Fri, 27 Oct
 2023 15:55:51 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::4d44:dbfa:a7b4:b7c1]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::4d44:dbfa:a7b4:b7c1%4]) with mapi id 15.20.6907.028; Fri, 27 Oct 2023
 15:55:51 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "broonie@kernel.org" <broonie@kernel.org>,
        "Szabolcs.Nagy@arm.com" <Szabolcs.Nagy@arm.com>,
        "debug@rivosinc.com" <debug@rivosinc.com>
CC:     "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "brauner@kernel.org" <brauner@kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "mgorman@suse.de" <mgorman@suse.de>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "vschneid@redhat.com" <vschneid@redhat.com>,
        "bristot@redhat.com" <bristot@redhat.com>,
        "will@kernel.org" <will@kernel.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "jannh@google.com" <jannh@google.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "bsegall@google.com" <bsegall@google.com>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "juri.lelli@redhat.com" <juri.lelli@redhat.com>
Subject: Re: [PATCH RFC RFT 2/5] fork: Add shadow stack support to clone3()
Thread-Topic: [PATCH RFC RFT 2/5] fork: Add shadow stack support to clone3()
Thread-Index: AQHaBbRTBvR+3Qu63E+MwFOmoT8P7rBXkZMAgAAhcgCABKBHAIAAC/yAgAAupoCAAP4VgIAARLEA
Date:   Fri, 27 Oct 2023 15:55:51 +0000
Message-ID: <b2ae41fd9a9f05269c7ffcd10565942acbab2c16.camel@intel.com>
References: <20231023-clone3-shadow-stack-v1-0-d867d0b5d4d0@kernel.org>
         <20231023-clone3-shadow-stack-v1-2-d867d0b5d4d0@kernel.org>
         <dc9a3dd544bbf859142c5582011a924b1c1bf6ed.camel@intel.com>
         <8b0c9332-ba56-4259-a71f-9789d28391f1@sirena.org.uk>
         <2ec0be71ade109873445a95f3f3c107711bb0943.camel@intel.com>
         <807a8142-7a8e-4563-9859-8e928156d7e5@sirena.org.uk>
         <ZTrOw97NFjUpANMg@debug.ba.rivosinc.com> <ZTuj565SqIb9KjQr@arm.com>
In-Reply-To: <ZTuj565SqIb9KjQr@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|CY8PR11MB7059:EE_
x-ms-office365-filtering-correlation-id: f1c8b395-4841-49a1-4aff-08dbd70531f9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XHRYiri3H2vlzLIzx0sztu85PRYS6I0uZxCQunnTZASmALUgOVPqi0XSSQVppD1vs1t0tvjkoGPk7JyZ6/rZ+I8ohnLuFNQdjsosEI4OWwFWR8P8hlcJ+jXrPJUaLBlsJo8ejbpqRsyMEZeRXBpuGcMgenzRFdkhSJNQTt0TN9Gag+etLuTg6gLlQcxrhJl6FO1PSDZ96MlrQqtDLPh+/ncN3RfLEfl1Y9BY7IlpS7saLH6bGdIf08t9x0SlodR9dtiXQL69TDJpq/xlW+ApkkLhrij9eXn4IUMJ15dQ6OMOPtrMm9quGKwghru31OBnFC2CcV0XLHxzKBYU6RE6jws6csFmmWZNKJwh6cliBmMvafOTzJ6mrq/hznIKuEIrZmkQ2HuG3nd458Ako6QqtOjlhjO/8Qg+5Xyu+p0KibWiOCBAOyEa1ChCaFPZQPSPlhZXv/cXUaOEkJHk+iRheQs6gjizbeJvRgtQRsKUxBI/EFC4/8p9jjWQdmbS32U1AX7K+vWTZ+Dh+dB6cb9eNDwTXzM7I8hx7d/TbcGQP8EwWGSJom8igu18V/oURh8x+sEGt7+DCy12pAVCanU+yRcMDqvC6dp8qe+qvq0GnViuSrGzEQRC3g+PCdKrLsLG
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(136003)(396003)(39860400002)(346002)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(82960400001)(76116006)(91956017)(86362001)(6486002)(4001150100001)(2906002)(110136005)(64756008)(26005)(66476007)(36756003)(66556008)(66946007)(316002)(7416002)(66446008)(122000001)(38100700002)(54906003)(5660300002)(6512007)(38070700009)(2616005)(6506007)(41300700001)(8936002)(8676002)(478600001)(4326008)(71200400001)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YnJjc2xTaXplR3lxS2VzVlBoTTkwVW54T0xxMUpaQWkyNENwRk9VLzh6eVpN?=
 =?utf-8?B?WHRaUE5UbmQzeHM0M2xqODFjYmRMeGVmaitMZ2UxQlA5VW1yZEszemkwdVFN?=
 =?utf-8?B?UEw0dHlRVC9JN0lnME9POUMyeVFxRFlQaEkvUkw2aVE5UW4ybm1kaW1HUFE1?=
 =?utf-8?B?VnRCVnU0MmpKU1NhR012SDlzUXAwSHRNSEEyRTlnYktWa3dpamIydXd0cVhz?=
 =?utf-8?B?NWNhcGpRVmFKQXRQemhFYkJwVnd0dE5zdUh3SXlRbEJnN1FCRG1JcythTExK?=
 =?utf-8?B?bzFJTVZXKzlZdm9aWG96akdBZlZHdzdSMTVjcjB5YmJKeTNUcDN0T3FySkYr?=
 =?utf-8?B?QjlUcG5YeVMrTHJaYlc4bCt3SHEvbEw0RG92aUcwbFBvc3N6R3dYU0s1TnRj?=
 =?utf-8?B?bVFCenEvbkRiVWtKclROUVp2RzhsUUsxZlVlamhQM1IrUVlWY1BPaGZidmVT?=
 =?utf-8?B?NjFIVmQ0RU9MNUFGZ3hobTU0YUFTOW84MWxKNjVxTkRoT1BwUHJoL3pxbGdC?=
 =?utf-8?B?b2drRFlDLzhQdEVjTDVEVUNrUGhtMXcxV3JoRWVQdlZ1L1RQVk9vMWpnSjVO?=
 =?utf-8?B?bU0rZ1RBdEZ5N1FNWmdCWVU1WklMYWtQRnV0dHVLWTdab2s1TUhKalhFdjF3?=
 =?utf-8?B?YktZNlppS1h2dlhNbDFFWDFkVStta0drYmloZ3lxVUc3TC9odUpOS205aXlE?=
 =?utf-8?B?N0ZZZ1p2MkpzWXEyc0t2bnc3RWMvSElUODVVVUVmSmc5UmpKdTQ4WXlITjd2?=
 =?utf-8?B?Uk5mSDlnUGVJQ252NE1UeFBVSXdvaVl0TlYxSlpGaW5DZWZrQWE1SjhtekQw?=
 =?utf-8?B?V0pXMlJleDdrYTZFMFFyTGtvRGtHNXdvUmNHeTdEMUtQWnhqTjN0RnViTVp3?=
 =?utf-8?B?eUw5d0RxSG5Yc05hVjM3ald3KzVDWG1td21uNjNGR3RlWXhJd2ZHNVBPcjI4?=
 =?utf-8?B?clBFSHJYVkFScWlBR2MyajIvZThYVE5iZWdUTUxNamNrcXdpV0o0dFZhTk54?=
 =?utf-8?B?YnIxandUclNaZlZtbU9GV3diNGQ4MnFndmhhVzBYdm4rR3A0M2dURDI1Ry90?=
 =?utf-8?B?UlpzK0FLWXRyamxPOU1jcjlGZUN0alBzTXY4NU5Pb3JsT2FYL1F4a0czanlr?=
 =?utf-8?B?ay9ad05zbzBvMERnQjF6amQyei8xR0NrRVd4Nk9xcEVxdnRvK0ljNmNMa0hU?=
 =?utf-8?B?YWtjYnBOekc5NGJDVFFCbWlBcjE2eEE3enl6RmVCbGVmaU1QT1RLb3RDalQz?=
 =?utf-8?B?YWZjVXFlc1BZMTFNUW1EdDZydUx0R2NGeEJDeEhTQ2xZbEhFSUxObVdGYW00?=
 =?utf-8?B?cnp5eG5NeGN4TE8zV254VzQ1Y1l5VkswNEJodWV6ajVLQjVUL1ZQS0wvOTc2?=
 =?utf-8?B?b2UvbDJMOUs2ckhGOEZGZkhOOEtZcHVPSXF1K01NWjBJeWFvUUI5cEhVdFMr?=
 =?utf-8?B?OWVjTStHMmF5UWdLVXNFLzExUnBJUGxFVi96SlpES09HQlgxczUyMENXQXor?=
 =?utf-8?B?UGlTeXBSMVdrSjJISnNrRy8ySjdSbExMZ0MrNnU4N2VvNVQ5LzZkV3FhY3l5?=
 =?utf-8?B?a24rZVBWY0xhUzBTMlcvQUdQaFYwdWx3RUJzeCtDbVhJcTljTGtuRmNmSTJi?=
 =?utf-8?B?UzdEQkVURmt5UkhVa0pxRFZRdTdyUDY0YjFDWlI4RzZyRWtZMEdKTUtodTZm?=
 =?utf-8?B?cFdJR0FnNkVqaEVEOHZPekdMVHY4TWVHczNFMUppVzZVcXlIWDhoY1paSUgz?=
 =?utf-8?B?QUV2T0tLVWNveHk1aURvSjE1SFR1M2ZvMVF3ZHk1Q0ZsZFUxUk9lbytGZ08z?=
 =?utf-8?B?RHhDWUtDM2JxdXRuMlduWU90Vi9TVjlEM3VVS1UvMGtIYnVOamZKQXZDOTZ5?=
 =?utf-8?B?WkVOL05jRW5nbGlSUGhwMUtFZkFEazFGcTZ2UzFNa2ltRk94Q2lvZUV0NnJD?=
 =?utf-8?B?ODVvYVZvRFU3bTdkcHlkOGRQb29scEZFa2JaR1V2anU1NEpsRXIzbTYzRDNo?=
 =?utf-8?B?MVJCcXc5a1ZEZ3o2RVNSR3ZLSjQ4WFo4V0prRVJiRFlKdlZDMmlFeitnVjRO?=
 =?utf-8?B?d1NxWVR4bW1OZ0ZUNnZzQWJxbFcxRFlKenJ5VVNQMDRQdVFOd1VPamM4WGxv?=
 =?utf-8?B?MnphckFwTTQxcEp5RTd1SkdHbVdpaEt5M1VZS3lvNkxXWWlnTnJaU1pVcHVn?=
 =?utf-8?B?QXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <828389483393C54283C6ADB8BFA04305@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1c8b395-4841-49a1-4aff-08dbd70531f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2023 15:55:51.5771
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5C1MFrDed7Uf9Ss3OaTq0Uwn4Al+Dkm6N1SgO0Noe7hlk8BHg64LnoCPuRyHCbvmG/Su2MODTd1k8SFXPI2JRNemj0Sq3np7WB4mGO5nyGo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7059
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

T24gRnJpLCAyMDIzLTEwLTI3IGF0IDEyOjQ5ICswMTAwLCBTemFib2xjcy5OYWd5QGFybS5jb20g
d3JvdGU6DQo+IG5vLiB0aGUgbGlmZXRpbWUgaXMgdGhlIGlzc3VlOiBhIHN0YWNrIGluIHByaW5j
aXBsZSBjYW4gb3V0bGl2ZQ0KPiBhIHRocmVhZCBhbmQgcmVzdW1lZCBldmVuIGFmdGVyIHRoZSBv
cmlnaW5hbCB0aHJlYWQgZXhpdGVkLg0KPiBmb3IgdGhhdCB0byB3b3JrIHRoZSBzaGFkb3cgc3Rh
Y2sgaGFzIHRvIG91dGxpdmUgdGhlIHRocmVhZCB0b28uDQoNCkhtbSwgdGhpcyBtYWtlcyBtZSB0
aGluayBhYm91dCB0aGUgdHJhY2luZyB1c2FnZXMuDQoNCj4gDQo+IChvciB0aGUgb3RoZXIgd2F5
IGFyb3VuZDogYSBzdGFjayBjYW4gYmUgZnJlZWQgYmVmb3JlIHRoZSB0aHJlYWQNCj4gZXhpdHMs
IGlmIHRoZSB0aHJlYWQgcGl2b3RzIGF3YXkgZnJvbSB0aGF0IHN0YWNrLikNCj4gDQo+IHBvc2l4
IHRocmVhZHMgZXRjLiBkb24ndCBhbGxvdyB0aGlzLCBidXQgdGhlIGxpbnV4IHN5c2NhbGwgYWJp
DQo+IChjbG9uZSkgZG9lcyBhbGxvdyBpdC4NCj4gDQo+IGkgdGhpbmsgaXQgaXMgcmVhc29uYWJs
ZSB0byB0aWUgdGhlIHNoYWRvdyBzdGFjayBsaWZldGltZSB0byB0aGUNCj4gdGhyZWFkIGxpZmV0
aW1lLCBidXQgdGhpcyBjbGVhcmx5IGludHJvZHVjZXMgYSBsaW1pdGF0aW9uIG9uIGhvdw0KPiB0
aGUgY2xvbmUgYXBpIGNhbiBiZSB1c2VkLiBzdWNoIGNvbnN0cmFpbnQgb24gdGhlIHVzZXJzcGFj
ZQ0KPiBwcm9ncmFtbWluZyBtb2RlbCBpcyBub3JtYWxseSBhIGJhZCBkZWNpc2lvbiwgYnV0IGdp
dmVuIHRoYXQgbW9zdA0KPiBzb2Z0d2FyZSAoaW5jbHVkaW5nIGFsbCBwb3NpeCBjb25mb3JtaW5n
IGNvZGUpIGlzIG5vdCBhZmZlY3RlZCwNCj4gaSB0aGluayBpdCBpcyBhY2NlcHRhYmxlIGZvciBh
biBvcHQtaW4gZmVhdHVyZSBsaWtlIHNoYWRvdyBzdGFjay4NCg0KRG8geW91IGhhdmUgYW55IHVw
ZGF0ZWQgcGxhbnMgdG8gc2hhcmUgYXJvdW5kIHlvdXIgZWFybGllciBpZGVhcyBmb3INCnRva2Vu
IHNjaGVtZXMgdGhhdCB0cnkgdG8gc2hvb3QgZm9yIG1vcmUgY29tcGF0aWJpbGl0eSBvciBzZWN1
cml0eT8NCg==
