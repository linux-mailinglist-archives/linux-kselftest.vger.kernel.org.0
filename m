Return-Path: <linux-kselftest+bounces-28435-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3170A5591D
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Mar 2025 22:52:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1F907A84E0
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Mar 2025 21:51:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1F82278171;
	Thu,  6 Mar 2025 21:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HOTOdYjf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A9F276046;
	Thu,  6 Mar 2025 21:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741297934; cv=none; b=JMBTxOuNLwF4/LRTcpJ00d/QuALwEL6Cw88QSKqi3lZjce9UgdYISyv1rV5uvkG1xYR5PTy2RzCp8E81hFsxQ9jm4qAkCZEWFhVrURAJYm21c9ep96kzTOyPgYIhLt8CXd4yUtH7ZL1uTy6QF5hVLBCoJqCdicHksHL6BxPEoJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741297934; c=relaxed/simple;
	bh=nhAyIio3nigN0eKRcjmZZGGLjCKqA6CrfxpJUJKfo8E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cePlCyQvcLlt5cYxi7zjpam0yP4BEPKOC0xzTx/n7nY61BCietPfSo+FKnsNcYx/hQljzyHYcUQSoghQo+83++RdJauJ7xbyLEMrBcnib/1rTyFA7F5koJYLacMSnKZ33paw7U2Tu4n1BP+MjBMkrpVKpSxgANP+iJylBzoGwQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HOTOdYjf; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-22337bc9ac3so25121015ad.1;
        Thu, 06 Mar 2025 13:52:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741297932; x=1741902732; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F90y4vkLqE0zEaM07LrOd+WDqDpI1vgMkcb/1Oa7DKI=;
        b=HOTOdYjf2cEdPespIcSpJeEdDK9GJEx5LK2U42TOVTjCcqb4LolswSJm2kUwvAvL1p
         AnfzOFGY6CKRnATbMuFTrMc75AvB/Won73zR70HaiReCisArCImPSxr5cenSbQnTYTgW
         2+RgfKxl4OHK2pd48XhnM8364PCu7IdesRMgAG6KGPZ6oT5v5QC63fOI120LVIv/2uav
         FQrVgi1K6dOccYyR2iZW3wEmqrt/Lwtx2WVXgss7IV5WDtoaGoRFnZiGswCYMxTz5bnr
         Ceu/zDmxhJRWpFyqt1fVd+4PatHSKPG2snjt6qNRYWDHGgLcosI+oPedhKiJbBP95a/b
         VJDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741297932; x=1741902732;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F90y4vkLqE0zEaM07LrOd+WDqDpI1vgMkcb/1Oa7DKI=;
        b=XyVjiGNPpN6A9kQyeyLlXCdQwYH4ufzhmW/6Nj1qd4rGcBgVjM5as3kxL1LPJXOLhd
         Rwas6+ppMsE7F8iviBkVZF4dMXJKOiKPYbe8hRaC3X26ApZ6AGFFfaKosFb1F5UO+6Hl
         pliej/BxunQ/vFTQEOhOvrlIaO3WdU443+mY/UhcMKS6Hh0NbsQrWAjD7iL6APmJt1fj
         8zn9muaUtxtzTUYdyzKUVYbpF5MCqNhpYx7h6Ezx/YZczmlXvoJW6nc4RAt65lNk5ABP
         M9k96Mn1ktejTboYRXzvjabHuZ+ICwumpT5wWxxFCSyFkcO++N/OCZc2QW/kV9+2ZF99
         HcLg==
X-Forwarded-Encrypted: i=1; AJvYcCVkV9kE1l9ZYKfoHIDVtSwLmNdL/xCmK1WM87htLZLT07hPxKPy85Ai4DD+o2rU+paHHShLkwMxfz8Z/wlTM986@vger.kernel.org, AJvYcCW/dLerevXejDyA1dbwRB53HKFBnST0FJir+7BtkYa/ANPr4eGQSiSMtqkdepGCXaUJnzqINYsIPCciz0A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxkWk0tczbXOpq6DndfmnvfQxLq0IF6PanJweTPpaMwcUw+KY1
	QA93+UOiCdDjrpXA/857g4/du9MfKckUo9OvfYK6nl9CaXALorgv
X-Gm-Gg: ASbGncvk3EJyBPACCrwzaTwuB8/uJgpifb+c16U2yPLLfIzT236+gc29qh7CLowY2i7
	19awuFx7gq6BksPQrpMaUsgf0TT4qHfARHxcLt0ulJfKKGp+tueglWwO/jrEqduTzhSx4JLV2RV
	5Ik2b5S+T7z/I39++uvn1pblflBx8aKSjRnqtAe3t7qTxPciLhdIz8ysoGAcoc1kCxXFEJaALLv
	ilYR3ZnfAvOt5VG7lloathkkG9bKhFn5ro9JLuPcbHrCvi0HeJCgsnj+NwCd3K0FzbW+32+DNen
	PwFsacP8CCgfNYCScTUH1zGQhvQ/A+rFiPeCzzZ/nKr5gve32aVE
X-Google-Smtp-Source: AGHT+IGvnHCAApqBbuJpVeHbvfXCRdvNPNCtWFkdmVwhY2/ltFNHvBJXnNYo7fKaUT2OCjAft0ViNA==
X-Received: by 2002:a05:6a00:1703:b0:730:9801:d3e2 with SMTP id d2e1a72fcca58-736aa9df8afmr1514441b3a.8.1741297932550;
        Thu, 06 Mar 2025 13:52:12 -0800 (PST)
Received: from fedora.local ([2804:d57:4e50:a700:f33d:65d1:e22e:109b])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7369824554bsm1923651b3a.69.2025.03.06.13.52.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 13:52:12 -0800 (PST)
From: Filipe Xavier <felipeaggger@gmail.com>
Date: Thu, 06 Mar 2025 18:51:43 -0300
Subject: [PATCH PATCH 2/2] selftests: livepatch: test if ftrace can trace a
 livepatched function
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250306-ftrace-sftest-livepatch-v1-2-a6f1dfc30e17@gmail.com>
References: <20250306-ftrace-sftest-livepatch-v1-0-a6f1dfc30e17@gmail.com>
In-Reply-To: <20250306-ftrace-sftest-livepatch-v1-0-a6f1dfc30e17@gmail.com>
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
 tools/testing/selftests/livepatch/test-ftrace.sh | 35 ++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/tools/testing/selftests/livepatch/test-ftrace.sh b/tools/testing/selftests/livepatch/test-ftrace.sh
index fe14f248913acbec46fb6c0fec38a2fc84209d39..35774c42e239b466599052d6a9cc3cf75b78d63d 100755
--- a/tools/testing/selftests/livepatch/test-ftrace.sh
+++ b/tools/testing/selftests/livepatch/test-ftrace.sh
@@ -61,4 +61,39 @@ livepatch: '$MOD_LIVEPATCH': unpatching complete
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
+check_traced_function "$FUNCTION_NAME"
+
+cleanup_tracing
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


