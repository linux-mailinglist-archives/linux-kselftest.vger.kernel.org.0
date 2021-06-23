Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC26F3B1C63
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Jun 2021 16:26:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230430AbhFWO2a (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 23 Jun 2021 10:28:30 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:35116 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230061AbhFWO22 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 23 Jun 2021 10:28:28 -0400
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id A8AE272C8B4;
        Wed, 23 Jun 2021 17:26:08 +0300 (MSK)
Received: from altlinux.org (sole.flsd.net [185.75.180.6])
        by imap.altlinux.org (Postfix) with ESMTPSA id 90E904A46EC;
        Wed, 23 Jun 2021 17:26:08 +0300 (MSK)
Date:   Wed, 23 Jun 2021 17:26:08 +0300
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org
Cc:     "Dmitry V. Levin" <ldv@altlinux.org>
Subject: Kernel selftests and backward compatibility?
Message-ID: <20210623142608.xx6qc3mkzc72z2cr@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Shuah,

Do kselftests require to be backward-compatible?

I see Documentation/dev-tools/kselftest.rst does not require this, but
maybe it's assumed like in other test suites (or in perf).

| In general, the rules for selftests are
| 
|  * Do as much as you can if you're not root;
| 
|  * Don't take too long;
| 
|  * Don't break the build on any architecture, and
| 
|  * Don't cause the top-level "make run_tests" to fail if your feature is
|    unconfigured.

For example LTP says:

| LTP test should be as backward compatible as possible. [...]
| 
| Therefore LTP test for more current features should be able to cope with older
| systems.

Also, (it's said[1]) perf, even though in kernel tree, is supposed to work
properly on any (older/newer) version of Linux.

Can you clarify this point in kselftest.rst?

I think, this would be useful for future kselftests developers, users,
and packagers. (Currently, I package for ALT Linux kselftests (and perf)
from the latest mainline branch, so people could test even older kernels
with the latest kselftests.

If there is policy to be backward-compatible kselftests in the future
could reach a state where users would run them in all pass mode (without
selecting only working tests). This, in turn, would increase [ease of]
usability of tests and thus frequency of their run and consequentially
quality kernel testing overall.

Thanks,

 [1] https://lkml.org/lkml/2020/7/29/677

