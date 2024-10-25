Return-Path: <linux-kselftest+bounces-20612-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 771E19AFB8B
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Oct 2024 09:53:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3648A2837BD
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Oct 2024 07:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 811621B6CFE;
	Fri, 25 Oct 2024 07:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="itct4HNW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2072.outbound.protection.outlook.com [40.107.220.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 387D8165F01;
	Fri, 25 Oct 2024 07:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729842796; cv=fail; b=LqmXe1fyXLqUi8T/O+DB2ph69FN7GDQDZCVquvtsrhNP67yhXUJDkyzJCP7R++ONj0icrf1V3JC6SO83L2kepeq8PiW1ewW0JulLZnz/CHnVZYR9SWoRuvgGA2K2kYpyk8QoPvb6kTpdEvMcI5BbPQeaq7bMWWvH+B6ebbte8cQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729842796; c=relaxed/simple;
	bh=tTIdcvXKDZOV9tFuIg6l6liuhdyblISu/5nEOe1A130=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=h95MrNeEnnsSJykmDYFK9EG7SeKP5MDDIryi3hgAuBDeyedVAbuJqGNyRL4NkCVkWPpwEzi1RmUHy9q+dVj7DwxHYd0zK3EHvvAfmYFJeVEygFTTQrlG6sH7WYcYYKYmkCZ40kZld9U9eaAOiAffH1djpPAEPIJKPVk8RqQSJfo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=itct4HNW; arc=fail smtp.client-ip=40.107.220.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a91seHuizlKXFa2XxGuh7SG4M9K1jAtc8u8pcV30mC08ZTmVMZGxK/psu/E+pmWdimT/pPMjlbxQEQxfnPTRnVM7RddfwC9Ex+afdtlsN8zf1gt4vaf84RjmdmBdX3M4jHuDJo7KfH4/LQvuNMXkx6Q/5VBE2hIlqiHshPZKhChczU+5Cx9p4xBz7YYSGlLY+eWB16x1tYrz72mVVExkgxiHHfVZcQt2bcW3KOR8+fmrE021wdntErN3cbMS5PSrr9Qmz90wIG6iyiX+AJfNWPS/gx3IwZsVhYDgtJxbU6xY15JDZ2YyHh0ja87qdH9ZF9EopHQlEUG+uD2YsqwKXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PiTFlLIi1V56exFobAOFa/0PNBHV6DwVCYhg38i9L6o=;
 b=FS+1zeCE9ko5jsB8uysA1ViTY9zsiNRDEE7jYn9V4pLb3hgH9zWHhCF0vW3rg73CBD4ZxyTdbxXtL+h9s6gdQC57MNIdZLKZd8sw+4mxiTv6K0YaaM6Rk667OCtJCNDVVn60sruV/O/xhW2hi+46uGyxAimfcpmulMbi0nqDH+bMo2RxU+tvrgy13vHWLipYfZ8G7incOrYwt2rpxfCHHHjVuLArzUc7PQaoUtl9NfnlqWh7/QorHowYWyRm5Lp68rQbqdQ7Q4EFEuOZMsQruqlAb4l9G3zRpxWCv9Ho9hlwET0aR8f9kQ4b8sVflvSpqaxxn8b7O3XVktr3bkwTAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PiTFlLIi1V56exFobAOFa/0PNBHV6DwVCYhg38i9L6o=;
 b=itct4HNWr/3uwxwo25sIqb+XzBi53uVG8OIY1gVPoVRPFzHbMCtF+uFK0G8wNWaJVul8wW9nHvn54xru4ZHnm+UVSE0kBelbX7Ba/obY9lzw2qnc0Auy7tOSKYAVXn/Pvwyih6+/HSuj+gjLFCy8DazE3CigmQqUNWtEvzE2Lnk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9194.namprd12.prod.outlook.com (2603:10b6:610:19f::7)
 by MN6PR12MB8568.namprd12.prod.outlook.com (2603:10b6:208:471::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.21; Fri, 25 Oct
 2024 07:53:10 +0000
Received: from CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f]) by CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f%4]) with mapi id 15.20.8069.020; Fri, 25 Oct 2024
 07:53:10 +0000
Message-ID: <11dfc0b3-9e45-4f9b-a029-714105fda9c1@amd.com>
Date: Fri, 25 Oct 2024 18:53:01 +1100
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v4 01/14] iommufd/viommu: Introduce IOMMUFD_OBJ_VDEVICE
 and its related struct
Content-Language: en-US
To: Nicolin Chen <nicolinc@nvidia.com>, jgg@nvidia.com, kevin.tian@intel.com,
 will@kernel.org
Cc: joro@8bytes.org, suravee.suthikulpanit@amd.com, robin.murphy@arm.com,
 dwmw2@infradead.org, baolu.lu@linux.intel.com, shuah@kernel.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kselftest@vger.kernel.org,
 eric.auger@redhat.com, jean-philippe@linaro.org, mdf@kernel.org,
 mshavit@google.com, shameerali.kolothum.thodi@huawei.com,
 smostafa@google.com, yi.l.liu@intel.com, zhangfei.gao@linaro.org,
 patches@lists.linux.dev
References: <cover.1729555967.git.nicolinc@nvidia.com>
 <ec230c740b649bba1ca4d2ef054d90c79be4be28.1729555967.git.nicolinc@nvidia.com>
From: Alexey Kardashevskiy <aik@amd.com>
In-Reply-To: <ec230c740b649bba1ca4d2ef054d90c79be4be28.1729555967.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SY5P300CA0048.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:10:1fe::17) To CH3PR12MB9194.namprd12.prod.outlook.com
 (2603:10b6:610:19f::7)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9194:EE_|MN6PR12MB8568:EE_
X-MS-Office365-Filtering-Correlation-Id: 383870b0-4a6e-4e02-c530-08dcf4ca11f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Qml2NDJaQVd0NTVpVGU2TjlvWi8vYVM2OEpyUHpPNVo0cVN3TnQ5Rm9UVUdW?=
 =?utf-8?B?dUcyeitLQjRZNWxjY1h1QjlxNmpsTldqZnJIaE5IZG5pOHlBTmJaS1hQeEd3?=
 =?utf-8?B?RGF2TnU2MG1IT0kzWG1HemJqRjgyNjAwK1VERTVmMGxPL1lBc0tCTnAxSWpq?=
 =?utf-8?B?WVc0eDdvZGIrZEZtSUlpaFFIcTgwVGFHd3RLUkFOcDBTaDl4VTE5S0laZGJt?=
 =?utf-8?B?NXZrWUNmM1MxbEU0dklidkFiU09yNzZQTDJFcVFFbktmYVp2TklZT3UyeVBt?=
 =?utf-8?B?T1RFaURUM09TT2ZEbm1WWC9VOXpSUGQrMzZxdDZmVXFuQlhScnk2eEJHc2xy?=
 =?utf-8?B?bGhFZkxybE9qUktrM0l5YzV2dk03VU53d2ppUmNrdXFCZDdNUUZRc283V0Jw?=
 =?utf-8?B?Y2FiM2VNNHV2VTVXajdhRjI5dTdoRkQyTGRYU0l3dEhMRkZaT3diQlg1UDRr?=
 =?utf-8?B?S3Zic3VPcXBmNGtqL2UrcnFvUTBMY0tpRWYreFZrYXJXODZPVTR1SjFLNXgr?=
 =?utf-8?B?NUd6R2wydkNzU3hTWUdzM2J4cklnR293eEM1VGVxSVZJeWRzUlNQR3JsQWV3?=
 =?utf-8?B?Tm5JVW1tTmhwcnlVV2ZSRmphVDR2NDJNUk5HdXhuQW5IUmFpMDgyZGQzNnlR?=
 =?utf-8?B?dzZ0N01rdGtEblFlSFU5U21kdFpyQ0xhMDQ1VytzeWtzWGRIS2RkQVV5S2I4?=
 =?utf-8?B?UURlU0IxaC9PdUljUEg0eXBjNXZWOCszOGJRUnR3QXg5NmhPc1hneWNZRkJ1?=
 =?utf-8?B?MGUwZ1JjbTBHcGt6blhMY29DVVBoT1krM3FKeUhOMUhBS3h3M0hVbVIwMmov?=
 =?utf-8?B?MVhjN2lZU0FRbjNldldQUW9xMjlFeXVXanJTZVhlSDN1SmR1cEhBenV1R1cy?=
 =?utf-8?B?VXgrTW5QSzFTSEw5UEhrclI2aHk5cGM1cGI5cmZ4WG14VlZXeEpveG1LSlYx?=
 =?utf-8?B?SVQ2bUtDNTZZcmsxeU5aY3JhTUxJQVg4ZEJGZVF2WkdwMWVaSVNHUmliQlBh?=
 =?utf-8?B?TVNwY2FVWnBEclhuekdycDNwNXU4ejVLVEY2R2s4L3dOeFhrYm1JUTBzZTE5?=
 =?utf-8?B?WVpVWUNudnU4S1gweU02azlHY01CaVR2L3Uyd1l1d1VubEYxNTl1Nm14dVIw?=
 =?utf-8?B?d1owY2cyRHRmVWRZTytGSExFWHdIWlcwc2pMR0dkT2tRcHM0d2xsVStldjZY?=
 =?utf-8?B?cG1KMVlXZWhaV3VWUlhzb1JzL0JuVithbzlsVXN6cGJaS3FmRFJQcWUrRFkw?=
 =?utf-8?B?MEVmaUhYYkRpQzIyZitUNTR4VU1MQ0xDa3BSSTdMMkN3Z2xldnFzRTJpRFZS?=
 =?utf-8?B?UFFJeHNQOTJ0ZzdlYm5TSTlSeWcxN0JoSXpZZlhULzU4aCt5ZnAwT1B5MnZy?=
 =?utf-8?B?akVLS0c0UDU3cWJGV2ZJNTJPeDBGZHIzTDc0RkFLanFOaXBBeURGcGhmNjly?=
 =?utf-8?B?QkwwMjRRTVgxV1pBNkdoZStWZDdlUnZKbFNUZFJ5bjc1N1l3VW9FYXo0RDB1?=
 =?utf-8?B?SjdTMGdPOFZtWHN3MlBadzhxQVRaeUJHUjVDTkh5SklvOS80dXpvdXZ5dXlZ?=
 =?utf-8?B?ZGZNNzlVQ2d5WFVYbEdXT0tlaVJZSjVZT1pXTlNPVjFSSTlKcUhOaVQxYnEx?=
 =?utf-8?B?dDlCZmszU3BEUjJ6SE9iSkFQMDNnYmRnVnZlbEt5WnhrQk5HajBDMEJhalRW?=
 =?utf-8?B?UXhzNEhtcDErbUlPT1h0aU5rNm1sL3VIdHRLeXNmVi9TNmZiMXQ4eEFsbGpz?=
 =?utf-8?Q?JnMjjngBc0jEBB+9k8Z2lAnwA3NTxfBCDe3YPcF?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9194.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a2ZjRXNmSkpjK1paY1ZHN2tRenhpTG56VE94UExxOFNNa3kwTnpkQkp6UFBs?=
 =?utf-8?B?bGhGQWRoWndlTEFEdXY3QkVTVWl1bmhHa2hna0I3aUppRHVQYWFZbVZDR1B3?=
 =?utf-8?B?cFhIaVZBOEhwK012bWZOajVSNEx3SzJMWlpSWTcyTzBOVit3UnBIbFVIZUxu?=
 =?utf-8?B?cXBQNG5yVHRJZlJGSnM3WVpLSDhiY2R3SS9JV0Z1d3ZhNGpPRWlJWlJhd1JR?=
 =?utf-8?B?RThXOHNRT3ZvRmJoU3J3SHNnL25wUUtVMEpQc2ZObXh0dmtmWmw5N3hrRDR0?=
 =?utf-8?B?MVE0aTRnUnczaFJ6TEJvOU11eThiNllvTFMvTUtRMVE5OXpXaWRTZ0NicTdP?=
 =?utf-8?B?QmRhT3E1eHVkK2pVNXRsRVdWVWl4TGZ3cy9IMkpON3d2by9hVWQ5QkdQWEd6?=
 =?utf-8?B?ZVFaZkprWVUrNVhjQ2liVGdObUhjcDZuNENJaW85VFlqQ3V3dm1qY3lxdmVG?=
 =?utf-8?B?emlNR3lWbGs2Q2hWV2ovRU4zUE5YTGhGdDk3RHVpSnd3ZStWMFhOVzlaUTd4?=
 =?utf-8?B?VnRuVldmY1lUWnJsRTdoQkQ3bGVzdW05dndPeWVQTUhlSjRJN05mR3NqVDZr?=
 =?utf-8?B?SFJqT01tWW5hZkY2ZFpnK1h0OElYODQ1UHo2T2IxbVI1RHRCbDFzQlY5UW9W?=
 =?utf-8?B?UmVnbC9zM1pLdnozYzhtQXBmUkpYTFpKeWgrK21DbW0zNU5lU3FHeWs3R3JX?=
 =?utf-8?B?enBxSnB6ZDlXeHQvNDF2SGEwWXFWZVRqRGk5NFpzayt5bE12Q3J3dytoamY4?=
 =?utf-8?B?ajRESUo2aitCM1FacExseTZXSktBT3B6Z01kam8zZ3J2eGllYWpBOEFseFJy?=
 =?utf-8?B?Y1FJYmxZWURnTjlBU1lkemxhalI5bGpOcnhBZndUT3RaT1hBMVhMR1c3KzBF?=
 =?utf-8?B?UU01MjJweTUydDVqUU9OTkpHNXcraUdnS05yUlFFVWZ5VUQ0TWlBcVJDNnZ0?=
 =?utf-8?B?ekJROW0yMHRZK2xmTTBpWVJVQ0VkdDkvQkVFNkJtRnhDSEE4ZzFUZ05jRGtL?=
 =?utf-8?B?Y3A1ckFWaWVIWGNZSitOVGJPVHJQYzJUM21tRFo5WUhmTDlUek9kb3M3YldJ?=
 =?utf-8?B?ckR3OC9hTWY1WXhvN3hPNzBhODRIMm1RbjgyaWYyLzhzc0ppK2pjOXBYOXN1?=
 =?utf-8?B?THBBZU9MRUp6bEkrM01td0VRUzZWR0VHZ2FScEVoZmJuQURCYnBDK09iMGJN?=
 =?utf-8?B?V1FJZ3VsRVd5aFJFM3dNeVBXL3ZVbDRRQTRrUUZKbWJQMmlJVjFVOGpQMmRF?=
 =?utf-8?B?YVlJUEdxNUpvMEU2bG54L1dvcXRFT29SbWlSaHRsSmNrQ1dBN1lWZE8yUFlI?=
 =?utf-8?B?RzB0V0F2OUFaNHRSNzRXZHdLb042MkQrME9VdkFVQm9FMEMyU3FpTWVnWW9S?=
 =?utf-8?B?QXpBZnBRVitNdUx5M1Y5cGc1eldjTm40RWQwUUI1eExPWFF5azFIN3NwVDRB?=
 =?utf-8?B?MDVPV0hPUFEzYnE0OTd6a0tqdHh6ejRFamYxa0RLV2NVTjJ6cnM5Ty9MSWJ5?=
 =?utf-8?B?QU1oVys3cVB3ODlJMDUwaVNwRVRMRnBoSmFuanJ4NDFjcmd2UlNaaytoVjZY?=
 =?utf-8?B?Y1JQQTVpZGxmcU9nMTh2SnFBb1VGREovWHRMQ3h5dUhpZXVQTStERk9wdkpq?=
 =?utf-8?B?WlUyS0ZJT0ZrRDV2Vk83MjZkQy9PTTRMcHdNQzEzUWozVmJYUHVHRXhWbVRF?=
 =?utf-8?B?bXZ5VUZKc0JOTUJEb3N2ZjkzNm5LQmdxUWRPVldpYWRDZUp2R0xhOERkQ2p4?=
 =?utf-8?B?QmgvS0xOMjByb1BQQWJXajgvMW5WY3dQakIrRkt0UjFPN1BQZTVZaHV4ZGlP?=
 =?utf-8?B?cGZMVTRCOUYvOUtNaTc2ZUd2VW1DWmY0R2Z4NEZNRmhYU3VIZ0RMdDJkcTBV?=
 =?utf-8?B?aVlMRWx1N0ZGSktqWmNOSmdoUjYrN3JmTUVxTHMveG56U05SUkxXZ3dyRVla?=
 =?utf-8?B?TnJNM25rWnA3cnRWamdvK3BxVUo4cXRvSEZ5b05nMEFZKzJ2c0NXcTl0clZs?=
 =?utf-8?B?c1QxUkJrSm8yOXRjTnZmR2pKODdybGx1b3hEc2FsL0NmQ0p6TzdpWUs0ai8y?=
 =?utf-8?B?eTlUKzduSTd1cTJaOVdmTnhVam5KbXZCZ0hZUENmMXdCVXVYdEtRdzM1NS9r?=
 =?utf-8?Q?xt8IDloiU9ytj3oRAijAUIhJ8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 383870b0-4a6e-4e02-c530-08dcf4ca11f7
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 07:53:10.3887
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A1NINJuJapUG8Mp5DnUtMX9mUBDNwbIKt6EG8ufkqLcfd5vMQtFsRb8u78wL1GO3WQ4ErSqMAZqM4SV/bu+PjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8568



On 22/10/24 11:20, Nicolin Chen wrote:
> Introduce a new IOMMUFD_OBJ_VDEVICE to represent a physical device, i.e.
> iommufd_device (idev) object, against an iommufd_viommu (vIOMMU) object in
> the VM. This vDEVICE object (and its structure) holds all the information
> and attributes in a VM, regarding the device related to the vIOMMU.
> 
> As an initial patch, add a per-vIOMMU virtual ID. This can be:
>   - Virtual StreamID on a nested ARM SMMUv3, an index to a Stream Table
>   - Virtual DeviceID on a nested AMD IOMMU, an index to a Device Table
>   - Virtual ID on a nested Intel VT-D IOMMU, an index to a Context Table
> Potentially, this vDEVICE structure can hold some vData for Confidential
> Compute Architecture (CCA).
> 
> Add a pair of vdevice_alloc and vdevice_free in struct iommufd_viommu_ops
> to allow driver-level vDEVICE structure allocations.
> 
> Similar to iommufd_viommu_alloc, add an iommufd_vdevice_alloc helper, so
> IOMMU drivers can allocate core-embedded style structures.
> 
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>   include/linux/iommufd.h | 32 ++++++++++++++++++++++++++++++++
>   1 file changed, 32 insertions(+)
> 
> diff --git a/include/linux/iommufd.h b/include/linux/iommufd.h
> index 5c13c35952d8..5d61a1d2947a 100644
> --- a/include/linux/iommufd.h
> +++ b/include/linux/iommufd.h
> @@ -31,6 +31,7 @@ enum iommufd_object_type {
>   	IOMMUFD_OBJ_ACCESS,
>   	IOMMUFD_OBJ_FAULT,
>   	IOMMUFD_OBJ_VIOMMU,
> +	IOMMUFD_OBJ_VDEVICE,
>   #ifdef CONFIG_IOMMUFD_TEST
>   	IOMMUFD_OBJ_SELFTEST,
>   #endif
> @@ -92,6 +93,14 @@ struct iommufd_viommu {
>   	unsigned int type;
>   };
>   
> +struct iommufd_vdevice {
> +	struct iommufd_object obj;
> +	struct iommufd_ctx *ictx;
> +	struct iommufd_device *idev;
> +	struct iommufd_viommu *viommu;
> +	u64 id; /* per-vIOMMU virtual ID */
> +};
> +
>   /**
>    * struct iommufd_viommu_ops - vIOMMU specific operations
>    * @free: Free all driver-specific parts of an iommufd_viommu. The memory of the
> @@ -101,12 +110,24 @@ struct iommufd_viommu {
>    *                       must be defined in include/uapi/linux/iommufd.h.
>    *                       It must fully initialize the new iommu_domain before
>    *                       returning. Upon failure, ERR_PTR must be returned.
> + * @vdevice_alloc: Allocate a driver-managed iommufd_vdevice to init some driver
> + *                 specific structure or HW procedure. Note that the core-level
> + *                 structure is filled by the iommufd core after calling this op.
> + *                 It is suggested to call iommufd_vdevice_alloc() helper for
> + *                 a bundled allocation of the core and the driver structures,
> + *                 using the ictx pointer in the given @viommu.
> + * @vdevice_free: Free a driver-managed iommufd_vdevice to de-init its structure
> + *                or HW procedure. The memory of the vdevice will be free-ed by
> + *                iommufd core.
>    */
>   struct iommufd_viommu_ops {
>   	void (*free)(struct iommufd_viommu *viommu);
>   	struct iommu_domain *(*domain_alloc_nested)(
>   		struct iommufd_viommu *viommu,
>   		const struct iommu_user_data *user_data);
> +	struct iommufd_vdevice *(*vdevice_alloc)(struct iommufd_viommu *viommu,
> +						 struct device *dev, u64 id);
> +	void (*vdevice_free)(struct iommufd_vdevice *vdev);
>   };
>   
>   #if IS_ENABLED(CONFIG_IOMMUFD)
> @@ -200,4 +221,15 @@ _iommufd_object_alloc(struct iommufd_ctx *ictx, size_t size,
>   			ret->member.ops = viommu_ops;                          \
>   		ret;                                                           \
>   	})
> +#define iommufd_vdevice_alloc(ictx, drv_struct, member)                        \
> +	({                                                                     \
> +		static_assert(                                                 \
> +			__same_type(struct iommufd_vdevice,                    \
> +				    ((struct drv_struct *)NULL)->member));     \
> +		static_assert(offsetof(struct drv_struct, member.obj) == 0);   \
> +		container_of(_iommufd_object_alloc(ictx,                       \
> +						   sizeof(struct drv_struct),  \
> +						   IOMMUFD_OBJ_VDEVICE),       \
> +			     struct drv_struct, member.obj);                   \
> +	})
>   #endif

A nit: it hurts eyes to read:

mock_vdev = iommufd_vdevice_alloc(viommu->ictx, mock_vdevice, core);

vs.

mock_vdev = iommufd_vdevice_alloc(viommu->ictx, struct mock_vdevice, core);

as for the former I go searching for a "mock_vdevice" variable and for 
the latter it is clear it is 1) a macro 2) which does some type checking.

also, it makes it impossible to pass things like typeof(..) or a type 
from typedef. Thanks,


-- 
Alexey


