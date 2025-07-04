Return-Path: <linux-kselftest+bounces-36541-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23AA8AF90C0
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Jul 2025 12:38:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7F6D3B4AFE
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Jul 2025 10:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E38AB29A310;
	Fri,  4 Jul 2025 10:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bufaLox4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F58F244686
	for <linux-kselftest@vger.kernel.org>; Fri,  4 Jul 2025 10:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751625482; cv=none; b=mHokrIjeA9O/VUIEiKS2FRipAXBoAPmRo5jl5LpB6pEh/Nm0a4H0NnTJI8zUUSvuA3C3mmrddx/5uVLAqA1MkQXkUkwVpJCxfsX/67xeS5wJbb0pgWmjVEaoqBI6iCoy0uROT1TUcKzxd+ZwWqNGT0dI+geB6ObuhHO+/dbnTJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751625482; c=relaxed/simple;
	bh=R61rp45Losycq8UAnzdMkZ9UbrztK6ZBfROjKO/3BnM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IvakAOnNypdmjuQqhIhgg/V/4xoswKfoCjaKvrigx2MhJRKPY+8F3MuPVxMC9CC69BSe7ELqBUTZigd2GqckZHpyc1FxIhXqK1vMBEYICVEnHKAb79QqKHd3JY2VqVzv9/6C14e3RnTObNbSytRYgEAz5Trh5LPg+Z/7EYHeV9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bufaLox4; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3a53359dea5so360209f8f.0
        for <linux-kselftest@vger.kernel.org>; Fri, 04 Jul 2025 03:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1751625478; x=1752230278; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RU8fatJd1cv2n5jtAJadSkr7OYYXJbPJFcsa+TWXM6M=;
        b=bufaLox4mNtFs5mAZLmF1H/sk+Wx4TLbrnRhwGqJd1ovivYFFAhYUmXmyVjTKKjTDH
         HYFBch2DKFTu2WH7YO7Jkef/XGwffwU8PA5Tih/y5IAuO0P5uDBXJyGscXXW6HeD64fn
         ESwPk0XXBKQ6L83dj0FK+EzWIhJC/Ea1nLHCfknyJ8LveDB4iYgzlbDhafM+PNuaSfoL
         zvoDXURZqwr/Jsmi9twpVxKAETsfmLh0zkfEiGB3MWZ7VIVu4T1u6HZgb3/VjdpKez5G
         o+xv7QNKR5itubm9rlPE50incRk93SW93si2Hwux8aK+m95KKWDHNLvCxYtpYsVB5Eay
         b2Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751625478; x=1752230278;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RU8fatJd1cv2n5jtAJadSkr7OYYXJbPJFcsa+TWXM6M=;
        b=WU8O66TUwCKNnafA3x2pKTilITbP/IgRPhGZAQYF7t/DGfJn2mmuhChecb4LfRLQPO
         JkVQ1R10MS6HWHXVPJNEUZn4IhPGkPNLe7i/RJ5RovgGrl9mowjy/kZOX1ZsSnGc9gwk
         cJUAjsVK7W3gypnRg3vP+39tThM3QzU0gNzBK6VqUC702L95RBIP60RY+SlAz8xKjaH1
         eg9Tw6ghPng2QtDdQKKmojWeiIfzzWL4fndTvKf6DI3LgpzKSc9WvJlXFxvve0SMVwco
         YK4Ah0fQhxPLywbLdtUqao953qvjQUjNlGSo64xF48PUyuzV81wT0/2k+qhKC+bXSFHr
         T6Wg==
X-Forwarded-Encrypted: i=1; AJvYcCXYIlTikelzHSMKGdjl0IUxdoXJ+t437SxcDPYFCla+3TP0uDqI0j5laW8TgGDdrrUH6mePL4xAWnF0mTf4njI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdP0zDSX1Lj3mZhG23wfSovDimkV+5AjU/p4qTH02RfAOEFJeO
	lAGCQ4aIS60Q04XRXZ4p3U+iSixk4KwBKazZbKLooSo1UntasTMRxRJP+Sv3u6Yr42M=
X-Gm-Gg: ASbGncuHXb/gXAl85lVkT+Fbb390n5YSrqBhusyBEKuwCSWePLRdQcYEfivMZ2DYUF+
	+TbwZHuV064o7K/azEgOLC3t4LLy7a91njVtYz6TiSvLlVrutG3aarpbew+34yt2twP7zqW7Jav
	Z2ZX1gJ/orOcS1uu5hLl8268OR3Lnl19xqWxpLrUATnrpzxdY4XcY1B/WJ6jPeJS/DFRAJTzNEM
	Zy16IoQPpMhqIQ4mG8GehS3GLa2Zp68dVJdcU13lPM11rgvp91+N7FLxUW9FGXovHQRM4SWn5zw
	GXeCZi8DXfFCS8sWQ1eNz6tMYUyYY/b1jCRuSZpZ4+WhCwI8DlLWf65daVLIR9wWRDdwKEkQU8O
	DB4Xdy9Qbk/v86gIhg09nK0Ik4m5repAvDbn5IaBVDAxeCLMpXDHAdqQHewPop8XnM7w0P6s=
X-Google-Smtp-Source: AGHT+IGhNXKIGZoogvnG+XHZowEEyeBRsxNYAJfEhbfMb8zexJp6A1Fk4F4oOcLnx7xw+eCnIsD0Yw==
X-Received: by 2002:a5d:5f92:0:b0:3a4:d0ed:257b with SMTP id ffacd0b85a97d-3b497020597mr1215816f8f.22.1751625478006;
        Fri, 04 Jul 2025 03:37:58 -0700 (PDT)
Received: from green.cable.virginm.net (nail-04-b2-v4wan-166353-cust693.vm26.cable.virginm.net. [82.35.130.182])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b47030ba77sm2187132f8f.17.2025.07.04.03.37.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jul 2025 03:37:57 -0700 (PDT)
From: Terry Tritton <terry.tritton@linaro.org>
To: Thomas Gleixner <tglx@linutronix.de>,
	Shuah Khan <shuah@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	=?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
Cc: ttritton@google.com,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Terry Tritton <terry.tritton@linaro.org>
Subject: [PATCH v2] selftests/futex: Add futex_numa to .gitignore
Date: Fri,  4 Jul 2025 11:37:49 +0100
Message-Id: <20250704103749.10341-1-terry.tritton@linaro.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

futex_numa was never added to the .gitignore file.
Add it.

Fixes: 9140f57c1c13 ("futex,selftests: Add another FUTEX2_NUMA selftest")
Signed-off-by: Terry Tritton <terry.tritton@linaro.org>
---
Changes in v2:
- Add Fixes tag

 tools/testing/selftests/futex/functional/.gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/futex/functional/.gitignore b/tools/testing/selftests/futex/functional/.gitignore
index 7b24ae89594a..776ad658f75e 100644
--- a/tools/testing/selftests/futex/functional/.gitignore
+++ b/tools/testing/selftests/futex/functional/.gitignore
@@ -11,3 +11,4 @@ futex_wait_timeout
 futex_wait_uninitialized_heap
 futex_wait_wouldblock
 futex_waitv
+futex_numa
-- 
2.39.5


