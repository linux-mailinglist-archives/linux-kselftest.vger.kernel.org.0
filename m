Return-Path: <linux-kselftest+bounces-18375-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4891A9868BE
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Sep 2024 23:56:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A75E284335
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Sep 2024 21:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 453F117C9A4;
	Wed, 25 Sep 2024 21:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FY6s2Tpe"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4609017BECD;
	Wed, 25 Sep 2024 21:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727301330; cv=none; b=pbuIo+J/zn2hq4llPv6Wu+Qis6YAC84iI9hFcEBRm8WNCxHn2akgZY50Jt5F/hWbsrSKZuZZuPg8gM4l4y9gnhHBe+jWY+fYHlQmLTis+VTos1hXKa3Wi2YR40NXlwcQ1h3sHHXtJc03QrvbZZ3KlNVTJDc8eQSHvPCYn5KsIZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727301330; c=relaxed/simple;
	bh=xNHnyhJFePMRWD0xmlV7oaH2NuiwOtkciszm0bIRYco=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qeI8RPrpTNso7asEHn+i4tTcgUPyKUaWysHCPSbCJSvPuZEvbl+/Cu4NvAPbB4/bJ3cS0pTCuZNasb90W4vzX5v40PaB4ERfoQVPTKZZjM4l+B1yAIYZtWVp3CvPNZzT6/fzUSu7TCUNZdGmXUz9Z6K5z6pRbtfJUXSauaOcDOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FY6s2Tpe; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-42cb0f28bfbso2344305e9.1;
        Wed, 25 Sep 2024 14:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727301326; x=1727906126; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P0fLhVR1VuwGVirwx3qztf7J7hxhejcQybt+qUHv768=;
        b=FY6s2Tpew3jocA61YR/jksg4xkfS29H8hT9J7iNBI4Gly7QFmu53wezdzHutRUx236
         TsCED9gYzy3pQ+7iYQVFbVYIm1OEZz8HGMGyiWIFWKm5Am0SYRKLFqOF0X/KQ/I1CgzL
         CGBZhJWmmVIHwKIT2XIbSP7TbBLMzv7JubKEZj1Vv3CvHMfrNHpm2R6/14Nj6Z5B3BNo
         bSylfx4iRAd1ldjh4sP2E4ZtjTZKBL5naVOTWAyXZ3dDsZd+i5oinAeFIyCtUtKCLn7U
         CHEHbRQ7WDpSZjnJarfio8Ltyoa7rUIdIoYtBQ9NhKSVPfh0l4DHRlCMrVeIM4Zqi/CJ
         DzyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727301326; x=1727906126;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P0fLhVR1VuwGVirwx3qztf7J7hxhejcQybt+qUHv768=;
        b=iW/9Kijw4vIxia9u8JuuCB6KelAI6Qzyp2RUxLQrSLJxmzCmXqKQaAVJSONKba8cpx
         4hqGwIMzlHae9tX0lRt5uLuRQBkV1t91dgGpH4gUArH5C7LhyA3PDBF3KgXqLDfJQDBR
         tuACs+aTR1bjqYqRXZDr8DMD7GUY6zI0YAD/Ng6oxEKI4KUJ1sFKuUb5S8FCBBpCfNjy
         Ft6Oybt+EpyGYGk+ab6aI/PaqAi7dphnz6rj1DHoe1DK+VGwQUi5mIyJPQu7+TfU8zfn
         hlB0Jo8MrtCKVidhQs8pw5WXCQQ5Ce2y+uPc/Zu+zqQCuxF/axDJHKHg4mvLm6kK9ajA
         /MyQ==
X-Forwarded-Encrypted: i=1; AJvYcCUejZ8o3l50QaF5d8uXqKTSqcsmcNtKJbFD8uMTqV8669FP0jqgHHQtequVgw92/c/HeCIoxky4Q7ygeVE=@vger.kernel.org, AJvYcCVyI+ooDHhzj4Iw7w6WDuGTTtWkU7enuDgHA5dvyOb9dpuMARUL3QY8j3TN1z4il85WXsMpYBWKoYuVNw==@vger.kernel.org, AJvYcCXN1lhKxmBn34GX7IbEJqM6j9ySynfyODIAwr6ARXbwX0kthY4TqZcT3j/a1wI+rJKYxCbGiVJB@vger.kernel.org
X-Gm-Message-State: AOJu0YyEvydd3wu4tpExMfAXQWNfZVpkR91T3XaOCalDFHCySJMPXqgc
	XsD+N87O0IJBX+TAcfxHeQxeVxYoYdfkze7Nem/tQ2wNeyI6KFJto3W2Kgzp
X-Google-Smtp-Source: AGHT+IG1A4qoRv7SMd8TNBfNShqHENauldGMjLafpbzcFd89l5bGejQRfF1SUyqBvLrbEb3pL+eolA==
X-Received: by 2002:a05:600c:468a:b0:42c:b950:680a with SMTP id 5b1f17b1804b1-42e96119222mr31749075e9.20.1727301326063;
        Wed, 25 Sep 2024 14:55:26 -0700 (PDT)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-370b-ca26-d622-f1c3.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:370b:ca26:d622:f1c3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e96a165fdsm29129385e9.34.2024.09.25.14.55.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 14:55:24 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Wed, 25 Sep 2024 23:55:13 +0200
Subject: [PATCH v3 3/5] selftests: rds: add include.sh to EXTRA_CLEAN
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240925-selftests-gitignore-v3-3-9db896474170@gmail.com>
References: <20240925-selftests-gitignore-v3-0-9db896474170@gmail.com>
In-Reply-To: <20240925-selftests-gitignore-v3-0-9db896474170@gmail.com>
To: Shuah Khan <shuah@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Allison Henderson <allison.henderson@oracle.com>, 
 Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org, 
 rds-devel@oss.oracle.com, linux-mm@kvack.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727301314; l=849;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=xNHnyhJFePMRWD0xmlV7oaH2NuiwOtkciszm0bIRYco=;
 b=vz8jjRoq4DHDHn378Xzd8ACYHEVLweQLL8Elx5Htyz86Sk2ekse1vxln0je7EuVbWKFUWOfdd
 uuHzNW4hsi9AWHeaT2Ab+wv9tdU319btAUKvw5brgzymvXspMT4GbG7
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

The include.sh file is generated when building the net/rds selftests,
but there is no rule to delete it with the clean target. Add the file to
EXTRA_CLEAN in order to remove it when required.

Reviewed-by: Allison Henderson <allison.henderson@oracle.com>
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 tools/testing/selftests/net/rds/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/rds/Makefile b/tools/testing/selftests/net/rds/Makefile
index da9714bc7aad..0b697669ea51 100644
--- a/tools/testing/selftests/net/rds/Makefile
+++ b/tools/testing/selftests/net/rds/Makefile
@@ -7,6 +7,6 @@ TEST_PROGS := run.sh \
 	include.sh \
 	test.py
 
-EXTRA_CLEAN := /tmp/rds_logs
+EXTRA_CLEAN := /tmp/rds_logs include.sh
 
 include ../../lib.mk

-- 
2.43.0


