Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED2E629B71F
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Oct 2020 16:32:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1798624AbgJ0P3S (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 27 Oct 2020 11:29:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:45576 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1798617AbgJ0P3Q (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 27 Oct 2020 11:29:16 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 412462225E;
        Tue, 27 Oct 2020 15:29:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603812554;
        bh=vT6TQiAhfCEnptE16SMHV42f9bp7lBiVGUO/RjqiwFg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=e+9aEIqwiR/tRtP9gru36SFKo0icLdNVXUOSyeeGq4AUHoG+dQRjTwyEt08w38WDZ
         +aqGPs11pq+7Ruwig/ancFMUe0NR8SfUmARl4cFBqP1nF8VBg4c8fu9d2V2jD0biMj
         7QJtWbHS9MgxcgidjBTTiY9fPkTcFPPsFaCaWNyI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Naresh Kamboju <naresh.kamboju@linaro.org>,
        linux-kselftest@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.9 251/757] selftests/lkdtm: Use "comm" instead of "diff" for dmesg
Date:   Tue, 27 Oct 2020 14:48:21 +0100
Message-Id: <20201027135502.347605691@linuxfoundation.org>
X-Mailer: git-send-email 2.29.1
In-Reply-To: <20201027135450.497324313@linuxfoundation.org>
References: <20201027135450.497324313@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Kees Cook <keescook@chromium.org>

[ Upstream commit d00451c8118f8f7ab8e057bc6ee2f8b7d70b6a1c ]

Instead of full GNU diff (which smaller boot environments may not have),
use "comm" which is more available.

Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: linux-kselftest@vger.kernel.org
Fixes: f131d9edc29d ("selftests/lkdtm: Don't clear dmesg when running tests")
Signed-off-by: Kees Cook <keescook@chromium.org>
Acked-by: Shuah Khan <skhan@linuxfoundation.org>
Link: https://lore.kernel.org/r/20200909211700.2399399-1-keescook@chromium.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/lkdtm/run.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/lkdtm/run.sh b/tools/testing/selftests/lkdtm/run.sh
index 8383eb89d88a9..bb7a1775307b8 100755
--- a/tools/testing/selftests/lkdtm/run.sh
+++ b/tools/testing/selftests/lkdtm/run.sh
@@ -82,7 +82,7 @@ dmesg > "$DMESG"
 ($SHELL -c 'cat <(echo '"$test"') >'"$TRIGGER" 2>/dev/null) || true
 
 # Record and dump the results
-dmesg | diff --changed-group-format='%>' --unchanged-group-format='' "$DMESG" - > "$LOG" || true
+dmesg | comm --nocheck-order -13 "$DMESG" - > "$LOG" || true
 
 cat "$LOG"
 # Check for expected output
-- 
2.25.1



