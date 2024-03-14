Return-Path: <linux-kselftest+bounces-6337-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC4DE87C550
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Mar 2024 23:44:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87F3C1F21941
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Mar 2024 22:44:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B8C464D;
	Thu, 14 Mar 2024 22:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uv5ZnILg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 586C7D27E;
	Thu, 14 Mar 2024 22:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710456243; cv=none; b=PlBY4euEfMQ8I4VKXrEq1rMtnjXqxFss16SMGtiSMf0lDfntp5UWHL+cB7+Yml7SZUuYN2WsKKcmAdphXcj0M4DvFryoNpuNbB5wKf35379tPFQ+kukLvs+6LCIWFQGhXpCRfzB7mdrKF1pleHlVC6kyNYy/hr/BE8eQfZeZKik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710456243; c=relaxed/simple;
	bh=QvqpKGOSYA7BSdeUsCnKtWmV5OlW1reNtVj8Tc2WIzw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=up4tEfQRFtZw8A5BBbg0m/vImcCmg0fGoo5c4SmhZ73D1iaB0iNuFV/220jn0m29Q//5z6xxonEMCDnKEsfdLf9au9Oyp/gtTjTx5cH86zluJE4kyJOCubpt0/T3rkgLqo7VBqZjTxPCkHbPfsRuB7ebsPoZe4WiqO96KBLNJxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uv5ZnILg; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2d24a727f78so17706941fa.0;
        Thu, 14 Mar 2024 15:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710456239; x=1711061039; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ISa+awojIIIvyhV6jEcmOsx8uIkeDM0sI+hIucia5Po=;
        b=Uv5ZnILgJB949itKGrs7q3cgrYGp0zv5H7kVjlGrxsIqYnCGoz+cyIyioimawhxgcK
         RgVAvnTa1svx6kH7luwB31Kt/NgAp0WAR0Y9Nonxcveg9R0y1GqtPXZJsc60oH2c9tYc
         A6ei2ln8VTb04knICIBPhT55Y/v4TwGHU9NGuB0AclC9P9V2CyUA8Hr+zabHnFOo3CLf
         cmMnlbbEk3hdsg2n+FR0Yr+Ohtc5QzAUomishJzKoAWLvshhGzGuW0L5g7uKhJo+QT5O
         9guA10bzQJvy9CQmNB3dsxTeX+CufNuEVNkxg1mdZkMx/jkZZmfQ21vTMTNEm909r8MF
         5gyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710456239; x=1711061039;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ISa+awojIIIvyhV6jEcmOsx8uIkeDM0sI+hIucia5Po=;
        b=WrCRAFGmFy+kyvfN9kEX50N5uJDgztT/6PuiUKq/OBR1MQmsfYCxY0HS+vUzDA2WtA
         PaZs3OXgu5IlDEC85fQNdhqyUe/+wpmhKiIaAOOvkFOs+gi/K5mNr7Zsp8FqF4JZKj2Y
         O16bXuCTvd6kyoj5jbVxo90Vx3aTRK+IZnSJM49L2J072iWN+0w4Fgxmr2sRBwK3zSxP
         tfW1QTm3I3NwfyFUXrHWcZyLtUonbaZUOcQGwJ0UoZzvIsvI/zEUgwmtBmE7D4omalf8
         346G6w1010DL8kuRV3m58KqlttywN6I1t9mRc2j+9rwDX5VP3w8JlMKlQrJgZON/LR4J
         9Yew==
X-Forwarded-Encrypted: i=1; AJvYcCVByokcY95NfOMjwi8hxBPKtm0hFSh1nzlf87lWVJ3dRQmHbuGQH8uQwy3lB34HcIgPRow3YVq09Ts3uq/2j2/Qp67WdFStDHFFRqkm7UZvLUjdp95gQbpOvzfeBT44V5pFQOlkjcV1rleGjKYN
X-Gm-Message-State: AOJu0YzFmSu3GE2uGJrSA9WE9VTxpYVzvpdIyMNf0S83kfW1aXVBQrGR
	C7+9dwbcYVdtaYYA7kvL6q7AxoBhv9QWlLY28XEl+zCjByujhw==
X-Google-Smtp-Source: AGHT+IEXWWIpfxd6KpsM9cgZ0hDPWGIK0f8y7B4rBKG9tFq30Ks7c79r6cslIcDcQUlAbJiSoHGfEg==
X-Received: by 2002:a2e:9b99:0:b0:2d3:4c3f:c12d with SMTP id z25-20020a2e9b99000000b002d34c3fc12dmr2257744lji.26.1710456239298;
        Thu, 14 Mar 2024 15:43:59 -0700 (PDT)
Received: from localhost.localdomain ([85.89.127.166])
        by smtp.gmail.com with ESMTPSA id f14-20020a2e6a0e000000b002d0f0f5e395sm284838ljc.47.2024.03.14.15.43.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Mar 2024 15:43:58 -0700 (PDT)
From: Shengyu Li <shengyu.li.evgeny@gmail.com>
To: shuah@kernel.org
Cc: luto@amacapital.net,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	wad@chromium.org,
	Shengyu Li <shengyu.li.evgeny@gmail.com>
Subject: [PATCH] selftests/harness: Prevent infinite loop due to Assert in FIXTURE_TEARDOWN
Date: Fri, 15 Mar 2024 06:43:23 +0800
Message-Id: <20240314224323.23201-1-shengyu.li.evgeny@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch addresses an issue in the selftests/harness where an assertion within FIXTURE_TEARDOWN could trigger an infinite loop. The problem arises because the teardown procedure is meant to execute once, but the presence of failing assertions (ASSERT_EQ(0, 1)) leads to repeated attempts to execute teardown due to the long jump mechanism used by the harness for handling assertions.

To resolve this, the patch ensures that the teardown process runs only once, regardless of assertion outcomes, preventing the infinite loop and allowing tests to fail.

Signed-off-by: Shengyu Li <shengyu.li.evgeny@gmail.com>
---
 tools/testing/selftests/kselftest_harness.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
index 4fd735e48ee7..230d62884885 100644
--- a/tools/testing/selftests/kselftest_harness.h
+++ b/tools/testing/selftests/kselftest_harness.h
@@ -383,6 +383,7 @@
 		FIXTURE_DATA(fixture_name) self; \
 		pid_t child = 1; \
 		int status = 0; \
+		bool jmp = false; \
 		memset(&self, 0, sizeof(FIXTURE_DATA(fixture_name))); \
 		if (setjmp(_metadata->env) == 0) { \
 			/* Use the same _metadata. */ \
@@ -399,8 +400,10 @@
 				_metadata->exit_code = KSFT_FAIL; \
 			} \
 		} \
+		else \
+			jmp = true; \
 		if (child == 0) { \
-			if (_metadata->setup_completed && !_metadata->teardown_parent) \
+			if (_metadata->setup_completed && !_metadata->teardown_parent && !jmp) \
 				fixture_name##_teardown(_metadata, &self, variant->data); \
 			_exit(0); \
 		} \
-- 
2.25.1


