Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FA3727493B
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Sep 2020 21:35:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726576AbgIVTfQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 22 Sep 2020 15:35:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbgIVTfQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 22 Sep 2020 15:35:16 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91377C061755
        for <linux-kselftest@vger.kernel.org>; Tue, 22 Sep 2020 12:35:16 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id w7so13409275pfi.4
        for <linux-kselftest@vger.kernel.org>; Tue, 22 Sep 2020 12:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Sqo10I328LeM2dGrmAMbMDjHGHNfY3AhrHLzAaG7Zcc=;
        b=SbYZH3mSnGlVgEsFBRoL6JaNbinBFwv3MKZkfeP6QtPh9H7MfyP0AJW8GxXvXyh7oS
         rB2MZP6qWoEmVuRs7JlfEwiBbgK4lZ23Vz2hvbf2mKPSWCpyTVqeghNS5302lcgAU1Ot
         3V8jL6xUcHt55VvzDvDGK3RdK/gVmXzdyxNNg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Sqo10I328LeM2dGrmAMbMDjHGHNfY3AhrHLzAaG7Zcc=;
        b=jCKsd6x/Y6nWfuGhF5KYjg+h45Hw6g2TZiIX5Ag1odY+lYoKWhJgcZnDD0+NeBwOec
         OyZqOI9BH4E4O18cR5T0tn5kMzSA9DGkpezz6/UphhwDhhWu0gbBvkuOuOwGjPjL3BTJ
         mkV/PVlsQtbnsNG4SbhMvkRJU7Qz4E6fqeUehGrGsYdjwsgnpAlzCcett5zLeIIzijRq
         6ut2+DYiGvubBByGHOusZNWzXZ8+PsRy3i5Av4ZEW9tIIBx4PZJ3KHAY3FSgKe1vuDax
         5GOcnsbwdkRWiaBVom80jKpvaouZJ4Skb6hFSc1px+1SobNt5UQs48TkS3mr0OKhL0ZX
         rQNw==
X-Gm-Message-State: AOAM531M9Ld7epHnsCpY9hyn4YhA0LxYDuWCrxN1T89+TB7aNY4AiTV9
        3hKoVQfcRgRyvXHHTT7Mm8K+aA==
X-Google-Smtp-Source: ABdhPJwJXWR+YYhKJY5dfjikhbiB5OtlnQmdHcgPbPiQaDOduurUwJgYHZOyXscbN5iibVyCq0TsTQ==
X-Received: by 2002:a65:6917:: with SMTP id s23mr4517004pgq.389.1600803316089;
        Tue, 22 Sep 2020 12:35:16 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y6sm3378542pjl.9.2020.09.22.12.35.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2020 12:35:14 -0700 (PDT)
Date:   Tue, 22 Sep 2020 12:35:13 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     luto@kernel.org, tglx@linutronix.de, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        willy@infradead.org, linux-kselftest@vger.kernel.org,
        shuah@kernel.org, kernel@collabora.com
Subject: Re: [PATCH v6 8/9] selftests: Add kselftest for syscall user dispatch
Message-ID: <202009221234.C0189A8F@keescook>
References: <20200904203147.2908430-1-krisman@collabora.com>
 <20200904203147.2908430-9-krisman@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200904203147.2908430-9-krisman@collabora.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Sep 04, 2020 at 04:31:46PM -0400, Gabriel Krisman Bertazi wrote:
> Implement functionality tests for syscall user dispatch.  In order to
> make the test portable, refrain from open coding syscall dispatchers and
> calculating glibc memory ranges.
> 
> Changes since v4:
>   - Update bad selector test to reflect change in API
> 
> Changes since v3:
>   - Sort entry in Makefile
>   - Add SPDX header
>   - Use __NR_syscalls if available
> 
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>

This passes, looks good. Thank you again for the self tests!

Acked-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
