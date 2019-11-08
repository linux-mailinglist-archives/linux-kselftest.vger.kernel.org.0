Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 28384F40B3
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Nov 2019 07:44:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725802AbfKHGo2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 8 Nov 2019 01:44:28 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:30899 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725372AbfKHGo2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 8 Nov 2019 01:44:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573195467;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8lM40lFP4drHIgc2WtqtIvW6FTL4t/S6w7ABeeLcRLo=;
        b=eVvr09B82pYpOF26xmZVqJolGa+lHZzejvadiiiTK35LC+YhU52CF7EU/BlS3CThCMalr1
        rTD0F/7kp28MoN95H4ZI1HTXdlJ7WzukkIzdliYC+IQO1eh2Rbd6mU5Dq7Lsb0wqWzNt2l
        CLNvXSZdTW9C6Sr8BALLMJoFydxUnJQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-165-KZfxqVJeNZywUsP5u8dF_A-1; Fri, 08 Nov 2019 01:44:24 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5211A800C72;
        Fri,  8 Nov 2019 06:44:23 +0000 (UTC)
Received: from dcbz.redhat.com (ovpn-116-182.ams2.redhat.com [10.36.116.182])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3CC606084E;
        Fri,  8 Nov 2019 06:44:19 +0000 (UTC)
Date:   Fri, 8 Nov 2019 07:44:16 +0100
From:   Adrian Reber <areber@redhat.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Shuah Khan <shuah@kernel.org>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] selftests: add tests for clone3()
Message-ID: <20191108064416.GA153851@dcbz.redhat.com>
References: <20191104131846.1076814-1-areber@redhat.com>
 <20191106155914.hzolyolz2w4hcn7w@wittgenstein>
MIME-Version: 1.0
In-Reply-To: <20191106155914.hzolyolz2w4hcn7w@wittgenstein>
X-Operating-System: Linux (5.3.8-300.fc31.x86_64)
X-Load-Average: 0.69 0.92 0.93
X-Unexpected: The Spanish Inquisition
X-GnuPG-Key: gpg --recv-keys D3C4906A
Organization: Red Hat
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: KZfxqVJeNZywUsP5u8dF_A-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Nov 06, 2019 at 04:59:15PM +0100, Christian Brauner wrote:
> On Mon, Nov 04, 2019 at 02:18:46PM +0100, Adrian Reber wrote:
> > This adds tests for clone3() with different values and sizes
> > of struct clone_args.
> >=20
> > This selftest was initially part of of the clone3() with PID selftest.
> > After that patch was almost merged Eugene sent out a couple of patches
> > to fix problems with these test.
> >=20
> > This commit now only contains the clone3() selftest after the LPC
> > decision to rework clone3() with PID to allow setting the PID in
> > multiple PID namespaces including all of Eugene's patches.
> >=20
> > Signed-off-by: Eugene Syromiatnikov <esyr@redhat.com>
> > Signed-off-by: Adrian Reber <areber@redhat.com>
>=20
> Resending, since mutt messed-up the quoting due to a new configuration I
> was testing.
>=20
> A few more comments below.
>=20
> Also, would you be open to adding tests here for the newly added .stack
> and .stack_size API (cf. [1])?
>=20
> [1]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/c=
ommit/?id=3Dfa729c4df558936b4a1a7b3e2234011f44ede28b

As mentioned in your follow-up email. Let's do that in a later patch.

> > ---
> > v2:
> >  - Applied Christian's suggestions
> >  - Skip root-only tests when running as non-root
> > ---
> >  MAINTAINERS                               |   1 +
> >  tools/testing/selftests/Makefile          |   1 +
> >  tools/testing/selftests/clone3/.gitignore |   1 +
> >  tools/testing/selftests/clone3/Makefile   |   7 +
> >  tools/testing/selftests/clone3/clone3.c   | 225 ++++++++++++++++++++++
> >  5 files changed, 235 insertions(+)
> >  create mode 100644 tools/testing/selftests/clone3/.gitignore
> >  create mode 100644 tools/testing/selftests/clone3/Makefile
> >  create mode 100644 tools/testing/selftests/clone3/clone3.c
> >=20
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index cba1095547fd..0040b7a6410b 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -12829,6 +12829,7 @@ S:=09Maintained
> >  T:=09git git://git.kernel.org/pub/scm/linux/kernel/git/brauner/linux.g=
it
> >  F:=09samples/pidfd/
> >  F:=09tools/testing/selftests/pidfd/
> > +F:=09tools/testing/selftests/clone3/
> >  K:=09(?i)pidfd
> >  K:=09(?i)clone3
> >  K:=09\b(clone_args|kernel_clone_args)\b
> > diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests=
/Makefile
> > index 4cdbae6f4e61..ad442364218a 100644
> > --- a/tools/testing/selftests/Makefile
> > +++ b/tools/testing/selftests/Makefile
> > @@ -4,6 +4,7 @@ TARGETS +=3D bpf
> >  TARGETS +=3D breakpoints
> >  TARGETS +=3D capabilities
> >  TARGETS +=3D cgroup
> > +TARGETS +=3D clone3
> >  TARGETS +=3D cpufreq
> >  TARGETS +=3D cpu-hotplug
> >  TARGETS +=3D drivers/dma-buf
> > diff --git a/tools/testing/selftests/clone3/.gitignore b/tools/testing/=
selftests/clone3/.gitignore
> > new file mode 100644
> > index 000000000000..85d9d3ba2524
> > --- /dev/null
> > +++ b/tools/testing/selftests/clone3/.gitignore
> > @@ -0,0 +1 @@
> > +clone3
> > diff --git a/tools/testing/selftests/clone3/Makefile b/tools/testing/se=
lftests/clone3/Makefile
> > new file mode 100644
> > index 000000000000..ea922c014ae4
> > --- /dev/null
> > +++ b/tools/testing/selftests/clone3/Makefile
> > @@ -0,0 +1,7 @@
> > +# SPDX-License-Identifier: GPL-2.0
> > +
> > +CFLAGS +=3D -I../../../../usr/include/
> > +
> > +TEST_GEN_PROGS :=3D clone3
> > +
> > +include ../lib.mk
> > diff --git a/tools/testing/selftests/clone3/clone3.c b/tools/testing/se=
lftests/clone3/clone3.c
> > new file mode 100644
> > index 000000000000..a982d95189bf
> > --- /dev/null
> > +++ b/tools/testing/selftests/clone3/clone3.c
> > @@ -0,0 +1,225 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +/* Based on Christian Brauner's clone3() example */
> > +
> > +#define _GNU_SOURCE
> > +#include <errno.h>
> > +#include <inttypes.h>
> > +#include <linux/types.h>
> > +#include <linux/sched.h>
> > +#include <stdint.h>
> > +#include <stdio.h>
> > +#include <stdlib.h>
> > +#include <sys/syscall.h>
> > +#include <sys/types.h>
> > +#include <sys/un.h>
> > +#include <sys/wait.h>
> > +#include <unistd.h>
> > +#include <sched.h>
> > +
> > +#include "../kselftest.h"
> > +
> > +/*
> > + * Different sizes of struct clone_args
> > + */
> > +#ifndef CLONE3_ARGS_SIZE_V0
> > +#define CLONE3_ARGS_SIZE_V0 64
> > +#endif
> > +
> > +enum test_mode {
> > +=09CLONE3_ARGS_NO_TEST,
> > +=09CLONE3_ARGS_ALL_0,
> > +=09CLONE3_ARGS_ALL_1,
> > +=09CLONE3_ARGS_INVAL_EXIT_SIGNAL_BIG,
> > +=09CLONE3_ARGS_INVAL_EXIT_SIGNAL_NEG,
> > +=09CLONE3_ARGS_INVAL_EXIT_SIGNAL_CSIG,
> > +=09CLONE3_ARGS_INVAL_EXIT_SIGNAL_NSIG,
> > +};
> > +
> > +static pid_t raw_clone(struct clone_args *args, size_t size)
> > +{
> > +=09return syscall(__NR_clone3, args, size);
> > +}
> > +
> > +static int call_clone3(uint64_t flags, size_t size, enum test_mode tes=
t_mode)
> > +{
> > +=09struct clone_args args =3D {
> > +=09=09.flags =3D flags,
> > +=09=09.exit_signal =3D SIGCHLD,
> > +=09};
> > +
> > +=09struct clone_args_extended {
> > +=09=09struct clone_args args;
> > +=09=09__aligned_u64 excess_space[2];
> > +=09} args_ext;
> > +
> > +=09pid_t pid =3D -1;
> > +=09int status;
> > +
> > +=09memset(&args_ext, 0, sizeof(args_ext));
> > +=09if (size > sizeof(struct clone_args))
> > +=09=09args_ext.excess_space[1] =3D 1;
> > +
> > +=09if (size =3D=3D 0)
> > +=09=09size =3D sizeof(struct clone_args);
> > +
> > +=09switch (test_mode) {
> > +=09case CLONE3_ARGS_ALL_0:
> > +=09=09args.flags =3D 0;
> > +=09=09args.exit_signal =3D 0;
> > +=09=09break;
> > +=09case CLONE3_ARGS_ALL_1:
>=20
> I don't fully understand this test case. What is this for exactly?

Not sure myself. It was just to make sure clone3() does not something
unexpected when given wrong and unexpected input. It is the opposite to
setting everything to zero. Not sure how much sense it makes, but as it
already exists I would say to just keep it.

> > +=09=09args.flags =3D 1;
> > +=09=09args.pidfd =3D 1;
> > +=09=09args.child_tid =3D 1;
> > +=09=09args.parent_tid =3D 1;
> > +=09=09args.exit_signal =3D 1;
> > +=09=09args.stack =3D 1;
> > +=09=09args.stack_size =3D 1;
> > +=09=09args.tls =3D 1;
> > +=09=09break;
> > +=09case CLONE3_ARGS_INVAL_EXIT_SIGNAL_BIG:
[...]

Let me know if you think that the CLONE3_ARGS_ALL_1 should really be
removed. I will fix the other two things you mentioned and resend a new
version.

=09=09Adrian

