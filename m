Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01A2A76C1DB
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Aug 2023 03:05:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbjHBBFN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 1 Aug 2023 21:05:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbjHBBFM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 1 Aug 2023 21:05:12 -0400
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [IPv6:2001:67c:2050:0:465::102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05ADE1BCF;
        Tue,  1 Aug 2023 18:05:09 -0700 (PDT)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4RFv0K41Jtz9sjc;
        Wed,  2 Aug 2023 03:05:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
        t=1690938305;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=g34OZvGRrz4maYRDbAHhhy11E8qzf3Ul4Hr/zDHsnFk=;
        b=e8d+RM8v+3aZNeNs+RKiTMkS7WLOTiQ56HN6tt021AHIPbZLgobqfg8+z3UGoQCQzbwMGA
        q9Zgrrya30FwNDZqq22Vbl4slVOV2HwNKGiLXSkiUWqkqzffWcZrZPFyd8qU9Dv2QqM8kG
        pHCmeMB4mNrr+pg2YhW5zitOQ69uvM4pCcdYrGLo7zz1X9eeY8cMeOiiGjlG32K/HjxNUN
        V+oUvK5fTCZ56AxRVtzhoUMmVrZ2qMrHgPjOT7/YCu8k4pRROFBAvdXG2lSoanbq8xeyrJ
        px0zO1lV3uRld99TvVCDtzb2/XQBoO7xfkLEGNwUe/VCfsE5xkMu7sIBOd9xMg==
Date:   Wed, 2 Aug 2023 11:04:50 +1000
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     Jeff Xu <jeffxu@google.com>
Cc:     Jeff Xu <jeffxu@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Daniel Verkamp <dverkamp@chromium.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        YueHaibing <yuehaibing@huawei.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [RFC PATCH 0/3] memfd: cleanups for vm.memfd_noexec
Message-ID: <20230801.032503-medium.noises.extinct.omen-CStYZUqcNLCS@cyphar.com>
References: <20230713143406.14342-1-cyphar@cyphar.com>
 <CABi2SkVCp_MDh9MgD-UJ_hgJ58ynm22XJ53zE+ZCBSsWFBxiOw@mail.gmail.com>
 <o2tz56m3y2pbbj2sezyqvtw3caqwcqtqqkkfrq632ofpyj4enp@znkxadzn5lmj>
 <CALmYWFs_dNCzw_pW1yRAo4bGCPEtykroEQaowNULp7svwMLjOg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qboptjuzyy5dxlxn"
Content-Disposition: inline
In-Reply-To: <CALmYWFs_dNCzw_pW1yRAo4bGCPEtykroEQaowNULp7svwMLjOg@mail.gmail.com>
X-Rspamd-Queue-Id: 4RFv0K41Jtz9sjc
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--qboptjuzyy5dxlxn
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2023-07-19, Jeff Xu <jeffxu@google.com> wrote:
> On Tue, Jul 18, 2023 at 8:10=E2=80=AFPM Aleksa Sarai <cyphar@cyphar.com> =
wrote:
> > On 2023-07-17, Jeff Xu <jeffxu@chromium.org> wrote:
> > > Hello Aleksa,
> > >
> > > Thanks for your email and patches for discussion.
> > >
> > > On Thu, Jul 13, 2023 at 7:34=E2=80=AFAM Aleksa Sarai <cyphar@cyphar.c=
om> wrote:
> > > >
> > > > It seems that the most critical issue with vm.memfd_noexec=3D2 (the=
 fact
> > > > that passing MFD_EXEC would bypass it entirely[1]) has been fixed in
> > > > Andrew's tree[2], but there are still some outstanding issues that =
need
> > > > to be addressed:
> > > >
> > > >  * The dmesg warnings are pr_warn_once, which on most systems means=
 that
> > > >    they will be used up by systemd or some other boot process and
> > > >    userspace developers will never see it. The original patch poste=
d to
> > > >    the ML used pr_warn_ratelimited but the merged patch had it chan=
ged
> > > >    (with a comment about it being "per review"), but given that the
> > > >    current warnings are useless, pr_warn_ratelimited makes far more
> > > >    sense.
> > > >
> > > Ya, This was discussed in [1]
> > > Replacing pr_warn_once with pr_warn_ratelimited won't address Peter
> > > Xu's observation that "ratelimited" will fill syslog [2],  I'm not
> > > sure it is acceptable to ones who is not interested in memfd, I will
> > > defer this to maintainers.
> > >
> > > [1] https://lore.kernel.org/lkml/202212161233.85C9783FB@keescook/
> > > [2] https://lwn.net/ml/linux-kernel/Y5yS8wCnuYGLHMj4@x1n/
> >
> > I see Kees's point, but in that case the logging should be tied to the
> > sysctl being the non-default value (I can post this version next if you
> > prefer). The current logging setup doesn't make sense.
> >
> Is there a best practice in kernel for this problem: too much log  vs
> too little log
> In other products, usually the log level or compiler flag (ifdef) are
> for such a situation.

It depends on what the purpose of the warning is -- if the purpose of
the warning is to tell developers to migrate their programs, then
a rate-limited warning is the only reasonable behaviour.

pr_warn_ratelimited() is the most straight-forward way of doing the
warning. There are alternatives (the pids cgroup has a per-cgroup
warning that is only triggered the first time a fork() fails in that
cgroup) -- but the key point is that the log will appear in dmesg in a
way that a developer will be able to notice. Having a single warning at
the very beginning of the boot sequence is useless. On my system,
systemd does memfd_create() without the new flags, so all you see is the
following message:

[    1.531305] memfd_create() without MFD_EXEC nor MFD_NOEXEC_SEAL, pid=3D1=
 'systemd'

in the middle of all of the other stuff that gets spit out during boot.
This obviously is going to be missed by basically all users.

> > > >  * vm.memfd_noexec=3D2 shouldn't reject old-style memfd_create(2) s=
yscalls
> > > >    because it will make it far to difficult to ever migrate. Instea=
d it
> > > >    should imply MFD_EXEC.
> > > >
> > > Though the purpose of memfd_noexec=3D2 is not to help with migration =
 -
> > > but to disable creation of executable memfd for the current system/pid
> > > namespace.
> > > During the migration,  vm.memfd_noexe =3D 1 helps overwriting for
> > > unmigrated user code as a temporary measure.
> >
> > My point is that the current behaviour for =3D2 means that nobody other
> > than *maybe* ChromeOS will ever be able to use it because it requires
> > auditing every program on the system. In fact, it's possible even
> > ChromeOS will run into issues given that one of the arguments made for
> > the nosymfollow mount option was that auditing all of ChromeOS to
> > replace every open with RESOLVE_NO_SYMLINKS would be too much effort[1]
> > (which I agreed with). Maybe this is less of an issue with
> > memfd_create(2) (which is much newer than open(2)) but it still seems
> > like a lot of busy work when the =3D1 behaviour is entirely sane even in
> > the strict threat model that =3D2 is trying to protect against.
> >
> It can also be a container (that have all memfd_create migrated to new AP=
I)

If ChromeOS would struggle to rewrite all of the libraries they use,
containers are in even worse shape -- most container users don't have a
complete list of every package installed in a container, let alone the
ability to audit whether they pass a (no-op) flag to memfd_create(2) in
every codepath.

> One option I considered previously was "=3D2" would do overwrite+block ,
> and "=3D3" just block. But then I worry that applications won't have
> motivation to ever change their existing code, the setting will
> forever stay at "=3D2", making "=3D3" even more impossible to ever be used
>  system side.

What is the downside of overwriting? Backwards-compatibility is a very
important part of Linux -- being able to use old programs without having
to modify them is incredibly important. Yes, this behaviour is opt-in --
but I don't see the point of making opting in more difficult than
necessary. Surely overwite+block provides the security guarantee you
need from the threat model -- othewise nobody will be able to use block
because you never know if one library will call memfd_create()
"incorrectly" without the new flags.

> > To me, using =3D1 as a migration path (and in fact, calling =3D1 a migr=
ation
> > path further argues that the warning for not setting _EXEC or
> > _NOEXEC_SEAL should be tied to =3D1) would mean finding every program t=
hat
> > uses executable memfds and changing it to stop doing that. Not that you
> > use =3D1 to go and rewrite every userspace program that uses
> > memfd_create(2) at all, without using executable memfds (rebooting each
> > time to test the behaviour because we use pr_warn_once).
> >
> I tend to think logging and sysctl are orthogonal, tie them together
> making it more complex than necessary. If we need more logging, we
> should find what is the best practice in the kernel for that.

See my above comment -- tying it to >=3D 1 would alleviate the log spam
concerns. pr_warn_once() is useless for this purpose.

> > If you want to block syscalls that don't explicitly pass NOEXEC_SEAL,
> > there are several tools for doing this (both seccomp and LSM hooks).
> >
> > [1]: https://lore.kernel.org/linux-fsdevel/20200131212021.GA108613@goog=
le.com/
> >
> > > Additional functionality/features should be implemented through
> > > security hook and LSM, not sysctl, I think.
> >
> > This issue with =3D2 cannot be fixed in an LSM. (On the other hand, you
> > could implement either =3D2 behaviour with an LSM using =3D1, and the
> > current strict =3D2 behaviour could be implemented purely with seccomp.)
> >
> By migration, I mean  a system that is not fully migrated, such a
> system should just use "=3D0" or "=3D1". Additional features can be
> implemented in SELinux/Landlock/other LSM by a motivated dev.  e.g. if
> a system wants to limit executable memfd to specific programs or fully
> disable it.
> "=3D2" is for a system/container that is fully migrated, in that case,
> SELinux/Landlock/LSM can do the same, but sysctl provides a convenient
>  alternative.
> Yes, seccomp provides a similar mechanism. Indeed, combining "=3D1" and
> seccomp (block MFD_EXEC), it will overwrite + block X mfd, which is
> essentially what you want, iiuc.However, I do not wish to have this
> implemented in kernel, due to the thinking that I want kernel to get
> out of business of "overwriting" eventually.

See my above comments -- "overwriting" is perfectly acceptable to me.
There's also no way to "get out of the business of overwriting" -- Linux
has strict backwards compatibility requirements.

> > > >  * The ratcheting mechanism for vm.memfd_noexec doesn't make sense =
as a
> > > >    security mechanism because a CAP_SYS_ADMIN capable user can crea=
te
> > > >    executable binaries in a hidden tmpfs very easily, not to mentio=
n the
> > > >    many other things they can do.
> > > >
> > > By further limiting CAP_SYS_ADMIN, an attacker can't modify this
> > > sysctl even after compromising some system service with high
> > > privilege, YAMA has the same approach for ptrace_scope=3D3
> >
> > Personally, I also think this behaviour from YAMA is a little goofy too,
> > but given that it only locks the most extreme setting and there is no
> > way to get around the most extreme setting, I guess it makes some sense
> > (not to mention it's an LSM and so there is an argument that it should
> > be possible to lock out privileged users from modifying it).
> > There are many other security sysctls, and very few have this behaviour
> > because it doesn't make much sense in most cases.
> >
> > > In addition, this sysctl is pid_name spaced, this means child
> > > pid_namespace will alway have the same or stricter security setting
> > > than its parent, this allows admin to maintain a tree like view. If we
> > > allow the child pid namespace to elevate its setting, then the
> > > system-wide setting is no longer meaningful.
> >
> > "no longer meaningful" is too strong of a statement imho. It is still
> > useful for constraining non-root processes and presumably ChromeOS
> > disallows random processes to do CLONE_NEWUSER (otherwise the protection
> > of this sysctl is pointless) so in practice for ChromeOS there is no
> > change in the attack surface.
> >
> > (FWIW, I think tying this to the user namespace would've made more sense
> > since this is about privilege restrictions, but that ship has sailed.)
> >
> The reason that this sysctl is a PID namespace is that I hope a
> container and host can have different sysctl values, e.g. host will
> allow runc's use of X mfd, while a container  doesn't want X mfd. .
> To clarify what you meant, do you mean this: when a container is in
> its own pid_namespace, and has "=3D2", the programs inside the container
> can still use CLONE_NEWUSER to break out "=3D2" ?

With the current implementation, this is not possible. My point was that
even if it were possible to lower the sysctl, ChromeOS presumably
already blocks the operations that a user would be able to use to create
a memfd (an unprivileged user cannot CLONE_NEWPID to modify the sysctl
without CLONE_NEWUSER, which is presumably blocked on ChromeOS due to
the other security concerns).

> And what makes the user namespace a better choice than pid namespace
> for this sysctl ?

It's too late for this discussion, the sysctl has already shipped and
you can't change this behaviour anymore.

However, the simple reason is that the kernel ties permission-related
things to the user namespace because credentials are tied to the userns
-- the only other pidns-related sysctl is kernel.ns_last_pid, which
clearly needs to be tied to the pidns.

> > > The code sample shared in this patch set indicates that the attacker
> > > already has the ability of creating tmpfs and executing complex steps,
> > > at that point, it doesn't matter if the code execution is from memfd
> > > or not. For a safe by default system such as ChromeOS, attackers won't
> > > easily run arbitrary code, memfd is one of the open doors for that, so
> > > we are disabling executable memfd in ChromeOS. In other words:  if an
> > > attacker can already execute the arbitrary code as sample given in
> > > ChromeOS, without using executable memfd,  then memfd is no longer the
> > > thing we need to worry about, the arbitrary code execution is already
> > > achieved by the attacker. Even though I use ChromeOS as an example, I
> > > think the same type of threat model applies to any system that wants
> > > to disable executable memfd entirely.
> >
> > I understand the threat model this sysctl is blocking, my point is that
> > blocking CAP_SYS_ADMIN from modifying the setting doesn't make sense
> > from that threat model. An attacker that manages to trick some process
> > into creating a memfd with an executable payload is not going to be able
> > to change the sysctl setting (unless there's a confused deputy with
> > CAP_SYS_ADMIN, in which case you have much bigger issues).
> >
> It is the reverse.  An attacker that manages to trick some
> CAP_SYSADMIN processes into changing this sysctl value (i.e. lower the
> setting to 0 if no ratcheting), will be able to continue to use mfd as
> part of the attack chain.
>  In chromeOS, an attacker that can change sysctl might not necessarily
> gain full arbitrary code execution already. As I mentioned previously,
> the main threat model here is to prevent  arbitrary code execution
> through mfd.  If an attacker already gains arbitrary code execution,
> at that point, we no longer worry about mfd.

If an attacker can trick a privileged process into writing to arbitrary
sysctls, the system has much bigger issues than arbitrary (presumably
unprivileged) code execution. On the other hand, requiring you to reboot
a server due to a misconfigured sysctl *is* broken.

Again, at the very least, not even allowing capable(CAP_SYS_ADMIN) to
change the setting is actually broken.

> > If a CAP_SYS_ADMIN-capable user wants to change the sysctl, blocking it
> > doesn't add any security because that process could create a memfd-like
> > fd to execute without issues.
> >What practical attack does this ratcheting
> > mechanism protect against? (This is a question you can answer with the
> > YAMA sysctl, but not this one AFAICS.)
> >
> > But even if you feel that allowing this in child user namespaces is
> > unsafe or undesirable, it's absolutely necessary that
> > capable(CAP_SYS_ADMIN) should be able to un-brick the running system by
> > changing the sysctl. The alternative is that you need to reboot your
> > server in order to un-set a sysctl that broke some application you run.
> >
>=20
> > Also, by the same token, this ratcheting mechanism doesn't make sense
> > with =3D1 *at all* because it could break programs in a way that would
> > require a reboot but it's not a "security setting" (and the YAMA sysctl
> > mentioned only locks the sysctl at the highest setting).
> >
> I think a system should use "=3D0" when it is unsure about its program's
> need or not need executable memfd. Technically, it is not that this
> sysctl breaks the user, but the admin  made the mistake to set the
> wrong sysctl value, and an admin should know what they are doing for a
> sysctl. Yes. rebooting increases the steps to undo the mistake, but
> that could be an incentive for the admin to fully test its programs
> before turning on this sysctl - and avoid unexpected runtime errors.

I don't think this stance is really acceptable -- if an admin that has
privileges to load kernel modules is not able to disable a sysctl that
can break working programs without rebooting there is=20

When this sysctl was first proposed a few years ago (when kernel folks
found out that runc was using executable memfds), my understanding is
that the long-term goal was to switch programs to have
non-executable-memfds by default on most distributions. Making it
impossible for an admin to lower the sysctl value flies in the face of
this goal.

At the very least, being unable to lower the sysctl from =3D1 to =3D0 is
just broken (even if you use the yama example -- yama only locks the
sysctl at highest possible setting, not on lower settings). But in my
view, having this sysctl ratchet at all doesn't make sense.

> Thanks!
> -Jeff

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--qboptjuzyy5dxlxn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS2TklVsp+j1GPyqQYol/rSt+lEbwUCZMmrsQAKCRAol/rSt+lE
b1PZAP9uPEOPdpv5btgYMPMi+pfKE9eibhyOVX9Y7xLseqiQUQEA2J2ZmlDaDtK0
rm2gINbyT1mav9Cl36nT4O+OqSQoYAI=
=TeTJ
-----END PGP SIGNATURE-----

--qboptjuzyy5dxlxn--
