Return-Path: <linux-kselftest+bounces-22805-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE95C9E312D
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Dec 2024 03:12:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6955B285A20
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Dec 2024 02:12:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE750224FA;
	Wed,  4 Dec 2024 02:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="JwBTYtNj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from esa12.fujitsucc.c3s2.iphmx.com (esa12.fujitsucc.c3s2.iphmx.com [216.71.156.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C2817C60;
	Wed,  4 Dec 2024 02:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.156.125
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733278346; cv=fail; b=rCiOUY/b3icRFm8X4v5XGzrdp4atjwUbp2lMfCI10EbRmBURqFwcKFoysvoLfoAKvTSiNv2rQZ4vo2BsvTs/ILaJgrbanFNvF4dFVMT/l0FjNaePlzbTu2Ocz3ckZVzfBdfIHn3bStgzY31MZ6dG8nbDizw1gDC0p2UfOhSmts4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733278346; c=relaxed/simple;
	bh=dcGKK4cvH1T/DzWlju/UjfswZKXG3cRAig2BoLXgn1A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RxoyxZtuNq64CCcs/v09hrEgoa1OjOxCo9+rsx6AcmxmxGDzTwTDj5xdPG2wKRJlXIZdvFTYuCrIKu8TfyheQ7TrSVNdWBy/S3QgETY1+FjLb3+nDy+fZkg1gMV5IwKqi8KiBtLadlmdU6Il6Fbx/yHEx5zgdI2EhMeXAXR9N0Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=JwBTYtNj; arc=fail smtp.client-ip=216.71.156.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1733278344; x=1764814344;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=dcGKK4cvH1T/DzWlju/UjfswZKXG3cRAig2BoLXgn1A=;
  b=JwBTYtNjs7RmOv90mULAvnP4FigyLM0N+4Ge9+M4rrZA79yRzetfo+lJ
   Q4nQ1zX26HLbmDq82DHuHCbVWw88XOzDL4VMo7OVhLon0iq9nW8Rdjh1r
   qoSwmXh5gXJ18L8k2xyapF67ZABqEkCpjWFoK0Ytv1bklcWm3vQlDDk5y
   s5RlrlEOXuApt2VVxeYRzZqlxFAg3RnCAeRYmMU4Ac+tHJj7BT/vl/XEI
   mCq3Up7EYW1IgYSU+OMhPDfnT1WYqvK7WudvRtK3gEhJiIJP830mPXUsV
   wjEJiX3fpFDZNpkvbtaPzvMiMGx/xPG4XxtMSkoBbgmiINxPvV8SJcK7V
   A==;
X-CSE-ConnectionGUID: C08eWFG/SymLteoxNk+tvQ==
X-CSE-MsgGUID: +MfBh347Tcyhx1iF+a5tSQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11275"; a="139161411"
X-IronPort-AV: E=Sophos;i="6.12,206,1728918000"; 
   d="scan'208";a="139161411"
Received: from mail-japaneastazlp17010002.outbound.protection.outlook.com (HELO TY3P286CU002.outbound.protection.outlook.com) ([40.93.73.2])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2024 11:11:11 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JEfOBAVDktK0SHn991Xqn2DOsSmckSoVSNq8SfHkVpD87HMo4sq1qo7mud+aUj0CeAgaR7pRBGKrvub4afmAFtqNs+tr1a4jdfVD0F35Gk/tZaC57TmUWL0sKUcs7NBfCpIEAbWbofcLgDfBy/Cev+Xkrst8AI/dA+oTtoxcZ24P82y45VCf0U/EmOHuAlICUBNMDyEdVU6vKAL3d6Ea60w+9teAq3P+phTbuqw0e/VDVrvNsqSRBfyKmjjHQ+HwZ/o7EvZFVEU0a75JORAryBmIFU15qq6hB72cY1pK60OdZAbb5U9GcxSmxlk39osdGHkTkxwBSBot6isw/jF98A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dcGKK4cvH1T/DzWlju/UjfswZKXG3cRAig2BoLXgn1A=;
 b=v4hX/RHy0h/m9V5APsxeOC3G6qBA9JiDkt3LJNcdynpXz0kHddOWqtHHNf85QNw6etooQmrpz72S1FZzJphb9nEH0cWzz3QPuzLQXqYf4W4O5uXQpgIG81zfhcW4zVWyWu2JilQOiax/o3hFrB3SGCnS5Uk18n03fNesGoh/VuM2F0FPF3LjWHQG1cSDYr/ptTaq/BXQ2aUeuTvHKDANzkjkYbfuSb5HmbIhXjKfRFHK9rxfiFVgy6Ze+wJD5tGvAcmkA8Wty2/UA6gy7WIhtxFT7VUIbYc1nEh7m07PYyfY+zMsl2vEgQcA7pVAyc7JQ1mDArIHTBYhh0kY2eHjnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com (2603:1096:403:6::12)
 by TYWPR01MB7284.jpnprd01.prod.outlook.com (2603:1096:400:ea::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.19; Wed, 4 Dec
 2024 02:11:07 +0000
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377]) by TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377%5]) with mapi id 15.20.8207.017; Wed, 4 Dec 2024
 02:11:07 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: Shuah Khan <skhan@linuxfoundation.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>
CC: "shuah@kernel.org" <shuah@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH for-next v3] selftests/zram: gitignore output file
Thread-Topic: [PATCH for-next v3] selftests/zram: gitignore output file
Thread-Index: AQHbPLL714SeDJIalUC6KloefGQuW7LVXD8AgAAN6AA=
Date: Wed, 4 Dec 2024 02:11:07 +0000
Message-ID: <79c762c6-77fc-4784-a86e-42be7977d86d@fujitsu.com>
References: <20241122074935.1583747-1-lizhijian@fujitsu.com>
 <95484cb4-b2fa-49fe-889c-03ad64e89c91@linuxfoundation.org>
In-Reply-To: <95484cb4-b2fa-49fe-889c-03ad64e89c91@linuxfoundation.org>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY1PR01MB1562:EE_|TYWPR01MB7284:EE_
x-ms-office365-filtering-correlation-id: 50800872-3c90-4e03-521e-08dd1408ea0e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|38070700018|1580799027;
x-microsoft-antispam-message-info:
 =?utf-8?B?Ykp1TkVoU1c3Vk5JdUY3WW00MkJrSzRNVktlMUo0RWtnc2dyeWJTNkVHYkcy?=
 =?utf-8?B?WnhmekJZbTVVejZMb0hXcllSY096Q3I0TytKc09IMDRpZmVMbHFveFlwMHJG?=
 =?utf-8?B?bkVJdVplT3FNblhSSFlYSW9lZ3pCV3pXTytMM21Fc3IvS0ZOR1N1OVltT0g2?=
 =?utf-8?B?dW9GVUFaYk1QaVQvSUxVVVBYa2JoMERLTWVOTXB3SEpkTzhRY0lSUmpEckZ6?=
 =?utf-8?B?U1pnN1pPNnkwazYrOENWRDBNMWtNaDhKVExHbHBhcEJEclI0TXhvdzNiZmQz?=
 =?utf-8?B?VzlBY0o5NU9YVGdYc1RMcWRYQjc3YkMwS1dsTTVoRmVMdzBPK1duTFZKaDZw?=
 =?utf-8?B?ZHlrRlZkNHFvSkNxK2ZFbGJ1QjFVNXpjdlRWZ2JRdnVwakwyNXIyVEg4UUls?=
 =?utf-8?B?WFZ5YVluZXJucnpPY3REYjRtaG5ZT3pNMlFONGxxd3B4c2d0TEY2YUxlaVI2?=
 =?utf-8?B?Q0laaWVzYWNMZWU1cFNKUFJzT0tpR1kwNkhDai9wZkhla1FUNzl0MVlNMWZh?=
 =?utf-8?B?K1Z0NHIzOHZlM29TRjQ3UGJ3eklKL0hmbW0wUDBFSnBLSWppOWQ1UTlLVEV1?=
 =?utf-8?B?Mlo5ZXZKT0Z6MW1pbi9UUE1leEFHaFJZLzgxeU95TzAzR055cTh5NEljQXlk?=
 =?utf-8?B?MmNOZlBsZzd3TTRNbjNScklncGk3L1o2NENSRkNjUmsxSmJUUUVHZmtQaG1S?=
 =?utf-8?B?WXBaSFJnTXAxZ2V0Uld1eG5acmJsNEZnbDRmc0dWZVZNdmtaT2VOY2lVRlFJ?=
 =?utf-8?B?WnBiT2w0VUkraGpSNXJGdXlkbUtCbjMrUzAvRHRCZnIrY3JENlFJUVBjb2xy?=
 =?utf-8?B?dkxkMFZtb1FBTXF1TnZvU2hzRERCVVp2dzJJRFJrekwyenVna21VOXpRaHc2?=
 =?utf-8?B?NnRDQ1V2b1NxUHhlL29pZk1qd1J1Nm1aaXJLRlEwZFFqRlpkNFBRRVlvdVUx?=
 =?utf-8?B?SGg5MUxGYzFzUU44amwvWFRDTEJwTDdNUEdSTjc4S04vU3lCWnRuOTByK3c5?=
 =?utf-8?B?VmhQdDhaT1NadzVLTkNmN3JMSjJwUy9BUkhlTENjQnQ1N0g2ZDhyTlpiRi9Y?=
 =?utf-8?B?VWZnemdETkxUazVsdkJWS1dvemxwc0RQTlM5NGg0VkdLYTM5bjdBcHExTEhH?=
 =?utf-8?B?d0wrMzFZVlF2eTd1ajgrcTBBd0Y2S2ozNnJqYlQ0cHNQR0ozUFBOUmtYdXdP?=
 =?utf-8?B?dzlhcktwR1NKSzNQbTgyb1Azajc2bkE5enFPRlRlZlhmZ043WFZxdGFuUzgv?=
 =?utf-8?B?My9QeldHU0VqZnlSL1pNUncxOTMraTNPaWZ4YkxRYUpXTjh6RjRiQitZTUky?=
 =?utf-8?B?KzlnbU14T0cwcUZ0YXkzaG1xVDNYdjZqZ2Q2WkpsTC9CYWVQN0U2WmFFeHlj?=
 =?utf-8?B?cnBGdHlFU2JtZ2NHblZ5SnlwN3hLTkplQ3E5ejBKSEVVUTMwWjZFdWNnVHhz?=
 =?utf-8?B?dDNaalFub2wwQS9uZkhtemo4ZmtyVjdZT0FqazZVWVA1aFl3UkQ4VXpUVmZG?=
 =?utf-8?B?M1gxeGprSVNJcVAybFhFV1Q1VUsrYjlQYTZpZ2YzWVRuazNBeXNkSTVOdzYy?=
 =?utf-8?B?VUdYZGlsaE5RZVBZMTVBNUZ2czFCdmVTOWw3UjBvWXpUcUtxanJkbkRVQU1H?=
 =?utf-8?B?ejJPelFZdTUxRkFqZW5DYVV6SE0vbU4rN2s4Q2VGNm9GM2dCcHMvczBScGZ3?=
 =?utf-8?B?aWtkVy9hSlRjNHE3eFAvQi84eldQbGVoSFZidzNvTEgzR0EwNnpIYStFelRO?=
 =?utf-8?B?ZmlQZm5WVWJDeHRJZU9IeERkUy9UZUJPZnZpb0RPNWlxUVcvTk1JMlE1VGNa?=
 =?utf-8?B?MEtLQWZUMUhQeUxkQ2dMZjZSRTVIVzBnQWVMdm9JVWlNWitsOERHbzMybU5W?=
 =?utf-8?B?VWdEaHVVQkxNTWFBVTRkVUxnNUhBL25IbVQwbldVdnhGbnFvRlQ3bTVKcmh5?=
 =?utf-8?Q?aH2Zgo7bG3TV+U8lO6unRQmZ8dOOeh/O?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY1PR01MB1562.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018)(1580799027);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?b2VDQ3BCWHc0Qk1hWXdnSDRJUFFCanpIZlB5Sm5HTktqUVdYeVg2T0w2MFNX?=
 =?utf-8?B?MUdrMFc2bDFDNXBTMDg1QTZiTDBKZmlaV3k0Ry9XVUJaSFZLOGpyeXlsSDFC?=
 =?utf-8?B?bEIyR3ZkUmZFc3VwQWk5N3kxZEFBVktqdEhvVDgva0tJYnlPQmRwdHFaUmpv?=
 =?utf-8?B?bDd6T1VkdlpUT2RkVnE5VmZmTk54RWlDelcxRnNiTDJKTGl6Ulc1Slh1b2Q5?=
 =?utf-8?B?V0ptTmFMUFFEQ2FnMkFFbXFVbkZmSUMxSTdSR0hWaGRTYXFhQ3EvNUR0bTJw?=
 =?utf-8?B?YVVoUUxwd0VHKzN1L2NBNjRscXpTanNuemhGc1ZGVnRmREVGSGc1dHBkQzRT?=
 =?utf-8?B?SGYvaXVkakJ2czVXdllYV2xYOGxtVzl2d0RVQ2FGTzVjVnFWVVZtZFJLeXI2?=
 =?utf-8?B?d1l2WFF3V2dqQlAyM09pcmNMZ0J3bWY4N0ZZR3dWdEdGYWMzYWlzSFlFeXdv?=
 =?utf-8?B?VWJacmRBdFpjL2szQ0ZKTkJGTVdUOWN4NSs5NFM5WkRaV05Kck9wK3prZTlL?=
 =?utf-8?B?dmZuaFRJTVUwK0krd2hSa3pTRGFWUUd1V2F2bkxwN2p0MmIwWEhaY1ptditX?=
 =?utf-8?B?cUlJT255ZXJjSkVyVVBvT0QzVklQTjZ2dmNTYzE5L1N3dFJjTjJtRlVmbDlE?=
 =?utf-8?B?QWk0ZHIxM2tWN3JQT3FDTy8zY3E2TXVXWDZRemYwN0JqUXpYaktSQ0dBQ1A3?=
 =?utf-8?B?REdhTDM1Q2U1MFBwcjk2ZldmRDRZbW9RV2ZkcUJuNm0wanNQWldBanlCMzZ0?=
 =?utf-8?B?Tlc0Q2sxbUJzV09TMXZzK0tnTU9WVjREeWdLMFhZbEdOdG5aS0JpTHVoV0Fs?=
 =?utf-8?B?TjV0cjBPNUh4endDbFBEYXJDS0FHTERJMkRtZWFKZHNQLzZMQlM5OUc4MDcv?=
 =?utf-8?B?K01CZ1ZySm5oSFJmSFJlblRvQXBWZnFROWpuamhZQzA4WnFHUitUT1gvclZz?=
 =?utf-8?B?dkdUVU9XUjVXQTNlL3lqQWVoNlJ6TGg0SlljZHpGRGdrK045YzFGZzN4T29C?=
 =?utf-8?B?cVFCNWV3RTZyYzlnZVFNYzZ6RCtCZ3o0OW9Vb1l0OFN6bTlaVUlpVk5ZT3BK?=
 =?utf-8?B?WHBRZnRVcFVrekttdmU3T0FEbW5NeHNycVovbzVObjZVRUhpQXFrVVdJeXBU?=
 =?utf-8?B?bGpkcHU1TFhGcU1PRWlEYnNWMFJJUlNESS95ZUpubTd0VFNNcEhVSDFaRENJ?=
 =?utf-8?B?N2Y5bHNMTlowSzVrcTNpWG9TUmlpaWV4aEExVkNTbDJPRDB5WXYvTFNWSnpL?=
 =?utf-8?B?eDVtN2V6U3ZBM0VUNThJQ0NqYzRhT2gzai9KeVFWelR5Q0VGN1NJSjVOVjE4?=
 =?utf-8?B?K2c3Z1E4aXdZUU5ZV1Iwb0NJaGJlcThkanQ3djZkZnU5OVcwVDJyeU95RGt0?=
 =?utf-8?B?NFBLeXNvZnN0aXJybWIxTVFoSmdNbU51MXdyc2hXRkNWNWJvcVRjOW1YSjZU?=
 =?utf-8?B?VWtGNnJLaW9nMkpNcjVka1FiU29oTG9SSVBvdzVZOGQ3TGNPSWxFa0U2YThC?=
 =?utf-8?B?RXQzU2Y4bm1YYTBHdVdrbW96UmI3QzlDdTVhTDU3VEFXQnF0MEVUR04yQnNw?=
 =?utf-8?B?c1B6Y1Q4QXVKdUk1TnZ6TVpwOHNLamZVWVpvWlluK1N5djJpWGNBempJWTVB?=
 =?utf-8?B?NEpjOHcyTmIvcnFTbDkyb0g2UXBmY1JRM1F2QmpwbHdiSmtaZUtWcU1NOXNN?=
 =?utf-8?B?MHlOWUliZUJqaWM4REhqMm42WnRxQ0FORW1ldm1ZdjF2dVFqa2RISzFKT201?=
 =?utf-8?B?NkQwV3luZ28xNUdQQnFzcUlzMHQreU5pUEpaUm1BMTg2blJhVzZTM3VFUHdI?=
 =?utf-8?B?RFM4UlNVK3lidGo0aVk3a3VYTWFmcFNUU0NtQmhQdHhpaUpySlRaNi80K1cr?=
 =?utf-8?B?NjdtdFVINHBEZ3UrNnl5WjlKdFR2SVlmbjFEcEVTcW9UQXlkeTRXT3dvV2dX?=
 =?utf-8?B?U0VXaVJ5T3pRd1JHSkdkSTFabEc0VWRVaGVraVMwQjBoMkE4d2RKSUFrVCtw?=
 =?utf-8?B?aWhTZjI5U1FrNk4xRmltQjE5M0NaTERVcllyRU5QdXlIVFlGdkZmVjJ1cXBD?=
 =?utf-8?B?NTlYV3drdmtqcWwrRGdZb1U1NzFXck80a2xJZTI0c0NJRHZOa05qNDR5SXV4?=
 =?utf-8?B?eXFuU0lMeVZucHNkeE1VSGYydEhySnJ0d0hFeEY1QjFGeHVkYzQ2NWxrWUJs?=
 =?utf-8?B?TGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A28DEDC53025F3439B11F5AF6131DA33@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	deuDOL7WF2VCSvg/tr+qKf9rYvaQffPyTCW00FBIeYLwK0g6Pgpn0X2qkCMAcfvg69N9p6Rm2ZeNAGy2pJK1OdYBvYtY5H9SwFSkZ7NqUbKtm0W+O8mGNq9kaqHYKvSIo6DSHpk+ItcZc+FDaUp618zLLou1Lb+MWK+04+EMYxjvTRMx5xtzrHV7k71PFLxbvw2pa10gVuC2WsKWRoqXqaplAO9DFAiXtPvNVVOoH57W6imuXvoa3QuO7uk2t1l/hYLF76XE9MQadZW0f+7jB9w/HD5eYXu11AmKg8hJMolBW+z7w8nWUkxxn1yABbxLHFFglR/grSKgzRExuF9VjpHtjRNw/V8ZkpC2h9s8RxK9O+znV/m6433gzfvMSQtkhQTEA71SkCzLo7PuNY8/x7EeV7NwOU5evR2sXoySNNXHKvzsIldr3CG7cQZpYE9hg6yCogLavUm2KD1rknO+Y5D4IC+BuuFvG8BBB+8k6GQAOPwXTJIgo5lE7gmQUVqPypTI1YbkqoWqozrV0qpqmZudCGUkSffjhmiS12kezkEdlDKJWLDoi1olkKlEBIu3f0UQTzG9WQSHESTeV16iqYzjWBz2Vdwla3VRUEOmpiuCnGzxbCm5tAo1GHRITaFr
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB1562.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50800872-3c90-4e03-521e-08dd1408ea0e
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2024 02:11:07.5230
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wJ4t2R3qGMylDEBc0iVvEazH3Xin27IbjSSMIeiCDjJV+XtM8e23lKFvTYse58dy66VZAniRSQC5SN5fR3FGow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB7284

DQoNCk9uIDA0LzEyLzIwMjQgMDk6MjEsIFNodWFoIEtoYW4gd3JvdGU6DQo+IE9uIDExLzIyLzI0
IDAwOjQ5LCBMaSBaaGlqaWFuIHdyb3RlOg0KPj4gQWZ0ZXIgYG1ha2UgcnVuX3Rlc3RzYCwgdGhl
IGdpdCBzdGF0dXMgY29tcGxhaW5zOg0KPj4gVW50cmFja2VkIGZpbGVzOg0KPj4gwqDCoMKgwqAg
KHVzZSAiZ2l0IGFkZCA8ZmlsZT4uLi4iIHRvIGluY2x1ZGUgaW4gd2hhdCB3aWxsIGJlIGNvbW1p
dHRlZCkNCj4+IMKgwqDCoMKgwqDCoMKgwqAgenJhbS9lcnIubG9nDQo+Pg0KPj4gVGhpcyBmaWxl
IHdpbGwgYmUgY2xlYW5lZCB1cCB3aGVuIGV4ZWN1dGUgJ21ha2UgY2xlYW4nDQo+Pg0KPj4gQ2M6
IFNodWFoIEtoYW4gPHNodWFoQGtlcm5lbC5vcmc+DQo+PiBTaWduZWQtb2ZmLWJ5OiBMaSBaaGlq
aWFuIDxsaXpoaWppYW5AZnVqaXRzdS5jb20+DQo+PiAtLS0NCj4+IEhlbGxvLA0KPj4gQ292ZXIg
bGV0dGVyIGlzIGhlcmUuDQo+Pg0KPj4gVGhpcyBwYXRjaCBzZXQgYWltcyB0byBtYWtlICdnaXQg
c3RhdHVzJyBjbGVhciBhZnRlciAnbWFrZScgYW5kICdtYWtlDQo+PiBydW5fdGVzdHMnIGZvciBr
c2VsZnRlc3RzLg0KPj4gLS0tDQo+PiBWMzoNCj4+IMKgwqAgQWRkIENvcHlyaWdodCBkZXNjcmlw
dGlvbg0KPj4gVjI6DQo+PiDCoMKgwqAgc3BsaXQgYXMgYSBzZXBhcmF0ZSBwYXRjaCBmcm9tIGEg
c21hbGwgb25lIFswXQ0KPj4gwqDCoMKgIFswXSBodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51
eC1rc2VsZnRlc3QvMjAyNDEwMTUwMTA4MTcuNDUzNTM5LTEtbGl6aGlqaWFuQGZ1aml0c3UuY29t
Lw0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IExpIFpoaWppYW4gPGxpemhpamlhbkBmdWppdHN1LmNv
bT4NCj4+IC0tLQ0KPj4gwqAgdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvenJhbS8uZ2l0aWdub3Jl
IHwgMiArKw0KPj4gwqAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKQ0KPj4gwqAgY3Jl
YXRlIG1vZGUgMTAwNjQ0IHRvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3pyYW0vLmdpdGlnbm9yZQ0K
Pj4NCj4+IGRpZmYgLS1naXQgYS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy96cmFtLy5naXRpZ25v
cmUgYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy96cmFtLy5naXRpZ25vcmUNCj4+IG5ldyBmaWxl
IG1vZGUgMTAwNjQ0DQo+PiBpbmRleCAwMDAwMDAwMDAwMDAuLjA4OGNkOWJhZDg3YQ0KPj4gLS0t
IC9kZXYvbnVsbA0KPj4gKysrIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvenJhbS8uZ2l0aWdu
b3JlDQo+PiBAQCAtMCwwICsxLDIgQEANCj4+ICsjIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBH
UEwtMi4wLW9ubHkNCj4+ICtlcnIubG9nDQo+IA0KPiBUaGlzIGRvZXNuJ3Qgc291bmQgcmlnaHQu
IGVyci5sb2cgaXMgYSBnZW5lcmF0ZWQgZmlsZQ0KPiB3aGVuIHRoZSB0ZXN0IHJ1bnMuDQoNCg0K
SUlVQywgZ2VuZXJhbGx5LCB0aGVyZSBhcmUgMiB3YXlzIHRvIGhhbmRsZSBmaWxlcyBnZW5lcmF0
ZWQgYnkgdGhlIHRlc3RzDQotIDEuIGNsZWFuL3JlbW92ZSBpdCBpZiBpdCdzIGEgdGVtcG9yYXJ5
IGZpbGUgYmVmb3JlIHRoZSB0ZXN0IGV4aXRzLg0KLSAyLiBhZGQgaXQgdG8gdGhlIGdpdGlnbm9y
ZSBpZiBpdCdzIHRoZSB0ZXN0IHJlc3VsdCBvciBsb2cgdGhhdCBuZWVkcyB0byBiZSByZWZlcnJl
ZCB0byBsYXRlci4NCg0KSW4gdGhpcyB6cmFtIGNhc2UsIGl0IHNlZW1zIGl0IGludGVuZGVkIHRv
IGxvZyBhbmQgcHJpbnQgdGhlIGVycm9yDQpvbmx5IGlmIHNvbWUgY29tbWFuZHMgZ2V0IHNvbWV0
aGluZyB3cm9uZy4NCg0KQW5kIHRoaXMgZmlsZSBoYXZlIGJlZW4gYWxyZWFkeSB0cmFja2VkIGlu
IHRoZSBNYWtlZmlsZQ0KdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvenJhbS9NYWtlZmlsZTpFWFRS
QV9DTEVBTiA6PSBlcnIubG9nDQoNCkdpdmVuIHRoYXQgSSBhbHNvIHRoaW5rIGl0J3MgZmluZSB0
byBhZGQgaXQgdG8gZ2l0aWdub3JlLg0KDQoNClRoYW5rcw0KWmhpamlhbg0KDQo+IA0KPiB0aGFu
a3MsDQo+IC0tIFNodWFoDQo+IA==

