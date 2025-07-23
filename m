Return-Path: <linux-kselftest+bounces-37868-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 968D2B0EEC2
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Jul 2025 11:51:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 148197A2C91
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Jul 2025 09:49:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE99E288524;
	Wed, 23 Jul 2025 09:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DV43+gWp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13E0D285040;
	Wed, 23 Jul 2025 09:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753264263; cv=none; b=GDy3sNRTbUMfB7kfudfKkwOCgJm+qJVUu30U3YXmOMpdCKjmKRny+79Amv2x+/KQEbhu5k85DS4bLeBFpni9QqCOXL+e8HfNQZkRJUtBTdK4wvNkl0RLYOGcKZ2v66TKZbr9u+8Gc1pvRRhNETjKusxKzoxf1L8SbK97+UbfJEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753264263; c=relaxed/simple;
	bh=RlMvcbgctMmGyMnLIYsA9sWTWUwX4FGvqs83BDWKXCY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=e1/RItzqLnCjtD3/WTaOQgi0xWUZIoS5emXldq3LIiEr5jqxxKLWw+9EjF0QUu7CgXfmkJR8mhaNC08QhK9bruJ4vff0i5krVDL77sXHXgTbeo794Tr5vwxdssHSTzIgc4KX1zkoH5vyzaSxDJ9fqHPgSPxgdS+wqmfx4GsevNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DV43+gWp; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3a51481a598so3442743f8f.3;
        Wed, 23 Jul 2025 02:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753264260; x=1753869060; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9ZMzVfgVazaFJAzYrHIuEN/Gbih3lNCuqRrmR3G639Q=;
        b=DV43+gWpmoAslN9xGd+zRHJd9sP9NkRbplntfQt6AJ7IMe2ALTq2NveeSX9sI4gv7F
         jBXEQTos417AGUBXm0yYBuQ47srbCeKO1HhAbLcEoQtPex886iyo3ldCjbgnaSp+F9iz
         vsF/s4nQO9E6x02aMdDoAEJ1GPtGrWcGo7bvf6RC8AJiBRS0xJRR7oBA98FlbiER2zBq
         GBLYKgGnbKn2P1Ypevx3PVW5qV3EGXvwf1bMqYPcSvst6UW512RbPinOaDbhqPHPGJZ4
         FkSmFoeNLicX3URm6TsoIukpua5ibvNWvvnaPbFB+CgBt49B5uhqFLIkVuJthdswJ2DM
         XX9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753264260; x=1753869060;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9ZMzVfgVazaFJAzYrHIuEN/Gbih3lNCuqRrmR3G639Q=;
        b=xQErKpJB/V6OtlVTTFPufO1hj7tzrkvat6RVXDuqyFtyDUqiUPAVG3BHuaKlLcUMwW
         7sA0zqKjqlgeHbZFS60IGAggO9BNLoM+Bi1K/IRXzachs3H7xuIOcHIPE1PJHt/nLC4s
         UjhykLxjMYE7mNpH+1mj5iMVYv6y60mCqhaCfPCMH6SPtsWMrlY0QNsKZ4OWm5ekqnOJ
         N72FNUT7f/TnlefAJE5e2Ihfxk5+VTB78m1p7TM4Mu1e4acz97NlBTq20nGbaN7hpK/8
         I3s7ugrUa8uVw0h2fBLO91SjHJnmQt171Ipp++u7XhGjN/jIEYn2WyYc4R8htTGQCTqp
         pdTw==
X-Forwarded-Encrypted: i=1; AJvYcCXJ0ByWgIyaKb5ynTx584awqHnJmRZFhOq3vYZt/HVnVTFLQyckMaCdLj6qS/YHozHly5C9AU5Q039GRJ8=@vger.kernel.org, AJvYcCXKgFIGp6h9ZhU3HaKuIeAZzzPcA7ZKa8ONwKLEw7auwIBW73AZFOhZsQlnxUW4efTNIR5RJ6YYm9pAzpz0r7Rc@vger.kernel.org
X-Gm-Message-State: AOJu0YzkHIhgE/fpEDe3s5AbzxrXqjD0LogMGg7oZMlQOTAkh5NTuqnV
	OIis8h+4VT4isdO0wG/DatStBQ+iMnsYbH1zmC5YDn09HqNlc1/xE9A0
X-Gm-Gg: ASbGncuqVPtOfQf5/5miiVimzxwc0Y1wstrs815wSdDt1xvZ2MFqoOtTCF4L5Atsqdk
	XNoWF87CGWIn0HoZXaeECrlVioi4AqnTx3ObQtJOuzZLK3dS7PwWlO7AeLnJb7o0FkbjSdBZOI3
	DJW384wvKdRXtiQ/tFqVCNf3mTmRjNDVxesW/QXuYD6w6+mzJN15BPbN009orb0lVfesFtqkMpW
	rEF97dkyCOcQ5ZSjwXf92YStSwWg+Rhyv1Y3vpteScTGtmmU+dlNfK39W6miY3O8cMV9TXJ7f0I
	BjlbSX5aSt+XUyFkZeTr69YAEgXFMQ7HCbhl/Itych5bQGw0+KCvU5zgR6pMT3HBhjF51nmQbQa
	hgIn3RXvEX+SvVOm+SYVR
X-Google-Smtp-Source: AGHT+IFYj/ZHoVPwCQEBnuRa1FRBb7f+LGF2/wD/iPkl2oqJC2a3kqKCSYyK1/tiu0v3EbYr4ZdR7w==
X-Received: by 2002:a05:6000:4028:b0:3b6:136d:55de with SMTP id ffacd0b85a97d-3b768caa42fmr1942681f8f.7.1753264260184;
        Wed, 23 Jul 2025 02:51:00 -0700 (PDT)
Received: from localhost ([87.254.0.133])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3b762bb4f6csm5464974f8f.4.2025.07.23.02.50.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 02:50:59 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] tools/testing/selftests: Fix spelling mistake "unnmap" -> "unmap"
Date: Wed, 23 Jul 2025 10:50:27 +0100
Message-ID: <20250723095027.3999094-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

There is a spelling mistake in ksft_test_result_fail messages. Fix them.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 tools/testing/selftests/mm/mremap_test.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/mm/mremap_test.c b/tools/testing/selftests/mm/mremap_test.c
index fccf9e797a0c..774cdba102fc 100644
--- a/tools/testing/selftests/mm/mremap_test.c
+++ b/tools/testing/selftests/mm/mremap_test.c
@@ -525,10 +525,10 @@ static void mremap_move_multiple_vmas(unsigned int pattern_seed,
 out:
 	if (success)
 		ksft_test_result_pass("%s%s\n", test_name,
-				      dont_unmap ? " [dontunnmap]" : "");
+				      dont_unmap ? " [dontunmap]" : "");
 	else
 		ksft_test_result_fail("%s%s\n", test_name,
-				      dont_unmap ? " [dontunnmap]" : "");
+				      dont_unmap ? " [dontunmap]" : "");
 }
 
 static void mremap_shrink_multiple_vmas(unsigned long page_size,
@@ -727,10 +727,10 @@ static void mremap_move_multiple_vmas_split(unsigned int pattern_seed,
 out:
 	if (success)
 		ksft_test_result_pass("%s%s\n", test_name,
-				      dont_unmap ? " [dontunnmap]" : "");
+				      dont_unmap ? " [dontunmap]" : "");
 	else
 		ksft_test_result_fail("%s%s\n", test_name,
-				      dont_unmap ? " [dontunnmap]" : "");
+				      dont_unmap ? " [dontunmap]" : "");
 }
 
 /* Returns the time taken for the remap on success else returns -1. */
-- 
2.50.0


