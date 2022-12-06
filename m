Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2969F64492B
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Dec 2022 17:27:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234599AbiLFQ1K (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 6 Dec 2022 11:27:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234608AbiLFQ1I (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 6 Dec 2022 11:27:08 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 776322A721
        for <linux-kselftest@vger.kernel.org>; Tue,  6 Dec 2022 08:27:07 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id u15-20020a17090a3fcf00b002191825cf02so15287670pjm.2
        for <linux-kselftest@vger.kernel.org>; Tue, 06 Dec 2022 08:27:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JgcwRFCL6hgvtdlBwWhPhxTax1zzqSSsoj4r1eWsJf8=;
        b=kX76ACCqquYYKdhd1CIgHnXMEB2+Uj5oj5pOCkG3xpDvEjeGvYakYAHNTo4wWv1Van
         orDE+qDfaC0K8lfHIRXqpbTTSJsqAwKTpg+INljBF1UtTncqnct1mbu2+iludo6zKmuu
         /8T7g0T9RN+U5tahdeL4X8SR6sJ15P44WttkcoX+reAZm1lQ0+KFBuys2PB9G6kKdPyz
         uScMqulZdXKQVT1rGNWJk6ZImu+IhtQto2OHZWinW3bNNeVOaYX3a47I3EivU73HYpCg
         66o2MTbUlicj+QFikjOsTay/QFP8D1ExET45mn7CByRgZkObBnQy5L04v6XncpO5XC3K
         l5Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JgcwRFCL6hgvtdlBwWhPhxTax1zzqSSsoj4r1eWsJf8=;
        b=lC21GtZtzibgtPjSi0xkFWYBVwGzc2iPTAObLVcj8wnOCtp7btIa+jRlNlWqsbeJud
         mq+uCV3DALZ7uoQd7kI9JXWtoOGbhEt7qCarq5goBS/CTyl171eHnQQXr5kcDAeZeDra
         qyTLcNQwUgQ55qIyEn5jODJDDqd6dJGPWMx7hE8NBUVjrERtrj56dNL7CpHarZs3Oa13
         tUknuw8x7bGWE79GCuHS0AKxlqauES2jV5K5fAY5Y0kpvu86cLuCbx7OIdE6PEiiVmn3
         bwikW8DflTKdAOo1We0V4e5PZAs50OR3HrwIgk0/M4wzjq9iuC1Nb/9UD5gNJg7gFkp5
         DTUQ==
X-Gm-Message-State: ANoB5pkDxdSLcD8x66IVpWg1qKwYcrtm8tF2PfIAuCXlnzFg98a47EZk
        C3Qdtvt1Q2qeIPlLImI+PKmLPXJs1lJmfCJXSIdPcw==
X-Google-Smtp-Source: AA0mqf7ZtYDDJ2IFAE867kBTqxlzwB1uI1VqK/hqmWarvEfAn0P7kQ6WgWlvXfzxt+quHS3mJfT+oyRZ304eC8tCcx4=
X-Received: by 2002:a17:90a:5295:b0:219:a43b:1006 with SMTP id
 w21-20020a17090a529500b00219a43b1006mr17831027pjh.195.1670344026725; Tue, 06
 Dec 2022 08:27:06 -0800 (PST)
MIME-Version: 1.0
References: <20221206152358.1966099-1-jeffxu@google.com> <20221206152358.1966099-4-jeffxu@google.com>
 <Y49oIR6/ULTqlcwL@kroah.com>
In-Reply-To: <Y49oIR6/ULTqlcwL@kroah.com>
From:   Jeff Xu <jeffxu@google.com>
Date:   Tue, 6 Dec 2022 08:26:30 -0800
Message-ID: <CALmYWFvaEg84DYtjQtoQqsvaboX7mRS5dOqz8OJ0EYJTOCp4kg@mail.gmail.com>
Subject: Re: [PATCH v5 3/6] mm/memfd: add MFD_NOEXEC_SEAL and MFD_EXEC
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     jeffxu@chromium.org, skhan@linuxfoundation.org,
        keescook@chromium.org, akpm@linux-foundation.org,
        dmitry.torokhov@gmail.com, dverkamp@chromium.org, hughd@google.com,
        jorgelo@chromium.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        jannh@google.com, linux-hardening@vger.kernel.org,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Dec 6, 2022 at 8:04 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Tue, Dec 06, 2022 at 03:23:55PM +0000, jeffxu@chromium.org wrote:
> > --- a/kernel/pid_namespace.c
> > +++ b/kernel/pid_namespace.c
> > @@ -110,6 +110,11 @@ static struct pid_namespace *create_pid_namespace(struct user_namespace *user_ns
> >       ns->ucounts = ucounts;
> >       ns->pid_allocated = PIDNS_ADDING;
> >
> > +#if defined(CONFIG_SYSCTL) && defined(CONFIG_MEMFD_CREATE)
> > +     ns->memfd_noexec_scope =
> > +             task_active_pid_ns(current)->memfd_noexec_scope;
> > +#endif
>
> .c files should never have #if in them.  Can't you put this in a .h file
> properly so that this does not get really messy over time?
>
>
Thanks for reviewing.
It seems to me that checking for CONFIG_XXX is  common in c code in
kernel/ path.
Do you have a sample code pattern (link/function) that I can follow?

Thanks
Jeff

>
> > +
> >       return ns;
> >
> >  out_free_idr:
> > @@ -255,6 +260,45 @@ void zap_pid_ns_processes(struct pid_namespace *pid_ns)
> >       return;
> >  }
> >
> > +#if defined(CONFIG_SYSCTL) && defined(CONFIG_MEMFD_CREATE)
>
> Same here.
>
> thanks,
>
> greg k-h
