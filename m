Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 743A96A095E
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Feb 2023 14:05:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234284AbjBWNFZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 23 Feb 2023 08:05:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233338AbjBWNFY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 23 Feb 2023 08:05:24 -0500
Received: from xavier.telenet-ops.be (xavier.telenet-ops.be [IPv6:2a02:1800:120:4::f00:14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B057D51FBC
        for <linux-kselftest@vger.kernel.org>; Thu, 23 Feb 2023 05:05:15 -0800 (PST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed50:bcd1:971c:dc94:f8b5])
        by xavier.telenet-ops.be with bizsmtp
        id Qd5C2900G0HkUFX01d5C9t; Thu, 23 Feb 2023 14:05:12 +0100
Received: from geert (helo=localhost)
        by ramsan.of.borg with local-esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1pVBHc-009oV5-E3;
        Thu, 23 Feb 2023 14:05:12 +0100
Date:   Thu, 23 Feb 2023 14:05:12 +0100 (CET)
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Chuck Lever <cel@kernel.org>
cc:     linux-nfs@vger.kernel.org, dhowells@redhat.com, simo@redhat.com,
        linux-kselftest@vger.kernel.org, linux-m68k@lists.linux-m68k.org
Subject: Re: [PATCH v2 00/41] RPCSEC GSS krb5 enhancements
In-Reply-To: <167380196429.10651.4103075913257868035.stgit@bazille.1015granger.net>
Message-ID: <b3e0b5e6-1d0-cdb2-186c-6b4f50e0a3aa@linux-m68k.org>
References: <167380196429.10651.4103075913257868035.stgit@bazille.1015granger.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

 	Hi Chuck,

On Sun, 15 Jan 2023, Chuck Lever wrote:
> The purpose of this series is to improve/harden the security
> provided by the Linux kernel's RPCSEC GSS Kerberos 5 mechanism.
> There are lots of clean-ups in this series, but the pertinent
> feature is the addition of a clean deprecation path for the DES-
> and SHA1-based encryption types in accordance with Internet BCPs.
>
> This series disables DES-based enctypes by default, provides a
> mechanism for disabling SHA1-based enctypes, and introduces two
> modern enctypes that do not use deprecated crypto algorithms.
>
> Not only does that improve security for Kerberos 5 users, but it
> also prepares SunRPC for eventually switching to a shared common
> kernel Kerberos 5 implementation, which surely will not implement
> any deprecated encryption types (in particular, DES-based ones).
>
> Today, MIT supports both of the newly-introduced enctypes, but
> Heimdal does not appear to. Thus distributions can enable and
> disable kernel enctype support to match the set of enctypes
> supported in their user space Kerberos libraries.
>
> Scott has been kicking the tires -- we've found no regressions with
> the current SHA1-based enctypes, while the new ones are disabled by
> default until we have an opportunity for interop testing. The KUnit
> tests for the new enctypes pass and this implementation successfully
> interoperates with itself using these enctypes. Therefore I believe
> it to be safe to merge.
>
> When this series gets merged, the Linux NFS community should select
> and announce a date-certain for removal of SunRPC's DES-based
> enctype code.

As this is now upstream, I gave it a try on m68k (on the ARAnyM
emulator), using a config based on atari_defconfig:

     KTAP version 1
     # Subtest: RFC 3961 tests
     1..3
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
     # RFC 3961 key derivation: ASSERTION FAILED at net/sunrpc/auth_gss/gss_krb5_test.c:52
     Expected gk5e != ((void *)0), but
         gk5e == 00000000
         ((void *)0) == 00000000
         not ok 1 des3-hmac-sha1 key derivation case 1
     # RFC 3961 key derivation: ASSERTION FAILED at net/sunrpc/auth_gss/gss_krb5_test.c:52
     Expected gk5e != ((void *)0), but
         gk5e == 00000000
         ((void *)0) == 00000000
         not ok 2 des3-hmac-sha1 key derivation case 2
     # RFC 3961 key derivation: ASSERTION FAILED at net/sunrpc/auth_gss/gss_krb5_test.c:52
     Expected gk5e != ((void *)0), but
         gk5e == 00000000
         ((void *)0) == 00000000
         not ok 3 des3-hmac-sha1 key derivation case 3
     # RFC 3961 key derivation: ASSERTION FAILED at net/sunrpc/auth_gss/gss_krb5_test.c:52
     Expected gk5e != ((void *)0), but
         gk5e == 00000000
         ((void *)0) == 00000000
         not ok 4 des3-hmac-sha1 key derivation case 4
     # RFC 3961 key derivation: ASSERTION FAILED at net/sunrpc/auth_gss/gss_krb5_test.c:52
     Expected gk5e != ((void *)0), but
         gk5e == 00000000
         ((void *)0) == 00000000
         not ok 5 des3-hmac-sha1 key derivation case 5
     # RFC 3961 key derivation: ASSERTION FAILED at net/sunrpc/auth_gss/gss_krb5_test.c:52
     Expected gk5e != ((void *)0), but
         gk5e == 00000000
         ((void *)0) == 00000000
         not ok 6 des3-hmac-sha1 key derivation case 6
     # RFC 3961 key derivation: ASSERTION FAILED at net/sunrpc/auth_gss/gss_krb5_test.c:52
     Expected gk5e != ((void *)0), but
         gk5e == 00000000
         ((void *)0) == 00000000
         not ok 7 des3-hmac-sha1 key derivation case 7
     # RFC 3961 key derivation: ASSERTION FAILED at net/sunrpc/auth_gss/gss_krb5_test.c:52
     Expected gk5e != ((void *)0), but
         gk5e == 00000000
         ((void *)0) == 00000000
         not ok 8 des3-hmac-sha1 key derivation case 8
     # RFC 3961 key derivation: ASSERTION FAILED at net/sunrpc/auth_gss/gss_krb5_test.c:52
     Expected gk5e != ((void *)0), but
         gk5e == 00000000
         ((void *)0) == 00000000
         not ok 9 des3-hmac-sha1 key derivation case 9
     # RFC 3961 key derivation: pass:0 fail:9 skip:0 total:9
     not ok 2 RFC 3961 key derivation
*** CHK ***   FORMAT=2
Current process id is 794
BAD KERNEL TRAP: 00000000
Modules linked in: gss_krb5_test rpcsec_gss_krb5 auth_rpcgss oid_registry kunit
PC: [<1188975a>] rfc6803_suite+0x2/0xffffc688 [gss_krb5_test]
SR: 2200  SP: 93025120  a2: 01b6f700
d0: 00000002    d1: 00000010    d2: 00000014    d3: 01aebcc4
d4: 01aebc44    d5: 00000009    a0: 11889754    a1: 01aebc44
Process insmod (pid: 794, task=c42c6bea)
Frame format=2 instr addr=1188975a
Stack from 01aebbd8:
         11963860 00000000 01aebc44 00000000 00000005 00000001 00000000 00000000
         11889e5c 11889e34 11889be8 119644d8 1196356e 00000001 00000009 00000000
         00000000 0000000b 01aebcfc 00000001 00000000 00000001 00000002 00000000
         00000000 00000000 00000000 00657333 2d686d61 632d7368 6131206b 65792064
         65726976 6174696f 6e206361 73652039 00000000 484e4f4c 4f475922 29000000
         00000801 000c729c 005b9c58 00000000 00040cc0 00040cc0 00000000 00000000
Call Trace: [<11963860>] kunit_run_tests+0x2f2/0x3d2 [kunit]
  [<119644d8>] kunit_debugfs_create_suite+0x0/0x54 [kunit]
  [<1196356e>] kunit_run_tests+0x0/0x3d2 [kunit]
  [<000c729c>] get_page_from_freelist+0x176/0x48a
  [<00040cc0>] __finish_swait+0x1a/0x1c
  [<00040cc0>] __finish_swait+0x1a/0x1c
  [<00040cc0>] __finish_swait+0x1a/0x1c
  [<000c7126>] get_page_from_freelist+0x0/0x48a
  [<00009752>] ssincosnan+0x10/0x26
  [<000c6f00>] __putback_isolated_page+0x62/0x7c
  [<119639e2>] __kunit_test_suites_init+0xa2/0xfa [kunit]
  [<000405ea>] __wake_up+0x0/0x1c
  [<00037774>] blocking_notifier_call_chain+0x0/0x46
  [<11963a5a>] kunit_module_notify+0x20/0x34 [kunit]
  [<00037404>] notifier_call_chain+0x34/0x48
  [<0004e3b4>] module_put+0x0/0x50
  [<000377a0>] blocking_notifier_call_chain+0x2c/0x46
  [<0004ebd4>] do_init_module+0xd6/0x1a2
  [<0036ec50>] memset+0x0/0x8c
  [<00005b94>] flush_icache_range+0x0/0x30
  [<0005009c>] load_module+0x1304/0x1368
  [<0000eb60>] zer_rm2+0x1c/0x24
  [<0036ed04>] __generic_copy_from_user+0x0/0x40
  [<00010000>] EXPTBL+0x1c8/0x400
  [<0036ec50>] memset+0x0/0x8c
  [<003762ac>] __cond_resched+0x0/0x46
  [<000501d4>] sys_init_module+0xd4/0xda
  [<0000eb60>] zer_rm2+0x1c/0x24
  [<0000536e>] buserr_c+0xc6/0x49a
  [<00002962>] syscall+0x8/0xc
  [<0000eb60>] zer_rm2+0x1c/0x24
  [<0000eb60>] zer_rm2+0x1c/0x24
  [<00010000>] EXPTBL+0x1c8/0x400
  [<0018c00b>] nfs_direct_write_schedule_iovec+0xe3/0x1d6

Code: 646b 1188 42f6 0000 0000 0000 0000 5246 <4320> 3638 3033 2073 7569 7465 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000
Disabling lock debugging due to kernel taint

All of gss_krb5_test, rpcsec_gss_krb5, auth_rpcgss, oid_registry, and
kunit are modular.

Thanks!

Gr{oetje,eeting}s,

 						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
 							    -- Linus Torvalds
