Return-Path: <linux-kselftest+bounces-10549-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D4D28CB839
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 May 2024 03:24:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF0DB1C20C00
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 May 2024 01:24:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1D7F15B108;
	Wed, 22 May 2024 01:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wuX8x+Cj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D54A15B0ED
	for <linux-kselftest@vger.kernel.org>; Wed, 22 May 2024 01:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716339752; cv=none; b=ZZDaF5N1JS7lssgQPchUDrtyapDOyVKn/YAAWbV21wpzxaS1hTpU/CGAdDs7+PNgfjNhap7y2oUueV5qi5GNWgnitu/3+EFK87OkhD8mDGdKrchUZrgK/oivM40DfwV1INNUx39S8esK11amznbsFdQYFDoFpxCChRwGn9GGg/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716339752; c=relaxed/simple;
	bh=wwHClzW3HS3k2rxcD4xGD4N6MPHNqeSCS7dmFIcppCg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FKl8GZGPn0hPcvj49MVIULuFnvzAd+lEC419aee3Soa6XVd1ZyQckkNV9u/AYGZLeou7J9fLkIJ9nkd5ct9xVCNRhe8zDp0wXU0I4HiwYu3Wfjf6FU0WbihbzyuMZT0GSzlMYBJGUdZC1x3VTfmToOFindRWJCkXV4E6eD+sjt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wuX8x+Cj; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2b4330e5119so11280233a91.3
        for <linux-kselftest@vger.kernel.org>; Tue, 21 May 2024 18:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716339751; x=1716944551; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=a/alAv/4/ktSZrlS0Fd5uW+NL7frJ+JSUceLln6ipw0=;
        b=wuX8x+CjchNTr9X9opshIhqVft6MqCMBCtr5VA38Gljf19w/RGAGdV7FcG84sMRt0b
         otwPYBEprSfBW7bSogSTU4p6z4TcjIWHI6oCg7OGtS2FiMEECiknKtEOd2wtvhrO3ZE0
         5i3oRS1BoD4AvPbSZ7lURZ3MlYaExtWsSOKgd1Jpa9mgj2/IApdqwFSg28PqgLwY+LrY
         JOHdv3fEqlRGcNAqsTtWlvyr0HKsapg8DggCdrFhKIE9IgRNvTOhn4xb1ih/c9l6vGKw
         uPGKwrYKrBY9Um/ntaXZ+W0Dw7ZqOR/IJfpyV1Jf9IzhxXFfU8rbli7nRikY//HXoIUe
         C3fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716339751; x=1716944551;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a/alAv/4/ktSZrlS0Fd5uW+NL7frJ+JSUceLln6ipw0=;
        b=TQZfCnK/RpCFrcPOTHFjL2cmYyBr7OO/NI9nAPFGFo2WITQisrM/g3fSCFNAhm55jA
         ylwvP/lhe/Z4kNuwnPUp9XsNTY4la3T+raDdu8L6SPKquXrlsy3ev8J7ERRl77tFaIf1
         GFC3T24m3Hp8m2DbKPtWGaZ7TictuRDCea00XYYl53qX+vR4WbGq9cw9FVS1To0JJOyH
         8ciH8CnVR/H/v+n+7PZbzDMEbIR+bMCkkMvfnOUHeMf0qQzvlsnfBjJrpFqxRXR1mjzI
         z0d1GqyL8WxvfBL6WEcEqt6C5HvGwfh+Wk3ABI5Cari6BHcw1gXd+kErCkVVUCoYigZ0
         eKrg==
X-Forwarded-Encrypted: i=1; AJvYcCUWDFm0ax7a4tB7nt3HhHRnYWUWV1/KQlhcvncZjD9Wvxsu1+l1/e4tdru+EyVR4cdEUgDTvcx/m/q6O7rsSw0w3dd1StSvIMfQ2nSQCpAZ
X-Gm-Message-State: AOJu0YzyXT8OJkPNoWxrU+GHfy0/zrLHmUP2WnrfGMNAws6P1paL6B1M
	MAnx+Nt3Tfr98vuoRt+L4qhlVdd57r1zODSt/Ns8qSmjr7VIAf/llBauYRyqGOUDoCBj0TIaOXI
	Iyw==
X-Google-Smtp-Source: AGHT+IFKRYUemB9bQi8KmbkmxRhMBRRK8qY6EnK/nEzjCpEKdmTU9GKLzNY+XB779KpN4GXjVpxm8X7d6Ns=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a17:90b:3008:b0:2b2:804e:fbb8 with SMTP id
 98e67ed59e1d1-2bd9f5d4c18mr2338a91.5.1716339750670; Tue, 21 May 2024 18:02:30
 -0700 (PDT)
Date: Wed, 22 May 2024 00:57:48 +0000
In-Reply-To: <20240522005913.3540131-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240522005913.3540131-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Message-ID: <20240522005913.3540131-63-edliaw@google.com>
Subject: [PATCH v5 62/68] selftests/tmpfs: Drop duplicate -D_GNU_SOURCE
From: Edward Liaw <edliaw@google.com>
To: shuah@kernel.org, "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>, Christian Brauner <brauner@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@android.com, Edward Liaw <edliaw@google.com>, 
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org, 
	linux-riscv@lists.infradead.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

-D_GNU_SOURCE can be de-duplicated here, as it is added by lib.mk.

Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/tmpfs/Makefile | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/tmpfs/Makefile b/tools/testing/selftests/tmpfs/Makefile
index aa11ccc92e5b..3be931e1193f 100644
--- a/tools/testing/selftests/tmpfs/Makefile
+++ b/tools/testing/selftests/tmpfs/Makefile
@@ -1,6 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0-only
 CFLAGS += -Wall -O2
-CFLAGS += -D_GNU_SOURCE
 
 TEST_GEN_PROGS :=
 TEST_GEN_PROGS += bug-link-o-tmpfile
-- 
2.45.1.288.g0e0cd299f1-goog


