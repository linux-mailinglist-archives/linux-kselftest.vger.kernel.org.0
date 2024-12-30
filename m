Return-Path: <linux-kselftest+bounces-23784-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A38DE9FE327
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Dec 2024 08:14:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32D4A161D65
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Dec 2024 07:14:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17F0419E99E;
	Mon, 30 Dec 2024 07:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="S1pvzUwV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2074.outbound.protection.outlook.com [40.107.220.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 807DB158858;
	Mon, 30 Dec 2024 07:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735542871; cv=fail; b=TfrrynhMy644RTAGre52+ie7DyXizdMIuXtRZOYpzyIX3N3skoC4KNkpiZAd1Z4+D16KvOFTJlreSRaLK5u31X7NS+n1qwYLgyl+Y4LeXKGTKdpgywaQ8sAaRe74UMN0yJX5WMWsPZT8yQ3T4pARkoYrBsPGcaTBTYGJJnCN6Qw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735542871; c=relaxed/simple;
	bh=AD7EVuAAu6Aol3gibCE5Txs7VZRZh4PVOTNZbz4v5bM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UWqytR+asz99zTpDEDef23Pj/kqJitICPaXnpVucMQJXvejHIvSDbMy7pZ4iaB0OEpMmPAw4X4JDfDxeMIyIFQU9keExvaJV3idoFE7Pjdj1KC222qYfPSkMyz6KIgVBx2aVYHtmsICdau+mdxwc5Dq7gA0LLY1728U9+xwC1SA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=S1pvzUwV; arc=fail smtp.client-ip=40.107.220.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YQPlst2NaKEGKc4u+yP7hQnp2r9TvSMaxchNO3T54A5gEALE1CYKa30bPAZB4Si028JajntgHHgQ/HQFaNv0ET1VOC3tKSYzckyLpjW6b7HDtJyc0yu45BsODMFD9ei627/wpQXI2gNvHQGXRDTN0C1wq5th6pJeWTyLQ30XwzdXd/PZbBVo8+iyMnUoM2JQVGwYgdOwfVhCFB73aXtQ3beXwhXfDJWBpD2n1yFEWMneZRzOQ/kQFNwLoBdbh+/8PckMLHHbL5pouDajCyoFGdqA8cv4IZJLGbxI3QMut7/Yk6GbkXsNiM1AQK190B9QzajfQrnXrjQHQGEfPKhqkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jJvF1vVAo0JYtJtRimdBDvzgOoqbRXC/TSQw0GWyNQ4=;
 b=mLMPA9OK2DZa11Iev7CWzNQi5SjhAMqkZ27skCENr7ihCWE/mftt6SOYjJO1OQ6Z0bnaNl7R4pD/NA5YeE1w2t3Gu5SCs/aS6jcNHs/7YixD4iNViZj0rtueM6PYzSLZkUUqBY2agoynH8xKG3ecFfu413bpvydAA3oHsGfES+t1Id62sOBIwL/ZbehxTXXc8mrUuU4tsObZIbpm0tt035FHzThP/+lU+ufhurTS23ODPmXExfLV0/d5NxiZjYenNnaRwoG9RH5aEcU1B+KgWejeplg51wevNsVIZeyMFV/NecGSi9igY3iDaWmsEFdDFPFS3aMOJiI1xW1Lld8Jug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jJvF1vVAo0JYtJtRimdBDvzgOoqbRXC/TSQw0GWyNQ4=;
 b=S1pvzUwVAxTrr3Jll6IEQrPQY71g4T1eUEyBQ232rJRL4cH4DOr61RvVs9w6F4Ksn0HDqh31gRR22Ea9+nOpgRkzp/GZDZXFu/gxIMvgwmgkAE3Q8hbtIp3nycDSs1Y7M8h3mznr+QrkvKaTkCHNZ+OJIh/s2HXVBXopqi6ccCI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6214.namprd12.prod.outlook.com (2603:10b6:8:96::13) by
 SN7PR12MB6742.namprd12.prod.outlook.com (2603:10b6:806:26e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.16; Mon, 30 Dec
 2024 07:14:23 +0000
Received: from DS7PR12MB6214.namprd12.prod.outlook.com
 ([fe80::17e6:16c7:6bc1:26fb]) by DS7PR12MB6214.namprd12.prod.outlook.com
 ([fe80::17e6:16c7:6bc1:26fb%4]) with mapi id 15.20.8293.000; Mon, 30 Dec 2024
 07:14:23 +0000
Message-ID: <212c4adf-1443-42f3-b4cf-161154039174@amd.com>
Date: Mon, 30 Dec 2024 12:44:15 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/4] KVM: nSVM: implement the nested idle halt
 intercept
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
 pbonzini@redhat.com, shuah@kernel.org, nikunj@amd.com,
 thomas.lendacky@amd.com, vkuznets@redhat.com, bp@alien8.de,
 babu.moger@amd.com
References: <20241022054810.23369-1-manali.shukla@amd.com>
 <20241022054810.23369-4-manali.shukla@amd.com> <Z2TB94Ux5mOlds3b@google.com>
Content-Language: en-US
From: Manali Shukla <manali.shukla@amd.com>
In-Reply-To: <Z2TB94Ux5mOlds3b@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PNYP287CA0007.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:23d::12) To DS7PR12MB6214.namprd12.prod.outlook.com
 (2603:10b6:8:96::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6214:EE_|SN7PR12MB6742:EE_
X-MS-Office365-Filtering-Correlation-Id: bab89057-8a85-4a65-ab8b-08dd28a1961c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dHZLbENKVjdVTFpHOWwrMnRDU2VFU2hIalJuMXRYa2EvS0Q3bmhwREI3Zyt1?=
 =?utf-8?B?cmxSWXRIY2pPRGFiS3ZCa3FCYTgxOWw4OXdocnpadk1mT1R4OFRBRFJWanJC?=
 =?utf-8?B?VXMwVjFZcUJidXdody82R0EwOTFsRmlkU2ZqNGxacmluNnFhVGxuc1hUYjJt?=
 =?utf-8?B?eFJEb1FXR3E0SHVGQitSUm1JSHRsdksrQmZhOFpUb2JDSWVWSjY2UFNGdnVu?=
 =?utf-8?B?OVA0N1BxZmlhb1VTbnBoVC82QlVtSlNicURwYmV1Uks5aDNWWFNCUUE3WDNM?=
 =?utf-8?B?UnozN2I2a0pna0JZN1NWMldvbU9EWTJmTzVpbE0yNDljZUp1TnJXZGNvaysy?=
 =?utf-8?B?M2hTNVZXeUpCY0JaRlh4UWdZZFNBVWd1VHg4R25LcWMwT3BqbG5nN1VqOGY2?=
 =?utf-8?B?bXRxRWZsRUg2cEVzdjBmTEtwR1F2ZkJVMEpWdU5YV1oxSEtMM1ZHRWo0NzdN?=
 =?utf-8?B?dUFPNUFlbmdqNUt0WWxLVDRCQ0dJMUtZNVY4Mi9pMm5sMHZtSzdaMVZ4VFJm?=
 =?utf-8?B?RkpmS3pmZ1hjVXk4UW1JNEdNV3RmeS82NHI0Q21XSXREN25rd1ljQ2F1cGZV?=
 =?utf-8?B?cllBaVFKWVlPYVhtSXFMZ2FwTU01UW9ueEJOU2piL2VBNmUzNXJsRjBQdXJh?=
 =?utf-8?B?NUNHcUZwcWJ4Z1N0c0IrWUZ2TUxkSUhieW1WcDNtOTVBNDNpdmVpVktIMTZZ?=
 =?utf-8?B?VmZ0R0VqeElaU0Y5TnUwbUtLUnVpY01CdWhwVXVxME1ZdG12TEtTcWhZZGgz?=
 =?utf-8?B?L1k3WXlqS05DdTBGWHhDOGU2aFBmdENzVXJ5Z1JXM3QvYnRlK3A2em02YlF3?=
 =?utf-8?B?SzNaeEplN2JKQzhjZ2FtUjk4WmJEYmlPcmFERXFONURJRGFqVzVvUk0rdjVh?=
 =?utf-8?B?YXUwL2ZWRnVFUG9uOVVXeUp5QTVSSGpEVXF4SzJ4dkowbXhYclF6MFF2c3U0?=
 =?utf-8?B?V2lDQWVPQ2orVkhCR3VKWVY2ang5OHlBUkI1Z0dBOHB3T1ZFS3M4Z21mMnBD?=
 =?utf-8?B?eC9PRHdaYm1QZnpoWXVrNjRHWlIzaUVXQzV5WnV6Wi9ubmhlOEFZYWpHdTQv?=
 =?utf-8?B?THRBcG9aM3Z4QkxEYk5DZEcxRTBxUlRsTFRZT2RsL2E3V0ZQSEdJZG9vbE9Y?=
 =?utf-8?B?UllCb09PaGNCSkRxSFdKRlNJaEF5cUtONnF6Z1ZWU2J3dmxzT0s5TlJheURW?=
 =?utf-8?B?ZUE2YjFhbTN3VVAxWHZTcG1RSHc5M3ZSOFY2Nkl0LzlRVkF2bndWL2pZcS9r?=
 =?utf-8?B?YU1Kdkh5N2t6QW55Z2FSVVlZS0ZYaEVkQlZoY0RobUpOSHlTY3VpUG93cEVJ?=
 =?utf-8?B?V05mcXQxc3BBUm5zd25wWVpnSmpHLzBwQUJDSW9JRjV2SFZsM3V4Wi9EUkEw?=
 =?utf-8?B?eGJ5UTE4bDJyVVU1dmExczBTejVJRUJnTi9rem9QQ3diLy9KVFYwMTVjaStE?=
 =?utf-8?B?NmlSRmR2cTBIeUxLZzdCTGRrWGM2dndHNDZNemRMU3lTUlIyellUZzZ0eTZa?=
 =?utf-8?B?TnZxTGkwVEw0aXBVWkthQjJLQVN0Mzh4ZWFvSFdXa2VrVEpoSWJiREZNT2k5?=
 =?utf-8?B?K3loVUV3Z25XeEVUWFFYcG8vK0FWRTFnSEprR0hKcm9hNlhDc2l4dFJOZ2tr?=
 =?utf-8?B?VTNjZmJWdU1Pb084MzBvazV2UW9mVWVvM0JQRDdITTFYNDR5SWxaUDc1UnVl?=
 =?utf-8?B?d2FnaDNta1NwaklBcGVTMy9PM0NhMGFWeVJpaEZZUjZhOGpieGZWaVk0SHBZ?=
 =?utf-8?B?OUh5Nzhrc2hGWjlRcTlpSkMrQnVaZDBxQjcxSExmY2k1TW1tNVEyUVN5TUV1?=
 =?utf-8?B?MjQzQWhRbDlodkNYWU1qNWtONHVtYkxNdnovV0crSnRqYXRyTGlMdUMzTHBo?=
 =?utf-8?Q?NlsdtHgo2dBNm?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6214.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cjNBOVBaWHo4Q2Ryb25XS0FjcHdXd2tkZmloeEJENmFXcWlQWUhNYWR5eTk0?=
 =?utf-8?B?cVlBWXJEVWwrT2JiKzhaY2wrNXhnMS9Ya2IxdkR3NFJiU1djcTdYU21mcGt4?=
 =?utf-8?B?dThWL09Yak1RcXhMa3RYY24wUWRCZ3NhdENjeUZyT0grY1QrRXcwZzEyZjFa?=
 =?utf-8?B?Wi9xMldCU3lkNTJuZnp4MlppdjJuUHkxdVpWYjdyRmc3aEYwRnZ6aGNRMGYv?=
 =?utf-8?B?NGMzZEhINkJrR1IrN2ZlbmdnTW4xSG91ZE1LQnFqblFORXY3OTJKd3VsWUV0?=
 =?utf-8?B?N2dlNnBSOE91ZXUzZDRSY2pzK3BFdHBFT1NZVDJDUTJpeVFlOXR3SWxZZlZC?=
 =?utf-8?B?K2w1dUVSQ0x0QlduN2NVSlM4NHArU2ZMakRsdFprRlFIYU1IWUtISlpSZlF0?=
 =?utf-8?B?V0tUalVCbi95THJDc1E4K25uK1BSa1pqaXdJTHdyb1Z2bHd1aHNvWk85eVEx?=
 =?utf-8?B?NGQwa1BMN0FZWkNBeENkVURqMjlIZHFOc2gwcnBRQXpqT3BLdFEvQXdPVHp4?=
 =?utf-8?B?WlZRZFhzUEFmRVgrTVNDNlJveDhRMk5LWURiZ2RsTE91NTRqME05K0MvMEtv?=
 =?utf-8?B?bkZwMVpkUVUwWEpNNDh6c0FaaGN5aVFENkZhUjJvS094Tzc5bFBoQUZkdFc2?=
 =?utf-8?B?SUQyM0JuMDBEUHRNVTd4b1F0YndHaW05YllIZFNJbjBnclF0cGJ1U1Z5NXNI?=
 =?utf-8?B?Yk1BVXROZSsrdnU1L3djQS9DdXVqUHZqRThXMG5oTExKSk53QWtHS3o5NERw?=
 =?utf-8?B?QnJrei96c2NIU3FFazFrM29POTdSN1ZqWWkwUnpPa25zbm5YTE5XWEVKZDdM?=
 =?utf-8?B?YUhtQk1seUtpK25WMkIwaW1Yb0Nja09tSjlDSE1TTHp1S3J1bXlpUHNlRnVI?=
 =?utf-8?B?dCtXOHMyYTZWZ3RwWFFyTEdsSjViZ2FYQlpISVdFMnYvc09DMDNtU2JpQkx6?=
 =?utf-8?B?b2oxV2xCYnFtTUR2VGowYWNodWw0MWMyQzYzZUpEaXRqZllpYitGYk1IbSs4?=
 =?utf-8?B?emFGbC9uTHhjd1dLNHdZRXY1RjZyVmw0MWpVYklXdmNPSEFMTjE2WHBpbGZk?=
 =?utf-8?B?aDdLbW1TQ1l1THY1dk93YUpuclpyQ3RwRkZnS3kwRnpPNCtycjQ2M2RxaXNL?=
 =?utf-8?B?ODhGNGRNTE9CQWxSQ1d4MGpFVTVZRHhNSG1HTnU0YkN1Q2VQMENoT0VTSlRh?=
 =?utf-8?B?ckFTVEpkd1BVTDltVlNFWnhoWlFQSkppRlBLazVGMTU1Y1dGek9LOTlTaEMw?=
 =?utf-8?B?eXFpZnVYaTVYcVFwcTBlNXp0KzhXWUx0MitFbFhjQWU4SVl5NGNZamh2d3Vr?=
 =?utf-8?B?dXBhMTQzdGk0VGlUY1Jud1VVa1lBSXZ3R0cxaHJIN1RUNUxiVkxObnd4RVdT?=
 =?utf-8?B?aCt3RjlYZ2pPSDRlY3BFeEt1dVVSbkNUVWVJYnNGNmwxSXdNRjVxOVd0eXdY?=
 =?utf-8?B?bTJwUGRScTgwb2pSMVNkSmtpSU00OHZVdmVrcjNFZ0h2KzVqNjNhWVlwdkk4?=
 =?utf-8?B?MDZ5aUF6dCtPQm1aUmpQNW5iYzg5ZVcyMVcwTXUwd3lNd2lUSERzMHdLM3Z3?=
 =?utf-8?B?RU5RNGo5L25aQm5GV3U5ajQvRWpKNWU1ZWRlNTNLOVF2OEVpUUFjMmZ2T0Vq?=
 =?utf-8?B?R3JBc2RZdHU2SVRiVkpEU0RYSzhINTNhaEZBRlpSRHMrQ25zZUpWUHFTUCtN?=
 =?utf-8?B?U0hOZEQwOGg3OHBzRkRrWXQ3UlZtS3BuVzdvSThKUW1qa2lFRnJJUmlrMVow?=
 =?utf-8?B?MTRGWHc3S2dnbFBxYmloQmk3b1UxR0lFalRDdVBBQzBENTUya1hNT1g2Wm1n?=
 =?utf-8?B?VFdCQnhJMCtUVEJLSGZGZHVpTFNvV0lUZzJSV1JRTWlWSnRPNkFXZURIZWt2?=
 =?utf-8?B?NFFnNXRTVkJVSGRGYVg1TnY5ZC9aaGxnOHJOLzdHWGl4eENFUmZDa0xZS0Na?=
 =?utf-8?B?ck94WisxaXY3OVJxQTRqTHM5eUxtMmFkWVRDaytydTl3elRqQW5XcnhIK2dp?=
 =?utf-8?B?ZEFtRG1na2NxU3diN1FmeUhuaDdoUUtTZFpyUFZtTHFIYzZWZ3BGOWRQcVpW?=
 =?utf-8?B?SFFKT2d4c0xQUit3SG9hbzB3K2praUpSVm9hV2dRNlRvNDIrQWhpMlJYc2x4?=
 =?utf-8?Q?WfzU3DCgFIai4Mj/PJIMy7l1F?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bab89057-8a85-4a65-ab8b-08dd28a1961c
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6214.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Dec 2024 07:14:23.3387
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0cRgN3cpDdCU9YHRAsFplCW1FUk/MeWFVNe0XngTO8TRCf7z6C0Qr0rKheJed7kN16VVPTF1ye2i7qaa654rEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6742

On 12/20/2024 6:31 AM, Sean Christopherson wrote:

>> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
>> index e86b79e975d3..38d546788fc6 100644
>> --- a/arch/x86/kvm/svm/svm.c
>> +++ b/arch/x86/kvm/svm/svm.c
>> @@ -4425,6 +4425,7 @@ static void svm_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu)
>>  	kvm_governed_feature_check_and_set(vcpu, X86_FEATURE_PFTHRESHOLD);
>>  	kvm_governed_feature_check_and_set(vcpu, X86_FEATURE_VGIF);
>>  	kvm_governed_feature_check_and_set(vcpu, X86_FEATURE_VNMI);
>> +	kvm_governed_feature_check_and_set(vcpu, X86_FEATURE_IDLE_HLT);
>>  
>>  	svm_recalc_instruction_intercepts(vcpu, svm);
>>  
>> @@ -5228,6 +5229,9 @@ static __init void svm_set_cpu_caps(void)
>>  		if (vnmi)
>>  			kvm_cpu_cap_set(X86_FEATURE_VNMI);
>>  
>> +		if (cpu_feature_enabled(X86_FEATURE_IDLE_HLT))
>> +			kvm_cpu_cap_set(X86_FEATURE_IDLE_HLT);
> 
> kvm_cpu_cap_check_and_set() does this for you.
> 

Sure. I will use kvm_cpu_cap_check_and_set() in V5.

>> +
>>  		/* Nested VM can receive #VMEXIT instead of triggering #GP */
>>  		kvm_cpu_cap_set(X86_FEATURE_SVME_ADDR_CHK);
>>  	}
>> -- 
>> 2.34.1
>>

- Manali

