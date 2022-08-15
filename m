Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8202A5927A1
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Aug 2022 03:56:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbiHOB4x (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 14 Aug 2022 21:56:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiHOB4w (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 14 Aug 2022 21:56:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5CCA12629;
        Sun, 14 Aug 2022 18:56:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7FEEE60FAF;
        Mon, 15 Aug 2022 01:56:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B3F0C433D6;
        Mon, 15 Aug 2022 01:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1660528610;
        bh=E+POgprZP2CXzwYKE7pYCzxT7PkjComH27PjV4PNA+g=;
        h=Date:From:To:Subject:In-Reply-To:References:From;
        b=JkuXSqpApuALY+WTVmNWc38heLV2+d1KIWHSrKHb5TYB5LLyo5ziGtWNbovjFhrLp
         0oUU+Dqsii9Sa4INM9Sj4HLMzwyrSl+/8BJOjfA5icmwbGXJdXZj+JZema/lrnkN1I
         bkQgZ5+YIRhWL6Xm97vuo6M4VWLa4g4C46vtuuJo=
Date:   Sun, 14 Aug 2022 18:56:49 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Joel Savitz <jsavitz@redhat.com>, linux-kernel@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, Nico Pache <npache@redhat.com>
Subject: Re: [PATCH] selftests/vm: enable running select groups of tests
Message-Id: <20220814185649.3303b34cfabcaf450c661b4b@linux-foundation.org>
In-Reply-To: <20220814185503.bf75150dee058db574797d07@linux-foundation.org>
References: <20220705185605.3889110-1-jsavitz@redhat.com>
        <20220814185503.bf75150dee058db574797d07@linux-foundation.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sun, 14 Aug 2022 18:55:03 -0700 Andrew Morton <akpm@linux-foundation.org> wrote:

> On Tue,  5 Jul 2022 14:56:05 -0400 Joel Savitz <jsavitz@redhat.com> wrote:
> 
> > Add the ability to run one or more groups of vm tests (specified
> > by the environment variable TEST_ITEMS). Preserve existing default
> > behavior of running all tests when TEST_ITEMS is empty or "default".
> 
> Why are we doing this?   Please describe the use case - something I
> can add to the changelog.

Old patch version, please ignore.
