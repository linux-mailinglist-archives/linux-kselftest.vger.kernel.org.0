Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D445F647401
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Dec 2022 17:16:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbiLHQQZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 8 Dec 2022 11:16:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbiLHQQY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 8 Dec 2022 11:16:24 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65EE2AE4C8
        for <linux-kselftest@vger.kernel.org>; Thu,  8 Dec 2022 08:16:18 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id d3so1940460plr.10
        for <linux-kselftest@vger.kernel.org>; Thu, 08 Dec 2022 08:16:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5lfY71TAViOQoe8YQHZ95RIFrQ+A11ZWICcAERJdWds=;
        b=hTN6H1OVBAFSCwo/nxyNAtyDzh106TmfYVB4USPC+RT73HCInYFg1auXkJ182+uwoX
         QrnwHu8oZr+KHn59TSvHWnjU3dea2id9D+YkQ6cfcXskt11hkUTHL3ZkGVE9SE2x66/4
         epv9mfaRYkC49+0DD6wlucjfoGmRJdF805Ny8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5lfY71TAViOQoe8YQHZ95RIFrQ+A11ZWICcAERJdWds=;
        b=zfeckvnSe8r72heQcuZPtsUUKTCwR8LjDazX4eSnIcAtV/b4h3Z1PPR+B5ZJHDXISa
         u7Nj57CVKSO0L/QEySK32+rSjAXp8GegsYVXEs3FpLlwZFnagio1AtZ+PlOnhdFRJ6Iv
         OpvET+TmXYwpVFSaQQ8d6GhrQMjlHsMX/z1yVpmgww7ak5IAPoac2UQmGjz2utnNvxal
         wQSc26BBW5VzBZEgbX5yS2cRyggXWZ0fZTBN/DfEj7Ds86hsa79jeRaxTY2iBkL/p/oN
         LjbNFioZbqwH9GpQer2+RPeh28ZC84cKC8L7Tqe+8DdSB8KvRFPYmVT4W+M6A9GKmNqi
         68Nw==
X-Gm-Message-State: ANoB5pl8ynytqWLgBvtGeUkpf/MlmzsEuh26hSeDzcBHCqs6C8X4v5SC
        X5j00qvajOUYSAB5h1T1dhWU0Q==
X-Google-Smtp-Source: AA0mqf7HpLsd2uW2CYrl0cCNhuhZbciNR3eUqo8jRlRor65NEX26E+Iv7KyDDQfTOVBuaHYoLQ2iHw==
X-Received: by 2002:a17:90a:ad85:b0:21a:1d94:568f with SMTP id s5-20020a17090aad8500b0021a1d94568fmr4818888pjq.51.1670516178264;
        Thu, 08 Dec 2022 08:16:18 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id w6-20020a170902a70600b00174f7d10a03sm7377321plq.86.2022.12.08.08.16.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Dec 2022 08:16:17 -0800 (PST)
Date:   Thu, 8 Dec 2022 08:16:17 -0800
From:   Kees Cook <keescook@chromium.org>
To:     jeffxu@chromium.org
Cc:     skhan@linuxfoundation.org, akpm@linux-foundation.org,
        dmitry.torokhov@gmail.com, dverkamp@chromium.org, hughd@google.com,
        jeffxu@google.com, jorgelo@chromium.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, jannh@google.com,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH v6 1/6] mm/memfd: add F_SEAL_EXEC
Message-ID: <202212080814.821C05264@keescook>
References: <20221207154939.2532830-1-jeffxu@google.com>
 <20221207154939.2532830-2-jeffxu@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221207154939.2532830-2-jeffxu@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Dec 07, 2022 at 03:49:34PM +0000, jeffxu@chromium.org wrote:
> From: Daniel Verkamp <dverkamp@chromium.org>
> 
> The new F_SEAL_EXEC flag will prevent modification of the exec bits:
> written as traditional octal mask, 0111, or as named flags, S_IXUSR |
> S_IXGRP | S_IXOTH. Any chmod(2) or similar call that attempts to modify
> any of these bits after the seal is applied will fail with errno EPERM.
> 
> This will preserve the execute bits as they are at the time of sealing,
> so the memfd will become either permanently executable or permanently
> un-executable.
> 
> Signed-off-by: Daniel Verkamp <dverkamp@chromium.org>
> Co-developed-by: Jeff Xu <jeffxu@google.com>
> Signed-off-by: Jeff Xu <jeffxu@google.com>

It looks like my Reviewed-by: tag was dropped?

https://lore.kernel.org/lkml/202212021443.0F684E33@keescook/

This patch is unchanged, so please carry forward any review/ack/tested
tags, etc.

But for the bots:

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
