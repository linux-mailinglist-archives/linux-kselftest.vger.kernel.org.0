Return-Path: <linux-kselftest+bounces-42587-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 721BABA9F04
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Sep 2025 18:05:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC4BD16C2A2
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Sep 2025 16:05:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44EA230C627;
	Mon, 29 Sep 2025 16:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kRlD6K3a"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0AE82F068C;
	Mon, 29 Sep 2025 16:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759161897; cv=fail; b=XyIpf5y18/qwG8RPx3ooeSxoOJnB0VInSu+D3F4pAAE6LpIWtouLpPE+yg79Isfx7zUq6WzFiXWUNjr63VwARuK0gVbdKQg47KfHOZXgz90AzpPFaIGwUBvTPHU6mtpUPCvSanhEJz2okxzk+oC35SraJr2MUbJ53Ox80KUlcKk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759161897; c=relaxed/simple;
	bh=/4MjKQIu0dwlfi87RqAFltQEa4Y5NNGmB1L5LQvmJrY=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gACXNwlZ4vrdegiqdxGw4xvzzeExLj99ABYrPpejB6R74FlaTjCgbeoALcLVvIfHsws8op48TPpDQ3+s+rDKEWeFIkBlSaz3vkspEoit/0UE0KyoBZBk0iIMn7TLd5M49d4dCWLJ1C6aaZwPweuvt2n+NBDklU93l70Wd1fACdE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kRlD6K3a; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759161895; x=1790697895;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=/4MjKQIu0dwlfi87RqAFltQEa4Y5NNGmB1L5LQvmJrY=;
  b=kRlD6K3aFquBBctjzp8uZVtn/Z3gQRRIFR4+h21brp5U1/EsJDooWazy
   c0kZI6J7stICk/K3feOa8trFd7lls6hR0nxnaFLCrzgVsQBVsmxEQOiLP
   8PBFzmte2g1xjBUqe6nE2uzHgOXBBlXgBlAE1yQn5HBO1MGKMGdIqtx1c
   CK1nKnUMdWyDN2Qu+Zwj2/yDNAwXybjhUjSEBS5Y/LIScbxyH6Y8+h6Or
   n8uym2lpLOVGJLhUBoSGD4C0/4Pan0txYfyTi1kebRFqPvZQR1O53FlRC
   6N2ytbYobc2cAQhQ3p9MvJI5lj5TrXFsDabkKqHw8KucT2NLzJwrsW5Aq
   g==;
X-CSE-ConnectionGUID: quJ0Jz55SlGRenOkUf/CLA==
X-CSE-MsgGUID: lUq+6HSoTZmL79bOfRJoLg==
X-IronPort-AV: E=McAfee;i="6800,10657,11568"; a="65260984"
X-IronPort-AV: E=Sophos;i="6.18,301,1751266800"; 
   d="scan'208";a="65260984"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2025 09:04:54 -0700
X-CSE-ConnectionGUID: 9QXK54OcTJKTomOBnySDzQ==
X-CSE-MsgGUID: JGIRZl95QWaRWRv52/aX5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,301,1751266800"; 
   d="scan'208";a="177392480"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2025 09:04:52 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 29 Sep 2025 09:04:51 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 29 Sep 2025 09:04:51 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.34) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 29 Sep 2025 09:04:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KcGvpbngMW8JUJYNrDx6mTr7ZAoKdWwKey/lzViMSeo1jB0ORWYf37qKk1ju6HKsQIg7m3LeYe7e1xunGk2YqhvYfHTrqTWrHrKt+pj6V/hXl2HcQNCEUgMUmc5+Xul95/Ogh6S8Gc84uK483R40cUk/Y2HA07bCXBMMEZbXHlltJnziNpZnodwG65uf8rR+CzGaLsHIZmP28LBzobwy8tPoncUzghE/MPQvRO5WUqui/62+sOWCr/rcfySJ8ixtdy84xTB9ccjakMOzn9bi2zHZIQ1U465Op0jEibHgNu2sMkSngRXt6/+uBpOSy3zBbvQtlEnKJ0y9sCstqKEK6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A77zkDq/nATtWxBHCHv74Ema8kXnxGos6CDo3yF1cS8=;
 b=yT30mf+Lwfls0TC+apa/SubmFs2ydQwCDR3y5B6bz47uBmAMaYa9ivBJ1x5nh20N9M9mWvI2x2+QrzzDuhnsToz1HFCUMSybPQTyBauWi1BOZsOidwVmuK1FUxTeE3DPYuwZla2RK1kk3GMYl+fsukAsKh7ix/6Wwk77o+WOav4RqJcu9MyAQij0pP+ChUR3eIOscoNcIe5uGFUVmAsWxw363uRAPNBVc1aFMyV31TDpmpIubvBq9RAtg1aYoGrqr2aE7DIiF93WJU+ZPliMGawAD0XSiXKDp+LBhWiqEMEPUtCWTUV0/BeZUI3tykOuBBaXjHCuPLMlCU4QVUox0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 SA1PR11MB5778.namprd11.prod.outlook.com (2603:10b6:806:23f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.15; Mon, 29 Sep
 2025 16:04:44 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%4]) with mapi id 15.20.9160.015; Mon, 29 Sep 2025
 16:04:44 +0000
Date: Mon, 29 Sep 2025 18:04:36 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Bastien Curutchet <bastien.curutchet@bootlin.com>
CC: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>, Magnus Karlsson
	<magnus.karlsson@intel.com>, Jonathan Lemon <jonathan.lemon@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, "Yonghong
 Song" <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>,
	"KP Singh" <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao
 Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko
	<mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, "David S. Miller"
	<davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, "Jesper Dangaard
 Brouer" <hawk@kernel.org>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Alexis Lothore <alexis.lothore@bootlin.com>, Network Development
	<netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>, "open list:KERNEL
 SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, LKML
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next v4 04/15] selftests/bpf: test_xsk: fix memory
 leak in testapp_stats_rx_dropped()
Message-ID: <aNquFCG+/FtKAUe/@boxer>
References: <20250924-xsk-v4-0-20e57537b876@bootlin.com>
 <20250924-xsk-v4-4-20e57537b876@bootlin.com>
 <aNVEiTJywHNJeEzL@boxer>
 <fd600cd5-062e-4806-9e8e-b7f6aacad242@bootlin.com>
 <aNZ9VWLgNGHQg1Tv@boxer>
 <CAADnVQ+bBofJDfieyOYzSmSujSfJwDTQhiz3aJw7hE+4E2_iPA@mail.gmail.com>
 <4c4edfc4-f69e-43d3-8bb7-95d00bad45c5@bootlin.com>
 <aNqZsZAbqNieTkjS@boxer>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aNqZsZAbqNieTkjS@boxer>
X-ClientProxiedBy: WA0P291CA0004.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1::14) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|SA1PR11MB5778:EE_
X-MS-Office365-Filtering-Correlation-Id: 08b9ccb3-e584-4bc5-fd2c-08ddff71e7ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ckVaV3pjLzBCZUwxeTVsdktOcTBrNSswZFN2V1ZxSEJHeEpXRUdyT0hOL24w?=
 =?utf-8?B?VTQxT09JNzlBKzB1VE9UYU5icGcwRU5rNXJSeWU3alZITXNwL3NFa1BIWmxR?=
 =?utf-8?B?aEEwWlpEUlM0MExoNEE4SzRJMnBVTU5CbXNUelRUY1dCVVZQMWhiUGQyeEhu?=
 =?utf-8?B?aFR4a1A1UTRocDMvZlFkSUhmaWNsalhPZWJkTiswcEVBR21GRkNReENmTmha?=
 =?utf-8?B?VTRVNm1tNUIvNkJTMXd1UFgxbmxoUFp6aCtPL2ZBdTFpLzM4M1RzWTFVa01M?=
 =?utf-8?B?L3hTbUpWKzhMU3pvU1pBZW1JUFhIeWpLN2c2UXNsL0Ivd00waVZkNTJkL0Q2?=
 =?utf-8?B?UkFHR255SFFCNkNETVlCKzNtTTNKUEwyWk1jR3pNRUZybnBBQXdRdm1tbEZO?=
 =?utf-8?B?eEJXY1Z0ZUJEWkZCMEdIWXFDZWhXSVVRL2h5MEVhZXVrY2MzcTFjbkxFQlZF?=
 =?utf-8?B?Q3cxcFhNZytpRmFWVmRTRTNFMGF2ZmVNTittUWdrT1pzZmxxVmNCbUlvRXJk?=
 =?utf-8?B?NEFJdXBiY1J2dUdmWS9UZ2VObVROVXo0Q0JOTFJyTFZnazBkOXJVTk9BMFdo?=
 =?utf-8?B?RjVnT3ZITUdhRTA5cXc5ZDBCVkUwN1h0cUdQMTlrUUpWZkhyUUIvQnIrZUVY?=
 =?utf-8?B?TThxTVZjbm1sK0xOUUVKU0pPa25SYU5mRjNFbXFoQ3FHTFQ3eHVOR1NGM3FR?=
 =?utf-8?B?Sll0U2JBYVdCMm5yRkRmaTJnMGVpNzYzK0ZpRUdCVTlrTGdGNVNkYlFwUE5K?=
 =?utf-8?B?dy9FdU9GUndGeE4zTWl4WXBzaUwxQ0VFTVJObmpSVWd3NE53Y2hTek5rbU9n?=
 =?utf-8?B?cW9RSHNTaVovaG5TamVaZ3VoY3JCaDR5MFdHbnNxUXBpeTZBQzBuMUF1MTJV?=
 =?utf-8?B?Z2VZNTJkQVY5eW1nRTBQWFVQcFBpbmpQT0k5dUszYUZ0T1ZUM09MSm50SnNj?=
 =?utf-8?B?bTA2N2h1VnJGbldvQ0xVZ3k3TkdlcXNPdEQvRUdnemdEb2YxYnptbzRiUXBB?=
 =?utf-8?B?UjVjdVNtRFBMV1B5bFVacGxzaDA5UU1nL1Q2a3lBdHFxT204bzVOS1hRaHpS?=
 =?utf-8?B?Umt2Z1dZKytBQmlTSjFPQmZObUZ6c1FUN2p5QWZIcmh0dGZMTHFKYU11Znpp?=
 =?utf-8?B?QzZmVDVZVHFCS3NWaWMzY2FHSm4xR2kxUHpnVHdrNEU1ZmJ2ekZOdjVPUlN2?=
 =?utf-8?B?Y2JCcHpqc3E1SVBhc3VIYnJocnhsYkVjYmgxTktZTjZPcGVPaHRpMjdUTWo0?=
 =?utf-8?B?YzR4LzlwUXVzMTdIN3hoS1JOY0xGdFo4eGl0TlhaV09hWk5Cbm5aQW9QTDNu?=
 =?utf-8?B?UjdhMlYwUkxFcTRrbSs3NU85bzM2RFZzM0pFTzlrY0UwM3lDNll5bW5xN2tt?=
 =?utf-8?B?YzcyTFhxekQ0ZHpiWFRtcUN6Nm95bGhEbXRSOU9la0tpbytacUFwek1NeUhp?=
 =?utf-8?B?alZOcGZ2R0xFTW1EMDF0ZG53TFZEV3VRcXJUVVJESzB5aWpQVmttMjNENW02?=
 =?utf-8?B?Vm82MmVpVjMvaS90TFUwSStkTW9IbnhsbmdrUmN2WmFXOE90NFZPQVUwSTlR?=
 =?utf-8?B?eWlrQ0YwaWpjb0d6cHowbWExa1N0ZzhJUzA0WWJoTDJFT2NGSTF6aUZrRkZi?=
 =?utf-8?B?NWg4dE1BdHNuTnNhK2pJL2o5bU5zYVA2YU1hSy8rQXBNT1k2cUFMY0xOeVJ6?=
 =?utf-8?B?VUFXWW1oOTFtVjhKREhBS1FCSm45dnArZ1pZWHo1TGo3a0RmTis3T0I1WmpP?=
 =?utf-8?B?ZzhMN0gvbkhWZ2p4Ti9KM2NDMjdzL3g1WWlNaEtndFpnUWhqVkVzcU5hTG5F?=
 =?utf-8?B?NmdEWTZxSVZQZlVSZWJnT2s4T0hEL3NQc1QzNmVPY0NsK3gzb3lUSVV4WHV5?=
 =?utf-8?B?WWhDRyt6QnNQL1BKTVp5UTBxRmxOaklPMWJOOWtFUnFFZ0E9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RkRKNFlONkR2OXdrQkNhZ2t1S2Nra29SYTd2THQrSWNFTkNaaUc1b1lnTDVZ?=
 =?utf-8?B?Zk9leXg3Z1lwWEI2WWhrU3RGSTNRS29weElST2R1aTdZd1F0azNQWE9oWkwr?=
 =?utf-8?B?Z3I5QXFsSGRtblZ2UWV4ZldzN1Q1cFRPMjZXYmxrY2R2Zk1XYWNDQndZV04r?=
 =?utf-8?B?TURLb3ppR2dRb3hNVXgrY0dSNzVQUjByQXpRQjhZNEx6TWRyOVJadEdSZ1Rm?=
 =?utf-8?B?d3pNb3FOM25jQzB0MVIrK0lHYnZqNm5OUHpSYXMxbUg4VDV0ZEtRaXlzSU8z?=
 =?utf-8?B?SDRQSkdGMzJVRk03aEtvcisxa3FtQkkvRzFLczdaRjhzYlByWkhnc3NsWkFa?=
 =?utf-8?B?NHBpUlpRcWhxYWswa3VFUjJtWEhBUUdMdGRuSEJqbEpZNzVDNGZaUE56Y3FS?=
 =?utf-8?B?bzZEelBhc2NUUXFXbVZVRlB4djBxUXhWMzZFZDloS0NLeXpIVDMyKzlBZ3pX?=
 =?utf-8?B?U0xuRXZtM0JyQktjQlpsZ0pZemlDdGNIRGdtSlA4NmczaFNRSXRyT2JuMzVt?=
 =?utf-8?B?dTIyN2draFFNSERsUktxcUVoRjZpL1A2bXVXZmFscmdjSXFsUlhMR3htUGFi?=
 =?utf-8?B?OGNvbmo1YTg0WmhRMHp2TkN3SStpTWtPVzc4bEZIOXBWL3ZmVm1TdDRFSzNX?=
 =?utf-8?B?ajJVbFRHYTk4Mmpxb2hZYVpxUGZMOFdSSCtrVmlHME1mMjhORjZyQS91Z24v?=
 =?utf-8?B?bjdTK3JiWDluRkN5UmQ2Qk1rL3F1SkJEdmdZT1FiY21rclIwVjJzY2ZUTkU3?=
 =?utf-8?B?VXQwNDRpVlRKQlJQdHUxUUw5UDhZeFFFa0JrcVdERW5oVEY5Q1A4YnhhVGh1?=
 =?utf-8?B?Z2F2RnYyclFhOWpuWkV2bVJ4bWVzUjgyVmtMc0hWbTNrMEFHajVzbDBYSmtt?=
 =?utf-8?B?Uy80alNBZU1uMjBSODl6MDI1UWtIeENZTG1HL0poQytoTVJ4cW5scTdGbEU0?=
 =?utf-8?B?aDhHcHJEUDMyU1BVYlZJRVUzZ250ZXFHQ2NIbllFMzIyWDRrV2UzUFhHT09N?=
 =?utf-8?B?Tzk2dUFRbDMrd1ZvZGh3TVByQmJLbmxqeFhyVDJ3blltMTAwVnVQY1hRcUpB?=
 =?utf-8?B?bGd1aUE0YUs2cEhjNWFhYUtIVUtCNFF1bmxNTjdkbFBtM0F0YjVCaG1MZUlr?=
 =?utf-8?B?K1Boc3RxeHRHdklRYTNTYmNMeEJzSHcwdC81WVJuejQwSno3RkwvdVJBQ2FI?=
 =?utf-8?B?U29ILytPQ1JQSXZlQjMxVmJ1QjJBTVRiUjR6MEoraXk3YUtPblNPRmdrYUtx?=
 =?utf-8?B?bEMvS29BSDJJRXJQQ3p0cGtPWG44VTNiRGZ6YTJpYk41b3dOTzFaWWQ0V0NQ?=
 =?utf-8?B?cmNRY29uMDFZQUlmaWttbHc1a3liTWlNUDg4K1NkMkdwQzZtWmg5ak5DLzhB?=
 =?utf-8?B?Q0pzL1R5SUdWeU5JR0N6T2IwQTVMNWpBMmJraEFYbU04Q2UwSWFvbWtlQlo5?=
 =?utf-8?B?ZHpiS25TRzYyci9BeEFVY3J0VGtQT1dVQVp1M0FzRmRUdDlzanp6OE1rT0Nr?=
 =?utf-8?B?ZjczWHJXRXc5TUZmQVNLOFhsMmczUHRDMnU2WTJJZjlwK0tRNEtWdW9CWEtC?=
 =?utf-8?B?VzVyWkdTMFc3dEpkUTdvUW03TWhhcHVMcklzcXE1c294ODd6M3dvRkd2a0NE?=
 =?utf-8?B?Mm1HLzJwV0tlem96eDZVWjM2TjBBYzhheFg0TmhRVFBNcUY0UTJTMmxOUG9v?=
 =?utf-8?B?OE9BRHZFSjhDMTQ0ODFVa25hdE9qUytIZzBrUDduazhqdWYraXlielUvck5v?=
 =?utf-8?B?NjcydnhmTjg5RnU4V0c3dGFLWm84ei9kZU1GdkxpSC9tNnpxbDMzZ1MreTNa?=
 =?utf-8?B?OGxsVWkyODl3bUNXQ0pHSVZjR3FqcDNURUVoc25ZYTY5MEVOVnpNNVZxMHE0?=
 =?utf-8?B?TlVsWi9LK1VvbzQ2dHd4ZHFIN0VzU0VtbURJSEZkanozYnFGUi9xbjl5S244?=
 =?utf-8?B?MUlWdWRZWXB2cmdCTUF0SEhLLzQ4UXFLMVdSVm5TL1lUWi9FZWt6dTBQa3A3?=
 =?utf-8?B?b1B2NXdoTDdBaGV3WXRHY3ZDU3ArRDkrc1psck9DZndsbStGWVlGRE5melgz?=
 =?utf-8?B?UUJHb25EOStmNlNSRU9EdDhtRlh4RXl1TGZvdmZBeFBOSC9Id0pOYkxwOGFC?=
 =?utf-8?B?VmhWOGxweG9jZExYOERMR0NYaGdpd1IzcEQwNXhGa0NhRGc2TjQ1T0FmNFdn?=
 =?utf-8?B?Y2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 08b9ccb3-e584-4bc5-fd2c-08ddff71e7ba
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2025 16:04:44.2398
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7HQDfhrCsBYi/Lv+/yQ+a8QNKkLfJTsEYEchrZIUyShuZa1kjzVrq45eFF9i6Y5kagC8bVD/rDeg/UMbGVYdXR+6gcXvkIlJobVHgfzOUYo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5778
X-OriginatorOrg: intel.com

On Mon, Sep 29, 2025 at 04:37:37PM +0200, Maciej Fijalkowski wrote:
> On Mon, Sep 29, 2025 at 10:57:45AM +0200, Bastien Curutchet wrote:
> > On 9/27/25 1:19 PM, Alexei Starovoitov wrote:
> > > On Fri, Sep 26, 2025 at 12:47 PM Maciej Fijalkowski
> > > <maciej.fijalkowski@intel.com> wrote:
> > > > 
> > > > On Fri, Sep 26, 2025 at 08:39:28AM +0200, Bastien Curutchet wrote:
> > > > > Hi Maciej,
> > > > > 
> > > > > On 9/25/25 3:32 PM, Maciej Fijalkowski wrote:
> > > > > > On Wed, Sep 24, 2025 at 04:49:39PM +0200, Bastien Curutchet (eBPF Foundation) wrote:
> > > > > > > testapp_stats_rx_dropped() generates pkt_stream twice. The last
> > > > > > > generated is released by pkt_stream_restore_default() at the end of the
> > > > > > > test but we lose the pointer of the first pkt_stream.
> > > > > > > 
> > > > > > > Release the 'middle' pkt_stream when it's getting replaced to prevent
> > > > > > > memory leaks.
> > > > > > > 
> > > > > > > Signed-off-by: Bastien Curutchet (eBPF Foundation) <bastien.curutchet@bootlin.com>
> > > > > > > ---
> > > > > > >    tools/testing/selftests/bpf/test_xsk.c | 7 +++++++
> > > > > > >    1 file changed, 7 insertions(+)
> > > > > > > 
> > > > > > > diff --git a/tools/testing/selftests/bpf/test_xsk.c b/tools/testing/selftests/bpf/test_xsk.c
> > > > > > > index 8d7c38eb32ca3537cb019f120c3350ebd9f8c6bc..eb18288ea1e4aa1c9337d16333b7174ecaed0999 100644
> > > > > > > --- a/tools/testing/selftests/bpf/test_xsk.c
> > > > > > > +++ b/tools/testing/selftests/bpf/test_xsk.c
> > > > > > > @@ -536,6 +536,13 @@ static void pkt_stream_receive_half(struct test_spec *test)
> > > > > > >            struct pkt_stream *pkt_stream = test->ifobj_tx->xsk->pkt_stream;
> > > > > > >            u32 i;
> > > > > > > + if (test->ifobj_rx->xsk->pkt_stream != test->rx_pkt_stream_default)
> > > > > > > +         /* Packet stream has already been replaced so we have to release this one.
> > > > > > > +          * The newly created one will be freed by the restore_default() at the
> > > > > > > +          * end of the test
> > > > > > > +          */
> > > > > > > +         pkt_stream_delete(test->ifobj_rx->xsk->pkt_stream);
> > > > > > 
> > > > > > I don't see why this one is not addressed within test case
> > > > > > (testapp_stats_rx_dropped()) and other fix is (testapp_xdp_shared_umem()).
> > > > > > 
> > > > > 
> > > > > pkt_stream_receive_half() can be used by other tests. I thought it would be
> > > > 
> > > > So is pkt_stream_replace_half() and other routines that eventually call
> > > > pkt_stream_generate() and overwrite the pkt_stream, right?
> > > > 
> > > > It just feels odd to have a special treatment in one function and other
> > > > are left as-is just because currently we don't have another abusive test
> > > > case.
> > > > 
> > > > Maybe it's enough of bike-shedding here, just wanted to clarify on my POV.
> > > > 
> > > > In the end don't get me wrong here, this interface is a bit PITA for me
> > > > and thanks for whole effort!
> > > 
> > > My reading of this discussion that it doesn't block the series
> > > and can be done in the follow up if necessary.
> > > 
> > > So I was planning to apply it, but it found real bugs:
> > > 
> > > ./test_progs -t xsk
> > > [   18.066989] bpf_testmod: loading out-of-tree module taints kernel.
> > > [   32.204881] BUG: Bad page state in process test_progs  pfn:11c98b
> > > [   32.207167] page: refcount:0 mapcount:0 mapping:0000000000000000
> > > index:0x0 pfn:0x11c98b
> > > [   32.210084] flags: 0x1fffe0000000000(node=0|zone=1|lastcpupid=0x7fff)
> > > [   32.212493] raw: 01fffe0000000000 dead000000000040 ff11000123c9b000
> > > 0000000000000000
> > > [   32.218056] raw: 0000000000000000 0000000000000001 00000000ffffffff
> > > 0000000000000000
> > > [   32.220900] page dumped because: page_pool leak
> > > [   32.222636] Modules linked in: bpf_testmod(O) bpf_preload
> > > [   32.224632] CPU: 6 UID: 0 PID: 3612 Comm: test_progs Tainted: G
> > >        O        6.17.0-rc5-gfec474d29325 #6969 PREEMPT
> > > [   32.224638] Tainted: [O]=OOT_MODULE
> > > [   32.224639] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
> > > BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
> > > [   32.224641] Call Trace:
> > > [   32.224644]  <IRQ>
> > > [   32.224646]  dump_stack_lvl+0x4b/0x70
> > > [   32.224653]  bad_page.cold+0xbd/0xe0
> > > [   32.224657]  __free_frozen_pages+0x838/0x10b0
> > > [   32.224660]  ? skb_pp_cow_data+0x782/0xc30
> > > [   32.224665]  bpf_xdp_shrink_data+0x221/0x530
> > > [   32.224668]  ? skb_pp_cow_data+0x6d1/0xc30
> > > [   32.224671]  bpf_xdp_adjust_tail+0x598/0x810
> > > [   32.224673]  ? xsk_destruct_skb+0x321/0x800
> > > [   32.224678]  bpf_prog_004ac6bb21de57a7_xsk_xdp_adjust_tail+0x52/0xd6
> > > [   32.224681]  veth_xdp_rcv_skb+0x45d/0x15a0
> > > [   32.224684]  ? get_stack_info_noinstr+0x16/0xe0
> > > [   32.224688]  ? veth_set_channels+0x920/0x920
> > > [   32.224691]  ? get_stack_info+0x2f/0x80
> > > [   32.224693]  ? unwind_next_frame+0x3af/0x1df0
> > > [   32.224697]  veth_xdp_rcv.constprop.0+0x38a/0xbe0
> > > [   32.224700]  ? common_startup_64+0x13e/0x148
> > > [   32.224703]  ? veth_xdp_rcv_one+0xcd0/0xcd0
> > > [   32.224706]  ? stack_trace_save+0x84/0xa0
> > > [   32.224709]  ? stack_depot_save_flags+0x28/0x820
> > > [   32.224713]  ? __resched_curr.constprop.0+0x332/0x3b0
> > > [   32.224716]  ? timerqueue_add+0x217/0x320
> > > [   32.224719]  veth_poll+0x115/0x5e0
> > > [   32.224722]  ? veth_xdp_rcv.constprop.0+0xbe0/0xbe0
> > > [   32.224726]  ? update_load_avg+0x1cb/0x12d0
> > > [   32.224730]  ? update_cfs_group+0x121/0x2c0
> > > [   32.224733]  __napi_poll+0xa0/0x420
> > > [   32.224736]  net_rx_action+0x901/0xe90
> > > [   32.224740]  ? run_backlog_napi+0x50/0x50
> > > [   32.224743]  ? clockevents_program_event+0x1cc/0x280
> > > [   32.224746]  ? hrtimer_interrupt+0x31e/0x7c0
> > > [   32.224749]  handle_softirqs+0x151/0x430
> > > [   32.224752]  do_softirq+0x3f/0x60
> > > [   32.224755]  </IRQ>
> > > [   32.224756]  <TASK>
> > > [   32.224757]  __local_bh_enable_ip+0x58/0x60
> > > [   32.224759]  __dev_direct_xmit+0x295/0x540
> > > [   32.224762]  __xsk_generic_xmit+0x180a/0x2df0
> > > [   32.224764]  ? ___kmalloc_large_node+0xdf/0x130
> > > [   32.224767]  ? __mutex_unlock_slowpath.isra.0+0x330/0x330
> > > [   32.224770]  ? __rtnl_unlock+0x65/0xd0
> > > [   32.224773]  ? xsk_create+0x700/0x700
> > > [   32.224774]  ? netdev_run_todo+0xce/0xbe0
> > > [   32.224777]  ? _raw_spin_lock_irqsave+0x7b/0xc0
> > > [   32.224780]  xsk_sendmsg+0x365/0x770
> > > [   32.224782]  ? xsk_poll+0x640/0x640
> > > [   32.224783]  __sock_sendmsg+0xc1/0x150
> > > [   32.224787]  __sys_sendto+0x1d0/0x260
> > > [   32.224790]  ? __ia32_sys_getpeername+0xb0/0xb0
> > > [   32.224793]  ? fput+0x29/0x80
> > > [   32.224796]  ? __sys_bind+0x187/0x1c0
> > > [   32.224798]  ? __sys_bind_socket+0x90/0x90
> > > [   32.224801]  ? randomize_page+0x60/0x60
> > > [   32.224804]  ? fget+0x18e/0x230
> > > [   32.224807]  __x64_sys_sendto+0xe0/0x1b0
> > > [   32.224810]  ? fpregs_assert_state_consistent+0x57/0xe0
> > > [   32.224812]  do_syscall_64+0x46/0x180
> > > [   32.224815]  entry_SYSCALL_64_after_hwframe+0x4b/0x53
> > > 
> > > and at the end:
> > > 
> > > # ERROR: [receive_pkts] Receive loop timed out
> > > test_xsk:FAIL:Run test unexpected error: -1 (errno 12)
> > > #251/32  ns_xsk_drv/XDP_ADJUST_TAIL_SHRINK_MULTI_BUFF:FAIL
> > > #251     ns_xsk_drv:FAIL
> > > Summary: 1/67 PASSED, 0 SKIPPED, 1 FAILED
> > > 
> > > [   99.308243] page_pool_release_retry() stalled pool shutdown: id
> > > 185, 48 inflight 60 sec
> > > [  159.724173] page_pool_release_retry() stalled pool shutdown: id
> > > 185, 48 inflight 120 sec
> > > 
> > > 
> > > The test is great and the work to make it run as part of test_progs
> > > paid off big time.
> > > 
> > > But we cannot enable it by default, since it will be crashing CI VMs.
> > > 
> > > Please reproduce the above issue.
> > > You might need
> > > CONFIG_DEBUG_VM=y
> > > and other mm debug flags.
> > > 
> > 
> > I did reproduce the issue with CONFIG_DEBUG_VM=y
> > 
> > > If the fix can be done quickly let's land the fix first.
> > > If not, please respin the series, but disable the test by default
> > > until the bug is fixed.
> > 
> > I won't have much time this week to investigate this further, so I'll respin
> > the series with this test in the 'flaky table'.
> 
> I'll take a look at the splat then.

Fix is two-fold and needs to be done in generic xdp hook and in veth
itself, it is aligned with what we discussed with Jakub at
https://lore.kernel.org/netdev/20250926124010.4566617b@kernel.org/

When skb_pp_cow_data() gives us skb backed by system page pool, this needs
to be reflected on rxq.mem.type so that helpers when releasing a frag will
use correct arguments in __xdp_return().

Below is a quick and dirty diff that silenced the splat on my side, let me
think a bit how this could be polished.

diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index a3046142cb8e..cabd2dda8e58 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -791,6 +791,7 @@ static struct sk_buff *veth_xdp_rcv_skb(struct veth_rq *rq,
 					struct veth_stats *stats)
 {
 	void *orig_data, *orig_data_end;
+	struct xdp_rxq_info rxq = {};
 	struct bpf_prog *xdp_prog;
 	struct veth_xdp_buff vxbuf;
 	struct xdp_buff *xdp = &vxbuf.xdp;
@@ -811,6 +812,12 @@ static struct sk_buff *veth_xdp_rcv_skb(struct veth_rq *rq,
 		goto drop;
 	vxbuf.skb = skb;
 
+	if (skb->pp_recycle) {
+		rxq.dev = skb->dev;
+		rxq.mem.type = MEM_TYPE_PAGE_POOL;
+		xdp->rxq = &rxq;
+	}
+
 	orig_data = xdp->data;
 	orig_data_end = xdp->data_end;
 
diff --git a/net/core/dev.c b/net/core/dev.c
index 93a25d87b86b..233b2fc424db 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -5206,34 +5206,11 @@ static int enqueue_to_backlog(struct sk_buff *skb, int cpu,
 	return NET_RX_DROP;
 }
 
-static struct netdev_rx_queue *netif_get_rxqueue(struct sk_buff *skb)
-{
-	struct net_device *dev = skb->dev;
-	struct netdev_rx_queue *rxqueue;
-
-	rxqueue = dev->_rx;
-
-	if (skb_rx_queue_recorded(skb)) {
-		u16 index = skb_get_rx_queue(skb);
-
-		if (unlikely(index >= dev->real_num_rx_queues)) {
-			WARN_ONCE(dev->real_num_rx_queues > 1,
-				  "%s received packet on queue %u, but number "
-				  "of RX queues is %u\n",
-				  dev->name, index, dev->real_num_rx_queues);
-
-			return rxqueue; /* Return first rxqueue */
-		}
-		rxqueue += index;
-	}
-	return rxqueue;
-}
-
 u32 bpf_prog_run_generic_xdp(struct sk_buff *skb, struct xdp_buff *xdp,
 			     const struct bpf_prog *xdp_prog)
 {
 	void *orig_data, *orig_data_end, *hard_start;
-	struct netdev_rx_queue *rxqueue;
+	struct xdp_rxq_info rxq = {};
 	bool orig_bcast, orig_host;
 	u32 mac_len, frame_sz;
 	__be16 orig_eth_type;
@@ -5251,8 +5228,11 @@ u32 bpf_prog_run_generic_xdp(struct sk_buff *skb, struct xdp_buff *xdp,
 	frame_sz = (void *)skb_end_pointer(skb) - hard_start;
 	frame_sz += SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
 
-	rxqueue = netif_get_rxqueue(skb);
-	xdp_init_buff(xdp, frame_sz, &rxqueue->xdp_rxq);
+	rxq.dev = skb->dev;
+	rxq.mem.type = skb->pp_recycle ? MEM_TYPE_PAGE_POOL :
+					 MEM_TYPE_PAGE_SHARED;
+
+	xdp_init_buff(xdp, frame_sz, &rxq);
 	xdp_prepare_buff(xdp, hard_start, skb_headroom(skb) - mac_len,
 			 skb_headlen(skb) + mac_len, true);
 	if (skb_is_nonlinear(skb)) {

> 
> > 
> > Best regards,
> > -- 
> > Bastien Curutchet, Bootlin
> > Embedded Linux and Kernel engineering
> > https://bootlin.com
> > 

