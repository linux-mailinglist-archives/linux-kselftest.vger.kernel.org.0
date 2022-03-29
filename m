Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95DFF4EB01C
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Mar 2022 17:21:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235516AbiC2PX3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 29 Mar 2022 11:23:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232090AbiC2PX3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 29 Mar 2022 11:23:29 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48CA37CB02;
        Tue, 29 Mar 2022 08:21:45 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 4FBEE1FD0A;
        Tue, 29 Mar 2022 15:21:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1648567304; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=n/czKHIPapnBxpdu79ODwmVGjcsUIWEmGzncRJ5TN4Q=;
        b=lbxalIk0hgBTc9ZrvdtVK14x3u1oqMDVbsoiIWRU/HZAKUtFdn9xuq+x4VdQSqRv2NIzra
        6u7dg24T8Ka4DRgQdxJkMClNHbD8rd8VMmEUcF8AeBfKYtvlHup2tBTYs1n4gYuW4kxpnl
        lnJuwJXKKePEEilmmgnC19er+O83O34=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 755B913AB1;
        Tue, 29 Mar 2022 15:21:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id hsZZGwckQ2LkcwAAMHmgww
        (envelope-from <mkoutny@suse.com>); Tue, 29 Mar 2022 15:21:43 +0000
Date:   Tue, 29 Mar 2022 17:21:42 +0200
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     "T.J. Mercier" <tjmercier@google.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <brauner@kernel.org>,
        Hridya Valsaraju <hridya@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Liam Mark <lmark@codeaurora.org>,
        Laura Abbott <labbott@redhat.com>,
        Brian Starkey <Brian.Starkey@arm.com>,
        John Stultz <john.stultz@linaro.org>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shuah Khan <shuah@kernel.org>, kaleshsingh@google.com,
        Kenny.Ho@amd.com, skhan@linuxfoundation.org,
        dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linaro-mm-sig@lists.linaro.org, cgroups@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [RFC v4 5/8] dmabuf: Add gpu cgroup charge transfer function
Message-ID: <20220329152142.GA15794@blackbody.suse.cz>
References: <20220328035951.1817417-1-tjmercier@google.com>
 <20220328035951.1817417-6-tjmercier@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220328035951.1817417-6-tjmercier@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi.

On Mon, Mar 28, 2022 at 03:59:44AM +0000, "T.J. Mercier" <tjmercier@google.com> wrote:
> From: Hridya Valsaraju <hridya@google.com>
> 
> The dma_buf_charge_transfer function provides a way for processes to

(s/dma_bug_charge_transfer/dma_bug_transfer_charge/)

> transfer charge of a buffer to a different process. This is essential
> for the cases where a central allocator process does allocations for
> various subsystems, hands over the fd to the client who requested the
> memory and drops all references to the allocated memory.

I understood from [1] some buffers are backed by regular RAM. How are
these charges going to be transferred (if so)?


Thanks,
Michal

[1]
https://lore.kernel.org/r/CABdmKX2NSAKMC6rReMYfo2SSVNxEXcS466hk3qF6YFt-j-+_NQ@mail.gmail.com
