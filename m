Return-Path: <linux-kselftest+bounces-27932-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 035B6A49F83
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Feb 2025 17:56:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4E92189613E
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Feb 2025 16:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7C0828137F;
	Fri, 28 Feb 2025 16:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DSqe/sMy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E2628136B
	for <linux-kselftest@vger.kernel.org>; Fri, 28 Feb 2025 16:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740761715; cv=none; b=DxdT45Gm98bkW5lTxf7MQOzt0kVcFMR+YtOo54tEx10Qu7SNIG7d4aD0tQVIQnLWi89oTej0g3fHGgKWqn5C247xtZDCHY/RLX2mMxcWDk64Rc0m31gmQQmYlTZHlDiNhXgP5LGD5Snf+g+dxcxFm8Wz+BP/GztxkasuTTouMwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740761715; c=relaxed/simple;
	bh=0bzgAqF8oo8eQx0sm5QVjzxcSuw9SBZhVRceoyFK0JI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=J+u2IZykVpIbcwwtEGuboSAaZluCKZx3Pdw9pHgEp3+0uPOqDUrQ/w72wk5pmPR27B/vXNpUeSRxP0smiFfyRJD4oTrnGo9Dvx/O8UwJHQGsSLoAXLBGCZFcpdai3zwnutTKzpI32nEx1pkJKMMWBIdU2ebknfRx8pfvwSLtk/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DSqe/sMy; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-390f000e962so440696f8f.2
        for <linux-kselftest@vger.kernel.org>; Fri, 28 Feb 2025 08:55:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740761712; x=1741366512; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=HglWqqIMp4q4cEq0dB/S4fjKGgd6pGq+F619sE0ZgpE=;
        b=DSqe/sMyMvEl1cQdPL9xJRi9RWiREeUW3nkEixRNltIn/8iL8CgsWRXyR2NWd746Aj
         DaA8LEMjNDioNQL5L0uLy49XnHMiGgmC2g9NHyRu1JXJ7R0pWxQq9sPqJTFNFrgHpCSs
         zTD8SlR/CFgP3iUxsB/Q/ZDG21NiHqo+BeQNs6NwDD1ZHd22Ysr7tvkWqhD5uMX/d6n+
         0eBB8UVpoUGqAB8J/oNE2D6WbOwzgo3Qpwz7JAkWc6iGTgZziVMT2DodYlvHfukQJyR3
         rDbUIuMA043GuhjMR7ckDB8HSgvIqBSG2uS3/158Y5qF9BfHN3BRXRjqBIk0cHTJHdBv
         gf+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740761712; x=1741366512;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HglWqqIMp4q4cEq0dB/S4fjKGgd6pGq+F619sE0ZgpE=;
        b=Vt6jRZxaNw18iqMSe0qQMwdcGhxvCHERZ/Bj1owEMCAiXOXaYYbYWXJ1rCD2hBiXQy
         +wvZGaWb+r3k1s2d4yHMvQbGKIaNgsEklG+Z875w53dg4gKYMOTYYIU/CAlcXMGLp6cl
         DrfYKDiir+idsxQleo17ts2F0XJDXaJOm9QAP1/BRiKtW+wv26evkDNF6OYX7xvv4qAU
         BZ8h2ga+kbJphPRjdNAwEgm35Sgs5ab8LIXpQ5k+Sf2RMZN73biY7uowMA1qBNBHLEov
         VIpkNBKoo7XVi/uW+xd4OuyIK6BXe1fTc/AsgCjP4rX094S+xPSOuLm61C+Y0agKfzuh
         2KEg==
X-Forwarded-Encrypted: i=1; AJvYcCWMO6tFr49g3pGPiK+GR702bzExAFjVpcyHXdTsWdFJlkaFTs0qDnt8pLdeFPbDm7pSjmKR6H//fYslZDPCq0M=@vger.kernel.org
X-Gm-Message-State: AOJu0YySuS3NYGitN4YzKOnwjRRmmOBFXATbJveFtpGdjePZUPvY0mkg
	eSuY8yfKBy6nDAk7e4LpXPVSWraRLQ/ocjzS7UV2sc04oMScK8IIEkRAL2p00zHkk6G+lqXlj3k
	udMAZpSWIyg==
X-Google-Smtp-Source: AGHT+IGyvxBXVKudgTqQT/Sz/ZVkUrhVlfUf3CFkBBjkljVRcLXxIDlIjwfcGDVpOf7sFqUfT+P2WC7Tjqu3bw==
X-Received: from wmbbi6.prod.google.com ([2002:a05:600c:3d86:b0:439:8688:5f9])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:4409:b0:38f:3b9b:6f91 with SMTP id ffacd0b85a97d-390ec7cb9bemr2080325f8f.12.1740761712441;
 Fri, 28 Feb 2025 08:55:12 -0800 (PST)
Date: Fri, 28 Feb 2025 16:54:56 +0000
In-Reply-To: <20250228-mm-selftests-v3-0-958e3b6f0203@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250228-mm-selftests-v3-0-958e3b6f0203@google.com>
X-Mailer: b4 0.15-dev
Message-ID: <20250228-mm-selftests-v3-8-958e3b6f0203@google.com>
Subject: [PATCH v3 08/10] selftests/mm: Skip gup_longerm tests on weird filesystems
From: Brendan Jackman <jackmanb@google.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Shuah Khan <shuah@kernel.org>
Cc: Dev Jain <dev.jain@arm.com>, linux-mm@kvack.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Brendan Jackman <jackmanb@google.com>
Content-Type: text/plain; charset="utf-8"

Some filesystems don't support funtract()ing unlinked files. They return
ENOENT. In that case, skip the test.

Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 tools/testing/selftests/mm/gup_longterm.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/mm/gup_longterm.c b/tools/testing/selftests/mm/gup_longterm.c
index 879e9e4e8cce8127656fabe098abf7db5f6c5e23..494ec4102111b9c96fb4947b29c184735ceb8e1c 100644
--- a/tools/testing/selftests/mm/gup_longterm.c
+++ b/tools/testing/selftests/mm/gup_longterm.c
@@ -96,7 +96,15 @@ static void do_test(int fd, size_t size, enum test_type type, bool shared)
 	int ret;
 
 	if (ftruncate(fd, size)) {
-		ksft_test_result_fail("ftruncate() failed (%s)\n", strerror(errno));
+		if (errno == ENOENT) {
+			/*
+			 * This can happen if the file has been unlinked and the
+			 * filesystem doesn't support truncating unlinked files.
+			 */
+			ksft_test_result_skip("ftruncate() failed with ENOENT\n");
+		} else {
+			ksft_test_result_fail("ftruncate() failed (%s)\n", strerror(errno));
+		}
 		return;
 	}
 

-- 
2.48.1.711.g2feabab25a-goog


