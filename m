Return-Path: <linux-kselftest+bounces-14148-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6145C93B06E
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Jul 2024 13:34:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C2732849DE
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Jul 2024 11:34:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93FA5158DBA;
	Wed, 24 Jul 2024 11:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="SC/A4ocF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6598158A3F;
	Wed, 24 Jul 2024 11:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721820835; cv=none; b=Ruxo/pHeNhkxXg5iwcIL7nlmX6Ixb7D9STCqUkAnsvrQAq8MN5NvdpG29mNPD952qLEi3sQT2uYRDa3glUUzYRz37h9nBKGgOClKGbBhF3QpdKWVO+DMGhRTEWrfLCOG2LXWI2+gCl/tCLXue23oMMNUCcUq/l4IKDVlKuWd1nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721820835; c=relaxed/simple;
	bh=uOz91Gn2STW9xzMEaWpAYLySta2fPZaLuXdfVEnOago=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=idtw9TS0JdVNX+OEfPVmTJCy9aYoEFCX77LSk26IqpvEcK7zK3EDu57ALApRtocbRUMiGotGHuv9i7ZTRx97QhWPSvtXreBEGjl++i7OUgjDh4CTQxquUZdf7cRMOsPjn2nqduvVqfpMjNlGANa9zKqTddZbzF1GvZhYvo1JDbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=SC/A4ocF; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1sWaFc-008NvU-H0; Wed, 24 Jul 2024 13:33:44 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector1; h=Cc:To:Content-Transfer-Encoding:Content-Type:MIME-Version:
	Message-Id:Date:Subject:From; bh=RG8Mn5O4ciGwSlNQl0ohY2SpG2tlGFwuC693yChqDCs=
	; b=SC/A4ocFdyBLisjIQyiTK2P/YHhqxIwLVnUNKk2Ivi93DG8SyYAt59Va5qVCQbUP07nMQaNYd
	6z/FmMQ0baEmRE3gV6XrWEwJQ/sh5DgTAi/qUX9nX2NrVx69g2PAFQZa5PU8Ny2lNRKY809NPCL4O
	SME+XlSGJPnxW6b1pn12fvCRWz4VzMw4tJgRkFv9OWhAUceiA/e6qsdmGTr5npR9wBmt04zB0Lsrs
	PSOowmAI7GfdXi0G0AugydAVpj0GnxJMPX8Z8xc811ja6islOnnt+IdfYASrnuOJ7f2aKr3tiwsr5
	WIFl101f9WX6szdmbpqdBRjvKm6hC+Tozfkw3A==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1sWaFc-0003y2-5D; Wed, 24 Jul 2024 13:33:44 +0200
Received: by submission03.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1sWaFK-00EK6H-Fs; Wed, 24 Jul 2024 13:33:26 +0200
From: Michal Luczaj <mhal@rbox.co>
Subject: [PATCH bpf 0/6] selftest/bpf: Various sockmap-related fixes
Date: Wed, 24 Jul 2024 13:32:36 +0200
Message-Id: <20240724-sockmap-selftest-fixes-v1-0-46165d224712@rbox.co>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFTmoGYC/x3L3QpAQBBA4VfRXJtisRuvIheLWSZ/246k5N1tL
 r9O5wGhwCTQJA8Eulj42CPyNIFhtvtEyGM0qEyVmVEFyjEsm/UotLqT5ETHNwlqrY2uTVXlhYE
 4+0B/iG8LvXfQve8HyEAMl20AAAA=
To: Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, 
 Jakub Sitnicki <jakub@cloudflare.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Michal Luczaj <mhal@rbox.co>
X-Mailer: b4 0.14.0

Series takes care of few bugs and missing features with the aim to improve
the test coverage of sockmap/sockhash.

Last patch is a create_pair() rewrite making use of
__attribute__((cleanup)) to handle socket fd lifetime.

v0: https://lore.kernel.org/netdev/027fdb41-ee11-4be0-a493-22f28a1abd7c@rbox.co/
  - No declarations in function body (Jakub)
  - Don't touch output arguments until function succeeds (Jakub)

Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
Michal Luczaj (6):
      selftest/bpf: Support more socket types in create_pair()
      selftest/bpf: Socket pair creation, cleanups
      selftest/bpf: Simplify inet_socketpair() and vsock_unix_redir_connectible()
      selftest/bpf: Respect the sotype of af_unix redir tests
      selftest/bpf: Exercise SOCK_STREAM unix_inet_redir_to_connected()
      selftest/bpf: Introduce __attribute__((cleanup)) in create_pair()

 .../selftests/bpf/prog_tests/sockmap_basic.c       |  28 ++--
 .../selftests/bpf/prog_tests/sockmap_helpers.h     | 145 ++++++++++++++-------
 .../selftests/bpf/prog_tests/sockmap_listen.c      | 117 ++---------------
 3 files changed, 120 insertions(+), 170 deletions(-)
---
base-commit: 13c9b702e6cb8e406d5fa6b2dca422fa42d2f13e
change-id: 20240723-sockmap-selftest-fixes-666769755137

Best regards,
-- 
Michal Luczaj <mhal@rbox.co>


