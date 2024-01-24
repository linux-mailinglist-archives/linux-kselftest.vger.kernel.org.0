Return-Path: <linux-kselftest+bounces-3555-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BF7083BCDE
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Jan 2024 10:10:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F010D2903D5
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Jan 2024 09:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DAE61BC50;
	Thu, 25 Jan 2024 09:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="F4zvZWNx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2071.outbound.protection.outlook.com [40.107.94.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB2C71BC25;
	Thu, 25 Jan 2024 09:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706173589; cv=fail; b=Xnk0G4rNgoestNgRXrREodjFr24d8cfctsvqPQ2arBPXLRHoSo0VOEZ5rN022gySvrQeoBN5fwoHS5fTah31hVVjvPAK+7ieEkrUhruqaDuDG1Vpi6NPy5NhL9saz4OJwuOxO2TV10p3ESdiXsad2PIcTi/jnLEkoSRPQuvztoY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706173589; c=relaxed/simple;
	bh=2hlAnQYntbkug2Ce51mVzTlNp2T85FVikHnRhKUnHr8=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=rguFAQoe9Yssvq8eGJ6WINcidFQVono7mYGGRdPBgPqr8QPyCXyFAIejmcjDIL6aEtuDTMnAfRVatfaO6psFD4JtuaCiaYlSCQHrvLMXShkjQXaxCxuX3RQ3+WHENSHiAblVxxUHMn+yRjjdv3Txsd1EOJmLZCHR+TU4/Yulyhg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=F4zvZWNx; arc=fail smtp.client-ip=40.107.94.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QGSfAT/qxu49LFZOM+XKjaqPivBFb/YhB123JSixohh5heHzH2Ulh9RKsgQiOLAfeo+Dnf1gQkEm2JYmGPh3O+Iys2U1RkB+rXP/xNwTDr2kPMUCgNpAgfjYx92LjBUPrd2EnUADGmCxPdKH4mu/LIn23GH76wYmQUAv8cwDQ6YxJMXBg2dv18iL313XDfpy61lkBAN2tmeJLFj9cgzlnZRebO1XV2wCautv2f/4QXBCWyFJtpy8nXSJn6/hwk+3ZJcBZnJRzax9BV/l+BcHSTPkmfhHW6KHWJvJtzLOA6jyeIG4K3XfHIpRZF/vCDtZWexSzI3lvI5vmetDeJQAtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QE10+q+bPQZ4yrk7ynqUBqEEcKpIvjkHNs/ynQw5bfA=;
 b=bvphcTou3LrAc97axXLfgRvoN7KtII9pfdH4orBUM9jr4jDoIePZkFDQbX0aq6NZ5KSniRKFNSx8gWMVupXpXY1/tNNC17hQ/XVotNy5xA+MmUuAe7ALHnIhHItxESk/cm5bozuP0/vxTdkjSE06CLC2TDN0T/TYHWn1qMmYmASpTWzupjrP6XxXvda6P2BIb3AnWaTu9bTrvJqMwEL2Ab58u1MlOeqmAYAkWjt36fT0SGRXrU0CqoXj6J4+oE8o9Zh9B78PZap43cZhwe5HS9WT7pKzP2uSdCWdi//9b6As0HzBRdcxQ2xK5SfBSU0Z3bSRsRsk4PQfsRpLHuL8AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QE10+q+bPQZ4yrk7ynqUBqEEcKpIvjkHNs/ynQw5bfA=;
 b=F4zvZWNxdStL3sdiXw6p5tx6o7AtZ3Ncy8uoMZCWFhoQxNAmPGGonhSOqurlbv1IFUOszwVWmHKlH/IxqnTLSIUluESNHrRVNKjPJ2gKmXqXJl66Fwim/HKzCqYa7EnnztteTTWPyKHgzZYSv3n0fhkeKF0yuIanpVzHeZvoasnNepV7PzASSdrBSy2e2wLsYuFIL7O+SLbErymvHEkL5lKmq92Z71krQMXWgiHvszzpEj2tQzjSUz1uT6LICOYytBpsxrbbCtRXlhEhMSDScw7ysKsOjtirEjEHgwDR+1xmTzN9I58XqApume1MOndnhgY26Otcc9VScweeqs8iNw==
Received: from DM6PR13CA0024.namprd13.prod.outlook.com (2603:10b6:5:bc::37) by
 DM4PR12MB5795.namprd12.prod.outlook.com (2603:10b6:8:62::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7228.22; Thu, 25 Jan 2024 09:06:25 +0000
Received: from CY4PEPF0000E9D8.namprd05.prod.outlook.com
 (2603:10b6:5:bc:cafe::8c) by DM6PR13CA0024.outlook.office365.com
 (2603:10b6:5:bc::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.21 via Frontend
 Transport; Thu, 25 Jan 2024 09:06:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000E9D8.mail.protection.outlook.com (10.167.241.83) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7228.16 via Frontend Transport; Thu, 25 Jan 2024 09:06:24 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 25 Jan
 2024 01:06:15 -0800
Received: from yaviefel (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 25 Jan
 2024 01:06:13 -0800
References: <20240122091612.3f1a3e3d@kernel.org> <87fryonx35.fsf@nvidia.com>
 <20240123073412.063bc08e@kernel.org> <87y1cgm040.fsf@nvidia.com>
 <20240123093834.23ea172a@kernel.org>
User-agent: mu4e 1.8.11; emacs 28.3
From: Petr Machata <petrm@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: Petr Machata <petrm@nvidia.com>, Shuah Khan <shuah@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"netdev-driver-reviewers@vger.kernel.org"
	<netdev-driver-reviewers@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
Subject: Re: [ANN] net-next is OPEN
Date: Wed, 24 Jan 2024 12:06:00 +0100
In-Reply-To: <20240123093834.23ea172a@kernel.org>
Message-ID: <87ede5n5oc.fsf@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D8:EE_|DM4PR12MB5795:EE_
X-MS-Office365-Filtering-Correlation-Id: 27b9d9df-426b-4b01-60f3-08dc1d84e859
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	MO1MhCWswr0o4Td07yr4Z6nbNXg7aVXJUWXCaA9THcq9lRoC0qv2NCPwJzv9J4J5t9zqJgUpH++wulv9shey6S+UbJPzILlcs/lXjRd1I3aQfr/Xs+ADdf2D3TJkt3+VPS2VCktIj059TKFus8091wJ2QJL0m8Ysef7QcN5gDBnJFnOwz19vK2UIBLCvMH1NA1MhBvFCEqYWfJrQ0paN99kp8AumONo07YhjIax8ILlv28FmMhBnXMK/PInIvmFcPXjtseMlugQ/wYXsFzFQb8cPy3VOkuI0rC5W/nHUPzBKbBG3prtzULlYI3CCTnolhDa2Or9ihIJ0ZQ7sfHDxaKvbYFdQvXkWX+XJieQNKMzBdxsaJDwcQtds/NrhnH+hefameTubSb8+2kbg3sZgPB70K8/zG+Apv/Mmq6FASyW4Y6h2bfWtx//OEZUF9pl+Vepz9eCuqWztkkvhfsgZbMPZTjYfAk/LUToYy9RYuDRkiFp4f1VNvz88zhQyG5/WBw79t7xmxXqaqp2CSPFceQMlFIbkcu1RC2ZVQm36J5lw3YtDsBf1VV6YQwUJ20Qj0IJ7fdKcRPA3QHDpHZg9hN6+y1lW1yQTee6b96ZtmDIGu5wqPho3+jtJJJZsQl3wAlXwyhV6AEAs2I1N2TKjoc3jWMnJDGfZw9x3+mst/z7OiYocgRzbOYbCz9+plBfIYQY65DlMNKFpJwAd8H/ksme7gYeBS6QGPXg8pNxTOoTXCWSqHkEWimggN8tPqJlmLKQ6wxlztIdhrmtOUJKRGg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(376002)(346002)(136003)(39860400002)(230922051799003)(451199024)(1800799012)(186009)(82310400011)(64100799003)(36840700001)(46966006)(40470700004)(47076005)(16526019)(2616005)(426003)(26005)(82740400003)(36860700001)(8676002)(336012)(5660300002)(4326008)(8936002)(41300700001)(2906002)(478600001)(966005)(6666004)(6916009)(54906003)(316002)(70206006)(70586007)(36756003)(86362001)(356005)(7636003)(40460700003)(40480700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2024 09:06:24.9734
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 27b9d9df-426b-4b01-60f3-08dc1d84e859
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5795


Jakub Kicinski <kuba@kernel.org> writes:

> On Tue, 23 Jan 2024 18:04:19 +0100 Petr Machata wrote:
>> > Unless I'm doing it wrong and the sub-directories are supposed to
>> > inherit the parent directory's config? So net/forwarding/ should
>> > be built with net/'s config? I could not find the info in docs,
>> > does anyone know?  
>> 
>> I don't think they are, net/config defines CONFIG_VXLAN, but then the
>> vxlan tests still complain about unknown device type. Though maybe
>> there's another device type that it's missing...
>> 
>> What do I do to feed the config file to some build script to get a
>> kernel image to test? I can of course just do something like
>> cat config | xargs -n1 scripts/config -m, but I expect there's some
>> automation for it and I just can't find it.
>
> The CI script is based on virtme-ng. So it does this:
>
> # $target is net or net/forwarding or drivers/net/bonding etc.
> make mrproper
> vng -v -b -f tools/testing/selftests/$target

Actually:

# vng -v -b -f tools/testing/selftests/${target}/config

Didn't know about vng, it's way cool!
(Despite having used virtme for a long time.)

> # build the scripts
> make headers
> make -C tools/testing/selftests/$target
>
> vng -v -r arch/x86/boot/bzImage --user root
> # inside the VM
> make -C tools/testing/selftests TARGETS=$target run_tests

I'm working my way through the selftests.

> https://github.com/kuba-moo/nipa/blob/master/contest/remote/vmksft.py#L138
>
> You're right, it definitely does not "inherit" net's config when
> running forwarding/net. I can easily make it do so, but I'm not clear
>
> what the expectation from the kselftest subsystem is. Because if other
> testers (people testing stable, KernelCI etc. et.c) don't "inherit" we
> better fill in the config completely so that the tests pass for
> everyone.

Oh, gotcha, the question was not whether it does, but whether it's
supposed to. OK.

IMHO not necessarily. net/config is for net/*.sh, net/forwarding/config
for net/forwarding/*.sh. It's not a given that whatever is needed for
net/ is needed for net/forwarding/ as well.

It will also lead to simpler patches, where enabling config options in
X/ doesn't imply checking for newly useless duplicities in X's child
directories.

