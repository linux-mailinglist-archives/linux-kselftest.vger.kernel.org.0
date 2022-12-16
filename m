Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0705E64EE1C
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Dec 2022 16:47:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231426AbiLPPrx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 16 Dec 2022 10:47:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231419AbiLPPrw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 16 Dec 2022 10:47:52 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B16EC1027
        for <linux-kselftest@vger.kernel.org>; Fri, 16 Dec 2022 07:47:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671205624;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LxMkecyGYG9dLIpgBNsZUPusnmfyW4vuV2TgoZY8b1I=;
        b=A1fXn9zjQ901DtvygIiyjjRKQzc4DqxvufQO1InD+mby2JrcmFAsrEotH/wQk55KkGvQMn
        CXwuC1DZ0jGVg2Q5Dbc19xL94w6zpHJmU5CMQ2JG2mpxWIC/WOaH1QwDVnRYqitkZQAYmy
        eLrxmaQe15/kqGhAvJIz2gQAN5NMGzI=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-562-34bpwe5PNw62aKSDh-ZP2A-1; Fri, 16 Dec 2022 10:47:02 -0500
X-MC-Unique: 34bpwe5PNw62aKSDh-ZP2A-1
Received: by mail-qv1-f70.google.com with SMTP id w1-20020a056214012100b004c6ecf32001so1650416qvs.8
        for <linux-kselftest@vger.kernel.org>; Fri, 16 Dec 2022 07:47:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LxMkecyGYG9dLIpgBNsZUPusnmfyW4vuV2TgoZY8b1I=;
        b=UUytwdeuguVojMo5wuukwOlHAbz6+ytLpwLEQo5rpbACFNzUPIdxPAPGAbJSlOfHMk
         weaJRcNEVY3gFQ/KJShrM3El8dKNv+T3QzaDr1JB60pXMKnt6moaHJXCxg8yJqb7Pgls
         /ZEYs9fiQFLRoVVpU9Ry9nxxpHzHVueX8DlOog3yM3kO2lwAZxMQz2nEcPUYw9F2JDTe
         R3MMXcN9UA3N+3CgMLjrmUVV1yw/VbNyWyZ4w4wQHoz0F5e2r6MxPkjKiriIVhG3wG9E
         XAaMRzfBvagRFbNaK6i30r6kIVfMIy6JatOdzi9hFT7migQfMxwn5F4l3T0opUN3+xAa
         piHg==
X-Gm-Message-State: ANoB5pmU79n6poirM5aQHJuNJRIkuatmonKeUSNzk37zJady4gSh0Rci
        CWrAfUDH5LfckQKF1W6LipHmcIwLYEox1gQyfSzQrslhoUbfpfLTYmRiWmiGnSbUN50uEa5RHSe
        f2p83Ame6caPRT3+T9QK8TbuIz+/j
X-Received: by 2002:a05:622a:40c5:b0:3a5:306f:b124 with SMTP id ch5-20020a05622a40c500b003a5306fb124mr45697428qtb.10.1671205622303;
        Fri, 16 Dec 2022 07:47:02 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5eK8zxu4MtCAROwOHMPjA4TRfLrCS+AsiC6Si+i4v1cyQH5maRZ4RJ3yJvRLlW+Au04FcIJQ==
X-Received: by 2002:a05:622a:40c5:b0:3a5:306f:b124 with SMTP id ch5-20020a05622a40c500b003a5306fb124mr45697411qtb.10.1671205622117;
        Fri, 16 Dec 2022 07:47:02 -0800 (PST)
Received: from x1n (bras-base-aurron9127w-grc-45-70-31-26-132.dsl.bell.ca. [70.31.26.132])
        by smtp.gmail.com with ESMTPSA id a5-20020ac844a5000000b003a68af60591sm1466597qto.70.2022.12.16.07.47.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Dec 2022 07:47:01 -0800 (PST)
Date:   Fri, 16 Dec 2022 10:46:59 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Jeff Xu <jeffxu@google.com>
Cc:     Kees Cook <keescook@chromium.org>, jeffxu@chromium.org,
        skhan@linuxfoundation.org, akpm@linux-foundation.org,
        dmitry.torokhov@gmail.com, dverkamp@chromium.org, hughd@google.com,
        jorgelo@chromium.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        jannh@google.com, linux-hardening@vger.kernel.org,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v6 3/6] mm/memfd: add MFD_NOEXEC_SEAL and MFD_EXEC
Message-ID: <Y5yS8wCnuYGLHMj4@x1n>
References: <20221207154939.2532830-1-jeffxu@google.com>
 <20221207154939.2532830-4-jeffxu@google.com>
 <202212080821.5AE7EE99@keescook>
 <CALmYWFuKR538vHxqYH1p6mb9iShOohf5bpHZXSfUN4KQHYiwaA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CALmYWFuKR538vHxqYH1p6mb9iShOohf5bpHZXSfUN4KQHYiwaA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi, Jeff,

On Thu, Dec 08, 2022 at 02:55:45PM -0800, Jeff Xu wrote:
> > > +     if (!(flags & (MFD_EXEC | MFD_NOEXEC_SEAL))) {

[...]

> > > +             pr_warn_ratelimited(
> > > +                     "memfd_create() without MFD_EXEC nor MFD_NOEXEC_SEAL, pid=%d '%s'\n",
> > > +                     task_pid_nr(current), get_task_comm(comm, current));

This will be frequently dumped right now with mm-unstable.  Is that what it
wanted to achieve?

[   10.822575] memfd_create() without MFD_EXEC nor MFD_NOEXEC_SEAL, pid=491 'systemd'
[   10.824743] memfd_create() without MFD_EXEC nor MFD_NOEXEC_SEAL, pid=495 '(sd-executor)'
...

If there's already a sane default value (and also knobs for the user to
change the default) not sure whether it's saner to just keep it silent as
before?

-- 
Peter Xu

