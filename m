Return-Path: <linux-kselftest+bounces-32652-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26B2BAAF595
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 May 2025 10:24:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACF3F9C5F14
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 May 2025 08:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFA4622A4D1;
	Thu,  8 May 2025 08:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="dL5hfY48"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2041.outbound.protection.outlook.com [40.107.243.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81F8D221F37;
	Thu,  8 May 2025 08:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746692563; cv=fail; b=P78hJ7qX9liP/5z89UrtPQJhjxp+FQZ6Etql6q6qRAXo+ySnLmKDN1Ejkn+1aUjQ9Che7ckxVYuzEBWfE2w+FrOTkeh7C+cbi49IjOJrdH60bjLuqTso9n5/q1Fe3Ycxx6mdfS9XUyisr3iSTBIwKLyoQZrWQvB0P9lhZcYsThU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746692563; c=relaxed/simple;
	bh=yoZBBXwg4eHNOOj4leRdXS/J/tuAgoUYXYmZYgGz0wU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WH0cspVmst/UnvgbEpB7h2x5QQzG/bp3GtkmzSrDN/d1+33TEuLSXBl1grepvT2wjNKaJflwxX72U2dtJG1CjkOK2AB6WhGXpShbxmjNzHuWMW+BQe1G5SsD75n//aI19yaJf/cjVTbeqm893PA0qIb+IJBP+ACNxGlbqgXpnjs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=dL5hfY48; arc=fail smtp.client-ip=40.107.243.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LcDs4iCVMHjBApJNoFQlNWAXpqb2opbHtseNhkRJ5q8Lk3qNSzpKwv4r++JwKzWyJ9dGjPf5+31tZ1sy9axqHUFo3J5tW1bSTZfHxiRS0DbemLfXLaiiRTSd9Z8+0a9XLI/Pphjq2yo7+k4X/eJywxgOaT/1/y/i20R88uynndOlcXHZFVzeHoiQiGixj2AQn4W9jgYq6mP9fw12RgfcjgEglVOCO99CrZhhqbQm8IiMXgRtVN9a3p82BUvQK17QcHLbne9IQk1SN6XMnZ9ukt8YjdJELjcp6MIznQ0Tv/qljFuV89/zN1KEJotvcuxXw0Dz3XGMIuQrwwxkO2VHgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WdH32izubHCSuysJ9dsU7+XehuSur2VcOjgE4iM6+34=;
 b=oGLZs2iQp9RdXdSnp1eMVEkANNtdkKiRqtjbI53MXpZE92WoT0Y9Y4oiEUR9nYG/hxn452+d1xJz2fSSdVoc9AITyfBg+KaJ8WsqlWykDErtuqe+osTp5l2VTaeSdeAkMC4G9yw07+HwzTku+FH1qmW8rrHr9jlp6tjBuZrQ+Vl1+Wys0gAoFJ7Olm11M1jFkYQMHO0kCqvwVY8oGE9oPnte2YC9IzyaxmosQ1lUnIJIanlYwzOtOMuFsijetWh+wmZHDdhFJNsY2kq3er0LLXl56KkafAQi3y1uT7Ee6zA5gFMUqF2TmSt7e1DcCTYAAeFxJk1DX8LdTbRgDQv0ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WdH32izubHCSuysJ9dsU7+XehuSur2VcOjgE4iM6+34=;
 b=dL5hfY48Jf8zZO1+2xUM0p019K3YqMZpxtHcXQqB0MMmu28UVWdDx/vjrgn9ZqQH/JMGSO3xSM6E4ThHBZTqpQSxEJPhE615EOglZenFKq8HDJTUiWwlaFsijub7W6xF5Dq1nMIGX1hMGoqK4VqjeyQ8aXykOU/UFFnueZ7pCTM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SA1PR12MB9469.namprd12.prod.outlook.com (2603:10b6:806:45a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.20; Thu, 8 May
 2025 08:22:38 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%7]) with mapi id 15.20.8678.028; Thu, 8 May 2025
 08:22:38 +0000
Message-ID: <dc21ab2d-071d-4596-a339-5abcfd01eca6@amd.com>
Date: Thu, 8 May 2025 10:22:32 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3 2/5] bpf: Add dmabuf iterator
To: "T.J. Mercier" <tjmercier@google.com>
Cc: sumit.semwal@linaro.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, skhan@linuxfoundation.org,
 alexei.starovoitov@gmail.com, song@kernel.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, android-mm@google.com, simona@ffwll.ch,
 eddyz87@gmail.com, yonghong.song@linux.dev, john.fastabend@gmail.com,
 kpsingh@kernel.org, sdf@fomichev.me, jolsa@kernel.org, mykolal@fb.com
References: <20250507001036.2278781-1-tjmercier@google.com>
 <20250507001036.2278781-3-tjmercier@google.com>
 <01e0e545-f297-466c-a973-e479fcbd934f@amd.com>
 <CABdmKX3ZjeZmT=Fj_TYfpXouM6AGigcQPH7ygf3puFQip0DQ_g@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <CABdmKX3ZjeZmT=Fj_TYfpXouM6AGigcQPH7ygf3puFQip0DQ_g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0310.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f6::15) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SA1PR12MB9469:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a3fa549-0c4f-47dc-478e-08dd8e097e82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dzlHNDFXSjFhWHFVaFBPdldEWUdOV2xaci9kdWFDMGh2UHlzRG1jWVdDRkxi?=
 =?utf-8?B?Y2l6Qk0vcVkrYUNZZ3AxQVNrR09mSzVDMUVHZFJRZEtoU1VYVFNWSUVvWG1q?=
 =?utf-8?B?N29hRmJGbU5lV1czdzVybnlUNnZqcEFZSjBHVGJrRWdQTVVkUXJOTlVoWkla?=
 =?utf-8?B?Q3pEL2dqS3B1eVpTUHFheHk2eGZrOWtOam4vbmVrYkdoWFVjREZZYitWRXp6?=
 =?utf-8?B?YVpUMlFDbkpKaTNJRDluOVdaVnRSYUMzUm9BRk5aY1BiK1B1YnhIWkRtK28x?=
 =?utf-8?B?cmNoU3VSelgyNTM3T3JYSm1sc0ppOWgrU0xMZ0dPSWNaZ3BwTTBZVnVsSGp6?=
 =?utf-8?B?M0I5WUthZ2NVS0p5RExPL2JXZ3FmSHZVS2FFczRtSS9KR0VyRCtyWDdmd1VB?=
 =?utf-8?B?SUZYenduQ1pjZGhpYWdrek8xSHNHV1JBUktEc0ZETk9QL004R3hlWnRabDhk?=
 =?utf-8?B?dkRVVjdTN2kwc3ZOYXp5UFVOQm9BOXJ5QnB0dm5XamRqOVBuR203cHZDQ0Zi?=
 =?utf-8?B?elFmTFI3Zi9ZaW56SXFwOUJjbFBFaXhTSFpEblp3OFdlTWtxdUFTV3BHVG9R?=
 =?utf-8?B?ZysvTW1lSmtsVnliSldkWllZRDFmZDJDMGdvRjAxZ2R3aUw0bG9nUnJncVc2?=
 =?utf-8?B?aUlFa25OcVJvSDdSYzZzTHJsWHRDRmUramVmZnFDTG5saXNaWllJVDFJWG9S?=
 =?utf-8?B?VjNxUGpJOFY4K0V3aE00QXhvOFpDWjZYOG9yYWUwcFY0TkdPVFhlY3g4bWNY?=
 =?utf-8?B?WjZqV3JTMzdTZXVubXlnZ2ZBV2xUSndya255S2dXc0R4Q3ljL2dMVWVXYVd6?=
 =?utf-8?B?MVFEeGFHWUxOcnczQ2t5N0xIcjZNS3NzUGtkWHdiZ1Z6OVFmVmRPNkNZL3NO?=
 =?utf-8?B?VFZCYVhuWTFqUlcrMmFEaEcrdnRKKzQyd01ZTk5BUXkwSUJZZlZuRkMxVkEx?=
 =?utf-8?B?czhhMHVjU09GbG9TbThRSkxnVUVMM2FjYmd6YzZyV3ZRbzBRTEQwdXM1MnBD?=
 =?utf-8?B?cm13SHpRMlB2WkFRRDBxcHZaQmpkclcrNFZ1a1N6M2Uxalp4NDBVZExHOVV5?=
 =?utf-8?B?S3pNcCtZOHBGWWx6eTJVcWNhYXV5MXZEc0ttNTh3WCtsQVNHRHo4SlZxcXVN?=
 =?utf-8?B?Tjh4aTY1ZlBNYnVjSU0vY1FNM01iOExFczJpWWd3TWY4bU93eDZGU2VtRDkv?=
 =?utf-8?B?T3NUbE5XQUJiU2dRVTRzajA1eHJUeGpXZjlFaWlZcDJ3aVJxWlI2SVJUbmtp?=
 =?utf-8?B?VUhUWHNoUytYM0NmMFF4VDNDdDJCcmtjTEt0UXZvc2hZZjF2WlBFN1hOU2Vi?=
 =?utf-8?B?b2JadE1JaXA0U0ROL0plMnJUUkloa2FSMUhlTTRaeVN6N3AzMWFUdURzdXVO?=
 =?utf-8?B?bUxxZklMT01UdkttMTBIM2tMZ215T2hmQnlYcVVaMnY2Zi9WTzkraEM0RE91?=
 =?utf-8?B?elc3MUhscWtKSTFrallIdG5ESkhwSzJBcDk4NUpRVGM3OUJSRFMzZERzMEhh?=
 =?utf-8?B?UFNYZUZNbENJZ2ZGV1BXMDNrZmxKSW5vQkRFUWxKSkR2NFlJWldGRkFvVy9p?=
 =?utf-8?B?dXNxZkc0bVN4UXU1NFFLKzNITnhlU1M1S3dyOHZmYU83ZEx0SXlYaDhiZVdm?=
 =?utf-8?B?ZE4zWGVjR3hMcUQ3YkxXb1FiSDlzS2FsakM5MFFvakZlUkRHWThLZVpZL0F6?=
 =?utf-8?B?c01LOCtpVGJBKy9sSjJvZWhRcXgzQ2wzRmZxcFowM2tEZ09URFNTOEVxR2pt?=
 =?utf-8?B?Tng1bW1PTjBnRW54UzhvM1dxbkNNeFM5QTM0TlQwN0REU3VJNWJYR0YrOEZn?=
 =?utf-8?B?bkNwaWVzVm5VNU1EdjdJMVRuc21kUnBnc2tvVVZJQ3g2ejk4WWpqN1J4VHpt?=
 =?utf-8?B?L3ZZNHhQa284enBNQ2hEaVpKejNYOXdaNWYrbm9FclBuZXJUVzI3YlozUU4r?=
 =?utf-8?Q?5h4+v2T5Flg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VzRZOFhFUUp6RXBnL0VKWndWKzltUFhUUDlZWXVmL1I4eGVaNzA3b0tTdFlo?=
 =?utf-8?B?TlNoZ083d0lHdWFCdXdkMG1TbUZxcXdLUjlvSXJERmhsN2dQUXVtUU9GQWhy?=
 =?utf-8?B?MjJOM0Rad2pnYlJFbnR0Tk55Y0VQVE93WlpPUmpjYkRPdlRvUWVzWVRpTjlu?=
 =?utf-8?B?OWw0UkhYUU9ldEZDc1JCaXFoZnJzdFVKVVpCWUQ1SGsxaTBISmNYTU1weEVJ?=
 =?utf-8?B?ZVNsUlA1dFhwS0NPMkNHbTFDVHpBdjh5R2ZhK0JmK01oaUFNK2E5T0g3M0J2?=
 =?utf-8?B?c0VJbHhmZXpYQmhsM1MrN010SlhvcThGT3E1bldlU1lkcUpTOFh4b3Y5bnhK?=
 =?utf-8?B?cWx0djIyZ3M4U1BFcEwxTGRpbFZnU1BPUFJsbXQrcUlQT2ozcFpZd0hpWmds?=
 =?utf-8?B?U2FTSEpnWFAwTG1yUUNSQnRITytzZ2dVbWdTZExObEQvVXB2Y2t0Vm9Cd2I5?=
 =?utf-8?B?cnU1OU5DaEZHRk53RXBiYk56VzBiY0pKZkhWdVJDQm1jeXEvc3JxMDFvdHVs?=
 =?utf-8?B?V3NYZElGZUx5YkViZ1h2b0ptTnNFdHFpdUJ0R01Oa1BKQVlHUmhuZDBzY3Zr?=
 =?utf-8?B?YytRYnJieVNSV1FyZ0dPVVBWNTIraHRUb25XQUhYWjYrS01QR0prRFcvL0xY?=
 =?utf-8?B?RjNzSnE0WkJtSkJVL0xGK3g0QWwxd1YyOUV2eWZZeXdTVURxMmlTK29hdEhX?=
 =?utf-8?B?enVmWHA3c1dTVFh4UWVObHlOWktleXZRbGJMM3FRODNSR2tXZS9vTUx1ZStj?=
 =?utf-8?B?dkc4S2k4blRWMU90eFc3WmhpcDhDWUkya2hZOWdXSmFXNno0aWtiVWZ6UEgw?=
 =?utf-8?B?QzZNL25ISTBRRlhZa1k3cy9mQTB2enFFekx0RVAzKzc1aERWOGhvNm1PVHE3?=
 =?utf-8?B?VGdVdWI4K213emVpQmh6ZlBUcDl1dUlYeE95cE9GNW5iTUUxVk0rbGxaYlRC?=
 =?utf-8?B?K1ZEYXVhQk5kNXV3T2JpanlQcnZxYmYraGRjRUNITjV0UjYwbWx0OHlFMnpN?=
 =?utf-8?B?a0R3TEZmVFR1OTZUR0h1bDRFOVBXM1c3dmZuSkRVNW1UM3dPNXFyTmVLWmtn?=
 =?utf-8?B?NGVYMVJQcmdyRUFGdFI0MEdNUisyNDdlWG1waFdHZXh1UmNFaU9jQTR1TEw2?=
 =?utf-8?B?NlhEOVd3bkdocys0aHd0UHFFcml0N2ZXN3dMOUNvVjZTcXhGNmpHNmo4Y3hj?=
 =?utf-8?B?d1p1dk9pejJEVjhvSWFKSGw4dmsvTFVrbVJuSkJ2RllTSmdaYmdlUTdPSnd2?=
 =?utf-8?B?UW9Db1ZWMjNDdWs3ekpUZUd3ejRvTWRFY2Z3TVcrZ3JTQjVWWHpqM21Dd0Rk?=
 =?utf-8?B?QjhQcG5rWUZHY3R2WFk2bXIvZDJkeVhPVkQyYTEzTEpDeWdYT2IrTGN4SkZP?=
 =?utf-8?B?RTdLWnJSV2xvL2F0TlQxaWxFSUUyK1lDQ09SRUNpWmhyRFBUTHNWdmV2Zlh1?=
 =?utf-8?B?aHpFU0dGcVdQUFRZUVpYNXh6MTg3TWtyMTk5OGVuRjQwT2dhSjVJRHBwK1Ur?=
 =?utf-8?B?MElCcDhiMU1Rc1FuSWVGeERvRWY3S202dFVleXBtRnJ2R0pQOHZJVzJteHVt?=
 =?utf-8?B?S0diUHJPRG45aERyak83d1oxRndMWWVaTEptaGo3STI5emlCVEMrT3BqSlBO?=
 =?utf-8?B?M3VxTmowMUtQNGRPc3FBOW8wK01hRitqMnArcWJLd254dVJZMWVQbWtMbEpU?=
 =?utf-8?B?K3ZhckNmeWxab1doWThydU1KMHVld3Q4bHpYTU9VYlllWnFTbEpKOWhqbjhT?=
 =?utf-8?B?VlVzbndTNFUydXN2ZWRxVTdmVHMyWWxFelJlZmdmWHVVeXZLZHhDR3FKNkpI?=
 =?utf-8?B?NzZsTlNOWEQ5UUxURkh1VUpHdG5MSGFQT29XU0JOaWRrN0VrOGFUdmYxQ2tX?=
 =?utf-8?B?RnB5aC9EU2s0cHFEZTlWc21CRDNNcXljRlhJdzZGOFNLMDZ5MlllUWpnZ2sw?=
 =?utf-8?B?bUpuSUM2c0tGN3k0ZDRjMjE1MTNoQVhoZ05NMXNKbEtiR3pna2ZpaVdnVGF1?=
 =?utf-8?B?Q2Z3MlJVOGxENk1kQ2dzWFQwd2tUYTZNaFFHaFRvRlNzWXc1djlCZ09iZlY2?=
 =?utf-8?B?bGVsQzFZTENHZVkzTFgrODliakYwTGJ3aTVVSURVRzhYcnBxUWZOV20rR1hp?=
 =?utf-8?Q?RxxI=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a3fa549-0c4f-47dc-478e-08dd8e097e82
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2025 08:22:38.7941
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wEhS6JuPdYigGvUiLAXOSNWlL105GSuG3gnkujeUYAHY9R9iMUmht2BwTnlGQpXS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9469

On 5/7/25 19:36, T.J. Mercier wrote:
> On Wed, May 7, 2025 at 1:15 AM Christian König <christian.koenig@amd.com> wrote:
>>
>> On 5/7/25 02:10, T.J. Mercier wrote:
>>> The dmabuf iterator traverses the list of all DMA buffers.
>>>
>>> DMA buffers are refcounted through their associated struct file. A
>>> reference is taken on each buffer as the list is iterated to ensure each
>>> buffer persists for the duration of the bpf program execution without
>>> holding the list mutex.
>>>
>>> Signed-off-by: T.J. Mercier <tjmercier@google.com>
>>> ---
>>>  drivers/dma-buf/dma-buf.c |  64 ++++++++++++++++++++++++
>>>  include/linux/dma-buf.h   |   3 ++
>>>  kernel/bpf/Makefile       |   3 ++
>>>  kernel/bpf/dmabuf_iter.c  | 102 ++++++++++++++++++++++++++++++++++++++
>>>  4 files changed, 172 insertions(+)
>>>  create mode 100644 kernel/bpf/dmabuf_iter.c
>>>
>>> diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
>>> index 8d151784e302..9fee2788924e 100644
>>> --- a/drivers/dma-buf/dma-buf.c
>>> +++ b/drivers/dma-buf/dma-buf.c
>>> @@ -19,7 +19,9 @@
>>>  #include <linux/anon_inodes.h>
>>>  #include <linux/export.h>
>>>  #include <linux/debugfs.h>
>>> +#include <linux/list.h>
>>>  #include <linux/module.h>
>>> +#include <linux/mutex.h>
>>>  #include <linux/seq_file.h>
>>>  #include <linux/sync_file.h>
>>>  #include <linux/poll.h>
>>> @@ -55,6 +57,68 @@ static void __dma_buf_list_del(struct dma_buf *dmabuf)
>>>       mutex_unlock(&dmabuf_list_mutex);
>>>  }
>>>
>>> +/**
>>> + * get_first_dmabuf - begin iteration through global list of DMA-bufs
>>
>> As far as I can see that looks really good.
>>
>> The only thing I'm questioning a little bit is that the name get_first_dmabuf() just doesn't sound so well to me.
>>
>> I'm a fan of keeping the object you work with first in the naming and it should somehow express that this iters over the global list of all buffers. Maybe something like dmabuf_get_first_globally or dmabuf_get_first_instance.
>>
>> Feel free to add my rb if any of those suggestions are used, but I'm completely open other ideas as well.
>>
>> Regards,
>> Christian.
>>
> Yeah you're right. "first" is actually a little misleading too, since
> the most recently exported buffer will be at the list head, not the
> oldest buffer. But buffer age or ordering doesn't really matter here
> as long as we get through all of them.
> 
> So I'm thinking dma_buf_iter_begin() and dma_buf_iter_next() would be
> better names. Similar to seq_start / seq_next or bpf's iter_<type>_new
> / iter_<type>_next.


Yeah, dma_buf_iter_begin/next works for me as well.

Feel free to add my rb when you use those names.

Regards,
Christian.


> 
>>> + *
>>> + * Returns the first buffer in the global list of DMA-bufs that's not in the
>>> + * process of being destroyed. Increments that buffer's reference count to
>>> + * prevent buffer destruction. Callers must release the reference, either by
>>> + * continuing iteration with get_next_dmabuf(), or with dma_buf_put().
>>> + *
>>> + * Returns NULL If no active buffers are present.
>>> + */
>>> +struct dma_buf *get_first_dmabuf(void)
>>> +{
>>> +     struct dma_buf *ret = NULL, *dmabuf;
>>> +
>>> +     /*
>>> +      * The list mutex does not protect a dmabuf's refcount, so it can be
>>> +      * zeroed while we are iterating. We cannot call get_dma_buf() since the
>>> +      * caller may not already own a reference to the buffer.
>>> +      */
>>> +     mutex_lock(&dmabuf_list_mutex);
>>> +     list_for_each_entry(dmabuf, &dmabuf_list, list_node) {
>>> +             if (file_ref_get(&dmabuf->file->f_ref)) {
>>> +                     ret = dmabuf;
>>> +                     break;
>>> +             }
>>> +     }
>>> +     mutex_unlock(&dmabuf_list_mutex);
>>> +     return ret;
>>> +}
>>> +
>>> +/**
>>> + * get_next_dmabuf - continue iteration through global list of DMA-bufs
>>> + * @dmabuf:  [in]    pointer to dma_buf
>>> + *
>>> + * Decrements the reference count on the provided buffer. Returns the next
>>> + * buffer from the remainder of the global list of DMA-bufs with its reference
>>> + * count incremented. Callers must release the reference, either by continuing
>>> + * iteration with get_next_dmabuf(), or with dma_buf_put().
>>> + *
>>> + * Returns NULL If no additional active buffers are present.
>>> + */
>>> +struct dma_buf *get_next_dmabuf(struct dma_buf *dmabuf)
>>> +{
>>> +     struct dma_buf *ret = NULL;
>>> +
>>> +     /*
>>> +      * The list mutex does not protect a dmabuf's refcount, so it can be
>>> +      * zeroed while we are iterating. We cannot call get_dma_buf() since the
>>> +      * caller may not already own a reference to the buffer.
>>> +      */
>>> +     mutex_lock(&dmabuf_list_mutex);
>>> +     dma_buf_put(dmabuf);
>>> +     list_for_each_entry_continue(dmabuf, &dmabuf_list, list_node) {
>>> +             if (file_ref_get(&dmabuf->file->f_ref)) {
>>> +                     ret = dmabuf;
>>> +                     break;
>>> +             }
>>> +     }
>>> +     mutex_unlock(&dmabuf_list_mutex);
>>> +     return ret;
>>> +}
>>> +
>>>  static char *dmabuffs_dname(struct dentry *dentry, char *buffer, int buflen)
>>>  {
>>>       struct dma_buf *dmabuf;
>>> diff --git a/include/linux/dma-buf.h b/include/linux/dma-buf.h
>>> index 8ff4add71f88..1820f6db6e58 100644
>>> --- a/include/linux/dma-buf.h
>>> +++ b/include/linux/dma-buf.h
>>> @@ -568,6 +568,9 @@ static inline void get_dma_buf(struct dma_buf *dmabuf)
>>>       get_file(dmabuf->file);
>>>  }
>>>
>>> +struct dma_buf *get_first_dmabuf(void);
>>> +struct dma_buf *get_next_dmabuf(struct dma_buf *dmbuf);
>>> +
>>>  /**
>>>   * dma_buf_is_dynamic - check if a DMA-buf uses dynamic mappings.
>>>   * @dmabuf: the DMA-buf to check
>>> diff --git a/kernel/bpf/Makefile b/kernel/bpf/Makefile
>>> index 70502f038b92..3a335c50e6e3 100644
>>> --- a/kernel/bpf/Makefile
>>> +++ b/kernel/bpf/Makefile
>>> @@ -53,6 +53,9 @@ obj-$(CONFIG_BPF_SYSCALL) += relo_core.o
>>>  obj-$(CONFIG_BPF_SYSCALL) += btf_iter.o
>>>  obj-$(CONFIG_BPF_SYSCALL) += btf_relocate.o
>>>  obj-$(CONFIG_BPF_SYSCALL) += kmem_cache_iter.o
>>> +ifeq ($(CONFIG_DMA_SHARED_BUFFER),y)
>>> +obj-$(CONFIG_BPF_SYSCALL) += dmabuf_iter.o
>>> +endif
>>>
>>>  CFLAGS_REMOVE_percpu_freelist.o = $(CC_FLAGS_FTRACE)
>>>  CFLAGS_REMOVE_bpf_lru_list.o = $(CC_FLAGS_FTRACE)
>>> diff --git a/kernel/bpf/dmabuf_iter.c b/kernel/bpf/dmabuf_iter.c
>>> new file mode 100644
>>> index 000000000000..80bca8239c6d
>>> --- /dev/null
>>> +++ b/kernel/bpf/dmabuf_iter.c
>>> @@ -0,0 +1,102 @@
>>> +// SPDX-License-Identifier: GPL-2.0-only
>>> +/* Copyright (c) 2025 Google LLC */
>>> +#include <linux/bpf.h>
>>> +#include <linux/btf_ids.h>
>>> +#include <linux/dma-buf.h>
>>> +#include <linux/kernel.h>
>>> +#include <linux/seq_file.h>
>>> +
>>> +BTF_ID_LIST_SINGLE(bpf_dmabuf_btf_id, struct, dma_buf)
>>> +DEFINE_BPF_ITER_FUNC(dmabuf, struct bpf_iter_meta *meta, struct dma_buf *dmabuf)
>>> +
>>> +static void *dmabuf_iter_seq_start(struct seq_file *seq, loff_t *pos)
>>> +{
>>> +     if (*pos)
>>> +             return NULL;
>>> +
>>> +     return get_first_dmabuf();
>>> +}
>>> +
>>> +static void *dmabuf_iter_seq_next(struct seq_file *seq, void *v, loff_t *pos)
>>> +{
>>> +     struct dma_buf *dmabuf = v;
>>> +
>>> +     ++*pos;
>>> +
>>> +     return get_next_dmabuf(dmabuf);
>>> +}
>>> +
>>> +struct bpf_iter__dmabuf {
>>> +     __bpf_md_ptr(struct bpf_iter_meta *, meta);
>>> +     __bpf_md_ptr(struct dma_buf *, dmabuf);
>>> +};
>>> +
>>> +static int __dmabuf_seq_show(struct seq_file *seq, void *v, bool in_stop)
>>> +{
>>> +     struct bpf_iter_meta meta = {
>>> +             .seq = seq,
>>> +     };
>>> +     struct bpf_iter__dmabuf ctx = {
>>> +             .meta = &meta,
>>> +             .dmabuf = v,
>>> +     };
>>> +     struct bpf_prog *prog = bpf_iter_get_info(&meta, in_stop);
>>> +
>>> +     if (prog)
>>> +             return bpf_iter_run_prog(prog, &ctx);
>>> +
>>> +     return 0;
>>> +}
>>> +
>>> +static int dmabuf_iter_seq_show(struct seq_file *seq, void *v)
>>> +{
>>> +     return __dmabuf_seq_show(seq, v, false);
>>> +}
>>> +
>>> +static void dmabuf_iter_seq_stop(struct seq_file *seq, void *v)
>>> +{
>>> +     struct dma_buf *dmabuf = v;
>>> +
>>> +     if (dmabuf)
>>> +             dma_buf_put(dmabuf);
>>> +}
>>> +
>>> +static const struct seq_operations dmabuf_iter_seq_ops = {
>>> +     .start  = dmabuf_iter_seq_start,
>>> +     .next   = dmabuf_iter_seq_next,
>>> +     .stop   = dmabuf_iter_seq_stop,
>>> +     .show   = dmabuf_iter_seq_show,
>>> +};
>>> +
>>> +static void bpf_iter_dmabuf_show_fdinfo(const struct bpf_iter_aux_info *aux,
>>> +                                     struct seq_file *seq)
>>> +{
>>> +     seq_puts(seq, "dmabuf iter\n");
>>> +}
>>> +
>>> +static const struct bpf_iter_seq_info dmabuf_iter_seq_info = {
>>> +     .seq_ops                = &dmabuf_iter_seq_ops,
>>> +     .init_seq_private       = NULL,
>>> +     .fini_seq_private       = NULL,
>>> +     .seq_priv_size          = 0,
>>> +};
>>> +
>>> +static struct bpf_iter_reg bpf_dmabuf_reg_info = {
>>> +     .target                 = "dmabuf",
>>> +     .feature                = BPF_ITER_RESCHED,
>>> +     .show_fdinfo            = bpf_iter_dmabuf_show_fdinfo,
>>> +     .ctx_arg_info_size      = 1,
>>> +     .ctx_arg_info           = {
>>> +             { offsetof(struct bpf_iter__dmabuf, dmabuf),
>>> +               PTR_TO_BTF_ID_OR_NULL },
>>> +     },
>>> +     .seq_info               = &dmabuf_iter_seq_info,
>>> +};
>>> +
>>> +static int __init dmabuf_iter_init(void)
>>> +{
>>> +     bpf_dmabuf_reg_info.ctx_arg_info[0].btf_id = bpf_dmabuf_btf_id[0];
>>> +     return bpf_iter_reg_target(&bpf_dmabuf_reg_info);
>>> +}
>>> +
>>> +late_initcall(dmabuf_iter_init);
>>


