Return-Path: <linux-kselftest+bounces-38453-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CFF1CB1D521
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Aug 2025 11:46:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A22E2189924B
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Aug 2025 09:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68E76277CB9;
	Thu,  7 Aug 2025 09:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FVVuUJo5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF13263F36
	for <linux-kselftest@vger.kernel.org>; Thu,  7 Aug 2025 09:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754559921; cv=none; b=G1Qa87F+yu2CRbUnYL0zxxMTgiOS6wmXoW4lszzbzI8aKg9aidCfy66Ft9z/5TT8APILmbXTpMAeYZMZVgXbjlr8AOivjPlAgDwMr/WAkx/gyXwtKu3RXsrQhvRBKtdiK4SsxSiAedulisERxmLOwYvihXHpdvG6kZRhohQoeec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754559921; c=relaxed/simple;
	bh=9CWqCoQd69akCMvnUCstVkxnK5EnbjHX63MZgi2hMIk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=OM6nZ9aWozpUUNYriEsUXoTpwq3hr/JQb6iEL4pLBlTtp+mabLk8VOmjgThODH8bmwacLQqihHseqZCx/P9E4kqZjbRkrCvALxZ43vIwE816JjXzD4xeTtorO4ELZc8AbLWrYoXxd0wvaTvvYubtLRaYR2FKYhGIxuD3MEWFDug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--wakel.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FVVuUJo5; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wakel.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-31f74a64da9so1038546a91.2
        for <linux-kselftest@vger.kernel.org>; Thu, 07 Aug 2025 02:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754559917; x=1755164717; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HqQFCr0puXBzxV1mM1+sQ3d9n1yvLLDEaN09Eux/FlI=;
        b=FVVuUJo5MVhgnf8wUYdsLSm9Zyq/ItWPTtbnnoc8GnP96kr3/ddACuMxeDKb/aIMeW
         jGBpLuHqlr0Ca3lDFxGVrKugrg94Zt8K2SetT/fYiVdmMEeqXg98vaDabY13tfqVAfsz
         RkosijVk+NjfAfIpYv5spQwzb6AVdBYJCQU63oIMpQH/nLAYrugqEMMbQMvlarF57Jzw
         QoS5WpClz+EzuqCVgxFCiLHTEbpBXYhlulhTPbSKsMpErIbDgKVF2Lp4IjxM7+A0LKEC
         mn33mIzYKnxqAr90VwCe25VYrAS2WFWdAhE3qNoMYrxL9kZtfhySJ04w2cb1AYvRGNvu
         /HVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754559917; x=1755164717;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HqQFCr0puXBzxV1mM1+sQ3d9n1yvLLDEaN09Eux/FlI=;
        b=oxfAopCocF+eCwORtga0RS1Tdobd0pjf3K8s4cjNERMi8RLoyNQBC7Yru21P2AHLrB
         hL3zcUD68ZX3U+8XP+QfKqffkZUn4ICa0td25xMqiuVdODVzY4U93o9NVKSfBt00v23D
         jx4nTmBrXqipkmNHyUcTiV6Mz/xDryTYdcKIZl7mMoq1DLMPoR7s9foohMY9s29h8YGn
         hJP88tBSj92LZ/CswTBqLtpLpDl7ughTfMdeVnCg/l/OV9Vt8DdsFZN98MqXTeStqiEy
         yFZx2+d53Yt2V1AW8XwuiMm1N1MQNDoB4D2Qeh7wU+pnKK2euefdLRoCKKK8ueTnhd6Y
         zs6w==
X-Forwarded-Encrypted: i=1; AJvYcCVK6d4kXZJ5mPme4S7EEoEmh2chBBnQVCPWNP833dvlnAyJZPvjYLjET2S/rkACcsVeEW/fV/ESIX+q6KtT28g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNZ/uFW1TcQfXFWsloQgIFKG4rhdOmkAX9XVMi8TSiTYakhMHm
	KrDmsxiWDxY76XWrmUbDnKSen+eM1wjSRgZMWt4gnz7U4y5g6BWsfQK6UMK5mwtO5QQ1Iuq2SR1
	TtA==
X-Google-Smtp-Source: AGHT+IGgGH634jFvBjcMTqZUObCM6RH+x7mywZlvBZG1zN7YFs+cGifnMo7s9AOHUwNXLTWPVeH0PKoJEw==
X-Received: from pjoa7.prod.google.com ([2002:a17:90a:8c07:b0:31c:4a51:8b75])
 (user=wakel job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1347:b0:321:729a:a421
 with SMTP id 98e67ed59e1d1-321729aa623mr3699563a91.32.1754559916863; Thu, 07
 Aug 2025 02:45:16 -0700 (PDT)
Date: Thu,  7 Aug 2025 17:45:11 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.1.703.g449372360f-goog
Message-ID: <20250807094511.1711013-1-wakel@google.com>
Subject: [PATCH] selftests/net: Ensure assert() triggers in psock_tpacket.c
From: Wake Liu <wakel@google.com>
To: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	wakel@google.com
Content-Type: text/plain; charset="UTF-8"

The get_next_frame() function in psock_tpacket.c was missing a return
statement in its default switch case, leading to a compiler warning.

This was caused by a `bug_on(1)` call, which is defined as an
`assert()`, being compiled out because NDEBUG is defined during the
build.

Instead of adding a `return NULL;` which would silently hide the error
and could lead to crashes later, this change restores the original
author's intent. By adding `#undef NDEBUG` before including <assert.h>,
we ensure the assertion is active and will cause the test to abort if
this unreachable code is ever executed.

Signed-off-by: Wake Liu <wakel@google.com>
---
 tools/testing/selftests/net/psock_tpacket.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/net/psock_tpacket.c b/tools/testing/selftests/net/psock_tpacket.c
index 0dd909e325d9..a54f2eb754ce 100644
--- a/tools/testing/selftests/net/psock_tpacket.c
+++ b/tools/testing/selftests/net/psock_tpacket.c
@@ -38,6 +38,7 @@
 #include <arpa/inet.h>
 #include <stdint.h>
 #include <string.h>
+#undef NDEBUG
 #include <assert.h>
 #include <net/if.h>
 #include <inttypes.h>
-- 
2.50.1.703.g449372360f-goog


