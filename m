Return-Path: <linux-kselftest+bounces-36676-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7446DAFAE3D
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Jul 2025 10:09:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B6B01AA2127
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Jul 2025 08:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C73328CF6C;
	Mon,  7 Jul 2025 08:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="EgQinWD6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2070.outbound.protection.outlook.com [40.107.220.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D39625B1EA;
	Mon,  7 Jul 2025 08:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751875553; cv=fail; b=JnkamLBjzg/uodGfvJkiYZr7my2Hv5wGVINlbz19MRBqZmnJCrDP5gBKtTnlu7KAE1ojYcYunmtHLZ/7s+gyRcJ3nEYmO1D+gps0/qJbQwmn4K59r684icXpo0gS6Ym4cB29qQh+dR20TufU5kQUW9N4hdyuAu6JIx/21ofHpc4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751875553; c=relaxed/simple;
	bh=XEcOmmo9pBkWh2/JAtJCEUMQC9S10X2b1XMMBzQP1Us=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=c8Lpj8q5tngPetJJFIi6HTwdEPcAWHuvVYuJCVjAzeeO5Ij0bxJ4JKgyimWxw5yqAtZmWq1kNR7IbbxrrdeKBoV/L99gNpsnbjpSXxQ1w08DMZGPcGc6Q7pWUuVBMZo3zZUJU34d+/TzSfEBJ1gfbIWB0bd3XTb0E0MuVPtcHM4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=EgQinWD6; arc=fail smtp.client-ip=40.107.220.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=crQFpO2jTv2t/l9eGxl44z9M9mxj/gkA5LyW6GHkkWt8ijB0JW0hKTxQRpAuJFzL4qcPFMwNazYTnsM7Q5AsVlJtbH9gQnGY9Ewm6s12ujg+FCZ+55z2ngXN15GcqiOZyQ9T5vNL7YuK2chmJai7yUMdRXfFvVzKDlVS/zi61sHQqhoy39A6nAhz5aMsLvmemJMRa7oFyxZE2MNeM0EjxTy4GnYz3nesaoZAuv9bqPMDFzlUThWGjrwWOBUdC0Z3LMeOzqmlY3CQnf1eukj6M8cd3xiGB6Rv7vk94mOFHVnmN+N8Fdpay4OYzVyaXlCqaagiep4NQq9dMtgO328vLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CPMQX8GiXS+FvfgXq9abnQpEvvRYff7XlKMI62rxLhk=;
 b=Upg9oUPFsiQfHE6awAGSiYUgHsarvwJ5r7NBisbfE2vUmnCkvTjEffr/LeaDv5Z4V+eBO2/B2OmvbUDmEe6N0GunqhMdWJX/B7LRRSlHwWJ5aKArYpuwU45EEaA2EPxKp4PMt3AA3e1V01DAgXim9ulvoUJAUHs8W4aXHLTczqxUAdo+kuRqr8XX5t1lHD2JWb9XlOYaXqdHPx55M60V4rg4a/GJJHXc9lWHfr/hLEOdAjBZ2Y10jswUNZrtWxvVT0YU6DrON2JJkrwMavL/ool/5yb8O1OBzVHK2f7a9I7GBSgP0GUwtPPj/lvJxISFdvV0ELj9u8U+kZsCE8Z8PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CPMQX8GiXS+FvfgXq9abnQpEvvRYff7XlKMI62rxLhk=;
 b=EgQinWD6NW/ks1HHdFDNK+ASJf6jkaGtdqN+IIpG+dOErdjCaXpKP4D+mRv34b4JcPlHd+z23QxTyKAzulV4LGBisgsts1jB9iIei82K/Agb0+C/wlWxfp5xE14frK441ug+6ZNctF0o2F/rdYdXJrNWDTZk6oc33vJwJ2QBtK0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 SA1PR12MB7442.namprd12.prod.outlook.com (2603:10b6:806:2b5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.24; Mon, 7 Jul
 2025 08:05:49 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5%5]) with mapi id 15.20.8901.018; Mon, 7 Jul 2025
 08:05:49 +0000
Message-ID: <59e75872-5fa3-4062-86a3-1fa8294cebe3@amd.com>
Date: Mon, 7 Jul 2025 13:35:36 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 06/29] iommu: Pass in a driver-level user data
 structure to viommu_init op
To: Nicolin Chen <nicolinc@nvidia.com>, jgg@nvidia.com, kevin.tian@intel.com,
 corbet@lwn.net, will@kernel.org
Cc: bagasdotme@gmail.com, robin.murphy@arm.com, joro@8bytes.org,
 thierry.reding@gmail.com, vdumpa@nvidia.com, jonathanh@nvidia.com,
 shuah@kernel.org, jsnitsel@redhat.com, nathan@kernel.org,
 peterz@infradead.org, yi.l.liu@intel.com, mshavit@google.com,
 praan@google.com, zhangzekun11@huawei.com, iommu@lists.linux.dev,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
 linux-kselftest@vger.kernel.org, patches@lists.linux.dev, mochs@nvidia.com,
 alok.a.tiwari@oracle.com, dwmw2@infradead.org, baolu.lu@linux.intel.com
References: <cover.1751677708.git.nicolinc@nvidia.com>
 <e34fe51299545789f7e97f193969a2688e708eef.1751677708.git.nicolinc@nvidia.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <e34fe51299545789f7e97f193969a2688e708eef.1751677708.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0082.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:23::27) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|SA1PR12MB7442:EE_
X-MS-Office365-Filtering-Correlation-Id: 52531f9a-ca5b-4bce-ef99-08ddbd2d156e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ckJOT3hjbk5IMVNRbHhTOURjY2lhTHkrNHZSM2thK0plVWZtakFkRk5DalNJ?=
 =?utf-8?B?UERjeitkb0lyZEo5Vm8xSWVxT0hNa0JqOXUweG8xRnNjdTRwR00vWEdrQWdy?=
 =?utf-8?B?T1pObTZNOWtVcEY3MGRFSGU0elNldmI1Y0J6Wm1wZ3ZDZ1VEcDFGeDd4MjRM?=
 =?utf-8?B?aUZWNjFVRjZZVVA5UzVTc3RpNzVGNHdicnAxeVpGQ2wyWk92WktxK2haNUVX?=
 =?utf-8?B?QTZrWVoyOTkwQUhNbm9MSTNmQUc3TWM2bGc5b2g2b3ovbDJ6NlVhWTNIZ3JW?=
 =?utf-8?B?TWZ2M2JIOEJJMlZ4djJnQVFwKzJua0RSRmM5REhyY2t6SFJLb3llY0dveHY4?=
 =?utf-8?B?R2xyWHFyMVh6MVpWNU5YQUczUHNsZkVvMC9vQVRydTkvVlRIY1h5a2YxOWJs?=
 =?utf-8?B?dGZhZ2Uyb3RQS1JBbEZrL2RaYUxYcU9OcjdXc0ZwbUJiSmVzVlVTRzM4d1hM?=
 =?utf-8?B?UUw5Y2VXYXZ1bkFNYjJEUW1OVll3TDljSVZLeGhvTUxoTktXSU1tZTgvclI4?=
 =?utf-8?B?NUZGaWVjZW9wSExDV2ErYnlYQTR6c2xCSHVHVnVZdmxEdzFaZzdHaGx3eG5i?=
 =?utf-8?B?NFJqTiszNDVyME9lMWgxYzdFamFBSE1zVW4wek9MOWZxTEczZVQrT3FPL0FV?=
 =?utf-8?B?aXlGaDhFZWNZTFdiSmpaT2NVK1N5dkdmeTNHUWJiMGIwVDdEOVg5b1U5SE1i?=
 =?utf-8?B?NGU0V1VyYk9SdlZuMDdCMkFFMU1SS2dOK0UwVyswRmorSFhxMWdsT3RESngx?=
 =?utf-8?B?YlE0T0E4RHo4aGlxSlErRDJTc3piMkRSM2xMdlBnNlhiWnZQYzk4ZFM0NUdp?=
 =?utf-8?B?OEdRQ3pJTVQyQWEyL1N1UEV0cjRka1gxM2F6TnpacEJtRjAxRWJvd2FaZVFz?=
 =?utf-8?B?UWxPTDlxT3R3cVluNTkyelhvcXplazRCQ3M2VE4wV1l6RGd6S1E1T0pUek42?=
 =?utf-8?B?QjFMWUQ4VWExTmlLMnF5TS96Y1FtQlJwYzF0WktEWFpoVWVNYU9Ja2taS1Rt?=
 =?utf-8?B?M3BvMmtza3hjMFkzczRCeUk4Q0Jub25vZ2V5eUgrNzVWK3NhMFFSTmVZTzBz?=
 =?utf-8?B?c1VsYlArZlBlWGFuYzlJb0FDUWY0WlF3Y29rZ3lIbjVPc1lIOU9ubCszeVV4?=
 =?utf-8?B?UnNSRHJMdWlRaCsvdWVoRUU1NHVzSHJjTGdlczBGaFVtUERCOGp1dWdNa2RE?=
 =?utf-8?B?YWhSM2h0bldWZnRDRlRWbDc3UUowRUFsRU01TDFETFA2QjdnQmlkUG1pblV6?=
 =?utf-8?B?dU5LVldxYlpYMmpDZjI0T3pNOVVMNEt0M0R1L1YvMk9sNVRvNUxBZGdKVW14?=
 =?utf-8?B?VVpWUktpWVdxTTFONEVPSnhhTjcyTkM4OEhESWdXRFNSWm9iSkc5ZGU0SEJP?=
 =?utf-8?B?YjVBZ080RzRMa2ttdWhzaFphUnQ5OTM0VGVuSFZ1a3hNZzVmZWozS0xvcVhw?=
 =?utf-8?B?Um5HdHJVVFVCczEvOWJKdFdDelkzbFZOZ0NoL2pGZ1NtcmI2aU9RSmpYcFFv?=
 =?utf-8?B?TEhJTWkwTk1vbkEvSFJZdDNRdStYa2VYbnNldWF2TnltYitTTlpmazdZU3ZO?=
 =?utf-8?B?SzZSR3p1TDZDaFNVUTNkckZ1WVB2bFc4UmJmdzBJMGZiMk1LY2s3OG1iOTY0?=
 =?utf-8?B?UnR6YUtKVC94K0YwS0N0cVdjeG03SnprQlB2KzhWcmxGYW9JOWc3NE5xMlZs?=
 =?utf-8?B?cy9IWHU1RUs0ci96ODF5eldPVEtodGVpdnc2SmVaK3RtYUd2UzFETHZSZW80?=
 =?utf-8?B?YytJY0VndHJWaUtyVTFSbWMrNE8vMEhuT1UxaVY1SkFOMCtKYXErdkIrcFRJ?=
 =?utf-8?B?TlJBUXhaNnFuN1RDY3JDUFphNlY0bUdIQUxUd2NpOHhIeFJUY1VvbmxmbDQ0?=
 =?utf-8?B?ellBK2Job3ZFSzRsMWthWmE0cDNyanJLczRWcitkOTVadTFWbTJHWERHUlZM?=
 =?utf-8?Q?SNKbw5K0SSc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T1d4SjhHcWE1UGpnOUVSM29vTWdaMld4UWwrM3JpUnVUM3kzd1JETVhKRVFp?=
 =?utf-8?B?V1EvdStPbVpoa085V0dwMFpnUDdFSW01NDNuRVFTY2luak0rUVpJcTRMSzF4?=
 =?utf-8?B?RUJtNFhsTXFqamtPZDU1VWk5blhYdWREN2dNT1hPVmlQc3UrWWtINVRWQllK?=
 =?utf-8?B?WVAwYll4bHBPbE1LZ0tmU2JnNFNlYk9uZS96OXdHcHV1Tm54eEkzcnRCM3l1?=
 =?utf-8?B?eVUrejEzbGFSdTJqTDlLelFPZ0paWjI2UXZoaEVuL2FJeEUxUWdnVHdsUU1k?=
 =?utf-8?B?VnBKSWVQYUFGQ01zVWRudEEwbGU4VFZSUmo4OGtQRXAwdlRiSTJ2MUVJUE1j?=
 =?utf-8?B?TjZOZUdrTjdxTTc1NGVPNUdmTjNuRjZJaGwwcHVaRGsxckN4OC9MYmlKaktS?=
 =?utf-8?B?elQ0VUM2ZncwSithQ1FrVERWZTk0ZlYzanlDZTVndERQN3hXR3ZKSUZoQ2dk?=
 =?utf-8?B?anFwMHJXOFhGQ3EzRzlGZ2lsMTNScUxtTU5xaENOMWE1TEduU1NVemFGYWJ3?=
 =?utf-8?B?eVhtZmtIcmgzaS9NU2JTVGZKS0ZVbnNIbkNnZHBRM2phRFdNN0xDaVhwR0tC?=
 =?utf-8?B?bFVrWHkzSUpSN2tNUktWckV1bFZoekovMTlsRFFSdTdna2V3OWx1YTVDalls?=
 =?utf-8?B?Q204L0pjOWpHbExhR2pzRTM3UEVEaEY2dCtlTCtOd2IrM08wWTU5YzVWNXQx?=
 =?utf-8?B?RlExaXhsVlZSNGRJWXI1SGJUUlFoaGZVeHFZdC9CZ1k3V0duM1B6eCs0NERi?=
 =?utf-8?B?UWsreUFRT1FTd1l6eHlOS1llUHRLd1N2ZWhPak5ucDZWZGx2d3pwUTNXSVQy?=
 =?utf-8?B?UkxNdUVlK2YzcGtBdEJZOTA3S2Z3OW5tZDZoVWdMZGZOaFliQm8rV2FSZTRD?=
 =?utf-8?B?clRxaGcwT1JWbkllYXNRdStOdmNwODZVTGxaRW5hTGJrbFhGYy9yczlvWGU4?=
 =?utf-8?B?L2w2OEV1ZjI5Q2FOcVk1b2VqVjQybjVTZk5YU0doS3dGVUd2R2hkWFRtRzNm?=
 =?utf-8?B?NXpPWG1QeVZiWmtLL3RybThnSUlmbCtLdGdhdWs3TDl2ZVZIbFJvaTBVb1Vl?=
 =?utf-8?B?UUJJUWRrRTF0OGZpZkljVE8wRGEya0x2SVlFbVFwM29YR1AxVUtFR0d3b2pR?=
 =?utf-8?B?b0VvSkJ6WTByQytuN0NtUWFCcloyYXlCNWdad1RFc09KNloyNEZLUGhFVXFP?=
 =?utf-8?B?WUN3cFdRUGN5RkthT0U5RWVTbWxKTUFtVmJFM0ZaSTM0bWUxM1RpWDNseFA1?=
 =?utf-8?B?Ynk0YjJmVGZ0anI1WjRNTjEySXNPMzUvOHcxbHh0OFZUMGh4NDlZRU5QUXlh?=
 =?utf-8?B?ZnprTGJnMjJMVXVINXJlWVZVL05aNWtiazRyaUhIZDIybEJVejkwMUxpekx1?=
 =?utf-8?B?Mk1qcDc2MlhCOGhsdVMvalBUSEcvYTB1K2xvODQ5TkhKZ1FtZDlIbW4zbXVU?=
 =?utf-8?B?K01UcTltdkl4a3JtQjFVSDJsY2RHMXR1T3VRWTNYdEUyQ2xzQTNDMHhvbmtQ?=
 =?utf-8?B?MERQTFd1YXpPQks1Z2xiMXI0UjdRb2diQW1SV0ZERURCd3R1U3VZTCtnTzl0?=
 =?utf-8?B?VVl5VzRCRkZqWXlMTUVoUGJOOXRoaFNoOGxFS0pqSkRPZ2Rya1ZqZFF3aW42?=
 =?utf-8?B?SUlLQlVTZ21VOVBGYmNGTHZ5NEx6MXRCRG0wU2R6bVI0TSsvclZOOVlaL1ZT?=
 =?utf-8?B?Z3lrWUZlVHgvZGlYdjBzV00wQ0thdXBKR054UGZ2TXJXeXl2QkFFTzhoOGhJ?=
 =?utf-8?B?TVZxOG9kNnp0UW54bGtvakZDNWVLd2IzUjZzaVNTazNoVEpoTmIzWXgrMldF?=
 =?utf-8?B?WWZ5R01iRzIyK0xTUmtWeEV6dWVyZzhiYlNoOWZOUEFFeS9UVXA2N1dqbkxj?=
 =?utf-8?B?VVhkZ1poNU5VSVh5UEVyVndIdk5mdjMxUlVkS3VyUzYxekNzWGJzVUZqdGlT?=
 =?utf-8?B?NDZzWXZFWEJlNzdyRVlwUXJxL25kSXEzL2FnWkZqS29XWlVNUU5hNndkalNW?=
 =?utf-8?B?NFlySGprSUozUDRDNXJwa2kyV1QwTmtRTWVwR1ovWUZ6aUVVUllkaHNja2NK?=
 =?utf-8?B?cmFxaWFSSHJWalNMTWRTVUV0YkZYeFp3ejgvZEx0V3k5SW5nV0tMSzNWb3d2?=
 =?utf-8?Q?QN2zF1kGD8+BlSVQV/57Zldbz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52531f9a-ca5b-4bce-ef99-08ddbd2d156e
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2025 08:05:49.0949
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hRB3p9vA9m8qEuX3Yfa4jiP0r4p81p4N1AecNPfb5mYKVJRlcQw0AGw2+dx/h1fg9s9kIyI9keXik8Zq1pd9ag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7442



On 7/5/2025 6:43 AM, Nicolin Chen wrote:
> The new type of vIOMMU for tegra241-cmdqv allows user space VM to use one
> of its virtual command queue HW resources exclusively. This requires user
> space to mmap the corresponding MMIO page from kernel space for direct HW
> control.
> 
> To forward the mmap info (offset and length), iommufd should add a driver
> specific data structure to the IOMMUFD_CMD_VIOMMU_ALLOC ioctl, for driver
> to output the info during the vIOMMU initialization back to user space.
> 
> Similar to the existing ioctls and their IOMMU handlers, add a user_data
> to viommu_init op to bridge between iommufd and drivers.

This is useful for AMD driver as well. We can allocate/configure guest specific
things including MMIO page.

> 
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
> Reviewed-by: Pranjal Shrivastava <praan@google.com>
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>

-Vasant

> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h         | 3 ++-
>  include/linux/iommu.h                               | 3 ++-
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c | 3 ++-
>  drivers/iommu/iommufd/selftest.c                    | 3 ++-
>  drivers/iommu/iommufd/viommu.c                      | 2 +-
>  5 files changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> index bb39af84e6b0..7eed5c8c72dd 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> @@ -1037,7 +1037,8 @@ void *arm_smmu_hw_info(struct device *dev, u32 *length, u32 *type);
>  size_t arm_smmu_get_viommu_size(struct device *dev,
>  				enum iommu_viommu_type viommu_type);
>  int arm_vsmmu_init(struct iommufd_viommu *viommu,
> -		   struct iommu_domain *parent_domain);
> +		   struct iommu_domain *parent_domain,
> +		   const struct iommu_user_data *user_data);
>  int arm_smmu_attach_prepare_vmaster(struct arm_smmu_attach_state *state,
>  				    struct arm_smmu_nested_domain *nested_domain);
>  void arm_smmu_attach_commit_vmaster(struct arm_smmu_attach_state *state);
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index fd7319706684..e06a0fbe4bc7 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -700,7 +700,8 @@ struct iommu_ops {
>  	size_t (*get_viommu_size)(struct device *dev,
>  				  enum iommu_viommu_type viommu_type);
>  	int (*viommu_init)(struct iommufd_viommu *viommu,
> -			   struct iommu_domain *parent_domain);
> +			   struct iommu_domain *parent_domain,
> +			   const struct iommu_user_data *user_data);
>  
>  	const struct iommu_domain_ops *default_domain_ops;
>  	unsigned long pgsize_bitmap;
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
> index 69bbe39e28de..170d69162848 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
> @@ -419,7 +419,8 @@ size_t arm_smmu_get_viommu_size(struct device *dev,
>  }
>  
>  int arm_vsmmu_init(struct iommufd_viommu *viommu,
> -		   struct iommu_domain *parent_domain)
> +		   struct iommu_domain *parent_domain,
> +		   const struct iommu_user_data *user_data)
>  {
>  	struct arm_vsmmu *vsmmu = container_of(viommu, struct arm_vsmmu, core);
>  	struct arm_smmu_device *smmu =
> diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
> index 7a9abe3f47d5..0d896a89ace7 100644
> --- a/drivers/iommu/iommufd/selftest.c
> +++ b/drivers/iommu/iommufd/selftest.c
> @@ -779,7 +779,8 @@ static size_t mock_get_viommu_size(struct device *dev,
>  }
>  
>  static int mock_viommu_init(struct iommufd_viommu *viommu,
> -			    struct iommu_domain *parent_domain)
> +			    struct iommu_domain *parent_domain,
> +			    const struct iommu_user_data *user_data)
>  {
>  	struct mock_iommu_device *mock_iommu = container_of(
>  		viommu->iommu_dev, struct mock_iommu_device, iommu_dev);
> diff --git a/drivers/iommu/iommufd/viommu.c b/drivers/iommu/iommufd/viommu.c
> index bc8796e6684e..2009a421efae 100644
> --- a/drivers/iommu/iommufd/viommu.c
> +++ b/drivers/iommu/iommufd/viommu.c
> @@ -84,7 +84,7 @@ int iommufd_viommu_alloc_ioctl(struct iommufd_ucmd *ucmd)
>  	 */
>  	viommu->iommu_dev = __iommu_get_iommu_dev(idev->dev);
>  
> -	rc = ops->viommu_init(viommu, hwpt_paging->common.domain);
> +	rc = ops->viommu_init(viommu, hwpt_paging->common.domain, NULL);
>  	if (rc)
>  		goto out_put_hwpt;
>  


