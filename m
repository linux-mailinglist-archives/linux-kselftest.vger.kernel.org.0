Return-Path: <linux-kselftest+bounces-6950-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1019789431B
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Apr 2024 18:59:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33A561C21E23
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Apr 2024 16:59:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91A9847A64;
	Mon,  1 Apr 2024 16:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lsR6dA9e";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="YrUdKE9X"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A02BA3F;
	Mon,  1 Apr 2024 16:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711990787; cv=fail; b=HoHfwvtKMy2T/G9b/8HZMotfdyfJd7ZWiUO1n4MCph1BG9TApF4Enm5mIYwSGWY2+kZwwsibIFTdDId0ng7omzw1tw10pYT89VXo0nHpVS+zntttam7p6RYjcC3PH1+AVojnNjr18RR5tutS/VbOHQqhjEa67/+o73xQACmzbUA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711990787; c=relaxed/simple;
	bh=ju4ziC3yo39cTVnlwIZcdJmlhNZzMPMHbwr1dO7io1Y=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rxyVdfFVHjBsUgRGxsQ0Bu6HgOiMMm+EEegPkhXnKD2r9isni+eFXSbUFGSUB44jpom7jgBY7RfLwlaJTNiwKgASku3efm32/fHUr/z7n38PEUjUR9u+M3/6BX+6NsHVVn52NRyUrmUJF8hcXL7jE3G+B+S6dHq/1qcCtoRKIkE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=lsR6dA9e; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=YrUdKE9X; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4318iBCC027630;
	Mon, 1 Apr 2024 16:59:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=kQnkzRdQS5qPMxNAk0RvR7a2e5DFOE3kDzc43WcE728=;
 b=lsR6dA9eK/WrY7BoGO6tuzwlj+SFQOs8tdPCi1u3B0Jl4nrUQWPWT39z4JDuV4RTAFdA
 CBUCT6BzZyu5QDAPHVPoGb46hBm373+osi+8H1q4fXf/qzPB0WY+86rFliYPbo1jKmVm
 ShjCCCurIIPitH5q/1zwc1obT+0/UuF724CkffWh9cesNG5Zg3WpQesd7m/HvUpI2xmy
 V/KNaEXOmI4JFVo8a63z3GNelKYlE9PXt5h2nrEK/aJRecpMbvlSby6cbGfsdzyxTpi8
 NRd1CAg+kNKhreOO15alqdBocLjZp3Ah2KPOoHOylYyyGhNTFFy+4ktJOsL3M2BUjZn6 zg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3x6abuas8j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 01 Apr 2024 16:59:37 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 431G4AoK011663;
	Mon, 1 Apr 2024 16:59:36 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3x696c53b1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 01 Apr 2024 16:59:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eOOqUekVjrdC4voKGLDL7LUD1ZvsjxeH81iCunHS+QdO0gwAXPUtZd67v+kRb0pCqhaYAPhVpBDQQOi53ISFkIdd4Sk699pGqoDmpv5pc5uXhwfz1UF/b8v/IbNwPsw58DGqFsriBAswTzUANhL5LrKlhBufwfto5X9CfjUo7WTKOjYeQGM+1ejgoPK+xerhAbnwTD8uCbHgxlhvz0G6cDjKbS9NjE5sanhedQTCLIXwRema1CikHLmPm/SM7OijZ4Q2U5vLSQxgUpKi45gil/N1hjYnQxQN1GG+zvCRm3HAykom6Ngjr9TMyq7C2EksxzHn4t/GyLoXrGrJuOgbkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kQnkzRdQS5qPMxNAk0RvR7a2e5DFOE3kDzc43WcE728=;
 b=FlzJlF6Ozi2aLfFeotWDzvywzmBPQjbUYEK+0dR0p9v6xXhHFlAmW7XR2Nd/cIN3JSAeSO9t7R5KHqcCVGQmSlwR/YrUDNrUsSUNQKecZdA11o78oyxNfHJn6Y4LNN2deIL4th5jdvwIkosFLqJcFvRqd01f5igaSMXRsEX+LF10/ChvvfPrF2XcYCz/mWhx01Fktu+eEkMftuCn/ohpXzY+UeI9QwvjWcIUvary2BGGIrBL/dezpda34AUXVP0vlfDKprZkB1Spkg6eIfRhfGH0/OmhDrzivU5BHi5yqepQNjhdhibzQKmQ7yHCtDbj/x97CHoTAKUq1D2joCYfvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kQnkzRdQS5qPMxNAk0RvR7a2e5DFOE3kDzc43WcE728=;
 b=YrUdKE9X7xQT1X8niQD5C4X7HeIP/Xj4Ih8hVNER6fvl6RqJTVdHzuVfv1q+yvCx1q7p8hiiDXOXX4rudW+Yi7hcNdhU5NTHJUBCSrc8JqjFs8z4FkrFkSYfh2WMcnGFobY7IotfYNmp2F0QnGLFZN7cDhcNqvXDiV5RZwlH0qQ=
Received: from SA0PR10MB6425.namprd10.prod.outlook.com (2603:10b6:806:2c0::8)
 by CH0PR10MB4907.namprd10.prod.outlook.com (2603:10b6:610:db::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Mon, 1 Apr
 2024 16:59:34 +0000
Received: from SA0PR10MB6425.namprd10.prod.outlook.com
 ([fe80::894:70b7:573e:da46]) by SA0PR10MB6425.namprd10.prod.outlook.com
 ([fe80::894:70b7:573e:da46%5]) with mapi id 15.20.7409.042; Mon, 1 Apr 2024
 16:59:34 +0000
Message-ID: <59714cae-4b69-9a3f-87c9-b934f8b7cc3e@oracle.com>
Date: Mon, 1 Apr 2024 09:59:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 3/3] KVM: selftests: Add a test case for
 KVM_X86_DISABLE_EXITS_HLT
To: Manali Shukla <manali.shukla@amd.com>
Cc: pbonzini@redhat.com, seanjc@google.com, shuah@kernel.org, nikunj@amd.com,
        thomas.lendacky@amd.com, ajones@ventanamicro.com, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org
References: <20240401152032.4284-1-manali.shukla@amd.com>
 <20240401152032.4284-4-manali.shukla@amd.com>
Content-Language: en-US
From: Dongli Zhang <dongli.zhang@oracle.com>
In-Reply-To: <20240401152032.4284-4-manali.shukla@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR04CA0020.namprd04.prod.outlook.com
 (2603:10b6:a03:217::25) To SA0PR10MB6425.namprd10.prod.outlook.com
 (2603:10b6:806:2c0::8)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR10MB6425:EE_|CH0PR10MB4907:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	WzKcAETCzSWkfoo5UuCk2WDhWYfYcKuf906kz6kNqgKBhkCSbEC0/4f5BB8p2asf4LLcpus8NS7YiWxWUizMNp1niofT+t/BMHxwf0SyVUOjmNRryN0TP2mq7dHDfCqgqg4QgMZkHZRSD2ErIIDeRVJ7beccG3EmaDwYqFta6Bv3y4X8YnbslhHdoTb3g1mxBmkXUEi/lDfc47VmtEivSQGrFmQ+PHxtNO4tviYoaMnUS6A1hE2/wlircIFwg6P7JdRFZai3UprZIpFIDoqJJIrEVyxkhFpsO3NfyLk+t9uhWt6pY0khYpHGbb/Vp96Fa8U5e58XkD5BygV4nbQKWbIM/NNU572EsNCL+A7oACSUsyrVNiWfySYfm/Cj0A5G+9OsU3W46dOszmmIJkUjJGWrcl7RxuKe8STQpSHk/Xsd/aWMfoO3t1c66/wA9B95HDghMfe/tBucFcsPupn8QwXLmY8mIjSXsDuBkpuMGhfs8OtW9RY0XkADo/aW9cu54bzzujR8P8sG8qbq/4xD8uvier5iehi2Hl3cHWtlSl6TevShqBiXKRlxk5awFOG4KBIuKHB8MRhrq1rKwN4hwJY5yj//u5flbZ/eWyYVkaYsuf0uO3m2J8vnqqtmYn/A3MjAvdjYP9zBHJ1gzuVz/FUXl2XGdAeFsE+UcAObdMs=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR10MB6425.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?V1FUNHRER1VndGNES3pnK1ZPUUh4WEJzemEzYzg5MEp3NHhkVld4OVBLU0Uy?=
 =?utf-8?B?WiswWEhsSGcvK2M2dVljNkVLWlhMMTBxRktWM0lFWEFuM09aU1Z4YktJZG5y?=
 =?utf-8?B?V3pNMDRpeWErZlBPMWZCMkU5TUw0cm0vMlRaa2UvOWl6b2pLZERST3NYSjZD?=
 =?utf-8?B?ejhzNEZteFFKb3czSTZoNDJOYi9qQnlhZHlyUVgwbHRXaFRGbGkvbnIvclVL?=
 =?utf-8?B?V21ZVjBkRW9Wdk1GNDl2eENYb283YnJsc2VFakFxM0hYKzN1V0w3Qm1pTk12?=
 =?utf-8?B?YmV0RmlTbmwxYldHQWVlT0VuMmMvbzFIdU5iU3lBYW4wYWhic0pNTW1kL0gz?=
 =?utf-8?B?SHltR1NERTdGNDBVdmhDVkhIQUxlUHBiK0hZRllRQlFnV0J6dHZYZlorcVI4?=
 =?utf-8?B?ZFNDNWhxNmdISFlDZzBTWU9ITVRHZU5XcXVxYjMybUdyYWw4d21sV2t2SmhQ?=
 =?utf-8?B?VzVUakx2UENXcVJuUk1USmlNQmRVeFQyWlJZWnVOLzJmRDFkQnVSMmJQNGtq?=
 =?utf-8?B?V081OFhPWERXUm9Yandwb3BKT3U4OXRpTGYwdU16cWExL1BrOEErQkNvYzZn?=
 =?utf-8?B?cVY0Rk5oNzdXaU1QYVBLLzhnaVkzcjVORVQ1TFZVSW9ia1FIQmR0UHA4Skpt?=
 =?utf-8?B?MG1wR0liUU13QitMRkN2TjB6YTRuMzQzdnUzam5lVTIzeUdENitsektTOGFa?=
 =?utf-8?B?VEZtbG4xZ1p3NFNuR0h1K1lmYTAwYkRpUkVmV0hENmQrR1lqZVgwZUVUeWtq?=
 =?utf-8?B?aE5CTTFHaytCQXFSQnhUZ1NkWTBBWEdNMWdWQ2tDNThIK0lEcitMY1ZVVHZL?=
 =?utf-8?B?d3ZiZktPUFJVOU9HMDhjOXNuNmhQRU84T1ltVVZNNTUwREpXNFE2QXRPbTZI?=
 =?utf-8?B?OGxTRFh5dkI3Q3QwNmNISmVadFFYbFkvTGFtRXRyT29Nd2JYNmNXMmpnRlFP?=
 =?utf-8?B?RVVBWmdYNDc1eDluOUdMOGFjalJzNlFzWFRtKytDcFJIYnhiSFV6ZnIxb3A3?=
 =?utf-8?B?TDVLUW9OZ3lYWEhMSDRYa0dYeGxrdjJUZmR6ZE9DODZVbVkzL1h0NGRiZ1V0?=
 =?utf-8?B?OHc3NWtCZUpGZEgyRkkwZ2lNZVNYdCt1eUJ2NVk2cFpTWUNveHRXWWJzNjBo?=
 =?utf-8?B?M0lqdnBkWlVSdWs0Q2dLeTBYaG1CRlYzaHhzSXhGYWZpUXpNZVlhWUFwc0pL?=
 =?utf-8?B?bU9jalg4aUE3dnNJdlVDc0xtN3czNDZsTkxaOG9uM1lBN1pINWp3Slh5WGUy?=
 =?utf-8?B?SzhuWUM5RURkTGs4dytGN1FxZzc4YWJrdnhPcDN4K2xsOUpBQWxjZnRiaUNQ?=
 =?utf-8?B?RzcxazI1cUlHOUFXWWV1QzB1bDBJL25sRXBUQUh6YkxoV1RKU0pkWU9kSHI1?=
 =?utf-8?B?bU1LaFAyN2tsaVZZRm1IeUMwSzBQMElhVHdvM0lJejUvcE9zdldBbGx0TVlo?=
 =?utf-8?B?MGZxeEF5MXpxY3FOWjU0cWxNN2piY1RSblRTYThlVlludGxNdFlTZ2ZrcDcz?=
 =?utf-8?B?anhkbDUwSXNMZG9CM0lDOXdScWtIeEtpMWtoLy93bHNlcis3QVJXV3k1RW1H?=
 =?utf-8?B?OFBVQjhMelRHbGNXdjZrbnlUaTJSdHVFV25CWDBIVm9hMjRCMnk3bCtXVDlI?=
 =?utf-8?B?WUh3Qm9qS1MwUTJNcHhOL3EzdzFlQ3FxTmhFUVo0RnY3YUVETVMyRkpTaUJY?=
 =?utf-8?B?clpkcWpyYkh3QTdpNENMOWR2RVg0TFgvS3hOejRxY1Vsa3VxU0FaZGdSa3Ns?=
 =?utf-8?B?Y1NkTnpoWkkwKzJxMmorY2dBMmRFbURvck01VVBaTzgrN0d0eFN0S2NnU2ha?=
 =?utf-8?B?bm5Vb0hGclZhVExDYVprVEd3RThTajdxZDJHcUlMcHFCTXdSOGRRWnR0eGJL?=
 =?utf-8?B?VkoxY0V6TnVabURRWVZyWFEyY0hRWkg0QXVQNHBEUmwxeTNGMEpSK2o3YmxB?=
 =?utf-8?B?b2ZiSThLMjhLMXlsc0VEMXVHWjFaQ2xjZ1RxcXYrL2ZMR3kxUTR0QXZsQWJj?=
 =?utf-8?B?UVdZWDBETkxPNnpjWVMzRTE0UDRVS0tDdkpwb2theHpKWEd1UkVUdWk2bEpk?=
 =?utf-8?B?U3hoRHVxZnJMQTFlcW1Tci9rY0ZIWjZlOThOSUtsSUJidlZJaHNpdG82Rmxw?=
 =?utf-8?Q?tdFjB6KgsTN7u1sETZs23JC0D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	6Rfcoqzmftp3ezTJn7eyC6+VD+fVLl0KvXMYA296Xwg+N4GzlJ4PrQQHpZXFKukTUfNErt4qkFjbqDvH/w0FzH3ssEjWuAkFLPNWTfHkfuMHWvcIKU1Zmrvro3pVKWmicjFkFUmpwsxlp+BiEFhkrKSPC6ngj1Hz04jAJ/STZ9BgRQbAhVskmHtnP5+EZULMHbVQTDIs35uhgHdQrRDTbJAarrffSpGlIYW1twJMpP2bw+UmPHE1dsW3tjn0+8domIDqFC0gE20q1oRAPFOeiFztYRgulzWfUGMb/2WBqN/TkElQxAO8DvimioxRNiDpqZUx3jiw/pdvEXh2zMQJua5kez+klpzpAc1SMdLnwjtzH8b9bSY8CFICJbVjkHvPB4dT7EQyNtXLExej54UErr8IUV4eP/EZoixCgx6c+N8nrhTgXVWItQ1rtQkbI9n1ydosGzF43kfgfcBLto8lg2it1fcMNwKWk+vpc8WiP/vQV24bBrG9jHUnMyI7/eTo4QkCg890pWkw+21UrBr2ebYYHwxWVa60BLwgOziHqous0S+FQSJaoqBxQO/zo3ldQXqaCjrqeZakSzww9+8vjZxzPC8yH6G6nYcVIxY/zeY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a709464-df58-4e3f-9810-08dc526d1b1d
X-MS-Exchange-CrossTenant-AuthSource: SA0PR10MB6425.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2024 16:59:34.0808
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jqeE+poEQ5gMbp+ox28nMrCvCG+6YSY4f/IptoSuIjUGzfkjllf90gFwWjsssvNjDkw3MLsrNSRs/sc/Zbh7rA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4907
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-01_12,2024-04-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 phishscore=0 bulkscore=0 spamscore=0 adultscore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403210000 definitions=main-2404010119
X-Proofpoint-ORIG-GUID: BBufE6BbQMtVvI8KcBrFs7Fq9XYmFi_A
X-Proofpoint-GUID: BBufE6BbQMtVvI8KcBrFs7Fq9XYmFi_A



On 4/1/24 08:20, Manali Shukla wrote:
> By default, HLT instruction executed by guest is intercepted by hypervisor.
> However, KVM_CAP_X86_DISABLE_EXITS capability can be used to not intercept
> HLT by setting KVM_X86_DISABLE_EXITS_HLT.
> 
> Add a test case to test KVM_X86_DISABLE_EXITS_HLT functionality.
> 
> Suggested-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Manali Shukla <manali.shukla@amd.com>
> ---
>  tools/testing/selftests/kvm/Makefile          |   1 +
>  .../kvm/x86_64/halt_disable_exit_test.c       | 119 ++++++++++++++++++
>  2 files changed, 120 insertions(+)
>  create mode 100644 tools/testing/selftests/kvm/x86_64/halt_disable_exit_test.c
> 
> diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
> index c75251d5c97c..9f72abb95d2e 100644
> --- a/tools/testing/selftests/kvm/Makefile
> +++ b/tools/testing/selftests/kvm/Makefile
> @@ -89,6 +89,7 @@ TEST_GEN_PROGS_x86_64 += x86_64/set_sregs_test
>  TEST_GEN_PROGS_x86_64 += x86_64/smaller_maxphyaddr_emulation_test
>  TEST_GEN_PROGS_x86_64 += x86_64/smm_test
>  TEST_GEN_PROGS_x86_64 += x86_64/state_test
> +TEST_GEN_PROGS_x86_64 += x86_64/halt_disable_exit_test
>  TEST_GEN_PROGS_x86_64 += x86_64/vmx_preemption_timer_test
>  TEST_GEN_PROGS_x86_64 += x86_64/svm_vmcall_test
>  TEST_GEN_PROGS_x86_64 += x86_64/svm_int_ctl_test
> diff --git a/tools/testing/selftests/kvm/x86_64/halt_disable_exit_test.c b/tools/testing/selftests/kvm/x86_64/halt_disable_exit_test.c
> new file mode 100644
> index 000000000000..4cc6a09906a2
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/x86_64/halt_disable_exit_test.c
> @@ -0,0 +1,119 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * KVM disable halt exit test
> + *
> + *  Copyright (C) 2024 Advanced Micro Devices, Inc.
> + */
> +#include <pthread.h>
> +#include <signal.h>
> +#include "kvm_util.h"
> +#include "processor.h"
> +#include "test_util.h"
> +
> +#define SIG_IPI SIGUSR1
> +static pthread_t task_thread, vcpu_thread;
> +
> +static void guest_code(uint64_t *is_hlt_exec)
> +{
> +	while (!READ_ONCE(*is_hlt_exec))
> +		;
> +
> +	safe_halt();

May I confirm if this selftest works on nested L1 VM as a hypervisor?

Thank you very much!

Dongli Zhang

