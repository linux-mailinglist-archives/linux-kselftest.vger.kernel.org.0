Return-Path: <linux-kselftest+bounces-114-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A2F07EBA22
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Nov 2023 00:12:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ECF01B20A7F
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Nov 2023 23:12:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9EF72A1DF;
	Tue, 14 Nov 2023 23:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T4lR6K+F"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3774526AC0;
	Tue, 14 Nov 2023 23:12:21 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9FE3DD;
	Tue, 14 Nov 2023 15:12:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700003540; x=1731539540;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=faqs6CXh6qtCHZaggzzMlh6JpHrBHe5aqQxT0jgTvwE=;
  b=T4lR6K+FRCTxdpIDxvmeQvV+Q8rYiuNw3DIzmu+f/9hTZiKhCeq2r+Vf
   /EiDTKYGcn3uoJH2U8c5z62dduhtKuPcjMO2wuafn1pD0Jus7718MPyFE
   6T7vd1PkOiAV0UPu2y2tvj5a2N2exES6+9oyojiyirPM3hBokhyPos1Ux
   mOaXfkBb+V4pkR8fBakAc7qMf86EnpmGd7pNi63LrWHz57F755/k77oP6
   9/xB9euq5Rf9a9XUB/Ygf1NNc9lfzWNdaJk12g4H1rODxbleN7LC6wNzz
   5wBHtD/fQb5pnVeO/LKwcte8EHENSxmJXuul8daaxz7vYdc75kyIQi/7z
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="12309445"
X-IronPort-AV: E=Sophos;i="6.03,303,1694761200"; 
   d="scan'208";a="12309445"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2023 15:12:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,303,1694761200"; 
   d="scan'208";a="12586937"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Nov 2023 15:12:07 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 14 Nov 2023 15:12:06 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 14 Nov 2023 15:12:06 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Tue, 14 Nov 2023 15:12:06 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Tue, 14 Nov 2023 15:12:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YREZV7tWW2+WSlcBn1CDY6XmoMVzcjVYKfE7hFvZlLbcFWwGSAx5V0Gki1F5rbnlu5B6myfFIk60W98heUePFwxbI5Osfl9JVhw5fOBAgcvNBnEjxUHF0K/YYq8Wx/md6aJCPhlMBPgZ9HkoexLiUQOkfI4zCrifdiDABT0H5F5NeAfOmOed1odMxjZWwuWoR6N3Eu5mCO3xi8hADVyzYizhwkWBW5l1mGiBok0+U4xhNvOYNTRTs6974G7G8CO57AbtCaMUtgvDuwfS+9SMH5UnAR9WR7hmVdrJ8evoHlP/HtobcitMepSm7URC2hMhPP9YRJdg/CKh3A310r2B6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=faqs6CXh6qtCHZaggzzMlh6JpHrBHe5aqQxT0jgTvwE=;
 b=WYVY7R6uI5z1LE0ScP+pc5U36E3Hbwc49JAvSbOc0Ru2KqJZXf243y8/oq1G1TlAZZHqTNJLa7CMuElhgTIB7gV2xdKbRY625/Fbl/tk07XqEQy2TfNWP7vzURW3cBcsQp/mn0cdV5CojzcU7thT9absIvczchI1BnC6hGzLo5AzPlPmY4YAokNTBeAWHm+Lucd8GHPhMptpu2Onckxi2cuh13lUVBw15dMhx6gSTpqM4eCOzNqer+rOJoIJALnRa97p8qgW0vDkQgflKW2YjTXNKblzfMjYRQKGfKKm2fep5Dq4bzkjFESg6f3q4uaUn4Zrim0u6ldSPoKLHztAbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by PH7PR11MB7429.namprd11.prod.outlook.com (2603:10b6:510:270::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.29; Tue, 14 Nov
 2023 23:11:58 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::5260:13db:a6e:35e9]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::5260:13db:a6e:35e9%6]) with mapi id 15.20.7002.015; Tue, 14 Nov 2023
 23:11:58 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
	"broonie@kernel.org" <broonie@kernel.org>, "Szabolcs.Nagy@arm.com"
	<Szabolcs.Nagy@arm.com>, "brauner@kernel.org" <brauner@kernel.org>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"debug@rivosinc.com" <debug@rivosinc.com>, "mgorman@suse.de"
	<mgorman@suse.de>, "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
	"fweimer@redhat.com" <fweimer@redhat.com>, "mingo@redhat.com"
	<mingo@redhat.com>, "rostedt@goodmis.org" <rostedt@goodmis.org>,
	"hjl.tools@gmail.com" <hjl.tools@gmail.com>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "vschneid@redhat.com" <vschneid@redhat.com>,
	"shuah@kernel.org" <shuah@kernel.org>, "bristot@redhat.com"
	<bristot@redhat.com>, "hpa@zytor.com" <hpa@zytor.com>, "peterz@infradead.org"
	<peterz@infradead.org>, "bp@alien8.de" <bp@alien8.de>, "bsegall@google.com"
	<bsegall@google.com>, "x86@kernel.org" <x86@kernel.org>,
	"juri.lelli@redhat.com" <juri.lelli@redhat.com>
CC: "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
	"keescook@chromium.org" <keescook@chromium.org>, "jannh@google.com"
	<jannh@google.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "catalin.marinas@arm.com"
	<catalin.marinas@arm.com>, "will@kernel.org" <will@kernel.org>, "Pandey,
 Sunil K" <sunil.k.pandey@intel.com>
Subject: Re: [PATCH RFC RFT v2 5/5] kselftest/clone3: Test shadow stack
 support
Thread-Topic: [PATCH RFC RFT v2 5/5] kselftest/clone3: Test shadow stack
 support
Thread-Index: AQHaFzYe+3PXY720NkO0CxBi0N1IArB6cYGA
Date: Tue, 14 Nov 2023 23:11:58 +0000
Message-ID: <309927ad8bfa72ce2d084ee16cd0cd84e69fef16.camel@intel.com>
References: <20231114-clone3-shadow-stack-v2-0-b613f8681155@kernel.org>
	 <20231114-clone3-shadow-stack-v2-5-b613f8681155@kernel.org>
In-Reply-To: <20231114-clone3-shadow-stack-v2-5-b613f8681155@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|PH7PR11MB7429:EE_
x-ms-office365-filtering-correlation-id: 1e9771ed-1b48-499d-57b5-08dbe56719e7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EKJojyRh2TMvNVxTE+CoNIGltK34jXlOVGdrm0UAy/mWVDp6ZyURr5+m+4Jb/9jWyjrPSxGikGPLPdSW7Z867szkaCNQeD7S7T5sjhYD5tKSbp0lLpxkN/cISNksFloyszULKSvnP+4dfhY9Rcf12EfdAbWeBeS44jjOnWrVO++EbOCQv30DYFrw7mG+EPcJiDjK5Kv0Yp/C5wn5qg7sFOOBpZvNVAClXYJVzVP47ut5j1E6yHYg2uwXsJCKxvD+aiHvAcfa9SPYRWE4+yDjVco4+2UHhOXSkLvlhMau9CHOh9YrUhGV8HHQZK0SABVjKDW4BW1rYcrru3rWGN1GaoGe/tqZh8OW1vGiiE3DEju6xzYAZLhzEFdG3uQ9IsIXdOJeZOHSI7tlsIaKEs4oNcg8sOb2vlf4LMIasDbUxOi0q0fzMtAP/k7urLzmN24J/5/95wOBroAlEWVXMzfj6rjcU13YyO51obqVtNlt5jmzktI2gAgb6fKGfJ13GUNd/MKcgTdk6CiJ44WeJozKHZryyCWC50bntQcQsIMbTM8oGdf6SKE/8ChVbyltpak8d0S2r4wkyxzW+SQ3jvg4KhTdGUESgPXCNeNQAs4rBdXkx11NMtfKMFWe62OHXUPY
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(136003)(346002)(376002)(39860400002)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(91956017)(110136005)(66946007)(64756008)(54906003)(76116006)(66476007)(66446008)(66556008)(478600001)(6486002)(316002)(966005)(71200400001)(7416002)(86362001)(5660300002)(41300700001)(36756003)(921008)(38070700009)(4001150100001)(8936002)(4326008)(2906002)(8676002)(2616005)(26005)(82960400001)(122000001)(38100700002)(83380400001)(6506007)(6512007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QVpGUytOWkUxVWY2NjVsbWtEK3JmTzNVMWhmbnVZUkpoUXFaaGRUS0lFbnAv?=
 =?utf-8?B?bXlrRUtseUpqeTh5dFM1cktHbnJndFhKb0pSNTJ3em9VZysrekRQSlZaM1Vt?=
 =?utf-8?B?TjhvOUZ4SUsrKy9YeUV1aE8yaEpzRnF5d3RreXFsaHRBR2dVTDBtT2hGaE1z?=
 =?utf-8?B?N2w5UEprVzUvMDZydWFUMFdRak9xWi9WUDN1RmRleGVIU05PU1d6YzJtZ2x3?=
 =?utf-8?B?azJ4eE1WWVlLdW93YzEwSUFOZGZOb1ZISGRsVk1oSlRTSzNKUnE0QXJCZ0da?=
 =?utf-8?B?VWlEb2NHRXRxeGlnWkdkSXB1Z2RpYytJT1hLdlR1a3hrUE5GM3JGZWtUK2Y5?=
 =?utf-8?B?eGVRT0ZRaFhseFdQTjZLblZQN0ZJUmpORVpFazI5aWZDd240a0llb044ZHRr?=
 =?utf-8?B?a0pHK0pQeUUwM1RNa1E2UHBKblpoU0lYbHF3NmtYbWRrbE1rdEU4TjRtWU1H?=
 =?utf-8?B?bGd0d0RyMHQxSWNwSk8zdW9yRUZQV1RNVDVaaXN6K3I5VUJvWW0zcnJqN3hZ?=
 =?utf-8?B?Q2JKeUwycStvYVd2OE9JOU1WVmFyd3I3L09hczJEb04ycWIveDRWMVEyRWNh?=
 =?utf-8?B?NnFQcFVVNldzS2xzWFhjUm4wY2RPSkh4eTVCS2Z2Q2txMUxyMnJkUkZDYmhX?=
 =?utf-8?B?M3pQS3lmR1NNL3VvL0ZucHF5VzZCUHoxQk0vbUdqeGxZNzVKZ0dNOHBzVy9G?=
 =?utf-8?B?eGQrbFUvYS9WTFc0MlliWDdMUlNWUk1yUzVVNGtKSkMxY0lSQ09QS0d4dVls?=
 =?utf-8?B?azFhaDVicVkxREJITmVJVmlrUG1LbVBQYjl1SmtzSC8xbXE5VXp4OHBMdTlS?=
 =?utf-8?B?NTc1aE10bzFIcnBsdmtmZXhNM1ZuSU1kcEYrTzhBZ0o0UHUvMlpOc2JiTjRy?=
 =?utf-8?B?c2NmTDBIeEZiS3BaM0djYmc1VFk4V0VOeEh2VGhjTmh1Zi93QWNlMCt2QTdx?=
 =?utf-8?B?TkkzbTNBaXFPSXZCbkdzL3VVMElZSURGcVhrM0c0WDB4ejlWTDN2dmdqaW9m?=
 =?utf-8?B?aUpkcjN1NDRuU05MNFZuUk03Q0dzR0EyUjdydUFqWG1HamdhL3Y0eGtHQ1FL?=
 =?utf-8?B?dHV4ZFMzUUFIanpnWkFIdzdrV2hIUENTZFdReDk3MmU4Y2tYSzZKcVltZDVs?=
 =?utf-8?B?ci9aL1lra1ZBYkYxY0ZYaEFidmlRZWhDc0pOVG1IQkpVY05heUw4ZUJub1o1?=
 =?utf-8?B?TUswb1JlT3NsOWJQbURkUVRsQXNib0NhandSVWR1WXlTUTBtRXoyWURFS0w4?=
 =?utf-8?B?b3JRYVh3SHVwc1FhWFpaMVoyRnBCVlJqSmg2cUR0d1NkU2xuVzBzZmFxMjlt?=
 =?utf-8?B?NDQ0aEx5eWJQOFZLOGYxWWcxY1FnNGxrZkUwc0ZNY2VXaTByNktudGUxdDlt?=
 =?utf-8?B?bEJUSkZvSE5hem10TmZxdlo0TGlZWU5TVGZGNm9Wc3c4QmpDc3JnS1lZRjNJ?=
 =?utf-8?B?REtjMlgwaStuQXJxdVM2OHBUYjRqa25jeS9BM1NSL3VpbTVZcmhGdmx4Q3Jy?=
 =?utf-8?B?M0FEYkpYZXBuVVhZajRqSXZWRW9GNDVzdFQwZmtBeTVtWVJZSUdpcytIOS9D?=
 =?utf-8?B?TzlMSzZmbDB3R3RvVVJjVHBkVElWZXZjVXB2ZGVVdFNGMVJBU0hENVFRMW1U?=
 =?utf-8?B?RWU3dFNaano5bGRLRmYvWW5sY2VTQndIVmw1THB6QVZBdDhuMUY2aHdwRUYw?=
 =?utf-8?B?U1JjS3dhdmN2YVhXckVWVmpvSG9BQ2FLa05KMWZSak1SdU02RjZKditVT1Aw?=
 =?utf-8?B?bTNhTnl4WndEVVc2UWR5WWdoQWk1dkZvSEovcmpRWU1KWnhhMksweGV2L2NX?=
 =?utf-8?B?emVxYWo0MzJheWVmaGhtLzg2ZXJyL1FTYm1DSW91bmZQdlpSK3hXSEdkd0hE?=
 =?utf-8?B?bDJIQitnazkwR05iWEwwZE5wVmJIYUQwbnJ4Q1I0WkpERjZYZy8rR2JkU1dw?=
 =?utf-8?B?TEZNZWx5K2t1VllXUGJDNmVpckZodTlDbFpKVzUwU1hMWTJLKzh0YjNnS1dz?=
 =?utf-8?B?RXA4ZlcyUDBneS9wdG9BRUtBWXhiOGVoK0UvZ2dWMTZuS3ViQTg2S3RkRVcv?=
 =?utf-8?B?S00zZU1vLzRHQ2tESDFnYlFRU1E5TkpTLzhENHBmcmU5MkdmWUM1U1E4TnFj?=
 =?utf-8?B?cXlNaXFUNHN5OXJQVXNESVBkNGdTajFSKzR0V3FKWWpMQWJ1b1czNzNhYnJ1?=
 =?utf-8?B?ZlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C009C9257FFB9F4FB3B2FA9DF5F96412@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e9771ed-1b48-499d-57b5-08dbe56719e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2023 23:11:58.1763
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: njVDVlHTpKkilErTp1DixaEiWQqGhBr3gGDTWKU9Xv+j+PW7kBlW1qm4JZx2Qv+5o3TVL5uXoX/tAoOoMu+9J/qLFWnuZ/axaMcic5S/6Mg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7429
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDIzLTExLTE0IGF0IDIwOjA1ICswMDAwLCBNYXJrIEJyb3duIHdyb3RlOg0KPiAr
c3RhdGljIHZvaWQgdGVzdF9zaGFkb3dfc3RhY2tfc3VwcG9ydGVkKHZvaWQpDQo+ICt7DQo+ICvC
oMKgwqDCoMKgwqDCoCBsb25nIHNoYWRvd19zdGFjazsNCj4gKw0KPiArwqDCoMKgwqDCoMKgwqBz
aGFkb3dfc3RhY2sgPSBzeXNjYWxsKF9fTlJfbWFwX3NoYWRvd19zdGFjaywgMCwNCj4gZ2V0cGFn
ZXNpemUoKSwgMCk7DQoNCkhtbSwgeDg2IGZhaWxzIHRoaXMgY2FsbCBpZiB1c2VyIHNoYWRvdyBz
dGFjayBpcyBub3Qgc3VwcG9ydGVkIGluIHRoZQ0KSFcgb3IgdGhlIGtlcm5lbCwgYnV0IGRvZXNu
J3QgY2FyZSBpZiBpdCBpcyBlbmFibGVkIG9uIHRoZSB0aHJlYWQgb3INCm5vdC4gSWYgc2hhZG93
IHN0YWNrIGlzIG5vdCBlbmFibGVkIChvciBub3QgeWV0IGVuYWJsZWQpLCBzaGFkb3cgc3RhY2tz
DQphcmUgYWxsb3dlZCB0byBiZSBtYXBwZWQuIFNob3VsZCBpdCBmYWlsIGlmIHNoYWRvdyBzdGFj
ayBpcyBub3QgeWV0DQplbmFibGVkPw0KDQpTaW5jZSBzaGFkb3cgc3RhY2sgaXMgcGVyIHRocmVh
ZCwgbWFwX3NoYWRvd19zdGFjayBjb3VsZCBzdGlsbCBiZQ0KY2FsbGVkIG9uIGFub3RoZXIgdGhy
ZWFkIHRoYXQgaGFzIGl0IGVuYWJsZWQuIEJhc2ljYWxseSBJIGRvbid0IHRoaW5rDQpibG9ja2lu
ZyBpdCB3aWxsIHJlZHVjZSB0aGUgcG9zc2libGUgc3RhdGVzIHRoZSBrZXJuZWwgaGFzIHRvIGhh
bmRsZS4NCg0KVGhlIHRyYWRpdGlvbmFsIHdheSB0byBjaGVjayBpZiBzaGFkb3cgc3RhY2sgaXMg
ZW5hYmxlZCBvbiB4ODYgaXMgdGhlDQpjaGVjayBmb3IgYSBub24gemVybyByZXR1cm4gZnJvbSB0
aGUgX2dldF9zc3AoKSBpbnRyaW5zaWM6DQpodHRwczovL2djYy5nbnUub3JnL29ubGluZWRvY3Mv
Z2NjLTkuMi4wL2djYy94ODYtY29udHJvbC1mbG93LXByb3RlY3Rpb24taW50cmluc2ljcy5odG1s
DQoNCkl0IHNlZW1zIGxpa2UgdGhlcmUgd2lsbCBiZSBhIG5lZWQgZm9yIHNvbWUgZ2VuZXJpYyBt
ZXRob2Qgb2YgY2hlY2tpbmcNCmlmIHNoYWRvdyBzdGFjayBpcyBlbmFibGVkLiBNYXliZSBhIG1v
cmUgZ2VuZXJpYyBjb21waWxlcg0KaW50cmluc2ljL2J1aWx0aW4gb3IgZ2xpYmMgQVBJIChzb21l
dGhpbmcgdW5yZWxhdGVkIHRvIFNTUCk/DQoNCj4gK8KgwqDCoMKgwqDCoMKgew0KPiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgLm5hbWUgPSAiU2hhZG93IHN0YWNrIG9uIHN5c3RlbSB3
aXRoIHNoYWRvdyBzdGFjayIsDQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAuZmxh
Z3MgPSAwLA0KPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgLnNpemUgPSAwLA0KPiAr
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgLmV4cGVjdGVkID0gMCwNCj4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoC5lMmJpZ192YWxpZCA9IHRydWUsDQo+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAudGVzdF9tb2RlID0gQ0xPTkUzX0FSR1NfU0hBRE9XX1NUQUNL
LA0KPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgLmZpbHRlciA9IG5vX3NoYWRvd19z
dGFjaywNCj4gK8KgwqDCoMKgwqDCoMKgfSwNCj4gK8KgwqDCoMKgwqDCoMKgew0KPiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgLm5hbWUgPSAiU2hhZG93IHN0YWNrIG9uIHN5c3RlbSB3
aXRob3V0IHNoYWRvdw0KPiBzdGFjayIsDQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAuZmxhZ3MgPSAwLA0KPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgLnNpemUgPSAw
LA0KPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgLmV4cGVjdGVkID0gLUVJTlZBTCwN
Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoC5lMmJpZ192YWxpZCA9IHRydWUsDQo+
ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAudGVzdF9tb2RlID0gQ0xPTkUzX0FSR1Nf
U0hBRE9XX1NUQUNLLA0KPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgLmZpbHRlciA9
IGhhdmVfc2hhZG93X3N0YWNrLA0KPiArwqDCoMKgwqDCoMKgwqB9LA0KPiDCoH07DQo+IMKgDQpJ
IGNoYW5nZWQgeDg2J3MgbWFwX3NoYWRvd19zdGFjayB0byByZXR1cm4gYW4gZXJyb3Igd2hlbiBz
aGFkb3cgc3RhY2sNCndhcyBub3QgZW5hYmxlZCB0byBtYWtlIHRoZSBkZXRlY3Rpb24gbG9naWMg
aW4gdGhlIHRlc3Qgd29yay4gQWxzbw0KY2hhbmdlZCB0aGUgY2xvbmUzIE1ha2VmaWxlIHRvIGdl
bmVyYXRlIHRoZSBzaGFkb3cgc3RhY2sgYml0IGluIHRoZQ0KdGVzdHMuIFdoZW4gcnVubmluZyB0
aGUgJ2Nsb25lMycgdGVzdCB3aXRoIHNoYWRvdyBzdGFjayBpdCBwYXNzZWQsIGJ1dA0KdGhlcmUg
aXMgYSBmYWlsdXJlIGluIHRoZSBub24tc2hhZG93IHN0YWNrIGNhc2U6DQouLi4NCiMgU2hhZG93
IHN0YWNrIG5vdCBzdXBwb3J0ZWQNCm9rIDIwICMgU0tJUCBTaGFkb3cgc3RhY2sgb24gc3lzdGVt
IHdpdGggc2hhZG93IHN0YWNrDQojIFJ1bm5pbmcgdGVzdCAnU2hhZG93IHN0YWNrIG9uIHN5c3Rl
bSB3aXRob3V0IHNoYWRvdyBzdGFjaycNCiMgWzEzMzNdIFRyeWluZyBjbG9uZTMoKSB3aXRoIGZs
YWdzIDAgKHNpemUgMCkNCiMgSSBhbSB0aGUgcGFyZW50ICgxMzMzKS4gTXkgY2hpbGQncyBwaWQg
aXMgMTM0Mg0KIyBJIGFtIHRoZSBjaGlsZCwgbXkgUElEIGlzIDEzNDINCiMgWzEzMzNdIGNsb25l
MygpIHdpdGggZmxhZ3Mgc2F5czogMCBleHBlY3RlZCAtMjINCiMgWzEzMzNdIFJlc3VsdCAoMCkg
aXMgZGlmZmVyZW50IHRoYW4gZXhwZWN0ZWQgKC0yMikNCm5vdCBvayAyMSBTaGFkb3cgc3RhY2sg
b24gc3lzdGVtIHdpdGhvdXQgc2hhZG93IHN0YWNrDQojIFRvdGFsczogcGFzczoxOSBmYWlsOjEg
eGZhaWw6MCB4cGFzczowIHNraXA6MSBlcnJvcjowDQoNClRoZSBvdGhlciB0ZXN0cyBwYXNzZWQg
aW4gYm90aCBjYXNlcy4gSSdtIGdvaW5nIHRvIGRpZyBpbnRvIHRoZSBvdGhlcg0KcGFydHMgbm93
IGJ1dCBjYW4gY2lyY2xlIGJhY2sgaWYgaXQncyBub3Qgb2J2aW91cyB3aGF0J3MgZ29pbmcgb24N
CnRoZXJlLg0K

