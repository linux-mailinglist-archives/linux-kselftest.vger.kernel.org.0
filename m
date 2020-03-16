Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A7A8B18740D
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Mar 2020 21:30:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732548AbgCPUaf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 16 Mar 2020 16:30:35 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:43219 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732516AbgCPUaf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 16 Mar 2020 16:30:35 -0400
Received: by mail-pl1-f195.google.com with SMTP id f8so8518891plt.10
        for <linux-kselftest@vger.kernel.org>; Mon, 16 Mar 2020 13:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yu64KSO2j/IShyNkzlE1/rhNk4ckOFCAT1HOnClY8mw=;
        b=FXLiYLt6cHEbL1uT9QrMgvWyLBlMnb2tg9L8BeiuFntcKb7AKNDkGn1kFgPkKdscaA
         Xs9WVDvhTJtPw7JK3exyVFTQFORHIoC6mchYTjD+FBgsXWlC0xCQBigte/OjQKHuSMau
         BASNEcz7DY+9N+wiXzX6gaFCMjkYkaCcGnila9vM/9kVFG1x5ai844TnCIC9MBHU4b8F
         LDkWVaPGsRqHIgSzVTpeQqCm5H23TxFPvd4AeflGYFyqhnug0FgLxOs7/har+TbIWlu9
         GuOVSZlRHIXWmSPABHfyoYVqoyLfFE7Lwky9VMQPRzNLSYLjF9OqMOvRtoFXUUeMsoiQ
         rOPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yu64KSO2j/IShyNkzlE1/rhNk4ckOFCAT1HOnClY8mw=;
        b=DYJpiSZjDkjMCSoQKRVhjgUDUB3MnUrNaJHC0fLlQDn+X1iv2E8pwBNDqWj+MW3+36
         Kgk8eJx/oDxW6ndtF8i5PCWhNIY2EashhPVWGuPxWyUmxqYdQd/0WStFPrtFNzGUp1uX
         MtGssup1eiMi52sxykGml/XvAWKMxb/LdnTLG0IilbwPT8SiUhWcz6hJ7N4YRERCpYMc
         ThAh6z/7mfIUu/JVZoqV2MX+m1xkGJMSJO0Lejfax5bYhte6Gd9VEpmG9m1PenAUUQzX
         i7gy5O7o1IyVoNe7NnwvBZRxGmr6FzDJ2q8DGlVFOwyMZviq6YveCKHwgHEOMKQwWufX
         qNvg==
X-Gm-Message-State: ANhLgQ0ODF+e864gy/3IapHWBHcsx8ZBfdY3aBB5tGVPBDaIXfV9M63n
        gsOAtvsVTyVInR9/wWyRcUknzTCYU9lMkBNYZY+FvQ==
X-Google-Smtp-Source: ADFU+vsYzCffmQb/XCUQsISGT10ec0VfDjJAnTWXelfrf3RRvEi77GLXlwNTpMwq7rbWg2B5+1nh8eA/KcYjp7OW9V0=
X-Received: by 2002:a17:90a:a616:: with SMTP id c22mr1393948pjq.47.1584390632130;
 Mon, 16 Mar 2020 13:30:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200316202125.15852-1-heidifahim@google.com>
In-Reply-To: <20200316202125.15852-1-heidifahim@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Mon, 16 Mar 2020 13:30:21 -0700
Message-ID: <CAFd5g46CRzqp6r0DtMCzjjf3PYkkyJvt=tWznrW=ZNxT0FMP3A@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] kunit: kunit_parser: make parser more robust
To:     Heidi Fahim <heidifahim@google.com>
Cc:     shuah <shuah@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Mar 16, 2020 at 1:21 PM Heidi Fahim <heidifahim@google.com> wrote:
>
> Previously, kunit_parser did not properly handle kunit TAP output that
> - had any prefixes (generated from different configs e.g.
> CONFIG_PRINTK_TIME)
> - had unrelated kernel output mixed in the middle of
> it, which has shown up when testing with allyesconfig
> To remove prefixes, the parser looks for the first line that includes
> TAP output, "TAP version 14".  It then determines the length of the
> string before this sequence, and strips that number of characters off
> the beginning of the following lines until the last KUnit output line is
> reached.
> These fixes have been tested with additional tests in the
> KUnitParseTest and their associated logs have also been added.
>
> Signed-off-by: Heidi Fahim <heidifahim@google.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
