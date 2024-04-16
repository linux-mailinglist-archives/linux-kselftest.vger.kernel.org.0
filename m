Return-Path: <linux-kselftest+bounces-8165-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 701CB8A6F35
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 17:01:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1DB81F230C6
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 15:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE42A12FF98;
	Tue, 16 Apr 2024 15:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HBH18eLj";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="vlaGjFnX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C016612FB02;
	Tue, 16 Apr 2024 15:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713279669; cv=fail; b=NKQFM51aE+nefaYny2Wayh+jBltM5Y8vHHu9YhRgwng+v7JncO6vC/wJaRV+eERvWuv6yx1NZY/eIiYSgfTV9JxvFV5vnS6MusEeiXv+sIUeZntBR3TBvvxbOTsmgBssNvmhXPqnyGEX+C+FtKT7YxdaYjZRfcA51a2JhG6/Yco=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713279669; c=relaxed/simple;
	bh=IJSP3y6zhj6lQiTSm96WnLdV9ihPf2M0DSVcQKzV44E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=SwWjjOAEJ0ixb04BJ9uUAT7N6S8RJvd/paqAbwn7ok8NjrHevP+d+x0gJW/34waAssPVhpkC7RfBKM/PoMqLdHMGAhVkg5zJO6uWXwqffx0IKgSwc1whWvORaTOjs9RcHPjaArHXzZknzW2hl3nSx9o/uYlKTn0cO2sFV1W6N/k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=HBH18eLj; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=vlaGjFnX; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43GENmmW027573;
	Tue, 16 Apr 2024 14:59:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2023-11-20;
 bh=oDOU9h4XaKP60kFCVRCKf6CF6BJMj5Rf3QtJLz24c1k=;
 b=HBH18eLjRFW5R3zBoberc3igwairGFYTVnClJrSRHNlhWKdnNESyGy2Y+T7oDsN50XxZ
 zKOF97CRAE4QSINz0OX3OoWpJFGPqu83oxVGO0isQUJMgkYR+IgzgXkD3BahE67e7rPU
 3IzMw1nOY5Utp0Ezd3wa2eEVB/FwykqwdLV4Ld7QhI6R+mAqTh4zWkwHsoiFd8pzDbPs
 WQocF9zaRGqas/cot+3YuJKK0biBflecq+iYOCYwHvgbfqrN2Sk2H2bwiQWrZ9xZSAyz
 CgeQKsT1HFDpfOGZ9wHiSWgXPq1W2c3sFXPNRcqaX0FtGBl459yi+MxzM7uk5u/SnvOx dA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xfhnudhqd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Apr 2024 14:59:43 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43GDp5DS029289;
	Tue, 16 Apr 2024 14:59:39 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xfgg7bn8v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Apr 2024 14:59:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qnj7K2+9pzoxLz2uWygANPL5dkFaJHuTYSAk5mKB2OUtbX08mtXQkOiRsLY6Gqj2VFh4DRKylxCWvbr29oM1V5DPjnyXHw22IdBkHPHxZ8w0b5iG3oe2BztmjHX0PM9lnmIevL2cqjzMcabj5VFHjvR2LL/tAczKoDFcZ6mQW4mDBWrFS7DOzo6vS7amohhZ2bZJ8EvgUQCQPueyeryhvUqlbAoPehD6vuRH5sW40arqyJ1dQ2QO+GsyVIZjUYABzq1tW6Y3gBsJ1kQkmKvJ5AMirfSDietvAZwGT3nypEu5h85GFGDZQlFbzRIYdPrw/8LwV/Me4yf6UOFevFWfng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oDOU9h4XaKP60kFCVRCKf6CF6BJMj5Rf3QtJLz24c1k=;
 b=XpBOTIJxv/z3fNb1dg345w1psDgIXGT0OTpPILmANRQW2D4hyH6hjtEmCOxTWcziIc5tt5Jck3uPZqm0JLjxX6PkxdDEyeztaNcBtP96MH6BpLrFIJoz85muZ0NewQgu8Qs5/cenPVv2O8qRrkdDyVclj5YdhlCZl0M0OqIqyFCCI/Q+cghli9pisimT1nPcBXwOMrRblT1pfPa/VMgzZaIxBcOVP72gFryRzfDqzpP/l7VnbuSjQOS7ahfqf47uhK6ZVN9bE5cjeQ8fDKG8cmSoQu1CBcpjp0hFxNt89U+nK0gjXBVLWzly9Zd42KbXQUmsYBvHMkfe9wJ7YPnHZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oDOU9h4XaKP60kFCVRCKf6CF6BJMj5Rf3QtJLz24c1k=;
 b=vlaGjFnXDJkYQnH8DHEalrPLl2yanwiP3QUcP7+yid8A39TMmZ/mwzVvuB0uOe4FV9E3AquSlAE7mqwp4lsGTDI7kuVl+pJMK3FYrlmU9s+ld1idrlbI9l6EZZnDqwdI6U12yz/LK7slQXC093pM6sCM7YaJ70v45zIj150TMLI=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by MW4PR10MB5840.namprd10.prod.outlook.com (2603:10b6:303:18b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Tue, 16 Apr
 2024 14:59:36 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::d359:1b95:6099:3550]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::d359:1b95:6099:3550%7]) with mapi id 15.20.7452.049; Tue, 16 Apr 2024
 14:59:36 +0000
Date: Tue, 16 Apr 2024 10:59:34 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: akpm@linux-foundation.org, torvalds@linux-foundation.org,
        jeffxu@chromium.org
Cc: keescook@chromium.org, jannh@google.com, sroettger@google.com,
        willy@infradead.org, gregkh@linuxfoundation.org,
        usama.anjum@collabora.com, corbet@lwn.net, surenb@google.com,
        merimus@google.com, rdunlap@infradead.org, jeffxu@google.com,
        jorgelo@chromium.org, groeck@chromium.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, pedro.falcato@gmail.com, dave.hansen@intel.com,
        linux-hardening@vger.kernel.org, deraadt@openbsd.org
Subject: Re: [PATCH v10 2/5] mseal: add mseal syscall
Message-ID: <v22gngid25vcufvdfbv3pdymq3s72c47pizr23tkrmbbyiqoe4@y5yxseh6thnf>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	akpm@linux-foundation.org, torvalds@linux-foundation.org, jeffxu@chromium.org, 
	keescook@chromium.org, jannh@google.com, sroettger@google.com, willy@infradead.org, 
	gregkh@linuxfoundation.org, usama.anjum@collabora.com, corbet@lwn.net, surenb@google.com, 
	merimus@google.com, rdunlap@infradead.org, jeffxu@google.com, jorgelo@chromium.org, 
	groeck@chromium.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, pedro.falcato@gmail.com, dave.hansen@intel.com, 
	linux-hardening@vger.kernel.org, deraadt@openbsd.org
References: <20240415163527.626541-1-jeffxu@chromium.org>
 <20240415163527.626541-3-jeffxu@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240415163527.626541-3-jeffxu@chromium.org>
User-Agent: NeoMutt/20231103
X-ClientProxiedBy: YT4PR01CA0246.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10f::10) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|MW4PR10MB5840:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ef18e3e-fa47-46b7-a870-08dc5e25d552
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	YpxcOaDHyb1Ht5YsbzSXigeEhMLklBSV9pbaSV/wB7yBN6TUb92Hory1GIlV7cxB2V4msPL1S+TUUCuTDFt5eGUIiwVN9ZQzCRawhPfMiuwUZqOioWZt6xEPbHBpPc3pH0UL1Az8vB1OiwlssQjGdrKDq0C/bhpfMhTe2KkeNB6uobMjg1cAecDhC0lY/9kGLB2iwOVhBfsLxHdTFKKKjz0L6yB4x6APm1IHKCRE4brFG0sMiOMT6IgcPcCqz1sKDufnYu5a8QfNnBz5U9DAgxLtpM6KoNgFUXhTUWLdSLeQ3tm3vQvEublAOZILI2hw/3MjOGgpmIfUOG+DIeBlJA8VazpSw47mtO5CiXyfgNmfqazM2PJFA0hd4PlnkueOcbxXstu0wfUZi0Mmv1r+bNKkUlQqp28iDu3DnRGPMZwS71FSHQRPPOuO33RZoUORqukV+D5ESrvltfRStHdl96wlG6DN5qwfjv48tuyLluijIEfQ5ZfHZJ4IImZdS+M2cbYMwfxVttEyXqr8BV4Y96dX4PnNsl7a7gfSTI/RsLibSZ+Wq0fkbTulYl5w3iwSIxt6U/8UpKDsCWp1o6SuqjN+HHpwAeq+LH2n5KvP0UEY2hT1kURjZ7uXf2Sc9dvdWGau+QvsXZvVR74pIm8UMdv08Ddf8ZnJRwoZKR6jlhc=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?eG55VXNDZjM5ZlhMSU9BQkZzZVVwcTYzbFdVVW83dFVWWXorU0lCTTJFQXM4?=
 =?utf-8?B?NjJSLzNVSHo1RFh1M3llSG9KNkY3OEpEOGJuR2hSUGtwQnAyTisxYjhPY3Nq?=
 =?utf-8?B?YStLdTdzYmdORUJVVHluTjVDT2o1bkJubDJxWVZyVTR3L1hYdU10QVRZcGI5?=
 =?utf-8?B?Nzd0ZVNUMURnbmREcjFRN3k4M0toZUJ5SnJxSHZ3ckdIaVRDSzVzMkdSZmJO?=
 =?utf-8?B?NGRRdnQrS1Y5TzdtSmx4OFFJQVE5TGtldjJlbWZpZklMWFR2Q1VBcWJUUGZy?=
 =?utf-8?B?YUd5b0dKR21qVjAyU2pHNjZ5STBEbGowNVdSNTg5TE40QVZtOTJ6ZXJaRjhn?=
 =?utf-8?B?ZnJkNnl3N0o0Z0FnamVTZ1plYUZCMlhKTEtxTlYxYkgvdC9qbmdNMEdKaTh5?=
 =?utf-8?B?V0xiQXZyWklqbzRyMURRMVJwVTB2bGlLM05vZXFVVE9ZR3VsdDh4Q2JUSyti?=
 =?utf-8?B?RkhCaFc5clNzYW5ncWh6bXN0WUJrV2NmTnFHZHhFUWNGRkpTWkdrSlRibWtz?=
 =?utf-8?B?NkFXeEw1bnhSOTYyN21lcnNsaDVRd2ovYlV1ZHVoOHJrOW43aUFoWTkxNVNx?=
 =?utf-8?B?cEJQYWVKTHZwejREaUdEOVZsenZzSmNNVTAyU1J0YitZM29lTllWWVZtdXU4?=
 =?utf-8?B?MGRSczZpM0tteW1PYkJCcm02N2t4V3FmcWtrM0N0Q3dTZTc3RVkwVFZ6M0lr?=
 =?utf-8?B?eXAvRUFvMVBRendyT045V2FCUlczS1J2L0dsL0dsWXdBb0lpVncyZmhmUFNt?=
 =?utf-8?B?bmFNYitudTZEZWtoNU9sMXdpVmRhaVNqTko5TDkwOGp5dnQ3UE5JVS9ja1N6?=
 =?utf-8?B?cmJBd1A1SGQrNXRSVklxSDk4VkJuOVhqTlcwekh1K1dacUJUY1ZLMGlWZFhX?=
 =?utf-8?B?dUdGeXRLWVdpWG1qcy9zUlZvUDhTRHVuTXMvZEM5VDRPenBwUWV4a3Vzckxy?=
 =?utf-8?B?eWFKYmFaTXhXRjIvSGp2RkRUT2U4NlVuNFljQmFaL3NERkF4Wm5CTERZSmd5?=
 =?utf-8?B?ZkVIYm9kY2NYZ255Y0lGRk1ocDkrUS9oUzIzajZIR1ZsZVpVcjNYMmpMQ3Ns?=
 =?utf-8?B?d2J4K3JmMUtSN0txeXA4Y0d5c0p4Y2Q5MTlnNzFxQjF0SkRmbUp4QUk0Y3I4?=
 =?utf-8?B?TEt3ZUlYaEJHVk1sWUNkb0pGMnpsdFJ1QVl4WmoyTVdkMUtFSzFBZ2gyT0gv?=
 =?utf-8?B?R3NoaFBOd21CUEpzYVJBZkhmclVmUHR6RlB4M2ZxYW85SUNJTGsxakRZemYv?=
 =?utf-8?B?S2tqY0FRK3l5aEk0YjVnazE3UnNUZ1Z1aWF5dWh5QU9HNUtWcENuTkFqRHlh?=
 =?utf-8?B?L2gvQUtFQXQ5SFNkSXA3SGUzQ3NFZkorWW52a1MybGxyN01wR01wek52WWli?=
 =?utf-8?B?dXA0QTl0ZUUrcnoxUVhHTEVqd3d1cjJzMWMzUEpDc3l2UGR3cXY4UHIyWm9Q?=
 =?utf-8?B?dkNZbitzcS8veEdQYmRwOTFaa1h4d296M2JXUVRlMW5uaVBvQ0ljdnp0OTZ6?=
 =?utf-8?B?VTNhaG1iWXhoOW80bVFRSDlDVGhRckhGS0JLbHRDQW5YZ1VDeEJ2TzBGTVNr?=
 =?utf-8?B?cjVCTDF1cVl3ZmRJZkJzMWxNcXd4L0FCQnZXTC95aG1JMnpieFFPN2ZTcGkz?=
 =?utf-8?B?QUtjc3RPL2N1d3ViZHZsY0F1dmphKzBUNnZuemNqa3J5ZmxJbDFBYTNkS2Ny?=
 =?utf-8?B?Zk1RaUxpYzU3cTZDRGhQemJQVWI4YjNBZy9JbE9zcWhxWGE5dUsvTDVTQ3Iv?=
 =?utf-8?B?SE01OC9jTFR2R01uNTFjYVdsQlY5YUdJeUZ6d283V2ZwREFjaUVtWG51YUd6?=
 =?utf-8?B?T3JGZzQ0Z2k1RDJOUXlsNWxXTDRuS0xqRkpmYzd4V2t2M01iRk5ieVliZVpZ?=
 =?utf-8?B?ZDk4NEpiQnhocktONTNhSncrOEhaOGV2TGxLeEdRR3N5cHVFTm1MMENlTi81?=
 =?utf-8?B?KzA4MmJ0bmFVU09uYUZ1OHZUQ0FtWVR2NEtPY0g3UGdvK2ZRenB5NWxCUVJK?=
 =?utf-8?B?cm5KMmUvMUYvOCtSMjNJaEF0ZWduNHNLY253a1JGMm8vQ05yaTlCaHMrVmIx?=
 =?utf-8?B?SkNjSU9WMXZXWG53MXM0SGpKTmc5U1Z3MGFjNUl1T3hyaFQweWU0bkpJK0JU?=
 =?utf-8?Q?n3rTGhMz6YCjtSQddOyL4+bHD?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	uucinMqiX0ac7yPI5jzbE6BVcZuY788/BlRZRe8kOjgI+eDiLQxz1b40Wh4yqe3QVxSpPb47Z3nBa5RL3fa0OpIug6cCs6gntPWK90gEJzx9NsUXxr60VsmH7/8trkK42+CSHtp1goDHpURrR5Z9HaC/TTo45I8JJbpOsauvuGDGuprVujwQ5/g9rhNe6bbHnziYL9pBy6yb3KUq01/tb/VZaY0NR+IG6z0NWzQLPpAVkymKcEPYdiUwMnyXRU7OexFnmcRId0K/ne740fnK6NaJO6nPemJgHg0lRL9gmYK8oW+vBnUJ0sd3+P+5a9TlfaAbAUep0tO2/iN3KNJPr4DVNW3EchI6sdX1GFqJ60eGQoYFZdwOpIDD8tucC7u3XxzvSH2ZywTumGcq/GfkcGc/dl4XViZE8iQsuQQFO71ge+m2uCkR/q0ulhnS/ZloQY7BuJ/5yI0XN2E0AJSgNaL5MUpw11rvzpjVPHcm43fU3kHIwUmcCtHx7GaGqmNXInUV82Wxb6CoLAvquZFlQX4GCGuU7hef7FddfrrgUkpwjY8JNhKHHlFr6tv2AbzM3ueUe5R3KPxn/Vrx/tjIlME0lPu2CD4IMlNANDqNfoc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ef18e3e-fa47-46b7-a870-08dc5e25d552
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2024 14:59:36.6654
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1qHwKfEhzgyrvxJRp+0m9K3cstVAolMf+nhQO4/ls8wFu5vChl5T8retFuMRm4zTwFO2rKRsf5zZbtL4Xjm8+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5840
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-16_10,2024-04-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 mlxlogscore=999 phishscore=0 mlxscore=0 malwarescore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404160091
X-Proofpoint-GUID: cUkXwLeBDjMenbDEc6VwPNu7DD-h-k0g
X-Proofpoint-ORIG-GUID: cUkXwLeBDjMenbDEc6VwPNu7DD-h-k0g

* jeffxu@chromium.org <jeffxu@chromium.org> [240415 12:35]:
> From: Jeff Xu <jeffxu@chromium.org>
>=20
> The new mseal() is an syscall on 64 bit CPU, and with
> following signature:
>=20
> int mseal(void addr, size_t len, unsigned long flags)
> addr/len: memory range.
> flags: reserved.
>=20
> mseal() blocks following operations for the given memory range.
>=20
> 1> Unmapping, moving to another location, and shrinking the size,
>    via munmap() and mremap(), can leave an empty space, therefore can
>    be replaced with a VMA with a new set of attributes.
>=20
> 2> Moving or expanding a different VMA into the current location,
>    via mremap().
>=20
> 3> Modifying a VMA via mmap(MAP_FIXED).
>=20
> 4> Size expansion, via mremap(), does not appear to pose any specific
>    risks to sealed VMAs. It is included anyway because the use case is
>    unclear. In any case, users can rely on merging to expand a sealed VMA=
.
>=20
> 5> mprotect() and pkey_mprotect().
>=20
> 6> Some destructive madvice() behaviors (e.g. MADV_DONTNEED) for anonymou=
s
>    memory, when users don't have write permission to the memory. Those
>    behaviors can alter region contents by discarding pages, effectively a
>    memset(0) for anonymous memory.
>=20
> Following input during RFC are incooperated into this patch:
>=20
> Jann Horn: raising awareness and providing valuable insights on the
> destructive madvise operations.
> Linus Torvalds: assisting in defining system call signature and scope.
> Liam R. Howlett: perf optimization.
> Theo de Raadt: sharing the experiences and insight gained from
>   implementing mimmutable() in OpenBSD.
>=20
> Finally, the idea that inspired this patch comes from Stephen R=C3=B6ttge=
r=E2=80=99s
> work in Chrome V8 CFI.

No per-vma change is checked prior to entering a per-vma modification
loop today. This means that mseal() differs in behaviour in "up-front
failure" vs "partial change failure" that exists in every other
function.

I'm not saying it's wrong or that it's right - I'm just wondering what
the direction is here.  Either we should do as much up-front as
possible or keep with tradition and have (partial) success where
possible.

If you look at do_mprotect_pkey(), you can even see
map_deny_write_exec() being checked in a loop during modifications.

I think we can all agree that having some up-front and some later
without any reason will lead to a higher probability of things getting
missed.

Thanks,
Liam

