Return-Path: <linux-kselftest+bounces-14248-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5645693C96D
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Jul 2024 22:18:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB681B20EC8
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Jul 2024 20:18:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C02B36BFCA;
	Thu, 25 Jul 2024 20:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O7grvwRe"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDE943224;
	Thu, 25 Jul 2024 20:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721938705; cv=none; b=rAeGu1TUNUn3/gWKG92nqRxeJxrBM25Qu2t+DbbEar5J8U5LKtbXKVWO4COH6/Ml+SIizdnVMrz2SU5ZMy0SulLVP6dFKZrXjT7X1qQ5FLHVDYa3WRnXQ/DMsohZwzMdNiMj/ek7dY5sqSQLFR1qieROXkxvbfmLgsxm2CHNs7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721938705; c=relaxed/simple;
	bh=bSIjH707A8TRz7ht8RMiy+R1DHqrwESTmUpegyYO3IE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XWudBA1bVyWCszsdhV4OIqxxUUtbrDUL4GZwWxuQKzofUJgiWVOodxPoY+ZF+xl5h9JYHYIjyMyCqyPg9FIcUfaO0jEikSSbLnG8eWSnFYB7AfK1i01obezQ2aqJdAqOG0ls3nCQiPclpr1RSYoHz4fTFufL4QQQup49cYo1NS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O7grvwRe; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a7ac469e4c4so168815866b.0;
        Thu, 25 Jul 2024 13:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721938702; x=1722543502; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zZ1iJo8QC4U6/UUapxlEeYZXRBnRy4gllZzXWq6Grnc=;
        b=O7grvwRey7UJxh0cONubnvRk9lAnWE9rlrwaVGkhFtkIxLhpdP0aBURTLTYV8lNaoT
         dJxGeIvHCdV+OG++lS2AFuvsGpwteTPppNEStGhpOo3TU82TdW4wTZXnfbWX+mf8u4Gj
         ooobK6KkRSKxY+TcU5F0modzkoHIPkfMUznjB6FUAO/MgoNbH3NnJ+uu38H5gMYoOX2T
         e/Ve/Jn+8qTt8cmHZ+1pYIwzYtu7ieiTpwqLanGox4jV63+UEnERLzkP/c2uhcYlWzGG
         /N1TK6HUDQBGYd6ZGt/3sjSvxKYe7rfy4adAvcZh1wGElSYRil/EQTFJkbnkhUxV3dlV
         +CIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721938702; x=1722543502;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zZ1iJo8QC4U6/UUapxlEeYZXRBnRy4gllZzXWq6Grnc=;
        b=a4hfnz+jYyoQ5XvewPC9noUrEVfqzDwCBYps7GQGQHT/1H27iU4a4YLJOuRr21Fam+
         Z02VD0JTAbDAcJxpJbGdAXMnPssRm3EoNmfoc9gpqZGNhPYokKVMnEKeE5tdjDU2eNBW
         Mv9QYR+5xNYsS17LwpenPWnufGFksMlQmGxzc6Ok2Xoy3lLuNR7jtIMhUeMh8aXFjVaw
         40BbX5BbWOr6HZPfGqRYY79oMZ5FUqAMMwBxdxzpK8POjghVg/EZrZXeodG/g/LF4/Hp
         WhU+UHJAjgfC6uZ5KEqqcuylz6DL2hSmAkUtQ6XvXKwOfItv1eKwWGUwf6pgxL+JoOgm
         Jk7A==
X-Forwarded-Encrypted: i=1; AJvYcCXighuybQqkHeH036XII6pEscJ91BQdF0GCpN2CN9qc6sd86gIp1nd8ijkPqHpjTNtbefEmLy24QhvmVu0EkVQILXg0FpzVdwpjAt+fscJHsf8PNWXOyTYMUJwfx4XzAto5i2PfcJd/
X-Gm-Message-State: AOJu0YwFqk6cm1KHqq1weRKQ/NlhtuA/R3aVzpMsvPKDu1gigZ/epesF
	h0cJ2t5vyzkVx7tykV/xOwQwFajDxi3ACsbdnqGqMAilRKjQR4oDYuAYPjIOxe7qg4xdtwms4Sf
	4BkEx6AuhZxdkwe40SRydHDMTsvI=
X-Google-Smtp-Source: AGHT+IHNM1ouleZKCEZhe9ddtB0zwIOUIS12UcKlbJi6EoTXQFE1/jAyeHKE80PPD7lnq2EIDcd27h8RZ7XL9XvtNcw=
X-Received: by 2002:a17:907:6d13:b0:a7a:acae:3419 with SMTP id
 a640c23a62f3a-a7ab3162321mr669091666b.28.1721938702090; Thu, 25 Jul 2024
 13:18:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1721903630.git.tony.ambardar@gmail.com> <b57266bcc9f47ffda1fc5e55933afbf2c1ce1d58.1721903630.git.tony.ambardar@gmail.com>
In-Reply-To: <b57266bcc9f47ffda1fc5e55933afbf2c1ce1d58.1721903630.git.tony.ambardar@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 25 Jul 2024 13:18:04 -0700
Message-ID: <CAEf4BzZO_G59KS4iBj0XVasKYidFMeBJ4wTrSP+J28HNFgdgmw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 5/8] selftests/bpf: Fix order-of-include
 compile errors in lwt_reroute.c
To: Tony Ambardar <tony.ambardar@gmail.com>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	netdev@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	=?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
	Magnus Karlsson <magnus.karlsson@intel.com>, 
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Jonathan Lemon <jonathan.lemon@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Yan Zhai <yan@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 25, 2024 at 3:39=E2=80=AFAM Tony Ambardar <tony.ambardar@gmail.=
com> wrote:
>
> From: Tony Ambardar <tony.ambardar@gmail.com>
>
> Fix redefinition errors seen compiling lwt_reroute.c for mips64el/musl-li=
bc
> by adjusting the order of includes in lwt_helpers.h. The ordering require=
d
> is:
> <net/if.h>  -->  <arpa/inet.h> (from "test_progs.h")  -->  <linux/icmp.h>=
.
>
> Because of the complexity and large number of includes, ordering appears =
to
> be fragile however. Previously, with "test_progs.h" at the end of this
> sequence, compiling with GCC 12.3 for mips64el/musl-libc yields errors:
>
> In file included from .../include/arpa/inet.h:9,
>                  from ./test_progs.h:18,
>                  from tools/testing/selftests/bpf/prog_tests/lwt_helpers.=
h:11,
>                  from tools/testing/selftests/bpf/prog_tests/lwt_reroute.=
c:52:
> .../include/netinet/in.h:23:8: error: redefinition of 'struct in6_addr'
>    23 | struct in6_addr {
>       |        ^~~~~~~~
> In file included from .../include/linux/icmp.h:24,
>                  from tools/testing/selftests/bpf/prog_tests/lwt_helpers.=
h:9:
> .../include/linux/in6.h:33:8: note: originally defined here
>    33 | struct in6_addr {
>       |        ^~~~~~~~
> .../include/netinet/in.h:34:8: error: redefinition of 'struct sockaddr_in=
6'
>    34 | struct sockaddr_in6 {
>       |        ^~~~~~~~~~~~
> .../include/linux/in6.h:50:8: note: originally defined here
>    50 | struct sockaddr_in6 {
>       |        ^~~~~~~~~~~~
> .../include/netinet/in.h:42:8: error: redefinition of 'struct ipv6_mreq'
>    42 | struct ipv6_mreq {
>       |        ^~~~~~~~~
> .../include/linux/in6.h:60:8: note: originally defined here
>    60 | struct ipv6_mreq {
>       |        ^~~~~~~~~
>
> Similarly, with "test_progs.h" at the beginning of this sequence, compili=
ng
> with GCC 12.3 for x86_64 using glibc would fail like this:
>
> In file included from tools/testing/selftests/bpf/prog_tests/lwt_helpers.=
h:8,
>                  from tools/testing/selftests/bpf/prog_tests/lwt_reroute.=
c:52:
> /usr/include/linux/if.h:83:9: error: redeclaration of enumerator =E2=80=
=98IFF_UP=E2=80=99
>    83 |         IFF_UP                          =3D 1<<0,  /* sysfs */
>       |         ^~~~~~
> /usr/include/net/if.h:44:5: note: previous definition of =E2=80=98IFF_UP=
=E2=80=99 with type =E2=80=98enum <anonymous>=E2=80=99
>    44 |     IFF_UP =3D 0x1,               /* Interface is up.  */
>       |     ^~~~~~
> /usr/include/linux/if.h:84:9: error: redeclaration of enumerator =E2=80=
=98IFF_BROADCAST=E2=80=99
>    84 |         IFF_BROADCAST                   =3D 1<<1,  /* __volatile_=
_ */
>       |         ^~~~~~~~~~~~~
> /usr/include/net/if.h:46:5: note: previous definition of =E2=80=98IFF_BRO=
ADCAST=E2=80=99 with type =E2=80=98enum <anonymous>=E2=80=99
>    46 |     IFF_BROADCAST =3D 0x2,        /* Broadcast address valid.  */
>       |     ^~~~~~~~~~~~~
>
> ...
>
> In file included from /usr/include/linux/icmp.h:23,
>                  from tools/testing/selftests/bpf/prog_tests/lwt_helpers.=
h:10,
>                  from tools/testing/selftests/bpf/prog_tests/lwt_reroute.=
c:52:
> /usr/include/linux/if.h:194:8: error: redefinition of =E2=80=98struct ifm=
ap=E2=80=99
>   194 | struct ifmap {
>       |        ^~~~~
> In file included from tools/testing/selftests/bpf/prog_tests/lwt_helpers.=
h:8,
>                  from tools/testing/selftests/bpf/prog_tests/lwt_reroute.=
c:52:
> /usr/include/net/if.h:111:8: note: originally defined here
>   111 | struct ifmap
>       |        ^~~~~
> In file included from /usr/include/linux/icmp.h:23,
>                  from tools/testing/selftests/bpf/prog_tests/lwt_helpers.=
h:10,
>                  from tools/testing/selftests/bpf/prog_tests/lwt_reroute.=
c:52:
> /usr/include/linux/if.h:232:8: error: redefinition of =E2=80=98struct ifr=
eq=E2=80=99
>   232 | struct ifreq {
>       |        ^~~~~
> In file included from tools/testing/selftests/bpf/prog_tests/lwt_helpers.=
h:8,
>                  from tools/testing/selftests/bpf/prog_tests/lwt_reroute.=
c:52:
> /usr/include/net/if.h:126:8: note: originally defined here
>   126 | struct ifreq
>       |        ^~~~~
>
> Fixes: 43a7c3ef8a15 ("selftests/bpf: Add lwt_xmit tests for BPF_REDIRECT"=
)
> Signed-off-by: Tony Ambardar <tony.ambardar@gmail.com>
> ---
>  tools/testing/selftests/bpf/prog_tests/lwt_helpers.h | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/lwt_helpers.h b/tools=
/testing/selftests/bpf/prog_tests/lwt_helpers.h
> index fb1eb8c67361..8e5e28af03c5 100644
> --- a/tools/testing/selftests/bpf/prog_tests/lwt_helpers.h
> +++ b/tools/testing/selftests/bpf/prog_tests/lwt_helpers.h
> @@ -6,10 +6,9 @@
>  #include <time.h>
>  #include <net/if.h>
>  #include <linux/if_tun.h>
> +#include "test_progs.h" /* between <net/if.h> and <linux/icmp.h> or erro=
rs */

Now we'll be papering over the real issue. Can you see if you can
untangle this mess and ensure that we consistently use either net/if.h
or linux/if.h headers?

pw-bot: cr

>  #include <linux/icmp.h>
>
> -#include "test_progs.h"
> -
>  #define log_err(MSG, ...) \
>         fprintf(stderr, "(%s:%d: errno: %s) " MSG "\n", \
>                 __FILE__, __LINE__, strerror(errno), ##__VA_ARGS__)
> --
> 2.34.1
>

