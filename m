Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 354755328BD
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 May 2022 13:19:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236563AbiEXLQL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 24 May 2022 07:16:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236567AbiEXLQC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 24 May 2022 07:16:02 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 901279155E
        for <linux-kselftest@vger.kernel.org>; Tue, 24 May 2022 04:15:51 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4L6s7p1QD4z4yT5;
        Tue, 24 May 2022 21:15:50 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Madhavan Srinivasan <maddy@linux.ibm.com>, mpe@ellerman.id.au
Cc:     kjain@linux.ibm.com, shuah@kernel.org,
        linux-kselftest@vger.kernel.org, atrajeev@linux.vnet.ibm.com,
        linuxppc-dev@lists.ozlabs.org
In-Reply-To: <20220322045638.10443-1-maddy@linux.ibm.com>
References: <20220322045638.10443-1-maddy@linux.ibm.com>
Subject: Re: [PATCH] selftest/powerpc/pmu/ebb: remove fixed_instruction.S
Message-Id: <165339059080.1718562.62560284365315376.b4-ty@ellerman.id.au>
Date:   Tue, 24 May 2022 21:09:50 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, 22 Mar 2022 10:26:38 +0530, Madhavan Srinivasan wrote:
> Commit 3752e453f6ba ("selftests/powerpc: Add tests of PMU EBBs") added
> selftest testcases to verify EBB interface. instruction_count_test.c
> testcase needs a fixed loop function to count overhead. Instead of
> using the thirty_two_instruction_loop() in fixed_instruction_loop.S
> in ebb folder, file is linked with thirty_two_instruction_loop() in
> loop.S from top folder. Since fixed_instruction_loop.S not used, patch
> removes the file.
> 
> [...]

Applied to powerpc/next.

[1/1] selftest/powerpc/pmu/ebb: remove fixed_instruction.S
      https://git.kernel.org/powerpc/c/079e5fd3a1e41c186c1bc4166d409d22e70729bf

cheers
