Return-Path: <linux-kselftest+bounces-27804-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73866A48B1E
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Feb 2025 23:09:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7294C1637F4
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Feb 2025 22:09:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5CE5271826;
	Thu, 27 Feb 2025 22:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BKlnf1fr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFBE426E968;
	Thu, 27 Feb 2025 22:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740694137; cv=none; b=RHs6Pj0X8Z8z6Z6el/E/2LyRuK6enZr7z0uHEMvhJ1yzLnndajQgyPs2bSLZIoHAa7+fXT+a+IxlLvvwCj40eTfDI2+1qKmaGDjjDsLMH7rnMyVXozZsvGoMZNKzqFRn5bkvL76HTkvOLQejqzO6XtZpqSYAfZmZStsqIJ10HGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740694137; c=relaxed/simple;
	bh=RtonItbxRqN5tUy3koSsiE+b6epQ5IsKPLHg4/gwsj4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=X++lrABkfb4GvCnNB2GVjPSFkDPPY01cqQoMDFSEuiXseVgC1mzANunwevneaREMbS6DImLW3G1t4RB6+hDEmX+b4V2feYGYql1Az3syoDBAzJeJJ+M9h5lPXwhH51v3YaQejowsICPb7LJ7OagnjnXZG3xwn2WvVxu5e/bvidU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BKlnf1fr; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-390df942558so1083023f8f.2;
        Thu, 27 Feb 2025 14:08:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740694134; x=1741298934; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lEaZnjEGW+dXEB2fycgaBpMAJRVwO79ROy1KwTNDGTA=;
        b=BKlnf1fr6zZ8QkTAgpp49+W9W9rNb06+YH/jv/9KZQM21g/BEZC9/tTR8Ys7WB7U80
         K0MuvDOhImc7jxv8fL6ChRiDBFxBAIy5hoHSecC6ln8ptAFkBQFjml+1Itov0EUVOjNt
         Wi3tgMqzKwFXpsTG9/fYUXO8lhUGPIZdc5173FLJTA7quuo8626xAr7IgrY5S/VV3z6P
         DHivF5Fm5zll9wlizqy21U/Ds+4iiaXqKzfeHx6Be5nZ6jiKzTXApC1dbogiXZCB13Uo
         q7AmnWZxeEqSehAnjNogp4uwRHseHXUrk1rRqxub/QSm7qmzez8BsHU8wn1XnpC7jE9P
         d74A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740694134; x=1741298934;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lEaZnjEGW+dXEB2fycgaBpMAJRVwO79ROy1KwTNDGTA=;
        b=rm6VATS5T5MVYfE7iA4/KMCn5Rhz9fzPlpvT8WkXtpSei81PsnSoqmropnrUGnkILp
         edo7x3PjYhTFzqCLqJgG91vgo7DOqR330wThCs/GLbE7xjJixBYMPd53FuOlbv/mXrFk
         LdYHeU/etdPyXAlkFO1a05Li+HhXECOLpl5cdZ9iZVAjAxPjj0wubkd/HXgywF+5RdN8
         nPf1BKiSHBvI/aOPLgcMTJwFZA8MYG/6aiUJuvY0mNGzB4iGL6rLvLuo3xHGPciscVq9
         trGcIjrJGFqr1bk5R3LDHTanJ3IKvf9Cow2iJ6IYNSxcy/5Wv6aqh6UKKIXMHnmlv7Et
         MgBQ==
X-Forwarded-Encrypted: i=1; AJvYcCVVJoHJ2Gl7xpKubD7wXqN6h9sjzJOeoDGM+X1lioJQx9eqUS2//9WxzSp8ksURCm2XtSU=@vger.kernel.org, AJvYcCVfGaBivkrLgOTAnuUXszVZSuUSJ7IsKNuwqIMLmX2+wDzx3HauZID9lrswxbrgVU/0hKy3xuqaIMNZmG8C/BTa@vger.kernel.org, AJvYcCVvTIkZn2ks5kHm7JK+FLG2hgU1pPwsyLADzOGZWLTBawfHCXxKg+qEJH3BcC2IBYFMmzEmr4XaEQM3+a+j@vger.kernel.org
X-Gm-Message-State: AOJu0Yzd3XFzCu/lSlycZGOTelTBWkPYvzFf3LVm44FL5kBOLvZXp6uw
	ZO5iKDpyc50vuTZp8btwhRxR4jO2TW75ZbHz+J9VnqyVMzcYAp1c
X-Gm-Gg: ASbGncuB3nm8yX2dECj1Ak6ZGbBV2hHstJNe02egBxJJCM9T8w0HChNMUofCJTKlwDd
	fbNthStO0DK1B4yXhSXFBan3RwGlN7Yv+Hm5clZwpTe1+r3xYYrwdAGxbmk09dJPQVf/5Yr1d0T
	79KhncGg+uH1qf53qI7HCaUN8cdt7hOLDmnVRsGTPZ5GmR7zBqoJ3thWISX9N17xzs/lhxkdTIr
	aXziKcN+YYTJ4hCwCPIxeK1HrUPBRyadYRN9W+F7VYRiKfEmS50rE0JeOJiBlR/2LmUkO8woy30
	tYJ/QOPpuInvtHYovKkrs0MLnDs=
X-Google-Smtp-Source: AGHT+IFZa9dboOaE6stYPiILmPTLGm8NPOEro5l2YZ8uwZslwXyNX9MgmlcGxKnCIReGCaskMePG2w==
X-Received: by 2002:a5d:5f91:0:b0:38f:3c8a:4bf4 with SMTP id ffacd0b85a97d-390ec7cd27fmr661579f8f.6.1740694134109;
        Thu, 27 Feb 2025 14:08:54 -0800 (PST)
Received: from localhost ([194.120.133.72])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-390e4796084sm3303760f8f.19.2025.02.27.14.08.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 14:08:53 -0800 (PST)
From: Colin Ian King <colin.i.king@gmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Sean Christopherson <seanjc@google.com>,
	kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH]][next] KVM: selftests: Fix spelling mistake "UFFDIO_CONINUE" -> "UFFDIO_CONTINUE"
Date: Thu, 27 Feb 2025 22:08:19 +0000
Message-ID: <20250227220819.656780-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

There is a spelling mistake in a PER_PAGE_DEBUG debug message. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 tools/testing/selftests/kvm/lib/userfaultfd_util.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/lib/userfaultfd_util.c b/tools/testing/selftests/kvm/lib/userfaultfd_util.c
index 7c9de8414462..5bde176cedd5 100644
--- a/tools/testing/selftests/kvm/lib/userfaultfd_util.c
+++ b/tools/testing/selftests/kvm/lib/userfaultfd_util.c
@@ -114,7 +114,7 @@ struct uffd_desc *uffd_setup_demand_paging(int uffd_mode, useconds_t delay,
 
 	PER_PAGE_DEBUG("Userfaultfd %s mode, faults resolved with %s\n",
 		       is_minor ? "MINOR" : "MISSING",
-		       is_minor ? "UFFDIO_CONINUE" : "UFFDIO_COPY");
+		       is_minor ? "UFFDIO_CONTINUE" : "UFFDIO_COPY");
 
 	uffd_desc = malloc(sizeof(struct uffd_desc));
 	TEST_ASSERT(uffd_desc, "Failed to malloc uffd descriptor");
-- 
2.47.2


