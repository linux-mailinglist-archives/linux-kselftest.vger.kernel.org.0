Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA6A664CFB2
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Dec 2022 19:53:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238090AbiLNSxB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 14 Dec 2022 13:53:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbiLNSxA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 14 Dec 2022 13:53:00 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E94A928E2D
        for <linux-kselftest@vger.kernel.org>; Wed, 14 Dec 2022 10:52:56 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id r18so2584142pgr.12
        for <linux-kselftest@vger.kernel.org>; Wed, 14 Dec 2022 10:52:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3OH5piqQgYs2HTpmjsVvlC/zkWvQoKtSKrvl3IZUHZQ=;
        b=bI1QN40VfMI5YffahIskXJ19TxDe1I9BCbHooK/Oq0RHU8deXnhE+Uzgfmwy9d4kI9
         4l5UD0lWzsJh0Wh1y5ViJkI5rntsqx9KWbjNYwh6ih7fissYH/mdaOxsJXfbTnXWqtob
         pvxkFzZ/YnE344PU68pGDiTSvnfzuCbQUByWI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3OH5piqQgYs2HTpmjsVvlC/zkWvQoKtSKrvl3IZUHZQ=;
        b=RPQLV+teL65w9tpVU1o40l71yHmCu82HqsI0y1AMG4zBBXx0pbVEA7WqhEFVsq4mU7
         WT91FMqOEoM9/9HS0jCWoLDclAkrOrnDcLKJxqtEngI+4G+xcCuf2hKkPWcCd1n6lToT
         hFyMSoi77BZslmRFTDn7oYadGcqr5vD5u3edNZYVYyBoxWQl6ofdX4wqbkCC6UMAIV5f
         RQyWtCX3fDPbMrSRBQo8BvNjjjTNB4NZNryaQTgmoFoJFjlF6MkEsNEUhiIvliBwXQy5
         vcdnFFnPajnIwZBydFiZMBN0a4nNTHWUN8PTvj3tIHR5DnfsehRlBZbdP9QujNo71PM2
         KWjw==
X-Gm-Message-State: ANoB5pmtLZ3olMQF1Eclfm8CdisbDAVkvuRZlHUyZOJB5MS4U32VDyoF
        K9mr7UCa3ekO/McTgVTGETj2Rg==
X-Google-Smtp-Source: AA0mqf65AEZDaIMr5dElxYb0kE1PXzokNGbweS278MyeHeqmjC2k8jXN/Ezzt8ghTuysEsp3KngeHQ==
X-Received: by 2002:a62:3103:0:b0:576:14a4:b76a with SMTP id x3-20020a623103000000b0057614a4b76amr22717330pfx.34.1671043976432;
        Wed, 14 Dec 2022 10:52:56 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id a2-20020a624d02000000b00576d4d69909sm228569pfb.8.2022.12.14.10.52.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Dec 2022 10:52:55 -0800 (PST)
Date:   Wed, 14 Dec 2022 10:52:54 -0800
From:   Kees Cook <keescook@chromium.org>
To:     jeffxu@chromium.org
Cc:     skhan@linuxfoundation.org, akpm@linux-foundation.org,
        dmitry.torokhov@gmail.com, dverkamp@chromium.org, hughd@google.com,
        jeffxu@google.com, jorgelo@chromium.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, jannh@google.com,
        linux-hardening@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH v7 2/6] selftests/memfd: add tests for F_SEAL_EXEC
Message-ID: <202212141052.3B04BF6@keescook>
References: <20221209160453.3246150-1-jeffxu@google.com>
 <20221209160453.3246150-3-jeffxu@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221209160453.3246150-3-jeffxu@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Dec 09, 2022 at 04:04:49PM +0000, jeffxu@chromium.org wrote:
> From: Daniel Verkamp <dverkamp@chromium.org>
> 
> Basic tests to ensure that user/group/other execute bits cannot be
> changed after applying F_SEAL_EXEC to a memfd.
> 
> Signed-off-by: Daniel Verkamp <dverkamp@chromium.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
