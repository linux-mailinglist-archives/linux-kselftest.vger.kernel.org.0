Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED4AA787B33
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Aug 2023 00:07:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243834AbjHXWGw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 24 Aug 2023 18:06:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243836AbjHXWGX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 24 Aug 2023 18:06:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FE661BE2;
        Thu, 24 Aug 2023 15:06:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3971966C53;
        Thu, 24 Aug 2023 22:06:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E7CBC433CB;
        Thu, 24 Aug 2023 22:06:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692914780;
        bh=Hytxi3Cg98uzyBqRReiFnjcWLYhr5yk1C/6Y76auyFE=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=caF3wn5HbvvnM3Q8967B6lXbHI1nJ1JpYq4WSPGIBE5v3Qp4KJ0mPHm5YJ/ZVTwOk
         YWlFa5Baj1g06+eh6VKduDWjBmZcF9apmqEn4ehy2dinmOLE+QzqQ1UmJnITVKdN/P
         a5BotQEMST0nD2wB3A/Tvb5PTcnfawFZO9xBQX0Fybq/RDiSTF+WkJYiRNqS0a5qRY
         9rwtyk2bJDCr/VEluBV4UwU5vpAUDs9saho9YUvjxVe74Mpzx5NywQV288GGFJCHI3
         Iv3fO0jD7DWl2WrzvymQRBCd64tFdHXcNJXRbT/yvffgt+HmeeQyLQQKs8axTaC7sj
         GG0LdjUZPYw0g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 312D7CE134A; Thu, 24 Aug 2023 15:06:20 -0700 (PDT)
Date:   Thu, 24 Aug 2023 15:06:20 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        rcu@vger.kernel.org, rostedt@goodmis.org
Subject: [GIT PULL] scftorture changes for v6.4
Message-ID: <79cb1ec7-08ec-40d2-bbb4-ce40b684f1a4@paulmck-laptop>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hello, Linus,

Once the merge window opens, please pull these scftorture changes:

  git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git tags/scftorture.2023.08.15a
  # HEAD: 3f68f9c822ebe208f961ab0402e49a10465278ca: scftorture: Add CONFIG_PREEMPT_DYNAMIC=n to NOPREEMPT scenario (2023-07-14 15:02:57 -0700)

----------------------------------------------------------------
smp_call_function torture-test updates for v6.6

This pull request prevents some memory-exhaustion false-postitive failures
in scftorture testing.

----------------------------------------------------------------
Paul E. McKenney (4):
      torture: Scale scftorture memory based on number of CPUs
      scftorture: Forgive memory-allocation failure if KASAN
      scftorture: Pause testing after memory-allocation failure
      scftorture: Add CONFIG_PREEMPT_DYNAMIC=n to NOPREEMPT scenario

 kernel/scftorture.c                                      | 12 +++++++++---
 tools/testing/selftests/rcutorture/bin/torture.sh        |  4 +++-
 tools/testing/selftests/rcutorture/configs/scf/NOPREEMPT |  2 ++
 3 files changed, 14 insertions(+), 4 deletions(-)
