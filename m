Return-Path: <linux-kselftest+bounces-39489-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8530B2FB84
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 15:59:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04213B66372
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 13:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A6392EC57B;
	Thu, 21 Aug 2025 13:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LO31eZ33"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC90C2EC570
	for <linux-kselftest@vger.kernel.org>; Thu, 21 Aug 2025 13:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755784496; cv=none; b=YA9DvJe3fr3hd6KvO7lRDY2N0FdmUBXLDnN46GT7vdPOpBUZC73BkmxLAEokHhclZZad/rMDdMLNJLTxhljpvHey9lJTBScx0O3Ul6Yj2QGw/m7jC0GP4k6bDxtZ2OM3ZdxfbyWGBcHPkPpM//whq/t82iDM3iTQNJ4lgmXNZuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755784496; c=relaxed/simple;
	bh=FRZ/dkTH5e7JEyicr5rKwYSZwT6g3H9r7TNIOOAYgss=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=U1+fXSZWhW1LhwsLdDZauy4U7tlj7A9x4R3xMh2aWLElVKYvAlEyLcrMgI4ATeC2bQm21je7adNvvEoanvOBXfOipViq4BeT6MXgBJWos0i+4WXAPU6ZRt/c3GymoPkifTNcXhjWG8yALMfco77dmJSnpKztcg2jID7z0aID56o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--davidgow.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LO31eZ33; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--davidgow.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b471a0e5a33so1832137a12.3
        for <linux-kselftest@vger.kernel.org>; Thu, 21 Aug 2025 06:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755784494; x=1756389294; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=XpTFpmF3LpyMWsoi7YRVPJftCPsO+iVXO+bA6kJHgfU=;
        b=LO31eZ33Rx4MStqcRWDOLK/mE63EmxOKBKoNkGWRctXY1mzyW5mpdQKBsRUpNQEnMv
         zM1PgD/II8xYkUJYKxCq9asq7NNHiimsbwsH9vkC8cCXrIdNNPeMObMA7E731OcuHMfj
         fUp175K3AQzvGBAN0KcIbnbG+ls3NCfSOylHWyAQd8irgzCxCmyYYrHRErcHaSl9VPdQ
         4VMjyhY6wEiHuGQFEKe7XptDCA6MisyI+Rl5pPa1nKs2MG+jCOsO2zdTuuCWhmLcDZch
         Ps4sOYFESuQ09hGhbRL7raRMmYh+AXUncKQ6Uww/mFFiWvZ8V1g66nuxCtZZHKKdsibT
         DvAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755784494; x=1756389294;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XpTFpmF3LpyMWsoi7YRVPJftCPsO+iVXO+bA6kJHgfU=;
        b=Uml0t8lgg6kOCGyTaEKlOtynMFmckoLn8waPo2ru7LAMWoNljdLgcV94eeIYugxErf
         NGht2TAvnTEzTx04WrbxsGtxx4W3W1tjNmESGQMIXP9NuGbK43wuVxhwJWAOROxY/FKh
         t7bbw1xPQUBf5Perc2yx5/Te+lg7DlbTvVrp4uxUVqij9Aw9JZw6fuStOf6PmNDSjQNE
         6j9C10J5R4TU093B4bC2bRSWpI2VMdpQaLiwVwpwzJeiCrlXwVXCbtKO6AY18Q0Y8Zm9
         HuGx7PYDBEqp86KXOmklxAWf6ZhcsQCa6mJu59oPqJnocAmZVBAAZOBlhLDLAE9yrekz
         dqhA==
X-Forwarded-Encrypted: i=1; AJvYcCV7xLf6Mfhj87M5xEVCThedZgayVn+pXrCdZ53yKKKidnuZlin12767c8tvzO35XtxhIZjaEDxKGAjkt8PBVWU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLLqjNGJ3lH3a2JQ3/8vMH/CxygkqT1r8vflPXO81xHwBZlNMd
	ywZ992beAMVj325/cK2FSuP1dkJnEwmx/eqau3tJ8qtWjhd7oOVkYLpJzaWhMR1cJCYy4Y4HwoZ
	nck9cXqe3uEs1SA==
X-Google-Smtp-Source: AGHT+IGJEX7ZclUuZ2o8JPzaPgxqgSiOjHKYAc6KuCEwQ4l/jHJHNh6xVmvyFffzu/3E1KDZ2EtRfnXg3G6H5Q==
X-Received: from pfbmd16.prod.google.com ([2002:a05:6a00:7710:b0:76b:c859:e832])
 (user=davidgow job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:5493:b0:23f:fd87:427c with SMTP id adf61e73a8af0-243307cb3b7mr3418114637.18.1755784494062;
 Thu, 21 Aug 2025 06:54:54 -0700 (PDT)
Date: Thu, 21 Aug 2025 21:54:45 +0800
In-Reply-To: <20250821135447.1618942-1-davidgow@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250821135447.1618942-1-davidgow@google.com>
X-Mailer: git-send-email 2.51.0.rc2.233.g662b1ed5c5-goog
Message-ID: <20250821135447.1618942-2-davidgow@google.com>
Subject: [PATCH v2 2/2] kunit: Only output a test plan if we're using kunit_array_gen_params
From: David Gow <davidgow@google.com>
To: Rae Moar <rmoar@google.com>, Marie Zhussupova <marievic@google.com>, marievictoria875@gmail.com, 
	Rodrigo Vivi <rodrigo.vivi@intel.com>, Shuah Khan <skhan@linuxfoundation.org>
Cc: David Gow <davidgow@google.com>, Stephen Rothwell <sfr@canb.auug.org.au>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>, intel-xe@lists.freedesktop.org, 
	kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

In 6a2a027e254b ("kunit: Enable direct registration of parameter arrays to a KUnit test"),
we now output a test plan for parameterised tests which use parameter
arrays. This uses the size of the array (via the ARRAY_SIZE macro) to
determine the number of subtests, which otherwise was indeterminate.

However some tests (particularly xe_pci.check_platform_gt_count) use
their own gen_params function which further filters the array, resulting
in the test plan being inaccurate (and hence kunit.py failing).

For now, only print the test plan line if the gen_params function is the
provided kunit_array_gen_params. Unfortunately, this catches a lot of
tests which would work, but at least makes sure we don't regress
anything until we can rework how some of these macros function.

Fixes: 6a2a027e254b ("kunit: Enable direct registration of parameter arrays to a KUnit test")
Signed-off-by: David Gow <davidgow@google.com>
---

No changes since v1:
https://lore.kernel.org/linux-kselftest/20250819073434.1411114-2-davidgow@google.com/

(The change was in patch 1.)

---
 lib/kunit/test.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index b661407ad0a3..bb66ea1a3eac 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -732,10 +732,12 @@ int kunit_run_tests(struct kunit_suite *suite)
 				  "KTAP version 1\n");
 			kunit_log(KERN_INFO, &test, KUNIT_SUBTEST_INDENT KUNIT_SUBTEST_INDENT
 				  "# Subtest: %s", test_case->name);
-			if (test.params_array.params)
+			if (test.params_array.params &&
+			    test_case->generate_params == kunit_array_gen_params) {
 				kunit_log(KERN_INFO, &test, KUNIT_SUBTEST_INDENT
 					  KUNIT_SUBTEST_INDENT "1..%zd\n",
 					  test.params_array.num_params);
+			}
 
 			while (curr_param) {
 				struct kunit param_test = {
-- 
2.51.0.rc2.233.g662b1ed5c5-goog


