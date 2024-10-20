Return-Path: <linux-kselftest+bounces-20220-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D83ED9A5609
	for <lists+linux-kselftest@lfdr.de>; Sun, 20 Oct 2024 21:23:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F7111F21584
	for <lists+linux-kselftest@lfdr.de>; Sun, 20 Oct 2024 19:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FDFD196434;
	Sun, 20 Oct 2024 19:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="n1n6IHGX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00790C2C6;
	Sun, 20 Oct 2024 19:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729452197; cv=none; b=DbQyd+fwLkKzj+sTfp1wi1jLcGSmDIGoTwS3MdvIN8LBRMLtwm0y434wc8LCAcGO6hcMnSgN5VOhjo4ojzd8ZyE+HebWCvNsdw6HRruk1ceGobQ5Cmhy3mVQmeI3C9BNscva08eGR/1PJD+EsYAmVJB/FcmSpcalKuywIvVX4cY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729452197; c=relaxed/simple;
	bh=c2HWT4gCvfaBx0f4vU+MqomfioLzCAn/zhpHtgH8vfU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=QxuVdBYOxKl0JMGPlLYv2X5o4bdLdmDuTZFX47VBRsxmiOIm6x1hAlwhAMVLTUekLAfTI6mYiP5lx7UWFERT2ZoJL1D/NWeJh3oej4rrDv/kWr9d+2VhsY3vdOX0rPR9Sq5U0qDcuErZiAyMGK9pLJb4ww4xCwVTLJ1RDzVJtHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=n1n6IHGX; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 26B52240005;
	Sun, 20 Oct 2024 19:23:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1729452185;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=66oWL8FFyWQvIReQm+bsye/p0smamRZi1ITOxDVWHvw=;
	b=n1n6IHGX0MZUv/0Thc8P85HlCTlIDg+8uQGITHIP9FXaGJdKBBQVGs+JLwwCkjh7BHrI9r
	rc399i1CSq3ZZD8iqmhMYJiYMtnQc7+43yCBRaoFUg8KWJ0CVPkn/BcVPH2QmtX/xrtZHC
	QQpdwao+UGMM64wg+0ooj1y+cz1Ylh9H1QvOASTiwCX1PbkBbGW4ZsOMWFPAKRCP3y3FZ4
	IowuCXoPGRZbZn8ERDgx3NkgaBfQ/v4vNUyFT8a482cVft7bubN1qIIa7D12fyYOLzF65k
	mVkco8vWhCRKHwlyFxki5bDRHU3U8fFzlEKhE5qNeQoYY3usNcUSKDd7uvpYGQ==
From: =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
Subject: [PATCH bpf-next v2 0/6] selftests/bpf: integrate
 test_tcp_check_syncookie.sh into test_progs
Date: Sun, 20 Oct 2024 21:22:52 +0200
Message-Id: <20241020-syncookie-v2-0-2db240225fed@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAIxYFWcC/02NywqDMBBFf0Vm3ZQkapSu+h/FhY+xDm0zkoSgS
 P69Qbro8nAu5x7g0RF6uBUHOIzkiW0GfSlgXHr7REFTZtBSV0qqWvjdjswvQoF9Y1qjTVW3BvJ
 +dTjTdrYeMKyzsLgF6LJZyAd2+3kS1el/PfPXi0pIUQ5NLydUWtXlfWAOb7LXkT/QpZS+QV3uS
 q4AAAA=
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
 Lorenz Bauer <lorenz.bauer@isovalent.com>, bpf@vger.kernel.org, 
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
Changes in v2:
- fix initial test author mail in Cc
- Fix default cases in switches: indent, action
- remove unneeded initializer
- remove duplicate interface bring-up
- remove unnecessary check and return in bpf program
- Link to v1: https://lore.kernel.org/r/20241016-syncookie-v1-0-3b7a0de12153@bootlin.com

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
 .../selftests/bpf/prog_tests/btf_skc_cls_ingress.c | 264 +++++++++++++--------
 .../selftests/bpf/progs/test_btf_skc_cls_ingress.c |  82 ++++---
 .../bpf/progs/test_tcp_check_syncookie_kern.c      | 167 -------------
 .../selftests/bpf/test_tcp_check_syncookie.sh      |  85 -------
 .../selftests/bpf/test_tcp_check_syncookie_user.c  | 213 -----------------
 7 files changed, 217 insertions(+), 604 deletions(-)
---
base-commit: 030207b7fce8bad6827615cfc2c6592916e2c336
change-id: 20241015-syncookie-ea7686264586

Best regards,
-- 
Alexis Lothoré, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


