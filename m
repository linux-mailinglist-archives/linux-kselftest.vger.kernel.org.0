Return-Path: <linux-kselftest+bounces-44768-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 948A2C33482
	for <lists+linux-kselftest@lfdr.de>; Tue, 04 Nov 2025 23:42:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BB3E04EE73F
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Nov 2025 22:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAAF834A3BB;
	Tue,  4 Nov 2025 22:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G0ADkr9B"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2CEB347FE5
	for <linux-kselftest@vger.kernel.org>; Tue,  4 Nov 2025 22:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762295961; cv=none; b=JHWcRmOCTZV0+3oNY+x6d/HAh64wRQ2kQB0cnmorCB99HGp0fpsTztK93Pw28mDGgvgQGAPMNtUTK17ytvj4U+q3CrbcxPNkmIa1f4LeumqCri/Hx61wNRuoxnXYHw7do4+7Bf3EI1fmDhxrLzvH3ss9+LuD+2qhxC5vwU4oUhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762295961; c=relaxed/simple;
	bh=XlP32tEwpZirdMr7sqd9mNrUqkac/qnWShul7Fw9yow=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ajgtjq1G1Uy2fiAZnPi0LyPS4q4/snGqxs+rm3f+QaXQhIfHkb0Wkzpfsl+KqMgbTxu5Q6DH8yfTiZCuQpRF+Et57u+HXo2Tok7wZb7Kjxp/R52rAbWL0rZ7w9q6XwAPr6PzkQ7/9ZB3EcZ6rN0w8Vk3T2A1fclcoHMKNuTCh0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G0ADkr9B; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-29570bcf220so42378335ad.3
        for <linux-kselftest@vger.kernel.org>; Tue, 04 Nov 2025 14:39:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762295958; x=1762900758; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/TRuhdOoSSGipeIAHAxq+HN65/ys/fdjImQ5W470jiE=;
        b=G0ADkr9B9NpB2Bim0ypTHP3Mt/+mWa4mBYdFMoZrgxG+XmDpZ4hxIQwde8PAioo9vj
         YzWPL8FeNcoFD23u2bvudw/FoErDIYepIqTHQGYgnXvZd+Yy2XdPBl9JEBZIfTzViE7u
         20/XwvC3PtnqWzZhKFLt2QpsT4Jb4Y3y6tg/xeN/sh9XPR0EGPg2RgMab7SaIPSttdMK
         OHNp5LZuPDjU4fHufrYI1mA3kimf8JACMa+ejHdhNWAyPLOc5qHmuCxQLXTZmc3HDy/Q
         94rr1MV5GJxDgVezXdBZUzW7K/V9WZXIe/Ea9FpIsWjpPMfLJFWa+jjjsKWtYd38diIh
         Mxgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762295958; x=1762900758;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/TRuhdOoSSGipeIAHAxq+HN65/ys/fdjImQ5W470jiE=;
        b=hyiHEEoYDKmhrFvYocryUIO61gdwFxifk7SlradTdZN+NQGLgBeapyBBJXdAe6OldP
         wl9m1sOXmS1sVQuNxOtziDmt2s4UcIkrHcrZEtkLzlHa7nr5qbYJjh7Q3SSG2Bj9utzT
         1utcbMApXbAobAu6aPDg62cH8lhpb+3fHIUzVYDdpsqTACE++GZrIfVFglr7d25sYupA
         fZvi7al9H0ehLbDIZbEF0vaat8EyuCWsAOCwkyIG8doHE9KVYRPQwRsAjmrFNJ8shqqC
         g0bzZXsd07ZMYYiEdBYc6Ok0g4jugCnUHvjW0+RVWfA9aCCNE8FNPZMu+/tOk3AMN9Y4
         mUJA==
X-Forwarded-Encrypted: i=1; AJvYcCVGIHT3iLBYrjQ84vXED5ASkUyaAPsX38U2LwuiB/p24kwZSVjHeus7c5eScOusTv6Ap1/fqwJnMj/I9tDzQKo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOJA4o8IkDpvA1CInnQ/Bt4q5bjBHBficeB8qdhwSQrpOFBziH
	i1F+SEWoXtD3vJTRO+DYjVlKhS9AsvIVmyX1CJY463yk/JGEZd1mj+uF
X-Gm-Gg: ASbGncuPss1kjJAWlajpQIdO1U53vG9oF4n6tHyyFGv/22P884bWepe/w8oZZXgBwwk
	poC+You8G5vJaE1x+XAcJbpMcanxgMJG3TE1ejuldibOEVRAhf58NwBfXUMsR+dg2lgbqlk/JhN
	9cYg1fdgl2ljrhnC7g7NOQUItqq2b8u/N2T/SdQlJF85l25DAsKZ78U9XpBYvbcpV6OyLaRBifN
	myo2ojtGPNyUoAbO0HgWWt8nUhzgC0RTHuBH1BjAUD+qqad1sQc/e8ffzkH3qF/uoZRqjrVl8ug
	aRp3ZGIG9R8hx0pByOJsoOdsooSLM4r4lZF8MeZ2eFg9nVMJSPbYZmr46nn10f/i4UpldeWZjFe
	zU4h6N0Iq+jhtAMZ5J6QqXgYYYoqFVhAIX097/e2F1PI60rDKQmdKnyJfaFBZNMwiDILWKW2W
X-Google-Smtp-Source: AGHT+IGkcKOy3RYFgLwyd/NR+t0Lm3XzaO4mSqwdUYhsWqQ4Xq3qCSzgiAZO/1PlUw5asRlhZe6BpQ==
X-Received: by 2002:a17:902:d488:b0:26d:d860:3dae with SMTP id d9443c01a7336-2962ad83389mr16923805ad.3.1762295958422;
        Tue, 04 Nov 2025 14:39:18 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:4::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29601972a36sm39341705ad.1.2025.11.04.14.39.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 14:39:18 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Tue, 04 Nov 2025 14:39:00 -0800
Subject: [PATCH net-next v2 10/12] selftests/vsock: add 1.37 to tested
 virtme-ng versions
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251104-vsock-selftests-fixes-and-improvements-v2-10-ca2070fd1601@meta.com>
References: <20251104-vsock-selftests-fixes-and-improvements-v2-0-ca2070fd1601@meta.com>
In-Reply-To: <20251104-vsock-selftests-fixes-and-improvements-v2-0-ca2070fd1601@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Simon Horman <horms@kernel.org>, Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.13.0

From: Bobby Eshleman <bobbyeshleman@meta.com>

Testing with 1.37 shows all tests passing but emits the warning:

warning: vng version 'virtme-ng 1.37' has not been tested and may not function properly.
	The following versions have been tested: 1.33 1.36

This patch adds 1.37 to the virtme-ng versions to get rid of the above
warning.

Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 tools/testing/selftests/vsock/vmtest.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index 3ba9a0dfdd01..0657973b5067 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -152,7 +152,7 @@ check_vng() {
 	local version
 	local ok
 
-	tested_versions=("1.33" "1.36")
+	tested_versions=("1.33" "1.36" "1.37")
 	version="$(vng --version)"
 
 	ok=0

-- 
2.47.3


