Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2D7252ADB4
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 May 2022 23:53:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbiEQVxt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 17 May 2022 17:53:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbiEQVxt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 17 May 2022 17:53:49 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5901A52B3F
        for <linux-kselftest@vger.kernel.org>; Tue, 17 May 2022 14:53:48 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id z7-20020a17090abd8700b001df78c7c209so3796845pjr.1
        for <linux-kselftest@vger.kernel.org>; Tue, 17 May 2022 14:53:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=C40m2Lc+hbE2HZtiF1GEQoSOONIhAIucdtMggOxGNeE=;
        b=ODtm0xJBW745rKr7CcjoK45FX2tcqA0/8aVOLndK+GjaCYtkIZ5MlUUIMv0aPcKM0o
         RxP/yC4sSxuXOA35Mmf98ap0IJPnFN0ui9fXIKVkVNf03GjpTnBetqnFveZ6IeeSpPZo
         t5a2H9vGJf2j9uqDGElDiw43dYcybMbTkqpCc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=C40m2Lc+hbE2HZtiF1GEQoSOONIhAIucdtMggOxGNeE=;
        b=yWo2tCvqrmoTHxAPCV4qeARMFkhty9LEGYRgOf4IIbRADVBgn0USjqRDLQk6DWg3mg
         HThiZipX8e1MsQo9iIclEuCzepTdntnoOf9mdC6ABIekgpG00K8mPT5CeGvcYHyhh8X8
         KGXLTtgtfiUe1mZn0W0dU9ylQsjwCrLl6SJCM2E1a9ER+r6ZnxP4WetHbgQDcrd6x8YA
         8bPMsptipErO/LLr4QGIrHCDYIq6GsdGahjlrbEGF9Ap62rtW+8xbszBqLsDL9acUvmy
         AjzvesG6JurUEyk+GOOOlRgmTIcj+hJzvmIp2WLRVMRXOLdMWAdA3reaRjFe+sALNCDk
         /prA==
X-Gm-Message-State: AOAM533xb7Vdt5J8CBRsXhFOG4DZkHYZ1+NMk+5bT+N8efOg1nk2dH3g
        +BdIR5tASPGInu7nRPWw2j1fvg==
X-Google-Smtp-Source: ABdhPJysaDWZtgtnnxq/bdt1RPBGF+0gxiHhLFOtEPL9C51wZH42ItY9ww5qFSigdYr+AgJVsWd9tg==
X-Received: by 2002:a17:903:2443:b0:161:bc26:825 with SMTP id l3-20020a170903244300b00161bc260825mr1612498pls.32.1652824427869;
        Tue, 17 May 2022 14:53:47 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id v24-20020a170902e8d800b0015f086e4aa5sm75200plg.291.2022.05.17.14.53.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 14:53:47 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     usama.anjum@collabora.com
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        kernel@collabora.com, linux-kselftest@vger.kernel.org,
        shuah@kernel.org
Subject: Re: [PATCH] selftests/lkdtm: add config
Date:   Tue, 17 May 2022 14:53:18 -0700
Message-Id: <165282439481.879192.6175196633705238781.b4-ty@chromium.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220517132932.1484719-1-usama.anjum@collabora.com>
References: <20220517132932.1484719-1-usama.anjum@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, 17 May 2022 18:29:31 +0500, Muhammad Usama Anjum wrote:
> Add config options which are needed for LKDTM sub-tests.
> STACKLEAK_ERASING test needs GCC_PLUGIN_STACKLEAK config.
> READ_AFTER_FREE and READ_BUDDY_AFTER_FREE tests need
> INIT_ON_FREE_DEFAULT_ON config.
> 
> 

Applied to for-next/lkdtm, thanks!

[1/1] selftests/lkdtm: add config
      https://git.kernel.org/kees/c/38c84c997d40

-- 
Kees Cook

