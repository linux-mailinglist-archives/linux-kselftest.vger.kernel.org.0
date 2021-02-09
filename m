Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C1DF31494B
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Feb 2021 08:11:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230058AbhBIHL2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 9 Feb 2021 02:11:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230043AbhBIHLX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 9 Feb 2021 02:11:23 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5CBAC061786
        for <linux-kselftest@vger.kernel.org>; Mon,  8 Feb 2021 23:10:41 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id w67so10427386pfd.5
        for <linux-kselftest@vger.kernel.org>; Mon, 08 Feb 2021 23:10:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=hKso1MwLRLw8n4+Grqq4tnQrzP51F50oX7aHEUrMrFI=;
        b=Bb5HKfqMvcuXwLRKuIc/nM60N7hDs2c47YYZ6XuJx8vUW9hQmNBlsZdudbUsOmTt9W
         25NVlfcONEgRGyjPOq7wb9lgFVq5lQ8IVBO4SrLEDCAHfnFUfJLP88AmiZ6ko4xj+zv1
         J8NH5Z5F3fOuurrK6m9dEBIf0AE1jLI0esPgKg2+6ujWAFc/CIdL88E5zXEimKNtef48
         FFnGOa4H0V5cULMnyJUpzW9rKH6nwmhl/g9jIn0YoW21jojQ2Nd7M7hHvMNsUKu5nbdL
         p16B6NjKKIltD23f7gmZByI1PbrSufoLBm9z/Yt6yUeqerwNf/y1L2iPUXje+Z5DKnKr
         sn6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=hKso1MwLRLw8n4+Grqq4tnQrzP51F50oX7aHEUrMrFI=;
        b=qSwop8gQyGCpOqAiCJvZbYKlG5Zk+bc9QsNtkhKzH8b919PRTQobiiLQcHOvXf2Nju
         hvbl1rg7o5U8RfaWKccdN6zXqjDqQ2IuO8hM8sotBeCNlO/a5tyNgskVf/cSR+ERR0xx
         sjh8j4MKK2ILYURUI8mZzutvZGlIZ8KkUO3wtJxiBrg9XIBMkNVHvCvv3nHYb7qTci3u
         Q1+jFs00PitvRS7owGXGI5AZa6tvVAx5cAAlB9fU+pajZhfNXjJKiI1h4HRABdgQCD55
         QDSC7svUqXhJEEINlxisnwBtCHvWeAT5ojKdaza5FQ/S4+PFSO/HmiBiMZywa3IJCpcK
         UH1Q==
X-Gm-Message-State: AOAM533SbkT76icT3HSQkJ6wN20IR37YxUCk3WuPNQrUKtKgHFjbOIlQ
        FyJwNpWFukPZ/pty9Y6FHGXXS8c2O5Zezw==
X-Google-Smtp-Source: ABdhPJz2uyZNOUWxCh8+bTaw0WF2AyuBjDmjriJxozzN+RmdDvksIBD9JocSbE0wQEhImCMlRxv9hoQdlniMiQ==
Sender: "davidgow via sendgmr" <davidgow@spirogrip.svl.corp.google.com>
X-Received: from spirogrip.svl.corp.google.com ([2620:15c:2cb:201:e4e6:62d4:a840:252a])
 (user=davidgow job=sendgmr) by 2002:aa7:98d2:0:b029:1da:3374:4777 with SMTP
 id e18-20020aa798d20000b02901da33744777mr13937516pfm.45.1612854641040; Mon,
 08 Feb 2021 23:10:41 -0800 (PST)
Date:   Mon,  8 Feb 2021 23:10:34 -0800
Message-Id: <20210209071034.3268897-1-davidgow@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01-goog
Subject: [PATCH] kunit: tool: Disable PAGE_POISONING under --alltests
From:   David Gow <davidgow@google.com>
To:     Brendan Higgins <brendanhiggins@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Vlastimil Babka <vbabka@suse.cz>
Cc:     David Gow <davidgow@google.com>, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, linux-um@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

kunit_tool maintains a list of config options which are broken under
UML, which we exclude from an otherwise 'make ARCH=um allyesconfig'
build used to run all tests with the --alltests option.

Something in UML allyesconfig is causing segfaults when page poisining
is enabled (and is poisoning with a non-zero value). Previously, this
didn't occur, as allyesconfig enabled the CONFIG_PAGE_POISONING_ZERO
option, which worked around the problem by zeroing memory. This option
has since been removed, and memory is now poisoned with 0xAA, which
triggers segfaults in many different codepaths, preventing UML from
booting.

Note that we have to disable both CONFIG_PAGE_POISONING and
CONFIG_DEBUG_PAGEALLOC, as the latter will 'select' the former on
architectures (such as UML) which don't implement __kernel_map_pages().

Ideally, we'd fix this properly by tracking down the real root cause,
but since this is breaking KUnit's --alltests feature, it's worth
disabling there in the meantime so the kernel can boot to the point
where tests can actually run.

Fixes: f289041ed4 ("mm, page_poison: remove CONFIG_PAGE_POISONING_ZERO")
Signed-off-by: David Gow <davidgow@google.com>
---

As described above, 'make ARCH=um allyesconfig' is broken. KUnit has
been maintaining a list of configs to force-disable for this in
tools/testing/kunit/configs/broken_on_uml.config. The kernels we've
built with this have broken since CONFIG_PAGE_POISONING_ZERO was
removed, panic-ing on startup with:

<0>[    0.100000][   T11] Kernel panic - not syncing: Segfault with no mm
<4>[    0.100000][   T11] CPU: 0 PID: 11 Comm: kdevtmpfs Not tainted 5.11.0-rc7-00003-g63381dc6f5f1-dirty #4
<4>[    0.100000][   T11] Stack:
<4>[    0.100000][   T11]  677d3d40 677d3f10 0000000e 600c0bc0
<4>[    0.100000][   T11]  677d3d90 603c99be 677d3d90 62529b93
<4>[    0.100000][   T11]  603c9ac0 677d3f10 62529b00 603c98a0
<4>[    0.100000][   T11] Call Trace:
<4>[    0.100000][   T11]  [<600c0bc0>] ? set_signals+0x0/0x60
<4>[    0.100000][   T11]  [<603c99be>] lookup_mnt+0x11e/0x220
<4>[    0.100000][   T11]  [<62529b93>] ? down_write+0x93/0x180
<4>[    0.100000][   T11]  [<603c9ac0>] ? lock_mount+0x0/0x160
<4>[    0.100000][   T11]  [<62529b00>] ? down_write+0x0/0x180
<4>[    0.100000][   T11]  [<603c98a0>] ? lookup_mnt+0x0/0x220
<4>[    0.100000][   T11]  [<603c8160>] ? namespace_unlock+0x0/0x1a0
<4>[    0.100000][   T11]  [<603c9b25>] lock_mount+0x65/0x160
<4>[    0.100000][   T11]  [<6012f360>] ? up_write+0x0/0x40
<4>[    0.100000][   T11]  [<603cbbd2>] do_new_mount_fc+0xd2/0x220
<4>[    0.100000][   T11]  [<603eb560>] ? vfs_parse_fs_string+0x0/0xa0
<4>[    0.100000][   T11]  [<603cbf04>] do_new_mount+0x1e4/0x260
<4>[    0.100000][   T11]  [<603ccae9>] path_mount+0x1c9/0x6e0
<4>[    0.100000][   T11]  [<603a9f4f>] ? getname_kernel+0xaf/0x1a0
<4>[    0.100000][   T11]  [<603ab280>] ? kern_path+0x0/0x60
<4>[    0.100000][   T11]  [<600238ee>] 0x600238ee
<4>[    0.100000][   T11]  [<62523baa>] devtmpfsd+0x52/0xb8
<4>[    0.100000][   T11]  [<62523b58>] ? devtmpfsd+0x0/0xb8
<4>[    0.100000][   T11]  [<600fffd8>] kthread+0x1d8/0x200
<4>[    0.100000][   T11]  [<600a4ea6>] new_thread_handler+0x86/0xc0

Disabling PAGE_POISONING fixes this. The issue can't be repoduced with
just PAGE_POISONING, there's clearly something (or several things) also
enabled by allyesconfig which contribute. Ideally, we'd track these down
and fix this at its root cause, but in the meantime it'd be nice to
disable PAGE_POISONING so we can at least get the kernel to boot. One
way would be to add a 'depends on !UML' or similar, but since
PAGE_POISONING does seem to work in the non-allyesconfig case, adding it
to our list of broken configs seemed the better choice.

Thoughts?

(Note that to reproduce this, you'll want to run
./tools/testing/kunit/kunit.py run --alltests --raw_output
It also depends on a couple of other fixes which are not upstream yet:
https://www.spinics.net/lists/linux-rtc/msg08294.html
https://lore.kernel.org/linux-i3c/20210127040636.1535722-1-davidgow@google.com/

Cheers,
-- David

 tools/testing/kunit/configs/broken_on_uml.config | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/kunit/configs/broken_on_uml.config b/tools/testing/kunit/configs/broken_on_uml.config
index a7f0603d33f6..690870043ac0 100644
--- a/tools/testing/kunit/configs/broken_on_uml.config
+++ b/tools/testing/kunit/configs/broken_on_uml.config
@@ -40,3 +40,5 @@
 # CONFIG_RESET_BRCMSTB_RESCAL is not set
 # CONFIG_RESET_INTEL_GW is not set
 # CONFIG_ADI_AXI_ADC is not set
+# CONFIG_DEBUG_PAGEALLOC is not set
+# CONFIG_PAGE_POISONING is not set
-- 
2.30.0.478.g8a0d178c01-goog

