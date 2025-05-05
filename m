Return-Path: <linux-kselftest+bounces-32339-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40218AA91E5
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 May 2025 13:18:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 222CE18831C8
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 May 2025 11:18:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B9FB202C44;
	Mon,  5 May 2025 11:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="uLL/Ku2K"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2060.outbound.protection.outlook.com [40.107.95.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 190E6156C69;
	Mon,  5 May 2025 11:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746443912; cv=fail; b=JMUlq6HRl4dSH1EAjrbvRVwSsdGyJSqJEulSYbYOq4z8CWAIdGB6QLLJa6BDabGjlIR8mcS3do9Ojg5wSJAfVA2i6AwjfAlJFPG+fg4xGzZI9buOHzOnwf1n4OyQKGRlmCitrP/5ctcVgF4LBUpnGhmX4a//3Z9GUBNHJS5ndmw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746443912; c=relaxed/simple;
	bh=kA4j1Sdg7G40Su7Q75lauVMpdn9O5hfdz2W0AA43TCA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=eMQQszAoy+YtBnKfWXeeecarN7gy1jVaHZJsMSQlMr4FwUjnovBxwnrF6bUOQ7Xj/re3yymQhTRk35eS6DQk7aR6tT4TkNjacUnpTtRL2B+Lnij4uv/fDJt5wxy0tWfE8kdlZtrFBmmkIKX1TfDHo/MCiDvizyWAjmaS0vS5lYk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=uLL/Ku2K; arc=fail smtp.client-ip=40.107.95.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G0UEA/OeqevVMbArVdHJNNML4TkN8FUCyO+gGBbEbxpeGBteFnHknEVfHVPTQYX6RBXFi0dBhRnvKR1WO3nWds1CaMpRsHdZAa4sWk/3pbCougiXwHcUlFqG5L9c+TEmTAqIobX8OVnj2whwIdX+zAArehvSGhXK1P3YygHSstnOYcXfsY+RTsw3DB3Gr92x9asQnA0R84ibd5l0XGNwBT/v8kxuBgsUhji+88y51EY2MGqNSlWgKw4pyR61LSxf8rDAMOAPq9y6BSOp0pugvUlBu1TwI1iwAONnxGLzCqssYx4m/Bck0g27qX9VwEYrJSUsLmWybkVSV2uKVsUAhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H8fyopZSxIBm25jEiJW8R+RIWxrb5yfw8UDcEFJ3KKs=;
 b=M4p/3cdPLrY1WayHXdDzHcEmKtuMO4oBdzs0XtTej6RZlyvy7OytsGpIIU5Nnu1geeBlE6UG9SK3/UmyPy7K4e+vFNVnafkzCoP2RlrvWfKjjA33En3Cdwmk9NLLbbDW92okifJpbQXIXM0fi9lOgLA5DPnxhdheLU3E1jN7Q7foH2QB+Hbkd46xPz27n1Y+brkmGGE0Bb3dE6gAbuYc3Qhe15/wLeoHr6q49a2QKvQw94uz2llWPwNJyMOf6l30S2qQ7NFuVpbgva6xYBndahDeRJMhSi/1+ktvViDH8PB+44aqdFTE8Yk1f+O7DSVqullBsndkXHHYr2Qx47HXzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H8fyopZSxIBm25jEiJW8R+RIWxrb5yfw8UDcEFJ3KKs=;
 b=uLL/Ku2KOgY8PEzwBGsDKwwwKSYkA75RXw3AnDSi0C6oJtu0yhZCmdaEFmmV/1a+yzZQrbpNtljhF0ah1dYoTEIwr9rbE7Uov0pfeQnABeOnVYn6qF41Fw9pUSF5AxlKCHMtC5YTRI8JL6z11+CPKU2i2vO5F3+QzPZmVZaXE/o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS4PR12MB9611.namprd12.prod.outlook.com (2603:10b6:8:277::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.23; Mon, 5 May
 2025 11:18:26 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%7]) with mapi id 15.20.8678.028; Mon, 5 May 2025
 11:18:26 +0000
Message-ID: <9b19ec16-468e-43b9-94a7-770e1defdca7@amd.com>
Date: Mon, 5 May 2025 13:18:17 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 6/6] RFC: dma-buf: Remove DMA-BUF statistics
To: "T.J. Mercier" <tjmercier@google.com>, sumit.semwal@linaro.org,
 ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, skhan@linuxfoundation.org, song@kernel.org,
 alexei.starovoitov@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 linux-doc@vger.kernel.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, android-mm@google.com, simona@ffwll.ch,
 corbet@lwn.net, eddyz87@gmail.com, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 jolsa@kernel.org, mykolal@fb.com
References: <20250504224149.1033867-1-tjmercier@google.com>
 <20250504224149.1033867-7-tjmercier@google.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250504224149.1033867-7-tjmercier@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0146.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:98::7) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS4PR12MB9611:EE_
X-MS-Office365-Filtering-Correlation-Id: f71ec533-0216-45f7-1137-08dd8bc68e35
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L1lVY2d3NTZ2RVpMTlJQUjE1Wm5ZeVkxK2ZiZGJFcUpRcjVzRXl2WnF6SzEr?=
 =?utf-8?B?aUJEek0xUUwwTC9GL1ZaNXdvaU9uajBWazQwUURDaEVOa0tTakhIV1FWTFVp?=
 =?utf-8?B?VDljcG1xZE9tNzJSdCtjdzdNOUVDcGpDaFRJWlJ0TWdVdDd5ald4dk96emxD?=
 =?utf-8?B?R1ZWNkxkZUhCMDVqaXFvVGpQbkExMWJMQ1RFR1ptMjJBdEdva2RlTXNwOU9T?=
 =?utf-8?B?VWhPeWQwOUd1WmFlOU5LVlRKMkFJYWpBWjBYU1RSZHgraTBTaU8xTE9sbEdE?=
 =?utf-8?B?K2ZPbXRCZllDVlJKZzNLSDVYWVp0aUc0bVBSY2FOR2xUMFRoaXN0R1lKRDhL?=
 =?utf-8?B?bFozTThzZjhnMVEzeGhmZEIwUUVrNDkyMlhPMk0xQ2I1ckYvR1o2SWg4MEdI?=
 =?utf-8?B?b25ydmlyWkhlWDBsY3FIeUtHcW9nZHNOY3ZiZXRZZHR3eXVhbmVVZElhYzJN?=
 =?utf-8?B?MTdmeUNNUDNIaVF0REtEQTdXZjlFbW1sL29rR3lHYlVYNk1PRDVxNkxrRjl4?=
 =?utf-8?B?TEduMjhtQ1lhaHczczhIM3JtRG0yMXhROHFWUjRSL3JaSXRzQ2dJV2NLMElS?=
 =?utf-8?B?a1ZKbk80ZHJzdG1ta1VYbThIaGpmblhMKzA4LzlpdVQzTy9xbTFibFh2VURa?=
 =?utf-8?B?bk42N3FYMEhhaXh4OEd6QmpLNE01eGgzcjF2VXljU09Ga3kxRU5QS2czb0xa?=
 =?utf-8?B?N29VMHdXdzJjRFhGZW91c1N2SmxlYzJaWldtc2ZBaU9TVnQzalZWeWxtK0xk?=
 =?utf-8?B?bzlUNitUVnBBUzQ1ZGJUQSsvbmhGb0xZZTRkRGdlRTR2REFHaGszNWhIYmFO?=
 =?utf-8?B?MC9Vd2RJK09sL0dJZVdvNCt4L1FBOXp1SzZYcS9LcGdKNEt6WnNOOWg0b2hH?=
 =?utf-8?B?VDl5MmNsdzVrcGhNb1A5VUZkTDg1TVdubXl3ZVNVOTROT1ljQmRqUVJaYzNr?=
 =?utf-8?B?aFhxQldESE9ERHBjQlcra3Bpazh1M0R4L1JXbjBIM2RIQnpDdTRENUJ0NFIw?=
 =?utf-8?B?cXlOUmhaem50ZEhzTm1YWC80cWM5Wi9DeEQzYWdmaEpsK0hjOFJIajAwb0xz?=
 =?utf-8?B?MlpOWkJ3bkpITWVldDhsWVZlckJ0VDc0a3gydVkvL3lYZU9wdEcrRmZncHFt?=
 =?utf-8?B?bEhzWkZ2alFLcCtSN1lEZW1EN1lvVWc5d0daSUZ3VWtiaVFBd3U0cGRvK3do?=
 =?utf-8?B?MFRmNEFaNVRGejNEaS9uYTZPbXBHbjN2NlhtUDlFSE13VlMwSDJWTWZ4S1RJ?=
 =?utf-8?B?azh0OGVHN2lCK0ozbDg0ZVhJVGFZZFZQVkw0dTlRVjRzT2NMMnBRQlRnNS9S?=
 =?utf-8?B?dHhyOWNNbGlGNHJvK3VzRHNmNjZ5cEd1a3hqNmw3dzVtU1RhSC9BcHI2TGND?=
 =?utf-8?B?UjRhZ1NGTmJwRnk2TGVWV3M5RHZCUDRhMlpCYjA3Q2podWFzSXlNckhFYmF6?=
 =?utf-8?B?TmJPMnh1QjFtUVpIVlJ0Rk93Nzl0cFdLZG9kWnMyL25rYnVxbVBNcVc5Q2g1?=
 =?utf-8?B?d2NwTW9uaU9JUFAvUzBBTTFVdEVtRHVHZXZoWXovWm1ISXM3eEVlYitsZVlJ?=
 =?utf-8?B?eC92M3lpTlliU0FjWXNQS2lVNmQ0MDBjSE5SNHN0QzY1aXl2QzNOdVJ0dU5m?=
 =?utf-8?B?K084RTRFSW5tYTdKT3lQc3VhU2UydU1sMEhQUEhwRFRBL2NDQWdnc05wZDE5?=
 =?utf-8?B?SlZBRms0L29HbjNxZmdibUk4RzRIV1lHdFRhVk5JODFEeEJWcGllRVEyMVRv?=
 =?utf-8?B?UEg0dXY3b2thNFA5bTVOOTlIWTAyRWowLzcvejRJYXY2WjdRMzdHZjRIeW9m?=
 =?utf-8?B?Y2FvSFVuazY4N2MwMHUzQ3EvQzNHTVJOWVNPNGFNOENRNGRGVHZwUmxMRVhJ?=
 =?utf-8?B?aStsWFo1Nmw4UXQyOFU5MFBnMGovVkhVUHBTalk0eTNqekExNThuSTF4NmpT?=
 =?utf-8?Q?CKepHwQfgUw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WFRkOW9rTUNDcW05MEFER0djRVpISHBWcUkzblYrNjhIR1lLNm5XRUFhbGxL?=
 =?utf-8?B?aDFSTnE2ZDB5VjJObktMUG9BalJzQlY3YTd6eDEwSWZYRHZUbE5mTWszbjY4?=
 =?utf-8?B?anBCY1ZwMUZ6MGFSQVBiK2JEaHpuWWw5clhheUhSQjJ6dndjTXpVS0JRaVg0?=
 =?utf-8?B?cGRSS1JwOWF2Y0VLSUhlY056bThqYTZBQnhPdzFMV1JBckY4OUxmbTdBb0I1?=
 =?utf-8?B?SlhCZE5YM3BVdkl6UVpRemZZN1o3Um1TZGJzKzhiSUhFYjAzVzZldHByYnlF?=
 =?utf-8?B?TDdCTUVJY0lya285aWovanlOUFNsWUR0MDVoMjJRV0c5eVlFRytXWVU0NUdX?=
 =?utf-8?B?cTh6THlKdUlvOHF5Q09Cdk9PMWpNV05ZbnpnelJkYzFlZXJaeFo4MXVNMzdp?=
 =?utf-8?B?c3BCTE5FdmRKc0tsdWNBTTBIakwwNEp2VlM3Yi9IVkg1YkJiUWlwRTFRYm1K?=
 =?utf-8?B?a2M4c001dWVBY2J0REQyWlo1K2o5M1YveHdpN0FaY3NvTS9NY3FGS01ITVBN?=
 =?utf-8?B?OCtRRVdMcW5RUG5xZ2Zqb1dySU9EeWdYV2lNMjVxTm9PWGJ5dGxVT3BSTFEx?=
 =?utf-8?B?S3Bja21Qa3ZLcW9VcFkzQjl2dVdTVEZUSFZDUnlNY1VkcWsvVzZqV21OV29F?=
 =?utf-8?B?Z2I0aXREMUxYQ0NKWW93eTVza09uZHB2SVRKejBpUGpBUEkrQlpSczcxK1JZ?=
 =?utf-8?B?Smw3WEc2ZGpQeVRqNmp2cU1qNkxic3JJZTh6cGtDWEVVb1lsejk5VXJUdmJW?=
 =?utf-8?B?dEtvNENueTV0a0FWN3ZuR3BmeHdsTEVjMUFzeDVNZ0FMOWhHSXdCZ1cvbXdq?=
 =?utf-8?B?QzlWSzIyRnA4L3FtQ0UydkE1Q2ZhWEZUWTMrMHlKRUgrd3NMNlo4SUo3Tjhv?=
 =?utf-8?B?M244eERjWm02dTRnOW1vMVZkRWVxaVd6c2g5dTEzTzFvcHhpcmg3NVE4RXNH?=
 =?utf-8?B?WTV0MmYrSXhuSmNkTFRHdWV0aEFBc0haL2JBM1VyZXRPME03bndocitLYTZi?=
 =?utf-8?B?L1ZueU5reTFwbUloWHk2c0Y3QUZxOFhwN0VPd25TTnMvZ0ZFQzArVXNXNkx6?=
 =?utf-8?B?OVpSWlZ4aGNGMm80SGYxVW1jLzRBc1pDT1U5VlVFMVY5TXVtUG5jUklScUZV?=
 =?utf-8?B?RHB6SlZUbE9Hc1Jrekx3RFpONjBFd21SNmpFNVRmNUZyRFowRnUyM1JuOCtU?=
 =?utf-8?B?Zi9LMHhXVmtFd0p3ZXVpaGpNc01BUFVCMW9HWDlDNzk1c0h3Q3c3d1RWRkZj?=
 =?utf-8?B?cG5DSVFlNEE4Qks4b1BLQXc4WFZXeTRpQWFzYWdUbWpBc0lHcmFIblZ1ZFV5?=
 =?utf-8?B?Sklma0UzWkptaEk2SkpBcUJWUmV1UEI2OHkxZjY5cVh1bjJOaTBxdTM0SlAz?=
 =?utf-8?B?eE1sNXNTTXB3YmEvRGNGb2llSTBKSGUwaHpFQ011akNHNkoxMitKTzhEOUFK?=
 =?utf-8?B?aWV1SEUyakdyMnJqa0FkRzJ5ZS8veG5VcEJTamRLUnBVNTc5eitERlBmbkpq?=
 =?utf-8?B?cDNWeksyWWpyN3NzbHp0WVQ3bFNqRkQ0TDVWSVA3aGJvUXZnQ2NEVzY3Wlpi?=
 =?utf-8?B?K0R0Y0N2OWcybGxGQ3dNM3FDL1k2TjhjUk9HNG1RVytNQ1oyVEFxMmJtUHFM?=
 =?utf-8?B?emdsckRCQWV0WXJQRk5ETDM2VUc0K0o5MStaeWxwbXVxbndGT0Z1Y2ZxZ25a?=
 =?utf-8?B?b0xWV1J1RGhrT2FDQlJQWWRDeUd6M1VDQnpZbUFJTnFqMVdrZHlIVTZOdEdX?=
 =?utf-8?B?aGtaM0I3c2dsSmFHSDBKU1dmeG1RbnB1L3pkU3FkL0pVSmpnaW5OdC9qaG9q?=
 =?utf-8?B?MnF0amNmWUd6dU9JeGxmalBiV3hpcWZhdTFFcFBZUzJqUlkvNW8xVC85eXJl?=
 =?utf-8?B?djk2dHZaZTBZcll6aFhnN3M2QkdOMTArdzBmVHRoOGlGaThyVnBiZHdQWGND?=
 =?utf-8?B?MXc0UWdwckFEVnFtOUtzak1pQ0N3Z0V5Wm04a2RIbUNDWll5a2JKZE91V0ky?=
 =?utf-8?B?THhialJOMDY2d1JWNWdYYVVNRno2WTI4VHo3SUNlTzdxa2lhbTNRU2EvWmNK?=
 =?utf-8?B?aUMxMG5TSCtVb25TcTVFMnFrZ3oyUG9leXdlUTRaeHlWaTR5Rm5yamtPZ1RU?=
 =?utf-8?Q?Mi8w=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f71ec533-0216-45f7-1137-08dd8bc68e35
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2025 11:18:26.3771
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3NOvA3H46febVT8+6PqBPgw7+7BU+taJUcnW3GJ9r5vfEpRv88uClqdg8EUFh/pP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9611

On 5/5/25 00:41, T.J. Mercier wrote:
> I think Android is probably the only remaining user of the dmabuf sysfs
> files. The BPF infrastructure added earlier in this series will allow us
> to get the same information much more cheaply.
> 
> This patch is a RFC because I'd like to keep this for at least one more
> longterm stable release (6.18?) before actually removing it so that we
> can have one longterm stable kernel version that supports both options
> to facilitate a transition from the sysfs files to a BPF program.

Sounds like a plan to me.

> 
> Signed-off-by: T.J. Mercier <tjmercier@google.com>

Acked-by: Christian König <christian.koenig@amd.com>

> ---
>  .../ABI/testing/sysfs-kernel-dmabuf-buffers   |  24 ---
>  Documentation/driver-api/dma-buf.rst          |   5 -
>  drivers/dma-buf/Kconfig                       |  15 --
>  drivers/dma-buf/Makefile                      |   1 -
>  drivers/dma-buf/dma-buf-sysfs-stats.c         | 202 ------------------
>  drivers/dma-buf/dma-buf-sysfs-stats.h         |  35 ---
>  drivers/dma-buf/dma-buf.c                     |  18 --
>  7 files changed, 300 deletions(-)
>  delete mode 100644 Documentation/ABI/testing/sysfs-kernel-dmabuf-buffers
>  delete mode 100644 drivers/dma-buf/dma-buf-sysfs-stats.c
>  delete mode 100644 drivers/dma-buf/dma-buf-sysfs-stats.h
> 
> diff --git a/Documentation/ABI/testing/sysfs-kernel-dmabuf-buffers b/Documentation/ABI/testing/sysfs-kernel-dmabuf-buffers
> deleted file mode 100644
> index 5d3bc997dc64..000000000000
> --- a/Documentation/ABI/testing/sysfs-kernel-dmabuf-buffers
> +++ /dev/null
> @@ -1,24 +0,0 @@
> -What:		/sys/kernel/dmabuf/buffers
> -Date:		May 2021
> -KernelVersion:	v5.13
> -Contact:	Hridya Valsaraju <hridya@google.com>
> -Description:	The /sys/kernel/dmabuf/buffers directory contains a
> -		snapshot of the internal state of every DMA-BUF.
> -		/sys/kernel/dmabuf/buffers/<inode_number> will contain the
> -		statistics for the DMA-BUF with the unique inode number
> -		<inode_number>
> -Users:		kernel memory tuning/debugging tools
> -
> -What:		/sys/kernel/dmabuf/buffers/<inode_number>/exporter_name
> -Date:		May 2021
> -KernelVersion:	v5.13
> -Contact:	Hridya Valsaraju <hridya@google.com>
> -Description:	This file is read-only and contains the name of the exporter of
> -		the DMA-BUF.
> -
> -What:		/sys/kernel/dmabuf/buffers/<inode_number>/size
> -Date:		May 2021
> -KernelVersion:	v5.13
> -Contact:	Hridya Valsaraju <hridya@google.com>
> -Description:	This file is read-only and specifies the size of the DMA-BUF in
> -		bytes.
> diff --git a/Documentation/driver-api/dma-buf.rst b/Documentation/driver-api/dma-buf.rst
> index 29abf1eebf9f..2f36c21d9948 100644
> --- a/Documentation/driver-api/dma-buf.rst
> +++ b/Documentation/driver-api/dma-buf.rst
> @@ -125,11 +125,6 @@ Implicit Fence Poll Support
>  .. kernel-doc:: drivers/dma-buf/dma-buf.c
>     :doc: implicit fence polling
>  
> -DMA-BUF statistics
> -~~~~~~~~~~~~~~~~~~
> -.. kernel-doc:: drivers/dma-buf/dma-buf-sysfs-stats.c
> -   :doc: overview
> -
>  DMA Buffer ioctls
>  ~~~~~~~~~~~~~~~~~
>  
> diff --git a/drivers/dma-buf/Kconfig b/drivers/dma-buf/Kconfig
> index fee04fdb0822..03e38c0d1fff 100644
> --- a/drivers/dma-buf/Kconfig
> +++ b/drivers/dma-buf/Kconfig
> @@ -76,21 +76,6 @@ menuconfig DMABUF_HEAPS
>  	  allows userspace to allocate dma-bufs that can be shared
>  	  between drivers.
>  
> -menuconfig DMABUF_SYSFS_STATS
> -	bool "DMA-BUF sysfs statistics (DEPRECATED)"
> -	depends on DMA_SHARED_BUFFER
> -	help
> -	   Choose this option to enable DMA-BUF sysfs statistics
> -	   in location /sys/kernel/dmabuf/buffers.
> -
> -	   /sys/kernel/dmabuf/buffers/<inode_number> will contain
> -	   statistics for the DMA-BUF with the unique inode number
> -	   <inode_number>.
> -
> -	   This option is deprecated and should sooner or later be removed.
> -	   Android is the only user of this and it turned out that this resulted
> -	   in quite some performance problems.
> -
>  source "drivers/dma-buf/heaps/Kconfig"
>  
>  endmenu
> diff --git a/drivers/dma-buf/Makefile b/drivers/dma-buf/Makefile
> index 70ec901edf2c..8ab2bfecb1c9 100644
> --- a/drivers/dma-buf/Makefile
> +++ b/drivers/dma-buf/Makefile
> @@ -6,7 +6,6 @@ obj-$(CONFIG_DMABUF_HEAPS)	+= heaps/
>  obj-$(CONFIG_SYNC_FILE)		+= sync_file.o
>  obj-$(CONFIG_SW_SYNC)		+= sw_sync.o sync_debug.o
>  obj-$(CONFIG_UDMABUF)		+= udmabuf.o
> -obj-$(CONFIG_DMABUF_SYSFS_STATS) += dma-buf-sysfs-stats.o
>  
>  dmabuf_selftests-y := \
>  	selftest.o \
> diff --git a/drivers/dma-buf/dma-buf-sysfs-stats.c b/drivers/dma-buf/dma-buf-sysfs-stats.c
> deleted file mode 100644
> index b5b62e40ccc1..000000000000
> --- a/drivers/dma-buf/dma-buf-sysfs-stats.c
> +++ /dev/null
> @@ -1,202 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-only
> -/*
> - * DMA-BUF sysfs statistics.
> - *
> - * Copyright (C) 2021 Google LLC.
> - */
> -
> -#include <linux/dma-buf.h>
> -#include <linux/dma-resv.h>
> -#include <linux/kobject.h>
> -#include <linux/printk.h>
> -#include <linux/slab.h>
> -#include <linux/sysfs.h>
> -
> -#include "dma-buf-sysfs-stats.h"
> -
> -#define to_dma_buf_entry_from_kobj(x) container_of(x, struct dma_buf_sysfs_entry, kobj)
> -
> -/**
> - * DOC: overview
> - *
> - * ``/sys/kernel/debug/dma_buf/bufinfo`` provides an overview of every DMA-BUF
> - * in the system. However, since debugfs is not safe to be mounted in
> - * production, procfs and sysfs can be used to gather DMA-BUF statistics on
> - * production systems.
> - *
> - * The ``/proc/<pid>/fdinfo/<fd>`` files in procfs can be used to gather
> - * information about DMA-BUF fds. Detailed documentation about the interface
> - * is present in Documentation/filesystems/proc.rst.
> - *
> - * Unfortunately, the existing procfs interfaces can only provide information
> - * about the DMA-BUFs for which processes hold fds or have the buffers mmapped
> - * into their address space. This necessitated the creation of the DMA-BUF sysfs
> - * statistics interface to provide per-buffer information on production systems.
> - *
> - * The interface at ``/sys/kernel/dmabuf/buffers`` exposes information about
> - * every DMA-BUF when ``CONFIG_DMABUF_SYSFS_STATS`` is enabled.
> - *
> - * The following stats are exposed by the interface:
> - *
> - * * ``/sys/kernel/dmabuf/buffers/<inode_number>/exporter_name``
> - * * ``/sys/kernel/dmabuf/buffers/<inode_number>/size``
> - *
> - * The information in the interface can also be used to derive per-exporter
> - * statistics. The data from the interface can be gathered on error conditions
> - * or other important events to provide a snapshot of DMA-BUF usage.
> - * It can also be collected periodically by telemetry to monitor various metrics.
> - *
> - * Detailed documentation about the interface is present in
> - * Documentation/ABI/testing/sysfs-kernel-dmabuf-buffers.
> - */
> -
> -struct dma_buf_stats_attribute {
> -	struct attribute attr;
> -	ssize_t (*show)(struct dma_buf *dmabuf,
> -			struct dma_buf_stats_attribute *attr, char *buf);
> -};
> -#define to_dma_buf_stats_attr(x) container_of(x, struct dma_buf_stats_attribute, attr)
> -
> -static ssize_t dma_buf_stats_attribute_show(struct kobject *kobj,
> -					    struct attribute *attr,
> -					    char *buf)
> -{
> -	struct dma_buf_stats_attribute *attribute;
> -	struct dma_buf_sysfs_entry *sysfs_entry;
> -	struct dma_buf *dmabuf;
> -
> -	attribute = to_dma_buf_stats_attr(attr);
> -	sysfs_entry = to_dma_buf_entry_from_kobj(kobj);
> -	dmabuf = sysfs_entry->dmabuf;
> -
> -	if (!dmabuf || !attribute->show)
> -		return -EIO;
> -
> -	return attribute->show(dmabuf, attribute, buf);
> -}
> -
> -static const struct sysfs_ops dma_buf_stats_sysfs_ops = {
> -	.show = dma_buf_stats_attribute_show,
> -};
> -
> -static ssize_t exporter_name_show(struct dma_buf *dmabuf,
> -				  struct dma_buf_stats_attribute *attr,
> -				  char *buf)
> -{
> -	return sysfs_emit(buf, "%s\n", dmabuf->exp_name);
> -}
> -
> -static ssize_t size_show(struct dma_buf *dmabuf,
> -			 struct dma_buf_stats_attribute *attr,
> -			 char *buf)
> -{
> -	return sysfs_emit(buf, "%zu\n", dmabuf->size);
> -}
> -
> -static struct dma_buf_stats_attribute exporter_name_attribute =
> -	__ATTR_RO(exporter_name);
> -static struct dma_buf_stats_attribute size_attribute = __ATTR_RO(size);
> -
> -static struct attribute *dma_buf_stats_default_attrs[] = {
> -	&exporter_name_attribute.attr,
> -	&size_attribute.attr,
> -	NULL,
> -};
> -ATTRIBUTE_GROUPS(dma_buf_stats_default);
> -
> -static void dma_buf_sysfs_release(struct kobject *kobj)
> -{
> -	struct dma_buf_sysfs_entry *sysfs_entry;
> -
> -	sysfs_entry = to_dma_buf_entry_from_kobj(kobj);
> -	kfree(sysfs_entry);
> -}
> -
> -static const struct kobj_type dma_buf_ktype = {
> -	.sysfs_ops = &dma_buf_stats_sysfs_ops,
> -	.release = dma_buf_sysfs_release,
> -	.default_groups = dma_buf_stats_default_groups,
> -};
> -
> -void dma_buf_stats_teardown(struct dma_buf *dmabuf)
> -{
> -	struct dma_buf_sysfs_entry *sysfs_entry;
> -
> -	sysfs_entry = dmabuf->sysfs_entry;
> -	if (!sysfs_entry)
> -		return;
> -
> -	kobject_del(&sysfs_entry->kobj);
> -	kobject_put(&sysfs_entry->kobj);
> -}
> -
> -
> -/* Statistics files do not need to send uevents. */
> -static int dmabuf_sysfs_uevent_filter(const struct kobject *kobj)
> -{
> -	return 0;
> -}
> -
> -static const struct kset_uevent_ops dmabuf_sysfs_no_uevent_ops = {
> -	.filter = dmabuf_sysfs_uevent_filter,
> -};
> -
> -static struct kset *dma_buf_stats_kset;
> -static struct kset *dma_buf_per_buffer_stats_kset;
> -int dma_buf_init_sysfs_statistics(void)
> -{
> -	dma_buf_stats_kset = kset_create_and_add("dmabuf",
> -						 &dmabuf_sysfs_no_uevent_ops,
> -						 kernel_kobj);
> -	if (!dma_buf_stats_kset)
> -		return -ENOMEM;
> -
> -	dma_buf_per_buffer_stats_kset = kset_create_and_add("buffers",
> -							    &dmabuf_sysfs_no_uevent_ops,
> -							    &dma_buf_stats_kset->kobj);
> -	if (!dma_buf_per_buffer_stats_kset) {
> -		kset_unregister(dma_buf_stats_kset);
> -		return -ENOMEM;
> -	}
> -
> -	return 0;
> -}
> -
> -void dma_buf_uninit_sysfs_statistics(void)
> -{
> -	kset_unregister(dma_buf_per_buffer_stats_kset);
> -	kset_unregister(dma_buf_stats_kset);
> -}
> -
> -int dma_buf_stats_setup(struct dma_buf *dmabuf, struct file *file)
> -{
> -	struct dma_buf_sysfs_entry *sysfs_entry;
> -	int ret;
> -
> -	if (!dmabuf->exp_name) {
> -		pr_err("exporter name must not be empty if stats needed\n");
> -		return -EINVAL;
> -	}
> -
> -	sysfs_entry = kzalloc(sizeof(struct dma_buf_sysfs_entry), GFP_KERNEL);
> -	if (!sysfs_entry)
> -		return -ENOMEM;
> -
> -	sysfs_entry->kobj.kset = dma_buf_per_buffer_stats_kset;
> -	sysfs_entry->dmabuf = dmabuf;
> -
> -	dmabuf->sysfs_entry = sysfs_entry;
> -
> -	/* create the directory for buffer stats */
> -	ret = kobject_init_and_add(&sysfs_entry->kobj, &dma_buf_ktype, NULL,
> -				   "%lu", file_inode(file)->i_ino);
> -	if (ret)
> -		goto err_sysfs_dmabuf;
> -
> -	return 0;
> -
> -err_sysfs_dmabuf:
> -	kobject_put(&sysfs_entry->kobj);
> -	dmabuf->sysfs_entry = NULL;
> -	return ret;
> -}
> diff --git a/drivers/dma-buf/dma-buf-sysfs-stats.h b/drivers/dma-buf/dma-buf-sysfs-stats.h
> deleted file mode 100644
> index 7a8a995b75ba..000000000000
> --- a/drivers/dma-buf/dma-buf-sysfs-stats.h
> +++ /dev/null
> @@ -1,35 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0-only */
> -/*
> - * DMA-BUF sysfs statistics.
> - *
> - * Copyright (C) 2021 Google LLC.
> - */
> -
> -#ifndef _DMA_BUF_SYSFS_STATS_H
> -#define _DMA_BUF_SYSFS_STATS_H
> -
> -#ifdef CONFIG_DMABUF_SYSFS_STATS
> -
> -int dma_buf_init_sysfs_statistics(void);
> -void dma_buf_uninit_sysfs_statistics(void);
> -
> -int dma_buf_stats_setup(struct dma_buf *dmabuf, struct file *file);
> -
> -void dma_buf_stats_teardown(struct dma_buf *dmabuf);
> -#else
> -
> -static inline int dma_buf_init_sysfs_statistics(void)
> -{
> -	return 0;
> -}
> -
> -static inline void dma_buf_uninit_sysfs_statistics(void) {}
> -
> -static inline int dma_buf_stats_setup(struct dma_buf *dmabuf, struct file *file)
> -{
> -	return 0;
> -}
> -
> -static inline void dma_buf_stats_teardown(struct dma_buf *dmabuf) {}
> -#endif
> -#endif // _DMA_BUF_SYSFS_STATS_H
> diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
> index 7260bdd77c75..adc6a0c96641 100644
> --- a/drivers/dma-buf/dma-buf.c
> +++ b/drivers/dma-buf/dma-buf.c
> @@ -31,8 +31,6 @@
>  #include <uapi/linux/dma-buf.h>
>  #include <uapi/linux/magic.h>
>  
> -#include "dma-buf-sysfs-stats.h"
> -
>  static inline int is_dma_buf_file(struct file *);
>  
>  DEFINE_MUTEX(dmabuf_list_mutex);
> @@ -88,7 +86,6 @@ static void dma_buf_release(struct dentry *dentry)
>  	 */
>  	BUG_ON(dmabuf->cb_in.active || dmabuf->cb_out.active);
>  
> -	dma_buf_stats_teardown(dmabuf);
>  	dmabuf->ops->release(dmabuf);
>  
>  	if (dmabuf->resv == (struct dma_resv *)&dmabuf[1])
> @@ -671,10 +668,6 @@ struct dma_buf *dma_buf_export(const struct dma_buf_export_info *exp_info)
>  		dmabuf->resv = resv;
>  	}
>  
> -	ret = dma_buf_stats_setup(dmabuf, file);
> -	if (ret)
> -		goto err_dmabuf;
> -
>  	file->private_data = dmabuf;
>  	file->f_path.dentry->d_fsdata = dmabuf;
>  	dmabuf->file = file;
> @@ -683,10 +676,6 @@ struct dma_buf *dma_buf_export(const struct dma_buf_export_info *exp_info)
>  
>  	return dmabuf;
>  
> -err_dmabuf:
> -	if (!resv)
> -		dma_resv_fini(dmabuf->resv);
> -	kfree(dmabuf);
>  err_file:
>  	fput(file);
>  err_module:
> @@ -1717,12 +1706,6 @@ static inline void dma_buf_uninit_debugfs(void)
>  
>  static int __init dma_buf_init(void)
>  {
> -	int ret;
> -
> -	ret = dma_buf_init_sysfs_statistics();
> -	if (ret)
> -		return ret;
> -
>  	dma_buf_mnt = kern_mount(&dma_buf_fs_type);
>  	if (IS_ERR(dma_buf_mnt))
>  		return PTR_ERR(dma_buf_mnt);
> @@ -1736,6 +1719,5 @@ static void __exit dma_buf_deinit(void)
>  {
>  	dma_buf_uninit_debugfs();
>  	kern_unmount(dma_buf_mnt);
> -	dma_buf_uninit_sysfs_statistics();
>  }
>  __exitcall(dma_buf_deinit);


