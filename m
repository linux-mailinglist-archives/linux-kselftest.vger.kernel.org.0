Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4672D6412EC
	for <lists+linux-kselftest@lfdr.de>; Sat,  3 Dec 2022 02:09:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235140AbiLCBJS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 2 Dec 2022 20:09:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235054AbiLCBJR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 2 Dec 2022 20:09:17 -0500
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9976398EB1;
        Fri,  2 Dec 2022 17:09:16 -0800 (PST)
Received: by mail-io1-xd31.google.com with SMTP id e189so4192514iof.1;
        Fri, 02 Dec 2022 17:09:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=k515FecbjI08DAyTf4c8VtdjGdTjE71XYVDsJ0hdO0g=;
        b=ChioXhnbIHyu9u/s1gWmLLEN943wPZCRReMjzOzlQx2IkbVO6AgiHfd9l7iDWHUEP4
         wQs4+HsCMHiDvxF5bQDHBhV6FOIQMIkwVVhdKF2UUGGm/wuAKFrq6L0mmpPhhVI4vCZB
         zr77/IoqV1hGK/zRS9hhZ+28ZJtXiR16EmbSoL0jbWALV+QSRKKux/hKZF6nlTocZOVm
         x4vsxsPtogzAXlj5/PSftOmPwu4FXLIyMnTF9k2bQ7KRkrCb2AK1MuEgEPLcpjXNIYe/
         DJBPfHrU9RYlRf1vQIE3CShOtzx9AI8NTBlEmFpEPqO3m7QmuZA3IZaw5zeHak9SDJUQ
         EKHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k515FecbjI08DAyTf4c8VtdjGdTjE71XYVDsJ0hdO0g=;
        b=U5oHO62mETxjlZjmDqlogtoiFVgKDgIYOFtoylafChf5Jw+11Vl38G8NUACsHPLEod
         slRK7yZa8S0svobRP9u/+E4TSVK5LHu2LHD982wRz5d4g3OriWD6n0x78MKuXVCiw0NF
         Ctes9AJ92W+J8WkL/8qPh5baqs9+NW6H1HECV0IAmcE8dwDvB5cPdmSEvwYvr3hS2oti
         MCxYdX1zcgVj6DnkVN59CCZ6paFmYExCGaB/3uv4n/BhRhTrlt+cO1lMMAX6Jx+Nz9FH
         XT/akffO4TgyC/hgT5MD9DRxqc6ke8sv8MoLsZnHI24P3C9rrShpKfNP1YhgSpQDYKQO
         cnWQ==
X-Gm-Message-State: ANoB5plNzdnJeNewBxOUIoYHr+PW1LXAetFpHkB8m7z86XFtbn2m40e9
        78PQEq9Xt/7gEQLMT7jo3saBYBjWMOXOzuFt0jo=
X-Google-Smtp-Source: AA0mqf4dd+jnIlXSjkVK2wK/y3vx8duHXJiqTpw8nY0vU9MXgUH9eZmqPGBQYExL4NPcFyuWsuwcVQ==
X-Received: by 2002:a05:6602:220c:b0:6df:3e12:b640 with SMTP id n12-20020a056602220c00b006df3e12b640mr18142155ion.124.1670029755746;
        Fri, 02 Dec 2022 17:09:15 -0800 (PST)
Received: from james-x399.localdomain (71-33-132-231.hlrn.qwest.net. [71.33.132.231])
        by smtp.gmail.com with ESMTPSA id k17-20020a0566022d9100b006a129b10229sm3252210iow.31.2022.12.02.17.09.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 17:09:15 -0800 (PST)
From:   James Hilliard <james.hilliard1@gmail.com>
To:     bpf@vger.kernel.org
Cc:     James Hilliard <james.hilliard1@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
        Alan Maguire <alan.maguire@oracle.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v2] selftests/bpf: Fix conflicts with built-in functions in bpf_iter_ksym
Date:   Fri,  2 Dec 2022 18:08:44 -0700
Message-Id: <20221203010847.2191265-1-james.hilliard1@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Both tolower and toupper are built in c functions, we should not
redefine them as this can result in a build error.

Fixes the following errors:
progs/bpf_iter_ksym.c:10:20: error: conflicting types for built-in function 'tolower'; expected 'int(int)' [-Werror=builtin-declaration-mismatch]
   10 | static inline char tolower(char c)
      |                    ^~~~~~~
progs/bpf_iter_ksym.c:5:1: note: 'tolower' is declared in header '<ctype.h>'
    4 | #include <bpf/bpf_helpers.h>
  +++ |+#include <ctype.h>
    5 |
progs/bpf_iter_ksym.c:17:20: error: conflicting types for built-in function 'toupper'; expected 'int(int)' [-Werror=builtin-declaration-mismatch]
   17 | static inline char toupper(char c)
      |                    ^~~~~~~
progs/bpf_iter_ksym.c:17:20: note: 'toupper' is declared in header '<ctype.h>'

See background on this sort of issue:
https://stackoverflow.com/a/20582607
https://gcc.gnu.org/bugzilla/show_bug.cgi?id=12213

(C99, 7.1.3p1) "All identifiers with external linkage in any of the
following subclauses (including the future library directions) are
always reserved for use as identifiers with external linkage."

This is documented behavior in GCC:
https://gcc.gnu.org/onlinedocs/gcc/Other-Builtins.html#index-std-2

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
---
Changes v1 -> v2:
  - add more details
---
 tools/testing/selftests/bpf/progs/bpf_iter_ksym.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/bpf_iter_ksym.c b/tools/testing/selftests/bpf/progs/bpf_iter_ksym.c
index 285c008cbf9c..9ba14c37bbcc 100644
--- a/tools/testing/selftests/bpf/progs/bpf_iter_ksym.c
+++ b/tools/testing/selftests/bpf/progs/bpf_iter_ksym.c
@@ -7,14 +7,14 @@ char _license[] SEC("license") = "GPL";
 
 unsigned long last_sym_value = 0;
 
-static inline char tolower(char c)
+static inline char to_lower(char c)
 {
 	if (c >= 'A' && c <= 'Z')
 		c += ('a' - 'A');
 	return c;
 }
 
-static inline char toupper(char c)
+static inline char to_upper(char c)
 {
 	if (c >= 'a' && c <= 'z')
 		c -= ('a' - 'A');
@@ -54,7 +54,7 @@ int dump_ksym(struct bpf_iter__ksym *ctx)
 	type = iter->type;
 
 	if (iter->module_name[0]) {
-		type = iter->exported ? toupper(type) : tolower(type);
+		type = iter->exported ? to_upper(type) : to_lower(type);
 		BPF_SEQ_PRINTF(seq, "0x%llx %c %s [ %s ] ",
 			       value, type, iter->name, iter->module_name);
 	} else {
-- 
2.34.1

