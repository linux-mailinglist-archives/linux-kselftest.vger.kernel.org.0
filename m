Return-Path: <linux-kselftest+bounces-14043-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DC6B939962
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jul 2024 07:55:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD29B282879
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jul 2024 05:55:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C5BE13D503;
	Tue, 23 Jul 2024 05:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FdMYbG55"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E29D5367;
	Tue, 23 Jul 2024 05:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721714145; cv=none; b=MFSIDQVbEpsHbJsyEqp+mEnMDwHFxwQV8iWE1WzXzm70BCAsGybEl8DosSt36j4fiGcka5d0ZUwBTh9Y79fZZqIGQ8iDpeDLvVX8oeM3Jb0hmD/RjqA4pn8E1JcbBUxNh3dhk6sb5jgGF8DVSzWWcHJ1wW2LHWYBA2IZhN5/PZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721714145; c=relaxed/simple;
	bh=orjN7N45+/uSUw4tbpqsVXAphe9Gj4vBhZaUgHqwb0g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=s+PAGKoPUgeGmYtmjqonrqTUebJYjxfYUVotOLfQ+H9WycrbfPcVPE3qPMcnhoZwOoVM1gN3U/UKDTsupgFNuQuym84uLD+E7sHsYKl0kddjitB0Sq3/AP2p+gRZ3Lfz7/NemnKEWe9wk55dU+gh6EySpWypG14KzXdv6LZJ7bI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FdMYbG55; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1fc587361b6so38479095ad.2;
        Mon, 22 Jul 2024 22:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721714143; x=1722318943; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qzLKMhq/i0ZyAtmvpqGuB9Le2Uf8ZZ76gVE1oOnUGq4=;
        b=FdMYbG55FVu9KpDULCdYTcP/6bVh4IZfm3YXxvx9kHt3BlUkrNVG9zpsWWPBvBZC79
         zNDq5P/tDDpNTKGqLuiegvwbXKZsILmR9pg3ZZRVA9T7gBrpXT2WBmFfnOmehjyJ9iJO
         D/8ODq0HEESObM8jLHIz0wH/9m7V/S29fAdiBTiUT/lHmha3HmBJ2vUAinAE4fLmOcJe
         VP8dmSpss8vcCR6GCqsliX3UjYZyTKyytIAA4ZeSDp+2NJho5CEPE3VpwMA7l46pjK8U
         7VpR9SpcXHSIw+thDii+7mOBQit9LgPo4Khu7cyYqVZpkEaVlEjVtYhfIicffBROEFWr
         bPvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721714143; x=1722318943;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qzLKMhq/i0ZyAtmvpqGuB9Le2Uf8ZZ76gVE1oOnUGq4=;
        b=QqyO8YKXvCdQqKJ2PCqVAgjzi1oRBKktb+UlpFI091YdJD7Bbzh5uexQFK/sH5x4gE
         QRd68egRYlx7XJTAZe8XHNr8JPtFZ1KpteTLZg+fFdV2L7meGBaQT1fyf8Nt9/pg/ACR
         0K3eD+shgtd2ZXfDLWDxuqR4YjygidKS0OCDQWt/AjwWuzPX8/CCNvenAPYoY4a0Zd59
         bNYnW3iGA/16XUcwpnhMbrgxcVG4SPv9ZAoAkPtowTlREELTNJo3A/cl51729m6WU369
         W2c9UlA+QQI5ai8UmdRe5liaIMol2cK2E0AVmpIi+JXTX2D5zDw2ZkHTA12lzZXg69li
         SVnQ==
X-Forwarded-Encrypted: i=1; AJvYcCWiLaPKrJG2y+88/9yQ0an9cCM+cadlMuAm/FsDFWIarJlxDIQt0yVdKetcKt8ZWU5jJLQJV2eV+qF7Pwew7W4wWEr+EARLYjkqI5Op0qJp
X-Gm-Message-State: AOJu0YzSHECPGikSE3phE36d3K3Pn7W84B7UP45r0BgO9RBbIawCX3TG
	0tzQ0HcGgCGyvyJx2X6/cBR5oQicmc8PXMPPGa2VA4rVXfw2TfeljDbYjQua
X-Google-Smtp-Source: AGHT+IFEi9tn+WpGvX1s5XPxycwhrDJbDW+r35u/w7uuzaRmvB6yOSQmoFJGpNgvKL+njogBevZYFw==
X-Received: by 2002:a17:903:234b:b0:1f6:f298:e50 with SMTP id d9443c01a7336-1fd74682b41mr58418855ad.58.1721714142976;
        Mon, 22 Jul 2024 22:55:42 -0700 (PDT)
Received: from localhost.localdomain (69-172-146-21.cable.teksavvy.com. [69.172.146.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fd6f469df5sm65724685ad.254.2024.07.22.22.55.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jul 2024 22:55:42 -0700 (PDT)
From: Tony Ambardar <tony.ambardar@gmail.com>
To: bpf@vger.kernel.org
Cc: Tony Ambardar <tony.ambardar@gmail.com>,
	linux-kselftest@vger.kernel.org,
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
	Yucong Sun <sunyucong@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Kuniyuki Iwashima <kuniyu@amazon.co.jp>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	Dave Marchevsky <davemarchevsky@fb.com>,
	David Vernet <void@manifault.com>,
	Carlos Neira <cneirabustos@gmail.com>,
	Joanne Koong <joannelkoong@gmail.com>,
	Petar Penkov <ppenkov@google.com>,
	Willem de Bruijn <willemb@google.com>,
	Yan Zhai <yan@cloudflare.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	YiFei Zhu <zhuyifei@google.com>
Subject: [PATCH bpf-next v1 06/19] selftests/bpf: Drop unneeded include in flow_dissector.c
Date: Mon, 22 Jul 2024 22:54:33 -0700
Message-Id: <e8039a3af82275aa0052fafb70cd9fe4d6f9b5e4.1721713597.git.tony.ambardar@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1721713597.git.tony.ambardar@gmail.com>
References: <cover.1721713597.git.tony.ambardar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Test prog flow_dissector.c includes glibc extension '<error.h>' and fails
to build for non-glibc (i.e. musl) systems. However, the header is actually
not needed, so remove it to allow more portable compilation.

Fixes: 0905beec9f52 ("selftests/bpf: run flow dissector tests in skb-less mode")
Signed-off-by: Tony Ambardar <tony.ambardar@gmail.com>
---
 tools/testing/selftests/bpf/prog_tests/flow_dissector.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/flow_dissector.c b/tools/testing/selftests/bpf/prog_tests/flow_dissector.c
index 9e5f38739104..9625e6d21791 100644
--- a/tools/testing/selftests/bpf/prog_tests/flow_dissector.c
+++ b/tools/testing/selftests/bpf/prog_tests/flow_dissector.c
@@ -1,7 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <test_progs.h>
 #include <network_helpers.h>
-#include <error.h>
 #include <linux/if_tun.h>
 #include <sys/uio.h>
 
-- 
2.34.1


