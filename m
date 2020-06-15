Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94A3F1F9EC4
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Jun 2020 19:46:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731181AbgFORpe (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 15 Jun 2020 13:45:34 -0400
Received: from mail-eopbgr770103.outbound.protection.outlook.com ([40.107.77.103]:32740
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729124AbgFORpd (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 15 Jun 2020 13:45:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lAj9A4MmAMwEEo379rUxo6PG35Wl8D2JnXvO89vBAA8mN58p/pUDiNcLd1RSxWhRGEQlRiNocYAUUhxreoTMWDUuA1sPN4D8uquJePGye2CCIwTWqctIknbPLPEBh/NzoSPXaHARwKn0Q8VOuxEN/W0D7CjFlLII21Wms7NpMG5HwzJlLoBox/5XN2ia3Khx0dniCcUXMGo3E4E6RU4qnrjc2X17nBvUfTcAC+nRh+7EXmxS26ADItc490jQVRpWEvUkJKixAZzdMwjxMpodi0sjO6YfOiaXM1wAAwB4j1RgdhfrWX99fzO/jVGyJxOkFGQbvt3xi1BYPl3AEK2vCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a2AltS6YTGT+kxv2dEeBIslynwx3ep2taUBDKYYBZdk=;
 b=a6rUq7AGPf0jRwAw8HIARBC0+c9REhUt1TTQjMeIMdOFQ4WuB9O48PPgRy+ZDN14bRKB3N4l7QEJ8plCXq5gO843r12a5TpHT+UmX015Y1c4z1tT3eox2MaldQPLLZrA4tdtuQpKnc73/cLM7uSAujctLZ+yMKowW5SNIkC/QYDgIV7SisbsHWBt5YxoGqHSWFg0lvc8cTvLa7KZZySOWtJQ8KH3AmsalULcWN/jK0X24Bt+hFPbpylgzPpplKYGIRrhPax6I8AZR0GgNngZBBXZ8TTHmAL17+GoMZRgRmOXTfD8A/cyXXrh1fheDduYx+kbjydNLiQNwlz8S6sadQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Sony.onmicrosoft.com;
 s=selector2-Sony-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a2AltS6YTGT+kxv2dEeBIslynwx3ep2taUBDKYYBZdk=;
 b=ZhtwHsEo6jEnExoBhQf18lrx4ilNizNf98IQ3H7w3nq+h/M/Ste+7bLAfgsc5TbcNM6Wo7IBxadyo7QgYdQSckmH/9x5zIDErshIcjksPbzaE1Q14ZJStrZ+3VVSdvpTjo0OT9vQEdFlfSbDPwwq5X+qGklutqocsIHVQYpnQd4=
Received: from CY4PR13MB1175.namprd13.prod.outlook.com (2603:10b6:903:40::23)
 by CY4PR1301MB2101.namprd13.prod.outlook.com (2603:10b6:910:4a::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.10; Mon, 15 Jun
 2020 17:45:28 +0000
Received: from CY4PR13MB1175.namprd13.prod.outlook.com
 ([fe80::e486:a4f:7430:536e]) by CY4PR13MB1175.namprd13.prod.outlook.com
 ([fe80::e486:a4f:7430:536e%9]) with mapi id 15.20.3109.018; Mon, 15 Jun 2020
 17:45:28 +0000
From:   "Bird, Tim" <Tim.Bird@sony.com>
To:     Kees Cook <keescook@chromium.org>, David Gow <davidgow@google.com>
CC:     Vitor Massaru Iha <vitor@massaru.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        "linux-kernel-mentees@lists.linuxfoundation.org" 
        <linux-kernel-mentees@lists.linuxfoundation.org>,
        "linux@rasmusvillemoes.dk" <linux@rasmusvillemoes.dk>
Subject: RE: RFC - kernel selftest result documentation (KTAP)
Thread-Topic: RFC - kernel selftest result documentation (KTAP)
Thread-Index: AdY/UfZiI2pZQBRwRN+1JBazpeVQogDJiXGAADDVTaA=
Date:   Mon, 15 Jun 2020 17:45:28 +0000
Message-ID: <CY4PR13MB11752A5C1586F3D597C52679FD9C0@CY4PR13MB1175.namprd13.prod.outlook.com>
References: <CY4PR13MB1175B804E31E502221BC8163FD830@CY4PR13MB1175.namprd13.prod.outlook.com>
 <202006141050.5512F17@keescook>
In-Reply-To: <202006141050.5512F17@keescook>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: chromium.org; dkim=none (message not signed)
 header.d=none;chromium.org; dmarc=none action=none header.from=sony.com;
x-originating-ip: [160.33.195.20]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4cdb404a-7ae7-41b4-e3e0-08d81153e458
x-ms-traffictypediagnostic: CY4PR1301MB2101:
x-microsoft-antispam-prvs: <CY4PR1301MB21010FC58356BF1BD1AAF6F4FD9C0@CY4PR1301MB2101.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 04359FAD81
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wGr05uSFzHaUiBIm7MmRT0N4p/5o0KCXZwVh22GRyi9mgo6ClpAhzMZhWMCuC7uHcvGHUJweCd+JA9WBQ3j89p8QVZgC/zNARMf2QIDvxLKhpfZFUcbJHyq+N1us9vQ9yz+ju5kHn5m/4wp9xbzZwh7Wo3NlGyDwQhzNqiPI1IiQHd1Z1NsEvIbI7PTJrQIP0K/AJpb9X/eGuEGj57AVTQrn3jbgsBFYXH5lXrHopzERQbB3e5Ep9cUxvCj5w1Tl2hov69mL9p6zO5Whh6BlbBJUm4PY+2hUcKrnHAYGLbFYqRNvKD9r1K5BPt84wpJ94f+6Fo8vhuZQjY/NQqTidnqyGhNfB02ZpbXETo506aj5WlfUZ6+RX1fuHUwUAzdkRZCdakah1grQnYPKbM3MGg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR13MB1175.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(346002)(136003)(39860400002)(366004)(376002)(186003)(71200400001)(478600001)(7416002)(83380400001)(7696005)(52536014)(110136005)(54906003)(45080400002)(26005)(316002)(966005)(5660300002)(53546011)(6506007)(9686003)(55016002)(8676002)(8936002)(33656002)(76116006)(66476007)(66446008)(64756008)(86362001)(4326008)(66946007)(66556008)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 0BRWS9JHvp/86qEBNrfhdG6wjnvEKwVVBFL1NxdZenP6iTCnEkfj0nAFF535II0HO01bZYY0e2CatCpQ4OZyEzeD7CH8Tny2FfZ+Hv6cWmqKlaivaKRkOPOMAlJ0s4+trXsO1Ei+XmLdDj6EJMchNNVdKijCec6bjf5GCz9SsKeosMFiObgk9vSphua9zyWVH3xmcLRP7YgOjX3cSjd/86gzTBcBuhYoyhdalsPg9z6BQcDevpTEKFgvVdcZRfS6UTWqbexzjxKovwbtTuPq0fnyc43zMSA1jEFF360AIUitdf19zRbDQKsgadizxQsPYrbWKzuQzHAPucDMKv7K3zyeZZrLD4Sd5D+R4fabcw9tgEpUwFtGkKSak1Rehul7nytNsZBWxMBHk/V32jqoEHRH8bAhbDvlzzi1MxWS2Sq5fQifJw4AdJpofhOwTNCyMeaDxLZMkFMzxHJOjrAUXnlcRNpzJDWe5pnUibm11lo=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cdb404a-7ae7-41b4-e3e0-08d81153e458
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2020 17:45:28.2394
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wGjswcCdTMR9ZXI9yWMCzie7MXseYkJ4ujvjWVq4kB0IMKQ5o8OTZSWCmHBXR4xJgMWMNsTQQtb/p2XV3A0EDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1301MB2101
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



> -----Original Message-----
> From: Kees Cook
> Sent: Sunday, June 14, 2020 12:18 PM
> To: David Gow <davidgow@google.com>
> Cc: Vitor Massaru Iha <vitor@massaru.org>; KUnit Development <kunit-dev@g=
ooglegroups.com>; Shuah Khan
> <skhan@linuxfoundation.org>; open list:KERNEL SELFTEST FRAMEWORK <linux-k=
selftest@vger.kernel.org>; Linux Kernel Mailing List
> <linux-kernel@vger.kernel.org>; Brendan Higgins <brendanhiggins@google.co=
m>; linux-kernel-mentees@lists.linuxfoundation.org;
> linux@rasmusvillemoes.dk
> Subject: Re: RFC - kernel selftest result documentation (KTAP)
>=20
> On Sat, Jun 13, 2020 at 02:51:17PM +0800, David Gow wrote:
> > On Sat, Jun 13, 2020 at 6:36 AM Kees Cook <keescook@chromium.org> wrote=
:
> > > Regarding output:
> > >
> > > [   36.611358] TAP version 14
> > > [   36.611953]     # Subtest: overflow
> > > [   36.611954]     1..3
> > > ...
> > > [   36.622914]     # overflow_calculation_test: s64: 21 arithmetic te=
sts
> > > [   36.624020]     ok 1 - overflow_calculation_test
> > > ...
> > > [   36.731096]     # overflow_shift_test: ok: (s64)(0 << 63) =3D=3D 0
> > > [   36.731840]     ok 2 - overflow_shift_test
> > > ...
> > > [   36.750294] kunit_try_catch: vmalloc: allocation failure: 18446744=
073709551615 bytes, mode:0xcc0(GFP_KERNEL),
> nodemask=3D(null),cpuset=3D/,mems_allowed=3D0
> > > ...
> > > [   36.805350]     # overflow_allocation_test: devm_kzalloc detected =
saturation
> > > [   36.807763]     ok 3 - overflow_allocation_test
> > > [   36.807765] ok 1 - overflow
> > >
> > > A few things here....
> >
> > Tim Bird has just sent out an RFC for a "KTAP" specification, which
> > we'll hope to support in KUnit:
>=20
> Ah-ha! Thanks for the heads-up. :)
>=20
> > https://lore.kernel.org/linux-
> kselftest/CY4PR13MB1175B804E31E502221BC8163FD830@CY4PR13MB1175.namprd13.p=
rod.outlook.com/T/#u
>=20
> *thread split/merge*
>=20
> This is coming from:
> https://lore.kernel.org/linux-kselftest/CABVgOSnofuJQ_fiCL-8KdKezg3Hnqk3A=
+X509c4YP_toKeBVBg@mail.gmail.com/
> But I'm attempting a thread jump... ;)
>=20
> > That's probably where we'll end up trying to hash out exactly what
> > this format should be. Fortunately, I don't think any of these will
> > require any per-test work, just changes to the KUnit implementation.
>=20
> Yup, good.
>=20
> > > - On the outer test report, there is no "plan" line (I was expecting
> > >   "1..1"). Technically it's optional, but it seems like the informati=
on
> > >   is available. :)
> >
> > There's work underway to support this, but it's hit a few minor snags:
> > https://lkml.org/lkml/2020/2/27/2155
>=20
> Okay, cool. It's not critical, I don't think.
>=20
> > > - The subtest should have its own "TAP version 14" line, and it shoul=
d
> > >   be using the diagnostic line prefix for the top-level test (this is
> > >   what kselftest is doing).
> >
> > Alas, TAP itself hasn't standardised subtests. Personally, I think it
> > doesn't fundamentally matter which way we do this (I actually prefer
> > the way we're doing it currently slightly), but converging with what
> > kselftest does would be ideal.
>=20
> I see the KTAP RFC doesn't discuss subtests at all, but kselftest actuall=
y
> already handles subtests. I strongly feel that line-start formatting is
> the correct way to deal with this, with each subtest having it's own
> self-contained KTAP. This allows for several important features:
>=20
> - the subtest, run on its own, needs no knowledge about its execution
>   environment: it simply emits its standard KTAP output.
>=20
> - subtest output can be externally parsed separably, without any
>   knowledge or parsing of the enclosing test.

I agree with both of these, but will save additional comments for the
thread on my KTAP doc RFC.

>=20
> For example, with my recent series[1], "make -C seccomp run_tests"
> produces:
>=20
> TAP version 13
> 1..2
> # selftests: seccomp: seccomp_bpf
> # TAP version 13
> # 1..77
> # # Starting 77 tests from 6 test cases.
> # #  RUN           global.mode_strict_support ...
> # #            OK  global.mode_strict_support
> # ok 1 global.mode_strict_support
> ...
> # ok 77 TSYNC.two_siblings_not_under_filter
> # # FAILED: 73 / 77 tests passed.
> # # Totals: pass:72 fail:4 xfail:1 xpass:0 skip:0 error:0
> not ok 1 selftests: seccomp: seccomp_bpf # exit=3D1
> # selftests: seccomp: seccomp_benchmark
> #
> not ok 2 selftests: seccomp: seccomp_benchmark # TIMEOUT
>=20
> > > - There is no way to distinguish top-level TAP output from kernel log
> > >   lines. I think we should stick with the existing marker, which is
> > >   "# ", so that kernel output has no way to be interpreted as TAP
> > >   details -- unless it intentionally starts adding "#"s. ;)
> >
> > At the moment, we're doing this in KUnit tool by stripping anything
> > before "TAP version 14" (e.g., the timestamp), and then only incuding
> > lines which parse correctly (are a test plan, result, or a diagnostic
> > line beginning with '#').
> > This has worked pretty well thus far, and we do have the ability to
> > get results from debugfs instead of the kernel log, which won't have
> > the same problems.
> >
> > It's worth considering, though, particularly since our parser should
> > handle this anyway without any changes.
>=20
> For the KTAP parsing, actually think it's very important to include
> kernel log lines in the test output (as diagnostic lines), since they
> are "unexpected" (they fail to have the correct indentation) and may
> provide additional context for test failures when reading log files.
> (As in the "vmalloc: allocation failure" line in the quoted section
> above, to be included as a diagnostic line for test #3.)
>=20
> > > - There is no summary line (to help humans). For example, the kselfte=
st
> > >   API produces a final pass/fail report.
> >
> > Currently, we're relying on the kunit.py script to produce this, but
> > it shouldn't be impossible to add to the kernel, particularly once the
> > "KUnit Executor" changes mentioned above land.
>=20
> Cool. Yeah, it's not required, but I think there are two use cases:
> humans running a single test (where is a summary is valuable, especially
> for long tests that scroll off the screen), and automation (where it can
> ignore the summary, as it will produce its own in a regularized fashion).
>=20
> > > Taken together, I was expecting the output to be:
> > >
> > > [   36.611358] # TAP version 14
> > > [   36.611953] # 1..1
> > > [   36.611958] # # TAP version 14
> > > [   36.611954] # # 1..3
> > > ...
> > > [   36.622914] # # # overflow_calculation_test: s64: 21 arithmetic te=
sts
> > > [   36.624020] # # ok 1 - overflow_calculation_test
> > > ...
> > > [   36.731096] # # # overflow_shift_test: ok: (s64)(0 << 63) =3D=3D 0
> > > [   36.731840] # # ok 2 - overflow_shift_test
> > > ...
> > > [   36.750294] kunit_try_catch: vmalloc: allocation failure: 18446744=
073709551615 bytes, mode:0xcc0(GFP_KERNEL),
> nodemask=3D(null),cpuset=3D/,mems_allowed=3D0
> > > ...
> > > [   36.805350] # # # overflow_allocation_test: devm_kzalloc detected =
saturation
> > > [   36.807763] # # ok 3 - overflow_allocation_test
> > > [   36.807763] # # # overflow: PASS
> > > [   36.807765] # ok 1 - overflow
> > > [   36.807767] # # kunit: PASS
> > >
> > > But I assume there are threads on this that I've not read... :)
> >
> > These discussions all seem to be coming to a head now, so this is
> > probably just the kick we need to prioritise this a bit more. The KTAP
> > thread hasn't covered all of these (particularly the subtest stuff)
> > yet, so I confess I hadn't realised the extent of the divergence
> > between KUnit and kselftest here.
>=20
> Cool. Yeah, I'd like to keep things as close as possible. In looking at
> this again, I wonder if perhaps it would be better to change the
> "indent" from "# " to "  ", which might make things more readable for
> both dmesg and terminal output:
>=20
> [   36.611358]   TAP version 14
> [   36.611953]   1..1
> [   36.611958]     TAP version 14
> [   36.611954]     1..3
> ...
> [   36.622914]     # overflow_calculation_test: s64: 21 arithmetic tests
> [   36.624020]     ok 1 - overflow_calculation_test
> ...
> [   36.731096]     # overflow_shift_test: ok: (s64)(0 << 63) =3D=3D 0
> [   36.731840]     ok 2 - overflow_shift_test
> ...
> [   36.750294] kunit_try_catch: vmalloc: allocation failure: 184467440737=
09551615 bytes, mode:0xcc0(GFP_KERNEL),
> nodemask=3D(null),cpuset=3D/,mems_allowed=3D0
> ...
> [   36.805350]     # overflow_allocation_test: devm_kzalloc detected satu=
ration
> [   36.807763]     ok 3 - overflow_allocation_test
> [   36.807763]     # overflow: PASS
> [   36.807765]   ok 1 - overflow
> [   36.807767]   # kunit: PASS
>=20
> As it happens, subtests are a bit rare in kselftests right now, but
> for kunit, the "common" output (IIUC) will fundamentally be a top-level
> test running all the subtests, so we should get it right. :)

Personally, as a human I find the space prefix a bit easier to read.
However, I think that in "normal" kernel log output it is unusual for
a line to be prefixed with a hash (#), so this might be easier to
both visually distinguish and for automated parsing.
So I'm torn.  I don't have a strong opinion on space vs. hash prefix
for indicating sub-test.  I think the KUnit convention of matching
whatever was the prefix of the "TAP version 14" line is clever, but
it would be nice to just pick a prefix and be done with it.

IMHO.
 -- Tim


> -Kees
>=20
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git/log/?h=
=3Dselftests/harness/tap
>=20
> --
> Kees Cook
