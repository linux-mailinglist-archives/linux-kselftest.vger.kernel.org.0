Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3A0B78B7EF
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Aug 2023 21:15:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233295AbjH1TO5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 28 Aug 2023 15:14:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233298AbjH1TOk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 28 Aug 2023 15:14:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C300910E
        for <linux-kselftest@vger.kernel.org>; Mon, 28 Aug 2023 12:14:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 613296145E
        for <linux-kselftest@vger.kernel.org>; Mon, 28 Aug 2023 19:14:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41B71C433C7;
        Mon, 28 Aug 2023 19:14:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693250076;
        bh=2NTZTvnMlL+IAzhEdSEC+MihfBPJt2Hq6WGmu/EcsCw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=LmFYHZSid0kPQkk4tHp1uN9yeFoJNnnY0NK+PFwI8PujYYnwf4Pe5f4civw2leoVd
         uhFjh00QXRqfb+23LOunnXXAQ70Hy8pJO3x2e47M4IHuhcMBdCLm+dmWrc0KKwnfaN
         klC3Uyj6rGYkJj7eQsDquIazZe7Ga0qYnOh2G9FuZMMJzz3WdYx/L684wq0j1Y+8hI
         MKbZKvtEYo8cEGhrwOjleIy6SJb6B/znv241teL7eKYQA1jbi5ZNm6VWn9+E3RXq9Q
         YGhwxIUs1VkJug7aI8rJiJra6fwOdYopZU8a5L6BFKfEVSse7LLoUoYD31z1ow7Ohh
         42zRDDoJg23yQ==
Date:   Mon, 28 Aug 2023 12:14:35 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Ido Schimmel <idosch@idosch.org>
Cc:     Sriram Yagnaraman <sriram.yagnaraman@est.tech>, pabeni@redhat.com,
        netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        David Ahern <dsahern@kernel.org>,
        Ido Schimmel <idosch@nvidia.com>,
        Shuah Khan <shuah@kernel.org>, Petr Machata <petrm@nvidia.com>
Subject: Re: [PATCH net v3 3/3] selftests: fib_tests: Add multipath list
 receive tests
Message-ID: <20230828121435.3b76c138@kernel.org>
In-Reply-To: <ZOy8JOjw9W4g8fYa@shredder>
References: <20230828113221.20123-1-sriram.yagnaraman@est.tech>
        <20230828113221.20123-4-sriram.yagnaraman@est.tech>
        <ZOy8JOjw9W4g8fYa@shredder>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, 28 Aug 2023 18:24:20 +0300 Ido Schimmel wrote:
> Jakub / Paolo, this change conflicts with changes in net-next and I
> assume that the next PR that you are going to send is from net-next.
> What is your preference in this case? Wait for the PR to be accepted and
> for master to be merged into net?

The trees will be merged before the PR, in the next 24h.
As soon as they are you can resend for net-next.
