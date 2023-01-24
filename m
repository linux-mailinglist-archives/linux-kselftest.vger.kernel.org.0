Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18ED667A745
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Jan 2023 00:59:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232483AbjAXX7C (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 24 Jan 2023 18:59:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230201AbjAXX7B (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 24 Jan 2023 18:59:01 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A5AA23336;
        Tue, 24 Jan 2023 15:59:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674604740; x=1706140740;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=B8UtZz3nAsK7bnV7GT4r3e561m/QL382mfIfT/03Hlw=;
  b=B85YcLFIwLPDs+pZRdmxWkDftTY3EcKGvUcf8GOMfBEC4inOqtLukLNZ
   05sHURKKLpoO+CtkQJ6Mjhnypy0DcE/7XkkZFH99uqtX28yssoPmBKHXJ
   x3OperpulaA4dS556Y8vhCaeAdQE3vDFSAuujVyxz/PQeNyvIJJuyWavA
   DVZY4i3I9DGgTximXM+8mNQ66uUivDM7wLpbZ70f9MxNu6bdaL8wGYzcD
   oH4dTgG0fJ2/28BBR9H/BBvR4uuOXXlOwLFUwQz8k9kzFpnef+EnLv6P1
   9LdLoMLTfoYVvUhG3EKhoUdsmjhn9adGDJ5zYJlG9EstywnsHhOWLlBz4
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10600"; a="327698554"
X-IronPort-AV: E=Sophos;i="5.97,243,1669104000"; 
   d="scan'208";a="327698554"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2023 15:58:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10600"; a="655613248"
X-IronPort-AV: E=Sophos;i="5.97,243,1669104000"; 
   d="scan'208";a="655613248"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga007.jf.intel.com with ESMTP; 24 Jan 2023 15:58:59 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 24 Jan 2023 15:58:59 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 24 Jan 2023 15:58:58 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 24 Jan 2023 15:58:58 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.104)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 24 Jan 2023 15:58:56 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fD5weFZM2+KzYUnRC7NVDg/aBPBGA85yWAFSXhS2psTbrmDXEVOoxopl32GF2Me/4/ovVLT8M8Rsryhshc5Nl48JCzS7mveOn8Cvteh3cLVWJQ1xeIpu0elV95fPLfL4L/Cb6MG//BiNC5uxE6zS1FZGuQFvZD6eoTLAOSw4gd0vVOKN20teFtAvW9j+dMyYPIvvWE8FXau/plh3m+T/Qr9nnFDMn2klsmBLsQe0X9AmnqySqk4T8pomDXAN/Ybb0k7HKqrGgR8Anyw5xMxEQUvwxLtgsWwhJ2ptERhfLWNOlmyy70C/cdj1bv6SY07LJ6zPV/VjazmyPlKqRgIVDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B8UtZz3nAsK7bnV7GT4r3e561m/QL382mfIfT/03Hlw=;
 b=CYQcjuTNVWjemZVly0c8eWk23jXl2woX5P28TOvZge5rWTJM/U6Y5H4ZXItIzqB8Y+/eb+K+8b2oN5UvhRhJZAHOuDna3nGVpPul+DXtvWkz0bQSuqdr4d86a1s7uLeO2AkkPc0hdMwzJh+4u4fZG9ron0f9SCIl0lfy0vnRK5LcyRTJIU3qklqLvtmGeI08J8M1Mdj3BGewrfsiE5QemheXyaVndmCurUqfUpOucQSI+XiIvrdBvccdYMChcD7L+nV5oRMCL4k+qkRhNd+p37+UjaNe6uPcuhORd/YYT7ZD/Dj6sr7RYLDW0zI4BpuPwTgmRM6Jv+pmZD4uYitu1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA1PR11MB6734.namprd11.prod.outlook.com (2603:10b6:806:25d::22)
 by SJ2PR11MB7617.namprd11.prod.outlook.com (2603:10b6:a03:4cb::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Tue, 24 Jan
 2023 23:58:51 +0000
Received: from SA1PR11MB6734.namprd11.prod.outlook.com
 ([fe80::59d:4c93:47eb:9811]) by SA1PR11MB6734.namprd11.prod.outlook.com
 ([fe80::59d:4c93:47eb:9811%5]) with mapi id 15.20.6002.026; Tue, 24 Jan 2023
 23:58:51 +0000
From:   "Li, Xin3" <xin3.li@intel.com>
To:     "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        "H. Peter Anvin" <hpa@zytor.com>, x86 Mailing List <x86@kernel.org>
CC:     "Hansen, Dave" <dave.hansen@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Brian Gerst" <brgerst@gmail.com>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Shuah Khan <shuah@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Linux Kselftest Mailing List 
        <linux-kselftest@vger.kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>
Subject: RE: [RFC PATCH v3 0/2] selftests/x86: sysret_rip update for FRED
 system
Thread-Topic: [RFC PATCH v3 0/2] selftests/x86: sysret_rip update for FRED
 system
Thread-Index: AQHZL9wHXOCNBEx4pEaxwC77ioU9Ra6uFIBQgAAH1oCAAB7EYA==
Date:   Tue, 24 Jan 2023 23:58:51 +0000
Message-ID: <SA1PR11MB6734D8D63E5404E2F2C23203A8C99@SA1PR11MB6734.namprd11.prod.outlook.com>
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
 <e48a7629-f357-ed3c-9f43-b1499930ceff@citrix.com>
In-Reply-To: <e48a7629-f357-ed3c-9f43-b1499930ceff@citrix.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB6734:EE_|SJ2PR11MB7617:EE_
x-ms-office365-filtering-correlation-id: 18329cf6-f23f-49dc-6199-08dafe66f150
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hZK2ztgnUGxW/zgsnF40OO/k8Neo/i9qOVQPRJvwwAOfvdNP1UeceeV5SS5UW8T+O6PnBFXG7ENfqhYou/7/+IVMjuOMdTQ0qLk+S3FgHyFA8Yxu2gNrxZVUH4UqIBDu4jaeDJXJr6hnDETYepSq6ICuiZFNOKYHsLpPCRMYwxJrgUB3WOOw9OCYknshrwPNN9MTr/Dh3um5yGwbtMwnWxZTfM1ZjQremzfq4/kPFBXNkhFxf0vr+EWDk0PYEGS3oXguJQZTZFrzJhYDUJqIun/0OxMgqRhY35R8mUvcujrUwKfwyNuZ0/Tt7S8lbF5zW79lNOlHDY88L+brBh+KoHfNdzLOB/4av4p9+SHwYiVQfJumSV9SnYc0uvOWGGFEsiw4DE43SCng0B01SaWmYHMI0K+6GvDpaHn8qtFVW2eLSG9f69efxRZgqu0ndtw61dt/NyUK5lkbOvJsMoTL/Lflq/eibbXJBSPu74A1IbZQkcsS0Bc8dK+2EqBIF3bE378DrSyPJQhufzjpU43IRAQ4zTg2x6bpXHYo8UmItCFNQKbJpLSCX6NRFZ4jTZ++rNlYM/uzOqFZYq84lkgtUGuSnpk2LJ3hF+wfef/las3JcsIrgdi7p3JgPdXJiy98exrm5ilMSqh0ONWR2TQjsizRwaCka2bZ+w7TS4NZ4gui8NUcudJlcLa3vVq4ROGPKXKOUrhvIfOlZ5qCFdYjXA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6734.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(396003)(346002)(366004)(136003)(376002)(451199018)(38100700002)(33656002)(122000001)(26005)(82960400001)(5660300002)(41300700001)(4744005)(7696005)(7416002)(2906002)(86362001)(55016003)(4326008)(8936002)(52536014)(316002)(6506007)(8676002)(186003)(66476007)(54906003)(66556008)(478600001)(64756008)(66446008)(110136005)(9686003)(71200400001)(66946007)(76116006)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TE1STVZWeVAwZS8zNHpQM2tremRCR1k1ZkZ4aktZMkFyWWFyQ013cTRIdjJ6?=
 =?utf-8?B?N25lWUcxcEZYNkhTdW0rNC91ekduYVFFcG53SVA1eU54T0VudWs1UHIzTGxl?=
 =?utf-8?B?TmZ0bFZkNlhyVktVL2dSd3UrRTZmT1BOVWVtUURnRWYrU0dOSGpSdS9VNFVZ?=
 =?utf-8?B?UWNkSVpYcmpRWkF5SEx2QkQ2cmw3bWtFZ1JKZnRURk9rTmhFWGpnL1R0Y0JG?=
 =?utf-8?B?VXZBS0hUZE5OWFBUU01WMWlEb3NzcHA4d2pBb1pwS1FWakJyb0xDcFJWMlZi?=
 =?utf-8?B?UzVEOEpWeVErazg5Q3A4ZEI5U21lVHFFQXh3ODFqMkFTTUd1UmhseVhjU1VY?=
 =?utf-8?B?UWx3N213dnEvc0hhVkVNeTZoaUFwWEZhOHZ6aldnTUw2Z0pNekdRSXhlZVNn?=
 =?utf-8?B?bHQrV2VpTnJmaXRNOUNldmVJRXo0NTBUUFhjTlNmd254OUZmTmVOMW5Dbm1W?=
 =?utf-8?B?L2xYdnE4YmVQTmg0VHZNWnRzalRZV1lOUEdXaGNxalFXUm0wRTdSMis5a2FO?=
 =?utf-8?B?cWltdkkydVhvWkNJekJteVZJWXhzbHJWOXBuMEJ5QytvSE5kMlNrTFBzelBX?=
 =?utf-8?B?NTA3VDI1dWhuTFV2TUVLVUkxRWVhR3VEalh4QzRWejVINmVwVURFbThXaUVY?=
 =?utf-8?B?Q2h1a1RCT1d1S013UDR3cFQvd1V4Z1g2b2JYNFRHSE5yVGgvdDRmOVI3OHAr?=
 =?utf-8?B?dmVXcG85R0huMUFQZmxiT1k2bkFTV2dWMk9IaHJ5bmljclVxYUE4dVVteDBW?=
 =?utf-8?B?Q2wvaHpDajdxcXJldFNzL0Z6S2VLNVo5WndlUHVOSTEwRW4rdDhna0lCSmJV?=
 =?utf-8?B?aXhuWC9HRWczWkgrRnBuTWdpODFMekw2R3Evd1doSzhrWHVrSHRLUnNyVTNn?=
 =?utf-8?B?RHYzQVVOSk5paVk1OHF6V0I4K1U3Snd0aFN4bW9RQlAxZmdVeGt1YWFieHJw?=
 =?utf-8?B?SWJ3cTNlNktUR2Y0TlJPdzhsdzJIbGRPdzlZdVAyeHNkdVBZcld6RWV3cUJs?=
 =?utf-8?B?bnNxeDNvZUNOY2d6NUo3dVdPcmVicThRZ0JDSjBHQ1Y2dUJDM1c2ZGltUVlq?=
 =?utf-8?B?R09YNzNxOG50YlFKSmZTK1JYUmlWbXRVWFo3cEdaY2sxYlpxNUpTWG9SNGtG?=
 =?utf-8?B?LzYyTnlodGp4SC9ZeEw0S1ZzQTBoeW1LZkxiQWt3NTZNVEZrSGxNNXhIcjMv?=
 =?utf-8?B?bzJaTG9ZdTNXQlNVbTE3NC9aM0ZtQlZCdjVVTVNjNmtGYTdNSFZmbU9qMUwr?=
 =?utf-8?B?c0h1YnMrMk1RNmYvdmQ3LzVWRFNPR2I0WEpVUWN5THJyeE5QTERYbnZsbkxS?=
 =?utf-8?B?dFVIbi81RHJHZVZPN2FqbmU3WEN1TlZmbDdpVU8yaXZTejB3OVlReUhqdlda?=
 =?utf-8?B?cjZsSkJlb2N3eEFlVEx3aExOdEkvYXozbExQMjZDZ3MxRDZKOVdnckN0MDJq?=
 =?utf-8?B?bzgzL1h1VE03VXgvTXdSS3o3cllaUlVQYWg3MU9RbDVCRHJOOG1FZVRhS1Y2?=
 =?utf-8?B?Z2lRS0JKbGJpYlNnSnVtcThyekdLcGhndkRPdG14RHpEeGZJMnd1WXhwV012?=
 =?utf-8?B?WVNjalFmV0xxKytaek9pS20rRkpLVEtCcHh0RmlvT05HN25VZ2czTnQwWnZn?=
 =?utf-8?B?Yi9BZXp4WkhxM0hzTGx5K2p2MlQ3Vllabno3WlZiSkVWbitrWGhTeHNmNnow?=
 =?utf-8?B?UGFTWS8wRWtObmhSSW9JVXFaWnFKQmpQdXk5ZHo3cDhaTG1uQmhmdDc3bER2?=
 =?utf-8?B?L0RWQU5OellLUzNWNUN4LzBwOGdJK0lMeGhnU1h4dXprN0ZrTWduRmxZLzNP?=
 =?utf-8?B?azZBR2U3dWZrVkVYNjVaV1lwTzFabytRRUhGcWxodHAyWmV5OTdNZ2IvQU9t?=
 =?utf-8?B?WXFLTmZQUC82YzJCYWJ5R1NmN3RwbkhwaDBXclUxb0tSSWZQczZsa3BYYkxx?=
 =?utf-8?B?M3lVcVVvQ0pOb2NkQWZSTTYzUHRLb3U0TkF2a0hESUJVMEdNa3JHaExLMlov?=
 =?utf-8?B?V1lBY0Q1a3ZaTXg4YXQ2MjZvVzUvRFQxWGlOVkpuUnpvMS9HUmgvNjlRQlNy?=
 =?utf-8?B?WVZWb094c3VvMFVnNlk4OG9nQVlLYVBOSzlYb2xCUTU3V3hXYm04SjJvdzl6?=
 =?utf-8?Q?ifYDm9XukRT+NYuf4E+4w1W/a?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6734.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18329cf6-f23f-49dc-6199-08dafe66f150
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jan 2023 23:58:51.4886
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nHvX3qYo3GddVsisBRYQb9Jd/rzNpx60nz0JR9aMw2iroSZ8cjeCstKCyplKj0Qyjr1atBvk+gx41i7wKkQ7tw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7617
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

PiA+PiAgICAgICAgIGFzc2VydChjdHgtPnVjX21jb250ZXh0LmdyZWdzW1JFR19FRkxdID09DQo+
ID4+ICAgICAgICAgICAgICAgIGN0eC0+dWNfbWNvbnRleHQuZ3JlZ3NbUkVHX1IxMV0pOw0KPiA+
IE9uIEZSRUQgc3lzdGVtcywgZmxhZ3MgaXMgMHgyMDBhOTMgYW5kIHIxMSBpcyAweGZlZWRmYWNl
ZGVhZGJlZWYgaGVyZS4NCj4gDQo+IElzIHRoaXMgdW5kZXIgU0lNSUNTLCBvciBlbHNld2hlcmU/
wqAgSXQncyBkb3VibHkgd2VpcmQgdGhhdCBmbGFncy8lcjExIG1hdGNoLCBidXQNCj4gJXJpcC8l
cmN4IGRvbid0Lg0KDQpUaGlzIGlzIG9uIEludGVsIFNpbWljcywgd2l0aCBGUkVEIGVuYWJsZWQu
DQoNCkZsYWdzIGFuZCAlcjExIGRvbuKAmXQgbWF0Y2ggb24gRlJFRCwgYW5kICVyaXAgYW5kICVy
Y3ggYWxzbyBkb24ndCBtYXRjaC4NCg0KSSB0aGluayBpdCdzIGV4cGVjdGVkLg0KDQpYaW4NCg==
