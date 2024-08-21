Return-Path: <linux-kselftest+bounces-15830-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B724E9597BD
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Aug 2024 12:39:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2526AB20BF4
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Aug 2024 10:39:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E391192D87;
	Wed, 21 Aug 2024 08:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gFcOb7Pd";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="D/Ojpc3/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 918081B533F;
	Wed, 21 Aug 2024 08:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724229723; cv=fail; b=UEKZgqdgQuaxWRAGCeSmnemcbNDW8T5ptypCeUUPorHp9H9PUdmvzg8/kHczinalWaxED6w1/wF0z+Q2xk9mN8tooy2jC1dyR9jbrcI9ON873Gi77bJtyqH2a+P542bYoxdiUKUHVohFYArzADFn6fgbXgjwAlhw8W3c7b65WsY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724229723; c=relaxed/simple;
	bh=2ADY+DRtz6fk3WdfJPKFm404AjZUiNWwex6sp7LgGEg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MxKoT/i8BqNaCc8ftFS7l+43NcgmwGkHmkbABLvc4D3bd1kvuT6nt8PPOsPS3u/FaxEHaoPRv+nA1Sv6et+UUREqv97Stac3MmGWWqn5w4oVz73YzNePs2t1jxbiyUwvHT41kTz601eu0EwVFQDLBBF6CP6ReHt5yy8XSg6dX+A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=gFcOb7Pd; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=D/Ojpc3/; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47L7tTna015416;
	Wed, 21 Aug 2024 08:41:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=ICDh9Ag24B0bRfF
	mUdUNDpopRX9+NMcJgpbyl5gFyy8=; b=gFcOb7Pdsz6kh97td6s40XhWt/xt9sg
	goNRSy/cE0OXRdu5Mc7qe0PwaehZ88HszF/OGPcRzlmc9mbl+mZrKvJR45JZ41/7
	bXIwP+WBdEgKrqjtc7VKwP9bUOWaCGJCE4ooNfYIYK9EE9C3WGSBrUfsM1VVjiiO
	D42gCpsynpmxBHLepfjWhsQCuWvhcpe2prpYqEhSmm2BlAy+m9MV4P9H4lV5TDZF
	AskM2WShlVDiTtIDu5x5OJY2Rc4PnXV64wgMdaeabcmhVK76ISL6Uh5LpuBarheM
	o1mcqqGIyW7oK+ZhcSyJ8xOIPlWHyKyNpMhqV/vx1lZ7nueKqrUootQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 412m2df2gr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 Aug 2024 08:41:41 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47L7TIRV038638;
	Wed, 21 Aug 2024 08:41:40 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2045.outbound.protection.outlook.com [104.47.56.45])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 415bw32p40-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 Aug 2024 08:41:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JCGeUc/8jAPIA0rzdrHuwSXXORi1vRuSGW9cnAVcjvGy8zT1YuZQ3DrVXTz+hIe4rP5HKh00QnEdMOS9wprMxHq2hupjygvoIoe+IpkZMkw5W758irx9VHqpzVhrvhRuH2kbCeGH4VPYyySGD1gtMr/gtkLEhBOZ6IruClnUvTwiat3+IzUVoy04/tnzrN2H8KWZqDAQp8aEJ3pzw2+hWsK1fUvn4wn0jlVn4rK/ZP4RO4kyCU5QYnvoQOkI4bepcleWc20fdCEiHUaxE4gPxp7+jjtOuSpuwB93xu10/APkVD0PofGVrpqNKE6Cp5hv1j4PpuqfR2hI6xE0l+bm6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ICDh9Ag24B0bRfFmUdUNDpopRX9+NMcJgpbyl5gFyy8=;
 b=UMYBklCJbHbl48ymPt8vJAskTGoa6mjmv9zGfhJO5dfEDm3GmLvxUm3Uts7LZRoXCYu/z1tzG98/W/W67CgnSstyWd/ZriPQRrNl+bzwQ/gSjxWbP5MfN5BUOR87Fx+cYYrt+cwMHaX2oRIIQzbT3FJbAMszTy1f15Rjv6M32eZf2My6FSN0ShgqqIGE9Iwn7wKbiG51OF/WNE+zIadsP3y6Mbhmt02cPm4sHjBqHz/nerwg8A5C4O8+Mfixn8tGxkaTX7C6tEaTsElSpPpF0hF1SAUK8DH0s10/CzZgYHU7aAajgFwjZ90ECy5xKs4enenFCSOHrNKxbftYCqf5yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ICDh9Ag24B0bRfFmUdUNDpopRX9+NMcJgpbyl5gFyy8=;
 b=D/Ojpc3/wxP6ctq9WH7rUocopuDEVkbP7rjaEBIuj6HoL+ycHOOLSUP6V1/WIZ2NEdhZtKSC4jl2I93nobBN2eRnqUpxmk8D969Bo7vo03ZxvtteQ2dtwvSGFnnObw1BxWXNWsXmjhJ3tBSPD2imOAHWnGDC/gAmo3k81jIFASo=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by SA2PR10MB4764.namprd10.prod.outlook.com (2603:10b6:806:115::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.19; Wed, 21 Aug
 2024 08:41:33 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%6]) with mapi id 15.20.7897.014; Wed, 21 Aug 2024
 08:41:33 +0000
Date: Wed, 21 Aug 2024 09:41:29 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Pedro Falcato <pedro.falcato@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Shuah Khan <shuah@kernel.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, jeffxu@chromium.org,
        oliver.sang@intel.com, torvalds@linux-foundation.org,
        Michael Ellerman <mpe@ellerman.id.au>, Kees Cook <kees@kernel.org>
Subject: Re: [PATCH v3 5/7] mseal: Replace can_modify_mm_madv with a vma
 variant
Message-ID: <7e31d62f-45b2-4b37-a6bb-96b7934a66c2@lucifer.local>
References: <20240817-mseal-depessimize-v3-0-d8d2e037df30@gmail.com>
 <20240817-mseal-depessimize-v3-5-d8d2e037df30@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240817-mseal-depessimize-v3-5-d8d2e037df30@gmail.com>
X-ClientProxiedBy: LO2P265CA0058.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:60::22) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|SA2PR10MB4764:EE_
X-MS-Office365-Filtering-Correlation-Id: e74e82c3-5bb3-410f-1b9d-08dcc1bd0f2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Op+lNWrtY5KfU87gf2X3PsfJD6Fs0pXM/uBunqROlavxMgzcTAHB6RTb/3Fd?=
 =?us-ascii?Q?9S/Lh6flr6TnerZocy3BbnuoagR2PThE2IzK1upu73Ptb1glvhG32BDhZ2fN?=
 =?us-ascii?Q?pOEwFf2wKAXiPvKC03unmhzWKKmy9GrcdweaFgLnhw5vCgrtU39evmpaiqZb?=
 =?us-ascii?Q?mDT/RLxA06kw18LOfdqO+nWZqdBaSUqrKaYI2kmSq4sOucCcIDaiFoXTqZL3?=
 =?us-ascii?Q?nRZQo5EKNNBEBfKo+1Vg5ob1uOqYunigQvTG/PJyzva4K3VYATastR+iSfYe?=
 =?us-ascii?Q?FMcdA4QwGeY1SaVGfyd1jQnDT+Rh7O+Owje6bfAPufkkEBUVc6/l6QNf3PBR?=
 =?us-ascii?Q?Bv4a+ELMFYue75DjQWLHMJLkP8KTrCCTT9tR88AL3BluFNZOwArV99EJrrWh?=
 =?us-ascii?Q?DMbq6lIlLwJluCpjZC8TOmW1OgZnxVfySZQ52dWXGVSkZt5tbmx4CZuxo/8h?=
 =?us-ascii?Q?M6X5gAT8ib1eDv6DZiuYqzwD2bALb3qwxwEjUVJZ319URL2tLk3X0M3wsEw/?=
 =?us-ascii?Q?cM6/efLUuLI1nq/kEjItqymndxNub0KQVEL+qwM7g/WRxvpvQ4aNYzlYLtUb?=
 =?us-ascii?Q?u3qHsvHDvwem01IzlVxF+UwMOvDs759IG3RqmJQ6nJOeonKXo4AdaAjVpKkM?=
 =?us-ascii?Q?S3wZ66UeKQmPHMmBumNhBMtp9YOdCPyPWtc3dpGRtX82DF609j13ZAPx/nJ5?=
 =?us-ascii?Q?qqYOm9zJj7fZYXOu0rkckfpmeqzDwkj6xTsYr5bxlW/EV/8IscY6QfvHN7em?=
 =?us-ascii?Q?qtI/CRK/pmUIpGAvlVL/uDf22no9YRm0UptwuiyGt+prp06maNyKXJyiEbEM?=
 =?us-ascii?Q?/ZnC00OoXt18T5oLJvA5vb0Ktv8FzpMkFKsFT/C/6J3h3wBBfGIBGOk0da4d?=
 =?us-ascii?Q?8DJy0Ne58LofGdwHdAxSjtHMB7yOLXKhyQwNjE0PNa8ETOJFd8gxiYugvBMq?=
 =?us-ascii?Q?kZF7vnI68VPL94CBM6iJE+bjphEc+ubWmhGEdf+Wv7LrJa40MbMWKyHWmJNw?=
 =?us-ascii?Q?IGjlUmGEq49rHoV86f4819tLrs9z4+4Y02Wy9Js3hMp9nyK1k/VQv22t/oS7?=
 =?us-ascii?Q?N06DQOVt39lU7aveM15YMfHVH0mkS12ZuKN5p0K/p0K4W5Hsoju9oC5bVjj3?=
 =?us-ascii?Q?E3EjIBa5lbztQ7XRBwLDCQAkmBmwYLD/qbwnS3RE3fpzSWT6wzUR1U1TdasJ?=
 =?us-ascii?Q?N8IRST5+LJ0Ucu9Tb54INwNuS8M0UNk2VBJBe6KRiXC+Gu4f+LyKsFp7h8Fa?=
 =?us-ascii?Q?NgE/ozHeB7SWHuIAeWY47iQq3PAh+ZqPiK+wV6FHsGhPVXHLWJn8Vr0N/gPn?=
 =?us-ascii?Q?HFgRlwm+k/vsW6Y1OdmL7p+yIxeELZEjlOC8CwQ3OnKD9g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZlBpkJ64NfDfjltJSSQzs2QVtbqLHe83J+sEv3oOCXBZVby4106hoOJCnDFq?=
 =?us-ascii?Q?ZmQDa/GKK+5+IB1qP3EmP7HSHQiX3QWTA67ljm2D/i+7/9s8eZQ9k35VLVJF?=
 =?us-ascii?Q?jVuS5uGY7zhstbWmi8tJIaub+V258XZTNbb4/d2wyg5WbUxqPTaqwCLkG8hH?=
 =?us-ascii?Q?m2zl6wa7Zt9SD4j+Bg0z/w251l7hKWurBBEfce1T+I8FJjZSjse2CjQ3SKvw?=
 =?us-ascii?Q?ci8ilnvA0+b4Vg9axVJimjD/mJ4qCH6OUpUgrIeURYOyfVg30pUO4wM+4izs?=
 =?us-ascii?Q?OS2VY5xZGIt497EJ2fBnNGXS+lHmv4W9Nxx5TWxy7wkiOS0tKDRUK01AlG4Q?=
 =?us-ascii?Q?BjbnTL2a/0octYhYwfUaLqpzt2QglU3ogkbtudsQIka61q2itnsRst/Yyt60?=
 =?us-ascii?Q?s/dlKx9Q6QTBCRw4lGqRxlIh/d84czttKFnmv9WAptCksEUWS2DVbzXwjzIw?=
 =?us-ascii?Q?fUq/He0L1fLfuTYY35HNbEFsFNuV9PCyz74z3b0l4QcRoYYJVgiUvXNdjO5p?=
 =?us-ascii?Q?/C8UK8QW3T9iDjoJP2GiE+NVlUbl5Q61RcG7BsqAtIY6GrN7eD+s+rqg8Mx2?=
 =?us-ascii?Q?mQKdkhPUNW8Mx1x6Ei8+7pHxgJZkIYhwZsb+cIbSx4chbV409oy9O/gwJ9tx?=
 =?us-ascii?Q?uUegRlHms8u19nLJk4k6qIjRItD0698qYY5Je1up4Yg62YqIEc4FLFuY4oFO?=
 =?us-ascii?Q?J7BovQV6eva+jJT01uD/tVBVJsg2hiKPvKQFzlgPy/Me/DCvcMojKeSjKryo?=
 =?us-ascii?Q?8/38Tl6eWoWGRhKZhk1q3SKioDF2N5dhjACsEpqAHtOkIHm49jfEpb76ZvsK?=
 =?us-ascii?Q?g+ri+N0E/nIOczJRgEo1x/2VAcsevdKg6HkzjDXKnu9XEq6Z4kNKyHfSbQLj?=
 =?us-ascii?Q?Dhts8QkFWk77XSxIfxVfqQjnFyg7KckiXayu7N1vdNcvWuGg/0geyHSTC7DQ?=
 =?us-ascii?Q?Mr65cqNGJrA2QWNWZCEeDtsLhw7gVV4CADZmAfuN1pY9SLgkx2FyQcW1/tVC?=
 =?us-ascii?Q?0SzqDqHEgg812LtToBFL+zzt8BC4vaG/Ol6NzLqAWwh/a7fc0CGRXRcEpOjs?=
 =?us-ascii?Q?dhfQ37np74dhrYOlJNUkJVpLf8xUKVJdMvo27uxqKJDVoJbl0YfEa0FCwmy4?=
 =?us-ascii?Q?g08H8innvnt4moBjX0UrZCqQVq7r7vlzIPTd03Ux1q8SL08ZoDelbn/KHRVr?=
 =?us-ascii?Q?7KY4XjBd9X5W6gLP6Omz7CFkBqVl/zO+ilbnt5Vcy11Q0G3ZOgPVMYKJC0ib?=
 =?us-ascii?Q?kuQcu5hPZe82sE6RYLjbhHwV2AFySlvn4I4Mmw7HyEfjvewLQsZa+dKJUVnb?=
 =?us-ascii?Q?t5jKAME3va04lzqvo8xflE1cfGhfL8QqPNwNZXtDfST65XfNGzpjMyzOyvvV?=
 =?us-ascii?Q?+osQNVW+glH4bmOFTcyWNfdY1ssoqvuKFdRVsrtr4CZOddix6uStx79pyjQS?=
 =?us-ascii?Q?Woytnv+G+J/ZTenK9mx8Sn7+DUBlS53vmXOmg4iruIrjyuzUFO1YrpMbXAgo?=
 =?us-ascii?Q?hxgv2CXx4cV/TWPI7JosLCNXLDfqo+NgXfvQGyy1jtWW2Uc0RvLML6GoRldJ?=
 =?us-ascii?Q?rZ4u0h3P76fhUgtBrqwFtXJ0pmPpbKNCpo/4Kl0lNJSMLmiG6TMgFguEeNMz?=
 =?us-ascii?Q?duj0dQ90+vQcdeenebEbybj82CMVxmKfOLsjn3VsPecJNXppvLyQTrP3RzO3?=
 =?us-ascii?Q?WCpMNA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	b3iNbboIksw8dMUBhi1cKlYflu+6SAaOjDrWXyRI9jXyn/6dmclt6xx61AESUViIkU9vJyPFfxTx4TsJ/yxUBG6P5fpxbup0+ohBbGzLlNtkhJNdHTpqfavF8+BqAe5JdFUWYTfMgag4oxRYP58tEpvbErRi48oGTC/CEzybdaaoorLNfwEpNpZOI/sHIjH1GIsbLPcBtmiHZaxUNKeURQaQGL0TMpHMIFhkbwYVv5ebcAcZk+RlIAWqQ1T+HPnPhvLpIR7cgznihUMKryk6c3ZSwQAn2GoueQ1TqFaRroPPf2OlKuSLAOap8+ojM5BodH0bl5zNC+QbF2bK8LdVmislSxAcr4PqZ5rDGcLczi9SzbpouehOqTOBKdV37vcTHJZYkltMzlc1yBnkQqvO8dxlDMpf8mBzfJymp5QBT0qNSNpmsv3FKvA1MwR66GZ8rjrbygvsIDQ4UdpsfCQilIE0xnzjQ14VRFDADuZjpoRbch3Kr1jiiQo6WhuFSKu/F2fD1Jdv5gTnWdZwPjWyYqsnwFDAPAMsWaRXY1DCiNpDhVLDM54bARVrQMPuPSLkn++7fQioh2XDWYnkgzJRYA5sAUR1puLyTw7cJwRpDXk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e74e82c3-5bb3-410f-1b9d-08dcc1bd0f2b
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 08:41:32.9661
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +2w3KBkuVOexPhzhV+epj26avGWb2RZ1dgrrXZu0piXHBf6f5kZtf86+maNkpYLyhCqvFolKQwkTtsVbWAp/hVfYmrxEYv5gkopA48Blq74=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4764
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-21_07,2024-08-19_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 mlxscore=0 phishscore=0 mlxlogscore=796 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408210057
X-Proofpoint-GUID: hzv-ysw7GqWmvooV6iKuXy8cfh88T5fZ
X-Proofpoint-ORIG-GUID: hzv-ysw7GqWmvooV6iKuXy8cfh88T5fZ

On Sat, Aug 17, 2024 at 01:18:32AM GMT, Pedro Falcato wrote:
> Replace can_modify_mm_madv() with a single vma variant, and associated
> checks in madvise.
>
> While we're at it, also invert the order of checks in:
>  if (unlikely(is_ro_anon(vma) && !can_modify_vma(vma))
>
> Checking if we can modify the vma itself (through vm_flags) is
> certainly cheaper than is_ro_anon() due to arch_vma_access_permitted()
> looking at e.g pkeys registers (with extra branches) in some
> architectures.
>
> This patch allows for partial madvise success when finding a sealed VMA,
> which historically has been allowed in Linux.
>
> Signed-off-by: Pedro Falcato <pedro.falcato@gmail.com>
> ---
>  mm/internal.h |  2 --
>  mm/madvise.c  | 13 +++----------
>  mm/mseal.c    | 17 ++++-------------
>  mm/vma.h      |  7 +++++++
>  4 files changed, 14 insertions(+), 25 deletions(-)
>
> diff --git a/mm/internal.h b/mm/internal.h
> index ca422aede342..1db320650539 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -1363,8 +1363,6 @@ static inline int can_do_mseal(unsigned long flags)
>
>  bool can_modify_mm(struct mm_struct *mm, unsigned long start,
>  		unsigned long end);
> -bool can_modify_mm_madv(struct mm_struct *mm, unsigned long start,
> -		unsigned long end, int behavior);
>  #else
>  static inline int can_do_mseal(unsigned long flags)
>  {
> diff --git a/mm/madvise.c b/mm/madvise.c
> index 89089d84f8df..4e64770be16c 100644
> --- a/mm/madvise.c
> +++ b/mm/madvise.c
> @@ -1031,6 +1031,9 @@ static int madvise_vma_behavior(struct vm_area_struct *vma,
>  	struct anon_vma_name *anon_name;
>  	unsigned long new_flags = vma->vm_flags;
>
> +	if (unlikely(!can_modify_vma_madv(vma, behavior)))
> +		return -EPERM;
> +
>  	switch (behavior) {
>  	case MADV_REMOVE:
>  		return madvise_remove(vma, prev, start, end);
> @@ -1448,15 +1451,6 @@ int do_madvise(struct mm_struct *mm, unsigned long start, size_t len_in, int beh
>  	start = untagged_addr_remote(mm, start);
>  	end = start + len;
>
> -	/*
> -	 * Check if the address range is sealed for do_madvise().
> -	 * can_modify_mm_madv assumes we have acquired the lock on MM.
> -	 */
> -	if (unlikely(!can_modify_mm_madv(mm, start, end, behavior))) {
> -		error = -EPERM;
> -		goto out;
> -	}
> -
>  	blk_start_plug(&plug);
>  	switch (behavior) {
>  	case MADV_POPULATE_READ:
> @@ -1470,7 +1464,6 @@ int do_madvise(struct mm_struct *mm, unsigned long start, size_t len_in, int beh
>  	}
>  	blk_finish_plug(&plug);
>
> -out:
>  	if (write)
>  		mmap_write_unlock(mm);
>  	else
> diff --git a/mm/mseal.c b/mm/mseal.c
> index 2170e2139ca0..fdd1666344fa 100644
> --- a/mm/mseal.c
> +++ b/mm/mseal.c
> @@ -75,24 +75,15 @@ bool can_modify_mm(struct mm_struct *mm, unsigned long start, unsigned long end)
>  }
>
>  /*
> - * Check if the vmas of a memory range are allowed to be modified by madvise.
> - * the memory ranger can have a gap (unallocated memory).
> - * return true, if it is allowed.
> + * Check if a vma is allowed to be modified by madvise.
>   */
> -bool can_modify_mm_madv(struct mm_struct *mm, unsigned long start, unsigned long end,
> -		int behavior)
> +bool can_modify_vma_madv(struct vm_area_struct *vma, int behavior)
>  {
> -	struct vm_area_struct *vma;
> -
> -	VMA_ITERATOR(vmi, mm, start);
> -
>  	if (!is_madv_discard(behavior))
>  		return true;
>
> -	/* going through each vma to check. */
> -	for_each_vma_range(vmi, vma, end)
> -		if (unlikely(is_ro_anon(vma) && !can_modify_vma(vma)))
> -			return false;
> +	if (unlikely(!can_modify_vma(vma) && is_ro_anon(vma)))
> +		return false;

Not your fault, but I find it extremely irritating that something this subtle
has literally zero comments.

mseal()'d + user does not have permission to modify pages = potentially
discards, as per the original message:

   6> Some destructive madvice() behaviors (e.g. MADV_DONTNEED) for anonymous
      memory, when users don't have write permission to the memory. Those
      behaviors can alter region contents by discarding pages, effectively a
      memset(0) for anonymous memory.

For something so invasive to just leave this as implied + needing to look
up the commit message to understand is just... yeah. But again, not your
fault...

>
>  	/* Allow by default. */
>  	return true;
> diff --git a/mm/vma.h b/mm/vma.h
> index e979015cc7fc..da31d0f62157 100644
> --- a/mm/vma.h
> +++ b/mm/vma.h
> @@ -380,6 +380,8 @@ static inline bool can_modify_vma(struct vm_area_struct *vma)
>  	return true;
>  }
>
> +bool can_modify_vma_madv(struct vm_area_struct *vma, int behavior);
> +
>  #else
>
>  static inline bool can_modify_vma(struct vm_area_struct *vma)
> @@ -387,6 +389,11 @@ static inline bool can_modify_vma(struct vm_area_struct *vma)
>  	return true;
>  }
>
> +static inline bool can_modify_vma_madv(struct vm_area_struct *vma, int behavior)
> +{
> +	return true;
> +}
> +
>  #endif
>
>  #endif	/* __MM_VMA_H */
>
> --
> 2.46.0
>

I remain baffled that the original implementation tried to do these things
at an mm- granularity.

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

