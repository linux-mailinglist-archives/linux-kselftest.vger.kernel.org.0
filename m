Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DC8B5192A2
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 May 2022 02:16:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232574AbiEDAUC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 3 May 2022 20:20:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230071AbiEDAUB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 3 May 2022 20:20:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 233CA42A0F;
        Tue,  3 May 2022 17:16:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 123AE61831;
        Wed,  4 May 2022 00:16:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E05AC385A9;
        Wed,  4 May 2022 00:16:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651623386;
        bh=f0fsh6Uc4bvfHGbrVz3cXfk5QnV5TefLA9ufcSBuzxo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jscYW4T6U4umNohgMaY+Q1fsw/2XLRV9HG6KGqA7hbElV2MUqKTNqWUNrWIzCPO+D
         DxLer4Vou9TOXU04cV+vjPps/7rBvHKiPvGihZ9HITtGt6tu0ViOxpR+c5EnMuevv3
         H9cciHi9w6Yamms/5Oxq6isF9k0chkjeMeEnzaVtrVTV7GrDvEm+5p0wJWn1eUYJIe
         CqiXkYZlgCehLWtI7Ml1KbtHSptjfzGyePKOZmkzfHB4EWKs4WFd0WohQ9PexgVhTc
         ejw3pgQO3A6oec9GV++fR7Ffj+7H025rTCT82vPLLCQ5miMpoi3TQN3i8jPL3rMsZT
         5XWJwcpifeyyw==
From:   SeongJae Park <sj@kernel.org>
To:     Yuanchu Xie <yuanchu@google.com>
Cc:     Shuah Khan <shuah@kernel.org>, Markus Boehme <markubo@amazon.de>,
        SeongJae Park <sj@kernel.org>, rientjes@google.com,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] selftests/damon: add damon to selftests root Makefile
Date:   Wed,  4 May 2022 00:16:22 +0000
Message-Id: <20220504001622.132117-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220504000358.1174849-2-yuanchu@google.com>
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

On Wed, 4 May 2022 00:03:58 +0000 Yuanchu Xie <yuanchu@google.com> wrote:

> Currently the damon selftests are not built with the rest of the
> selftests. We add damon to the list of targets.
> 
> Fixes: b348eb7abd09 ("mm/damon: add user space selftests")
> Signed-off-by: Yuanchu Xie <yuanchu@google.com>

Reviewed-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

> ---
>  tools/testing/selftests/Makefile | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
> index 2319ec87f53d..bd2ac8b3bf1f 100644
> --- a/tools/testing/selftests/Makefile
> +++ b/tools/testing/selftests/Makefile
> @@ -9,6 +9,7 @@ TARGETS += clone3
>  TARGETS += core
>  TARGETS += cpufreq
>  TARGETS += cpu-hotplug
> +TARGETS += damon
>  TARGETS += drivers/dma-buf
>  TARGETS += efivarfs
>  TARGETS += exec
> -- 
> 2.36.0.464.gb9c8b46e94-goog
