Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (unknown [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7BBB1A60C0
	for <lists+linux-kselftest@lfdr.de>; Sun, 12 Apr 2020 23:42:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728344AbgDLVmA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 12 Apr 2020 17:42:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.18]:50300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727363AbgDLVmA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 12 Apr 2020 17:42:00 -0400
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-2.mimecast.com [205.139.110.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40FA7C0A3BF5
        for <linux-kselftest@vger.kernel.org>; Sun, 12 Apr 2020 14:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586727719;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cZgZS3VL9u0IfZZxKaJedf/PTKndLbqxtt6EqiRUq98=;
        b=Csj+WSbQRiNSZFMZYrdYh08sUHrUTjaS8W8HqaiwJDSyhhWoW1vRpG2f2sH67tj1X1NtTz
        Pdt+vADwGxXtNe7+q4kub2Qv3mBZ/WVvwxwCYpOHcglgcr1FeM1F1i/oDegy0palWluEsL
        bzVU+RBhsie/hGocB+/24XxluJ+bU08=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-316-C_W_-vKMPTaTgAbori2cpw-1; Sun, 12 Apr 2020 17:41:55 -0400
X-MC-Unique: C_W_-vKMPTaTgAbori2cpw-1
Received: by mail-qt1-f199.google.com with SMTP id z8so7363911qtu.17
        for <linux-kselftest@vger.kernel.org>; Sun, 12 Apr 2020 14:41:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cZgZS3VL9u0IfZZxKaJedf/PTKndLbqxtt6EqiRUq98=;
        b=JvyKuZ+2yD1YL7VtKU+DkiydIgMAT9W+k+US+iO6HRORuI/t0ccteCCv0i12PeEEBi
         1xsw1YW9s73MYm8NVuTVWQAaBcYq/CbDwna8iQyO5FNaJEwoADuIuZvtSQjpI31/FJFr
         730x1YZR9ZyH9XFC6MEWP8DvtpLknep6zu+Qu5tsWV+mYHZUNys66KP7mzh8N7rZs1gT
         ra6yTMzjy2B3aG6dkCNO5QK5pWh7bxdnidVyiZr7lkkvGGD881go9Lrgul2BaeDeV/fj
         UeeYNp79mgze0/5fLN0G4q9pF8ZYI1c9IgHCYXPkF0VkC3rHCYJfFjwKjrDTg4ml/uGN
         ZIKA==
X-Gm-Message-State: AGi0PuZ06b6pT2xWWQqlMvGm7bi1yhlen3fumKOaYoIjrBI52wlWHBNr
        cBkSVn2IXu8u/G4sTRw1U7wya0EHUgrd+w3tgJAKxlIX764GOj0djBFisaRqFmItVIdYFDIZn/q
        CEEVSO5QjoKjsSRf4PHh2guntlh5N
X-Received: by 2002:ac8:7408:: with SMTP id p8mr8849265qtq.82.1586727714587;
        Sun, 12 Apr 2020 14:41:54 -0700 (PDT)
X-Google-Smtp-Source: APiQypLYhh5/2KJDBWWaSqKpz9rNtf6twGnt8bcq4F1iR6WS2PijfIjU2a+iOx4m4OwZ4jGuWFBpvg==
X-Received: by 2002:ac8:7408:: with SMTP id p8mr8849243qtq.82.1586727714223;
        Sun, 12 Apr 2020 14:41:54 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id j92sm1505197qtd.58.2020.04.12.14.41.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Apr 2020 14:41:53 -0700 (PDT)
Date:   Sun, 12 Apr 2020 17:41:50 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
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
Subject: Re: i386: selftests: vm: compaction_test: BUG: kernel NULL pointer
 dereference, address: 00000000
Message-ID: <20200412214150.GB38470@xz-x1>
References: <CA+G9fYsRGvkqtpdGv_aVr+Hn17KgYq04Q=EE=pB774qVxRqOeg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+G9fYsRGvkqtpdGv_aVr+Hn17KgYq04Q=EE=pB774qVxRqOeg@mail.gmail.com>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi, Naresh,

On Sun, Apr 12, 2020 at 12:24:57PM +0530, Naresh Kamboju wrote:
> On Linux mainline kernel 5.6.0 running kselftest vm compaction_test on i386
>  kernel running on x86_64 devices we have noticed this Kernel BUG followed by
> Kernel panic.
> 
> BUG: kernel NULL pointer dereference, address: 00000000
> Kernel panic - not syncing: Attempted to kill init! exitcode=0x00000009
> 
> Steps to reproduce:
> --------------------------
> # cd /opt/kselftests/default-in-kernel/vm/
> # ./compaction_test
> 
> [   45.955706] kauditd_printk_skb: 15 callbacks suppressed
> [   45.955707] audit: type=1334 audit(1586671685.974:25): prog-id=13 op=UNLOAD
> [   45.968082] audit: type=1334 audit(1586671685.974:26): prog-id=12 op=UNLOAD
> [   46.008163] get_swap_device: Bad swap file entry 7007504a
> [   46.013647] BUG: kernel NULL pointer dereference, address: 00000000

I suspect this is the same issue with:

https://lore.kernel.org/lkml/20200410002518.GG8179@shao2-debian/

And since this one is very easy to reproduce, I finally noticed that
we have wrongly enabled uffd-wp on x86_32, which is definely not going
to work... Because we'll use bit 2 of swap entry assuming that's the
uffd-wp bit, while that's part of swp offset on 32bit systems.

Naresh, could you try whether below change fixes the issue for you?

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 8d078642b4be..7ac524d1316e 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -149,7 +149,7 @@ config X86
        select HAVE_ARCH_TRACEHOOK
        select HAVE_ARCH_TRANSPARENT_HUGEPAGE
        select HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD if X86_64
-       select HAVE_ARCH_USERFAULTFD_WP         if USERFAULTFD
+       select HAVE_ARCH_USERFAULTFD_WP         if X86_64 && USERFAULTFD
        select HAVE_ARCH_VMAP_STACK             if X86_64
        select HAVE_ARCH_WITHIN_STACK_FRAMES
        select HAVE_ASM_MODVERSIONS

Thanks,

-- 
Peter Xu

