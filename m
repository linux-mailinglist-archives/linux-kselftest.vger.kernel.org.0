Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0902DD4C98
	for <lists+linux-kselftest@lfdr.de>; Sat, 12 Oct 2019 06:08:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727688AbfJLEIz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 12 Oct 2019 00:08:55 -0400
Received: from mx2a.mailbox.org ([80.241.60.219]:42745 "EHLO mx2a.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727440AbfJLEIy (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 12 Oct 2019 00:08:54 -0400
Received: from smtp2.mailbox.org (smtp2.mailbox.org [80.241.60.241])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx2a.mailbox.org (Postfix) with ESMTPS id 0485AA1104;
        Sat, 12 Oct 2019 06:08:47 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by hefe.heinlein-support.de (hefe.heinlein-support.de [91.198.250.172]) (amavisd-new, port 10030)
        with ESMTP id WQcjjXFgeVVi; Sat, 12 Oct 2019 06:08:40 +0200 (CEST)
Date:   Sat, 12 Oct 2019 15:08:15 +1100
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Arnd Bergmann <arnd@arndb.de>,
        David Howells <dhowells@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Andy Lutomirski <luto@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>, Tycho Andersen <tycho@tycho.ws>,
        David Drysdale <drysdale@google.com>,
        Chanho Min <chanho.min@lge.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Christian Brauner <christian@brauner.io>,
        Aleksa Sarai <asarai@suse.de>,
        Linux Containers <containers@lists.linux-foundation.org>,
        alpha <linux-alpha@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        GNU C Library <libc-alpha@sourceware.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-ia64@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org,
        linux-s390 <linux-s390@vger.kernel.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        linux-xtensa@linux-xtensa.org, sparclinux@vger.kernel.org
Subject: Re: [PATCH v14 2/6] namei: LOOKUP_IN_ROOT: chroot-like path
 resolution
Message-ID: <20191012040815.gnc43cfmo5mnv67u@yavin.dot.cyphar.com>
References: <20191010054140.8483-1-cyphar@cyphar.com>
 <20191010054140.8483-3-cyphar@cyphar.com>
 <CAHk-=wh8L50f31vW8BwRUXhLiq3eoCQ3tg8ER4Yp2dzuU1w5rQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="t2fxesclfr677pzw"
Content-Disposition: inline
In-Reply-To: <CAHk-=wh8L50f31vW8BwRUXhLiq3eoCQ3tg8ER4Yp2dzuU1w5rQ@mail.gmail.com>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--t2fxesclfr677pzw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2019-10-10, Linus Torvalds <torvalds@linux-foundation.org> wrote:
> On Wed, Oct 9, 2019 at 10:42 PM Aleksa Sarai <cyphar@cyphar.com> wrote:
> >
> > --- a/fs/namei.c
> > +++ b/fs/namei.c
> > @@ -2277,6 +2277,11 @@ static const char *path_init(struct nameidata *n=
d, unsigned flags)
> >
> >         nd->m_seq =3D read_seqbegin(&mount_lock);
> >
> > +       /* LOOKUP_IN_ROOT treats absolute paths as being relative-to-di=
rfd. */
> > +       if (flags & LOOKUP_IN_ROOT)
> > +               while (*s =3D=3D '/')
> > +                       s++;
> > +
> >         /* Figure out the starting path and root (if needed). */
> >         if (*s =3D=3D '/') {
> >                 error =3D nd_jump_root(nd);
>=20
> Hmm. Wouldn't this make more sense all inside the if (*s =3D- '/') test?
> That way if would be where we check for "should we start at the root",
> which seems to make more sense conceptually.

I don't really agree (though I do think that both options are pretty
ugly). Doing it before the block makes it clear that absolute paths are
just treated relative-to-dirfd -- doing it inside the block makes it
look more like "/" is a special-case for nd_jump_root(). And while that
is somewhat true, this is just a side-effect of making the code more
clean -- my earlier versions reworked the dirfd handling to always grab
nd->root first if LOOKUP_IS_SCOPED. I switched to this method based on
Al's review.

In fairness, I do agree that the lonely while loop looks ugly.

> That test for '/' currently has a "} else if (..)", but that's
> pointless since it ends with a "return" anyway. So the "else" logic is
> just noise.

This depends on the fact that LOOKUP_BENEATH always triggers -EXDEV for
nd_jump_root() -- if we ever add another "scoped lookup" flag then the
logic will have to be further reworked.

(It should be noted that the new version doesn't always end with a
"return", but you could change it to act that way given the above
assumption.)

> And if you get rid of the unnecessary else, moving the LOOKUP_IN_ROOT
> inside the if-statement works fine.
>=20
> So this could be something like
>=20
>     --- a/fs/namei.c
>     +++ b/fs/namei.c
>     @@ -2194,11 +2196,19 @@ static const char *path_init(struct
> nameidata *nd, unsigned flags)
>=20
>         nd->m_seq =3D read_seqbegin(&mount_lock);
>         if (*s =3D=3D '/') {
>     -           set_root(nd);
>     -           if (likely(!nd_jump_root(nd)))
>     -                   return s;
>     -           return ERR_PTR(-ECHILD);
>     -   } else if (nd->dfd =3D=3D AT_FDCWD) {
>     +           /* LOOKUP_IN_ROOT treats absolute paths as being
> relative-to-dirfd. */
>     +           if (!(flags & LOOKUP_IN_ROOT)) {
>     +                   set_root(nd);
>     +                   if (likely(!nd_jump_root(nd)))
>     +                           return s;
>     +                   return ERR_PTR(-ECHILD);
>     +           }
>     +
>     +           /* Skip initial '/' for LOOKUP_IN_ROOT */
>     +           do { s++; } while (*s =3D=3D '/');
>     +   }
>     +
>     +   if (nd->dfd =3D=3D AT_FDCWD) {
>                 if (flags & LOOKUP_RCU) {
>                         struct fs_struct *fs =3D current->fs;
>                         unsigned seq;
>=20
> instead. The patch ends up slightly bigger (due to the re-indentation)
> but now it handles all the "start at root" in the same place. Doesn't
> that make sense?

It is correct (though I'd need to clean it up a bit to handle
nd_jump_root() correctly), and if you really would like me to change it
I will -- but I just don't agree that it's cleaner.

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--t2fxesclfr677pzw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSxZm6dtfE8gxLLfYqdlLljIbnQEgUCXaFRqQAKCRCdlLljIbnQ
El00AQDKyu1GNvL91tAxvDZP/2rrqVrUf7Ad1T8uobD+aKQbgwEAvz9eeuLveRVq
aqnd3Ifu8HO4SYcqYn+hDFgDz5D5Kwo=
=XXCi
-----END PGP SIGNATURE-----

--t2fxesclfr677pzw--
