Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB013B82D4
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Sep 2019 22:41:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729256AbfISUlv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 19 Sep 2019 16:41:51 -0400
Received: from mail-eopbgr690135.outbound.protection.outlook.com ([40.107.69.135]:1870
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728984AbfISUlv (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 19 Sep 2019 16:41:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oHY1FR38TfAsm+eDr93Pc7gDaG39ODQ7gUTm8ftK1YmOt4PNXmTW2mPJYZVeZKGdb4USdDO0YT0nKUOu57Bn3GdvtWZ6gJm5wtfQDsGfflH3e6kjzO5P8iifG8Va2U7J3NV1PgtejUg+ShfOlzgMT+D5bFiClK9+pHLVJeQaIi9rI8tjaSBgv5d5SSe+5k/hljsSR6YAxtPAozZflP0lmz1C4nvuMcHwjogw0Qn1aQ+WTbVyNB+i7Ta3cPofP1C8halLLGSRM2PL08Buz6GdGEZdTuIDFYIb7rXgmyACcOlpDr37c1GtB8A7mBnuMaSdUJe03aETNP/KYEZK6gcKcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xa/IBwGoxex2GWg2QMs7Xjh5M6MkBKkep5abjJ2NX0c=;
 b=myk7rNoqi2FuGyGYP+GJY3t4EKGczfVrDL0WtPQ01X0DVulG5KU0ergS6Wc0Xc7jRcgwUQhE5lOYseAjQMihiSmbChygKLtrWFLTRXzfqfhkBpUmSUhas/fOqgDF186ALZ7QDk03aqUd4EplBHi4EFHfU4RQyLKXIgdkbZMGE2yJ7Ewj3Z4ROKtxUzdYJfnFFdoRMYAabbeRS3XCSCx4jmg85C2SD/wsDkFohIt6UD43JK0hnfSRMOKAUqpID1MtJ+UQ79ICuktwBZPxWVnuaIUlXQRIANH2HefRi5uduWLKDQiPb2sk6Dm6MYwRRtP6MaeYH8dbW0b7lIN+euZcPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 160.33.194.230) smtp.rcpttodomain=chromium.org smtp.mailfrom=sony.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=sony.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Sony.onmicrosoft.com;
 s=selector2-Sony-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xa/IBwGoxex2GWg2QMs7Xjh5M6MkBKkep5abjJ2NX0c=;
 b=t3gm23hVMXXN6VcehBqdB5FZ0iSQM5k4hxY05WKeFH9e6VI1L8O51MmQJ/8oCR3Ugm3p/r6XEUiCXIG0djUikJXO/2EDtAFvX3nRf+NapflU++0jMfHp1pBfmGkT8OVJUJBSrfDPwXZ/BnXhxfRo3S4SAxQKsW3tyQyM7uT26iw=
Received: from MWHPR13CA0020.namprd13.prod.outlook.com (2603:10b6:300:16::30)
 by DM5PR13MB1179.namprd13.prod.outlook.com (2603:10b6:3:72::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2284.14; Thu, 19 Sep
 2019 20:41:48 +0000
Received: from SN1NAM02FT040.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::205) by MWHPR13CA0020.outlook.office365.com
 (2603:10b6:300:16::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2284.14 via Frontend
 Transport; Thu, 19 Sep 2019 20:41:48 +0000
Authentication-Results: spf=pass (sender IP is 160.33.194.230)
 smtp.mailfrom=sony.com; chromium.org; dkim=none (message not signed)
 header.d=none;chromium.org; dmarc=pass action=none header.from=sony.com;
Received-SPF: Pass (protection.outlook.com: domain of sony.com designates
 160.33.194.230 as permitted sender) receiver=protection.outlook.com;
 client-ip=160.33.194.230; helo=usculsndmail03v.am.sony.com;
Received: from usculsndmail03v.am.sony.com (160.33.194.230) by
 SN1NAM02FT040.mail.protection.outlook.com (10.152.72.195) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.17 via Frontend Transport; Thu, 19 Sep 2019 20:41:47 +0000
Received: from usculsndmail12v.am.sony.com (usculsndmail12v.am.sony.com [146.215.230.103])
        by usculsndmail03v.am.sony.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id x8JKfku8003963;
        Thu, 19 Sep 2019 20:41:46 GMT
Received: from USCULXHUB05V.am.sony.com (usculxhub05v.am.sony.com [146.215.231.43])
        by usculsndmail12v.am.sony.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id x8JKfkrO026077;
        Thu, 19 Sep 2019 20:41:46 GMT
Received: from USCULXMSG01.am.sony.com ([fe80::b09d:6cb6:665e:d1b5]) by
 USCULXHUB05V.am.sony.com ([146.215.231.43]) with mapi id 14.03.0439.000; Thu,
 19 Sep 2019 16:41:45 -0400
From:   <Tim.Bird@sony.com>
To:     <keescook@chromium.org>, <shuah@kernel.org>
CC:     <anders.roxell@linaro.org>, <alexandre.belloni@bootlin.com>,
        <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
Subject: RE: [PATCH] selftests/kselftest/runner.sh: Add 45 second timeout
 per test
Thread-Topic: [PATCH] selftests/kselftest/runner.sh: Add 45 second timeout
 per test
Thread-Index: AQHVbxUXsNEjsnpJkUeVTYYfiT5hwaczb7LQ
Date:   Thu, 19 Sep 2019 20:41:42 +0000
Message-ID: <ECADFF3FD767C149AD96A924E7EA6EAF977BA636@USCULXMSG01.am.sony.com>
References: <201909191102.97FA56072@keescook>
In-Reply-To: <201909191102.97FA56072@keescook>
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
X-Forefront-Antispam-Report: CIP:160.33.194.230;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10019020)(136003)(396003)(376002)(39860400002)(346002)(51444003)(13464003)(199004)(189003)(106002)(229853002)(8746002)(26005)(70206006)(6306002)(76176011)(54906003)(7696005)(2906002)(2876002)(70586007)(23726003)(6116002)(3846002)(8936002)(6246003)(316002)(102836004)(46406003)(126002)(446003)(336012)(37786003)(86362001)(5660300002)(6666004)(55016002)(356004)(186003)(476003)(11346002)(426003)(110136005)(33656002)(246002)(14444005)(486006)(4326008)(66066001)(8676002)(97756001)(7736002)(55846006)(966005)(478600001)(50466002)(47776003)(305945005)(5001870100001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR13MB1179;H:usculsndmail03v.am.sony.com;FPR:;SPF:Pass;LANG:en;PTR:mail.sonyusa.com,mail03.sonyusa.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bd409794-57be-4668-3c91-08d73d41cac8
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(4709080)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:DM5PR13MB1179;
X-MS-TrafficTypeDiagnostic: DM5PR13MB1179:
X-MS-Exchange-PUrlCount: 2
X-Microsoft-Antispam-PRVS: <DM5PR13MB1179BAE654FA99BBF807E61EFD890@DM5PR13MB1179.namprd13.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 016572D96D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: jeocI6OVlTh/ZhAkN/26p7OlTzSBojjIm3dMvZC9e2rlT+cpe1PdRTrnKWIJ/ZMONjs8kyWfZLfqFbtq1Ecw4DH7PLa8TB8cDsJ6XTSqDhSYU+5pZNG6TuRH8oUayQUeDjqL8vZy5u7YaiGp4WPx/M6ZmtC3Iw6RDY5avcbi0WRCdOdVzUO2lfXIOU7Z/xu9EsHMZdtDotglMayrAI0kFcJzveIUtJ2+h9PVX8d67hGI9Aw14l0M7PHAezMACOnX03hmw8RiWRaXe4mimo1/1fuVcCM83a+Aer21YPLjKEBBjNXqpCXWDOQ/8kKGPopf6llHsFXHNQAO42OS45DYL8NhvqzGXwUiWhf3WHrG5ogR0yP6ZLsLhJWL/jttrTC2wtJ0v6gjGfNoWK3Ej8oAMmavW8uQbiy6bMPWIPPogfw=
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2019 20:41:47.9602
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bd409794-57be-4668-3c91-08d73d41cac8
X-MS-Exchange-CrossTenant-Id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=66c65d8a-9158-4521-a2d8-664963db48e4;Ip=[160.33.194.230];Helo=[usculsndmail03v.am.sony.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR13MB1179
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



> -----Original Message-----
> From: Kees Cook
>=20
> Commit a745f7af3cbd ("selftests/harness: Add 30 second timeout per
> test") solves the problem of kselftest_harness.h-using binary tests
> possibly hanging forever. However, scripts and other binaries can still
> hang forever. This adds a global timeout to each test script run.
>=20
> To make this configurable (e.g. as needed in the "rtc" test case),
> include a new per-test-directory "settings" file (similar to "config")
> that can contain kselftest-specific settings. The first recognized field
> is "timeout".

OK - this is quite interesting.  I have had on my to-do list an action
item to propose the creation of a file (or a standard kerneldoc string)
to hold CI-related meta-data (of which timeout is one example).

What other meta-data did you have in mind?

I would like (that Fuego, and probably other CI systems would like) to have
 access to data like test dependencies, descriptions, and results interpret=
ation
that would be beneficial for both CI systems (using them to control test in=
vocations and scheduling), as
well as users who are trying to interpret and handle the test results.
So this concept is a very welcome addition to kselftest.

LTP is in the process of adopting a new system for expressing and handling =
their test meta-data.
See the discussion at:=20
https://lists.yoctoproject.org/pipermail/automated-testing/2019-August/0004=
71.html
and the prototype implementation at:
https://github.com/metan-ucw/ltp/tree/master/docparse

I realize that that system is coupled pretty tightly to LTP, but conceptual=
ly
some of the same type of information would be valuable for kselftest tests.
One example of a specific field that would be handy is 'need_root'.

It would be nice to avoid proliferation of such meta-data schemas (that is
field names), so maybe we can have a discussion about this before adopting
something?

Just FYI, I'm OK with the name 'timeout'.  I think that's pretty much unive=
rsally
used by all CI runners I'm aware of to indicate the test timeout value.  Bu=
t
before adopting other fields it would be good to start comparing notes
and not invent a bunch of new field names for concepts that are already in
other systems.

>=20
> Additionally, this splits the reporting for timeouts into a specific
> "TIMEOUT" not-ok (and adds exit code reporting in the remaining case).
>=20
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  tools/testing/selftests/kselftest/runner.sh | 36 +++++++++++++++++++--
>  tools/testing/selftests/rtc/settings        |  1 +
>  2 files changed, 34 insertions(+), 3 deletions(-)
>  create mode 100644 tools/testing/selftests/rtc/settings
>=20
> diff --git a/tools/testing/selftests/kselftest/runner.sh
> b/tools/testing/selftests/kselftest/runner.sh
> index 00c9020bdda8..84de7bc74f2c 100644
> --- a/tools/testing/selftests/kselftest/runner.sh
> +++ b/tools/testing/selftests/kselftest/runner.sh
> @@ -3,9 +3,14 @@
>  #
>  # Runs a set of tests in a given subdirectory.
>  export skip_rc=3D4
> +export timeout_rc=3D124
what are the units here?  I presume seconds?

>  export logfile=3D/dev/stdout
>  export per_test_logging=3D
>=20
> +# Defaults for "settings" file fields:
> +# "timeout" how many seconds to let each test run before failing.
> +export kselftest_default_timeout=3D45
> +
>  # There isn't a shell-agnostic way to find the path of a sourced file,
>  # so we must rely on BASE_DIR being set to find other tools.
>  if [ -z "$BASE_DIR" ]; then
> @@ -24,6 +29,16 @@ tap_prefix()
>  	fi
>  }
>=20
> +tap_timeout()
> +{
> +	# Make sure tests will time out if utility is available.
> +	if [ -x /usr/bin/timeout ] ; then
> +		/usr/bin/timeout "$kselftest_timeout" "$1"
> +	else
> +		"$1"
> +	fi
> +}
> +
>  run_one()
>  {
>  	DIR=3D"$1"
> @@ -32,6 +47,18 @@ run_one()
>=20
>  	BASENAME_TEST=3D$(basename $TEST)
>=20
> +	# Reset any "settings"-file variables.
> +	export kselftest_timeout=3D"$kselftest_default_timeout"
> +	# Load per-test-directory kselftest "settings" file.
> +	settings=3D"$BASE_DIR/$DIR/settings"
> +	if [ -r "$settings" ] ; then
> +		while read line ; do
> +			field=3D$(echo "$line" | cut -d=3D -f1)
> +			value=3D$(echo "$line" | cut -d=3D -f2-)
> +			eval "kselftest_$field"=3D"$value"
> +		done < "$settings"
> +	fi
> +
>  	TEST_HDR_MSG=3D"selftests: $DIR: $BASENAME_TEST"
>  	echo "# $TEST_HDR_MSG"
>  	if [ ! -x "$TEST" ]; then
> @@ -44,14 +71,17 @@ run_one()
>  		echo "not ok $test_num $TEST_HDR_MSG"
>  	else
>  		cd `dirname $TEST` > /dev/null
> -		(((((./$BASENAME_TEST 2>&1; echo $? >&3) |
> +		((((( tap_timeout ./$BASENAME_TEST 2>&1; echo $? >&3) |
>  			tap_prefix >&4) 3>&1) |
>  			(read xs; exit $xs)) 4>>"$logfile" &&
>  		echo "ok $test_num $TEST_HDR_MSG") ||
> -		(if [ $? -eq $skip_rc ]; then	\
> +		(rc=3D$?;	\
> +		if [ $rc -eq $skip_rc ]; then	\
>  			echo "not ok $test_num $TEST_HDR_MSG # SKIP"
> +		elif [ $rc -eq $timeout_rc ]; then \
> +			echo "not ok $test_num $TEST_HDR_MSG #
> TIMEOUT"
This is an extension to the TAP protocol (well, not strictly, since it is i=
n a comment),
but it should be documented.

I took an action item at the CKI hackfest to rigorously document the
details of how kselftest has extended (or augmented) TAP.  For example
our indentation mechanism for sub-tests.  You and I talked about this
a bit at Plumbers, but I'd like to follow up and add something
to Documentation/dev-tools/kselftest.rst so users and CI systems
can know how to appropriately parse and manage kselftest TAP output.

I'll start a separate thread on that when I get to documenting it,
but this would definitely be an addition to that documentation.

>  		else
> -			echo "not ok $test_num $TEST_HDR_MSG"
> +			echo "not ok $test_num $TEST_HDR_MSG #
> exit=3D$rc"
Is this also something new to kselftest's TAP output that should be documen=
ted?

>  		fi)
>  		cd - >/dev/null
>  	fi
> diff --git a/tools/testing/selftests/rtc/settings
> b/tools/testing/selftests/rtc/settings
> new file mode 100644
> index 000000000000..ba4d85f74cd6
> --- /dev/null
> +++ b/tools/testing/selftests/rtc/settings
> @@ -0,0 +1 @@
> +timeout=3D90

This is introducing a schema for meta-data naming, and a first field name.
I have no problem with this one, but it might be worth comparing it with
names expected by various kselftest-calling  CI systems.  I'll try to work
on this shortly and report back any issues.

Thanks for this.  I think this points us in an interesting new direction.
 -- Tim
