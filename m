Return-Path: <linux-kselftest+bounces-17547-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F8BE9722DA
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Sep 2024 21:38:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CEFD11F24605
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Sep 2024 19:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AEA618A6B5;
	Mon,  9 Sep 2024 19:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3GWPjxGf";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/25BoWyt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C81D17C9B9;
	Mon,  9 Sep 2024 19:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725910705; cv=none; b=pR1aDCGTYg6U4ZJjj5wj9PxB/5VWubvg5jYar524s2T44FkFcj53uM7VTteiuYQvpwESCZwKayMgNDipiPEOm06kO7INsAHwGbxa8PdPLarfB0wUvr4ID4szZutDDvCiojIHxkXueG24Fco8TrywVup1HZZZzo6zEJrmjLBnfYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725910705; c=relaxed/simple;
	bh=RnvkZhjYRI7CMLflZiYVjg05UbvuzfnP5NsX2zc5vA4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=qJ4CtgambG2aMNzuRDCE5rZYLBEnGdY4sabSjayoA2Rs1+9AXJaCWONvgkJoDc2ovx+iyHtWBD5y6Gy13oD2XkFjm7PIHjkAssOY77S9MATMXoeFzt49r0xol7xkULX3SWYbKFm0qXE9IZiQXpq6KIdLnDv1ezHOZF85NG/apY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3GWPjxGf; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/25BoWyt; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Florian Kauer <florian.kauer@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725910702;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=6YEooAw5RFwgRDx0O+u59W8NXtkjDoxyTJ47o256NPE=;
	b=3GWPjxGf/DKI9TaqKxBajvEJuNeK255j6+T0I9psL6Pw2CzhAGQTezsCgRJ3g7waw90BBb
	AKAY8x8EIk6AhvweBLgAIUnO6GxyJrbE2zCUF03XwUPRQXOESSthJjZUjO60/YbDFgGwNQ
	pqkgaYHsJ6jOaj6q6A6JR0bcCXP8WPMh9IN16pSK3U+zCSC2mK06sZywkgfqduN8XP0TM7
	KjhSoWZgTalgl/KA3sT/I9urVSq0Yvs6nSThEkPguCjZDGWQgyi6zuTUwCKdkQEnn0PX+r
	CWh9l537lZgWJrVBrJGyzSEz4MQ1ENLVIrZR6OcixWIzyE4y3CblyHsWbdAjYg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725910702;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=6YEooAw5RFwgRDx0O+u59W8NXtkjDoxyTJ47o256NPE=;
	b=/25BoWytWM3UpjFD4Dlp1P66UOAzwlf3HmaGpABrWj8k3ENnH2NhvP1vExSJpt+dtdRx9B
	pvRP6bU5uY+8saCQ==
Subject: [PATCH net v3 0/2] bpf: devmap: provide rxq after redirect
Date: Mon, 09 Sep 2024 21:38:04 +0200
Message-Id: <20240909-devel-koalo-fix-ingress-ifindex-v3-0-66218191ecca@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJxO32YC/42NTQ7CIBBGr9KwdgxQbFNX3sO4oDBtJzZgoJKap
 neXsDJudPn95L2NRQyEkZ2rjQVMFMm7HOpDxcyk3YhANmcmuVS84yewmHCGu9ezh4FWIDcGjBF
 oIGdxhb6TXW1VK2zfsEx5BMy3Yrgyhwu75XKiuPjwKtYkyvS3IAkQYIXU3LbKyM5cZnLPJXhH6
 9Fi4Sf5yWx+MyVwUEZrIU2jVK++mfu+vwH+rv9XKwEAAA==
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1157;
 i=florian.kauer@linutronix.de; h=from:subject:message-id;
 bh=RnvkZhjYRI7CMLflZiYVjg05UbvuzfnP5NsX2zc5vA4=;
 b=owEBbQKS/ZANAwAKATKF5IolV+EkAcsmYgBm306hIE0EZJvycKLxajvOwUK7ncI3nmDr3BVrr
 0tMIS7bVdKJAjMEAAEKAB0WIQSG5cmCLvpm5t9g7UUyheSKJVfhJAUCZt9OoQAKCRAyheSKJVfh
 JGTHD/9Y1kSnmNhyRHb0AfRk7xJMPl/NhWh2eM7dXClwC9hdQjJMtN7kSf0TvbI2wGFJeDUDW7g
 URitHNg6ptOH7x8XXJTKxDGc1XgHh3jzEmmi9v/rZTml6iFCYvEwgST7dcgHlVLLUnJclQit5zv
 FVer8BArNz32e16DTj0cSk40WX5GpQzkyx3Cn/FMSkeK01VWvghFs/asD94I8QkE2gqyiluW1Hm
 ji+GA9pEv5B72/+EuJEPRWFVUUiHKzMcVUQWIR1knaW+JpTm2MqxFxB+7ocke0pdfG/ewYlQhC/
 kUBmyHvYWEgyQv8iQrfwCgNme+5BIz6j2Zg2n7PffbpZi/PSZEoFpNaZLOJf6yz1i6HaoMhJmBA
 NcIZ4v+xjcMIpeyqVCkNZBFF6MuuHf/nL96ekLjdingUX7uQpGlldlA1k8sZkWGh45Rf6L1fTcA
 9z9i2EhNRTkbzk9UZDmwFHNf5SJt0SCKikBCEYsBGvM5nfo94e64h+fN6zfOhObiUZZOqVpcPf/
 mHbs3H5ntHWMJ5GQlkOQ4mDt4qHr3UjnHlFAVXq3AY0KJttEdnoydqLjcM5aHSJlQnr+Z/Qxa/I
 93FAvcF43Ji2KuNR1RYFf5h9MCngztmAS1v3S7JXdMX2TzmB5M+FkcfAKNcvtB/f6zAdI7kZkt2
 Vvbl1lz2uAYYWOA==
X-Developer-Key: i=florian.kauer@linutronix.de; a=openpgp;
 fpr=F17D8B54133C2229493E64A0B5976DD65251944E

rxq contains a pointer to the device from where
the redirect happened. Currently, the BPF program
that was executed after a redirect via BPF_MAP_TYPE_DEVMAP*
does not have it set.

Add bugfix and related selftest.

Signed-off-by: Florian Kauer <florian.kauer@linutronix.de>
---
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


