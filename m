Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 905216D8C10
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Apr 2023 02:40:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234655AbjDFAk4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 5 Apr 2023 20:40:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234519AbjDFAkw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 5 Apr 2023 20:40:52 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81F4265AE
        for <linux-kselftest@vger.kernel.org>; Wed,  5 Apr 2023 17:40:45 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-54c060d7cdfso17531757b3.13
        for <linux-kselftest@vger.kernel.org>; Wed, 05 Apr 2023 17:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680741644;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=x8R/SEDfqF4QrtFeRx/u2abN72cLJ7gQ42FhuO/V5K0=;
        b=ZCqkQYcafiAtvRvV3fHcQ/fGM6OE4T8iRV3w1fmZKzRWP42x57FdCTAbn2xhSCkS8D
         g7/sHITX3xpmjygzz850+hz+7Ofn3Ga29i16IQLKsvuDl/ARP0XS69IBvokQc1B/y7kj
         EQxUO30KM7p3z4QSgWyx3Y/XtS6cr8O8OiY23SPHPIV7y5SZucR1PBQaJFUk3nVogKey
         umNa/tl3tx8FFtyMktnCpJp4P21tuOkDjq4R1mI+bABEvC2PCUv4g/L2Ig8H9ne32mrO
         L7R0SzslBoH8PJ3dFikEKFHx3W+Uf2A5ns3c9zmYpx9t9NykulL6jkR+cNRJLm5KUmhK
         ofgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680741644;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x8R/SEDfqF4QrtFeRx/u2abN72cLJ7gQ42FhuO/V5K0=;
        b=60c+IZWxeExrfHt3Egtn93oeVRvMcmogFT1ItJCF633mAY8Pnf/pKozASJt/LLZPlM
         zW/WCp7P3Lj9BPf2mG23CNlh+SksgNZTXavwRDc76hkLDFjyX6K/A3SkZMAbTHym1lmp
         KH6OntJOuXIoTHdj8B4p6EFFhrX30AO+rNXuICZ+MKuvHX+qTwavJ+FnhzOpfMDdJb1i
         Yz5o+5szE8qds+g3nADs5MHyUk60JsDcnva/KG1CPjnm8s7ZrVrYO6Fkm1wlafZ7LVi4
         yqyUJB8h7yzNd9BWAUXttDRiOr6UC+iixMYqy8Q8ztRvhlLG3CA1PY4XXXBxq5Jau2wy
         kV3g==
X-Gm-Message-State: AAQBX9czRUeRM1EpEj54rxUcFTh1hXCYBcjMEdkmOML8/CVS2+6JqyUQ
        FsNNNAQnOjwB/EvCOoHK/gB5GpUlc2M=
X-Google-Smtp-Source: AKy350Y+if23WZgYEhMrSezh2kGa1/V3dBjppuEeSCDz5TpXpURFDSDF0HvuDxVTPEWFxq3wS4lP9CWr3/Q=
X-Received: from drosen.mtv.corp.google.com ([2620:15c:211:201:694f:f21b:c6de:aead])
 (user=drosen job=sendgmr) by 2002:a25:d4c7:0:b0:b76:126b:5aa1 with SMTP id
 m190-20020a25d4c7000000b00b76126b5aa1mr715873ybf.8.1680741644750; Wed, 05 Apr
 2023 17:40:44 -0700 (PDT)
Date:   Wed,  5 Apr 2023 17:40:18 -0700
In-Reply-To: <20230406004018.1439952-1-drosen@google.com>
Mime-Version: 1.0
References: <20230406004018.1439952-1-drosen@google.com>
X-Mailer: git-send-email 2.40.0.577.gac1e443424-goog
Message-ID: <20230406004018.1439952-4-drosen@google.com>
Subject: [PATCH 3/3] selftests/bpf: Test allowing NULL buffer in dynptr slice
From:   Daniel Rosenberg <drosen@google.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Joanne Koong <joannelkoong@gmail.com>,
        Mykola Lysenko <mykolal@fb.com>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, kernel-team@android.com,
        Daniel Rosenberg <drosen@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

bpf_dynptr_slice(_rw) no longer requires a buffer for verification. If the
buffer is needed, but not present, the function will return NULL.

Signed-off-by: Daniel Rosenberg <drosen@google.com>
---
 .../testing/selftests/bpf/prog_tests/dynptr.c |  1 +
 .../selftests/bpf/progs/dynptr_success.c      | 21 +++++++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/dynptr.c b/tools/testing/selftests/bpf/prog_tests/dynptr.c
index d176c34a7d2e..db22cad32657 100644
--- a/tools/testing/selftests/bpf/prog_tests/dynptr.c
+++ b/tools/testing/selftests/bpf/prog_tests/dynptr.c
@@ -20,6 +20,7 @@ static struct {
 	{"test_ringbuf", SETUP_SYSCALL_SLEEP},
 	{"test_skb_readonly", SETUP_SKB_PROG},
 	{"test_dynptr_skb_data", SETUP_SKB_PROG},
+	{"test_dynptr_skb_nobuff", SETUP_SKB_PROG},
 };
 
 static void verify_success(const char *prog_name, enum test_setup_type setup_type)
diff --git a/tools/testing/selftests/bpf/progs/dynptr_success.c b/tools/testing/selftests/bpf/progs/dynptr_success.c
index b2fa6c47ecc0..a059ed8d4590 100644
--- a/tools/testing/selftests/bpf/progs/dynptr_success.c
+++ b/tools/testing/selftests/bpf/progs/dynptr_success.c
@@ -207,3 +207,24 @@ int test_dynptr_skb_data(struct __sk_buff *skb)
 
 	return 1;
 }
+
+SEC("?cgroup_skb/egress")
+int test_dynptr_skb_no_buff(struct __sk_buff *skb)
+{
+	struct bpf_dynptr ptr;
+	__u64 *data;
+
+	if (bpf_dynptr_from_skb(skb, 0, &ptr)) {
+		err = 1;
+		return 1;
+	}
+
+	/* This should return NULL. SKB may require a buffer */
+	data = bpf_dynptr_slice(&ptr, 0, NULL, 1);
+	if (data) {
+		err = 2;
+		return 1;
+	}
+
+	return 1;
+}
-- 
2.40.0.577.gac1e443424-goog

