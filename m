Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D26314F8DD5
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Apr 2022 08:26:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233999AbiDHD43 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 7 Apr 2022 23:56:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233968AbiDHD42 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 7 Apr 2022 23:56:28 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44506C6F32
        for <linux-kselftest@vger.kernel.org>; Thu,  7 Apr 2022 20:54:24 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id r13so14815125ejd.5
        for <linux-kselftest@vger.kernel.org>; Thu, 07 Apr 2022 20:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D7YUStDPWza8UkzrpgFtnrpD2famjW1bAkdmrqOtSUU=;
        b=fUK2vPxt9SxmMdjIhTXLvMnPX8/W+JXqShZctLnEO2mgWM0WeZZVnHL6eyemUzWAoC
         5pxf15Sifcij9t6M5N+igcrpuoxkx3Dg4SzoBRDG+rrepHrYRvQSwguMi/7plnrh5b3P
         BDBfQbAKoWNKGDUwindRGVfnKhaCVD20ybPUB8d9eBf70yMwTYamODviazTUReKe6oru
         9mbkXodUmVOGzEqpdHCoe6zOsrNDpY9iQB34YB44Aye/UvAPUqOrMshpDH1Kznjq7eKx
         1Mz9LBf+cLQqKnQzw8hS3HvW1aMOE2qLFoaLSG1PxLk9QcFonNGUeMAX2Lc8vYMw4dlr
         NS5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D7YUStDPWza8UkzrpgFtnrpD2famjW1bAkdmrqOtSUU=;
        b=B0RCYTrLoUgELC7IKFx95ACNYeR7z+ZIKpYwoRp9NCegtKLNB8bRHUT+HiXGpyRmCq
         A2kU2PXf/yk8t52KAsMoOJEE3oBMy7bafA1pE9qGWfIKP2mSpvuffmur8687Aj4Rq6aO
         qWtQLoaf9vPsJvmzdxoApH/WXbeMqq/saK5iR//WjTrKfUB3QHo0FfvYlNfHxNOqXHyG
         F1wZRXhbCLg0Hph/fYnGCe0l9fQhjPpTHcsnItjnvnvu6gDeD2yq8PcugsfOjlrjXZAE
         uWsd+DJsYwq0XZawsYyMDnOKPWox0GZFXBQMV5XQBfMjbHQZce8E2PxGl6vHNDVsmEEQ
         0Eow==
X-Gm-Message-State: AOAM533JZNOknilmjDwzPkI1UD9Io7zMsHx8VjTugj3mPeh63AbtZ7HO
        K23PfyvoL87yI/UsnrEo4PFDlPJQfO0vc6tGI7Ftkw==
X-Google-Smtp-Source: ABdhPJzYaQe8DeQfbrUhPeHDR7UtJGv4KPUhY2QBaOSCZd2f3v2VzCBUqNex3z72UZuLa3zNcZ3UNLHOSaw5qz4jf0U=
X-Received: by 2002:a17:907:6d8b:b0:6e7:5610:d355 with SMTP id
 sb11-20020a1709076d8b00b006e75610d355mr16269440ejc.369.1649390062564; Thu, 07
 Apr 2022 20:54:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220407223019.2066361-1-dlatypov@google.com> <CABVgOSmdD=GHN5yaU500Txd6r3w-ubNS5YM92PRbJRpcVKLMXA@mail.gmail.com>
In-Reply-To: <CABVgOSmdD=GHN5yaU500Txd6r3w-ubNS5YM92PRbJRpcVKLMXA@mail.gmail.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Thu, 7 Apr 2022 22:54:11 -0500
Message-ID: <CAGS_qxrpPquXVTOhDs4hvBfC-yBZKOCBGhEudh=PHz_tNCBwEA@mail.gmail.com>
Subject: Re: [PATCH] kunit: tool: don't print out test statuses w/ 0s in summary
To:     David Gow <davidgow@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Apr 7, 2022 at 10:48 PM David Gow <davidgow@google.com> wrote:
>
> On Fri, Apr 8, 2022 at 6:30 AM Daniel Latypov <dlatypov@google.com> wrote:
> >
> > Before:
> > > Testing complete. Passed: 137, Failed: 0, Crashed: 0, Skipped: 36, Errors: 0
> >
> > After:
> > > Testing complete. Passed: 137, Skipped: 36
> >
> > Even with our current set of statuses, the output is a bit verbose.
> > It could get worse in the future if we add more (e.g. timeout, kasan).
> > Let's only print the relevant ones.
> >
> > I had previously been sympathetic to the argument that always
> > printing out all the statuses would make it easier to parse results.
> > But now we have commit acd8e8407b8f ("kunit: Print test statistics on
> > failure"), there are test counts printed out in the raw output.
> > We don't currently print out an overall total across all suites, but it
> > would be easy to add, if we see a need for that.
> >
> > Signed-off-by: Daniel Latypov <dlatypov@google.com>
> > ---
>
> Looks good to me. I agree that we should add a total, too. I was
> thinking of adding one anyway, but now there's more space for it, I've
> just sent a patch out.

I was specifically referring to the test statistics in the kernel output.
We print out the counts per suite, but we don't print out the total count.

But a total in the kunit.py parsed output might be useful as well.

>
> Reviewed-by: David Gow <davidgow@google.com>
>
> Cheers,
> -- David
