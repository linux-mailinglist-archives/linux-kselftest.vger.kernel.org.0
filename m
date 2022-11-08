Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4521620CBE
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Nov 2022 10:59:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233719AbiKHJ7M (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Nov 2022 04:59:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233729AbiKHJ7L (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Nov 2022 04:59:11 -0500
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0BEE2A401
        for <linux-kselftest@vger.kernel.org>; Tue,  8 Nov 2022 01:59:07 -0800 (PST)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-37063f855e5so129041767b3.3
        for <linux-kselftest@vger.kernel.org>; Tue, 08 Nov 2022 01:59:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=aP3hSw+a2HgDmzSipLCzIo7ck6k41ZoMCxvssD+0v1o=;
        b=zzAS9QgO8w6xOtMnBzEpDSOODgFOx5XzF3wE11LBTsyXjKrtq2GpkuF84P/vEKah8J
         mUxbQ2SOxcFuZ60RML/Iq9FApqkWLiiYYXVVIySAn71VioXTOdmuvRtHIlFGhTeOh8bP
         s25KZp3KaxESmQI5l5xQo6CO0wcgwceu6ViaDrXekWVQ0k8nydcW4N53SZdsxwoxMhOd
         YVNJ2qKJL2xggrmdG0cqiXon2YcS9mihdpDHSPnOu9rlHRJFLqznpo7zsRsTInvWsWaC
         HR90/84XS85oWwAxecZgeMT7ZrPpbweGd0NA68NKmsetUtRf7SPX3PfN9vGu3VG5v4bE
         QRSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aP3hSw+a2HgDmzSipLCzIo7ck6k41ZoMCxvssD+0v1o=;
        b=f3aJVugYVwuJHS/SgPuqVaT8nAP+mqkm+HVuxVt2G17YhYqEhK03YNw77820xY3wQy
         UEnl9GIzWLliYOLY8dUY4fM6uTw1rTAbsdYiYLnkiOMujKEswyFOwZNeLID8feiCG/wv
         FZx3NWrRGkuYpOy00gioIZqys8FH6V7KMys0PF/oMm+PjFZw4MxF6fe6ovDDoIgKRkES
         AIJO7xnp/q2vMiKvG4erUx9RVVUbYdL9uz87SwwN5Kx1REn1jnkGNGzgE2MtP3aDp7Wt
         +Pe5l5If4lg7e6Kgw3AUvm5j1RXIBRYtXYewblwwUNIEpMdU/jonnL7fcnWcVFfmiM3U
         P9cg==
X-Gm-Message-State: ACrzQf3/AVO+K+MyuTzIY5p23JcxwiKHWoH/0zm0AJpnTxH8oG98uTdq
        xD1cIlLxqwRfxxmRgAhIhbs4+G38NtjkxW1dMvpUsvd5RYd+5A==
X-Google-Smtp-Source: AMsMyM5knL3wIXxcfXxMNzbPaXvY0XOAmJE35Yq5+8nNO/SDEFtNzabr4BmsrhAF9M2hg3CH4WhI+xBWJNVKlSx8h1w=
X-Received: by 2002:a81:ab4f:0:b0:36f:d141:f9af with SMTP id
 d15-20020a81ab4f000000b0036fd141f9afmr50610675ywk.311.1667901546042; Tue, 08
 Nov 2022 01:59:06 -0800 (PST)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 8 Nov 2022 15:28:55 +0530
Message-ID: <CA+G9fYs+fOTBO=aTfO57xby=QQDaqUt4umwgo6bwLB_iGoSEPw@mail.gmail.com>
Subject: selftests: clone3: clone3_clear_sighand failed - Bail out! Failed to
 clear signal handler for child process
To:     "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org
Cc:     Florian Weimer <fweimer@redhat.com>, libc-alpha@sourceware.org,
        linux-api@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Shuah Khan <shuah@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

selftests: clone3: clone3_clear_sighand failed on arm32 and i386
but passed on arm64 and x86_64.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

# selftests: clone3: clone3_clear_sighand
# TAP version 13
# 1..1
# # clone3() syscall supported
# Bail out! Failed to clear signal handler for child process
# # Planned tests != run tests (1 != 0)
# # Totals: pass:0 fail:0 xfail:0 xpass:0 skip:0 error:0
not ok 2 selftests: clone3: clone3_clear_sighand # exit=1

Test details links,
https://lkft.validation.linaro.org/scheduler/job/5820146#L1795

Test results comparison link,
https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20221107/testrun/12848543/suite/kselftest-clone3/test/clone3.clone3_clear_sighand/history/

metadata:
  git_ref: master
  git_repo: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
  git_sha: b6fc3fddade7a194bd141a49f2689e50f796ef46
  git_describe: next-20221108
  kernel_version: 6.1.0-rc4
  kernel-config: https://builds.tuxbuild.com/2HFnr3jvzSvcbeO3iSMp7Fbvmmq/config
  build-url: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next/-/pipelines/688275399
  artifact-location: https://builds.tuxbuild.com/2HFnr3jvzSvcbeO3iSMp7Fbvmmq
  toolchain: gcc-11

--
Linaro LKFT
https://lkft.linaro.org
