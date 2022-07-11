Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05C92570612
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Jul 2022 16:47:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231669AbiGKOrD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 11 Jul 2022 10:47:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231678AbiGKOrC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 11 Jul 2022 10:47:02 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ED4A6D2EC;
        Mon, 11 Jul 2022 07:46:57 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id B49515C0118;
        Mon, 11 Jul 2022 10:46:55 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 11 Jul 2022 10:46:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1657550815; x=1657637215; bh=D5TPwGuYkl
        d4skWWJ3d7Y7bzOGmBlqbTLop3Zhf6oA0=; b=rUqMvV3s5zwY0I3OumS1+X8Hd5
        Wq+nz9ZQbgF7ExJhHz+KqA7XWZIMKAk00s96SPbs9He5fh4rg8+8JwkC90/1g3wX
        2VO5CtdbwFHTywsn0csNm84Ci36f0MExp1bmTjI8EVk49B8yCdPVO/KbE1u7MLkz
        tqzONuYgt+02gmz69Wtw/fGwUZmmoc7KVK+IZY+h9SJZG8G3x8n++ytCQcS8WCkI
        zR5EtYbMs/+/AqSIXd5NPNcIPof8gJWKv3LQiL9eiS52kaSWtXSjkSdMl66NWUXA
        3aidWW0iKP1KVJNrSpjfP5eZSTdQ5ANrBgbn0vjDH7JNF+avb4tqS+129vHQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1657550815; x=1657637215; bh=D5TPwGuYkld4skWWJ3d7Y7bzOGmB
        lqbTLop3Zhf6oA0=; b=CZbEo2HvFOj4OJLKjTi8H4K6/Ov47f8UoZFcVJ7pfBIf
        zS/Y9ypnWLmrCyLdN1pbNoffpuJm1mtwYPUwNffZYuFUwzReLKD1eaAZSB295o5c
        JoovXK2LprFERY3EUbGUu40scEqh/qlcKPiEYu+Qgj/9iWuATDRLzV1dyipHsdZb
        puFJhosKJ4Uj2NNom8Zin7YooYAEZJQo6g1aV4Zuk1PeSHMCqbzTHjXSdMF4g339
        bPfsbUZX6aQuRG2Qbsj3viHZlcL1//aodE34179JELN8Z99bH1JGCmeKeXJ+z73D
        znMBwDfBtRQCyeDf2oIBxTO1d3Z0OdNhjOx/RWmBXg==
X-ME-Sender: <xms:3jfMYmx6J16BofQKOaURrHyBTVqGARGXwhy-D67WiZsx4TLlnh0LIQ>
    <xme:3jfMYiREUlqLfwTmJ_3tVFBnbHCoEufFs4s5rR2VG7Ph5cpqMoqMw8zWfdXcSpScN
    sTN7JUBOb1iy-7A0zA>
X-ME-Received: <xmr:3jfMYoWzz14SXPHsjbYbzL4v7d5sKLXIhlGtQfGKp5hSpSeMSJuLm0od6VUNPRd7s5d-jbATl98dlo0YoCbkMEq3UBpGwv_8rBNskOo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudejfedgjeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtudenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpeejveefheefkeeiffegveelveetgffffeektdefuefhtedtgeejhefggedu
    ffffudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:3zfMYshZOBNuAZY6x9PC119B8UZgoyFM0UazFHyVZaBQ2pqHwM057Q>
    <xmx:3zfMYoCuS0AmTpJPnGgKjKk0RPOr0tOZoF983u55NzuHqCbXpfNTLA>
    <xmx:3zfMYtLo5r3K11J-QK8rYyBJx6UQ6ImKQNKigr1FoqRM16FzTuXLRQ>
    <xmx:3zfMYot8tx08nHL3wpMDlCc0tdAcJZnuznjvK4-ubzf1c-17Tl0fGw>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Jul 2022 10:46:54 -0400 (EDT)
Date:   Mon, 11 Jul 2022 16:46:51 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Daniel Latypov <dlatypov@google.com>
Cc:     brendanhiggins@google.com, davidgow@google.com,
        linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org,
        =?utf-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>,
        Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org
Subject: Re: [PATCH v3] kunit: tool: Enable virtio/PCI by default on UML
Message-ID: <20220711144651.yekrivauz3phkuvm@houat>
References: <20220708162711.1309633-1-dlatypov@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="chwcydxziidfgakt"
Content-Disposition: inline
In-Reply-To: <20220708162711.1309633-1-dlatypov@google.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--chwcydxziidfgakt
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi David, Daniel,

On Fri, Jul 08, 2022 at 04:27:11PM +0000, Daniel Latypov wrote:
> From: David Gow <davidgow@google.com>
>=20
> There are several tests which depend on PCI, and hence need a bunch of
> extra options to run under UML. This makes it awkward to give
> configuration instructions (whether in documentation, or as part of a
> .kunitconfig file), as two separate, incompatible sets of config options
> are required for UML and "most other architectures".
>=20
> For non-UML architectures, it's possible to add default kconfig options
> via the qemu_config python files, but there's no equivalent for UML. Add
> a new tools/testing/kunit/configs/arch_uml.config file containing extra
> kconfig options to use on UML.
>=20
> Tested-by: Jos=E9 Exp=F3sito <jose.exposito89@gmail.com>
> Reviewed-by: Daniel Latypov <dlatypov@google.com>
> Signed-off-by: David Gow <davidgow@google.com>
> Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>

Unfortunately, this breaks the clock tests in next-20220711:
$ ./tools/testing/kunit/kunit.py run --kunitconfig=3Ddrivers/clk/.kunitconf=
ig  --raw_output
[16:45:52] Configuring KUnit Kernel ...
Regenerating .config ...
Populating config with:
$ make ARCH=3Dum O=3D.kunit olddefconfig
[16:45:53] Building KUnit Kernel ...
Populating config with:
$ make ARCH=3Dum O=3D.kunit olddefconfig
Building with:
$ make ARCH=3Dum O=3D.kunit --jobs=3D16
[16:45:58] Starting KUnit Kernel (1/1)...
TAP version 14
1..10
# Subtest: clk-test
1..4
ok 1 - clk_test_get_rate
ok 2 - clk_test_set_get_rate
ok 3 - clk_test_set_set_get_rate
ok 4 - clk_test_round_set_get_rate
# clk-test: pass:4 fail:0 skip:0 total:4
# Totals: pass:4 fail:0 skip:0 total:4
ok 1 - clk-test
# Subtest: clk-orphan-transparent-single-parent-test
1..1
ok 1 - clk_test_orphan_transparent_parent_mux_set_range
ok 2 - clk-orphan-transparent-single-parent-test
# Subtest: clk-range-test
1..11
ok 1 - clk_range_test_set_range
clk_set_rate_range: clk test_dummy_rate dev (null) con (null): invalid rang=
e [142001000, 142000000]
ok 2 - clk_range_test_set_range_invalid
ok 3 - clk_range_test_multiple_disjoints_range
ok 4 - clk_range_test_set_range_round_rate_lower
ok 5 - clk_range_test_set_range_set_rate_lower
ok 6 - clk_range_test_set_range_set_round_rate_consistent_lower
ok 7 - clk_range_test_set_range_round_rate_higher
ok 8 - clk_range_test_set_range_set_rate_higher
ok 9 - clk_range_test_set_range_set_round_rate_consistent_higher
ok 10 - clk_range_test_set_range_get_rate_raised
ok 11 - clk_range_test_set_range_get_rate_lowered
# clk-range-test: pass:11 fail:0 skip:0 total:11
# Totals: pass:11 fail:0 skip:0 total:11
ok 3 - clk-range-test
# Subtest: clk-range-maximize-test
1..2
ok 1 - clk_range_test_set_range_rate_maximized
ok 2 - clk_range_test_multiple_set_range_rate_maximized
# clk-range-maximize-test: pass:2 fail:0 skip:0 total:2
# Totals: pass:2 fail:0 skip:0 total:2
ok 4 - clk-range-maximize-test
# Subtest: clk-range-minimize-test
1..2
ok 1 - clk_range_test_set_range_rate_minimized
ok 2 - clk_range_test_multiple_set_range_rate_minimized
# clk-range-minimize-test: pass:2 fail:0 skip:0 total:2
# Totals: pass:2 fail:0 skip:0 total:2
ok 5 - clk-range-minimize-test
# Subtest: clk-gate-register-test
1..6
ok 1 - clk_gate_register_test_dev
ok 2 - clk_gate_register_test_parent_names
ok 3 - clk_gate_register_test_parent_data
ok 4 - clk_gate_register_test_parent_data_legacy
ok 5 - clk_gate_register_test_parent_hw
gate bit exceeds LOWORD field
ok 6 - clk_gate_register_test_hiword_invalid
# clk-gate-register-test: pass:6 fail:0 skip:0 total:6
# Totals: pass:6 fail:0 skip:0 total:6
ok 6 - clk-gate-register-test
# Subtest: clk-gate-test
1..3
ok 1 - clk_gate_test_parent_rate
------------[ cut here ]------------
WARNING: CPU: 0 PID: 45 at lib/logic_iomem.c:141 __raw_readl+0x9f/0xd0
CPU: 0 PID: 45 Comm: kunit_try_catch Tainted: G        W        N 5.19.0-rc=
1-00014-g6fc3a8636a7b #165
Stack:
6030a5b6 60277543 60350943 6030a5b6
6002a000 00000000 0000008d 6031ccb0
a088bd08 60294456 00000000 00000000
Call Trace:
[<6002a000>] ? um_set_signals+0x0/0x50
[<60294456>] ? dump_stack_lvl+0x44/0x50
[<60277543>] ? _printk+0x0/0x9b
[<60274ddb>] ? __warn.cold+0x33/0xa3
[<60274f24>] ? warn_slowpath_fmt+0xd9/0xe9
[<601ececa>] ? clk_core_lookup+0x5a/0x150
[<601ec370>] ? clk_prepare_unlock+0x0/0x100
[<601ee953>] ? __clk_register+0x8c3/0xb50
[<601f0d95>] ? clk_hw_register+0x15/0x30
[<60274e4b>] ? warn_slowpath_fmt+0x0/0xe9
[<60264b3f>] ? __raw_readl+0x9f/0xd0
[<601f68bd>] ? clk_gate_endisable+0xcd/0x110
[<601f6925>] ? clk_gate_enable+0x15/0x20
[<601ec147>] ? clk_core_enable+0x57/0xc0
[<601efb0e>] ? clk_enable+0x2e/0x50
[<601f8ccf>] ? clk_gate_test_enable+0xff/0x2f0
[<60295990>] ? schedule_preempt_disabled+0x0/0x20
[<60063aa0>] ? complete+0x0/0x70
[<601bff9d>] ? kunit_try_run_case+0x4d/0x80
[<60295855>] ? schedule+0x55/0x100
[<601c0d90>] ? kunit_generic_run_threadfn_adapter+0x0/0x20
[<601c0d9b>] ? kunit_generic_run_threadfn_adapter+0xb/0x20
[<60054364>] ? kthread+0xf4/0x150
[<60019e42>] ? new_thread_handler+0x82/0xc0
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
WARNING: CPU: 0 PID: 45 at lib/logic_iomem.c:190 __raw_readl+0xbd/0xd0
Invalid readl at address 60c057d8
CPU: 0 PID: 45 Comm: kunit_try_catch Tainted: G        W        N 5.19.0-rc=
1-00014-g6fc3a8636a7b #165
Stack:
6030a5b6 60277543 60350943 6030a5b6
6002a000 00000000 000000be 6031ccb0
a088bd08 60294456 a088bd50 00000000
Call Trace:
[<6002a000>] ? um_set_signals+0x0/0x50
[<60294456>] ? dump_stack_lvl+0x44/0x50
[<60277543>] ? _printk+0x0/0x9b
[<60274ddb>] ? __warn.cold+0x33/0xa3
[<60274f24>] ? warn_slowpath_fmt+0xd9/0xe9
[<601ececa>] ? clk_core_lookup+0x5a/0x150
[<601ec370>] ? clk_prepare_unlock+0x0/0x100
[<601ee953>] ? __clk_register+0x8c3/0xb50
[<601f0d95>] ? clk_hw_register+0x15/0x30
[<60274e4b>] ? warn_slowpath_fmt+0x0/0xe9
[<60264b5d>] ? __raw_readl+0xbd/0xd0
[<601f68bd>] ? clk_gate_endisable+0xcd/0x110
[<601f6925>] ? clk_gate_enable+0x15/0x20
[<601ec147>] ? clk_core_enable+0x57/0xc0
[<601efb0e>] ? clk_enable+0x2e/0x50
[<601f8ccf>] ? clk_gate_test_enable+0xff/0x2f0
[<60295990>] ? schedule_preempt_disabled+0x0/0x20
[<60063aa0>] ? complete+0x0/0x70
[<601bff9d>] ? kunit_try_run_case+0x4d/0x80
[<60295855>] ? schedule+0x55/0x100
[<601c0d90>] ? kunit_generic_run_threadfn_adapter+0x0/0x20
[<601c0d9b>] ? kunit_generic_run_threadfn_adapter+0xb/0x20
[<60054364>] ? kthread+0xf4/0x150
[<60019e42>] ? new_thread_handler+0x82/0xc0
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
WARNING: CPU: 0 PID: 45 at lib/logic_iomem.c:141 __raw_writel+0xb0/0xe0
CPU: 0 PID: 45 Comm: kunit_try_catch Tainted: G        W        N 5.19.0-rc=
1-00014-g6fc3a8636a7b #165
Stack:
6030a5b6 60277543 60350943 6030a5b6
6002a000 00000000 0000008d 6031ccb0
a088bcf8 60294456 00000000 00000000
Call Trace:
[<6002a000>] ? um_set_signals+0x0/0x50
[<60294456>] ? dump_stack_lvl+0x44/0x50
[<60277543>] ? _printk+0x0/0x9b
[<60274ddb>] ? __warn.cold+0x33/0xa3
[<60277543>] ? _printk+0x0/0x9b
[<60274f24>] ? warn_slowpath_fmt+0xd9/0xe9
[<601ececa>] ? clk_core_lookup+0x5a/0x150
[<601ee953>] ? __clk_register+0x8c3/0xb50
[<60274e4b>] ? warn_slowpath_fmt+0x0/0xe9
[<60264c20>] ? __raw_writel+0xb0/0xe0
[<601f689f>] ? clk_gate_endisable+0xaf/0x110
[<601f6925>] ? clk_gate_enable+0x15/0x20
[<601ec147>] ? clk_core_enable+0x57/0xc0
[<601efb0e>] ? clk_enable+0x2e/0x50
[<601f8ccf>] ? clk_gate_test_enable+0xff/0x2f0
[<60295990>] ? schedule_preempt_disabled+0x0/0x20
[<60063aa0>] ? complete+0x0/0x70
[<601bff9d>] ? kunit_try_run_case+0x4d/0x80
[<60295855>] ? schedule+0x55/0x100
[<601c0d90>] ? kunit_generic_run_threadfn_adapter+0x0/0x20
[<601c0d9b>] ? kunit_generic_run_threadfn_adapter+0xb/0x20
[<60054364>] ? kthread+0xf4/0x150
[<60019e42>] ? new_thread_handler+0x82/0xc0
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
WARNING: CPU: 0 PID: 45 at lib/logic_iomem.c:190 clk_gate_endisable+0xaf/0x=
110
Invalid writeql of 0xffffffff at address 60c057d8
CPU: 0 PID: 45 Comm: kunit_try_catch Tainted: G        W        N 5.19.0-rc=
1-00014-g6fc3a8636a7b #165
Stack:
6030a5b6 60277543 60350943 6030a5b6
6002a000 00000000 000000be 6031ccb0
a088bd28 60294456 a088bd70 00000000
Call Trace:
[<6002a000>] ? um_set_signals+0x0/0x50
[<60294456>] ? dump_stack_lvl+0x44/0x50
[<60277543>] ? _printk+0x0/0x9b
[<60274ddb>] ? __warn.cold+0x33/0xa3
[<60274f24>] ? warn_slowpath_fmt+0xd9/0xe9
[<601ee953>] ? __clk_register+0x8c3/0xb50
[<60274e4b>] ? warn_slowpath_fmt+0x0/0xe9
[<60264c20>] ? __raw_writel+0xb0/0xe0
[<601f689f>] ? clk_gate_endisable+0xaf/0x110
[<601f6925>] ? clk_gate_enable+0x15/0x20
[<601ec147>] ? clk_core_enable+0x57/0xc0
[<601efb0e>] ? clk_enable+0x2e/0x50
[<601f8ccf>] ? clk_gate_test_enable+0xff/0x2f0
[<60295990>] ? schedule_preempt_disabled+0x0/0x20
[<60063aa0>] ? complete+0x0/0x70
[<601bff9d>] ? kunit_try_run_case+0x4d/0x80
[<60295855>] ? schedule+0x55/0x100
[<601c0d90>] ? kunit_generic_run_threadfn_adapter+0x0/0x20
[<601c0d9b>] ? kunit_generic_run_threadfn_adapter+0xb/0x20
[<60054364>] ? kthread+0xf4/0x150
[<60019e42>] ? new_thread_handler+0x82/0xc0
---[ end trace 0000000000000000 ]---
# clk_gate_test_enable: EXPECTATION FAILED at drivers/clk/clk-gate_test.c:1=
69
Expected enable_val =3D=3D ctx->fake_reg, but
enable_val =3D=3D 32
ctx->fake_reg =3D=3D 0
------------[ cut here ]------------
WARNING: CPU: 0 PID: 45 at lib/logic_iomem.c:141 __raw_readl+0x9f/0xd0
CPU: 0 PID: 45 Comm: kunit_try_catch Tainted: G        W        N 5.19.0-rc=
1-00014-g6fc3a8636a7b #165
Stack:
6030a5b6 60277543 60350943 6030a5b6
6002a000 00000001 0000008d 6031ccb0
a088bd58 60294456 00000000 00000000
Call Trace:
[<6002a000>] ? um_set_signals+0x0/0x50
[<60294456>] ? dump_stack_lvl+0x44/0x50
[<60277543>] ? _printk+0x0/0x9b
[<60274ddb>] ? __warn.cold+0x33/0xa3
[<601c0280>] ? kunit_resource_instance_match+0x0/0x10
[<60274f24>] ? warn_slowpath_fmt+0xd9/0xe9
[<601bfdc0>] ? kunit_do_failed_assertion+0x100/0x1c0
[<601c022c>] ? kunit_destroy_resource+0x10c/0x160
[<60274e4b>] ? warn_slowpath_fmt+0x0/0xe9
[<601bfcc0>] ? kunit_do_failed_assertion+0x0/0x1c0
[<60264c20>] ? __raw_writel+0xb0/0xe0
[<60274e4b>] ? warn_slowpath_fmt+0x0/0xe9
[<601ef400>] ? clk_hw_is_enabled+0x0/0x10
[<60264b3f>] ? __raw_readl+0x9f/0xd0
[<601f694a>] ? clk_gate_is_enabled+0x1a/0x50
[<601ebf42>] ? clk_core_is_enabled+0x22/0xb0
[<601f8c77>] ? clk_gate_test_enable+0xa7/0x2f0
[<601c0ad0>] ? kunit_binary_assert_format+0x0/0x100
[<60063aa0>] ? complete+0x0/0x70
[<601bff9d>] ? kunit_try_run_case+0x4d/0x80
[<60295855>] ? schedule+0x55/0x100
[<601c0d90>] ? kunit_generic_run_threadfn_adapter+0x0/0x20
[<601c0d9b>] ? kunit_generic_run_threadfn_adapter+0xb/0x20
[<60054364>] ? kthread+0xf4/0x150
[<60019e42>] ? new_thread_handler+0x82/0xc0
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
WARNING: CPU: 0 PID: 45 at lib/logic_iomem.c:190 __raw_readl+0xbd/0xd0
Invalid readl at address 60c057d8
CPU: 0 PID: 45 Comm: kunit_try_catch Tainted: G        W        N 5.19.0-rc=
1-00014-g6fc3a8636a7b #165
Stack:
6030a5b6 60277543 60350943 6030a5b6
6002a000 00000001 000000be 6031ccb0
a088bd58 60294456 a088bda0 00000000
Call Trace:
[<6002a000>] ? um_set_signals+0x0/0x50
[<60294456>] ? dump_stack_lvl+0x44/0x50
[<60277543>] ? _printk+0x0/0x9b
[<60274ddb>] ? __warn.cold+0x33/0xa3
[<601c0280>] ? kunit_resource_instance_match+0x0/0x10
[<60274f24>] ? warn_slowpath_fmt+0xd9/0xe9
[<601bfdc0>] ? kunit_do_failed_assertion+0x100/0x1c0
[<60274e4b>] ? warn_slowpath_fmt+0x0/0xe9
[<601bfcc0>] ? kunit_do_failed_assertion+0x0/0x1c0
[<60264c20>] ? __raw_writel+0xb0/0xe0
[<60274e4b>] ? warn_slowpath_fmt+0x0/0xe9
[<601ef400>] ? clk_hw_is_enabled+0x0/0x10
[<60264b5d>] ? __raw_readl+0xbd/0xd0
[<601f694a>] ? clk_gate_is_enabled+0x1a/0x50
[<601ebf42>] ? clk_core_is_enabled+0x22/0xb0
[<601f8c77>] ? clk_gate_test_enable+0xa7/0x2f0
[<601c0ad0>] ? kunit_binary_assert_format+0x0/0x100
[<60063aa0>] ? complete+0x0/0x70
[<601bff9d>] ? kunit_try_run_case+0x4d/0x80
[<60295855>] ? schedule+0x55/0x100
[<601c0d90>] ? kunit_generic_run_threadfn_adapter+0x0/0x20
[<601c0d9b>] ? kunit_generic_run_threadfn_adapter+0xb/0x20
[<60054364>] ? kthread+0xf4/0x150
[<60019e42>] ? new_thread_handler+0x82/0xc0
---[ end trace 0000000000000000 ]---
clk_unregister: unregistering prepared clock: test_gate
clk_unregister: unregistering prepared clock: test_parent
not ok 2 - clk_gate_test_enable
------------[ cut here ]------------
WARNING: CPU: 0 PID: 46 at lib/logic_iomem.c:141 __raw_readl+0x9f/0xd0
CPU: 0 PID: 46 Comm: kunit_try_catch Tainted: G        W        N 5.19.0-rc=
1-00014-g6fc3a8636a7b #165
Stack:
6030a5b6 60277543 60350943 6030a5b6
6002a000 00000000 0000008d 6031ccb0
a088bcf8 60294456 00000000 00000000
Call Trace:
[<6002a000>] ? um_set_signals+0x0/0x50
[<60294456>] ? dump_stack_lvl+0x44/0x50
[<60277543>] ? _printk+0x0/0x9b
[<60274ddb>] ? __warn.cold+0x33/0xa3
[<601ef880>] ? clk_unprepare+0x0/0x50
[<60274f24>] ? warn_slowpath_fmt+0xd9/0xe9
[<601ee1bb>] ? __clk_register+0x12b/0xb50
[<601ececa>] ? clk_core_lookup+0x5a/0x150
[<601ec370>] ? clk_prepare_unlock+0x0/0x100
[<601ee953>] ? __clk_register+0x8c3/0xb50
[<60274e4b>] ? warn_slowpath_fmt+0x0/0xe9
[<60264b3f>] ? __raw_readl+0x9f/0xd0
[<601f68bd>] ? clk_gate_endisable+0xcd/0x110
[<601f6925>] ? clk_gate_enable+0x15/0x20
[<601ec147>] ? clk_core_enable+0x57/0xc0
[<601efb0e>] ? clk_enable+0x2e/0x50
[<601f80cf>] ? clk_gate_test_disable+0x12f/0x390
[<60295990>] ? schedule_preempt_disabled+0x0/0x20
[<60063aa0>] ? complete+0x0/0x70
[<601bff9d>] ? kunit_try_run_case+0x4d/0x80
[<60295855>] ? schedule+0x55/0x100
[<601c0d90>] ? kunit_generic_run_threadfn_adapter+0x0/0x20
[<601c0d9b>] ? kunit_generic_run_threadfn_adapter+0xb/0x20
[<60054364>] ? kthread+0xf4/0x150
[<60019e42>] ? new_thread_handler+0x82/0xc0
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
WARNING: CPU: 0 PID: 46 at lib/logic_iomem.c:190 __raw_readl+0xbd/0xd0
Invalid readl at address 60c057d8
CPU: 0 PID: 46 Comm: kunit_try_catch Tainted: G        W        N 5.19.0-rc=
1-00014-g6fc3a8636a7b #165
Stack:
6030a5b6 60277543 60350943 6030a5b6
6002a000 00000000 000000be 6031ccb0
a088bcf8 60294456 a088bd40 00000000
Call Trace:
[<6002a000>] ? um_set_signals+0x0/0x50
[<60294456>] ? dump_stack_lvl+0x44/0x50
[<60277543>] ? _printk+0x0/0x9b
[<60274ddb>] ? __warn.cold+0x33/0xa3
[<601ef880>] ? clk_unprepare+0x0/0x50
[<60274f24>] ? warn_slowpath_fmt+0xd9/0xe9
[<601ee1bb>] ? __clk_register+0x12b/0xb50
[<601ececa>] ? clk_core_lookup+0x5a/0x150
[<601ec370>] ? clk_prepare_unlock+0x0/0x100
[<601ee953>] ? __clk_register+0x8c3/0xb50
[<60274e4b>] ? warn_slowpath_fmt+0x0/0xe9
[<60264b5d>] ? __raw_readl+0xbd/0xd0
[<601f68bd>] ? clk_gate_endisable+0xcd/0x110
[<601f6925>] ? clk_gate_enable+0x15/0x20
[<601ec147>] ? clk_core_enable+0x57/0xc0
[<601efb0e>] ? clk_enable+0x2e/0x50
[<601f80cf>] ? clk_gate_test_disable+0x12f/0x390
[<60295990>] ? schedule_preempt_disabled+0x0/0x20
[<60063aa0>] ? complete+0x0/0x70
[<601bff9d>] ? kunit_try_run_case+0x4d/0x80
[<60295855>] ? schedule+0x55/0x100
[<601c0d90>] ? kunit_generic_run_threadfn_adapter+0x0/0x20
[<601c0d9b>] ? kunit_generic_run_threadfn_adapter+0xb/0x20
[<60054364>] ? kthread+0xf4/0x150
[<60019e42>] ? new_thread_handler+0x82/0xc0
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
WARNING: CPU: 0 PID: 46 at lib/logic_iomem.c:141 __raw_writel+0xb0/0xe0
CPU: 0 PID: 46 Comm: kunit_try_catch Tainted: G        W        N 5.19.0-rc=
1-00014-g6fc3a8636a7b #165
Stack:
6030a5b6 60277543 60350943 6030a5b6
6002a000 00000000 0000008d 6031ccb0
a088bce8 60294456 00000000 00000000
Call Trace:
[<6002a000>] ? um_set_signals+0x0/0x50
[<60294456>] ? dump_stack_lvl+0x44/0x50
[<60277543>] ? _printk+0x0/0x9b
[<60274ddb>] ? __warn.cold+0x33/0xa3
[<60277543>] ? _printk+0x0/0x9b
[<601ef880>] ? clk_unprepare+0x0/0x50
[<60274f24>] ? warn_slowpath_fmt+0xd9/0xe9
[<601ee1bb>] ? __clk_register+0x12b/0xb50
[<601ec370>] ? clk_prepare_unlock+0x0/0x100
[<601ee953>] ? __clk_register+0x8c3/0xb50
[<60274e4b>] ? warn_slowpath_fmt+0x0/0xe9
[<60264c20>] ? __raw_writel+0xb0/0xe0
[<601f689f>] ? clk_gate_endisable+0xaf/0x110
[<601f6925>] ? clk_gate_enable+0x15/0x20
[<601ec147>] ? clk_core_enable+0x57/0xc0
[<601efb0e>] ? clk_enable+0x2e/0x50
[<601f80cf>] ? clk_gate_test_disable+0x12f/0x390
[<60295990>] ? schedule_preempt_disabled+0x0/0x20
[<60063aa0>] ? complete+0x0/0x70
[<601bff9d>] ? kunit_try_run_case+0x4d/0x80
[<60295855>] ? schedule+0x55/0x100
[<601c0d90>] ? kunit_generic_run_threadfn_adapter+0x0/0x20
[<601c0d9b>] ? kunit_generic_run_threadfn_adapter+0xb/0x20
[<60054364>] ? kthread+0xf4/0x150
[<60019e42>] ? new_thread_handler+0x82/0xc0
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
WARNING: CPU: 0 PID: 46 at lib/logic_iomem.c:190 clk_gate_endisable+0xaf/0x=
110
Invalid writeql of 0xffffffff at address 60c057d8
CPU: 0 PID: 46 Comm: kunit_try_catch Tainted: G        W        N 5.19.0-rc=
1-00014-g6fc3a8636a7b #165
Stack:
6030a5b6 60277543 60350943 6030a5b6
6002a000 00000000 000000be 6031ccb0
a088bd18 60294456 a088bd60 00000000
Call Trace:
[<6002a000>] ? um_set_signals+0x0/0x50
[<60294456>] ? dump_stack_lvl+0x44/0x50
[<60277543>] ? _printk+0x0/0x9b
[<60274ddb>] ? __warn.cold+0x33/0xa3
[<601ef880>] ? clk_unprepare+0x0/0x50
[<601ef880>] ? clk_unprepare+0x0/0x50
[<60274f24>] ? warn_slowpath_fmt+0xd9/0xe9
[<601ec370>] ? clk_prepare_unlock+0x0/0x100
[<60274e4b>] ? warn_slowpath_fmt+0x0/0xe9
[<60264c20>] ? __raw_writel+0xb0/0xe0
[<601f689f>] ? clk_gate_endisable+0xaf/0x110
[<601f6925>] ? clk_gate_enable+0x15/0x20
[<601ec147>] ? clk_core_enable+0x57/0xc0
[<601efb0e>] ? clk_enable+0x2e/0x50
[<601f80cf>] ? clk_gate_test_disable+0x12f/0x390
[<60295990>] ? schedule_preempt_disabled+0x0/0x20
[<60063aa0>] ? complete+0x0/0x70
[<601bff9d>] ? kunit_try_run_case+0x4d/0x80
[<60295855>] ? schedule+0x55/0x100
[<601c0d90>] ? kunit_generic_run_threadfn_adapter+0x0/0x20
[<601c0d9b>] ? kunit_generic_run_threadfn_adapter+0xb/0x20
[<60054364>] ? kthread+0xf4/0x150
[<60019e42>] ? new_thread_handler+0x82/0xc0
---[ end trace 0000000000000000 ]---
# clk_gate_test_disable: ASSERTION FAILED at drivers/clk/clk-gate_test.c:186
Expected enable_val =3D=3D ctx->fake_reg, but
enable_val =3D=3D 32
ctx->fake_reg =3D=3D 0
clk_unregister: unregistering prepared clock: test_gate
clk_unregister: unregistering prepared clock: test_parent
not ok 3 - clk_gate_test_disable
# clk-gate-test: pass:1 fail:2 skip:0 total:3
# Totals: pass:1 fail:2 skip:0 total:3
not ok 7 - clk-gate-test
# Subtest: clk-gate-invert-test
1..2
------------[ cut here ]------------
WARNING: CPU: 0 PID: 47 at lib/logic_iomem.c:141 __raw_readl+0x9f/0xd0
CPU: 0 PID: 47 Comm: kunit_try_catch Tainted: G        W        N 5.19.0-rc=
1-00014-g6fc3a8636a7b #165
Stack:
6030a5b6 60277543 60350943 6030a5b6
6002a000 00000000 0000008d 6031ccb0
a088bd08 60294456 00000000 00000000
Call Trace:
[<6002a000>] ? um_set_signals+0x0/0x50
[<60294456>] ? dump_stack_lvl+0x44/0x50
[<60277543>] ? _printk+0x0/0x9b
[<60274ddb>] ? __warn.cold+0x33/0xa3
[<60274f24>] ? warn_slowpath_fmt+0xd9/0xe9
[<601ececa>] ? clk_core_lookup+0x5a/0x150
[<601ec370>] ? clk_prepare_unlock+0x0/0x100
[<601ee953>] ? __clk_register+0x8c3/0xb50
[<601f0d95>] ? clk_hw_register+0x15/0x30
[<60274e4b>] ? warn_slowpath_fmt+0x0/0xe9
[<60264b3f>] ? __raw_readl+0x9f/0xd0
[<601f68bd>] ? clk_gate_endisable+0xcd/0x110
[<601f6925>] ? clk_gate_enable+0x15/0x20
[<601ec147>] ? clk_core_enable+0x57/0xc0
[<601efb0e>] ? clk_enable+0x2e/0x50
[<601f89df>] ? clk_gate_test_invert_enable+0xff/0x2f0
[<60295990>] ? schedule_preempt_disabled+0x0/0x20
[<60063aa0>] ? complete+0x0/0x70
[<601bff9d>] ? kunit_try_run_case+0x4d/0x80
[<60295855>] ? schedule+0x55/0x100
[<601c0d90>] ? kunit_generic_run_threadfn_adapter+0x0/0x20
[<601c0d9b>] ? kunit_generic_run_threadfn_adapter+0xb/0x20
[<60054364>] ? kthread+0xf4/0x150
[<60019e42>] ? new_thread_handler+0x82/0xc0
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
WARNING: CPU: 0 PID: 47 at lib/logic_iomem.c:190 __raw_readl+0xbd/0xd0
Invalid readl at address 60c057d8
CPU: 0 PID: 47 Comm: kunit_try_catch Tainted: G        W        N 5.19.0-rc=
1-00014-g6fc3a8636a7b #165
Stack:
6030a5b6 60277543 60350943 6030a5b6
6002a000 00000000 000000be 6031ccb0
a088bd08 60294456 a088bd50 00000000
Call Trace:
[<6002a000>] ? um_set_signals+0x0/0x50
[<60294456>] ? dump_stack_lvl+0x44/0x50
[<60277543>] ? _printk+0x0/0x9b
[<60274ddb>] ? __warn.cold+0x33/0xa3
[<60274f24>] ? warn_slowpath_fmt+0xd9/0xe9
[<601ececa>] ? clk_core_lookup+0x5a/0x150
[<601ec370>] ? clk_prepare_unlock+0x0/0x100
[<601ee953>] ? __clk_register+0x8c3/0xb50
[<601f0d95>] ? clk_hw_register+0x15/0x30
[<60274e4b>] ? warn_slowpath_fmt+0x0/0xe9
[<60264b5d>] ? __raw_readl+0xbd/0xd0
[<601f68bd>] ? clk_gate_endisable+0xcd/0x110
[<601f6925>] ? clk_gate_enable+0x15/0x20
[<601ec147>] ? clk_core_enable+0x57/0xc0
[<601efb0e>] ? clk_enable+0x2e/0x50
[<601f89df>] ? clk_gate_test_invert_enable+0xff/0x2f0
[<60295990>] ? schedule_preempt_disabled+0x0/0x20
[<60063aa0>] ? complete+0x0/0x70
[<601bff9d>] ? kunit_try_run_case+0x4d/0x80
[<60295855>] ? schedule+0x55/0x100
[<601c0d90>] ? kunit_generic_run_threadfn_adapter+0x0/0x20
[<601c0d9b>] ? kunit_generic_run_threadfn_adapter+0xb/0x20
[<60054364>] ? kthread+0xf4/0x150
[<60019e42>] ? new_thread_handler+0x82/0xc0
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
WARNING: CPU: 0 PID: 47 at lib/logic_iomem.c:141 __raw_writel+0xb0/0xe0
CPU: 0 PID: 47 Comm: kunit_try_catch Tainted: G        W        N 5.19.0-rc=
1-00014-g6fc3a8636a7b #165
Stack:
6030a5b6 60277543 60350943 6030a5b6
6002a000 00000000 0000008d 6031ccb0
a088bcf8 60294456 00000000 00000000
Call Trace:
[<6002a000>] ? um_set_signals+0x0/0x50
[<60294456>] ? dump_stack_lvl+0x44/0x50
[<60277543>] ? _printk+0x0/0x9b
[<60274ddb>] ? __warn.cold+0x33/0xa3
[<60277543>] ? _printk+0x0/0x9b
[<60274f24>] ? warn_slowpath_fmt+0xd9/0xe9
[<601ececa>] ? clk_core_lookup+0x5a/0x150
[<601ee953>] ? __clk_register+0x8c3/0xb50
[<60274e4b>] ? warn_slowpath_fmt+0x0/0xe9
[<60264c20>] ? __raw_writel+0xb0/0xe0
[<601f689f>] ? clk_gate_endisable+0xaf/0x110
[<601f6925>] ? clk_gate_enable+0x15/0x20
[<601ec147>] ? clk_core_enable+0x57/0xc0
[<601efb0e>] ? clk_enable+0x2e/0x50
[<601f89df>] ? clk_gate_test_invert_enable+0xff/0x2f0
[<60295990>] ? schedule_preempt_disabled+0x0/0x20
[<60063aa0>] ? complete+0x0/0x70
[<601bff9d>] ? kunit_try_run_case+0x4d/0x80
[<60295855>] ? schedule+0x55/0x100
[<601c0d90>] ? kunit_generic_run_threadfn_adapter+0x0/0x20
[<601c0d9b>] ? kunit_generic_run_threadfn_adapter+0xb/0x20
[<60054364>] ? kthread+0xf4/0x150
[<60019e42>] ? new_thread_handler+0x82/0xc0
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
WARNING: CPU: 0 PID: 47 at lib/logic_iomem.c:190 clk_gate_endisable+0xaf/0x=
110
Invalid writeql of 0xffff7fff at address 60c057d8
CPU: 0 PID: 47 Comm: kunit_try_catch Tainted: G        W        N 5.19.0-rc=
1-00014-g6fc3a8636a7b #165
Stack:
6030a5b6 60277543 60350943 6030a5b6
6002a000 00000000 000000be 6031ccb0
a088bd28 60294456 a088bd70 00000000
Call Trace:
[<6002a000>] ? um_set_signals+0x0/0x50
[<60294456>] ? dump_stack_lvl+0x44/0x50
[<60277543>] ? _printk+0x0/0x9b
[<60274ddb>] ? __warn.cold+0x33/0xa3
[<60274f24>] ? warn_slowpath_fmt+0xd9/0xe9
[<601ee953>] ? __clk_register+0x8c3/0xb50
[<60274e4b>] ? warn_slowpath_fmt+0x0/0xe9
[<60264c20>] ? __raw_writel+0xb0/0xe0
[<601f689f>] ? clk_gate_endisable+0xaf/0x110
[<601f6925>] ? clk_gate_enable+0x15/0x20
[<601ec147>] ? clk_core_enable+0x57/0xc0
[<601efb0e>] ? clk_enable+0x2e/0x50
[<601f89df>] ? clk_gate_test_invert_enable+0xff/0x2f0
[<60295990>] ? schedule_preempt_disabled+0x0/0x20
[<60063aa0>] ? complete+0x0/0x70
[<601bff9d>] ? kunit_try_run_case+0x4d/0x80
[<60295855>] ? schedule+0x55/0x100
[<601c0d90>] ? kunit_generic_run_threadfn_adapter+0x0/0x20
[<601c0d9b>] ? kunit_generic_run_threadfn_adapter+0xb/0x20
[<60054364>] ? kthread+0xf4/0x150
[<60019e42>] ? new_thread_handler+0x82/0xc0
---[ end trace 0000000000000000 ]---
# clk_gate_test_invert_enable: EXPECTATION FAILED at drivers/clk/clk-gate_t=
est.c:249
Expected enable_val =3D=3D ctx->fake_reg, but
enable_val =3D=3D 0
ctx->fake_reg =3D=3D 32768
------------[ cut here ]------------
WARNING: CPU: 0 PID: 47 at lib/logic_iomem.c:141 __raw_readl+0x9f/0xd0
CPU: 0 PID: 47 Comm: kunit_try_catch Tainted: G        W        N 5.19.0-rc=
1-00014-g6fc3a8636a7b #165
Stack:
6030a5b6 60277543 60350943 6030a5b6
6002a000 00000001 0000008d 6031ccb0
a088bd58 60294456 00000000 00000000
Call Trace:
[<6002a000>] ? um_set_signals+0x0/0x50
[<60294456>] ? dump_stack_lvl+0x44/0x50
[<60277543>] ? _printk+0x0/0x9b
[<60274ddb>] ? __warn.cold+0x33/0xa3
[<6002a044>] ? um_set_signals+0x44/0x50
[<60274f24>] ? warn_slowpath_fmt+0xd9/0xe9
[<601bfdc0>] ? kunit_do_failed_assertion+0x100/0x1c0
[<601bf580>] ? kunit_log_append+0x0/0x130
[<60274e4b>] ? warn_slowpath_fmt+0x0/0xe9
[<601bfcc0>] ? kunit_do_failed_assertion+0x0/0x1c0
[<60264c20>] ? __raw_writel+0xb0/0xe0
[<60274e4b>] ? warn_slowpath_fmt+0x0/0xe9
[<601ef400>] ? clk_hw_is_enabled+0x0/0x10
[<60264b3f>] ? __raw_readl+0x9f/0xd0
[<601f694a>] ? clk_gate_is_enabled+0x1a/0x50
[<601ebf42>] ? clk_core_is_enabled+0x22/0xb0
[<601f8986>] ? clk_gate_test_invert_enable+0xa6/0x2f0
[<601c0ad0>] ? kunit_binary_assert_format+0x0/0x100
[<60063aa0>] ? complete+0x0/0x70
[<601bff9d>] ? kunit_try_run_case+0x4d/0x80
[<60295855>] ? schedule+0x55/0x100
[<601c0d90>] ? kunit_generic_run_threadfn_adapter+0x0/0x20
[<601c0d9b>] ? kunit_generic_run_threadfn_adapter+0xb/0x20
[<60054364>] ? kthread+0xf4/0x150
[<60019e42>] ? new_thread_handler+0x82/0xc0
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
WARNING: CPU: 0 PID: 47 at lib/logic_iomem.c:190 __raw_readl+0xbd/0xd0
Invalid readl at address 60c057d8
CPU: 0 PID: 47 Comm: kunit_try_catch Tainted: G        W        N 5.19.0-rc=
1-00014-g6fc3a8636a7b #165
Stack:
6030a5b6 60277543 60350943 6030a5b6
6002a000 00000001 000000be 6031ccb0
a088bd58 60294456 a088bda0 00000000
Call Trace:
[<6002a000>] ? um_set_signals+0x0/0x50
[<60294456>] ? dump_stack_lvl+0x44/0x50
[<60277543>] ? _printk+0x0/0x9b
[<60274ddb>] ? __warn.cold+0x33/0xa3
[<6002a044>] ? um_set_signals+0x44/0x50
[<60274f24>] ? warn_slowpath_fmt+0xd9/0xe9
[<601bfdc0>] ? kunit_do_failed_assertion+0x100/0x1c0
[<60274e4b>] ? warn_slowpath_fmt+0x0/0xe9
[<601bfcc0>] ? kunit_do_failed_assertion+0x0/0x1c0
[<60264c20>] ? __raw_writel+0xb0/0xe0
[<60274e4b>] ? warn_slowpath_fmt+0x0/0xe9
[<601ef400>] ? clk_hw_is_enabled+0x0/0x10
[<60264b5d>] ? __raw_readl+0xbd/0xd0
[<601f694a>] ? clk_gate_is_enabled+0x1a/0x50
[<601ebf42>] ? clk_core_is_enabled+0x22/0xb0
[<601f8986>] ? clk_gate_test_invert_enable+0xa6/0x2f0
[<601c0ad0>] ? kunit_binary_assert_format+0x0/0x100
[<60063aa0>] ? complete+0x0/0x70
[<601bff9d>] ? kunit_try_run_case+0x4d/0x80
[<60295855>] ? schedule+0x55/0x100
[<601c0d90>] ? kunit_generic_run_threadfn_adapter+0x0/0x20
[<601c0d9b>] ? kunit_generic_run_threadfn_adapter+0xb/0x20
[<60054364>] ? kthread+0xf4/0x150
[<60019e42>] ? new_thread_handler+0x82/0xc0
---[ end trace 0000000000000000 ]---
# clk_gate_test_invert_enable: EXPECTATION FAILED at drivers/clk/clk-gate_t=
est.c:250
Expected clk_hw_is_enabled(hw) to be true, but is false
clk_unregister: unregistering prepared clock: test_gate
clk_unregister: unregistering prepared clock: test_parent
not ok 1 - clk_gate_test_invert_enable
------------[ cut here ]------------
WARNING: CPU: 0 PID: 48 at lib/logic_iomem.c:141 __raw_readl+0x9f/0xd0
CPU: 0 PID: 48 Comm: kunit_try_catch Tainted: G        W        N 5.19.0-rc=
1-00014-g6fc3a8636a7b #165
Stack:
6030a5b6 60277543 60350943 6030a5b6
6002a000 00000000 0000008d 6031ccb0
a088bcf8 60294456 00000000 00000000
Call Trace:
[<6002a000>] ? um_set_signals+0x0/0x50
[<60294456>] ? dump_stack_lvl+0x44/0x50
[<60277543>] ? _printk+0x0/0x9b
[<60274ddb>] ? __warn.cold+0x33/0xa3
[<601ef880>] ? clk_unprepare+0x0/0x50
[<60274f24>] ? warn_slowpath_fmt+0xd9/0xe9
[<601ee1bb>] ? __clk_register+0x12b/0xb50
[<601ececa>] ? clk_core_lookup+0x5a/0x150
[<601ec370>] ? clk_prepare_unlock+0x0/0x100
[<601ee953>] ? __clk_register+0x8c3/0xb50
[<60274e4b>] ? warn_slowpath_fmt+0x0/0xe9
[<60264b3f>] ? __raw_readl+0x9f/0xd0
[<601f68bd>] ? clk_gate_endisable+0xcd/0x110
[<601f6925>] ? clk_gate_enable+0x15/0x20
[<601ec147>] ? clk_core_enable+0x57/0xc0
[<601efb0e>] ? clk_enable+0x2e/0x50
[<601f937f>] ? clk_gate_test_invert_disable+0x12f/0x390
[<60295990>] ? schedule_preempt_disabled+0x0/0x20
[<60063aa0>] ? complete+0x0/0x70
[<601bff9d>] ? kunit_try_run_case+0x4d/0x80
[<60295855>] ? schedule+0x55/0x100
[<601c0d90>] ? kunit_generic_run_threadfn_adapter+0x0/0x20
[<601c0d9b>] ? kunit_generic_run_threadfn_adapter+0xb/0x20
[<60054364>] ? kthread+0xf4/0x150
[<60019e42>] ? new_thread_handler+0x82/0xc0
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
WARNING: CPU: 0 PID: 48 at lib/logic_iomem.c:190 __raw_readl+0xbd/0xd0
Invalid readl at address 60c057d8
CPU: 0 PID: 48 Comm: kunit_try_catch Tainted: G        W        N 5.19.0-rc=
1-00014-g6fc3a8636a7b #165
Stack:
6030a5b6 60277543 60350943 6030a5b6
6002a000 00000000 000000be 6031ccb0
a088bcf8 60294456 a088bd40 00000000
Call Trace:
[<6002a000>] ? um_set_signals+0x0/0x50
[<60294456>] ? dump_stack_lvl+0x44/0x50
[<60277543>] ? _printk+0x0/0x9b
[<60274ddb>] ? __warn.cold+0x33/0xa3
[<601ef880>] ? clk_unprepare+0x0/0x50
[<60274f24>] ? warn_slowpath_fmt+0xd9/0xe9
[<601ee1bb>] ? __clk_register+0x12b/0xb50
[<601ececa>] ? clk_core_lookup+0x5a/0x150
[<601ec370>] ? clk_prepare_unlock+0x0/0x100
[<601ee953>] ? __clk_register+0x8c3/0xb50
[<60274e4b>] ? warn_slowpath_fmt+0x0/0xe9
[<60264b5d>] ? __raw_readl+0xbd/0xd0
[<601f68bd>] ? clk_gate_endisable+0xcd/0x110
[<601f6925>] ? clk_gate_enable+0x15/0x20
[<601ec147>] ? clk_core_enable+0x57/0xc0
[<601efb0e>] ? clk_enable+0x2e/0x50
[<601f937f>] ? clk_gate_test_invert_disable+0x12f/0x390
[<60295990>] ? schedule_preempt_disabled+0x0/0x20
[<60063aa0>] ? complete+0x0/0x70
[<601bff9d>] ? kunit_try_run_case+0x4d/0x80
[<60295855>] ? schedule+0x55/0x100
[<601c0d90>] ? kunit_generic_run_threadfn_adapter+0x0/0x20
[<601c0d9b>] ? kunit_generic_run_threadfn_adapter+0xb/0x20
[<60054364>] ? kthread+0xf4/0x150
[<60019e42>] ? new_thread_handler+0x82/0xc0
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
WARNING: CPU: 0 PID: 48 at lib/logic_iomem.c:141 __raw_writel+0xb0/0xe0
CPU: 0 PID: 48 Comm: kunit_try_catch Tainted: G        W        N 5.19.0-rc=
1-00014-g6fc3a8636a7b #165
Stack:
6030a5b6 60277543 60350943 6030a5b6
6002a000 00000000 0000008d 6031ccb0
a088bce8 60294456 00000000 00000000
Call Trace:
[<6002a000>] ? um_set_signals+0x0/0x50
[<60294456>] ? dump_stack_lvl+0x44/0x50
[<60277543>] ? _printk+0x0/0x9b
[<60274ddb>] ? __warn.cold+0x33/0xa3
[<60277543>] ? _printk+0x0/0x9b
[<601ef880>] ? clk_unprepare+0x0/0x50
[<60274f24>] ? warn_slowpath_fmt+0xd9/0xe9
[<601ee1bb>] ? __clk_register+0x12b/0xb50
[<601ec370>] ? clk_prepare_unlock+0x0/0x100
[<601ee953>] ? __clk_register+0x8c3/0xb50
[<60274e4b>] ? warn_slowpath_fmt+0x0/0xe9
[<60264c20>] ? __raw_writel+0xb0/0xe0
[<601f689f>] ? clk_gate_endisable+0xaf/0x110
[<601f6925>] ? clk_gate_enable+0x15/0x20
[<601ec147>] ? clk_core_enable+0x57/0xc0
[<601efb0e>] ? clk_enable+0x2e/0x50
[<601f937f>] ? clk_gate_test_invert_disable+0x12f/0x390
[<60295990>] ? schedule_preempt_disabled+0x0/0x20
[<60063aa0>] ? complete+0x0/0x70
[<601bff9d>] ? kunit_try_run_case+0x4d/0x80
[<60295855>] ? schedule+0x55/0x100
[<601c0d90>] ? kunit_generic_run_threadfn_adapter+0x0/0x20
[<601c0d9b>] ? kunit_generic_run_threadfn_adapter+0xb/0x20
[<60054364>] ? kthread+0xf4/0x150
[<60019e42>] ? new_thread_handler+0x82/0xc0
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
WARNING: CPU: 0 PID: 48 at lib/logic_iomem.c:190 clk_gate_endisable+0xaf/0x=
110
Invalid writeql of 0xffff7fff at address 60c057d8
CPU: 0 PID: 48 Comm: kunit_try_catch Tainted: G        W        N 5.19.0-rc=
1-00014-g6fc3a8636a7b #165
Stack:
6030a5b6 60277543 60350943 6030a5b6
6002a000 00000000 000000be 6031ccb0
a088bd18 60294456 a088bd60 00000000
Call Trace:
[<6002a000>] ? um_set_signals+0x0/0x50
[<60294456>] ? dump_stack_lvl+0x44/0x50
[<60277543>] ? _printk+0x0/0x9b
[<60274ddb>] ? __warn.cold+0x33/0xa3
[<601ef880>] ? clk_unprepare+0x0/0x50
[<601ef880>] ? clk_unprepare+0x0/0x50
[<60274f24>] ? warn_slowpath_fmt+0xd9/0xe9
[<601ec370>] ? clk_prepare_unlock+0x0/0x100
[<60274e4b>] ? warn_slowpath_fmt+0x0/0xe9
[<60264c20>] ? __raw_writel+0xb0/0xe0
[<601f689f>] ? clk_gate_endisable+0xaf/0x110
[<601f6925>] ? clk_gate_enable+0x15/0x20
[<601ec147>] ? clk_core_enable+0x57/0xc0
[<601efb0e>] ? clk_enable+0x2e/0x50
[<601f937f>] ? clk_gate_test_invert_disable+0x12f/0x390
[<60295990>] ? schedule_preempt_disabled+0x0/0x20
[<60063aa0>] ? complete+0x0/0x70
[<601bff9d>] ? kunit_try_run_case+0x4d/0x80
[<60295855>] ? schedule+0x55/0x100
[<601c0d90>] ? kunit_generic_run_threadfn_adapter+0x0/0x20
[<601c0d9b>] ? kunit_generic_run_threadfn_adapter+0xb/0x20
[<60054364>] ? kthread+0xf4/0x150
[<60019e42>] ? new_thread_handler+0x82/0xc0
---[ end trace 0000000000000000 ]---
# clk_gate_test_invert_disable: ASSERTION FAILED at drivers/clk/clk-gate_te=
st.c:266
Expected enable_val =3D=3D ctx->fake_reg, but
enable_val =3D=3D 0
ctx->fake_reg =3D=3D 32768
clk_unregister: unregistering prepared clock: test_gate
clk_unregister: unregistering prepared clock: test_parent
not ok 2 - clk_gate_test_invert_disable
# clk-gate-invert-test: pass:0 fail:2 skip:0 total:2
# Totals: pass:0 fail:2 skip:0 total:2
not ok 8 - clk-gate-invert-test
# Subtest: clk-gate-hiword-test
1..2
------------[ cut here ]------------
WARNING: CPU: 0 PID: 49 at lib/logic_iomem.c:141 __raw_writel+0xb0/0xe0
CPU: 0 PID: 49 Comm: kunit_try_catch Tainted: G        W        N 5.19.0-rc=
1-00014-g6fc3a8636a7b #165
Stack:
6030a5b6 60277543 60350943 6030a5b6
6002a000 00000000 0000008d 6031ccb0
a088bcf8 60294456 00000000 00000000
Call Trace:
[<6002a000>] ? um_set_signals+0x0/0x50
[<60294456>] ? dump_stack_lvl+0x44/0x50
[<60277543>] ? _printk+0x0/0x9b
[<60274ddb>] ? __warn.cold+0x33/0xa3
[<60274f24>] ? warn_slowpath_fmt+0xd9/0xe9
[<601ee1bb>] ? __clk_register+0x12b/0xb50
[<601ececa>] ? clk_core_lookup+0x5a/0x150
[<601ec370>] ? clk_prepare_unlock+0x0/0x100
[<601ee953>] ? __clk_register+0x8c3/0xb50
[<60274e4b>] ? warn_slowpath_fmt+0x0/0xe9
[<60264c20>] ? __raw_writel+0xb0/0xe0
[<601f689f>] ? clk_gate_endisable+0xaf/0x110
[<601f6925>] ? clk_gate_enable+0x15/0x20
[<601ec147>] ? clk_core_enable+0x57/0xc0
[<601efb0e>] ? clk_enable+0x2e/0x50
[<601f86e7>] ? clk_gate_test_hiword_enable+0x107/0x300
[<60295990>] ? schedule_preempt_disabled+0x0/0x20
[<60063aa0>] ? complete+0x0/0x70
[<601bff9d>] ? kunit_try_run_case+0x4d/0x80
[<60295855>] ? schedule+0x55/0x100
[<601c0d90>] ? kunit_generic_run_threadfn_adapter+0x0/0x20
[<601c0d9b>] ? kunit_generic_run_threadfn_adapter+0xb/0x20
[<60054364>] ? kthread+0xf4/0x150
[<60019e42>] ? new_thread_handler+0x82/0xc0
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
WARNING: CPU: 0 PID: 49 at lib/logic_iomem.c:190 clk_gate_endisable+0xaf/0x=
110
Invalid writeql of 0x2000200 at address 60c057d8
CPU: 0 PID: 49 Comm: kunit_try_catch Tainted: G        W        N 5.19.0-rc=
1-00014-g6fc3a8636a7b #165
Stack:
6030a5b6 60277543 60350943 6030a5b6
6002a000 00000000 000000be 6031ccb0
a088bd28 60294456 a088bd70 00000000
Call Trace:
[<6002a000>] ? um_set_signals+0x0/0x50
[<60294456>] ? dump_stack_lvl+0x44/0x50
[<60277543>] ? _printk+0x0/0x9b
[<60274ddb>] ? __warn.cold+0x33/0xa3
[<60274f24>] ? warn_slowpath_fmt+0xd9/0xe9
[<601ec370>] ? clk_prepare_unlock+0x0/0x100
[<601ee953>] ? __clk_register+0x8c3/0xb50
[<60274e4b>] ? warn_slowpath_fmt+0x0/0xe9
[<60264c20>] ? __raw_writel+0xb0/0xe0
[<601f689f>] ? clk_gate_endisable+0xaf/0x110
[<601f6925>] ? clk_gate_enable+0x15/0x20
[<601ec147>] ? clk_core_enable+0x57/0xc0
[<601efb0e>] ? clk_enable+0x2e/0x50
[<601f86e7>] ? clk_gate_test_hiword_enable+0x107/0x300
[<60295990>] ? schedule_preempt_disabled+0x0/0x20
[<60063aa0>] ? complete+0x0/0x70
[<601bff9d>] ? kunit_try_run_case+0x4d/0x80
[<60295855>] ? schedule+0x55/0x100
[<601c0d90>] ? kunit_generic_run_threadfn_adapter+0x0/0x20
[<601c0d9b>] ? kunit_generic_run_threadfn_adapter+0xb/0x20
[<60054364>] ? kthread+0xf4/0x150
[<60019e42>] ? new_thread_handler+0x82/0xc0
---[ end trace 0000000000000000 ]---
# clk_gate_test_hiword_enable: EXPECTATION FAILED at drivers/clk/clk-gate_t=
est.c:322
Expected enable_val =3D=3D ctx->fake_reg, but
enable_val =3D=3D 33554944
ctx->fake_reg =3D=3D 0
------------[ cut here ]------------
WARNING: CPU: 0 PID: 49 at lib/logic_iomem.c:141 __raw_readl+0x9f/0xd0
CPU: 0 PID: 49 Comm: kunit_try_catch Tainted: G        W        N 5.19.0-rc=
1-00014-g6fc3a8636a7b #165
Stack:
6030a5b6 60277543 60350943 6030a5b6
6002a000 00000001 0000008d 6031ccb0
a088bd58 60294456 00000000 00000000
Call Trace:
[<6002a000>] ? um_set_signals+0x0/0x50
[<60294456>] ? dump_stack_lvl+0x44/0x50
[<60277543>] ? _printk+0x0/0x9b
[<60274ddb>] ? __warn.cold+0x33/0xa3
[<6002a044>] ? um_set_signals+0x44/0x50
[<60274f24>] ? warn_slowpath_fmt+0xd9/0xe9
[<601bfdc0>] ? kunit_do_failed_assertion+0x100/0x1c0
[<601bf580>] ? kunit_log_append+0x0/0x130
[<60274e4b>] ? warn_slowpath_fmt+0x0/0xe9
[<601bfcc0>] ? kunit_do_failed_assertion+0x0/0x1c0
[<60264c20>] ? __raw_writel+0xb0/0xe0
[<60274e4b>] ? warn_slowpath_fmt+0x0/0xe9
[<601ef400>] ? clk_hw_is_enabled+0x0/0x10
[<60264b3f>] ? __raw_readl+0x9f/0xd0
[<601f694a>] ? clk_gate_is_enabled+0x1a/0x50
[<601ebf42>] ? clk_core_is_enabled+0x22/0xb0
[<601f8689>] ? clk_gate_test_hiword_enable+0xa9/0x300
[<601c0ad0>] ? kunit_binary_assert_format+0x0/0x100
[<60063aa0>] ? complete+0x0/0x70
[<601bff9d>] ? kunit_try_run_case+0x4d/0x80
[<60295855>] ? schedule+0x55/0x100
[<601c0d90>] ? kunit_generic_run_threadfn_adapter+0x0/0x20
[<601c0d9b>] ? kunit_generic_run_threadfn_adapter+0xb/0x20
[<60054364>] ? kthread+0xf4/0x150
[<60019e42>] ? new_thread_handler+0x82/0xc0
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
WARNING: CPU: 0 PID: 49 at lib/logic_iomem.c:190 __raw_readl+0xbd/0xd0
Invalid readl at address 60c057d8
CPU: 0 PID: 49 Comm: kunit_try_catch Tainted: G        W        N 5.19.0-rc=
1-00014-g6fc3a8636a7b #165
Stack:
6030a5b6 60277543 60350943 6030a5b6
6002a000 00000001 000000be 6031ccb0
a088bd58 60294456 a088bda0 00000000
Call Trace:
[<6002a000>] ? um_set_signals+0x0/0x50
[<60294456>] ? dump_stack_lvl+0x44/0x50
[<60277543>] ? _printk+0x0/0x9b
[<60274ddb>] ? __warn.cold+0x33/0xa3
[<6002a044>] ? um_set_signals+0x44/0x50
[<60274f24>] ? warn_slowpath_fmt+0xd9/0xe9
[<601bfdc0>] ? kunit_do_failed_assertion+0x100/0x1c0
[<60274e4b>] ? warn_slowpath_fmt+0x0/0xe9
[<601bfcc0>] ? kunit_do_failed_assertion+0x0/0x1c0
[<60264c20>] ? __raw_writel+0xb0/0xe0
[<60274e4b>] ? warn_slowpath_fmt+0x0/0xe9
[<601ef400>] ? clk_hw_is_enabled+0x0/0x10
[<60264b5d>] ? __raw_readl+0xbd/0xd0
[<601f694a>] ? clk_gate_is_enabled+0x1a/0x50
[<601ebf42>] ? clk_core_is_enabled+0x22/0xb0
[<601f8689>] ? clk_gate_test_hiword_enable+0xa9/0x300
[<601c0ad0>] ? kunit_binary_assert_format+0x0/0x100
[<60063aa0>] ? complete+0x0/0x70
[<601bff9d>] ? kunit_try_run_case+0x4d/0x80
[<60295855>] ? schedule+0x55/0x100
[<601c0d90>] ? kunit_generic_run_threadfn_adapter+0x0/0x20
[<601c0d9b>] ? kunit_generic_run_threadfn_adapter+0xb/0x20
[<60054364>] ? kthread+0xf4/0x150
[<60019e42>] ? new_thread_handler+0x82/0xc0
---[ end trace 0000000000000000 ]---
clk_unregister: unregistering prepared clock: test_gate
clk_unregister: unregistering prepared clock: test_parent
not ok 1 - clk_gate_test_hiword_enable
------------[ cut here ]------------
WARNING: CPU: 0 PID: 50 at lib/logic_iomem.c:141 __raw_writel+0xb0/0xe0
CPU: 0 PID: 50 Comm: kunit_try_catch Tainted: G        W        N 5.19.0-rc=
1-00014-g6fc3a8636a7b #165
Stack:
6030a5b6 60277543 60350943 6030a5b6
6002a000 00000000 0000008d 6031ccb0
a088bce8 60294456 00000000 00000000
Call Trace:
[<6002a000>] ? um_set_signals+0x0/0x50
[<60294456>] ? dump_stack_lvl+0x44/0x50
[<60277543>] ? _printk+0x0/0x9b
[<60274ddb>] ? __warn.cold+0x33/0xa3
[<601ef880>] ? clk_unprepare+0x0/0x50
[<60274f24>] ? warn_slowpath_fmt+0xd9/0xe9
[<600ed737>] ? kmem_cache_alloc+0x137/0x1a0
[<601ee1bb>] ? __clk_register+0x12b/0xb50
[<601ec370>] ? clk_prepare_unlock+0x0/0x100
[<601ec370>] ? clk_prepare_unlock+0x0/0x100
[<601ee953>] ? __clk_register+0x8c3/0xb50
[<60274e4b>] ? warn_slowpath_fmt+0x0/0xe9
[<60264c20>] ? __raw_writel+0xb0/0xe0
[<601f689f>] ? clk_gate_endisable+0xaf/0x110
[<601f6925>] ? clk_gate_enable+0x15/0x20
[<601ec147>] ? clk_core_enable+0x57/0xc0
[<601efb0e>] ? clk_enable+0x2e/0x50
[<601f8fef>] ? clk_gate_test_hiword_disable+0x12f/0x390
[<60295990>] ? schedule_preempt_disabled+0x0/0x20
[<60063aa0>] ? complete+0x0/0x70
[<601bff9d>] ? kunit_try_run_case+0x4d/0x80
[<60295855>] ? schedule+0x55/0x100
[<601c0d90>] ? kunit_generic_run_threadfn_adapter+0x0/0x20
[<601c0d9b>] ? kunit_generic_run_threadfn_adapter+0xb/0x20
[<60054364>] ? kthread+0xf4/0x150
[<60019e42>] ? new_thread_handler+0x82/0xc0
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
WARNING: CPU: 0 PID: 50 at lib/logic_iomem.c:190 clk_gate_endisable+0xaf/0x=
110
Invalid writeql of 0x2000200 at address 60c057d8
CPU: 0 PID: 50 Comm: kunit_try_catch Tainted: G        W        N 5.19.0-rc=
1-00014-g6fc3a8636a7b #165
Stack:
6030a5b6 60277543 60350943 6030a5b6
6002a000 00000000 000000be 6031ccb0
a088bd18 60294456 a088bd60 00000000
Call Trace:
[<6002a000>] ? um_set_signals+0x0/0x50
[<60294456>] ? dump_stack_lvl+0x44/0x50
[<60277543>] ? _printk+0x0/0x9b
[<60274ddb>] ? __warn.cold+0x33/0xa3
[<601ef880>] ? clk_unprepare+0x0/0x50
[<601ef880>] ? clk_unprepare+0x0/0x50
[<60274f24>] ? warn_slowpath_fmt+0xd9/0xe9
[<601ec370>] ? clk_prepare_unlock+0x0/0x100
[<601ec370>] ? clk_prepare_unlock+0x0/0x100
[<60274e4b>] ? warn_slowpath_fmt+0x0/0xe9
[<60264c20>] ? __raw_writel+0xb0/0xe0
[<601f689f>] ? clk_gate_endisable+0xaf/0x110
[<601f6925>] ? clk_gate_enable+0x15/0x20
[<601ec147>] ? clk_core_enable+0x57/0xc0
[<601efb0e>] ? clk_enable+0x2e/0x50
[<601f8fef>] ? clk_gate_test_hiword_disable+0x12f/0x390
[<60295990>] ? schedule_preempt_disabled+0x0/0x20
[<60063aa0>] ? complete+0x0/0x70
[<601bff9d>] ? kunit_try_run_case+0x4d/0x80
[<60295855>] ? schedule+0x55/0x100
[<601c0d90>] ? kunit_generic_run_threadfn_adapter+0x0/0x20
[<601c0d9b>] ? kunit_generic_run_threadfn_adapter+0xb/0x20
[<60054364>] ? kthread+0xf4/0x150
[<60019e42>] ? new_thread_handler+0x82/0xc0
---[ end trace 0000000000000000 ]---
# clk_gate_test_hiword_disable: ASSERTION FAILED at drivers/clk/clk-gate_te=
st.c:339
Expected enable_val =3D=3D ctx->fake_reg, but
enable_val =3D=3D 33554944
ctx->fake_reg =3D=3D 0
clk_unregister: unregistering prepared clock: test_gate
clk_unregister: unregistering prepared clock: test_parent
not ok 2 - clk_gate_test_hiword_disable
# clk-gate-hiword-test: pass:0 fail:2 skip:0 total:2
# Totals: pass:0 fail:2 skip:0 total:2
not ok 9 - clk-gate-hiword-test
# Subtest: clk-gate-is_enabled-test
1..4
------------[ cut here ]------------
WARNING: CPU: 0 PID: 51 at lib/logic_iomem.c:141 __raw_readl+0x9f/0xd0
CPU: 0 PID: 51 Comm: kunit_try_catch Tainted: G        W        N 5.19.0-rc=
1-00014-g6fc3a8636a7b #165
Stack:
6030a5b6 60277543 60350943 6030a5b6
6002a000 00000001 0000008d 6031ccb0
a088bd78 60294456 00000000 00000000
Call Trace:
[<6002a000>] ? um_set_signals+0x0/0x50
[<60294456>] ? dump_stack_lvl+0x44/0x50
[<60277543>] ? _printk+0x0/0x9b
[<60274ddb>] ? __warn.cold+0x33/0xa3
[<601ee1bb>] ? __clk_register+0x12b/0xb50
[<60274f24>] ? warn_slowpath_fmt+0xd9/0xe9
[<600ed737>] ? kmem_cache_alloc+0x137/0x1a0
[<601f0d95>] ? clk_hw_register+0x15/0x30
[<601f6ae7>] ? __clk_hw_register_gate+0x167/0x190
[<60274e4b>] ? warn_slowpath_fmt+0x0/0xe9
[<60264b3f>] ? __raw_readl+0x9f/0xd0
[<601f694a>] ? clk_gate_is_enabled+0x1a/0x50
[<601ebf42>] ? clk_core_is_enabled+0x22/0xb0
[<601f717f>] ? clk_gate_test_is_enabled+0x6f/0x130
[<60063aa0>] ? complete+0x0/0x70
[<6002a044>] ? um_set_signals+0x44/0x50
[<602952f0>] ? __schedule+0x0/0x510
[<601bff9d>] ? kunit_try_run_case+0x4d/0x80
[<60295855>] ? schedule+0x55/0x100
[<601c0d90>] ? kunit_generic_run_threadfn_adapter+0x0/0x20
[<601c0d9b>] ? kunit_generic_run_threadfn_adapter+0xb/0x20
[<60054364>] ? kthread+0xf4/0x150
[<60019e42>] ? new_thread_handler+0x82/0xc0
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
WARNING: CPU: 0 PID: 51 at lib/logic_iomem.c:190 __raw_readl+0xbd/0xd0
Invalid readl at address 60c057d8
CPU: 0 PID: 51 Comm: kunit_try_catch Tainted: G        W        N 5.19.0-rc=
1-00014-g6fc3a8636a7b #165
Stack:
6030a5b6 60277543 60350943 6030a5b6
6002a000 00000001 000000be 6031ccb0
a088bd78 60294456 a088bdc0 00000000
Call Trace:
[<6002a000>] ? um_set_signals+0x0/0x50
[<60294456>] ? dump_stack_lvl+0x44/0x50
[<60277543>] ? _printk+0x0/0x9b
[<60274ddb>] ? __warn.cold+0x33/0xa3
[<601ee1bb>] ? __clk_register+0x12b/0xb50
[<60274f24>] ? warn_slowpath_fmt+0xd9/0xe9
[<600ed737>] ? kmem_cache_alloc+0x137/0x1a0
[<601f0d95>] ? clk_hw_register+0x15/0x30
[<601f6ae7>] ? __clk_hw_register_gate+0x167/0x190
[<60274e4b>] ? warn_slowpath_fmt+0x0/0xe9
[<60264b5d>] ? __raw_readl+0xbd/0xd0
[<601f694a>] ? clk_gate_is_enabled+0x1a/0x50
[<601ebf42>] ? clk_core_is_enabled+0x22/0xb0
[<601f717f>] ? clk_gate_test_is_enabled+0x6f/0x130
[<60063aa0>] ? complete+0x0/0x70
[<6002a044>] ? um_set_signals+0x44/0x50
[<602952f0>] ? __schedule+0x0/0x510
[<601bff9d>] ? kunit_try_run_case+0x4d/0x80
[<60295855>] ? schedule+0x55/0x100
[<601c0d90>] ? kunit_generic_run_threadfn_adapter+0x0/0x20
[<601c0d9b>] ? kunit_generic_run_threadfn_adapter+0xb/0x20
[<60054364>] ? kthread+0xf4/0x150
[<60019e42>] ? new_thread_handler+0x82/0xc0
---[ end trace 0000000000000000 ]---
ok 1 - clk_gate_test_is_enabled
------------[ cut here ]------------
WARNING: CPU: 0 PID: 52 at lib/logic_iomem.c:141 __raw_readl+0x9f/0xd0
CPU: 0 PID: 52 Comm: kunit_try_catch Tainted: G        W        N 5.19.0-rc=
1-00014-g6fc3a8636a7b #165
Stack:
6030a5b6 60277543 60350943 6030a5b6
6002a000 00000001 0000008d 6031ccb0
a088bd78 60294456 00000000 00000000
Call Trace:
[<6002a000>] ? um_set_signals+0x0/0x50
[<60294456>] ? dump_stack_lvl+0x44/0x50
[<60277543>] ? _printk+0x0/0x9b
[<60274ddb>] ? __warn.cold+0x33/0xa3
[<601ee1bb>] ? __clk_register+0x12b/0xb50
[<60274f24>] ? warn_slowpath_fmt+0xd9/0xe9
[<600ed737>] ? kmem_cache_alloc+0x137/0x1a0
[<601f0d95>] ? clk_hw_register+0x15/0x30
[<601f6ae7>] ? __clk_hw_register_gate+0x167/0x190
[<60274e4b>] ? warn_slowpath_fmt+0x0/0xe9
[<60264b3f>] ? __raw_readl+0x9f/0xd0
[<601f694a>] ? clk_gate_is_enabled+0x1a/0x50
[<601ebf42>] ? clk_core_is_enabled+0x22/0xb0
[<601f704f>] ? clk_gate_test_is_disabled+0x6f/0x130
[<60063aa0>] ? complete+0x0/0x70
[<6002a044>] ? um_set_signals+0x44/0x50
[<602952f0>] ? __schedule+0x0/0x510
[<601bff9d>] ? kunit_try_run_case+0x4d/0x80
[<60295855>] ? schedule+0x55/0x100
[<601c0d90>] ? kunit_generic_run_threadfn_adapter+0x0/0x20
[<601c0d9b>] ? kunit_generic_run_threadfn_adapter+0xb/0x20
[<60054364>] ? kthread+0xf4/0x150
[<60019e42>] ? new_thread_handler+0x82/0xc0
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
WARNING: CPU: 0 PID: 52 at lib/logic_iomem.c:190 __raw_readl+0xbd/0xd0
Invalid readl at address 60c057d8
CPU: 0 PID: 52 Comm: kunit_try_catch Tainted: G        W        N 5.19.0-rc=
1-00014-g6fc3a8636a7b #165
Stack:
6030a5b6 60277543 60350943 6030a5b6
6002a000 00000001 000000be 6031ccb0
a088bd78 60294456 a088bdc0 00000000
Call Trace:
[<6002a000>] ? um_set_signals+0x0/0x50
[<60294456>] ? dump_stack_lvl+0x44/0x50
[<60277543>] ? _printk+0x0/0x9b
[<60274ddb>] ? __warn.cold+0x33/0xa3
[<601ee1bb>] ? __clk_register+0x12b/0xb50
[<60274f24>] ? warn_slowpath_fmt+0xd9/0xe9
[<600ed737>] ? kmem_cache_alloc+0x137/0x1a0
[<601f0d95>] ? clk_hw_register+0x15/0x30
[<601f6ae7>] ? __clk_hw_register_gate+0x167/0x190
[<60274e4b>] ? warn_slowpath_fmt+0x0/0xe9
[<60264b5d>] ? __raw_readl+0xbd/0xd0
[<601f694a>] ? clk_gate_is_enabled+0x1a/0x50
[<601ebf42>] ? clk_core_is_enabled+0x22/0xb0
[<601f704f>] ? clk_gate_test_is_disabled+0x6f/0x130
[<60063aa0>] ? complete+0x0/0x70
[<6002a044>] ? um_set_signals+0x44/0x50
[<602952f0>] ? __schedule+0x0/0x510
[<601bff9d>] ? kunit_try_run_case+0x4d/0x80
[<60295855>] ? schedule+0x55/0x100
[<601c0d90>] ? kunit_generic_run_threadfn_adapter+0x0/0x20
[<601c0d9b>] ? kunit_generic_run_threadfn_adapter+0xb/0x20
[<60054364>] ? kthread+0xf4/0x150
[<60019e42>] ? new_thread_handler+0x82/0xc0
---[ end trace 0000000000000000 ]---
# clk_gate_test_is_disabled: ASSERTION FAILED at drivers/clk/clk-gate_test.=
c:409
Expected clk_hw_is_enabled(hw) to be false, but is true
not ok 2 - clk_gate_test_is_disabled
# clk_gate_test_is_enabled_inverted: ASSERTION FAILED at drivers/clk/clk-ga=
te_test.c:423
Expected hw is not error, but is: -17
not ok 3 - clk_gate_test_is_enabled_inverted
# clk_gate_test_is_disabled_inverted: ASSERTION FAILED at drivers/clk/clk-g=
ate_test.c:438
Expected hw is not error, but is: -17
not ok 4 - clk_gate_test_is_disabled_inverted
# clk-gate-is_enabled-test: pass:1 fail:3 skip:0 total:4
# Totals: pass:1 fail:3 skip:0 total:4
not ok 10 - clk-gate-is_enabled-test
[16:45:58] Elapsed time: 5.759s total, 0.857s configuring, 4.786s building,=
 0.080s running

Maxime

--chwcydxziidfgakt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYsw32wAKCRDj7w1vZxhR
xUhxAP9eM45wMof9qy/K127XaCM/M860EEJFlPaAS4hyXv1JEQEAxdiJ+fe8FZh2
0TcIHbWA1uhL9Be5mEZciHeMq47vawE=
=YZD4
-----END PGP SIGNATURE-----

--chwcydxziidfgakt--
