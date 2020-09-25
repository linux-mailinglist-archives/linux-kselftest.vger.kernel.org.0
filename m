Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3C022794E3
	for <lists+linux-kselftest@lfdr.de>; Sat, 26 Sep 2020 01:45:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729424AbgIYXpi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 25 Sep 2020 19:45:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729469AbgIYXpi (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 25 Sep 2020 19:45:38 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55472C0613CE
        for <linux-kselftest@vger.kernel.org>; Fri, 25 Sep 2020 16:45:38 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id f18so4732145pfa.10
        for <linux-kselftest@vger.kernel.org>; Fri, 25 Sep 2020 16:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cCvjyh3GAWHODp3gNqO/cxpjyT+UK9hE3i+NYvWYWug=;
        b=UaBaPWPOtq6Ku6r+E/aktfyx2R2zJ+wD62Bxd9SCvodOkjq446bGgfddVvHaqJ5ZQv
         tievxaUuKaBeq+7npte/4zLwlBxDDR3mz9dCXRJcIJkGTv4dIDWeyziPvNaRxHbd+ThX
         hJzLkj0XnH6NjDHuGuo8XH+MMqxth9IEeOwF8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cCvjyh3GAWHODp3gNqO/cxpjyT+UK9hE3i+NYvWYWug=;
        b=V0Q99IDy48orzs855tw5e1FsoHx0n6PbKWXJK/SrXeXzbbD1f6hxjUHvEqmkVoPBs+
         EMuUQpmEj9J8m4OidJSQ7LRCukkiil1oHMRolE47fCyqQ+g/eLy22GNd0lkK/XgmGiu5
         jMzTo2KbHGF0ODdlQ1AapSPh2DcivpCbwnM77UageB7RhojrETYhAYAAfjSBuQg2jLPD
         6zq79M3UQjeO9X/WUxFRgFzyC8lZkwDpE6C0sI1yeUIxTjdt+6srcqqR7ipOh94NRaKN
         +jPOswYCMwxkk7+Afo+cZI4pZNx4c0Qn9cL2P31gz3W5MfY9J5YUnU+53RQQ++EzOL8Z
         InTg==
X-Gm-Message-State: AOAM532MYZMYUqlSEuB25eCAS6BKbpPUpNqsiHoxFIFio/q2c4KZMavm
        dTVlWFqPx96LbKIa/4Vwxkzaxg==
X-Google-Smtp-Source: ABdhPJx/ssB0AJWYYp3cLL8gzai0BTOQP/wl4iZKIWPv0+GRei9MwCIslR5o26fmdgEwQGo/+OrXgg==
X-Received: by 2002:aa7:96f1:0:b029:142:2501:39ed with SMTP id i17-20020aa796f10000b0290142250139edmr859126pfq.60.1601077537908;
        Fri, 25 Sep 2020 16:45:37 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id n9sm3119447pgi.2.2020.09.25.16.45.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2020 16:45:36 -0700 (PDT)
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
Subject: [PATCH 0/2] selftests: Extract run_kselftest.sh and generate stand-alone test list
Date:   Fri, 25 Sep 2020 16:45:25 -0700
Message-Id: <20200925234527.1885234-1-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi!

I really like Hangbin Liu's intent[1] but I think we need to be a little
more clean about the implementation. This extracts run_kselftest.sh from
the Makefile so it can actually be changed without embeds, etc. Instead,
generate the test list into a text file. Everything gets much simpler.
:)

And in patch 2, I add back Hangin Liu's new options (with some extra
added) with knowledge of "collections" (i.e. Makefile TARGETS) and
subtests. This should work really well with LAVA too, which needs to
manipulate the lists of tests being run.

Thoughts?

-Kees

[1] https://lore.kernel.org/lkml/20200914022227.437143-1-liuhangbin@gmail.com/

Kees Cook (2):
  selftests: Extract run_kselftest.sh and generate stand-alone test list
  selftests/run_kselftest.sh: Make each test individually selectable

 tools/testing/selftests/Makefile         | 26 ++-----
 tools/testing/selftests/lib.mk           |  5 +-
 tools/testing/selftests/run_kselftest.sh | 89 ++++++++++++++++++++++++
 3 files changed, 98 insertions(+), 22 deletions(-)
 create mode 100755 tools/testing/selftests/run_kselftest.sh

-- 
2.25.1

