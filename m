Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C016763CF6
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Jul 2023 18:53:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230335AbjGZQxl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 26 Jul 2023 12:53:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjGZQxk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 26 Jul 2023 12:53:40 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA23B26A6
        for <linux-kselftest@vger.kernel.org>; Wed, 26 Jul 2023 09:53:38 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3fb4146e8fcso9097475e9.0
        for <linux-kselftest@vger.kernel.org>; Wed, 26 Jul 2023 09:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690390417; x=1690995217;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2UPiX7fReDR3fI6kmxK7fKJRGBv6XCkE0IO8pClG7+g=;
        b=IBozOJkHMEJObNgwvMorzSH0KtIJG9/P8EQ1ZZJVm28cONWXXjTayecK4rWdnAyUxW
         xxbMsywVvJPOah5xbdygmmgf+ExN/CF0K0egEoibj6PKc5IY6dINi6UaHUBLrrmte37n
         qic+uwFKpgt43UklcnIv686n/cFqm13uOiM9iMZFtjQLJqOuOHW106bp0ljruQlr69w3
         AnNrCBMX1dkprJy1ItKB7yxlKQvEbFdlYpsQuo/sAJ6RNxGA+WFBXtGTDXp5+veI3VGk
         L49LlZG33rdpSc3BboCAuzFoSAI0Zlf0aIGHtfzhMFBjbcfnxs+ej+jjt00pALR/gJ/r
         GpIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690390417; x=1690995217;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2UPiX7fReDR3fI6kmxK7fKJRGBv6XCkE0IO8pClG7+g=;
        b=JlRqMlx3VIasuyEv8hPxn2e7sclEHrbfEqaXdkp8Zx61e0FKYfybNGouPsql4ysCNK
         rA/t0MA28/vJj6ARYUCtNnySXByKYmLOwHwwYS+BewCcPhZOmGUjF0JG/KpKS9iVwOFK
         RX8Q5pIa/9GIAZ+oIbSu+Owg4l1DEPFDWm3LFbfaZCK4zQFCj0j1b7tuVi3nkgRDMUMk
         Xeb2XzrIKSFQXSk2aNUjh9H0sWE4tS8ClgAEaAkxqH4L5NitCTluXgxgJ/lkaC4SsvQ2
         f1TLgaapbmDl4H5tDOZKMfKb9bGwQDjThDSNfJ/JkZjL8l7MaH00liLN99MGjnWtHo0x
         bBUA==
X-Gm-Message-State: ABy/qLZpl8yGgeHEeRs+vUYBAjG/IkBYlGtKnEZTZt8gbT2fJB1DEOgy
        Gj58+R/zxaSx2bxvM89wlYv0sQ==
X-Google-Smtp-Source: APBJJlFH2LcZdnXOgKo+SIZ831oYDnQvR/FZ52W3UHhYnhv2g2sJD4xB3T7pPoCuCQZaT/q8WmoofQ==
X-Received: by 2002:a05:600c:4e14:b0:3fa:ef97:1fa5 with SMTP id b20-20020a05600c4e1400b003faef971fa5mr77269wmq.6.1690390417249;
        Wed, 26 Jul 2023 09:53:37 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id f2-20020a7bc8c2000000b003fc04eb92cbsm2483960wml.44.2023.07.26.09.53.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 09:53:36 -0700 (PDT)
Date:   Wed, 26 Jul 2023 19:53:33 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Yan Zhai <yan@cloudflare.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-kselftest@vger.kernel.org, kernel-team@cloudflare.com,
        Jordan Griege <jgriege@cloudflare.com>,
        Markus Elfring <Markus.Elfring@web.de>,
        Jakub Sitnicki <jakub@cloudflare.com>
Subject: Re: [PATCH v4 bpf 1/2] bpf: fix skb_do_redirect return values
Message-ID: <8b681fe1-4cc6-4310-9f50-1cff868f8f7f@kadam.mountain>
References: <cover.1690332693.git.yan@cloudflare.com>
 <e5d05e56bf41de82f10d33229b8a8f6b49290e98.1690332693.git.yan@cloudflare.com>
 <a76b300a-e472-4568-b734-37115927621d@moroto.mountain>
 <ZMEqYOOBc1ZNcEER@debian.debian>
 <bc3ec02d-4d4e-477a-b8a5-5245425326c6@kadam.mountain>
 <ZMFFbChK/66/8XZd@debian.debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZMFFbChK/66/8XZd@debian.debian>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Jul 26, 2023 at 09:10:20AM -0700, Yan Zhai wrote:
> On Wed, Jul 26, 2023 at 06:01:00PM +0300, Dan Carpenter wrote:
> > On Wed, Jul 26, 2023 at 07:14:56AM -0700, Yan Zhai wrote:
> > > On Wed, Jul 26, 2023 at 04:39:08PM +0300, Dan Carpenter wrote:
> > > > I'm not positive I understand the code in ip_finish_output2().  I think
> > > > instead of looking for LWTUNNEL_XMIT_DONE it should instead look for
> > > > != LWTUNNEL_XMIT_CONTINUE.  It's unfortunate that NET_XMIT_DROP and
> > > > LWTUNNEL_XMIT_CONTINUE are the both 0x1.  Why don't we just change that
> > > > instead?
> > > > 
> > > I considered about changing lwt side logic. But it would bring larger
> > > impact since there are multiple types of encaps on this hook, not just
> > > bpf redirect. Changing bpf return values is a minimum change on the
> > > other hand. In addition, returning value of NET_RX_DROP and
> > > NET_XMIT_CN are the same, so if we don't do something in bpf redirect,
> > > there is no way to distinguish them later: the former is considered as
> > > an error, while "CN" is considered as non-error.
> > 
> > Uh, NET_RX/XMIT_DROP values are 1.  NET_XMIT_CN is 2.
> > 
> > I'm not an expert but I think what happens is that we treat NET_XMIT_CN
> > as success so that it takes a while for the resend to happen.
> > Eventually the TCP layer will detect it as a dropped packet.
> > 
> My eyes slipped lines. CN is 2. But the fact RX return value can be
> returned on a TX path still makes me feel unclean. Odds are low that
> we will have new statuses in future, it is a risk. I'd hope to contain
> these values only inside BPF redirect code as they are the reason why
> such rx values can show up there. Meanwhile, your argument do make
> good sense to me that the same problem may occur for other stuff. It
> is true. In fact, I just re-examined BPF-REROUTE path, it has the
> exact same issue by directly sending dst_output value back.
> 
> So I would propose to do two things:
> 1. still convert BPF redirect ingress code to contain the propagation
> of mixed return. Return only TX side value instead, which is also what
> majority of those local senders are expecting. (I was wrong about
> positive values returned to sendmsg below btw, they are not).
> 
> 2. change LWTUNNEL_XMIT_CONTINUE and check for this at xmit hook.
> 

Sounds good!

regards,
dan carpenter

