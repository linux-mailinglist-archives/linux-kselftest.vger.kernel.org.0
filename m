Return-Path: <linux-kselftest+bounces-2882-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 929CB82B8C5
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Jan 2024 01:51:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 430952847D3
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Jan 2024 00:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AC5A812;
	Fri, 12 Jan 2024 00:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Gtdi3aGa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BEF11848;
	Fri, 12 Jan 2024 00:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705020654; x=1736556654;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   in-reply-to:mime-version;
  bh=QetwigVW2wf5W5943vSyP2gmDcqUxzHatOKBz7szc3Y=;
  b=Gtdi3aGabXEFT4kQt0Q4PXreC3gjkbmfFNSXZaZQrCd6ZYqYhIVHp4nx
   MMPX7cvdLLj6ntKptca94VxLnZuNpk1f9KmobzQRCda7DlnIgEHNZEQYE
   Dek9c2xsuKhUoUGvjiGFuZbbhgSMPO0XzPRgew8j2hTMPD+Y4tVKhHhcI
   XuTq8aLuNsTUIkEpRwzaQ9G6vjOeDHq81aqgvb9CfttgqTq4diJFqIute
   24RNonq6MBvRWui9XmuFNfSSoA/c3KKXExdDnwBT1dkUAWBzT1goIjLLW
   9A1vG96L+M8Eqrta/wd59YsV6vQEt3rXSc3LSGUaHzh5sQkGK0AZ/ZzOz
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10950"; a="396193143"
X-IronPort-AV: E=Sophos;i="6.04,187,1695711600"; 
   d="scan'208";a="396193143"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2024 16:50:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10950"; a="782836483"
X-IronPort-AV: E=Sophos;i="6.04,187,1695711600"; 
   d="scan'208";a="782836483"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Jan 2024 16:50:53 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 11 Jan 2024 16:50:52 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 11 Jan 2024 16:50:52 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 11 Jan 2024 16:50:52 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 11 Jan 2024 16:50:51 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TXxxJxEpB3ji3tCXd6fsdN/fsETKjgCtza1Qtpspi8tLsJ09h0SWzIRj5cJfKp7d9NCmPe6zVKvnUtlyQUC9jGXhr7Wz5VMRBB8PYI8sG9V8LabEo7ifgQEHSFHNttlnHsZ2qT+fQT8DLCajWSYtenixDc5P+GNBkEtYyuq9JfdYGJqg2wJz9PI/p05B6TbCuerBN8YDQGcwTcKlRxcD8ct9PwauAP1pfjXS6WflnhyrRdJpLHFT6QRk3exKISCWGqOs0v65cXBEIvHidgOrXRdrHp1bqAUVIfQlmXlO3RAO6Xw04iDIIcpQUCFYgp7PmcO1VpaTLtwndxUaGyS3BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UzqsMVJpQYacC/eg2j/sO9aCQE+R16XCCFkIF0J7nFo=;
 b=RVh2OCaZOQZ4rdWqcF2pZGDJrRdyMqFvzSfaNaiiSlgvDz2Oa4VKKdCxOwYwL1GSeIdeVk3vefiaFR0tW3eKCL6yBdYg9PaeACPcpNQDkUctYgXW+IvRh5Q1FZ84eSBAuQ/sSDbf62KSGJ4FbzDOfR9wYyHD07zsAhkF6Hrb4IKo2tH4yvR6PtTOAF3V6q+nENacqXY93aa3j6HoWA1kNdfM10QDlasF//RVS4TWtlfKhVPgba7csOarEn55I2fXYlPjxv2YY+6hUm+Cab+Yr3Qw3G8JfyU0YoBgXkL/p4lAPoftNsgSkpK9AGaoRmJKJ0AVu3C1rmZ2ymAiFJreaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS7PR11MB5966.namprd11.prod.outlook.com (2603:10b6:8:71::6) by
 PH0PR11MB7564.namprd11.prod.outlook.com (2603:10b6:510:288::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.24; Fri, 12 Jan
 2024 00:50:50 +0000
Received: from DS7PR11MB5966.namprd11.prod.outlook.com
 ([fe80::32a9:54b8:4253:31d4]) by DS7PR11MB5966.namprd11.prod.outlook.com
 ([fe80::32a9:54b8:4253:31d4%4]) with mapi id 15.20.7159.026; Fri, 12 Jan 2024
 00:50:49 +0000
Date: Fri, 12 Jan 2024 08:21:29 +0800
From: Yan Zhao <yan.y.zhao@intel.com>
To: Yuan Yao <yuan.yao@linux.intel.com>
CC: <kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <pbonzini@redhat.com>,
	<seanjc@google.com>, <shuah@kernel.org>, <stevensd@chromium.org>
Subject: Re: [RFC PATCH v2 2/3] KVM: selftests: add selftest driver for KVM
 to test memory slots for MMIO BARs
Message-ID: <ZaCGCS6xY2KXubf8@yzhao56-desk.sh.intel.com>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
References: <20240103084327.19955-1-yan.y.zhao@intel.com>
 <20240103084457.20086-1-yan.y.zhao@intel.com>
 <20240104081604.ab4uurfoennzy5oj@yy-desk-7060>
 <ZZfP3/pYyPnbgL3P@yzhao56-desk.sh.intel.com>
 <20240110062708.zf3arjmha5czgpzp@yy-desk-7060>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240110062708.zf3arjmha5czgpzp@yy-desk-7060>
X-ClientProxiedBy: SG2PR01CA0178.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::34) To DS7PR11MB5966.namprd11.prod.outlook.com
 (2603:10b6:8:71::6)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB5966:EE_|PH0PR11MB7564:EE_
X-MS-Office365-Filtering-Correlation-Id: b555edb9-21c2-42fc-7f51-08dc13088537
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OACtlKQnJT41bOv+5nlgjM0Zo4jqHWnMVPRVQ4QlvRnrchSCel5p6iHUb7INJHdHw1MZxwzrrQGdGrmG2kt9CLk/r4XziYiBmnr4JVg47JC9rFGgjAxcHl8xJbDxsIjVw7zeqcqYPcqEeTfV+ZicPaF7zqZFJkILug7x0WcmaTx4LpigQ4zMYILpx+5V3BRBPqUQGxwBHSCDRuhZ7XnRohyL++cfhhI06LuU8uMKex2bMYgNekHQNPlvX56G7LOCI4z/XRy4sZMYV2C1Sz5SfBhtBaum9SelIa6ItvZ1vjqnIChrmKE4AUoP8xSMqwNCFTX4ABpWP//exduWmXwbnnsKO4QmMJoXnpEYzYFdDu/O9QyMgapNBMP2e+1SHbgCnirBtF7/XeRQG46z3v3Q1cBoyUMSyE+17TL8wcQMTgjO4QKzdrC2HLlClfsgAK2kIjTBME74wUbuhSYp9CMVL1rZQbcLWe875cc3QQ2giyXgJ7h5ZKm4Lxia82jo1/oyeFr6VepMGoc49Nlvw4LfOG5Ubg9XHAEtGsx7KmhtQk6ACikpYAOy7xCvcZyLzB53
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR11MB5966.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(346002)(39860400002)(136003)(366004)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(26005)(6512007)(83380400001)(86362001)(38100700002)(82960400001)(4744005)(4326008)(6666004)(6506007)(5660300002)(8936002)(316002)(8676002)(66476007)(41300700001)(66556008)(6916009)(2906002)(54906003)(6486002)(478600001)(66946007)(3450700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vlA9cW6ltydo8btp//STjeaXdYNVmdAjeN8fxKg8GySM55v8JUKIbggBuA2L?=
 =?us-ascii?Q?Ak8fiqSaC8rMXRsNcQyRO5REnw503KOxrsShtJyntOv/PI0w1pesgCVNDyBB?=
 =?us-ascii?Q?hP7paftITX9Tf4XOgo578gAxPyDOZc/VlnqE7e/+WcgclKiVWTN0c2EIKjPu?=
 =?us-ascii?Q?fD0yCnCfRSUgOT1OQjpHl/iEzYKwvoRoNrO9vO5NBc9Xm/4KcpJzuP/+HTE7?=
 =?us-ascii?Q?mSfliTpr0qNBYci7NHocma2zEFGtACpXwMzYglaSbmsazR/SaMP1PQhfKWXO?=
 =?us-ascii?Q?9sZFZYIUZM60ZrJ777EsvxwU7hL+ADCy4uDK65NOOmljh89zwu2FdWIPozVb?=
 =?us-ascii?Q?YAscS7j+6x7sjsuE8p6tnXeGxIj2h+BHGvOybvHj9daplsUeLBhRGhQuEEZ1?=
 =?us-ascii?Q?MBPE/SjN201j6b9rcnObpcFkhUgdHfw4js15bFyNLH2j2NqSzgnJ/QA8Wa2v?=
 =?us-ascii?Q?1pssJl9slPaN112tVGx2NVXAuHJNAa40WrDYngIDPS9v+pPm802AP5nSAFxB?=
 =?us-ascii?Q?cI2dj17uAwqYGiIBKWsOh2TUAgKbyB/kXSm1CjFqjNEwp/SZo9fBjt7h9mQc?=
 =?us-ascii?Q?JtR261KrmTT33dIJRqofKOtwneESl7bmMtygINAqcjoBiIkV7mDo7/1Ro5Wj?=
 =?us-ascii?Q?NHKOnNAG7VOGGYzRS4Xh+9SVZoa7VYcWTyoxAXcqIUpQP2DWCJKA25U9C94Q?=
 =?us-ascii?Q?rEdIbWH98qgyUl5sLAHxIS6flN+jsly4jMG45WMlMnBRYcJcnpYUMdoU1/8M?=
 =?us-ascii?Q?HjQSsARWjRrbZx+sqK7IM46NqHAgyUsXMiD0fSBemmhm3aqTqifGINL93DUR?=
 =?us-ascii?Q?SNszjbP1HM0pXITvgnxOfwn26NKQNInar4YGuDnDW5PSfuP/ZoSYUdz3Dtmo?=
 =?us-ascii?Q?DOOYTMy7vKACpUbEuenGjpYPNAPzRxnrG8JKP+s5b142B5UxPrJ5qj3HBGSZ?=
 =?us-ascii?Q?S4KCoFoP1lhmCKTV3WFs6R+usDY0xA+gz4sLqLnC/ZY85kLjIX/LKL/hLiaf?=
 =?us-ascii?Q?WtgZz9VMILC7/6Sx9FjgLggLh7dZANh9L1PgyGUhv7kBgXpma4Gtn1clxO4k?=
 =?us-ascii?Q?5ylTPVmJ+QMO9v5HK8zhVMzxVjqT9y3cvV/mM7J1AXS9JwwyZN+65wyY2ATx?=
 =?us-ascii?Q?nPRaDp9oakwv6ttRn3E9pSWDNZFYaekgCBtKhSEBOBOa/m3MWcSJK0+p3ZBL?=
 =?us-ascii?Q?X0R2Qe1c99mbO+A8Ls8RFdmjPDpLzhkaBccEvTfzIvF/Vzuioe+oRUGNV5Ei?=
 =?us-ascii?Q?6SshZvkBpogl83YIYoQvnHC1xL25CIo/C4WTW8nX2xi1Ap+ICT/ExAWwEh+l?=
 =?us-ascii?Q?w8tqervkdW2P3GKQI8K8YKo0boaikz8mJeugn8GyK8pIo/IlAgNI7UWmwVSt?=
 =?us-ascii?Q?10EP7wU6FZ4BdGA/VGAnb7Z3OJh8bnYWYsBMrHcqbyV7THWMxxMmTsQqrR6h?=
 =?us-ascii?Q?gzkiLIpejpTWVXN8056z3+WtGgaPhf7JqSlU+t7uXPD+NSf3roK90r7KKbpY?=
 =?us-ascii?Q?kZSOMGQUTTI6WYaIFlfJmzh5lTp8NaN63Xs+a/V+pCYCCPKydDGJlDdqctXM?=
 =?us-ascii?Q?z/HaaqWzjgIrNx/wydqZ9cHWqxHbQMCNkQ2wvjoU?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b555edb9-21c2-42fc-7f51-08dc13088537
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB5966.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2024 00:50:49.7046
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3z84rSleI6nlPgFfZSqD9yYdQnRtCDg8Zny+JaJcVEQxWxF32Muj19WDUA8W1F/Wh4l8M8s5EcNwQPxaINmvUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7564
X-OriginatorOrg: intel.com

On Wed, Jan 10, 2024 at 02:27:08PM +0800, Yuan Yao wrote:
> > > Do you have plan to allow user to change the bar_size via IOCTL ?
> > > If no "order" and "bar_size" can be removed.
> > >
> > Currently no. But this structure is private to the test driver.
> > What the benefit to remove the two?
> 
> It's useless so remove them makes code more easier to understand.
Just my two cents:
Keeping bar_size & order in a device structure is better than spreading
macro BAR_SIZE everywhere and the code is more scalable.

