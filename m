Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0E4F25C9F3
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Sep 2020 22:06:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729226AbgICUGP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 3 Sep 2020 16:06:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728525AbgICUGJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 3 Sep 2020 16:06:09 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD3E9C061245
        for <linux-kselftest@vger.kernel.org>; Thu,  3 Sep 2020 13:06:08 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id d184so2254355qkf.15
        for <linux-kselftest@vger.kernel.org>; Thu, 03 Sep 2020 13:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=/UWKJLPAXkkx3Yx/UTxrL8j3KiLl2CtZ9wNsas0CmuE=;
        b=PzHnPuf93hixvMb2aF+7BlDdwkzjC0etPhPvo9SQurkewLDnKyFtIWalPovaKknZb2
         Fe4e2WB0d036omhsG/4CRB4bG/f4l2UYghYN5ixsc5KDr9GA82fMgPV0OHeekJ2X/AyJ
         IjEEAOMglVDisZDfffRS9noELvbMTbtyDJ1yL1FpY9tnBi2lowcfU8QaXroOa3Zjz0Zy
         F0yWB1K9BbNwDr32UJrT4UOXcA+vzBIDP8S2Z0etxhd78EffQJTO69jmA4+pLYZ/aaI+
         mJ8SWHx38Q11qpJVljv6QaZgdiWGpA9CmRWI+VhQuYlrdpxYA6j/+9OZbzYb7SxXDpLn
         FIRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=/UWKJLPAXkkx3Yx/UTxrL8j3KiLl2CtZ9wNsas0CmuE=;
        b=tRdKrQN130uUOohzHO25kPjF0WVv4+syY8rrgqBvCJ1BbIHNP9ymo0F7PS2lzGW6tA
         A2ZOZHdnABcJ1uLUKiaD2HSNV8jzORE3VfQh1PRCdp88zJDH7wW3KH1MCXNvOIChhISg
         /+FfKpdLRg8re49yv4zlL3/tWODlGB5zrcDiWmoRk7AmIFOku1cHhEQ427a/eTVDUrKZ
         t6p9yCnIn3uKL63rzQsJlM31VQdV/hfB60j8IM7iRJLa1W5Dxyv2EMuufmGBfPS/EhE/
         fM/cLzzlGQVqP8lM8Jg+hlJkvCCwSegrntESUbD2yurseQ9/w8L3cWWJpLrf6zeiyUAw
         MWPw==
X-Gm-Message-State: AOAM530jxxF952Z0RiBZ3DCJS1/3PpXfE0d+geglulfjvS5MuF+i4o5J
        kHqbwsnA3EsTJ1RFfSaZdUoYn/sItOY=
X-Google-Smtp-Source: ABdhPJyK9sfS5Vkv4dj8ZJQOHZl2X6IErVJpoiHmtkGO5YHA9LFQM3sNM26AhgovDm0AE51Lnt9kXdHfOmw=
X-Received: from haoluo.svl.corp.google.com ([2620:15c:2cd:202:f693:9fff:fef4:e444])
 (user=haoluo job=sendgmr) by 2002:a0c:edaa:: with SMTP id h10mr3625649qvr.12.1599163567913;
 Thu, 03 Sep 2020 13:06:07 -0700 (PDT)
Date:   Thu,  3 Sep 2020 13:05:28 -0700
Message-Id: <20200903200528.747884-1-haoluo@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.526.ge36021eeef-goog
Subject: [PATCH] selftests/bpf: Fix check in global_data_init.
From:   Hao Luo <haoluo@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc:     Shuah Khan <shuah@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andriin@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        "=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?=" <toke@redhat.com>,
        KP Singh <kpsingh@chromium.org>, Hao Luo <haoluo@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The returned value of bpf_object__open_file() should be checked with
libbpf_get_error() rather than NULL. This fix prevents test_progs from
crash when test_global_data.o is not present.

Signed-off-by: Hao Luo <haoluo@google.com>
---
 tools/testing/selftests/bpf/prog_tests/global_data_init.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/global_data_init.c b/tools/testing/selftests/bpf/prog_tests/global_data_init.c
index 3bdaa5a40744..ee46b11f1f9a 100644
--- a/tools/testing/selftests/bpf/prog_tests/global_data_init.c
+++ b/tools/testing/selftests/bpf/prog_tests/global_data_init.c
@@ -12,7 +12,8 @@ void test_global_data_init(void)
 	size_t sz;
 
 	obj = bpf_object__open_file(file, NULL);
-	if (CHECK_FAIL(!obj))
+	err = libbpf_get_error(obj);
+	if (CHECK_FAIL(err))
 		return;
 
 	map = bpf_object__find_map_by_name(obj, "test_glo.rodata");
-- 
2.28.0.526.ge36021eeef-goog

