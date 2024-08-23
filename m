Return-Path: <linux-kselftest+bounces-16200-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1967895D9CD
	for <lists+linux-kselftest@lfdr.de>; Sat, 24 Aug 2024 01:44:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 927A01F21CC0
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Aug 2024 23:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3921B1C86F0;
	Fri, 23 Aug 2024 23:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TT1Eyi7l"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 811BC152196;
	Fri, 23 Aug 2024 23:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724456683; cv=none; b=atrYSl85PRbYGXtd3i5Bgtx1HtLBuI40lzy/Gh2RbRf5VD3GNXZKChFdo3zRXjaeUXvzJ8xzPaZBeC65VXCVQqtJ9euRswmEN6tnjzF3eiHgk3E8dG/TuenEqt4twql6fpt6LgVfjUA0Gsi6Z+vYdlwvryT+mr50WwY0OkaKOk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724456683; c=relaxed/simple;
	bh=yCPfI+kiHgQVq30mEcE1PtkAHzc/7g/v0pZ3Aj/kmSQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ia4mNVdXpQhgy71FA+xDOVfvaMM7kp0XB2WYHnqcloU4Ie28t2iMava6xbRQkBdSaE/Ybvaqe8dNTwlRvrCaReN7pt31DIYVTjllhdYjZMPZjpeebzVpF5fiaWHawkpqZKNUt3vW6DqElglCFumKHzHOKubmYY6VuzrT/ctf19Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TT1Eyi7l; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-81fd9251d99so91211439f.0;
        Fri, 23 Aug 2024 16:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724456680; x=1725061480; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KistXHioizcW9FYbSUI1OlFUfi5tftYK70zDq1HxHBE=;
        b=TT1Eyi7lVdjB4Nu9EGMweLNMLw2sb/8s4nr0ApfpiIDNGhPUnajd7eGtif6bXHPPiP
         F2tINBMXS5tmOFEiO96gLgU05H45MNfCNCcLk4hHihFlmeP0LeCAsJ7OsnMZvggrfXeF
         sObQ/QAmACbuTDdKq/OM6U0LvL6NYlriehW4GMBBVLIYahN/1/8ItYGuQpACI83cthb/
         CarXWdpXna2z4Kc8c1Vw9man55M0p5phoGqglACuD/yZ4ZvdP7F3iFAPVojFuwpO0zpf
         DKFUJuU1ENpJWOGmTE2I4u7sr5/dkthAYtcudp0+4cGLjebMDrWRmEPB11m46N5CYwL0
         nniQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724456680; x=1725061480;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KistXHioizcW9FYbSUI1OlFUfi5tftYK70zDq1HxHBE=;
        b=ZuSqF+CoEOrA9PKCIfNAwvRcbvajL2V4YCsZyZ6+XHTxelc1wHMKCO4WZvpGNKU6jX
         3UXS6j+q5y8KUiZoiagUpEMwfajdvEYrM5P6B4XPn0qNxdz67KHM+XHG/NvPdFCSV8/Q
         jB19Cih9nZbhnFW4mvENZGOFsMakcJYr1R8DdQt0p9FPlLczEjSvz2Hcs87JbLjyaFCS
         ZkqvRZv+QDzdifzHpSnsjU1vv1hRqYQUgxuFzLaXjxnbcb4rf+FY+3Kwu8AlFWbfPMo1
         k80U20XA5VwG/JObz3NDKF+RcBqOSM1Mf0m88CH5hgedZwTPgOVp/yX+xaMVWzixQwzq
         48qA==
X-Forwarded-Encrypted: i=1; AJvYcCUubtoprtCYaxHdjHENMRGDEeHsWGqnOsz3t0gYA2e5LCc7RszBHRMyyaXdtl8hPUJp7GCf+vudoQHrcc/d1Q4=@vger.kernel.org
X-Gm-Message-State: AOJu0YykJ0jzxDKq9Voss+HIG6YpZcrruwmUWTwLlb0ngWRcvBGC6w2X
	aUcSD10IniqW3xmwzitxkc8aEkN+y+/aLRLWigX9/8V5Ld3a27btRYhUUk9FSTBl4AAgh6Wo6tB
	MhWWUQRomcbHJqbu2QSxBKdxlk6RHEva+004=
X-Google-Smtp-Source: AGHT+IHCScWcM1ds0gB3lNaC69Mano1ry0Gq37G1600EUnNhIVZ7f/NfUYnJapCmBiihOhMOyBGmsZp2IEtZE0PVG+o=
X-Received: by 2002:a05:6e02:12ee:b0:39d:3c85:9b0 with SMTP id
 e9e14a558f8ab-39e3c98c707mr43076015ab.15.1724456680471; Fri, 23 Aug 2024
 16:44:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240823211902.143210-1-jmaloy@redhat.com> <20240823211902.143210-3-jmaloy@redhat.com>
In-Reply-To: <20240823211902.143210-3-jmaloy@redhat.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Sat, 24 Aug 2024 07:44:04 +0800
Message-ID: <CAL+tcoCro6o5ZkhVJdKah9o2p=tPUSu06D0ZzNPPDB2Ns66kMw@mail.gmail.com>
Subject: Re: [PATCH 2/2] selftests: add selftest for tcp SO_PEEK_OFF support
To: jmaloy@redhat.com
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	davem@davemloft.net, kuba@kernel.org, passt-dev@passt.top, sbrivio@redhat.com, 
	lvivier@redhat.com, dgibson@redhat.com, eric.dumazet@gmail.com, 
	edumazet@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Jon,

On Sat, Aug 24, 2024 at 5:19=E2=80=AFAM <jmaloy@redhat.com> wrote:
>
> From: Jon Maloy <jmaloy@redhat.com>
>
> We add a selftest to check that the new feature added in
> commit 05ea491641d3 ("tcp: add support for SO_PEEK_OFF socket option")
> works correctly.
>
> Reviewed-by: Stefano Brivio <sbrivio@redhat.com>
> Tested-by: Stefano Brivio <sbrivio@redhat.com>
> Signed-off-by: Jon Maloy <jmaloy@redhat.com>

Thanks for working on this. Sorry that I just noticed I missed your
previous reply :(

> ---
>  tools/testing/selftests/net/Makefile          |   1 +
>  tools/testing/selftests/net/tcp_so_peek_off.c | 181 ++++++++++++++++++
>  2 files changed, 182 insertions(+)
>  create mode 100644 tools/testing/selftests/net/tcp_so_peek_off.c
>
> diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftes=
ts/net/Makefile
> index 8eaffd7a641c..1179e3261bef 100644
> --- a/tools/testing/selftests/net/Makefile
> +++ b/tools/testing/selftests/net/Makefile
> @@ -80,6 +80,7 @@ TEST_PROGS +=3D io_uring_zerocopy_tx.sh
>  TEST_GEN_FILES +=3D bind_bhash
>  TEST_GEN_PROGS +=3D sk_bind_sendto_listen
>  TEST_GEN_PROGS +=3D sk_connect_zero_addr
> +TEST_GEN_PROGS +=3D tcp_so_peek_off
>  TEST_PROGS +=3D test_ingress_egress_chaining.sh
>  TEST_GEN_PROGS +=3D so_incoming_cpu
>  TEST_PROGS +=3D sctp_vrf.sh
> diff --git a/tools/testing/selftests/net/tcp_so_peek_off.c b/tools/testin=
g/selftests/net/tcp_so_peek_off.c
> new file mode 100644
> index 000000000000..8379ea02e3d7
> --- /dev/null
> +++ b/tools/testing/selftests/net/tcp_so_peek_off.c
> @@ -0,0 +1,181 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <unistd.h>
> +#include <errno.h>
> +#include <sys/types.h>
> +#include <netinet/in.h>
> +#include <arpa/inet.h>
> +#include "../kselftest.h"
> +
> +static char *afstr(int af)
> +{
> +       return af =3D=3D AF_INET ? "TCP/IPv4" : "TCP/IPv6";
> +}
> +
> +int tcp_peek_offset_probe(sa_family_t af)
> +{
> +       int optv =3D 0;
> +       int ret =3D 0;
> +       int s;
> +
> +       s =3D socket(af, SOCK_STREAM | SOCK_CLOEXEC, IPPROTO_TCP);
> +       if (s < 0) {
> +               ksft_perror("Temporary TCP socket creation failed");
> +       } else {
> +               if (!setsockopt(s, SOL_SOCKET, SO_PEEK_OFF, &optv, sizeof=
(int)))
> +                       ret =3D 1;
> +               else
> +                       printf("%s does not support SO_PEEK_OFF\n", afstr=
(af));
> +               close(s);
> +       }
> +       return ret;
> +}
> +
> +static void tcp_peek_offset_set(int s, int offset)
> +{
> +       if (setsockopt(s, SOL_SOCKET, SO_PEEK_OFF, &offset, sizeof(offset=
)))
> +               ksft_perror("Failed to set SO_PEEK_OFF value\n");
> +}
> +
> +static int tcp_peek_offset_get(int s)
> +{
> +       int offset;
> +       socklen_t len =3D sizeof(offset);
> +
> +       if (getsockopt(s, SOL_SOCKET, SO_PEEK_OFF, &offset, &len))
> +               ksft_perror("Failed to get SO_PEEK_OFF value\n");
> +       return offset;
> +}
> +
> +static int tcp_peek_offset_test(sa_family_t af)
> +{
> +       union {
> +               struct sockaddr sa;
> +               struct sockaddr_in a4;
> +               struct sockaddr_in6 a6;
> +       } a;
> +       int res =3D 0;
> +       int s[2] =3D {0, 0};
> +       int recv_sock =3D 0;
> +       int offset =3D 0;
> +       ssize_t len;
> +       char buf;
> +
> +       memset(&a, 0, sizeof(a));
> +       a.sa.sa_family =3D af;
> +
> +       s[0] =3D socket(af, SOCK_STREAM, IPPROTO_TCP);
> +       s[1] =3D socket(af, SOCK_STREAM | SOCK_NONBLOCK, IPPROTO_TCP);
> +
> +       if (s[0] < 0 || s[1] < 0) {
> +               ksft_perror("Temporary probe socket creation failed\n");
> +               goto out;

Nit: I wonder if we can use more proper test statements to avoid such
hiding failure[1] when closing a invalid file descriptor, even though
it doesn't harm the test itself?

[1]: "EBADF (Bad file descriptor)"

> +       }
> +       if (bind(s[0], &a.sa, sizeof(a)) < 0) {
> +               ksft_perror("Temporary probe socket bind() failed\n");
> +               goto out;
> +       }
> +       if (getsockname(s[0], &a.sa, &((socklen_t) { sizeof(a) })) < 0) {
> +               ksft_perror("Temporary probe socket getsockname() failed\=
n");
> +               goto out;
> +       }
> +       if (listen(s[0], 0) < 0) {
> +               ksft_perror("Temporary probe socket listen() failed\n");
> +               goto out;
> +       }
> +       if (connect(s[1], &a.sa, sizeof(a)) >=3D 0 || errno !=3D EINPROGR=
ESS) {
> +               ksft_perror("Temporary probe socket connect() failed\n");
> +               goto out;
> +       }
> +       recv_sock =3D accept(s[0], NULL, NULL);
> +       if (recv_sock <=3D 0) {
> +               ksft_perror("Temporary probe socket accept() failed\n");
> +               goto out;

Same here.

> +       }
> +
> +       /* Some basic tests of getting/setting offset */
> +       offset =3D tcp_peek_offset_get(recv_sock);
> +       if (offset !=3D -1) {
> +               ksft_perror("Initial value of socket offset not -1\n");
> +               goto out;
> +       }
> +       tcp_peek_offset_set(recv_sock, 0);
> +       offset =3D tcp_peek_offset_get(recv_sock);
> +       if (offset !=3D 0) {
> +               ksft_perror("Failed to set socket offset to 0\n");
> +               goto out;
> +       }
> +
> +       /* Transfer a message */
> +       if (send(s[1], (char *)("ab"), 2, 0) <=3D 0 || errno !=3D EINPROG=
RESS) {
> +               ksft_perror("Temporary probe socket send() failed\n");
> +               goto out;
> +       }
> +       /* Read first byte */
> +       len =3D recv(recv_sock, &buf, 1, MSG_PEEK);
> +       if (len !=3D 1 || buf !=3D 'a') {
> +               ksft_perror("Failed to read first byte of message\n");
> +               goto out;
> +       }
> +       offset =3D tcp_peek_offset_get(recv_sock);
> +       if (offset !=3D 1) {
> +               ksft_perror("Offset not forwarded correctly at first byte=
\n");
> +               goto out;
> +       }
> +       /* Try to read beyond last byte */
> +       len =3D recv(recv_sock, &buf, 2, MSG_PEEK);
> +       if (len !=3D 1 || buf !=3D 'b') {
> +               ksft_perror("Failed to read last byte of message\n");
> +               goto out;
> +       }
> +       offset =3D tcp_peek_offset_get(recv_sock);
> +       if (offset !=3D 2) {
> +               ksft_perror("Offset not forwarded correctly at last byte\=
n");
> +               goto out;
> +       }
> +       /* Flush message */
> +       len =3D recv(recv_sock, NULL, 2, MSG_TRUNC);
> +       if (len !=3D 2) {
> +               ksft_perror("Failed to flush message\n");
> +               goto out;
> +       }
> +       offset =3D tcp_peek_offset_get(recv_sock);
> +       if (offset !=3D 0) {
> +               ksft_perror("Offset not reverted correctly after flush\n"=
);
> +               goto out;
> +       }
> +
> +       printf("%s with MSG_PEEK_OFF works correctly\n", afstr(af));
> +       res =3D 1;
> +out:
> +       close(recv_sock);
> +       close(s[1]);
> +       close(s[0]);
> +       return res;
> +}
> +
> +int main(void)
> +{
> +       int res4, res6;
> +
> +       res4 =3D tcp_peek_offset_probe(AF_INET);
> +       res6 =3D tcp_peek_offset_probe(AF_INET6);
> +
> +       if (!res4 && !res6)
> +               return KSFT_SKIP;
> +
> +       if (res4)
> +               res4 =3D tcp_peek_offset_test(AF_INET);
> +
> +       if (res6)
> +               res6 =3D tcp_peek_offset_test(AF_INET6);
> +
> +       if (!res4 || !res6)

What if res6 is NULL after checking tcp_peek_offset_probe() while res4
is always working correctly, then we will get notified with a
KSFT_FAIL failure instead of KSFT_SKIP.

The thing could happen because you reuse the same return value for v4/v6 mo=
de.

Thanks,
Jason

> +               return KSFT_FAIL;
> +
> +       return KSFT_PASS;
> +}
> +
> --
> 2.45.2
>
>

