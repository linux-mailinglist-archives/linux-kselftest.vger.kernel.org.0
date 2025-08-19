Return-Path: <linux-kselftest+bounces-39326-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B854B2CAC0
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Aug 2025 19:37:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 140A24E47B7
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Aug 2025 17:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 744C030BF7C;
	Tue, 19 Aug 2025 17:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="DM5c6UxU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 569AF30BF6A
	for <linux-kselftest@vger.kernel.org>; Tue, 19 Aug 2025 17:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755625041; cv=none; b=Mp8oR/YmuDnYlEnhQn0VFVzH78UK1H5qW7UYsrzd17DqT+H+UiEkE6OUg0yFjSgmvXIfH1wwWTGiASp5IBS1YgEQD/dzWJHFfY/kjXCBXAHXMD86qMlGkke/46axEOgvBvaOuwggfH1wU2pRNo4DIlwb9eRlBXVw7kFleVFtzbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755625041; c=relaxed/simple;
	bh=JXPd1rLK4KxreXPwbOiKrhOxW5tmFTs62cIXzsuk8AY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=s/+a8IfQoyWZxZRFgxDi2+cA3tMcBORYN6JOdNt//BgjXeLPYJGlTMgk22AR2y5uial38mFzIYppY/5YHrXONdNG80H2p9JR+ofTwEVuKySF3IGuPRsDTGEzn+d7HTU6sjCJwJPtzWsjAQ8RMXcYjNdthOjI8FdKkUxViH1/JcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=DM5c6UxU; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3b9e7437908so5349497f8f.3
        for <linux-kselftest@vger.kernel.org>; Tue, 19 Aug 2025 10:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1755625037; x=1756229837; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dO5/mt3F5WN5A5SgwE0dDDSreyFeFbLuWxIdcH33nUM=;
        b=DM5c6UxUhU7iHTTkj2hj4QMHVGYMUdfnGnWOKBp+zAYLoc/DQqrA92WoCGqm8JbkXK
         DStvjVpCytekBsqcOp95f9gmLU4m1XvpWQ6gl2WNt4KXK/lnioNo0GCyxHXF01qCNSA+
         XV470V8PrzVdrZGPGtPHx12/1z7bxo2h7/UVCGVwbVjQNMHu8vt02WxzQYs4iW6Nr6kH
         TUhdHJGMHuBz5Sa9/UB8/Nd44oVhdG6p15dIe65Zz7AGSWl2HHCzwxRJjdYZIsCdYpIb
         0XBkuxGbyB+9CeqG2cE0f4H+3WRL+b+aUQLIUhOaznHYros8d8L4toOSkoHVy3ca+KDS
         jNMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755625037; x=1756229837;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dO5/mt3F5WN5A5SgwE0dDDSreyFeFbLuWxIdcH33nUM=;
        b=OdPO7cJ/yb5pKwq7A779l4fan57syuxDQJImw6iZmc2v2HJhnPH337v5PUOpX6yIIL
         1QVm+Nv2nDaJNMUOFxSZJ11PL+Zi/MS1QDvqMFHwkrKAmaRQO1AWu5d0E3AzRgItQKUr
         iFmgXWF5+PCy4gwH8zcwiOwcZtJui8cQpSvp3sDFBNG2d1pcAAfaRI9iZbqVi6YW28qu
         FWoX1JSxEbsuy6S5ZSZQKOx/6kdDx0ICXX3tjyaQH1uf1rvXVmo3AsrWay0famF+CK3x
         kxBrlO0+M83eoiPEC5qKLZsJ3UnnP55hnlYCeKuvu2W5ECju76cZvSFVkmmv8cGE5Cjy
         MYZA==
X-Forwarded-Encrypted: i=1; AJvYcCWiTK0yM9vfApwUr9RBwc2eZVJW8P/la2bEO71pYuVmJ4Xcz790DdW6+gxf7wQOCl6e1vOg8IlIIrskTdB+seA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFpUj4L59cwU8vB6gqqsHp0Q5ZzVToVgwyjTSO8gnZApw9w0xI
	vUOy1OrSZWmXUICgwWJni//oxWYTyq3gJJUYYzVEoX0XR0msc1DjvySk5+RqbK8V4+M=
X-Gm-Gg: ASbGncvWZ2izr76T6cnZ08M+GPUTb3XwdVyRVV7DF2855eoGfYQmHXLMomB1qRGJ1x8
	Ca1wMeHpI/T4DrJgrJ6N6Cgr9wAoiijRbk5yKpXIoh7Xpuhh9lCxFLvfVmHRa7FfZ5lhM8/Nyac
	ngT0p6pedOqLlwhP1/ixj7BbttQkvkhbGqJbpvBfoPhSgJjecnoUrh9tFqseIXgUTkEK7woEBKl
	szU5IkpYxa/d20yRZVtwAIiHzo6weYm7TS/L1ULSVJRTDYZ4hXPXI7BuRocHuxGunjVxsGH/uUm
	Bg6YXtePpD7Z7kmCi212tHVEIzL7wWogdqYQ06GIUzBQGYeSRR/oyAHnbmiSGXolXWXil9eK2hn
	fWYltoefTIkU=
X-Google-Smtp-Source: AGHT+IGh34R50gEhJycTm5zqMFBCoU3WTDF2MBvLl83PU9al954kLRGJD/Cpv5Dxv7zp9pGb6k4+EA==
X-Received: by 2002:a05:6000:4012:b0:3c0:7e02:67bb with SMTP id ffacd0b85a97d-3c0ecd26d18mr2762797f8f.63.1755625036666;
        Tue, 19 Aug 2025 10:37:16 -0700 (PDT)
Received: from localhost ([177.94.120.255])
        by smtp.gmail.com with UTF8SMTPSA id 71dfb90a1353d-53b2bed9fe1sm2906022e0c.16.2025.08.19.10.37.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 10:37:16 -0700 (PDT)
From: =?utf-8?B?UmljYXJkbyBCLiBNYXJsacOocmU=?= <rbm@suse.com>
Date: Tue, 19 Aug 2025 14:37:01 -0300
Subject: [PATCH] selftests/livepatch: Ignore NO_SUPPORT line in dmesg
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250819-selftests-lp_taint_flag-v1-1-a94a62a47683@suse.com>
X-B4-Tracking: v=1; b=H4sIADy2pGgC/x3MQQqDMBBA0avIrBuqAUvTq5QikzgxA2EqmVgE8
 e5Nu3yL/w9QKkwKj+6AQh9WfkvDcOkgJJSFDM/NYHs79vfBGaUcK2lVk9epIkudYsbFBHeLo3f
 e0uyg1WuhyPv//Hw1e1QyvqCE9Ptp2jBdhfYK5/kFGmhp7IYAAAA=
X-Change-ID: 20250819-selftests-lp_taint_flag-c96f5b9b2ed9
To: Josh Poimboeuf <jpoimboe@kernel.org>, Jiri Kosina <jikos@kernel.org>, 
 Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>, 
 Joe Lawrence <joe.lawrence@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: live-patching@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Marcos Paulo de Souza <mpdesouza@suse.com>, 
 =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1960; i=rbm@suse.com;
 h=from:subject:message-id; bh=JXPd1rLK4KxreXPwbOiKrhOxW5tmFTs62cIXzsuk8AY=;
 b=owEBiQJ2/ZANAwAIAckLinxjhlimAcsmYgBopLZIfQ0VomklN2mvleQcbBjgLgQY1J4xq4OOr
 qxsw4qZyOSJAk8EAAEIADkWIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCaKS2SBsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMSwyLDIACgkQyQuKfGOGWKZGnQ//fBACTrdtPSbzrMFqDYzWog8GqrVdXFi
 4SqqfZ7DKYjSQ5aSMPrsBxJn7TJwY89RaEHx05QfSS+1ZiRtGRXywG5Wf2gMiFq13JCXF7NImqg
 P0JU69SV7XTysIQbGnmtLMnkemaJPoK4IN/7+h0lFlogYfakHzVlOpD1zsnMAk4PWAQx6AKeWep
 xMkfQSlI55rXwmV6n5OqHfMdnDkS3aRNiX8mkSsjeOPT6MlPDOp6pe9rQhC8rUT4TkXm1wEp2i5
 Df58jj4q5Bc/SuPD/Yl37HsoiwAjsQjEfLOsbk6GWoNz3eL3egG8970hI92TTwz9R9yjaAzpjkK
 URSbA2hJd2eXhS2CZnbSNHCV7pyaVuV4Zk5zA5QF7C1VrFpKi4mYst87Jcf9rFgFnn94avGeZOn
 pniqrKf9GBfmRduRXGTnNtlE3NlErpegKumgxlBO1Kyr1fxyWMo1NWG9ZmgaP9DBQKN8Q30zfnu
 MPszoN8iyhd6W5iqdqNS2pJ70dy4cZqq0KBMIsjoW+Aw2HU10wEsvQcLZnSP4N+9TRqaudYrgwp
 1xxwGTBL5AE+parSF7X/ocZmqLRDaigFgjZyhGGt39vRC1CK9/AsY+RApYCCXp7SO+NVEjQ5Zuw
 JSsRVoGi9S1P8OKCfnkGeve0kkgGmVFHEw5znZgbr/apkvQ9EvUA=
X-Developer-Key: i=rbm@suse.com; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

Some systems might disable unloading a livepatch and when running tests on
them they fail like the following:

$ ./run_kselftest.sh -c livepatch
  TAP version 13
  1..8
  # selftests: livepatch: test-livepatch.sh
  # TEST: basic function patching ... not ok
  #
  # --- expected
  # +++ result
  # @@ -5,6 +5,7 @@ livepatch: 'test_klp_livepatch': starting
  #  livepatch: 'test_klp_livepatch': completing patching transition
  #  livepatch: 'test_klp_livepatch': patching complete
  #  % echo 0 > /sys/kernel/livepatch/test_klp_livepatch/enabled
  # +livepatch: attempt to disable live patch test_klp_livepatch, setting
  NO_SUPPORT taint flag
  #  livepatch: 'test_klp_livepatch': initializing unpatching transition
  #  livepatch: 'test_klp_livepatch': starting unpatching transition
  #  livepatch: 'test_klp_livepatch': completing unpatching transition
  #
  # ERROR: livepatch kselftest(s) failed

Cc: Marcos Paulo de Souza <mpdesouza@suse.com>
Signed-off-by: Ricardo B. Marlière <rbm@suse.com>
---
 tools/testing/selftests/livepatch/functions.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/livepatch/functions.sh b/tools/testing/selftests/livepatch/functions.sh
index 46991a029f7c64ace3945727b3540521ffe2e529..13fc289962cdd77c9fc4eaf1ad336775d6db710d 100644
--- a/tools/testing/selftests/livepatch/functions.sh
+++ b/tools/testing/selftests/livepatch/functions.sh
@@ -321,6 +321,7 @@ function check_result {
 	result=$(dmesg | awk -v last_dmesg="$LAST_DMESG" 'p; $0 == last_dmesg { p=1 }' | \
 		 grep -e 'livepatch:' -e 'test_klp' | \
 		 grep -v '\(tainting\|taints\) kernel' | \
+		 grep -v 'setting NO_SUPPORT taint flag' | \
 		 sed 's/^\[[ 0-9.]*\] //' | \
 		 sed 's/^\[[ ]*[CT][0-9]*\] //')
 

---
base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
change-id: 20250819-selftests-lp_taint_flag-c96f5b9b2ed9

Best regards,
-- 
Ricardo B. Marlière <rbm@suse.com>


