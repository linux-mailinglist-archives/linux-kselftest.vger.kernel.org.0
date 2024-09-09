Return-Path: <linux-kselftest+bounces-17507-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 160819710E8
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Sep 2024 10:02:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D0621F223A8
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Sep 2024 08:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D1551B78EE;
	Mon,  9 Sep 2024 07:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g/bVku6V"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB0041B652E;
	Mon,  9 Sep 2024 07:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725868632; cv=none; b=FG5ASApKIlksso3U4L/iXi15ccYE1AeWR8/VKEoHj/JY2plARXb3X8CPVpptlB+P8Hfe5lVyIAtSdB5xmzFoDkUJQ3pZA9Di0hddj04raK3fO8Um+9WrSmMgHwh7TUUvn0uJx8HxWSNcIxjuQw4TjtAQ5zOuROqgmOy4H4bbLY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725868632; c=relaxed/simple;
	bh=gBbNhFO0BEjuhC56tT9G9xCxb9heG3EotW+MI4AasP8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FIqATC2orKn64Br2hxsEwzCQxic/dK+uM4mzKknZ1B/vULy/FSjIHgEfzUj6Tcq6Op5OWAAUyQ1Mp8U7RHT9w7+RX/NUyMEw1zVZUaV73PC0cBM68AM5+r8eXnCRm5I8POj7wSUn50ygojjc5osrwbv4bPWhbDlw55/h6x3tNTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g/bVku6V; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-42cafda818aso15181185e9.2;
        Mon, 09 Sep 2024 00:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725868629; x=1726473429; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uaLYxtWkb9UDRswjf7QQ6H+2Ezg3Jw4reUgYCP+x518=;
        b=g/bVku6VxJ1wJnmm0skyrV7TfnHUjOCUlQo26m9/m5Vc/qn0SnZDT6adMpk8xRhuJi
         UY28VRfoGv62fETqpKAgLGpZd824CNTc3loOJxIix/GjyoqFrsv6NzOTQDrgwVAWw9v7
         QuX9DWiTRu1Hr/TLzfENVI/I2/l3DvMADYbVndGutEUX640aqNG1pW9Jb/mu2ZIoxV7J
         rcK81HrWQGSnW8dn3oqWmafVhjMUy2jHkpRZTFNtttzLB3g9j72ppBjqFkFIbN8ZyCMK
         AnRZsEzO2XUz3uf6gHi8Co2HCYQo9xr4vEecClu9xJsY2YL0oUk4CM/NoVaTtMPfE7DM
         YXHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725868629; x=1726473429;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uaLYxtWkb9UDRswjf7QQ6H+2Ezg3Jw4reUgYCP+x518=;
        b=jcMk42w8/WoZX5ck2IqLJdQJ+mt2/VqNMxF/oXU1lgsMPvNavvBUfRjcuupiC/m8IZ
         cy5jH1p2omYn72II01WjNUJ/qiONnm38gECdWNROpKbMqmy8rN/G06IwToAQuUwcnyKe
         PU8l+O2xq1G9KtusEmhykiOzFgpBBvKUkszTUw3A4o6C2cwsVgns7y3B0QYfVt1nIIic
         S/pFx+427FDVqWP3u5vLUUfszTIMRTg8GGnyWHDjRCLYzG3C5NoMSGoFlXagwF/SZv/L
         +7yJHrQU7HnVQf0cevJM3JV9y4Z6rhX8cVD3rmWLCSMFpx8dpjinCpBW+21UVZclVTOH
         6d8A==
X-Forwarded-Encrypted: i=1; AJvYcCUGY1s9FUtHTDgR4fKB7i4VVjvwAyQ27RDDtxh+A9D/fhSUtPkQT3y/ugGIsGbqbN5tMiTkOpi11JwjePjP@vger.kernel.org, AJvYcCUgQmgDbaVXUYHSNKmhQ6YHjh1CaLupAf/jM29Rk9cCz90erA1VIePHF92EAD1zNZZhFbe9bq8oC2QcZA==@vger.kernel.org, AJvYcCV97IoXB4Tpgvj5Gv/BhEHiBBkzAn2ema2pdPWNmzfhJgK1R9ORHWYparqaJyPLuznHu6I=@vger.kernel.org, AJvYcCW6+bnZoqfdEU+jEZmL+eF3DQ1BW6PGIC4XFz7rUoM1cft8fA0aaIopdJQXoLBuOuVuxlRvZUQUFmiogR6m@vger.kernel.org, AJvYcCX11UrrbY11oUmQ0xhZOpnZhRy8zBuIerKf3y4gN4c8SNWpo5bmmpo3/eXCSHPKho59XcBx1qLGc2q0XcM=@vger.kernel.org, AJvYcCXNAeMa9sBjA0wwjGZv4l0YZ6auGkm8wyAyUlhwn+1uoZZOy3erDMXHsGjfwuS++gFNNrGCRyZvHpBc7bVzMg==@vger.kernel.org, AJvYcCXRy3Jd+ViYms5LOxuzuk8TTC3ef6+fwpcloQC3N95r51tTDTS32E2PfpObBCqSGsPu4gnh1ki5zdjsgQckQ9RM@vger.kernel.org
X-Gm-Message-State: AOJu0YxYwRJ//PT6ThpoeJDOhuFq0P/1FNsJZLr0hPuqsdE//k+o0QE7
	nq1RpSSEvxsHww6bxB2sWvQeLQmMjQMFn+YiXCjjMTAOPFOM7U9I
X-Google-Smtp-Source: AGHT+IETjLR+Br4j1eN9qUmeGiXMn0hxIOR/FMqY6EotNIPlACrNl22bd9oFTjuVkMYBJaH0OQXWXQ==
X-Received: by 2002:a05:6000:136e:b0:374:c911:7749 with SMTP id ffacd0b85a97d-3788967950bmr5536942f8f.49.1725868628808;
        Mon, 09 Sep 2024 00:57:08 -0700 (PDT)
Received: from fedora.iskraemeco.si ([193.77.86.250])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37895675b7esm5303001f8f.50.2024.09.09.00.57.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 00:57:08 -0700 (PDT)
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
	Andrew Morton <akpm@linux-foundation.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>
Subject: [PATCH RESEND v2 14/19] bpf/tests: Include <linux/prandom.h> instead of <linux/random.h>
Date: Mon,  9 Sep 2024 09:53:57 +0200
Message-ID: <20240909075641.258968-15-ubizjak@gmail.com>
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
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Eduard Zingerman <eddyz87@gmail.com>
Cc: Song Liu <song@kernel.org>
Cc: Yonghong Song <yonghong.song@linux.dev>
Cc: John Fastabend <john.fastabend@gmail.com>
Cc: KP Singh <kpsingh@kernel.org>
Cc: Stanislav Fomichev <sdf@fomichev.me>
Cc: Hao Luo <haoluo@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
---
 lib/test_bpf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/test_bpf.c b/lib/test_bpf.c
index ca4b0eea81a2..eb4a1915e4d2 100644
--- a/lib/test_bpf.c
+++ b/lib/test_bpf.c
@@ -14,7 +14,7 @@
 #include <linux/skbuff.h>
 #include <linux/netdevice.h>
 #include <linux/if_vlan.h>
-#include <linux/random.h>
+#include <linux/prandom.h>
 #include <linux/highmem.h>
 #include <linux/sched.h>
 
-- 
2.46.0


