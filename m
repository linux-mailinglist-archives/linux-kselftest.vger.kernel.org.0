Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFA8850C372
	for <lists+linux-kselftest@lfdr.de>; Sat, 23 Apr 2022 01:10:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232856AbiDVWcR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 22 Apr 2022 18:32:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232944AbiDVWcH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 22 Apr 2022 18:32:07 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D3F0324C79;
        Fri, 22 Apr 2022 14:54:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4FBCFB832C3;
        Fri, 22 Apr 2022 21:54:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4A48C385A4;
        Fri, 22 Apr 2022 21:54:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1650664497;
        bh=BHXV0YOJHr2WM2YchlEQurnNcQ9G+9t5xI2geAAdRgY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=iGGqtTPs/Shjsut4v8AhxTjmcP0yty7k0GpImOSyAPTRxxD261KW9ru192wle1d/g
         adYtTm/zXG/dElLaOgX66EwhRPAZb0wlWlW9e0weRuVHMTfsNlfjyoW0DybS5Q4tol
         pXMW/S6T5UanpnUXjYtXemKFzxfpHNEHTX/b0vV4=
Date:   Fri, 22 Apr 2022 14:54:56 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Axel Rasmussen <axelrasmussen@google.com>
Cc:     Shuah Khan <shuah@kernel.org>, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] selftests: vm: refactor run_vmtests.sh to reduce
 boilerplate
Message-Id: <20220422145456.1e9f22220b1ad502aa56628d@linux-foundation.org>
In-Reply-To: <20220421224928.1848230-1-axelrasmussen@google.com>
References: <20220421224928.1848230-1-axelrasmussen@google.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, 21 Apr 2022 15:49:27 -0700 Axel Rasmussen <axelrasmussen@google.com> wrote:

> Previously, each test printed out its own header, dealt with its own
> return code, etc. By just putting this standard stuff in a function, we
> can delete > 300 lines from the script.
> 
> This also makes adding future tests easier. And, it gets rid of various
> inconsistencies that already exist:
> 
> - Some tests correctly deal with ksft_skip, but others don't.
> - Some tests just print the executable name, others print arguments, and
>   yet others print some comment in the header.
> - Most tests print out a header with two separator lines, but not the
>   HMM smoke test or the memfd_secret test, which only print one.
> - We had a redundant "exit" at the end, with all the boilerplate it's an
>   easy oversight.
> 
> Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
> ---
>  tools/testing/selftests/vm/run_vmtests.sh | 459 +++-------------------
>  1 file changed, 64 insertions(+), 395 deletions(-)

Well that's nice.

There were a bunch of changes already pending in this file but I think
with this patch, they become unneeded.  So I just reverted them all. 
please double check?


--- a/tools/testing/selftests/vm/run_vmtests.sh~revert-1
+++ a/tools/testing/selftests/vm/run_vmtests.sh
@@ -162,32 +162,22 @@ echo "----------------------------------
 echo "running: gup_test -u # get_user_pages_fast() benchmark"
 echo "------------------------------------------------------"
 ./gup_test -u
-ret_val=$?
-
-if [ $ret_val -eq 0 ]; then
-	echo "[PASS]"
-elif [ $ret_val -eq $ksft_skip ]; then
-	 echo "[SKIP]"
-	 exitcode=$ksft_skip
-else
+if [ $? -ne 0 ]; then
 	echo "[FAIL]"
 	exitcode=1
+else
+	echo "[PASS]"
 fi
 
 echo "------------------------------------------------------"
 echo "running: gup_test -a # pin_user_pages_fast() benchmark"
 echo "------------------------------------------------------"
 ./gup_test -a
-ret_val=$?
-
-if [ $ret_val -eq 0 ]; then
-	echo "[PASS]"
-elif [ $ret_val -eq $ksft_skip ]; then
-	 echo "[SKIP]"
-	 exitcode=$ksft_skip
-else
+if [ $? -ne 0 ]; then
 	echo "[FAIL]"
 	exitcode=1
+else
+	echo "[PASS]"
 fi
 
 echo "------------------------------------------------------------"
@@ -195,16 +185,11 @@ echo "# Dump pages 0, 19, and 4096, usin
 echo "running: gup_test -ct -F 0x1 0 19 0x1000 # dump_page() test"
 echo "------------------------------------------------------------"
 ./gup_test -ct -F 0x1 0 19 0x1000
-ret_val=$?
-
-if [ $ret_val -eq 0 ]; then
-	echo "[PASS]"
-elif [ $ret_val -eq $ksft_skip ]; then
-	 echo "[SKIP]"
-	 exitcode=$ksft_skip
-else
+if [ $? -ne 0 ]; then
 	echo "[FAIL]"
 	exitcode=1
+else
+	echo "[PASS]"
 fi
 
 echo "-------------------"
@@ -306,16 +291,11 @@ echo "-------------------"
 echo "running mremap_test"
 echo "-------------------"
 ./mremap_test
-ret_val=$?
-
-if [ $ret_val -eq 0 ]; then
-	echo "[PASS]"
-elif [ $ret_val -eq $ksft_skip ]; then
-	 echo "[SKIP]"
-	 exitcode=$ksft_skip
-else
+if [ $? -ne 0 ]; then
 	echo "[FAIL]"
 	exitcode=1
+else
+	echo "[PASS]"
 fi
 
 echo "-----------------"
_

