Return-Path: <linux-kselftest+bounces-1024-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A008802216
	for <lists+linux-kselftest@lfdr.de>; Sun,  3 Dec 2023 09:58:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C68A81F21033
	for <lists+linux-kselftest@lfdr.de>; Sun,  3 Dec 2023 08:58:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 312D928FE;
	Sun,  3 Dec 2023 08:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JEBsNm6Z"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55626118;
	Sun,  3 Dec 2023 00:58:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701593890; x=1733129890;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=pwxgIp8PdDhunUKpsg8CBBPWBv/FLnmU8LNT4gluTEA=;
  b=JEBsNm6ZpjD6vdJlocbNo1BLa7QQ6+Smd20TCKIyIzdTMhUzVkaueDnN
   PjQr0losMXDNcmEw40ZnjDPoCV14e+rp4qfdMpUCtQCSWFcUU3SZihfsu
   r36b/fDzapz24My+ugLG1TSyo0P0v0qdscTRNq+XxVdfn4bETHQaLJkH1
   i6JHGlvizDutjJEfIPFBeEy2hAUmkc/eFbV+nQly/JSwLInGIwUJaGVkT
   xKrdQM+3lVEr1HhrJdyMOF49cVEbHGSFANeTMIaRTweE8emyc3x0haVpn
   Yq9kNNjd2BGBVB2XKo8sxn6p0S/Fmw/u+t/f97lELG/ajuQs8Jhmc5T8O
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10912"; a="373827132"
X-IronPort-AV: E=Sophos;i="6.04,247,1695711600"; 
   d="scan'208";a="373827132"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2023 00:58:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10912"; a="893671241"
X-IronPort-AV: E=Sophos;i="6.04,247,1695711600"; 
   d="scan'208";a="893671241"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Dec 2023 00:58:09 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Sun, 3 Dec 2023 00:58:09 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Sun, 3 Dec 2023 00:58:09 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Sun, 3 Dec 2023 00:58:08 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lTo7oNaScwMC5VxjD08uomzIOpSmixBX7Yz0WZwcu0i62efeOEH4gPw7rmW22pb9pJOlcrsuKPt5pL0NXw1F4vH/4QYYsK+GKyRfCROtEj0uVDonruOjrgDzg9h+yfn7QmXvll/RuEp8O3rGm26b09PdTQV4rWueBX32VAf0QnXN6oBbNcxf/oJYpVeGFwa/XW4TDgPmCYrnXharIWuVWZaBUfMrZOXm2Bh0DYNTCI66iTWPISqwZAfTqhHcltS3/ogczHTRKP8TkSkbLFKlHpFg3qjV5mMCwq6d+BoFvw6vb1BzRZqBDJuJFk+kPpLfGbmrHO0ilmhS1dslkjpFhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vST5jH8Th6pejsNd1nllkEi1xyyaAd3mI/KIZ2ihFX8=;
 b=ST+FSaa2YBDdMFgK3C957PggqKP636WkMk+fmrJ1xAXPcEL95EVAYPqshckeN375LGT2yPvGrgRwY2//TLU1NOJYx4AOf09J80LO64n2zGJC0kmrnuUlCIxaZyYP1RfE//TAtLmZ/JZL7I1B6oae/W2C+x2U8dv4OEQ9eZNyrbwo9EqugacTOx7CLriPWD+HbocHVuWD12TkBiC4l7U6gdezdyJ/5/jrTyqNLE+07hyG3cmU9j1lLdnC8zt2sgtu9p3B8V+ZF5ptG213jNlDkuMnjALB5TZqjMXzIodcSXYm+tKuVa/tqcXvufs7mGa1AdpQnKm2Hup1REW1vHb1Pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5830.namprd11.prod.outlook.com (2603:10b6:510:129::20)
 by SJ0PR11MB5816.namprd11.prod.outlook.com (2603:10b6:a03:427::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.32; Sun, 3 Dec
 2023 08:58:06 +0000
Received: from PH0PR11MB5830.namprd11.prod.outlook.com
 ([fe80::6ffc:93a3:6d7f:383c]) by PH0PR11MB5830.namprd11.prod.outlook.com
 ([fe80::6ffc:93a3:6d7f:383c%6]) with mapi id 15.20.7046.028; Sun, 3 Dec 2023
 08:58:05 +0000
From: "Song, Yoong Siang" <yoong.siang.song@intel.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: "David S . Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Jonathan Corbet
	<corbet@lwn.net>, Bjorn Topel <bjorn@kernel.org>, "Karlsson, Magnus"
	<magnus.karlsson@intel.com>, "Fijalkowski, Maciej"
	<maciej.fijalkowski@intel.com>, Jonathan Lemon <jonathan.lemon@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend
	<john.fastabend@gmail.com>, Stanislav Fomichev <sdf@google.com>, "Lorenzo
 Bianconi" <lorenzo@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, "Willem de
 Bruijn" <willemb@google.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>, Mykola Lysenko <mykolal@fb.com>, "Martin
 KaFai Lau" <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song
	<yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, Hao Luo
	<haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Shuah Khan
	<shuah@kernel.org>, Alexandre Torgue <alexandre.torgue@foss.st.com>, "Jose
 Abreu" <joabreu@synopsys.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"xdp-hints@xdp-project.net" <xdp-hints@xdp-project.net>,
	"linux-stm32@st-md-mailman.stormreply.com"
	<linux-stm32@st-md-mailman.stormreply.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>
Subject: RE: [PATCH bpf-next 1/3] xsk: add launch time support to XDP Tx
 metadata
Thread-Topic: [PATCH bpf-next 1/3] xsk: add launch time support to XDP Tx
 metadata
Thread-Index: AQHaI6lNhMbclA0v6kGITaNu3vmUTbCVV/0AgAHtsgA=
Date: Sun, 3 Dec 2023 08:58:05 +0000
Message-ID: <PH0PR11MB5830B462F82BFFE7E8958B64D887A@PH0PR11MB5830.namprd11.prod.outlook.com>
References: <20231130162028.852006-1-yoong.siang.song@intel.com>
	<20231130162028.852006-2-yoong.siang.song@intel.com>
 <20231201192846.15c9e64e@kernel.org>
In-Reply-To: <20231201192846.15c9e64e@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5830:EE_|SJ0PR11MB5816:EE_
x-ms-office365-filtering-correlation-id: 3de4b8aa-5cd1-415e-54a9-08dbf3ddf687
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UtVUbBKLL5nQwEdhO7304zYkUBWWivPFpmu9KgCwKeiL0Bt+wTSDUcOkKO81F0q1bd4b1yMTELBlu++xvoCgzpFr7bZIcswiMiK4YbquNTcGPTbgv9DimvjPxaaZ5Y56MRnYRtDmpq6ftLoTOcRL7z73bPPxSprVCLNF2JAGv0+75ThJ69ckvZs3Aimvs5Ft2H0Ig86EvxLh9G6j3RMlJDLsi7A9qZCAwSNMINuz4uS046uOGoKa5FbPInPfqVcZANJNs39CWdM4kWIbS5RKjhUaFbF2njgN1BUW+Ei8a347QWpPM+69FQRkjuJkhfOf2/JHkt7qd6nB2GR0wEl2igJGQalSQY/4euDFapPIXKJ7AFngfDZNNDM+gQXwTr572Tafheb/pmA3J5HGIMD3I7nuLRxXMvW0IFkbOaxsp8K3rwMRFMgC1Ed9L6JdpL1r6lI3g99z0DQzOJ2Advfs0FEvYWPLhBd96V2FyyrI055TW9Vy6B4h7GEkCLsyRSLxQmT02RV91uRpE/IfcrLTTpUW+0oagxH57UV+mi7m0bVcpLUqlWyaGczdDk8uM62VT1iHgwxKyLRfzjHSlGjK6UUA6K7ZYCyt+xYbXeoQE4o/AzqImSqAlYBc8l8pN08N
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5830.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(39860400002)(366004)(346002)(376002)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(7406005)(5660300002)(52536014)(4744005)(7416002)(86362001)(4326008)(8676002)(8936002)(2906002)(38070700009)(41300700001)(33656002)(9686003)(6506007)(53546011)(82960400001)(83380400001)(26005)(478600001)(7696005)(71200400001)(38100700002)(55016003)(122000001)(316002)(54906003)(64756008)(66446008)(66476007)(6916009)(66556008)(66946007)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?vWA602wIlieTI+umq1ZnVC5MbgqZpdXWkX3irI97PkoWBW+v0RRgbOcvkmjT?=
 =?us-ascii?Q?pBqjpp+3q4lqzvYv7UAbXqDCN3D1cKdrZxfXY3l0nTBFI6BgDXdqqCtIdfbY?=
 =?us-ascii?Q?7k2Z9rnoKr07kH/uZ5QYdGWeMoimuapBNwjKaCxhIBKSl17E8uzNhF2rs4OY?=
 =?us-ascii?Q?AxrqP22yQhBZt0T9jrMGcXGrOc0q6XSMIzfYbI+UWwx7qu4hUlhmcOIJXq9W?=
 =?us-ascii?Q?B9oO/GpZWjkozVCCKPB0HQpCLpT970w+d69Z4/qqLrWrRn+RWnejXvT9gA7J?=
 =?us-ascii?Q?ojEGjtBNIMqV/KE9Pze0rHNy/VA+ouCaJV6ST5vNL0+wJ/UtjabxUlyCUqBB?=
 =?us-ascii?Q?azmawYuZoA/xeRggqF6GepWAQ3SEniIrsn7HH5y2zLeGCsZHhUI6P++/jzKb?=
 =?us-ascii?Q?+WBt0Tukp5yCPdbReh7IXkAGB75RWQ/zYY3xtRh1JM064SI7VLJ1Vo1eWKTm?=
 =?us-ascii?Q?A/3+5e8BAI9JR4lCitH7P4Q4LwhIkT7vrrlsjUvD0VHhgH+Buzb698gaZ8hl?=
 =?us-ascii?Q?6r055XfgWyGtmkQCXZoHxVp24/mqVlj2zUto32pV6UQp9JHB+rvyb8oQlA0A?=
 =?us-ascii?Q?klIQYUCndW2Yr096p7km6E1h8rvkvSFo2hyxNMqDPzuqNko/becTvfIh1hnJ?=
 =?us-ascii?Q?6qsBvD1I8yZoGKmKy+lOmo97aNRQ3I7GKudTqyy1nrcSR01Xo+K6JstZXled?=
 =?us-ascii?Q?1u5gYojotVCKj3v8ym5QxAPh1T8uzpri99yuk3f8wzP2/oNvHrBb1dDGFdKa?=
 =?us-ascii?Q?wVSekYyW5DlxRgY0lTzO/MvdMF7MuNC1Gr/qr0ZUWNn4WyhlNbOx2Njv+18L?=
 =?us-ascii?Q?i1zqFsKyZvnhomLdq2Wz13tnxLHnn7r8VCUYxb9yPiGnrK1bQIqxBc20S1nd?=
 =?us-ascii?Q?ZsrnIv5JBuMNcYWFh/oXeiO4s2ZMUuCRytPQX/FP6Q3SMbAoWbhR0S3WY5So?=
 =?us-ascii?Q?NwmaI+WRTH7/nOyHQN17Oiu3w7W8P89P96LPzZRz4XnsutVbAKsx8sDXCOx5?=
 =?us-ascii?Q?zi8oxcqanqozksOygMoEIzVQLaH6lSzvBmKqAHq1yIjsHWMMZTue3++dx05Y?=
 =?us-ascii?Q?zKOz4azAT9q77ae+nfS3fNWQC+lkmyKx/10oQSd+NBN3qsiLi9ghx3tqdE8l?=
 =?us-ascii?Q?mBZPL7MVX6fTjzfY2UsdxEOS32yriIjcFv/xazIdCF1DIvMBkE9LFDq0y5EU?=
 =?us-ascii?Q?q/G44aN8leepZ6uYx8c6krndGesZhtxS/TIIde1K7fISnGhdhLDTiKxsgENT?=
 =?us-ascii?Q?yHk/mws9BGv6vKgrpxkkT8Gn5RXnNDBRmM24nyXQVtuDbA1QeHL4A5iOfJbE?=
 =?us-ascii?Q?gJkBLH2GaicON3hQD48ogLUCfm0DG6xYOJoHBo3GnOHBNB72sKb9RT3msjtP?=
 =?us-ascii?Q?Uj027C+yXJQ0ErIs49lHAH0AACB6Nq9Z5REIQOE14DwiH7hOs8NZL+VEhUPh?=
 =?us-ascii?Q?0ZPOZAQET6wbALGtMeJjAVkAxob4QF1aOZ6MyUXEGvEG9/LBW4QtglfvLeTG?=
 =?us-ascii?Q?zqFYTBoCLV2HjpK13yNEeSHImrA8JIOIeK7T16bmZUwvID53D8bCxxik9/bk?=
 =?us-ascii?Q?WPRTMdoxIvKbSjeBuL2PzYZbbzfznmuk5wDKlVitx8eWts78Ad13zGaC2HI4?=
 =?us-ascii?Q?aw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5830.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3de4b8aa-5cd1-415e-54a9-08dbf3ddf687
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2023 08:58:05.2423
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rEBG7JkmexeHzxek2sLS7ocRwxl3EBKH9EX8ZFF/+Q3+4r4N757cxfT9r9Ym87fWq0ajnhcEv+0YHj6xaVE9Ck9jHzNJAjf+LXpFaNzCwRE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5816
X-OriginatorOrg: intel.com

On Saturday, December 2, 2023 11:29 AM, Jakub Kicinski wrote:
>On Fri,  1 Dec 2023 00:20:26 +0800 Song Yoong Siang wrote:
>> +        name: launch-time
>> +        doc:
>> +          HW Time-Based Scheduling (TBS) is supported by the driver.
>
>Does this mean fifo "gating" or HW can do reordering?

Yes, HW will do reordering according to the value of launch time.
=20

