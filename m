Return-Path: <linux-kselftest+bounces-24543-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90B54A116CF
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Jan 2025 02:47:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FA4C1889799
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Jan 2025 01:47:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADC1F22A4F4;
	Wed, 15 Jan 2025 01:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="CfObTYks"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from esa17.fujitsucc.c3s2.iphmx.com (esa17.fujitsucc.c3s2.iphmx.com [216.71.158.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12DC6229B21;
	Wed, 15 Jan 2025 01:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.158.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736905636; cv=fail; b=fSBVBejxrbs52uU4d+zZxloK1TxCyZT+cNhClbnZB4v2eicx3EUKClOWi1FctcrxbGVVBb0TSMOhUlCC5GG9M7un3dhv9E2lOghsQRyIioOKaO14RMJthUsuvEVW8QceJspIcD7yGUaiuUNJt0kO24Ge4lTVLJhMsePAEEz+YKw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736905636; c=relaxed/simple;
	bh=yZznrEoz2wKfIzKSCkDI9noqwWrCoz6wjkboa9glblw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Zqstyih0ODQm9KerETY8TQOsGd68i2Dmq16ePbIN6y8YiJTpjqXmG5ZRjP4XrRx19UhA9DDSrw4uspSs3rYVLEnqPezxC1M8Wj54Yt9eQx0TVWA5EnELt/pUpmUGHMMgoVh7WTexzd/RNxgQ+mf9UmQKatS8tX9HTWjdh4psr08=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=CfObTYks; arc=fail smtp.client-ip=216.71.158.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1736905634; x=1768441634;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=yZznrEoz2wKfIzKSCkDI9noqwWrCoz6wjkboa9glblw=;
  b=CfObTYksikm6fVOFqYO39BB4qYM8jPC3a9dVu9q5/Hb/LfgLpwjmy/VU
   VFuvcfEsvkZ156+ol07th4FZnVRkHfKhL9f4+n9Vr6tWjBEGndGu/Aln1
   P6BJrvMAlUA3toYz1XxxvoGdgv5Kdyrnrcwvd5a7E7LKhXazVdJTIUCI3
   4wDyDNoqN0pwlc0WVCkGtjAT2lCZRHR8fkn7YfEYbQYYXj5ynyxpKu9EX
   GcBoBpaUtr2V0CgoilZCvpNj7V++0xZ+CIkwx4ufovoNtBwodvMt2iK31
   EwxVc5DjJbsQT1nQBGedUBvARQMDYggIAA6atFrN4mf+Aj4mZxedHQ9mP
   g==;
X-CSE-ConnectionGUID: NlBZR6TtSyyk8j7coLvEQQ==
X-CSE-MsgGUID: XnHNENSBT3abq7l2HBna2g==
X-IronPort-AV: E=McAfee;i="6700,10204,11315"; a="142817605"
X-IronPort-AV: E=Sophos;i="6.12,315,1728918000"; 
   d="scan'208";a="142817605"
Received: from mail-japaneastazlp17010004.outbound.protection.outlook.com (HELO TY3P286CU002.outbound.protection.outlook.com) ([40.93.73.4])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2025 10:46:01 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E6cGm48iOnGbO0EKOyqC1YAG0e7Nva+4nZ1pzNrUp2TV+5eMBWmfxW7LX4XdlnFmoY6z9FgGhtHMeN3CfO+akhr0fBEXt4NKOEM+XTHqFa6fPI4VbtVUwvdT0a9BVuim95ttFMiRAgKdc7U8SCUgxCCDs4IQJIw3kYABXV3mlLzwh+YJUNUvDYUlPap1tG7dhPawLvPQc0D22IOjssugLkkzLv94JYLJmoVgjAwNZohGcTqlGDukVzdarPE0/Jt+3C06LUgOExAFXhf7hABeL+oXrIVahV985W4NFZIP35B/XwB2SMTJjWna9PpkYRL3qk6Qra7ri2Gnzn0I75poWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yZznrEoz2wKfIzKSCkDI9noqwWrCoz6wjkboa9glblw=;
 b=AQyCIya3zx4o2yAsYvHh/RgXZ4EYoUlO7Su6o4Hr8yUmnLszSjfTNnegMWbsBjCTku6hdonztj6jhyEGco7V0RVJ2WKTKWIOwdCqdFM+I3eZleWSCxYJPU5CpPKcT1//pyU3Xpl+fsitbSsS/jzk1tk89/QitxtO51iAONjb9p7exXe5SacR7iNi0RJAanypz8JDC8NdjcTiqvqCqcc29HO0M7itCRqSFuGF9drPKdzIhHEyLf7+Liy2E6udLVuIgJfOjhm5UpjW5CNrIw1dx2v75PZt2YqsU6ZcOkmSoctxa6flPM8kKvOv/Amu1e22HPjYuE/Au8ADhoikFuZ3gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYXPR01MB1566.jpnprd01.prod.outlook.com (2603:1096:403:11::17)
 by TY4PR01MB14972.jpnprd01.prod.outlook.com (2603:1096:405:25d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.13; Wed, 15 Jan
 2025 01:45:59 +0000
Received: from TYXPR01MB1566.jpnprd01.prod.outlook.com
 ([fe80::f896:4d51:593e:6a14]) by TYXPR01MB1566.jpnprd01.prod.outlook.com
 ([fe80::f896:4d51:593e:6a14%6]) with mapi id 15.20.8335.017; Wed, 15 Jan 2025
 01:45:59 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
CC: "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	Masahiro Yamada <masahiroy@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH for-next v2] selftests/Makefile: override the srctree for
 out-of-tree builds
Thread-Topic: [PATCH for-next v2] selftests/Makefile: override the srctree for
 out-of-tree builds
Thread-Index: AQHbVRU+fkUZw6ZkpEuUZFIQ9EIqT7MW/vsAgAA1SgA=
Date: Wed, 15 Jan 2025 01:45:59 +0000
Message-ID: <ddd74a74-3415-4dd4-8cf8-718a8241cc26@fujitsu.com>
References: <20241223083342.1172756-1-lizhijian@fujitsu.com>
 <CAEf4BzYOOnR8k3WNKGKOUnfs_8VXk5Xh5J7Zrstix+bEciyCcg@mail.gmail.com>
In-Reply-To:
 <CAEf4BzYOOnR8k3WNKGKOUnfs_8VXk5Xh5J7Zrstix+bEciyCcg@mail.gmail.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYXPR01MB1566:EE_|TY4PR01MB14972:EE_
x-ms-office365-filtering-correlation-id: 13213434-d68a-4927-dfc7-08dd35065c48
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|1580799027|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?S1lRS2p5SXVZUlUvWlMrVHlKTDIvS1J2UzEwSlBwR0FkaEgzcC8xQkdFOUVZ?=
 =?utf-8?B?cS8yRWR1MUVoQ0xUczhiMkZKMHpZWVlvbmhDZU1QK1RQVDJRTTJRREpXUVZq?=
 =?utf-8?B?NFduZjNub1hWK3FZSVdNZGl3K0ZBYXlKV0NLYlFJb1I3TlZKTjlVb0wvVmtG?=
 =?utf-8?B?dy96cXlZQ2drREhpRVRWeFdJQmNWVWRUaG50RWlUQTFYS1hyaFgvTTVSVExS?=
 =?utf-8?B?KzlnaE9qZ2o3cm9zcVNaTnM4d1Zwc0pRajhCQ01xRmNYdWQxbysyRStFRUdl?=
 =?utf-8?B?MXBhNFlGMm1LOHJSelk0Q0JQbDZ4NWNIMlFQUmsyeC9Nb2ZidElrNGRrYW9I?=
 =?utf-8?B?WmFaTnhJL0thNGRCRG4wT0p1T2ZBVzJRbG1LNmlnZmlHeGdSWmMzRitWOS9u?=
 =?utf-8?B?WFJxbFJPUzFQdGVYTUR4SHRaanRkZmdXQzVkM21mSWNOTDJhZ3dRYVNScE9O?=
 =?utf-8?B?SWVlZldpcWZ3cU41bnBGNHlZdDRqS2l3emdPWXNZYWVLK0NQazVQZ25VMUdQ?=
 =?utf-8?B?Qk96VjN2REJ4QTlvK0ZBMThGMzJjN1dzenZzc0VlZXkxdTRyR2RUdWU4QW54?=
 =?utf-8?B?V2Z2NzgraEljRGdSb2h1ditjUGxxNGdrT1d6M01yUWxvRlpxY05aS1djWXV1?=
 =?utf-8?B?L1BwRGEyMnVZRUxObktPbmp0WnJ2K3RBOHhxeVRGeUZ0bmFQZ2xTeHdaeDE4?=
 =?utf-8?B?QmtBVlZPbzh5cEUzN29DQjF1cmhPek5sOHViMEo2SFhiTFVqd0xwYk5QQW1u?=
 =?utf-8?B?K1lYZ244bzFTUHMvREdhT3lDYXBzbGdoRUJLeXZZT2RLYjVaN2tvUFZTaFlI?=
 =?utf-8?B?WW5DKzhwTG9id2p0bHYzdllMcVFYYktKbzJCYU15bm5KRmRZYUlNMFlzdm9K?=
 =?utf-8?B?YzJtclo4aDd0aFZWelJpSFp0UUxUbG12MFNSN2FvSGtxdk1ndzNJdTlWaG4w?=
 =?utf-8?B?V1dSVURxNUtXdmdyRUxwcWR3b29KcG1DVTZ3eFhyQ25QdTYyaEdVWU0rSWV0?=
 =?utf-8?B?TWNRZU4wblB2d0NhNkNwTTRaNzByK01TZFNRZm10U0x2UnQ0R0RUdFJ0SEh1?=
 =?utf-8?B?c2lvaTRzcG11ZCtqV2VoN2tob2JYazQ0UnZYM0lLOElQeE04enYzS0JYdlpN?=
 =?utf-8?B?ekpKL1pJVTB1cCs2Y0R6aHVpSXk4elFWY2JpSy9NbHJBQm9RRDRCUmxpeVJu?=
 =?utf-8?B?YmN2cmhObzZqS1Y1THRpUkpVMmlOZnRORFFqVXZOM2pubGhKOGx6d1lvbTFU?=
 =?utf-8?B?cUsvVlMzOWRJZVRSR3BnbDcrdWhmWlNhb2wxSnRTZ1BGWHJGcWpiZ0l3eTlx?=
 =?utf-8?B?WWQ3M292dXVUWXEyY2taRFYrcWU0elZZaUJjZFRTK2JnRXNHRkYxUmNBZDNK?=
 =?utf-8?B?bVNVa3c0RDNrWWpBZXhkR0dLakU4WWM0NVNVV1dibzBRWGN4RUlxQ2lTK2hI?=
 =?utf-8?B?a1J4Q2wwVno3TUhiUldrTXRQTGNkZ0dzYUlSSGR4bzFGblNaWTZydUxDQ2J6?=
 =?utf-8?B?Z2laM3luaXFDeVptYmVEVmMrR3IwSUc5WUxHcnNDc3BpZzJUQVdBbTJxWUgx?=
 =?utf-8?B?c1c3eUZzWk1OWGRzekZCU0FHUWJBN0pZTWh5L3JDcFZPVVpUT290SXVDK2pV?=
 =?utf-8?B?OE12eXpRcWhBUDVxaG5IZ0Vvc3hWQXd0SzFmK3NqWUlhSkdEOHI5RmxDMDRB?=
 =?utf-8?B?QlNWRlFFeHRFME15bDFteXlWSTV6WkFQcmtuU1VqdDhJaFZPb09ocVVVenh6?=
 =?utf-8?B?d2tVd2FRUEtKWmpDQTBNTEgvczNhRkFJRExkNi9DTCtCR2YvSTFsaEViL0F5?=
 =?utf-8?B?dkZpMEhWcGQ3dW5hOG50VmlLMlQ0bXo4QkdUc2tVNmZZNHBqMDdXRnRKQWFM?=
 =?utf-8?B?QTNEQ0h6VDAvYlp4NEVzNlU2ZWlYRDNtMTFtc2wzREhFcnkzUkJydnVlcUc1?=
 =?utf-8?B?a1IzdjZ3ZGQrdVpvOFJiazVKSUpDMHVObE1CN2N0MEFmVXlTUWNxQzZwemJS?=
 =?utf-8?Q?hYMInfUnKHbkr1OL725i12ImGM/EEQ=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYXPR01MB1566.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(1580799027)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RGtzWFZ2NDVyZjBLV21veGswVERmMFFDUE1UT2tCaXdhb1ZjRXc2K3ozaUU4?=
 =?utf-8?B?NXQ5U0JlcFZSM3pIQmFsNDB5U2tuekMxTzU4dTNiK3JiMk96RjZ2MnV2cklo?=
 =?utf-8?B?OFBPbHZpNUtNTm1lVkYvMUF6eHJnMTh0R1NQOHltd2xQcEVUMXBRVUlwbUF6?=
 =?utf-8?B?UVlUQ1lRenNLck9VNW5WYnJxV2llMmp1YVpEWFhxQ3BLcWtNUU1KakRwL21R?=
 =?utf-8?B?cnQwbjZBb1UvS3pEWWIzYjU3L2hmT3FCT1RVUE1iTnB0NWYzNStHRUdxNWZF?=
 =?utf-8?B?bXozQmRVc3F4aWpSL0VONW5JL0J4SzVwd3BldFFKb0ExVkwrUDJKWjdvU2s1?=
 =?utf-8?B?TE9QNTBlS3M1WEhyVS9qOGE1bmV0M0x5MEdmaW95ZmMrRkd2R1VqNUUwVWhk?=
 =?utf-8?B?RXVlbm9EYXpvak5LY0tGREVodjJIV2UyQ3FDQ2hxUklGN2E1QW05c2lXWEtX?=
 =?utf-8?B?Zk1KUlhjUGNMekRZWkFxc3JPL1JTclQ5djJKeXVxd2dKT0VQaldnOUw0UEtU?=
 =?utf-8?B?d29reEdrYitVa2JlTmhGTGJqaVJZSnN1d0FQb0J6eEJocnRidUNiQlhJZjJS?=
 =?utf-8?B?eDlGTUFBRm9lV045Q3ZLOEtpb2RLYk1kcEkxaC8wY3B1UFpTYmMzT0VjZWI1?=
 =?utf-8?B?QTd5MUovQ3dmT3JDbzd1aUVlQ2ZhdEIrSXQ4OWV4cFFFdlNFdXJqS0NTRDB0?=
 =?utf-8?B?WG1NK1pTWEtWU2wyVW0vRnZWNnMyMUdyR21hL0llTkR2S2pmWVVTS0pZUC8z?=
 =?utf-8?B?aXFMczRkYVVwZjB0enhQeHcwVFJ4MmN3bzdpWDAyL2JmUGJJRUp6Z2p3WHZR?=
 =?utf-8?B?QmNFajRuQnBPdFo1SUlIUERxSXZzdVpzclNoYW4rVGduSnYxUkNMWkkzRS9q?=
 =?utf-8?B?SmRRNm1STHpxNXBVSnErRWlZT1J2eFJBWVQ0WFV4ejFUQ3BPSHNLRDJmWnN0?=
 =?utf-8?B?bzJMNW1xVHpwYngwT2ZxYXpYTlBEdjlCYTR0dDdTUWVOUTRiWHJkZTEyVVo5?=
 =?utf-8?B?Zms5Tkw5OEtmbllrbVRiQ1VISE9pbXpmdElUaUc2ejR6UXBDdUNSQ2NYMW1v?=
 =?utf-8?B?OTc3dnF1NUw4RG5WRlBRa2xyZEdzNGphSGJCeEpyRFkzK016YmtvT29Hb2w2?=
 =?utf-8?B?elhueERZVFVNQU1yU2dpTXFucFZkQ0lRbXE2cHk5L01DRU5uVmtoRXRxcm5S?=
 =?utf-8?B?YjBIT2xpeE5pTW1vN0pUZmhkRDZTbFFJWmNzR0ZoN2crcmVQMWRuSVJmWE1T?=
 =?utf-8?B?RzNxMnZDNDVFWE5rdmlkNjNJa2pmcWU4dzRVQTloUFczZEphem4xUFpBQkNX?=
 =?utf-8?B?Y01kc2VDcUJycS9Tb0FuaVlBUTM4NzQvcklBZ1Z0blJ3dC9QV3pzRGhEcmRu?=
 =?utf-8?B?N1hNaDhuUGduUnh3Q1RHK0tJdFh5c1BzbWRjMllPck4vaGd5alN4K3pBaVZ0?=
 =?utf-8?B?YTJ4WGsxdERzT0NDOXFTWTRueWpFMGMrNmxmb1A4RldXdzIrWExVNXNBSzM3?=
 =?utf-8?B?SDF3SGl6ME5tSTFXZ2xrNmxkUTg1M1c2Sllib0R5THorMUZGc0xFTEZ4MXlv?=
 =?utf-8?B?VXphb1FJZE9iTFkvdEo5UUtWU2JZdFVyczZGa0lKQys2K2J6TWZaMHRqRUtV?=
 =?utf-8?B?anFya0xoaU1xZ3czRmxvejBRUyszSnNINisxLzJBeWFQYTF5TFJKZko4eStN?=
 =?utf-8?B?bVFHYWlFNFM5Zml5NGVqVEcxcEN5dXl1TXdJb0FobmNSdWV5WnBGa3N4MXUz?=
 =?utf-8?B?dG51Vm5Oa1FFWWx5cGdGaG5PV3ZyQXIxOUJBMnRLN1hEUGNCZmcyYUhuR3NX?=
 =?utf-8?B?dnpkaUdBM2VtNTQ3ZTdsaXZBdEtvN2orQjRQTmdLdkNHbGd4cUdBT0R5UGM2?=
 =?utf-8?B?RXUzYkNaNlJYVFZHeCtFTVFaSCtOMm9HQzV2aWZNN1dmclUxdk9VSTJKZXd0?=
 =?utf-8?B?ekVLcmREQnVxZjBpczFMR2JNNHhCSTZLSjUvQVM0U0FlMm9pYmE3THpzeHA3?=
 =?utf-8?B?Tno1TW82YzhIR0tweU9RVWxKM2djMXhERUF0RUUwbitxSFdoQmRrYzNldHQr?=
 =?utf-8?B?SE9Gb2toRUNFOThEd1ExN0ZTVGVOQWlJTUVoeG5PSitVRFl5VFlRelRWQU9k?=
 =?utf-8?B?RHFwN3oxMXVvN3pUbTc1S3U0WC9JQnBYK0NFMnJGUmpmWTVzMWRPZ1p5dDRo?=
 =?utf-8?B?cUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F944E2C8E8208046BE36E89DF135487C@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	r1CkuODYAGG7s2Xw12oQTGQiHzcWWCN72Op055DaqbZ6SgYx/Z7J8Pmp4XS5Jk6yyI94kvvdJTgI8aKx0+u8T8qJ1o7V1mzUKpQV2PRqpmtBET8BdRpSXpYtiRfUvgkOQjfdg934sEC3awIm0dIHZaClNG4Xvp549Ec49Ln2hw7TuhUFk3fW7U+uDDdsRD6MOmVxZSZg5oTjR3VXyTtTPA5W+rg5X41ltwYu60ahqzARQEYAUpgdoXbss6a24cXMmxrSBaMEcI9aMjkKAvL+fMoENelvBH7MfxN2BrTH3cldV1QLzNiNCgolE80yZ1azeAAqGxzMFF+atU/jGD/kTt3bHCwMUwDDuG8s1gMb2lFYvu16yBLWJ1iWiJVXaJP2NeIcB+J07ysR0SgfUGAL0GurSSu0rr9uVZMyJo8gvacD8xHUUQfZe2kiIM5Kqi6gqXP4B3lyj+flsL7Xx/cfyNGwzXmu7SRDrCkGqFqZw4CogoqxiQ6o/rG8MlVmHfSgWLAQ0JQGjWGB6hrb5fKwMOk8GObIDdYsEGrsMG7eUnXpwosoc3qM9IN0mxdp8I8ZmLlcVXn660MmbZYsMzmrIvtbMQZRAcyguQZ6ZGi6aY7XJnh6o5NIT7laNYAbk2GC
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYXPR01MB1566.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13213434-d68a-4927-dfc7-08dd35065c48
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2025 01:45:59.0698
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5u4mupmh/0T3DsnzrABGTqd574/0c2Yav0J56k2TBXSKrRbCZSeoYs/xCwSMQf2LwgfZ/tLLMcMjrFFB7rr63g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB14972

SGkgQW5kcmlpDQoNCkkgYW0gZGVsaWdodGVkIHRvIGhlYXIgZnJvbSB5b3UuDQpJIHdpbGwgcmVi
YXNlIGFuZCByZXNlbnQgaXQgdG8gYnBmIHNvb24uDQoNCg0KT24gMTUvMDEvMjAyNSAwNjozNSwg
QW5kcmlpIE5ha3J5aWtvIHdyb3RlOg0KPiBPbiBNb24sIERlYyAyMywgMjAyNCBhdCAxMjozM+KA
r0FNIExpIFpoaWppYW48bGl6aGlqaWFuQGZ1aml0c3UuY29tPiAgd3JvdGU6DQo+PiBGaXhlcyBh
biBpc3N1ZSB3aGVyZSBvdXQtb2YtdHJlZSBrc2VsZnRlc3QgYnVpbGRzIGZhaWwgd2hlbiBidWls
ZGluZw0KPj4gdGhlIEJQRiBhbmQgYnBmdG9vbHMgY29tcG9uZW50cy4gVGhlIGZhaWx1cmUgb2Nj
dXJzIGJlY2F1c2UgdGhlIHRvcC1sZXZlbA0KPj4gTWFrZWZpbGUgcGFzc2VzIGEgcmVsYXRpdmUg
c3JjdHJlZSBwYXRoIHRvIGl0cyBzdWItTWFrZWZpbGVzLCB3aGljaA0KPj4gbGVhZHMgdG8gZXJy
b3JzIGluIGxvY2F0aW5nIG5lY2Vzc2FyeSBmaWxlcy4NCj4+DQo+PiBGb3IgZXhhbXBsZSwgdGhl
IGZvbGxvd2luZyBlcnJvciBpcyBlbmNvdW50ZXJlZDoNCj4+DQo+PiBgYGANCj4+ICQgbWFrZSBW
PTEgTz0kYnVpbGQvIFRBUkdFVFM9aGlkIGtzZWxmdGVzdC1hbGwNCj4+IC4uLg0KPj4gbWFrZSAt
QyAuLi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cyBhbGwNCj4+IG1ha2VbNF06IEVudGVyaW5nIGRp
cmVjdG9yeSAnL3BhdGgvdG8vbGludXgvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvaGlkJw0KPj4g
bWFrZSAgLUMvcGF0aC90by9saW51eC90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy8uLi8uLi8uLi90
b29scy9saWIvYnBmIE9VVFBVVD0vcGF0aC90by9saW51eC9PL2tzZWxmdGVzdC9oaWQvdG9vbHMv
YnVpbGQvbGliYnBmLyAgXA0KPj4gICAgICAgICAgICAgIEVYVFJBX0NGTEFHUz0nLWcgLU8wJyAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXA0KPj4gICAgICAgICAgICAgIERF
U1RESVI9L3BhdGgvdG8vbGludXgvTy9rc2VsZnRlc3QvaGlkL3Rvb2xzIHByZWZpeD0gYWxsIGlu
c3RhbGxfaGVhZGVycw0KPj4gbWFrZVs1XTogRW50ZXJpbmcgZGlyZWN0b3J5ICcvcGF0aC90by9s
aW51eC90b29scy9saWIvYnBmJw0KPj4gLi4uDQo+PiBtYWtlWzVdOiBFbnRlcmluZyBkaXJlY3Rv
cnkgJy9wYXRoL3RvL2xpbnV4L3Rvb2xzL2JwZi9icGZ0b29sJw0KPj4gTWFrZWZpbGU6MTI3OiAu
Li90b29scy9idWlsZC9NYWtlZmlsZS5mZWF0dXJlOiBObyBzdWNoIGZpbGUgb3IgZGlyZWN0b3J5
DQo+PiBtYWtlWzVdOiAqKiogTm8gcnVsZSB0byBtYWtlIHRhcmdldCAnLi4vdG9vbHMvYnVpbGQv
TWFrZWZpbGUuZmVhdHVyZScuICBTdG9wLg0KPj4gYGBgDQo+Pg0KPj4gVG8gcmVzb2x2ZSB0aGlz
LCBvdmVycmlkZSB0aGUgc3JjdHJlZSBpbiB0aGUga3NlbGZ0ZXN0cydzIHRvcCBNYWtlZmlsZQ0K
Pj4gd2hlbiBwZXJmb3JtaW5nIGFuIG91dC1vZi10cmVlIGJ1aWxkLiBUaGlzIGVuc3VyZXMgdGhh
dCBhbGwgc3ViLU1ha2VmaWxlcw0KPj4gaGF2ZSB0aGUgY29ycmVjdCBwYXRoIHRvIHRoZSBzb3Vy
Y2UgdHJlZSwgcHJldmVudGluZyBkaXJlY3RvcnkgcmVzb2x1dGlvbg0KPj4gZXJyb3JzLg0KPj4N
Cj4+IFNpZ25lZC1vZmYtYnk6IExpIFpoaWppYW48bGl6aGlqaWFuQGZ1aml0c3UuY29tPg0KPj4g
LS0tDQo+PiBDYzogTWFzYWhpcm8gWWFtYWRhPG1hc2FoaXJveUBrZXJuZWwub3JnPg0KPj4NCj4+
IFYyOg0KPj4gICAtIGhhbmRsZSBzcmN0cmVlIGluIHNlbGZ0ZXN0cyBpdHNlbGYgcmF0aGVyIHRo
YW4gdGhlIGxpbnV4JyB0b3AgTWFrZWZpbGUgIyBNYXNhaGlybyBZYW1hZGE8bWFzYWhpcm95QGtl
cm5lbC5vcmc+DQo+Pg0KPj4gVjE6aHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC8yMDI0MTIx
NzAzMTA1Mi42OTc0NC0xLWxpemhpamlhbkBmdWppdHN1LmNvbS8NCj4+IC0tLQ0KPj4gICB0b29s
cy90ZXN0aW5nL3NlbGZ0ZXN0cy9NYWtlZmlsZSB8IDggKysrKysrLS0NCj4+ICAgMSBmaWxlIGNo
YW5nZWQsIDYgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4+DQo+IElzIHRoaXMgaW50
ZW5kZWQgdG8gZ28gdGhyb3VnaCB0aGUgYnBmLW5leHQgdHJlZT8gSSBkb24ndCBzZWUgaXQgaW4N
Cj4gb3VyIHBhdGNod29ya3MsIHNvIHBsZWFzZSByZWJhc2UgYW5kIHJlc2VuZCAodW5sZXNzIHRo
aXMgd2FzIHJvdXRlZA0KPiB0aHJvdWdoIHNvbWUgb3RoZXIgdHJlZSBhbHJlYWR5KQ0KDQo=

