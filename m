Return-Path: <linux-kselftest+bounces-20891-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C0179B40BD
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Oct 2024 04:05:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 002531F2327A
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Oct 2024 03:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9ADE1F76B2;
	Tue, 29 Oct 2024 03:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="uECGJCSE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from esa20.fujitsucc.c3s2.iphmx.com (esa20.fujitsucc.c3s2.iphmx.com [216.71.158.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C52D1149C4F;
	Tue, 29 Oct 2024 03:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.158.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730171105; cv=fail; b=Qj9Vd4oTagp4WcOtfZotVYG91edWsBI3uFMvZ3trhk+OLaR534I6xb93LTs/mqOL76mlHldhzsHOdGzItORtvMAilvrIxqvflxRSbGeER3UCbNMPM9OXNBmwD9b5cLmIzTcckdgKpeBDInl6r4fLKJ1imaoDINEZtMVamAE3+NY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730171105; c=relaxed/simple;
	bh=lAmqpsIbYaode4iUGhTH730xUiGHfj3hvs1FE5BnzNg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=skgapFoIkv7y47/7zq4EsfgVgCCFQpYwZJDS7IbVlohMmf5P1U4iaf+uYjVMYqHfibsrm8c4szcinDNLEOEGlXiK41y/LRmyCxpZL9NewWIVBfwjaharAne0Gk0+TRJqVC/xuztUqJpRd1G8xh/cCojK/9gpYtqFe2XmjGkcNuw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=uECGJCSE; arc=fail smtp.client-ip=216.71.158.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1730171104; x=1761707104;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=lAmqpsIbYaode4iUGhTH730xUiGHfj3hvs1FE5BnzNg=;
  b=uECGJCSEEVms6syZF1ondjJdZmS42t/UjWVWG1bfNCgwdJU1J/qmQR8v
   qBAhhTRQ+rdDKrLbTsxjVDIWv6cQXz/vRoryPWTCXXGwCGxNBB94sMmUc
   +r6OYJPfE4csa7vo3PsB39TT+Mevc6Uf/Vp8YiOt+lIruEAx/OrnSeuGY
   f5CF/4bLMyeUlNqvEyoo+fZ/9xzJQCp9SJQ/ydxVssHp464+y7aw2TssX
   IYgGYKV6JPOEm4UniGYB7PJg26zK6PNNj2aW2zgSpA43YFqb1JJBl3Xy8
   /2Vo5VJZ/rVIA0ZvJlJl8eTwg0cKmN+D71lwf/LzIdTcBkqJ/Q4E6xHyw
   A==;
X-CSE-ConnectionGUID: aag7gY8ZQZSQSlqvpaIDGg==
X-CSE-MsgGUID: EKLd8U7ARiG2Vp4l2lKXIA==
X-IronPort-AV: E=McAfee;i="6700,10204,11239"; a="134907894"
X-IronPort-AV: E=Sophos;i="6.11,240,1725289200"; 
   d="scan'208";a="134907894"
Received: from mail-japaneastazlp17011029.outbound.protection.outlook.com (HELO TYVP286CU001.outbound.protection.outlook.com) ([40.93.73.29])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2024 12:03:50 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kgy9G+DEKU0m38upiKyyCyqvHTFX/lclH28li3R4lyprIUUwK52roW6dIkXhZjMCcadu1M8BNMX+jmPTo02N001x6WoKGYxcSB/+HNME85xNC88JAdbv+shcQeMySf+DTzXdRJgiD/rHUESefbXjz4K93Mt4uuJL5ISFZ4BiY81hPIjzSXPTVYRKqmdbBo9veDvG5Ls2p1RI64Dva1l4bf3zVHrvAJilgivWSX8tGA24tF4F8HYh3GdimCk9gHP9n1aXcl/eHVQySWMDFscvtei23aWhlBJGTRCWSuFIDYuUAFA8x8Ajjl9Tal3Lv2b/elpKYI7fAU7hiLJI1rwmmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lAmqpsIbYaode4iUGhTH730xUiGHfj3hvs1FE5BnzNg=;
 b=KIHAbF96xzRAgcHCK3qhSrPZ9JCXpbGjTBn+HwGjql/mfItep7sjVKudMgfS4Es2qGHaf/c209BpcfXa9yDI5AS7Uf4K8Yri2IYmY1dqNDpt2ROf358Vw7Zt5zdDP+5+ZU5RxgrUO6874XlOE3JagsJ+4mBtWtKj8s+ZO8bHnh8MnsTJIPXVwzytlNHxWZ3EnXqzDvOyHz30MXpOXIy2CuhfMRI0LKjfVhFYxu+HYg3RVkpIbai3ZcMP5wZcRWRb1dNkm8OiF2yTu8emt6cMYMSC14F4HRFKkWKuiHUfiQojRpw+Sjj2WOZaXVfo4ms8b7zAmwsQHEaNOAiEp88E1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com (2603:1096:403:6::12)
 by OS0PR01MB6002.jpnprd01.prod.outlook.com (2603:1096:604:cf::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.28; Tue, 29 Oct
 2024 03:03:45 +0000
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377]) by TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377%7]) with mapi id 15.20.8093.027; Tue, 29 Oct 2024
 03:03:45 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: Shuah Khan <skhan@linuxfoundation.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>
CC: "shuah@kernel.org" <shuah@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH for-next 1/3] selftests/watchdog: add count parameter for
 watchdog-test
Thread-Topic: [PATCH for-next 1/3] selftests/watchdog: add count parameter for
 watchdog-test
Thread-Index:
 AQHbJn6pWUq1FBNyBUCuyGcWUIOetrKZwW0AgAGYNoCAACyDAIAACTkAgAAZB4CAAAPMAIAAAq4AgAADOICAAAVaAIAAAdoAgAADVgCAAUnSgIAACt+A
Date: Tue, 29 Oct 2024 03:03:45 +0000
Message-ID: <74d0434d-ca97-489a-a4e3-a4220e040345@fujitsu.com>
References: <20241025013933.6516-1-lizhijian@fujitsu.com>
 <c2cae7a7-1a0d-48ef-9b8f-8d2436532ea7@linuxfoundation.org>
 <0861d73d-4fd9-4118-91c8-5a619c7d7ca0@fujitsu.com>
 <e907e67d-9116-4dd2-9b61-f93191737de6@linuxfoundation.org>
 <b7b3deec-47fd-43e4-a9b5-7099e3c00623@fujitsu.com>
 <54cbf018-eba1-4227-b464-78bfa41fa4ae@linuxfoundation.org>
 <3ee0d14a-7f6b-4ef4-9349-d6b0f14ba9e8@fujitsu.com>
 <f10e8a78-3b50-4212-9b5d-ba99a3421379@linuxfoundation.org>
 <6862e399-b169-4ffb-b9c6-904f99d96e56@fujitsu.com>
 <19579b1c-0a9b-4c72-be00-44871dd37b9a@linuxfoundation.org>
 <a6a5d13b-c550-4a99-9a84-b28e8314ccd1@fujitsu.com>
 <e0bf1824-c476-490c-b63c-0789dabd788b@linuxfoundation.org>
 <3d36bb3c-07b8-43b3-a5ef-fe63b65429ce@linuxfoundation.org>
In-Reply-To: <3d36bb3c-07b8-43b3-a5ef-fe63b65429ce@linuxfoundation.org>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY1PR01MB1562:EE_|OS0PR01MB6002:EE_
x-ms-office365-filtering-correlation-id: d4845869-b07b-4e36-1b37-08dcf7c64d64
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|1580799027|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Tk82V2cwT1J4a0RnSGlxMHY2aXcxOS9lejNXUGhKTDZEWEpIWXBSaGFTbUhq?=
 =?utf-8?B?V0h4SHRUV3hta09rdVdlMDgyYmh2MUdKdHdOMU5mZE9CQTNiTFR2bFRYRTVq?=
 =?utf-8?B?SmJwTENxRW92SzBuVlZjSXQra09WcFdRNmQ3TE56eVdDUnpNV291ZWFuZHhO?=
 =?utf-8?B?V296UnY0T0l0OUNMZWd3TG9vMFEvdnpvNXFmeW96WVM0bnJqcUNYbm5YckJw?=
 =?utf-8?B?WmR3U3ZyMU4veEpjSWpURkNOSjFtRGtrS05uRFRXWG4wSXpEVzFBYkR2S1hs?=
 =?utf-8?B?bHlGcXZWa0RvQWkvc0xrU2RWeDNxTDhTUlk1R1BNUkkzS0NtQ2dCbjBoY0s3?=
 =?utf-8?B?SkpLQmhnamY1QzkzMFJJS3VPYzVVc1pBeHF3ME1sR3NOTnFkWnJGenJpTzF6?=
 =?utf-8?B?WUxkTEF2V1gzb0tMV1pjb3oxaWd6MDhCajlZOFhVRmpQYTBNQzFQekJ6bXc5?=
 =?utf-8?B?b2VJZktxWnNTT1c0MC80WkZUa09ZWTl3YjdJQ3ZnSVdZYVZDMThIaGRCeDZi?=
 =?utf-8?B?elh4N0tTcENwNVdNQ3NjYjJ0MFRnUkxVbXhtcm4xVUg4amQwQWxPNlFjak9D?=
 =?utf-8?B?NHJEM2hlOUhpUWd4ZmN2SWlNVHpGUTZOZmZ0Q21tQS85dDIvQSsxZ2grdnVa?=
 =?utf-8?B?eU9OVWc2QU5DaEl0aFpVVDBFVStUdFBoVjQ4MzlKREkzbEVZSTd6Nyt0UmNP?=
 =?utf-8?B?WjNHNitsV1AzODZFdVMrQnZtVGE5NUVNeU9MQ1ZJRG9sVG5mVHFGNEpOM1Bl?=
 =?utf-8?B?aWR4U091TWNQTW1OeTNuWUxoOXVoM0lFUnZ3UnNGNWNlZTg4ZXh0cFNuS00r?=
 =?utf-8?B?Nkw2cG9nUW5jVnUvKzVOSDVQMWRGSmk4K0laRjY0MiszOVFkc09QTVUwSTNp?=
 =?utf-8?B?OURwNm1MTlNPdVd2NS8rWnJlckJrK1MrVklvalNIVmJlTVl3Y2RhcnBpcTQy?=
 =?utf-8?B?cGVSaVBjREJpQ2c0a3ZXMEs4S25XL3VJc3B2dXptZXZQZHpLcGMxVU5XU3Qr?=
 =?utf-8?B?eWdoMnF5WExuV0JOMkp3S0toZ09NcUVRdkVkYjNwRW94bkJXOURPZnNqVDJQ?=
 =?utf-8?B?VTlxQXlXTEozbmVKd1hTRDlNNkNoNDc5UUR1OUFsYVFtbnVkZGV3L3orZ3l1?=
 =?utf-8?B?SGIydmVuc0RuYkhlT1dtVDZzWlVGTHdSL3hYT1E2SlJuNW1kcjBWNGlBR2tP?=
 =?utf-8?B?Ylo3eU5Lb2MzU0N6VitMQXN4cTRSVHd2V2Q1MzNuZmFlMHZkalpabjdXaHRz?=
 =?utf-8?B?UGEzaFpERFNTTDQ3WlY0bkxLSTUyL3dsRjFkSHVzZVB0OE1rdG51T2Z0dWd2?=
 =?utf-8?B?RnNuTEpMNzJMNys5TWMvd2dnK2NGTGdrVURjeldxdG5kZG1UU2ZtLzRrUHFn?=
 =?utf-8?B?Ykd0V2pvTXdzRi9pOGNaTkR0YitVSzZYSTN5RUZvTWN1bjExNmhPdzZjcnZV?=
 =?utf-8?B?Z3JrUUp0cC9XaStIeGt1OWxPZ1pockg4MXJISG5GL2VHYnluS1RwdkhJMmNL?=
 =?utf-8?B?YTNZN2d0bUNubG9lNEVDSWQyL3hEbmJHdU8rcVBXa0lzaTRXekFUQXgvaEhn?=
 =?utf-8?B?ekJvVHdzOW1pNGxPbmtwTHRoT3k1MFJibmhMYkFKZ2ZMdGVwOXAxNVdzTGcz?=
 =?utf-8?B?eWR4aFBxOTRBN1JZVVkyTUVyazZCM1hQUFR0UVdISmp4dUVLaGNzRVFPZ01j?=
 =?utf-8?B?cGM2c2ZNMVZsVkhWK3JSakNmQThOTURLdWRzSUh4dkh0OHFNNVZxWndHS09S?=
 =?utf-8?B?VWhsZVU0WUQrbTVPQlNNY2REV0JESTlQTHlwRktoWUw5MHpnQ2pYdStsUkNS?=
 =?utf-8?B?UTBSYzlldmR4U0NRbzJROEdWa1UvRXNUY2pMZ3lrUXZXUmhXMkFpdlNCU2pI?=
 =?utf-8?B?UEZEODhnZUJxYWh2ZWZWQk1Xd2hxTFYrUGViM24wbUZ1NEE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY1PR01MB1562.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(1580799027)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WHNRWm9iL214c1Y1RjZ2M09YRjByV1JZL09VTEJKVHhRT3NTUGlud2RNN0Qx?=
 =?utf-8?B?eG80NmRzKzY0eHYrNFR2Q3g2aURKeDRWUGZJaDBudzlTUXJsSDdiOWhLSmpp?=
 =?utf-8?B?ZDlJZVk5STZDWEdTV1pwYjExOG5UbU5TZWpRcWVTYndqQnpEYVZLSU11UUVV?=
 =?utf-8?B?SGNmaWJ6ZzFRN1Y1V0JreG9lY2RrYU9zc3hta1NYN3ArTkIrRGN4aTFLSThQ?=
 =?utf-8?B?Z1NWNVR0S0RidkZDbHN6MFJOdFl3ekpoWGF6bi85NVRhamtLMVBGR21CZnZs?=
 =?utf-8?B?T21PdEpCVk5lK0dDV3R1OCtyd1FTSVVMUGRqMW5RV1YwWkNKNTl6VnFBRUM2?=
 =?utf-8?B?UHc3ZkQzTEswZlVtQ2NzRmJ3cnc4bHZsbnU4L2oveGM2MkZHQjdwOGx6ZHU0?=
 =?utf-8?B?djQyaGUxdTNMRnJuR0MxeStIVHduVDZWWnE5enl4UEx0Z2pCeXYweU43UE1o?=
 =?utf-8?B?cnBkYTV2amtXdWxMNTU1MUtiVnJyNFZPb0tVMm5Ia3g2NTQ3ZUhxZjRVZW04?=
 =?utf-8?B?emQ1blFVV1NKV2UrRFluYXQveWpaQ3lPbEU3K0VPOGhJN1hFSkVhMjRvVzhB?=
 =?utf-8?B?V0VvZG5PQ3R2RkFsZHY5S0ZXa3VMMm5JYXlzdUd2YXhSOFJtK0srR0tsV09m?=
 =?utf-8?B?SjBoKy9Xd2ZLM1Z6d3l0NEZNY1pvVlJhV3ZFZDFaOEFOcC94MnQ4Q2tQT2tX?=
 =?utf-8?B?Njk2VVJqZkRGRWoyMGZMT2tqSkx6aHBPVUV1SWRyMG5zUmVXWDh6TTBBWHpO?=
 =?utf-8?B?V0RaOFk0UXBwRnVvMm8vcnowM0Q5V3g1VFpkNjN0ekdnTjJ4d1NMNmZtS3l1?=
 =?utf-8?B?aDhnRlhwS1VpVXIwcC83cVIxRTU4eDRqQlVheEhpc1V6ZUVlK0wrdGIwR3Ix?=
 =?utf-8?B?TkQ4dUV2d0pObmgzb0s1L3dPUDVSWG5GckQ4OWxzWjAxL0VYRmpXZHNKcitw?=
 =?utf-8?B?dm55WWtnbElsVUtQMS9pSHp6bHhQMzV5VFlnM2o1MmxLNmM2RnBjN2JjS04y?=
 =?utf-8?B?L1B4N2hTUEI0NGs2Q3A0eitwMkpSTFVIUTZsb1FpcDlPNlYxWGNKS0NmU2ZM?=
 =?utf-8?B?SVV5a3BFeWZ6aVVyK2FpMHJ5akgyM1lOVnRCZU9NSXd1cEVrUUVsU2ozWkg3?=
 =?utf-8?B?cE9MRTB6L0lZd0RMNHN5S1FZZEJrZ3BpeGNYWXZYOG5FTno0Tlg2ZlBQWWhN?=
 =?utf-8?B?eXFlVHpkaVkxNE0wNFhzRS9QL09lTWRCVHFWU09PeVBMQW0xcVhYalR3Q0Nj?=
 =?utf-8?B?eitLRnhnVElOdkpxYVBnM0lER25EMjBuZDBXQVl3NnVWV3hpV1o1b3BvcFkw?=
 =?utf-8?B?b2c2MkJ3Z0JSenhvTW90SmtwM2JHa2s0WjUwU1NuTHg3MFBFY0ZFREQwdzNX?=
 =?utf-8?B?am1zZXB5TVgzTWpqY2ZQUlJmTnU1WlQzUVNnTFpNU2FhQ0c5SmNoNzhSYzVS?=
 =?utf-8?B?NWM2Mm1OZ3ZvRFEwMHJZdXRhdEE4VkhmckxHK0ZCSWNiOEQ1ZXpxUTF5Vk9o?=
 =?utf-8?B?SEJwenRhWE1zRlFYd0Nnei9xdUJRcmttWVlkdlFYS1dLbmNyN3NnYUk0cTlO?=
 =?utf-8?B?ZDIvRnd0eXJ6RS9YTHV3UUpHVHlwbkYyQ1FXTzZvZmIvaFlydmppbHI2ekRU?=
 =?utf-8?B?RjlYT3B4VFNJL3I5SXo4ZXlNR0F0QW1LZDV3TWNldjEyYkd0U2labnBYL3NG?=
 =?utf-8?B?LzVzYzNvTWZGblhCL1ZDZHZEenIwSThIdithSkUrbTdGcldQdmpFVnBoWnQy?=
 =?utf-8?B?aUgwbW9OK1k3Zi81REJsMmJ2K1lGK25OS1N0WU1HRSsvOXdjck9TM3dTVjFC?=
 =?utf-8?B?Tll2QmxLMnB2Qk5HekJrNTM0TjZvd3gxRmFPOVhHY25XVkFqRm1xZWh4RkNL?=
 =?utf-8?B?VDVVa2M1dTA5Z2svSkVLV3RpQmZWOGdvLzU1Y01wZ0RyQzZQUVkxd2d0Q0Z3?=
 =?utf-8?B?K2xoeXdUN0lQSitzakx0WEtvUmZEeHFTNDgzNGdIUk4wRHplbVpidnM0cFZu?=
 =?utf-8?B?a2F3YkFDYzUrRHJmcnJFV3AxRmFBWTJvdWFyUVAxVjhab2gvaUJIMEhmdEZZ?=
 =?utf-8?B?RXJxR2RIY3dTNS9MMHVyT0tubWRCaDd0czdCZk0yZnVobW95T1NWVGlCTS9j?=
 =?utf-8?B?Zy9LZTk3NFI0bmwxeGxjVGxTNkJXSnJxRkwrb1NvTlF5eVN6QVEwV1dFZDVx?=
 =?utf-8?B?MEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F7F84E382C2BA24E82126393B5065E38@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	uBRgA9SxaeHs+6b0kB8p8LUdAP566jaJPFiLPvu0Smbj2JDtQNUUUNLcMsWARFu5UXAsDf1HYlbOKSM6iH51cnLE/ovAWbHHxuYdju7jAXTsEb2PpvJN5PLQu/stusmw5bggBrvMr125PFEarBwMNmm/y0VaFHZxvptD6ao/jFVQTJgaFkeE3jru7v0OtwGCp21WHpy6Rst6qSflSY0WrfYjB7bgoL3WLzSlqGvchPfFt/RuGq6mK1uc3S+nCA8nkrdTjfxeJj0tZJqgNje1hYQcZ7R+pg/jOgGiNC8bT24mXPtFY/PXkAelvPv/+QF1wOYRGAhuvgwgwZVaWuOUfC2cTc3oHFNGtG/XanULRRB1fHc/Him4XoodEOkDTrJlzTG3svRJQ/qet2QNu5wXSPF1+sukjv174J4QPXh0BpFtP4oX2/05TSLE8bJfSScOFv1qOuC7rqsRa6DoGMMYsE48F4ib3bSSUgQwZTAp8WiwwX0/dsl3ca5x9Hw6+iajZ9WrciilRY2x0WHAZev7YdwONBB03OOzagsoSrSyzfhkabLZZtj9uIzz6aIbI+N3Ky5EAFcUTVCHlvMc6ij+kca7oMbyaDrcGmhc2GnUajr4P6DRidlanztyiwa3AaHo
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB1562.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4845869-b07b-4e36-1b37-08dcf7c64d64
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2024 03:03:45.3712
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tBaNm3ZXyHF++PwWjY1Alj4imSnwvKeycHpTShhDvEm+1m58p2CrWkE4XFpgZF7EwOlGjC4gEH8eLHvz5tBGIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS0PR01MB6002

DQoNCk9uIDI5LzEwLzIwMjQgMTA6MjQsIFNodWFoIEtoYW4gd3JvdGU6DQo+IE9uIDEwLzI4LzI0
IDAwOjQ0LCBTaHVhaCBLaGFuIHdyb3RlOg0KPj4gT24gMTAvMjgvMjQgMDA6MzIsIFpoaWppYW4g
TGkgKEZ1aml0c3UpIHdyb3RlOg0KPj4+DQo+Pj4NCj4+PiBPbiAyOC8xMC8yMDI0IDE0OjI1LCBT
aHVhaCBLaGFuIHdyb3RlOg0KPj4+PiBPbiAxMC8yOC8yNCAwMDowNiwgWmhpamlhbiBMaSAoRnVq
aXRzdSkgd3JvdGU6DQo+Pj4+PiBsaW51eC90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy93YXRjaGRv
ZyMgbWFrZSBydW5fdGVzdHMNCj4+Pj4+IFRBUCB2ZXJzaW9uIDEzDQo+Pj4+PiAxLi4xDQo+Pj4+
PiAjIHRpbWVvdXQgc2V0IHRvIDQ1DQo+Pj4+PiAjIHNlbGZ0ZXN0czogd2F0Y2hkb2c6IHdhdGNo
ZG9nLXRlc3QNCj4+Pj4+ICMgV2F0Y2hkb2cgVGlja2luZyBBd2F5IQ0KPj4+Pj4gIyAuLi4uLi4u
Li4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4jDQo+Pj4+PiBub3Qgb2sgMSBz
ZWxmdGVzdHM6IHdhdGNoZG9nOiB3YXRjaGRvZy10ZXN0ICMgVElNRU9VVCA0NSBzZWNvbmRzDQo+
Pj4+Pg0KPj4+Pj4NCj4+Pj4+IEFuZCBpIGdvdCB3YXJuaW5nIGluIGRtZXNnDQo+Pj4+Pg0KPj4+
Pj4gWyAxOTUzLjIyOTUxMV0gd2F0Y2hkb2c6IHdhdGNoZG9nMDogd2F0Y2hkb2cgZGlkIG5vdCBz
dG9wIQ0KPj4+Pj4NCj4+Pj4+DQo+Pj4+Pg0KPj4+Pj4NCj4+Pj4NCj4+Pj4gUnVuICJtYWtlIHJ1
bl90ZXN0cyIgdW5kZXIgc3RyYWNlIGFuZCBzZW5kIG1lIHRoZSBvdXRwdXQuDQo+Pj4NCj4+Pg0K
Pj4+IENvdWxkIHlvdSBzaGFyZSB0aGUgZXhhY3QgY29tbWFuZCwgaG93IHRvICdSdW4gIm1ha2Ug
cnVuX3Rlc3RzIiB1bmRlciBzdHJhY2UnDQo+Pj4NCj4+DQo+PiBzdHJhY2UgbWFrZSBydW5fdGVz
dHMgPiBzdHJhY2Uub3V0IDI+JjENCj4+DQo+PiBTZW5kIG1lIHN0cmFjZS5vdXQNCj4gDQo+IFRo
YW5rIHlvdSBmb3IgdGhlIHN0cmFjZSBvdXRwdXQuIGtzZWxmdGVzdCB1c2VzIGEgdGltZW91dCB0
byB0ZXJtaW5hdGUNCj4gaHVuZyB0ZXN0cyAtIHRoYXQgdGltZW91dCBpcyA0NSBzZWNvbmRzLiBX
aGVuIHlvdSBydW4gIm1ha2UgcnVuX3Rlc3RzIg0KPiB1bmRlciB3YXRjaGRvZyBkaXJlY3Rvcnks
IHlvdSBhcmUgcnVubmluZyBpbnRvIHRoaXMuDQo+IA0KPiBZZXMgeW91ciBmaXggdG8gYWRkIFNJ
R1RFUk0gaGFuZGxpbmcgbWFrZXMgc2Vuc2UuIFBsZWFzZSBhbHNvIGhhbmRsZQ0KPiBvdGhlciBz
aWduYWxzIC0gU0lHS0lMTCwgU0lHUVVJVC4NCg0KDQpVbmRlcnN0b29kLCBJIHdpbGwgdXBkYXRl
IHRoZSBwYXRjaCBzb29uLg0KDQoNClRoYW5rcw0KWmhpamlhbg0KDQo+IA0KPiBUaGFua3MgZm9y
IHRoZSBmaW5kLg0KPiANCj4gdGhhbmtzLA0KPiAtLSBTaHVhaA==

