Return-Path: <linux-kselftest+bounces-14607-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67DA6944762
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Aug 2024 11:03:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDAB01F232B8
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Aug 2024 09:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2375516EC1B;
	Thu,  1 Aug 2024 09:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Lyuw1zC8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2052.outbound.protection.outlook.com [40.107.92.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 556BB16EBF7;
	Thu,  1 Aug 2024 09:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722502924; cv=fail; b=ervGCW1/FOhdv9sP0MqcbFYAW3/nFzv01JBsHAviXBILgZKlRFNkIsWosHbM9s4zpSYpWDfj5yVBzPYWB6lFUe/9kcb5eoVBCJWrS5ZgnBI4K31rs5UNMj9iSzp45ai6tQ2kDuSrNDE3sJWaGcqyzBxPP0J146kifR9Az36WAHw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722502924; c=relaxed/simple;
	bh=A7ZW//ik4ns7n1ymnrp1nTQV/EYfxdevu/tWg5nujO0=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=brtClGX1Vo0upWkV/j/E+U1QRSxMWlfBvOY9WTHlbrBlzJDzdyQMxwz2yE6HJTz5rtDqOvF30pUG/BxFvSd1ql0cy5IH70cjzxi89scmH2AdZziJnB+9ri6gfpeb11gDcNjfoNgtv4vpaADk9oaDqhiFVBzibXdNoL66hbKSuDc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Lyuw1zC8; arc=fail smtp.client-ip=40.107.92.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CIDpWhGBMU+yBM3YE/VI4xlJHuKS5PFgYz6uxFYbZlRY00Z2XWQ+IDhi5cAQcE9uEiZvjEWHxM0+SrqafJjzl59JGpPB5xFYbdUCej1N1AayWrnVeM19iDFyUZBNcxXbUOfM3ryWlClXGgJLC7nqbF9IyW25ZP2Jy9sEZfQBxMqMIYJciyMjY+9uuF3adcNl2STm7qR7lVISQaPqa1AumlYLs4Spf4cf5iPCRJEu0koHris+6kHTJgee45MZm5frsD3Ffi5MB574QSyElIyU5t58R1XBnLLp85mAWpvvvOkwpFqr4vwCyNHyJAX3Mz4W7uYMfJtJg2daUkDg4SYyZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wOni/5QJue0yHZi2CJQh3sj9kfSa4xQyROhZaDE1Jfo=;
 b=JJVqDrhgrTxYwkJlObX76Q9EBuis6yHYaTUh8m91spOsMYy1J2xexIx9WzQ1GNESW0kb3f8XCkHs4TXoAios7mEeDMOGIij0CP8JXIuJZ1CN27y800kXC2bF/wNg8Z/lViY6FUs1HXl5vkFcdiMTI20HuqpfrUsZ5prPE7+EhwYbTNUtozCQjns35NloW2xqCGudGkCdsR9yvf8HYxYIEZ99yxcKh5kUcZLZfoKxEml0Xi7pkr9Ft6kVuHmMTuD7BMZtkrmjFkTEJ3d/nLk0bf0WT7e4ZPv/2zwwXAZRygkfW9MdZgA9501lYSz4tSNQVjK5lL8Ds/ItxevTOaZ6Vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wOni/5QJue0yHZi2CJQh3sj9kfSa4xQyROhZaDE1Jfo=;
 b=Lyuw1zC85GqC8FOzr6Be0BsCHT3dQnfPD9jWNU9Kbdak0UvZBLoWvi6gk/6e/f/OQ5wd4kjIR571nuF7hAf5ppUeDPFb9MkV1PnwiEYALe7uOeSq/ByFWr+cEfBuNLhl6zfN7fcFQvfoAIv/U3WdvDU28U6+qyJY70JWDmZQSt22c1F0Zq3PikrXPrtHEtk56H6HWdAGXTJJnzcNAc1gXdzMbMrVLP9eSO+N4tOAVeIyNhvZ2PUqWchMy1hFJ63eMG5uuoTWa80bmNm30V+9Ng6aX9561PsyjS5ki8u8Ns97ps9GZDg40E18vK4ozpW1j0d3YXFVVKjA1DVDYnFJzw==
Received: from BN9PR03CA0381.namprd03.prod.outlook.com (2603:10b6:408:f7::26)
 by CYYPR12MB8854.namprd12.prod.outlook.com (2603:10b6:930:b8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.27; Thu, 1 Aug
 2024 09:01:58 +0000
Received: from BN3PEPF0000B074.namprd04.prod.outlook.com
 (2603:10b6:408:f7:cafe::45) by BN9PR03CA0381.outlook.office365.com
 (2603:10b6:408:f7::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.22 via Frontend
 Transport; Thu, 1 Aug 2024 09:01:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN3PEPF0000B074.mail.protection.outlook.com (10.167.243.119) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7828.19 via Frontend Transport; Thu, 1 Aug 2024 09:01:58 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 1 Aug 2024
 02:01:43 -0700
Received: from fedora (10.126.230.35) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 1 Aug 2024
 02:01:39 -0700
References: <20240730223932.3432862-1-sdf@fomichev.me>
 <20240730223932.3432862-2-sdf@fomichev.me> <878qxh7mf4.fsf@nvidia.com>
 <Zqqi8LhvSn1MXu9B@mini-arch>
User-agent: mu4e 1.8.14; emacs 29.4
From: Petr Machata <petrm@nvidia.com>
To: Stanislav Fomichev <sdf@fomichev.me>
CC: Petr Machata <petrm@nvidia.com>, <netdev@vger.kernel.org>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, Joe Damato
	<jdamato@fastly.com>, <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH net-next v2 2/2] selftests: net: ksft: support marking
 tests as disruptive
Date: Thu, 1 Aug 2024 10:36:18 +0200
In-Reply-To: <Zqqi8LhvSn1MXu9B@mini-arch>
Message-ID: <87zfpw62hi.fsf@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B074:EE_|CYYPR12MB8854:EE_
X-MS-Office365-Filtering-Correlation-Id: 852dd6c6-a78e-4977-b360-08dcb208999a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?V/UCuos03BX3UlZGT5/lGutLVGm1yrmQrYrCBVbEktO3N2bNrgn5SRDSpIDE?=
 =?us-ascii?Q?at78J/vWfBwx+/GUJ8a6CifhuIDjIQm452MDYmOvovg1X9BXAx2a6ncG2ipb?=
 =?us-ascii?Q?G18g6/+xYZlvqyt4y3BgQo141LFupS55/3hap5hEYD2Wj2FGMPe0tgwhvPKJ?=
 =?us-ascii?Q?hIqgukEJvjh5lNSQGkE0g4lzJwXNcvYEvY7cULDRa3Kdc5nbYs4IbeREiIfA?=
 =?us-ascii?Q?C3cumTzl422XglLXuK0Y8qjN9aM8IPqS6/6bvObdfeBWDSHB8DQtH+awcuQk?=
 =?us-ascii?Q?wVQ0u2QEtlYc/EtJLEjJXxFGbPPCXg1TlpQxn4C1SfCL8ZQxuiVGbKGUHK+n?=
 =?us-ascii?Q?4lWuv8SdqJjzdEH6AKdN0Ezt7XNyrn+N0A2dxruR+zz5pY5eBPt8dODFKH/E?=
 =?us-ascii?Q?IQCvUioZyGefqKfUPHZ9nsl+6bkiSbHdoevV+Y2s6vMOzGfua2DiJRrGPeph?=
 =?us-ascii?Q?+EWa6+mfRHeMMafOs77GkC/oBGf2wzETAuvD5BEuo58eCtQO0RrRSMbuCNB0?=
 =?us-ascii?Q?QB+VnAb+XQf9jC+I3xbjX2Ct6M5PTg5sF9607m4woGlF+uB3hdmz4rRTvJVR?=
 =?us-ascii?Q?e12KIE8N57qv35AoFBt0RtI5pbFJv/SuhoTcwveFj3MZkavxKJwGlfCy55sy?=
 =?us-ascii?Q?ttB9eYHHvxdrV8NuV1uS1vQqK6dOuA5T62iLknNitn1HrOOGTc9xLn6hH2Gu?=
 =?us-ascii?Q?zJ8OcHM3Eqk9V23nNTifHuj4l0D1KWGhBrjPmwcvQIWgVu6WMLxgRGg3BCph?=
 =?us-ascii?Q?K2fR26NF1Hh16XY/q8o7k2vYtDOSSI2uGt/ErkInMrfuKdMU5K8iaFSICAap?=
 =?us-ascii?Q?u6DZAvs45vQtIv6at9sTFBTAp1X2o633gbh9MqiAAoEjR75xreFrIWNKUkKM?=
 =?us-ascii?Q?dgwIdJJ+JGdap36S+kqzCPfJRfVTuIgmJzJmHkPjDzsLBHeFHByIc3vDFqV2?=
 =?us-ascii?Q?D0nmlmPfDXZ8UmGUpDZziaJoyLplY5rENnDHsbcqDY6ksoankF19VYuRS1G/?=
 =?us-ascii?Q?iNwckghVLv1yA3EYVBXeC9cz5mUBYoGOHpA+6ybjvRdteQL7Tu4BQgiQ7tdA?=
 =?us-ascii?Q?SRo4TGID9vrQoPoJ/vWDn4WeFd6dbBl0HU+K6lKi19NF+y5NNk9tOZHh9yHo?=
 =?us-ascii?Q?OKAebWPuIbFU6s4j80yOxuZo4ODR5bUtHWWRuhOvP79UlDGrBB1Sf/zDA5W+?=
 =?us-ascii?Q?hVYxN1FxkW+wnFW/gn9PCvoNCug1Ea2L9ySe2UiBG2kytkbxDUq/86R1YvsK?=
 =?us-ascii?Q?XRGpa1nid+cbSEzSk9C2ViyFiqF/gtlke6yItHImCvJIO35Wxi7vkRj3Hi6D?=
 =?us-ascii?Q?W080zdJE/RA4KGetdaxnzAkBU01LqpYGxPYHu532QSLHqpYQ4Y7Du3Tzv/j2?=
 =?us-ascii?Q?BKEIBV7fuNYZkdGtu4BDSPiqxed3cYl0lHJ35nJe9KN4rBT4ojBeBwnmy92W?=
 =?us-ascii?Q?roEpYhxM1mSM/1Oe36INTF8+gPuGId2j?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2024 09:01:58.4115
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 852dd6c6-a78e-4977-b360-08dcb208999a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B074.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8854


Stanislav Fomichev <sdf@fomichev.me> writes:

> On 07/31, Petr Machata wrote:
>> 
>> Stanislav Fomichev <sdf@fomichev.me> writes:
>> 
>> > Add new @ksft_disruptive decorator to mark the tests that might
>> > be disruptive to the system. Depending on how well the previous
>> > test works in the CI we might want to disable disruptive tests
>> > by default and only let the developers run them manually.
>> >
>> > KSFT framework runs disruptive tests by default. DISRUPTIVE=False
>> > environment (or config file) can be used to disable these tests.
>> > ksft_setup should be called by the test cases that want to use
>> > new decorator (ksft_setup is only called via NetDrvEnv/NetDrvEpEnv for now).
>> 
>> Is that something that tests would want to genuinely do, manage this
>> stuff by hand? I don't really mind having the helper globally
>> accessible, but default I'd keep it inside env.py and expect others to
>> inherit appropriately.
>
> Hard to say how well it's gonna work tbh. But at least from
> what I've seen, large code bases (outside of kernel) usually
> have some way to attach metadata to the testcase to indicate
> various things. For example, this is how the timeout
> can be controlled:
>
> https://bazel.build/reference/test-encyclopedia#role-test-runner
>
> So I'd imagine we can eventually have @kstf_short/@ksft_long to
> control that using similar techniques.
>
> Regarding keeping it inside env.py: can you expand more on what
> you mean by having the default in env.py?

I'm looking into it now and I missed how this is layered. ksft.py is the
comparatively general piece of code, and env.py is something
specifically for driver testing. It makes sense for ksft_setup() to be
where it is, because not-driver tests might want to be marked disruptive
as well. It also makes sense that env.py invokes the general helper.

All is good.

>> > @@ -127,6 +129,36 @@ KSFT_RESULT_ALL = True
>> >              KSFT_RESULT = False
>> >  
>> >  
>> > +def ksft_disruptive(func):
>> > +    """
>> > +    Decorator that marks the test as disruptive (e.g. the test
>> > +    that can down the interface). Disruptive tests can be skipped
>> > +    by passing DISRUPTIVE=False environment variable.
>> > +    """
>> > +
>> > +    @functools.wraps(func)
>> > +    def wrapper(*args, **kwargs):
>> > +        if not KSFT_DISRUPTIVE:
>> > +            raise KsftSkipEx(f"marked as disruptive")
>> 
>> Since this is a skip, it will fail the overall run. But that happened
>> because the user themselves set DISRUPTIVE=0 to avoid, um, disruption to
>> the system. I think it should either be xfail, or something else
>> dedicated that conveys the idea that we didn't run the test, but that's
>> fine.
>> 
>> Using xfail for this somehow doesn't seem correct, nothing failed. Maybe
>> we need KsftOmitEx, which would basically be an xfail with a more
>> appropriate name?
>
> Are you sure skip will fail the overall run? At least looking at
> tools/testing/selftests/net/lib/py/ksft.py, both skip and xfail are
> considered KSFT_RESULT=True. Or am I looking at the wrong place?

You seem to be right about the exit code. This was discussed some time
ago, that SKIP is considered a sort of a failure. As the person running
the test you would want to go in and fix whatever configuration issue is
preventing the test from running. I'm not sure how it works in practice,
whether people look for skips in the test log explicitly or rely on exit
codes.

Maybe Jakub can chime in, since he's the one that cajoled me into
handling this whole SKIP / XFAIL business properly in bash selftests.

