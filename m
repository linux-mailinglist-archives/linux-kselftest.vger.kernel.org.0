Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06E79651012
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Dec 2022 17:15:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232125AbiLSQPZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 19 Dec 2022 11:15:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232124AbiLSQO4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 19 Dec 2022 11:14:56 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B20113D3E
        for <linux-kselftest@vger.kernel.org>; Mon, 19 Dec 2022 08:14:39 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id z8-20020a17090abd8800b00219ed30ce47so13546850pjr.3
        for <linux-kselftest@vger.kernel.org>; Mon, 19 Dec 2022 08:14:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5dL/5e66Q421m8/scPuFx+mndERQbshrnwDDg3EMSsc=;
        b=qR+VevN661+iIuH02xO+YfS45M/ZR1cMO1J/nhGa4mYsarAqugAWZG0qrD9QBtNOqq
         bgY55YbQrxbEodLAWCRxjZ30qiz20kG2kkiyqLGZiq4y+APUg8E7MO6Hj95aTsqIPGq5
         23+V/eLiiE6BUDMXkf4hGBHJ0OKt1CTHWIy1v+s5SYaOHRL7Zp382cc7tiKdmgTrGMGN
         vBvJ704/VmBjE0Q5uP1wKCoKsT3d56s8AqLGjc1+MtYpEaebR3g/OcBBORdjU/4zg68l
         H+A0Jcyw8ZnHeQhVVFU5KMKc+DS4DpewNIt15/TmFdvVK5XxMkX/PNZqEk/65c7dE94O
         Kxzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5dL/5e66Q421m8/scPuFx+mndERQbshrnwDDg3EMSsc=;
        b=ebvHTHAxBqDdW5ruaohFvZofpeg0SbMwhzvS5O4W4QcacneJR8KtxF/32ldWLutc3j
         dWj5jUsg5OJ8/stUyNrc24Y4YtOJ8HrywsnNMN7JmO/jW8qWxkG7vCmTwxKxhyWPrmiA
         NeRysnPVGwealrm/bXJV6LDKlpPtpe7ek7d63dglqKfzMGNj5Zvp/xqQovdiyTutTTbQ
         iz0L49YRw2xR2K2a9O3oiwlAmGIHhCIz0KepMUmyWAzxepzq67FxYXN6K24DhGZ1KFWy
         RWm/uXpfq7ShS9Ol6bP808A9Iz3zEYKIyIMSGhwWbosJ2TFr5n8b4RjPnV715Eq0YBZg
         eK+g==
X-Gm-Message-State: AFqh2kr9wfNZ/t+k723Hj5Kh6MiQYaWMmfFynjdS4KSwwZhs8OGNKJio
        kzOTmyitMV7CXr2jclL2TPs9hA==
X-Google-Smtp-Source: AMrXdXvmp3Jyv+LOxgrryADAvlI8P5f1UyM6BBcn0v37B0TGn7ATjOYxPhmskeOx8cTau2VjzR025A==
X-Received: by 2002:a17:90a:e28d:b0:218:84a0:65eb with SMTP id d13-20020a17090ae28d00b0021884a065ebmr1217698pjz.1.1671466478651;
        Mon, 19 Dec 2022 08:14:38 -0800 (PST)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id pw6-20020a17090b278600b00213c7cf21c0sm6113969pjb.5.2022.12.19.08.14.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 08:14:38 -0800 (PST)
Date:   Mon, 19 Dec 2022 16:14:34 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Like Xu <like.xu.linux@gmail.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
        kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: selftests: Install sanitised kernel headers before
 compilation
Message-ID: <Y6CN6kWo+KPD5wOi@google.com>
References: <20221219095540.52208-1-likexu@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221219095540.52208-1-likexu@tencent.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Dec 19, 2022, Like Xu wrote:
> From: Like Xu <likexu@tencent.com>
> 
> On many automated test boxes, selftests in a completely clean src tree
> will be compiled independently: "make -j -C tools/testing/selftests/kvm".
> Sometimes the compilation will fail and produce a false positive just
> due to missing kernel headers (or others hidden behind the complete
> kernel compilation or installation).
> 
> Optimize this situation by explicitly adding the installation of sanitised
> kernel headers before compilation to the Makefile.
> 
> Reported-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Like Xu <likexu@tencent.com>
> ---
>  tools/testing/selftests/kvm/Makefile | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
> index 947676983da1..a33e2f72d745 100644
> --- a/tools/testing/selftests/kvm/Makefile
> +++ b/tools/testing/selftests/kvm/Makefile
> @@ -202,6 +202,11 @@ TEST_GEN_PROGS_EXTENDED += $(TEST_GEN_PROGS_EXTENDED_$(UNAME_M))
>  LIBKVM += $(LIBKVM_$(UNAME_M))
>  
>  INSTALL_HDR_PATH = $(top_srcdir)/usr
> +
> +ifeq ($(shell make -j -C ../../../.. headers_install),)
> +	$(error "Please install sanitised kernel headers manually.")
> +endif

Auto-installation of headers was recently removed[*], presumably whatever problem
existed with KSFT_KHDR_INSTALL also exists with this approach.

FWIW, I also find the need to manually do headers_install annoying, but it's easy
to workaround via bash aliases.

[*] https://lore.kernel.org/lkml/cover.1657296695.git.guillaume.tucker@collabora.com
