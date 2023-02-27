Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F88B6A3E9A
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Feb 2023 10:51:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbjB0Jvo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 27 Feb 2023 04:51:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbjB0Jvm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 27 Feb 2023 04:51:42 -0500
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD6B41A961;
        Mon, 27 Feb 2023 01:51:40 -0800 (PST)
Received: by mail-qt1-f179.google.com with SMTP id s12so5861389qtq.11;
        Mon, 27 Feb 2023 01:51:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gj9gKpiseh+D/fSOLAEPwn6YG59IzTCb5Bzhksu4Pdw=;
        b=K9ghXytqn13+448dARz2zhFHJRJwATS5/RrOqAKSoTsXnEznTdTql3RUZxU3dEUsa3
         R0TdeC1ndoQQBjragrnTFFJMUu2wiz5bZiktc+0DUSQGhuxxB34CfFoqKABxCl+GN+qX
         Xl92PIjo58y9ScGSkOWpK7DjELcz7JWdan9zm1jR98ir/blDxa9uHjaAquSRL4tdWppO
         9ZW+aH09Lil31iXFsn4Dg1jKMgXE4EcyDgYTl2NcerniUrLu82lcoHJbRMm6peKVi336
         orrzBTSNkkaDYc3RQIM0MnE24ZlCRduvfmrqFdffEMz8AgdXSRLJibBda1IRnaqZb+Na
         +SSg==
X-Gm-Message-State: AO0yUKX8cYcmOzN2x0VqgDJQcwfd3Wvpo8VlqjZEslwjPu2PUxfv7F+M
        5NkHbGqJQTNOBP7yIF0C/aNCeIaaiBiKvw==
X-Google-Smtp-Source: AK7set84FIOhhFE04RwRxqXmcaWyY6JHmsS2EU0/a33jWAr5U9UMSq4UY3xg6fKBIVi6i8NJ0HnfnA==
X-Received: by 2002:a05:622a:591:b0:3bf:ce27:e1fc with SMTP id c17-20020a05622a059100b003bfce27e1fcmr10259642qtb.7.1677491499391;
        Mon, 27 Feb 2023 01:51:39 -0800 (PST)
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com. [209.85.128.173])
        by smtp.gmail.com with ESMTPSA id c3-20020ac86603000000b003b9bc00c2f1sm4275630qtp.94.2023.02.27.01.51.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Feb 2023 01:51:39 -0800 (PST)
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-536b7ffdd34so159591157b3.6;
        Mon, 27 Feb 2023 01:51:38 -0800 (PST)
X-Received: by 2002:a25:9c85:0:b0:90d:af77:9ca6 with SMTP id
 y5-20020a259c85000000b0090daf779ca6mr9186019ybo.7.1677491498294; Mon, 27 Feb
 2023 01:51:38 -0800 (PST)
MIME-Version: 1.0
References: <167380196429.10651.4103075913257868035.stgit@bazille.1015granger.net>
 <b3e0b5e6-1d0-cdb2-186c-6b4f50e0a3aa@linux-m68k.org> <D5221DC2-2A9C-43DC-AC21-FA96E7F76E5B@oracle.com>
 <CAMuHMdVtsZ-jU5foR7V_4XeXT_0f3Nx5vfoJo5pH2jMga0SpWA@mail.gmail.com>
 <58CCF033-58C3-4AF0-B958-BE1AAF1695F3@oracle.com> <CAMuHMdUG5cthYp3u6GeYqTqMaNgW0Ernq_ce0AZ22rgFQ5J24A@mail.gmail.com>
In-Reply-To: <CAMuHMdUG5cthYp3u6GeYqTqMaNgW0Ernq_ce0AZ22rgFQ5J24A@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 27 Feb 2023 10:51:22 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXYXO+D==BrN4h57cmuNyOG2Jd3_NwOWNgpjaoBdWQvOg@mail.gmail.com>
Message-ID: <CAMuHMdXYXO+D==BrN4h57cmuNyOG2Jd3_NwOWNgpjaoBdWQvOg@mail.gmail.com>
Subject: Re: [PATCH v2 00/41] RPCSEC GSS krb5 enhancements
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Chuck Lever <cel@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        "simo@redhat.com" <simo@redhat.com>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "linux-m68k@lists.linux-m68k.org" <linux-m68k@lists.linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Chuck,

On Thu, Feb 23, 2023 at 5:52 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Thu, Feb 23, 2023 at 5:19 PM Chuck Lever III <chuck.lever@oracle.com> wrote:
> > > On Feb 23, 2023, at 10:16 AM, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
 > > Unable to handle kernel access at virtual address af06da84
>
> > > I.e. a slightly different crash.
> > > As the difference between the two crashes is modular vs. builtin,
> > > this looks like an out-of-bound access in the test.

Just ran it on physical arm32 and arm64 (Renesas APE6EVM and
Salvator-XS), and the test crashes there, too.

> > Why not run the test suite just as I suggested?

kunit_kernel.ConfigError: m68k is not a valid arch, options are
['alpha', 'arm', 'arm64', 'i386', 'powerpc', 'riscv', 's390', 'sparc',
'x86_64']

Will look into adding m68k support ;-)

But the issue can easily be reproduced using
".../tools/testing/kunit/kunit.py run --arch=arm
--cross_compile=arm-linux-gnueabihf- --raw_output=all --kunitconfig
./net/sunrpc/.kunitconfig" on current upstream[1]:

KTAP version 1
1..5
    KTAP version 1
    # Subtest: RFC 3961 tests
    1..2
        KTAP version 1
        # Subtest: RFC 3961 n-fold
        ok 1 64-fold("012345")
        ok 2 56-fold("password")
        ok 3 64-fold("Rough Consensus, and Running Code")
        ok 4 168-fold("password")
        ok 5 192-fold("MASSACHVSETTS INSTITVTE OF TECHNOLOGY")
        ok 6 168-fold("Q")
        ok 7 168-fold("ba")
        ok 8 64-fold("kerberos")
        ok 9 128-fold("kerberos")
        ok 10 168-fold("kerberos")
        ok 11 256-fold("kerberos")
    # RFC 3961 n-fold: pass:11 fail:0 skip:0 total:11
    ok 1 RFC 3961 n-fold
        KTAP version 1
        # Subtest: RFC 3961 key derivation
        ok 1 des3-hmac-sha1 key derivation case 1
        ok 2 des3-hmac-sha1 key derivation case 2
        ok 3 des3-hmac-sha1 key derivation case 3
        ok 4 des3-hmac-sha1 key derivation case 4
        ok 5 des3-hmac-sha1 key derivation case 5
        ok 6 des3-hmac-sha1 key derivation case 6
        ok 7 des3-hmac-sha1 key derivation case 7
        ok 8 des3-hmac-sha1 key derivation case 8
        ok 9 des3-hmac-sha1 key derivation case 9
    # RFC 3961 key derivation: pass:9 fail:0 skip:0 total:9
    ok 2 RFC 3961 key derivation
# RFC 3961 tests: pass:2 fail:0 skip:0 total:2
# Totals: pass:20 fail:0 skip:0 total:20
ok 1 RFC 3961 tests
    KTAP version 1
    # Subtest: RFC 3962 suite
    1..2
        KTAP version 1
        # Subtest: RFC 3962 encryption
        ok 1 Encrypt with aes128-cts-hmac-sha1-96 case 1
        ok 2 Encrypt with aes128-cts-hmac-sha1-96 case 2
        ok 3 Encrypt with aes128-cts-hmac-sha1-96 case 3
        ok 4 Encrypt with aes128-cts-hmac-sha1-96 case 4
        ok 5 Encrypt with aes128-cts-hmac-sha1-96 case 5
        ok 6 Encrypt with aes128-cts-hmac-sha1-96 case 6
    # RFC 3962 encryption: pass:6 fail:0 skip:0 total:6
    ok 1 RFC 3962 encryption
8<--- cut here ---
Unable to handle kernel paging request at virtual address 73657420 when execute
[73657420] *pgd=00000000
Internal error: Oops: 80000005 [#1] ARM
CPU: 0 PID: 1 Comm: swapper Tainted: G                 N
6.2.0-12486-g85f341272fa9 #1
Hardware name: Generic DT based system
PC is at 0x73657420
LR is at kunit_run_tests+0x3cc/0x5e8
pc : [<73657420>]    lr : [<c02d0e54>]    psr: 20000053
sp : f0809cc8  ip : f0809e54  fp : 00000006
r10: c069dc30  r9 : c069dd84  r8 : f0809e54
r7 : 00000000  r6 : 00000006  r5 : c08a8504  r4 : c08a82d0
r3 : 73657420  r2 : 00000002  r1 : f0809e54  r0 : 00000000
Flags: nzCv  IRQs on  FIQs off  Mode SVC_32  ISA ARM  Segment none
Control: 10c53c7d  Table: 40004059  DAC: 00000051
Register r0 information: NULL pointer
Register r1 information: 2-page vmalloc region starting at 0xf0808000
allocated at kernel_clone+0x94/0x2fc
Register r2 information: non-paged memory
Register r3 information: non-paged memory
Register r4 information: non-slab/vmalloc memory
Register r5 information: non-slab/vmalloc memory
Register r6 information: non-paged memory
Register r7 information: NULL pointer
Register r8 information: 2-page vmalloc region starting at 0xf0808000
allocated at kernel_clone+0x94/0x2fc
Register r9 information: non-slab/vmalloc memory
Register r10 information: non-slab/vmalloc memory
Register r11 information: non-paged memory
Register r12 information: 2-page vmalloc region starting at 0xf0808000
allocated at kernel_clone+0x94/0x2fc
Process swapper (pid: 1, stack limit = 0x(ptrval))
Stack: (0xf0809cc8 to 0xf080a000)
9cc0:                   c06b6154 f0809d54 00000006 c01443d8 00000000 00000000
9ce0: 00000000 00000000 c088a8c0 c069dd1c c069dd38 c0698d6c 00000000 00000001
9d00: 00000000 00000000 00000001 00000000 00000000 00000000 00000000 00000000
9d20: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
9d40: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
9d60: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
9d80: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
9da0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
9dc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
9de0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
9e00: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
9e20: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
9e40: 00000000 00000000 00000000 00000000 00000000 72636e00 20747079 68746977
9e60: 73656120 2d383231 2d737463 63616d68 6168732d 36392d31 73616320 00362065
9e80: 2259474f 00000029 800000d3 3ffff049 0000000c 00313601 0000004a 00000000
9ea0: c0894480 ff7583a2 00000004 ffffffff 00000000 c069e520 00000000 c072185c
9ec0: c072183c c0141eac f0809f1c c031fd5c 0251f4a2 ff7583a2 c0727f10 c08d932c
9ee0: c0727f14 00000002 00000005 c0804205 00000000 c072183c c0700510 c02d1160
9f00: c0cf534e c050f460 f0809f1c 00000005 c0727f10 c0cf5340 00000000 00000001
9f20: c072185c c02d2e94 c0c01100 c0727f24 c0727f10 c08d9318 c072185c c0806cd0
9f40: c0728750 c0cf5340 c06b9808 c06b73e0 c072185c c072183c c0700510 c07015f4
9f60: 00000007 00000007 00000000 c0700510 00000002 0000005d c0c5c000 c0804200
9f80: c0515dd8 00000000 00000000 00000000 00000000 00000000 00000000 c0515df0
9fa0: 00000000 c0515dd8 00000000 c0100148 00000000 00000000 00000000 00000000
9fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
9fe0: 00000000 00000000 00000000 00000000 00000013 00000000 00000000 00000000
 kunit_run_tests from __kunit_test_suites_init+0xc0/0x1a8
 __kunit_test_suites_init from kunit_run_all_tests+0x24c/0x41c
 kunit_run_all_tests from kernel_init_freeable+0x20c/0x258
 kernel_init_freeable from kernel_init+0x18/0x144
 kernel_init from ret_from_fork+0x14/0x2c
Exception stack(0xf0809fb0 to 0xf0809ff8)
9fa0:                                     00000000 00000000 00000000 00000000
9fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
9fe0: 00000000 00000000 00000000 00000000 00000013 00000000
Code: bad PC value
---[ end trace 0000000000000000 ]---
Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b

[1] 85f341272fa9 = f3a2439f20d91893 ("Merge tag 'rproc-v6.3' of
    git://git.kernel.org/pub/scm/linux/kernel/git/remoteproc/linux") +
    a cherry-pick of a fix for a regression on my arm64 platforms)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
