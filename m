Return-Path: <linux-kselftest+bounces-7072-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 262AD896C29
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Apr 2024 12:24:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 491011C20E3B
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Apr 2024 10:24:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CAE41369A0;
	Wed,  3 Apr 2024 10:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="F3dSO+3r"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 697D2259C;
	Wed,  3 Apr 2024 10:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712139848; cv=fail; b=lfxVOxaLa9f13utMzMaxxwVMkazjZmmx6tU501zK4U4MDKcV17dVTPKAWW2phihb+biL05Sy46IK8AIO69uGbdAoajCLi5lkJlvriAHOhbhaNDaGg7/IfqXqXeItq++XMFvjuMsos8NEJdsTXcHBwcjbTY1lIxuLrqHEsavlxns=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712139848; c=relaxed/simple;
	bh=sPqzE6fQQocWV/5YUk9DfTs3wG3gEV+33NTxzCSqBJk=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=f5bM+pBRgv6zbSANIxGcrInbrgD6WZZmYxNWIGsPGLWGNcgYVGzE7DltV1Z/gpDRfikrbf3DN7412kKcsU/5ciqNPV81br144a75GhoMYAQAHjQ2p+KSORswaJ0jwG0tVnj7NUeCGJ5LZ/E3vq6tZaWhTF6rs5rJHbgDKOuJLRE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=F3dSO+3r; arc=fail smtp.client-ip=40.107.236.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TYNTDUnn1Oo8hokfzER2qEC4k6vp8yDKyoRBMKGB3whPvyWVZ8q5TDkee5UKStvHhfMTS6Y1PzwU3NEJEP0mK5satVqz9x3Re03awZL0Jb4XOHgd0mBxZA5S/XphrJUpSfgUtRXfH1YNtj+KyYCpeCTyDMGPBHgAel2/vxSUy9ThDfrUAyplkoU3ipHHCDkUJdpp2LTKf+E+NTpspYYC16Ch00CCMWRZ3w8TQsk9CEmKh0dIFRLRmoeUZlvkOItZvpLsFdfPr4YHkFoT58HUv5lzEGEgNN83UBZo4t31fiLfs3lH58wwRLnFrpjSOh+vO3KOPv2wv/whxC/svU8GeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CRXg+W+FJ/+AOmJuz7lpzQVx3lcpgTOkxV28HmFcTtM=;
 b=ABbjghZlGVjhluYp3aE+LtCD8fje6dL241BoK84s6d8jYAyNewUoX6a6izqYNuembdg6X1DLUOPw1By0QATOJJ0Dg8h01QmWMOHivWKRoMRGNL6KjmX3jyHJF5RrQ9qSVOlCub9MCt3Kw+6ce4XSizIsYcfbWHVIPhuVZ1bCZXaKQ+WtXcYO0lKQ07qEaMkPbga1TiRPOs7E4OvJcwR2Y5eKhWelPHKIE3yFbIj3r54UUExFmaypsOZ++lj60/IKwN/CefTUhi4i2espuKOjBLbV8n1s2Poc9zei9T67XwNKsqD9OEZfTy/FO2vqNOSXL7rvS2Bw3BM9YupfK31USQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CRXg+W+FJ/+AOmJuz7lpzQVx3lcpgTOkxV28HmFcTtM=;
 b=F3dSO+3rYRGXKVyDBJzv6FGuYciWVgdd+MSGzLc0v5Ol2dbCQ0+wCltnkLIVCWRA0rn1RH1yiLccTttklBjLmkrgP3RfLr2pe/ggw0fDO1TKO9n0PNMbcED/wsPp9KRu0MwAVIOcbhRUTf6Y3IjIYNHzfSyLqPsfVwrqLVNDRBV5RoixajAvo8ceO5vHsEpPB7AdUiPiqNTvmbroNQESZDvbZ0UgOiHE8Lfi9vUofaTZK15DAYTEQzyuav4xZ9K+z6qRI07PtP9Ouhgc1Z1OXtMW276ozuAv9ePGXc4UvB0jL7zEABU8G10H+sfes8/UNudiz0SL+ImqEiCYCvqvow==
Received: from CH0P223CA0008.NAMP223.PROD.OUTLOOK.COM (2603:10b6:610:116::19)
 by DM4PR12MB7720.namprd12.prod.outlook.com (2603:10b6:8:100::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Wed, 3 Apr
 2024 10:24:03 +0000
Received: from CH2PEPF0000013D.namprd02.prod.outlook.com
 (2603:10b6:610:116:cafe::61) by CH0P223CA0008.outlook.office365.com
 (2603:10b6:610:116::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46 via Frontend
 Transport; Wed, 3 Apr 2024 10:24:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH2PEPF0000013D.mail.protection.outlook.com (10.167.244.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Wed, 3 Apr 2024 10:24:03 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 3 Apr 2024
 03:23:46 -0700
Received: from yaviefel (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Wed, 3 Apr
 2024 03:23:42 -0700
References: <20240402010520.1209517-1-kuba@kernel.org>
 <20240402010520.1209517-8-kuba@kernel.org> <87bk6rit8f.fsf@nvidia.com>
 <20240402103111.7d190fb1@kernel.org> <8734s3idys.fsf@nvidia.com>
 <20240402163649.4fdc2d3b@kernel.org>
User-agent: mu4e 1.8.11; emacs 28.3
From: Petr Machata <petrm@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: Petr Machata <petrm@nvidia.com>, <davem@davemloft.net>,
	<netdev@vger.kernel.org>, <edumazet@google.com>, <pabeni@redhat.com>,
	<shuah@kernel.org>, <sdf@google.com>, <donald.hunter@gmail.com>,
	<linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH net-next 7/7] testing: net-drv: add a driver test for
 stats reporting
Date: Wed, 3 Apr 2024 10:58:19 +0200
In-Reply-To: <20240402163649.4fdc2d3b@kernel.org>
Message-ID: <87y19uhhhx.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013D:EE_|DM4PR12MB7720:EE_
X-MS-Office365-Filtering-Correlation-Id: a521082e-175e-42f6-a862-08dc53c82f83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	e5wjNMFHqI2PprYndnUtw3hyKJKM3rAU7107EYRE9VpUX95mgM4bpSaGhn1ukrQH6jZ85tihwTr8JqcR4Apbz+s4eE6R+5+Lj7matauzf6pOK+w/aSp3286lNbzWr8NTH7wIGNmwVdka6WBqvgM5WJ1pfG5IDglfCbyNOjkTe69LJH13zrM+an7utDAr7JeVCMkyMxLD2X10rrlCiIAbmYKiY7Sdgb/Rq6qdg9ub5xOSsrwVmvK0MF6xgGMjaluBN9pSStY7lcoWOxsl4f2waVl5SnOC7Tssskb5dY6J07sIHcGu/b/7LUakUEU+teWPaDXMdLlWNNAou17bpA0u6aDUSpQpQKM1fmSb7jB0HI4qs2I8u13KycFFzvOGqiJJCnCD1PeCWiskP6ZVFYHTOGXf0OZvUCgjCrEiRYP9mThQroz4uDfiTXvHMm321y07gbCo5YVC13tpbSkxPYT+2wLyGw6gDq7P4MV7lYLRKv/fhXLUQZz/onAXEWOGxzb90+GZswV238KIFd05VyGRp6Y+IZou1nUAmUtk0yJYGLul2O/Tw3VdwafpRfSguQpkDS4j/wPm5fWontocmz2Us0IKwk80Kh1eqp1JSWSU7nzcZGhk96/xEo9F2bxXGC3DSCkYARaolWTdjdtdmuAV6aoORj1gk9aj+1MwCNEDMvv5TUdC5Xj5BSxlwnavm90s+WxgIl5MVqaiuTUWU3P0Sm0wROpXuR0cdG4l9fmzvexslu9AFtvSloFy+8+zFgqs
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(82310400014)(36860700004)(1800799015)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2024 10:24:03.3927
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a521082e-175e-42f6-a862-08dc53c82f83
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000013D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7720


Jakub Kicinski <kuba@kernel.org> writes:

> On Wed, 3 Apr 2024 00:04:14 +0200 Petr Machata wrote:
>> > Yes, I was wondering about that. It must be doable, IIRC 
>> > the multi-threading API "injects" args from a tuple.
>> > I was thinking something along the lines of:
>> >
>> >     with NetDrvEnv(__file__) as cfg:
>> >         ksft_run([check_pause, check_fec, pkt_byte_sum],
>> >                  args=(cfg, ))
>> >
>> > I got lazy, let me take a closer look. Another benefit
>> > will be that once we pass in "env" / cfg - we can "register" 
>> > objects in there for auto-cleanup (in the future, current
>> > tests don't need cleanup)  
>> 
>> Yeah, though some of those should probably just be their own context
>> managers IMHO, not necessarily hooked to cfg. I'm thinking something
>> fairly general, so that the support boilerplate doesn't end up costing
>> an arm and leg:
>> 
>>     with build("ip route add 192.0.2.1/28 nexthop via 192.0.2.17",
>>                "ip route del 192.0.2.1/28"),
>>          build("ip link set dev %s master %s" % (swp1, h1),
>>                "ip link set dev %s nomaster" % swp1):
>>         le_test()
>>
>> Dunno. I guess it makes sense to have some of the common stuff
>> predefined, e.g. "with vrf() as h1". And then the stuff that's typically
>> in lib.sh's setup() and cleanup(), can be losslessly hooked up to cfg.
>
> I was thinking of something along the lines of:
>
> def test_abc(cfg):
>     cfg.build("ip route add 192.0.2.1/28 nexthop via 192.0.2.17",
>               "ip route del 192.0.2.1/28")
>     cfg.build("ip link set dev %s master %s" % (swp1, h1),
>               "ip link set dev %s nomaster" % swp1)
>
> optionally we could then also:
>
>      thing = cfg.build("ip link set dev %s master %s" % (swp1, h1),
>                        "ip link set dev %s nomaster" % swp1)
>
>      # ... some code which may raise ...
>
>      # unlink to do something else with the device
>      del thing
>      # ... more code ... 
>
> cfg may not be best here, could be cleaner to create a "test" object,
> always pass it in as the first param, and destroy it after each test.

I assume above you mean that cfg inherits the thing, but cfg lifetime
currently looks like it spreads across several test cases. ksft_run()
would need to know about it and call something to issue the postponed
cleanups between cases.

Also, it's not clear what "del thing" should do in that context, because
if cfg also keeps a reference, __del__ won't get called. There could be
a direct method, like thing.exit() or whatever, but then you need
bookkeeping so as not to clean up the second time through cfg. It's the
less straightforward way of going about it IMHO.

I know that I must sound like a broken record at this point, but look:

    with build("ip link set dev %s master %s" % (swp1, h1),
               "ip link set dev %s nomaster" % swp1) as thing:
        ... some code which may rise ...
    ... more code, interface detached, `thing' gone ...

It's just as concise, makes it very clear where the device is part of
the bridge and where not anymore, and does away with the intricacies of
lifetime management.

If lifetimes don't nest, I think it's just going to be ugly either way.
But I don't think this comes up often.

I don't really see stuff that you could just throw at cfg to keep track
of, apart from the suite configuration (i.e. topology set up). But I
suppose if it comes up, we can do something like:

    thing = cfg.retain(build(..., ...))

Or maybe have a dedicated retainer object, or whatever, it doesn't
necessarily need to be cfg itself.

>> This is what I ended up gravitating towards after writing a handful of
>> LNST tests anyway. The scoping makes it clear where the object exists,
>> lifetime is taken care of, it's all ponies rainbows basically. At least
>> as long as your object lifetimes can be cleanly nested, which admittedly
>> is not always.
>
> Should be fairly easy to support all cases - "with", "recording on
> cfg/test" and del.  Unfortunately in the two tests I came up with

Yup.

> quickly for this series cleanup is only needed for the env itself.
> It's a bit awkward to add the lifetime helpers without any users.

Yeah. I'm basically delving in this now to kinda try and steer future
expectations.

