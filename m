Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DA81758BDB
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Jul 2023 05:11:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230310AbjGSDLA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 18 Jul 2023 23:11:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230318AbjGSDK7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 18 Jul 2023 23:10:59 -0400
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [IPv6:2001:67c:2050:0:465::201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5066A1FC8;
        Tue, 18 Jul 2023 20:10:48 -0700 (PDT)
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4R5LRj5npSz9skf;
        Wed, 19 Jul 2023 05:10:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
        t=1689736241;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kVkTgFNs+1TvHl3f5WurRNNk4V4kr7WQcIrEp2Yd87E=;
        b=A5/P2eNBFoekIOp0cqRhmy/HH6n4XAE/+4CSUG8wQPQeEFPXgxkFSUip1vZXk7/Ax3f3kd
        hwunbyydpz9p9x/dj8E76DfTT2qkx4ztlMSpNif0zuzSq9BOzVa6Ta6KtMHllAXcCkePax
        JvsmYwgPPQfRKwcjBwMwaHaodPYZovjc0OkHN881QjEZr5quBkmssSIb9VddBEZfBY/TQT
        FyV6ZCnAN1YIB9l2L3p+3PyYv3uLVXMYLAC5J/Wl4AvTBmEUj1WL6eRruKERCMBHeSvE/v
        lrU1E2cdDK4FEO6QOgIUH05/tUQP8cFvhcMVTYSGEymSCTT0bPHNax1n2oiH+g==
Date:   Wed, 19 Jul 2023 13:10:28 +1000
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     Jeff Xu <jeffxu@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, Jeff Xu <jeffxu@google.com>,
        Kees Cook <keescook@chromium.org>,
        Daniel Verkamp <dverkamp@chromium.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        YueHaibing <yuehaibing@huawei.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [RFC PATCH 0/3] memfd: cleanups for vm.memfd_noexec
Message-ID: <o2tz56m3y2pbbj2sezyqvtw3caqwcqtqqkkfrq632ofpyj4enp@znkxadzn5lmj>
References: <20230713143406.14342-1-cyphar@cyphar.com>
 <CABi2SkVCp_MDh9MgD-UJ_hgJ58ynm22XJ53zE+ZCBSsWFBxiOw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lbrl6e2i4nsxdaxl"
Content-Disposition: inline
In-Reply-To: <CABi2SkVCp_MDh9MgD-UJ_hgJ58ynm22XJ53zE+ZCBSsWFBxiOw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--lbrl6e2i4nsxdaxl
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2023-07-17, Jeff Xu <jeffxu@chromium.org> wrote:
> Hello Aleksa,
>=20
> Thanks for your email and patches for discussion.
>=20
> On Thu, Jul 13, 2023 at 7:34=E2=80=AFAM Aleksa Sarai <cyphar@cyphar.com> =
wrote:
> >
> > It seems that the most critical issue with vm.memfd_noexec=3D2 (the fact
> > that passing MFD_EXEC would bypass it entirely[1]) has been fixed in
> > Andrew's tree[2], but there are still some outstanding issues that need
> > to be addressed:
> >
> >  * The dmesg warnings are pr_warn_once, which on most systems means that
> >    they will be used up by systemd or some other boot process and
> >    userspace developers will never see it. The original patch posted to
> >    the ML used pr_warn_ratelimited but the merged patch had it changed
> >    (with a comment about it being "per review"), but given that the
> >    current warnings are useless, pr_warn_ratelimited makes far more
> >    sense.
> >
> Ya, This was discussed in [1]
> Replacing pr_warn_once with pr_warn_ratelimited won't address Peter
> Xu's observation that "ratelimited" will fill syslog [2],  I'm not
> sure it is acceptable to ones who is not interested in memfd, I will
> defer this to maintainers.
>=20
> [1] https://lore.kernel.org/lkml/202212161233.85C9783FB@keescook/
> [2] https://lwn.net/ml/linux-kernel/Y5yS8wCnuYGLHMj4@x1n/

I see Kees's point, but in that case the logging should be tied to the
sysctl being the non-default value (I can post this version next if you
prefer). The current logging setup doesn't make sense.

> >  * vm.memfd_noexec=3D2 shouldn't reject old-style memfd_create(2) sysca=
lls
> >    because it will make it far to difficult to ever migrate. Instead it
> >    should imply MFD_EXEC.
> >
> Though the purpose of memfd_noexec=3D2 is not to help with migration  -
> but to disable creation of executable memfd for the current system/pid
> namespace.
> During the migration,  vm.memfd_noexe =3D 1 helps overwriting for
> unmigrated user code as a temporary measure.

My point is that the current behaviour for =3D2 means that nobody other
than *maybe* ChromeOS will ever be able to use it because it requires
auditing every program on the system. In fact, it's possible even
ChromeOS will run into issues given that one of the arguments made for
the nosymfollow mount option was that auditing all of ChromeOS to
replace every open with RESOLVE_NO_SYMLINKS would be too much effort[1]
(which I agreed with). Maybe this is less of an issue with
memfd_create(2) (which is much newer than open(2)) but it still seems
like a lot of busy work when the =3D1 behaviour is entirely sane even in
the strict threat model that =3D2 is trying to protect against.

To me, using =3D1 as a migration path (and in fact, calling =3D1 a migration
path further argues that the warning for not setting _EXEC or
_NOEXEC_SEAL should be tied to =3D1) would mean finding every program that
uses executable memfds and changing it to stop doing that. Not that you
use =3D1 to go and rewrite every userspace program that uses
memfd_create(2) at all, without using executable memfds (rebooting each
time to test the behaviour because we use pr_warn_once).

If you want to block syscalls that don't explicitly pass NOEXEC_SEAL,
there are several tools for doing this (both seccomp and LSM hooks).

[1]: https://lore.kernel.org/linux-fsdevel/20200131212021.GA108613@google.c=
om/

> Additional functionality/features should be implemented through
> security hook and LSM, not sysctl, I think.

This issue with =3D2 cannot be fixed in an LSM. (On the other hand, you
could implement either =3D2 behaviour with an LSM using =3D1, and the
current strict =3D2 behaviour could be implemented purely with seccomp.)

> >  * The ratcheting mechanism for vm.memfd_noexec doesn't make sense as a
> >    security mechanism because a CAP_SYS_ADMIN capable user can create
> >    executable binaries in a hidden tmpfs very easily, not to mention the
> >    many other things they can do.
> >
> By further limiting CAP_SYS_ADMIN, an attacker can't modify this
> sysctl even after compromising some system service with high
> privilege, YAMA has the same approach for ptrace_scope=3D3

Personally, I also think this behaviour from YAMA is a little goofy too,
but given that it only locks the most extreme setting and there is no
way to get around the most extreme setting, I guess it makes some sense
(not to mention it's an LSM and so there is an argument that it should
be possible to lock out privileged users from modifying it).
There are many other security sysctls, and very few have this behaviour
because it doesn't make much sense in most cases.

> In addition, this sysctl is pid_name spaced, this means child
> pid_namespace will alway have the same or stricter security setting
> than its parent, this allows admin to maintain a tree like view. If we
> allow the child pid namespace to elevate its setting, then the
> system-wide setting is no longer meaningful.

"no longer meaningful" is too strong of a statement imho. It is still
useful for constraining non-root processes and presumably ChromeOS
disallows random processes to do CLONE_NEWUSER (otherwise the protection
of this sysctl is pointless) so in practice for ChromeOS there is no
change in the attack surface.

(FWIW, I think tying this to the user namespace would've made more sense
since this is about privilege restrictions, but that ship has sailed.)

> The code sample shared in this patch set indicates that the attacker
> already has the ability of creating tmpfs and executing complex steps,
> at that point, it doesn't matter if the code execution is from memfd
> or not. For a safe by default system such as ChromeOS, attackers won't
> easily run arbitrary code, memfd is one of the open doors for that, so
> we are disabling executable memfd in ChromeOS. In other words:  if an
> attacker can already execute the arbitrary code as sample given in
> ChromeOS, without using executable memfd,  then memfd is no longer the
> thing we need to worry about, the arbitrary code execution is already
> achieved by the attacker. Even though I use ChromeOS as an example, I
> think the same type of threat model applies to any system that wants
> to disable executable memfd entirely.

I understand the threat model this sysctl is blocking, my point is that
blocking CAP_SYS_ADMIN from modifying the setting doesn't make sense
=66rom that threat model. An attacker that manages to trick some process
into creating a memfd with an executable payload is not going to be able
to change the sysctl setting (unless there's a confused deputy with
CAP_SYS_ADMIN, in which case you have much bigger issues).

If a CAP_SYS_ADMIN-capable user wants to change the sysctl, blocking it
doesn't add any security because that process could create a memfd-like
fd to execute without issues. What practical attack does this ratcheting
mechanism protect against? (This is a question you can answer with the
YAMA sysctl, but not this one AFAICS.)

But even if you feel that allowing this in child user namespaces is
unsafe or undesirable, it's absolutely necessary that
capable(CAP_SYS_ADMIN) should be able to un-brick the running system by
changing the sysctl. The alternative is that you need to reboot your
server in order to un-set a sysctl that broke some application you run.

Also, by the same token, this ratcheting mechanism doesn't make sense
with =3D1 *at all* because it could break programs in a way that would
require a reboot but it's not a "security setting" (and the YAMA sysctl
mentioned only locks the sysctl at the highest setting).

> >  * The memfd selftests would not exit with a non-zero error code when
> >    certain tests that ran in a forked process (specifically the ones
> >    related to MFD_EXEC and MFD_NOEXEC_SEAL) failed.
> >
> I will test this code and follow up.

Thanks!

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--lbrl6e2i4nsxdaxl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS2TklVsp+j1GPyqQYol/rSt+lEbwUCZLdUIwAKCRAol/rSt+lE
b0DsAP4r143pePDRUZUnqh8oHdDRDRbBWcyU3kwybr6tiVlwqQEA2m9TV/qcQHxq
V5fKtMl112yZem0gWzT9TTVHK9bBUgI=
=SQH/
-----END PGP SIGNATURE-----

--lbrl6e2i4nsxdaxl--
