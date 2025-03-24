Return-Path: <linux-kselftest+bounces-29721-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7725AA6E6DD
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Mar 2025 23:51:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AE121742D8
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Mar 2025 22:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2766F1F0E2A;
	Mon, 24 Mar 2025 22:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EaQUCsLI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FFB31F0980;
	Mon, 24 Mar 2025 22:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742856658; cv=none; b=RYDCYFUWcqyX8+dgdwl9QtL/kaDRHdTlmpx/eSnlf/X7d1Mxk6vhAK1G+M4DOtJkcMbdvLDDMxk2P6u6PTK6u3MPvJ70VJET6gJosgxzkuNef4KZekCs82CKwNg9UZAM6+IMEeUSZgkqGzJ9s+HzkI8jU8ETACuk6bSziGxmndk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742856658; c=relaxed/simple;
	bh=OFnfZFOvRFjLF8yLMJ78CR39P8ues9cZwGeS5uxP9jQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FvWDrJxvjzpa9IswbC3L7gw6n83pgZNm8Yt2BJpXsRfoQauDjFSpIJxjpTUp3Q3nSzHcnXFqaprtDbsCOdAOOrmESqhV28XNE8M86DygwqQO6WStqkjtVU/wLnJ2fKKh0itjmKXgJkfYZhVKsXcZFAX1FKhP8obhX4AFKCzVH3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EaQUCsLI; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-301c4850194so7212147a91.2;
        Mon, 24 Mar 2025 15:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742856655; x=1743461455; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HIcZnMnjQF2uW7JNXrODHoycRkxw07WZdEbj6dXyb74=;
        b=EaQUCsLIlGpzPM02p9D+12RTz63/NRMxzrmGRxiXB2IgzC5rtBTRZGRl/Kc8v9Xbrp
         ejuoDBQfZSwg6UnT74RHfE038RsonG6x/I66WIALx45NV/QVyZlF4+EZqmRstVUrR7Dk
         3YJ8YbpRcm/g2NcX016DpvFEXigrb3ur/lVv0l/D0cUlO5fXfOx+p66pHLchPDSt0FVT
         pb6G/fL3waeBxrJ05d8J5aIy676Pzp/ihZeeJ7Zuh/wM3fAI1uHEbscWuXVbTCXqJiG7
         4SJOvQ1cPOOIQJbcHQIQJY9I2P9Ow5DgM7pz0PCef4d4wZnoUgrwTAJi569SdUWGnAyS
         NZUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742856655; x=1743461455;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HIcZnMnjQF2uW7JNXrODHoycRkxw07WZdEbj6dXyb74=;
        b=dvnQwMN3c+eoEkgbWGcs5HQs5dLlwdMdJN7/w45ggZoUwTo4urPcu3+HYE3knGxZ7A
         HaHekuiiJLNEMkEPj8mjjug8KGhklSHMkNBbQ+2CVzvI2PIWhE9aIwErS1HURWwhYLmz
         RIrtHQK/GMxWKAdbphFl89DMp2a2qoSU2tXkGzY7OjM0tR/E17Tk8fR5hx3ROnaLKiYi
         sVeYjqXNDaaWsVbqFJ6zRWTWkanmNTXxVwhFwmJHrV84lstVhCn6RH2JYQ6+dGa5sVBP
         3fe4QbqjuVjLLIaQqgTrg2JmMJPbWKUP+sjy3UCSGpL7+qxSpTpUX6fCdQwjZ4YzM7VM
         56Bg==
X-Forwarded-Encrypted: i=1; AJvYcCV5VMbZ/7bcmCDRKgy7/ZvVVfibPKREqqz8tWf/PRX8Wv2WGgrRzxBBK2pP+QFQDEwh68IZM7IDpbndxwzyzlCa@vger.kernel.org, AJvYcCWCvTkjxmG9ufsIdtEEnC2GGtDSg8AX6LC47+hYz4KQuVurDsyVL1LChIhT8SP26IEVndpdsKFqGAKldvA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8C+vAU6x8bGke/bFMHnwPDPNJnroKPCxu6MaY0r1NZOsTX/bp
	dbpEmZGxzknujU/LpF0MVuQt6DBF4qY5BS6Bw2NQQIVgh0o+1+Dd
X-Gm-Gg: ASbGncu30gb+Fp3qXzcO1HV8NeKA/AyVi/xhWxhtsuLjbrsrjmE+Tzb1zP1SiC7wewH
	LfeFEUEqW3eVkrky+tOSTI7jp68ISfUuJF9o9fifpi+15sX/0tbunEXoco0xklOBzXhoNgdLFOM
	JYbbyE9vXy6yN1qUeF7Mdk/SVhuoxApQ31T3KWS8D2ZkTZu39e/BXbMS19wH3R6IuJmC3+wE6NG
	h9abfUhAT6DDpvi+MwzUKFft5yPFx0AqOP/g3aG4FgJMHtmmDbYPqQOvYUu9kzOxipAvVfFWeqr
	Qi6OdXqssFpKvt69TFmY7IpR5/MrbqP2Lkqcp+xCxgyhVMWs3Vom
X-Google-Smtp-Source: AGHT+IF8iWTONHUd8aV2dDQzwo6/Z6bKjkb4Rz6knucNIpNah98QGJl0Hvie4EV6FW8ZoGTIxMbdqA==
X-Received: by 2002:a17:90b:2e83:b0:2fa:1a23:c01d with SMTP id 98e67ed59e1d1-3030fec62damr21880841a91.21.1742856654672;
        Mon, 24 Mar 2025 15:50:54 -0700 (PDT)
Received: from fedora.local ([2804:d57:4e50:a700:f33d:65d1:e22e:109b])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3030f5b7823sm8801477a91.10.2025.03.24.15.50.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 15:50:54 -0700 (PDT)
From: Filipe Xavier <felipeaggger@gmail.com>
Date: Mon, 24 Mar 2025 19:50:19 -0300
Subject: [PATCH v3 2/2] selftests: livepatch: test if ftrace can trace a
 livepatched function
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250324-ftrace-sftest-livepatch-v3-2-d9d7cc386c75@gmail.com>
References: <20250324-ftrace-sftest-livepatch-v3-0-d9d7cc386c75@gmail.com>
In-Reply-To: <20250324-ftrace-sftest-livepatch-v3-0-d9d7cc386c75@gmail.com>
To: Josh Poimboeuf <jpoimboe@kernel.org>, Jiri Kosina <jikos@kernel.org>, 
 Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>, 
 Joe Lawrence <joe.lawrence@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 Marcos Paulo de Souza <mpdesouza@suse.com>
Cc: live-patching@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, felipe_life@live.com, 
 Filipe Xavier <felipeaggger@gmail.com>
X-Mailer: b4 0.14.2

This new test makes sure that ftrace can trace a
function that was introduced by a livepatch.

Signed-off-by: Filipe Xavier <felipeaggger@gmail.com>
---
 tools/testing/selftests/livepatch/test-ftrace.sh | 34 ++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/tools/testing/selftests/livepatch/test-ftrace.sh b/tools/testing/selftests/livepatch/test-ftrace.sh
index fe14f248913acbec46fb6c0fec38a2fc84209d39..094176f1a46aee8cf08667ae9e31ae8720bc1ae1 100755
--- a/tools/testing/selftests/livepatch/test-ftrace.sh
+++ b/tools/testing/selftests/livepatch/test-ftrace.sh
@@ -61,4 +61,38 @@ livepatch: '$MOD_LIVEPATCH': unpatching complete
 % rmmod $MOD_LIVEPATCH"
 
 
+# - verify livepatch can load
+# - check if traces have a patched function
+# - reset trace and unload livepatch
+
+start_test "trace livepatched function and check that the live patch remains in effect"
+
+FUNCTION_NAME="livepatch_cmdline_proc_show"
+
+load_lp $MOD_LIVEPATCH
+trace_function "$FUNCTION_NAME"
+
+if [[ "$(cat /proc/cmdline)" == "$MOD_LIVEPATCH: this has been live patched" ]] ; then
+	log "livepatch: ok"
+fi
+
+check_traced_functions "$FUNCTION_NAME"
+
+disable_lp $MOD_LIVEPATCH
+unload_lp $MOD_LIVEPATCH
+
+check_result "% insmod test_modules/$MOD_LIVEPATCH.ko
+livepatch: enabling patch '$MOD_LIVEPATCH'
+livepatch: '$MOD_LIVEPATCH': initializing patching transition
+livepatch: '$MOD_LIVEPATCH': starting patching transition
+livepatch: '$MOD_LIVEPATCH': completing patching transition
+livepatch: '$MOD_LIVEPATCH': patching complete
+livepatch: ok
+% echo 0 > $SYSFS_KLP_DIR/$MOD_LIVEPATCH/enabled
+livepatch: '$MOD_LIVEPATCH': initializing unpatching transition
+livepatch: '$MOD_LIVEPATCH': starting unpatching transition
+livepatch: '$MOD_LIVEPATCH': completing unpatching transition
+livepatch: '$MOD_LIVEPATCH': unpatching complete
+% rmmod $MOD_LIVEPATCH"
+
 exit 0

-- 
2.46.2


