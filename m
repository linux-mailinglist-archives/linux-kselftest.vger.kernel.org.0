Return-Path: <linux-kselftest+bounces-40395-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73C81B3DA79
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Sep 2025 08:59:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3996616AE11
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Sep 2025 06:59:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92B7C25A328;
	Mon,  1 Sep 2025 06:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="PwhqvEdG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11012018.outbound.protection.outlook.com [40.107.75.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65944243954;
	Mon,  1 Sep 2025 06:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756709993; cv=fail; b=Bu26Kk4RhjrHUsTMTSMepxi9rFHb3n+1KC/lrn6K3Bm+27mc+w4sEhfZSpXcg43bgO9Wg8oKPYA+6KONTgwzSqvKQO289Dmwek+A2lgYsKEOEn3JhM/hvegvAf/5+uRMUh9+QeLqjiqwiLfcm/uN+lrU1wOtrWHtY+qlB3AmHog=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756709993; c=relaxed/simple;
	bh=6Pf9d5yjrs1a29WUGF5UQkmj8/JsKQTWI3xV6iShtYk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QNLma517BcsN96O14JSIlVdUj14PxUVZy03yPB73bL4BSFgr+biUx3xOGiVbvyuwtn4btqbFJ+vWKaXH5mE/TzPd3OleIDqjXT5upkT2JRrGsKdVGOOMeW9rZExSy62bh3XmJegIT9BEMQIYJ4AhM+H/NqgZdmjZkIqOVJFvgXE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=PwhqvEdG; arc=fail smtp.client-ip=40.107.75.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WkK6y798rx2UekZZZwFj8pNIR9hMb89Ru9eOt+aU1rhJK0Kw9MGmC5ofXjwxZZxDlbxOFgTl9VuSdwqiz06iyZyHyvTEOnz8xTFVAh8jzcy1kdBuxQhxtWftLfRtCCQ3x9HBunpXVinwpuI8TIvt9Jy8GMxM+xtAqzCC3nIaMcVhnarHgYc2BpqV4z1kHcBkvbNAOI16vFMd9ou5/se08l8D5LZkbZzYw79/ie5OBvkr7pGGEo0mr86kv59rxhUwQAdSYWZ22JhgHghPAgPfiEitOgKdcwczs41EjbGVpRy0nL54YC7AKMHPfvDPPDqLe0XKkNnSLafA/4OuQAXNUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YBw4XH8J5NULEOXiyf1Un4jl2qt/oqFZgN1MBlMTTU4=;
 b=jMkBYsQPA8ZBBAnLAKm6GmRmsvPwZM2IZhMznGts9NX5QOg8dFSmcJcOFYGPRBIh0HlkxB7AHufSw7tdwXK2cl8zkG0pRXrPqgYyfbp4Ybb9B4O1YWiP19RaYdGsUkoWdIZScKnHUGMPhzHFNFoxvaJBuk92B7UO//cqn1Xx8ETApHlKN1SAkrJPCoqyjuJ8m1lNbuMYzFDQ5WANVlDNCKHuni9YCz2B0+OHKooSWp8Vq1T4q+xyuP1ESALoV2RyC9fmdZB0Ese0yb4LWXG129kUF54GIlc/HGIE9OEEogdboYQh1Mvn7YSLwr12zfcYYf7/sSyJFJP6zM3YuFydcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YBw4XH8J5NULEOXiyf1Un4jl2qt/oqFZgN1MBlMTTU4=;
 b=PwhqvEdGjaY06xfvb6Mn6IDCBAM6xedqP8eHj+BVtpItAE2/XbS5a+PCMvwqxMUcFNSwdbpsNtSz+Gkv8P3L0wVOYwwjw7tvrwN096De1hzMH0Bq4q/RTu7IWmCLau8btPHNwGnlOTnnrRweQz6EvWItqhTzGu+mQ3IVLiVihoy6L14iXQgyd0fsQ0dGZ3OwzWp+o/fFH8Rw+bwq0iLCC/sjVCd9PiaoR73WbdJ7bakJCRD+/bhYbIRpZt7z3dfVIKOnb83QZf2zvspCgpKa/rVtHnLZlSdIEbK7jAaqhYuaoaU2L3gKqCOwmxqUF+F7NjE3rU5y9MrwxqCjogp2Aw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from KL1PR0601MB4324.apcprd06.prod.outlook.com (2603:1096:820:73::6)
 by JH0PR06MB6386.apcprd06.prod.outlook.com (2603:1096:990:17::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Mon, 1 Sep
 2025 06:59:48 +0000
Received: from KL1PR0601MB4324.apcprd06.prod.outlook.com
 ([fe80::f8ee:b41e:af25:202]) by KL1PR0601MB4324.apcprd06.prod.outlook.com
 ([fe80::f8ee:b41e:af25:202%5]) with mapi id 15.20.9073.026; Mon, 1 Sep 2025
 06:59:48 +0000
Message-ID: <37d6f4a3-89dc-464a-b5fe-dcfb3e7882cc@vivo.com>
Date: Mon, 1 Sep 2025 14:59:43 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHSET V1 0/2] cpuidle, bpf: Introduce BPF-based extensible
 cpuidle policy via struct_ops
To: Song Liu <song@kernel.org>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
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
 bpf@vger.kernel.org, Tejun Heo <tj@kernel.org>, zhaofuyu@vivo.com
References: <20250829101137.9507-1-yikai.lin@vivo.com>
 <CAPhsuW4PGfmFnJ-huFFELRQDJ7SpgWOLxYVBhRtsZnsLZhB6rw@mail.gmail.com>
From: "yikai.lin" <yikai.lin@vivo.com>
In-Reply-To: <CAPhsuW4PGfmFnJ-huFFELRQDJ7SpgWOLxYVBhRtsZnsLZhB6rw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR06CA0194.apcprd06.prod.outlook.com (2603:1096:4:1::26)
 To KL1PR0601MB4324.apcprd06.prod.outlook.com (2603:1096:820:73::6)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR0601MB4324:EE_|JH0PR06MB6386:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a3e2a78-9ba5-4ca1-ac92-08dde9252310
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SGtrOFR6TmVnTG14MUdoQUdYTVRhamtHem11K3RlYXV6L3lVSlYvRUIyMUl5?=
 =?utf-8?B?YVJwTmZPYmljMHRYdlBsc05QRG93MjBtK29iNVUzakZJL0RJVURCc0ZyUkZ2?=
 =?utf-8?B?S1Z6Z2F2SEo3Ull6NjJraGU1ZUJydXR0K24vckl1b3BGRmcvemZwRUg1OWdN?=
 =?utf-8?B?WGcrSXhxVFVZd29QSlFBdjIyNXZWUHRJV2U3eEVJZGNzdnFpYjhibXNZVVJ4?=
 =?utf-8?B?d0Z4ZjZFN0pqQzZiTzBSbVFvWVptNTdJaFdjK09BR2xIMVArbEpIcWR4MDVN?=
 =?utf-8?B?UWY1MGMyV21kL1RQSVh2QXp1R2RqdGxQWVU1UlJjWTV1ZmpNSVUwc3RsK05q?=
 =?utf-8?B?ZXc0VXFNYnBpenF6eDY4bTJocVZ3U0V2U2FZb004cW9KeGdGeG9LLzFLOHF2?=
 =?utf-8?B?MVcyUWUyOERYNWZIT21hU2FCQy93RHR0QkZwam0wOEZwb1p4SXF1L2wzcm5U?=
 =?utf-8?B?SFhyMmQ3TnR2OHZGYU16QnltckJaOTBTelgrV0ZmeFBreHp2SWhhUDd6Qzd4?=
 =?utf-8?B?ZG5YUG9nL01JWFBFNU9PcnRVK1IzKzFpYUpNT0xac20wWUpjVGxiOEhFVDht?=
 =?utf-8?B?V2JTRjFVMmdmNS94clR5dTYwNndBZDJJdDRzV09qdWtEOE1rTEtQV2Q0RTd1?=
 =?utf-8?B?czhENlZaTTVsZzA4NzVOQkprSVZlN2paa0Z4QmZzWEtLWWtUbGF4cDY4TUhn?=
 =?utf-8?B?WURWODE1WW5RVmtyaytPeEJXLzVka1FBeVpBL08zcCtTblAxWDI1UGdPbDN2?=
 =?utf-8?B?VjRhSUp5dkNJWHpCY0FJMS9xZ3pHS2tRZEo3NE1Vc0NBWUZHZVFCamZpanoy?=
 =?utf-8?B?VGc1NTZrV3p5cW91WDJiVnhaQjFkcEd6cmVQa1lVMFBCUVIvTzJyTU1EVVYx?=
 =?utf-8?B?dFpjdXQ3cXF6b2xCSzQzSU5XVGg4NDVNNlAwVVpQRkxkeHhZOEEwRUl1TE4r?=
 =?utf-8?B?LzV0SVVRcVVYdDRleHVjMEsycUhsLyt2NHRVdm1uUXVJNk5UU1NYNHBrQkF1?=
 =?utf-8?B?bkJVVmwvRTdsNUxSZmdpUGdVMS9JTVJxVHdHMUt2c1NLZU5qRVVkVW9kaUMw?=
 =?utf-8?B?UXRDeGk2VVVubnY1ek5IeTBBL0ZncmtiSktzQjg4UEdaMUk2TWpISWVOUlVI?=
 =?utf-8?B?aGdIUU5laXVLSEtDRHJNanEvVERhNmVTNWMvMGNybGg1MjZ6dGxydlR6RFlZ?=
 =?utf-8?B?Z3FsdG5BVXNyQm44MTJrWkdzeTZQZ3N1RzR3ekE4YXBKUU1qaC9VWlhSNGVN?=
 =?utf-8?B?L09SdXYzNzBxOUlwZlJ6Y1JDeHFkRFpWYWlpTUdtdjQ5TUZXMVJlbWFBbita?=
 =?utf-8?B?V0VkWVhlblVZaklLdkR3cUVraWFIU3dHNDhZSEpaK1hpSzQvVjNEaXVIK2xq?=
 =?utf-8?B?WHYzTUZWL2tmd2JmY3ZrZTM3MFZaY3BMZk9WTVFVRzJEMkJDaVZ6M25qUS9K?=
 =?utf-8?B?RTAyeXNvNzZrUCs4MndnK3lJOGlhcXZCMXRnbnA4WnBrTjVJaW9HT1pJTll4?=
 =?utf-8?B?eDUvS1MreGRyMWtwUzZRTERoSHdpWHRtTlJsbExLNERWTnloUDFwZ1JQWW9z?=
 =?utf-8?B?Rk4wMnc5V3pyMFkwME0xMWE1dm5pMk44SWdwRHdmMUNsTDF1bURlbERhZDZj?=
 =?utf-8?B?LzFJekxDcFVPbGFFcWlDTWhiL3k5RmtXeW1UcGk3NDh1YUR1cllkdkw0ZHN1?=
 =?utf-8?B?QXQ2bjhnSHNYeFpBTnp5bldOOVpZMnNOU3l5UExQbGRpeTlxLzV2dlVBNmJj?=
 =?utf-8?B?K0R5WktXTnpud0dpUlMyRzNkalhiR2pNejByZWJFUHI3TE84OXJKclFkbS9K?=
 =?utf-8?B?ajRrN1pJWTd5bEZrZDJQOFlmOUs5SjIrRk9qL1dMSDBseklaUGRjRjQwYXUx?=
 =?utf-8?B?VmdLdUlkVzRkSTRqaHhNY2FLWDZLL2pvTDVVdllKL3RtRkdDTGpEL2x3YzJV?=
 =?utf-8?Q?5Lz6r9x5PVo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR0601MB4324.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dnJ5b1dRakhXM3lFZjRJeEE3bFltdExNR1VWLzcrNDFCWEg1TEpmWGFFR0Jl?=
 =?utf-8?B?R0hpUk1TZzR6bjN1QW9hbmNmZHVjdi9Fc3dyQ3lkTVdJVHFpWXBYTnBZdkFP?=
 =?utf-8?B?clRQUVF3RmVHM2NJZWcwZG45NVRHNjArQjdnZEVpUElicWl2THlxUVlBdnZi?=
 =?utf-8?B?UlMvbThxVVFNdFdxMHhleUkrS2FGWTJGejRKT3lHeSszV3pYbkJmSFZLWVpF?=
 =?utf-8?B?YmpQMVVqSitwTTB4akxQZ24zZ291T2RtTlZLZTJPTUFkVVVKMTY3N1plU1g1?=
 =?utf-8?B?Y0pJK1V6SjNTRUhSRS9Ma1kyb1V6MmlPTGhVYmVkK201VDJjUTc0bisvNzFU?=
 =?utf-8?B?bzh4c1hSZm9qQWxQS1NVSWo0MzJXUHRJQ0dYRTRub1N6VnREOXJQeGVSTDBJ?=
 =?utf-8?B?SDJRN1VLNlhuM0NJUm5GL2xabmRXVGNWYTdvYVBVWFl5OU9FTFZOZU5QVTNS?=
 =?utf-8?B?bjN5MFUxVGtxUVNuS2l0OTFNQ1Z5MVREUmN4bDhRUTBEZW9IU3BXUkF5Tkhw?=
 =?utf-8?B?cHFRRWJCZXZSZ0xsdk1jSHRLUUhqOEpwMzlGSFNrRTJMUGdieDY3aFQ5YmNq?=
 =?utf-8?B?NzAwdmxhcGxiWTJncDd6eUV1Y2YwSTR3dlRHSGp4dFVMZHlhbUNuc2tIVGtr?=
 =?utf-8?B?UURtT1pJTjZmdmk0MHJ0a1p4R1Y3N0xaWWlpV3UzaU1SUloySFgwdDZOQThn?=
 =?utf-8?B?ZmY0MjU0enlKbFRJcWRlS01Vbi9WN1VTNlloZkdCbzVzWWYyaS9MZ1ZHWTRH?=
 =?utf-8?B?L0dLbE52amdMMFl0STlvUjF0UmhTV2wvVm5wSlRBS1Q0ZVZrM1h2N0E3VVpL?=
 =?utf-8?B?ZUVCeU5yNHdKbzAvVG9LYW9DRlhrdWtyTlpRRVV5RUlEN0F6TFVndkpiUC9C?=
 =?utf-8?B?QWpqMDJuTEpabmpKTFk3Tis4WUFBSFd0OVl4TGFIYXpLYTFDZXdQa0svdk5y?=
 =?utf-8?B?TWJ2eFJKWm8wMlFobGtXNXJJQlhZT0RyZEF5ZEZwblZyUVBSQmNjd2lkRWpH?=
 =?utf-8?B?QURmaXdBRWl3dDltRE5NYklEbWhjMmFZRmc5Y3pVemdTNDE1M0g1aExNVGZz?=
 =?utf-8?B?VEtzMS9WYlc5S3VTVDg5MnVEVFNuMzc3ZXU0RXY0NHBibVVEMUpSWEd4NkZp?=
 =?utf-8?B?RzZFcDFmbDVDUUpJSGs0akdOZUQwL1JacjNEbEJ6NDgzYmo4SmJ3d3dGNDM2?=
 =?utf-8?B?U2hIVXBHQktGNmR1L1drbzFTa0I2RHdEMzJ1dDNvLzFWbUFnREp1M25lSWZ3?=
 =?utf-8?B?OTNNeEJXN1FydzNZWExiVzJTYnZYeERpemZYR3oxSFgwcVlSU2VPTUJUTVM1?=
 =?utf-8?B?SSswK3hGa3B5MnF4eW8vM0tvdWU1aWt4cVZranFhVUlOdGxjNWE1OFZhSWlX?=
 =?utf-8?B?QVdRQ055dE9QSGlheWthTnJWZmdvS0drRUF2d0U2akZJenBiY2NUTEw2MzZJ?=
 =?utf-8?B?VnJRQmpQck9nbHJQZkVFbWUwaXJuWDRlSCtkVHBObUlMV0RFWVFzVFNkQVF6?=
 =?utf-8?B?aWdRNmVNTFR5M0h6aUlCb2ErK0U1ZU1TRGhrRXIzMmRJSnlLZXhZUUZSSW1s?=
 =?utf-8?B?YnJtanhaQU84c3F0cnd3TzRObDZLMnlIRDdiNll5TGloZTNMUG5mMVJuZE5x?=
 =?utf-8?B?NFp5U28rSXQ4Ty9NOXB0MXFHVTFmK0JHUFQ3ZnZjM0VLK01TajVnQ2JsazhB?=
 =?utf-8?B?bEQxYWVjd3huUzlheDd6TnEzWnM3QXErWm9jN2dCUEszaWN1c1ZYQlpYMlZk?=
 =?utf-8?B?K2lPT1hYUkJZOURHNlpyUlp0WXpBanFsYzViK1J4NFhOQlQ3VVNjRkpSOG9S?=
 =?utf-8?B?ZVJyVi8zTkk2YW9PN3hrZFlwaTdjYzNaSmlTRGFRdkxkRGRQT1hFdEZFSmhP?=
 =?utf-8?B?MTJ0dmhzTVhtTWFDRTFSM3RwbnFxaEZaSjdrdEJjdGRGUkwzdnRieW9OQ2Rv?=
 =?utf-8?B?NjFvNURkcjlZN1FzR2JoRVZjUUpUeXIwTXRxbFM1UzFMMWJMRVNZaXRxMWJS?=
 =?utf-8?B?MzhDWWlXMGhUNjhUeE03cUN2RXptS0VCKzRZSm8zTjIzNkR5aGcxR0NUc1k3?=
 =?utf-8?B?SHd1dEhZbldMRVpKR0VHY1V4THhQZzY0VG54Q2Y2U2QycWdPRmpyL3JrR0Uw?=
 =?utf-8?Q?A2Cy1P3EASvMPGsGS//AWw4BW?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a3e2a78-9ba5-4ca1-ac92-08dde9252310
X-MS-Exchange-CrossTenant-AuthSource: KL1PR0601MB4324.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2025 06:59:48.8356
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fYZKrPEBNd28Sl7gmPtD/JTiHjUxZPO6uYumKvLporGn/up2z0aMEYKHzvucVT65ZdMYnDxb7jBhU3x5SMkYkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB6386



On 8/30/2025 4:00 AM, Song Liu wrote:
> Hi,
> 
> Thanks for the patchset.
> 
> Some logistics:
> 
> 1. Please prefix future patches properly with "bpf" or "bpf-next", for example,
> [PATCH v2 bpf-next 1/2].
> 
> 2. Please be specific with the patch title, i.e. "selftests/bpf: Add selftests"
> should be something like "selftests/bpf: Add selftests for cpu-idle ext".
> 
> On Fri, Aug 29, 2025 at 3:11 AM Lin Yikai <yikai.lin@vivo.com> wrote:
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
>> Reducing C0 to ≤20% could yield ≥5% power savings on mobile phones.
>>
>> To address this, we expect:
>>    1.Dynamic governor switching to power-saved policies for low cpu utilization scenarios (e.g., screen-off mode)
>>    2.Dynamic switching to alternate governors for high-performance scenarios (e.g., gaming)
>>
>> OverView
>> ----------
>> The BPF cpuidle ext governor registers at postcore_initcall()
>> but remains disabled by default due to its low priority "rating" with value "1".
>> Activation requires adjust higer "rating" than other governors within BPF.
>>
>> Core Components:
>> 1.**struct cpuidle_gov_ext_ops** – BPF-overridable operations:
>> - ops.enable()/ops.disable(): enable or disable callback
>> - ops.select(): cpu Idle-state selection logic
>> - ops.set_stop_tick(): Scheduler tick management after state selection
>> - ops.reflect(): feedback info about previous idle state.
>> - ops.init()/ops.deinit(): Initialization or cleanup.
>>
>> 2.**Critical kfuncs for kernel state access**:
>> - bpf_cpuidle_ext_gov_update_rating():
>>    Activate ext governor by raising rating must be called from "ops.init()"
>> - bpf_cpuidle_ext_gov_latency_req(): get idle-state latency constraints
>> - bpf_tick_nohz_get_sleep_length(): get CPU sleep duration in tickless mode
>>
>> Future work
>> ----------
>> 1. Scenario detection: Identifying low-utilization states (e.g., screen-off + background music)
>> 2. Policy optimization: Optimizing state-selection algorithms for specific scenarios
> 
> I am not an expert on cpuidle, so pardon me if the following are rookie
> questions. But I guess some more detail will help other folks too.
> 
Thanks very much for your comments.
The cpuidle governor framework is as follows,
and I will include it in the next V2 version.
  ----------------------------------------------------------
                 Scheduler Core
  ----------------------------------------------------------
                     |
                     v
  ----------------------------------------------------------
| FAIR Class | EXT Class |           IDLE Class           |
  ----------------------------------------------------------
|            |           |              |
|            |           |              v
|            |           |      ------------------------
|            |           |          enter_cpu_idle()
|            |           |      ------------------------
|            |           |              |
|            |           |              v
|            |           |   ------------------------------
|            |           |       | CPUIDLE Governor |
|            |           |   ------------------------------
|            |           |     |            |           |
|            |           |     v            v           v
|            |           |-----------------------------------
|            |           | default   | |   other  | | BPF ext  |
|            |           | Governor  | | Governor | | Governor |
|            |           |-----------------------------------
|            |           |     |            |           |
|            |           |     v            v           v
|            |           |-------------------------------------
|            |           |           select idle state
|            |           |-------------------------------------> 1. It is not clear to me why a BPF based solution is needed here. Can
>    we achieve similar benefits with a knob and some userspace daemon?
> 
Each time the system switches to the idle class, it requires a governor policy to select the correct idle state.
Currently, we can only switch governor policies through sysfs nodes, as shown below:
   / # ls /sys/devices/system/cpu/cpuidle/
   available_governors  current_driver  current_governor  current_governor_ro
   / # cat /sys/devices/system/cpu/cpuidle/available_governors
   menu teo qcom-cpu-lpm   《===Here we can switch governor policy by echo this node.
However, it is not possible to change the implementation of this policy through user interfaces.

> 2. Is it possible to extend sched_ext to cover cpuidle logic?
> The sched_ext is used to determine the scheduling order of tasks,
whereas cpuidle is invoked after switching to idle class when no tasks are present.
They are not closely related, so it's not feasible to implement kfuncs or other extensions via sched_ext.> Thanks,
> Song
Thanks,
yikai


