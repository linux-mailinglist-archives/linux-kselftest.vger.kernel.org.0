Return-Path: <linux-kselftest+bounces-16991-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 31DC6968BBE
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Sep 2024 18:15:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D16B41F22E65
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Sep 2024 16:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBFA31AB6E5;
	Mon,  2 Sep 2024 16:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l3R4kCJl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 849C71AB6DB;
	Mon,  2 Sep 2024 16:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725293702; cv=none; b=HejMrDLd/DxBlmtET2OH8x1ukEaRfxAeSnt7fRwpsThKeE/vU3LFY96zhXWFfNZ+nbB+83R4INQ49Tr+QByp535JD8w3oTfL33MTUX8Tb9PNAOYP9Muv4R9BhVxkfFs4YpZ47yPF0D6wN8ROcEI7L1lwCJyNEstB5YXJ3g4o1jY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725293702; c=relaxed/simple;
	bh=SAepiqf5pj0GW3dbl6s8Y9ralJY+FSiywgHt7/u9Iks=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=k9///bxTwNqqdIpjVIuJZx9y/0L20DU12UXTU7V1OI+lYOu628+9zDCcSO2U99g7FOgD4woBTwdggsVLJW2gnd3bBUzC/QHlpmUXGl3ocDE8rl0xKu7mI0uIxdjMaCv2OoxqYg3IAjNy50NUjjMDakpL5Fs5qv+HrWKrQLzqKXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l3R4kCJl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0F51C4CECA;
	Mon,  2 Sep 2024 16:14:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725293702;
	bh=SAepiqf5pj0GW3dbl6s8Y9ralJY+FSiywgHt7/u9Iks=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=l3R4kCJl3Os1hbrFcJKs+xg2yer3z63pKGoM6ElBi+WzoD54GvlavYhwIUKVsPFXY
	 jmZR7D3DXabIHBFvwQU0zjIo2wODMXfysQSlhZxxoAyLE3ZUOp71XaHmlWl6Hle6aU
	 rTQKJubL72xI5ONxHFRVHqf5qNUd6tzWDS79QVG2EDZkIVzpvoYaI1FW77LZV4jIaE
	 fcyf/vaTwD4S4Fa+PK66EBzNuMQCkp0/o+woUYVp7WOmGGnAOpLsIfYvXpCOLY6hOy
	 x33yEilRGP/kiDQFGUPpdLsiq0ogz/xT5vEDaD3B25IcNQVIwIyUKKDmYs0uF2cLqt
	 zCTLrEq3r2kxw==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Tue, 03 Sep 2024 01:14:31 +0900
Subject: [PATCH HID 1/7] selftests/hid: add dependency on hid_common.h
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240903-hid-bpf-hid-generic-v1-1-9511a565b2da@kernel.org>
References: <20240903-hid-bpf-hid-generic-v1-0-9511a565b2da@kernel.org>
In-Reply-To: <20240903-hid-bpf-hid-generic-v1-0-9511a565b2da@kernel.org>
To: Jiri Kosina <jikos@kernel.org>, 
 Peter Hutterer <peter.hutterer@who-t.net>, Vicki Pfau <vi@endrift.com>, 
 Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-input@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
 linux-doc@vger.kernel.org, Benjamin Tissoires <bentiss@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1725293696; l=827;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=SAepiqf5pj0GW3dbl6s8Y9ralJY+FSiywgHt7/u9Iks=;
 b=LgetzPyn8o0P+uKkHDVzEJaYqwFqkaJma4QjIwgWjKuzGybMpZvp8uKwffCRGi/ymKZysNX4y
 rrlztCVuFDtCGkiO/ER8WCoqxtkm8MFCXMXJ/aBVgEGUhqLSUISxS0I
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

Allows to recompile the C tests when that file changes

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
---
 tools/testing/selftests/hid/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/hid/Makefile b/tools/testing/selftests/hid/Makefile
index 72be55ac4bdf..9399fa3f2f9d 100644
--- a/tools/testing/selftests/hid/Makefile
+++ b/tools/testing/selftests/hid/Makefile
@@ -229,7 +229,7 @@ $(BPF_SKELS): %.skel.h: %.bpf.o $(BPFTOOL) | $(OUTPUT)
 	$(Q)$(BPFTOOL) gen object $(<:.o=.linked1.o) $<
 	$(Q)$(BPFTOOL) gen skeleton $(<:.o=.linked1.o) name $(notdir $(<:.bpf.o=)) > $@
 
-$(OUTPUT)/%.o: %.c $(BPF_SKELS)
+$(OUTPUT)/%.o: %.c $(BPF_SKELS) hid_common.h
 	$(call msg,CC,,$@)
 	$(Q)$(CC) $(CFLAGS) -c $(filter %.c,$^) $(LDLIBS) -o $@
 

-- 
2.46.0


