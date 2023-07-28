Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19C86766AE2
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Jul 2023 12:40:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235090AbjG1KkS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 28 Jul 2023 06:40:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236033AbjG1KkD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 28 Jul 2023 06:40:03 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82FA744B0;
        Fri, 28 Jul 2023 03:38:12 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1bbd2761f1bso15495975ad.2;
        Fri, 28 Jul 2023 03:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690540692; x=1691145492;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hjdkmAB6b44rcAISRtqp3WiFnsO1zZS32bCrIGKi8kI=;
        b=sLutBpgqb13P2OpL8NpxevoNZm7/vZglywJ50TImuLPW0CHCK/qYvNjStvfzWqQlYM
         ZH4Z7MhWUIktdBee01sc77PFDV05vYrsc4Yoqdh8QMuWCxXGfKSq+ceTMwvaIo4qBRP0
         qgDy4zFU9WS0v4YKo2QmlMZlQ817ugFBY9OiDW+jJSafzq+bKAu6VLfSh/6AMELTM/Yq
         TrpjtH/lhfpuvCkFS4R2ZVtvGxyzDWZdcLkuhEvSc0R+CR3IRSBLR6phvDXO4DMgj7It
         FdgACdWZOORd6dE1ar+VFZkr618dECiySx0qFQAZZD1bIRF5alxm5M+x5CqCkJ2jaoFk
         lvCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690540692; x=1691145492;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hjdkmAB6b44rcAISRtqp3WiFnsO1zZS32bCrIGKi8kI=;
        b=FEW/41ulpMHSOQGaEvw5JqmJ9frHhnAsSrYvg+/89ubVdRzfC3o5UsiPdB64RbwDH0
         bIxIAscL4B+9888pwvSrBwEJ5AyTenz1f97Xtz9xliQH4ZkE6Xl7CAcXZlM9giJXrE9s
         aAbV0oqFERBdTMDvDCSKK8GLn+iCPzCRE+G2mvCkK2/GojHD92C/WVJglxXQhVUQEiDq
         urjBdP4eyk4MiXwQkoHHABZbcxmASiqy54uBy8rTqx1BFpPJ0W9q8tSHrjzzoj/c/M+/
         CtVpM+jM4dONBJaOWYt766SGHKM5kj0Z7lG1L423OSGkS2yUK7eux0MQW1sivkGcatXe
         AICg==
X-Gm-Message-State: ABy/qLZanzbGRLIBaf3EpE7H6Hv5sMBfoGZGCj51wdjafjrytv7VkNmj
        aC93+TET5mqvA6ecdQy2hgs=
X-Google-Smtp-Source: APBJJlGnRgVp+lpVXVYVBNXG47DEcvDlrcQ1s5eKZjviY/ycCTlCRMzMEcXI2WH17gtvYpjVlpfn3g==
X-Received: by 2002:a17:902:7b85:b0:1b8:33d4:77f8 with SMTP id w5-20020a1709027b8500b001b833d477f8mr1323162pll.23.1690540691923;
        Fri, 28 Jul 2023 03:38:11 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id b21-20020a170902d31500b001b552309aedsm3233065plc.192.2023.07.28.03.38.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 03:38:11 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 28 Jul 2023 03:38:10 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Rae Moar <rmoar@google.com>
Cc:     shuah@kernel.org, davidgow@google.com, dlatypov@google.com,
        brendan.higgins@linux.dev, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        keescook@chromium.org, linux-hardening@vger.kernel.org,
        jstultz@google.com, tglx@linutronix.de, sboyd@kernel.org
Subject: Re: [PATCH v3 0/9] kunit: Add test attributes API
Message-ID: <59dc28b1-298c-4e7b-b35f-0b94071f4cb5@roeck-us.net>
References: <20230725212522.1622716-1-rmoar@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230725212522.1622716-1-rmoar@google.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Jul 25, 2023 at 09:25:11PM +0000, Rae Moar wrote:
> Hello everyone,
> 
> This patch series adds a test attributes framework to KUnit.
> 

With this series in linux-next, almost 50% of my boot tests crash,
and many others show warnings tracebacks.

Example crash from x86_64 boot attempt attached.

Guenter

---
[    6.165419] ok 6 lib_sort
[    6.166044]     KTAP version 1
[    6.166139]     # Subtest: kunit_executor_test
[    6.166247]     # module: kunit
[    6.166261]     1..8
[    6.168252]     ok 1 parse_filter_test
[    6.169579] BUG: unable to handle page fault for address: ffffd757e80004c8
[    6.169872] #PF: supervisor read access in kernel mode
[    6.169990] #PF: error_code(0x0000) - not-present page
[    6.170142] PGD ffd4067 P4D ffd4067 PUD 0
[    6.170346] Oops: 0000 [#1] PREEMPT SMP PTI
[    6.170521] CPU: 0 PID: 182 Comm: kunit_try_catch Tainted: G                 N 6.5.0-rc3-next-20230728 #1
[    6.170735] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.2-0-gea1b7a073390-prebuilt.qemu.org 04/01/2014
[    6.171024] RIP: 0010:kfree+0x61/0x140
[    6.171313] Code: 80 48 01 e8 0f 82 ec 00 00 00 48 c7 c2 00 00 00 80 48 2b 15 29 bf aa 01 48 01 d0 48 c1 e8 0c 48 c1 e0 06 48 03 05 07 bf aa 01 <48> 8b 50 08 48 89 c7 f6 c2 01 0f 85 b3 00 00 00 66 90 48 8b 07 f6
[    6.171715] RSP: 0000:ffffb48f80267dc8 EFLAGS: 00000286
[    6.171847] RAX: ffffd757e80004c0 RBX: ffffa34583aef5d0 RCX: 0000000000000000
[    6.171998] RDX: 00005cba00000000 RSI: ffffffff95cb1ad5 RDI: ffffb48f80013cd0
[    6.172146] RBP: ffffb48f80013cd0 R08: 0000000000000001 R09: 0000000000000001
[    6.172293] R10: 0000000000000001 R11: 0000000000000001 R12: ffffb48f80267e74
[    6.172445] R13: 0000000000000000 R14: ffffa34583bf4000 R15: 0000000000000002
[    6.172620] FS:  0000000000000000(0000) GS:ffffa3458f800000(0000) knlGS:0000000000000000
[    6.172793] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    6.172917] CR2: ffffd757e80004c8 CR3: 0000000009048000 CR4: 00000000007506f0
[    6.173089] PKRU: 55555554
[    6.173177] Call Trace:
[    6.173313]  <TASK>
[    6.173494]  ? __die+0x1f/0x70
[    6.173600]  ? page_fault_oops+0x14a/0x460
[    6.173693]  ? search_exception_tables+0x37/0x50
[    6.173793]  ? fixup_exception+0x21/0x310
[    6.173887]  ? exc_page_fault+0xee/0x1c0
[    6.173977]  ? asm_exc_page_fault+0x26/0x30
[    6.174076]  ? kunit_filter_suites+0x3a5/0x460
[    6.174192]  ? kfree+0x61/0x140
[    6.174271]  ? kfree+0x106/0x140
[    6.174353]  kunit_filter_suites+0x3a5/0x460
[    6.174473]  ? __pfx_kunit_generic_run_threadfn_adapter+0x10/0x10
[    6.174604]  filter_suites_test+0xea/0x2c0
[    6.174702]  ? __pfx_kunit_generic_run_threadfn_adapter+0x10/0x10
[    6.174828]  kunit_generic_run_threadfn_adapter+0x15/0x20
[    6.174941]  kthread+0xef/0x120
[    6.175012]  ? __pfx_kthread+0x10/0x10
[    6.175098]  ret_from_fork+0x2f/0x50
[    6.175177]  ? __pfx_kthread+0x10/0x10
[    6.175260]  ret_from_fork_asm+0x1b/0x30
[    6.175387]  </TASK>
[    6.175466] Modules linked in:
[    6.175640] CR2: ffffd757e80004c8
[    6.175887] ---[ end trace 0000000000000000 ]---
[    6.176029] RIP: 0010:kfree+0x61/0x140
[    6.176119] Code: 80 48 01 e8 0f 82 ec 00 00 00 48 c7 c2 00 00 00 80 48 2b 15 29 bf aa 01 48 01 d0 48 c1 e8 0c 48 c1 e0 06 48 03 05 07 bf aa 01 <48> 8b 50 08 48 89 c7 f6 c2 01 0f 85 b3 00 00 00 66 90 48 8b 07 f6
[    6.176478] RSP: 0000:ffffb48f80267dc8 EFLAGS: 00000286
[    6.176589] RAX: ffffd757e80004c0 RBX: ffffa34583aef5d0 RCX: 0000000000000000
[    6.176729] RDX: 00005cba00000000 RSI: ffffffff95cb1ad5 RDI: ffffb48f80013cd0
[    6.176869] RBP: ffffb48f80013cd0 R08: 0000000000000001 R09: 0000000000000001
[    6.177008] R10: 0000000000000001 R11: 0000000000000001 R12: ffffb48f80267e74
[    6.177150] R13: 0000000000000000 R14: ffffa34583bf4000 R15: 0000000000000002
[    6.177290] FS:  0000000000000000(0000) GS:ffffa3458f800000(0000) knlGS:0000000000000000
[    6.177448] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    6.177564] CR2: ffffd757e80004c8 CR3: 0000000009048000 CR4: 00000000007506f0
[    6.177704] PKRU: 55555554
[    6.177807] note: kunit_try_catch[182] exited with irqs disabled

