Return-Path: <linux-kselftest+bounces-34515-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45EBAAD2668
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Jun 2025 21:13:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E6533B0642
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Jun 2025 19:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42C1A21CC49;
	Mon,  9 Jun 2025 19:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zceVzWVW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D9F920EB
	for <linux-kselftest@vger.kernel.org>; Mon,  9 Jun 2025 19:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749496413; cv=none; b=ZeXgmpmiekf0fyrT6Te39WKfP+g5xD3OPkjazOyFzGAhOb+ZJnoIjkwhDQrulac2tMqqxgbZk9bWQfRz6CQUCRMsvDf7vEEb9PmnvUM23Empv9APvxojquG1h4FKfPEYxKdpuMePiNCWJdClCUt+kDNF58fv9mYm6jP0BRgiCXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749496413; c=relaxed/simple;
	bh=RH1moK8rgMoBpS61eJ1qLMUWxGsWt7u8Eenot99hHYg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=O03wwc4JL4U5JSVRJHvbAfCYyIrTk31DZMCfDABdj0aPLF9cz23yJzGOw5irmcEGeSUUD0cQdJGIx2tFHGpse3MxWVK2HPdgNKJUANeob+gywcSIfLKPzCclrhbfUzVA3qHa+lERzZP7hV6fSVZCReOthV2bB8y2MZuRU3vkxaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zceVzWVW; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3a51d552de4so2520144f8f.0
        for <linux-kselftest@vger.kernel.org>; Mon, 09 Jun 2025 12:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1749496410; x=1750101210; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5oMpxxju5fqwiILJnsmlBVD5PQ4lHkNcFxE2f/RbQAQ=;
        b=zceVzWVWE4XFWr9Nltt2wzjw09JHvukflD4JFSwbHR3CYy6WFgGd9BxnBMaLydaWwD
         +JiNs0EP98tWwRAEABX/2nrmuJT6OkAqaf6qGFCQr/4gCrvqlz6icQXGhXT19pFGXPnI
         1kDasAphI11xnLDQ1I3q8iGCWzuP2s0m3J2fVS9k9Pp6BJ1HOsvMqpNsDUK15G39z7YO
         rYygMjPDlxPVOBgAzWB4hUMKmpzJPImyBr/4odpIZTlHCXj/uKlEEmjT9oC9n9NH0GDG
         yTiQLJtCRk+CJB+DNSoohxItcIkiGMroep+6M7RxB4iTKyDlvoyLU+o809LFlgDMBrW0
         +TCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749496410; x=1750101210;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5oMpxxju5fqwiILJnsmlBVD5PQ4lHkNcFxE2f/RbQAQ=;
        b=MW9T79jbJT1Wt7OGDRXjhUtunSU2NG+pIjddZ5+zDLBAIGpGDUritEHU+owcj11NoF
         wWLDOsgvJysrPiJC6czKxK1rGgS4DJz0q2rFT6SMXDu7CocdR8rKblVSFRzb0fa9rQJA
         4kX2iuUh7OgKOj3+P/r9/zgKT3fowc2g9j5OwR02CzfUDgZxfadaBN5fHOkR63xJz+t9
         nDiidefmGTzDVqH4sRBMUPAGqngKS3cUSxmJCU4wtamvEsxGglAJBsPjn7oQ6TX4iiQ2
         a3jv1RrFMzYlz9Fbo6+HjYyDoAvHKibcTensoOolIJvcWU4qoYlYKY9x5jN1LeuoZDqX
         z4Vw==
X-Forwarded-Encrypted: i=1; AJvYcCV4992pyZfPcT7dFKPtsE9q6DOu4I6YhtIL9tpS/m3DDia+aUmbJy77qbwYfXJgek+s2PVjI0mr9WQnFydLtjs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiKLQUnYJtjJDqkeEpOwgQpkHEMwiNvBT8I2qbWyQJRQRzfq6X
	On/IVas+sGIZuZ2vJMEz1slYDbnLWgUqaJTRPi/KKaeHh09ZR2UPeax5cn32hh6pQmw=
X-Gm-Gg: ASbGncud7sqGTzdD66ww+ry261QiZHaqgIf4F1rLOMPiglFizZs8NfIl95ccJAb5UUj
	XffxaQPGw18tOsjV5kDO1sr2CEvbIO0OdX77hSz7e+PqRJiFKtgfp8F5IFFEoLOUqF1PxvdDF6J
	NqbeXP4Z+AK+sq8pouB2eZ37jzhvGn/W/AiJcuwAGq6Ka3x3ios40UdNFHD7IsBCsF08YwgYTzW
	eaz1USQCWYKX9l34hNE+RrTm8PlC88IVq+3xCRrZ56Ms7Op49pq+juhkiV+QSsHUWUsI7G1FcWI
	i1Sia84ucYM2p6F4R6n5CQ+f4j7PN4cnuk4lQKopESdL5VN/1D6puDtCoVPRrEvKBrkd/O4W3nq
	87SNsdsSE3UWJVq6Q0s3uN8+d8HBTs8qoTZ3kdtNQ71bVpH8yP1Ljdi+8H0664w7qq3+egiE=
X-Google-Smtp-Source: AGHT+IHa9LIxtooL5yOEEicTnKzc6G5QUyWFM9R6pj9cNKP1kvLuERjpBxUX1XqsC1CguSfVa3zGJQ==
X-Received: by 2002:a05:6000:2004:b0:3a4:fc75:d017 with SMTP id ffacd0b85a97d-3a53188da32mr11342117f8f.26.1749496409749;
        Mon, 09 Jun 2025 12:13:29 -0700 (PDT)
Received: from green.cable.virginm.net (nail-04-b2-v4wan-166353-cust693.vm26.cable.virginm.net. [82.35.130.182])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4526e163447sm115089115e9.17.2025.06.09.12.13.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jun 2025 12:13:29 -0700 (PDT)
From: Terry Tritton <terry.tritton@linaro.org>
To: Thomas Gleixner <tglx@linutronix.de>,
	Shuah Khan <shuah@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	=?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
Cc: ttritton@google.com,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Terry Tritton <terry.tritton@linaro.org>
Subject: [PATCH] selftests/futex: Add futex_numa to .gitignore
Date: Mon,  9 Jun 2025 20:09:27 +0100
Message-Id: <20250609190927.89655-1-terry.tritton@linaro.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

futex_numa was never added to the .gitignore file.
Add it.

Signed-off-by: Terry Tritton <terry.tritton@linaro.org>
---
 tools/testing/selftests/futex/functional/.gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/futex/functional/.gitignore b/tools/testing/selftests/futex/functional/.gitignore
index 7b24ae89594a..776ad658f75e 100644
--- a/tools/testing/selftests/futex/functional/.gitignore
+++ b/tools/testing/selftests/futex/functional/.gitignore
@@ -11,3 +11,4 @@ futex_wait_timeout
 futex_wait_uninitialized_heap
 futex_wait_wouldblock
 futex_waitv
+futex_numa
-- 
2.39.5


