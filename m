Return-Path: <linux-kselftest+bounces-18104-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0517F97BAF0
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Sep 2024 12:35:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAE37281783
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Sep 2024 10:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE03C17C7BB;
	Wed, 18 Sep 2024 10:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="UMpA2LC5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2047.outbound.protection.outlook.com [40.107.92.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAEB71CF9B;
	Wed, 18 Sep 2024 10:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726655721; cv=fail; b=k6lgWpUfyFdK/EvfAveBEA2yUb0iI9MZo7H4NZiPw7Rj6wL6H5KpjEbYid/COqcoe2uvgd5sGMiKpfBq4WmfS/lEzGt7p5XODRikxG2veEcd+c9SyrfPh6qNGeJE2x/lbNkE4/VxwH0+tP9ZExt1+KO1l6ma8tNTKPvFQRWgJIk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726655721; c=relaxed/simple;
	bh=uxI5dEYiU+EcIsaGxIT/w3e4PDDJsiIutJPZcbFqvJA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kLLmRIDDlmxtD2G1mfd9cpF0wfv/WtCZNYuDKvVPr/5IMGhojO/Y27S0x8yt8hoE/GnbJjBYjlm8ak9czKoh/drTyEwjRb4EFW4gVHjYEuxbRBwi+4nCDKxOrs/jsVW7KQ7eX+qZ9x7A1ZhbQY9Y/+PNBUqj/to09gEYxztOBw4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=UMpA2LC5; arc=fail smtp.client-ip=40.107.92.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NTWcZwdSVZD+aPO4nbiYUG0WKzOxOJptubK9PwbJkH+RYBJ4k+VdTmDl4lKrTDp/JsJV7XaZQ4Fwn6z4SiHujHsBMN6+z1vfnzdTskf48IJIXKPSkUn4I4qd6AEJiXEWcaquSjy9FoUb1RR49w7RcXkfGvgZebLyYtj/9dSZltsixJudhdwlmQJGPHwfAUISr9lylOW/gHoxoyiGkKTE+/H4J0Cn5ucGrd+A/uhX1qK1PVKFaRu2Ujsm7468AxnCrE6C+5E1eDjKIykSxlvivKLEkXOWMiAXfifA/ERgntwTlTGGcrCmbnFngId+Mt84R9YW/6kkPeXCPxQyiAZOAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uxI5dEYiU+EcIsaGxIT/w3e4PDDJsiIutJPZcbFqvJA=;
 b=BfiMmv97iBWoMqzEt6KiU8QI0wMHJvCCAd1waYvpo1mj5KOCD082g/tRc5b7FRW5KqllyOigCmC+8SakgHJNGNALqmCdSeL3NwBK4UO6hXenR0nQZuqbNzbUXGee/mRc3UDlX887mGpsvyEsQaO7v1/MWtU2VEy8bzvuSp6kn+WILQLGotF34tBNL9iEfo/DMpajz46KR/NVZ81saoj0e+VM7j9400lDzuvbmIoKqy9Be5H58YuAR+3URPLSDsrB1LnAGo0/nq9FfcX1x7kDwJFDReBGLlbkCBT61tX4kzCm2nCparpwib2/x+pMnpUqA/tXOhmdu+uBLaejM/vzPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uxI5dEYiU+EcIsaGxIT/w3e4PDDJsiIutJPZcbFqvJA=;
 b=UMpA2LC508YNETvOTx+Hroq7EocgvoziIV5aKEu6HvSmmDlCYRNtvryTlGhG/XTH1Vsz3TsykZcsCANFc6XRylTR6oPxPvkDGoxz0bz+gJPqmTS9ITUzKfwcTc3OjHQEaXi314W2e/g5BKesHTxhW+YzsH0zoAqb/tj90tq+l2de4KRxDILCxXncgWpS9I6n1JluCXZURKRIQbNNnyaFqtrdgVMYGbdXpoKBect3nu6oWriyCOJrHFK/GKg3n4yfiFIrHRfD3yMwQLUwi8wjjVLLmd5oLh4YoaPKng90zyXF/SDPQZET6f6yePgztHmeY1WnMddBfCQxpI2kxWHoFw==
Received: from DM6PR11MB4236.namprd11.prod.outlook.com (2603:10b6:5:1d9::20)
 by DS7PR11MB6077.namprd11.prod.outlook.com (2603:10b6:8:87::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.24; Wed, 18 Sep
 2024 10:35:16 +0000
Received: from DM6PR11MB4236.namprd11.prod.outlook.com
 ([fe80::ea6a:8f25:ead5:8dfb]) by DM6PR11MB4236.namprd11.prod.outlook.com
 ([fe80::ea6a:8f25:ead5:8dfb%6]) with mapi id 15.20.7962.022; Wed, 18 Sep 2024
 10:35:16 +0000
From: <Mohan.Prasad@microchip.com>
To: <andrew@lunn.ch>
CC: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>, <shuah@kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<horms@kernel.org>, <brett.creeley@amd.com>, <rosenp@gmail.com>,
	<UNGLinuxDriver@microchip.com>, <willemb@google.com>
Subject: RE: [PATCH net-next v2 1/3] selftests: nic_basic_tests: Add selftest
 file for basic tests of NIC
Thread-Topic: [PATCH net-next v2 1/3] selftests: nic_basic_tests: Add selftest
 file for basic tests of NIC
Thread-Index: AQHbCOSaqY6jyq2GfkWTIKzaGCAXv7JcInmAgAE394A=
Date: Wed, 18 Sep 2024 10:35:16 +0000
Message-ID:
 <DM6PR11MB4236AB0ADF93D8A4EBBC59EF83622@DM6PR11MB4236.namprd11.prod.outlook.com>
References: <20240917023525.2571082-1-mohan.prasad@microchip.com>
 <20240917023525.2571082-2-mohan.prasad@microchip.com>
 <1ad4656f-eb3f-4ecb-9e5d-5846f4f6c3e6@lunn.ch>
In-Reply-To: <1ad4656f-eb3f-4ecb-9e5d-5846f4f6c3e6@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB4236:EE_|DS7PR11MB6077:EE_
x-ms-office365-filtering-correlation-id: 36b11036-5fc1-476f-b9e4-08dcd7cd962c
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4236.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?MDIyaWg2bnR0bmJmL3NHSnRES0w2bVY0UDZ2YTIzNExKUXBEWU1Sam5CeVNB?=
 =?utf-8?B?b1FuUGhXMDBWWFI5ZjQ5V3FpKzZPK1dHNHdlaDU2YW5LZkxscXoxZEVCTkRD?=
 =?utf-8?B?VnJJTzkwK3AySktwU2JJbTcxZkpSaTVKdmpHYStqbHk0MXhrdHBNTTI4NElM?=
 =?utf-8?B?NlZMRGRTRnRybGJkMmRXM3VrczdiNHl5MkthS2xneUozYXViWEZFM0FaWE10?=
 =?utf-8?B?ZFMzQlRSckY4b0MxR0JpQWl2VDlRQ3NCaGhmR3lkdEI1dDB1Q3VLU1dacmpl?=
 =?utf-8?B?WTc5RkJHam5aa296MVZhRkErRkpicnRXWFVrb3ZDMG52REk0Z1QyUG5QUDRE?=
 =?utf-8?B?ekZJTVV3eFd4ZjB5Tkl0WEZoUStxQmFLNmFPTDZrajkvOUI1OFQ5RkUxVFdO?=
 =?utf-8?B?WVlpTmJoRHZtQUVwSEpTWG11QktuMkl2Um9HS2ZlZm5LY1RGZ0xlTk9ZTkMx?=
 =?utf-8?B?Y0ZMQklWRU91ei9DMTlKT2tFU1QxbVE0dHNNVjY2NXA5VUxLL0gwU2dxVFF6?=
 =?utf-8?B?L1E1aXRMQlJZMDNGbnVzWVN2ckN6bC8rZzN6TEpvdVluL0pXMElmaTk0REN1?=
 =?utf-8?B?TUd6YjB3cC9pYy80THRuM0ZKMkFLWWp5SFU3WklPUU41WnVqM0RyR2lvdEtm?=
 =?utf-8?B?bldJU0RUQ24zVm1YekNwNHc3aE5SQzgzYitVaXF2MUlkcnFPVWllRlNXd0l5?=
 =?utf-8?B?SnhjZGlkQmF6NlI1aDAyUE0xbFA0SFRaMHNDS1k4Sk5HQVRrVFhGMXhoWjVY?=
 =?utf-8?B?blExNzhjSUZFYVMzNlFFZG4wNjIzMkZqaEt6b3VnNzJmeU1PcGpKUFpkY0c0?=
 =?utf-8?B?ZWV6eG1rdUVtMHpwUHoxeFZnOFVuYXFGZmNQTXh1Z3FHbHpsUWtLaElqUXZW?=
 =?utf-8?B?RmRsdkxkaDNzR08xZjZlbDRhZjlmL3pyVFZnNHJCNmpoV2ZVUEZQbW12TC9m?=
 =?utf-8?B?VWcvSE5GbktxNHBMSjZrSTZsRTVNcUdNZjlrY0NUQXZPSXdEVnd0dUhER2Nq?=
 =?utf-8?B?K0p2WjhBb2c5dXpsRTYvVE83MXVnQkx6WmI4M21OeFZ3MXJLSndXMWVxUkRR?=
 =?utf-8?B?TVR6ZG5EZFJERzZhbzVmN2VlY09OS2pZeDhUUmpjZWhja0haRG5UMDJxUDlv?=
 =?utf-8?B?TE4wWUJaK0x3ZVpqQnplS1FoZEN5UnJreUdPd3pEMTRsOC9IeFhDM3R3dEU5?=
 =?utf-8?B?TXc3R2hpRVpuMGdPL1BEOTNHRS92dHdyQXg1akVZTEFyMWtnTVBXNmpwYzcy?=
 =?utf-8?B?Z04wYjIwSnRUTFhMVTZubUs3SW9aTFFWRGhhVTNicENnWHNTaUJ6MXRqOGxH?=
 =?utf-8?B?dXVoMmdGUUVteUxLaGpyVExCVkZZbktnam1aZXl5WklsWFJ1aUpyQmtZUndK?=
 =?utf-8?B?SzNSc3VMaitUL3NEdVpyZlNWeDRkSGRDUDFwSHpWeDIzZnhzL2I4dWxkQTRU?=
 =?utf-8?B?MmhWb3lJU2RIL1BUL1VDZjE0YkdydDBFaFY1eHJxSmwraUg1eHFmR0grbkNH?=
 =?utf-8?B?MTZEUldFaVduSlMvVDFWYTRTdkwwaDJGcVhJMENpN3lObzNQQlNqUmhEN2xR?=
 =?utf-8?B?akNxbzRYSFJwWHNHS0ZqM3J6OUJrUm5HdGFrbTVRRlJ5SjkxNTlEa0pJblRZ?=
 =?utf-8?B?bWNHenduQmN0RUw5TG0yS1ZLVTB3S1hkbkhMOG5PWHd6S1NodklEMVFIZFVx?=
 =?utf-8?B?eWhLYS9rTjQ3bDgxbTVIMk9JVkI1N29XR3llWEs3YXBYNXlzWUl1NGVySE5G?=
 =?utf-8?B?cEFaSHVzY3ZwZjFkS2IzbFdicmc3U1BFTDNsMm9kK01zb3dpQTFoYlFTVGdl?=
 =?utf-8?B?U1h6eUxBTm05OERGQUgrVlZwWUdFZjJmdWlXUGxwMG5rYkZ6UnBRVEVGWnFN?=
 =?utf-8?B?UW5HS2VEQmJzbXM5M3JBQU9mQXFCTmNGZGhnZGEyU1kyMmc9PQ==?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VTNuUHNZR1NSYkdPakE3eDduMG5vTFAxQkJCVm4wNXdObk1ZRlpqeEF4ZFRr?=
 =?utf-8?B?QWw1TTJzY2ZxdlhjNzRWcGtLWGpVemVNb2M5VGd1NzZRYWRoU0VTVDdOdGtP?=
 =?utf-8?B?NUtXVWsyM1p2c0JGeDlVOUZ0Y1BJSlBpZVI4amcvTndQYy8xT3RHOG9WejU2?=
 =?utf-8?B?aS9HMTNWUzlpV3VwYk44WmVZQWlwa0FteVhrWkVlVm9VeG8zOEh6SlNvTzlW?=
 =?utf-8?B?NU5QVGYxTDRCK2wrZ2pRQUFYNVY2TE9qbEhYcktQamkyT0g1eWE1dXloTFVo?=
 =?utf-8?B?OGltMlNYRDBvMndzOE9VM0MrMGFMbm1pL2xUVlhlQVBscC9jR25NZHVIYXRZ?=
 =?utf-8?B?bDBmMms0RGtTQmR5VWJyV2dDUnpsSkxNTFhqM3l0VnFYOWoyb0szaHNldVVM?=
 =?utf-8?B?TzF1c25FbzFQblRBV2ZVQ0l1aENZemIzbUIvNmE3NE9qaEVlamxpc2RRVnR2?=
 =?utf-8?B?OFVJNk1KZkpaSDRjT3MvbFFxbU1aYXExZXlMV3UwMmkwME8wcy9hckhVYW5t?=
 =?utf-8?B?OFJ2cjdkRHY1eUc1bkkyWXZuU2JIOG5lTGdPSk5tSDJIRWxVVnVBZWJNLzhz?=
 =?utf-8?B?bEV3Yi9BQzRPR1NmWk95RnNiRmMwS242ak5EZEJlaCtTdVJTaUNac1NzZmpF?=
 =?utf-8?B?a3RXVFJEaXkzTU9VRnJOQUE1R0J6UHpPSlYzdFdiWGxndndRc3RmU2RTZ2lu?=
 =?utf-8?B?Z3BUSS96ZGYwcjJNU1RJck93L2tLQ3BlTFlNUWlkWXN2ZS80SW1JMm9EV09F?=
 =?utf-8?B?Mm9OUFZQWWROYnFzejRzQ0NQWmNzd2hhR3FhaUs4SUNDcFh3YUFJS0cyMTNs?=
 =?utf-8?B?V0dlWmkwZWdzejNhSjF3Sy9xRkI4REpuZnhJTzZ3ZHdtVEEyZFJYbDBzclly?=
 =?utf-8?B?QzFjTzlKWUl6Rld0Y0RWb0ZUekY4U0tTSGovYzdTektUelFnWGhSV3l6Q1l5?=
 =?utf-8?B?U0FWR0xqYjVMSFlpOVNNVUJYSkZRdGdiTUcwVkszMjE4cjFwbDhObU5PNWhY?=
 =?utf-8?B?NFJtUTdGREcxbEdSR01QRlA5OGlyaXR4TFB3MkFRbEtDUm45NFN5TExCd1Zp?=
 =?utf-8?B?YUxLay9TSStsaVJoV2xsS1FNSGdpZms3RTBpN3dZQlJXTmcydC9iNEYvY0J3?=
 =?utf-8?B?Z21yd014WlI1S2ZPVmRkbVBFelpuRnUwdEg4RFhuVENicnc2dHZRQjFmNXJl?=
 =?utf-8?B?Q0VOZUJRWXM1UzBIdm9FOGNzRjViamJ6YVVzRDd4cHRkRnhtYXYwRDVaeHk0?=
 =?utf-8?B?NjhGYlFDRFh6UjM1NWYxalpqZUxIQUtKdUpIb0pFS3BvT0YxZDVUKzBGcDdD?=
 =?utf-8?B?M0t5dFVtVEZNZDRpczh2QjhCaDNucmxYWHdhU05HaW9tMWRBdTBpSjN5dEVs?=
 =?utf-8?B?QnB1cGIzT1BaVzRhNFlzaVowZEtFOXB3UjF0TnIxdEhVZFNXd1VUMXF6Y1RP?=
 =?utf-8?B?ZEpOSVFVZW1CVVpJWHNyZzBLa2JBY3NzQzNTNUpwSHZRalNNRmlFUjBRdHhF?=
 =?utf-8?B?eXQ3ZWdOS3orektTM09zVU5CUzhjTHlSU0xDcFhKWitMRCs0dHdObDF5NW1j?=
 =?utf-8?B?RTdpbzZKRmoyR3Nza3J1NURxSXV5cmhMbkNoK2hIS3dWM0diOVQ3T3RsN0FM?=
 =?utf-8?B?Vm9mNlAvYTZWMkJHdXdsUXVxVE9MaFoyRjJQWW9CMmRlSm8vRUJOWVpYb21Y?=
 =?utf-8?B?cGJoSlpENDVJTldsNWNYaTdlL2VXb05LNGRhdXpReVc0blhPMGdHSUpCc3ls?=
 =?utf-8?B?NnB5TVNzS3Q1RVVraGtZU1VUaDJLdk1VZTU4YnJOdll1YmFHaTdwMDRlQ01T?=
 =?utf-8?B?ZXROd3cyQVhObWxWbW5NcXY2VjNxQzZOVGdqWld1MGc3ZnQ4ZUozaVJEQzFN?=
 =?utf-8?B?T1VwNlJGR2dtNUVkOUhSUFlFcmxnaTdGbjg5ZGh6V2FQcmlWcGlKbTIvUGQ0?=
 =?utf-8?B?TEtCSHF6eWdzR0l6aGVZVHlPcTFjcXdyTkpsSGdKOGxyMWdzNmR3TGkvSlc1?=
 =?utf-8?B?cjlYUm54N3ZycjRYSWp2Q3J6SGtzMXBiQ2JkV2NUR2wxdGh0V1Z6c1NkSnZW?=
 =?utf-8?B?a0NBRjN3SFpRdGNGUkg5WDRHSUdmMUF6QWg2MFNGWnUyNzlMK1QxSXJyYmdM?=
 =?utf-8?Q?2RBWJ5AIk3qoRRFgHXGLJVY7T?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4236.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36b11036-5fc1-476f-b9e4-08dcd7cd962c
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2024 10:35:16.7032
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FSxStIHd2a/Ei6O/wron8bpuMZGykWLIAu1ofjGH/yvxOwwLYSP5157QflST4txlsbjcpWtu88I3fSIvMW0UyGiJQyo+rshw3pJu6DSvkXw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6077

SGkgQW5kcmV3LA0KDQpUaGFuayB5b3UgZm9yIHRoZSByZXZpZXcgY29tbWVudHMuDQoNCj4gRVhU
RVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVz
cyB5b3Uga25vdyB0aGUNCj4gY29udGVudCBpcyBzYWZlDQo+IA0KPiBPbiBUdWUsIFNlcCAxNywg
MjAyNCBhdCAwODowNDowN0FNICswNTMwLCBNb2hhbiBQcmFzYWQgSiB3cm90ZToNCj4gPiBBZGQg
c2VsZnRlc3QgZmlsZSB0byB0ZXN0IGJhc2ljIGZlYXR1cmVzIG9mIGEgTklDIGRyaXZlci4NCj4g
PiBUZXN0cyBmb3IgbGluayBtb2RlcywgYXV0by1uZWdvdGlhdGlvbiBhcmUgcGxhY2VkLg0KPiA+
IFNlbGZ0ZXN0IG1ha2VzIHVzZSBvZiBrc2Z0IG1vZHVsZXMgYW5kIGV0aHRvb2wuDQo+ID4gQWRk
IHNlbGZ0ZXN0IGZpbGUgaW4gdGhlIE1ha2VmaWxlLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTog
TW9oYW4gUHJhc2FkIEogPG1vaGFuLnByYXNhZEBtaWNyb2NoaXAuY29tPg0KPiA+IC0tLQ0KPiA+
ICAuLi4vdGVzdGluZy9zZWxmdGVzdHMvZHJpdmVycy9uZXQvaHcvTWFrZWZpbGUgfCAgIDEgKw0K
PiA+ICAuLi4vZHJpdmVycy9uZXQvaHcvbmljX2Jhc2ljX3Rlc3RzLnB5ICAgICAgICAgfCAxNDUg
KysrKysrKysrKysrKysrKysrDQo+ID4gIDIgZmlsZXMgY2hhbmdlZCwgMTQ2IGluc2VydGlvbnMo
KykNCj4gPiAgY3JlYXRlIG1vZGUgMTAwNjQ0DQo+ID4gdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMv
ZHJpdmVycy9uZXQvaHcvbmljX2Jhc2ljX3Rlc3RzLnB5DQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEv
dG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvZHJpdmVycy9uZXQvaHcvTWFrZWZpbGUNCj4gPiBiL3Rv
b2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2RyaXZlcnMvbmV0L2h3L01ha2VmaWxlDQo+ID4gaW5kZXgg
YzlmMmY0OGZjLi45ZjEwNTIyN2MgMTAwNjQ0DQo+ID4gLS0tIGEvdG9vbHMvdGVzdGluZy9zZWxm
dGVzdHMvZHJpdmVycy9uZXQvaHcvTWFrZWZpbGUNCj4gPiArKysgYi90b29scy90ZXN0aW5nL3Nl
bGZ0ZXN0cy9kcml2ZXJzL25ldC9ody9NYWtlZmlsZQ0KPiA+IEBAIC0xMCw2ICsxMCw3IEBAIFRF
U1RfUFJPR1MgPSBcDQo+ID4gICAgICAgaHdfc3RhdHNfbDMuc2ggXA0KPiA+ICAgICAgIGh3X3N0
YXRzX2wzX2dyZS5zaCBcDQo+ID4gICAgICAgbG9vcGJhY2suc2ggXA0KPiA+ICsgICAgIG5pY19i
YXNpY190ZXN0cy5weSBcDQo+ID4gICAgICAgcHBfYWxsb2NfZmFpbC5weSBcDQo+ID4gICAgICAg
cnNzX2N0eC5weSBcDQo+ID4gICAgICAgIw0KPiA+IGRpZmYgLS1naXQgYS90b29scy90ZXN0aW5n
L3NlbGZ0ZXN0cy9kcml2ZXJzL25ldC9ody9uaWNfYmFzaWNfdGVzdHMucHkNCj4gPiBiL3Rvb2xz
L3Rlc3Rpbmcvc2VsZnRlc3RzL2RyaXZlcnMvbmV0L2h3L25pY19iYXNpY190ZXN0cy5weQ0KPiA+
IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+ID4gaW5kZXggMDAwMDAwMDAwLi4yN2Y3ODAwMzINCj4g
PiAtLS0gL2Rldi9udWxsDQo+ID4gKysrIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvZHJpdmVy
cy9uZXQvaHcvbmljX2Jhc2ljX3Rlc3RzLnB5DQo+ID4gQEAgLTAsMCArMSwxNDUgQEANCj4gPiAr
IyEvdXNyL2Jpbi9lbnYgcHl0aG9uMw0KPiA+ICsjIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBH
UEwtMi4wDQo+ID4gKw0KPiA+ICsjSW50cm9kdWN0aW9uOg0KPiA+ICsjVGhpcyBmaWxlIGhhcyBi
YXNpYyB0ZXN0cyBmb3IgZ2VuZXJpYyBOSUMgZHJpdmVycy4NCj4gPiArI1RoZSB0ZXN0IGNvbXBy
aXNlcyBvZiBhdXRvLW5lZ290aWF0aW9uLCBzcGVlZCBhbmQgZHVwbGV4IGNoZWNrcy4NCj4gPiAr
I0Fsc28gaGFzIHRlc3RzIHRvIGNoZWNrIHRoZSB0aHJvdWdocHV0ICMNCj4gPiArI1NldHVwOg0K
PiA+ICsjQ29ubmVjdCB0aGUgRFVUIFBDIHdpdGggTklDIGNhcmQgdG8gcGFydG5lciBwYyBiYWNr
IHZpYSBldGhlcm5ldA0KPiA+ICttZWRpdW0gb2YgeW91ciBjaG9pY2UoUko0NSwgVDEpICMNCj4g
PiArIyAgICAgICAgRFVUIFBDICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIFBhcnRuZXIgUEMNCj4gPiArI+KUjOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKU
gOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUkA0KPiDilIzilIDilIDi
lIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDi
lIDilIDilIDilIDilIDilJANCj4gPiArI+KUgiAgICAgICAgICAgICAgICAgICAgICAg4pSCICAg
ICAgICAgICAgICAgICAgICAgICAgIOKUgiAgICAgICAgICAgICAgICAgICAgICAgICAg4pSCDQo+
ID4gKyPilIIgICAgICAgICAgICAgICAgICAgICAgIOKUgiAgICAgICAgICAgICAgICAgICAgICAg
ICDilIIgICAgICAgICAgICAgICAgICAgICAgICAgIOKUgg0KPiA+ICsj4pSCICAgICAgICAgICDi
lIzilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilJAgICAgICAgICAgICAgICAgICAg
ICAgICAg4pSCICAgICAgICAgICAgICAgICAgICAgICAgICDilIINCj4gPiArI+KUgiAgICAgICAg
ICAg4pSCRFVUIE5JQyAgICDilIIgICAgICAgICBFdGggICAgICAgICAgICAg4pSCICAgICAgICAg
ICAgICAgICAgICAgICAgICDilIINCj4gPiArI+KUgiAgICAgICAgICAg4pSCSW50ZXJmYWNlIOKU
gOKUvOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKU
gOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUvOKUgCAgICBhbnkgZXRoDQo+IEludGVyZmFjZSAgICDi
lIINCj4gPiArI+KUgiAgICAgICAgICAg4pSU4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA
4pSA4pSYICAgICAgICAgICAgICAgICAgICAgICAgIOKUgiAgICAgICAgICAgICAgICAgICAgICAg
ICAg4pSCDQo+ID4gKyPilIIgICAgICAgICAgICAgICAgICAgICAgIOKUgiAgICAgICAgICAgICAg
ICAgICAgICAgICDilIIgICAgICAgICAgICAgICAgICAgICAgICAgIOKUgg0KPiA+ICsj4pSCICAg
ICAgICAgICAgICAgICAgICAgICDilIIgICAgICAgICAgICAgICAgICAgICAgICAg4pSCICAgICAg
ICAgICAgICAgICAgICAgICAgICDilIINCj4gPiArI+KUlOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKU
gOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUmA0KPiDilJTi
lIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDi
lIDilIDilIDilIDilIDilIDilIDilJgNCj4gPiArIw0KPiA+ICsjQ29uZmlndXJhdGlvbnM6DQo+
ID4gKyMgQ2hhbmdlIHRoZSBiZWxvdyBjb25maWd1cmF0aW9uIGJhc2VkIG9uIHlvdXIgaHcgbmVl
ZHMuDQo+ID4gKyMgIiIiRGVmYXVsdCB2YWx1ZXMiIiINCj4gPiArc2xlZXBfdGltZSA9IDUgI3Rp
bWUgdGFrZW4gdG8gd2FpdCBmb3IgdHJhbnNpdGlvbnMgdG8gaGFwcGVuLCBpbiBzZWNvbmRzLg0K
PiA+ICt0ZXN0X2R1cmF0aW9uID0gNSAgI3BlcmZvcm1hbmNlIHRlc3QgZHVyYXRpb24gZm9yIHRo
ZSB0aHJvdWdocHV0IGNoZWNrLCBpbg0KPiBzZWNvbmRzLg0KPiA+ICt0aHJvdWdocHV0X3RocmVz
aG9sZCA9IDAuOCAjcGVyY2VudGFnZSBvZiB0aHJvdWdocHV0IHJlcXVpcmVkIHRvIHBhc3MNCj4g
PiArdGhlIHRocm91Z2hwdXQNCj4gPiArDQo+ID4gK2ltcG9ydCB0aW1lDQo+ID4gK2ltcG9ydCBv
cw0KPiA+ICtpbXBvcnQgcmUNCj4gPiAraW1wb3J0IGNvbmZpZ3BhcnNlcg0KPiA+ICtpbXBvcnQg
anNvbg0KPiA+ICtmcm9tIGxpYi5weSBpbXBvcnQga3NmdF9ydW4sIGtzZnRfZXhpdCwga3NmdF9w
ciwga3NmdF9lcSBmcm9tIGxpYi5weQ0KPiA+ICtpbXBvcnQgS3NmdEZhaWxFeCwgS3NmdFNraXBF
eCBmcm9tIGxpYi5weSBpbXBvcnQgTmV0RHJ2RXBFbnYgZnJvbQ0KPiA+ICtsaWIucHkgaW1wb3J0
IGNtZCBmcm9tIGxpYi5weSBpbXBvcnQgZXRodG9vbA0KPiA+ICsNCj4gPiArIiIiR2xvYmFsIHZh
cmlhYmxlcyIiIg0KPiA+ICtjb21tb25fbGlua19tb2RlcyA9IFtdDQo+IA0KPiBTb2Z0d2FyZSBl
bmdpbmVlcnMgaGF2ZSBhIGRpc2xpa2UgZm9yIGdsb2JhbCB2YXJpYWJsZXMuIEluIHRoaXMgcGF0
Y2gsIGl0IGlzIG5vdA0KPiBldmVuIHVzZWQuIFBsZWFzZSBjb25zaWRlciByZXBsYWNpbmcgaXQg
YnkgcGFzc2luZyBpdCBhcyBhIHBhcmFtZXRlciwgb3IgdHVybg0KPiB0aGUgY29kZSBpbnRvIGEg
Y2xhc3MgYW5kIG1ha2UgaXQgcGFydCBvZiBzZWxmLg0KDQpJIHdpbGwgY2hhbmdlIHRoaXMgaW4g
dGhlIG5leHQgdmVyc2lvbi4NCg0KPiANCj4gPiArZGVmIHRlc3RfbGlua19tb2RlcyhjZmcpIC0+
IE5vbmU6DQo+ID4gKyAgICBnbG9iYWwgY29tbW9uX2xpbmtfbW9kZXMNCj4gPiArICAgIGxpbmtf
bW9kZXMgPSBnZXRfZXRodG9vbF9jb250ZW50KGNmZy5pZm5hbWUsICJTdXBwb3J0ZWQgbGluayBt
b2RlczoiKQ0KPiA+ICsgICAgcGFydG5lcl9saW5rX21vZGVzID0gZ2V0X2V0aHRvb2xfY29udGVu
dChjZmcuaWZuYW1lLCAiTGluaw0KPiA+ICtwYXJ0bmVyIGFkdmVydGlzZWQgbGluayBtb2Rlczoi
KQ0KPiA+ICsNCj4gPiArICAgIGlmIGxpbmtfbW9kZXMgYW5kIHBhcnRuZXJfbGlua19tb2RlczoN
Cj4gPiArICAgICAgICBmb3IgaWR4MSBpbiByYW5nZShsZW4obGlua19tb2RlcykpOg0KPiA+ICsg
ICAgICAgICAgICBmb3IgaWR4MiBpbiByYW5nZShsZW4ocGFydG5lcl9saW5rX21vZGVzKSk6DQo+
ID4gKyAgICAgICAgICAgICAgICBpZiBsaW5rX21vZGVzW2lkeDFdID09IHBhcnRuZXJfbGlua19t
b2Rlc1tpZHgyXToNCj4gPiArICAgICAgICAgICAgICAgICAgICBjb21tb25fbGlua19tb2Rlcy5h
cHBlbmQobGlua19tb2Rlc1tpZHgxXSkNCj4gDQo+IFlvdSBjYW4gdXNlIHRoZSBwb3dlciBvZiBw
eXRob24gaGVyZS4NCj4gDQo+ICAgICAgICAgInN1cHBvcnRlZC1saW5rLW1vZGVzIjogWw0KPiAi
MTBiYXNlVC9IYWxmIiwiMTBiYXNlVC9GdWxsIiwiMTAwYmFzZVQvSGFsZiIsIjEwMGJhc2VUL0Z1
bGwiLCIxMDAwYmFzZVQvDQo+IEZ1bGwiIF0sDQo+ICAgICAgICAgImxpbmstcGFydG5lci1tb2Rl
cyI6IFsNCj4gIjEwYmFzZVQvSGFsZiIsIjEwYmFzZVQvRnVsbCIsIjEwMGJhc2VUL0hhbGYiLCIx
MDBiYXNlVC9GdWxsIiwiMTAwMGJhc2VULw0KPiBGdWxsIiBdLA0KPiANCj4gY29udmVydCB0aGUg
bGlzdCBpbnRvIGEgc2V0LCBhbmQgdGhlbiB1c2UgJ2FuZCcuDQo+IA0KPiAgICAgICAgIGNvbW1v
bl9tb2RlcyA9IHNldChqb3NuWydzdXBwb3J0ZWQtbGluay1tb2RlcyddKSBhbmQgc2V0KGpzb25b
J2xpbmstDQo+IHBhcnRuZXItbW9kZXMnXSkNCg0KSSBhbSBmaWd1cmluZyBvdXQgdGhlIHdheSB0
byBnZXQgdGhlIGV0aHRvb2wgb3V0cHV0IGluIGpzb24gZm9ybWF0Lg0KT25jZSBzdWNjZXNzZnVs
LCBJIHdpbGwgY2hhbmdlIHRoaXMgaW1wbGVtZW50YXRpb24gYXMgc3VnZ2VzdGVkIGluIG5leHQg
dmVyc2lvbi4NCg0K

