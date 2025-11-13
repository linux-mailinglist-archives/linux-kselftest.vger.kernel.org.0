Return-Path: <linux-kselftest+bounces-45512-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 145CEC55E37
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Nov 2025 07:10:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EA9254E20FB
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Nov 2025 06:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B51A03164BE;
	Thu, 13 Nov 2025 06:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TVqSNd4S"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDA273009F1
	for <linux-kselftest@vger.kernel.org>; Thu, 13 Nov 2025 06:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763014246; cv=none; b=i1cQc6bVyuDrNKn+xU73NVgpkOuSj+XXb2LuUJBSVf+1qgomKOCJcaHJnPRGnuQ/w+MW8bfeH0QQO7SG0Hf5MbSk26u99j7f50NUCGJ8tKc/OUKYwuECx8+e47ymADv1BFV70lzpxQ5xK/YAzBZteKXA7YdZXP5J9iTfL/hPR7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763014246; c=relaxed/simple;
	bh=JZgVvkmMqovaXMNVarstuvuRVnP6+Gz5DgI1eqaAwSY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mxpi40iO9tHyvDVQMMiNud0+/dyWrOf4I0mr2ujcIAS6hSUy18fMEUKKM26M9f7LeB437rXiRSsnie6rgkATcm8XVmwcpaPThqWVmbYZjLblI2p2L1rDItb+VlbwRgWt1qYn0VpRiCpaiT3lPE/95leubuB+aWmC2Fkj6Xen0vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TVqSNd4S; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2953e415b27so4029185ad.2
        for <linux-kselftest@vger.kernel.org>; Wed, 12 Nov 2025 22:10:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763014244; x=1763619044; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gW6r0ASCKhJNFYglngEFExHVzU4sK+KFa1j2mIqWseg=;
        b=TVqSNd4Sj9961nj8iCyR9/BtFVZ+K0eI5yQEpgHjP0pAC+6T92Tbh+wxv3rcyim+A9
         nDST8k+4BzESzDuixgdClboBasWuod9cmdr3qrc1sf/dxavZN0eXFJWSP7L9dyBuwRcD
         ZU5LDkeAFvQq8kmWfDrSt68A4jk78OyqiFtoek2nrBtH3q6z2ARxVRsPsSgLxfGgvjWC
         6Dbql7gVLR9AH6CTq94Dx4Rp8WIOC4DHzKnFSIxeqI8cvZpdhjMSnRzM3JrvIH8D62vG
         3jGBU9UdQHzr/wh40OilDMhf/F4xhsYAFzUXtNpHB+ZOLyjnfxNC/9mzzeXIpiEQIczS
         xOjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763014244; x=1763619044;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gW6r0ASCKhJNFYglngEFExHVzU4sK+KFa1j2mIqWseg=;
        b=aSFMHzMj3bBfSySiPHDHwfUPJu+m/iq7yAeVQKfhInwUG/NMp1ea59YKLCSU6Quntr
         f4U7+AmqLSf4USjHEyHXh/SMc8z5QQOfA9hAwOGw79SIiCLOBGrVLP37O7Nzz1oHF6uf
         rUnYzjEwtsOZ6TvSGtDTZcc9/fMK9ANixIiPhnjEMfJMtF+f6NkQ1r/sFwud4ZGjGKZb
         9Rj9mngTnsEFyxVWEQnTllxuSxLxikDcV2MKF7BtbVl+mIawpw8nNUj/dWH92P4wIRwv
         Lmp+fOtgPqPsTX1iz453k8bna4TbdFIXO8tZQVhbP1f4rCIiEhZBmW4wGmHEsatWUFEF
         yLOA==
X-Forwarded-Encrypted: i=1; AJvYcCXd4tKKhVK2WaWP7DT2B4juVgU387DLMoVlUfADvkHeuUSOq1lFYQHbIjpr7hM1JyK2bSKA6BgwRT0bVYhucIg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxS8Z0kjys+SvioILxtbAzh5KMRnKI3PbUZrvG9ku0zY/H4uM5H
	oprsFk5FnW64pQS+pCgyeYf7zvc2t5qHin18s00Fyv0pJdFr2/cbFD3DWCGW6KD5EmUStzUV1Pa
	3k2VjjCF5n7YHChcjToikL4paCUmNWAPZP57QMfQg
X-Gm-Gg: ASbGncvqQxD2SCfFqH8wQabVJMNTMwi7zAbKZ8e5Us1jpJgFR9KJUDA8a68/zcw7Bjm
	7OBvgATDe5U2d/AzUS5PFXhUsJ9bJWaVm9874M3M0hY0YEGTJeDLzMQBX4fuUJ51odT4ltH8IFp
	mBhiTOrkigO83oFCEkGH+cibH/DWjVXGrmv8I2j1lygMYxBSFBBapcxQS7ipDWFbB3Y7DEU6wgl
	pN7xx2t1wGm0FCPmivRfoBCxqJ2r0raXzrmupcxeZkpPka0GihbdO0TWzRckzCHi66S1cf5qMMX
	UUNN8OFCvHxbI0RFR9Zb1cflHyvvg7/lIrkWKcRx0NDBFukzmA==
X-Google-Smtp-Source: AGHT+IEkpbg9A6bZTJrS46SXf+aXP4nce1dlZH6O6I47/5/6XJg9tT3U/fTcOgGzCwTT9hsNgmQrRgGWYCe/Vm0AYvo=
X-Received: by 2002:a17:902:f684:b0:26a:8171:dafa with SMTP id
 d9443c01a7336-2984ed49524mr74640225ad.21.1763014243968; Wed, 12 Nov 2025
 22:10:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251112212026.31441-1-adelodunolaoluwa.ref@yahoo.com>
 <20251112212026.31441-1-adelodunolaoluwa@yahoo.com> <CAAVpQUB97EBnTbA9pKwdhPM0pHadiM3QhP4_1qLSKGg2LAwzkA@mail.gmail.com>
 <295e5440-94eb-447f-b4f0-4943e9d02f1c@yahoo.com>
In-Reply-To: <295e5440-94eb-447f-b4f0-4943e9d02f1c@yahoo.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Wed, 12 Nov 2025 22:10:32 -0800
X-Gm-Features: AWmQ_blByZrqO_WYYCiP3ZG6rhHHMDnOi3dyaVAWeDKqTuxwCCMB3n-6ZZUHouo
Message-ID: <CAAVpQUAyPwyG=aSnv-2w7g3dqhB3BLXGoo5VmbSNqQ0txpqqWQ@mail.gmail.com>
Subject: Re: [PATCH v4] selftests: af_unix: Add tests for ECONNRESET and EOF semantics
To: Sunday Adelodun <adelodunolaoluwa@yahoo.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, shuah@kernel.org, 
	skhan@linuxfoundation.org, david.hunter.linux@gmail.com, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, 
	linux-kernel-mentees@lists.linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 12, 2025 at 9:25=E2=80=AFPM Sunday Adelodun
<adelodunolaoluwa@yahoo.com> wrote:
>
> On 11/12/25 23:04, Kuniyuki Iwashima wrote:
> > On Wed, Nov 12, 2025 at 1:20=E2=80=AFPM Sunday Adelodun
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
> >>   tools/testing/selftests/net/.gitignore        |   1 +
> >>   tools/testing/selftests/net/af_unix/Makefile  |   1 +
> >>   .../selftests/net/af_unix/unix_connreset.c    | 178 ++++++++++++++++=
++
> >>   3 files changed, 180 insertions(+)
> >>   create mode 100644 tools/testing/selftests/net/af_unix/unix_connrese=
t.c
> >>
> >> diff --git a/tools/testing/selftests/net/.gitignore b/tools/testing/se=
lftests/net/.gitignore
> >> index 439101b518ee..e89a60581a13 100644
> >> --- a/tools/testing/selftests/net/.gitignore
> >> +++ b/tools/testing/selftests/net/.gitignore
> >> @@ -65,3 +65,4 @@ udpgso
> >>   udpgso_bench_rx
> >>   udpgso_bench_tx
> >>   unix_connect
> >> +unix_connreset
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
> >> index 000000000000..9413f8a0814f
> >> --- /dev/null
> >> +++ b/tools/testing/selftests/net/af_unix/unix_connreset.c
> >> @@ -0,0 +1,178 @@
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
> >> +           variant->socket_type =3D=3D SOCK_SEQPACKET) {
> >> +               err =3D listen(self->server, 1);
> >> +               ASSERT_EQ(0, err);
> >> +       }
> >> +
> >> +       self->client =3D socket(AF_UNIX, variant->socket_type | SOCK_N=
ONBLOCK, 0);
> >> +       ASSERT_LT(-1, self->client);
> >> +
> >> +       err =3D connect(self->client, (struct sockaddr *)&addr, sizeof=
(addr));
> >> +       ASSERT_EQ(0, err);
> >> +}
> >> +
> >> +FIXTURE_TEARDOWN(unix_sock)
> >> +{
> >> +       if ((variant->socket_type =3D=3D SOCK_STREAM ||
> >> +            variant->socket_type =3D=3D SOCK_SEQPACKET) & self->child=
 > 0)
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
> >> +       if (variant->socket_type =3D=3D SOCK_STREAM ||
> >> +           variant->socket_type =3D=3D SOCK_SEQPACKET) {
> >> +               self->child =3D accept(self->server, NULL, NULL);
> >> +               ASSERT_LT(-1, self->child);
> >> +
> >> +               close(self->child);
> >> +       } else {
> >> +               close(self->server);
> >> +       }
> >> +
> >> +       n =3D recv(self->client, buf, sizeof(buf), 0);
> >> +
> >> +       if (variant->socket_type =3D=3D SOCK_STREAM ||
> >> +           variant->socket_type =3D=3D SOCK_SEQPACKET) {
> >> +               ASSERT_EQ(0, n);
> >> +       } else {
> >> +               ASSERT_EQ(-1, n);
> >> +               ASSERT_EQ(EAGAIN, errno);
> >> +       }
> >> +}
> >> +
> >> +/* Test 2: peer closes with unread data */
> >> +TEST_F(unix_sock, reset_unread_behavior)
> >> +{
> >> +       char buf[16] =3D {};
> >> +       ssize_t n;
> >> +
> >> +       if (variant->socket_type =3D=3D SOCK_DGRAM) {
> >> +               /* No real connection, just close the server */
> >> +               close(self->server);
> >> +       } else {
> >> +               /* Establish full connection first */
> >> +               self->child =3D accept(self->server, NULL, NULL);
> >> +               ASSERT_LT(-1, self->child);
> >> +
> >> +               /* Send data that will remain unread */
> >> +               send(self->client, "hello", 5, 0);
> > Could you move this send() before "if (...)" because we want
> > to test unread_data behaviour for SOCK_DGRAM too ?
> >
> > Otherwise looks good, so with that fixed:
> >
> > Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
> >
> > Thanks!
> Thank you for the prompt response.
> I thought of putting the send before the if the statement , but I was afr=
aid
> STREAM and SEQPACKET connections won't be accepted before data sending.

connect() create the paired child socket and accept()
allocates a file descriptor to expose the socket to user
space.

In that sense, the comment above accept() sounds a
bit weird ;)


>
> I will start working on v5.
>
> That part will look like this now:
> /* Test 2: peer closes with unread data */
> TEST_F(unix_sock, reset_unread_behavior)
> {
>          char buf[16] =3D {};
>          ssize_t n;
>
> */* Send data that will remain unread */
>          send(self->client, "hello", 5, 0);*
>
> *if (variant->socket_type =3D=3D SOCK_DGRAM) {
>                  /* No real connection, just close the server */
>                  close(self->server);
>          } else {
>                  /* Establish full connection first */
>                  self->child =3D accept(self->server, NULL, NULL);
>                  ASSERT_LT(-1, self->child);
>
>                  /* Peer closes before client reads */
>                  close(self->child);
>          }*
>
>          n =3D recv(self->client, buf, sizeof(buf), 0);
>          ASSERT_EQ(-1, n);
>
>          if (variant->socket_type =3D=3D SOCK_STREAM ||
>              variant->socket_type =3D=3D SOCK_SEQPACKET) {
>                  ASSERT_EQ(ECONNRESET, errno);
>          } else {
>                  ASSERT_EQ(EAGAIN, errno);
>          }
> }
>
> Thank you once again.
> >
> >
> >> +
> >> +               /* Peer closes before client reads */
> >> +               close(self->child);
> >> +       }
> >> +
> >> +       n =3D recv(self->client, buf, sizeof(buf), 0);
> >> +       ASSERT_EQ(-1, n);
> >> +
> >> +       if (variant->socket_type =3D=3D SOCK_STREAM ||
> >> +           variant->socket_type =3D=3D SOCK_SEQPACKET) {
> >> +               ASSERT_EQ(ECONNRESET, errno);
> >> +       } else {
> >> +               ASSERT_EQ(EAGAIN, errno);
> >> +       }
> >> +}
> >> +
> >> +/* Test 3: closing unaccepted (embryo) server socket should reset cli=
ent. */
> >> +TEST_F(unix_sock, reset_closed_embryo)
> >> +{
> >> +       char buf[16] =3D {};
> >> +       ssize_t n;
> >> +
> >> +       if (variant->socket_type =3D=3D SOCK_DGRAM)
> >> +               SKIP(return, "This test only applies to SOCK_STREAM an=
d SOCK_SEQPACKET");
> >> +
> >> +       /* Close server without accept()ing */
> >> +       close(self->server);
> >> +
> >> +       n =3D recv(self->client, buf, sizeof(buf), 0);
> >> +
> >> +       ASSERT_EQ(-1, n);
> >> +       ASSERT_EQ(ECONNRESET, errno);
> >> +}
> >> +
> >> +TEST_HARNESS_MAIN
> >> +
> >> --
> >> 2.43.0
> >>
>

