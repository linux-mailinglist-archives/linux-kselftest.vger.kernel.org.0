Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE0C7F6820
	for <lists+linux-kselftest@lfdr.de>; Sun, 10 Nov 2019 10:26:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726692AbfKJJ03 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 10 Nov 2019 04:26:29 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:41966 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726681AbfKJJ03 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 10 Nov 2019 04:26:29 -0500
Received: by mail-lj1-f194.google.com with SMTP id m9so10577921ljh.8
        for <linux-kselftest@vger.kernel.org>; Sun, 10 Nov 2019 01:26:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=K1ej7rxXZvVCH8e1mzSa2PqgvsoRf/talUhoLH+H5BM=;
        b=jGAyzSJNgenepOVDpgcoatW8FvxiXgtBo/+3uCvrRidklsARm0qBnq/OVU2ZYt+k3t
         lbciLJwZnuaTH5pHq+lA8p4tv0BQ3C7bu8ZUYB7OR8SrcvTAQfh8vju4TwrSQdxEl2t/
         nGAtHEAn6m/zUwf8SOR2+BO81w4VgdwP24D688iBRGhFOHb6nwOi282+0ybql1qghlpJ
         7HRZQy+t8KHnzfn++ys2iPclUzLK9BapzxIIc1d7YECz4uF2ZKsLNbP7fOmtLqyn14vm
         sVLYplkorsExiVXqYifD57Mzrqu8q5bkhrVGXjvpr6fjX0YtlJEmz/r+ozXRUe6ogjxu
         4vTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=K1ej7rxXZvVCH8e1mzSa2PqgvsoRf/talUhoLH+H5BM=;
        b=VUUosgOAD9OLYpv4KTWusLCweTtAaLePSEWXcaZIJ2z2e+aRia86X0UZqgukI6lgJI
         hVz6AmKGT9X8diD8za3m9atebqhcvSWbmMJkDyxtWWcOCNRVNOVHdbI75PDUeYsyMncF
         uuSYcFbcMZDPXJ5lL6BsLZnb5sUvImbGk3ss36hXmAZWaps18G3zlaB+qOYzNt0bLWaX
         l9fjNZtkLVBjqmRwG/m/Vy07SVolx8fNg/Gkpsk9/QFk45J5b/d0ANpcOyOfxZ0xeJJw
         RnBgaAqtbOxoBHVtCox/d/8iPypXAeFCnrAW+J6u2x/x+kgETsrDX0c9rZoIUJv2KyI7
         63Og==
X-Gm-Message-State: APjAAAVoCyEY9iQAv6GXqiGq6zap0ZcxNV/6s2dIqCGtQ021+yltNyGM
        eDPXfzi2FLfgJJpbRY1FRaBAQA==
X-Google-Smtp-Source: APXvYqx3plopljkgMoHmlCt+ix4ylDYZb5YkeDOw0zRMV6mx/YEOEJ/1CxAwrBtSx3dm+g1s0hN45A==
X-Received: by 2002:a2e:9985:: with SMTP id w5mr11953032lji.162.1573377987220;
        Sun, 10 Nov 2019 01:26:27 -0800 (PST)
Received: from localhost (c-413e70d5.07-21-73746f28.bbcust.telenor.se. [213.112.62.65])
        by smtp.gmail.com with ESMTPSA id k19sm6048059ljg.18.2019.11.10.01.26.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Nov 2019 01:26:26 -0800 (PST)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     ast@kernel.org, daniel@iogearbox.net, davem@davemloft.net
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        shuah@kernel.org, songliubraving@fb.com,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH bpf-next 1/2] selftests: bpf: test_lwt_ip_encap: add missing object file to TEST_FILES
Date:   Sun, 10 Nov 2019 10:26:15 +0100
Message-Id: <20191110092616.24842-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

When installing kselftests to its own directory and running the
test_lwt_ip_encap.sh it will complain that test_lwt_ip_encap.o can't be
find.

$ ./test_lwt_ip_encap.sh
starting egress IPv4 encap test
Error opening object test_lwt_ip_encap.o: No such file or directory
Object hashing failed!
Cannot initialize ELF context!
Failed to parse eBPF program: Invalid argument

Rework to add test_lwt_ip_encap.o to TEST_FILES so the object file gets
installed when installing kselftest.

Fixes: 74b5a5968fe8 ("selftests/bpf: Replace test_progs and test_maps w/ general rule")
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
Acked-by: Song Liu <songliubraving@fb.com>
---
 tools/testing/selftests/bpf/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index b334a6db15c1..cc09b5df9403 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -38,7 +38,7 @@ TEST_GEN_PROGS += test_progs-bpf_gcc
 endif
 
 TEST_GEN_FILES =
-TEST_FILES =
+TEST_FILES = test_lwt_ip_encap.o
 
 # Order correspond to 'make run_tests' order
 TEST_PROGS := test_kmod.sh \
-- 
2.20.1

