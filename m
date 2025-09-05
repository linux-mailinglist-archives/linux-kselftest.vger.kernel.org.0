Return-Path: <linux-kselftest+bounces-40819-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C1CEB454D2
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Sep 2025 12:35:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C06445A7B98
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Sep 2025 10:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B57C2E040B;
	Fri,  5 Sep 2025 10:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DDtm8cNd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD9062D7818
	for <linux-kselftest@vger.kernel.org>; Fri,  5 Sep 2025 10:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757068489; cv=none; b=PjoB0GCrfuWxWznHXQulVR2xDdm+kxcn5mdxqL6J+CHKNktj+jdm6BPOHP54v1aOT8/sGVz3W+edhIdyWIHOZrvz8rG5h+h9cYEuZJSopdW7bLYPhWD+Wif47zNMAX/Zv/nMVYjdGeN2837LJKIpQEgiBamk7QLvpBYjjqHfLeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757068489; c=relaxed/simple;
	bh=u6RhB0tf0PDdBxV2rbvlgcsSK3l7osAwo6tTvY3V7jU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=q+doIq9+mvHQ1al70s16tK347vG2OOHKLJU3Ead8zojRaoW4dmRZI4NHIOyLOmbxvEQvJeZ0jSK0ADdy4NWs1Qr8ZY1u1SCYk8AYw1kPV7P7YVjBvqptDmvpnAk9sWLveqRKGCAaiafZ5ZU5oTeLKQFkRWgT+9HcWavCMGdXA/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DDtm8cNd; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-45b9c35bc0aso17914315e9.2
        for <linux-kselftest@vger.kernel.org>; Fri, 05 Sep 2025 03:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757068485; x=1757673285; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GPtTBmTlI3N0NEb+IPUhn2li4g4XRE/ENCP82oW3Ymc=;
        b=DDtm8cNdvV2i0UbcZdJkKhttMeS8Ge1GZO6/2sOLoaBmV0Cy8YGY4P1pqt0cRU3ffB
         uZOxLjyl99lUMFuT2YPgdHBvXJ7UPamY1JRM9Jb4F5VTCCbWW1kPiZ4iPu0Qo7cax7Ty
         81Bs+zgXlE1A8f/wSNCP0t2WuKgoVKP4Cvw9dxJv6RMuz6C/8EtW8mkXuZG7oS4KHhKB
         SlQp6BiPWfZPhTXpm/VHVal7q2SHwIbu3zC517XH7LH83IgSzhaRak9TgHDZ7xYFiK8u
         f42EWOVh2KLenHMpUV/AvVqP7MV8A8ZFcsI1kX2B9BKczikqemGfreSq27b2cvUFw248
         rZ6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757068485; x=1757673285;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GPtTBmTlI3N0NEb+IPUhn2li4g4XRE/ENCP82oW3Ymc=;
        b=qLtJtUd7Mozu0ALVcfgE/X8y0DVixZQ0ldJnTyK5TSfhd4VoH+TTxTYPjtApYgJHMO
         IB0rAPca8ZUrxmpk7aXmdSVgrvITJdCiFBvrHZKWlXykdDiN8nQ/5mzp08OW6D29QTWW
         0V5idnQ0NjQ98voybdHjKKDp0TdWwWzcB/q3jepm6er+daKZlGWq+QoKRiateDDtEcaS
         XsWn7AnOSllgkq9JfB3wfWl/2qrinpKvzsYhgdyIE/Ui/hGq2F66WGHyjjrZz0GXe+9B
         rbbviAb0xcC7iD8iseSy5Q3WGjuFrk0myF8Eq7aVwY5S9NipPM2UbZn4WxOhxQlslVna
         iHfg==
X-Forwarded-Encrypted: i=1; AJvYcCXAEyUn8EtL0uWqqetkNoyvaBh9Aibbuyo5MCk67scRsHm2p9W2klqKAj9ewHpCMhoYCtVfYRaejqGHh4FOF3Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqZohL4q+UGDJgHJ3ryTvE6dpggGp5spPagRADMPZrV+3dFp27
	UPF3QBuBrRS3qkYdCH+uUxKWrHTiZNrCDnQRnzZ9rNdgwRJQVDJzxnKH79/AYBTDxS4=
X-Gm-Gg: ASbGnctZiI4iNlpoKEMWHHEVPsoOSekSD80L3rmyKClaWnI8eXDyAckccMKNNettIN2
	HxddlzGC4UHgikPLFteLMWB8m2k28ar2uKc3XPzGFHas2ywY7FEQv0ZOekOw0MDu49AY+3Y0Emn
	z8ZP0vbVH/5mVxgmHB/pObc/L7aKl1GMmnGieE+hMELQCla0qNjfo7XptWXNgL06YKY+YCz31DC
	9FqswPv9F34F+tpshGMZOsNQNR3TmanaDg/HElM6E9zwnac4HzqhYugHspO19Ap8Kt6vMT+LhES
	6D8LScaGR36QK6DStDTU+6b1XRrRWqrvvjTrFe0DRBsq4yr0DiU0a/MfZPOiiC2ScjUIUdWepdT
	5WYoi047JW+is6PwgwOB8+d1AGEo=
X-Google-Smtp-Source: AGHT+IHMNZ5aQjypfVjJ8/LG9UBIbm3yubJahrqfypappgfPyW+RM4kefqenC/by5O/ylYVnmWRXlQ==
X-Received: by 2002:a05:600c:4454:b0:459:dfde:3324 with SMTP id 5b1f17b1804b1-45b855b34f8mr173869605e9.29.1757068485001;
        Fri, 05 Sep 2025 03:34:45 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45b9c5c89f2sm137991255e9.14.2025.09.05.03.34.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 03:34:44 -0700 (PDT)
Date: Fri, 5 Sep 2025 13:34:41 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc: Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>,
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] kunit: print a message before triggering a NULL dereference
Message-ID: <aLq8wXJraE3SBPnP@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

Print a message so that people reading dmesg know that these NULL
dereferences are not a bug, but instead a deliberate part of
the testing.

Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 lib/kunit/kunit-test.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/kunit/kunit-test.c b/lib/kunit/kunit-test.c
index 8c01eabd4eaf..a8b6e16f4465 100644
--- a/lib/kunit/kunit-test.c
+++ b/lib/kunit/kunit-test.c
@@ -119,6 +119,8 @@ static void kunit_test_null_dereference(void *data)
 	struct kunit *test = data;
 	int *null = NULL;
 
+	pr_info("Triggering deliberate NULL derefence.\n");
+
 	*null = 0;
 
 	KUNIT_FAIL(test, "This line should never be reached\n");
-- 
2.47.2


