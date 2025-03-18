Return-Path: <linux-kselftest+bounces-29384-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F16A7A67E94
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Mar 2025 22:21:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DE5E42208B
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Mar 2025 21:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6804E2139B5;
	Tue, 18 Mar 2025 21:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IMn9BBM5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF7D12135B0;
	Tue, 18 Mar 2025 21:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742332868; cv=none; b=Caa4p7Z4V4VjZZeNjBTNcfJBP5cJB5ncCW6hjOYWxeqL5/t3YiwW7ANiuNK65aLBE0MOgGHQu5RlN1M3kc011+TBodfTsXoK8sGVwZZvl50ylWFtHIKI2lCh9ZFvQ+yOKuq+blRJJ/9/tgmlIYlBXxaoKUJer7oFo76cJuXklFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742332868; c=relaxed/simple;
	bh=GL4EtuyKf9kUHOkV7b4hHX4ryQgPIQE3G1XsfQEzaMs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dvIdOM4UAv9jrPMFUzKYOH1oLhGxhqLqszqE6ceBDQiiteatmzcaoHIMWKPZzPLaqyTd78RUh2MOQGgSNeS5vCJ3kJEBG/AlLNOwtsxUJ9rEKgcd2dTZBwIIuuU4frIy1VbxcpOmmVuHU4M27QtodE7q/7506m1HkVFbFGnAbsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IMn9BBM5; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-224171d6826so23680345ad.3;
        Tue, 18 Mar 2025 14:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742332866; x=1742937666; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vcPVC3BuIieClRSBg7nnlgbieJqM/uBxuytiend4ClE=;
        b=IMn9BBM5pGZtN/Ztzn0+ZXlzY6GQRDZUsCUO/1o4iNQ1sKVNvlwfXIPd+EjXhqV9dN
         ZYGyHYQkIt3vZeSLcaKlw6i5qNLSVoyYk4qH8s/GGr8HHQUUycCmwxyPTL1b1gVPGY9T
         KehRYUKOodux1J0zlWU85UrgT5rfIoDT9o8DMwtgLo0KywP85I1kf59fDo2RwZKjYqJ9
         djmy1Sub6ny05kF76zH+K9VDAGYv3DGvVrwUm8V4rb1FVJLygPE4MwzBoB28kM5AycgH
         vm+wZoXbvi5ktTNQva0Qs8E+iBqzgSgMeEDI7cBcMoRPbKghHy2sYh2Djy0tldotBSFZ
         onrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742332866; x=1742937666;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vcPVC3BuIieClRSBg7nnlgbieJqM/uBxuytiend4ClE=;
        b=VA6+sH20lTKTnPHqhqjtiJKtm3fvHkr24Xa/NM5B1q3zJS6Ga2F7GICBPH25ChFSIB
         pOCMxzhac/pcwVF5toFEkL1oGVLDN8ntt6sHR2e4M3lcrGKm/CL8933w1FOfFhf1H1jO
         SdwaD688/syNraEtItAj0MU63vyvQpH+3z3pw7X/zX1JdC1QgCJCuB4M+gtLuk+aI5mL
         r5O3ZsG3Pg2pTe6v+9cO/RspjTLaFOifj2aDe1E33ywTqp9AXPTwSRsoliVoyd3Tfe6o
         UMsztyY2Ezk37aiCGDW8PmlSckEhwLcKNZr2sNTCyeQtj2T2axekffAgBBKqOC0m+s8j
         cXQQ==
X-Forwarded-Encrypted: i=1; AJvYcCW5hquiWj/ik6pB68E5RrZY77Wb2ju5owezzlRp4RS4b5lJ/2xBu9yDMzQuqf+9ruhKg8Kq5rsL4ArBRw0=@vger.kernel.org, AJvYcCX9/y0OIQSHQzTxp/gri/koa7E8bxyl/BOz3SOtcddScbCV/EW1Y4pHbY30ltRfjlBcpzmAoP27jAvLaLdl1rbq@vger.kernel.org
X-Gm-Message-State: AOJu0Yyomr7BfoJACHkZ62wL2TQYMXOD7hwHViKJ8nBRhrbrnQe34/xR
	sF3iHrQ6PDG83aR+/SCupnDymorjQQH7q97rBnwFci4IXe2EQHRS
X-Gm-Gg: ASbGncumwDluXVWYOLd3A9dECazBI3iCo8Cy/fg30jn/hsqUQvKZFAm8CqDl5+AJ0lF
	CkWYPewtF6gaPXeMCWnq6QblojYztCYZCBZC/KECinIpwthNz88UOnnP5Be5xI+ZWHz96VPeO6o
	d+ACy0sr1aI7y0ekCNkqMiLM+YTCRgk72Tt7gAzqIC9gGC51dU9A65U9BwXfD6qGMOjQB9c+1bs
	pBaCNZ9in2kYXbCln7rmsBOLGqaB72NtpZ8a4OX9iVPgUHHY/N0dgPOBtyvIayon+hyXXcV0sJR
	5qoDdDc2tcr93o/V0wFlgJiyO/L04gGzyCCjtoqbN2ZrxaxD6Cyx
X-Google-Smtp-Source: AGHT+IHOuyvtgKXpgxIO0eGzpjjF1K4mPR3b3EWMIu0A4RfQpFi2svHXNP4J5NKiI+G0qp0wEa08tg==
X-Received: by 2002:a17:90b:3b49:b0:2f5:88bb:12f with SMTP id 98e67ed59e1d1-301bdf94105mr209130a91.21.1742332866252;
        Tue, 18 Mar 2025 14:21:06 -0700 (PDT)
Received: from fedora.local ([2804:d57:4e50:a700:f33d:65d1:e22e:109b])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30153afe74asm8771777a91.24.2025.03.18.14.21.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 14:21:05 -0700 (PDT)
From: Filipe Xavier <felipeaggger@gmail.com>
Date: Tue, 18 Mar 2025 18:20:36 -0300
Subject: [PATCH v2 2/2] selftests: livepatch: test if ftrace can trace a
 livepatched function
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250318-ftrace-sftest-livepatch-v2-2-60cb0aa95cca@gmail.com>
References: <20250318-ftrace-sftest-livepatch-v2-0-60cb0aa95cca@gmail.com>
In-Reply-To: <20250318-ftrace-sftest-livepatch-v2-0-60cb0aa95cca@gmail.com>
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
index fe14f248913acbec46fb6c0fec38a2fc84209d39..4937c74de0e4d34e4e692f20ee2bbe3cd6f5a232 100755
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
+% echo 0 > /sys/kernel/livepatch/$MOD_LIVEPATCH/enabled
+livepatch: '$MOD_LIVEPATCH': initializing unpatching transition
+livepatch: '$MOD_LIVEPATCH': starting unpatching transition
+livepatch: '$MOD_LIVEPATCH': completing unpatching transition
+livepatch: '$MOD_LIVEPATCH': unpatching complete
+% rmmod $MOD_LIVEPATCH"
+
 exit 0

-- 
2.46.2


