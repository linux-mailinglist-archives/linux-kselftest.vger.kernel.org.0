Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22D457ADDAE
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Sep 2023 19:14:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231395AbjIYROq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 25 Sep 2023 13:14:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbjIYROp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 25 Sep 2023 13:14:45 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B57D107
        for <linux-kselftest@vger.kernel.org>; Mon, 25 Sep 2023 10:14:39 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id 5614622812f47-3adba522a5dso4132124b6e.2
        for <linux-kselftest@vger.kernel.org>; Mon, 25 Sep 2023 10:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695662078; x=1696266878; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PAufuLXu5pawlfTE6eOjTvzrwlkHEhvIkqQPTRTOQvY=;
        b=VQN6nTSkpAKxmtOFHOyk0Q550C03oTjM8T92PLugu8ozY2SpSf1QmVfUPRusclBSRq
         xN7Sl5b1dW+EpBygszJhAo/THPM+QhntKuAoLM7T2F+NmIz0ntrXD6SGhsY8eizSIRXo
         3NZ9FwGPzDU1v/AXsTlA/bSyjY2Iyz0kWlVOs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695662078; x=1696266878;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PAufuLXu5pawlfTE6eOjTvzrwlkHEhvIkqQPTRTOQvY=;
        b=tPfb8ArEEcyTUAU6srAmd6++DZwCFnue928T8nK2BjhtzQ4ZGOwebDulrCT0TBb4aD
         511GjYJfTmlJXCu4tiktdBgmdEhTYOPTmgWRKOgiTkL9c/vILjdLpIg01wouSCsgJgi/
         ZrYNzhmLfYL8+37y9Lyq10JkrMyG0vGuT12r0hbftaZDRAZ12BRrNx0W25GFt3/7+69y
         13HBeMIOoNWRbwrgqntMbclgEx413A2WsukyFwSyB6J3NdGogK6laE7nXyJRXor+Dx8d
         vYyZMduRbqvIToYtDrASGqQFmKs1PwLE/UHjPsbHKr3AnI8KVq7hBxa0k4JtUhmvOeya
         RchA==
X-Gm-Message-State: AOJu0Yw07PZ/k/yvGqCS7rB4M5C+mOee/4NF4zBs5LO+Vfh1i8MJugN5
        VqV0o+d0exNjt6HG7kJBFhECnMM4njJOVygPrCo=
X-Google-Smtp-Source: AGHT+IFXCG2dKKeAE549Z5IsbnTd9bbiGzZ8xwxdxIsr1oca3NoyiW/ynGMAT2UgAxEw3FxZo74XOw==
X-Received: by 2002:a05:6358:3398:b0:143:5383:af8b with SMTP id i24-20020a056358339800b001435383af8bmr7956212rwd.11.1695662078229;
        Mon, 25 Sep 2023 10:14:38 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id g22-20020a62e316000000b00687fcb1e609sm8281838pfh.116.2023.09.25.10.14.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 10:14:37 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     =?UTF-8?q?Ricardo=20Ca=C3=B1uelo?= <ricardo.canuelo@collabora.com>
Cc:     Kees Cook <keescook@chromium.org>, kernel@collabora.com,
        shuah@kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2] selftests/lkdtm: Disable CONFIG_UBSAN_TRAP in test config
Date:   Mon, 25 Sep 2023 10:14:33 -0700
Message-Id: <169566207189.319254.5288593313898696067.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230802063252.1917997-1-ricardo.canuelo@collabora.com>
References: <20230802063252.1917997-1-ricardo.canuelo@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, 02 Aug 2023 08:32:52 +0200, Ricardo Cañuelo wrote:
> The lkdtm selftest config fragment enables CONFIG_UBSAN_TRAP to make the
> ARRAY_BOUNDS test kill the calling process when an out-of-bound access
> is detected by UBSAN. However, after this [1] commit, UBSAN is triggered
> under many new scenarios that weren't detected before, such as in struct
> definitions with fixed-size trailing arrays used as flexible arrays. As
> a result, CONFIG_UBSAN_TRAP=y has become a very aggressive option to
> enable except for specific situations.
> 
> [...]

Applied to for-next/hardening, thanks!

[1/1] selftests/lkdtm: Disable CONFIG_UBSAN_TRAP in test config
      https://git.kernel.org/kees/c/64d0436d8588

Take care,

-- 
Kees Cook

