Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E8E52F501F
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Jan 2021 17:36:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727720AbhAMQgO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 13 Jan 2021 11:36:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727713AbhAMQgO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 13 Jan 2021 11:36:14 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00261C0617A7
        for <linux-kselftest@vger.kernel.org>; Wed, 13 Jan 2021 08:34:57 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id b9so4025911ejy.0
        for <linux-kselftest@vger.kernel.org>; Wed, 13 Jan 2021 08:34:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BdIvDbIaLfjihhRkhU5/HCzUvJ+o4x5+Y+DliwVMXI0=;
        b=hxRotWBElbEIKPd54uMcTCedGp59nZYVMAeKuPhfY7dKVGEI7lk+k5HRAf5JslUYyd
         vbFiqyIDHgKPfPUZde154fNm1GroSTz8+gqXxs5MAldGUsy0d8r25SRnnRBp51FUx4lS
         hjStaBFfh2SmbOxvuJRjGvgs1HRwxB6hsd1LMie5HvPVBJ8vI5LkFdC3avjtmtZtcccy
         RHWn8tbkEOMWD+W/7LHYCJ6fT0y6JvlSBsLY3cFI9YAakurrVZSPB3M9/o8u0PDNOKf5
         S+fVjAY3aO2aqeSfdjuNPnwhhFsaOqqI2Z12SRuFv262uPbmwGRGZUbzQqE/5GbZmhpY
         QxyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BdIvDbIaLfjihhRkhU5/HCzUvJ+o4x5+Y+DliwVMXI0=;
        b=AeE3W5HfjfVNe4QCM8DkP7/CvI4T07YKREhnzLowXVkbtxWpZP8h8VRmH/Zgx27Jnt
         6zJuTweDZsTXFauGzCli/2VXHSXyEH+yYvUYsG3BloSmv8PaPD2XMAtHHOjaYjTjZszq
         1D7mu5frweM6w4k9uQGQ3ELFYzJ8E6vUATn2RleB3kQr5atJxiH8LeBhAdM0Mhdu8i6w
         nRFrCeJXXtcTAJ4QqbD6meJOznIXspFw5jovga0trBbO2vMzQlFX/2kGf//SDUtrNlvf
         OpkGjsa6JLWviuF8n+f45mvYMDh6uRrTyvQ+0gFyiDwMcJtadxDdEMmMCP1/c2Ne68+N
         isJQ==
X-Gm-Message-State: AOAM5308EixpZeyS370nQ3MiEDrpQCMAQnlocxPIzFnhir6hm44omJYi
        ZGr5EGu8m1IiFxP/jVXC2ubVAA==
X-Google-Smtp-Source: ABdhPJxIw5d98gY4xn2J6ZKW1T8RtHRaZ491RfwnxHENsukkA29IZJ+h0+kfMYsI2X45CmHKcS+J8Q==
X-Received: by 2002:a17:906:bc9b:: with SMTP id lv27mr2079635ejb.505.1610555696700;
        Wed, 13 Jan 2021 08:34:56 -0800 (PST)
Received: from localhost.localdomain ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id g25sm923943ejf.15.2021.01.13.08.34.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 08:34:56 -0800 (PST)
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     bpf@vger.kernel.org
Cc:     shuah@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org,
        linux-kselftest@vger.kernel.org,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH bpf-next v2 5/5] selftests/bpf: Install btf_dump test cases
Date:   Wed, 13 Jan 2021 17:33:20 +0100
Message-Id: <20210113163319.1516382-6-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210113163319.1516382-1-jean-philippe@linaro.org>
References: <20210113163319.1516382-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The btf_dump test cannot access the original source files for comparison
when running the selftests out of tree, causing several failures:

awk: btf_dump_test_case_syntax.c: No such file or directory
...

Add those files to $(TEST_FILES) to have "make install" pick them up.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 tools/testing/selftests/bpf/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 0fafdc022ac3..7f8667ad113e 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -46,7 +46,8 @@ endif
 
 TEST_GEN_FILES = test_lwt_ip_encap.o \
 	test_tc_edt.o
-TEST_FILES = xsk_prereqs.sh
+TEST_FILES = xsk_prereqs.sh \
+	$(wildcard progs/btf_dump_test_case_*.c)
 
 # Order correspond to 'make run_tests' order
 TEST_PROGS := test_kmod.sh \
-- 
2.30.0

