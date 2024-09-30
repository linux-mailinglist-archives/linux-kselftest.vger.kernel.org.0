Return-Path: <linux-kselftest+bounces-18636-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CD35398A31A
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Sep 2024 14:42:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F2217B28246
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Sep 2024 12:42:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3600E1991A3;
	Mon, 30 Sep 2024 12:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nbu4C9dU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C0B9198A19;
	Mon, 30 Sep 2024 12:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727699849; cv=none; b=k/O9NdhiL7weSy3HC6oI6EHnJALSPGbtpdBvz01ZKDKLo7Ca2RFYsWgnpvD76L5y7jJ0LJOrZJIoUXDIlfgx5Qxr8d0F5Tz2MDd27w9DxjijGXIYcKSYaNYBhCoVJ7wmwIS4Ix2/w77pOmc8/JN9YnnZcYLNXYu/16VOe5dzczQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727699849; c=relaxed/simple;
	bh=JXmWlYvKlWWXWkkd7/pKR0/0o0HW3ylekaxJG4aUYT0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tMJhHwJMYvASBd5oilb2LoP/kqEhwFVEUm0K8i1pVj+Ol85fMZ+v41IYsOXH+VfSyzVqPkQrdFq8cQRYzPozTuHPr9CYbMfxDeeox2ADXr3++sEu5XkzpmJFcvIvnKkUqUSlqk77rReHqI+C/kU4bwKJ2GQ6hFQTTRUv82vJKwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nbu4C9dU; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-42cbe624c59so34208435e9.3;
        Mon, 30 Sep 2024 05:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727699846; x=1728304646; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=padwceDith9kH638WiD07J9lxW9cmsB/QyloZLAGT/8=;
        b=Nbu4C9dUcx5rmTK5HEOSdc5bd3KRst5hUN3U0mqA6J82fBOhbXFbw6/Bk7v8ESlDRA
         60m+7ZYblJLl3F6ZgQ3VMbUu0WxfNQzA3Hfcq5ytHMoSNoTmGLUpcif7yoBxDibcbp9I
         5mV8Rjo1YkpGNDBdm3w6m2OtBwRIu6SanF3cMdSAbKshWuj3b98/pMS4Bw/0lSVjv1rV
         wPM57kTKXoyM5jYX8KzIHcQIV9iRtejjuTY3mGNuoLZzi3gD5787sXp5wI1MN1bkK+dL
         vWx2wVMHoQPDmbVNOANdWmUAH7fEC+7jttXMiuUmesCeZ/Iwh8/NOKRWNXekHHEoJg97
         qJiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727699846; x=1728304646;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=padwceDith9kH638WiD07J9lxW9cmsB/QyloZLAGT/8=;
        b=bGqlL0AEefDqD3yT8QG4Fn5h5duBmlGU6zVTwHIltkQKMetWtCSzWejt2xf3yHhVDU
         rq93toQtcABWvAfB6xbsM9EuM26YCu/HDcZV2f9kXtSaXJe/tN/Yx7Ih8w33RZ9pHyfY
         ZrdhSMhp8aB5M4+PM/8SzcSu7BLSKGe1KSyDATUuyxfo09XJIsNJb/MtLcB3GgBgNJxg
         vh/wx1HygIZuAcL6sNMJyoRFBlvbXPRcOjMzUa2sHLxFVGzr8Z0PeVDXKwiFmdNvvQs6
         DBonLPvgfhrnOGXoX04s6yUENINLsElVLkOWGEO6fCr3X81IPXuW1qLLe5BO3BOn+c/I
         9ijg==
X-Forwarded-Encrypted: i=1; AJvYcCUFbO71/eEVYQTeNU3r135iF5llVgeS23V21q5P1hFfVyfd+CfDkJTDSKBIeok8fdkge/ovHw3sStRelQ==@vger.kernel.org, AJvYcCUkgEZmVBgnK589wP9DYv7kEUN6lrq13yQjI5c05+UCAXwuiYgY7MSgaDAcNSm+4stHwaYckg1edAAcZBWL@vger.kernel.org, AJvYcCUmWKhDbqUTqHJalHzq7IcgUHCmjwjgthWdxc9ni43qd+7Xi4aqoLXrLrQrTk5orVjn0e4=@vger.kernel.org, AJvYcCVmBccLCKVTV1sP18zyqrmHr7t1mu0pxUbg9Sc/02P0MMQLUsQ6UwkVAZzlWwoa1/vk1zKILJhE9mOQ68Xx4C9A@vger.kernel.org, AJvYcCW1dNO5cJ2raadwBROPYlBRz6OVP/EivD+x+mKXo7JhVFLfpq9k2TbtIg15jaYvOOPKlQPo+z91PDuNINqn@vger.kernel.org, AJvYcCWhy/D1NRm66UZEyvZq7/Pea8AKdQ0R00C0i8hyGsfzi07nHnImbnIbCU5CLu24zP6VqSPuoEadpKYvZaI=@vger.kernel.org, AJvYcCXTMQFSCTT4kXP1SqTfKO4Ekc5OpxJFYtdGhwyyFLA/6ghIPvlEY0pBpaWlijBP+jSbD/raVMybA1ZWA2cEBw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzEHjjdOyYgAEEnEg0aw5eEvWSTOFjMDqvpueeSstuhbFt3fd7U
	5NllWaZqZcAN//Er2qy+w7o1HbJU9OeFrHPUa0fqRD9UMiIETdhA
X-Google-Smtp-Source: AGHT+IHAZnkMewglqQ/9HzMtHISIRMWUmH9Pj6F7fJL+aYx8/KhkKe4NnWnDTfk2bHUTjX5xhdBmkg==
X-Received: by 2002:a05:600c:5292:b0:42c:cd88:d0f7 with SMTP id 5b1f17b1804b1-42f6df6d212mr10003285e9.10.1727699845853;
        Mon, 30 Sep 2024 05:37:25 -0700 (PDT)
Received: from fedora.iskraemeco.si ([193.77.86.250])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e96a52308sm149011355e9.43.2024.09.30.05.37.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 05:37:25 -0700 (PDT)
From: Uros Bizjak <ubizjak@gmail.com>
To: x86@kernel.org,
	linux-crypto@vger.kernel.org,
	intel-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-media@vger.kernel.org,
	linux-mtd@lists.infradead.org,
	linux-fscrypt@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v3 13/19] lib/rbtree-test: Include <linux/prandom.h> instead of <linux/random.h>
Date: Mon, 30 Sep 2024 14:33:24 +0200
Message-ID: <20240930123702.803617-14-ubizjak@gmail.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20240930123702.803617-1-ubizjak@gmail.com>
References: <20240930123702.803617-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Substitute the inclusion of <linux/random.h> header with
<linux/prandom.h> to allow the removal of legacy inclusion
of <linux/prandom.h> from <linux/random.h>.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 lib/rbtree_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/rbtree_test.c b/lib/rbtree_test.c
index 41ae3c7570d3..8655a76d29a1 100644
--- a/lib/rbtree_test.c
+++ b/lib/rbtree_test.c
@@ -2,7 +2,7 @@
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/rbtree_augmented.h>
-#include <linux/random.h>
+#include <linux/prandom.h>
 #include <linux/slab.h>
 #include <asm/timex.h>
 
-- 
2.46.2


