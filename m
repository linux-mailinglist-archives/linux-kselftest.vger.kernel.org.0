Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C89653681E
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 May 2022 22:34:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351434AbiE0UeN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 27 May 2022 16:34:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230135AbiE0UeL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 27 May 2022 16:34:11 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47D8F1269BB
        for <linux-kselftest@vger.kernel.org>; Fri, 27 May 2022 13:34:10 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id d129so4826895pgc.9
        for <linux-kselftest@vger.kernel.org>; Fri, 27 May 2022 13:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BhWiy+u6CGIxU/xIbrrvAKnLH+DMq1tyIbHLZpH6IYA=;
        b=KSwFPHiiGG1DMPxJblwbpP1Ur2ictm9QtDr7vMqJeyIoPo+SXOmrbr2i/OYxRbDxM3
         o4jKrNaKqIm4jhthNdZ9zuB1J0dnww89O+V/4/KFWWq8kII6xZ+XamzwcRqtbR1iPQ5A
         rwieHD4Y2s344gn/ma8mBg38ntnc9PXu4cW7A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BhWiy+u6CGIxU/xIbrrvAKnLH+DMq1tyIbHLZpH6IYA=;
        b=o6a8/lZU9PV/9pOKv2rFlpacn61HK75uSF6bkW+eA3LunspCEOhwckpia9zLwi05Fr
         weac5XCV8AS9+0AUJZ71iYYROgFPYNs4R2Ho0o4f4uznShk2L8eaJ9G/pUVAv1QMmSv3
         BrFondMcUIx9GRkv5lgyJy4ohXc8PD9mhg+43s7moMr7RPpCj+0f3Wb0WXQZcyGezwrO
         sMYGcBMutwqXeTCI0GidN/1nerJIxT+jWsEm/CxRl+rH+Pzhamw8N4o+jKN8TImTNAE2
         5s6FQmtBkT/hCjp1ONX3LeoMWAuRMjA+3h+eb/83FHN5jwmP1YR8VZQHgwKexfDrtFhC
         2PZA==
X-Gm-Message-State: AOAM530eRh9xbLORuVrLgA7DJ0hLetsVKhzF05//NYGTeXy3Lo3N4MpK
        I7xnKuyuTXcSIlS70Ouc1++oOQ==
X-Google-Smtp-Source: ABdhPJzUD2QjIliB8iVM+amgGA8Khu4/8pI/8T3lk3zMUpCf+RrhJEX4WjwNEWS14JAuyuRq1ZpcCw==
X-Received: by 2002:a63:1a17:0:b0:3fa:e901:1c68 with SMTP id a23-20020a631a17000000b003fae9011c68mr11571011pga.243.1653683649828;
        Fri, 27 May 2022 13:34:09 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id v9-20020a17090a0e0900b001df93c8e737sm2009741pje.39.2022.05.27.13.34.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 May 2022 13:34:09 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     zhuyifei@google.com
Cc:     Kees Cook <keescook@chromium.org>, shuah@kernel.org,
        luto@amacapital.net, wad@chromium.org, bpf@vger.kernel.org,
        brauner@kernel.org, llvm@lists.linux.dev,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH seccomp] selftests/seccomp: Fix compile warning when CC=clang
Date:   Fri, 27 May 2022 13:34:01 -0700
Message-Id: <165368363912.774765.17949173463800378438.b4-ty@chromium.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220526223407.1686936-1-zhuyifei@google.com>
References: <20220526223407.1686936-1-zhuyifei@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, 26 May 2022 22:34:07 +0000, YiFei Zhu wrote:
> clang has -Wconstant-conversion by default, and the constant 0xAAAAAAAAA
> (9 As) being converted to an int, which is generally 32 bits, results
> in the compile warning:
> 
>   clang -Wl,-no-as-needed -Wall -isystem ../../../../usr/include/  -lpthread  seccomp_bpf.c -lcap -o seccomp_bpf
>   seccomp_bpf.c:812:67: warning: implicit conversion from 'long' to 'int' changes value from 45812984490 to -1431655766 [-Wconstant-conversion]
>           int kill = kill_how == KILL_PROCESS ? SECCOMP_RET_KILL_PROCESS : 0xAAAAAAAAA;
>               ~~~~                                                         ^~~~~~~~~~~
>   1 warning generated.
> 
> [...]

Applied to for-next/seccomp, thanks!

[1/1] selftests/seccomp: Fix compile warning when CC=clang
      https://git.kernel.org/kees/c/73a8dbafd31a

-- 
Kees Cook

