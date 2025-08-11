Return-Path: <linux-kselftest+bounces-38664-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C1697B201BC
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Aug 2025 10:25:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 779CE3A3706
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Aug 2025 08:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10CCB299A9E;
	Mon, 11 Aug 2025 08:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gj+r8fkM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f194.google.com (mail-pg1-f194.google.com [209.85.215.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F3311E2307;
	Mon, 11 Aug 2025 08:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754900704; cv=none; b=AoYv04ed6ZmypF+OGvCzLLvFoqQANS1bLv3smdyGduAfazGNTwDJW7CU8276N7HilufMTTjrmCUY0FYMoAnHcGWbVi+LkTKA3Y1Sd7O2cGWJgoSjXETGL3C4moeJxZwe9J7FHox3dKMiJLop/CGfsKg9UL1lkqgyyHEVM7p+2QI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754900704; c=relaxed/simple;
	bh=s97S7bP6x6rwpTfBP4ZrwaPn0XbN6neEY1ya36wm4Oc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qcPa4cWlf/EGIHVwFp4RkcWMW5g5fQw6+NqG4BD4MpN4QLaMtDEgDcEiPXe+6TM749+urG7EQajwwYyW7Tu+/pa+mIz1p4SC1RZp+kGPQsWWtyBqe8O7AVhZm6G7HS+QuF4Y39ve31a5DffLi1NPkhzBrvcIVPbXKyqO3JLWa6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gj+r8fkM; arc=none smtp.client-ip=209.85.215.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f194.google.com with SMTP id 41be03b00d2f7-b271f3ae786so3140851a12.3;
        Mon, 11 Aug 2025 01:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754900701; x=1755505501; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=x7IicRSCc1Qm6PnM7hIkmjKFTLHGMpXrZ4wc/cEf1z4=;
        b=Gj+r8fkMigsOlcpTF5isiPrTzWg6/83VLrxj20BGJ+lSR5bYq9DIFecPjUDqx2AfAw
         jsABUNfwBGURbf7+Yqq0GgzSKn8PB35hRMDE3HzpU8Id3oTnq76KbDFTFDflbZUTTqDR
         ObEsfDFrpk5tAEfdWKcovgZ/uSP/n3/Plubn09yB5QxzCziDkA+lvU/ZIb2qEIUEtlCK
         W0IqNQD3PgUraInEzir2PY2PxElQXZZDKvZ45nu3K3UHh+ewCu+bXXvfo1dkzu9NaDjQ
         O90Uy9AmZrvD2Ltvkd5TfxD99chDpN1MbhCZa9ABQHTBBSE931rejU6t2ej1+prnbHE2
         HY0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754900701; x=1755505501;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x7IicRSCc1Qm6PnM7hIkmjKFTLHGMpXrZ4wc/cEf1z4=;
        b=cewQL4+CSO55w09T74MVW6PPvtC0UD78ylEbBYA6XT7Bi+POPSK8RnVDEaJZJ63lMR
         +MwQJwrPOZL55QRj8aYk5UH32nel0h1MNqWkAiPnQnHTw1XYIOiGpmEKzbDNxtKsVKx3
         nq9nzkIHYgJgl9qjMhAFpGI0cfxDfh/RvAjeKZE++EFyb5qkCAyu4SFfvrzlFHohGsQC
         qCDYRsMxljfc0ubT66NBXGHMOh8YJFznJoCRfeNgYCxwO4EbGua8TqKbnQqBT9yEpIki
         1qGT4dv9mi+9d/CgMi8TDeCLqkWDbVpuiYso0RciU9KE0RxRjgYn3lgvwNM8+4ZqUGRv
         0MFA==
X-Forwarded-Encrypted: i=1; AJvYcCU9KEBO5pFXNnTFRdcxtnbfzER22PEGhO8vQ8NWaBx1k6mwC4m8WFizHRaFpYHsKJZKWZ9SB2hoMMlAl0c=@vger.kernel.org, AJvYcCXdm+ZybTzI9q2Bqs6i/2UEBGUc30Oc6uHaM1N4J+bzaDvtHmA8zyHv+LVWajQOB3NIDHzqmt74//QPBMWVPV41@vger.kernel.org
X-Gm-Message-State: AOJu0YxEWt81EU9LyfZpz18QlYnKGNZTwURFFNPs290cTNOpgMQNc17p
	UYn6XNLTg4u3jBwVsMGFW/KIbLnqvtk7pO6kKpYqMXCfO6tWfToO0ftZ
X-Gm-Gg: ASbGncsz1zu3dTXAczQ7HrWpI80wXDPj5m0qWHUbpAtMTrLmeoCjHTS5Sq7Ojnbn1AS
	vR2dTIm3pYnROhsx0p4/CtNbHialHmI5DPNvRRxPjOc+g/moNVAds4JXk1BqYZG9xu95FnUOm5R
	vCsvMmNeMbjpVtYYFlBGbHIWkseEkGa9aZ3MZ/Z4GrdI6K1z+NsNAbBCeLNG7InnlnKuUOqtb4s
	Fm2UYAwaoBVJ5lZuzqlnFWVHquYIrsjbx7MtgIlsVOqd4p8N7TZblAq/4v/6qtWG+9/MYCkscLn
	ZVclfcpD9S2qPvzY5UPgOVLza5HN+r9H44QcnlEeJMqdh5WPASrvz/yu7cpI0dulbGc1ha5D7p3
	fpPqIl8xayop7htoMCth/0i9cpWVAK2LuLogUvmra41k=
X-Google-Smtp-Source: AGHT+IFOTH73jUw3CoKj2TbxuK1bCZdXf6eo1J3MQvAMqRVomnu/NfRgRLcFs5Zzs6EzYh8/6U3u+w==
X-Received: by 2002:a17:90b:4b0a:b0:321:265a:e0b6 with SMTP id 98e67ed59e1d1-32183b406f6mr15519305a91.20.1754900701315;
        Mon, 11 Aug 2025 01:25:01 -0700 (PDT)
Received: from days-ASUSLaptop.lan ([45.67.200.227])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32160ae5eb5sm14015812a91.0.2025.08.11.01.24.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 01:25:00 -0700 (PDT)
From: Dong Yang <dayss1224@gmail.com>
To: pbonzini@redhat.com,
	shuah@kernel.org
Cc: kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	maobibo@loongson.cn,
	chenhaucai@kernel.org,
	Dong Yang <dayss1224@gmail.com>,
	Quan Zhou <zhouquan@iscas.ac.cn>
Subject: [PATCH] KVM: loongarch: selftests: Remove common tests built by TEST_GEN_PROGS_COMMON
Date: Mon, 11 Aug 2025 16:24:53 +0800
Message-Id: <20250811082453.1167448-1-dayss1224@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove the common KVM test cases already added to TEST_GEN_PROGS_COMMON
 as following:

	demand_paging_test
	dirty_log_test
	guest_print_test
	kvm_binary_stats_test
	kvm_create_max_vcpus
	kvm_page_table_test
	set_memory_region_test

Fixes: a867688c8cbb ("KVM: selftests: Add supported test cases for LoongArch")
Signed-off-by: Quan Zhou <zhouquan@iscas.ac.cn>
Signed-off-by: Dong Yang <dayss1224@gmail.com>
---
 tools/testing/selftests/kvm/Makefile.kvm | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
index 38b95998e1e6..d2ad85a8839f 100644
--- a/tools/testing/selftests/kvm/Makefile.kvm
+++ b/tools/testing/selftests/kvm/Makefile.kvm
@@ -199,17 +199,10 @@ TEST_GEN_PROGS_riscv += get-reg-list
 TEST_GEN_PROGS_riscv += steal_time
 
 TEST_GEN_PROGS_loongarch += coalesced_io_test
-TEST_GEN_PROGS_loongarch += demand_paging_test
 TEST_GEN_PROGS_loongarch += dirty_log_perf_test
-TEST_GEN_PROGS_loongarch += dirty_log_test
-TEST_GEN_PROGS_loongarch += guest_print_test
 TEST_GEN_PROGS_loongarch += hardware_disable_test
-TEST_GEN_PROGS_loongarch += kvm_binary_stats_test
-TEST_GEN_PROGS_loongarch += kvm_create_max_vcpus
-TEST_GEN_PROGS_loongarch += kvm_page_table_test
 TEST_GEN_PROGS_loongarch += memslot_modification_stress_test
 TEST_GEN_PROGS_loongarch += memslot_perf_test
-TEST_GEN_PROGS_loongarch += set_memory_region_test
 
 SPLIT_TESTS += arch_timer
 SPLIT_TESTS += get-reg-list
-- 
2.34.1


