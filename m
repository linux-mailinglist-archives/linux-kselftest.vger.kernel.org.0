Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A1BA3B3072
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Jun 2021 15:48:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231417AbhFXNvI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 24 Jun 2021 09:51:08 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:32984 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbhFXNvI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 24 Jun 2021 09:51:08 -0400
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 5136A72C8B4;
        Thu, 24 Jun 2021 16:48:47 +0300 (MSK)
Received: from altlinux.org (sole.flsd.net [185.75.180.6])
        by imap.altlinux.org (Postfix) with ESMTPSA id 396E84A46EC;
        Thu, 24 Jun 2021 16:48:47 +0300 (MSK)
Date:   Thu, 24 Jun 2021 16:48:47 +0300
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        "Dmitry V. Levin" <ldv@altlinux.org>
Subject: Re: Kernel selftests and backward compatibility?
Message-ID: <20210624134847.zoms7776gm6d3q2k@altlinux.org>
References: <20210623142608.xx6qc3mkzc72z2cr@altlinux.org>
 <a068b01b-9549-3c6b-f0c5-7c68e9bc1c23@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <a068b01b-9549-3c6b-f0c5-7c68e9bc1c23@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Shuah,

On Wed, Jun 23, 2021 at 12:08:48PM -0600, Shuah Khan wrote:
> On 6/23/21 8:26 AM, Vitaly Chikunov wrote:
> > Do kselftests require to be backward-compatible?
> 
> Kselftests from the latest kernel can run on older kernels. In that
> respect they are backward compatible.
> 
> It is possible that a newly added test is for a new feature and new
> API and as a result could be skipped on older kernels.
> 
> 
> 
> > I see Documentation/dev-tools/kselftest.rst does not require this, but
> > maybe it's assumed like in other test suites (or in perf).
> > 
> > | In general, the rules for selftests are
> > |
> > |  * Do as much as you can if you're not root;
> > |
> > |  * Don't take too long;
> > |
> > |  * Don't break the build on any architecture, and
> > |
> > |  * Don't cause the top-level "make run_tests" to fail if your feature is
> > |    unconfigured.
> > 
> 
> Correct. We don't explicitly state that the tests are backward
> compatible, however they are. We don't do any revision checks.
> We keep adding new tests and enhancements to existing tests in
> every release. New tests depend on new kernel features and headers
> and they could fail to build. However the suite will build the tests
> it can build and will run the test it can run.
> 
> > For example LTP says:
> > 
> > | LTP test should be as backward compatible as possible. [...]
> > |
> > | Therefore LTP test for more current features should be able to cope with older
> > | systems.
> > 
> > Also, (it's said[1]) perf, even though in kernel tree, is supposed to work
> > properly on any (older/newer) version of Linux.
> > 
> > Can you clarify this point in kselftest.rst?
> > 
> > I think, this would be useful for future kselftests developers, users,
> > and packagers. (Currently, I package for ALT Linux kselftests (and perf)
> > from the latest mainline branch, so people could test even older kernels
> > with the latest kselftests.
> > 
> > If there is policy to be backward-compatible kselftests in the future
> > could reach a state where users would run them in all pass mode (without
> > selecting only working tests). This, in turn, would increase [ease of]
> > usability of tests and thus frequency of their run and consequentially
> > quality kernel testing overall.
> > 
> 
> The policy is kselftests from new kernel can run on older kernels.
> Tests that don't meet dependencies and privileges to run are skipped.
> We do have newer tests that don't fail gracefully if dependencies aren't
> met and those cases are considered as bugs.
> 
> We have a wide range of tests in the suite. Some tests are at the
> granularity of a specific system call flag. It would be difficult to isolate
> all pass. What we can come close to is skipping tests that don't
> meet dependencies consistently and we strive to do this and consider the
> ones that don't meet as bugs and fix them.
> 
> Hope this gives you a context around backward compatibility.

Thanks much for the detailed explanation!

Vitaly,

