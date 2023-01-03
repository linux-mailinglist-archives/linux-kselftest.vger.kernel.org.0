Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4033E65C1EF
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Jan 2023 15:28:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233466AbjACO2x (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 3 Jan 2023 09:28:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233507AbjACO2W (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 3 Jan 2023 09:28:22 -0500
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 490B2204;
        Tue,  3 Jan 2023 06:28:20 -0800 (PST)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1pCiH3-0004Wl-PL; Tue, 03 Jan 2023 15:28:17 +0100
Date:   Tue, 3 Jan 2023 15:28:17 +0100
From:   Florian Westphal <fw@strlen.de>
To:     Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
Cc:     linux-kselftest@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Shuah Khan <shuah@kernel.org>, Florian Westphal <fw@strlen.de>,
        Jakub Kicinski <kuba@kernel.org>
Subject: Re: PROBLEM: Hang in selftests/netfilter/nft_trans_stress.sh
Message-ID: <20230103142817.GA19686@breakpoint.cc>
References: <281b5a5e-4b56-ef6f-9896-49b364924662@alu.unizg.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <281b5a5e-4b56-ef6f-9896-49b364924662@alu.unizg.hr>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr> wrote:
> Hi all,
> 
> The `make kselftest` hangs in netfilter/nft_trans_stress.sh test when testing 6.2.0-rc2
> (attempted 2 times, waiting half an hour at least):

This script completes in 49 seconds for me.

> # selftests: netfilter: nft_trans_stress.sh
> # PASS: nft add/delete test returned 0
> # PASS: nft reload test returned 0
> 
> The test script seems to be stuck in ping flood:

No, it gets stuck in the sub-test after 'PASS: nft reload test returned 0'

Can you send me the output of 'bash -x nft_trans_stress.sh'?
It should tell which command/program isn't making progress.
