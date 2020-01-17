Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8241F140F5D
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Jan 2020 17:54:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729138AbgAQQyG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 17 Jan 2020 11:54:06 -0500
Received: from mail-il1-f195.google.com ([209.85.166.195]:41900 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729129AbgAQQyF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 17 Jan 2020 11:54:05 -0500
Received: by mail-il1-f195.google.com with SMTP id f10so21787063ils.8
        for <linux-kselftest@vger.kernel.org>; Fri, 17 Jan 2020 08:54:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=brzZaUJh7FW1ka56Adtf/85XWoAeQqVQT/Er0invsYs=;
        b=SZtwdh2oqjI+UBiZ9BSi5WKvwkiUFyfwGoVa2E3NdmvReO0bKyMmTi7Ubdbzdm1zYx
         j/dvlz0YjLN6po1K1VfcfjAdHKCvHItvP3Fh0gJV3ri9ioJU/CfhoGK21WXnfbbiT9Ji
         VousTxLZB3mEZQk6cxudxSPYWMu4CwYT2N1RfGnbN5M51Qg1EEcVToajht0YCvQ0kEfi
         aFDZVWqMkJNUKyTuLZY22D6P6bg1mg5zo/PuTI9B2KNZ9AMzwyoslvWMmqdQS7Se9uAT
         caEUvK8/k9nEXVFSzcrVcZBzcRGDYYGKFiV5c/iPuhhat3MwI0pN5oV/tk6ytlYWaiwu
         EiUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=brzZaUJh7FW1ka56Adtf/85XWoAeQqVQT/Er0invsYs=;
        b=rfw8Eg/JYnqH5NHWhq5N1/kSafeeFs+uIj0Pl2sHAbw7uoKxYrVCbvO4Ymvbv+lInY
         SY3VhOd3TEQCU4JTcTFXbpCJtKNrChCfIAu7LdHa0Xn80y1+mvbhoSaF4hNqbwJiTptY
         Gwz2Uf3+m/jrZTnljUYAcFsKI+Y/Fp03sz3+rCmMFEDrVn3s3PEgALmMxWcHK3AEpB7l
         Om1rN3gRII0/98rYu2iCTg7NmF9cvumgVc+vn8xU/rCycQqG45REcCMzNJ7BBqii69uu
         z+m96eWDq/TCxVEckzQD/o+AxM4+O3Zg/WwpZH1CHYvBUxJJppqIcevxIRrmjh4VItqv
         D8Qw==
X-Gm-Message-State: APjAAAUJ25gQaFE7W5fKDLF98q33vSZzMs8nrvHXQ30wQhRMLUZDS0uZ
        QXds9GVulDdW1Z3HlYib/thpXw==
X-Google-Smtp-Source: APXvYqwYn6A64W6RYQdcSAW8Dx+vuADYJTH0IldHuTPwJSaUgo9yYVECtHmkSACxkdEpECMiMT5HEw==
X-Received: by 2002:a92:4013:: with SMTP id n19mr3718111ila.279.1579280044000;
        Fri, 17 Jan 2020 08:54:04 -0800 (PST)
Received: from alago.cortijodelrio.net (CableLink-189-219-74-147.Hosts.InterCable.net. [189.219.74.147])
        by smtp.googlemail.com with ESMTPSA id f16sm8120662ilq.16.2020.01.17.08.54.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 08:54:03 -0800 (PST)
From:   =?UTF-8?q?Daniel=20D=C3=ADaz?= <daniel.diaz@linaro.org>
To:     shuah@kernel.org
Cc:     =?UTF-8?q?Daniel=20D=C3=ADaz?= <daniel.diaz@linaro.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        linux-kernel@vger.kernel.org (open list:RESTARTABLE SEQUENCES SUPPORT),
        linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK)
Subject: [PATCH 2/3] selftests/rseq: Build with LDFLAGS
Date:   Fri, 17 Jan 2020 10:53:27 -0600
Message-Id: <20200117165330.17015-2-daniel.diaz@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200117165330.17015-1-daniel.diaz@linaro.org>
References: <20200117165330.17015-1-daniel.diaz@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

During cross-compilation, it was discovered that LDFLAGS were
not being used while building binaries, leading to defaults
which were not necessarily correct.

OpenEmbedded reported this kind of problem:
  ERROR: QA Issue: No GNU_HASH in the ELF binary [...], didn't pass LDFLAGS?

Signed-off-by: Daniel Díaz <daniel.diaz@linaro.org>
---
 tools/testing/selftests/rseq/Makefile | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/rseq/Makefile b/tools/testing/selftests/rseq/Makefile
index d6469535630a..2d2d0c283de1 100644
--- a/tools/testing/selftests/rseq/Makefile
+++ b/tools/testing/selftests/rseq/Makefile
@@ -22,15 +22,15 @@ TEST_PROGS = run_param_test.sh
 include ../lib.mk
 
 $(OUTPUT)/librseq.so: rseq.c rseq.h rseq-*.h
-	$(CC) $(CFLAGS) -shared -fPIC $< $(LDLIBS) -o $@
+	$(CC) $(CFLAGS) $(LDFLAGS) -shared -fPIC $< $(LDLIBS) -o $@
 
 $(OUTPUT)/%: %.c $(TEST_GEN_PROGS_EXTENDED) rseq.h rseq-*.h
-	$(CC) $(CFLAGS) $< $(LDLIBS) -lrseq -o $@
+	$(CC) $(CFLAGS) $(LDFLAGS) $< $(LDLIBS) -lrseq -o $@
 
 $(OUTPUT)/param_test_benchmark: param_test.c $(TEST_GEN_PROGS_EXTENDED) \
 					rseq.h rseq-*.h
-	$(CC) $(CFLAGS) -DBENCHMARK $< $(LDLIBS) -lrseq -o $@
+	$(CC) $(CFLAGS) $(LDFLAGS) -DBENCHMARK $< $(LDLIBS) -lrseq -o $@
 
 $(OUTPUT)/param_test_compare_twice: param_test.c $(TEST_GEN_PROGS_EXTENDED) \
 					rseq.h rseq-*.h
-	$(CC) $(CFLAGS) -DRSEQ_COMPARE_TWICE $< $(LDLIBS) -lrseq -o $@
+	$(CC) $(CFLAGS) $(LDFLAGS) -DRSEQ_COMPARE_TWICE $< $(LDLIBS) -lrseq -o $@
-- 
2.20.1

