Return-Path: <linux-kselftest+bounces-45066-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 98A8AC3EB0E
	for <lists+linux-kselftest@lfdr.de>; Fri, 07 Nov 2025 08:07:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 32CC14E1C84
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Nov 2025 07:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78CB0306D26;
	Fri,  7 Nov 2025 07:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BvKbk7Ci"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A8ED306494
	for <linux-kselftest@vger.kernel.org>; Fri,  7 Nov 2025 07:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762499235; cv=none; b=FLqVAAPZZfQPFSy5BlEAvDX8HTGHycVvE2M+u7lCnQbp7Dexn5LnJ/veTecJ7Sm3yX64tyfHQCjl2h5mjBdfkIQ5NfQN7cK9K+AKFzzpOPc3p30ZSUh1wb7pLoLVXaR+mvCve+NjjCe4ye6Jq0WwQ1VY5FFopBBeLBQTOs31q8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762499235; c=relaxed/simple;
	bh=lCs49KFxoMFrIEOoTD/naUkYVoUfAQLWK8wiieZIm4Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bjpV7aoFa0sSSV7dD7QKSv1NCr1whecEhlBuhidX2Kre4YmIVELwftX9l3Kv5gCbvvq3U/RT7KMiKGrgOvXZ0mfmtynYBEGgijYEqONWGHQ+3ztABc751griw1rSssLRjnhP19mEYDZE4UYy+hHOPE3wTDBtdRvlL02kdXs1cAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BvKbk7Ci; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-3418ad76023so1334994a91.0
        for <linux-kselftest@vger.kernel.org>; Thu, 06 Nov 2025 23:07:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762499233; x=1763104033; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ic3ja93/cQk65eeTH/cK94gVyAPs95zGxwNR/6EByzY=;
        b=BvKbk7CiJKYMPqTB4IdMgoxVWaI8wNqZSU2VJif88gjbQ3biSC+O6cD3HsG4lkl5s9
         t5ZFE6R8Tfv7znJJj7nkmPvaKFLO0lRqcOkY34YwuoMvk8jziTvQUMQuN3BFubxiVG0Z
         SbXaT39JFQAFJCl9peHqOHRbbmUYgInbW6SyfKiEEYZ8ZMV5PF20kE8fwtlQYGAh2+q7
         s9+adq2qVO4F4jJBTsqzbqNtxdYH2QlGy49pCYxqbpgQPmYSDuhhTkw75sI7n4TXDLUN
         CCBAkH8wInOLI0BimVt9vHk/lHUyzqnU9x0mAXnKgrxt7PF0rzT28qkywXm7W7wToejW
         Q+Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762499233; x=1763104033;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ic3ja93/cQk65eeTH/cK94gVyAPs95zGxwNR/6EByzY=;
        b=s1hHJnUXv9QrEw6OuNGBuMftJmrEW27DsADMBP//8CG9Q/gpWJiID1dED206JZLDmF
         qBNVk2R/v9S1ikmEmCBC2zViDKzivF8U/SYrLn7+3se+DBbmXS8aUcd9qpEb7YTmZIKs
         ZegFlXyZXvRhEDLw91k7fmQrwKrb0WJ24x4S072pUFmlq1b7y7XiHRym4km389CDcxC3
         /kppw4ouQyJmwXgzTr2lDZKzMpsGLRsyil3G+HZyISXd7BNHM37+9CzsfFjV5XF+RX9y
         UHCZE2O2GmIIJx9OveFB8BWz1Ch18nw3GrxJN0PSpKZP956wVoGG0YhrymHVx6rWDIz0
         o2pg==
X-Forwarded-Encrypted: i=1; AJvYcCWZurZLeiO4rNhZ2COuo7aH1b5gceMcmLz+Ei6w+AQ5Ih9nN1O/h814CuriAZ/GsmXJTjzkGwEXbvKLld3ZWlU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUxBL1coCQJqzGJOn0mqSnbFGrE6EIdFDWUOzd96XS5I+133KX
	w2J6dcIwkrQeFHZkwIsYD7ZJBHh6VE+SXbtu4ApYEuXlRJl8o0u2t8EV4rEeCjzSU6RyMtxY53w
	fG3czTQ==
X-Google-Smtp-Source: AGHT+IH2L5WyheD68FMlbVolIrglj717q0H4sRdOJCtkxJmx1Vd7u+k1RenCsJ0Dimw0+3YuwtXbTfHiGzU=
X-Received: from plav13.prod.google.com ([2002:a17:902:f0cd:b0:290:28e2:ce4b])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d503:b0:295:2cb6:f4a8
 with SMTP id d9443c01a7336-297c046c3bfmr30844965ad.51.1762499232838; Thu, 06
 Nov 2025 23:07:12 -0800 (PST)
Date: Fri,  7 Nov 2025 07:05:42 +0000
In-Reply-To: <26835ada-4e3a-4f78-8705-4ed2e3d44bd8@yahoo.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <26835ada-4e3a-4f78-8705-4ed2e3d44bd8@yahoo.com>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251107070711.2369272-1-kuniyu@google.com>
Subject: Re: [PATCH v3] selftests: af_unix: Add tests for ECONNRESET and EOF semantics
From: Kuniyuki Iwashima <kuniyu@google.com>
To: adelodunolaoluwa@yahoo.com
Cc: davem@davemloft.net, david.hunter.linux@gmail.com, edumazet@google.com, 
	horms@kernel.org, kuba@kernel.org, kuniyu@google.com, 
	linux-kernel-mentees@lists.linuxfoundation.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	shuah@kernel.org, skhan@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

From: Sunday Adelodun <adelodunolaoluwa@yahoo.com>
Date: Tue, 4 Nov 2025 11:42:47 +0100
> On 11/4/25 01:30, Kuniyuki Iwashima wrote:
> > On Mon, Nov 3, 2025 at 4:08=E2=80=AFPM Sunday Adelodun
> > <adelodunolaoluwa@yahoo.com> wrote:
> >> On 11/2/25 08:32, Kuniyuki Iwashima wrote:
> >>> On Sat, Nov 1, 2025 at 10:23=E2=80=AFAM Sunday Adelodun
> >>> <adelodunolaoluwa@yahoo.com> wrote:
> >>>> Add selftests to verify and document Linux=E2=80=99s intended behavi=
our for
> >>>> UNIX domain sockets (SOCK_STREAM and SOCK_DGRAM) when a peer closes.
> >>>> The tests verify that:
> >>>>
> >>>>    1. SOCK_STREAM returns EOF when the peer closes normally.
> >>>>    2. SOCK_STREAM returns ECONNRESET if the peer closes with unread =
data.
> >>>>    3. SOCK_SEQPACKET returns EOF when the peer closes normally.
> >>>>    4. SOCK_SEQPACKET returns ECONNRESET if the peer closes with unre=
ad data.
> >>>>    5. SOCK_DGRAM does not return ECONNRESET when the peer closes.
> >>>>
> >>>> This follows up on review feedback suggesting a selftest to clarify
> >>>> Linux=E2=80=99s semantics.
> >>>>
> >>>> Suggested-by: Kuniyuki Iwashima <kuniyu@google.com>
> >>>> Signed-off-by: Sunday Adelodun <adelodunolaoluwa@yahoo.com>
> >>>> ---
> >>>>    tools/testing/selftests/net/af_unix/Makefile  |   1 +
> >>>>    .../selftests/net/af_unix/unix_connreset.c    | 179 +++++++++++++=
+++++
> >>>>    2 files changed, 180 insertions(+)
> >>>>    create mode 100644 tools/testing/selftests/net/af_unix/unix_connr=
eset.c
> >>>>
> >>>> diff --git a/tools/testing/selftests/net/af_unix/Makefile b/tools/te=
sting/selftests/net/af_unix/Makefile
> >>>> index de805cbbdf69..5826a8372451 100644
> >>>> --- a/tools/testing/selftests/net/af_unix/Makefile
> >>>> +++ b/tools/testing/selftests/net/af_unix/Makefile
> >>>> @@ -7,6 +7,7 @@ TEST_GEN_PROGS :=3D \
> >>>>           scm_pidfd \
> >>>>           scm_rights \
> >>>>           unix_connect \
> >>>> +       unix_connreset \
> >>> patchwork caught this test is not added to .gitignore.
> >>> https://patchwork.kernel.org/project/netdevbpf/patch/20251101172230.1=
0179-1-adelodunolaoluwa@yahoo.com/
> >>>
> >>> Could you add it to this file ?
> >>>
> >>> tools/testing/selftests/net/.gitignore
> >> Oh, thank you for this. will add it
> >>>
> >>>>    # end of TEST_GEN_PROGS
> >>>>
> >>>>    include ../../lib.mk
> >>>> diff --git a/tools/testing/selftests/net/af_unix/unix_connreset.c b/=
tools/testing/selftests/net/af_unix/unix_connreset.c
> >>>> new file mode 100644
> >>>> index 000000000000..6f43435d96e2
> >>>> --- /dev/null
> >>>> +++ b/tools/testing/selftests/net/af_unix/unix_connreset.c
> >>>> @@ -0,0 +1,179 @@
> >>>> +// SPDX-License-Identifier: GPL-2.0
> >>>> +/*
> >>>> + * Selftest for AF_UNIX socket close and ECONNRESET behaviour.
> >>>> + *
> >>>> + * This test verifies:
> >>>> + *  1. SOCK_STREAM returns EOF when the peer closes normally.
> >>>> + *  2. SOCK_STREAM returns ECONNRESET if peer closes with unread da=
ta.
> >>>> + *  3. SOCK_SEQPACKET returns EOF when the peer closes normally.
> >>>> + *  4. SOCK_SEQPACKET returns ECONNRESET if the peer closes with un=
read data.
> >>>> + *  5. SOCK_DGRAM does not return ECONNRESET when the peer closes.
> >>>> + *
> >>>> + * These tests document the intended Linux behaviour.
> >>>> + *
> >>>> + */
> >>>> +
> >>>> +#define _GNU_SOURCE
> >>>> +#include <stdlib.h>
> >>>> +#include <string.h>
> >>>> +#include <fcntl.h>
> >>>> +#include <unistd.h>
> >>>> +#include <errno.h>
> >>>> +#include <sys/socket.h>
> >>>> +#include <sys/un.h>
> >>>> +#include "../../kselftest_harness.h"
> >>>> +
> >>>> +#define SOCK_PATH "/tmp/af_unix_connreset.sock"
> >>>> +
> >>>> +static void remove_socket_file(void)
> >>>> +{
> >>>> +       unlink(SOCK_PATH);
> >>>> +}
> >>>> +
> >>>> +FIXTURE(unix_sock)
> >>>> +{
> >>>> +       int server;
> >>>> +       int client;
> >>>> +       int child;
> >>>> +};
> >>>> +
> >>>> +FIXTURE_VARIANT(unix_sock)
> >>>> +{
> >>>> +       int socket_type;
> >>>> +       const char *name;
> >>>> +};
> >>>> +
> >>>> +/* Define variants: stream and datagram */
> >>> nit: outdated, maybe simply remove ?
> >> oh..skipped me.
> >> will do so.
> >>>> +FIXTURE_VARIANT_ADD(unix_sock, stream) {
> >>>> +       .socket_type =3D SOCK_STREAM,
> >>>> +       .name =3D "SOCK_STREAM",
> >>>> +};
> >>>> +
> >>>> +FIXTURE_VARIANT_ADD(unix_sock, dgram) {
> >>>> +       .socket_type =3D SOCK_DGRAM,
> >>>> +       .name =3D "SOCK_DGRAM",
> >>>> +};
> >>>> +
> >>>> +FIXTURE_VARIANT_ADD(unix_sock, seqpacket) {
> >>>> +       .socket_type =3D SOCK_SEQPACKET,
> >>>> +       .name =3D "SOCK_SEQPACKET",
> >>>> +};
> >>>> +
> >>>> +FIXTURE_SETUP(unix_sock)
> >>>> +{
> >>>> +       struct sockaddr_un addr =3D {};
> >>>> +       int err;
> >>>> +
> >>>> +       addr.sun_family =3D AF_UNIX;
> >>>> +       strcpy(addr.sun_path, SOCK_PATH);
> >>>> +       remove_socket_file();
> >>>> +
> >>>> +       self->server =3D socket(AF_UNIX, variant->socket_type, 0);
> >>>> +       ASSERT_LT(-1, self->server);
> >>>> +
> >>>> +       err =3D bind(self->server, (struct sockaddr *)&addr, sizeof(=
addr));
> >>>> +       ASSERT_EQ(0, err);
> >>>> +
> >>>> +       if (variant->socket_type =3D=3D SOCK_STREAM ||
> >>>> +               variant->socket_type =3D=3D SOCK_SEQPACKET) {
> >>> patchwork caught mis-alignment here and other places.
> >>>
> >>> I'm using this for emacs, and other editors will have a similar confi=
g.
> >>>
> >>> (setq-default c-default-style "linux")
> >>>
> >>> You can check if lines are aligned properly by
> >>>
> >>> $ git show --format=3Demail | ./scripts/checkpatch.pl
> >>>
> >>>
> >>>> +               err =3D listen(self->server, 1);
> >>>> +               ASSERT_EQ(0, err);
> >>>> +
> >>>> +               self->client =3D socket(AF_UNIX, variant->socket_typ=
e, 0);
> >>> Could you add SOCK_NONBLOCK here too ?
> >> This is noted
> >>>> +               ASSERT_LT(-1, self->client);
> >>>> +
> >>>> +               err =3D connect(self->client, (struct sockaddr *)&ad=
dr, sizeof(addr));
> >>>> +               ASSERT_EQ(0, err);
> >>>> +
> >>>> +               self->child =3D accept(self->server, NULL, NULL);
> >>>> +               ASSERT_LT(-1, self->child);
> >>>> +       } else {
> >>>> +               /* Datagram: bind and connect only */
> >>>> +               self->client =3D socket(AF_UNIX, SOCK_DGRAM | SOCK_N=
ONBLOCK, 0);
> >>>> +               ASSERT_LT(-1, self->client);
> >>>> +
> >>>> +               err =3D connect(self->client, (struct sockaddr *)&ad=
dr, sizeof(addr));
> >>>> +               ASSERT_EQ(0, err);
> >>>> +       }
> >>>> +}
> >>>> +
> >>>> +FIXTURE_TEARDOWN(unix_sock)
> >>>> +{
> >>>> +       if (variant->socket_type =3D=3D SOCK_STREAM ||
> >>>> +               variant->socket_type =3D=3D SOCK_SEQPACKET)
> >>>> +               close(self->child);
> >>>> +
> >>>> +       close(self->client);
> >>>> +       close(self->server);
> >>>> +       remove_socket_file();
> >>>> +}
> >>>> +
> >>>> +/* Test 1: peer closes normally */
> >>>> +TEST_F(unix_sock, eof)
> >>>> +{
> >>>> +       char buf[16] =3D {};
> >>>> +       ssize_t n;
> >>>> +
> >>>> +       /* Peer closes normally */
> >>>> +       if (variant->socket_type =3D=3D SOCK_STREAM ||
> >>>> +               variant->socket_type =3D=3D SOCK_SEQPACKET)
> >>>> +               close(self->child);
> >>>> +       else
> >>>> +               close(self->server);
> >>>> +
> >>>> +       n =3D recv(self->client, buf, sizeof(buf), 0);
> >>>> +       TH_LOG("%s: recv=3D%zd errno=3D%d (%s)", variant->name, n, e=
rrno, strerror(errno));
> >>> errno is undefined if not set, and same for strerror(errno).
> >>>
> >>> Also, if ASSERT_XXX() below fails, the same information
> >>> (test case, errno) is logged.  So, TH_LOG() seems unnecessary.
> >>>
> >>> Maybe try modifying the condition below and see how the
> >>> assertion is logged.
> >> Oh..thank you. Didn't it through that way.
> >> I understand.
> >> I will remove the TH_LOG()'s
> >>>> +       if (variant->socket_type =3D=3D SOCK_STREAM ||
> >>>> +               variant->socket_type =3D=3D SOCK_SEQPACKET) {
> >>>> +               ASSERT_EQ(0, n);
> >>>> +       } else {
> >>>> +               ASSERT_EQ(-1, n);
> >>>> +               ASSERT_EQ(EAGAIN, errno);
> >>>> +       }
> >>>> +}
> >>>> +
> >>>> +/* Test 2: peer closes with unread data */
> >>>> +TEST_F(unix_sock, reset_unread)
> >>>> +{
> >>>> +       char buf[16] =3D {};
> >>>> +       ssize_t n;
> >>>> +
> >>>> +       /* Send data that will remain unread by client */
> >>>> +       send(self->client, "hello", 5, 0);
> >>>> +       close(self->child);
> >>>> +
> >>>> +       n =3D recv(self->client, buf, sizeof(buf), 0);
> >>>> +       TH_LOG("%s: recv=3D%zd errno=3D%d (%s)", variant->name, n, e=
rrno, strerror(errno));
> >>>> +       if (variant->socket_type =3D=3D SOCK_STREAM ||
> >>>> +               variant->socket_type =3D=3D SOCK_SEQPACKET) {
> >>>> +               ASSERT_EQ(-1, n);
> >>>> +               ASSERT_EQ(ECONNRESET, errno);
> >>>> +       } else {
> >>>> +               ASSERT_EQ(-1, n);
> >>>> +               ASSERT_EQ(EAGAIN, errno);
> >>>> +       }
> >>>> +}
> >>>> +
> >>>> +/* Test 3: SOCK_DGRAM peer close */
> >>>> Now Test 2 and Test 3 look identical ;)
> >> seems so, but the only difference is:
> >>
> >> close(self->child); is used in Test 2, while
> >> close(self->server); is used in Test 3.
> >> Maybe I should find a way to collapse Tests 2 and 3 (if statement migh=
t
> >> work)
> >>
> >> I am just afraid the tests to run will reduce to 6 from 9 and we will =
have 6
> >> cases passed as against 7 as before.
> >>
> >> What do you think?
> > The name of Test 2 is a bit confusing, which is not true
> > for SOCK_DGRAM.  So, I'd use "if" to change which fd
> > to close() depending on the socket type.
> >
> > Also, close(self->server) does nothing for SOCK_STREAM
> > and SOCK_SEQPACKET after accept().  Rather, that close()
> > should have the same effect if self->child is not accept()ed.
> > (In this case, Skip() for SOCK_DGRAM makes sense)
> >
> > I think covering that scenario would be nicer.
> >
> > If interested, you can check the test coverage with this patch.
> > https://lore.kernel.org/linux-kselftest/20251028024339.2028774-1-kuniyu=
@google.com/
> >
> > Thanks!
> Thank you!
>=20
> kindly check these if any conforms to what it should be:
>=20
> TEST_F(unix_sock, reset_unread_behavior)
> {
>          char buf[16] =3D {};
>          ssize_t n;
>=20
>          /* Send data that will remain unread by client */
>          send(self->client, "hello", 5, 0);
>=20
>          if (variant->socket_type =3D=3D SOCK_DGRAM) {
>                  close(self->server);
>          }
>          else {
>                  if (!self->child)
>                          SKIP(return);
>=20
>                  close(self->child);
>          }
>=20
>          n =3D recv(self->client, buf, sizeof(buf), 0);
>=20
>          ASSERT_EQ(-1, n);
>=20
>          if (variant->socket_type =3D=3D SOCK_STREAM ||
>                  variant->socket_type =3D=3D SOCK_SEQPACKET)
>                  do { ASSERT_EQ(ECONNRESET, errno); } while (0);
>          else
>                  ASSERT_EQ(EAGAIN, errno);
> }
>=20
> OR
>=20
> TEST_F(unix_sock, reset_unread_behavior)
> {
>          char buf[16] =3D {};
>          ssize_t n;
>=20
>          /* Send data that will remain unread by client */
>          send(self->client, "hello", 5, 0);
>=20
>          if (variant->socket_type =3D=3D SOCK_DGRAM) {
>                  close(self->server);
>          }
>          else {
>                  if (self->child)
>                      close(self->child);
>                  else
>                      close(self->server);
>          }
>=20
>          n =3D recv(self->client, buf, sizeof(buf), 0);
>=20
>          ASSERT_EQ(-1, n);
>=20
>          if (variant->socket_type =3D=3D SOCK_STREAM ||
>                  variant->socket_type =3D=3D SOCK_SEQPACKET)
>                  do { ASSERT_EQ(ECONNRESET, errno); } while (0);
>          else
>                  ASSERT_EQ(EAGAIN, errno);
> }
>=20
> OR
>=20
> is there a better way to handle this?

Sorry for late!

What I had in mind is to move accept() in FIXTURE_SETUP() to
Test 1 & 2 (then, only listen() is conditional in FIXTURE_SETUP())
and rewrite Test 3 to cover the last ECONNRESET case caused by
close()ing un-accept()ed sockets:

TEST_F(unix_sock, reset_closed_embryo)
{
	if (variant->socket_type =3D=3D SOCK_DGRAM)
		SKIP(return, "This test only applies to SOCK_STREAM and SOCK_SEQPACKET");

	close(self->server);

	n =3D recv(self->client, ...);
	ASSERT_EQ(-1, n);
	ASSERT_EQ(ECONNRESET, errno);
}


>=20
> I ran the KCOV_OUTPUT command using the first *TEST_F above* as the Test=
=20
> 2 and got the output below:
> *$ KCOV_OUTPUT=3Dkcov KCOV_SLOTS=3D8192=20
> ./tools/testing/selftests/net/af_unix/unix_connreset*

You should be able to see line-by-line coverage by decoding
files under kcov with addr2line or vock/report.py.

Thanks!

