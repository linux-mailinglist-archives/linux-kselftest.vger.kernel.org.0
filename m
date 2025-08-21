Return-Path: <linux-kselftest+bounces-39457-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 337F9B2EE3B
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 08:30:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9240A5E2FBF
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 06:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 278E92D7813;
	Thu, 21 Aug 2025 06:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SVwqIJMb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f194.google.com (mail-yw1-f194.google.com [209.85.128.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6498F29CEB;
	Thu, 21 Aug 2025 06:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755757780; cv=none; b=uNZiDnUlhAdScHAyPqdqCFKRUziot6/FEcEv/Sn5dGrVWCd/i0bPRQqn1Z+TXnAAdDRbiW5uZylMCaN8IDc3zchagqU+3O1L5ocJUCOMK9w255j/lQeMhwik+uXlvwUTGWhRrFX/+xbJdlbthMI4/EGjvZ3sWlaV1IIWcHuULBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755757780; c=relaxed/simple;
	bh=Vft/aTY8HINoWeptFeNZ6DU2nnhJEmoDi6IGcH08nUg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=C4DyUHoPD17YjJqSc+QybdJIEAbsKRu/tf0Sp7SUlh7tOsSnZcIlmrUMXPbkky6a4AP1Ro9q8Pj8g7fpl38iFB8X7/bkmuV6HcSCoC9SoJtC3jRqE55ybZymoc+IhZrnh14CxfVxQ6VvXSdNH95g7etZ/DNqvv+HjIyOFKqchw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SVwqIJMb; arc=none smtp.client-ip=209.85.128.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f194.google.com with SMTP id 00721157ae682-71d6014810fso6051827b3.0;
        Wed, 20 Aug 2025 23:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755757776; x=1756362576; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SZ++liDHqHU/+1Q4q7tOfI2K+QGQy7gcYUpitGDsOe0=;
        b=SVwqIJMbvs/Lmk5JPqxC5GVhbk7vuvBmFdNht5xhRUF/iDmAucTaC5kTpxSt71WjmV
         fBzDfgRAfY0TTZMi5aA/6hbTWl/roYItQn3EkLGb/R+moGmbR+rKipmVcYC5wW5FREbJ
         KXlb7pnFOKj9bL4IsE6LEUsKeB+0YiY5nYI71Fbdd6uhbcUWLxKIhQRbCDkxWxHnwCYa
         0VpheoYLc3HM2j99LXlUUoGrQJ+6klmmeqbxWK4MZqJjZ3mnkFD4YIL+SmAQ7CJlp2QF
         schZJR956fmUpjOIM2dx4W5AYGJ7Q8HVqeF2r/lMTdWko8LAzA7N+nTo/xwJKZ952pJZ
         dMyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755757776; x=1756362576;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SZ++liDHqHU/+1Q4q7tOfI2K+QGQy7gcYUpitGDsOe0=;
        b=kd74+NNz3ML/7VKZ+yH6hG2tF6B6pBbdP+r1c/rPaC5lm4BvJPxK8c6pc9sJnrRQlO
         LteBdPiIqUzM6D4FTP+pbbGQpq9HD/4RWdBkWmPLtEPCpZT45i8XzOxaGTarVSSzKzzh
         pmcgLSYnlMhlqO7CdiMwJxerGjkFl1twJTWJcBRoUxR7pXqeUdXYBZmqi5jT2zKIwvMe
         LfwPu4YUBqcL1Ms2PHoq5RBjWkNK4/wOSzPGD6O4g+aBA4tKVxnl+DHuwYsDdp6itkVA
         ygPyrhGI5p2RORtIC3KdjG3C/Jnkfshy/YenaFVsIEhak4RBua8WbOdvWKo4aW84AePQ
         5eBw==
X-Forwarded-Encrypted: i=1; AJvYcCVZXWDg+CSr4KGrMc0S3g5Z5Rj4IBR/afjII3hrHR1T7Wh4l9AKO99+93vyjZOmaeF+W4iR4tehyw5gu6Q=@vger.kernel.org, AJvYcCWWfwTWzf8e2Ke6CTQvaCPNYO3z/ULpq37+zZZowQ9zaDe7I70+UdMGhJAjtQFSNc5LQJ8RLMiV2x4ScDIejuL9@vger.kernel.org
X-Gm-Message-State: AOJu0YyvMAnqiNCIpOo/BuZIfc8RCnLSLCqNzgWJaxfhSRZ0jAEu3u0I
	9N+SbCs+67IExCW51LD7dv18qGSKR6UZiKah/hmCe7Z/4piGOeJ0rhJW
X-Gm-Gg: ASbGncvR5E/Ck2it5STn4Mrzzq21auZY6kE1tEpyEVKj4Jr9mizU0l6j0hryQQZzKpe
	/fN5KPUjTqKcJcCuWuGp5kE+hXyfpmu90S4Ya3yBVGpRZ98GXx55rFt/Gz/myrkBERrpjZeXeE0
	ek5rGZ+gGUTxauHhbKZdEUV3ZRy9twJHiMWr47ey0lVPWC7k5Gd7vr3lHwUR4UrfggFpM3c4q3W
	P2eFTQW7qylWsboMXeYikoMA5OG4e4lT9Sbv6RyG32Me9FRCqXbjwlILtra4ezyV9umpJx1sZgY
	bT6op73QU++yGNcbFBFMAu5ovT5PxrOFOGFf+RUy97g/jP7K8dpeqnXbJGsMNDO/nfEKOg5Q8IJ
	6Nv+YU4k=
X-Google-Smtp-Source: AGHT+IG27pkkO4wkswVqV8JiRUKLCYv6YmkwvUm5bKcFFA8q2JPHCMXIg5UUl059QPJ946XF7TRSNw==
X-Received: by 2002:a05:690c:5:b0:71f:b944:103e with SMTP id 00721157ae682-71fc8d42296mr17807217b3.47.1755757775282;
        Wed, 20 Aug 2025 23:29:35 -0700 (PDT)
Received: from fedora.attlocal.net ([2600:1700:3680:fd50::44])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71e6de96c79sm42443447b3.11.2025.08.20.23.29.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 23:29:35 -0700 (PDT)
From: Abhishek Jadhav <abhijadhav.dev@gmail.com>
To: shuah@kernel.org
Cc: Abhishek Jadhav <abhijadhav.dev@gmail.com>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Fix typo in comment, amd-pstate selftest gitsource script
Date: Wed, 20 Aug 2025 23:29:06 -0700
Message-ID: <20250821062913.333316-1-abhijadhav.dev@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Abhishek Jadhav <abhijadhav.dev@gmail.com>
---
 tools/testing/selftests/amd-pstate/gitsource.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/amd-pstate/gitsource.sh b/tools/testing/selftests/amd-pstate/gitsource.sh
index 4cde62f90468..9b7323b1d0a6 100755
--- a/tools/testing/selftests/amd-pstate/gitsource.sh
+++ b/tools/testing/selftests/amd-pstate/gitsource.sh
@@ -121,7 +121,7 @@ parse_gitsource()
 	en_sum=$(awk 'BEGIN {sum=0};{sum += $1};END {print sum}' $OUTFILE_GIT-energy-$1-$2.log)
 	printf "Gitsource-$1-#$2 power consumption(J): $en_sum\n" | tee -a $OUTFILE_GIT.result
 
-	# Permance is the number of run gitsource per second, denoted 1/t, where 1 is the number of run gitsource in t
+	# Performance is the number of run gitsource per second, denoted 1/t, where 1 is the number of run gitsource in t
 	# seconds. It is well known that P=E/t, where P is power measured in watts(W), E is energy measured in joules(J),
 	# and t is time measured in seconds(s). This means that performance per watt becomes
 	#        1/t     1/t     1
@@ -179,7 +179,7 @@ gather_gitsource()
 	avg_en=$(awk 'BEGIN {sum=0};{sum += $1};END {print sum/'$LOOP_TIMES'}' $OUTFILE_GIT-energy-$1.log)
 	printf "Gitsource-$1 avg power consumption(J): $avg_en\n" | tee -a $OUTFILE_GIT.result
 
-	# Permance is the number of run gitsource per second, denoted 1/t, where 1 is the number of run gitsource in t
+	# Performance is the number of run gitsource per second, denoted 1/t, where 1 is the number of run gitsource in t
 	# seconds. It is well known that P=E/t, where P is power measured in watts(W), E is energy measured in joules(J),
 	# and t is time measured in seconds(s). This means that performance per watt becomes
 	#        1/t     1/t     1
-- 
2.50.1


