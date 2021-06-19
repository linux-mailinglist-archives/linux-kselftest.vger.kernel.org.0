Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB4853AD6E1
	for <lists+linux-kselftest@lfdr.de>; Sat, 19 Jun 2021 04:58:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235594AbhFSDAs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 18 Jun 2021 23:00:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234263AbhFSDAs (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 18 Jun 2021 23:00:48 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3637DC061574
        for <linux-kselftest@vger.kernel.org>; Fri, 18 Jun 2021 19:58:37 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id i34so3766956pgl.9
        for <linux-kselftest@vger.kernel.org>; Fri, 18 Jun 2021 19:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HbU9xu9H0S4Zp4/r0rFgl+fi72yv0penQhl6VWi1XNU=;
        b=k93wQuuBxI/sMtxZrxrmp9tJ2kGwsdy4oLt5kcRif7GvZRi3rblvIkADOO+jtur7ph
         IfUajvTk9AGEzP30fz+vdlULuEk9gOdEBrQPYhhZtbnDAnkH2jNV6/rrG3HMgqpHqG8C
         +XVb7shFVf5/zHiMLtCYHAkosTvrZggLPRkYk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HbU9xu9H0S4Zp4/r0rFgl+fi72yv0penQhl6VWi1XNU=;
        b=N52jiZYu7x7JKKyokPkXDOq1secl0eIOWSNzJaZ8TpbrtIFDqIM180W91DhTFF0FBZ
         lth8redlAWEiTYjbB6hOFEi+M35RXjdI3ERhYIbKIqyg0w+eDh7K3wATMjKpm1YiVpfS
         nWb+itpFhK9ODIPjX85caDjI+ukkrT2P4Owyn8i042W2CJ0ATiayXjtG67CgMqDb8fLD
         9EMjDtgyQ6NHE9Eoc81938V4RNtkbw002DhLHsQnnSmiZevRMDOt29yRbdjd9sDRXFg4
         cOXRbNOWT3wVSWhpedYa88hPDUf1T1BjxbF4psoyUYb6Lmi/79d+uPW1FhWC8r6aHUBK
         ndYA==
X-Gm-Message-State: AOAM533iqAuFUNw5Z8fwaQkZQdIhla6icYiFnuYO1IEiMpkwdG0FlHT6
        6DS+zW+Tdpkf+1ahAzIcZBp+8w==
X-Google-Smtp-Source: ABdhPJyFqwJvi3zXG5gdWVDVkUwCru/35AquIu/0x+0F4XVjJOu3a6JE1G1Sjq7nMbZX6fGU42QA8A==
X-Received: by 2002:a63:5a4b:: with SMTP id k11mr12899821pgm.289.1624071516653;
        Fri, 18 Jun 2021 19:58:36 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id i6sm11282648pgg.50.2021.06.18.19.58.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jun 2021 19:58:36 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Shuah Khan <shuah@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Guillaume Tucker <guillaume.tucker@collabora.com>,
        stable@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] selftests/lkdtm: Use /bin/sh not $SHELL
Date:   Fri, 18 Jun 2021 19:58:34 -0700
Message-Id: <20210619025834.2505201-1-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Patch-Hashes: v=1; h=sha256; g=abaacaeb40d19df3f0123ca96cc8242ca6e3268c; i=lfnT3xbl3M4bSoo3fY1JvS2JIxARVoZVIzxV1pBNVzw=; m=cu0dPMI36VjT72aoOxoHuPRqB3LHPSjswDa6MCN+MZc=; p=qUkO+dFY9Yp/ywFt5TFJleapjrvJYshagfpYradjlMA=
X-Patch-Sig: m=pgp; i=keescook@chromium.org; s=0x0x8972F4DFDC6DC026; b=iQIzBAABCgAdFiEEpcP2jyKd1g9yPm4TiXL039xtwCYFAmDNXVkACgkQiXL039xtwCbq4g//dCV QHTL1nxrCKGLO65q5B3wUQ4hi8m7xJAECFT7za5dDw2MvlhH6RTZCotulF0nW7g+78Wl1GqDMJh54 9tQhmyyI/WZH82ab6ck/eTB/TZaWQXLhxnp5h9Y/yv+lpKM26fr6OQzeORwb7FbRMKx9Szxw4MVkg 5SzE0iNSFV6pnMHZZCGuGpPO+CIfLaynmvLlYOhUboaWkCFb3tzmVF5HR557XqEeTWnJitzKK9T16 Soc/6JvKuLiwAhHeW1UgU9fyb5Vj2wnjGQAoP7olpYU0Ry7aRBeMEajhSarHaLOq397zW+SqeNBVU SE3jQLpfNbGykVNd2DeKDdrZBYFLwJY5Z8nc5iCTjR0t+unvyYzI+EGNlhR6tKiuVZbRMa01sOz/U rYgEp0W43irDWvlRDUe+Gx8teTo3eMDk6DkX6I34j9UCqnJcRT65+uXWLqsakdWDxAXr1pmvoh3M8 0RGcNnHogNPddCI6aO5O7BwWFtOmLRygepsKk9afxTxgKeOKhpIDFaPHuNuXidfzqehuYg3NqCBhR GhWXI2/xOlXMAYmIIXzN0RDTgzxsVLd8EFfJQ2UWGOHUAcXHNgcOdVXlRMYpoaPVPmt8oDLA1qss9 7czBiL8tB4Gp12mRjiKKDcBET7eqsCizJZsgJKhjMVcnHmF4GAOdoeDC6uUGFDjg=
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Some environments do not set $SHELL when running tests. There's no need
to use $SHELL here anyway, so just replace it with hard-coded path
instead. Additionally avoid using bash-isms in the command, so that
regular /bin/sh can be used.

Suggested-by: Guillaume Tucker <guillaume.tucker@collabora.com>
Fixes: 46d1a0f03d66 ("selftests/lkdtm: Add tests for LKDTM targets")
Cc: stable@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 tools/testing/selftests/lkdtm/run.sh | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/lkdtm/run.sh b/tools/testing/selftests/lkdtm/run.sh
index bb7a1775307b..0f9f22ac004b 100755
--- a/tools/testing/selftests/lkdtm/run.sh
+++ b/tools/testing/selftests/lkdtm/run.sh
@@ -78,8 +78,9 @@ dmesg > "$DMESG"
 
 # Most shells yell about signals and we're expecting the "cat" process
 # to usually be killed by the kernel. So we have to run it in a sub-shell
-# and silence errors.
-($SHELL -c 'cat <(echo '"$test"') >'"$TRIGGER" 2>/dev/null) || true
+# to avoid terminating this script. Leave stderr alone, just in case
+# something _else_ happens.
+(/bin/sh -c '(echo '"$test"') | cat >'"$TRIGGER") || true
 
 # Record and dump the results
 dmesg | comm --nocheck-order -13 "$DMESG" - > "$LOG" || true
-- 
2.25.1

