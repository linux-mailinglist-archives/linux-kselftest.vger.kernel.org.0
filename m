Return-Path: <linux-kselftest+bounces-26780-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B891A384BE
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Feb 2025 14:33:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBD7F1897956
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Feb 2025 13:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB2B721CA0E;
	Mon, 17 Feb 2025 13:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SwGX+POg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A379216E35;
	Mon, 17 Feb 2025 13:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739799059; cv=none; b=cc000DaQ1hZyY6Lsq12bR3FIHu0kzfNhqqP8Ky8qez0Viq24d5qlJpyUBd5YX8YrhPdtRV7OrQF1pWQOrfuTuWhl4KuYlBRHnNd3chz6NCrgkXoqd6a5GmfW7YTmEjcujT9wfJW9FBKw8ULzcBRWgJGjMGtzY5QYuE7IYsHmQx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739799059; c=relaxed/simple;
	bh=Ci1COuX6Tex2zAyW3UWO2Ew42J/7mVCWOO5StT0eol4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=FvYVWj+k0U/CddvPOavSTbtJcEKY/A5zMWIM+jB7y62e9EUcLA5vsVsRCBi8xR3EWvuJQse8mstgSNGhNrQNOH1l5CvG2Nd2v45JsT6FUuuqT+hITWRM1yq2rkWVw175F2I01b5GMDDtfn4f9WncRWA0g3D26SuLztinfdemWJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SwGX+POg; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-46fa764aac2so35014801cf.1;
        Mon, 17 Feb 2025 05:30:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739799056; x=1740403856; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fOEexKTjiuD42jQvv3hpmelca47VqT1a18N1JHI7NKg=;
        b=SwGX+POgtVkyqBHLYLPlZM5uXVPjYWckIPpDxZ6GVwq4nU7gtAHb+gVBtEAuRsLgDp
         9JmD0tLO1Jz+EUateayg8EQLm5SWUgp6VuqFnbCuX/k8BdGBIyR7jnVmvlwYMuK8qWtA
         mnQe9zg8AWJRA1PJRTqFMKEJYFuQuITDyNBW0QQCOlcsPL5dxb23HKKccvPQvQeieyev
         wPGE7btpazOUyirU7qaMVv4Show7j+6D8VOZ994sifhB2DM7ZAc1Uyz8BWvMR/fqpK5O
         /2Bw6UUMa98wF5zxCckIsq301XUa79fa8ZsAXhNSpB/IExRiOJNyQXd9MofiVrr3r6DI
         4wPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739799056; x=1740403856;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fOEexKTjiuD42jQvv3hpmelca47VqT1a18N1JHI7NKg=;
        b=xRUV0feNFTg2gllBGijjZHO31Ep1HGOUXgTG+xWPXEJGpTdrajvjy/16HFJ3MiTFEs
         QFxgOCQZdZMUG1savfiVR+mBjsDZBqjaOA658UbFVZpI2C8is/vyNX799hRh7lK04sOC
         NDzXz+5Sg0jJsOvkFBi7ss/HIpvEWyNYlp1fkYC8keoNJtao0F75eELTsC1u5+WxFM3Q
         +6wXV+Go+ExQ+StrlWPj2ZffbpQoRexd7EIcDraIHkYzjXQuy98fxFi1I/sz7CekXoMF
         1N+m8vlPgd2X3OnFBxFq74fABvxxF72ROoNU9MiBJ43W1bQW6ohiEmYjrhPWXADJuWsU
         oWLg==
X-Forwarded-Encrypted: i=1; AJvYcCU2gbBbQzIMCAKmEVPGIMOmprW4QwxxKlqoXmHwA+xITE9eDOxK3UYc4xKcQofRjtK+ScG/PG3jx+ucvTA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywuu5/TqVdNYOBEJuf95vyYWct5yw060dc8WyNL9YiUkF2H1eks
	u4TZtuie5nyf/v8vS8EEhPtnYl8k30ChI58R/5L2wZmfm/07KTDza0Ckzjgi
X-Gm-Gg: ASbGncvK+DT8Ft8R+G59u5MqkP5kIFPkZ2y8zQDQ8iUWOgccnY0bzeoAtwywCjXNReT
	0xJPblPMcbNuFZ+HckeCqNxyccdRC+ewA0YVOXy1Lv/WbSaVn6xblxymcKtx9z/+YX15WNYI+Y6
	oDGkWbUzU54v/dN86GjEBPun6OOfRdZfEedAIah6PofYv86mOxiB3nBRqqwdo0HPhJzVAQmJU5l
	6ZeWh9Qbu7SDYwFq8O3CpEnFC2pP+fjxFRMenc3BcASxOE0eLWZNetil1KVFhqCx+3+qlVYMQXw
	GdJuXqzA+FYMQg44ndiQwNDuBBMh/wikEDu0IA==
X-Google-Smtp-Source: AGHT+IEkw/9PhCElM+wJh8NDgNHcMXUDbkc1rj0rJlwgZQWlmQuqZS5NCUWmW4yM2EuXqdVXAhgkwQ==
X-Received: by 2002:ac8:574f:0:b0:471:ac91:966b with SMTP id d75a77b69052e-471dbcc1cfdmr158394571cf.2.1739799056010;
        Mon, 17 Feb 2025 05:30:56 -0800 (PST)
Received: from [192.168.1.159] ([2600:4041:5be7:7c00:a82e:ca05:346d:c94f])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-471c2af3722sm47732511cf.49.2025.02.17.05.30.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 05:30:55 -0800 (PST)
From: Tamir Duberstein <tamird@gmail.com>
Date: Mon, 17 Feb 2025 08:30:44 -0500
Subject: [PATCH] selftets: lib: remove reference to prime_numbers
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250217-fix-prime-numbers-v1-1-eb0ca7235e60@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAQ6s2cC/x2MSwqAMAwFryJZG7CBKngVceEn1SxaJUURinc3u
 BzevCmQWYUz9FUB5VuyHMnA1RUs+5Q2RlmNgRryDbkOgzx4qkTGdMWZNWPwNjrvZ6IW7Hcqm/Q
 3h/F9P133EwRjAAAA
X-Change-ID: 20250217-fix-prime-numbers-f5202155b226
To: Shuah Khan <shuah@kernel.org>, Kees Cook <kees@kernel.org>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 oliver.sang@intel.com, oe-lkp@lists.linux.dev, lkp@intel.com, 
 Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.15-dev

Remove a leftover shell script reference from commit 313b38a6ecb4
("lib/prime_numbers: convert self-test to KUnit").

Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202502171110.708d965a-lkp@intel.com
Fixes: 313b38a6ecb4 ("lib/prime_numbers: convert self-test to KUnit")
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 tools/testing/selftests/lib/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/lib/Makefile b/tools/testing/selftests/lib/Makefile
index c52fe3ad8e98..66dcbe2e39fa 100644
--- a/tools/testing/selftests/lib/Makefile
+++ b/tools/testing/selftests/lib/Makefile
@@ -4,5 +4,5 @@
 # No binaries, but make sure arg-less "make" doesn't trigger "run_tests"
 all:
 
-TEST_PROGS := printf.sh bitmap.sh prime_numbers.sh scanf.sh
+TEST_PROGS := printf.sh bitmap.sh scanf.sh
 include ../lib.mk

---
base-commit: 0ae0fa3bf0b44c8611d114a9f69985bf451010c3
change-id: 20250217-fix-prime-numbers-f5202155b226

Best regards,
-- 
Tamir Duberstein <tamird@gmail.com>


