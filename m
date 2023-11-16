Return-Path: <linux-kselftest+bounces-228-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F76D7EE678
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Nov 2023 19:12:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E13DB20DED
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Nov 2023 18:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CAA435896;
	Thu, 16 Nov 2023 18:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ncSWV2We"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A70F6192;
	Thu, 16 Nov 2023 10:11:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700158310; x=1731694310;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=HI+yHyypNjxlsdFo4VYnZSd2ETcB+pSouEoXQyki0UA=;
  b=ncSWV2WezUenKr6kix5kdL3jGi47ygNNkxBb2h5XFljRrFmfaaEJHbvf
   K61IzqrINwq1retVZ9mUAxnI+duYcLU8GPz7vCM/qG2j38c2G+F1G+mc8
   A5w7T7IgLkJ48Z2Ia+1GD4r5tOVXn5311LorfgT5622hg9DvLHn+NztoN
   WUrtcueP11RRXk21NCJN+zTGur3jMEaaNuWu0oJR61/Bixrh85n+Tqz90
   1DAQIF85acisMc8BUptFNZeawbTvTfeq0rYakFg/HnoEiEfSjcTZQpeq6
   AKHXvU4DQptyW2V8+UV9DgXxwH6KguvdpSOqsFD6dtlVddVM3I52byQ/m
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10896"; a="381541639"
X-IronPort-AV: E=Sophos;i="6.04,204,1695711600"; 
   d="scan'208";a="381541639"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2023 10:11:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10896"; a="835814280"
X-IronPort-AV: E=Sophos;i="6.04,204,1695711600"; 
   d="scan'208";a="835814280"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Nov 2023 10:11:20 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 16 Nov 2023 10:11:19 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Thu, 16 Nov 2023 10:11:19 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Thu, 16 Nov 2023 10:11:19 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PY/BBNJiTgjGgI/Uevsz5KC1ZjrbS0GZbDm3qsjEL24Hx2JbGVd89pWU+NMt+WB3jpCpHmEG+WrWTCZfJTfVLJ51sYfg9dYCV28ASkjpuEQ7qt9G2xcy5ELdqo9o5FWRmHsJlW+a3WpMwzPEEy2NDB6N0N44/H46e8pQCj3x6+U0xXLGujuFvaP4KpqFGVr9IbguDRRGGgbCFvsQXgs/SjTL6VufsylNCCMqkz5IULdzL7Y8VZPNcHH6kSscRnuN2kP5aC8Z5T3IkZq8bKNeTuZffSBCuLxwamSNvcge7VFy0P2m9vtYF/eax7wbJGwoJJw4/t1tqPYQa5jS42bdcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HI+yHyypNjxlsdFo4VYnZSd2ETcB+pSouEoXQyki0UA=;
 b=VnLIXKE345DEy55yIi5fuP7i/VdM9hl757j/inTuGzwaBEBBC/uh9yUtzj90ym5si7YZbG76lKxYQ1Sp/eImYe+Av5fXRTvi9mbGD+m1s+dchkCRIJJgixgY7KHEQSdmZV06havQPzMKJJqp/sCVzDIfqhPTpOE1400J+Zfvzmt/vY6efsr3+Fxcs++YK/OkyDzZ/O9RI+Zejuaiuy8kWdOe3OCxlMjZP0NcasP37z59DZDTC3JXA4pYLJpBfcY3KMnRM4NTpzbzBMGvRyXScCBpxKgimMdyf+ZGAhSqxfJhxGNhc0Mu+3FJ5PexTWg8BUGL2pfrtUDB/foU3NOHPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by DM4PR11MB6310.namprd11.prod.outlook.com (2603:10b6:8:a7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.21; Thu, 16 Nov
 2023 18:11:17 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::5260:13db:a6e:35e9]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::5260:13db:a6e:35e9%6]) with mapi id 15.20.7002.015; Thu, 16 Nov 2023
 18:11:17 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "broonie@kernel.org" <broonie@kernel.org>, "Szabolcs.Nagy@arm.com"
	<Szabolcs.Nagy@arm.com>
CC: "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
	"keescook@chromium.org" <keescook@chromium.org>, "shuah@kernel.org"
	<shuah@kernel.org>, "brauner@kernel.org" <brauner@kernel.org>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"debug@rivosinc.com" <debug@rivosinc.com>, "mgorman@suse.de"
	<mgorman@suse.de>, "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
	"fweimer@redhat.com" <fweimer@redhat.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "mingo@redhat.com" <mingo@redhat.com>,
	"rostedt@goodmis.org" <rostedt@goodmis.org>, "hjl.tools@gmail.com"
	<hjl.tools@gmail.com>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"vschneid@redhat.com" <vschneid@redhat.com>, "catalin.marinas@arm.com"
	<catalin.marinas@arm.com>, "vincent.guittot@linaro.org"
	<vincent.guittot@linaro.org>, "bristot@redhat.com" <bristot@redhat.com>,
	"will@kernel.org" <will@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
	"peterz@infradead.org" <peterz@infradead.org>, "jannh@google.com"
	<jannh@google.com>, "bp@alien8.de" <bp@alien8.de>, "bsegall@google.com"
	<bsegall@google.com>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "Pandey, Sunil K"
	<sunil.k.pandey@intel.com>, "x86@kernel.org" <x86@kernel.org>,
	"juri.lelli@redhat.com" <juri.lelli@redhat.com>
Subject: Re: [PATCH RFC RFT v2 2/5] fork: Add shadow stack support to clone3()
Thread-Topic: [PATCH RFC RFT v2 2/5] fork: Add shadow stack support to
 clone3()
Thread-Index: AQHaFzYai+mxslqXM0i150aoxWGrvrB6i7UAgADGr4CAAD5nAIAAKB6AgABm6gCAAKILAIAAIfGAgAAWyICAABwsgIAAK2UA
Date: Thu, 16 Nov 2023 18:11:17 +0000
Message-ID: <9ce63f824b768f9635e55150815ee614fdee1d73.camel@intel.com>
References: <20231114-clone3-shadow-stack-v2-0-b613f8681155@kernel.org>
	 <20231114-clone3-shadow-stack-v2-2-b613f8681155@kernel.org>
	 <c9434fa9d864612ed9082197a601c5002ed86a38.camel@intel.com>
	 <d873072c-e1f4-4e1f-9efc-dfbd53054766@sirena.org.uk>
	 <ZVTvvJTOV777UGsP@arm.com>
	 <d90884a0-c4d3-41e9-8f23-68aa87bbe269@sirena.org.uk>
	 <d05d23d56bd2c7de30e7732e6bd3d313d8385c47.camel@intel.com>
	 <ZVXvptSmmJ6MQ0dY@arm.com>
	 <1bd189e0-a7dd-422c-9766-ef1c9b0d3df8@sirena.org.uk>
	 <ZVYfO/yqRtuRYaJA@arm.com>
	 <54d3bc9c-9890-49f0-9e9d-78ea4d0d7199@sirena.org.uk>
In-Reply-To: <54d3bc9c-9890-49f0-9e9d-78ea4d0d7199@sirena.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|DM4PR11MB6310:EE_
x-ms-office365-filtering-correlation-id: 50bb7e5c-c50a-41c6-16d1-08dbe6cf6da8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /Cjo+vjoKnLvIr4KGFdfi1/DNnCPcNFrgDXO8CImV5HOQd3V/py9Fev/wItAg9anWikqojSORv601eoAOoPzzyFuiqXFPL3zBNNk9IAwv8J7xPrgSJDpccwHc7f4++Tz4LWnNYIZj5Jrqs5h5Wc2piU7Ic9imdIG/YTE593LBwGsWPvNtX/HK43qI6nZPHTYj9ynEkDuQW/JwnXj9ng8vFgBRqnBDXSr/iGUBBC3N0hrN43za92idfCfSddu6pReW3ezcwVeGpPqHV/SmM5BDtDdpH5lLFGimnpc5719f3woWNU5GXMAY/w7KHVN2qdCcRP6mxp4TSDOEKuqS3Zi7nzdPvTWQP5U4f6abaTMpK68mtUfzrnAa22YcFSeQEWyNSCB088pbfF5F4xUy9buw8IWxaj1JhH50f5F2RInVlN5iUUfg8cr3xpgdoLsoQipVh3xb0hLaA0ZIerc+NrVQcOl84K6/R6jptlnR6dID4vuTwN8JcZqGPS4HLM75z6q1vz5Ug3uVw4G24swR5Jg2DyUd5s4yujQhWwBKh+Qe23h/gI0E3N0GBa5kZE5pym8NY4t6HUFHGAKUfjthcuUUtq5UYGrmcXm+qIeVACySGnKKukzk3Z1vKD9C1Ye6qSx
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(366004)(396003)(346002)(136003)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(54906003)(91956017)(110136005)(66446008)(66476007)(66556008)(76116006)(64756008)(66946007)(316002)(83380400001)(26005)(2616005)(6506007)(36756003)(38070700009)(6512007)(71200400001)(6486002)(478600001)(7416002)(38100700002)(5660300002)(122000001)(4001150100001)(82960400001)(41300700001)(2906002)(86362001)(8936002)(8676002)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bjBQSnJvZlpKY04wQ2xxdmpOcVUzWEdscmdvakhwTWlFSXBtbjRPdjNmd0I1?=
 =?utf-8?B?KzFoN2NHOXBOZGRKRGZUZlVOZXRnSU5uUCtNUGVZWmZ5WmgxM2xROENuUjhp?=
 =?utf-8?B?cTFKQ014V3A1aWZ2a2tkcnRJdzlLcGliM1JPRmpXeGNEcGZhZndkWjhEMEw1?=
 =?utf-8?B?TkRTZnZUUVVCUm4yZjFKNEJ1UHlFTVFheEczYWZ4T1J3KzJUWHJZdFpuQUJs?=
 =?utf-8?B?Zi9zYUhpS3E2YTRlM1krUDB2T0FMZFdrbWJjWjRUSXpjMmplTG96NUNJdGR4?=
 =?utf-8?B?ZmRDNGN6MjB5cXRYamppR2ticUZLUE1raTBFRU5tZjdMUis5UTZJS3kxYXFy?=
 =?utf-8?B?aWR3NjRVV2pzZVlJNzliZXc0b2ZhZmtZdnh6NGtOQldmVmowbHQyVlFPZVdx?=
 =?utf-8?B?MEJ2WEZSQWpOU3FuVjQ5L1pGc2hnZHhvcG9aNThWY0R0c3FVK0Qrdjh1YWdh?=
 =?utf-8?B?RGYvQTlCbG41SjAyelQzMVcxT2JCc1hBdDBKOFlrRVBESE9kNUpzMi9CQi95?=
 =?utf-8?B?bk16NXhoc1dna2NuandpTG44dFJrS2w4YUZ6SThYVjJSOEt4WHB0U1cxSGZp?=
 =?utf-8?B?UkJjTndtYTM5UEV2UjQ5TmE2VWxQbmlFOEF6QTNjZXFVOE9WNk5Kd21xMWpw?=
 =?utf-8?B?bG1jaHZkVXVCMTJqL1hQL2w4U3NaMjVTRDN5czN3M0pYamUvYzFuVG1HaHNt?=
 =?utf-8?B?NUFnVWV6OGtzVDJXYWN4OUgrTkg5MkIvRlZDT0lqNEttUncrTkJ0cy9qLzVr?=
 =?utf-8?B?U1hqT0xVc0ZRRGNMZERvbG1wek9jakoyUlY5NklOem55bVYxb3RWUnVrTHlk?=
 =?utf-8?B?OWU3VVY2bHpLdUQyeUk4bmxBMHYreTc2K2NOZFZFblJSbnpoTks0Q05uWHlF?=
 =?utf-8?B?YmxGV0FKK3hPZWhnUlFWTEJpYllPTlF4QUxBNk14OWdPWFJUWW53UldYMzAv?=
 =?utf-8?B?WnpGZHllZE0wYTBBcEdnclNuNEtheHBRWlFBSHh4elB0ZmxUSGltNjRiTm1H?=
 =?utf-8?B?TnQzTkJ6SFpoM2Y4YVJTT1ltRXhOSUNZekJFTG42S0MyMDBmcGRLV200OVdX?=
 =?utf-8?B?cXBuWFJxUVRMeERiREErbTluSmhseVVZRVB4TTd3eTJoWE13SjlMYkNWdUdv?=
 =?utf-8?B?RHc1RDcwSFB0cWtNQk1VaVdmZDYzUlRCblhMeitZYUFoZEljYmIvNld1d3ND?=
 =?utf-8?B?bE1kUW9mVUJUclcxUElUSWhHWEhocVlOYWg5bDBpdE9wdFkrSHowQUx1VURJ?=
 =?utf-8?B?SU1TOHFIRlMwL1FkMnNrNzAyQlNRT1g2bXZTSVkva0xrdFJZakJPS0V3blhj?=
 =?utf-8?B?dkJ0ZGhvRGpFSHRKUWU3bWVialZwUXZDRVdCVXBRUWV3Y0xLelZDZzlWaGFp?=
 =?utf-8?B?aWdGOEFaL3BNTkNDNUxXVFN0RSthZzhiVzhFdjVqRWpIeWtiMEI0d0wyTjB2?=
 =?utf-8?B?YVBnTW1CYzVnbDg3WkVXVlhpVzZTQ1BGN2JmL1RRSzJ4TGc2ejRTT21aTDBZ?=
 =?utf-8?B?RGRwaWt3M21GamwzYXJTa0dsV1Fod3hjamtFejRlOE1TUWYzWFhrYWRCZWw5?=
 =?utf-8?B?OFBCSVhOUGJVSUdXTGExKzBrMVhiWm1Fdk1BYlRVVzVLNmI5aURTQS9wL2RR?=
 =?utf-8?B?VWxzUitYZXpUd0ZDNkZGbERDTlp5V0xDUE9VR3F3N3hxQnpHajRyWkJwZ0xY?=
 =?utf-8?B?NzhpTWMyODY1UkFyNVZGQjg1QTFPbDJDbjNuK1hGRytTVkdjQVJhNitiZksx?=
 =?utf-8?B?L01ZbTlFU1g1cXZOSXRZNFRIWXFMMWpGR1MxREY0Z3A4WE5CbWp0Vm5RWjNQ?=
 =?utf-8?B?dW9xUmdrWFQvbzYyOWVOeWpDeEdiMkFJVnFxRk01OTJYdEVQQTlxSkd5UUhi?=
 =?utf-8?B?bkNsS010aHpTQkxYdUVoY241WFRlR2pyOStLL3l6STlGSnl6L3ZrMnpKQ3Vn?=
 =?utf-8?B?QlBuYnp2Tjc2Nlo2Q0diZjN0K1dRZHNhZ2xSblZOb211VUhPeGVyWHpwRGNF?=
 =?utf-8?B?dnhIUCtUV3lNQW9qNHNxaURMS0dpMFZLZ3JVZE4rVVZBYnAwWWhwbHNqY1Rw?=
 =?utf-8?B?VFBpeFd1K1VSR1RmbjhCM1M2dlUxQ3FNSVYvVXF5VGZ2alJMalNXUTM2dmkz?=
 =?utf-8?B?NjJlTUUycjFsbkV6Wk1XaUNrdVJHd3BXWTJOYWdMREdGVnZBNExsQjdlSVdv?=
 =?utf-8?B?cUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C567AF368A39894E998945CEAA95223C@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50bb7e5c-c50a-41c6-16d1-08dbe6cf6da8
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2023 18:11:17.5335
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FUpg/khe7yBp9K9rNp+Qm0iNR6FZ/RLHZCazfKRWjVu9bwzXI3y7AYeniBkQMg5YLiF9h/NxTHTKnWXlfwFXRSUCjXOUOd6ly3HlLn+ULJ0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6310
X-OriginatorOrg: intel.com

T24gVGh1LCAyMDIzLTExLTE2IGF0IDE1OjM1ICswMDAwLCBNYXJrIEJyb3duIHdyb3RlOg0KPiBP
biBUaHUsIE5vdiAxNiwgMjAyMyBhdCAwMTo1NTowN1BNICswMDAwLA0KPiBTemFib2xjcy5OYWd5
QGFybS5jb23CoHdyb3RlOg0KPiA+IFRoZSAxMS8xNi8yMDIzIDEyOjMzLCBNYXJrIEJyb3duIHdy
b3RlOg0KPiA+ID4gT24gVGh1LCBOb3YgMTYsIDIwMjMgYXQgMTA6MzI6MDZBTSArMDAwMCwNCj4g
PiA+IFN6YWJvbGNzLk5hZ3lAYXJtLmNvbcKgd3JvdGU6DQo+IA0KPiA+ID4gPiBpIGd1ZXNzIHRo
ZSB0cmlja3kgY2FzZSBpcyBzdGFjayE9MCAmJiBzaGFkb3dfc3RhY2tfc2l6ZT09MDoNCj4gPiA+
ID4gdGhlIHVzZXIgbWF5IHdhbnQgYSBuZXcgc2hhZG93IHN0YWNrIHdpdGggZGVmYXVsdCBzaXpl
IGxvZ2ljLA0KPiA+ID4gPiBvciAod2l0aCAhQ0xPTkVfVk0gfHwgQ0xPTkVfVkZPUkspIHdhbnRz
IHRvIHVzZSB0aGUgZXhpc3RpbmcNCj4gPiA+ID4gc2hhZG93IHN0YWNrIGZyb20gdGhlIHBhcmVu
dC4NCj4gDQo+ID4gPiBJZiBzaGFkb3dfc3RhY2tfc2l6ZSBpcyAwIHRoZW4gd2UncmUgaW50byBj
bG9uZSgpIGJlaGF2aW91ciBhbmQNCj4gPiA+IGRvaW5nDQo+ID4gPiB0aGUgZGVmYXVsdC9pbXBs
aWNpdCBoYW5kbGluZyB3aGljaCBpcyB0byBkbyBleGFjdGx5IHdoYXQgdGhlDQo+ID4gPiBhYm92
ZQ0KPiA+ID4gZGVzY3JpYmVzLg0KPiANCj4gPiB0byBiZSBjbGVhciBkb2VzIGNsb25lIHdpdGgg
ZmxhZ3M9PUNMT05FX1ZNfENMT05FX1ZGT1JLIGFsd2F5cw0KPiA+IHVzZSB0aGUgcGFyZW50IHNo
YWRvdyBzdGFjayBpbmRlcGVuZGVudGx5IG9mIHRoZSBzdGFjayBhcmd1bWVudD8NCj4gDQo+ICFD
TE9ORV9WTSByYXRoZXIgdGhhbiBDTE9ORV9WTSBidXQgeWVzLCB0aGF0J3Mgd2hhdCB0aGUgY2xv
bmUoKSBhbmQNCj4gaGVuY2UgY3VycmVudCBjbG9uZTMoKSBiZWhhdmlvdXIgaXMgaGVyZS4NCg0K
ImZsYWdzICYgQ0xPTkVfVk0iIGdldHMgYSBuZXcgc2hhZG93IHN0YWNrLCB1bmxlc3MgYWxzbyAN
CiJmbGFncyAmIENMT05FX1ZGT1JLIi4gT3RoZXIgZmxhZ3MgaW4gdGhlcmUgYXJlIG5vdCBjb25z
dWx0ZWQgZm9yIHRoZQ0KbG9naWMgb2Ygd2hldGhlciB0byBjcmVhdGUgYSBuZXcgc2hhZG93IHN0
YWNrLg0KDQpTbyBDTE9ORV9WTXxDTE9ORV9WRk9SSyB3aWxsIHVzZSB0aGUgcGFyZW50IHNoYWRv
dyBzdGFjay4NCg0KIUNMT05FX1ZNIHdpbGwgYWxzbyBzb3J0IG9mIHVzZSB0aGUgc2FtZSBzaGFk
b3cgc3RhY2ssIGJ1dCBpdCdzIGEgQ09XDQpvbmUuDQoNCg0KTm93IHRoYXQgSSd2ZSB0aG91Z2h0
IGFib3V0IGl0IG1vcmUsIHJlbW92aW5nIHRoZSBDTE9ORV9WRk9SSyBwYXJ0IG9mDQp0aGUgbG9n
aWMgaGFzIHNldmVyYWwgZG93bnNpZGVzLiBJdCBpcyBhIGxpdHRsZSBleHRyYSB3b3JrIHRvIGNy
ZWF0ZQ0KYW5kIHVubWFwIGEgc2hhZG93IHN0YWNrIGZvciBhbiBvcGVyYXRpb24gdGhhdCBpcyBz
dXBwb3NlZCB0byBiZSB0aGlzDQpsaW1pdGVkIGZhc3QgdGhpbmcuDQoNCkl0IGFsc28gd2lsbCBj
aGFuZ2UgdGhlIFNTUChsZXQgbWUga25vdyBpZiBhbnlvbmUgaGFzIGEgZ2VuZXJhbCB0ZXJtIHdl
DQpjYW4gdXNlKSBmb3IgdGhlIGNoaWxkLiBTbyBpZiB5b3UgaGF2ZSBsaWtlOg0Kc3NwID0gX2dl
dF9zc3AoKQ0KaWYgKCF2Zm9yaygpKSB7DQoJZm9vID0gKnNzcDsNCgkuLi4NCn0NCg0KLi4uaXQn
cyBhd2t3YXJkIGVkZ2UuIEluIHRoZSB2Zm9yayBtYW4gcGFnZSBpdCBwb2ludHMgdG8gZm9yayB3
aGljaCBoYXMNCnRoZSB0ZXh0OiAiVGhlIGNoaWxkIHByb2Nlc3MgaXMgYW4gZXhhY3QgZHVwbGlj
YXRlIG9mIHRoZSBwYXJlbnQNCnByb2Nlc3MgZXhjZXB0IGZvciB0aGUgZm9sbG93aW5nIHBvaW50
cyIsIHdoaWNoIG9idmlvdXNseSBkb2Vzbid0DQppbmNsdWRlIFNTUC4NCg0KTGFzdGx5LCB0aGVy
ZSBhcmUgYWxyZWFkeSBjYXNlcyB3aGVyZSB0aGUgeDg2IGdsaWJjIGltcGxlbWVudGF0aW9uDQpz
dGF5cyBvbiB0aGUgc2hhZG93IHN0YWNrIHdoZW4gaXQgc3dpdGNoZXMgcmVndWxhciBzdGFja3Mg
KGkuZS4NCnNpZ2FsdHN0YWNrKCkpLiB2Zm9yayBjaGlsZHJlbiBhcmUgbm90IHN1cHBvc2VkIHRv
IHJldHVybiwgc28gaXQgc2hvdWxkDQpub3JtYWxseSB3b3JrIHRvIGJlIG9uIHRoZSBzYW1lIHNo
YWRvdyBzdGFjay4gU28gaXQncyBub3QgYSBzcGVjaWFsDQpzaXR1YXRpb24gdW5sZXNzIHdlIGNh
biByZXNvbHZlIHRob3NlIG90aGVyIHNpdHVhdGlvbnMsIHdoaWNoIGFyZQ0KbGltaXRlZCBieSB0
aGUgc3RhY2sgbGlmZXRpbWUgaXNzdWVzLg0KDQpXaGF0IGFib3V0IGEgQ0xPTkVfTkVXX1NIU1RL
IGZvciBjbG9uZTMgdGhhdCBmb3JjZXMgYSBuZXcgc2hhZG93IHN0YWNrPw0KU28ga2VlcCB0aGUg
ZXhpc3RpbmcgbG9naWMsIGJ1dCB0aGUgbmV3IGZsYWcgY2FuIG92ZXJyaWRlIHRoZSBsb2dpYyBm
b3INCiFDTE9ORV9WTSBhbmQgQ0xPTkVfVkZPUksgaWYgdGhlIGNhbGxlciB3YW50cy4gVGhlIGJl
aGF2aW9yIG9mDQpzaGFkb3dfc3RhY2tfc2l6ZSBpcyB0aGVuIHNpbXBsZS4gMCBtZWFucyB1c2Ug
ZGVmYXVsdCBzaXplLCAhMCBtZWFucw0KdXNlIHRoZSBwYXNzZWQgc2l6ZS4gTm8gbmVlZCB0byBv
dmVybG9hZCBhbmQgdGllIHVwIGFyZ3MtPnN0YWNrLg0KDQpJbiB0aGUgb3RoZXIgZGlyZWN0aW9u
IHRob3VnaC4uLiBDTE9ORV9WRk9SSyBjYW4gYmUgdXNlZCB0byBzdGF5IG9uIHRoZQ0KZXhpc3Rp
bmcgc2hhZG93IHN0YWNrIGFuZCBwb3NzaWJseSBjb3JydXB0IGl0LiBUaGlzIGNvbm5lY3RzIHdp
dGgNCmVhcmxpZXIgZGlzY3Vzc2lvbnMgYXJvdW5kIHNpZ25hbHMgZHJvcHBpbmcgYSB0b2tlbiBi
ZWZvcmUgYmVpbmcNCmhhbmRsZWQgYW5kIHRoZSBvdmVyZmxvdyB1c2UgY2FzZSwgYW5kIHRyeWlu
ZyB0byBndWFyYW50ZWUgb25lIHRocmVhZA0KcGVyIHNoYWRvdyBzdGFjayBhdCBhIHRpbWUsIGV0
Yy4gU28gaWYgdGhlcmUgaXMgYW55IGluY2xpbmF0aW9uIHRvd2FyZHMNCnRyeWluZyB0byBnZXQg
dGhhdCwgaXQgbWlnaHQgYWN0dWFsbHkgYmUgdXNlZnVsIGZvciBhbm90aGVyIHJlYXNvbi4gSXQN
CndpbGwgY2xvc2Ugb25lIG1ldGhvZCBmb3IgZ2V0dGluZyB0d28gdGhyZWFkcyBvbiB0aGUgc2Ft
ZSBzaGFkb3cgc3RhY2sNCmF0IHRoZSBzYW1lIHRpbWUgKG9uZSBpcyBzbGVlcGluZyB5ZXMsIGJ1
dCBpdCdzIHRoZSBzYW1lIHByb2JsZW0gaW4NCmVmZmVjdCkuDQoNCg==

