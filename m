Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F176C76D9F7
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Aug 2023 23:49:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231215AbjHBVtL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 2 Aug 2023 17:49:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230031AbjHBVtJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 2 Aug 2023 17:49:09 -0400
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [IPv6:2001:67c:2050:0:465::103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 456DF2129;
        Wed,  2 Aug 2023 14:49:06 -0700 (PDT)
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4RGQbc1BCmz9sTD;
        Wed,  2 Aug 2023 23:49:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
        t=1691012940;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=i04Z8bgkzw2aMO36HReNQAuyWQgn5tBl6lRpl7bgpMs=;
        b=L3qQ4uJsloDWhmez7dk0vWebPtjr0CPjKjzFCrqJT8HZYhxvWTE4Phy919tGtYat8G3va7
        9JFNqoJltD21NQtO6XUICSW96NSisGfmx66IFzdt1hInJj2/ZGEK5DwPzNDGoHpNpgbN71
        BsaAtzQ4q1POirg4djVe2zypnQD8KEJKJDU3Mp/LkWD0w+W6Vm9aQKBuyzfx6PNM+cnD5C
        AnOiznEsYiqeWXTkk5mG68xUkHzP2KvdyU3PoTf7/5F+tnm4KnpCGLjZ16B5MEWrUeFOyv
        Wthc40romOk0aGW6wYZ1DGvj8UGfP1kive5M18gFNPollkH9FG2AXZhbJjVA8w==
Date:   Thu, 3 Aug 2023 07:48:48 +1000
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     Jeff Xu <jeffxu@chromium.org>
Cc:     Jeff Xu <jeffxu@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Daniel Verkamp <dverkamp@chromium.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        YueHaibing <yuehaibing@huawei.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [RFC PATCH 0/3] memfd: cleanups for vm.memfd_noexec
Message-ID: <20230802.213938-adept.raisins.dental.revival-IIlYKYPmegSa@cyphar.com>
References: <20230713143406.14342-1-cyphar@cyphar.com>
 <CABi2SkVCp_MDh9MgD-UJ_hgJ58ynm22XJ53zE+ZCBSsWFBxiOw@mail.gmail.com>
 <o2tz56m3y2pbbj2sezyqvtw3caqwcqtqqkkfrq632ofpyj4enp@znkxadzn5lmj>
 <CALmYWFs_dNCzw_pW1yRAo4bGCPEtykroEQaowNULp7svwMLjOg@mail.gmail.com>
 <20230801.032503-medium.noises.extinct.omen-CStYZUqcNLCS@cyphar.com>
 <CABi2SkUnJ4NiRMtSXdLtHXWrY23iKLdGiUuTgc0Yrtq16-KkeA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="w2o6q6aerims2enk"
Content-Disposition: inline
In-Reply-To: <CABi2SkUnJ4NiRMtSXdLtHXWrY23iKLdGiUuTgc0Yrtq16-KkeA@mail.gmail.com>
X-Rspamd-Queue-Id: 4RGQbc1BCmz9sTD
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--w2o6q6aerims2enk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2023-08-02, Jeff Xu <jeffxu@chromium.org> wrote:
> > > > > >  * vm.memfd_noexec=3D2 shouldn't reject old-style memfd_create(=
2) syscalls
> > > > > >    because it will make it far to difficult to ever migrate. In=
stead it
> > > > > >    should imply MFD_EXEC.
> > > > > >
> > > > > Though the purpose of memfd_noexec=3D2 is not to help with migrat=
ion  -
> > > > > but to disable creation of executable memfd for the current syste=
m/pid
> > > > > namespace.
> > > > > During the migration,  vm.memfd_noexe =3D 1 helps overwriting for
> > > > > unmigrated user code as a temporary measure.
> > > >
> > > > My point is that the current behaviour for =3D2 means that nobody o=
ther
> > > > than *maybe* ChromeOS will ever be able to use it because it requir=
es
> > > > auditing every program on the system. In fact, it's possible even
> > > > ChromeOS will run into issues given that one of the arguments made =
for
> > > > the nosymfollow mount option was that auditing all of ChromeOS to
> > > > replace every open with RESOLVE_NO_SYMLINKS would be too much effor=
t[1]
> > > > (which I agreed with). Maybe this is less of an issue with
> > > > memfd_create(2) (which is much newer than open(2)) but it still see=
ms
> > > > like a lot of busy work when the =3D1 behaviour is entirely sane ev=
en in
> > > > the strict threat model that =3D2 is trying to protect against.
> > > >
> > > It can also be a container (that have all memfd_create migrated to ne=
w API)
> >
> > If ChromeOS would struggle to rewrite all of the libraries they use,
> > containers are in even worse shape -- most container users don't have a
> > complete list of every package installed in a container, let alone the
> > ability to audit whether they pass a (no-op) flag to memfd_create(2) in
> > every codepath.
> >
> > > One option I considered previously was "=3D2" would do overwrite+bloc=
k ,
> > > and "=3D3" just block. But then I worry that applications won't have
> > > motivation to ever change their existing code, the setting will
> > > forever stay at "=3D2", making "=3D3" even more impossible to ever be=
 used
> > >  system side.
> >
> > What is the downside of overwriting? Backwards-compatibility is a very
> > important part of Linux -- being able to use old programs without having
> > to modify them is incredibly important. Yes, this behaviour is opt-in --
> > but I don't see the point of making opting in more difficult than
> > necessary. Surely overwite+block provides the security guarantee you
> > need from the threat model -- othewise nobody will be able to use block
> > because you never know if one library will call memfd_create()
> > "incorrectly" without the new flags.
> >
> >
> > > > If you want to block syscalls that don't explicitly pass NOEXEC_SEA=
L,
> > > > there are several tools for doing this (both seccomp and LSM hooks).
> > > >
> > > > [1]: https://lore.kernel.org/linux-fsdevel/20200131212021.GA108613@=
google.com/
> > > >
> > > > > Additional functionality/features should be implemented through
> > > > > security hook and LSM, not sysctl, I think.
> > > >
> > > > This issue with =3D2 cannot be fixed in an LSM. (On the other hand,=
 you
> > > > could implement either =3D2 behaviour with an LSM using =3D1, and t=
he
> > > > current strict =3D2 behaviour could be implemented purely with secc=
omp.)
> > > >
> > > By migration, I mean  a system that is not fully migrated, such a
> > > system should just use "=3D0" or "=3D1". Additional features can be
> > > implemented in SELinux/Landlock/other LSM by a motivated dev.  e.g. if
> > > a system wants to limit executable memfd to specific programs or fully
> > > disable it.
> > > "=3D2" is for a system/container that is fully migrated, in that case,
> > > SELinux/Landlock/LSM can do the same, but sysctl provides a convenient
> > >  alternative.
> > > Yes, seccomp provides a similar mechanism. Indeed, combining "=3D1" a=
nd
> > > seccomp (block MFD_EXEC), it will overwrite + block X mfd, which is
> > > essentially what you want, iiuc.However, I do not wish to have this
> > > implemented in kernel, due to the thinking that I want kernel to get
> > > out of business of "overwriting" eventually.
> >
> > See my above comments -- "overwriting" is perfectly acceptable to me.
> > There's also no way to "get out of the business of overwriting" -- Linux
> > has strict backwards compatibility requirements.
> >
>=20
> I agree, if we weigh on the short term goal of letting the user space
> applications to do minimum, then having 4 state sysctl (or 2 sysctl,
> one controls overwrite, one disable/enable executable memfd) will do.
> But with that approach, I'm afraid a version of the future (say in 20
> years), most applications stays with memfd_create with the old API
> style, not setting the NX bit. With the current approach, it might seem
> to be less convenient, but I hope it offers a bit of incentive to make
> applications migrating their code towards the new API, explicitly
> setting the NX bit.  I understand this hope is questionable, we might
> still end up the same in 20 years, but at least I tried :-). I will
> leave this decision to maintainers when you supply patches for that,
> and I wouldn't feel bad either way, there is a valid reason on both sides.

People will not switch =3D2 on if it has the possibility of breaking
existing programs that are doing nothing wrong by not passing a noop
flag.

In 20 years at best you would have =3D1 in widespread use because the
rewriting behaviour is what users expect of kernel uAPIs. They expect
old programs to work without modifying them if they aren't doing
anything wrong. A uAPI knob that requires every userspace program to
change before you can safely enable it (especially because it ratchets
in a way that makes it dangerous to enable on production machines) will
simply not be used.

If the goal is to get programs to update (which it seems it is), having
a knob that nobody will turn on doesn't help. Doing proper warning
logging is the way to get userspace to switch -- userspace usually
notices when their programs trigger warnings in dmesg.

> To supplement, there are  two other ways for what you want:
> 1> seccomp to block MFD_EXEC, and leaving the setting to 1.

I made this point in an earlier mail.

However my point is that =3D2 is not an acceptable uAPI and if you want
something that looks like =3D2 you can also implement that with seccomp
too!

In fact, the key difference is that you cannot implement the
rewriting easily in seccomp -- you would need to install a
seccomp_notify monitor that does nothing but rewrite syscall arguments.
This would be equivalent to running the entire system under GDB to work
around a uAPI flaw.

> 2> implement the blocking using a security hook and LSM, imo, which is
> probably the most common way to deal with this type of request (block
> something).

The issue is not the blocking, it's the rewriting.

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--w2o6q6aerims2enk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS2TklVsp+j1GPyqQYol/rSt+lEbwUCZMrPQAAKCRAol/rSt+lE
b4ZmAP4j1QzOrrlorZ9dFzAjKiWri6UkXw3KrM473BItd9lriAEA0JKOcWehL+c/
34o/eX/AOXwrJ9p80VBoPFsIqPj6TwY=
=I+84
-----END PGP SIGNATURE-----

--w2o6q6aerims2enk--
