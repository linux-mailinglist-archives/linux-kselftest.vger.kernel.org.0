Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ED7ECB82EA
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Sep 2019 22:49:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732437AbfISUtY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 19 Sep 2019 16:49:24 -0400
Received: from mail-eopbgr800127.outbound.protection.outlook.com ([40.107.80.127]:21472
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727273AbfISUtY (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 19 Sep 2019 16:49:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RwlKEvnkiZwHsdxbz3ZRm4+eHFvtP/VUZ5OmWOlucQ5bP7uDMU/7EMzsXcApMEbnFDKTIunuCV6/coPhNqiDMOPu5LXv+frf3wTFZjFbthIsLICZW+jF9t4pGR9Gaw8OJCGFLdsUx5mdfhBhXdPqu1EYr/9YkD1f4oSmK2tmcsLlvfRrV6fpkVtmaaywaMero9E1qPgllcnIbY0jhqSsKUhX+SAlbnofZwGXMMSl58JS0deF/1OiB9nmpHeUHCTBkb4JjdkjU1PtIvJ0PF5pMf4RtVDrudbin5GxAYrrbYQRwXjbNFeEtFQbcdnLiK7ZjRi1AwNYPvUxdtZW2aWQJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u3sDGI9etxWwJF5cScGkxR8pWvdswFoExU97VO12/Bw=;
 b=Ht5OD37gSxGu6CYjy3VeTpmxF6H2SQbodiim02Lv45pt+pLw9Zk/NkBPypwLkxGVn5kULBfnfi0LjclAyhLRufsQwhBjU7nHQPG7zu2IhXJOemmxBASR5gmKRyi+dbxWLwrBrPIH70nlQPWHFm9sEHg3IDocafxOShaS3i5HilGdZLWH6orBipMStNVgVTrlZMrE3cy2roFOsWXyE2OqOHbI54X2W/FrfnWf7x8e/OC0FLlIzAe6HzWp7OR891nD9HXk/cFrFUDrA4NafTj9qe3RgQfsCp2HEtV/wmKLr/6C31Io8JKe9W4t7gQi7gBcbkC1lx21ZvLfzLI4AgtLIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 160.33.194.228) smtp.rcpttodomain=chromium.org smtp.mailfrom=sony.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=sony.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Sony.onmicrosoft.com;
 s=selector2-Sony-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u3sDGI9etxWwJF5cScGkxR8pWvdswFoExU97VO12/Bw=;
 b=rxQpuOKNjmkt7aCrOGlHXjRBX5O2adIaXsjUgRNJCvXqJGKkVqAoUls+F7Ofm8CvtYcml/WusjTiRRpdwBFnf907sbOx3V3JQgbjyYD1dpe5xYKV+nYExv4A7bf/ArgwztzJnjLN3m1mMXgYVq0KXX/qZrNFBp6xr/8qydfkxhI=
Received: from MWHPR13CA0018.namprd13.prod.outlook.com (2603:10b6:300:16::28)
 by BY5PR13MB3288.namprd13.prod.outlook.com (2603:10b6:a03:186::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2284.10; Thu, 19 Sep
 2019 20:49:20 +0000
Received: from BL2NAM02FT033.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::202) by MWHPR13CA0018.outlook.office365.com
 (2603:10b6:300:16::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2305.10 via Frontend
 Transport; Thu, 19 Sep 2019 20:49:20 +0000
Authentication-Results: spf=pass (sender IP is 160.33.194.228)
 smtp.mailfrom=sony.com; chromium.org; dkim=none (message not signed)
 header.d=none;chromium.org; dmarc=pass action=none header.from=sony.com;
Received-SPF: Pass (protection.outlook.com: domain of sony.com designates
 160.33.194.228 as permitted sender) receiver=protection.outlook.com;
 client-ip=160.33.194.228; helo=usculsndmail01v.am.sony.com;
Received: from usculsndmail01v.am.sony.com (160.33.194.228) by
 BL2NAM02FT033.mail.protection.outlook.com (10.152.77.163) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2263.17 via Frontend Transport; Thu, 19 Sep 2019 20:49:19 +0000
Received: from usculsndmail13v.am.sony.com (usculsndmail13v.am.sony.com [146.215.230.104])
        by usculsndmail01v.am.sony.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id x8JKnImw028313;
        Thu, 19 Sep 2019 20:49:18 GMT
Received: from USCULXHUB04V.am.sony.com (hub.bc.in.sel.sony.com [146.215.231.18])
        by usculsndmail13v.am.sony.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id x8JKnI4T007382;
        Thu, 19 Sep 2019 20:49:18 GMT
Received: from USCULXMSG01.am.sony.com ([fe80::b09d:6cb6:665e:d1b5]) by
 USCULXHUB04V.am.sony.com ([146.215.231.18]) with mapi id 14.03.0439.000; Thu,
 19 Sep 2019 16:49:17 -0400
From:   <Tim.Bird@sony.com>
To:     <Tim.Bird@sony.com>, <keescook@chromium.org>, <shuah@kernel.org>
CC:     <anders.roxell@linaro.org>, <alexandre.belloni@bootlin.com>,
        <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
Subject: RE: [PATCH] selftests/kselftest/runner.sh: Add 45 second timeout
 per test
Thread-Topic: [PATCH] selftests/kselftest/runner.sh: Add 45 second timeout
 per test
Thread-Index: AQHVbxUXsNEjsnpJkUeVTYYfiT5hwaczb7LQgAAJVtA=
Date:   Thu, 19 Sep 2019 20:49:14 +0000
Message-ID: <ECADFF3FD767C149AD96A924E7EA6EAF977BA66E@USCULXMSG01.am.sony.com>
References: <201909191102.97FA56072@keescook>
 <ECADFF3FD767C149AD96A924E7EA6EAF977BA636@USCULXMSG01.am.sony.com>
In-Reply-To: <ECADFF3FD767C149AD96A924E7EA6EAF977BA636@USCULXMSG01.am.sony.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [146.215.228.6]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:160.33.194.228;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10019020)(39860400002)(376002)(136003)(396003)(346002)(199004)(189003)(13464003)(51444003)(476003)(8936002)(8746002)(66066001)(47776003)(6666004)(336012)(97756001)(37786003)(5660300002)(246002)(356004)(70586007)(11346002)(50466002)(4326008)(86362001)(446003)(70206006)(426003)(14444005)(8676002)(305945005)(46406003)(6306002)(102836004)(33656002)(6246003)(2201001)(7736002)(106002)(7696005)(54906003)(110136005)(966005)(229853002)(316002)(126002)(478600001)(55016002)(55846006)(486006)(26005)(23726003)(186003)(6116002)(2906002)(3846002)(2876002)(76176011)(5001870100001);DIR:OUT;SFP:1102;SCL:1;SRVR:BY5PR13MB3288;H:usculsndmail01v.am.sony.com;FPR:;SPF:Pass;LANG:en;PTR:mail.sonyusa.com,mail01.sonyusa.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6abddc12-62e6-40b7-819b-08d73d42d7f4
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(4709080)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:BY5PR13MB3288;
X-MS-TrafficTypeDiagnostic: BY5PR13MB3288:
X-MS-Exchange-PUrlCount: 2
X-Microsoft-Antispam-PRVS: <BY5PR13MB328808F46F14FE0C0FED18A8FD890@BY5PR13MB3288.namprd13.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 016572D96D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: r1SlwfFP3Ig95qMOMg/+F8TSXwMIOh3eIVFQBbZ1VF7JCYBLSfIRxsH0J78IyKhbQXXELIdPGHrTBYTszhYx7vULgT3+ZyjpRjLkKMq6L0qlttyv2Vv5G1ZsYaDGXQVD6p/+QAkvf4dociIQeXNoucmT2EstPBs4Sw3+5zt0ddWCBP12XTnVTRl8wR1v8+D0jDiL3DpRSBV4azQ5NxeFo9Y3P5llK9sxvj7u1oUkkHoBA1E4oHrawmna+ZtHW1UsR9EjMfWZrrNz4Iy3POTL01NdB9nmYRh/3UBJdrm+ABYAi9HtNtufRwMeakJGpIkP2n1JLuGwU7aFOtQftV+VDQ6nZhUW32fVUp7w4y4xmg6C/R6r+rXfFilPl/WZ6y94Hr7BmlFIPt4Inb4L2Dj5wpxhFFm41EJVhzxtiDv2pyU=
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2019 20:49:19.6305
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6abddc12-62e6-40b7-819b-08d73d42d7f4
X-MS-Exchange-CrossTenant-Id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=66c65d8a-9158-4521-a2d8-664963db48e4;Ip=[160.33.194.228];Helo=[usculsndmail01v.am.sony.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR13MB3288
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



> -----Original Message-----
> From Tim.Bird@sony.com
>=20
> > -----Original Message-----
> > From: Kees Cook
> >
> > Commit a745f7af3cbd ("selftests/harness: Add 30 second timeout per
> > test") solves the problem of kselftest_harness.h-using binary tests
> > possibly hanging forever. However, scripts and other binaries can still
> > hang forever. This adds a global timeout to each test script run.
> >
> > To make this configurable (e.g. as needed in the "rtc" test case),
> > include a new per-test-directory "settings" file (similar to "config")
> > that can contain kselftest-specific settings. The first recognized fiel=
d
> > is "timeout".
>=20
> OK - this is quite interesting.  I have had on my to-do list an action
> item to propose the creation of a file (or a standard kerneldoc string)
> to hold CI-related meta-data (of which timeout is one example).
>=20
> What other meta-data did you have in mind?
>=20
> I would like (that Fuego, and probably other CI systems would like) to ha=
ve
>  access to data like test dependencies, descriptions, and results
> interpretation
> that would be beneficial for both CI systems (using them to control test
> invocations and scheduling), as
> well as users who are trying to interpret and handle the test results.
> So this concept is a very welcome addition to kselftest.
>=20
> LTP is in the process of adopting a new system for expressing and handlin=
g
> their test meta-data.
> See the discussion at:
> https://lists.yoctoproject.org/pipermail/automated-testing/2019-
> August/000471.html
> and the prototype implementation at:
> https://github.com/metan-ucw/ltp/tree/master/docparse
>=20
> I realize that that system is coupled pretty tightly to LTP, but conceptu=
ally
> some of the same type of information would be valuable for kselftest test=
s.
> One example of a specific field that would be handy is 'need_root'.
>=20
> It would be nice to avoid proliferation of such meta-data schemas (that i=
s
> field names), so maybe we can have a discussion about this before adoptin=
g
> something?
>=20
> Just FYI, I'm OK with the name 'timeout'.  I think that's pretty much
> universally
> used by all CI runners I'm aware of to indicate the test timeout value.  =
But
> before adopting other fields it would be good to start comparing notes
> and not invent a bunch of new field names for concepts that are already i=
n
> other systems.
>=20
> >
> > Additionally, this splits the reporting for timeouts into a specific
> > "TIMEOUT" not-ok (and adds exit code reporting in the remaining case).
> >
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> >  tools/testing/selftests/kselftest/runner.sh | 36 +++++++++++++++++++--
> >  tools/testing/selftests/rtc/settings        |  1 +
> >  2 files changed, 34 insertions(+), 3 deletions(-)
> >  create mode 100644 tools/testing/selftests/rtc/settings
> >
> > diff --git a/tools/testing/selftests/kselftest/runner.sh
> > b/tools/testing/selftests/kselftest/runner.sh
> > index 00c9020bdda8..84de7bc74f2c 100644
> > --- a/tools/testing/selftests/kselftest/runner.sh
> > +++ b/tools/testing/selftests/kselftest/runner.sh
> > @@ -3,9 +3,14 @@
> >  #
> >  # Runs a set of tests in a given subdirectory.
> >  export skip_rc=3D4
> > +export timeout_rc=3D124
> what are the units here?  I presume seconds?

Nevermind.  I misread this.  This is the return code from the 'timeout' pro=
gram, right?
 -- Tim

