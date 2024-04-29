Return-Path: <linux-kselftest+bounces-9097-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FECF8B66A0
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Apr 2024 01:46:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3AB51F20F62
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Apr 2024 23:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DEFD194C7F;
	Mon, 29 Apr 2024 23:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eHSBEGvW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14CEF194C70
	for <linux-kselftest@vger.kernel.org>; Mon, 29 Apr 2024 23:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714434397; cv=none; b=LX2TykVvwsth05LY1GhOq3rTpNXjvBFZXDARsaF07sps7Bmg6uILKBpZTTCmjGqG2yvXd7YAy/X9mL48BITpbFh+soHktf+Nf1vT7OQRbsEcgHOkvzIZEE4oVln3PO7cBaniFraRIw4dZpsvx7xHepYjyWRSXbg44lJg8Z1CLBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714434397; c=relaxed/simple;
	bh=eegKWMCzrzmAYKZZgWikTznQIF2vb+MOg4eHgNWHlvI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ddmxjatLpUTBrKvJx5+6ctc6BQ1NyL4jLFAmpst61LxnVa5fNlBBCToB3Onys5akd8xSUUPs5yVTjLKpm63fKKT4KSvbestxrsXlbnHKyig/k76a8gC7d/k1p2ncljm47HLDv0XXx8vkkzvSnStgKz96jGD8eqVtadcLOceMUTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eHSBEGvW; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-5d8dd488e09so6297989a12.2
        for <linux-kselftest@vger.kernel.org>; Mon, 29 Apr 2024 16:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714434395; x=1715039195; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VBKZZVwka2zaA5v6QzXM0lkoNOh+22WGqQQ6UgQ50cs=;
        b=eHSBEGvWL15RNxpFN1o/z2TsCBOpM5PHzbyWILQxF0RW4NMO7OT7Cq9fHtRMNUe0/a
         N1z9R6ipNPuqj0ovEDGBSg+k3W8o6pSHmOshm3DkN80xfwOP+jboIc9EydSgRyXY55oE
         CeM5gF0xV+WH+gPvlWPjMYzu1URutmcL3+kgLrLkZrBHvVzjgMYQXDeIheRDQkjiDeJU
         2kzUbmXYA5fKB5pJWmXrS9QY4NZNrEijtCDsSx29Ln8wSvlvJN0mXyVKQc9d5i7dB80P
         5MPYLvBp+JV6B0wzEDppsc+K8oPjGiDhB/BqYmyYlMfzhPFQuWUOY7GzTlm5UYX3xKcO
         e68A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714434395; x=1715039195;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VBKZZVwka2zaA5v6QzXM0lkoNOh+22WGqQQ6UgQ50cs=;
        b=o2bMdm6MZooH9aUMD/tx+K1Z8hZZ2vNyjjt4PuEknhnav2+qYyuvVekLDIbmEzpL4b
         E4hDXbK0pmtd3xjlHpC97mLluyUJTtzpGeMvnVidHEbMIxnt6kHm2IWPXySdK8qK6zjy
         pRe5ZIjU3zuw3TM51rLAMp6uaUKv4Oix9h+hi/U4AixIP9cyVzXj935KTcx2JahwCE8y
         k1oZPzUvGHjdH4rcJ8sFV6bWNqMVC9Khd6XUW0VqHdM066BD7Co0Cw1UpOKi/yfN597B
         wI1cxMidfYYgy6u68bInmNfmrhN65H7ZBLEWqGKNcHg91SLRLC/dCmoPA4Z5yGOXIVQy
         h4vg==
X-Gm-Message-State: AOJu0YznvlrUsI9GOUcw6ZZjMH6yZjk1RsBa3cW//89rjKwHyc4ZHujF
	Dy9jbUImIZRq2ansbSZ92x0fcuSJm/kzCrdciyQErJwc0xBQCWxn5J1Gg/6qmJ0kxHH+tLKuMEj
	56A==
X-Google-Smtp-Source: AGHT+IHmoAnjMd09Wlv6UL5QKa6QxWL7QFhCXyeHDXlfoY9FtEuKDfIaCrjFq4GlMUJN9085xhFmBcBtaf0=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a63:f508:0:b0:5f7:9783:12ed with SMTP id
 w8-20020a63f508000000b005f7978312edmr49147pgh.10.1714434394810; Mon, 29 Apr
 2024 16:46:34 -0700 (PDT)
Date: Mon, 29 Apr 2024 23:46:09 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <20240429234610.191144-1-edliaw@google.com>
Subject: [PATCH] selftests/kcmp: Remove unused open mode
From: Edward Liaw <edliaw@google.com>
To: linux-kernel@vger.kernel.org, Shuah Khan <shuah@kernel.org>, 
	"Eric W. Biederman" <ebiederm@xmission.com>, Cyrill Gorcunov <gorcunov@openvz.org>, 
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kselftest@vger.kernel.org, kernel-team@android.com, 
	Edward Liaw <edliaw@google.com>
Content-Type: text/plain; charset="UTF-8"

Android bionic warns that open modes are ignored if O_CREAT or O_TMPFILE
aren't specified.  The permissions for the file are set above:

	fd1 = open(kpath, O_RDWR | O_CREAT | O_TRUNC, 0644);

Fixes: d97b46a64674 ("syscalls, x86: add __NR_kcmp syscall")
Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/kcmp/kcmp_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kcmp/kcmp_test.c b/tools/testing/selftests/kcmp/kcmp_test.c
index 25110c7c0b3e..d7a8e321bb16 100644
--- a/tools/testing/selftests/kcmp/kcmp_test.c
+++ b/tools/testing/selftests/kcmp/kcmp_test.c
@@ -91,7 +91,7 @@ int main(int argc, char **argv)
 		ksft_print_header();
 		ksft_set_plan(3);
 
-		fd2 = open(kpath, O_RDWR, 0644);
+		fd2 = open(kpath, O_RDWR);
 		if (fd2 < 0) {
 			perror("Can't open file");
 			ksft_exit_fail();
-- 
2.44.0.769.g3c40516874-goog


