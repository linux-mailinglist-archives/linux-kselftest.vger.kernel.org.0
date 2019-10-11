Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0AB00D4A39
	for <lists+linux-kselftest@lfdr.de>; Sat, 12 Oct 2019 00:12:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729341AbfJKWMf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 11 Oct 2019 18:12:35 -0400
Received: from mx2a.mailbox.org ([80.241.60.219]:24435 "EHLO mx2a.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728719AbfJKWMf (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 11 Oct 2019 18:12:35 -0400
Received: from smtp2.mailbox.org (smtp2.mailbox.org [80.241.60.241])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx2a.mailbox.org (Postfix) with ESMTPS id 013FEA2475;
        Sat, 12 Oct 2019 00:12:31 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by hefe.heinlein-support.de (hefe.heinlein-support.de [91.198.250.172]) (amavisd-new, port 10030)
        with ESMTP id awj_3okSA5oP; Sat, 12 Oct 2019 00:12:26 +0200 (CEST)
Date:   Sat, 12 Oct 2019 09:12:08 +1100
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     Michael Kerrisk <mtk.manpages@gmail.com>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Florian Weimer <fweimer@redhat.com>, libc-alpha@sourceware.org,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Shuah Khan <shuah@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Roman Gushchin <guro@fb.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "Dmitry V. Levin" <ldv@altlinux.org>,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 1/2] clone3: add CLONE3_CLEAR_SIGHAND
Message-ID: <20191011221208.5eglbazksfigliob@yavin.dot.cyphar.com>
References: <20191010133518.5420-1-christian.brauner@ubuntu.com>
 <CAHO5Pa3V7fDb_+U-v+LB+TeAU0vfJyUMs9mD4ZqUtbLpZcD4nA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="dznhhg5jfs2k76ol"
Content-Disposition: inline
In-Reply-To: <CAHO5Pa3V7fDb_+U-v+LB+TeAU0vfJyUMs9mD4ZqUtbLpZcD4nA@mail.gmail.com>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--dznhhg5jfs2k76ol
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2019-10-11, Michael Kerrisk <mtk.manpages@gmail.com> wrote:
> Why CLONE3_CLEAR_SIGHAND rather than just CLONE_CLEAR_SIGHAND?

There are no more flag bits left for the classic clone()/clone2() (the
last one was used up by CLONE_PIDFD) -- thus this flag is clone3()-only.

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--dznhhg5jfs2k76ol
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSxZm6dtfE8gxLLfYqdlLljIbnQEgUCXaD+NAAKCRCdlLljIbnQ
EsXLAP4svXcWl20h3G+bd587VKul6LgrZoHh8ME/zbe/4bqIygD+KiTbpJcNbA2S
nyKwJIJkd/7LCZoh82sx/bDaoiDAdAQ=
=scKk
-----END PGP SIGNATURE-----

--dznhhg5jfs2k76ol--
