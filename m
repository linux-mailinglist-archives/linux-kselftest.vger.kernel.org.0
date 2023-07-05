Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57401748551
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Jul 2023 15:45:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232225AbjGENpi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 5 Jul 2023 09:45:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232196AbjGENph (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 5 Jul 2023 09:45:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCD3E10EA;
        Wed,  5 Jul 2023 06:45:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0C3DC6156C;
        Wed,  5 Jul 2023 13:45:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F30B0C433C7;
        Wed,  5 Jul 2023 13:45:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688564733;
        bh=2nZc8QuDXQtU0mJQdbBKKU3T4vyKo8XqmVijsQeBb+w=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=HHCNlWJdsDyCfJAqxVw88yhrOEwjE4+AzjYxJ5QdiR8zt2Bq3oevCi7o2fOX30Vs9
         vR4PqMoHxn+Lu2H8Z56jIubA19YmDBfJKFWE6sO4kkMYH0qdo6rsCG7LGu3w3/RN4t
         XIgbDrYMp/K5PeAmItfPHIpVfVuLJy2b65tmxMT0o3IqOBb4eVUNsNj/EjOrEB7Lms
         Ki+JeSy0W8UmVOzyslNJUj5BvAD4YWTGpWbPcxD71SfAeh4OxhX8/nv0wdNMxK1fTd
         b4Gj68qHZOwIh2u5ghqhV5kuA1UFfeWvCE/zKBicWXuF9rz5rWJUVEzb4ZcddFTEAc
         QJIN5x6a71C0A==
From:   =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To:     Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>, bpf@vger.kernel.org,
        netdev@vger.kernel.org
Cc:     =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>,
        Alexei Starovoitov <ast@kernel.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH bpf-next 0/2] BPF kselftest cross-build/RISC-V fixes
In-Reply-To: <9ee053a4-500c-2722-d822-d137648e55e5@iogearbox.net>
References: <20230705113926.751791-1-bjorn@kernel.org>
 <9ee053a4-500c-2722-d822-d137648e55e5@iogearbox.net>
Date:   Wed, 05 Jul 2023 15:45:30 +0200
Message-ID: <87bkgqtqth.fsf@all.your.base.are.belong.to.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Daniel Borkmann <daniel@iogearbox.net> writes:

> On 7/5/23 1:39 PM, Bj=C3=B6rn T=C3=B6pel wrote:
>> From: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
>>=20
>> This series has two minor fixes, found when cross-compiling for the
>> RISC-V architecture.
>>=20
>> Some RISC-V systems do not define HAVE_EFFICIENT_UNALIGNED_ACCESS,
>> which made some of tests bail out. Fix the failing tests by adding
>> F_NEEDS_EFFICIENT_UNALIGNED_ACCESS.
>>=20
>> ...and some RISC-V systems *do* define
>> HAVE_EFFICIENT_UNALIGNED_ACCESS. In this case the autoconf.h was not
>> correctly picked up by the build system.
>
> Looks good, applied thanks!=20

Thank you!

> Any plans on working towards integrating riscv into upstream BPF CI?
> Would love to see that happening. :)

Yes! I started hacking a bit on that some time back:

  https://github.com/libbpf/ci/pull/87
  https://github.com/kernel-patches/vmtest/pull/194

(TL;DR: I'll continuing that work at some point.)

RISC-V still needs cross-compilation, and testing on qemu/TCG (on
typically x86-hosts), which puts some constraints on the
rootfs/cross-compilation host; For RISC-V Debian Bullseye is way too old
(a lot packages are missing/broken). Typically for BPF it would be
Ubuntu Kinetic (or later), or some Debian Sid snapshot.

The rootfs, the host, and the host foreign arch would need to be the
same for "no-hassle cross-compilation on Debian derivatives" -- and at
least younger than "Ubuntu Kinetic"-age.

AFAIU, there are some issues with rootfs version and build host
versioning for other archs as well: https://github.com/libbpf/ci/pull/83


Bj=C3=B6rn
