Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEB2172D84D
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Jun 2023 06:09:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232537AbjFMEJI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 13 Jun 2023 00:09:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbjFMEJH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 13 Jun 2023 00:09:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9869FE1;
        Mon, 12 Jun 2023 21:09:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3143161EEA;
        Tue, 13 Jun 2023 04:09:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19A33C433D2;
        Tue, 13 Jun 2023 04:09:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686629345;
        bh=gcYLEJmYhn8Y/B0gvoEFzJ/4hmgkUFsu0ldSHoSsl6g=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=JbtnMJXcWJFgFAi7Wx0GxQupFXlVzt/KQaJQItODG9bptE97nZcqSn1IX7ZQ99won
         ecXw59GLkcgOg8tdHNXWsr7Z6tu0rmAQNqwK3FK4YJPXidXAK1jAdAp5tMkqjCy8yM
         CWhdfY2WaQEs3kMky3Z+S+2YuPBUOYERXSL0JVz/OrDcjE2o5aEsFI4BHMnDP62e9c
         1GgX1PeKY/F8ThND0q9lG54yuJqpIsqycnuuWjWZ/fWStarM+Ay8gN3Jb8crIyRKfU
         szutEdixjzJkDZuLEO+DIYWUTSojEBDkNIn94lcEfDfQk3/cQ0g6/+Le8zJM39gA34
         vBYmF+qG0PVPg==
Date:   Mon, 12 Jun 2023 21:09:04 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Magali Lemes <magali.lemes@canonical.com>
Cc:     davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
        shuah@kernel.org, vfedorenko@novek.ru,
        tianjia.zhang@linux.alibaba.com, andrei.gherzan@canonical.com,
        netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/4] selftests: net: tls: check if FIPS mode is
 enabled
Message-ID: <20230612210904.1023f312@kernel.org>
In-Reply-To: <20230612125107.73795-3-magali.lemes@canonical.com>
References: <20230612125107.73795-1-magali.lemes@canonical.com>
        <20230612125107.73795-3-magali.lemes@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, 12 Jun 2023 09:51:05 -0300 Magali Lemes wrote:
> @@ -406,6 +415,7 @@ static void chunked_sendfile(struct __test_metadata *_metadata,
>  
>  TEST_F(tls, multi_chunk_sendfile)
>  {
> +
>  	chunked_sendfile(_metadata, self, 4096, 4096);
>  	chunked_sendfile(_metadata, self, 4096, 0);
>  	chunked_sendfile(_metadata, self, 4096, 1);

nit: leftover change, with that fixed feel free to add:

Reviewed-by: Jakub Kicinski <kuba@kernel.org>
-- 
pw-bot: cr
