Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DB837408AC
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Jun 2023 04:47:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231296AbjF1Crp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 27 Jun 2023 22:47:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231285AbjF1Crh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 27 Jun 2023 22:47:37 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 451EE296D;
        Tue, 27 Jun 2023 19:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687920456; x=1719456456;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=RU2jmMYZczAFzBdG/hFukIJ0VGVpX1bXrx2wpim07Vo=;
  b=S93USjxcUYf8jVjh75whqa+siHVYCsPNFdmeRytcQ/G11yl4q9Bz0LUR
   X+q9HjccbD13BRlQntfz4yuFv3tJfEyWpJ6aZZSuq9bsFnfWTXC2Cr0hE
   8Sxku99zsS2bFkpQZeYT1EPH/HJ9pnZamULULmSU7qu+5QDFVi6VrNlZq
   iuqnKAcqYFstbpOKjdawhA8bbQSjLB38rykgxinHuGLhjmRZc2NKzwlAH
   a+mNMeRfgEoNq6LDsATXMqdDPTmX8cVXV29paaO8HN/H+QKcsl7YAycT1
   tw8+7xs+tFnPNI8iOK3ITciMU9sV9Rlgpn8BmLs5zZXRj5+iT4qT5p8el
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10754"; a="425404814"
X-IronPort-AV: E=Sophos;i="6.01,164,1684825200"; 
   d="scan'208";a="425404814"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2023 19:47:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10754"; a="752044833"
X-IronPort-AV: E=Sophos;i="6.01,164,1684825200"; 
   d="scan'208";a="752044833"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga001.jf.intel.com with ESMTP; 27 Jun 2023 19:47:35 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 27 Jun 2023 19:47:35 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 27 Jun 2023 19:47:34 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 27 Jun 2023 19:47:34 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.174)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 27 Jun 2023 19:47:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VYbpQA1sMqGBdtJ9OT+A8s+Y57JPImwkaT1McgjdmKLI6WtC6iu5+9gwxr4yip/K8MQSkXuXGvA3heVeaUmdBiC03jtSBlCaPzgJtxeU2pZTtUbeTyOTgsIi4dipzZcXHp6EFiR2ikRqwAAOxw8GkMQDAgv/GOdf1TRGlSuR7zOLazWeY5Lir83JxoGrx+ZQ8BNY83m2s4VhBI4sPuxi/5+5AhbZ4H/P95U8Sscav7eRP5to3kMVuKL0NMpXhnBMkMNS4IW+3eOyM166W+VaOrtxpN2402Uw5AqnmpuWVCnW36eWbgaGVf8nU2PKEsezv/pw59oIHgaKdngli8eJvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RU2jmMYZczAFzBdG/hFukIJ0VGVpX1bXrx2wpim07Vo=;
 b=ZpQK0E/c4wAW5snJuQkLzWlGfnM9u8H/cRhwkyLinXmcSymSuZW4ti+Pa5bs8WkN6VmBr08wfPmJvdBa13MM4Jg9usfCAkqCKsoWMtnV+WHNbxwQupRJU8T0UGlBXd6OWdtVpC6WWxxBFGD187NWDZJy4lOfsVlH1Ia48x0PcxPei6wmBmiwQEnHws26S/6g8NK2xUvOPhzfllwXUHJQHepunwdo5ZGcx2ufSO2E6n/cFTTAwQJa9vzyjvGqG5RdPejFABkUWI+tE+Zccm5B0vuye+sh1mVr4LStXsDctBqJgH/E5fmcmRfMFcUnLqAhJKFXQWjWxdYCFAhwOlGK1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by SJ2PR11MB8403.namprd11.prod.outlook.com (2603:10b6:a03:53c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.27; Wed, 28 Jun
 2023 02:47:30 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::19b7:466f:32ac:b764]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::19b7:466f:32ac:b764%3]) with mapi id 15.20.6521.026; Wed, 28 Jun 2023
 02:47:29 +0000
From:   "Huang, Kai" <kai.huang@intel.com>
To:     "corbet@lwn.net" <corbet@lwn.net>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>
CC:     "Aktas, Erdem" <erdemaktas@google.com>,
        "Du, Fan" <fan.du@intel.com>, "Luck, Tony" <tony.luck@intel.com>,
        "dionnaglaze@google.com" <dionnaglaze@google.com>,
        "qinkun@apache.org" <qinkun@apache.org>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "atishp@rivosinc.com" <atishp@rivosinc.com>,
        "wander@redhat.com" <wander@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "chongc@google.com" <chongc@google.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "brijesh.singh@amd.com" <brijesh.singh@amd.com>,
        "Yu, Guorui" <guorui.yu@linux.alibaba.com>
Subject: Re: [PATCH v3 3/3] selftests/tdx: Test GetQuote TDX attestation
 feature
Thread-Topic: [PATCH v3 3/3] selftests/tdx: Test GetQuote TDX attestation
 feature
Thread-Index: AQHZhjUev+9U/9vzEkKqwBILfHYrRq+HtK4AgBGCl4CABpIPAA==
Date:   Wed, 28 Jun 2023 02:47:29 +0000
Message-ID: <eef5f3146d041c47864647351242fc06453c5aa4.camel@intel.com>
References: <cover.1684048511.git.sathyanarayanan.kuppuswamy@linux.intel.com>
         <972e1d5c5ec53e2757fb17a586558c5385e987dd.1684048511.git.sathyanarayanan.kuppuswamy@linux.intel.com>
         <64876bf6c30e2_1433ac29415@dwillia2-xfh.jf.intel.com.notmuch>
         <64961c3baf8ce_142af829436@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <64961c3baf8ce_142af829436@dwillia2-xfh.jf.intel.com.notmuch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.2 (3.48.2-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|SJ2PR11MB8403:EE_
x-ms-office365-filtering-correlation-id: 8257c202-06b9-446c-f7a8-08db7782039d
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nsXb6DCdR5dLlRrG0RAyhoucEPFExqBrjh3fT6Y7/8kFnyHeLz57S2ftxMpXZ2wcF0nenl4D5cM9MnZygndN0wTztzv/tOeL7VxgI/pM9ZE0+icXJzrjXiGdZvhKrbX8Ms9zFQtCugg8Ist22RvzpzcA1hSfbcoZIbFi64luTsSgvUQOnvI5zx/sd8LEfr/Bbv1Kh8YcE8sUg1ZQ0wtkK5qHykLLVwljmyo2+mhJ9yZFLC2k0ldBaZZu8iV99qyMQmjg1rZsFVruHFXGPHjjPrXCl0NIIuOgppvb8p10cKRnTAFX40nr9rRHTULOKppFVO+HWcJP8oEFmBspB9CFkxrofBBV+0EpcgxwCKYz8kTX1b7SqUKJg/yiX41HbnHF3rGAbEG5Q39OAJbQaPVoRTT04JM1W2LZIrTVbn7nrMxELGP50R/BfQ9ng+H2+kCne7iy5T0dVb/90nDi34A+e8uOok2zM7O2aq44R2WJNtftCimWxew18JL6xIbin2cnRQjeeHPYnIaP58FwJfyn03UW47Po9V9V//ElcUBd6/4xLsi9yJEl5cZ9DJU5kHGpoJQlyE0OXpQ4FL+ymeikMFetrj/40zDAVmrHxJBoM2Xr3FRBeP9wZTvr7K9wNpMY0KXPcblYKYrqtmvO0hTrs4QtxigTkni16RtOqm1KIIQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(136003)(376002)(39860400002)(366004)(396003)(451199021)(6486002)(91956017)(110136005)(478600001)(54906003)(71200400001)(76116006)(83380400001)(2616005)(38070700005)(86362001)(2906002)(66946007)(6512007)(186003)(41300700001)(36756003)(6506007)(26005)(38100700002)(921005)(122000001)(82960400001)(4326008)(64756008)(316002)(5660300002)(8936002)(66446008)(66556008)(66476007)(7416002)(8676002)(505234007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OWdRTkY2WlE3R0VjSnJEK0JadjBST1l4b1k5cG15SmlFK3owbnlzR1hIRVh2?=
 =?utf-8?B?Q0xOdk9MdjlHelNlUVd6Tk1ZTklVRU50WXEyRHJvZE41aVI1MmMvdFNiQVBy?=
 =?utf-8?B?MVdnVUhaUUZUYWJjQkUvZHhKTXViN2RLWFQzcDZRN0RpT3FyYTc5RCtHR3Nm?=
 =?utf-8?B?U3hBcGtoUW5ucithMG93TjFBZWFJRjNXRXFTUlhjSnFrYTBhZ2VJLytYNkNP?=
 =?utf-8?B?c0Iydy9tcE9GRkJaNU9DTGU4ZVpxR21qWHBFZkhTbnpOS0QvTjJ1eDVIcU96?=
 =?utf-8?B?SGMrVVRTUVltbjF6NUM1UnJXeWhES2E1YXpYenQvd0ZKVEIxUFkyenZRZHRH?=
 =?utf-8?B?NzlJeVNFVi9LdzBBZnd2RzhXN290cUUwbmtLUk81VWRQc2p2WW9tN3VubTk4?=
 =?utf-8?B?NkF6SmowYm8rTGtjakhCY2RBdmo3RVkyblFpM1pFbllEa2RoYUZacDBwMHhP?=
 =?utf-8?B?NWN3S2hIYllGR3RZTUhUTHEwNFdqM25wdkl5UjkzSzdHOVJxQVVoaUlPZENZ?=
 =?utf-8?B?aWxjSTAzd0d1TEJqZ2hDM3RtU2VWU3V0Q21XeTBuY0hwYUlOUkpmSk12amZY?=
 =?utf-8?B?WTlPcWk2aytNWWVBNXpxK2FkUjRxNXYzWHRMS0kvbmk3aHhFQnlhcVJZbnlu?=
 =?utf-8?B?MHVUbGcwVnVZTllPdXEzb1N6UXdFK0FNQUFBMFlBRVBXaFd3Mmc2am5FQ2Fk?=
 =?utf-8?B?dnUzU0djSkM3NW9tR0w0bk05YU9DQklTR3hFdk0rdTJhdUt5RUVhQ2ZNTUw4?=
 =?utf-8?B?M25uK3V5eU9EYTUya2s5a05zRVRxY09EdUg2RVF2UHFsWUR3S2hUR3Yxb0E2?=
 =?utf-8?B?RkxxVEpObG0xTG1MWC9YNGZwSVZsSnE5OWFMc2Y5S1B6L1NEdEQrVzFNUjY4?=
 =?utf-8?B?cVNUdXNmOTBzdHR1QlR6WHdLeUREM3NsK2dRNVNwR2dMSXQ1UHV3TUpDQUZB?=
 =?utf-8?B?NDZjbWJ0dVhacytQenRnMFlMcmNlSUUwVWZTVVpCSEk4TUIwVEJmek9EbmNq?=
 =?utf-8?B?RmIwdC9HTEovbTJMVmFXeitxcmR4VFFNWFZpV0NqazZhY0EvQXBNMGt4N3Fa?=
 =?utf-8?B?cWlmVHV6RytzeWNrbElvTEJlMzFYckIrVStTOHNyK0VWWWVOZkRhY0NGcWxw?=
 =?utf-8?B?cnJmTlI4VFVKUGMxN3hLS09paEUrRzkyMmY5YW1XVmtnR3lxY0paWTZDNHE3?=
 =?utf-8?B?bkFEa2pvMFNQYm8rdFdzbW9JUk9pZlIwN1ZZOXBnVW41T2l0WExLTzJVL1o1?=
 =?utf-8?B?L0IwWlhvRXByVHNaZ00xdjNDMXQ4OTdvSzJiM2g3MGpIVzh4bS94ZE92K1lG?=
 =?utf-8?B?SEgxaTJTTmxGWCtnLzdLRmdRR2hqa1djVkNTTnZGSGNOMDd2MlA3SGs4SVla?=
 =?utf-8?B?SEg3U1JMQzNZZTgxZUV6d042Qzd2UWpxQ0VrVXlYcjhmZ0xkUjNmYzg0a29X?=
 =?utf-8?B?eFZOQXlmaXN1UUVtbVcwdlQ4bUxoak8wWDc3U3ZVSDBMNjZKY3BJWFcxMDFk?=
 =?utf-8?B?dVhFcDBlQ0N5WlRWUjhORHhtZFZicXNQTWRlUGp3dTNzMWNDN3dlVVRLRkNz?=
 =?utf-8?B?NkVGOEJkaGJzREg2UjBSTm10UHcydEthVzNTZWFPTWRxQklSUU1Ec0FQUTgz?=
 =?utf-8?B?RmRMaXJzZE82UXZ1UzJEQmJva0hIS2F1NlR1UXNQMmV6TUNMd01BMnRHTWQv?=
 =?utf-8?B?ZW4xTkdxaDFuUmRTZTFyNnRjTXFFVVlzV1dGQllSQjBLbGNDM2VZWEZpeWdx?=
 =?utf-8?B?b1BtY0RwYWZGZmRicW4ydjRLWE5Ra1lEK2piSHNubEhLOFNiNjl2MFFrcjhi?=
 =?utf-8?B?Q2IvZ245OUw0NVBrWVhDSHNtdEg4YkRrWG9BN1A0VHdDNVJVUTBuNjhFeE1w?=
 =?utf-8?B?LzhiL3p2QW9ja2duY3M4R3pFYitsalpZUkR2ZWVVcGxOVzFnUzQvSmlEVzJu?=
 =?utf-8?B?anpBQkJ3eFcyNDlVbm5JWGFCSk9LaXF4QnpraGN3VTk5aXpBWldOSWxXM3Q3?=
 =?utf-8?B?bTlMMHpKQVR0UkU1aHNpblNDWThzS1dKWVlUU0szN2U3amtQcVhiWEtvOWhk?=
 =?utf-8?B?S0U1RzRpS2pzZ3ZHZkw2Z29qb29vTEVlNzVTcHJrWFJRMmpWSEovQUJZdW1v?=
 =?utf-8?B?TXcrUFRKY0U1SmNESlJEaEZMSGdtditUQzYzZkp4azVzV011Q1AzYzZEYWta?=
 =?utf-8?B?b2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0CB1F370AADE7843995B5745B90A1AB9@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8257c202-06b9-446c-f7a8-08db7782039d
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2023 02:47:29.2582
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /e88jE46uf/U95FUFR0tbLtZdwqPuaUuqklZ3f6J7gkbNTDEM6R352mqsX0rZ8l+EXjYqEGCZ+aE9BPPh9agqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8403
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

T24gRnJpLCAyMDIzLTA2LTIzIGF0IDE1OjI3IC0wNzAwLCBEYW4gV2lsbGlhbXMgd3JvdGU6DQo+
IEFuIGV4YW1wbGUsIHRvIHNob3cgd2hhdCB0aGUgc3RyYXdtYW4gcGF0Y2ggYmVsb3cgZW5hYmxl
czogKHJlcV9rZXkgaXMNCj4gdGhlIHNhbXBsZSBwcm9ncmFtIGZyb20gIm1hbiAyIHJlcXVlc3Rf
a2V5IikNCj4gDQo+ICMgLi9yZXFfa2V5IGd1ZXN0X2F0dGVzdCBndWVzdF9hdHRlc3Q6MDowLSRk
ZXNjICQoY2F0IHVzZXJfZGF0YSB8IGJhc2U2NCkNCj4gS2V5IElEIGlzIDEwZTJmM2E3DQo+ICMg
a2V5Y3RsIHBpcGUgMHgxMGUyZjNhNyB8IGhleGR1bXAgLUMNCj4gMDAwMDAwMDDCoCA1NCA0NCA1
OCAyMCA0NyA2NSA2ZSA2NcKgIDcyIDYxIDc0IDY1IDY0IDIwIDUxIDc1wqAgfFREWCBHZW5lcmF0
ZWQgUXV8DQo+IDAwMDAwMDEwwqAgNmYgNzQgNjUgMDAgMDAgMDAgMDAgMDDCoCAwMCAwMCAwMCAw
MCAwMCAwMCAwMCAwMMKgIHxvdGUuLi4uLi4uLi4uLi4ufA0KPiAwMDAwMDAyMMKgIDAwIDAwIDAw
IDAwIDAwIDAwIDAwIDAwwqAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDDCoCB8Li4uLi4uLi4uLi4u
Li4uLnwNCj4gKg0KPiAwMDAwNDAwMA0KPiANCj4gVGhpcyBpcyB0aGUga2VybmVsIGluc3RhbnRp
YXRpbmcgYSBURFggUXVvdGUgd2l0aG91dCB0aGUgVERSRVBPUlQNCj4gaW1wbGVtZW50YXRpb24g
ZGV0YWlsIGV2ZXIgbGVhdmluZyB0aGUga2VybmVsLiANCg0KVGhlcmUgbWlnaHQgYmUgb25lIHNt
YWxsIGlzc3VlIGhlcmUuICBUaGUgZ2VuZXJhdGVkIFF1b3RlIGhhcyBhIHVzZXJzcGFjZQ0KcHJv
dmlkZWQgJ3U2NCBSRVBPUlREQVRBJyAod2hpY2ggb3JpZ2luYWxseSBjb21lcyBmcm9tIHVzZXJz
cGFjZSB3aGVuIGdlbmVyYXRpbmcNCnRoZSBURFJFUE9SVCkgd2hpY2ggaXMgc3VwcG9zZWQgdG8g
YmUgdXNlZCBieSB0aGUgYXR0ZXN0YXRpb24gc2VydmljZSB0bw0KdW5pcXVlbHkgaWRlbnRpZnkg
dGhpcyBRdW90ZSB0byBtaXRpZ2F0ZSBzb21lIHNvcnQgb2YgcmVwbHktYXR0YWNrLiAgRm9yDQpp
bnN0YW5jZSwgdGhlIFJFUE9SVERBVEEgY291bGQgYmUgYSBwZXItVExTLXNlc3Npb24gZGF0YSBw
cm92aWRlZCBieSB0aGUNCmF0dGVzdGF0aW9uIHNlcnZpY2UuDQoNCkkgZG9uJ3Qga25vdyB3aGV0
aGVyIG90aGVyIGFyY2hzIGhhdmUgc2ltaWxhciB0aGluZyBpbiB0aGVpciBRdW90ZS1saWtlIGJs
b2IsDQpidXQgSSBiZWxpZXZlIHRoaXMgaW4gZ2VuZXJhbCBpcyBhIHJlYXNvbmFibGUgdGhpbmcu
DQoNCklJVUMsIG9uZSBwcm9ibGVtIG9mIHVzaW5nIGFib3ZlIHJlcXVlc3Rfa2V5KCkgdG8gZ2Vu
ZXJhdGUgdGhlIFF1b3RlIGlzDQpwb3RlbnRpYWxseSBvdGhlciB1c2Vyc3BhY2UgcHJvY2Vzc2Vz
IGFyZSBhYmxlIHRvIHNlZSB0aGlzLCB3aGlsZSBJIGJlbGlldmUgdGhpcw0KUkVQT1JUREFUQSBp
cyBvbmx5IHN1cHBvc2VkIHRvIGJlIHZpc2libGUgYnkgdGhlIGFwcGxpY2F0aW9uIHdoaWNoIGlz
DQpyZXNwb25zaWJsZSBmb3IgdGFsa2luZyB0byB0aGUgYXR0ZXN0YXRpb24gc2VydmljZS4gwqAN
Cg0KSSBhbSBub3Qgc3VyZSB3aGV0aGVyIHRoaXMgaXMgYSByaXNrLCBidXQgdXNpbmcgSU9DVEwo
KSBzaG91bGQgYmUgYWJsZSB0byBhdm9pZA0KdGhpcyByaXNrLg0K
