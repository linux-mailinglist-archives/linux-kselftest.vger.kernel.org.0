Return-Path: <linux-kselftest+bounces-9630-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 690738BEA0A
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 May 2024 19:06:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CC3C1C20EB9
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 May 2024 17:06:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B82654BD3;
	Tue,  7 May 2024 17:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="U3rPIS21"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2064.outbound.protection.outlook.com [40.107.94.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D94BBB672;
	Tue,  7 May 2024 17:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715101575; cv=fail; b=Qv5tvjGdc5nKG0r8rKcS0Exu/s9PU6572Yw9dhethrmyN0sWr+GDGaDL41CJdejDqvM1Ij2NGm3/jXNHUjgzWu41jlqnszJCKUjy2qKNGJ9dgJDCtFSoPuNjQ2HfTlUQGgrxt0cgyesGIzU4vcnIVGA/pxzK3hLW9E/xROsP7QQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715101575; c=relaxed/simple;
	bh=w6KrAknsO/2SK5EdWbJF8wiCgtBTxeeY86CWcZsTYCE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Sjb93Zf+7VFpaBpYToG9uZprdK7xuNWkEhSVqgBNQpIvTP1i6X8i5mZXQvUuyLgB0Qsi1synOdvP9ayHJA0HNF9bs3Z0GYpFBCU6n6LX5MgGbjvU3baekBc8SOul/tNPFdYZ1iLfTHzGFKpEkL9eBnzNBrn1Caqls+PP6OpVhtU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=U3rPIS21; arc=fail smtp.client-ip=40.107.94.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QAsfwCfPFim6xtodM9AGbOy/1o3NQK5ZWtmUpNABRvKYjxMorTM8+Sr5fLC9QWvBMNPrwpEaX5oDjRXXxtSBy+RAE7mF7WPnGFs8vVLBYbNjInozLCjgHmZRQokiHcrHlAEweIiEcexMJYE8l5P3q3FAdBfTUAFpLiNDK82vVYnBEO9iLFP0LQRgCJfj/Ohpi58KLwNKQcxzrxqAp1BYX1P2yPBSA9+TL8bo/+mkmm2EvZKg7oCBfQnKy4EF8VO0Pq3w25rWf/t9eafhtxd0hCdB0iMB0LtH7lsr7K+MFWlYlCc3ofVQ8Xx1L6JwxMcTUYvv67m3qdmPqJJJu0Z+DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TMF06TTGEUlZ9uMPlGu9NpNLUJDeA9hLf2ZyTn1w+K8=;
 b=Iyfoi4KFvgohb/tUo0nAgkq3fKYT/PT003GxtDo4FQ25zC44MOZs6XGRXFvRXS8LxwD3ra1i91OOydBmj1siTXGXM+/Lc0KzcGLgRbm2j0gJ4/PIFIBZ5XfRUehvYys2M4+mHZhudmc9nFCGSJv054+VGj6UAYHgVCH6emvK9NOC5Mo1Cln6xUUc/AeO9JDs2r0GoO1+VHZCf59qAmR8EcyCkzKTBSupnQt4Hfb4cZjUn+dLvrVRWgPAgKOuzqVb4+iBCoCI02wIF7oi7goMYJV5hB/lNXAxxR+ljLHhPFwQWaBD+kH+sHH+X9l5Maz5atspokgwqIIVI0XAgWDdog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TMF06TTGEUlZ9uMPlGu9NpNLUJDeA9hLf2ZyTn1w+K8=;
 b=U3rPIS21ObHac6jd9FVz5toz2L933XR3Nw+Ma9no7NhR9lImlm9ZqRllLEjonDif+6DAwPOlxBy7w9o3TdjeBHSbVsDtcu9o0jEyyabcy2sdUgjk44JP1oKNeVIwnf/25je8LjRt8KZsA5aDjdgs6/4t2q4Dl+d1zZuKFeBnliUHJcO0VFbkpIbRDJ7mFs+dFL9q8mONlL/Ut+jAVJ/OOgQJk3gYyFW2+IElCtojEgSb0w1ZBiHCl7/TNS879QY7BXJJJ6QuyCWFLlI6xwQjQ75dEsaLNgPEi4MRJwMWaCq8G0TZmag+7+GoPEtw/9WTi4Gl4d6IOilz8kOaX4tCbg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4140.namprd12.prod.outlook.com (2603:10b6:5:221::13)
 by IA1PR12MB7712.namprd12.prod.outlook.com (2603:10b6:208:420::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42; Tue, 7 May
 2024 17:06:01 +0000
Received: from DM6PR12MB4140.namprd12.prod.outlook.com
 ([fe80::5b0:8154:dfef:2cac]) by DM6PR12MB4140.namprd12.prod.outlook.com
 ([fe80::5b0:8154:dfef:2cac%3]) with mapi id 15.20.7544.041; Tue, 7 May 2024
 17:06:01 +0000
Message-ID: <edca87be-d8a7-4c62-b9c1-f9b3f5752595@nvidia.com>
Date: Tue, 7 May 2024 10:05:49 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] selftests/netfilter: return a value for several "int"
 functions
To: Felix Huettner <felix.huettner@mail.schwarz>
Cc: Shuah Khan <shuah@kernel.org>, Phil Sutter <phil@nwl.cc>,
 Pablo Neira Ayuso <pablo@netfilter.org>, Florian Westphal <fw@strlen.de>,
 Max Lamprecht <max.lamprecht@mail.schwarz>,
 Luca Czesla <luca.czesla@mail.schwarz>, Xin Long <lucien.xin@gmail.com>,
 "David S . Miller" <davem@davemloft.net>, Paul Moore <paul@paul-moore.com>,
 Richard Guy Briggs <rgb@redhat.com>,
 Boris Sukholitko <boris.sukholitko@broadcom.com>,
 Valentin Obst <kernel@valentinobst.de>, linux-kselftest@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>, llvm@lists.linux.dev
References: <20240505214716.62304-1-jhubbard@nvidia.com>
 <20240505214716.62304-2-jhubbard@nvidia.com>
 <ZjjsGW314qCgpTKs@felix.runs.onstackit.cloud>
 <b20d43d6-8d01-480c-af1d-90c0acd35d5c@nvidia.com>
 <ZjnoFfkyREHWUPtq@felix.runs.onstackit.cloud>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <ZjnoFfkyREHWUPtq@felix.runs.onstackit.cloud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY3PR05CA0036.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::11) To DM6PR12MB4140.namprd12.prod.outlook.com
 (2603:10b6:5:221::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4140:EE_|IA1PR12MB7712:EE_
X-MS-Office365-Filtering-Correlation-Id: 62909de8-0adc-492e-6ad4-08dc6eb7f8c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015|7416005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?a0htT2QwdTZ4S3E4NFB0d0h0NDJDWmdZVkpiSGw3Y2lwV0U1NXUzWUJKWHh3?=
 =?utf-8?B?QnI3eHpmRlZ5azhmOTdzN1U2Y0o5elhBKzZzTmZQT0Jxa3VFUWNiRlBoYWpH?=
 =?utf-8?B?b0thbW5wY0VqTWdRWHdmdEF2RCs3aml1UUxPazF0M01zL1NTcTVxcVhiQWJa?=
 =?utf-8?B?UWJIVHFqNTZMaHI2d0lDbXVMMFdXQVdIYUxIekQwQmVzL1JINCt4NjFyYWlr?=
 =?utf-8?B?dGlYaGZsMGluQkJVM2RLOW1OYkdrczdHdGtuT1ltbTdMZmRPbjlLU0cxZjBm?=
 =?utf-8?B?WkxWQ1dORmYxN2hNdWZFZ2MzZit1T2FKNytqS0NlTStYQXV5Tmdyb3cweFhp?=
 =?utf-8?B?LzhNZkRpNE5UQllYR2NYSHlHd2tsK0JvU0gxU3VDeEZUM3AxQnhvUS85dFhQ?=
 =?utf-8?B?QW5qaGVkNGFmUGtYdmR2Yk04WjZPQjZQSllVQjRQeTI4Qy9YZ0ZZN1lqcUtN?=
 =?utf-8?B?NHVzWjEzenByR3BqYnNNR282aDQvK1c3RnFiU3QxYkNCL2NvZTJxZnA1dXQr?=
 =?utf-8?B?MWE0a0VwTTdmYTJkbmxLU2FOQldJOEhPcVNEWVZNck9nRFdTSjd0eW1rUVVQ?=
 =?utf-8?B?dGtYUG44NWdrV0tSZElFRnhSSGVMcUJVUkF0WFVhUmRaRlprVXM5VmVVUWdy?=
 =?utf-8?B?SmxaY1krRVRSSEIwYXM2bzVMZG5tUS9lVjNnMDNSbktKU3pBd2I5TmtxeDJU?=
 =?utf-8?B?WHJ5WUh6ZTJJMGM5SjExNjdieUJNNWVZWFQzZkpiL3BIeTdsNUk0UE40VzJW?=
 =?utf-8?B?dDd2RXgvaVEzcjBHcDRLNTA2QXB1U20xUzJGbDQ2cndzQkRRNlV0Wmp3NkJo?=
 =?utf-8?B?QXJIZ1MwOEppRWtDb0VSeDVqWUNxVm8zNFFGRXZDeVZ3Qll1LzdVS0w4UUhC?=
 =?utf-8?B?RytncGEyeDdOR05uMU9tQlVIWkZxNWdUUVc5MWl1NHNnY0R6Z2F6TUE2dlV4?=
 =?utf-8?B?ZnJ2MHJkaUh6OFdUMUczeVBWQW5IbnBZVDc2VlNYTXFBWC9OcGxxZGtNUnJQ?=
 =?utf-8?B?TjB0OCtHNnAwaHVYcmRQSkxWOWd1aVpZTVQzb3pjQ2hTRXh3WVlaRE9uaW9m?=
 =?utf-8?B?aGdSOCtzMHloQlVUeHlOZy9DN1lYRUZ3MDdrTXVnbzhlbjkyODd6b1ZXK0hV?=
 =?utf-8?B?cmNudW9GNWl4MlRhbDdzOXIwWW90ajNvR25QNHNqU3dMRWcyclNNem1XdU1m?=
 =?utf-8?B?ZHAxc1JwRklWUkg4cUQ5N2RYQ29mNllzUWlxeXBoN2U5TzRqOVNyY0dnbUJG?=
 =?utf-8?B?R2hId2lkTGtGWXArMHlsdlQ4V0RZRXVHc1RXYk04eUpNNGYvYVA5eVFTeHA5?=
 =?utf-8?B?czFXZGZDZEVtUGVFNE11UDRJYVdTVGx6MzRuc1ltNzJPd2tFUkpyZU1KbVlz?=
 =?utf-8?B?Nk9acmlFeUhIYmNQSnkyUXhiMnY5NytIRGxrSVVsSWdTeXIvcjNPbGtVRjRN?=
 =?utf-8?B?RllaT0hsNzNNSzVYeE5yaHErazlSaHBsaDNCR1h4Z1JSTjRWMDRHRjJZQ0Uw?=
 =?utf-8?B?MjdCZTZpSFQ1WTZWeHpmd0Njc0hHZzFmaC9JS0lLbUZkWU5WWEc1K014c2RW?=
 =?utf-8?B?azRvb2xFTk84Smh4bUdmT2ZtZkQ4VnUvM0tQRWZNL2ZDc2RHaElqa2dvY00z?=
 =?utf-8?B?U1F3WkN4M3BuUTdqeDdqZUQ4SUc1TG9QTW5aSytzOXZmSWczUDJyM1hQeGZk?=
 =?utf-8?B?dkZtQWtCTEdVUy9hY1lWRjFtbXVoUE1YdUsrbTFKRnJCb2owUEZVZ2FRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4140.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bXlMWXI1Z1g3blgvanI5MDBLNHlCWDZXSTJxd3NxbEI2OTlmYVBOdW9yMHFi?=
 =?utf-8?B?WXJnK1VHakxtSXIvSkFlVVlhL2VXMG9icnl4anJwUm5yM0ZkYjFpZWFZVmds?=
 =?utf-8?B?M3hoUk4xYVo3Z0Y2dUF1MjhJOVV1djJXUkRFaWZzd3NZSHBLMmh5UE5LNW9H?=
 =?utf-8?B?WDVXWHBhVWZjUjBiSEpNN01nVWR6bHgrREU4TzVvTUpoczk2clFYTVAwWENu?=
 =?utf-8?B?V05Oa01TNE1waUhSc21yUDRHZnJaMGJUdnJYaFgwa1NydnR2UDlCUU5CZitZ?=
 =?utf-8?B?REZTcEdJTWNpR2VSUjQzcGJ6ZExjUmFwOUUwcVRORHpYeWlJWWZkVDlOOUFT?=
 =?utf-8?B?T3VBQWkydFRoSTJXSVpiOXd4YXZaUmlrc2ZnQWhPUzhkbEFSK3N1bjlnam9P?=
 =?utf-8?B?UUVuOFdack1xK2lNM3B6blg2ZWlKTnVpUFVFYmViYXd6OFN0RG1EcThYcnIw?=
 =?utf-8?B?VHFsS2Rqblh3QVArdGlqSVpEczhiWVR1N21VVWYwTWxRZSswRGFRT21uenJI?=
 =?utf-8?B?NmxnNEpEQWw3OHBTRkMxWkRiSzZ6bFJMOVBvV3ZvRzBqVHJLZzVEb2ZvU3VO?=
 =?utf-8?B?TjRQamNXck1sNzBaY095dmx4NnJ4RnpERzU2d1BHZzFPUUYzSXAyMTdldmlv?=
 =?utf-8?B?VWdtRXlFazJUZ3I2bnV3SkMyZmo0WktKNVptVGhaMjg2bDlxdDZVNXEyelVR?=
 =?utf-8?B?NllQSUtGVS9VQmt1UFBOTzJZbGthbWNCRHZzNi9YNXR5bVYveWdtUmd1Nzkr?=
 =?utf-8?B?S3MzWG10VzdDN25nQnp1V0Nlck9xbWlsQXVsZlI4MDQvTWZYS3FEV3BkY2k0?=
 =?utf-8?B?ZHNPUVNoK0tJSXdKMUozRWk2ZXE4eWZXY2tFbGRxRzNzc1JDb0laLzF3OUZM?=
 =?utf-8?B?R21PcUVsUEs3MDBHbURiZU0yQWFMOTlUeHp2Q2U4ODdGK2prY3YxTVhpWHVj?=
 =?utf-8?B?WWdZQUNSTjJmNVpRK1VuMlFJMkloK2YwUHdTOHJCKzF1TUdpVXdyOWZHWlEx?=
 =?utf-8?B?ZWhjMUFiQzdDNThLWUtMekJCNjdldTdsclVWQUlsYjJTK01GZlR6ZFh5dGJ4?=
 =?utf-8?B?V3JjUDQrSWwvSGYrQnB6R1pKeWhMWG5oNnFlelY4eW80SkhQdVhuYk4xNy9l?=
 =?utf-8?B?eTFkM2VwVUdDM08zZEhYVmI0ZXdmRSsxT083bGttbTkxei92RVhvU2R4WXVN?=
 =?utf-8?B?RFlNRlFxTHRLc1dDQXlrT0dpdkZGaTRaZ29vVkhPRVpLbFExOEs5akhmdjRT?=
 =?utf-8?B?bVFieUVJcWVvMk8xTSsrVjVxTWJEUHI2RkZhUzh5OUx4ckRNa1RxTDZMaXNL?=
 =?utf-8?B?ZEVaYU8vcUp2ejV6bVJseU9PTzdsVzlGUW1Bc0w5ZXBPb0FobG9qRjNmVnkx?=
 =?utf-8?B?cVF3TlBHNmtsT1lHbXhlc3QvREFQZXcwenYxbEMrYnh1L25JSW8xUng5OVMr?=
 =?utf-8?B?WWpRQ1Vnd0dTQTNCbU5QSWxDZXdkOFcyM1dDOVhHZlJtaVBBdUpUekx4ak1C?=
 =?utf-8?B?aWNJb044VjhMNUhSUXkvVXVicjFwR0pSNldvTWJUUE94WFA3b2s0dk9aNFl4?=
 =?utf-8?B?aWVUNWtvRnlYRTRTamZiZkkrNzZzMzNXdnhKdGlFK0tocHN6VTVqNXZJOWxi?=
 =?utf-8?B?Ty9paldPZVdVN21aOFNjK001aVlkcTc3RmNIVkRuMWxoWUZkYVQ5UGJNVnpN?=
 =?utf-8?B?OE5xU1ZCWUJoU0FNbmFIaXF0cVhiRHNlb3FZZVZNanE0a1A1U3NHVlk0dWc3?=
 =?utf-8?B?NFpsdExwZXdxTEN6OGhaOUYzUnZONE5HQzRlRTlmQUtuMHhYUHJFYWdzVXNW?=
 =?utf-8?B?MWJjbUR2L3g2VDlRbSs0ajZYTnpORUpFaVU2VHVxRkpMa3BsaG03UFc1VzFG?=
 =?utf-8?B?aWJVSjZGNkhkRGxLZmExTGxndnZkQzN4K2NCQmtCWXRvMmp1NmNTemRSV1pC?=
 =?utf-8?B?V2ZNKzBJZDRpOEVUckVwYjMyRjVYZUVYQWhGektxU2RYUmpqbzhJV0hxLzU4?=
 =?utf-8?B?ZHdwc096dzBlTFRiQXlteGxQMGxGb3Y1M2VPYVZQeXNWR1Uwc0Myd0VOdjlt?=
 =?utf-8?B?NG54NG5lYkJDclZzWlNHSTBmVzhta3BSNFVhYUlmRERTb1VEYnRPSW9od2d4?=
 =?utf-8?B?aVlMSTllOGNqRFJsRjcySTZGMmJrSlVwWFBBYnRZc1ZxUjFzdHkrMGozZjUr?=
 =?utf-8?B?VFE9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62909de8-0adc-492e-6ad4-08dc6eb7f8c2
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4140.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2024 17:06:01.2469
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vWOdXnDTtpHyThx/8a0kZFqQD056aqpa4jo+h+F136VdbZtrG3BH8Jicsm09eiN03enPo1yLckMSxYcJL2B1XQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7712

On 5/7/24 1:36 AM, Felix Huettner wrote:
>  >
>  > As long as we are looking at this, what do you think about
>  > this:
>  >
>  > diff --git a/tools/testing/selftests/netfilter/conntrack_dump_flush.c
>  > b/tools/testing/selftests/netfilter/conntrack_dump_flush.c
>  > index e9df4ae14e16..4a73afad4de4 100644
>  > --- a/tools/testing/selftests/netfilter/conntrack_dump_flush.c
>  > +++ b/tools/testing/selftests/netfilter/conntrack_dump_flush.c
>  > @@ -317,12 +317,12 @@ FIXTURE_SETUP(conntrack_dump_flush)
>  >         self->sock = mnl_socket_open(NETLINK_NETFILTER);
>  >         if (!self->sock) {
>  >                 perror("mnl_socket_open");
>  > -               exit(EXIT_FAILURE);
>  > +               SKIP(exit(EXIT_FAILURE), "mnl_socket_open() failed");
>  >         }
>  >
>  >         if (mnl_socket_bind(self->sock, 0, MNL_SOCKET_AUTOPID) < 0) {
>  >                 perror("mnl_socket_bind");
>  > -               exit(EXIT_FAILURE);
>  > +               SKIP(exit(EXIT_FAILURE), "mnl_socket_bind() failed");
>  >         }
>  >
>  >         ret = conntracK_count_zone(self->sock, TEST_ZONE_ID);
>  >
>  > ...which changes the above output, to:
>  >
>  > $  ./conntrack_dump_flush
>  > TAP version 13
>  > 1..3
>  > # Starting 3 tests from 1 test cases.
>  > #  RUN           conntrack_dump_flush.test_dump_by_zone ...
>  > mnl_socket_open: Protocol not supported
>  > #      SKIP      mnl_socket_open() failed
>  > #            OK  conntrack_dump_flush.test_dump_by_zone
>  > ok 1 conntrack_dump_flush.test_dump_by_zone # SKIP mnl_socket_open() 
> failed
>  > #  RUN           conntrack_dump_flush.test_flush_by_zone ...
>  > mnl_socket_open: Protocol not supported
>  > #      SKIP      mnl_socket_open() failed
>  > #            OK  conntrack_dump_flush.test_flush_by_zone
>  > ok 2 conntrack_dump_flush.test_flush_by_zone # SKIP mnl_socket_open() 
> failed
>  > #  RUN           conntrack_dump_flush.test_flush_by_zone_default ...
>  > mnl_socket_open: Protocol not supported
>  > #      SKIP      mnl_socket_open() failed
>  > #            OK  conntrack_dump_flush.test_flush_by_zone_default
>  > ok 3 conntrack_dump_flush.test_flush_by_zone_default # SKIP
>  > mnl_socket_open() failed
>  > # PASSED: 3 / 3 tests passed.
>  > # Totals: pass:0 fail:0 xfail:0 xpass:0 skip:3 error:0
>  >
>  > ?
> 
> lgtm
> 

OK, I'll send that out, appreciate your looking at it.

thanks,
-- 
John Hubbard
NVIDIA


