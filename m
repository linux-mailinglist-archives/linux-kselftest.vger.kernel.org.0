Return-Path: <linux-kselftest+bounces-6420-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2339B87FF88
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Mar 2024 15:26:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF893B2261F
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Mar 2024 14:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3817781AA1;
	Tue, 19 Mar 2024 14:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pYBWP/LO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2133.outbound.protection.outlook.com [40.107.243.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19F963BBD4;
	Tue, 19 Mar 2024 14:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.133
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710858368; cv=fail; b=swtwbFeq6gXP9X988X1ioAvLdwLz5mSpvyEQ5TxUIOboFTW/RkMpCAlsCT77UAsXCutM6NJyQup+yZNxXpOqKYVVK2F/ZXcoEBytQT51xYVxuF34nVDOG5an1m/DyWCUhgBg4vouGm8WCXpYUn3TTA8e7b43wv+FzC38w9sAekA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710858368; c=relaxed/simple;
	bh=c1yHo/rslxZ4a7VM2c7tYsMh7HDymuoBYwYmdoTt96A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DnGM3M2d8eSuFaPg/kFyRrRWvPqWOQdD0wQCHtI5hRb9L2RZJ9NQxBYqE72yHMLPvSo0V0SY0xHzmFQCoLTJHndCQSTXMBndFlTq+VlGt46DCb/s3j1L8ObpDuGcaX2JS6wqWY9JMc7k8Nx8VCOmOD9aATVmlpfrQhfOK7yNOy0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pYBWP/LO; arc=fail smtp.client-ip=40.107.243.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D6Mnws2FRQbV35ljQbJS1DvzVhmAbxkGt9swco6p30H8xeeOsKGjJ8lPcqIyI6k3hVWhRHRQWcrn/ywIDjPR/jfz9wakjUT3jR8YOPuAOwnLDoWAWtDjkYa3upjqLCvW+dkQ4RgeVdFFOW+GcKu6V/hJqT7ErOfXt3Bn1ykKsI3VEGFe7R+J6qEVw35u4eHKoKJ0JhM5BO/uIxqLQ31+kXzQSAyVpBZcYVUTmGXx2mzSX6X9foHFV2RuYJM9QGhjJH4kzPDacHKqXda0YFIOSQ1dSKkS7Z6Hc7xGCoZsn1DGAKKgRaBdwHe1SQ18HOuJUmoABIMpILNK0rY7xxP6Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Qn19pTdajoaYoKQKKj6XWFsvxA90ru+ajjkRxTc5Ys=;
 b=BCzJqCxyTe3pt3wijK8Xh4NbjdVGBz17lDYiWSdMhf6/t2nDnVMzmUO3qsorXkFm+P/Oth9DitIDXCYF8vcUiEr+2FzTkrGMK68zydLCo6TKZ3NGqDiXRJRrOv+JePY2tf2EKjPVhpFgARYLVkwRx0WKgpetL5oZnzmWtmQvjgO/buZTRUxKjgGBXG9PZSB0Y4ACq6DtKqtmuTgulWXtgDVUtj2DcR2vduIfMx6wyXenHW5beJEf9v/GCYV66Sv7+UykkaaD70Y62aci6FNkB8WdjHYrEdOwY2yjJ5HV8bAdruN5E5v8K8F9XYESRum8NRiBd/tLC9Hxyh9UWcvcag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Qn19pTdajoaYoKQKKj6XWFsvxA90ru+ajjkRxTc5Ys=;
 b=pYBWP/LOdf66LQxzii/SmTi1CS/7w86T++nNP0C52pdTv3sN9bYaTkcoDDuQ4eG3uP/xdzIgpPHBNJVeHIlvN/kiyJlOAnRPMy4vHeXoj/3Kn0vVsxngeswoLPBoUmSXb7uk3K0mni7OVbapN0eaG4SHYmwE3LTpLjwrakbvVWkeEh1UIUT3SMSbDkqyJPqR7lm5ekASUFEtKbO6Pu5a4W5OPaesfdMcMOOGPDwEtrgRfLwKOckSGg8bzp9CQ/aIUGFWq0rHu2NoJgP3/gY/urWCCS/quE6wtCjbjuz5smSuzDcZgSv1XjMt5+7Arbh9iUB6HrHnwLD5RIyEVphKzA==
Received: from CY5PR12MB6179.namprd12.prod.outlook.com (2603:10b6:930:24::22)
 by SA1PR12MB5640.namprd12.prod.outlook.com (2603:10b6:806:23e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36; Tue, 19 Mar
 2024 14:26:02 +0000
Received: from CY5PR12MB6179.namprd12.prod.outlook.com
 ([fe80::b93d:10a3:632:c543]) by CY5PR12MB6179.namprd12.prod.outlook.com
 ([fe80::b93d:10a3:632:c543%4]) with mapi id 15.20.7386.025; Tue, 19 Mar 2024
 14:26:02 +0000
Date: Tue, 19 Mar 2024 16:25:57 +0200
From: Ido Schimmel <idosch@nvidia.com>
To: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
Cc: Hangbin Liu <liuhangbin@gmail.com>, netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [BUG] selftests/net: test_vxlan_mdb.sh: 84 out of 642 tests
 [FAIL]
Message-ID: <ZfmgdVUmy-DgNklu@shredder>
References: <5bb50349-196d-4892-8ed2-f37543aa863f@alu.unizg.hr>
 <Zfe2cGv_EWFAZXAJ@Laptop-X1>
 <f005453c-c7cf-4e1d-b266-ffe1cf8fc79e@alu.unizg.hr>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f005453c-c7cf-4e1d-b266-ffe1cf8fc79e@alu.unizg.hr>
X-ClientProxiedBy: LO4P123CA0532.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:2c5::14) To CY5PR12MB6179.namprd12.prod.outlook.com
 (2603:10b6:930:24::22)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6179:EE_|SA1PR12MB5640:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	pSiVh5gLOpVhVGgd8IOft1GDfaEqZYLvjbGz2ZKMYKuFnbrbe2vxuzMjCcCG3ZVTuBtENGTawYYizFnaq+DLlF0DZosJg2b/loQZFQnTKW9y1X/ZaK8gbbUP2kV78y0aV6EcIg+TXyzB8LvJ8SSdf5VGAKKFoNitokIUgMhkhWQbyUfC9EDmMBvxZFnbhcidPr1e5Kidf52WTx1Dhthl3h2jftVDKbJOP4OEE947/5Fla7jJaQUug9fQwz6TBQmeTIhINNYX4UHwaKSjDw+/e5nRBE71Z/NxUvx4WI4kbCirMIW0XerXdcfH8oBxIaKGXQ4Slm/d/rF/udUjNvWXKCO/cKs4k7+kJy1qVocrNYCvcw3LDdtQU1ZePC/GMuZyaCrNKr6J75p3ClTGwKO8/BG5peo6wY1E/XrfRwD7G/IzT6mjDniAOWevebIjvCmPuw3xgAfDaBjeQ9eavwz0F9HN2ip6Sebzt1uMYSBSc5ByisreCgX6x3iCy2hIUzmzOwoEZwYKNwo9tl0YLjJI2xgr5SbJmbcBeLWIC5SgbuTyE4jEjZQFAdAvfjYSKnQrASuFpaflTmDJPUzvILQmN1IzybwtafXfay+cPB2aejnyqkT32taG7uUUFEqnTMhBQTId9ZlvN/m09HbnP11VFb3Mex/oIo5bNQfmnKQV1vc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6179.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(7416005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LMCppPAfgH8RQ0aBP9WZTas0SURrJ5As0osHByNW3XVHNrxZYO1SdzrQzCY0?=
 =?us-ascii?Q?kMT71djVRc0YJbJY6JipXjgydWa/DGWgFsUv1F6ZwSxUSSIBuUPtHY8vl00t?=
 =?us-ascii?Q?wYhvHQFYuI+2Vd9vCc0ODqlH9pSu03ta2RU+IVdABKo3JyGjUjiSZt5RImiW?=
 =?us-ascii?Q?XAPp+/SByaWdCVl0KI1rLKHtyxrAoD3O7qorT7Dgh0EFfBwkYXGraBRsOnAF?=
 =?us-ascii?Q?dArvcT1zxuyn/GDvFMNpTynMoHu2WyAGvo42Pmus+WmRMXLmvGAL/owtbvlQ?=
 =?us-ascii?Q?4SNgVGzn7LqvrDay7RmKclYP9OdYv52NlypOTYoYr9nnazdGPIX4qnFhYVL3?=
 =?us-ascii?Q?PY2gRIjlRhfPt6HmdlG8QMb08rQNf+BnzukbpBQx8sKxSahd/gKx+Y1udeCR?=
 =?us-ascii?Q?vhv8bqb3JXTd1O3NawFyNU1V4iqeQQgMGecxW6PzhFSSorW1Iot5I6S/nUcG?=
 =?us-ascii?Q?nkmT4JV1dH5RI7YuR1AiNB1FntvNou7zlazNsgv+fVakGK9sQ8eb0FDBP4oP?=
 =?us-ascii?Q?tcmGOgScE5yV5apdNpYZwI1Wkz2ZliW9syj5uLD5evp42uxqqU359gyjxjeU?=
 =?us-ascii?Q?6ep6qUeR8ptejh3lSGknSdD5G1wjSnLEE1pAhvBnqaHqztPGczbPrmxBkWIS?=
 =?us-ascii?Q?WHrf5sT06eRXaaxEY01/00ACX2f+zlUaMnGp09/g2ZHf8/insl91aAyyTmV/?=
 =?us-ascii?Q?KFeHZrb6SGTwRL2K+4NEFsaRP22bd6yn/aqBYLAXlucGLgA7xlNsRWNGl7hw?=
 =?us-ascii?Q?nFRjVOJ00dvt+rW+1TaysNybExgth5dm9HLzPU1ZXyKBfbGVWXmv5oOnkbzv?=
 =?us-ascii?Q?JqAS/7SQNce8Wjw36E0XtlvlXvBV/heTx2ScmlIKGO9fTyqJpmINgfeDu2JR?=
 =?us-ascii?Q?GTcAf/o6oWv3ii6pDln5eI69IYBkFH8JHOAoV/axZXEBjQIqsTALEhZzN++p?=
 =?us-ascii?Q?ytXxFGYuxwsU/s0Gh/jLDyW0o2z1noMxFolDLaMGNT5wqY9THRWqWoQMnR/c?=
 =?us-ascii?Q?wQxxzsiVMzk/dRmjCu3ej4tExQ63c8OiSqtMRiRzJRjRwsNoXfzXRHKBWOk+?=
 =?us-ascii?Q?+EMtFplkPEmCNySm7M/uaI2vlWwJZ9BWhfzb/lcrrf7Hpfszc5PWxev0neWA?=
 =?us-ascii?Q?TkS4BCq64OLDqrgq/bDKkFrtM1FVGSp0iqQzaHUCLU/dIgOVTB8w1Y6+AABW?=
 =?us-ascii?Q?QPnXzgwayM7RV7/5WWlTKTmUgYLi9pEtibhz3ATFMFhegS2Ouc9huJpX16dO?=
 =?us-ascii?Q?vpoviNAixC91NNxys7KUevM5aqPYnDD/qMsz1Vf6rlrtaHH1zVgPKicOXY9K?=
 =?us-ascii?Q?DUyngiL+QfVamc3gWyWx22B3wA9MnHzWChFPfnH33VUsyVs6gUxU3X+o56rl?=
 =?us-ascii?Q?V5TnBCcI+LFVfSYuSKSZejFTSlvtqm3d4utNHJT1SFmnN13+DY+2U0pLKKwv?=
 =?us-ascii?Q?4q0hfyYymdqYVpK1Bnc7DQGLd5IJFUEzNEfmDc1coGTfmdKv2J/7k9yBFVeX?=
 =?us-ascii?Q?joqU/7S05badADdZPGV1o4/thvWlOm8+zRuDxkG+B91wAnjj6IoldP/sz87N?=
 =?us-ascii?Q?48ExkKmcyME8nxlOnYcZuCM19XAOnjd1sXA0cjbg?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75b2571d-eb41-40b4-8331-08dc482080d6
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2024 14:26:01.9064
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xuirl9XAOkvlnvLmPAEN9RTb+WU0434hEPC52kNjAJ3BFvyBIL6rDX1hI4yd9NMvCvE4kD0NInjq0xfwgiZZpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5640

On Tue, Mar 19, 2024 at 06:05:16AM +0100, Mirsad Todorovac wrote:
> On 3/18/24 04:35, Hangbin Liu wrote:
> > On Sun, Mar 17, 2024 at 12:19:12AM +0100, Mirsad Todorovac wrote:
> > > Hi,
> > > 
> > > While running kselftest on vanilla torvalds tree kernel commit v6.8-11167-g4438a810f396,
> > > the test suite reported a number of errors.
> > > 
> > > I was using the latest iproute2-next suite on an Ubuntu 22.04 LTS box.
> > > 
> > > # Tests passed: 558
> > > # Tests failed:  84
> > > not ok 90 selftests: net: test_vxlan_mdb.sh # exit=1
> > 
> > FYI, I tested with 6.8 kernel with net tree. All passed.
> > 
> > Data path: MDB torture test - IPv6 overlay / IPv6 underlay
> > ----------------------------------------------------------
> > TEST: Torture test                                                  [ OK ]
> > 
> > Tests passed: 642
> > Tests failed:   0
> > 
> > # uname -r
> > 6.8.0-virtme
> > 
> > Thanks
> > Hangbin
> 
> Hi, Hangbin,
> 
> I am running an Ubuntu 22.04 LTS configuration.

Didn't get your first mail for some reason. Anyway, it might be related
to the fact that Ubuntu is using an old version of libnet:

https://launchpad.net/ubuntu/+source/libnet

I remember fixing similar issues in the past:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=cb034948ac292da82cc0e6bc1340f81be36e117d

Will look into it today or later this week.

