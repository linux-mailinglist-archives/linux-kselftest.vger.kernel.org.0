Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88CCE69C49B
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Feb 2023 04:51:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbjBTDvr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 19 Feb 2023 22:51:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230085AbjBTDvq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 19 Feb 2023 22:51:46 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C1A7CA23;
        Sun, 19 Feb 2023 19:51:45 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PKpPn0GRjz4x8S;
        Mon, 20 Feb 2023 14:51:41 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Shuah Khan <shuah@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        linux-kselftest@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     linux-kernel@vger.kernel.org
In-Reply-To: <20230127135755.79929-1-mathieu.desnoyers@efficios.com>
References: <20230127135755.79929-1-mathieu.desnoyers@efficios.com>
Subject: Re: (subset) [PATCH 00/34] selftests: Fix incorrect kernel headers search path
Message-Id: <167686495443.2406274.663246701426471015.b4-ty@ellerman.id.au>
Date:   Mon, 20 Feb 2023 14:49:14 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, 27 Jan 2023 08:57:21 -0500, Mathieu Desnoyers wrote:
> This series fixes incorrect kernel header search path in kernel
> selftests.
> 
> Near the end of the series, a few changes are not tagged as "Fixes"
> because the current behavior is to rely on the kernel sources uapi files
> rather than on the installed kernel header files. Nevertheless, those
> are updated for consistency.
> 
> [...]

Applied to powerpc/next.

[21/34] selftests: powerpc: Fix incorrect kernel headers search path
        https://git.kernel.org/powerpc/c/4f11410bf6da87defe8fd59b0413f0d9f71744da

cheers
