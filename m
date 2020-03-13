Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 31EAB185187
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Mar 2020 23:14:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726543AbgCMWOL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 13 Mar 2020 18:14:11 -0400
Received: from mail-mw2nam10on2134.outbound.protection.outlook.com ([40.107.94.134]:38881
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726534AbgCMWOL (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 13 Mar 2020 18:14:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NSTu4N5eJUSqn1d3hcLan7H2TOzxVcAHV+NZc4YZA6eh+rPb6YInd6OAkQWDjC0p3tjySb/h2NKGsP7Z3mfISZZPa4d6ScMDZXVgxyEc7bkjELMEN0+/DNhjpkBYMB+fHhAPUL0szlCbNwVmP8kxDpCpfpck7hWqLwbtUIMw22ibB7XpVpcbTaT659TQnBWZFBo1rm0Te0PQoQLJbz/NBv74+L13CD3SmssYV+63oLRUDNIk+J6ZaAki7EA4hmnu5U1YunmV2yGwQGW5QTh/sVsKFB1nkoxjeuxjhSByAa9uhgZnIerJeH7Djxu0v+aMY6lX8Q7DmI3kYTf6GxfGaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nuLXJbTKAo2HH6842/Z9yAyAx0RrH3bYr4WSdgTKwbc=;
 b=Df1GHX2agNvwVf6gPFQtha8rZ1/9Yx+wYFkhSJp5gFBVmQQIWtZKmNlkDuVRDIc1gxrXuuUlxmMpk3+q+LcTR36H+yzwkVTuxMYJ8XiUB9ckzySyeVh8zKoskLlgRc+/TkIKdNnycabKBGQkM0T8O2VLih5tnXaz5NIMR+ME9Me/tbGy5E5yNqkDaL1LUiIyHTlSpvePHy9Dscy0htVuMM9dk2vVPTb4SX0l0d5GrNmHYJnqvPyCKXenEHtoXMIZaqrY3R3ClbLN1o7+12skRNYKZNt8QFKCroK5ALSBEnumcWfN6SNuDSw7njaixlRRUBvlZQ7dvCcY8OaJzZEJbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Sony.onmicrosoft.com;
 s=selector2-Sony-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nuLXJbTKAo2HH6842/Z9yAyAx0RrH3bYr4WSdgTKwbc=;
 b=PLoDr7/vu2ss8Vsffcu2fuJYRUjfc4YAkcLnjt0t6jSUVwUC1fo5dIvRjiScIhuhQN+jMe5ToeRhxSVlP/CyAnptRYQyoIQjoMC828yTlWovxq3APLbGzDvmMcDdWCpuQFbXhtr3LV1DxONNo8omcSDkv+K2aNztQbaz2mRGDjw=
Received: from MWHPR13MB0895.namprd13.prod.outlook.com (2603:10b6:300:2::27)
 by MWHPR13MB1294.namprd13.prod.outlook.com (2603:10b6:300:9b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.5; Fri, 13 Mar
 2020 22:14:07 +0000
Received: from MWHPR13MB0895.namprd13.prod.outlook.com
 ([fe80::308b:ce00:680a:333e]) by MWHPR13MB0895.namprd13.prod.outlook.com
 ([fe80::308b:ce00:680a:333e%6]) with mapi id 15.20.2835.003; Fri, 13 Mar 2020
 22:14:06 +0000
From:   "Bird, Tim" <Tim.Bird@sony.com>
To:     Shuah Khan <shuahkh@osg.samsung.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: cross-compiling vm, confusion over output directory
Thread-Topic: cross-compiling vm, confusion over output directory
Thread-Index: AdX5gBczKI3kpl+jT9616UrKn+d3vg==
Date:   Fri, 13 Mar 2020 22:14:05 +0000
Message-ID: <MWHPR13MB0895E9C11DB4E72158445944FDFA0@MWHPR13MB0895.namprd13.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tim.Bird@sony.com; 
x-originating-ip: [160.33.195.21]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: dcff9d1d-049e-470e-fb9f-08d7c79bd878
x-ms-traffictypediagnostic: MWHPR13MB1294:
x-microsoft-antispam-prvs: <MWHPR13MB1294DD016D062616114672CAFDFA0@MWHPR13MB1294.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 034119E4F6
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(346002)(376002)(366004)(396003)(39860400002)(136003)(199004)(6506007)(8676002)(26005)(316002)(81166006)(8936002)(81156014)(7696005)(110136005)(86362001)(2906002)(76116006)(64756008)(66946007)(66556008)(66446008)(66476007)(33656002)(71200400001)(52536014)(5660300002)(55016002)(186003)(478600001)(9686003)(4326008);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR13MB1294;H:MWHPR13MB0895.namprd13.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
received-spf: None (protection.outlook.com: sony.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4y6ieppL5SosIe4+k1NRUSrYkFAyHwhcXmuE3KmXBluHaifZkdlxuEDDTGehVLNIQIJ6y8J4ZjGoGqDN2fyrzOkmnlEoGanEuylWqhHpdVs/foWQ6x+QGHexMmlRZ2Ot18XRHveMUGRizGYnFUSIe634KNUkL8QjyMPcmHEFux6RiGOs/CWQhhKT3B9rp1Lafp5nIcUGZSHZnIoW6Ep8VXnHgXRJSi+DOr8yVKNBIfdZ8QOwRw/wmt8DH/nzpig+KMSxxDuw3nOd95oWxp4+8tkNJ3xlAe7KVROr0hHSGknFEFpzZFurgvcVUKFtvt5EiWKt+XVECzVi8ZmbSFMzIF/7pNsJIBQYBYzuz2MUJjMaH8Zl5g2fshev59fCijbwqE9Hzk+JN3GkPGi8pQcIuKrdFg8RoMqdM/9zDNWvsrLmAOh4yrPT5yyke/8I1a5C
x-ms-exchange-antispam-messagedata: IdHA/Jft8vyXCg3zhgYqL1XlCA8fF/rhsSSwnCnvS0ZV6A915QIA2+HlRZ7StrJvZ5a+X9HeP6S3LzrukVhOFMthskc8e4nOGyX3ga/J2sEkpfqvBK16b4E3EFuwMI+5QOTJAFTGaZFdpzASiWfGWA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dcff9d1d-049e-470e-fb9f-08d7c79bd878
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2020 22:14:05.5353
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HBkABwmbpNnq6RY0l44LLXyES78El8J9iZs7WBDjiDexnAtkt+PMfaOS7/FHxjF6zjtO9enI7pQ2YxQEDYaX6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR13MB1294
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

I was working on fixing the cross-compilation for the selftests/vm tests.
Currently, there are two issues in my testing:

1) problem: required library missing from some cross-compile environments:
tools/testing/selftests/vm/mlock-random-test.c requires libcap
be installed.  The target line for mlock-random-test in
tools/testing/selftests/vm/Makefile looks like this:

$(OUTPUT)/mlock-random-test: LDLIBS +=3D -lcap

and mlock-random-test.c has this include line:
#include <sys/capability.h>

this is confusing, since this is different from the header file
linux/capability.h.  It is associated with the capability library (libcap)
and not the kernel.  In any event, on some distros and in some
cross-compile SDKs the package containing these files is not installed
by default.

Once this library is installed, things progress farther.  Using an Ubuntu
system, you can install the cross version of this library (for arm64) by do=
ing:
$ sudo apt install libcap-dev:arm64

1) solution:
I would like to add some meta-data about this build dependency, by putting
something in the settings file as a hint to CI build systems.  Specifically=
, I'd like to
create the file 'tools/testing/selftests/vm/settings', with the content:
NEED_LIB=3Dcap

We already use settings for other meta-data about a test (right now, just a
non-default timeout value), but I don't want to create a new file or syntax
for this build dependency data.

Let me know what you think.

I may follow up with some script in the kernel source tree to check these
dependencies, independent of any CI system.  I have such a script in Fuego
that I could submit, but it would need some work to fit into the kernel bui=
ld
flow for kselftest.  The goal would be to provide a nicely formatted warnin=
g,
with a recommendation for a package install.  But that's more work than
I think is needed right now just to let developers know there's a build dep=
endency
here.

2) problem: reference to source-relative header file
the Makefile for vm uses a relative path for include directories.
Specifically, it has the line:
CFLAGS =3D -Wall -I ../../../../../usr/include $(EXTRA_CFLAGS)

I believe this needs to reference kernel include files from the
output directory, not the source directory.

With the relative include directory path, the program userfaultfd.c
gets compilation error like this:

userfaultfd.c:267:21: error: 'UFFD_API_RANGE_IOCTLS_BASIC' undeclared here =
(not in a function)
  .expected_ioctls =3D UFFD_API_RANGE_IOCTLS_BASIC,
                     ^
userfaultfd.c: In function 'uffd_poll_thread':
userfaultfd.c:529:8: error: 'UFFD_EVENT_FORK' undeclared (first use in this=
 function)
   case UFFD_EVENT_FORK:
        ^
userfaultfd.c:529:8: note: each undeclared identifier is reported only once=
 for each function it appears in
userfaultfd.c:531:18: error: 'union <anonymous>' has no member named 'fork'
    uffd =3D msg.arg.fork.ufd;
                  ^

2) incomplete solution:
I originally changed this line to read:
CFLAGS =3D -Wall -I $(KBUILD_OUTPUT)/usr/include $(EXTRA_CFLAGS)

This works when the output directory is specified using KBUILD_OUTPUT,
but not when the output directory is specified using O=3D
I'm not sure what happens when the output directory is specified
with a non-source-tree current working directory.

In any event, while researching a proper solution to this, I found
the following in tools/testing/selftests/Makefile:

If compiling with ifneq ($(O),)
    BUILD :=3D $(O)
else
    ifneq ($(KBUILD_OUTPUT),)
        BUILD :=3D $(KBUILD_OUTPUT)/kselftest
    else
        BUILD :=3D $(shell pwd)
        DEFAULT_INSTALL_HDR_PATH :=3D 1
    endif
endif

This doesn't seem right.  It looks like the selftests Makefile treats a dir=
ectory
passed in using O=3D different from one specified using KBUILD_OUTPUT
or the current working directory.
In the KBUILD_OUTPUT case, you get an extra 'kselftest' directory layer
that you don't get for the other two.

In contrast, the kernel top-level Makefile has this:
ifeq ("$(origin O)", "command line")
  KBUILD_OUTPUT :=3D $(O)
endif
(and from then on, the top-level Makefile appears to only use KBUILD_OUTPUT=
)

This makes it look like the rest of the kernel build system treats O=3D and=
 KBUILD_OUTPUT
identically.

Am I missing something, or is there a flaw in the O=3D/KBUILD_OUTPUT handli=
ng in
kselftest?  Please let me know and I'll try to work out an appropriate fix =
for
cross-compiling the vm tests.
 -- Tim

