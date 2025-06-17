Return-Path: <linux-kselftest+bounces-35220-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5DB7ADD9DF
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Jun 2025 19:10:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 919174A7AB8
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Jun 2025 16:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D829236A73;
	Tue, 17 Jun 2025 16:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WbRDOvZZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2065.outbound.protection.outlook.com [40.107.243.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 282172FA64B;
	Tue, 17 Jun 2025 16:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750179124; cv=fail; b=ce7+w5SS1R/0JUm0GMmHSLVln6uOuh4jS+DLSoz8X/C08Lt0UywTxsFom5o2JUqmt9zvKZndhmmr8lz9deot8+wKTFMSpMbd3YbnQvWt+apvrBpNaplWzv6I/fnXsr6NqxtUHTvBX2Z9LA9rn1XvqR9e+M5hqWD6rOgRYSW7ljw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750179124; c=relaxed/simple;
	bh=W/jHBY9+wzig+Imm/f1bYnWPYEN8jqOOSA7R9pNH3wM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PpSbQ1RhK8FuLaW7g7BxSeu4naH/DY/n+FOSLMkwKRkFY3bt+D0la0S91ZSX5xeWhAGASkSjZxeiCwgdAKpZ1ckgxuMYZExajL4YOTsK/nzYSDAPkP1Tj60dZcSMzzo0PRAfDS/Ue0dUBwPC8qgvFQigYwKXNjxJGgXl+MYfpuI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WbRDOvZZ; arc=fail smtp.client-ip=40.107.243.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BzWbVrIwn/EcQruLMlrHcTcOZ2HydeI0+zSDYhKz6tKx/qNQC4VWBsfw9/b6sxWZNe7EK+mAMpdp4GXkoDyXAwatA2dn58lQq6PBSaAxhgGllcWrUV9Ymy48HzBXLxPojKnR+RdaW9zN+UIqVlMyykF2PAWIkFI59V3esyuzpYgbrq9s+lgrL9FOpbpMo0G+B64A/hBb4SCDnCJUAob9HvaCZFEyIjJo0vpmnZ1Tk5UuRvjqG1cj5dSmdYFnwG/oxI4OY0d6gZqA8Gx2Wb5dZtMhl3FTn+jQ/HCYQk50DBUxFJpXzMaONdCBv7z931By9fgJjGGwmXiUqJ0jftJw/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wEDKXEaRCFvoocC+B46ePPr+8AdrPOlrKGNvgWg+LSk=;
 b=XG3BbdEBMaMLSFoPA4FGkEBqZvEl4tKrzorf0hlJVO0CmDOuctLYDraRwiXeHVxF81+nKQbPs5WmpJ5rPGYk1Z4y665EErCRPDAWw5aejSvocTZjl9SoCq7YGE0qKSQbgY98pp+5lEINCdIkClyDO1V2cok5e5uXQlESdFHrjgJGwQRMZ7/DRXvnHgjEuw8I2rkfw5qDk/Af75UH3dpH+is+RoJej9KoFqXWwXPsluWqkpuAhGzTNOAH6YZYYgvZOGTRg7sZChbXfmflm3/D32LsTjPzHYCKIeoVSlCtc/petDydvctinrlDeDW/tNwywxpxKUBu7wYHsLugL4V9kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wEDKXEaRCFvoocC+B46ePPr+8AdrPOlrKGNvgWg+LSk=;
 b=WbRDOvZZWJFsSvQnc+8ta6cTC45QK4tj691QQ/sXN/wyvpNJGq0hIB6aelZAp2Bhq5gQXr9tcTyCLNVLIpGavg5G+j4+22GnQy2aymF7eSkvdl547lv69OATaQOmUFlrVOgMcTQkvjSmdJMmTzQBIL7qudAMbsJQCZ7WfKeECgexmqPL57yJr7NBu9zOmJhAQ+FLmD2N/zgBu65a6WYdQvRGIhmliokwoxTajWzrTUaqQRNwPLmQDMQitQGYDMPQO4Nvr02O8hEzz2d5nFyTVOQnVnH3BIt7DOGNY1qrYTX9+Z53FZMJqVwBt1Kqgiq4AGMRHP/d6gHPmk6E1R+mAg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SN7PR12MB6911.namprd12.prod.outlook.com (2603:10b6:806:261::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Tue, 17 Jun
 2025 16:51:59 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%7]) with mapi id 15.20.8835.023; Tue, 17 Jun 2025
 16:51:59 +0000
Date: Tue, 17 Jun 2025 13:51:57 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>, iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	Justin Stitt <justinstitt@google.com>,
	Kevin Tian <kevin.tian@intel.com>, linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org, llvm@lists.linux.dev,
	Bill Wendling <morbo@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, Shuah Khan <shuah@kernel.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Will Deacon <will@kernel.org>, Alexey Kardashevskiy <aik@amd.com>,
	Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
	James Gowans <jgowans@amazon.com>,
	Michael Roth <michael.roth@amd.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>, patches@lists.linux.dev
Subject: Re: [PATCH v3 02/15] genpt: Add Documentation/ files
Message-ID: <20250617165157.GA1558251@nvidia.com>
References: <0-v3-a93aab628dbc+521-iommu_pt_jgg@nvidia.com>
 <2-v3-a93aab628dbc+521-iommu_pt_jgg@nvidia.com>
 <aFDMBt1J1w8I_A8U@archie.me>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aFDMBt1J1w8I_A8U@archie.me>
X-ClientProxiedBy: YT4PR01CA0476.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d6::16) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SN7PR12MB6911:EE_
X-MS-Office365-Filtering-Correlation-Id: abdc6843-0fc7-4a62-952f-08ddadbf4655
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?R+nRRuLXtjV3JhrjudMcrkLlEu05j9G4g7SxHoaBM6tTO1wPvrFGr3DI6EZ5?=
 =?us-ascii?Q?hV38Ek/BQMEJQM8NUXbArqgOkQb63NSOkWYTLo9dXXo99pIMEjiAVncJlbBC?=
 =?us-ascii?Q?ywvd2HyzvREG4BKueoA6IgNZwShS5ZhqzS/8MgerFHSuI9NcxWuf7QckE19x?=
 =?us-ascii?Q?zgAxvQKEHiGVWg0YaScN9QtilSlQ/kkocHNtPQt8cxMFkEqlVKxZ/j9seMRY?=
 =?us-ascii?Q?xL6P5ogKKfpiuc+BlxHDCEzs8Ke3J2jh6q50halq92Q0CYEKj0vMhYVE/Vua?=
 =?us-ascii?Q?e+N5gUvgDw2WQbbwTwlJxzt6ccG4r4685mQwSjv34jXHwwxqM0P3OJ/FiSGA?=
 =?us-ascii?Q?vUjLgBWbX0j/2b6eodbZ0dTfrD1cYg65DmRARjyZBn8/0y7AutqQO24Av0d9?=
 =?us-ascii?Q?zm/MOsupvqnn8WJYaaPzSbMeE7S0I/HdxFGKCJYjHiKvYWk2bfAbFjeSL8qK?=
 =?us-ascii?Q?5fI4zyjZMao6d0TQhhzA/Ph12YA6OIHpqJXIQl9F8bZLCVZdYqEll/E2PIsb?=
 =?us-ascii?Q?GLql5ELBs6JTmGZy0pONMF1SAlE/QzCM/q4jTv3+NXu/bZE8pcqSAIr6xAdg?=
 =?us-ascii?Q?zsGYNRRrtOyCWPKzGCR+6DlbLLyHQmX79VQWzD21lPi2tAMM/Sbb2FaWA4ES?=
 =?us-ascii?Q?nKUmLoOa3jtAFxbk8U3/v7iTz9CIiiVnzawfXglSojm/JghGTIpUJD/T1JUC?=
 =?us-ascii?Q?jLjwuCM+NfY9JYM9UDgYs4y3WRn2rbIkec3YMA8DRLO5H7HKHvFt1oan8dUi?=
 =?us-ascii?Q?t4InhTKDmyMHZxCBjf2aksCiapcgWrqCeiQ7qAfs8nG9LCtMYhRq0ATXymF1?=
 =?us-ascii?Q?ZRWOUy+hqpbgAXdPtZN+ZUeRpI73k+DlBI2xJ8+2pT6hTEzmNFN5WFte0e/V?=
 =?us-ascii?Q?HJkfDfKc8xkBvx6TO9BYGrGMb7e8JtkbrG7eJLv+01Tyl+aKB/k8/T1mIBJj?=
 =?us-ascii?Q?2WbcYnHqPE16NfaHq8fgx4Hl2cNjKu9WjpwnRMHexJnCegN5cE6ebtQVeEvb?=
 =?us-ascii?Q?EHx4m2MEOTomwjCcRjW8da3AG84fv93kt8FvGPmwtDTwdLD7ksGJyAz3ajCH?=
 =?us-ascii?Q?2fF1fnz9KQId+OB98MjX9iHO1OWe/yR4Oae+e3dx3+G+D+mHt9g2npbf4AT2?=
 =?us-ascii?Q?MG8CeDNwui5/JDmYiFfUMphPzn+OeJvJ6k5FvJ18Oxc8voRt5k977acKMkWy?=
 =?us-ascii?Q?Xi/S1BF2K4oLP6h/PsTvksbxu+1RtCR//hKHhIlHeG0La+iF2/sP6JjWZZSo?=
 =?us-ascii?Q?lbzfF89KnsGQXON64mm5Zv389Tcejp1N3zOoXog78F0W2/N/YN4Q88Fx8ONH?=
 =?us-ascii?Q?fyE259uvFiCwEyxDWPC82hgisraC8D+f2rkHqanM4q0yf6zARmJEdI542YGL?=
 =?us-ascii?Q?T+m+l/DW3hGqESwMJRd2adADos/6oIWvs1Kl2Fdpy0FHwoE02A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bGaHacXrJfEa9H0qSzB+cmKBAvTdrnK5Ew0hWQxplimBCsyHPHXOacdP+3lF?=
 =?us-ascii?Q?KAcDYC6823bmGzX3tAdlrDFuoTMQ5pJBUE3BPgHLgtvUBd6NJRbXC2M03tVn?=
 =?us-ascii?Q?Y36nQ73GmlWCAg6V5mw8Lwv3EaSjjifIVUqq43Nmulf2jG8bsW1qWwpZPILa?=
 =?us-ascii?Q?ngZK9JO36Zc55+zD5Mt5uOK9VpWumjyLvNiPKdXAbdhxjILxrsNJIPEjIGjD?=
 =?us-ascii?Q?LQm/mflTZKA8GSHbCs/I+jlSX9Slr91Izg83wTGcAPy0eclLkuvljVIkHj0Q?=
 =?us-ascii?Q?vBP9BlhytaXONCBtwOkG3pucXz264qxwPmxxrLTBS1RBHc1mzEijqmYneDXl?=
 =?us-ascii?Q?d4QnG/stBKLoznCWadH79GbO0b2+dsLBBRlgsE0TVtKqILz6nCmrN8M96TGj?=
 =?us-ascii?Q?7nZxaPhc2bfWM3oCgOwra/q0k0ys9ahOZHvZpXbReLxTdDgfCA5WoNTpSPzk?=
 =?us-ascii?Q?M4gqgMAGQYnCcOEgbgZV+5vJGF5UObxaUpvIUsMZAhuH86id4j7f9OXem9aE?=
 =?us-ascii?Q?eeSvBhtykLExI+O9pyQioMI/ie081IlmngRLnZJN5uudRe3dWyuW/G6OTJhu?=
 =?us-ascii?Q?OYNY0Nli1fO1AeL3J9fBs8iyhistNOFVWKIg92ksiUZuU331yCNrVJlfGFSj?=
 =?us-ascii?Q?D94XV81vr/ETNk+gVnJdBdDj8VUppu//m/V+0KhmdQ+u3F8tma8nJRKgG2NS?=
 =?us-ascii?Q?NQ4C0CP5Vm5NdkH1dPAJBqHTLAfnnNtKv1uP/esztmAJ/KZGDfV3Z7yo2OvR?=
 =?us-ascii?Q?VUjvw61hDdk0xzrvjYuqkpua18smHLVzQK8iqUywcAg6IdwyLsGkwTu0BIa1?=
 =?us-ascii?Q?WgRtj9uWrymSKmizObKcw/MBw+h293dmKdw/677t0Ov2IOhK1woNwp/rKtJN?=
 =?us-ascii?Q?2CrTU4TQXNCioO94eTyA90jDtj+XQISKjyd/L8tQnB7zdoMYCTjOxGTe3sgL?=
 =?us-ascii?Q?jz1zqn+oMc+UiSnOnEb7zaMR3gL/kytrgh/NlZ1Yvp/hwS7KZ4eWYgMoSl9s?=
 =?us-ascii?Q?EM5nLbdvNdihOx+vsZ9IolC36VmlzJpTDLyT3mkH8YaJ3fPfGIfR1QXjxjeT?=
 =?us-ascii?Q?8v1VkR3OGrmxCTWmYVABS/BHUaStT8xMrg0FOqG/G5bRM5irYaCqbNW7W/QP?=
 =?us-ascii?Q?KMJqWBs1YrtRk197oC1ypLI26udv14B62w2jxHhbue04nlIXXGgMoKXKf2Rq?=
 =?us-ascii?Q?PUH9G9uzIWYcp91/+cbbHjFeA6zZfrdZUrO6VajGwPH1O/bJciaQnuTcIZEB?=
 =?us-ascii?Q?aQ+S+4K8nr6rOM+ZjE1HDskL4CcZSwPLqU2O8nvf90DQ1rhbTHqXYFMueDF1?=
 =?us-ascii?Q?k6zREE68BW52Z2PCiyHRO6V2+8UR8lZ6AnzxiUjqa3tEAsk0brA0Vu+KSacT?=
 =?us-ascii?Q?QcnMkZxf7w1+/3Kx16psF7RZHkZPuRUIvGLyK70VTauicq/fCXla8BD6hCD1?=
 =?us-ascii?Q?mRJvT6W6uvzAdU7IGPhuKlQzKYVlicAsT8vx0gw3fcfMHj/gtQs0Co/cMvCv?=
 =?us-ascii?Q?xvFuvV1AzE8oR8hxCrRZAaomiNwJ9w8BQ1/8MFc/FomPeObrA/Sg42S8n+Vd?=
 =?us-ascii?Q?CfF3o2iFLiwSeM6K7L0HY3HnC6S2r4Xvx4oHNE96?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abdc6843-0fc7-4a62-952f-08ddadbf4655
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2025 16:51:59.0969
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lFWTRswwdc5lyxtOATdLTyiKDJsMC8UmNXPY4Ejf/w+koFwhb2EPlowuT5vbLW/o
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6911

On Tue, Jun 17, 2025 at 08:59:34AM +0700, Bagas Sanjaya wrote:
> On Mon, Jun 16, 2025 at 03:06:05PM -0300, Jason Gunthorpe wrote:
> > +The generic tests are intended to prove out the format functions and give
> > +clearer failures to speed finding the problems. Once those pass then the entire
>                     to speed up finding...
> > +kunit suite should be run.
> 
> Thanks.

Done

Thanks,
Jason 



