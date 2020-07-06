Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 085822160C1
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 Jul 2020 23:03:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725941AbgGFVDy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 6 Jul 2020 17:03:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725860AbgGFVDy (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 6 Jul 2020 17:03:54 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B91CC061755;
        Mon,  6 Jul 2020 14:03:54 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id x9so34191380ila.3;
        Mon, 06 Jul 2020 14:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dJcRuZiW502lyt79q4NbNcGnwyJ5bsa33N05bbGF6KY=;
        b=fb4LEAwelQZhBQartXxX+K/z44dEfBN+CPqGvIDl+w7J1eLsZPkVXNhLzEtikXgReS
         +kiRBi08ZCwZ+PPJFB9D3EOpNO5HLXS+ycWHz9V7rZAObNI6UqEHcC4Gl3UV8b8CLakz
         wfzLUGnyJUkT35yrmYXTdJ7cVGBlmCn9848F/S7cHvS2/zfkQn5fliOy4t/r2JfSjwt1
         TdsZI88OPbRTCk3fPc7i5LAlYv1gZmazaTydrZ6KmACsGRshcKdC4/ndKYzyqWfXdMAn
         IC+J/QsJ+7w+UVUWJEfKRf92Zrktl87lyYtzQf7mhdB6h32coDdSTwt9/m3Be41th6Hy
         fQCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dJcRuZiW502lyt79q4NbNcGnwyJ5bsa33N05bbGF6KY=;
        b=qqJiBseUfiXQi2vuFimn84xYlJhR/uFlFc+dLNdRX9TGb6gr7MuKn8SBcfGys/JttZ
         /OStZot+gwATU9Wlaz0ncPKtRqU0OKpnd+XopsM8VBwC6xiSb8ZqxQz1+eddeKRVHxTp
         AGxnT8HmI4cRfukbpOvNb+LVEHexbQYFMy/F7EuDK6KeCQ0atsYWXV/iDAGW87Tw6AEB
         E1rZhYALKDwyVWNz4eSAREUtMAV2xSRJMtE4fr6m+qz6QpVl4YcNL5ulL9p9/uQVg3Bd
         wAAubKSOX98r0kxzEgQOmVbFXKpYZUTgnIBwsNwUEdYe/FGRolJCJWU4F0GH+1OFzLDV
         ND3Q==
X-Gm-Message-State: AOAM530wwXkO8VD/gGcnlQMBcXDb+ljlZBhCkxL0s0B5u5CHj50HrLrZ
        T9P99OVKi3/QFMyS+e1wzLQ=
X-Google-Smtp-Source: ABdhPJzHQY4gcWWjayoSceEU/AntNo9Wx92xwOBX0gPaOOwxbeSczT6JhlIJ0FRm2x/EtGbmnO6XSg==
X-Received: by 2002:a92:d24a:: with SMTP id v10mr33073352ilg.224.1594069433312;
        Mon, 06 Jul 2020 14:03:53 -0700 (PDT)
Received: from urieldev.c.googlers.com.com (243.199.238.35.bc.googleusercontent.com. [35.238.199.243])
        by smtp.gmail.com with ESMTPSA id v10sm11522730ilj.40.2020.07.06.14.03.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2020 14:03:52 -0700 (PDT)
From:   Uriel Guajardo <urielguajardojr@gmail.com>
To:     brendanhiggins@google.com, catalin.marinas@arm.com,
        akpm@linux-foundtation.org
Cc:     changbin.du@intel.com, rdunlap@infradead.org, masahiroy@kernel.org,
        0x7f454c46@gmail.com, urielguajardo@google.com, krzk@kernel.org,
        kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-mm@kvack.org
Subject: [PATCH 0/2] KUnit-Kmemleak Integration
Date:   Mon,  6 Jul 2020 21:03:25 +0000
Message-Id: <20200706210327.3313498-1-urielguajardojr@gmail.com>
X-Mailer: git-send-email 2.27.0.212.ge8ba1cc988-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Uriel Guajardo <urielguajardo@google.com>

With these patches, KUnit can access and manually run kmemleak in every test
case. Any errors caught by kmemleak will cause the KUnit test to fail.

This patchset relies on "kunit: KASAN integration", which places the
currently running kunit test in task_struct. [1]

[1] https://lore.kernel.org/linux-kselftest/20200606040349.246780-2-davidgow@google.com

Uriel Guajardo (2):
  kunit: support kunit failures from debugging tools
  kunit: kmemleak integration

 include/kunit/test-bug.h | 15 +++++++++++++
 include/kunit/test.h     |  1 +
 include/linux/kmemleak.h | 11 ++++++++++
 lib/Kconfig.debug        | 26 +++++++++++++++++++++++
 lib/kunit/test.c         | 46 +++++++++++++++++++++++++++++++++++-----
 mm/kmemleak.c            | 27 +++++++++++++++++------
 6 files changed, 115 insertions(+), 11 deletions(-)
 create mode 100644 include/kunit/test-bug.h

-- 
2.27.0.212.ge8ba1cc988-goog

