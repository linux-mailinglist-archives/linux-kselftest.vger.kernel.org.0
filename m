Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 206C74E43E4
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Mar 2022 17:07:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237104AbiCVQIu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 22 Mar 2022 12:08:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236568AbiCVQIs (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 22 Mar 2022 12:08:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37E848D68F;
        Tue, 22 Mar 2022 09:07:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D1A5261224;
        Tue, 22 Mar 2022 16:07:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBD3BC340F2;
        Tue, 22 Mar 2022 16:07:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647965240;
        bh=uSOOq0K0AgKLPEeuKOwHFh4OYgLE2Hvt3voMGhHzT6o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fQPHI71f0BUCbQYIhPaRBwike/7mbu7HfbqKAyTZyeXxvTFSZBW8OJHw75FyNjjct
         TkJ06nuufpzYFl30PfmHHBsdFoAVO/Rx0Py/EjuoAKDdpB/pe2RWuS3m6aOIijxKqc
         4QUbiO92sHlJvwFEXOPCHmImzlFcOAhg54Q+11qL1v3uqtjpAMaTzXM5VBvwNrUQaM
         0pDSwIOEuTE6bHlxoGYzBa9s329CV9bgmt8q09zcbRbyvOe2RQxTg2mokYrSjoByFw
         q9ZWxV41RiPsyAX4zQlvXxD0pIV62dPOK62WraDz62dbu/RjKCEGPO0AZga3dK4b2/
         RdPvbVQNl8fyQ==
Date:   Tue, 22 Mar 2022 17:07:09 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     Todd Kjos <tkjos@google.com>
Cc:     "T.J. Mercier" <tjmercier@google.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arve =?utf-8?B?SGrDuG5uZXbDpWc=?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Hridya Valsaraju <hridya@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Liam Mark <lmark@codeaurora.org>,
        Laura Abbott <labbott@redhat.com>,
        Brian Starkey <Brian.Starkey@arm.com>,
        John Stultz <john.stultz@linaro.org>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shuah Khan <shuah@kernel.org>, kaleshsingh@google.com,
        Kenny.Ho@amd.com, dri-devel@lists.freedesktop.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
        cgroups@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [RFC v3 8/8] selftests: Add binder cgroup gpu memory transfer
 test
Message-ID: <20220322160709.rcbjgqdoar7lvbox@wittgenstein>
References: <20220309165222.2843651-1-tjmercier@google.com>
 <20220309165222.2843651-9-tjmercier@google.com>
 <CAHRSSEwN4Xuo2vLt8d2QfJbNOK21VB7_NjjbO_XGDz6pYUaXZg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHRSSEwN4Xuo2vLt8d2QfJbNOK21VB7_NjjbO_XGDz6pYUaXZg@mail.gmail.com>
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Mar 14, 2022 at 05:43:40PM -0700, Todd Kjos wrote:
> On Wed, Mar 9, 2022 at 8:53 AM T.J. Mercier <tjmercier@google.com> wrote:
> >
> > This test verifies that the cgroup GPU memory charge is transferred
> > correctly when a dmabuf is passed between processes in two different
> > cgroups and the sender specifies BINDER_BUFFER_FLAG_SENDER_NO_NEED in the
> > binder transaction data containing the dmabuf file descriptor.
> >
> > Signed-off-by: T.J. Mercier <tjmercier@google.com>
> 
> Reviewed-by: Todd Kjos <tkjos@google.com>
> for the binder driver interactions. Need Christian to take a look at
> the binderfs interactions.

Sorry, just saw this now. I'll take a look tomorrow!
