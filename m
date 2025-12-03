Return-Path: <linux-kselftest+bounces-46924-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D7CF3C9D688
	for <lists+linux-kselftest@lfdr.de>; Wed, 03 Dec 2025 01:37:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AAB324E03F8
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Dec 2025 00:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2B8E22B594;
	Wed,  3 Dec 2025 00:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="i4vhVeLV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C3DA20ADF8;
	Wed,  3 Dec 2025 00:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764722201; cv=fail; b=o+AGj5m4W5MHMqFtBpFyPsrUjYEOnAntmLSQnk8ej1FOD1zITSCpQJwRx+RuAK97rDO3urxJ4K3gJG2KJiVykcv4euErFylsdNAFXFDm1ghZKRiDCQePDGdNEMy1TlXf1OyfUZ/QxmeM51FOGtTaVWj5Ea6PBd+mNLftpmIUr+c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764722201; c=relaxed/simple;
	bh=EfoosfDefOtovU6xlS2gRLaNND7PB/CRcyRvt0w81lU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=L6vz9MmEY2OwlmRJV2PSm81+l/9zekLHbG/XkusZV+sv2ciwuygsjn+vMqc2WjjYsBIjOExvZV15NS7yLYIEQwg7ZY6PRdYvymc4JpfSTjNqrgiggb0uN+hy9Do3Qjb7grtxOZlmW+TAIzeFT1DTflUyIDmLU4UogAz9q3TjDdQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=i4vhVeLV; arc=fail smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5B2MBw4t1940602;
	Tue, 2 Dec 2025 16:36:26 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=pb0XWhW2oKN0H4iK9gFZkAlxTopYjSXJrSkJ7AwL2TI=; b=i4vhVeLVoXFA
	UgIHYacYMbbM0AUMN3phbdXLxrg9LI25CAvMZFSE1fvEOsfS0WWBifQ++vHZOfDM
	63yCE+2U7nZs3hORayGd0PXsyZQoH9TzsqpJo4WD8mIoGWs7kMWX6CaoGzN9eGa8
	o+hUlnwhO4myQgy5pjKQYRNw5hX40L9lDzwWpqUe319mIhNDSBo8B8bjF9nXE+0C
	JDx6BP/w3CA/s3yaCgrnsHZWYxAjnie4hdYgbnlg+zeXaQzxWgoCTDnpKdiT7eDK
	Le4dNXqaVvAx1FegoXNmoXvG/HDZoxvKWKdNOBHDb3vIZ84WRSFh5+rTBywHonuO
	DAdoji9NXw==
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010054.outbound.protection.outlook.com [52.101.85.54])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4at8pr8y29-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 02 Dec 2025 16:36:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=clot2ct9t+0oVrhSoLpF3rSzgDki66i2ZSE3aBA0o7QgOeYE1sJpDso6B8D7RuApwNmi30eFDHZ9KbsEQz2dyS1VzzzN8lqMJT0tU20/xnJycqm9H5k32UhFV7hwBLmjA3b47g4D2QVUFHSrsqoQJFrzCi2S4k2RS3mIvIhPFiEPN7ac0s4me7BwsHO9rgPIWPy66w4SlKltqeewC/J4BLDwPFJZR0dlUNAGkPrJGuZI+VglgPNVp8I00DUgA0JYsl7u93PBhdqZrzAbaPvGnj167iznYatll7lYhmV7BqcZOuTxgr1jGaS6O1jxwPdh0EQ1SxArHq3ov46Y/8LBaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pb0XWhW2oKN0H4iK9gFZkAlxTopYjSXJrSkJ7AwL2TI=;
 b=XtEiI3xhgsoBN8q/i1ntYZCbVelKziyIo4Wcc/KUlMpBfgvJMEtB81wIG9gXAJ9iMfeD0DpMXdTtJ9fPT3J8UPlh/t8PpKQYnIXnWh59EWU+DDU74pLaO8TJpV1AHczkWE97mntdk020uqrNzM4YLybAh7zzg85hJ58Q/jOAIC3YQBIVaBUjMeVfxcHgzz/fh1jj4sKFXz3wZinAo7gxtNj7crYiyYbxwOh2nsNe6K+KTC2i0PuU9Un548AXzRDALNG3xeFoRplI+FDriBMjZvW9z+QGo8PSapA8zOK+LinICt6YZoebtsoKkeMx0dJsdTJA6LNbIaiGukKD+mGKGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from LV3PR15MB6455.namprd15.prod.outlook.com (2603:10b6:408:1ad::10)
 by SJ4PPFE0F24BAED.namprd15.prod.outlook.com (2603:10b6:a0f:fc02::8ce) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Wed, 3 Dec
 2025 00:36:24 +0000
Received: from LV3PR15MB6455.namprd15.prod.outlook.com
 ([fe80::8102:bfca:2805:316e]) by LV3PR15MB6455.namprd15.prod.outlook.com
 ([fe80::8102:bfca:2805:316e%5]) with mapi id 15.20.9366.012; Wed, 3 Dec 2025
 00:36:24 +0000
Message-ID: <18bccfd5-ad55-45e8-8d9f-7f3ed2aac21e@meta.com>
Date: Tue, 2 Dec 2025 19:36:07 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC/RFT net-next v2 1/5] net: dsa: deny bridge VLAN with
 existing 8021q upper on any port
To: Simon Horman <horms@kernel.org>
Cc: Jonas Gorski <jonas.gorski@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller"
 <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <vladimir.oltean@nxp.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <CAOiHx=mog+8Grm1QTnqU_F3=BnWmJqTj+ko-nZiRMAb4-hvSqw@mail.gmail.com>
 <20251201224855.4102774-1-clm@meta.com> <aS8Q7yCvvhXn5iYu@horms.kernel.org>
From: Chris Mason <clm@meta.com>
Content-Language: en-US
In-Reply-To: <aS8Q7yCvvhXn5iYu@horms.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL0PR05CA0015.namprd05.prod.outlook.com
 (2603:10b6:208:91::25) To LV3PR15MB6455.namprd15.prod.outlook.com
 (2603:10b6:408:1ad::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR15MB6455:EE_|SJ4PPFE0F24BAED:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f68eb9f-cb2d-4ad9-69f9-08de3203fce7
X-LD-Processed: 8ae927fe-1255-47a7-a2af-5f3a069daaa2,ExtAddr
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?TmU0YzZjNHhlaVhlU2xFUHJYNUN2b1d6eGQ5UzRDbURKbGV0ZGQ3Z1p5Z3lm?=
 =?utf-8?B?YVZLNHNCRFBvQ3VBNDE1NE9MSDJydHBjWi9OMThsZlVpVTlaWmhZVVJGQWdr?=
 =?utf-8?B?d0lTdmxtY0JNN0drWmdBZ0JHZ3dqSDlXSDBVSEMvM0NHNExZcUFwbElkU3kx?=
 =?utf-8?B?MXJQQjdoK2dYZnZtcytiTmV2b0QraTlVSUphZEJCQ0NMQjZhMlA4cUUrUlcw?=
 =?utf-8?B?WUJialE5ejlYcmtpODk3bHRIL1puQzhhZ25BeStoNTRZMGlIUW80SGpIbmtI?=
 =?utf-8?B?eUdLSk0zVnNLbnFybEEzMUxTa3NFb3FYeE5ManFjbk0vd2tmTHd6U0lFZ3hM?=
 =?utf-8?B?RVVWOUtVaHVwV3doVXFBSllaMDY5aUQ3NE9rMjZvV0x5QXF0dmFPNjYrYUdB?=
 =?utf-8?B?TTFFWWErdHBUYzZHbllTTStZT3IzVXNRbDA1bEk5ZnVRNVlocG4xYldra1E1?=
 =?utf-8?B?cFpFWExjbjYyb3dlOHhFQ0dwNSszL0NoaDRCbmdhQUcyekRmSXNCRHBaa0dO?=
 =?utf-8?B?MVJ0NG9NUEZMemxSd2ZTZ1lMZ2s3aFNxaUh0bTE1dUhGbmhuQ0lCTXpxR2Ir?=
 =?utf-8?B?bytYR0ptTHBhNFE5US9TNGhTQXRlZVQwRk8zOG1OS0MwUmg4bHEwYnIwODNX?=
 =?utf-8?B?YmFSQ2ZEd0w2YTE3RHJzSzg2TDlmaE5ZdkJvcCtSN2hDbndhbmpEMmVoN1B2?=
 =?utf-8?B?bGpYYnhqdkZ1b1BhZ0JEUmc3SWhuMXRnNlpwL2w5bTB4NXhvd3BZckNRMCtx?=
 =?utf-8?B?dlNiaE1oQ1c4dTJQMUpwQ1pydGZ3Rys1c2pPWTJMUXpoZG0wTk84dHpueWYy?=
 =?utf-8?B?Z0tnbWdBajFJR2VoWjFtZFVYTVhNbC9ZZVNMd2t0ZzV5NWRBZjA0L0tiM21w?=
 =?utf-8?B?ZmRoZDQvSDdsbFptQTFkN054UW91YzhtM3pvakwzbVNMcWpFTVMrRWRnQlBK?=
 =?utf-8?B?ejJGa3FVdGVzQVV3aEQvZm81RjMyMVZUSnFpUWJWY2JHZGU3c3J6UTlHSUY0?=
 =?utf-8?B?dUI5TmFQZDlobUNtYmVvd2ZJdmRsWXpzRnlrcEE4bTFhd0FlbGkxVjU1MXhH?=
 =?utf-8?B?T1BSZHZmWlJvQ1E2WU03U0tBelBoZWhOMGhyQllrNXI1bE5uSTJ2TTFFcXpZ?=
 =?utf-8?B?UDFWTHNkM2ZqY3NUKzZEbHVIRk41QW53U0RiVGkyK3VDSEdiQk5qVUxpQXFy?=
 =?utf-8?B?WSsybGdEOVIzWXZLaHFqbDh2UU81cnVlZ1BLSkxpRXpSWTBlT3NWaDRNTi90?=
 =?utf-8?B?OFRvWVNhQmNyT2VmR2MzT3VJK01yZzBTTVh1SzVxQXZxMG1WdUY5NWZRcFBO?=
 =?utf-8?B?dG5tYU9nSTN6emRPakdCaVlKRjB2bTZ1Y3JVUXppSXhvczkyVG5RMTViUkdl?=
 =?utf-8?B?SHVoeVo2UFVLMGRaVGdYMWVPaTdDTTFMM1JGV0NSYnhaS0dtM2lnb3c5TklE?=
 =?utf-8?B?SER1TWF5WDdueWFQa1FaT2c0SUVsTy81WUlUSE1pVkVvZDF0OGFYYVdyT2tt?=
 =?utf-8?B?dGJtZmduQjkyZmRYVHNtSU1Kc3pQRStQcEZFYVV0cTVZTjkzQ1VuNFNBMDcr?=
 =?utf-8?B?VzJScjVEMkp0M3Q2QldsRE1TdW5yd1hIblMyL3VvbHhLUzB5RVorR09SZmpU?=
 =?utf-8?B?WHBPcjlzY1N4eEdzU0traDhvQmVxaFFYbjVaaVc2SHdiRjRoOGE2NlU1Yk1W?=
 =?utf-8?B?L2sxYlJkeFdIUjN4Vmp5ZjNQMndDWkMrTjFzSldZeDRFVkJ4TjVEZXJVSjNs?=
 =?utf-8?B?TURsR3AwdkxzekVBck9zMkRHMlFKUm82cnBrbDAwQ2ErR09QUkMreDJlYUF0?=
 =?utf-8?B?dTNqR1hZbHJBYW01Q1pqVkdaSkxQU3kvQ3doa1JYREE1cnVzenRrb3VnVEEr?=
 =?utf-8?B?WnZrQ3lrUFFLY3NIOXJMdHE1WU0zTTBvaG5OMUJaZEFEZlowNXlUbVBRdEsy?=
 =?utf-8?Q?0OzpMX8B1dD/98JxzjicidXZ+w3AcZ/Y?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR15MB6455.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?MGE4Zi84UXhhT283SWdINzgzclU4cTV4TjF2ejlKZlZxWUpnb21nSTkyWnFB?=
 =?utf-8?B?TDgwaWpaZ2Y1cEpJczJuMnBtOHFKdGp0Z0NGb3FMRTY4cnAxNnp0Y0tRMlRL?=
 =?utf-8?B?cU1sN0pHU0NaSlJJWUs4Uy9uSkwxVnh4WUpYMVRkMHNuTFB6T05SV2xGZjJ6?=
 =?utf-8?B?Z2lRa2c3a3p0NGMzQzFCcnVKRnYyUUVJTTRQY0RhZXZ4NEVVN3g2d1k3dTJL?=
 =?utf-8?B?aGk5TWNBU2UzTW9iU04rV0RzSmord2kvWVBpUkoyRmd0RW1iVGpEZElKcUhX?=
 =?utf-8?B?b2VvdlpZekVJdlZXL1JLZGFVYnBjSW5vaE1wU1lnamV1Tm1INFM0WDd0azVQ?=
 =?utf-8?B?eS9HbjlzWDA5WjlaRHphekdvOGh3MXBLNHdveDFSam12bWo5QXFXNVRTU05T?=
 =?utf-8?B?czIyeWxPelYxdEhpYUM4bkpKZXZDWlo2U0hLSUh0LzNLNEQ4aHphVHV4eXRN?=
 =?utf-8?B?cUdyQ1BOdk9pTWgrYVNEZk93VkZTN0JmOEFZRlBsS3J4L1MxL3JBQ0g3aWJK?=
 =?utf-8?B?ekpzMEVneTRsUGlTRE5Ka1RSZFQxU2Y0YVhuSGowMUUxMXk0cTlXV2NWRVNm?=
 =?utf-8?B?UDUxeU5SaURtc0VYNWpEUUZDMGl3YW9BcFd4bnM0YVBhNy9taDUwWStXRHpC?=
 =?utf-8?B?dmgyTm9QbWVLTE1zdWxkbWttMkErcWpvaXh1NkdFMGNpRitjWTdqeGRaeUk5?=
 =?utf-8?B?Ni83bVFrRTFhaG9Eci9hNS9HK3p0bFJYbkRpNGFmWDA1b0pKaCtSTkszMjA0?=
 =?utf-8?B?dzE5a3R6MnZISlRncUo1aFA1SDhhV2w2ZUYxYXh1NXMvVWswZWMwTVV0OHJ5?=
 =?utf-8?B?QWVrdW9xWndSWUlud29Ub0pIQmJpMFRtc2VVY1BRa0NQNVlFN1lFbTR5U2pv?=
 =?utf-8?B?dmVVNzFnQVMxdytBSmlkVzBzNDArOFA1c29PRGpJakM3UVFJa21WOVh3N0ZX?=
 =?utf-8?B?Wm9UY2ZEcVNPUW5DOWtjSUFCRjRYUUk3K3B1NUE1SndnV2VIWWpFVGcrbW1u?=
 =?utf-8?B?MzJaTmFBblJpMzNsdytURjZJbE9NM29CUVlEclV1VzRac2szN3RNclorVlNQ?=
 =?utf-8?B?UzRtYldIejNWc05MQU5YSHlkQlMzSVdTK2VoVzdYR2xZd0hwamFHQXhCY2lF?=
 =?utf-8?B?b2pRZnAxVEppdVFtdXhvUzZ2WlJXb0NKYi9LRVc4Q3hObU1VODdsMzZiK3J2?=
 =?utf-8?B?bU1GYlpEY0d6RGFxWngzVjRmSzM0M0h5VEdpalBzbUVEL09hRFpqbmQzTmo2?=
 =?utf-8?B?MGJEOHBzQUkwdUZITjF4c2hlYzRwN21IUkxmZkRMQmlNNmRsUlNXd0RyaGNW?=
 =?utf-8?B?MVBzOWpjYVNzWXl3MEFyWGJGRjgva2E2cXhHeml0bndrbHU4c2cwN2xPb1BT?=
 =?utf-8?B?RHRxT3cwV010cEErL1gvTTBZM2xXMjRqQzZqdzRkelFWZWEzdzZJczE2bFlR?=
 =?utf-8?B?aGxHUDhxOW1YTnhWN2Z1bi9RUmlYVnJtbWdrdEFybGpIa3phNmE0K01sV0xD?=
 =?utf-8?B?ZW1HalVBQ0x3aHJMTjgzcE05c0pEbjFNU3FsWGVhSlFPUWVPLzEraWpyTUs5?=
 =?utf-8?B?b2p4VnVJWUdrNlVkRlF3bFhqV05lWlFrc1p2QS9QNEZWdXhQSko4d29xcDRm?=
 =?utf-8?B?RlE5dzIwZnlmNVRaVHlDWlZVKzBLdGV1OUdXb1FxV21waFFOdTY2NVRrMThD?=
 =?utf-8?B?NEtPQlZuWjNxUWdValVzajlBQVJVK3RsNjdFZDhNU1dNSDNQd0dFbUp2Vm91?=
 =?utf-8?B?T2I3SFcxY21Ha2l3V2tBc0ViU3ZMYkJsZGZBMEczb1VZRmlMNEpQQ05XWWtz?=
 =?utf-8?B?TjMwRTBQc1g5clZCSm5ubTlkbDRvODloc2JJQzRSUnVJbWpZTXg1dWFPcWVN?=
 =?utf-8?B?WDQwN0M5b0p5cE9CK0M2RDd5dGQ1LzZuVmVYbWtRWjZiMW5iTHhuSlhyTGZQ?=
 =?utf-8?B?UDdhZDEzTm9YRlpqalFMMzU4NUVFZ1cycVdoMFpGSEtFSFRGV0hvcUE4NXc4?=
 =?utf-8?B?bXNBZjk4YVByalBLYm5POTNvV1RpU2hjbm4rbGtHZzZYWjUvMjhJZkh5cVhj?=
 =?utf-8?B?MGZvOG9QTnh2THYrUVJ0aG1heENTTXI4YVprTTRpRU85Wjd6TXI0WDJnZlM5?=
 =?utf-8?Q?CC2Y=3D?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f68eb9f-cb2d-4ad9-69f9-08de3203fce7
X-MS-Exchange-CrossTenant-AuthSource: LV3PR15MB6455.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2025 00:36:24.3673
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UvjmR3lQjTMRnJD6lgBhC7bq36EtobGMg+lF0Npjwil06F7t9I/sLJpRPdFw0ZZ/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ4PPFE0F24BAED
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjAzMDAwMiBTYWx0ZWRfX9RVzQJ3976F0
 JcK3e7lNnq+8nVpirf019MTGSkJLQUf39yDmDJaU0V4yYIVPQULNsxC8opB2RQJ6dfylQDiabHG
 lcRPgH/WHQaoTZVrNcejQaGIDFvDYpS6aBHZsHqtsFJdrTL83wIVnD58u3jFc/JuuxrdzkGo625
 UPDQRTLpDFsby2WQf7YUkd4r26Hj6Rkz0VJzO6oXA8x3EXz4onfyc5lRLEi74B14We+ga58I/yQ
 fNoXUa+fwaFuFbIt0poYZoL919DdTEbajpc1zZxBoQzl5fnSR+RGj0wlGGzGWdxF9jAyRi1Wtx5
 xnM6POf8vMNhMON+bCbRwY4jPjL4sZFipLNpIbaKCvD62izRiNHFCgfXMmTL3DgEm1BjldG0/82
 3tNt++R16pApO41UOPaS8cpUEdBf+A==
X-Authority-Analysis: v=2.4 cv=Ztvg6t7G c=1 sm=1 tr=0 ts=692f860a cx=c_pps
 a=Y5aTAp+79vj4S64KMabfRQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=pGLkceISAAAA:8 a=l-kCU6vbbzB7jWNEDxkA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: WNzK4RGJ1QOuClKPZ7B3sw1oGO0Jzm25
X-Proofpoint-ORIG-GUID: WNzK4RGJ1QOuClKPZ7B3sw1oGO0Jzm25
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-01_01,2025-11-27_02,2025-10-01_01

On 12/2/25 11:16 AM, Simon Horman wrote:
> On Mon, Dec 01, 2025 at 02:48:48PM -0800, Chris Mason wrote:
>> On Mon, 1 Dec 2025 20:52:34 +0100 Jonas Gorski <jonas.gorski@gmail.com> wrote:

[ ... ]

>>
>> I reproduced this false positive here, thanks for the explanation.  This is an
>> example of a class of review mistakes I've wanted to fix, so I used it to
>> improve the prompts around NULL pointers that are protected via other checks.
>>
>> I'll test this on some more commits and push it out.
> 
> Thanks for following-up on this Chris.
> 
> I guess everyone has their own opinion on AI.
> And, in a similar vein, many have opinions on the review-prompts.
> But, FTR, I've been impressed by the output I've seen,
> having used them for a few weeks now. And I look forward
> to that improving further.
> 

Thanks, I really appreciate everyone being willing to experiment with
the reviews (and huge thanks to Jakub for wiring this up).  I'll try to
stay on top of the false positives, but please also let me know if I'm
missing classes of bugs.

I think Jonas's other_dp->user check is really at the limit of claude's
ability to reason about the code in a generic way, and I'm still trying
to get it to process this patch consistently.

If all else fails we can fix some of these with more networking specific
knowledge, but I'm trying to avoid whack-a-mole.

-chris


