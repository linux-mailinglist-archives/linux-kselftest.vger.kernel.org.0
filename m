Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03E974E3515
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Mar 2022 01:07:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233586AbiCUX6W (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 21 Mar 2022 19:58:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233617AbiCUX5x (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 21 Mar 2022 19:57:53 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0A2028AC79
        for <linux-kselftest@vger.kernel.org>; Mon, 21 Mar 2022 16:55:03 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id r22so12910459ejs.11
        for <linux-kselftest@vger.kernel.org>; Mon, 21 Mar 2022 16:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=qiaO27WzdyEkhPCgtVcKJYNpZr9WKp2+zwnsf/1VvSc=;
        b=Ri8yuR7/Vfc3fPL9gQLx7nlC2w5WarFCPritcrnsHpSsxuLwI5G3Voo8JeXcgyszLb
         +2uoYc1aMEeZckMfuvJ2tS1RQ4sV4x2bEw3/t6bZI8mymUrBIyCvE8fdVOZNpVekttmd
         gL3/aF9rUmS8p0UDTQfskhyx+I2egHowIc+sQ/N03tFWDWkkas9yz9J6z6/pRbfJotOJ
         Hya7yMo0Sw59opqFkSYTZhc7F9NiPgJ8uwx1p8C0nJ00wLf8jKvLHqjCFphRAZgfpYi+
         VVSQCs5iHmIrTMa+g/VlfDJHcUV27McnejGmfZoaaKiH2IvdAJP5kg+Lda21FYCK3UME
         MrGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qiaO27WzdyEkhPCgtVcKJYNpZr9WKp2+zwnsf/1VvSc=;
        b=csU/zAHkr5pZSfGd0nRzDgRWHfx9QK9G0/g0UVHDbgGPbc72LdVwymROuilz3zOhw5
         SThES9+YtFgIt/1KnvueI69xMZgz0XpBSpZzLrem7x3CquvaOQRHqLG8aVrv01+5QdLn
         wptlJIaq50XgXzX4iBCq6x3TZFG/U9tyqsMTUirwXWI8WEvWsB16/gI83doMPFhwDMDB
         NDSn14LyVAXce5tDL8d8soaFMcquQCjUvaxynaPe72hMPCcruIT4QoELMNxAEnk4JgaJ
         m8xoOhYJM+glVP3whBNBUsUuWpEFTThlspSqemKHIqs77s4s7jufKzMjgy+H06ruq+4R
         6Eeg==
X-Gm-Message-State: AOAM530mV7p5mSsBvxvZt8x8v5pU5k+FG7Z/lyoRDpvwfzOsKf6EyN5P
        7sfSaW7s+e8GkN9mGJLcvSG7p2j8XIb7jWRY4nwCWA==
X-Google-Smtp-Source: ABdhPJwljarBa64DW7LUA/1wDxvFxLHgPtNYizJ4BJSCb3j/73bGTaegZtVwv4hXKy5Ey64Opp4zZ4UPfFj0Fl96E/A=
X-Received: by 2002:a17:907:3eaa:b0:6df:b058:96a with SMTP id
 hs42-20020a1709073eaa00b006dfb058096amr18101556ejc.368.1647906877844; Mon, 21
 Mar 2022 16:54:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220309165222.2843651-1-tjmercier@google.com>
 <20220309165222.2843651-6-tjmercier@google.com> <20220321174530.GB9640@blackbody.suse.cz>
In-Reply-To: <20220321174530.GB9640@blackbody.suse.cz>
From:   "T.J. Mercier" <tjmercier@google.com>
Date:   Mon, 21 Mar 2022 16:54:26 -0700
Message-ID: <CABdmKX3+mTjxWzgrv44SKWT7mdGnQKMrv6c26d=iWdNPG7f1VQ@mail.gmail.com>
Subject: Re: [RFC v3 5/8] dmabuf: Add gpu cgroup charge transfer function
To:     =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
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

On Mon, Mar 21, 2022 at 10:45 AM Michal Koutn=C3=BD <mkoutny@suse.com> wrot=
e:
>
> Hello.
>
> On Wed, Mar 09, 2022 at 04:52:15PM +0000, "T.J. Mercier" <tjmercier@googl=
e.com> wrote:
> > +int dma_buf_charge_transfer(struct dma_buf *dmabuf, struct gpucg *gpuc=
g)
> > +{
> > +#ifdef CONFIG_CGROUP_GPU
> > +     struct gpucg *current_gpucg;
> > +     int ret =3D 0;
> > +
> > +     /*
> > +      * Verify that the cgroup of the process requesting the transfer =
is the
> > +      * same as the one the buffer is currently charged to.
> > +      */
> > +     current_gpucg =3D gpucg_get(current);
> > +     mutex_lock(&dmabuf->lock);
> > +     if (current_gpucg !=3D dmabuf->gpucg) {
> > +             ret =3D -EPERM;
> > +             goto err;
> > +     }
>
> Add a shortcut for gpucg =3D=3D current_gpucg?

Good idea, thank you!

>
> > +
> > +     ret =3D gpucg_try_charge(gpucg, dmabuf->gpucg_dev, dmabuf->size);
> > +     if (ret)
> > +             goto err;
> > +
> > +     dmabuf->gpucg =3D gpucg;
> > +
> > +     /* uncharge the buffer from the cgroup it's currently charged to.=
 */
> > +     gpucg_uncharge(current_gpucg, dmabuf->gpucg_dev, dmabuf->size);
>
> I think gpucg_* API would need to cater for such transfers too since
> possibly transitional breach of a limit during the transfer may
> unnecessarily fail the operation.

Since the charge is duplicated in two cgroups for a short period
before it is uncharged from the source cgroup I guess the situation
you're thinking about is a global (or common ancestor) limit? I can
see how that would be a problem for transfers done this way and an
alternative would be to swap the order of the charge operations: first
uncharge, then try_charge. To be certain the uncharge is reversible if
the try_charge fails, I think I'd need either a mutex used at all
gpucg_*charge call sites or access to the gpucg_mutex, which implies
adding transfer support to gpu.c as part of the gpucg_* API itself and
calling it here. Am I following correctly here?

This series doesn't actually add limit support just accounting, but
I'd like to get it right here.

>
> My 0.02=E2=82=AC,
> Michal

Thanks!
