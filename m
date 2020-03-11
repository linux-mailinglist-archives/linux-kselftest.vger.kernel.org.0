Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 27C8F1823BC
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Mar 2020 22:17:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729095AbgCKVRp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 11 Mar 2020 17:17:45 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40883 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729435AbgCKVRm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 11 Mar 2020 17:17:42 -0400
Received: by mail-pg1-f193.google.com with SMTP id t24so1870915pgj.7
        for <linux-kselftest@vger.kernel.org>; Wed, 11 Mar 2020 14:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3LAERohpuvpSm00xKjtaZdoLFyl6wQmyHVk+s3HW4ao=;
        b=Dt+BHf7WqtAzksMgppkm1kzL6sgJlgG6NGzgEwvH3WTT8gIJgWzW08GFsJbZGnIghv
         1xLoE7nGsuKZxrP9SGxRwb0S6uq3PSudZQ03IHeedBogQuKh2dKMRrPwUNPKhm21wG9/
         hqH8tWV8IU+Sk8OtrTWDDxYJdlHuKrt3geVXo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3LAERohpuvpSm00xKjtaZdoLFyl6wQmyHVk+s3HW4ao=;
        b=d0jS13THPEJ5Tl0nYaSEFZ20XuDYBplMydzh0th6/sdd1KqizfxYrlvS0PBzttSBWG
         MBtzyIB4rcz72Rl9Acj78l0UrwkrCbuVASNhjo2J/rsIqBkxIpOcaq5yy2yoQlraHtw7
         cE9VYr388o1S2v7dLTzPz6GwKw9G8U7rMKg5p9sCRGFIpE2/jhS9yivcQ3qvf8GH07mx
         LhClD+NfC02RyvjntEvCLZJB+nDLWQkJaHCRoKtFBG9M31gRBiYQNBJeDwtDLx6wWIlf
         rNG2YsgEPql3c3WoOjLkYkfrPPNeyOSPBvw/mEooB6M3XxeqaoS4DVOcNhQMUpMNKN1U
         zvdg==
X-Gm-Message-State: ANhLgQ3Q3T4drZS9TCIcU2sLnvml11KW+nsuUTotIGk997mkxrCt6/8d
        SxBo1cM1ShFS3mXeEwqW3zNm3A==
X-Google-Smtp-Source: ADFU+vsE/tbqMMh99IEondTMGiAXly4iLT4ptHDR79in7ALtrEBOqRXfZNbkKUAuIi/sOEdvmju+dw==
X-Received: by 2002:aa7:880e:: with SMTP id c14mr4676249pfo.76.1583961459854;
        Wed, 11 Mar 2020 14:17:39 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b9sm22272129pgi.75.2020.03.11.14.17.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2020 14:17:37 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Shuah Khan <shuah@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] selftests/harness: Handle timeouts cleanly
Date:   Wed, 11 Mar 2020 14:17:31 -0700
Message-Id: <20200311211733.21211-1-keescook@chromium.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

When a selftest would timeout before, the program would just fall over
and no accounting of failures would be reported (i.e. it would result in
an incomplete TAP report). Instead, add an explicit SIGALRM handler to
cleanly catch and report the timeout.

Before:

        [==========] Running 2 tests from 2 test cases.
        [ RUN      ] timeout.finish
        [       OK ] timeout.finish
        [ RUN      ] timeout.too_long
        Alarm clock

After:

        [==========] Running 2 tests from 2 test cases.
        [ RUN      ] timeout.finish
        [       OK ] timeout.finish
        [ RUN      ] timeout.too_long
        timeout.too_long: Test terminated by timeout
        [     FAIL ] timeout.too_long
        [==========] 1 / 2 tests passed.
        [  FAILED  ]

-Kees

Kees Cook (2):
  selftests/seccomp: Move test child waiting logic
  selftests/harness: Handle timeouts cleanly

 tools/testing/selftests/kselftest_harness.h | 144 ++++++++++++++------
 1 file changed, 99 insertions(+), 45 deletions(-)

-- 
2.20.1

