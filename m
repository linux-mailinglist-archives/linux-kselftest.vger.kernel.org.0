Return-Path: <linux-kselftest+bounces-14517-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 60B2A942B72
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jul 2024 12:02:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3476B22492
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jul 2024 10:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E415E1AD40B;
	Wed, 31 Jul 2024 10:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="tAYtncIj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F961AC446;
	Wed, 31 Jul 2024 10:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722420119; cv=none; b=mAKVofF6FsPiP8jF+15hKKFL5A9PSxCC83yHHqH6Md/H5LklWSCI/gtcOIOZdqkyZeCuOLtL385Whd+S+JxfUT7YTMB7yesRo4O0CU6bpsHmD7YU/Mfuu83FxSUoh+kR/ipjHx1suhLfq4kopJQ5NoosIwV/DUgz2TUCtL3kQGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722420119; c=relaxed/simple;
	bh=tdubKWeQ7/Pp27n5L80+ynUfu1iDyyVSMxfVMke+z3Q=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=hCY/Hg0IgQhC8TOWL43LBvWHVvJmEi9CncemS6turZzgJ8WpoDbrgTZvKHqXDIIl8EsNYogmN8ZIFjP7vL7SxKLnf+HtwBXnuHHeiZ+tJePQY/O9ooIneMy5fvi89GzBCqTtYsXP81slVqRqW46RIJOl29bu7R7C/S2xppDM0E4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=tAYtncIj; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1sZ69W-007DDf-DO; Wed, 31 Jul 2024 12:01:50 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector1; h=Cc:To:Content-Transfer-Encoding:Content-Type:MIME-Version:
	Message-Id:Date:Subject:From; bh=g7dCkFGrNHMpHsx6fqZcRInO68yF/eYwB79iS1Zb17s=
	; b=tAYtncIjuRy+NFtWuDII+h/eJf652tQWxKZNfgcgRqpUmS/Y+GFjuNsMqYhlcdU+A10aZUI3C
	6ypmcgPtUB+BJast/lzsjZeMNHmEm2wOyqTFzZrstdc7ORA4TjMEWdvsDtbnx5ZHzpGZ+9whNKoRm
	RkBFeW1TQHjjqDErKmuwTRoj75aZ06SRTc2XzkVcmU0mIeVk14GLzomgIeykj4FqK6LSKB3swL9mN
	SNX98CXPNUiKO2q5lzlp/oBxw4SifRfWZ19yJSlKjCRVn4ScveXWDHnjO/ReKqm5eyfeP/uwrUE4W
	Z6N2cP7gDr+tISWgdPE2rVJxF6iA8kaUEpfVtQ==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1sZ69V-0004vj-Tn; Wed, 31 Jul 2024 12:01:50 +0200
Received: by submission02.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1sZ69E-006dO6-N8; Wed, 31 Jul 2024 12:01:32 +0200
From: Michal Luczaj <mhal@rbox.co>
Subject: [PATCH bpf-next v2 0/6] selftests/bpf: Various sockmap-related
 fixes
Date: Wed, 31 Jul 2024 12:01:25 +0200
Message-Id: <20240731-selftest-sockmap-fixes-v2-0-08a0c73abed2@rbox.co>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHULqmYC/x3LQQqDMBBG4avIrDtgU6mkVyldJOmfOmhjyAQRx
 Ls3dPnxeAcpikDp0R1UsInKmhrMpaMwufQBy7uZTG+GfjSWFUus0Mq6hvnrMkfZoexDcNbecR1
 untqcC/6hvU/yOXLCXul1nj/QYy+pcgAAAA==
To: Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, 
 Jakub Sitnicki <jakub@cloudflare.com>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Michal Luczaj <mhal@rbox.co>
X-Mailer: b4 0.14.1

Series takes care of few bugs and missing features with the aim to improve
the test coverage of sockmap/sockhash.

Last patch is a create_pair() rewrite making use of
__attribute__((cleanup)) to handle socket fd lifetime.

Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
Changes in v2:
- Rebase on bpf-next (Jakub)
- Use cleanup helpers from kernel's cleanup.h (Jakub)
- Fix subject of patch 3, rephrase patch 4, use correct prefix
- Link to v1: https://lore.kernel.org/r/20240724-sockmap-selftest-fixes-v1-0-46165d224712@rbox.co

Changes in v1:
- No declarations in function body (Jakub)
- Don't touch output arguments until function succeeds (Jakub)
- Link to v0: https://lore.kernel.org/netdev/027fdb41-ee11-4be0-a493-22f28a1abd7c@rbox.co/

---
Michal Luczaj (6):
      selftests/bpf: Support more socket types in create_pair()
      selftests/bpf: Socket pair creation, cleanups
      selftests/bpf: Simplify inet_socketpair() and vsock_socketpair_connectible()
      selftests/bpf: Honour the sotype of af_unix redir tests
      selftests/bpf: Exercise SOCK_STREAM unix_inet_redir_to_connected()
      selftests/bpf: Introduce __attribute__((cleanup)) in create_pair()

 .../selftests/bpf/prog_tests/sockmap_basic.c       |  28 ++--
 .../selftests/bpf/prog_tests/sockmap_helpers.h     | 149 ++++++++++++++-------
 .../selftests/bpf/prog_tests/sockmap_listen.c      | 117 ++--------------
 3 files changed, 124 insertions(+), 170 deletions(-)
---
base-commit: 92cc2456e9775dc4333fb4aa430763ae4ac2f2d9
change-id: 20240729-selftest-sockmap-fixes-bcca996e143b

Best regards,
-- 
Michal Luczaj <mhal@rbox.co>


