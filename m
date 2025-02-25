Return-Path: <linux-kselftest+bounces-27459-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E081A4419C
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Feb 2025 15:02:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A52E517315F
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Feb 2025 14:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A20B326A0F8;
	Tue, 25 Feb 2025 14:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OIpQqyAe"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2052.outbound.protection.outlook.com [40.107.95.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C8D826A090;
	Tue, 25 Feb 2025 14:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740492011; cv=fail; b=cthaqjoIGjwNyj9YAshn3ZEN2SZQ/58y2gllnnB3BMwAkenKqc6R9n419eWuL8IKypP/okzGxp68rIqwdRkCJRz7PAIxW2KKNvI28PAvEZ4OQsUU2/1WNJ3/KjO2EnjbasyNygp/nCPeIT62+Uqpgk3hsoYwAR1Ie3FOCcQi3QM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740492011; c=relaxed/simple;
	bh=ncexXzzxnN78BfO4FwslEN5V5GnXmqjzlbdDr8vVKi8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=a2DhfD/YW2TNUBwF+/mBXrXOT5zpGu3r8iOKFClqqZWB4LT3RTHf/2/cGajYiFvsbaozDjf7KY0qyXHSFHRy1RzMa6wHqeQRGZz8dnryWpb/rgUsK5RfCiwhjoCM5puPFt1zAgoGJLYU54xqUSm3BRzbs9OBeZwjani775FA5Tk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OIpQqyAe; arc=fail smtp.client-ip=40.107.95.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q4h1F7jjuAwgZ9afl6Z5AhB/mKBujyW0DK1Q9oI94Hnvn4WCbM2odX3XqHsgjAITMaKTLPl8sLSiOxxhfuDaiLmw1p/OiWh2d8DSddjLlmFrbSzCPuPISBWtRiSxVoVwWXGTkQ/+nx6oUIXB9CJa303dj4m8QmIqYHwdpn7TNN1LlgOiNJXl4NoZcxc82fVX+AQrKAElk9P9W4ELNAL+TJHP00J6CLO9oOoLbjTwqW+wrrGg0x62elBxlc0K2JGjR25AnM0SdJJzsXpj5c1aZFM913qvTLP9u5NDINzNJIEiR2Gz8Geant14RbhmPREv3SrBlEwfILZvJS2mi8UmQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ncexXzzxnN78BfO4FwslEN5V5GnXmqjzlbdDr8vVKi8=;
 b=WWCxb21mvuN/8oOJ12lu3PzA6f9yMwdP1E38NhPBJ2mAr/6Ii3/xJMsFJIBzLvy8PnPckxOhkbMy+V6m0NzRBWtXoUYpxn4zcknU+z8iDGHcMYf1yHsyOiPFiHqgrmX4EJ97tBt1Gpd2gwL0wBtCawYmfN4uouuntVwMTde53izmckdIdOFqH9tIp57ckLZwRojLjZo8bF1gYVQFUExJRe1odRb1FOofoGQ2t22fkmp0xsO5ICcaFR9TRmtDPDSqx0n70DzMKw9Y1ZkNMY1SNeRQwm9simxsYEdxAAuHOE+pq/SEcNzoVE4AuaUWSgnukTZChqimIo2eEJ3r6vB8kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ncexXzzxnN78BfO4FwslEN5V5GnXmqjzlbdDr8vVKi8=;
 b=OIpQqyAeIxkq8eLQcO08nSoFz7oAz/A0jzs3PhpGZXc36WPUVsSxkkCfY25Vgy9C/OUTfv494Vl29FzLMu0Mmn6APSe5yn32L2E+++Ar71z6cZwOiA+A9eUqRyPWsOMC1A3VKjpol/3KGwhWuA0c2uCDAyrVhX4Jq53prz+hlvjRvwByEGhFfxclMiiVJg45y7MMinKrRj0K56G5ZXjhfHFfTpSSHTcAqcJS/uWTePoAOQ7pms386ItPcabcDos96rhYNck5QB7c1NrQbS7X5p37Hs6gpNdaoN3YVSGuY42jbjpBn5c4u2MpqJNpIlN1eCVVISdnJxW8mAkyW+YkoQ==
Received: from DS0PR12MB6560.namprd12.prod.outlook.com (2603:10b6:8:d0::22) by
 MN2PR12MB4141.namprd12.prod.outlook.com (2603:10b6:208:1d5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Tue, 25 Feb
 2025 14:00:06 +0000
Received: from DS0PR12MB6560.namprd12.prod.outlook.com
 ([fe80::4c05:4274:b769:b8af]) by DS0PR12MB6560.namprd12.prod.outlook.com
 ([fe80::4c05:4274:b769:b8af%4]) with mapi id 15.20.8466.016; Tue, 25 Feb 2025
 14:00:06 +0000
From: Cosmin Ratiu <cratiu@nvidia.com>
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "liuhangbin@gmail.com"
	<liuhangbin@gmail.com>
CC: "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "jarod@redhat.com"
	<jarod@redhat.com>, "razor@blackwall.org" <razor@blackwall.org>,
	"davem@davemloft.net" <davem@davemloft.net>, Tariq Toukan
	<tariqt@nvidia.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "shuah@kernel.org" <shuah@kernel.org>,
	"steffen.klassert@secunet.com" <steffen.klassert@secunet.com>,
	"jv@jvosburgh.net" <jv@jvosburgh.net>, "pabeni@redhat.com"
	<pabeni@redhat.com>, "horms@kernel.org" <horms@kernel.org>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, Jianbo Liu <jianbol@nvidia.com>
Subject: Re: [PATCHv2 net 1/3] bonding: move mutex lock to a work queue for
 XFRM GC tasks
Thread-Topic: [PATCHv2 net 1/3] bonding: move mutex lock to a work queue for
 XFRM GC tasks
Thread-Index: AQHbh2ll1/r6krzjmEu6zwJW6lI7lLNYDFAA
Date: Tue, 25 Feb 2025 14:00:05 +0000
Message-ID: <d298da7bc638c323e6d492b2dec7f1b9ea1e1350.camel@nvidia.com>
References: <20250225094049.20142-1-liuhangbin@gmail.com>
	 <20250225094049.20142-2-liuhangbin@gmail.com>
In-Reply-To: <20250225094049.20142-2-liuhangbin@gmail.com>
Reply-To: Cosmin Ratiu <cratiu@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB6560:EE_|MN2PR12MB4141:EE_
x-ms-office365-filtering-correlation-id: ba48ef3b-eebf-48fe-8296-08dd55a4b530
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZW9zbXJmU1JYNXRMaG9ZaEJUMmtjVU44R0hrRktEQzFCYkhESzhCdm8vajdx?=
 =?utf-8?B?NWZubklacFRNYmREbVdjQlA2L3BPbHQvekZzYnVtNFQ2TEVjL2k5L2twdWpC?=
 =?utf-8?B?dFZyNGpheHpzU081a1J1YjdCZytMcVNQdEphNzc2dkFKbW1GYmwrSWN1M1A0?=
 =?utf-8?B?UmwzNGNkR0pJMGt2cVBGazl1VkpGTHZJZmJ4ZlVrNHRwd2krbjN0NUNON0Ri?=
 =?utf-8?B?cDFEZ1dyLzZ0cDFlcGttVk5BVWwzc1NFZjlCZGdSZkNGb3ZlQzNHb0tKK1hG?=
 =?utf-8?B?WkplM2xyTEhTVzNxVVMrZDhyN3VqblJmL3cvYTFseDU5RzdHOHd1VjZnVStD?=
 =?utf-8?B?Mm5SYzYwZXJMYlNkR2Fzc08vK1M3OVVacVpNQUFEYmhMWEhsRDdCcHNQaUdF?=
 =?utf-8?B?eER0RlZkWWVjd0pWMyt3KzBUUENrTTFiQmpzcndhSTVnNERWZzRnRDByQ1BV?=
 =?utf-8?B?eXVnMGF5Rk5La05XSzVYK2FUU21PT3B6Ti9PdjBvWTkwU09mdlBkczhTSWhy?=
 =?utf-8?B?S0l4aGNGZlBFTVRPa2h3Yy9nQjVHakJwVWFyUmNZOE8rYitRKzJmK3Q1eUM1?=
 =?utf-8?B?cm5HK29JQlhFM0JxazFXdHR1MDcxbS94SGI1azd0eit4QzJDbDZvRmtpQklQ?=
 =?utf-8?B?eURLQ3NsRGRMbE5HMTFxc2Q3enhkNjdpd3BQekpBZW96NVIyVHZzdTlBTEc1?=
 =?utf-8?B?cEZMS0E1RHR2MGFoa3ZLNU1TSmd0RitCZUVITkNqcFA5aHBtYVgxa095OVo5?=
 =?utf-8?B?dXJTaUMxeXNZRmpWKzN6dFhEWkZId1U0NkEvZk9NU1hLbkduUTg2TzFSdGlV?=
 =?utf-8?B?ek1RRytuWDF3aEFQNGpNVG1YQ0cyVWhaVCtHYXBUalJPeitHazVCMkI1cE5W?=
 =?utf-8?B?ajBOb3BXOXpqakxYbEd3QzEzZmc1Q21pR0Z3blNiUmZaM1ZiYUhCM1VFR1pW?=
 =?utf-8?B?Zy9PTTlxa216cHcxTFBLM2lmSEZwRyt1d2RCbUVLTUp5OWVvbGZaSUl2Uy95?=
 =?utf-8?B?dHR1YkZ2V1FqaktaNWRzdzIvTCtMQm9xa3FSZE50aldIVVh5MXFCKzNiTU43?=
 =?utf-8?B?SCtpWE1iMS9UMWVUbldSUlduU280ZWlrcmJTeHdJRXJyKzRmM2lkZ0czWFRN?=
 =?utf-8?B?enY5bFBBM3dqV2QySnlsbGh2Z05iNjBKUnkzNEthWVgyZUV3YnVmQVhnb1N3?=
 =?utf-8?B?cC82RTFXeDdrVlRkWmsvS3hxZ2ZQTFIzT0ljVmMwTjdETHgySmpGaDR6Ykpz?=
 =?utf-8?B?WUp1blVlNU9ZU29HM0VnMThCcC9KSy82NVQ2ekRFSVU2ZTY2ZGk4ZzJYVnJM?=
 =?utf-8?B?SE1COXBMck1vS3VaNnhreXFHWjBSRHhkc3NKcDJoYzRadG9SaUFUOERhQ2kr?=
 =?utf-8?B?UUV2Y1o0Q2ZDQVRaVmhZMXZ2bUdGdjgxVUpNN2xuRnhzSGZiWXhBcG5Hbkkv?=
 =?utf-8?B?Ty9DTUFSN0FSRUpuMWlqckRCUUJjbWhOeEJQajVXVFR0U1lVWTFyeHRXdUMy?=
 =?utf-8?B?TVUwMVBKdms1NmNObVNnQkFYNG5ZT1luQVc1M0ZHbnU2Q09iQzd6eGJZY1Bu?=
 =?utf-8?B?OFpYbWFsZGhQdHRYckF2RkVlRGhXQ2p1TWFwQkd5RUI4OURaempjTXpKeVc0?=
 =?utf-8?B?RHBURC9vTTFyTk9PNW14dWJQKzlTQm5mZFpkKzZpQ3Z3eEFPbEV1RWNkYnJh?=
 =?utf-8?B?NzB0WGIwcXcyWmxiUVRvVys5Q3hSZkpBR291ZU9OTHBmOGtjN2MvUVFQYy9X?=
 =?utf-8?B?QkZ2STlML2ZUZWwveW5uVGp1WUF4NG5vb1NnenVaRncvZ1ZHakt2eHlZMVd6?=
 =?utf-8?B?b3E4M3Y3emFBMmx5OEpML01jWnJvQ2hQbnllc1RTOUxsZjlHK1pPTUVWR2U5?=
 =?utf-8?B?RWlJU1QxcHkyZjNIOEs4czgrbm5PTmtSTVAwdG54VWFNMy9ZSlJHSDNLZXU5?=
 =?utf-8?Q?ojTmf2JukefytoYiyG+oUPx8g+9zas1G?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6560.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cWN0TWY2OTQ3V0dKU1piVEVnV01QR3RRTUhoaDVub3FYakIzZlo4S3UvTTNH?=
 =?utf-8?B?QzRMbFhlb2lXYkdsY3hGRmN4bmU0QUMxVUFSMjgrK0NXYkVoRXE1YktCOEow?=
 =?utf-8?B?ZW1UUTdyVWFveEVNWVRsNE83WVdHQ3NFRFlCOHRqdnd0R0piZkZMbmdhbHZJ?=
 =?utf-8?B?bjFtZ2JZMXdJbndFdjRaMHc4LzBMRmNPS0c3SDJackxudHdRNk95UVBnRWNx?=
 =?utf-8?B?YzAyT1lWRzlSWG1mWTdONlRUNWcwVjcrV0VSa01ENkRpSk16a2didlhlbzVv?=
 =?utf-8?B?UUlSSnFtazlicEFwM0k5cDZTMzg0WThSOXI2R3dBbDRRbDl0UnBFcUdQTTdI?=
 =?utf-8?B?dVB4Z2ZyTm5ZenN1Z2xxcG5jcTl0S2JLejZkZzIvcFpkbHQ4UUFkKy9qWHU1?=
 =?utf-8?B?Y0tNMnoraU81d1BWQzFVUmJnRTFvQkFJYmlabUxvRmQvYVdHUUlmcEc5WjNi?=
 =?utf-8?B?b092aDJnY0FQK0ZCTThIZkFsTDdidnVOa1dGZm8rbzAzQjJ1OXJ0WmN2bnV5?=
 =?utf-8?B?RkNCV3MrQ24zMWk0YVFoc05yRVJJNTRYSjJyZ081NW9RL0RORDMvK0VobjIy?=
 =?utf-8?B?U1RiRUxwRkZKYzBDK3E3UzFPeW1DdmlKZGo0KzdTSEduODh5SnIyRHFFLzU0?=
 =?utf-8?B?allEOXBEVlVmRm16d2U2ai9GUGpkMGlIbFQwT1BhNWxZS0t3WDRyQVVIRTVU?=
 =?utf-8?B?em95Y0k4MzJtUlZZc2tHNjdxcjhJVFVwZ1QxY0FTWWgxUG1iRDBpQjBiY2dt?=
 =?utf-8?B?aTRCOUhhR1pvUkJSQVBlT0diUFlRUDhaM1p6UTR0T29YVFB5N1Z3Tm9QL1hE?=
 =?utf-8?B?T2NlZHNwaFl3V0NBSFNQWGJuZzlxekpSU3Z6WmZwdlQ0TVZlbzEwNXJDYWxv?=
 =?utf-8?B?M01Nd0xmNzdwMkdRa2NZUUw4bWl3MUZFbk1pUVZSSG00MDE1RlViTUZGekwv?=
 =?utf-8?B?c1VralNYWmdrQXFKeVM0Q2ZPWldxOGhVb3BnTHFTblBFQWtXbElyNnlmR3VQ?=
 =?utf-8?B?TTVXczhaUk00UkNTc3JTUFZBK1QrSGw5NlJOY0RySUxVa2RQU0JwTzYvdzZr?=
 =?utf-8?B?Mm5iNG1GK3RCY3JzaE1pM3kzY0tCT1FkWE5YbE9aT1Rtb2JKR1M5MndwVW1S?=
 =?utf-8?B?QUpXWDhjSGRZZmIwZXNocG40bXlTaXFudy9GWndrYXFONG9hZEJrSVpZaUhE?=
 =?utf-8?B?M1Y2TDZ4bTBaRDdlL1RDSW5xM0x5Mmt6SkpsMStwM3pRbU5vRHphWit4N0k1?=
 =?utf-8?B?S213TmMzVmNVZE44MWtRTDU0NmZBc0dOaTJvYTRxZUQ3K25HZjlKVEttaHZl?=
 =?utf-8?B?SGsxU1NmSytERXgrc1F5Vm9oakVwNkZGa25Ud1ZTb0tCbmFMVFBxUk1UYVMv?=
 =?utf-8?B?RlV4b3UyY2MzRWNxS3RJWkJ2TFR3ZmlLRnBvS0d4RUxQUXFmdjczUHFCRzkr?=
 =?utf-8?B?aDRya2xVSDFtRDJqYmVjV0w1TW4xbTFlNjNia3RBOFVFUWlLRTU5cXF6QzA3?=
 =?utf-8?B?YXZZMThLZ3d2ZWdjM0Vub2tuNVZYREQwajBMUDBNZDNzVFM2VmZneU1ZR2d6?=
 =?utf-8?B?OHlDMnpPbkNyQ2s3ODJaclNJaWtyNThGSVpKNzVNWUpBUTM4bXVIK0N1bVVk?=
 =?utf-8?B?emhmZTYyN05GNHFlUUxDV3dkUk9LbFpDY3NzZE8ySG5hT3ZwbUhSdDhnaVRR?=
 =?utf-8?B?WElLTDB6QTZSQUZoVUE4azU3WUhyRUFqMjRYSHREVTFKSW82bVdzWDVlcHdB?=
 =?utf-8?B?OUZUMWNCUHFOcVVXUGc1ek1oTUtqSUxrZTl5S0lYUnZueXN0Z25YVDRDN2xC?=
 =?utf-8?B?RktEd2M1UDF6VFYyTUN5T3ZkS2c5eGZ2QUNZKzlWcis0WWk5d2JTeWZhajVS?=
 =?utf-8?B?Ym53dmJxMlpWbWY0dTRwaVY2emVmcHFUUUNheW5FU2kyNm5LbjhMbEszNmho?=
 =?utf-8?B?L1NLMFNKWXc3ZmFRaEZEdCtKa2lDcFZ5N0tWd0l4SWREZVJmQnFYZU4yY2w2?=
 =?utf-8?B?V3MyOEdpc2VWbGVjS3h1aHVQQ3hiZU9DZERiTFM3bVdBK2h5QTNkenprM3JZ?=
 =?utf-8?B?TGNPYnprb3l1WUpPUWVYaW9Nd3BUUkNhK2hkOVI5VXMxZ1M1TlJMdHd0bDV2?=
 =?utf-8?Q?LEWLQYpWdzAZyAN2FHd5Y3b95?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8488A441CD258E46B0A1357B7D92EED1@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ba48ef3b-eebf-48fe-8296-08dd55a4b530
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2025 14:00:05.8986
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CbwTDRoYfwQ9MEZ94psISDJGn7cLRWwQSH2HBq3Be5mgahG8IUX7o53f3Hq7K4OsF4zqTKFi5km/iL98zoZyMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4141

T24gVHVlLCAyMDI1LTAyLTI1IGF0IDA5OjQwICswMDAwLCBIYW5nYmluIExpdSB3cm90ZToNCj4g
VGhlIGZpeGVkIGNvbW1pdCBwbGFjZWQgbXV0ZXhfbG9jaygpIGluc2lkZSBzcGluX2xvY2tfYmgo
KSwgd2hpY2gNCj4gdHJpZ2dlcnMNCj4gYSB3YXJuaW5nIGxpa2U6DQo+IA0KPiBCVUc6IHNsZWVw
aW5nIGZ1bmN0aW9uIGNhbGxlZCBmcm9tIGludmFsaWQgY29udGV4dCBhdC4uLg0KPiANCj4gRml4
IHRoaXMgYnkgbW92aW5nIHRoZSBtdXRleF9sb2NrKCkgb3BlcmF0aW9uIHRvIGEgd29yayBxdWV1
ZS4NCj4gDQo+IEZpeGVzOiAyYWVlZWY5MDZkNWEgKCJib25kaW5nOiBjaGFuZ2UgaXBzZWNfbG9j
ayBmcm9tIHNwaW4gbG9jayB0bw0KPiBtdXRleCIpDQo+IFJlcG9ydGVkLWJ5OiBKYWt1YiBLaWNp
bnNraSA8a3ViYUBrZXJuZWwub3JnPg0KPiBDbG9zZXM6DQo+IGh0dHBzOi8vbG9yZS5rZXJuZWwu
b3JnL25ldGRldi8yMDI0MTIxMjA2MjczNC4xODJhMDE2NEBrZXJuZWwub3JnDQo+IFNpZ25lZC1v
ZmYtYnk6IEhhbmdiaW4gTGl1IDxsaXVoYW5nYmluQGdtYWlsLmNvbT4NCj4gLS0tDQo+IMKgZHJp
dmVycy9uZXQvYm9uZGluZy9ib25kX21haW4uYyB8IDQxICsrKysrKysrKysrKysrKysrKysrKysr
KystLS0tLS0NCj4gLS0NCj4gwqBpbmNsdWRlL25ldC9ib25kaW5nLmjCoMKgwqDCoMKgwqDCoMKg
wqDCoCB8wqAgNiArKysrKw0KPiDCoDIgZmlsZXMgY2hhbmdlZCwgMzcgaW5zZXJ0aW9ucygrKSwg
MTAgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvYm9uZGluZy9i
b25kX21haW4uYw0KPiBiL2RyaXZlcnMvbmV0L2JvbmRpbmcvYm9uZF9tYWluLmMNCj4gaW5kZXgg
ZTQ1YmJhMjQwY2JjLi5jYzcwNjRhYTRiMzUgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbmV0L2Jv
bmRpbmcvYm9uZF9tYWluLmMNCj4gKysrIGIvZHJpdmVycy9uZXQvYm9uZGluZy9ib25kX21haW4u
Yw0KPiBAQCAtNTUxLDYgKzU1MSwyNSBAQCBzdGF0aWMgdm9pZCBib25kX2lwc2VjX2FkZF9zYV9h
bGwoc3RydWN0IGJvbmRpbmcNCj4gKmJvbmQpDQo+IMKgCW11dGV4X3VubG9jaygmYm9uZC0+aXBz
ZWNfbG9jayk7DQo+IMKgfQ0KPiDCoA0KPiArc3RhdGljIHZvaWQgYm9uZF94ZnJtX3N0YXRlX2dj
X3dvcmsoc3RydWN0IHdvcmtfc3RydWN0ICp3b3JrKQ0KPiArew0KPiArCXN0cnVjdCBib25kX3hm
cm1fd29yayAqeGZybV93b3JrID0gY29udGFpbmVyX29mKHdvcmssIHN0cnVjdA0KPiBib25kX3hm
cm1fd29yaywgd29yayk7DQo+ICsJc3RydWN0IGJvbmRpbmcgKmJvbmQgPSB4ZnJtX3dvcmstPmJv
bmQ7DQo+ICsJc3RydWN0IHhmcm1fc3RhdGUgKnhzID0geGZybV93b3JrLT54czsNCj4gKwlzdHJ1
Y3QgYm9uZF9pcHNlYyAqaXBzZWM7DQo+ICsNCj4gKwltdXRleF9sb2NrKCZib25kLT5pcHNlY19s
b2NrKTsNCj4gKwlsaXN0X2Zvcl9lYWNoX2VudHJ5KGlwc2VjLCAmYm9uZC0+aXBzZWNfbGlzdCwg
bGlzdCkgew0KPiArCQlpZiAoaXBzZWMtPnhzID09IHhzKSB7DQo+ICsJCQlsaXN0X2RlbCgmaXBz
ZWMtPmxpc3QpOw0KPiArCQkJa2ZyZWUoaXBzZWMpOw0KPiArCQkJeGZybV9zdGF0ZV9wdXQoeHMp
Ow0KDQpJIHdvdWxkIGV4cGVjdCB4ZnJtX3N0YXRlX3B1dCB0byBiZSBjYWxsZWQgZnJvbSBvdXRz
aWRlIHRoZSBsb29wLA0KcmVnYXJkbGVzcyBvZiB3aGV0aGVyIGFuIGVudHJ5IGlzIGZvdW5kIGlu
IHRoZSBsaXN0IG9yIG5vdCwgYmVjYXVzZSBpdA0Kd2FzIHVuY29uZGl0aW9uYWxseSByZWZlcmVu
Y2VkIHdoZW4gdGhlIHdvcmsgd2FzIGNyZWF0ZWQuDQoNCj4gKwkJCWJyZWFrOw0KPiArCQl9DQo+
ICsJfQ0KPiArCW11dGV4X3VubG9jaygmYm9uZC0+aXBzZWNfbG9jayk7DQo+ICt9DQo+ICsNCj4g
wqAvKioNCj4gwqAgKiBib25kX2lwc2VjX2RlbF9zYSAtIGNsZWFyIG91dCB0aGlzIHNwZWNpZmlj
IFNBDQo+IMKgICogQHhzOiBwb2ludGVyIHRvIHRyYW5zZm9ybWVyIHN0YXRlIHN0cnVjdA0KPiBA
QCAtNTU4LDkgKzU3Nyw5IEBAIHN0YXRpYyB2b2lkIGJvbmRfaXBzZWNfYWRkX3NhX2FsbChzdHJ1
Y3QgYm9uZGluZw0KPiAqYm9uZCkNCj4gwqBzdGF0aWMgdm9pZCBib25kX2lwc2VjX2RlbF9zYShz
dHJ1Y3QgeGZybV9zdGF0ZSAqeHMpDQo+IMKgew0KPiDCoAlzdHJ1Y3QgbmV0X2RldmljZSAqYm9u
ZF9kZXYgPSB4cy0+eHNvLmRldjsNCj4gKwlzdHJ1Y3QgYm9uZF94ZnJtX3dvcmsgKnhmcm1fd29y
azsNCj4gwqAJc3RydWN0IG5ldF9kZXZpY2UgKnJlYWxfZGV2Ow0KPiDCoAluZXRkZXZpY2VfdHJh
Y2tlciB0cmFja2VyOw0KPiAtCXN0cnVjdCBib25kX2lwc2VjICppcHNlYzsNCj4gwqAJc3RydWN0
IGJvbmRpbmcgKmJvbmQ7DQo+IMKgCXN0cnVjdCBzbGF2ZSAqc2xhdmU7DQo+IMKgDQo+IEBAIC01
OTIsMTUgKzYxMSwxNyBAQCBzdGF0aWMgdm9pZCBib25kX2lwc2VjX2RlbF9zYShzdHJ1Y3QgeGZy
bV9zdGF0ZQ0KPiAqeHMpDQo+IMKgCXJlYWxfZGV2LT54ZnJtZGV2X29wcy0+eGRvX2Rldl9zdGF0
ZV9kZWxldGUoeHMpOw0KPiDCoG91dDoNCj4gwqAJbmV0ZGV2X3B1dChyZWFsX2RldiwgJnRyYWNr
ZXIpOw0KPiAtCW11dGV4X2xvY2soJmJvbmQtPmlwc2VjX2xvY2spOw0KPiAtCWxpc3RfZm9yX2Vh
Y2hfZW50cnkoaXBzZWMsICZib25kLT5pcHNlY19saXN0LCBsaXN0KSB7DQo+IC0JCWlmIChpcHNl
Yy0+eHMgPT0geHMpIHsNCj4gLQkJCWxpc3RfZGVsKCZpcHNlYy0+bGlzdCk7DQo+IC0JCQlrZnJl
ZShpcHNlYyk7DQo+IC0JCQlicmVhazsNCj4gLQkJfQ0KPiAtCX0NCj4gLQltdXRleF91bmxvY2so
JmJvbmQtPmlwc2VjX2xvY2spOw0KPiArDQo+ICsJeGZybV93b3JrID0ga21hbGxvYyhzaXplb2Yo
Knhmcm1fd29yayksIEdGUF9BVE9NSUMpOw0KPiArCWlmICgheGZybV93b3JrKQ0KPiArCQlyZXR1
cm47DQo+ICsNCj4gKwlJTklUX1dPUksoJnhmcm1fd29yay0+d29yaywgYm9uZF94ZnJtX3N0YXRl
X2djX3dvcmspOw0KPiArCXhmcm1fd29yay0+Ym9uZCA9IGJvbmQ7DQo+ICsJeGZybV93b3JrLT54
cyA9IHhzOw0KPiArCXhmcm1fc3RhdGVfaG9sZCh4cyk7DQo+ICsNCj4gKwlxdWV1ZV93b3JrKGJv
bmQtPndxLCAmeGZybV93b3JrLT53b3JrKTsNCj4gwqB9DQo+IMKgDQo+IMKgc3RhdGljIHZvaWQg
Ym9uZF9pcHNlY19kZWxfc2FfYWxsKHN0cnVjdCBib25kaW5nICpib25kKQ0KPiBkaWZmIC0tZ2l0
IGEvaW5jbHVkZS9uZXQvYm9uZGluZy5oIGIvaW5jbHVkZS9uZXQvYm9uZGluZy5oDQo+IGluZGV4
IDhiYjVmMDE2OTY5Zi4uZDU0YmE1ZTNhZmZiIDEwMDY0NA0KPiAtLS0gYS9pbmNsdWRlL25ldC9i
b25kaW5nLmgNCj4gKysrIGIvaW5jbHVkZS9uZXQvYm9uZGluZy5oDQo+IEBAIC0yMDksNiArMjA5
LDEyIEBAIHN0cnVjdCBib25kX2lwc2VjIHsNCj4gwqAJc3RydWN0IHhmcm1fc3RhdGUgKnhzOw0K
PiDCoH07DQo+IMKgDQo+ICtzdHJ1Y3QgYm9uZF94ZnJtX3dvcmsgew0KPiArCXN0cnVjdCB3b3Jr
X3N0cnVjdCB3b3JrOw0KPiArCXN0cnVjdCBib25kaW5nICpib25kOw0KPiArCXN0cnVjdCB4ZnJt
X3N0YXRlICp4czsNCj4gK307DQoNCkFsc28sIGxpa2UgTmlrb2xhaSBzYWlkLCBzb21ldGhpbmcg
bmVlZHMgdG8gd2FpdCBvbiBhbGwgaW4tZmxpZ2h0IHdvcmsNCml0ZW1zLg0KDQpUaGlzIGdvdCBt
ZSB0byBzdGFyZSBhdCB0aGUgY29kZSBhZ2Fpbi4gV2hhdCBpZiB3ZSBtb3ZlIHRoZSByZW1vdmFs
IG9mDQp0aGUgeHMgZnJvbSBib25kLT5pcHNlYyBmcm9tIGJvbmRfaXBzZWNfZGVsX3NhIHRvIGJv
bmRfaXBzZWNfZnJlZV9zYT8NCmJvbmRfaXBzZWNfZnJlZV9zYSwgdW5saWtlIGJvbmRfaXBzZWNf
ZGVsX3NhLCBpcyBub3QgY2FsbGVkIHdpdGggeC0NCj5sb2NrIGhlbGQuIEl0IGlzIGNhbGxlZCBm
cm9tIHRoZSB4ZnJtIGdjIHRhc2sgb3IgZGlyZWN0bHkgdmlhDQp4ZnJtX3N0YXRlX3B1dF9zeW5j
IGFuZCB0aGVyZWZvcmUgd291bGRuJ3Qgc3VmZmVyIGZyb20gdGhlIGxvY2tpbmcNCmlzc3VlLg0K
DQpUaGUgdHJpY2t5IHBhcnQgaXMgdG8gbWFrZSBzdXJlIHRoYXQgaW5hY3RpdmUgYm9uZC0+aXBz
ZWMgZW50cmllcw0KKGFmdGVyIGJvbmRfaXBzZWNfZGVsX3NhIGNhbGxzKSBkbyBub3QgY2F1c2Ug
aXNzdWVzIGlmIHRoZXJlJ3MgYQ0KbWlncmF0aW9uIChib25kX2lwc2VjX2RlbF9zYV9hbGwgaXMg
Y2FsbGVkKSBoYXBwZW5pbmcgYmVmb3JlDQpib25kX2lwc2VjX2ZyZWVfc2EuIFBlcmhhcHMgZmls
dGVyaW5nIGJ5IHgtPmttLnN0YXRlICE9IFhGUk1fU1RBVEVfREVBRA0KaW4gYm9uZF9pcHNlY19k
ZWxfc2FfYWxsLg0KDQpXaGF0IGRvIHlvdSB0aGluayBhYm91dCB0aGlzIGlkZWE/DQoNCkNvc21p
bi4NCg==

