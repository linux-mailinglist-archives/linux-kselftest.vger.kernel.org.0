Return-Path: <linux-kselftest+bounces-17593-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53F4B973A52
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Sep 2024 16:45:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2E7A1C24BAB
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Sep 2024 14:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D2CA1A00CF;
	Tue, 10 Sep 2024 14:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lOe/CVQH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D5F719FA93;
	Tue, 10 Sep 2024 14:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725979441; cv=none; b=Qg5w1h1bUlEwqWKNlGFCRtn6H/WirFNHl+a1d8n1SbdQ6gCqkC7wz1yFdM5SQ8QfqIiKCFTfMO434WE1wbsB+51JB2sJTYh45gfz4zKbXaUqXUReifs/Yh02SdiPITVYE9K5UWuTXn3FHoUz97m6ARVVfUYVJevqIhIOhsy+EFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725979441; c=relaxed/simple;
	bh=PcylA1+94LG9KARyIPuGccijQnN2vj003tX21Zw9Tbo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VPe0DbDq25cSRCBkmF7DIbTeEJe81l2jrFIA9qZWj+tpn1IDQ1lm+wX0BnhegCUuCZ/kDSEzjsHNr24OJt8NRFxWmVVGWdus1+fNzRNV9lVj631DEEQbqGLuMZxmwTaW9FgOueG4XLv4Q0vvfCD5L31Rei+UcKrQBNqPhe0zVWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lOe/CVQH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39E6EC4CEC4;
	Tue, 10 Sep 2024 14:43:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725979440;
	bh=PcylA1+94LG9KARyIPuGccijQnN2vj003tX21Zw9Tbo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=lOe/CVQHP+un+q+BINAwM4P5krDbalcG0y04Hm1hFLFHKN6GoXHy2/6onoOBiKHe9
	 ouJZ5UWBDk6mpkKa3QSzC6FgveU/I2c1DERinKyaZOUbVIjM8jwLAGxQUAQih/U0/P
	 /8VSs8pwli+Dm+VOP1nLJULx3rqxe3FZ4jG/2WQJKfNYnXLI1DVQfde3yg+x6SrFzI
	 08uwDp9LA59pQhYMUqhZl5B3xJXsNJ0IeXRTrlygUleGP030pAqErTukaS/pJfMfIe
	 LQ2upPEh4+cTOEe9ivEUe6vi6PVjhLtZEKPFI+ONdJbYCcHgGNwbKXOQI9s5RhKhKs
	 AtoyRNv3hsw0A==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Tue, 10 Sep 2024 23:43:41 +0900
Subject: [PATCH HID v2 05/11] selftests/hid: add dependency on hid_common.h
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240910-hid-bpf-hid-generic-v2-5-083dfc189e97@kernel.org>
References: <20240910-hid-bpf-hid-generic-v2-0-083dfc189e97@kernel.org>
In-Reply-To: <20240910-hid-bpf-hid-generic-v2-0-083dfc189e97@kernel.org>
To: Jiri Kosina <jikos@kernel.org>, 
 Peter Hutterer <peter.hutterer@who-t.net>, Vicki Pfau <vi@endrift.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
 Benjamin Tissoires <bentiss@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1725979428; l=854;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=PcylA1+94LG9KARyIPuGccijQnN2vj003tX21Zw9Tbo=;
 b=tpMw5MpnEKcNrunsr9z9pW2Db9YDiTxivD3VnNkIADJv6IoDbXWXHMgu+Bb/uG073eo4skWMK
 eVswxdpd6ZaBwrihlr1d2LQ2kddOvMnB1Hf6b2tlQC3CKNuSu0xNtx3
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

Allows to recompile the C tests when that file changes

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>

---

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


