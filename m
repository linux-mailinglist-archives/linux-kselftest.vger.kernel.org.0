Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 167A927B633
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Sep 2020 22:27:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726873AbgI1U05 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 28 Sep 2020 16:26:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726621AbgI1U05 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 28 Sep 2020 16:26:57 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5039C061755
        for <linux-kselftest@vger.kernel.org>; Mon, 28 Sep 2020 13:26:54 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id s31so1889456pga.7
        for <linux-kselftest@vger.kernel.org>; Mon, 28 Sep 2020 13:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lJ5ZdKcP2oAkwJGbJu7+t9DxeD4UPnPYjzHySuJB9PE=;
        b=MlFab++6Ip3miUqv0VUcTTNeUxVV45WuF5PFiNzVNk1Ih0DWAMRo93baww8sIoZcuL
         Cva6K7F9j2ZeLMDPnoJunPlqO7v4JnzhXtJIVt+mbmxZjzYIy/ZTeUA5TsNyRtLBpmWe
         jArZUszX6PfOEgwGFNEEE6ZGNMbxfVeBhqs64=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lJ5ZdKcP2oAkwJGbJu7+t9DxeD4UPnPYjzHySuJB9PE=;
        b=FGOdqA7d//fVSL417SXw9empqIMPUD40dKqOn3QKYoXX5mWIWb31W82rsXMOA9yPZn
         N+ZR+EPTTSAVQ3adQgYo8HIASlHeDn19GP/5a1m5qdSMkmwbXtgtLfSdF1FSpOiZ+QUx
         qkchCpgRPDhBILrx7dJ33Dz/2l6lUG1QOeYCo9j+6+V5n6cj78eiHoyUuKtgNew1IOmB
         Mhp35vZpJuF6baRkhm/Wnom/U5nA0Vbt//Lgsy0mRprSdHXHPn95lIslWsMi35ZOroaZ
         jtSasUnF2YBtaTsI41nuVAJ5sPtKelC52/FqOYY04uZcJgQZ647jvD0uZ3tLLyCnrwWd
         uC8g==
X-Gm-Message-State: AOAM531tUXH4sffqcxQbjDzQ9ZeTcSsBvzivAxMsgAtVNz6Is50lGBKj
        XFPs0IRu9d5K4J4JY3PM4wiZNw==
X-Google-Smtp-Source: ABdhPJxH5K44N+9tEm104267VEbgaRdZeWLDO/ScilChvQxDBLD7mNFmT4KCtmzLAvGg2fUSgu8YNA==
X-Received: by 2002:a17:902:14f:b029:d2:562d:e84 with SMTP id 73-20020a170902014fb02900d2562d0e84mr1027485plb.64.1601324814455;
        Mon, 28 Sep 2020 13:26:54 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q4sm2484432pjl.28.2020.09.28.13.26.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2020 13:26:53 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Shuah Khan <shuah@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Hangbin Liu <liuhangbin@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Tim.Bird@sony.com, lkft-triage@lists.linaro.org,
        Anders Roxell <anders.roxell@linaro.org>,
        Justin Cook <justin.cook@linaro.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH v2 0/3] Extract run_kselftest.sh and generate stand-alone test list
Date:   Mon, 28 Sep 2020 13:26:47 -0700
Message-Id: <20200928202650.2530280-1-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

v2:
- update documentation
- include SPDX line in extracted script
v1: https://lore.kernel.org/linux-kselftest/20200925234527.1885234-1-keescook@chromium.org/


Hi!

I really like Hangbin Liu's intent[1] but I think we need to be a little
more clean about the implementation. This extracts run_kselftest.sh from
the Makefile so it can actually be changed without embeds, etc. Instead,
generate the test list into a text file. Everything gets much simpler.
:)

And in patch 2, I add back Hangbin Liu's new options (with some extra
added) with knowledge of "collections" (i.e. Makefile TARGETS) and
subtests. This should work really well with LAVA too, which needs to
manipulate the lists of tests being run.

Thoughts?

-Kees

[1] https://lore.kernel.org/lkml/20200914022227.437143-1-liuhangbin@gmail.com/

Kees Cook (3):
  selftests: Extract run_kselftest.sh and generate stand-alone test list
  selftests/run_kselftest.sh: Make each test individually selectable
  doc: dev-tools: kselftest.rst: Update examples and paths

 Documentation/dev-tools/kselftest.rst    | 35 +++++----
 tools/testing/selftests/Makefile         | 26 ++-----
 tools/testing/selftests/lib.mk           |  5 +-
 tools/testing/selftests/run_kselftest.sh | 93 ++++++++++++++++++++++++
 4 files changed, 124 insertions(+), 35 deletions(-)
 create mode 100755 tools/testing/selftests/run_kselftest.sh

-- 
2.25.1

