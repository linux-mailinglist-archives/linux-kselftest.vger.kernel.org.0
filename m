Return-Path: <linux-kselftest+bounces-42967-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FAE2BCDD0D
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Oct 2025 17:38:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7A82D4E3D24
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Oct 2025 15:38:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32F682FAC1C;
	Fri, 10 Oct 2025 15:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="oscbLpkC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010055.outbound.protection.outlook.com [52.101.56.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A4512144C7;
	Fri, 10 Oct 2025 15:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760110699; cv=fail; b=qSH5KkIXL0xtAiruILX0Mm+v+53hSuEQeYHyEt2lpsGtqINHjPNFPr/8AZx/1Hbueuh1v3lfIpsTc9SOxQ7pErMFc7ezPub5vm0kd3v7U1lnYp/81x/YI10te+cm66XRO+1t5Zb22AHPMowkAOg6QFQvhJpNr4SWamcCP7M/D5Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760110699; c=relaxed/simple;
	bh=3Nx6+LcUyucTcz99OK4YpP73DQQUxf6KPafpcs0gxqc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CnqN0cFxV8x2tEDLS4AmIosa2TA9RGG/BgwiKWdPV0nVHIQcvwUu4M+X/54XHLAogrI3LGtCxtrHcdKVzZXXYAX8zYuKYFN8lDJsEb7SAU9Tutv2JJfReyf7jajdcPN9AmHxIa7MM9gELhj/IanCwKWfcH9DNVYNtO2weF8hsVQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=oscbLpkC; arc=fail smtp.client-ip=52.101.56.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=arbCz3qTWpqIRtOqJl1bjPfFrDDdhP4gQlOIcx5rNSF8EtMV3uV8DEslqFLYAK0Un8WuAlPnVvNF69oFKpX3GLV5HalgXgI/+zbV7Qa0VoEI9eNCQ7dWN5TJxWYGQ5uqZjEfFjDYTVytYEWmp+vHnH+DimX1VnCX0EPIdXtwtcEkEh4cvWiQCY/j/rcRh0s7/O7fYm6I0J125ZJ3BO1z1mfZ20flLkG36qn9f2qO0ui9Ilh5uIjqUQZT7EDQKfkQOCdWBBrWALOjAX5tpCjNjaL7/uiV+LPzm16RbhZqqk1iwhB8jGUrl0t1eZkvXyWwPUDq8u+r5h8yb4IhzQIdFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AUxczi2CGTt7MgNcJoLNHgh7jAXOI2M4QV3SOuR0tQA=;
 b=AK3aO5+JFIhnPBYp7Wp2zT5OmLLU4svYPFCle69TXdFf4TFvVckSfc0W/pMys6DkngPk7UJzJ4fWfBLBeo5OI3hk04peRxzZMrvUQyi8M+e4E21vI99X3UWgJXxzYUm/WmyKWTZ3lWW5S938O4ZsYQz+9BasbWpvoPM5N7sqQ+ZIdYfV6AH64tXN8NtN1KrUgc06KrmxpcAZb2o6Bzq4s37nTICkQOgyrO6JBkrZCUEsidtvUGC7rx+khK7xEqOVRcZyXJ9iwLV8HzOJXwOcsM4uskDiF1tWPITnC/5Gx+SmLbvf0X8iWv7OJi1milS6nwFVER6NmOdOhd+DkhsE0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AUxczi2CGTt7MgNcJoLNHgh7jAXOI2M4QV3SOuR0tQA=;
 b=oscbLpkCU/mhYkjBnxU6SIantNvGqUvuU5/kMOctrbcugz5kCHMNOJoe5K4Vcp0EAybvkluPv6OlzjeM2TaS6t58XOp5pP6jpo1We+J09Od1aH3yNn4z2Uh6mdxQk2qfqpTckyBxdA7lrObQWr8+kfqG4jeMJfqndQRZEnSCZVg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bdc) by MN0PR12MB5858.namprd12.prod.outlook.com
 (2603:10b6:208:379::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Fri, 10 Oct
 2025 15:38:14 +0000
Received: from IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 ([fe80::8d61:56ca:a8ea:b2eb]) by IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 ([fe80::8d61:56ca:a8ea:b2eb%8]) with mapi id 15.20.9115.018; Fri, 10 Oct 2025
 15:38:13 +0000
Message-ID: <a8dc8c62-6cc5-46f0-a514-d2e97c3313c3@amd.com>
Date: Fri, 10 Oct 2025 10:38:10 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: RE: [PATCH v3 0/4] selftests/resctrl: Enable MBM and MBA tests on
 AMD
To: "Shaopeng Tan (Fujitsu)" <tan.shaopeng@fujitsu.com>,
 'Babu Moger' <babu.moger@amd.com>,
 "'james.morse@arm.com'" <james.morse@arm.com>,
 "'dave.martin@arm.com'" <dave.martin@arm.com>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
 "'linux-kselftest@vger.kernel.org'" <linux-kselftest@vger.kernel.org>,
 "'ilpo.jarvinen@linux.intel.com'" <ilpo.jarvinen@linux.intel.com>,
 "'maciej.wieczor-retman@intel.com'" <maciej.wieczor-retman@intel.com>,
 "'peternewman@google.com'" <peternewman@google.com>,
 "'eranian@google.com'" <eranian@google.com>,
 "'fenghua.yu@intel.com'" <fenghua.yu@intel.com>,
 "'reinette.chatre@intel.com'" <reinette.chatre@intel.com>,
 "'shuah@kernel.org'" <shuah@kernel.org>, Swapnil.Sapkal@amd.com
References: <cover.1717626661.git.babu.moger@amd.com>
 <OSZPR01MB8798A07599944A1790AD03B48BEEA@OSZPR01MB8798.jpnprd01.prod.outlook.com>
Content-Language: en-US
From: "Moger, Babu" <bmoger@amd.com>
In-Reply-To: <OSZPR01MB8798A07599944A1790AD03B48BEEA@OSZPR01MB8798.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN7PR18CA0012.namprd18.prod.outlook.com
 (2603:10b6:806:f3::35) To IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bdc)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PPF9A76BB3A6:EE_|MN0PR12MB5858:EE_
X-MS-Office365-Filtering-Correlation-Id: 384fd434-dfa5-4153-67fc-08de0813062a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SjlsbFc4aU5pVU81c2xhWGk3UU12SkU4bnpmaktMYmF3TlJmQjN0Y0t5cjRO?=
 =?utf-8?B?ak45blQyM1lTWjM0dFhES1A0UUFoSG5XakY4RzZQRUhZdlNUbXRxU3N5SGty?=
 =?utf-8?B?akg4TUg0enUrZGRQTFRwNjk1SnlIcFl3NHQ5NlZEYloxdWNvSlFIeGFrWkRR?=
 =?utf-8?B?WnpYVzZpREpTZ0htUzdlVnQrZlQ5cGw3RjdKNGEvTVRYQUxNL2t6UEUyc2c0?=
 =?utf-8?B?aGlGU2Nidk1tQk1CcTNzSDd3ZHYzeTdEdjNzSHJNZVhGdU5HaGJ3U1d1VVJ0?=
 =?utf-8?B?dkc2b3hSZkplSndPRFRtblU1V0gvVU1uSkxwNzViN3QxWlBLNGh4WGx6N2RX?=
 =?utf-8?B?MUF3RzRKSTNpN0ZsTmxEL2tMekNuTVVqRW1tQmRVaVM3eENzV0cvbnZhUTVB?=
 =?utf-8?B?UmpZcXd1V1VGUEEyMStGMUZjNm5lRUhLSmM3czBqanV5QUpOQnVwSmlwZ0Q2?=
 =?utf-8?B?ZnF3RTFPc21OcXRGbjlhR0JVUG9LbUNyVEpodmZVM2xSTURxUk5aSmdGMkZr?=
 =?utf-8?B?OFkrZ05kNlRYZzRRRmduSXhxemVQa3paejFNb1NhQzhRVCtxSit3RTEzWG0y?=
 =?utf-8?B?azNoVzlrMnZQQ21YRkh6VjB5ZzROTER4ODdEeG5WWHY5N0Y0NUZyV1p5R0VJ?=
 =?utf-8?B?c2FYOVVHeGRwTWdINjllaTJzWTcxNndGMVFVUTJ0ekJVdDg2MitYU2tueFlC?=
 =?utf-8?B?bmdDNk82ZEZDVnd3MlRjUEUxdlVPbHRnMHFyc2xyODYvWlJxUlVTVkdQS3JE?=
 =?utf-8?B?dHh5UXhVWDk4SVhMeUhrQUZ3S3hlejR4aWVHa1lGdENYVWdRZ2U4L3JMaFVI?=
 =?utf-8?B?ejhwTVJSL083aUxRYjFCTDE4QVFURWhzTTc2OTlhUFpCU1ViTHFpN3JkTVIw?=
 =?utf-8?B?VkU0dTJUdHFWU3AvRUE4eGIvTnJQVkRuSFFINktONytqRVo5a2c2dGxzTzYz?=
 =?utf-8?B?cDVGd2I3ci9ybGkzMDNCVFhZRk1RV3FDYVl5RHdDbGxYU1ZlUE1zZUR6aXM2?=
 =?utf-8?B?Yy9Hc2d1VWdqL0laRFBtZllhOU14d1FxdGlOMTI4RXpzMm11SEZxNEF3Q2tl?=
 =?utf-8?B?RFpXVDZ0NjhsSDNKWWQ3UkV6KzN2SEJhV1dlYXQ2eGhOK2lyZmFmS014UER1?=
 =?utf-8?B?Vm5uRzZvOFN5b0YzWW40Q1VLSGYzQmM1RndJTGFsaUhqQkhUM0tmRThEdGRy?=
 =?utf-8?B?V1BRZ2tELy9FZUh5d05WUG9ZcEdXUnRDa3dPQk1xcGdLQzRkMXBWN25KZVZL?=
 =?utf-8?B?MndTdlR5bTErYTdOQWJabEliTUQ3amtVYnBVckJQai9wdkV1YnhSWW5iME5Y?=
 =?utf-8?B?cjRFOHlUR0dZdDIxY1RLYzJKK25qVFErWlZ5c2RnMHB0TDROaEdBMVVncDFs?=
 =?utf-8?B?REpSZndxQ1k5TGdRYlcweTVIaGtkamhPdGFkUWhTU1RGU0pNei9oREY1bFJl?=
 =?utf-8?B?VVFIVy9RWTZXOEtUNEZJSXdVekxMK1gxc1hWMy9ReWVJSW9ub1VsVmtjM014?=
 =?utf-8?B?dUMzQ1Eway9FNVJzZm00bzAvZEhtSlo5TTFYQW9UMGFoSEVLbGtSb2IxUEVN?=
 =?utf-8?B?aXo1S25ic1F5eU1wb1h2MzlhY2loVmNsZURqWmhBeHVGTVVZOGhVK3NMVjIz?=
 =?utf-8?B?UXRtaE9OTldGaEU2ejhoeW1ENmE0R3ltUTFHdmNGZHdOVTE2TnUvSUFUU1d2?=
 =?utf-8?B?bE1wME1sRXBPZHpiTS9KSk16V081eUEvU2VOZ3Y0d1BMTERCMko0MER5NWxn?=
 =?utf-8?B?V0FnTFd0Y0ZPbkQ1dmlzcXNyL0J0enVmbGthRjZxZ1pSODJxVFlBY01acWZF?=
 =?utf-8?B?UEIvQkFJVGkrTUV2SlZXNTFEQktickI4cGlrTFFnYjJPZDRZdTdPUURQMGNY?=
 =?utf-8?B?cHVjVG5VUEt0Z3NBeDVMSENTMEtPZkdBMnUwditMYWlkeHRiV3dJZGxGQ2tS?=
 =?utf-8?Q?4YA0L1A4528peuplE6DZ9OJNiKpm9NEf?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PPF9A76BB3A6.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N3ZuUWRhakxWRnAvSFAreHFSb1FhN1Q4eGN6ejhQRkRxQzlHM0N2ZFkxVG5I?=
 =?utf-8?B?YWlacGYxdlVhOG9QU1pYMHFCa2RFYjF2YTl0bWwySzdpbnBvVm1vbFkwZ1Nw?=
 =?utf-8?B?Z3Y2eWJnSGtmd2JLazd4T0RtYTMzeStIV2JyNHlVb0lxd0RnWnQvUWhzRHZG?=
 =?utf-8?B?bVNxOEIyOXJWdmRveFZGcnJqYTVTYW1PME41NTNCeXIzcUFKMFZ3MXZFNTIr?=
 =?utf-8?B?WXY4QkVFeExFbUhLVU0xM1VIbnQ2YzREcWMwcEIrd1p0TzhENm5JWm1TMjJ6?=
 =?utf-8?B?QSt6ejNIVEZjelhkUjJBMVpVYWdxUW85WU1jZlRBWEpIVW1yRGlpZVF1VG1u?=
 =?utf-8?B?UW42MWo3elA3MnhOSTk0UndEQWNXMkJkL1VnU0U4YitzVFFZMm9xRHJYakoz?=
 =?utf-8?B?V1hMUGtXRW5qTGRPSFVxaEZUWDcrWHZjY0prWHB1NlY2bUFvWG81dzVnMGpt?=
 =?utf-8?B?NWsvRUMzbGRqcHBNUDhDaGIxb3N2a1pRMDl1SHRmWFU3THR5Nmd3YVZrOUkw?=
 =?utf-8?B?ZFRabGUrUE9HRlpSb2pGV1NMdzVmaGJBZW1SN2F5ektKcDIvOFRXb29Da2tJ?=
 =?utf-8?B?TEJqM2dLZDlGYjZaRFdDeFIvaTc5K2dwRVNoSnNkSWl2K0R3U2xsUm9wWXE5?=
 =?utf-8?B?UUpQN3VTcmtJd3JDMG5CSTArMVFLR1dQYWp6aGVocDQ2NThWNUpLSXhrdFox?=
 =?utf-8?B?elVlUUpMMlRHOVI0MWtRSGZnUHRYbjdjYkV1d3h2TWlNZ014WEVxcWJXYVJU?=
 =?utf-8?B?WWM3VW90NUVDVjNKU1B3WVFWT29xU08vMFNxdVdibGpwQStDYUlob3NXd1p3?=
 =?utf-8?B?LytNZ1NKNllJL2tsQUFaL2FnQzlxdVhuMG96Z2tHZ2Z6Y2lDMjFpWjY0aDVh?=
 =?utf-8?B?UW9IaG1CaVlwa0oxcXQxT01WaDJqRjk2aUc3cVA0amdEL1hwSHJmZTEzQUNm?=
 =?utf-8?B?UFc3WUZOeklqYkJTTW8zQXk3L1lRL0NjNWk2TWpaOGF1dkdVT0hHTHk1NHFO?=
 =?utf-8?B?NitHczhpYlZJZ3RJTlJhWm9XZ1JDc0hZZWI5a2x1N3JYbjNWcGl2RWNpbnlr?=
 =?utf-8?B?eEJ1YUx5TUx0K2NmZEFlM2tpZGFDcmMyUHY2OWM2eFJ2ZVc0QmgxdkgveGQ0?=
 =?utf-8?B?T0xSUjVRckdxRzJVSnJUN3RvelVpL0FxL3dkWVM0Y0laWmlwMlNpb1E3U2RU?=
 =?utf-8?B?dVc0Y1laQStLN0IxVW41bFhCN09PSjdYWXVoMmMrZE14MEcyMVZrTGpoRDBy?=
 =?utf-8?B?UCtQcU5QNzhhbXdJbjUwcmJzRng4dHVlUk5EUjk4OGY3V3JjOGt0cTdnZmZT?=
 =?utf-8?B?RnRqZTlqOTF4TmNJR2Q3S01WdWNSWjRIQ3RERnptRmttNUNteFhUc09HUXVN?=
 =?utf-8?B?ajdVWkVCMXk4YmxxTHhvSjlCcUN3Z0tRbW5kWFVQOEwzTmgraitVRnhzMnBy?=
 =?utf-8?B?cHRPYUNhOCtML0R3UXVSMmpyL1JEcWhRcGROQUxVS2phN0NmU1orRjF6VWJB?=
 =?utf-8?B?YnV0cHpYdERGVkxHYTlqeFY4azhvRmcxNjc0WEh5a1E0WnMyQ3ovNDNrMG1a?=
 =?utf-8?B?aXlDOEY5T0tHTWJ3dTcybFNWVGlFeS9ISEJURDV2SldSanY4ZXB6QUthQ0p1?=
 =?utf-8?B?Njhpemc1ZTV2b3BhUkNGMWQ5SnNNUUJOdTlraDR6QUd4MjZpR2wzRXJPWEJD?=
 =?utf-8?B?ZnlJVm1EbzZoSkx4bGhEeHZhSUpDbGNDVUNvZWd1Yys3U1E1dGFlaXN4azcv?=
 =?utf-8?B?RklxVDJoS29iODRCcmF0Zy9oemY5NzB6NFdrcEVYM2ZMYURqV0k2Q0RETEk3?=
 =?utf-8?B?M0pCdjh5Q2JGa2RLYmNKWlV0UzlDN1FnZzQ1S05vWDFxOEcwZVNMS280UTFF?=
 =?utf-8?B?MkszVnRNNXhlYlNERzByZFovcXdYWHBFUHFUM0ZUVExFOWJkcHR2bHVGeldz?=
 =?utf-8?B?cnlRVDlpMm52NUJHNTcvbnBvdkEvRDNxUDR2bll6V3R1T0djb25MTGxFWHMz?=
 =?utf-8?B?b0RLRVhuS0k1dy9XUGRSdmVseXEyZ2FLZVZwVDZ5dTVaMUxid2ZUck9tZzhi?=
 =?utf-8?B?MmhOeEFkejNUUWFBK29BZkV2UTMyTThxQU5vYTRTNEJaa0FRUjlWekk4Mlpv?=
 =?utf-8?Q?AaFznkufWelKkHuoIP4yVOrlp?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 384fd434-dfa5-4153-67fc-08de0813062a
X-MS-Exchange-CrossTenant-AuthSource: IA0PPF9A76BB3A6.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 15:38:13.6038
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JzgRlbWLsdxlmjmdgbeKoKbzytifq5g/V20Pv/Yc3dk2Ysga+Yu3I8MfJ0sR92+f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5858

Hi Shaopeng,

On 10/8/2025 9:45 PM, Shaopeng Tan (Fujitsu) wrote:
> Hello Babu,
>   
> I think you are still planning to upstream this patch series.
> Do you have a timeline for posting v4? And when do you anticipate it being merged?
> 
> I'd like to enable MBM/MBA tests for ARM arch (MPAM driver),
> However, I foresee potential conflicts if this patch series is not merged.
> I apologize for the inconvenience, I kindly request your attention to this matter.

Thanks for following up.

Swapnil (CC’d) is currently working on revising the patches. We’re 
aiming to post the updated series by the first week of November.
Since these patches will go through multiple rounds of review anyway, 
I’d recommend posting yours if they’re ready.

Thanks
Babu

