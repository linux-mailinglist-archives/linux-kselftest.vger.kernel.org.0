Return-Path: <linux-kselftest+bounces-38372-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE99FB1C497
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Aug 2025 13:02:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCED25607D8
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Aug 2025 11:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 955BC260566;
	Wed,  6 Aug 2025 11:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lNJk+oys"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1396920F067;
	Wed,  6 Aug 2025 11:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754478165; cv=none; b=oefTkx52x15YBEdp04xrT/jyQR2KJyZjbiRTWkKILB2vYZ3J1Nm8hut0FhCslOeSVhRs5M4aarfx9GDi4wxwlqka8cfU1G+Ac+tCbHqRwOZs7SQhyGWFwUyEMpaMZ7zw7FKgUMGe+kt5pQeVHxoLcwqv9dxTT9Uvk8Am+6xvcvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754478165; c=relaxed/simple;
	bh=fGwQvuZekVYWNVp+xHF2By/+OhCeDXLdr6UFjCBMrmU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Tl9xh8+4IAabuAyuimm/B8qyenuV+41KEgEeScupcGc3FPnj+B7K0Z/+KSSmAQhEP3P7otfmFTnUlpJS96z+MmjRnsjHTF9/HnTQRoT//uk8omVOVXr1wvsWg8P2dbMVkLN572g+LkCekXEkzDzryVBuwU2tsQhi+y7FAQ66VcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lNJk+oys; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7426c44e014so5901751b3a.3;
        Wed, 06 Aug 2025 04:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754478163; x=1755082963; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rnS6VYdGfdFt/krsus/FgbrkiOQovzavFwfxL0kycI4=;
        b=lNJk+oysPEIxA2BkMzFeaDgFAnNLy1VegqLvjQLQUv4ML6OCkKxR6Z0tE0WYxH9teh
         awzT/PVAdhbcYmzhhcMA9sqn49bnnDRSJqO2IPEnFm8yhfb21Woc7mDGiNyhyIVeiOG2
         1lsQUFUM+B/VZrr+KptSJFOoAD+tMFrxhEZJ/0/hMqfUAfj5LKq7qNTIFQqjv5ox8dbT
         IFkrNzaCfWAcDx7BoGQUmkLF7yn4YXaIJ/Rhj7PkrUjfap6yrsAeaZ0sSfBSn5+dBL7a
         lyTvL+GKoEn71az9Ypx1JceA3h6Z9SdQpz6T06B/k2vXwo3PkPWiUcXW+KhonjdBX5q3
         x6Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754478163; x=1755082963;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rnS6VYdGfdFt/krsus/FgbrkiOQovzavFwfxL0kycI4=;
        b=cQ/EzbnW8yb9NIB6rsNikuzqmsXS98m0WLl4l9iac8f4IaE7rg4hHFHrE0CG7YcZ1W
         WfJV94zhb0ctiShxaRNiSCjr/Kwo5bIdtY9sLBW7RMnxR6WB3tgEJjDUvVgz0lblEPj3
         aaou0JDk2DwR9jHzxwWESnPPbPudtvpoxMVPnOPetuNKM7vDQYZL6c8Z/bTjwxiAlwXI
         K5E6MWBWVEkaICBhj7nJCqUIY2uKdbhXFZMp+NrojSIUloWEOSl8bv327Y0dVS+YTu/Z
         tIUKrDnLQ9UQZi6cJxF2dmDntojbSBvadTWxlVSVyFkLBUaftsT4+WPKnj8V3vUh6is4
         SKFA==
X-Forwarded-Encrypted: i=1; AJvYcCUvs13vFN0mswKy7LTkRToB7o4XxsqQ0LTUR2iUCrqT7jXU9+R7TzlmfUIhEPY1G8ggBZXqKMeFjVrpn9Va73VI@vger.kernel.org, AJvYcCWsrQ2QLJlQgtDvQgTlc/hZIegceYCCvgMrPVWqhxSktFIaqE4ar53ke0CKKIAVlNX9chHhkSty@vger.kernel.org, AJvYcCXZ1kjUXjXXIqQooEBCMFksND6oPm3UHXL6zDBtR+wDy8H6SB4L3JZr0Ed948hdZaQ7avU8TQ5JrMpwDGH8@vger.kernel.org, AJvYcCXgCuAwuTDiuNllIY72F1It56AYXwyDT5S3SAqy9zdwNmpUHFW1dXc0U6AhU1Zm9oo8Jcc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0lI/HWcLmPJZKejlsEIjvKvxiVmOJnEYLMYMEyMcI0qO8ttDl
	aRxYtR+UBpvr25XLe/S01THwW7735yoQdVH4xCxL3DIy5RlF06gojdEw
X-Gm-Gg: ASbGncs55/BlIDlCD0m/iT1y2aVC0LCJHYHehAkxBNoUmidLhj9lrTuE+QuQLxY6Smd
	jfoglMYiSUXyLACDJM4fCLUudYYCvJhOgtMNHemcKJf+Eo33e+BJB+2uxH2YjnEyMTzJekCAhOg
	v5roVJ/mp+LweQOtkWBtud8xmC+RfzhgpLISj3MZ4zeZkDFqp1WNjd8FPvaw//mPBQHWGcqUQbp
	V1jFXiEZqa9aPUt4xCenyAvDpNG5p6CRThUSqFNxkRDQGXISWRmvjvxkmnnVtpDkLJsBoe9VAOS
	XjaMhGO/zAWhpFgqS29jFAY/bQxhP9XwmVrXGRSDSjPvAsixIN02lCpuZgnJ+1B0mHJ8jKPS+CL
	dI/YJxC9RN8dSUpwbfyGxrKpiZ1yDPt7t8yfZqNYhE0M=
X-Google-Smtp-Source: AGHT+IFjR517vCAUNyZmP/NtQ6JbvJmH4KhkzCA3/4f876CAu+LnOExtfNWpNrpMCkeAqIM3e2h6Sw==
X-Received: by 2002:a05:6a20:7487:b0:240:30c:276a with SMTP id adf61e73a8af0-24031463e79mr4059373637.39.1754478163258;
        Wed, 06 Aug 2025 04:02:43 -0700 (PDT)
Received: from manjaro.domain.name ([2401:4900:1c30:7b0d:6527:282d:9edd:5f40])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bcce8de28sm15074948b3a.39.2025.08.06.04.02.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 04:02:42 -0700 (PDT)
From: Pranav Tyagi <pranav.tyagi03@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	davem@davemloft.net,
	kuba@kernel.org,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	eddyz87@gmail.com,
	shuah@kernel.org
Cc: sdf@fomichev.me,
	mykolal@fb.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	haoluo@google.com,
	jolsa@kernel.org,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev,
	Pranav Tyagi <pranav.tyagi03@gmail.com>
Subject: [PATCH] selftests/bpf/progs: use __auto_type in swap() macro
Date: Wed,  6 Aug 2025 16:32:30 +0530
Message-ID: <20250806110230.23949-1-pranav.tyagi03@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace typeof() with __auto_type in xdp_synproxy_kern.c.
__auto_type was introduced in GCC 4.9 and reduces the compile time for
all compilers. No functional changes intended.

Signed-off-by: Pranav Tyagi <pranav.tyagi03@gmail.com>
---
 tools/testing/selftests/bpf/progs/xdp_synproxy_kern.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/progs/xdp_synproxy_kern.c b/tools/testing/selftests/bpf/progs/xdp_synproxy_kern.c
index 62b8e29ced9f..b08738f9a0e6 100644
--- a/tools/testing/selftests/bpf/progs/xdp_synproxy_kern.c
+++ b/tools/testing/selftests/bpf/progs/xdp_synproxy_kern.c
@@ -58,7 +58,7 @@
 #define MAX_PACKET_OFF 0xffff
 
 #define swap(a, b) \
-	do { typeof(a) __tmp = (a); (a) = (b); (b) = __tmp; } while (0)
+	do { __auto_type __tmp = (a); (a) = (b); (b) = __tmp; } while (0)
 
 #define __get_unaligned_t(type, ptr) ({						\
 	const struct { type x; } __attribute__((__packed__)) *__pptr = (typeof(__pptr))(ptr); \
-- 
2.49.0


