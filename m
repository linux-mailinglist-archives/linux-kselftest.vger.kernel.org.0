Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6919A567879
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Jul 2022 22:35:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231196AbiGEUe7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 5 Jul 2022 16:34:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbiGEUe6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 5 Jul 2022 16:34:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FCBB11476;
        Tue,  5 Jul 2022 13:34:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AFA4D61BD9;
        Tue,  5 Jul 2022 20:34:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC752C341C7;
        Tue,  5 Jul 2022 20:34:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1657053297;
        bh=JnJYDsv1xJL+frNlNtapPlb/coEeft/5LJNSa+eBRkk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=V6UaodJICGMrItkQ59G/i0I2Ou1epMY9I0wtL0xygUBTIw8Wvsd89cnuaXfBtP3AB
         PL2HhdXfuM1rG5Z3I6cO/GauugrdtYHGqYMFZd/1EwIP3y5/sVcYm3d430SzVuYPvB
         2o+NtPfMgTGSl8Q1Atz+wVZF/FHZMg81amD6GR5A=
Date:   Tue, 5 Jul 2022 13:34:56 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Joel Savitz <jsavitz@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        Nico Pache <npache@redhat.com>
Subject: Re: [PATCH] selftests/vm: enable running select groups of tests
Message-Id: <20220705133456.d5572b2e36ebb36188369988@linux-foundation.org>
In-Reply-To: <20220705185605.3889110-1-jsavitz@redhat.com>
References: <20220705185605.3889110-1-jsavitz@redhat.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
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

What is the reason for this?  What's the use case?

And why via the environment rather than via commandline args?
