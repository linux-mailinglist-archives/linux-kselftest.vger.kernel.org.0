Return-Path: <linux-kselftest+bounces-44550-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B6CD7C26CE9
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Oct 2025 20:41:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4AC994E1D0B
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Oct 2025 19:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FD1A30E825;
	Fri, 31 Oct 2025 19:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CO47Guhd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DB912C0F63
	for <linux-kselftest@vger.kernel.org>; Fri, 31 Oct 2025 19:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761939702; cv=none; b=kpMneyLNMRTgECYDd/6N5YUEJ515hTQUT7A/GGAOdg/5RQy7xaKzzDJNBmkkwKVAo2x5BdTxJU53JNMjzBZEP8Sx6yAyOASdCkQ40oKCC3C5VpyXXxtb9Y6kJEvbJ12Hgxc0lfiq6tPV8qt7jHyOdF5HPQZ6xFGtfwIYenPdOZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761939702; c=relaxed/simple;
	bh=maRK7XpfoR92vY8Ydni5YVMz4/Px/3eFRr8cqwFVDz4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bsFn69vSHvvs46XbzJgGHqj54/8MNdUnM/wN/qgJ/Ps5q22dlVZ0zDdO59/4oCEXqVcWxsRWJgyd2+R/6TjJfYJ3JPuefUekrrHcFLQJ2o7HXwe1aHk8hVH4u51iE3hsOe7P9S5a1MgW6wYRWB1rjeHLup2hHSAsJJcnBzxxyGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CO47Guhd; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-63c1a0d6315so5367069a12.1
        for <linux-kselftest@vger.kernel.org>; Fri, 31 Oct 2025 12:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761939699; x=1762544499; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dYbfNT0Vc8/TiytLOjgG9hBzeApOsG89ichqEMIxreo=;
        b=CO47GuhdUeuvY3nDtLjGgL2JLFbFwiScv0qtUocZSNhfoh4EA1EDNTyZsTe1IOkltF
         2OZgqk88DXzyVIYx4eMdFIkAzfFzGqm7sLnpCdAclCLjjN7f5rk06K6eVlZL1zJMEe2H
         W2bTWnP+7j2/qBYpXE8upTRv/T8lGKOvRCkZP+wD7S8Zzg25NT5laz8XB1H2KHKYDGp3
         IdG4vCXewqwvs8LZC9pr5TeG7LLvXwciMcH5V3DPTAMQ4vWYOxeeUzS/56CRXYP5dnHR
         RDZye2fp1dKjDtsZCWE6E20Wx+TkInrCxw4EYgbcmky/ERAbgAv0or8LedfqjGKfkQGa
         wvqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761939699; x=1762544499;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dYbfNT0Vc8/TiytLOjgG9hBzeApOsG89ichqEMIxreo=;
        b=F41TpWs/5tP7Kb75zda5KUamgaqC55Eo6v/5HOeqILBouQg3mQuiIQBlN9p5yg0RFY
         Co0EoExPM0F/OpUwPKhioYYpf3sAwOEj5w64rNMev5yBcER9hJIphpkZRhYHKvk+EQ9y
         cYdoOIkxXcp1JnxJINtaRfIHzalBIRxg/IkSEWfVDxn7IG7hSPK7Ow8nA6U733eUFD6e
         MyrV3kwJYeZv84Cakz7XkQxIkAINxylOUp+G625ZHU1M9TSvBGRBZzLEloWKrEVfHa4x
         KFDejEKugeWwByQv2i9KdHzD+z46haQh8l6ogKC+POfy1awaea6qyWs/HGmDNYU4VF40
         Huqw==
X-Forwarded-Encrypted: i=1; AJvYcCXcu3KsTOcQ0aoWKJ1TYntvmwwTdKwngPiZRWJklTE6RwJkCzwIQHeAJa0LAwFNHJpuTCDxYSD2PBSDmf0PWNo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDejmOLPAJ+5DHv6cYPMtbHwXdi9CsqeIt5bfvK37lCnIzqNRk
	46pk6DvEzIzDh0+J+XDODXj4KQCZAySKBZn3ZZYAmKhkYTp9cF512zlKFJNAo/k6UC0EFE2bRiE
	xsw8YNwhNDIn3gA5sndYJDZW26CqQHVPT2i0WtjWZ
X-Gm-Gg: ASbGncuxWW7+Yyq6frUFx9jH6DYUyIMK4XuNVKEVEWC+NEMHudzfzgHZCO+p4EAxcyj
	Ynr8zF00SxMt+0uckx0zfe65NnIkJS93hms82/6t6O/u/H/coun+YbdF4ufyKhKZZ1E4lD9NOlA
	iuMC8VxM040T3C2FIoJQF4YCxApStO6UPWzRezPFIN8/zGr6DQb75JPKL09gXD0etMR6c2YUNey
	wTTRvzB7Qo4EEr4Rjkr9LnDypyjHcyrDWcQohTxdTPU7kD9z908mHADCrcReH/f521UhaCaRruM
	NkH36MCs+I03+x4/OA==
X-Google-Smtp-Source: AGHT+IGP39uKZ8Ldsc5A2MSKFDiQ/EXttriDPIq9JhsO1OWBc5tum20Be7vZowWj6ukKGFaTckz2hYue61ejofW9WFY=
X-Received: by 2002:a05:6402:274b:b0:634:6bca:2d1c with SMTP id
 4fb4d7f45d1cf-64077081fafmr4171016a12.26.1761939698354; Fri, 31 Oct 2025
 12:41:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251025190256.11352-1-adelodunolaoluwa.ref@yahoo.com>
 <20251025190256.11352-1-adelodunolaoluwa@yahoo.com> <CAAVpQUAbDfaiAZ_NCppGE5vsafWoU7V1xvnqtQQM44cwv6jHsA@mail.gmail.com>
 <7c4070ed-1702-4288-90c6-7edb90468718@yahoo.com>
In-Reply-To: <7c4070ed-1702-4288-90c6-7edb90468718@yahoo.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Fri, 31 Oct 2025 12:41:22 -0700
X-Gm-Features: AWmQ_bn_XVrMh5WLNVzJVx0p1VBoVnrz3YR-LeQYxE8Gmud4G1IaBv7E36TYekY
Message-ID: <CAAVpQUAT8CVwQfSXq+P78kgPVy8gyD9thEgBcAz45Jpxh=1smw@mail.gmail.com>
Subject: Re: [PATCH v2] selftests: af_unix: Add tests for ECONNRESET and EOF semantics
To: Sunday Adelodun <adelodunolaoluwa@yahoo.com>
Cc: "=David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, 
	David Hunter <david.hunter.linux@gmail.com>, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel-mentees@lists.linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 30, 2025 at 6:45=E2=80=AFAM Sunday Adelodun
<adelodunolaoluwa@yahoo.com> wrote:
>
> On 10/28/25 19:28, Kuniyuki Iwashima wrote:
> > On Sat, Oct 25, 2025 at 12:03=E2=80=AFPM Sunday Adelodun
> > <adelodunolaoluwa@yahoo.com> wrote:
> >> Add selftests to verify and document Linux=E2=80=99s intended behaviou=
r for
> >> UNIX domain sockets (SOCK_STREAM and SOCK_DGRAM) when a peer closes.
> >> The tests cover:
> >>
> >>    1. EOF returned when a SOCK_STREAM peer closes normally.
> >>    2. ECONNRESET returned when a SOCK_STREAM peer closes with unread d=
ata.
> >>    3. SOCK_DGRAM sockets not returning ECONNRESET on peer close.
> >>
> >> This follows up on review feedback suggesting a selftest to clarify
> >> Linux=E2=80=99s semantics.
> >>
> >> Suggested-by: Kuniyuki Iwashima <kuniyu@google.com>
> >> Signed-off-by: Sunday Adelodun <adelodunolaoluwa@yahoo.com>
> >> ---
> >> Changelog:
> >>
> >> Changes made from v1:
> >>
> >> - Patch prefix updated to selftest: af_unix:.
> >>
> >> - All mentions of =E2=80=9CUNIX=E2=80=9D changed to AF_UNIX.
> >>
> >> - Removed BSD references from comments.
> >>
> >> - Shared setup refactored using FIXTURE_VARIANT().
> >>
> >> - Cleanup moved to FIXTURE_TEARDOWN() to always run.
> >>
> >> - Tests consolidated to reduce duplication: EOF, ECONNRESET, SOCK_DGRA=
M peer close.
> >>
> >> - Corrected ASSERT usage and initialization style.
> >>
> >> - Makefile updated for new directory af_unix.
> >>
> >>   tools/testing/selftests/net/af_unix/Makefile  |   1 +
> >>   .../selftests/net/af_unix/unix_connreset.c    | 161 ++++++++++++++++=
++
> >>   2 files changed, 162 insertions(+)
> >>   create mode 100644 tools/testing/selftests/net/af_unix/unix_connrese=
t.c
> >>
> >> diff --git a/tools/testing/selftests/net/af_unix/Makefile b/tools/test=
ing/selftests/net/af_unix/Makefile
> >> index de805cbbdf69..5826a8372451 100644
> >> --- a/tools/testing/selftests/net/af_unix/Makefile
> >> +++ b/tools/testing/selftests/net/af_unix/Makefile
> >> @@ -7,6 +7,7 @@ TEST_GEN_PROGS :=3D \
> >>          scm_pidfd \
> >>          scm_rights \
> >>          unix_connect \
> >> +       unix_connreset \
> >>   # end of TEST_GEN_PROGS
> >>
> >>   include ../../lib.mk
> >> diff --git a/tools/testing/selftests/net/af_unix/unix_connreset.c b/to=
ols/testing/selftests/net/af_unix/unix_connreset.c
> >> new file mode 100644
> >> index 000000000000..c65ec997d77d
> >> --- /dev/null
> >> +++ b/tools/testing/selftests/net/af_unix/unix_connreset.c
> >> @@ -0,0 +1,161 @@
> >> +// SPDX-License-Identifier: GPL-2.0
> >> +/*
> >> + * Selftest for AF_UNIX socket close and ECONNRESET behaviour.
> >> + *
> >> + * This test verifies that:
> >> + *  1. SOCK_STREAM sockets return EOF when peer closes normally.
> >> + *  2. SOCK_STREAM sockets return ECONNRESET if peer closes with unre=
ad data.
> >> + *  3. SOCK_DGRAM sockets do not return ECONNRESET when peer closes.
> >> + *
> >> + * These tests document the intended Linux behaviour.
> >> + *
> >> + */
> >> +
> >> +#define _GNU_SOURCE
> >> +#include <stdlib.h>
> >> +#include <string.h>
> >> +#include <fcntl.h>
> >> +#include <unistd.h>
> >> +#include <errno.h>
> >> +#include <sys/socket.h>
> >> +#include <sys/un.h>
> >> +#include "../../kselftest_harness.h"
> >> +
> >> +#define SOCK_PATH "/tmp/af_unix_connreset.sock"
> >> +
> >> +static void remove_socket_file(void)
> >> +{
> >> +       unlink(SOCK_PATH);
> >> +}
> >> +
> >> +FIXTURE(unix_sock)
> >> +{
> >> +       int server;
> >> +       int client;
> >> +       int child;
> >> +};
> >> +
> >> +FIXTURE_VARIANT(unix_sock)
> >> +{
> >> +       int socket_type;
> >> +       const char *name;
> >> +};
> >> +
> >> +/* Define variants: stream and datagram */
> >> +FIXTURE_VARIANT_ADD(unix_sock, stream) {
> >> +       .socket_type =3D SOCK_STREAM,
> >> +       .name =3D "SOCK_STREAM",
> >> +};
> >> +
> >> +FIXTURE_VARIANT_ADD(unix_sock, dgram) {
> >> +       .socket_type =3D SOCK_DGRAM,
> >> +       .name =3D "SOCK_DGRAM",
> >> +};
> > Let's add coverage for SOCK_SEQPACKET,
> > which needs listen() / connect() but other semantics
> > are similar to SOCK_DGRAM.
>
> I will add it through:
> if (variant->socket_type =3D=3D SOCK_STREAM ||
>                 variant->socket_type =3D=3D SOCK_SEQPACKET)
>
>
> in both the setup and teardown fixtures with a little bit of modification
>
> where necessary (especially in the setup fixture).
>
> And also the fixture_variant_add macro.
>
> >> +
> >> +FIXTURE_SETUP(unix_sock)
> >> +{
> >> +       struct sockaddr_un addr =3D {};
> >> +       int err;
> >> +
> >> +       addr.sun_family =3D AF_UNIX;
> >> +       strcpy(addr.sun_path, SOCK_PATH);
> >> +
> >> +       self->server =3D socket(AF_UNIX, variant->socket_type, 0);
> >> +       ASSERT_LT(-1, self->server);
> >> +
> >> +       err =3D bind(self->server, (struct sockaddr *)&addr, sizeof(ad=
dr));
> >> +       ASSERT_EQ(0, err);
> >> +
> >> +       if (variant->socket_type =3D=3D SOCK_STREAM) {
> >> +               err =3D listen(self->server, 1);
> >> +               ASSERT_EQ(0, err);
> >> +
> >> +               self->client =3D socket(AF_UNIX, SOCK_STREAM, 0);
> >> +               ASSERT_LT(-1, self->client);
> >> +
> >> +               err =3D connect(self->client, (struct sockaddr *)&addr=
, sizeof(addr));
> >> +               ASSERT_EQ(0, err);
> >> +
> >> +               self->child =3D accept(self->server, NULL, NULL);
> >> +               ASSERT_LT(-1, self->child);
> >> +       } else {
> >> +               /* Datagram: bind and connect only */
> >> +               self->client =3D socket(AF_UNIX, SOCK_DGRAM | SOCK_NON=
BLOCK, 0);
> >> +               ASSERT_LT(-1, self->client);
> >> +
> >> +               err =3D connect(self->client, (struct sockaddr *)&addr=
, sizeof(addr));
> >> +               ASSERT_EQ(0, err);
> >> +       }
> >> +}
> >> +
> >> +FIXTURE_TEARDOWN(unix_sock)
> >> +{
> >> +       if (variant->socket_type =3D=3D SOCK_STREAM)
> >> +               close(self->child);
> >> +
> >> +       close(self->client);
> >> +       close(self->server);
> >> +       remove_socket_file();
> >> +}
> >> +
> >> +/* Test 1: peer closes normally */
> >> +TEST_F(unix_sock, eof)
> >> +{
> >> +       char buf[16] =3D {};
> >> +       ssize_t n;
> >> +
> >> +       if (variant->socket_type !=3D SOCK_STREAM)
> >> +               SKIP(return, "This test only applies to SOCK_STREAM");
> > Instead of skipping, let's define final ASSERT() results
> > for each type.
> >
> > Same for other 2 tests.
>
> can I use a switch statement in all the tests? say, for example

switch() is completely fine, but I guess "if" will be shorter :)

>
> test1:
>
> ...
>
> switch (variant->socket_type) {
>
> case SOCK_STREAM:
>
> case SOCK_SEQPACKET:
>
>          ASSERT_EQ(0, n);

You need break; here.

>
> case SOCK_DGRAM:
>
>          ASSERT(-1, n);
>
>          ASSERT_EQ(EAGAIN, errno);
>
>          break;

And also please make sure the compiler will not complain
without default: depending on inherited build options.

>
> }
>
> ...
>
> test2:
>
> ...
>
> switch (variant->socket_type) {
>
> case SOCK_STREAM:
>
> case SOCK_SEQPACKET:
>
>          ASSERT_EQ(-1, n);
>
>          ASSERT_EQ(ECONNRESET, errno);
>
>          break;
>
> case SOCK_DGRAM:
>
>          ASSERT(-1, n);
>
>          ASSERT_EQ(EAGAIN, errno);
>
>          break;
>
> }
> ...
>
> test 3:
>
> ...
>
> switch (variant->socket_type) {
>
> case SOCK_STREAM:
>
> case SOCK_SEQPACKET:
>
>          ASSERT_EQ(-1, n);
>
>          ASSERT_EQ(ECONNRESET, errno);
>
>          break;
>
> case SOCK_DGRAM:
>
>          ASSERT(-1, n);
>
>          ASSERT_EQ(EAGAIN, errno);
>
>          break;
>
> }
>
> ...
>
> if not these, could you kindly shed more light to what you meant
>
> >
> >
> >> +
> >> +       /* Peer closes normally */
> >> +       close(self->child);
> >> +
> >> +       n =3D recv(self->client, buf, sizeof(buf), 0);
> >> +       TH_LOG("%s: recv=3D%zd errno=3D%d (%s)", variant->name, n, err=
no, strerror(errno));
> >> +       if (n =3D=3D -1)
> >> +               ASSERT_EQ(ECONNRESET, errno);
> > ... otherwise, we don't see an error here
> >
> >> +
> >> +       if (n !=3D -1)
> >> +               ASSERT_EQ(0, n);
> > and this can be checked unconditionally.
> did you mean I should remove the if (n !=3D -1) ASSERT_EQ(0, n); part?

If SOCK_DGRAM does not reuse this test, yes.

The point is we do not want to miss future regression by
preparing both if (n =3D=3D -1) case and if  (n =3D=3D 0) case, one
of which should never happen at this point.

Thanks!

