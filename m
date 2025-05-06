Return-Path: <linux-kselftest+bounces-32494-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E2FF3AABF04
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 May 2025 11:19:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3B7A4C6FCE
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 May 2025 09:19:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0C64266B65;
	Tue,  6 May 2025 09:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="UqBA6abm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2059.outbound.protection.outlook.com [40.107.212.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2310233136;
	Tue,  6 May 2025 09:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746523067; cv=fail; b=P/DnVCxzTFMnpcMsa3pm/j1JfbE/vw1waG0Be1yy97qEtmwEj5CkBxc8kP7f2tkcp/NzF8misO1sYZVNNzNucd3bjpaUniiaLONXc4otvUjc1f5ZcpiYcA3vN7m7xMJpvH/WIyBf+Kw7jndxuw/r61Zg563rJMRs1aNaNefxKu4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746523067; c=relaxed/simple;
	bh=7b+mTOuPt+k3oZEM6ZORj9K20wmOEguzmhnmpQAus1Q=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=md4DnTG7oVJ75zj3fK21n3PLwhWO0r3ZzFR9ZJTZcQy6C2hhqUFpf6PP00pZ2N6eZM0pIgEp4O36o4nCsNvvSn4LyK8IFj0+UKItKn3SOnvFr8H3H+CTTG2zMjJttq5gI4Oaihyjxc6mgLa/V96z/9kVEZgiZg204mQPU420jCY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=UqBA6abm; arc=fail smtp.client-ip=40.107.212.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E4ux35e4UtY4zGFzpn2ThznXskTr+kAL7bgwBaPeo7ok7TEPxTMzk42ZDgGZL2LGWsOJzhoiqg/1YT2VBYRposC//VaMrlnNCzLW9c2Y7n8PRQjBhAlIWEITmppFo9KMTwF+Gt4i/H5OuO57tKZ7UpfATHyS8p+BdHz27ifF+qCKREZG2psNIYkoxIRq0NLH9k56g/9ASHOGrk+PzKHEEKK6nEzosk0gtBbNd1YhBkqlsQ5IzMLBQUId7rMN6O3mtxtAUqWbDTRYGgpLfpNHbYzpOrq9uvFffD95/Ma9lSsjrN41dwG3GgvSI6SN/hOPfN466lQ7aErwveQQ34NGlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gr/mJFi+dYrEoj7vk321hSnXeIxlQ1zJqIUx63FEcxc=;
 b=L/+W4kGS8Lr62FKQsVgRPez5I2qtCCowjIgxTcuXzr6a2kl/HwqnHD0KEiGe4ZJrzrav5NhyuBPtFuJOg2oIjCxuW37yy3RAl9vZP4aR980y31WmIAfJVuYC/7BF6f/Y8VmJgw68uKosKzDov/JSF/Vmv9bhFca8DJJaydrqzoJTSFiqawunLOc5vXmXclShgQH5aZIoKUvpuZLXnvJ2HGC2HRqJBzIFL4G9i/yEv/tP10FkqC0GiePYGK/VXEVxzIZJaR2ZILvAq/WuIEPr8i7oTpw2/lKf/+W9M+uxlrDZ3dgCoC9y8EraLmmfATlAimBCTT0kRLz1hfBX3SWrpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gr/mJFi+dYrEoj7vk321hSnXeIxlQ1zJqIUx63FEcxc=;
 b=UqBA6abmPoRirYJOBLRTlk39ywSsyw6XnStMU1mxesdUDMIwYVpTFeqy1b9j46HuXE6yB0pTjPt8jBh7qLu5iJB8vXT9zJrgD9oMmXZ6JHebVVG7CMr+Mjm56fdqvtLJ58nI4IZ5yuJ2fVxGt0ApB0sGPecCW9n6se+ISHWtLco=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 SA1PR12MB7222.namprd12.prod.outlook.com (2603:10b6:806:2bf::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.23; Tue, 6 May
 2025 09:17:37 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5%5]) with mapi id 15.20.8699.019; Tue, 6 May 2025
 09:17:37 +0000
Message-ID: <cc9d2ff7-ce8c-419a-970c-cec88572c0c8@amd.com>
Date: Tue, 6 May 2025 14:47:22 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 10/23] iommufd/viommu: Introduce IOMMUFD_OBJ_VQUEUE and
 its related struct
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
 alok.a.tiwari@oracle.com
References: <cover.1746139811.git.nicolinc@nvidia.com>
 <b44dfbe2d933949f4d93a23fdae5b26af9d6f624.1746139811.git.nicolinc@nvidia.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <b44dfbe2d933949f4d93a23fdae5b26af9d6f624.1746139811.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4P287CA0122.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:2b2::11) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|SA1PR12MB7222:EE_
X-MS-Office365-Filtering-Correlation-Id: 6cf74808-32af-45e8-d651-08dd8c7ed7be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Y0g0S08vYjBvclZjajgyUXB3QWpjaFVNc0Q2ODliaHdHM2tIU3pieGxIR29M?=
 =?utf-8?B?amF2dnpsNEp2aVhaMUJlNCt4ODQwaHpaaW00UnlYL3Q4MkVyUHNKM1dBam1E?=
 =?utf-8?B?dDVDd29zck5tcGM2U2RkR1I1WUFCOHZuTWgvb0RmYUNocUNsSGFrT2llem1i?=
 =?utf-8?B?Yldnb2lYZktOL1h1TlNiMGl6ajN5WXUrSGovcG1QOXRWdTFXcHV1SXlaSFUx?=
 =?utf-8?B?WU9la2FYTk5JQkd5TVhMcm96cnFLakdGaXBhdVNHbjVFSnRtR0dyRzVlK2Fw?=
 =?utf-8?B?Q0dSTyt6ZTlOcHFFQ0lhOUU3bW9selhic0huV0QrdkNuRjlPc2RNZFFpVEkw?=
 =?utf-8?B?THU2OFUxd285MmFNRFdLVy9rV2xadmpSUUtLeEI3RzlDTEo4UHVwbUp5bmNv?=
 =?utf-8?B?NEJaYlJxQVN5WjR2M0R6aUViRGVidU1zbmV6ckZGck4wZDZTbzJCbE1relVS?=
 =?utf-8?B?OWlJS0J3N3Q4QU93N05GVXNxczc3MVk1cEQvY3QrV0dxVWlIZHo0ME90NWh6?=
 =?utf-8?B?Ym5BTXVpMENoWVY1djdRZ3FTTlBKem5tWE1TLzNLbWZlMXdHR3RZMkhuV01t?=
 =?utf-8?B?V0lQZEdBbDZNaXpkQ2lDWklFQk1zaWx2RTNwOERjeG9iZXFWZTVrRFRZZ1Nn?=
 =?utf-8?B?VTUxRFFNcVVuejB5a3lsOFJybDdXNm9vZm5kOE9HWjl4bFVqQ0lSdFJFWXRL?=
 =?utf-8?B?Uk43b0JKZ0oxWWRUc0h0Rml6d0RNbnhheGpLY0dhWUkzclBqcUxqQjZ2cTV5?=
 =?utf-8?B?WU9mZkdadE9hVTRoWjI0eHQxcFNzSHI2WFNhNGcyVHBHUVJ3dVV1TWNQb2Ru?=
 =?utf-8?B?RTRWYTJkWkd3OCtlRE9IK1dhOUJRMTlaYVM0ZkVCWFpiaklpL0tRYWRyT0Qv?=
 =?utf-8?B?OHZ3dnF6dS94Wnd1RVZMemgxQ0VYNC95d2loLzZlWnMyb3hWdVJmVWIvcy8v?=
 =?utf-8?B?bkh5QUFvV1VYRFJVVkVFTTk0elI3bml1QlBCa3VGcmdCUE9oaUtHSVA4UmNt?=
 =?utf-8?B?bVA4SUN3K3lXaVY4Q0lrd2UrWkVCNzN0VUQ1THU2RHRiNVhPeXQxdkhpZlBw?=
 =?utf-8?B?V293VG13MFVBbXhPK0YvNks5dGhCNlVXN01hcTFsUHNDejJiOGJyTklFcXRH?=
 =?utf-8?B?TjFEZlFwaVRqRVFsS0VveStGdGtrUWVHdkFtUUFZcURsZVpGRWdPMTFFWHZK?=
 =?utf-8?B?MmJvdjFNMGxMQTMrSFIzWWtNRVQ1NUpJbEZBSmNBVG82V2QzNjlsNHp1aEtq?=
 =?utf-8?B?aWFPK0F5UjJUMFE2RGpKTUQzZkphR01aWmJ1ZG9HTUVRbWtLM3lLOVRpd0lF?=
 =?utf-8?B?enpJSG5lcHlHeU5NZlE4ZmltSmhKR3pQRFJRSWtCRk16NFV4VXlnUXFoZUpw?=
 =?utf-8?B?T3hXbUpSNTRGdVVpdWgzcWIza2FpY281dGkyTllWZDRlUGZCb0R3M1lSUFU2?=
 =?utf-8?B?ajQ1MjFyNWNQVWxaZVBEd2FyUEN3VitmMHQ5OGR3SE1xNGx1bVAyclRGV3dD?=
 =?utf-8?B?Sm1PQTdKMlpVQkxxNGNuMXF5aTEyNDNxUE0zTFBlK2lrUEFTZXhpN3lrT0Vq?=
 =?utf-8?B?VU91S3pSTGRXNS90SXp5WGpWU3RabEd5MDhpZ25Gd01Vc0l0aVBkTEFMSWR3?=
 =?utf-8?B?UFZCM3NxQjF2TmRLa1NoWjhINTZpVDRBRUg0ejlWSHkzbGxReDZXYzdIZ1R2?=
 =?utf-8?B?enlXT1ZoTk1Sb2w3N3MwbldaQmhacDlySVNXUWhkVVhxZitNdXozaW96OVFL?=
 =?utf-8?B?TDAwemVOL09PN1lDQ3hOMi9VWGFvb05RR3g0WTVmMForQlB6enlWSTFhYzRm?=
 =?utf-8?B?RzUzYTVwc0ltZ0dLTExuc3BtYkgwWU43bTF3WHgzQTNYaFI2U09VNncyZkdu?=
 =?utf-8?B?V0d6RzhWN284K2pKenpEOXhKU3lBcUpGTXJocUFGYjkyK2tvWjNHRjErRTFQ?=
 =?utf-8?Q?TSfA4bVQ/pQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Vml1ay8yVHpkTTRZeDJmZ1BqZEdzR2xzSDU3NG9VTGUzZmViK25sMmhWbUR5?=
 =?utf-8?B?T29ocFoweS93SFZrR1BtbGhJTVVzaHZkL25ONnFuZi9UOUdqc2N1T2RBWERz?=
 =?utf-8?B?UENJbzRYVWpINXlpMExGenpWaE83bUltbko2R1ZmTWo3ZWpJRzdBbnV0T1la?=
 =?utf-8?B?Z1UycEVGcFN4bGFRelZrNTVnL0RuVy8wa2hpNFlER0gvRUNNK2JiL2pmTlVt?=
 =?utf-8?B?ZC9tQ3Y3Ry95c3RtQ3RnWUt1V3pycHdnUjhWenVVeWJibmdId3JNYWFQRWdj?=
 =?utf-8?B?YXUxZ3NWNzB3RUkzU1BreVJkYUxXU0tTelhVMERXKzlkVkFtUU1zN0VDMVlZ?=
 =?utf-8?B?czd3ZXhQZkM2Y3RhSlRMWndVQ0VlRmw2ZnRnbCtZWTE5dzRKUzl3bXpYQWJn?=
 =?utf-8?B?R05TaVVlQ00yODVscVk1UnBXbUJDQzd5S29lZDZKSEtXUDRaTU9TVHJpa2VX?=
 =?utf-8?B?ZHF0NUpPcGFLWkRDUnBMa2NZSlU5R2NzNWlnWXVoUVFQeG5xSlE5d0ZxTEk5?=
 =?utf-8?B?YnE1MlJocjUyendOb0RvSWpTOUs3UzF0d0xvU2c0ZnI5ZFZMcHJaNHdFUi9m?=
 =?utf-8?B?dkhZY3g0QjV1MUhNcmdDbWNTNkVCN1g3bUIrSXJJcXpjclBLcmx4Mk5MVi8x?=
 =?utf-8?B?NUNObnZNZndySU5YQnlsaWpQTGM2VHdPNmJJdFZtUElMa3IxamRLTVBtUXVW?=
 =?utf-8?B?VWxVSEVGOWdYdUZTSnh3MmRQQmIrbzBveEVuc0w0WnNhTklBOVZzOWZrOHJz?=
 =?utf-8?B?UXRvY0dud3ZWYmRMOTFydFlneXRiSUoxdVNQbkdoM0FFSTc4c3NzVndOR0h4?=
 =?utf-8?B?WUtoTi9XUGZ5MHcxR09CQmNXakJGUkZqZXhFT0pJekRMMWRyOWJidXN5b2hq?=
 =?utf-8?B?eTZ4c0FIWlFqRkJicXcxeEgwWkhIVFprTjZuU1pub0JpY3JGLzFYRFlISkJB?=
 =?utf-8?B?VUYyMkVLQndmdm82TllZc0xYV0IwMm9RTHBQQVhxM3ZkVFdTZWpTSEdjRW5K?=
 =?utf-8?B?TVlvNDBmUDl5TUY5cWZDWXJKVEFtV29kNm03ay9VUGF5dktGVnFzalpyMWJr?=
 =?utf-8?B?eHpEMWFySWxkWnkyV0pkMWQ0eG52Q0JNZ1h0eG5ONTFkTXhYcUtxUnlKcVJ0?=
 =?utf-8?B?S1FVazBPTDFxZDVMVksxaloreDZMemxpNnA1UXpCYitSZkg0S0IvS1h3YzNi?=
 =?utf-8?B?UVBkZExQODY2cFZtQ3VSQVNoMVU3ZWpCaTdmZEF5NDhYZVF4V3RYcU9nNzJu?=
 =?utf-8?B?L2ZlQy9EQS9nUHVPMlliT2ZPSjkvUVBKdnRudDQ5Vmw4cUorcmtYVHA1OFpN?=
 =?utf-8?B?cWZGQmlIK09ETkRIMEdDeTlmOHBCQVhQMVBFUndHbGYrYkt3VjI0RDNaZnZX?=
 =?utf-8?B?NWdoTk5wczl5WHZrang3SnJjYVVTNTBnNllFOG1uUXV5WlVvU21XcU1WblRL?=
 =?utf-8?B?SXNFSllYUGp4cDE5S3lwTEZHWFhHTHJHdUt4THErYlN1cnBrNVdDVEU5Wkhy?=
 =?utf-8?B?S3FoK3dHc28xcVI5UDE1R3dvQm1zMXdWTWxjbkp0NlYrUXl1ajAvaGVPeUtw?=
 =?utf-8?B?RmNmY0VIT05ITWJ3VE85WWVnWjZtcUJsL1JIVEd6Tko2MWF3NDNtbGIyMndl?=
 =?utf-8?B?ejZOWDdtemJ6WFFjLzVzd1BsVTZRTm1OeW1sbGhGYXA5YmlkRW9SWENteFZE?=
 =?utf-8?B?Z2pjVkN5cWRoS2p5T3JaUlU2OERyVTRkaTNPQ0dXS0lxQ3FLUElRNVhTenNx?=
 =?utf-8?B?L1pUWmZuVlR3Nm51RS9pSzVUU3ZXRHBKZXp0dWVOZUY1ZnozVU5GSEpyZEdk?=
 =?utf-8?B?SnRXYWFtcUJMV3ljQUtqOWpRanQyN2Yrby9sWklEcGZWSTBiajl5NXU0YS9X?=
 =?utf-8?B?bDZvblJLbUI5V1RMU3oraU8yMVREdVhxVkRJa3pUcE4wZnZTdkhpSTY0cGpO?=
 =?utf-8?B?VDFJbldER09YLzc0N1FNdTB1b1lLR2ZkdEkvTUNNU3B4UkkwUkMrSWZtMWYz?=
 =?utf-8?B?WjVITk9sNDJlYjNFTFI1ZHk3Z2RkOWpBSStyV1VNRHIxRSt4QU5XZy9YaGt6?=
 =?utf-8?B?SFF6MS9RNUlqMkpLVHlXU0FiVEl3azdaOHFGRktWUXpzYVE2eTlDalRDTnE1?=
 =?utf-8?Q?+32Z09e7rCDC4M2t2pD0QQxJw?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cf74808-32af-45e8-d651-08dd8c7ed7be
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2025 09:17:37.3331
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nPhu/uZLUv2ConyBCCwyNCo5A2bFiO7Ga7btSgtx6osyBC+buRkuSS7o8/wHaknZ0GnOT8KHb3YtAxA35j6XHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7222



On 5/2/2025 4:31 AM, Nicolin Chen wrote:
> Add a new IOMMUFD_OBJ_VQUEUE with an iommufd_vqueue structure representing
> a HW-accelerated queue type of physical IOMMU's passed to a user space VM.
> This vQUEUE object, is a subset of vIOMMU resources of a physical IOMMU's,
> such as:
>  - NVIDIA's Virtual Command Queue
>  - AMD vIOMMU's Command Buffer, Event Log Buffer, and PPR Log Buffer
> 
> Introduce a struct iommufd_vqueue and an allocator iommufd_vqueue_alloc().
> Also, add a pair of viommu ops for iommufd to forward user space ioctls to
> IOMMU drivers.
> 
> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
> Reviewed-by: Pranjal Shrivastava <praan@google.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>


Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>

-Vasant



