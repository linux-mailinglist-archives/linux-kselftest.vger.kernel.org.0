Return-Path: <linux-kselftest+bounces-30491-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 721BBA84C0D
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Apr 2025 20:27:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 990503AF234
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Apr 2025 18:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E89C428CF72;
	Thu, 10 Apr 2025 18:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="IhwsPRWQ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="kaqGuCWs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F2228C5D4;
	Thu, 10 Apr 2025 18:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744309626; cv=fail; b=rsFVH5dIn2eP72dROvYcHQYxJERHnmKAKkRB6G4VskRgX2UjaN2weTSv2i42BwINwX8wGz3Wf3qwEVnv9ZCvZ/Nmet/yHpfc0l8UtRmnoDDKfCeUI2Lu8zHl7tWJ25DIcxkFuQpYkoxJBI4Qkd6jyNV0r88yAmziRlEnPSgeFkI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744309626; c=relaxed/simple;
	bh=nPmdzZJ5MuL4ne5F7f7wlaSTdMsEZqF5TQMPHSONEds=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=iyMzNXxOF9yMb5xKEVkNxdmO2uNk14VM1dpZUAjG0zpumCvw8eFj9V+OMEICbg7QAlqed4dJ38M83jtFw9rnFJyVY2QUoixD4tDKC+FVyo+VgUhLqOA1JMx7d07736M+wr88HNZlcxnIP+kpHhfANXIHqr0fRJo4D+jam78WA0g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=IhwsPRWQ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=kaqGuCWs; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53AHpqtY008250;
	Thu, 10 Apr 2025 18:26:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=ESpNz6XACm+m5ijNJUL11P32K+rrXEIfpmYs+UfW+Dk=; b=
	IhwsPRWQkf1x0q2OVKeDiFS0aNbHZZQg5zuKKqcMmhhOlPZspoKS6238HuK8XWTI
	K06tewfeH89ZlzfCyrJlZZ1KZAA0AJaRfsXemhcKLGS/wisMOPpp3IfGOuHID/F/
	Go7gifdnGPPj0dBcs9Ue4R25Ew6mRS58G8HoS+iRX1TRAOXfETovsksIGIYQrX1/
	gvl+4xFP9LZ89Ka9yMoyS2q3wiUlXreWmgUQnwmACDalkLqJf89++4pa+d2bypiD
	Vn98uCbFhDEOcAfV+wGZgnDk2hcQRniYvOgyF9AY1br6dznmN2OxvnrVwQhQrWom
	/JxQpCn0pACc6CoggD2+GQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45xjrsg2n8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Apr 2025 18:26:55 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53AHjVrE001648;
	Thu, 10 Apr 2025 18:26:54 GMT
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azlp17010006.outbound.protection.outlook.com [40.93.10.6])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 45ttycmbap-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Apr 2025 18:26:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J/qRWE5zt2tweDs3UV1LOoUtF3ny/znrqaM1oyFy/OqzGMQf8PaW6y0Gh6P0Qf7AopEDBlylDDPThATYkmMEBUUP+DbC4l5/couWL4K35XGsuIeLWIQwM1ROEOkKrZ6k9Dip5S4/TnxMkLA8Q5Sgoulp8EUX1qR+tIRUqCyLF35l2d9sLG11UUI4Jffk9S8GFQJ8vXoSQl8dmaTjj20maZGQZWBJ490mBuAdodSNFYs9dueG7R+IImhNejgYduxqdVaXWaj2RUE6zszcu/OpJVeY4djOHBdWC7tYtwm/V/OJkSA9k2MS0t8JAlfa+f+cgtqGFRZMJbQUerMB0yqnTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ESpNz6XACm+m5ijNJUL11P32K+rrXEIfpmYs+UfW+Dk=;
 b=DT6hV4mewHvwkUOQ+s0U4v0nx0h50N7DLC5hFkN0vyHAbObJn3zzqb/QnbvlJn5xrr+DP38DGN3bUr4AxrJcJG4aP9aj72kqpMpe1ND+imuk76slUohHkCkO2UZlFNVpy52PORU+Z3aATPnjppRzPqDVX8P0kAZuq2vd3p3K1t2k/Z98iIQgIRBsLHxwp47Ed6ziD3/E7/1XuKCoP3N3tuR0dcXJs2W50ID9sHq7vUXTayf02YnnbJQvvpo01tJC+4wEzmIuUC/BPdLUTL3xONFsNyByGzQMrvzgolTDS38QnXwl9u+7tByYzXZEo4KXc5o4ubUtW/GQ6s8aEopgCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ESpNz6XACm+m5ijNJUL11P32K+rrXEIfpmYs+UfW+Dk=;
 b=kaqGuCWsD9CYBI2yC9hCwbIIy848ZL58V5zXEyXW1HmjMnFapChAt1SYFElmEZ3zB/G08eblzXQx6/8w3cQBPx9j0Q4KHVUTjWggOAFk0efDSQ+itaoL1W5V2nzOtz7nqkEbDgTXbUcdWYgc4MNgqM+xAZDIEk1KsXKqYexngr8=
Received: from DS7PR10MB5328.namprd10.prod.outlook.com (2603:10b6:5:3a6::12)
 by DS7PR10MB5040.namprd10.prod.outlook.com (2603:10b6:5:3b0::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.22; Thu, 10 Apr
 2025 18:26:50 +0000
Received: from DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c]) by DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c%6]) with mapi id 15.20.8632.017; Thu, 10 Apr 2025
 18:26:50 +0000
Message-ID: <28760a9d-670e-47bf-9fe6-b76624994b09@oracle.com>
Date: Thu, 10 Apr 2025 23:56:42 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v25 02/23] ovpn: add basic netlink support
To: Antonio Quartulli <antonio@openvpn.net>, netdev@vger.kernel.org,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Donald Hunter <donald.hunter@gmail.com>, Shuah Khan <shuah@kernel.org>,
        sd@queasysnail.net, ryazanov.s.a@gmail.com,
        Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, Xiao Liang <shaw.leon@gmail.com>
References: <20250407-b4-ovpn-v25-0-a04eae86e016@openvpn.net>
 <20250407-b4-ovpn-v25-2-a04eae86e016@openvpn.net>
Content-Language: en-US
From: ALOK TIWARI <alok.a.tiwari@oracle.com>
In-Reply-To: <20250407-b4-ovpn-v25-2-a04eae86e016@openvpn.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR03CA0088.apcprd03.prod.outlook.com
 (2603:1096:4:7c::16) To DS7PR10MB5328.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::12)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5328:EE_|DS7PR10MB5040:EE_
X-MS-Office365-Filtering-Correlation-Id: 0cb27629-7818-48e3-13ea-08dd785d42af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|376014|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ditEZzF5ekJtRU9GU28yYXVITHpSU2crOXVjdkM5N1VsT3QzRFFLa3V2aGND?=
 =?utf-8?B?MVAzajJ3d2RkaHl4VGVqK29JSmtQL3RrYXg2TDJaalpVUUVrNVZaVE03NU44?=
 =?utf-8?B?T3EvamtJQmMwWHI4YlNqNU5jSllFQWpreWhzdE5vZ1l4MjMvWWovbVlnUS9D?=
 =?utf-8?B?UlBkTHVKWkY4WXNTcmJqSHVhWUErTkxLODhmSTZwUkpacENIejIyYjRHZHN5?=
 =?utf-8?B?RGdLOExCNllJVVh6cG0vdWZDdStramFoL3d6ZXFhMnJ1RTUvbDMyQ1Job1l0?=
 =?utf-8?B?WTBCM1Buem1oZHRFbWJLL2ROeGlLb2hxVFBMb0pVaTMrUlFVZmVUaE9UZDVR?=
 =?utf-8?B?Wi8zelNxNjZCUTRYK01sU1ZNQ1FsSWlwemg4MHB3dndlV1R0ZTJMVVhVN2JP?=
 =?utf-8?B?ODZ0T1EyVmluUkN4U0lSOHN0bjIrVHA5VzVMM3Fxb1k5TUZBcDdtWUM4UWJw?=
 =?utf-8?B?OE9mKys3Wk42ZFY5U0xjeFZRQlVPRG1RNCthbXMxalk4anBCZnorQS94ZEdq?=
 =?utf-8?B?WDVNV1R2TUJOK2d1YkZpemZ3OFJnMFdRMEJTMlRwVjJibWhkR1VOZEhlS09L?=
 =?utf-8?B?bEZWc2N1eFhxZTNYUm5UbmVpM3lsLzAyT2djQW5BL0E4MEFhQjJ2REJnWVBs?=
 =?utf-8?B?Tndza3BtR3oyS1p0Q2haTUpJYU1uS3lISlhldnYvanBrTFRMdXV6RzZVem1i?=
 =?utf-8?B?WXhobG9PSEdPWmU4aUVsZ1pJUEFUK041RkNtN0tDSEZIWVhpdk4wNE1pTDFU?=
 =?utf-8?B?R2tlRHN4TlpLQW5KZkxMTHhFWDZoWGZFV21aYTl1bDF1eGNoVFdRem0wVHJP?=
 =?utf-8?B?U2V5Q2hPVXBhUWpwbmRYQ3pINlIydURHcUFOdWdNSGpzK0dLLytBaFRoZXB0?=
 =?utf-8?B?cVlzS1o5RFJ3T25FTmorSElVOW5JbzFJNGZRZFJNY0ZOZHpqSndaQ1BGRm5F?=
 =?utf-8?B?clJtY3ZoMWdXdGdrRWozWkpLR2EyaVhxWkRvdU1DbkVFOElBMzVjdEZ4MWJN?=
 =?utf-8?B?Z0g5Tmpva215eXRTZTJ6L1FKVmRPL0MzTUdGM3hjd2RKcEFKUmhwV1VMRTBM?=
 =?utf-8?B?VVQxQ0dWTU14VkswM29pOWFJa2d2T3JVNTgvOGt4NHhYU2ROU1VRbFptWGNj?=
 =?utf-8?B?dmJ2MmozRFNhNjZxd2FXMzNDVC9rNis0aXhXZ0FiRUkrTk5xWnVNckFPR013?=
 =?utf-8?B?Y3pZMldIcWUrUFF4bytMc08vMVVCeXZ0ckpyMGZFVkJKMnNNbUFNOGxlbjF5?=
 =?utf-8?B?YmNEU1lTZ2s3dHZVL0tKeXdxcTNjSjZrakd4d1dzUmRaYms2WlE1ZG1UWkhZ?=
 =?utf-8?B?eFl6cDZ6ZGtrSDBBS3NkNml5Qzhzd1liYjNKZjBMTlFUcUhVeVJUUVZpLzUx?=
 =?utf-8?B?ZlB5TFZQK1ZOZFFoK29oSTRSemVSRXJDUEFMQW1BbnJ1RE11Y2kya0JobCtP?=
 =?utf-8?B?SlJEYUV0RjYzQldqc1FmdlQyY3RkaTIzeXNoWjBud2NET05sdUxQeWt1U3ZI?=
 =?utf-8?B?SEd1Tk9wUUtZc0lvUGFRSnJteDNTa2daRlA4b2lWYnlJNHA5NUpkenduYTNi?=
 =?utf-8?B?am41N25vZjdLMEIwMmlYOFdMWERrcEZSWjhlc2w4MHhzVFBvY3NVaFR1Q0VG?=
 =?utf-8?B?TVh3RmtjZ0h1MXN5VTV6MGJCRk9DSHZKK3JjUEhvV0hVY3NacDI1bVUrZ21x?=
 =?utf-8?B?V1JyR2JVYlNzL2NaOHFIWG40UzlsZDZtQ0lucU9Td0dYeE5YNWN0SS96MXpo?=
 =?utf-8?B?SEZkTDZLbTJ4akZMMzV6NFJyTGdLcmg3V01uQWFEUnNNRUNyVkZvcmV5bkN5?=
 =?utf-8?B?RmJJQ2NRSGFiZFJVcTlTMzRjRVZrVGFPSDArdU9PUkhnMUc3bE1KbklGekZI?=
 =?utf-8?B?SUxJeUIzUGlST2N0WmcxcHFHUkU2WWdudHJLWUtCdWZWYWRPRC94ZWU0Vnpt?=
 =?utf-8?Q?eR4k3KYGcCY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5328.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eFVOQ0VMaEhpem5IYjI1ZlR3aWIvaHVNaEgrZ2lzdzhhL2ZlTlBpUllKN2tS?=
 =?utf-8?B?dy83eFBzdVc5NUdIMVFXQ1doZ0FyaDJaV3hkeENvNE1yM3NPVmZGcmwraVVi?=
 =?utf-8?B?aitiUExkMXBmVkpnNmE3V3hYdDJiZHJKUEtYL1F6L1NXeEN1Rm9acmdjLzln?=
 =?utf-8?B?a3hGU1cwUWZsVlc3YjJCTklCTU5QbmsxQXNCM2JMN3dWRWtrZTJqRHhQYjdM?=
 =?utf-8?B?c1RDZHVRUWp1dHpYcE9RV2NTc2NFRHFLY1ZvTHpxdGN6SmlwZE5vb2h2OHJ1?=
 =?utf-8?B?MkRadkYrN1doclFqTEZBU3piTmN3ei9hWjBGVG5MVzhLWCs1VWVKNE1jY1Fq?=
 =?utf-8?B?QkZ4SXhlaTNYbm0zdTZhd0JqZkJ0cFozVSs4SWxOdHJlaEUycU5GMjZrRFZI?=
 =?utf-8?B?akpPaS85Zjk1SDEzTkJlYzdEOHpwOGozb0plUk1EbVFaWWNiN2FhSVFhbTJq?=
 =?utf-8?B?eWlCZzdDbjNXME8rSCtNSWl2dnBPZHdIR2NqaDRRUUo1MW8waXNpRWVVS0tw?=
 =?utf-8?B?WjBMMGszQXo4cXlrRUpuM3JFMFpaS05FTlRwYzc2SEdWcmJIUVVCU3Fkd0Fa?=
 =?utf-8?B?dm4raUUySDBGejk4YnVUakpkZ0dDc2JXaDI5WG9HNzhTcW5VZDA5NWs5YzNn?=
 =?utf-8?B?NEo0VmZYSjVYM1YvK2dRM1dwSGpjRHdLTVBOUUQxWlA4SzFtVXcxeHBLN2ZU?=
 =?utf-8?B?cEhkL2hKbS9TYmhsVmcvd3hhWVRTNklwNVNyeGVnR0ZHeUlVbElHQWxkSXJz?=
 =?utf-8?B?c0NCM0xxZVlvT01EbllpMDJ1Nk41LzY5VVVIMlJoZnBmc0hmVXptdWJuRy9v?=
 =?utf-8?B?YXFjSWgvdEhJZDhaNDFNaFJxQkc2QTNQOFZzaFp4OFhmUytnOUxleXZWL0xQ?=
 =?utf-8?B?dnhEenZxTDRvMGxJdHlwNDFpWXdTM0tOYm9kU2tLR0Z2dVMrQytOM2xyTDVO?=
 =?utf-8?B?Tit5dGtRaW40Q0FYbzhmRVNDRWNyMCtZNk1hMWJmU3ZSNHhtQnp1d2NLcGhs?=
 =?utf-8?B?UmtkSFNzYUxnSkJrSmJiYnBiOWNNTGxwNHZQQmV6SCtkVVk5Uk00L3BYRlZU?=
 =?utf-8?B?V2s2dkhIOHpHSVRXQ2FTNzBsNTZiK0NJZklSWHhyN1Rkc0MvdmdtcWJQRThi?=
 =?utf-8?B?Ym9LU3VYQ3YwaDV1SWVUWHhNNDlERk1CaEJNL3gvdXlNWXdpUVhGTmxMblF3?=
 =?utf-8?B?RVNzRmJLRW5ZL2dSNkJaOFUrZzZsS3ZTWDdBbHdneWpQeDRTRUthcExDUVc0?=
 =?utf-8?B?aStXOVB4ay9RTHh4UmVTaXZDWXVCN21sVm0zTVBXMWJnYWtFT1ozN0hLdHBn?=
 =?utf-8?B?MDFaanpRUUxjaFVObExrQ09ld2o4SGtQR1JLTmU0NGZxT0tuQitWSWtrL0E1?=
 =?utf-8?B?U2R5OG9nVzBoNi92SklLYnFLcHdzdUp3Mmp6THVSem12dEw0TjRGeFdxTTBi?=
 =?utf-8?B?bmJCVXlJVXhCbXNBUXcvZlZaaDNkU3dkbFYvNGw1bk04L0xNWis3Wi8rQWpa?=
 =?utf-8?B?c0U2cjM4Nkp2VEptUTAxTXVQZG5RNkkrN00rSng0NTg3ZHpuaGN5KzkyeHJO?=
 =?utf-8?B?K09aSlZwcmdmenZDR0lyajBJRVovekJtTVdpRG5DWEk5b09OcU9Ec2NLVU9P?=
 =?utf-8?B?YmFWa1Y4L1ZnZnEzenJVS0hLV1lody9scjVJUW9rQnp5aFJJcTVVVjJoajBl?=
 =?utf-8?B?N0p0ZFFIczNOTFd6SWdhaU1nZG5CdlEyUlhHbXFzbVovODV3bWVPUDErMnNh?=
 =?utf-8?B?emNEQ0JIeENuaUtVclBwWXllY1FnUGxrd0lnZEd5WWZ3RjZXMEdLdE9NblFs?=
 =?utf-8?B?R3p6c09pUEpVenZBb3ZydTJkdDFHWVBkVld2TnNpYlg0SWhlcituaXlrTzFa?=
 =?utf-8?B?azJIUmVMWWtER2RKbTJpT0lxVjQxS1JFREV2eUtJczVObE9oYnVyb0FuSllX?=
 =?utf-8?B?WmlBMHNrNGthTXc2TlJGS1F0TEUzVDJQNU5FV0crdENmdHhOZDg1WjdkVVhZ?=
 =?utf-8?B?U3FUbERza0xCeklwaXNVOU5MWlVzR1U1M3BoSlgwV2dMMS9sVVd5VDNOVjcy?=
 =?utf-8?B?eUFDbGRrWUprTk80cytuajMzRVl6TVdZUFFDUzJ5aWJzMGQ3UnlPSEtHV0ph?=
 =?utf-8?B?K21pMkROL2VRQmFiampWaUNlbnMyTlg4MXdzNGhQNnBJSS94Z0RiYXhSUTFV?=
 =?utf-8?B?SkE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	AWvJOoDtZqTKQ0pVk1dyYcEWOQC4AYEUVqTL8m+sN+yfF8317dnhB4xJfvRhXJN3/MdququLLMdMChAZkZ5zN3s6DojOTw2Qs4Sx0Vns+ZYUyd2FiwKRTOMYI3k2+eIk+MaScU+DVkVLSXl06s/9j+pyugfTQhTtMvUDySpagdCf+QnLKzysDirovcKyHC2e/MhpUBvB5SM3TRWm+9nHiwCuW4pL+zhtmsSsXALdWpZFjmOrHPJF7YNsnGJhxuqglhGh+6LX9K7y2hX6cN9xB/hpMIYepdNh4g7luGC12YXXOfvsP/ZjVPbnaUN1ZA+DtECVp9mj8T5z7mU5C4gxHhXxqrPekBxG2Im/VGD2Wp7I8u2oUppQs8jGL3raRP9N+acKdTfqPOp4gwcvavJzGxpCVLrzwK6fxTHP8kL2cTR0jYPG/q5Zm1dKfdYOd/n9jbGJFBVPwY/Y5UzU+bQdPzl5LxW3iqCrZIdllzfmIQl/g9ktt11UZOVK5ZPNhXWO2xKCX14G/qQH//nJuPaWXq1MEEOYSTAYM7HwRiVO8WRZSZQcMNqHMWANXRGY+g2aqpso/lYq83jvK57u7o2MtJE83ynrYP8Q8B5SYuvglYY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cb27629-7818-48e3-13ea-08dd785d42af
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5328.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2025 18:26:50.3585
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tU2HUzlIbRqHel8vvRL0AwBrXIly2XRHyN2CeAPODk+RK9woROLONItmBY9FAJIDMXXCbOUHTO0u7gvQAsdvka8MnwIKGvcjZeQWZEW5VJ0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5040
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-10_05,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 suspectscore=0 adultscore=0 bulkscore=0 mlxscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2504100133
X-Proofpoint-GUID: ftD8Kw5fBEMSkpgX6tN35azSMba8UDpx
X-Proofpoint-ORIG-GUID: ftD8Kw5fBEMSkpgX6tN35azSMba8UDpx



On 08-04-2025 01:16, Antonio Quartulli wrote:
> +/**
> + * ovpn_nl_register - perform any needed registration in the NL subsustem

typo subsustem -> subsystem

> + *
> + * Return: 0 on success, a negative error code otherwise
> + */
> +int __init ovpn_nl_register(void)
> +{
> +	int ret = genl_register_family(&ovpn_nl_family);
> +
> +	if (ret) {
> +		pr_err("ovpn: genl_register_family failed: %d\n", ret);
> +		return ret;
> +	}
> +
> +	return 0;
> +}


Thanks,
Alok

