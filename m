Return-Path: <linux-kselftest+bounces-18748-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAE5098C024
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Oct 2024 16:34:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 54D4BB292ED
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Oct 2024 14:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFC0A1C9DFF;
	Tue,  1 Oct 2024 14:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gEKNRWdx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 930E61C9DF7;
	Tue,  1 Oct 2024 14:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727793044; cv=none; b=LvSxVAqdz6vDDoCsQzJDFhpoFjrtcnCFLKmhUNTt6My4pEwl0SkN5OsRGHzCY/7W+V1Yqp1r/bdqxuzWBxm8fL/KNVBaDbFP9dvgkfngeIo85LHNTlhiLpoOVMWFp60Voyb0BM6sHQCD1ptsRi2svWDF63NlG07PQZpvUze2wpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727793044; c=relaxed/simple;
	bh=wppJWxa4PFXTMDnMvcUDcgs5QXEfPQihMd/UMsAYQnM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=K0vS0AlUoFz+FeNZ9dGpFq8J2RiNlI/Qb339geDvBrwZfVAmkOm3gr4qT/1PHJ+SEho8ZgvS3KvYy+dFD12GQaQwU4QKt51vATimvAqy+sxTbsUS+MI2OF+P8vWkPQNSKfS+xZtK+a3whwS0z2Qmg2HfrfRwQTCOk31P78opX8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gEKNRWdx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84FB7C4CECD;
	Tue,  1 Oct 2024 14:30:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727793044;
	bh=wppJWxa4PFXTMDnMvcUDcgs5QXEfPQihMd/UMsAYQnM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=gEKNRWdxYzYHRy857+So3PX971QEacnV+kalQirmVQtwmB/GgEz1+jZSrfgr2Q0cc
	 5vw85v0n+0DBl53vv/LCubXGZknzKn/DemtEafSMngj0lXBEAuOS4iafi+35Rw/bgC
	 NFZn1P3ITtOuiKhqr06wyJNKxzMUn7EsnEbUKdMVqhxX1EsVS9e1QHLlvNRdp+VD+L
	 COdQgzVzQ6OvtZOdTdXuZvdRbcKnoBbvVSVUFNPIlIxCDmi0sRHmQbKuLvAfRO3bjZ
	 N9S1EJtwHf/n/3ezySkPC+LZYh1vw3gYkJKAGnWCZlPtiZHVC1Obe7NQXhMJwbGrrR
	 dsS+MoZBthOCw==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Tue, 01 Oct 2024 16:30:09 +0200
Subject: [PATCH HID v3 5/9] selftests/hid: add dependency on hid_common.h
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241001-hid-bpf-hid-generic-v3-5-2ef1019468df@kernel.org>
References: <20241001-hid-bpf-hid-generic-v3-0-2ef1019468df@kernel.org>
In-Reply-To: <20241001-hid-bpf-hid-generic-v3-0-2ef1019468df@kernel.org>
To: Jiri Kosina <jikos@kernel.org>, 
 Peter Hutterer <peter.hutterer@who-t.net>, Vicki Pfau <vi@endrift.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
 Benjamin Tissoires <bentiss@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727793031; l=930;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=wppJWxa4PFXTMDnMvcUDcgs5QXEfPQihMd/UMsAYQnM=;
 b=rjXl7WAjtkJLDaKCTw/ol1V+kbo32YqLl98rzMd6rvDUWssLGFbCu3LUW9QPdM7HamkIJHVF8
 UPp/jXMQgYwAbB4tUPZU6YjOKDz9ygARimiGvHfBbWcHRaIUAsF44fb
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

Allows to recompile the C tests when that file changes

Reviewed-by: Peter Hutterer <peter.hutterer@who-t.net>
Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>

---

no changes in v3

no changes in v2
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


