Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7210876D9B3
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Aug 2023 23:39:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232412AbjHBVjR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 2 Aug 2023 17:39:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230007AbjHBVjQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 2 Aug 2023 17:39:16 -0400
X-Greylist: delayed 74045 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 02 Aug 2023 14:39:14 PDT
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [IPv6:2001:67c:2050:0:465::202])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EB4A1BC7;
        Wed,  2 Aug 2023 14:39:14 -0700 (PDT)
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4RGQNG47cSz9srr;
        Wed,  2 Aug 2023 23:39:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
        t=1691012350;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=J6LlYeH6oWwaePHcKa4pV249iEzg4bTxNZKZ65XojGc=;
        b=GtIK/wlJqs3LYKhGsQd8aSM1vwWqKc2t+LFr++L9LhIbnCLoxkkW6wBznMq2lUNskgdeNR
        E1FtaKINIxjjlesv7D0INLHE4xtrc7RTUoy1PG+cqsBW/JnpoNhzhNpNHASa1vRdYTeo3Y
        y7j+/FrKQjG+T9+1tQw0RPEqltSM8punLhmiLivqJ2DBC8Xi8ptwnyCk6mysuN7W6AQc7x
        asxe76m4psJ7fCnmLA/l/LYFQ1i/Kr+hEY9Gt+LuauiqkS+Rulr5ByRP3uxS7To12tv6+6
        zGR7gjkH6XicFchQOiLA3RW7szPDuuIrWlD8oXS/AhC7JN7dwRnDAwzOTvceiQ==
Date:   Thu, 3 Aug 2023 07:38:50 +1000
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     Jeff Xu <jeffxu@chromium.org>
Cc:     Jeff Xu <jeffxu@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Daniel Verkamp <dverkamp@chromium.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        YueHaibing <yuehaibing@huawei.com>,
        Christian Brauner <brauner@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [RFC PATCH 0/3] memfd: cleanups for vm.memfd_noexec
Message-ID: <20230802.211829-obedient.verb.pointed.walk-inxghgNcxn@cyphar.com>
References: <20230713143406.14342-1-cyphar@cyphar.com>
 <CABi2SkVCp_MDh9MgD-UJ_hgJ58ynm22XJ53zE+ZCBSsWFBxiOw@mail.gmail.com>
 <o2tz56m3y2pbbj2sezyqvtw3caqwcqtqqkkfrq632ofpyj4enp@znkxadzn5lmj>
 <CALmYWFs_dNCzw_pW1yRAo4bGCPEtykroEQaowNULp7svwMLjOg@mail.gmail.com>
 <20230801.032503-medium.noises.extinct.omen-CStYZUqcNLCS@cyphar.com>
 <CABi2SkXWfup2_UeKqm7C-xkjF5gnhKuxOP7TsRVa5MLbxabFQg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="nd5bu6leykkydsju"
Content-Disposition: inline
In-Reply-To: <CABi2SkXWfup2_UeKqm7C-xkjF5gnhKuxOP7TsRVa5MLbxabFQg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--nd5bu6leykkydsju
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2023-08-02, Jeff Xu <jeffxu@chromium.org> wrote:
> On Tue, Aug 1, 2023 at 6:05=E2=80=AFPM Aleksa Sarai <cyphar@cyphar.com> w=
rote:
> >
> This thread is getting longer with different topics, I will try to
> respond with trimmed interleaved replies [1]
> There are 3 topics (logging/'migration/ratcheting), this response will
> be regarding ratcheting.

The migration and ratcheting topics are interconnected because the
migration issue makes ratcheting an even more severe issue. But I'll
respond to each thread separately.

> [1] https://www.kernel.org/doc/html/latest/process/submitting-patches.htm=
l?highlight=3Dsigned%20off#use-trimmed-interleaved-replies-in-email-discuss=
ions
>=20
> >
> > > > > >  * The ratcheting mechanism for vm.memfd_noexec doesn't make se=
nse as a
> > > > > >    security mechanism because a CAP_SYS_ADMIN capable user can =
create
> > > > > >    executable binaries in a hidden tmpfs very easily, not to me=
ntion the
> > > > > >    many other things they can do.
> > > > > >
> > > > > By further limiting CAP_SYS_ADMIN, an attacker can't modify this
> > > > > sysctl even after compromising some system service with high
> > > > > privilege, YAMA has the same approach for ptrace_scope=3D3
> > > >
> > > > Personally, I also think this behaviour from YAMA is a little goofy=
 too,
> > > > but given that it only locks the most extreme setting and there is =
no
> > > > way to get around the most extreme setting, I guess it makes some s=
ense
> > > > (not to mention it's an LSM and so there is an argument that it sho=
uld
> > > > be possible to lock out privileged users from modifying it).
> > > > There are many other security sysctls, and very few have this behav=
iour
> > > > because it doesn't make much sense in most cases.
> > > >
> > > > > In addition, this sysctl is pid_name spaced, this means child
> > > > > pid_namespace will alway have the same or stricter security setti=
ng
> > > > > than its parent, this allows admin to maintain a tree like view. =
If we
> > > > > allow the child pid namespace to elevate its setting, then the
> > > > > system-wide setting is no longer meaningful.
> > > >
> > > > "no longer meaningful" is too strong of a statement imho. It is sti=
ll
> > > > useful for constraining non-root processes and presumably ChromeOS
> > > > disallows random processes to do CLONE_NEWUSER (otherwise the prote=
ction
> > > > of this sysctl is pointless) so in practice for ChromeOS there is no
> > > > change in the attack surface.
> > > >
> > > > (FWIW, I think tying this to the user namespace would've made more =
sense
> > > > since this is about privilege restrictions, but that ship has saile=
d.)
> > > >
> > > The reason that this sysctl is a PID namespace is that I hope a
> > > container and host can have different sysctl values, e.g. host will
> > > allow runc's use of X mfd, while a container  doesn't want X mfd. .
> > > To clarify what you meant, do you mean this: when a container is in
> > > its own pid_namespace, and has "=3D2", the programs inside the contai=
ner
> > > can still use CLONE_NEWUSER to break out "=3D2" ?
> >
> > With the current implementation, this is not possible. My point was that
> > even if it were possible to lower the sysctl, ChromeOS presumably
> > already blocks the operations that a user would be able to use to create
> > a memfd (an unprivileged user cannot CLONE_NEWPID to modify the sysctl
> > without CLONE_NEWUSER, which is presumably blocked on ChromeOS due to
> > the other security concerns).
> >
> >
> > > > > The code sample shared in this patch set indicates that the attac=
ker
> > > > > already has the ability of creating tmpfs and executing complex s=
teps,
> > > > > at that point, it doesn't matter if the code execution is from me=
mfd
> > > > > or not. For a safe by default system such as ChromeOS, attackers =
won't
> > > > > easily run arbitrary code, memfd is one of the open doors for tha=
t, so
> > > > > we are disabling executable memfd in ChromeOS. In other words:  i=
f an
> > > > > attacker can already execute the arbitrary code as sample given in
> > > > > ChromeOS, without using executable memfd,  then memfd is no longe=
r the
> > > > > thing we need to worry about, the arbitrary code execution is alr=
eady
> > > > > achieved by the attacker. Even though I use ChromeOS as an exampl=
e, I
> > > > > think the same type of threat model applies to any system that wa=
nts
> > > > > to disable executable memfd entirely.
> > > >
> > > > I understand the threat model this sysctl is blocking, my point is =
that
> > > > blocking CAP_SYS_ADMIN from modifying the setting doesn't make sense
> > > > from that threat model. An attacker that manages to trick some proc=
ess
> > > > into creating a memfd with an executable payload is not going to be=
 able
> > > > to change the sysctl setting (unless there's a confused deputy with
> > > > CAP_SYS_ADMIN, in which case you have much bigger issues).
> > > >
> > > It is the reverse.  An attacker that manages to trick some
> > > CAP_SYSADMIN processes into changing this sysctl value (i.e. lower the
> > > setting to 0 if no ratcheting), will be able to continue to use mfd as
> > > part of the attack chain.
> > >  In chromeOS, an attacker that can change sysctl might not necessarily
> > > gain full arbitrary code execution already. As I mentioned previously,
> > > the main threat model here is to prevent  arbitrary code execution
> > > through mfd.  If an attacker already gains arbitrary code execution,
> > > at that point, we no longer worry about mfd.
> >
> > If an attacker can trick a privileged process into writing to arbitrary
> > sysctls, the system has much bigger issues than arbitrary (presumably
> > unprivileged) code execution. On the other hand, requiring you to reboot
> > a server due to a misconfigured sysctl *is* broken.
> >
> > Again, at the very least, not even allowing capable(CAP_SYS_ADMIN) to
> > change the setting is actually broken.
> >
> > > > If a CAP_SYS_ADMIN-capable user wants to change the sysctl, blockin=
g it
> > > > doesn't add any security because that process could create a memfd-=
like
> > > > fd to execute without issues.
> > > >What practical attack does this ratcheting
> > > > mechanism protect against? (This is a question you can answer with =
the
> > > > YAMA sysctl, but not this one AFAICS.)
> > > >
> > > > But even if you feel that allowing this in child user namespaces is
> > > > unsafe or undesirable, it's absolutely necessary that
> > > > capable(CAP_SYS_ADMIN) should be able to un-brick the running syste=
m by
> > > > changing the sysctl. The alternative is that you need to reboot your
> > > > server in order to un-set a sysctl that broke some application you =
run.
> > > >
> > >
> > > > Also, by the same token, this ratcheting mechanism doesn't make sen=
se
> > > > with =3D1 *at all* because it could break programs in a way that wo=
uld
> > > > require a reboot but it's not a "security setting" (and the YAMA sy=
sctl
> > > > mentioned only locks the sysctl at the highest setting).
> > > >
> > > I think a system should use "=3D0" when it is unsure about its progra=
m's
> > > need or not need executable memfd. Technically, it is not that this
> > > sysctl breaks the user, but the admin  made the mistake to set the
> > > wrong sysctl value, and an admin should know what they are doing for a
> > > sysctl. Yes. rebooting increases the steps to undo the mistake, but
> > > that could be an incentive for the admin to fully test its programs
> > > before turning on this sysctl - and avoid unexpected runtime errors.
> >
> > I don't think this stance is really acceptable -- if an admin that has
> > privileges to load kernel modules is not able to disable a sysctl that
> > can break working programs without rebooting there is
> >
> > When this sysctl was first proposed a few years ago (when kernel folks
> > found out that runc was using executable memfds), my understanding is
> > that the long-term goal was to switch programs to have
> > non-executable-memfds by default on most distributions. Making it
> > impossible for an admin to lower the sysctl value flies in the face of
> > this goal.
> >
> > At the very least, being unable to lower the sysctl from =3D1 to =3D0 is
> > just broken (even if you use the yama example -- yama only locks the
> > sysctl at highest possible setting, not on lower settings). But in my
> > view, having this sysctl ratchet at all doesn't make sense.
> >
> To reiterate/summarize the current mechanism for vm.memfd_noexec
>=20
> 1> It is a pid namespace sysctl,  init ns and child pid ns can have
> different setting values.
> 2> child pid ns inherits parent's pid ns's sysctl at the time of fork.
> 3> There are  3 values for the sysctl, each higher value is more
> restrictive than the lower one. Once set, doesn't allow downgrading.
>=20
> It can be used as  following:
> 1>
> init ns: vm.memfd_noexec =3D 2 (at boot time)
> Not allow executable memfd for the entire system, including its container=
s.
>=20
> 2>
> init ns: vm.memfd_noexec =3D 0 or 1
> container (child init namespace) vm.memfd_noexec =3D 2.
> The host allows runc's usage of executable memfd during container
> creation. Inside the container, executable memfd is not allowed.
>=20
> The inherence + not allow downgrading is to reason with how
> vm.memfd_noexec is applied in the process tree.
> Without it, essentially we are losing the hierarchy view across the
> process tree and  a process can evaluate its capability by modifying
> the setting. I think that is a less secure approach I would not
> prefer.

If you really want the hierarchical aspect, we can implement it so that
it's _actually_ hierarchical like so:

 * By default, your setting is the same as your parent (this is checked
   by going up the pidns tree -- a-la cgroups). This is less efficient
   but you want a hierarchy, so we can do it this way instead.
 * If you set a specific setting, that takes precedence but only if it's
   a greater or equal setting to your parent.
 * Trying to set a lower setting than your parent fails regardless of
   privileges.

This will allow *privileged users* to lower the setting, but only if
the parent pidns also has a lower setting. This allows a system admin to
enforce the setting. It seems to me that this fulfils all the
requirements you have.

Most importantly, this would allow for a hierarchical view without
having a sysctl that will break systems and nobody will use. I need to
re-iterate this point -- nobody is going to use this sysctl as it
currently works because it ratchets in a way that admins cannot undo. In
practice this would mean you would need to reboot your whole datacenter
if you didn't catch that an update to one of you dependencies didn't
pass a required *noop* flag to memfd_create().

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--nd5bu6leykkydsju
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS2TklVsp+j1GPyqQYol/rSt+lEbwUCZMrM6gAKCRAol/rSt+lE
b5iBAQCCAKCZLBiPuS0RZ9+pUw3/4zLkEUllHNcoPPEkDKL8ogD/VNqrHoAs0PG1
tbRBIlj/TvEEoj5to4IRVurRcwns/wo=
=8bPm
-----END PGP SIGNATURE-----

--nd5bu6leykkydsju--
