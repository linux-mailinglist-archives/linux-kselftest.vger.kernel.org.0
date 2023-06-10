Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 944EC72AD02
	for <lists+linux-kselftest@lfdr.de>; Sat, 10 Jun 2023 18:13:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230048AbjFJQND (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 10 Jun 2023 12:13:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231321AbjFJQMo (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 10 Jun 2023 12:12:44 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D3FB3C07
        for <linux-kselftest@vger.kernel.org>; Sat, 10 Jun 2023 09:12:21 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-30ad458f085so2053112f8f.0
        for <linux-kselftest@vger.kernel.org>; Sat, 10 Jun 2023 09:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1686413525; x=1689005525;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YUHaQF9C9UJgnrQYwO0kb39FALtMlGaWS5DDHraXgNc=;
        b=3eHHzU7V9iCW2QqCzcYB/kyaM9Sb/8xd80ozJmG+Y/gnaqKemXsqZN3aWBVLoPV4Xa
         Xuu/Xh933Exykjef8i9Mzu9Od1h0SAVrAeAB4pMJmX6mnLKBMk0JGIiTPHYsaxWstQhR
         3Rl45653b7m/i+QG7J/tXZjlRfd+VSJ7QeNYfcrswh2iu36fqBxAJ+OyIY/iCewO6XSk
         JdxUalVqeIxKIb8067UtKWuhq+EiNL+KRreDZUL/FAADir2NAJ+muvG6mpsDB1qRSn7b
         dDHEJvhKVlfmpGLrMcGzbbM124Gifjtu1xp5NnVwiv1+5pUwYzD1kJ8jFCxZmVMkGez9
         38Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686413525; x=1689005525;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YUHaQF9C9UJgnrQYwO0kb39FALtMlGaWS5DDHraXgNc=;
        b=jQir3xQzDap1pBtLlgGKUIJozKaZ0vIDrXQYnJj+8t+qQDHl4Gl4zwLRypWnvTN0RJ
         Dwh3OYR1Z14IGlxe7bF0GsZ/LIIahaXzPIe6rppiRxJGadEjuBWxnCj7NtuJyeuE/YY4
         ys4jAd4IOHVPQczutcJCbvZCRHbFhKl2FZ+NE7N6RgRe6UhbCIqFnJ/rzMaKDuP4MexP
         bwbqMUxSfLzdSxqBKqCoM+B1/HDuBnxWL12LdQBuU3D9+6jhAbu8QmukfNAPD6vrvNNf
         uI8KMxWUkKJZjMxJ9feJ8UzUU8YGrW+f3/zs4Wp+45+VPG7HPdpyJ27RP8BefRCevdbP
         k+/g==
X-Gm-Message-State: AC+VfDxo5EDWQPKHXqEXRhrCZRIxh1UQK+ot8cQvObq+WnHp3IRr8xEj
        5dWYqjBIhtaG9CABoYpDTtLYVA==
X-Google-Smtp-Source: ACHHUZ5lKdONzlXMHUxtz6QvZyl01ZoGJFdb4YAHYqgfDxGz0joio4iMPT6qXUZAA0KkOdCMea2KpQ==
X-Received: by 2002:a5d:4887:0:b0:30a:900b:6bf4 with SMTP id g7-20020a5d4887000000b0030a900b6bf4mr1674642wrq.0.1686413525688;
        Sat, 10 Jun 2023 09:12:05 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id u9-20020a5d4349000000b003079c402762sm7431145wrr.19.2023.06.10.09.12.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jun 2023 09:12:05 -0700 (PDT)
From:   Matthieu Baerts <matthieu.baerts@tessares.net>
Date:   Sat, 10 Jun 2023 18:11:50 +0200
Subject: [PATCH net 15/17] selftests: mptcp: join: skip PM listener tests
 if not supported
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230609-upstream-net-20230610-mptcp-selftests-support-old-kernels-part-3-v1-15-2896fe2ee8a3@tessares.net>
References: <20230609-upstream-net-20230610-mptcp-selftests-support-old-kernels-part-3-v1-0-2896fe2ee8a3@tessares.net>
In-Reply-To: <20230609-upstream-net-20230610-mptcp-selftests-support-old-kernels-part-3-v1-0-2896fe2ee8a3@tessares.net>
To:     mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Florian Westphal <fw@strlen.de>,
        Davide Caratti <dcaratti@redhat.com>,
        Christoph Paasch <cpaasch@apple.com>,
        Geliang Tang <geliangtang@gmail.com>,
        Geliang Tang <geliang.tang@suse.com>
Cc:     netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        Matthieu Baerts <matthieu.baerts@tessares.net>,
        stable@vger.kernel.org
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1324;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=POtE7jKpTIYY83aubXV5/Xbyae8R1ULpdCYpNXP6iBo=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBkhKC+EUgKEzwh6bj0Ly3esf8ARmZJ22bVcjB16
 WqjHwOxn6mJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZISgvgAKCRD2t4JPQmmg
 c/giD/9vj/TTJijj79ucofvm4lwWlNY6OFUfSCfb/jn3JEwSl89sDaRXECImN/RtEavOuMx5ZAn
 ioEVixMmpQB2TQYEMSn8SWn++nXeQQUYpL4GmgE/oeFM5g358IIQi9piuHHofEb2rCszfTKcQ9z
 Un0JjAsgW7jLLXFQ/RPZSDZURF30efPRCgE6wC9uNvLV3zOl+JC6BA5gTnnikX+youdTiZCMKPw
 gVC6Y7QPnErxi5ZnM1/3WrEao1lVK5cY/RNm38w8wiqzCNSu76GshqTJ9ftKz/35UbWx0HP0acx
 +wz6nNautjtVIESZerjTdNf8zHUQIhyBWpAo7C/LfsZzEktb4PaGQfQAUDzhqEmnX47dyh6bPa+
 1tuxL+vQBEeW5s7nCuIdsu6kPxl6Pj/Jws2w4y0rLeT9juw7K5FN4XCr9MhomGACh/SbRWzyluW
 8414weBKSYNePAhFXRYJxiVTJeb+Lawqs2xWuf34m4WHcuURFDGT3GFdpnuDBTjhMLJ1Z8BPRxN
 K0CoGNMKyQTAyoOLNqxT8RhEIFrnQQ7PEI77AFEWjRm7+sqvSR/7dG+Kd8hBUOXUdb4x1YCTI40
 R/cArTTxX9ERa7Fksf3nbV8yvIcJ8Vn1RQbqryA42fHp6oJhe7OII/8v2R1ozTbLlo5TthV2+Cx
 y2jqEAylwpbZPpg==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Selftests are supposed to run on any kernels, including the old ones not
supporting all MPTCP features.

One of them is the support of PM listener events introduced by commit
f8c9dfbd875b ("mptcp: add pm listener events").

It is possible to look for "mptcp_event_pm_listener" in kallsyms to know
in advance if the kernel supports this feature.

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/368
Fixes: 178d023208eb ("selftests: mptcp: listener test for in-kernel PM")
Cc: stable@vger.kernel.org
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 554fcafd6e8a..0c22efeba675 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -2774,6 +2774,11 @@ verify_listener_events()
 			$e_saddr $e_sport
 	fi
 
+	if ! mptcp_lib_kallsyms_has "mptcp_event_pm_listener$"; then
+		printf "[skip]: event not supported\n"
+		return
+	fi
+
 	type=$(grep "type:$e_type," $evt |
 	       sed --unbuffered -n 's/.*\(type:\)\([[:digit:]]*\).*$/\2/p;q')
 	family=$(grep "type:$e_type," $evt |

-- 
2.40.1

