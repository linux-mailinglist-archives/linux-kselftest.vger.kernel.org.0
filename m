Return-Path: <linux-kselftest+bounces-33226-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 513F4ABA49F
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 May 2025 22:19:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4AB0A276D0
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 May 2025 20:17:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBC67227E99;
	Fri, 16 May 2025 20:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wA7+KUkT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19A2022A7E6
	for <linux-kselftest@vger.kernel.org>; Fri, 16 May 2025 20:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747426657; cv=none; b=NZVv0i4WQdsnQA09aaSLD2JYk4jjkPCu3BYMJ7F/LESRL1R8WxOkfW11EMCEc/XOZRTTQfQoonDHFfDUgBTlGlJYRuouwTFECVtyYfKdO4HcAFh01dNC5gFS1aTrCMS0GsnCk43/zxtJu5Ma1d+RA5JRWZ4cyX3TLqPQuNv7tRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747426657; c=relaxed/simple;
	bh=Bu/MHyg4YHVuyS3LOBxtHZLr7L1GcDOPIZ8uDIhpLxE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ohIo4fcrWHd1iRWB36PMQdUGNVRKbCliCKIT3pOsypBGU9B+ak9QCSbH1sIN+DUD9KiGkHCnpd4ml2SGbU+8gDal7VHrm87v5s/b4otcptNge5SyNh8TFYnC0ZtvGmZQ8aShY8zz5/XeSr5IA8CPUOUj/FPKDMxgSvxcRUYvqW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--rmoar.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wA7+KUkT; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--rmoar.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-7c5b9333642so279230285a.3
        for <linux-kselftest@vger.kernel.org>; Fri, 16 May 2025 13:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747426655; x=1748031455; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9CHB9wwhPWWYDPfcbzkF4W4PL5+L+ibby6qD0MEp0ho=;
        b=wA7+KUkTZfDZHWUzAQZEc/j43NZtxeO0xvYKRFAOOEBw5HhFLqRCLmVhZyU6AUXsmE
         sbeXGCG/+E1XAxoNMHWt8uLAplyuiG0eD0FDOWCA9iePoWTcTR4NYLpiC73paNcVSGJA
         vdKUgUfbS2ZWV5cKMPuCoiyeFt95o8b3fyH7aSqhTaq3Ddlkl0whTqHjImQZDvl8Ci7+
         /KEa0vsg5oKet608rnx199jPnO0NDkMcEXd6QUgFctxdD1vVVKGxVaO/Ghk1C5yX3Umj
         GMrQTwkd+W9Eo48NmhDVTlWAtDD4gaU95aRuawDMWGakd0avlm8UhYOfQ/aB8XiqL5Fy
         cPSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747426655; x=1748031455;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9CHB9wwhPWWYDPfcbzkF4W4PL5+L+ibby6qD0MEp0ho=;
        b=YTwAYoPwyCdD+daWBtDG38POaE7eX7XIMlXnoKpDJz567fc/r5w7OB3/wrAKBYfPK4
         2+xOmpH/AszQJrDrieYW22J9usaGLUQqGgaHx0276k7Zw0BophKfSNQODDofTjAfjZxS
         TuiXj0Ab/KZE+R9XTQvxpnoJcQaXdDhx2KulS8DCofaO3n7p1Yzx6o1sGnf7/PthzbqF
         vhVbRxkt5P65AMOBaLA0kj0v51EajLfoOpwDz490z79mYbu7JmX4S9THFbzhWBa1nW7o
         +RcMHgfUvCOs2CZdV/KZRO17P/dbcUc92ZjwID+pgmHnm52VjrZXBGA66XxM/D3FOHn0
         o8oA==
X-Forwarded-Encrypted: i=1; AJvYcCVBpICjcG/gHLu4RbyZJcoMsZesaj/ooy4397nU6+VI7jNBB9Rrfi3SwyYHv7wCpTBDe9wet+yjQmxDi+cPIrk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyycEJd3w+CduW0oQ9ewKUDcL4OkHEj9uDJfoEW6azzpZUT43S4
	5fbLwTkjiKLaVft0iC5R/+ZTSeimf4h4Ol2zrCTcVmyLeMfhBPDC6HwlZe4WCqELgOMFKRTVDsV
	iSg==
X-Google-Smtp-Source: AGHT+IGFEFtE0VXSdQwE4QdE7XZfEG6vLdmjRQWUL17HoHMazJClUlrpqfyCzriA1nm9WNAdMI+aZK50Dw==
X-Received: from qknqj9.prod.google.com ([2002:a05:620a:8809:b0:7cd:177:9ba4])
 (user=rmoar job=prod-delivery.src-stubby-dispatcher) by 2002:a05:620a:1a26:b0:7c5:592c:c27
 with SMTP id af79cd13be357-7cd46721b89mr656986685a.21.1747426654978; Fri, 16
 May 2025 13:17:34 -0700 (PDT)
Date: Fri, 16 May 2025 20:16:15 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.1101.gccaa498523-goog
Message-ID: <20250516201615.1237037-1-rmoar@google.com>
Subject: [PATCH] kunit: tool: add test counts to JSON output
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

Signed-off-by: Rae Moar <rmoar@google.com>
---
 tools/testing/kunit/kunit_json.py | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tools/testing/kunit/kunit_json.py b/tools/testing/kunit/kunit_json.py
index 10ff65689dd8..80fa4e354a17 100644
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
+		"misc": counts_json
 	}
 	test_group.update(common_fields)
 	return test_group

base-commit: c2493384e8110d5a4792fff4b9d46e47b78ea10a
-- 
2.49.0.1101.gccaa498523-goog


