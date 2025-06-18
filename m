Return-Path: <linux-kselftest+bounces-35285-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 96726ADEB01
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Jun 2025 13:58:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0EFA3A78A4
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Jun 2025 11:58:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 854D12DE200;
	Wed, 18 Jun 2025 11:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VX4iIWHT";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="cFZrrhgx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E5AE288C25;
	Wed, 18 Jun 2025 11:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750247890; cv=fail; b=neoBcHJUT0YQYk6r6U0td3mNlPpOPYLl6+hZuYYIJuQ+FdzUiHGDv/7HrjU1GP5+rVNDegpG14hmtviq0KdzB5UHahsj98c3dC3TNNBmxwjUlf8vkY5wTyf04Bx23dgF7K3RDbUuPz010HAvuOHrNgTvoRNrAFVdlxwvgcQ/XAU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750247890; c=relaxed/simple;
	bh=WDaozx+maWcTteBopa2sfodUAG6HS4blnenUxEwdhYE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TTSS2mk4LnrGXsGX9a8xk6rVMmptY95TFnWLUkaZL2Xqm0ehXlDtGN1WVI5mVM0pZo+nI8qa/GrLBWb3ymT8OiyOxHu4jh7iC5LwnzSxhWWHehaig6A4FT38d0EJS8h8hYL7ojqT98GdRdVpjY7YucKIggeqD3rEwxjpumzIzM0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=VX4iIWHT; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=cFZrrhgx; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55IBMaQY009751;
	Wed, 18 Jun 2025 11:57:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=WDaozx+maWcTteBopa
	2sfodUAG6HS4blnenUxEwdhYE=; b=VX4iIWHTQSnTfLzNvPQdptuq8y4N3wGNKr
	aH7gB8Z+PdSajMmCm/wyohhIVtbBO7VKtb+GAjWasHo27fMZxT7XHF4ylmwV8Sy5
	F9BvU7IpmksSKgsg5hM/eMMwIS60HzKCMQyslmcFbJiMz14t3H547cO/pc/aChQA
	P7cHnQefn+p0gPGuAo9nWm6Br4OvNfqsO5oaLR34rVOotzHxc2OEeN+UMzkZhfG2
	BudDyoIguYSRrsT9hTtswWcCwfTDw+Y1wfqwKOPXW9sFse8FysKSetkOm3s0XB/U
	RY+dvIxeoMgicnPfU5LxVBTHCPWimDlCwIgPVKS3QQ7iRgyyBQmw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47900eyne6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Jun 2025 11:57:45 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55IA98Mm000846;
	Wed, 18 Jun 2025 11:57:43 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12on2049.outbound.protection.outlook.com [40.107.237.49])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 478yhaj97q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Jun 2025 11:57:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yLXnjwKnrODFg4PAU5l+OWlmk5UgAhp5q7i9g4GCukQLFyd9+pXDL8sjtrd/fQD3KgBh6VoXrCfZJMkP6HUMzEKzdgPrwnF9rPdrc0cQ74y/nMi84Tw82RBz14bm60HlirSAT1byAs2E7gQ+zdBUvn/hHx9JgBT0QK1pzqZTTL4DUIBfm+8JoNKSqwVkhtDkm9b7W6NzZDyh/Z1pOC63NGo5f7noGwL8UNQIC/R9KmUJaDVBXhXE19YgVy51FyE5NH9Al0oexSgtBu+V7ExCvOstzxYISFnd6iQf48wwld+pGA21jU47eFjwztGKiWVyjbhjnA/StWPaudAGCAO1Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WDaozx+maWcTteBopa2sfodUAG6HS4blnenUxEwdhYE=;
 b=gfwmwv1gRY9lqRq13yxssVYq7ln0eyXSQZjB49cLph2iV0ylYpJCUKFiAhLnSd6GNGwDYCCstdhh/yuH7OsggHWUGddgILsogfJxJhrfGTSCSnXSoGDVN1FT7+Eb1ku1p5lLt9nILDlUYWPlItiDhyTDtoYIk2khQXuIvI9YmBOGGdbUCbzZlU0kDUhnmMzgJoMf980ba9EOD+g7f6FOd5WznU+2BEPJmqDfIdZxG4h9ZbMZzwTCIXZZH5H14R7QpRkW+Za5q5eWaFCd2QecX/ivmSChULDR9EC12JrWKXiKfQKxgz2+w2EmJ448rF46gLVlP3VmQLvNWf2t9IRQzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WDaozx+maWcTteBopa2sfodUAG6HS4blnenUxEwdhYE=;
 b=cFZrrhgxRrsDT5n+6QxECGgfHy2hQ+NCabn6Nnd7JG4sDW0jMSVoZLN1FAjur5kqcWOsvBafyCRjxjDrdTkVPgAUQ6FKnfW7NBmfZ+dS5H8tw0Bu5/NebolIDvlSkdxD536VKgf44VeYnDnxXmo5Vd1bBW6g7VMROi7BIKlxVR0=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by MW5PR10MB5852.namprd10.prod.outlook.com (2603:10b6:303:19c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.18; Wed, 18 Jun
 2025 11:57:41 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8857.019; Wed, 18 Jun 2025
 11:57:41 +0000
Date: Wed, 18 Jun 2025 12:57:38 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Dev Jain <dev.jain@arm.com>
Cc: Aboorva Devarajan <aboorvad@linux.ibm.com>, akpm@linux-foundation.org,
        Liam.Howlett@oracle.com, shuah@kernel.org, pfalcato@suse.de,
        david@redhat.com, ziy@nvidia.com, baolin.wang@linux.alibaba.com,
        npache@redhat.com, ryan.roberts@arm.com, baohua@kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, donettom@linux.ibm.com,
        ritesh.list@gmail.com
Subject: Re: [PATCH 1/6] mm/selftests: Fix virtual_address_range test issues.
Message-ID: <8e23c5d3-6ce3-4fe8-b6fe-69658d5d0727@lucifer.local>
References: <20250616160632.35250-1-aboorvad@linux.ibm.com>
 <20250616160632.35250-2-aboorvad@linux.ibm.com>
 <0665a8d3-7094-4732-9518-01ac313959e1@arm.com>
 <159f6939-e7c8-492c-8195-b7e8787a08f1@lucifer.local>
 <f8730d2d-41bf-407a-b44b-6cb9c1e5d4b3@arm.com>
 <79bdd993-0e9c-4d7d-b42c-4b5750eff140@lucifer.local>
 <aaddfd0b-216e-48fe-b48f-35c78eabcf9a@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aaddfd0b-216e-48fe-b48f-35c78eabcf9a@arm.com>
X-ClientProxiedBy: LO4P123CA0417.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18b::8) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|MW5PR10MB5852:EE_
X-MS-Office365-Filtering-Correlation-Id: bb474e9a-5fcd-485c-7bb4-08ddae5f53e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?71j8G93Hl3gT96mLKjy2Xrw4b2KzTEALGJpAFrQjpugCmPwSQSWn6pRx6c5Y?=
 =?us-ascii?Q?L39SXOVpZ8ZY/othB4gTMaKOZ1wykbKtiTqTa2ytwBzwSmMgDdxIOiPdI+oH?=
 =?us-ascii?Q?AhyIR9uXbDRWuCB3JYPsG4t5W+4Rs88kMkO7FiO1CCiBcnyao3mnzCkWULeO?=
 =?us-ascii?Q?r6yYl6xnePl+nXVYTbYhVTCKIIKwzEIey1D9UBKbc6arwZxAdF+nlZl55P2H?=
 =?us-ascii?Q?54o1HOoSpJmbUO7pUdcYphWr13VSmbdeNBFj1jTA8glYwV2gYEMtlIsIoAJm?=
 =?us-ascii?Q?18dYLahPp2Wklh2mEO8Gmacbr4vRIDv+eJPBYrL1yv892zJLu3slezZMUE9P?=
 =?us-ascii?Q?w6QBUITKtbAjI/MON6wfCzCp0XagcjahtRofC3pkresni5t5C2mMfWMsz29c?=
 =?us-ascii?Q?u79Dwqnq3bOHYD6f5hnFVUz1Y1Z3J5zLDLo/PgLXMrvsYgH2i9patyKD5xew?=
 =?us-ascii?Q?qPwBP+gqaArvcMweTValOdnEsuhaP3I++G+9OweWaQfstG61CPw7/6XUuO8U?=
 =?us-ascii?Q?7PO3D+5FRR+9PL8KkOj708fUp7YaqFzjY3l4+zPUypkbjW7Xuxuo0sJG9bri?=
 =?us-ascii?Q?ut2My9SnjlNjNwmiZ0IwC16TgAQzrj4o8VY7tP+76ShTGlmO8iy2XYtfkH/c?=
 =?us-ascii?Q?asw48XtTtHb7VX/vwevPxTY+0OaCOOeHiDlkj1WXiuX+MQUWfKRsl5A7T0aB?=
 =?us-ascii?Q?gljJOtf3SGzzb2oAwtIxvmo6G00bloOMNjD7PwsQoBxHsTuGJfoENSYWy/3F?=
 =?us-ascii?Q?I5FfZDDozx2+Ig+EA0topjwgufiTVJAUAhEbK2u9QIoKWoXLTuSLPIMHFqvp?=
 =?us-ascii?Q?tg5Xbde29Nx2H3crLjzf/EuA97/uZqjxwrI6pMuPWFcY03d268Lw5gwtgZvf?=
 =?us-ascii?Q?xXzCXJiMZJSLaJEctJmFPNmyvxdm45ktain/gZw1LxGqwZHhrr3+RlqQAPVy?=
 =?us-ascii?Q?a+cScJlT94qu1Bw0McsndY/3iMef+24chetBfSgrC8QKjkmYyjTmL/j1vZiw?=
 =?us-ascii?Q?YKksv8TwdYBm1qOmred2yJPyHpE/Guhx3g9wFAmPp7Nau1uMvKkECVvmA38z?=
 =?us-ascii?Q?pDPgxeTq9WRFu0v4yR2sFscpt3aEA5YhIL23T9Q7cWYJkWTvondEA5Iway6N?=
 =?us-ascii?Q?Ylo33kWIa0v4HJ0a3JVW7T+o4UgtjpEjXzXDAiWByTZ49rQXi3aN3KmYVUWz?=
 =?us-ascii?Q?tEGhDpuTROD0x59tvPVMclFe1eETuVQvoIClxiyygiiYh2LtmXtyEHfCK6+O?=
 =?us-ascii?Q?qDr8ADvJ2/Be0xFVGz3E7a/jiYl6cOm2PUUURzj+LoxsVsLLKf94Z8W/iPZz?=
 =?us-ascii?Q?JCvicaqn1n3Ar1/grFS3esW3nO+cGUVNK2mkmYAcloxR/XuhfEb0Vt4dhQMI?=
 =?us-ascii?Q?6TUaCrITGuNN5bYYGNgA1H15f/I5v0YX/b7YO+hjepbIv6MqWy4tTJekBAc4?=
 =?us-ascii?Q?iYcrbk+HX6o=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?krnrimjFDsF1sFIaGi4hIdyPyoNfmeI/m+0n6ySZGqc9KM+FhMnqWZ3BW4q4?=
 =?us-ascii?Q?nCS44bwTtPabv/1fqojikAN/rK5x2sJdJ/DkjvZIp8OOk2aJlDDG5OHdQMDj?=
 =?us-ascii?Q?J8AkBuSpWY6irVg5ifw7hl+YJ+bFdawNxWnlcXZOYWc3vKkXA1Dfd+qkjeRP?=
 =?us-ascii?Q?dlKJqsE0n24YGeJ/rpYHZ7v6LsaDz832P/t5wZbOUKS7rNpZF3poIN9PzmTo?=
 =?us-ascii?Q?6FXiCBwuUK3hKem/Adz/nTnc3cJquOba6vlZkqiTyVc+x2XKBywSha56QVSf?=
 =?us-ascii?Q?KJSLhe1vOEAWjXvNS3InG5uWaixLJ5c0Gww0x13MDfxk0yVq3TT3wAPfgylG?=
 =?us-ascii?Q?kDxEOXZOd3f96eZt7rh8CJ4dgqIJ82rOdre0+tZsqkZdhgzYtBd61bV8QYhA?=
 =?us-ascii?Q?2nlXX3Eq6ObjQSYl2qFzWuJVNxwPS/44fEQT5addiruJPAsNldoxPUXTd0Em?=
 =?us-ascii?Q?l91YBZXDsm9uc/a8EFu7DCBZbnzSAd/WB5jPinLKFN2HAwIIVNnF0O/IS4KE?=
 =?us-ascii?Q?kzr9Y6+7X122i3H3eUTnFwDSzXovcbxNpZNc5GoieVXuGRXcajD0tQ1crH0X?=
 =?us-ascii?Q?DL0muPDsaDhR1NXEGg2rIwuQw9p29LcPh/Qh4LI4ocinP1LgnHLhgSrA3+s4?=
 =?us-ascii?Q?PYVgruNF7LBMimTjsC5fgz5nXrzO1oQvvSWE8VuSzQksrEvPEuoBuvRoSdJa?=
 =?us-ascii?Q?0UaM6U6ivfCI1uC6tYp5H45YphyHsPb2KEauvZlREWxjR9Qbo5JC+ahYvKwA?=
 =?us-ascii?Q?0ckgujayxsiiIA2H7CVfdWzzoQWbnwzA6kDzfi8dunzaO601RmAAZ8TqznuQ?=
 =?us-ascii?Q?ZOrOhpGD+ArotXKeNCDzxsCYz11S6gHysLGFUnlt3DuC5YNvaa8cUX6e3g7b?=
 =?us-ascii?Q?6WVWFvDKwZ+WvNvRk3Cf/M9MSydJcnBKPikFVSPfvWlIcHQL0U5gutgooKrE?=
 =?us-ascii?Q?3Hc77yXICltAIalgzPHa9KnZD4E+gv3+BSvoPz5uEDDUfn2iXsKx2m2J72NQ?=
 =?us-ascii?Q?fFBFxvOT/glL173UknPbqPDGjd0qcw6tS+UnNZbhjJzWEwv6MWkwWTWvbM4t?=
 =?us-ascii?Q?CV/Mxpg8r2o1vStVbJfu3s8Y9J+G6RphjGjhSTYnocT1TkAJl/kK/GLEVBMG?=
 =?us-ascii?Q?ocWobQ4cH/pCH6gaNPTnoKQVwDLdxT4OYIlD/NqHP8IYaFoXr0Bo7ikMlVVT?=
 =?us-ascii?Q?KuXYjwfitzaBd5GAm/8bw/wGRAuuSZHKfLHvnJIO7BxCLxFxpMgDKdC0i6QF?=
 =?us-ascii?Q?/kk7ymA9lTkg2Yz6rCi2dgsOAiHfeiUDr/d9rSD88PZWwNUllduqmHm5PZKS?=
 =?us-ascii?Q?tA1bT7bo828ML/2t1BzcIO2wHrbjyIXPJ0lWLaR+t0HTKJew8uxS5xl2z5N/?=
 =?us-ascii?Q?t44Jz0rOZw7y0plfmu232iGG8YjIxZz4eB8cqaNf+40TDXh4SZtg9dvl6LgL?=
 =?us-ascii?Q?TQYxVd2gEv0b8E1/+lK4nF0YLhSG3eyoWWDHw3KZrcz7Auk+0bLnGkmavDPY?=
 =?us-ascii?Q?EBVV7Ktai15oLPEWfH75kCjNLcnEh6TRGFaIY/lbd+FT7GMFRVTXPYNVbs6A?=
 =?us-ascii?Q?cOMkZC7CjZWtG7Lx7g44ITF3yMudKR7ol5tMALkxiBJdwdopgpeVB8lwV/iu?=
 =?us-ascii?Q?1A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	M1mtF+Ah4jHRfWPqwChKY4q4xUGRdI1UtIz4Tys/fcWkh68BfAcNXmvu+dK0j3Ijsb7TWi/HIOEhVVIuOAs/gnfJ9DqarEzs+pmcq1iDT/IzOthCT2tHvxQtCZyYH5BbUiBopeo8W9OgIkWjIitjAszMD6dNB+uxdZNpGveG4QYiAt2w8+3jguoh6xJHTGXiM1Bbn4y6CJuiOv1rmLU1g2y+VR1BTlBnuSA3qtItTO+rlmUzCOQB3WYhczFS+9pzfIIpCe9XwO3czrpOGQKT4II/sdcCvE1Ze/btGCqYHxBy8u4DpWcjN0UCN+e+XBIt/B9Y3znx3A0BTetiJX+BgAOeSbCQvej4OImfgebl0ew9x91u/HVFzsr4SajdYP/px5FbFmgX4NptrYdByNXDh6Rbb+tBlogUoAl1IOQ/2J7OsMcpq63WsYutRmNGniaoLS5YjJ7Toylh7M+zUU6ILopVexUEok7o7xPof7DmAG/DgYEBU7bMg+HZh4b6xKW+lDtvbiZh8y6azFdGzcEBmvaer5GZVS7mn88/mpNohEFk5wILMI+Jn6D0yvWNGvnDcFnlckILSJkrssBgY7nBITxS1irgeG/L5vA1mv8HZek=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb474e9a-5fcd-485c-7bb4-08ddae5f53e6
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2025 11:57:40.9919
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ut5o3z6Zbcd6egCDCKSAujCvo6PFF02eO3C3hgSwlrlcpdODlMeKSl3q7S7tb+gqg+pzv064vJ+bHoVx/7xLYMjjn4SiW+48m1zmc6+fxSU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5852
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-18_05,2025-06-18_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 mlxlogscore=773 mlxscore=0 bulkscore=0 spamscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2506180100
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE4MDEwMCBTYWx0ZWRfXxCD6Zm3sgXWZ WugZaWZF8zqVYVl+dp+rUz1AksnxlLo7dLOOxpzudkoPYsjfG92U16mogyt6IdwRzJqjmDZXhgw 7pz//qXqxVF+H5g/Dz9RJlj3dNJpcYWdSTLFUyeEwixkSB/kSLcWIAVNG2K+c2SEkUPhWzpzih4
 pFgSUWP6lymlk8a+zYg+e6qh0wzxwjPoTL3YO9u032Gu5dUilGBFCSV/pD5+hAMU0gAn3Atx4vT fwKAyhdmrsfKL+M3umtvMVgny2X3o6E2vjbvmWzHnxrzfx2T7/Fx7iXW4b/2lRfs4kWeVFlBMFA tXOEI93WIxlIHlX3Z+PpkdN8ryvee9HTE0zpBwIaaPSTKyppYWCCukk0aroR8golURblOLX4fuk
 g47otQKnmq/SgyCAlBu4XMHL9nw6w7sIOOe7wBdhCSWLG4XnHAzafqYLiLDPNipE5aDDAOEx
X-Proofpoint-ORIG-GUID: PBg1qQizFU7dtPjF829Z8Ox5JCe0Jste
X-Authority-Analysis: v=2.4 cv=X/5SKHTe c=1 sm=1 tr=0 ts=6852a9b9 b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=8KC_ErlvkdLqVZISOgYA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:13206
X-Proofpoint-GUID: PBg1qQizFU7dtPjF829Z8Ox5JCe0Jste

On Wed, Jun 18, 2025 at 05:15:50PM +0530, Dev Jain wrote:
>
> On 18/06/25 5:07 pm, Lorenzo Stoakes wrote:
> > On Wed, Jun 18, 2025 at 04:58:56PM +0530, Dev Jain wrote:
> > > MAP_CHUNK_SIZE was chosen randomly. Good to see it translates into something logical : )
> > >
> > > So I guess I am correct, if we can find two VMAs (except at the edge of the high addr boundary)
> > > with a gap of greater than MAP_CHUNK_SIZE then there is a bug in mmap().
> > No haha, not at all!! Firstly fixed addressed override a lot of this, secondly
> > the 256 page gap (which is configurable btw) is only applicable for mappings
> > below a stack (in stack grow down arch).
>
> Sorry, I was making that assertion w.r.t this specific selftest. What the test
> is doing is exhausting VA space without passing a hint or MAP_FIXED. With this
> context, where does this assertion fail? One of them will be if the stack guard
> gap is more than 256 pages.

Are you accounting for sys.max_map_count? If not, then you'll be hitting that
first.

>
> Also, note that the test hasn't reported frequent failures post my change, so
> in general settings, w.r.t this test, the assertion experimentally seems to
> be true : )

I don't really have time to dig into the test in detail sorry too much else on
at the moment.

But it isn't a big problem even if it happened to turn out that this test isn't
really testing quite what you expected :)

