Return-Path: <linux-kselftest+bounces-10383-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 01D3A8C9601
	for <lists+linux-kselftest@lfdr.de>; Sun, 19 May 2024 21:13:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 334381C2087C
	for <lists+linux-kselftest@lfdr.de>; Sun, 19 May 2024 19:13:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C171471748;
	Sun, 19 May 2024 19:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gPYddY8v"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BE536FE07
	for <linux-kselftest@vger.kernel.org>; Sun, 19 May 2024 19:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716145978; cv=none; b=iuBQC5vkpUlJi6pbuM96C7yvm7JFRCIGKsjH69LKccWHXsBNnj8uMkrh2UkC/4/WOY3BF7xftKbjVrIOnyQ2bp+q/FFzNTbwYeYn+XL3CklLTGrK8nvmsAr7pjyjfdtS52WO2MSnjOGvuKhoXayfG2cnQm9bZxZtGay0SsqlFHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716145978; c=relaxed/simple;
	bh=TvYiE6RK2shFoVTWXPZeqyoZ8YKAjkG6Ellf0yg/u7Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Y5PINR5qYIQu/Pin917/ApqTxnM4J4ybIrEIMAI/cosTlmJvR9HIUAbdAMleDSD2D+ivH9uY/O8dO/FHFNMjPOx06WKLkrANKHlA17VFHoRxashRgkEvFGvyvhHGsfPbzBOtjRDiQUVySlh64yjd74cX4Wlf+koNfQQj2IW5MWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=gPYddY8v; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-36dd215b965so5632025ab.1
        for <linux-kselftest@vger.kernel.org>; Sun, 19 May 2024 12:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1716145976; x=1716750776; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ejuUaE8Tf+21HDVBQI8KoPt1q5m6R7BpPs5rhgo54Cw=;
        b=gPYddY8v6VNIb8mBKGQg5fi8moa5PQZojxzpbfLHisKxPd54pxSAg1joBhvooMl7dE
         614g0hOPOIlRX8jjpkpxnVMT8C8B1zoYGIcyPr6hRkjSCTUl3RaJgV0Xzr9zzaksge2Y
         +WtaCCsxfovTlfgX/tuJnnZzyqFQRZjKaL5dY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716145976; x=1716750776;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ejuUaE8Tf+21HDVBQI8KoPt1q5m6R7BpPs5rhgo54Cw=;
        b=lCaeKusXQP0bZs3pcD4Tw25/ySS1AzjODot6uW7d95VvEqXrQI5772kFza51vwEOhQ
         ZzkIs4b0jBDavcaBhglQ//m23OhaoCA6y6F9dnOYZdPUa+koytc/iVCKEmvtF4KCmd9r
         /A+NPOkdXjqQ8Gh1Cfmv0SaeAuolUmqyW55GZEjxiWrNJork7W6m1UMWatMoLLXedArz
         4fWYtBsqK9mJgDDYiuIWO0GjUO81vsaqIC8Mjgrq7QbSnJShy4AfHC7pPtDLvKQlwvnG
         KhXLZuWk99WeSkt/t9zYjLto1NuE5uMlHW7lydCevO4o6T8mkkTzsjIrjR8FJQEY3NCf
         ppOA==
X-Forwarded-Encrypted: i=1; AJvYcCV5JyoA2X4JWfMIdpoIPWcGdz2UCcXMvsO88IEZGJr8lwDbqSz4PWVBoMNaHw+VwA6+uMRpoK3ygrw4isrRvt03MPJsz74+NvB9B0W4pN9Y
X-Gm-Message-State: AOJu0YzxSba+foudcE5v3hTESrkooZI5GKkGNh0mjEv7pkKZKrTkrY7x
	vtHqPpTNyJv5gaRIggAMxwD2Vyn470T4giuXH1YtJGSVvT5nLzOr/ha7+O0oQQ==
X-Google-Smtp-Source: AGHT+IFT+Jybt3kU5nlitpCW4CyTX4z7FozJUigiFblwZM3BAT1I6M9v9XBdpuciznr/CHOXRdwfpg==
X-Received: by 2002:a05:6e02:17c6:b0:36a:352c:44d6 with SMTP id e9e14a558f8ab-36cc14424c8mr319581855ab.13.1716145976473;
        Sun, 19 May 2024 12:12:56 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-665eaa5108fsm2450328a12.7.2024.05.19.12.12.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 May 2024 12:12:55 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: Kees Cook <keescook@chromium.org>,
	Vitor Massaru Iha <vitor@massaru.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>,
	Rae Moar <rmoar@google.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com,
	linux-hardening@vger.kernel.org
Subject: [PATCH 0/2] usercopy: Convert test_user_copy to KUnit test
Date: Sun, 19 May 2024 12:12:51 -0700
Message-Id: <20240519190422.work.715-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1061; i=keescook@chromium.org;
 h=from:subject:message-id; bh=TvYiE6RK2shFoVTWXPZeqyoZ8YKAjkG6Ellf0yg/u7Y=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBmSk815MmLWo2vRuElgQ1FSs0sA1xblomw+Xqbt
 tmURv+t7Y6JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZkpPNQAKCRCJcvTf3G3A
 JuEmD/4nCIUvqCOjE0Mo2VIX1bHMWtY80KIg/79W7VPn/1qIZ+MmRDTNWVpZ/dz0EbAffYTb56p
 Oj9GKp09vCwmi4tQ83ha7ZYpKlwMDW3tbGrrmOF5FGLak/gPLg9uwt3swqh5VYjcNK2Rh4upDow
 dEFZrILnKqdSmOxgUsiA+7NXR2G/EvGgy14zMeKKzLK+HveIXqa6PdXaKWn262gOcawn2vl05NY
 HaEbd4i1KFdVRZpMhq4XVnxo7etflWjYNKAfXa5wcSk0pKhMO1Dtdm1kzQCWU55waZK/xlewVY2
 2iDWaynNbWczJvg9l9o9R/sQ4OY0U1K90pEVbR5DxruG89nWoCHQdB1Q8nM0ik93d7zzvqBpx6J
 milPQIdiyzlFOYRJUxCDZ0X/2nxe6p2klL2cw7umWE8MOgGklfGyjSKJCKuQ10i2RfWW5fRpVYj
 z5cV0UU8Xk2bSHt6V58km4obdTgPMQSNogupKFuaU8Ry7gIXfOt1768JZBWz4KjVDvCDtOqiV9N
 Y8mbKPGWh+ZgixIqI1MBD29Zi69nXR9meibFu96JPoYXjX1KQhwFAJeYhc6AZa4T2ABg0KqWeYD
 W9nqK7ixiB4vZVfUbHDmQNRTAIMyHYF/uL7Moh+kwBZ17cU0vLCTZdx3c5Vdzst+oC4bHf719hG
 Y3urkwD DljoLGuQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Hi,

This builds on the proposal[1] from Mark and lets me convert the
existing usercopy selftest to KUnit. Besides adding this basic test to
the KUnit collection, it also opens the door for execve testing (which
depends on having a functional current->mm), and should provide the
basic infrastructure for adding Mark's much more complete usercopy tests.

-Kees

[1] https://lore.kernel.org/lkml/20230321122514.1743889-2-mark.rutland@arm.com/

Kees Cook (2):
  kunit: test: Add vm_mmap() allocation resource manager
  usercopy: Convert test_user_copy to KUnit test

 MAINTAINERS                                |   1 +
 include/kunit/test.h                       |  17 ++
 lib/Kconfig.debug                          |  21 +-
 lib/Makefile                               |   2 +-
 lib/kunit/test.c                           | 139 +++++++++++-
 lib/{test_user_copy.c => usercopy_kunit.c} | 252 ++++++++++-----------
 6 files changed, 288 insertions(+), 144 deletions(-)
 rename lib/{test_user_copy.c => usercopy_kunit.c} (52%)

-- 
2.34.1


