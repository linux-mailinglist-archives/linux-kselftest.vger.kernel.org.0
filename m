Return-Path: <linux-kselftest+bounces-25996-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02F3BA2C37B
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Feb 2025 14:26:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8919316A08A
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Feb 2025 13:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BB791EEA30;
	Fri,  7 Feb 2025 13:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="aAALQFS0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2123.outbound.protection.outlook.com [40.107.101.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A8C4EB51;
	Fri,  7 Feb 2025 13:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738934814; cv=fail; b=txvnV178jx+91b9waXIM+C1OsYXXC63XN1L1izZ2dHDB8LfDx/QpmhrlXZsdghqKcP9yUtEKkfJ7w9P6eFllOqFEEjtWDchh9oNnYwm22CWveiyy4llAHYDOq0notwXr93pvj0/cP3duUn2ho5Uerno24dxwa44OwMCHiSAe9o0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738934814; c=relaxed/simple;
	bh=XCcgzucFP0G4vb9Q5DfHMgm7jkRjZV26Ke2xQvW8lXM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Alrd/yOlLCYNkloDbFY6joLWlYt+JBoEHyfLShyHEYfGcyWy+feGNyXchV1zrHKnPIZlsZnC9Hw/PYPrpNKsI/JjS3DG1RHXocJukspiEvuA+dm0I56j0V6fU9efQRKhTLt5fQKo0y/IyHW8s0YYfeZnyhaINvuiKR3mVpXVnYs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=aAALQFS0; arc=fail smtp.client-ip=40.107.101.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qIE5KXz6KbuTakU610Lom16EweJHK/UNwlaoToJTtUmeiYzHGxeW9Ppw99ZGkKC2BxPrbZ9+gvzGYCKvDnJ4+Y4vcT/V3dRM5LjEeqsI3IR9xzBJDEDiFEz9fToQM3ycARdUF/F8H3QLaSKdkW7GayWxSZ+0+W1McgM9FdkW8L0/+GgU/5EA6JSYlZmixx2uy0Zs1/HVRiV0/gKQGTlO2MFV/QHIUiVajWJeXs3Gxc23RqAiD7d9FJlPk/5T0OhCWt6YY13F1BN3SdAm5z5ejLDN5cS1R8rkfJxHvbrhkpyN65irtlO9FRyfDGMNEWNRZR6sp4cDmuxINGp8x7qkUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E+dK/I1hkxX5oq1+fbbKoD7U8k0NTjvHGIKV9nV57ss=;
 b=ok842Uv5HdxVU6RTF/jJNYi37+0f54EaYsZGuTgHuKLthFXw1Vwi9eygnfzgUQjq0fkOwFHA6yWt0WeFeO9d+RuH1BXG+7azqC5ugZnTtTUUNIf4c3BM0zGqOI9WOV23ef5ehKjq7K15nDeHKW/DpfzFPB5w66kXc/a4fmgds4f63KNouXRHa/rxRfMzdc4qpJyO+K0kI4otwJ1hbx+mayWRUtfQKNOICLrRQLAXluEgI29uSAl/tow7RfPh0XboGsRWVxrnuZ0H6XCzLHMTFsdv10l+hcbyoGG8e3rh9yQDQdHf//hi1h7FXxZCouZ5OtEAn+Z5ccCLLGiEGXrnxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E+dK/I1hkxX5oq1+fbbKoD7U8k0NTjvHGIKV9nV57ss=;
 b=aAALQFS0noB3aJqNvEf7NxfbtfpXCm//IdAgC91YkRq7BbJ3xH5W9xaOODTi3Y4OzG04M3D6fIeMNDiiRaIS/D40ZRdXLIulWndlyWrF9b4rTq1qsZn7/5GRC8gMMgVIFjHEqrw4hzlyoNPpgt48Bm1UCU89XiLuyMoQWDWnccI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SJ2PR01MB8101.prod.exchangelabs.com (2603:10b6:a03:4f6::10) by
 PH0PR01MB7384.prod.exchangelabs.com (2603:10b6:510:105::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.6; Fri, 7 Feb 2025 13:26:48 +0000
Received: from SJ2PR01MB8101.prod.exchangelabs.com
 ([fe80::292:6d9c:eb9a:95c9]) by SJ2PR01MB8101.prod.exchangelabs.com
 ([fe80::292:6d9c:eb9a:95c9%4]) with mapi id 15.20.8445.005; Fri, 7 Feb 2025
 13:26:47 +0000
Message-ID: <9b4a8665-4fb8-42e7-b63f-d154ae75a4f0@os.amperecomputing.com>
Date: Fri, 7 Feb 2025 18:56:41 +0530
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
Content-Language: en-US
From: Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>
In-Reply-To: <86o6zeu668.wl-maz@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR01CA0146.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::26) To SJ2PR01MB8101.prod.exchangelabs.com
 (2603:10b6:a03:4f6::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR01MB8101:EE_|PH0PR01MB7384:EE_
X-MS-Office365-Filtering-Correlation-Id: ee6b4e3d-0713-42a2-9db3-08dd477b1283
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ckJQMjBSKzlxQTZ3c3dVSFZsWnpDa0phUW1xbmM3TlFVOUhjMmNzR3VpWmRL?=
 =?utf-8?B?dGF6a3htQlNWZnRVVUtFK2VndDhZN2VmdG5uVUwvbFJaYThKY1Y1Vk4zeHFL?=
 =?utf-8?B?ZE1OZ0h0Q283V3c1YktjODk3UTVzYlp1eGFIOC8vQ0JPZStiYi9kbEJodjFP?=
 =?utf-8?B?ZzZVNE5UVC9QTmo3ZDYzNVNrQnZyWVBEb2ZRWE90bkl2ZXFFSmVmMUswZGVa?=
 =?utf-8?B?WHNHbWk4bW1MQXpTVG54citTajdGbXM1akpiMENQQi9mNTJySGhUbnkwL0oz?=
 =?utf-8?B?cWJKMThnUjhjTDE0ZElZWCtIQXBtUWw5Rjl1QlRENkl1ZzZ1Nmx3bUVaRWEv?=
 =?utf-8?B?c0MxanBoMHlxVnZjUE5tVnp5U0FXdUNqY1FNbjJDaTdFU3FYbVBJTm5VU2kw?=
 =?utf-8?B?TkF0cTFMdGJ2eVB5SFZKS1RoWkUwU29TcDNBUmlob2FnL3ZVWFJNcUNjUUZt?=
 =?utf-8?B?L0xOT2h2VDRFZkJqa1AvZ1U1VTV3VGgvcHRoaXVLVTB0a09mVGhPTU5vSERM?=
 =?utf-8?B?MzJCbFBONm1Ecks1c3Q4eWZJY1d2UjVpeUd3Y1JIVkdrMGp0b2g5SkE4dWN3?=
 =?utf-8?B?cjhuRGNhb043UEVkbkNwV1NXL1NwQjQxdW1xQWMvWVlQdFhjL1JhMC9uZm9q?=
 =?utf-8?B?MnZrbjFJRVhkMk1SdEhXUlM3SFJRYXlCcTluT0FqSzlGVU9UTmc4VGJtZ2hP?=
 =?utf-8?B?NkZHaGJBanFKajdsYlJmUmRxTGpVWDVaajhhVlMvNUY1cUdiK2FUSzdMYWZl?=
 =?utf-8?B?NnJVYThaT1NRSGRxbWdVRkQ2YUNIa25SdzVTdm4yOTd5SkhaVGhzL3I4RWRm?=
 =?utf-8?B?SDRyRXBiYVQ2ZXE4cElSRXRnQUtaSzgrVzdTczhCNStmMDVBOHdhTDVEamNw?=
 =?utf-8?B?RFNLQXBzWUxiTUNXOGRkQm40MlVMZjIyenExQlNxd0wvcnl0WVFVT2NxQW1l?=
 =?utf-8?B?eFhIMExqb2xkRUhQSnpqQ0RhRHVUSWNPVTU0cFFsZmdxOURwWWJHdTBwdVZo?=
 =?utf-8?B?RFkzKzBlLzhuMzdXSzZBcG11LzhEK29EY3lFdFBJUUhQWEIvQkUxR2FTR2Jn?=
 =?utf-8?B?R2thOHZLeWVpQjZkZWFkODVyUWxiYndGeXc3eUQ4OUxKTzd0ZmgrdnJPQ3NI?=
 =?utf-8?B?WHBUZVozRENhQXUzdHIzQWQwQmFlamRWS0F6U1M5MitqRlhCM3BoNDBNZmc5?=
 =?utf-8?B?dnNsejVtcVQweXB4cVIxdFlXV0hWdEZCZGxtNnFwTmFjNjFON0s3bTlCWG1t?=
 =?utf-8?B?V2x1RGFYejkrdERjb1IydGhRQ3FwdmlOS0JmNFhtaTNpdzFvOUlJOFpKbyti?=
 =?utf-8?B?NTJER2x0Z1ZGdTg5bTFjaFdMVlZZcUdYaEZNTFJzbE5oRTQ3Z01MbkZMSjA1?=
 =?utf-8?B?QmNtT1JTZm16a1ZzbE5JUldDb2swTnZMOE9seWU2VjZmNWlKOEZtemtBSmJo?=
 =?utf-8?B?K3NTZjhUd2xTbHFJL0UyMGM4VWtvYUxNZVdTdTVEcmpuRVVvK2pEOCtSb0FO?=
 =?utf-8?B?bGdXbDNRRXpGdXRtZ0pVbVgwb1Ayc0xCRTZyak1valNVTXowZlhsb3FocENa?=
 =?utf-8?B?NDdSRzhKZXFiRjYyTnNMTjhwRnNzT2tXNEg4NmN3azZEZC9ZLy9KNDNnSjQ3?=
 =?utf-8?B?NTdKL2RwZ2FPL0FHQkZ0YlhvRlJPOHpOeGRrSmo1WDQzalZxaXluc3NySDFH?=
 =?utf-8?B?MDV0aDJmT0xOWWoxLzZIMnFhVFo2ZjkyazhUOXp3Yk1OeDErQVlEd1I2Uzk2?=
 =?utf-8?B?UTM3MzBubFNIMjEwN1d6dTR6WktUa2xwUGFuYTRrYWxHd0Q2ZlgwUXRCZ3N3?=
 =?utf-8?B?ckVnVURsSi9kTE5QVEZFdWhmTG1uZHoxblU1YVFkOFRDOW05V2RpQS9KeTZi?=
 =?utf-8?Q?/g/gcv02zdz+x?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR01MB8101.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RU1SejlwRndrcmNaMmpDYlgvTlROUnNMcUx0cWJmNGwwakt5QXlYaGRjOEtW?=
 =?utf-8?B?dkFobzR6L0xIbEFySGduMTNvMkZyS09ISEkyVmZYZ3Z2dUlxZmhlVUZxLzFr?=
 =?utf-8?B?L1VlRUtwWEc3TEtRYzg4L1MxcjJYRHE4dzBMbXo0RU4wVlp1RWIvUmQyd2Vk?=
 =?utf-8?B?NmNBYzZkcUwzYnFiUjNBN2lCejkrT21vOHN5UGFieW8xSm5NMVdpSHVDR2do?=
 =?utf-8?B?N2hoOEhKWHZVL1NyNnUvTWtFV2RDVE55MjFSc25mVFFPWU4zNmxKd0RBajkw?=
 =?utf-8?B?aGZZNFc3aWFyYVFtSkQvVU5CQlZGYUVCR1RCMnRlTy81cytnRXdTaUlVN1px?=
 =?utf-8?B?UmlzMU1NNXFsamQ4MmVWTFJrbWhySlVUQzByMjdjaDhuTXkzZW5SU0MyejJZ?=
 =?utf-8?B?MWl5SGQ0WlRyU1NvVzI4czkzcDE1QVl1ZUJBUVFTb05KSTlxVkFZV2hIejhF?=
 =?utf-8?B?d3pTRU80TU1RVUt1MjFkV0Z5STRGRWtRbm1XejlZU0RseG56MWZTTHBnU2xt?=
 =?utf-8?B?bkIxcmcwb1M1aDhFWXA5TkYxRnp3ZlIwUUlqMzlMeDdiSGhSREM4dDhjMmIz?=
 =?utf-8?B?RkdwRXh6aXJva2h0L1NvSjNPQ2h0UDhieHh4R0xwWFlrNXV5ZHE4dWFNbWhS?=
 =?utf-8?B?ZnNzREhSVnpneWdYc0JEUEdqT2J2V2hrYVBiQXpUeGNLa3JpU2dsNUNaS25P?=
 =?utf-8?B?QmNZVUJYMWZsaktmZzc3TlkydUg4UmxyTnI5aGRKOTE4QWlRUzFrSXFxK3VX?=
 =?utf-8?B?YUdwYnovM0x1UHc2bnhsdlNhS1pBRldET3Y3NVFuVEhPNUd1S00ydGVxVCsw?=
 =?utf-8?B?STFSbG1hWGF0bTNTLzdGWlNxS2dOcnlQU0N4RmM1L252Yzl4ZTd1Qmo3dlJ4?=
 =?utf-8?B?R01GSXZVbnRmZXl3NzdYVkhWcEZjeWFFc1BPYkY0cUt5SWU1UXBsQlJzdXla?=
 =?utf-8?B?dVhSTThaUk83RGJsNGxiK25yaldZeGZFdExoOXRnRXNOejU4Nzd6d2xGc210?=
 =?utf-8?B?TkQ4dUJOSEhNNG5FR3lKbkVNLzNHNmlXSjdteTlRMHJianJHbUJDakZtZEtQ?=
 =?utf-8?B?LzJTRkNTNUJZdlFnNTRUTDBtVjg1clRJMW16czU4c2tmL2EyRnM3cmdneW5p?=
 =?utf-8?B?cTdZeWY3QXYrWkpzcmhHL2xVcEJiOXphR2EzdEtTeTZaNEpjams5RTNPelJ5?=
 =?utf-8?B?Tmo1M3hWMVJ0a0VnQVMwSjBESGEyeFdUNGUxbVU4MkNleXczd1FsbkRTSTFE?=
 =?utf-8?B?REdyaFR3Mjg5UTRqQnMvdThDK3RpcCswazAwTytXbWVPb0pGNFJ5YzQ4dWl6?=
 =?utf-8?B?TEJEQU5QRElHQlhwUWFybWtJUTZHSFZoOTBpZ1N4SFdUOHZLa3gzaGs3K201?=
 =?utf-8?B?K2kyN0lLRlhGYTM3b2dDSmNVcDFhZzJ4L0grY0JBSTB1V1ZvSlJjaE4xZHls?=
 =?utf-8?B?c2xDcENyNDl2TlFCekozRUJQRDhuMUgvbzVtUjlnS1VEK3kzTTVyUnMzeUgw?=
 =?utf-8?B?eUlxSGd4Nm1VK2hYM2JtYzk4c0lsMC9FcW9WMGFvbzFKUVBBWHQ3ZHUyOWU3?=
 =?utf-8?B?dURHUE0rQnlNaG5oRkhaV25uYXE5a1hYOW5EUkxzZzBFRGRhd1p0MjNvN0lm?=
 =?utf-8?B?Z0FyOEFYUjFqc3Bhby81VGpLc01JWGlSblZoSFViM0k5Ti9tWDFsbk1GS1E3?=
 =?utf-8?B?MVJhUFA4MlVpVWdsSjd1YUd3NGR2ZXFqRVd5dVQ1cnJZZkczdmhlOVh3Z0Np?=
 =?utf-8?B?Q2xTZVE3Q3hUN2xvaG1qbHpFSkFQendMYlBNVEdSTEd6Ykd1MnF5RDFwWUFW?=
 =?utf-8?B?L2tRK0p0VU1NS0czMG9WbzN3TnVIaGVzYS9NaXpDRlNkRkhSQ1VQYVVmT291?=
 =?utf-8?B?MDhRaExQbENMcXpXa0REUkI1L0FzSndWSWtvYXRLZlRUUHV4ZVNHajNiaTA0?=
 =?utf-8?B?Ym0welZmNzBKL2djSDhJcllGd2swemlVcEllL1N4cEdkSVJoMFoxNWF3dzdE?=
 =?utf-8?B?Z3FoT0tYcGt2ZmxNMDgyQUc5WE5jb2QyalAwYXRaKzFQSkQ4cE1CQndGMEV6?=
 =?utf-8?B?aGxjTHd2Q2Rlblp2N2lsT0J3YmYzazd1V2p2YzBIY2w1aXVVZHNRbUpWUTQw?=
 =?utf-8?B?UFdOL3NKTzU5N1VHWnVmTTFTRkhxek43TzZnbHlxUnNpUUdOenBXTFZlMUpy?=
 =?utf-8?Q?+RB5u7euYcOIwtBEC0z5A911f4Ma7s9XF+0R5TwdGV/6?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee6b4e3d-0713-42a2-9db3-08dd477b1283
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR01MB8101.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2025 13:26:47.6379
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o7ltzgCbB6+rlCzD6d8Ec0WbwaxyFX+XTNQm6N15aBPbOv9+15y3Cyq37CLJi4QlwBPZLfhRIw0hz7dKBcFqq4AHrXUjKKnvmpEqFSQgpQLZilwxaYH8u8C9hT1ONBNX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR01MB7384


Hi Marc,

On 07-02-2025 02:44 am, Marc Zyngier wrote:
> On Thu, 06 Feb 2025 16:41:19 +0000,
> Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com> wrote:
>>
>> This patch adds the required changes to init vcpu in vEL2 context.
>> Also adds a KVM selftest to execute guest code as a guest hypervisor(L1).
>>
>> Signed-off-by: Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>
>> ---
>>   tools/testing/selftests/kvm/Makefile.kvm      |  1 +
>>   .../selftests/kvm/arm64/nv_guest_hypervisor.c | 83 +++++++++++++++++++
>>   .../kvm/include/arm64/kvm_util_arch.h         |  3 +
>>   .../selftests/kvm/include/arm64/nv_util.h     | 28 +++++++
>>   .../testing/selftests/kvm/include/kvm_util.h  |  1 +
>>   .../selftests/kvm/lib/arm64/processor.c       | 59 +++++++++----
>>   6 files changed, 161 insertions(+), 14 deletions(-)
>>   create mode 100644 tools/testing/selftests/kvm/arm64/nv_guest_hypervisor.c
>>   create mode 100644 tools/testing/selftests/kvm/include/arm64/nv_util.h
>>
>> diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
>> index 4277b983cace..a85d3bec9fb1 100644
>> --- a/tools/testing/selftests/kvm/Makefile.kvm
>> +++ b/tools/testing/selftests/kvm/Makefile.kvm
>> @@ -154,6 +154,7 @@ TEST_GEN_PROGS_arm64 += arm64/vgic_irq
>>   TEST_GEN_PROGS_arm64 += arm64/vgic_lpi_stress
>>   TEST_GEN_PROGS_arm64 += arm64/vpmu_counter_access
>>   TEST_GEN_PROGS_arm64 += arm64/no-vgic-v3
>> +TEST_GEN_PROGS_arm64 += arm64/nv_guest_hypervisor
>>   TEST_GEN_PROGS_arm64 += access_tracking_perf_test
>>   TEST_GEN_PROGS_arm64 += arch_timer
>>   TEST_GEN_PROGS_arm64 += coalesced_io_test
>> diff --git a/tools/testing/selftests/kvm/arm64/nv_guest_hypervisor.c b/tools/testing/selftests/kvm/arm64/nv_guest_hypervisor.c
>> new file mode 100644
>> index 000000000000..5aeefe43aff7
>> --- /dev/null
>> +++ b/tools/testing/selftests/kvm/arm64/nv_guest_hypervisor.c
>> @@ -0,0 +1,83 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Copyright (c) 2025 Ampere Computing LLC
>> + */
>> +#include <kvm_util.h>
>> +#include <nv_util.h>
>> +#include <processor.h>
>> +#include <vgic.h>
>> +
>> +static void guest_code(void)
>> +{
>> +	if (read_sysreg(CurrentEL) == CurrentEL_EL2)
>> +		GUEST_PRINTF("Executing guest code in vEL2\n");
>> +	else
>> +		GUEST_FAIL("Fail to run in vEL2\n");
>> +
>> +	GUEST_DONE();
>> +}
>> +
>> +static void guest_undef_handler(struct ex_regs *regs)
>> +{
>> +	GUEST_FAIL("Unexpected exception far_el1 = 0x%lx", read_sysreg(far_el1));
>> +}
>> +
>> +static void test_run_vcpu(struct kvm_vcpu *vcpu)
>> +{
>> +	struct ucall uc;
>> +
>> +	do {
>> +		vcpu_run(vcpu);
>> +
>> +		switch (get_ucall(vcpu, &uc)) {
>> +		case UCALL_ABORT:
>> +			REPORT_GUEST_ASSERT(uc);
>> +			break;
>> +		case UCALL_PRINTF:
>> +			printf("%s", uc.buffer);
>> +			break;
>> +		case UCALL_DONE:
>> +			printf("Test PASS\n");
>> +			break;
>> +		default:
>> +			TEST_FAIL("Unknown ucall %lu", uc.cmd);
>> +		}
>> +	} while (uc.cmd != UCALL_DONE);
>> +}
>> +
>> +static void test_nv_guest_hypervisor(void)
>> +{
>> +	struct kvm_vcpu *vcpu;
>> +	struct kvm_vm *vm;
>> +	struct kvm_vcpu_init init;
>> +	int gic_fd;
>> +
>> +	vm = vm_create(1);
>> +	vm_ioctl(vm, KVM_ARM_PREFERRED_TARGET, &init);
>> +
>> +	init.features[0] = 0;
>> +	init_vcpu_nested(&init);
>> +	vcpu = aarch64_vcpu_add(vm, 0, &init, guest_code);
>> +
>> +	__TEST_REQUIRE(is_vcpu_nested(vcpu), "Failed to Enable NV");
>> +
>> +	vm_init_descriptor_tables(vm);
>> +	vcpu_init_descriptor_tables(vcpu);
>> +	gic_fd = vgic_v3_setup(vm, 1, 64);
>> +	__TEST_REQUIRE(gic_fd >= 0, "Failed to create vgic-v3");
>> +
>> +	vm_install_sync_handler(vm, VECTOR_SYNC_CURRENT,
>> +				ESR_ELx_EC_UNKNOWN, guest_undef_handler);
>> +
>> +	test_run_vcpu(vcpu);
>> +	kvm_vm_free(vm);
>> +}
>> +
>> +int main(int argc, char *argv[])
>> +{
>> +	TEST_REQUIRE(kvm_has_cap(KVM_CAP_ARM_EL2));
>> +
>> +	test_nv_guest_hypervisor();
>> +
>> +	return 0;
>> +}
>> diff --git a/tools/testing/selftests/kvm/include/arm64/kvm_util_arch.h b/tools/testing/selftests/kvm/include/arm64/kvm_util_arch.h
>> index e43a57d99b56..ab5279c24413 100644
>> --- a/tools/testing/selftests/kvm/include/arm64/kvm_util_arch.h
>> +++ b/tools/testing/selftests/kvm/include/arm64/kvm_util_arch.h
>> @@ -2,6 +2,9 @@
>>   #ifndef SELFTEST_KVM_UTIL_ARCH_H
>>   #define SELFTEST_KVM_UTIL_ARCH_H
>>   
>> +#define CurrentEL_EL1		(1 << 2)
>> +#define CurrentEL_EL2		(2 << 2)
>> +
>>   struct kvm_vm_arch {};
>>   
>>   #endif  // SELFTEST_KVM_UTIL_ARCH_H
>> diff --git a/tools/testing/selftests/kvm/include/arm64/nv_util.h b/tools/testing/selftests/kvm/include/arm64/nv_util.h
>> new file mode 100644
>> index 000000000000..4fecf1f18554
>> --- /dev/null
>> +++ b/tools/testing/selftests/kvm/include/arm64/nv_util.h
>> @@ -0,0 +1,28 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only */
>> +/*
>> + * Copyright (c) 2025 Ampere Computing
>> + */
>> +#ifndef SELFTEST_NV_UTIL_H
>> +#define SELFTEST_NV_UTIL_H
>> +
>> +#include <linux/bitmap.h>
>> +
>> +/* NV helpers */
>> +static inline void init_vcpu_nested(struct kvm_vcpu_init *init)
>> +{
>> +	init->features[0] |= (1 << KVM_ARM_VCPU_HAS_EL2);
>> +}
>> +
>> +static inline bool kvm_arm_vcpu_has_el2(struct kvm_vcpu_init *init)
>> +{
>> +	unsigned long features = init->features[0];
>> +
>> +	return test_bit(KVM_ARM_VCPU_HAS_EL2, &features);
>> +}
>> +
>> +static inline bool is_vcpu_nested(struct kvm_vcpu *vcpu)
>> +{
>> +	return vcpu->nested;
>> +}
>> +
>> +#endif /* SELFTEST_NV_UTIL_H */
>> diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
>> index 4c4e5a847f67..8c53dbc17f8f 100644
>> --- a/tools/testing/selftests/kvm/include/kvm_util.h
>> +++ b/tools/testing/selftests/kvm/include/kvm_util.h
>> @@ -58,6 +58,7 @@ struct kvm_vcpu {
>>   	struct kvm_dirty_gfn *dirty_gfns;
>>   	uint32_t fetch_index;
>>   	uint32_t dirty_gfns_count;
>> +	bool nested;
>>   };
>>   
>>   struct userspace_mem_regions {
>> diff --git a/tools/testing/selftests/kvm/lib/arm64/processor.c b/tools/testing/selftests/kvm/lib/arm64/processor.c
>> index 7ba3aa3755f3..35ba2ace61a2 100644
>> --- a/tools/testing/selftests/kvm/lib/arm64/processor.c
>> +++ b/tools/testing/selftests/kvm/lib/arm64/processor.c
>> @@ -10,6 +10,7 @@
>>   
>>   #include "guest_modes.h"
>>   #include "kvm_util.h"
>> +#include "nv_util.h"
>>   #include "processor.h"
>>   #include "ucall_common.h"
>>   
>> @@ -258,14 +259,47 @@ void virt_arch_dump(FILE *stream, struct kvm_vm *vm, uint8_t indent)
>>   	}
>>   }
>>   
>> +static void aarch64_vcpu_set_reg(struct kvm_vcpu *vcpu, uint64_t sctlr_el1,
>> +			uint64_t tcr_el1, uint64_t ttbr0_el1)
>> +{
>> +	uint64_t fpen;
>> +
>> +	/*
>> +	 * Enable FP/ASIMD to avoid trapping when accessing Q0-Q15
>> +	 * registers, which the variable argument list macros do.
>> +	 */
>> +	fpen = 3 << 20;
>> +
>> +	if (is_vcpu_nested(vcpu)) {
>> +		vcpu_set_reg(vcpu, KVM_ARM64_SYS_REG(SYS_CPTR_EL2), fpen);
>> +		vcpu_set_reg(vcpu, KVM_ARM64_SYS_REG(SYS_SCTLR_EL2), sctlr_el1);
>> +		vcpu_set_reg(vcpu, KVM_ARM64_SYS_REG(SYS_TCR_EL2), tcr_el1);
>> +		vcpu_set_reg(vcpu, KVM_ARM64_SYS_REG(SYS_MAIR_EL2), DEFAULT_MAIR_EL1);
>> +		vcpu_set_reg(vcpu, KVM_ARM64_SYS_REG(SYS_TTBR0_EL2), ttbr0_el1);
>> +		vcpu_set_reg(vcpu, KVM_ARM64_SYS_REG(SYS_TPIDR_EL2), vcpu->id);
> 
> How about some of the basics such as HCR_EL2, MDCR_EL2? A bunch of
> things there do have an impact on how the guest behaves, and relying
> on defaults feels like a bad idea.

Sure, I will try to have these registers also set to required value 
explicitly.

> 
> This also assumes VHE, without trying to enforce it.

Ok, I will try to set specific bits of HCR_EL2 to force it run in VHE.

> 
> Finally, how to you plan to make all the existing tests run as EL2
> guests if TPIDR_EL1 isn't populated with the expected value? Surely
> you need to change the read side...

OK, I have not yet tried running existing tests modifying to run as EL2 
guests. I will try to run them modifying to run in vEL2.

Should we modify them to run as EL2 guests by default, if the host 
supports/detected NV? or command line argument based run? either in 
El1(default) or in EL2?

BTW, I have also ran all existing tests on L1, most of the tests are 
passing(atleast I did not see any failure prints).

arm64/debug-exceptions is failing on L1 and needs to be 
debugged/fixed/skipped.
arm64/arch_timer_edge_cases fails on both L0 and L1.


-- 
Thanks,
Ganapat/GK


