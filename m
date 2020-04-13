Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BED291A659A
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Apr 2020 13:29:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728898AbgDML3m (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 13 Apr 2020 07:29:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727792AbgDML3m (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 13 Apr 2020 07:29:42 -0400
X-Greylist: delayed 482 seconds by postgrey-1.27 at vger.kernel.org; Mon, 13 Apr 2020 07:29:42 EDT
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EB84C0A3BDC
        for <linux-kselftest@vger.kernel.org>; Mon, 13 Apr 2020 04:21:39 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id r24so8345498ljd.4
        for <linux-kselftest@vger.kernel.org>; Mon, 13 Apr 2020 04:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TfybxCS9KvV17UPheJnqSM+e/cLRrV8TeDHR7AgRiYw=;
        b=y88rwGl/RjfrMbIPOK7+s+NQx1aoXwZDd8G3Aln6CMeD6UrIUasDet6IZZcqT9dOg3
         l4Nv3vQFImsFKN8Wer2g6roOIKKoWwGPTIPRR2BDmBgiuGNzPbldm5GlyKxYeioexKSM
         oGygbWZZ+ma2QaheiQrXtpCSqLrG1Ue+y1CEC5+cpb5b2ujPN3zfjQNxtDr5KIgCSYPo
         +Rj0dQk0vBVucBeDXA94ZYtSYVmc7M6iasr8XMAVU7DJ08AjFPmtZGSbwo7oeH4C6MtN
         W/eUnnA5mlK8b3G1nJCBEJp7l89bzD+tCMbv/jN17QQ5fXLGWtDv4POsulXDupmsSIlP
         SEqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TfybxCS9KvV17UPheJnqSM+e/cLRrV8TeDHR7AgRiYw=;
        b=nsiuC0mKLakCFSo1TKtjVk3WWHPdMfg/QQUDVi33XDYYBl2MyXS1qre2CvQ10JfrBn
         ww0AVloE2DzxaiiYLblOslxtuWI1LmzEcHVSNMISufsDAELA38+fVz0WK+Q/raM1UOUK
         UREpReiXfoJyJXZexhn3JYLYqkD0rvpLU/BwJTtBEAMoP3w++B4tFU1LG23z/D5IRBgY
         O9TmwK81I8awB2hHHeIkZOZHN7vQd8T33K49KfjFAccrmVwTSfnBfBrjvC1OeT04w6I0
         epNR5fsBvp70a37g2GgzkpAIYE9/Z8kQDl8R6VmTFbggPRnoM0/1lLcIM8/quIo8airN
         HGjA==
X-Gm-Message-State: AGi0PubgbS+aN5pm06STvGMRu/RRBPVCWhmmunIUOnquRMBZI8kskRB6
        ZdSltWFVemUVBCdV6x2JCuSuzpHlkXfXXTpUTA17Ug==
X-Google-Smtp-Source: APiQypKZxajlMe0BodxfJkVJg9NJCcYeXNTqOwy0OQAXKiMOpmeX9tR3Jo8ny+juQeVyUWeXVPsZc/KvhmVF+uDhGws=
X-Received: by 2002:a2e:a495:: with SMTP id h21mr10092859lji.123.1586776897822;
 Mon, 13 Apr 2020 04:21:37 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYsRGvkqtpdGv_aVr+Hn17KgYq04Q=EE=pB774qVxRqOeg@mail.gmail.com>
 <20200412214150.GB38470@xz-x1>
In-Reply-To: <20200412214150.GB38470@xz-x1>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Mon, 13 Apr 2020 16:51:25 +0530
Message-ID: <CA+G9fYvARTCKjbfHYEbfOjtn_s7desuAToOF4g+Z_fztzZ-myw@mail.gmail.com>
Subject: Re: i386: selftests: vm: compaction_test: BUG: kernel NULL pointer
 dereference, address: 00000000
To:     Peter Xu <peterx@redhat.com>
Cc:     open list <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
        lkft-triage@lists.linaro.org, Shuah Khan <shuah@kernel.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Andrew Morton <akpm@linux-foundation.org>,
        Leonardo Bras <leonardo@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Jules Irenge <jbi.octave@gmail.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
        Rik van Riel <riel@surriel.com>,
        Hugh Dickins <hughd@google.com>,
        Minchan Kim <minchan@kernel.org>, Mel Gorman <mgorman@suse.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Mateusz Nosek <mateusznosek0@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Kees Cook <keescook@chromium.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Hillf Danton <hdanton@sina.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, 13 Apr 2020 at 03:12, Peter Xu <peterx@redhat.com> wrote:
> And since this one is very easy to reproduce, I finally noticed that
> we have wrongly enabled uffd-wp on x86_32, which is definely not going
> to work... Because we'll use bit 2 of swap entry assuming that's the
> uffd-wp bit, while that's part of swp offset on 32bit systems.
>
> Naresh, could you try whether below change fixes the issue for you?
>
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 8d078642b4be..7ac524d1316e 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -149,7 +149,7 @@ config X86
>         select HAVE_ARCH_TRACEHOOK
>         select HAVE_ARCH_TRANSPARENT_HUGEPAGE
>         select HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD if X86_64
> -       select HAVE_ARCH_USERFAULTFD_WP         if USERFAULTFD
> +       select HAVE_ARCH_USERFAULTFD_WP         if X86_64 && USERFAULTFD
>         select HAVE_ARCH_VMAP_STACK             if X86_64
>         select HAVE_ARCH_WITHIN_STACK_FRAMES
>         select HAVE_ASM_MODVERSIONS
>

Tested-by: Naresh Kamboju <naresh.kamboju@linaro.org>

The above patch tested and did not notice the crash.
+ cd /opt/kselftests/default-in-kernel/vm/
+ ./compaction_test
No of huge pages allocated = 297
+ ./compaction_test
[   46.059785] kauditd_printk_skb: 15 callbacks suppressed
[   46.059786] audit: type=1334 audit(1586776582.927:25): prog-id=17 op=UNLOAD
[   46.071997] audit: type=1334 audit(1586776582.927:26): prog-id=16 op=UNLOAD
No of huge pages allocated = 160

Full test log,
https://lkft.validation.linaro.org/scheduler/job/1362495#L1308

Build artifacts.
https://builds.tuxbuild.com/w0ol7cCsGan0wzPp7bNqkg/

- Naresh
