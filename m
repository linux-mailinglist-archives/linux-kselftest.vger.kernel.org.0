Return-Path: <linux-kselftest+bounces-15820-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BE85959519
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Aug 2024 08:52:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D715E287034
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Aug 2024 06:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DD45192594;
	Wed, 21 Aug 2024 06:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cOYabQGS";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="yma5WGOl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E01E185B7A;
	Wed, 21 Aug 2024 06:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724223101; cv=fail; b=UQ5v5WV0hK9bMaR+qUvN9idxpc2yHHiBrZDz3PhwhVY97zhKpJEip91/yZBFQXUsA8JEQk+za12oPpWsawJBSrB/M6BpXLDBUZK5rcdNiCOsFlfr3SSxY7ZinFrQ8H8yreJbBXZdJ29bHgd6aNHzDWhcA09Namh0n8M34p2rl0A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724223101; c=relaxed/simple;
	bh=ZD7U8HFwDKhVb6sQt7T5w686EBEIOQUpwAzvF9xub+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=W1KQje5hPdgiG3tXS0XblJ3KFcx/0sxIqlOd6e+9PuWOl2qGtrfghyJzS9HxjOa4yvCSsEfFQBUZ7T/4+/IP6ffLJsgF15ZMXuIrf0SvjX7sQcqo6VRPszQpETeBQlkbQLAbm52KhGYuTzjP0iRsq5OmJe3uV37JZkX7yck4qHE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=cOYabQGS; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=yma5WGOl; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47L4fY3t003856;
	Wed, 21 Aug 2024 06:51:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=NHrro2V6h6+S9Dl
	on3t4B4KzmXvME4QwlkpYU6R0Yms=; b=cOYabQGSC6bgJPPxNosgDw1Msqh9PTp
	Eh/cxYD+rFXPvsD20xejILwpUI70K85VQkkJnij2MyXf5tZxncgH6cw7EB2sj8/9
	bhwOLrvaiaoCP9nZNhypU5dpjfe8AfYCLMpdmqT/Oo9MQEiLWN+uebD+oKm0ZurD
	26KRLwikV8bIqpdtjCrsmuQMck6zWEGn60YIEfSOvHAL+NIaU47RhS3W+KoQkNde
	VmwTaQDq9NRod49JiQL210iYLZUVt+tUV9WXEmsHqYQCK+obUpss0lRUH8RtI3ga
	JdujpnHC5X4DGXa012BnZrUAzj77VJqagIQ3RtlnBp0MXXQUxwq8jtA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 414yrj12s6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 Aug 2024 06:51:21 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47L6It1f014884;
	Wed, 21 Aug 2024 06:51:21 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 415av28v7g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 Aug 2024 06:51:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kdoiHa9b0n7UL/9bbCJLEmg3rFlyANfQy5r4KrTlv4ZgAOIdF3/O2WqChItaNwgohg/hVgew9MY8KZSobGFJHvUpVFEhuAFPqCGj0fCCEnESNOIxwe0H7bSgLzhhzKXFnX520FPcXxQmTgH/nACLxuW+9V9CRg7RR7B9YaLA6cF1S7cgGG53OkuOoxjIPVoRPVSWF0xkobzW8GrCcRf++cauu2+zQswVSnUEI5IplcvuJ3A4iQv3RP6Jjsrp0WGmSfPt0Rqt9E6XcmKF4SEIV+m/ecJXuwr0lTKuVW5mVIzbcKHm7n5Y8u6uguzRws2XQU30GES4VfRL+0Hcsxqd+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NHrro2V6h6+S9Dlon3t4B4KzmXvME4QwlkpYU6R0Yms=;
 b=ZzAeyCN9xvgkWks90qXbKeDOSzqn3XCraXCnZsKZKojyxQE10epfJ87YixooVTY/mrVYHy2ZUwRZtXk0mMdHAmw8nDY+cfgeKC1bnv6vyVC+2+9YIlMbGfNXfk1Cbwz5sA3Q0VRHpZ4duVoiiczIyQUkioPk/K4ZqCfKQ/qLAxzchUktnwmz+isekeGuL2xKSZ/FfYwj+rRxsOeyDE1paHjDQO5LbtT8Py1lvGiKoLLT/xMlqZFFmEC6rL+oz+2gQm9YdA7SvuI05KDdx2Qj07l1NUJcjJJoKffZbTHMeTmxIAnTz95cDMEWRxkveYn235SCzsJ9XY6bNrkR6TNXGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NHrro2V6h6+S9Dlon3t4B4KzmXvME4QwlkpYU6R0Yms=;
 b=yma5WGOlmS0RC5gnJwtI5m9ZhUsIhJL4xtVfo4j/NGndMMemXA3lGjohs1AJit+jl0hAON1b1rwDs+ldqxW4hjXYrGYJH6v1FI9A0qmzKgfnxLAHa5mRZcjAn9169R1ZpYYUcfkeL9WskDqvD1EApx2hfK8t4qg/BLBm0e5VEbQ=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by DS0PR10MB6080.namprd10.prod.outlook.com (2603:10b6:8:c8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.18; Wed, 21 Aug
 2024 06:51:18 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%6]) with mapi id 15.20.7897.014; Wed, 21 Aug 2024
 06:51:18 +0000
Date: Wed, 21 Aug 2024 07:51:15 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Pedro Falcato <pedro.falcato@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Shuah Khan <shuah@kernel.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, jeffxu@chromium.org,
        oliver.sang@intel.com, torvalds@linux-foundation.org,
        Michael Ellerman <mpe@ellerman.id.au>, Kees Cook <kees@kernel.org>
Subject: Re: [PATCH v3 3/7] mm/mprotect: Replace can_modify_mm with
 can_modify_vma
Message-ID: <ecf95db2-520d-416c-8bd7-d4e812449f74@lucifer.local>
References: <20240817-mseal-depessimize-v3-0-d8d2e037df30@gmail.com>
 <20240817-mseal-depessimize-v3-3-d8d2e037df30@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240817-mseal-depessimize-v3-3-d8d2e037df30@gmail.com>
X-ClientProxiedBy: LO4P123CA0395.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18f::22) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|DS0PR10MB6080:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e49c4d3-26dc-43a3-484b-08dcc1ada897
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oH5een5f80ftWxHxrTW9XfTNmmSQzh/dsoOkqaNT7b1cVHMucWSee7+3xmEV?=
 =?us-ascii?Q?4VFJw50Z/lYqPGbSOn12ile2HfcPXa+1z/5/AWotNhNj4WkwZA4OCRcrPBuJ?=
 =?us-ascii?Q?KaUbxtuKL8hsxyhkBu4oiIwgHDvolz9KL7JiKe/V8odJqpRE0yiHDjTHQ0TQ?=
 =?us-ascii?Q?sA8s56Bsiq1Zvc7L9iZOkuwhKDMJZQ76szR4wf+JaR3CJr6vXpeT9Xew2wek?=
 =?us-ascii?Q?a1H8osePMp35L2sXSRCCTd8qNCtTRQveznk6lP+lDP7lSwVcku4l/3RGXosm?=
 =?us-ascii?Q?+Px9c8LhpfSqFmM1hVZOhJzx/t4nf1t0Qh8r6J18nkeDSyBAeL17C650NQAZ?=
 =?us-ascii?Q?GkuOq9IJ1q6as9EIGXW2NIsFc3e9Qf3lW4tNcmGePFgociBN6lYjb529nYuZ?=
 =?us-ascii?Q?hm29Q1w/h5NWxOPgD2QNVmIddzRlsL+yPKVGYdU7Ai6sttyKUkHRkg5UA22V?=
 =?us-ascii?Q?qsPIgWLQ80ezrH8JjxzLuWkaXJkqTM5ooX4kN6YVy1QM6is+4/tKG0NoeTef?=
 =?us-ascii?Q?Qjtj+KPOks3RefqWR8J7GN92nWJKNeCsMsled/zjD4If3lCZjYlUkv8qyoka?=
 =?us-ascii?Q?x0ieGCsU3yjJ2RP2eZC9cn7NZ/5bpteStl1r3aSk8XIkVGgM7BmBHR5ehuOu?=
 =?us-ascii?Q?8wC5HxSumCxUN2PSJEWvSEm97dW9rfRKR+cmUslaM6vMqmfavFsdM2aPVAQl?=
 =?us-ascii?Q?LIC29jLUP4Wghc3xiCeq9JDdPQtXs0VSAZIQYq+qa6e8eo+YsxCa7gmxJ1Ik?=
 =?us-ascii?Q?nTJctJt08TpefSCd83jDkltdka2SzK0OD9NAT1sgMV/gisv0sF1bX/upAX2G?=
 =?us-ascii?Q?D2ojXbQFRgLi2+DndPyxDB60bZhQRn6WaWlgqS5Y/W0j4pI3fzFoQtpHX1vE?=
 =?us-ascii?Q?COH7gi8+kQm2uEr2i/PdWwB3H8sNBqEw8kz0gcP3YMmbbNXn4qqXaAFroEMf?=
 =?us-ascii?Q?PNgfeDulEqnzmHbCWDC7bNXPapx3sFmmv0Ld0rIEcciPs8caRzc26Sf5bliM?=
 =?us-ascii?Q?1dGqNalLai25Ndie35w5XzQJjVzeUk5tqGCJFTkrC/LcFWCQqxG7ayYgAjKG?=
 =?us-ascii?Q?aCsXG+u4oINY+GwebHozw9wqZxby5eEUQLvys+w4b2NoSfUdT4U65Ei/+sUt?=
 =?us-ascii?Q?o0o4b0LP4bjRvm/U5W/6VdhI+e+W1OCTxKDD6em90pOrKu1LNzp98eco8q7Q?=
 =?us-ascii?Q?nTYHzsjjZVWRQaQbRDm0jzcxDHLP+TsPlGxMSfnctVfXO/UuRpkjkFu3i1dY?=
 =?us-ascii?Q?0mkT/hXi76Ly0oruBbmAfW3jf0X7RhVs3g6z/bSS/QFsdxfY4xNU3ncLSevu?=
 =?us-ascii?Q?XiBltZwYCCBkewbx+uMg4d1JR76YLFFNKbc5efjquwJFMQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iilkifAGpC0lfYzU+6P5LcbokvF9rn/W+gWdOVaThqZsTfjA2wEvqQ+n0HSu?=
 =?us-ascii?Q?wEdcWZxAtsLz6g5cpcSiGTgjaOM6v7jAsFj7/qmRAX8K2bk3BXHhmr66nVuN?=
 =?us-ascii?Q?bAYGYQc78iR/OfO/Svwpw9ENFGzWAtX8MWw2sp7nDgMGuEFIEabKRss/jni9?=
 =?us-ascii?Q?0UpZ0AqArXWO2lk8mAl0JXsPX4CQlTxPgWl9bpYZWZERJZaAncLVJE0L17bu?=
 =?us-ascii?Q?qBdh2ZVhR6LDq2DhAC7fsO6aE+sbNh0/3YcRnskIjXoPu0CMUVP1X67IdsUD?=
 =?us-ascii?Q?Kge/gYnhb8osZoe38vX0DI943vKtDe9rqXS8RwkY5eIBYlYCCLxCrT7XLV9z?=
 =?us-ascii?Q?ATeFSOCDPhZ26sTs4Hp2Rjm8mKfN2dHSQudwybXpFYeFly5/53PHfOpkIyw0?=
 =?us-ascii?Q?QqOmx+rgguOQmRRHEQTGm6HLNdIOT0FYYaYA63Mafeef88Bthcn/FZoimtlX?=
 =?us-ascii?Q?OWTJ8ltCkubLPVX3bVdr/dZbrc4bDxtx3ujsh6vOwjNqPQclc3DvqNKZFTMg?=
 =?us-ascii?Q?AYV49phUgheCg6Z1dHM10VlIopMKWegZvH0hPi5YqShuuOvR8xQNfJkQ/PPC?=
 =?us-ascii?Q?5+1b4xeeO7uRjEC+NW5hdn7ARv3/lcD++bS43jQ3i85bmFDnI5ZQZhIoFhBc?=
 =?us-ascii?Q?rJmbPo1qm5qJN1uBOT84r7C2dxcQGsLvTNSEg/3GSszfW36DR4ubZdpvje79?=
 =?us-ascii?Q?CXqvsN2Wo1cdVFcP0xCkrbkV9mFM3T5OpsuF7pV7K3kOXI4WYWpIitqh15jv?=
 =?us-ascii?Q?PYeHRx2YMdphdt1p5kn6FBmnMn/0qtYjI4TtX16QrRhujf+V1TVLXbPAvraY?=
 =?us-ascii?Q?j87dCFUYFNzOsAGa87sQtwtGnZfZAq0eiEtS20CI0qCo/lOzCGsMTnRHK9ni?=
 =?us-ascii?Q?kAppD2GjMOlC41lFBwyCPKNmo8uZt5hu3qRgVePqiDxp40XDzDhGyyZy33qb?=
 =?us-ascii?Q?0INtyFdbeVPCh95whO/rTmMGaeXT6yidgmy5p8ew9z+lNPls0r90RTIqbXgA?=
 =?us-ascii?Q?D9BDbQqhNmr+6+R8po0oW7K0o8usgkTXxDxetnYIO0VRQYnAHwiFYr6oI90K?=
 =?us-ascii?Q?BbDXeemCvipFD8PbWJ2F0boox4VuXyCz24h8xmwjSQEmT0Cw44vO/jPZkUf+?=
 =?us-ascii?Q?w5iJtGyG5Ea5WPC5ALETZUiUK3r5s9fmRTqIw9njggRLIS105IFFHYnTpAjz?=
 =?us-ascii?Q?oyAfznGdr9TzUmfr46NVJYyK6UWrWXC6WFChvElGYnExbt2y8fj1kxHqTs7v?=
 =?us-ascii?Q?mrrhF9UranoR597zxFY+CcQWiRUf/NBhf91jETHfjz7QxDeZhyEGz7KDOkK7?=
 =?us-ascii?Q?vsEp/hO5zyYfKelnvFxgY5KC2wgfoLKAIkaGdOaKHQDD4/NUBKj4uZq9N1aT?=
 =?us-ascii?Q?xXuXpADTQJj98gOwvKpLPZV8dIRafajxjTjiIyz2jcKpjl7RWjKe2TdRB0M0?=
 =?us-ascii?Q?AvMuaLrMr275IuxO9Sji9bwqEsfNz5ykJ1x4QZPsUF/qj4UpYXnaa3O528/v?=
 =?us-ascii?Q?vAb6rLq7M0Al0y2+Xgyad3c6X3nC26qRkofSZo9euwDK31OUATNwfx2kdxHd?=
 =?us-ascii?Q?Z0x6U4f5V05voetA42IE/N3smMb1S6F1j7/CAbB+jLc7K4BPQ2sWMB5YakRU?=
 =?us-ascii?Q?uSbgAGjcvm5Dz3G8hZo8wesCbnfCyaOl9cFamxUkfg1/X/cfG1r7jsxeTxBa?=
 =?us-ascii?Q?gxm9uQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	eGLGqV2u9lMF3r5KAWeRWovRl6G8NDslMfFyE2qkB23TEeWVLCDdU0t8X8TaZEXpG6sX78KiYaxmaFnxuafBGUuuku77SrByQLyyo9ptFs7/k8kO55Ym5OsRmOL4+s94RjlW1Bbj799XQbRWKkJOnEmGMxR0Tx8y7m+BzqfcrKxNhHuHHKgPdgnIsn4/kkyNHo8B486TeMV2hIRP4oh8ZpC66qAuNeOWBTvk5tXOudgRCo7t9PQiR7u18g+bJ3Uk7rCatWjS81EB7tBPd+AXpDYWl7BghvzapEdELaZ/95TtsvwM0r0/G4tNBaLuH9ROrc95qKJNRZywJjeC7BkvM9JNaLXtS2fntEkavsSoOkciDf76JLNNKbg6WS5fOTYMStjHxtrDyC7rbK4FZCb9Ri21PDXeefCV/ic87XqRlnWsMUG1GoOBmrnIPMoW/e/bwGUPvy1NcQzpk+Fs2JSCnTuoTZ31qqgFmL4NShLY8bNFxP66gruxkI0LEATVL5JGugSPD05ZSm13J0d9IbqYWhJm9CeT8tUstqlRe3VJztsU8sKJQ6fKGjCUN/H1dCjenycP+TmbLFfDDAJD3vefTZU6rygPOz8bzrS08AKIx54=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e49c4d3-26dc-43a3-484b-08dcc1ada897
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 06:51:18.2396
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yvbDIgsV3Hz6tdzpsjBJZ2tY9gV73mmCnBgQ3U+ey59Ym4KIV916rqyRVQ1FXGKGWT4rOAlvx6YfHSn967MIehrpcxabN1U1Dok4BbmOl6I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6080
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-21_07,2024-08-19_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 malwarescore=0
 suspectscore=0 spamscore=0 mlxlogscore=999 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408210048
X-Proofpoint-ORIG-GUID: jeozvMLrKP-clGsECRDlw19PjQeeP-PZ
X-Proofpoint-GUID: jeozvMLrKP-clGsECRDlw19PjQeeP-PZ

On Sat, Aug 17, 2024 at 01:18:30AM GMT, Pedro Falcato wrote:
> Avoid taking an extra trip down the mmap tree by checking the vmas
> directly. mprotect (per POSIX) tolerates partial failure.

Pretty sure this also applies to any such mXXX() operation, though I
haven't read the formalised POSIX spec. But in practice, this is how it is
:)

>
> Signed-off-by: Pedro Falcato <pedro.falcato@gmail.com>
> ---
>  mm/mprotect.c | 12 +++---------
>  1 file changed, 3 insertions(+), 9 deletions(-)
>
> diff --git a/mm/mprotect.c b/mm/mprotect.c
> index 446f8e5f10d9..0c5d6d06107d 100644
> --- a/mm/mprotect.c
> +++ b/mm/mprotect.c
> @@ -611,6 +611,9 @@ mprotect_fixup(struct vma_iterator *vmi, struct mmu_gather *tlb,
>  	unsigned long charged = 0;
>  	int error;
>
> +	if (!can_modify_vma(vma))
> +		return -EPERM;
> +

I'm glad to get rid of the unlikely() too, imo these should _only_ be added
based on actual data to back them up rather than because the programmer
instinctively 'feels' that something is unlikely from the compiler's point
of view.

>  	if (newflags == oldflags) {
>  		*pprev = vma;
>  		return 0;
> @@ -769,15 +772,6 @@ static int do_mprotect_pkey(unsigned long start, size_t len,
>  		}
>  	}
>
> -	/*
> -	 * checking if memory is sealed.
> -	 * can_modify_mm assumes we have acquired the lock on MM.
> -	 */
> -	if (unlikely(!can_modify_mm(current->mm, start, end))) {
> -		error = -EPERM;
> -		goto out;
> -	}
> -

This will allow the vm_ops->mprotect() caller to run on the vma before
initiating the mprotect() fixup, a quick survey suggests that sgx uses this
to see if mprotect() should be permitted in sgx_vma_mprotect() (so fine),
and um uses it to actually do an mprotect() call on host memory (honestly
fine too).

Looking at the struct vm_operations_struct declaration I see:

	/*
	 * Called by mprotect() to make driver-specific permission
	 * checks before mprotect() is finalised.   The VMA must not
	 * be modified.  Returns 0 if mprotect() can proceed.
	 */
	int (*mprotect)(struct vm_area_struct *vma, unsigned long start,
			unsigned long end, unsigned long newflags);


Which explicitly says DO NOT MODIFY THE VMA.

So we're good.

>  	prev = vma_prev(&vmi);
>  	if (start > vma->vm_start)
>  		prev = vma;
>
> --
> 2.46.0
>

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

