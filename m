Return-Path: <linux-kselftest+bounces-44687-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E9E2C2E9D9
	for <lists+linux-kselftest@lfdr.de>; Tue, 04 Nov 2025 01:33:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C5A384E20D7
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Nov 2025 00:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A5491E00B4;
	Tue,  4 Nov 2025 00:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kvY85oEv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B86C1DE3DF
	for <linux-kselftest@vger.kernel.org>; Tue,  4 Nov 2025 00:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762216232; cv=none; b=MeXDLk6UT+pu0o6qfCGS+wFC9CwAl5g8kTf9Jz5KY8avVYA0BP6yrX31pWGmeqiyYca7asp2Ay2P9FYc1fw+rc90qUc0RR1jEevZjuG4weXH2liFs1s7Az4IbAcr5mYsVHpbB6IGQDnESVmPqvkIHO1wkb2wpZm/Td2tZ/B5LXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762216232; c=relaxed/simple;
	bh=CiLhLbG/M7HwnYjSqGUrPgkG+/V5ygCbc8QsfCLg1zo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QHDrirb1mvzhluakwGgXcpCYcloNWVEOUmJdW0GOUSAbSchr1ntD5hIEaTbkV0ToDANIEVjR+KusyxRaTExCWzGxZ33m0ELjU4sOv/dOKGNv2068kfxqGRguIxBDPfBbORzDsRwS+CooMLt2Ue3Zzju2f/3Aju/9pnWhYnJWyfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kvY85oEv; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-295df6ad56cso10110145ad.3
        for <linux-kselftest@vger.kernel.org>; Mon, 03 Nov 2025 16:30:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762216230; x=1762821030; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AqcCRqTl/qoCqnjiqKwU9PLeLoMNE7fr5oh2+DkTABg=;
        b=kvY85oEv9E7LDQMgG7XbiS4kjJE/8zQo8dVWfmRiohVaCopBFVcblOsD3haa5U0lkV
         Cb/qKI1fnu7vQoCVILzabC1ZjXIzchDSANP/VznfD2ABHYxACR64uryQSBnZrE7HBs2W
         JztfF3aQ8/Jtqv3gvWwATUohyXPBcVPXDB6blVgf82ajHG3wHIFNzTRu3QiLM+BD1pvX
         v6HbAPRsbz6bswBusAjv7UToUWk+EjK0VqrlSjEkjmt5vTFBlqD3sgegmvXWYoAYMb6g
         AnqfG1Au7OxQSb3ih1g9oytXWPwx3uwmaOTCW/wIlkewNdTtPXUJO0l1GHR8hqgTUe/N
         1yeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762216230; x=1762821030;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AqcCRqTl/qoCqnjiqKwU9PLeLoMNE7fr5oh2+DkTABg=;
        b=wL10RQ8k9+FEzGAflUGbs13SCujzXkuHerRH2gAS95anWd5CwIlGBSJBecircchTFS
         VN0zF8JBvWantvcXW6N+cs6IDiqBM5rMbrTOOyn0tRFIMTNX4kZZt+HYxqNP5X4W2k8G
         nVfpjM3oeUGVyxVFi9heaj4hp6p59ZuOH6ufFt76ACvyzh+IcS2D8aOtrA1PpVZUhRBZ
         PDGMveb7FGPABBbT/9prRiCEoBOs+KmqPxT/7QGsZh087m6k2501DsXVrIqaWwJ7RL+Z
         vEK1JiJ9o1wnqGZLEiC2qWV436H4R3zNlGR2WdB7QmJrRaNQSTvFaR8S7BckBcLrZMte
         XDFg==
X-Forwarded-Encrypted: i=1; AJvYcCWbjskk6BLLOatp5Jb38iURlYy6QKrhX74cR1Oq9NM3yOvdFwgV2+9XiFxRL6tkmYYfv4dEVt+O7L+lw5Fw23w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzabUS/cSoEwJkLSiRMZ0rrTgd8E8uU23q1KxeOoJRLuSDFfoFF
	ZcTQsOIQ1qmKftAa+xl3Idx2ArEydHRcGn5LZbWCna59pfjwb2c5OK0kw6VoqVxx7EBHHqrObM3
	BkpSy/+E9+0e+eOkVOP6nBeG6x7G9a81OffKr6dWg
X-Gm-Gg: ASbGncs8FiHqGjN3cu0XZh7EGEK4P2z+yshmIy6MNy/Me59SkTa0lnoy1oCuNCt85JA
	qGonHp1Yh6w6pdX8nyA6wMVCLTaTq9Z2I2wJqEH8fm+OM29UP88Y4okhlouPPJ5tWLgcbyy6EQ9
	j/fGXQc0oE2CoplJVEvfJiNTbhxb97vmvJzkobwWqgupSEvS7XOhUL/qP7y40iERfw/inzpOtbc
	aGgrA1ZiHOR+M1zpQ6IDV7d5KtFH9sYfY7121Dx1SPwMbvFQ1ukhykOtMgYFe21cDt5JdirOYtc
	jUmYoQZ93QtI4F/0TzOn1Msd6oJO
X-Google-Smtp-Source: AGHT+IF/TuzzM6UiR2btqhhnkzThmfNLPxoe+iiZUgfG0xqcwukxfOV9+GQogXuYNA/DvvkDwAKRLlZkf1zyd7gQ6dE=
X-Received: by 2002:a17:902:ea0b:b0:295:557e:746d with SMTP id
 d9443c01a7336-295557e7b03mr121283135ad.57.1762216229784; Mon, 03 Nov 2025
 16:30:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251101172230.10179-1-adelodunolaoluwa.ref@yahoo.com>
 <20251101172230.10179-1-adelodunolaoluwa@yahoo.com> <CAAVpQUDL1FB1nFYOZ6QuO+cGTqnpYNSaFtFD=YN742pyspe9ew@mail.gmail.com>
 <7a162b38-3ff8-4f97-aac3-4fe2ab50fe33@yahoo.com>
In-Reply-To: <7a162b38-3ff8-4f97-aac3-4fe2ab50fe33@yahoo.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Mon, 3 Nov 2025 16:30:18 -0800
X-Gm-Features: AWmQ_bnnGa6oY3iwc-ExLoQS270SjXZ6P7Ip3gcrLKuqdfofie0b35WwSthl_lo
Message-ID: <CAAVpQUADwghMj=SgdiZEErC5oy7RVpam4i9S2RwP19bA=Rbynw@mail.gmail.com>
Subject: Re: [PATCH v3] selftests: af_unix: Add tests for ECONNRESET and EOF semantics
To: Sunday Adelodun <adelodunolaoluwa@yahoo.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, shuah@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org, 
	david.hunter.linux@gmail.com, linux-kernel-mentees@lists.linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 3, 2025 at 4:08=E2=80=AFPM Sunday Adelodun
<adelodunolaoluwa@yahoo.com> wrote:
>
> On 11/2/25 08:32, Kuniyuki Iwashima wrote:
> > On Sat, Nov 1, 2025 at 10:23=E2=80=AFAM Sunday Adelodun
> > <adelodunolaoluwa@yahoo.com> wrote:
> >> Add selftests to verify and document Linux=E2=80=99s intended behaviou=
r for
> >> UNIX domain sockets (SOCK_STREAM and SOCK_DGRAM) when a peer closes.
> >> The tests verify that:
> >>
> >>   1. SOCK_STREAM returns EOF when the peer closes normally.
> >>   2. SOCK_STREAM returns ECONNRESET if the peer closes with unread dat=
a.
> >>   3. SOCK_SEQPACKET returns EOF when the peer closes normally.
> >>   4. SOCK_SEQPACKET returns ECONNRESET if the peer closes with unread =
data.
> >>   5. SOCK_DGRAM does not return ECONNRESET when the peer closes.
> >>
> >> This follows up on review feedback suggesting a selftest to clarify
> >> Linux=E2=80=99s semantics.
> >>
> >> Suggested-by: Kuniyuki Iwashima <kuniyu@google.com>
> >> Signed-off-by: Sunday Adelodun <adelodunolaoluwa@yahoo.com>
> >> ---
> >>   tools/testing/selftests/net/af_unix/Makefile  |   1 +
> >>   .../selftests/net/af_unix/unix_connreset.c    | 179 ++++++++++++++++=
++
> >>   2 files changed, 180 insertions(+)
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
> > patchwork caught this test is not added to .gitignore.
> > https://patchwork.kernel.org/project/netdevbpf/patch/20251101172230.101=
79-1-adelodunolaoluwa@yahoo.com/
> >
> > Could you add it to this file ?
> >
> > tools/testing/selftests/net/.gitignore
> Oh, thank you for this. will add it
> >
> >
> >>   # end of TEST_GEN_PROGS
> >>
> >>   include ../../lib.mk
> >> diff --git a/tools/testing/selftests/net/af_unix/unix_connreset.c b/to=
ols/testing/selftests/net/af_unix/unix_connreset.c
> >> new file mode 100644
> >> index 000000000000..6f43435d96e2
> >> --- /dev/null
> >> +++ b/tools/testing/selftests/net/af_unix/unix_connreset.c
> >> @@ -0,0 +1,179 @@
> >> +// SPDX-License-Identifier: GPL-2.0
> >> +/*
> >> + * Selftest for AF_UNIX socket close and ECONNRESET behaviour.
> >> + *
> >> + * This test verifies:
> >> + *  1. SOCK_STREAM returns EOF when the peer closes normally.
> >> + *  2. SOCK_STREAM returns ECONNRESET if peer closes with unread data=
.
> >> + *  3. SOCK_SEQPACKET returns EOF when the peer closes normally.
> >> + *  4. SOCK_SEQPACKET returns ECONNRESET if the peer closes with unre=
ad data.
> >> + *  5. SOCK_DGRAM does not return ECONNRESET when the peer closes.
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
> > nit: outdated, maybe simply remove ?
> oh..skipped me.
> will do so.
> >
> >> +FIXTURE_VARIANT_ADD(unix_sock, stream) {
> >> +       .socket_type =3D SOCK_STREAM,
> >> +       .name =3D "SOCK_STREAM",
> >> +};
> >> +
> >> +FIXTURE_VARIANT_ADD(unix_sock, dgram) {
> >> +       .socket_type =3D SOCK_DGRAM,
> >> +       .name =3D "SOCK_DGRAM",
> >> +};
> >> +
> >> +FIXTURE_VARIANT_ADD(unix_sock, seqpacket) {
> >> +       .socket_type =3D SOCK_SEQPACKET,
> >> +       .name =3D "SOCK_SEQPACKET",
> >> +};
> >> +
> >> +FIXTURE_SETUP(unix_sock)
> >> +{
> >> +       struct sockaddr_un addr =3D {};
> >> +       int err;
> >> +
> >> +       addr.sun_family =3D AF_UNIX;
> >> +       strcpy(addr.sun_path, SOCK_PATH);
> >> +       remove_socket_file();
> >> +
> >> +       self->server =3D socket(AF_UNIX, variant->socket_type, 0);
> >> +       ASSERT_LT(-1, self->server);
> >> +
> >> +       err =3D bind(self->server, (struct sockaddr *)&addr, sizeof(ad=
dr));
> >> +       ASSERT_EQ(0, err);
> >> +
> >> +       if (variant->socket_type =3D=3D SOCK_STREAM ||
> >> +               variant->socket_type =3D=3D SOCK_SEQPACKET) {
> > patchwork caught mis-alignment here and other places.
> >
> > I'm using this for emacs, and other editors will have a similar config.
> >
> > (setq-default c-default-style "linux")
> >
> > You can check if lines are aligned properly by
> >
> > $ git show --format=3Demail | ./scripts/checkpatch.pl
> >
> >
> >> +               err =3D listen(self->server, 1);
> >> +               ASSERT_EQ(0, err);
> >> +
> >> +               self->client =3D socket(AF_UNIX, variant->socket_type,=
 0);
> > Could you add SOCK_NONBLOCK here too ?
> This is noted
> >
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
> >> +       if (variant->socket_type =3D=3D SOCK_STREAM ||
> >> +               variant->socket_type =3D=3D SOCK_SEQPACKET)
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
> >> +       /* Peer closes normally */
> >> +       if (variant->socket_type =3D=3D SOCK_STREAM ||
> >> +               variant->socket_type =3D=3D SOCK_SEQPACKET)
> >> +               close(self->child);
> >> +       else
> >> +               close(self->server);
> >> +
> >> +       n =3D recv(self->client, buf, sizeof(buf), 0);
> >> +       TH_LOG("%s: recv=3D%zd errno=3D%d (%s)", variant->name, n, err=
no, strerror(errno));
> > errno is undefined if not set, and same for strerror(errno).
> >
> > Also, if ASSERT_XXX() below fails, the same information
> > (test case, errno) is logged.  So, TH_LOG() seems unnecessary.
> >
> > Maybe try modifying the condition below and see how the
> > assertion is logged.
> Oh..thank you. Didn't it through that way.
> I understand.
> I will remove the TH_LOG()'s
> >
> >> +       if (variant->socket_type =3D=3D SOCK_STREAM ||
> >> +               variant->socket_type =3D=3D SOCK_SEQPACKET) {
> >> +               ASSERT_EQ(0, n);
> >> +       } else {
> >> +               ASSERT_EQ(-1, n);
> >> +               ASSERT_EQ(EAGAIN, errno);
> >> +       }
> >> +}
> >> +
> >> +/* Test 2: peer closes with unread data */
> >> +TEST_F(unix_sock, reset_unread)
> >> +{
> >> +       char buf[16] =3D {};
> >> +       ssize_t n;
> >> +
> >> +       /* Send data that will remain unread by client */
> >> +       send(self->client, "hello", 5, 0);
> >> +       close(self->child);
> >> +
> >> +       n =3D recv(self->client, buf, sizeof(buf), 0);
> >> +       TH_LOG("%s: recv=3D%zd errno=3D%d (%s)", variant->name, n, err=
no, strerror(errno));
> >> +       if (variant->socket_type =3D=3D SOCK_STREAM ||
> >> +               variant->socket_type =3D=3D SOCK_SEQPACKET) {
> >> +               ASSERT_EQ(-1, n);
> >> +               ASSERT_EQ(ECONNRESET, errno);
> >> +       } else {
> >> +               ASSERT_EQ(-1, n);
> >> +               ASSERT_EQ(EAGAIN, errno);
> >> +       }
> >> +}
> >> +
> >> +/* Test 3: SOCK_DGRAM peer close */
> >> Now Test 2 and Test 3 look identical ;)
>
> seems so, but the only difference is:
>
> close(self->child); is used in Test 2, while
> close(self->server); is used in Test 3.
> Maybe I should find a way to collapse Tests 2 and 3 (if statement might
> work)
>
> I am just afraid the tests to run will reduce to 6 from 9 and we will hav=
e 6
> cases passed as against 7 as before.
>
> What do you think?

The name of Test 2 is a bit confusing, which is not true
for SOCK_DGRAM.  So, I'd use "if" to change which fd
to close() depending on the socket type.

Also, close(self->server) does nothing for SOCK_STREAM
and SOCK_SEQPACKET after accept().  Rather, that close()
should have the same effect if self->child is not accept()ed.
(In this case, Skip() for SOCK_DGRAM makes sense)

I think covering that scenario would be nicer.

If interested, you can check the test coverage with this patch.
https://lore.kernel.org/linux-kselftest/20251028024339.2028774-1-kuniyu@goo=
gle.com/

Thanks!

