Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D95051F9F5D
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Jun 2020 20:29:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729847AbgFOS3e (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 15 Jun 2020 14:29:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729354AbgFOS3d (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 15 Jun 2020 14:29:33 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EFFEC061A0E
        for <linux-kselftest@vger.kernel.org>; Mon, 15 Jun 2020 11:29:33 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id d6so212064pjs.3
        for <linux-kselftest@vger.kernel.org>; Mon, 15 Jun 2020 11:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8FxwWC3iZKm61HO0ehpnuZNaVe2atP/tzaiSp825MH8=;
        b=mhfsJSyub63yQFDdiSpQaUyhWYLbxVBUWABBm02mXQJ7zDNigJQ4IJiFEjyS+E1KHm
         9yjZUulkhQsNP2YXS42iM/yClo7fWfhSw5aunJ6Bz1ndLWVwcTu14zPCrnZ9+PV933zc
         j5ZOEayQ7M9yKbVmVlPGWDDSwQFi6kvIihSaQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8FxwWC3iZKm61HO0ehpnuZNaVe2atP/tzaiSp825MH8=;
        b=Jxd9IHwu1+xnyUxDxKcmXOXJK+4eiNQU9718+G5fAA7tj2CiyLc/oNaHrUcmM4QZCN
         UxUdE/599AAYIl8JLh2Ao8Jp58sEicJuQOl3dRAwWxtWjWAjea92jB5mkV7Pnytqo/Ln
         xUqjJOoLtvGs0OpW1nVMfjbBS+dS2Gu5qbOmquI3zD/tmjMO0SAD6HateyQvRZ0ODv1e
         6Amxja5YPKcpvi7fPNx4Pqrav8WjaJJua5NSOUiqmw3kvfwCEwKs56stdU4T7i7bfLic
         VEs9aQnkXaYRqLyRF8Pg36GENkzFMmi5CHvtKduCpHnAkv+pW2z8F7n3bFAbB2zIJkhW
         LRew==
X-Gm-Message-State: AOAM531OQv5y85HoKg4IjCROhNFjf3YcgCvPmLNiNcm9C0Ih/DKTzUkk
        0Vw7p1+HxpM29xSaOxxAw3LRxA==
X-Google-Smtp-Source: ABdhPJx6DdfnZeNyP52AMFA6vKzVWDSvQlYbLyIEFbXZ6IY1BEvC81J95AMbtMbXCi/hz40LBBfvAA==
X-Received: by 2002:a17:90a:2222:: with SMTP id c31mr578149pje.200.1592245773166;
        Mon, 15 Jun 2020 11:29:33 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id ev20sm214003pjb.8.2020.06.15.11.29.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 11:29:31 -0700 (PDT)
Date:   Mon, 15 Jun 2020 11:29:30 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] selftests/exec: Add binfmt_script regression test
Message-ID: <202006151128.EFFD6A6@keescook>
References: <202005200204.D07DF079@keescook>
 <159223571468.30953.4003723352312620963.git-patchwork-notify@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <159223571468.30953.4003723352312620963.git-patchwork-notify@kernel.org>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Jun 15, 2020 at 03:41:54PM +0000, patchwork-bot+linux-kselftest@kernel.org wrote:
> Hello:
> 
> This patch was applied to shuah/linux-kselftest.git (refs/heads/next).

Hi! Thanks for snagging this, however, see below...

> 
> On Wed, 20 May 2020 02:05:56 -0700 you wrote:
> > While working on commit b5372fe5dc84 ("exec: load_script: Do not exec
> > truncated interpreter path"), I wrote a series of test scripts to verify
> > corner cases. However, soon after, commit 6eb3c3d0a52d ("exec: increase
> > BINPRM_BUF_SIZE to 256") landed, resulting in the tests needing to be
> > refactored for the larger BINPRM_BUF_SIZE, which got lost on my TODO
> > list. During the recent exec refactoring work[1], the need for these tests
> > resurfaced, so I've finished them up for addition to the kernel selftests.
> > 
> > [...]
> 
> 
> Here is a summary with links:
>   - selftests/exec: Add binfmt_script regression test
>     https://git.kernel.org/shuah/linux-kselftest/c/b081320f0693cce0394f7c8bad9fba0b25982186
> 
> You are awesome, thank you!

This was already picked up by Eric for this execve series, and has
already landed in Linus's tree as b081320f0693cce0394f7c8bad9fba0b25982186

-- 
Kees Cook
