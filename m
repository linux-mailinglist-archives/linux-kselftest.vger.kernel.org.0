Return-Path: <linux-kselftest+bounces-22508-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BDB39D87E1
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Nov 2024 15:26:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87B24169737
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Nov 2024 14:26:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2B811AF0BC;
	Mon, 25 Nov 2024 14:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="P6HsTkn9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2067.outbound.protection.outlook.com [40.107.94.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C0CD1B0F1B;
	Mon, 25 Nov 2024 14:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732544785; cv=fail; b=jBGv/TR5gH0g/mTlXPbmnzhOP5tUZPP4fvBLIZfV0VkieofcCmOe88s6MTUua0ldlLyXa9mDS3xon96yN0MoBRw68zoMucWmxqmTN1PgXFT/mrsTiCt+cYcU5DQpBh+No+HYO2H4Mz/xD7NgywcM9KMmC8qN6I4smXm42B6Iwds=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732544785; c=relaxed/simple;
	bh=cSXZND6N12rariezLgN1BRfP4jiNKx/JILD8U3xKdoE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QeBtZcHhzIroFeXVlCUO311HKG9TLS34monUirbseyltIvp1JqhPZt48em5QMx3sIup92DLqanhCGoLu+Cgi9I7F/k7DTlGt0A44m5tJoaAOnJTcA+ZKl0fsuo7A6emA8LnJxOekFVpPM9bHRQctB8w0/Bzc5aW1OoI3RVU3Kj4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=P6HsTkn9; arc=fail smtp.client-ip=40.107.94.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AyBS6WawHuLI3qiYPEphFU/tA0+4K49qRaXxrBIxdU4WqjWbkuobT1Kip1Q7BFEjpuDt1gKzSGFXI6huH7IYwCaX8PdVPaIJ48j74bvCLl8d2wvEnKpRs918qbA0dYGY7y/RppIzRawKYhFKBPiFJ3VCrYGZ5fjwm+nDP1BnYu37T0c4vsUXDFWG+PaiHw/4nyOGLYIMngSklQmbvehII4AaK5kb9mFevmIaRlDM2DW0xvwbqKuECmQUmS7OECEXXkH/r4sVslWD++CoKelStCOlIjQyjgu9DUAaWNGO6DTPNQrmjmXPLuMRWfyxTIL6uZWQJ6mdCsh2ad677CC2Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mR+msfEzd2Z9RwI+EKGqMzwo1+xCbJn85uQM/CXiMxM=;
 b=Gfio8XBV6Fi14fxih+nFKY5cL2AVmQHtprCrJlR+FeItxikvCLNNFd6Do60B42tPARSIze/4xGm7K/N7DZSKZLBIHp0K8CVv2EeMOCebCHg2nsY9xKIw8v57Ke6MOwZMcALSoRCxINsX5Jta6Y86m0oDVN5u6/ByTCg12S8bd1P8XizP9Q6PVVVIiEKqHN08cVrUovZdTUrE+/jg6RZMcLsd1Dkqe/duTwXjSFf81if8l0jQLonyOVKO+e1yMGyW1i/usHcJKm9fOIRP8eVCHSt1JVImbLObIndL3XbMNgMEDjcUfcA/UCNj3fJX8DGVRANQkKCQMENl5YEzFX9eaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mR+msfEzd2Z9RwI+EKGqMzwo1+xCbJn85uQM/CXiMxM=;
 b=P6HsTkn94j+80hf60/F1XpK8I1lzsLibAJSmWdbKDhDohCm6sLQiSuNDL/nHtkgum+bAZ51zF/+CKBkeW8nFfr5toty6LlbCDjhw0mCcL74cRcJL7RtZbDfUZfcQk4gBUchtCuKA70rOUDEkdQ3NNT6+FJrcAXS2EAV3uWBo9GvkJJENqYcZ+NCqEnQ4y9m8n5NJRXHuiH0ydAhEQgUlQSr7dfGTh5vrjSssuSdPRrwN8JnwG3oZCNX/zTQmUxkO2p+stbZhpflYeb5NtK1JnGVoMoO/mpPrn2mdZN2+wt6h2a2/hvnqP5149kY89BVxVERt45h+X7m7tpP+qkOM5g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7500.namprd12.prod.outlook.com (2603:10b6:610:148::17)
 by PH8PR12MB7183.namprd12.prod.outlook.com (2603:10b6:510:228::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.27; Mon, 25 Nov
 2024 14:26:20 +0000
Received: from CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2]) by CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2%5]) with mapi id 15.20.8182.019; Mon, 25 Nov 2024
 14:26:19 +0000
Message-ID: <a479ec8a-99ab-4e30-ae76-290836c713c3@nvidia.com>
Date: Mon, 25 Nov 2024 16:26:13 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/5] net: ethtool: only allow set_rxnfc with rss
 + ring_cookie if driver opts in
To: Ahmed Zaki <ahmed.zaki@intel.com>, Edward Cree <ecree.xilinx@gmail.com>,
 edward.cree@amd.com, davem@davemloft.net, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com
Cc: netdev@vger.kernel.org, habetsm.xilinx@gmail.com,
 linux-net-drivers@amd.com, horms@kernel.org, andrew+netdev@lunn.ch,
 shuah@kernel.org, linux-kselftest@vger.kernel.org
References: <cover.1731499021.git.ecree.xilinx@gmail.com>
 <cc3da0844083b0e301a33092a6299e4042b65221.1731499022.git.ecree.xilinx@gmail.com>
 <871a9ecf-1e14-40dd-bbd7-e90c92f89d47@nvidia.com>
 <b0f84914-c4bf-9071-b72d-cc2cc4a517f9@gmail.com>
 <d986d2ad-3ac6-4357-a8dc-e83e3622efb2@nvidia.com>
 <6ab56991-1415-4009-a630-14a0b709583d@intel.com>
From: Gal Pressman <gal@nvidia.com>
Content-Language: en-US
In-Reply-To: <6ab56991-1415-4009-a630-14a0b709583d@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: GV3P280CA0089.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:a::13) To CH3PR12MB7500.namprd12.prod.outlook.com
 (2603:10b6:610:148::17)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7500:EE_|PH8PR12MB7183:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e6b9a6a-f3ae-4147-eef8-08dd0d5d2103
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Y2hqNUxHamlveGJzaElsWkI5REFDNXZ3eFZTOWZabXo4blRUOFVIOWlCcUFX?=
 =?utf-8?B?VStRMExiYWc2bW1hbS9YdE9VUUwxSWlmSWg5Vmd2eE9KNU1WVE1mRmlIRUJJ?=
 =?utf-8?B?K1o0emxLWUNVL1Q0NnN4MTBCaldSNjREYXFLN3ZYSHZPWm1yM0pNdklFUndj?=
 =?utf-8?B?aUdya2lYTExMaTBPdXhpNkt1elcwaFkwTnZvRTVBeCtocjQ2eTBqTFBMRTlo?=
 =?utf-8?B?ZjV4MGx1Qkg1alppZTBTTm5NazhoUzM4UVV1cWcrUlppT0J6SUlMOEJCT1hS?=
 =?utf-8?B?Y1gyMFdBUGQvQ2FGanNkczg2c2tDNTBxM05NbWZLY2ZpdEpLQU0xQmxDTDVq?=
 =?utf-8?B?V3ZsZzZ5cmdEdklWZm12Wko0ZTVtTjRCR1czUkk5enU5Mko1RGlxd0tuTWN1?=
 =?utf-8?B?Z1FDTnpRa3R2TEdUb0o5OFJUVWt0blNCUXlNeldaRnR0OWNwMm9YV21HeTVQ?=
 =?utf-8?B?Rlh4RUJWT2I5T3FXQlZscVV4VTRYSnJOY1NaUnBTOVBUZFc0N21PdWZhVDhF?=
 =?utf-8?B?MzBZWnRUdm9lVVg4WXRqSzZZUDc2Q2xvS0g2Q0ZkalpraWZSOVRwL2xNU2w1?=
 =?utf-8?B?RTk3bVJSSjZQeUp3RFJMT0NYMVMvSVMxVGJrK1RrSm1Md3pybzQ0dGxFWkpY?=
 =?utf-8?B?ck9hbmtVdUNwOFI1aUJSeDJsR241NVFIVWhnNXVra2E3QSsxeHVneS9zWmI1?=
 =?utf-8?B?UlIveXZXL1BuWE9PeXdmNGVmMVdteWdlLzMwbWJIWTlRNDE0QlIwRVpjODNo?=
 =?utf-8?B?MFE3QWF1LzhXbjJhOG1Eejd4Z0VickdvL2JNLytYNlN2VzVBdk1iL3NaYTNC?=
 =?utf-8?B?STVJaG5vV2xjUnJWREFnOFZsdE54RCt2UlMzaE96RTZVUnhoMm02TytoTlVM?=
 =?utf-8?B?cG1iYjdqK2hDaGFhUTMxMXZweE0vdi95VHhqL29TRTZsZDdTMy8xMitwMERS?=
 =?utf-8?B?OXlyS2FlT0Y1VXd2RHBpeHpWQzFsem5yVVJWU0pTdTllQ1l4SHVlUmt6c2tH?=
 =?utf-8?B?ajBLY2VxV2IvTWNiWCtNUXVSelRaYmxFaDBOaFhrbHNDbyt2d3NIUkwrei9T?=
 =?utf-8?B?L3pTYWt2WUpBbElDcS85MUcvMjhkcVMrenhENk91Z1o3NVVhUjR4UHlhZjBL?=
 =?utf-8?B?V0V2V2R5K2JCcGRMbWllakxaUkpKVmVlTzh1RVVMUmM3YXhVM3RzdXJvcVda?=
 =?utf-8?B?RzZNSWRxYVZZZ3NRMHQrU1BnTWNiMkNCN0RnRWlyRmdmOU8rdkQ3dnBod0RN?=
 =?utf-8?B?S1JQMnF4VzRmVzZ3d2dVbFdpY2d2blVJOUpKcFQrdEErd3ZIL0kxUVg3Wk11?=
 =?utf-8?B?UzAvbjZkNTczOHBQanRreEI3YVQyM3pHNnU4SGppeGh0TGZqWUhSYkdsUklC?=
 =?utf-8?B?UVJUYU1lMVhod0RyQmU1eHJVbGJnZWpqbEt2QkNrWDIxRHVLS1Z3aWNQZXpJ?=
 =?utf-8?B?dmZEakpiN3BHSFY3YXc4NHRlM0NUcndhRkJIN3p2OGtzeE4rSldBMmh6UzRx?=
 =?utf-8?B?MDlvZGpZU24vWTgyMTZ0Tkt2L1dRUWpWajhnS0c3bTV3WHVjc0tIcGxTOTd4?=
 =?utf-8?B?d2xqRzdvRGFaT29mL1RZUkZMQVhUSnRRMkVMdDh1dW1vUzNKazlsQlVnNTJH?=
 =?utf-8?B?Wk9UMFJPUEExcDhpbmlNZXBqUzhRcVhoWE5QMU5OeEljVzh0dUxtQkR2dzFV?=
 =?utf-8?B?WHJHWSt5SklOUlVqQWFBQ3BXQmpzN09BUlliTUZLSmVSdUJhMFFvUmU0UjVV?=
 =?utf-8?B?Mk5KUnM5V0NVOTB2OGhyZ0x2Z1ZySU5KbExuWFN3NUNDYnZkaXZMNnVJUzlx?=
 =?utf-8?B?VHdVTVlhZ3hpam56eXJnUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7500.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ajNncHQvbmJvY0NGaUxrakZHSTFhMnJYVzFUY21ObWZVcmdTWmtJbjRwUXhJ?=
 =?utf-8?B?NW5zVElpZkdjY2dEN2g0eGNnZ2pWV01BY2I1UnppRFA0bHJDT2hxRGVTd2pt?=
 =?utf-8?B?SFdqZytET0hFaDJuaDRLNytpVDZzSGpFbndmNmZ0WmtGNjBNY0RnbElEZmZW?=
 =?utf-8?B?bncrZEkyaUYwc2k1QkJiWUhFU3h3dzc1b1RQNkxjaEVPSEtIMGttc3d2Mmw4?=
 =?utf-8?B?VVV3RjR1VERRZm9NVWttSzJZUk10eENTcjNpNm9LM3lZcklNWWVPMTdLVHRX?=
 =?utf-8?B?ZDJkOEJPMU1XTWJVOE1ZbjhRRG1xcU5Lb0liOEJMb0Z1anRnVThQeGxpNzcz?=
 =?utf-8?B?MTJaWFRablJ2aUVSU3ppWlR4bDlOQzloZGJzK3laRloxQVJCNjI1MTFHOUUy?=
 =?utf-8?B?M2F1dUo0NE9LcVFpaG9pTElHcnBFUXlzUnU2SDJxSFh4bldPaEJENTg3cnVw?=
 =?utf-8?B?bEMvK1prVm1Td21SVnkxWGZRTG0yM0Z2Umhyb1dyclJJOFZIZHV1N1FDWUov?=
 =?utf-8?B?eDJmZng1Qll4Mjc0eFNyd0lxSFVQZzVPVnJGREZWMnNXcENKOUppY1o4Q1FF?=
 =?utf-8?B?KzFHMHIvcC9wYlVMRFZOL2tweC84bXRxRWRYRE12VzN3dDdSZ3Y4S0wvaHIy?=
 =?utf-8?B?UzZhMnlOejhuMDdoVzFlRWF5c1VMZ0FJZVFJcUYzY3JuRVB6UGlwVGxUTlFY?=
 =?utf-8?B?Q0djdXFPMEFKcFRRNVFBRElwMTA2VnN4ZEQ5aTFRTGowTXQxZWZhZFBENUY5?=
 =?utf-8?B?L1JEUldqZVIveDVvMFJ1RHNSMDFtZnNJbVpqTEwvY3Z5T1h3SnpMZHhKdWpB?=
 =?utf-8?B?RjRMejlnZTROalpzRitzRHRXNVlWT0grOWZTMnRlSWRJaTVsSTg4Qi9oUGZX?=
 =?utf-8?B?aDdYYk94dmtRNkc5eW52NzF0aHd2Zlh6d0RCbzc2T1VyRHpJdXYzUEFRbStC?=
 =?utf-8?B?U3RNeWVGRk9XZTVNNVdpMHZlV0orSFVVTm9qNm1WbnJqOHBOUFA1eTFKL0Ex?=
 =?utf-8?B?WS9UcjBIV3drVmx1UkhSWmFJTnFOOE13U1c1eWlCdi9VbUI5RGk5R05TQlEw?=
 =?utf-8?B?UDhRSGM5UHdhYVJJdjNUUTEyTTRzbG9lVEdIRktleWk5RUZ2UnFLWlRJaUM2?=
 =?utf-8?B?a1p3ZmF3WDJ5UEZ4YU1NRXBPWWI5RE9FMWZVeHpzNUxTY2tWMVpNK0V3dlE2?=
 =?utf-8?B?ODlRWFJZVFVoOFJoNzNVNTVLMmVtVzNSdmZPUitvRDRleHY3aDVrWlIzODdK?=
 =?utf-8?B?cDdMZVRlMFo5U0JvemlEeGpjczBpbndvbUMyM1RaYXNsRkFlcDJhVnZiUng3?=
 =?utf-8?B?enloZ3dEaS92aEFCWWxpajVTdW5EVmdlQUY0Z3NaUDdTVkgvODB2OE1ycE5I?=
 =?utf-8?B?WWpzRHpaQkJZL3FyMnN1OGdyU3Q2VmNLUklTa1BJMG1VWk84cnpHUmZtdCs2?=
 =?utf-8?B?bU5CZTE3TUNiQnhFTC8wMkhmRElPdXhueGlCUERiVlp1L29OdkVqcGJkMDJV?=
 =?utf-8?B?QWxodjIzOFo0QWMxUVF4aFJFcjZYYWVwSzFLWmttZG5xbVd0TkIvSVNBNmcy?=
 =?utf-8?B?ZGoybTAwc1hWdk1YTDFWZlI2V3YzY1pHNllhYUhhcDRvRFRGQTVLUGQ1VFZC?=
 =?utf-8?B?K3B4akx5Z0xGdHZQaGJaUEVyZ0NLTHJEUnFZVHRhdHJxRDFob2xuZjZPSWZZ?=
 =?utf-8?B?M05zS1BIbHRPMXVmdC9PN3lJM085MC9MdFZCelVJVUduODl1ellHZnJRSFB4?=
 =?utf-8?B?b01PMFdXbEJ3NVUvaWlmVkFEZHBGQnkzYkFZRjQzMzhkRzBVVHFnaS9Zbm1Y?=
 =?utf-8?B?Z3RBdy9oc0dWak16Q2k1cXNJWXlMcWcyaEJXUnY3SlU1VG9BVE9iVnF0ZHQ2?=
 =?utf-8?B?c2dwQzlBQ1NvOUF5OXZQR201Q0t0dndoOXNyMCtkaUwzOGIzUXpTeWhVTEpB?=
 =?utf-8?B?TmRLSnM0UHNiS1gvSDlPL0V6UU1icnNUVHZYbVd0Z0doTTBUTFlNdXBDU2Vq?=
 =?utf-8?B?UmN2a2hhS2Y0VnJFVnBJT2VZSjFIRzJpSWNPZEsrMTRiTFk0NG5LbmFZSTJL?=
 =?utf-8?B?ck81SlZZaHppQ2tWc0c3R0M0ZnZMVXR2Zm8zd0IvU0ozWWs3Yld4c2tFR2Jh?=
 =?utf-8?Q?sg4Ifv4+fKQnaZcy+M98wYY4M?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e6b9a6a-f3ae-4147-eef8-08dd0d5d2103
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7500.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2024 14:26:19.6748
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rJuCWixYWwblhwrL64HMucVpA8nVUTOmJ62nSKHowmBVgcsrCnh+1GUiXyZDTIRC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7183

On 25/11/2024 16:20, Ahmed Zaki wrote:
> 
> 
> On 2024-11-25 7:10 a.m., Gal Pressman wrote:
>> On 25/11/2024 15:21, Edward Cree wrote:
>>> On 25/11/2024 07:11, Gal Pressman wrote:
>>>> On 13/11/2024 14:13, edward.cree@amd.com wrote:
>>>>> Ethtool ntuple filters with FLOW_RSS were originally defined as adding
>>>>>   the base queue ID (ring_cookie) to the value from the indirection
>>>>> table,
>>>>>   so that the same table could distribute over more than one set of
>>>>> queues
>>>>>   when used by different filters.
>>>>
>>>> TBH, I'm not sure I understand the difference? Perhaps you can share an
>>>> example?
>>>
>>> Something like this:
>>>
>>> ethtool -X $intf context new equal 2
>>> # creates context ID 1, table filled with 0s and 1s
>>> ethtool -N $intf <match fields...> context 1
>>> # filter distributes traffic to queues 0 and 1
>>> ethtool -N $intf <match fields...> context 1 action 2
>>> # filter distributes traffic to queues 2 and 3
>>>
>>> See the selftest in patch 4 for a concrete example of this.
>>> Some NICs were apparently sending the traffic from both filters to
>>>   queues 0 and 1, and ignoring the 'action 2' on the second filter.
>>
>> Thanks, I did not know it works that way, is it actually documented
>> anywhere?
>>
>>>
>>>>> @@ -992,6 +992,11 @@ static noinline_for_stack int
>>>>> ethtool_set_rxnfc(struct net_device *dev,
>>>>>       if (rc)
>>>>>           return rc;
>>>>>   +    /* Nonzero ring with RSS only makes sense if NIC adds them
>>>>> together */
>>>>> +    if (info.flow_type & FLOW_RSS && !ops->cap_rss_rxnfc_adds &&
>>>>> +        ethtool_get_flow_spec_ring(info.fs.ring_cookie))
>>>>> +        return -EINVAL;
>>>>
>>>> I believe this check shouldn't happen when we do ETHTOOL_SRXCLSRLDEL as
>>>> flow_type is garbage, WDYT?
>>>
>>> Agreed; this check should only apply to ETHTOOL_SRXCLSRLINS.  Do you
>>> want
>>>   to send the fix or shall I?
>>
>> I will do it.
>>
>>>
>>> Also, the check below it, dealing with sym-xor, looks like it's only
>>>   relevant to ETHTOOL_SRXFH, since info.data is garbage for other
>>> commands.
>>>   Ahmed, is my understanding correct there?
>>>
>>
>> Speaking of the below check, the sanity check depends on the order of
>> operations, for example:
>> 1. Enable symmetric xor
>> 2. Request hash on src only
>> = Error as expected, however:
> 
> Correct. The check below is to make sure that no ntuple that does not
> cover symmetric fields is added if symm-xor is enabled.
> 
>>
>> 1. Request hash on src only
>> 2. Enable symmetric xor
>> = Success :(.
>>
>> I've been thinking of improving the situation, but that requires
>> iterating over all flow types on symmetric xor enablement and that feels
>> quite bad..
> 
> and delete/disable filters? may be just a warning to the user that some
> filters are not symmetric.

I think the right thing to do in that case is fail the symmetric xor
enablement, but do we really want to query the driver for all flow types
and check if an asymmetric filter exists?

