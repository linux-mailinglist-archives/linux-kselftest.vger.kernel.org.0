Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEADC270BB3
	for <lists+linux-kselftest@lfdr.de>; Sat, 19 Sep 2020 10:07:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726168AbgISIGr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 19 Sep 2020 04:06:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726097AbgISIGr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 19 Sep 2020 04:06:47 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C05FFC0613D0
        for <linux-kselftest@vger.kernel.org>; Sat, 19 Sep 2020 01:06:46 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id k13so4459184pfg.1
        for <linux-kselftest@vger.kernel.org>; Sat, 19 Sep 2020 01:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9iH7lg3YkHOWr7NTqH/dXox+CFNwDp9U5uBDltp9opg=;
        b=VliAdCAKA8262/f1rFGSxP8xylGXaZO4FcA+nCHPcdNqzcUPuWcsjFUnaLb/PJdGDc
         77LDfBN6skG3zcIHXXKVxcVAm5eMB9le2+2lsMUje1wbpOCIZh2A4ZLSie9ILwBOpC9K
         4vvx0i4xKcWt+EOoZlwSsPar86nskR8syAyuE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9iH7lg3YkHOWr7NTqH/dXox+CFNwDp9U5uBDltp9opg=;
        b=Ozz1uP4ZRf1WAf1cuwHcpDXS0QccS+aw59M/oXnEQWNGibzuBA5UhMv0lAbaAj9BR5
         yr/hz3I0gqHmJyx0ooSpYuo3t9/2U00E9cNFyH8yKDiWUM0q6daMnNMoS8VxT08EYu+t
         KBUGQEqV01KIbf1J7grbQvgGXUh6LFyUN14Bcodb7QBdGzV0hy3YzlVj20OsByyrWOXz
         XbQ5fiuk7V2TGRuqeh9EU0pJaEx71DSpGhgCCoS2FSWArB1XDHzcRdOAj/dqltPjcaWr
         k84caqXqL39lQCKA2oEQKgFGHvhtELwJD9NoaD/C1AynjnX48jTu5o9TClaHdZi1gz3L
         VwTQ==
X-Gm-Message-State: AOAM533dxE1Bs37FneuWSB9RF/vVZJCYHYz8c3DnRaFiaZPVMg/qZxtw
        ahl0IYDQA/rudiBlizR3OxVMDw==
X-Google-Smtp-Source: ABdhPJxqwI/NRVwSlA1Y4+c6UzNBZYDGK/U+ZUNMSqUez01WLw6CEsVrOzXeoFKh2YifcS+xdf+aPg==
X-Received: by 2002:aa7:87da:0:b029:13c:1611:66bf with SMTP id i26-20020aa787da0000b029013c161166bfmr35672458pfo.10.1600502806153;
        Sat, 19 Sep 2020 01:06:46 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id gj6sm4896682pjb.10.2020.09.19.01.06.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2020 01:06:45 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Thadeu Lima de Souza Cascardo <cascardo@canonical.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christian Brauner <christian@brauner.io>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        linux-kselftest@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-xtensa@linux-xtensa.org,
        linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 0/4] selftests/seccomp: Refactor change_syscall()
Date:   Sat, 19 Sep 2020 01:06:33 -0700
Message-Id: <20200919080637.259478-1-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

v1: https://lore.kernel.org/lkml/20200912110820.597135-1-keescook@chromium.org
v2:
- Took Acked patches into -next
- refactored powerpc syscall setting implementation
- refactored clone3 args implementation

Hi,

This finishes the refactoring of the seccomp selftest logic used in
for ptrace syscall number/return handling for powerpc. Additionally
fixes clone3 (which seccomp depends on for testing) to run under MIPS
where an old struct clone_args has become visible.

(FWIW, I expect to take these via the seccomp tree.)

Thanks,

Kees Cook (4):
  selftests/seccomp: Record syscall during ptrace entry
  selftests/seccomp: Allow syscall nr and ret value to be set separately
  selftests/seccomp: powerpc: Set syscall return during ptrace syscall
    exit
  selftests/clone3: Avoid OS-defined clone_args

 tools/testing/selftests/clone3/clone3.c       |  45 +++----
 .../clone3/clone3_cap_checkpoint_restore.c    |   4 +-
 .../selftests/clone3/clone3_clear_sighand.c   |   2 +-
 .../selftests/clone3/clone3_selftests.h       |  24 ++--
 .../testing/selftests/clone3/clone3_set_tid.c |   4 +-
 tools/testing/selftests/seccomp/seccomp_bpf.c | 120 ++++++++++++++----
 6 files changed, 131 insertions(+), 68 deletions(-)

-- 
2.25.1

