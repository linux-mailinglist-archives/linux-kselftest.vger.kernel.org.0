Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 665F7DB9B8
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Oct 2019 00:25:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438255AbfJQWZp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 17 Oct 2019 18:25:45 -0400
Received: from mail-eopbgr700093.outbound.protection.outlook.com ([40.107.70.93]:46816
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732705AbfJQWZo (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 17 Oct 2019 18:25:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CDJrAG64ZBO7OYl23SuMsShtRbFpPwYGMzj1Uu9/Pb4mflAKmPqXUSzIqhNBisGeUJcCsP+DLXvedk7Cax+9pKkyRGzYqtBvuaO2oxnaiWHyiQWygzskyAwylrL6ZVpVRdKm6Ij1UnGaLAVOKlH/+hL61bBdDji/tDd/HhF/hAhu5hUVXFICB0ebLp5TjX30+eG8E4JE40PHqYvR3Aj6k5/mJPv8lCxSLCh215YY0rVATUQwOv5noYGwr1vLIFn2x/CdFn8X2LlxyvMk8COyql/46OUaIS8hSsgE+dpOno/Rn4inRF+e8qsAzk139mnzEdWywJmOyw6NUS9s1FluDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4n6tmZEzus7fSkO6gahWVK0Ls6832+U+odiGgot6LTg=;
 b=ehknQb8aCtCEXWsav+pZPDKDnAgLOXMs/2QPdXTk68J0rV48Ay4FLhQcls1E3IqDPNqvfQjhodVcTNeuLWmBdMMJmZZDzsmdsrxSoAYXiKa2CpNNYnoJsiatz4TNaDLZqU4DKbVKWcElfkcc+QxSkSYvxecjPIOVvyNhzFxcPbuO66XvLDEOLYZVuYgFvK67LeCvJAxjhdF64sdVM4zAsByJdWp9m6W/SzVTJ18w+kKPI+Im7TG0yYafKNSU8a1Cjl6ZY7/0ICVLrcnOW99FiD9C6w1QbecuCOvKTZsWJ4cHPURndmEASgduHbbXaHGg31xk6t3upsAdEMhTihFsug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 160.33.194.231) smtp.rcpttodomain=mit.edu smtp.mailfrom=sony.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=sony.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Sony.onmicrosoft.com;
 s=selector2-Sony-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4n6tmZEzus7fSkO6gahWVK0Ls6832+U+odiGgot6LTg=;
 b=ts92t/2sQndtRimh8nrZ16GM0N4wkIFceQhQPz8nvL3bQ5R0yQLyaIo3oiv2Nxev+wHfWHOd3QH1CS/IYWDGA6bmqxH55UolR5TNmAlkDsK5ch0DBEV3889SqtzOq9dmGPuAhX1YYaezAqCYt5ukmDAv9OX4l2BIHBLQjBch6v4=
Received: from MWHPR13CA0045.namprd13.prod.outlook.com (2603:10b6:300:95::31)
 by CY4PR13MB1816.namprd13.prod.outlook.com (2603:10b6:903:157::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2367.14; Thu, 17 Oct
 2019 22:25:40 +0000
Received: from BL2NAM02FT020.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::204) by MWHPR13CA0045.outlook.office365.com
 (2603:10b6:300:95::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2367.14 via Frontend
 Transport; Thu, 17 Oct 2019 22:25:40 +0000
Authentication-Results: spf=pass (sender IP is 160.33.194.231)
 smtp.mailfrom=sony.com; mit.edu; dkim=none (message not signed)
 header.d=none;mit.edu; dmarc=pass action=none header.from=sony.com;
Received-SPF: Pass (protection.outlook.com: domain of sony.com designates
 160.33.194.231 as permitted sender) receiver=protection.outlook.com;
 client-ip=160.33.194.231; helo=usculsndmail04v.am.sony.com;
Received: from usculsndmail04v.am.sony.com (160.33.194.231) by
 BL2NAM02FT020.mail.protection.outlook.com (10.152.77.162) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2367.14 via Frontend Transport; Thu, 17 Oct 2019 22:25:40 +0000
Received: from usculsndmail11v.am.sony.com (usculsndmail11v.am.sony.com [146.215.230.102])
        by usculsndmail04v.am.sony.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id x9HMPdcL014154;
        Thu, 17 Oct 2019 22:25:39 GMT
Received: from USCULXHUB01V.am.sony.com (hub.cul.am.sony.com [146.215.231.15])
        by usculsndmail11v.am.sony.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id x9HMPccc004842;
        Thu, 17 Oct 2019 22:25:39 GMT
Received: from USCULXMSG01.am.sony.com ([fe80::b09d:6cb6:665e:d1b5]) by
 USCULXHUB01V.am.sony.com ([146.215.231.15]) with mapi id 14.03.0439.000; Thu,
 17 Oct 2019 18:25:38 -0400
From:   <Tim.Bird@sony.com>
To:     <tytso@mit.edu>, <skhan@linuxfoundation.org>
CC:     <brendanhiggins@google.com>, <yzaikin@google.com>,
        <linux-kselftest@vger.kernel.org>, <linux-ext4@vger.kernel.org>,
        <adilger.kernel@dilger.ca>, <kunit-dev@googlegroups.com>
Subject: RE: [PATCH linux-kselftest/test v2] ext4: add kunit test for
 decoding extended timestamps
Thread-Topic: [PATCH linux-kselftest/test v2] ext4: add kunit test for
 decoding extended timestamps
Thread-Index: AQHVfxQJt5KYyUfdIUCqjuPcGwlYBqdUYHYAgABUYYCAAMbxgIAANgMAgAhyYYCAABMAgIAA1OuAgABbSgA=
Date:   Thu, 17 Oct 2019 22:25:35 +0000
Message-ID: <ECADFF3FD767C149AD96A924E7EA6EAF977D0023@USCULXMSG01.am.sony.com>
References: <20191010023931.230475-1-yzaikin@google.com>
 <2f2ea7b0-f683-1cdd-f3f2-ecdf44cb4a97@linuxfoundation.org>
 <CAAXuY3qtSHENgy3S168_03ju_JwAucOAt5WEJGQ+pi5PfurP6g@mail.gmail.com>
 <CAFd5g46RcFV0FACuoF=jCSLzf7UFmEYn4gddaijUZ+zR_CFZBQ@mail.gmail.com>
 <20191011131902.GC16225@mit.edu>
 <CAFd5g45s1-=Z4JwJn4A1VDGu4oEGBisQ_0RFp4otUU3rKf1XpQ@mail.gmail.com>
 <1e6611e6-2fa6-6f7d-bc7f-0bc2243d9342@linuxfoundation.org>
 <20191017120833.GA25548@mit.edu>
In-Reply-To: <20191017120833.GA25548@mit.edu>
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
X-Forefront-Antispam-Report: CIP:160.33.194.231;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10019020)(396003)(376002)(39860400002)(136003)(346002)(13464003)(189003)(199004)(14444005)(26005)(336012)(70206006)(70586007)(33656002)(50466002)(102836004)(8746002)(5660300002)(8936002)(97756001)(76176011)(426003)(2906002)(7696005)(4326008)(54906003)(110136005)(3846002)(11346002)(356004)(305945005)(316002)(2171002)(8676002)(47776003)(37786003)(7736002)(186003)(66066001)(246002)(46406003)(55016002)(23726003)(486006)(6666004)(55846006)(229853002)(126002)(6116002)(106002)(86362001)(2876002)(6246003)(476003)(446003)(478600001)(5001870100001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR13MB1816;H:usculsndmail04v.am.sony.com;FPR:;SPF:Pass;LANG:en;PTR:mail04.sonyusa.com,mail.sonyusa.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 66fdbcb1-13e5-4eee-1812-08d75350f105
X-MS-TrafficTypeDiagnostic: CY4PR13MB1816:
X-Microsoft-Antispam-PRVS: <CY4PR13MB1816392FD0154E83703FDE11FD6D0@CY4PR13MB1816.namprd13.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-Forefront-PRVS: 01930B2BA8
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tGSB1M8wgUzG8nI+UpC2jfyRGP3He5/+MSVrWRA64aN8hGYCc+cdcUrjxZxYMwH2ENiXFKbsm9o7TJiUdsD2+s+J6ZLyd2712dtImK0kX0k8aXHUv+SU2FL26HgjV6562P5zTlq1iBdwtCBW8nwnDbaX0l31FVKbq1ELxbaXQt07sil8LNHNhAQlpsZ3IG27TeBXd0bzsdu1yV6FdC25350f88hlO4CYY5OTor4IcjXiKO+FI1rAZZEgVbmbuBHVnVoybPPYWi+IcUM7Z++JtEdF9ikpRze93IxSA2odhR/VTqTqdupjTVFBUIKVAoUdajZe386vIwekt3zVMX00LHKkG7DiLXpgkSqYZYRY4rO3sd08A+Pp/mi2g8ZUzN9PdnbHt/gKTU/BDLah7mMN4sXkedoJWxFmIiWGBupCDGA=
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2019 22:25:40.2046
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 66fdbcb1-13e5-4eee-1812-08d75350f105
X-MS-Exchange-CrossTenant-Id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=66c65d8a-9158-4521-a2d8-664963db48e4;Ip=[160.33.194.231];Helo=[usculsndmail04v.am.sony.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR13MB1816
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



> -----Original Message-----
> From: Theodore Y. Ts'o on October 17, 2019 2:09 AM
>=20
> On Wed, Oct 16, 2019 at 05:26:29PM -0600, Shuah Khan wrote:
> >
> > I don't really buy the argument that unit tests should be deterministic
> > Possibly, but I would opt for having the ability to feed test data.
>=20
> I strongly believe that unit tests should be deterministic.
> Non-deterministic tests are essentially fuzz tests.  And fuzz tests
> should be different from unit tests.

I'm not sure I have the entire context here, but I think deterministic
might not be the right word, or it might not capture the exact meaning
intended.

I think there are multiple issues here:
 1. Does the test enclose all its data, including working data and expected=
 results?
Or, does the test allow someone to provide working data?  This alternative
implies that either the some of testcases or the results might be different=
 depending on
the data that is provided.  IMHO the test would be deterministic if it alwa=
ys produced
the same results based on the same data inputs.  And if the input data was =
deterministic.
I would call this a data-driven test.

Since the results would be dependent on the data provided, the results
from tests using different data would not be comparable.  Essentially,
changing the input data changes the test so maybe it's best to consider
this a different test.  Like 'test-with-data-A' and 'test-with-data-B'.

2. Does the test automatically detect some attribute of the system, and adj=
ust
its operation based on that (does the test probe?)  This is actually quite =
common
if you include things like when a test requires root access to run.  Someti=
mes such tests,
when run without root privilege, run as many testcases as possible not as r=
oot, and skip
the testcases that require root.

In general, altering the test based on probed data is a form of data-driven=
 test,
except the data is not provided by the user.  Whether
this is deterministic in the sense of (1) depends on whether the data that
is probed is deterministic.  In the case or requiring root, then it should
not change from run to run (and it should probably be reflected in the char=
acterization
of the results).

Maybe neither of the above cases fall in the category of unit tests, but
they are not necessarily fuzzing tests.  IMHO a fuzzing test is one which r=
andomizes
the data for a data-driven test (hence using non-deterministic data).  Once=
 the fuzzer
has found a bug, and the data and code for a test is fixed into a reproduce=
r program,
then at that point it should be deterministic (modulo what I say about race=
 condition
tests below).

>=20
> We want unit tests to run quickly.  Fuzz tests need to be run for a
> large number of passes (perhaps hours) in order to be sure that we've
> hit any possible bad cases.  We want to be able to easily bisect fuzz
> tests --- preferably, automatically.  And any kind of flakey test is
> hell to bisect.
Agreed.
=20
> It's bad enough when a test is flakey because of the underlying code.
> But when a test is flakey because the test inputs are
> non-deterministic, it's even worse.
I very much agree on this as well.

I'm not sure how one classes a program that seeks to invoke a race conditio=
n.
This can take variable time, so in that sense it is not deterministic.   Bu=
t it should
produce the same result if the probabilities required for the race conditio=
n
to be hit are fulfilled.  Probably (see what I did there :-), one needs to =
take
a probabilistic approach to reproducing and bisecting such bugs.  The durat=
ion
or iterations required to reproduce the bug (to some confidence level) may
need to be included with the reproducer program.  I'm not sure if the syska=
ller
reproducers do this or not, or if they just run forever.  One I looked at r=
an forever.
But you would want to limit this in order to produce results with some conf=
idence
level (and not waste testing resources).

---
The reason I want get clarity on the issue of data-driven tests is that I t=
hink
data-driven tests and tests that probe are very much desirable.  This allow=
s a
test to be able to be more generalized and allows for specialization of the
test for more scenarios without re-coding it.
I'm not sure if this still qualifies as unit testing, but it's very useful =
as a means to
extend the value of a test.  We haven't trod into the mocking parts of kuni=
t,
but I'm hoping that it may be possible to have that be data-driven (dependi=
ng on
what's being mocked), to make it easier to test more things using the same =
code.

Finally, I think the issue of testing speed is orthogonal to whether a test=
 is self-enclosed
or data-driven.  Definitely fuzzers, which are experimenting with system in=
teraction
in a non-deterministic way, have speed problems.

Just my 2 cents.
 -- Tim
=20
