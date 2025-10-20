Return-Path: <linux-kselftest+bounces-43555-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CE39BF1E91
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Oct 2025 16:46:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DCF6E4EBE2B
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Oct 2025 14:46:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 016751DE4C2;
	Mon, 20 Oct 2025 14:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ldC/Vmiv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011063.outbound.protection.outlook.com [52.101.52.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48AFE1C8605;
	Mon, 20 Oct 2025 14:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760971613; cv=fail; b=HeDMPY6PqEhTD/im59CTeVqLCwNcCrN/e7T6c8kzcXpJ50fF9r4V7M1Za2EGKjZs7JIIClKgoRBdNSwrja7y+/HXSFrhOsXZusrYY71KsqeG+ICONqYISnd0oFXEK2ZSrU5xI3llp5cw/OwQ1kuO05ypvms+cJ+7YJfbHaXvvko=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760971613; c=relaxed/simple;
	bh=ISzZVrTtT8RwLLYOeRSrfNYwfJKCoW5rlxl/2Tz6LHs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ctRb8XXziQh4sCLsvufMHG8ejyaFR8zGmm0zX2Hy/BVCm6S2udgoL5HHb/OLQcG/jH7by1MNt1SM1CwwVAaMn7faok48rT8HFlWePHICbTlVQ3mdYHwvhaqUY2c6WpXgcq5Uue2aZAh7Mw9geYOsTZQU7JbfNAnf5oQNpxD9Umo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ldC/Vmiv; arc=fail smtp.client-ip=52.101.52.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cXrTx9KxnQPNDCzVnK+9b2AS7gw4mqXTEYGOAz3UZs6SpwNUBMqcFnX42XNitht4m87+qQO5BSJVda18Acw8nyYduclUKot2wwYJNXblNsq6zJUa6tP1Zl1vYj0cRitJCi7czQbpCeO8GcGLRRB3t+fRgmPRZKvHAuHNidLojaY/CHy5Upxilj2J6kw9NmCsnnA+/zKXTM9zn/EgWMr6ICInsePuDHLsEPwYbW6BpoXi0QHoziOE7/JN+BdCMVaDs0o65wdTPNat1WwDTSs12kIbJDq8lf2SBFG/bLOzDcWa0q9crW2OSoDsUy8g/m10VhwNkvCYg//+6Y8iT4xNuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e9DE8Y4ELtbu9c+CGNbLoj5JLa2wZmUmqU0Hi3lY7mU=;
 b=Js0QxAeqZjRpCddr47cHNZwII3eR/5ngTY2YsBb4RFYr8ca6qkp1+sErIGCETR/75GFLGzmq90W+JI/xIRp5TctlQXximm1wdkivu6vq08s7/SaYVoXoo+aReSs5LOHSe9jUo39UGnfwzp5MrxHHYImtodpctgpBuqFlSRJUhAojpi8KOyefUtp/ywXciH6dGh3uIgUaq1qI82yRb0Gqw5i3c1B31XNExhvpl12Yd/LLVrPs0sZ1NlLyp4kf8hu6qgA5d+wYFwF9u8I/iRXyLsMcNua7CjK3pZn0X72iZev7zxBNR2/dV3Q7MqBtZL7K116PdA8Ju0cTKxN3lVs8mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e9DE8Y4ELtbu9c+CGNbLoj5JLa2wZmUmqU0Hi3lY7mU=;
 b=ldC/VmivkB3OKreyLYZ0NwHo37Z4iz8tjeOXjfnLH1ocHS5/1eDWWirJmDckBMn1g7avIYWPExlbfhWhy/tIqVqf45eJrjvt+hBKP6cQUw5GxSc5Pw2IrMv0L9SwY7yP9mdr70ilphh+KAAGgXEF3h/btVgcL5alG61TYTyshH2wCHejnQNZSXa81jjjFcgyY98/xoZ4+KWLtq25btg9gYj6GdZOvOBoDKyi22wMQL4pwiDINnD0+6BHlkocLV/tOASrx6S+gRHyVD5/xhwV/8ujyoq3fqQcNHSVBUrqAKX+/b+zh/rKmx1V+nNywvUEGq8Syc7QgZX0htEl42hiGg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by PH8PR12MB6867.namprd12.prod.outlook.com (2603:10b6:510:1ca::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.16; Mon, 20 Oct
 2025 14:46:48 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9228.015; Mon, 20 Oct 2025
 14:46:47 +0000
Date: Mon, 20 Oct 2025 11:46:46 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Jiaqi Yan <jiaqiyan@google.com>
Cc: maz@kernel.org, oliver.upton@linux.dev, duenwen@google.com,
	rananta@google.com, jthoughton@google.com, vsethi@nvidia.com,
	joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com,
	catalin.marinas@arm.com, will@kernel.org, pbonzini@redhat.com,
	corbet@lwn.net, shuah@kernel.org, kvm@vger.kernel.org,
	kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v4 0/3] VMM can handle guest SEA via KVM_EXIT_ARM_SEA
Message-ID: <20251020144646.GT316284@nvidia.com>
References: <20251013185903.1372553-1-jiaqiyan@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251013185903.1372553-1-jiaqiyan@google.com>
X-ClientProxiedBy: BL1P222CA0021.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:208:2c7::26) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|PH8PR12MB6867:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b8cd6ff-bd2c-4155-a7e0-08de0fe77f11
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zm7iftggoofnt0HG7+J72zWLiEF5U5eHrkzBxye8jnCKCds/XPERGlCMyu78?=
 =?us-ascii?Q?DQxWjJVWzKAEKTmmcfcf9qX7lJcXDYXQiU+bUUh40LcXU7hPEPkbhhVag38Z?=
 =?us-ascii?Q?yK9DVMUQxZn05XcZ1H7zdY0H90epWZFGrZgy0Of8Q16n7X+cv6A8GNPf66yB?=
 =?us-ascii?Q?zQs7VzZxt9yKmpOBE6Ud4bwCtdqAxQS3VS76oSEcz1hVDQfi5p15bFQWwepC?=
 =?us-ascii?Q?xEhBr3pH6fpZVvwJAneWU1h9QOSYUBnqNFDmS5zTIIKL1T3cYOxfBD9ExXkc?=
 =?us-ascii?Q?EOl3NaW9BznQhX5T0FltJLSNjEG//t1tyxdWe2iqjc8IAusVSrrbHVqRQ1/9?=
 =?us-ascii?Q?J064OXdQK8ufW1hi5YDTsK2zAPk873lG9JKHMcXH50Pw0GAMQn8Nv3Tq3S2m?=
 =?us-ascii?Q?INnMw5G5QUiwt4nM563JngtAhvhxsqGYabVaPDxp5XRBXDm/ZiOJOZwrf+Qt?=
 =?us-ascii?Q?UJvI1nBVZ+8jKe/Lrpa31TTRVGMEe1Oq2rGNlcvQ9YLiWTKzU5Pa1f+M4BZ6?=
 =?us-ascii?Q?M3UT9o0EEWb1bkAdXiIBmX0QRfdUzXwFVG0515Hd2eFMe9JCmeu5omCB4B39?=
 =?us-ascii?Q?p0sFEWTrr0XAsedJEw8ovQw2D0mRglIhaJVO8gVCVURQXHyvtbzxkAINM4/t?=
 =?us-ascii?Q?vu7fkyhu7ucuwlT8U4n/mZdcmkhKkrMCEMFxditKQwUQ9RnFK9/rVbgBEhqw?=
 =?us-ascii?Q?CFBajpRtB62Cz+eQEtjjHwd1H/erasVGolETs8cKqNNi4P3oLDekjENsjLJd?=
 =?us-ascii?Q?Yfo/V1Cp9pozP//NNjGI/oMMD2I8Q9QzZrq5u80DhQTUHAEzQRibuHrm3Q9R?=
 =?us-ascii?Q?hwDIj5iGHeWqRLQeiqhB05KEKNP109uc1sQEUSkd/bjP5WsGLbdyOKQzemnw?=
 =?us-ascii?Q?HkSlFLWwevU8dH1jsKY7iJx45OzDQc8ZJ8/3BCHkLXlDqgvZ4+TiLWcwGBLf?=
 =?us-ascii?Q?WvoHN8RHavDs8gJC1EH0Aom8/CIhD5l3T0tpbyBDMtVrmbTsiizElnaI9Vqc?=
 =?us-ascii?Q?DmxGJagTxBpP32KCPEYtJMUMsAInpy+bHDmP+fa0ZbWjyG2ocfpxqHRy/ad2?=
 =?us-ascii?Q?OCc74Sqj6GSBOgmhBNEQQmdj3p5yGinyITQZ5Y8/4frMj9Kdcjo7wdWvIdUH?=
 =?us-ascii?Q?3blIgYxStOy1oo4H7edJsx7YC8wgPkpwXNb1RI3lsJjP3uKcXcQriXgNrloD?=
 =?us-ascii?Q?Xd4gj1HeIgfe7xbuPpddLxfjEcvtVBJSA8w3IFG+5lkkZh6c0680nYAx1Zgi?=
 =?us-ascii?Q?gJ7W2roe0qvmguqex0qTGrU/WA92WuWSTIO+DyE3UUKEVh8Te4r06na9p8Gt?=
 =?us-ascii?Q?IwnsRQlepamlPz7jFyhbbIt6HMZekLueVQx8jHG6dCNCHVESRIhekqhXQfY/?=
 =?us-ascii?Q?o6yEBUmFsgMxRIY/CoMLwoo6Gv4do938N01zc6QRJX/HhOG3Aii8EN8FFTzO?=
 =?us-ascii?Q?Mm/rv/GkAnMYRCEW5b4B6MaEMSCdCdE3?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3613.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CbpydnOm2ehy9Y8098k49cTnLV6nDZgrIri2NSFTODMGY9JlwVG96d71eRTo?=
 =?us-ascii?Q?EfqqD2DYnDGLDja2pJ1X30vjCsa2NqPKAAxG3ctWNckf0zWpOOhKi6pgvJjs?=
 =?us-ascii?Q?FOC3KajZPgEqfEjFxdEqLCGzX7+j+yrQIlyJMreus5T4QClbDM9oLVzSD02c?=
 =?us-ascii?Q?E2Gp49NM1Lidvk0VK+tJ0jOGeezvIZj+Z3cF03P457ZrPUK54MbVFIHsREj0?=
 =?us-ascii?Q?SXR0oSxP7bt9znTzfVikZhqDFeNlQ5BasC6Q4cPB2IZiKj/ijPlh7b+uRdBh?=
 =?us-ascii?Q?xltbNwtmRRej8gbbmSAVE+FjpQHtaO14LOxM4TqmYvWSBpvwwmXwH/6cRoe7?=
 =?us-ascii?Q?nhJpymvaRWY8BlpqqLR3jdxR6IP7aFYCSq3R725PJF16CRsXntDJBmmxyTqn?=
 =?us-ascii?Q?/ciLqDFEvJfaQcQR31yV7EqFYVuJDEJ18eu+vixpU9lSphAPoayGTxVA4zD9?=
 =?us-ascii?Q?WiOJcMgwA6MO2AQF/cYGxesu4j6UNploLYW+cmXGQIHrO7Zz8DBUM0C2pY2/?=
 =?us-ascii?Q?IQynamDCrhclsJinZaofcjKO2FPAuW/ATZHiIzAKGZczV9F7A5kSQ2fQ6+SW?=
 =?us-ascii?Q?9tzsRIqufgnU2fkNVZ3NxfgS47S6sNfBpV9hIkuxbLtJ+EASwGhH8blae+3M?=
 =?us-ascii?Q?6Ig1Yrr4o50bArIfJrLSpiiaTtM0xxRH1TC6MRRjrXwR7XUl3UnKdNENN3Rt?=
 =?us-ascii?Q?2Yx8fJ5d/6IUtDBq+ZfZXeWAdulahPkjH7GCFcuZZh4hAW/a8U6H5ikB+9zD?=
 =?us-ascii?Q?9NuGhi1u347b3VxEWLPKbDzbpxk27VnrsSktSY4gEbsY8NWFY0CmbTSQVPJQ?=
 =?us-ascii?Q?pIuHuUeYUIuoLU1YmN0Vb/ZaszX5ALYeCHOZoHmofdK9PRFAeSzEcXdpSuN1?=
 =?us-ascii?Q?YfncfytJnwBaTdewaukvjt4MW9K33XOofBKbpbFXU759jdLbVn7sOmj11/KB?=
 =?us-ascii?Q?NqHPa6AIf/PodoHm7YGtDP2bfASu3IKMFZ9/LrXV1qXqCSGWHuglq1hmGmj3?=
 =?us-ascii?Q?BLoZrwjnfQ53NFNTbAAbR+xVrVPP0z4gZI8mROjEeLOlB0WzxMJcwlKwVUri?=
 =?us-ascii?Q?py7dcqH32yg/EqqTscTcIB9l0oBzetBqmQsnN5iuW12gAyawD1CPK3R2WMMz?=
 =?us-ascii?Q?3/JZ1Jr2t+2cTUurv7whXu2+n2uVyjgFm8GVjzwqpiCXtEIa2MlodWM/TXax?=
 =?us-ascii?Q?BSmj8shPocrvE9XIKIQvit/IBTOEpSXba9m49qxAODUwelG/KqCWivhHBZ9u?=
 =?us-ascii?Q?8D1gn+a7mBQRiAB3tasrZHGt/vXtnbnkxQVfy6OVDXUSD3ylNIN6dtUIKTIK?=
 =?us-ascii?Q?5EsD0vAS0IMiO0L9utjcJCMcr7gzWDZaWrvrlta1gVICJnZuG9QQQNXyGCyL?=
 =?us-ascii?Q?G5hinTC4QIW+dDutgjX+QrUIu8Yxc6TShFcZDrocrDZci0DXKme0XDrWcEou?=
 =?us-ascii?Q?JD64F4l2RbrswQBMfyNRwFvE/GPvwCssQEcQnMSKWwXyIyH6iro97CwUmjVg?=
 =?us-ascii?Q?ooj4O5/O83jSq++3QpA2kWeJKn1VUdUPK9DDgPLlfrzUa3Pq/kioITeTPIyr?=
 =?us-ascii?Q?EyEU6n+wTzhUIwZhQv1KB6uQQZR9sHIx4MwQMMOq?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b8cd6ff-bd2c-4155-a7e0-08de0fe77f11
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2025 14:46:47.9281
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UjQzy/+/BaDu6nwETAdb8TbACWTcDV9eir6snZnPKkU/4Z87V+NtlbtQxmfgM0PF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6867

On Mon, Oct 13, 2025 at 06:59:00PM +0000, Jiaqi Yan wrote:
> Problem
> =======
> 
> When host APEI is unable to claim a synchronous external abort (SEA)
> during guest abort, today KVM directly injects an asynchronous SError
> into the VCPU then resumes it. The injected SError usually results in
> unpleasant guest kernel panic.
> 
> One of the major situation of guest SEA is when VCPU consumes recoverable
> uncorrected memory error (UER), which is not uncommon at all in modern
> datacenter servers with large amounts of physical memory. Although SError
> and guest panic is sufficient to stop the propagation of corrupted memory,
> there is room to recover from an UER in a more graceful manner.
> 
> Proposed Solution
> =================
> 
> The idea is, we can replay the SEA to the faulting VCPU. If the memory
> error consumption or the fault that cause SEA is not from guest kernel,
> the blast radius can be limited to the poison-consuming guest process,
> while the VM can keep running.
> 
> In addition, instead of doing under the hood without involving userspace,
> there are benefits to redirect the SEA to VMM:
> 
> - VM customers care about the disruptions caused by memory errors, and
>   VMM usually has the responsibility to start the process of notifying
>   the customers of memory error events in their VMs. For example some
>   cloud provider emits a critical log in their observability UI [1], and
>   provides a playbook for customers on how to mitigate disruptions to
>   their workloads.
> 
> - VMM can protect future memory error consumption by unmapping the poisoned
>   pages from stage-2 page table with KVM userfault [2], or by splitting the
>   memslot that contains the poisoned pages.
> 
> - VMM can keep track of SEA events in the VM. When VMM thinks the status
>   on the host or the VM is bad enough, e.g. number of distinct SEAs
>   exceeds a threshold, it can restart the VM on another healthy host.
> 
> - Behavior parity with x86 architecture. When machine check exception
>   (MCE) is caused by VCPU, kernel or KVM signals userspace SIGBUS to
>   let VMM either recover from the MCE, or terminate itself with VM.
>   The prior RFC proposes to implement SIGBUS on arm64 as well, but
>   Marc preferred KVM exit over signal [3]. However, implementation
>   aside, returning SEA to VMM is on par with returning MCE to VMM.
> 
> Once SEA is redirected to VMM, among other actions, VMM is encouraged
> to inject external aborts into the faulting VCPU.

I don't know much about the KVM details but this explanation makes
sense to me and we also have use cases for all of what is written
here.

Thanks,
Jason

