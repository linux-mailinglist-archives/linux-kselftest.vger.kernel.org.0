Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 793AF55AC1F
	for <lists+linux-kselftest@lfdr.de>; Sat, 25 Jun 2022 21:25:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233365AbiFYSzI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 25 Jun 2022 14:55:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233151AbiFYSzH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 25 Jun 2022 14:55:07 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B807313E17;
        Sat, 25 Jun 2022 11:55:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 77359B8090B;
        Sat, 25 Jun 2022 18:55:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92CD1C3411C;
        Sat, 25 Jun 2022 18:55:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656183304;
        bh=A3qyjjsryOa7J2ItedKhH4Huf5P8CnU7F9RxA8YtExY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bE4wbfvrEbUAIra0inC54hOjX2MLei7fmRLTWkzI0bjriYQ8tC4aplpduwqYQ9WeU
         S7vZxu9v0AoP6N97ZU44DvFgmpdue7Ia40a6QihNi4Zfy50QQHKQ2mBrE6sxq0bQi2
         MHEVLY0oMatkOeVtpOTHui74lmHRXw6crxRjUPL3tjCCjld/ZU81u6jawZzLZL94fM
         Cb1IsPi5MuPEr5CJ6qm8aeL8tbmV4DTStAZ2EvwGBWAzAQsKlDxQHMz1Thpupg52ff
         FHjVUEB2J5dW1c2AZ6xJIVQBqjCx0rBhn4SN2lYRd0qY65lMOus51IfM8AzIcDlyEZ
         J3Cp623rZCoPA==
From:   SeongJae Park <sj@kernel.org>
To:     Gautam <gautammenghani201@gmail.com>
Cc:     sj@kernel.org, shuah@kernel.org, damon@lists.linux.dev,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] kselftests/damon: add support for cases where debugfs cannot be read
Date:   Sat, 25 Jun 2022 18:55:01 +0000
Message-Id: <20220625185501.85168-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220625083513.19761-1-gautammenghani201@gmail.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Gautam,

On Sat, 25 Jun 2022 14:05:13 +0530 Gautam <gautammenghani201@gmail.com> wrote:

> The kernel is in lockdown mode when secureboot is enabled and hence
> debugfs cannot be used. Add support for this and other general cases 
> where debugfs cannot be read and communicate the same to the user before
> running tests.
> 
> Signed-off-by: Gautam <gautammenghani201@gmail.com>

All looks good, thank you!  I left one comment below, though.  After fixing it,
you may have

Reviewed-by: SeongJae Park <sj@kernel.org>


> ---
> Changes in v2:
> 1. Modify the error message to account for general cases.
> 2. Change the return code so that the test is skipped.
> 
> Changes in v3:
> 1. Change the name of variable holding the error message.
> 
>  tools/testing/selftests/damon/_chk_dependency.sh | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>  mode change 100644 => 100755 tools/testing/selftests/damon/_chk_dependency.sh

I think this permission change is unnecessary?


Thanks,
SJ

> 
> diff --git a/tools/testing/selftests/damon/_chk_dependency.sh b/tools/testing/selftests/damon/_chk_dependency.sh
> old mode 100644
> new mode 100755
> index 0189db81550b..0328ac0b5a5e
> --- a/tools/testing/selftests/damon/_chk_dependency.sh
> +++ b/tools/testing/selftests/damon/_chk_dependency.sh
> @@ -26,3 +26,13 @@ do
>  		exit 1
>  	fi
>  done
> +
> +permission_error="Operation not permitted"
> +for f in attrs target_ids monitor_on
> +do
> +	status=$( cat "$DBGFS/$f" 2>&1 )
> +	if [ "${status#*$permission_error}" != "$status" ]; then
> +		echo "Permission for reading $DBGFS/$f denied; maybe secureboot enabled?"
> +		exit $ksft_skip
> +	fi
> +done
> -- 
> 2.36.1
