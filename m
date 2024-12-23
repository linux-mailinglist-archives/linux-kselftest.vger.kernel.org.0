Return-Path: <linux-kselftest+bounces-23729-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 52DE89FA8DD
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Dec 2024 02:01:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C9B61885A3B
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Dec 2024 01:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70DAA746E;
	Mon, 23 Dec 2024 01:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="kab1uO3Z"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from esa11.fujitsucc.c3s2.iphmx.com (esa11.fujitsucc.c3s2.iphmx.com [216.71.156.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE5391FB4;
	Mon, 23 Dec 2024 01:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.156.121
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734915635; cv=fail; b=RUOl+XHdCtoQK3FHIEcp6CwRc4f/YvCDahbHg88oNwqy/2hO/pqn9Dta1kSxNXnD60UFTrnsERgB2VcEcDBQUjUdm84O+lluqhwPCogkHu7B8A/WqX7XOKEZAlb7VS1BDLf42QYfcdphHquvc/Oo63FbWUCoqu6SgmV2OZshXvg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734915635; c=relaxed/simple;
	bh=77/RPdRweyfXHtXh6IKQGcHBsOHM2LN/H/xDJu6l5dc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=D/6xUZIGfd6m37qQGKyZLgneX4AMPfnwTz4wDgFxxL4I1vvMEpa6EZLAwDWQvqhr133VK+n/d903LSbkWi5ebaEAOFU38U96gb1cK1GXH3z9BD9FI0hLWoxrij8GGjsG5v2KIi7urt99609+gFpP/ixQ6gPQ1f3lUndbsAQfgsc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=kab1uO3Z; arc=fail smtp.client-ip=216.71.156.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1734915633; x=1766451633;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=77/RPdRweyfXHtXh6IKQGcHBsOHM2LN/H/xDJu6l5dc=;
  b=kab1uO3ZxRTu5iJbKnzdb1+g/X8LA/Y9MVTl2QdDxSC9DywpPA2Szkpi
   yiIDaOSg9WRyvRNeaMPq9VQ2k5VYsj5n55DLDHA1VLDscylmIaIQJNYHz
   BSgViOP+/xqPu6a/ir0mrPiglY4JrxJ9+hlq3NJN1GVZDzBlz13FFVKON
   yFBdKQnn0cAr5ATFJFBp2PhiX0opFe9/3Abu1WVvGgD3yWy01cKg9AWTX
   CnI0QXPDZlZiJfyO/+Gb2gVgSJe4CeUoOFSNPblqCC+b4peKYPIvVE+hN
   WeCDMbnoJMmlEXub9D0IijWzz2wSDbJhfFzbsz/vA2xYrYpHK3gBZyv7J
   Q==;
X-CSE-ConnectionGUID: UYsLU3NeS6GVWek02AFtWA==
X-CSE-MsgGUID: qhDnaYCITjORwGxLcWgTNQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11294"; a="141890492"
X-IronPort-AV: E=Sophos;i="6.12,256,1728918000"; 
   d="scan'208";a="141890492"
Received: from mail-japaneastazlp17011029.outbound.protection.outlook.com (HELO TYVP286CU001.outbound.protection.outlook.com) ([40.93.73.29])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Dec 2024 10:00:28 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NI2yHxjr7Z0uAenGbPT5ooLGnKluMLRknKYpnLN+JrmRvSDjDtPmQJwcFQliu8dyxXYJcoKAxBVeRzm0NaYJA3ojeAKYHbWe0HBE4FVl/jtJKudK5YkQXVc+8N9niuZOhaESM0IgcZGlBIebq7HMYjZiWdMiyNxFWbeFIMsSlgY+nVX5c9hdI4LC6kefA/0/dxcVK6s+DGNcZkZWhXIGZ7mMSwlQRPOadDNUMN1mXTG898WpIjpI0SdA/DfTNhFwS06maIw9RpeL7MfhvJp1onS8lgIUccLtKjZrW6Y9ykcgUsnPYkKmW4cTr+UQ13ZQSPFONeL/LfAKvKhdWK4qUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=77/RPdRweyfXHtXh6IKQGcHBsOHM2LN/H/xDJu6l5dc=;
 b=U77b+mVBFVUxXXUwIV/g6/Lnk15XiX0aPFqYB+cblRcqdwVPKv7dtVNHIcxJsRfBc/F4aKwcSmdOyDKTI1nzMaEI9cx73Nn9dtQif0+dcM4i8QFAFALJWXsmmx0Nod3qDKyH/bYXqWMo9boVKOxpXK+MKWPectJNcCV5nxRDlO0POb5td3Fm1V+TqsixbjUM8PDYvldCgipSKQMw3iJ87OITc/2NSXKEqZ/aZSTL+SFrhjSd217M38H6MCNQRUlJMFsFKIP8KVpttV0+12a/sv6xFDA8IevGIXdwNLYuSpn8BfTIJ3dIhKkF5nB2URAJn+pHHn5CyxYpcIcwI8Emiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com (2603:1096:403:6::12)
 by OSZPR01MB9484.jpnprd01.prod.outlook.com (2603:1096:604:1d0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.20; Mon, 23 Dec
 2024 01:00:25 +0000
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377]) by TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377%4]) with mapi id 15.20.8272.013; Mon, 23 Dec 2024
 01:00:25 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: Quentin Monnet <qmo@qmon.net>, "linux-kbuild@vger.kernel.org"
	<linux-kbuild@vger.kernel.org>
CC: Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor
	<nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>, Shuah Khan <shuah@kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH RFC] Makefile: Export absolute srctree path for
 out-of-tree builds
Thread-Topic: [PATCH RFC] Makefile: Export absolute srctree path for
 out-of-tree builds
Thread-Index: AQHbUDE2YluD9d5UZ0aU7JIvatAtCbLvZMEAgAOm9AA=
Date: Mon, 23 Dec 2024 01:00:25 +0000
Message-ID: <dd2c9072-e95e-4906-a5cb-cb9ba862dd36@fujitsu.com>
References: <20241217031052.69744-1-lizhijian@fujitsu.com>
 <4e810697-dfb0-4729-a414-e5d545e61d90@qmon.net>
In-Reply-To: <4e810697-dfb0-4729-a414-e5d545e61d90@qmon.net>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY1PR01MB1562:EE_|OSZPR01MB9484:EE_
x-ms-office365-filtering-correlation-id: d00c78e8-24df-4b10-eac4-08dd22ed2f69
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|1580799027|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZEx0Qy8yTTJGYVZqaVlLNS9ZbXA1NHRPWHRzdU5RaTl3NGUydzY1ZHVVVnBD?=
 =?utf-8?B?aWdwTitIZW1QY1F6RmIxMHFMalI4WkVmK09rZUZ5T0RBL3NJZnhFNGIzNTM1?=
 =?utf-8?B?akVvdVNFMmZnUkFKL2FrcGV4WGFkNURwZ3ZGY3lyb0Y2bi8rME8yZytXVnEx?=
 =?utf-8?B?OW82cGEvQVBLdlptVzdmakZmeXNndFE0c3hjWHFMRnBmM1lSbkxEZEk3UzFM?=
 =?utf-8?B?U3dBMGFzMlIxT1l6NjAyNkZtaXBwWGQxeVVnbU5lRXpOZVJCYkVzbjR2aTF5?=
 =?utf-8?B?QkR1alQ0bGkzUktxSVR2NGtyK2p5b1lCU0V6K1h6U3VHMXhodDM3R29LWlRs?=
 =?utf-8?B?bFE3V3NYL1dSd1ByeTJ4S2JsYzVQOFl4SGxod2dra3RJVEZJNDVYTHd5aDh5?=
 =?utf-8?B?SURFSG1STE0wbW8ydy9oNUw4RDNRcEFDNkh1OW12bm9LV1Qwc3pSemM4R0Zy?=
 =?utf-8?B?RTNiNjRGbDY2dDFUOWc5WDR4RHk2WnZ3ejY1eURaakt1RFo1V2JET3JwQW94?=
 =?utf-8?B?MkJiYkhEZ0V3cHIxZ09ZTk40RWZkL3pJdjMvTDdVWGZ1S05XNDhDdzVYTVVE?=
 =?utf-8?B?NzUxUTRSYmNNSWI0WGkvaCtnTUsxS3EvK1NrUmRYMWJxSC9JbXVYY1ZhNVp2?=
 =?utf-8?B?S1BYejlpWisvOE8yQzRMNFgvQWZ6eWFSdFBkZkZwQ0RSd2t1aXFXaCtWb1hY?=
 =?utf-8?B?TFcvcnh3a0VRR3FaR3dsTitqUXpzZFo2TVhvYUI0NVVDS2NJK1dXQ091U2pw?=
 =?utf-8?B?Rnd2NVdyR2UzWFl5cjF2TmlzKzNrcFJrNG54YlhDbDgwbTB4Vy9xblJHM0Iw?=
 =?utf-8?B?T3c2d2U3NUZDYnRxdS9nbSt1ZkhqV29HWlNkZkRIdGpHdEpIMkg4aktxOHA4?=
 =?utf-8?B?Znc5Z2ZWS2VqM1g3QmdrY1dXSi9JV2dqMVNGZVlkbFB6N3lIcTBNOWMvV1FL?=
 =?utf-8?B?STYzME0rODhmQ3o4T05VdlFMRHBQSVQ2TGZDSmQ4RHd5cUZOaER3NDlFUDFw?=
 =?utf-8?B?ZkNIY3IwMmJPekdpY3ZyNGVSdzV4THV6TzFLZWUxS2huOFhCMkM1azdpekVa?=
 =?utf-8?B?aUV3YUZCZ0dPSFJFajlXZWx3V2FFc1pmdjA2dElSSHZwWkI3bUZzZTI4UTJM?=
 =?utf-8?B?azRIYVVEL1BENW1UZC9vSUY1WGhqdHEvSkJvN2ZHRDNBUXNYc2JOYWNRdyt5?=
 =?utf-8?B?VzZaWVVxaXlpa1lmM0QyUml6VXpkZUk0T1hpc0xIaEF3eElCaC9tRzFITUNT?=
 =?utf-8?B?MU9mak81aE5NRlBRU2pwLzQyTHRDcUE5N3RReE9DbzEybFBQZnBhWmdNL3Js?=
 =?utf-8?B?ZTh1RXpVbkVUdGxNUWtqaHdJL1B6RzdmeVloRXBBUklMR2xtMyt3RkJ4Wml0?=
 =?utf-8?B?WmNSeTNqem9xV3hPMk9mb1ZucXRaZTJLdVNqSUZBU3ZzZGZ5eXlhVGJJM0ZH?=
 =?utf-8?B?cEdlU2J0TCs5Q1BoK1RKSVB6NS9BNTRIYmxsLytlT3pzcmlpK1FaSktRbXJK?=
 =?utf-8?B?eG1ram1RUnZXLzlQaERTeW5FQkllSHNCSU94dFFmSjNhMlhWWmQwdlhwM3ZG?=
 =?utf-8?B?WGNMRDRGYjJMRkxEZ0E4THpxemQzb1VqdkpPVFQzQUladWxpM2ZkdmJzMGFi?=
 =?utf-8?B?bFp5YWFXWFg2QUNxRzRhZkVlL1pZZzN3NVMrL0hpN24yblBrVm9mNEY4azVT?=
 =?utf-8?B?RE1TeXRNbGVoTmRpd1pkNjcxenA4VU5xTktqemVOWm1NT2k5c3hrd21lYzZF?=
 =?utf-8?B?WGtlb1lBUzZNWjhXdm1MM3dFaFFNK3JDTHRLbW9PKy9IWUJtQ2NIOHYrbitq?=
 =?utf-8?B?K0gyOXB3eG9yUkJpTjh2TlhaNnFLQTc5azNlajhjNWlZa0FtU1RaMUt1M3I2?=
 =?utf-8?B?ck9TQU1QR3lLcTJGaHR1ZTM0VGhLK2M5RHZxTmNGZ2lKUUd2TjhBakZCMWQ1?=
 =?utf-8?B?VGZXa1c3c010Vzh0VUVzcXdFV0lNYlZOcnJNR1ZIOUo0RndsV0Rsc2loZ3JN?=
 =?utf-8?Q?S9YLJpYGUdZH0FN+3b/PxQo19dcg5w=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY1PR01MB1562.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(1580799027)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MWcwdnpXTFVjM0hhWjdOOS9JNXIrSXRzRThRK0poZmpteDZrcmpvMlh4S3M4?=
 =?utf-8?B?b3BWTnpEMVl3ZWpCdCtneEJud01zdlhTQ3dLaS9MWHZPWDVKaFNqTWUwTGNF?=
 =?utf-8?B?dU84Z294dDlTMmxpNnV3OWJKS1BkbzFIYVVwR0cwV0NwTUlUUXJwanIzRDRk?=
 =?utf-8?B?c0dSYmRxOUc4bjhVTlY5TzhTMXpra3FXZFlRbmlITm1Nb3NDNkNBYlFJYS8v?=
 =?utf-8?B?bTROcWdmN2ZyNmR5OWkwVE05K2tsREd1R05ZMlFGdk1FUmFHMGRLdTlVemtZ?=
 =?utf-8?B?RytLUDFBSVp6d3cwQUdLcWpJL3FoYUI1QXdQajhUZVJZQytiSVRsUkpzbGJv?=
 =?utf-8?B?UFY0UXBPeHB3RDlzcXpjeXFlVm5aN0FUcmZIUTBSOG1YSWg1M2poa2tuOUth?=
 =?utf-8?B?K2RCaXRwRUFUSzdQcVZiTXRaMHh6T0hHN3AyNHJQT0JicG9pWks0bEkvT254?=
 =?utf-8?B?dGxxSlZlREFveVBBTjZzcWZ4Vys2K1k1eEVCa2FJN05hbFRLWGgvdUgyaVR0?=
 =?utf-8?B?ajZ4b3NlRU9MaktMeis5eHFvZE1LaXlGamxla09IT2pRbU9BMXhNdEY5VWtz?=
 =?utf-8?B?R1kxWFU0bnhWVk1ocW8xQUZCTUZUQ2IxcFh6ejlZeHVyQW9tbEd0SWxSdGYz?=
 =?utf-8?B?ekhMZEliTzhybGpFZU9DdGhNKzUwOHlxc054UXhvN2F1akRRbXhTcmNONDh1?=
 =?utf-8?B?UENzMGJESXFhZ2s0OFhUemJRY0NtajU5Y09EUzBXU1AwaCtkTkVrQkZFZWpN?=
 =?utf-8?B?Ym9FbXRicjVkSnZRVmVES0NmRUs3TzlGQnRld0ZlRUxZYnV4YVJ3bjZySm1j?=
 =?utf-8?B?MEkzSnIzdlNndU92VU5qRkJ2SWRsRGwzT0k3Y1ZnTjlkL2RQOHkxMnU1TnFJ?=
 =?utf-8?B?Z24yellYZTJZM3diVjlISFRHaHFLZnZ0b0Fkc3BTYXZyR09kSyszb2o3UHFP?=
 =?utf-8?B?TjB0YzdzVmVyNzlENjg2K1FUWm1oTkZrajM1WTZObU8rQis4MldxQUg1dG5w?=
 =?utf-8?B?WHZaOWg3NWpyZkoxSitFNzFIK09jODdOelZXY1B1eHBOVXNGSFhreERocTR6?=
 =?utf-8?B?cWtnWTByZVlJL1lWL1pxbmphdCs5WklQK3E4WVZVK0FuZGxPNGNSWDV6YStY?=
 =?utf-8?B?MmZQdkxQZlJxSzVoVTRMK2FyMlEyMVlKQyt6YUZzYjRXK3RVMWltcStTa1ZK?=
 =?utf-8?B?WlRUTFFIMjhhV29uZEp1T2MvZTFKUkx3YUV5S0hvKzh1Zkk3NW9neUJqeDhR?=
 =?utf-8?B?bFJZWXBUYUZ3dGFiOWgwUXZybTNGWVU2RW9FenBJRU1mMlI1VGJlbXc5STZZ?=
 =?utf-8?B?MEVsbDVTQWIvNldYWXZYZ0dFK2pHbXV4Yi9nSkxaaWoxNE15ZGxZUExxVTZa?=
 =?utf-8?B?Q041QTczaDVzajV6MXV4aitHWUU2Y3JGQjkzVXN4UGk3L2VVdUI4SWtxQk9h?=
 =?utf-8?B?QllOSk5MOEh5R01KcnRNU2xEL3VYMGJOM1BQajBtVTVwZDAvL2JHMnoyb2VG?=
 =?utf-8?B?akpGdXFSaklicHVKL3dQVUMrUGxhU2tvUStkaHJxTGc5QTBoMlB4bEo4M2Rl?=
 =?utf-8?B?WDRKc0o3SjJrWkFjZzVaekZtT3kvdUNhcHl6K054SE52ZFF2alN1bnp0clBO?=
 =?utf-8?B?bE9LU0hFajYwaGdTekJ1SkRpNUt6SkFKK2pMSmFLSXJwNFVwaTRha082SnVP?=
 =?utf-8?B?UXpGc0RZWk9yRXdLZHdUdWNad3lqcDVTTWtpQWhaNjFWQTZHdXRlUEk4SnFz?=
 =?utf-8?B?Nk13RDZ6cVRpb1A2Z0VldkZpQzUvQkk1SVZpWlBuNzRyS2RQV1FjVUljNjBk?=
 =?utf-8?B?R1Y4QUx1ak44QUR0dTZqalRhcEp2YkdQRFhMdUNTSW5vYWo0TGxZaWQxV04y?=
 =?utf-8?B?MHg4YzNralVlQUxCcnhZMHZHeHp4eW1uZGNBc0tKeUpEekNDa1UxdFE2RDZP?=
 =?utf-8?B?V1RWZU9hYlBHRm1Oa2ZuMnRvZ1BFM04xZGhudzAzSzFPdG0wM2ZRbEEzNXc3?=
 =?utf-8?B?aE55MmpxbDAvVE8wK0RxWWJKcFZPdWVhOTBUaldBd01tOEsxelpZQWJBZ0hD?=
 =?utf-8?B?VDdsbW5FKzFMaC9DOFRTMjl6WGp0K3djTVluNGx5WlY2Z3ZPM3FUNWhZZkdM?=
 =?utf-8?B?S0NhL0VCQmlHT1ZTZnlWSVpXQnVIY2dLZWgwL1A1NXFwTytCUjNqQS9TODZ5?=
 =?utf-8?B?RHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F090979BCD379A4192F4042AEE16364D@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	vgpOcOO28e4w8yHDYgwt9vJBerVjsg6oMU+vOfSEbHXGdf9ntZCRydxCPajXcyq2fiHwYC2nHWPkyMWWe6en7SvL/E4dAgIxsFF7e6RaE6PJQ1/wbV3U+TLDH9cSZTmCuRwyyxsl8x1/dOZY0E+Vq5MV4A/v454O2oyQrVFEM2y5ctpfN7IU3ihF3NSr303HrtIMFXUlqeOanlVidR4W27F5hMUWuF3XME/JN0LRYI+fvs4KyTibCXWGY7S7PXWnjAG3NbjalIDqRoF5ezLupbma1Jc/Wu11wwUOl/ssX3jYUQ4wuILiJTy2InsAoOQ99lLmYdVel7YFV8YNVj++p8YdSrIVKLXH9yWqTTlzmaw/RKTsj7FgQSYxyvHb1ARSC5rSrYhWhkQ7PikY9IYNwdEk1qHUu/0Kb3I/ztxliniJ1Xh+PViZQz+As1Liex51UkNjJda/ixuQSVuBHIodd9oq/vo5ZTjIoGintqcxDRjrSRf8Kd4yP4CZK2CFYYoHL4gE2NDL6DkKVKROI0Dpz/MFbwuQ7kGAoBe32rtIs37fTfkGGSXYrGf2Xc65HVR3VaJqUgL1qPs0GenifSusVH3jvBMDYuuSnhzfl/IM1aD5ReG2jXe1A/vc7srPFwvz
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB1562.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d00c78e8-24df-4b10-eac4-08dd22ed2f69
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Dec 2024 01:00:25.4449
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: u+q3E5WiLWJGj4bhIZaHzrC1F5nUypln2pg96mC0h/dufwkQj3ww5Aq/SgNWEBRbqFB05rk8ljX+sUirHuhc1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB9484

DQoNCk9uIDIxLzEyLzIwMjQgMDE6MTQsIFF1ZW50aW4gTW9ubmV0IHdyb3RlOg0KPiAyMDI0LTEy
LTE3IDExOjEwIFVUQyswODAwIH4gTGkgWmhpamlhbiA8bGl6aGlqaWFuQGZ1aml0c3UuY29tPg0K
Pj4gRml4ZXMgYW4gaXNzdWUgd2hlcmUgb3V0LW9mLXRyZWUga3NlbGZ0ZXN0IGJ1aWxkcyBmYWls
IHdoZW4gYnVpbGRpbmcNCj4+IHRoZSBCUEYgYW5kIGJwZnRvb2xzIGNvbXBvbmVudHMuIFRoZSBm
YWlsdXJlIG9jY3VycyBiZWNhdXNlIHRoZSB0b3AtbGV2ZWwNCj4+IE1ha2VmaWxlIHBhc3NlcyBh
IHJlbGF0aXZlIHNyY3RyZWUgcGF0aCAoJy4uJykgdG8gaXRzIHN1Yi1NYWtlZmlsZXMsIHdoaWNo
DQo+PiBsZWFkcyB0byBlcnJvcnMgaW4gbG9jYXRpbmcgbmVjZXNzYXJ5IGZpbGVzLg0KPj4NCj4+
IEZvciBleGFtcGxlLCB0aGUgZm9sbG93aW5nIGVycm9yIGlzIGVuY291bnRlcmVkOg0KPj4NCj4+
IGBgYA0KPj4gJCBtYWtlIFY9MSBPPSRidWlsZC8gVEFSR0VUUz1oaWQga3NlbGZ0ZXN0LWFsbA0K
Pj4gLi4uDQo+PiBtYWtlIC1DIC4uL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzIGFsbA0KPj4gbWFr
ZVs0XTogRW50ZXJpbmcgZGlyZWN0b3J5ICcvcGF0aC90by9saW51eC90b29scy90ZXN0aW5nL3Nl
bGZ0ZXN0cy9oaWQnDQo+PiBtYWtlICAtQyAvcGF0aC90by9saW51eC90b29scy90ZXN0aW5nL3Nl
bGZ0ZXN0cy8uLi8uLi8uLi90b29scy9saWIvYnBmIE9VVFBVVD0vcGF0aC90by9saW51eC9PL2tz
ZWxmdGVzdC9oaWQvdG9vbHMvYnVpbGQvbGliYnBmLyBcDQo+PiAgICAgICAgICAgICAgRVhUUkFf
Q0ZMQUdTPSctZyAtTzAnICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBcDQo+
PiAgICAgICAgICAgICAgREVTVERJUj0vcGF0aC90by9saW51eC9PL2tzZWxmdGVzdC9oaWQvdG9v
bHMgcHJlZml4PSBhbGwgaW5zdGFsbF9oZWFkZXJzDQo+PiBtYWtlWzVdOiBFbnRlcmluZyBkaXJl
Y3RvcnkgJy9wYXRoL3RvL2xpbnV4L3Rvb2xzL2xpYi9icGYnDQo+PiAuLi4NCj4+IG1ha2VbNV06
IEVudGVyaW5nIGRpcmVjdG9yeSAnL3BhdGgvdG8vbGludXgvdG9vbHMvYnBmL2JwZnRvb2wnDQo+
PiBNYWtlZmlsZToxMjc6IC4uL3Rvb2xzL2J1aWxkL01ha2VmaWxlLmZlYXR1cmU6IE5vIHN1Y2gg
ZmlsZSBvciBkaXJlY3RvcnkNCj4+IG1ha2VbNV06ICoqKiBObyBydWxlIHRvIG1ha2UgdGFyZ2V0
ICcuLi90b29scy9idWlsZC9NYWtlZmlsZS5mZWF0dXJlJy4gIFN0b3AuDQo+PiBgYGANCj4gDQo+
IA0KPiBBbm90aGVyIGNvbmRpdGlvbiB0byByZXByb2R1Y2UgdGhlIGZhaWx1cmUgYWJvdmUgaXMg
dG8gaGF2ZSBoYXZlDQo+ICQoc3Jjcm9vdCkgaW4gdGhlIE1ha2VmaWxlIHNldCB0byAiLiIgb3Ig
Ii4uIiwgZm9yIGV4YW1wbGUgd2hlbiB5b3VyDQo+ICRidWlsZCBpcyBsb2NhdGVkIHJpZ2h0IHVu
ZGVyIHRoZSByb290IG9mIHRoZSByZXBvIFswXS4NCj4gDQo+IFswXSBodHRwczovL2dpdC5rZXJu
ZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC90b3J2YWxkcy9saW51eC5naXQvdHJlZS9N
YWtlZmlsZT9oPXY2LjEzLXJjMyNuMjczDQo+IA0KPiANCj4+IFRvIHJlc29sdmUgdGhpcywgdGhl
IHNyY3RyZWUgaXMgZXhwb3J0ZWQgYXMgYW4gYWJzb2x1dGUgcGF0aCAoYWJzX3NyY3RyZWUpDQo+
PiB3aGVuIHBlcmZvcm1pbmcgYW4gb3V0LW9mLXRyZWUgYnVpbGQuIFRoaXMgZW5zdXJlcyB0aGF0
IGFsbCBzdWItTWFrZWZpbGVzDQo+PiBoYXZlIHRoZSBjb3JyZWN0IHBhdGggdG8gdGhlIHNvdXJj
ZSB0cmVlLCBwcmV2ZW50aW5nIGRpcmVjdG9yeSByZXNvbHV0aW9uDQo+PiBlcnJvcnMuDQo+Pg0K
Pj4gU2lnbmVkLW9mZi1ieTogTGkgWmhpamlhbiA8bGl6aGlqaWFuQGZ1aml0c3UuY29tPg0KPj4g
LS0tDQo+PiBSZXF1ZXN0IGZvciBBZGRpdGlvbmFsIFRlc3RpbmcNCj4+DQo+PiBXZSB3ZWxjb21l
IGFsbCBjb250cmlidXRvcnMgYW5kIENJIHN5c3RlbXMgdG8gdGVzdCB0aGlzIGNoYW5nZSB0aG9y
b3VnaGx5Lg0KPj4gSW4gdGhlb3J5LCB0aGlzIGNoYW5nZSBzaG91bGQgbm90IGFmZmVjdCBpbi10
cmVlIGJ1aWxkcy4gSG93ZXZlciwgdG8gZW5zdXJlDQo+PiBzdGFiaWxpdHkgYW5kIGNvbXBhdGli
aWxpdHksIHdlIGVuY291cmFnZSB0ZXN0aW5nIGFjcm9zcyBkaWZmZXJlbnQNCj4+IGNvbmZpZ3Vy
YXRpb25zLg0KPj4NCj4+IFdoYXQgaGFzIGJlZW4gdGVzdGVkPw0KPj4gLSBvdXQtb2YtdHJlZSBr
ZXJuZWwgYnVpbGQNCj4+IC0gb3V0LW9mLXRyZWUga3NlbGZ0ZXN0LWFsbA0KPj4gLS0tDQo+PiAg
IE1ha2VmaWxlIHwgMyArKy0NCj4+ICAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwg
MSBkZWxldGlvbigtKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9NYWtlZmlsZSBiL01ha2VmaWxlDQo+
PiBpbmRleCBlNWI4YTg4MzJjMGMuLjM2ZTY1ODA2YmI1ZSAxMDA2NDQNCj4+IC0tLSBhL01ha2Vm
aWxlDQo+PiArKysgYi9NYWtlZmlsZQ0KPj4gQEAgLTI3NSw3ICsyNzUsOCBAQCBlbHNlIGlmZXEg
KCQoc3Jjcm9vdCkvLCQoZGlyICQoQ1VSRElSKSkpDQo+PiAgICAgICBzcmNyb290IDo9IC4uDQo+
PiAgIGVuZGlmDQo+PiAgIA0KPj4gLWV4cG9ydCBzcmN0cmVlIDo9ICQoaWYgJChLQlVJTERfRVhU
TU9EKSwkKGFic19zcmN0cmVlKSwkKHNyY3Jvb3QpKQ0KPj4gK3NyY3RyZWUgOj0gJChpZiAkKEtC
VUlMRF9FWFRNT0QpLCQoYWJzX3NyY3RyZWUpLCQoc3Jjcm9vdCkpDQo+PiArZXhwb3J0IHNyY3Ry
ZWUgOj0gJChpZiAkKGJ1aWxkaW5nX291dF9vZl9zcmN0cmVlKSwkKGFic19zcmN0cmVlKSwkKHNy
Y3RyZWUpKQ0KPj4gICANCj4+ICAgaWZkZWYgYnVpbGRpbmdfb3V0X29mX3NyY3RyZWUNCj4+ICAg
ZXhwb3J0IFZQQVRIIDo9ICQoc3Jjcm9vdCkNCj4gDQo+IA0KPiBUaGUgcGF0Y2ggZG9lcyBmaXgg
dGhlIGlzc3VlIGluIHRoZSBjYXNlIHlvdSByZXBvcnRlZC4NCj4gDQo+IE1heWJlIEknZCB3cml0
ZSB0aGUgY2hhbmdlIGRpZmZlcmVudGx5LCB0aG91Z2g7IHJhdGhlciB0aGFuIHBvdGVudGlhbGx5
DQo+IG92ZXJ3cml0aW5nICQoc3JjdHJlZSkgYmVmb3JlIGV4cG9ydGluZyBpdCwgbGV0J3MgdW5y
b2xsIHdpdGggaWZkZWYncyB0bw0KPiBtYWtlIGl0IGNsZWFyZXI/DQoNClllcywgeW91ciBjb2Rl
IGxvb2tzIGJldHRlci4NCkhvd2V2ZXIsIHRoaXMgImFic29sdXRlIHNvdXJjZSB0cmVlIiBhcHBy
b2FjaCB3YXMgbm90IGFwcHJvdmVkLjopDQoNClRoYW5rIHlvdSEhDQoNCg0KDQo+IA0KPiAJaWZk
ZWYgYnVpbGRpbmdfb3V0X29mX3NyY3RyZWUNCj4gCSAgICBzcmN0cmVlIDo9ICQoYWJzX3NyY3Ry
ZWUpDQo+IAllbHNlIGlmZGVmIEtCVUlMRF9FWFRNT0QNCj4gCSAgICBzcmN0cmVlIDo9ICQoYWJz
X3NyY3RyZWUpDQo+IAllbHNlDQo+IAkgICAgc3JjdHJlZSA6PSAkKHNyY3Jvb3QpDQo+IAllbmRp
Zg0KPiAJZXhwb3J0IHNyY3RyZWUNCj4gDQo+IChub3QgdGVzdGVkKQ0KPiANCj4gVGhhbmtzLA0K
PiBRdWVudGlu

