Return-Path: <linux-kselftest+bounces-20177-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 018379A4882
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Oct 2024 22:51:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BF8D1C21DDB
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Oct 2024 20:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4ADD18D645;
	Fri, 18 Oct 2024 20:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="If8vo7Yi";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="IZkoReeb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B8BE2CA5;
	Fri, 18 Oct 2024 20:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729284700; cv=fail; b=t/IGl5Mu4sNspbDC2TEjG7NAHiUmsT9kqjFr3hxQdRc0F/FAdrrfJ1uokuOQzF6W4CfCIXVyHjRtX67eFpf5LVL5QLGL07ZnnW2w0OYKFgfRoBNWYCO3KR2CzIso4TrSgvDm58MfxHDc9wIFA566KsCWe64J+mc/a9hv5pq4WD4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729284700; c=relaxed/simple;
	bh=EBbbOp4yu0eH+p8Vi3cxNADCtD5Votn5fdQndiv7DYc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LX6xPjGjgSYoY0XkgEKTH8pfxQ8FLfoxbu9oxFKrxNhcQ4lQMhsQMy0lEnMsJqBbGmqFOglkSlYlaxILf1HRul9WLnXAaLsDr7hjGWLxJ0S8VFxm2Y8ELyYtzUxPyugoTq0NwuVoi4GjseTxElR9xg5NL3wsXEU+FG6xgXGkFuY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=If8vo7Yi; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=IZkoReeb; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49IKBeXD027875;
	Fri, 18 Oct 2024 20:51:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=rsuXPz6LI1FuioHGTB93xU52+Xzm7EsJnwSKrBsQiiM=; b=
	If8vo7Yi7N2eq2wXG1ywY1JlCOu8O4TGochKLkYzDBi1vLR04iXlHWGiEF7xqxU+
	6yCcT50aWuA16vFZO/HnBpGOVuihMMuStn47NgbM8cxREGxCofQwZf6mUQfYnGLq
	G2IYu+KLSmvZNF2zI+HngsgtTDQuyHIIlAFKW6bcsoE5zK0EnMLrxM9f4KSZeSve
	VYTMHPPs9UiAM2nO9aJG69HjJvtzEqLF4ORkO2xBflOv9H64NHLb+MnW9xzQFfpn
	ucc3E7wUVVNY+2usY4NVTmP16aodfrdEmws/ptSlMwgMUY/dySKZfS6V0HQzAoD/
	5A5Rh0jwh6pxCjalECG5ng==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427hnthqff-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Oct 2024 20:51:19 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49IJviN7027209;
	Fri, 18 Oct 2024 20:51:18 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2045.outbound.protection.outlook.com [104.47.55.45])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 427fjjpcas-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Oct 2024 20:51:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dpW4dNb10U+THotS9vc5s0oby+LA0BTLslgM2QYAbaUR7C3u0shpo4Kcwafy5VRASQteU7Jk2vc9EEdDhLMeo44SmVY1qHUyHCZDZgNH+ibvDpizQUzn5y9EecmUOtJwvDCCZvNisuiPSfRYJZqVQTvJASUoVIhLJqhbA36pPqQBfmaj95AtlLP3MjcgOHX+ZbkOS61ebqLgyYetfJQGwtuvsE1cGcD8Go5P8Pjwcp8ovw2GNGjZkzIDBGy+44ZSJUfwQrpdCot3aw/Vfuj70UTvT+F1KH5f8MPwdBHJvbdyB0ac1Ny6TwMjNly3C0CbhQNUH1SSVemeS07KQcQDrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rsuXPz6LI1FuioHGTB93xU52+Xzm7EsJnwSKrBsQiiM=;
 b=hj3/naQMgZGVGif5QrVmYEicOAHXsRTqQP+ON1UJgeS3zK1qY25/M5jFz5VeuLitMLDu+O6sdLyK7JidEZ/Y26VTPKOqsy5zb+z07jb+LB2O89NV4920sy3csUSawe2C7p7uRykVDgONhYXF4X8pVBD2gwscZt9jo2DiTizbivXrx4NwpQACZZ4O3pmMTI4LNlVYaVrv39GhLyILpa7rUiFfaamSJ1EHTI76KdpOpcAuDQxY/+bRHOeh5ImwFg7MrU3I80pnWFRnMgFNX8KCHfQY/IIqaaMs6YyKT1csp0bJIpUFD1fakcQr7WAecdiMhDQT6nkXEiHhzOYdavtgsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rsuXPz6LI1FuioHGTB93xU52+Xzm7EsJnwSKrBsQiiM=;
 b=IZkoReebIDXaiZ/9hXrR0kCNV1VQMl3s/8ns4OdTQo8tchlt9hE/dHRKAoOS9R9rjnP/mbBjbTBHUCGG0UiIajMkNp/uderroMZHzLRMCvkMZRXwfmdeW9JoJ6T+tyy4gMrGhoet/66qAKFS5G94s4LTMN4guxIiD2YWNHdTkKE=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by PH7PR10MB5814.namprd10.prod.outlook.com (2603:10b6:510:125::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Fri, 18 Oct
 2024 20:51:13 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.8069.016; Fri, 18 Oct 2024
 20:51:13 +0000
Date: Fri, 18 Oct 2024 21:51:10 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Jeff Xu <jeffxu@chromium.org>
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
        akpm@linux-foundation.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, linux-hardening@vger.kernel.org,
        linux-kernel@vger.kernel.org, pedro.falcato@gmail.com,
        willy@infradead.org, broonie@kernel.org, vbabka@suse.cz,
        Liam.Howlett@oracle.com, rientjes@google.com, keescook@chromium.org
Subject: Re: [PATCH v3 4/5] selftests/mseal: add more tests for mmap
Message-ID: <22024c01-9b73-4345-9b76-8414a6bcb124@lucifer.local>
References: <CABi2SkUpCf+aOa2sPED8CosG5ccqjFd7ouot8gXi9ECqsHiZhw@mail.gmail.com>
 <4944ce41-9fe1-4e22-8967-f6bd7eafae3f@lucifer.local>
 <CABi2SkUgDZtJtRJe+J9UNdtZn=EQzZcbMB685P=1rR7DUhg=6Q@mail.gmail.com>
 <CABi2SkVEMRHV3swrbb6M5RA6GQpFVVx855CGwdQ1xiz3tygiqA@mail.gmail.com>
 <f9b9422c-216d-422e-94b4-d8814b0b277e@lucifer.local>
 <CABi2SkWAv4LXvR1Wb1e31eyZ35JfyieXhDOq1bp_ZvHPLLg-qA@mail.gmail.com>
 <e0f440b0-5a45-4218-8c51-27f848c0617b@lucifer.local>
 <CABi2SkWNRTCC0LzDSuzgjC1tO=KF==5FXUnPHOrPzEG5abAeDg@mail.gmail.com>
 <c56aac50-83b5-45f2-8ddb-6980c22c059b@lucifer.local>
 <CABi2SkUiazcOnGZxVyb21jCa1gzOaQ1NPzjGJVX5a3kw1BBE0Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABi2SkUiazcOnGZxVyb21jCa1gzOaQ1NPzjGJVX5a3kw1BBE0Q@mail.gmail.com>
X-ClientProxiedBy: LO4P265CA0046.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ac::20) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|PH7PR10MB5814:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f8d5ffc-dbbb-4c90-879c-08dcefb69a96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|10070799003|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S0RSSDY5TXRhcUYrbjF1UklEMzFmcjhuWCtaTnhiTEVMWTlmR1NUR2ZNYlVT?=
 =?utf-8?B?WUJ1S0RjWXRzMzRWL0QzMEtPcmdKMDZ6b0c2c1grUWx5cStGNzFHRkNXWXlm?=
 =?utf-8?B?aUc4dHFDZStlWSs0bDc1TE5KdDVJOWltTmpqZWc0OGMyN0sxZ1pUdk41cWxx?=
 =?utf-8?B?d3h4T2QvRDNBbXI2ZU9xK2pJL0pGbURrakJVMEpXMXNnYnMyTDd6R2FkSWVz?=
 =?utf-8?B?QVEvdEJhdEpTdVFJaUlTckNLV0lPcnpNVHl5TXU1YXpJMlZBTndacG8yWXhn?=
 =?utf-8?B?eEJURWwycUxuVWROSnR2b3pWVDgxcHN2YVByeW44R3dWdGZxWHE4eXFieVVY?=
 =?utf-8?B?NUtEeTJKM004MzhPWitwZzFWdjJXSWg1V0IrNkltU3IxdE5hdG41NjFqZVoy?=
 =?utf-8?B?OXpzWUF3Tzh4MjV2WkdYRWphWjB6TGFmN3ZDc1BZWjNsVHBsNlhPY2RhOWZI?=
 =?utf-8?B?SVRIK0VORk05TjQvNzh0WUVTMjFQQnN2QzFQZEcyK3QzbXFoTldGTFMycm9s?=
 =?utf-8?B?UFN5Zk1xd3p0bEpUWmdwbUU1cFpyL1NxNDhhTkg5NUpaNFVSOGgvZy9sK2Mx?=
 =?utf-8?B?ZmczckdIclpubDhaUHBkdjJZZjBDVEI2enVtanZUR2xXZVp2Ylg4YmkvYm5J?=
 =?utf-8?B?a25sYWVmZmtqUTNUbFVURjI0V0d5amdHRzNZRDJabzZyR0pzOHg1dVRMZG1k?=
 =?utf-8?B?cEVIK2cweHZLN3lub1A3SWVoaGVKTlJ5M1lDRHZVQVE5azQ1d3BPY0pPeE5t?=
 =?utf-8?B?VDZ6cENUNStGUldUSlk3QTgxYmVxQmJZVFk3NlVBbkxTc2NRblN6R056ZTl6?=
 =?utf-8?B?emxuUGkxWDJmTU9zR2F5SkRjN0c1MG1wRXJ2ZzR1aWx4V1YzNGV5U2trNVNt?=
 =?utf-8?B?NjJCSVlLWlBwcEpyTFEwTmJRV2NrWEphWnQrTVEySlJKb2FHYlQ3MWR3Tkg3?=
 =?utf-8?B?THZiTU91UHlzTDRIWmJ0bXpVc0x6ZlptWjhjV2xxUktWQzU5UjM4NVNrZXly?=
 =?utf-8?B?Slo1Q1FGbkVZTEExblNBR3VxR0tkRkNYd0RyYkNhWWVtcTZUNWFFSU52RkJ1?=
 =?utf-8?B?TExncCtDQ0MwZUZuVndEWGFEQURCZUkrWS9OTnVRY25LYmdJMVprTUdVQVJy?=
 =?utf-8?B?eURtaG9Eb0d6QzBNcXZ2UlRjNEVkUEIxYis3cXBhR1RLbjZxcjJ6N0tWbGtz?=
 =?utf-8?B?dlo3dXpjemhNaWMxeDVEeitsQ2Z2SlB0bHJXTUlFbFp1b0V4RFY4VzNmYTl5?=
 =?utf-8?B?bXoreVE2NUxHMFJpWFRPdzFGejBjSURuUk4rRkdobmFhcGN1UjdyME55cVVI?=
 =?utf-8?B?akVLV20wYnlNT1dnVXFSeld4TldEdkMzakcyT3hScGZXOW1ZU0d6ZDdEdEdW?=
 =?utf-8?B?YXNDbG1xNlI3YVlzNC9pdDN4R3BoV2FOWFVuUEpZNFJKcXViU2k2QjQvaGtK?=
 =?utf-8?B?dVlYNndLQk80YVFGR2ZFNDdGOFlkeWhRQWt5ZWhKMWJaM2lycnE1elNITzRz?=
 =?utf-8?B?TkJvSVVyVjFnQzJtUzQ0Vk13S2k3SU1GTTJYc3crWi94eE4yc3lsdWtiYmJG?=
 =?utf-8?B?ZFJQQ05SY1dMZzBJSE11MUhaUE9JU09ha25ITW9XZnRHYTMwWk5vMld3SzFK?=
 =?utf-8?B?Nk1iZm8ydGc0a3V5NUdtcVAraER0UEpEczlxRWs4MGlCajFPT29MZWZKd2Q4?=
 =?utf-8?Q?t6Hf5f3dSpl/KRc6doCO?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(10070799003)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Zm5kS2d6U25yYjQzK0twMFV2QkF2ZUg0a1V1ZUNQWTIxbWt6YXBQb2k2UnVH?=
 =?utf-8?B?U0V3S3RYUEVtaGExNGNYYno3aGhDVFNFVzBtMDNCbW5CQW5Id3lqRGZ3aFRH?=
 =?utf-8?B?UERPN3RSc2RiTzBEUURHWEs3YUozSnNqWE1IOHhvMVM5dEJPYVg1d2lYMUxi?=
 =?utf-8?B?c0FaN0pxQ2lhSjlWWmdySnh4V09zT0daVXlMMXpTeUF4YmxOVmtSQ1pWTi9I?=
 =?utf-8?B?TFdyRXljSmtnTnBnVkFtTGVHalZsK0liSi9mT09YTk1DZ1duQWh5QkZOaDVs?=
 =?utf-8?B?R2pCTkhUZ0RRN1FVV000TlQvTDhBQmxwWFBKd1RySUttWG02ck1ZNlpwMnRL?=
 =?utf-8?B?QjNacmhYZHU0NTU5L0YwMkU4ajZldXZ6QUxmKzZJakZydFZmN0NNbEZnYmhp?=
 =?utf-8?B?MkozMnMrVWpadHlzeDZlZzNVTzhSWFY3RFo1R0Z1OFMxZDlSVU8zem1ackFF?=
 =?utf-8?B?UG5xTE1VaHNyRnI3aXU0c3lWMFczQ2lUMU5DemZGWDdxV08rTnlrV3V0bFc3?=
 =?utf-8?B?Sk55b2JqSGNqZis2V1hqU2QvOU1FSm9jdGZQbnZvdmdoTHpSdFR4dEZJTmlF?=
 =?utf-8?B?cWFETnltaGFkSnNJWnBPZDNZU2dCTmRyYUdwS3pyNVZobERod1Y2ZGNWK3pF?=
 =?utf-8?B?alFlUzZFZk56L05VQzdWQlUxWUVobzUvZW51NGR1NEV3WmtPQnFLZFhicWxj?=
 =?utf-8?B?Nlk0TDRjQ0dpdVFyVTRZWUQ5NXFuQlROTXB2T2xLZU1rdFltUlF0V0NpNTVz?=
 =?utf-8?B?bkhSU28reU9kZU9BWDYvZHNGSkJGTE9RR2ZTQXVqbkNpU01MV2o3TFQ5MGMy?=
 =?utf-8?B?a1ozQlJuQnFmcXNmTnk5QlJZbFpETllSb0pvSWowbVBONEJKcFhLVHlRY1hF?=
 =?utf-8?B?Y1lUNjFZR292dXJHZnhxTGtrSGsrSS9TZVRNdGtVNnJobzdOdjNuZ25qQ3lt?=
 =?utf-8?B?dWxPN0NNNFBGZHJHRnU1eHVMQ0lLSUM3Q25EaEtaL3lCQlVkYTBsQWZsMzcw?=
 =?utf-8?B?dWxHWmJRQWhvUW5qeGgrclFUeVVTdTQ3ZWpidzZLeU9CY0EyRFRBZXl3b2FK?=
 =?utf-8?B?dDhSNndHVTlvL1d1THZKUk9UMlZoa2dFQzhrQjMvYnpYdG1mck1FMTZJR3c3?=
 =?utf-8?B?Sk11dWFiQVJUS2lIb292WFkrckV1c3MzMUZ6M2c0Y0trRzZMdFNndTg5bUtT?=
 =?utf-8?B?Um8zQzRyYWM2RjZDVUhTZzhNTzlwaTU0eXhhZUUxNFluTVpaV1BnZThZWk8y?=
 =?utf-8?B?TlorRit4cXpHTk01WncrTmZnVGdCbUpTVWFHM1VDb1RWbnhaeU5XSU1EN0Zh?=
 =?utf-8?B?Q2d5a1dRSktpdzZJN3RPbldzSW5EWmFGdjF6cFA0QWE1b2k5T1pZTWVuazgy?=
 =?utf-8?B?M1hmbTdZZWltU1R2TkQrZmlzRGg3Nzd1akQ1WUZtenVadDVjUDVHUmhoaUNO?=
 =?utf-8?B?R25tcW1Zby92d1lmTjFCcldQbjhGekEyVTdtWDlmMWxPRExjZkQ0ZGZvMlRV?=
 =?utf-8?B?RURERkhwS1BUZU1ZTy9Qc3VDWGFBNEtLWXdoOEh4LytCU05NZlhJV2pwUmhk?=
 =?utf-8?B?eGIrYTltM3ZQUDRET3NKemJGMjZuTlUyUHZGdzlhVWtURGpYQ2k4d3UyZUdF?=
 =?utf-8?B?SUdqRFBIaHlGbVBEZ3VNczRCTm11NFcwZGlRTkpPM1I3MG1xT3M2cHBDcXlG?=
 =?utf-8?B?LzJEeFZtSkhXY2xBcldMV0FtcmhpVkx4Zko0TExra2lCeWwvT2dVNVh1b09u?=
 =?utf-8?B?dHlPMExnWldWM2d6U3Q5T0FRdnJIcStnU2xQQ1o4T0tFakdpL1MzaEtGWGhD?=
 =?utf-8?B?STBjNnN5OCtaVi9Wb1VBeE9rNzRNNFVEci8vcW1pendEQVJMa2lyVFd3VUpX?=
 =?utf-8?B?eGNxaUF5OUMrQnBQc0N1cEFHZU9pQmh5RVZoVjFwNUc0Q0dzYm9FUFpILzBH?=
 =?utf-8?B?RjQ0Y3NuK2MvT043MUpPQzNJOENUWnRhMmtHdkFEaFYreHU2YXZHUGw5VWR0?=
 =?utf-8?B?eEhhMmNoVE1SeERNMnpZVDYyMnpXUDNiSWdqQ0QyNElQUHZOTDZnMWVoTjhi?=
 =?utf-8?B?aG0rZ3o0T0FhejN4bno1dGFpbUNJdVR2N1NEdm5KalhSOTgwSGdzMzdtRmdL?=
 =?utf-8?B?cVhBQllFb25raHJaSTlxbXUwOGM1dVdZTnJSQXZybHRkdmMzcmdNbER3cTFQ?=
 =?utf-8?B?TE9WaG1NZy9ZTTJseUVXUFdROHJ2bk1UOGtuTHJ5dGVMS2c1UkRBVHlCaWsx?=
 =?utf-8?B?YmhvbVlaNlZvVi9UTTkvSXRFTXdnPT0=?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	XkDhEk25Id7rxTmEKvFQ/jDtAh8wJtGR0JB0HGUhDSzbeLkNXOCGqtwQ0ZqHVDwCo/ZfxSkS+H9+n5WC92bcwWSfDMsYFA/yb/xbd/+dvFAAr/IX875GMG5BIfE+L3y0SlFc2onfxM6tGKf8/NdgemV2X6n1/U41dz6sOzmWU/ikv29c8cvU4K+uBLDmYwbIjgTfZE6pAPidlVEAtwlhFtWVrbeelB4Sycd6PIz0D4DPxaPsAkJb6QdhSY8rjjzkEyrcidiwHbLqwlVDdSx8Z9WgfOMl/LML7zBF9uAyDadLW4BIoR9Bw7Fl1vf3bvJFXtHznhWJBbuTFHaTpzvTNI3rGu6wOiIwfytRBPjzupIGeXrkCZvZCoM5DFyDOSTHD6Iy+/57HM/6JC0qIUUMuYc4NPvu/yI3h9Eh9MchI3b4bLAuKRWGH7SnhXGRo7aOUSye3ewXV2vyK5rDtsJl9hKQ15lbS3Q/Lx9IeH6p1LtzaU7WfquMad1/d9dkdQ4LPfy1Beplkr/GpWSX15fE9ifcMqtGbKY1v/faEOIR7urm+7mQOQOJzWswoi9oRt/Mc0dyFXuNIUb4h0BgVQf2WOJCg1pe3+F7JpUqFmv4QR8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f8d5ffc-dbbb-4c90-879c-08dcefb69a96
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2024 20:51:13.7905
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gOLzS2O6Ey+qGjC6HigbE/8lp4QM+mjesXpYkesSo/LtyHR+jsRP1A/i7u924vGHPYBwLqLqj+WPcJE1nQvyzoC0e+d9kVJQ2CsdQlT+NXo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5814
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-18_16,2024-10-17_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 spamscore=0 malwarescore=0 bulkscore=0 suspectscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410180133
X-Proofpoint-ORIG-GUID: dM_F-ZWALM3UtEs6nBRN1kwqHyuxW1TZ
X-Proofpoint-GUID: dM_F-ZWALM3UtEs6nBRN1kwqHyuxW1TZ

On Fri, Oct 18, 2024 at 11:01:40AM -0700, Jeff Xu wrote:
> >
> > Jeff, you're falling into your usual pattern of being unreasonably
> > argumentative for apparently no reason and I really don't have time to
> > constantly respond inline when you're just ignoring what I tell you.
> >
> > You do this on nearly all code review and this just isn't working. If you
> > want to effectively be involved in mseal you need to LISTEN.
> >
> > The more you do this the less patient everybody gets with you and the less
> > likely your series will ever get merged. This is not good for mseal or
> > anybody involved.
> >
> > On this issue - either use sensible macros that YOU ARE DEFINING, not
> > assert.h, but YOU, that allow you to evaluate whether a condition is true
> > or false - or I will not accept your unreadable test code.
> >
> > It's that simple and I'm done discussing this.
>
> Thanks for your time on discussing this.
>
> Please, if I may say, when presenting your argument, keep it technical
> and avoid personal attack. Using personal attacks rather than using
> logic to refute your argument is “Ad Hominem Fallacy” [1]  and will
> make it harder to get your point across.

This is not how ad hominem works, Jeff, it's a common misunderstanding of
what that means.

It'd be the case if in replying to a specific technical point I was to
respond with something personal. That is not what is happening here.

In fact it is not personal at all - code review consists of 1. technical
points and 2. how well the conversation goes on review. If 2 is absolutely
failing, it is absolutely fair and pertinent to bring that up.

What is happening here is that we have spent several months trying to
explain to you very very simple points:

1. Have macros that assert both truth and falsity so you don't have some
   inverted and unreadable assert.

2. Do not use arbitrary 'magic numbers'.

Instead of listening, you have been needlessly difficult in a way others
are not. I can't spend chunks of my working day going point-by-point
knowing you will ultimately say something like 'well I just don't want to'
or simply ignore points.

It is a waste of both of our time, but it is what you do.

>
> [1] https://www.txst.edu/philosophy/resources/fallacy-definitions/ad-hominem.html#:~:text=(Attacking%20the%20person)%3A%20This,who%20is%20making%20the%20argument.
>
> Additionally, The mseal_test was reviewed-by Muhammad Usama Anjum
> during original RFC discussion. IIUC, Muhammad Usama Anjum has domain
> knowledge for selftest infra, and I have relied on Muhammad’s comments
> and implemented all those comments.

If I can't read the tests, I'm going to NACK the series, sorry.

>
> I'm not saying there is no room for improvement, but it should happen
> in more respectful and constructive ways. In any case, I hope we have
> common interest  and passion to  get more test coverage to avoid
> future regression.  Given that we had 2 regressions in the past during
> code reviews and a pending regression to fix at this moment in memory
> sealing area,  the benefit of additional test coverage is obvious.

You are repeatedly ignoring what you are being told by me and others. You
have done this consistently to the point that you are taking up quite a bit
of our time.

You do this on pretty much all code reviews. There is not just 'room for
improvement', you are bordering on being impossible to deal with.

The benefits of additional test coverage is indeed obvious, but not if the
tests are largely redundant, misleading or confused, which yours in fact
are.

This is why I proposed that we sit down and figure out exactly what it is
you want to test ahead of time, and NACKed the series (I'm not even quite
sure why we are discussing this here still).

The fact you're debating about using ASSERT(), EXPECT() on the same series
months later is not encouraging.

>
> Specific on FAIL_TEST_IF_FALS macro, during the course of this
> discussion, your comments have started with, and I quote:
>
> “ Why do we not have a FAIL_TEST_IF_TRUE()? This is crazy.
>   Would be nice to have something human-readable like ASSERT_EQ() or
> ASSERT_TRUE() or ASSERT_FALSE().”
>
> “This is beyond horrible. You really have to add more asserts.”
>
> TO my response:
>
> “ASSERT_EQ and ASSERT_TURE are not recommended by the self-test. The
> FAIL_TEST_IF_FAIL wrap will take care of some of the admin tasks
> related to self-test infra, such as counting how many tests are
> failing.”
>
> And your question:
> “why we have to assert negations only, and other self tests do not do this.”
>
> And my response:
> "My most test-infra related comments comes from Muhammad Usama Anjum"
> (added into this email), e.g. assert is not recommended.[1] ,
> [1] https://lore.kernel.org/all/148fc789-3c03-4490-a653-6a4e58f336b6@collabora.com/"

This is a PERFECT example of the problem.

You are excluding my response to this - that he said NO SUCH THING - but
rather he was talking about having an EXPECT()-like pattern!

You repeatedly do this - you ignore responses that contradict you. This is
not a functional way to do code review.

>
> And my additional  try to clarify about your question about negations:
> “So it is not a problem with the MACRO, but where is it used ?
>         ret = sys_mseal(ptr, size);
>         FAIL_TEST_IF_FALSE(!ret);
> Take this example, it would be
> assert(!ret)
> The syscall return usually returns 0 to indicate success, where a
> negative comes from, but dev should be so used to (!ret), it is a
> common pattern to check syscall return code. e.g assert(!ret)"
>
> And I offer an alternative approach for macro naming:
> "ret = sys_mseal(ptr, size);
> TEST_EXPECT_TRUE(!ret);"
>
> Which you didn’t respond to directly.

Because we are going round in circles on 2 very very simple points and I
don't have infinite time.

Simply introduce ASSERT_TRUE(), ASSERT_FALSE(), EXPECT_TRUE(),
EXPECT_FALSE() perhaps with different spellings (no idea why you would want
to do that) or use the test harness.

Instead you try to debate 'oh this is kind of like assert' or implying
somebody said something or etc. etc. over dozens of emails.

>
> Given the situation, I think it might be best to let domain experts
> from the testinfra team, such as Muhammad to suggestion a better
> replacement for this macro.

I'm not sure what kind of 'domain expertise' is required for you to not use
magic numbers and to not create unreadable expressions. This is basic stuff.

The 'situation' is that I've asked you for 2 extremely simple things that
pretty well all other tests do and you are arguing about it 2 months later
on a NACKed series.

Inviting others into the thread is not going to help that.

>
> Best regards,
> -Jeff

As you know I've gone out of my way and dedicated quite a bit of time to
trying to find various different solutions to this.

It is not far off 10pm here and I am sat here replying to this. I would
please ask you to take a step back, stop being so defensive, and just
listen.

Go read some other code reviews in mm and see how successful code reviews
progress. Concede some points. Defer to domain expertise and to maintainers
at least on occasion.

The reason I keep on bringing up what you characterise as 'ad hominem'
(incorrectly, though it's a very common misunderstanding of what that
means), is because the problem in these reviews isn't technical - it is
your unwillingness to listen and engage with reviewers.

If that isn't fixed, I don't see how any of your series can progress.

And in general I don't think I can sink more time into giving as detailed
feedback on the review process as this. I have tried to do what I can here.

Anyway, I hope that we can find a positive resolution to this as I've said
before.

Thanks, Lorenzo

