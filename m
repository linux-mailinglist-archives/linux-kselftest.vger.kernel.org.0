Return-Path: <linux-kselftest+bounces-9733-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C331D8C0536
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 May 2024 21:41:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E293E1C2182B
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 May 2024 19:41:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DA08130AF2;
	Wed,  8 May 2024 19:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IPN7OJOj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2066.outbound.protection.outlook.com [40.107.220.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB8B14316A;
	Wed,  8 May 2024 19:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715197300; cv=fail; b=iG+1NmtpG72BGz77KQFjS3v8rPHjBqbFnxMStAkf3FovPHpmamVdPcYuvqqcKcl916za3Uw+GWDF/ogzJkzH213OI2TMiMWwWjgvKQe3GCVf0kUAA+CGhM+JwNKu5mFOdm4qTFkECVIKmV72JXuuluYe2B78c9Ou8gYMdygG6EM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715197300; c=relaxed/simple;
	bh=FTXmFLZuRpW2kSUZU/nlf2JxITqnjJ//Dme2+ZuIMJc=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=RcMQS3545/v05Oh4CUe57T+E6GE95J8xVvL0SXNCet0tGl0HP165WvhpjN44igT9uXPEHepwKLCJifFnJlyIL9RT/NPYtvOuI7t5Sn+rWnAWmU6ZVn0tmQH6N/kEZ49HloJH62SZbzw2cxMBRcLtLfX6LNKx+875ziZR0+3NzwI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IPN7OJOj; arc=fail smtp.client-ip=40.107.220.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DYLv0HEowLO9nuLI6zuJu6MK0i3aB0u0lfUrsWlNxkDs2qyCDf/oo3FqaCnYKk9xw1CpNEI5iTqrG2nH7I2ZwG7Mmbph7KPomr+hjOX8hE/MrD24RSslKT1SWwUe1p0gqngdNW37EMmvXwsukS11hgBzTdLhtwRrPC/z4kudA75g+X7PJRrFP6Jc0nf6uMgls2sD9HQNzOYn1Gx/TC4rU7G+Mn75IQGbHfEIfDJOZr5GYX9IqdQlDALCR3SvcbdNSAy07elbQqN6uH/AXaqYDZkmur0vQ4mNTRenZHdYbEehiOpYLnIJ2iGJveWxcEugE7zjp4QxBakq5tlWWZxOLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tzp/iQV9ZtI/J88NVRv5RhlsjifciYnhXGVg1rkITus=;
 b=WtOu05V5++Yt6rv+qTVfGfyevXgbKAVsju3Jgo/PJWOxw519ZUmxdTXXeNDmAuA9bVubLza/QgDKyloj4gdg46X37q896YV0aghlrQqRfeEHXCsVuQmQVIEJw0g9U1wtlPtEqlzhfHja9QNU4nsjzA7LdsCBev3N3sr6qD8Y51wzv+ZA9DTX6EVMUOUsOWWtR0VuIL/9cDWGLmUTmesAELZl7NXQ/ktrD4jvbLhqUTsos8e0rDf4IBTcczhXeUHS3OsfiLUV4UO8JJjbKwk6V4pR1ecUFBGNsdS18InjOyKcSCrY6Gh3wo8sVBH//N7rYzV+StzKdLYxlSVu6xvOYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tzp/iQV9ZtI/J88NVRv5RhlsjifciYnhXGVg1rkITus=;
 b=IPN7OJOjZjgkjQabtKJ9GM292lTTLo+zQEGzJRUYU7/odFuxZpvQ1jOK0SphGHeXzICSFx/W/4ZopSmNZbka0YNPaxWZG0RJihNvlk7K49BZ7+wKgbj8FPzXDQbRAP8MueHX/k0FujUAurMkls1mk0PXtOuvH07y2GkkRjJo2ko9aQtcw0lfdv1JrQvdG9eEUKUP7Lx3meuLVTbERMgrdLfRbcReC2194/MgB6qUGBascUVWAQu3CARaySWoHLtX56iVhO99b+A4A+DBpxTc+d9u2dsgl1S/Qr+pegDf2HWBKlELiz1EHBCzeljXehE7QRavBtPmzWWKEGuo26aI0Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by SN7PR12MB6840.namprd12.prod.outlook.com (2603:10b6:806:264::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.46; Wed, 8 May
 2024 19:41:35 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07%4]) with mapi id 15.20.7544.041; Wed, 8 May 2024
 19:41:35 +0000
From: John Hubbard <jhubbard@nvidia.com>
To: Shuah Khan <shuah@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Fenghua Yu <fenghua.yu@intel.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Valentin Obst <kernel@valentinobst.de>,
	linux-kselftest@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	llvm@lists.linux.dev,
	John Hubbard <jhubbard@nvidia.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v3] selftests/resctrl: fix clang build warnings related to abs(), labs() calls
Date: Wed,  8 May 2024 12:41:32 -0700
Message-ID: <20240508194132.269168-1-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.45.0
Content-Type: text/plain; charset=UTF-8
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0150.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::35) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4130:EE_|SN7PR12MB6840:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c4d88fc-499a-4773-26d0-08dc6f96dee3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015|7416005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VlM3a1pvS2M4Zkl3VnBXM3dRZS9XcWlMM0FmKzN4ZUtHZzJzTnJ6R3kvOUdR?=
 =?utf-8?B?QnhoYjlmaWNweE5FWFNKVCs0VXJJZkFFTldFdG5xOGZBQTBPak5PTU1QWlRZ?=
 =?utf-8?B?RUgrUUtld21aQndhMzFYM1gwdEV1UEwvdTNqQ0h2YkJHNTZ1OHJOcHlCTk5z?=
 =?utf-8?B?eHBaM3hHcEM0L3h5K0hVZXFSaGNRTTZRTE1ndTNOTTZRU3lkWnpyZ2FxYVps?=
 =?utf-8?B?R1A2UDFaNEttZ1RqaWJTdHVSODNvQ2tDNnh4YzdtcnE3WVhWTGIyMWc3bjFC?=
 =?utf-8?B?ZjlVcms2cncrWXloRUpObFVhWWEwczl2U2ZGZzg3SzlnZWdIZFk5ZDRPM3Fp?=
 =?utf-8?B?M1VKZmRsV3QyNkxHWFJwMjFJVHNkbk40WDgwSVFLZWNTa1k4VXVXNXhqdTJo?=
 =?utf-8?B?Y2t5d0xhdUw5R2QzTmFTVi8wUjBSdW5reTVmR0FhWnN5ZDFUd3ZmRkNFMFJn?=
 =?utf-8?B?WE5lTXM1VHY5N21ML0N6UzA5aEpIQ1ZPQmtZamRTWDcyUXN5T0pVcVZtSDdL?=
 =?utf-8?B?b3AxNG8wb21Lbm11SnJrbVAzRzVsSEFJWFhDZDNNbnJmREowVkNqVGJVU1FU?=
 =?utf-8?B?UXFUR0R4RzJmQWNROUx5dVIrNHZlYkJnc24rN0JOTVIzbjF3WGxSTW9yUTF3?=
 =?utf-8?B?VjFzRjJEZG5VTkZwQ1NxNU1EOElEbVRzSElML2NWS3IybkNEeVBYZkxjam9T?=
 =?utf-8?B?OXB6RWg2K1pMQnd3dVU4MmlzdS9iaWJvWWlwZGNudVZkRkN3cWJEVk5xTVFy?=
 =?utf-8?B?Rm1KSm5VVmFNc2xNTlAvTWJIcW5udndoMEpaaS9DRHRhRjBkd2VtaWJWZnZh?=
 =?utf-8?B?VUt0V2xDVmp5SDVwMlEyK3hBT3p2VnM1cWdrTEYrTzNGdEZvMlFFNWJLMUxX?=
 =?utf-8?B?NHJGQ2FpTUF6c0tQcDRNUDE4dTc5ZFBwelB0dC9WSE8xa1MrVnVySGswM01M?=
 =?utf-8?B?T1pYYXdOQ3ZEbE9BVHU1eU5XUTJoTlZ3a01ScU1aRDhGekdLbTJZY0tyQXZC?=
 =?utf-8?B?RjFxc3Nwc2dpZktMOTVBekZLamcxQ2k0ZGNCOTNNRTJYcHltZUZLVGoweGUv?=
 =?utf-8?B?VDV6WmtFSyt5a2lMN0x4czN3d0dlYjFxZmVaZWZiTkZGZldaN3AxMk02WnZW?=
 =?utf-8?B?bXZQYWFoTjc5QXFTZE9lRDJmMHVrcndHc3FWOFRpZEZvV0NlSEt4Q00ySWs0?=
 =?utf-8?B?T3BKYUk4UUp2bU1YNE1HRVZWVThHVlZFcGRCTjhvUnI2Qy9ERFI5bmU3Umxp?=
 =?utf-8?B?N0NtazE2TmQ2SlphMXZQR29FNXBCa3EzM2piRklqVi9EZkZHLzBzVzVRMUZy?=
 =?utf-8?B?d1dvNElBc25lZitmU09obEZZV1A2cWdRK0pVQXdqUnpSaHRSS0doYzlPVlhY?=
 =?utf-8?B?OXAwVjZiQ1BRbjFTMDViQVRSSFFIakZ0eE5Ncy9lblhkZ1RocWY0WTk5bnV3?=
 =?utf-8?B?UHRTUlhDMm1RVUdtdXY2cGN6bEpBNWVCeHJUZ0R0N2MzUm80K2k2em5UZGs2?=
 =?utf-8?B?NXNwbm8wVGhnR2hUMDlEUFZCQUVZL21VQXlxODJHYllXK3F5Tklpck5LMzB6?=
 =?utf-8?B?ekhwa3p1TlQxUEt4OGpqeU1ERlhHalB0Z0tMbzF5OGRMN0dlOS8wRHBWTXI0?=
 =?utf-8?B?dkJtTXpGYjNTYnRSL0ZtSlFuTXRZZmdIU29BbzBlY2Z0QzJoRTdNNFNhUmR1?=
 =?utf-8?B?UzczNEtNWm93VVdKR243WEs5ZHhnZmN5amM3K3J4MzJyditoUHZhblp3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eHVjOGYrNFo1UjZGMzI1U3lJOU4yYllPeVZzRnRWcGJKb2QyOWdCUFZOMWti?=
 =?utf-8?B?bGd4ZGYxVlhJUXg3TW9vRzdvajl4NElhNXlSZGpGWk03Z29iWndxa0x4V1lw?=
 =?utf-8?B?eFA5Nno3RzRrWml3L1A1TGRjTzY5RjM0WCsxK3NTU1BPVjJkUDU4UFJPRE51?=
 =?utf-8?B?dzRUWGF5ZzY3VG05LzJZYXJZWnpmRGdrMFJyWHlENEViL1V0ZTZ5YzlBYUV4?=
 =?utf-8?B?a0J1UkRUTlBRQXNIRmNPaHlmR3EzVDlDYlBCRmFoZlcxM3dkbXhTdW81SXEz?=
 =?utf-8?B?cU1iWHZTZGkwMC9RL2VKWEZwNW1zZFZmWnJNSjdHT3FjSXRwb3J4NHZZV0gz?=
 =?utf-8?B?UWpGL2pzaXJ2cGxOWTQrdXgvbWd1YndpY1d5SGdsZS9qRUVOdyt3SjRzdnFY?=
 =?utf-8?B?RVlLTG1IYUhNdENxNmxDK1dIa2J3cnVsbTBOUzZ1blg5WHNwZzg2OXNMZlJn?=
 =?utf-8?B?eXQzVldnODVUbEdvZ1o5eFBBTXBsZjdXUHlLcFRWSWEvUnRrZS84VWlRTTJE?=
 =?utf-8?B?SHZsM3NBdXBqSFp1Qkhwa0FVSnlQN2llUS9TT3gwVHI4bW14Q0FuSG5BOUhU?=
 =?utf-8?B?RE1VVHJFcTFoR0lJT2xzaFRVdmlKNk9xLzMzS2E1U2JoQks5Qzl5TXIvODBB?=
 =?utf-8?B?ZWpxLzA0d1NBR1lPc0RZRlF2QjlzVWN6ZFlqWjBrUGhZRTZ4akxhSTN3emdC?=
 =?utf-8?B?SnQ4OVBLQ0lPMnZTWGs3YzRzNVNZY2VOTVdHNUJpRy8vRlExWEZhRjJUVC96?=
 =?utf-8?B?UXhDeWp3bmN3VjBtNytXWUFUdkgzV0xDZy95bUFQdkVNOHZjWmFEWnJmRzht?=
 =?utf-8?B?NVVEbHR1bUdPOHczZlVCYy9VUUVPazNwVzYvUTR3WEVoT0ZEVUdrQk8yblAw?=
 =?utf-8?B?Rk5tMEtlMVJaOC9scEVyNkkvQkVFTjdaOG5iNUl3RzJ5MTR1QUZCSjI5eTVz?=
 =?utf-8?B?b1M1RTJQanBLTzlVTE82MjkrWWlwVHBYMFZBcG5VTE5CLzdoOVpiWkVVTUdz?=
 =?utf-8?B?ZHZXQ0NlYWY3K1dxNFNEL2xVankrQkJLU1FzT1BSR3RCay8vZFVvS2N3Q3p5?=
 =?utf-8?B?Vkc5VG1kRXA2bEpISm5pWDUvZW1kbTZ3MFJhcFpNemlWWVRWcWZUV0F5dGF4?=
 =?utf-8?B?Y2xDVkFDNk1rOWo5RUZ3NkZSdjIya09DQ3U2dkZGa1lXNnY0VUhkVUI0akUr?=
 =?utf-8?B?VHRZVUQrclRVM0R6V2JOSUJ0TENEdUFpWU9YbTNGL253am5mQzRQblU2dFlX?=
 =?utf-8?B?SVBZUUlJWnd3UUswYXdEV2NlZGdmUHdoN295MkpZd0E1R0dTS1JOYm85RVVC?=
 =?utf-8?B?b2ZyOHlIS0wrWDFGdFREMmtJNjkxQ0syRmZmWHZBTlUyRkYrazBQaXovUEVk?=
 =?utf-8?B?VEZZWHA0ZmtRU0l4TWc2V3JidndRbVh4TVVZakFtVFlRV1JtbG1PZ25LK005?=
 =?utf-8?B?aVlRdm5kK29WdGxEMHN6ajN5Vlk2UlloRjRFcFZTMWsrYTFVYzhFV1lZK3FP?=
 =?utf-8?B?SXBHeDNrMEQ5cVAzeXlDeVpscEU3NW1oakhkSzdDYVlpaTQ0L250WnpWeGNN?=
 =?utf-8?B?L3pTVnV2QnJxQ0w5aGdGWDkyaWsvTUZEbWVqTmsrOXRGRUJKMENFZFYzb0tq?=
 =?utf-8?B?TDRaSWQ0R05xSGRSUC9DQWpkdEt5UzhTZm1HZWZIVWxyWWs2RW5FVFU4ZENU?=
 =?utf-8?B?d2FRQUp2SzRxMkZicHROSnpmN295S2ZUVVB6V0lpSzBsWFVHdmpIQ05ISWEy?=
 =?utf-8?B?UmQ0bUtBdm1yMlc0TlJvVWxxTUVJdDczNnVRSFM0Q0lwQWRqamR1a2xmOERo?=
 =?utf-8?B?ZXZIL1BUdTlGcnJCVGpWOVRHQURsS1VCVEhpVTJUbktBZEFMUXREV01RWFFJ?=
 =?utf-8?B?ZjloODJ0c2tXT082VjJ2SmMzc1VlNnVQdDR1bHk5L2JueVdVQ2FuY3ZlcUs2?=
 =?utf-8?B?ZDJlbGhtUkhOUWVWUUhvczhWekp0T1EyZDh5V1VVaWg5bjFQeVRXUk04d3Vv?=
 =?utf-8?B?dFZDbUhDblJLVXNvZ1U2MjBUbVdDVjFXWWdvS3lQTldkYXVGR2dGU2FnT0Jq?=
 =?utf-8?B?UEJLY3BnNDBWdVdxeEprcXVhSHZadXpVelhjc2V3QWFyejh4cHl6a3JMdGVN?=
 =?utf-8?Q?efad7aP0aPA+ohD4NvYhWxLxi?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c4d88fc-499a-4773-26d0-08dc6f96dee3
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2024 19:41:35.5950
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hCVgj3IpM/FT2ua64Oo7IpAK11j5KWfr/kxbaW+wXe1LQ8nPw2kGbnXJwU0cyn+7g7IJJA9Qt8L8Tc88sNLj7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6840

When building with clang, via:

    make LLVM=1 -C tools/testing/selftests

...two types of warnings occur:

    warning: absolute value function 'abs' given an argument of type
    'long' but has parameter of type 'int' which may cause truncation of
    value

    warning: taking the absolute value of unsigned type 'unsigned long'
    has no effect

Fix these by:

a) using labs() in place of abs(), when long integers are involved, and

b) Change to use signed integer data types, in places where subtraction
   is used (and could end up with negative values).

c) Remove a duplicate abs() call in cmt_test.c.

Cc: Reinette Chatre <reinette.chatre@intel.com>
Cc: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 tools/testing/selftests/resctrl/cmt_test.c | 4 ++--
 tools/testing/selftests/resctrl/mba_test.c | 2 +-
 tools/testing/selftests/resctrl/mbm_test.c | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/resctrl/cmt_test.c b/tools/testing/selftests/resctrl/cmt_test.c
index a81f91222a89..05a241519ae8 100644
--- a/tools/testing/selftests/resctrl/cmt_test.c
+++ b/tools/testing/selftests/resctrl/cmt_test.c
@@ -40,11 +40,11 @@ static int show_results_info(unsigned long sum_llc_val, int no_of_bits,
 	int ret;
 
 	avg_llc_val = sum_llc_val / num_of_runs;
-	avg_diff = (long)abs(cache_span - avg_llc_val);
+	avg_diff = (long)(cache_span - avg_llc_val);
 	diff_percent = ((float)cache_span - avg_llc_val) / cache_span * 100;
 
 	ret = platform && abs((int)diff_percent) > max_diff_percent &&
-	      abs(avg_diff) > max_diff;
+	      labs(avg_diff) > max_diff;
 
 	ksft_print_msg("%s Check cache miss rate within %lu%%\n",
 		       ret ? "Fail:" : "Pass:", max_diff_percent);
diff --git a/tools/testing/selftests/resctrl/mba_test.c b/tools/testing/selftests/resctrl/mba_test.c
index 7946e32e85c8..5fffbc9ff6a4 100644
--- a/tools/testing/selftests/resctrl/mba_test.c
+++ b/tools/testing/selftests/resctrl/mba_test.c
@@ -60,7 +60,7 @@ static bool show_mba_info(unsigned long *bw_imc, unsigned long *bw_resc)
 	/* Memory bandwidth from 100% down to 10% */
 	for (allocation = 0; allocation < ALLOCATION_MAX / ALLOCATION_STEP;
 	     allocation++) {
-		unsigned long avg_bw_imc, avg_bw_resc;
+		long avg_bw_imc, avg_bw_resc;
 		unsigned long sum_bw_imc = 0, sum_bw_resc = 0;
 		int avg_diff_per;
 		float avg_diff;
diff --git a/tools/testing/selftests/resctrl/mbm_test.c b/tools/testing/selftests/resctrl/mbm_test.c
index d67ffa3ec63a..a4c3ea49b0e8 100644
--- a/tools/testing/selftests/resctrl/mbm_test.c
+++ b/tools/testing/selftests/resctrl/mbm_test.c
@@ -17,7 +17,7 @@
 static int
 show_bw_info(unsigned long *bw_imc, unsigned long *bw_resc, size_t span)
 {
-	unsigned long avg_bw_imc = 0, avg_bw_resc = 0;
+	long avg_bw_imc = 0, avg_bw_resc = 0;
 	unsigned long sum_bw_imc = 0, sum_bw_resc = 0;
 	int runs, ret, avg_diff_per;
 	float avg_diff = 0;

base-commit: 45db3ab70092637967967bfd8e6144017638563c
-- 
2.45.0


