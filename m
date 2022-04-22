Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FE9050BABC
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Apr 2022 16:53:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1448938AbiDVO4D (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 22 Apr 2022 10:56:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1448951AbiDVOz7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 22 Apr 2022 10:55:59 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBBBA5C36E;
        Fri, 22 Apr 2022 07:53:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 811FEB8307B;
        Fri, 22 Apr 2022 14:53:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92041C385A4;
        Fri, 22 Apr 2022 14:53:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1650639183;
        bh=T9UBwXuqufvpPkwkvMfLrSuvMpCvswDkzG2OAhXGXms=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gtR6ueBjj90k6uXG+sGb62mjEPhUyWqCc4g/LYsDAGDC86QvoXlQYy95NhT2btdF8
         P0xl3sQ3qmwmyqmSN38lcytsJbQgKvLmqdrL0dhCwz49yEBz1tKjoPpydxABJtmKdz
         GxSusnTu+4goI0K1PWwTnb2+/G0VhcVxFy2lzYdc=
Date:   Fri, 22 Apr 2022 16:53:00 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "T.J. Mercier" <tjmercier@google.com>
Cc:     daniel@ffwll.ch, tj@kernel.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Jonathan Corbet <corbet@lwn.net>,
        Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <brauner@kernel.org>,
        Hridya Valsaraju <hridya@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Liam Mark <lmark@codeaurora.org>,
        Laura Abbott <labbott@redhat.com>,
        Brian Starkey <Brian.Starkey@arm.com>,
        John Stultz <john.stultz@linaro.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shuah Khan <shuah@kernel.org>, jstultz@google.com,
        cmllamas@google.com, kaleshsingh@google.com, Kenny.Ho@amd.com,
        mkoutny@suse.com, skhan@linuxfoundation.org,
        kernel-team@android.com, dri-devel@lists.freedesktop.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
        cgroups@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [RFC v5 0/6] Proposal for a GPU cgroup controller
Message-ID: <YmLBTBd+5RHzr9MK@kroah.com>
References: <20220420235228.2767816-1-tjmercier@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220420235228.2767816-1-tjmercier@google.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Apr 20, 2022 at 11:52:18PM +0000, T.J. Mercier wrote:
> This patch series revisits the proposal for a GPU cgroup controller to
> track and limit memory allocations by various device/allocator
> subsystems. The patch series also contains a simple prototype to
> illustrate how Android intends to implement DMA-BUF allocator
> attribution using the GPU cgroup controller. The prototype does not
> include resource limit enforcements.
> 
> Changelog:
> v5:
> Rebase on top of v5.18-rc3

Why is a "RFC" series on v5?  I treat "RFC" as "not ready to be merged,
if people are interested, please look at it".  But v5 seems like you
think this is real.

confused,

greg k-h
