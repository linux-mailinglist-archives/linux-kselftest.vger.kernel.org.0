Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB04B23CD7C
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Aug 2020 19:34:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728908AbgHEReW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 5 Aug 2020 13:34:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728462AbgHERdC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 5 Aug 2020 13:33:02 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43ADBC061575
        for <linux-kselftest@vger.kernel.org>; Wed,  5 Aug 2020 10:32:46 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id x24so7369469lfe.11
        for <linux-kselftest@vger.kernel.org>; Wed, 05 Aug 2020 10:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0O/A2cezVuB/QMtGDV0w8M/cQpgej4IbeFVmCUBKN34=;
        b=g2z0q3DehVGOj6+EVJm4x/hwlkqyBJ+6sjjEolBgDgmrVojA82SWGyPYplXGk6nZz4
         tBDDsgA5D3E9t07YwgHjqIhce2JrBaqR24SLIZ9H7iaBBCDQfXGPdagobUmPf8h2MrgL
         A7vpzsGgHrnqUu6WLBssX3eI8MTOw2kBAKj0I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0O/A2cezVuB/QMtGDV0w8M/cQpgej4IbeFVmCUBKN34=;
        b=Ai3sYDHAOJRw5XrinPmB8FUV8uPOUiIzRcaCxr5V1bUPCgvKBLW3E3K3tg/xaZpysZ
         4txrMXTykRza2ZrUrPbJmDUOxjE2BL7Fjokdd2w7hmYVnBjXvgIdVktRgAWq/1T3/w8Y
         l3afFBZNoFZA6mHn5y/S8YycPnoYVMFJQhQC39eGN3PLREMXyDSKegIx2O4XJ0DTOlcn
         IziEZD3XhQBWHxxVBEdoxqEkI9OfK5CmnPVJ2qCDbKd6wYwFV/0put6wbckGnmv9OloW
         EmqA3k05OPP4fMhtrFZoYZklXIOXAfvMHNZIJrCpfB4MyFRmDAdKmLgOswnPlf6G/VsL
         u9lQ==
X-Gm-Message-State: AOAM533DbI3xv0NuLc37xOEVYuX2AohqrV4NyrztgxnyJYh30Bq0m5zT
        F2Jxw6lBzdk0U4sd1NF0Zftj8U056SI=
X-Google-Smtp-Source: ABdhPJxDGt4mkAlbiaufpY2OD2D1BrRC+KGCKa/X1DV3KODFTE+TU66AMjoLUiEWfodvpj3BnqN+0Q==
X-Received: by 2002:a19:bcc:: with SMTP id 195mr2070076lfl.160.1596648764117;
        Wed, 05 Aug 2020 10:32:44 -0700 (PDT)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id k23sm1152791ljk.37.2020.08.05.10.32.42
        for <linux-kselftest@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Aug 2020 10:32:42 -0700 (PDT)
Received: by mail-lj1-f174.google.com with SMTP id t23so25116326ljc.3
        for <linux-kselftest@vger.kernel.org>; Wed, 05 Aug 2020 10:32:42 -0700 (PDT)
X-Received: by 2002:a2e:545:: with SMTP id 66mr2031802ljf.285.1596648762224;
 Wed, 05 Aug 2020 10:32:42 -0700 (PDT)
MIME-Version: 1.0
References: <0e3a9c1f-7ac6-33e2-ed11-5a56659fc5f7@linuxfoundation.org>
 <CAHk-=wi4iDwuazgXQ-1yvM_JMTBepi9rc-zfSMeyjfDgSS2fgA@mail.gmail.com> <8d894cb3-83ac-66bc-48ec-dc273d1afcbe@linuxfoundation.org>
In-Reply-To: <8d894cb3-83ac-66bc-48ec-dc273d1afcbe@linuxfoundation.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 5 Aug 2020 10:32:25 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiKe_rBFthfttj1fM3cwqaArSUN0Dz1KhARdMNo1a2F=A@mail.gmail.com>
Message-ID: <CAHk-=wiKe_rBFthfttj1fM3cwqaArSUN0Dz1KhARdMNo1a2F=A@mail.gmail.com>
Subject: Re: [GIT PULL] Kselftest update for Linux 5.9-rc1
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Aug 5, 2020 at 7:13 AM Shuah Khan <skhan@linuxfoundation.org> wrote:
>
> Please pull the following Kselftest update for Linux 5.9-rc1.

Ok, it worked fine this time, although now you lost the note about the
conflict ;)

I took the version from the seccomp tree that seemed to be the
slightly cleaned-up one.

            Linus
