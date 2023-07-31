Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCE51769972
	for <lists+linux-kselftest@lfdr.de>; Mon, 31 Jul 2023 16:27:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229829AbjGaO1F (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 31 Jul 2023 10:27:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230229AbjGaO07 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 31 Jul 2023 10:26:59 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF04FC9
        for <linux-kselftest@vger.kernel.org>; Mon, 31 Jul 2023 07:26:57 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-31751d7d96eso3832669f8f.1
        for <linux-kselftest@vger.kernel.org>; Mon, 31 Jul 2023 07:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690813616; x=1691418416;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=d0amng8ESj5Ivn3+1Qpwn6F8c5hSHQtHpqsKrSaqmyM=;
        b=uc+fd4z3doK5zO6DlkUKmP75VP+YhckG31qRdKmzMx3SfzHxgEvUG4TZJe3y+phASO
         Vt6Vj2SpM+mhoB8FlaaLfSg4GvJr5glzyru4hhZn2/OF34PIdvyQuuXIC2o82IDlbMkT
         lvFY0u9O1qGNbQKhcLXSslU6Vjv6a+4hxvgmthJJEMVtsaJzdLjgk1j/Kq9rQ4lHsJTR
         Ep8xhUPTxZj6UgC7aru352SW/OnJsGkG03+RxM49bagpvN9UyEQbzbEjYCKCq+GDPMFr
         ipmS+4dk5mg5xGqNuajn9l1LXxr1F4Lh8OtGHZ3MAO2L7rx6TLAp98U/lDNOZOVNjYLy
         fd2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690813616; x=1691418416;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d0amng8ESj5Ivn3+1Qpwn6F8c5hSHQtHpqsKrSaqmyM=;
        b=edKVeL7qCvlclD1z9gJ3tbRHuyvXld+XO7h1ySL4KlmMvhgB6QWIn6EaqGI280AD1W
         KJ5gGoBVfgn65emJy7s+mieg1+GRRq0ockkjP9uhEwH8Muk7kbpjH9yFzxJdn60rTsL3
         Hgi3LAtmZR5JvPYJ8r/L/XLdB3KNQETaarKlqUaGvthybQc+ZOh43fYh7nTMCqw3mx8z
         iOrA9DW+DnRj7FO4Ogmpc5Wt1klagC+IgvtkkyH9rPEPnj85qKsVitbb5yxvQpawe7L6
         FzJN7R/0SoQYSBq6O1VTv//IUz7Bj7YgbtcWXsMK/+BSgaMxHh7BopZjngLn+XEH3VNu
         grSg==
X-Gm-Message-State: ABy/qLZo9vBbM/AK9gJBTTypx4hnuUAK+kPc0LOCiVAhu+ZdFYjVfRnL
        77wsQP618Ov7AuEd1wa259wHqw==
X-Google-Smtp-Source: APBJJlGzCyI+U5RVUU8FDM+eBfMc+3uCEUPv/aNqKzgnlSN7kdoPm8KbQdY/Zxi8dDL10HtPb67Ihw==
X-Received: by 2002:adf:f70c:0:b0:313:f61c:42b2 with SMTP id r12-20020adff70c000000b00313f61c42b2mr5302957wrp.69.1690813616290;
        Mon, 31 Jul 2023 07:26:56 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id a8-20020adfed08000000b0031417b0d338sm13274552wro.87.2023.07.31.07.26.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 07:26:56 -0700 (PDT)
Date:   Mon, 31 Jul 2023 17:26:53 +0300
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
Message-ID: <38c61917-98b5-4ca0-b04e-64f956ace6e4@kadam.mountain>
References: <cover.1690332693.git.yan@cloudflare.com>
 <e5d05e56bf41de82f10d33229b8a8f6b49290e98.1690332693.git.yan@cloudflare.com>
 <a76b300a-e472-4568-b734-37115927621d@moroto.mountain>
 <ZMEqYOOBc1ZNcEER@debian.debian>
 <bc3ec02d-4d4e-477a-b8a5-5245425326c6@kadam.mountain>
 <ZMFFbChK/66/8XZd@debian.debian>
 <8b681fe1-4cc6-4310-9f50-1cff868f8f7f@kadam.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8b681fe1-4cc6-4310-9f50-1cff868f8f7f@kadam.mountain>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

I'm not a networking person, but I was looking at some use after free
static checker warnings.

Apparently the rule with xmit functions is that if they return a value
> 15 then that means the skb was not freed.  Otherwise it's supposed to
be freed.  So like NETDEV_TX_BUSY is 0x10 so it's not freed.

This is checked with using the dev_xmit_complete() function.  So I feel
like it would make sense for LWTUNNEL_XMIT_CONTINUE to return higher
than 15.

Because that's the bug right?  The original code was assuming that
everything besides LWTUNNEL_XMIT_DONE was freed.

regards,
dan carpenter

