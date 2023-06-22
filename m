Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1C0673AD4D
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Jun 2023 01:45:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230060AbjFVXpB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 22 Jun 2023 19:45:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231803AbjFVXpA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 22 Jun 2023 19:45:00 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A94D2121;
        Thu, 22 Jun 2023 16:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687477499; x=1719013499;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=T/uhrUov68dm8MLte/ny1H4YpCy2A9s695ZMyAXYe5U=;
  b=de2EJZmk07/5VKHisUwWx3o9/0dRtdlVr/sqlm2wIsIGT26KLyzvEVbr
   IUqiwaphphSkf7ZBE2VxYfZB6qyqZSWYz55Sub3Xfylov6HHBZsBvP22y
   eejo73aIXXjvk5X586Z6Uo268mH4xsL6pySFrfpvtnkQptN3Av21Iz5d1
   3wZzNsob1nZYNlmazUXhC+eHijZJdbb7KXmR64ehq9Ih2W9AXkYTDcwu3
   IyImZq4rORYI3WQwRZNMGpDYMTktHga55svzEI2hPIsbK4vJ0OmhpdF1K
   BU17DCp+gwB1OHUaVY9C+yZfbGJT7tjsljnjV7tr/CccOyalEvUkwM6xU
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10749"; a="390515207"
X-IronPort-AV: E=Sophos;i="6.01,150,1684825200"; 
   d="scan'208";a="390515207"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2023 16:44:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10749"; a="889270561"
X-IronPort-AV: E=Sophos;i="6.01,150,1684825200"; 
   d="scan'208";a="889270561"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga005.jf.intel.com with ESMTP; 22 Jun 2023 16:44:57 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 22 Jun 2023 16:44:57 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 22 Jun 2023 16:44:56 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 22 Jun 2023 16:44:56 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.174)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 22 Jun 2023 16:44:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nOckiI8GfuMCBVxYQR4tU6iH5Weu3p8cyYft8K+LfUCK0cb8ohV+cEhyczW3kGHOoDttYHVLBqPbY8Ik15wf0sqvmtynAk055nJXvFqBfWJAkX6LY4KR9FKV6Jmqc77eYhYGDkoaxdWZr5Qkup2VbXdFUGH7UOItxJQCOFRKjUdBrm6/9/2NW3+xDoQfQQc2LDROsKN44nd5QHKQnSz/mWUsczm4GZYLaPFX6m42JIo8cH3rNvOwOyb54habdNEbvO7MmIVhgV5AmgNSowJDLymT3xCJzxN1oY+cWBT+4OyTaP2S6aiMWwBEgJmjiX2vBK7LI9BAwGrnaonY042eaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T/uhrUov68dm8MLte/ny1H4YpCy2A9s695ZMyAXYe5U=;
 b=eDLrRTdnUCkrEqyXXtvCs9cw5Exxk43Z862WnbHXEfuQhnSumFW8kq+uDiYZBKoVh23fd2fjo8NH8zU4Zm2Ug2W/cVsQG8I/SEfwo4sRUcQo5SmZkU9i9oerWBefBBRfGSsQWlWa1/PqNo5mGgc2TrLgziyUSj0PuaOT6Igy+KPVwEBjnbZpBHZWjOwbcoxlKfcS29qLyS6RTUdXQXuPWk4XNdhZrgHq2hRYsUmf9rjMDg/VtW8FygYkbKPzUP+v4vbOUbBatVQcB640Z5o8Kd3imHXG3Cs9ntyTEdyR9kJ1uy6heg3ry4jEnPTDCVKCrEuv1ii4pw+FTmlOSQA+4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by SJ2PR11MB7426.namprd11.prod.outlook.com (2603:10b6:a03:4c4::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.27; Thu, 22 Jun
 2023 23:44:54 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::19b7:466f:32ac:b764]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::19b7:466f:32ac:b764%3]) with mapi id 15.20.6521.026; Thu, 22 Jun 2023
 23:44:54 +0000
From:   "Huang, Kai" <kai.huang@intel.com>
To:     "Williams, Dan J" <dan.j.williams@intel.com>,
        "Aktas, Erdem" <erdemaktas@google.com>
CC:     "corbet@lwn.net" <corbet@lwn.net>, "Du, Fan" <fan.du@intel.com>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "Luck, Tony" <tony.luck@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "brijesh.singh@amd.com" <brijesh.singh@amd.com>,
        "dionnaglaze@google.com" <dionnaglaze@google.com>,
        "qinkun@apache.org" <qinkun@apache.org>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "wander@redhat.com" <wander@redhat.com>,
        "atishp@rivosinc.com" <atishp@rivosinc.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "chongc@google.com" <chongc@google.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "Yu, Guorui" <guorui.yu@linux.alibaba.com>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v3 3/3] selftests/tdx: Test GetQuote TDX attestation
 feature
Thread-Topic: [PATCH v3 3/3] selftests/tdx: Test GetQuote TDX attestation
 feature
Thread-Index: AQHZhjUev+9U/9vzEkKqwBILfHYrRq+HtK4AgBACT4CAAAOsAA==
Date:   Thu, 22 Jun 2023 23:44:54 +0000
Message-ID: <b99d329e5a28a06dfb947270b8a9032cc6960f83.camel@intel.com>
References: <cover.1684048511.git.sathyanarayanan.kuppuswamy@linux.intel.com>
         <972e1d5c5ec53e2757fb17a586558c5385e987dd.1684048511.git.sathyanarayanan.kuppuswamy@linux.intel.com>
         <64876bf6c30e2_1433ac29415@dwillia2-xfh.jf.intel.com.notmuch>
         <CAAYXXYzOUQC0G7yoh1i2+SW-FodCABwhD6TgArLf28iG=i65zw@mail.gmail.com>
In-Reply-To: <CAAYXXYzOUQC0G7yoh1i2+SW-FodCABwhD6TgArLf28iG=i65zw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.2 (3.48.2-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|SJ2PR11MB7426:EE_
x-ms-office365-filtering-correlation-id: 6a12e23e-05a9-4b5f-d6ad-08db737aae12
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oxLnqSldV3QNfmwwjqrp7Qz6829D0VTLXEYzxmWak5AeGZlWih7/IwMmyKvDtpu6BLK0PsZJalnFQ/ud4lcnRz9lEZWmJLgszNdWoXbF/n2oQLTYRXas2hi0gnt05J9o1TRlWsnGri5IFdruir0iCfUvFvIhurVjvQaKWaMOscnVkP6smA/QM/mYIBlzwwppFKArIMWFMWCzUEPPGnUUHu9vX7D8q/73SyUXX2XhiFNi8Cbm6Q07isQi05ZfDcsagIZAk4TpZBOBLgwGdZMR9N0eO9UAsRZIoyLBxfFB4xKdHFjiTgbZvj24jhJ2ZjnBhw9SN8ayAs+mlpo3lF+llYRZpcR31cwUAceGh8tMjDAubc6Iutiemx1pkxCLtY+ySFJPU2CbS1Or1tIqXgLLTTekUqs/AlbL3Z4/aWJmcskGuvMwjSf2LOoQWpKQA1DLog2JX7A9Rmetdg9APVIjTtIop6nB49Ne7DnEQ+LnYdqkvsvWMNGFswElR0/ewzUDihje21i8f/UvQJNkph0UM4g3Oy5tdoBis5t2oscFwzDwumprT+3Er3XVStk6sU/daNjflvk/Y4p+IeICHJqsJY7+BqaSGXJ2WQpTWqN7rKQE96r0YE1cRvLC4tM4Z/L2
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(396003)(136003)(346002)(39860400002)(376002)(451199021)(4326008)(316002)(91956017)(76116006)(66476007)(66946007)(66446008)(64756008)(66556008)(186003)(6506007)(6512007)(122000001)(86362001)(82960400001)(2616005)(38100700002)(83380400001)(36756003)(110136005)(478600001)(6486002)(26005)(54906003)(8936002)(2906002)(5660300002)(38070700005)(4744005)(7416002)(8676002)(71200400001)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N3c1Wm5pZFEwbkpuLzdJbHVndHJCUHVUbmRiZW1HVTYwSWxOZ3N0TU1vRmhx?=
 =?utf-8?B?alhJelpiL3hwdmpjTmc0MHppbDRCcEpMY0RvaXpuNjVzb3VhbGFNRU5IY1JX?=
 =?utf-8?B?V29BQ3ZOWE9YOFVnLzhWQkxTa0tCM1hlZUJhRkhMT1U5eCtjYzQ5YVBHK1BL?=
 =?utf-8?B?UHBhREt6UjhYaHV1Q1hTMjQ3ODB1Z1AxRHM5R1VOL1VlY3ZwSlVRTU9kdVJS?=
 =?utf-8?B?bWRzcHZ0QmFISzZ5U2ZRRG1JeVhMemJGTGg4WTZ4d296QmpFYU1nRUJPdDND?=
 =?utf-8?B?RVc1VXNGdE5tYXBFTm1xZlZHMHJvTTZ1Z3Q3aXBSbUtEczVCL1ZOSlppTTJv?=
 =?utf-8?B?ZUNBMzhUWHlEbmp4eno5YkhxaUthVHlqTUZnNmQ1NDdLRXlxcUxwMDZiYXVK?=
 =?utf-8?B?WEw4QWdJM3FPcmIzSSttVExWUkdSM01NNlNid0ZwL3g3LzNUYlJGdUNIM09Y?=
 =?utf-8?B?UVY0c1NsU2F5TDFKa2hhNFBURE5rYzB1cldhK2plVXRhRVRraG1XMGF0V2JR?=
 =?utf-8?B?Ump2T09PeU55bWE0UTVXYitDb29sNzFGQUpIdnBvL01xRER0SGV4WUtjcGMr?=
 =?utf-8?B?akYvbUdETE81aURmZno0Z2hnWHBnNUJ4K3BLU0VleGx6cXFGM0E4M0RUOGhs?=
 =?utf-8?B?cDBNTExTTk4wblp5eUV6elZKU0E1aDMycCtTMDgzbmZja1crYXBsTzJkRm56?=
 =?utf-8?B?MFo5VmRnTjZqT3phZ2s1N0VNNFIrdnd4cWtSOTVjVVdQcUtSczJMbnVNL3ZF?=
 =?utf-8?B?YWl5V3pJZ0xDZE5FOUZ6ODVQZVNEUEFGM0t2bFg3WDFvZEFQN09OblR6VkxB?=
 =?utf-8?B?cGJZMmVubG1zaitqTkZpYlN0dFduUy8weVd3NUdIcG8yWk1CdURaZHIxZzNJ?=
 =?utf-8?B?UllORzZBUlFZTVNmcnhiNytFc2RtcHhFV1AzZHBkZ3pzalNlcTBCYTZ1Ylhw?=
 =?utf-8?B?UFFORCs4UXdGU3c0SDVOMjh4ZTRrMkZrQXh5VmVBUk1lU1U4T1dUQkdxQUxC?=
 =?utf-8?B?R0hRT3Q4V1JtR0dwSytNOUpSQWlXbXErNXJqcVFMZTNZY2E1M0JOZHgvVjJ1?=
 =?utf-8?B?SGNyekZlZHV0YzdNd2loTkZ0bUJqS0RIRGY1eHZYTjFYN0l2TWlYUUM0YkZj?=
 =?utf-8?B?UzJaTEpzTnZGSk90WVYwZmNmd3NYQlo5WWZjeVN4TDRtVDlrbkpJU25QQ0pO?=
 =?utf-8?B?TVZwNE5qL1Q5U1NXNzdCU0d2V2dLM3Q2bi9oa292YVQ1aG1LNUpVL3VmTkc1?=
 =?utf-8?B?SzZSQ0VHSGQ1S1pxVHJaSEpmM0lOVzJTNVRyVGlESjVVamIrN1RLT2F2clZM?=
 =?utf-8?B?QzRWMmdGNWUxT2hpZ20venUwMTFzN0duQkc1czNzREFqSHRTQXFYaGtBU3hH?=
 =?utf-8?B?Z3c1eU9KWE4rTkVXclYxTE5ubVhiSUdwdDRwa3ZHb2wraHljWmRGNEppNSs4?=
 =?utf-8?B?eVFCUzZrVGJ2TU00cFUwVTZpRFpkR00yckRBbzlDZDZvd2xRRWNjZjU2WnA0?=
 =?utf-8?B?VklQNU9qYm5sdDNkSHZKRGh1RVhySVpVTG1abEFRdzRVRVdIZlJtSEFLSVl2?=
 =?utf-8?B?VzdsT0xoMmE3Ynd1c2VjSjN6UEJNQmZOMzE2UlAzWTJLMm9KTzZWMnZaVDFJ?=
 =?utf-8?B?U3Z1YWdacG04OEQ0RFpDaGZNNzZ6ZUhSbnpOKzBscjgwN2RzY1oxZE0zcWZU?=
 =?utf-8?B?RkZJQU0wUUk4SWV2azB2YUNyK0NDQ1orck9FK240VVIzbWl6dkl5VVFRNGRL?=
 =?utf-8?B?cHkzN253cUgwY3FlWXFtVmlpMjJaaUpEVURsNGp2VVg4Z29reXpESWt6eUZ2?=
 =?utf-8?B?MDlNb1ZpN1BBLy95WXZMUU5MUk1GTGJxNDh1a0NPUGJDeFhvK3EzSDhaZTFy?=
 =?utf-8?B?OTR2aHBXV1BOUnY3S3VkT1I5ZGxRWFhiMHVJdHR0MkN1RFpzWjFVWlJvWjdy?=
 =?utf-8?B?eGtkTnNKb3krczBTSFVkSXpFQlFHMDBKbWpUc0lid0xYWnR2eEtjRkFpSmJD?=
 =?utf-8?B?bEFvblAvTTBZWHVsdXk0Rjg5ekovMGlyeHZQaEYyamhWaUFndzRuclNsbUVp?=
 =?utf-8?B?V2h1bzVnTFpOV1hSMzBsYUJwY1ZWTTFGWFg3emV5K0VMK01DUGY5WnZ3c1lF?=
 =?utf-8?B?aW1KMUdodUZiUVBNQmoybWNQSkVmVDNSdzJ6Q3JkQU9FWnpvNzgyS0NUWlc2?=
 =?utf-8?B?Unc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3EF453E381A87B4AA9E4D439BFED5DC8@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a12e23e-05a9-4b5f-d6ad-08db737aae12
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jun 2023 23:44:54.6246
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0c+AcKXEu83nm6U0MSEF1pPsPWhRIEhvGYU/UGvYXeub25DI6tB4T8RrFfYt+0E5RBsm1c3mEGhOZ1SGV1DRYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7426
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

T24gVGh1LCAyMDIzLTA2LTIyIGF0IDE2OjMxIC0wNzAwLCBFcmRlbSBBa3RhcyB3cm90ZToNCj4g
U28gd2hpbGUgSSBsaWtlIHRoZSBzdWdnZXN0ZWQgZGlyZWN0aW9uLCBJIGFtIG5vdCBzdXJlIGhv
dyBtdWNoIGl0IGlzDQo+IHBvc3NpYmxlIHRvIGNvbWUgdXAgd2l0aCBhIGNvbW1vbiBBQkkgZXZl
biB3aXRoIGp1c3Qgb25seSBmb3IgMg0KPiB2ZW5kb3JzIChBTUQgYW5kIEludGVsKSB3aXRob3V0
IGRvaW5nIHNwZWMgY2hhbmdlcyB3aGljaCBpcyBhIG11bHRpDQo+IHllYXIgZWZmb3J0IGltaG8u
DQoNCkkgZG9uJ3Qgd2FudCB0byBpbnRlcnZlbmUgdGhlIGRpc2N1c3Npb24gYXJvdW5kIHdoZXRo
ZXIgdGhpcyBkaXJlY3Rpb24gaXMNCmNvcnJlY3Qgb3Igbm90LCBob3dldmVyIEkgd2FudCB0byBz
YXkgcmVxdWVzdF9rZXkoKSBtYXkgbm90IGJlIHRoZSByaWdodCBwbGFjZQ0KdG8gZml0IFF1b3Rl
IChvciByZW1vdGUgdmVyaWZpYWJsZSBkYXRhIGJsb2IgaW4gZ2VuZXJhbCBmb3IgYXR0ZXN0YXRp
b24pLg0KDQo+IHJlcXVlc3Rfa2V5KGNvY29fcXVvdGUsICJkZXNjcmlwdGlvbiIsICI8dXVlbmNv
ZGVkIHRkcmVwb3J0PiIpDQoNCkFsdGhvdWdoIGJvdGgga2V5IGFuZCBRdW90ZSBhcmUgZGF0YSBi
bG9iIGluIHNvbWUgd2F5LCBRdW90ZSBjZXJ0YWlubHkgaXMgbm90IGENCmtleSBidXQgaGF2ZSBt
dWNoIG1vcmUgaW5mb3JtYXRpb24uICBUaGUgbWFuIHBhZ2Ugb2YgcmVxdWVzdF9rZXkoKSBzZWVt
cyB0bw0Kc3VnZ2VzdCBpdCdzIGp1c3QgZm9yIGtleToNCg0KICAgICAgIHJlcXVlc3Rfa2V5IC0g
cmVxdWVzdCBhIGtleSBmcm9tIHRoZSBrZXJuZWwncyBrZXkgbWFuYWdlbWVudA0KICAgICAgIGZh
Y2lsaXR5DQoNClNvIElNSE8gdXNpbmcgcmVxdWVzdF9rZXkoKSB0byBmaXQgUXVvdGUgbWF5IGNh
dXNlIGJpZ2dlciBjb25mdXNpb24uDQoNCg0K
