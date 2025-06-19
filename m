Return-Path: <linux-kselftest+bounces-35350-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FD5EAE01DD
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Jun 2025 11:40:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27B6E3B2B63
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Jun 2025 09:40:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D6AA21D3F6;
	Thu, 19 Jun 2025 09:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="YiFNS0xn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2096.outbound.protection.outlook.com [40.107.243.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9602A21CC64;
	Thu, 19 Jun 2025 09:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750326041; cv=fail; b=ZeWfOXqV+Il1xC+GJhOiSgz3gdcusYOacHCEd6mmN1pBKvOTdd5GBV0gmK8F4ilFhwgJfEDQ8EjjY5GdiyIZ6FXb3NVXv7sb+FLHckfHronVza5LQ81s5cwdM78gS9TT/0a29w94EPJ1GnhVrtAwF0rnwkamAr+fOzR6JcasSa0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750326041; c=relaxed/simple;
	bh=Zl0DT7n39QSp2rITWaLzs2shCVtt77V4w/sl5qq+Bk4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=E8IGmNJ+3SlFnrADVsSFUmqO5wfpPbWaZlEBQz4ZuO/yFDDx75800Ex/Zz1J+BSXV7SjzG4a38gl/RaCd3geIA6g6WIX9C0GmXGXewmSvtI4/bnftWKbOrmVqta0t5uy9+DMuxH8irUVc62jVopVBWN14O3l+oM0qDsucA2QEac=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=YiFNS0xn; arc=fail smtp.client-ip=40.107.243.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cSxBwLk4lYcha5Q1BCPX/Pg7WkS0Ytlw/2i/DdLbt8EFFd4jOPbFYLSSn7NfNWJS3Z46pTxTyhsPf/wzb3VxKEqfc5DSdwIUm6XbNBkg88vmiUxSM8//QR7RsmC06tIqtIkurrnejZCQCv4Mq6LeXTr9ndpx4KWTtK3BvteMORvvU1o7TuCQsFdF89a+pVZOhtxNWC3HsCtWgdheBaLqWsAkaBxvDpeLlOcenc+D+tQwaV4x82sbti4OXlSIoWwNZY/g15JpgYIBiheXZYY4Z6dGZgqWdT9kK1Cosvs4JNgdp8PcuqUtEIjECVvfj7mmeYZUxhdaqT78TTf+OiWcEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LqlKBw+/ecrIzOhxDzv5rDlwUr989PCXU0s7TiGRsTs=;
 b=BG2Zqf4hNpj1fkP8zIrl/HjSxQXqX9D7o0Ep+WNBGRkaOLqZdKDI3FPAOPnIpLy+IwiHJLi9tZUUDc5WxCwGpH+Dr3AZ1DQfOndxb2tO2PacpGaFn0vtdE1lPvkWk8nr5MKdfhItrLOmw3V5nnnkTix7kACO8FG0cgvTt4ip/6jNbL0tP/Ygstlp4aaW30uogQroaBcBoO2gyVUFwRvuXm0+WcZZwU93ydvFfKccJt4fCkms7oAKW2jigzT1UUYqIDWB40JQp3aT3SNuC9UEiRy8Mi0RkyaftohpvxZ8MkLiuURp/rtQ5aF8Ri/SRQS47Soyye3dxWW1yCuv3mOf2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LqlKBw+/ecrIzOhxDzv5rDlwUr989PCXU0s7TiGRsTs=;
 b=YiFNS0xnY6xOBdK9XenjhuxHR0iIlfLDaU1nhFwk+IWTOLpB83ek9aX+C/OSSiYM3F289kptMxGvfiCEtzI7uyeKvFhsgB8h/Nmkno2sjDSw75K6jEf8a4iVW9fmhvZ0Nu8RXFyZWizdI1mGzBMZhxt7hjN17QCClcROriT+qB8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SJ2PR01MB8101.prod.exchangelabs.com (2603:10b6:a03:4f6::10) by
 CY3PR01MB9318.prod.exchangelabs.com (2603:10b6:930:103::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.29; Thu, 19 Jun 2025 09:40:35 +0000
Received: from SJ2PR01MB8101.prod.exchangelabs.com
 ([fe80::292:6d9c:eb9a:95c9]) by SJ2PR01MB8101.prod.exchangelabs.com
 ([fe80::292:6d9c:eb9a:95c9%6]) with mapi id 15.20.8722.027; Thu, 19 Jun 2025
 09:40:35 +0000
Message-ID: <3be548bf-aee4-46ab-bcbf-15bf629b24da@os.amperecomputing.com>
Date: Thu, 19 Jun 2025 15:10:15 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 0/9] KVM: Enable Nested Virt selftests
To: Marc Zyngier <maz@kernel.org>
Cc: Eric Auger <eauger@redhat.com>, linux-arm-kernel@lists.infradead.org,
 kvmarm@lists.linux.dev, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, oliver.upton@linux.dev, joey.gouly@arm.com,
 suzuki.poulose@arm.com, yuzenghui@huawei.com, seanjc@google.com,
 darren@os.amperecomputing.com
References: <20250512105251.577874-1-gankulkarni@os.amperecomputing.com>
 <92c7e99c-5574-422c-92f1-62d5cde58fec@redhat.com>
 <7bf7bd52-7553-42a7-afdb-a5e95f8699b5@os.amperecomputing.com>
 <86a56veiyy.wl-maz@kernel.org>
Content-Language: en-US
From: Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>
In-Reply-To: <86a56veiyy.wl-maz@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MAXP287CA0010.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a00:49::21) To SJ2PR01MB8101.prod.exchangelabs.com
 (2603:10b6:a03:4f6::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR01MB8101:EE_|CY3PR01MB9318:EE_
X-MS-Office365-Filtering-Correlation-Id: 72a5cf0d-47b3-4f95-b492-08ddaf155730
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?am5UdU5ORFkybFplMFU3eTBrSkNLSjlnL2xWUE0yNm16RTk1Zmx0QUhHZDht?=
 =?utf-8?B?NVltS1lEYkVSNEpQK0V1WGtkeGRiYVEraWNodWJBNjBhSnVkNXoxZWdvN1dG?=
 =?utf-8?B?QjQvby82Q1ROOXl0MjAveWtVMW1CeWhPaUVkZmhtaktnNUk2Q0xSTFVGWEwr?=
 =?utf-8?B?b2hHRHo2ZmgxYUlZYld4NzRXWFBxOU1SWmtsOHM1Y0FFM0JUWXdrckdZbE9C?=
 =?utf-8?B?eFFSbFUrYk9PRW5pVkNyUVRTLzM5YmNsa2RyRWxMM1lFY0ZSd0RJRnBZVG9S?=
 =?utf-8?B?Zm5PMzJVZUg0ZFlPMUlxcG51QkRpaVVXdHI4YklJS3FldnRjeU1OdU0xTGdP?=
 =?utf-8?B?NmRBWEpDY0FNN0ZVY0hyU1lrcnRqMEYyVHVsWXlYMitUejFkZWViajhZMHY0?=
 =?utf-8?B?dHp6ZDRkRXlwcmJaQnlvQ2hMQ3ZoZ0tPM215clp4L2tjWjRPZUY3OG0zTmQy?=
 =?utf-8?B?V0oxcG9HWWxzL1ltTGJOUjBGMjlJbmJka1dYeE9kZGZZZHVXbzNuczQ5M1hh?=
 =?utf-8?B?K2hERXg5dGlTZmowanlUS3czSU9FWGRZeGp4NlFnR012MkRFRm1UcHVLdU1T?=
 =?utf-8?B?bnhRRlo0QklubmhENERUMVpTb1NrOVJyaUNGT0MwVVNqWm9MWG1QZkI2RDQx?=
 =?utf-8?B?dkZiSUhNQ1J1QVNKVkdFWkowSmFFNldaZXU2encwdWZBY0xHdHdFaU5Qenh3?=
 =?utf-8?B?L1FzcVZrdE9OYU1OYmxldzhoVjMwVEJ0cEIwa01FSXphVGpTSTVzcndlV3Vk?=
 =?utf-8?B?a0J5UFlYOW9tZFNjS014Tk1RcVIwdE5lY2NkRzVsaitaNTNzWmFKMS9DYXdO?=
 =?utf-8?B?bGtuOXNPb2RGUHJ1RlkxUjJKUldBNjh2S29ORGFjQTI3ekdlVHZEKzdhYlNj?=
 =?utf-8?B?MDhWeEFwSERTSE1GUXk2L3p5VzdsNC83QWxwMGk3cjlMd2ZZMVBLbk5NVEM0?=
 =?utf-8?B?ck9EaUtqZ2RHUHQvODdyaDZGN1k1M1R0bVBTcEVkWTdrdW5KRXJxTXhwTWxq?=
 =?utf-8?B?ZTNPaTlUcU5jbnkxU25kVUZPNmhSbzdPZUMxVHZQN0M0a3g5RitRYzZCT1NE?=
 =?utf-8?B?TC9BTnNwbFVhQ1VNam9PbkVoeHRSNWM3bmhZQVdSZk8zQ2s1OUpQM09XdTFw?=
 =?utf-8?B?NlprY21nYTFoUktQTlNXakJNaFk3bEtIS0UvYjUyd3R0ZjZRYVhSaWd0Um5x?=
 =?utf-8?B?dVk4d3ZxZjZqaDBIbFRDWGFrUUhpaTJ0VW8vb1BLME5KWEI1VTV6S1I4d3hz?=
 =?utf-8?B?REJ1cHAyQzZLWDFUVFRVVk1uMVZ6ek51Wm1jKzdneFB1ZnJ4STBxTEhScktk?=
 =?utf-8?B?Yi9EN0pIYzFFSTdxaHlocVZNUEJaVnArLzFJdnUybVNkTFUrNGVpTUpVbnJl?=
 =?utf-8?B?S0kvZ0VWOG9PeDRtd2dDUlNXOEZpR2tEcHJWWHZkVERSSWtobmFnZ0RLQXpp?=
 =?utf-8?B?TFk5enR0S1lEaGREb1FGQ3hFdTBaV1NqSnJ3S1FFdWR1Zk1rMGNYQlJaS3RH?=
 =?utf-8?B?c2dKRi9sQ2d4WmZzdkxYZ3RXdGdKaTAvZ0w5b1ZBdzlrZnVsemw1TjBKOERn?=
 =?utf-8?B?bjE5RHJNOEZNRlRuSnI5UFNpcks5dXRycHU2Zys5TElMNklzeGdMR3BRcU9p?=
 =?utf-8?B?bEdYNnVuL0F0VnZsMGZON3YrMyt2MGVmdmw0WHg1bGsxakhncWFHOHBDMXJr?=
 =?utf-8?B?V3E1YXJhTGpoQ3BMa1lFcjZyOHM1OFdBZzZFeEJscHEzYnBpSU1BbW41SXp6?=
 =?utf-8?B?NDltY0xLN21Oc0pRc2dWbERBMzF3bEFQUFNzRkFrYmprdEFaMXpWSlRHL1F3?=
 =?utf-8?B?NzlaVCtOTG1qQi9yNHhnZ3lxVDdDU0NSUzNCMGJ6ajJWVXpneEFFZFpyQzNy?=
 =?utf-8?B?cjRzV3NWL3hwZU9CNk1mbjkvMHVpTUUvYldtRU9Ib3M3WXgwZ2RqUkQzOVRZ?=
 =?utf-8?Q?dqQEDsXmbno=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR01MB8101.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UTMvQzVSYXlZR1c0enltM3V0d1NpaklJMFN2bDV3U0d6WENBMGZpNmk0YVhM?=
 =?utf-8?B?ZGYzT1E0S2FkdG90SDN5dW10WEl5bU1EeVJvc0c1NGxKaUQxVmdjRUpnUSti?=
 =?utf-8?B?TzUyYnJ6VlZuSmZudzVwaHp5dW05ODNpQzdQSHNDd0s5OTdGRXpWdndLMTVq?=
 =?utf-8?B?OXNUeitkYllKU3FTTGMvL3hpQ1ZpUjhBZUJVYVJoNENWbE5ZQXlwYnNWMy9D?=
 =?utf-8?B?cFJWZHlOb25DbUZvK2s5RG0wazdjT1IwT01oZ2ZBV2hpN3NWVFZ5UG5RUHMz?=
 =?utf-8?B?QTlreGNrNkR5M2RxclorUnNYL2t2a0prWXAvSFBtV2E5eXNrdU5wcDNCTnZi?=
 =?utf-8?B?TXRDaXhsbjJ4eWozV3RWbjFaN1RueW84Uk13VU9FK1d0d3o0REJLNEFKNGha?=
 =?utf-8?B?UHVIRE1IWWRncmthZ091em5kUWpiZVM0TkNkajB3ZGgycmRTRlpacXdBMW9V?=
 =?utf-8?B?eGJSdmVtU1JjOUtSdC9CL0k1Y2pqaXZhYjVwaHMwemdUZ1g0aFlxTUpYQ0tI?=
 =?utf-8?B?WE5rOHdsQk1uMlJZam1MbkxWbXpRN0RoMXl1ZGJyUUFMeExQTW1pbytKYzhQ?=
 =?utf-8?B?eVY5ZUFUeWVXYUdVYnl5eHNTcFZnQzRlT2Z2V0NiMlA0NWhDYjk3Mkl2UGNa?=
 =?utf-8?B?SmcyblUrUmUyVzExWFhjUWtWTlY3UUYrMlJPRWs4QWlseXZYY2xEMmZsNDZw?=
 =?utf-8?B?WEw1QUh5Q2hVd0w3UEJMejlmd0ZGM2Z6VTBNci9TbWhuS2VybXQ3b3RYMUtZ?=
 =?utf-8?B?UjJGVTQyUWtJODVNQXl3d2JFYlpzdXlFYTljTmdKZEluMnNvelU4MTFlTllV?=
 =?utf-8?B?V1Fmckt6UnhXU3k0WmdxK0ROZ0NYMjRUUmVzK3FFcWUzdDJPRitTVXRIUWI5?=
 =?utf-8?B?R2tnWTA3Mm1OMkVZUzExNTlBRlErSlVZc05GNzk3MFAyMEZUamoyTDVzQXEx?=
 =?utf-8?B?K2I1TDNhMjZZaHJsN1lZTGtRNlFoMVpZZis2U1RmQnBvN0tIWGhleWhYWENQ?=
 =?utf-8?B?czBYWnhqYjZOYy9WYzA4aW52aDcwaWFyckNEN2RTMnh1VjFGQXY1U1lzdnhD?=
 =?utf-8?B?STRBdzNKRlBSeDVRZmoyNG04c3pmNm5IRHR4eU1CNFFRakQ1VXlWbkFnRjAy?=
 =?utf-8?B?MHNPYytNZkVhUFUvQkpRcm4vblBlQ1ljTURpd3VCUVFNRERyVDI1UzhiUHo1?=
 =?utf-8?B?bFZnbC8zQVU3Y1g0bUpIcktZN1NrcVdDMjVQMmg1OThNRWlTRXo2QkVWMWVB?=
 =?utf-8?B?ZVYrZDRQR3RDdUhzbk1PT2FRbHI3d1N3MFR3L3hyUWw0YkJ0bk1aSm9oVjNx?=
 =?utf-8?B?bmpXOVQrZ2M3anB5WGlkVk92R210UGxqUVRLbDVEcnRWTGRSSzRDdk5hSlBi?=
 =?utf-8?B?UUJBdkF3dWRXNjcrU0hUenRxTytRYWhzWmpwRCtPRUxlTlRiLzZ5VTREOW9P?=
 =?utf-8?B?WFd2em83QVJad1Fjanlqb1ZzZVgyQmEzV0hjUjliM0RVYThMVXIzU3NGWmZt?=
 =?utf-8?B?a2NEVUVRY1hMdGc3bjJwWFNNMjJOOGFIZWRiVXozcEhzazRIbjdnaHFBRkFK?=
 =?utf-8?B?bjBpZVZIU2FuYWdiaE9zT29kSnVmTWlTNkl0bjYyQXNwcGhGNUtJeVV2UFI5?=
 =?utf-8?B?aThac2N4RmU1RWhwTGhPTkZJaHpvODkxRW5qdUE0bjVDWlhsdUlMa0QrQWRz?=
 =?utf-8?B?MlNoVXQ3T2NPNUpCTHAxbjdkNUd4Y0w3ME5vN0QyTEpFWWt5eFZCZWlCYzlI?=
 =?utf-8?B?cnBXSmRWVWkxengyNmR0eHFmcXdPZFlHOWtBT2U4Z2VIZnNSNU0yOVdUWkg1?=
 =?utf-8?B?eFphOTZUNnIwMW9vTFZVTHhkUjBvdVNXejQ4eC9NVW8yQVo1ZEF4NlZUZWhD?=
 =?utf-8?B?NkI4L2Y2Vzh3RFhIZG5LVFVRcHl1NHpZWEc2cEM4Q1M4aWpVQldiWVloYWJ5?=
 =?utf-8?B?K082bHEycGFrREI0MVBtVTNlei9wKzRtRHFoWTFIdGVOck5yZGpKcEZPYXVT?=
 =?utf-8?B?R2dLNmpPTE15TTFjTVBZOWRPMlRLWkx0NjN3UU5sTHIrbm9sWEkxQkJYQXVy?=
 =?utf-8?B?Y0gxZWxkcWh1TFY5d1ZFNy9EQ2tIV2FvVzJLUndWSEpOUDhWT2MvdXAvZzFz?=
 =?utf-8?B?RVN6elBxMXJhdlBkQllkRUYyYmFqWEszeFZoMEhTcGx0eFM3UzcrRDd3eTQv?=
 =?utf-8?Q?yA4Noj3NuMPJ+Sx/oaktDpc=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72a5cf0d-47b3-4f95-b492-08ddaf155730
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR01MB8101.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2025 09:40:34.9747
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l4OIEDwkTjCMgGU2r6KMrgXhHG/6leStmDfcksvrMm+QST3lU3GlaXsZRBIi+3NIcPFY7Rcl9QMmL+tRzGcubtmlHUhxkVK3YYdQ8JwBAFk7JB9UuQjtfrtJm2RZDQXq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR01MB9318


[Sorry for late reply]

On 5/29/2025 5:18 PM, Marc Zyngier wrote:
> On Thu, 29 May 2025 11:29:58 +0100,
> Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com> wrote:
>>
>>
>> Hi Eric,
>>
>> On 5/28/2025 6:58 PM, Eric Auger wrote:
>>> Hi Ganapatrao,
>>>
>>> On 5/12/25 12:52 PM, Ganapatrao Kulkarni wrote:
>>>> This patch series makes the selftest work with NV enabled. The guest code
>>>> is run in vEL2 instead of EL1. We add a command line option to enable
>>>> testing of NV. The NV tests are disabled by default.
>>>
>>> For commodity, I would add in the coverletter that for all tests
>>> enhanced with vEL2 testing "-g 1" option shall be added to force that mode.
>>
>> Sure, will do.
>>
>>>
>>> I don't really get how you chose tests capable to run at vEL2 and
>>> excluded others? Wouldn't it make sense to have a way to run all tests
>>> in either mode?
>> There is no selection as such. I have worked on around 50% of the tests and sent for the early review.
>> Yes, almost all tests can/should run in vEL2 except few.
> 
> Define EL2. You are so far assuming a E2H RES1 guest, and I don't see
> anything that is even trying E2H RES0. After all the complaining that

Sure, I will mention that default test code runs in EL2 with E2H enabled.
The tests code is in vEL2 with E2H RES1 by default, since host is booted with VHE.

> E2H0 wasn't initially supported, this is a bit... disappointing.
IIRC, I was mentioning about L1 switching between arch mmu table and guest mmu table(VMID 0).
I don't remember why It was switching.
  > 
> Also, running EL2 is the least of our worries, because that's pretty
> easy to deal with. It is running at EL1/0 when EL2 is present that is
> interesting, and I see no coverage on that front.

Sorry, I did not get this comment fully.
When we run selftest on Host with -g option, the guest code will run in vEL2 as L1.
This is implemented as per comment in V1.

When we run same selftest from L1 shell, then guest_code will be running in EL0/1 like running from L0.

-- 
Thanks,
Gk

