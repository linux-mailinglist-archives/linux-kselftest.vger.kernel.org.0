Return-Path: <linux-kselftest+bounces-39349-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49029B2D209
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Aug 2025 04:42:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6A397ADD08
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Aug 2025 02:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B900A2773D1;
	Wed, 20 Aug 2025 02:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cdFdHWz2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58276238D49;
	Wed, 20 Aug 2025 02:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755657767; cv=none; b=UipY2vwe3B+8nLL+9GPzQj3FxG04/14+p2ZiLlWFEZDqgPwNGBVtoB8EaIJRhr3nLezpvQf6f56UPIt0EFo4Ukd5Lvz1zXwgO5+n9I3Z71AmZFhpzvBmG96a1ySB5DnX1/d7GvR/KpXIojyevjqehoF0t2F8UBd/ihwU5CrgTfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755657767; c=relaxed/simple;
	bh=Q9s/1H9E6hoHtXrUZrrI8CwFU/UfqaIGHJwn3EhCeRI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hhFeBIdMvoNG2sZoPLmgotZLikgDDSdJoePsc8+yN/+1M84eMLhjtbWXbkl5wpgJdVuMkeTXSH/VXHoM7OpwG4XDeub3N1ZItQoX8HBp1b/XmhY6ueRL7vO4vR/dM8RLUlar2eMJGAHb9Dk5aFjV614DCfo+QueXdivzYu4JcZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cdFdHWz2; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-323266b6ff5so310973a91.0;
        Tue, 19 Aug 2025 19:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755657765; x=1756262565; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WgJSS4DuXeTEsBeU+yFhVC/r47vWoeem+y9c2tQdA+0=;
        b=cdFdHWz2MdaLcPkBLKIJOX0x8vi1VRAjvux5GPxXRGoVuH4/FqiE0u1BX3LUo1PCat
         7J/DYIQ2+byarEWKae2Uomfp9fUGvOohsKFDfy5AfZW3FuE1+ntP7EtzqL0KII9pvRhF
         X/zYZUtptYUqBeUUmR+47RPfanI7J9mkx33R+qBftn+DGaUduhOSti9LuynRv/UYMlr9
         JuoIHxU1AydszwLAAArdWtXBB+PM/HCeE5RvkZTvc0/outb28V46THUsfQc6eAOPVQQd
         ME+lGW+EUdxssRl7vLzc8YLBep7FQxALi6ZzpJDoZOCNdH2M4J9bwdtaCXoWlPUlWaQ9
         PUbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755657765; x=1756262565;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WgJSS4DuXeTEsBeU+yFhVC/r47vWoeem+y9c2tQdA+0=;
        b=I2sfqqy7D277PmbfHLMclGCkU0/cN2M/Yz9K7p59CJ46ltxfPgfrbW4VJGf89WTWDE
         wjOFFlE8RsDdCE5jqKjc6tIHGgDEbkdLFLSlF2d/w+zfOUC+a1d4xH86dRyjX18nmn1R
         hrA1KyHd8OFNvku4LHqa9xEvpbAKgbIa5Rth6sYQn3YhtiEoGjLpvsUkzipuIRH+ZV+g
         XXdBd2yUT6SgHAixsijJMwOEFf2eC3ajxKyRVNIc+vtyBuBF3JS715oiiH4yG+VVHPrm
         L6VZOrHQxlRUsmWjarsmk6yDWDlTzjyOqPTB+7LEG/iOP6gL/QFLgyAppt8DajdBktQB
         2RfA==
X-Forwarded-Encrypted: i=1; AJvYcCUQWNSLQZ2MC/4UExfPologmNSPqMWkl/yxxfN6mzDN2JUHQhwPiX89fV0O6mVSIFHaEPFtKtF6TFmeqH8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLFbxMrfMuXs2YjDACjMSrattXgIWochEdaQ8YhU5UkAWVuvcu
	mImBQ1VrRCDoA3awdJ5jS4a0d8ObOsa1euNOPy6a1/3E6XK6TMWEtvvT
X-Gm-Gg: ASbGncum3p+sPeVCso47wbRoCkSQ53fvBeFSXaZk8QvsYnkoc54VLr5DpdFAiEcxyC7
	u6T03Xirts921DDw0c+zAJus+xkbL92ArfMevXGiar51vOno7TSunPfV5CdpZ8Rcly1TEwo5noK
	/QIkjWfgz2SOPeIyjuSQmvhZpHo67sOP6zLx72Po5xkH9p69XX+IENL/qcrr++CxDyYLndt+4hI
	RQs9+VXMRYvatB/9enYrmAFZQRoGfOJIpXd9gEJixI741882Nbhvb8r1R1JJH6aIZw9ES40thLz
	3b5uqnrSWGKjIWuaqUjxjMdX0uA5P0Srh3ysgHm+axpQKUuT4DMzDDfkoeTk4bjtuSoH25d09s+
	U99UUkZhvFWGEO8FNYgMTnBGy6w==
X-Google-Smtp-Source: AGHT+IHu+mQHQ9OUyB35MccefpKNmsfscyVloV5sAuGFK47KF7BEC+h9dbNGAQ+zFcZsPSySEL2IBA==
X-Received: by 2002:a17:90b:582b:b0:321:cd7a:8377 with SMTP id 98e67ed59e1d1-324d32d5c1amr5373995a91.0.1755657765261;
        Tue, 19 Aug 2025 19:42:45 -0700 (PDT)
Received: from linux ([223.185.135.101])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-324e258cb88sm639075a91.28.2025.08.19.19.42.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 19:42:44 -0700 (PDT)
From: I Viswanath <viswanathiyyappan@gmail.com>
To: shuah@kernel.org
Cc: linux-kselftest@vger.kernel.org,
	anna-maria@linutronix.de,
	frederic@kernel.org,
	tglx@linutronix.de,
	jstultz@google.com,
	sboyd@kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev,
	I Viswanath <viswanathiyyappan@gmail.com>
Subject: [PATCH] selftests/timers: Improve POSIX timer test messages
Date: Wed, 20 Aug 2025 08:12:27 +0530
Message-ID: <20250820024227.11183-1-viswanathiyyappan@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

- Break up the ksft_print_msg statements to follow the 80 char rule.
- Capitalize "POSIX" and rephrase messages for better readability.
- Clarify that false negatives may occur in tests relying on timers
  if other threads run on the CPU.

Signed-off-by: I Viswanath <viswanathiyyappan@gmail.com>
---
 tools/testing/selftests/timers/posix_timers.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/timers/posix_timers.c b/tools/testing/selftests/timers/posix_timers.c
index f0eceb0faf34..017a9e19ad0f 100644
--- a/tools/testing/selftests/timers/posix_timers.c
+++ b/tools/testing/selftests/timers/posix_timers.c
@@ -673,8 +673,9 @@ int main(int argc, char **argv)
 	ksft_print_header();
 	ksft_set_plan(19);
 
-	ksft_print_msg("Testing posix timers. False negative may happen on CPU execution \n");
-	ksft_print_msg("based timers if other threads run on the CPU...\n");
+	ksft_print_msg("Testing POSIX timers.\n");
+	ksft_print_msg("False negatives may occur in tests\n");
+	ksft_print_msg("relying on timers if other threads run on the CPU\n");
 
 	check_timer_create_exact();
 
-- 
2.50.1


