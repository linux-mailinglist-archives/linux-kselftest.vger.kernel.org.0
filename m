Return-Path: <linux-kselftest+bounces-3885-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 23F43844A2E
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jan 2024 22:40:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 280C8B21C16
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jan 2024 21:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCCAB39AC8;
	Wed, 31 Jan 2024 21:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b="w+j/RdrZ";
	dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b="D1RYMzJv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx08-0057a101.pphosted.com (mx08-0057a101.pphosted.com [185.183.31.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BBCC38F97;
	Wed, 31 Jan 2024 21:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.183.31.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706737198; cv=fail; b=LppEU3YaN1WQU5YD8YFCKgcbCtuCQXi2ie+QFsEQv5UV8gzkhrHwrAB5mQurjYVFDcuRptL/LRyh1fGCb+2628IwYJq5pvXP8Io2t72xFJofC07qIDzgrwaNw9y8YhYkWcYwetC39pnBmc55hhtBd+i4YRIzE0J1zhdzyYkL1tc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706737198; c=relaxed/simple;
	bh=eZvhAVx1YifqC7iD2tBgZ1utyb3ylErJyndSU3r2L8s=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=e6yC5oZX4hhbpfS3MW6/+Aop0oQ/WoncBNy5ohZvxPn4eTpzHmAdakQtLCXLi7ExE+Q4NCuQAy4G4cRViO+k2la4WbSToRyHv7PIawgehL4lkFqsDqVqtqvCiRDO5ECPQQwSvjbCmE4fU9G+9ZDNdE7MF0zqhknnwgVjggLANnU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com; spf=pass smtp.mailfrom=westermo.com; dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b=w+j/RdrZ; dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b=D1RYMzJv; arc=fail smtp.client-ip=185.183.31.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=westermo.com
Received: from pps.filterd (m0214196.ppops.net [127.0.0.1])
	by mx07-0057a101.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40VLLNAS011302;
	Wed, 31 Jan 2024 22:36:34 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=westermo.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	12052020; bh=+mbHjKyjIa3SaE29x2bk+5brFmIzej/pXwf92z/Ycaw=; b=w+j
	/RdrZcBM0j2BUxAjr/HqgHkHnsC3Q1ZoqGLCRH2KEYifDsMfO4xr55WrudWkGvpD
	cikcR0HnCxJolXGtAUbpl9T4JStB2jJk7JbEeNf2fiXSk3ThSB8cD842HkHg6djO
	CvZ4vOLoe/30Vxz9ciLkKoE1ODuxb9mjr8FX0XC+txFCEv/SeH66tjqtOIcCVQ1R
	6yE3CjRpMSKrT98Y69SeVlm3jcWiV+V5AO7daSjiTnjG0fr6aUEhSLlj87hbhT2F
	jKDdJHcwWvuCPczQfNky5FvMsoLWo5DM6mfJ2aNILRmPjdGdJ3adG4TGE7fHTaV2
	dZ9W+C1rfFgNUqk79Cw==
Received: from mail.beijerelectronics.com ([195.67.87.132])
	by mx07-0057a101.pphosted.com (PPS) with ESMTPS id 3vvpq44ac8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
	Wed, 31 Jan 2024 22:36:34 +0100 (CET)
Received: from EX01GLOBAL.beijerelectronics.com (10.101.10.25) by
 EX02GLOBAL.beijerelectronics.com (10.101.10.26) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.2375.34; Wed, 31 Jan 2024 22:36:33 +0100
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (104.47.11.40) by
 EX01GLOBAL.beijerelectronics.com (10.101.10.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.2375.17 via Frontend Transport; Wed, 31 Jan 2024 22:36:32 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SBjjtLedglcUfXbmQvjG436fQA2tgoUfl/OS/NDQ46BJfF6QXj0td2Mh/31wVRxOysueef/oKfVHVxbUVnUwQ77fVX6lwRiY6utsN6WF3/i5k0nUYObMK9nAfmVpuBRqoOfVAVBprN1yUJZgVeHP8jfFEays4SiMdZqpP5gWofQfnFw1fNyWPXaM8+JFENVZby2ct98P4UOqPIpxYRmCPevd4YGQfpmBowvHNwsuyC0kOdgtZBvRw3A1EOHWoomehnundRb7XXYQCphwHZdNkYlXp1fksNYwvh5kpJyshhzjCSNfynU/Ka3IihhOGJ70J2mgjiNiIV2pbKt/Faw9zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+mbHjKyjIa3SaE29x2bk+5brFmIzej/pXwf92z/Ycaw=;
 b=UfL2ULOGqdiPSrch7qNvm9fZkZNJhYjoYH+E+wd3xrpxMGSJMLVA6n7XZgntj5ZD5+Ssb4jONZaVJ58dy/4FsDqfVLQ+RBsPwLrZGfsVqF2ZhrgzsploIL2gqEfEk0fH6PGBGSvTSt1hCCdZh40XMOhduseufsjx5Mchuh30kf6Oh/YSWN5QxN+aZxWnBujLwTAwYT2bkkHNsj44FpRj3zP4NSAfw8LK/F0AmjrJB8ROUeh2MHRh/2go4XlekYj515iwVzFsRrWLaQvkt3W/nl90YUCGR8E91FMMcIYm46BC1GqFsrKtPuESOscLgt5psjmZR74b8IaDDiYhuJ6dlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=westermo.com; dmarc=pass action=none header.from=westermo.com;
 dkim=pass header.d=westermo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=beijerelectronicsab.onmicrosoft.com;
 s=selector1-beijerelectronicsab-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+mbHjKyjIa3SaE29x2bk+5brFmIzej/pXwf92z/Ycaw=;
 b=D1RYMzJvnU+ZhLmw+AjUlP0FA5jMSFwvRnl/z+Cpj5j0JHiiZ3MJU5w/MRmRiYZxiLw4fhdT6f28OKyko8iwkhFqgSO/XYteMBY0mP66lkVJF5oUkvvnxLDZ1QutNu5cEBmEfixaNv/uxhiaYcaD7BRL+XwjqaoMQ5H8JHIbKbU=
Received: from DB9P192MB1388.EURP192.PROD.OUTLOOK.COM (2603:10a6:10:296::18)
 by AS4P192MB1838.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:51a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Wed, 31 Jan
 2024 21:36:31 +0000
Received: from DB9P192MB1388.EURP192.PROD.OUTLOOK.COM
 ([fe80::f1b7:52d5:fa2e:39e1]) by DB9P192MB1388.EURP192.PROD.OUTLOOK.COM
 ([fe80::f1b7:52d5:fa2e:39e1%5]) with mapi id 15.20.7249.023; Wed, 31 Jan 2024
 21:36:30 +0000
Message-ID: <05100815-3651-4944-b559-546b529e15b4@westermo.com>
Date: Wed, 31 Jan 2024 22:36:27 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] selftests: net: add missing config for GENEVE
To: Jakub Kicinski <kuba@kernel.org>
CC: "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com"
	<edumazet@google.com>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
References: <20240130101157.196006-1-matthias.may@westermo.com>
 <20240131085159.21313974@kernel.org>
Content-Language: en-US
From: Matthias May <matthias.may@westermo.com>
In-Reply-To: <20240131085159.21313974@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR0P278CA0098.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:23::13) To DB9P192MB1388.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:10:296::18)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9P192MB1388:EE_|AS4P192MB1838:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d5f9c71-93b8-485d-ff99-08dc22a4b01d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HQvz9fI6Om/l3sQGWEKTpuWO/zYeRi4hWRBHBVlv/Tx6LowjL0I1Bv0KSW6p1bYfuCNMmH+VVt1wF8SvMcwkAOWlPoMLjvq49VXhcRrU4+vHe5Loku18RxU33aHtj9kWKu+/Hr0yNwWtPCYhgktldqxRhSmNAX4aT7MsuNkPuDZNkA2hYZaCbYUIwu0ueWGBCHvjJVkGiJqe6PZDhpu//UzTkKvMzq9G1wEG+fKeHPDgBXCSc5K5uJp7anO9E+brMiM/gZ+OjlJmjgvUR9o4z1UpHfIcxMfdOHrwL1VBZv9NFGcdhLP4WAfoxQH9/2GxsFZ72G8fmzQAuyjHkGwb0Qa4SfwXxGSpCYh5q6fd6RejyDQZ7Am18lAzq8B0rnVhZfAZ83dZfopN/jYne8siDS+tNYdcSADCaldSc2my+Zs1oyRQUJ5M4wLWacQduVEsqEXwv6Cd9KafWT/BR6wGS/3EINjaW5NdYNWR94KYSmo1B6CSgTf7kKTob8QZsfP+wfOfliMpGnGTV2odIsK1/YmojaLZ7dq+Eoen9x9ufiKA0nlhJZhDcfAj+JZ++2xk/i0/+/btXVaCjiP6nU95DWvGuTXniIVo19yMowziGYtoXHFWMhM5AHdhH82iR6+ZqU7VyX3gMkp1Mv4gc+pwxw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9P192MB1388.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(39850400004)(136003)(396003)(376002)(346002)(366004)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(6486002)(26005)(6916009)(66946007)(478600001)(66556008)(66476007)(6512007)(6666004)(316002)(54906003)(6506007)(2616005)(53546011)(8676002)(31696002)(4326008)(8936002)(44832011)(5660300002)(86362001)(38100700002)(31686004)(2906002)(4744005)(36756003)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QVBPeVFzY1JkZVBTcGJoaHFKZ0RmQkVpdzJTM1gvaFZJVWNXdlFJQVMwdnYr?=
 =?utf-8?B?ZlV1WkVBWm1OZ1plUzFwYUNxa00xdmRmZFRaZlJ5c3hBZEx2b0UrYjhlamEw?=
 =?utf-8?B?TzdLYkQwZ2NuNlJrSlFWMUJyaElHM29IcUZDcFROWHVTaDRLRExJNVhCcVZh?=
 =?utf-8?B?STZRZDJkRkZGL1d2c0w4R0VhSXZKRlpkYmFoWmlSdVZ5SStlMVVwZC94OE9P?=
 =?utf-8?B?NzhnektjSStSRU13d3hLMkY3Tzk1MkE1cW1VMlNnTXh4QzhlczNzTVZxRFg0?=
 =?utf-8?B?SmZKSXJOOTFKQWV2M2xjU1RLMG1pSHB2WDhqbXFVVklQMVdRQlI0N1FpLy9I?=
 =?utf-8?B?UWkydFBWTGY5Z1JnMnRQNTdqYXlZT1ZuV25mSWFRcVZxekYzVGxSTy9BbTQ2?=
 =?utf-8?B?QTAyVTBENmg1R0dKbnlKZEhubmFrRjF4ZmJRT3BTcnc1STFCZklTUWtyTFA5?=
 =?utf-8?B?ZjBjdTJFMDcrNUlWN0xEUWxOSlVzK0RTcVpRd2doZGJUTzNpUWgwU3BkcnhZ?=
 =?utf-8?B?alRNRkQ4M2Mxa3ZCekdoSnJ3UjBtMGJQWjZMMlhFVFRudW9hcDZyWU5FVFp1?=
 =?utf-8?B?L0hQTXBuTVR3dzI0V0VSbVgvN05sUkNUU0c0UzlJZmRTc2xBa2pJWFo2SGJS?=
 =?utf-8?B?Sjg3alJNclY4WXhqaEl0OUE5ZFRoQ21aRXFpdVJPR3VPZmI4Vms2cHMzckdK?=
 =?utf-8?B?dGRmbmtsWSs4ZVpJY2ZGUFN4Tkg4d0Zyb2ZXQWlvdDltK0lhQ1c3R1JYZXBU?=
 =?utf-8?B?eFRFSE9UbCtZSlRuS2JTTmJLNTh0cjlTekNzaDNDMFVyZkVSdnhMWHlRa0RX?=
 =?utf-8?B?VE1MVE5mUWNzdXJlbEVYWmJEdEg2QjlGSE5LNmZEQzZUUUtscS9PY2dQbUxM?=
 =?utf-8?B?TW8ydy94ejJGZ1ZyS21nMytDcmUvSTVkaklFcW5FRjB5YWtXNHhNdzQ0Ny9F?=
 =?utf-8?B?MTZmdy9qTExhdzRIWHdSNzlrRUVtbTllSmZEd2pVb1hvVEhJeFBNcG5OSjAx?=
 =?utf-8?B?S2hjcWZJSVZiRjJOeC9WanJ1c2NzNzdwbHg3SGtubk1yaUM4cGQ0RUU2TmRm?=
 =?utf-8?B?NWloSVZ3VHV0dzZHSXlOSGIrU3ZxWndPeXVISEpoZHl3ZTNBS1NSTzFsc3Jq?=
 =?utf-8?B?MDZuYVlKZ0w4NVk1aUcyLzd4cjNTTlpXN3BwZVFlSThmM3ZkYzRxQVg5cWp0?=
 =?utf-8?B?NG9vcmlEY2F0SnhUTEJEbXZRTmk0bEFCbndvY3JySE5obkMvN0VRUFN5SHY0?=
 =?utf-8?B?bHd5c2kxbENwZHBPc1FMMXhoaUt3Sit1MUkyY3dSZ3ZLVkdYczB1bXhuNlQ2?=
 =?utf-8?B?RkVsYTRXWHJpb0ovUndWN21jVVZ2eVI3TFJ4WGFqamU0OGpuUG1pOE5wV1Bz?=
 =?utf-8?B?aTVReDJaNVRXSzZoWkpzYVFnd05waWwwWlA2U2dYeWtHelprcVBnbm0vOFZI?=
 =?utf-8?B?YlZlZ1E0RkpBZ2RRZGM0YlNTaCtsU1pzYnVZajJmKzFFU3VxdGJqK1ZXVG9T?=
 =?utf-8?B?MkpoTmlMYXZ2dlRKTXlrenNENU1rZGZULzdtVmRjNFRISldscU9DcmFoT3VV?=
 =?utf-8?B?aGtsbFE1dGlPdVRaRklUSC9aQmJETHZFT1hkbzQ2TERwYktEWEZMNlVOSno1?=
 =?utf-8?B?ZGVZQkVITTdidXN4T3NoTk9aNVRWazNGam0zcUxlQmlnT2xCQm9nL1pTaG1n?=
 =?utf-8?B?N0JZL21oMGFBTXhxMDExQlBOUFJjWHg4TTI0b0hNNDJaN0tQWThaY1VCNTR5?=
 =?utf-8?B?bTZmaUYrenhTK0w1WWt5Y2Q1TE4reDFTYTNiVTRua3RHdXZneXpmMUVKbXRq?=
 =?utf-8?B?Qk9FYjhZcm96VTA0c0IwWFJWYVRyeFZXTCtQU0xJYW5sQk4yMkMyem0yVjNw?=
 =?utf-8?B?WWJRV3ZCWVFlaG5PL1IzVzBjanp2OFJCVklDMzhhajhFeUx6bXRLWVdielhm?=
 =?utf-8?B?YkNSV2YyUTl6RXd0Uml4aGFnaXdxa2Z3eWkxZzBiUWxCTk9MdFp1QVErRDlX?=
 =?utf-8?B?Q1JqdnMranF6blpndHJvSFZ3bkNOMk1SUmJyT1dwQkdOa2Z6dXB5THcxVjZQ?=
 =?utf-8?B?Nkg5dVZMR1pQNFhnZXYvWmtSQkFFRUNlRVY5Rm9vdUZuTG5yZDY1eTBsUlpU?=
 =?utf-8?Q?aQ6H7locEI6H7kpviXHQaSpxb?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d5f9c71-93b8-485d-ff99-08dc22a4b01d
X-MS-Exchange-CrossTenant-AuthSource: DB9P192MB1388.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2024 21:36:30.6858
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4b2e9b91-de77-4ca7-8130-c80faee67059
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bELIpFSYZIPzuae4fttZ3EOfRQnZ8We9nMzklY0lmjLsxlqE+YRBS9CkefsIKvIMdFWoQYWQLpTOcvEo4DCoMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4P192MB1838
X-OrganizationHeadersPreserved: AS4P192MB1838.EURP192.PROD.OUTLOOK.COM
X-CrossPremisesHeadersPromoted: EX01GLOBAL.beijerelectronics.com
X-CrossPremisesHeadersFiltered: EX01GLOBAL.beijerelectronics.com
X-OriginatorOrg: westermo.com
X-Proofpoint-ORIG-GUID: IQr2O9G3cZehAdIG2gYrv2PN2ks6PAzX
X-Proofpoint-GUID: IQr2O9G3cZehAdIG2gYrv2PN2ks6PAzX

On 31/01/2024 17:51, Jakub Kicinski wrote:
> On Tue, 30 Jan 2024 10:12:18 +0000 Matthias May wrote:
>> l2_tos_ttl_inherit.sh verifies the inheritance of tos and ttl
>> for GRETAP, VXLAN and GENEVE.
>> Before testing it checks if the required module is available
>> and if not skips the tests accordingly.
>> Currently only GRETAP and VXLAN are tested because the GENEVE
>> module is missing.
>>
>> Signed-off-by: Matthias May <matthias.may@westermo.com>
> I reshuffled the option to sort slightly more alphabetically,
> added a fixes tag and applied to net, hopefully this will help
> folks testing stable.
>
> Thank you!
Thank you for the fixup.
I wasn't sure if it actually "fixes" something since it kind of never 
worked.

BR
Matthias

