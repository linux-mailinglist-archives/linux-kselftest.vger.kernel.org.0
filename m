Return-Path: <linux-kselftest+bounces-24191-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F2E24A08BC4
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Jan 2025 10:25:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B2203A3C74
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Jan 2025 09:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE9D920A5E8;
	Fri, 10 Jan 2025 09:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="lyQVylka"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8702F20A5DD;
	Fri, 10 Jan 2025 09:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736500878; cv=none; b=TAYamzR9Bla4RujqCMbtkVmEQ3qPE3QNf8gDKRKsR7bhm0u8VZyQ/eE5aTiCm9lnMcgFjlgCVpJMNCdvhWnj05z1qBXVJGo3OcmGRE/8nCthCcKNjOFqu2yMub+HLunul/ftPVE497CQbV/aMo1dHBgvcG6dOmk8gteJU5kz0tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736500878; c=relaxed/simple;
	bh=71kREDqoIDbpUxQdLPa+jXmEllnT/4m5dNpcbns4cM4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Bv9NFkCx+TrlLGKDRw0l/xr1vNwmhy/MBhGhWmPgbCIIpLTC7Zz4uF3/GCjDceej8v5/bpJh9Tc03ZNxb/RLkJVhf19wb0rtEM/WkOL3VmStMzzY7oO3WH4digEsx3s+ZuR8l80MnWWoK2NFoRqcvFC0ZSGqPnPSotnoIPm56vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=lyQVylka; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 08559FF802;
	Fri, 10 Jan 2025 09:21:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1736500873;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=KNu9MnhjhHE7oM3Fv3s1OlHSd/oNitikD4TzpcQPJCE=;
	b=lyQVylkayEWZ6P7fLCfNkxTNAufgvy68CJm1NDFo8sz9g7l9OT1Ecen546PICFS3TrKspl
	s4mm1dialKfIIvDjvq9nYFCammUsAJBBs0NivFKykGivAcWcLNXzJ3X+Tvolw5hPKnX+Xp
	oxdC47fum2NwTKLGArDS4vsSzpw1hzxCSKJ4G8lxm5tEpz+/FOZVc6uRGH6P6uhnhSP9Es
	tLtWZNM1cSMlqskET8iUk4V8vjv9BFX47o6nn2DXmZW9dVokST8CZfgrBvIzUo8yPmhdnG
	QbQFO4AY6SwyVkOgXqAWaXmYGu6gFB88Os2cgT0rPepZle2KpAbyEDofPQFAHA==
From: "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>
Subject: [PATCH bpf-next v2 0/3] selftests: bpf: Migrate
 test_xdp_redirect.sh to test_progs
Date: Fri, 10 Jan 2025 10:21:08 +0100
Message-Id: <20250110-xdp_redirect-v2-0-b8f3ae53e894@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIXmgGcC/1WNQQrCMBBFr1JmbSRJW3VceQ8pYpKpHdCkJKFUS
 u5u6M7l4/Hf3yBRZEpwbTaItHDi4CvoQwN2evoXCXaVQUvdKa1QrG5+RHIcyWahzYXsGZ3VHUG
 dzJFGXvfcHcw8Ck9rhqGaiVMO8bv/LGr3NdlLJdv/5KKEFIStRBx7lCe8mRDym/3Rhg8MpZQf9
 t57gLQAAAA=
X-Change-ID: 20241219-xdp_redirect-2b8ec79dc24e
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Alexis Lothore <alexis.lothore@bootlin.com>, netdev@vger.kernel.org, 
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>
X-Mailer: b4 0.14.2
X-GND-Sasl: bastien.curutchet@bootlin.com

Hi all,

This patch series continues the work to migrate the *.sh tests into
prog_tests.

test_xdp_redirect.sh tests the XDP redirections done through
bpf_redirect().

These XDP redirections are already tested by prog_tests/xdp_do_redirect.c
but IMO it doesn't cover the exact same code path because
xdp_do_redirect.c uses bpf_prog_test_run_opts() to trigger redirections
of 'fake packets' while test_xdp_redirect.sh redirects packets coming
from the network. Also, the test_xdp_redirect.sh script tests the
redirections with both SKB and DRV modes while xdp_do_redirect.c only
tests the DRV mode.

The patch series adds two new test cases in prog_tests/xdp_do_redirect.c
to replace the test_xdp_redirect.sh script.

Signed-off-by: Bastien Curutchet (eBPF Foundation) <bastien.curutchet@bootlin.com>
---
Changes in v2:
- Use directly skel->progs instead of 'bpf_object__find_program_by_name()'
- Use 'ip -n NSX' in SYS calls instead of opening NSX with open_netns()
- Use #define for static indexes of veth1 and veth2
- Delete the useless second ping
- Set nstoken to NULL after close_netns()
- Merge the two added tests into one with 3 subtests (one for each flag:
  0, DRV, SKB)
- Link to v1: https://lore.kernel.org/r/20250103-xdp_redirect-v1-0-e93099f59069@bootlin.com

---
Bastien Curutchet (eBPF Foundation) (3):
      selftests/bpf: test_xdp_redirect: Rename BPF sections
      selftests/bpf: Migrate test_xdp_redirect.sh to xdp_do_redirect.c
      selftests/bpf: Migrate test_xdp_redirect.c to test_xdp_do_redirect.c

 tools/testing/selftests/bpf/Makefile               |   1 -
 .../selftests/bpf/prog_tests/xdp_do_redirect.c     | 164 +++++++++++++++++++++
 .../selftests/bpf/progs/test_xdp_do_redirect.c     |  12 ++
 .../selftests/bpf/progs/test_xdp_redirect.c        |  26 ----
 tools/testing/selftests/bpf/test_xdp_redirect.sh   |  79 ----------
 5 files changed, 176 insertions(+), 106 deletions(-)
---
base-commit: b27feb5365c6a1bf7e71ba5c795717ee0eec298d
change-id: 20241219-xdp_redirect-2b8ec79dc24e

Best regards,
-- 
Bastien Curutchet (eBPF Foundation) <bastien.curutchet@bootlin.com>


