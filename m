Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6817222C74
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Jul 2020 22:04:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729136AbgGPUEl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 16 Jul 2020 16:04:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728907AbgGPUEk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 16 Jul 2020 16:04:40 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86BD9C061755
        for <linux-kselftest@vger.kernel.org>; Thu, 16 Jul 2020 13:04:40 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id cv18so3315737pjb.1
        for <linux-kselftest@vger.kernel.org>; Thu, 16 Jul 2020 13:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8cjlPgn09p7l40db0k5FtyWMlNcHlH5a0ko12DoYDl8=;
        b=R2wl2O3bAKRmcG8CwSs2Q1w5Hfu4lrQCtvgaHOXYz089uxJGqL7jfyozh0dElVhkht
         HihXpzUVBYBgCTDp49G6vJod1zIH+8LnNuatOpdSaa02mG64zIzslDVh2t4P2ws/pltF
         4GmSr2KOtIN649ayUtFptrou3zZo1Q2nqVrD8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8cjlPgn09p7l40db0k5FtyWMlNcHlH5a0ko12DoYDl8=;
        b=Li3RG4b4cGLfgfzx1RnGMqgnaqGOp/MrQOanV3urELB3iWeycAv9iA5hFOrU71JfPN
         BlKVa1TP8X1F+UegXkjp0HA6UoGeHnoC5YF5UOPzYNOta4tnyu+OcvmpbsMNJkqG39gi
         t6akY5ZuwITaK1dhVduYozEG6xmeMwwkvcw4+JvwI58iqpgwa44cfHUwZ4NzT3ZZA15C
         o5NN91Eu5U8h4DveiYyi/jeOxpevTvBFA6h0E4QQPBfmMn15eopycmUf1m6d14ZitynB
         osaMnynhpLziqn4c7Fk5xkMQG2dUBs148hAAkE4HQyiQYBLkkqxn81EdXEjdKVPEf2h3
         IL6w==
X-Gm-Message-State: AOAM5323GywmTNa0e6Ok+p6Oi/CTO+dtKNwV+VgzqUguKVzWrHguGwh2
        TzyX8uURQBMPg7igbxqrKifqqw==
X-Google-Smtp-Source: ABdhPJzQmwwQY4qaLuGuH2c57JaOLP7yXkUxTXHj7pOsYZEf+Uu5diFNUB050bd6hczoiR9qcdlZ9g==
X-Received: by 2002:a17:90a:a50d:: with SMTP id a13mr6205936pjq.95.1594929879858;
        Thu, 16 Jul 2020 13:04:39 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y19sm5695800pgj.35.2020.07.16.13.04.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 13:04:38 -0700 (PDT)
Date:   Thu, 16 Jul 2020 13:04:38 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>,
        Andy Lutomirski <luto@kernel.org>,
        Matthew Wilcox <willy@infradead.org>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org,
        kernel@collabora.com, gofmanp@gmail.com, linux-api@vger.kernel.org,
        x86@kernel.org, linux-kselftest@vger.kernel.org, shuah@kernel.org
Subject: Re: [PATCH v4 0/2] Syscall User Redirection
Message-ID: <202007161300.7452A2C5@keescook>
References: <20200716193141.4068476-1-krisman@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200716193141.4068476-1-krisman@collabora.com>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Jul 16, 2020 at 03:31:39PM -0400, Gabriel Krisman Bertazi wrote:
> This is v4 of Syscall User Redirection.  The implementation itself is
> not modified from v3, it only applies the latest round of reviews to the
> selftests.
> 
> __NR_syscalls is not really exported in header files other than
> asm-generic for every architecture, so it felt safer to optionally
> expose it with a fallback to a high value.
> 
> Also, I didn't expose tests for PR_GET as that is not currently
> implemented.  If possible, I'd have it supported by a future patchset,
> since it is not immediately necessary to support this feature.

Thanks! That all looks good to me.

> Finally, one question: Which tree would this go through?

I haven't heard from several other x86 maintainers yet (which is where
I would normally expect this series to land), but I would be comfortable
taking this through my seccomp tree if I got Acks/Reviews at least from
Andy and Matthew.

Andy, Matthew, what do you think of this?

-- 
Kees Cook
