Return-Path: <linux-kselftest+bounces-39842-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A30C5B344D1
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Aug 2025 16:59:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D2C51779E4
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Aug 2025 14:59:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B38222FF641;
	Mon, 25 Aug 2025 14:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="PDfm7K8N"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DAD72FF159
	for <linux-kselftest@vger.kernel.org>; Mon, 25 Aug 2025 14:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756133882; cv=none; b=fnWc0GdGhGuJKEo1esoMbr2dLwRpwiwyiMrQPTat9DhCC5GmbTHa0X6SJQ58kQvbEPE4vKPt2D2nJCmIrRmI0eL+kqLCLj0CtoL4TPY6fNBs5X24MwHwu7NMVFmJIMXQtYra4gicKQzpJ30ZJ4dh4iPIYl29Kjd9wvSNjUkosks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756133882; c=relaxed/simple;
	bh=Uo8Uq5CGd42i/IUZX2QiGqJ9jwcLrhXXcAVNfr2ZqI8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WpX76G0U6ab+MjJ/CDIvXFt4tzReCzvY37C0QEyLt/XE3SciVFJXnyVaTdKUYzettzSkBoUs9Wu9ayywDYookKfUt69ZjimTqOehAay8e0Hc9Ycpwn5h8Iw5KeA5VJz7PRN0tCYdobeh0dbNebOo57LzvxC3bnDFIEJMWYOGQsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=PDfm7K8N; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-76e2ea933b7so3924122b3a.1
        for <linux-kselftest@vger.kernel.org>; Mon, 25 Aug 2025 07:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1756133880; x=1756738680; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6KNNjy6jnCK8i9cBT6PGrQfVqxJIthxv9ctwdRDGY9o=;
        b=PDfm7K8NieFMY50Sdlh/ug169oYnY/9tcoBKJLQCELXJnxgAgqIv09LuNQQfzGnG68
         lsyVpBypgdYeCY0+sb65Ogh35dUZTioX+bCxNSXPwlQ8mjC/gR9q6CtLESyTlDz8Vzpd
         /gMRcjFBteIhH9zCv3z7oqGYKF7gRXXJDcRHg0GdqWo9kZ1IV1W9S1nJikMcEBwvEJZK
         8PerSauEHl2NlBYwgoI1uClSoe0bExrWphQo/Fb5EvPtppNcxOfx87tI4En2m0DRypEo
         rgIcQL2fKuDSzVqkv7UlAo1sDcyPxb80QFd0Ld8AH4BZDCZMZ+bkXi/kpPunwasyhAo1
         wOuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756133880; x=1756738680;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6KNNjy6jnCK8i9cBT6PGrQfVqxJIthxv9ctwdRDGY9o=;
        b=TPkiFLIrfZPhEHTWLaQ1RH3zl9+yQbPSK+azVjkmS0h6b3z6NlqxYibFZRxFNCs8KC
         hPE2i7IzY28QhjU/leUc103rYPG0dmr92vYImNLgjtxILRB8qBrAVfwXASmzp4yur26f
         io4kUjKQnfKLpJApy2X5DDCeWvltEweKgljHv6Fo4/hV3BkFBnWe55c60NxbW2psi3Jd
         S3Z+uz/EPj8zK/nZFeCd/IqN39vs5k2bPe6Mlte+fooPuEYrq9lZLUTlLwlRzZiUxVLM
         YgVCphBGLzbDU1hy+7VUihY/0Y2D0OoK4Q+Io+/YlxG6ZUuHY0D0vlMHl8pKksCQmtA3
         /TZg==
X-Forwarded-Encrypted: i=1; AJvYcCWVJsDFb+ik3OBgzK+DsQQl4ZdZw/DZFSV1PqA+5mrPrbkEKFlrF5g/gTxQRCa6ngGbTszIGqsIVJfcRXLBXag=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzbr+3vJf36GDiO2eZHYwcwI2/ccNKvHgKFf18+bFo2R/mEVWft
	clyoGZn3ky2wrtEokqsX42kz7a1oA+kvJRXRRvhE4il7PYH4aEd6i2aChcKfibOHnwA=
X-Gm-Gg: ASbGncv/f3NPghk6M9gRzG+nWi0dl9ebqr3bo+HtQiTkwWNkIPzy3r6Nr4IpGqe+j+h
	KexTCVBL8jhJZydn5razUjSdYXdg5yghcqUONWArAYrd1ytpx90jyv+RoLR6mXC8N2RNaHCSYem
	PNVsL3lmtfs94fFbjg8obYjnLxhPOGSa6VQPACWzzqxnxOPjSGKUTzWJG7wVEWp7snL3vD/2SAa
	o1HJqgiojDXKbVbAHBKenURNImgPKyAzDF+WeGIOrGRPXs7lffPXwRAcp/MczeV1kG1H+bHhjUo
	50Rh1d97tmGlYeW2zOl0q83cYExnAygFpg+q35fI9QhOin+oN8beYPAY4fJjNL+zu98/RIaeqvd
	+whQO/Hullc5LtiAWxJZve3qTqBiliG8UVGXUJ8YmpZVz2gRNsYu+YyLb2Uq2
X-Google-Smtp-Source: AGHT+IGbWxmYTsBIeFlK1EvF3uLRm34ATqyatUoKhGCOYfILgtNZGvHj6AvQD4iDtUNoTtKa6iaYsQ==
X-Received: by 2002:a05:6a00:4088:b0:770:4753:b984 with SMTP id d2e1a72fcca58-7704753bbf6mr10848203b3a.16.1756133880306;
        Mon, 25 Aug 2025 07:58:00 -0700 (PDT)
Received: from H3DJ4YJ04F.bytedance.net ([203.208.189.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-770401b190asm7803436b3a.74.2025.08.25.07.57.56
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 25 Aug 2025 07:57:59 -0700 (PDT)
From: Yongting Lin <linyongting@bytedance.com>
To: anthony.yznaga@oracle.com,
	khalid@kernel.org,
	shuah@kernel.org,
	linyongting@bytedance.com
Cc: linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	akpm@linux-foundation.org,
	linux-mm@kvack.org
Subject: [PATCH 8/8] mshare: selftests: Add test case to demostrate that mshare doesn't support THP
Date: Mon, 25 Aug 2025 22:57:11 +0800
Message-Id: <20250825145719.29455-9-linyongting@bytedance.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250825145719.29455-1-linyongting@bytedance.com>
References: <20250825145719.29455-1-linyongting@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This case is quit simple by using madvise(MADV_HUGEPAGE), but for verifying
the size of THP memory, we need to setup the memcg and attach test
process to this memcg before perform the test.

Because mshare doesn't support THP feature, the size of THP memory should
be 0 even though we use madivse.

Signed-off-by: Yongting Lin <linyongting@bytedance.com>
---
 tools/testing/selftests/mshare/memory.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tools/testing/selftests/mshare/memory.c b/tools/testing/selftests/mshare/memory.c
index 7754c0e33506..2a415ce7bc01 100644
--- a/tools/testing/selftests/mshare/memory.c
+++ b/tools/testing/selftests/mshare/memory.c
@@ -68,4 +68,15 @@ TEST_F(memory, swap)
 	ASSERT_GT(swap_size, GB(1) * 9 / 10);
 }
 
+TEST_F(memory, thp)
+{
+	ASSERT_NE(madvise(self->addr, self->allocate_size, MADV_HUGEPAGE), -1);
+	/* touch 1G */
+	memset(self->addr, 0x01, GB(1));
+
+	size_t huge = read_huge_from_cgroup(self->cgroup);
+	/* mshare don't support THP now */
+	ASSERT_EQ(huge, 0);
+}
+
 TEST_HARNESS_MAIN
-- 
2.20.1


