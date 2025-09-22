Return-Path: <linux-kselftest+bounces-42069-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF222B91DC4
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Sep 2025 17:11:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A60372A5205
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Sep 2025 15:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FD4E2DECB1;
	Mon, 22 Sep 2025 15:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YERSFbBd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013064.outbound.protection.outlook.com [40.93.201.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B43712DEA68;
	Mon, 22 Sep 2025 15:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758553849; cv=fail; b=idO4HvynwXhrjC5e0p0M+4O5/rL8BOSjVIBN0i5nP/ocJdGtzry0juCSKeoaztuwVLq66YPWc7/qcQDn60XQKIYj7e1ldAPz9swS8Ba6TN0nScqYd/K5VhZgH8AxF0vRkDXBVivGxpVVOG+BP25+4KGfY1FU6Xj+aZSfkmJ2x18=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758553849; c=relaxed/simple;
	bh=nq4GLb1rnezQdC9hUrPXdl6ocxlSLMpLkfM7tPf1D7Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DvLfX2cFBzOCPLhS43R8Ea+qB2WwKjn+vQ8RvwtvRzPObjG0JNnMa6K9SLlGFvRZpuWpoyHY1aftXZGiTLRytFSUbbHnWBxSeVng/SB9VJEACFwcoUyQ8rA/XxdXBxnIaioJ5WJg18el1ksLqV5fJyiXgnqpwv6an2cEEhVmXIU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YERSFbBd; arc=fail smtp.client-ip=40.93.201.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iGw1xXdMIFHeJLilVk1b3pzGhNfKAw6nc/bgLCBpKfuX8HwDK0ZfXkWfeIO6vZ8oZG/k+aFgSvyjAN2cjGxGDtwJ5SOXvT/3alKSH8EdfUcB87PiSslD6owkX2GDq9SomgsfRCqqSm6QsZ/v3C5b9OnSElA33feIex6Sf3trvosPvYNwC21XYcsk7jHj0XyOAWa7PLdansFQPz5nMAFh8I4SKSapVvKZQG97fvkKU51hyb82emEmDF/oMr5c0ONEACGg7CRAP8x243np4FSPFfOtglKMjXQtQTKy1C3PhVrsqKatdvLhUEYGdBBRv0CXfZQMsWLrhc4n42O5EJkZQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nq4GLb1rnezQdC9hUrPXdl6ocxlSLMpLkfM7tPf1D7Q=;
 b=KLqmqF9uQVkutiKAMk6JtTz9qdKYGSp75kG/Iv9GWd6FRUo0bmkMANapwcmG7bvhsUwIzgpQZ+IzvO9N5D1Eh8O2ZLoXsNIVHZyauJJ77CuFn0ITOBNQzHBYHjqsVl7eVl/X7r4ytioQCkABDZbn5i1DLFihJkdZhZZLPzZCk29OPrsY4m2gYfdkjZLw3Cp1j/0lFsGAE2tUn9903LGtV5rZzNjI2YVrWm6TXd+2FsIw2Ytq8OScbjXa9ZzkwECdZdLqcUq5pa5qN47LRa+87NvNzVYCsV/EVRuS+WYMAlhPEI9bT1GWwisoBzB0+BNBGFztC5a8zN2wfvm5aYqYJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nq4GLb1rnezQdC9hUrPXdl6ocxlSLMpLkfM7tPf1D7Q=;
 b=YERSFbBdQRf9iEoV7cYHts7LA+Fp85ZU7Vh60kLP/RB2ToisUPqZhDGValh+dBztZnFCImG+GgEhEbmO/RT0gz2QNEuUhLSlLnnAoof3WRvSY7LzMHiuS284bnWscm5mU3fwZiBnogZ/nIkBBIFVXd+uXTs9X4Eevx5obpjaH88kQWGeHCCwuycWw+yvla9Rx2YjR9612vWgWeMksTjsId1x8ATFiXfNoQgHASpXJR1jHSO59sh2Kzk6dT4EHrIDHXG0hh2xEJQfP96LhcvSXiVSVMNhLfwh4oY9dYsPmPdtq5i08jYH6ojWINMEC6NJDUTbFGcLld5wBe9Rs2TP6Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5757.namprd12.prod.outlook.com (2603:10b6:510:1d0::13)
 by SA3PR12MB9106.namprd12.prod.outlook.com (2603:10b6:806:37e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Mon, 22 Sep
 2025 15:10:44 +0000
Received: from PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632]) by PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632%2]) with mapi id 15.20.9137.018; Mon, 22 Sep 2025
 15:10:42 +0000
Date: Mon, 22 Sep 2025 12:10:40 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Benson Leung <bleung@chromium.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
	Dawid Niedzwiecki <dawidn@google.com>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v3 0/5] platform/chrome: Fix a possible UAF via revocable
Message-ID: <20250922151040.GA2546062@nvidia.com>
References: <20250912081718.3827390-1-tzungbi@kernel.org>
 <2033c6cd-4112-4c8a-a9ef-2ab34f3504b8@kernel.org>
 <CACMJSeuKH+WKOXLNU92dMssqhK02xG3z=cT0VeXYM+ZGuPCB9g@mail.gmail.com>
 <aMQW2jUFlx7Iu9U5@tzungbi-laptop>
 <20250912132656.GC31682@pendragon.ideasonboard.com>
 <2025091209-curfew-safari-f6e0@gregkh>
 <CAMRc=MfdoB50o=3Q2p94o+f7S2Bzr=TAtWWQcDrC5Wf3Q5nqAA@mail.gmail.com>
 <20250912135916.GF31682@pendragon.ideasonboard.com>
 <2025091220-private-verse-d979@gregkh>
 <20250912142646.GI31682@pendragon.ideasonboard.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250912142646.GI31682@pendragon.ideasonboard.com>
X-ClientProxiedBy: SN7P222CA0027.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:124::30) To PH7PR12MB5757.namprd12.prod.outlook.com
 (2603:10b6:510:1d0::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5757:EE_|SA3PR12MB9106:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f98da75-d3e0-4547-9594-08ddf9ea3249
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ihxZg/AVSIw4t6/+oo8xPJOvKNGf/7A8FGCEgBX3DzLJ8GC2sxW0JWrYUSEJ?=
 =?us-ascii?Q?Q2LDFXyFhHuG1lDxqlvb5kI3siOE/tf+tNepjSbaAUi6X6QeyvcIKR0p5Q5t?=
 =?us-ascii?Q?OMXHB8gtxHIG7NZ2glRwHLu+jJkiOiHsOpJv38AbYMQT9N4Atui12ApvwuRZ?=
 =?us-ascii?Q?mTjxwyNa6wWuQUcRE0QXbzgfgxkkoLgG9HgkusH63BUEarIIoItcatjNmWNQ?=
 =?us-ascii?Q?0viZpBrvRqJhl4h1+FzprjljxNdgiNy4HH8uE6tuqiiIYL+gXou82C3dOFn2?=
 =?us-ascii?Q?A+GEFqZKjF1ri87xwpsGgnL6bVI6wi69/bKVsnAEphrCIDwqCKKwWgG24oI0?=
 =?us-ascii?Q?v/iY3/a5iDIEmu4Emm/pSiiWyuJ4HN2jrKjmdTOhTCKNCARr1jr5pq5OjWxR?=
 =?us-ascii?Q?m8OZV9s+FXoKE3mWMZzzSmkVzdEDOXgyAHvfG3L+W1WEUPEyjNmNzTcigMwx?=
 =?us-ascii?Q?RIhfgOy9xIlKtXPmIhemuVklF+uNBr28txVYtfD15HLvvawp0orNYhiASBGb?=
 =?us-ascii?Q?cRhcpYVaX5wa311tXcdkskSLUgLkjcgTuA6/xfIhYo3PhHRx1L9nq9lcG7un?=
 =?us-ascii?Q?Nlbj4dCUcbs57nD7M4qGoDCWeZSjR5k/iHh38/5us4mPeJZM01fB04wsD5wt?=
 =?us-ascii?Q?1Awjp/1nd9tnj1gmKRNJCi156RqjHHrvbd0zgvKDtxAOScd9zYywbla7T2Yh?=
 =?us-ascii?Q?mh/lGnfB8bEbJqXDQZSm5654cNP3ac29Y5Dz0g5LKEds38UDJj7Ap06HldTl?=
 =?us-ascii?Q?XZZjxiASfJGzDpfyvznwDXD9nkWXI6Mq0jc+yvQSiSV8sSVCfwvMQaKb14JZ?=
 =?us-ascii?Q?0xz8j3V5fkqI8wsXF0UB4SHmUl0/5WQAClfogp/vtn+MJ2mfNMLJs1hCMgSk?=
 =?us-ascii?Q?FuayVLO8d9yfV8CqAXNDigtD/xXIhFWf6/WvxCdgrKE4DSDigA12M/30Cld1?=
 =?us-ascii?Q?6hjzjnZgL8iJtY9Q3FL+waehzNg89ytih5TL2LVCvMieezXVrHRq7/93PXeo?=
 =?us-ascii?Q?Ws8FRZSHFHV7isApm63hzG3xQ8oYmATum7o/6R3jc7L7xqlTYe5FqBnTuUX5?=
 =?us-ascii?Q?+pgetbPR50dvqSsyvFJzXY6SoK2Ad6mGKBh8Tn2JqIbJUMQ9nt8Ng9aKksUI?=
 =?us-ascii?Q?btmwiN2JkCbBUUTNn4MQ66me8FXL14PSq5cUjs9m0Wo655mlmMyMSht2ELsT?=
 =?us-ascii?Q?W+WXO9Ar6W9gHAgF50wZR0RDWl3/Rp9nKL12lKeNzrk1TKYt95fbl2wRnx7e?=
 =?us-ascii?Q?/fXaYtSSxrnct1baIrCui21HNCjhqhUX4xD7lyXRwm+0veRNRECTrsEXDGqX?=
 =?us-ascii?Q?2aypOzEeOvQ2Rlt+YhtD0/Z0TNviJtebir6oceqrW/ajuMp4gSuUu8P/ZWri?=
 =?us-ascii?Q?WlS3WCuXZrydGI/GSp7hLKJ4FlFbdUd8CCguBDnAVX80mDCgeakb3UzbSF6S?=
 =?us-ascii?Q?R+DyPJBqk/o=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5757.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lmkMEL3qKkql+gcdz8QL+Jy5gX59UNkUtIoqn+DgCMBHEhUnSl9Gv4n1NXDo?=
 =?us-ascii?Q?Bl8nuB9OHNHwz9lu6jJB3fMkdPalu7eRqHUnqMiAxpY6wqCp/9j6ffWZdGr2?=
 =?us-ascii?Q?EtvCxCPS3+PvYnPIsMVf39K6Kwf12tAicblAqOjP0jzw2+7+geNUUMkH6QPX?=
 =?us-ascii?Q?7LOPfFOT65GL1myrQGtUOoOwxaxdz3a0hbhE/zT6N59bO6gktRu1Bbw90LzU?=
 =?us-ascii?Q?gcoSV8yETTI+9+9HffI8bFK4aUybBqc5WtdPI5Kn6/EAWmipXSYTzcyArn/o?=
 =?us-ascii?Q?m3p9IlEkQ5rROPOnCuMKpvzhtgS92RkDNnjTeHNm6B4BAjgSxOHmt8kE8YHo?=
 =?us-ascii?Q?c2Ynko/8niNGpp08T/n83OfdMRJFgoA05FT7xADJdU+C9770WmACN+40A76P?=
 =?us-ascii?Q?zXuurWj2sKztHLByIMo4NqigS6jQJ+zq+jGc99PtXiFPn+SyaYcpJZfzwmxC?=
 =?us-ascii?Q?gvMWijvkwTrkjf9TzYnslMdHjY2StXh9tjkPspCzyD58bJ5gAXTVsJTAYMbe?=
 =?us-ascii?Q?w4vrRCavOBWgm1JS+jF2O8kndWyMDnUlPr+5wmM1UpYt/HgI3pBrg5OwO7hy?=
 =?us-ascii?Q?a6JyHr8IF49hgbKL35ByVrdsaETovIiYAMTRfcByYREWW8Z38xJbd8tbnyA2?=
 =?us-ascii?Q?f69+vl070oCUGxIAIUZ9u96HYkglLq6aXOZQFosmwwxT/FRzz+8SdSaixdEb?=
 =?us-ascii?Q?yEc3k4UoICygBllRYtHWLKMBrjnW2O4MYed92bc5FyRbqFi3il61LvAlXVzm?=
 =?us-ascii?Q?e86IMOWRUuPKvH3qW2zZlMQWNkUMyiy6n0jVH+GAaBzPPDjmSZqSd8ipsnxi?=
 =?us-ascii?Q?+0YGM9wtCeLRaX89i23KumTWbqxju/CAZozpzXg6aR3G2EM6iXg6dy2oQoke?=
 =?us-ascii?Q?T8sf/1vw+whJeKfvx2Z6q9FRWpmtHWwc3laIRlViCVRlKF3a3JPUv2AJXBR6?=
 =?us-ascii?Q?QZ1d73tSi6qkkH3AeRvKNWNuAT4uGWg15MCCxWbDfqRmYRgEOXi5sCiVF52Y?=
 =?us-ascii?Q?lo58nIuuYy3cDuvC8KVMNeBCS9sNjFBZEP6TBJqfM2N3DyT/78Ugyj0bjUj8?=
 =?us-ascii?Q?Sr110ismngZ9sHSPRr8Q+aHPculLzrFP8OCMZ43lLNOCHlP9jpRa7ElwCL94?=
 =?us-ascii?Q?sGZKHWZ+0ytJTB5AhXxfXjVlKcIg7MQpfAlJ6xW1nUgAJqrriG88z55FKwyU?=
 =?us-ascii?Q?Z3OxK/TZb6eJiDnKir7uZPJCGFk3w8L7CDvT5y+3FNdc9BRdwnlRnzIpFHVa?=
 =?us-ascii?Q?sjh5Q0LfhNZcqw/9qm9bT/rVimWLjO8Etm01+KGgOV6u2XihbUfmvf/Uq1PS?=
 =?us-ascii?Q?exO4jYXlM5kz8wwYzOfy4IxZzSFkPTCmfK2RaCvtbf1ik0FtcOn0WTPjfgzf?=
 =?us-ascii?Q?cRcWMSP1ppypr+eMtKfIDPiCx5GlcBdyiupSWU7ArgFr9ph2b/aBSNeJl1Mi?=
 =?us-ascii?Q?8zgOZSiP/Y+ikWrlr+x9YhRT+gysZb9PR1HX2F2TSmcDEc5VDB8GcD6wrn7a?=
 =?us-ascii?Q?QsUtUjtLq6lSmREnGF5VDBVv4UsQMm1dY3tUbNQQ1bX+Rj28Leqpp/qjfFsg?=
 =?us-ascii?Q?UShzFYlX25X6DGjpwNquv5K8keT8aD1bLCq7ABru?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f98da75-d3e0-4547-9594-08ddf9ea3249
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5757.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2025 15:10:41.9910
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WOVha/mA2z1nx2h+yKYvWc9pnl72iR90PYL5a0fOhutq0qQptfoLQznGk02si/Hy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9106

On Fri, Sep 12, 2025 at 05:26:46PM +0300, Laurent Pinchart wrote:
> Not quite, I would like to see the enter/exit (aka revocable scope if my
> understanding is correct) being pushed to char_dev.c, as Dan did in [1].
> I'm fine having to add an extra function call in the .remove() path of
> drivers, but I'm not fine with having to mark revocable sections
> manually in drivers. That part belongs to cdev.

+1 I've open coded something here many times.

The implementation challenge is performance..

The big ask would be to make file_operations replaceable without
races. I can't see a way to do that at the struct file level without
slowing down everything.

Dan's idea to provide a wrapper file_operations that then effectively
calls another set of file_operations under a synchornization is more
reasonable, but the performance cost is now a percpu ref and another
indirect function call for every file operation. It also relies on the
inode which some cdev users end up replacing.

Open coding the lock in the subsystems avoids the indirect function
call, flexible inode, and subsystems can choose their locking
preference (rwsem, srcu, percpu).

As was said later in this thread, it would be a real shame to see
people implement revocable in drivers instead of rely on subsystems to
have sane unregistration semantics where the subsystem guarentees that
no driver callbacks are running after unregister. You never need
driver revocable in a world like that.

Jason

