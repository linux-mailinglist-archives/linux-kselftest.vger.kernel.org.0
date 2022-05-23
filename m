Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FBF0530763
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 May 2022 04:03:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237016AbiEWCDB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 22 May 2022 22:03:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234027AbiEWCC7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 22 May 2022 22:02:59 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08BCE35AB2;
        Sun, 22 May 2022 19:02:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5E8C1B80CBE;
        Mon, 23 May 2022 02:02:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE23BC385AA;
        Mon, 23 May 2022 02:02:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653271371;
        bh=ERwtvphja6U/1OhlgSfEhE5NLiXGu89oIBPKPKs7U8Q=;
        h=From:To:Cc:Subject:Date:From;
        b=YYroKg8JiImIEyhxQqxr9dwSw6Gvz1uWiyFTs6/Arz+D78M6TjE788dmc4o88D3+C
         yz9ghXro/LMf4BlMmFJJKGCcEc/yLsjL5rV7MjA4Hz2v3iDCB0BmwwzOTY9RPA9avG
         nk14pZu9MJJUMFRvuU+GioRXKmkkvpJxj6j1DzgNG7Id/s3k2fz4KstwpRDeUVGgec
         /lE4TfznmsR1NMdvfmW9HbRP82C815EbADCMxN60Za904DFLaE8qS4X2vIgDRInjq4
         EmvQ0mzLy51/Oxa6eLaoEG5p/QnLNDGqO6RTYT5D24v7d8empSxpr6/M1HyKTSFtSS
         zUUdug5Vel7Kg==
From:   Miguel Ojeda <ojeda@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>, kunit-dev@googlegroups.com,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-um@lists.infradead.org, live-patching@vger.kernel.org
Subject: [PATCH v7 00/25] Rust support
Date:   Mon, 23 May 2022 04:01:13 +0200
Message-Id: <20220523020209.11810-1-ojeda@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Rust support

This is the patch series (v7) to add support for Rust as a second
language to the Linux kernel.

If you are interested in following this effort, please join us in
the mailing list at:

    rust-for-linux@vger.kernel.org

and take a look at the project itself at:

    https://github.com/Rust-for-Linux

As usual, special thanks go to ISRG (Internet Security Research
Group) and Google for their financial support on this endeavor.

Cheers,
Miguel

--

# Rust support

This cover letter explains the major changes and updates done since
the previous ones. For those, please see:

    RFC: https://lore.kernel.org/lkml/20210414184604.23473-1-ojeda@kernel.org/
    v1:  https://lore.kernel.org/lkml/20210704202756.29107-1-ojeda@kernel.org/
    v2:  https://lore.kernel.org/lkml/20211206140313.5653-1-ojeda@kernel.org/
    v3:  https://lore.kernel.org/lkml/20220117053349.6804-1-ojeda@kernel.org/
    v4:  https://lore.kernel.org/lkml/20220212130410.6901-1-ojeda@kernel.org/
    v5:  https://lore.kernel.org/lkml/20220317181032.15436-1-ojeda@kernel.org/
    v6:  https://lore.kernel.org/lkml/20220507052451.12890-1-ojeda@kernel.org/

This is a small round to address the comments made in v6 plus a few
related changes:

  - Added `%pA` to `Documentation/core-api/printk-formats.rst`.

  - Added `checkpatch.pl` patch to search for `%pA` in C code.

  - Added `checkpatch.pl` patch to enable language-independent checks.

  - Added UML (x86_64) support, for KUnit (thanks David Gow!).

  - Added inline licensing information ("Apache-2.0 OR MIT") in
    the commit message of the `alloc` patch, as well as in
    `rust/alloc/README.md` in the following patch.

  - Added SPDX license identifiers to `Documentation/rust/`.

  - Reformatted `Documentation/rust/arch-support.rst` list table
    into simple table.

  - Removed logo from documentation patch; used Linux GIF one for
    the Rust generated docs in its place (to be replaced with
    the SVG one once available).

  - Used `"GPL"` instead of `"GPL v2"` for the `license` field of the
    `module!` macro.

  - Moved `module_misc_device!` macro in `samples/rust/rust_random.rs`
    to the top of the file in `samples/rust/` for consistency.

  - Sorted `#include` lists in `rust/kernel/bindings_helper.h`
    and `rust/helpers.c`.

  - Fixed some English typos.

  - Made the patches more `checkpatch.pl`-clean overall.

  - Picked up Reviewed-by and Acked-by tags.


## Patch series status

The Rust support is still to be considered experimental. However,
support is good enough that kernel developers can start working on the
Rust abstractions for subsystems and write drivers and other modules.

The current series has just arrived in `linux-next`, as usual.
Similarly, the preview docs for this series can be seen at:

    https://rust-for-linux.github.io/docs/kernel/

As usual, please see the following link for the live list of unstable
Rust features we are using:

    https://github.com/Rust-for-Linux/linux/issues/2


## Conferences, meetings and liaisons

We would like to remind everyone about the Rust MC (microconference)
of LPC 2022 (Linux Plumbers Conference):

    https://lpc.events/event/16/contributions/1159/

The Rust MC intends to cover talks and discussions on both Rust for
Linux as well as other non-kernel Rust topics. The Call for Proposals
is open!


## Acknowledgements

The signatures in the main commits correspond to the people that
wrote code that has ended up in them at the present time. For details
on contributions to code and discussions, please see our repository:

    https://github.com/Rust-for-Linux/linux

However, we would like to give credit to everyone that has contributed
in one way or another to the Rust for Linux project. Since the
previous cover letter:

  - Kees Cook for his reviews of some of the v6 patches.

  - David Gow and Brendan Higgins for their reviews of the KUnit
    prerequisite patch and their feedback.

  - Jonathan Corbet and Akira Yokosawa for their review of the
    documentation patch and feedback on documentation rules.

  - Gary Guo for working on improvements to the Rust compiler that
    could make our `static_assert!` macro applicable in more cases.

  - bjorn3 for working on making `rustc_parse_format` compile on
    a stable Rust compiler so that it may be used by lightweight
    formatting systems (for instance, by the kernel).

  - As usual, bjorn3 and Gary Guo for all the input on Rust compiler
    details, reviews and suggestions.

  - Esteban Blanc, Arthur Cohen and Martin Schmidt for rebasing their
    SPI abstraction work.

  - Maciej Falkowski for continuing his work on the Samsung Exynos
    TRNG driver and the required abstractions around it, such as
    adding `delay`, `ktime` and `iopoll` abstractions, new methods
    to `platform::Device` and run-time power management abstractions.

  - Yuheng Su for working on cleaning up the `Module::init` interface.

  - Peng Hao for working on wrapping `mm_struct`.

  - Sergio González Collado for continuing his work on the GitHub CI
    problem matchers.

  - Wei Liu for taking the time to answer questions from newcomers
    in Zulip.

  - Philip Li, Yujie Liu et al. for continuing their work on adding
    Rust support to the Intel 0DAY/LKP kernel test robot.

  - Philip Herron and Arthur Cohen (and his supporters Open Source
    Security and Embecosm) et al. for their ongoing work on GCC Rust.

  - Antoni Boucher (and his supporters) et al. for their ongoing
    work on `rustc_codegen_gcc`.

  - Mats Larsen, Marc Poulhiès et al. for their ongoing work on
    improving Rust support in Compiler Explorer.

  - Many folks that have reported issues, tested the project,
    helped spread the word, joined discussions and contributed in
    other ways!

Please see also the acknowledgements on the previous cover letters.


Boqun Feng (1):
  kallsyms: avoid hardcoding the buffer size

Gary Guo (2):
  rust: add `build_error` crate
  vsprintf: add new `%pA` format specifier

Miguel Ojeda (18):
  kallsyms: support "big" kernel symbols
  kallsyms: increase maximum kernel symbol length to 512
  kunit: take `kunit_assert` as `const`
  rust: add C helpers
  rust: add `compiler_builtins` crate
  rust: import upstream `alloc` crate
  rust: adapt `alloc` crate to the kernel
  rust: add `macros` crate
  rust: export generated symbols
  scripts: checkpatch: diagnose uses of `%pA` in the C side
  scripts: checkpatch: enable language-independent checks for Rust
  scripts: add `rustdoc_test_{builder,gen}.py` scripts
  scripts: add `generate_rust_analyzer.py` scripts
  scripts: decode_stacktrace: demangle Rust symbols
  docs: add Rust documentation
  Kbuild: add Rust support
  samples: add Rust examples
  MAINTAINERS: Rust

Wedson Almeida Filho (4):
  rust: add `kernel` crate's `sync` module
  rust: add `kernel` crate
  [RFC] drivers: gpio: PrimeCell PL061 in Rust
  [RFC] drivers: android: Binder IPC in Rust

 .gitignore                                   |    5 +
 .rustfmt.toml                                |   12 +
 Documentation/core-api/printk-formats.rst    |   10 +
 Documentation/doc-guide/kernel-doc.rst       |    3 +
 Documentation/index.rst                      |    1 +
 Documentation/kbuild/kbuild.rst              |   17 +
 Documentation/kbuild/makefiles.rst           |   50 +-
 Documentation/process/changes.rst            |   41 +
 Documentation/rust/arch-support.rst          |   25 +
 Documentation/rust/coding-guidelines.rst     |  216 ++
 Documentation/rust/general-information.rst   |   79 +
 Documentation/rust/index.rst                 |   22 +
 Documentation/rust/quick-start.rst           |  232 ++
 MAINTAINERS                                  |   15 +
 Makefile                                     |  175 +-
 arch/Kconfig                                 |    6 +
 arch/arm/Kconfig                             |    1 +
 arch/arm64/Kconfig                           |    1 +
 arch/powerpc/Kconfig                         |    1 +
 arch/riscv/Kconfig                           |    1 +
 arch/riscv/Makefile                          |    5 +
 arch/um/Kconfig                              |    1 +
 arch/x86/Kconfig                             |    1 +
 arch/x86/Makefile                            |   14 +
 drivers/android/Kconfig                      |    6 +
 drivers/android/Makefile                     |    2 +
 drivers/android/allocation.rs                |  266 ++
 drivers/android/context.rs                   |   80 +
 drivers/android/defs.rs                      |   99 +
 drivers/android/node.rs                      |  476 +++
 drivers/android/process.rs                   |  960 +++++
 drivers/android/range_alloc.rs               |  189 +
 drivers/android/rust_binder.rs               |  111 +
 drivers/android/thread.rs                    |  870 +++++
 drivers/android/transaction.rs               |  326 ++
 drivers/gpio/Kconfig                         |    8 +
 drivers/gpio/Makefile                        |    1 +
 drivers/gpio/gpio_pl061_rust.rs              |  370 ++
 include/kunit/test.h                         |    2 +-
 include/linux/kallsyms.h                     |    2 +-
 include/linux/spinlock.h                     |   25 +-
 include/uapi/linux/android/binder.h          |   28 +-
 init/Kconfig                                 |   45 +-
 kernel/kallsyms.c                            |   26 +-
 kernel/livepatch/core.c                      |    4 +-
 lib/Kconfig.debug                            |  155 +
 lib/kunit/test.c                             |    4 +-
 lib/vsprintf.c                               |   13 +
 rust/.gitignore                              |   10 +
 rust/Makefile                                |  398 +++
 rust/alloc/README.md                         |   33 +
 rust/alloc/alloc.rs                          |  438 +++
 rust/alloc/borrow.rs                         |  498 +++
 rust/alloc/boxed.rs                          | 2007 +++++++++++
 rust/alloc/collections/mod.rs                |  156 +
 rust/alloc/fmt.rs                            |  601 ++++
 rust/alloc/lib.rs                            |  226 ++
 rust/alloc/macros.rs                         |  127 +
 rust/alloc/raw_vec.rs                        |  567 +++
 rust/alloc/slice.rs                          | 1282 +++++++
 rust/alloc/str.rs                            |  632 ++++
 rust/alloc/string.rs                         | 2869 +++++++++++++++
 rust/alloc/vec/drain.rs                      |  186 +
 rust/alloc/vec/drain_filter.rs               |  145 +
 rust/alloc/vec/into_iter.rs                  |  356 ++
 rust/alloc/vec/is_zero.rs                    |  106 +
 rust/alloc/vec/mod.rs                        | 3362 ++++++++++++++++++
 rust/alloc/vec/partial_eq.rs                 |   49 +
 rust/alloc/vec/set_len_on_drop.rs            |   30 +
 rust/alloc/vec/spec_extend.rs                |  174 +
 rust/bindgen_parameters                      |   17 +
 rust/build_error.rs                          |   29 +
 rust/compiler_builtins.rs                    |   57 +
 rust/exports.c                               |   20 +
 rust/helpers.c                               |  644 ++++
 rust/kernel/allocator.rs                     |   65 +
 rust/kernel/amba.rs                          |  257 ++
 rust/kernel/bindings.rs                      |   47 +
 rust/kernel/bindings_helper.h                |   46 +
 rust/kernel/build_assert.rs                  |   82 +
 rust/kernel/c_types.rs                       |  119 +
 rust/kernel/chrdev.rs                        |  207 ++
 rust/kernel/clk.rs                           |   79 +
 rust/kernel/cred.rs                          |   46 +
 rust/kernel/device.rs                        |  546 +++
 rust/kernel/driver.rs                        |  442 +++
 rust/kernel/error.rs                         |  565 +++
 rust/kernel/file.rs                          |  860 +++++
 rust/kernel/gpio.rs                          |  478 +++
 rust/kernel/hwrng.rs                         |  242 ++
 rust/kernel/io_buffer.rs                     |  153 +
 rust/kernel/io_mem.rs                        |  275 ++
 rust/kernel/iov_iter.rs                      |   81 +
 rust/kernel/irq.rs                           |  411 +++
 rust/kernel/kasync.rs                        |    6 +
 rust/kernel/kasync/net.rs                    |  322 ++
 rust/kernel/kunit.rs                         |   91 +
 rust/kernel/lib.rs                           |  261 ++
 rust/kernel/linked_list.rs                   |  247 ++
 rust/kernel/miscdev.rs                       |  291 ++
 rust/kernel/mm.rs                            |  149 +
 rust/kernel/module_param.rs                  |  498 +++
 rust/kernel/net.rs                           |  392 ++
 rust/kernel/net/filter.rs                    |  447 +++
 rust/kernel/of.rs                            |   63 +
 rust/kernel/pages.rs                         |  144 +
 rust/kernel/platform.rs                      |  223 ++
 rust/kernel/power.rs                         |  118 +
 rust/kernel/prelude.rs                       |   36 +
 rust/kernel/print.rs                         |  405 +++
 rust/kernel/random.rs                        |   42 +
 rust/kernel/raw_list.rs                      |  361 ++
 rust/kernel/rbtree.rs                        |  563 +++
 rust/kernel/revocable.rs                     |  161 +
 rust/kernel/security.rs                      |   38 +
 rust/kernel/static_assert.rs                 |   38 +
 rust/kernel/std_vendor.rs                    |  160 +
 rust/kernel/str.rs                           |  597 ++++
 rust/kernel/sync.rs                          |  161 +
 rust/kernel/sync/arc.rs                      |  503 +++
 rust/kernel/sync/condvar.rs                  |  138 +
 rust/kernel/sync/guard.rs                    |  169 +
 rust/kernel/sync/locked_by.rs                |  111 +
 rust/kernel/sync/mutex.rs                    |  153 +
 rust/kernel/sync/nowait.rs                   |  188 +
 rust/kernel/sync/revocable.rs                |  250 ++
 rust/kernel/sync/rwsem.rs                    |  197 +
 rust/kernel/sync/seqlock.rs                  |  202 ++
 rust/kernel/sync/smutex.rs                   |  295 ++
 rust/kernel/sync/spinlock.rs                 |  360 ++
 rust/kernel/sysctl.rs                        |  199 ++
 rust/kernel/task.rs                          |  175 +
 rust/kernel/types.rs                         |  679 ++++
 rust/kernel/user_ptr.rs                      |  175 +
 rust/macros/helpers.rs                       |   79 +
 rust/macros/lib.rs                           |   94 +
 rust/macros/module.rs                        |  631 ++++
 samples/Kconfig                              |    2 +
 samples/Makefile                             |    1 +
 samples/rust/Kconfig                         |  140 +
 samples/rust/Makefile                        |   16 +
 samples/rust/hostprogs/.gitignore            |    3 +
 samples/rust/hostprogs/Makefile              |    5 +
 samples/rust/hostprogs/a.rs                  |    7 +
 samples/rust/hostprogs/b.rs                  |    5 +
 samples/rust/hostprogs/single.rs             |   12 +
 samples/rust/rust_chrdev.rs                  |   50 +
 samples/rust/rust_minimal.rs                 |   35 +
 samples/rust/rust_miscdev.rs                 |  143 +
 samples/rust/rust_module_parameters.rs       |   69 +
 samples/rust/rust_netfilter.rs               |   54 +
 samples/rust/rust_platform.rs                |   22 +
 samples/rust/rust_print.rs                   |   54 +
 samples/rust/rust_random.rs                  |   60 +
 samples/rust/rust_semaphore.rs               |  171 +
 samples/rust/rust_semaphore_c.c              |  212 ++
 samples/rust/rust_stack_probing.rs           |   36 +
 samples/rust/rust_sync.rs                    |   93 +
 scripts/.gitignore                           |    1 +
 scripts/Kconfig.include                      |    6 +-
 scripts/Makefile                             |    3 +
 scripts/Makefile.build                       |   60 +
 scripts/Makefile.debug                       |   10 +
 scripts/Makefile.host                        |   34 +-
 scripts/Makefile.lib                         |   12 +
 scripts/Makefile.modfinal                    |    8 +-
 scripts/cc-version.sh                        |   12 +-
 scripts/checkpatch.pl                        |    8 +-
 scripts/decode_stacktrace.sh                 |   14 +
 scripts/generate_rust_analyzer.py            |  134 +
 scripts/generate_rust_target.rs              |  227 ++
 scripts/is_rust_module.sh                    |   13 +
 scripts/kallsyms.c                           |   47 +-
 scripts/kconfig/confdata.c                   |   75 +
 scripts/min-tool-version.sh                  |    6 +
 scripts/rust-is-available-bindgen-libclang.h |    2 +
 scripts/rust-is-available.sh                 |  158 +
 scripts/rustdoc_test_builder.py              |   59 +
 scripts/rustdoc_test_gen.py                  |  164 +
 tools/include/linux/kallsyms.h               |    2 +-
 tools/lib/perf/include/perf/event.h          |    2 +-
 tools/lib/symbol/kallsyms.h                  |    2 +-
 182 files changed, 37614 insertions(+), 69 deletions(-)
 create mode 100644 .rustfmt.toml
 create mode 100644 Documentation/rust/arch-support.rst
 create mode 100644 Documentation/rust/coding-guidelines.rst
 create mode 100644 Documentation/rust/general-information.rst
 create mode 100644 Documentation/rust/index.rst
 create mode 100644 Documentation/rust/quick-start.rst
 create mode 100644 drivers/android/allocation.rs
 create mode 100644 drivers/android/context.rs
 create mode 100644 drivers/android/defs.rs
 create mode 100644 drivers/android/node.rs
 create mode 100644 drivers/android/process.rs
 create mode 100644 drivers/android/range_alloc.rs
 create mode 100644 drivers/android/rust_binder.rs
 create mode 100644 drivers/android/thread.rs
 create mode 100644 drivers/android/transaction.rs
 create mode 100644 drivers/gpio/gpio_pl061_rust.rs
 create mode 100644 rust/.gitignore
 create mode 100644 rust/Makefile
 create mode 100644 rust/alloc/README.md
 create mode 100644 rust/alloc/alloc.rs
 create mode 100644 rust/alloc/borrow.rs
 create mode 100644 rust/alloc/boxed.rs
 create mode 100644 rust/alloc/collections/mod.rs
 create mode 100644 rust/alloc/fmt.rs
 create mode 100644 rust/alloc/lib.rs
 create mode 100644 rust/alloc/macros.rs
 create mode 100644 rust/alloc/raw_vec.rs
 create mode 100644 rust/alloc/slice.rs
 create mode 100644 rust/alloc/str.rs
 create mode 100644 rust/alloc/string.rs
 create mode 100644 rust/alloc/vec/drain.rs
 create mode 100644 rust/alloc/vec/drain_filter.rs
 create mode 100644 rust/alloc/vec/into_iter.rs
 create mode 100644 rust/alloc/vec/is_zero.rs
 create mode 100644 rust/alloc/vec/mod.rs
 create mode 100644 rust/alloc/vec/partial_eq.rs
 create mode 100644 rust/alloc/vec/set_len_on_drop.rs
 create mode 100644 rust/alloc/vec/spec_extend.rs
 create mode 100644 rust/bindgen_parameters
 create mode 100644 rust/build_error.rs
 create mode 100644 rust/compiler_builtins.rs
 create mode 100644 rust/exports.c
 create mode 100644 rust/helpers.c
 create mode 100644 rust/kernel/allocator.rs
 create mode 100644 rust/kernel/amba.rs
 create mode 100644 rust/kernel/bindings.rs
 create mode 100644 rust/kernel/bindings_helper.h
 create mode 100644 rust/kernel/build_assert.rs
 create mode 100644 rust/kernel/c_types.rs
 create mode 100644 rust/kernel/chrdev.rs
 create mode 100644 rust/kernel/clk.rs
 create mode 100644 rust/kernel/cred.rs
 create mode 100644 rust/kernel/device.rs
 create mode 100644 rust/kernel/driver.rs
 create mode 100644 rust/kernel/error.rs
 create mode 100644 rust/kernel/file.rs
 create mode 100644 rust/kernel/gpio.rs
 create mode 100644 rust/kernel/hwrng.rs
 create mode 100644 rust/kernel/io_buffer.rs
 create mode 100644 rust/kernel/io_mem.rs
 create mode 100644 rust/kernel/iov_iter.rs
 create mode 100644 rust/kernel/irq.rs
 create mode 100644 rust/kernel/kasync.rs
 create mode 100644 rust/kernel/kasync/net.rs
 create mode 100644 rust/kernel/kunit.rs
 create mode 100644 rust/kernel/lib.rs
 create mode 100644 rust/kernel/linked_list.rs
 create mode 100644 rust/kernel/miscdev.rs
 create mode 100644 rust/kernel/mm.rs
 create mode 100644 rust/kernel/module_param.rs
 create mode 100644 rust/kernel/net.rs
 create mode 100644 rust/kernel/net/filter.rs
 create mode 100644 rust/kernel/of.rs
 create mode 100644 rust/kernel/pages.rs
 create mode 100644 rust/kernel/platform.rs
 create mode 100644 rust/kernel/power.rs
 create mode 100644 rust/kernel/prelude.rs
 create mode 100644 rust/kernel/print.rs
 create mode 100644 rust/kernel/random.rs
 create mode 100644 rust/kernel/raw_list.rs
 create mode 100644 rust/kernel/rbtree.rs
 create mode 100644 rust/kernel/revocable.rs
 create mode 100644 rust/kernel/security.rs
 create mode 100644 rust/kernel/static_assert.rs
 create mode 100644 rust/kernel/std_vendor.rs
 create mode 100644 rust/kernel/str.rs
 create mode 100644 rust/kernel/sync.rs
 create mode 100644 rust/kernel/sync/arc.rs
 create mode 100644 rust/kernel/sync/condvar.rs
 create mode 100644 rust/kernel/sync/guard.rs
 create mode 100644 rust/kernel/sync/locked_by.rs
 create mode 100644 rust/kernel/sync/mutex.rs
 create mode 100644 rust/kernel/sync/nowait.rs
 create mode 100644 rust/kernel/sync/revocable.rs
 create mode 100644 rust/kernel/sync/rwsem.rs
 create mode 100644 rust/kernel/sync/seqlock.rs
 create mode 100644 rust/kernel/sync/smutex.rs
 create mode 100644 rust/kernel/sync/spinlock.rs
 create mode 100644 rust/kernel/sysctl.rs
 create mode 100644 rust/kernel/task.rs
 create mode 100644 rust/kernel/types.rs
 create mode 100644 rust/kernel/user_ptr.rs
 create mode 100644 rust/macros/helpers.rs
 create mode 100644 rust/macros/lib.rs
 create mode 100644 rust/macros/module.rs
 create mode 100644 samples/rust/Kconfig
 create mode 100644 samples/rust/Makefile
 create mode 100644 samples/rust/hostprogs/.gitignore
 create mode 100644 samples/rust/hostprogs/Makefile
 create mode 100644 samples/rust/hostprogs/a.rs
 create mode 100644 samples/rust/hostprogs/b.rs
 create mode 100644 samples/rust/hostprogs/single.rs
 create mode 100644 samples/rust/rust_chrdev.rs
 create mode 100644 samples/rust/rust_minimal.rs
 create mode 100644 samples/rust/rust_miscdev.rs
 create mode 100644 samples/rust/rust_module_parameters.rs
 create mode 100644 samples/rust/rust_netfilter.rs
 create mode 100644 samples/rust/rust_platform.rs
 create mode 100644 samples/rust/rust_print.rs
 create mode 100644 samples/rust/rust_random.rs
 create mode 100644 samples/rust/rust_semaphore.rs
 create mode 100644 samples/rust/rust_semaphore_c.c
 create mode 100644 samples/rust/rust_stack_probing.rs
 create mode 100644 samples/rust/rust_sync.rs
 create mode 100755 scripts/generate_rust_analyzer.py
 create mode 100644 scripts/generate_rust_target.rs
 create mode 100755 scripts/is_rust_module.sh
 create mode 100644 scripts/rust-is-available-bindgen-libclang.h
 create mode 100755 scripts/rust-is-available.sh
 create mode 100755 scripts/rustdoc_test_builder.py
 create mode 100755 scripts/rustdoc_test_gen.py


base-commit: 4b0986a3613c92f4ec1bdc7f60ec66fea135991f
-- 
2.36.1

