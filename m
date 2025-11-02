Return-Path: <linux-kselftest+bounces-44618-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 67D84C28A96
	for <lists+linux-kselftest@lfdr.de>; Sun, 02 Nov 2025 08:35:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2627A188E357
	for <lists+linux-kselftest@lfdr.de>; Sun,  2 Nov 2025 07:34:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 083FF26E6FE;
	Sun,  2 Nov 2025 07:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Soqbrc+U"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B6F426CE1A
	for <linux-kselftest@vger.kernel.org>; Sun,  2 Nov 2025 07:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762068766; cv=none; b=uEZ0fZZ1nIO2wFn4m8isyWyfsWUHse+c4PLwNbACHtr4kBp0sivkQAKqNsJYuQC392l1yZtQtHiY3ihDpofDZglk8MOcdSWqA+BRKTZ9rmV88DR6TgHqK/z2ZpLQacdOEcxn7MwiiAQvdL2g0SmDQf7J4Z4jnTCW6knRayaXM1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762068766; c=relaxed/simple;
	bh=X5GGfT0Fb6Pdwjs1LDTMtk3l4izdSvji14DLk1KDCeY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uIooL87kDjpxIxjsf6W8hb06UsOGR8jZBOnLtacTrZbZ7d+ep5jKelGX7Hcim0DHmK00UQc9Ro9G5V0BHXQG3kmKCaplA1+h60MkgdkXYht2W5kyWsPnTDhuOERAO7RVCnA7RVdUqP3hi1UFQIktCbpEMx8d1T0yUWeDKvI6KT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Soqbrc+U; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-27c369f8986so35363615ad.3
        for <linux-kselftest@vger.kernel.org>; Sun, 02 Nov 2025 00:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762068764; x=1762673564; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=psmfYF2mFpi74h7bmYecR+gj0aBVviR4E8MTUa1Jbhc=;
        b=Soqbrc+U8MX2XlpslhzJIggz0xnkzljMvOlHY9fqjD4DM7VoMpHSEh2kZxOII2eZcZ
         eLfWiTm3nJ7v7Emwk2Y64kfmHpRxvGkghS955ZXuoP5FLuiXomP7rsbAusmcTIIKVB9U
         aGeO3cNrVfrGf7KgfymXJ85aY6mxjEGuKsS4kkC06H5A08biS+Ot4eUITel65RyTIOiP
         h+mxWLCJA8ceLf1nSmBFgCkdONot6OvL3F9uoEIaZomr3QEJrvuII4MZHknljavWvBj6
         mDEl2fkFYKUE+gX/6nv9BjBmC2LQj4icDaw15n8aBoX9MkWQqyfQhK0ISitlV79kPG5M
         4SBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762068764; x=1762673564;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=psmfYF2mFpi74h7bmYecR+gj0aBVviR4E8MTUa1Jbhc=;
        b=gKc2h69Qg/QY9SdERibTLedbE9Y/rf/A/E+gCYXBkMtSsmevoQm1f2eZlZkYODR6jv
         eSpNHTRt24H5mX+LBZoxauR3MJsjlhhq4KsTlQwDtZ2fTjSlJDtMSyHXQQNID9tNnVHH
         4XCe0I8QwLcNPT0tZho36atXF9VrzmyqhhtpYfHeHFDqAPZNdJMDcfTbOvbFfexLv4Kd
         vJc54y/ev4v4EH1OCraL4Dp7lW0usNqA4bBJMGTT+L5qB/DtOh5xLgZq2+zO+fi9xKz+
         yWZUlktzdi5Fu5cbgFQHnTdwlNezq8csctUTZA6TA2LgBql6kgio7eK10fZJh1CKIl1Q
         J6Pg==
X-Forwarded-Encrypted: i=1; AJvYcCX0wmTHYnky2t6Ggd5myhjuAuqxvjzZcxU/uyovKknQ90kcos9jWpG7sxKI5Z4zy4BHdolNl/2+Bu4yuQZQ0AY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxil8B8zHDfbFAnAbqNParwyhLrA0NKKv3jMbXDmloLMz8OakP4
	3M++v5i+ZArftgu5aDN9l7i396T+dfKAef8soy1OjoC9OkS+0pZIaiTfufLwqZhT1n+RmkWMbqY
	9rSemNOzuUxRNmzmIGeMTQbkxpkthSsnPSt0cCWWB
X-Gm-Gg: ASbGncuUODpVEn4V3haJfYZk0zOErahEHiKsr/0CS67bLEG0AsL54DDY4u9s7KGrkJ/
	L1M8Zp1YAZm4jMhbgqw4Wg8v3rbqYKnA5JHcybewMfeRKfZnx6dWJ0K4RJEz3uKbioQXqyFeVj4
	PMupEaVlVdzJeL8wWekBzxlBHPrcqG0REmR6Rin+rgTo/y0PJbw7VAaSuE7KH2N8WG0W2/4F8Nx
	+6yhaHX91EGd5F88Nfud61KrxSmED7vXYegksP0+9nylBrJIy8HcR4rqh/al3adQ/d2yZN9Aznx
	SXlfmU9irYdZH0t90EigzrL1TMSI
X-Google-Smtp-Source: AGHT+IFbW7bCQJ0PZWFIhPoBoJbyq4L78a2Dn1ShTaa+crTgaOBXNBIsSdR20e5FJO4cGtyCHIdPcl2p5BJao9hsgSg=
X-Received: by 2002:a17:902:f60c:b0:295:9cb5:ae2a with SMTP id
 d9443c01a7336-2959cb5b3a5mr9776895ad.9.1762068764144; Sun, 02 Nov 2025
 00:32:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251101172230.10179-1-adelodunolaoluwa.ref@yahoo.com> <20251101172230.10179-1-adelodunolaoluwa@yahoo.com>
In-Reply-To: <20251101172230.10179-1-adelodunolaoluwa@yahoo.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Sun, 2 Nov 2025 00:32:32 -0700
X-Gm-Features: AWmQ_bl-AuPwDhpPjaIEpKjwp_zIOpPzGuKKuWV51VIxF5js7Nyb6hFeYlKzfqQ
Message-ID: <CAAVpQUDL1FB1nFYOZ6QuO+cGTqnpYNSaFtFD=YN742pyspe9ew@mail.gmail.com>
Subject: Re: [PATCH v3] selftests: af_unix: Add tests for ECONNRESET and EOF semantics
To: Sunday Adelodun <adelodunolaoluwa@yahoo.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, shuah@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org, 
	david.hunter.linux@gmail.com, linux-kernel-mentees@lists.linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 1, 2025 at 10:23=E2=80=AFAM Sunday Adelodun
<adelodunolaoluwa@yahoo.com> wrote:
>
> Add selftests to verify and document Linux=E2=80=99s intended behaviour f=
or
> UNIX domain sockets (SOCK_STREAM and SOCK_DGRAM) when a peer closes.
> The tests verify that:
>
>  1. SOCK_STREAM returns EOF when the peer closes normally.
>  2. SOCK_STREAM returns ECONNRESET if the peer closes with unread data.
>  3. SOCK_SEQPACKET returns EOF when the peer closes normally.
>  4. SOCK_SEQPACKET returns ECONNRESET if the peer closes with unread data=
.
>  5. SOCK_DGRAM does not return ECONNRESET when the peer closes.
>
> This follows up on review feedback suggesting a selftest to clarify
> Linux=E2=80=99s semantics.
>
> Suggested-by: Kuniyuki Iwashima <kuniyu@google.com>
> Signed-off-by: Sunday Adelodun <adelodunolaoluwa@yahoo.com>
> ---
>  tools/testing/selftests/net/af_unix/Makefile  |   1 +
>  .../selftests/net/af_unix/unix_connreset.c    | 179 ++++++++++++++++++
>  2 files changed, 180 insertions(+)
>  create mode 100644 tools/testing/selftests/net/af_unix/unix_connreset.c
>
> diff --git a/tools/testing/selftests/net/af_unix/Makefile b/tools/testing=
/selftests/net/af_unix/Makefile
> index de805cbbdf69..5826a8372451 100644
> --- a/tools/testing/selftests/net/af_unix/Makefile
> +++ b/tools/testing/selftests/net/af_unix/Makefile
> @@ -7,6 +7,7 @@ TEST_GEN_PROGS :=3D \
>         scm_pidfd \
>         scm_rights \
>         unix_connect \
> +       unix_connreset \

patchwork caught this test is not added to .gitignore.
https://patchwork.kernel.org/project/netdevbpf/patch/20251101172230.10179-1=
-adelodunolaoluwa@yahoo.com/

Could you add it to this file ?

tools/testing/selftests/net/.gitignore


>  # end of TEST_GEN_PROGS
>
>  include ../../lib.mk
> diff --git a/tools/testing/selftests/net/af_unix/unix_connreset.c b/tools=
/testing/selftests/net/af_unix/unix_connreset.c
> new file mode 100644
> index 000000000000..6f43435d96e2
> --- /dev/null
> +++ b/tools/testing/selftests/net/af_unix/unix_connreset.c
> @@ -0,0 +1,179 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Selftest for AF_UNIX socket close and ECONNRESET behaviour.
> + *
> + * This test verifies:
> + *  1. SOCK_STREAM returns EOF when the peer closes normally.
> + *  2. SOCK_STREAM returns ECONNRESET if peer closes with unread data.
> + *  3. SOCK_SEQPACKET returns EOF when the peer closes normally.
> + *  4. SOCK_SEQPACKET returns ECONNRESET if the peer closes with unread =
data.
> + *  5. SOCK_DGRAM does not return ECONNRESET when the peer closes.
> + *
> + * These tests document the intended Linux behaviour.
> + *
> + */
> +
> +#define _GNU_SOURCE
> +#include <stdlib.h>
> +#include <string.h>
> +#include <fcntl.h>
> +#include <unistd.h>
> +#include <errno.h>
> +#include <sys/socket.h>
> +#include <sys/un.h>
> +#include "../../kselftest_harness.h"
> +
> +#define SOCK_PATH "/tmp/af_unix_connreset.sock"
> +
> +static void remove_socket_file(void)
> +{
> +       unlink(SOCK_PATH);
> +}
> +
> +FIXTURE(unix_sock)
> +{
> +       int server;
> +       int client;
> +       int child;
> +};
> +
> +FIXTURE_VARIANT(unix_sock)
> +{
> +       int socket_type;
> +       const char *name;
> +};
> +
> +/* Define variants: stream and datagram */

nit: outdated, maybe simply remove ?

> +FIXTURE_VARIANT_ADD(unix_sock, stream) {
> +       .socket_type =3D SOCK_STREAM,
> +       .name =3D "SOCK_STREAM",
> +};
> +
> +FIXTURE_VARIANT_ADD(unix_sock, dgram) {
> +       .socket_type =3D SOCK_DGRAM,
> +       .name =3D "SOCK_DGRAM",
> +};
> +
> +FIXTURE_VARIANT_ADD(unix_sock, seqpacket) {
> +       .socket_type =3D SOCK_SEQPACKET,
> +       .name =3D "SOCK_SEQPACKET",
> +};
> +
> +FIXTURE_SETUP(unix_sock)
> +{
> +       struct sockaddr_un addr =3D {};
> +       int err;
> +
> +       addr.sun_family =3D AF_UNIX;
> +       strcpy(addr.sun_path, SOCK_PATH);
> +       remove_socket_file();
> +
> +       self->server =3D socket(AF_UNIX, variant->socket_type, 0);
> +       ASSERT_LT(-1, self->server);
> +
> +       err =3D bind(self->server, (struct sockaddr *)&addr, sizeof(addr)=
);
> +       ASSERT_EQ(0, err);
> +
> +       if (variant->socket_type =3D=3D SOCK_STREAM ||
> +               variant->socket_type =3D=3D SOCK_SEQPACKET) {

patchwork caught mis-alignment here and other places.

I'm using this for emacs, and other editors will have a similar config.

(setq-default c-default-style "linux")

You can check if lines are aligned properly by

$ git show --format=3Demail | ./scripts/checkpatch.pl


> +               err =3D listen(self->server, 1);
> +               ASSERT_EQ(0, err);
> +
> +               self->client =3D socket(AF_UNIX, variant->socket_type, 0)=
;

Could you add SOCK_NONBLOCK here too ?


> +               ASSERT_LT(-1, self->client);
> +
> +               err =3D connect(self->client, (struct sockaddr *)&addr, s=
izeof(addr));
> +               ASSERT_EQ(0, err);
> +
> +               self->child =3D accept(self->server, NULL, NULL);
> +               ASSERT_LT(-1, self->child);
> +       } else {
> +               /* Datagram: bind and connect only */
> +               self->client =3D socket(AF_UNIX, SOCK_DGRAM | SOCK_NONBLO=
CK, 0);
> +               ASSERT_LT(-1, self->client);
> +
> +               err =3D connect(self->client, (struct sockaddr *)&addr, s=
izeof(addr));
> +               ASSERT_EQ(0, err);
> +       }
> +}
> +
> +FIXTURE_TEARDOWN(unix_sock)
> +{
> +       if (variant->socket_type =3D=3D SOCK_STREAM ||
> +               variant->socket_type =3D=3D SOCK_SEQPACKET)
> +               close(self->child);
> +
> +       close(self->client);
> +       close(self->server);
> +       remove_socket_file();
> +}
> +
> +/* Test 1: peer closes normally */
> +TEST_F(unix_sock, eof)
> +{
> +       char buf[16] =3D {};
> +       ssize_t n;
> +
> +       /* Peer closes normally */
> +       if (variant->socket_type =3D=3D SOCK_STREAM ||
> +               variant->socket_type =3D=3D SOCK_SEQPACKET)
> +               close(self->child);
> +       else
> +               close(self->server);
> +
> +       n =3D recv(self->client, buf, sizeof(buf), 0);
> +       TH_LOG("%s: recv=3D%zd errno=3D%d (%s)", variant->name, n, errno,=
 strerror(errno));

errno is undefined if not set, and same for strerror(errno).

Also, if ASSERT_XXX() below fails, the same information
(test case, errno) is logged.  So, TH_LOG() seems unnecessary.

Maybe try modifying the condition below and see how the
assertion is logged.

> +       if (variant->socket_type =3D=3D SOCK_STREAM ||
> +               variant->socket_type =3D=3D SOCK_SEQPACKET) {
> +               ASSERT_EQ(0, n);
> +       } else {
> +               ASSERT_EQ(-1, n);
> +               ASSERT_EQ(EAGAIN, errno);
> +       }
> +}
> +
> +/* Test 2: peer closes with unread data */
> +TEST_F(unix_sock, reset_unread)
> +{
> +       char buf[16] =3D {};
> +       ssize_t n;
> +
> +       /* Send data that will remain unread by client */
> +       send(self->client, "hello", 5, 0);
> +       close(self->child);
> +
> +       n =3D recv(self->client, buf, sizeof(buf), 0);
> +       TH_LOG("%s: recv=3D%zd errno=3D%d (%s)", variant->name, n, errno,=
 strerror(errno));
> +       if (variant->socket_type =3D=3D SOCK_STREAM ||
> +               variant->socket_type =3D=3D SOCK_SEQPACKET) {
> +               ASSERT_EQ(-1, n);
> +               ASSERT_EQ(ECONNRESET, errno);
> +       } else {
> +               ASSERT_EQ(-1, n);
> +               ASSERT_EQ(EAGAIN, errno);
> +       }
> +}
> +
> +/* Test 3: SOCK_DGRAM peer close */

Now Test 2 and Test 3 look identical ;)

Thanks!

> +TEST_F(unix_sock, dgram_reset)
> +{
> +       char buf[16] =3D {};
> +       ssize_t n;
> +
> +       send(self->client, "hello", 5, 0);
> +       close(self->server);
> +
> +       n =3D recv(self->client, buf, sizeof(buf), 0);
> +       TH_LOG("%s: recv=3D%zd errno=3D%d (%s)", variant->name, n, errno,=
 strerror(errno));
> +       if (variant->socket_type =3D=3D SOCK_STREAM ||
> +               variant->socket_type =3D=3D SOCK_SEQPACKET) {
> +               ASSERT_EQ(-1, n);
> +               ASSERT_EQ(ECONNRESET, errno);
> +       } else {
> +               ASSERT_EQ(-1, n);
> +               ASSERT_EQ(EAGAIN, errno);
> +       }
> +}
> +
> +TEST_HARNESS_MAIN
> +
> --
> 2.43.0
>

