Return-Path: <linux-kselftest+bounces-15551-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AEC0B955058
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Aug 2024 19:57:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D80101C215D7
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Aug 2024 17:57:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD8A51C3F0F;
	Fri, 16 Aug 2024 17:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fqOG/I5t"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 704081C3F01;
	Fri, 16 Aug 2024 17:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723830967; cv=none; b=ic3MZ7BhoLOrVqEp4TLmDsO3/MpujG42u0/1DXclS+wa9//5kM4AJWnxTci98E3bzKfbyDlkvFuxftI46ghx4wqQhS7zxi/Mavk+6R84qG6I2DObi8D+K01zIxXKmBZi++PRIokB6jOyeljp2Zi/AJLlQEHHsAiL7G1DFaR1O5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723830967; c=relaxed/simple;
	bh=T7fGNCI/lVtt8Y86TqJ8a7wmFGxW1GrY9DfL8mSR4As=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=AEmAzm7imXJYha1LAp/m0PZVEseqbboELjpdJMvPGyefjlzHHyUOS8i5Ds17lQvo1MZxslcnCzz9MOma/qBp1jspDKOT3wfnm+Sh1zCBZzRyN7VTK528N8dkDiC15uFS7b0NnrT1JPGGDk2jLOPHsgVhNU5vhWC+sggnrvFB8hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fqOG/I5t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 855C0C32782;
	Fri, 16 Aug 2024 17:56:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723830967;
	bh=T7fGNCI/lVtt8Y86TqJ8a7wmFGxW1GrY9DfL8mSR4As=;
	h=From:Subject:Date:To:Cc:From;
	b=fqOG/I5tKtL2VN3zigfLeHzMfmB+YsGDMdY6osAQou7T7s4sfcAvODDw63DFJRfNy
	 uOUsVi3JrGxPS2mXYo1hAqekFn7GIin097HO81/b8BaGfF+TtTnrRYRchS7M66NzKD
	 G/viHMMYSinxlvZ6ULzszDAiXFqA6+R/TJypv4t9Bi3AXkoaQF0WPdVo4vwo9tnhPq
	 30Dn0a6jd4puNE4Ym4dsPWEfApwyfnHzDCSSl7e+HNfJ3cgQsMOiwx00eT5MQLtAe6
	 ULDzJuBTrMD2hoqEZ1S0CF72zSOpH2B7LVCN1RqwTlIwNmXLnTNHF3oKrBlcSIToZo
	 7Sn/XVG0/mnoA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH bpf-next 0/2] selftests: bpf: avoid duplicated UAPI headers
Date: Fri, 16 Aug 2024 19:55:51 +0200
Message-Id: <20240816-ups-bpf-next-selftests-use-khdr-v1-0-1e19f3d5b17a@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKeSv2YC/zWNwQqDMBAFf0X23AVNbdn2V4oHqy91aUlDNhZB/
 PcGweMcZmYlQ1IY3auVEn5q+g0FmlNFw9SHF1jHwuRq19bSXHmOxs/oOWDJbPj4DMvGs4Hf05j
 Yib+dL4NIKz2VSkzwuuyHBx0iddv2BxYtTCR7AAAA
To: mptcp@lists.linux.dev, Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Jesper Dangaard Brouer <hawk@kernel.org>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2680; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=T7fGNCI/lVtt8Y86TqJ8a7wmFGxW1GrY9DfL8mSR4As=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmv5KyBwk97AcdUek4K5rgC+Mv+BzPsjTpteG0B
 3hNQXXqd6SJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZr+SsgAKCRD2t4JPQmmg
 c0DnEAC1gAqIZja8rQgdsgP4wSyeet8NvGJoV4YkZLU6Xq2YTAcSlquPo5cGYPsvwqU1QPuQiEe
 2XDEkLEos0PGa3J2r2KHuLfTFq2lIad8VEAX118UrJ1Xs+9Mok/jeYfuh5/SI1FCdjgBxCgj7Sj
 EE0QmlK3q07Vr1rOTNTG4Cr0FB0GL89cAfJwzUuRTrSYetK5Or4FMEs60jjoyHYmNEib5Yn1rSx
 cxKgyesNB+JBc1/WdT6n2QzEKA01MrnofeTyBCCUuk5Dh5faGDNIy5hbnYfgyFhuBA/G1pVgZkY
 hBxGj9Dkct8V+YiuTr64uCYItjB7HWwy5pv0TkDmjafY7h1bu5Io8EkC1bTgF56c++RHAAE+jT1
 7dxIuvn0ARMcrCPgvWkOQ3hJkcdrcYQjDmmw1JRO5L0/j+W/qz3cOVabD80RCulQvBgDZ7MNSCF
 7sD4ufj03O/Mc4jGtUbrctyoIuePvm+Smewo31qpILB7DaOjoNSL7ORqxYh9Mo0s9vbMUCezadq
 tyQFb0L8xh9YiT3zsvw3m6O/4fb94bclw/Tr5LPcmymf74XtMFlMOpXofVG73NDITtIYf1KOsGX
 OyP084A+g3Q125v6VKtIj5pgZaaoTcixlqAbcZq6Pr3evoP9lesea7dyjZBjLAxJBbhCA0EljTr
 IXc6XkFOdFOGDrg==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

If a BPF selftest program requires (recent) UAPI headers [1], it is
currently needed to duplicate these header files into tools/include/uapi.
That's not a good solution, because it is a duplication that needs to be
kept up-to-date, while the required files are only a few directories
away.

A solution to avoid these duplicated files is to use the KHDR_INCLUDES
from the kselftest infrastructure. That is what is being done in the
first patch.

The second patch removes 'if_xdp.h', which is no longer needed, and was
causing a warning when building the libbpf required by the BPF
selftests. There could be more duplicated UAPI header files that could
be removed, but I didn't spend too much time checking which ones are not
used by anything else from the 'tools' directory.

Hopefully, these modifications should not cause any issues on the
different CIs, because it is using the recommended method for the kernel
selftests. If this causes issues on the CIs side, it should be easy to
fix by overriding the KHDR_INCLUDES variable, and it might be better to
do that, because it likely means the CI is not following the recommended
way to execute the kernel selftests. See patch 1/2 for more details
about that.

Link: https://lore.kernel.org/all/08f925cd-e267-4a6b-84b1-792515c4e199@kernel.org/T/#u [1]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Matthieu Baerts (NGI0) (2):
      selftests: bpf: use KHDR_INCLUDES for the UAPI headers
      selftests: bpf: remove duplicated UAPI if_xdp headers

 tools/include/uapi/linux/if_xdp.h                  | 173 ---------------------
 tools/lib/bpf/Makefile                             |   3 -
 tools/testing/selftests/bpf/Makefile               |   2 +-
 .../selftests/bpf/prog_tests/assign_reuse.c        |   2 +-
 tools/testing/selftests/bpf/prog_tests/tc_links.c  |   4 +-
 tools/testing/selftests/bpf/prog_tests/tc_netkit.c |   2 +-
 tools/testing/selftests/bpf/prog_tests/tc_opts.c   |   2 +-
 .../selftests/bpf/prog_tests/user_ringbuf.c        |   2 +-
 .../testing/selftests/bpf/prog_tests/xdp_bonding.c |   2 +-
 .../selftests/bpf/prog_tests/xdp_cpumap_attach.c   |   2 +-
 .../selftests/bpf/prog_tests/xdp_devmap_attach.c   |   2 +-
 .../selftests/bpf/prog_tests/xdp_do_redirect.c     |   2 +-
 tools/testing/selftests/bpf/prog_tests/xdp_link.c  |   2 +-
 tools/testing/selftests/bpf/xdp_features.c         |   4 +-
 14 files changed, 14 insertions(+), 190 deletions(-)
---
base-commit: fdf1c728fac541891ef1aa773bfd42728626769c
change-id: 20240816-ups-bpf-next-selftests-use-khdr-28f935c8848a

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>


