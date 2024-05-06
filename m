Return-Path: <linux-kselftest+bounces-9552-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FAC68BD4E1
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 May 2024 20:51:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAD842814AA
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 May 2024 18:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE808158D8B;
	Mon,  6 May 2024 18:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="O358p5mK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2056.outbound.protection.outlook.com [40.107.243.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C7EC4AECA;
	Mon,  6 May 2024 18:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715021460; cv=fail; b=vD2l5O9mMkIHGUo0kvwM7o23bEw7vgZsL5VbFRzs3bV717W+MotbpPvrYTXDFY9pN9Wc9kSxiZKVSKst1mM1vPXr31JyoynFW88a8z/QlFSm9GG/44TOLPaZeaxW9HxjkmzOy7TUUguRXuf89i5sqa3prMNlGi2CpDsdLlyHs6c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715021460; c=relaxed/simple;
	bh=6TjPXwDHMrKam3heobAM+nTr0wZ3G8FQxnuyGqSXeJ0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DaSbrHD7zQP53hG+vUDwy5fM/f76rxzrOyMA56Wo8yzo6i4KHGEGwNoqpVvLvCCsvmnds2RthJTG7PhTPZQo27CcLK1IeyFxsbEpIo0Sa2kgZeLNyfqwnmCC7nDsw3FADwEXbGs4Irhut8MVxzD+xQV9P/u9hueMB1E2T+iKmSo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=O358p5mK; arc=fail smtp.client-ip=40.107.243.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hzN1dJdyuYUTJsvfVc7ETNFmW+c82qhGKnuyWDjAx4wjE3l3lQ2lV4TiO/g4bJyi0D+gEVu6M4iwa7WDx4Kkj4tRhYzm+4f+zVF+cDi3R0LAAXyPZrLKIn21jZSbPQG8DLawsfoHSvjRjWSVlXPYzR29JHdFcrJmSN41lLViEWbeY1X1lWPSLpqnaWyfe8VMbOa09MgEY4WiDk1iRzFwgVVROXfj9haGylWlOpqUhJUKChUH6es+ILR0rlpU3aR91eK1aAhBGwWw1kn6+GYvszNlUgIpNuYNSXR99b24XwwkpVlit752IEoVVmFI1w5og2pg0fEOtrq5itIs0FkWJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ShH1y5EJvLyw8L8Y3VMDX0hBH3YYOJ6GcUoiYqKBN0Y=;
 b=MRUkF7bRgX7ohPDHtfV1qrfIMQuZM7BpU4pQpmijJOfvQlVki6iTCpbSuSviDsuR4yDxovcHxEbIn3A0KE8+evad3NviGMVt283jxmiwX95kb4CThwzzRxGqLemOKucrgnK/Tk9MJ9J+yIrKzfG4dmY33Ff+Py2dPQ7i61C/0CQrHngpQtahWuqK6OrDn3PH2iteUoCDEYKpOds6meXbWT2kLyCIkBZY/XRCNfTJJ5I0hp34BuJwraLFAymKXTc03enh2KPPmucUhSUM2ESf7D4FMrWQdY6LvuyEtKG+Cy8UkUfiHIErIozLBN5+5XjMGiPWlnuVFlxnLWxyS1rfAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ShH1y5EJvLyw8L8Y3VMDX0hBH3YYOJ6GcUoiYqKBN0Y=;
 b=O358p5mK8ZHZxd1/qFLNJ+XfkRF8vb+WIHQ359kiZLQgUrwajC0c8SrQkgawfeSDRKrZaqBW8O7DOj/8/beCzyF+5pmK3oyqNzXaTQ8o2c5+doledFa7sA953+aFHtpyjOm/yvkFTuvFXYonqhtZFlIXNu9CbkPbHPo3keswf31P7x4yX0kxwL12cpqLDZUkRlj5137nTqicJ2a6MAQ1DbjjIPZ2GxmBLDII7ozAPoVWGW7M8CwrnlO1G3WTYfDtNWbKV5FeHmNoa211s5feif8a5rvIJtw4FxAJlgroAXRHovhCEYbMMKtRzFrdVFK9yoKMO1rNXgeiikO3OpQgiQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by PH7PR12MB6907.namprd12.prod.outlook.com (2603:10b6:510:1b9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41; Mon, 6 May
 2024 18:50:51 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07%4]) with mapi id 15.20.7544.041; Mon, 6 May 2024
 18:50:51 +0000
Message-ID: <fd74de9a-4deb-4fb7-9461-65c38ff1443c@nvidia.com>
Date: Mon, 6 May 2024 11:50:40 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] selftests/net: fix uninitialized variables
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Shuah Khan <shuah@kernel.org>, richardbgobert@gmail.com
Cc: "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Steffen Klassert <steffen.klassert@secunet.com>,
 Herbert Xu <herbert@gondor.apana.org.au>, =?UTF-8?Q?Andreas_F=C3=A4rber?=
 <afaerber@suse.de>, Manivannan Sadhasivam
 <manivannan.sadhasivam@linaro.org>, Matthieu Baerts <matttbe@kernel.org>,
 Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>,
 Pravin B Shelar <pshelar@ovn.org>,
 Alexander Mikhalitsyn <alexander@mihalicyn.com>,
 zhujun2 <zhujun2@cmss.chinamobile.com>, Petr Machata <petrm@nvidia.com>,
 Ido Schimmel <idosch@nvidia.com>, Hangbin Liu <liuhangbin@gmail.com>,
 Nikolay Aleksandrov <razor@blackwall.org>,
 Benjamin Poirier <bpoirier@nvidia.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Dmitry Safonov <0x7f454c46@gmail.com>, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-actions@lists.infradead.org,
 mptcp@lists.linux.dev, dev@openvswitch.org,
 Valentin Obst <kernel@valentinobst.de>, linux-kselftest@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>, llvm@lists.linux.dev
References: <20240505222639.70317-1-jhubbard@nvidia.com>
 <20240505222639.70317-2-jhubbard@nvidia.com>
 <66391ab83771c_516de294d7@willemb.c.googlers.com.notmuch>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <66391ab83771c_516de294d7@willemb.c.googlers.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR08CA0001.namprd08.prod.outlook.com
 (2603:10b6:a03:100::14) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4130:EE_|PH7PR12MB6907:EE_
X-MS-Office365-Filtering-Correlation-Id: 5bbd65d5-4849-4563-a88d-08dc6dfd735c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|7416005|376005|366007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TnJ0RzJocjcyVjVTa3lCWnhBMGVzSlJoaUtEdHExN3JvK2lFcVJwQnZ2S2F1?=
 =?utf-8?B?N1pyS0NJWXNCdjVHejlBYkRFZjNVeG1kUjhLNTdOTWRpUFZWQVVGOWQ4SGd4?=
 =?utf-8?B?dHErdVUrOXpoZGNJQ1J4TVJ2MG5GWVVYb21Cc2hZRDhFV1NIK3hlakFkRDVJ?=
 =?utf-8?B?YUsrVEdnRFg0TlF0aUxZTEJQT01KY1E2bE9kOEZ0aTE1clVSdjZVOUZyTFdo?=
 =?utf-8?B?MUk0eDZsNkxJRjNYV3N0NmdYQlRSM3dCTUlNdFBTSG1PbTBKY0kzcEV1K2t5?=
 =?utf-8?B?R2lwQ3lkVnhFOW1yUXp4bENzcGZRbWRLWU9hUWFiYWdKK205QjEweWQyRnJ2?=
 =?utf-8?B?Y1pySzd1WSs3Q1BxYTJvUTJjdlV6d0pBaVQ4ckNRdHVjelNyQTlDeksrNzRl?=
 =?utf-8?B?QzVwWkJmbktBbktDM2FRWm1KMU9abUtqazJ0ZUtIOGNTOEZKNnhjdmVxSFZJ?=
 =?utf-8?B?Sm8vUmQxTFIzd281M3RDVUlReXRVUElXSFJNQ1FRRHBZVGV1cEVuOW9lbnFo?=
 =?utf-8?B?L3hUNEJTZ05nbm9veko4dWYya2tubHYySnhJa1hkM0traHhpZU92RHBlZmJl?=
 =?utf-8?B?Q3BMVVovZWF6YlNCNjg5NlFyR3B3aDZKTHJtZkJVRTV0VHdDaEFCam9PSE9F?=
 =?utf-8?B?OCtmT0hxMUVBdThHNk04dGVnbC9FTDhlcEUyY0ZYTWlxWTdValJOaktNUHhx?=
 =?utf-8?B?QkpXd0pJR3ViVjRRVlI0aW5scWp3ajcxZURHSjI3aFdpSXQxM2RkZHo3d2NM?=
 =?utf-8?B?TWZOWTlzSFRrYk9uU1FYTFh3K0ExaElBcTRuallUK1VDUklNUXRiTEI4dnlu?=
 =?utf-8?B?RzRvaDJvSlh1Y1duMjNxaS9ITTJNaDJDZU5jMGo5aTFEbTlSRFdzYklVZG8w?=
 =?utf-8?B?dDVxakVBakxLUnU2c2V5bk1WNXRkUmV2bDVUbm1GUDlHSEhnRUIrTWJoTFNt?=
 =?utf-8?B?elhzVzRKR2lxSFBDTDJ6VW4yZGUwbVl4a2FsZkUwVUJJUUFvRklUQXY5NDdL?=
 =?utf-8?B?YytrUjNKVlRlb1VNajR1aWxWSjhTRHhIQlZsd2lPVHpRaTF0bGwwT2hEREVo?=
 =?utf-8?B?Z0s0NG8yb0c5bjVYWFlocHphOTJRMUxQWXZVaWFKd1U5V1UzN3JoVmx5eW1P?=
 =?utf-8?B?UVVxeGNLVUczMWdoU3FHc0xVeGh2Mi9PUTZ5Z29oUmowR1ZpUGRtNlRIanFo?=
 =?utf-8?B?YnpCZGUySGJiMnVmVFljdE5NemN2eTRSTG13d0p5c0ZhVy9MQkJZU3hmL01K?=
 =?utf-8?B?cG14NHNTb0VSTWpycGcrcDJCdzFocXVYQUtCRUdWSEhWbVpYNjkwTUZ0OU51?=
 =?utf-8?B?cmh6bGpkYllLYmgwMGhBVzFKNHpHWHdrOHA2ZXM4djFjQVNGRnlQdnNjRnZH?=
 =?utf-8?B?SVZXM29MMG9icDhDK3lrYk4xTDIzblhWWDAzdzFkNFprYmpjTTJ3WnpxSkIr?=
 =?utf-8?B?cm56ZkRrdjJmWU1tKzlqempmL1o2a1pMUmZGM3EvQ1BrSzFENUh0aXVkMGtn?=
 =?utf-8?B?TWxaM1ovOHdVUWpINXdGc29NV3ByWXUzUWhWUzJ6SW9ieDAvV3NWRzVMTFll?=
 =?utf-8?B?UlNtbzBtek5mQ28wa2dPd2trVmlKd0dZUWd6TUdMT2I1bCtLaUlDZjQzOVlM?=
 =?utf-8?B?WDZCL2pJQjZuUUxhNSt5ZFBQc1BiUThvdU5LTmUzUHp2STlNSDQ3R1pxaGRJ?=
 =?utf-8?B?ekxGekQxZStrVWhtVVdYRldaejdiOVErMGNIQ0tPRkJPeHBDQXBLNHBnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VVJpSUdGdmRRSWVTZkRpbTNZZEtVNlE0R2NNNnZlZ3ZCWW1pcFlZQno2Y0U1?=
 =?utf-8?B?cmZnR21PVGFZM3BxeXVUTkE2dkRmY3QwM0dNUU5sM0o4czJtZlgwK1VMbGUy?=
 =?utf-8?B?U05JTXVHL1Bud3VLUlNRS2xKeGpQTG80UlhkUG1XODVVWE9tanZvR1hEeXRw?=
 =?utf-8?B?S1NCWHJKRVNoaWlKSWtHUU9WNnphYUhIM1FYQzJLSFN2OEpXTWYyc3RvRy9F?=
 =?utf-8?B?bk9nNmRaZHpqSjJFVkV4cTVnMGxEcU5kbWNDVVErKzQ0OGFWcDErUjEwdnFk?=
 =?utf-8?B?My9RMHJNRHpxSTBHc2Vub1d1NDJBb1ZLcSswWU9lbUVkRm83VlkwakVHNGxL?=
 =?utf-8?B?Qno2c21yT1FHNGhuaHgrS09ub0ZOc3IxWHR6dGU2dkVDWGptOVhQbVRuMDZh?=
 =?utf-8?B?ZnhEVTRLQVVNZDZBOTUvekRIWkx1eHhsZ2pvSXgwVlBLZjJPN3I3TnNEZ3ph?=
 =?utf-8?B?SEdtT2g3RGlGaEZsbS9FSHpNMURYMUFHbDRucnY5bnNyNzhseThQVzExNVlq?=
 =?utf-8?B?N2hnVVh2QmFKSU5zeDYzSWV2dFdDYWxyamxTaTRkdy82YS8rdEZaNnZJT2lQ?=
 =?utf-8?B?a3lOYnRmcGlvNHREUGExdmhSOHVQdE9meElqTFJwelZILzZZbFIrcjBVM1Jz?=
 =?utf-8?B?OEN4KzdKelJtNGdvdUZVRmZHbTRVaUZHSXEwZGpUYXhuVElDQUNwd0VkV0ZM?=
 =?utf-8?B?eU9Cb1A1MGhlTWQzVnBWWS95QXlXV0FiSmczblV1azJOQmtmTnhOMHh0TDVn?=
 =?utf-8?B?dVdmMVZXV3BoajVzWjdYWlJWWVliOVBHbjVEL2NMTEdid1pnWHZvK3VOcUt0?=
 =?utf-8?B?QldFOFdqZTdRZk9Pa1AzRUErcFJNK0FRRkVjNHEyd2xyTGNkeFIvbkJRS0kr?=
 =?utf-8?B?VTQySUJ1Ny81QWdkU1pycHJld04yMm05c2hWcGdheXR2L0ZaVFd3dG8zRXBJ?=
 =?utf-8?B?RmI3TFNUak4rQ3NaL2ppc21BMXp3MGpVRzNHTDBnMytEbUZxT2Z6RnBPK3NV?=
 =?utf-8?B?Q0t4UFZsUHV5TGQ0WE05eFg0NEwzVGZNNm9GbjF3VUVxVVNiOCsraUdrOEx1?=
 =?utf-8?B?dWtLcW42S0ZRSFlFZFpzZ3dDWno4aFplYmQ2MnhHZG5iUUdzYStRcFV0MXRV?=
 =?utf-8?B?cHFzcHBKdDg1dVhnRzVmTER3VnoweXJmNlhHenM3b0ZGT29ibkx2eVVZL3VR?=
 =?utf-8?B?aGt6Qkp3MzRSSlhxdXhHQkNHNUh5SGJjTlJrWk0wcXNCTE5xSXhNeFZYL1Vz?=
 =?utf-8?B?T1dwcVpsQjBEVlM4NzVBS1poa1hDQXRYeXdsY1JRUTZaOXlrcmc1eWYxZkE0?=
 =?utf-8?B?Tm8zYTVtWDFjTU8yRDBOVmIvNXdBeHVlRmdkZEpBK0hIcGJlc1ZYajZmV3hr?=
 =?utf-8?B?eld3TmpsbTlTR1UrVmNhVC9SdUVnZ05ZTTJvQzRZTXhTU0o2TW56YkhvU1l2?=
 =?utf-8?B?UVRCYlN4d3J1a1M2NlFyOFVuRnJjQWE5ZkgvWFYrY0thK1hUaGVOMUV0ZXVV?=
 =?utf-8?B?Y0JvNlMwcW8wbkF5WE9oZ1dQaWxCc1ViUllZL2JYWG9zQWYwMGtTM3d3RmZL?=
 =?utf-8?B?WHowVnlSbDNQam9MKzN6Y0lqQ1RXcmRaaWdzWFJZZWZlbHQrYUdZOFkwam81?=
 =?utf-8?B?TUxtWmxuTndRSDhMeXhWTkI5aVE2b1lJOGVUOFJ6bEtCUTBKQ2xrcmtaVXQw?=
 =?utf-8?B?MU9Ca1J2dzAyMlVXUUxUNWh0c09CZDVnK0dVZnRCQkdTUWZMaWl3UFV3bHJr?=
 =?utf-8?B?UTlsc3RSVDRtMGtsRmFQVGhVQitHdUZVV1NROXlHSHdQMzg4RkkwSFYxNDRC?=
 =?utf-8?B?THloWWFET1gxVVZLSjlvK1VCLzhLTHJ3YWlQUmJ3UWZydzRiTGo0OFM1TVA0?=
 =?utf-8?B?MmtWYnExSjc4ZkJMSHg4ZW4xR0VtdXZrY21TcG15eGlPcGpyU21od1U3eFRo?=
 =?utf-8?B?WWF3VGdGYTZaRjdOSVJXTlZTL0JrQmtERDdHSkR3Qm5sbUtpUkVzaDV4S29t?=
 =?utf-8?B?TWZKYXFpTU1UV2VwOHJXNFF0VURBcjBPZjlHTmY0eE9sUjJKN2F4V2RlT3Nu?=
 =?utf-8?B?V2dZNk4rVG4vYVZ4QlFkMVZMWnY3YXpNOTMzUmJBOGhQVUxVQjJ5TlhTNXNu?=
 =?utf-8?B?U0s1TWlFOXVqcWJJUVZuQlZ6Ty95cGpMZkRUaDUySnVUdkdzQWNtL3A3ZGps?=
 =?utf-8?B?dWc9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bbd65d5-4849-4563-a88d-08dc6dfd735c
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2024 18:50:51.0532
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2f8NpaO4jd299OLB4e3wBJRlDjcwtczrITcuICw1vmSfGPBjf0Uoecj8fCKtKMcL933qucbdc+o1B18fTon1Rg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6907

On 5/6/24 11:00 AM, Willem de Bruijn wrote:
> John Hubbard wrote:
...
>> diff --git a/tools/testing/selftests/net/gro.c b/tools/testing/selftests/net/gro.c
>> index 353e1e867fbb..0eb61edaad83 100644
>> --- a/tools/testing/selftests/net/gro.c
>> +++ b/tools/testing/selftests/net/gro.c
>> @@ -110,7 +110,8 @@ static void setup_sock_filter(int fd)
>>   	const int dport_off = tcp_offset + offsetof(struct tcphdr, dest);
>>   	const int ethproto_off = offsetof(struct ethhdr, h_proto);
>>   	int optlen = 0;
>> -	int ipproto_off, opt_ipproto_off;
>> +	int ipproto_off;
>> +	int opt_ipproto_off = 0;
> 
> This is only intended to be used in the case where the IP proto is not TCP:
> 
>                          BPF_STMT(BPF_LD  + BPF_B   + BPF_ABS, ipproto_off),
> +                       BPF_JUMP(BPF_JMP + BPF_JEQ + BPF_K, IPPROTO_TCP, 2, 0),
> +                       BPF_STMT(BPF_LD  + BPF_B   + BPF_ABS, opt_ipproto_off),
>                          BPF_JUMP(BPF_JMP + BPF_JEQ + BPF_K, IPPROTO_TCP, 0, 5),
> 
> In that case the test tries again at a different offset that accounts
> for optional IPv6 extension headers.
> 
> This is indeed buggy, in that it might accidentally accept packets
> that should be dropped.
> 
> Initializing to 0 compares against against the first byte of the
> Ethernet header. Which is an external argument to the test. So
> safest is to initialize opt_ipproto_off to ipproto_off and just
> repeat the previous check. Perhaps:
> 
> @@ -118,6 +118,7 @@ static void setup_sock_filter(int fd)
>          else
>                  next_off = offsetof(struct ipv6hdr, nexthdr);
>          ipproto_off = ETH_HLEN + next_off;
> +       opt_ipproto_off = ipproto_off;  /* overridden later if may have exthdrs */

OK, thanks for pointing out the right fix, I'll send a v2 that does that.

thanks,
-- 
John Hubbard
NVIDIA


