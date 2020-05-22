Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A89991DE5B8
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 May 2020 13:42:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729547AbgEVLmc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 22 May 2020 07:42:32 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:59394 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728469AbgEVLmb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 22 May 2020 07:42:31 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04MBgDtA152945;
        Fri, 22 May 2020 11:42:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : in-reply-to : message-id : references : mime-version :
 content-type; s=corp-2020-01-29;
 bh=FU9/0CC92BC6LuPweyJBqNbp6HPQizGKZ6RZAf1Uq3E=;
 b=LxdBCE5nbL8SMBUyLiKGz3E8LrDSzxF/Wo/0zoz8u0WbqM6WikbN97Pe1gDdvSiivGTH
 pAmULJDxcadgxhgCcRn/ndGOEzXPQ7cA33oh5mDXZ3Dr+pDzNne7C/x7iyE3Cr4HTjER
 8eCgdDwjjGfiYHJJlMtzQqjhrsaaKI1e/eI2K2lEqubt0CIsl+cH1P70c62wsvUhA+ea
 KDXDs7WKzuDGUYBA6+soh5Zq7zDbVJdqwFvJf+w+jAOyBg4+lIWwXJH6TC6jyTh7l/b6
 Saf6W7PUSRt/n5GJONqJzpaTtsB9AbD9nOywxBDyiS3KiejD3+tqxA8d/uueP8pw/Vy1 sw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 31284md9x0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 22 May 2020 11:42:26 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04MBcif0002137;
        Fri, 22 May 2020 11:42:25 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 313gj7bgub-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 May 2020 11:42:25 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 04MBgOSA008360;
        Fri, 22 May 2020 11:42:24 GMT
Received: from dhcp-10-175-194-37.vpn.oracle.com (/10.175.194.37)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 22 May 2020 04:42:23 -0700
Date:   Fri, 22 May 2020 12:42:16 +0100 (BST)
From:   Alan Maguire <alan.maguire@oracle.com>
X-X-Sender: alan@localhost
To:     David Gow <davidgow@google.com>
cc:     kernel test robot <yidingx.liu@intel.com>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        "Li, Philip" <philip.li@intel.com>
Subject: Re: Kunit get 0 tests when run defconfig in Debian9
In-Reply-To: <CABVgOSnj6H5UXNGktT2NAHPF1KxAu5=Mg0hyuBu+NpjAdh+Q4A@mail.gmail.com>
Message-ID: <alpine.LRH.2.21.2005221239330.26762@localhost>
References: <ef994ce9-ccd8-e9c9-9838-049a62a3a561@intel.com> <CABVgOSnj6H5UXNGktT2NAHPF1KxAu5=Mg0hyuBu+NpjAdh+Q4A@mail.gmail.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1073592370-1590147743=:26762"
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9628 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 malwarescore=0
 mlxscore=0 adultscore=0 bulkscore=0 suspectscore=1 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005220096
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9628 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 mlxscore=0
 cotscore=-2147483648 impostorscore=0 malwarescore=0 mlxlogscore=999
 lowpriorityscore=0 phishscore=0 spamscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 clxscore=1011 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2005220096
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1073592370-1590147743=:26762
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Fri, 22 May 2020, David Gow wrote:

> Thanks for checking KUnit out =E2=80=94 it's a shame it hasn't worked
> out-of-the-box here.
>=20
> I'm not sure off the top of my head what could be wrong here: as you
> note, there are no obvious errors. My suspicion is that it's either
> some strange incompatibility with UML, or something is not quite right
> with the config being generated and used.
>=20
> A few questions/suggestions:
> - Are there any test results visible when running
> ./tools/testing/kunit/kunit.py run --raw_output  (older versions of
> the KUnit parser may not work well if the kernel log is decorated,
> e.g. with timestamps, etc =E2=80=94 this should be largely fixed for 5.7)=
=2E
> - If not, does running the built UML kernel manually work, and if so
> does it print any test results? This should be as simple as running
> "./vmlinux". On some older host kernels, UML may not boot if built
> statically and KASLR is in its strictest mode. This shouldn't be the
> case here, but running "setarch `uname -m` -R ./vmlinux" may help if
> some weirder issues show up.
> - Does the .config actually have CONFIG_KUNIT_TEST=3Dy and
> CONFIG_KUNIT_EXAMPLE_TEST=3Dy? kunit.py will keep its .config around, so
> you can check it after running kunit.py run. It'll also preserve any
> config changes you make that don't conflict with the .kunitconfig, so
> you could try (for example), also enabling CONFIG_LIST_KUNIT_TEST to
> see if it's a problem specific to those tests.
> - Finally, running 'make ARCH=3Dum defconfig' before running kunit.py
> run may help clean up any residual config that could be causing
> problems.
> - Otherwise, I'm not sure what could be going wrong. Are you running
> on x86_64? UML doesn't support non-x86 architectures, and while the
> 32-bit stuff worked last I checked, it's not tested as regularly at
> present.
>=20
> Of course, it's also possible to run tests without UML or the kunit.py
> script as well, by either building them into a kernel, and reading the
> results from the log on startup, or building the tests as modules,
> modprobing them, and reading the results from
> /sys/kernel/debug/kunit/<test-suite>/results. That's obviously a bit
> less convenient than the script, but may fit better into existing test
> infrastructure, and can sidestep any UML issues.
>

This is all great advice; I wonder if we should add a "Troubleshooting"
section to the KUnit documentation's start.rst file? A slightly-edited
(to be more general) version of the above would be really helpful there
I think. Thanks!

Alan

=20
> Hope that helps!
>=20
> Cheers,
> -- David
>=20
> On Thu, May 21, 2020 at 1:57 PM kernel test robot <yidingx.liu@intel.com>=
 wrote:
> >
> > Hi, all.
> >
> >
> > I met a strange problem that kunit run 0 tests in Debian9.
> >
> >
> > Env:
> >
> > ```
> >
> > root@lkp-hsw-ep4 ~/linus# head /etc/os-release
> > PRETTY_NAME=3D"Debian GNU/Linux 9 (stretch)"
> > NAME=3D"Debian GNU/Linux"
> > VERSION_ID=3D"9"
> > VERSION=3D"9 (stretch)"
> > ID=3Ddebian
> >
> > root@lkp-hsw-ep4 ~/linus# uname -r
> > 5.6.0
> >
> > ```
> >
> >
> > Reproduce: Just run `./tools/testing/kunit/kunit.py run --defconfig`
> >
> > ```
> >
> > root@lkp-hsw-ep4 ~/linus# ./tools/testing/kunit/kunit.py run --defconfi=
g
> > [13:41:30] Building KUnit Kernel ...
> > [13:41:33] Starting KUnit Kernel ...
> > [13:41:33] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > [13:41:33] Testing complete. 0 tests run. 0 failed. 0 crashed.
> > [13:41:33] Elapsed time: 2.619s total, 0.002s configuring, 2.610s
> > building, 0.007s running
> >
> > root@lkp-hsw-ep4 ~/linus# cat .kunitconfig
> > CONFIG_KUNIT=3Dy
> > CONFIG_KUNIT_TEST=3Dy
> > CONFIG_KUNIT_EXAMPLE_TEST=3Dy
> >
> > ```
> >
> >
> > As doc said, looks like everything worked correctly.  But kunit run 0 t=
ests.
> >
> > ```
> >
> > If everything worked correctly, you should see the following:
> >
> > Generating .config ...
> > Building KUnit Kernel ...
> > Starting KUnit Kernel ...
> >
> > ```
> >
> >
> >
> > --
> > Best regards.
> > Liu Yiding
> >
> > --
> > You received this message because you are subscribed to the Google Grou=
ps "KUnit Development" group.
> > To unsubscribe from this group and stop receiving emails from it, send =
an email to kunit-dev+unsubscribe@googlegroups.com.
> > To view this discussion on the web visit https://groups.google.com/d/ms=
gid/kunit-dev/ef994ce9-ccd8-e9c9-9838-049a62a3a561%40intel.com.
>=20
--8323328-1073592370-1590147743=:26762--
