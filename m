Return-Path: <linux-kselftest+bounces-17502-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 184BA9710BA
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Sep 2024 10:00:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 447781C2219C
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Sep 2024 08:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EB591B4C3F;
	Mon,  9 Sep 2024 07:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O/txuuef"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C47C41B140B;
	Mon,  9 Sep 2024 07:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725868624; cv=none; b=ZNPaN3zWAWMFvURaqD/wyBSQbyMuFZzezdnJ9G7FIX/HwJ+7oHNxp6PY41I1OH1/2UEffMDx6gKpC0RiyoagrN5Oy4v14GGIuinZ6UfMVKhNDail4HPHkcCbopbTsVTHMk1y1Sn7lkiWIsSAjK8sDu0luQ0yqQyBieUshzMcgUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725868624; c=relaxed/simple;
	bh=ScXljYfb4gZ0j4RvtMPh0B1lEYoMVRDf4adoO8flAvA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ka2rRfe+Rr5O5rHufYcPcrbAq2LAJEKnuGgBlhGonZvMiHfSmYIxWN0mtEVE2FSWHfwFzXnqOAQrysOtgqO17QjU9+PSGVegjGsX/TCek3JEhIaPDwc7CTwT5vGEsAsrXw5m8fM/KedicMGtQEmJbbMmfQViP+vEtoaeC2gC3ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O/txuuef; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-42cba0dc922so1929215e9.3;
        Mon, 09 Sep 2024 00:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725868621; x=1726473421; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yJ+e64efHlSgzeDsuneltxPlkbdvNmJYnADy0syd420=;
        b=O/txuuefvzbEUOQc8iWB9guNVMwiaM0g237Rg34jvn/wv6FzHe+0sosU/oCQypAP1p
         Z78bOrkS7ptwvY4qbMomioX5jg2iLVYS7Q5zSuXjxcvYWuzl796hfajeC8Vmln1yM7K1
         jYkqK1ejEj7k1mAYlY9jva5WDSef40jC5xvMfDj+SDtA0iQ/IqrPxaWk/75De3KztcVt
         gKVW0d1NjjLOgQwMfq0bmnAaaGqZ8yrNYGc8izDAOmb2tgz2XuVW6DzVL/JvsBxx6CNy
         zxxhGrTtGkPIp3CLbX/kl2LIZZm9sVhNl3USzhiaG+L73aVokSm+kJ4AX1DO2gK/JGUB
         ILJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725868621; x=1726473421;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yJ+e64efHlSgzeDsuneltxPlkbdvNmJYnADy0syd420=;
        b=OfFYvGy7yLuKmRJVg/rxQj74HT3O+vFLH8v8hR+dWBnZERpcrvPXwJ2Rk4ENFVSM2a
         6lAkNClobGvs+Hm++BDabUQhfJ6KxJ6b4KCt53TMeXtRIEKpEyU7xMfMRvGWgXyC8KfW
         s50XBkfw8fcgZW2WyOnC5rOsyqHPGax2o/Wrj7pnzslv5TBuK+zUcdSBKjdRogW+yuJV
         hR4d2XtCUkHYR1b7huSYI/u4F/aN85ETRESirz9zUgoNr0edSPxIy/FqHlZVkFl71BPp
         8BMbU7pMm8Ddbe8xzAzH5Il/0cHtwbUE21Mu9natHGtke5UjdFoIM+dpwJAGR9rCGx/g
         EhpA==
X-Forwarded-Encrypted: i=1; AJvYcCU8Zdx3A1JfyCmB9JGcj2sOvNse4KMXiYK04W482C+zmdHPXyB186IM3WQgmWcCT5Di0mj3dM6V7/gvmQ==@vger.kernel.org, AJvYcCVSSlc0WLqjTf5O9qNhDgL8h+IJ4lD6qlOOidOYaqoHef84dYxECuf51UuNNZf+urPto5HVv0o2XB8lQ5ChWA==@vger.kernel.org, AJvYcCWnMAH3QRVrJ9mwNWjIbGrR/9VTZhmOJEw0RqiP6RFPSuFpsyeBM/zQFaNshm/tMaijE+eLmr2u8C/tYtup@vger.kernel.org, AJvYcCWnR/43e3EKoCy7V+uzM0VUL7fJpzXstiFskiGzzQKjDI7gjeY4irMF5NjSsblUxBoS87C/i1rBhDor/Te423u/@vger.kernel.org, AJvYcCWwo9iiA6E0yP6JS3tOgyDRpIzm++XY3s7ALXMngmgd5Fjm6mGzk1+fuv7slOWSpEbXkvteyzSKgcwXmzg=@vger.kernel.org, AJvYcCX7waGDHhKW2ktHRIQ7fYmaHBMUYdGdyjq/zjWSiaqvJxoStdY6Iwi+kUyN7K2FU3YuIG5TLu04AeWsW2/X@vger.kernel.org, AJvYcCXh0Jjpy3PwK2HBaHSPmDSwUvbFo4Og9KfG4FpXu5EV499hI3cZwaAeLCbRQ3tRYcR4txM=@vger.kernel.org
X-Gm-Message-State: AOJu0YywIDgWu2wjEmcP30xKcfYhbqfo9uZ0WlRUPIS1gpF41u6aYlk/
	ErHMy163fYNUCuIHXf0Ez76EmvuLH2yUkSmQHDYV9J+J+hFjIRAr
X-Google-Smtp-Source: AGHT+IEqjD0pfE9Tv+DdK7SKAV5je4YjRSRbb8e9vECs6S3GOh1jf14emjKYBkmnsY1RroQpxtUgAg==
X-Received: by 2002:adf:f64f:0:b0:374:c977:363 with SMTP id ffacd0b85a97d-3789268f0a6mr3668337f8f.24.1725868621057;
        Mon, 09 Sep 2024 00:57:01 -0700 (PDT)
Received: from fedora.iskraemeco.si ([193.77.86.250])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37895675b7esm5303001f8f.50.2024.09.09.00.56.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 00:57:00 -0700 (PDT)
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
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>
Subject: [PATCH RESEND v2 09/19] bpf: Include <linux/prandom.h> instead of <linux/random.h>
Date: Mon,  9 Sep 2024 09:53:52 +0200
Message-ID: <20240909075641.258968-10-ubizjak@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240909075641.258968-1-ubizjak@gmail.com>
References: <20240909075641.258968-1-ubizjak@gmail.com>
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
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: John Fastabend <john.fastabend@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Eduard Zingerman <eddyz87@gmail.com>
Cc: Song Liu <song@kernel.org>
Cc: Yonghong Song <yonghong.song@linux.dev>
Cc: KP Singh <kpsingh@kernel.org>
Cc: Stanislav Fomichev <sdf@fomichev.me>
Cc: Hao Luo <haoluo@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
---
 kernel/bpf/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 7ee62e38faf0..3f0d1eb7f5b0 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -21,7 +21,7 @@
 #include <linux/filter.h>
 #include <linux/skbuff.h>
 #include <linux/vmalloc.h>
-#include <linux/random.h>
+#include <linux/prandom.h>
 #include <linux/bpf.h>
 #include <linux/btf.h>
 #include <linux/objtool.h>
-- 
2.46.0


