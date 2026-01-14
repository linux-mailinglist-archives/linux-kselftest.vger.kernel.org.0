Return-Path: <linux-kselftest+bounces-48901-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 68FD4D1BE31
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Jan 2026 02:09:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6EE123011AB5
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Jan 2026 01:09:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA88D21D3CC;
	Wed, 14 Jan 2026 01:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dR4I7KGe"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012031.outbound.protection.outlook.com [40.107.209.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 688FA1B6527;
	Wed, 14 Jan 2026 01:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768352981; cv=fail; b=FEXuteKp88BPXo6nlwVyxN8QIz14HLMWsngqc/S6iQdyULVhJ5au2y5DKheUvBTxuxx4vPZGgaA7YhmpFqoKCpsal5T7cY8BPVFQramEMGi8FH1g5WeDffIRhdk/QC/eH3nNh3id/XMxRVFkO8d2R7wApXDgDgIScO2VHlMOZ/A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768352981; c=relaxed/simple;
	bh=+Tfpqd6g2W0UiKEGq7roRaW7BGFnWssupsI2SlQREJ4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YOKzwQUSC7QX0pfnYtXxrrjLT4ehzMNdWkCCRnmpxfZ0gCuLGEw9ZlXB5vkT0QosgyxP37RM9OBBf52H1ZC3mIIyrtGXzHaQP1ho4ZaJKzcnv28JbN098IfI04z2qf/vSaHGTUXi9Xa3c34Khwx9nJ5tv0zRrjqvKsMtuShPEUU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dR4I7KGe; arc=fail smtp.client-ip=40.107.209.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XomNnSjVL4bPewhkYcSUNrQDFRUMZwuD7OuX1B5cUUqUUNZ8JqVUSJX01JYJ2Rv1YrkVP1RKYMufjlyUM06Vaz/sexHRksE0uGBTQkGbVHcsk4FzToHmt0R5y9VIUe/RIwH21CvrRgfB3GG5RwMK+3XSicrnrv4kc817eNOAH4l1Yj4LPXkaQf6q5fp9e4TWeZTi3Ilctoc1fEmhTiGYHGGWyiAhqwU8PvfsPCICiksNCO6JXLdfkYDUcPP9necbDCKR3lDBPwKFFYReQSU2xBu8Ib4E4cBFX3ik5/9qwpOp+N2TWM++g34TGDZUcsvVDmWI/MtQJlPz1KFR7KDDHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZrJnir8apQCgMu+ZqY/2i81zD9O28k8bJV9RR/44wQc=;
 b=YTMNu1h5CmA5wNcxuUjHmUk13/SZTRIo0336DNf0WfMirbV+ML8vx6E3FAqulWDuj2z0lUnJGQ+t0AngkGB5U5s0y9OtdIy6DDFrXtHQ/9Sba8x+NQNBrnM9+lPyj33/MA/Dr7KS3wgHJe695FPB3fUVXlT+jl5HYmCkTY3iv0vkjYBwj9R7NwYeCxf7rKibBZBVNFCPMNCH5VJbe/Ts5vnkTMhIeGCpMrodK0GfVBBnQoMwzxKJcrrz3M6V0sE6tW+y0gqXCHCz1sLcoYiLytCY8V09axSQxde1JRi1WPvZypR8z8rX6fRySZhTLeA8i2MHyWrQlpkS+1vyNHeAaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZrJnir8apQCgMu+ZqY/2i81zD9O28k8bJV9RR/44wQc=;
 b=dR4I7KGevAe6oPQ2sJniued7vDtvhnPaapDTsSWCRShfL5BRravVOiJtxe0WwJywjeR9+r8JLS4WJAWSsTPLIQNyzfzyIZxRzR3dbolJEtVRwTCEgOlb5KbMutlzMNIxTGgrH+IBW2g+xvmkepcP/t2KJ2Wh4GFe4+287RxKJPYD7rlpCeFpPmkdcZx6bQuHnD2xTOPo09Ux+5kwUp12U2z1gswp29e+56RtY/bRSxI8tMIlijCiVhgEQVlyyqKaIn50tXN7tVH9ICd8Hq9VuKDpbb/PReHbVAq/TRZP9Gj7V+0UBbuRjGQ4+FXmOEi6+D2f2Pu4mRu1KRTtuSVl4g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by CH3PR12MB8657.namprd12.prod.outlook.com (2603:10b6:610:172::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Wed, 14 Jan
 2026 01:09:37 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%2]) with mapi id 15.20.9499.005; Wed, 14 Jan 2026
 01:09:37 +0000
Message-ID: <654e3bde-764b-49ae-8faa-bab8199b1f15@nvidia.com>
Date: Tue, 13 Jan 2026 20:09:35 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next 5/8] rcu/nocb: Add warning to detect if overload
 advancement is ever useful
To: "Paul E . McKenney" <paulmck@kernel.org>,
 Boqun Feng <boqun.feng@gmail.com>, rcu@vger.kernel.org
Cc: Frederic Weisbecker <frederic@kernel.org>,
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
 Josh Triplett <josh@joshtriplett.org>, Uladzislau Rezki <urezki@gmail.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>,
 Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20260101163417.1065705-1-joelagnelf@nvidia.com>
 <20260101163417.1065705-6-joelagnelf@nvidia.com>
Content-Language: en-US
From: Joel Fernandes <joelagnelf@nvidia.com>
In-Reply-To: <20260101163417.1065705-6-joelagnelf@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR08CA0016.namprd08.prod.outlook.com
 (2603:10b6:208:239::21) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|CH3PR12MB8657:EE_
X-MS-Office365-Filtering-Correlation-Id: 4dbdfb9f-8c81-431c-919d-08de53099623
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NkZDcnZ1bDQyN1BndmtGU3E5L0IyWlk4Q05ENFcwKzNXWUFJdXY3ZytZRHFD?=
 =?utf-8?B?c1dMeURuWkQrekxjbmhDNHI0d2ZmeEpoWFNFTEMwNHIrWTRpS01qcy9KV2xZ?=
 =?utf-8?B?T0s3MUdZejFvdTZ3b2xvRVdXM3FUSVg1blpPQ2c1TEZyU2dNOFB0RERVQ3Jn?=
 =?utf-8?B?L3ltbndJNjdzUXZ2OVdrQndKTUx2VmkyYmJkUFRiczc3L0VGczRqZGpQY1BB?=
 =?utf-8?B?TnVkeEhqMFhKZ1dKZXcycjBqbUczUk9QQUo5L2FyYVdtRzlnSEg4d3hTeTl1?=
 =?utf-8?B?MmZnKzhTQ2ZaQ0QrWUpYZjJGNGJOVzhlOE5FanhSSUVXVlhFeTZwUExMRkZk?=
 =?utf-8?B?RHM4c2oyVENsWEg0R1ptTUJBTnMwR2owVmFRS1p4SkZrN1hYV3g5QjhpUFFl?=
 =?utf-8?B?ZFdFRjdVbFRrd3pGQzF6anJMcGlZc0czdGltanl1SkF6RHZXZk9EQ1dHMk1P?=
 =?utf-8?B?NFMxZkNoYVQ1cWlyNVNsUW1laEs3c2lFczllbXZ1VExEVlVtRHgrUmtOSlZ1?=
 =?utf-8?B?VU5CM2V1S1E0TUo2ZzFwbjZJUnZqYnMyY1pwMjZ6MktxaGFMU0dVM2lxMC90?=
 =?utf-8?B?UDlqWHkyaG1BcTc1NU0zYnJITnFZenpYS3Q5ZExROTN4WTJLeW1SNm5iZFhz?=
 =?utf-8?B?TU1nM0pSYm5DUW9RVXpEZVRyNTRMWHVpelpGRTMxYWJTQkc2dms1NHFiQVRw?=
 =?utf-8?B?MjBqd1ZTMWY2UHcyZ0xQSUFMeWtUSm5pbGNqbG1jU25JR3NDbm1vbjNGNStz?=
 =?utf-8?B?Y3hnVjZJRDhSVkFDS2F2UHR5aVphYTd3RlZlaUM1MGhoVGxiWEszQVVaUTI1?=
 =?utf-8?B?bkF6aXF3d25ERkhlTkIreVg2Vjh6Rlg2Uno4ZWxtQk5ZeWVkemNXYjM2TVZW?=
 =?utf-8?B?VUZBYXhpa2NIRGZlQURpSVRZdkMxU0pXa2lEM3Bhb1czVXVMWHNTNzdkSWVs?=
 =?utf-8?B?RVRGaVRzQmxGdGtXdWExNTNpK215MysxUHRBaEQyQnlqS1lIWUQ2NTZnYnZo?=
 =?utf-8?B?UmlFZ2VJajh6MGJoRll2Q3Q5RzRFQSs0QTMrU3hmcElyTFA0cDJOaVN0bDE2?=
 =?utf-8?B?cnB6TmxsNEd5Vm52NkF6Q2tZeGN2OWdaeGVIaEJNalZzWW41RWFTVlpoZ2ha?=
 =?utf-8?B?K1BQYytod2ZvbjhzMkNTZ2hKbXFrQ1ZFYVE5cHdlYUZiNExHcDJ5R1VWTmxo?=
 =?utf-8?B?UDc2M2pUMCtTQXJVWGU0SmdULzkzVDcrSUkxd3RDM2JDK3VSRzV6cHQ3TG5x?=
 =?utf-8?B?R21Zdit1RGN1Vjd1bzIxSTRQUzdBNHBKeTBCdWJlL1JoY01TT3hJUU5Jb3Ar?=
 =?utf-8?B?WVFYbmJaRTdWSFRYMGJWbUo5UUtJREhTRkVLV3lXRDI2Zi9NZ0dWMHdHNmcv?=
 =?utf-8?B?SVhDZzlpQ3pNR0xGNzFCRVgraU41ODJDblNtaFVoZU4zbTBYSjI3bGZpQitE?=
 =?utf-8?B?SzZlZk1mNyt3RjJlR3N3NlBsSE41R25JUk9CT3FLUTEwZnRGb1A0dXVOczBE?=
 =?utf-8?B?T0RjN0Y3NkRTRzk5TXhCcW8vczdZWGFCbHVodTBrSFFJdWtQTHhyTW1XN3hY?=
 =?utf-8?B?S1VXeTV0cjRjeVZrakxmdTNvZWlURTJZN1h1R1R2bTJxcEFRSW9MVlQxQmd0?=
 =?utf-8?B?UnpoWktRUXFRWmxqWUpFR3BYYTdDL3ZXN01tNkVVbXlWaEs1UFhPRDZCUmYw?=
 =?utf-8?B?d3lMWFY5Q0F3NXdvVCtHRjRDRmQ3aGhpOEgrTUJPd1F4UjhBNkF6SGV4TFR6?=
 =?utf-8?B?RXBSNjBDM1pBbVRaay9RU0lSQkIzKzR6dkFuUGZRN1pHUkptNGNiV2puWVFn?=
 =?utf-8?B?WkxPZHltbmI2Vm5rZWNOMkV1KzVBREpZTWFjTjUxQ0FlaFk4Vm9nbmxIeDd2?=
 =?utf-8?B?MnZFeE5zcDYzd0UwR1FmZWFxTEN1RmlhaVJ2cEV5ZFhKU0xva3NQOWRWNEhN?=
 =?utf-8?B?cmFQVHM1dVNkYWdlKzJxc3JPTkxKQjRmNkZVcFl5bTNRV1dwR3NseUo3R00v?=
 =?utf-8?B?QkkyZnRZTDRBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YXRWNVVzMkNTRzVqRVJaMDhyay8vQ3NiYUIvZjRncjRUVkt2YkVaNlkvQWEw?=
 =?utf-8?B?bmxLN2xuVDRJS1FKN2N4dGJsRmJ0akJSMDRmTm5GM1VqT0tyNE1McDBmVWYr?=
 =?utf-8?B?UStpK0RpWVA2OEtzVituYWVkdWMzTkhjYmhGL1VyNWFDeTA0VlhnM2NyWVNB?=
 =?utf-8?B?SmU0TnRIZEtqV2VvRHYvSk5GTVQxVXZqMEtNb0JMSnl0aHpBRWNwdG9zdmth?=
 =?utf-8?B?T3F3cVNhbThIaFFrYmxxRWVUbjhReFkyU0NDdzJkdlZNUFVudGxnN1F2bWg5?=
 =?utf-8?B?d0hROC9WNkdQdVc2QkxYck9CKy80d2JZYnpoci8rZ1o1WDEyalZqVjFyODZr?=
 =?utf-8?B?VG5hUi9XSHcvQzlMb0dDa0M3RUdPWFRyY1dJaHNwbjBvUTFJTi9TYVFRbnJG?=
 =?utf-8?B?MHRUUlJEa3dDUXFjTWZyN1oyKzRRQVY0YVJuR21pdDhJY2FybmZabTF2UUR5?=
 =?utf-8?B?bjRVRnY0KzV3czhKWGpQQUhvQU5XV1B3cjI0YVBjSGlCS2NocjFLOUlSUHZU?=
 =?utf-8?B?ZW5MVVpEaFZNeWJHVHZ5LzhpeUF5d3E1RTNOb3BBaGovN1NKK251elp1bjlv?=
 =?utf-8?B?UEpqYXgrcGc4U25Lc0xWeWNHbmdXYVZqRGV2aGFtaGtqSnRBeFNJMTF1NEZK?=
 =?utf-8?B?cjI3WUowdmx6OVk2RjVCRk1tY2VsQmM5elVBS25nbWRSY2YzT3puTWJuMW16?=
 =?utf-8?B?S0xKT0ZJUkxkUFV0N2o3MTAyT0wyd014REtMRlpQL0hYV2ZBck0wR3JrUjlV?=
 =?utf-8?B?dVEwcjJNYWRKMno4Z1g0bWtYR0o2QnZHSGtPcDY2WkF3TVVZOHJ6SEpleGl0?=
 =?utf-8?B?ckRKeWgxcEtHQjhnRURPQkpySDRieEZiUk1DaGZSN1hOeTh6SFFZK3dpVFZX?=
 =?utf-8?B?bHExOUh2RWRZS3c5dG0yYXFWV3BFWEVoR0RUNTN2b1RDRGRaRHpOSFl2UTNT?=
 =?utf-8?B?M1ZOV1JpSTNMNGZ4eUFNam9RWGswMXA1V1lLOVQrZENPNnJFQ2J0UDBlaFlT?=
 =?utf-8?B?dGh0aUQvNXk2N2dkb1p3Z1VkcHhZTDVmY2RMR2xuNjdzTEtPUGFrQ081dlBy?=
 =?utf-8?B?UEYvbmdkOEdYbEVlWURFSFdVaEpubGVQSUZJVGxlcDhoZ0xSSWNhTkMzd2k4?=
 =?utf-8?B?VU9oVDZBUXVEVFExS0RBNC9BV0NBTkxwNDJXNG14K1ltMlpyK09URnlzcVNO?=
 =?utf-8?B?ZW8wc3p2MTdsaFEvUVFhWlhkVmRVeGRWS0ZybWpVOG1Oam0xejhLWGduTHRU?=
 =?utf-8?B?OVo0cGUvV3psdnhJWHozdytNRGtMM2ZpZy83RW9BREVQRXZCMEI0dUVGTmQr?=
 =?utf-8?B?OVd6aUNhTWN6MER2Q1VsOUZPNmNnWkFGYkVuNXRqVzMvdE52bWcxZWM1TkR0?=
 =?utf-8?B?bk5JN0h2K1pvaUswWFU0RXBmZkhsL3VyU0tHSXBucGRvbkMvbTlRRGQ4VkRp?=
 =?utf-8?B?OGJkdXhsN2ZHQnZFZ2NFNVJLUTBoZ3JLSXBBTlBwV1JBWXV1YmlvQjFEQy9Q?=
 =?utf-8?B?bzZvbkxuN1R2Q0NBNHBxeFQ5SHRxb0ZDNXZzSUs3cGpHbkdjWVViV1dObEU0?=
 =?utf-8?B?Ym1oQ3NGNWtHblc0ZjRnTWRBbzhiSFFyNkxUUGNQTmVSc1FIbWZoVUlRSk5z?=
 =?utf-8?B?VnBKanFDR2dDOU9hT1BNanNUT0Q0VDRTSEpwTThzSGVvVEd1QnR1RzVxQ1lE?=
 =?utf-8?B?UUNGMTk1UmkxUElQTFdhZ3FRNy9jTHNZcGU1cjR2aHFPQVNSbU1yRS9OK2Nj?=
 =?utf-8?B?cTJXLzI2dXJaMHJOaGpFNEx6ZDdVbjNXV3BDMmhFM1BuRG80d0tvakRhK2xJ?=
 =?utf-8?B?QlE0WUtNSDY1VWpCYkV6U29SbVNhK0drZG80ZStNbEJzWDlQMFkvd0h3ZGdr?=
 =?utf-8?B?MnhlV0lVMFNhUGlxdTNlRjZyeW01TU9NN0FyYis3S1E1aGR1dFZiL2ttcWRt?=
 =?utf-8?B?ckxkVm5QY2k2b2RKZWcrNXYranRjSXRHeW0ydWxydFVseWF3VDVwZFB6UHVh?=
 =?utf-8?B?VEFzM2RZV1l1ZGxsTXNncG5VaS81bUtXaXdMNC9rbnJsbDM1SkdiRlFCSURK?=
 =?utf-8?B?SXVaOGlOZmlmdlhpczNjMFVYZ2lwU2RMRExkMXpQaW5TS0wyNG9HV21lKzJm?=
 =?utf-8?B?ajdKYlpPNGdnODRrRHRGdk8xOThuUWNSUHRTQ3NLTFBTdEpTZzZyRDZUcmpz?=
 =?utf-8?B?YjFEdnJzNDJIRWV1OXhoMWdWUmg5Ukl0MHU1UE44R29nQkc0Mm0vU3djVFRv?=
 =?utf-8?B?R3Z6SCtUMUd1bERjN1lFWVpXT2x2ais3Ukwvc1k5emsyNk5DbVJrS3Bob0Rt?=
 =?utf-8?B?cU5KS29xN1prcW5SVW0ybitXMlVmN00vVFM0a0FFajFJYWNmWGFIQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dbdfb9f-8c81-431c-919d-08de53099623
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 01:09:37.3441
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fpv0Iv6njxeL8N2v11iJHn4zbg66oyge1s2YcSofwVAzmHTTu1j8A58P7LAo6zSJGLLr7EAVqkVYDOSRymM3Nw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8657

Since I am resubmitting the nocb patches in this series (3 of them from this
series) for the next merge window, I thought I'll replace this particular patch
with just a deletion of the rcu_advance_cbs_nowake() call itself instead of
bloating the code path with warnings and comments.

linux-next and many days of testing on my side are also looking good.

Thoughts?  Once I get any opinions, I'll change this patch to do the deletion.
Also I am adding one other (trivial) patch to this series:
https://git.kernel.org/pub/scm/linux/kernel/git/jfern/linux.git/commit/?h=nocb-7.0&id=84669d678b9cb28ff8774a3b6457186a4a187c75

Running overnight tests on all 4 patches now...

thanks,

 - Joel

On 1/1/2026 11:34 AM, Joel Fernandes wrote:
> During callback overload, the NOCB code attempts an opportunistic
> advancement via rcu_advance_cbs_nowake().
> 
> Analysis via tracing with 300,000 callbacks flooded shows this
> optimization is likely dead code:
> - 30 overload conditions triggered
> - 0 advancements actually occurred
> - 100% of time no advancement due to current GP not done.
> 
> I also ran TREE05 and TREE08 for 2 hours and cannot trigger it.
> 
> When callbacks overflow (exceed qhimark), they are waiting for a grace
> period that hasn't completed yet. The optimization requires the GP to be
> complete to advance callbacks, but the overload condition itself is
> caused by callbacks piling up faster than GPs can complete. This creates
> a logical contradiction where the advancement cannot happen.
> 
> In *theory* this might be possible, the GP completed just in the nick of
> time as we hit the overload, but this is just so rare that it can be
> considered impossible when we cannot even hit it with synthetic callback
> flooding even, it is a waste of cycles to even try to advance, let alone
> be useful and is a maintenance burden complexity we don't need.
> 
> I suggest deletion. However, add a WARN_ON_ONCE for a merge window or 2
> and delete it after out of extreme caution.
> 
> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
> ---
>  kernel/rcu/tree_nocb.h | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
> index 7e9d465c8ab1..d3e6a0e77210 100644
> --- a/kernel/rcu/tree_nocb.h
> +++ b/kernel/rcu/tree_nocb.h
> @@ -571,8 +571,20 @@ static void __call_rcu_nocb_wake(struct rcu_data *rdp, bool was_alldone,
>  		if (j != rdp->nocb_gp_adv_time &&
>  		    rcu_segcblist_nextgp(&rdp->cblist, &cur_gp_seq) &&
>  		    rcu_seq_done(&rdp->mynode->gp_seq, cur_gp_seq)) {
> +			long done_before = rcu_segcblist_get_seglen(&rdp->cblist, RCU_DONE_TAIL);
> +
>  			rcu_advance_cbs_nowake(rdp->mynode, rdp);
>  			rdp->nocb_gp_adv_time = j;
> +
> +			/*
> +			 * The advance_cbs call above is not useful. Under an
> +			 * overload condition, nocb_gp_wait() is always waiting
> +			 * for GP completion, due to this nothing can be moved
> +			 * from WAIT to DONE, in the list. WARN if an
> +			 * advancement happened (next step is deletion of advance).
> +			 */
> +			WARN_ON_ONCE(rcu_segcblist_get_seglen(&rdp->cblist,
> +				     RCU_DONE_TAIL) > done_before);
>  		}
>  	}
>  


