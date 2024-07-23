Return-Path: <linux-kselftest+bounces-14046-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 87048939969
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jul 2024 07:56:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EB951F22876
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jul 2024 05:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EE0813D60F;
	Tue, 23 Jul 2024 05:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gI6SNWHd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0941367;
	Tue, 23 Jul 2024 05:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721714152; cv=none; b=Y4HUjX5ZPsZPbAsK96B9nN5FiI2HWba/9yrMq7HXx5Id121K/itmDUVslw61JCB53QKTZTiAC9j5dWStt6VXekDMcybTTddf38KFpYx+5JcJxiE+Z8wwG0yGVqfLtvZWd+2jbX790wYO4tzIh2LPi7dT8PswnT4ijmBli4pogOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721714152; c=relaxed/simple;
	bh=Fvulvh0wRi63KXe+ClPk5X6wqiVaG05JHCmmwEQZS7M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=J4pWeGn7oixBe4cuXgRhU97BmB3ahcVypID5YSFhO0q77qJVcabpeOfz3J/T4roW9qIjq9tUEjxMojES+tJ7AH+WnvPEONXy3e/sgji9gMReXNmw+VslLPYc/9zKM8x2ekJYtdr0Z9gqh2s6zNcxzdaYpjJqJBZcZjC1Q0RMo2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gI6SNWHd; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-70b2421471aso172024a12.0;
        Mon, 22 Jul 2024 22:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721714150; x=1722318950; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PvN2vCmbbitXVsoz1GgGcqMKTbCHMV5QXlZU28fpyGQ=;
        b=gI6SNWHd3gQvyGJrDgNCAZB7P5UU70nuzIAKvOsjuL9jiejWBRH/rzYYX8HUqfXc3y
         VYQpqJbNawXZCTATOpIXuGb7AMgnqXVAUIl8an7ANEmh8+WYwVZUWl3Bx6G3JEGOY0uz
         YUoidFoTnMUz83YCWd29CsYHgsykUz0zQL1kIs1kLhZ8iBRdXTT+cB0a9Bw9S/t1N6Os
         x818YLq889V0ITfbbKCNMzJxqDBTQ1V/AfT68qC4LbKN76rY5lNs5nxqv0tFAAAG7PN4
         TQ0KpdHfPhaeJSRoK4wGzvOgRvrzD7iiFgmIVkY1iAKbL5WDxWPIkE+gVV84uUWTkmiB
         csWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721714150; x=1722318950;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PvN2vCmbbitXVsoz1GgGcqMKTbCHMV5QXlZU28fpyGQ=;
        b=do5EawlawwDxEOS7q8Pe+x/+LuAa6jJvoilR70Z5UaObmlym60cfOODfdTwl7RoaLe
         r5giZMkNH+YsfccmeZwMWh7FXBq7wUvlJmw7eTuTTGdS0Uv8oMI0LgS5U5onf9TfTVZN
         wyKktZOS5kruWCZDY9LzWidQDh9rT7onjRWcnoNgJTULYPltyS1CIWm3YUtpKHa02IbM
         J4Ui5R4x/m9uKoucdnwJ5A5vLiqQCJTAmWOqcJAWQ1wEts6SoZnCoI7fOs1xUhoWBrLI
         3qelRcMY4Px+oZwyw2T1KrrAdR85RZgl5gV9gFa1+qz9/rwv6Hv2Rn5xILnyYsdsUafP
         kPsQ==
X-Forwarded-Encrypted: i=1; AJvYcCU7GiLDA6fM3pdtVJy4UIEk+vPhZHSJRUIRd+tl1rv+SSmAzSLo7R/2zkqSnLbyWHm5Hnfz6b6ltSwbVJkEg7gIVBWTnfafylto4F9FkyyP
X-Gm-Message-State: AOJu0YwbuzAUQfi9lVV6WpOrWdDTOU6FUPkBEGPoOelNUNZ28JPblEqc
	ETCl+QK/eXbFCXeZH7/9FtQAMSnhR2WzmOYHYdlwBagt6DrVqpqdbKa7hJCl
X-Google-Smtp-Source: AGHT+IH1b5r88+ekB7/iB+JZSSWMelEkDkH5IJbqwABrSZGDBCRuhCkjgIu0nu70oG7wzvDil6r2FQ==
X-Received: by 2002:a17:902:e74d:b0:1fb:4f2e:8b7c with SMTP id d9443c01a7336-1fd74533ff5mr81345125ad.7.1721714149922;
        Mon, 22 Jul 2024 22:55:49 -0700 (PDT)
Received: from localhost.localdomain (69-172-146-21.cable.teksavvy.com. [69.172.146.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fd6f469df5sm65724685ad.254.2024.07.22.22.55.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jul 2024 22:55:49 -0700 (PDT)
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
Subject: [PATCH bpf-next v1 09/19] selftests/bpf: Fix missing BUILD_BUG_ON() declaration
Date: Mon, 22 Jul 2024 22:54:36 -0700
Message-Id: <b28575f9221ec54871c46a2e87612bb4bbf46ccd.1721713597.git.tony.ambardar@gmail.com>
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

Explicitly include '<linux/build_bug.h>' to fix errors seen compiling with
gcc targeting mips64el/musl-libc:

  user_ringbuf.c: In function 'test_user_ringbuf_loop':
  user_ringbuf.c:426:9: error: implicit declaration of function 'BUILD_BUG_ON' [-Werror=implicit-function-declaration]
    426 |         BUILD_BUG_ON(total_samples <= c_max_entries);
        |         ^~~~~~~~~~~~
  cc1: all warnings being treated as errors

Fixes: e5a9df51c746 ("selftests/bpf: Add selftests validating the user ringbuf")
Signed-off-by: Tony Ambardar <tony.ambardar@gmail.com>
---
 tools/testing/selftests/bpf/prog_tests/user_ringbuf.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/user_ringbuf.c b/tools/testing/selftests/bpf/prog_tests/user_ringbuf.c
index e51721df14fc..dfff6feac12c 100644
--- a/tools/testing/selftests/bpf/prog_tests/user_ringbuf.c
+++ b/tools/testing/selftests/bpf/prog_tests/user_ringbuf.c
@@ -4,6 +4,7 @@
 #define _GNU_SOURCE
 #include <linux/compiler.h>
 #include <linux/ring_buffer.h>
+#include <linux/build_bug.h>
 #include <pthread.h>
 #include <stdio.h>
 #include <stdlib.h>
-- 
2.34.1


