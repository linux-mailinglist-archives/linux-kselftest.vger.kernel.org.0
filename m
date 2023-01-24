Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2179B67A6C7
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Jan 2023 00:20:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbjAXXUZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 24 Jan 2023 18:20:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbjAXXUY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 24 Jan 2023 18:20:24 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A725B303DA;
        Tue, 24 Jan 2023 15:20:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674602423; x=1706138423;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=URE+6PT07fmRbSMlmWmUWXzwHA40MsB/FeGoCK9BYU4=;
  b=h28N1Y9AXxkQPm5SIeZRKO6xlvDvDrmTI8XXN2UV0o7D3cXc3Utu0cH5
   79K4H+JhcPY13beXn11o/FxGmaD0ksZz4UtRsXgrfbQgGsrQkSN5MJM/v
   qzXSPJgrpPUjnSKzqNhnYSDq/blxKPzilJUKsgt5Z5+YFJSqCk08WvyFe
   SDGT/bmK0SpmOO89HMd24mjO8ogy7NlQjL+SlI4y4Vv1xG6I8HDcsI11S
   dmvaHNLAnXWKVwJP91B7g3L0891FNHZdEDJFIVNuVh6RRJw/rRMnWoO+A
   pu+o1aEC+0iABYkYbWg0Et1Mxdw9LjuVd2stwuRQoD0qJMlvnLCvX4g4/
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10600"; a="306789325"
X-IronPort-AV: E=Sophos;i="5.97,243,1669104000"; 
   d="scan'208";a="306789325"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2023 15:20:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10600"; a="786253363"
X-IronPort-AV: E=Sophos;i="5.97,243,1669104000"; 
   d="scan'208";a="786253363"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga004.jf.intel.com with ESMTP; 24 Jan 2023 15:20:19 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 24 Jan 2023 15:20:19 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 24 Jan 2023 15:20:19 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 24 Jan 2023 15:20:19 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.177)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 24 Jan 2023 15:20:17 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=glrJF8GuHJRnFaN/9pP01ALdCp5MReQ4Lpr4AmaAXxxRcEwHAwXx+pABCLN1QOJwMA7ZcDZtBmc8Nli/BIQo3FuxEAELtmUzt7j/cBzymuKM1dEtztGhZ2B8VFfUD92BBzwkf5G7VuLJc08XGQ/zOk3kgE71M7OrV54csCg9e4vFoe7sgsdrnQTZZEnkvM6PxIrXpLvVwQ7EOwRcfY77NeDsC/RWMqtzTCQyCXcYPceXaEVifEb9jB3qMhITS4B+TjGWRacrdHbhNXdnREo2zAl8YWIPdvR4Ol1GrBzGx3xvAfhwJpZNeKQy7DcUCD7ZGsCk79HLYUxPtBmIo6MnQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=URE+6PT07fmRbSMlmWmUWXzwHA40MsB/FeGoCK9BYU4=;
 b=eSOtuuePB4gtqyIXTAnR2T5RTWOrT3hqU8IeYdimER71fjksjAsncJD0e1AcJHijLM8fY5IZPTPf0vIEdjIFDEz5um8StYazeqkcZH8i5K2ZqgmtHyane83tz053oL7IyEMU856Xz4PP07EU1LYV/fZvZimzNHvXAdtRD9ZSkeIuPAlUI32wGmowDFTckj0qGrp48XNiXuMBvstCAjNZVIplTaDlx3uth+QUrPmrNpXMXSGQOntronWrAW+28YSKKnEA/AIlBgr9oZMsE93ugZEuAErW9VffoC+LqBf1+lRVweeZQshJZr5K3wPZ02S6lwZOP/Kg4RWmWroosKpGDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA1PR11MB6734.namprd11.prod.outlook.com (2603:10b6:806:25d::22)
 by MW4PR11MB5933.namprd11.prod.outlook.com (2603:10b6:303:16a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Tue, 24 Jan
 2023 23:20:12 +0000
Received: from SA1PR11MB6734.namprd11.prod.outlook.com
 ([fe80::59d:4c93:47eb:9811]) by SA1PR11MB6734.namprd11.prod.outlook.com
 ([fe80::59d:4c93:47eb:9811%5]) with mapi id 15.20.6002.026; Tue, 24 Jan 2023
 23:20:12 +0000
From:   "Li, Xin3" <xin3.li@intel.com>
To:     "H. Peter Anvin" <hpa@zytor.com>,
        Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        x86 Mailing List <x86@kernel.org>
CC:     "Hansen, Dave" <dave.hansen@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        Brian Gerst <brgerst@gmail.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Shuah Khan <shuah@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Linux Kselftest Mailing List 
        <linux-kselftest@vger.kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: RE: [RFC PATCH v3 0/2] selftests/x86: sysret_rip update for FRED
 system
Thread-Topic: [RFC PATCH v3 0/2] selftests/x86: sysret_rip update for FRED
 system
Thread-Index: AQHZL9wHXOCNBEx4pEaxwC77ioU9Ra6uFIBQgAAD9oCAABxwoA==
Date:   Tue, 24 Jan 2023 23:20:11 +0000
Message-ID: <SA1PR11MB6734D1FC972F663487E9140DA8C99@SA1PR11MB6734.namprd11.prod.outlook.com>
References: <b6e36a5c-6f5e-eda6-54ad-a0c20eb00402@intel.com>
 <25b96960-a07e-a952-5c23-786b55054126@zytor.com>
 <fb1cab9f-a373-38e6-92e6-456332010653@gnuweeb.org>
 <6cd0db14-c9e2-3598-fd10-4b473d78c373@citrix.com>
 <5ecc383c-621b-57d9-7f6d-d63496fca3b3@zytor.com>
 <20230124022729.596997-1-ammarfaizi2@gnuweeb.org>
 <20230124022729.596997-3-ammarfaizi2@gnuweeb.org>
 <ce25e53f-91d4-d793-42a5-036d6bce0b4c@zytor.com>
 <Y899kHYbz32H1S6a@biznet-home.integral.gnuweeb.org>
 <BC632CA8-D2CB-4781-82E5-9810347293B0@zytor.com>
 <Y8+hGxVpgFVcm15g@biznet-home.integral.gnuweeb.org>
 <20230124100926.637335-1-ammarfaizi2@gnuweeb.org>
 <SA1PR11MB6734CA3184183E490D18CA72A8C99@SA1PR11MB6734.namprd11.prod.outlook.com>
 <7E935340-B596-4663-80FF-CDC4E31896B4@zytor.com>
In-Reply-To: <7E935340-B596-4663-80FF-CDC4E31896B4@zytor.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB6734:EE_|MW4PR11MB5933:EE_
x-ms-office365-filtering-correlation-id: 833beeb9-c182-48c6-a903-08dafe618ac7
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LNbOeyvV9CQ75OiDVW2YTnYpOWW0F3VTNlmBwL5MKkrYLZGcN5z5WsJZIQtx8vz/cEZBACqkr2bd/dzYK7jAEFG1K6/fZfbeTQVN0iI+1XD9mNfUUOWU6evYWhMfeaRsVdbTe8siuCG/VnwQdCBTERW1wTen1ilfU04dB1IdzBLQSuuPhbTd+81X5qSJsztIzi7P8RjAOjbqtyDY3DOFsLGfBH6ouGGvb/DNO/kos/hIW1K3g/krOUsDMW2BHXETthbWoJZ5CPYJbQ4N/vHvKdF6Zw3iDONQv/hiNHQkVY6tc+2TBO2YI0EEDkUsNE+Iu8XMzCmGKHK7fJGjhKsQVmbLyw92TTypD9nJdTETHYQGM8WccMNghsjg/kLqoZ5rCMx3AD/d7/5DlaAKXfWBQD45ljqW62kz178EEalyWxr+GTSkALSeZ40Xgu4CuviIvGfFgNX6lyUaS+jacJjIWGim6xAGuDwwilucBqa8sKYk3YBuNefJSgsuImGoeSzCTk5dvUkSHrFOyT39IRVHeMIM/9gikMEosKLuM7dkqSuBNDwUGMmzplkZEzWJbsDiJnFB5HalsyAd4k/pJdF/OC6mUqGfagNKOXbO92QHYRGTgTBykcBuxXCA/TjK06VPsjFJyDqNB7DFPIcmadbrzgxEhZYmcuu1Ozj7TGXCVTaBrjO5aFFKR3vR6vRublgaO653jVcjL25SrNRWDZQRXw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6734.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(136003)(376002)(346002)(366004)(39860400002)(451199018)(33656002)(122000001)(82960400001)(38100700002)(41300700001)(6506007)(86362001)(8936002)(26005)(52536014)(9686003)(55016003)(7416002)(66946007)(4744005)(186003)(5660300002)(316002)(64756008)(66556008)(2906002)(478600001)(8676002)(66476007)(38070700005)(110136005)(7696005)(71200400001)(54906003)(76116006)(66446008)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZEgzWnFQSUd1dXc4OTBnKzdpUXJIQVkzdngzeEVFMUVJd2ZyS2lXZzI3Z0dl?=
 =?utf-8?B?aVh4by9wRnROczBSbXE4VDVBUi9wdDZ3R25CbDJUbk44SHBFaEU3WUdRS09N?=
 =?utf-8?B?VS8xamZWNmZTeFIzNU9aZ3VSbmkyL0NTT3EwSVZnNlhET2NyM253dlkyTW9Z?=
 =?utf-8?B?Vi9oRWw5ZGQrYVl2TEl3b0g5ZW1NUVRxRFU5Tzd2NlRObHErTDViajdLWlRO?=
 =?utf-8?B?NWM1VGxWQkpoSWpTVEY5amNQNHdPVWhKTWdWczRqQ1BuWGZPeURyMnFIdGJ1?=
 =?utf-8?B?aWVES25pS1lwak92Z1VCN2Y2dVc3NXV2ZmJZU05TT1hDZTNGZ3B6bzdpN1N3?=
 =?utf-8?B?bGFwQUtPRnFydG9mZDVIRmgxSHphQncyOVpiTDVpNDNoazRvYjBQRHRUNHFG?=
 =?utf-8?B?TEhmR1hJM00rM0JmRGNlZDN5cnRHYWlpdnQ0elRwS2FwYTV1OWdKVzlHSG1T?=
 =?utf-8?B?UE5mRW1PSUlKYkc1WE1hbTJxTTllYjg4cmtyTll1RlpKbEZoSHAvSDRRcHFk?=
 =?utf-8?B?ckROTTVEYmpuZEZERS9SdGVTMWU5NWIxZWNHZ05wYXBZUXdacmNiajU5TkFu?=
 =?utf-8?B?V242K1RqVnF2NGxkSkFsNGQzc2cyUFYzRTdaazh3SmRVdWk3QWRQMFkraGlU?=
 =?utf-8?B?SGoydkVSODhaOVpWd0h5c09QSGpCZzg5bnhZeXV5NFFFLzczZ1BXL1JqdFNJ?=
 =?utf-8?B?cmRoUGw2bHl2NTQ5WDZJdFI0eTBYM2d2YTZIdEV0dTFLR3pJR0NYVWN6Y2t6?=
 =?utf-8?B?dTMyemtONk9ibkxDNW1hYjVtWlo4dy9IMWpySG5WMUwwNW5EWWRjNUJBUkdD?=
 =?utf-8?B?L3pERXZhTjVoQnJhZUpNQTB2VVpiMTZBUW4xZVdDbk04b1h2cEJYeng4SzBo?=
 =?utf-8?B?TW8wc0NiNGZtTWJkeUtKTjFHQ2tOaWJIQVl6NnhzZnp2SEJYWEFVUmRlZGpy?=
 =?utf-8?B?eFNUM2dtalhkTXVjeHRuL2k0VHFyUG1yWXR1QnZRemE5ZEMzOHA4NklxYVBm?=
 =?utf-8?B?ZkZtRkx1aWkxcXFMejRsckRUdEpLUzVjYmFpV1BkZ05yRkJIOC9rSjNmVU1q?=
 =?utf-8?B?VkVORmRxUmlPWGNoTGh0QUVpY2psNHNwYkw4cGpzNWhraVk2M2dQdE9XRXlO?=
 =?utf-8?B?NjZibWdNUFJxT3NVdkFXTVN5eDhkMkZaWktFVXhwWXp2NDZjR1RjUkJmTk9D?=
 =?utf-8?B?Qkd1cE9CeU82T09QRHluaE5Jd3BFNTVTd3ZnencvYWpZcXNDNHVuQmZ2S2xz?=
 =?utf-8?B?WEZXTDRmc2VIc20yM0xuNlF3Q0Nnd1Vab3g0TUJpV1RCNS9RQXFEM0E2UjR3?=
 =?utf-8?B?QjQzNStOSFZsbmdxVEpCOTYzNlRmdkVCVnJzV1RNRjRDbDJIZGU0VG5VTVY4?=
 =?utf-8?B?U25pUVFqRmU4TDVDbndEZFhObXRiYmI1Yk9EVVk1VjJQSlJGMGx1cEhTVm9Q?=
 =?utf-8?B?cU1FbjRUSWQyS3crOG8wTHlxV0FybFB0cEVFZ0JBaWhsc0VnRk94RXREUHhw?=
 =?utf-8?B?RXBGd0xGdW13a1A5bndJQnczZytTcHhUb2QxZjFhQ0hiOUEzV0F6ZVdrVzNm?=
 =?utf-8?B?MXJKUlJUZWY0c2pUYXlWeEE3RXZvcXcxZU1haW5IN3hZWkZzN1RlNlhJelJQ?=
 =?utf-8?B?dUpwNFF1YllIVGF2b3loemloQVQ4OGtYa0FXbG1FN0FRVGQ1L1dramsxNm82?=
 =?utf-8?B?WldBZkZESnJwL0NUUUsxMFQzZ2IwZWxlQWlkekZpQW1jaGlXbnRmV3dHdzBE?=
 =?utf-8?B?VVlPMFg0M0RuVzNvZUpuZ0VxRlhpZmUxSmdZdzJpSUYzM0pkR3liKzhnV2tS?=
 =?utf-8?B?dkx1QlBmWXRSaWVBWUVseEpWWFRRUzZGNEhYbys4SUVsbVVUVHM5ZnF0bXd1?=
 =?utf-8?B?SG1Gckl3dVlGaW15VGVTWjR4am1WS3hhYk9RamFvUnpYQmFIS3FheVFadDA4?=
 =?utf-8?B?Y3E5djRwVnZHRW9zOGNMdERIbE1zT0VUU3NQUFJlRUs2RDhBajE5a2JTcGxz?=
 =?utf-8?B?V3NrUHRuZjJOa0J5cFVSd0dPVjlpSjZYcDV5WStqMS9RSGNzNEN6dGtRMFA2?=
 =?utf-8?B?RkRVNVdVOUE1YUk0eWxEWXZZYTdjMjdQVmJ6UFYvYWg2OThieFlzcXduNzE1?=
 =?utf-8?Q?peeORyHqYc5PvserOOHkCuOdp?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6734.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 833beeb9-c182-48c6-a903-08dafe618ac7
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jan 2023 23:20:11.9345
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZR4dud2MWuKzLabo8Og3IZml/J3X9O+yR8Ho+ijnplOj2FZrfeLCJdeQ2owLP9MWVbIHRPCGkWkxTRyUaieWLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB5933
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

PiA+Pg0KPiA+PiBYaW4gTGkgcmVwb3J0ZWQgc3lzcmV0X3JpcCB0ZXN0IGZhaWxzIGF0Og0KPiA+
Pg0KPiA+PiAgICAgICAgIGFzc2VydChjdHgtPnVjX21jb250ZXh0LmdyZWdzW1JFR19FRkxdID09
DQo+ID4+ICAgICAgICAgICAgICAgIGN0eC0+dWNfbWNvbnRleHQuZ3JlZ3NbUkVHX1IxMV0pOw0K
PiA+DQo+ID5PbiBGUkVEIHN5c3RlbXMsIGZsYWdzIGlzIDB4MjAwYTkzIGFuZCByMTEgaXMgMHhm
ZWVkZmFjZWRlYWRiZWVmIGhlcmUuDQo+ID4NCj4gPldlIG5lZWQgdG8gcmVtb3ZlIG9yIGNoYW5n
ZSB0aGlzIGFzc2VydGlvbiwgbWF5YmU6DQo+ID4gIGFzc2VydChjdHgtPnVjX21jb250ZXh0Lmdy
ZWdzW1JFR19FRkxdID09IGN0eC0+dWNfbWNvbnRleHQuZ3JlZ3NbUkVHX1IxMV0gfHwNCj4gPiAg
ICAgICAgIHIxMV9zZW50aW5lbCA9PSBjdHgtPnVjX21jb250ZXh0LmdyZWdzW1JFR19SMTFdKTsN
Cj4gPg0KPiA+Pg0KPiA+PiBpbiBhIEZSRUQgc3lzdGVtLiBMZXQncyBoYW5kbGUgdGhlIEZSRUQg
c3lzdGVtIHNjZW5hcmlvIHRvby4gVGhlICdzeXNjYWxsJw0KPiA+PiBpbnN0cnVjdGlvbiBpbiBh
IEZSRUQgc3lzdGVtIGRvZXNuJ3Qgc2V0ICVyMTE9JXJmbGFncy4NCj4gPj4NCj4gDQo+IFRoaXMg
c2hvdWxkIHVzZSBjaGVja19yZWdzX3Jlc3VsdCgpIOKAkyB3aGljaCBpcyBleGFjdGx5IHRoZSBy
ZWFzb24gSSBtYWRlIHRoYXQgYQ0KPiBzZXBhcmF0ZSBmdW5jdGlvbi4NCg0KRXhhY3RseS4NCg==
