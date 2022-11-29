Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D87D563BC65
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Nov 2022 09:59:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231642AbiK2I7k (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 29 Nov 2022 03:59:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231624AbiK2I7h (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 29 Nov 2022 03:59:37 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5680350D5B;
        Tue, 29 Nov 2022 00:59:36 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id w23so12749949ply.12;
        Tue, 29 Nov 2022 00:59:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+Lmpq7VrBSREoxRAFIm/Yh9qhesF+CF91NiSA6vujoc=;
        b=OskYZlSflhIt6iflBqWJVsqxBguXuMSrwLVYUmvYGiI5MWRxY1jkRrg1x/hcA0QiQS
         dZjwItWPM1bfRncH7kJBVLVnJo/CY8jERFsLFS0X4r9Igx/Aakh3XTEsWwLCh/2WvRCd
         Mo9oMma9+EeTLXdbOS9nrUxATEZokhF+/yctHpX2dLxrMeXLc0rMalp+niprF3IRgO3s
         e+kt21As4P3GKCOXwVE/ca7E3dKITN92mfPseJl+DZvYGkE7fxFr3GyZGcwwykmndhDd
         WKRFoa4fQv9EgFTtFr2GJT00OKKlAU/5f+EM2dGzx/4OOshpiT/Cu/to4UGh5sNS26a9
         P+tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Lmpq7VrBSREoxRAFIm/Yh9qhesF+CF91NiSA6vujoc=;
        b=CEF9Tk8Re9KfTl2dMzC/gRvRy/O1eAt3jYNuC6mqICcnDdQaiEwePOqniIPSCT8IDM
         Lpyp2Z/UXj7zBSNCsNooR0mUm7VW4nJR4vlgDJKDcobFMlr+gTlJqmLTGeqtrGlwm5gQ
         z08xEWqMjKFNRalXUkFOeP77vSb5/4diLfpXKS4uvG/wjnOEqrOM0sgvbTTvU+EJKYH9
         iyqtyV1Y092C9rKOdVJkv9OH7lLUmWl8xKQ9+yepuePHL/NNeXM0iAt+Kww0iiAVzzuU
         NAWDl73MEd5Q++c0p+Q3Crt8EHJNQVgqWsiVs4Bk+ZHqWNdFgmOOSky3bnIL58VrlNME
         4gDA==
X-Gm-Message-State: ANoB5pmbIi0Rf6PfkXV8mpTWW6+xhsNc1Zuo0dIGeKgyhALjhnKLxlT6
        TfgdOnTQX3Ym5bpygSLuqLU=
X-Google-Smtp-Source: AA0mqf6RP25gcvllBnCRd/6OgKNlnW1j7lzdLoel7mq3RzQUGfVotrIeEuyU/LOekhqwsIazO1DLKQ==
X-Received: by 2002:a17:903:2350:b0:189:9004:cf1f with SMTP id c16-20020a170903235000b001899004cf1fmr7514243plh.154.1669712375807;
        Tue, 29 Nov 2022 00:59:35 -0800 (PST)
Received: from mail.google.com ([103.135.102.183])
        by smtp.gmail.com with ESMTPSA id 13-20020a170902c24d00b00188f8badbcdsm10268152plg.137.2022.11.29.00.59.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Nov 2022 00:59:34 -0800 (PST)
Date:   Tue, 29 Nov 2022 16:59:22 +0800
From:   Changbin Du <changbin.du@gmail.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Changbin Du <changbin.du@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Quentin Monnet <quentin@isovalent.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>,
        linux-perf-users@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 1/2] libbpf: show more info about missing ".BTF" section
Message-ID: <20221129085922.yad7lefg472vgl5z@mail.google.com>
References: <20221126111147.199366-1-changbin.du@gmail.com>
 <20221126111147.199366-2-changbin.du@gmail.com>
 <CAEf4BzYt7MhKjWfdxKUe10mUxDoCYeWNHYr1-ruCxMEmNqJqqA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzYt7MhKjWfdxKUe10mUxDoCYeWNHYr1-ruCxMEmNqJqqA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Nov 28, 2022 at 09:59:00PM -0800, Andrii Nakryiko wrote:
> On Sat, Nov 26, 2022 at 3:13 AM Changbin Du <changbin.du@gmail.com> wrote:
> >
> > Show more information about why failed instead of just saying "No such file or
> > directory".
> >
> > Now will print below info:
> > libbpf: can not find '.BTF' section
> > libbpf: is CONFIG_DEBUG_INFO_BTF enabled for kernel?
> > Error: failed to load BTF from /home/changbin/work/linux/vmlinux: No such file or directory
> >
> > Signed-off-by: Changbin Du <changbin.du@gmail.com>
> > ---
> >  tools/lib/bpf/btf.c | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> >
> > diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> > index d88647da2c7f..3f661d991808 100644
> > --- a/tools/lib/bpf/btf.c
> > +++ b/tools/lib/bpf/btf.c
> > @@ -906,6 +906,15 @@ struct btf *btf__new(const void *data, __u32 size)
> >         return libbpf_ptr(btf_new(data, size, NULL));
> >  }
> >
> > +static bool is_vmlinux(const char *path)
> > +{
> > +       size_t path_len = strlen(path);
> > +       size_t suffix_len = strlen("vmlinux");
> > +
> > +       return (path_len >= suffix_len) &&
> > +              (!memcmp(path + path_len - suffix_len, "vmlinux", suffix_len));
> > +}
> > +
> >  static struct btf *btf_parse_elf(const char *path, struct btf *base_btf,
> >                                  struct btf_ext **btf_ext)
> >  {
> > @@ -990,6 +999,9 @@ static struct btf *btf_parse_elf(const char *path, struct btf *base_btf,
> >         err = 0;
> >
> >         if (!btf_data) {
> > +               pr_warn("can not find '%s' section\n", BTF_ELF_SEC);
> > +               if (is_vmlinux(path))
> > +                       pr_warn("is CONFIG_DEBUG_INFO_BTF enabled for kernel?\n");
> 
> this is generic piece of BTF loading code in libbpf, it knows nothing
> and should know nothing about vmlinux and CONFIG_DEBUG_INFO_BTF, this
> is not the right place to add such suggestions.
> 
> Check bpf_object__load_vmlinux_btf(), libbpf emits vmlinux-specific
> error there: "Error loading vmlinux BTF". If we need to mention
> CONFIG_DEBUG_INFO_BTF anywhere, that would be the place to do that.
>
Agreed. I think adding "can not find '.BTF' section" is enough to diagnose the problem.
The standalone error msg "No such file or directory" is really weird.

> >                 err = -ENOENT;
> >                 goto done;
> >         }
> > --
> > 2.37.2
> >

-- 
Cheers,
Changbin Du
