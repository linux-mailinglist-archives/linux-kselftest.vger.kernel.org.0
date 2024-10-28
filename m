Return-Path: <linux-kselftest+bounces-20792-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A1D09B2594
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Oct 2024 07:32:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6E7C1C21006
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Oct 2024 06:32:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8D9A186E52;
	Mon, 28 Oct 2024 06:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="hmZSIDff"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from esa11.fujitsucc.c3s2.iphmx.com (esa11.fujitsucc.c3s2.iphmx.com [216.71.156.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C48718E04F;
	Mon, 28 Oct 2024 06:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.156.121
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730097157; cv=fail; b=bIB7Aw/3+ZPTRj6SnXN+Vvu6Lg2/NoBh3i+1eqAZFXUoM77OP+A6K29MGV8hyFUNzsCuTrW+fcTGyRfcirC+Ep/E5cOLCPDWL72SJHLVIsXhPnG0JbFJIe5DiEriB7HzpTwITtoLUbqbOJypfhAOQ2RwqVZmDg50vaXelCsj/QA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730097157; c=relaxed/simple;
	bh=9G0lUVVLxSKEnu0sp8eMXrt/LVN/tED56PAgtLhrvTU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Qnvqma4tUnN0AQqtr7i/bwHBMF8jqyF7qYm1NYJmRbtlYdnRi04fqKSTEri+HlUZAz/UA9BOCC5a1d8vLy6wVpJiljc94ldb/NK9v3tUUsTgcqv/CdDs4YlA8OSMkZzWNM9IFFbXzswUwKVyaDddwBri5kwOpkU1pNSxLeBa65o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=hmZSIDff; arc=fail smtp.client-ip=216.71.156.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1730097155; x=1761633155;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=9G0lUVVLxSKEnu0sp8eMXrt/LVN/tED56PAgtLhrvTU=;
  b=hmZSIDffPObxowu9olm2ntn1Kxd5qOdSFREaCZgtUllomWK+93CxZ1Vx
   NN61UICkbzv+c9yU7a7rhI9A5rbrr82OtJdPXgEkebf+X4PxG9IPnaFSi
   TqvurMGC2q0S8V4g7vaQSoEzluA3LOzdegRMgHY5wV3s+zj8myhHM0/vP
   Xk7VreALKFKc6Eaze6jLlPwj8AxKmWUwya+OGoFGGmQ7bet8la8OrVhVz
   bbgRczKP5e4Nm9tNv6AjHWIauzB56btpJ58vpTtw5i48B7XmW1W0HGvkT
   Ryo83syYHa3hX1oKkFd8+E5w8/SRRbc6XTCvbotagx/i/F64DdGEZftiF
   Q==;
X-CSE-ConnectionGUID: VSXzH9GRSYm5vG/nWOvTfg==
X-CSE-MsgGUID: x1I8inXnQWeC9MXEkdraTg==
X-IronPort-AV: E=McAfee;i="6700,10204,11238"; a="135846718"
X-IronPort-AV: E=Sophos;i="6.11,238,1725289200"; 
   d="scan'208";a="135846718"
Received: from mail-japaneastazlp17010005.outbound.protection.outlook.com (HELO TY3P286CU002.outbound.protection.outlook.com) ([40.93.73.5])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2024 15:32:26 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YFM9TYVlzXJA7AWLx68HDO6ANf212LtlLi0gww30lRuifvTzKbbDtiYWBzPE3QXT8Ajv9UIO540WfzwjqFgt33juqtp02SJ+ZqeeyUsR7wkI4CpbqJZvq9RTjX1CU1kQjdW5ePmXnDqSElfg/5HiAM8eZiNF1FgAh6cl7tUftPUImoCKv1DgLjAZhdtQTL7ultGwWmCNQz/iygzdZmxhZYYwmCGDJnH9CVpKHDzzONHi6VAi+U2acH9Kb1cT0AUbcbGkmdJxtOkF7VXl5ub1wkpaZtLELaQ41yte7nJw1zHJA2HEQ12azcdQsrs063HdoiQU7/03rM31pAPiRh7mNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9G0lUVVLxSKEnu0sp8eMXrt/LVN/tED56PAgtLhrvTU=;
 b=S7TbClFvKEkxDX0gCWQel4C4gnhumjNwjBy+pCNGnwLQQih8vHKMwFnbo7wNJkh9WgRj7yZkKYcD4GP4Z2XJhuCkGACVGf+TvjNFDMLkqUvrngLIdnxwpIjcIF4cO85tAoE3KiY17fT600oPqyzP5CEEt/YEBso44SAn6gDvIEwQ5e2jFYAhaNvF0a4XuuFw8UHn0V3XZItxfv5SDTxX8wzRMXGealn09Riyz72NcuHsKlDiDOPd3bXXHQ2B733mjrrsge1LZ+/j6+FCRwTTtEfZO2MNWdrlLi3eG0aD/s9xH2xEflE6YGi1ZdIHqtx1rYrtiQQ8HfqoPMdRkpcCKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com (2603:1096:403:6::12)
 by OS3PR01MB9707.jpnprd01.prod.outlook.com (2603:1096:604:1e9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.23; Mon, 28 Oct
 2024 06:32:24 +0000
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377]) by TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377%7]) with mapi id 15.20.8093.024; Mon, 28 Oct 2024
 06:32:23 +0000
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
 AQHbJn6pWUq1FBNyBUCuyGcWUIOetrKZwW0AgAGYNoCAACyDAIAACTkAgAAZB4CAAAPMAIAAAq4AgAADOICAAAVaAIAAAdoA
Date: Mon, 28 Oct 2024 06:32:23 +0000
Message-ID: <a6a5d13b-c550-4a99-9a84-b28e8314ccd1@fujitsu.com>
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
In-Reply-To: <19579b1c-0a9b-4c72-be00-44871dd37b9a@linuxfoundation.org>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY1PR01MB1562:EE_|OS3PR01MB9707:EE_
x-ms-office365-filtering-correlation-id: 2909e9aa-04fc-4e18-7548-08dcf71a4897
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|1580799027|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?WHpIWW9DVFlPMEFoZEFCR2hzdi90T2l0U2hnMUlzT0dxRkxyc3RZam5SRHJl?=
 =?utf-8?B?NFlaK1h6UFE0T000TWJKYUovYUhJcHp5ZnhMUzFPanBhZFI0ZW5MdU5CVGxT?=
 =?utf-8?B?Rk8rdHVaQ0gwMlpPdldiMFNLSndJUk94VURlcEJrTlpGM1hQY0JXMzZyUXhS?=
 =?utf-8?B?eGNLWjlEQ3JobGZKanVvc3lSR0xSUVZENXBBVE54WDhEUUN4UGdVSjY3enBH?=
 =?utf-8?B?aEQ2b2FQRXdZczNiaWtpSm96WlFMQW5ZUlBjVXQ5clF2a0g4TG14dk16djB3?=
 =?utf-8?B?MVBTYTFhSXl3eWVFQkJFS1N4MVlWYVNEcUppckJRUmdLQWZCbUdBM3BUbHRw?=
 =?utf-8?B?elhrUWcwRDFLNUhsTWJQM0grY3JzRGpXQTdXbUVjY0RwTXdIZ1cwLzd6V09h?=
 =?utf-8?B?RUhOOGIwNlFNK3ljSnBNQzcrQ3hQdlhTaThWU0VtQnJTR3JwNWRBdHl2RWFE?=
 =?utf-8?B?TjRkR0toQkRQTlFPNUtTc25rYmZ6VG1PazJIeEhvS3FkSlRPVTlldjlRODVM?=
 =?utf-8?B?NStGN3VhbWs0dnozTFBoMEhOdENWTHpxVHFwKzJEWEVUQ1FnTjlTalgrVk9Q?=
 =?utf-8?B?N1JBN21nK3l2K3FKZnFvb3BMN2dkLzA1MzVsS3FqaHRMUTkyQ1I4R08rZlpX?=
 =?utf-8?B?VEY1MW9YaFoyMFVuYWFpRUR5dHZ0TjhpT0FQdlpaSFE5WFpHdSsyTi8rbU9v?=
 =?utf-8?B?Y1B6RVhSd0x2cWc3dzBuWC92VnJ3eFdrTGxrZlRJOE5tMnZ2cklvUXBDWEtD?=
 =?utf-8?B?YndRUG5pMHVIT1FiWUxEb25saC9VT1p6Nk9aWi9SZ3FEdUJjSlpXbTRWSGJp?=
 =?utf-8?B?Z0JZNDB4VGFOd09tSllCdGhZWHlWM1Q3U09zU2t6NnVGbTJQdVpveEd1aDVT?=
 =?utf-8?B?WTdQajluaUpmMW04VTFlaW55QW9ObUs4eXQrZ1B4VmE1MHZVWGwvZTRCWGtR?=
 =?utf-8?B?ZmsxRVRMM0RQYjJOc3gxbFBRdUYwTlhJaE4yczViTDVFRFFMQmp5YVZqM3U3?=
 =?utf-8?B?MGRTUGZXcHBtMTBxc2NObkZzeklxVUdaM0ZITHF0enozaVAyTjBYVXN3akJJ?=
 =?utf-8?B?VDhIT1NvcDZQNlNubElZVVZ2MFhVNFFiWFBHOHAzazJkYkx1SnhyVjJoV2NU?=
 =?utf-8?B?RWhnc0t0S1NQK0k4T2pweUJ2eGNYeWd0MStjMTU2OVFKUUZDK3J1bzBSQ2pn?=
 =?utf-8?B?WnVpdklQUXRDOHg2alBQZHdiYnkzWXk4N1VxOW9GaVVBZGI5NGthUFdiS0FU?=
 =?utf-8?B?d011RnFySkFzOGNWV0xNMDFtOEYvQ09Lcnk1OXdsRm9kNytzSkRtZEE2THkx?=
 =?utf-8?B?UnFiUER3SGxueVpMb0RQeEQrZHd1aEYydGpXTFBpVGdZblBsdTR0NlFBVmta?=
 =?utf-8?B?aW50dWRLQ0wyVm9BWTJBdU1wS09lOE1BTTFqNEdkaEJBa0lEb251VmRXOGY0?=
 =?utf-8?B?ZUZwYm1WYVFyQUlVQTZhRkwvMW5CRHNCR0NjaGJHeHFkSkFyWnNRQUNyeFJD?=
 =?utf-8?B?TjJZTlZZcDhjeDU5Q0VhM0Y5NzVpMDNMdkk2b0hOWDR6UkdqVWUrS2lzdVVE?=
 =?utf-8?B?TGdsMzU3c2VaZngvWEFsTTJqcDNqcUxZUm1PQ3lKem5nTzM1d3Y5b2RLb1pY?=
 =?utf-8?B?NTF5QXM5azcwenBpaXdoaXBiOXBrUlFGVG5BYldsaTRreVdmT2tZTzhBdXRt?=
 =?utf-8?B?ZVc0a0FOTXQrSmlhTTRRRUw1RXNkU2ZNSFU4a3ZGUnBEZWcxTFM1VDBMQUtT?=
 =?utf-8?B?bVIxRnU4S1NDSHA0eHh4Y2N3RnlETFA5Z1lFT21aTlhsTWJsSXZ2QzIzODJV?=
 =?utf-8?B?WUNqbzlVYVdycmVFNlMwd2NHQXE0aldQNFJ4TnVNaFlDTkFNcnRZQUllYm1L?=
 =?utf-8?B?Z1JzOVRSbUs1Z3c0WC9vQkxiRmFueXhpZFBjSi9jMUwzTGc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY1PR01MB1562.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(1580799027)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aG9HWmJlMjA1ekxiUmVrbm1FdVF6T3dtclhjVWVOM3BQQmg3aTBYOGlnN3RJ?=
 =?utf-8?B?VTdZVHNhNlJ2MWVnUTlISWVJNDhjSjVRU3ZVME9hLzZDc3haandBbUhzaWM5?=
 =?utf-8?B?M0Y0TjQySFR1Y0VBS0twL3JyY0ZMcUJoNmE0NG1JaHQwa014WG01NUMyNXlj?=
 =?utf-8?B?WFNqd3I1S25VTlkwaXlHdGJiZXRtellKcWxUMndIYTd3dG0xUGt1Zm5vQkFT?=
 =?utf-8?B?VkRmVEpPMTk3WnF1SXdoTjZWVThheWtoM20yc2V1YTIxbDViMUVCeFg2aUxL?=
 =?utf-8?B?b1lLUzN4VUNiaHpXYWsxamxHT1JFWUxZR1ZYcjF1aFBXcHF2TXJrUHNpTmVO?=
 =?utf-8?B?MXp5Tk4vNjMyeWNBT2dWR0JqVk01cnR4TStjVExEd3FVTjREVlJrdnF6N290?=
 =?utf-8?B?ck9aK05HcTJpdm1oMjNtb2tDeHE3aXVGc0JJVGpCS3pFVlBTOXJyMytJV1Bt?=
 =?utf-8?B?aVZGSUR0dStVNmdPaGZocW5HaUZZb3BsdWFNTUhkV2IxcTd1R0gxZ2t4aUN0?=
 =?utf-8?B?RzNxcXUycWsvb2R3dzQ3ek0xU3VmTjJiNWY5VnFTUFBRT2pwNEtJK1lTZ0oz?=
 =?utf-8?B?ZWlUNVNLeExRYXhCYUNzR1dRVnordzB5TEpFZmtmSDF3b3dnTE1pQWNwUzcv?=
 =?utf-8?B?c0JGS2NzTTFINDFtbVFGbUJxZ3RKSElYOUxiK3MrUTJybk1jZEtaTXlad053?=
 =?utf-8?B?WnRoMUNFRlVIU2F5WXhVM2lhTG9wVlY5RHlGQmVpTUZHK2VKbHRBSHRiNVc3?=
 =?utf-8?B?dVRRaW9IZHUwZ0EwQldkQXFvZzdqNElzV0cwSW9PYUVrb0trb2tzZGk3ajl0?=
 =?utf-8?B?ZlJMVThEQkh6b2U3cW9Na1E3ZFFiNW03OXh2ZGJoMzNOYzBacEl0eGhEdmQv?=
 =?utf-8?B?aThoVWVhcmRYU1hLM1lGU01YRG9QR20vU2hlaW1ObVJIV2lZY3pyU1ZnK0pm?=
 =?utf-8?B?djkwbHdtbThTWGRabkhGT0xSeDFqc1VKSzBpeU5PNFJYOE5jdmxLUk5ZVEwy?=
 =?utf-8?B?NUlia0dKNVhsVWVJNm9LUkIveWp2NEZsNDlnZTNaeDJ4NCtWMXZoMGlXQm5o?=
 =?utf-8?B?bWdqalBDK01ySHptV2hUNWlXOUFvUDRlNEUyVFVpUHJQd3VXdFRZWGlDZGZr?=
 =?utf-8?B?SGRiVS9NMDRCSGY2OFN1Qkh4TllSdEo2ditmbEdSekVPQzZrNk9UT3FHVzRr?=
 =?utf-8?B?RityNlRYbFhBcGZnRU1BTnJJSnh3ZUVwQWlNYldsRlYvUzBpeDJDemk4NTBQ?=
 =?utf-8?B?ZjVJRWFSMk5YYXhIR3FkSFRjUURnUzBJbWZwV25PKy80akdTMXg0SkpKQzda?=
 =?utf-8?B?dW9Pc2Y3VlZTS3FVUk9UUWVrWUwralREYTdoL2REMUNEaDg4cU80L0UrUW5w?=
 =?utf-8?B?eVBLeHF3eGFKSy9BTUp5RnlpVW5qcFFqY2ZIREp1dVN2WE9ITFZHdWpSOTlP?=
 =?utf-8?B?VEFaaHlGbTM4RmljQ0FWdm5FVVlHaGVCTDR2YS9wQk1jU2lLZDlYZjZGTElx?=
 =?utf-8?B?Q0ZvczZET3NBTmQ5L2lVblh0dVJaVWhpSkpYRVdMczZqV2VMK0Z4d1hYWHVW?=
 =?utf-8?B?Nzd4T01QUlBDc09kaWIvWmNrWFJ4VVpWaW9YRzZ4Rm9EbXBEdTZnWm9jNkVC?=
 =?utf-8?B?ODRVYXlwUENTSng5VC95dG9XeTZtaU5mekFDeXR1TVI0MjQwdytZZDFYVHps?=
 =?utf-8?B?TUNBS0xFMDFrMUVXT0w4QjVZb1dzNmRwN25uWHlISVVjeHlIdzRwODgyOHI3?=
 =?utf-8?B?QlVjTmx5alE0LzBFUnY0RnEzcHZHcEEyeHphYjJRbEFHaFZZY3V0SXk0Vmtx?=
 =?utf-8?B?VnRVbnNKbi9RM0xRWk83enQwcTdsRzJ1K0gzTWlVMC8wb2JGSXI1UUFXMnpl?=
 =?utf-8?B?Q0xta3dDWlR2L0hNTUMvUmhOYTkrTDZwNk0rVnVKcURoeEJnV3haWEhTTmhx?=
 =?utf-8?B?amk3WW1ZbDVZZEFCeEtBVjE2dUw0ZXhjd2JDbFgyQ3YzdGRRcUlRbDZJYUlC?=
 =?utf-8?B?NU1PYzYrK1pWNU1pWE92VHoxUlFsc3Y0Ulk4NGk0NlZiVkdSQ3Q4UkN1MG9R?=
 =?utf-8?B?S0tDN3lPMkpxbWhrK2RqcXpMWHMvcTFtUWszVUxCRUc3QzNUQjgxenRINTBJ?=
 =?utf-8?B?QisxeE5MbFlKNnE5R1laRnlxQStWV2pBaHZyNlNsUm9rT3BFK2ZKYjZFOUNC?=
 =?utf-8?B?WEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3F4DA047B552FD4996AE07223D952390@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	/9R1ys2RM0ABAdvUycTnkmhFZLKtOCxhtTzN1CpHPm+xbbYrytN662r0g8RBmyZQkkFf5IiO1+GDsv6a7xI15eu6V/wJuOp68G5Il60Kw+9vc0aEsuejtmvBTd99/UqxHTH24LDyh30dAvgUGdGWCE/mo+KkDZhUzyDrdOAeaNhNWanePlN0ryJrabmBSyAJicCVbSU4vyjXkQyXGpVbtHqq85cfuZymq7JkY3xe/Tb6hkhFdtyHhNn4ZgmMhFW4o62ui60FkJcVJGdHNhDSXRRw7wqk19Sl/KVK44uxbg/S6GGiSepRNfHAQFT8UexXAzL3l//QPToQgo175sN56pDF2rU43/p3R5X+ne6bDw+uqVtqAM6do1l1ytlJf6uiO6lASBq7GHfnyX+fEbVdMdvhz0MQpbm+5wKQMnbuyEwqNSClc8+YGDOJWt81YfJ/MosH1G6moLM1AiM2oYMP8jNpG/6UaueP083hwF0nXpUf1hLuDQQN8gHjULfn0bODc8Yzj0VjpuF2ZjvLYlpmtVQuZwRDpytMZGY0MeMa+nz+27oSSOHJTCGtETxd0uG6c5UPmZbDW9QhOtyATnoIQkdT5uVq4y3735i0FaJobWpYLSfW2UBwET1KbYQF+tuo
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB1562.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2909e9aa-04fc-4e18-7548-08dcf71a4897
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2024 06:32:23.8828
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BgMesgn5nSlgJusQ39d5/GUQihdrLOOqp/vkxiOvU8HtBEL/nVgqTHSOdeb8SOiUAwkUyCjifwqfvCc6VRY6VA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB9707

DQoNCk9uIDI4LzEwLzIwMjQgMTQ6MjUsIFNodWFoIEtoYW4gd3JvdGU6DQo+IE9uIDEwLzI4LzI0
IDAwOjA2LCBaaGlqaWFuIExpIChGdWppdHN1KSB3cm90ZToNCj4+IGxpbnV4L3Rvb2xzL3Rlc3Rp
bmcvc2VsZnRlc3RzL3dhdGNoZG9nIyBtYWtlIHJ1bl90ZXN0cw0KPj4gVEFQIHZlcnNpb24gMTMN
Cj4+IDEuLjENCj4+ICMgdGltZW91dCBzZXQgdG8gNDUNCj4+ICMgc2VsZnRlc3RzOiB3YXRjaGRv
Zzogd2F0Y2hkb2ctdGVzdA0KPj4gIyBXYXRjaGRvZyBUaWNraW5nIEF3YXkhDQo+PiAjIC4uLi4u
Li4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLiMNCj4+IG5vdCBvayAxIHNl
bGZ0ZXN0czogd2F0Y2hkb2c6IHdhdGNoZG9nLXRlc3QgIyBUSU1FT1VUIDQ1IHNlY29uZHMNCj4+
DQo+Pg0KPj4gQW5kIGkgZ290IHdhcm5pbmcgaW4gZG1lc2cNCj4+DQo+PiBbIDE5NTMuMjI5NTEx
XSB3YXRjaGRvZzogd2F0Y2hkb2cwOiB3YXRjaGRvZyBkaWQgbm90IHN0b3AhDQo+Pg0KPj4NCj4+
DQo+Pg0KPiANCj4gUnVuICJtYWtlIHJ1bl90ZXN0cyIgdW5kZXIgc3RyYWNlIGFuZCBzZW5kIG1l
IHRoZSBvdXRwdXQuDQoNCg0KQ291bGQgeW91IHNoYXJlIHRoZSBleGFjdCBjb21tYW5kLCBob3cg
dG8gJ1J1biAibWFrZSBydW5fdGVzdHMiIHVuZGVyIHN0cmFjZScNCg0KDQoNCg0KPiANCj4gdGhh
bmtzLA0KPiAtLSBTaHVhaA0KPiANCj4gDQo+IA==

