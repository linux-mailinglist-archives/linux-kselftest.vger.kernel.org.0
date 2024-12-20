Return-Path: <linux-kselftest+bounces-23665-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3160D9F9620
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Dec 2024 17:14:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DD191885911
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Dec 2024 16:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2D80219A7E;
	Fri, 20 Dec 2024 16:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Gne+M/DD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18CF5219A77
	for <linux-kselftest@vger.kernel.org>; Fri, 20 Dec 2024 16:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734711177; cv=none; b=VY17aMBienOcnj3JZ/GBH3LkxnPCceNrwdxT4a2eUnGXlU3artL9Cw/5WwRVLp5ltsmk4Tp8YQ283ATpjEAXSwQPtHK48NmX8vi3r4RZTfKGb2luUWclUJqbltIjA0hA8tBRev0PfZy5S/C8yRIF5IpT0Kj6HwlTKiuLxmEalUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734711177; c=relaxed/simple;
	bh=DkRNRnElt+tPHCBj1dVkI9eNV/kvfWH8oF+1IGzpaBE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ZXAO17z2ipzqBS9/KHrw9mjbNgeEfNUkF0ZSddP6aBfrS5Pvq3wlQHuxa8ejo6YqAeQuz2X/BBfP+ScYe68afZVSl13GcuS7UqNfJGgzYY7tlM7Ta8LXXxnkoUFPz1g2VJ0IJJFgaHZGLgvF4L263pX+MtGBzRL0pEetCjzQM2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Gne+M/DD; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-38a2140a400so870507f8f.0
        for <linux-kselftest@vger.kernel.org>; Fri, 20 Dec 2024 08:12:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734711174; x=1735315974; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=caIdKNr2Db4IHYsQKVGm6OLu9X3ie13DDca2IYJEuPA=;
        b=Gne+M/DDDvGMYhS8n/uPLlGh1rm5tGVV1G8VR6zRULGniPEomBrHSJorxsrHpiIeGK
         /2RD6CNbG7ishL2U+LnM3ttDlHnzYiLHoXklN1kAmKhRvR0UU75BRpicfBpDIVL0/LAi
         YDggJw4lK8M8JWkStQZmU2JITND+X5xKlQ6WbQe5HA5RpqoLzfFm/o4WU6wkqJKKE6Y6
         e7xbQ0TEfvt43K1Lyq6PxVuWcY8BjsYLbN/ebLZWcNPORZU0ZD+UvWcpQ6RWqMA5jL/7
         zTjVTrcgRd2Blyzl9m+Xaxd0YDefKsywKzfKwNzgDF7appkeEy2cylw/bqGAijEGmXB4
         iRhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734711174; x=1735315974;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=caIdKNr2Db4IHYsQKVGm6OLu9X3ie13DDca2IYJEuPA=;
        b=GZBwTtQglv9xGgXyGkzbR7MM7Jhb8jW6ApZ7yCW6UVJaas4POj3Vobv0Grg+Pdtatx
         gEibMt+x/Fu/dXwK6uDspkR9aIndJkCppv8SywTxzfBW9Zs1UrcLVYcdToj79pDDEmBV
         2RyYzlt8KrHs0FK19/rqNzbA1VUm6L8nXhm4PU8rC8cdEiklUeKjUn4i/9+c0rR7tjEU
         gh20gW4SkTZPOY+qJXBu74MH++BVGUy7v0htODIrQv2kzjRTrUdPs6XTX2Pr81vMjL9h
         V9ARu8FwDoDyEHyXFgY0mCR51Aa00j2AA3T09WgeMOX7sK4vGFj8bLkY0Op6CiOxsGFK
         Z2/A==
X-Gm-Message-State: AOJu0Yz+LprIhLMDSc26utBNYbWK8cqC5Ntr+iE4m97xeHNcOe47X9jN
	GcgzNjrTNNEOC8OTFjDFf2ljjPI1SCFkxJIGD+J5CTN70F1UNq+RVMiBSzpJNm8KTxQkuJ8lICB
	vOL1LnsSuLw==
X-Google-Smtp-Source: AGHT+IGK1+DfbiEMPgKPSYqDyJTscnikj1zgZWylPhwcJYRMfJAsrsjvz66YCYzl00rS10ZsrPDhu+86D21IJw==
X-Received: from wrfu3.prod.google.com ([2002:a05:6000:383:b0:388:cf0a:a114])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a5d:5f56:0:b0:386:1cd3:8a00 with SMTP id ffacd0b85a97d-38a223f5b41mr3893112f8f.40.1734711174607;
 Fri, 20 Dec 2024 08:12:54 -0800 (PST)
Date: Fri, 20 Dec 2024 16:12:41 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAHiXZWcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxNDIyMD3YLUIt2S1OIS3Zz8dF1j49TkNMsUE0sTAzMloJaCotS0zAqwcdG xtbUA6z0Kfl4AAAA=
X-Change-Id: 20241220-per-test-log-33ecf9d49406
X-Mailer: b4 0.15-dev
Message-ID: <20241220-per-test-log-v1-1-de5afe69fdf4@google.com>
Subject: [PATCH] selftests/run_kselftest.sh: Fix help string for --per-test-log
From: Brendan Jackman <jackmanb@google.com>
To: Shuah Khan <shuah@kernel.org>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Brendan Jackman <jackmanb@google.com>
Content-Type: text/plain; charset="utf-8"

This is documented as --per_test_log but the argument is actually
--per-test-log.

Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 tools/testing/selftests/run_kselftest.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/run_kselftest.sh b/tools/testing/selftests/run_kselftest.sh
index a28c1416cb89b96ba5f8b287e68b324b51d95673..50e03eefe7ac70d1b21ec1da4d245182dda7b8ad 100755
--- a/tools/testing/selftests/run_kselftest.sh
+++ b/tools/testing/selftests/run_kselftest.sh
@@ -21,7 +21,7 @@ usage()
 	cat <<EOF
 Usage: $0 [OPTIONS]
   -s | --summary		Print summary with detailed log in output.log (conflict with -p)
-  -p | --per_test_log		Print test log in /tmp with each test name (conflict with -s)
+  -p | --per-test-log		Print test log in /tmp with each test name (conflict with -s)
   -t | --test COLLECTION:TEST	Run TEST from COLLECTION
   -c | --collection COLLECTION	Run all tests from COLLECTION
   -l | --list			List the available collection:test entries

---
base-commit: eabcdba3ad4098460a376538df2ae36500223c1e
change-id: 20241220-per-test-log-33ecf9d49406

Best regards,
-- 
Brendan Jackman <jackmanb@google.com>


