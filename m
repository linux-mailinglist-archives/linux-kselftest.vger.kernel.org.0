Return-Path: <linux-kselftest+bounces-21598-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E6FE9C01FF
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Nov 2024 11:12:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EDD3282F8A
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Nov 2024 10:11:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9B151EABA1;
	Thu,  7 Nov 2024 10:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="NIdIDsJm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2085.outbound.protection.outlook.com [40.107.212.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91C3E1E8856;
	Thu,  7 Nov 2024 10:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730974302; cv=fail; b=H8E2F5pzd+s3kyVN0lPa5SO+o4K+EzQ3KbVi2nY3Je3dy7hScuVJzsmAy8wLsVbgXuF9/UgeEDrPYnWgR95uRhhnqgehQ0i6NoS98n0MeYZN0ig3S45MBetTiBJRtEpnCGrSCJ7rWECTywUY6DNf/IpcLNp7VW16kErnyD+DSRY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730974302; c=relaxed/simple;
	bh=lETs+v3hPyJ8HMyl+sreJt4gA5cXkjpxBvUibZSHapQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oGUQCCI9qaMSOtYrjk6TZTEeAAmZwQlf7rquDe+TCpTfc2OmmR1202mrH09eiOp1scOUPiv9+zEWf8hHqJpnYT5CBPXQJsBJd6dRIhRqAUTTdQxPLnQQRDaziXXJx8dzPUxeonAlfv/9DtdwuWhiT/80HxFI2MohbG+NQ9JvAD0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=NIdIDsJm; arc=fail smtp.client-ip=40.107.212.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kt1ZQQJaT3tOqtIrGZ/pgeSpc8Ezn0y54hfGOxEUouKXMa1VvMBZiwz8ge1gCFOL8jOSBT6vtX520N57vPrlYbChMq/qMTn4GPn/QUM2I4HRnfeAVInDAK9r5D8KvHMp4xE83cMq8r5qCJN0tlunmwhTVJWDZTNzSZHoQe/isBvzc2n4hTiy18eRC0UPGD3FFt4/D5wdqujJHQw8t+EUDH1GObm6GrVqL4Ljit2H/eA5t6P5/Cri+5wp3e2Bq6DQKKEiv+CVqsB5xX+0SYPBT/HGLRyYUFiW5DWMBlxBgRmHm/Xk7p3UxmpNpE+bOp55OKydvSK1Z1sU7UEn6ZiaeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nogCHC/1T8qG8Cj0EjpCwPKadvqwyW91Q4CC/eRhlmA=;
 b=X2kOAh8U1VU2snNJFgV3515IsgEttoniUntkYWft3Wn5tu9k8sFSs2mUPT3Bj/GV+qmsZAZMepTVWS5ilZxCBK0b+tek4SdDIvP9LrKPPxhBTyVfdYSXpfNwf8zWHP1+5Krynr06WZouqdQyTU2ASikufLZMLbRMoebzJYMCVhreE9ahIgZd2cr3sj0te8E2o/cZnC/qvhtF/SUZEbEHdxv838sqYnl2c/BK2OgO5/8EueDkQVFTfxRsQzofAsZU74gxuT+c8SbJlWYOm8jb+zh7CJv/EaWj6PToYpZuBLtA96d3fRLexVi971E+PLujn/J//erpGJ3FAQ+lucxA+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nogCHC/1T8qG8Cj0EjpCwPKadvqwyW91Q4CC/eRhlmA=;
 b=NIdIDsJmuNUyR14sED8KaL3X/J9od+71jA5nltpa5DuPsgYH3FOY6DAStrr9W+jGl2fidWcSD0Txl27keIqN4yBci2uB32CXNV2YqaluKZcIH8/HqgtS8sW7yhpeQrGyDwY3Qa9hWTZZgXrz84GikBYfTNJTN27u78crB9kzaBM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9194.namprd12.prod.outlook.com (2603:10b6:610:19f::7)
 by PH0PR12MB8030.namprd12.prod.outlook.com (2603:10b6:510:28d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.31; Thu, 7 Nov
 2024 10:11:37 +0000
Received: from CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f]) by CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f%6]) with mapi id 15.20.8137.018; Thu, 7 Nov 2024
 10:11:37 +0000
Message-ID: <aeb88b6b-9989-4e1a-824c-757ffdbfbca7@amd.com>
Date: Thu, 7 Nov 2024 21:11:27 +1100
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v6 01/10] iommufd/viommu: Add IOMMUFD_OBJ_VDEVICE and
 IOMMU_VDEVICE_ALLOC ioctl
Content-Language: en-US
To: Nicolin Chen <nicolinc@nvidia.com>, jgg@nvidia.com, kevin.tian@intel.com,
 corbet@lwn.net
Cc: joro@8bytes.org, suravee.suthikulpanit@amd.com, will@kernel.org,
 robin.murphy@arm.com, dwmw2@infradead.org, shuah@kernel.org,
 iommu@lists.linux.dev, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 baolu.lu@linux.intel.com, eric.auger@redhat.com, jean-philippe@linaro.org,
 mdf@kernel.org, mshavit@google.com, shameerali.kolothum.thodi@huawei.com,
 smostafa@google.com, yi.l.liu@intel.com, zhangfei.gao@linaro.org,
 patches@lists.linux.dev
References: <cover.1730313494.git.nicolinc@nvidia.com>
 <19e20e54d41a0c1ab7403264e1016c4b19293135.1730313494.git.nicolinc@nvidia.com>
From: Alexey Kardashevskiy <aik@amd.com>
In-Reply-To: <19e20e54d41a0c1ab7403264e1016c4b19293135.1730313494.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SYAPR01CA0045.ausprd01.prod.outlook.com (2603:10c6:1:1::33)
 To CH3PR12MB9194.namprd12.prod.outlook.com (2603:10b6:610:19f::7)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9194:EE_|PH0PR12MB8030:EE_
X-MS-Office365-Filtering-Correlation-Id: dcd5e719-9c73-48eb-03fe-08dcff14908b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aUtMMnZSdlFwT3doSEU2VnBEdTdLNGdwRVNYc3grNEx6Sys1ZGhSdzlySytJ?=
 =?utf-8?B?MzM4MU80WHJKRmJ6ZmNXdnl4WDhCR0FWTkJnVGxWcWFJTUxQUEp1RTRoanZW?=
 =?utf-8?B?UW1WekNZZ0w0eVdlY2svMXBTR0FkOGN0SUk4eDM4Y2t5YnExMWJoQzRsTzJS?=
 =?utf-8?B?VUtKOVFsbENFdUJHUXhmY2g3M29iUlVudkZTcGU3V3BZUXpPbVNETGhPY1Ex?=
 =?utf-8?B?ZmtFRURxWjdaZGtIbUd2MDNZc0hWVVZxQVpKd3JqRXZTZFFrU0Vod1hyRjZH?=
 =?utf-8?B?Z3liOW5ZTHdNTDd6TDRteit6QWEyakJCbW5admczTUZFaGk0dVFrMThNSmlw?=
 =?utf-8?B?TFYzUjlSM3FFUG93VHN0d0NCRzI5ZXZpRDYxR0pIUkE1bGU0SlluZmZ1T3Zk?=
 =?utf-8?B?REJIMDZrWTFjQTVzVWNvQmJrTVJWWnkvN3RKQVJxb1lHa2RVbyt1RzlFSUtZ?=
 =?utf-8?B?ampoVU5PWGIzY3IycFhPUFdOZUxWOStuQnF0bHRoZFF0bzZBU25adzM4SlNu?=
 =?utf-8?B?cXJ1bnpXTXVYRU8zTzBaVlI3SlVUV0tpVzRHVTRWbHlON2x6RVVpekJOZTdu?=
 =?utf-8?B?WnB4Njk1b3JzWXRTUHF4NEQzaEFiWnNzWjFLajVRaG5WUmx4TFE3UCticzlI?=
 =?utf-8?B?T01lc3FsU0dTOGV3RnMwZjBUL2JMNXpvTUNnajRlUm9jZDYycXcxNEhIcENr?=
 =?utf-8?B?bGc5NGRTMnQyclRuY2JnWEx6Y0I1L2FCa3hwck9nUVM1MEZQQ09rcTNCYlBn?=
 =?utf-8?B?TnJyamZpZzR0QWZTcndmRUFLbnNpd1RsUzlGeEk3OVNKdmxaUXpydGNRVWs3?=
 =?utf-8?B?OUQxbXJpMzd1YzZHWGNNZXJvM1M5QWZsTW5YUzBpWVBZY0x3aG9jSk81OUdH?=
 =?utf-8?B?T3pBdm4zRVFURTgwM01yRlRRdTB3TDNJOFJZT1EycHVBWU5hZHdOUStKcis2?=
 =?utf-8?B?Ujl3RHFkSXJFYVhPM1RUQVBqR0JyUnJ1MWlqVUNkV0JKVDBHUU42Tm44akZt?=
 =?utf-8?B?VVh0T0pxOUlEaVRERTluL04rYlp3NytkTWlCN1l5M2JJbVlveG8yb3ZoaVg1?=
 =?utf-8?B?a0VZUnN1RDk4bjhLSFhhNmdYQnBFcE8zUzlRdWdXdWZoT3piM0pPcVdlbkZS?=
 =?utf-8?B?WHpLOEs4VUtQY1BoL2h5SS9ZSlF6VHdOdVRnOWR0L1VZNVp0ZGtXNXVJYlRz?=
 =?utf-8?B?WmF0ZFNOQ3FwN0QyMy9zVVRCM3pzMHdRRjkyamNjTi9YUkMyeUhrKzNuV0Vl?=
 =?utf-8?B?cHBEY0tROUphQ0JXY2dzVXU4K1VvbXExbkh3MmZsL29VL3dJTHNXTEtDRlh0?=
 =?utf-8?B?M1FGK1BXU0tvWlo2TnRLSWxZU2Z5dnBqaEpYQnM0SEdDdDRHM1FvY0E5UkxJ?=
 =?utf-8?B?dTFtc0JTbTVYSGIwUjZjTzcza2dGdDgyMUh1aTBKZHFxM255Mnk4cjFWNHFF?=
 =?utf-8?B?b3hsSHJXektWeFpaczJJbkVUTSt4NzZNU2FqOGlTejhER2JEU05TUWRlcTZU?=
 =?utf-8?B?c1ExNzNnRkVxeE0xeUNCU3djc2ZESUEyYXRGVUtYMHlNYTlZUmdDOXNEcVBN?=
 =?utf-8?B?bTJqbmoyaG16T0plelQyZnJGVXNLUVM3NTkxU1VnNHdpTUxqUVNFQU4wSUNw?=
 =?utf-8?B?d2tyckZDUVYzWXFaZUhRWmZGaTEzNUUzU1NRTi9xSURpN2t3QU5YOElRb0VC?=
 =?utf-8?B?V2hENWhJclJwbU5rSlNET2E2MHNBbjUrdUc3V214MnQwZGlaa085RytwWVB2?=
 =?utf-8?Q?562XrOVS3DmoKGSIXKw3OZWDfGhUbAxDE7SJAtr?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9194.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NzRkQ0ZTVWhOall5dG1LbzdhRGJkNVZtUEtZN0NBRHA5a1ZuMlo3TUZPT1Zw?=
 =?utf-8?B?WHRVWW1vVFFzTXFCMDBtUjZCVUJyV3VMdTdkRHg2V0YweGhmM0lSUGJWSTY3?=
 =?utf-8?B?WTdIOVJKY3I2V3lMMEwwa2JoVGtad0lJaUJsK1R4ci9HTy9Oak5Sa3VncmR0?=
 =?utf-8?B?Y2hHOXNFQmFDcitUOU9zYjJpcXMvTElRR0YxUWgrb1puckhMRFN3N0ZWY2pD?=
 =?utf-8?B?Y1ZGTEZ5M2RscEYyVXp3bmZSczZTenNZYWJpTWtZUTJlN3dDQllIWEgyZFpC?=
 =?utf-8?B?OXJpTG94MXl6Zm0wYzh6N3IwZFVGOGNYN3ZrNWRaaHRJZG9SUFdZbjQzanpn?=
 =?utf-8?B?TVhvVU9VRm8wZVBaV3hBdkhFSE5Sdm9QTHdFNG1TT0ZiMTh4RWNwTktEV0d0?=
 =?utf-8?B?aVFBVUFUZHZreWVIZmhYS0NKK3QydXNmNmF3TjQ3VTZ5dkRhekNxZm0xWDQ5?=
 =?utf-8?B?SmJkUWcyR0VxRlFMcWhUMHFqRERiamZDTGRsUmdRNGVTaUYxV3c4blBBWDJF?=
 =?utf-8?B?Q0NkcDBLZW8wR2VJYVRVYWR0S1pwUTBIVXZyNHBGRXFEUlpRYTRTS2xkakly?=
 =?utf-8?B?NnNnZjhRU0Fta2JlYlJ5TFN2Z09uVUhKYm1YRTFhT1pIR1pPN3ZRQy94T0w5?=
 =?utf-8?B?RWRYbkpFRVJ1K0FLZVVNZWE3b3pkaGxjcFREeThlRGNVRXJMeDEvc2lmd083?=
 =?utf-8?B?UWxLcGo2dHdEeDBPR2RrckF3TEtvdlRDbkwrNHduc2FLYTZvNWVHa051dG9j?=
 =?utf-8?B?RUdYR0M0d0ZrTkZZajY5Mlk0L0lYbmxBMUFBZlBsbzhTUTF4VEZKcW84RUta?=
 =?utf-8?B?Z0haaVpuZDlaQ29VNmVQQU9rUmNrNk91Z1NxbGkzQkFhaXIzamRoVkpRalI2?=
 =?utf-8?B?Z2lILy92OUxsdjJ3L3dQRUI3UVhnYUp4bEdsVHpPQjg4c1RhVVIyY0NuNDBK?=
 =?utf-8?B?bDhXRm5TclRnNnRmdGdqemFyRjlpZ21ocXdORzk5ckRtNVVnMXdEVmxDMnJN?=
 =?utf-8?B?UWtha01QUmM0RE9NSHIySURZRC9jOFB0VWJJWEJsWDdGd0NDc1ZjZ3ozd0hz?=
 =?utf-8?B?VWxhTDlnbFZBUnVDamJCUkpCOXBvS2hzQ1phRDNPdmYwMUhNd2o2Z1hvMzB5?=
 =?utf-8?B?VXBQNy9XbytHSlMrcDVuTksvUGpYdERjZzA1N2dwTW55WDhaNDNlc3RzT1JD?=
 =?utf-8?B?VzF3b2UrYnNyN1dESjVkbUF5K0o1RXZ0eEREN1ZCbmFHWXExNm9WSFZxMG9H?=
 =?utf-8?B?Q2dpWWxpL2gwS0ZZakMzTkxxeTI4M2t2ZkFvdW44cXpvakIrM1FxaC9tWGYr?=
 =?utf-8?B?VXRidmF0Z0xtdC9UMEFqWVgyUDNtSkI2M0JGYjRuZGRuTmNqWkd0ZmN2M0FL?=
 =?utf-8?B?cEllOVE5WitCTXlUU2taV3NuZUVXMU03TWV6T09YKzVIeUNhVVhXY0x4N0F4?=
 =?utf-8?B?Z1RFd3h3QWNNQ3NtNmZxd0xwRjU1RkF0clVEUStZS2R4WW42VXZqV2M2QzRp?=
 =?utf-8?B?dE1oV1ovVThXZUloeFh3cnBEdnlpN25mVFVHa3lIQjBJem9iYnl1QjhaUkxU?=
 =?utf-8?B?V21tdXRRakFsU3BycjJUQmdPVlpESisrWWV6L2t1QUllOXA3TVZ1d1kxVFEz?=
 =?utf-8?B?c0RKaUlDRzhrbVJVV3R3bXdDYThtNll1TVRITldpRm0wbEtHV3hyNTNJeXZ1?=
 =?utf-8?B?bHE1akNEdSsxQnBlbVNqOTUrYUlLbkE5eldlWGNxemltNk1vR2E5NFh4MG5G?=
 =?utf-8?B?MFV0ZEpQamcwMW9YUS9nN01UR1dsNlhvZHpvN0JWWEpTcFQzUHE1MGk5Q21H?=
 =?utf-8?B?YXNJazhQdVppWlljZ3VWbFMzUUpmK3Vnem8wWVhTUHNiZlNDcnFELzNlaVhE?=
 =?utf-8?B?ekpMenp5eTROcHhRbDBnM2FnWlJicEc3ZDU4VitWL3pETjQ3VEJUNTZIMll0?=
 =?utf-8?B?YTV6Q2l6ZWNwS25kNXR0d0NmdGpEUmMvT2hsTHFRTWs5NWlaQ3RBbXV3VUhu?=
 =?utf-8?B?dnZKZDI2TXUrK2NKN0hWZTlXNTkrTlYxaThoTlBlZlJ6Z1k0dVhkbjZhY3lJ?=
 =?utf-8?B?Z2xzdDN5a1owUDNMQmNGbDNFeDRsbzRlN1I3S2U1b09uNjlRTUZYdlFMMCtt?=
 =?utf-8?Q?9eWp3vD2qQzARIkmK5ZpC6ZAb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dcd5e719-9c73-48eb-03fe-08dcff14908b
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 10:11:37.0674
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f/1+ChvBpcWiUMdiJoDmelv8BDmMUOHtfJAg1kF0u7gEENDxdqAv4DcTrBSjkKakbiYde92nfko5izYf3q4VKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8030

On 31/10/24 08:35, Nicolin Chen wrote:
> Introduce a new IOMMUFD_OBJ_VDEVICE to represent a physical device (struct
> device) against a vIOMMU (struct iommufd_viommu) object in a VM.
> 
> This vDEVICE object (and its structure) holds all the infos and attributes
> in the VM, regarding the device related to the vIOMMU.
> 
> As an initial patch, add a per-vIOMMU virtual ID. This can be:
>   - Virtual StreamID on a nested ARM SMMUv3, an index to a Stream Table
>   - Virtual DeviceID on a nested AMD IOMMU, an index to a Device Table
>   - Virtual RID on a nested Intel VT-D IOMMU, an index to a Context Table
> Potentially, this vDEVICE structure would hold some vData for Confidential
> Compute Architecture (CCA). Use this virtual ID to index an "vdevs" xarray
> that belongs to a vIOMMU object.
> 
> Add a new ioctl for vDEVICE allocations. Since a vDEVICE is a connection
> of a device object and an iommufd_viommu object, take two refcounts in the
> ioctl handler.
> 
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>   drivers/iommu/iommufd/iommufd_private.h | 18 ++++++
>   include/linux/iommufd.h                 |  4 ++
>   include/uapi/linux/iommufd.h            | 22 +++++++
>   drivers/iommu/iommufd/main.c            |  6 ++
>   drivers/iommu/iommufd/viommu.c          | 76 +++++++++++++++++++++++++
>   5 files changed, 126 insertions(+)
> 
> diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
> index e8f5ef550cc9..062656c19a07 100644
> --- a/drivers/iommu/iommufd/iommufd_private.h
> +++ b/drivers/iommu/iommufd/iommufd_private.h
> @@ -507,8 +507,26 @@ static inline int iommufd_hwpt_replace_device(struct iommufd_device *idev,
>   	return iommu_group_replace_domain(idev->igroup->group, hwpt->domain);
>   }
>   
> +static inline struct iommufd_viommu *
> +iommufd_get_viommu(struct iommufd_ucmd *ucmd, u32 id)
> +{
> +	return container_of(iommufd_get_object(ucmd->ictx, id,
> +					       IOMMUFD_OBJ_VIOMMU),
> +			    struct iommufd_viommu, obj);
> +}
> +
>   int iommufd_viommu_alloc_ioctl(struct iommufd_ucmd *ucmd);
>   void iommufd_viommu_destroy(struct iommufd_object *obj);
> +int iommufd_vdevice_alloc_ioctl(struct iommufd_ucmd *ucmd);
> +void iommufd_vdevice_destroy(struct iommufd_object *obj);
> +
> +struct iommufd_vdevice {
> +	struct iommufd_object obj;
> +	struct iommufd_ctx *ictx;
> +	struct iommufd_viommu *viommu;
> +	struct device *dev;
> +	u64 id; /* per-vIOMMU virtual ID */
> +};
>   
>   #ifdef CONFIG_IOMMUFD_TEST
>   int iommufd_test(struct iommufd_ucmd *ucmd);
> diff --git a/include/linux/iommufd.h b/include/linux/iommufd.h
> index f03c75410938..ee58c5c573ec 100644
> --- a/include/linux/iommufd.h
> +++ b/include/linux/iommufd.h
> @@ -10,6 +10,7 @@
>   #include <linux/errno.h>
>   #include <linux/refcount.h>
>   #include <linux/types.h>
> +#include <linux/xarray.h>
>   
>   struct device;
>   struct file;
> @@ -31,6 +32,7 @@ enum iommufd_object_type {
>   	IOMMUFD_OBJ_ACCESS,
>   	IOMMUFD_OBJ_FAULT,
>   	IOMMUFD_OBJ_VIOMMU,
> +	IOMMUFD_OBJ_VDEVICE,
>   #ifdef CONFIG_IOMMUFD_TEST
>   	IOMMUFD_OBJ_SELFTEST,
>   #endif
> @@ -89,6 +91,8 @@ struct iommufd_viommu {
>   
>   	const struct iommufd_viommu_ops *ops;
>   
> +	struct xarray vdevs;
> +
>   	unsigned int type;
>   };
>   
> diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
> index a498d4838f9a..9b5236004b8e 100644
> --- a/include/uapi/linux/iommufd.h
> +++ b/include/uapi/linux/iommufd.h
> @@ -53,6 +53,7 @@ enum {
>   	IOMMUFD_CMD_FAULT_QUEUE_ALLOC = 0x8e,
>   	IOMMUFD_CMD_IOAS_MAP_FILE = 0x8f,
>   	IOMMUFD_CMD_VIOMMU_ALLOC = 0x90,
> +	IOMMUFD_CMD_VDEVICE_ALLOC = 0x91,
>   };
>   
>   /**
> @@ -864,4 +865,25 @@ struct iommu_viommu_alloc {
>   	__u32 out_viommu_id;
>   };
>   #define IOMMU_VIOMMU_ALLOC _IO(IOMMUFD_TYPE, IOMMUFD_CMD_VIOMMU_ALLOC)
> +
> +/**
> + * struct iommu_vdevice_alloc - ioctl(IOMMU_VDEVICE_ALLOC)
> + * @size: sizeof(struct iommu_vdevice_alloc)
> + * @viommu_id: vIOMMU ID to associate with the virtual device
> + * @dev_id: The physical device to allocate a virtual instance on the vIOMMU
> + * @out_vdevice_id: Object handle for the vDevice. Pass to IOMMU_DESTORY
> + * @virt_id: Virtual device ID per vIOMMU, e.g. vSID of ARM SMMUv3, vDeviceID
> + *           of AMD IOMMU, and vRID of a nested Intel VT-d to a Context Table


So it is one vdevice per a passed through device (say, a network 
adapter), right? I am asking as there are passed through devices and 
IOMMU devices, and (at least on AMD) IOMMUs look like PCI devices, both 
in hosts and guests. For example, from the above: "@dev_id: The physical 
device ..." - both a network card and IOMMU are physical, so dev_id is a 
NIC or IOMMU? I assume that шы a NIC (but it is a source of constant 
confusion).

Is there any plan to add guest device BDFn as well, or I can add one 
here for my TEE-IO exercise, if it is the right place? It is the same as 
vDeviceID for AMD but I am not sure about the others, hence the 
question. Thanks,


> + *
> + * Allocate a virtual device instance (for a physical device) against a vIOMMU.
> + * This instance holds the device's information (related to its vIOMMU) in a VM.
> + */
> +struct iommu_vdevice_alloc {
> +	__u32 size;
> +	__u32 viommu_id;
> +	__u32 dev_id;
> +	__u32 out_vdevice_id;
> +	__aligned_u64 virt_id;
> +};
> +#define IOMMU_VDEVICE_ALLOC _IO(IOMMUFD_TYPE, IOMMUFD_CMD_VDEVICE_ALLOC)
>   #endif
> diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
> index cc514f9bc3e6..d735fe04197f 100644
> --- a/drivers/iommu/iommufd/main.c
> +++ b/drivers/iommu/iommufd/main.c
> @@ -308,6 +308,7 @@ union ucmd_buffer {
>   	struct iommu_option option;
>   	struct iommu_vfio_ioas vfio_ioas;
>   	struct iommu_viommu_alloc viommu;
> +	struct iommu_vdevice_alloc vdev;
>   #ifdef CONFIG_IOMMUFD_TEST
>   	struct iommu_test_cmd test;
>   #endif
> @@ -363,6 +364,8 @@ static const struct iommufd_ioctl_op iommufd_ioctl_ops[] = {
>   		 __reserved),
>   	IOCTL_OP(IOMMU_VIOMMU_ALLOC, iommufd_viommu_alloc_ioctl,
>   		 struct iommu_viommu_alloc, out_viommu_id),
> +	IOCTL_OP(IOMMU_VDEVICE_ALLOC, iommufd_vdevice_alloc_ioctl,
> +		 struct iommu_vdevice_alloc, virt_id),
>   #ifdef CONFIG_IOMMUFD_TEST
>   	IOCTL_OP(IOMMU_TEST_CMD, iommufd_test, struct iommu_test_cmd, last),
>   #endif
> @@ -501,6 +504,9 @@ static const struct iommufd_object_ops iommufd_object_ops[] = {
>   	[IOMMUFD_OBJ_VIOMMU] = {
>   		.destroy = iommufd_viommu_destroy,
>   	},
> +	[IOMMUFD_OBJ_VDEVICE] = {
> +		.destroy = iommufd_vdevice_destroy,
> +	},
>   #ifdef CONFIG_IOMMUFD_TEST
>   	[IOMMUFD_OBJ_SELFTEST] = {
>   		.destroy = iommufd_selftest_destroy,
> diff --git a/drivers/iommu/iommufd/viommu.c b/drivers/iommu/iommufd/viommu.c
> index 888239b78667..c82b4a07a4b1 100644
> --- a/drivers/iommu/iommufd/viommu.c
> +++ b/drivers/iommu/iommufd/viommu.c
> @@ -11,6 +11,7 @@ void iommufd_viommu_destroy(struct iommufd_object *obj)
>   	if (viommu->ops && viommu->ops->destroy)
>   		viommu->ops->destroy(viommu);
>   	refcount_dec(&viommu->hwpt->common.obj.users);
> +	xa_destroy(&viommu->vdevs);
>   }
>   
>   int iommufd_viommu_alloc_ioctl(struct iommufd_ucmd *ucmd)
> @@ -53,6 +54,7 @@ int iommufd_viommu_alloc_ioctl(struct iommufd_ucmd *ucmd)
>   		goto out_put_hwpt;
>   	}
>   
> +	xa_init(&viommu->vdevs);
>   	viommu->type = cmd->type;
>   	viommu->ictx = ucmd->ictx;
>   	viommu->hwpt = hwpt_paging;
> @@ -79,3 +81,77 @@ int iommufd_viommu_alloc_ioctl(struct iommufd_ucmd *ucmd)
>   	iommufd_put_object(ucmd->ictx, &idev->obj);
>   	return rc;
>   }
> +
> +void iommufd_vdevice_destroy(struct iommufd_object *obj)
> +{
> +	struct iommufd_vdevice *vdev =
> +		container_of(obj, struct iommufd_vdevice, obj);
> +	struct iommufd_viommu *viommu = vdev->viommu;
> +
> +	/* xa_cmpxchg is okay to fail if alloc returned -EEXIST previously */
> +	xa_cmpxchg(&viommu->vdevs, vdev->id, vdev, NULL, GFP_KERNEL);
> +	refcount_dec(&viommu->obj.users);
> +	put_device(vdev->dev);
> +}
> +
> +int iommufd_vdevice_alloc_ioctl(struct iommufd_ucmd *ucmd)
> +{
> +	struct iommu_vdevice_alloc *cmd = ucmd->cmd;
> +	struct iommufd_vdevice *vdev, *curr;
> +	struct iommufd_viommu *viommu;
> +	struct iommufd_device *idev;
> +	u64 virt_id = cmd->virt_id;
> +	int rc = 0;
> +
> +	/* virt_id indexes an xarray */
> +	if (virt_id > ULONG_MAX)
> +		return -EINVAL;
> +
> +	viommu = iommufd_get_viommu(ucmd, cmd->viommu_id);
> +	if (IS_ERR(viommu))
> +		return PTR_ERR(viommu);
> +
> +	idev = iommufd_get_device(ucmd, cmd->dev_id);
> +	if (IS_ERR(idev)) {
> +		rc = PTR_ERR(idev);
> +		goto out_put_viommu;
> +	}
> +
> +	if (viommu->iommu_dev != __iommu_get_iommu_dev(idev->dev)) {
> +		rc = -EINVAL;
> +		goto out_put_idev;
> +	}
> +
> +	vdev = iommufd_object_alloc(ucmd->ictx, vdev, IOMMUFD_OBJ_VDEVICE);
> +	if (IS_ERR(vdev)) {
> +		rc = PTR_ERR(vdev);
> +		goto out_put_idev;
> +	}
> +
> +	vdev->id = virt_id;
> +	vdev->dev = idev->dev;
> +	get_device(idev->dev);
> +	vdev->viommu = viommu;
> +	refcount_inc(&viommu->obj.users);
> +
> +	curr = xa_cmpxchg(&viommu->vdevs, virt_id, NULL, vdev, GFP_KERNEL);
> +	if (curr) {
> +		rc = xa_err(curr) ?: -EEXIST;
> +		goto out_abort;
> +	}
> +
> +	cmd->out_vdevice_id = vdev->obj.id;
> +	rc = iommufd_ucmd_respond(ucmd, sizeof(*cmd));
> +	if (rc)
> +		goto out_abort;
> +	iommufd_object_finalize(ucmd->ictx, &vdev->obj);
> +	goto out_put_idev;
> +
> +out_abort:
> +	iommufd_object_abort_and_destroy(ucmd->ictx, &vdev->obj);
> +out_put_idev:
> +	iommufd_put_object(ucmd->ictx, &idev->obj);
> +out_put_viommu:
> +	iommufd_put_object(ucmd->ictx, &viommu->obj);
> +	return rc;
> +}

-- 
Alexey


