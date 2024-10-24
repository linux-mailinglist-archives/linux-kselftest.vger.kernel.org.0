Return-Path: <linux-kselftest+bounces-20531-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B73249AE244
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Oct 2024 12:15:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D850281CB9
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Oct 2024 10:15:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D8411B983F;
	Thu, 24 Oct 2024 10:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WwETPjBJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2084.outbound.protection.outlook.com [40.107.102.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E992316FF4E;
	Thu, 24 Oct 2024 10:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729764946; cv=fail; b=bxnqdCacbFA0hm1ONXEbGSrkCPpyFys7TU883FRf/2r5YLcKztFBsr/sJXmmieCca84zgvHgO742t3v1J5LImN4pduB2XBm2d5l6JbY80xqx4NLaJm7Ac5esnzgABpa+Lyn20EAM7wAjBaETxV2y04r0ARHF+cRCdLzPWDiMACE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729764946; c=relaxed/simple;
	bh=ypWkZGejMSc5hdseMiTX0kRJ9Hr8HGF5uK5IqwHBWjg=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=I1c/llnJy+sNZ6w4shRNx4UQF6O5U1TymA4kAEL2k5EgSw8M0OC5nkFGVvvlzZc0ZZvVlEuiv0J54BjSg9bnfReELmwT/nonBWWVfqo0nExMSllH0iytq8Bkd9fVefzyIyQ3hcwxmAUWUDaOaduv9Gdj61zU72zcLPhj1fz1Zfw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WwETPjBJ; arc=fail smtp.client-ip=40.107.102.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v7SH5XM58e7JpdWRKsGH8b28TjU7cwmtda97JG1OCInrnwjGwpoW//lefQ1K/ejMTpEzIUAKzi3B5ue+hkXAXg59SUfBWmAyM1QVR9aFJixKkSchv20a5w6XcemmtdCLRtvMLnS1q6KctfKQZASA48sBVYU4wwH2gkNL1IjMCSdzF7rPSK2SpsDCZ/GvjteKhHovqHJPbO45oAjasx+enwKP2sB2ZeBV1PL6QOTM6bP+lo3c9lhnfwzF4ktRsRBfTfSlmGoheY2hi2Xji2jY7lS2win4HSrTTtkIVRlgbAmEl6m47EK0SeK213lHBwQfBW8RWA73rvTXGOmq33ek9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ypWkZGejMSc5hdseMiTX0kRJ9Hr8HGF5uK5IqwHBWjg=;
 b=yY/am99ABlQfo1uI5e+szZ1mvafQkYX6tt+rndkEun/b5jUcuIGe+bjryGuH86uDzO/+7PX8v0du//m0XDT/0qx4U/2yYuxL70ejkQx/62p23pnoJ4mZipJILiaWy+BL4czgkN6CpPYnX2f/qNp9MomL/shTs9CaDLWbixCLiVkoSvaBNtSwBexYMJQcaEnXN1ZcnPynDOwn7DGUm4pR/YmJTWhHCL1EvH77klciozKvX+7tg46uP/jAKwLIQyafZR3Y3qiazrX3bfUoEQYrknoxVXOCITFyrOE7yAxMt8ZuP4f8XcN5BW+4Cnd7dq7wqT9t3Dki9sVZFkASnO9tBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=resnulli.us smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ypWkZGejMSc5hdseMiTX0kRJ9Hr8HGF5uK5IqwHBWjg=;
 b=WwETPjBJsYISr/hiyPm7zcfBMMGUsaNs5f6qZPmrUW4E12rjMPn5WrdGN99t0Zrshz62WNkk8DYE3DLaOuvvsmFx9ri5QFAJP2UtX89atyfZkOh+mIh+JXZ0TUwx8PMPvhYCqNpi9zfkLmV8PQpTYXpwHe5ONzG7g9rdAD9Azwj4GLkCS+8vHwf/s1RCilO+jMERW3UlUtNrIGTOoi7DNyrzqdQG3CRSg9Ku/H78/x34O0tlc60BMttv0hVR2RVbOTUsbKwU6r2RltTC1/Q+o0ud/8lmqwR9II7z1drYsYYBRP+AdbKviY7SYww/kmLSMG0b96WL55KLZRY8Tr2DXw==
Received: from DS7PR03CA0292.namprd03.prod.outlook.com (2603:10b6:5:3ad::27)
 by IA1PR12MB6257.namprd12.prod.outlook.com (2603:10b6:208:3e7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.29; Thu, 24 Oct
 2024 10:15:40 +0000
Received: from DS3PEPF0000C37E.namprd04.prod.outlook.com
 (2603:10b6:5:3ad:cafe::85) by DS7PR03CA0292.outlook.office365.com
 (2603:10b6:5:3ad::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.17 via Frontend
 Transport; Thu, 24 Oct 2024 10:15:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS3PEPF0000C37E.mail.protection.outlook.com (10.167.23.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.14 via Frontend Transport; Thu, 24 Oct 2024 10:15:39 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 24 Oct
 2024 03:15:27 -0700
Received: from fedora (10.126.230.35) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 24 Oct
 2024 03:15:21 -0700
References: <cover.1729607879.git.petrm@nvidia.com>
 <4421094dd36be3714eeea70d577ff761454de3b3.1729607879.git.petrm@nvidia.com>
 <477cac2e-606d-4c78-ba5e-ce7e594bb6f5@linuxfoundation.org>
User-agent: mu4e 1.8.14; emacs 29.4
From: Petr Machata <petrm@nvidia.com>
To: Shuah Khan <skhan@linuxfoundation.org>
CC: Petr Machata <petrm@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, <netdev@vger.kernel.org>, Ido Schimmel
	<idosch@nvidia.com>, Amit Cohen <amcohen@nvidia.com>, Vladimir Oltean
	<vladimir.oltean@nxp.com>, <mlxsw@nvidia.com>, Shuah Khan <shuah@kernel.org>,
	Benjamin Poirier <bpoirier@nvidia.com>, Hangbin Liu <liuhangbin@gmail.com>,
	<linux-kselftest@vger.kernel.org>, Jiri Pirko <jiri@resnulli.us>
Subject: Re: [PATCH net-next 4/8] selftests: net: lib: Move logging from
 forwarding/lib.sh here
Date: Thu, 24 Oct 2024 12:06:37 +0200
In-Reply-To: <477cac2e-606d-4c78-ba5e-ce7e594bb6f5@linuxfoundation.org>
Message-ID: <87bjz9iz7u.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37E:EE_|IA1PR12MB6257:EE_
X-MS-Office365-Filtering-Correlation-Id: bef5a477-fa5a-4f80-ef21-08dcf414cf6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7J+ZsBvdVCgOgWyxy2frBkTK9pupixi2FeOTbp/B6DdPgvLVr6hSAFs4QKwv?=
 =?us-ascii?Q?7ffYhrZbG4PpDBqrVNHlWBUvBlBc6hGdmTCe3oBzT+xty34u82MmWwBJitqk?=
 =?us-ascii?Q?yQnx8/NIkwNYRke2GmfGN6MdUNCBy8q4fBQYe5QjozeQIAj2Z09wrTzKW8uP?=
 =?us-ascii?Q?lmjUBzD04V0QzRNos4zKd/9F03nqxBb+wlnPFFSFlWAUl1F69/+HgZktSIuV?=
 =?us-ascii?Q?gCxwQJ7+R/0VYrEUai3gOoQfwya6kpzVJsshf78yQD/2RjRKyafNwdVifvAF?=
 =?us-ascii?Q?Zdg4egTpjKtXTSZEhfr141HygrfFi6+eIjjt6uZ2ucOh4x73jE5fAIGejwvW?=
 =?us-ascii?Q?+XHlcKLUoiwAnNXnbyGiQE+FILzwfS+EDU+wmqS9qUtfNO4+OYyyd6+C/aPd?=
 =?us-ascii?Q?8GEKOu03JLG/HJWdg5ae0zvAsMiBkkjhIXvZNXH/46cXhffTvCRhbjOy3ZOI?=
 =?us-ascii?Q?ThOf7y76We/jXs6PEwtOuxXjCKYyD1cCRFTyevysO9KuruEq5ykaelWHsOix?=
 =?us-ascii?Q?jLxk9GhxqvxvK8KHLkkfaNcM44tZdLPosfHqy62H6ReuoTvWA2iz1tHdqVAA?=
 =?us-ascii?Q?54N4wcu8PPLFiQWPt8EITEQwcAxG1bcxRu/3TnW/ydXvKJRoZOGLLLSxZvQC?=
 =?us-ascii?Q?NR4YBq0gmK8UlHeWChM6two0i57A2g4Tu5114J16OFSQB3w2wHz+8BPlBDcq?=
 =?us-ascii?Q?zhCVHiKYDDecWhoU1+/LzidagUXjFF61ryob+BG3ZPMF94sybJq6TpVQ9kw+?=
 =?us-ascii?Q?oJT+kM8/Lf494fHNK1O9fuWDE09LM2NjCzxPtHqTOIWw/+M7xtubyjFY9IJq?=
 =?us-ascii?Q?73Mc1j5xWiGHRucny37C0X83aKEL5c/o4FujAL/KDBWSQS/hUVLFAR8a2T+R?=
 =?us-ascii?Q?dnAT3DxXuIZqQITHI5565gok5R+JTnVnbJ7zvql6atLKusVeaV/OIB5ZUrug?=
 =?us-ascii?Q?MHDNWF8ExKsTaqD86MdI/i1jvj1KhwEwbQiCJcag3nlR4DLDw/7+jfZWzIHR?=
 =?us-ascii?Q?fUPwf1pzDE6zoyxbDzoXkV/17+V+uxPQ2XwT+ci+wjWIZmp3GU2GJbAGrp7m?=
 =?us-ascii?Q?T7WvmJnWqoj/eaF50qXV9K85CIn2CKO7Tir8pw8ngFyCjnOd5JjeRdCb+ptw?=
 =?us-ascii?Q?eYP4CU/5KrX4+MJB9sf/m4/GZVKL/fU257XocZ9phZx6Rr7htFEDLisq5mNh?=
 =?us-ascii?Q?Y2pOUeFhTH70kyA8Gn4EVqqWg4tcQxhIorW1R5G1txHg8Pr8R9NxDx9hBOe9?=
 =?us-ascii?Q?SsOJIP8eCIYafE8akmYuh4c09fWgThJhusty/l1GFwW87CMZRMXtkDjOXxN1?=
 =?us-ascii?Q?3xBnY+OqDe08WIjRVmH1mXyoYAE9asWVsjyHcoUy+Wb+I8LxPhM/eK+YVYu+?=
 =?us-ascii?Q?MdNKZvyWo+1p9eTy8Y08W2gfr9Jqr/2swyUTphXq0sUgVLERHg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2024 10:15:39.4463
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bef5a477-fa5a-4f80-ef21-08dcf414cf6a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C37E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6257


Shuah Khan <skhan@linuxfoundation.org> writes:

> On 10/22/24 08:50, Petr Machata wrote:
>> Many net selftests invent their own logging helpers. These really should be
>> in a library sourced by these tests. Currently forwarding/lib.sh has a
>> suite of perfectly fine logging helpers, but sourcing a forwarding/ library
>> from a higher-level directory smells of layering violation. In this patch,
>> move the logging helpers to net/lib.sh so that every net test can use them.
>> Together with the logging helpers, it's also necessary to move
>> pause_on_fail(), and EXIT_STATUS and RET.
>> Existing lib.sh users might be using these same names for their functions
>> or variables. However lib.sh is always sourced near the top of the
>> file (checked), and whatever new definitions will simply override the ones
>> provided by lib.sh.
>
> I like the direction to leverage and make logging functions
> common. It make sense to use prefix to clearly indicate
> that they are common and to namespace conflicts in the future.

Yeah, for newly added logical blocks we should probably do something
like the defer patchset did, where the module is introduced as a
separate small library with clear namespacing and marking of what is
internal and what is public. But there are years of baggage in bash
selftests at this point, so the changes can't quite be very dramatic,
because any changes risk invalidating a test.

