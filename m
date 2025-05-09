Return-Path: <linux-kselftest+bounces-32731-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 14E73AB0B9E
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 May 2025 09:25:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BF83179696
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 May 2025 07:25:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0595126C3A7;
	Fri,  9 May 2025 07:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OTzxJdsb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2069.outbound.protection.outlook.com [40.107.236.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FD9C26AABA;
	Fri,  9 May 2025 07:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746775506; cv=fail; b=gQQzQXfBv/5rQ/hMrsoMkE5hNTpnxnWCW97M6aqNofC8vpVqHjJ92t+5JQigMHPKxRILJ4S+MyLFrY9j5eP2YuUOuaqyJqWl+UVPlGpfZYZzuouOXb0yXv+5oMYWcHzkW2VMaEOV+Rlko1htriB2OXWxyrP3Vl0/NcTOMertIOQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746775506; c=relaxed/simple;
	bh=D4exOAYVfOB03l0TIxSXfec/9PFmwIW5iCBXLn1V3cg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HSr/RUKdlBe4C+PPQOT8AY30YOCxnkbWVmvvk4G94fsCMMTU1SShd7KKaIZrSVdzXhYtNMTUIQqLoVz9zg3PDJPqKKEobATStXlmF038sGhXlXprX+csXgRPF4jcLL+qHCXGqE0qofiRi1t3A27XhkmrNXoPKm7iYl+uLbvf7Sk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OTzxJdsb; arc=fail smtp.client-ip=40.107.236.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RHg+0eNKU+SbdzKSjekcl8TX73iPum9pGxIKvO/RtrXFkPARRA0la6Yqt2WDE2++ononUBqbHKDZFRBRNcMApkOjJ4EYiVy4KHONGIpk6HfsTsB4bgD9zbydWImePNJDMeN5ndHUFzOnw33YZhJInGd6KYOAEdEOPr8FDjHNjmWcbwCN9t/soeHezka2dsyEei+nKi57zRP7xVlJk3j/+Etha9wS9tNgySzD53BWjJF2EtGWzldE4UdrsOoaa/iWJDSYsUU+6VLgvKbrKpKD1+51Z4aj1yU7KP1m4+7+y3bFQGNhGHqPUZA58nh0DlAvIYOtM97493PpprhEC3P8BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D4exOAYVfOB03l0TIxSXfec/9PFmwIW5iCBXLn1V3cg=;
 b=mDOUzZh/wbxGPcgkWrWhctwjRVcpHb9DJ4NHt78GhMJXD0U1LtWlTJpayu4fBvi20o3sHZ89IQpm/E+9v9DtHQx4k4txRzvVT7lh0joEGV4zVc6TpJYvJ8QjqqxDH/leKfQsB0LnK5Jy01kkpze4JzZ1bY/ekQCs79dOx1azfaifx7ckiZqSwJJgQJXGTufrVWhw9sOJvEAhhVV8uLxz2aTohIdEgTua7j5AzCtzm6yhZw97wUB+CtaDZFT5jE5/5SamzfngoRO9+K8aS7xL/+O7P9np2Plke3wGhuWTDLYQ2LOFo1vGxwU62BJ4oZnYu0R5K0s8VjbuQTDZVc8ENA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D4exOAYVfOB03l0TIxSXfec/9PFmwIW5iCBXLn1V3cg=;
 b=OTzxJdsbSS9m1VjIj95ENeuJLBnnZjrLCAGpknB4qn+DB62bAIWjgcd9W385vUrxGWQSNpFjR91lmN2BRyKhb/0lho7bmIR36YGZBRH5K6nfOYD6OKMdfAZOjEX5EtFWbMDXcD/RFo+DXPJT3irb3GbuTfQRkQ0NJV6tdZycOm8NG7G+cgs4gm9VMhpk0yJoDPjQGNRVg7mML2yKBuAREwyeaUCRH8xnWIYooQVzjkaiPvxh56LU/o0U8n6W1lqlFvwI8Sxu3OCyEnL/sZGpVI+3ysUnmITte4Bq2gkQjN/wdTu+UqyKb7CYJ+0VZAYyfS23zsuOSbW7bHjxG+s01Q==
Received: from DS5PPF266051432.namprd12.prod.outlook.com
 (2603:10b6:f:fc00::648) by SN7PR12MB6790.namprd12.prod.outlook.com
 (2603:10b6:806:269::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.24; Fri, 9 May
 2025 07:24:57 +0000
Received: from DS5PPF266051432.namprd12.prod.outlook.com
 ([fe80::a991:20ac:3e28:4b08]) by DS5PPF266051432.namprd12.prod.outlook.com
 ([fe80::a991:20ac:3e28:4b08%6]) with mapi id 15.20.8655.033; Fri, 9 May 2025
 07:24:57 +0000
From: Cosmin Ratiu <cratiu@nvidia.com>
To: "almasrymina@google.com" <almasrymina@google.com>
CC: "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "jdamato@fastly.com" <jdamato@fastly.com>, Tariq
 Toukan <tariqt@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>,
	"shuah@kernel.org" <shuah@kernel.org>, "sdf@fomichev.me" <sdf@fomichev.me>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>
Subject: Re: [PATCH net v2] tests/ncdevmem: Fix double-free of queue array
Thread-Topic: [PATCH net v2] tests/ncdevmem: Fix double-free of queue array
Thread-Index: AQHbv/WIgVX6+V0IbkCpxG+F980BrbPJM4YAgACzc4A=
Date: Fri, 9 May 2025 07:24:57 +0000
Message-ID: <6b7181f9866e357116e11d834040f6d927f6b201.camel@nvidia.com>
References: <20250508084434.1933069-1-cratiu@nvidia.com>
	 <CAHS8izMkqMr6r6nYeDH9BgLWrf5_DsCibcg6-BcRhZiJQqiTyg@mail.gmail.com>
In-Reply-To:
 <CAHS8izMkqMr6r6nYeDH9BgLWrf5_DsCibcg6-BcRhZiJQqiTyg@mail.gmail.com>
Reply-To: Cosmin Ratiu <cratiu@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS5PPF266051432:EE_|SN7PR12MB6790:EE_
x-ms-office365-filtering-correlation-id: 3c68054a-7d39-4ea3-abe2-08dd8eca99ca
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?SUgzRjQ0ZVVXMTlaZS9ZSktnaldXU1p4bXR3eEl0NHcvdE1DeWhTaGNWc0VL?=
 =?utf-8?B?bUtjejlzNGhCZVBmY0R5QzhjcDFmQ3dyZytCeUx1WkNLeFpLZjR2NHZPZnhk?=
 =?utf-8?B?T0lPclR1MHB4N0xpUTlpdjFieUkrTGlCY1FTbmZXZ0huWG9hZ2x4Nm9icWpv?=
 =?utf-8?B?eFBtNjdCMHZwTGN6SHlSWkQ0N0cvcW90TVpURTRSdlBKd1kvVHEzeDZhTHNz?=
 =?utf-8?B?Nk5ud0dlbEdFY2thcm1QVGYrQmliWUNoSEcxNWdTSW9uYzg1RjJJUThxdzB3?=
 =?utf-8?B?bEk5TmpsREhHc3orUHZ2VThWa3IzS3VwTEFPNjN4VktPZXAxQlVsdWhvL1ZK?=
 =?utf-8?B?QlAxMSs3VG5EWGVDb2tLSmNXcWh4d0tWYmJMWUd4aDlmOGp2L0hLQmNiZVZM?=
 =?utf-8?B?M2I0cytVQXFWY1VkS2lkRUFzZlJFUVoxVTE2bXJ0djR5cHhsUXYrRjl5ZlNt?=
 =?utf-8?B?Z0NqZ2xPbEVnRmhjekpxT25yKzZBSWJzVzRZUVlMQUhrdW9UakcrYjllcVFH?=
 =?utf-8?B?T09pWlh4M3lyK2VnVDNSSkZEYUhYcnBHVGFtbVVtb0I4OXlOS05hcG45M0xB?=
 =?utf-8?B?U3MvWURtaSsyVzBQeXkzSlFEc2pkcjJ5anVWSVZPaVBYbGYvcjRvYmM0M3Zt?=
 =?utf-8?B?cTlsV3lrTlBkZDlDMC9XVVkzNUJ3ZjZBNnc5cHpRWDdMb0RNRVk5VFo0RGU3?=
 =?utf-8?B?Z3ZBRXpCcmhLejNYcEpZdlNuUVUwVXpQQVdDa2RoeHZ1eEp6a05UM0dyc0tl?=
 =?utf-8?B?OTV1RGRHREE4YlRpMjBCR2FVVUZFbGNyWWcvd2dKT0tROTVZbE5GS2gvMFQy?=
 =?utf-8?B?bFJiN1V5MjRhMEo1L1Bhb0JsTW9wMUVpVXZzSFBDWURZMjhLWjYwNnlvYWxk?=
 =?utf-8?B?U1djSDlsVG1ISFJnN0lnUnBRRVNCUG1PcVhyclFnclJRS0RiVmlDZFZqNGVQ?=
 =?utf-8?B?U3VKYVJOSWozV0d5WjhzN1B3Q1g2Q2hCZFNPdml3aDkvYkZxckNmMmpjejZL?=
 =?utf-8?B?cllGOURQNjFVckF2UUNiaUVsYUh3L2IxUDE4a1hvTys3Q0VublEzUnRRL0Zj?=
 =?utf-8?B?QWxBL1orTXRRYkhic2JpWUEyV1BnWHI0ODErbXZYK2RqTCtnZ1BuU2VhM0dG?=
 =?utf-8?B?SHd3dmlIUkE3aGhWRzM4VEpMUEd4UTBuOExmZXEvQ1ZLd0p3QmNpWkFlOXFz?=
 =?utf-8?B?MmRrUGpsMmdkcnpQUm4vN3hpeXdFcVptQ0RwN0hUaDNoUTFnVFJlRTczRmhF?=
 =?utf-8?B?VW5HLzk4ZTh5T01tVlp4dmY1QTk0VlRUdUZzYnRnRFdlMmdTODgzcndTZG1z?=
 =?utf-8?B?V0lyY2pwL0EzcyttZnVHcVpmaVU4VGlJRHppdC9MUk1xN0xQbWFkK3pPaEpu?=
 =?utf-8?B?dzlJcHU3KytuM2xBUUhUOS9RRElhMUViZVU1RTgySlVzU082eTdYNWpacTJt?=
 =?utf-8?B?VzhNaitTOFJwY01zVUxTcGVaWHA5cytNMEY2bm1JdDR3YnpkY1MwUEs4dFdX?=
 =?utf-8?B?NlBtSmwwcnZYQ3FlK3FFMFF6d1JaWjNTMTNZRHhtY3JCZkU0VHpIc2tWUThi?=
 =?utf-8?B?a0xFTUZrQTJZY1d0ZjVacWNCNmt6L3kyR0kyM2FMcTcrQ05wc3l3Q01rdUZj?=
 =?utf-8?B?VEhHak9DNStSYXpzZDBZU2lsTWd6eXl2Tng2cXpsOUIrU3pkdXM3dXNOWlQ2?=
 =?utf-8?B?OENlaTZsa281cFhMV3RpZkFPY2NKMWlJOUtKZTBLMzlPMnR0Nzd1NW9zbFFU?=
 =?utf-8?B?eFdOdjlsaE9GZEhzUjdjWm5jcFd6M1hOZHlyL1dLTmFmKzVidkFldTc2ajJF?=
 =?utf-8?B?T3c5bmYrR0NYeVRZUUxhUi8wYmVRUGhBL0wzQlM0RkM0UFZMSkNlNkQ2M1kr?=
 =?utf-8?B?UzBFS2FiSW02M09nMTgyaVB6RzhYVGFzdHhoQ00zSklXb2RUcVFwNzNPK1Za?=
 =?utf-8?B?eWF5eE55V3FzWnpHR1ZkVVFYY3lhYSs1dUVoQXVXOFZuNWdBUFVTSFJ6T3Ft?=
 =?utf-8?B?T3VpU0NNZXBRPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS5PPF266051432.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dk5pYTljOHdwUGVPME9OcXJmUGx5RTVlQUNuVDJQajcwYmtXWTR6enRERThN?=
 =?utf-8?B?OHpWdDZ1cHY1OXhKWnZ4NU9aVzJXb0FZeUM3dSs3Ui83Tm00QUkwbFE0a2Z4?=
 =?utf-8?B?V0UyNExVUnlxelVXcmgyYmg5R05IRVlId0huTUFwNVBkOVpMdm5xRTBzenUx?=
 =?utf-8?B?UWNONmYwTGo1ZXA4RUdDMDJZMFhCNUh0TUVremRoS05Bc3E1V0cxQVA3YzA3?=
 =?utf-8?B?UXdvUDNCTjlFYzI2a0pkc2xCbGtDTzhSVzlIN25QNmlsR2FQbFhNOWxoWVpM?=
 =?utf-8?B?Z1A2VkhiN1JXLzJoNTJZY3lUZXNrQjRrdzdMWkdib2l0R2prVmZNbXA0dWtL?=
 =?utf-8?B?YW81dThnYllmY3ZOSHFNM1RFdVQzVE0xY0ttWkdFNXh2OFN3VUdtT01LRjJz?=
 =?utf-8?B?cXg3NGVGTGFRUDB3SjUxT2ZRNnByMWMxZXpTakJ2MUU3WDgyeG1aWjFTMnRZ?=
 =?utf-8?B?eFIycTJhc0JqU1pncjdsMmxEQjYwRXpkZk4xVzN0V0RyWm9TUG9hN2pNTWdI?=
 =?utf-8?B?Wk9UNS8xNHJ4N25tK0JsRzZncDROK1h0d29BY0VPd0FTVVVpYzlQUHFjek41?=
 =?utf-8?B?ZlJmdmZUZ28wV2FkT0Y5MExjQ2NxZzc3WDlYQ2Jwaml0ZXB0N3NnWUxVb3VN?=
 =?utf-8?B?OVQyblBjZCtWOXlJS0tGbXRwTjRURFhuWUxuaTdqcHJQbmErakFRbVdRdll0?=
 =?utf-8?B?TmRsbXlUYS8ydzI1V3ZNRExNYVM3VkJ2dEI3cWhxZ2xsbUdlNHY5QzNwNUMw?=
 =?utf-8?B?a1Z4NXpHcysvL2pjdUpEckMrMnNlblFyQ21LNUZvYmYyaGNMQXpQSjlXbFJM?=
 =?utf-8?B?UERwWldXb3QvQmg2T2F3S0F6TmFCLzZOOWh4ZlRaem84TDhaZWJhVTFneGhw?=
 =?utf-8?B?WXZjTDMwS3hjUjBnS0xhVUpYMitsTG43bmwxV3ZCaDVNQktrYlhHcFFBbnlS?=
 =?utf-8?B?bUJLdS94K2NKQ3gzTGM4NFFhN3dHY3F3dW1IOHhkSHhlbHhNL3Z0ZEZiUjNR?=
 =?utf-8?B?WFBadFZOVStwRU9udlFYbkVVZjBXUmdTRy9Ua0ViN2tMQWdvcUpDcXpqRHcz?=
 =?utf-8?B?TW1xb1Zhb1BCOEZSWU5ldXl1ZjdzOFM1NDlTWUQ4YUZyUU1na21hWjNEZ0ZS?=
 =?utf-8?B?NUxsQUtvY1Z1RzVlZzNlU1dhaStJTFpwVWwveERqQzJkdE1xOHUzK29oWC9U?=
 =?utf-8?B?WWovREliazlkWUpXZW41eFNaTzhpbzJ3YVdwUGtJQjJ5QTFGWnBPeTVwcGtw?=
 =?utf-8?B?YXc3NUh5Q2FvelZBM0NCdDU5NXlrUjd5dWFWMm9nQzlnVXFvNHFIZmNvS0ZD?=
 =?utf-8?B?a3A5MW5OeGVORVdqV3hyQ0JJbkJaa0VRNFJUUk0xRENWU1o2cVNDOHVGOHlq?=
 =?utf-8?B?QVpabWFoVXkzeEdCeFBaY0ZpanVqMWFSdFIxU0g4Zk1RTEJ2TjBvcGNwMXV2?=
 =?utf-8?B?c1VxbHZxdjVMc3JKL1hnMEJzaFFYUGlxemlIdEhiaElFaDZCak9oaWNPUVd3?=
 =?utf-8?B?NDhSaUhIRXM5WUJOQm1XdjY4SUJZcFU2aUZWRHp0aHhrRVdLeXp0UUNzY21t?=
 =?utf-8?B?M0xVUE0rZ2pGbDViaGMyS2NyK1RKNVlDRFNBN2xQOU55bkFkaXpHWDllL1Nr?=
 =?utf-8?B?ZEs1cDA4MS9scDdkUjc5UjRsT084ZDA3VFovYllyaDN3WWxpZ1VrbUMyN29F?=
 =?utf-8?B?enRIb0JMZktYU3g3ZkVlbXFnNGpvejZDZFM0bnZTV1FHT0NhdFRiK2cwSzlS?=
 =?utf-8?B?YXgzWHdLR2F5bUtTQ2FITWlIS0VjUklNZCs3SkpHZWxUdFVFcEpzUUJLU2Ew?=
 =?utf-8?B?Ynh6UFJEOGI0dXhWL012RU5IU0cxU2UvMlFkM0FPd3FnZHdxWjVaTzlncUlE?=
 =?utf-8?B?MXhtV0VzSmllS0pHS3U1Q3ZlcW5KNTdpZlREeVY5MkhxRk5UeGFvN1Yra0di?=
 =?utf-8?B?UVAzTzZYSmNkSmZacHN0L0N3YlRyaVM3YjU1OFl4clZRSkNOSXMvVmhlTlZy?=
 =?utf-8?B?c2VFenY3SHFwTUlSY05maENRemM5bW42YjJ4SUxKNjVOVUFGTjZWRFlXaUtB?=
 =?utf-8?B?WjZVL3Rod0hmU3ViakRJWkpZRnh1U2dQdVZwK0NZMmFSeUROTkNMM25TUVNR?=
 =?utf-8?Q?RLdN2xNcXPLcO4pSrR2RP7lAt?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D107821DB2007241A9175C8C76C53C13@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS5PPF266051432.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c68054a-7d39-4ea3-abe2-08dd8eca99ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2025 07:24:57.0952
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vA9tA+2eG0hV8oOBt0wEVv/aXuj8QSgHLrC+m90N9MC4P8Rnktg6By2lbkIUPX9tzPeFHqkNGjBN9rpnR2x3tA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6790

T24gVGh1LCAyMDI1LTA1LTA4IGF0IDEzOjQyIC0wNzAwLCBNaW5hIEFsbWFzcnkgd3JvdGU6DQo+
IA0KPiBUaGFuayB5b3UgdmVyeSBtdWNoLg0KPiANCj4gUmV2aWV3ZWQtYnk6IE1pbmEgQWxtYXNy
eSA8YWxtYXNyeW1pbmFAZ29vZ2xlLmNvbT4NCg0KVGhhbmsgeW91IGZvciB0aGUgcmV2aWV3Lg0K
DQo+IA0KPiBBbHNvLCBJIHRoaW5rIHRoZXJlIHdhcyBhIGRpc2N1c3Npb24gaW4gdjEgYWJvdXQg
aW5jcmVhc2luZyB0aGUNCj4gYW1vdW50DQo+IG9mIG1lbW9yeSB0aGF0IG5jZGV2bWVtIHVzZXMg
YnkgZGVmYXVsdCAoY3VycmVudGx5IGl0J3MgNjRNQikgYXMgU3Rhbg0KPiBzdWdnZXN0ZWQuIEkg
aGF2ZSBpdCBpbiBteSBUT0RPIGxpc3QgdG8gaW1wbGVtZW50IHRoYXQgY2hhbmdlIGJ1dCBJDQo+
IGRvbid0IHRoaW5rIEknbGwgZ2V0IHRvIGl0IHNvb24uIElmIHlvdSAob3IgYW55b25lKSBnZXRz
IHRvIGl0IGJlZm9yZQ0KPiBtZSwgaXQncyBhIHdlbGNvbWUgY2hhbmdlLiBBRkFJVSBpdCdsbCB1
bmJsb2NrIHlvdSBmcm9tIHJ1bm5pbmcNCj4gbmNkZXZtZW0gb24geW91ciBkcml2ZXIgd2hpY2gg
ZXhwZWN0cyBtdWNoIG1vcmUgZG1hYnVmIG1lbW9yeQ0KPiBhdmFpbGFibGUuDQo+IA0KPiBCdXQg
dG8gYmUgY2xlYXIsIHRoYXQgY2FuIGJlIGEgZm9sbG93IHVwIGNoYW5nZS4gSSB0aGluayB0aGlz
IGlzIGdvb2QNCj4gYXMtaXMuDQo+IA0KDQpJIGRvIHBsYW4gdG8gZm9sbG93LXVwIG9uIHRoYXQg
dG9waWMsIG1seDUgd2lsbCByZXF1aXJlIHNvbWUNCnJlZW5naW5lZXJpbmcgdG8gbm90IGZhaWwg
cnggcmluZ3MgcmVmaWxsIHdoZW4gdGhlIHBvb2wgaXMgdG9vIHNtYWxsLA0KYW5kIG1vc3QgbGlr
ZWx5IHNvbWUgdG91Y2gtdXBzIGluIG5jZGV2bWVtL3VkbWFidWYgdG8gbWFrZSB0aGlzIGJldHRl
ci4NCg0KQ29zbWluLg0K

