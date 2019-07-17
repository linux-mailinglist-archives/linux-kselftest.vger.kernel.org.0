Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F422B6BC0F
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Jul 2019 14:00:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726934AbfGQMA5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 17 Jul 2019 08:00:57 -0400
Received: from mx2.suse.de ([195.135.220.15]:54610 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726063AbfGQMA5 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 17 Jul 2019 08:00:57 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id DEFB4AE86;
        Wed, 17 Jul 2019 12:00:55 +0000 (UTC)
Date:   Wed, 17 Jul 2019 14:00:55 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Joe Lawrence <joe.lawrence@redhat.com>,
        Jiri Benc <jbenc@redhat.com>
Cc:     linux-kselftest@vger.kernel.org, live-patching@vger.kernel.org,
        shuah@kernel.org
Subject: Re: [PATCH v2] selftests/livepatch: add test skip handling
Message-ID: <20190717120055.pno2b7zczpcgaixg@pathway.suse.cz>
References: <20190716133414.20196-1-joe.lawrence@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190716133414.20196-1-joe.lawrence@redhat.com>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue 2019-07-16 09:34:14, Joe Lawrence wrote:
> Add a skip() message function that stops the test, logs an explanation,
> and sets the "skip" return code (4).
> 
> Before loading a livepatch self-test kernel module, first verify that
> we've built and installed it by running a 'modprobe --dry-run'.  This
> should catch a few environment issues, including !CONFIG_LIVEPATCH and
> !CONFIG_TEST_LIVEPATCH.  In these cases, exit gracefully with the new
> skip() function.
> 
> Reported-by: Jiri Benc <jbenc@redhat.com>

Adding Jiri into CC to be sure that we really solved the original problem.

I get the following output when livepatching is not configured:

$> make run_tests
TAP version 13
1..4
# selftests: livepatch: test-livepatch.sh
# TEST: basic function patching ... SKIP: Failed modprobe --dry-run of module: test_klp_livepatch
not ok 1 selftests: livepatch: test-livepatch.sh # SKIP
# selftests: livepatch: test-callbacks.sh
# TEST: target module before livepatch ... SKIP: Failed modprobe --dry-run of module: test_klp_callbacks_mod
not ok 2 selftests: livepatch: test-callbacks.sh # SKIP
# selftests: livepatch: test-shadow-vars.sh
# TEST: basic shadow variable API ... SKIP: Failed modprobe --dry-run of module: test_klp_shadow_vars
not ok 3 selftests: livepatch: test-shadow-vars.sh # SKIP
# selftests: livepatch: test-state.sh
# TEST: system state modification ... SKIP: Failed modprobe --dry-run of module: test_klp_state
not ok 4 selftests: livepatch: test-state.sh # SKIP

Jiri, is it acceptable solution for you, please?


> Suggested-by: Shuah Khan <shuah@kernel.org>
> Signed-off-by: Joe Lawrence <joe.lawrence@redhat.com>

Otherwise, the patch looks fine to me. If Jiri is fine
then feel free to use:

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
