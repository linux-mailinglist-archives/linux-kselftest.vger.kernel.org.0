Return-Path: <linux-kselftest+bounces-31528-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A509DA9A6D5
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Apr 2025 10:51:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A1251B86F57
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Apr 2025 08:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AECB229B38;
	Thu, 24 Apr 2025 08:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="O/yp1CCm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2044.outbound.protection.outlook.com [40.107.220.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65299221FA1;
	Thu, 24 Apr 2025 08:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745484461; cv=fail; b=rPl17yl5Ue6ogh0OWwUgV1aYb6UmXcaGDs3rLyMoGjS4SkaOgipZc7Msb14tJQXmQejeC7A2JtkGbrYr6JTVBe4D9+seGxALut89xWCmNynq1ljlWAmMk/Nj6NvQKM7gGw5db2iLsqQYyymeN9jACf5kCldP1rIt1n9+Ty5xkWM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745484461; c=relaxed/simple;
	bh=PzSY0LJSxSHdpmRtk+B3P4YDlrWz5VfvPnotEDeKQMs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ljiqmKE9ZGsfiI9HpTCPTuOflkQeK/HEBd4vvZ4WcARf25QKF4nZUTXjs5pR16IBKlsSRV6KxXQdxTIy13djh+KlhL4ElN7siGA9/CMwjHxgAF8jKzey/yyQV1Zq60hhmvqy4B0eUNXl5TBpkHiTJNZSStYMzBZyhXL4/EA2HaE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=O/yp1CCm; arc=fail smtp.client-ip=40.107.220.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hvNZaHskQlnTq929rNQuYNxEEKCZiDUzMMCi4AAsKk+/AEmTUHNtqrBOhQ/6OcigaRVofuScimiA9xzEc+LkSmwVp4YXIcs83mWZjhI551qjcYKVj/CL4THKnd6BKDkppl3wn2vkNRahNnIfClHkHBsf8+/2f/1MqLYMQ5NKrS4dQucv9qhLNP2RgzNEq+OlQpIwKxC1OACY1gCmh3p7Qorf7nquoQ9G+4twXv6cgVAdhOomAhaUdujQwt7w43transwhxRKAy8Tqh8XT3hxLIOpokriDNC7I1xuCx1mvJ5xPnKVrV44gX8VpEaAX+1m15d721FWyzq02lY1/qHcFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PzSY0LJSxSHdpmRtk+B3P4YDlrWz5VfvPnotEDeKQMs=;
 b=rgL5g74eKKZ/+zO0iPJxiuRGtu7ai1FmvEIBqVCiJNW6+7GsElIYkxPUbclwAfpp8OAHewCmF3PIEo5CeJwSojSWumpSlB30eGm6jQu0T6q9bTcmCck8eime+xHPI9QirqR7WFJeOlIw5r67H+GOEVKJ4dw2vsaswtrxXqtqhycWu0pLvhGs1E9SbK4ExTwBfQ3d+vi2wCWUq3nxkbl7OV6168ZTsqA0PiZdJ+0yKL/91wrlh7nZcRmRnTV6axB/N+TpFISq8yJDcKA0+29pJoYA6Bp6khwmDWZCJKzfqugJv4mzs/NSysodnVt2ia7au3xZx4yyWAKp275LoTPguw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PzSY0LJSxSHdpmRtk+B3P4YDlrWz5VfvPnotEDeKQMs=;
 b=O/yp1CCmOdyUDffl1e6zbag5P+F+W2zIxfYrumbcFqa830hWMdAQ45Kp2m8l8PmBDUkkMmArvB6m5daJfxRwMrifp+7HfpKJSCPJ2QkEbbMlJOnpAMOJpex06X2JgUPT92XZGUcdSGOoFCNr75nP0GPKlRgoQUeyPjPNe/llVLgsvM7DL/dWeX57+V/0TeJIJ/9UD2jb5fJPZy3jiOT/2S1cYq4DQeeT0zhMbqdNMJUMfEJhn1vtIymyerMz1YvqWZvNlVyptiqaV7JqMUH0bwwhxwI8kezG8akiWdU1wbfcoCIXcEcLMB1URUZi2UBpFrX+gkkUqU8IigM4aRPhZQ==
Received: from DS0PR12MB6560.namprd12.prod.outlook.com (2603:10b6:8:d0::22) by
 CY3PR12MB9679.namprd12.prod.outlook.com (2603:10b6:930:100::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.23; Thu, 24 Apr
 2025 08:47:37 +0000
Received: from DS0PR12MB6560.namprd12.prod.outlook.com
 ([fe80::4c05:4274:b769:b8af]) by DS0PR12MB6560.namprd12.prod.outlook.com
 ([fe80::4c05:4274:b769:b8af%2]) with mapi id 15.20.8678.021; Thu, 24 Apr 2025
 08:47:36 +0000
From: Cosmin Ratiu <cratiu@nvidia.com>
To: "almasrymina@google.com" <almasrymina@google.com>
CC: Jason Gunthorpe <jgg@nvidia.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>, Tariq
 Toukan <tariqt@nvidia.com>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, Dragos Tatulea <dtatulea@nvidia.com>,
	Saeed Mahameed <saeedm@nvidia.com>, "pabeni@redhat.com" <pabeni@redhat.com>,
	Leon Romanovsky <leonro@nvidia.com>, "edumazet@google.com"
	<edumazet@google.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"horms@kernel.org" <horms@kernel.org>, "kuba@kernel.org" <kuba@kernel.org>
Subject: Re: [PATCH net 1/2] net/devmem: Reject insufficiently large dmabuf
 pools
Thread-Topic: [PATCH net 1/2] net/devmem: Reject insufficiently large dmabuf
 pools
Thread-Index: AQHbtGV0Crm/qDneuE6vHN1WEyHDzrOxgeuAgAEAVoA=
Date: Thu, 24 Apr 2025 08:47:36 +0000
Message-ID: <9322c3c4826ed1072ddc9a2103cc641060665864.camel@nvidia.com>
References: <20250423153504.1085434-1-cratiu@nvidia.com>
	 <CAHS8izPxT_SB6+fc7dPcojv3mui3BjDZB5xmz3u6oYuA2805FA@mail.gmail.com>
In-Reply-To:
 <CAHS8izPxT_SB6+fc7dPcojv3mui3BjDZB5xmz3u6oYuA2805FA@mail.gmail.com>
Reply-To: Cosmin Ratiu <cratiu@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB6560:EE_|CY3PR12MB9679:EE_
x-ms-office365-filtering-correlation-id: 02b5e000-a52c-4379-9024-08dd830ca981
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?c2ptSzl4N1k4NjM2V0hpazhIcnN4c3R3aVYwVzZSV2Y0VzAwaDZiMmRHSG5m?=
 =?utf-8?B?OU1aYTJCVENqVTBhbHBJWnhJSXpJSjNhWW15YnFKaXYydGxhUGp3VHlYS2Rv?=
 =?utf-8?B?RUxaR01yZll5NWlsenl2ZXZOWHpsVVhrd3FCN3VxV2VYdGIrNm14TVNhcUpN?=
 =?utf-8?B?U2hvUnNtNkEwNUNBSzlneUgveC9TNjhObThrZ2ZrWm4vWDBKQ0hxRFdZSjBQ?=
 =?utf-8?B?c2JvaWNja1dZTmprYmRLZklmU2hMdDVwY0JTV255bHprSnY0V2JENXh4QS9a?=
 =?utf-8?B?eXdaUmd2Slp6aUd4SE14QlBzMFROT1djMldZamJTTndPQlJvL0pwRDlRd09J?=
 =?utf-8?B?TGo3STN3OFNPakpnRkFpdTg1YUlRTTJUR2ZZN2xsaG83WUxQS0dMNE1UN0pR?=
 =?utf-8?B?MkV6NEpLQUJISDJ3cDFYWk5kalF1WlBTNlE5NU1qaDl2MHJtU2RORWpubTJv?=
 =?utf-8?B?cnlCc3V3akxjU0hraTNicG1jMHBjc2s0U1NpdTh5M1k0OFVKOWFITmlld01B?=
 =?utf-8?B?NXVabW1lNFp1SnA3SUtjbWNKL3l1OHhOOTl1S1pwaEVqWWxNbUlxbXJDUzVk?=
 =?utf-8?B?RGN0RFFhU3J5Z0NsanlWb1hBbnFvSnFyNkk5K2NwRXNlTDQ5SENQZ3BmV20x?=
 =?utf-8?B?T2VSR3BxczBUZ2FvWWNPb2VSZkdmQWlBKzRIYUVVMTIvN0RJaHB3NzJlbW5C?=
 =?utf-8?B?eWpQc3lXaDV5bVdZSjhPQTg4L1R5R0tGN0paanN6a1M4am9XaFV6YVQ3Z01J?=
 =?utf-8?B?N1kxSnh1OWZUeXJ0QlNORWM0ZXlCelQrb3BzR2QwL0JPZkQyV05JNW4zQ2oz?=
 =?utf-8?B?QkwxVGNkN3g5REt3SHMyS1phZHRGeU1yaHNBOEN3Zy93amFQWUJlS25wbUhJ?=
 =?utf-8?B?S2hnTCt2eXhJRUY5NnZoMnFyck1qVFVzV1EzcCtOek9YNDNPQlBhWW12K3Aw?=
 =?utf-8?B?aW4yaTRMaTNiM1RLMURLT2dEMXIwSlpVRkpNMGtyMjdxeCsyVXB6dWcrZnNv?=
 =?utf-8?B?RVFXcFpJYzZBOVNpZnM4UjJTQi9TKzdMVEZ4ckhVSjZHMUdGY2dsVXpsVEgr?=
 =?utf-8?B?blBMMzA3MjF5cUJra0prQllGQ1gzQ29QK1RzS016bmJzV0ZKSE1kT3F3OHNz?=
 =?utf-8?B?ZHgyTUFTWXNOMUZXSlVWU3Q1MldDSmt4bTlxNmMrSFpoTDdrUkgrUUc2b3RH?=
 =?utf-8?B?bURDOGE2WW5yRlBZZ01EQXhZMzJ2eEFQc3BtVUxET0RRODAwb25qVTJBdG9J?=
 =?utf-8?B?dWI5RWFYRHpSNStRUndRQ3NyN3J3L01lZkFYelpCbGMva1d1SWh3NU9sYXhR?=
 =?utf-8?B?a0IvemlCYmZLYmRPU1lxVER1Yzd4eFN5bG04bzdDV2MwWFpGaWdKemYzMzlz?=
 =?utf-8?B?QVQ3MGtCUk54NHBrSE9rcml4MDJyY2Z1NmtEbkJDZE5neEhBbnQzL1BtU3FM?=
 =?utf-8?B?a0hFWDI1UlY5b1g5NDl3NWxWMWlBa2pEV2hJcGdFbWIyOEpFRXFCSFFMSStS?=
 =?utf-8?B?T1gzaWljeXBWY1kxOVVXemtHWUNSU2NxMjRCODRsRW9NOVdHN2RTTVlldFNC?=
 =?utf-8?B?SVU4bHZpUVBRN0F0SXJoZDQ5eTcxcEhRQVBpZWplZlY3dVdMSzBXVTVCbDdZ?=
 =?utf-8?B?Rm0vb1Y3U1lQbHQwR080dmYvdXVQZTkxd0RIcWl4WklnVi9KdjE4bS81NkVh?=
 =?utf-8?B?WDZ4RWl4Ym1XelZmbVNObzJHL1dkWjNZc0daeUN0Z21WY0tVUzA3ZVpiT2pq?=
 =?utf-8?B?ellSNjF4TEI4bG5kWHkyMnhpZWxSTUVJa2h0YnZsRVZCK1pteXdhT0hPVE54?=
 =?utf-8?B?T3JRL2kyZ0p6ZzIxK0lhZVVFSkdZemJ3ckZhd2F2KyszZ2taM3FKYVRQc01l?=
 =?utf-8?B?Q2JhK09vM1NaTTUyRXhLYWwzWTZrQlJOWGtaTlBmbWJHUWtUYXZIdjJuTS96?=
 =?utf-8?B?WldmTUhQaDBKRmlaR3I3a1lJWkhnWEQ2azZEQmV1di9XazNaVlUrVGdsKzc0?=
 =?utf-8?B?TjFaMTZzdWV3PT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6560.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SlR2a0xPL2tFRTdmZWxybVBrMXdjNi9QQy9MZjlRS29LMEpKQ2ROVjBlMjZF?=
 =?utf-8?B?ZUxCQlhsUlFoWkxaQnRKNUtLM0hQa2tBajNlZXR4SWtXVWpCMWxoQzRPbCtY?=
 =?utf-8?B?WmFqZXZzakhZSHM5Tk9lRVVCZVdDbVhzSENpNVNUdkpEK29FeWJLQ0UxMU8w?=
 =?utf-8?B?SmVzdm1rOFBGSEVSbTR2eldLK1R3NW9PVkJkOVdZQTEvYmVBQVNZd2Fidng2?=
 =?utf-8?B?KzI0M2lNZFFFVEpwZnE2bDUvcEplUTJiemNJTWxiK29idWhPNXROaGpFR2pE?=
 =?utf-8?B?NGZ5T1dISzZJSHFZS3ZFd3grNFZFUVBOZEtyWVRTZlNtMlZtMG9ISHlIU0hh?=
 =?utf-8?B?d3A2WitleWVIWXU2dmMrOFFzY1h2WFJvU3U3VkJkcXNxeHo0WTZDSzRMM0I1?=
 =?utf-8?B?S3U2eVJRTmUyZzF3dVNJSVhianNsVmVIUDZtQzZIcUwwMzRGVDI4VlBQV2Iy?=
 =?utf-8?B?YmFXV2NvdnlINUgxbWJYUXBEcGdmZW5Yd2dtZVo0bGwrcCtvcWV5c2lCTGxD?=
 =?utf-8?B?bmpzOWlMdk9nand5Z3FSSDdxZUQxZGxpUjJGVVlESW5UaUl6ZE1PTFkzeVIr?=
 =?utf-8?B?OUtiRU15dm1ObTNXS0kzekRZVGhUUG4yT21XSm5haUFQb3NwaC9MY3ZzSWNR?=
 =?utf-8?B?Y0RZbXdSUmluTml4OEZ0aUFLQ2tUa3VmMmM3WDZvVitxaFlUUytTUENUd2sr?=
 =?utf-8?B?YUNjc1pvN0ozTjNHdUkwTzdsTllMRXludlQ3d1RqNDBQelhlTU9UekhNaHRJ?=
 =?utf-8?B?bjdiMFh1NnErU1Q0M3JiTmx4WHVUU1VJOURnV2ptcWVtTEZoMmJ6VHByaERK?=
 =?utf-8?B?SXRBbnNMcWR5aThpc1IvTTdlYmhSYjd5TG0wTkVsWHI3YjN2N2xWaWZSNE94?=
 =?utf-8?B?bWtpUDRJNzJMaklRM1pvbXdMZlVuT3BYbkx3cFQzWXlqRVkwS3NncDBJSW9V?=
 =?utf-8?B?VzZ5TW5VMndOYVZ2ZEljMWFtY1d4RDkzRFBDSGZ1TjFqWTI1Vyt5a2JYN3Jl?=
 =?utf-8?B?Y2JNWVdlSWJvbkxPNjFXN25QWW1hYmNnOGFkTnY1RG0rKytVREpxancvMU5l?=
 =?utf-8?B?a0cvTlZ5MWt6NWN3L3BFbXlVUmJyNzZsZ0FXS1VHZjRjVy9rYm44bzZNcjdT?=
 =?utf-8?B?bEpyUXprVmtEMTlZa2szbjUvaFZsM0kxOU5pSWpmY3pmamNWWUZHQkVvYVNN?=
 =?utf-8?B?L2V0Mld0ZmhTVzFLV0piSjYwa2lFdHZGSVJMa0dhVWwxRmRLNUtST25MZjRz?=
 =?utf-8?B?Yjh3d1ZSY3hldTVESHFkTmgxR2Q4TUVLVGx1Z0E3MSsyU1VFbnNtUnpldC9h?=
 =?utf-8?B?L2dsWldHRG1uT2c1NmEzdEZnZVNqQW9DQm9WOE1Ba2NBeVZ6eW9wV0ZJMUg0?=
 =?utf-8?B?d0Z5UjQ4dkxqTHFTQmtIVU15V29WNzJ5Z3doRmVZTkx5WWhBNVZzTEM0bXhx?=
 =?utf-8?B?WS9PTVQ0dXIxelNZMTF0YVIyelhXNXhmb2ViOGxnajlVSFBsOHJrTk1PRDJC?=
 =?utf-8?B?NXY2OTFzSnA3WG9SWmZZRm84b1BrUkJzRU5Vay96Tk55YkkwRzNvb3NsZEVO?=
 =?utf-8?B?WnRoaVFNZEZ2Y3lPZkxXNFVUdlJEd1FHcHR6MTk3QlpFY05OTk9rR3RzVzF3?=
 =?utf-8?B?elV4dG5ubmxaUDhKbkFCSDZEcWVnTUtIbi9PUUNaMVFjMmhCTlpPQ0lKRmZp?=
 =?utf-8?B?d1I4dVlnaXBQemxBSUZoU1JMcllvTkx1eGpYeHlOOW0xSkkyeGEyWW5YQmFy?=
 =?utf-8?B?VU5sQzQ1TWRXQjB6M25TdktyTUN3THQybThrQmJiRU12TXdZdXpOZ3ExdFJj?=
 =?utf-8?B?c21ySG8veVVuMDJCcVZrbzVZY3pXVndUTURXdWVOTzFZalRWVEIzczcvZUMv?=
 =?utf-8?B?b096cWtmUlQ1MlFsdHluZ0dSS1RHc0xIcld1dS9zK1l4S1lyTTl6WXVXYmk4?=
 =?utf-8?B?ZFVBNFlTMHl3Qm9YQ2ZyWkZDOCtrbC9PeWJuNlk5Y0MwbjlFL3VzM1EwU05w?=
 =?utf-8?B?WkxUN291dk10Q0pjaEZZb0tSbXFkNVl2bE9TemNVUnNQZzhlb1ZrYlNQS3BT?=
 =?utf-8?B?TmtPWGxheXQ5bHJHR3lvZ3F3S2hIbjQ0bTl5OTYyTklGbGE4NDRQcTU3OGRv?=
 =?utf-8?Q?IgIwFe0i/pq+QYFcDrr9ixazb?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0AD6FAB542C4BF49BD0707FC0E2597B3@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6560.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02b5e000-a52c-4379-9024-08dd830ca981
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2025 08:47:36.2656
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vov8hlM94alOaEmFcDhH6Idbat9b8VYaZcvYG/u75YslCD9aa4kVHK8TLjYJ2QtMRwp+dIRnNV5LZlcYq6MfTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9679

T24gV2VkLCAyMDI1LTA0LTIzIGF0IDEwOjMwIC0wNzAwLCBNaW5hIEFsbWFzcnkgd3JvdGU6DQo+
IE9uIFdlZCwgQXByIDIzLCAyMDI1IGF0IDk6MDPigK9BTSBDb3NtaW4gUmF0aXUgPGNyYXRpdUBu
dmlkaWEuY29tPg0KPiB3cm90ZToNCj4gPiANCj4gPiBEcml2ZXJzIHRoYXQgYXJlIHRvbGQgdG8g
YWxsb2NhdGUgUlggYnVmZmVycyBmcm9tIHBvb2xzIG9mIERNQQ0KPiA+IG1lbW9yeQ0KPiA+IHNo
b3VsZCBoYXZlIGVub3VnaCBtZW1vcnkgaW4gdGhlIHBvb2wgdG8gc2F0aXNmeSBwcm9qZWN0ZWQN
Cj4gPiBhbGxvY2F0aW9uDQo+ID4gcmVxdWVzdHMgKGEgZnVuY3Rpb24gb2YgcmluZyBzaXplLCBN
VFUgJiBvdGhlciBwYXJhbWV0ZXJzKS4gSWYNCj4gPiB0aGVyZSdzDQo+ID4gbm90IGVub3VnaCBt
ZW1vcnksIFJYIHJpbmcgcmVmaWxsIG1pZ2h0IGZhaWwgbGF0ZXIgYXQgaW5jb252ZW5pZW50DQo+
ID4gdGltZXMNCj4gPiAoZS5nLiBkdXJpbmcgTkFQSSBwb2xsKS4NCj4gPiANCj4gDQo+IE15IHVu
ZGVyc3RhbmRpbmcgaXMgdGhhdCBpZiB0aGUgUlggcmluZyByZWZpbGwgZmFpbHMsIHRoZSBkcml2
ZXIgd2lsbA0KPiBwb3N0IHRoZSBidWZmZXJzIGl0IHdhcyBhYmxlIHRvIGFsbG9jYXRlIGRhdGEg
Zm9yLCBhbmQgd2lsbCBub3QgcG9zdA0KPiBvdGhlciBidWZmZXJzLiBTbyBpdCB3aWxsIHJ1biB3
aXRoIGEgZGVncmFkZWQgcGVyZm9ybWFuY2UgYnV0IG5vdGhpbmcNCj4gb3Zlcmx5IGJhZCBzaG91
bGQgaGFwcGVuLiBUaGlzIHNob3VsZCBiZSB0aGUgc2FtZSBiZWhhdmlvciBpZiB0aGUNCj4gbWFj
aGluZSBpcyB1bmRlciBtZW1vcnkgcHJlc3N1cmUuDQoNCldoYXQgbW90aXZhdGVkIHRoaXMgY2hh
bmdlIHdhcyBhIGZhaWx1cmUgaW4gaG93IG1seDUgcmVmaWxscyByaW5ncw0KdG9kYXkuIEZvciBl
ZmZpY2llbmN5LCByaW5nIHJlZmlsbCB0cmlnZ2VyZWQgYnkgTkFQSSBwb2xsaW5nIG9ubHkNCnJl
bGVhc2VzIG9sZCBidWZmZXJzIGp1c3QgYmVmb3JlIGFsbG9jYXRpbmcgbmV3IG9uZXMgc28gZWZm
ZWN0aXZlbHkgaGFzDQphIGJ1aWx0LWluIGFzc3VtcHRpb24gdGhhdCB0aGUgcmluZyBjYW4gYmUg
ZmlsbGVkLiBDb21taXQgNGMyYTEzMjM2ODA3DQooIm5ldC9tbHg1ZTogUlgsIERlZmVyIHBhZ2Ug
cmVsZWFzZSBpbiBzdHJpZGluZyBycSBmb3IgYmV0dGVyDQpyZWN5Y2xpbmciKSBpcyBhbiBpbnRl
cmVzdGluZyByZWFkIGhlcmUuDQoNCkZvciBtb3JlIGRldGFpbHMsIHNlZSB0aGUgZG97IH13aGls
ZSBsb29wIGluIG1seDVlX3Bvc3RfcnhfbXB3cWVzLA0Kd2hlcmUgbWx4NWVfZnJlZV9yeF9tcHdx
ZSB0aGVuIG1seDVlX2FsbG9jX3J4X21wd3FlIGFyZSBjYWxsZWQgdG8gZnJlZQ0KdGhlIG9sZCBi
dWZmZXIgYW5kIHJlYWxsb2NhdGUgYSBuZXcgb25lIGF0IHRoZSBzYW1lIHBvc2l0aW9uLiBUaGlz
IGhhcw0KZXhjZWxsZW50IGNhY2hlLWxvY2FsaXR5IGFuZCB0aGUgcGFnZXMgcmV0dXJuZWQgdG8g
dGhlIHBvb2wgd2lsbCBiZQ0KcmV1c2VkIGJ5IHRoZSBuZXcgZGVzY3JpcHRvci4NCg0KVGhlIGJ1
ZyBpbiBtbHg1IGlzIHRoYXQgd2l0aCBhIGxhcmdlIE1UVSAmIHJpbmcgc2l6ZSwgdGhlIHJpbmcg
Y2Fubm90DQpiZSBmdWxseSBwb3B1bGF0ZWQgd2l0aCByeCBkZXNjcmlwdG9ycyBiZWNhdXNlIHRo
ZSBwb29sIGRvZXNuJ3QgaGF2ZQ0KZW5vdWdoIG1lbW9yeSwgYnV0IHRoZXJlJ3Mgbm8gbWVtb3J5
IHJlbGVhc2VkIGJhY2sgdG8gdGhlIHBvb2wgZm9yIG5ldw0Kb25lcy4gRXZlbnR1YWxseSwgcngg
ZGVzY3JpcHRvcnMgYXJlIGV4aGF1c3RlZCBhbmQgdHJhZmZpYyBzdG9wcy4NCg0KPiBJbiBnZW5l
cmFsIEkgZG9uJ3Qga25vdyBhYm91dCB0aGlzIGNoYW5nZS4gSWYgdGhlIHVzZXIgd2FudHMgdG8g
dXNlDQo+IHZlcnkgc21hbGwgZG1hYnVmcywgdGhleSBzaG91bGQgYmUgYWJsZSB0bywgd2l0aG91
dCBnb2luZyB0aHJvdWdoDQo+IGhvb3BzIHJlZHVjaW5nIHRoZSBudW1iZXIgb2YgcnggcmluZyBz
bG90cyB0aGUgZHJpdmVyIGhhcyAoaWYgaXQNCj4gc3VwcG9ydHMgY29uZmlndXJpbmcgdGhhdCku
DQo+IA0KPiBJIHRoaW5rIG1heWJlIHByaW50aW5nIGFuIGVycm9yIG9yIHdhcm5pbmcgdGhhdCB0
aGUgZG1hYnVmIGlzIHRvbw0KPiBzbWFsbCBmb3IgdGhlIHBvb2xfc2l6ZSBtYXkgYmUgZmluZS4g
QnV0IG91dHJpZ2h0IGZhaWxpbmcgdGhpcw0KPiBjb25maWd1cmF0aW9uPyBJIGRvbid0IHRoaW5r
IHNvLg0KDQpGb3IgcmVndWxhciBtZW1vcnktYmFja2VkIHBhZ2UgcG9vbHMsIHRoZXJlJ3Mgbm8g
aGFyZCBsaW1pdCBvZiBob3cgYmlnDQp0aGV5IGNhbiBiZWNvbWUgKGV4Y2VwdCBhdmFpbGFibGUg
cGh5c2ljYWwgbWVtb3J5KSwgc28gdGhpcyBpc3N1ZSB3YXMNCm5vdCBzZWVuIGJlZm9yZS4NCg0K
SSBkaWRuJ3QgbG9vayBhdCBvdGhlciBkcml2ZXJzIHlldCwgYnV0IGlzIGl0IGV4cGVjdGVkIHRo
YXQgZHJpdmVycw0Kb3BlcmF0ZSB3aXRoIGluY29tcGxldGVseSBmaWxsZWQgcmluZ3M/IEkgYXNz
dW1lZCB0aGF0IHNpbmNlIHRoZSB1c2VyDQpjb25maWd1cmVkIGEgc3BlY2lmaWVkIHJpbmcgc2l6
ZSwgaXQgZXhwZWN0cyBkcml2ZXJzIHRvIGJlIGFibGUgdG8gdXNlDQp0aGF0IHNpemUgYW5kIG5v
dCBzaWxlbnRseSBvcGVyYXRlIGluIGRlZ3JhZGVkIG1vZGUsIHdpdGggYSBzbWFsbGVyDQpyaW5n
IHNpemUuDQoNCklmIHlvdSB0aGluayBkcml2ZXJzIHNob3VsZCB3b3JrIGluIGRlZ3JhZGVkIG1v
ZGUsIHdlIGNhbiBsb29rIGF0DQppbXByb3ZpbmcgdGhlIHJpbmcgcG9wdWxhdGlvbiBjb2RlIHRv
IHdvcmsgYmV0dGVyIGluIHRoaXMgc2NlbmFyaW8uDQoNCj4gcG9vbF9zaXplIHNlZW1zIHRvIGJl
IHRoZSBudW1iZXIgb2YgcHRyX3Jpbmcgc2xvdHMgaW4gdGhlIHBhZ2VfcG9vbCwNCj4gbm90IHNv
bWUgdXBwZXIgb3IgbG93ZXIgYm91bmQgb24gdGhlIGFtb3VudCBvZiBtZW1vcnkgdGhlIHBhZ2Vf
cG9vbA0KPiBjYW4gcHJvdmlkZS4gU28gdGhpcyBjaGVjayBzZWVtcyB1c2VsZXNzPyBUaGUgcGFn
ZV9wb29sIGNhbiBzdGlsbCBub3QNCj4gcHJvdmlkZSB0aGlzIGFtb3VudCBvZiBtZW1vcnkgd2l0
aCBkbWFidWYgKGlmIHRoZSBuZXRtZW1zIGFyZW4ndA0KPiBiZWluZw0KPiByZWN5Y2xlZCBmYXN0
IGVub3VnaCkgb3Igd2l0aCBub3JtYWwgbWVtb3J5ICh1bmRlciBtZW1vcnkgcHJlc3N1cmUpLg0K
DQpJIHRoaW5rIHBvb2xfc2l6ZSBpcyB1c3VhbGx5IHNldCBieSBkcml2ZXJzIGJhc2VkIG9uIHRo
ZWlyIHBhcmFtcywgYW5kDQppdCdzIHRoZSBtYXggc2l6ZSBvZiBwb29sLT5yaW5nLiBUaGUgb3Bw
b3J0dW5pc3RpYyBjaGVjayBJIGFkZGVkDQpjb21wYXJlcyB0aGlzIGRlbWFuZCB3aXRoIHRoZSBz
dXBwbHkgKGF2YWlsYWJsZSBjaHVuayBtZW1vcnkpIGFuZCBmYWlscw0KdGhpcyBjb25maWcgYmFz
ZWQgb24gdGhlIGFzc3VtcHRpb24gdGhhdCB0aGVyZSBzaG91bGQgYmUgZW5vdWdoIG1lbW9yeQ0K
aW4gdGhlIHBvb2wgdG8gc2F0aXNmeSBkcml2ZXIgbmVlZHMuDQoNClBsZWFzZSBsZXQgbWUga25v
dyB5b3VyIHRob3VnaHRzIGFuZCBob3cgdG8gcHJvY2VlZC4NCg0KQ29zbWluLg0K

