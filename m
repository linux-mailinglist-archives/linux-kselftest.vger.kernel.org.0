Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3BA06A2E4A
	for <lists+linux-kselftest@lfdr.de>; Sun, 26 Feb 2023 06:08:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbjBZFI6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 26 Feb 2023 00:08:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjBZFI5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 26 Feb 2023 00:08:57 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8163BE399;
        Sat, 25 Feb 2023 21:08:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 04B8B60C04;
        Sun, 26 Feb 2023 05:08:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0588DC433D2;
        Sun, 26 Feb 2023 05:08:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1677388135;
        bh=DAfO6lgQfsX8e4eAz4Jp1wblc0DHfPpgZd2JsmuvcXc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=nm6CNxHGjw7mjWJMcGRqObe44yKeqZ1WvpXtlQcZeGSCAmlJRuD24SKXQ9OUXeWCj
         ZWpL9zBTkVCWxcz5xfEh/l6C+nSdgjrCUj+bKEodPfJ17U6rznW4aZaokV/iYUzTh2
         xuJbo62QRTs1vMUrEohN+0HIfBse9HjD0GgMbaGY=
Date:   Sat, 25 Feb 2023 21:08:54 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Stefan Roesch <shr@devkernel.io>
Cc:     kernel-team@fb.com, linux-mm@kvack.org, riel@surriel.com,
        mhocko@suse.com, david@redhat.com, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org, hannes@cmpxchg.org
Subject: Re: [PATCH v3 0/3] mm: process/cgroup ksm support
Message-Id: <20230225210854.25e93b1d94666aa13c269104@linux-foundation.org>
In-Reply-To: <20230224044000.3084046-1-shr@devkernel.io>
References: <20230224044000.3084046-1-shr@devkernel.io>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, 23 Feb 2023 20:39:57 -0800 Stefan Roesch <shr@devkernel.io> wrote:

> So far KSM can only be enabled by calling madvise for memory regions. To
> be able to use KSM for more workloads, KSM needs to have the ability to be
> enabled / disabled at the process / cgroup level.

I'll toss this in for integration and testing, but I'd like to see
reviewer input before proceeding further.

Please plan on adding suitable user-facing documentation?  Presumably a
patch for the prctl manpage?
