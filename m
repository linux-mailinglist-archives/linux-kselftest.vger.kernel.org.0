Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00D24262388
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Sep 2020 01:22:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728643AbgIHXW4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Sep 2020 19:22:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726002AbgIHXWz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Sep 2020 19:22:55 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C368C061573
        for <linux-kselftest@vger.kernel.org>; Tue,  8 Sep 2020 16:22:55 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id g29so663755pgl.2
        for <linux-kselftest@vger.kernel.org>; Tue, 08 Sep 2020 16:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8vw8y/keL8WobWtmOV5HZRJN8/Uakg/hovhFlM5RtH0=;
        b=dhgVv6ytoDhKtI7epFtTsWzhO99dRLXs9qP6tHOGr0W9iPEBMxhPEYFzCPy4e45x1p
         iv7oDHrhvzoFHFQbgnieeDK9qlcnx9jCxpTM73Wv9OxRI1dQYBAzJ5GwMJlhCteDErSG
         EnPe8FFbiKqJ1TpYawiqNukVf+bzmUYQIoggE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8vw8y/keL8WobWtmOV5HZRJN8/Uakg/hovhFlM5RtH0=;
        b=XiSsF/4F0mn4nuazQaJDSqyj0p3bD0kcxY5PJy4P0cbKgU5RwR3RFfbvDWeRNHv0J7
         q+JGaK/rDbDKrxYjTP8iA37p6LtP/PXgvdlF1WyMSszGu+SqpPJ2yAGo4CGqehA7lXK0
         FYsjy4rHS6JEXLMs/myqcVSWr5lftJcOWdDU2nqTwacOiSnOSDksgGvKq1OmUj7l8yNP
         L6LKpFJWF6BM0WV2/3m0AxT1ScQNNaRkooNR8rxZC/ktyiyNSLGJ0uPPkbiu8bmvfvnK
         ga0qdRYNstW7gvKOYJQUp4KCNj193kcJNIwkmwBK3MrcmI3up6l0SDwTxOddSUMmiZiy
         nAJg==
X-Gm-Message-State: AOAM530maWdyLVpnGdg3+vkdZZpD4KQ865gDPWpNprA52IIFSyVMvqCp
        34JgDrmLL+E1LBpbk9mVh9nyQA==
X-Google-Smtp-Source: ABdhPJyWsjXkHCgvBe7fbOxyDUTgQ0nowPHAXIjoEPMa62KZxAej8RSYGYurVX5t0SOTnFuQ0UNLDw==
X-Received: by 2002:aa7:942a:: with SMTP id y10mr1046719pfo.68.1599607374934;
        Tue, 08 Sep 2020 16:22:54 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 194sm474000pfy.44.2020.09.08.16.22.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 16:22:54 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     kafai@fb.com, songliubraving@fb.com,
        linux-kselftest@vger.kernel.org, luto@amacapital.net,
        wad@chromium.org, daniel@iogearbox.net, john.fastabend@gmail.com,
        kpsingh@chromium.org, shuah@kernel.org, netdev@vger.kernel.org,
        Zou Wei <zou_wei@huawei.com>, yhs@fb.com, andriin@fb.com,
        bpf@vger.kernel.org, ast@kernel.org, linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH -next] selftests/seccomp: Use bitwise instead of arithmetic operator for flags
Date:   Tue,  8 Sep 2020 16:22:12 -0700
Message-Id: <159960731879.1678444.6814133998182138035.b4-ty@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <1586924101-65940-1-git-send-email-zou_wei@huawei.com>
References: <1586924101-65940-1-git-send-email-zou_wei@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, 15 Apr 2020 12:15:01 +0800, Zou Wei wrote:
> This silences the following coccinelle warning:
> 
> "WARNING: sum of probable bitmasks, consider |"
> 
> tools/testing/selftests/seccomp/seccomp_bpf.c:3131:17-18: WARNING: sum of probable bitmasks, consider |
> tools/testing/selftests/seccomp/seccomp_bpf.c:3133:18-19: WARNING: sum of probable bitmasks, consider |
> tools/testing/selftests/seccomp/seccomp_bpf.c:3134:18-19: WARNING: sum of probable bitmasks, consider |
> tools/testing/selftests/seccomp/seccomp_bpf.c:3135:18-19: WARNING: sum of probable bitmasks, consider |

Applied, thanks!

[1/1] selftests/seccomp: Use bitwise instead of arithmetic operator for flags
      https://git.kernel.org/kees/c/76993fe3c1e4

Sorry for the massive delay on this one! I lost this email in my inbox. :)

-- 
Kees Cook

