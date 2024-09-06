Return-Path: <linux-kselftest+bounces-17361-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9597496EB1A
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Sep 2024 08:56:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0AECB22BE3
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Sep 2024 06:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F3FC14264A;
	Fri,  6 Sep 2024 06:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="KB9Rbi/8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2078.outbound.protection.outlook.com [40.107.100.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 250B63B1A2;
	Fri,  6 Sep 2024 06:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725605781; cv=fail; b=Ii4adbFaZuw5RTsekg5HgXZpUQIRXpNJqU3JfRmJ4UW21wx/nCWhyYJ8mF2ViZcDyx2AWYCADpachvzYLeyd3rkjOmF/q8z9oXk0XxK9D9FHpEEfoocdK9NUgK0Vl/V9m+WpGN6Lop8wtOdY+ixuNeMNblOxL1ER0dXrXKT7M2o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725605781; c=relaxed/simple;
	bh=I9QFGYcrFth5YFceXauTwYx+eaaE6dcsdewaCu/M9I0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oW+qy5fN9fzMakjReCp+dcmsqdCIvpmo1E/3fFyz6pJxdBCm0eQambvQTpzDR0IXN5XvF9PxaAVnGsDJJvQvEpMgnEd4pwm3+ixCPD38kf5ATMuUqJNcQOkujKmhgVop7XkfhHvrqajV4NIeyAdQ4g1zbPK0CP5r5abvP3bDAZg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=KB9Rbi/8; arc=fail smtp.client-ip=40.107.100.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yuSAQoZ3tkOkQ+bJC81Lqa3GTgGMAL35K6qb0hVsk7urgZXBcmgfsQ4EUDY3wZqbYnK+v4e1Be6iPt/6Zak0z1zIDuFUFC8m6r1nZwBGVOSuwN4iUaiixx5bhB0GE/wWLhFBJt0NdJmtPZaLMx/2r/28hC8KoDwx97d4WpowfA0+HAtpe/ajMIGjVjjxQGsgbLwxlrf/IQFxaykYf+hMEvrCxn0bRjDZgJI/tpPsL5mu8Iy3VRBB8iLbE+h+PlMWwqjkwgUS+fXPO5hsAdJbD3Q4w3UOXUCXxRKIooPGBHJs05/qaaLyfzYhbOL1ZV+YBsjNnK2smHn0qpOlZ916Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I9QFGYcrFth5YFceXauTwYx+eaaE6dcsdewaCu/M9I0=;
 b=cDsIOWl8qm7ry32R2/FSJOZjlJj5UpJntWE7jk+c0z2Nd2YdqDqATmPFkvZvbpAGY7BhtwmLU1BrzhlitGq6LEFSyloFGr6YcT91zy6bJHQftS6L0B01P53n4+WBtnSY6Mjm+5FqZEhgEwbYyPp7H1CeEPD7q2CW96FObtIYARLjQHDzfDjfGhSLkrOPGlkcUp8YStL/7LW5sxgJnlsWNaBvLusvZw+knTRJbWv7PgdHJcFvpygqLbMDjYKyD4egB1HTUT0P4wGDhOKhLiCW4uQ38GOSj/5yZS2ESxfxwmnMUCs/LYAV/tC4u8KH02b+OB/kYflMTGwEkpGJ7TshcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I9QFGYcrFth5YFceXauTwYx+eaaE6dcsdewaCu/M9I0=;
 b=KB9Rbi/8lbDw+vIZQTMx7EFIHXou9BUChKSvUDYQjanxKFMXFRqUhVipcpi44r3YyCpkgmFbzeqNoFhzt/SoTthfnE2gNxaC1JElVVdyCBbDm0MQUgr6TOS/JQG7rq4MTJvFmiKZVSkZESRSEBUlc+dfT9eEkmR0d13lDMIP6yhRz0PWjatNhQbWweFYj4bu+UGosPNoIE/juggmZtA4Y3P6pJC5RVvAZonikDQd42g8oJ38Uhh4SgmPcVQWZhppeSYEQH+3hlpf0/Qlm8m8vdBJQCNEu3ehPXkUVGcCFs4VL0q5TpXA/0r4WZ/omVVygGZAiEM7aViWcjdkTLMKpw==
Received: from DM6PR11MB4236.namprd11.prod.outlook.com (2603:10b6:5:1d9::20)
 by SA1PR11MB8489.namprd11.prod.outlook.com (2603:10b6:806:3a9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Fri, 6 Sep
 2024 06:56:15 +0000
Received: from DM6PR11MB4236.namprd11.prod.outlook.com
 ([fe80::ea6a:8f25:ead5:8dfb]) by DM6PR11MB4236.namprd11.prod.outlook.com
 ([fe80::ea6a:8f25:ead5:8dfb%5]) with mapi id 15.20.7918.024; Fri, 6 Sep 2024
 06:56:15 +0000
From: <Mohan.Prasad@microchip.com>
To: <bcreeley@amd.com>, <netdev@vger.kernel.org>, <davem@davemloft.net>,
	<kuba@kernel.org>
CC: <shuah@kernel.org>, <Bryan.Whitehead@microchip.com>,
	<UNGLinuxDriver@microchip.com>, <edumazet@google.com>, <pabeni@redhat.com>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<horms@kernel.org>, <brett.creeley@amd.com>, <rosenp@gmail.com>
Subject: RE: [PATCH net-next 3/3] selftests: lan743x: Add testcase to check
 throughput of lan743x
Thread-Topic: [PATCH net-next 3/3] selftests: lan743x: Add testcase to check
 throughput of lan743x
Thread-Index: AQHa/ollcs6Ohcn4Q02jwTj/84unnrJHzjYAgAKID/A=
Date: Fri, 6 Sep 2024 06:56:15 +0000
Message-ID:
 <DM6PR11MB42363573F3189C914E600A52839E2@DM6PR11MB4236.namprd11.prod.outlook.com>
References: <20240903221549.1215842-1-mohan.prasad@microchip.com>
 <20240903221549.1215842-4-mohan.prasad@microchip.com>
 <09a5c481-883d-48f4-81d4-1028f7cd72d7@amd.com>
In-Reply-To: <09a5c481-883d-48f4-81d4-1028f7cd72d7@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB4236:EE_|SA1PR11MB8489:EE_
x-ms-office365-filtering-correlation-id: 55486950-e6c1-4c3c-4b0b-08dcce410073
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4236.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?RUJxVXp4TEhvSDJUWk1YTkNwcU1MM3BaR21kZ0hsSnpxaVN3VlVzWWV6ak5C?=
 =?utf-8?B?c3VKeXlHYWkwMksvb2x3a2pLak1HQi80RzJTVU4vS011amhKcUJ6VE84MEdo?=
 =?utf-8?B?RkxXMjBpZG9tY1pwdkxrQUs3L3lzeUdmOWdpTnB3OGhNdkNlRXlBNTlCdTM3?=
 =?utf-8?B?Lzk0WTVzM2NQZXAyQk5sY3hHSXg0QXArZTBLQXJIY1FsY0tDbnJWaFpJdkJy?=
 =?utf-8?B?Wm5ZNE1lZ0N5eWZmb3JOZVdiMjdKdDltTldhcThzY1FLZXZTVVNNaU9UL1dU?=
 =?utf-8?B?TEpXTWV2ZllDYTUvVEQyL2NXSUpsNWtmelU4emR5bXdsR08rck91d1grT1g0?=
 =?utf-8?B?RmlFU3RCZEsyTWdYS2Z0SGNlaXc4TkpTQmpGMVFmOFZRblBzZDRKNG5uZkM2?=
 =?utf-8?B?NVRpVUJnRDBaWlFockdCcDUzQVFKWmhwQlBYMzZoMFlENm1BRkx5M1paT2xh?=
 =?utf-8?B?THJ0eWJIcFZvQkNCNWFqOG5ac0JvTGJ1OUNyTCtRb2R3dnNlYUFqc3RFY3lr?=
 =?utf-8?B?YmZ5aFBnSjloNXA3Q2IvUnE0R0Q2b28wQzVOd2o0bkIwNFg0Rjg4Y0h4dDlE?=
 =?utf-8?B?Zm9NdXpHUW5BKy9Uc3dyNGUxTGRyY2pDaFR0K0x1eHduVlVkd1RuYmRwMzZM?=
 =?utf-8?B?RCt2YjR5TjBUUHk2WTlSbjlrS0twZVBtM1VkdUZCc3Fjd2ppWDFGOW16UDNZ?=
 =?utf-8?B?ZWw0WHZuTmtyL1dUd0NucTJYVlVsbEpFL21GYkg5dGp3N3gycGNxSnpINTRQ?=
 =?utf-8?B?WGhmV3VGcjN1UjRoOXV3anZNRjhWZmF6MjM5RFJzNUtWb3FZMkJ1bTUvME5m?=
 =?utf-8?B?OUQ1UGNoSUdKczh2dDdFa2dHZXVRaCszbEdMaXJwSWJLTjJXSm1xcS9ZbE1z?=
 =?utf-8?B?bS9YWFAxWUc4ZGdUdm0rZWk1TXV3RnpnS25oWkx3NXVYKzkzOVA1UktUOVRw?=
 =?utf-8?B?VVNHQUJlV0h1WXBKWHB6dnoyNm5EWngycExsT01uRGpCL0dBUmR6T0Vpc1J3?=
 =?utf-8?B?aEJyb2ZZV1JHejZ5TGVpUTg4emt6N0I5M1hjbEphbWRvUEpPQUdwWWJDM0or?=
 =?utf-8?B?ODZBZm1jMVBpa1JMQUlCblVNQ3dFNG4xRDQxanZWbjR2RHFLcnNpM2JwWXFW?=
 =?utf-8?B?blZYbXNCWFp1TDJLODRQY2w2Tis0enVaRWZGaUFodkhleVpBR2hzbi9rZlQr?=
 =?utf-8?B?ZU1lU0VuZlZseVRCdTB6Tys5cjNjTG1vQUZXYTRmeXA1Nnd0RUxJc2R6VnZq?=
 =?utf-8?B?dGpadElrZVlNT0svYkMvOWZmWFhPZG50aHUwWDB3WkNyRlc5RXI1SDByZldx?=
 =?utf-8?B?NnRWa21XMm9GN2hoN3BQekFBcW5qZ3ZTR0xFRjVjMDlOdWNvSlZoeWlHcmd5?=
 =?utf-8?B?MDNjREpnRk9neDBDZmdiR2ZubG5KVlc0dmtuQzVVblFDZ1ErQ2xuLzVpRU5E?=
 =?utf-8?B?K1Q3OTVUMWhYSXVnRzBmUW4ra05YdmxBWnJoaFYzbFNhcHg1UTVnWTM5UDcy?=
 =?utf-8?B?bEVpVDBKYVRrV3VZaG5kUlFuY2g2bUxsSVNZVWZyUW1nK3h2aHRPN3QxMUJr?=
 =?utf-8?B?MEpNTVBSZWtIU2VQcGszNnBXbFhQYmwrMjJCRDEvY2t5VEprbVVIWEo4WFVh?=
 =?utf-8?B?Y2ZYMUdybExRR3k1T1dwL1RtNExSVnkrQ2JocmRyblI3OEhuMHB1RnE4KzJh?=
 =?utf-8?B?MUxkN0dNN1NuN2lhTk5BNmxGalZNWUZxNk9vYURaOXRia1hIbktSSWNpYTFh?=
 =?utf-8?B?NFE3bVhaSjloRW5UV0J6czNXM0VQRXYzejdUY3BNcTJjZW1YVFN0S1dEczNV?=
 =?utf-8?B?eGVFeEpLNHFRWEpJbXFxUitjdE8walZCRmV6S0tReDAyclluRlJzVHF2RzAy?=
 =?utf-8?B?Sk1xeXgzd28vRmZ6ZGJUdFJvUFRKY2RWb1VsR3FIYkZPSlE9PQ==?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Sk5PSkk4VkR0UVdlaTVLQnlMK0hISVpJbGpVZkt4UVBjNFJJZDJpd1ZOL1g2?=
 =?utf-8?B?SVdDV3lISWlIWTdGTGlpRDdiL0lZdXZpRnRhbnpmbHQxL2FSRUdzOUJKRHNj?=
 =?utf-8?B?YzNucWNvaE1BdG9FMng5TkdSSGE0dkl4WFQ4b21hZXQ4cEM4eG1JbGd4WUpz?=
 =?utf-8?B?UEdSM2owYVY5ZHlFckpsM0pFZW4vUkVBTUZ3OGZmcXVpVytVRjhpN0lHVVQz?=
 =?utf-8?B?L1lpU01vYXFIT1pVMUdUbGhGb2VkS0VRaEtGcWJqWStsM2k4OGJjcXNSM3NU?=
 =?utf-8?B?cHExNkc5RXlXYnpWNFkxenJrV2FZb3M1VHRoR1JvWXpuUndkZUcvQkZmdXRm?=
 =?utf-8?B?aVR6V1QzNkFQSTJUZnZnc3I4UUVENllxSVVsUFpwODBYd05HdWszTC9XN09l?=
 =?utf-8?B?UHRtcjBwN21QTThMNThCLy9zeWNJdVQ0RjZUU3BqZzlweUR5ZTFjUW1LTS90?=
 =?utf-8?B?OTFJTFdWVU9zRXhCQVNhYWpVeGxqR1hFeHBiOVNwZHQ5RnlPeTF6Mk5GTDN6?=
 =?utf-8?B?dC8vYkhtSXB1SGtDZHpORnhvREVsOGlvL3pIWU5aYkVrWUpsN3BXM1lraXNW?=
 =?utf-8?B?TnNJZ3M4WnZTOVNzYmhBNkZLc2d2U0NsVUZPYnl2cStFMGxMTW40UWNvLzEy?=
 =?utf-8?B?Vkx2VkVJUDdicXVybWJ5S1ZMQnlZVnFDaGpXcW52bWczMTI1S1doR0o2empt?=
 =?utf-8?B?SHAvbDNvaEZ6dXZZZlJnNzl4a2Z0WXhPakpoZkpCT1VJRmNRdU5UdEFBcDhp?=
 =?utf-8?B?TnBYNjJpandlV2NTeEdqMTdHYS8zK3FMTXlOZXRWeUV5RUM2YURBWVFlL3Zn?=
 =?utf-8?B?THJFUnU1dVczZzAvNGdwalYvTHFqakJqTHV6dk5Fd2VUZDZjMyttVGh5Q3lH?=
 =?utf-8?B?VDh4bW5WS3NoaTdMbXhKTlU4RTdsTXFDUkxWT0gyaFNYNjRkMkMzaXY5Z2pn?=
 =?utf-8?B?dy8ySnpEYy9NSWJTVDFFcVhTVit6N21qMDRnaXFIRzRNblVWUnEyd2lRbjVM?=
 =?utf-8?B?eHBQYytSSTQxeUN1QmVGcDVxSW1ONEFVVGxoeXprV00vdHQ3RzljWkZvUGQy?=
 =?utf-8?B?NXY5ci9tZ1gyMlVqQnhrakhNRmVTMEtabmphRXgrODY5dWRZMmEzSmtVOFhu?=
 =?utf-8?B?cTNrdElsdUoreXpGZlg4dXdLVWFLV0R1bURQM3ZXSytpWFVPQ1dlbzk0Z3Vz?=
 =?utf-8?B?YVhoMTJKMkswZVBscTBXYkxBeWZjMHdWYTg5NTF0cFJCQkRoU2JiNGVaNXVz?=
 =?utf-8?B?cVJnTXNzbFRsa0JJZXpPdk5sdlJLZ1NjQ2lqOUtieStvSzlIZ3hsZXRpVlRR?=
 =?utf-8?B?V1F2TFd2Yi9GVDA2aHdwQ1NHZ0V6L3J1cmdCQU5LRXZCWmVrRTczQUpiV290?=
 =?utf-8?B?bHFueHl5QW5YZVMyMmZPL0FPdnAyRnNhVzY4WjloaTJ3QXlVYzVHTzlYWU5R?=
 =?utf-8?B?NDJNc1NHTjMyb21SQ2VXQi8xZWNEeFRIZXo2MW05Wkg4WUtDWFkwcnhSMWlu?=
 =?utf-8?B?QWZiQ3p6UW54am4xOUJWdUZnV0Nxd3VoMU5nZlFFK0hPcnMwVWJqdncxMXNn?=
 =?utf-8?B?cGhLNUFlRU1sZjk4ckZQbXBKRHAvUktWR1VuL29qMXJHb08xdFAzbS9kUit4?=
 =?utf-8?B?eWhmOXoyMzZYSmxEQ09EZlJhcWNGSk9qZ2l6MTlycHk0MUhYc1dNN3Z3REtl?=
 =?utf-8?B?MlE5OEJncnUzVkRHOXhlVDRUNno5ODhFSlUxak1EcENZVG1tOEIrZElOa2h4?=
 =?utf-8?B?ekM2U3BXTms4dDJNWkwrN3RHWkd4MVdHS09nbXF0MHZYcGlPQnUrWHZwZEhN?=
 =?utf-8?B?U3FlSmZLWFliLzY5d2RXMlBIdlUyejJnakF6UEhsZVRlSnBSNXB0MHRMY2pG?=
 =?utf-8?B?VEpvd2c5Vk1VcmI4SjByOUVoeFJmTlBnRlM1U01wTnl0OWo2L29TeGkyWHJG?=
 =?utf-8?B?YUtObThVUFJ4cGdnSWIySWtnZnYwQWZzZWw1ZVU1M2xhTFloZDRvT3ByODlQ?=
 =?utf-8?B?dC9BeHg1TEVnM0J2T3Bka2I1WWZrUS9MUUhYNm5FV0xCQjBXMC9FZ0w0dWJp?=
 =?utf-8?B?TGxqN2J3Q2dHSVV0Y0RVZEFrcHVoV0dLZmRkdHQ2RTg4RDNqOHI4b0dEbVNM?=
 =?utf-8?B?SlYxR1MzYThTNm4wYk8wVHEva29QdTJ5VDJ1TXVoQVJVMlNzZUNjNVcrVjdk?=
 =?utf-8?B?TXc9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 55486950-e6c1-4c3c-4b0b-08dcce410073
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2024 06:56:15.5031
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wBEElvzED0bCSozo06WjdUTHzgRPgdYH2mxLRSF84fuwgTWMMtgD97k15Curm9OJbm8GJ2y5Om4wyfNRLG/8HJp5DPos1e7NXfHIM02cEZU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8489

SGkgQnJldHQsDQoNClRoYW5rIHlvdSBmb3IgdGhlIHJldmlldyBjb21tZW50cy4NCg0KPiBFWFRF
Uk5BTCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNz
IHlvdSBrbm93IHRoZQ0KPiBjb250ZW50IGlzIHNhZmUNCj4gDQo+IE9uIDkvMy8yMDI0IDM6MTUg
UE0sIE1vaGFuIFByYXNhZCBKIHdyb3RlOg0KPiA+IENhdXRpb246IFRoaXMgbWVzc2FnZSBvcmln
aW5hdGVkIGZyb20gYW4gRXh0ZXJuYWwgU291cmNlLiBVc2UgcHJvcGVyDQo+IGNhdXRpb24gd2hl
biBvcGVuaW5nIGF0dGFjaG1lbnRzLCBjbGlja2luZyBsaW5rcywgb3IgcmVzcG9uZGluZy4NCj4g
Pg0KPiA+DQo+ID4gQWRkIHRlc3RjYXNlIHRvIGNoZWNrIFRDUCB0aHJvdWdocHV0IG9mIGxhbjc0
M3ggbmV0d29yayBkcml2ZXIuDQo+ID4gVGVzdCB1c2VzIGlwZXJmMyB0byBkbyBwZXJmb3JtYW5j
ZSB0ZXN0aW5nIG9mIHRoZSBkcml2ZXIuDQo+ID4gVENQIGRhdGEgYXQgZGlmZmVyZW50IHNwZWVk
cyBpcyBzZW50LCByZWNlaXZlZCBhbmQgdmVyaWZpZWQuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5
OiBNb2hhbiBQcmFzYWQgSiA8bW9oYW4ucHJhc2FkQG1pY3JvY2hpcC5jb20+DQo+ID4gLS0tDQo+
ID4gICAuLi4vbmV0L2h3L21pY3JvY2hpcC9sYW43NDN4L2xhbjc0M3gucHkgICAgICAgfCAzMyAr
KysrKysrKysrKysrKysrKysrDQo+ID4gICAxIGZpbGUgY2hhbmdlZCwgMzMgaW5zZXJ0aW9ucygr
KQ0KPiA+DQo+ID4gZGlmZiAtLWdpdA0KPiA+IGEvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvZHJp
dmVycy9uZXQvaHcvbWljcm9jaGlwL2xhbjc0M3gvbGFuNzQzeC5weQ0KPiA+IGIvdG9vbHMvdGVz
dGluZy9zZWxmdGVzdHMvZHJpdmVycy9uZXQvaHcvbWljcm9jaGlwL2xhbjc0M3gvbGFuNzQzeC5w
eQ0KPiA+IGluZGV4IDU5ZjBiZTJhNy4uYTNkY2Y3ODk2IDEwMDc1NQ0KPiA+IC0tLQ0KPiA+IGEv
dG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvZHJpdmVycy9uZXQvaHcvbWljcm9jaGlwL2xhbjc0M3gv
bGFuNzQzeC5weQ0KPiA+ICsrKyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2RyaXZlcnMvbmV0
L2h3L21pY3JvY2hpcC9sYW43NDN4L2xhbjc0M3gNCj4gPiArKysgLnB5DQo+ID4gQEAgLTMsNiAr
Myw3IEBADQo+ID4NCj4gPiAgIGltcG9ydCB0aW1lDQo+ID4gICBpbXBvcnQgcmUNCj4gPiAraW1w
b3J0IGpzb24NCj4gPiAgIGZyb20gbGliLnB5IGltcG9ydCBrc2Z0X3J1biwga3NmdF9leGl0LCBr
c2Z0X3ByLCBrc2Z0X2VxDQo+ID4gICBmcm9tIGxpYi5weSBpbXBvcnQgS3NmdEZhaWxFeCwgS3Nm
dFNraXBFeA0KPiA+ICAgZnJvbSBsaWIucHkgaW1wb3J0IE5ldERydkVwRW52DQo+ID4gQEAgLTc1
LDYgKzc2LDM4IEBAIGRlZiB0ZXN0X25ldHdvcmtfc3BlZWQoY2ZnKSAtPiBOb25lOg0KPiA+ICAg
ICAgICAgICAgICAgdGltZS5zbGVlcCg1KQ0KPiA+ICAgICAgICAgICAgICAgdmVyaWZ5X3NwZWVk
X2FuZF9kdXBsZXgoY2ZnLmlmbmFtZSwgc3BlZWQsIGR1cGxleCkNCj4gPg0KPiA+ICtkZWYgdGVz
dF90Y3BfdGhyb3VnaHB1dChjZmcpIC0+IE5vbmU6DQo+ID4gKyAgICBzcGVlZHMgPSBbIjEwIiwg
IjEwMCIsICIxMDAwIl0NCj4gPiArICAgICIiIlRlc3QgZHVyYXRpb24gaW4gc2Vjb25kcyIiIg0K
PiA+ICsgICAgdGVzdF9kdXJhdGlvbiA9IDUNCj4gPiArICAgIHRhcmdldF9pcCA9IGNmZy5yZW1v
dGVfYWRkcg0KPiA+ICsNCj4gPiArICAgIGZvciBzcGVlZCBpbiBzcGVlZHM6DQo+ID4gKyAgICAg
ICAgc2V0X3NwZWVkX2FuZF9kdXBsZXgoY2ZnLmlmbmFtZSwgc3BlZWQsICdmdWxsJykNCj4gPiAr
ICAgICAgICB0aW1lLnNsZWVwKDUpDQo+ID4gKyAgICAgICAgdmVyaWZ5X2xpbmtfdXAoY2ZnLmlm
bmFtZSkNCj4gPiArICAgICAgICBzZW5kX2NvbW1hbmQ9ZiJpcGVyZjMgLWMge3RhcmdldF9pcH0g
LXQge3Rlc3RfZHVyYXRpb259IC0tanNvbiINCj4gPiArICAgICAgICByZWNlaXZlX2NvbW1hbmQ9
ZiJpcGVyZjMgLWMge3RhcmdldF9pcH0gLXQge3Rlc3RfZHVyYXRpb259IC0tcmV2ZXJzZSAtLQ0K
PiBqc29uIg0KPiA+ICsgICAgICAgIHNlbmRfcmVzdWx0ID0gY21kKHNlbmRfY29tbWFuZCkNCj4g
PiArICAgICAgICByZWNlaXZlX3Jlc3VsdCA9IGNtZChyZWNlaXZlX2NvbW1hbmQpDQo+ID4gKyAg
ICAgICAgaWYgc2VuZF9yZXN1bHQucmV0ICE9IDAgb3IgcmVjZWl2ZV9yZXN1bHQucmV0ICE9IDA6
DQo+ID4gKyAgICAgICAgICAgIHJhaXNlIEtzZnRTa2lwRXgoIk5vIHNlcnZlciBpcyBydW5uaW5n
IikNCj4gPiArDQo+ID4gKyAgICAgICAgc2VuZF9vdXRwdXQgPSBzZW5kX3Jlc3VsdC5zdGRvdXQN
Cj4gPiArICAgICAgICByZWNlaXZlX291dHB1dCA9IHJlY2VpdmVfcmVzdWx0LnN0ZG91dA0KPiA+
ICsNCj4gPiArICAgICAgICBzZW5kX2RhdGEgPSBqc29uLmxvYWRzKHNlbmRfb3V0cHV0KQ0KPiA+
ICsgICAgICAgIHJlY2VpdmVfZGF0YSA9IGpzb24ubG9hZHMocmVjZWl2ZV9vdXRwdXQpDQo+ID4g
KyAgICAgICAgIiIiQ29udmVydCB0aHJvdWdocHV0IHRvIE1icHMiIiINCj4gPiArICAgICAgICBz
ZW5kX3Rocm91Z2hwdXQgPQ0KPiByb3VuZChzZW5kX2RhdGFbJ2VuZCddWydzdW1fc2VudCddWydi
aXRzX3Blcl9zZWNvbmQnXSAvIDFlNiwgMikNCj4gPiArICAgICAgICByZWNlaXZlX3Rocm91Z2hw
dXQgPQ0KPiA+ICsgcm91bmQocmVjZWl2ZV9kYXRhWydlbmQnXVsnc3VtX3JlY2VpdmVkJ11bJ2Jp
dHNfcGVyX3NlY29uZCddIC8gMWU2LA0KPiA+ICsgMikNCj4gPiArDQo+ID4gKyAgICAgICAga3Nm
dF9wcihmIlNlbmQgdGhyb3VnaHB1dDoge3NlbmRfdGhyb3VnaHB1dH0gTWJwcywgUmVjZWl2ZQ0K
PiB0aHJvdWdocHV0OiB7cmVjZWl2ZV90aHJvdWdocHV0fSBNYnBzIikNCj4gPiArICAgICAgICAi
IiJDaGVjayB3aGV0aGVyIHRocm91Z2hwdXQgaXMgbm90IGJlbG93IDAuOSB0aW1lcyB0aGUgc2V0
IHNwZWVkIiIiDQo+ID4gKyAgICAgICAgdGhyZXNob2xkID0gZmxvYXQoc3BlZWQpICogMC45DQo+
ID4gKyAgICAgICAgaWYgc2VuZF90aHJvdWdocHV0IDwgdGhyZXNob2xkIG9yIHJlY2VpdmVfdGhy
b3VnaHB1dCA8IHRocmVzaG9sZDoNCj4gPiArICAgICAgICAgICAgcmFpc2UgS3NmdEZhaWxFeCgi
VGhyb3VnaHB1dCBpcyBiZWxvdyB0aHJlc2hvbGQiKQ0KPiANCj4gSU1PIGl0IHdvdWxkIGJlIGJl
c3QgdG8gZG8gdGhlc2UgY2hlY2tzIHNlcGFyYXRlbHkgc28gdGhlIGZhaWx1cmUgaXMNCj4gaW1t
ZWRpYXRlbHkgb2J2aW91cy4NCg0KSSB3aWxsIHNlcGFyYXRlIHRoZXNlIGNoZWNrcyBpbiB0aGUg
bmV4dCB2ZXJzaW9uLg0KDQo+IA0KPiBUaGFua3MsDQo+IA0KPiBCcmV0dA0KPiA+ICsNCj4gPiAg
IGRlZiBtYWluKCkgLT4gTm9uZToNCj4gPiAgICAgICB3aXRoIE5ldERydkVwRW52KF9fZmlsZV9f
KSBhcyBjZmc6DQo+ID4gICAgICAgICAgIGtzZnRfcnVuKGdsb2JzPWdsb2JhbHMoKSwgY2FzZV9w
Zng9eyJ0ZXN0XyJ9LCBhcmdzPShjZmcsKSkNCj4gPiAtLQ0KPiA+IDIuNDMuMA0KPiA+DQo=

