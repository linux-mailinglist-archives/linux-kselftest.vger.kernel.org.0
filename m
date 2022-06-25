Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8B9655AC43
	for <lists+linux-kselftest@lfdr.de>; Sat, 25 Jun 2022 22:04:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233386AbiFYUDj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 25 Jun 2022 16:03:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233374AbiFYUDj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 25 Jun 2022 16:03:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5128914099;
        Sat, 25 Jun 2022 13:03:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D70B660EF8;
        Sat, 25 Jun 2022 20:03:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70B63C3411C;
        Sat, 25 Jun 2022 20:03:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656187417;
        bh=BWeR0SUqiVtogg11CTKEDR7vQjoaisWfSZKgU4PshMg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aGtXbY+/cvxOUWVl1/9H6NVBmQQy88ag5fLvY7IyuHs5Mh6hNa3I8FnzxrRPNcUoE
         pF+99qRLy+ZuZLIWEnW++pJ2nayl4ywHcKXTjLVCXWoddXV4PFy0ZpaWnikrZS3ypO
         InQ6JR6Vl+TKqZRwCFhCp3MLpotakpU1TrkuCgSmE8Zs5miJ526CKeiVMYoXZnyuBx
         K4jJl18oJ+vCYsE1c1BbtgJovjNraG00X8U1OvIkxhHkb/xdBg3xTKY3mZoZxypgWm
         P3MaecMfx6zC/MaortF4U/UAvlsi2ZM83GP5q/ULb3qaGV0QpzW4r4WIt8u1hEtNyE
         En58Hnv1ZBagQ==
From:   SeongJae Park <sj@kernel.org>
To:     Gautam <gautammenghani201@gmail.com>
Cc:     sj@kernel.org, shuah@kernel.org, damon@lists.linux.dev,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] kselftests/damon: add support for cases where debugfs cannot be read
Date:   Sat, 25 Jun 2022 20:03:34 +0000
Message-Id: <20220625200334.83818-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220625195245.4368-1-gautammenghani201@gmail.com>
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

On Sun, 26 Jun 2022 01:22:45 +0530 Gautam <gautammenghani201@gmail.com> wrote:

> The kernel is in lockdown mode when secureboot is enabled and hence
> debugfs cannot be used. Add support for this and other general cases 
> where debugfs cannot be read and communicate the same to the user before
> running tests.
> 
> Signed-off-by: Gautam <gautammenghani201@gmail.com>

Reviewed-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

> ---
> Changes in v2:
> 1. Modify the error message to account for general cases.
> 2. Change the return code so that the test is skipped.
> 
> Changes in v3:
> 1. Change the name of variable holding the error message.
> 
> Changes in v4:
> 1. Correct the mode of the source file.
> 
>  tools/testing/selftests/damon/_chk_dependency.sh | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/tools/testing/selftests/damon/_chk_dependency.sh b/tools/testing/selftests/damon/_chk_dependency.sh
> index 0189db81550b..0328ac0b5a5e 100644
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
