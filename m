Return-Path: <linux-kselftest+bounces-14291-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BA1C93DD2B
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 Jul 2024 05:56:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C2101C2342F
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 Jul 2024 03:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5D9C4688;
	Sat, 27 Jul 2024 03:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XVO4lB1L"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED0421879;
	Sat, 27 Jul 2024 03:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722052575; cv=none; b=koNM5+kaNbpmgxM29pJ9tCLnyPUMFAp7PlrzaqdnhHBAsJXwgNJd/W640rqZgMBggINn2edLLywrkts/GRd8sejztNt6rbC/bFHi/WsxQWeqoYbarLCsuq0t/upImRD8a2t21C0C9/lGLklRk4PVjakhjbsv+FgV9ts9oNNewCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722052575; c=relaxed/simple;
	bh=SNHSyuSNFuBnjDLJ5FfGmh8xfNZjOqBSWP+phxp60Nk=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZkSnAcxHzwZKpLhZe68wkOfdhIuW/M1Hbj9gB0lBaTkZR50NRjXw3wI09pK9zKflcOH7NaF0Ll+AfxahVtup1WS9BFA26yiF4dPDfCwMxXwPZIDNvKqaADG09budzTotyMtMI0Nr6Ol6EHnwlk7BaLxUIx+HcvakyHptoU46UcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XVO4lB1L; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e087264e297so348934276.3;
        Fri, 26 Jul 2024 20:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722052573; x=1722657373; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0N0cC6LZTPaZP8xNwyGdaGzHIJjVXTX0NCILFc0SbpU=;
        b=XVO4lB1LPj+f3iBAW1ZLDbzVMipwcS+WhQ0/MKOvkKGEKh7mqV6hQ3Qc/MYDMKn7qP
         xuHjOwH6fgScJYK/brJlNqbtWKtBh5D4UFfjqGIXw6D9CGltClYVkTlW5oVj4pYuaojB
         BvzDTjue0quEC87Z6mdkJZ5lasz6ivfyKbsMBTOMVFMbVE4CE1gn1Nq58PLKJcGawJPp
         KiFhFnftAsbjHD7moFSdgJLdTjsKir4RyiGpkSxRhDh0c8TtOCX3UYPg9gKvZmDdic4X
         QptBR/1jtoXhDnz05L/p3klSmfKdChmsIIdoMUbKwCQ02a1Jg8LUYt8y0jLWMdSS1SkY
         f1CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722052573; x=1722657373;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0N0cC6LZTPaZP8xNwyGdaGzHIJjVXTX0NCILFc0SbpU=;
        b=INwBj0UHZ+rHp4JrohPBfPE6GSd4AjJUoL0y6PsxRi1bl0oL/pd8xNZ6F3+sPY3UhQ
         uqUkvB7dmaTb/ekS+tVnszFSTW84aKPcqmZ4iy2RlMb4OeUWL/+HPDqbgkncM0XikLHk
         7wSQCYWfSyRNx4vxMEQHabLtq/jtlTxRLjX2EIz6aDUys4FulIDlG1qWBv3Wtm2H55rT
         GUS4y8YvcWS8p3oOFykVwyc5kBw5wzuMnhOWrfOv92wmIg13xX9zgX8HySBcZ60EGVBS
         aPz5qN06HNhBMYw6nMyHU90fGYKMe0gX2Cc+J/MSpxbtAaW97Hb1b70tz4qJDngq5Vgu
         Tx0g==
X-Forwarded-Encrypted: i=1; AJvYcCWci4Hn3iIKxJwn/ZQsj2WTTOm7dvJm5diatjUoXN7L9s+ezxe7Cjtacn9Ov4h5dlK1E6APNpWhlCElLXJeFzF3e45UlWg4xgh7ovlCzJq6d7wPJ9j0KhQnPQHchel0YzEE5q70ONa+
X-Gm-Message-State: AOJu0YwEkjSoWfCQAZdN7aTmTi2qFNvHsDrw2kpv4Le0qTh8jRH3j6qZ
	rMVup935pYS5Oi1bjxMI5U4MZsWwnbVF2Q47m/NdSFSxLQc2N0I0
X-Google-Smtp-Source: AGHT+IGUowV7Yb9JdbDe8/pG1DpHEgzFk7d83WvsLYf97rvaDK93vs+LzHD49u8Bsag8bqgchKbB9A==
X-Received: by 2002:a81:8287:0:b0:646:25c7:178e with SMTP id 00721157ae682-67a053e0201mr21186797b3.5.1722052572783;
        Fri, 26 Jul 2024 20:56:12 -0700 (PDT)
Received: from kodidev-ubuntu (69-172-146-21.cable.teksavvy.com. [69.172.146.21])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70ead72ad5asm3519119b3a.90.2024.07.26.20.56.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 20:56:12 -0700 (PDT)
From: Tony Ambardar <tony.ambardar@gmail.com>
X-Google-Original-From: Tony Ambardar <Tony.Ambardar@gmail.com>
Date: Fri, 26 Jul 2024 20:56:10 -0700
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Jonathan Lemon <jonathan.lemon@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Yan Zhai <yan@cloudflare.com>
Subject: Re: [PATCH bpf-next v1 5/8] selftests/bpf: Fix order-of-include
 compile errors in lwt_reroute.c
Message-ID: <ZqRv2uXUk21uj7Gt@kodidev-ubuntu>
References: <cover.1721903630.git.tony.ambardar@gmail.com>
 <b57266bcc9f47ffda1fc5e55933afbf2c1ce1d58.1721903630.git.tony.ambardar@gmail.com>
 <CAEf4BzZO_G59KS4iBj0XVasKYidFMeBJ4wTrSP+J28HNFgdgmw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzZO_G59KS4iBj0XVasKYidFMeBJ4wTrSP+J28HNFgdgmw@mail.gmail.com>

On Thu, Jul 25, 2024 at 01:18:04PM -0700, Andrii Nakryiko wrote:
> On Thu, Jul 25, 2024 at 3:39 AM Tony Ambardar <tony.ambardar@gmail.com> wrote:
> >
> > From: Tony Ambardar <tony.ambardar@gmail.com>
> >
> > Fix redefinition errors seen compiling lwt_reroute.c for mips64el/musl-libc
> > by adjusting the order of includes in lwt_helpers.h. The ordering required
> > is:
> > <net/if.h>  -->  <arpa/inet.h> (from "test_progs.h")  -->  <linux/icmp.h>.
> >
> > Because of the complexity and large number of includes, ordering appears to
> > be fragile however. Previously, with "test_progs.h" at the end of this
> > sequence, compiling with GCC 12.3 for mips64el/musl-libc yields errors:
> >
> > In file included from .../include/arpa/inet.h:9,
> >                  from ./test_progs.h:18,
> >                  from tools/testing/selftests/bpf/prog_tests/lwt_helpers.h:11,
> >                  from tools/testing/selftests/bpf/prog_tests/lwt_reroute.c:52:
> > .../include/netinet/in.h:23:8: error: redefinition of 'struct in6_addr'
> >    23 | struct in6_addr {
> >       |        ^~~~~~~~
> > In file included from .../include/linux/icmp.h:24,
> >                  from tools/testing/selftests/bpf/prog_tests/lwt_helpers.h:9:
> > .../include/linux/in6.h:33:8: note: originally defined here
> >    33 | struct in6_addr {
> >       |        ^~~~~~~~
> > .../include/netinet/in.h:34:8: error: redefinition of 'struct sockaddr_in6'
> >    34 | struct sockaddr_in6 {
> >       |        ^~~~~~~~~~~~
> > .../include/linux/in6.h:50:8: note: originally defined here
> >    50 | struct sockaddr_in6 {
> >       |        ^~~~~~~~~~~~
> > .../include/netinet/in.h:42:8: error: redefinition of 'struct ipv6_mreq'
> >    42 | struct ipv6_mreq {
> >       |        ^~~~~~~~~
> > .../include/linux/in6.h:60:8: note: originally defined here
> >    60 | struct ipv6_mreq {
> >       |        ^~~~~~~~~
> >
> > Similarly, with "test_progs.h" at the beginning of this sequence, compiling
> > with GCC 12.3 for x86_64 using glibc would fail like this:
> >
> > In file included from tools/testing/selftests/bpf/prog_tests/lwt_helpers.h:8,
> >                  from tools/testing/selftests/bpf/prog_tests/lwt_reroute.c:52:
> > /usr/include/linux/if.h:83:9: error: redeclaration of enumerator ‘IFF_UP’
> >    83 |         IFF_UP                          = 1<<0,  /* sysfs */
> >       |         ^~~~~~
> > /usr/include/net/if.h:44:5: note: previous definition of ‘IFF_UP’ with type ‘enum <anonymous>’
> >    44 |     IFF_UP = 0x1,               /* Interface is up.  */
> >       |     ^~~~~~
> > /usr/include/linux/if.h:84:9: error: redeclaration of enumerator ‘IFF_BROADCAST’
> >    84 |         IFF_BROADCAST                   = 1<<1,  /* __volatile__ */
> >       |         ^~~~~~~~~~~~~
> > /usr/include/net/if.h:46:5: note: previous definition of ‘IFF_BROADCAST’ with type ‘enum <anonymous>’
> >    46 |     IFF_BROADCAST = 0x2,        /* Broadcast address valid.  */
> >       |     ^~~~~~~~~~~~~
> >
> > ...
> >
> > In file included from /usr/include/linux/icmp.h:23,
> >                  from tools/testing/selftests/bpf/prog_tests/lwt_helpers.h:10,
> >                  from tools/testing/selftests/bpf/prog_tests/lwt_reroute.c:52:
> > /usr/include/linux/if.h:194:8: error: redefinition of ‘struct ifmap’
> >   194 | struct ifmap {
> >       |        ^~~~~
> > In file included from tools/testing/selftests/bpf/prog_tests/lwt_helpers.h:8,
> >                  from tools/testing/selftests/bpf/prog_tests/lwt_reroute.c:52:
> > /usr/include/net/if.h:111:8: note: originally defined here
> >   111 | struct ifmap
> >       |        ^~~~~
> > In file included from /usr/include/linux/icmp.h:23,
> >                  from tools/testing/selftests/bpf/prog_tests/lwt_helpers.h:10,
> >                  from tools/testing/selftests/bpf/prog_tests/lwt_reroute.c:52:
> > /usr/include/linux/if.h:232:8: error: redefinition of ‘struct ifreq’
> >   232 | struct ifreq {
> >       |        ^~~~~
> > In file included from tools/testing/selftests/bpf/prog_tests/lwt_helpers.h:8,
> >                  from tools/testing/selftests/bpf/prog_tests/lwt_reroute.c:52:
> > /usr/include/net/if.h:126:8: note: originally defined here
> >   126 | struct ifreq
> >       |        ^~~~~
> >
> > Fixes: 43a7c3ef8a15 ("selftests/bpf: Add lwt_xmit tests for BPF_REDIRECT")
> > Signed-off-by: Tony Ambardar <tony.ambardar@gmail.com>
> > ---
> >  tools/testing/selftests/bpf/prog_tests/lwt_helpers.h | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/tools/testing/selftests/bpf/prog_tests/lwt_helpers.h b/tools/testing/selftests/bpf/prog_tests/lwt_helpers.h
> > index fb1eb8c67361..8e5e28af03c5 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/lwt_helpers.h
> > +++ b/tools/testing/selftests/bpf/prog_tests/lwt_helpers.h
> > @@ -6,10 +6,9 @@
> >  #include <time.h>
> >  #include <net/if.h>
> >  #include <linux/if_tun.h>
> > +#include "test_progs.h" /* between <net/if.h> and <linux/icmp.h> or errors */
> 
> Now we'll be papering over the real issue. Can you see if you can
> untangle this mess and ensure that we consistently use either net/if.h
> or linux/if.h headers?
> 

Well, "untangle this mess" is certainly the right phrase, so I'll give it
another go and see what I can find.

> pw-bot: cr
> 
> >  #include <linux/icmp.h>
> >
> > -#include "test_progs.h"
> > -
> >  #define log_err(MSG, ...) \
> >         fprintf(stderr, "(%s:%d: errno: %s) " MSG "\n", \
> >                 __FILE__, __LINE__, strerror(errno), ##__VA_ARGS__)
> > --
> > 2.34.1
> >

