Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3F0F7D874D
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Oct 2023 19:11:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234684AbjJZRLA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 26 Oct 2023 13:11:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231771AbjJZRK7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 26 Oct 2023 13:10:59 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 624EC116;
        Thu, 26 Oct 2023 10:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698340256; x=1729876256;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=i1CUoyWm90D8FLe7lhpSu9M57XJZ8r6Durc5teJfCaA=;
  b=YcsLbTcwmZEhbHQVZvhTME48h2fnl8BqDGUbpsiEYbyawpOyEmpXcq/Z
   BAncm6wiXw3lCoo3EKEq4fMFlRc+YmVy2FDrAqQSQrJQANUsJpAxR6oCw
   XCCPHAlMBP49f8vsO2epAMbFBvBu+MYA+LDbXP2ke8UjxDRKA8UFkST0h
   fw6qti9J1xbYVUbhLwi93ieCTfhatnjtXRW0mD6lDDOtOotxOYX0owDIK
   iSjz+yMnnlA92wR4cR0JzCUQU/bQJis5SHKhVuYRV63I95EQgIBeY4jZ/
   ATf9qTcfyeuCu6ffjZmmJ79b23263yGhcaVzAKWmZZBc/hpSM/uG4uzwa
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10875"; a="387423335"
X-IronPort-AV: E=Sophos;i="6.03,254,1694761200"; 
   d="scan'208";a="387423335"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2023 10:10:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10875"; a="794294812"
X-IronPort-AV: E=Sophos;i="6.03,254,1694761200"; 
   d="scan'208";a="794294812"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Oct 2023 10:10:55 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 26 Oct 2023 10:10:55 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 26 Oct 2023 10:10:54 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Thu, 26 Oct 2023 10:10:54 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Thu, 26 Oct 2023 10:10:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fQJcSgfsg2grR4adDw3v7EYHralvAxckLd1RZInu2pS/vgLGAZQElngt2h8XHixXKb29B0SzeZHXyFr0PMjVvs9LtncMMJE4oRe/6l5N94mJEFGVpXpRzAGq/NfiOGzu7v2GY8umB1AlImo35mTAZbDnL5jy2SvxbYdksWA+UhiQDfNbgS4G4jav2JzA2kNu3fGt+qMJu6dtbUAokXlAS/GrmtXvOwn80CwTefBx6Emsk4zqt9NEPFzK4tTeRtZ+RvzOJGr+FnEvbrbgKHcMUBpFSNriTbgWQdT0T37NBugh3iTP22I3S4lzs6AFOqZQ78eKxBJ5EWApvA3hrsKB5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i1CUoyWm90D8FLe7lhpSu9M57XJZ8r6Durc5teJfCaA=;
 b=MtX1nPGNeLqy6Ky5SrLBm/7izIiuQX2NMBrwndAXCJTLHrA0R5gcMf8jAMTTlhH82I87vY9iZl7NUMMcSz2mxoZ23SrHvyIHJeszfgqwkfzQJR3hHR2plA3TMhKkJJNjQhEsYGAsQ8JpZcPuJXQZ5NR1OXA1FEqL1FB01x4NTH6J4xSD3jHd0JUnVokm0VljrGLvgJfrw0Qc2RWUK8QQF7ybdKib7tAwdXgh26FuqMjtl35MRsZU1HssYoyhs7XGhnHDZoOKXuoj7bpuFJky6XNDYceF5JQrswaWV+X7IqCPjs9PuC6SlV8Dejs/8xrPZ4HkI0GTQgqf8sYFEk7Ewg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by SJ0PR11MB5070.namprd11.prod.outlook.com (2603:10b6:a03:2d5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19; Thu, 26 Oct
 2023 17:10:48 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::4d44:dbfa:a7b4:b7c1]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::4d44:dbfa:a7b4:b7c1%4]) with mapi id 15.20.6907.028; Thu, 26 Oct 2023
 17:10:47 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "broonie@kernel.org" <broonie@kernel.org>
CC:     "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "Szabolcs.Nagy@arm.com" <Szabolcs.Nagy@arm.com>,
        "brauner@kernel.org" <brauner@kernel.org>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "debug@rivosinc.com" <debug@rivosinc.com>,
        "mgorman@suse.de" <mgorman@suse.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "vschneid@redhat.com" <vschneid@redhat.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
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
Thread-Index: AQHaBbRTBvR+3Qu63E+MwFOmoT8P7rBXkZMAgAAhcgCABKBHAA==
Date:   Thu, 26 Oct 2023 17:10:47 +0000
Message-ID: <2ec0be71ade109873445a95f3f3c107711bb0943.camel@intel.com>
References: <20231023-clone3-shadow-stack-v1-0-d867d0b5d4d0@kernel.org>
         <20231023-clone3-shadow-stack-v1-2-d867d0b5d4d0@kernel.org>
         <dc9a3dd544bbf859142c5582011a924b1c1bf6ed.camel@intel.com>
         <8b0c9332-ba56-4259-a71f-9789d28391f1@sirena.org.uk>
In-Reply-To: <8b0c9332-ba56-4259-a71f-9789d28391f1@sirena.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|SJ0PR11MB5070:EE_
x-ms-office365-filtering-correlation-id: 98ced7b0-44a6-4a5c-b71b-08dbd6467f92
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7ByLvsH9j9qxM+aX7dMEe/smux42Q88StDGpAu2iRH8txwIRWRHCvyMWyz/2dfculfsyWg7JA+WkQa1QCcSPmApv7AQ44LY5ofd4WYkZAZDeHUgpP5zBpzKObO3tS/03RId0YhqWw9Cl39+24vqzHrUGJMcNOuLIoMZGIQs4FwSX5ZmEyEIX23zHoll0arW3iXtRcbTwx54FIWwbyEm0EU4vMtEJvTQCfGFh4wOgbc/3sQg7mozDKDneuSZOzOrwhSA4Dz0LtYhx2jrGewy2SyHV+2LA/NwjGsMsFoDFB3mO/9KY9khHr1gGM38Ra3AERElqjEIBkzp4Hi14I8IFvZ/kkaNq+0TFmFJoi+ng1m1wKx/4fCXlJVC0YrU5ZMlFHEYjLpSU49kfcZCgGkZ2qCqKL9oYoXLuoSNkjnus0z5TgNxAw1he8pkcWt1lrhu8Dvf880uUHuEUL8lKBK4OWTtmxrkrZZ4jwB9oXzNlAjoSMjgzTFImfTISZCtY2qepsT+aae4cQomjxX6Haol7SACRqsdTtbReeHqqc0vE7zaSahUk819y09k/j82Jlrf9X5DANY3JEYjfqkl0Mcw5bjktGw0xrGeeGb+fa94gs+LuXsfGXEY2LlDYWGkRPJVR
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(376002)(396003)(346002)(39860400002)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(2906002)(4001150100001)(7416002)(5660300002)(41300700001)(82960400001)(26005)(38100700002)(38070700009)(4326008)(8676002)(8936002)(83380400001)(91956017)(76116006)(316002)(66446008)(64756008)(66476007)(66556008)(2616005)(6916009)(36756003)(54906003)(6512007)(66946007)(122000001)(478600001)(6506007)(71200400001)(86362001)(6486002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?anJHOVRodkt5R0g2NktwK0FHRHpHN2tIVVlSRnIrNVY0UlJ1eXh2UDZaQVRU?=
 =?utf-8?B?Tk0vbnh1Q3FFZWo3K0lOR0FMenpvMDl2MVR3bjI1dWpiVG5qanFkMUR2NjM5?=
 =?utf-8?B?Z0duc1BZbnJtVHRVODZYRnBNTG4vRk43Sld4cFJXWXRLWmZIOFBUZHJVVkd1?=
 =?utf-8?B?NHNkNUpoY0pWZTUyYlo0NnBKMW82WjBtZW5USEExUXBqUW5uUlRNdVJYek1i?=
 =?utf-8?B?SWQxdDJOOHpjOWVGenBMWVNIdGlJcjVta2lTZUVhQnpZTXFyVDEzKzNvOWRj?=
 =?utf-8?B?b2x0N2VuRnY0MWhZbTZRM1ljMFB5ZXpLdTllL3RXd05pbzFhczllaVFHM0dn?=
 =?utf-8?B?TUNlVERyQ3IzSGpNM0plVEJVYSs0eDNUeFp0Wk9xZ04vWk5WN2tlUDJKaUM1?=
 =?utf-8?B?MmYySENmeEtWTktCbDFnZ1BtZkVWa096UEtmejBNeTE3RHI5Mk0vWkd2THZn?=
 =?utf-8?B?M3dPUklLbGNleGVXV21ib2hqL09IUW5kNHhxbFlGK2VLS2cwa2lBalc1MStS?=
 =?utf-8?B?UUFLV0wzdlFvQ0UzOFFwNXhpK3Fidno3T1FGVFVUdkp5TGZIOXpXK1ZSbjFI?=
 =?utf-8?B?Wkc2cHpNVWtNTHUvLzR5QTByUEU4QVdEN0JCbmhkK2tTaEVtTGdNeWp1SzRE?=
 =?utf-8?B?Yk02a3BMN1E4d0k5MEVGd1NqcHd5KytMMC93VnlKVHFETXlvaFVmVXA3aWZP?=
 =?utf-8?B?SHVzNXg5M3BUK1J0K2paZUhUaUF6UDdKNlorZUNjU1Q3ZUlreS9Kem9MV0kv?=
 =?utf-8?B?SEx2LzJUaXZIQUtNRVF0cWpFL1E0UGZ4U0JsckxRWGo5YW9YN1EwSVhhK0I0?=
 =?utf-8?B?TWZza3BFSTVyWEk1SitNYmJpVEFuQ2lySEtmbER3bWxlSnVHSEZxTW1rWFZl?=
 =?utf-8?B?aVF5eHRocEtNaWdZemUwcGRYQ0h1RnhsaTZGRDJRUU4zRVFuckVkMEpUT3px?=
 =?utf-8?B?aWROWFZHa0lPbHNLWHl6ZUVwdVRJT1VaUktqRzZ6OTJCU1JMUFlsQ2k2M2pV?=
 =?utf-8?B?R3ZSN051bHkwekpxUGk0Q2J0M2dmTlRRblc2cnFuNENtSlFycnNtVWhSWHJU?=
 =?utf-8?B?d0JZb3p5dnY3Nk5mOTRTQWRLMnl5T3lNdVJPaE1hRUlYUWRuOGtzRDhJRC95?=
 =?utf-8?B?WFZIc1llbmU1UnJlVDNyWnpTMmZReHdseExLVi95MmFpNnlTZTg3eEQ2NHRz?=
 =?utf-8?B?dkNOK2gyVXpORVpnb3JCa1NBU0VCaUsxSVp5cVdHYVVicU9zTmxVZG90bnpV?=
 =?utf-8?B?dUxpNUorVXhUeDYwbiswOWp0aHNSbDVXZyswU3VnTEQ2UkR2aUxMYkt4ZENt?=
 =?utf-8?B?eFkrSkt6bDcyUDdSWjRxM2ErVzJpTWF5OG10Q0JHYStRTTUyT0R6UkZZL0Nx?=
 =?utf-8?B?QnRmTnNMK1hhd3BteE1LSFZRVFpSTnk1TENpMGliNkpPZUwyK2toMTNnL2pz?=
 =?utf-8?B?NDZ2OTlVZE4zeitZdHhxcFBBL0dYM0s2dEl2L21kMENoc3ZZRlVXU0xaODg1?=
 =?utf-8?B?U0greDJ0bnZKS2tUcWdyd2hndnNQVDdRbXJtYU96NFY3ZjZ2TFVYQTcyUWVI?=
 =?utf-8?B?UjZ1a01vVStHdE5TbHNSM3o0cGRzSnB6a2FYalRKMWc1WEF2VGJsMy9SUC9X?=
 =?utf-8?B?MEdDdmVMc0ROT1IyODlsUXNDRHNrWU9SNGNLbWFpZVVLQ2lORy9JU21JME91?=
 =?utf-8?B?TnhoUngyUk5vanhGNGYyOXRhTTBTV2dXQzBoTUxHZ2VMOGdCZURkLzBVTlYy?=
 =?utf-8?B?WFFkU1lJYnJLeWs4VTdSL3FiSjFGZHlvc1FGODNNdTRqV0E4ZlZOalNLejFw?=
 =?utf-8?B?KytrWnNHeVRpWmNNSGdTNU1QaE1URmZLT2YwNW9halFQTnhiSmUvUzBjbG50?=
 =?utf-8?B?cHV3RitJRGVONnZ2c2dVMDVyTi9sMXBtZkgzMjJocUsyZFMvWXNYR0FHMm9B?=
 =?utf-8?B?M2g2U0Q2MnRVamtPaVVjaEF4S0tNZW9UaU5jMWpWMGlYK3I0cDVtbk9maEk3?=
 =?utf-8?B?L0hTa0IxdnNIOEJ5SG9EeFk1WlV6RkJWaGJ6NVZWVURiU0lSRWtTd0g1Qkh5?=
 =?utf-8?B?MkFLbkRvdGlVcFNUR3JpNFp3NjhZRzlNNDlNaTU0Q1NaUys0endNa0QvNzJx?=
 =?utf-8?B?MVVzRUpYengrOHZQZ1VYNVM5OGdNOFNpRWwwdEliM3hDMHMrdnlubUF3Rkpm?=
 =?utf-8?B?Y0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <938DCE4DDF231E47A7E13060DA6FA748@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98ced7b0-44a6-4a5c-b71b-08dbd6467f92
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2023 17:10:47.9284
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: atawSXBWfVy0WDbH5AR8/OhntLDzPABkiJCEyF6yH9xzUlzYbKM9FaPNzkpJt6jLKzENvnE1SxubTDVzOKMQlAAM/JuIwW6AakZL1fWDcgo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5070
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

T24gTW9uLCAyMDIzLTEwLTIzIGF0IDE5OjMyICswMTAwLCBNYXJrIEJyb3duIHdyb3RlOg0KPiBS
aWdodC7CoCBXZSdyZSBhbHJlYWR5IGFkZGluZyB0aGUgY29zdCBvZiB0aGUgZXh0cmEgbWFwX3No
YWRvd19zdGFjaygpDQo+IHNvDQo+IGl0IGRvZXNuJ3Qgc2VlbSB0aGF0IG91dCBvZiBzY29wZS7C
oCBXZSBjb3VsZCBhbHNvIGFsbG93IGNsb25lMygpIHRvDQo+IGJlDQo+IHVzZWQgZm9yIGFsbG9j
YXRpb24sIHBvdGVudGlhbGx5IHJlbW92aW5nIHRoZSBhYmlsaXR5IHRvIHNwZWNpZnkgdGhlDQo+
IGFkZHJlc3MgZW50aXJlbHkgYW5kIG9ubHkgc3BlY2lmeWluZyB0aGUgc2l6ZS7CoCBJIGRpZCBj
b25zaWRlciB0aGF0DQo+IG9wdGlvbiBidXQgaXQgZmVsdCBhd2t3YXJkIGluIHRoZSBBUEksIHRo
b3VnaCBlcXVhbGx5IHRoZSB3aG9sZQ0KPiBzaGFkb3cNCj4gc3RhY2sgYWxsb2NhdGlvbiB0aGlu
ZyBpcyBhIGJpdCB0aGF0IHdheS7CoCBUaGF0IHdvdWxkIGF2b2lkIGNvbmNlcm5zDQo+IGFib3V0
IHBsYWNpbmcgYW5kIHZhbGlkYXRpbmcgdG9rZW5zIGVudGlyZWx5IGJ1dCBnaXZlcyBsZXNzIGNv
bnRyb2wNCj4gdG8NCj4gdXNlcnNwYWNlLg0KDQpUaGVyZSBpcyBhbHNvIGNvc3QgaW4gdGhlIGZv
cm0gb2YgZXh0cmEgY29tcGxleGl0eS4gTm90IHRvIHRocm93IEZVRCwNCmJ1dCBHVVAgaGFzIGJl
ZW4gdGhlIHNvdXJjZSBvZiB0aG9ybnkgcHJvYmxlbXMuIEFuZCBoZXJlIHdlIHdvdWxkIGJlDQpk
b2luZyBpdCBhcm91bmQgc2VjdXJpdHkgcmFjZXMuIFdlJ3JlIHByb2JhYmx5IGhlbHBlZCB0aGF0
IHNoYWRvdyBzdGFjaw0KaXMgb25seSBwcml2YXRlL2Fub255bW91cyBtZW1vcnksIHNvIG1heWJl
IGl0J3MgZW5vdWdoIG9mIGEgbm9ybWFsIGNhc2UNCnRvIG5vdCB3b3JyeSBhYm91dCBpdC4NCg0K
U3RpbGwsIHRoZXJlIGlzIHNvbWUgZXh0cmEgY29tcGxleGl0eSwgYW5kIEknbSBub3Qgc3VyZSBp
ZiB3ZSByZWFsbHkNCm5lZWQgaXQuIFRoZSBqdXN0aWZpY2F0aW9uIHNlZW1zIHRvIG1vc3RseSBi
ZSB0aGF0IGl0J3Mgbm90IGFzIGZsZXhpYmxlDQphcyBub3JtYWwgc3RhY2tzIHdpdGggY2xvbmUz
Lg0KDQpJIGRvbid0IHVuZGVyc3RhbmQgd2h5IGRvaW5nIHNpemUtb25seSBpcyBhd2t3YXJkLiBK
dXN0IGJlY2F1c2UgaXQNCmRvZXNuJ3QgbWF0Y2ggdGhlIHJlZ3VsYXIgc3RhY2sgY2xvbmUzIHNl
bWFudGljcz8NCg0KPiANCj4gVGhpcyBhbHNvIGRvZXNuJ3QgZG8gYW55dGhpbmcgdG8gc3RvcCBh
bnlvbmUgdHJ5aW5nIHRvIGFsbG9jYXRlIHN1Yg0KPiBwYWdlDQo+IHNoYWRvdyBzdGFja3MgaWYg
dGhleSdyZSB0cnlpbmcgdG8gc2F2ZSBtZW1vcnkgd2l0aCBhbGwgdGhlIGxhY2sgb2YNCj4gb3Zl
cnJ1biBwcm90ZWN0aW9uIHRoYXQgaW1wbGllcywgdGhvdWdoIHRoYXQgc2VlbXMgdG8gbWUgdG8g
YmUgbXVjaA0KPiBtb3JlDQo+IG9mIGEgZGVsaWJlcmF0ZSBkZWNpc2lvbiB0aGF0IHBlb3BsZSBt
aWdodCBtYWtlLCBhIHRva2VuIHdvdWxkDQo+IHByZXZlbnQNCj4gdGhhdCB0b28gdW5sZXNzIHdy
aXRlIGFjY2VzcyB0byB0aGUgc2hhZG93IHN0YWNrIGlzIGVuYWJsZWQuDQoNClNvcnJ5LCBJJ20g
bm90IGZvbGxvd2luZy4gU3ViLXBhZ2Ugc2hhZG93IHN0YWNrcz8NCg0KPiANCj4gPiA+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAvKg0KPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCAqIFRoaXMgZG9lc24ndCB2YWxpZGF0ZSB0aGF0IHRoZSBhZGRyZXNzZXMgYXJl
DQo+ID4gPiBtYXBwZWQNCj4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKiBW
TV9TSEFET1dfU1RBQ0ssIGp1c3QgdGhhdCB0aGV5J3JlIG1hcHBlZCBhdA0KPiA+ID4gYWxsLg0K
PiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAqLw0KPiANCj4gPiBJdCBqdXN0
IGNoZWNrcyB0aGUgcmFuZ2UsIHJpZ2h0Pw0KPiANCj4gWWVzLCBzYW1lIGNoZWNrIGFzIGZvciB0
aGUgbm9ybWFsIHN0YWNrLg0KDQpXaGF0IGxvb2tlZCB3cm9uZyBpcyB0aGF0IHRoZSBjb21tZW50
IHNheXMgdGhhdCBpdCBjaGVja3MgaWYgdGhlDQphZGRyZXNzZXMgYXJlIG1hcHBlZCwgYnV0IHRo
ZSBjb2RlIGp1c3QgZG9lcyBhY2Nlc3Nfb2soKS4gSXQncyBhIG1pbm9yDQp0aGluZyBpbiBhbnkg
Y2FzZS4NCg==
