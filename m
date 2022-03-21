Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A4C44E2F53
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Mar 2022 18:45:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349453AbiCURrB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 21 Mar 2022 13:47:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238056AbiCURrA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 21 Mar 2022 13:47:00 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 448CE3B039;
        Mon, 21 Mar 2022 10:45:34 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B8B6C1F381;
        Mon, 21 Mar 2022 17:45:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1647884732; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=peglqrh0TeDc2F8OaZcmUkLDagjJhol7WzzofXyyxO4=;
        b=PnmDb1Bn2lmsEUIPSG3oXSY46IqI6iAnrhkUOd3imYGHhzUBGrywA4Q9uGXh7c/svUPKw5
        ngHuZu78cVggAJKMr47ybLtd326kLSE1NoNSHr9Gfg480gkY2G8m9HV1lQGRPPiKOrSgdz
        U10jIZn2E3ClJ36uP4+4GnMAPYs5WBQ=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AB410139DB;
        Mon, 21 Mar 2022 17:45:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id uViIKLu5OGIeUQAAMHmgww
        (envelope-from <mkoutny@suse.com>); Mon, 21 Mar 2022 17:45:31 +0000
Date:   Mon, 21 Mar 2022 18:45:30 +0100
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     "T.J. Mercier" <tjmercier@google.com>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
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
        Kenny.Ho@amd.com, dri-devel@lists.freedesktop.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
        cgroups@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [RFC v3 5/8] dmabuf: Add gpu cgroup charge transfer function
Message-ID: <20220321174530.GB9640@blackbody.suse.cz>
References: <20220309165222.2843651-1-tjmercier@google.com>
 <20220309165222.2843651-6-tjmercier@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220309165222.2843651-6-tjmercier@google.com>
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

Hello.

On Wed, Mar 09, 2022 at 04:52:15PM +0000, "T.J. Mercier" <tjmercier@google.com> wrote:
> +int dma_buf_charge_transfer(struct dma_buf *dmabuf, struct gpucg *gpucg)
> +{
> +#ifdef CONFIG_CGROUP_GPU
> +	struct gpucg *current_gpucg;
> +	int ret = 0;
> +
> +	/*
> +	 * Verify that the cgroup of the process requesting the transfer is the
> +	 * same as the one the buffer is currently charged to.
> +	 */
> +	current_gpucg = gpucg_get(current);
> +	mutex_lock(&dmabuf->lock);
> +	if (current_gpucg != dmabuf->gpucg) {
> +		ret = -EPERM;
> +		goto err;
> +	}

Add a shortcut for gpucg == current_gpucg?

> +
> +	ret = gpucg_try_charge(gpucg, dmabuf->gpucg_dev, dmabuf->size);
> +	if (ret)
> +		goto err;
> +
> +	dmabuf->gpucg = gpucg;
> +
> +	/* uncharge the buffer from the cgroup it's currently charged to. */
> +	gpucg_uncharge(current_gpucg, dmabuf->gpucg_dev, dmabuf->size);

I think gpucg_* API would need to cater for such transfers too since
possibly transitional breach of a limit during the transfer may
unnecessarily fail the operation.

My 0.02€,
Michal
