Return-Path: <linux-kselftest+bounces-17730-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69CEA974CD9
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Sep 2024 10:41:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 138741F28B11
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Sep 2024 08:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C2BA155353;
	Wed, 11 Sep 2024 08:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SdxOBws3";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZmqffyMT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3DCC13D881;
	Wed, 11 Sep 2024 08:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726044107; cv=none; b=mUuWLhOckod9MXZ6wRlI6wA02LpytM9y9Lpr2oq5gx4raNhwNVWl0PYlW2htcgK+CpkqUP4d3ESWaAIPGVKt4BD6CyJPN7dMs0vwaiiNtUBZnLt9kadFRonCe0DYJA6I+dbBOcvzuZrzZyAoGJLLpNaUucFeDiRYY5CzvBgdnnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726044107; c=relaxed/simple;
	bh=QXVqM0ep9qjiaA9b9Ehze7JRk9JPQ8NbDOqiRkeXycs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=YFVawX3H+J9tKE+0lfpwidKIv5i2cKJPnFvcab58AWS3qExGipqkZabkOLC4DQwBhXzSRRXs49in5e8P7YBf2VDs1bxkj2jMxPEdf0Hto2+zfQji9fopHTPWIX8tABSUieE392tjHCJOVBuJwOuu2pDC7v98rPKaJfTAxoH6ESM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SdxOBws3; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZmqffyMT; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Florian Kauer <florian.kauer@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1726044103;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=S8DgETyTbstBPqNt/W783jDRLO3m8aY7HIUj6g/Rass=;
	b=SdxOBws3hVPBY+p4UOwFCZnBq2lCgpKCpTaqTYoby5YUmEa7QZ8cFQV4De4DYXC/VBYwZS
	DIyACh2FIrLLeuBcqB77g5JJRaOiTf0CSIlKIazTRzmsUAccR919Oreyvftrfiy54bGgOH
	0Gwqv7E3WgPWDTwsbNU88Zd+RY+0OZmWZGQinL7ABYBhWtVwFoj34OHo8JSnHU2BoeUhC7
	ggpXbN8DglrbuXsdG9vngShBqo0CCCdTGhyEW8B527s0zTbLcTh3cPPBCSUy5kKlFQ+ynA
	53UNN5FrtFMkMk33PwlqVt+hxHdjPRcCtH5awgvDvqSsbZC8Pof0Ox4rnrmzKw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1726044103;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=S8DgETyTbstBPqNt/W783jDRLO3m8aY7HIUj6g/Rass=;
	b=ZmqffyMTIbdbpEVAOIA6FZOn28+ATq/xEF0JhifJhbzdqnHt27oXYDnpBozQZ4Dj3FWp9A
	IJV0btl3EpavMOAQ==
Subject: [PATCH net v4 0/2] bpf: devmap: provide rxq after redirect
Date: Wed, 11 Sep 2024 10:41:17 +0200
Message-Id: <20240911-devel-koalo-fix-ingress-ifindex-v4-0-5c643ae10258@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAK1X4WYC/43NQWoDMQwF0KsEr6tgaVyn7ir3KF14bCURHexiT
 8yUMHevmVUogXT5pc/7N1W5CFf1vrupwk2q5NSDedmpcPHpzCCxZ0WajHb6FSI3nuAr+ynDSRa
 QdC5cK8hJUuQFRkduiOaAcbSqK9+Fe21b+FCJZ/XZjxepcy4/22rD7fXvgYaAEJG8jgcTyIXjJ
 Ok6l5xk2Ufe/Eb3pn1uEmgwwXukYI0ZzSNzuDfdc3PoprWEb+iQQ/B/zXVdfwG5w1HjfwEAAA=
 =
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
 Jiri Olsa <jolsa@kernel.org>, 
 =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>, 
 David Ahern <dsahern@kernel.org>, Hangbin Liu <liuhangbin@gmail.com>, 
 Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jesper Dangaard Brouer <brouer@redhat.com>, 
 linux-kselftest@vger.kernel.org, 
 Florian Kauer <florian.kauer@linutronix.de>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1330;
 i=florian.kauer@linutronix.de; h=from:subject:message-id;
 bh=QXVqM0ep9qjiaA9b9Ehze7JRk9JPQ8NbDOqiRkeXycs=;
 b=owEBbQKS/ZANAwAKATKF5IolV+EkAcsmYgBm4Ve2q3uIsaisQd/QMc/3rfqJRbR7SwtNoe65X
 nIw+lleztOJAjMEAAEKAB0WIQSG5cmCLvpm5t9g7UUyheSKJVfhJAUCZuFXtgAKCRAyheSKJVfh
 JP3LEACT/JMK5dc0j/ZpyYvNchRugdPGrn2/HyYaJe4+SjWnG2t0ICv1OPuah+X7KF5GgJxNBI2
 MfOCaBkVIdzRmtVBjLw9ot+DljSbv0N38kPvTW0SMvAn0B/sVsK4vJmbFl1Y7UHWJXk3aLmoMoe
 eFKPKthMslryz4GF/6MAWaHOkmtzMqDe5dW63xJljBUtZMbrVACRqDkhDgcqcKGv6dkkoNfcvWe
 Q2DAM1IeA2kjCZgB65EF0KRvjgeO8vnGxgn2CNi20aINHZQ7aVn5hXFYmzSDbJLX2lzvLmLMaFK
 jfH9I16RsOFDKMQr0FXZ57OQhc6O1veAThcmpymcFqpsWl0dpqMgHpyJSkfw1gL7rx7iEhyfNdZ
 3oi0YY0wXJPhWS/DKohPZ2IDP5cFRtUUco7HAlsV6y2lDdyyJhm8lG9kH2UkynHDtrlEZT5rEzB
 Kfdu7XjY5xcWLVsaov7mABBLu7L8Zc2RXypaM02ODoMRbAWzrOljVWkjwkXF3r9M3qpEPkOkI99
 ArOT3Tb+TNJ4uRFFNI4qpkkjsy00b/RgfOL242mFvYbzzEh1mzrIrcmkY1Y5ByKgVBOmn796W/b
 T21+vEVsuBAy32wl2u859P7bmhpOo0R82gvjYqe12oRilmZLPVsb1TFyTiSrrQ5uPic6kZ/RjzB
 CkftbMV4Y312RxA==
X-Developer-Key: i=florian.kauer@linutronix.de; a=openpgp;
 fpr=F17D8B54133C2229493E64A0B5976DD65251944E

rxq contains a pointer to the device from where
the redirect happened. Currently, the BPF program
that was executed after a redirect via BPF_MAP_TYPE_DEVMAP*
does not have it set.

Add bugfix and related selftest.

Signed-off-by: Florian Kauer <florian.kauer@linutronix.de>
---
Changes in v4:
- return -> goto out_close, thanks Toke
- Link to v3: https://lore.kernel.org/r/20240909-devel-koalo-fix-ingress-ifindex-v3-0-66218191ecca@linutronix.de

Changes in v3:
- initialize skel to NULL, thanks Stanislav
- Link to v2: https://lore.kernel.org/r/20240906-devel-koalo-fix-ingress-ifindex-v2-0-4caa12c644b4@linutronix.de

Changes in v2:
- changed fixes tag
- added selftest
- Link to v1: https://lore.kernel.org/r/20240905-devel-koalo-fix-ingress-ifindex-v1-1-d12a0d74c29c@linutronix.de

---
Florian Kauer (2):
      bpf: devmap: provide rxq after redirect
      bpf: selftests: send packet to devmap redirect XDP

 kernel/bpf/devmap.c                                |  11 +-
 .../selftests/bpf/prog_tests/xdp_devmap_attach.c   | 114 +++++++++++++++++++--
 2 files changed, 115 insertions(+), 10 deletions(-)
---
base-commit: 8e69c96df771ab469cec278edb47009351de4da6
change-id: 20240905-devel-koalo-fix-ingress-ifindex-b9293d471db6

Best regards,
-- 
Florian Kauer <florian.kauer@linutronix.de>


