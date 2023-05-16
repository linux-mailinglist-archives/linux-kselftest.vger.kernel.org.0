Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF290705857
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 May 2023 22:07:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbjEPUHl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 16 May 2023 16:07:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjEPUHl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 16 May 2023 16:07:41 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 669DF59E5
        for <linux-kselftest@vger.kernel.org>; Tue, 16 May 2023 13:07:40 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1ae3fe67980so777815ad.3
        for <linux-kselftest@vger.kernel.org>; Tue, 16 May 2023 13:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684267660; x=1686859660;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5yK4aZqvfgO0WJ8XP2YQsUwZXdAoZzrxUjN80rlLt4Q=;
        b=n+n0N1x1kTOQTXTYpkicsApchyuKJU6rIqOVr/nfeik1SxnFwCdYu5J+Ma2kGNR592
         GmeMv+aGpBEWPX5873vshFxa6mCp2oj/97to3/3iWUtqRKhDbg7Z+FErMibpYj5M7orE
         WEN8nXBaRrWCplSX+wTveuOU4SzH9b4zVDJwk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684267660; x=1686859660;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5yK4aZqvfgO0WJ8XP2YQsUwZXdAoZzrxUjN80rlLt4Q=;
        b=YiilXtU0n4QTNC3y4A3RHrlRxI3F6K7uK4nhcD2+WZcTwOVYtuSSK8LOXgWPCXg+Ur
         rBxR88sEg5Zak61PF8ZbnaCp8JLc+u7fv/YzNSnKDc2bkD9+z1kA2XNEMOJu9J04vb49
         YL0AtxGs31yVkl+3vuWt12wcrLOFC7rIAIjIMoo1xTU5VnLScxX0mfEvTRflVJ1Vj4fw
         hmnE3nNTEP0YebTR0xsPTr3+vHvh2P03XogPYSLvn+S/DhG8lHXkHkeSR20Al/2uDJSK
         kTFg+GX5WXroPpZIBW99KeU67UzlMBPJhevo3VW8X/kS2+ylkG6Imm0XDmvpciHumaG1
         TTOg==
X-Gm-Message-State: AC+VfDyoikb+9i65Q1Fy7+L/VUDeBI7D/6bQLgK4iqWHI0JGrcNR95Bv
        fR8+gBogIpgv9RTyXIZo0QDYBQ==
X-Google-Smtp-Source: ACHHUZ7u3rq8Nf3VNgH0qCDY5XXjRFg4nCnp6SRHMGYOyrcJwgfTQx+Kt2i9J0Ln1vx5tmCauEmMxQ==
X-Received: by 2002:a17:902:cec8:b0:1ad:c736:2090 with SMTP id d8-20020a170902cec800b001adc7362090mr24149254plg.3.1684267659998;
        Tue, 16 May 2023 13:07:39 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id g7-20020a170902868700b001a64c4023aesm15911708plo.36.2023.05.16.13.07.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 13:07:39 -0700 (PDT)
Date:   Tue, 16 May 2023 13:07:39 -0700
From:   Kees Cook <keescook@chromium.org>
To:     jeffxu@chromium.org
Cc:     dave.hansen@intel.com, luto@kernel.org, jorgelo@chromium.org,
        groeck@chromium.org, jannh@google.com, sroettger@google.com,
        akpm@linux-foundation.org, jeffxu@google.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH 3/6] PKEY: Apply PKEY_ENFORCE_API to mprotect
Message-ID: <202305161307.77B29D261@keescook>
References: <20230515130553.2311248-1-jeffxu@chromium.org>
 <20230515130553.2311248-4-jeffxu@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230515130553.2311248-4-jeffxu@chromium.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, May 15, 2023 at 01:05:49PM +0000, jeffxu@chromium.org wrote:
> From: Jeff Xu <jeffxu@google.com>
> 
> This patch enables PKEY_ENFORCE_API for the mprotect and
> mprotect_pkey syscalls.

All callers are from userspace -- this change looks like a no-op?

-Kees

-- 
Kees Cook
