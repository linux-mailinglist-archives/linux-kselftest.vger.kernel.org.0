Return-Path: <linux-kselftest+bounces-20788-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 39CDF9B248C
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Oct 2024 06:46:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A17F4B20B8F
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Oct 2024 05:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38DA41885BE;
	Mon, 28 Oct 2024 05:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="EZYFwFev"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from esa17.fujitsucc.c3s2.iphmx.com (esa17.fujitsucc.c3s2.iphmx.com [216.71.158.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26C5A156F5D;
	Mon, 28 Oct 2024 05:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.158.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730094408; cv=fail; b=TFJkGFtIb5HPIXCbv6FQ0EudKM/jZi12Hm8doCoF3JvIgvrm3PFg9icYmeQrkkpKMsNfaFs5C1o9XSfKN8zdctuJPDaoV59Cw2zazcKIbvJYLtyF0sN0Eh+BisitS+HOygxifGHthkZr/PHv/2LqIzMyOhayfGWgUkIfmNrxMog=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730094408; c=relaxed/simple;
	bh=64lTQsglEQvNI0+wnfpMn6aQH0/RUQZJM65Db0Qeugs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sOq/mE0qs9V9UfLcLOTy+LdyZlptqrDhATUfvQdDpWl2vl92kFJNkWsNGGSUOQZ9DtP/3VEjeN3rwvJHS/Ndr5yUvrVmdldkR4GYaqKkGGaV7Hmnw3rMsgIi/jGGnDjVGGzDILLcOuHESBzbtq44HtRWsQwd4f+l3KsXpwkz88o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=EZYFwFev; arc=fail smtp.client-ip=216.71.158.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1730094405; x=1761630405;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=64lTQsglEQvNI0+wnfpMn6aQH0/RUQZJM65Db0Qeugs=;
  b=EZYFwFevVxF2URRnCOBDlpmW0/+zK4VdpWCmhDWRo/Igjho1IHBXi0Rs
   2Mz/g1AYUcg0hS8/GS6IXVyxEpWIorz/T/YHA8GYk40LvhmoHIs1BgOcN
   TmCAYXssHBlH7cChva0fupQh0a+dS2ewfAJIAzCea9quCaH2YiiO7Vq2W
   9nlAUfD9BNwyJJjMKFD8zEl8GNKRL9x8BUbNSW3QTsVZhBEfNEB4lUQb2
   KLENSepFxeuNBpbdBY18CZ0angH5YrepB2WEIqRQ+4JwJXBxOxl1+1cc4
   MV/7bpsu/3UxXQLDWMP+2YW6WJkcL5RwTi4GCPDY1DxoQwl1hzWHqu8OU
   A==;
X-CSE-ConnectionGUID: E/mMG8DdTdi7AcPQW29IuQ==
X-CSE-MsgGUID: v8mHWZ31QjmgFoGs6+1r8w==
X-IronPort-AV: E=McAfee;i="6700,10204,11238"; a="134908567"
X-IronPort-AV: E=Sophos;i="6.11,238,1725289200"; 
   d="scan'208";a="134908567"
Received: from mail-japanwestazlp17010005.outbound.protection.outlook.com (HELO OS0P286CU011.outbound.protection.outlook.com) ([40.93.130.5])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2024 14:45:33 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZTuRvDlIo6+s2PNjhc0Mub5yqEkmhN6KRD1YPTvtpFvfXZkz0k87omXgxYmU9Sv+PrwEMxc6cO+S2UcppXtYfpEmRvmnMUHZJLtOlU1BEP1R8iD5MrwtiLGTEvL0mAWFcVwwvpGbpw1LmoyWrD/PcbVVupguQJu6VRCB6k2LmGqY3HMHYTqoyg7cwZr+0usk6fZriv9c++iPFbDONIFMxaUGd4hFZP+RsLON1cKxzsd1XF7Y6fA3uBns7qsrCbKWE5/oX056jtNfQrMoD65itKrus16fkkIUw5drmj10kW4WyKvKDauKLfvWco+8aOawJYskU/n4lLMsNiKN02ajKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=64lTQsglEQvNI0+wnfpMn6aQH0/RUQZJM65Db0Qeugs=;
 b=l/96WWx6D9+Um17dO8dYWwkjc0hTeqI/plhoGmXY+kx1aVpa21AP9scYeoDaR+KQ5me7o7a0GUxTGUFB+uumWtGo5NWR0UEJgOJZzEdkVI554iTjwuiNsVsRoIcYfdjoRp23MddklU3Y0Wrhdu98tDwedbwOBQqU/osd3DLoFP8oa5WR5WRjwljaReyyK5I/pztcr8uXol1RT6+48QT10Yp/qgFn1Vz6k0f4SCpqjE2yI2exXtOMsfTLHFZtNGoidfe92ObfkEgTdlp5+TkLo5EWkB9bGuZXxl77VUG4NZj2h0qJEMAl7RB02iv+y6reoHLNujpD25g4aeRguB0Z4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com (2603:1096:403:6::12)
 by TY3PR01MB10238.jpnprd01.prod.outlook.com (2603:1096:400:1d8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.20; Mon, 28 Oct
 2024 05:45:30 +0000
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377]) by TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377%7]) with mapi id 15.20.8093.024; Mon, 28 Oct 2024
 05:45:29 +0000
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
 AQHbJn6pWUq1FBNyBUCuyGcWUIOetrKZwW0AgAGYNoCAACyDAIAACTkAgAAZB4CAAAPMAA==
Date: Mon, 28 Oct 2024 05:45:29 +0000
Message-ID: <3ee0d14a-7f6b-4ef4-9349-d6b0f14ba9e8@fujitsu.com>
References: <20241025013933.6516-1-lizhijian@fujitsu.com>
 <c2cae7a7-1a0d-48ef-9b8f-8d2436532ea7@linuxfoundation.org>
 <0861d73d-4fd9-4118-91c8-5a619c7d7ca0@fujitsu.com>
 <e907e67d-9116-4dd2-9b61-f93191737de6@linuxfoundation.org>
 <b7b3deec-47fd-43e4-a9b5-7099e3c00623@fujitsu.com>
 <54cbf018-eba1-4227-b464-78bfa41fa4ae@linuxfoundation.org>
In-Reply-To: <54cbf018-eba1-4227-b464-78bfa41fa4ae@linuxfoundation.org>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY1PR01MB1562:EE_|TY3PR01MB10238:EE_
x-ms-office365-filtering-correlation-id: b2d9e767-f305-456d-214a-08dcf713bb59
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|1580799027|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?c3V6c0RBSldUUU8yNFJsViszU25XRHhlOU5mcnBuR0txVE43R3Nsc0xpRjlp?=
 =?utf-8?B?NzJ6ajhSUk5sMGkzcUFjQ29LUlppdTUycVppNklJcUk5WCt4NHIwMVlJdWtJ?=
 =?utf-8?B?RDRTL0RyTzAxbkJsV1lWK0V5R3lKdWVjUG1sNGJkRXJPWlJ1cEpnVjE0Qm5o?=
 =?utf-8?B?TnF0ZUlNQ1JWbTdHUHdsRlpEeklFUUc3MHc0L2tyVTVwNTR1ZVRyeE1NQjJm?=
 =?utf-8?B?SWpkMmRRNDNKZ2RtMFpGS1RLVFNFK1Q4NUx1UTNSM3ZEUDhYUXZyV0F0eXpt?=
 =?utf-8?B?eFdlM0E0c3d4bXMxYWZjUnNtbmFPTlVmcjc2dTV3aGNYeXBSNUpFNEQzUkVj?=
 =?utf-8?B?UjJZN1htUnFlaEpJODE3dnlVSXZMaEdmLzVuVnBSRHptQWhIVUUvRHNvekor?=
 =?utf-8?B?eWt5SUY5THFoVFlBT1VPWkJiT1dKOUJ2TE9WUnllN1YwSUxkQ3JTTjNEVEFR?=
 =?utf-8?B?YmZ5aU5Xa0dIQVR2MmNYdW53M1YvRnFjUmYzaWZxLzkyamdmeGVtanhNNzBm?=
 =?utf-8?B?MFVCTG9mTTNLanJhZUlpYms0ZkZtK2M3R3pMU0NVMHoxdDVtR1daQlpNTUg0?=
 =?utf-8?B?dVpDOVlLWXREbStrRUhxb2VXK0wzSDdrMHBoVGtUalRBWWFoazdJVWdTZXVt?=
 =?utf-8?B?cE53V2xlRDk1MUtkMzVxbHRvTDJyc1ViNXNZc3dNaW1VN2N2WnU3WjJSMFNv?=
 =?utf-8?B?Y3l2VUJ4SW15UHJwV0t5Q0hIbWdCdXBiN0p4eUQzQnJvS0F6cFBaUlVIUnZB?=
 =?utf-8?B?WGpLYmNuMFlVWXlKaVZCUTB0SFo2SW11QktzN1ZpTkxDYVVuVVRhRnRLeGx5?=
 =?utf-8?B?em9zT042RUhNTG1FYTlBL0NtZVkzaUE2ZWozMHJzTG85K2pIRXpFaFpIYTNm?=
 =?utf-8?B?TlVRNHRaMnRKS1ZnNTdPOGFSK3E1ckswME5sWjA3SGJ4bDVaZUtIeThtUmQy?=
 =?utf-8?B?Z1BFc0hrc240M1JzdjVYZitCRTdacUVaRmVJeHA2cU44dERVWkUydjB2bWVR?=
 =?utf-8?B?bFRsNXk5U05kb3crS2VodUlRT0M2VFY5Q2txWFZSSk00Mmtub2E0eXpjYmEz?=
 =?utf-8?B?L2dxU25sQW5VOTA3bG5saXQ4UlF3RFVGQkJ0QkJqUjU1bEI3SFpYbUNjMGZt?=
 =?utf-8?B?MW1GaE41eGNoY3Jka1pEMkNOYjQxZDR4dSt6SXdMRkJObkc2bkVmc2kzeEpB?=
 =?utf-8?B?KysxVElWOUNKQlJJd3R6R3M3VGl4SEcrTHR6VWNUS1czVUZYYTZKVHhhU1dU?=
 =?utf-8?B?WEtPdUJsZHUvbjZjVXZOWG1RU2NUUmNTRnNIczNrNWI4M3RnMHk1V0h3cUR6?=
 =?utf-8?B?NHFRZEJYeHVFNzh6bEduTnlOQWlnekRsbXR0WXZrWkl4UFhIckE5ZEdrZzhi?=
 =?utf-8?B?clFjb3Z0RjJPbmlkTVlLYVNJd1VublkzMHpzMTV2UkxTdWVnQzI4VEJDbE81?=
 =?utf-8?B?b2N2Rko1dDVKQmVVY0xOUzY2SWJrTUFJc2xpVkxiUXhpR2FtZlE0ZU1MbDB1?=
 =?utf-8?B?U0pmQWpPMUZreTAydHY4NUt5RzFhSy8rbzRZWXQ0RW8xZnc1MzE3dmNSVktz?=
 =?utf-8?B?cTBaSW9VcUVXeEIzS0IwZUxwaXdtWWluK29yaUdkSE5IeWdESWlDOURvL3pH?=
 =?utf-8?B?VWg4ZXFLYTVDZXlaZzlnVlNYdTg0Z3BuQWRPYUx5bzZzb2IzWHBXL0ZRVks4?=
 =?utf-8?B?OHcrQUNCMjBNVGJJOE1DZ2dQY3hkbUhBSjkxamVlanVvOFIvUE1OOERkQldG?=
 =?utf-8?B?Ny8vMDVsRW9oekRFTkJneGFjTVNqeVozeGZWTUpnV3Y5eHJ0WVhMWXVzTE9r?=
 =?utf-8?B?VThDMUxRblpNR0pTU1V3aFpVcC9weXp3dW9XM1lXR1lDKytTM3Q5dDEzU3U4?=
 =?utf-8?B?dUlCSDBEQWVaZEVKVkNPbkZHU2c4R0ZZay9QR0p0M3hJSHc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY1PR01MB1562.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(1580799027)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?anE0VVBlSGRTMjZkUlVLUVpQTDYxV2RMNmlMcUlic1QwOEVtSTNnb3ZJSjFJ?=
 =?utf-8?B?NlJOMkhmclZUbTVKTU1xNG00SU5nQkpseTdoRjNwUERrcFBvVjM0LzNtbnBn?=
 =?utf-8?B?ZEN1Mzc2UEhHZndqSHNUYUxzRWdZcyttdE9malZLb2cwZW53NVRNdU5SU0dl?=
 =?utf-8?B?MG5ISVBXTHVkUk5FQ2VDY3dBNTFQelZYTWxaQ2hnMzh2NEVFY3hxNjdmaGtJ?=
 =?utf-8?B?eGJ6Mnc2bk1ibnhuNVFLL0VnZzlISUZnZFhGbUpnZVdtOHJCWVNOLzIwckpL?=
 =?utf-8?B?VDlzbnIzQWtXaWg5dkRrWjRkM05JTmRIcWk2YkdJNUhqcStZUURUMGFVNHB0?=
 =?utf-8?B?SkRIeTNpUy84WkpRR1p5SzduM2plYmxETVJPSnFrRld5YzJQT3NYcU9hQWhI?=
 =?utf-8?B?S2ROZGNSU2RabFk4RzNkYnhoeXM4VFIyZS96OHNSc0sxMGV0OE1qMWNUQU1W?=
 =?utf-8?B?b3NjYVRUVk0vZTd6Vk9PcVI3TVZjZEtXb0YzWU84S1dpemNSNmdKaDBxbU1j?=
 =?utf-8?B?VXFoRjV1OGNMYUN6K3hZUTd2c25nMTg3Nk1SY0pvVmVVUUNkSnpRZENDM2Vy?=
 =?utf-8?B?Yk0xYVpNbVFSdW5md1ZadzVIWktlOU84N1FFWndMdzdJamI0bkdzYXJOY0M0?=
 =?utf-8?B?eWRweXhkNTJ3enZrWk5rV3diK1VJY1d4bFNnOVlLNzdkN2hmMFlGTFRHOFBz?=
 =?utf-8?B?bStnNXlPN0pGN0RJUHRkTHhCVEdjNFNwMmFvaStvT20yM05DV2RPSDlQcWlo?=
 =?utf-8?B?c29oeEt3VnBLRlAvRmkyTlY5M0lTNHZhT2xzeEMwZy9DK3FFWXVSRmNub05h?=
 =?utf-8?B?Nnl5ajNuUEIydUcwOWprdktjVUMwK1JzVlgyTHBGczZHY0h5V2U3WjZyZlJ1?=
 =?utf-8?B?bDV1VSt3eVp0YzJpcGJtaUJIZzBwcldDeTVrMitVdGsvM1Y5b05jSFdoUy9J?=
 =?utf-8?B?cmZlNFYvMEs2b0pKYVBzNXBmdUY5VDNra2ROcnRmME5pUW9uVTJpc3BMZ29u?=
 =?utf-8?B?ZWUxWVovVUZtN2V0cGNtZnhJV2p3aFZTUEc3dUtXMytyVTErNFY5dll4WU9E?=
 =?utf-8?B?Q2NST1pDV0hCOFNqQkVjT1VibkcvcnI1TTV0Z0pkL21qRFhyNmNLOFlaVjMy?=
 =?utf-8?B?R3VGcTFYQy9hMkkzbk9mc2x4UTlPbzR2RnVrL2lYQlVjWmVrbWFORTJwSHcv?=
 =?utf-8?B?UkxpbWtkaHBhSFR4MUdBMzhWSFBMWFk3M0pSc2VGMlh5c3BXMXptTmY3SkJ0?=
 =?utf-8?B?dHNvdzNCYUlBRkhwNVV2Q3diZTJ3alZCNXhnWnJmekFZQ0loVHZxdzhCalRt?=
 =?utf-8?B?Tzg4Tks4NUJTbVdCNFZhZnQwajF4VWRGb2xwVHB2N3FFYlljcVFiVnhDd2Zu?=
 =?utf-8?B?MnJ4a3AyY0M5VTZqTmdHNFFib0Ivd0Vlb1JIOEFCWG90ZXpxWUFTYjhvQTV4?=
 =?utf-8?B?aWpwUEplVUszSi91NTRiK2JoQTRSeFpkSjYwWG1BaHRZN1lNYTdjWmNVWng3?=
 =?utf-8?B?Z3NyQUhDcnVYUXlQb2FvdW50QU1adVZIeGRMU3hsa3FrTkxDMEl2SndtWC9V?=
 =?utf-8?B?Ni9INGVNMTVJUEluZ0NkTERWdTBHazVURnIxY0tJWi9tRUQxV3gvTVZNb2w2?=
 =?utf-8?B?QUlhWitpSVFRc1hLZkM1b0cxSm5GTmJCRXBoN1pqMkJXeG9VUUpWZG9xTDZh?=
 =?utf-8?B?VWRPaHdXTWx6SU9udE5kTE5ieGJSMStIVksxWEIveVF2ak10S00wdkZFVEdZ?=
 =?utf-8?B?RFVRTnhkeVJWd1JweEVMYXVUVzJtN211U1hnZ0MwZUtGc2ZEWlEya2ZEM3hL?=
 =?utf-8?B?bkM0WHZJdnJ4MEt0K1JicDZiZmdkUVNCVU5HaUxTM1VsSVNGSlMxalZ0b1d4?=
 =?utf-8?B?eGtwQzFEYnJ5TTVTWmZkSjBRVk1wUFdXS1duckduL29qdWxtWmt4NEx0L09p?=
 =?utf-8?B?UUpieGtwUjNwOW94VkdhcG5YK3NTajNMdUZDOG9hVVZRMVkwUk1uckVvWUpW?=
 =?utf-8?B?WE9TL0czVTZKMkVicGpNNVZKWnBPcDcxUDN2cDFNR3ZpdGp6YlV2VzJDV0lZ?=
 =?utf-8?B?NkFnQ2JzUXUzSDJGdjk3NytZc1AwV1dVTU9CL2pMYmVBNkw4R0RUVW0vamdB?=
 =?utf-8?B?UzVFS01CR1ZPb2xsZTJERWZwWGo5Tm5uY3FxbVl3L1JOcGg4TjBrT08zNDFr?=
 =?utf-8?B?ZFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D150D9F3C4D5A747B7B1B1C9F13E4CFB@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Z1bUi8k1rZmecnojWTuAaUkVRluVkDvoXwTd/Ft6+jb2kIW/SfVEnNrZkRLkKib+PA1vd574Nx9Uk9loWu2yqyFIu24pOeeJt0nS3n/VFSpGyQ7C4SP48wI0eJZTSz25V1z+jEFC1moGjyVbJ2OiX8iSDpiE+uxQbZHrmZa8geX5dHMLvWHKJjDsrsvbW+DjBTgXeHR3EwS49jGAAXcNOPMJAFgbHYWk6gdQ9MvnQ3eTNrqsR/gk6hvoXGODA1h/VxiNrNnEvE+oratFmqlQ9WO7A153fo8CEt++Ks7ZKCmQ6DQUghX9wD4GeWh0+DnpRQB7D7rqRTZXVvTeCPmBolGcjMVMInTxcAWZaCsMsJ2cWc3Gt9LTfB4f+sBqcDMBtl9gU66D2ANYTrwv7mcYU0Rdx1urLSF5+E2j1zGQDPyvDGW4Gd7yRwqa9EckzFbVrD5MG1saHaVZZkXSaD1nEWIP6BThlXAxF1atI0Tt5mEtsuqafL4sSUH0hfBuRkBju0cN8kkCsi5IifWFjv5XoZ91UDJEmCaRCk+x0JSAyQmMlUVCkYJcVCWeOjSrpgqUVg5cIGSsE732frEzzJVtJAFIMWbIUmAx9l2t+80JQqH6M/mPaYe/7ec5XE0RJoKb
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB1562.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2d9e767-f305-456d-214a-08dcf713bb59
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2024 05:45:29.8906
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R6fq/IwswPUe7uz8QJDOVkuFAg7cMJzBjr2B/1PKuHcWvQjjPSL88cXy2pZnDV1AVaKMpebnoVR9E+6A7lXqbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB10238

DQoNCk9uIDI4LzEwLzIwMjQgMTM6MzEsIFNodWFoIEtoYW4gd3JvdGU6DQo+IE9uIDEwLzI3LzI0
IDIyOjAyLCBaaGlqaWFuIExpIChGdWppdHN1KSB3cm90ZToNCj4+DQo+Pg0KPj4gT24gMjgvMTAv
MjAyNCAxMToyOSwgU2h1YWggS2hhbiB3cm90ZToNCj4+PiBPbiAxMC8yNy8yNCAxODo1MCwgWmhp
amlhbiBMaSAoRnVqaXRzdSkgd3JvdGU6DQo+Pj4+DQo+Pj4+DQo+Pj4+IE9uIDI3LzEwLzIwMjQg
MDg6MjgsIFNodWFoIEtoYW4gd3JvdGU6DQo+Pj4+PiBPbsKgMTAvMjQvMjTCoDE5OjM5LMKgTGnC
oFpoaWppYW7CoHdyb3RlOg0KPj4+Pj4+IEN1cnJlbnRseSzCoHdhdGNoZG9nLXRlc3TCoGtlZXDC
oHJ1bm5pbmfCoHVudGlswqBpdMKgZ2V0c8KgYcKgU0lHSU5ULsKgSG93ZXZlciwNCj4+Pj4+PiB3
aGVuwqB3YXRjaGRvZy10ZXN0wqBpc8KgZXhlY3V0ZWTCoGZyb23CoHRoZcKga3NlbGZ0ZXN0c8Kg
ZnJhbWV3b3JrLMKgd2hlcmXCoGl0DQo+Pj4+Pj4gbGF1bmNoZXPCoHRlc3TCoHZpYcKgdGltZW91
dMKgd2hpY2jCoHdpbGzCoHNlbmTCoFNJR1RFUk3CoGluwqB0aW1lwqB1cC7CoFRoaXPCoGNvdWxk
DQo+Pj4+Pj4gbGVhZMKgdG8NCj4+Pj4+PiAxLsKgd2F0Y2hkb2fCoGhhdmVuJ3TCoHN0b3AswqBh
wqB3YXRjaGRvZ8KgcmVzZXTCoGlzwqB0cmlnZ2VyZWTCoHRvwqByZWJvb3TCoHRoZcKgT1MNCj4+
Pj4+PiDCoMKgwqDCoMKgwqBpbsKgc2lsZW50Lg0KPj4+Pj4+IDIuwqBrc2VsZnRlc3RzwqBnZXRz
wqBhbsKgdGltZW91dMKgZXhpdMKgY29kZSzCoGFuZMKganVkZ2XCoHdhdGNoZG9nLXRlc3TCoGFz
DQo+Pj4+Pj4gwqDCoMKgwqDCoCdub3TCoG9rJw0KPj4+Pj4+DQo+Pj4+PiBUaGlzwqB0ZXN0wqBp
c24ndMKgcmVhbGx5wqBzdXBwb3NlZMKgdG/CoGJlwqBydW7CoGZyb23CoGtzZWxmdGVzdMKgZnJh
bWV3b3JrLg0KPj4+Pj4gVGhpc8KgaXPCoHRoZcKgcmVhc29uwqB3aHnCoGl0wqBpc24ndMKgaW5j
bHVkZWTCoGluwqB0aGXCoGRlZmF1bHTCoHJ1bi4NCj4+Pj4NCj4+Pj4gTWF5IEkga25vdyB3aGF0
J3MgdGhlIGRlZmF1bHQgcnVuLCBpcyBpdCBkaWZmZXJlbnQgZnJvbSBgbWFrZSBydW5fdGVzdHNg
ID8NCj4+Pg0KPj4+IE5vIGl0IGlzbid0LiAibWFrZSBrc2VsZnRlc3QiIHJ1bnMgb25seSB0aGUg
dGFyZ2V0cyBtZW50aW9uZWQgaW4gdGhlDQo+Pj4gc2VsZnRlc3RzIE1ha2VmaWxlLiBUaGF0IGlz
IGNvbnNpZGVyZWQgdGhlIGtzZWxmdGVzdCBkZWZhdWx0IHJ1bi4NCj4+DQo+PiBIZXksIFNodWFo
LA0KPj4NCj4+DQo+PiBUaGFua3MgZm9yIHlvdXIgZXhwbGFuYXRpb24uDQo+PiBJZiB0aGF0IGlz
IHRoZSBjYXNlLCBJIGRvIG5vdCBoYXZlIGFuIHVyZ2VudCBuZWVkIGZvciB0aGUgY3VycmVudCBw
YXRjaCwgZXhwZWN0DQo+PiBJJ2QgbGlrZSB0byBhdm9pZCB0aGUgcmVib290IGlzc3VlIGFmdGVy
IGFuIGFjY2lkZW50YWxseSBgbWFrZSBydW5fdGVzdHNgDQo+Pg0KPj4gU29tZSBjaGFuZ2VzIGFy
ZSBtYWtlIGFzIGJlbG93LCBwbGVhc2UgdGFrZSBhIGxvb2suIEkgd2lsbCBzZW5kIGl0IG91dCB3
ZSByZWFjaCBhIGNvbnNlbnN1cy4NCj4+DQo+Pg0KPj4gY29tbWl0IDIyOTZmOWQ4OGZkZTQ5MjE3
NThhNDViZjE2MGE3ZjFiOWQ0Njc4YTAgKEhFQUQpDQo+PiBBdXRob3I6IExpIFpoaWppYW4gPGxp
emhpamlhbkBmdWppdHN1LmNvbT4NCj4+IERhdGU6wqDCoCBNb24gT2N0IDI4IDExOjU0OjAzIDIw
MjQgKzA4MDANCj4+DQo+PiDCoMKgwqDCoMKgIHNlbGZ0ZXN0cy93YXRjaGRvZy10ZXN0OiBGaXgg
c3lzdGVtIGFjY2lkZW50YWxseSByZXNldCBhZnRlciB3YXRjaGRvZy10ZXN0DQo+PiDCoMKgwqDC
oMKgIEFmdGVyIGBtYWtlIHJ1bl90ZXN0c2AgdG8gcnVuIHdhdGNoZG9nLXRlc3QsIGEgc3lzdGVt
IHJlYm9vdCB3b3VsZA0KPj4gwqDCoMKgwqDCoCBoYXBwZW4gZHVlIHRvIHdhdGNoZG9nIG5vdCBz
dG9wLg0KPj4gwqDCoMKgwqDCoCBgYGANCj4gDQo+IFRoZSBzeXN0ZW0gc2hvdWxkbid0IHJlYm9v
dCBqdXN0IGJlY2F1c2Ugd2F0Y2hkb2cgdGVzdCBpcyBsZWZ0IHJ1bm5pbmcuDQo+IHdhdGNoZG9n
IHRlc3Qga2VlcHMgY2FsbGluZyBpb2N0bCgpIHdpdGggV0RJT0NfS0VFUEFMSVZFIHRvIG1ha2Ug
c3VyZQ0KPiB0aGUgd2F0Y2hkb2cgY2FyZCB0aW1lciBpcyByZXNldC4NCg0KRXJyLi4NCg0KSG93
IHdhdGNoZG9nIHRlc3Qga2VlcCBjYWxsaW5nIGlvY3RsKCkgd2l0aCBXRElPQ19LRUVQQUxJVkUg
YWZ0ZXIgLi93YXRjaGRvZ190ZXN0IGhhcyBmaW5pc2hlZD8NCg0KSW4gbXkgdW5kZXJzdGFuZGlu
ZywgdGhlIGNhdXNlIGlzIHRoYXQsIC4vd2F0Y2hkb2dfdGVzdCBkaWRuJ3QgZ290byBuZWl0aGVy
DQpBKQ0KMzQ3IGVuZDoNCjM0OCAgICAgICAgIC8qDQozNDkgICAgICAgICAgKiBTZW5kIHNwZWNp
ZmljIG1hZ2ljIGNoYXJhY3RlciAnVicganVzdCBpbiBjYXNlIE1hZ2ljIENsb3NlIGlzDQozNTAg
ICAgICAgICAgKiBlbmFibGVkIHRvIGVuc3VyZSB3YXRjaGRvZyBnZXRzIGRpc2FibGVkIG9uIGNs
b3NlLg0KMzUxICAgICAgICAgICovDQozNTIgICAgICAgICByZXQgPSB3cml0ZShmZCwgJnYsIDEp
Ow0KMzUzICAgICAgICAgaWYgKHJldCA8IDApDQozNTQgICAgICAgICAgICAgICAgIHByaW50Zigi
U3RvcHBpbmcgd2F0Y2hkb2cgdGlja3MgZmFpbGVkICglZCkuLi5cbiIsIGVycm5vKTsNCg0Kbm9y
IEIpDQoNCiAgNjggc3RhdGljIHZvaWQgdGVybShpbnQgc2lnKQ0KICA2OSB7DQogIDcwICAgICAg
ICAgaW50IHJldCA9IHdyaXRlKGZkLCAmdiwgMSk7DQogIDcxDQogIDcyICAgICAgICAgY2xvc2Uo
ZmQpOw0KICA3MyAgICAgICAgIGlmIChyZXQgPCAwKQ0KICA3NCAgICAgICAgICAgICAgICAgcHJp
bnRmKCJcblN0b3BwaW5nIHdhdGNoZG9nIHRpY2tzIGZhaWxlZCAoJWQpLi4uXG4iLCBlcnJubyk7
DQogIDc1ICAgICAgICAgZWxzZQ0KICA3NiAgICAgICAgICAgICAgICAgcHJpbnRmKCJcblN0b3Bw
aW5nIHdhdGNoZG9nIHRpY2tzLi4uXG4iKTsNCiAgNzcgICAgICAgICBleGl0KDApOw0KICA3OCB9
DQoNCnRvICJlbnN1cmUgd2F0Y2hkb2cgZ2V0cyBkaXNhYmxlZCBvbiBjbG9zZSINCg0KDQpUaGUg
dGltZW91dCBkZWZhdWx0IHNpZ25hbCBpcyBTSUdURVJNLCB3YXRjaGRvZ190ZXN0IG9ubHkgcmVn
aXN0ZXJlZCBTSUdJTlQgaGFuZGxlci4NCg0KVGhhbmtzDQpaaGlqaWFuDQoNCg0KDQo+IA0KPiBJ
ZiB5b3UgYXJlIHNlZWluZyByZWJvb3RzLCB0aGF0IG1lYW5zIHdhdGNoZG9nIHRlc3QgY291bGRu
J3QgcmVzZXQgdGhlDQo+IHRpbWVyLiBUaGlzIHVzdWFsbHkgbWVhbiBzeXN0ZW0gaXMgdW5yZXNw
b25zaXZlIG9yIHNvbWV0aGluZyBpcyB3cm9uZw0KPiB3aXRoIHRoZSB3YXRjaGRvZyBjYXJkIG9u
IHlvdXIgc3lzdGVtLg0KPiANCj4gVGhpcyBpcyB0aGUgYmVoYXZpb3IgeW91IHdvdWxkIGV4cGVj
dCBmcm9tIGEgd2F0Y2hkb2cgdGltZXIuIERvZXMgeW91cg0KPiBzeXN0ZW0gaGF2ZSBhIHdhdGNo
ZG9nIGNhcmQgb3Qgb3IgeW91IGVuYWJsaW5nIHNvZnRkb2cgbW9kdWxlPw0KPiANCj4gRWl0aGVy
IHdheSB0aGVyZSBpcyBzb21lIG90aGVyIHJlYXNvbiBmb3IgdGhlIHN5c3RlbSByZWJvb3QuDQo+
IA0KPiB0aGFua3MsDQo+IC0tIFNodWFo

