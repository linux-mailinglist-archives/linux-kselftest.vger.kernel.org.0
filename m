Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4B507E6B33
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Nov 2023 14:27:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231658AbjKIN1X (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 9 Nov 2023 08:27:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230055AbjKIN1W (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 9 Nov 2023 08:27:22 -0500
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com [IPv6:2607:f8b0:4864:20::e31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3E8B30CF
        for <linux-kselftest@vger.kernel.org>; Thu,  9 Nov 2023 05:27:20 -0800 (PST)
Received: by mail-vs1-xe31.google.com with SMTP id ada2fe7eead31-45da94f4b90so377410137.3
        for <linux-kselftest@vger.kernel.org>; Thu, 09 Nov 2023 05:27:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699536440; x=1700141240; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cbopAyKk2nUSkgWtHiP/bLtiSi3hylXJFxrxhIdXSa4=;
        b=eL//GpxUzCrr7mO6OamntOqflgodX334PE2rE5vC3YUopXNG8nuEUlMjToWQo47U4+
         ECuzfzvO7WY4CZvQ/TU2ytSQB/NJ7R7OmogVi6Rkv9Dx1VagCP04Ybgmuu4vhQL5pqeY
         WcLQoeiSJm3HPuMFr8tHwiWKOuwYf0ExwhMb8+UE7vX0ix7LtFdqstZ6bWWmR9iwUbYm
         Ju4851dH5VZ9iMr3wpMvR0K9WXD83oGzCc3fKUh3kJTARM8nzw+v9Ex+cuGiHbicxLEv
         Mc4OP0l8L1CK5X5q2ugGhcBE37g+Ac8woXeaL/lAoXgViiQ9ccHYb85m5FN2TafpZPEk
         t79w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699536440; x=1700141240;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cbopAyKk2nUSkgWtHiP/bLtiSi3hylXJFxrxhIdXSa4=;
        b=r1DHZWb3uWlM/d6r3wy+lW5ONRNbr1Y9NFNIJS2T0vWet+gC5Ys+bKlUcpfgVG5ib/
         pQ2oHDWGpVYSxQh0B5UNG0C7nrOSaVGwv6Rk+4eggbDYtxTfjj9K/4Bx6Lu9eaBYOM+3
         eLdIDsYuchRDMsxMw6bdAcCxiCSjClckMDzDZP9lzrf11mEL2fKsPsk5wwEBV2ZJe1gQ
         AUJCXFTiZE8C9SkkGdkAwdMMV+Pwnh5xfhqqnYmWdgvLv/aM8ISuW5hsovYh88ChvA9t
         7O6n4kYLh3kHwXSU0gb9kDEs3ldIZpA8+6C9fzIxAixYn0QDt5OmV5epMkc3R4LWPwIq
         82NQ==
X-Gm-Message-State: AOJu0YxszA3EbUfuA8vVJLwDi1wRtuOhzz9fuvA4dE7LbzToBlinX+yx
        u7hrXqXSRMGw9Mx5mvCMStk7tGrfCb0lE/PwqqOngQ==
X-Google-Smtp-Source: AGHT+IHZv6/tHioQIWcjB+aBmS/UdtoC1McUwT/k73qnfV49+CgnR/jgai3mHG1zVSK7o4helKC44xQ1U97V1/xXSTQ=
X-Received: by 2002:a67:cc16:0:b0:45d:962e:f17b with SMTP id
 q22-20020a67cc16000000b0045d962ef17bmr4553293vsl.30.1699536439712; Thu, 09
 Nov 2023 05:27:19 -0800 (PST)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 9 Nov 2023 18:57:08 +0530
Message-ID: <CA+G9fYs-j2FYZSFSVZj48mgoM9gQd4-7M2mu2Ez3D1DqDdW2bQ@mail.gmail.com>
Subject: WARNING: CPU: 6 PID: 474 at include/linux/maple_tree.h:712
 mmap_region (include/linux/maple_tree.h:556 include/linux/maple_tree.h:731
To:     linux-mm <linux-mm@kvack.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        lkft-triage@lists.linaro.org, regressions@lists.linux.dev
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will@kernel.org>, Mark Brown <broonie@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dan Carpenter <dan.carpenter@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Following kernel panic noticed while running  selftests: exec: load_address
on Fastmodels (FVP) running Linux next-20231109.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

log:
---

# timeout set to 45
# selftests: exec: load_address_16777216
[  238.405168] ------------[ cut here ]------------
[  238.405244] WARNING: CPU: 6 PID: 474 at
include/linux/maple_tree.h:712 mmap_region
(include/linux/maple_tree.h:556 include/linux/maple_tree.h:731
include/linux/maple_tree.h:747 include/linux/mm.h:1033 mm/mmap.c:2828)
[  238.405432] Modules linked in: arm_spe_pmu crct10dif_ce
panel_simple pl111_drm drm_dma_helper drm_kms_helper fuse drm
backlight dm_mod ip_tables x_tables
[  238.405932] CPU: 6 PID: 474 Comm: load_address_16 Not tainted
6.6.0-next-20231109 #1
[  238.406070] Hardware name: FVP Base RevC (DT)
[  238.406151] pstate: 123402009 (nzCv daif +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
[  238.406294] pc : mmap_region (include/linux/maple_tree.h:556
include/linux/maple_tree.h:731 include/linux/maple_tree.h:747
include/linux/mm.h:1033 mm/mmap.c:2828)
[  238.406424] lr : mmap_region (mm/mmap.c:2836)
[  238.406554] sp : ffff8000819639b0
[  238.406629] x29: ffff8000819639c0 x28: ffff000806f79000 x27: 0000000002002000
[  238.406829] x26: ffff000806f798f0 x25: ffff000806f790b0 x24: 0000000000000006
[  238.407029] x23: 0000000000000ffc x22: ffff000805d6e100 x21: ffff0008016adf00
[  238.407229] x20: 0000000000100073 x19: 0000000001ffc000 x18: ffffffffffffffff
[  238.407425] x17: 0000000000000000 x16: ffffd7c64ceb7c10 x15: ffffffffffffffff
[  238.407627] x14: 0000000000000000 x13: 1fffe001002bc9a1 x12: ffff0008015e4d0c
[  238.407825] x11: ffff800081963a48 x10: ffff0008015e4d00 x9 : ffffd7c64b49c9f0
[  238.408028] x8 : ffff800081963778 x7 : 0000000000000000 x6 : 0000000000000000
[  238.408223] x5 : ffffd7c64e35f000 x4 : ffffd7c64e35f278 x3 : 0000000000000000
[  238.408420] x2 : ffffd7c64e92fd78 x1 : 0000000002001fff x0 : 0000000000479fff
[  238.408618] Call trace:
[  238.408681] mmap_region (include/linux/maple_tree.h:556
include/linux/maple_tree.h:731 include/linux/maple_tree.h:747
include/linux/mm.h:1033 mm/mmap.c:2828)
[  238.408812] do_mmap (arch/arm64/include/asm/mman.h:18
include/linux/mman.h:147 mm/mmap.c:1274)
[  238.408940] vm_mmap_pgoff (mm/util.c:546)
[  238.409088] vm_mmap (mm/util.c:559)
[  238.409229] elf_load (fs/binfmt_elf.c:385 fs/binfmt_elf.c:408)
[  238.409337] load_elf_binary (fs/binfmt_elf.c:1134 (discriminator 1))
[  238.409454] bprm_execve (fs/exec.c:1940)
[  238.409598] do_execveat_common.isra.0 (fs/exec.c:1938)
[  238.409757] __arm64_sys_execve (fs/exec.c:2106)
[  238.409910] invoke_syscall (arch/arm64/kernel/syscall.c:46
(discriminator 19))
[  238.410058] el0_svc_common.constprop.0 (arch/arm64/kernel/syscall.c:136)
[  238.410218] do_el0_svc (arch/arm64/kernel/syscall.c:155)
[  238.410363] el0_svc (arch/arm64/include/asm/daifflags.h:75
arch/arm64/kernel/entry-common.c:677)
[  238.410508] el0t_64_sync_handler (arch/arm64/kernel/entry-common.c:697)
[  238.410623] el0t_64_sync (arch/arm64/kernel/entry.S:595)
[  238.410735] ---[ end trace 0000000000000000 ]---


Links:
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20231109/testrun/21009598/suite/log-parser-test/test/check-kernel-exception/log
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20231109/testrun/21009598/suite/log-parser-test/tests/
 - https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/tests/2Xv9wca3SPRN4lh73fIuUxVRNHI
 - https://storage.tuxsuite.com/public/linaro/lkft/builds/2Xv9vEpjybxlDA4IvgDBm4bjzVT/

--
Linaro LKFT
https://lkft.linaro.org
