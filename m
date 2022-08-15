Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5E4259279E
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Aug 2022 03:55:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229450AbiHOBzI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 14 Aug 2022 21:55:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiHOBzH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 14 Aug 2022 21:55:07 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9DE55F71;
        Sun, 14 Aug 2022 18:55:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7DE6AB80B99;
        Mon, 15 Aug 2022 01:55:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFFE6C433C1;
        Mon, 15 Aug 2022 01:55:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1660528504;
        bh=jjaPnk42QQFvYnkLBLhu9HPiINUfz6WQyKgWadvtTxg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=T3Ylg+E0gAJcw6O1SKZIdvzswyo5Z9JwPs9+wfpG1LKO/G2nFW5DIwU3/F3/G5Bmd
         pz3iIII1k1/flWtbG1uFh+lqSMq+rzvTnHHwJ7YGRgOev985J64qFto+nxm63h7iH+
         pfdOJ/lwDhs04sap0laWDFcGeMjZHzQ1uic52h58=
Date:   Sun, 14 Aug 2022 18:55:03 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Joel Savitz <jsavitz@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        Nico Pache <npache@redhat.com>
Subject: Re: [PATCH] selftests/vm: enable running select groups of tests
Message-Id: <20220814185503.bf75150dee058db574797d07@linux-foundation.org>
In-Reply-To: <20220705185605.3889110-1-jsavitz@redhat.com>
References: <20220705185605.3889110-1-jsavitz@redhat.com>
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

On Tue,  5 Jul 2022 14:56:05 -0400 Joel Savitz <jsavitz@redhat.com> wrote:

> Add the ability to run one or more groups of vm tests (specified
> by the environment variable TEST_ITEMS). Preserve existing default
> behavior of running all tests when TEST_ITEMS is empty or "default".

Why are we doing this?   Please describe the use case - something I
can add to the changelog.
