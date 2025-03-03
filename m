Return-Path: <linux-kselftest+bounces-28228-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16ECFA4EAC3
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Mar 2025 19:11:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCB951893B75
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Mar 2025 18:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2789259C88;
	Tue,  4 Mar 2025 17:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="UJN6nX7O"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from beeline1.cc.itu.edu.tr (beeline1.cc.itu.edu.tr [160.75.25.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E972F1F3D30
	for <linux-kselftest@vger.kernel.org>; Tue,  4 Mar 2025 17:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=160.75.25.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741110396; cv=pass; b=mkOEkDABLQph1VinWT2lOmpxqRdbF8isRHStQIZZEcPbWdA1+Kwk6mdP1ZeuvtZkRkLeb/c1KUultWubjCWk6Q2trojSK8MpshvuRLrggcsQBxHJAGwSFpy5KIM9L/C68vIsi0UnX4WWHI1NCZEgsr0DG9rrW+ggSXF1qnNSfV4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741110396; c=relaxed/simple;
	bh=VmzpT3xQVyvpJRwyRzfT67E539eO66WnD2nAargeggQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=nqGUpJ1RtPZiW4USki8HclItqRqnh3tI+7GA40MYUf1Ii7izVnHDafIRPBPUN6MDAEGBFeHNvE//7GYB5wxRRsmwVLtEqmDWnSNhqNZYuA7ROrGdIytzTJxqpBg/zVB64hLHlzmUD7iEzQU9Ky7R1OuJWiZ8IH9TckfSUCUPgl8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=none smtp.mailfrom=cc.itu.edu.tr; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=UJN6nX7O; arc=none smtp.client-ip=217.70.183.200; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; arc=pass smtp.client-ip=160.75.25.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr
Received: from lesvatest1.cc.itu.edu.tr (lesvatest1.cc.itu.edu.tr [10.146.128.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by beeline1.cc.itu.edu.tr (Postfix) with ESMTPS id 2919440D0B71
	for <linux-kselftest@vger.kernel.org>; Tue,  4 Mar 2025 20:46:33 +0300 (+03)
X-Envelope-From: <root@cc.itu.edu.tr>
Received: from lesva1.cc.itu.edu.tr (unknown [160.75.70.79])
	by lesvatest1.cc.itu.edu.tr (Postfix) with ESMTP id 4Z6gWy6J76zG2Mc
	for <linux-kselftest@vger.kernel.org>; Tue,  4 Mar 2025 19:05:50 +0300 (+03)
Received: by le1 (Postfix, from userid 0)
	id C324341898; Tue,  4 Mar 2025 19:05:33 +0300 (+03)
Authentication-Results: lesva1.cc.itu.edu.tr;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=UJN6nX7O
X-Envelope-From: <linux-kernel+bounces-541135-bozkiru=itu.edu.tr@vger.kernel.org>
Authentication-Results: lesva2.cc.itu.edu.tr;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=UJN6nX7O
Received: from fgw2.itu.edu.tr (fgw2.itu.edu.tr [160.75.25.104])
	by le2 (Postfix) with ESMTP id B0BD842BD2
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 11:23:46 +0300 (+03)
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by fgw2.itu.edu.tr (Postfix) with SMTP id 4D6342DCF0
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 11:23:46 +0300 (+03)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77E183ADD38
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 08:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3F3D1EFFB6;
	Mon,  3 Mar 2025 08:23:00 +0000 (UTC)
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA6023F36D;
	Mon,  3 Mar 2025 08:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740990177; cv=none; b=aQbPY7uXB/CNf4SYSiphRsaHKazbT0fiZ50tgluqoFSCqfbFUydctuBmAk5bfANKDLkjmysYUmLCc+kuj83AxrLOfb/VH6XJyMJ7YKnvzITPN86oR3Rx/yDqB/6h5hVwhkQVb1CYbWerjtzwCSfKqLK6K+jveAV+U+W/WAdd/1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740990177; c=relaxed/simple;
	bh=VmzpT3xQVyvpJRwyRzfT67E539eO66WnD2nAargeggQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Zi6ZPjnZAFIIUK/Gh6/VKQiOsnqxUZYiXpgVMsprn7sdAHtNDEPES4u3Fx26kAngi6bz35u2apZMdqPtVUycouWZb8gksG8gg43rQBPjbbYSRE7/61yXryMCTFxj7bdqZOz4K3Ce/S4lT+iaxeQwI92Y6PGXKNsuS8Z6zWVC+t0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=UJN6nX7O; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4539D44352;
	Mon,  3 Mar 2025 08:22:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1740990172;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=jqlu8eOJiZMNZm/+Mkhpb1rlBXN5YMdMX15PMY6me0M=;
	b=UJN6nX7Om5ZXdA8i/wrHFqWm6b317tIL/moZqP5+5o5ASSr7cSh2+yxB/WjLoJ7J08sfqZ
	WKYEHGB/H5mygk56iHVN5h5Dj6IZkjzQbbsveiaU4LrIjn+TA8YKle0MhMWB4em8OdqPEQ
	2Wc08R0Yt9IepEnIgHKbMuKtKcSuzM2jg0BVuUkktweDxkBlHesTNjISSOb08xdCEsI0AO
	G/GeqpBaREnV+RPgnaJ/hJ5U0VbSC+RC2luhN9vU6x7lvhEPXmpzf0Dv9l7zgdb4UMbtQR
	VySb5FV5iyJk/UMW945XW5i07SzcolBZWrD0HqxrniWetntDG0E8TcOw9pqWjw==
From: "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>
Subject: [PATCH bpf-next v2 00/10] selftests/bpf: Migrate test_tunnel.sh to
 test_progs
Date: Mon, 03 Mar 2025 09:22:48 +0100
Message-Id: <20250303-tunnels-v2-0-8329f38f0678@bootlin.com>
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANhmxWcC/z2Nyw7CIBBFf6WZtRgeRaMr/8N0Ae1gJ6nQAJKap
 v8uYeHy5Nycu0PCSJjg3u0QsVCi4CvIUwfjbPwLGU2VQXKpuVCC5Y/3uCSmb/bSCzTKCQ51vUZ
 0tLXSE+zqmMctw1DNTCmH+G0XRTTfalJe/7UiGGdKTU6PihvD+4cNIS/kz2N4w3Acxw99YJm5q
 gAAAA==
X-Change-ID: 20250131-tunnels-59b641ea3f10
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Alexis Lothore <alexis.lothore@bootlin.com>, bpf@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>
X-Mailer: b4 0.14.2
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdelkeeifecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffufffkgggtgffvvefosehtjeertdertdejnecuhfhrohhmpedfuegrshhtihgvnhcuvehurhhuthgthhgvthculdgvuefrhfcuhfhouhhnuggrthhiohhnmddfuceosggrshhtihgvnhdrtghurhhuthgthhgvthessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhephffgheekudehgeduiedufeevtdejjedvffekffetudejiefgkefgieeuheeftdejnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghloheplgduledvrdduieekrddtrddugegnpdhmrghilhhfrhhomhepsggrshhtihgvnhdrtghurhhuthgthhgvthessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepvddtpdhrtghpthhtoheplhhinhhugidqkhhsvghlfhhtvghsthesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehshhhurghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehjohhhnhdrfhgrshhtrggsvghnugesghhmrghilhdrtghomhdpr
 hgtphhtthhopegvugguhiiikeejsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhonhhgsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrshhtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehmhihkohhlrghlsehfsgdrtghomhdprhgtphhtthhopegrnhgurhhiiheskhgvrhhnvghlrdhorhhg
X-GND-Sasl: bastien.curutchet@bootlin.com
X-ITU-Libra-ESVA-Information: Please contact Istanbul Teknik Universitesi for more information
X-ITU-Libra-ESVA-ID: 4Z6gWy6J76zG2Mc
X-ITU-Libra-ESVA: No virus found
X-ITU-Libra-ESVA-From: root@cc.itu.edu.tr
X-ITU-Libra-ESVA-Watermark: 1741715077.87039@TfspID1dN4IE5/dN9viWLA
X-ITU-MailScanner-SpamCheck: not spam

Hi all,

This patch series continues the work to migrate the *.sh tests into
prog_tests framework.

The test_tunnel.sh script has already been partly migrated to
test_progs in prog_tests/test_tunnel.c so I add my work to it.

PATCH 1 & 2 create some helpers to avoid code duplication and ease the
migration in the following patches.
PATCH 3 to 9 migrate the tests of gre, ip6gre, erspan, ip6erspan,
geneve, ip6geneve and ip6tnl tunnels.
PATCH 10 removes test_tunnel.sh

Signed-off-by: Bastien Curutchet (eBPF Foundation) <bastien.curutchet@bootlin.com>
---
Changes in v2:
- PATCH 1: Move tc_hook definition to attatch_tc_prog()
- PATCH 4: Disable DAD through `ip addr`
- Link to v1: https://lore.kernel.org/r/20250227-tunnels-v1-0-33df5c30aa04@bootlin.com

---
Bastien Curutchet (eBPF Foundation) (10):
      selftests/bpf: test_tunnel: Add generic_attach* helpers
      selftests/bpf: test_tunnel: Add ping helpers
      selftests/bpf: test_tunnel: Move gre tunnel test to test_progs
      selftests/bpf: test_tunnel: Move ip6gre tunnel test to test_progs
      selftests/bpf: test_tunnel: Move erspan tunnel tests to test_progs
      selftests/bpf: test_tunnel: Move ip6erspan tunnel test to test_progs
      selftests/bpf: test_tunnel: Move geneve tunnel test to test_progs
      selftests/bpf: test_tunnel: Move ip6geneve tunnel test to test_progs
      selftests/bpf: test_tunnel: Move ip6tnl tunnel tests to test_progs
      selftests/bpf: test_tunnel: Remove test_tunnel.sh

 tools/testing/selftests/bpf/Makefile               |   1 -
 .../testing/selftests/bpf/prog_tests/test_tunnel.c | 633 ++++++++++++++++----
 tools/testing/selftests/bpf/test_tunnel.sh         | 645 ---------------------
 3 files changed, 530 insertions(+), 749 deletions(-)
---
base-commit: 97b4501198b918f1d0adeb8205004d64f780e472
change-id: 20250131-tunnels-59b641ea3f10

Best regards,
-- 
Bastien Curutchet (eBPF Foundation) <bastien.curutchet@bootlin.com>



