Return-Path: <linux-kselftest+bounces-24166-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EBC56A0839E
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Jan 2025 00:42:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10E8B3A7CAE
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Jan 2025 23:42:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B5162063CF;
	Thu,  9 Jan 2025 23:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="cv1I0l/6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Q6432d7a"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE32618C00B;
	Thu,  9 Jan 2025 23:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736466168; cv=none; b=GJie1n8xlrZLXACtjJAm+wFLhM4VJQqcaMbmQCuFrQwmaqp3MN6JCxDYC3VXMI1O6BbYcD0RjK/+6BSBQi44zktWb7LvYZ7UJtXYkT8LEWbRwW5lxF6Hb8+lcGcMvGEX/gklJq8NnNQKIhyFUjxgrkRP/YZV4Mhk6Fi5iJStNW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736466168; c=relaxed/simple;
	bh=8PLDozhomkyuke4vvgLU0O26lPQt3JPxUiiRnkWIz3Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SqaYVdtQkJ86/umXoEVW6zwaqcDqefivCPvWBAEVh/kEOvfjn5cl+3WVSN5EHNQQ1PO9+avkmLchy2JuEyYnoq1OD0M0xKSo3wp05N3BKh36DbUb0WPWpvYdQbEMzWTE/wsT8hvYCcEeyqK4iDGgAecOOViv2d5CmGR+bb8N4iI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=cv1I0l/6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Q6432d7a; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id ABB171380285;
	Thu,  9 Jan 2025 18:42:45 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Thu, 09 Jan 2025 18:42:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm1; t=1736466165; x=1736552565; bh=bT8qtCPvpDtiIG8OFwtM4
	I8IhIxG5AZwEqb6EFkP6r8=; b=cv1I0l/6zfBkzrDZ7l25dJPsVqXuI5E73vf0h
	xWfxRDMAhmdkKzir2H847gNx1/+AUlvYUGEvDfPaNZilVJHmps0tvadUY3ob2Re9
	6NkgQhelSCe0H0cnRVMedE70rNIRZUZUnwYZQY6o6CefzH3YwunUA/3mrP//y5GH
	gWbJ6+mkrQ83NAo2jo7rSppJFT3YZbQhLC8Z3DRN9mSFma3uv3bKqVbngNqFk+my
	CxADGH7vKKuCiiXzeuk8RDpiRed2OJ03uwVJd7nQK7jtFB5X1SpQqvqlytad2qWj
	ZurnNtUN4iwlG6NqZf2XOfXT7Uu5JU/jChIBVfGKkfGyy/PNQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1736466165; x=1736552565; bh=bT8qtCPvpDtiIG8OFwtM4I8IhIxG5AZwEqb
	6EFkP6r8=; b=Q6432d7aWqW3Rretfnn1dZOXeJuH8l5O8g+oD6cZL3leaUiYkEw
	WW7WzIs+BW98n5GXBxz03MN3biVcIsUsowiE1Yz3aptagTaWg6GTJGKNKWO18D4E
	IC4YuaDlYP6tfImSV4Eq/sE18sxdZVB8MwgVy/Wrg4b+KiVYQXDz3HCORQfePAC3
	Y7I5mC1xAdvFayLIjmQCV01fM3jxSIy3MzpQw21E9OfOfrPue2EZVjLVzMmzF8SX
	7sDjqIz4/XiYnAW9iJR+U4KC/+98dOtEabQWm8CsJvJvj7o2ab9gcq91JkANNi4L
	l30HS/GZj9Afjcz68s9xsAnxMBgnmjf0gFg==
X-ME-Sender: <xms:9V6AZ504SD8Pc-MSBBn5pl4HlxSEOt07VlnFe-aj6oI3bALPX93Aaw>
    <xme:9V6AZwFFT3MeWonJPFOAcmfkGg7jQFbRPCs9mgZAW4ScB2TAXtV92z_Ia2srq2uMZ
    t3gec0udJ-8KX-HJg>
X-ME-Received: <xmr:9V6AZ56fC8MoLZxljfJOhBxdGMrWNN9Xw_BwBeJjUskA6nM1WIL_Frc-3W4nCzhfx0nja6o-NvkKOPRyjhwfDO4qgEzT6ww9oJ8XThLzVZvF7OBLw-xj>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudegjedgudduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdlje
    dtmdenucfjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeffrghn
    ihgvlhcuighuuceougiguhesugiguhhuuhdrgiihiieqnecuggftrfgrthhtvghrnhepvd
    eggfetgfelhefhueefkeduvdfguedvhfegleejudduffffgfetueduieeikeejnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepugiguhesugiguh
    huuhdrgiihiidpnhgspghrtghpthhtohepudejpdhmohguvgepshhmthhpohhuthdprhgt
    phhtthhopegvugguhiiikeejsehgmhgrihhlrdgtohhmpdhrtghpthhtoheprghnughrih
    hisehkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghnihgvlhesihhoghgvrghrsgho
    gidrnhgvthdprhgtphhtthhopehshhhurghhsehkvghrnhgvlhdrohhrghdprhgtphhtth
    hopegrshhtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehmhihkohhlrghlsehfsgdr
    tghomhdprhgtphhtthhopehmrghrthhinhdrlhgruheslhhinhhugidruggvvhdprhgtph
    htthhopehsohhngheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohephihonhhghhhonhhg
    rdhsohhngheslhhinhhugidruggvvh
X-ME-Proxy: <xmx:9V6AZ21W5uuYNrtwwsrDUpGS4MYWEom8XMSgoPVigLsLzc2ylXJfyg>
    <xmx:9V6AZ8F-eNEL7XR1CJ1eCsvBJdqnjCtIxA7JCqHGT9HgfaiBWr4BcQ>
    <xmx:9V6AZ3_6ASvyK7GuG4XAyMnZ9FIPGenn5ajSm3R5P-c9Af3N8JZdpQ>
    <xmx:9V6AZ5lTl5gbDaQYDx5cetRvDn2jRHEFrM0j-MPvyD3P-GdHNXfviw>
    <xmx:9V6AZxJm-1Y5P0xgTmGfHGdj9ePwl4f63rHrZ5R6dm1oRA3GwriDhQLH>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 Jan 2025 18:42:43 -0500 (EST)
From: Daniel Xu <dxu@dxuuu.xyz>
To: eddyz87@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	shuah@kernel.org,
	ast@kernel.org
Cc: mykolal@fb.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next] bpf: veristat: Document verifier log dumping capability
Date: Thu,  9 Jan 2025 16:42:29 -0700
Message-ID: <d57bbcca81e06ae8dcdadaedb99a48dced67e422.1736466129.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

`-l2 -v` is a useful combination of flags to dump the entire
verification log. This is helpful when making changes to the verifier,
as you can see what it thinks program one instruction at a time.

This was more or less a hidden feature before. Document it so others can
discover it.

Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
---
 tools/testing/selftests/bpf/veristat.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/veristat.c b/tools/testing/selftests/bpf/veristat.c
index 974c808f9321..7d0a9cb753e3 100644
--- a/tools/testing/selftests/bpf/veristat.c
+++ b/tools/testing/selftests/bpf/veristat.c
@@ -216,7 +216,8 @@ const char argp_program_doc[] =
 "\n"
 "USAGE: veristat <obj-file> [<obj-file>...]\n"
 "   OR: veristat -C <baseline.csv> <comparison.csv>\n"
-"   OR: veristat -R <results.csv>\n";
+"   OR: veristat -R <results.csv>\n"
+"   OR: veristat -v -l2 <to_analyze.bpf.o>\n";
 
 enum {
 	OPT_LOG_FIXED = 1000,
@@ -228,7 +229,7 @@ static const struct argp_option opts[] = {
 	{ "version", 'V', NULL, 0, "Print version" },
 	{ "verbose", 'v', NULL, 0, "Verbose mode" },
 	{ "debug", 'd', NULL, 0, "Debug mode (turns on libbpf debug logging)" },
-	{ "log-level", 'l', "LEVEL", 0, "Verifier log level (default 0 for normal mode, 1 for verbose mode)" },
+	{ "log-level", 'l', "LEVEL", 0, "Verifier log level (default 0 for normal mode, 1 for verbose mode, 2 for full verification log)" },
 	{ "log-fixed", OPT_LOG_FIXED, NULL, 0, "Disable verifier log rotation" },
 	{ "log-size", OPT_LOG_SIZE, "BYTES", 0, "Customize verifier log size (default to 16MB)" },
 	{ "top-n", 'n', "N", 0, "Emit only up to first N results." },
-- 
2.47.1


