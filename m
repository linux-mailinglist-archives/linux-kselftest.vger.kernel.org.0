Return-Path: <linux-kselftest+bounces-20768-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21E829B2215
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Oct 2024 02:52:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C2EAB21426
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Oct 2024 01:52:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2782213D8B2;
	Mon, 28 Oct 2024 01:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="r3Bzj4Vn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from esa12.fujitsucc.c3s2.iphmx.com (esa12.fujitsucc.c3s2.iphmx.com [216.71.156.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D5393D66;
	Mon, 28 Oct 2024 01:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.156.125
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730080351; cv=fail; b=lgkX0lJvWZXMLGYu6X0s81jkAQGJbPK4kmfN6yqpsgiwu+SXoA4uBy5YvGW3Eyrvh3BHj0CB4mDIUj+slrsLGtYlyITiaznMIbbE6k1MxqEskFEUhv3Plws1y6gbyLhpojd8MwFqfTrDB5fepcjmuYf+ETFEVL44rt+81PT0/eg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730080351; c=relaxed/simple;
	bh=KJ4Sn05xrF3z5nctCdB6qbCFcLtCKrund7L3EuPFyj8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gIAcGtmsYKajPq50P6axFX+Ye91DiinG6UbBNoYKhT+IFeVwhtZpUJMdGw40kzEu+1yXMN/24utiulYBw8OTO+qd9CDCpg+frm8wfRzmuMyHkMREp0xoqgfJTf5IUIgl84DXe5kQ6yH9dxULvilqlLhRYjowe1j1vY8FbuE5dnI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=r3Bzj4Vn; arc=fail smtp.client-ip=216.71.156.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1730080350; x=1761616350;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=KJ4Sn05xrF3z5nctCdB6qbCFcLtCKrund7L3EuPFyj8=;
  b=r3Bzj4VnEqjPjG9h7x+hTf7L6t2CpBchm5TyskiHzq6JiI3FU5IKBnCN
   WrTaGV8eQlWHLR8XybQyIy7a0Kr8iL9UhPV5XnEiFmfKayrUPHvV/IOx5
   miyUdSZOvYUiXR3DLsr6cz+lI7TkbUF9gDFB4e5jSBGGaP2+DDg4p1btu
   IcDssv1xB8KRuKV/Qp/ErRhvdAnh7h4MmdDMJFBCNCnUq6I3GBp5Yp4vI
   /hdz8pHsQB0OI+VyWD60dCxtUIn27ZW+rK/vmEG0h+CY4D0b60c6yOrn/
   uBUaePeu5/vXyY2/6M5N3LQefoo8xGpTIgF3ylFqsRIByItQzKbz9nAGC
   Q==;
X-CSE-ConnectionGUID: EnZXwONESZm5q5NM9XNUtw==
X-CSE-MsgGUID: 80wxI5tTRT+yToN3YswEsg==
X-IronPort-AV: E=McAfee;i="6700,10204,11238"; a="135120578"
X-IronPort-AV: E=Sophos;i="6.11,238,1725289200"; 
   d="scan'208";a="135120578"
Received: from mail-japanwestazlp17011031.outbound.protection.outlook.com (HELO OS0P286CU010.outbound.protection.outlook.com) ([40.93.130.31])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2024 10:51:16 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NuH0pCunyHuhvh6b0Bc9ugio2+91FGl4Z3Mj2zklAtOkPBM1nEU8g32VW31yyw9bRp5bqm5SIAY2DQHI/GInDVxtbWtGVPJpWxpZ95t4QIqUIgNr6TV6gfvJ56URCVjFVCIA5ifq8gC+iryzMB8LCvbgnt0XwJ/xmjveyWS+FJhVP62a2HIZd+EuMoWcV48Db6GhytTIMOHkTl58JDLbQ6YustS7AHDthA+V4nL46LD5cV/AuMH4zx/N7DvozfB9Go9w+FFvsu+G4Ba/N1aeSmDfR4HS/g+Z+AmgYgJXH2VevIhts9KL2Woh2iyzpTODVv8M0EfGbWi+8M9gVMya7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KJ4Sn05xrF3z5nctCdB6qbCFcLtCKrund7L3EuPFyj8=;
 b=J39666FWTKn9CjG8LQa+kq85U826cRVrIMbHsMcDhMMi/K36RmNyud4k3TpGGdX1CtVOUUVPvx8BRKZtIjx34QxYXyV2ZVi2OjvBJ/VrhRKOt9iOCD+EP6PVUZcMtvj1FOUrkQ1qIwVuBiAtrLYHwjvRhDebyVMkqoMkLEzXms+z/za/rejCW02wNnDfzNBmhapTtj7E7rIfEvMsYgG6JGiH22SgwSU2Q3s5sIwUu/XrdqrbchvB9Mb3co1rvPMXiZXBrYGoVlb4yS/+PdbrdemQwin4mZqif5xcTVthEEwKRsCWz6rRorP8ta8LKEyS+1AWFh1IcsnfE/msODHppg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com (2603:1096:403:6::12)
 by TYWPR01MB10258.jpnprd01.prod.outlook.com (2603:1096:400:1d5::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.20; Mon, 28 Oct
 2024 01:51:09 +0000
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377]) by TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377%7]) with mapi id 15.20.8093.024; Mon, 28 Oct 2024
 01:51:09 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: Mark Brown <broonie@kernel.org>
CC: "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"shuah@kernel.org" <shuah@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi
 Iwai <tiwai@suse.com>, "linux-sound@vger.kernel.org"
	<linux-sound@vger.kernel.org>
Subject: Re: [PATCH for-next 1/7] selftests/alsa: Add a few missing gitignore
 files
Thread-Topic: [PATCH for-next 1/7] selftests/alsa: Add a few missing gitignore
 files
Thread-Index: AQHbJn6/mAr3QllUK0e3O7GQWhW0TbKXPfIAgAQsxYA=
Date: Mon, 28 Oct 2024 01:51:09 +0000
Message-ID: <36001711-456b-4e46-96d8-5caf7de2b57c@fujitsu.com>
References: <20241025014010.6533-1-lizhijian@fujitsu.com>
 <831f5cfd-2a4a-4b48-9ce0-55215cf2c600@sirena.org.uk>
In-Reply-To: <831f5cfd-2a4a-4b48-9ce0-55215cf2c600@sirena.org.uk>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY1PR01MB1562:EE_|TYWPR01MB10258:EE_
x-ms-office365-filtering-correlation-id: b069e61a-8e9f-4199-dc85-08dcf6f2fed3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|38070700018|1580799027;
x-microsoft-antispam-message-info:
 =?utf-8?B?eFhOTWpZQzNIcDBodVN0YTRXV0x5OVNOd3ZXbE9oWXpXOVVzcUNOdTlwbjBJ?=
 =?utf-8?B?dGZGR09jS2VWMThGbTR0NlphUlphcFUzUU1Bekc5S0dVdEVkcTd2Q2loaHFO?=
 =?utf-8?B?MmtFdVRyOFhWTUhKdERhTnZQYk9Dc2Npd1JTaEZ2Y3gwaDMrSHg3WXpOZ204?=
 =?utf-8?B?SW9uMXd4UWl0dEVmZlBZODRodTR6ZVd5NVpMcGdQTnlPUER5SHEzQ2lyeUti?=
 =?utf-8?B?a0RkbU0ySHh1NnFmN283YytoSWMyOUxIWWxkamtRdkVramxSeDA0b2VFWWpQ?=
 =?utf-8?B?dnlBMjNpYkxiNzg0bE1WVGpVOW10M0I4N0ZxYm9WeVJNVWppSWVHTys0YStD?=
 =?utf-8?B?ZzBrajZlU3NMY0R1NzNuZjdMSFRKOUhqWWFvMnY2ODh4RmlNVDJLVzVTdHpZ?=
 =?utf-8?B?YWhUQVJlcXVYeWRaV1NlTStHTHFCeDJGQzFRdzFNM1h3UldEWEZFcjNKVm9m?=
 =?utf-8?B?bHZobmxHMjlxRWY3QXJkc2lUVjVLMCsySWs5US9rUXBqRzN3WlpVR1ppZjFC?=
 =?utf-8?B?S2VkdEhpT0VQaFBWelh3RkR0T0l2MGdaVjhhcy9hZ0RiYUR4eDRleXo0QmZy?=
 =?utf-8?B?OHFBK0gyWTVYQ2d2MzI3VC9UUC85b3hKaXd4cVVNSkNBS2hEeVdKUTNZRnpw?=
 =?utf-8?B?YWxwenNiWVF3a0hLUVlzUWFoVHIrUnU2VWQzdWR1RjRVY0MrRnRqUkM3Q29G?=
 =?utf-8?B?WElvenVYR05XclkvMzVpMER4bUpOWW8zcXJoeFdNZ2xLYXJuVy9YQkszLzBP?=
 =?utf-8?B?TEMvUWRvcG5OYndXd0kwZkFKcjVYWGpMR1ByRG0ycFNEUmlQK0tuKzhlZ2gx?=
 =?utf-8?B?UHBCbUtYZ0xTODVPU0d4bnY3bngwMThDSG5qdUoreXZhSjlrajhkQjVGWXVF?=
 =?utf-8?B?UEs1aE13WHpKYnp5alhKeFh6UVhuK2k2Z053enNOcGtFSFQ3eHB3clF2YmFQ?=
 =?utf-8?B?ZndxNGptOWpvdlpraUNhbVg5THdEUjk0ZFBYWW8xdEhiUDc4ZytWL2EzbDR6?=
 =?utf-8?B?YjczNVd2cjF0SW1KdjZHMDVhWmdGRkkwN0tSK1h3UE50bDUwVHYrcWFIR0NJ?=
 =?utf-8?B?OVlDWXA2Q0YwaHNOeXhVZ2VkcS9OcGdqbWdlcnNmRjFrWDc5NHBJWnlBbmRO?=
 =?utf-8?B?TThteExkVFlaakg4aDRTa3VDVjN0UndGM3B5Wk1QWFN0NDFGRVBGendVZVZ1?=
 =?utf-8?B?QjhYTkVic091ajhxY2h0bUJTVStQSU1nSU4xMmZjRzkzdnBYT1lEeVFDRENL?=
 =?utf-8?B?UHdKUU9ac3BPdnNncXd5bVdpZjFWbXd0dWN2T1VFOXZwNVM0cnh6Y08vVElJ?=
 =?utf-8?B?TUhSL1NsOXk2L0dYNUoxdlZSbkRERC9BQ1RYOGgwQ0Q1RHJndnFZdzROSTVZ?=
 =?utf-8?B?d1BzYldlNzYxY0hOUXI3bEZRaXA1MkJKSlZUclZjSDJXUmIwZ0t0blc1d2tH?=
 =?utf-8?B?bXE4aDNpcnZlYVJyVHhGYUo0VXc1eU5DaTRoaFRxbHdFSExvUE1iSHZYc1Rl?=
 =?utf-8?B?MCtyd2Z0Yk5kdlArSTFwYmRsYnk2d2U1NUlwWXA0d2RJY2pEOUtLV1hxUk1r?=
 =?utf-8?B?L0xVRkx4K0F6bDlncDdLZHRiUzRLSWRxVXdRQm1CVnUrMGZLUFgzdmI2Tjdr?=
 =?utf-8?B?bkpWblpma1hSR1VZbTM0azRKRXF4ZzhBdkk1Q3R0UlhQQk11NS9pTFB5eWdZ?=
 =?utf-8?B?U284TEdJNEwvSUVZOEtoSi8rSjdaMU5Pc2Y4OXRVYjFiWXZGdEtVQmJKK2Vy?=
 =?utf-8?B?MC8zM256Wm11WmFRc3p5Um1WRVJWdUo2aHVNand0VU1DUUVvSHg1Q1ZhMkRC?=
 =?utf-8?B?Q0N6U3BnRmRmVU9kRVJibUMzcStDYnk4WUNtanVmN3ZndWtvY0VRYjNKem1M?=
 =?utf-8?B?bUhRUFQyYWZCd3A4RFI1UWpkeS9abzZVRXFybXJXRUcvR3c9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY1PR01MB1562.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018)(1580799027);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RWUwUzZXYncvRHgwUkNSS0hzRFNtNE4vN1RwcE16a1l1RWExS0phU1N2Sm50?=
 =?utf-8?B?S2JoOHprYmNOeXgrdFdNdGlIa2dEN2l6WnFkbitNMzhJZmxnK3hXTGZNc1RZ?=
 =?utf-8?B?T3hhTnJ1MkNjTmlleXUzQ1ZDeVVRZVplM3JGMDRJb1hBeHJ3V0dVUUVISy9a?=
 =?utf-8?B?WEVBYWxCUndLNWxraUpQUjBSSUV6VjNJUXcrbXlHOWVEZVowekdQM2Y3Si9E?=
 =?utf-8?B?UC9BRk41S1VtbUhmSjNjRHNYVm9TWGNUQlloZnl3Qnh0dTVoTmRKR05ORUJT?=
 =?utf-8?B?dFF2MUc4R1VTR2toRS9LTzJhLzBCREJNQkl2eGJLWWs5ZnRXU2NRTmVGRmNW?=
 =?utf-8?B?Z3pWaTFJbEcwb0Q4dW90UWdKNFJnT08wWklaN241ZklOck1haFNGL0hENHhP?=
 =?utf-8?B?djNPTTRmVi84L08wMXlzOCtZUjFCcFI1RnZKV1MyOWpQekcwOEtIQ0d0SVdF?=
 =?utf-8?B?dk1wT01HK1oyS2FnNXhvSTVxVTdxc0wzYjlPdTd3WEg4NC9zR1FnTFNzenhj?=
 =?utf-8?B?aWdVbThtVVVIaGIwK0VqQnlTR01Qa3N2RkVIUGR0cVpzblRtK3htWTlkdUkw?=
 =?utf-8?B?U0NYdDhUSWxQeENoZTdKMmFFSzd4eW5FQWlObXBQUFZ3NG5TZjlKWklOaUFX?=
 =?utf-8?B?bGF4UkoyaVZhd2xFbTFOVHpHYUxtWHB4Y0xISmYvRHBQTnFJaEtSbjh4Sk9X?=
 =?utf-8?B?OEt3NzlwajdlYXgxRXJTUVZVdXVtTS9QVzFodU1RTEpFbEptT28yZlFJb0dl?=
 =?utf-8?B?ZXdwTmhXcUFtakM0blhZYzBuZ3JFMHM3SVI4NWs1bGdtUE5qSWh3SXBzdWZt?=
 =?utf-8?B?ZGxYdnBqSVlLTnVFeXYwcEVpSlJlc2xPQlZBVFpBTmE3TFBBVG5zNjdzbFdn?=
 =?utf-8?B?aWt3NDFFZ3A0cVRIRHQ4RlkxclJUZ2haeERna1JkQXByeHd4Q2kyQXllUVhJ?=
 =?utf-8?B?UmR3LzRERTRRSU1Tb3AxWUNDd2lnWnF5NVBReERWWkxmVWswSDg4bVpxUmEr?=
 =?utf-8?B?YmRtekV1LytCTzI2b2p4YkVGTzZWMmp5V0hEbm93Sm01Q21wNlhMTFAraEtB?=
 =?utf-8?B?VTdSM2ZGbFRMeU5wRmhWaGx1WWppcTZWL1c0VWpGeHJ3YUI4M3B4aXBucVoz?=
 =?utf-8?B?Q1JPVlBjdWt4d0RGWExKbnR2cWFuaGtGMDEyT0VBbFdWYks5UW1HNXdmM0Y2?=
 =?utf-8?B?WXZxTjVIY3V1cTVLR2gyV3F3UlFMc0FzV3p1VW16T3ZFaGlya2hsc0tiSVM4?=
 =?utf-8?B?OVdZdk02WUovM2xnVkM4c0w0VGRFbkN5SHh1NEZWQVJaREU0cHlwcVk2N09a?=
 =?utf-8?B?Y1J6Y3VRWjBPUkYwdEpyTWViZlpCY0E3bnpKY0VMb1gxTnFLOXBITGl3K3pj?=
 =?utf-8?B?d1NlWEo1VUtEWmdaYjkvL3lJdDdhNllIZW10TWtSd0c5WmoyMk5wb2kzaVl5?=
 =?utf-8?B?UjRVTTBUMVF4MkJpQXEraEY0a0lPR1lxUzlwc0JQVllROHpDdUxXQnNrYXZD?=
 =?utf-8?B?TWVsN2Y3dDd0VVBPcEdRZTlxWk5HdVNOWkFpeFllQjZDNUQzM3kxS2FsVTZ1?=
 =?utf-8?B?bjlWUnJDUkJONHdoaUFqeDg4WEp5RmdsR1crZnJ5a0YzYmxHczJSVWlTaHR4?=
 =?utf-8?B?c3gxOUxlT24rcHM3dUZhdXJHVVFiOEVId2ZVakpDUFBYM2tNVFR6NGxNZGUx?=
 =?utf-8?B?K2U1bnlKVTFHS0NLalV4S0lLbU5qWFJvWjIxYWpLR0Vlekk2OEF1d01ieUxu?=
 =?utf-8?B?OVBDYnJUUVcvbU91TDdObGlSSDFwZGhyTVQ4WGpjeDJVMHpUUHV3d0I1cUIr?=
 =?utf-8?B?dHRZUi9sTENKNGpsTEtYYnN4bU1VeFltLzZocE53TFlndlNWQzZXclN6RG8z?=
 =?utf-8?B?RTIvUEROOWZmY281a0NkdytYcGtCOFFJcFlXdzNZSDlnazFVcXhEczczclFq?=
 =?utf-8?B?a2NhZDZ6S0lNVE1UMm13enE4R2FESHZIbkphUXEzNlhIOFhCTlZwa3RZRmhx?=
 =?utf-8?B?QjhnODJtcDVDbGI0UE1LZHhBOUtySFlReFk2VWNHcmdGUnRwZ3lORzUwYUNw?=
 =?utf-8?B?Ym9Cb3FHZERNNjY3blZHS29yMHNxSnJIVUVCdG1YaGUrSjFuTzBqTm1QcDBS?=
 =?utf-8?B?Z0R4aU91ZlAzblRIQU9YbnZBMTRnOXVxUFJYNW5PbTZQS1V6cTZ2WElubU1o?=
 =?utf-8?B?OWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6AE8908C7FAB8B499F01352551F086BA@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	twyzhfzjBbiu0VRVzWFUANxZdoDGJbAzom5bmbs9g3L7txUG04m6FL+C+0PSuNWcGppbRwvApwosj8DZ9MHE/oP0YN1hasaeypReT3n4LJl1iugmFQwGPsCC95W+jC/mvM/ntH+8/szYmSjm1x5jjq8reANK+LHoeWOS9gzHM7CPHiupdG1Rm/1qiDN7c07Ris7rwKtWe6OqngVc5AfDEfVO7BMv3nFEP5XA8Y8IIsfLtMAiTxTG62NHIPrVEyzQMSe++nA90SelSMpevC7dvBehNFEWImaGDpF4mT2e8g8T+GF9q9reHZJ08q+p5iJElZqVZargiwcYu6nVRw91IyegD0upB+1QoQotnBJccWeFytdY0y2726I6IqE/poK+WxBgZbkTaxw4RAuWOP5XsUhK/fmqlgAUE+KWLJNWEoHmL1WhfF4VzNjM82vdCJhZ06rEEMUH4JR4cGEwfZ9fJzs2tZI0UnLpqvqOwE4UgxPpuBX6JEYMuA6JDLetJMRB/cZu1t7CEoid3BH4VztZckG5mjGCfQirhDiCVqN7iXMLJD/0t/OEFZ/Nvh3CuLCKMAQBM70Po9hUFGDrFw7CYpa3HY2KvASghzzDpGv3Zq8KaaJgGrGDUkMdeKanclHj
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB1562.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b069e61a-8e9f-4199-dc85-08dcf6f2fed3
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2024 01:51:09.7176
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t0+fYhSOaHG6nmtkUZIZjtBImlWZPgEAIhTSGQ5elVaalpdzquAwAt6gi9nM5+qZdonTjRsZcUf8kT35s6eFdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB10258

DQoNCk9uIDI1LzEwLzIwMjQgMTg6MDUsIE1hcmsgQnJvd24gd3JvdGU6DQo+IE9uIEZyaSwgT2N0
IDI1LCAyMDI0IGF0IDA5OjQwOjA0QU0gKzA4MDAsIExpIFpoaWppYW4gd3JvdGU6DQo+IA0KPj4g
aW5kZXggMTJkYzNmY2QzNDU2Li4xNDA3ZmQyNGE5N2IgMTAwNjQ0DQo+PiAtLS0gYS90b29scy90
ZXN0aW5nL3NlbGZ0ZXN0cy9hbHNhLy5naXRpZ25vcmUNCj4+ICsrKyBiL3Rvb2xzL3Rlc3Rpbmcv
c2VsZnRlc3RzL2Fsc2EvLmdpdGlnbm9yZQ0KPj4gQEAgLTEsMyArMSw1IEBADQo+PiAgIG1peGVy
LXRlc3QNCj4+ICAgcGNtLXRlc3QNCj4+ICAgdGVzdC1wY210ZXN0LWRyaXZlcg0KPj4gK2dsb2Jh
bC10aW1lcg0KPj4gK3V0aW1lci10ZXN0DQo+PiAtLSANCj4gDQo+IFBsZWFzZSBrZWVwIHRoZSBm
aWxlIHNvcnRlZCwgdGhpcyBhdm9pZHMgc3B1cmlvdXMgY29uZmxpY3RzIGluIGZ1dHVyZS4NCg0K
DQpUaGFua3MgZm9yIHlvdXIgcmV2aWV3LCB3aWxsIHVwZGF0ZSBpdCBhZnRlciBnZXQgZmVlZGJh
Y2sgb24gb3RoZXIgcGF0Y2hlcy4NCg==

