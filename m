Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 886EC6A0CAE
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Feb 2023 16:17:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234126AbjBWPRP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 23 Feb 2023 10:17:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233429AbjBWPRO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 23 Feb 2023 10:17:14 -0500
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39AEB56518;
        Thu, 23 Feb 2023 07:17:12 -0800 (PST)
Received: by mail-qt1-f182.google.com with SMTP id w42so11041959qtc.2;
        Thu, 23 Feb 2023 07:17:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IgdhNdgIhRopLygNtjMJqvmObdRSMA+pwwR1xAllHGc=;
        b=YQTYDfsSWL6BACobwTbe2JJTUJxspAfqP5rxzf/O0Q1u/VdwiLuHTCEwE47Apzb7x0
         x+u8ADEFn7BbNH5Ze9mGHmCUSwdtIbosCgQlfPB+FnBNZRu6t8yh/zNchDR0V8/V2P63
         Uch5FlW7748xmO7N+knN7V2X84cV3U7Rlsv8D3HFzGqLoMIHfyzEvophYmwmA7vjsXz/
         5jZqNiVrZlSny2t6ta0vIoymCHYveYTIsKHWFY58/rdXHRK8mgZp6ltPf70is7y+wzyf
         UqBrzWLRZ6BpTQHEJnPoAnyPB8f8wxUIvEIsfumxMHNXtMZ8MlZGj6D+521LeafdAAv0
         1PGg==
X-Gm-Message-State: AO0yUKVX1hQC3MkBZTBKxgjo5smbVsmgWPFoWAELu2xgRuINj55nqLev
        QP5WB9GeqWg2IYRyXaWUJ6zavL1PSWzz4Q==
X-Google-Smtp-Source: AK7set/rETxseMDdbRs6ujD2z0DeGdmlwhnk9Zh+z4fvZGXF8pCXi81VabJU7IMvoeAiSaQzZTpwAw==
X-Received: by 2002:ac8:7fca:0:b0:3bc:e796:8630 with SMTP id b10-20020ac87fca000000b003bce7968630mr5024221qtk.23.1677165430955;
        Thu, 23 Feb 2023 07:17:10 -0800 (PST)
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com. [209.85.128.182])
        by smtp.gmail.com with ESMTPSA id f14-20020ac8498e000000b003b9a426d626sm6221195qtq.22.2023.02.23.07.17.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Feb 2023 07:17:10 -0800 (PST)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-536e10ae021so154879027b3.7;
        Thu, 23 Feb 2023 07:17:10 -0800 (PST)
X-Received: by 2002:a5b:301:0:b0:a09:32fb:bd6c with SMTP id
 j1-20020a5b0301000000b00a0932fbbd6cmr1666693ybp.7.1677165429712; Thu, 23 Feb
 2023 07:17:09 -0800 (PST)
MIME-Version: 1.0
References: <167380196429.10651.4103075913257868035.stgit@bazille.1015granger.net>
 <b3e0b5e6-1d0-cdb2-186c-6b4f50e0a3aa@linux-m68k.org> <D5221DC2-2A9C-43DC-AC21-FA96E7F76E5B@oracle.com>
In-Reply-To: <D5221DC2-2A9C-43DC-AC21-FA96E7F76E5B@oracle.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 23 Feb 2023 16:16:55 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVtsZ-jU5foR7V_4XeXT_0f3Nx5vfoJo5pH2jMga0SpWA@mail.gmail.com>
Message-ID: <CAMuHMdVtsZ-jU5foR7V_4XeXT_0f3Nx5vfoJo5pH2jMga0SpWA@mail.gmail.com>
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

On Thu, Feb 23, 2023 at 3:00 PM Chuck Lever III <chuck.lever@oracle.com> wrote:
> > On Feb 23, 2023, at 8:05 AM, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > On Sun, 15 Jan 2023, Chuck Lever wrote:
> >> The purpose of this series is to improve/harden the security
> >> provided by the Linux kernel's RPCSEC GSS Kerberos 5 mechanism.
> >> There are lots of clean-ups in this series, but the pertinent
> >> feature is the addition of a clean deprecation path for the DES-
> >> and SHA1-based encryption types in accordance with Internet BCPs.
> >>
> >> This series disables DES-based enctypes by default, provides a
> >> mechanism for disabling SHA1-based enctypes, and introduces two
> >> modern enctypes that do not use deprecated crypto algorithms.
> >>
> >> Not only does that improve security for Kerberos 5 users, but it
> >> also prepares SunRPC for eventually switching to a shared common
> >> kernel Kerberos 5 implementation, which surely will not implement
> >> any deprecated encryption types (in particular, DES-based ones).
> >>
> >> Today, MIT supports both of the newly-introduced enctypes, but
> >> Heimdal does not appear to. Thus distributions can enable and
> >> disable kernel enctype support to match the set of enctypes
> >> supported in their user space Kerberos libraries.
> >>
> >> Scott has been kicking the tires -- we've found no regressions with
> >> the current SHA1-based enctypes, while the new ones are disabled by
> >> default until we have an opportunity for interop testing. The KUnit
> >> tests for the new enctypes pass and this implementation successfully
> >> interoperates with itself using these enctypes. Therefore I believe
> >> it to be safe to merge.
> >>
> >> When this series gets merged, the Linux NFS community should select
> >> and announce a date-certain for removal of SunRPC's DES-based
> >> enctype code.
> >
> > As this is now upstream, I gave it a try on m68k (on the ARAnyM
> > emulator), using a config based on atari_defconfig:
> >
> >    KTAP version 1
> >    # Subtest: RFC 3961 tests
> >    1..3
> >        KTAP version 1
> >        # Subtest: RFC 3961 n-fold
> >        ok 1 64-fold("012345")
> >        ok 2 56-fold("password")
> >        ok 3 64-fold("Rough Consensus, and Running Code")
> >        ok 4 168-fold("password")
> >        ok 5 192-fold("MASSACHVSETTS INSTITVTE OF TECHNOLOGY")
> >        ok 6 168-fold("Q")
> >        ok 7 168-fold("ba")
> >        ok 8 64-fold("kerberos")
> >        ok 9 128-fold("kerberos")
> >        ok 10 168-fold("kerberos")
> >        ok 11 256-fold("kerberos")
> >    # RFC 3961 n-fold: pass:11 fail:0 skip:0 total:11
> >    ok 1 RFC 3961 n-fold
> >        KTAP version 1
> >        # Subtest: RFC 3961 key derivation
> >    # RFC 3961 key derivation: ASSERTION FAILED at net/sunrpc/auth_gss/gss_krb5_test.c:52
> >    Expected gk5e != ((void *)0), but
> >        gk5e == 00000000
> >        ((void *)0) == 00000000
> >        not ok 1 des3-hmac-sha1 key derivation case 1
>
> Geert, thanks for testing GSS on m68k.
>
> This assertion failure means that support for the encryption types
> specified in RFC 3961 is not built into your kernel.
>
> The new Kunit tests don't work unless everything is built in --
>
> there's a net/sunrpc/.kunitconfig that provides the supported
> build configuration for running them. I typically use a command
> line similar to this:
>
> ./tools/testing/kunit/kunit.py run --raw_output=all --kunitconfig ./net/sunrpc/.kunitconfig

Aren't modular crypto algorithms auto-loaded when needed?

In general, it's a good idea to make the tests test only functionality
that is available, either through "depends on" in Kconfig, or "#if
IS_ENABLED(...)".  Of course that does not preclude providing a
.kunitconfig to enable and test everything.

Note that net/sunrpc/.kunitconfig has

    CONFIG_RPCSEC_GSS_KRB5_KUNIT_TEST=y

which needs KUNIT_ALL_TESTS=y, else it will still be modular.

First, I tried getting my modular setup working.
After enabling:
    CONFIG_RPCSEC_GSS_KRB5_ENCTYPES_DES=y
    CONFIG_RPCSEC_GSS_KRB5_ENCTYPES_CAMELLIA=y
    CONFIG_RPCSEC_GSS_KRB5_ENCTYPES_AES_SHA2=y
(the former is marked deprecated!)
and loading all needed crypto modules (cfr. the .kunitconfig), I got:

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
    # RFC 3961 key derivation: ASSERTION FAILED at
net/sunrpc/auth_gss/gss_krb5_test.c:62
    Expected err == 0, but
        err == -22 (0xffffffffffffffea)
        not ok 1 des3-hmac-sha1 key derivation case 1
    # RFC 3961 key derivation: ASSERTION FAILED at
net/sunrpc/auth_gss/gss_krb5_test.c:62
    Expected err == 0, but
        err == -22 (0xffffffffffffffea)
        not ok 2 des3-hmac-sha1 key derivation case 2
    # RFC 3961 key derivation: ASSERTION FAILED at
net/sunrpc/auth_gss/gss_krb5_test.c:62
    Expected err == 0, but
        err == -22 (0xffffffffffffffea)
        not ok 3 des3-hmac-sha1 key derivation case 3
    # RFC 3961 key derivation: ASSERTION FAILED at
net/sunrpc/auth_gss/gss_krb5_test.c:62
    Expected err == 0, but
        err == -22 (0xffffffffffffffea)
        not ok 4 des3-hmac-sha1 key derivation case 4
    # RFC 3961 key derivation: ASSERTION FAILED at
net/sunrpc/auth_gss/gss_krb5_test.c:62
    Expected err == 0, but
        err == -22 (0xffffffffffffffea)
        not ok 5 des3-hmac-sha1 key derivation case 5
    # RFC 3961 key derivation: ASSERTION FAILED at
net/sunrpc/auth_gss/gss_krb5_test.c:62
    Expected err == 0, but
        err == -22 (0xffffffffffffffea)
        not ok 6 des3-hmac-sha1 key derivation case 6
    # RFC 3961 key derivation: ASSERTION FAILED at
net/sunrpc/auth_gss/gss_krb5_test.c:62
    Expected err == 0, but
        err == -22 (0xffffffffffffffea)
        not ok 7 des3-hmac-sha1 key derivation case 7
    # RFC 3961 key derivation: ASSERTION FAILED at
net/sunrpc/auth_gss/gss_krb5_test.c:62
    Expected err == 0, but
        err == -22 (0xffffffffffffffea)
        not ok 8 des3-hmac-sha1 key derivation case 8
    # RFC 3961 key derivation: ASSERTION FAILED at
net/sunrpc/auth_gss/gss_krb5_test.c:62
    Expected err == 0, but
        err == -22 (0xffffffffffffffea)
        not ok 9 des3-hmac-sha1 key derivation case 9
    # RFC 3961 key derivation: pass:0 fail:9 skip:0 total:9
    not ok 2 RFC 3961 key derivation
*** CHK ***   FORMAT=2
Current process id is 785
BAD KERNEL TRAP: 00000000
Modules linked in: gss_krb5_test kunit rpcsec_gss_krb5 auth_rpcgss
oid_registry camellia_generic sha512_generic sha1_generic md5 cmac
hmac ecb cts cbc
PC: [<1187775a>] rfc6803_suite+0x2/0xffffc688 [gss_krb5_test]
SR: 2200  SP: efc1339e  a2: 01b4e610
d0: 00000002    d1: 00000010    d2: 00000014    d3: 01b57cc4
d4: 01b57c44    d5: 00000009    a0: 11877754    a1: 01b57c44
Process insmod (pid: 785, task=52ae00a3)
Frame format=2 instr addr=1187775a
Stack from 01b57bd8:
        11869860 00000000 01b57c44 00000000 00000005 00000001 00000000 00000000
        11877e5c 11877e34 11877be8 1186a4d8 1186956e 00000001 00000009 00000000
        00000000 0000000b 01b57cfc 00000001 00000000 00000001 00000002 00000000
        00000000 00000000 00000000 00657333 2d686d61 632d7368 6131206b 65792064
        65726976 6174696f 6e206361 73652039 00000000 484e4f4c 4f475922 29000000
        00000801 000c729c 005d6074 00000000 00040cc0 00040cc0 00000000 00000000
Call Trace: [<11869860>] kunit_run_tests+0x2f2/0x3d2 [kunit]

I.e. -EINVAL later, so something is still missing.

Second, with net/sunrpc/.kunitconfig, and just
CONFIG_RPCSEC_GSS_KRB5_KUNIT_TEST still modular, the tests
succeed, but there is still a crash:

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
*** CHK ***   FORMAT=2
Current process id is 716
BAD KERNEL TRAP: 00000000
Modules linked in: gss_krb5_test
PC: [<1197575a>] rfc6803_suite+0x2/0xffffc688 [gss_krb5_test]
SR: 2200  SP: acd229e8  a2: 01ae20a0
d0: 00000002    d1: 00000010    d2: 00000014    d3: 01ae1cc4
d4: 01ae1c44    d5: 00000000    a0: 11975754    a1: 01ae1c44
Process insmod (pid: 716, task=962b0746)
Frame format=2 instr addr=1197575a
Stack from 01ae1bd8:
        001f3158 00000000 01ae1c44 00000000 00000005 00000001 00000000 00000000
        11975e5c 11975e34 11975be8 001f415c 001f2e66 00000001 00000000 00000000
        00000009 00000014 01ae1cfc 00000002 00000000 00000000 00000002 00000000
        00000000 00000000 00000000 00657333 2d686d61 632d7368 6131206b 65792064
        65726976 6174696f 6e206361 73652039 00000000 484e4f4c 4f475922 29000000
        00000801 000c729c 005db3c4 00000000 00040cc0 00040cc0 00000000 00000000
Call Trace: [<001f3158>] kunit_run_tests+0x2f2/0x3d2

Third, with net/sunrpc/.kunitconfig, and
CONFIG_RPCSEC_GSS_KRB5_KUNIT_TEST=y:

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
ok 31 RFC 3961 tests
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
Unable to handle kernel access at virtual address af06da84
Oops: 00000000
Modules linked in:
PC: [<20746573>] 0x20746573
SR: 2204  SP: 05ef00e4  a2: 010195d0
d0: 00000002    d1: 00000010    d2: 00000006    d3: 0101bdf8
d4: 0101bd78    d5: 00000000    a0: 20746573    a1: 0101bd78
Process swapper (pid: 1, task=b63809d5)
Frame format=7 eff addr=20746573 ssw=0546 faddr=20746573
wb 1 stat/addr/data: 0000 00000000 00000000
wb 2 stat/addr/data: 0000 00000000 00000000
wb 3 stat/addr/data: 0000 20746573 00000000
push data: 00000000 00000000 00000000 00000000
Stack from 0101bd0c:
        001f64b0 00000000 0101bd78 0000001f 00000023 01015480 000359ba 0000209c
        00000000 005890c0 0053aafc 001f7c88 001f61be 00000001 00000000 00000000
        00000006 00000006 0101be30 00000001 00000000 00000000 00000001 00000000
        00000000 00000000 00000000 006e6372 79707420 77697468 20616573 3132382d
        6374732d 686d6163 2d736861 312d3936 20636173 65203600 4f475922 29000000
        00000801 000c886c 006003b4 00000000 00040cc0 00040cc0 00000000 00000000
Call Trace: [<001f64b0>] kunit_run_tests+0x2f2/0x3d2
 [<000359ba>] parse_args+0x0/0x202
 [<0000209c>] do_one_initcall+0x0/0x184
 [<001f7c88>] kunit_debugfs_create_suite+0x0/0x54
 [<001f61be>] kunit_run_tests+0x0/0x3d2
 [<000c886c>] get_page_from_freelist+0x176/0x48a
 [<00040cc0>] __finish_swait+0x1a/0x1c
 [<00040cc0>] __finish_swait+0x1a/0x1c
 [<00040cc0>] __finish_swait+0x1a/0x1c
 [<0000209c>] do_one_initcall+0x0/0x184
 [<000c86f6>] get_page_from_freelist+0x0/0x48a
 [<000c8500>] prepare_alloc_pages.isra.0+0x12/0x84
 [<001f6632>] __kunit_test_suites_init+0xa2/0xfa
 [<003a160c>] _printk+0x0/0x18
 [<001f7b9e>] kunit_run_all_tests+0xd0/0x1a6
 [<0039a0c0>] strcpy+0x0/0x1c
 [<00564602>] kernel_init_freeable+0x152/0x190
 [<000359ba>] parse_args+0x0/0x202
 [<003a6e76>] kernel_init+0x0/0xec
 [<003a6e8a>] kernel_init+0x14/0xec
 [<003a6e76>] kernel_init+0x0/0xec
 [<000028d4>] ret_from_kernel_thread+0xc/0x14

I.e. a slightly different crash.
As the difference between the two crashes is modular vs. builtin,
this looks like an out-of-bound access in the test.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
