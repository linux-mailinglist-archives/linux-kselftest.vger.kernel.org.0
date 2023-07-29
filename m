Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E30B767CF1
	for <lists+linux-kselftest@lfdr.de>; Sat, 29 Jul 2023 09:53:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230230AbjG2Hxk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 29 Jul 2023 03:53:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230194AbjG2Hxi (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 29 Jul 2023 03:53:38 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 047C82D7E
        for <linux-kselftest@vger.kernel.org>; Sat, 29 Jul 2023 00:53:23 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3fbd33a1819so22285e9.1
        for <linux-kselftest@vger.kernel.org>; Sat, 29 Jul 2023 00:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690617201; x=1691222001;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nS8MFufSLLMtZClBqbViwdVqq5Wj26o1tp0u8UhZNO4=;
        b=YFPjgdEvu1Q8F++dExxac0T4CZftI/fGtmD1BUuUWeJR1nEfnknBwFFPthGWMXAoXH
         0xHzCvNd7g+PdMGSVlBsEwNUPaP8Yx3/e3OmDPJ1UMidaxvX8kh0BlpWiIbnV9XTo2pS
         AWrvcLHjlpcBHYSPJrEkIIzn7R6JC9m0ri1+yfYqRcIMMbHltMMc65LTJj4YH4wW52qR
         GXJSFRJHKNnEmlKUzajPEDgJzuzyvkkXm+OUYiasVE4ej5+xhnq8AepEcVAveEZkhG5f
         3VM5CSEn+oS3MujG5ziOLf7ygySK9h3DKYqeVMVScyb517a1fjKtWD2LuKtsac8pDw06
         wRrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690617201; x=1691222001;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nS8MFufSLLMtZClBqbViwdVqq5Wj26o1tp0u8UhZNO4=;
        b=cmKFTNzA/Py7C513gkF0qhOP/pw2AJkM5RFYgiw4/kvdIbTAtZxxaFKS9IHRG4ps23
         aBGNEoY9mdlSxkPparXNx1TSCdgWZ/blhUeqtrcPyH0grT+aCLEyaONW+l4w3KBBJNcJ
         rxu2RfwFRTa95NKIcSfYPb5Ttu8Nn+z5i4JxYZ0kddh5uKqpZEDlHz2kuOoUMglBsM35
         xCbPNy+oOFg65V/g2i6RcDbcmIBQMiyyBmMicGc1CTuaiFk5MbiLaDLoGhUK00ryQPa3
         ViXDcSwZTaqUIFfDiTbActbHZXgU22SFYCDlZE0QRdcaGpfVdHl0KvnQQ7PXXycPXa6D
         oNig==
X-Gm-Message-State: ABy/qLZOH1JsbSr/lGLEsIgwdmWid9sFgFkdszGjo6bSXfZUxjZhsVdi
        sLU4lwVpcNodPaQT9Nwhbf9mrFDurybCFE3iaNxdOA==
X-Google-Smtp-Source: APBJJlF5F7B8gWeRzBo8RDFVrolQzxUBd8VXQ2E9W1UUdW2SgRwlk7ctqfsAlh3mmrYhvxidyRiclT0BbqeRAyYzCbw=
X-Received: by 2002:a05:600c:1c90:b0:3f1:6fe9:4a95 with SMTP id
 k16-20020a05600c1c9000b003f16fe94a95mr56614wms.4.1690617201430; Sat, 29 Jul
 2023 00:53:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230725212522.1622716-1-rmoar@google.com> <59dc28b1-298c-4e7b-b35f-0b94071f4cb5@roeck-us.net>
In-Reply-To: <59dc28b1-298c-4e7b-b35f-0b94071f4cb5@roeck-us.net>
From:   David Gow <davidgow@google.com>
Date:   Sat, 29 Jul 2023 15:53:07 +0800
Message-ID: <CABVgOS=wfUS929nKGvnRpBdEjQCHD1d5tbmGtKCBNFh2bKWO-Q@mail.gmail.com>
Subject: Re: [PATCH v3 0/9] kunit: Add test attributes API
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Rae Moar <rmoar@google.com>, shuah@kernel.org, dlatypov@google.com,
        brendan.higgins@linux.dev, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        keescook@chromium.org, linux-hardening@vger.kernel.org,
        jstultz@google.com, tglx@linutronix.de, sboyd@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, 28 Jul 2023 at 18:38, Guenter Roeck <linux@roeck-us.net> wrote:
>
> On Tue, Jul 25, 2023 at 09:25:11PM +0000, Rae Moar wrote:
> > Hello everyone,
> >
> > This patch series adds a test attributes framework to KUnit.
> >
>
> With this series in linux-next, almost 50% of my boot tests crash,
> and many others show warnings tracebacks.
>
> Example crash from x86_64 boot attempt attached.
>
> Guenter
>
> ---

Hmm... It's not reproducing here (even with KASAN), which is strange.

Does the patch here help?
https://lore.kernel.org/linux-kselftest/20230729010003.4058582-1-ruanjinjie@huawei.com/

-- David

> [    6.165419] ok 6 lib_sort
> [    6.166044]     KTAP version 1
> [    6.166139]     # Subtest: kunit_executor_test
> [    6.166247]     # module: kunit
> [    6.166261]     1..8
> [    6.168252]     ok 1 parse_filter_test
> [    6.169579] BUG: unable to handle page fault for address: ffffd757e80004c8
> [    6.169872] #PF: supervisor read access in kernel mode
> [    6.169990] #PF: error_code(0x0000) - not-present page
> [    6.170142] PGD ffd4067 P4D ffd4067 PUD 0
> [    6.170346] Oops: 0000 [#1] PREEMPT SMP PTI
> [    6.170521] CPU: 0 PID: 182 Comm: kunit_try_catch Tainted: G                 N 6.5.0-rc3-next-20230728 #1
> [    6.170735] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.2-0-gea1b7a073390-prebuilt.qemu.org 04/01/2014
> [    6.171024] RIP: 0010:kfree+0x61/0x140
> [    6.171313] Code: 80 48 01 e8 0f 82 ec 00 00 00 48 c7 c2 00 00 00 80 48 2b 15 29 bf aa 01 48 01 d0 48 c1 e8 0c 48 c1 e0 06 48 03 05 07 bf aa 01 <48> 8b 50 08 48 89 c7 f6 c2 01 0f 85 b3 00 00 00 66 90 48 8b 07 f6
> [    6.171715] RSP: 0000:ffffb48f80267dc8 EFLAGS: 00000286
> [    6.171847] RAX: ffffd757e80004c0 RBX: ffffa34583aef5d0 RCX: 0000000000000000
> [    6.171998] RDX: 00005cba00000000 RSI: ffffffff95cb1ad5 RDI: ffffb48f80013cd0
> [    6.172146] RBP: ffffb48f80013cd0 R08: 0000000000000001 R09: 0000000000000001
> [    6.172293] R10: 0000000000000001 R11: 0000000000000001 R12: ffffb48f80267e74
> [    6.172445] R13: 0000000000000000 R14: ffffa34583bf4000 R15: 0000000000000002
> [    6.172620] FS:  0000000000000000(0000) GS:ffffa3458f800000(0000) knlGS:0000000000000000
> [    6.172793] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    6.172917] CR2: ffffd757e80004c8 CR3: 0000000009048000 CR4: 00000000007506f0
> [    6.173089] PKRU: 55555554
> [    6.173177] Call Trace:
> [    6.173313]  <TASK>
> [    6.173494]  ? __die+0x1f/0x70
> [    6.173600]  ? page_fault_oops+0x14a/0x460
> [    6.173693]  ? search_exception_tables+0x37/0x50
> [    6.173793]  ? fixup_exception+0x21/0x310
> [    6.173887]  ? exc_page_fault+0xee/0x1c0
> [    6.173977]  ? asm_exc_page_fault+0x26/0x30
> [    6.174076]  ? kunit_filter_suites+0x3a5/0x460
> [    6.174192]  ? kfree+0x61/0x140
> [    6.174271]  ? kfree+0x106/0x140
> [    6.174353]  kunit_filter_suites+0x3a5/0x460
> [    6.174473]  ? __pfx_kunit_generic_run_threadfn_adapter+0x10/0x10
> [    6.174604]  filter_suites_test+0xea/0x2c0
> [    6.174702]  ? __pfx_kunit_generic_run_threadfn_adapter+0x10/0x10
> [    6.174828]  kunit_generic_run_threadfn_adapter+0x15/0x20
> [    6.174941]  kthread+0xef/0x120
> [    6.175012]  ? __pfx_kthread+0x10/0x10
> [    6.175098]  ret_from_fork+0x2f/0x50
> [    6.175177]  ? __pfx_kthread+0x10/0x10
> [    6.175260]  ret_from_fork_asm+0x1b/0x30
> [    6.175387]  </TASK>
> [    6.175466] Modules linked in:
> [    6.175640] CR2: ffffd757e80004c8
> [    6.175887] ---[ end trace 0000000000000000 ]---
> [    6.176029] RIP: 0010:kfree+0x61/0x140
> [    6.176119] Code: 80 48 01 e8 0f 82 ec 00 00 00 48 c7 c2 00 00 00 80 48 2b 15 29 bf aa 01 48 01 d0 48 c1 e8 0c 48 c1 e0 06 48 03 05 07 bf aa 01 <48> 8b 50 08 48 89 c7 f6 c2 01 0f 85 b3 00 00 00 66 90 48 8b 07 f6
> [    6.176478] RSP: 0000:ffffb48f80267dc8 EFLAGS: 00000286
> [    6.176589] RAX: ffffd757e80004c0 RBX: ffffa34583aef5d0 RCX: 0000000000000000
> [    6.176729] RDX: 00005cba00000000 RSI: ffffffff95cb1ad5 RDI: ffffb48f80013cd0
> [    6.176869] RBP: ffffb48f80013cd0 R08: 0000000000000001 R09: 0000000000000001
> [    6.177008] R10: 0000000000000001 R11: 0000000000000001 R12: ffffb48f80267e74
> [    6.177150] R13: 0000000000000000 R14: ffffa34583bf4000 R15: 0000000000000002
> [    6.177290] FS:  0000000000000000(0000) GS:ffffa3458f800000(0000) knlGS:0000000000000000
> [    6.177448] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    6.177564] CR2: ffffd757e80004c8 CR3: 0000000009048000 CR4: 00000000007506f0
> [    6.177704] PKRU: 55555554
> [    6.177807] note: kunit_try_catch[182] exited with irqs disabled
>
> --
> You received this message because you are subscribed to the Google Groups "KUnit Development" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kunit-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kunit-dev/59dc28b1-298c-4e7b-b35f-0b94071f4cb5%40roeck-us.net.
