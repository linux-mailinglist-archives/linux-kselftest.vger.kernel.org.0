Return-Path: <linux-kselftest+bounces-33422-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5E10ABE3FD
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 May 2025 21:47:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DA6C7A4DC3
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 May 2025 19:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 817752820C2;
	Tue, 20 May 2025 19:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h8JvuXed"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4C0D25CC45
	for <linux-kselftest@vger.kernel.org>; Tue, 20 May 2025 19:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747770442; cv=none; b=h5LTxZgkPmFkV5vzbuNnq/5UQqUYLNCFIRoZM28XfY90WJCSj+66USFG+6nYEJ2SUyjd9hDXub+JOM0NFGG+xW+sjoHj+xwAdN6Jwp4DcmpMLTvXvIg8Z8PbnNbI5+OpoQhG+vy1ig1PtlZiDizpE3OV/2CENkpUNZ8EEBWMcN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747770442; c=relaxed/simple;
	bh=amxOjkQ68jSiXOIMKfSrhfbi7f+ELcaOtAJf4MVQ/EM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=IkN/3/s/0bZzdmR3d4RYvECHeMn8iTCUZZ47wwupWtSWczROn0h00JwbrmrMnzdgAJrxz2v9PWSc4ByILir+O3ZCCAVYrUb5FLIP2vy8QbKnNVvIEAQxpgPGG9oEv5ZJw8DfK6SIcWbV/jsmLVI9YPtzcc+C4sQSnNiE52MAsvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--rmoar.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=h8JvuXed; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--rmoar.bounces.google.com
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-7c7c30d8986so1843418485a.2
        for <linux-kselftest@vger.kernel.org>; Tue, 20 May 2025 12:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747770438; x=1748375238; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rqsLb4Go615Rv3sDkm4gh0pD3pm2JY3mUNmzalqtLZc=;
        b=h8JvuXedIGkbAuCu+BVFxJbiEIWm2qqPMB0t+LKdUdsGn3HBXGLzF1U04jEfwbKay+
         celAPNS2opoSatTM6nYeIb5Ou51yZUKPPTYd5KAtOmkj6gBxq3VQFpOBIHVPLF9zDIoO
         TfTkEjqY8lxELX5wllMSEFKTzd27e3i2vDJqZQpmWllD8UNVuETVs7WI1bPpztoYejng
         nOtI7jQ9mJWbYJTW+UgSyFAw1XnCPrL1W4LRErncUmtXwL1RFBkMsPTkyniojfwpLY7/
         oE+LaCuAebfAkyYq7bXQltPZABVs3avg0xcdU4t7WjJgia9vIq4Ct71HsYA7RP9x2y0q
         nbmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747770438; x=1748375238;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rqsLb4Go615Rv3sDkm4gh0pD3pm2JY3mUNmzalqtLZc=;
        b=tq6Ao8EAIDT9qZG9ORYMhJub+SfBQQV2R6O4bdHr8Pl5vsmVnc5zgskMNk+QYdU0RU
         LGt4+CK6WHCHrjgWhyke4BrQBPgVTWtFLXoq9NEAUn5lICZECbU4KQnSBEOqD1zOgKN3
         oiDCB6fss2p+acvV7wKTx1qtlFBFtPu0X3PPeUGgxxb3Z3r7NWLyWvU7BbgGvIu6LJHR
         84Kz8QNoKbHKEMvCSfI9cOSqUnlr6KgGCRkma1i3axUVDHyEt3jc1EJzVpR2L96OQmAR
         nmEZrY1OoNuBjGpG4V8UZg/KVeKZsQ8AXKBzryvL6H8+fS0caUHcai3Zug8nEFC0vf0V
         SO9A==
X-Forwarded-Encrypted: i=1; AJvYcCUBG7WttcBK3DOWSd2b758n/o02iBGhnMIF5dX+QGBEnnszUo2q+eJ0LHdGpaOS5kzz/Y1Af4SL7S2Sz1OHJbY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+CQcVAtEx8WktXxq2q8ajXZp0DdrBUiHUhxOEgKeuNake071o
	0hoJ19DWKVsZxvFtcczBk+Dk/sI6PcjKGQfbV6L4b0nKV3GkRE6JNCeYjB+slZWpwmydPLMAnCK
	XDg==
X-Google-Smtp-Source: AGHT+IEk8HRf1tMAAyBDk6ioHYYDZ8p2tDUMaT/WbcTGVmXyjZj8eY/n+8d58IEwmqQwx1gmDZmsdtEWzw==
X-Received: from qkam16.prod.google.com ([2002:ae9:e710:0:b0:7ce:c22d:6a49])
 (user=rmoar job=prod-delivery.src-stubby-dispatcher) by 2002:a05:620a:4443:b0:7ca:f021:4d3a
 with SMTP id af79cd13be357-7cd47fb274emr2106144085a.39.1747770437675; Tue, 20
 May 2025 12:47:17 -0700 (PDT)
Date: Tue, 20 May 2025 19:47:13 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.1112.g889b7c5bd8-goog
Message-ID: <20250520194713.2233351-1-rmoar@google.com>
Subject: [PATCH v2] kunit: tool: add test counts to JSON output
From: Rae Moar <rmoar@google.com>
To: davidgow@google.com, brendan.higgins@linux.dev, skhan@linuxfoundation.org
Cc: dlatypov@google.com, kunit-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Rae Moar <rmoar@google.com>
Content-Type: text/plain; charset="UTF-8"

Add the test counts to the JSON output from kunit.py. For example:

...
"git_branch": "kselftest",
"misc":
{
    "tests": 2,
    "passed": 1.
    "failed": 1,
    "crashed": 0,
    "skipped": 0,
    "errors": 0,
}
...

To output the JSON using the following command:
./tools/testing/kunit/kunit.py run example --json

This has been requested by KUnit users. The counts are in a "misc"
field because the JSON output needs to be compliant with the KCIDB
submission guide. There are no counts fields but there is a "misc" field
in the guide.

Reviewed-by: David Gow <davidgow@google.com>
Signed-off-by: Rae Moar <rmoar@google.com>
---
 tools/testing/kunit/kunit_json.py | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tools/testing/kunit/kunit_json.py b/tools/testing/kunit/kunit_json.py
index 10ff65689dd8..c1463e6819b6 100644
--- a/tools/testing/kunit/kunit_json.py
+++ b/tools/testing/kunit/kunit_json.py
@@ -39,10 +39,20 @@ def _get_group_json(test: Test, common_fields: JsonObj) -> JsonObj:
 		status = _status_map.get(subtest.status, "FAIL")
 		test_cases.append({"name": subtest.name, "status": status})
 
+	test_counts = test.counts
+	counts_json = {
+		"tests": test_counts.total(),
+		"passed": test_counts.passed,
+		"failed": test_counts.failed,
+		"crashed": test_counts.crashed,
+		"skipped": test_counts.skipped,
+		"errors": test_counts.errors,
+	}
 	test_group = {
 		"name": test.name,
 		"sub_groups": sub_groups,
 		"test_cases": test_cases,
+		"misc": counts_json,
 	}
 	test_group.update(common_fields)
 	return test_group

base-commit: c2493384e8110d5a4792fff4b9d46e47b78ea10a
-- 
2.49.0.1112.g889b7c5bd8-goog


