Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B7B54EB242
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Mar 2022 18:50:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239938AbiC2QwV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 29 Mar 2022 12:52:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239932AbiC2QwU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 29 Mar 2022 12:52:20 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44CC1D6E;
        Tue, 29 Mar 2022 09:50:37 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id jx9so18055992pjb.5;
        Tue, 29 Mar 2022 09:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=oo4DwVPmc4Xc8mHsSOZJPPM1+kxb1H+BME8RduWXyEc=;
        b=fon/v7xEg/MG9yKo0ZhFyVDd8Pi8tu6+Ushj4CQ5i5ZK7JvGdhYA+9e/SNRbZmP9Sv
         pCKmTk3lb6hjAAWbXCrUihV4aR6Osupca5LKufEEjFzjS5dKaHLe0jNplTFUZ36iHnVk
         sTubKidTh4TFkPcklY8dTxB8YzPtwQKC9XMO0UBR3PrCLB/DdkbgqeffVh5WeCzY1Kz3
         JiapQ7p+VMjbsVZb1XgQylMCEerXzU91lVY69si8AUutSOzJsBTatSYV6g7QbeGrvQUa
         oPrdqMZejb1WJMC3kUMFa0DQeBm3jfo1vJfKQPQsi7YcylRvBDYfhLYmZlW2miVTOKKE
         o0Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=oo4DwVPmc4Xc8mHsSOZJPPM1+kxb1H+BME8RduWXyEc=;
        b=of4CBxGLiYVg4mpUN7JvzLc5RxuPon3AaxLPNTbxrY92cW9iV0KuU9QaTNpNvnp84s
         Eed/MFTnP/bbvTNnEOAr5AO5JjMGS7iZ/HXolNVhRUbRIsi85iHnbvPuEXe7LycMwc1h
         VPdnm82OVAbBx1i7PC6jKMwOWzN6qUIJYGwJXQN8tkx354ruhOEVujFzV/s8LNQcVu19
         3VE2hGxd6eA5Ya60CguEq80HmBPArjLeEjMRcdmkx/CQa5uTHyPGFtAeRk595ctOUNLd
         8zfZI55J1gYiFWPKfrcBXpP767DIkRdQyG0w/8eTUpTenpn4TTf38jV1aNixNCNV8uLC
         HknA==
X-Gm-Message-State: AOAM5328TIf4HR7HrGJfg69rLyfSYhBGozBVQ+RDWO/2EHu/cGK+BvHe
        BBmskWlAy/FZcEUIp9mrV8Q=
X-Google-Smtp-Source: ABdhPJwK34gym8LY0bVce8JYqwr3XDALjGLRfStGWGhzeJS7utaFiUFkwfefNjUZnxfhL3wq68o19Q==
X-Received: by 2002:a17:903:246:b0:153:87f0:a93e with SMTP id j6-20020a170903024600b0015387f0a93emr31382772plh.171.1648572636435;
        Tue, 29 Mar 2022 09:50:36 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:7749])
        by smtp.gmail.com with ESMTPSA id b25-20020a637159000000b00381fda49d15sm17968864pgn.39.2022.03.29.09.50.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 09:50:35 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 29 Mar 2022 06:50:34 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     "T.J. Mercier" <tjmercier@google.com>,
        David Airlie <airlied@linux.ie>,
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
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shuah Khan <shuah@kernel.org>,
        Kalesh Singh <kaleshsingh@google.com>, Kenny.Ho@amd.com,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linaro-mm-sig@lists.linaro.org, cgroups@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [RFC v4 4/8] dmabuf: heaps: export system_heap buffers with GPU
 cgroup charging
Message-ID: <YkM42vdq3mdIP9Zl@slm.duckdns.org>
References: <20220328035951.1817417-1-tjmercier@google.com>
 <20220328035951.1817417-5-tjmercier@google.com>
 <YkHH/0Use7F30UUE@phenom.ffwll.local>
 <CABdmKX01p6g_iHsB6dd4Wwh=8iLdYiUqdY6_yyA5ax2YNHt6tQ@mail.gmail.com>
 <YkLGbL5Z3HVCyVkK@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YkLGbL5Z3HVCyVkK@phenom.ffwll.local>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Mar 29, 2022 at 10:42:20AM +0200, Daniel Vetter wrote:
> Hm I just realized ... are the names in the groups abi? If yes then I
> think we need to fix this before we merge anything.

Yes.

Thanks.

-- 
tejun
