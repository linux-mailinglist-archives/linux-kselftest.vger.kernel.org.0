Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD9C84EFA0E
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Apr 2022 20:42:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351352AbiDASnp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 1 Apr 2022 14:43:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351345AbiDASno (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 1 Apr 2022 14:43:44 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE80821593D
        for <linux-kselftest@vger.kernel.org>; Fri,  1 Apr 2022 11:41:50 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id i16so7553835ejk.12
        for <linux-kselftest@vger.kernel.org>; Fri, 01 Apr 2022 11:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=DLtOWenxXCw5vQfabcGIJp+Je2gVQjc6VzKW0XdhyiQ=;
        b=h+rLLWbMQ/iHnS5/pj19fhLvsaEM9Wtdy1qxj2U1tvLPMxqJCjQosFe2F24w4FuEik
         zSrjnDN8RVUqsGTehE0RLFU9iAnAgsZLy6+HaVFpgiQgyaH0bi2nNoUnW/PN++7erDWp
         RX2laVeByhssITiwvlf5JqxR9o7iIybqO73rq6iDBg0II0FI27oeey/L41eoch8FqdX9
         HSLjysJJ9QsP1Keic9p/q3hcmxjndegS2Td9/sQ/qsgWCFS7CVf9el3ursRzkfzAihRs
         Haf70E3SoFpNKPytMrE2H1AsOY13tYTorkjDKu54Gzzinf56UPzglOwHHVZBMjHJCiR4
         t3yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=DLtOWenxXCw5vQfabcGIJp+Je2gVQjc6VzKW0XdhyiQ=;
        b=WgMgSXp/wVY5u3JR5fT+6Nzq2X24ql3jrYmW0RMdmDSL0arBeysLQr0Nibmcj5pJW3
         7JmaAjWz+KWhQomOJwiOjGf5lgy5SH7GMGZXA0RDlaAw8h1DoA6b+C7m4yE+Stz7irFa
         EWV+cy2f7bHUcnUuPV4lRSt1z7cySUqDdfgwkzI+ebnTUfMlC07eacsZdTIY9Z//WBL1
         3WCLae6ehYft5bY7XNSCPthMkThgCRvHzPGHHKkkrWeQ4WSR6vJovourBJ2U0gWggY7w
         eZGPW+gjjYzcFej3JeNMAr2o744P/uaCZwMiqQdSe9UBMEahV0FLkG8PgBU9toZ8jRut
         fMcQ==
X-Gm-Message-State: AOAM531NWvoPWaDGDZdrC4SLfYhob5qaPsdqFUYzsTKZaCapo4p3E9Il
        yHn07wjXM//6HP7eBOZaFu5A6vIcDg8ydU0KYqwLAg==
X-Google-Smtp-Source: ABdhPJwrYPj1kC3SIVIUHr/U2Akla60gayN+BoFrbJkPw1P4im/SamWlkUSDfJabqc8psCgCaTuKJc519X3Csg6+YUY=
X-Received: by 2002:a17:907:3eaa:b0:6df:b058:96a with SMTP id
 hs42-20020a1709073eaa00b006dfb058096amr1028056ejc.368.1648838508127; Fri, 01
 Apr 2022 11:41:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220328035951.1817417-1-tjmercier@google.com>
 <20220328035951.1817417-6-tjmercier@google.com> <20220329152142.GA15794@blackbody.suse.cz>
In-Reply-To: <20220329152142.GA15794@blackbody.suse.cz>
From:   "T.J. Mercier" <tjmercier@google.com>
Date:   Fri, 1 Apr 2022 11:41:36 -0700
Message-ID: <CABdmKX2874NdYCBzpKLnqWhZQDkC2wKz4ZL_aFNqrec6iAutpQ@mail.gmail.com>
Subject: Re: [RFC v4 5/8] dmabuf: Add gpu cgroup charge transfer function
To:     =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <brauner@kernel.org>,
        Hridya Valsaraju <hridya@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Liam Mark <lmark@codeaurora.org>,
        Laura Abbott <labbott@redhat.com>,
        Brian Starkey <Brian.Starkey@arm.com>,
        John Stultz <john.stultz@linaro.org>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shuah Khan <shuah@kernel.org>,
        Kalesh Singh <kaleshsingh@google.com>, Kenny.Ho@amd.com,
        Shuah Khan <skhan@linuxfoundation.org>,
        dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linaro-mm-sig@lists.linaro.org, cgroups@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Mar 29, 2022 at 8:21 AM Michal Koutn=C3=BD <mkoutny@suse.com> wrote=
:
>
> Hi.
>
> On Mon, Mar 28, 2022 at 03:59:44AM +0000, "T.J. Mercier" <tjmercier@googl=
e.com> wrote:
> > From: Hridya Valsaraju <hridya@google.com>
> >
> > The dma_buf_charge_transfer function provides a way for processes to
>
> (s/dma_bug_charge_transfer/dma_bug_transfer_charge/)
>
Doh! Thanks.

> > transfer charge of a buffer to a different process. This is essential
> > for the cases where a central allocator process does allocations for
> > various subsystems, hands over the fd to the client who requested the
> > memory and drops all references to the allocated memory.
>
> I understood from [1] some buffers are backed by regular RAM. How are
> these charges going to be transferred (if so)?
>
This link doesn't work for me, but I think you're referring to the
discussion about your "RAM_backed_buffers" comment from March 23rd. I
wanted to do a simple test to confirm my own understanding here, but
that got delayed due to some problems on my end. Anyway the test I did
goes like this: enable memcg and gpu cgoups tracking and run a process
that allocates 100MiB of dmabufs. Observe memcg and gpu accounting
values before and after the allocation.

Before
# cat memory.current gpu.memory.current
14909440
system 0

<Test program does the allocation of 100MiB of dmabufs>

After
# cat memory.current gpu.memory.current
48025600
system 104857600

So the memcg value increases by about 30 MiB while the gpu values
increases by 100 MiB. This is with kmem enabled, and the /proc/maps
file for this process indicates that the majority of that 30 MiB is
kernel memory. I think this result shows that neither the kernel nor
process memory overlap with the gpu cgroup tracking of these
allocations. So despite the fact that these buffers are in main
memory, they are allocated in a way that does not result in memcg
attribution. (It looks to me like __GFP_ACCOUNT is not set for these.)

>
> Thanks,
> Michal
>
> [1]
> https://lore.kernel.org/r/CABdmKX2NSAKMC6rReMYfo2SSVNxEXcS466hk3qF6YFt-j-=
+_NQ@mail.gmail.com
