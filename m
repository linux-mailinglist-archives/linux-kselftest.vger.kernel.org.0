Return-Path: <linux-kselftest+bounces-18632-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EDD798A2F6
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Sep 2024 14:40:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFFB21F20F42
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Sep 2024 12:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 565E518E36D;
	Mon, 30 Sep 2024 12:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UbdfhOHk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87E4A18E357;
	Mon, 30 Sep 2024 12:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727699844; cv=none; b=AHSQaTlkQS+pYikvBxRPJsvKYFaVRDOwygby7YQNLV/o0eoGMXzOmy+rVaF+kHvaNnSbP87qazSqLyii1PqZRSjn+3pCgtB1y1KY7VE3zrl678Am0pWvUkLU9rvs24OEAuxOAsRYi8XOr/WQRI/04IDnIwpXoJGEcyvuZomzT1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727699844; c=relaxed/simple;
	bh=8jyPgz6zWJ1sNTz01vhtz3c/Pp+liTlYl/iGlSwLCdA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GZuviF9oL2OBohZql/pg7NSAvC06Bp1245cTAlW8bFL5R9Cfg/Yklx2adLMv5+vbJnv2tMsgg2YRvQxH2IUq+uCYSqYa70dvIKh84v2hQoCak+KoKVaMyQst/A49jRzTguOSvm6C0MIaiq2tA2+Qi3SZDtJW6NosJAbjr1jQ5Vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UbdfhOHk; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-42cb1758e41so31426465e9.1;
        Mon, 30 Sep 2024 05:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727699841; x=1728304641; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6rs5JfkaX4vjLfXsqAZRoDkbs0NL2Tu6uf8tfOBZdKA=;
        b=UbdfhOHkdV2cA6eBiPM4rfOcVYLQY9MPSmaGp42+ORqdNjOKFOqkv3DE7uWKSJDOod
         8y8fwF/gheReePkhqS8OYCg64dgMFeZThSYE9ZSbUXJWXp9wXw26IB/DF6/MONKawwk+
         QQOqN7Kufo1J3AI59lzpMScRJsyr0iavjcRUkxLDjHaulXko5Bxk5oIqj+InOEpoA/54
         3+Rkl1JZGpruvKXYEst+B1/6OONDupoOkjVVEtl6ML/ojx5BBR5+sPCWZPc1OK9B1npX
         v8Y/SVWzeaXtaCcnS6ZxmWaXPSbyJGtJYh9969Zo2TBsQE4aJamohuAVcflj4YbzZ0SU
         ISWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727699841; x=1728304641;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6rs5JfkaX4vjLfXsqAZRoDkbs0NL2Tu6uf8tfOBZdKA=;
        b=tC3opvjPVLnRQbePBj5SlI8bOOp0wvayW5fRg/P5/2ycZ7hVGH9JKLx7aGfxo9ByO9
         ratExSGDKlfnVOrQq7v6Z8JyamfcDnL8b1IZVzkK6u+L/LIemmVfOgBzAp/LBjgg3yJU
         FY6R59GvAEIl/7lOWKvz5zH1Gf/k6sjaEZ1+TS1FfkJ9GMmX8f+NiCBTJoQJYr30i7Z0
         SLepYFhg0DxwG+kArFoQGZwqnkI9nzedGdskjdb4E7hEx9ZeFIXVSzPEJXiJxhu0RjW5
         ++fNIH4VaDC2gSt2BDxFmyAv6IxaUHjm3uWmoe7/HpZ6lZC2AfvuhDUwgpFRekYEUNih
         gRiQ==
X-Forwarded-Encrypted: i=1; AJvYcCUAgZtnFsSE0UznfQbITPf/gBLD+4Ffq/qWU5W3pQmM9lbdubwOzIuIvBH5y37eUo5JNRlUAoAZ4pmyTk4=@vger.kernel.org, AJvYcCUJBH5+9UXIdC9+xHZGvBEpEacf+DG1stF4ReyphCTRlsUrXvS5GSgSCWiJMIslifyVmfK69fqGXtF6hA==@vger.kernel.org, AJvYcCUQhSGEyQKGikPlle/U3h9fgWURB9jlO/StqQtZODYfBj0rBTA4+kz6Nwi+NYcztnn/+jaDAMZFRAiUK8Vr@vger.kernel.org, AJvYcCUqwXpPHU9aV7QOOS0zOmGu2aFVEtQFrDACnRC9vJZso9zsDQAon2+gUflTkxicPcONkrk=@vger.kernel.org, AJvYcCV7P5bNRHmQt4CxyjcdTGKSSAdK4GSSW9gJz7ng+rCM4J+1lrfClAskqJA2uSgpfPMrZQyIyp7V4HL8C532@vger.kernel.org, AJvYcCWDO86cPFPidA2Mm+2NNN2eVO+QBnbA6fab5VPmZVm7rdglzhMYgO3iF7ddB7R4vvHYjrM1IFEh8ekNxFnyOUtJ@vger.kernel.org, AJvYcCXc2EJHt5BsQHqTWxNL/oMoFHkQfjjNSfqNZAJleOT3eOGZ3jKDOlftVtkCoPQROvJZDQjeuvKt8dpc2ll8zw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8rbWqsQRKi6rNMAUJ39l1onXg1k7Y8GKmuJx4NB0FrnKBS3og
	6tX7/YlBAkclKNEUjG6tc3bV1kzczT3VbKU119R3EmiDElxkCVaW
X-Google-Smtp-Source: AGHT+IFHgMvS9GhqstV2aQ3xEgJPZmWF5RO5X6f+ra7fPCRYNUY7uUx6XjXf5I/swT371oPEEJv2gg==
X-Received: by 2002:a05:600c:1d8a:b0:426:593c:935d with SMTP id 5b1f17b1804b1-42f58409f9dmr84281535e9.5.1727699840695;
        Mon, 30 Sep 2024 05:37:20 -0700 (PDT)
Received: from fedora.iskraemeco.si ([193.77.86.250])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e96a52308sm149011355e9.43.2024.09.30.05.37.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 05:37:20 -0700 (PDT)
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
Subject: [PATCH v3 09/19] bpf: Include <linux/prandom.h> instead of <linux/random.h>
Date: Mon, 30 Sep 2024 14:33:20 +0200
Message-ID: <20240930123702.803617-10-ubizjak@gmail.com>
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
index 4e07cc057d6f..66474021f84e 100644
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
2.46.2


