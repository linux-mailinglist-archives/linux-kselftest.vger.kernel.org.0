Return-Path: <linux-kselftest+bounces-5144-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A05185D398
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Feb 2024 10:31:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E77AD1F23ADA
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Feb 2024 09:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43A0841202;
	Wed, 21 Feb 2024 09:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D6FVsTD4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 686F840BF0
	for <linux-kselftest@vger.kernel.org>; Wed, 21 Feb 2024 09:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708507707; cv=none; b=ATOQG0JkT2CvDRDMaMcjg9yzR+jSlles9imAXwJkcCpGaz4Zqzr2k+qKTInZ9Ai1o5XYc9DBSg2bfBOGB3kb17NuzFP+jX3MCpCvw8ppycRq8IiN2AvuHTJDJhOhYduiNyvlNXGAM50Yqc0vVcjVpJJ7AlcdZdvJ8uOI0igCA3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708507707; c=relaxed/simple;
	bh=qMDq4bdbhpPxmFVNu5BAuMHikajNGQCbrs05AJS2Hgg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TES94FGTjN5JMX3B4lmSzurra4+FtjrKU/eZUgjiTIinrXeVt0eea1abANzaG2Oxrp6fg2GvYMh8go1D2hi62ANhsaMXm6F2iPXf2U2QsLztMCvV/jck5hBqC2ERgpi0rQ33sCtrqRt6xJ85+zmOtjBlH6QWdK4a9kLSsRukygc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--davidgow.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=D6FVsTD4; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--davidgow.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6085e433063so33695127b3.1
        for <linux-kselftest@vger.kernel.org>; Wed, 21 Feb 2024 01:28:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708507703; x=1709112503; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6oh8w0yc8LvH1yvSHI8zU+2R7q+ewyvFM42Am6pdhYA=;
        b=D6FVsTD4raEeATxpVZ6Qcyn+x0avEjJx8xgJvJ/z4iE0JjaKunjA/Z82BKNy+FzkR2
         lp+3qO5dhnzsfc/dM+z2pECqaOjIQ8xuKlLxZGEjL601epK+6DDd3REFZfSGOt+D/HZM
         QrcMdWaNT/FVPNhZzCaV7aYI3WB+sPL2iR3DZG4z/wBKBkUExn9I09KyWYjc1rEAjpLG
         kauIplsgkQBLM8u9xwfvIXKs7VSVVqvEg0N0sOMlCRsSrHY+jA3+sukTBOcT88jfJ9ma
         2xW1OkO6ZTe6kq8rb096JA8P0VnVHqwLbFWTDc2NCFK2vAaUykNlfA4u9AFqM0ob82Px
         oggw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708507703; x=1709112503;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6oh8w0yc8LvH1yvSHI8zU+2R7q+ewyvFM42Am6pdhYA=;
        b=oY6dnD4aoOQNP0IbiazBmNxilhiI+dZ7gP8ZmyuqbI8LLbzHx1j4Y5AGvm9ET4mEz+
         Ui/ETVAv51IwQWaPtZeGHUJsQGYb3FAaeX+7f9PMDcvqtVp+7PhLxu4GsDQd7vF/dcfP
         eLpn8WBtonbNXdllzE9GVQeuFXJdM2s7tFTyL/TxAa4Nfv0SWWQFoEiklk1W8qeJ55Xr
         snTgK32mwSKx0R4jE1sizGE9YJ7Q2mhlB92gumy96BlKhExFL7RniskPoXMt17zI0GnF
         lTv6Ti2jGqzj034WRUl4UYRp7dXIhib6REpxWIj5Hlagy501hpyF6AnxIfAzFIaMDfQM
         3ypw==
X-Forwarded-Encrypted: i=1; AJvYcCXCzpoLFL+GlQeqVSU9NdF8yE21SghzDa9Ha1aCAAzJjYzjnS41PP6kCSO3dM2t4iow3XycAXAWfVZQFF8H1ygotqcb+0ryJizNNe2qtqj7
X-Gm-Message-State: AOJu0YzPOyj5F58NNNi+TANPRFgnBFhXMY7BTGk2sPx05mRGBZElbRs5
	cNHajhe12ZShQnhUZCwMzEsPAZ4PKsUMPbSen2eUIOwqkfMnGOJT9mek7Ay6/A/8zJPHjV+Y1Vz
	pHj+VTzuurg==
X-Google-Smtp-Source: AGHT+IHAVxan3IBdGfT14ZlxAMIfrkzUxv01ETxOcEryam+Wji8MbAhrWelAxlNmlmHCaTgl78twQW5eAT/4hw==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a0d:e8c4:0:b0:607:cd11:5464 with SMTP id
 r187-20020a0de8c4000000b00607cd115464mr4264994ywe.9.1708507703514; Wed, 21
 Feb 2024 01:28:23 -0800 (PST)
Date: Wed, 21 Feb 2024 17:27:18 +0800
In-Reply-To: <20240221092728.1281499-1-davidgow@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240221092728.1281499-1-davidgow@google.com>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Message-ID: <20240221092728.1281499-6-davidgow@google.com>
Subject: [PATCH 5/9] rtc: test: Fix invalid format specifier.
From: David Gow <davidgow@google.com>
To: Linus Torvalds <torvalds@linux-foundation.org>, Shuah Khan <skhan@linuxfoundation.org>, 
	Guenter Roeck <linux@roeck-us.net>, Rae Moar <rmoar@google.com>, 
	Matthew Auld <matthew.auld@intel.com>, 
	Arunpravin Paneer Selvam <arunpravin.paneerselvam@amd.com>, 
	"=?UTF-8?q?Christian=20K=C3=B6nig?=" <christian.koenig@amd.com>, Kees Cook <keescook@chromium.org>, 
	"=?UTF-8?q?Ma=C3=ADra=20Canal?=" <mcanal@igalia.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	Matthew Brost <matthew.brost@intel.com>, Willem de Bruijn <willemb@google.com>, 
	Florian Westphal <fw@strlen.de>, Cassio Neri <cassio.neri@gmail.com>, 
	Javier Martinez Canillas <javierm@redhat.com>, Arthur Grillo <arthur.grillo@usp.br>
Cc: David Gow <davidgow@google.com>, Brendan Higgins <brendan.higgins@linux.dev>, 
	Daniel Latypov <dlatypov@google.com>, Stephen Boyd <sboyd@kernel.org>, David Airlie <airlied@gmail.com>, 
	Maxime Ripard <mripard@kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	intel-xe@lists.freedesktop.org, linux-rtc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-hardening@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

'days' is a s64 (from div_s64), and so should use a %lld specifier.

This was found by extending KUnit's assertion macros to use gcc's
__printf attribute.

Fixes: 1d1bb12a8b18 ("rtc: Improve performance of rtc_time64_to_tm(). Add tests.")
Signed-off-by: David Gow <davidgow@google.com>
---
 drivers/rtc/lib_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/lib_test.c b/drivers/rtc/lib_test.c
index d5caf36c56cd..225c859d6da5 100644
--- a/drivers/rtc/lib_test.c
+++ b/drivers/rtc/lib_test.c
@@ -54,7 +54,7 @@ static void rtc_time64_to_tm_test_date_range(struct kunit *test)
 
 		days = div_s64(secs, 86400);
 
-		#define FAIL_MSG "%d/%02d/%02d (%2d) : %ld", \
+		#define FAIL_MSG "%d/%02d/%02d (%2d) : %lld", \
 			year, month, mday, yday, days
 
 		KUNIT_ASSERT_EQ_MSG(test, year - 1900, result.tm_year, FAIL_MSG);
-- 
2.44.0.rc0.258.g7320e95886-goog


