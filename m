Return-Path: <linux-kselftest+bounces-32008-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF191AA41CA
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Apr 2025 06:22:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92B3D3BA56B
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Apr 2025 04:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 989431D89E3;
	Wed, 30 Apr 2025 04:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="mW/7C5v0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2053.outbound.protection.outlook.com [40.107.92.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A871E2DC775;
	Wed, 30 Apr 2025 04:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745986948; cv=fail; b=KkFCOfX/lIzzkSATGYFE2Giq2K9NiCTdWfa51J+yNHVrZh59zETPQahyXpIb2bCdkC3H+o7SQNQgIKpsX6K+zUlzGZEWCCc9z45TN45OsBa6TV41F7z40DMrUF0wET1dg33hfZvaYIb2NswcOkVPDblPKbTATeBXy232+niHEMk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745986948; c=relaxed/simple;
	bh=lKplf4Q+OBuYlPmsMFyTCrz99GD6uWokx4jakmZcK7k=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=F6UNoiZ25GlmBxjAwig1mEuFcfak/N+txfCoMrMC5ckE3YJ/onOLoi4Y8c0zty/TAS2v0rizs8AiUmYiBmx/5zNbHx1aZ0Nn4aBoopSOCEZXrNnqn0GjK9GyPRE1u4VDska3Ic4q+zstZp09erko1mCqJ7QzX4f+o1V7JDdnIws=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=mW/7C5v0; arc=fail smtp.client-ip=40.107.92.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vRjF8Z8s7B0B5y6etUhhcUaUArTloGAU46xv1TE2a44Jimp2w4Hg71E0Qx1MkJAB+H+e9zN8GpmI1e1YjnN4/HaxJsqU3muhBRgyjMSRBHb313trGO5II9FlrygzIZ2JCu8ct6P6Fu6AsmLv52OGM00ufuYrEfk41bemVBLpA6akOhlgh/zmS/oVf6tea8XxSCo7UIHEalfecDgd7kgZhVsjwUbN9wyh4ovnMXWkVpCQROB/TNELX3hAtVqyZywDLUZIKaCIpaRljgw71dDRRMA9T7yzJ9h9KtgW8Yzwk273HJtyclFPt+cZEtNIEOrsy6jGfMlxxByuCwBrcPE8CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O5tJxQ+evYjVMmpPmqBdQCCwzS2gwUGZ22Y1x8Hvga0=;
 b=iZ2h5YRso0mznvN7pC+cq61++BgCDcidLFJr4E8Wb+UZEuKy3uV/pyZ9qR2uVgXGvdEfBVsY+pJn4X54MpXEEwmJXbno5oW6SRKxbVKiG3y8XccaTABK5yHnwU8QAk7SN+6Za/Y8Xy7DzSUN3xC+kUd55SjK5H/GqU1OoGC/1/atkFDbWgvqCuufo+tnAZ0asNGWKWW151n18oQjVfcJ69kXC0qcmQ+cg54xtAsO6IOIYaNHmR94wM7SV6liAJByBDA2L0bgmNefJuvaMycVL+SL/Xe6F50K/65DEXgSUpzSNPd9rs+OHn34yzaH8XH51f2Usvc1HUJ8HicgM3CWUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O5tJxQ+evYjVMmpPmqBdQCCwzS2gwUGZ22Y1x8Hvga0=;
 b=mW/7C5v0DompPEJMyHLJB2WRM+l9KlatO28znwOgpZhjwM8FPkReqxdcd8W/rhax0sJsdFNfy4Ew2cIGg95vxQEbyM2Ec652xdR4ikbwpa/VPXQBTtwVhmtJ26/IKxKLsxoJsLJW6Jdrm6+y2KrnJFSbh1LxhFvIo75cr6luBvc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 DM3PR12MB9390.namprd12.prod.outlook.com (2603:10b6:0:42::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8678.34; Wed, 30 Apr 2025 04:22:21 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5%5]) with mapi id 15.20.8678.028; Wed, 30 Apr 2025
 04:22:21 +0000
Message-ID: <7c813df6-e37d-47ae-9b5a-b8735c865626@amd.com>
Date: Wed, 30 Apr 2025 09:52:09 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/22] iommufd/viommmu: Add IOMMUFD_CMD_VCMDQ_ALLOC
 ioctl
To: Nicolin Chen <nicolinc@nvidia.com>, jgg@nvidia.com, kevin.tian@intel.com
Cc: corbet@lwn.net, will@kernel.org, bagasdotme@gmail.com,
 robin.murphy@arm.com, joro@8bytes.org, thierry.reding@gmail.com,
 vdumpa@nvidia.com, jonathanh@nvidia.com, shuah@kernel.org,
 jsnitsel@redhat.com, nathan@kernel.org, peterz@infradead.org,
 yi.l.liu@intel.com, mshavit@google.com, praan@google.com,
 zhangzekun11@huawei.com, iommu@lists.linux.dev, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-tegra@vger.kernel.org, linux-kselftest@vger.kernel.org,
 patches@lists.linux.dev, mochs@nvidia.com, alok.a.tiwari@oracle.com,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
References: <cover.1745646960.git.nicolinc@nvidia.com>
 <094992b874190ffdcf6012104b419c8649b5e4b4.1745646960.git.nicolinc@nvidia.com>
 <b0d01609-bdda-49a3-af0c-ca828a9c4cea@amd.com>
 <aA/exylmYJhIhEVL@Asurada-Nvidia>
 <b8338b47-6fbf-44ac-9b99-3555997c9f36@amd.com>
 <aBB1gLfahnLmn0N1@Asurada-Nvidia>
 <a3860aed-5b6b-4e68-a8fd-1a6ee28ba022@amd.com>
 <aBEI+T7P+hV8Y6tU@Asurada-Nvidia>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <aBEI+T7P+hV8Y6tU@Asurada-Nvidia>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4PR01CA0059.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:274::9) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|DM3PR12MB9390:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f8fae7f-392f-4c63-1e44-08dd879e999b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SnZ1ckp3NXFIUGsrQyt0anF4S1llVWNZcWtJeTB1Q3F3L2tHblJGdWFGM09r?=
 =?utf-8?B?Z1JKL3J3SVRudVdFYU1USHNMMDNaMHFsVE9nQkZ2SWtkbkFsWG5jZ1o1L2VR?=
 =?utf-8?B?QnUyYlNtcVJodkJrWVZ2WWxVMmN6Ky9RZmNoTjhBQ3RWS0FmSTFzNjZWbGtK?=
 =?utf-8?B?TU43QTY1aThtUURia2dzeUJqbkdEQ1IwT3pLRmRXQ2dhbjlnT0tlZUNFRzRm?=
 =?utf-8?B?TWljcnltTkgxR0ZrMTEvOEhBUHJYT29tdmxxSkJndmcyaEhjNzlXSkc5Unlu?=
 =?utf-8?B?cGpYeHVNT2FEbG1ZallBTncrMGJlNjdUYWlLWE5YVlRLY1Q1c2hWSGFBWVJB?=
 =?utf-8?B?SGNzQU56NWxzTDc4YlJrK1FySVFwRmFnbDYvcUk3R3N1OTNVaUFrblMrQnd6?=
 =?utf-8?B?dmRLTWZ4QnROMzE2RUZCVERUWU5lTUh2MXZLSjA2bjg1Q0lXNzRRSzBDQjBG?=
 =?utf-8?B?QjhFek5mdWNFSG9ENmtnempRMzBLM09nL2djNnhtSEJmMisyZWR2K0kvYitF?=
 =?utf-8?B?RytvZVJFREZZZjljbW9tdG5qdzZQTXhFcWRzR0o2blVhM3J4MUxmbTBGSW0x?=
 =?utf-8?B?MHlKNXdoendqQmorSFRFTFpRemdpRktjNUd2ZG5OVUxXTDJTR1Q0NWNWS3Zx?=
 =?utf-8?B?a054N0hCamk0UW94TlZIYXBkYzdIL010V25NYnlGSGJtbnFwNWJ2UGtQWmdi?=
 =?utf-8?B?bnNXR2lnNGR1U2dUUEc1ZGhwa2ZPWVk5dmUzYVhBeHJXRzFGeTU0bVFnUW9z?=
 =?utf-8?B?MUZFMEN6Y1VwK0lzcEp2MXh0RzI3U0xWUmNmUXBXa2o3WVlwb1JDb09aR0RV?=
 =?utf-8?B?OU1uODJRNUZSNllqa3dyRDBMTHN3STFSc1lFaEVuL005RXA3eTdORU9EQzAz?=
 =?utf-8?B?SVZqSDhEeU14aDF6LzZHMWF3eU9SQmhJTWo4RFVyMFg3bUV2VTNyUkF3b3V4?=
 =?utf-8?B?NmtpY0thd2NhNkhMTDlqemZlbEdQcFNFUisyWk9VUDRodXNSdWdRWlpSbjVD?=
 =?utf-8?B?cGNjSS9UVGJPK3pOZ2o5bXBQNTFjUU5ZU3A2QXc5NU5EQUl0K2NUTEJZZ0Jj?=
 =?utf-8?B?clZkU3NuNitMOTNnNWhrdG1ES2t0dUZkc1F3bVN6TUJBRHZFdjRtUHhwRkVG?=
 =?utf-8?B?NzI1L2VraHI1bjZtN1l5SXJSYWVZeGxXd3ArU2xSWW94KzBjU1RxVzE2cTVK?=
 =?utf-8?B?WkU3VkszRkhCWk1RaFZvZHdVeGZiaEE1L1krU0JtamNyZnQzZzF5S1cyRE1u?=
 =?utf-8?B?QUp1NllCM1JrWjN2MlpxQVBpdUp4YVBTN3ZQcDNoRzhVNzNwaStlMGE1cHk0?=
 =?utf-8?B?MmF2ZEc1VWpqU3VlRDdONUh3TkdSaXRQT25JSDZJL3RUWkoyVE5yMmdyc0Qv?=
 =?utf-8?B?VGdGeVFSa1U3NUpta0xYTTdpYTI4d3dyc0Y1cStmQVB4dTRHL0tMUXVUdnlO?=
 =?utf-8?B?UUgyR2lSTjNDTjljemxCT0RuQmJ4YVJCc21rNnREZ012WWZxcVBVTzE0c2VL?=
 =?utf-8?B?STBBR0VqY0hmOUJBQjBoWU51RmVMNnN4cVpNNk5lVmZ4UzIyYnpMQWF5NlAx?=
 =?utf-8?B?aTVUYlFUc0MxTjd6T1pMWkQvRHVNNjdPc3puK0cvZkVmYVNQMzRoM0JMUHps?=
 =?utf-8?B?N0VUeW1sL0dKNzVsalR0STZheURBOXA1ZUJOS0FDcDMvU2ZZcERRVmpkVXhF?=
 =?utf-8?B?OWpjejZJUHBYZ2RFTlJnM2NSSU0vdzF4dUdDT0dOb2dvdUg0WFI0RWNTQVhT?=
 =?utf-8?B?OUY5SWdkRkF4b2h3TEEwTGRXRmpjcVlvUXVYOFZYMHV4MU1RRjRtcjIya0xr?=
 =?utf-8?B?em5GcFpwZkxWbXhGNjdPMSthMXNyT3lZMmZNUlNvTTYwTzR2OE8wU2hrNnpI?=
 =?utf-8?B?K1lsNGJwWGRrNEJpSWtqOUR6NzJ1M3NrMG1iaWJzU2xhRkNIeVlkT002MmhY?=
 =?utf-8?Q?NI/621Sfj6s=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bERSM2RmTm12MkJFSStidHdLaWNpakt6UkhGVFRwczNoTkxrb3pnSzBDZUt6?=
 =?utf-8?B?aGlGN1VWeUR5dHN3d2dLUXAzcTZCM1NjaThyS29Tbnd6QUxsMVJsMmxidHg5?=
 =?utf-8?B?QjhzSlFab3Rwa2hwSE00RHg0dFJIbkEvTVVQNnNXTEx1RjM5bXBoS1AzUGd4?=
 =?utf-8?B?RUxUYy82aSt3ZXA2SGxrcWNPa0RybHpQMWtyN1F5S2M2OTZsNER5dC8rN0VJ?=
 =?utf-8?B?cjFkZ1hTV3ZuS2hYK3hlMUpONTN0RGk3Vy81OXZaYkZDUnNSRGNQbnZKREJQ?=
 =?utf-8?B?c0VMVk5QRlJuQUhFSWgrMytWVXo1K2w2b2ppL0hNNnlWVUFZN3dPOFZRbkxI?=
 =?utf-8?B?WThLeS94U3luWEpNeFg4OVJteCsrOTZyQkNaeVdMY0M5cnpzakhQSmswYXNv?=
 =?utf-8?B?cXlIUlYvY0ZPbVpaSThNMnB2eDBqZFBLUnFsWnZuSldtelUvZEp4STNSeDhG?=
 =?utf-8?B?ZWdoU0diSUYxanEvNnovNTFnb0dIelYwTWI1eXNUODM0R1BzeUtPaU9zeGNr?=
 =?utf-8?B?MkdoeHM2bkp3TVBtYUpSc0VEUmNsNEcrMVpiRlArS2NkUHFueHRNUXpNWDZI?=
 =?utf-8?B?eURVTjRsbkduWkpFd0tBK0I2ZzF2TkJnVTlUZGxwSzMvK0JQRURFeEFPQStw?=
 =?utf-8?B?UjQxcE9vTHdoS1ZGTFJHVzF0QkNidVVpZ0dIdVJhZnpodDhiYXg5Q3d3NXU3?=
 =?utf-8?B?WW1IU1FIczJybWRkV3Q0UGhqdE9WQjgzbXJnYUdEK3BsZzVtZzNBcUtnVmRY?=
 =?utf-8?B?Z0Rob210Q1V4bCtQSFU4UVFZaStuYnFjSHpCR2tsM1dNcFo1M3RPeHhmNWhT?=
 =?utf-8?B?QktEelJodlQ4M05GNzUwM2ZyOXBqN0ducmZHK0YwdFZUc3crUmZCTzBwZUxX?=
 =?utf-8?B?Mlh1T2piRnY3dVAxbGVLQzZkU2lmbG00T0NmcG5LMSttQVBFUDA4cldIVUUx?=
 =?utf-8?B?ZE1mYVRSZU0vbHptTUVjcHlQVEI4bllpT1ZKSk41a1JxZU9KNDhENmJTWDVB?=
 =?utf-8?B?aE5vVVR3SDQvRlA4VTZOWHgwY3V2b013VzNUU3A1WWZIaVV3elNGV2w0Q2Ez?=
 =?utf-8?B?QjZ1UmQwdUM2Yk5VS0Zmd1Q1Tk5TZk01eWVXSHM5ZUtKSFFpL0xGNXhGUk9o?=
 =?utf-8?B?RWVuUzdBVWVjemh1WndKMXRIRFpRUUdYSVB6N0xKU3lnWFVlWFYwZEdqN2lh?=
 =?utf-8?B?ZHdvclZneGlIWnF3QVFiMjJNT09VYmo3VFpLUm5pZkRNcHhwOWRTUUpEUVBH?=
 =?utf-8?B?aHRTNUd0ak0xb2ErMXYrSGpTTFFzby9FV2YvYXJQd3cvV1Y4emZ2SzI5TlVI?=
 =?utf-8?B?ODBiZ1ZjNXRhMlV2aFhXdTl1SE5tbkExbnZCTUxLWlRoc1FWcThqb2xmYnpt?=
 =?utf-8?B?WGhISGxqTzYxU1JZZXVNTlNQanZVaWpyNVhlTVpHWFhwNkwyRVFRZFhzV05o?=
 =?utf-8?B?OG4xZmRIdHNpdU5RcWRaTWlGeVYzaEVCYnZDVkF4b1dITU1uM1lVT2JweE1X?=
 =?utf-8?B?SVlqMGVHYVp3eDFwN09YbmdDeXhTbnVUNHdFVHRVRjhlcG0wa1dISDY2OXlX?=
 =?utf-8?B?VjIzNlhrUmNxS0J0dm9xK1lZbjYyaXZYRDNoOXJTNFBqc0pZM2Z2bGVoZkM1?=
 =?utf-8?B?K25mLzViNUE0L1U0bFllUEhNR2ZqSmw1RnpmMzdEL3NORHpmbUd3TkYvMXdW?=
 =?utf-8?B?alFaZnBOYzBvcm5IYWJpb0N2YWJxa2ZCRHJRRVV0NER2UEdDVWNmWk1qVG9W?=
 =?utf-8?B?ekxjUUcybXA2QWFZMHh5VG0wK0FqMlFVS0dtNWUxYUR5V2dNSjNKR1N5djZ2?=
 =?utf-8?B?bU5ZU2hNWlZ3U1ZFRXFPWUtsOVcvMkZGYTk3UzQzcUdvT0lCNkIyQ1huMmpk?=
 =?utf-8?B?d01VWnB2SnVodHk1NEh6UzdQcUJYYUpkQXNtM01rdTFRTVFNQ3dSMnJmMmU0?=
 =?utf-8?B?ME0zSUZieUlya0ltZnRuREd4V3lLL2VsWFc5MS9vSkVZNkhFQ2N0WWhYTlhZ?=
 =?utf-8?B?ZjY2M2g4a2NKRG9XZnRUcHJET05CamtLVityaUVIRUJrNys0eDNzL1lMNS95?=
 =?utf-8?B?NVpGOXoyemNNNWVMK1lUNkYzU082dExPOTBUeG03VGQ2Q2pPYzJWbkthR3Qz?=
 =?utf-8?Q?oF9lu/FyxcoOsYec/YPIR3ejb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f8fae7f-392f-4c63-1e44-08dd879e999b
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2025 04:22:21.1750
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tU/2rJTFBQ8okASRhqCWPAH99o72rK7YlxhveVPwEfUSuUAiLSD3KdfkgockGQvNL5tKrnMpmysZcFY32U2WeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9390

Hi Nicolin,


On 4/29/2025 10:44 PM, Nicolin Chen wrote:
> On Tue, Apr 29, 2025 at 03:52:48PM +0530, Vasant Hegde wrote:
>> On 4/29/2025 12:15 PM, Nicolin Chen wrote:
>>> On Tue, Apr 29, 2025 at 11:04:06AM +0530, Vasant Hegde wrote:
>>>> On 4/29/2025 1:32 AM, Nicolin Chen wrote:
>>>>> On Mon, Apr 28, 2025 at 05:42:27PM +0530, Vasant Hegde wrote:
>>>>> Yes. For AMD "vIOMMU", it needs a new type for iommufd vIOMMU:
>>>>> 	IOMMU_VIOMMU_TYPE_AMD_VIOMMU,
>>>>>
>>>>> For AMD "vIOMMU" command buffer, it needs a new type too:
>>>>> 	IOMMU_VCMDQ_TYPE_AMD_VIOMMU, /* Kdoc it to be Command Buffer */
>>>>
>>>> You are suggesting we define one type for AMD and use it for all buffers like
>>>> command buffer, event log, PPR buffet etc? and use iommu_vcmdq_alloc->index to
>>>> identity different buffer type?
>>>
>>> We have vEVENTQ for event logging and FAULT_QUEUE for PRI, but both
>>> are not for hardware accelerated use cases.
>>>
>>> I didn't check the details of AMD's event log and PPR buffers. But
>>> they seem to be the same ring buffers and can be consumed by guest
>>> kernel directly?
>>
>> Right. Event log is accelerated and consumed by guest directly. Also we have
>> Event Log B !
>>
>>>
>>> Will the hardware replace the physical device ID in the event with
>>> the virtual device ID when injecting the event to a guest event/PPR
>>> queue? 
>>> If so, yea, I think you can define them separately using the> vCMDQ
>> infrastructures:
>>>  - IOMMU_VCMDQ_TYPE_AMD_VIOMMU_CMDBUF
>>>  - IOMMU_VCMDQ_TYPE_AMD_VIOMMU_EVENTLOG
>>>  - IOMMU_VCMDQ_TYPE_AMD_VIOMMU_PPRLOG
>>> (@Kevin @Jason Hmm, in this case we might want to revert the naming
>>>  "vCMDQ" back to "vQEUEUE", once Vasant confirms.)
> 
> I think I should rename IOMMUFD_OBJ_VCMDQ back to IOMMUFD_OBJ_VQUEUE
> since the same object fits three types of queue now in the AMD case.

Makes sense.

AMD architecture supports 5 buffers. In practice we have not implemented event
log  B / PPR Log B in Linux.
  Command buffer
  Event Log A / B
  PPR Log A / B


-Vasant

