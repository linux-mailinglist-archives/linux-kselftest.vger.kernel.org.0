Return-Path: <linux-kselftest+bounces-26008-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C5D6A2C932
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Feb 2025 17:46:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CE863A2D03
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Feb 2025 16:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD10C18C92F;
	Fri,  7 Feb 2025 16:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="H5gpz/HE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from CY4PR02CU008.outbound.protection.outlook.com (mail-westcentralusazon11021142.outbound.protection.outlook.com [40.93.199.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B4B1161320;
	Fri,  7 Feb 2025 16:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.199.142
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738946795; cv=fail; b=URYloBEgt1GVa+cQkTt7UyfAieYXD2X5s5L8+OyVpXVyAgrMvldNOLFWq2dmFo8MBKrLW6tWcasYorm4qZcHttuAyRkMrU+xO8QHBrs3MB6MtNJJ3CjTXgl+Nn95+ZvHD6atWS4HNLmhMT9vzSATm6ivwpSuNahsA8NYLeNU3AM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738946795; c=relaxed/simple;
	bh=Cg8a4aC5gRigEJzLHY22vqaFtsH0xp1KlVTZ4ZxiSOk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=M+Dt/0W6eXtz6S8i5eph78ODuB1toinpeom8Zj7McPqmAAHHteQuemXu56H03eWNL+snKplCHVKnGGqed7NENcs7VetE6s2lt6C1v137+Ihq5PQMsdCyPwNtqkIhEDNcachZFAAgyUO7++dc5zJGf8fO2aRfypFg19P6V4ZZMMQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=H5gpz/HE; arc=fail smtp.client-ip=40.93.199.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y0PUT1aurGcRrRRJtvXipaDd5YHajafAKXKFN7JEdvRCHOgI4CPQCA+mD6LOowm2xJvuDgLSBGRyhgiHlXBjxHn27QVq3wJFCVMBlyRkWp6pq9f8htQ5mZLXdNymOOvVpOEgDHAfl/KtfdpBgQKq8GpQF9rQ9HkdtJWfz/ep0gWJgq/groZL28VNOXJyptBhvlaPxxFvW9bAbcP8bL8bMyOEYVDRUQhDuENvv0fKPD43G9goCRYyPMZuYzvUVBrapIth/HTIm/zt8YybwEPcF0zj/9rcaWMpprok+d0W4yUGi49eOF/U7rf5CysDjGV1u+AbzWFiS2h+0ZaZNmsS8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XB6ADwdVvX5r//lXjbd8nkkyGDNPLKgawYi3tkfZNF8=;
 b=lxV8Tw7Cvi2zOgsPBLt6MqopsqhFx5aw6Y0zPeX65/3C/paeEBZ+N8ju2uzfMrth2PcDWe2rKgLy5eraDppe4yydqSTH8pXmBmRdOiMlz0bdphTzEidDAr5+AfEwXfvIIRGDCuLiPlintGsIVXDxOIF8DloHwahILqqi180Zeg6ll2kog5dv8hV7Y4/RwgA+KuCvNmecPqnnUh4qdt+IQt1+l1Ry6BEi2dzxaHMYJwxfZbQcfRhVJZMZDnvJjJxRL9GdyOx1cYlEqa6hL/6ffPKFU30K5DSahyWFEFSsXfynSE5Avi1dDaLyMwiQ63mZtZzB+t0Fs5NF1p5sIZU4Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XB6ADwdVvX5r//lXjbd8nkkyGDNPLKgawYi3tkfZNF8=;
 b=H5gpz/HElHoFd5RPC9KNJvAdy9KVqV74KhlD8FFxfIv2N7Hno6UDI7M/A0o1oyHbovh6JwsXjXOdfWayvQW8Zd/4VllbkLBOQ6USRlLD+sjV9yIw35VsaeuXphbk46KLx9sOXJjqNw35T0tdfBVjb2pAXoSK22OKX77rLsVyQk0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SJ2PR01MB8101.prod.exchangelabs.com (2603:10b6:a03:4f6::10) by
 SA6PR01MB8832.prod.exchangelabs.com (2603:10b6:806:42d::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.6; Fri, 7 Feb 2025 16:46:31 +0000
Received: from SJ2PR01MB8101.prod.exchangelabs.com
 ([fe80::292:6d9c:eb9a:95c9]) by SJ2PR01MB8101.prod.exchangelabs.com
 ([fe80::292:6d9c:eb9a:95c9%4]) with mapi id 15.20.8445.005; Fri, 7 Feb 2025
 16:46:31 +0000
Message-ID: <5192ba8d-577a-4bd6-b8ee-7e3547f2c86b@os.amperecomputing.com>
Date: Fri, 7 Feb 2025 22:16:22 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/2] KVM: arm64: nv: selftests: Add guest hypervisor
 test
To: Marc Zyngier <maz@kernel.org>
Cc: kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, oliver.upton@linux.dev, joey.gouly@arm.com,
 suzuki.poulose@arm.com, darren@os.amperecomputing.com,
 scott@os.amperecomputing.com
References: <20250206164120.4045569-1-gankulkarni@os.amperecomputing.com>
 <20250206164120.4045569-2-gankulkarni@os.amperecomputing.com>
 <86o6zeu668.wl-maz@kernel.org>
 <9b4a8665-4fb8-42e7-b63f-d154ae75a4f0@os.amperecomputing.com>
 <86jza1ua7w.wl-maz@kernel.org>
Content-Language: en-US
From: Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>
In-Reply-To: <86jza1ua7w.wl-maz@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0037.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::9) To SJ2PR01MB8101.prod.exchangelabs.com
 (2603:10b6:a03:4f6::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR01MB8101:EE_|SA6PR01MB8832:EE_
X-MS-Office365-Filtering-Correlation-Id: 56512a6d-5884-406d-2c8c-08dd4796f94a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M1BpVmhWNlE2UW1RTXFXQ3dySEdmd2I4SmRaK21mMGpOeWtTTEJibFFJaVEr?=
 =?utf-8?B?cFBrcVlOQ1VHbjBlOVcwMG5ORHJTdkE3ZFVGLzJyKzEyU1loZjlTdzc2QldL?=
 =?utf-8?B?WDM1WnlodzhJb2pOMWkyTDZld0JRWEdWMzR4V2ZCajJqUXUydER0TVlPRWxu?=
 =?utf-8?B?R0xhQ3NNVDdhTnAzQXMvRlJoRnFCcHhBcjh3Y1JmMjFkaUZUa1Iyd0xrZkZ1?=
 =?utf-8?B?U1huSmppNldBYXNuVDdsM2JtZ21WUUdERHpCRHpBY0VBSkR0NW9ySkZNM2kx?=
 =?utf-8?B?YUcwRmFONU1Qa3NHZENXTHloR2VyaHd0S1krRWxmMHorV3NTMCtadWpmcHk0?=
 =?utf-8?B?eWpBa2Q2NzJpSG5oMXFtWHhxSmJSZVNlQVc5Nm1HcEh4dTBJMVo2R0htT2hl?=
 =?utf-8?B?R05uSnYxOFp1UWU3K2xST25acW1LeEJkalphdDIxV3pvK2l6eVhlT0FHTFQv?=
 =?utf-8?B?K1c4bEdnZWVNMTNtNXlVa0lMbTY2Yi92c2Y0NnpxVUNxUnorQzk2WFBzelBs?=
 =?utf-8?B?SzB5Rm54MElPSld4WWJad1lxd1ljOTR1eFYwTTRibWRrNzBhZVArU2ZWN0R0?=
 =?utf-8?B?STlKTE9DQzFKMGZzTW5kY0xuWHNRRTVGdjRUaDBpcE05ZnFxbUZHNG50ZFov?=
 =?utf-8?B?WkRXRytxbzV2QzRYd25hejFuYnhkZThrMEN1dHRFaC9XZkQxTFVoL0hkem1s?=
 =?utf-8?B?cElkd1BKNmJiMnZSRk1LVGZlZ052aGRTWi9GR2sxRnNReUhWZEl2LysxZjhS?=
 =?utf-8?B?aFR1Q28rNkNHbktWMmtTQzRzYjhzZG4yWUJzdFRXb0ZMeWFnNVlBc1lyZGMw?=
 =?utf-8?B?MXhmWDV3UWw1NFBySnNDekJySU0rOUUzOFZlc1NaL2E3OFFsUGZkM3g0OEgz?=
 =?utf-8?B?bGpDYWtxdWgrS3F3SW41VUFZNnlaa05zNVRQV1lheDgvengvVElHUlhqNUxs?=
 =?utf-8?B?VndST0pPNXVEUEpQMkdNMUdyYnFTS3lzQTIrd3dCcHlCUDJTUFcrY1VtVnBC?=
 =?utf-8?B?WVVsQVA0RHlHWVVNTGl0SWwzUXByUDlZMjdyWHhLVW1QSUY0cGl4QWpuaExx?=
 =?utf-8?B?aDk1N1JxUGFOc05SQ1pweXd2QWZDc3dVckhybi93b3dhS29jcVlLcGlBa2Ro?=
 =?utf-8?B?Q3VXaGxnYWViUTVXYndYSzZpRkRvakJTWXMzU1pJTDZXMjdhd1JleCt1cUZl?=
 =?utf-8?B?T21JWWJGL1RGSnM1bldkdWFVTUxnWUV4b1pmMjIycnZlb2oyU3JDMDdKaTlM?=
 =?utf-8?B?bEVmNHFmcnBGaGNlMkhzY2VwU0d1T0ZPVUlLMEM1V3VTckhXUjFTdjFHZ1d3?=
 =?utf-8?B?ZW9pOGtITTJMYnRoVEsxVG1SRjFFa1NKeDRTbmxnRldHQVdla0NNbzJrR0g3?=
 =?utf-8?B?ZElyNDFMRHd4aTVtazZ2bDlYTk1zaVpaVG5NMnZadFNwQXQzbDh0dnVlMERL?=
 =?utf-8?B?WUFqc0xxM0E3Zkpvam41TGhxNnl4SlpZRXZZUUlQd3NidzRlbWxFc0ZvTCts?=
 =?utf-8?B?b3NiTFZXSFcxUWUzVytqWUNuWTdGNmZMOWhlNmxiZ3JlOWVjWTJXWGtqU0FL?=
 =?utf-8?B?S3RPdGs1U3dKL1N1NGRHU0Zydm96TWlPeDZ3T1B5d1MyeFp6bkZkZmFHR1Zx?=
 =?utf-8?B?RzIySUk3SkxkblVMaGhiQmFTMUcvQksvY2NYM3NROThsTFMzekc3WlJFME43?=
 =?utf-8?B?dnNVbmIwM2g3Mm4yODk1NWVDYVY5enZ0MzVUdHI4M3dzaWxUQTVlN3lQMkJ4?=
 =?utf-8?B?a3RLcjZXQUYxKzJtM1MxSndIMVlJNHJxUHVCSVNtZHZUNkpsN1ExbkQzNUhN?=
 =?utf-8?B?cXFBQnkzaGxSazEyYTdqSzFEcXlWSm1wLzZLNU1GclpSNjY5NHhabzkyclJr?=
 =?utf-8?Q?kHa709u2jqNeE?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR01MB8101.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T2FtMEFjZWlLTE1uRC8zMzR6dUdXYVAyQWlEL3NtYUZKVDZYQmxUUWt4a3M3?=
 =?utf-8?B?anR6ZEFXcnRkZURKZUVadHY4bUlvS0p2MjhiT1NwSHdqRE5DZzFrS0JNbXc3?=
 =?utf-8?B?UGhqZ01UOWxTRk1uTmZMbytyZUpSa3hpMVg1YlFWcE01OGtORmdkN2h2NjVy?=
 =?utf-8?B?M1gwOEgra241dmJtY1Y2SWFZU2wrTU0zZ1doTlM0UExNZnh5VnJCMVJpUk9v?=
 =?utf-8?B?RENLUEo2M1lYQW0wbWxmcWxLb1d1ZDNzcldnUm9JZ2pMK1hmOVFwYVdNS2tn?=
 =?utf-8?B?elpSdzlTQlU1ZzB3OFJsYjFJN3hodG9ISXNQczgrSXNUNExCTTdVbUJqQnFM?=
 =?utf-8?B?VDhKME9xcHRJZTZXMnpoYlZoK0xrYlUrZVJsUEVIdWRzWUV0WnY2QjVwRWNQ?=
 =?utf-8?B?ZHdKYVZaQmY0ZmxTRGllN2NBTFlwazZVaUo0eHBYNEpSL1lmS1hyV083SGJq?=
 =?utf-8?B?elh4Z0lsSUZ1TldFNWxMaTI4RWFrTUhMSVhTellIbWFnOWE0L0ZvSjlHVUYy?=
 =?utf-8?B?SGdHdDVXS3RvU0xJbUtVRWNUTFVSR2RodWVXR3VRSmNvM1o1MExUSXd2TGlU?=
 =?utf-8?B?UVJnUGcvc2pSdHA3cDMxQzRUbkVod0tMaklGQUJaTHBRMmFjRm9MZjNzUDNw?=
 =?utf-8?B?TDBtdzJSUTZqdVhpR2hNY2FES2dJWHdDV1p3ZEdLenhDL3FVbXdYSi9RMW05?=
 =?utf-8?B?RVVwMkZGT296TEhYMDNQU2Jja01NZ2d1SzZnMWdoSHRhc3JZZXlzcFlhdUFP?=
 =?utf-8?B?dVFXU3FmeEplZ1pNbmtIaE5rMmpmK0JGODU0eEZQWldNdjhROGduRS9IdE81?=
 =?utf-8?B?OGgxaExCMVdZbUc3cGJGaUF2YW1VWXBGcDM4WUNPMndkNkxXYWhTaC8zTW43?=
 =?utf-8?B?cVpaQm5qMHlsdnVkUGtEeWZmYzRXRlRTek5yanNEU2F4VDNuZGxhbmgrakR1?=
 =?utf-8?B?R2tJSlgrc1RTWitCeHd1VVlLbmZ4aXNIZVRKOFQ4ZDdmcjRYTWVxc0k2Y2M5?=
 =?utf-8?B?QThDamNmSHVoVUZuTHNaN0lYc3lrNFo3aEphM0hiQnVocEpSL2pvOS9pa3FD?=
 =?utf-8?B?ZTBVR2pTWmdTRys2L0pCQ21vblZlZm1qMUxkaWI5eUxxQzVxMlUvOUhlVEZy?=
 =?utf-8?B?OTg4MUczWUk4SXNFZ1lRK1dWemRVTVp6bko1Vmp3c2p3VFFwVkh1WHoxempS?=
 =?utf-8?B?T21tbFdSVmpqclpGcEJneDZ2S1BCdGVyZUpTcjJXWjdHRlNWTGRmWjVKWlNi?=
 =?utf-8?B?YVhhbXlKMXNoU1VYOXVTbW5FSmgrZG80T2FkbXpHQjV3WXdPS3FTNy90TFMy?=
 =?utf-8?B?bkthL3JIdkhBaWY3bTdES1kzRFI0YnNqUUx3ZStyWDdHRG5GMlBLQW9MTVFP?=
 =?utf-8?B?V2xGUlFzQUlDRERBRmxqRC9JZS9qQ2FOSEFhdnl0QXcwYVVNU0Z5dXYwcEFz?=
 =?utf-8?B?dThIODNoa0o2NXBIWkJndlN2RWZsWTRNcWprdDI3MGV4cmZIaklFbXlUQVQv?=
 =?utf-8?B?TDNpUWllbFgyOTN5cXUzNTRJMG1uMWRraUVVWWNzU3lLaTFsa0FXaVFBNVhH?=
 =?utf-8?B?WklBQkhyeHNmVVlUc3JnV1NRZ1l3SGZXSDczN1Y2eFlnY2RUQ0sva0M3Mms2?=
 =?utf-8?B?ckYwVGFGU2Q1L1h4dCtUWTVDV05wVXBLaFFWd2d2UTZLelltKzkwaDJyc0ps?=
 =?utf-8?B?RkhFd2VCdldtUEduYlV2dEZzRDB6QmRCY2tuUk5jV1Ria0JNS0hwOWhRRk1x?=
 =?utf-8?B?NEtLSVorak8zakV5djlMaTNrY0d5L2dER3BoKzdLYnF6L1RvRGZxYWFtQ0Iw?=
 =?utf-8?B?SHhsblRyVnQ5Mk1JNktCZHZhWDVaTjNOZ1ZoMHozWTF6N0hUQVA1RlM1dTBy?=
 =?utf-8?B?RnlGSkVTMkhvRzhrZTBlYXhHMjZNam10dXgzZzN6NHI5Z25nQTU0K2JkZ2c1?=
 =?utf-8?B?SmRyZTV3TmJoaDAybnB0OFltZHNtV0pyMHBHbnpBczBRQThxaDZQUGxYNzZD?=
 =?utf-8?B?Tk5jbDd6dFJnVDJoU1lHV0JvS0wyb3VZR0daTFRSOGVtamF2bGRPZDJoRjFj?=
 =?utf-8?B?VkJ4Q0J1MmJPZ2h5T09ZREorSWwwQkZram0rYmZnWEorU05rbTZ5aXh5Nld2?=
 =?utf-8?B?cG9DKzh1am9XRG1pNWJhaWZwa2k1OUo5blErT0NaNVhaY2hxcXpWRitqaCta?=
 =?utf-8?Q?nHE59yZD8Kg9E43leed3h3y/LJJsNb513CAvzY8jYtEs?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56512a6d-5884-406d-2c8c-08dd4796f94a
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR01MB8101.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2025 16:46:31.2325
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WFVuuvhoXbYnqvljlKd7AoVEy6nNls2NllrwvBe/mNxk+WlQZDn/oI16RoUSbWKQCo7fONGu1jc8p6SPpdtToPVzJupcH5tfTjAACoTuZ8T/hk3gUMk3hhELy2e1q6X6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR01MB8832



On 07-02-2025 07:29 pm, Marc Zyngier wrote:
> On Fri, 07 Feb 2025 13:26:41 +0000,
> Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com> wrote:
>>
>>>> +	if (is_vcpu_nested(vcpu)) {
>>>> +		vcpu_set_reg(vcpu, KVM_ARM64_SYS_REG(SYS_CPTR_EL2), fpen);
>>>> +		vcpu_set_reg(vcpu, KVM_ARM64_SYS_REG(SYS_SCTLR_EL2), sctlr_el1);
>>>> +		vcpu_set_reg(vcpu, KVM_ARM64_SYS_REG(SYS_TCR_EL2), tcr_el1);
>>>> +		vcpu_set_reg(vcpu, KVM_ARM64_SYS_REG(SYS_MAIR_EL2), DEFAULT_MAIR_EL1);
>>>> +		vcpu_set_reg(vcpu, KVM_ARM64_SYS_REG(SYS_TTBR0_EL2), ttbr0_el1);
>>>> +		vcpu_set_reg(vcpu, KVM_ARM64_SYS_REG(SYS_TPIDR_EL2), vcpu->id);
>>>
>>> How about some of the basics such as HCR_EL2, MDCR_EL2? A bunch of
>>> things there do have an impact on how the guest behaves, and relying
>>> on defaults feels like a bad idea.
>>
>> Sure, I will try to have these registers also set to required value
>> explicitly.
>>
>>>
>>> This also assumes VHE, without trying to enforce it.
>>
>> Ok, I will try to set specific bits of HCR_EL2 to force it run in VHE.
>>
>>>
>>> Finally, how to you plan to make all the existing tests run as EL2
>>> guests if TPIDR_EL1 isn't populated with the expected value? Surely
>>> you need to change the read side...
>>
>> OK, I have not yet tried running existing tests modifying to run as
>> EL2 guests. I will try to run them modifying to run in vEL2.
> 
> You shouldn't try to modify them. Just make them take a parameter so
> that the initialisation is done by configuring everything at EL2.
> 

OK, make sense, thanks.
I will work on one of the test case and post it in the v2.
>>
>> Should we modify them to run as EL2 guests by default, if the host
>> supports/detected NV? or command line argument based run? either in
>> El1(default) or in EL2?
> 
> EL1 by default.

OK.
> 
>>
>> BTW, I have also ran all existing tests on L1, most of the tests are
>> passing(atleast I did not see any failure prints).
>>
>> arm64/debug-exceptions is failing on L1 and needs to be
>> debugged/fixed/skipped.
>> arm64/arch_timer_edge_cases fails on both L0 and L1.
> 
> Then I guess you have some work to do to debug these problems, and it
> once more means that NV is not ready for merging.

I will debug and share the findings/fix at the earliest.

-- 
Thanks,
Ganapat/GK


