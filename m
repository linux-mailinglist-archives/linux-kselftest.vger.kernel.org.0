Return-Path: <linux-kselftest+bounces-28984-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D68C4A60137
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Mar 2025 20:30:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 312D67AF147
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Mar 2025 19:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56FE11F3FC1;
	Thu, 13 Mar 2025 19:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rXN9Jwju"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f74.google.com (mail-qv1-f74.google.com [209.85.219.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CFD31F37B8
	for <linux-kselftest@vger.kernel.org>; Thu, 13 Mar 2025 19:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741894048; cv=none; b=p98tHfr9gLDArANRHx1gzNxNbCZYjFjan0mmSVlT6Y2EbxExG+KPobxD/Uz2gsRh4wBRHtxvhpxNJ89r/k+WOrDbf3plpnLKl+3iTh1+yl2yEatQJaPGdzg9s5Rh9gyiVpxvQMrwok3gdy1t0JDf0LNnwpr2DJ7RdGzch1YRNmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741894048; c=relaxed/simple;
	bh=KrBlLCuENNqmAXVG7c3+/aqpGnMQ9/bc/NOxjGDGs0U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BDGmv6oco21pkrX/pwwhzqIoUtr1WCpENNQrHaU/3i9hZjij6AYSgvuPQ58tJls0Dz2hOFPJs+nOXSUt8y3i6lbTGER/kp+m/6QzUl8al9mNkDQA0SEFziCQVqddVecFnWU82w37xdBdU7sLf+kGQfLDfZE/5XY4wgST2lnmDNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--rmoar.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rXN9Jwju; arc=none smtp.client-ip=209.85.219.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--rmoar.bounces.google.com
Received: by mail-qv1-f74.google.com with SMTP id 6a1803df08f44-6e8feea216aso46178266d6.0
        for <linux-kselftest@vger.kernel.org>; Thu, 13 Mar 2025 12:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741894044; x=1742498844; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QZ3Mm17hODYwuzWnxvtURLhRnjoSjhRLoip0t8b11co=;
        b=rXN9Jwjubd6oyzjen+mmS9k4ogZ6tjRnMp+PIB1GrgklTIcowcerWR0XQwTt1YF1xU
         pntxHPA68VpL1qZI0zxoOqnWvQ6WjIjVX46wB6KiexmprVTFeP0He8EEJpHO5IxheN37
         1wAiLH94tI7szTbtqshesuf0PboiFBNR20egXOeuFozLFkujG8w7sfbiusvUnp02ttSX
         U9UyKz9ej0OP/zPiX5tsalzzr1kFEGJQ3AdItCb/0EEQiDisa5lQmCAQSLr8hcgyDdme
         Nx1RwObfwJNdgAIGGMm8gAPbRYOczSSCUivpu4gCtnyJhrM6hjh/i2zPAAE4H9FoTdGM
         DlTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741894044; x=1742498844;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QZ3Mm17hODYwuzWnxvtURLhRnjoSjhRLoip0t8b11co=;
        b=cXeVXyFcjhjChBio9mf8aVra+yA2NNpWOhorBMltlVjlxrD+yV/2NFBgj/bCy3DF2+
         AJTo1RlxZyyKMjWax97a9Vl3E6bfK+g/XkLo7cGVTGEAi/zeDzfj234zSyMUyHb2Fk2d
         YlSEksP8WhdWY3Rie1Q8HvPS7zMRb9nERvQyotbqSiHnU/I92Cr/RmQFODIu+yF/QT2L
         WQGwAhlPnW7EqgZMS3PNIeuvUfBW59odMavQd+rig91mL7VTBmF+rPWY2UwAIJLMJeCF
         lWpo567iGcnaTNJxebZv/g+WX2yX/5A3NMQ4u8Afb8X45W5gVpZmT6B6K9n5M/6Hdz52
         +eUQ==
X-Forwarded-Encrypted: i=1; AJvYcCU77pzMfmINgYNSHG55cy7fMsuFnl3f08tcaIH9QbeBrZI+LQlJo8MDuWwyJLhn/vz+pL3Gsq+y8CmpWVh3rVw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJtonxfB6bh51M6dnbb+9Yz94NlJ2moUyCFd47D55GP4+EECET
	FGrg8x+mKtcg4CqH14al2zqSoxbLan+kHpueO8OT1n6ThHx71bOz6uBsZN6TspxyyMQe5Z2zZA=
	=
X-Google-Smtp-Source: AGHT+IHUUkUlx830CBpJPHMfzFNdP1ycZ9vkfSY6GnZkeGYCtQvF2FUhUcJ6pbIDO6vFgtx9ZVgMs/nRng==
X-Received: from qtbhj5.prod.google.com ([2002:a05:622a:6205:b0:476:7266:9db9])
 (user=rmoar job=prod-delivery.src-stubby-dispatcher) by 2002:a05:622a:1a1e:b0:474:f5fb:b11a
 with SMTP id d75a77b69052e-476ba8b317bmr46779441cf.3.1741894044398; Thu, 13
 Mar 2025 12:27:24 -0700 (PDT)
Date: Thu, 13 Mar 2025 19:27:14 +0000
In-Reply-To: <20250313192714.1380005-1-rmoar@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250313192714.1380005-1-rmoar@google.com>
X-Mailer: git-send-email 2.49.0.rc1.451.g8f38331e32-goog
Message-ID: <20250313192714.1380005-2-rmoar@google.com>
Subject: [PATCH v3 2/2] kunit: tool: add test to check parsing late test plan
From: Rae Moar <rmoar@google.com>
To: shuah@kernel.org, davidgow@google.com
Cc: jackmanb@google.com, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org, 
	Rae Moar <rmoar@google.com>
Content-Type: text/plain; charset="UTF-8"

Add test to check for the infinite loop caused by the inability
to parse a late test plan.

The test parses the following output:
 TAP version 13
 ok 4 test4
 1..4

Signed-off-by: Rae Moar <rmoar@google.com>
---
Changes since v2:
- Adds this patch to add a test for this behavior

 tools/testing/kunit/kunit_tool_test.py | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tools/testing/kunit/kunit_tool_test.py b/tools/testing/kunit/kunit_tool_test.py
index 0bcb0cc002f8..5ff4f6ffd873 100755
--- a/tools/testing/kunit/kunit_tool_test.py
+++ b/tools/testing/kunit/kunit_tool_test.py
@@ -363,6 +363,17 @@ class KUnitParserTest(unittest.TestCase):
 		self.print_mock.assert_any_call(StrContains('  Indented more.'))
 		self.noPrintCallContains('not ok 1 test1')
 
+	def test_parse_late_test_plan(self):
+		output = """
+		TAP version 13
+		ok 4 test4
+		1..4
+		"""
+		result = kunit_parser.parse_run_tests(output.splitlines(), stdout)
+		# Missing test results after test plan should alert a suspected test crash.
+		self.assertEqual(kunit_parser.TestStatus.TEST_CRASHED, result.status)
+		self.assertEqual(result.counts, kunit_parser.TestCounts(passed=1, crashed=1, errors=1))
+
 def line_stream_from_strs(strs: Iterable[str]) -> kunit_parser.LineStream:
 	return kunit_parser.LineStream(enumerate(strs, start=1))
 
-- 
2.49.0.rc1.451.g8f38331e32-goog


