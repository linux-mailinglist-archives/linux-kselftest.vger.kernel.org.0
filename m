Return-Path: <linux-kselftest+bounces-38410-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B663B1CBF1
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Aug 2025 20:31:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CD283A7CAD
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Aug 2025 18:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29AF129C33A;
	Wed,  6 Aug 2025 18:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V72obWrI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B74531FF1B5;
	Wed,  6 Aug 2025 18:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754505054; cv=none; b=bM0Wl+O7gXFAR4npANutbgTywVZcF2gnpuXe6hO+UJrGHLkqTKNQjXzGd1JsjuSOzJupUkG38jydjKQiRiv9fHpix/mm0bggNeQ75B7Hljn+LutsvKqQCXw4XovhXSZTKVYqpGQkl9N8y7Zn1a0T2MoQkntLSd8YGqWH4Beh9hI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754505054; c=relaxed/simple;
	bh=T+1HlKw0s9c1tad81m//HxBviAT8h8of98i+3now1w4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SC4HpU6Idaa+P9w3RKLCsx+zk8TuIM8qfk+75HkaGKz8j7zQnT45EM19kLstoO52eWsNhnD6cW5At+5Oh7H/Q/buHbV2Yx1tlsAvShbGppwnW7iLFaghOcByr00szlPJOvXEFvidfSUWMF1dnh6XL8NnMWnVBy4XWxZH+FPz0s0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V72obWrI; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b3be5c0eb99so113732a12.1;
        Wed, 06 Aug 2025 11:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754505052; x=1755109852; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CvgCpYV82+QLhrXKYTkJl5n29y4RTR43i8tWOdTaOvM=;
        b=V72obWrIPRJYMev61GKzXm3rjCMoyBPqa9aCMobtbqLdFe8L3fjGA5ULSqdUjeFzmg
         lJ545BwSzUIE5B/cB0NLWdxjFnlsWY3IWeWAlAXQRG40WTGF9BvaRrh7QOlPH49G5Q9w
         b/9erqzAGzD2CcJ2dxccFkgpFO4gg5E8C2NkdZrGctPhbaDnIp81HUQYJap6JrJZvwIM
         7mIYcAsWS2te/5Y1ZZQvRLgfA0idRbOHwoPO/VGghY1hFtrXlleDSqD4GG+9DJxXqQHm
         Mee/M3vAvuUuLN4fEH9FEsEF5bLzJtocVZLqxp5u+RsiMnV9IRXDceddqAVG4jtT3HLh
         SsCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754505052; x=1755109852;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CvgCpYV82+QLhrXKYTkJl5n29y4RTR43i8tWOdTaOvM=;
        b=lVvb+EsleKrJ3YBZxkAlFozopWK718pbwwNkpBQCenPbmhHIfcwZ5dD8Tmwm3RHMn+
         a4SR6m7yUoUYuYnTCxLk8XsZ4d1VtUCUuomxVNLDfzHdg2NBBhReaKSN2Zut2K2f+J1a
         RJYw5SkB7q2J/oLSbWUepmdZOwTZ8sn4KPrLhs2Ncy4m9JLlsOAOwPzbnWl88/js1iBj
         SlRCRIZa7fdFGA1p1onpnoRTVXLfV4qPzRweNIu3xGk1RvLv1a4RP3Kn6K3me/NXu5SE
         fAGTzwyuPokq1jWinbvIjnRSIwZBiVWVGCmXI14QkvNgL8E0vdpBJgxcSgTpE2n9Ozhq
         pluA==
X-Forwarded-Encrypted: i=1; AJvYcCUPSwhDWtEiq87zr11QlhJXV5aqFjABRMt6f2aSKYlXcDZzRWt2A/bF1BdApkGafVkVdELeQn81QAktIT4=@vger.kernel.org, AJvYcCVfKiPvcqEnxU2iGahQaRkcZAnReRTevZ06JOyd7Bx1e1C8+ZWKqW90uFxhcgfosRSk0UtoPkc73EY4dNCzVa8R@vger.kernel.org
X-Gm-Message-State: AOJu0YwB8x2rRiyKGCBwnu8HDuYv8lkqhrw3XwrI19KVJ0MHptoPCGlt
	Qh37YZnF5BOOQB6wN7pEluO6IGkPcsbCYb2xs7qrpzWI35IJBbpl9RJH
X-Gm-Gg: ASbGncsDWNbKnwft4wJN+bChO0npbCVo/M7rUtgixzbReICFlTSQo0Ql54Qlh7NCJB+
	idag97kQZMQeyLsDZUWwZ+IPecU+ZM3jn0P/1xHbKmaLcHPB/3Iylc6FrzcQ2yEVQOjah7LgYQW
	oLQfXK5OIPLkx1cBHtko5PQG/KWD/V7RoKu2JWTMfMGe5qGyx/5a5hyemYHU1HyuCMguDnKA4d9
	KpsNORgBPpAnEyYJ+wXoTDzIW99/wquDyVHisHSEumhE+XzISi85K5NDyFRnNMtkM9kCQm7+plm
	YEckaFEBp9FOIjY1TjJQWv3LJoXnWCD+o3oRDAc6HYWonOc0C9I92MjnDyPi+GX/SLKSjBcJFWS
	zt9x7NTK0RbKQjqt7uu39
X-Google-Smtp-Source: AGHT+IFoqMA+F/6iLOHC7KIXqVX88uaOv4pNyTT/6IjxRjJViB4zQn8WY68ChegYQ0ATdleDWMzGLQ==
X-Received: by 2002:a17:903:986:b0:240:3e7a:9060 with SMTP id d9443c01a7336-2429f51c6b8mr55588235ad.37.1754505051670;
        Wed, 06 Aug 2025 11:30:51 -0700 (PDT)
Received: from fedora.. ([27.63.252.211])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e8aabdedsm165918815ad.167.2025.08.06.11.30.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 11:30:51 -0700 (PDT)
From: Devaansh Kumar <devaanshk840@gmail.com>
To: tglx@linutronix.de,
	mingo@redhat.com,
	peterz@infradead.org,
	dvhart@infradead.org,
	skhan@linuxfoundation.org,
	shuah@kernel.org
Cc: Devaansh Kumar <devaanshk840@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH] futex: selftests: Add description for futex_wake_op()
Date: Thu,  7 Aug 2025 00:00:26 +0530
Message-ID: <20250806183030.542453-1-devaanshk840@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Devaansh Kumar <devaanshk840@gmail.com>
---
 tools/testing/selftests/futex/include/futextest.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/futex/include/futextest.h b/tools/testing/selftests/futex/include/futextest.h
index ddbcfc9b7..c77352b97 100644
--- a/tools/testing/selftests/futex/include/futextest.h
+++ b/tools/testing/selftests/futex/include/futextest.h
@@ -134,7 +134,9 @@ futex_unlock_pi(futex_t *uaddr, int opflags)
 }
 
 /**
- * futex_wake_op() - FIXME: COME UP WITH A GOOD ONE LINE DESCRIPTION
+ * futex_wake_op() - atomically modify uaddr2
+ * @nr_wake:	wake up to this many tasks on uaddr
+ * @nr_wake2:	wake up to this many tasks on uaddr2
  */
 static inline int
 futex_wake_op(futex_t *uaddr, futex_t *uaddr2, int nr_wake, int nr_wake2,
-- 
2.49.0


