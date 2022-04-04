Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCBA24F1C7D
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Apr 2022 23:28:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379523AbiDDV1b (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 4 Apr 2022 17:27:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379594AbiDDRn6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 4 Apr 2022 13:43:58 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A183131DE7;
        Mon,  4 Apr 2022 10:41:59 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id c23so8798407plo.0;
        Mon, 04 Apr 2022 10:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=cN+cryxrTnBG0VJoafZ3s+TyTmI2BuJ8Y3SjnOF9NwE=;
        b=q3aN/qFotQnWnl+DjEG8MO6ne2oneqFucG+YMqB8k3tZY4ziHRZjt9uG5kk2ucPSyJ
         B3t4mekt0LtHaY6B2DxdS9ITSE1r5EeeAd/rhW1xKoa1wo3vU4K2S8P61apUpP5h4bNm
         Ie0A7GhmrIV13SapWYC+pBHHxcMfzG1xl5pi5A5mA6QQacPLxq32GEg+r615aQjVj0cM
         ScAvsigcU1WuLyjMICOCbYf7dvvMMcfNL5CZ9k+EEuJADXpZ4eKJcbWnBjSBr+bT6AiL
         7lCs1XU5CcdliX4j+yjAr9C7RGzTsxJzZ3oMolqcxQoEMANHXQ/CG9u/lINvdUreaUZ7
         6UmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=cN+cryxrTnBG0VJoafZ3s+TyTmI2BuJ8Y3SjnOF9NwE=;
        b=QdVh3ys8cFAljnWrNfGGglggY5h1xoDIxaOprUekNAFGSNWkd6hSUvVM2lSzQcTXzo
         ahncuo08SmmAfa2LteG7sS5i+51QOknbxQXhCAryc9aGkQ9WPNR1l4zXIeZpxc/0nafY
         cknp3egJa1ftVFGL088yX84jzZhfoZY4BzeKFHV4HsR0ujkejp8QEKHPQJzPA8AFzm6c
         69Gkt36moJekCV3JI9dwtqHkNZBAUyJwe99fE9YZlFZMeb0SozM/X1qr6EsV/9UOVBe6
         cTOKzRl0VVIjrfyIkjqtVNbuhWRRUaAA8jyH4xw+vB10ApqreQGm/n3OdPOHGAbzKXL0
         LeSQ==
X-Gm-Message-State: AOAM532bwbgJBJ9f3YDXP6a6SnOuMp9cnaUq1TZQfZljuozQOEtMXLhT
        8LfFnn8KvNEN0iVtD3fStpU=
X-Google-Smtp-Source: ABdhPJzKUk4qJcY2Yl04uIk073pVWVy0TAgu29TjkZGtqRzd2GqD3mnxPAiabi9k3biaI+nz18T1DA==
X-Received: by 2002:a17:903:110c:b0:14d:8859:5c8 with SMTP id n12-20020a170903110c00b0014d885905c8mr1112876plh.156.1649094118990;
        Mon, 04 Apr 2022 10:41:58 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:baee])
        by smtp.gmail.com with ESMTPSA id v17-20020a63b951000000b0038644f62aeesm10984699pgo.68.2022.04.04.10.41.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 10:41:58 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 4 Apr 2022 07:41:56 -1000
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
        Shuah Khan <shuah@kernel.org>,
        Kalesh Singh <kaleshsingh@google.com>, Kenny.Ho@amd.com,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linaro-mm-sig@lists.linaro.org, cgroups@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [RFC v4 2/8] cgroup: gpu: Add a cgroup controller for allocator
 attribution of GPU memory
Message-ID: <Ykst5K/cI+DUVc94@slm.duckdns.org>
References: <20220328035951.1817417-1-tjmercier@google.com>
 <20220328035951.1817417-3-tjmercier@google.com>
 <YkM6/57mVxoNfSvm@slm.duckdns.org>
 <CABdmKX2Gxg35k7QiL2Vn4zWhmQ4UnM-Z8cnOXR0fwBWyJnZ+Ng@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABdmKX2Gxg35k7QiL2Vn4zWhmQ4UnM-Z8cnOXR0fwBWyJnZ+Ng@mail.gmail.com>
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

On Wed, Mar 30, 2022 at 01:56:09PM -0700, T.J. Mercier wrote:
> The use case we have for accounting the total (separate from the
> individual devices) is to include the value as part of bugreports, for
> understanding the system-wide amount of dmabuf allocations. I'm not
> aware of an existing need to limit the total. Admittedly this is just
> the sum over the devices, but we currently maintain out of tree code
> to do this sort of thing today. [1]

So, drop this part?

Thanks.

-- 
tejun
