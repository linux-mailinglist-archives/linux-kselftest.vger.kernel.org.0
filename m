Return-Path: <linux-kselftest+bounces-20243-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0B429A5EAB
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Oct 2024 10:31:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CAC3283361
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Oct 2024 08:31:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 107191D2707;
	Mon, 21 Oct 2024 08:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="D14j7Uri"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2051.outbound.protection.outlook.com [40.107.100.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF1C71D0DF2;
	Mon, 21 Oct 2024 08:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729499471; cv=fail; b=hYtGOaZhng5LZ1Yf45H5TmUx7EOKqjsyNnpk9haIx7doW938JMHDVa6yCxlcJHLup0xgueSqtlePCQXTC5BPiElErsOSJ+AFT5ZAV5cG4dN8e4AaR2hBOalt/6vPHr9ahi3Rhud46S4c/usqSm1B6YJWRm+7JD3nZe9abJ1oo/8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729499471; c=relaxed/simple;
	bh=3OuquXYRqshnpNAHUFwZek/xY/HUFWmiHHkqN1Bc/0o=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jdlso1ny/aXZjhs7iq+jQgu4kAFdjHKNocmeZgi28trJpY5ASv930R55xwRmyRubOMkOpIk5N1rPAbAFIVtTn84zicZLArS4l0LMEl1FqlaDLXousszmblwfUat98pcZR80IoN9QiA+Ygr5JOqvK5j1PFdQGWDnzesYmLoEFxho=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=D14j7Uri; arc=fail smtp.client-ip=40.107.100.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TdHqh/sUBnqb46JB3jKuXAYEkMBXPgCn5CZK0TjBcTSsjjRm5pkiFnQ4VbXSXAegM5Y8sGsgk883M4tLtmBXxEb6MpzmBhFb+XsFo8WoRJ/jm/eJOE+BtVQMf5Ip0HOBUmBK7TzykAsBhfyuRbFrXX2vbHKeI1LsaxG6tpXS4aLdR6p3B+ri+xtbd+zmNXDS5YFxp85vxJhtIy2KVyTaGMguIfGb0L3tBfd3QJwvmQkmKYir8z7Uc4Dg3EJ1v891gshUEzxnLTsA3ueLidXh0YUMbcRujj7TgN7zNmjxBoj2RNAiYVnWdr8dpkh78rRfppHJ77esGBrjO4N6BVp1yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IkNPJVF3CjNn3+cewgkCLd+NZmVlKfP5sqF9hbWUeDo=;
 b=nALyxgIE3UMfxxAjuBPxWUpC/dVigve/0C712HZL8cA61Mjd9YqvLE4WkuM1XHAn9yXSzuebO74jN21baCl7VLQMxZvuI0GgggTqWP13zEMuWc9V0cOGWLHXiq3cVygmBF/UJSgZbMf8r0z2uaXvmydfKSP4xYwBsSDXXzbWlw536GllLirRfkEXTkFd+FU7rjaDIwz27+Bc0kOqBn3tntZcY0DRuDEMp9GelZ0MQv4lzy/iH2onW0q6f0pywxuSecdqxS/Fo37xgQlVYWT/ioIqk/Yay+Q6uYGSNeq4orSNvlpT+U4jm3DYOE+UQgRKKoTA9KW/+n+/nhN6ZZE/9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IkNPJVF3CjNn3+cewgkCLd+NZmVlKfP5sqF9hbWUeDo=;
 b=D14j7Uri7qMvJMxysfsxpp+bUcASvm6pGKDRV0AonC4aUBRHsAyXyyHfFB+JHnMTtrjtwXQ6CouTI6O5K6Vtq/OjxutxK6j7WfbVFDAV1ufClAYTiGeEDV4tKZOutdmjwwwt098Ft6c6Ac4YikGUlkTObQmGcK76tmkKLJGEQIk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9194.namprd12.prod.outlook.com (2603:10b6:610:19f::7)
 by MW3PR12MB4364.namprd12.prod.outlook.com (2603:10b6:303:5c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Mon, 21 Oct
 2024 08:31:06 +0000
Received: from CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f]) by CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f%4]) with mapi id 15.20.8069.020; Mon, 21 Oct 2024
 08:31:06 +0000
Message-ID: <7f808273-a920-4937-9693-68d4a1557491@amd.com>
Date: Mon, 21 Oct 2024 19:30:57 +1100
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v3 09/11] iommufd/selftest: Add IOMMU_VIOMMU_ALLOC test
 coverage
Content-Language: en-US
To: Nicolin Chen <nicolinc@nvidia.com>, jgg@nvidia.com, kevin.tian@intel.com,
 will@kernel.org
Cc: joro@8bytes.org, suravee.suthikulpanit@amd.com, robin.murphy@arm.com,
 dwmw2@infradead.org, baolu.lu@linux.intel.com, shuah@kernel.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kselftest@vger.kernel.org,
 eric.auger@redhat.com, jean-philippe@linaro.org, mdf@kernel.org,
 mshavit@google.com, shameerali.kolothum.thodi@huawei.com,
 smostafa@google.com, yi.l.liu@intel.com, patches@lists.linux.dev
References: <cover.1728491453.git.nicolinc@nvidia.com>
 <320e7f6a93f50d00d7273ad8a2f06be928a6ed35.1728491453.git.nicolinc@nvidia.com>
From: Alexey Kardashevskiy <aik@amd.com>
In-Reply-To: <320e7f6a93f50d00d7273ad8a2f06be928a6ed35.1728491453.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SY8PR01CA0011.ausprd01.prod.outlook.com
 (2603:10c6:10:29c::14) To CH3PR12MB9194.namprd12.prod.outlook.com
 (2603:10b6:610:19f::7)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9194:EE_|MW3PR12MB4364:EE_
X-MS-Office365-Filtering-Correlation-Id: f1060614-d83e-446c-d2bf-08dcf1aab4fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RUJyamRyMUNqaWJnNW0wMHVVYnB5U0xqWS9xOU5HMkxPSHAvbjFldUFBeVJy?=
 =?utf-8?B?MFNuU205Q1lrcUZ3NzlDY2I2UXVuN1IraVlsY2piY09GNEQ0Vk9kWW5tbzNv?=
 =?utf-8?B?T1M0WWRvQzdOUGNQaWJVL0dsaU94VkEyU1BPWUd3bXdEQ1BkM2s2L0NlZit0?=
 =?utf-8?B?aDluN2laRU5CZnBoWDhlU1JUWVBiV0JHaXNvcE00WWVQSS8yTFlhbGh0STJN?=
 =?utf-8?B?c3hucmFsV1U0MTVRSVE1UjduMVhrYkhRMGx1WVdQWW45S2JrR1RMbkg0SHRZ?=
 =?utf-8?B?YStRcS9ONlQyNjM3OE0vWUswZnNXQ0c3YlBkRVRndVdOVCtqZW9Pb3RyU0NY?=
 =?utf-8?B?dVpRTEkyTUVKSjNQRXdqam95QmVWTzJxeVdkOGhnaEoxVmV4U0tYaVhpQnEz?=
 =?utf-8?B?am83RVhBbkgrK0ZGZU5LOERXWUNINDdhajFMQXFlanVLbnJWUTdhR3REL3l6?=
 =?utf-8?B?R2JpUU9UT3pVK1ZVM3lUVExjZGJTejZsd3ZobnRPdFlIUWgxV1I4bnBFTUEz?=
 =?utf-8?B?MjJla2NIaWhGdnZQZktETHdtS3ovbTZhS3c4dGNONGE5K2NGMkFPeTNldTRN?=
 =?utf-8?B?ZFI0TlgrOTc5WWhJMytaWVJCdlVjUDhBdHdiNXlHM2JXS1pqTVJnRlFDbE5G?=
 =?utf-8?B?d2R4bGR2K3FXZllaaEY1VmVuenk0QmNUeEhwSHBRalMvMkN2OEFKWDhONUxo?=
 =?utf-8?B?WlRscURRcGVKcFBneW1Ddjh6MDBwcTkvU2dZdUFQTHowaVVZNDR2T0J3SjlN?=
 =?utf-8?B?RGRXM1lSK2JuWnd6Z0pHcWxQeTJOL3I2RmdxTFBhM1JYVzM0OWdmL0VscG40?=
 =?utf-8?B?Y0I0SFBud3p0OEJQU3JoM1ZzVW82R0ZONFhZaGZxc0h3a0M0czRZbUVIQ2lL?=
 =?utf-8?B?OW9mVWRtZ1o2Vm45MGY0YUhHSXpuMmQxaExpVFpuOUZqTmdhanVZUnlYUTBN?=
 =?utf-8?B?amRmU2RjYiswbVhlQTYwbitMeEszd0JxN3pIekZEZFlzLzgrcVhYRThJcTQ3?=
 =?utf-8?B?N3hRRzEvNEF1MVhMU3NqdWRqMEZsczNLNE56Y1BzTEJDSUo2ekhsblVFNjNX?=
 =?utf-8?B?TDNRVGRwNzlsM1hHKzUxdlFodlNiRUlWd3lHZG1LbkM4UUYxWUJNUFdHQnNV?=
 =?utf-8?B?SXZWY0lGeXo5QnNhUytrUXVyQ1lZc1Y0ejBEdXJDYjMrQ0s3d2pRdVI2Q1kv?=
 =?utf-8?B?QURjSTNJNGtiaUg4UzNCR1A4K09Qbmdxdk9mQTRiYk8wbGpha0FXWWY5T2JQ?=
 =?utf-8?B?TG5UcTJHOHVYbEgxRzBTQ1NZVy8rRFl6NWF5SnprRXFmelRDRW9IUERFMC80?=
 =?utf-8?B?M3BtRDZSOWIzQUZTQkRwYnJpZ0xDWUwvY2swbCtCQkJnaU5YQTJLdTNxSWtH?=
 =?utf-8?B?dVUydkRpZUN1SXlXYmVkcXZQNTJWYkZPdHRJaWwwcnM0YWhEU001bzMrbTY3?=
 =?utf-8?B?eFRNWU9wMWN6eVI1VGFYaWN2VW1LdmVDbjNocVc1ajNRSXllY0p4VVo5ei9W?=
 =?utf-8?B?Qm4rVElGeG9ELzhTd3NjeEdiOUlvRk5CWG9zQ2xQbnJaL2srdWwrVEh6dnFB?=
 =?utf-8?B?dE1KT3E1cFJ6TXdWYkpiQlZjb25PSFNjQ2FDQktFMTZHVHk3YmpWeXhDTWJG?=
 =?utf-8?B?WXZkQVhyV2t4a0RXaHNPY1BIbk5LSHcrMlFSdi8rM0dIaGhVTXJyNU1SWGJD?=
 =?utf-8?B?U2ZPd3N1aVA2VEJBUWhFV2txcXFpU1dHNHZvUGhodGoweDVvMm51ckcrNDJ2?=
 =?utf-8?Q?4DFXJ3OE/q1SZtFTL8X3egyiBuT3au5J6SrLSYG?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9194.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YmtueXFFRkc5bm1RUjZOS0N6Zk40Rlg1cGRZaDdNbVdYUjFTODQzMEwzQnNK?=
 =?utf-8?B?cU02NWExZS9SUnpZNDk4VWR5Z21MRVRwQnBPbmIwcHliMlNwY0lnRkR3MGZR?=
 =?utf-8?B?VStRS2NwN1hyVGNmYjNOWkw2ak5LL3lJYjFxa0ZTTUNWRlVOU2hWUnlzMlp3?=
 =?utf-8?B?TzRuV3NrRGM2S2szSVVFNDhOYnZjcy83V3huRHVNZllzSEk3TUdwSHRYOEZ5?=
 =?utf-8?B?bU5iWmxlM3JRVUpVMGtjd2g5dVIrOXUyK2ppbW1mRVRWcVVGazVjb2Z2dVN1?=
 =?utf-8?B?UXh5czZ2cG9JZDFvK0RqUjNZL2pFOE4zWmRkd2VnTk9LL29rL3lORTgyR2sr?=
 =?utf-8?B?R0hFcTFpRXdQWnROMC9sSzIyVTFUNnd4bENsbW9GTHlPTENrTlVMTys5ZUFq?=
 =?utf-8?B?c2FqVzhEd0UxcFZ2K3kwQVVkQkJGVkh4M2V4bFl1N2toTDNHUWVkMGV2Zm1m?=
 =?utf-8?B?UnVsYjVFVHN6a2lRNWI1eU1pN05EN0lsb3BiQk8wNk5sQVlGcmw4ZnZMUTQr?=
 =?utf-8?B?MDgrUThwS1NzR3o0b2F3bGdPa08zU29oK2dUQkFDWTI0MERqVUdmbG5rYnRn?=
 =?utf-8?B?ZU9oMis3aXNySFlROGpxc2lsUkRKNXFDaWpnOEMrMGlmU3RIYU52RC9FUUlY?=
 =?utf-8?B?N1pTUnEvdDRKeTFrL0J1ZTRHQXJRRG0rQkR6K3VaWVBBV29uY2hiSjd2eVlz?=
 =?utf-8?B?ZGdaQnZsck4ydXBnaW1nSmphR092L3IxSXFMZGh5Tno1OUdkdUI5NlVzWHlL?=
 =?utf-8?B?WTB4UC9rL0wwenBVdG8zMUtzZHdWbFc1RnUwbmh5eWlrTmpZNmF3bFhFWDk5?=
 =?utf-8?B?S0p0VFg1TDdBQXp4T2ZvREkwWjUvQlJnTFVPa0xZRzdKeVRacFQ2OC9TYlpn?=
 =?utf-8?B?RnEyRFc2Rnh3T1JHTHFqc0ZEWEJQSjZ2LzFWdVZHZFEzcGV1SEtiaGQvKzJT?=
 =?utf-8?B?ZmtYUmlpUlVYbHlaWEhPU1ZLclkvbVlaWXVCZ2J4ME56UWFndjllaDZHR1BP?=
 =?utf-8?B?MGpSdlQ1OEJhZDJrMGdWSTlzSlF1TzVjYzEzNFhLV3VheWhUTFlnWVNySWJG?=
 =?utf-8?B?T1poUENKMjV3d3IxTjBWMkpKQllOdHRJaHlvb0tyMjhaR0VtVXA5dG1ZaFcr?=
 =?utf-8?B?V3dIUE9OL2VhY2ljVGtEWXdoWDE4NVpWZk0yOFRxWW1xZ3BGYUhIcXRMcWJY?=
 =?utf-8?B?MmlYSTRVWmp3RFBrajRacHRId2NmMTB5amxTd3h5dkJqVHNxeTEyY0ZGeks4?=
 =?utf-8?B?U1RsaXdENG44OVQ0R3ZKTFBnZ3dxYjVCb2MwU0xpQ3UzQis3M1cxREsrVlVa?=
 =?utf-8?B?UjZnZHgvdGxaajlBb1l0TnlsVlAvSXI0aG9MT21FaTRkbHRnNlN2L2ZlWTJx?=
 =?utf-8?B?RmFSajFPQWw0KytRekIwZnRwNHdidW5jQk1mQW90R054SmFYWHE1WjZ5dm9z?=
 =?utf-8?B?cEZTN1BBZjlPNlkvQWtHaVhjYnE3OXd6aks5RFZ5SmV4MTZyZ0tWZVFkRS9C?=
 =?utf-8?B?QlRtUXVUYkhadSt4SUoxZTQ4OUZXRm5KOGdZUTN1ZC9lM0dvTytGekpiaTNs?=
 =?utf-8?B?YkhIazZnRlBVTWVvNytkZDBlT0MvS3JVSGhnd3dia3AwV2dFK2lPalhNbnNF?=
 =?utf-8?B?YTl4M2dlajdNZ0Jnc3JmbHVPMnJUUjhLd3NxYXUvWWtqQkg0dUpIZzJDanAr?=
 =?utf-8?B?d09PMzkvd3JnYnBQaDJxcjNYQVpwYzNpM2R1b3MvV3BiZkg5WTZ1UW1aY2po?=
 =?utf-8?B?b2NDRVVDbjhlbjNVREZjWEJkOUxoNFJhbnhtN1Z2V3lETWhVcjN3S2FlMnJV?=
 =?utf-8?B?TXNnZGFJSUFsc0M0RzcyUGNENUVZYlRsMFRUekI5ZjgwcnlrYVZ1dHFsOUZW?=
 =?utf-8?B?S1EzS1lMakJXN29iWUFyZjJlNW8wREdJcEQwc29mUFhjTmFjNVhzZEdvVkZB?=
 =?utf-8?B?T3M2b1BYSFBCcXI2cWY2Z3NuSnlvKzc4WTVxQmNVNTZiWCtBZGs4N1FETVdz?=
 =?utf-8?B?bDZCTCsyWllYVXEvUU10cThhTytjSUE2cUUwV2Z6NjFnd2d5TVBBd2gxa0xh?=
 =?utf-8?B?bHFxM3BrTzBvWlJvVk1lM1NXRmoxbjcxN0JSdmxoVzh5eWYxM0tyc0ltWXZZ?=
 =?utf-8?Q?H5fAIimSBOU/F9Npvw5rxi/gW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1060614-d83e-446c-d2bf-08dcf1aab4fd
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 08:31:06.4483
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wCysgB9dTE6kcQgM0droG26C2AEU71YdAOBQ/24RY8854Usr5pI1MinJLrKZix+WNH2N9H6uvVEu34sXijIjhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4364

On 10/10/24 03:38, Nicolin Chen wrote:
> Add a new iommufd_viommu FIXTURE and setup it up with a vIOMMU object.
> 
> Any new vIOMMU feature will be added as a TEST_F under that.
> 
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>   tools/testing/selftests/iommu/iommufd_utils.h | 28 +++++++
>   tools/testing/selftests/iommu/iommufd.c       | 84 +++++++++++++++++++
>   2 files changed, 112 insertions(+)
> 
> diff --git a/tools/testing/selftests/iommu/iommufd_utils.h b/tools/testing/selftests/iommu/iommufd_utils.h
> index 40f6f14ce136..307d097db9dd 100644
> --- a/tools/testing/selftests/iommu/iommufd_utils.h
> +++ b/tools/testing/selftests/iommu/iommufd_utils.h
> @@ -762,3 +762,31 @@ static int _test_cmd_trigger_iopf(int fd, __u32 device_id, __u32 fault_fd)
>   
>   #define test_cmd_trigger_iopf(device_id, fault_fd) \
>   	ASSERT_EQ(0, _test_cmd_trigger_iopf(self->fd, device_id, fault_fd))
> +
> +static int _test_cmd_viommu_alloc(int fd, __u32 device_id, __u32 hwpt_id,
> +				  __u32 type, __u32 flags, __u32 *viommu_id)
> +{
> +	struct iommu_viommu_alloc cmd = {
> +		.size = sizeof(cmd),
> +		.flags = flags,
> +		.type = type,
> +		.dev_id = device_id,
> +		.hwpt_id = hwpt_id,
> +	};
> +	int ret;
> +
> +	ret = ioctl(fd, IOMMU_VIOMMU_ALLOC, &cmd);
> +	if (ret)
> +		return ret;
> +	if (viommu_id)

"if" can be dropped as viommu_id is always non-null in this test. Thanks,


> +		*viommu_id = cmd.out_viommu_id;
> +	return 0;
> +}
> +
> +#define test_cmd_viommu_alloc(device_id, hwpt_id, type, viommu_id)        \
> +	ASSERT_EQ(0, _test_cmd_viommu_alloc(self->fd, device_id, hwpt_id, \
> +					    type, 0, viommu_id))
> +#define test_err_viommu_alloc(_errno, device_id, hwpt_id, type, viommu_id) \
> +	EXPECT_ERRNO(_errno, _test_cmd_viommu_alloc(self->fd, device_id,   \
> +						    hwpt_id, type, 0,      \
> +						    viommu_id))
> diff --git a/tools/testing/selftests/iommu/iommufd.c b/tools/testing/selftests/iommu/iommufd.c
> index 4927b9add5ad..c03705825576 100644
> --- a/tools/testing/selftests/iommu/iommufd.c
> +++ b/tools/testing/selftests/iommu/iommufd.c
> @@ -128,6 +128,7 @@ TEST_F(iommufd, cmd_length)
>   	TEST_LENGTH(iommu_ioas_unmap, IOMMU_IOAS_UNMAP, length);
>   	TEST_LENGTH(iommu_option, IOMMU_OPTION, val64);
>   	TEST_LENGTH(iommu_vfio_ioas, IOMMU_VFIO_IOAS, __reserved);
> +	TEST_LENGTH(iommu_viommu_alloc, IOMMU_VIOMMU_ALLOC, out_viommu_id);
>   #undef TEST_LENGTH
>   }
>   
> @@ -2386,4 +2387,87 @@ TEST_F(vfio_compat_mock_domain, huge_map)
>   	}
>   }
>   
> +FIXTURE(iommufd_viommu)
> +{
> +	int fd;
> +	uint32_t ioas_id;
> +	uint32_t stdev_id;
> +	uint32_t hwpt_id;
> +	uint32_t device_id;
> +	uint32_t viommu_id;
> +};
> +
> +FIXTURE_VARIANT(iommufd_viommu)
> +{
> +	unsigned int viommu;
> +	unsigned int viommu_type;
> +};
> +
> +FIXTURE_SETUP(iommufd_viommu)
> +{
> +	self->fd = open("/dev/iommu", O_RDWR);
> +	ASSERT_NE(-1, self->fd);
> +	test_ioctl_ioas_alloc(&self->ioas_id);
> +	test_ioctl_set_default_memory_limit();
> +
> +	if (variant->viommu) {
> +		test_cmd_mock_domain(self->ioas_id, &self->stdev_id, NULL,
> +				     &self->device_id);
> +
> +		/* Negative test -- invalid hwpt */
> +		test_err_viommu_alloc(ENOENT, self->device_id, self->hwpt_id,
> +				      variant->viommu_type, &self->viommu_id);
> +
> +		/* Negative test -- not a nesting parent hwpt */
> +		test_cmd_hwpt_alloc(self->device_id, self->ioas_id, 0,
> +				    &self->hwpt_id);
> +		test_err_viommu_alloc(EINVAL, self->device_id, self->hwpt_id,
> +				      variant->viommu_type, &self->viommu_id);
> +		test_ioctl_destroy(self->hwpt_id);
> +
> +		/* Allocate a nesting parent HWP */
> +		test_cmd_hwpt_alloc(self->device_id, self->ioas_id,
> +				    IOMMU_HWPT_ALLOC_NEST_PARENT,
> +				    &self->hwpt_id);
> +		/* Negative test -- unsupported viommu type */
> +		test_err_viommu_alloc(EOPNOTSUPP, self->device_id,
> +				      self->hwpt_id, 0xdead, &self->viommu_id);
> +		/* Allocate a default type of viommu */
> +		test_cmd_viommu_alloc(self->device_id, self->hwpt_id,
> +				      variant->viommu_type, &self->viommu_id);
> +	} else {
> +		test_err_viommu_alloc(ENOENT, self->device_id, self->hwpt_id,
> +				      variant->viommu_type, &self->viommu_id);
> +	}
> +}
> +
> +FIXTURE_TEARDOWN(iommufd_viommu)
> +{
> +	if (variant->viommu) {
> +		test_ioctl_destroy(self->viommu_id);
> +		test_ioctl_destroy(self->hwpt_id);
> +	}
> +	teardown_iommufd(self->fd, _metadata);
> +}
> +
> +FIXTURE_VARIANT_ADD(iommufd_viommu, no_viommu)
> +{
> +};
> +
> +FIXTURE_VARIANT_ADD(iommufd_viommu, viommu_default)
> +{
> +	.viommu = 1,
> +	.viommu_type = IOMMU_VIOMMU_TYPE_DEFAULT,
> +};
> +
> +FIXTURE_VARIANT_ADD(iommufd_viommu, mock_viommu)
> +{
> +	.viommu = 1,
> +	.viommu_type = IOMMU_VIOMMU_TYPE_SELFTEST,
> +};
> +
> +TEST_F(iommufd_viommu, viommu_auto_destroy)
> +{
> +}
> +
>   TEST_HARNESS_MAIN

-- 
Alexey


