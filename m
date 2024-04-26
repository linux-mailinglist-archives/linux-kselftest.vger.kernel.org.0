Return-Path: <linux-kselftest+bounces-8921-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 00A3F8B3A74
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Apr 2024 16:56:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 251321C2225A
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Apr 2024 14:56:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 802141487DC;
	Fri, 26 Apr 2024 14:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="F4eM3b4c"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2082.outbound.protection.outlook.com [40.107.220.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 053E31E504;
	Fri, 26 Apr 2024 14:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714143401; cv=fail; b=O6Dn3M4uX7ozHEao99EyWiaLsAFO0ksQ1Ue+PGOXujXxOVBo+vbExz4VG07S4ludkfnbUep4B7v7Q75hVPB8rUAcPoedG9xLu7XBpAX96aTBebYtXBHiysDoB5R1BnLqy80W3QoojXjGCG2HE9zhiVso3YhO86Nw5Db27pDll64=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714143401; c=relaxed/simple;
	bh=oLprFrPZ/lzi7N30kfp50+nWYQi5W60Pvsxep77XKwU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FOP7vmpHf+nZDIvM9r8wdz0I/WwDZEupvG5acON4tLq9RlexODsZinG3u0v9JXp5LOD/Tiu8PYlRGPg67+o9RFJ/Z1GRB3h1+g5GQgmFl6N627BM4VKZL+m9cHYz8GDOaIAMTVw8p8NkZywrFwXaTJwnAhRA2yP/6/fRdJgZuIw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=F4eM3b4c; arc=fail smtp.client-ip=40.107.220.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mEFnCi75f0QKTffZbo+DdsLziY7s71+7jwHUV0zFb+MkJsiqGZurnT6aqq8gH8kWKv2a/fKvn027zIvFBnf1OY/pbaR02b6XBm9eD+66BoWXxTuJep67qr978I53hVFHOwRP9qw0EiNuKlxGspi+ncdUy6e7Dn/lavD0AAZk+x5XrqfSWmVgjYocY30cb6iGv1EmR83NEBMnfkM9QIfwVW7BYrfEOuO2hfFgThz52B3Jg7Rsl674I/RGw8xR56/Y/1itYDUxsrCpzN0Y3Fanp/t5g2Nw5RMeKeAKkgWC3HuAK3DYXQZyAIX02yjogbfTvsFXAwbRDoQDcVsM6TLcjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L4EXhqTc7cAXdpwPdn9YwGqGL2bc/ZgWX5WyCLFPH5c=;
 b=nrWqI779MtEqckc2Y/OBXYCzlygWBN+T1SHhyUu9VeTmb8/enytWZPwM15g2eideawzcZFzMgd39FVMlXib85Zg1sX0q7C6543B24usNne7aZH6naTU3q3rqEfxwggdcrAb8HWg9BGEnxu3OAXkgXdT0cB793j9t/NCBmYK8jzKvNZjCZGS2B31XMYxWNoTeJGmmr+lodVJjkvpkNCSi2DvbbBU0/Y2s5xLopLjgOw8Y4oU7iXVxTeHW36Lq8Oqa57wJgt1jqx1ZdRrBd6KPX6DteLA7cQIjaD9WPVVJt/Xhk98qDpivJbnyvuB3KpuhvwTxtKk0RyF8OU3DDv1/6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L4EXhqTc7cAXdpwPdn9YwGqGL2bc/ZgWX5WyCLFPH5c=;
 b=F4eM3b4c6U+OA4wFx3bPMjhiAW5XQJ3129CK2D/Ynee+CGfAT/jS6GOXBYhejfKvsW4PZRxtZ0srR3AgQZLZx+o9MyybuQOZzaUaECoLjlFFqWN7DEVsVY2mkJPhYkOt+3iUPKaeFDMW7XkkQI2hh+ka22Y/V46uNxV4sPxkBjk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by CH3PR12MB8710.namprd12.prod.outlook.com (2603:10b6:610:173::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.31; Fri, 26 Apr
 2024 14:56:36 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%4]) with mapi id 15.20.7519.030; Fri, 26 Apr 2024
 14:56:36 +0000
Message-ID: <b618c170-78dd-78fb-0123-c6aa8d9125c9@amd.com>
Date: Fri, 26 Apr 2024 09:56:31 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v2 4/4] selftests/resctrl: Enable MBA/MBA tests on AMD
Content-Language: en-US
To: =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Babu Moger <babu.moger@amd.com>
Cc: fenghua.yu@intel.com, Reinette Chatre <reinette.chatre@intel.com>,
 shuah@kernel.org, LKML <linux-kernel@vger.kernel.org>,
 linux-kselftest@vger.kernel.org,
 =?UTF-8?Q?Maciej_Wiecz=c3=b3r-Retman?= <maciej.wieczor-retman@intel.com>,
 peternewman@google.com, eranian@google.com
References: <cover.1708637563.git.babu.moger@amd.com>
 <cover.1714073751.git.babu.moger@amd.com>
 <e3bf1fbbe3ab2d9c2dc1d9669a791de140dea248.1714073751.git.babu.moger@amd.com>
 <911547f7-e952-f771-867a-57c1de738c39@linux.intel.com>
From: "Moger, Babu" <bmoger@amd.com>
In-Reply-To: <911547f7-e952-f771-867a-57c1de738c39@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR07CA0050.namprd07.prod.outlook.com
 (2603:10b6:610:5b::24) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|CH3PR12MB8710:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c2ddab7-0e66-4e6f-441c-08dc660111f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bmFzaFJPUXkzMVJsdGVsanBqRWpNUzBBSEJiNzR2N04rOXdjRDM4SDd6bWg3?=
 =?utf-8?B?RmlqdndXem8xVUw5SGpxeW9qc3lSWlA2REdqVU40NG5FOGJ4UWh5NVJSV25X?=
 =?utf-8?B?TmRRV1l0SGQ1RVZZUnJaSnBuVGFUcUQ3U2VFYzdlR3pXMWQ0aFI0cGt1ajNT?=
 =?utf-8?B?ZXlJR0VVRHdCaUEyVy8wVWJqR2hkZlc2bWtKVjIvQktVRFNUV0VjeXRHa3Nq?=
 =?utf-8?B?bU5PRFRCdlcxdWxIR3pNMkRCZEw2a3JEYlA3RWQwaTVORnE1V3p0YWVldXkr?=
 =?utf-8?B?TTlSYjZKT3F1V0JpK1NmbjJYMVBicU1ZUVhMNktqZXVYRlVGQXp0ZUM1c3JF?=
 =?utf-8?B?TVV1REFpMW5mZXlLV1N5OEQ2TVBNQzd3QXBhS09UcUZSSGsrTXRaVncvNWdy?=
 =?utf-8?B?MzNESUVodGRSQlU1a1hINzRTbFZhZEJPYzArbklPdlU4NWtiNlJ1THJ6VGJh?=
 =?utf-8?B?MnlyNUZHMENPZnhXbFFlNnU0VEQxUFFXMThFUTkyYVloVHZROXlaTEg0VkFp?=
 =?utf-8?B?NXhKWGxCWnZQMUp6cVBETXdjamNQVUVOOU5SMFNaSmd5WGVwZjljTUpwYmVB?=
 =?utf-8?B?UUE2Ni9odFY2UFFTUzUvSmNVWVhlZGhHd2ZjN29FTVh3ZGxkcFBScFlyWFIx?=
 =?utf-8?B?Z09mRDQwK1QxRFI0YVVqc3Z5MFJrdTY5bExYbkxPVStEQXJLNElUbkpMMTd2?=
 =?utf-8?B?eGJ4TlFJYTBqZ3BjbGNDOXlITERpTXp2RkxrYkExTXNYWGY5SHFHVWxJWHZH?=
 =?utf-8?B?Ujk1bzdhTmtsSlpoQ29BeDZaUmJDWkFBNUh3T2luaFBjMmMrMDVnUGRHVjRn?=
 =?utf-8?B?cE9sSklMVjRBVktob2JwTHQ1cDFsL1VmbzlwdEdyZzJoNGtKd2cxaHhscEdZ?=
 =?utf-8?B?WGVLYVkwRFJJN1E2M2JxdU5lalN4Z01Na2pUbGdZYjZDYlgvQkNEeU9vUHo0?=
 =?utf-8?B?d3FBZnVSM25TM2ZuZUdIcks4ZTNDV0NLS1pCcG5YdUljazROZ01VaDlSR3ox?=
 =?utf-8?B?a0txZ0NpeHlBalJLOUh2NzFjY0RHTnBRRW1yR0puTDZJbnVISXVVOTBCUzNP?=
 =?utf-8?B?VkUva1FpSU9WdFlOM3hkYTBsK3Z2MzN0dEgvVFJCanZZSVkzNGFLb1ZJUHpZ?=
 =?utf-8?B?dVd1a2ZKVTZ4Q3B3aGY0YUlKS1QyaWZiSDdBL2VTVVlRUE1xTEM0ZTJrQjE1?=
 =?utf-8?B?OTgyMlpjQnROZytIditjcnBKSTBYRXpOUXg5VUk1S2FiWUNZNWlIN1lYZERE?=
 =?utf-8?B?RkY4YVQ4TVBDdVo4OE1pYWl5akQ1QUllSEVVVHphbEhKQ2JpTXlZeXduK05F?=
 =?utf-8?B?U2pndm1HcExaOVZ3NklBbEdYNkNZMnZDR3daU2RaQUwwbTlFKzE4U3NldE9U?=
 =?utf-8?B?a0hpKzZXM2VBY2JTeTFrYjdCeDZ2R09qUzlnZlpFd1dGb0RhUlppckgyTGZE?=
 =?utf-8?B?bTg4ekE1ZGQrNENKVlh5OFFweHJWYVF5VmhyS0xrMWlpVzV2WXJKWE9TSmVU?=
 =?utf-8?B?L3dLZTJmMzErTXdhK21OMlRPWTV0NmN4M2FGeVVYZTgvU0VMT1k1eGFFVGlm?=
 =?utf-8?B?ZHZsbXZlNHk1SmRHZVJnemQxQmFjcU5PVFpZMzlEWW53bElxSFZYdW1qNHYw?=
 =?utf-8?B?N3dtU1IrTTNTcGx6OWRyT25Eb1hpMGFOZXZNVWkwbDc0VkcyOVNrNm5JTEw0?=
 =?utf-8?B?RFhhVjJQdHFsZ04yZ0dDcko1blR3YzA1NTlGT1NvdlBwOHJGS2pmckVBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T1J1TC9yc1FGYkFaeTRtRmpoN2pLczdjQ1d1Yjl6cWlRWU1mYVdMRllGYUNU?=
 =?utf-8?B?NkRublpJOTVSaHFRc3ZVZDlFNVd4RzQ2am5PSElYeStsM0hQN20rcm5ad0pT?=
 =?utf-8?B?V3lVZjMwVm44Qm1OMGxjMFlycmRKVkN4eGEyaUQxY2I3T3BWanlNcnA5RlJt?=
 =?utf-8?B?T0NHeEpVZm5kdzZLRUQvU1A2MXg4ZStvUnNsZWpJYTZNcnFPUHFDRXliTTRO?=
 =?utf-8?B?YlV6VTd6Z3gwQUpwaDNSQnBBOTBBRExxbUlzbzRZT28wdDRwejI2M0tmSGto?=
 =?utf-8?B?WjhUTGVZR2lLbzVaQTAxTDZzU3MzSDBRZk9id0dSY2hDUWh0MFNpbjV0WFFX?=
 =?utf-8?B?ZGRtc3FrV1F6Yms0ZThVOVE4VzRTYmN6NGhBQ1FTblJJKzU4eEZDREJUd3pR?=
 =?utf-8?B?U2JiaDZJa1pQeWc5TUhGbUdFMklPVmxCcjBlaHNINFZkVkViS084ZHJCeVlo?=
 =?utf-8?B?TW5DcTc0UW9xUklpcjRzaGV6S3hhemREUE1VemFyU0kybU5pRnlyMXNXRVdX?=
 =?utf-8?B?dVYrNXFjUkQ2cWtLK0tTN1ZXanFHdkNMNDhlcG9ZSno2MUVoZUluUG1tOHJp?=
 =?utf-8?B?ejY0VWFHalFNUW02eE5lblVUZDlqSzZaSFhqRFp0czZyYloyRjNlY0lKcVRZ?=
 =?utf-8?B?MjdScmNsNXNUdWZ3bHV4Q1pjSzgxMjh0K3h0WU9NMmRwMFNRM2xQOEJUWktV?=
 =?utf-8?B?ZkYyS1lJTU5Ic29XRkpWcWM5aFNDekwxcW9uQ202cFpkc0h5cGJqWFZKME81?=
 =?utf-8?B?cEFXZE5KOWl1Um9ZS0NnMjkzc2NjNmJ0NmdVMTVHOE4zM1RldnVtQ2srcG5h?=
 =?utf-8?B?azVTVG9KenRvVmFuTXZDTlR4RnRQNC80eVZjMnBobnhtd0lqMG1veW1Rb2E5?=
 =?utf-8?B?YVN1TU5Say93bFQ2OS9ia2ZhOWVwNkprdW9XNmlWY3UvK2RIaDJCcHNDZHox?=
 =?utf-8?B?VldTVjNBMmdjQmd5QWw1bXd2RXhZNk9NMUhpaG94ZFZocXExN3QwRzA0ak1G?=
 =?utf-8?B?dFU1VzI0NzJJTGVxck5LSlMyeGdWMFIrNUNONkZZelpIaXNWU1l1eGg0ZER5?=
 =?utf-8?B?YnRSQk01ZlIxS29QL1JVNW5HQ2JxWHVVSWw0eHJkYWFEV250R3htYzFHUEp6?=
 =?utf-8?B?aFBFd09PNk40OTRiSzBIdEQyRDBXdnBwblFoZGJoZXBQTjgxbGZqRkliSXpq?=
 =?utf-8?B?NVI2Z25nYktTOCtoZ2l3WGFZaHA4b0lYbFphaFhlVEhWTXFqYVVyN1I5ZTFa?=
 =?utf-8?B?N05tcTNGUEJZQytqZHFING5hTlZidVlwdVFpdGtNaVJFbEZCbVg3cHFVcWh4?=
 =?utf-8?B?UCtCcGF2SVJGUDZBVFNKTHZ6RjY5cXdQcWc0T2hQVlMxVGVVRm5OWWNzdEhu?=
 =?utf-8?B?cnRLdkF3dzFnUk1WcGI4R1NGM1VGWnczeFFaR1YyYnUrenYvd2VBSmxzQmlB?=
 =?utf-8?B?bjZmYVk0MkUydnFicVFKellhMlhydFBFa254Q3BsNWgwUHZkcGhxM1REbG5j?=
 =?utf-8?B?MU4xMFJTRGthL3RFclMyVzFieUVWVkNKWlp0NlRWWndHLzdXREJmUlRvYTlS?=
 =?utf-8?B?VWQ2QkNrd0tTTnZMTFFFU0hzS3BtSHNhRnNHblhuRGhOWHVQVTVjTDIvOHEx?=
 =?utf-8?B?RDE3eUNzMGVkY0lkcUlSMjF4Vm5YNWFVS0hHY0JKQ3dKVjdOcUVpY2lqUWZU?=
 =?utf-8?B?UnR2Qm5hb1JTckF5OU1PeFlSbk1aR2Z4S2ExcHdrSHMvNStnOWVGb3F1MVhM?=
 =?utf-8?B?V2FwOEpuc3o1d1ZBeTZpZU40L0t1d2QzbzgxK3FTZmdsR25pNkZ3L3VSVWtj?=
 =?utf-8?B?bEFYT1JFYUVrOEtZQlBSazhJdTlFREU2blZPME9tL0U0UmtaRGhYUEtwTTVU?=
 =?utf-8?B?NkhxaDhIQnh1Yzg2bWZVSnpWb2kwdUwxTlJjbHlsUHBjTCt5ZDBHL2tLSzZG?=
 =?utf-8?B?RTYvYWo5UG9VWEc1S20rMlBjWUJCcGdwamRJd25DdmdpU1JsZEc3TStRTHhy?=
 =?utf-8?B?cXRXMG03TXg3ckFKajJHa21yeDdvdndlcmZtZUdLbDlPTU5YTVR5TW93Z0Ry?=
 =?utf-8?B?UC83L1Z3bCtoSXVBeUZSeCs4ZXhIOTJxajUxQS9sRVhPd0EyVzVsVHczMzcv?=
 =?utf-8?Q?MtsXovktWDsgbMpv9jIUOn9uK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c2ddab7-0e66-4e6f-441c-08dc660111f9
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2024 14:56:36.3827
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HYdrE9Froasmx5rIyag1GIGRBktE9woGBTtB2PaudI28mMYyAmJnCYkTGJyyBwF9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8710

Hi Ilpo,

On 4/26/2024 2:06 AM, Ilpo Järvinen wrote:
> On Thu, 25 Apr 2024, Babu Moger wrote:
>
>> Enable MBA/MBM tests if UMC (Unified Memory Controller) support is
>> available on the system. Tests will be skipped otherwise.
>>
>> Update noncont_cat_run_test to check for vendor. AMD supports
>> non contiguous CBM masks but does not report it via CPUID.
>>
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> ---
>>   tools/testing/selftests/resctrl/cat_test.c | 2 +-
>>   tools/testing/selftests/resctrl/mba_test.c | 1 -
>>   tools/testing/selftests/resctrl/mbm_test.c | 1 -
>>   3 files changed, 1 insertion(+), 3 deletions(-)
>>
>> diff --git a/tools/testing/selftests/resctrl/cat_test.c b/tools/testing/selftests/resctrl/cat_test.c
>> index 4cb991be8e31..b682eaf65bfd 100644
>> --- a/tools/testing/selftests/resctrl/cat_test.c
>> +++ b/tools/testing/selftests/resctrl/cat_test.c
>> @@ -314,7 +314,7 @@ static int noncont_cat_run_test(const struct resctrl_test *test,
>>   	else
>>   		return -EINVAL;
>>   
>> -	if (sparse_masks != ((ecx >> 3) & 1)) {
>> +	if ((get_vendor() == ARCH_INTEL) && sparse_masks != ((ecx >> 3) & 1)) {
> This looks independent change to me which should be put into own patch.

Sure. Will do.

Thanks

Babu


