Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC9F4728C3E
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Jun 2023 02:10:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237763AbjFIAKv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 8 Jun 2023 20:10:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237714AbjFIAKq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 8 Jun 2023 20:10:46 -0400
Received: from antelope.pear.relay.mailchannels.net (antelope.pear.relay.mailchannels.net [23.83.216.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20BEC30D8
        for <linux-kselftest@vger.kernel.org>; Thu,  8 Jun 2023 17:10:37 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id ED3555C1BA7
        for <linux-kselftest@vger.kernel.org>; Fri,  9 Jun 2023 00:10:33 +0000 (UTC)
Received: from pdx1-sub0-mail-a313.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 85AFB5C1CE3
        for <linux-kselftest@vger.kernel.org>; Fri,  9 Jun 2023 00:10:33 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1686269433; a=rsa-sha256;
        cv=none;
        b=MKQ0mdLfNAFfoar70iQmQ027xB0FR6+D8duFunQrFBvZmE+jc0HkOEUpMackOXCLgXnQhz
        tZ6DuqBdWcuQwJMUj9yX49L+2yFTwXuXOi1RhNJMEzcRuTjIdmJms8Ww8E4FRutWYHq38O
        GPRYTnLfGlGUwvbYItQpkdM26tGTDWsMXr0L6GP7AW8Xza5tbdYMgE3RxLAGGBcsHhSnjr
        dbvicN4VVeOD50bIrfpM9LxAKTegxj/XCu2CC8GxZEo9VUnMQ+MaIhflw8jAhjydtLpvYM
        Ttwy+l8xcMsL88fb/4GZ4N+bk8uR8AS16L01kG4z9m6RZZExU3yc15pJVO3SbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1686269433;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         dkim-signature; bh=HeNuXD0zf3NfQuJ7PUoGga0OpHJpYDBE8S37/JQICZM=;
        b=P7zWMQ5AhoP9Utp7eEO8Hn/OgoID1q+ciofrDYv7nI5QhnU7+j0J+YYxW++mp9RmQo248y
        TgTCKxZyL55tzc+p+D+C1bj9u6Pw0ZpXoq/+30YkFiDGsEwBtzMZC8A41rLgwvzvVimFtW
        R28cbk5GmH6xdO8ix2CdYcKdQUASCKWeDaPPDlbKGGfNyjiec5DRLDF6cXJhfUSFitMCJu
        c9QLK6M+n0pTa2S7oEXRIPdEDNQpwRPB8qkVibDvQYnAqzyWc5/vmnAvQxAgbYjeUsGfZJ
        QuuqGa2DWTgow9oA8lxqEus8+cJYUnn2hZ9DmbPkOKgBJZSaMfKlILPGh29GPw==
ARC-Authentication-Results: i=1;
        rspamd-6f5cfd578c-4g7jg;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=kjlx@templeofstupid.com
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MC-Relay: Good
X-MailChannels-SenderId: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MailChannels-Auth-Id: dreamhost
X-Tasty-Reign: 0b7bf9de0335ca59_1686269433811_1434311423
X-MC-Loop-Signature: 1686269433811:851685816
X-MC-Ingress-Time: 1686269433811
Received: from pdx1-sub0-mail-a313.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.116.217.228 (trex/6.8.1);
        Fri, 09 Jun 2023 00:10:33 +0000
Received: from kmjvbox (c-73-93-64-36.hsd1.ca.comcast.net [73.93.64.36])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kjlx@templeofstupid.com)
        by pdx1-sub0-mail-a313.dreamhost.com (Postfix) with ESMTPSA id 4QchLJ523qz1qB
        for <linux-kselftest@vger.kernel.org>; Thu,  8 Jun 2023 17:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=templeofstupid.com;
        s=dreamhost; t=1686269432;
        bh=HeNuXD0zf3NfQuJ7PUoGga0OpHJpYDBE8S37/JQICZM=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=QHyLeBj+nzOnd+MaABKkDQpg1ZHJv0OCvgLMf4NZplmdAtKpOV4nJ6hB/P9KHCz2K
         PGU+5d30VGlzw45Gne/QE8+EFffTX20wK+a2BWdgOfBfWxLqbz7tAdJ4ID70IdH4p5
         /1IrjBqHLWnqC6oJGg9jo+qAlzSfy5rySTyccBAU=
Received: from johansen (uid 1000)
        (envelope-from kjlx@templeofstupid.com)
        id e0042
        by kmjvbox (DragonFly Mail Agent v0.12);
        Thu, 08 Jun 2023 17:10:31 -0700
Date:   Thu, 8 Jun 2023 17:10:31 -0700
From:   Krister Johansen <kjlx@templeofstupid.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH bpf v3 0/2] bpf: fix NULL dereference during extable search
Message-ID: <cover.1686268304.git.kjlx@templeofstupid.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi,
Enclosed are a pair of patches for an oops that can occur if an exception is
generated while a bpf subprogram is running.  One of the bpf_prog_aux entries
for the subprograms are missing an extable.  This can lead to an exception that
would otherwise be handled turning into a NULL pointer bug.

When run out of the selftest, the oops looks like this:

   BUG: kernel NULL pointer dereference, address: 000000000000000c
   #PF: supervisor read access in kernel mode
   #PF: error_code(0x0000) - not-present page
   PGD 0 P4D 0
   Oops: 0000 [#1] PREEMPT SMP NOPTI
   CPU: 0 PID: 1132 Comm: test_progs Tainted: G           OE      6.4.0-rc3+ #2
   RIP: 0010:cmp_ex_search+0xb/0x30
   Code: cc cc cc cc e8 36 cb 03 00 66 0f 1f 44 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 55 48 89 e5 48 8b 07 <48> 63 0e 48 01 f1 31 d2 48 39 c8 19 d2 48 39 c8 b8 01 00 00 00 0f
   RSP: 0018:ffffb30c4291f998 EFLAGS: 00010006
   RAX: ffffffffc00b49da RBX: 0000000000000002 RCX: 000000000000000c
   RDX: 0000000000000002 RSI: 000000000000000c RDI: ffffb30c4291f9e8
   RBP: ffffb30c4291f998 R08: ffffffffab1a42d0 R09: 0000000000000001
   R10: 0000000000000000 R11: ffffffffab1a42d0 R12: ffffb30c4291f9e8
   R13: 000000000000000c R14: 000000000000000c R15: 0000000000000000
   FS:  00007fb5d9e044c0(0000) GS:ffff92e95ee00000(0000) knlGS:0000000000000000
   CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
   CR2: 000000000000000c CR3: 000000010c3a2005 CR4: 00000000007706f0
   DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
   DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
   PKRU: 55555554
   Call Trace:
    <TASK>
    bsearch+0x41/0x90
    ? __pfx_cmp_ex_search+0x10/0x10
    ? bpf_prog_45a7907e7114d0ff_handle_fexit_ret_subprogs3+0x2a/0x6c
    search_extable+0x3b/0x60
    ? bpf_prog_45a7907e7114d0ff_handle_fexit_ret_subprogs3+0x2a/0x6c
    search_bpf_extables+0x10d/0x190
    ? bpf_prog_45a7907e7114d0ff_handle_fexit_ret_subprogs3+0x2a/0x6c
    search_exception_tables+0x5d/0x70
    fixup_exception+0x3f/0x5b0
    ? look_up_lock_class+0x61/0x110
    ? __lock_acquire+0x6b8/0x3560
    ? __lock_acquire+0x6b8/0x3560
    ? __lock_acquire+0x6b8/0x3560
    kernelmode_fixup_or_oops+0x46/0x110
    __bad_area_nosemaphore+0x68/0x2b0
    ? __lock_acquire+0x6b8/0x3560
    bad_area_nosemaphore+0x16/0x20
    do_kern_addr_fault+0x81/0xa0
    exc_page_fault+0xd6/0x210
    asm_exc_page_fault+0x2b/0x30
   RIP: 0010:bpf_prog_45a7907e7114d0ff_handle_fexit_ret_subprogs3+0x2a/0x6c
   Code: f3 0f 1e fa 0f 1f 44 00 00 66 90 55 48 89 e5 f3 0f 1e fa 48 8b 7f 08 49 bb 00 00 00 00 00 80 00 00 4c 39 df 73 04 31 f6 eb 04 <48> 8b 77 00 49 bb 00 00 00 00 00 80 00 00 48 81 c7 7c 00 00 00 4c
   RSP: 0018:ffffb30c4291fcb8 EFLAGS: 00010282
   RAX: 0000000000000001 RBX: 0000000000000001 RCX: 0000000000000000
   RDX: 00000000cddf1af1 RSI: 000000005315a00d RDI: ffffffffffffffea
   RBP: ffffb30c4291fcb8 R08: ffff92e644bf38a8 R09: 0000000000000000
   R10: 0000000000000000 R11: 0000800000000000 R12: ffff92e663652690
   R13: 00000000000001c8 R14: 00000000000001c8 R15: 0000000000000003
    bpf_trampoline_251255721842_2+0x63/0x1000
    bpf_testmod_return_ptr+0x9/0xb0 [bpf_testmod]
    ? bpf_testmod_test_read+0x43/0x2d0 [bpf_testmod]
    sysfs_kf_bin_read+0x60/0x90
    kernfs_fop_read_iter+0x143/0x250
    vfs_read+0x240/0x2a0
    ksys_read+0x70/0xe0
    __x64_sys_read+0x1f/0x30
    do_syscall_64+0x68/0xa0
    ? syscall_exit_to_user_mode+0x77/0x1f0
    ? do_syscall_64+0x77/0xa0
    ? irqentry_exit+0x35/0xa0
    ? sysvec_apic_timer_interrupt+0x4d/0x90
    entry_SYSCALL_64_after_hwframe+0x72/0xdc
   RIP: 0033:0x7fb5da00a392
   Code: ac 00 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb be 0f 1f 80 00 00 00 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 0f 05 <48> 3d 00 f0 ff ff 77 56 c3 0f 1f 44 00 00 48 83 ec 28 48 89 54 24
   RSP: 002b:00007ffc5b3cab68 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
   RAX: ffffffffffffffda RBX: 000055bee7b8b100 RCX: 00007fb5da00a392
   RDX: 00000000000001c8 RSI: 0000000000000000 RDI: 0000000000000009
   RBP: 00007ffc5b3caba0 R08: 0000000000000000 R09: 0000000000000037
   R10: 000055bee7b8c2a7 R11: 0000000000000246 R12: 000055bee78f1f60
   R13: 00007ffc5b3cae90 R14: 0000000000000000 R15: 0000000000000000
    </TASK>
   Modules linked in: bpf_testmod(OE) nls_iso8859_1 dm_multipath scsi_dh_rdac scsi_dh_emc scsi_dh_alua intel_rapl_msr intel_rapl_common intel_uncore_frequency_common ppdev nfit crct10dif_pclmul crc32_pclmul psmouse ghash_clmulni_intel sha512_ssse3 aesni_intel parport_pc crypto_simd cryptd input_leds parport rapl ena i2c_piix4 mac_hid serio_raw ramoops reed_solomon pstore_blk drm pstore_zone efi_pstore autofs4 [last unloaded: bpf_testmod(OE)]
   CR2: 000000000000000c

These changes were tested via the verifier and progs selftests and no
regressions were observed.

Changes from v2:
- Insert only the main program's kallsyms (Feedback from Yonghong Song and
  Alexei Starovoitov)
- Selftest should use ASSERT instead of CHECK (Feedback from Yonghong Song)
- Selftest needs some cleanup (Feedback from Yonghong Song)
- Switch patch order (Feedback from Alexei Starovoitov)

Changes from v1:

- Add a selftest (Feedback From Alexei Starovoitov)
- Move to a 1-line verifier change instead of searching multiple extables

Krister Johansen (2):
  bpf: ensure main program has an extable
  selftests/bpf: add a test for subprogram extables

 kernel/bpf/verifier.c                         |  6 ++-
 .../bpf/prog_tests/subprogs_extable.c         | 31 +++++++++++++
 .../bpf/progs/test_subprogs_extable.c         | 46 +++++++++++++++++++
 3 files changed, 81 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/subprogs_extable.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_subprogs_extable.c

-- 
2.25.1

