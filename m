Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C5572441AC
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Aug 2020 01:17:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726593AbgHMXRe (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 13 Aug 2020 19:17:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726546AbgHMXRe (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 13 Aug 2020 19:17:34 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEA5FC061386
        for <linux-kselftest@vger.kernel.org>; Thu, 13 Aug 2020 16:17:33 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id f193so3600179pfa.12
        for <linux-kselftest@vger.kernel.org>; Thu, 13 Aug 2020 16:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kMaIwjW9eusb+2TY79hGdNFXq8NkyNcWXc0iY+eQ23I=;
        b=kfG9TFFepAXDbzZfcw0mIK2vP0Gs1b3ZmYF0kSK4W/am738KDkGh7FF8/Zr8D2V350
         I6j06PiROMtFU4GYDLCslZrzfNACffjK7jTvJ37/N7puZ99I4lobMtmdvcyYOWQ8/vRt
         2ew8Q22zSowQfty8z7JmIcPduU7pJ5GYBG47E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kMaIwjW9eusb+2TY79hGdNFXq8NkyNcWXc0iY+eQ23I=;
        b=e/WopP74oVuorJUoXwN6Slgie75D6O4M3UP2VWb4fxljRy7pRq9ScEP+JMh4NtG8Go
         /uGPt0kbQKHRm7uS/qFggHBiF007dYm5G0p0p3RpF+edeGzccPc0E6sRKEpNtnprIgqU
         B9a8NFPrWXb4QJ2t9IAve5UNK0y3ijUR0n3NjeLtYOtTDEXveddYtpNI0MU+SDl7v+R4
         yHAdCJi30LUeO08RY4XUIalbSzApHG2dM8XuNcQOy3KhKJAWtVIflo7WEkkmVKg/boOj
         p0HrWbxhjsGQ/6tjfC2siNg3yS/z3uSo7yoCCqHuuyYmRmSCbE027PgNZpaJzzmfcas8
         Q3ZQ==
X-Gm-Message-State: AOAM530hjKcHcvnSMA8k7W3N+J8GoLbLsXTCpKSrPdRpIW3thi42yp3s
        D7jyt61QjVu/2c5/0BIQ0VrQMQ==
X-Google-Smtp-Source: ABdhPJwbu9pop4TT3+LDw1+TCnb4W2C3I+Iy5K/KYiM8BEpOhw/+PM2YnAajKwFfSJaZm6S65ht0CA==
X-Received: by 2002:a63:c34e:: with SMTP id e14mr5370668pgd.55.1597360651664;
        Thu, 13 Aug 2020 16:17:31 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y29sm6929728pfr.11.2020.08.13.16.17.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2020 16:17:30 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Kees Cook <keescook@chromium.org>, Marc Zyngier <maz@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH 0/2] Fix S_ISDIR execve() errno
Date:   Thu, 13 Aug 2020 16:17:21 -0700
Message-Id: <20200813231723.2725102-1-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Andrew,

This fixes an errno change for execve() of directories, noticed by Marc
Zyngier[1]. Along with the fix, include a regression test to avoid seeing
this return in the future.

Thanks!

-Kees

[1] https://lore.kernel.org/lkml/20200813151305.6191993b@why

Kees Cook (2):
  exec: Restore EACCES of S_ISDIR execve()
  selftests/exec: Add file type errno tests

 fs/namei.c                                 |   4 +-
 tools/testing/selftests/exec/.gitignore    |   1 +
 tools/testing/selftests/exec/Makefile      |   5 +-
 tools/testing/selftests/exec/non-regular.c | 196 +++++++++++++++++++++
 4 files changed, 203 insertions(+), 3 deletions(-)
 create mode 100755 tools/testing/selftests/exec/non-regular.c

-- 
2.25.1

