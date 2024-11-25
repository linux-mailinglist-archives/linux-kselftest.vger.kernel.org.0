Return-Path: <linux-kselftest+bounces-22497-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E1BA79D7BDA
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Nov 2024 08:11:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6661F162DF1
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Nov 2024 07:11:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAC16149C53;
	Mon, 25 Nov 2024 07:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HPLGUhkV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2087.outbound.protection.outlook.com [40.107.243.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0316D45003;
	Mon, 25 Nov 2024 07:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732518709; cv=fail; b=mn/Ol7v3MuUDhdBqea2tEIpHQDWKxUpSo5Zu2WulmK2el8xOSWYr9ivCczu/xybTxkF0kPtD+AEy2b1uZau33dVJgq7/Dbm4lFLCFwawzazJUvMT0bqKCZja0KGH3oND7gi73a1M6DcB0jpGL6AraGs0/lJYaQLH5CZGY6tyTIo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732518709; c=relaxed/simple;
	bh=XkPTIgN7XToWeR9a5X4fBEG3Wi4VLDC6aI6fSliPDV4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UUp41xHBRPcVrFQna1SPf7KsffqKhvUH3CtJPafNDOPJ5xn8I+OxIz/PiJJBzwxKOqNhCwKlF1Fi8jgEXNyx2mZWQEnI85Gt4S22+llaDM7yh4DQqdQGaI9Epyub7b5W69ImMoC8weBmkOnD6aBZ1IcgoNSWT4bwCWSQyqWDSnY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HPLGUhkV; arc=fail smtp.client-ip=40.107.243.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lfWMqhwW8TjtevPxAWsJb2T1bfhEMp+betzAo9yWKlKPTbbK0y5JmwkCeQj9ZLvuTu6iH8+V15ZiMnOnp+XrJRzAZnOEvRzX5hi31ryaqxbiIG7DIcuRtsrbyDGxUcmIeCWLY4hYb1nwLXCAYx+GkyWBpgIUqFaRlKIbbx9otT9YPf4LU+V/o21Hz4nEjsOyQNylrQbKknqwtrjEOqkIZ0ubFVQygk1hGlQ1qs/ihFqNx1QSVO8Pz7rYVTaCa3AX3gg2A/Gp6hADLHyAhl2HJyyR0OzHA9duN9SVjN1Fgq2DRVStQIV3FymDdg3nqaZVl1tz18ZYBAVd2dNUcL5gNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GTFhhhhOkpZdlfp+bVldQXI0bYZNTDLJDRfjIIrBgLU=;
 b=BIE7nHAJxfawpOYeXi544Tapr/kYVbLGmPWW69fZ4JWkj/7nY4Gi5QYA8CwakeOEy3T+sa6QskSRD9ahUdWZMxBsKvZ3cgK77Jys9W4oHxf+MRY7zkftrwlZsLALG868zUe5uK/1fk4D27yL8X1Mc5H3zV/mXAG+0Du7N2cM7z1mlrq0JvLivSCzk3aM57lqiD+4FYsxy/rRozXsQCB+EiSG+fwUjwaMgPVZKH6q/aJDW88YLsQop196cUv2AWhar4z4E+BO2iYOFGsN7LwNG3Mywivt4vpewoq4IbU80jkOstjbsBTBrt6GiUbtBzLX/PCup2ANQIvCSY0KSBKAwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GTFhhhhOkpZdlfp+bVldQXI0bYZNTDLJDRfjIIrBgLU=;
 b=HPLGUhkVoXjQh35LoTogNh219+L8Cv9/QMoJd1u5FrpGITQmtQlegpsbYeC02w1NVCkLzvU/ZH1g2TtudZWGn3XEpIPsOup3N7/EmcqtMLiH7FbjCcFeFqCm67aMt4NUCw0t2INz7nLpJY3EC/3FrHM0NuEZGts4medgksQg8o6IYD+GZVqUAQhxAlBYncM6Qf44uWHvZVyKdvOAuj6L3unkGoDsjRNQDEUdaeim3i3F1s689ZNw2AEH/qPQToLjfTMmCBooxfV6wGeozVDv9hMJb+NaC3W79UZHOzUuKkpgwT1tede2sNo3Ek+phkJSHxWDhXtT1cFRdFK2+z5CPg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7500.namprd12.prod.outlook.com (2603:10b6:610:148::17)
 by SJ2PR12MB9114.namprd12.prod.outlook.com (2603:10b6:a03:567::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.27; Mon, 25 Nov
 2024 07:11:44 +0000
Received: from CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2]) by CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2%5]) with mapi id 15.20.8182.019; Mon, 25 Nov 2024
 07:11:44 +0000
Message-ID: <871a9ecf-1e14-40dd-bbd7-e90c92f89d47@nvidia.com>
Date: Mon, 25 Nov 2024 09:11:37 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/5] net: ethtool: only allow set_rxnfc with rss
 + ring_cookie if driver opts in
To: edward.cree@amd.com, davem@davemloft.net, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com
Cc: Edward Cree <ecree.xilinx@gmail.com>, netdev@vger.kernel.org,
 habetsm.xilinx@gmail.com, linux-net-drivers@amd.com, horms@kernel.org,
 andrew+netdev@lunn.ch, shuah@kernel.org, linux-kselftest@vger.kernel.org
References: <cover.1731499021.git.ecree.xilinx@gmail.com>
 <cc3da0844083b0e301a33092a6299e4042b65221.1731499022.git.ecree.xilinx@gmail.com>
From: Gal Pressman <gal@nvidia.com>
Content-Language: en-US
In-Reply-To: <cc3da0844083b0e301a33092a6299e4042b65221.1731499022.git.ecree.xilinx@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GV3P280CA0006.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:b::6)
 To CH3PR12MB7500.namprd12.prod.outlook.com (2603:10b6:610:148::17)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7500:EE_|SJ2PR12MB9114:EE_
X-MS-Office365-Filtering-Correlation-Id: 4094394a-6094-4a47-ddb3-08dd0d206ae7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WWJVTUdSZ3lXeXo4STVnNGNad1JtLzRBMWtsRUlGQWxFOG9sV0czNGVhNE9Y?=
 =?utf-8?B?cUIvMFlKTTdHV0kxSUwxN2FaTmNsdktqMFdaNEpJT1UrVDk1SFVUbTgvK3pS?=
 =?utf-8?B?TTNqRWcyTWE3TFVObXJRWDhLMG5CdjlBWkI0TmVWRjZRTElYcXB1bmNnRm5H?=
 =?utf-8?B?WWZjTEJmQUxmS1dZVG9iYkNOejdKSCs1YWk1a0N4L2F2bGFUUTc5VnlCTHIx?=
 =?utf-8?B?QUhrbm40ZlN0Vi9rTGVUTlBYWmtCT2ZLYjRqQXZJS2hxMVMrQnFZK2trN2h6?=
 =?utf-8?B?bGwzTlpCUHcycmNjcHFTT0NTTXFnWlhzSTJhSDR0L25tcXMvNVQwczQ0d0ZP?=
 =?utf-8?B?ejJpMHN6TlNZby9zcVZZZWZ3OU94dEJIZjJ5cnpYOTNqMnhoalNIOTc5dWc1?=
 =?utf-8?B?UVNpN0l3alJGSXNIMVBYazJQa2NtSnZCUlU5dUcyclRHNWRGK3NWU2V1QjAw?=
 =?utf-8?B?NkIzL2hadTQ1bklvU3Bncm9jK1FiaDIxL0pQN3BnM255V3lOMW12UzBzeSsv?=
 =?utf-8?B?M3JHWUtVd05tMmZ0cXBremRSOEx3QmpLRGVCVklMRWhpa2k3WktkdmtDWXJ6?=
 =?utf-8?B?Njl6TkpUck9sM0NTZmczdVd0bDAvZm5ZV1cyRjZacEtmejJ6eVRsSG1BU2hV?=
 =?utf-8?B?UGhLcmdsVWhRRXRENVYzV0QwRTFLRlNQL0FndzZFNSs4SW82bkZKRHpmV1Fw?=
 =?utf-8?B?YTdSSUNZdTdLV0NObGJ5RFNPeitoY3c2eWxFcXBGTWwzOXl5bFJVRGNKZlZB?=
 =?utf-8?B?RDZWTmI3cTNUeTF4VndHSFNlY2VUazhNZnFkY1NPN1hFY3h5LzdHV2VWUW9p?=
 =?utf-8?B?OVB5cFZ3N1RmZEFpbWUweFM4S0ZqVjgzbnB3TEsvdXhKL1ljVVBVbHV2eERD?=
 =?utf-8?B?c2lQbkNCT2FSUFlQaDNPei9jK3pDUFhIUjFRV25wcWJKb0FHYms0VTgvdnRv?=
 =?utf-8?B?OTJHNkJrMHhNNllkUlhRVlZVNWFVVitjMWtlOXhjMVJVVnRjWHdTNUdEN1FB?=
 =?utf-8?B?bmxpeUM4UitaSXp3eFBzMG1KbGtSZGpleEhGVHU1bW53RGpXa0hGbDU2bjZk?=
 =?utf-8?B?L05hYlFqQyt6MHhSRXhmSGRkSkNQcWdLSVZhdHorRDZUaEZFM2I1aTIvM1hD?=
 =?utf-8?B?N01NUDl3L0lVNzgyYUJKRkdBQW4vTXVXNlE1T2liaU9JalVINHFxa2NwaEtK?=
 =?utf-8?B?QTJJT2wrblU4QVNLQ3lSa3VmSnowK1Z5RXZUUHh3ZWhDOUpOSkpuMm5oM1dE?=
 =?utf-8?B?SmRzMVlrcTRCcTFzcnQ4NENEc1EzblEraVFRWjdKNCtVanQrdlJtWktuN000?=
 =?utf-8?B?VmFZRzVZZjE3UTk4MFNMY2VpcGp4emREZ2hDUWxTNnJaTmpSRXJabXN2Wmkx?=
 =?utf-8?B?YUVoUk95emRCY3NHT2FLc2VmaHBhb2FnUFRyRFE5RWhIR05HWGR3SHM2aVdD?=
 =?utf-8?B?c1VFR1RuVDFvOVA5Vk1qcWMvVU50RVNFeUZ3OHc3R2dzQThDeGE0ZzZIYUNh?=
 =?utf-8?B?dGpiNy8vckJ3WUhwb2hsUWRlVE8rUkppNDRhQ25FaUNLM2I3aVJVQndSenVl?=
 =?utf-8?B?Zml1dC9VOVRMVGpiZit0Qk5ER3lLdVBaT1prQWVOajc2VzI2bGRKSzhZa0dJ?=
 =?utf-8?B?Njc2UmFpdmU0bWQ5MnJVaU5zZlo5MWVhaHNYMGJxcENjV3o2SCtzVitvMVRv?=
 =?utf-8?B?UUxxWkx1ckdOSFgrZlpBK3hkRnNNcGh3MG9UZ0RlSEJxOW1VRitoT2p6VWxG?=
 =?utf-8?B?dEw2aUhrZWxsZHBBMnRRSnJHTEJneVB4NG9BUzYvejlYUFNCL2NKa2pjeXZ4?=
 =?utf-8?B?VkVlNjZsSHJvVjRwL2pWZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7500.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Zi8xS3VTS25ESjdJSGtBVmg4eHBmazlHUm9abWVPQ1IxZG5Odkd3dlRVZkFx?=
 =?utf-8?B?QlQ5eTdIOGVSWGVUUmMvbWhuUW1ERmloZEQrSGNHRUZwK0llcXRvMlR2alhC?=
 =?utf-8?B?czBmYUlPNUtEZDlZbkpDdjNjeDlRK0hkSnZQRFFieWVWZWhsQTZJOVg1ZGxv?=
 =?utf-8?B?NGVKdVd3SThwazIrOW5KUnMwdkhXRXlYOFpDNlJKbUh2Q0N6SllVN1hVbUZn?=
 =?utf-8?B?RE9HNEJiaXROaGNwSnNoTkJYNjBNckVyamMvaStOd1lxdkpUZjE1elA0WG9M?=
 =?utf-8?B?aWpOcWQwcU42VDJndjJzeEtnRHlVV29zbGRJcTljYVhEeFdjbDlNaVU3WkJK?=
 =?utf-8?B?bGpyaGU2UDZsK3laR1VlSE5GSWVhdm42YlI5dzQrUGRmS0l1SUFMWmEySDdN?=
 =?utf-8?B?V1lMK0tPUzNnSzFQdEVJbzlDM2d3SmdFZFBXNDAwcFJ1Rnc3cDExcE9FNXZw?=
 =?utf-8?B?eGxtblhTSVhtQTdQS3U2SEVFQ2hSR0Z6c3hJTkpFQUpxU0lGTFpGSVBpcEZD?=
 =?utf-8?B?TTltR2xadS93alBmdlM5WGxNUGVDZzFHNExLZUsxeUlTcVJ4N09jMnBVWTUz?=
 =?utf-8?B?Vk9YOGEyZDhubWRiU013YmdEWXE1dldTUjVVSmNLTDRWSTRNUmlLYmFMV0lK?=
 =?utf-8?B?WjFlOHc1R2pSc2w3UjNEV0gxSkVBRUFyZGtqdWhPc29oUUM1UmFOM3MzRURn?=
 =?utf-8?B?ZUZYL2xuS1JwYkZHUlJUY2k2aGtkWGZzbzl1Z2dhaDRvQkhUY0tORHI0Q0dt?=
 =?utf-8?B?OHU2QVN5U3lhV0VQYllpVG1ka2NWYUFhMm1FaHVCaHNMUmpsZ3NKdStOSG1z?=
 =?utf-8?B?cU15b0dlN3g4MkFMdVd5N0x1aVhlMFMxZlI2Ukw0bHc1b3NHcUZKTDJRdFhN?=
 =?utf-8?B?RHZqZWZnd2tZZy9QbUNvbXZCL2dmS0hpeUVyYVhha2pabndZbVE3NDBDeW9V?=
 =?utf-8?B?QjMwTXY3T2dIaEp3R3lRVGhYOStrdHZOQUhvditvNlRLcFE1cDU5aTFLREl6?=
 =?utf-8?B?c0traGRpMWprRy9aRTdXQno3Ni9WUnpPYlZGZ0Q2NmlFR2R4RFgvU0dTY0k0?=
 =?utf-8?B?SzZ6djI4cjhyMTZrdllzUlJzRW1zZ2dXd0RsVVZrL1RlSnFGRTdJbHBwMlMw?=
 =?utf-8?B?Q2I0WWMzQ0h5bTQxSzNKOFZKaXRDcDdYS0VEQ2ZodjJnN2N4akg4WVZJV25C?=
 =?utf-8?B?THlPeWhnTHEvUEltM0ljTUxKQlhJaVBoWEwzb1FsV242ZzZTWW9rdjV2Mmda?=
 =?utf-8?B?dkhVbGpXR1NZTEl6Rm1XKzN0OWJCNk1aaDdZVUh3djU4UnplaXRzQjNOWENm?=
 =?utf-8?B?RCs2K2RRQndUQ1lBUkQvZldwQlBEL25pc1JpYlI4RE43SEdhRU9DbUtJMnk1?=
 =?utf-8?B?dmsyZnN4UDQ3WjloenMwU01ObFdBbDRZMldveGc5K3FPNHpqWFExQnBNWEZP?=
 =?utf-8?B?cUpCbWNUaHdGRjBOeG9RemNSYjJXNUdEMFdMNGtiNlBScFlNak4rQXpJYVF4?=
 =?utf-8?B?cjk0Z0hpb3Q1ZnhzSEx3bzJSK05LQTYxL2Jya1JQaXREMEpMVWFhTUZneUhU?=
 =?utf-8?B?ck41MVpJVisyS2NnT1pRdGliS1Y4Tkt1SDh0bW9XUG1pMVpuY0pXM29BeUl3?=
 =?utf-8?B?Mk1EM3R0Uys0NVl1ZE9nbktIOG5XdXVRa09OTHcvWENaV2xPVU1oT3FzY2ZQ?=
 =?utf-8?B?NFBWNDZZdUxrUkpiUzFXdTNiSFprdXdIekRNVXlKeGtlVFNWVzJKMEpGemp1?=
 =?utf-8?B?bzJtUWROdFZPMG1jdkgvQUpzWmgzaXAxZHdrOXNYZHpXdnAxNGJsRG4yNnNi?=
 =?utf-8?B?Mm1CckVCdXpwUDI0bWtxNGRoWkhZUGRtMnQySUw3YWhEQmc1YzNrUU9uQVoy?=
 =?utf-8?B?VzhNeTk3VUxUUmRGeGhtMmQ5bjY5YlQyOTdHMmFYcysranBCK1Q4TU1DUHhz?=
 =?utf-8?B?MmFCM0RZWkpSYk4vbEJJT0hqTXVXMUdzbVlSYTlxTlFvR2Y0S21NT25tTnI2?=
 =?utf-8?B?a0RYbG5GU0xkVjVtdVBzd2t5UFBhZXFjV2JNTU0yd1BIQnBZT1Y5SWQ0T1hU?=
 =?utf-8?B?S1hrN0tEb0JlRldxZE1wZ1QrZGt2ZURHVEIrcUFxeEczbTBNT20xODlQWXA2?=
 =?utf-8?Q?b7UY=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4094394a-6094-4a47-ddb3-08dd0d206ae7
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7500.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2024 07:11:44.3288
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IAIj/ArKH47eEgbd6klSUJ0b7E2WnBWpGIuD7rElFjikKt/cuiZudz1gmpKN86eq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9114

Hi Edward,

On 13/11/2024 14:13, edward.cree@amd.com wrote:
> From: Edward Cree <ecree.xilinx@gmail.com>
> 
> Ethtool ntuple filters with FLOW_RSS were originally defined as adding
>  the base queue ID (ring_cookie) to the value from the indirection table,
>  so that the same table could distribute over more than one set of queues
>  when used by different filters.

TBH, I'm not sure I understand the difference? Perhaps you can share an
example?

> However, some drivers / hardware ignore the ring_cookie, and simply use
>  the indirection table entries as queue IDs directly.  Thus, for drivers
>  which have not opted in by setting ethtool_ops.cap_rss_rxnfc_adds to
>  declare that they support the original (addition) semantics, reject in
>  ethtool_set_rxnfc any filter which combines FLOW_RSS and a nonzero ring.
> (For a ring_cookie of zero, both behaviours are equivalent.)
> Set the cap bit in sfc, as it is known to support this feature.
> 
> Signed-off-by: Edward Cree <ecree.xilinx@gmail.com>
> ---
> diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
> index 7da94e26ced6..d86399bcf223 100644
> --- a/net/ethtool/ioctl.c
> +++ b/net/ethtool/ioctl.c
> @@ -992,6 +992,11 @@ static noinline_for_stack int ethtool_set_rxnfc(struct net_device *dev,
>  	if (rc)
>  		return rc;
>  
> +	/* Nonzero ring with RSS only makes sense if NIC adds them together */
> +	if (info.flow_type & FLOW_RSS && !ops->cap_rss_rxnfc_adds &&
> +	    ethtool_get_flow_spec_ring(info.fs.ring_cookie))
> +		return -EINVAL;

I believe this check shouldn't happen when we do ETHTOOL_SRXCLSRLDEL as
flow_type is garbage, WDYT?

> +
>  	if (ops->get_rxfh) {
>  		struct ethtool_rxfh_param rxfh = {};
>  
> 


