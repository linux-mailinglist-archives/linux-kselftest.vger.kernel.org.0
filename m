Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 54B76BEB1C
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Sep 2019 06:11:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726205AbfIZELl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 26 Sep 2019 00:11:41 -0400
Received: from mail-eopbgr790139.outbound.protection.outlook.com ([40.107.79.139]:33135
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725844AbfIZELl (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 26 Sep 2019 00:11:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dPYesCpXDpLIWXQrfuRb3PJDWdt5mPEmA6tMKcx/UBCLuYTeQmsAl+VQt37FCEibKMPma8ix0uqg5DKJXo/LTRXXg216dIAuNAPhS4unwovmM5k1hJFjeiS4K30G9Fd9NqYCdg2KJj4xVPC2ntCOaTY2u/F39fohj1vTyvAl7Z3f/De2IfZe2wNITGuIp0egt99ebk8wjoDzatC26eWWP1dHszWnLIYKxTGm9nhYWeTA6BRY1Wp7YaVyUpfHMRdhMiu8eCnhNkn4OkqsaFG+dt/cCvblMD1X+w5Zc+g6WQqO2EQTlzq15x3l4bPXJ6NSz3PwBVkYBkg+ybqAcTJI8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RvpJ6id9zB/KD0XmD5ps4l00iClVATBKSqq0A06xrio=;
 b=JIvy0YJS6+LZSyA/S6GRy5VrDvRjI2xf6iQ/SBxHG8lD7r000f0THl10qjwj5syRl1nCgjEo8tWRPOcZ/TyMJk0NNwaU8R0DqEWqTIqXc3wMQ+5YNBJnRkVUW6QxlPqw0swwBfuG1aJIV0mvX9seyx1RzprnmMvJIg4+EfPOLkZkT6xsasKtlnuKKpKHPKon29zSPPaxn5qRIB+K6NITeBqHzcfJFPZccrIvjvrYAhZYX/IAf8fdYfxxEN3yj/qZye21AXaVmzYOpN6jwg6jl8JWfpoGXVni6GMiVqp5mXNKC+PfWjza3KrXDMZ/BOiMKd+/+PRYFBlyrvMIf/kuhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 160.33.194.231) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=sony.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=sony.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Sony.onmicrosoft.com;
 s=selector2-Sony-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RvpJ6id9zB/KD0XmD5ps4l00iClVATBKSqq0A06xrio=;
 b=jbTHAY6se9J5JwKp/sXdo7rRAs4CR36ZsmF8q6uBYJIs8oG02/Kq/x5D5Q8U2jwdBYbQcvd6i1Sk8drtYGPS9CYXHPLkL37nvWovDyHmRiyd98sETLNUsd5wga+zMb1SZVdGO3G2fRVa+CNictYaiDbare2MhbZAVR64Wr+Ud+o=
Received: from BN6PR13CA0049.namprd13.prod.outlook.com (2603:10b6:404:11::11)
 by BN6PR1301MB2050.namprd13.prod.outlook.com (2603:10b6:405:33::34) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2305.12; Thu, 26 Sep
 2019 04:11:37 +0000
Received: from BL2NAM02FT022.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::204) by BN6PR13CA0049.outlook.office365.com
 (2603:10b6:404:11::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2305.11 via Frontend
 Transport; Thu, 26 Sep 2019 04:11:37 +0000
Authentication-Results: spf=pass (sender IP is 160.33.194.231)
 smtp.mailfrom=sony.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=sony.com;
Received-SPF: Pass (protection.outlook.com: domain of sony.com designates
 160.33.194.231 as permitted sender) receiver=protection.outlook.com;
 client-ip=160.33.194.231; helo=usculsndmail04v.am.sony.com;
Received: from usculsndmail04v.am.sony.com (160.33.194.231) by
 BL2NAM02FT022.mail.protection.outlook.com (10.152.77.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.25 via Frontend Transport; Thu, 26 Sep 2019 04:11:37 +0000
Received: from usculsndmail11v.am.sony.com (usculsndmail11v.am.sony.com [146.215.230.102])
        by usculsndmail04v.am.sony.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id x8Q4BbuB020540;
        Thu, 26 Sep 2019 04:11:37 GMT
Received: from USCULXHUB08V.am.sony.com (usculxhub08v.am.sony.com [146.215.231.169])
        by usculsndmail11v.am.sony.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id x8Q4BaHC001154;
        Thu, 26 Sep 2019 04:11:37 GMT
Received: from USCULXMSG01.am.sony.com ([fe80::b09d:6cb6:665e:d1b5]) by
 USCULXHUB08V.am.sony.com ([146.215.231.169]) with mapi id 14.03.0439.000;
 Thu, 26 Sep 2019 00:11:36 -0400
From:   <Tim.Bird@sony.com>
To:     <linux-kselftest@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>
Subject: bug in KBUILD_OUTPUT handling - for relative paths in kselftest
Thread-Topic: bug in KBUILD_OUTPUT handling - for relative paths in kselftest
Thread-Index: AdV0IGedtC8X/5q0RqG/+mkdxaV+Bw==
Date:   Thu, 26 Sep 2019 04:11:28 +0000
Message-ID: <ECADFF3FD767C149AD96A924E7EA6EAF977BD214@USCULXMSG01.am.sony.com>
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
X-Forefront-Antispam-Report: CIP:160.33.194.231;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10019020)(346002)(396003)(136003)(376002)(39860400002)(199004)(189003)(8936002)(8746002)(2351001)(246002)(23726003)(2876002)(450100002)(55846006)(8676002)(356004)(2906002)(6916009)(126002)(305945005)(186003)(86362001)(426003)(26005)(50466002)(70206006)(47776003)(7736002)(6666004)(102836004)(66066001)(486006)(336012)(478600001)(106002)(476003)(70586007)(3846002)(4326008)(55016002)(7696005)(46406003)(37786003)(5660300002)(6116002)(316002)(33656002)(97756001)(5001870100001);DIR:OUT;SFP:1102;SCL:1;SRVR:BN6PR1301MB2050;H:usculsndmail04v.am.sony.com;FPR:;SPF:Pass;LANG:en;PTR:mail04.sonyusa.com,mail.sonyusa.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 557af67c-d141-47cc-b283-08d74237a054
X-MS-TrafficTypeDiagnostic: BN6PR1301MB2050:
X-Microsoft-Antispam-PRVS: <BN6PR1301MB20501F1E0B8B41F07B29ED52FD860@BN6PR1301MB2050.namprd13.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 0172F0EF77
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bNkYKbGvIdDFXdwION8bbHjPohTxy6/i5ZjFc9MFtyjDyQPQDKNabpUKQWjU+PhWKsNquEs2eSsJBCt73GszTYQJyz4gT2NnqaP0rTKr/HmgL3AiNrDrynpjIzRnwot0BXjrODxmkk8csh72GIgfNpzCPpvOmWgCFHwSfx+moAwOlT5IEu732qbRSOlUFGHBy91W5oVRimFWuaZip7zVO9aN6mSgTClXpg8m0xPKT02pBYr9i29dT9e6tweJYhn0KfNL/Abo8MfVEj3lXiYi2HLzL38RnuHVDxD6DkRRToPXWnfjEeKsT4cqlDzchFfqt4AadwsL/Z6ujfNsVr1I5BghaiU8YnEsP7MYpg/NQtp0DgdLp/LZRtQ976JC+elQ/QHMpyOve/42V45nQAMYjXBqt15ZuCYFRCeni9pt5Ho=
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2019 04:11:37.6624
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 557af67c-d141-47cc-b283-08d74237a054
X-MS-Exchange-CrossTenant-Id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=66c65d8a-9158-4521-a2d8-664963db48e4;Ip=[160.33.194.231];Helo=[usculsndmail04v.am.sony.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1301MB2050
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

I found a bug in kselftest KBUILD_OUTPUT handling.

The following works:
$ cd /home/tbird/work/linux
$ export KBUILD_OUTPUT=3D/home/tbird/work/kbuild
$ yes '' | make localmodconfig
$ make TARGETS=3Dsize kselftest

But this doesn't work:
$ cd /home/tbird/work/linux
$ export KBUILD_OUTPUT=3D../kbuild
$ yes '' | make localmodconfig
$ make TARGETS=3Dsize kselftest

I see the following:
make[1]: Entering directory '/home/tbird/work/kbuild'
 make --no-builtin-rules INSTALL_HDR_PATH=3D$BUILD/usr \
 	ARCH=3Dx86 -C ../../.. headers_install
   INSTALL ../kbuild/kselftest/usr/include
 gcc -static -ffreestanding -nostartfiles -s    get_size.c  -o ../kbuild/ks=
elftest/size/get_size
   /usr/bin/ld: cannot open output file ../kbuild/kselftest/size/get_size: =
No such file or directory
 collect2: error: ld returned 1 exit status
   ../lib.mk:138: recipe for target '../kbuild/kselftest/size/get_size' fai=
led
 make[3]: *** [../kbuild/kselftest/size/get_size] Error 1
 Makefile:136: recipe for target 'all' failed
 make[2]: *** [all] Error 2
 /home/tbird/work/linux/Makefile:1240: recipe for target 'kselftest' failed
 make[1]: *** [kselftest] Error 2
 make[1]: Leaving directory '/home/tbird/work/kbuild'
 Makefile:179: recipe for target 'sub-make' failed
 make: *** [sub-make] Error 2

This is due to the relative path for KBUILD_OUTPUT being handled incorrectl=
y (I believe)
in tools/testing/selftests/Makefile.

There are these lines in the Makefile, which are responsible for creating t=
he output
directory:
    BUILD_TARGET=3D$$BUILD/$$TARGET
    mkdir $$BUILD_TARGET -p

But these are executed from working directory tools/testing/selftests,
so the 'size' directory gets created at tools/testing/kbuild/kselftest/size=
,
instead of /home/tbird/work/kbuild/kselftest/size.

I can add some code to the Makefile to change the assignment of the
variable BUILD, so that if it is a relative path it is relative to $(top_sr=
cdir)
instead of the current directory.   But I wanted to check and make sure tha=
t
I'm not  breaking anyone else's workflow.

I'm not sure what the expectation would be for someone who did this:
 $ export KBUILD_OUTPUT=3D../kbuild ; make  -C tools/testing/selftests run_=
tests

But I assume if someone is running the kernel's 'make' from the top-level
kernel source directory, and they have a relative KBUILD_OUTPUT directory,
then they want that output directory to be relative to the top-level direct=
ory
and not somewhere else.

Should I just code up something for review?

I use relative KBUILD_OUTPUT paths for a number of my kernel build scripts,
and right now these are incompatible with kselftests.

Thanks,
 -- Tim

