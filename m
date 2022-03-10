Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F9D14D51ED
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Mar 2022 20:43:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245361AbiCJSSK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 10 Mar 2022 13:18:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236928AbiCJSSK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 10 Mar 2022 13:18:10 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8448913D906
        for <linux-kselftest@vger.kernel.org>; Thu, 10 Mar 2022 10:17:08 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id v1-20020a17090a088100b001bf25f97c6eso7083967pjc.0
        for <linux-kselftest@vger.kernel.org>; Thu, 10 Mar 2022 10:17:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8i9PcoBgS4Z5fTHkHhwCw2b7OCjvoaGKsCGSTw+C1tM=;
        b=FHz7R3ScT4P/6jx0UHpLjssNo+wzcUAnkAq0eNZlWWEK3aYGOxTGOxoQ/SFYQ4gitQ
         IzTn31mtdV3LRCsbXyZSNMjDZxDVwh14jEA1Mz6aZXSZSmLrPmfX8dxOIT0DkyfXgObJ
         sadA5/c2IF8P5u2OaXSS9m3nK92vT8MhshqvQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8i9PcoBgS4Z5fTHkHhwCw2b7OCjvoaGKsCGSTw+C1tM=;
        b=3uY474DI1an01Ry+GGrEl2jFjRNb4pZmvZGRJlMlD6N0Rhe4hw4iIyn688WY7DRsD5
         MHHfJlWdelcW8NjOdF0cSM01RZ5PrUyV982VS4oD7Uu9D6YYE8fnkPbO5QYsEZQZd6CZ
         4YMZYDWbgUyUhsY61a8KsMRQ94Qaop7V6rpBAxajV2UO5EfsiEpiGz3TCW6fylRLeP10
         bz60CjWFmWX108lL/CB613Vfq3UM9CKi6fj6S0H+6F7Y0FVM61YJcI9bbbog3HbUe4PS
         8aJzmc1NzHug375tc1iYIHHBtMPfeKuv44s57ESjwDYjnMfseA0Q7MvSGQE9dX+sTTJU
         z3Iw==
X-Gm-Message-State: AOAM531J6iqFhIQ2TmvbFHR4RNx03wbDr0hYg+vu298CRk7clpukEp0e
        ysbpELSJcIQCA0+laobM8zK8ug==
X-Google-Smtp-Source: ABdhPJzmiruB6ATSxE49WZKgHvZiUJtMXmtRjvqxJVHf8r+8/uOrEQawYL1mjAJMJLNoP66nxh0ubA==
X-Received: by 2002:a17:902:9a4b:b0:14f:fe0b:5546 with SMTP id x11-20020a1709029a4b00b0014ffe0b5546mr6364220plv.46.1646936227861;
        Thu, 10 Mar 2022 10:17:07 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id w5-20020a17090a4f4500b001bf3bdf39a8sm6785842pjl.4.2022.03.10.10.17.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Mar 2022 10:17:07 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     luc.vanoostenryck@gmail.com, nathan@kernel.org, shuah@kernel.org,
        mark.rutland@arm.com, akpm@linux-foundation.org,
        tglx@linutronix.de, ndesaulniers@google.com, linux@roeck-us.net,
        gregkh@linuxfoundation.org, catalin.marinas@arm.com,
        will@kernel.org, npiggin@gmail.com, arnd@arndb.de,
        masahiroy@kernel.org, ojeda@kernel.org,
        Dan Li <ashimida@linux.alibaba.com>, elver@google.com,
        samitolvanen@google.com
Cc:     Kees Cook <keescook@chromium.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-kselftest@vger.kernel.org
Subject: Re: (subset) [PATCH v3 1/2] AARCH64: Add gcc Shadow Call Stack support
Date:   Thu, 10 Mar 2022 10:15:37 -0800
Message-Id: <164693613561.1275052.17242543278628621803.b4-ty@chromium.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220303074323.86282-1-ashimida@linux.alibaba.com>
References: <20220303073340.86008-1-ashimida@linux.alibaba.com> <20220303074323.86282-1-ashimida@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, 2 Mar 2022 23:43:23 -0800, Dan Li wrote:
> Shadow call stacks will be available in GCC >= 12, this patch makes
> the corresponding kernel configuration available when compiling
> the kernel with the gcc.
> 
> Note that the implementation in GCC is slightly different from Clang.
> With SCS enabled, functions will only pop x30 once in the epilogue,
> like:
> 
> [...]

I'm taking this one now so it'll make the merge window. We can hammer
out the lkdtm test after that.

Applied to for-next/hardening, thanks!

[1/2] arm64: Add gcc Shadow Call Stack support
      https://git.kernel.org/kees/c/afcf5441b9ff

-- 
Kees Cook

