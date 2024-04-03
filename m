Return-Path: <linux-kselftest+bounces-7109-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2938E8975FF
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Apr 2024 19:11:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4352282238
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Apr 2024 17:11:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31794152519;
	Wed,  3 Apr 2024 17:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KQs7uIFM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2074.outbound.protection.outlook.com [40.107.220.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7397A152506;
	Wed,  3 Apr 2024 17:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712164265; cv=fail; b=B7WkpKyiVt+WX2n3eCZ7NbzwkDaC1F1XSYpf+ozUu/XtI7ksnWLDEu25rbQgfbNDHCYLe63JzMObxT6rBjhhi6syfcS32Dd3FyG1m4Fn2xchL/OjI3w4II61ycgaF7J0suz+3rWcZK+qLXKLXbs0H7oXleigTJT7ZLkpPcwi/aQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712164265; c=relaxed/simple;
	bh=5IWlBvI6ZNVu7Y/K8W7ArbnOjS2NWSEvVOz90rv0obg=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=uD8PDxKJqvSBq9MbtZpXAPvX8Wc/ipYgdD8WDU9CreU4tdSiRTtbmU+DF7ZF5QBcXOLxitFQAhtoLaaqRvIaXLjivAkvoh4g+2hj7tGtbEVWx0ITS8v2N3VsRZmFea6jVe7WOv3jBbG+bbCss8tbvf42llRawo0kVwXNIV6tqaw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KQs7uIFM; arc=fail smtp.client-ip=40.107.220.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PSKNkj5lPB0fHrSOam0t06CLngeMnN54J/4xOGCMgxYn4BUL+DtEPF6WK+O1cZW6ZDTa9ximS6rI/dSQ+evXzSFS3tzobi+w+An8yLkhJz9lLqEnnuO1NGtbi27BwObrNtGvSgGCpoRiBHC+QiQGVUINWVL6RGp2+EiHrcMFqmsqQ9Gk0YE9R7LnbwTRULGBCahyX5VXDcqYKEN7v5Q12zw5cC1243Stf2Y9yk/OPWs+uQu4KISGvRBwhS1yje0/mx3HooySEow8o1yBZuu0TtvSFGy7dbG3IESocjLnmDx/9A6FwDvgbLDaOfZvt28UU0aTkPVKc24nYab9e1yONg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rS7pSqlP5c9ssV6gIAA1Z/R9ayWSMktu58NJpybRZJY=;
 b=YO3gKkVTn/x+AizgNfyMgzuBE+WKhTCS673ngMoWeidfSKBXbfigiEvNCeUZfR2imBedmWho9Hm5pWxec2djtr6Pb/u9+ctRiVmhkDTktb8AjyuFdFyqzc0iIl5SDvV1H4LcQjWqii+LSBTiZB6RRNuKCNcqoHcQ1eYEF0J6+kJ9WkdnBJQeoW3qloGYREC8uJAOVt12tvLFwCyihPlp1MP9QM8Iz3ypk4v61+1gP7Z0tAIqR9Z100IOokUs7yZag7AKrJNAeE9NiLWMKVnjl+X+Qc9nB/hzw/dQAbQjkSlWc58xQ4ow7h6a6JVhoDMTBsNry6Zy51a7qofjS7ji8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rS7pSqlP5c9ssV6gIAA1Z/R9ayWSMktu58NJpybRZJY=;
 b=KQs7uIFMXLcr0JE3Jjc2zz+5cRiZqBg245U9QLk5FHIUdYAAZGj2JVYShC7HO4BZVSTBuFGG2Pclgv7/WdpygKyStrFh9/nS6xBt+xVG/GiitqQkM7HGD65qeMoCUKAqZUFt59aUiodz61CDBCqpQjUhhdP19RdoC+9JFZxlxttI+eMbPkNijLGN6WUkKjzqHeJfzqN199G6V6e9+YhS4LObDMeiSF+bXuH+3FMLyKFEbCPtCL1GRKA3vsVBz7+K3ajTnsj+RaVjwcxFMXMB2cBkXjOONtMUGv03sPp7IUbQRwfDi+jpItFss5CgLzCWBXj3wYXTmAKLqVUehBiERw==
Received: from SN6PR01CA0019.prod.exchangelabs.com (2603:10b6:805:b6::32) by
 IA1PR12MB6436.namprd12.prod.outlook.com (2603:10b6:208:3ac::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Wed, 3 Apr
 2024 17:10:59 +0000
Received: from SA2PEPF00001505.namprd04.prod.outlook.com
 (2603:10b6:805:b6:cafe::fe) by SN6PR01CA0019.outlook.office365.com
 (2603:10b6:805:b6::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46 via Frontend
 Transport; Wed, 3 Apr 2024 17:10:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF00001505.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Wed, 3 Apr 2024 17:10:58 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 3 Apr 2024
 10:10:32 -0700
Received: from yaviefel (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Wed, 3 Apr
 2024 10:10:28 -0700
References: <20240402010520.1209517-1-kuba@kernel.org>
 <20240402010520.1209517-8-kuba@kernel.org> <87bk6rit8f.fsf@nvidia.com>
 <20240402103111.7d190fb1@kernel.org> <8734s3idys.fsf@nvidia.com>
 <20240402163649.4fdc2d3b@kernel.org> <87y19uhhhx.fsf@nvidia.com>
 <20240403065532.1f2a072d@kernel.org>
User-agent: mu4e 1.8.11; emacs 28.3
From: Petr Machata <petrm@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: Petr Machata <petrm@nvidia.com>, <davem@davemloft.net>,
	<netdev@vger.kernel.org>, <edumazet@google.com>, <pabeni@redhat.com>,
	<shuah@kernel.org>, <sdf@google.com>, <donald.hunter@gmail.com>,
	<linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH net-next 7/7] testing: net-drv: add a driver test for
 stats reporting
Date: Wed, 3 Apr 2024 18:52:50 +0200
In-Reply-To: <20240403065532.1f2a072d@kernel.org>
Message-ID: <87ttkigynz.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001505:EE_|IA1PR12MB6436:EE_
X-MS-Office365-Filtering-Correlation-Id: 8dad3595-aaa8-4962-9e4b-08dc54010832
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	90Vb/erYaV/T8w8ZVV4MYpaNapNP3DQp3ol6aznG83OARnN4LneupFnAuj+522nFtdUwxX53fhZNrSp39H0zJNoIixYZc/OXq2bWtZOB2dDWUwBH1Ofvnh9WxB04KKg122FYM4dH7Yx0mF6pqWQR5DyYp2LUy0IlW0+fYrH50Xb6F4ZbXppJKquXemGrBwZxumY39+VT7dJR8Zwcp+jdQ4LHz6s1KGp116f+mlFXEn60tdzt8+OOtr8WDGhRTLkeK8BO6kaGZ3WVVzwom2a+LwFRn4npcTloGG25a+E/68j4VWfPVyfINBmAFUy27/42FvqmCQLhFz9L2wSqOMezlonhhmo7v++fiw31a8KVaIPmikjcAHDEoUgEDP5zCgpQQnVfBbHzPeXKD2AWHKnB649V8BnxH7V8t7XmLbsiMG50/vffTm19vxkfkzTm5njOTwSEye5y6TWNif9PVy+CbTidvkCbEoIj8EkQjHP3o6+p3fyJiFMVNF+j4NcH6qjWCBaztEJ6frfu4t9Uu+csR4X8+rP27UtUkzjzXZpG+whwtIUxLQ+Hih9YHbD0piemnO2RB8MXO8yF6NQ9r0oWUWO47ap/QwoWAPLs3w3A/7m5DiJYrPVp95RA2iqDzhmlVpqFdJPam2VUwVgAIQDfarWi0qYOFXYp8OwzcQ2xYVqkVwTNiR/k8L2YpXCyP6PfNXEN+7vwzxfGsCwsVDjxeTX5u0/mcuInFoGQszEsajKNSl57/pqsv74fVC/LuRsU
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(1800799015)(82310400014)(376005)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2024 17:10:58.6815
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dad3595-aaa8-4962-9e4b-08dc54010832
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001505.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6436


Jakub Kicinski <kuba@kernel.org> writes:

> On Wed, 3 Apr 2024 10:58:19 +0200 Petr Machata wrote:
>> Also, it's not clear what "del thing" should do in that context, because
>> if cfg also keeps a reference, __del__ won't get called. There could be
>> a direct method, like thing.exit() or whatever, but then you need
>> bookkeeping so as not to clean up the second time through cfg. It's the
>> less straightforward way of going about it IMHO.
>
> I see, having read up on what del actually does - "del thing" would
> indeed not work here.
>
>> I know that I must sound like a broken record at this point, but look:
>> 
>>     with build("ip link set dev %s master %s" % (swp1, h1),
>>                "ip link set dev %s nomaster" % swp1) as thing:
>>         ... some code which may rise ...
>>     ... more code, interface detached, `thing' gone ...
>> 
>> It's just as concise, makes it very clear where the device is part of
>> the bridge and where not anymore, and does away with the intricacies of
>> lifetime management.
>
> My experience [1] is that with "with" we often end up writing tests
> like this:
>
> 	def test():
> 		with a() as bunch,
> 		     of() as things:
> 			... entire body of the test indented ...
>
> [1] https://github.com/kuba-moo/linux/blob/psp/tools/net/ynl/psp.py

Yeah, that does end up happening. I think there are a couple places
where you could have folded several withs in one, but it is going to be
indented, yeah.

But you end up indenting for try: finally: to make the del work reliably
anyway, so it's kinda lose/lose in that regard.

> Nothing wrong with that. I guess the question in my mind is whether
> we're aiming for making the tests "pythonic" (in which case "with"
> definitely wins), or more of a "bash with classes" style trying to
> avoid any constructs people may have to google. I'm on the fence on
> that one, as the del example proves my python expertise is not high.
> OTOH people who prefer bash will continue to write bash tests,
> so maybe we don't have to worry about non-experts too much. Dunno.

What I'm saying is, bash is currently a bit of a mess when it comes to
cleanups. It's hard to get right, annoying to review, and sometimes
individual cases add state that they don't unwind in cleanup() but only
later in the function, so when you C-c half-way through such case, stuff
stays behind.

Python has tools to just magic all this away.

