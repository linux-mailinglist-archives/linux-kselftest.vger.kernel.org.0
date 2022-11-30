Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C041063D1F3
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Nov 2022 10:32:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233789AbiK3JcV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 30 Nov 2022 04:32:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233880AbiK3Jbd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 30 Nov 2022 04:31:33 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00C0C55A93;
        Wed, 30 Nov 2022 01:31:32 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NMYql3stGz4xTw;
        Wed, 30 Nov 2022 20:31:31 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-kselftest@vger.kernel.org,
        Colin Ian King <colin.i.king@gmail.com>,
        Shuah Khan <shuah@kernel.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linuxppc-dev@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
In-Reply-To: <20221021084545.65973-1-colin.i.king@gmail.com>
References: <20221021084545.65973-1-colin.i.king@gmail.com>
Subject: Re: [PATCH] selftests/powerpc: Fix spelling mistake "mmaping" -> "mmapping"
Message-Id: <166980025183.3017288.8121920354602330062.b4-ty@ellerman.id.au>
Date:   Wed, 30 Nov 2022 20:24:11 +1100
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

On Fri, 21 Oct 2022 09:45:45 +0100, Colin Ian King wrote:
> There is a spelling mistake in a perror message. Fix it.
> 
> 

Applied to powerpc/next.

[1/1] selftests/powerpc: Fix spelling mistake "mmaping" -> "mmapping"
      https://git.kernel.org/powerpc/c/04757c5e21ea17615b66f45e38f1cab32a7a0654

cheers
