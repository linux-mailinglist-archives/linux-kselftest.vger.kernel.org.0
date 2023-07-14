Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B18E753FD0
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Jul 2023 18:26:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235481AbjGNQ0E (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 14 Jul 2023 12:26:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235420AbjGNQ0D (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 14 Jul 2023 12:26:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9C43E5C;
        Fri, 14 Jul 2023 09:26:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8455061D64;
        Fri, 14 Jul 2023 16:26:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E984C433C8;
        Fri, 14 Jul 2023 16:26:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1689351961;
        bh=KCFwww0adoGf6GZfuD46kIOEeyzUE+Wl2mPsDM1NWt4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=U3hJr6yptiENG5+P4pTdJ4lu2ZZVsSmnGoiFUuyvbqnRlqCIK5lGbx4RLJELgTbXl
         8+bjROiicIQkjcwgV7PPXVKR70O/hSTxjt0IjRLMUFneu5loLRN6lJajiZ7c2EtBN5
         +riPYEZcT7KDYw08UJP0wVlHGxiUFmzZNJ451UvU=
Date:   Fri, 14 Jul 2023 09:26:00 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Ryan Roberts <ryan.roberts@arm.com>
Cc:     SeongJae Park <sj@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        =?ISO-8859-1?Q?J=E9r=F4me?= Glisse <jglisse@redhat.com>,
        Mark Brown <broonie@kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Florent Revest <revest@chromium.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v1 2/9] selftests/mm: Give scripts execute permission
Message-Id: <20230714092600.5cdf5844098a2de728a1750b@linux-foundation.org>
In-Reply-To: <7935c31a-6c47-95c8-d6bd-176b81046699@arm.com>
References: <20230713173237.66285-1-sj@kernel.org>
        <7935c31a-6c47-95c8-d6bd-176b81046699@arm.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, 14 Jul 2023 10:44:14 +0100 Ryan Roberts <ryan.roberts@arm.com> wrote:

> Thanks for the detailed explanation. Are you effectively saying this patch will
> turn into a no-op once its been munged through the various patch management
> tools? That's disappointing because it's a pain to have to invoke everything
> though bash explicitly. Many other scripts manage to have the correct execute
> permission set (see everything in ./scripts for example).

Such patches need delicate handling :(

I queued this as a standalone thing, for 6.5-rcx.
