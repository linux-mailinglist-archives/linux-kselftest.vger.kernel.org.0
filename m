Return-Path: <linux-kselftest+bounces-40820-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 58AE0B455E3
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Sep 2025 13:13:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 449041B2514A
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Sep 2025 11:13:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADDCD345738;
	Fri,  5 Sep 2025 11:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="kVbIoThB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2561A342CA5;
	Fri,  5 Sep 2025 11:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757070727; cv=none; b=hlxIoh08SDJhCinIvOVtT6Em5XMHBrf4jg7VVQj3xEC73qBt61Gr0VhJ7/Wwz4nEH2ChhSdCjqXgQ05HPPgv0bynrAkd/ucnvebEfcxvYCi1+E7gdf0CLMMASYIaj6826HkLsxgDwZYFAyLWzpXf/3wWRt4SNKFowk/sGmUlXpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757070727; c=relaxed/simple;
	bh=glh5P06NCOevpZ9Sp5glEkCB0eLqJHhinW20Q0pz7pM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=rIAwq/QixcFTVBSvtIT46yWWjaxWZLArDmSG4s9JE74pGkauvAFFbCJBeKLRcSrXuydkNXSFww+SlmEqNm2pcr15Oa3vGxQZtkSi5gJmQMdsm//w31Ri7qztF3Yyvlv7XW5CcXr8EulwOsHYDQuO7KkFK783WTLiDb+QAwZmCA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=kVbIoThB; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1uuUMK-003UQI-8Y; Fri, 05 Sep 2025 13:12:00 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector1; h=Cc:To:Content-Transfer-Encoding:Content-Type:MIME-Version:
	Message-Id:Date:Subject:From; bh=jZMIXDdUUTfEaODnK4UbKydDgc130U4hQ1ir/5FWrj8=
	; b=kVbIoThBdF/pnJV9uhuDsN6t/KmTirGB9NqdKrB78HQq33bZwJcbCcra2oRSzBo9rS287semZ
	2go0P2eZZ0/nnbSor2tNe/Tlb8h+sIwkvjfqDre33kb+/InsYIxVDyLCstwl2nYzlgWhtjHyQPOvg
	H1rTe5N1OIwIGnHFZHuViwLyYYbCCrH1O/WbtLNO3+uQ0yw35DAjpGtuMJf8VWfxmyZLEXoMUExDY
	g0k9ldpo3J4d8YBSZYDo1pTVgCJrVnDWByf28EGQ5awnuli1G+/yyWZ35eN9KV2sviiWlzk29NdJ6
	PP9q+G1wzhvxII43Z48nMPE0BLJ1W4VWREQtSg==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1uuUMJ-0002Ga-Ky; Fri, 05 Sep 2025 13:11:59 +0200
Received: by submission02.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1uuUM9-002yZ1-1E; Fri, 05 Sep 2025 13:11:49 +0200
From: Michal Luczaj <mhal@rbox.co>
Subject: [PATCH bpf-next 0/5] selftests/bpf: Extend sockmap_redir to test
 no-redir SK_DROP/SK_PASS
Date: Fri, 05 Sep 2025 13:11:40 +0200
Message-Id: <20250905-redir-test-pass-drop-v1-0-9d9e43ff40df@rbox.co>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGzFumgC/x3MMQ6DMAxG4asgz7UErtKhV6kYUvKn9RIiO0JIi
 LsTMX7Dewc5TOH0Hg4ybOq6lo7pMdDyj+UH1tRNMkoYgzzZkNS4wRvX6M7J1sqSJQakJb4wUU+
 rIet+bz/0rZkL9kbzeV6bonpvcAAAAA==
X-Change-ID: 20250523-redir-test-pass-drop-2f2a5edca6e1
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Michal Luczaj <mhal@rbox.co>, 
 Jiayuan Chen <mrpre@163.com>
X-Mailer: b4 0.14.2

sockmap_redir was introduced to comprehensively test the BPF redirection.
This series strives to increase the tested sockmap/sockhash code coverage;
adds support for skipping the actual redirect part, allowing to simply
SK_DROP or SK_PASS the packet.

BPF_MAP_TYPE_SOCKMAP
BPF_MAP_TYPE_SOCKHASH
	x
sk_msg-to-egress
sk_msg-to-ingress
sk_skb-to-egress
sk_skb-to-ingress
	x
AF_INET, SOCK_STREAM
AF_INET6, SOCK_STREAM
AF_INET, SOCK_DGRAM
AF_INET6, SOCK_DGRAM
AF_UNIX, SOCK_STREAM
AF_UNIX, SOCK_DGRAM
AF_VSOCK, SOCK_STREAM
AF_VSOCK, SOCK_SEQPACKET
	x
SK_REDIRECT
SK_DROP
SK_PASS

Patch 5 ("Support no-redirect SK_DROP/SK_PASS") implements the feature.
Patches 3 ("Rename functions") and 4 ("Let test specify skel's
redirect_type") make preparatory changes.

I also took the opportunity to clean up (Patch 1, "Simplify try_recv()")
and improve a bit (Patch 2, "Fix OOB handling").

$ cd tools/testing/selftests/bpf
$ make
$ sudo ./test_progs -t sockmap_redir
...
Summary: 1/720 PASSED, 0 SKIPPED, 0 FAILED

Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
Michal Luczaj (5):
      selftests/bpf: sockmap_redir: Simplify try_recv()
      selftests/bpf: sockmap_redir: Fix OOB handling
      selftests/bpf: sockmap_redir: Rename functions
      selftests/bpf: sockmap_redir: Let test specify skel's redirect_type
      selftests/bpf: sockmap_redir: Support no-redirect SK_DROP/SK_PASS

 .../selftests/bpf/prog_tests/sockmap_redir.c       | 143 +++++++++++++++------
 1 file changed, 105 insertions(+), 38 deletions(-)
---
base-commit: e8a6a9d3e8cc539d281e77b9df2439f223ec8153
change-id: 20250523-redir-test-pass-drop-2f2a5edca6e1

Best regards,
-- 
Michal Luczaj <mhal@rbox.co>


