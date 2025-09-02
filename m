Return-Path: <linux-kselftest+bounces-40523-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EE29B3F786
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Sep 2025 10:04:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 460643B1CE0
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Sep 2025 08:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD0522E7F2C;
	Tue,  2 Sep 2025 08:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="nZKCivcZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11012038.outbound.protection.outlook.com [40.107.75.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E344D25A328;
	Tue,  2 Sep 2025 08:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756800233; cv=fail; b=H9C4nKg65DJybXI/L9cZCAlGxL0BocuuKSC5m9mjZMbol+vbaEDE5zIR9Lhfn3+W3FbhfF5VLQQyKgDnJi519S3e72fVhEm6X0/c57WFPRrMM+ofdqMuFYq6Oys9ZCqJAAHU04Ry+wnvFyZyna/lo7A5+dh96mm4ruuqw7jGWhc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756800233; c=relaxed/simple;
	bh=kpVkKAnaZ2mD1PdlvVgwbI6zabjuqNx0lPYgUUSGBaA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IMjIru7CfBC1oewEP6v5Nb7HP5cR0l7l6+dkec674uLx1uvBFQefHAsR5A1WHwfAFDjqJUDRD6ESuQ93pOaCZp6c/kOJWlbMZRYhvG1mH4PeoyGaFi48YlBpDDf/0+nny17MlWdFupwJ2U7jL34H8+UhptH3XuBz+uppjKb4QwY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=nZKCivcZ; arc=fail smtp.client-ip=40.107.75.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=azax7Hakwt7bOoxnPFa9xuu2+iEhNWBjjvQIc0cish+YRxg95jd9A8Aaj8zmZPyfPvCHk7b+F1Pt4/c4Arg0hanMZq4pQbBZV2Sl5uCyA9LC5DkCBtc1dpoPdPbgB1HMQWFyHHj8SRWcLlj+/x6PWvMw39kh6VDWHpeSznZgJ2NgchTLndDDcWlPesxEDulkke/x1HlfXv/PFEOeQCco+Ahxy4RqnyxRsHr2HzNjvMr0zoUZ3a4xhL6pT7kf+oM3j23Ct/jptEN0J6IVNKRDpnc7R+g/WCA028K6p6VTKOlzL1uJn0UcJNa4DfmcYTmIzKRxkDHOeGCfHmD1pavyBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xfiPdYcXqG6ULGgdgQR1w+Y/5BjhH9xd+MiJEzedpMQ=;
 b=u1Q7j75AO2s+rRaWiTX4OarCAgqa1PY4HVtZrS4CI3+JJIAy7Lyf7Ubf4t2q6HWiqe4zGmwl7/dngL4mqyUOfFQzYlhaRMpVnPA/oZBkA6O1IxNkNnNX6WU1MURZ5yJamqqzk2NruzSNrcFpzfAQ3oIewjs2PnGdihZ9ex6676/dKv/f4mPqg32ivANUW0EsTFEJU5fN7MCw728XLIa4sQwPSGTla4x+eDXepTOniBae2Nsze1UVs4o6uGWWcFiWOcg77HoqyQfc0E7aVv3gz1pgxCi00Q04yRIE4nQLXMm4+a+tfIsKneInHYgUNvLT/dFYfFGNQa2aCDKlUb/6dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xfiPdYcXqG6ULGgdgQR1w+Y/5BjhH9xd+MiJEzedpMQ=;
 b=nZKCivcZ+gbnGnyNliBGWB6sQlYQHZw5C0ZbYonJcw7s8xhFXDnhDQ64Rht3ASfH1I4repZNBGghpWUztbB9WVEyUqnZ6mrLCO5SPpNn4JdptgkKc6/MsSDx47sbPgjZgoAZAzEsHKFP9WpQR5efJJt/l+fXURFdITkHUE1xW3L60QOJqzMp9IvCNXFlhlb6juQmGiFdgMAsfRGJtLW5mZDirRGYPcr8Qiw96nNHSXUnbMkhpIebblFUp0TkROw4SCZgB2W15o/0RjdXzZLjn2WPgOvPHCRrcok/3UcOmv8MpfxJUnPDIDzkwk8Ne6uL8hW5H5+vn/QtmXHHvdALmw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from KL1PR0601MB4324.apcprd06.prod.outlook.com (2603:1096:820:73::6)
 by SEYPR06MB5489.apcprd06.prod.outlook.com (2603:1096:101:b7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.26; Tue, 2 Sep
 2025 08:03:48 +0000
Received: from KL1PR0601MB4324.apcprd06.prod.outlook.com
 ([fe80::f8ee:b41e:af25:202]) by KL1PR0601MB4324.apcprd06.prod.outlook.com
 ([fe80::f8ee:b41e:af25:202%5]) with mapi id 15.20.9073.026; Tue, 2 Sep 2025
 08:03:46 +0000
Message-ID: <2e20cea2-9ba5-477c-acdb-e2465ea02e79@vivo.com>
Date: Tue, 2 Sep 2025 16:03:42 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHSET V2 bpf-next 0/2] cpuidle, bpf: Introduce BPF-ext
 cpuidle governor policy via struct_ops
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Christian Loehle <christian.loehle@arm.com>, Song Liu <song@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Mykola Lysenko <mykolal@fb.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
 linux-kselftest@vger.kernel.org, linux-pm@vger.kernel.org,
 bpf@vger.kernel.org, Tejun Heo <tj@kernel.org>, zhaofuyu@vivo.com,
 yikai.lin@vivo.com
References: <20250901135609.76590-1-yikai.lin@vivo.com>
 <CAJZ5v0hvbirsez==k1g9QEQ9k38OYihwsaDELi0DnO6gLY295w@mail.gmail.com>
From: "yikai.lin" <yikai.lin@vivo.com>
In-Reply-To: <CAJZ5v0hvbirsez==k1g9QEQ9k38OYihwsaDELi0DnO6gLY295w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0030.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::8) To KL1PR0601MB4324.apcprd06.prod.outlook.com
 (2603:1096:820:73::6)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR0601MB4324:EE_|SEYPR06MB5489:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e5d915a-e224-4d1d-63bd-08dde9f73e1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NGNyT3hSRnRCTVlhVS9wL2o2VmdSUjFtTlpoOE5UUmV4VmVMdEpPcWpNQ1Ev?=
 =?utf-8?B?ckxCbStBbjFYTW5JdGJJaFpDeDJZMGNsWFpwM1puQUtRSFhDSFQrcERSMFZ3?=
 =?utf-8?B?QWNYTTJaZHZCRURkSVMweW1vM09CR3RtL2dKM1VuNHdlOENKYjNWaUNFcnlD?=
 =?utf-8?B?TFlmMUg2QmlldVRXR3lQdVRVdmxpMG9RZUFQMG5SWGJKZmJWVVdNMGt1TXEz?=
 =?utf-8?B?MG5JT05jbGpiZTAzdmxxakJXN0ZiT01oQlJLaGkzY2xETGM5SXF2YUtPcXp4?=
 =?utf-8?B?TW1EKzNtd3pXV1J3K2cvY09oK0tXQ1Bmb1Q1RE45U2pkc09HTkR4cERKdlNp?=
 =?utf-8?B?VVJCTStTL3RSUXE3eTQyRFFYVlp2YnowNy9QUG1tcFlCRVVwYVJxMzUrT2VC?=
 =?utf-8?B?eWdjY1VvVlNnMER0alEwSm9tRVNaTnorSzJic2xIbjJRRUpVR1NHTHIrcENE?=
 =?utf-8?B?VGthMjdtTHd0L2VHaHl3ckVuazMvRkJKdGR6aHQzREo0UVk2K3RvdDlkb0Rq?=
 =?utf-8?B?cVFwc2JmYnBvRGhMQ1ZDQzNHMFBWSzlvcEZzUXdYVGNGb2d3c3B1eVMxVkIw?=
 =?utf-8?B?cUpQdXV0K1hzMmIzM2dYdzFnd29pUVgzVUV1Q3M3K0FhYXRhNmZ3ZnRTWUZS?=
 =?utf-8?B?S25QSnBoSU52Q0tpdWVZK2VEeEJlb0VZWlF4cmRkNnBZWDl5RHg2djhJQ1BZ?=
 =?utf-8?B?MzNaMTNlK1Jwc1ZGQjZyQXFpNnB6a3VHY1hoRzhCNFB4a1dneVFGblZNa0xs?=
 =?utf-8?B?L0VnSkZDeG9PNnZsUVpCclA2TURJb09FUlc3cGtIZUFaZUJqdkNoZXJ5d2dt?=
 =?utf-8?B?MGZqdHVPRjg1WGZMVi9oenpobDlsbTJUS3FSMm53YmZvYnd2VnlqdTVwQytn?=
 =?utf-8?B?K0hQS1R3aTNyVzZwSlNSdVBGK3JLSllYazRCd1llTTFvYTBKbDRnUmZrYk1K?=
 =?utf-8?B?S3Fqb3gxMVJiVFpnY1U2Vi96YmMvQ1NPc0xEc0d1UTU3czhQYWRGUld4L0tX?=
 =?utf-8?B?L3I5WEJubXJHVkp5ak04VEU3eFBsMlNHK0dYUWp1a0ZmRFZRRHFEYVVOUEpv?=
 =?utf-8?B?czdUbHAvbHEwRlB6RjdRM3JZWisvQk15MktQVXBFVDRIWmRYTzZ5MjFTQmww?=
 =?utf-8?B?bDgwdXdzL3FWaVVaSTZZMm1JZDlxRTBFWWFwNTYrUXBUcS9mOVk0TGlDOWh2?=
 =?utf-8?B?aENQeWg5TWlydi80UG5DY3ZvSGdEbk5Qb1k3T2JSMVIrUzNoNFpjWGoxYzNh?=
 =?utf-8?B?WGZIekVPVldTMVhEa2ZOUkQrR2oxTy9PRmtGY1dqc3JKS1lSaHZycnFRendR?=
 =?utf-8?B?dG1NWGhOb2lKQlBVcURDanZCRVJ4aldPRnI0QS84RU5WejI0eThrekRYSXUx?=
 =?utf-8?B?eUJSTG1xZ1pPZGdDYVRFVXVLb3p2ayt4NFZwT1VwMTN2ZlVrRHo4dzRVMmsy?=
 =?utf-8?B?blM0WW9TYTZ4MzdTM0grc2k4TWluZVBnVTZCVHQ3cG10b2VkNDhqQnlLckJD?=
 =?utf-8?B?UTN6M1pQekxmNGlRcmRDVUhQNXA4TGJMNHErNFl5cTk5VnhQS05pbVBtSFJT?=
 =?utf-8?B?WldxTDZtU25xcFpJMTEzOU9JMWEvNkJma2p3SWtzVHBXclhDSXNtWEtjMzJu?=
 =?utf-8?B?WmlpeGxXY2cvRlFlKzRkenZ3Nzg0aDNPSlFLRUgvbkE2SVZ1blRsT1N5K2xl?=
 =?utf-8?B?MVQxdDRIWm5hdWF1NkZIMFJ5YVA3aXNRL1dGckpmOHN2YjI0WmFBQ1NRN1lP?=
 =?utf-8?B?d3dXMW9GMjB6NE04Nll1MDliRzBjMUVObVkwMWpGVmVWaERpb0dTbGlHV1Yy?=
 =?utf-8?B?azZUZnd0NmlaaFYvS3JTS3g3RWFPdWh5N2ZKSG9RK3NhUDZhdUk3ckdIWC8z?=
 =?utf-8?B?dmpTQVlCamJxaUFxZlN5TVRWaTdLMHh0MnlaTy9kOHdScFFheVlBUkdRMXgy?=
 =?utf-8?Q?vsoN+d+7Dbk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR0601MB4324.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MFRVMkVHdmpDZ0xPN0U2YjdyL1VGL083eFdSMFh1aVNrVFIraGo0UWZyRFFM?=
 =?utf-8?B?ZFd2QzZHMm9RTmlKOTU4UGhoRDdIdVo2SFRxamdrN2RSZXlQU0NEWEJnNVVj?=
 =?utf-8?B?NWJhanlQaDRka1EvLzdWOVRHN3daaWY5NjhsSnNNZnVCRURxVkVVM2ovY2Uz?=
 =?utf-8?B?NmdDNnlHY3ZyYzNGYkdWRFgvakdSMEpPNVd3MUU4aW9zRmtSRG9HK0x6Z3Bn?=
 =?utf-8?B?QjhrWjc2RE1EZ1hhcnRYekczUjMzWTZiKzY5UGpjaDFSMDhRMnNoZ1c3UFZN?=
 =?utf-8?B?WkY3UDI3SzNvcFBmenZQcEJBeHl6c0JRWmdwNnkxU1FxYllXdzVoTUs5NnB5?=
 =?utf-8?B?Vk9MM2d1K1F0eUZMU1VuUzI4bm1RcGM0SmV0M2IveElHVFRKSWYzbWdkT1Iw?=
 =?utf-8?B?S2dIZjV2YkN5WmRJRktrNERPVDUwMDlyUTg1OElqaWI0MHcyZ245T3F4Q0Zw?=
 =?utf-8?B?RVduUDBSekZhY3hOdG55Zy96L0VoVXY5N2ZJeHJWSDFob1BBV2hOWmFMMmpD?=
 =?utf-8?B?bno4ODFoRHh0bFlRUjZOZzNMWXZKSFR6ZFFOS21OMlhUWUx1bzdQMlZnWk5r?=
 =?utf-8?B?Yzh4YVNyVFJxRDl0TFU0OUdwSDJqMmJKMXVYR3JRRWo0aHEzUGRSdm02NEQ2?=
 =?utf-8?B?OExoVTZIM0pBQzU1bVB6TXJNMys2TmlJVUhFc3d3OWE2cWFGSExLV2hGZFNS?=
 =?utf-8?B?clBxdUFHWUFTbnNEQklFUll1RDJSUUU5TUF3YW1jNVFJbWEzN1FEOXlISFI2?=
 =?utf-8?B?c3hkbzA3dExLY0p3L0c1cGllSytKOFl2NUhXekVQb2lvOXlqRTJiaWFveUpx?=
 =?utf-8?B?UVFUQkYvZE5qMXVZRExzRG9xbG1xRTVsUnZteGE5ekRwWUwzbC9UenBpZVg0?=
 =?utf-8?B?a0JLTG5lN1NjV2xnSE5lTlZ6RTNCMTdFYnVLekF4QWtzMWliUDl1UUdwVmR5?=
 =?utf-8?B?cVhRNlF3TUx3UkNxTElRTDF4RGMzV0ppelNvait5b05CM2lkY2dnUllKMDl0?=
 =?utf-8?B?UGVFNDR2ZDdoU2Viam03Rmh0bGMvWHFnTHZ1NjJtcXFWRzBCcnRGaUoxeGFu?=
 =?utf-8?B?YlpxaCt0Q2tMU2NLbFMybXRXWmpFdjNpTFBkZFBkUkpjVW1ZamtDUm9YSUpR?=
 =?utf-8?B?V1dyU1BlMC9IMFliaHNlcmg0R3NaZVNkQnFMbE55UDVJTWU3Ylk3a0FBQWFU?=
 =?utf-8?B?SXA5YzhadGZhNUpLckxwRlEvSS85d0ZhMjBzSVcxT3EzN3FNMXE4VkZFMFVI?=
 =?utf-8?B?ZVJxU1hGbWZialBOc1NMNVpZUDJxc0l6NVFrdHpGRFJXeCt0YlBWN3JDSlg2?=
 =?utf-8?B?S1EvNnI5WGRXSGRoZ05raklHUmJKMlJ1a2hwSVBoYU4yRlpvNUFkd0pObGM2?=
 =?utf-8?B?NVFrWFJoVXhYNHF3c25qaDJwY1NleDJZakp0VmNNUlhYMS94bVk1OHpyYXQ0?=
 =?utf-8?B?eTRuOUZIdlNMLzFldFFMeTlRNGJibldvS2VpNVRwWEtaeWRMd0M2dmVjNzhK?=
 =?utf-8?B?ZXltTFFJdUVlMDJxZlo1NDdsUnN0dXlzbXZZL2xkaTNRdFAvSnE0Tktzb0dJ?=
 =?utf-8?B?TkFONmh2d2s3NTRzRml0NmIya2hIOStJSGtSamtERmwrUGpPTzZBcDE1OS9p?=
 =?utf-8?B?UlZnSUovSWZxN01CWkh0REJkdXRya3ZWRUJOQkZNVm43MlZaMnMzd3prWXNP?=
 =?utf-8?B?V0E2ZXJaL0p5ekZ2amV6UVJKRldqb1E5a0RPQjJHWG1kQ0NSc0VkQWpOT2VI?=
 =?utf-8?B?YWtPWnFHaUlVK1hQQlhKUWkwLytzU1hiSThra2IrR0h2bWo1SzhiaEN2eFg3?=
 =?utf-8?B?QzVpMXN5Y1lwczAvcU90elA1MUE3S2daaWxXb0tsejIranM0aGNqWWpIU0pV?=
 =?utf-8?B?aUh2ZHAyVExhWHBkM1NCOGY2MUE3OEk5OFFsdnE3djVTNFZkdUtjeFdhNkNn?=
 =?utf-8?B?NXRqUEZ3SWdyUmpJVHA5ZEV6Rk1MTXlDWDNRMEpCTXNybWpCaGVHcnVjaFkr?=
 =?utf-8?B?QjlrOFFEbUc5OVJMK3BialFCWG1MN1RWdnp5NW1qdG11L0JxRzFITzY2dWp5?=
 =?utf-8?B?YU9YMFNnc2lHUi9lOS9NZWVMbFJuZjFnTENoTUdtQ0Q0OHZJTDMrbUx3cUJG?=
 =?utf-8?Q?UUJkdrD8/YXTfkSryu9jwWiw7?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e5d915a-e224-4d1d-63bd-08dde9f73e1f
X-MS-Exchange-CrossTenant-AuthSource: KL1PR0601MB4324.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 08:03:46.5973
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YXn4AalQ1HreNgoI1qyhFI/ESyB0k/bnEhODghrLnnS4gKDYcYb637TpQLTQm/5/PIhD5lGuyEk6gcsOQxBIog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5489



On 9/2/2025 12:36 AM, Rafael J. Wysocki wrote:
> On Mon, Sep 1, 2025 at 3:56 PM Lin Yikai <yikai.lin@vivo.com> wrote:
>>
>> Changes in v2:
>>   - Optimized the logic in descriptions. (Song Liu)
>>   - Created a new header file to declare kfuncs for future extensions included by other files. (Christian Loehle)
>>   - Fixed some logical issues in the code. (Christian Loehle)
>>
>> Reference:
>> [1] https://lore.kernel.org/bpf/20250829101137.9507-1-yikai.lin@vivo.com/
>>
>> Summary
>> ----------
>> Hi, everyone,
>> This patch set introduces an extensible cpuidle governor framework
>> using BPF struct_ops, enabling dynamic implementation of idle-state selection policies
>> via BPF programs.
>>
>> Motivation
>> ----------
>> As is well-known, CPUs support multiple idle states (e.g., C0, C1, C2, ...),
>> where deeper states reduce power consumption, but results in longer wakeup latency,
>> potentially affecting performance.
>> Existing generic cpuidle governors operate effectively in common scenarios
>> but exhibit suboptimal behavior in specific Android phone's use cases.
>>
>> Our testing reveals that during low-utilization scenarios
>> (e.g., screen-off background tasks like music playback with CPU utilization <10%),
>> the C0 state occupies ~50% of idle time, causing significant energy inefficiency.
> 
> I gather that this is based on measurements taken on ARM-based
> platforms because for x86 it is demonstrably not true.
> 
Yes, we conducted our tests on mobile phones based on Qualcomm SoCs, which use the ARM64 platform.
There are only two cpuidle states in total on these CPUs (C0/C1).
Through tracing cpuidle and scheduling, we found that during screen-off music playback,
although the task running time accounts for less than 10%, the C0 state's proportion exceeds 50%.

>> Reducing C0 to ≤20% could yield ≥5% power savings on mobile phones.
>>
>> To address this, we expect:
>>    1.Dynamic governor switching to power-saved policies for low cpu utilization scenarios (e.g., screen-off mode)
>>    2.Dynamic switching to alternate governors for high-performance scenarios (e.g., gaming)
> 
> All of this can be done without using BPF at all, so why use it here?

Thanks for your comments.

Conclusion first
------------------
Yes,it is possible to switch different governors using sysfs nodes,
but that lacks granularity and flexibility.
This approach aims to preserve the common logic of existing Linux governors
while adding flexibility for scenario-specific optimizations on certain SoC platforms or by ODMs.

Details second
-----------------
Below is a comparison of traditional governor methods
with a BPF-based approach for dynamic optimization of the cpuidle governor:

1.Agile Iteration
-Traditional:
   Governor policies require being predetermined and statically embedded before kernel compilation.
-BPF:
   Allows dynamic policy iteration based on real-time market user feedback
   User-space components can be updated via cloud deployment,
   eliminating the need for kernel modifications, recompilation, or reboots.
   It is very convenient for mobile device updates.

2.Dynamic Fine-Tuning
-Traditional:
  Involves replacing the entire governor, which is less granular.
-BPF:
  Allows granular tuning of governor parameters.
-Examples:
  --Screen-off music playback: dynamically enable "expect_deeper" or other flags add by BPF progs for deeper idle states.
  --Gaming scenarios: Allows idle strategy parameters adjustments via user-space signals
    (e.g., FPS, charging state) – metrics often opaque to the kernel.

So, by exposing tunable parameters through BPF maps,
user-space applications could make more run-time parameters adjustments, enhancing precision for specific scenarios.

Wish more additional insights you might have on this.
Thanks,
[yikai]

