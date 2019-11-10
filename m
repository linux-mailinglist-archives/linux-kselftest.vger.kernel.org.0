Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 44330F6826
	for <lists+linux-kselftest@lfdr.de>; Sun, 10 Nov 2019 10:26:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726799AbfKJJ0f (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 10 Nov 2019 04:26:35 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:34594 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726770AbfKJJ0f (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 10 Nov 2019 04:26:35 -0500
Received: by mail-lj1-f194.google.com with SMTP id 139so10600480ljf.1
        for <linux-kselftest@vger.kernel.org>; Sun, 10 Nov 2019 01:26:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8aI8sjWlub3zpRJ8r4fpaJqD6GY3bsTASrTbl6sw7ss=;
        b=tvNtpFENS2mmFCAqz/ZOTYdjpoYKxyEk/pGN2a6uoO/Ao9sK+hHbCf2xaMd6Z1PAVY
         fB1Gal2+zjYVmE9alTs+fL4oQ3XRcTYXiUQsTvaJfh7sAw3GBfBJLrIcNBc3fFbWJeiR
         z1OoyPwAC8sOre56oJbVcH34BP07YSOVOqpSCL6CMfIdqcxHEGiCR7IPDOjVCBhvog8o
         cA2JwDdUoGXwY0+nz1dhVWA16Majv/9Si1mdVbGZ0AVXgQg6pq11oXlHz/mMptwKOBXk
         PU/DBrY3cchclak3Hhw8zXWwz/j7oDJBLly1iei0nU8oMKTgVK5vY0UmBu0eWHm00l/N
         WLxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8aI8sjWlub3zpRJ8r4fpaJqD6GY3bsTASrTbl6sw7ss=;
        b=QZKn4EuURn5jas5+963I4nMFItSIcRRPvkVLT3JbunNv/89eF2j9S2FnCZvnBxkWFm
         f3CknrKchrPUkmdAzxSrxZnNmMzp8Vtr4Gni35gJY9k2SIXq3n695pGUwSrXsFZVmOqx
         kElN4+94L2rovvraMthLiNkbs69G/f8tJCDmapbbRzzHldJAiIJWiN9HX754HvJCNBsu
         g4PuF/sjLoky+5I3Go0KmIjUAi4YHlzMiCe8CFsEiwY2FdJWaeCS7zMduNkv6D2l7rpW
         LsQcJ55+6XiOC/Nphv8TaN7eCMMfWseKkq8bPn83WTGFE+7YR68/4RU22z2+aYIPsT0F
         ukGw==
X-Gm-Message-State: APjAAAWpd6MCiKNdcunNUVLq20YsX+KycCs49oXoKD7hitDTfQP8ao7X
        eQWQfWPK4ZuljQcI3TIAjF+8Pg==
X-Google-Smtp-Source: APXvYqwcNJQjyfscWvq/5dHrCVAAp4pAqlltqEM8iziSqRzOTqevSOlTqB1O8P1FgFUO7gykSFzasw==
X-Received: by 2002:a2e:5c46:: with SMTP id q67mr11997066ljb.42.1573377991746;
        Sun, 10 Nov 2019 01:26:31 -0800 (PST)
Received: from localhost (c-413e70d5.07-21-73746f28.bbcust.telenor.se. [213.112.62.65])
        by smtp.gmail.com with ESMTPSA id o15sm5362013ljc.28.2019.11.10.01.26.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Nov 2019 01:26:31 -0800 (PST)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     ast@kernel.org, daniel@iogearbox.net, davem@davemloft.net
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        shuah@kernel.org, songliubraving@fb.com,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH bpf-next 2/2] selftests: bpf: test_tc_edt: add missing object file to TEST_FILES
Date:   Sun, 10 Nov 2019 10:26:16 +0100
Message-Id: <20191110092616.24842-2-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191110092616.24842-1-anders.roxell@linaro.org>
References: <20191110092616.24842-1-anders.roxell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

When installing kselftests to its own directory and running the
test_tc_edt.sh it will complain that test_tc_edt.o can't be find.

$ ./test_tc_edt.sh
Error opening object test_tc_edt.o: No such file or directory
Object hashing failed!
Cannot initialize ELF context!
Unable to load program

Rework to add test_tc_edt.o to TEST_FILES so the object file gets
installed when installing kselftest.

Fixes: 74b5a5968fe8 ("selftests/bpf: Replace test_progs and test_maps w/ general rule")
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
Acked-by: Song Liu <songliubraving@fb.com>
---
 tools/testing/selftests/bpf/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index cc09b5df9403..b03dc2298fea 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -38,7 +38,8 @@ TEST_GEN_PROGS += test_progs-bpf_gcc
 endif
 
 TEST_GEN_FILES =
-TEST_FILES = test_lwt_ip_encap.o
+TEST_FILES = test_lwt_ip_encap.o \
+	test_tc_edt.o
 
 # Order correspond to 'make run_tests' order
 TEST_PROGS := test_kmod.sh \
-- 
2.20.1

