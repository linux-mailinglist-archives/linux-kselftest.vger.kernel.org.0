Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C0C252E67E
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 May 2022 09:47:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346601AbiETHra (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 20 May 2022 03:47:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346549AbiETHr3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 20 May 2022 03:47:29 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9645371D89;
        Fri, 20 May 2022 00:47:27 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id nk9-20020a17090b194900b001df2fcdc165so10842579pjb.0;
        Fri, 20 May 2022 00:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=56ihVfI55g+5kWoCWi0j9KBKpP7u+QiASGOdishgsYU=;
        b=fI4qwgrFQO4hVvdc3SUyQ8Cdgd+sywkDfLxoX5FB2E66Rov05yQTZSVOzP7gpoXEQF
         0elvCO46fIFZh0PGVYSb0zBP9E8rthiYU1kAunjlGADxZHVDIzKAD9lkoRKg2HXJ1W5y
         hXlwhv/t9DEN5z9vOFJjkOJHZlgbiKv1kt3tICg8ZW4m3WO5jv6iWCSmP7K1aB7qLYm4
         VMIP2whsDbn6dmzkcOergoPPDPGfcjXLPaXh/y5sNGVVKXZAO8zLhLtKDQfFcopimuD1
         iFzKXGu0GYsL7i2AAdYko6ymJb3ROx8/6svDCApNBiO36LmQDMIJe2JZDgJ2TmbOdK9q
         Eg8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=56ihVfI55g+5kWoCWi0j9KBKpP7u+QiASGOdishgsYU=;
        b=HM34ncEY4fHxu4Xx07p6KWs1bSKp1D4Cq/L9VCHzndNSN63VYDO33Of07xgwiOuFDw
         qdTRgF6q3QNhJ9hMFBPD+AfVZcUHxoQepZTb2ZBJbFXKHdGwOftBNlT8TxVkD2cal/04
         YndHel80ekeJfzMIfv0fnDEjqqYWJAZ5Ho90nhIf5HTkho40yNUn0KtOMtEoP0IUPEd4
         m1KS0ryCWldQDYPTQSg4ZF3qklZTsfphRuMQyojd8vY7IdQ3az6CXS7f/XX2ILDFvQd9
         cHBkF1gmdM/NKHj1Q4tINQOOh0LsvDPs+9usQNfnrwcG6SNk4opFz06RKE8Pr2Sqrv9I
         GD1Q==
X-Gm-Message-State: AOAM5331K2ZflfCEdV5/3yMlh+VwT393BPqvmcpgFwXx1lpECKu6WPBC
        INfzm8Azfl1wtnjIjX7VQSI=
X-Google-Smtp-Source: ABdhPJzWP/OizPFgR9KmuaPsRGfMHikuqC99X6s0BZZQYR12Xiw5I0XneB0xM48YDFHIVgUBpKEfiw==
X-Received: by 2002:a17:90a:760d:b0:1df:6423:d0b9 with SMTP id s13-20020a17090a760d00b001df6423d0b9mr10201911pjk.33.1653032846949;
        Fri, 20 May 2022 00:47:26 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::4:1761])
        by smtp.gmail.com with ESMTPSA id v12-20020a17090331cc00b0015e8d4eb1ebsm4949822ple.53.2022.05.20.00.47.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 00:47:26 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 19 May 2022 21:47:25 -1000
From:   Tejun Heo <tj@kernel.org>
To:     "T.J. Mercier" <tjmercier@google.com>
Cc:     Nicolas Dufresne <nicolas@ndufresne.ca>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
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
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Liam Mark <lmark@codeaurora.org>,
        Laura Abbott <labbott@redhat.com>,
        Brian Starkey <Brian.Starkey@arm.com>,
        John Stultz <john.stultz@linaro.org>,
        Shuah Khan <shuah@kernel.org>, Daniel Vetter <daniel@ffwll.ch>,
        John Stultz <jstultz@google.com>,
        Carlos Llamas <cmllamas@google.com>,
        Kalesh Singh <kaleshsingh@google.com>, Kenny.Ho@amd.com,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        kernel-team@android.com, cgroups@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v7 0/6] Proposal for a GPU cgroup controller
Message-ID: <YodHjYlMx1XGtM2+@slm.duckdns.org>
References: <20220510235653.933868-1-tjmercier@google.com>
 <3365cd1d750e84fedc8e75d646a77ffd85619d35.camel@ndufresne.ca>
 <CABdmKX3ZV6-u-oLvW_wWavAMBfrsZ=C_rCgK_Uz4VjxcRvRFew@mail.gmail.com>
 <81026ef07c1ce20f8673b75b17bab79a2b39c548.camel@ndufresne.ca>
 <CABdmKX2LxZ6zZR=fhXfnuWCB2BR+gzDd1-t1DD2A2XP24wvuGQ@mail.gmail.com>
 <Yn6DpUsoSz1/15Kc@slm.duckdns.org>
 <CABdmKX1xvm87WMEDkMc9Aye46E4zv1-scenwgaRxHesrOCsaYg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABdmKX1xvm87WMEDkMc9Aye46E4zv1-scenwgaRxHesrOCsaYg@mail.gmail.com>
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

On Tue, May 17, 2022 at 04:30:29PM -0700, T.J. Mercier wrote:
> Thanks for your suggestion. This almost works. "dmabuf" as a key could
> work, but I'd actually like to account for each heap. Since heaps can
> be dynamically added, I can't accommodate every potential heap name by
> hardcoding registrations in the misc controller.

On its own, that's a pretty weak reason to be adding a separate gpu
controller especially given that it doesn't really seem to be one with
proper abstractions for gpu resources. We don't want to keep adding random
keys to misc controller but can definitely add limited flexibility. What
kind of keys do you need?

Thanks.

-- 
tejun
