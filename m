Return-Path: <linux-kselftest+bounces-35742-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C53F1AE8029
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Jun 2025 12:50:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5CF9D7B4321
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Jun 2025 10:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE4B9291C01;
	Wed, 25 Jun 2025 10:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="NSJcZd2k";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="NSJcZd2k"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010016.outbound.protection.outlook.com [52.101.69.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A0C3595D;
	Wed, 25 Jun 2025 10:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.16
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750848390; cv=fail; b=ZWYbeuFmN4t7b9z+Dmc2XwOcP6VXyHo5GjpiR5Fm/TjriFGnDohPD7aYWF06sAjtJLXhTbdHzTAvHtqG4bZSy37e2YYkLxKPQFv1cAarDYn9I4Q22I3O5Y2RCyPIHZAHVwK4rNvH7BHDDq3xPBVM8txFdxfsVMXa8YtDXWubl+o=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750848390; c=relaxed/simple;
	bh=VNjF2qGFgXuOpThdzKjVVjPLw4ryBqZd/HyMXQulcbY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Bf8IUN8dOVY5xa9elIWr9CaTAiSt6F8deboNH+wlOnRsdatwPjW9YFfUBYNYbEira8ZGTt5JdtOWBbY9lCbNFySGL8DNcdoW/18CxKlmAibTJqejQneCtPghKIY8l0uStZAwkcPS8cro9El+OgcjL3gg6i2se3MGTWxxaEhNKuI=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=NSJcZd2k; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=NSJcZd2k; arc=fail smtp.client-ip=52.101.69.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=prEbtow7NQVK8915TI3U4bHs3lZw2iwVqtIv9W4s4m0Rj+O0XbC8mcz38Zr1XRrRZUVPjFRe+VaKf4l0G2vjNFx6TZFt+8q4n4P4gByS6o0WCij0dxZ02hGeRHP0EtrSJCZYcx8GeWZM+XMIuI2sGXwu0iVltygnNUGO2qbjZE2rx3aGY2X4rQ3e/CxYHkyTGemWKF5gI1hP5642Z7DA1oYQoeB1YpA+y6wWdjPubv2sCakg+aOhM17G5miTdc+H74BF4oljurfaHftHUPWaGCj4hcmocDpUJNZsIBF2anFI0RtqXoSDoM2arr/dpA1sKlGPODzFONLerMzlqkKMrQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VAAWMQllxOQz6vwClo32aJt2xudUT70UKyNs/92ogP8=;
 b=i9ZxGRu2DwoE+a4SrS6CucyP5fVfyqJUl9p4pSS/l99l2Qw8rdysnk6u0LD8gNXgPTjkaAtb36wZxPEXnTJlkJ13beQaSAmhiM3V2npWIP3vV9wb+yhI3gAa1kSRgb32lTIFNDvAwFLu39rIOREsReVKrzc9bVSrHgYgvjG2pqP45+YWST/BCL/bMy67jQjgTevC6x+jxJhIQcUSkK/J93Yq/hz3++gofFSo7C3iRjQ8SZhBZNc1E2aZ7hzVNBi+nxkksPqZ4zHxf9pgaFHd6y3G9kx6/HEnhcWP0ypYTKnrlSSJQSj7Fab+5JSuehJgzZd/v3P4qyZMZ4/esUn31w==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=linux.ibm.com smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VAAWMQllxOQz6vwClo32aJt2xudUT70UKyNs/92ogP8=;
 b=NSJcZd2kH98okGYbJtXJhviBPsAK44NVVJJdIbJCG5pJ8lcG0LymldjX8S/0CC3+qILRw1+Bo+hUmyq6Eu51V4xHoqc5fI1K0vXpOQUEp3BG/IkpIUmA3dsnsoZhGZtAvFpHjkQWY49Z9OJNeQQoJH7AaNqm4D0mKMsJ+tPGkPk=
Received: from AM0PR02CA0119.eurprd02.prod.outlook.com (2603:10a6:20b:28c::16)
 by AS2PR08MB8902.eurprd08.prod.outlook.com (2603:10a6:20b:5f6::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Wed, 25 Jun
 2025 10:46:19 +0000
Received: from AM1PEPF000252DF.eurprd07.prod.outlook.com
 (2603:10a6:20b:28c:cafe::12) by AM0PR02CA0119.outlook.office365.com
 (2603:10a6:20b:28c::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.17 via Frontend Transport; Wed,
 25 Jun 2025 10:46:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AM1PEPF000252DF.mail.protection.outlook.com (10.167.16.57) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.14
 via Frontend Transport; Wed, 25 Jun 2025 10:46:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GbXLzZ78Zp/94rLo6eoTigtVEEaJ1qVxACh39WP0SHf34JDrox8GtLPVh3u8Zz60jY6XykKbD2SPlsRaORNF5nn+oZQAqwDlVUyH/Yxt7o+FNgWVjjiafQUXQGUkf8gdS/MXqCCXl/qWm7nxpokI6rWtpLAQ/29QyWj9yzJ6OL6dvvmQ33Z19nAAo87hzgUvv7NB/dC3tP5tEAfLlY8GdQ4DoJpjJTxjWwtwO8OLqfS4n0BKMJ2hfa9h3+0+47NraKikuJox91KDyc8X/pjRmU3MCZQioSnYxT4cXHrv6Q2geVydscP6nKmH7tBZJdchxSn+x4gM+x0h7xKZ13ziFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VAAWMQllxOQz6vwClo32aJt2xudUT70UKyNs/92ogP8=;
 b=YXCKXQ+2P5FZHgHNSOtkeQ/ww3wHZVrmO9x9B1roEUV2MTNaurHSf8Rga8RBrB7KCKlQSGb2Z0K8ZWcDEInq1gC9TzQfPoLM64fE0H1mK8QLLPEcMXO+gptwHhIcLE3CBH92TV5uRY3JlNci3JcdRTQV8++8GHmih2a+V2Yw9sFMqFt464n/TuRn7b0rFoExCv5P7y+qT3V7folZJmY+Cg65aICol9lROQrWG2RLzcDUlj+PcbrKr7fXHNKNNF4fYsssRg5gZmFy49vY9qR1I+Hgj9/YPjp3k7f8ZXU/i/Hjnow5IAa9RU8fkzIRulCkxSSTvmEQ8Ln582Ki4vYSfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VAAWMQllxOQz6vwClo32aJt2xudUT70UKyNs/92ogP8=;
 b=NSJcZd2kH98okGYbJtXJhviBPsAK44NVVJJdIbJCG5pJ8lcG0LymldjX8S/0CC3+qILRw1+Bo+hUmyq6Eu51V4xHoqc5fI1K0vXpOQUEp3BG/IkpIUmA3dsnsoZhGZtAvFpHjkQWY49Z9OJNeQQoJH7AaNqm4D0mKMsJ+tPGkPk=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from DB9PR08MB7114.eurprd08.prod.outlook.com (2603:10a6:10:2c7::19)
 by PA4PR08MB5951.eurprd08.prod.outlook.com (2603:10a6:102:ee::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.27; Wed, 25 Jun
 2025 10:45:46 +0000
Received: from DB9PR08MB7114.eurprd08.prod.outlook.com
 ([fe80::515:9f73:5a61:fddb]) by DB9PR08MB7114.eurprd08.prod.outlook.com
 ([fe80::515:9f73:5a61:fddb%7]) with mapi id 15.20.8857.026; Wed, 25 Jun 2025
 10:45:46 +0000
Message-ID: <0d89d71e-66cc-40da-8115-18124bcddb5c@arm.com>
Date: Wed, 25 Jun 2025 16:15:38 +0530
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
References: <c93110a4-19e4-4a1d-b044-6b7f521eaa0d@lucifer.local>
 <815793f1-6800-4b9a-852e-f13d6308f50f@arm.com>
 <2756fa2b-e8bf-4c66-bf9b-c85dc63dfc33@lucifer.local>
 <41d9a70d-9791-4212-af23-5b13d8e4a47d@arm.com>
 <aFPI_blZGhvKSbNJ@li-06431bcc-2712-11b2-a85c-a6fe68df28f9.ibm.com>
 <546d7aa5-9ea3-4fce-a604-b1676a61d6cd@arm.com>
 <aFbyFMjVs9F3KMex@li-06431bcc-2712-11b2-a85c-a6fe68df28f9.ibm.com>
 <2fc32719-1e38-4bf0-8ec5-5bcb452d939f@arm.com>
 <aFmPliw773p1VvAY@li-06431bcc-2712-11b2-a85c-a6fe68df28f9.ibm.com>
 <673c9442-7d69-408b-a2c4-2baa696a7e86@arm.com>
 <aFvDNPZWs2CA_MoU@li-06431bcc-2712-11b2-a85c-a6fe68df28f9.ibm.com>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <aFvDNPZWs2CA_MoU@li-06431bcc-2712-11b2-a85c-a6fe68df28f9.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0PR01CA0032.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:b8::19) To AM9PR08MB7120.eurprd08.prod.outlook.com
 (2603:10a6:20b:3dc::22)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	DB9PR08MB7114:EE_|PA4PR08MB5951:EE_|AM1PEPF000252DF:EE_|AS2PR08MB8902:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c6c2d8b-c2a4-45cb-7841-08ddb3d58494
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?cVN3RTVFQWlCT09zRUJDUjFyakswSkZlYlBDcUN3Qk1weUJibUhaVG9MRzhl?=
 =?utf-8?B?U1MvOEZ4aTBWeko1VFJBZHhKYlNrbU83YXZUV3YxSWEvWEp5Y1BaWFJsWG5O?=
 =?utf-8?B?Y0VGY2NKYWR5VkIzSHJRbTZZTlNQK2tnR3ovVXJISmd3cGdxcDYyUTYyb0Ju?=
 =?utf-8?B?Si9Pbjk1YWVtblZiZ0pSTEZMT2xxeGtrbTYzSFRWQ1BsUFRnRGpPYk53WVpC?=
 =?utf-8?B?cm1YMklaaVFnMFVxWUJCd3libk5IK0lyTytzdVUxRnNVSlFodlF2RDhmeFlE?=
 =?utf-8?B?NDlFVXdIU1RCaFZvc1NrK2c5ellaU3ZxbVBSVVBveG1uSmxLT0xBN1R6SmFC?=
 =?utf-8?B?QW13NFd4aUxWMlJCaWcyYXhreGhKSGVPRXdSRCtGOE1qUjRTMVZ3ZDlrcEs3?=
 =?utf-8?B?TGQ1bXZhb3RzdUNna045Q2tPWEc1YklpMk5zdTJGK2oxTW93U3JKWDR2ZFox?=
 =?utf-8?B?RnpGeTZqQUE3YXovQTl5SjA2SWxxVDU5M0hjc3JFdmZMMHRCaXkyWmtQSVZ6?=
 =?utf-8?B?Qzg3cGdwMzJvbUE2dHhId0dLU3JjZVBhK0dzYnZNcVNheGRQb3J6OVh0bjQw?=
 =?utf-8?B?L05oeU52bGZSWDRhaWxhRmtQNlhDejVlVTJXOXFERklEYThLbDFaQzFOTW9Q?=
 =?utf-8?B?bWFJMkNjcjA5R1JiYnFuZ2JqdVVTVVlGcElpMy9GUHpMOUNxSGJTQVpQTGRM?=
 =?utf-8?B?NVI2WkJraGVyUm5tbGZGNjZqcTZBZnl5NzA2UUJHTXM4ZUhNbElpVnNwSit1?=
 =?utf-8?B?eE80Z25sa1BMdHlmalptcEJISlkxVmtOdWtmR0lCMkduL1I0UkN0WkZ5RHQr?=
 =?utf-8?B?Sm50c3hLYTFzT1JtVzY1UzgwQXpMVjd6UWlGRjU4eHBucW1QMzMxUmxGUXJW?=
 =?utf-8?B?QUw1UE8xQlhyTFhvczd3V3pxMjF4ZmJWOVR5a3FGOTQ2a1QveFZxWnlnbGcy?=
 =?utf-8?B?WUZ2eUlad2lLbzEyMUVpYjNqMUNTTGx2UzhQZjV0MDRUY2N2TUdwSk1qNW13?=
 =?utf-8?B?Q3JLR014YU1iVTRBa1ZwaS9ONGdzcU9QTFc0OGVIR3B5STQ3aURpSkJueXJI?=
 =?utf-8?B?VStpOWsvQ0VuUDB4UWRQWmtlcmdndks0dm92U3VQZWk2TTlEbUdIT1ZBeHFD?=
 =?utf-8?B?YkRVYmhNbm4vTEJ6VG1hdXRMU0xsWmVhN0dyYXJpTzYzQnpJNjMrSi9jeC8z?=
 =?utf-8?B?dzlLSlBiYUJIaU5YV25ONDVYVFdtSVdwZVBwU2w5WW1aN2NhRjE3MU9ZcVl5?=
 =?utf-8?B?N2IrZ0JkNkthWG42SEZnWkhRbllORVdaaDNyNW9uZktGWEFhNzJrL1RIWXFT?=
 =?utf-8?B?RkhiUWovcW1wV2ZJYnZoYUNsQldTbTdzMDZoSXlmYVBXZVZTQmxMQmN6ZkFq?=
 =?utf-8?B?YjVwaWgxbmJ5Ritoc0hlSENDeVh3RWF2RWwxNWkrekF2d3Rtb1RvYkZuMkM4?=
 =?utf-8?B?YkdZRTg0L3lDd2xBNDFHL00ycTNGcmY0dXFCNmNvRS9hZG1MM2VaMXM3VGd3?=
 =?utf-8?B?QURSY2lWMFVDYklLbWF2RkY2ZWV4L2hxRGdIZU9rcTkweklZZW56enZwVlhz?=
 =?utf-8?B?cWdBZi9XRUE4UnhLMm9jZkNFY0RyazZUSUc5VE5qNVp3bklFNmpxbjJJajFL?=
 =?utf-8?B?SE1BWU1WMnJ6dElOMEg0bGFreVZlOVgwbXRkWExFQjJTWDRmeVcwcUxtMG5P?=
 =?utf-8?B?cmZJREgwbDJhRGFpWlA2bmtrcGhjUHpIVVVvSlV0TitpMUpHM3doNUNmYUFC?=
 =?utf-8?B?Wll6VHpoejNGZ1JJM21VRGIvT1NaZmkyRmJUTzBxVytWVmprT2RBbnBSUVNV?=
 =?utf-8?B?V2g1cjRmN2VsR1NzUlpPVTZmM1lLRmx5TXo4UXdXWExONCsrVmRkRlJQT0h2?=
 =?utf-8?B?WE95MXFXeVF0V2d1R2YvYkh4TXM2K1NIcStLZFFvY3FkMzYyS1FNUzlTM0lJ?=
 =?utf-8?Q?tsHxvkUqpnk=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR08MB7114.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB5951
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM1PEPF000252DF.eurprd07.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	d2fd48aa-1dd5-4297-32a3-08ddb3d5706e
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|35042699022|14060799003|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V0U0bnk1bzJBN1E5NzRIcVhWb3Z3cGVyZVlWUjFoQXBqay9iMCtLWWZscEhL?=
 =?utf-8?B?bk1SajNpRXVqR21XeUw3Wlc4d084TnJWTXZoejhkeXRGNFpkbXhFcVlmQzZQ?=
 =?utf-8?B?T3NKVGxyQllzY3o1Ky9PYTZWOFA4SzM4R2xaTy9zWU0vZWZYSjc4Z3BCbTB1?=
 =?utf-8?B?M3N5WldLOGFvNjVWeENaZFh2QXNodFE5aTNLU3d3Z1Y4MzUyWEtMZzZtaFV0?=
 =?utf-8?B?VCtCWks0MVBYc21PU3cxS3BDY3VYVXdYVHlqOFJkemlqMmgxaitGQTRxV1Bn?=
 =?utf-8?B?SjVybGpGUVZpL1hYQTVXUWRFNmdJcjJzQjM3d0hXWHJZQ3p5MWZnMURLd2RP?=
 =?utf-8?B?MGdRTGtDYVVDNllROGdhOUt0T2o3d3NCOCtUSEdwcmNnc1g1Tk51MjJnQ3gv?=
 =?utf-8?B?bHhybWtBaXJsWmVQSy8zMWJ0ZzRMSmJnMlVmeEdaczBkWUJ1VVRkeWlVOW9Y?=
 =?utf-8?B?UUVaL2VLY2Vud2JBb204T2JVNUFtQmpBa0VyUEdIWWpOWm5OQ3pFNmFleE00?=
 =?utf-8?B?REYyQVhjQXViTklVbXZNNTVraE1SMkRuRTVxWmNrZm5MdTZsTjVDUkE4S3FZ?=
 =?utf-8?B?QlBuaHk3NVZZMWlPUlpGMUZPeG5lbUY3NlN3VDhKNnpBcS9wN2doQVRCWEZ3?=
 =?utf-8?B?dVEwM1RUKzE1L2hlSjJHTVI3dXlKbTR4eWdSR09rb1JRUmQwenRkRklyaWNh?=
 =?utf-8?B?dzBnVC9DcTlYTXJSbDQxN3hCVTdudll5THhjaUwvTFd2dzdSTHVVeEExeU9W?=
 =?utf-8?B?cDVlM0l3eG9WSEhuZjFlb0JWM0ltby9jZ2VQOTVsRkkvVTlSd1dGTm16blN1?=
 =?utf-8?B?Mis4bXFqL1o2R3NJZWpyQjZhd1V1cmI5ZnJSb1FpNFdkUCtvT25wVnY3UEU3?=
 =?utf-8?B?eFRkbkdEYjh6azdyakQrT29WK3ZBbEtpZHo0RS80ano4VkpqSG90S3VUWE56?=
 =?utf-8?B?OE9EVTg3d011OCsxKy9zVmxHeTc1aWVyYkp1S0Jocm5TUTJVWStPODluN0l6?=
 =?utf-8?B?SEhvRzFVUEc4OGhPSGN2K3RtYXY3d3I3TXdERlR5S2lVR0x0ZjAzZmdtMXd2?=
 =?utf-8?B?K1l2OTBEOHBFa2FUeU9Oa2RKdTAxbEZ5cThYZDhjelEyUkNMOEdrTnVuU1RO?=
 =?utf-8?B?cHIxaWJDL0Z2UWhqd25uVGNYaHhDQVh1TzY0bC9UR3NRY2dkN1ZueWpqeExk?=
 =?utf-8?B?RHB3a1pTeE1EdWhmaWN4UnR5bjl0dFlGOW9jMExUQXF2YU5Sa2J4TE5vcE52?=
 =?utf-8?B?cy8xNU02ZmxNWmR5R0xqOUhLK0hMd1JVR09KS0VBZmxldjl0eDhzeWhQMEk4?=
 =?utf-8?B?bFVlQjNIVUdZdjJVbzI1M2VDcnVTTFZYYWlIQXQ4ZjUyeTJwQklsM0hwNTha?=
 =?utf-8?B?TFpRZzlaQTFQUXdBMUx5ZGowaXpNS0Z1Sk9SR2dYKzhQM0xLdE13Qk1IZDVT?=
 =?utf-8?B?c2NGc080MzJvV0VTeU5rczZtU3FoZE9mdllLNzFOc2pGSnVzcUxCN2tBdUl1?=
 =?utf-8?B?dTZWRWk3Wm52VG9lSitpUlZiemlLbDAzVWVJcXUzaFVLNXRpUnBUT3M0R01m?=
 =?utf-8?B?ZWY2VjBNTzdveHpPTXpRUHhRYUxzZWRTOE1pN2haTUYxQU42N1dYdE9ocEVX?=
 =?utf-8?B?U0oxb3QwRHZiZEZWVG12ZXdJREpVNVgzOG1KVDV2eEh6UDAzTnFMKzlzRnBl?=
 =?utf-8?B?VzgxL0hyTU1JbGNCY29QdFF1REwvS29lbDdNSjZTTFhobjRXMG1wK09EekhR?=
 =?utf-8?B?L2NSN0pRcEFFdEtHL2ltcDlDek5IUTZ3ZXFIL01mOE96WjFpbXdIMks0d09z?=
 =?utf-8?B?NGRsODRrVzVXZk9kRFdWYXFJWFFFSGxhYzY0M2d4dzJIaW4zSU00TnozTFV0?=
 =?utf-8?B?cDBYWXZVMUJGTkFBcndVT0RwaFc5TE4vT1VwSnZyNzh5blBIaWdjSTloeGZX?=
 =?utf-8?B?RVVxRUVSQ1lCczJYWTUvdVp2azhFZlVUTC93Snp5S2NzWVBLTVJVbmFPUGcy?=
 =?utf-8?B?cHJPYkdwOVQ1eXV2dnFxTlg1amZWa2d1Uis4TUJ1N1dJbnZUREN6djE3ZXRu?=
 =?utf-8?Q?P1J4cZ?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(35042699022)(14060799003)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2025 10:46:18.9189
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c6c2d8b-c2a4-45cb-7841-08ddb3d58494
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM1PEPF000252DF.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB8902


On 25/06/25 3:06 pm, Donet Tom wrote:
> eOn Tue, Jun 24, 2025 at 11:45:09AM +0530, Dev Jain wrote:
>> On 23/06/25 11:02 pm, Donet Tom wrote:
>>> On Mon, Jun 23, 2025 at 10:23:02AM +0530, Dev Jain wrote:
>>>> On 21/06/25 11:25 pm, Donet Tom wrote:
>>>>> On Fri, Jun 20, 2025 at 08:15:25PM +0530, Dev Jain wrote:
>>>>>> On 19/06/25 1:53 pm, Donet Tom wrote:
>>>>>>> On Wed, Jun 18, 2025 at 08:13:54PM +0530, Dev Jain wrote:
>>>>>>>> On 18/06/25 8:05 pm, Lorenzo Stoakes wrote:
>>>>>>>>> On Wed, Jun 18, 2025 at 07:47:18PM +0530, Dev Jain wrote:
>>>>>>>>>> On 18/06/25 7:37 pm, Lorenzo Stoakes wrote:
>>>>>>>>>>> On Wed, Jun 18, 2025 at 07:28:16PM +0530, Dev Jain wrote:
>>>>>>>>>>>> On 18/06/25 5:27 pm, Lorenzo Stoakes wrote:
>>>>>>>>>>>>> On Wed, Jun 18, 2025 at 05:15:50PM +0530, Dev Jain wrote:
>>>>>>>>>>>>> Are you accounting for sys.max_map_count? If not, then you'll be hitting that
>>>>>>>>>>>>> first.
>>>>>>>>>>>> run_vmtests.sh will run the test in overcommit mode so that won't be an issue.
>>>>>>>>>>> Umm, what? You mean overcommit all mode, and that has no bearing on the max
>>>>>>>>>>> mapping count check.
>>>>>>>>>>>
>>>>>>>>>>> In do_mmap():
>>>>>>>>>>>
>>>>>>>>>>> 	/* Too many mappings? */
>>>>>>>>>>> 	if (mm->map_count > sysctl_max_map_count)
>>>>>>>>>>> 		return -ENOMEM;
>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> As well as numerous other checks in mm/vma.c.
>>>>>>>>>> Ah sorry, didn't look at the code properly just assumed that overcommit_always meant overriding
>>>>>>>>>> this.
>>>>>>>>> No problem! It's hard to be aware of everything in mm :)
>>>>>>>>>
>>>>>>>>>>> I'm not sure why an overcommit toggle is even necessary when you could use
>>>>>>>>>>> MAP_NORESERVE or simply map PROT_NONE to avoid the OVERCOMMIT_GUESS limits?
>>>>>>>>>>>
>>>>>>>>>>> I'm pretty confused as to what this test is really achieving honestly. This
>>>>>>>>>>> isn't a useful way of asserting mmap() behaviour as far as I can tell.
>>>>>>>>>> Well, seems like a useful way to me at least : ) Not sure if you are in the mood
>>>>>>>>>> to discuss that but if you'd like me to explain from start to end what the test
>>>>>>>>>> is doing, I can do that : )
>>>>>>>>>>
>>>>>>>>> I just don't have time right now, I guess I'll have to come back to it
>>>>>>>>> later... it's not the end of the world for it to be iffy in my view as long as
>>>>>>>>> it passes, but it might just not be of great value.
>>>>>>>>>
>>>>>>>>> Philosophically I'd rather we didn't assert internal implementation details like
>>>>>>>>> where we place mappings in userland memory. At no point do we promise to not
>>>>>>>>> leave larger gaps if we feel like it :)
>>>>>>>> You have a fair point. Anyhow a debate for another day.
>>>>>>>>
>>>>>>>>> I'm guessing, reading more, the _real_ test here is some mathematical assertion
>>>>>>>>> about layout from HIGH_ADDR_SHIFT -> end of address space when using hints.
>>>>>>>>>
>>>>>>>>> But again I'm not sure that achieves much and again also is asserting internal
>>>>>>>>> implementation details.
>>>>>>>>>
>>>>>>>>> Correct behaviour of this kind of thing probably better belongs to tests in the
>>>>>>>>> userland VMA testing I'd say.
>>>>>>>>>
>>>>>>>>> Sorry I don't mean to do down work you've done before, just giving an honest
>>>>>>>>> technical appraisal!
>>>>>>>> Nah, it will be rather hilarious to see it all go down the drain xD
>>>>>>>>
>>>>>>>>> Anyway don't let this block work to fix the test if it's failing. We can revisit
>>>>>>>>> this later.
>>>>>>>> Sure. @Aboorva and Donet, I still believe that the correct approach is to elide
>>>>>>>> the gap check at the crossing boundary. What do you think?
>>>>>>>>
>>>>>>> One problem I am seeing with this approach is that, since the hint address
>>>>>>> is generated randomly, the VMAs are also being created at randomly based on
>>>>>>> the hint address.So, for the VMAs created at high addresses, we cannot guarantee
>>>>>>> that the gaps between them will be aligned to MAP_CHUNK_SIZE.
>>>>>>>
>>>>>>> High address VMAs
>>>>>>> -----------------
>>>>>>> 1000000000000-1000040000000 r--p 00000000 00:00 0
>>>>>>> 2000000000000-2000040000000 r--p 00000000 00:00 0
>>>>>>> 4000000000000-4000040000000 r--p 00000000 00:00 0
>>>>>>> 8000000000000-8000040000000 r--p 00000000 00:00 0
>>>>>>> e80009d260000-fffff9d260000 r--p 00000000 00:00 0
>>>>>>>
>>>>>>> I have a different approach to solve this issue.
>>>>>> It is really weird that such a large amount of VA space
>>>>>> is left between the two VMAs yet mmap is failing.
>>>>>>
>>>>>>
>>>>>>
>>>>>> Can you please do the following:
>>>>>> set /proc/sys/vm/max_map_count to the highest value possible.
>>>>>> If running without run_vmtests.sh, set /proc/sys/vm/overcommit_memory to 1.
>>>>>> In validate_complete_va_space:
>>>>>>
>>>>>> if (start_addr >= HIGH_ADDR_MARK && found == false) {
>>>>>> 	found = true;
>>>>>> 	continue;
>>>>>> }
>>>>> Thanks Dev for the suggestion. I set max_map_count and set overcommit
>>>>> memory to 1, added this code change as well, and then tried. Still, the
>>>>> test is failing
>>>>>
>>>>>> where found is initialized to false. This will skip the check
>>>>>> for the boundary.
>>>>>>
>>>>>> After this can you tell whether the test is still failing.
>>>>>>
>>>>>> Also can you give me the complete output of proc/pid/maps
>>>>>> after putting a sleep at the end of the test.
>>>>>>
>>>>> on powerpc support DEFAULT_MAP_WINDOW is 128TB and with
>>>>> total address space size is 4PB With hint it can map upto
>>>>> 4PB. Since the hint addres is random in this test random hing VMAs
>>>>> are getting created. IIUC this is expected only.
>>>>>
>>>>>
>>>>> 10000000-10010000 r-xp 00000000 fd:05 134226638                          /home/donet/linux/tools/testing/selftests/mm/virtual_address_range
>>>>> 10010000-10020000 r--p 00000000 fd:05 134226638                          /home/donet/linux/tools/testing/selftests/mm/virtual_address_range
>>>>> 10020000-10030000 rw-p 00010000 fd:05 134226638                          /home/donet/linux/tools/testing/selftests/mm/virtual_address_range
>>>>> 30000000-10030000000 r--p 00000000 00:00 0                               [anon:virtual_address_range]
>>>>> 10030770000-100307a0000 rw-p 00000000 00:00 0                            [heap]
>>>>> 1004f000000-7fff8f000000 r--p 00000000 00:00 0                           [anon:virtual_address_range]
>>>>> 7fff8faf0000-7fff8fe00000 rw-p 00000000 00:00 0
>>>>> 7fff8fe00000-7fff90030000 r-xp 00000000 fd:00 792355                     /usr/lib64/libc.so.6
>>>>> 7fff90030000-7fff90040000 r--p 00230000 fd:00 792355                     /usr/lib64/libc.so.6
>>>>> 7fff90040000-7fff90050000 rw-p 00240000 fd:00 792355                     /usr/lib64/libc.so.6
>>>>> 7fff90050000-7fff90130000 r-xp 00000000 fd:00 792358                     /usr/lib64/libm.so.6
>>>>> 7fff90130000-7fff90140000 r--p 000d0000 fd:00 792358                     /usr/lib64/libm.so.6
>>>>> 7fff90140000-7fff90150000 rw-p 000e0000 fd:00 792358                     /usr/lib64/libm.so.6
>>>>> 7fff90160000-7fff901a0000 r--p 00000000 00:00 0                          [vvar]
>>>>> 7fff901a0000-7fff901b0000 r-xp 00000000 00:00 0                          [vdso]
>>>>> 7fff901b0000-7fff90200000 r-xp 00000000 fd:00 792351                     /usr/lib64/ld64.so.2
>>>>> 7fff90200000-7fff90210000 r--p 00040000 fd:00 792351                     /usr/lib64/ld64.so.2
>>>>> 7fff90210000-7fff90220000 rw-p 00050000 fd:00 792351                     /usr/lib64/ld64.so.2
>>>>> 7fffc9770000-7fffc9880000 rw-p 00000000 00:00 0                          [stack]
>>>>> 1000000000000-1000040000000 r--p 00000000 00:00 0                        [anon:virtual_address_range]
>>>>> 2000000000000-2000040000000 r--p 00000000 00:00 0                        [anon:virtual_address_range]
>>>>> 4000000000000-4000040000000 r--p 00000000 00:00 0                        [anon:virtual_address_range]
>>>>> 8000000000000-8000040000000 r--p 00000000 00:00 0                        [anon:virtual_address_range]
>>>>> eb95410220000-fffff90220000 r--p 00000000 00:00 0                        [anon:virtual_address_range]
>>>>>
>>>>>
>>>>>
>>>>>
>>>>> If I give the hint address serially from 128TB then the address
>>>>> space is contigous and gap is also MAP_SIZE, the test is passing.
>>>>>
>>>>> 10000000-10010000 r-xp 00000000 fd:05 134226638                          /home/donet/linux/tools/testing/selftests/mm/virtual_address_range
>>>>> 10010000-10020000 r--p 00000000 fd:05 134226638                          /home/donet/linux/tools/testing/selftests/mm/virtual_address_range
>>>>> 10020000-10030000 rw-p 00010000 fd:05 134226638                          /home/donet/linux/tools/testing/selftests/mm/virtual_address_range
>>>>> 33000000-10033000000 r--p 00000000 00:00 0                               [anon:virtual_address_range]
>>>>> 10033380000-100333b0000 rw-p 00000000 00:00 0                            [heap]
>>>>> 1006f0f0000-10071000000 rw-p 00000000 00:00 0
>>>>> 10071000000-7fffb1000000 r--p 00000000 00:00 0                           [anon:virtual_address_range]
>>>>> 7fffb15d0000-7fffb1800000 r-xp 00000000 fd:00 792355                     /usr/lib64/libc.so.6
>>>>> 7fffb1800000-7fffb1810000 r--p 00230000 fd:00 792355                     /usr/lib64/libc.so.6
>>>>> 7fffb1810000-7fffb1820000 rw-p 00240000 fd:00 792355                     /usr/lib64/libc.so.6
>>>>> 7fffb1820000-7fffb1900000 r-xp 00000000 fd:00 792358                     /usr/lib64/libm.so.6
>>>>> 7fffb1900000-7fffb1910000 r--p 000d0000 fd:00 792358                     /usr/lib64/libm.so.6
>>>>> 7fffb1910000-7fffb1920000 rw-p 000e0000 fd:00 792358                     /usr/lib64/libm.so.6
>>>>> 7fffb1930000-7fffb1970000 r--p 00000000 00:00 0                          [vvar]
>>>>> 7fffb1970000-7fffb1980000 r-xp 00000000 00:00 0                          [vdso]
>>>>> 7fffb1980000-7fffb19d0000 r-xp 00000000 fd:00 792351                     /usr/lib64/ld64.so.2
>>>>> 7fffb19d0000-7fffb19e0000 r--p 00040000 fd:00 792351                     /usr/lib64/ld64.so.2
>>>>> 7fffb19e0000-7fffb19f0000 rw-p 00050000 fd:00 792351                     /usr/lib64/ld64.so.2
>>>>> 7fffc5470000-7fffc5580000 rw-p 00000000 00:00 0                          [stack]
>>>>> 800000000000-2aab000000000 r--p 00000000 00:00 0                         [anon:virtual_address_range]
>>>>>
>>>>>
>>>> Thank you for this output. I can't wrap my head around why this behaviour changes
>>>> when you generate the hint sequentially. The mmap() syscall is supposed to do the
>>>> following (irrespective of high VA space or not) - if the allocation at the hint
>>> Yes, it is working as expected. On PowerPC, the DEFAULT_MAP_WINDOW is
>>> 128TB, and the system can map up to 4PB.
>>>
>>> In the test, the first mmap call maps memory up to 128TB without any
>>> hint, so the VMAs are created below the 128TB boundary.
>>>
>>> In the second mmap call, we provide a hint starting from 256TB, and
>>> the hint address is generated randomly above 256TB. The mappings are
>>> correctly created at these hint addresses. Since the hint addresses
>>> are random, the resulting VMAs are also created at random locations.
>>>
>>> So, what I tried is: mapping from 0 to 128TB without any hint, and
>>> then for the second mmap, instead of starting the hint from 256TB, I
>>> started from 128TB. Instead of using random hint addresses, I used
>>> sequential hint addresses from 128TB up to 512TB. With this change,
>>> the VMAs are created in order, and the test passes.
>>>
>>> 800000000000-2aab000000000 r--p 00000000 00:00 0    128TB to 512TB VMA
>>>
>>> I think we will see same behaviour on x86 with X86_FEATURE_LA57.
>>>
>>> I will send the updated patch in V2.
>> Since you say it fails on both radix and hash, it means that the generic
>> code path is failing. I see that on my system, when I run the test with
>> LPA2 config, write() fails with errno set to -ENOMEM. Can you apply
>> the following diff and check whether the test fails still. Doing this
>> fixed it for arm64.
>>
>> diff --git a/tools/testing/selftests/mm/virtual_address_range.c b/tools/testing/selftests/mm/virtual_address_range.c
>>
>> index b380e102b22f..3032902d01f2 100644
>>
>> --- a/tools/testing/selftests/mm/virtual_address_range.c
>>
>> +++ b/tools/testing/selftests/mm/virtual_address_range.c
>>
>> @@ -173,10 +173,6 @@ static int validate_complete_va_space(void)
>>
>>                   */
>>
>>                  hop = 0;
>>
>>                  while (start_addr + hop < end_addr) {
>>
>> -                       if (write(fd, (void *)(start_addr + hop), 1) != 1)
>>
>> -                               return 1;
>>
>> -                       lseek(fd, 0, SEEK_SET);
>>
>> -
>>
>>                          if (is_marked_vma(vma_name))
>>
>>                                  munmap((char *)(start_addr + hop), MAP_CHUNK_SIZE);
>>
> Even with this change, the test is still failing. In this case,
> we are allocating physical memory and writing into it, but our
> issue seems to be with the gap between VMAs, so I believe this
> might not be directly related.
>
> I will send the next revision where the test passes and no
> issues are observed

But we are not solving the real problem - can you give me the diff
of the modified test, the sequential hinting you were talking
about?

>
> Just curious — with LPA2, is the second mmap() call successful?
> And are the VMAs being created at the hint address as expected?

mmap() is working as expected on LPA2 - the first three mmap's
correctly happen at the hint addresses, then mmap retrieves
addresses in a top down fashion, and the test passes, after
eliding the gap check on the boundary.

>   
>>>> addr succeeds, then all is well, otherwise, do a top-down search for a large
>>>> enough gap. I am not aware of the nuances in powerpc but I really am suspecting
>>>> a bug in powerpc mmap code. Can you try to do some tracing - which function
>>>> eventually fails to find the empty gap?
>>>>
>>>> Through my limited code tracing - we should end up in slice_find_area_topdown,
>>>> then we ask the generic code to find the gap using vm_unmapped_area. So I
>>>> suspect something is happening between this, probably slice_scan_available().
>>>>
>>>>>>>     From 0 to 128TB, we map memory directly without using any hint. For the range above
>>>>>>> 256TB up to 512TB, we perform the mapping using hint addresses. In the current test,
>>>>>>> we use random hint addresses, but I have modified it to generate hint addresses linearly
>>>>>>> starting from 128TB.
>>>>>>>
>>>>>>> With this change:
>>>>>>>
>>>>>>> The 0–128TB range is mapped without hints and verified accordingly.
>>>>>>>
>>>>>>> The 128TB–512TB range is mapped using linear hint addresses and then verified.
>>>>>>>
>>>>>>> Below are the VMAs obtained with this approach:
>>>>>>>
>>>>>>> 10000000-10010000 r-xp 00000000 fd:05 135019531
>>>>>>> 10010000-10020000 r--p 00000000 fd:05 135019531
>>>>>>> 10020000-10030000 rw-p 00010000 fd:05 135019531
>>>>>>> 20000000-10020000000 r--p 00000000 00:00 0
>>>>>>> 10020800000-10020830000 rw-p 00000000 00:00 0
>>>>>>> 1004bcf0000-1004c000000 rw-p 00000000 00:00 0
>>>>>>> 1004c000000-7fff8c000000 r--p 00000000 00:00 0
>>>>>>> 7fff8c130000-7fff8c360000 r-xp 00000000 fd:00 792355
>>>>>>> 7fff8c360000-7fff8c370000 r--p 00230000 fd:00 792355
>>>>>>> 7fff8c370000-7fff8c380000 rw-p 00240000 fd:00 792355
>>>>>>> 7fff8c380000-7fff8c460000 r-xp 00000000 fd:00 792358
>>>>>>> 7fff8c460000-7fff8c470000 r--p 000d0000 fd:00 792358
>>>>>>> 7fff8c470000-7fff8c480000 rw-p 000e0000 fd:00 792358
>>>>>>> 7fff8c490000-7fff8c4d0000 r--p 00000000 00:00 0
>>>>>>> 7fff8c4d0000-7fff8c4e0000 r-xp 00000000 00:00 0
>>>>>>> 7fff8c4e0000-7fff8c530000 r-xp 00000000 fd:00 792351
>>>>>>> 7fff8c530000-7fff8c540000 r--p 00040000 fd:00 792351
>>>>>>> 7fff8c540000-7fff8c550000 rw-p 00050000 fd:00 792351
>>>>>>> 7fff8d000000-7fffcd000000 r--p 00000000 00:00 0
>>>>>>> 7fffe9c80000-7fffe9d90000 rw-p 00000000 00:00 0
>>>>>>> 800000000000-2000000000000 r--p 00000000 00:00 0    -> High Address (128TB to 512TB)
>>>>>>>
>>>>>>> diff --git a/tools/testing/selftests/mm/virtual_address_range.c b/tools/testing/selftests/mm/virtual_address_range.c
>>>>>>> index 4c4c35eac15e..0be008cba4b0 100644
>>>>>>> --- a/tools/testing/selftests/mm/virtual_address_range.c
>>>>>>> +++ b/tools/testing/selftests/mm/virtual_address_range.c
>>>>>>> @@ -56,21 +56,21 @@
>>>>>>>      #ifdef __aarch64__
>>>>>>>      #define HIGH_ADDR_MARK  ADDR_MARK_256TB
>>>>>>> -#define HIGH_ADDR_SHIFT 49
>>>>>>> +#define HIGH_ADDR_SHIFT 48
>>>>>>>      #define NR_CHUNKS_LOW   NR_CHUNKS_256TB
>>>>>>>      #define NR_CHUNKS_HIGH  NR_CHUNKS_3840TB
>>>>>>>      #else
>>>>>>>      #define HIGH_ADDR_MARK  ADDR_MARK_128TB
>>>>>>> -#define HIGH_ADDR_SHIFT 48
>>>>>>> +#define HIGH_ADDR_SHIFT 47
>>>>>>>      #define NR_CHUNKS_LOW   NR_CHUNKS_128TB
>>>>>>>      #define NR_CHUNKS_HIGH  NR_CHUNKS_384TB
>>>>>>>      #endif
>>>>>>> -static char *hint_addr(void)
>>>>>>> +static char *hint_addr(int hint)
>>>>>>>      {
>>>>>>> -       int bits = HIGH_ADDR_SHIFT + rand() % (63 - HIGH_ADDR_SHIFT);
>>>>>>> +       unsigned long addr = ((1UL << HIGH_ADDR_SHIFT) + (hint * MAP_CHUNK_SIZE));
>>>>>>> -       return (char *) (1UL << bits);
>>>>>>> +       return (char *) (addr);
>>>>>>>      }
>>>>>>>      static void validate_addr(char *ptr, int high_addr)
>>>>>>> @@ -217,7 +217,7 @@ int main(int argc, char *argv[])
>>>>>>>             }
>>>>>>>             for (i = 0; i < NR_CHUNKS_HIGH; i++) {
>>>>>>> -               hint = hint_addr();
>>>>>>> +               hint = hint_addr(i);
>>>>>>>                     hptr[i] = mmap(hint, MAP_CHUNK_SIZE, PROT_READ,
>>>>>>>                                    MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>> Can we fix it this way?

