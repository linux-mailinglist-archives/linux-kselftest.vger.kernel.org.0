Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 269EB501B26
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Apr 2022 20:36:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344696AbiDNSiU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 14 Apr 2022 14:38:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344694AbiDNSiT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 14 Apr 2022 14:38:19 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0823CC9B40;
        Thu, 14 Apr 2022 11:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649961354; x=1681497354;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=PVk+YPF/aH0IpgDqRROyNyo7TwVQj/NOr+gvUAjnlqA=;
  b=KQqSpK6VdPfSPmD1kL87pJA42zdprpSszh7pZLQUoc7kuqX/6tH7KxDb
   6lRJB69sHfmJEe9QRODEpYEgPkKkv3/rC+XohJbK5iLpSYPdy+0MuDXVD
   5sEGGE2oclw8ygILztLsHZjxIHa8tR/ggvrRnHIoXPwPoGI/WwkIC8H35
   nRSPrvkQpNP5nnR5lgR1y861UMZb7gXesgBTMTLXfiEtCFR5YlHVmYfCZ
   uLvdcE0NPfOp4ivLjjnx8xPcSzPjmFlNA8Ia+en+itq7PcZJtA52bk9HN
   m2nyCWCLfNCtyvnhSWL1pnCUAMdjRTE2yF10I23UR+UNeNXJGIIXWBEQB
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10317"; a="323448621"
X-IronPort-AV: E=Sophos;i="5.90,260,1643702400"; 
   d="scan'208";a="323448621"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2022 11:35:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,260,1643702400"; 
   d="scan'208";a="573935454"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
  by orsmga008.jf.intel.com with ESMTP; 14 Apr 2022 11:35:53 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 14 Apr 2022 11:35:52 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 14 Apr 2022 11:35:52 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Thu, 14 Apr 2022 11:35:52 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.105)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Thu, 14 Apr 2022 11:35:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Miv/EB/QBc3CSd5S0RYx4xuHboQ2DH47bs3NNCZ2+UCEkIH5VROCAoZu0QgvC8hxXnYnBRv+BKrIhht1A4PH5/qThA9CV585SnNQeDgG7IayPhjqKXincYWj3/ix8VXUn1uOoyUYPCwAvsikgZR7V3mj4wne4xNpELeN4DQ9GflhLYqkwRs8pdbDP5nxrljU+5guDeJ0te1fimkwZVP1viqGJDUaAeeeH96V40wz/vnS5A2NKxIPahJtMqOd+utPFe18ZPwaJZVVS+1oP8yQWhnS0aANzu3wX7JrB5EpqJUFpA9tCAM5/VqcQLWQZF89wlKApWARfxzTSgNyuTL6GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PVk+YPF/aH0IpgDqRROyNyo7TwVQj/NOr+gvUAjnlqA=;
 b=SJsQaWxOAFQN2Kk7irQpagwTITGlcjQ8MiWqaoUaElGdWMOPdJ5wqYSRFo6KAJV6F8++kMfL93Sae1Mkt3/zCexmzD8soWCu9a4za/ENMkFzKC8X4H60CDqpxpRG27ZMYygU8PI9kXsvwfQxsH4JD6yOoInlU3F8DqF/LzjYCL9r9qBv5Rwvp5vJWFUaxld7JTvVgVNSnKQreM5bc4nh2Lgb9r8wDUhQhrZ3fZ21cC6WdeZXGi36EZfcQbKq0E0Mkodnga2qCm0kjXqP7a2z4qRZ+PWTDk20vkRV9/WgMXIxpSnBOPRa8R1jb1oaYkFQhGoI/aHJI1H081SQwzNBVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5591.namprd11.prod.outlook.com (2603:10b6:8:38::23) by
 DM5PR11MB1627.namprd11.prod.outlook.com (2603:10b6:4:a::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5144.29; Thu, 14 Apr 2022 18:35:50 +0000
Received: from DM8PR11MB5591.namprd11.prod.outlook.com
 ([fe80::14a4:94fa:fcb7:3089]) by DM8PR11MB5591.namprd11.prod.outlook.com
 ([fe80::14a4:94fa:fcb7:3089%6]) with mapi id 15.20.5164.020; Thu, 14 Apr 2022
 18:35:50 +0000
From:   "Dhanraj, Vijay" <vijay.dhanraj@intel.com>
To:     Jarkko Sakkinen <jarkko@kernel.org>,
        "Chatre, Reinette" <reinette.chatre@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "bp@alien8.de" <bp@alien8.de>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
CC:     "Christopherson,, Sean" <seanjc@google.com>,
        "Huang, Kai" <kai.huang@intel.com>,
        "Zhang, Cathy" <cathy.zhang@intel.com>,
        "Xing, Cedric" <cedric.xing@intel.com>,
        "Huang, Haitao" <haitao.huang@intel.com>,
        "Shanahan, Mark" <mark.shanahan@intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH V4 00/31] x86/sgx and selftests/sgx: Support SGX2
Thread-Topic: [PATCH V4 00/31] x86/sgx and selftests/sgx: Support SGX2
Thread-Index: AQHYT3rxs23shhvg+k2Ofp5Co3ZiHKzvRb4AgABWSQCAAAX2AIAAGVGQ
Date:   Thu, 14 Apr 2022 18:35:50 +0000
Message-ID: <DM8PR11MB5591BBA189BC4EA5CFE2C7EAF6EF9@DM8PR11MB5591.namprd11.prod.outlook.com>
References: <cover.1649878359.git.reinette.chatre@intel.com>
         <2f4338f37943c2b067db16ae65c9af665d3b51d9.camel@kernel.org>
         <9fbf26c8-5808-20c5-8653-d4f36bf398a4@intel.com>
 <42a52a6018e8dadb4c3eebefaae4dab31c0d5721.camel@kernel.org>
In-Reply-To: <42a52a6018e8dadb4c3eebefaae4dab31c0d5721.camel@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.6.401.20
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 97e90572-f8f3-4dfb-53f8-08da1e459978
x-ms-traffictypediagnostic: DM5PR11MB1627:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <DM5PR11MB162747C0443532E5789030B6F6EF9@DM5PR11MB1627.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IZWSwdigDhdCpY6UvXnIVvgwuymMak0A/5xfWTacO8lE2E9qPxtU4bMivLTYZ2OPBAgqTX4RzsjwIJHDxMvm6XB7regpNaEfNr2Nr09yowRijhwjtx4cifq8SRZbP1L1Ad7CUfkc46F+daG7Ck87AeA2xL/T4eYephZ83Zr6CQwvsxgk9zRP3lY0K/GRe85i7BnIiLVdWAlUGOcdf3km4o6aBG68F/fccXL3pbScDHe0W1q2DBVIFQUwN5e8RfptwCkUob0iFGKJNuVk17NUwW4HGOtexcoNZchP9XbT4n0Zl0w89zvmUFrJ2R+pvR5mId/S5aAS5PJA5pTWysTDKbC61K8M6ttV+zNncfb2JzOx8B2zIn+1S8oq/4nfln2kQzv1ZZUDFiKhBnWxgvQjym6wCTmREz61CmPSliz52jE5vOkRBrZqn4x6HPT5etv0cNB30N3fUZHC9WcJLIM06hI1vvOrKKkbIS3UnkYfN5pShI0H//n4EWy2UAF5pDSf1BhmGqxopJV05sDezX770tzbyRVbUqh7SF6WXOLvsrfnU7mSt1Hhu24RxZ+rb/7AJ+LQmhPZ9NJRBeIXSfTMmNKyvOvUOpiWQuaP+Hfg7Fj/tQBZNZxQ5xAVBx1XK6o8VSWRaFlLKwMg6XJZCBPXze7/o5Fi3fEwt9j8XSq12IiKzKyk0QqybBn++oE740C/7zxTiZGm9DEe9uD2Fq8INTNAdw8I3c0DNAHvcXeuzi4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5591.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(54906003)(110136005)(8676002)(64756008)(66446008)(5660300002)(186003)(7416002)(86362001)(33656002)(316002)(71200400001)(26005)(83380400001)(508600001)(55016003)(2906002)(66556008)(53546011)(122000001)(9686003)(7696005)(8936002)(6506007)(38100700002)(4326008)(52536014)(82960400001)(38070700005)(76116006)(921005)(66946007)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q0Q1ck96cEtEVGxPTU9jZ0VQT0FDVkNHTTZhWlNGQlBUUTFJVmN3alBTMzJH?=
 =?utf-8?B?OHhSZ0ttQ01CQ216V0lRMW1aMGZTUEhHV25RaHlHdWRiQW14R1MrVHVVTVZH?=
 =?utf-8?B?MWlYVlFCRUJscjd5WXU1UXhXdU0wS0RTUGh5bURMOGUyZkdGSDdEbEJ2Q2FZ?=
 =?utf-8?B?anFSSmpVSVlDeFowc0xhWHd0V1JYWFkzMnpqYTRnU0JHZWs4d0p0ZnF4cnQy?=
 =?utf-8?B?Y0k5bDNDT09QMEZoaXYrY0M4ZCsrV3BQNlc2cy91K1Ywc2NXdnY4eGRzVWox?=
 =?utf-8?B?Q1Z6VTVCNk91Vm0wSXJqVDR5M1JnOEtuVHdWeWNpTGpyYXgybGZQKzBvaFM3?=
 =?utf-8?B?d3dweXpxWW8wMWlVblR3TGozTitLcUZlb0VVejZCSklCYTVkQTM5dDMvTE5u?=
 =?utf-8?B?VFdJWm9XWXlNajJzWVUraU9oRndEVURZd0lmOEhhYWlCbDlQTHRnNVljTHl2?=
 =?utf-8?B?c2l4cmp3eGRsNXRaYXRGVjMwbFdsUG1naG4vOFh4alN5MkZhRUlIL1k0ZVEr?=
 =?utf-8?B?Zk5UanFnSE91MW5VTzZzYTh1MGRleWRTRm1TbHNhUHRyN1p2UmF0ajBvYURZ?=
 =?utf-8?B?QS93NWg5ZFd5dWwwMFVPZ2NlMnljWklBY3pmWlJ0dzNMalhpdzYwNTlOMEdK?=
 =?utf-8?B?My81M2drSkg3R2hld1NlMUMvUHpGZVk3L3B6Y3ZSSDlzcG5TYjI1SCtmamlG?=
 =?utf-8?B?UEk3T0tEc3pDQlBnZ2RwTG5Cc3IzRDZZSkJ6QnRKSGhMM21rMVhxaU5WMmQr?=
 =?utf-8?B?M2xDVi8xVVgxb0E3dFhsM3Z6eFYwOEwvbUtIeGRKRTh5ODNiVmlyczI4d1d2?=
 =?utf-8?B?aFo3K2xoN0dUcGNjQWtoMUtwc050MEZUVmhtdGlwMmtqRXllRTlRUW5uQUNu?=
 =?utf-8?B?QmFEampERHFmYUNXQmtCb2NRZjRJaTNueW5BVHdLYndtU1RaU2hrMDdKaElR?=
 =?utf-8?B?NVBCM3ZwM2pkNGpyT0dva3ZvN05qbUJGOUJwTENvOEJvK3hSMUV2TE9vYWlH?=
 =?utf-8?B?Sld2UHNOblhHb3NTUFBvbktXT0tidjh6NFRLai9MU3dzMlZ3a0FNRkJDME9V?=
 =?utf-8?B?NVNyVy9UcGhZL05WcGJtaW5MR0FkY1RSTlE2YzY5MGs3R0Z6RXFQb20yMVds?=
 =?utf-8?B?WjRITklmeW5vb1N5SGNHVzIxWDgxUWhhWVUzSXQxRDA2ZXBaV05GUWl1V25K?=
 =?utf-8?B?VklJSXJMZEJOUC9aTWZ1cEhBUHRBdmt5d1RyWDl5blhPSUNrMEpIcmVOSHgx?=
 =?utf-8?B?b1R6WS9wSzUybzJaRjI4T2ZZYTE0L3RkVDhiMkZLc3RBNFdJQVpmNlIrL1Z3?=
 =?utf-8?B?MnBnbFRJUC9zOTFkZmNWd0NTOTd1QTV1QXZ6WnFpSzd4Mk9CWEM1QytWUnpu?=
 =?utf-8?B?cmwzOVlQcDU5NjRYZWpnY0tJSHpNcXluVzl1OHk1NFUzQm45T09pNU5uUDFP?=
 =?utf-8?B?SWdoN01wUWVxdHI0eklWUzRpTmliU29rMy9VMG9lTjZQSE5IZ2hRRmUyd2U1?=
 =?utf-8?B?aHhhR3pqWU9YaFJnRHBXVDVQaSthdjhNajhEYmhyRnc5WDRTcmJBbWdkYlJZ?=
 =?utf-8?B?R3ZDd3VYenVKWG5ZZ0JRNm4wQ3YxS01PMnFCQmVMVlMrVVI0UXd3RkMxYjhE?=
 =?utf-8?B?OE9HR3ppL1lycmljaVJiblhqRXdBOW02MjV5dXZsUXBrZ095YlJXeDdNUWJE?=
 =?utf-8?B?aFMzcDU4bGxCTE1oM0NiNzgxakVETVZRUkZLZ3h6QzJvNHp4RjAxZ3dOc3Bl?=
 =?utf-8?B?TFI1MndhWUJnb05qWGdnRmM1ZWs3aGw2aUg2THFFaWFZODVBTExQV2RzM0RI?=
 =?utf-8?B?U3krSGVqQjVCN1FUMDZ1ZjRSNlFjd1ErUTZFdXhTd1J1SGcwMk9JY21qQnRk?=
 =?utf-8?B?OE1ua25WTUJaWEZwOG1VZ29tdW5wOVBtTEVGeStGRmxWUkE1U3haNjdURlNv?=
 =?utf-8?B?NUpnQXBDK05NRklZc1ZJRUZoREVtYzlJeS9KeWxuYzlZWDBDN3oxOG5NL2s1?=
 =?utf-8?B?MkJCSEltNVhxRHdoZGU1YUNMcThXR3FUVjdZRGtuZFJIZVR1S3lvZklKSGVS?=
 =?utf-8?B?RGFDeUNoeUh6dEN4dVJMSFR4MkJ5eWQ2SmYwU2c0akt6RTVUbUtBc2hiTzRy?=
 =?utf-8?B?dkZHeGY4WkxoeVFxdjE1U0lXTmZwSGlHdm1FRHc5MFNHNlBkVlpQWkZhclBC?=
 =?utf-8?B?OW91UTN3bXlSMXA3a0tnNVgwbnl4U21pemFuYitzWFFwZFhiUloxQnlIaUNN?=
 =?utf-8?B?VWtqZHJhLzd4QThIcDF1Ty9USDl2TDh0Qjg3WkhWemtVa1FTeEdubFBMSUdC?=
 =?utf-8?B?MXNPQVp3MmM2TTVlUzU4UzhvUnM1UjlXbldzdXB4SGdoaVVuc1JDUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5591.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97e90572-f8f3-4dfb-53f8-08da1e459978
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2022 18:35:50.1473
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xcpKGZR02udsG2nzzyot9ZSjm2nLUYqE2UFz+wgbhelgeiYauWL9eu74eTJkZFXtwlf1t02UkAx1i8LxEvHkPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1627
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

SGkgSmFya2tvLA0KDQpJIGFtIHdvcmtpbmcgb24gZW5hYmxpbmcgR3JhbWluZSB3aXRoIHRoaXMg
RURNTSBwYXRjaCBzZXJpZXMuIEkgaGFkIHRlc3RlZCB3aXRoIFYyIHBhdGNoIHNlcmllcyBhbmQg
aXQgbG9va2VkIGZpbmUuIFdpbGwgZXZhbHVhdGUgR3JhbWluZSB3aXRoIFY0IHBhdGNoIHNlcmll
cyBhbmQgcG9zdCBteSB1cGRhdGVzIGluIGEgY291cGxlIG9mIGRheXMuDQoNClJlZ2FyZHMsDQot
VmlqYXkNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBKYXJra28gU2Fr
a2luZW4gPGphcmtrb0BrZXJuZWwub3JnPg0KPiBTZW50OiBUaHVyc2RheSwgQXByaWwgMTQsIDIw
MjIgOTo1NiBBTQ0KPiBUbzogQ2hhdHJlLCBSZWluZXR0ZSA8cmVpbmV0dGUuY2hhdHJlQGludGVs
LmNvbT47DQo+IGRhdmUuaGFuc2VuQGxpbnV4LmludGVsLmNvbTsgdGdseEBsaW51dHJvbml4LmRl
OyBicEBhbGllbjguZGU7IEx1dG9taXJza2ksDQo+IEFuZHkgPGx1dG9Aa2VybmVsLm9yZz47IG1p
bmdvQHJlZGhhdC5jb207IGxpbnV4LXNneEB2Z2VyLmtlcm5lbC5vcmc7DQo+IHg4NkBrZXJuZWwu
b3JnOyBzaHVhaEBrZXJuZWwub3JnOyBsaW51eC1rc2VsZnRlc3RAdmdlci5rZXJuZWwub3JnDQo+
IENjOiBDaHJpc3RvcGhlcnNvbiwsIFNlYW4gPHNlYW5qY0Bnb29nbGUuY29tPjsgSHVhbmcsIEth
aQ0KPiA8a2FpLmh1YW5nQGludGVsLmNvbT47IFpoYW5nLCBDYXRoeSA8Y2F0aHkuemhhbmdAaW50
ZWwuY29tPjsgWGluZywNCj4gQ2VkcmljIDxjZWRyaWMueGluZ0BpbnRlbC5jb20+OyBIdWFuZywg
SGFpdGFvIDxoYWl0YW8uaHVhbmdAaW50ZWwuY29tPjsNCj4gU2hhbmFoYW4sIE1hcmsgPG1hcmsu
c2hhbmFoYW5AaW50ZWwuY29tPjsgRGhhbnJhaiwgVmlqYXkNCj4gPHZpamF5LmRoYW5yYWpAaW50
ZWwuY29tPjsgaHBhQHp5dG9yLmNvbTsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBT
dWJqZWN0OiBSZTogW1BBVENIIFY0IDAwLzMxXSB4ODYvc2d4IGFuZCBzZWxmdGVzdHMvc2d4OiBT
dXBwb3J0IFNHWDINCj4gDQo+IE9uIFRodSwgMjAyMi0wNC0xNCBhdCAwOTozNCAtMDcwMCwgUmVp
bmV0dGUgQ2hhdHJlIHdyb3RlOg0KPiA+IEhpIEphcmtrbywNCj4gPg0KPiA+IE9uIDQvMTQvMjAy
MiA0OjI1IEFNLCBKYXJra28gU2Fra2luZW4gd3JvdGU6DQo+ID4gPiBPbiBXZWQsIDIwMjItMDQt
MTMgYXQgMTQ6MTAgLTA3MDAsIFJlaW5ldHRlIENoYXRyZSB3cm90ZToNCj4gPiA+IElNSE8sIHdl
IGNhbiBwdWxsIHRoaXMgYWZ0ZXIgKzEgdmVyc2lvbi4gSSB0aGluayBJIGhhZCBvbmx5IG9uZSBu
aXQNCj4gPiA+IChvbmUgY2hhcmFjdGVyIHRvIGEgc3RydWN0IG5hbWUgaXQgd2FzKSwgYW5kIEkn
dmUgYmVlbiB0ZXN0aW5nIHRoaXMNCj4gPiA+IHNlcmllcyAqZXh0ZW5zaXZlbHkqIHdpdGggcmVh
bC13b3JsZCBjb2RlICh3YXNtIHJ1bi10aW1lIHRoYXQgd2UgYXJlDQo+ID4gPiBkZXZlbG9waW5n
KSwgc28gSSdtIGNvbmZpZGVudCB0aGF0wqAgaXQgaXMgKmdvb2QgZW5vdWdoKi4NCj4gPg0KPiA+
IFRoYW5rIHlvdSB2ZXJ5IG11Y2guIEkgYW0gYXdhcmUgb2Ygb3RoZXIgdGVhbXMgc3VjY2Vzc2Z1
bGx5IGJ1aWxkaW5nDQo+ID4gb24gYW5kIHRlc3RpbmcgdGhpcyB3b3JrLiBJIGRvIGhvcGUgdGhh
dCB0aGV5IGNvdWxkIGFsc28gcHJvdmlkZSBhbg0KPiA+IGFjayB0byBoZWxwIGluY3JlYXNlIHRo
ZSBjb25maWRlbmNlIGluIHRoaXMgd29yay4NCj4gPg0KPiA+ID4NCj4gPiA+IFJlaW5ldHRlLCBm
b3IgdGhlIEVNT0RUIHBhdGNoLCBhcyBsb25nIGFzIHlvdSBmaXggdGhlIHN0cnVjdCBuYW1lDQo+
ID4gPiB5b3UgY2FuIGFkZCBteSByZXZpZXdlZC1ieSBhbmQgYWxzbyB0ZXN0ZWQtYnkgdG8gdGhh
dCBwYXRjaCBiZWZvcmUNCj4gPiA+IHlvdSBzZW5kIGl0ISBJdCdzIHNvIG5hcnJvdyBjaGFuZ2Uu
DQo+ID4NCj4gPiBUaGFuayB5b3UuIEkgd2lsbCBtYWtlIHRoZSBzdHJ1Y3QgbmFtZSBjaGFuZ2Ug
YW5kIGFsc28gcGxhbiB0byBtYWtlDQo+ID4gdGhlIHNhbWUgY2hhbmdlIHRvIHRoZSBmdW5jdGlv
biBuYW1lcyBpbiB0aGF0IHBhdGNoIHRvIGVuc3VyZSB0aGF0DQo+ID4gZXZlcnl0aGluZyBpcyBj
b25zaXN0ZW50IGluIHRoYXQgcmVnYXJkLg0KPiANCj4gSSB0aGluayBnZXR0aW5nIGFjayBmcm9t
IGFueW9uZSB3b3JraW5nIEdyYXBoZW5lLVNHWCB3b3VsZCBicmluZyBhIGdyZWF0DQo+IGNvdmVy
YWdlIG9mIGRpZmZlcmVudCB1c2UgY2FzZXMuIEl0J3MgZGlmZmVyZW50IHNhbWUgb2YgRW5hcngg
aW4gdGhlIHNlbnNlIHRoYXQNCj4gYm90aCBjYW4gcnVuIGFyYml0cmFyeSBhcHBsaWNhdG9ucyB3
cml0dGVuIGUuZy4gd2l0aCBDKysgYWx0aG91Z2ggYXBwcm9hY2hlcw0KPiBhcmUgb24gb3Bwb3Np
dGUgc2lkZXMuDQo+IA0KPiA+IFJlaW5ldHRlDQo+IA0KPiBCUjsgSmFya2tvDQo=
