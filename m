Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7772A64F269
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Dec 2022 21:35:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231226AbiLPUfO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 16 Dec 2022 15:35:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbiLPUfN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 16 Dec 2022 15:35:13 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FC762E698
        for <linux-kselftest@vger.kernel.org>; Fri, 16 Dec 2022 12:35:12 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id m4so3443176pls.4
        for <linux-kselftest@vger.kernel.org>; Fri, 16 Dec 2022 12:35:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=r/hPsvfVFhvh9haGKLunftTxDivO3JDSv2xgcZcDsPA=;
        b=HvYgLvzKyB+qontqJaRxw4JCx5keeHG+fJkK4euqza/veNJBrv8ioB2lE6IXO0VI3n
         esNkVZN37PeYArveZqKULuIZn7F1HgLhZ7ZOg+3+Q1JX2YF8qc0w9Jp9AkLmPCAxaHXq
         9NQKhQSoi5qpbGUeWi2a7tg62N+alAyY5VjrQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r/hPsvfVFhvh9haGKLunftTxDivO3JDSv2xgcZcDsPA=;
        b=oG0pJLpTYavDXeH101NW78+hob1epUMozflM6hnvMATqZchwWxucpqOb4rASNUvTNg
         5WJYT7EDgKhXecd7jCCcdUvpzaPNrbRAYgnpHcSIX+1pUDWbM2fWFrftCVbmoYgZHOQP
         ezSfqEJ0JO2U+6G3DRuNyJit1gLmitiWeXQ1lBpIjKxpzB+dJpKAREDZBsIsuy0WQAu+
         IOB28icVBbdl7isx1ukATR11+7R62QMVO97aEEuvpwE4+FlvJL7yUMMSaWlrxDeI2WIB
         5MO1XaGPpkXGhlh0OfoTBlkN2T2AnU6VUuR2zgWQIj+imMAyk1QQnzlcGzhY81M+sPe/
         TkbA==
X-Gm-Message-State: AFqh2ko/XwhTWE5EaVKFSSfgPHn5U5xl6SaLj5/vdyVSUNsvRpl37p2l
        bRqZwNg5p+dKEEtqO5wD4w7wGw==
X-Google-Smtp-Source: AMrXdXt8w3fEbmDbvTVO1Z+Z3U9o6ttyQJonRnCieP1HRMjM8XxbOprdtKK2Ib64+zi1S8WdDE+mjA==
X-Received: by 2002:a17:902:d4c6:b0:191:a19:e768 with SMTP id o6-20020a170902d4c600b001910a19e768mr1842628plg.48.1671222912139;
        Fri, 16 Dec 2022 12:35:12 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id i4-20020a17090332c400b0018913417ba2sm2039045plr.130.2022.12.16.12.35.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Dec 2022 12:35:11 -0800 (PST)
Date:   Fri, 16 Dec 2022 12:35:10 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Jeff Xu <jeffxu@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>, jeffxu@chromium.org,
        skhan@linuxfoundation.org, dmitry.torokhov@gmail.com,
        dverkamp@chromium.org, hughd@google.com, jorgelo@chromium.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, jannh@google.com,
        linux-hardening@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v6 3/6] mm/memfd: add MFD_NOEXEC_SEAL and MFD_EXEC
Message-ID: <202212161233.85C9783FB@keescook>
References: <20221207154939.2532830-1-jeffxu@google.com>
 <20221207154939.2532830-4-jeffxu@google.com>
 <202212080821.5AE7EE99@keescook>
 <CALmYWFuKR538vHxqYH1p6mb9iShOohf5bpHZXSfUN4KQHYiwaA@mail.gmail.com>
 <Y5yS8wCnuYGLHMj4@x1n>
 <CALmYWFsDhX76zbcyhYAW-u0BBwD+m+TKpt4_pZTMt+22zHhrGQ@mail.gmail.com>
 <20221216094259.bec91e4abd6cf54a05ce2813@linux-foundation.org>
 <CALmYWFsNp87a5uVQUAb4PG0khFN8Xxd=ibh9Q7g-Y0XW1Mn-8Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALmYWFsNp87a5uVQUAb4PG0khFN8Xxd=ibh9Q7g-Y0XW1Mn-8Q@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Dec 16, 2022 at 10:11:44AM -0800, Jeff Xu wrote:
> Once per boot seems too little, it would be nice if we can list all processes.
> I agree ratelimited might be too much.
> There is a feature gap here for logging.
> 
> Kees, what do you think ?

I agree once per boot is kind of frustrating "I fixed the one warning,
oh, now it's coming from a different process". But ratelimit is, in
retrospect, still too often.

Let's go with per boot -- this should be noisy "enough" to get the
changes in API into the callers without being too much of a hassle.

-- 
Kees Cook
