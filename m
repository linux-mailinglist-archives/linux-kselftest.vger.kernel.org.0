Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92C045276D1
	for <lists+linux-kselftest@lfdr.de>; Sun, 15 May 2022 12:14:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236236AbiEOKOd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 15 May 2022 06:14:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236251AbiEOKOc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 15 May 2022 06:14:32 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C81F83D1FA;
        Sun, 15 May 2022 03:14:30 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4L1JC656JHz4xYY;
        Sun, 15 May 2022 20:14:26 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Shuah Khan <shuah@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Haowen Bai <baihaowen@meizu.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
In-Reply-To: <1650788802-14402-1-git-send-email-baihaowen@meizu.com>
References: <1650788802-14402-1-git-send-email-baihaowen@meizu.com>
Subject: Re: [PATCH] selftests/powerpc/pmu: Fix unsigned function returning negative constant
Message-Id: <165260953752.1040779.16790511150750388387.b4-ty@ellerman.id.au>
Date:   Sun, 15 May 2022 20:12:17 +1000
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

On Sun, 24 Apr 2022 16:26:41 +0800, Haowen Bai wrote:
> The function __perf_reg_mask has an unsigned return type, but returns a
> negative constant to indicate an error condition. So we change unsigned
> to int.
> 
> 

Applied to powerpc/next.

[1/1] selftests/powerpc/pmu: Fix unsigned function returning negative constant
      https://git.kernel.org/powerpc/c/a84ca704d8306a949578d36c028c8e1bab3dcf0b

cheers
