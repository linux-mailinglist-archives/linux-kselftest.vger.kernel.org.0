Return-Path: <linux-kselftest+bounces-2814-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 26FBF82A352
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Jan 2024 22:34:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DB7D1C22D57
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Jan 2024 21:34:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 242994F5F2;
	Wed, 10 Jan 2024 21:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="eISlyelm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C3B04F881
	for <linux-kselftest@vger.kernel.org>; Wed, 10 Jan 2024 21:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-336dcebcdb9so4471544f8f.1
        for <linux-kselftest@vger.kernel.org>; Wed, 10 Jan 2024 13:34:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1704922457; x=1705527257; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ULJlgsbYbFdx3cKG7esKuUDjzGCjCZ7y1LhDjw4dP0A=;
        b=eISlyelm/bqLfb6AhL8zLj51CBIuxKZ9rfdDrVZzuRe4l/CXHePYiSpGDj+MoNKjBQ
         mASKJsKalWq2Cj36U0MnUiF8W2/mZZu+VDxE0p2FASb7TmWRi+xi0LITuBUT41N1nB5F
         lhG5Ubi8GOLOUJ4WvEd19YtTdL9MOFclADguEpwD/uzmR9eG/YXGX4zH8GO39oPW1r5R
         D/dvzw158H5wpOQ2wL4HIcxwED6KfRv7/wPCPfAUn1unppVzEo6gqt8KlnCdG6bqQk2Z
         TBpMphxItqV8jc26ZV3zpZJZ7le2yVJDRIkCxtHudhQO4unZWDr+83/W8CMIWd1OP59Q
         PBCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704922457; x=1705527257;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ULJlgsbYbFdx3cKG7esKuUDjzGCjCZ7y1LhDjw4dP0A=;
        b=qlClRVpKdcW8G0I/x4v/v6IHOnHLdx7+Ul34+eJDshmddaDSsM2IGn3gMSJt5jJrlU
         R/F+aXFaWtw0vIHqHNWO3o96JapkYUiYeZbc0XlBFhzTWhqICZAixJwE6Fn+2OHQahvq
         CClHt0KqL/wqqKXa6daUnfgMHeRaMg8YGYHebLHZiLlAmwGggTE9n5wDTq4Vu5xefr1b
         MovUp5tkm/72uqzgs4PK9S5Meq77+zIQTHRMley5VkRu2oK+QavuP3e2Yk1S2B25w2R9
         2HwOT/Ka7dMpXMm2LWNeUrHKD7UB4AcZ4Ug1mziWLtDk82Exhrdr1cD2nvxuiP7/1QRa
         oWbw==
X-Gm-Message-State: AOJu0YwISyGKqZiQQnGtfBx9zGqA824Y53om81nMx0QTb/SKyPnKScqI
	ut2KORsgJxJxHb65yKvIC7R2CHtcxLI9
X-Google-Smtp-Source: AGHT+IGHWhbaDD4IwqxDfw9jHTHkuUKjQBNNUmn/8eVs+uq7aRefvD7j/ILYF+UvNVbHn3mv4iVq8A==
X-Received: by 2002:adf:f64f:0:b0:336:c434:5c20 with SMTP id x15-20020adff64f000000b00336c4345c20mr25026wrp.149.1704922457598;
        Wed, 10 Jan 2024 13:34:17 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id j17-20020adfea51000000b0033660f75d08sm5686611wrn.116.2024.01.10.13.34.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jan 2024 13:34:16 -0800 (PST)
From: Dmitry Safonov <dima@arista.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>
Cc: Dmitry Safonov <dima@arista.com>,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel test robot <lkp@intel.com>,
	Dmitry Safonov <0x7f454c46@gmail.com>
Subject: [PATCH] selftests/net/tcp-ao: Use LDLIBS instead of LDFLAGS
Date: Wed, 10 Jan 2024 21:34:10 +0000
Message-ID: <20240110-tcp_ao-selftests-makefile-v1-1-aa07d043f052@arista.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.13-dev-b6b4b
X-Developer-Signature: v=1; a=ed25519-sha256; t=1704922450; l=2675; i=dima@arista.com; s=20231212; h=from:subject:message-id; bh=jOEuqyTW483yTy2cXCaxWhi99+o9vEjXDhzO6CQSOWA=; b=fC9CsSMSOCG1M+izUI7BZ21j+Sjv1Pv5AgqclfGnYKUnkC+G4GIygOQfa85B570ArTNpDdeOe avefNzHNYi9DgxCtqYgoAHI9MmxtdzMXB4Hd9iy6lHxZ+QElE3iTFk7
X-Developer-Key: i=dima@arista.com; a=ed25519; pk=hXINUhX25b0D/zWBKvd6zkvH7W2rcwh/CH6cjEa3OTk=
Content-Transfer-Encoding: 8bit

The rules to link selftests are:

> $(OUTPUT)/%_ipv4: %.c
> 	$(LINK.c) $^ $(LDLIBS) -o $@
>
> $(OUTPUT)/%_ipv6: %.c
> 	$(LINK.c) -DIPV6_TEST $^ $(LDLIBS) -o $@

The intel test robot uses only selftest's Makefile, not the top linux
Makefile:

> make W=1 O=/tmp/kselftest -C tools/testing/selftests

So, $(LINK.c) is determined by environment, rather than by kernel
Makefiles. On my machine (as well as other people that ran tcp-ao
selftests) GNU/Make implicit definition does use $(LDFLAGS):

> [dima@Mindolluin ~]$ make -p -f/dev/null | grep '^LINK.c\>'
> make: *** No targets.  Stop.
> LINK.c = $(CC) $(CFLAGS) $(CPPFLAGS) $(LDFLAGS) $(TARGET_ARCH)

But, according to build robot report, it's not the case for them.
While I could just avoid using pre-defined $(LINK.c), it's also used by
selftests/lib.mk by default.

Anyways, according to GNU/Make documentation [1], I should have used
$(LDLIBS) instead of $(LDFLAGS) in the first place, so let's just do it:

> LDFLAGS
>     Extra flags to give to compilers when they are supposed to invoke
>     the linker, ‘ld’, such as -L. Libraries (-lfoo) should be added
>     to the LDLIBS variable instead.
> LDLIBS
>     Library flags or names given to compilers when they are supposed
>     to invoke the linker, ‘ld’. LOADLIBES is a deprecated (but still
>     supported) alternative to LDLIBS. Non-library linker flags, such
>     as -L, should go in the LDFLAGS variable.

[1]: https://www.gnu.org/software/make/manual/html_node/Implicit-Variables.html

Fixes: cfbab37b3da0 ("selftests/net: Add TCP-AO library")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202401011151.veyYTJzq-lkp@intel.com/
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 tools/testing/selftests/net/tcp_ao/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/tcp_ao/Makefile b/tools/testing/selftests/net/tcp_ao/Makefile
index 8e60bae67aa9..522d991e310e 100644
--- a/tools/testing/selftests/net/tcp_ao/Makefile
+++ b/tools/testing/selftests/net/tcp_ao/Makefile
@@ -52,5 +52,5 @@ $(OUTPUT)/%_ipv6: %.c
 
 $(OUTPUT)/icmps-accept_ipv4: CFLAGS+= -DTEST_ICMPS_ACCEPT
 $(OUTPUT)/icmps-accept_ipv6: CFLAGS+= -DTEST_ICMPS_ACCEPT
-$(OUTPUT)/bench-lookups_ipv4: LDFLAGS+= -lm
-$(OUTPUT)/bench-lookups_ipv6: LDFLAGS+= -lm
+$(OUTPUT)/bench-lookups_ipv4: LDLIBS+= -lm
+$(OUTPUT)/bench-lookups_ipv6: LDLIBS+= -lm

---
base-commit: 8cb47d7cd090a690c1785385b2f3d407d4a53ad0
change-id: 20240110-tcp_ao-selftests-makefile-3dafb1e96df8

Best regards,
-- 
Dmitry Safonov <dima@arista.com>


