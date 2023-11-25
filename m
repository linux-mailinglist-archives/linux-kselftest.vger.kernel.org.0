Return-Path: <linux-kselftest+bounces-604-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09EBA7F895A
	for <lists+linux-kselftest@lfdr.de>; Sat, 25 Nov 2023 09:43:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 54167B21303
	for <lists+linux-kselftest@lfdr.de>; Sat, 25 Nov 2023 08:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B863063C7;
	Sat, 25 Nov 2023 08:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="pRBffyQr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6C2FA9
	for <linux-kselftest@vger.kernel.org>; Sat, 25 Nov 2023 00:43:11 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1ce3084c2d1so21230865ad.3
        for <linux-kselftest@vger.kernel.org>; Sat, 25 Nov 2023 00:43:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1700901791; x=1701506591; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NPPxIVkRMPlLUxZMsEygBEBjgDTLIaOmfxI6JWnloIc=;
        b=pRBffyQrCwf4oKhvTAqwDsql81Gi1ZUG1TrWWb6Th9wByymCvZ4X4bzpp/9PDyFHGb
         JmdQhjCkn7EtugvsHui0i2ssEtCDYTd8z1fElK0aM/ar8YXaqvCuXiGIlud47tTtebc/
         E3CA4FM2z4dZmUjPX8X1wtv+VyAfON7Zm3JDIQZEoQ3JQf8+S7RgUq9/BMI8BTUB0oRj
         kUfC7HIugLwA/ZSj+ifnjYyeBQxHnKX6pMeLK394C9+iS1BFK/W3kafNRnEBwK4ThjeY
         /ofKbPaRIuRdqkfj24IYDyXAbJkKu08h6EhVO27TDEzpTNj9N6hTphqY893bNlUtGjMB
         /WEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700901791; x=1701506591;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NPPxIVkRMPlLUxZMsEygBEBjgDTLIaOmfxI6JWnloIc=;
        b=U7bfCtB+5IWkCI1uoPeLukGFFJ6qyQVw8SfVm98G1Yjy/UqmGSjd//Bv029RyfEg2B
         TKNiD2bM+h5fWjqt4NZJECVw3AM4qgO5DvoT0tTgweckdr1DmtZLHgm1IZKlTsWrQZWl
         4CUQ0ih36zktfNofFlBtf7RZujsTpr23TTYcbnddFMwCQvwdUU++sdlsVLzIJwYsxQZw
         nAOkNS4OMntSp/2oDZs+x7SCIQvwU4S8rujBAc3G+8MmL1jGEqWVEk5qsVR+Qhi/qfhn
         d+WICJS6F+pwwwL4Ewd2jC4ztr/N8gH7BQzWHcHQRH68GQKVrPZ0S9BgbNZWR1d1alhU
         VezA==
X-Gm-Message-State: AOJu0Yzwx3KHiaT+u0ECDpdx8XVnteFhp1AIrex9zmlrgHZErEX6A1P5
	2aJ9XUqhd1W3ONmhjuaLExRxmg==
X-Google-Smtp-Source: AGHT+IEVVpVFIcUVQouFS95iWEttXau5YwBJgu8W9QjT7uKgsVIqZzxbtoETCuWtg/ws4lKe1JRV9g==
X-Received: by 2002:a17:902:f68d:b0:1cf:6704:4340 with SMTP id l13-20020a170902f68d00b001cf67044340mr6468913plg.22.1700901791152;
        Sat, 25 Nov 2023 00:43:11 -0800 (PST)
Received: from localhost ([157.82.205.15])
        by smtp.gmail.com with UTF8SMTPSA id h12-20020a170902748c00b001c9d011581dsm4432500pll.164.2023.11.25.00.43.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Nov 2023 00:43:10 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: Andrii Nakryiko <andrii@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Nick Terrell <terrelln@fb.com>,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH bpf-next v5 1/3] selftests/bpf: Choose pkg-config for the target
Date: Sat, 25 Nov 2023 17:42:50 +0900
Message-ID: <20231125084253.85025-2-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231125084253.85025-1-akihiko.odaki@daynix.com>
References: <20231125084253.85025-1-akihiko.odaki@daynix.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pkg-config is used to build sign-file executable. It should use the
library for the target instead of the host as it is called during tests.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 tools/testing/selftests/bpf/Makefile | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 9c27b67bc7b1..94825ef813d5 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -18,7 +18,7 @@ else
 GENDIR := $(abspath ../../../../include/generated)
 endif
 GENHDR := $(GENDIR)/autoconf.h
-HOSTPKG_CONFIG := pkg-config
+PKG_CONFIG ?= $(CROSS_COMPILE)pkg-config
 
 ifneq ($(wildcard $(GENHDR)),)
   GENFLAGS := -DHAVE_GENHDR
@@ -219,9 +219,9 @@ $(OUTPUT)/urandom_read: urandom_read.c urandom_read_aux.c $(OUTPUT)/liburandom_r
 
 $(OUTPUT)/sign-file: ../../../../scripts/sign-file.c
 	$(call msg,SIGN-FILE,,$@)
-	$(Q)$(CC) $(shell $(HOSTPKG_CONFIG) --cflags libcrypto 2> /dev/null) \
+	$(Q)$(CC) $(shell $(PKG_CONFIG) --cflags libcrypto 2> /dev/null) \
 		  $< -o $@ \
-		  $(shell $(HOSTPKG_CONFIG) --libs libcrypto 2> /dev/null || echo -lcrypto)
+		  $(shell $(PKG_CONFIG) --libs libcrypto 2> /dev/null || echo -lcrypto)
 
 $(OUTPUT)/bpf_testmod.ko: $(VMLINUX_BTF) $(RESOLVE_BTFIDS) $(wildcard bpf_testmod/Makefile bpf_testmod/*.[ch])
 	$(call msg,MOD,,$@)
-- 
2.43.0


