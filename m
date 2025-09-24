Return-Path: <linux-kselftest+bounces-42164-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8472EB9839C
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Sep 2025 06:41:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DB6C19C5246
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Sep 2025 04:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A211C1F03D7;
	Wed, 24 Sep 2025 04:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mWnIgdqP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2040D1E521E
	for <linux-kselftest@vger.kernel.org>; Wed, 24 Sep 2025 04:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758688908; cv=none; b=bg+PEZYLbqR0JbR05w1u7GekdfJSJqPRneZbiwodjr9G+svoCPmL3x9bb3YDktuFjOG+cHVEFeIs6x+d7fv9g/83737TQKYRK7MNs2jjo21e8MvdXVdlJ6OfQFM2m1CjKdiwvLwv8CQ+sqDQ4V0Hsb9xXC51GJy3wWnIwfvazPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758688908; c=relaxed/simple;
	bh=VkN8VdwJf6liSsFMc51tLMa9eVqIny+v9e0ELBq7zGo=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=EIHr+MFGmYSXL+pVvKLtE+qplE9M2pPvfZIvyoKPVlBjqDG5d/oIgTcebcpVnW5NtCgmNIvfgCUlCLH0T5yu0SyZ2WS/pSFLaQvDSjDeqYnkoiFuy/hhyABNqrPHvxcvPDJjsqTJrkiobCC0z4vef3PC58xK5GzY0MkYHzu8mBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--wakel.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mWnIgdqP; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wakel.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-272ed8c106eso22629385ad.2
        for <linux-kselftest@vger.kernel.org>; Tue, 23 Sep 2025 21:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758688906; x=1759293706; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=EE4vZbGIJvGo3igNi0/c9KzOBwiHc7y3M43t0PHBKt4=;
        b=mWnIgdqPllmdmEo1TRbYeqSo1qr64q902tyiXqgICLgjjj4tTQwcSB1dZEg5P20uTq
         PnE11BwUyKx6VgJdcP1OpL4dhVTzU3e3liX8RAA1WoY7QfUAx3oCOR7VQXpvuJcbmETr
         7e/Bty9ijyhJmfa3lle3FXU66Ijv0j2yWTqlBBwHkYBPJblWe4C8GKvFBpY9ffCQaryS
         ZvLqpsSj+7WHeHxEMM47Xm1pwnEMzeM3m/d34KYw2fiLHqkOePbhOF8iKMp8H+3W2lh4
         SOpy03yVZTjvUeXqvHUTty323aKPrlcOwuRcUnNGQ59VQKVpudPNvAPhdN2KeETNWjIY
         cXGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758688906; x=1759293706;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EE4vZbGIJvGo3igNi0/c9KzOBwiHc7y3M43t0PHBKt4=;
        b=dsJAtHZ5qQ7HXjmIjdkrResNc5R8BCmA7msY0LdXvd5eb2+Mn+eJxtDlQLWxuM6jsb
         BfvueitI31M8TH2LTnYdVJX372T3/pS9nSwXsuuzwvu+9XONkcRvN7TaNQyAuszpJVAf
         tqjBB3Y2gE52JteDCOWWGKhNXoo+DYPEx5oAwsak0h7zEX2GsiKl8aiuiz6H5s455oys
         zS4nZxpLHvcrBpKzOZxzHVs2PXfiafe8ExNKKxfYnyIEF+21eJ95kvhMR5zow11VWfW8
         J7CpJph0rWQ7kbjEEbRJ6nJG+N60oYl5fciRzhvdyp0qNn0/bUdeMaCla3pXgXxuo6vC
         KzPg==
X-Forwarded-Encrypted: i=1; AJvYcCXspk9I9J5b56cOiuWrVZVhFHSSOHhrjBGwrp8VGS76FbW5d1bQMgVhugZDs5ZpSpOXalGFqlUcLqkkLQ16UiI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTXf+RJIXSkybTqEDAFLetI+Y1L8vRF6w0xXcgCjb5LMwtDwq+
	/QhOWlq03BC2r8kSNrmA52sFvuv5QSJ/K+eOMST+fWaXmthC66XjjavhIxOd6T7o05N3aygWHWT
	I8w==
X-Google-Smtp-Source: AGHT+IFcIXMb7tZZIi7ut6xW8tfCbz5S5n6NQszs9NFINm8xgD7Ql5FeEdZB6xxblrlnYdA/SzP9uVQoDA==
X-Received: from plbmv15.prod.google.com ([2002:a17:903:b8f:b0:267:fa7d:b637])
 (user=wakel job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f609:b0:248:e3fb:4dc8
 with SMTP id d9443c01a7336-27cc7bb9ce9mr59498475ad.39.1758688906448; Tue, 23
 Sep 2025 21:41:46 -0700 (PDT)
Date: Wed, 24 Sep 2025 12:41:42 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.534.gc79095c0ca-goog
Message-ID: <20250924044142.540162-1-wakel@google.com>
Subject: [PATCH] Net: psock_tpacket: Fix null argument warning in walk_tx
From: Wake Liu <wakel@google.com>
To: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: Simon Horman <horms@kernel.org>, Wake Liu <wakel@google.com>
Content-Type: text/plain; charset="UTF-8"

The sendto() call in walk_tx() was passing NULL as the buffer argument,
which can trigger a -Wnonnull warning with some compilers.

Although the size is 0 and no data is actually sent, passing a null
pointer is technically incorrect.

This commit changes NULL to an empty string literal ("") to satisfy the
non-null argument requirement and fix the compiler warning.

Signed-off-by: Wake Liu <wakel@google.com>
---
 tools/testing/selftests/net/psock_tpacket.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/psock_tpacket.c b/tools/testing/selftests/net/psock_tpacket.c
index 221270cee3ea..0c24adbb292e 100644
--- a/tools/testing/selftests/net/psock_tpacket.c
+++ b/tools/testing/selftests/net/psock_tpacket.c
@@ -470,7 +470,7 @@ static void walk_tx(int sock, struct ring *ring)
 
 	bug_on(total_packets != 0);
 
-	ret = sendto(sock, NULL, 0, 0, NULL, 0);
+	ret = sendto(sock, "", 0, 0, NULL, 0);
 	if (ret == -1) {
 		perror("sendto");
 		exit(1);
-- 
2.51.0.534.gc79095c0ca-goog


