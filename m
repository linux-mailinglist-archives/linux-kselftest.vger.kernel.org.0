Return-Path: <linux-kselftest+bounces-38626-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 85B30B1F3B6
	for <lists+linux-kselftest@lfdr.de>; Sat,  9 Aug 2025 11:26:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B53818C2FE4
	for <lists+linux-kselftest@lfdr.de>; Sat,  9 Aug 2025 09:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D05827F013;
	Sat,  9 Aug 2025 09:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Jq6ctYQu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A38CE23E25B
	for <linux-kselftest@vger.kernel.org>; Sat,  9 Aug 2025 09:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754731576; cv=none; b=ZQqvAf+b6T0Avlqnt+6x7yirAaOtQpw7TnkXLtWRBNJpzQvJX3a7bP5clEUsAzov1R1HqqjXcvERV/TKBeRadxx+03Vi2mz6FwGrvFfcp7UMS0mliUked+bQ3mY7952IFo85W9PG4mNE8q5yvYCFuilwCWo2w1GGiyb/oDm+TB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754731576; c=relaxed/simple;
	bh=JI7UxsnlFe4V69bsEG+B+RaGNll1vaMtUV/O2Isv0WU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RCD2ARISWjby1175t9H/zF53h2s6xxX/87NldEHH4COeumt5lWpVyq5+1qwiNBoyxoHty8qBq1s4UUQIux7yjt4a6/B2uhNf09rYI6sNHNBwFVLr+vSoY1WfLjJ6MTovDF3CbW9xy45jDHrBnJSlBEmVls0zPw5/oaIpRTZu5Qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--wakel.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Jq6ctYQu; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wakel.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2424aaa9840so29945765ad.1
        for <linux-kselftest@vger.kernel.org>; Sat, 09 Aug 2025 02:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754731574; x=1755336374; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=taB2S1kc21QQVal7yCU/KFHfBisPj+YfeRw4O/7Vlq8=;
        b=Jq6ctYQunWcwzpcMvgVe9Zu8eioRElJneCISA1k/RHM2nff+UBINat7scoqCtLsvFN
         vOxr10+VtGQN7rmL1NoFwUcf9R2oOgNFt/mqm+ABcDrfggJvIQUmIcCE7vVkP8jUx8ZE
         C8DTpAxLNI2fHuXm7i/n4trXjO90rTgxZ7xAUrUE1m01Bf/eA9fUzt2HjzxVkXCabv+S
         JF9AupFxWLUGiKfcZuI0u6kLHjwrsSJzLsqLs85D1Qm/iSYARQFJMNZNBOxvZYRZ3mTW
         304E9udBeZPyugX8f00PY5aPO7/+opLPrQbpbZsaDceWiOPwwcWPPIWvm5eXP/MuR2cp
         JmRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754731574; x=1755336374;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=taB2S1kc21QQVal7yCU/KFHfBisPj+YfeRw4O/7Vlq8=;
        b=QzHoWiNgFopsuvd/mEWtYt7cedHR6AvsIZAo9enub9aCeYeJcf31aSFzZIxoJtqGQJ
         6mdok3nzPPSumWQ4kyEa4KYP1wFi9qIXcDpjrQQd1u0gi3QDTYRyLzF/LXmDPGfWOqp9
         BEOnclLio6BUjWvT71tDaOaFi45DrSE07QzvN11UykOo+35e3z67hxXYA8NyyB1Xku71
         I8qL/XbPt2XK9bKSicxb590khr1DBVdSI1ef0zOiDr+BP6taQCRMUtHcsWuZZNiIqmvt
         rdaDOpgN1igtH7RU2QI8Ko7FzNfPo7aEhlc0rDSAIeSojbXTwVP1CZ1lwn/nBieRbfw/
         ZZGg==
X-Forwarded-Encrypted: i=1; AJvYcCUUvkyS5pYFyETLCsySxJc8nGUIylWxAmLHPLOM1V/40F+ZcfTiygGeRWuIjm+CEiLGpI6VDXlvRSPM9ghAABw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+6K2xLBUWkmPBmw1lQXyMvWw/nQb3T+lS8f/o4KyXId/AIe34
	2RQoY4asmICQH5k50YP7T3tjXLXV18IOBATEPDe/+XDh7om5MGVoh4ZNfcKEnKznfmBa18GFk2k
	pFQ==
X-Google-Smtp-Source: AGHT+IF67/5BRworf1OUrxxyHh4xaXb8ltchvm4vHnd/z6Gz/vfYWC6tHpkj9DFfS+wBIWceaYaK1BsjKg==
X-Received: from ploq6.prod.google.com ([2002:a17:903:1aa6:b0:23e:3914:f342])
 (user=wakel job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:3d07:b0:23f:f065:f2be
 with SMTP id d9443c01a7336-242c2217718mr92708095ad.26.1754731573971; Sat, 09
 Aug 2025 02:26:13 -0700 (PDT)
Date: Sat,  9 Aug 2025 17:26:08 +0800
In-Reply-To: <38bbacc3-625d-4071-889c-a5b4d59ec456@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <38bbacc3-625d-4071-889c-a5b4d59ec456@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1.703.g449372360f-goog
Message-ID: <20250809092608.2457522-1-wakel@google.com>
Subject: [PATCH v2] selftests/binderfs: Add CONFIG_USER_NS dependency
From: Wake Liu <wakel@google.com>
To: shuah@kernel.org
Cc: Wake Liu <wakel@google.com>, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"

The binderfs selftests, specifically binderfs_stress and
binderfs_test_unprivileged, depend on user namespaces to run.

On kernels built without user namespace support (CONFIG_USER_NS=n),
these tests will fail.

Instead of adding a runtime check, indicate the dependency on
CONFIG_USER_NS in the selftest config file. This allows the
test runner to skip the tests if the required config is not enabled.

Signed-off-by: Wake Liu <wakel@google.com>
---
V1 -> V2: Use selftest config to declare dependency instead of a runtime check.
---
 tools/testing/selftests/filesystems/binderfs/config | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/filesystems/binderfs/config b/tools/testing/selftests/filesystems/binderfs/config
index 7b4fc6ee6205..7d5f941d03a8 100644
--- a/tools/testing/selftests/filesystems/binderfs/config
+++ b/tools/testing/selftests/filesystems/binderfs/config
@@ -1,2 +1,3 @@
 CONFIG_ANDROID_BINDERFS=y
 CONFIG_ANDROID_BINDER_IPC=y
+CONFIG_USER_NS=y
\ No newline at end of file
-- 
2.50.1.703.g449372360f-goog


