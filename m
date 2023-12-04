Return-Path: <linux-kselftest+bounces-1040-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 92681802ECC
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Dec 2023 10:39:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C387F1C20987
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Dec 2023 09:39:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D61821C2BE;
	Mon,  4 Dec 2023 09:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CoFuB5nU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3086B2;
	Mon,  4 Dec 2023 01:39:43 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-40c09ba723eso11251645e9.2;
        Mon, 04 Dec 2023 01:39:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701682782; x=1702287582; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=itnvq+P/Fjh6RP+B0+dY8QHorajZulYkmu3iW5W6GwY=;
        b=CoFuB5nU6e31ISJXpMBxyiKWE8ME0yoRZlrS8DYOEhlP14xRysT5BPQ1zaKlVJkRkh
         RWTkyHgh2rNT35F0yWexHGP3Puk939AkBnYihRc6q5aXdbtJQ51lsnde0RYAEoj34x1L
         Al355chhLfeKHg59nxVWtG6bZKKwwWfCTn8/S+e1fcyLFl4TSu9oywM84I9PbOGSiQ9P
         g6jTHkVmRwzXn24IHzD/+RhyMCx+CuJFUR7TRwmil+Ubuq0oldyG3/V9Mx2pjy1di8r4
         PBhVAnF5SWGOqGpopJxZygsCkmxHg1u6Sm2NlsQbx+TXs1SWinASfhWPMfGoRcLgukM+
         jlYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701682782; x=1702287582;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=itnvq+P/Fjh6RP+B0+dY8QHorajZulYkmu3iW5W6GwY=;
        b=lqZhmGd5RlTi8S9CP++e9Cs89/mlhMhzAGwO25jZ4QZKEzjwpCb8JUBKHpzyUeBQxZ
         UBh1uSxhZXm2iWHOyaiHwEzK9J/L9wBhPW5hOVyuO+9fYxHB/p5cdKohLqS3SvRuj2dj
         sZ49m0GkqUrI3OsVUuX+On9YoDsgMWkOxX5phtSs0P1G+gjIgYylLHOJbcj/oXxIv6wY
         G44IC7zGvTPzDlH+4fytdRQKzQFaQg2kgml9bnnvocDma/HFj8nZDFPcDTXDw5UwJzS+
         IrzO0ZTiBOJnj09Yt/PHuSDzLnFioMCVnAmNPXekAxup5r+nc30yimP5Oxk+48U0U980
         8mOw==
X-Gm-Message-State: AOJu0Ywl+MvrBnkEYQgBTbL+e0kgCjSlSzPqIZPrvfeRHS31TUflC2PJ
	x1HbEks8a29RBfIgLNJw9KQ=
X-Google-Smtp-Source: AGHT+IEuktjrUxLdnaKY9QQMHGXtWDZAhW0oayMCNA5adoVDlXNkChDbLVtvMFBUY6gJCz8lY1y0og==
X-Received: by 2002:a05:600c:3584:b0:408:5a1c:9de7 with SMTP id p4-20020a05600c358400b004085a1c9de7mr2136608wmq.7.1701682782129;
        Mon, 04 Dec 2023 01:39:42 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id r1-20020a5d4e41000000b0033340c678ffsm4278525wrt.96.2023.12.04.01.39.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 01:39:41 -0800 (PST)
From: Colin Ian King <colin.i.king@gmail.com>
To: Andrii Nakryiko <andrii@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][NEXT] selftests/bpf: Fix spelling mistake "get_signaure_size" -> "get_signature_size"
Date: Mon,  4 Dec 2023 09:39:40 +0000
Message-Id: <20231204093940.2611954-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

There is a spelling mistake in an ASSERT_GT message. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 tools/testing/selftests/bpf/prog_tests/verify_pkcs7_sig.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/verify_pkcs7_sig.c b/tools/testing/selftests/bpf/prog_tests/verify_pkcs7_sig.c
index 6c90372b772d..ab0f02faa80c 100644
--- a/tools/testing/selftests/bpf/prog_tests/verify_pkcs7_sig.c
+++ b/tools/testing/selftests/bpf/prog_tests/verify_pkcs7_sig.c
@@ -498,7 +498,7 @@ static void test_pkcs7_sig_fsverity(void)
 	if (!ASSERT_OK_PTR(skel, "test_sig_in_xattr__open"))
 		goto out;
 	ret = get_signature_size(sig_path);
-	if (!ASSERT_GT(ret, 0, "get_signaure_size"))
+	if (!ASSERT_GT(ret, 0, "get_signature_size"))
 		goto out;
 	skel->bss->sig_size = ret;
 	skel->bss->user_keyring_serial = syscall(__NR_request_key, "keyring",
-- 
2.39.2


