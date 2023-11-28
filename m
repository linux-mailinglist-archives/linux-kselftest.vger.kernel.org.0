Return-Path: <linux-kselftest+bounces-755-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B719F7FC831
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Nov 2023 22:49:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E88FE1C20D01
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Nov 2023 21:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84C6246BBE;
	Tue, 28 Nov 2023 21:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DEfh7QDL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE0F099;
	Tue, 28 Nov 2023 13:49:03 -0800 (PST)
Received: by mail-qk1-x735.google.com with SMTP id af79cd13be357-77d5cf15280so326509985a.0;
        Tue, 28 Nov 2023 13:49:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701208143; x=1701812943; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9gRjgH2cK5ajZRSCUmFV/9aCVUL7685vwmsd3v9kOPs=;
        b=DEfh7QDLS/Fer51VoZj5vdycQ+c8DXXGDbBgXRf7Gfpe1pfoa7Gr95JmGTRCV5S0jN
         buJN1xxnhueGYuFIE2PHhhmndkEZXvc6hJlgAui/DZtLgtT6LsJQ+It+2HvGoHa7Kxot
         8y4JJS5UNxAmDtLnPSimbo0UdyzTj35jlBYk/xpSQUx8GOncMPPZ/YocGMq1eclTzHZM
         N1TIGwIcgUslpMubR1BfGm+QvMK9dGD3qIRMoACPD3ugqJSCeC5NWbgf7jnRo49vediW
         pFyocExZj25SsksEW1kI+9SJtfgD6poycc0kOBl7Fz7cuh0ASAt+LaCukOgVa6gGxmed
         dsuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701208143; x=1701812943;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9gRjgH2cK5ajZRSCUmFV/9aCVUL7685vwmsd3v9kOPs=;
        b=tyNkjK9KypzajWkPSL9c78UwRDN4qwXZZKzmY/Jygh3ibhWbb4uP5UMfSC7RfrJXs6
         ckTOw98lfS/XoWX+9hlJMfPl+IGusvvjNCYIge9sNL24RnKqisbyoV1q9dXQ4uDYVEMD
         8fpq17bQXs2kqsGQ7+S6TOdJ5FJabudQI3k0ZDRYvDDisjtrRNrUGpMK2PYprm9/uPF6
         DLGj0ZbzZomk6zgh9l6vtJemScYHba+7xP9h1RFlWeA2/BCJ3ku8PdjiBNv0gNFw50yC
         aYktX7lfhpE2m8/XD5bTyWeDtUrd7sF+A2arGD4/Y6O6aQSwdM18aE4ZiI6U1BU5Qoro
         gFiw==
X-Gm-Message-State: AOJu0YwMP9coF7o0lB8j+xqYQ1G+95fGSGp/6O9N9EYBfG/OF0q7DFBT
	6BzIq/Hfhyi8jwIpX0d+7b0=
X-Google-Smtp-Source: AGHT+IF0QxaAgFEtr+edYeVMZIhTSIblAJXMe9mRtYqbJ1nR/ptVUp8eCqEDMQecAM9siqeXFXzZUQ==
X-Received: by 2002:a05:620a:2d89:b0:77b:9bf8:b0e3 with SMTP id tr9-20020a05620a2d8900b0077b9bf8b0e3mr14237057qkn.27.1701208142987;
        Tue, 28 Nov 2023 13:49:02 -0800 (PST)
Received: from angquan-linux.. ([72.36.119.4])
        by smtp.gmail.com with ESMTPSA id ea11-20020a05620a488b00b0077d93c7c785sm3131141qkb.119.2023.11.28.13.49.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 13:49:02 -0800 (PST)
From: angquan yu <angquan21@gmail.com>
X-Google-Original-From: angquan yu
To: skhan@linuxfoundation.org
Cc: shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	angquan yu <angquan21@gmail.com>
Subject: [PATCH] selftests/breakpoints: Fix format specifier in ksft_print_msg in step_after_suspend_test.c
Date: Tue, 28 Nov 2023 15:48:54 -0600
Message-Id: <20231128214854.60362-1-angquan21@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: angquan yu <angquan21@gmail.com>

In the function 'tools/testing/selftests/breakpoints/run_test' within
step_after_suspend_test.c, the ksft_print_msg function call incorrectly
used '$s' as a format specifier. This commit corrects this typo to use the
proper '%s' format specifier, ensuring the error message from
waitpid() is correctly displayed.

The issue manifested as a compilation warning (too many arguments
for format [-Wformat-extra-args]), potentially obscuring actual
runtime errors and complicating debugging processes.

This fix enhances the clarity of error messages during test failures
and ensures compliance with standard C format string conventions.

Signed-off-by: angquan yu <angquan21@gmail.com>
---
 tools/testing/selftests/breakpoints/step_after_suspend_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/breakpoints/step_after_suspend_test.c b/tools/testing/selftests/breakpoints/step_after_suspend_test.c
index 2cf6f10ab..b8703c499 100644
--- a/tools/testing/selftests/breakpoints/step_after_suspend_test.c
+++ b/tools/testing/selftests/breakpoints/step_after_suspend_test.c
@@ -89,7 +89,7 @@ int run_test(int cpu)
 
 	wpid = waitpid(pid, &status, __WALL);
 	if (wpid != pid) {
-		ksft_print_msg("waitpid() failed: $s\n", strerror(errno));
+		ksft_print_msg("waitpid() failed: %s\n", strerror(errno));
 		return KSFT_FAIL;
 	}
 	if (WIFEXITED(status)) {
-- 
2.39.2


