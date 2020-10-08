Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17267287CDC
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Oct 2020 22:06:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729998AbgJHUGV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 8 Oct 2020 16:06:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730022AbgJHUGV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 8 Oct 2020 16:06:21 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A74CEC0613D2
        for <linux-kselftest@vger.kernel.org>; Thu,  8 Oct 2020 13:06:20 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id g9so5245638pgh.8
        for <linux-kselftest@vger.kernel.org>; Thu, 08 Oct 2020 13:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dqDMGKDPXWEL3s+Lkoign4mpB+eJXnkZnlQvVOX0XM8=;
        b=A6iIp0QO1JadVLCV2aLMTv6djq+eW/MVZ9vR8BoFTkolbuRRaX5VAlVUWUkLa+ruzE
         ApLg4o8J8+1NCvkeajV8gbXbN7Tvh9hlUXhNoUNP+1f9UWSrCptKLodXqNJ1vFI9epbv
         Luikqx4OsLQepRsPGu4tl5gN7gfZ9ajqRn5PA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dqDMGKDPXWEL3s+Lkoign4mpB+eJXnkZnlQvVOX0XM8=;
        b=qmZMHVTw5HN4lMVvGxyPYTTUSYrLO+YTtv6S0Q+rUtrb1q6e4pyED9qfIrjUKYK5m6
         y622zRfDW8nu/CJGVssu8ysfQbVGhPJAgdWdCMngC84xDRu6j8MempIfTrSi4nG6JPxk
         L2rtfCuyenaHHOVwEHU9t1fNhM6w7laLWT/fE6ZZiMfPXlxXPoMaWq3bHt1P8DSJsnmu
         VzZArY+LQhVyv/GeMuUNFY3MtdcehzCClW3PG5BRmqd3F+eX/cVj5W19AxtxYe1pwwRZ
         dhjHtGD+aWQ5Rr9Cbk5djn/u1BCn5YNkU6kxU3UPS5rYDy6VopjfyNfEzEALM1iBtKzK
         n5gg==
X-Gm-Message-State: AOAM531pAoMPRGgIzhg31254KrArL4AOaVkjY5GEWDwIA83esZYLDdnV
        r7oVN/teoE39wNflGT6tdZO2mg==
X-Google-Smtp-Source: ABdhPJwX8e486E/dOh8H206wcTmba4Et7SJ2p+N9U28QP6b8IRdQ2zeZH4E8rhZJ+tzOC5Jr+DGXzg==
X-Received: by 2002:a62:6044:0:b029:151:1a04:895 with SMTP id u65-20020a6260440000b02901511a040895mr8874226pfb.34.1602187580280;
        Thu, 08 Oct 2020 13:06:20 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id in6sm7207281pjb.42.2020.10.08.13.06.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2020 13:06:19 -0700 (PDT)
Date:   Thu, 8 Oct 2020 13:06:18 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Tommi Rantala <tommi.t.rantala@nokia.com>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>
Subject: Re: [PATCH 04/13] selftests/harness: prettify SKIP message
 whitespace again
Message-ID: <202010081306.4365BBF7A@keescook>
References: <20201008122633.687877-1-tommi.t.rantala@nokia.com>
 <20201008122633.687877-5-tommi.t.rantala@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201008122633.687877-5-tommi.t.rantala@nokia.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Oct 08, 2020 at 03:26:24PM +0300, Tommi Rantala wrote:
> Commit 9847d24af95c ("selftests/harness: Refactor XFAIL into SKIP")
> replaced XFAIL with SKIP in the output. Add one more space to make the
> output aligned and pretty again.
> 
> Fixes: 9847d24af95c ("selftests/harness: Refactor XFAIL into SKIP")
> Signed-off-by: Tommi Rantala <tommi.t.rantala@nokia.com>

Nice catch!

Acked-by: Kees Cook <keescook@chromium.org>


-- 
Kees Cook
