Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DD57576DFB
	for <lists+linux-kselftest@lfdr.de>; Sat, 16 Jul 2022 14:42:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231651AbiGPMmY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 16 Jul 2022 08:42:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbiGPMmX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 16 Jul 2022 08:42:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 981DF18385;
        Sat, 16 Jul 2022 05:42:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 50BDCB80108;
        Sat, 16 Jul 2022 12:42:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6CBCC34114;
        Sat, 16 Jul 2022 12:42:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657975340;
        bh=HjF+NeyLSXs/BPREprBA9T9P63b0wfvdyRWiqF26LnM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=u23P2EU6qRL1vu6U1ohiYHNRckhBNC8KYLKdsiszyMvWP2H18PzeER3z0ZoCqs8Oz
         jcDv58i75lMPxVsyThQIDpuusbS1ggqazOvkBjc0XIBMWOOCt6FhnBOHk0SQrwKruJ
         XSo7j0jgJemcDPs9KTaC7peucwxSOMt4rJMAHkA5uwdtU7P3TVe7D9jWyfRcSJNhkk
         ZBSZAiI0ucFmL1fK5Dskz6B94ZFS2WZrK5KXL25yE+Q8WIfgxDRTt01tLNXdu4Q7N8
         DZobomePyEVsHwva8L8DkFKlH7VjnXfoKcEaNJxI9vUeO+aItFS6E/0zfWyfDmlOhH
         6F5kuracHfOdw==
From:   Conor Dooley <conor@kernel.org>
To:     ojeda@kernel.org
Cc:     gregkh@linuxfoundation.org, jarkko@kernel.org,
        kunit-dev@googlegroups.com, linux-arm-kernel@lists.infradead.org,
        linux-doc@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-um@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, live-patching@vger.kernel.org,
        rust-for-linux@vger.kernel.org, torvalds@linux-foundation.org
Subject: Re: [PATCH v7 00/25] Rust support
Date:   Sat, 16 Jul 2022 13:42:14 +0100
Message-Id: <20220716124214.329949-1-conor@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220523020209.11810-1-ojeda@kernel.org>
References: <20220523020209.11810-1-ojeda@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hey,

Maybe I am just missing something blatantly obvious here, but trying
to build rust support in -next fails for me. I am using ClangBuiltLinux
clang version 15.0.0 5b0788fef86ed7008a11f6ee19b9d86d42b6fcfa and LLD
15.0.0. Is it just expected that building -next with rust support is
not a good idea?
My defconfig is the default RISC-V one plus:
CONFIG_RUST=y
CONFIG_SAMPLES=y
CONFIG_SAMPLES_RUST=y
CONFIG_SAMPLE_RUST_MINIMAL=y

Thanks,
Conor.

Fail log:
  UPD     rust/target.json
  BINDGEN rust/bindings_generated.rs
  BINDGEN rust/bindings_helpers_generated.rs
  RUSTC L rust/core.o
  EXPORTS rust/exports_core_generated.h
  RUSTC P rust/libmacros.so
  RUSTC L rust/compiler_builtins.o
  RUSTC L rust/alloc.o
  RUSTC L rust/build_error.o
  EXPORTS rust/exports_alloc_generated.h
  RUSTC L rust/kernel.o
error[E0428]: the name `maple_enode` is defined multiple times
     --> linux/rust/bindings_generated.rs:18009:1
      |
18006 | pub struct maple_enode {
      | ---------------------- previous definition of the type `maple_enode` here
...
18009 | pub type maple_enode = *mut maple_enode;
      | ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ `maple_enode` redefined here
      |
      = note: `maple_enode` must be defined only once in the type namespace of this module

error[E0428]: the name `maple_pnode` is defined multiple times
     --> linux/rust/bindings_generated.rs:18015:1
      |
18012 | pub struct maple_pnode {
      | ---------------------- previous definition of the type `maple_pnode` here
...
18015 | pub type maple_pnode = *mut maple_pnode;
      | ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ `maple_pnode` redefined here
      |
      = note: `maple_pnode` must be defined only once in the type namespace of this module

error[E0391]: cycle detected when expanding type alias `bindings::bindings_raw::maple_pnode`
     --> linux/rust/bindings_generated.rs:18015:29
      |
18015 | pub type maple_pnode = *mut maple_pnode;
      |                             ^^^^^^^^^^^
      |
      = note: ...which immediately requires expanding type alias `bindings::bindings_raw::maple_pnode` again
      = note: type aliases cannot be recursive
      = help: consider using a struct, enum, or union instead to break the cycle
      = help: see <https://doc.rust-lang.org/reference/types.html#recursive-types> for more information
note: cycle used when computing type of `bindings::bindings_raw::maple_range_64::parent`
     --> linux/rust/bindings_generated.rs:18058:22
      |
18058 |     pub parent: *mut maple_pnode,
      |                      ^^^^^^^^^^^

error[E0391]: cycle detected when expanding type alias `bindings::bindings_raw::maple_enode`
     --> linux/rust/bindings_generated.rs:18009:29
      |
18009 | pub type maple_enode = *mut maple_enode;
      |                             ^^^^^^^^^^^
      |
      = note: ...which immediately requires expanding type alias `bindings::bindings_raw::maple_enode` again
      = note: type aliases cannot be recursive
      = help: consider using a struct, enum, or union instead to break the cycle
      = help: see <https://doc.rust-lang.org/reference/types.html#recursive-types> for more information
note: cycle used when computing type of `bindings::bindings_raw::maple_topiary::next`
     --> linux/rust/bindings_generated.rs:18340:20
      |
18340 |     pub next: *mut maple_enode,
      |                    ^^^^^^^^^^^

error[E0117]: only traits defined in the current crate can be implemented for arbitrary types
     --> linux/rust/bindings_generated.rs:18005:10
      |
18005 | #[derive(Copy, Clone)]
      |          ^^^^
      |          |
      |          impl doesn't use only types from inside the current crate
      |          `*mut [type error]` is not defined in the current crate
      |
      = note: define and implement a trait or new type instead
      = note: this error originates in the derive macro `Copy` (in Nightly builds, run with -Z macro-backtrace for more info)

error[E0117]: only traits defined in the current crate can be implemented for arbitrary types
     --> linux/rust/bindings_generated.rs:18011:10
      |
18011 | #[derive(Copy, Clone)]
      |          ^^^^
      |          |
      |          impl doesn't use only types from inside the current crate
      |          `*mut [type error]` is not defined in the current crate
      |
      = note: define and implement a trait or new type instead
      = note: this error originates in the derive macro `Copy` (in Nightly builds, run with -Z macro-backtrace for more info)

error[E0117]: only traits defined in the current crate can be implemented for arbitrary types
     --> linux/rust/bindings_generated.rs:18005:16
      |
18005 | #[derive(Copy, Clone)]
      |                ^^^^^
      |                |
      |                impl doesn't use only types from inside the current crate
      |                `*mut [type error]` is not defined in the current crate
      |
      = note: define and implement a trait or new type instead
      = note: this error originates in the derive macro `Clone` (in Nightly builds, run with -Z macro-backtrace for more info)

error[E0117]: only traits defined in the current crate can be implemented for arbitrary types
     --> linux/rust/bindings_generated.rs:18011:16
      |
18011 | #[derive(Copy, Clone)]
      |                ^^^^^
      |                |
      |                impl doesn't use only types from inside the current crate
      |                `*mut [type error]` is not defined in the current crate
      |
      = note: define and implement a trait or new type instead
      = note: this error originates in the derive macro `Clone` (in Nightly builds, run with -Z macro-backtrace for more info)

error: aborting due to 8 previous errors
