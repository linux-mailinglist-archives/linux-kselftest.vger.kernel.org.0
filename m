Return-Path: <linux-kselftest+bounces-14374-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9968493F0FA
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Jul 2024 11:25:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE5831C21BC5
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Jul 2024 09:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF44713E41A;
	Mon, 29 Jul 2024 09:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aB/PTN4r"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 720E2135A63;
	Mon, 29 Jul 2024 09:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722245105; cv=none; b=YvaDn7j7ErAS/F4Y5MRFMkrs8l+r4aEdoeGpcFabz+Ifydm+lSrfUSBOBye/BGxqBA4YwO4Th9bvW8yxyDKm/cDvz7QPb0f6edBX+jGT6uuWLopUVYPVtN6MxTAC6PcDA8IeAeWSRYAxAamuHaOyljkcRtaWCY+6wzZKIn5AHSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722245105; c=relaxed/simple;
	bh=FQrcOOy+m/blf8ix9UP7S4A0ij3wHldqUVHF9z9y2/I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=g2e8hQIoc01+HEpIHLyTeG+ZLsxRQ2NuH9OMY3qo2GZyVxhy9h3pkfRoTrsCl5qtyD1JCLviih9ZEIMM54zehcdvwuqDiqd4k+QIq7l0E9Qn0UK3DbL6DBE6o3Y2f1jvvM1nNqSiXLKtp3vyBnV+2gD2DtIw6R1y0seB05cZ9cU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aB/PTN4r; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1fd6ed7688cso18289055ad.3;
        Mon, 29 Jul 2024 02:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722245104; x=1722849904; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ss5Trmaz8d1KChsteoiB0CfEnS7j0drXtuJsrgRgs5k=;
        b=aB/PTN4rx+Y0dyni48NWpC4rDOtbvoHIGu0hsKY2X7vtek94Btwy56Pgj6jWAaVcP7
         Xm1vx3mjqoSSv0zxt71Rvh6+6aEf+109NroYssPxBPhlxlMWJZySotl1IPvLffH3cNL5
         u5Siqtj56NdC360QDc8QDyx1PorKpisjlrQo2EZN+oij3zKF8tRUM9alvN8JXFkwNLSF
         WUP8zlvQd5GZ7KViNyojVV1DvVT80/GzgGPZx0NWwuT3XVvKqvwQMpbx+bVxMZexVWZy
         9JTo2uBPX/wDwtYVYrXFSHZEVEgg1Q0QQmljN0+QnKNtEbq0b1AOWdSCGipvNcBxjJlx
         /V4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722245104; x=1722849904;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ss5Trmaz8d1KChsteoiB0CfEnS7j0drXtuJsrgRgs5k=;
        b=eQ7ES/8G0D09Vl94975d7CGcVtyp+EBK4TngFA+S314Q8Pa6Ybsx7LbjscOPmZO0NJ
         b1dGcByZL8WjCKF39hFAH23mXa2MaJiC3dBzuLM1v/deUvhES5cSzrCRVcSi1FU5t6lc
         shMbDzogcAWa5ELyklnVhy7mQZ/M97BZG/A/Nutz3qWHmfaP8lgXESvikKjxJjDYhQyZ
         /TAf1jCBWc7aG+UzGJdpaTbBZodLoLYRSt7NpVn1k8yuZ1MvJJjW8PywvOg4l03aon7s
         u2Sp7zf+BiwAi/lTlSpNR0Y8dVWRzVeHjwJ0Fa0P0SwaEG5qKfQAsrcTNSrE+E9f/XS1
         JjVA==
X-Forwarded-Encrypted: i=1; AJvYcCW03z6BWaANlg5mNH02So4Ow+DwVTVyJSa4dujGsqavVHQBhRsxkzYawPdM9lIRIXPDUgfsPGWNxsByYzgQM8nVWnyOq76/J+7q8pDjxwvO/DX0dS2vpevLLwKPqWqfR6N2I3EjEPI5
X-Gm-Message-State: AOJu0Yw/u3SN4kXhHIoi6QD8fUG4B5WZoTuGpFuFdtb7mQ6N7eGW2nq2
	qIMZ1DjQL0cjyi+P02G9bYSls9Zrql+f9woXOmXkpSfw9qWmeXzJY3yp9WBq
X-Google-Smtp-Source: AGHT+IGWUH5D5srqRgCA4MK0mZYlxqSGcj/oxvfwHH4bGr19xe12SQdBOw+pnofS/O5kftsXZxojGQ==
X-Received: by 2002:a17:903:2304:b0:1fc:6a13:a394 with SMTP id d9443c01a7336-1ff0483e1e7mr54259495ad.23.1722245103531;
        Mon, 29 Jul 2024 02:25:03 -0700 (PDT)
Received: from localhost.localdomain (69-172-146-21.cable.teksavvy.com. [69.172.146.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7c8c19dsm78119145ad.54.2024.07.29.02.25.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 02:25:03 -0700 (PDT)
From: Tony Ambardar <tony.ambardar@gmail.com>
To: bpf@vger.kernel.org
Cc: Tony Ambardar <tony.ambardar@gmail.com>,
	linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org,
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
	Jiri Olsa <jolsa@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>,
	Shuah Khan <shuah@kernel.org>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Jonathan Lemon <jonathan.lemon@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Yan Zhai <yan@cloudflare.com>
Subject: [PATCH bpf-next v2 4/8] selftests/bpf: Fix C++ compile error from missing _Bool type
Date: Mon, 29 Jul 2024 02:24:20 -0700
Message-Id: <6fc1dd28b8bda49e51e4f610bdc9d22f4455632d.1722244708.git.tony.ambardar@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1722244708.git.tony.ambardar@gmail.com>
References: <cover.1721903630.git.tony.ambardar@gmail.com> <cover.1722244708.git.tony.ambardar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While building, bpftool makes a skeleton from test_core_extern.c, which
itself includes <stdbool.h> and uses the 'bool' type. However, the skeleton
test_core_extern.skel.h generated *does not* include <stdbool.h> or use the
'bool' type, instead using the C-only '_Bool' type. Compiling test_cpp.cpp
with g++ 12.3 for mips64el/musl-libc then fails with error:

  In file included from test_cpp.cpp:9:
  test_core_extern.skel.h:45:17: error: '_Bool' does not name a type
     45 |                 _Bool CONFIG_BOOL;
        |                 ^~~~~

This was likely missed previously because glibc uses a GNU extension for
<stdbool.h> with C++ (#define _Bool bool), not supported by musl libc.

Normally, a C fragment would include <stdbool.h> and use the 'bool' type,
and thus cleanly work after import by C++. The ideal fix would be for
'bpftool gen skeleton' to output the correct type/include supporting C++,
but in the meantime add a conditional define as above.

Fixes: 7c8dce4b1661 ("bpftool: Make skeleton C code compilable with C++ compiler")
Signed-off-by: Tony Ambardar <tony.ambardar@gmail.com>
---
 tools/testing/selftests/bpf/test_cpp.cpp | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/bpf/test_cpp.cpp b/tools/testing/selftests/bpf/test_cpp.cpp
index dde0bb16e782..abc2a56ab261 100644
--- a/tools/testing/selftests/bpf/test_cpp.cpp
+++ b/tools/testing/selftests/bpf/test_cpp.cpp
@@ -6,6 +6,10 @@
 #include <bpf/libbpf.h>
 #include <bpf/bpf.h>
 #include <bpf/btf.h>
+
+#ifndef _Bool
+#define _Bool bool
+#endif
 #include "test_core_extern.skel.h"
 #include "struct_ops_module.skel.h"
 
-- 
2.34.1


