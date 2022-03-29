Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EE4D4EB25E
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Mar 2022 18:59:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238389AbiC2RB3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 29 Mar 2022 13:01:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231454AbiC2RB3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 29 Mar 2022 13:01:29 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 648062AE3D;
        Tue, 29 Mar 2022 09:59:46 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id n18so18171158plg.5;
        Tue, 29 Mar 2022 09:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=67yHXoFmcX0ZazheDKYQVpHoB656ZGpg7LX2oma8XGY=;
        b=l1oIEc6kFQcKGLgIxGfSwqNZBvaZGfVzYIpmLE5Rh6nGhFdWOqxOLcEiD5UGOeShLo
         a3iUDj7MTnw1ZVoumywlaRlOqrOguzQaaUg8sl/W8xYELNabR0FkepIhxq53qWfWRHqT
         ocM2HSkoX6c1ycU+gtCJdRWBI5LQV8B2NcIE2eGHLknFjpgkEJzAV6QEilvZPsFmftqT
         gEf10uCzq4cyr50t7r+MHukvbyXMswobdfj+UiEjLCGz8uU2kyzlTjXvCPVu1iLyYPLF
         hpLrTonQaPEFCwIiW4cB09XczJYAql+ov2htCytwylqN1iQbCWxBZsm43uimxjTneIJO
         mdzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=67yHXoFmcX0ZazheDKYQVpHoB656ZGpg7LX2oma8XGY=;
        b=qW7fwf0jpUOKgTZbodWyDeOBBNklE7Vn+zOU9PL6m9vBUnvd2aRfD93cZ+4h3DhHeL
         EiVX8R9xKtcUXU7TLkPRUAlSEfTHdDwbHiUNxv2WQNVtNWCTVNqEvwYRg7gLLkfQMEjW
         EDKc3SAZKrtImE/ry4QqiKnBUjnZ7pFkOgL5Sl+h80Oneasa+KTszwONj9dLFu7mYGsp
         KGNBis3LDMwABTxOIqsZiqcx50wgEjfTF0Kw05L6TuDDEqMv1MTqLaoMxusaaVL2UvQp
         2SRHxCe1B50pYE/fropfW3V67UdtBxYnjD35aVYUV+31oeBZUw2ulPx+SvdQoGUjAtCK
         ypZg==
X-Gm-Message-State: AOAM530UEc7FKTRIHu6CaquZBFCbNWQwLX9eoaCUSunlDOKYR7lEEpN1
        r0FIL4h6SjO/AR8SShjSnaY=
X-Google-Smtp-Source: ABdhPJwzy42BlJVB0bBm4Ge7A7WVOaCsDi/5yGBrI0VAwZfeGFTf8i7B6I5tAtAaOfrhDGFcEZ17Ug==
X-Received: by 2002:a17:902:f68f:b0:154:759c:c78 with SMTP id l15-20020a170902f68f00b00154759c0c78mr30853829plg.49.1648573185719;
        Tue, 29 Mar 2022 09:59:45 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:7749])
        by smtp.gmail.com with ESMTPSA id qe15-20020a17090b4f8f00b001c6f4991cd4sm3571258pjb.45.2022.03.29.09.59.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 09:59:45 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 29 Mar 2022 06:59:43 -1000
From:   Tejun Heo <tj@kernel.org>
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
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shuah Khan <shuah@kernel.org>, kaleshsingh@google.com,
        Kenny.Ho@amd.com, mkoutny@suse.com, skhan@linuxfoundation.org,
        dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linaro-mm-sig@lists.linaro.org, cgroups@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [RFC v4 2/8] cgroup: gpu: Add a cgroup controller for allocator
 attribution of GPU memory
Message-ID: <YkM6/57mVxoNfSvm@slm.duckdns.org>
References: <20220328035951.1817417-1-tjmercier@google.com>
 <20220328035951.1817417-3-tjmercier@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220328035951.1817417-3-tjmercier@google.com>
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

Hello,

On Mon, Mar 28, 2022 at 03:59:41AM +0000, T.J. Mercier wrote:
> The API/UAPI can be extended to set per-device/total allocation limits
> in the future.

This total thing kinda bothers me. Can you please provide some concrete
examples of how this and per-device limits would be used?

Thanks.

-- 
tejun
