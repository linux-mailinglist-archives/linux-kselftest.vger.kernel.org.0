Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBDA376DE4F
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Aug 2023 04:36:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233737AbjHCCge (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 2 Aug 2023 22:36:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230210AbjHCCgQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 2 Aug 2023 22:36:16 -0400
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75ACF4C0E;
        Wed,  2 Aug 2023 19:34:36 -0700 (PDT)
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4RGXl92DZNz9sSv;
        Thu,  3 Aug 2023 04:25:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
        t=1691029557;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QDaQQq8N3pV/0zOSm0S8Jmeu7eQz2E5FW0Ju7kYcogY=;
        b=Y1QMaVE0KtysYE+lwk1MnyWvrQxXJS9qbQlv2SuhvCeiQhrJnugZ6PyoP5TdBjHVlcHA6W
        61Z7A2b1SDPlD6gmsQsoVh91sHohyYVSGA5TZzJDK/nOlqlfcbPORdD0H9pCU8B35nG2WA
        Yv4yh7KeNg7PI59PogMuBQvzEGr/M7xCPzPM6t8yBxr3nKcnRIShRimmUiAbhNgukDtjkH
        92zM38Uv9/yEiWW+aEpxEHex3y3BnhkcH4qsf65XwM0y6Mu/2fwRPGa63Dzox9sZKLyo6V
        LFZjG+/BfNweZpbLMGAt61Fl8isAN0qJHseIuhGyUKmmJOsKqBiC9nNnHTD1qA==
Date:   Thu, 3 Aug 2023 12:25:42 +1000
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     Jeff Xu <jeffxu@google.com>
Cc:     Shuah Khan <shuah@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Verkamp <dverkamp@chromium.org>,
        Kees Cook <keescook@chromium.org>, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 3/3] selftests: memfd: error out test process when
 child test fails
Message-ID: <20230803.022458-mundane.voyage.tricky.kinship-yaSxczr9O6cB@cyphar.com>
References: <20230713143406.14342-1-cyphar@cyphar.com>
 <20230713143406.14342-4-cyphar@cyphar.com>
 <CALmYWFsusw5H6aa9Po6QyEKr7beUSTN+PmGzc0Er0tuGEmYCbA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ol7adjwswqudaxv6"
Content-Disposition: inline
In-Reply-To: <CALmYWFsusw5H6aa9Po6QyEKr7beUSTN+PmGzc0Er0tuGEmYCbA@mail.gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--ol7adjwswqudaxv6
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2023-07-19, Jeff Xu <jeffxu@google.com> wrote:
> On Thu, Jul 13, 2023 at 7:34=E2=80=AFAM Aleksa Sarai <cyphar@cyphar.com> =
wrote:
> >
> > Before this change, a test runner using this self test would see a
> > return code of 0 when the tests using a child process (namely the
> > MFD_NOEXEC_SEAL and MFD_EXEC tests) failed, masking test failures.
> >
> > Fixes: 11f75a01448f ("selftests/memfd: add tests for MFD_NOEXEC_SEAL MF=
D_EXEC")
> > Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
> > ---
> >  tools/testing/selftests/memfd/memfd_test.c | 19 ++++++++++++++++++-
> >  1 file changed, 18 insertions(+), 1 deletion(-)
> >
> > diff --git a/tools/testing/selftests/memfd/memfd_test.c b/tools/testing=
/selftests/memfd/memfd_test.c
> > index d8342989c547..8b7390ad81d1 100644
> > --- a/tools/testing/selftests/memfd/memfd_test.c
> > +++ b/tools/testing/selftests/memfd/memfd_test.c
> > @@ -1219,7 +1219,24 @@ static pid_t spawn_newpid_thread(unsigned int fl=
ags, int (*fn)(void *))
> >
> >  static void join_newpid_thread(pid_t pid)
> >  {
> > -       waitpid(pid, NULL, 0);
> > +       int wstatus;
> > +
> > +       if (waitpid(pid, &wstatus, 0) < 0) {
> > +               printf("newpid thread: waitpid() failed: %m\n");
> > +               abort();
> > +       }
> > +
> > +       if (WIFEXITED(wstatus) && WEXITSTATUS(wstatus) !=3D 0) {
> > +               printf("newpid thread: exited with non-zero error code =
%d\n",
> > +                      WEXITSTATUS(wstatus));
> > +               abort();
> > +       }
> > +
> > +       if (WIFSIGNALED(wstatus)) {
> > +               printf("newpid thread: killed by signal %d\n",
> > +                      WTERMSIG(wstatus));
> > +               abort();
> > +       }
> >  }
> >
> Signed-off-by: Jeff Xu <jeffxu@google.com>

Did you mean for this to a Reviewed-by?

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--ol7adjwswqudaxv6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS2TklVsp+j1GPyqQYol/rSt+lEbwUCZMsQJgAKCRAol/rSt+lE
b6fuAP9ki0uOZxhvg7UYVxVmtgV9baTK8Br1vb4etGtmEfZ1IwEAg8kjMvzzv+mb
zmU0bhe6uOd5ZHdu5KCubvPCLtWzow0=
=mmRd
-----END PGP SIGNATURE-----

--ol7adjwswqudaxv6--
