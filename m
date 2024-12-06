Return-Path: <linux-kselftest+bounces-22903-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC2379E688C
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Dec 2024 09:12:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 581D8281292
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Dec 2024 08:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6094E1DE3C7;
	Fri,  6 Dec 2024 08:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="W9aBfhgD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4CD719CCF9;
	Fri,  6 Dec 2024 08:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733472768; cv=none; b=e8DN6qwH9OXMqJ31OR0cVjpRqZu/k8XMCCipd41nvy5QA21Yovza7gnSIBwl1O/P8km/g6zLqMMtQn+UMgnPl4xt7l3GJr2jdhTbLA/DJBMuJQriVNtwgYJ9E4QyOgZfZ6iOpTR995k4q8A0sHjA5luw4XVlcZWC+sYrbUvBZB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733472768; c=relaxed/simple;
	bh=JNNaH34EO1nd5+Uu6cgEU/6hEXGP18OfUC6K9iiula4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=uuimZrrS44yDrzKNsS3Gwtj/Ob0kZnInwHg+Y54/4W0U6jyQVrifOxOzJivopdgQNdAao2IsIeyanOU1vNVewgaunD73L+SolWuajSezrq3OSvbPWjQJs1fpXzGstH+xZjdkpGOOVz/CjuPwxXHo42AtyHctCtSULxhTgh46zVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=W9aBfhgD; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5209440004;
	Fri,  6 Dec 2024 08:12:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1733472756;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=j/7tWpNlbID7+A63lCqTn/CaIDT0TjA2WkhQtioC0pU=;
	b=W9aBfhgDL5IyBLU6yuZvDIpV+1I2rYdI8SGNlSQ/AWolFxp5HKfUX4G+exIEsh3v3o8H8r
	A3RPIRp6CMokDAnjuudVMdM4EP8eLXTiNhcLyReJe6TxzGcql054u1pU2siH2d3qoUj71N
	Bl0OC3P6ZK6xPsYG1EbqoSchTgbr15L9ROAiGm7dC/8n9QKTqX2iKE2qSE+zW9nvNKA6Pg
	BVRbVb1ut2BVM86++lIrGYXZ5Ndp5+9NkF9pmw+7LLagv/3V8nZtO6YEA7x8JO3CSnq3Gg
	d83llv2+pGP7hUvPuxkG1XefLnJOVqBOuRre3kOOUGS3EUENJ0VfqwOOiYvyOw==
From: Bastien Curutchet <bastien.curutchet@bootlin.com>
Subject: [PATCH bpf-next 0/2] selftests: bpf: Migrate test_xdp_meta.sh to
 test_progs
Date: Fri, 06 Dec 2024 09:12:12 +0100
Message-Id: <20241206-xdp_meta-v1-0-5c150618f6e9@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANyxUmcC/x3MQQqAIBBA0avErBMmjYquEhGVY80iE5UQpLsnL
 R98foZAninAWGXw9HDg2xY0dQX7udqDBOtikCjbRqISSbvloriKoRsU9rtGQgUld54Mp381wea
 MsJQizO/7Ab7b/plkAAAA
X-Change-ID: 20241203-xdp_meta-868307cd0e03
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
Cc: Alexis Lothore <alexis.lothore@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org, 
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>
X-Mailer: b4 0.14.2
X-GND-Sasl: bastien.curutchet@bootlin.com

Hi all,

This patch series continues the work to migrate the script tests into
prog_tests.

test_xdp_meta.sh uses the BPF programs defined in progs/test_xdp_meta.c
to do a simple XDP/TC functional test that checks the metadata
allocation performed by the bpf_xdp_adjust_meta() helper.

This is already partly covered by two tests under prog_tests/:
- xdp_context_test_run.c uses bpf_prog_test_run_opts() to verify the
validity of the xdp_md context after a call to bpf_xdp_adjust_meta()
- xdp_metadata.c ensures that these meta-data can be exchanged through
an AF_XDP socket.

However test_xdp_meta.sh also verifies that the meta-data initialized
in the struct xdp_md is forwarded to the struct __sk_buff used by BPF
programs at 'TC level'. To cover this, I add a test case in
xdp_context_test_run.c that uses the same BPF programs from
progs/test_xdp_meta.c.

---
Bastien Curutchet (2):
      selftests/bpf: test_xdp_meta: Rename BPF sections
      selftests/bpf: Migrate test_xdp_meta.sh into xdp_context_test_run.c

 tools/testing/selftests/bpf/Makefile               |  1 -
 .../bpf/prog_tests/xdp_context_test_run.c          | 86 ++++++++++++++++++++++
 tools/testing/selftests/bpf/progs/test_xdp_meta.c  |  4 +-
 tools/testing/selftests/bpf/test_xdp_meta.sh       | 58 ---------------
 4 files changed, 88 insertions(+), 61 deletions(-)
---
base-commit: 6849a3de3507a490fb0788c9bafbb2f29a904f05
change-id: 20241203-xdp_meta-868307cd0e03

Best regards,
-- 
Bastien Curutchet (eBPF Foundation) <bastien.curutchet@bootlin.com>


