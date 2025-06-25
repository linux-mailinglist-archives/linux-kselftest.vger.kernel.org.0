Return-Path: <linux-kselftest+bounces-35778-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65A34AE8365
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Jun 2025 14:57:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB2B317A774
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Jun 2025 12:56:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34343264602;
	Wed, 25 Jun 2025 12:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="C2wPjzZ0";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="C2wPjzZ0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010001.outbound.protection.outlook.com [52.101.84.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFE1E263F52;
	Wed, 25 Jun 2025 12:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.1
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750856023; cv=fail; b=rKxmrAugCNzcC45p47Bd6K2BpDJlayXzfA1QoVSyA3ckhD4j7yjo1K+Qy0TGEPGjnoypbjDX43AWwAMT3yM1LJivCZIknepoOIg6KHoyvZ8ORcAx3/z2Mg8+ByrjoT/Q49kutuB3k507irrLGTuh53nzTZFal7Br8M5Piee0AjM=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750856023; c=relaxed/simple;
	bh=7+0BD1apJUOkyEZS/+Luz8cYZHXfjVr7CchQMYWJGWA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WOg4PcpcH31NajpE2Fd0ATImkPhkuC2+FiWxetD68H9ZtEkKsB6RKUHHP7RIlL82iIrYqT92J7mydZiR1q5PZk9F/QO3EE+jWh0MLlQR93tibP+IBq5tvycSN4Q+J0ngBRXx7Btzve8A9frDjjHD/hZbfXf9Ik1csiZn3G9DC3g=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=C2wPjzZ0; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=C2wPjzZ0; arc=fail smtp.client-ip=52.101.84.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=SXHau0ImWWFUHSRYutiRcB5CR8FD1q59ZOu43luKFeI9nKD4D3PN8sAEzxAEqUxbs7PRqadnGJ/9nHWItg7J06cNhEam0SkMhp1tpos7QohahEa8A2V8Wj6eXr/PbBY4Sah/by3StisDgiq9zxZYUPr4KYTllDbhzQuL6CEvX8fj9QK0fyp8H42pF95T3Fmn/50ndrZRNUJJgrJRT3y38ijYeYEcWvXbebpwEadFDD48RRzrEuVYA8O1qOJUNsqLW51cZrb9+m6utmnnLWWlQISaeTlXwp3KRqaoPXqKsyFK/KiVy4wY+sJG6BI/CXMRuka5CWCmzpL7Os96DvSrOw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rFKBbsxz1C3B9YivlNyUBqXB6NmRbQLfEBUtfT96eTY=;
 b=taznAvstj2C9zsvM8K/Pl7W8YW59fTTPobwWpl1A44PD+nucZNYuzzhoAwUjLZZYVq1J9utJjhIGSgGIGNKJE+e3xd4QZ61L6y4EAFemloHUdJRT/PtOxIhmM2TZYSFCT+Uw9BhgOoRgbJMfQqGA6Yl0EVk+TXp/bjp9V3heiwkkR+foRzrwiS6dOl6wOjT3ZSsnFxQb6SL7eCQtcCnzGfP5Mqty1SY43EjapnTBbkCAPuZTnl3YfvvfU+2xE5w4v95RPdH1loyMyHEL6qsyhXywT6e+8b5LxjXKUHkb2fvQ0NoA3Wd7lZN0hf4MDrJ8pGMOzHjUvFnoLIwCg2dECA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=linux.ibm.com smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rFKBbsxz1C3B9YivlNyUBqXB6NmRbQLfEBUtfT96eTY=;
 b=C2wPjzZ0gQ5ofWDVteJfyexwWCwDGYR2i/XKO0hUEteatUL9/CeoSUzTwkoGuAJAVTzf1ALVIzoDqVAkk+vGkXyFaCpDCNVW4enc4MGuIKn+RphffkSTBU7Yt5TC8l1v0lb9x7dbGexxLOyymMhxkO0eaOzSCD0Ii3qanrQPctQ=
Received: from DU6P191CA0018.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:540::6) by
 GV1PR08MB10955.eurprd08.prod.outlook.com (2603:10a6:150:1f0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Wed, 25 Jun
 2025 12:53:35 +0000
Received: from DU2PEPF0001E9BF.eurprd03.prod.outlook.com
 (2603:10a6:10:540:cafe::69) by DU6P191CA0018.outlook.office365.com
 (2603:10a6:10:540::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.17 via Frontend Transport; Wed,
 25 Jun 2025 12:53:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DU2PEPF0001E9BF.mail.protection.outlook.com (10.167.8.68) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.14 via
 Frontend Transport; Wed, 25 Jun 2025 12:53:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XGNH7/1He5I4uFUhpgMBX3OZqcLF49Dkj/hVAueozo2YB6Y9KnyvBIBkmByYIcRewkeOhc4fCucoFR+ZHnsbJKpXb4usIhsvNDCsJV/UYFKWyqEQOxFwqRoMKsR++VAWvxKmV3sQ27wbxFtwr1XVSbYYEV6QzgpBkh+74cUlApY1oK73z9raIzX85/Mtbk+Gmtf2QTFMSmkG3bZ8nT8gGlvquhSJnndisiU3ycgQhN/Hs/0iZ8VSw79pvFp/gqsRDFV0opj1jnXT8M5p4TKYpXNo3rqYvnifwq40Vs8vuAdjQVxJeQsvoA0UgdjE4mhvkRG58mdUncto87km9jR2mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rFKBbsxz1C3B9YivlNyUBqXB6NmRbQLfEBUtfT96eTY=;
 b=MB+caPSX6HsU0O3aCBBrCOYj2U3+ixvrbhTOgI7d5fKPTobErEdBEE6uFbuSBPifoKJVFE6ZaHs2n1fuYAzNJTvbxBtb9XJHHE7kWplPDI0MGrEt4HnCj3rnpNGB9al6goJY8x+icZqBdw5C8Db6DRNiM1ITOD1ahTUgDLGJq5+4wAEMZPKrkNaEJ0eU2UessZN0OZEML/hSZ65Mi7K1ZJS4aMwB6Xih7K3tzV4ft/zoIKaKCI5MIDl27Bi0gkFyO2XJWbgfLW5iz+ADQpJG1PB46G1W/a1D1aL28628PgwwR6Yo9IGDxZ8fScEyW7sSmMjpw9nQhQfCA0y/1avhzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rFKBbsxz1C3B9YivlNyUBqXB6NmRbQLfEBUtfT96eTY=;
 b=C2wPjzZ0gQ5ofWDVteJfyexwWCwDGYR2i/XKO0hUEteatUL9/CeoSUzTwkoGuAJAVTzf1ALVIzoDqVAkk+vGkXyFaCpDCNVW4enc4MGuIKn+RphffkSTBU7Yt5TC8l1v0lb9x7dbGexxLOyymMhxkO0eaOzSCD0Ii3qanrQPctQ=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from DB9PR08MB7114.eurprd08.prod.outlook.com (2603:10a6:10:2c7::19)
 by DB9PR08MB7865.eurprd08.prod.outlook.com (2603:10a6:10:39c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.16; Wed, 25 Jun
 2025 12:53:01 +0000
Received: from DB9PR08MB7114.eurprd08.prod.outlook.com
 ([fe80::515:9f73:5a61:fddb]) by DB9PR08MB7114.eurprd08.prod.outlook.com
 ([fe80::515:9f73:5a61:fddb%7]) with mapi id 15.20.8857.026; Wed, 25 Jun 2025
 12:53:01 +0000
Message-ID: <16fff6e9-98f5-4004-9906-feac49f0bbb4@arm.com>
Date: Wed, 25 Jun 2025 18:22:53 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] mm/selftests: Fix virtual_address_range test issues.
To: Donet Tom <donettom@linux.ibm.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Aboorva Devarajan <aboorvad@linux.ibm.com>, akpm@linux-foundation.org,
 Liam.Howlett@oracle.com, shuah@kernel.org, pfalcato@suse.de,
 david@redhat.com, ziy@nvidia.com, baolin.wang@linux.alibaba.com,
 npache@redhat.com, ryan.roberts@arm.com, baohua@kernel.org,
 linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, ritesh.list@gmail.com
References: <159f6939-e7c8-492c-8195-b7e8787a08f1@lucifer.local>
 <f8730d2d-41bf-407a-b44b-6cb9c1e5d4b3@arm.com>
 <79bdd993-0e9c-4d7d-b42c-4b5750eff140@lucifer.local>
 <aaddfd0b-216e-48fe-b48f-35c78eabcf9a@arm.com>
 <8e23c5d3-6ce3-4fe8-b6fe-69658d5d0727@lucifer.local>
 <fc5c8193-2642-49f7-9f2a-00ad33353773@arm.com>
 <c93110a4-19e4-4a1d-b044-6b7f521eaa0d@lucifer.local>
 <815793f1-6800-4b9a-852e-f13d6308f50f@arm.com>
 <2756fa2b-e8bf-4c66-bf9b-c85dc63dfc33@lucifer.local>
 <41d9a70d-9791-4212-af23-5b13d8e4a47d@arm.com>
 <aFPI_blZGhvKSbNJ@li-06431bcc-2712-11b2-a85c-a6fe68df28f9.ibm.com>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <aFPI_blZGhvKSbNJ@li-06431bcc-2712-11b2-a85c-a6fe68df28f9.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0PR01CA0029.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:b8::11) To DB9PR08MB7114.eurprd08.prod.outlook.com
 (2603:10a6:10:2c7::19)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	DB9PR08MB7114:EE_|DB9PR08MB7865:EE_|DU2PEPF0001E9BF:EE_|GV1PR08MB10955:EE_
X-MS-Office365-Filtering-Correlation-Id: 407f453e-2301-46a4-6de5-08ddb3e74bf7
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?L1F2ODYrNCt4bHVnc2toNGUrTkIrcDNYd0hhYm92VVVTcGJ0YUV2bUNZZlhr?=
 =?utf-8?B?TFpUUGNCNlkwTTBkMngvd29BT0RtcDE5THcyNGIvZ0c5aFRyUThTUWphWHZZ?=
 =?utf-8?B?VGVCZlVlNE9CTC9UYnBRbDRVbTJnUFZGVXFPNXc5Y1c1U0k4RFNBWm5HZEkz?=
 =?utf-8?B?dlV5M25qK0dhSVFhUXE2VFpVN1IxZzlGRTVsZlRwZ2h2N3NId21lUFE3QWlt?=
 =?utf-8?B?RTJpdGdpRTFaL2c3cmp0SXBMVkRZMzhYN0cyK1BPTUFtOUhRWUNudlh2NWZV?=
 =?utf-8?B?ZHdjQ0FPdldoWjZIMWlVTUV5Zllnc0YwcUsxd2xFY2NTbWVwenNWaDMvWjB4?=
 =?utf-8?B?RDkzQjBpOGlMQzhlRCttckMweUE2Ukl4bnlHZy9BV3NqdXZRR1dvV2dBcm9t?=
 =?utf-8?B?cjdFWDFQNzY3aWNjWVc2bytvZGNBdmlHZ0l6RFB5N3Q5Q0xmaUVnTGw5eUtL?=
 =?utf-8?B?TC9TMUpzU3YwY2lqcUhBb3R6ck5jbC9GLzJTSDBlTDhIZTh5aGcxanhBZVk5?=
 =?utf-8?B?K0lIYVJGUHlZK1djVklTb1NUdDBjdWtuL0dMTzNRYzczZXVEb0Y3TCt1Ymtu?=
 =?utf-8?B?c28zZEF5enJwTTMxTEN2a0ZSMXVKZUMrZVdDWENxdnhZVEtNTEYrQ1RlN2hR?=
 =?utf-8?B?Z29XbEFGS2NSU2pJcXQxQnFiaVFkTys4RGNBNGwzTFlONWZvSGV0MnV1d01y?=
 =?utf-8?B?cmxxZDJMOUZWQk9QNlJReEFMemVJd3RxdVJ6WXh5UnBQNkhkQWJFeEFNK2FX?=
 =?utf-8?B?TWJMZVBvNWVrZnBJUkh2UVJ3T1lGclhLVkhBajQzUWJCTnJjbGpEdTVTNUdF?=
 =?utf-8?B?dmFhYjMxa0NoN3VxT09IYysySHNjQlkvZ000R01iQjcwT3hyeXhiZjZQclc4?=
 =?utf-8?B?aDJra2FoTlRCSXRPcTA3Q2o5QU9oZ1V0R1NFVU9SbmhLVGlsYXhJbVRqdWdY?=
 =?utf-8?B?aS9yaXhhZExkckxUTndnemIxQXBRZWgwTVpWVTl4dGxpL2pGRm1ZaGFiSXBI?=
 =?utf-8?B?anl6clF3YkY1SFc2SjFlWUh4U2hsN2hEZDIrZXEvckdMN3JRQm9NK1F5NVRI?=
 =?utf-8?B?N1BzN3lqVmYrWmJVQ0hNNSthWHFadGU0dnBCKzNRaGNRNG01UW9hc0tiK1hW?=
 =?utf-8?B?Tkw3T0tjSForMzZFMkJHck9OSzhkUy9ENDJ1ZS9YRmloV0dwRnNXMW1EMFV3?=
 =?utf-8?B?c1UvZGQ2cHRCSTdpNVJEMTlsRmEzd3FKRnNINzMxMU1MaUcxdzAvWmd3V3pP?=
 =?utf-8?B?RHNGMjBJcWt1bzExaHcxK3docXpINE1sVUdHTTdWeVBTUW5JbWxzd1VGeEl6?=
 =?utf-8?B?RENsVlFKTWovcWxkTkcwSS9hWklreHVvOVRlZStaazUweFVYRHZJK3pCS3VH?=
 =?utf-8?B?TDlwbTNlaGxxT3pvdllIbThmTUlVL2ExWktaOWh4a0VqRHdsT3dqWDJGUkhz?=
 =?utf-8?B?THdueURmMkV2dGpYN0tkLzBjcW9SUUFZWFUxK08veUx0OVJxVGpkZ1ZqNXpl?=
 =?utf-8?B?QlpBMVlJYlhlQWp0MTAvTXBuT1FjVFZjU1FSMmkvdUhaTDRHTVptN1Z3Wm5w?=
 =?utf-8?B?UTlMM2JKa2V3YWh3dnpWRmE2alQrMXhDczc2cnltdlZRRUdZanR2dnU3Qk9D?=
 =?utf-8?B?ajJ5RWJUUk9pTldVbDA0b2pQV0tSMVJDTk5URTVTRlJLUWlHaTE4RndvdGFL?=
 =?utf-8?B?V2IxejM3aldPN0QycUl5RFoyNGF3SEFVbi9DYngrOWN2RkhmUFVrRDRtQkpR?=
 =?utf-8?B?M0J1L1JuZTh6ZGhjaUF2UXVrWXFtUGk2bFhScncrV29NdUVFYkpHR3FqWVhk?=
 =?utf-8?B?bWg2NU9BZGZsbUgrSlNBT2E4L2xod083U2NnNExyazhvdFJTZExjOWhaaWl0?=
 =?utf-8?B?M0tGOXEwREpLRlFIdzRSNENKUmNMd25sZTJ0T0xRdVNRSmUrUTZUdC9mZkl4?=
 =?utf-8?Q?hUEGQ2CSDcY=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR08MB7114.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB7865
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU2PEPF0001E9BF.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	e743d619-9b0c-4402-f048-08ddb3e737b2
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|7416014|36860700013|14060799003|35042699022;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bE5ENlo4WXpZOVRGMnFDOVF0UWxCdzVQVktGRjNyenlTZy8yeEJ4MnNrb2JF?=
 =?utf-8?B?d0xzcjFLeklqVFhQbENleW5DZzNkcldlWTdmYnh6L0xEb3FlcjFySmZrTlhu?=
 =?utf-8?B?b3RCQldkRWI2ajJKZHRKTkZ3azN6VDJsdkVxWWVYRmhMVWVnVDdDMitGYU04?=
 =?utf-8?B?ZmhvdUROZ0ROZi8rbU0vSXpKRDNZZ2d3QVMraHZqRk8xb2VXUmhDeVJLcDBv?=
 =?utf-8?B?cmpXY2JOaUV1dXBFNzhTeXBOcFp2RHNsd3FEV2praHZMYmhkemdoNWtxVWds?=
 =?utf-8?B?VkRkM1crbmp6c2I1R0xFclVoS0Nid3JVTXdDdDBCTkpTSk5EczBaQ1hEWWs2?=
 =?utf-8?B?YkhvVVk0UkNvUmZQa1RFbjdXcVNsampYUU93dnNoT0JaeURQZXRaTG5kVzA0?=
 =?utf-8?B?aDRub0p6MFQ1TGtjS1pzbWxicGZoY2tCOGt2dlZJSSswWW42cnptMmE5WllJ?=
 =?utf-8?B?bVVlUkdMYUpWYXRWWmJFak13aGE1QXprUWdQR2k2OVBGVXpic2s1L2JqR0lm?=
 =?utf-8?B?RFlKeUhhNHpmQXlnR3I2WmR6U0RzOCtpeGRTcFhoOE02cXgzdHN6aTlpY0FZ?=
 =?utf-8?B?VytjVXYrd0dWYTg0K2hYUVdQMitkUTdQUndjUVZuNnc3UnE4WXY2VXIxTElG?=
 =?utf-8?B?QW8wcmFGSnVjNHJVaDk2UXMyd3J2VmUyWTdUSkNLajd3S1Y5elF1NHpPOHFj?=
 =?utf-8?B?eDZCZ0hmK0U4Q3VoOGxZeG9IcS9NN1VsNXNZTG8yTEgzTFdlT2Nma0JPMngw?=
 =?utf-8?B?Y0tPU2c2UW5RWDJDc1o5Zm85M3FVM3VPTHhaT3ZzNVIxYU9KV2dIclpYbUtI?=
 =?utf-8?B?YjFYTVhmRnZzL1pQTUNqamc0YTdzUkh4eTBrYkVRQ3J0MFhwcE03OEZTZDB6?=
 =?utf-8?B?MlNMMjI5SElWQ3psdkRxc3hqdnFwSzZ5QXdjdG01V3l6aG8wb2ZyVVh6ZWJl?=
 =?utf-8?B?elNLdmgrQ0pIUjYvMFQ3UmVPK0gzNEo1QmhqQy9UT1poS2tsNnNWcWYvejJV?=
 =?utf-8?B?Zm9Rd0pxSlU4YnJRTXpaMlNqNVl4bkJCZHlTeVdad0Rad2o3aFhKQ0hwL2xK?=
 =?utf-8?B?dktGa3BwQUxyQ0M2K04wZGkvZGtiZm14eTdEY1FtanhYNWhNVFA1NWtabVln?=
 =?utf-8?B?MlFqMTNvTzh0YThQNi9reERNRWQ3eTkrcGN6MEpXbVUrblBrTkFmR2xJTGJx?=
 =?utf-8?B?dnZuOUN4SlhzU3FoTWpFRG9ja1JCN0dKS0pqbEUrbENPbUxzaDd2NXF1WGJS?=
 =?utf-8?B?YktmV20wQXZld3E4MUZXSC9WRXcvL1B6Zlo3a2JEbXpuVG80Ukp5NkFzSzU3?=
 =?utf-8?B?SEZDSkk4UXM1Z0twNU9YbDBFSEEvZHFBMFk5ZnFWdDgvaXRWSzNaQkN5R0c1?=
 =?utf-8?B?NVU5VGZDdzZHSVk1bmEwUjhPSmJ2MlR4Q1lNSEVsSHFwM2pCa2MxSFBQVCtp?=
 =?utf-8?B?VUQwWm80V1VKMThZUzVzazB6dmI4aHYyTUdZQnBmbG1Qbm5UWlc5bkgvU1hN?=
 =?utf-8?B?K1ZXR1RLWWZCb3JzYVJKLzM2OHR3TzdSdnlvQU9ySVNlckhNYmE2M0tybjlj?=
 =?utf-8?B?TUZ1S1RvQTJEZDNBb2c0ai8zZ012Nm81RVlQUk53eHhoS3NRM09HMTdtTXFK?=
 =?utf-8?B?Rk0zcUxzTFhiWE9BeW12K2xPQm91NzY4WVlMUmxtVEdqVnlFZGYrTXVsWGht?=
 =?utf-8?B?cXYweEVnRk9URTdWZUxpOHFIY1d2TkRONnFZdUdMU2hPVUxicGlab0F4OGp1?=
 =?utf-8?B?cHlCT2R6RmhRRFo0aXd4ditIVTJUWHNTSHlLQjlFVnYzZVl4bC9OV2ZjODhi?=
 =?utf-8?B?b09pcXM3N2FsVjJRRjRDOTlzZ0FRNEJPd3JpL2NoQkxad0tHVXBrU0lFRkhH?=
 =?utf-8?B?MGh2RVBoa0hBUWE4a285UHJBQSs4RVJ6OUp2STJzRjZqRFBsS2FSakpnRVpH?=
 =?utf-8?B?RGZlVWp6NFBjd29oelVOajFaUjE0T3lkOC9qYS9zMXFTTjZlS3AwYTFRL0VH?=
 =?utf-8?B?VnFqVzN6dWhmbU9hRENDcC80bnFKSFFaaHAwWFVoVW9lblRYSElKL2h0Yi91?=
 =?utf-8?Q?uTFGed?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(7416014)(36860700013)(14060799003)(35042699022);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2025 12:53:34.8632
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 407f453e-2301-46a4-6de5-08ddb3e74bf7
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF0001E9BF.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB10955


On 19/06/25 1:53 pm, Donet Tom wrote:
> On Wed, Jun 18, 2025 at 08:13:54PM +0530, Dev Jain wrote:
>> On 18/06/25 8:05 pm, Lorenzo Stoakes wrote:
>>> On Wed, Jun 18, 2025 at 07:47:18PM +0530, Dev Jain wrote:
>>>> On 18/06/25 7:37 pm, Lorenzo Stoakes wrote:
>>>>> On Wed, Jun 18, 2025 at 07:28:16PM +0530, Dev Jain wrote:
>>>>>> On 18/06/25 5:27 pm, Lorenzo Stoakes wrote:
>>>>>>> On Wed, Jun 18, 2025 at 05:15:50PM +0530, Dev Jain wrote:
>>>>>>> Are you accounting for sys.max_map_count? If not, then you'll be hitting that
>>>>>>> first.
>>>>>> run_vmtests.sh will run the test in overcommit mode so that won't be an issue.
>>>>> Umm, what? You mean overcommit all mode, and that has no bearing on the max
>>>>> mapping count check.
>>>>>
>>>>> In do_mmap():
>>>>>
>>>>> 	/* Too many mappings? */
>>>>> 	if (mm->map_count > sysctl_max_map_count)
>>>>> 		return -ENOMEM;
>>>>>
>>>>>
>>>>> As well as numerous other checks in mm/vma.c.
>>>> Ah sorry, didn't look at the code properly just assumed that overcommit_always meant overriding
>>>> this.
>>> No problem! It's hard to be aware of everything in mm :)
>>>
>>>>> I'm not sure why an overcommit toggle is even necessary when you could use
>>>>> MAP_NORESERVE or simply map PROT_NONE to avoid the OVERCOMMIT_GUESS limits?
>>>>>
>>>>> I'm pretty confused as to what this test is really achieving honestly. This
>>>>> isn't a useful way of asserting mmap() behaviour as far as I can tell.
>>>> Well, seems like a useful way to me at least : ) Not sure if you are in the mood
>>>> to discuss that but if you'd like me to explain from start to end what the test
>>>> is doing, I can do that : )
>>>>
>>> I just don't have time right now, I guess I'll have to come back to it
>>> later... it's not the end of the world for it to be iffy in my view as long as
>>> it passes, but it might just not be of great value.
>>>
>>> Philosophically I'd rather we didn't assert internal implementation details like
>>> where we place mappings in userland memory. At no point do we promise to not
>>> leave larger gaps if we feel like it :)
>> You have a fair point. Anyhow a debate for another day.
>>
>>> I'm guessing, reading more, the _real_ test here is some mathematical assertion
>>> about layout from HIGH_ADDR_SHIFT -> end of address space when using hints.
>>>
>>> But again I'm not sure that achieves much and again also is asserting internal
>>> implementation details.
>>>
>>> Correct behaviour of this kind of thing probably better belongs to tests in the
>>> userland VMA testing I'd say.
>>>
>>> Sorry I don't mean to do down work you've done before, just giving an honest
>>> technical appraisal!
>> Nah, it will be rather hilarious to see it all go down the drain xD
>>
>>> Anyway don't let this block work to fix the test if it's failing. We can revisit
>>> this later.
>> Sure. @Aboorva and Donet, I still believe that the correct approach is to elide
>> the gap check at the crossing boundary. What do you think?
>>
> One problem I am seeing with this approach is that, since the hint address
> is generated randomly, the VMAs are also being created at randomly based on
> the hint address.So, for the VMAs created at high addresses, we cannot guarantee
> that the gaps between them will be aligned to MAP_CHUNK_SIZE.
>
> High address VMAs
> -----------------
> 1000000000000-1000040000000 r--p 00000000 00:00 0
> 2000000000000-2000040000000 r--p 00000000 00:00 0
> 4000000000000-4000040000000 r--p 00000000 00:00 0
> 8000000000000-8000040000000 r--p 00000000 00:00 0
> e80009d260000-fffff9d260000 r--p 00000000 00:00 0
>
> I have a different approach to solve this issue.
>
>  From 0 to 128TB, we map memory directly without using any hint. For the range above
> 256TB up to 512TB, we perform the mapping using hint addresses. In the current test,
> we use random hint addresses, but I have modified it to generate hint addresses linearly
> starting from 128TB.
>
> With this change:
>
> The 0–128TB range is mapped without hints and verified accordingly.
>
> The 128TB–512TB range is mapped using linear hint addresses and then verified.
>
> Below are the VMAs obtained with this approach:
>
> 10000000-10010000 r-xp 00000000 fd:05 135019531
> 10010000-10020000 r--p 00000000 fd:05 135019531
> 10020000-10030000 rw-p 00010000 fd:05 135019531
> 20000000-10020000000 r--p 00000000 00:00 0
> 10020800000-10020830000 rw-p 00000000 00:00 0
> 1004bcf0000-1004c000000 rw-p 00000000 00:00 0
> 1004c000000-7fff8c000000 r--p 00000000 00:00 0
> 7fff8c130000-7fff8c360000 r-xp 00000000 fd:00 792355
> 7fff8c360000-7fff8c370000 r--p 00230000 fd:00 792355
> 7fff8c370000-7fff8c380000 rw-p 00240000 fd:00 792355
> 7fff8c380000-7fff8c460000 r-xp 00000000 fd:00 792358
> 7fff8c460000-7fff8c470000 r--p 000d0000 fd:00 792358
> 7fff8c470000-7fff8c480000 rw-p 000e0000 fd:00 792358
> 7fff8c490000-7fff8c4d0000 r--p 00000000 00:00 0
> 7fff8c4d0000-7fff8c4e0000 r-xp 00000000 00:00 0
> 7fff8c4e0000-7fff8c530000 r-xp 00000000 fd:00 792351
> 7fff8c530000-7fff8c540000 r--p 00040000 fd:00 792351
> 7fff8c540000-7fff8c550000 rw-p 00050000 fd:00 792351
> 7fff8d000000-7fffcd000000 r--p 00000000 00:00 0
> 7fffe9c80000-7fffe9d90000 rw-p 00000000 00:00 0
> 800000000000-2000000000000 r--p 00000000 00:00 0    -> High Address (128TB to 512TB)
>
> diff --git a/tools/testing/selftests/mm/virtual_address_range.c b/tools/testing/selftests/mm/virtual_address_range.c
> index 4c4c35eac15e..0be008cba4b0 100644
> --- a/tools/testing/selftests/mm/virtual_address_range.c
> +++ b/tools/testing/selftests/mm/virtual_address_range.c
> @@ -56,21 +56,21 @@
>   
>   #ifdef __aarch64__
>   #define HIGH_ADDR_MARK  ADDR_MARK_256TB
> -#define HIGH_ADDR_SHIFT 49
> +#define HIGH_ADDR_SHIFT 48
>   #define NR_CHUNKS_LOW   NR_CHUNKS_256TB
>   #define NR_CHUNKS_HIGH  NR_CHUNKS_3840TB
>   #else
>   #define HIGH_ADDR_MARK  ADDR_MARK_128TB
> -#define HIGH_ADDR_SHIFT 48
> +#define HIGH_ADDR_SHIFT 47
>   #define NR_CHUNKS_LOW   NR_CHUNKS_128TB
>   #define NR_CHUNKS_HIGH  NR_CHUNKS_384TB
>   #endif
>   
> -static char *hint_addr(void)
> +static char *hint_addr(int hint)
>   {
> -       int bits = HIGH_ADDR_SHIFT + rand() % (63 - HIGH_ADDR_SHIFT);
> +       unsigned long addr = ((1UL << HIGH_ADDR_SHIFT) + (hint * MAP_CHUNK_SIZE));
>   
> -       return (char *) (1UL << bits);
> +       return (char *) (addr);
>   }
>   
>   static void validate_addr(char *ptr, int high_addr)
> @@ -217,7 +217,7 @@ int main(int argc, char *argv[])
>          }
>   
>          for (i = 0; i < NR_CHUNKS_HIGH; i++) {
> -               hint = hint_addr();
> +               hint = hint_addr(i);
>                  hptr[i] = mmap(hint, MAP_CHUNK_SIZE, PROT_READ,
>                                 MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);

Ah you sent it here, thanks. This is fine really, but the mystery is
something else.


>
>
> Can we fix it this way?
>   

