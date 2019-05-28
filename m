Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ACACA2C74F
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 May 2019 15:05:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727054AbfE1NF2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 28 May 2019 09:05:28 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:57252 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726620AbfE1NF1 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 28 May 2019 09:05:27 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D01EC80D;
        Tue, 28 May 2019 06:05:26 -0700 (PDT)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 479923F5AF;
        Tue, 28 May 2019 06:05:21 -0700 (PDT)
Date:   Tue, 28 May 2019 14:05:18 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-rdma@vger.kernel.org,
        linux-media@vger.kernel.org, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        Yishai Hadas <yishaih@mellanox.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Alexander Deucher <Alexander.Deucher@amd.com>,
        Christian Koenig <Christian.Koenig@amd.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Leon Romanovsky <leon@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Evgeniy Stepanov <eugenis@google.com>,
        Lee Smith <Lee.Smith@arm.com>,
        Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
        Jacob Bramley <Jacob.Bramley@arm.com>,
        Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Szabolcs Nagy <Szabolcs.Nagy@arm.com>
Subject: Re: [PATCH v15 05/17] arms64: untag user pointers passed to memory
 syscalls
Message-ID: <20190528130518.GB32006@arrakis.emea.arm.com>
References: <cover.1557160186.git.andreyknvl@google.com>
 <00eb4c63fefc054e2c8d626e8fedfca11d7c2600.1557160186.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00eb4c63fefc054e2c8d626e8fedfca11d7c2600.1557160186.git.andreyknvl@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, May 06, 2019 at 06:30:51PM +0200, Andrey Konovalov wrote:
>  /*
>   * Wrappers to pass the pt_regs argument.
>   */
>  #define sys_personality		sys_arm64_personality
> +#define sys_mmap_pgoff		sys_arm64_mmap_pgoff
> +#define sys_mremap		sys_arm64_mremap
> +#define sys_munmap		sys_arm64_munmap
> +#define sys_brk			sys_arm64_brk
> +#define sys_get_mempolicy	sys_arm64_get_mempolicy
> +#define sys_madvise		sys_arm64_madvise
> +#define sys_mbind		sys_arm64_mbind
> +#define sys_mlock		sys_arm64_mlock
> +#define sys_mlock2		sys_arm64_mlock2
> +#define sys_munlock		sys_arm64_munlock
> +#define sys_mprotect		sys_arm64_mprotect
> +#define sys_msync		sys_arm64_msync
> +#define sys_mincore		sys_arm64_mincore
> +#define sys_remap_file_pages	sys_arm64_remap_file_pages
> +#define sys_shmat		sys_arm64_shmat
> +#define sys_shmdt		sys_arm64_shmdt

This hunk should be (I sent a separate patch for sys_personality):

@@ -160,23 +163,23 @@ SYSCALL_DEFINE1(arm64_shmdt, char __user *, shmaddr)
 /*
  * Wrappers to pass the pt_regs argument.
  */
-#define sys_personality		sys_arm64_personality
-#define sys_mmap_pgoff		sys_arm64_mmap_pgoff
-#define sys_mremap		sys_arm64_mremap
-#define sys_munmap		sys_arm64_munmap
-#define sys_brk			sys_arm64_brk
-#define sys_get_mempolicy	sys_arm64_get_mempolicy
-#define sys_madvise		sys_arm64_madvise
-#define sys_mbind		sys_arm64_mbind
-#define sys_mlock		sys_arm64_mlock
-#define sys_mlock2		sys_arm64_mlock2
-#define sys_munlock		sys_arm64_munlock
-#define sys_mprotect		sys_arm64_mprotect
-#define sys_msync		sys_arm64_msync
-#define sys_mincore		sys_arm64_mincore
-#define sys_remap_file_pages	sys_arm64_remap_file_pages
-#define sys_shmat		sys_arm64_shmat
-#define sys_shmdt		sys_arm64_shmdt
+#define __arm64_sys_personality		__arm64_sys_arm64_personality
+#define __arm64_sys_mmap_pgoff		__arm64_sys_arm64_mmap_pgoff
+#define __arm64_sys_mremap		__arm64_sys_arm64_mremap
+#define __arm64_sys_munmap		__arm64_sys_arm64_munmap
+#define __arm64_sys_brk			__arm64_sys_arm64_brk
+#define __arm64_sys_get_mempolicy	__arm64_sys_arm64_get_mempolicy
+#define __arm64_sys_madvise		__arm64_sys_arm64_madvise
+#define __arm64_sys_mbind		__arm64_sys_arm64_mbind
+#define __arm64_sys_mlock		__arm64_sys_arm64_mlock
+#define __arm64_sys_mlock2		__arm64_sys_arm64_mlock2
+#define __arm64_sys_munlock		__arm64_sys_arm64_munlock
+#define __arm64_sys_mprotect		__arm64_sys_arm64_mprotect
+#define __arm64_sys_msync		__arm64_sys_arm64_msync
+#define __arm64_sys_mincore		__arm64_sys_arm64_mincore
+#define __arm64_sys_remap_file_pages	__arm64_sys_arm64_remap_file_pages
+#define __arm64_sys_shmat		__arm64_sys_arm64_shmat
+#define __arm64_sys_shmdt		__arm64_sys_arm64_shmdt
 
 asmlinkage long sys_ni_syscall(const struct pt_regs *);
 #define __arm64_sys_ni_syscall	sys_ni_syscall

-- 
Catalin
