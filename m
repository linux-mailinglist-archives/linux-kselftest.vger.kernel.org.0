Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7202ADBA3F
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Oct 2019 01:40:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441797AbfJQXkM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 17 Oct 2019 19:40:12 -0400
Received: from mail-eopbgr750137.outbound.protection.outlook.com ([40.107.75.137]:17991
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2441782AbfJQXkL (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 17 Oct 2019 19:40:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VAHsVA30mNxxsWwY5lcU3bPAiLc3Cxd64avwnbgH6FbFTH45DFq6X7HEhv16SztHrr84BHnvrXfPGNK0NqoI67b3QS5g4OxQPkcRbvDUd4rRJsq7qvIXJAiIjDUXgK+mesw+/MjAuznbIBKEJsS4C1c1u/TLhm5IunmD04Z55yj03f1P9IbMzl8RmN5DaG04BY3Ce8OaR2ffahBqY9HKVUFl+UOS3/0KaM9OQYJpXnSL3/Qu9pgCqydR9fxpgW99ovIpA69H2iTDgnUaPHHNVXmYGSiru6nDzgZN2laCjgFivjnD2O+jpJLoJV9tWAbgusR+ZQF0KEFGfZasVlqR7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jlJ+Y7tVYfJvHYnzDtG8yUBBneLr7X3wtHZg7LcwgXQ=;
 b=M9FKX5AFHUNCgWky20qDYyV7NJk+s2+wjbOg9AnSuxTR+6rHO68y/aUj1lBJcApNucEkYIc0WmninWM/G0mofrEDiAa+HM1AF8GobUGte7Uh4g+v8GtE3vbiZ2F4pygXtLn8mqc9qWUmLHwSblIfaIPC2hgtvPrxPrmwHh2o1qeKA/0c5qh3UTIUKG7+ZEIOVy5iN0egft/RHRkQ/i5Qz5W5rprz8rEz+dbAnQwMFMFki9UW40m/pxqEGE3din99Sv3mJi2LdykSs0jF74kFsu0dz1dBue+QzYEITeOvB3IVZY2Gktljjtd1M8ShMRGk34U+zs61rsqgWSEEBVEbTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 160.33.194.231) smtp.rcpttodomain=mit.edu smtp.mailfrom=sony.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=sony.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Sony.onmicrosoft.com;
 s=selector2-Sony-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jlJ+Y7tVYfJvHYnzDtG8yUBBneLr7X3wtHZg7LcwgXQ=;
 b=K3FfPsV/1ekJ+TukGf6QKhPgAanN4LblLsI5fDwANjNmyT4PBGzwPCLVEIZWM6y/btunTEY3M7NT/DTisOJwcmfL8kFBqUTSyQ4vd/+SC51p9Bbm7icPyxHzs0VO6KrLkciAbjs8X5U0GGDt4q9qIJ8i02owmMtGUedRL+5/FOk=
Received: from CY4PR13CA0085.namprd13.prod.outlook.com (2603:10b6:903:152::23)
 by DM5PR13MB1834.namprd13.prod.outlook.com (2603:10b6:3:131::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2347.14; Thu, 17 Oct
 2019 23:40:06 +0000
Received: from BL2NAM02FT003.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::206) by CY4PR13CA0085.outlook.office365.com
 (2603:10b6:903:152::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2367.6 via Frontend
 Transport; Thu, 17 Oct 2019 23:40:06 +0000
Authentication-Results: spf=pass (sender IP is 160.33.194.231)
 smtp.mailfrom=sony.com; mit.edu; dkim=none (message not signed)
 header.d=none;mit.edu; dmarc=pass action=none header.from=sony.com;
Received-SPF: Pass (protection.outlook.com: domain of sony.com designates
 160.33.194.231 as permitted sender) receiver=protection.outlook.com;
 client-ip=160.33.194.231; helo=usculsndmail04v.am.sony.com;
Received: from usculsndmail04v.am.sony.com (160.33.194.231) by
 BL2NAM02FT003.mail.protection.outlook.com (10.152.76.204) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2367.14 via Frontend Transport; Thu, 17 Oct 2019 23:40:06 +0000
Received: from usculsndmail12v.am.sony.com (usculsndmail12v.am.sony.com [146.215.230.103])
        by usculsndmail04v.am.sony.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id x9HNe5YP004322;
        Thu, 17 Oct 2019 23:40:05 GMT
Received: from USCULXHUB06V.am.sony.com (hub.bc.in.sel.sony.com [146.215.231.44])
        by usculsndmail12v.am.sony.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id x9HNe4jX013673;
        Thu, 17 Oct 2019 23:40:05 GMT
Received: from USCULXMSG01.am.sony.com ([fe80::b09d:6cb6:665e:d1b5]) by
 USCULXHUB06V.am.sony.com ([146.215.231.44]) with mapi id 14.03.0439.000; Thu,
 17 Oct 2019 19:40:04 -0400
From:   <Tim.Bird@sony.com>
To:     <tytso@mit.edu>
CC:     <skhan@linuxfoundation.org>, <brendanhiggins@google.com>,
        <yzaikin@google.com>, <linux-kselftest@vger.kernel.org>,
        <linux-ext4@vger.kernel.org>, <adilger.kernel@dilger.ca>,
        <kunit-dev@googlegroups.com>
Subject: RE: [PATCH linux-kselftest/test v2] ext4: add kunit test for
 decoding extended timestamps
Thread-Topic: [PATCH linux-kselftest/test v2] ext4: add kunit test for
 decoding extended timestamps
Thread-Index: AQHVfxQJt5KYyUfdIUCqjuPcGwlYBqdUYHYAgABUYYCAAMbxgIAANgMAgAhyYYCAABMAgIAA1OuAgABbSgCAAFnHgP//vbhQ
Date:   Thu, 17 Oct 2019 23:40:01 +0000
Message-ID: <ECADFF3FD767C149AD96A924E7EA6EAF977D00A4@USCULXMSG01.am.sony.com>
References: <20191010023931.230475-1-yzaikin@google.com>
 <2f2ea7b0-f683-1cdd-f3f2-ecdf44cb4a97@linuxfoundation.org>
 <CAAXuY3qtSHENgy3S168_03ju_JwAucOAt5WEJGQ+pi5PfurP6g@mail.gmail.com>
 <CAFd5g46RcFV0FACuoF=jCSLzf7UFmEYn4gddaijUZ+zR_CFZBQ@mail.gmail.com>
 <20191011131902.GC16225@mit.edu>
 <CAFd5g45s1-=Z4JwJn4A1VDGu4oEGBisQ_0RFp4otUU3rKf1XpQ@mail.gmail.com>
 <1e6611e6-2fa6-6f7d-bc7f-0bc2243d9342@linuxfoundation.org>
 <20191017120833.GA25548@mit.edu>
 <ECADFF3FD767C149AD96A924E7EA6EAF977D0023@USCULXMSG01.am.sony.com>
 <20191017225637.GB6371@mit.edu>
In-Reply-To: <20191017225637.GB6371@mit.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [146.215.231.6]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:160.33.194.231;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10019020)(979002)(39860400002)(346002)(396003)(376002)(136003)(189003)(13464003)(52294003)(199004)(8746002)(6916009)(4326008)(7736002)(2171002)(7696005)(106002)(229853002)(86362001)(37786003)(6246003)(55016002)(33656002)(316002)(46406003)(54906003)(8676002)(5660300002)(246002)(305945005)(8936002)(50466002)(2351001)(14444005)(23726003)(3846002)(47776003)(6116002)(70586007)(6666004)(186003)(66066001)(26005)(70206006)(102836004)(426003)(76176011)(336012)(2876002)(446003)(356004)(2906002)(476003)(478600001)(486006)(126002)(97756001)(55846006)(11346002)(5001870100001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR13MB1834;H:usculsndmail04v.am.sony.com;FPR:;SPF:Pass;LANG:en;PTR:mail04.sonyusa.com,mail.sonyusa.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2f7fbee5-bcef-49de-320d-08d7535b56fa
X-MS-TrafficTypeDiagnostic: DM5PR13MB1834:
X-Microsoft-Antispam-PRVS: <DM5PR13MB183452BDAAC0F97EBE38184DFD6D0@DM5PR13MB1834.namprd13.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 01930B2BA8
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hFdI3Lf9qvSTqNRsKJhsuEvp0GFAgcaHItJoKUxHyudPeV3WxmvSDnCWfz/So3iNtSZBhg1USLyvHJUpz8N9Fv8SjqlxYDLv2udSGGrH0LshSBBVpD2t7aMFrDOyNWtEhL/tMYF/Q9wYwhglfE9gb0vIJKVeIGSI//0mhDIDE/S8y3isCxjY/yXPv4M7HRpLPUJfNpXu4Fp04JIoAYJmIZ/RniUgCPvMSFPk+gIWIy0al7nJCKN9rVsbjfXSW4OJPZ3ynJA2JeYp5XV/oYegkG0MoCmNLswDA4GEXoL8hc7IC8ggnb17C1bRDYSLf88rKkpbC2ZtEVjigD0K95ydsqiMgjiHRl5YnWez1Q3gP80ajMmsgZwlCNQ3Jrmv4e46/fhr3Oet2A0/td5xi9fGUNWCfWGvRXewyX7mFYjUEo8=
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2019 23:40:06.2291
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f7fbee5-bcef-49de-320d-08d7535b56fa
X-MS-Exchange-CrossTenant-Id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=66c65d8a-9158-4521-a2d8-664963db48e4;Ip=[160.33.194.231];Helo=[usculsndmail04v.am.sony.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR13MB1834
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



> -----Original Message-----
> From: Theodore Y. Ts'o=20
>=20
> On Thu, Oct 17, 2019 at 10:25:35PM +0000, Tim.Bird@sony.com wrote:
> >
> > I'm not sure I have the entire context here, but I think deterministic
> > might not be the right word, or it might not capture the exact meaning
> > intended.
> >
> > I think there are multiple issues here:
> >  1. Does the test enclose all its data, including working data and expe=
cted
> results?
> > Or, does the test allow someone to provide working data?  This
> > alternative implies that either the some of testcases or the results
> > might be different depending on the data that is provided.  IMHO the
> > test would be deterministic if it always produced the same results
> > based on the same data inputs.  And if the input data was
> > deterministic.  I would call this a data-driven test.
>=20
> Do you mean that the tester would provide the test data at the time
> when they launch the test? =20

No. Well, the data might be provided at some time independent
of the test compilation time, but it would not be made up on the fly.
So the data might be provided at run time, but that shouldn't imply
that the data is random, or that there is some lengthy fabrication
process that happens at test execution time.

> My definition of a unit test is something which runs quickly so you
> can do make some quick edits, and then run something like "make
> check", and find out whether or not you've made any screw ups.  Or it
> might get used in an automated way, such that immediately after I push
> to a Gerrit server, tests *automatically* get run, and within a minute
> or two, I get notified if there are any test failures, and a -1 review
> is automatically posted to the proposed change in the Web UI.
>=20
> So this is not the sort of thing where the human will be providing
> working data to change how the test behaves.  The idea is that you
> type "make check", and hundreds of tests run, sanity checking basic
> functional soundness of the changes which were just made.
I'm not talking about any kind of system where a human is required
to think something up when the test runs.

>=20
> Unit tests also tend to run on small pieces of code --- for example,
> in how we encode 64-bit timestamps in ext4, to provide both 100ns
> granularity timestamps as well as post-2038 encoding, where the "low"
> 32-bits are backwards compatible with traditional 32-bit time_t's.  It
> turns doing this is complicated, and it's easy to screw it up (and in
> fact, we have).  So now we have a set of unit tests for it.
>=20
> The unit tests use a lot of reusable infrastructure, so that while
> there are a series of tests to test each of the various different
> boundary conditions, they are *driven* by test data.  So for example,
> this is a test...
>=20
> 		{
> 			.test_case_name =3D
> 	  "2174-02-25 Lower bound of 32bit <0 timestamp, hi extra sec bit
> on.",
> 			.msb_set =3D true,
> 			.lower_bound =3D true,
> 			.extra_bits =3D  2,
> 			.expected =3D {.tv_sec =3D 0x180000000LL, .tv_nsec =3D 0L},
> 		},
>=20
>=20
> ... and this is a different test....
>=20
> 		{
> 			.test_case_name =3D
> "2310-04-04 Upper bound of 32bit>=3D0 timestamp, hi extra sec bit 1. 1 ns=
 bit
> 1.",
> 			.msb_set =3D false,
> 			.lower_bound =3D false,
> 			.extra_bits =3D 6,
> 			.expected =3D {.tv_sec =3D 0x27fffffffLL, .tv_nsec =3D 1L},
> 		},
>=20
> So yes, it's very data-driven.  *But* all of the code, data, and
> expected results are all encapsulated in fs/ext4/inode-test.c.

Agreed.  By data-driven, I should have more specifically said
something like external-data driven.

>=20
> So when you say, "does the test allow someone to provide working
> data", it's unclear what you mean by that. =20

I mean that some piece of data that allows the test to test more conditions=
.
More specifically, I mean data that already exists at test execution
time.

> How do you expect a user
> to provide the working data?  And how do you make the test easy to
> run?

In this case, the data is encoded in C structures and requires re-compiling
the test when a new data point is added.  One could envision reading
the list of data points from a file, and processing them.
Each new data point becomes a new test case.  This allows someone
to add a data point - for example maybe Iurii missed an interesting one,
or the algorithm changed and a new test case becomes worth testing.

In this case, the cost of parsing the data file does add some overhead,
but it's not onerous.  I'm not sure how, or whether, kunit handles
the issue of reading data from a file at test time.  But it doesn't have
to be a file read.  I'm just talking separating data from code.

This might not be the best example, because the C code for expressing
the data points is pretty simple, so someone can add another data
point pretty easily.  What cannot be done with the data points embedded
in the code, however, is send a data file indicating a new problem data poi=
nt,
without other people having to re-compile the code to check it out
on their system.

>=20
> > 2. Does the test automatically detect some attribute of the system,
> > and adjust its operation based on that (does the test probe?)  This
> > is actually quite common if you include things like when a test
> > requires root access to run.  Sometimes such tests, when run without
> > root privilege, run as many testcases as possible not as root, and
> > skip the testcases that require root.
>=20
> And if the test needs to do this, it's *automatically* not a unit
> test.

Not necessarily.  Maybe the root privilege example is not a good one.
How about a test that probes the kernel config, and executes
some variation of the tests based on the config values it detects?

This has nothing to do with the scope of the test or the speed of
the test.

> It might be an integration test.  xfstests fall very squarely
> into into that category.  Integration tests are heavier-weight.
> You're not going to run them as lightly as you run unit tests, because
> they take more resources, and more wall clock time before you get
> results.
>=20
> One of the main point of unit tests is that they are testing units of
> code smaller than "the whole kernel".  When I'm testing how 64-bit
> timestamps are encoding, "root" has no meaning, because the scope of
> the test doesn't even really include the concept of a process, or user
> privileges.
Agreed.

>=20
> One of the other advantages of unit tests is that sometimes it's much
> easier to test the corner cases of some internal abstraction because
> you can have test mocks which are can simulate conditions which would
> be very hard to simulate if you are running userspace code which can
> talk to the kernel only via the system call interface.
Agreed.

>=20
> > The reason I want get clarity on the issue of data-driven tests is
> > that I think data-driven tests and tests that probe are very much
> > desirable.  This allows a test to be able to be more generalized and
> > allows for specialization of the test for more scenarios without
> > re-coding it.  I'm not sure if this still qualifies as unit testing,
> > but it's very useful as a means to extend the value of a test.  We
> > haven't trod into the mocking parts of kunit, but I'm hoping that it
> > may be possible to have that be data-driven (depending on what's
> > being mocked), to make it easier to test more things using the same
> > code.
>=20
> So does this distinction help?
>=20
> If you need to do things which involve system calls and whether the
> system calls are run as root, it seems to me that the existing
> kselftest infrastructure is the right thing to do.  If you are
> interested in testing code below (and in some cases *well* below) the
> system call interface, then kunit is the right approach.
>=20
> I'd encourage you to take a look at Iiuri's fs/ext4/inode-test.c.  As
> you can see, it is very data-driven.  But it is also, at the same
> time, very self-contained, and which can be easily run, and run very
> quickly.

I'm familiar with the test.  I provided input to it.  In using it as an exa=
mple
I am not advocating that it is a good candidate for being data driven (with
data external to the test program).
But other tests - particular ones where hardware needs to be mocked,
are.

 -- Tim

