Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E45C67D8C38
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Oct 2023 01:31:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231655AbjJZXbv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 26 Oct 2023 19:31:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjJZXbu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 26 Oct 2023 19:31:50 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52C5E187;
        Thu, 26 Oct 2023 16:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698363108; x=1729899108;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=vFMmZBA+3ttLuM9LCcjFHQwzp+mBVBTaLX7LXSKEFuA=;
  b=M2qYPHgITIxVi+PlLFSQHVyN/iQgjyV/OTCAeOQ1lXhwz3Eqq4jURfz3
   UTud6/yV4HDzPXDqLi/RuwRqUC3mlkv09gpQ5MA/y7NyHSfTWO9zRzugS
   Q65PM/C6yGc3OjCwsIlQXDYNRwZOni4MI6Ja/jBtBuPAUl6YKoWL7VBAG
   Ey+v71JHZp6PCsilSxQtyQAo7qrFh1AeAXZ01HYp0C5xhp231NBhhhat3
   YypZaGuI+3jXDIwMXiTphwU4yo9rHY8+RBf5FU3sSLu2K8wP7hS9Wqmud
   BhX4blwkEDtGXpYznV6zywcSzDCvr1MYv0H4EsSs+V3Jk9EJrfb8DcFid
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10875"; a="386561293"
X-IronPort-AV: E=Sophos;i="6.03,254,1694761200"; 
   d="scan'208";a="386561293"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2023 16:31:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10875"; a="752923887"
X-IronPort-AV: E=Sophos;i="6.03,254,1694761200"; 
   d="scan'208";a="752923887"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Oct 2023 16:31:47 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 26 Oct 2023 16:31:46 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 26 Oct 2023 16:31:45 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Thu, 26 Oct 2023 16:31:45 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Thu, 26 Oct 2023 16:31:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RUPGj4y52/cWqAycNKjBnbLJREuZ0mUGhPwrpyTiVA7mSSZA//kFA5U4DjQjSR7f9ZpMvrZdTUgeBiy1DM6j7uyoUITDWpV5EMRFU8V4zLIkGX25kIsReRNiGH6lY5BP5K28x/OsFrceqUh0ywXstALCk4dAkhdRA/Lxj4w2NHPqfz0ZFclHLwcLH+apEMl1fho9x1U89P5uqvJXDCuohTQgZEfqxhCjd0rz5oDMjoBR48JetdSl+w5lQxb0ESkVaJ2sUry4UAJnjvx7kM7lDsodChpBLJjAeLhuJcUTYCHIaVt7KcpZhwMvZZXPC+A6/PQlhrCUVW46Su9R4+hbKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vFMmZBA+3ttLuM9LCcjFHQwzp+mBVBTaLX7LXSKEFuA=;
 b=ocqf402oyk41nMSyxsoJ2RqJ9khxyHVYE6OJ+DGOF/Gz9vYDD/SziC3DdxSOheca4p28DxzUg75neK2gN4CKh9siHvMX04DMelP/TqKQ9NAdpI7HvDg+WfXD0Coiwu4BQgO4+J5PspQOLHoVNvOnFJdEf3QaktR2YPEb6y+qP72NKvo5cEdYoW02ScavPjjIc17QVwdYMyboNaLTwTeFSTsHkIPRf0MrrlaiA1TNOkL+M07O6EJRVYsz+s3HkmA5bZwpFRZC447lJIve5REkhrneHFGSMtW/cLVedsq5lHmiZ7djyby8uZp/mH8Q6TO+76vcXtiuhlz6+6JHdVIb7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by SJ0PR11MB5597.namprd11.prod.outlook.com (2603:10b6:a03:300::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Thu, 26 Oct
 2023 23:31:03 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::4d44:dbfa:a7b4:b7c1]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::4d44:dbfa:a7b4:b7c1%4]) with mapi id 15.20.6907.028; Thu, 26 Oct 2023
 23:31:03 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "broonie@kernel.org" <broonie@kernel.org>
CC:     "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "Szabolcs.Nagy@arm.com" <Szabolcs.Nagy@arm.com>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "debug@rivosinc.com" <debug@rivosinc.com>,
        "mgorman@suse.de" <mgorman@suse.de>,
        "brauner@kernel.org" <brauner@kernel.org>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
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
Thread-Index: AQHaBbRTBvR+3Qu63E+MwFOmoT8P7rBXkZMAgAAhcgCABKBHAIAAC/yAgABeRgA=
Date:   Thu, 26 Oct 2023 23:31:03 +0000
Message-ID: <b211a1db25b634d9c4b8b956d22fc59d0c43bf8a.camel@intel.com>
References: <20231023-clone3-shadow-stack-v1-0-d867d0b5d4d0@kernel.org>
         <20231023-clone3-shadow-stack-v1-2-d867d0b5d4d0@kernel.org>
         <dc9a3dd544bbf859142c5582011a924b1c1bf6ed.camel@intel.com>
         <8b0c9332-ba56-4259-a71f-9789d28391f1@sirena.org.uk>
         <2ec0be71ade109873445a95f3f3c107711bb0943.camel@intel.com>
         <807a8142-7a8e-4563-9859-8e928156d7e5@sirena.org.uk>
In-Reply-To: <807a8142-7a8e-4563-9859-8e928156d7e5@sirena.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|SJ0PR11MB5597:EE_
x-ms-office365-filtering-correlation-id: 49e56dfc-a934-4e8f-d739-08dbd67b9eec
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iAsJ+vUSOdO3U7++Ysr4V9o3Anah46s4E7X/jwygdsyLVKiX+MxJHweXGCS8GD6jLEJ4xBSvDDMWm1njSD0y4dE9jPW8YvfogITWe+9sebkM6J3l74mmqKF6TGd1q4oRvGb8J8viKfHhamkygBs7JjNjlrFGGv7lNZcxel+Yy04k4G5uz4QFkdGm+KsB8hkxbHQib1r483EJ7rzGsno1ZpsJVKU93sAjOTo50Zdp+yNpCROMpMeJa23v0Kl1AbZdJNBG9GBerx96rApW/DxbckSCzrsb+ATs2lSqQkIvzo+Rj94/CddV6qZGTAob8iGbhbH0VzWh4dlOKP3uMZxlSxm6ol+GOmco7Cbx406PjBcORueiAmwA0PmTFgYXCKlUZoQ8dc24V0Lp0X+taRD6IIf8+8HsoIVX58gKzgtutKgxuWM0bEJX7hiKn4W3yar17Ja02gaIcaqgy9M17cRrlUsGwBaEcijyyclhPyGFKUnVzwPUCBSQKdlEmJl0wpep3vx2SD61+S8af33LZKaL1A+B9aYzqzcKYbAO+vnu99gkwg+sBqNELEBT4IBNlry+UZ26VpJrlZX1Ff8oMf3RLx8AziJmVerbQsn/GG2MRFbf2/y7RnwatQBbco5zH5J3
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(396003)(376002)(346002)(366004)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(76116006)(66446008)(558084003)(82960400001)(36756003)(71200400001)(26005)(6506007)(6512007)(38070700009)(86362001)(38100700002)(122000001)(2616005)(4326008)(6486002)(8936002)(41300700001)(8676002)(478600001)(5660300002)(4001150100001)(7416002)(2906002)(64756008)(66476007)(316002)(54906003)(6916009)(91956017)(66946007)(66556008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TzB1MC9BcEVxRjVOUzY2ZHlkVXlUNXc1V1grQjQ3ai8vWWZpQU40a1Bmejgv?=
 =?utf-8?B?NkIrVzlqa3hnaW5rbVV1R0x1YWJQN09KSk90Znk5MWVIYTNSVC9ZWlA3dE40?=
 =?utf-8?B?KytMN2JBWGhkbCtnSjNwOGhEdnlheWpxeGhiNGpFaTlSaERtUXZESXE4elVx?=
 =?utf-8?B?L3hsVDFMY21nTUpEdXhoaFVodFFuQ2d1K0t1Zk9tQUZ1VzFITkRKMUxnUC94?=
 =?utf-8?B?aGdrMUZJemIxeXhSaCtReVR5KzlDWXY2d2ZPTEhqTUZxSm8xUlZGZHAxUDFY?=
 =?utf-8?B?YVZuOFJUQXNmb1dpZzFRWkxoa05NMCttVVhWb2Frb01FYjZEOFhoSmVzN1NJ?=
 =?utf-8?B?S2NBY3cxQUxYcGFJdCtwWUVlbkh4M2pCd3RMYkxpWkN1Y1FpMFNMdWRIbnZu?=
 =?utf-8?B?UldyR1p5ZGd6K3FJY3JOczl5ZzlNMFRYcUIwaEhpdUFaSkozTkFOUUN1UWZt?=
 =?utf-8?B?VGt2ZGtBTUpyQzA2UDZ5SFEyazNQY25NdW84U1dQSUtyODFSZU56SjNPK3ZC?=
 =?utf-8?B?SDZkeDBFanpDOGxJUzRkcDlQTjhCamo0OG1xQzk2enQ3c1IwY2JYRzBWVVY2?=
 =?utf-8?B?czNVTENFUXAvZlMybG5LVVZHMy8rNXJ5VkVNTDFLaWxCeXBudUNlZ2VncnVT?=
 =?utf-8?B?UmdnamtUUmU5aURPQi9kOHBaQlAzZEJTY3lMZW5kdTVqNW1JaWVCdFRud0w0?=
 =?utf-8?B?VldNZ0dCZHR0SDJxd1EyVTJJaE5mWDYrYzgzNG5CbUEwSk41WGJDWm9HTFpn?=
 =?utf-8?B?V2ppRFpCTzg2Y1BFalhCWWR3QklldVJFVVBwbE5JdUd4ZzlmdnBVdG9XdWQz?=
 =?utf-8?B?K01tZmY5OXU4TlY4NGdwMlkzVXdTZDFwMitvZ0dYL2huNHZXMVJCbTh3TlVs?=
 =?utf-8?B?RmpnQ1gwTTJXUUwxeDVrVlJISC9RTExUQmpzMTg3Z0psZGJ6d0s5UXNsVVlj?=
 =?utf-8?B?Ujhja2cyT0dTYlNXM253eXExNUlMVEs2dDN0V0c0d081MGpNZll2UkxEOXJX?=
 =?utf-8?B?QW4zREJJMFlmVVR4bTRETVU4aU1wTmFPRzF1Y1VnaE1yQ25BenNjMDZDK01t?=
 =?utf-8?B?L1hldGlvQUcyUm12M0pybmE1eDVlQ0hsRElSbVNOL2tkdlh5a1JBQm9ZNTFx?=
 =?utf-8?B?VEZ0cXdMKzZwZnZQdVkrYUtHVDd6OEllRFo5N3plTmtMUklQMlpMdHBmcStk?=
 =?utf-8?B?NHZobXFZSSsvVGtYazR4cS9qZW91eFEzU3B4cFYrQTdUYjNXRm41TzFobkFC?=
 =?utf-8?B?K1RyTWRXcW1Eck5DOXJCbUhETHJWOUM3LzVhWS83dkpWYlhYbEF4VDR6VS9D?=
 =?utf-8?B?YW9HV0FTS3IzazNXRXV0VTdHc2NNKzhoZkdTUEFGU2s4Q3RvYy9XTElDZFVW?=
 =?utf-8?B?QUszOGNaOTdGUjAzTmRBY3Y4OHN3QUlGREFFaGQxNHc1SHM0NWlFUjdGWGdl?=
 =?utf-8?B?bXZseDcwMnVNV3hTN2ZYemNmckxyS1lOeXB0L2VNRHFvUU43dlNvZFNrZmpi?=
 =?utf-8?B?S0JqTVlzdG5MYVBPRWZkS1V2OUxtcVZaWjk2TEhhZi9jSE9RS1U5QVd3bUx3?=
 =?utf-8?B?MXBGekZoUHVUOURvVVB3VGJ3ayt0VnlLcVkwYW9rVXlnODVFTWpQUXJmemQx?=
 =?utf-8?B?STZ1ZHZPVVNmbTJmUFZpclNvSmFDaTJjbzVPMjNudkd5Ris5SHNDVHAzY29T?=
 =?utf-8?B?M3kxYXhVcERuaVV5RExwN3N5SnJkODYxM1pWQ0hjY2RMTTNhditGSHNFalRK?=
 =?utf-8?B?emZxQ2FIaUYxSVBSVTViazVlTDRDM3NKQWhIRC8rNXByd1JqL2xqbzJ1SXh4?=
 =?utf-8?B?aTBVNzk5d2EydVFkSEgzaFdvSUF3SWVYV0Zqbng0cUhITk5Pa29DOFVMMFpD?=
 =?utf-8?B?T0oxRTJHSUEvWk5DNDFRWEhKaFJlREhJa3Z6aTN5UVFxUjVFNUxiK2o1aHNE?=
 =?utf-8?B?a0dnRXp2N1dhbVRLU0dUVldrQnJ4bVgzSkt5cnJZMnVXdjNPZndnTGFHMks1?=
 =?utf-8?B?RG9OY3FLeXNVdjF6SldxRUE2RVRyQ0d4KzluUmV5NEU2Y285eHBQemwwdlQz?=
 =?utf-8?B?RzlrSHcvWkZDcWFEbG1PcTV1ZEhpQ1o1MVI2ZngxWGc5WnpwTGRYTUVFU29H?=
 =?utf-8?B?RFJFUEZEMjNZclRMbFJWUkJvbnhzdVdXU3VNRTFjSUsrek5Tand0SVVqbDRr?=
 =?utf-8?B?VUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BE8305114213774B934B40B62A6FD9E7@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49e56dfc-a934-4e8f-d739-08dbd67b9eec
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2023 23:31:03.8378
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cLsqTEpByA4L/cVurzDnXdewjG2NGYFDmmDg5fNy9ezxH8+udQpFyFk4dynGxxvCIByCsIVGF/zfiLyhcSLJyzOnMsCocrqRcslfFoAy6FM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5597
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

T24gVGh1LCAyMDIzLTEwLTI2IGF0IDE4OjUzICswMTAwLCBNYXJrIEJyb3duIHdyb3RlOg0KPiBQ
YXJ0aWN1bGFybHkgZ2l2ZW4gbXkgaW5hYmlsaXR5IHRvIHRlc3QgeDg2IEknbSBjZXJ0YWlubHkg
d2F5DQo+IG1vcmUgaGFwcHkgcHVzaGluZyB0aGlzIHNlcmllcyBmb3J3YXJkIGltcGxlbWVudGlu
ZyBzaXplIG9ubHkgdGhhbiBJDQo+IGFtDQo+IGRvaW5nIHRva2VuIHZhbGlkYXRpb24uDQoNCkkg
Y2FuIGhlbHAgd2l0aCB0ZXN0aW5nL2RldmVsb3BtZW50IG9uY2Ugd2UgZ2V0IHRoZSBwbGFuIHNl
dHRsZWQgb24uDQo=
