Return-Path: <linux-kselftest+bounces-20606-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9290E9AF928
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Oct 2024 07:32:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18CD21F22BA6
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Oct 2024 05:32:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B96195FEE6;
	Fri, 25 Oct 2024 05:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="d50doqyc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2081.outbound.protection.outlook.com [40.107.95.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6990733EA;
	Fri, 25 Oct 2024 05:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729834347; cv=fail; b=enAdFREuPsw9H4P9bGHhKe9t1VE035se4P3F4J8SZmKTe6Yl7s+8M7yr13tsbMDngur73K7KqqUGJtRASFgBwMMufaWhZoeHQvU15eNJVKazZGHG4K8Kn+0+WFz+1G42nokVSzpN0kw7t1eftWa40lBZXZidlPjnw/BOCQVWCLQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729834347; c=relaxed/simple;
	bh=3sWGM1QynIPJQ4TMiV1TTXPre0fRj2glLCe5BRvLEZc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DGImXEdReA5xsiRNZTzdLizJBxStiUWi63fPFGn+J7qiwwgND+px4wLIVciflvzSo5OUGYWZNPL26t1b5EmUExW1uptTlMLibOZaBF91GBt8sl8aJJkcBuW5yBo6qCxYTWEos1U8U9OM/9UJo7KSEd0KEjpTQJ7xozYMkS2iegg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=d50doqyc; arc=fail smtp.client-ip=40.107.95.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wFX8hFiUA9YHIjUlAg3ZPzi8CyJ9xVW6hbiCI3EhUZxH/LF9VDd0UiT0QRHAQTSd/jvJ9DYePEHzxON1znTPdoqYT14kGBPc5VHKF88vuluz32holOq/k4exjzwJbtlsym039hT0k4xDS8YE9ofBPZzbfKEHlLw1ENAeZht523HO9BUvgNlvaoCFL0Xf3jfgNXZqfNBfATmkQEK6HKdkCB8bT/zWvTDkYQjTTk3j3uBb/bPgKaTmu2pr8swVLDjioV0KYEsu+w+qEqKvqCZFJoJC3NZJZ5LbC69AAuk9tPGCJRMfc3fr5rOVK/AyezOcU0aFmrMYwjN6t3U9nvhlmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=epVb+a66Bp/vfi1Z/ssbD1nhMl8dhFw62NHV/H9olB4=;
 b=YAxAcojEdGBgpvUNOYg6tfhLJgdNzVGBC72MxF7tt4SuLWQjQbsO/bRhdT0sxDymOIqbaK5INXKPdwvYvEVdNEtMOH/P7CgGmb9vMPCPm+6IhaT86uaE9yf1Sj5i/vauJKdKf77JY+7MVpKpOunHIS8rsWN61+uYXKfxYZUFfbdo8b7C8oVQ9/5itQh825VRctM/Jy5qGsc2DVEv3Tg+fhn6lV1WNC+z7p5rwWFvyBw3jtdReyAzsiJdnAkf6f7FvC9NEr2Od+OLx0PqIRIOXsMbp0peNLuHEe60L//XvTq53Xrs+oN7MLtvQBQKWXj8uM+1MbbiehG5SzYVkNKMtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=epVb+a66Bp/vfi1Z/ssbD1nhMl8dhFw62NHV/H9olB4=;
 b=d50doqycZrhu1Zt56z5EcQytA9zH8p8SgUafWuuOcGVLEZ7oBvh80kDbeIEUdEk/qZcq5lhUiEW4gSIokv2Fb7u29t1+avAH3aur+r1AbkT84P6NHTxWoUdd9oq0yOv1HAKaf/+nKOWAVUNk6I/zxWggTDf74ULg/mmRl6q5wDY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9194.namprd12.prod.outlook.com (2603:10b6:610:19f::7)
 by SA1PR12MB6969.namprd12.prod.outlook.com (2603:10b6:806:24c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16; Fri, 25 Oct
 2024 05:32:22 +0000
Received: from CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f]) by CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f%4]) with mapi id 15.20.8069.020; Fri, 25 Oct 2024
 05:32:20 +0000
Message-ID: <487ebe2c-718f-405c-8f20-213eab59ca0f@amd.com>
Date: Fri, 25 Oct 2024 16:32:10 +1100
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v4 00/14] iommufd: Add vIOMMU infrastructure (Part-2:
 vDEVICE)
Content-Language: en-US
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: jgg@nvidia.com, kevin.tian@intel.com, will@kernel.org, joro@8bytes.org,
 suravee.suthikulpanit@amd.com, robin.murphy@arm.com, dwmw2@infradead.org,
 baolu.lu@linux.intel.com, shuah@kernel.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-kselftest@vger.kernel.org, eric.auger@redhat.com,
 jean-philippe@linaro.org, mdf@kernel.org, mshavit@google.com,
 shameerali.kolothum.thodi@huawei.com, smostafa@google.com,
 yi.l.liu@intel.com, zhangfei.gao@linaro.org, patches@lists.linux.dev
References: <cover.1729555967.git.nicolinc@nvidia.com>
 <98a0e135-4f9b-4a2e-94b5-f1a830a49f19@amd.com>
 <ZxslrakslZbphayO@Asurada-Nvidia>
From: Alexey Kardashevskiy <aik@amd.com>
In-Reply-To: <ZxslrakslZbphayO@Asurada-Nvidia>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SY5P282CA0066.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:203::11) To CH3PR12MB9194.namprd12.prod.outlook.com
 (2603:10b6:610:19f::7)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9194:EE_|SA1PR12MB6969:EE_
X-MS-Office365-Filtering-Correlation-Id: 067c26c5-74da-4217-a684-08dcf4b66515
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NVR3dmNYeWVBNU15SHpZQm5sZFZ2YTR4TlZhdnR3eVlnN1hTOFFVSDhGOUc0?=
 =?utf-8?B?MTVXSnFvYTRVaVUvVXVHMzY3Ump1OUo1c1VGQ09INFFqbklNKy9JMGFBa2JT?=
 =?utf-8?B?K2wxU2p3YmloOWNCejYyb2J5WWRaRmtEdVpDdHVXVTFhZlpvbEVhOTNTMUZV?=
 =?utf-8?B?TUQybVVHdDMwK3Jia1JxeXh2ZC91Mi9MbmN6K210aUE3ZFpNdHBjYlpPczVm?=
 =?utf-8?B?UiszaGtXRUJIYURIMkkycG5PUGxNeWI0MUxRVmZRT1VkYTRuWWRvdkhwTHRm?=
 =?utf-8?B?VTFVRzB5TmVGQWFRWklXWHI2V3ZVY0JvZTJLUFhGalJyMmNDVUFnMzN3QUVj?=
 =?utf-8?B?ZWhIRkp3aXB3WW9Wdjk5MXVVTXk4aEJHV0UvK2M4cFFGRHh2SEdxenozRzZk?=
 =?utf-8?B?MWtpQ2FBVXU0YXc0aG1BOGhkeCs1dTRFQXRWSjlHUElwQ3BRTnJLNkxUMjlj?=
 =?utf-8?B?RUVwUFRQN1RobytIdHZqZEt6VnhmWFpVRkdCWFlwazNVTmlLS3I0Z1cyY1B5?=
 =?utf-8?B?NTIvQy9EWHpkZjRDd2oxb1JYbTBRK3dXWEtKZDRVMjlzeG9lVFUwekhzbEtx?=
 =?utf-8?B?dlFYT2x3VU1ZcndMc1NCaDF4UkFmaXlWbmtJY050V3djbXMrVTdWNHdwak1W?=
 =?utf-8?B?ZElUbFdJUFIvVWdtYW5pdmZFWDZVbEJXbi9zOUV1dG5EbTM4dkxacmx1U0Na?=
 =?utf-8?B?WUh3NzBpRTlTN2J6ZnZSMDJSWUU5UGFLQVMyb0Y3bStHNHBQUEM2N2lSUVc0?=
 =?utf-8?B?TXVmQjFNWGhjNHphbitPL0FmdksrbUFoYjVCcldQdnRNVnNtVWlUaUNVak5w?=
 =?utf-8?B?V1VFR0lxOUtTSUtaS0ovSWhOUVhSa1Z4ZWRndGJ3TmNjeEMvM0dQbUZyQXB1?=
 =?utf-8?B?Q1BDOTJTVDNCYmJ4OGFoOTRKN0xsc053M3p0a1o3b2padUgxUU8vYUlqTzRq?=
 =?utf-8?B?d0ZYVXBSRXJkSUVSZTlQRkZVWW5QSVFsRWpTSlZOY1VEbnhrTW5nY0t0Ym54?=
 =?utf-8?B?VjN2MGNXK2F0T2hyYnlIV2FwNDNDaFJqd2duNlJIRkxpWjZLNzVrSnl1TFZm?=
 =?utf-8?B?cTh4ejZVUU9aejc0MllVb0xrR0xjREUyTnA1QTZzOVBXcWwyMlgvME5LQ1dr?=
 =?utf-8?B?bnZnZUh2OTkxamQ2cUxhKzBRSklXdklaUzJzNUtoVVdKSkFpODNHTE05STk0?=
 =?utf-8?B?eHdkeUlpVkVZL3JqNTZiaXQyWm5qdHdGaFlDMmJCenVmbEduWEVwb2EvelI5?=
 =?utf-8?B?cHJ5SnN1ckZyM25zTlNrZTR5dUtXQXFCSmlFMnFsQ095UWhiSjNwdmpYazRL?=
 =?utf-8?B?cEpyRloraHN4YTVoRXV6cEVVR1BnNDlwa3h2R2JqNEY0QjFHQkV3Qm9aaFg3?=
 =?utf-8?B?NjRTNkFWNlJhWE0waUhNVCsvMFQ3dmNtMDM5a3dYeVNFb0VvbkFpd3I4Wk5P?=
 =?utf-8?B?cXdhaDhidXhYd3d4VE5SNFZBdHYyMms1eFovZHZYaGh2c05WSUFxRUo4SzlH?=
 =?utf-8?B?ak43UzZlaFVOZGx6YWtsaThRM0V0c2YxYTA5eVc4OXpad3FWT1cvTjFuY3dr?=
 =?utf-8?B?c0dsK2F6SWd2Ri9nUmJDVXFzVU1FMW44U2tNZlFiV2MyQWE2Mm9MN2dXcHhr?=
 =?utf-8?B?emRJSkJMcjdPNmZFMXVvbmNDRitvRzZJcDVtNmlSazNBd2Z1RWhZZ1BnK1Ry?=
 =?utf-8?B?QTNQRDR1Tjk2M2gyMkRZMEM1TFA0dVdGYm4wdmxRK1NCUGE5MTE2T2x3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9194.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S215M08vYmtRQmd6WUI5QUlabFY2ZHZpWmRxYVVFZjlDY3JGT2JPZmlmYnZP?=
 =?utf-8?B?VHAzMDFwbmR2MlZiZ3pZaVB0ZDY3K2VUWU5EV1JsZm8zdjVRMDRIWFN0bWF1?=
 =?utf-8?B?c1RZV3krVkpHV3ZvTHV3SUhEOUZpSnZETElKOHFYbzdJb2pEdjNMVUdBUlgr?=
 =?utf-8?B?cjhkdE1JdXcwYXRCSzVDYmJIb0pnRVIzR3lvM2s4ckE5eGZVanpNR0ZkTmQ4?=
 =?utf-8?B?N1pzQ0tTRWNjeW1mVW1uSWdNa0RjUXRhRTM3VXFiS2lUNzJJeVltTHlaSVhu?=
 =?utf-8?B?ZE9HUzNzVWhDR0VxcUZ2bVNJeDVXTTIwZjliS1lOazZmMjNhL0JNd0VSUGxZ?=
 =?utf-8?B?Y0xWWXhtNnM0YVB0dlFTa0ZHaHhXamp3MFhwckNDSnNyTE1uRXFOVFR1MzJv?=
 =?utf-8?B?dVh5cVFPNEthNG1vbXBCOGNlWUNWTzlTbktEbzJlWG5NcDBwcU1hSEMxNnhv?=
 =?utf-8?B?SmF1WHo2R1A4c09vcmVnbUVtOTV1eDBXT1o0cHVobUdDWmVYYS8vTTFEZkVY?=
 =?utf-8?B?SStGM2pZTDdYSTFVQTlkTU0rR0h1NkJJN3R0RTZyVDZSeFdLNTJicjg1OFBr?=
 =?utf-8?B?NktiNVRYb2UySzJ4TTRJWUN6aWdyL2dwTWdWOC95RkRJWUJJdEQyUGhVQjFY?=
 =?utf-8?B?TG5OL2I3a05BY3ZzR3BrQjV3MXpZcUpyK09jd0Rpc0ZuNkFsTVpqZ25yVm5N?=
 =?utf-8?B?OEtxYmNtQ2tDYlJkN1JSQlZmY2NoU3lJYUgwZ0RxMFNYSENYSVVMUElZelo2?=
 =?utf-8?B?SHB4azkrQVYvS0ZqWmlkak9sUTNyZWlvczVINDcwZktHejNUSS9YOWk4T1Aw?=
 =?utf-8?B?bTYvcEdvNldSVlAwUnN0ZkN0Rzd4V25UYWwyU1JPMDZlK2dMdy9vNENRRHJq?=
 =?utf-8?B?TncvUFNqZTQzRmQ4K0FtN1FyVXBtRjdWaDEyRVdWQ1A1dXlON241bkd1SmM1?=
 =?utf-8?B?ZkdibnVja2JKUXRVUWFoU1JSSGVUMGNsTmsrRTNVbDFCK2NHUHVLa1owVUo3?=
 =?utf-8?B?ZDdxczZVQStlVDhuNHJRUjFzWHUraUpUdklndGs0UFNZUkxwVGh0UWpZZlRt?=
 =?utf-8?B?L0RSNnc3Rm45TjhvTVZhZVozbXJNb0dGdWx2Ny9zUE5Sd0FKM0lnMjZ1a2JU?=
 =?utf-8?B?eUtqOGgycGdNTjFscFhEQ1UxaG5sK2V6SmhYWFlGT2NOZ3dQbHFWVXRaN3A4?=
 =?utf-8?B?ZTBPclFKUUs3Ly93VWdPQjdlREVSc1lDZmxpdUpNbUlrM2hxMVN2S3FGSTVG?=
 =?utf-8?B?ZzZTMytvY2sxMkJzTjJ4L2Y3VTIrQ3hYY04wQ3RGUHFIalFTbElaRXlDa2xC?=
 =?utf-8?B?UnBGU2lnTDByM1dNbWFEYnhhK01WUHhvUVZMYXUwcWZMcC8vSlliV2p3MTM0?=
 =?utf-8?B?OHBBa285UFhhbTBlc2xuakZZTDJ0T2pKM1RTZjNJZTBKNGpkQUVyQm9sZ2dX?=
 =?utf-8?B?UDRMc01HbUQ2dzBkNmphcUtjL2hjclB5K0tRNW5IZmhIbE4yK1dzWGFHY05l?=
 =?utf-8?B?bElTYTBzMUJOWm5NKy9GS3VrZUVRUkxITWZRbHRpS0FISzFPbGFuYVhuU0Jm?=
 =?utf-8?B?bmdDb2FrbFlkYllwQS8zYllxWmtoTW9DZkJ6bHNNeXZ5djJzRTBkOEdLdkJF?=
 =?utf-8?B?K3VlQU5BQmhueVBFQ1JqSFd1aXN5RHl0S0lNV01DdUFQMWZSck1PMnVXRHJP?=
 =?utf-8?B?WTF4UzJaSFJtUXRXT0I4Q3pqcmZMTSt4WWQ0ejBDektFMHJqTEtaQVdNd2Fv?=
 =?utf-8?B?eHZ5SnhRZkNoRjZNUGlnODM1UWJXSHFucmU3c3pkNmRCOTZISmtXSXB5aitY?=
 =?utf-8?B?eW53cy9VOTFsRnYyTGllTkpieThYc2s2bkpObVgrQ0JsLzIxd04yeVRVV1dY?=
 =?utf-8?B?ejRjUmlQVTN2ejdoQm54SHhZTTlWc25rMHBnNTgycVdpdHJ0NXJlUnVoOExx?=
 =?utf-8?B?ekdOdklXcDNpNmtMTzJ0aHBuYUR6ZXQ5N1BQKytZV0FNbEZyaCtGaHVrN1lO?=
 =?utf-8?B?N2I4ZEt1VGJxeGY3U0VmbmpvVDc4RXlzSDExdU90TnBRY3NJTDZtSU1YNXdm?=
 =?utf-8?B?ZmpSY1lKUzNzYU9oanU1Wm9DUW10amRlVnpOd1pHek9KK3N3RnAybUdobTVD?=
 =?utf-8?Q?sRhKKfliev29Ke/6wKWxhJDEv?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 067c26c5-74da-4217-a684-08dcf4b66515
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 05:32:19.9883
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qaam3NrUmd9zh9xktrKaAREdIrkXlMhaRm8hYz+MDOONoybpjGMmLkSQ25B7qqx11ncI3GQ127CBf22Q1xbhTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6969



On 25/10/24 15:59, Nicolin Chen wrote:
> On Fri, Oct 25, 2024 at 03:54:44PM +1100, Alexey Kardashevskiy wrote:
>> On 22/10/24 11:20, Nicolin Chen wrote:
>>> Following the previous vIOMMU series, this adds another vDEVICE structure,
>>> representing the association from an iommufd_device to an iommufd_viommu.
>>> This gives the whole architecture a new "v" layer:
>>>     _______________________________________________________________________
>>>    |                      iommufd (with vIOMMU/vDEVICE)                    |
>>>    |                        _____________      _____________               |
>>>    |                       |             |    |             |              |
>>>    |      |----------------|    vIOMMU   |<---|   vDEVICE   |<------|      |
>>>    |      |                |             |    |_____________|       |      |
>>>    |      |     ______     |             |     _____________     ___|____  |
>>>    |      |    |      |    |             |    |             |   |        | |
>>>    |      |    | IOAS |<---|(HWPT_PAGING)|<---| HWPT_NESTED |<--| DEVICE | |
>>>    |      |    |______|    |_____________|    |_____________|   |________| |
>>>    |______|________|______________|__________________|_______________|_____|
>>>           |        |              |                  |               |
>>>     ______v_____   |        ______v_____       ______v_____       ___v__
>>>    |   struct   |  |  PFN  |  (paging)  |     |  (nested)  |     |struct|
>>>    |iommu_device|  |------>|iommu_domain|<----|iommu_domain|<----|device|
>>>    |____________|   storage|____________|     |____________|     |______|
>>>
>>> This vDEVICE object is used to collect and store all vIOMMU-related device
>>> information/attributes in a VM. As an initial series for vDEVICE, add only
>>> the virt_id to the vDEVICE, which is a vIOMMU specific device ID in a VM:
>>> e.g. vSID of ARM SMMUv3, vDeviceID of AMD IOMMU, and vID of Intel VT-d to
>>> a Context Table. This virt_id helps IOMMU drivers to link the vID to a pID
>>> of the device against the physical IOMMU instance. This is essential for a
>>> vIOMMU-based invalidation, where the request contains a device's vID for a
>>> device cache flush, e.g. ATC invalidation.
>>>
>>> Therefore, with this vDEVICE object, support a vIOMMU-based invalidation,
>>> by reusing IOMMUFD_CMD_HWPT_INVALIDATE for a vIOMMU object to flush cache
>>> with a given driver data.
>>>
>>> As for the implementation of the series, add driver support in ARM SMMUv3
>>> for a real world use case.
>>>
>>> This series is on Github:
>>> https://github.com/nicolinc/iommufd/commits/iommufd_viommu_p2-v4
>>>
>>> For testing, try this "with-rmr" branch:
>>> https://github.com/nicolinc/iommufd/commits/iommufd_viommu_p2-v4-with-rmr
>>
>> Is there any real example of a .vdevice_alloc hook, besides the
>> selftests? It is not in iommufd_viommu_p2-v4-with-rmr, hence the
>> question. I am trying to sketch something with this new machinery and
>> less guessing would be nice. Thanks,
> 
> No, I am actually dropping that one, and moving the vdevice struct
> to the private header, as there seems to be no use case:

Why keep it then?

> https://lore.kernel.org/linux-iommu/ZxsSYbK3gqyC84U7@Asurada-Nvidia/
> https://lore.kernel.org/linux-iommu/ZxsTAANTTuQzQ9HR@Asurada-Nvidia/
> 
> Do you need vdevice_alloc in the driver for your sketch?

At the moment one of the things I am looking for is a place to add 
tsm_bind(host_bdfn, guest_bdfn, kvm_vmid). I assumed that this vdevice 
represents the guest's IOMMU attributes for a passed through device and 
naturally stores the guest_bdfn as an id (for AMD). I am still trying to 
wrap my head around these new things. Thanks,


-- 
Alexey


