Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88B86647002
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Dec 2022 13:50:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbiLHMuY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 8 Dec 2022 07:50:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230184AbiLHMuA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 8 Dec 2022 07:50:00 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1F4A8E592;
        Thu,  8 Dec 2022 04:49:55 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NSYry19v5z4xvR;
        Thu,  8 Dec 2022 23:49:54 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Nicholas Piggin <npiggin@gmail.com>,
        linux-kselftest@vger.kernel.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Shuah Khan <shuah@kernel.org>, linuxppc-dev@lists.ozlabs.org,
        Miaoqian Lin <linmq006@gmail.com>,
        Anshuman Khandual <khandual@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221205084429.570654-1-linmq006@gmail.com>
References: <20221205084429.570654-1-linmq006@gmail.com>
Subject: Re: [PATCH] selftests/powerpc: Fix resource leaks
Message-Id: <167050321517.1457988.92380060922256003.b4-ty@ellerman.id.au>
Date:   Thu, 08 Dec 2022 23:40:15 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, 5 Dec 2022 12:44:27 +0400, Miaoqian Lin wrote:
> In check_all_cpu_dscr_defaults, opendir() opens the directory stream.
> Add missing closedir() in the error path to release it.
> 
> In check_cpu_dscr_default, open() creates an open file descriptor.
> Add missing close() in the error path to release it.
> 
> 
> [...]

Applied to powerpc/next.

[1/1] selftests/powerpc: Fix resource leaks
      https://git.kernel.org/powerpc/c/8f4ab7da904ab7027ccd43ddb4f0094e932a5877

cheers
