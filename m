Return-Path: <linux-kselftest+bounces-30099-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F0F7A7BB51
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Apr 2025 13:04:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 503437A79BB
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Apr 2025 11:02:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8011B1C84DD;
	Fri,  4 Apr 2025 11:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="oraHYNOn";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="rbCK85re"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD0FD19F464
	for <linux-kselftest@vger.kernel.org>; Fri,  4 Apr 2025 11:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743764634; cv=fail; b=NFKf5BN3Uiw1F7dIGi5YQWC2QiYplAlhQs6yENs1XeWtGA13QGyJU3PS7qk4QiK306TSClajHyopIa/goOyuUvZtfbvKxb/tGPKkcIpJFQien3tLumemTDrX9FSDV9xNXaPwkm1+rIgnhnKocog0dzft6ceaa8rtD5FpjqzYBE0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743764634; c=relaxed/simple;
	bh=o9pxcU107DC/ylScNCC0WfZKL+mB6dkYo35Rdr1Inas=;
	h=Message-ID:Date:From:Subject:To:Cc:Content-Type:MIME-Version; b=uDUCPZkKWkrwkUFv0zRzw2xIULStEfjBR/+fJPriQVnwmNWhkRjid8WAeKXs3h7CuXlcbG4S8drc1uTRSMyzp300r6tpWYvUo5ZiCOXqoDyF48vsDMg/YR3Y6zEwobcfJlTrAzbru2dlqAZZq6GsES0xqWoeJ44rPU8e+SJ2ie0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=oraHYNOn; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=rbCK85re; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5348N3Gm009445;
	Fri, 4 Apr 2025 11:03:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2023-11-20; bh=diD5fRNZZRKS3xeT
	QY5AinxO4aFYDOfc94zDpygm9Ms=; b=oraHYNOniy6FzSzNA37yWIGZHdmiLE5M
	rNfRrCojcoaBRVj3boUGfuye+3FabuysxBH5BbtopLFECuXK+RwilhsNzEq5d6Zs
	vYZ5wXhSnRA7SJ1zn6fFHnwkonHbOHhPA2vnxpCoGSeDmehvvc8iU3jVfaQIy225
	s4kWZlwgpFJCazoxHGPnF442Gqpj8v/nCKj0loLe0GAdOBgBcJCv1zaUQVDEMMnc
	TzsZPjSL5aVM/65ECSV4vSOj7k5S6sPO8JKghCKjcpPEZIzVoH6+sDbdJOnAGbwi
	U4n2EHVTtQ8oHpR76T5AOTYvPjYi4+iMgVgTKaV1X3YxTzlBQ4K0eA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45p9dtptpg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 04 Apr 2025 11:03:35 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5348kavR020648;
	Fri, 4 Apr 2025 11:03:34 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2042.outbound.protection.outlook.com [104.47.58.42])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 45t31wv63p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 04 Apr 2025 11:03:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jdkFMqqUXStIBFT4Uf/sDYv6VxyRouHpHAOW5QwZszMni1Y2KvXvzTJTlrjeburIhG2d7BDCFOEclp/FZSI5iEqXIgyimbqXjFxiHZc7nH/qFRv4ZU/Ld8XaZ7zvbNV5MFmaPnPEfchIwBdz+BvgsrHvZFDp67FBzrBcrc+WfhVjJ9flskiWglwsNO5PVF6JdrPpjLBzbypwPy0O5wXxGtPHKU8x4ZIuoZumAV5j65lgdjpcmIIvoWmnepaFjvP4BHInDa6ToeDq0NtIw/St93/illTzZcNm1Y5Lt6WK6SGgXBS3V19HlJYyQvHvWwblGsDgBX/y7weZ31HkHOVbWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=diD5fRNZZRKS3xeTQY5AinxO4aFYDOfc94zDpygm9Ms=;
 b=GXNk3yjbxgMa7+QkzMN5h+rDt7366jHp8xvQD6CrtUIDPa9rNHNsbSiVwwxNiqR5PS5ZxqgGsNQnbkfvbYeyWtCk+V+yNjnENV3fd+xGEreYPqdigNzRWfHHl1UggfRFjH+QkeBhPJz6o/qyjPv8yD/mAg6pxf47hhZ4smKBAesXnq8GKxk3D0H/GBuMSHcibUpYRWGyVH0LdWs2WNT1ktu8vckmBwowXy7/1GRiOX9pp7vW24o3ObS5FM6oVCde9rMroRjtf2GIEBWajt3U7DLf7nfZkcHzzeAXL9m1TNfQvnVnI7WcSpMMU2DG7+us1WxZIXDmVP2ZqwElWhhUlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=diD5fRNZZRKS3xeTQY5AinxO4aFYDOfc94zDpygm9Ms=;
 b=rbCK85re++HIjx+0f3LA+BssuFDiG7iGdGKs15d8hEKd+yR4W+bY9aJD9BjQgD0coCevpPMhc52mXqlhiyAeE0TZUeH6B5U6yLb+WVWtXt+V02SSk3JHyoh+TMN+CF6N/+Rlx/JUqYBJicLBtVN8dJQfI9lbox4FFZxCKf9sAac=
Received: from DS7PR10MB5328.namprd10.prod.outlook.com (2603:10b6:5:3a6::12)
 by DS0PR10MB7953.namprd10.prod.outlook.com (2603:10b6:8:1a1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.43; Fri, 4 Apr
 2025 11:03:07 +0000
Received: from DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c]) by DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c%6]) with mapi id 15.20.8583.043; Fri, 4 Apr 2025
 11:03:07 +0000
Message-ID: <8e3b6cf0-0341-43df-9b99-e5fa10935262@oracle.com>
Date: Fri, 4 Apr 2025 16:33:00 +0530
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: ALOK TIWARI <alok.a.tiwari@oracle.com>
Subject: posix_timers kself test failed in 6.12.y
To: tglx@linutronix.de, frederic@kernel.org, anna-maria@linutronix.de,
        jstultz@google.com, "sboyd@kernel.org" <sboyd@kernel.org>
Cc: linux-kselftest@vger.kernel.org, shuah@kernel.org
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2P153CA0003.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::20) To DS7PR10MB5328.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::12)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5328:EE_|DS0PR10MB7953:EE_
X-MS-Office365-Filtering-Correlation-Id: 37b1a514-4be9-49a8-44ec-08dd73684764
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WVRnL1dwNUhKNTY4eEpKcEc4QXFQdXdjVHFuMkdqclNjTE4yOVV6S1FoRW5D?=
 =?utf-8?B?U1pkdElISHVZWXdmMXQ0L0pLUmxCckN5N3lGTW82bkFWTTU3MnZ4bVpYdnNX?=
 =?utf-8?B?dWFRalNlbmVENUx2eHhsV1hFUTNDY2dINWU4dDdQcjI3N3JBOElmNmxMbFZx?=
 =?utf-8?B?aGxNQjBJdjhFcXh6eWQ5QmdKRXMwWFdLZ29sZGZtbHBRQmRBK25lWnBKVXhT?=
 =?utf-8?B?c3ozQjBZaXVoZ3B1V1czZC8yN0lnNzBKNE14VHJVZjBWM1B0ZEhMQTBwaVBM?=
 =?utf-8?B?T0dxeDBCeUZid3licm84Mk56RDZmRERIM21aNXhOanpneUdIRy9JZDJZQ3M3?=
 =?utf-8?B?NnJkeC9KTlFoeWZoZGxSR0xOZnB3T2Q0RXZYVXBDdjRyWnNXUmVvQ1AvQVFY?=
 =?utf-8?B?bEI4ajlnWFFxTk5adU5vYW5ZTGFCWE9CcVVVUnVNZmJNS2NNSnlramtGTnkx?=
 =?utf-8?B?U1ZJVkEySUlybjJJMEF5U25rNlk0QU5lYzl4YXZlaHVHNjJGUDNtTjFjaDlE?=
 =?utf-8?B?L0I2bXYyU2dKVDRTeXJ1R1FFZGthM0Vkb2UxaXJvVW45V1NuK29reE9SaGtl?=
 =?utf-8?B?VThjUmRHalpHS2hhZUNNTFNjVEl6ZGYrR3dnRUhFU01HK3BYMUQzeWs4KzJr?=
 =?utf-8?B?QittNEtueG9lLzlrMU1ZZnVvNUJLc3dUMXdDKy9zK0ZQUjN6Rk1rK1ZnTUhw?=
 =?utf-8?B?YkwyUm9kcHdacHhNMU9MUDZWa1hMWW9TTHdWdG5ZdDZXaEd2NUtSd1hvVFlB?=
 =?utf-8?B?QmV5dG1VbXhtMkV0bVA4bHRtODRvR2RiSkNJWXpIc2x6S1oyaUlyMzZQOVFT?=
 =?utf-8?B?T0pmbEhNMjAwZ083WHowdDVzUytNRlBYRVNzZXpndnZLSDBBSURXSlZSNU5G?=
 =?utf-8?B?d0NCYkhySkphbHhaTGNHK0ZvVFFMZUw2SDQwYUszMFlGVHV0TDhwTVdVL05y?=
 =?utf-8?B?VW4wbWJJaHEwdi8vNThZc1ZmVmtzREZpKzZ1V3hBRll6dDlrTW1UbHZRR0VT?=
 =?utf-8?B?WjF2VG5GRjdYKzFPck13SnNBandxcG8xUnNXMzFqTlRjZ21EZzF4M0JoYWh2?=
 =?utf-8?B?Q3FYU2RsQURlQ3NRdktYZTFqTld6OEUwZ0RUTW12RG9Fbm5Ic2o2NjArb0RP?=
 =?utf-8?B?Y00vNUQzZEJRUXNGb1pjelJvc0gwNlJuNTFFS3ZhM0pTMHZVZnhTMzlrdWZ5?=
 =?utf-8?B?ZFozNmNZSU5MbDNWS08yQXZheS9aWXhiaWZnUVIyN3BXZStVakFTTWUxcDhD?=
 =?utf-8?B?Z1h3dmdaQlVrS3dKQ2d0bEVSUFZQWUJZSEJXRVpXZzF4T3c5c0ViY0tRYm52?=
 =?utf-8?B?R2h6ZStuUWViTzI1a3EvMGlDNmg1bHZ0Zmlkc0VIcXVDMGNXcVhpT3ZoTXNy?=
 =?utf-8?B?eXhsTmNGS2lXWURxYW8vVkhlVGk1ZjZDWktWUVZCM3kyZkRkcUFnUjNTVENI?=
 =?utf-8?B?Y09GZmtIYXVWUFhka21ZQ1V3bDJ5Ujd0ZngwWGlINGlMRmNpT3hZUjlaMExN?=
 =?utf-8?B?K3dQQUlVZUFMUE5wN1hqNVlaUkp5MnE2dEpUVThPbFZXMWJpL2NrUkNBYW9z?=
 =?utf-8?B?bFYyUGFOVXZsYnJPMndzRDR4L1lPcFB5MUZtNW5VUW5JbE9TRWR2MDZqRjRy?=
 =?utf-8?B?VVBON293ekpjQ3YwZ2ViamdQaW9WMEN3WXlYbGFpZ2pMVmcvUW9TUGNsQzZh?=
 =?utf-8?B?OUNrQ21lc2pETDB3Si9USldNVE93K1JoblRTVTY0ay9KTXFNS2ZCYjZvbWJI?=
 =?utf-8?B?MEtINVloOWVaaFBQVkJnZlVNWFhRY2t5TldnL0pSZUhMZHlEYUo3WnVqRWVG?=
 =?utf-8?B?dWdUaC9IRHM1aG9jcytiWWpUblJldkxzd0x6ME9KR1h0N3hEcTA4dmJ0L242?=
 =?utf-8?Q?mCSBMDCx0LZwD?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5328.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QXRNdFVoYk80OWhvL09keUNBb1JtWVhkVTNHTG84QVo1dXlaV05kaUlIU25C?=
 =?utf-8?B?YXRrUlRUWEdBOEdRbDIwcHhaM0hlbjdUV0Nod1dOR3YvVVZ6UTkvQ2lKbWlW?=
 =?utf-8?B?Y0VrS01TcEdOemI2dndEOWdTRkVYV01oMFRJQjlNdGhydUM1MDVvSmxqU2JY?=
 =?utf-8?B?QW1SMWR3cjQwL1Nrb1J6S1AvbXR0ditFWVpDb1l4VG9MajhsMlkxYS85T2tT?=
 =?utf-8?B?cERhdE1ybVB6R05PbkppbHFWUFp3bWk3QUtCcURGS25CcjlBZW0zWE9JL3Zp?=
 =?utf-8?B?MmorTVdhQU1UTURNTVZjbWViUUJWVWZpeGF3WEhwTE1MbkpKZ0FXNmxFZC9u?=
 =?utf-8?B?YVR3QllpMm95TDIvY29qTHRJL2lYeEN2ZVFnREI5VGN5TnplU3czbVh2cUNz?=
 =?utf-8?B?TVlnNm9jUVMvaHI5QmpCZTlXSGJnU1JqVGtVMlRmQkJwdkNhQmVWaWVsTWpE?=
 =?utf-8?B?bDBobkRyZnhyWkVjcHlHcENySkNpZU9rVGV3VE5RR1FaZkMwaUpQNHNZSkRJ?=
 =?utf-8?B?WHBwZ2c5R0tEVmRjSDIzRURhTzRGTG5kcm1RTFdhNk44NFg1WG12Q3BxTDFV?=
 =?utf-8?B?REo4c2ZldjBMdmpZQTJ3a0xkOFpRb21hZ0NSbnVYMGp5WDRLazl3YURjOVlC?=
 =?utf-8?B?NXV1dWVIaUx6SzcrRmJBa1NiWWxTVDV2NGF3NlowQ1NxQmFZTWF2YkJaUldz?=
 =?utf-8?B?TUVDZ3BMcWJSL294eGMxcE1OOXdqVHRpYWVYSnJGRjEwZGp1T005MXM3cDFP?=
 =?utf-8?B?ekJxQ2VkSkVMeWNtd3BLQ3BZMkp2R2JRb1dEZ0pSZkVoT3l4MnBSNXJ4NzBF?=
 =?utf-8?B?cmw5L253alh1ZkhzY2k1OXBXSEJSeitzNjJqd3BiSUJ1Mjg4Qm92RnVsZjRH?=
 =?utf-8?B?cG5Eci9ra1c5b1hib1loNFdvbWI3WGR5NkhzQitBMSsvYmdpNUphKzlvTGtH?=
 =?utf-8?B?RmpXSlNMN01HbUZ3VzdMeit2d2lyNzY3b0NpaEI5QzZNbTRBK203cVVSbUlI?=
 =?utf-8?B?MklxMkhNZHh5bkU0SXhBOWFDZEpPQzFRNnhZeGZDZFlkU0l3ZkcrY3M3Qldv?=
 =?utf-8?B?VlFzQ0VhQnJCc1J4Z1JUSkZtQ3gycGxyVkRtaFBUYmlpdG43UHBlU0ZvOUZQ?=
 =?utf-8?B?bUdvaHhVV25oNlUwT1o0dC8rejc3c2p1ZDRmV3VZc1dXQnRDaUVUc0tBVUtD?=
 =?utf-8?B?YUwvSHRRbnBaUjQyNzFWdGZlTHF6SXFQSVAwZkhFK05pRmZXV2FFNk5vT3h3?=
 =?utf-8?B?R1QweEFkSEczZlJGa3plazhJT1Zjbms3djVlMVY4NlcvWDJYUWRGOUlsc0Rw?=
 =?utf-8?B?YmE2eGpSQ3VRYzd2ek90VHpYU0FGTlZIMmJaT1RhUm04Y1g2TU55OXpjZnor?=
 =?utf-8?B?OG1mUkRFVEx4OThSc2VmY1pEN2VIS2tLbjEvbEZOTlJVT2xjcklTSHJlL08z?=
 =?utf-8?B?Y2pzd28rY3hMZXlWaUZ0OGJUL2hHazM4TXRjUHE1ekhZNWNhWnUwRGtVOWo2?=
 =?utf-8?B?cmp6Mmt0d1dzUFphRVd2R1BEY0RIdmdjMktGQVd2azR3MkNReVFsaDc0UEN5?=
 =?utf-8?B?S1MyeG5kSnJRK3IvTFhsSk1VUG9LS3dvUFNnWkhJTVhwVXAzOEI4ZmxCR0Rl?=
 =?utf-8?B?YldFKzF6WlVPWS93NHNxNnBGUmxWQlVLMjFNZVE4dzExRUw1NjcrVFJtcGNW?=
 =?utf-8?B?cWdDclpkRktLVkIrVkRlaWtUR3crOE9EZC85MC8ydVFxdWZTNE5wYWp2NzBX?=
 =?utf-8?B?U0JOeDFtbnF0dk5WLzRxZGQ1aTBsU09mMlcyUEliMWpmM1lob2dqaXh0RytT?=
 =?utf-8?B?c0ZyUkE4Q3FraGZ5aWpLV3V0YUJ5VmVzcTVlVW1zSzVyaGlSWnZJK3lHOUp1?=
 =?utf-8?B?N1hmTVNsSnNuNU1wRHRjajBySW9VRC9tMVhiR01hSTlvOHcxTFVkaDZ2ck5u?=
 =?utf-8?B?TTFJVkt0aXY1WDVzRkVpbHpRbmZ3K1JCTGFSY082cGtrb3NScVAxbGhWWlFG?=
 =?utf-8?B?eExSV0FSMGtSdU9OREpEbE9kRlJBSU9CMjQ5NGw0NkVoRks2L01tbFN5ekpu?=
 =?utf-8?B?S053U1NFQjBFcWJpMDNpcXF2QU9VVStzbHNzU0dQbUxkM3lOTXI5WU9VOVg0?=
 =?utf-8?B?YmdPT09JZTNRaWQ3L0hMVGNkWVJFcFltMVBMekJPY3hId0ZaMTRwS3ZHeS82?=
 =?utf-8?B?VlE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	b58nzSGskJyBIAwgU+Se4pKiBX+p7XcueU9fio+vPJqmpAaeBq5d6THmTGBa0v+BXiXgQOeGQicaByhxKQkwivxhz6Uh4RS/f0dtaXnCHfbQ2ukIMmawV5FXfN3sYXexkVcOwsMTuEHxtNlOyMU99JK24ksNU6hoVpSVelRITLW7a/xl4OHEm2Hx3i4RasJ9KQ4pMZOC3Gh/Iqv7/P2B8fOkB41ygtNRxe8nJS0VbcUXhmbjT7xdMLs3K3WpOc3SZCKJ0IX39BjDFyywzdrIj/8oZUItPopAb1d/0k7Du/wilj0KWDWbuNANs87dLpZoFOlqA/9vX0RvLfoCEfXeYGgcDXAfSr3F9NgslrBXG7JW5jDgpWHvKUBI2PvY4Pm/J1ngYxzSMA4WNGj9LnSkzvq7GdfoFqp9jUsGwe+Dn6gX/p+ALPpx4dNqjXuKCtVBcAHTBJ83N0/rVqevRSu1fVf5UnwKPMc79K9fGk8gnuZ54nI889c0Ur14AaDl9fTR/ETEGaYcDIIecb3NrDuQLRTs1SrI657/MvfHekLy2+vLBMzpCfbpyXls9JsxujZraCay5WmTCT2aym9FlA0/wccep42zqDRDkKo4Ybz/Y1s=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37b1a514-4be9-49a8-44ec-08dd73684764
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5328.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2025 11:03:07.1021
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ji3r+OFn/Bs3uNM693jSopkWIsICNXUOVe3hrwrS3DfemR/e3qydPcFGBQuIi43+atEBQOAnD8keWEvRv4nLcrCt3/22LpvlTdGZiXSVRLo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7953
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-04_04,2025-04-03_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 phishscore=0 bulkscore=0 suspectscore=0 adultscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2504040076
X-Proofpoint-ORIG-GUID: YcmH9JeBAeSjrL391MhvZHL_7xYPMZl_
X-Proofpoint-GUID: YcmH9JeBAeSjrL391MhvZHL_7xYPMZl_

Hi Thomas

Following posix_timers kself test failed in 6.12.y
-------------------------
not ok 7 check_sig_ign SIGEV_SIGNAL
not ok 9 check_rearm
not ok 10 check_delete
-------------------------

Reason of failure:
6.12.y does not support these KSELT tests,
Because the following commits were not backported in 6.12.y:
6017a158beb: "posix-timers: Embed sigqueue in struct k_itimer"
69f032c92cf: "signal: Provide ignored_posix_timers list"


is it feasible to backport in these commits or complete series of patch 
in 6.12.y ( [patch V7 00/21] posix-timers: Cure the SIG_IGN mess)
6017a158beb: "posix-timers: Embed sigqueue in struct k_itimer"
69f032c92cf8:  "signal: Provide ignored_posix_timers list"

if not, we shall revert following kself test from 6.12.y
45c4225c3dcc "selftests/timers/posix_timers: Add SIG_IGN test"
e65bb03e4427 "selftests/timers/posix_timers: Validate signal rules"


Thanks,
Alok


