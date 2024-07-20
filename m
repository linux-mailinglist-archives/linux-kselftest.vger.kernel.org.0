Return-Path: <linux-kselftest+bounces-13966-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 11B3A938261
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Jul 2024 20:00:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91F2D1F2207F
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Jul 2024 18:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 459481487E1;
	Sat, 20 Jul 2024 18:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RbZz/jT0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2066.outbound.protection.outlook.com [40.107.244.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 510677462;
	Sat, 20 Jul 2024 18:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721498416; cv=fail; b=bWiSGQAHybxjq49tu1dKMSYyg5OPQ2F4sRJ0n7jlrLtp+S1HHHscl6mRQevA6yoAyF2VxFAOgCuK8Lb1qmXLV4bXhEXErk4s2k+gspiX524Bt2mylG7cZ7nAJZeTIz/6K1+y0PQjl1zVlmQ4e0YzetN/9OzThysgFNzU8roqM5Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721498416; c=relaxed/simple;
	bh=iZjAI0cAwAAjQ5/47co5L/6y0UWOu1eUp8pjRQzmYV8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dmPbUOP5IbdcvcsInI0sjvW7EbqvDY7qvYQrgn2YW2blF0AfSGSVABaymKmoGw7TfJep25X9zD9/xrVjDGU1SPbr6PX8nL1QuiCFiKubSJUPGOVRAIVEFWRz+Nwx/KDa3zxoPXxGcXZDvV0Rfk22nGIaMTYZuHjh/0imuL9hjXs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RbZz/jT0; arc=fail smtp.client-ip=40.107.244.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iPV94aP3P5ujXs21e/37GZv0EtHVcsSiz8tMPI69TYBI0Yqmar3lw6XrVSElB8gh6PcpfJOeWoaZyl/TZ+bZqEoidZQC2RhW/M0mo5soWfHwqK2KxTtmwaI1tHRgpvTzMpC19T/rGBoPNlIrzIYyIJCeAz9UzL/e1ncwmKxi8NQuFXaiifZdE7NKwhS+/qlSb09iuMP2XqT8rbxu20wIzm1SZPr73tfPWh9y47Y3RGCnzZETKI5/nzYp2k5fDfY5O9VYdsNvQNtxMF2bLx6FpIXSssd/PryTdmo2imoqXrWWA1s/oSntScnmjxRg5n665VpK/hRIW07LfU2BmlZXbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1WSs0HajkaQN7Q5/C9FStVZhf3d2/qD34XIfip9QLms=;
 b=L9H+G834F2cJzv0vH8MYaBnOnqO621qGptuYhm+WWG+aF4hQYBD5bt2yTx/dpV06woeydmnf8damAppVfyBEKskObR6SaiWc0Ia+42UWa/uMI6g9JdIUQ5kpKAa8ViehpmY6N5IP+XCDdxW4HKYjfyLmnui8PV5ugs3ERkVX5pP/IoKuMHZNXMYCQjEzL2PiKZ0GO0b5kRo/B6EkY2E/JML4gxoPTU3rU6m84e807FZgXZXtxAZqjS0QbDYQcsDXtGEQq+J7j2WyiFqBWF7dPNbhV0LFL4Gi2y8ysbrfRlvY4zohfYI92gMrKl0nzl/4bxdXPKMQmPUpYV24Yr47OA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1WSs0HajkaQN7Q5/C9FStVZhf3d2/qD34XIfip9QLms=;
 b=RbZz/jT0t7LNPklLqwnpk9wTHXySNvumuJ+ruO1vdspVbzaP6C3OmT6lhP1GM8Hj4r0mLuZtoHvss970lDLwl7wDFgMtEc3nZ+Dp6F8nxiI7tj9ru82eB0gfeTu925dX6xJgck1kW3dRfU90qd3jtP2tc9Jy9FeDOCc4p6vYPBqz1qjt0xA+PQECT8G7QvGOwLbOZxmeCPPhkSgIwvyRuLxCzhz8ThFU14L+nycNoNR9fhPhF3x02tPjtzbNM/N3DVZ39EBf0i8PbPbkZFZW20W0u5M1bywjrCefD2R2oZdV3zFi7XYWQ6oqwAGmUgKWIFk2bqpFbHbF+cJZggu1DQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by MW6PR12MB8705.namprd12.prod.outlook.com (2603:10b6:303:24c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.30; Sat, 20 Jul
 2024 18:00:09 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07%2]) with mapi id 15.20.7762.027; Sat, 20 Jul 2024
 18:00:07 +0000
Message-ID: <c9613b11-5751-400f-ae83-4590d4593ab4@nvidia.com>
Date: Sat, 20 Jul 2024 10:59:10 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Documentation: KUnit: Update filename best practices
To: Kees Cook <kees@kernel.org>, David Gow <davidgow@google.com>
Cc: Brendan Higgins <brendan.higgins@linux.dev>, Rae Moar <rmoar@google.com>,
 Jonathan Corbet <corbet@lwn.net>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <20240720165441.it.320-kees@kernel.org>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20240720165441.it.320-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR01CA0048.prod.exchangelabs.com (2603:10b6:a03:94::25)
 To BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4130:EE_|MW6PR12MB8705:EE_
X-MS-Office365-Filtering-Correlation-Id: dc1898b2-6d88-47e6-4e47-08dca8e5ca28
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UVRiNmgrYzJ5ZmgyclgrRWp0Q0xQOW5xb2NJaGEvSExEelhtcVd3S2dSL3ln?=
 =?utf-8?B?dm1oQmJvYnkwRDFuWUo3UzdzbGc0OUEyZ1QrY3Z6YlRtVzM3ZlRscHlhS0JZ?=
 =?utf-8?B?S0w2WGlDUzhLK3JsVzV1ODQyVzBzMXNGdUlkd1l2UjY4RjVDcnkycXQyV2Ux?=
 =?utf-8?B?ejdYenpnbWQ1dE9lS1dWaDA2V2p3NXJ1ajNXU3BoTmViQzJnOU5TY0VoZ0h3?=
 =?utf-8?B?UmVHQ3F2Wk1FNmtzbml6RGhndFlXZ2pXNWdjczFxZVYwdThYT1NMYisxY1d0?=
 =?utf-8?B?MDZpcTRsSVV0UlJIT0VsQitmRjJyRVF0SlFIVUIra1ZYbGdTWHExZEp1bHZK?=
 =?utf-8?B?dXV5bENGK25WWmlnUVNaNTQ4TGdlSFJmdURsa1dCL0NJb3NYQmFzSXh1MXFT?=
 =?utf-8?B?enhmVks3Q3U2cnk3ZEx3TjlSdTFiNUVNVldFZjRESVY2ZmZPZzVOTFZGbEU4?=
 =?utf-8?B?UVNzTTBEQ3h5ODJZTXNud0pDKzhLdkZBV2ZMcmUxcUdDYlE4VGs2SmdOS0NG?=
 =?utf-8?B?cVdvcnplSmtYWEk5TnNiY2ZvMzNqWWNjV2ZsdFF2b3dtQmZVRlJkS3lheHgv?=
 =?utf-8?B?WVNXcFJYc0t1NXYrQXJ6SldnenhJazJ2dWhFY3gyalNJSDdiU3ViNjl5bEEr?=
 =?utf-8?B?R2V6Ym9qaGpzTVF0U1FnMERWZGJrZ0ZjQnU0YzI4bEVUa3lOWmRLbmxxZ3dO?=
 =?utf-8?B?d2JDdnBtK3J2R0wwTzZQQjBJU04wUTVUZExCWkRDdklyaDc5YnBYeUNvaFJj?=
 =?utf-8?B?eXorVjRJTWx6eFJVNjYvTzRmR2NQaUhWMDZpcWZPOUl1Z21udjhucFRIbmxu?=
 =?utf-8?B?MUwzSkllRUJoWDJIeStzcnBiT25qcG9QTGtHR2dtRE9WZWhINUYza0l5dFNB?=
 =?utf-8?B?R3hNSDhSTzJNMVdocWJZNHpDaWluQnRNdUdGMjhQb1VhREk1bGdaQ1dSM3pm?=
 =?utf-8?B?RGRvQ2xlaVFYVVNsNVI2c3NaZXZyeWY4cVhMd2Nsdk5rbjJIZVdVWkJ6bzBv?=
 =?utf-8?B?T1JXSno3Y09IcVhXTElvWjdFTUNZMk9qc3ZmcG54NmtCTHlaOSttNG1yTUtt?=
 =?utf-8?B?dFZpNm5TTmo1MDliSzFqcWIvSWZ1a2IvRVBvUS9FYjBIRzBWbnN6cGpCdUNZ?=
 =?utf-8?B?OVBjYWJQUlEvalMvbGpKWW4vS1J4RGF5QXdkVGNxRW5OVVdTSHo1QnFscVVG?=
 =?utf-8?B?QTJ1cjEvbjhyYXBKWlBROWliTFRodVJQdTNFbXZqa05PWWt6Q2F0b0t5QjRa?=
 =?utf-8?B?NlZzR3RDMVNOa1ljbFg0UWs0M01jVG52ZVVTVHdDSHNRbVVTNWdtaDhjdVlU?=
 =?utf-8?B?VW1hcndKSFA5cmNTSXFWZFU3citaS2NuV3hWVHhYZ01IYUR4OXVkaUJqQnlM?=
 =?utf-8?B?aythTDRTNnJGd08rQW80STFJbjJVUjZZbjkzVTAvcWVzMk43QVpaUGZGQVNk?=
 =?utf-8?B?VVJ4OWV2NVU3Mk56RkpWbkR4WXVuVjlZN0hXUGNYUkpxMHAvcjNiMkJ4UDNy?=
 =?utf-8?B?czNlQ0xjS2RRcnppT04zZlNDRXJQVHRSaFZPdGo2dlkwbHRkZFNhT2N0aHBY?=
 =?utf-8?B?SVNWNFlKOUwyU29nM3dCZEdheUZ5dHo4VHRJS1I3dkFZWXlaQzhkalNLZ3Vv?=
 =?utf-8?B?RnZ0dHBPL093d2JRa0wrOEJaVGFJdXVsRUQ4eE9RQ0VYK1JqY1Z6ZUdOZjFD?=
 =?utf-8?B?TjkzMlpJL29JTDRiZEZKa3JBUCtOTDdEZ3hyQVVHWjM4cjRWTG1DUkJhWkJp?=
 =?utf-8?B?ZU5JZzU4M3hRaUMyaEQ3QThEWXdQUkNCUmc4UTdqU1A4WXhBM3kwbHpHZ1h5?=
 =?utf-8?B?SjVHWjNRa0t4SUVHcDdTZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NVM2ekNORnMzSmZDb2szM3doWXN5WUk0VDVVZ3RzUzFPNzd5d1JWeE8weE9p?=
 =?utf-8?B?MFBqcHlGVGhpRy9FQVBubzFhYkwrbGNuOXpoQUFGUVJUQlBNQVJpUlJGY3Yr?=
 =?utf-8?B?L2MySFdUZTVLaEhXZG45MkdvaU84Y08rT0syWFpTOUVjQUJjQUxsL1RBUW51?=
 =?utf-8?B?ckU2ak1ZUTQ0aHNVOTQ0LzUxTm16azVxYit6VThhMXFnQW4ycG1scG11MjNh?=
 =?utf-8?B?SXpyaHJaaXJxZEdBM04wa2sxK2x4dzJGSDFJV2hpOVBXQVEvSDVrYlk2YkR3?=
 =?utf-8?B?RytoaDRIdGxzd1d2eitNUVl1VngvaFNlQUxTNzNZVkxFeXVPYXpoNWJjeXRP?=
 =?utf-8?B?L1VBZXl3SFJKUThZRkdlTWUxWTdkelRBWVBWdzdDVFZVQXphblZobUNJdVZO?=
 =?utf-8?B?eXlrMWNSRVFkdGtjYVJZYjlObmFNb2M1RXovSmxUazUxNHpkRVJEbFl2ZkpT?=
 =?utf-8?B?RUw1aS9OUjc0N3dBUTQ3K0wvTTdPR1h1UyszZlkza0dOaEtzNXFUclNJNE9t?=
 =?utf-8?B?S2JtakR3RHdHcUpqWEZwQUpkSHpHNzdJU0IzeFlYaFBBVHBTeW5RZ0VCeFU5?=
 =?utf-8?B?K3pwaVF5d0Vwa01IeXNmaHNBSzVJRk5pdkFpWXlqd285anloYWNWS1AvamM0?=
 =?utf-8?B?SldtMm84OUJuWnF0cmhiS1pRTEwwWFFoT0h2bGpvT2RhYVpZV1lMenZFaU9z?=
 =?utf-8?B?S0dzam1LSlFSa0tkL1dhMHp4bXF4dEVIcjJ5SmUxY2dXR1FEWGRVZzlNd2pq?=
 =?utf-8?B?RHE5bCtiYXZxU1YzdzhRcUE4eFoyRTFWejRzWWZRZmNUbDBEbGFGSEVXMFZt?=
 =?utf-8?B?SFBaMzNuVVVQUFhvcCtBSDB3dktJU0w2cmVHNmRZT1UvVlQ5VURDb1pjSW9S?=
 =?utf-8?B?ZUJlcWI4NWJzTjJYalVRSHhUUHplM04ya0RXS3pVVWtadUZYeVJFMDVab002?=
 =?utf-8?B?WkF5aThtMVVpNFNRa0FSSDBMZ29TNE4rVk43b09xdTN2WFd1eGcvekFJSldK?=
 =?utf-8?B?L1VUMmlhZ2VBOEd2SnZtSldQZ1RhU2tQRlVMb3Z0bDYvbXUrLy9OT2h1Tldj?=
 =?utf-8?B?VmVFZXNwSm4ybEFXWHh4S2p5Q1RsQW5jYTFUM1h0SG11Q3g5RlZNOGdjaXZr?=
 =?utf-8?B?UW1XYVBocUxCcUZWeE5TSUM4TlZNS0JWbEhOQ09XQWV0MnhJVFllOEFUL3Zp?=
 =?utf-8?B?cnZ2NjBURnY4M1FWemkxcTFiNlVVdGl2bEZUcVU0N1l0MEh0Rzc0Qkg0RTVh?=
 =?utf-8?B?Y2FXMkE2ZlNYQ2NpRTZxdE52aStja2FuOUFQYjlGVkZPNmZ3Uk9GVmdsN1Aw?=
 =?utf-8?B?VmZXa1lkQmQrU2dTNXdnQytkZWJHWmJ5eDgyOE5NUzBHT01pelJ6RHRqbWFZ?=
 =?utf-8?B?UG5hcHlub1lLOEdiZW05SGhieG91aENlVmt0OXl6WllmNkY4bCt2MDVGTUlK?=
 =?utf-8?B?enRSTkQzbTRGT1V0U1hTNDIxdllkWmRSUm5WTnY1OWtPTkhTUTNkNE9SOGpj?=
 =?utf-8?B?Tk9JendjSUVsa2xWTXBoRGI4UHVGZ2RuemQ2WUlHbE10aFQvMk1pdVNwNjln?=
 =?utf-8?B?T0FtY3hKT2pJSEZVaXpGdUcrcXpWUlB1TThubFFyYUZ2aUZVMUMrU0FWajhX?=
 =?utf-8?B?SEh6bytzMUs0dFBCcnlOT1JGRHQzd1BQUE1IeUdkbFQ3MURnUlg5d3JaMjdX?=
 =?utf-8?B?YzF0Z2c5OEtVTDJhL3BwdkpDZDF1aW1vUEtiVmJieWFqSDVwSExIZEVmbjNC?=
 =?utf-8?B?L0VCZnZBL1Q2cksxQnNadzZQN2RtWllBV2tvakdscmxYc25MalVmKzl1M1J2?=
 =?utf-8?B?dEFQZEVqL2ZQYzBXb2d6ZUpNOFhSV2ZGUnNOc0IwSHlmcnkvY2ExMzNGZk5P?=
 =?utf-8?B?WVNGenRyd1lEMm9CYWtZOHpodCt6OEVLSkdnSGtDL3hoYzJkZTNWT2lVdDJI?=
 =?utf-8?B?NlkwOVFrL1IrNDRRNXJ1emNLQUVPaUFHZ3ZZdTVldVFVR1M4S3hHVkxzeFJu?=
 =?utf-8?B?ODhrU0tYTVlVempodDVsN3VKbU9TMTl2dnNtRmUvbnpHdzJWM29oblAwL1Mx?=
 =?utf-8?B?VWhRZ0lBSmpJZTB0Y3k5SGRVTGY0SGlaYTJ4a29ZNGwvNTlZQks5Q0I1VXVP?=
 =?utf-8?B?SmJLNXV6Q1cwU0dQendPZmsyVHVCb1BBc2dyQlhnUU1pVGNKVHVlRFJQcWVv?=
 =?utf-8?B?Mmc9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc1898b2-6d88-47e6-4e47-08dca8e5ca28
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2024 18:00:07.3606
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7WyH1e9IklmtR3aIyPUqnyDlto3ZyDb9gssL/kS8ZZ9jqzpk/B6I2Q3MHJTbeqhCHUHoyjQKvmSdCrFkPTJP5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8705

On 7/20/24 9:54 AM, Kees Cook wrote:
> Based on feedback from Linus[1] and follow-up discussions, change the
> suggested file naming for KUnit tests.
> 
> Link: https://lore.kernel.org/lkml/CAHk-=wgim6pNiGTBMhP8Kd3tsB7_JTAuvNJ=XYd3wPvvk=OHog@mail.gmail.com/ [1]
> Signed-off-by: Kees Cook <kees@kernel.org>
> ---
> Cc: David Gow <davidgow@google.com>
> Cc: Brendan Higgins <brendan.higgins@linux.dev>
> Cc: Rae Moar <rmoar@google.com>
> Cc: John Hubbard <jhubbard@nvidia.com>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: linux-kselftest@vger.kernel.org
> Cc: kunit-dev@googlegroups.com
> Cc: linux-doc@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-hardening@vger.kernel.org
> ---
>   Documentation/dev-tools/kunit/style.rst | 25 +++++++++++++++----------
>   1 file changed, 15 insertions(+), 10 deletions(-)
> 
> diff --git a/Documentation/dev-tools/kunit/style.rst b/Documentation/dev-tools/kunit/style.rst
> index b6d0d7359f00..1538835cd0e2 100644
> --- a/Documentation/dev-tools/kunit/style.rst
> +++ b/Documentation/dev-tools/kunit/style.rst
> @@ -188,15 +188,20 @@ For example, a Kconfig entry might look like:
>   Test File and Module Names
>   ==========================
>   
> -KUnit tests can often be compiled as a module. These modules should be named
> -after the test suite, followed by ``_test``. If this is likely to conflict with
> -non-KUnit tests, the suffix ``_kunit`` can also be used.
> -
> -The easiest way of achieving this is to name the file containing the test suite
> -``<suite>_test.c`` (or, as above, ``<suite>_kunit.c``). This file should be
> -placed next to the code under test.
> +Whether a KUnit test is compiled as a separate module or via an
> +``#include`` in a core kernel source file, the file should be named
> +after the test suite, followed by ``_kunit``, and live in a ``tests``
> +subdirectory to avoid conflicting with regular modules (e.g. if "foobar"
> +is the core module, then "foobar_kunit" is the KUnit test module) or the
> +core kernel source file names (e.g. for tab-completion). Many existing
> +tests use a ``_test`` suffix, but this is considered deprecated.

For this paragraph, may I suggest this wording below? It attempts to
explain the _kunit a bit (without leaving anything behind that would need
to be changed later, if/when people rename things from _test.c to _kunit.c),
as well as fixing up the sentence structure slightly:


Whether a KUnit test is compiled as a separate module or via an
``#include`` in a core kernel source file, the file should be named
after the test suite, followed by ``_kunit``, and live in a ``tests``
subdirectory. This is to avoid conflicting with regular modules (e.g. if
"foobar" is the core module, then "foobar_kunit" is the KUnit test
module) or with the core kernel source file names (e.g. for
tab-completion). The ``_kunit`` suffix was chosen over the older (and
now deprecated) ``_test`` suffix, because KUnit behavior is sufficiently
distinct that it is worth identifying at file name level.


> +
> +So for the common case, name the file containing the test suite
> +``tests/<suite>_kunit.c``. The ``tests`` directory should be placed at
> +the same level as the code under test. For example, tests for
> +``lib/string.c`` live in ``lib/tests/string_kunit.c``.
>   
>   If the suite name contains some or all of the name of the test's parent
> -directory, it may make sense to modify the source filename to reduce redundancy.
> -For example, a ``foo_firmware`` suite could be in the ``foo/firmware_test.c``
> -file.
> +directory, it may make sense to modify the source filename to reduce
> +redundancy. For example, a ``foo_firmware`` suite could be in the
> +``tests/foo/firmware_kunit.c`` file.

Whether you use that wording or not, this looks good, so:

Reviewed-by: John Hubbard <jhubbard@nvidia.com>

thanks,
-- 
John Hubbard
NVIDIA


