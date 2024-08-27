Return-Path: <linux-kselftest+bounces-16392-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0758B9609BF
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2024 14:12:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C5741C22975
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2024 12:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 179F01A08BC;
	Tue, 27 Aug 2024 12:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="q5AJKAQs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2063.outbound.protection.outlook.com [40.107.223.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3827519D8BB;
	Tue, 27 Aug 2024 12:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724760742; cv=fail; b=jn/w8GnKgHzwuTkQn9PA1ca+8vwAEUkynnOE4bJkAiRGo6+ief0kaN4Tgk3bJlfDfRkQbYxawjPKShWWukiKQ7IZ3M9zG1qbkFeczsSRyWJyutheQwZZNkc/+AI2Cg62/QHs8vd+3nHdxW6u/Xrmru95+wnetZQNE3ytBLNnHak=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724760742; c=relaxed/simple;
	bh=RWbWxXLrVTO6PRz7McvJuzxJTL/f1yng9xZcR+sWPS8=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=ahFXd5SIz+M6R+d8l13HE3bjETph8Ofa074w7H9Be8QNPJGitC4lB5UgLtZ8ZXHAwy/MhBjOOJRrJ/UgkS/AGjwLTVkFFvNFmu4OKtEmK8EX6ATmNikZaf10L7VcQ8+oqJopdfhHRE0O+tej6/QLsvWlyE37cdgVzDIW343zBqU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=q5AJKAQs; arc=fail smtp.client-ip=40.107.223.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ya9uDrT9zHFqS8ZV8DdqjI35qlIui3M8iFt02Y05xxAo1gSEl30BnuvDCXvktOKYF75FDZX3t4SZUqGzUprg7rykMnJuRQEjQAKLCM/X4ht+i893urCdogVOts9tTW+TUCrTpPn5lKC/4QkXajdG4yMVmBeRGySzgByz/nGdk0E9K2+kqN8s7if31hyhMYJ2+ZRV/aj/b81Qf44dOwNdHfEYWoXionpTF06q1+2dBGlfwQztQlFlzO7lvUA/IFpU6VcmQ2MdgqnK+D8a+LKhQ0DfpAK5m6CzkiXpV3IQU5Um9UrppnjYH/0yLD+BmtTNnFlKYUJR7TvYHP+FVZmjKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wlI7C5mlg/4y024FjVksuI2Rm+xw8a/lTwI+B01YU94=;
 b=i8cwm2nwK11aAupAmVQ6aMzKaomnllLRNiybMsQJInAIdMsfYkzBE4hLBemnOQAGd+2/PAO/iFHc9o9a5bUBNI369hh1OtwhgQDISxtSizMokiWuvpzIBseIQvAoe1Q0VpS/FutP2gfx1dwbp1rMKRx6lI0ckYDvwW4jRJaoEorQHNWThsnZm9LTtgb5H2DslTwVZQE7eiwAwzUyiYNZNR8foNwk6FueJBdhV+rjiGhiLH6NV9KxhPzbqU/CbWsqMD8XfdkHfidkaSbl1J7IndLBOaHnRoASHGTgtKwGZTAfd/fbPdK2id6tQYgWJmzqkch79mOg7dZBIo/evQ79bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nxp.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wlI7C5mlg/4y024FjVksuI2Rm+xw8a/lTwI+B01YU94=;
 b=q5AJKAQsxi0nHnPLl2jY+EGYbLo2u4/a6hjwV+Yo55t/xzMKMgq2zFDUZ3so+CZBYRopgdqR9fpV0fcscGvJT29FCFT+CCXuUC7JkDAg5yFxLdnHXZ7Q3HbTkIgcNoxnx2a+MDc0FmxZMUjzt1UrEcDRIlo3Awqknk+pMAalnJ/oKnuZMCIm53joHZdHvgd5VJjnyKGUEeodCilLl0PzdtLhG/Li25Ys7a0o1CzR6QRh0qC12MBUxrIvo4BanSRiyY/n+ICc4dIcziDt6vttH4etbQmYdAh9GemmkxyeXXGeqJDgvCCiy10MyqXWtOLK1CXJejUK4RQ+lflZY7c9uA==
Received: from MN2PR22CA0004.namprd22.prod.outlook.com (2603:10b6:208:238::9)
 by DS7PR12MB8084.namprd12.prod.outlook.com (2603:10b6:8:ef::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7875.20; Tue, 27 Aug 2024 12:12:12 +0000
Received: from BL6PEPF0001AB59.namprd02.prod.outlook.com
 (2603:10b6:208:238:cafe::77) by MN2PR22CA0004.outlook.office365.com
 (2603:10b6:208:238::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25 via Frontend
 Transport; Tue, 27 Aug 2024 12:12:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF0001AB59.mail.protection.outlook.com (10.167.241.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Tue, 27 Aug 2024 12:12:11 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 27 Aug
 2024 05:11:56 -0700
Received: from fedora (10.126.231.35) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 27 Aug
 2024 05:11:50 -0700
References: <cover.1724324945.git.petrm@nvidia.com>
 <d5f8364b42f277daa9e235d23398e3dce5549e92.1724324945.git.petrm@nvidia.com>
 <05b9caf6-ecf5-48a2-ab65-509b0d5b5fb0@intel.com>
 <87o75f8e0l.fsf@nvidia.com>
 <3312a4a6-97f5-4ae2-9527-c7b1b73da6d2@intel.com>
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
Date: Tue, 27 Aug 2024 10:53:53 +0200
In-Reply-To: <3312a4a6-97f5-4ae2-9527-c7b1b73da6d2@intel.com>
Message-ID: <87jzg288sd.fsf@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB59:EE_|DS7PR12MB8084:EE_
X-MS-Office365-Filtering-Correlation-Id: 6cf3db88-894e-4181-1438-08dcc6917b5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1QSbdpp2Ooh2KxvAitUP9LWo2YGzqe+SZO2EAf5maD71nGXKx8Dx9A0SrG+A?=
 =?us-ascii?Q?3WUe+tDKXy5p3aO+uZ8mxFJpT8mX5a5AsFCtAwDB1xM1hpRb47tcMW9Ki7xQ?=
 =?us-ascii?Q?VIg2pF08o26x/9P4InN4YA6HuGah+A9hrT9U5DOJPTRYwkK41FeuC98YsF/E?=
 =?us-ascii?Q?tTIAjl1EBNPSbkvoasLQKFRSQod4mQiNTae+miHAG0INqJxJtqz4sPddy3vt?=
 =?us-ascii?Q?M/DXJxxHFnNDDdtlUJRuGDT8EfklLnePJBk264kOmB/Vana9XhH7HrnpEI3O?=
 =?us-ascii?Q?IIUq4MBV+0vVJ39HqNYTPsexRB7fD7iWINltUvbUK0IYkkFqqhKKcve+aZqJ?=
 =?us-ascii?Q?CmaqmrKiK2ctacgL8ENfPQiCLJOevz/DbTZXvyAtIYpFdabt+QxMr6S5tz36?=
 =?us-ascii?Q?ftxkW7nd7l8Eybjfl+/CrzLv0NSBs9hucZG+oDdtlElUX8Kz6GKBUAP55sEx?=
 =?us-ascii?Q?C+ePzrlx3PhlnB1L90hjUM1zVO11NMV648HDAR32xGNGKUuoVABWQgsbiHiF?=
 =?us-ascii?Q?o6C8q4hUZtzdM1C8XoFOaMto5lyZEs+a7SPGeXbAeSrlenns/oWubWjpYw42?=
 =?us-ascii?Q?9MtWJ6ONKzteSKXiq5CsvcBFuozmpwlHvOgG8GxWEj8dfqrzEeG2MYIpkfkV?=
 =?us-ascii?Q?6M+i5W3TONOzPwS5nQZbPmicIzHUesFVdP+9xoZdw4FVhYQuGy3aa7n+c8fY?=
 =?us-ascii?Q?dO09THiEcNcjI+BhRAkmuZLrTm85J2qx3feht+iUWScTxe4rcorXvOaIqCmP?=
 =?us-ascii?Q?A9fqyepTMWANhAs7u7hBd2+Fu3PhzcZi1WFmbmyD3ElNlcGQ4bIPo6DOKaKx?=
 =?us-ascii?Q?4y50OK/6B1MtRsMD7ko+/oKilV0s7Hh0DUDPXxODkVDberSRwp2RBmWGH7Bc?=
 =?us-ascii?Q?2dJ8jYbwEf50u99//JRwGKLGUo7Pw8VRlVSUR1CmHBLUoAtu+Ozx7K3cvc3Y?=
 =?us-ascii?Q?WL+J60Y/+GXsQrQ+87Mtvxl2lFXUwQFRFJMwWK8FhyM9vsLGKx9RUONJsGnS?=
 =?us-ascii?Q?cOD7ssb02I9x9DERqJqd3MfIABLx4AzrG1RfIY2WnIl+AEo6nJAAyMqfRZg0?=
 =?us-ascii?Q?XbxdAlF8ssFvdTMFNDmllyOWDLsSDf+l5lNk3cAW1jEa7dbrSGoM+hkW8ngg?=
 =?us-ascii?Q?173GCxZd2g5LfXKGCNDCDD/bvSjCXYVVbW/mhWueGLSStwdgfFqOSzRXhI58?=
 =?us-ascii?Q?DzZ3MQxQXZ1VXp8F0cxaTVFQCGdV/rm8bgvuUpXGTitbfY8oHzX+OZHb8uEt?=
 =?us-ascii?Q?V7VryD1JjFMoHNI5Jp3skfZ3hrgwcFrWJZTuxIr4AuYJrtRCXV0P7vOTq6Eh?=
 =?us-ascii?Q?FG/QINC6EIlWkUsqoK45g8dzakMKGwLtsh0wQcHOFzc3m1mW/5qzQaa4GVQ6?=
 =?us-ascii?Q?F+q2+csOrbGF51suKdTaGIfq9qdjYtNpZglKiHS9CAjv1rNzBQBwBSK/7DYT?=
 =?us-ascii?Q?des8NgNXKGpTRKlTxmAqnGf4BPdhZMhf?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 12:12:11.9638
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cf3db88-894e-4181-1438-08dcc6917b5a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB59.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8084


Przemek Kitszel <przemyslaw.kitszel@intel.com> writes:

> On 8/26/24 17:20, Petr Machata wrote:
>> Przemek Kitszel <przemyslaw.kitszel@intel.com> writes:
>> 
>>> On 8/22/24 15:49, Petr Machata wrote:
>>>> In commit 8510801a9dbd ("selftests: drv-net: add ability to schedule
>>>> cleanup with defer()"), a defer helper was added to Python selftests.
>>>> The idea is to keep cleanup commands close to their dirtying counterparts,
>>>> thereby making it more transparent what is cleaning up what, making it
>>>> harder to miss a cleanup, and make the whole cleanup business exception
>>>> safe. All these benefits are applicable to bash as well, exception safety
>>>> can be interpreted in terms of safety vs. a SIGINT.
>>>> This patch therefore introduces a framework of several helpers that serve
>>>> to schedule cleanups in bash selftests:
>>>
>>> Thank you for working on that, it would be great to have such
>>> improvement for bash scripts in general, not limited to kselftests!
>>>
>>>>    tools/testing/selftests/net/forwarding/lib.sh | 83 +++++++++++++++++++
>>>
>>> Make it a new file in more generic location, add a comment section with
>>> some examples and write down any assumptions there, perhaps defer.sh?
>> I can do it, but it's gonna be more pain in setting up those
>> TEST_INCLUDES. People will forget. It will be a nuisance.
>> I'm thinking of just moving it to net/lib.sh, from forwarding.
>
> what about separate file, but included from net/lib.sh?

Unfortunately that would be even worse. Then you need to remember to put
the file into TEST_INCLUDES despite seemingly not using it.

Like ideally we'd have automation for this. But I don't know how to do that
without actually parsing the bash files, and that's just asking for
trouble. Maybe after the defer stuff we also need a module system :-/

>>>> - defer_scope_push(), defer_scope_pop(): Deferred statements can be batched > together in scopes.
>>>> When a scope is popped, the deferred commands
>>>>     schoduled in that scope are executed in the order opposite to order of
>>>>     their scheduling.
>>>
>>> tldr of this sub-comment at the end
>>>
>>> such API could be used in two variants:
>>>
>>> 1)
>>> function test_executor1() {
>>> 	for t in tests; do
>>> 		defer_scope_push()
>>> 		exec_test1 $t
>>> 		defer_scope_pop()
>>> 	done
>>> }
>>>
>>> 2)
>>> function test_executor2() {
>>> 	for t in tests; do
>>> 		exec_test2 $t
>>> 	done
>>> }
>>> function exec_test2() {
>>> 	defer_scope_push()
>>> 	do_stuff "$@"
>>> 	defer_scope_pop()
>>> }
>>>
>>> That fractals down in the same way for "subtests", or some special stuff
>>> like "make a zip" sub/task that will be used. And it could be misused as
>>> a mix of the two variants.
>>> I believe that the 1) is the better way, rationale: you write normal
>>> code that does what needs to be done, using defer(), and caller (that
>>> knows better) decides whether to sub-scope.
>> But the caller does not know better. The cleanups can't be done
>> "sometime", but at a predictable place, so that they don't end up
>> interfering with other work. The callee knows where it needs the
>> cleanups to happen. The caller shouldn't have to know.
>
> The caller should not have to know what will be cleaned, but knows that
> they are done with callee.
>
> OTOH, callee has no idea about the "other work".

Nor should it have to. It just needs to dispose of all responsibilities it
has acquired (read: clean up what it has dirtied, or what others have
dirtied for it). That's done by closing the defer scope.

But let me take a step back. I've been going back and forth on this
basically since yesterday.

In practice, the caller-defined scopes lead to nicer code.

If run_tests creates an implicit scope per test, most of the tests can just
issue their defers without thinking about it too much.

For cases where the implicit scope is not enough, the caller has to know
that a certain function needs to be run in a dedicated scope or else it
will interfere with something else that it's running. That's not great, it
complicates the caller-callee contract in a way that's not captured
anywhere in the syntax. But I suspect it's going to be just fine, these
scripts are not exactly complex, and if there's an interference, I figure
it will be easy to notice.

The major upside is that we avoid the need to pepper the code with
defer_scoped_fn.

So I'll drop defer_scoped_fn and add in_defer_scope:

in_defer_scope()
{
	local ret

	defer_scope_push
	"$@"
	ret=$?
	defer_scope_pop

	return ret
}

>>> Going back to the use case variants, there is no much sense to have
>>> push() and pop() dispersed by much from each other, thus I would like
>>> to introduce an API that just combines the two instead:
>>>
>>> new_scope exec_test1 $t
>>> (name discussion below)
>>>
>>>> - defer(): Schedules a defer to the most recently pushed scope (or the
>>>>     default scope if none was pushed. >
>>>> - defer_scopes_cleanup(): Pops any unpopped scopes, including the default
>>>>     one. The selftests that use defer should run this in their cleanup
>>>>     function. This is important to get cleanups of interrupted scripts.
>>>
>>> this should be *the* trap(1)
>>>
>>> with that said, it should be internal to the defer.sh script and it
>>> should be obvious that developers must not introduce their own trap
>>> (as of now we have ~330 in kselftests, ~270 of which in networking)
>> Yeah, we have 100+ tests that use their own traps in forwarding alone.
>> That ship has sailed.
>> I agree that the defer module probably has the "right" to own the exit
>> trap. Any other cleanups can be expressed in terms of defer, and I don't
>> know if there are legitimate uses of exit trap with that taken out. But
>> that's for sometime.
>
> There could be multiple traps for ERR/EXIT/etc conditions, but for
> simplicity it's best to rely on just EXIT trap.
> So we should convert current scripts one by one to use your new API.

I'd just grandfather those in, but having this stuff consolidated would
obviously be nice.

I think in practice we just need to add the trap registration to
forwarding.sh, and per bash script do something like:

-trap cleanup EXIT
 setup_prepare
+defer cleanup
 setup_wait

It should be fairly mechanical most of the time. But the defer stuff works
without it as well, so we can take care of that later on.

>>>>     Consistent use of defers however obviates the need for a separate cleanup
>>>>     function -- everything is just taken care of in defers. So this patch
>>>>     actually introduces a cleanup() helper in the forwarding lib.sh, which
>>>>     calls just pre_cleanup() and defer_scopes_cleanup(). Selftests are
>>>>     obviously still free to override the function.
>>>> - defer_scoped_fn(): Sometimes a function would like to introduce a new
>>>>     defer scope, then run whatever it is that it wants to run, and then pop
>>>>     the scope to run the deferred cleanups. The helper defer_scoped_fn() can
>>>>     be used to derive from one function its wrapper that pushes a defer scope
>>>>     before the function is called, and pops it after it returns.
>>>
>>> It is basically a helper I would like to see as new_scope() mentioned
>>> above, but it takes it upside down - it should really be the caller that
>>> sub-scopes.
>>>
>>> I think that the name of the new_scope() would be better, still concise,
>>> but more precise as:
>>> subscope_defer(),
>>> trapped(), or
>>> sub_trap().
>
> here I mean that "scope" is too broad without the word "trap" or "defer"
> in name
>
>>>
>>> I have no idea how to make a sub-trapped, SIGSEGV isolated scope of bash
>>> execution that has ability to still edit outer scope variables. Perhaps
>>> we could relax the need for edit to have easier implementation? It is
>>> "all ok or failure/rollback" mode of operation anyway most of the time.
>> I'm not sure what you have in mind.
>
> 	foo=1
> 	function bumpfoo {
> 		maybe-crash
> 		foo=2
> 	}
> 	new-defer-scope bumpfoo
> 	echo $foo
>
> do you want this to print 2 or 1?

Oh, that's what you mean by relaxing the edits. Yeah, I think I'd want that
to print 2 if at all possible. I think in_ns() is the only helper that
violates this.

