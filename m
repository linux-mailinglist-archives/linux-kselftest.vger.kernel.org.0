Return-Path: <linux-kselftest+bounces-19859-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1759D9A11A6
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Oct 2024 20:35:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98A6BB2254E
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Oct 2024 18:35:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84DDA2139B5;
	Wed, 16 Oct 2024 18:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="hu5Dw3sZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D112139AF;
	Wed, 16 Oct 2024 18:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729103749; cv=none; b=IwHU1JUKfVLLEnToBXPmJLMRORHIFhpM+1rBbeFpncMkTJZYZkqqZASFfkdlyWhg/A1+dHJWj+7JyVaIfrjGgSPL35pCsjwTr32sGnvqeKe25WlO6vMKo7ozMztsk9hEnxOftbL3bWS7hPBkmWdF/03t9eGqNg+45GMNmpK/oIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729103749; c=relaxed/simple;
	bh=gtrF4zPM5AFeLktgKFVWiAGJ8CilTELDXnQpcLMtl5s=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=R40F/Vt1aQSOraq1YAXAnRCXegbTdChQvIGmCtkojshyhg9TAZVJq/99Fl7TRURxn5aWFNsG3PCf0w+NahqPQ3RHc9RucabXfwwRmajDJEEs1VPmEIU2nGY2OIS3Km/q+z5UkrCrTMLzNBurnaTlgLqOnJgSZ3CrWddxLuUa0hQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=hu5Dw3sZ; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id BFE33C0005;
	Wed, 16 Oct 2024 18:35:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1729103744;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=TGnXEDRtylOFzUTpibw7jOg90yuA3FnAohBNNwRGYyI=;
	b=hu5Dw3sZlaEpyIv8j6YpZKvFzFQlxJzh9OXWSVk1HkbWR1Vna8rV4uv4f6+o1mY+l5lrKH
	26Eo3L4YYkPvEZFPhjnQSz1YBG78pUv7lHzDp8bT6VnrSmYRVZWySxs75qOtrwjLmeMb+P
	ngesfvahsVJFExtjvAoaHs8Jsx1OKOj2DnVxJpVPe2D0LvhHMDHf9vK2suLQKX2O7GbOUp
	BAVmkiCmaPfOPYla8ED/7xkvK8t8pvI7M2i7qHjBIpuqfo93kwfygTZ3osCawJigcEuUQN
	4tfjVtk15cu4JSU7EvCcCmER2tZNvuDaeqtLV1rq9PALW8Zru9D+vBzGpFUyeQ==
From: =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
Subject: [PATCH bpf-next 0/6] selftests/bpf: integrate
 test_tcp_check_syncookie.sh into test_progs
Date: Wed, 16 Oct 2024 20:35:21 +0200
Message-Id: <20241016-syncookie-v1-0-3b7a0de12153@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAGkHEGcC/x3MQQqAIBBA0avIrBNU1KKrRIuyqYZAQyOM8O5Jy
 wef/0LCSJigZy9EvClR8BWyYeD2yW/IaakGJZSWQhqeHu9COAg5Tq3trLLadBZqf0ZcKf+vAeZ
 z5R7zBWMpH0xSA6NlAAAA
X-Change-ID: 20241015-syncookie-ea7686264586
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, 
 Shuah Khan <shuah@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>
Cc: ebpf@linuxfoundation.org, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Lorenz Bauer <lmb@cloudflare.com>, bpf@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, 
 =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
X-Mailer: b4 0.14.2
X-GND-Sasl: alexis.lothore@bootlin.com

Hello,
this series aims to bring test_tcp_check_syncookie.sh scope into
test_progs to make sure that the corresponding tests are also run
automatically in CI. This script tests for bpf_tcp_{gen,check}_syncookie
and bpf_skc_lookup_tcp, in different contexts (ipv4, v6 or dual, and
with tc and xdp programs).
Some other tests like btf_skc_cls_ingress have some overlapping tests with
test_tcp_check_syncookie.sh, so this series moves the missing bits from
test_tcp_check_syncookie.sh into btf_skc_cls_ingress, which is already
integrated into test_progs.
- the first three commits bring some minor improvements to
  btf_skc_cls_ingress without changing its testing scope
- fourth and fifth commits bring test_tcp_check_syncookie.sh features
  into btf_skc_cls_ingress
- last commit removes test_tcp_check_syncookie.sh

The only topic for which I am not sure for this integration is the
necessity or not to run the tests with different program types:
test_tcp_check_syncookie.sh runs tests with both tc and xdp programs, but
btf_skc_cls_ingress currently tests those helpers only with a tc
program. Would it make sense to also make sure that btf_skc_cls_ingress
is tested with all the programs types supported by those helpers ?

The series has been tested both in CI and in a local x86_64 qemu
environment:
  # ./test_progs -a btf_skc_cls_ingress
  #38/1    btf_skc_cls_ingress/conn_ipv4:OK
  #38/2    btf_skc_cls_ingress/conn_ipv6:OK
  #38/3    btf_skc_cls_ingress/conn_dual:OK
  #38/4    btf_skc_cls_ingress/syncookie_ipv4:OK
  #38/5    btf_skc_cls_ingress/syncookie_ipv6:OK
  #38/6    btf_skc_cls_ingress/syncookie_dual:OK
  #38      btf_skc_cls_ingress:OK
  Summary: 1/6 PASSED, 0 SKIPPED, 0 FAILED

Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>
---
Alexis Lothoré (eBPF Foundation) (6):
      selftests/bpf: factorize conn and syncookies tests in a single runner
      selftests/bpf: add missing ns cleanups in btf_skc_cls_ingress
      selftests/bpf: get rid of global vars in btf_skc_cls_ingress
      selftests/bpf: add ipv4 and dual ipv4/ipv6 support in btf_skc_cls_ingress
      selftests/bpf: test MSS value returned with bpf_tcp_gen_syncookie
      selftests/bpf: remove test_tcp_check_syncookie

 tools/testing/selftests/bpf/.gitignore             |   1 -
 tools/testing/selftests/bpf/Makefile               |   9 +-
 .../selftests/bpf/prog_tests/btf_skc_cls_ingress.c | 265 +++++++++++++--------
 .../selftests/bpf/progs/test_btf_skc_cls_ingress.c |  83 +++++--
 .../bpf/progs/test_tcp_check_syncookie_kern.c      | 167 -------------
 .../selftests/bpf/test_tcp_check_syncookie.sh      |  85 -------
 .../selftests/bpf/test_tcp_check_syncookie_user.c  | 213 -----------------
 7 files changed, 222 insertions(+), 601 deletions(-)
---
base-commit: 030207b7fce8bad6827615cfc2c6592916e2c336
change-id: 20241015-syncookie-ea7686264586

Best regards,
-- 
Alexis Lothoré, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


