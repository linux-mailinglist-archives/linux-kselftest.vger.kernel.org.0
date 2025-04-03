Return-Path: <linux-kselftest+bounces-30077-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E37DCA7A868
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Apr 2025 19:08:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D731C3B6035
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Apr 2025 17:08:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2FFF2512F4;
	Thu,  3 Apr 2025 17:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="aFh/ueRR";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="WGNvyM3H"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3C60251797
	for <linux-kselftest@vger.kernel.org>; Thu,  3 Apr 2025 17:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.149.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743700135; cv=fail; b=Qczutw0M7R74bKDcrKItTLJE87F+5avGnkAnhhavhTCCPTvKVo4a+P3eAKMq4re1IDxcpIT3gbvp7t9EWsZtkMtREVya8QlDKm/hBS/DozoaXMVlncQrzjcUc2aCoXIUodiiV09clLga7kvd5MX0o2T+LXbpoJIoVwdp3IyEnxc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743700135; c=relaxed/simple;
	bh=ULEh4swXioPe1emr0FiIyLEdzIEzsEw5na8QkPkoBTI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iaVmwVqrj+Ud5XTo6nO/cHQx4pLT8N4hniLEkzHm63er59fs5dbMWnX84fN83Sws4qW+gBDUXuAuuwuYzZngFEnAqW8m+DL/r7EOPLPK1uOgR3Ll7TDHWjNSnfQ5gjgVUizwCsUMb4STOMByPjfgEhotNoO/q6uSqKUJA41V5lk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=aFh/ueRR; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=WGNvyM3H; arc=fail smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5334inCd014638;
	Thu, 3 Apr 2025 11:58:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=BH+e41lfTV+JuLmdHfoWV5S936xzT8mLRmr6Q/y3F0E=; b=
	aFh/ueRRCQZ9qdTUMpHWcBkTG8lUPqI0XJ7Kfq9y3mFXiQ46KRe5RUmax0qb0lHj
	6qNYOV+4Oe4nSPWt9Un9bdT6IiQ5Ji/P6aIr7pfaN3QCAQmduvc8YYV2Ri5fHVUb
	BqBZzkXBDLaDLsXyrUidvE8yej/zdoNkNkG59rWIX5F8E/7aFqUQKyZ2r/QxN7wL
	Ho71LkIHWNOHpIQHOu6XtuWRsvZ1+tH6hGJAL6IbRZWR9ruSspYQBpbpc0k7BCaq
	pqhPa8J5X/XrivvSuFD4boAPCowVOJZjtNkn30EQ6RcKhjq9n1rmNmOk+XfSbA3n
	pLHN2kyLl7SNBZ1KnJzJxg==
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 45s4y8jgn7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 03 Apr 2025 11:58:05 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ieslcTFnaWYZw0oPI22nA39uQybGbVCxnS8M4i87ewwRwngIQAdBZnMJMXVSE8xwkRU6etW82TlqcAVZiq/qDNCc8ksmPsQQQ92WZrzOXnBGMznf2CRAUXTD9NLsUxvmj0l8tvoJ+7wizOo6gP9IEKp/kuTJo1n25RmmFkQzTq+JzRan6v+Vz/mCdvYwRWc+jWkAtg25lWg5r8DRQud0jRN5IKbBMbodHfmWw9BsAYnf9Nu//wM8kEX8jAAlIO0bqVcLtl5sOddDncOYpUBPOP/RuVwLIYN30OZLnfYRFDqO0Cz0EcfH8R9sOTisGhEYkQ6/k0gD0h7kXuPh6WU1eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BH+e41lfTV+JuLmdHfoWV5S936xzT8mLRmr6Q/y3F0E=;
 b=rXwLJyKUasjdmD1nSysx9qh2Zi1JmAzwPOqqKl1HFF5kncFUhP0TslsMRxnVbc9BIFXFp5aPTThpxOSgk22Dn/c1DqFLxJMAMQhIhXsmArV6xsNfMJNVq50Llz2G2F6YwWhO+AgttKmUq8UHFrHleVbpYycU+kxHv8xFi2empYlIY5HgLjloPNpXq9Sw1nw7nhR931aHUiNevfrw5+8tCuRhSM7NvvFaEv/JL20wEdpAVsvTlnlVwS6chv5q9STHTzDwEptjXSXgQ2b6ABW/oMxXiJnv6cWiLf6dPtek9jLJ+GZy94P+gosmUw2zMVqF2wIhaCzqiMz7pBQmTOxNAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=cirrus.com smtp.mailfrom=cirrus.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=opensource.cirrus.com; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BH+e41lfTV+JuLmdHfoWV5S936xzT8mLRmr6Q/y3F0E=;
 b=WGNvyM3H9evb3rx2jPSRByrb1+eBzO7CN2gjjzdwkdqGWQhnqPnggn/tYCxYFD/xUYzQ7JU/rkeGjAdWDgkT0PtFhWJLjeyDis9Vd9cvWID/Vhi7xQLq2p0OHPt7gciTEJYWMKZsBuYWimjw03oQlg8MzBDLbvD7qB49fGV1NNo=
Received: from PH8PR07CA0036.namprd07.prod.outlook.com (2603:10b6:510:2cf::9)
 by BY1PR19MB7821.namprd19.prod.outlook.com (2603:10b6:a03:522::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.50; Thu, 3 Apr
 2025 16:57:58 +0000
Received: from SN1PEPF00036F40.namprd05.prod.outlook.com
 (2603:10b6:510:2cf:cafe::b1) by PH8PR07CA0036.outlook.office365.com
 (2603:10b6:510:2cf::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8606.26 via Frontend Transport; Thu,
 3 Apr 2025 16:57:58 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of cirrus.com does not
 designate 84.19.233.75 as permitted sender) receiver=protection.outlook.com;
 client-ip=84.19.233.75; helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 SN1PEPF00036F40.mail.protection.outlook.com (10.167.248.24) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8606.22
 via Frontend Transport; Thu, 3 Apr 2025 16:57:57 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 24019406544;
	Thu,  3 Apr 2025 16:57:56 +0000 (UTC)
Received: from [198.61.68.186] (EDIN4L06LR3.ad.cirrus.com [198.61.68.186])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 534F8820248;
	Thu,  3 Apr 2025 16:57:53 +0000 (UTC)
Message-ID: <40aae10e-184a-446f-b4fa-09935e25ee21@opensource.cirrus.com>
Date: Thu, 3 Apr 2025 17:57:51 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Exclude cirrus FW tests from KUNIT_ALL_TESTS
To: Mark Brown <broonie@kernel.org>, David Gow <davidgow@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>, patches@opensource.cirrus.com,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org
References: <20250402103655.3e0c62d7@kernel.org>
 <a91811dd-6f86-4af1-8d91-02b990ef2fe3@sirena.org.uk>
 <CABVgOSmSU=i9WvUHFERY--Pgqg3Hr_LxgA9HJ_5aG4F-FgKhzA@mail.gmail.com>
 <d9d9fa47-c926-4479-a0c9-fb6c0713b244@sirena.org.uk>
Content-Language: en-US
From: Richard Fitzgerald <rf@opensource.cirrus.com>
In-Reply-To: <d9d9fa47-c926-4479-a0c9-fb6c0713b244@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F40:EE_|BY1PR19MB7821:EE_
X-MS-Office365-Filtering-Correlation-Id: f2c3dc88-a6e6-43b5-9a6b-08dd72d0af74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|61400799027|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b0lRRkRVWDFIOG1rYWgxOVNodVVuQVNxVWU3bWhMSTVzODIxS0ZPOEpiZEhW?=
 =?utf-8?B?ekdoRHVROHI5WFNCNWtlUDd2QVJiYk9nQ0p6VkNFRHozUjd4YmI1Z3NNRy9T?=
 =?utf-8?B?RmM0cXNSUXkzNnBqUzBibW95KzQ0dVhDN0hlOWlHdENyM2pWWXBjMFNwQUt6?=
 =?utf-8?B?V0I4Z3dmVW0zcG9xSWFxbW9EbEFXVkFDdVVZYmh5aVV2WFpYRUk4Vmp5aTA5?=
 =?utf-8?B?c2dlSkFheUZHbm9wQ0xqSStOSThjR1duSFlLcHVId2l1K05uOWpQZFUzVFVT?=
 =?utf-8?B?ZnBQVE4xTWV3dmdISFRWSTVPanNCa0hoTFJhWXJIOXE2SitOL2psUDQyQTly?=
 =?utf-8?B?SU5oalB3anhIY3p3bzczSjFiamFrdUtyOUNTTVlibGFVUGhnZ3BKMGh5R2Jj?=
 =?utf-8?B?Nmw5d1BFdENoaDYzNTF5d1drTmRKTU1GVzIyWFZCblY4bXJzdkJseVczYVFT?=
 =?utf-8?B?eFRnRkFEMTFWUlVZSUh6YU5GbStrcXZZWmoyT29SbVBqZUhsSDlSYWFyN1lx?=
 =?utf-8?B?UnY1LzdDUjdFVGZOZUlVTC9wTExNWlF4S1RkVFBmYk9QL25MTk8xS1M5bFFp?=
 =?utf-8?B?TGxMUEo3ZUs1ZXdxSjhEdnlqUjBZUE4zS0c0aEZSVVpMdFBSNjQ5eXBmZjA3?=
 =?utf-8?B?VVNuakpjV1daVEkyOW9KZURTb0E2T3ZpeVg3WWZDZzRmaU1jRmo4Q0ZPa3JE?=
 =?utf-8?B?eHdlWmRaeWZHUW5nN1VOQUJDNGd4Y05NWThDZzc1Nmc5Tzl2OW1XZHI0ZmE3?=
 =?utf-8?B?dmt3ZCtqVnpJYWVtYU9qQ3NLalhQbGVBS2JlN1NYeWhOSDBIbHg3eVVtN1B0?=
 =?utf-8?B?SE1qdVJ4bDIrUXpmSUM1cExYQklDRHRRTkYzWWpkbm12dmVHRnFSZmRsRExy?=
 =?utf-8?B?YlNvSTh0K3A1aENqQ2p0OUg4Q2N6YkpFY0NuRE1MTWpWSUJITTBVTXhTcDlH?=
 =?utf-8?B?cFNmdVovaEFiS2lIbERJWFp5REJETFZFblBWQXE4OU1EYXdDNW5uMmdOQS9H?=
 =?utf-8?B?QW53Q0I4T2pDY0d3c1FhN2NYQlArek1kTmVVTXFIL3IxM09DZ09XUjNlOUM1?=
 =?utf-8?B?SmpURG5XbDV1QWhmS3FHTzN0TlZPV2c2RGNneVgzZjNXZHREWHVyWDFBZjhP?=
 =?utf-8?B?a05jcWhKckxCRXB5NDdkT1pQdEVOYzV1THpqdmkvOUVBTHZVdmNkQlgrMTJP?=
 =?utf-8?B?bzBUV2lXSzcvNDlCa2FJZndPaTNQTDJRdE5mN2tVRWFlb3Z4ZmxwSEMxdDhm?=
 =?utf-8?B?andGSlpTaW5tUHNjek9valQ2blkxdCtxbWxnT2Zza3pxS0hJbDRZQjgvSWhX?=
 =?utf-8?B?UzdudXhkejBDK1NWTk4wZkwvREtZakpZOGdPa2hPUWxBSU81UFo0MC9RVkdr?=
 =?utf-8?B?MHRxbjJDWmdVOTltOG9nSWh2dG1zTk9QdzhPUzRVRjBLU2R1cHdlZ1p2TTBW?=
 =?utf-8?B?cWdUMHpVbWdLdWYvYU9ETEJsYXcyL0dxazYxd1ZPOXNGV21YRDFFdUNoUmh1?=
 =?utf-8?B?TktsWS9Ncm5yOVlJN0dnZVVCZVZCeXJ5T0t0OG9OV2xkczRIdE52V1ovZ3k0?=
 =?utf-8?B?QVR4c2M2RGRzOTFsRE1hZkRpSE83QW9BMUZxekFkdTJqajBORHU1RnJrdUdF?=
 =?utf-8?B?R2NiLzZiYXRpODFUTHVmaDNBSTRkU2JIMHVwVjFONHZkMzExdnB5VkE1dkhq?=
 =?utf-8?B?b2Fkb1JxUnFjc1dPUkRBMFNWOVozUlN1ZldPWTBuUVc5RW5qem16THllbGVS?=
 =?utf-8?B?cCtGaFB1YnV3eG9xMWxTWitaMTdXdG54UGc5aGk0ZWJXd1FrSkJoSS9sVmpa?=
 =?utf-8?B?eXVLUXRTVUhwR0xNOXhIaUI3cGZQbU42bW43U1ZrRU9Rc3lod1A1TU9VS2gx?=
 =?utf-8?B?MXk3WXZNbEl4aVUxTWdEcmJVZWZUNVdRM0YwWDRvVzc3ZFJUTmhoVWM0ZG9T?=
 =?utf-8?B?NTd4RE0xZzRDbXVvNnlITTZ4bk94NzhkbTVDWExpSUxaTDROaUlLT1JxMlE2?=
 =?utf-8?B?ZEtzT01DV21TTTFBdzNweDhhWGV2enIvUmVERGNJUldXNjFzMnU1czYwdklK?=
 =?utf-8?Q?5Qpx6+?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(61400799027)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2025 16:57:57.5615
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f2c3dc88-a6e6-43b5-9a6b-08dd72d0af74
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00036F40.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR19MB7821
X-Proofpoint-ORIG-GUID: 97sHGemWFelyFrNYzcP9WAzvEdwJVn2y
X-Authority-Analysis: v=2.4 cv=bo1MBFai c=1 sm=1 tr=0 ts=67eebe1d cx=c_pps a=7lEIVCGJCL/qymYIH7Lzhw==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10
 a=RWc_ulEos4gA:10 a=yzdIBmMVihQxGBSljzEA:9 a=QEXdDO2ut3YA:10 a=BGLuxUZjE2igh1l4FkT-:22
X-Proofpoint-GUID: 97sHGemWFelyFrNYzcP9WAzvEdwJVn2y
X-Proofpoint-Spam-Reason: safe

On 3/4/25 14:26, Mark Brown wrote:
> On Thu, Apr 03, 2025 at 02:19:40PM +0800, David Gow wrote:
> 
>> That being said, there are a _lot_ of Cirrus FW tests (over 5000 by my
>> count when all of the parameterised ones are taken into account), so
>> this can still trigger the default 5-minute kunit.py timeout. And
>> because its split up over a lot of smaller suites, it doesn't really
>> make sense to mark all of those tests/suites as slow (though some of
>> them might merit it). If that's causing issues for people, maybe that
>> could be a good reason to remove them from KUNIT_ALL_TESTS, though
>> personally, I suspect the better answer might be to move it behind a
>> config option which can then be excluded from the default .kunitconfig
>> if necessary, as in [2]. (Or just increase the default timeut.)
> 
> I've not heard anyone mention hitting the timeouts, though now I run
> interactively I do see that the Cirrus stuff is a good proportion of the
> runtime for --alltests.  We could potentially add a config option,
> though it'd need to end up in the config file so it gets turned on and
> we'd still run into any timeout issues.  There's a tension with people
> expecting --alltests to actually run all the tests as well...

I don't want to get into the situation where nobody outside of Cirrus
is running the tests. One of the main points of converting our tests to
kunit was the hope that more people would run them on more
configurations.

Ideally if they have any failures they would report those back with
enough information for us to investigate. Disabling tests that fail
and ignoring them isn't helpful.

