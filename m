Return-Path: <linux-kselftest+bounces-29613-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEDFFA6CBED
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Mar 2025 20:03:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7255E7A3F37
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Mar 2025 19:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03DEF17BEB6;
	Sat, 22 Mar 2025 19:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="cZJs8Pt+";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="qTFPInFx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A7757080D;
	Sat, 22 Mar 2025 19:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.149.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742670189; cv=fail; b=QUY33V3yRr12AXm58GyclmThPsE4EhjUxp8kA1t7EF7JGEQuNHRDDBatvuBDM89LarcOn6btwdW0o7M6lb7UQI7JeKYu+4N0XvZERpUuXs4UYjDah6Cjwad6MbZMpga0hU81k7PcfHrIXFgc8JD1kbtsnfQ3CanAz+yQyn+sC2c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742670189; c=relaxed/simple;
	bh=//VnlIqGIr9fipnNUw3E6wbkDdhYKGAKLJVx4ZmxAUU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=FMGxh+EdtPTBCDaOJ4SGp0c4rvZcaK5TIgI0wXIevptX1ZXDlSdt1XXMg1zwb/OuoYDu+QlelZjEL0WQQXQKZa1Gefq2OdrhZ/ct8WqEtYlDPl/70kh9K3f5DlG6k9LUEi9h3JrDSpBQJ/VHUQQR1eqCFaSsgXEQpUVKU3SlGUY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=cZJs8Pt+; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=qTFPInFx; arc=fail smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52MIuDbP021706;
	Sat, 22 Mar 2025 14:02:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=ClBsAAZ08V8tD65V72TIjfYFQqMuE19E8GXLxy9Sve0=; b=
	cZJs8Pt+cIFaJamuV2OkTCSccwkKWYhfMNprNFlPWlb0LTPB/ytmCAPHbDxYdtXx
	GR64BvS189EANTAIU+LnFFDCmAqLNpQRTISZYi4o5t4A4IvG0h/u7w6Nmp3mqMqN
	oj8N3qKnDhcQcSaOgu9+OfdM1qKnOYwJ8ltaJLwrfD+MZTLGnRITJmfnbH5EPoIx
	Uh5fsKddEGYeRsJR8AoUNhdJHvIPzNhAjiIYrw2ELm17h4ejMQz207heYgzDOjys
	2Vni7T1I/5Zsm7x0Ttz8GAkmM1FGa1JO18gMicnvaY1DVR4z5mG14DcgH1qg6heh
	GlNuYV3L2v2M3h3yNImzHA==
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2040.outbound.protection.outlook.com [104.47.55.40])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 45htm1gfh0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 22 Mar 2025 14:02:36 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wa5kCOh8A7LvQHbm1C7qERDrcVkv6ynwwLPPk12CXiqPagc/yv2KRZLgiBRyNCYnK6Si0FCeWVBj9HO3KNAF8uNiKrRc+c0GD3MQpnZvivuEgfLLM1+w0QoP6iXvpNnwkt8cFKxsrA4SDg0G7CwyRlEYs6iaFvaj/U7Nsx/gOFP3ZxGanO8xpq8AjTLeqrSn2ppAxoBSdukxJDoUT9Z7SWIWKT9ojxg1YNDyr3EfadgWbIpVR8le9NL22PDkhPyd0UFezMfnwNSw8XHljXYwDbIVa9YoZni6/sOvZDKxdN/tE/4l23++5NhQHrzB4VHVUJMwryqSHE7mWGGGZZvVhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ClBsAAZ08V8tD65V72TIjfYFQqMuE19E8GXLxy9Sve0=;
 b=EiYqMNsTQt+A1ubEV1crwlR42nTbh6HyFvVfquSPdvplb6zfyN8HBexYx7005TbH+29ayr8LAn6hTAf++VMQpbER62v09Oy6Pz7YWYC7Am4KrHkpHJxHh/UCsJm8CctQeyGvTdogyaQFXZf8umpYUZM5DqHzlqvx9U4TBbU/MkR6waeoFZtjzGD0CIMrIDGc33dqfPMWOTmKOjMEM9xxYZiEbLWQHNVKE+pbAXEsxtvSiJxX9ST6HPoq46/rSwIA4S+ZsWhXmA4n7rkWYePi54mxQcgC7CjR6vFveJMd4PrMy6UogxfaGMHb22cNmqVI2d4+ElZvxk9sUM47u6/7fA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=cirrus.com smtp.mailfrom=cirrus.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=opensource.cirrus.com; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ClBsAAZ08V8tD65V72TIjfYFQqMuE19E8GXLxy9Sve0=;
 b=qTFPInFx8GvyiNTcDyRF2P7QNlCUxedkEnFJ/eUYA7wfACX1jsXY4mhCGbS/cOwQKwG4rW2+mzTH7izPA4wSu8V8N0n3UY5mG3vBKf64B1vwXpfM+MuXUP8AG5xJ32oLQQfS+5PMVQpIaEP74uAB84eSf2ycAHfgXCH9Nt+cVEg=
Received: from DS7PR03CA0169.namprd03.prod.outlook.com (2603:10b6:5:3b2::24)
 by MN2PR19MB3760.namprd19.prod.outlook.com (2603:10b6:208:1e2::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.40; Sat, 22 Mar
 2025 19:02:32 +0000
Received: from CY4PEPF0000E9CE.namprd03.prod.outlook.com
 (2603:10b6:5:3b2:cafe::11) by DS7PR03CA0169.outlook.office365.com
 (2603:10b6:5:3b2::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.37 via Frontend Transport; Sat,
 22 Mar 2025 19:02:31 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of cirrus.com does not
 designate 84.19.233.75 as permitted sender) receiver=protection.outlook.com;
 client-ip=84.19.233.75; helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 CY4PEPF0000E9CE.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.20
 via Frontend Transport; Sat, 22 Mar 2025 19:02:30 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 8C3A5406540;
	Sat, 22 Mar 2025 19:02:29 +0000 (UTC)
Received: from [198.61.68.186] (EDIN4L06LR3.ad.cirrus.com [198.61.68.186])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 637B0820244;
	Sat, 22 Mar 2025 19:02:27 +0000 (UTC)
Message-ID: <9d6831c7-053e-4414-ba9f-f5e71c690588@opensource.cirrus.com>
Date: Sat, 22 Mar 2025 19:02:26 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] kunit: cs_dsp: Depend on FW_CS_DSP rather then enabling
 it
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: Nico Pache <npache@redhat.com>
Cc: broonie@kernel.org, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, simont@opensource.cirrus.com,
        ckeepax@opensource.cirrus.com, brendan.higgins@linux.dev,
        davidgow@google.com, rmoar@google.com, johannes.berg@intel.com,
        sj@kernel.org
References: <20250319230539.140869-1-npache@redhat.com>
 <CAA1CXcD2g=sRRwgLSudiOAqWXq3sCj+NPuE1ju7B2gFXXefjXA@mail.gmail.com>
 <d8fc1f66-f220-42fb-b58f-f5f9c7d30100@opensource.cirrus.com>
 <CAA1CXcA460xfy48JMNeX5rNTfUqsahER8SDF6tWu82V35ripLg@mail.gmail.com>
 <CAA1CXcD2RF6aXNH0ix=GN1+LTR9+dV7yRz-HGKZfUbSu+8ZM_w@mail.gmail.com>
 <4cc16ecf-d498-44a6-99b2-eee840cff63d@opensource.cirrus.com>
Content-Language: en-US
In-Reply-To: <4cc16ecf-d498-44a6-99b2-eee840cff63d@opensource.cirrus.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CE:EE_|MN2PR19MB3760:EE_
X-MS-Office365-Filtering-Correlation-Id: d73a9204-976b-4db7-8021-08dd697418f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|7416014|30052699003|61400799027;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TjNqMjJEaW0yQ0c1OE5lZ3RBN3gzRmt4d0RGUmxJZ3RjdU10MjRqdlR3cDE0?=
 =?utf-8?B?YUJ1dittNDRoNWoyV3RocEg1S0N1Q25VWkFwL3lFTjlhdytwek5NY2JzNzJJ?=
 =?utf-8?B?Z2daOW9lemQxOVlNOHErTW13L1k5b0ZhN1dPcWUrY0JKNFVCckV6RFN6ZnZa?=
 =?utf-8?B?UmdBY0dWc3NnVVhON1I1NlNCbzBnVndFNGw0ejVWNzN3enA0UnV5Y3FCdSt4?=
 =?utf-8?B?MkRUZ0tadXJVa3JQRFF6OW40T29NOGIxMGhPY3BuTDRoSHl0UDhsNFRHc29T?=
 =?utf-8?B?R3hVNEhqYmd6UGo3Yy9zbzRBdlB6c0pCNDlQNnZhU0ZTa2JscytJS1czeG90?=
 =?utf-8?B?K1MxWW9PenZvdERZbWR5R0g2OEo4NHN6VGNlQWZnZTB3U3dSVnZaeGRnSTYr?=
 =?utf-8?B?UlJaQnl0R2pkRTVVQUdMK1FxOTdScWJzcGV0V092SHpGSkxrekQ0VmdhR3dV?=
 =?utf-8?B?dlpub2NINkZ0eVVFRDVrV1A5TXVSTGpWNWFoZmxhZEZhVEZLbHVCSlNNd3VL?=
 =?utf-8?B?WVF3ZFVyTHpMZVhReDlmZ1VHSGRhTUFXK1ByTGZuTFlPSzF2a2xhSFZ4dlkz?=
 =?utf-8?B?dkNmdXcvSEpwTlk4aWorSHJyak8wTzdpTW1vNVJaYVk2TGI4d1ZFQnk0cm1G?=
 =?utf-8?B?UHphNVVaVE0zb2NjU3hiOHRYUkRZL3d3aHRVOXl5YW9TZEoydFdNZVVSNGky?=
 =?utf-8?B?WmVJWUJxTzBwTnk4dmxnVGF1WFlTMU55N2xpS090NnN4ejdHVkh0Y1REK2t6?=
 =?utf-8?B?TEplTS9iR3FPRTNIdC9rOGtSV3U0Q0ZVclVSOWhvcVkrWHBVOUdQMURpVTEx?=
 =?utf-8?B?L2d3K2ZkUWtqM1k3Y0ZqTlRLWUt0T2xScHhvaTNlaDhtT1BDNGljTEZMbmZw?=
 =?utf-8?B?TG93akdWY1hvVkQwRDZ1Zy9qM1BJRWVSNDE0SE1MOU8vV0VITnY4RG9VTW5x?=
 =?utf-8?B?K1lDU1Y0V01WOFNmbExTTzVGWmk2OFduTTM4eGV5YzVaSncrd1U2WlYxL0pG?=
 =?utf-8?B?SUpWVUl3aU00VTJWVE5rdFNCSVZHckdYMWo0ZkFvZXZheC9qRFpUSCttK3h0?=
 =?utf-8?B?cG9zdUVHSUtKYmw5WFFHbUVEb0VnSUZHSThtMEJ1OWQxTkdkUVByRU83VWZR?=
 =?utf-8?B?bHZJK01Eai9UVW4zcW0wU0hsR2c1STBtK09JdjBTMHg2QndMVXltM3JrZHE4?=
 =?utf-8?B?djl2Q2UyUU5vMTJOU0tlQXNxWkVHekozcFhRSzRVakptcm1XWm1SS1pKdHZo?=
 =?utf-8?B?ZzBBanc4YkdUSHFIbEFjaVE2SkwvdE5hSE12WWdMNWlFOHZSZEVHU1NTTFhN?=
 =?utf-8?B?Sjl1VXZCaWFYeHo3Zjk3eE8vR0NvQnc4NUh0bnRJMS9kT0Z4ZFlnQnRNM0p2?=
 =?utf-8?B?aGYxR2hYTXc3ZWk4VUxjNEVwOG5xZVNTWDRaN284TmN6OG9oZkpEdGt3U3ZE?=
 =?utf-8?B?V21nN3hOZ3l4T2lxSGpiVGdVa21HOUlMdExiZHYzblVQWStoazZYNW93VHV5?=
 =?utf-8?B?Sy8xWjFhOUFvU0g2MkcwZjNwRzlJNE9vaHRWMGFBdWpBMzVvcGZOblo2Z04w?=
 =?utf-8?B?K2F2SDIxdXpwRTJCSjdmOU05VEo4eUxMT0E4TkE2UTQxT0hkL3BRbnVxSXBt?=
 =?utf-8?B?QTY5VnRZakJSSTFkZHFpK2hzdjl2WU0rNGptUWxlT3lvcWlNTGwvNkNHRS9k?=
 =?utf-8?B?YXZZN0U5L3BKUUs3cHBkQjlRdFpjRWdTYkJ6bVVEOHBYR2hENWc4TlZtRVZE?=
 =?utf-8?B?MXJoejdxam82aCsvNFhHWUZ3Zkw5S0IrbW5KblB6cW1LbWVsQXBOaUFsZW4w?=
 =?utf-8?B?Ui9vVkJ5Vjc0bVVvSzd6cTAvNnI4RjREWmw3VUI1VldNRG1mQ1ozZjNnMlBt?=
 =?utf-8?B?dHdSOGtKUzQ4c2RVN3FNL2FkNXIvYXNpc1plcGdVaFNiV1Zka2R0emJGKzUz?=
 =?utf-8?B?bXhjNjluenNnZzB3TTVURERFT2FsU1kwUk5uNTEzZ2EyVHQzZlNlY3NrTHBT?=
 =?utf-8?Q?aGaUEv8OAxncW8lQz6vbrVMSOWPrXA=3D?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(7416014)(30052699003)(61400799027);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2025 19:02:30.9400
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d73a9204-976b-4db7-8021-08dd697418f3
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9CE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR19MB3760
X-Authority-Analysis: v=2.4 cv=WvwrMcfv c=1 sm=1 tr=0 ts=67df094d cx=c_pps a=OemXRkCljtmPz/OzEC+nkg==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10
 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10 a=VwQbUJbxAAAA:8 a=SXbSFBWwjd8au7aDGB0A:9 a=QEXdDO2ut3YA:10 a=BGLuxUZjE2igh1l4FkT-:22
X-Proofpoint-GUID: s-BZ4JelVmLgTghKwp7Jv0fHuFLvaD8w
X-Proofpoint-ORIG-GUID: s-BZ4JelVmLgTghKwp7Jv0fHuFLvaD8w
X-Proofpoint-Spam-Reason: safe

On 22/3/25 10:11, Richard Fitzgerald wrote:
> On 20/3/25 17:35, Nico Pache wrote:
>> Sorry links got mangled
>>
> Thanks. I'm on vacation right now but I'll take a look through
> all those when I have time.
> 
> The unterminated string bugfix is this:
> https://lore.kernel.org/all/20250211-cs_dsp-kunit-strings-v1-1- 
> d9bc2035d154@linutronix.de/
> 
> I got lucky on all the UM, X86 and ARM builds I tested.
> 
It looks like that bugfix has got lost.
Mark sent an email on 20 Feb to say it has been merged into his
sound tree. But that patch isn't in torvalds/master.

It's possible that the unterminated strings are causing the problems
you have seen.

