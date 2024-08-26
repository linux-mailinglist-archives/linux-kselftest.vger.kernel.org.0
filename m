Return-Path: <linux-kselftest+bounces-16311-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 456CD95F60A
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Aug 2024 18:07:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB21F1F2169F
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Aug 2024 16:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7697C191F74;
	Mon, 26 Aug 2024 16:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Y0mUDhf5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2048.outbound.protection.outlook.com [40.107.101.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA92B3399B;
	Mon, 26 Aug 2024 16:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724688429; cv=fail; b=YVx9F4Mw6oLzdLDt/07V2MD+eViCmDq15bHpyHqPf1EetIBtqpOF3xW5E5nchBVsAEFpzpVmu+HVQrTZ/+HTQQnnA72k7r0IED4VnKFLYtQs9xdBghzlTFh7A9w3MQtUazUVQqYoXEEJMX0tdDO1OKFMuGxZ1Jdz8qOpUtVSWBg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724688429; c=relaxed/simple;
	bh=ZCR8k1S2TGXDakDBbg6Uh9/pORI84uk8oG3duSYiBHM=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=XN7RnfFUrwe9Ch7/dkjp2rn4fQ3UoAzEvubmVZ90Yo6JfEHh5AOp5vIw4Ugw464jchcUZQlfrMbnSt2N6+TWuqTPms0qC9gTvxYSEIBjj77mRKwh2cGBXbjXYZOe4Au24snN4vDZp2zjdq1SNz4T+RHuxli4AjSTzMXoyLIJSPU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Y0mUDhf5; arc=fail smtp.client-ip=40.107.101.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D2wqU1efnBvF1bRvoeOw+FZNeAVHZVpiKFau/zmH4x5zA5xRLuIG3D4Y/7PEfc3hPOZmuryBi1be2F3qwNPjUWQqtQ6DsAd6WK6886zLXNtPFKC69siJstETp/HL+GpYMJWdYJrwBs/euu6eXkZmx1Qn9/25OVAyrNG5C8B/nkssNCcS7bNtuwie6IUvx3doL9U8yWK8zYMRwfgtmuoDSW7xJvsVfJmJWUtGcM+vVdNclHfH85CtednVOagzVeRe+qNBbdyNogE9XPr8N6QWSyo6SEJYGGkhDO+VuVIGw2DelW9MVt6+PTz/5d/zCyU2MlvV4Ww7jbV1xS7ojCP13Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mTdvJ/NgLdew1NjWW4mGb1baRIHkj6UIDNkBkWEie60=;
 b=iLO567YUxNq/cYzYyDJgHHuqbDG41vsUQPTVc0BcrH+Nh9AYYn/TaGcqnF5hpsevXphzK+oVuPQ7xCoU3QEBh+fpUAPDmhgk/IDWCGTxy8ldtR6naJ6J9K/gFPca7gwgsJ4CzfsCzG800Y/LvWnkRyrocL/3knpc+6ZhNHL0lDklixCDUKneQE72c/uFtONI2l1A/u+8zCiz+Ww7XkW656Z7Ka2V+y1AjlSAhvDNdYa8PoN50BYe+iyTRUzUJBgRLrWNdQK3S5lTCzwNYwbdz6+mjhhywqdYapnGi9nf6xkShPM6vm6BimaOgOp6T+OIuvsGM3xoHgcOlC0Ug7eljw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nxp.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mTdvJ/NgLdew1NjWW4mGb1baRIHkj6UIDNkBkWEie60=;
 b=Y0mUDhf5xCvU5svVbq7ccQ5ixqFfE+6mbdvXYZBis4RQMITgo/52Op7rgDijsK1FT8gF9SO0nBUCzQWhMU1VE9ZL2kxbbDjjOm1EW0/rQBOlOYEgFEr2dl2ym6iUE/KXHZ2EEPFivoicjY/YT4kYxyOuc2eNt7httO5qbML/4rJCisGtbRE+6RvCfPdifMcHhoHw75K7TJB7jqoGEL9ZkVXsYaYpJ5oNLk6egvPRhM2s2Nwivp3LwoEY1MK5x2OljwQm+rZTPzr+mvPwAJsEu9cLTvrVQuqg2YY2bHmC6q7IDJ7DhTo4HJqnO+1MXth6203Y/WsXPOnmAdItKoNe9Q==
Received: from PH7P221CA0067.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:328::28)
 by CY5PR12MB6345.namprd12.prod.outlook.com (2603:10b6:930:22::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Mon, 26 Aug
 2024 16:07:04 +0000
Received: from SN1PEPF0002529E.namprd05.prod.outlook.com
 (2603:10b6:510:328:cafe::9d) by PH7P221CA0067.outlook.office365.com
 (2603:10b6:510:328::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25 via Frontend
 Transport; Mon, 26 Aug 2024 16:07:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF0002529E.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Mon, 26 Aug 2024 16:07:03 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 26 Aug
 2024 09:06:44 -0700
Received: from fedora (10.126.230.35) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 26 Aug
 2024 09:06:39 -0700
References: <cover.1724324945.git.petrm@nvidia.com>
 <d5f8364b42f277daa9e235d23398e3dce5549e92.1724324945.git.petrm@nvidia.com>
 <05b9caf6-ecf5-48a2-ab65-509b0d5b5fb0@intel.com>
User-agent: mu4e 1.8.14; emacs 29.4
From: Petr Machata <petrm@nvidia.com>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
CC: Petr Machata <petrm@nvidia.com>, Shuah Khan <shuah@kernel.org>,
	<linux-kselftest@vger.kernel.org>, <netdev@vger.kernel.org>, Jakub Kicinski
	<kuba@kernel.org>, Ido Schimmel <idosch@nvidia.com>, Amit Cohen
	<amcohen@nvidia.com>, Benjamin Poirier <bpoirier@nvidia.com>, Hangbin Liu
	<liuhangbin@gmail.com>, Vladimir Oltean <vladimir.oltean@nxp.com>,
	<mlxsw@nvidia.com>
Subject: Re: [RFC PATCH net-next 1/5] selftests: forwarding: Introduce
 deferred commands
Date: Mon, 26 Aug 2024 17:20:49 +0200
In-Reply-To: <05b9caf6-ecf5-48a2-ab65-509b0d5b5fb0@intel.com>
Message-ID: <87o75f8e0l.fsf@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529E:EE_|CY5PR12MB6345:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d345b3d-66e4-48f1-bb2b-08dcc5e9201e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Q1sraKQh5TYH0zC3PYedhToxZUUxiJewuIFiFzCpDLXjFb/pNACb+EXV0uRR?=
 =?us-ascii?Q?7tYy4CvfN1A9OGH2NMUOlHhndPFr4zHLlD+2YhQ8+IdxrtJx0ntnxUsCXNFh?=
 =?us-ascii?Q?bzRH/CfwXd0EDA4jE4OJxuVE+4zHzKTcCBDFZCUDAhq48/p2EyDPLavz17N0?=
 =?us-ascii?Q?5rdGnKpr+RQbTjTmSRh92A9ZQpjWfqB9yYwjPvplElAY2VfCDJLpnyaMAQUj?=
 =?us-ascii?Q?zxeHBcs1CoWILDc3jyB1K43oAGl50tESEP4wKiZPs4ytjuf2p5hBuqneq6zZ?=
 =?us-ascii?Q?rP3rLyKYh2nSBVimIQ7hCf7/AYxtjMpRCa5TBFUvZIJtSXVmTP0JzA3o2u7C?=
 =?us-ascii?Q?N+FznuqDHuNsoAX0tpF/kyP7fONu6YrntYoFQc60Ee9BMuozr7RAndRXJiqv?=
 =?us-ascii?Q?OXLFFHdIupqNHE/V3cNB+H/x0I2ITwpc0UMW7OaDsxmwEpxL3wwO1vcfmrFs?=
 =?us-ascii?Q?n74P/HnfHLax5oSSESWQi33t4Ub6kXhMTKDMVQwilzyxDZUu8JJTJPKsqj/Z?=
 =?us-ascii?Q?Y6+Foc+7R10QPgNhZ34fP+kJBwujUZfVwrpv0dQiPiuJ+8qwnwxQzPErJ+yM?=
 =?us-ascii?Q?31/jyRQubAX8qJWoXQLFSechN2CC1lur4R5Yem7remjD/3/jxARQk55omL2O?=
 =?us-ascii?Q?G0OuHCSgT31u3jXcqyMCGNJQ7lH771ImjaFMFYG/LLtqGTVokKCL5/XOGuty?=
 =?us-ascii?Q?s3rlMRt7b+kdJmqC7Cyqbp27/7IFnXzJgXwKoye+o7LXhBp/smBjmH+jq3Qu?=
 =?us-ascii?Q?5oRoemSwUdT+KrPlLGCfm6ZQat8/TLvezkELl/yhzxFbUWs/N47aN818xIwI?=
 =?us-ascii?Q?ezrpazwS0GE77n3yFSiE+uhrK6yGn1v+OHYdPk2IpVEB39CnMDlBHsO5Yz5X?=
 =?us-ascii?Q?QTwZdotDaUzNWs2/oK/PpGcmijT6MoXmsETQFMguhChjhPXCOXAeuqNC/Yt8?=
 =?us-ascii?Q?yCzpVoGUboqIUVWUjIr4xL4u6HMrDvzbINhqOALjpCdZXqDcVBDc0dW/wcoL?=
 =?us-ascii?Q?eKh0LctFw5+bkhkwAtje0/8BCTvuxpm9+YklfDIZBic7yByk4aVU0oxcDFX8?=
 =?us-ascii?Q?7Rteg1BmRxUKdC/J2v+DFDpUyTezS995coElOlV0fsCBM7h7s4F/4DbQPS2E?=
 =?us-ascii?Q?W+Z3lJABGVQeGIX0d2bIT/RHD5EBHvOoOeJIHWmtpdfmydP15IyXvA+zwpS4?=
 =?us-ascii?Q?VeYd3t5G/ghMHRbKjEJwApQxj3FnvRe0J82SxOnjSwN6I1c1Fnrz9KBDzXCr?=
 =?us-ascii?Q?hIH2NAmRhY7t6koEXEqEtw521ZibfH50ewkPP7LE3u6rmneUtd0iXnd7qHym?=
 =?us-ascii?Q?dgSbIlDW/W/MqVlPiraBILy7xrx2+txiEeDEfxKbrPKh8xE2SrSxIIUqTQU2?=
 =?us-ascii?Q?1VA9dM3ukZEgyC0gef9mejNfS9uBHZZBHAoiV+Pr/mLvYpBEGCSVDE+8XAYE?=
 =?us-ascii?Q?4WDJU18VaTK1QbZ6gTX4aZUHGwCqFEB2?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2024 16:07:03.5141
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d345b3d-66e4-48f1-bb2b-08dcc5e9201e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002529E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6345


Przemek Kitszel <przemyslaw.kitszel@intel.com> writes:

> On 8/22/24 15:49, Petr Machata wrote:
>> In commit 8510801a9dbd ("selftests: drv-net: add ability to schedule
>> cleanup with defer()"), a defer helper was added to Python selftests.
>> The idea is to keep cleanup commands close to their dirtying counterparts,
>> thereby making it more transparent what is cleaning up what, making it
>> harder to miss a cleanup, and make the whole cleanup business exception
>> safe. All these benefits are applicable to bash as well, exception safety
>> can be interpreted in terms of safety vs. a SIGINT.
>> This patch therefore introduces a framework of several helpers that serve
>> to schedule cleanups in bash selftests:
>
> Thank you for working on that, it would be great to have such
> improvement for bash scripts in general, not limited to kselftests!
>
>>   tools/testing/selftests/net/forwarding/lib.sh | 83 +++++++++++++++++++
>
> Make it a new file in more generic location, add a comment section with
> some examples and write down any assumptions there, perhaps defer.sh?

I can do it, but it's gonna be more pain in setting up those
TEST_INCLUDES. People will forget. It will be a nuisance.

I'm thinking of just moving it to net/lib.sh, from forwarding.

>> - defer_scope_push(), defer_scope_pop(): Deferred statements can be batched > together in scopes.
>> When a scope is popped, the deferred commands
>>    schoduled in that scope are executed in the order opposite to order of
>>    their scheduling.
>
> tldr of this sub-comment at the end
>
> such API could be used in two variants:
>
> 1)
> function test_executor1() {
> 	for t in tests; do
> 		defer_scope_push()
> 		exec_test1 $t
> 		defer_scope_pop()
> 	done
> }
>
> 2)
> function test_executor2() {
> 	for t in tests; do
> 		exec_test2 $t
> 	done
> }
> function exec_test2() {
> 	defer_scope_push()
> 	do_stuff "$@"
> 	defer_scope_pop()
> }
>
> That fractals down in the same way for "subtests", or some special stuff
> like "make a zip" sub/task that will be used. And it could be misused as
> a mix of the two variants.
> I believe that the 1) is the better way, rationale: you write normal
> code that does what needs to be done, using defer(), and caller (that
> knows better) decides whether to sub-scope.

But the caller does not know better. The cleanups can't be done
"sometime", but at a predictable place, so that they don't end up
interfering with other work. The callee knows where it needs the
cleanups to happen. The caller shouldn't have to know.

> As this defer is very similar to golang's in intention, I would give
> yet another analogy from golang's world. It's similar to concurrency, you write normal code that
> could be parallelized via "go" keyword,
> instead of writing async code that needs to be awaited for.

Notice how in go, defer also runs at function exit. Similarly with C++
destructors, run on scope exit. There's no caller-defined "collection
point".

Putting off until "sometime" works for memory. Things like garbage
collection, obstacks, autorelease pools, etc. work, because there's
plenty of memory and we don't mind keeping stuff around until later. But
that doesn't work for the sort of cleanups that selftests typically need
to do.

> Going back to the use case variants, there is no much sense to have
> push() and pop() dispersed by much from each other, thus I would like
> to introduce an API that just combines the two instead:
>
> new_scope exec_test1 $t
> (name discussion below)
>
>> - defer(): Schedules a defer to the most recently pushed scope (or the
>>    default scope if none was pushed. >
>> - defer_scopes_cleanup(): Pops any unpopped scopes, including the default
>>    one. The selftests that use defer should run this in their cleanup
>>    function. This is important to get cleanups of interrupted scripts.
>
> this should be *the* trap(1)
>
> with that said, it should be internal to the defer.sh script and it
> should be obvious that developers must not introduce their own trap
> (as of now we have ~330 in kselftests, ~270 of which in networking)

Yeah, we have 100+ tests that use their own traps in forwarding alone.
That ship has sailed.

I agree that the defer module probably has the "right" to own the exit
trap. Any other cleanups can be expressed in terms of defer, and I don't
know if there are legitimate uses of exit trap with that taken out. But
that's for sometime.

>>    Consistent use of defers however obviates the need for a separate cleanup
>>    function -- everything is just taken care of in defers. So this patch
>>    actually introduces a cleanup() helper in the forwarding lib.sh, which
>>    calls just pre_cleanup() and defer_scopes_cleanup(). Selftests are
>>    obviously still free to override the function.
>> - defer_scoped_fn(): Sometimes a function would like to introduce a new
>>    defer scope, then run whatever it is that it wants to run, and then pop
>>    the scope to run the deferred cleanups. The helper defer_scoped_fn() can
>>    be used to derive from one function its wrapper that pushes a defer scope
>>    before the function is called, and pops it after it returns.
>
> It is basically a helper I would like to see as new_scope() mentioned
> above, but it takes it upside down - it should really be the caller that
> sub-scopes.
>
> I think that the name of the new_scope() would be better, still concise,
> but more precise as:
> subscope_defer(),
> trapped(), or
> sub_trap().
>
> I have no idea how to make a sub-trapped, SIGSEGV isolated scope of bash
> execution that has ability to still edit outer scope variables. Perhaps
> we could relax the need for edit to have easier implementation? It is
> "all ok or failure/rollback" mode of operation anyway most of the time.

I'm not sure what you have in mind.

> After the above parts will be discussed out I will look more into the
> details of the code more deeply.

