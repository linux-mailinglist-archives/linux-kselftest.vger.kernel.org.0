Return-Path: <linux-kselftest+bounces-10024-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B4D9F8C29C9
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 May 2024 20:22:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2767AB21309
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 May 2024 18:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F6F124B2F;
	Fri, 10 May 2024 18:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rHkynnzb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2048.outbound.protection.outlook.com [40.107.237.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53DED18EA1;
	Fri, 10 May 2024 18:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715365356; cv=fail; b=swLZZ9eo5fWpgYq53xJpqq7v2T8E+lifsTld9ntLpF5/a/8y/8dpclzgKYAQ/5eZa+mRFHWzCpSOMjUqUzO/fMh1I/U67IYKePzXr+/mOQsnhqbB5Z/v32cr0EBdS4g6YeqqVNdksgQ01hxeY08iXR2moCLr7VqVewdRZf4V73A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715365356; c=relaxed/simple;
	bh=h+zS82SMMZXUXNYLaBlgB565GBfkdCPpjCQcFKLkufQ=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZOrRO+FS2OIm17Yi7TxgGwqhOqNc1FzqVuqSQcCvMrMAOPVkMTNQgWgA3GjxnNtu4WPtaNqmCJ5TnEPLlXwsFmnlOnxNwjRaenBk73OFdjgyPiagls+MXhSWqdgKfDzwGs1a9y75cbYPnrYwi9/PRg866yyohkezMeoi8LIxXls=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rHkynnzb; arc=fail smtp.client-ip=40.107.237.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G7lCYcoB0HVyeBWOV1+9gTB5me5gRopuORfAke7MHaGW3skXujLs/ugkDlrNN94Uuz4zMeYSEKa8veTx/Ts2KNAi1/VF84GfRj5lLkbPj+mhYyGKCAjFflX+epkvBg62UQARJ0LowMON3b88mfzpymPKgbGvgDDmtfKkz0dpl/vyR7lZ5bbtyKQyNXBLrti/duD6auWtTzEQc3NkzONhVsP1evCcIfZq87/1D0OzOl2qcS9Awi7QG0BoCdMMLC+9RQxjzNt4F6ZaFI4owK2dTcCHQi33NFmS7oxjmzs3tCyq1htDfGvJp6g4sUcfC9Vd2NGDfMUvjRBghN334gEYcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qDuOnOU7v1iLUlKG7iSYtVTdU3NIJL4eNNI9h5t+p4U=;
 b=hM4ujSipojb/eM6LWAj8LIthzlBCPJn6mmDODFbggW9OaBCFkhtGAdAqP6BAOnEe53NDFn/CO+yR+ys8pjTDnXUvREjdy5l3u9Qt1y5tzg6hdgGN6EnP7W9mzDrwzqBNACgXa1G7Bm/lspFr/j/YIg0o5hABUY50CfyEuYT1sOi05XhcCOOFUupqn4INAn04/hRvhQucU5WgFvzpBplKyK0VzHoTG9KawzUdFc9DxP2oAqsL78sxtRBVbnwFeemYeMwe6lNPRq0ReQdg4u8lUC7m/GNfRBKJ84E3HpNCc4AzcdIIkl2S7g/PW/RqHvsQkd6+FWw5kWnlH+1m4KeWOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qDuOnOU7v1iLUlKG7iSYtVTdU3NIJL4eNNI9h5t+p4U=;
 b=rHkynnzbaLvVqr3pRl5HgRmzwMr913bDFYsFhCnDuNyMTdd29Bi3yyokRIUrfeomwR9Zd5PYZPw6dbe09hXCOhj92kE7MSuwlhU3+O/Qo4DZa0+6JYAatixpEptozmGhaR53zdkxD7Jlv1AGwW0vQwflnYXIo1yW3UJimw7rG74YYUW+g/bKk/Th8trTiNYx7aUNZntknpQ3lnLbjjTeGqRIC9dE6D8bWu6W8iTIqSdtOZbv+vVVQWnBVJ3gesfwekX87EnZ1tVJvSaoLzBpSO8yIKvu671Z7AhY0tWNVcLlAwYjS4TYcH/IF/323L1FI2Dg109c7AjaIOJJIbBrzg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by CH2PR12MB4296.namprd12.prod.outlook.com (2603:10b6:610:af::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.49; Fri, 10 May
 2024 18:22:28 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07%4]) with mapi id 15.20.7544.046; Fri, 10 May 2024
 18:22:28 +0000
Message-ID: <b28e6bcb-dde2-4ac0-ac0d-dfddb42c4426@nvidia.com>
Date: Fri, 10 May 2024 11:22:16 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] selftests/openat2: fix clang build failures:
 -static-libasan, LOCAL_HDRS
From: John Hubbard <jhubbard@nvidia.com>
To: Ryan Roberts <ryan.roberts@arm.com>, Shuah Khan <shuah@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
 Christian Brauner <brauner@kernel.org>,
 Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Alexey Gladkov <legion@kernel.org>, Valentin Obst <kernel@valentinobst.de>,
 linux-kselftest@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 llvm@lists.linux.dev
References: <20240504044336.14411-1-jhubbard@nvidia.com>
 <c406383d-e08a-4a12-9e25-1c987b0d678f@arm.com>
 <f715719a-c835-496c-9e99-d249e5607a0b@nvidia.com>
Content-Language: en-US
In-Reply-To: <f715719a-c835-496c-9e99-d249e5607a0b@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR01CA0036.prod.exchangelabs.com (2603:10b6:a02:80::49)
 To BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4130:EE_|CH2PR12MB4296:EE_
X-MS-Office365-Filtering-Correlation-Id: 2bee1ee7-e0be-41de-d767-08dc711e2632
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|7416005|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WTBKM3Y3a1ZEMXk2VjdhbFJIWDFab2I3Ui9SU05nZXhOODZWckRJajNuZUlW?=
 =?utf-8?B?V21tcUJ2S3hsNnBGemgyZk0wR1ZDLy9mSFdKazlpQS9qeEppRE9EeWJ4OU1S?=
 =?utf-8?B?MFJlVHIvYkNpS2FER00waUZIemNuNUZrNVluaVFMZk1KTi9veTZzMis1d2Rm?=
 =?utf-8?B?ZXM4TTB1Myt2dmN6dzZXYlBhVHg4WDNuZWowMDNrZjBYc3crV3FFWWo0cmpn?=
 =?utf-8?B?RVZKNDdWaGdQQkFsM2tNaU8wbDlrSWM4TjJ6VXZidXFud3QwclA0cmVMSlRZ?=
 =?utf-8?B?a09BR0JBZDFjb2U1WEJVZXdZV2ozQjArcVBnWGdDUWZSMUFEV2tDODU4T3c4?=
 =?utf-8?B?cnQrMjJyY0pTUkxRUlFYOHpSV1hNWTRyM2tBNHl0Tktvd3Buc2lNeHcvU2du?=
 =?utf-8?B?cXIrWEZ4NkYzQWZ4ZEdHV1pvZFBFNGt6V3RqeEtlcENEWjhTR1VJZmtNazdM?=
 =?utf-8?B?RDFIN1NxS0Nrc2dCZ09qY1l3VFBqMkJ2c2lRRzFzV1o2eXpoYVVPdStPbnp6?=
 =?utf-8?B?cnhEMUUxSUNtcEVpY1ZaeDVIRWNkZkxPbVhvRFdwTFZPS1RjMUg1R1BxZzda?=
 =?utf-8?B?cTFKenI0WkRLaW50ZDZqSG40blZsMnhZQVF4MkJtcThGUnptTjU5d28xUkI3?=
 =?utf-8?B?ejI1Z2J1eU9EaTRveEV3dWozRHJPeXdIYmNhZFhiRU5ZK28waU5kNWl4ZUJw?=
 =?utf-8?B?ZURtNk1PVlRqMGVTWmZLZVQ0M2xoem1lZ01WOGtWUjhHN01JMDBjdzVuOXlW?=
 =?utf-8?B?OFhnc2Q0Yk10T2xod1l2NkRiZlJGbUNNWnBXSjFveGtzelgrRGlKNTJjbjFU?=
 =?utf-8?B?ZzZhc0lwL1lISDZwTStBZXh3QlRXZ25DMzEyS3VzaXhSUmJsN1V0RUlxTlE4?=
 =?utf-8?B?RDJtdjlla0VpRHF6MFVuYk15bWs5dlVDdllJUlFpUms0bDlsc1I3NHdzTElZ?=
 =?utf-8?B?M1kwV05yejdOaGlQTUh6bWdTNTlPVC9YSkpSZTJUV0tWYzc4ekRXdkJPZXJh?=
 =?utf-8?B?ZVhCZnQybGprVy9rSGRqbDJwaVE1OHN3Vjd2Y0JVck1IQ1A2cDRXZ0JOcVV2?=
 =?utf-8?B?a3U5OURrUHdpOWxZT3U0R082b1NtYVp4a3ROT1RPMkZTMWE3eFgxTTgzQ0NF?=
 =?utf-8?B?MlI3dUZOdnVjczRYMXZYN1JGVFFQcTVNeGN3bXYrNjIvR3VIM0tiUmhSRUsv?=
 =?utf-8?B?ZldwWWQyYkJFU0VZd2pxbGwxRzFOZkJxc1ZHNkZIQmR5UHNhMnFJUUNyNytM?=
 =?utf-8?B?a2VmdXhSMmpENGJqWStRT2tVdDJ6UlBDOEhHSUVEVGFhSE4ybHM5TDFsSXlX?=
 =?utf-8?B?citBbWhiUXFHRDRzbkpzdnI4dVZZMU9YVFJNMUxGQmN2dGY5QzFBSXpKZ0pn?=
 =?utf-8?B?QzBtN3JsT0o0YW82ZnJRaTVpOFowVnZOLzZFUWhGQWliMjhpdUc2YXNlUlNW?=
 =?utf-8?B?VEk3YkpRVlBaR0I0clBWTGhkZDdGeTVpUDdISXIyWXlaK1BuSUo0dVFXakhE?=
 =?utf-8?B?ak5kd2VKWlRhVkNhbXdUZlZvcXdPM3JSSE9jWnB1bUlGSTR0bHVrWFFqcmpG?=
 =?utf-8?B?aDhOeS9kN2FpdERWaGQ3K1BuNFh6cHpUVldUOVlta0lLNXNOcXhjeUw1Y0V1?=
 =?utf-8?B?b2JtaUNtZUhpVTZwMnV6ZHd1TEFwTUc1UkRwS2FLQW1CYnVZTWl5VVpEUHdW?=
 =?utf-8?B?SlZSdGVFQ2lubnhYR0hycUpoRkhlVUJaaDVBcVZwemQ2bWsvbWxqYVRrYjRu?=
 =?utf-8?Q?oToEnNAnd74bEIincM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VDFzeUE5NzlIb0JpRnBteVhpd3dzWkRYcllGaVdla0Z0cW1GV285dnVveE1k?=
 =?utf-8?B?aklNVGZJOTRWTW4xSng0SGEreDFoRitmUjcvZURxNHVPNlV5YUc2U0dFV1FO?=
 =?utf-8?B?VDN2bEZSSEVYa1BsMmhxZ3NlY2RsR3pFcmFKRFFQaXpiTlNiREMybVlKVXVV?=
 =?utf-8?B?Y25tRmVXOUNaajUzZ1dqYlY0bXVjVnRPOWIzbHI3RG5GYU92SWF2SkFjQTBM?=
 =?utf-8?B?enVRMTZFRWdPWnVDdDV6SnowdFVLNEZCU0Q4QlltNWI0T0ZGYXplUUhNWGtX?=
 =?utf-8?B?R0paTFA4dE5BOG95b1oxbzVLS1hlL2NVVFJmZjhNUDdBSHA0U0ZIOWl3djAr?=
 =?utf-8?B?UzFjc0lDV1VKOXROOGZaL1BBR0tST3ZUc051eGY4MnRMa3AyaHRPWGhtblhT?=
 =?utf-8?B?RWw5NlFoYkxEeWJEdDN5M290T2gzNEUxWjBZWnQ2clpnSzJDVlNCeXRiWWpk?=
 =?utf-8?B?OVV6ekpRUkM4YlFLdHBWUVhBZjZOUEN6aUNTS3FSQzhCdHRBaFk1ckJ5alh3?=
 =?utf-8?B?MDhISGdBSTNoYWJQZWlTTjJtMDVRMUk1ZXAxL1duYllQdzNJWmREZDB3Q0hn?=
 =?utf-8?B?bElIL1pRcmdNeFFRbG42cUZveDlQQTdKUkFyMHI2ZTdUQ0NOdzRTNFZGblVO?=
 =?utf-8?B?NkI2VERZdzF6Q3Jkb29MQWUzUEFjaEM4bnJmMnRsVG9GVml5U3NzSDhBVjFt?=
 =?utf-8?B?OUtFdW9DV0I2cy9jTENkcUU1dHBWTnF6dDEvTnVlRXZWNm01UDVuYUhpdXRr?=
 =?utf-8?B?Y2ZlNktOWk9MNDFWUkJtaWZWdys3WGcya1FacUcyemhmcnJTTW1YVHFnZ3Ir?=
 =?utf-8?B?RUtMQkJ4NytjMVRBWitQVFltbUh5SkNkcFJsdEo5eFh5QTNJRGNvRndRVmtE?=
 =?utf-8?B?M0t3dm9EMmdmTWxHMSt2RlFPQmxqM1lwRjBobW04QzlzZWJ2RmJHcm9DK1J0?=
 =?utf-8?B?TFB0YlE0aXpRVnZKNXFjd0JoRitSdkQrWlU2Z2F0WVloWWVleGFVZzc1YzV3?=
 =?utf-8?B?N3VHdVJSdm1CUWtvNk05V201bjVPTXZhWEhzanhPdnlxUWtmY1BIcUMvRUVK?=
 =?utf-8?B?YkZ1R0pSZDB6dXBjSnRNYWdoc0s3TjJOY2hXaktCUllRZnlTbzF0N1NCR09h?=
 =?utf-8?B?aFlKSHZCeGd3RXorQ3ZVTk1oemliSEk0QkVqdWVuS1RSRXZjMDE5SUhIeFFp?=
 =?utf-8?B?UXdERGR6YWhHdFlUUXZYTWI2eFM5OEhKQjkvRnVvYk9kWk8wMlEvRXdwYjEx?=
 =?utf-8?B?R0p5RDQ1M2hwRDNMM0lxcGgrUlZxV00vWEZLd1hNK010N2MzQkhDL05qUDNS?=
 =?utf-8?B?QVlPK0laemZzdy92ZHpWdVVjRkJJUis2WmFDQ05hOFQrRmpGZUxWaEZPTnB2?=
 =?utf-8?B?R3FiVWFmQUI2RkpkdU1XL2ROR3pHQVVkTjNTS2Y4QTFxYTBOYVloZU5nUDJJ?=
 =?utf-8?B?VEFhcldXRzNGQ1dhOTk3U0lVN3g5cVdWUk9vcTQydlordXEvTXhqanUwOGt2?=
 =?utf-8?B?N2dKdEtsZ3dwcTlWY2VEdU5hVlRHdDRqa2swS1prbm0xRTI5bzl1L1ljZm10?=
 =?utf-8?B?NTZNOGp2ZCtST3g2eVVheWtpbGpFNWR4V1RxY3pDWHExN0czUVB2VCt4TVVV?=
 =?utf-8?B?TGZvU3lLZ3YxdmpRdFcxamtSd0pnZXdXbTgrd2MwNUQ0by81RGthOFBITnlo?=
 =?utf-8?B?SUlZM05wRUtFL2ZzRkV0ekJReGpSUnNMYW42WklQUnBja28zTXFiZlBVcWw5?=
 =?utf-8?B?SHJpbGdJUXhCM2V3ZVY0M1NuR0RyVCtkdHRJY2Y4RWxHd1MyR3ZBQ1FPbUND?=
 =?utf-8?B?TlF1QmwzemxjWk92TmF5dE54enA3TSt5QjJCV3c0LzAxSGhEY1Z0aWtRQTVQ?=
 =?utf-8?B?OGM4azU5YSt3U29NM3ZkWjFGTzE3UUhHQ0xlYmpOMnlzMWNNVEhwd0RXQlVm?=
 =?utf-8?B?RS9QR3BiNGNmU1BVcVhPSXFGbXVyckN4R0tPOFdlc0FjTStYeTFzY3ZFMkNN?=
 =?utf-8?B?bkVoNzM4WjNDNEM2VFNHbUNMMXhSUHA5YnNkSFNzYjNLNlNRWnNvdDhId2w0?=
 =?utf-8?B?MWhvalBDNHN1NW9MUTFpMHVTZ1R3T25sQldmb0didzRUZkNZSDlZM2hrNkxq?=
 =?utf-8?B?V004a3RsY0ZiVno5ckJpZmZGVXVrK3NWMUcxSy95bUVic2k4SjFGMkd3K2Na?=
 =?utf-8?B?RFE9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bee1ee7-e0be-41de-d767-08dc711e2632
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2024 18:22:28.4521
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wd5e9b+6np/IPQHTTqMzZgvnUMf1NNW8aJC1+rJw7Ap33paJkcizDKEYiaX5PC2KT8y307VQ+KwAZhUpvY638w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4296

On 5/10/24 10:56 AM, John Hubbard wrote:
> On 5/10/24 4:52 AM, Ryan Roberts wrote:
>> On 04/05/2024 05:43, John Hubbard wrote:
> ...
>> It just occured to me that the bug report I was fixing with my attempt 
>> was
>> invoking make like this (see [1]):
>>
>> # tools/testing/selftests/fchmodat2$ make CC=clang
>> # tools/testing/selftests/openat2$ make CC=clang
>>
>> So LLVM is not set in this case. Perhaps my approach [2] (suggested by 
>> Arnd) of
>> using cc-option is more robust? (cc-option is alredy used by other 
>> selftests).
>>
> 
> Yes, I think that would better handle the two cases: setting LLVM,
> and/or setting CC (!).
> 
> For that, some nits, but only worth fussing over if the patch hasn't
> gone in yet, or if you're changing it for some other reason:
> 

I just remembered it needs the LOCAL_HDRS approach as well. Did your
patch already go in? Should I fix up this one here to use cc-option,
or go with yours? Either way is fine with me.

thanks,
-- 
John Hubbard
NVIDIA

> In Make, the arguments to functions include *all* spaces, so it's good
> practice to not add spaces in most function calls, unless they are
> definitely desired.
> 
> Also, you only ever want one of those $(CC) options, so saying so is a
> nice touch. Neither of these is a functional issue in [2], but you could
> do this on top of the patch (I'm only showing the openat2 case):
> 
> diff --git a/tools/testing/selftests/openat2/Makefile 
> b/tools/testing/selftests/openat2/Makefile
> index 02af9b6ca5eb..c894778874a5 100644
> --- a/tools/testing/selftests/openat2/Makefile
> +++ b/tools/testing/selftests/openat2/Makefile
> @@ -3,7 +3,7 @@
>   include ../../../build/Build.include
> 
>   CFLAGS += -Wall -O2 -g -fsanitize=address -fsanitize=undefined
> -CFLAGS += $(call cc-option, -static-libasan) $(call cc-option, 
> -static-libsan)
> +CFLAGS += $(call cc-option,-static-libasan,$(call 
> cc-option,-static-libsan))
>   TEST_GEN_PROGS := openat2_test resolve_test rename_attack_test
> 
>   include ../lib.mk
> 
> 
>>
>> [1] https://lore.kernel.org/all/202404141807.LgsqXPY5-lkp@intel.com/
>> [2]
>> https://lore.kernel.org/linux-kselftest/20240417160740.2019530-1-ryan.roberts@arm.com/
>>
>>
>>> +
>>> +LOCAL_HDRS += helpers.h
>>> +
>>>   include ../lib.mk
>>> -$(TEST_GEN_PROGS): helpers.c helpers.h
>>> +$(TEST_GEN_PROGS): helpers.c
>>>
>>> base-commit: ddb4c3f25b7b95df3d6932db0b379d768a6ebdf7
>>> prerequisite-patch-id: b901ece2a5b78503e2fb5480f20e304d36a0ea27
>>
> 
> thanks,



