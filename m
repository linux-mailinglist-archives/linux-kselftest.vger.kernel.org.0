Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 759C965C39E
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Jan 2023 17:11:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233158AbjACQLO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 3 Jan 2023 11:11:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238057AbjACQLJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 3 Jan 2023 11:11:09 -0500
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F4E8DDB;
        Tue,  3 Jan 2023 08:11:04 -0800 (PST)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1pCjsT-000581-PA; Tue, 03 Jan 2023 17:11:01 +0100
Date:   Tue, 3 Jan 2023 17:11:01 +0100
From:   Florian Westphal <fw@strlen.de>
To:     Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
Cc:     Florian Westphal <fw@strlen.de>, linux-kselftest@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Shuah Khan <shuah@kernel.org>, Jakub Kicinski <kuba@kernel.org>
Subject: Re: PROBLEM: Hang in selftests/netfilter/nft_trans_stress.sh
Message-ID: <20230103161101.GB19686@breakpoint.cc>
References: <281b5a5e-4b56-ef6f-9896-49b364924662@alu.unizg.hr>
 <20230103142817.GA19686@breakpoint.cc>
 <11cc1fca-01b3-f83b-eb9e-3ceffd68b6d4@alu.unizg.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11cc1fca-01b3-f83b-eb9e-3ceffd68b6d4@alu.unizg.hr>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr> wrote:
> > Can you send me the output of 'bash -x nft_trans_stress.sh'?
> > It should tell which command/program isn't making progress.
> 
> Hi, Florian!
> 
> Well, when ran alone, the script ended successfully:
> 
> root@marvin-IdeaPad-3-15ITL6:/home/marvin/linux/kernel/linux_torvalds/tools/testing/selftests/netfilter# bash nft_trans_stress.sh
> PASS: nft add/delete test returned 0
> PASS: nft reload test returned 0
> PASS: nft add/delete with nftrace enabled test returned 0
> PASS: nft add/delete with nftrace enabled test returned 0
> root@marvin-IdeaPad-3-15ITL6:/home/marvin/linux/kernel/linux_torvalds/tools/testing/selftests/netfilter#
> 
> There was no stall after "nft reload test" in a standalone superuser run.

Hmm.  Does this patch make it work when running via 'make kselftest'?

diff --git a/tools/testing/selftests/netfilter/nft_trans_stress.sh b/tools/testing/selftests/netfilter/nft_trans_stress.sh
--- a/tools/testing/selftests/netfilter/nft_trans_stress.sh
+++ b/tools/testing/selftests/netfilter/nft_trans_stress.sh
@@ -10,12 +10,20 @@
 ksft_skip=4
 
 testns=testns-$(mktemp -u "XXXXXXXX")
+tmp=""
 
 tables="foo bar baz quux"
 global_ret=0
 eret=0
 lret=0
 
+cleanup() {
+	ip netns pids "$testns" | xargs kill 2>/dev/null
+	ip netns del "$testns"
+
+	rm -f "$tmp"
+}
+
 check_result()
 {
 	local r=$1
@@ -43,6 +51,7 @@ if [ $? -ne 0 ];then
 	exit $ksft_skip
 fi
 
+trap cleanup EXIT
 tmp=$(mktemp)
 
 for table in $tables; do
@@ -139,11 +148,4 @@ done
 
 check_result $lret "add/delete with nftrace enabled"
 
-pkill -9 ping
-
-wait
-
-rm -f "$tmp"
-ip netns del "$testns"
-
 exit $global_ret
