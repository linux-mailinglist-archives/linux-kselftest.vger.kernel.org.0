Return-Path: <linux-kselftest+bounces-33862-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 490D1AC50D5
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 May 2025 16:25:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 846223A7F8C
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 May 2025 14:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9249279904;
	Tue, 27 May 2025 14:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="isNa4KZP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AA652798EC
	for <linux-kselftest@vger.kernel.org>; Tue, 27 May 2025 14:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748355892; cv=none; b=KatzhylknBR/NNgjUf6tpmijsThJRBGMOyvQRaqx++xtZYqM61o+JQfQSZldNOeY73KWvaqe+UTggaHsbVTzTwvCFwiw7er6mwvXk+08Ykdr3FxpceVAYceeSueeh09MIZvQ0muK5l8zctEXtAOORf7QXwLxbmC/THVmfRryP7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748355892; c=relaxed/simple;
	bh=VzQyPkruYWrDZAOkmL/UT3N0xShjKnGR9pQJo0jQ/Qk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ebsgMFyyFqrhEb+3dW+EOfLsn03asjk8QmV71MeUi169m+tP9f3Lhcetf2QC2US0+h0mE8KR+wRSNzOFar+vKVpmwCtyri2TB34U5byUfwO17HENWnn3Lc6POhGWpCBYE75V6C3jfKYxxa0DUI6KJa+KV/XzJWbX8KAqsI6PSj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=isNa4KZP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748355890;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AdRsO2Uefrz8JMO751IFZEkS7KH/EcFqwNDUBdHYAOY=;
	b=isNa4KZPJ+VcGx5frg6XDT2aeQuCkcjf7q/qz7kVN7I5Rnqwb5LCSvTVCsD/0WbRHj4KFH
	EzeohJ4+ScecvrX8JENo1MQjKYEv8sUFOBlPg4jBcehzlz1QjAHc0HSE5p3+bBAEMm+QYB
	eBue7dM1Lb6STGcDg+2eGcy4LB6SYDI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-48-e9ArKJoYMJmMIzHUGiqilA-1; Tue, 27 May 2025 10:24:45 -0400
X-MC-Unique: e9ArKJoYMJmMIzHUGiqilA-1
X-Mimecast-MFC-AGG-ID: e9ArKJoYMJmMIzHUGiqilA_1748355885
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-44b1f5b8e9dso13016395e9.2
        for <linux-kselftest@vger.kernel.org>; Tue, 27 May 2025 07:24:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748355884; x=1748960684;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AdRsO2Uefrz8JMO751IFZEkS7KH/EcFqwNDUBdHYAOY=;
        b=QiqGpUQnKY7SIaDexfG9GusO+unln4iaXSTk+oUPXvmbxSCeOLUMfFG17NGzgHrl6A
         tPOUrVxeuJ5QJ6A1x3sgiIKkaz9WocpoLr9lUwj8MXH7whQIMJQVqoIk9haWF67V4ljO
         lOFbYGxGgjnsoI5410sRagNR1WgPg3+Zm6Eg/bjvIrz8LFEmKkjLcgavgBg4KZqq/mHn
         K1VuLbtk20AHazx0iaq6quMEBNo3ovDMGaLCV1UxxJ3GPGtANJkpDY6qb8UTojvLb279
         xNk6A6mkJtf1NIy9B2lIaBp7kQPlXoxZfRPdc0/EOQJ4veVAzE6fjNDRE/RqTMJJ3K/g
         b+4Q==
X-Forwarded-Encrypted: i=1; AJvYcCW9rQ6YZjkzIGw/UrkgP+7cflSt2T5XlrA3EV1R7nKpHIW5leDtpRiviiaeA30mlhlvfIBDKPo3b5WdNygPoOc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7L2XDK+Jv3zzOqBZoWYk9Fc5lpKX2oScq0HNBV3Z9HMk2NUar
	zkqRwUOQoBtNnmAUc+nBITw0VuvvHEKmVHZFIXYuEt1PBVnuQUubyGCg4fu8/W40KdN9T8C99V3
	ju00X8Rn1VhiJmMDACcR6ICWFPMX4ZrM5iemzREsgJoUzB+dJT7go51/CoKWsQSUn/M8aHw==
X-Gm-Gg: ASbGnct8gv7D3VIBxWUrmi/9ggkiJaefP9aHDitM1cZCezgKCAqzqUoMT51iZ1tO12Q
	KaZ63PO+SDEjhBmzbxxl9IJy5KygptVSMT8JkZ+qsPhXMBq0mJdxl3ggRLH54o6+P0tLDAim/Zv
	V6sXFfcFnozf/0Vo3HBv/wUDr9wuR7WLhjKddeKxTBgogjWsrF0Tbig1ryX3ouSRbcETHtzsL/h
	/8R4o+Vqkq5wNMoy9JFGQMJgylGq9E/BmPw7i4As3vYJ6xXm01lvrbGFdZas5SAtzWInCgQ5xf6
	XXOcmXeKUQAB+53lfnFCMkhpb/VZ7OWtvX/7FPynntXmgjQDCpiQn2Yr5O6YlGyEOr6bzB7Z3A=
	=
X-Received: by 2002:a05:600c:35d3:b0:43d:4e9:27ff with SMTP id 5b1f17b1804b1-44c93016587mr106055915e9.7.1748355884587;
        Tue, 27 May 2025 07:24:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGA8HR0A+QTW5CLIzzWpCQrdDEVxcSOCyoGFkafJofsp5nJGXbEA7AFPSlzJnet1RbsnO2sOA==
X-Received: by 2002:a05:600c:35d3:b0:43d:4e9:27ff with SMTP id 5b1f17b1804b1-44c93016587mr106055565e9.7.1748355884133;
        Tue, 27 May 2025 07:24:44 -0700 (PDT)
Received: from rh.fritz.box (p200300f6af1bce00e6fe5f11c0a7f4a1.dip0.t-ipconnect.de. [2003:f6:af1b:ce00:e6fe:5f11:c0a7:f4a1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-447f73d3edcsm278766415e9.20.2025.05.27.07.24.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 May 2025 07:24:43 -0700 (PDT)
From: Sebastian Ott <sebott@redhat.com>
To: Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>
Cc: Colton Lewis <coltonlewis@google.com>,
	Ricardo Koller <ricarkol@google.com>,
	Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Shuah Khan <shuah@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Sebastian Ott <sebott@redhat.com>
Subject: [PATCH v2 1/3] KVM: arm64: selftests: fix help text for arch_timer_edge_cases
Date: Tue, 27 May 2025 16:24:32 +0200
Message-ID: <20250527142434.25209-2-sebott@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250527142434.25209-1-sebott@redhat.com>
References: <20250527142434.25209-1-sebott@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix the help text for arch_timer_edge_cases to show the correct
option for setting the wait time.

Signed-off-by: Sebastian Ott <sebott@redhat.com>
---
 tools/testing/selftests/kvm/arm64/arch_timer_edge_cases.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/arm64/arch_timer_edge_cases.c b/tools/testing/selftests/kvm/arm64/arch_timer_edge_cases.c
index a36a7e2db434..c4716e0c1438 100644
--- a/tools/testing/selftests/kvm/arm64/arch_timer_edge_cases.c
+++ b/tools/testing/selftests/kvm/arm64/arch_timer_edge_cases.c
@@ -986,7 +986,7 @@ static void test_print_help(char *name)
 	pr_info("\t-b: Test both physical and virtual timers (default: true)\n");
 	pr_info("\t-l: Delta (in ms) used for long wait time test (default: %u)\n",
 	     LONG_WAIT_TEST_MS);
-	pr_info("\t-l: Delta (in ms) used for wait times (default: %u)\n",
+	pr_info("\t-w: Delta (in ms) used for wait times (default: %u)\n",
 		WAIT_TEST_MS);
 	pr_info("\t-p: Test physical timer (default: true)\n");
 	pr_info("\t-v: Test virtual timer (default: true)\n");
-- 
2.49.0


