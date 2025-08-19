Return-Path: <linux-kselftest+bounces-39289-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 14E35B2BAE3
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Aug 2025 09:36:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D91B04E1F1B
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Aug 2025 07:36:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 685EF304BC6;
	Tue, 19 Aug 2025 07:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="maoj+BJh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9D482727FE
	for <linux-kselftest@vger.kernel.org>; Tue, 19 Aug 2025 07:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755588998; cv=none; b=XAumcEoHLtVQz0idgfkP/xwxtOitB8yEA+pvVX5TeXt5dk6qYbDcctG0lTTLWd/MmQlOwEHK3jM3avDGhBo1g1S3k8bin/s3He/hLe10aMdZB0VbEzMr4uvy7QmCNHmkXDp+J6i12ehYWS7JyDtl5iJFzKEI4iodO1rLa6lMYPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755588998; c=relaxed/simple;
	bh=GkLSvdY41yUuby86O5+BvOcphZ93ugVw0bEnopcPEPI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=R2nOuwsE3rWT1ZorQ4X7cGA7X/UzyZ9GXbH67vApQIawHji7W94nl06+zYoQt4FKyYMqtSNyC6OhzH6ZxFihE5i9d8Zcdryn3heKvl9LIBjtovPPFAG77ent2U8bT5+i5h10adID7JtOI3hl39zyBvEmsF3x0I5qIXz0mangRQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--davidgow.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=maoj+BJh; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--davidgow.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-76e2eb47455so10353596b3a.3
        for <linux-kselftest@vger.kernel.org>; Tue, 19 Aug 2025 00:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755588996; x=1756193796; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9KSbimSnv0XBPGJ9MxTD7jYQER3c+CloUdhjhKYZFuw=;
        b=maoj+BJhHMEqJbLCSzb43d7CK2TEvWT76dpx2blpZ7CvLAS6QkODcFNx6b8xmixE9/
         MjRv9kGTV8oRzAq+Jp28b264yypoeyNGoYOzArpesaeHJ0A05yPFJxoh3sUWQSTzDQSw
         /eVUlW8IKMIpsgw8b0OG4+/a7boedo3KLCuwMrtPmzPkr92oKtjxLKx7IKmd4V7Shz4O
         bW3tyJZs8oSwA5vmmXOvE2Sh3keZJDZXixqdOp+v04r/iS4coZNEeeUMKKtpmqSjYZWr
         9nKpkfC5Ae4g13E3KPdW4Z1zggVzrBlF2P1Kn5rrwDNVTWhBnRVNqDzo2d36glBluECM
         V4bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755588996; x=1756193796;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9KSbimSnv0XBPGJ9MxTD7jYQER3c+CloUdhjhKYZFuw=;
        b=KemG22h1+KBDWCq0QHlNsoipzkHumIWKTL6pLYoU53oyzRucMNL4F15puwplcVxrX5
         tQWyuezOLrNh3h/IaiUgVZtHZGbQKuZfFlnXBJalXHrlOCzFBdy1k/2wd3kGQRDQn+SD
         pMH1zeSRs5c2dxgrQdYLLMciNLZwMDxouorpc08NED7XMQH6KDcfHbGv6y2Y38lFcc3L
         7bJI//a1cy6l9Z8o3ShIg/m0kSt91SK+aDS+QGw8Ih4Z5E700gOQgQa10g4OBVbXCIz4
         //65CfP1BfYEu3Z/NbMPt+VvBb8hIUDzpDjMhj0TADnZAu7UH5IGd7EesntbqHzsuZj3
         Wk+g==
X-Forwarded-Encrypted: i=1; AJvYcCXJayPIa0EvO2vS8Ga3v7C216XeYgVKRtR9Wr/L0WryG3/vfcN2f5WJztWgojazTT207m+L3XGVJovFK7k6g7w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeREp9qvR4kNdfGfwsO8t/kB1TNWw6XomTbGOcjM4cFaCT9s5r
	EESDKMO34zBdnO5/Dbr7eppholI9I+BxpayUlWZwJlkwna8jUqCdXl6BA6oag0ljygwCXXU146p
	bTzCpkCQR4RiedQ==
X-Google-Smtp-Source: AGHT+IFVitRB2pYP30mQyIezEFbnNHtlcuT+1BqFK4GSPkogm0Fg1JqC4rE6PsNNNd1LADkKo8O8s6mLcTxctw==
X-Received: from pfij13.prod.google.com ([2002:aa7:800d:0:b0:765:6e59:d7fe])
 (user=davidgow job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:2290:b0:748:e38d:fed4 with SMTP id d2e1a72fcca58-76e80eb456cmr2204859b3a.6.1755588995886;
 Tue, 19 Aug 2025 00:36:35 -0700 (PDT)
Date: Tue, 19 Aug 2025 15:34:33 +0800
In-Reply-To: <20250819073434.1411114-1-davidgow@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250819073434.1411114-1-davidgow@google.com>
X-Mailer: git-send-email 2.51.0.rc1.167.g924127e9c0-goog
Message-ID: <20250819073434.1411114-2-davidgow@google.com>
Subject: [PATCH 2/2] kunit: Only output a test plan if we're using kunit_array_gen_params
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
2.51.0.rc1.167.g924127e9c0-goog


