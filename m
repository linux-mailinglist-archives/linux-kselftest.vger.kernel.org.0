Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35A4559A5FC
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Aug 2022 21:17:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350779AbiHSTHl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 19 Aug 2022 15:07:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350622AbiHSTHi (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 19 Aug 2022 15:07:38 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90962109A22
        for <linux-kselftest@vger.kernel.org>; Fri, 19 Aug 2022 12:07:37 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id m10-20020a17090a730a00b001fa986fd8eeso8417427pjk.0
        for <linux-kselftest@vger.kernel.org>; Fri, 19 Aug 2022 12:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=DHHhnraoY65tyRhzZg5vQ0+h6PvziDksTsOW2++v8Zs=;
        b=RPjmo2FxtGyLR8PYNrQ0WpMsIJGmf9vuJNzD3hcTlkiWIceSPrxTlQdWlGLXoPWmeZ
         QE8kzIm93mhy6fbK94/1CVsj3VUeiVVL9xd6IjE6nh8u+p3xHnEhzuSU0z+FeitWBm+u
         IT9bWa+bVqb8v01iZG+o6UeShRs5ZnjrIhqUg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=DHHhnraoY65tyRhzZg5vQ0+h6PvziDksTsOW2++v8Zs=;
        b=z6Os1pw5Wa/SRDXEbVIBaZYm8z+xQ5V1V6QQ+9f/hnX+4M8suDN7OXOeqBBttjVxsd
         mrO0xXG4D6hlzKj8peU5r6mMYuxmAXuikDuNf772IKTzhJOgqAvtFh85PQzF63Cs2Y/d
         8MOksi4A4Yj9kTsdM72GhPJgEU+B27LIYInmiTcbDd+6Az0rDGn3vaqXcLMIE0gGHlZC
         Lj+2eH6XKLywUNJJMSywhOiozsDgYTO1Qz6c9fYa/3H6aaGeDk+XPTf2j44t2mNbEZ8S
         ZKeDgcT6VCeUB7NgiVf95BrK5NyTXVKnr6QHhxq9ZJL+mCbJM42QNnAIe1z/iCJuajb6
         7c+g==
X-Gm-Message-State: ACgBeo2rVmpP8xzYh47W7//LqM4KZ9sq0RGwwIvMhqEXzcqxqRgxFKM0
        DwR35Al2ATN3w/6eYgqrpaFaIA==
X-Google-Smtp-Source: AA6agR6K8ZeFu5uVrPpEanR+fcoa22K2szNXPWdkjPu9h6Z5dqzuI/cjW0mM8eCRai82tKvovNirIQ==
X-Received: by 2002:a17:902:c40a:b0:16e:cc02:b9ab with SMTP id k10-20020a170902c40a00b0016ecc02b9abmr8595584plk.81.1660936057093;
        Fri, 19 Aug 2022 12:07:37 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y16-20020a17090a6c9000b001f216407204sm3522272pjj.36.2022.08.19.12.07.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 12:07:36 -0700 (PDT)
Date:   Fri, 19 Aug 2022 12:07:35 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Axel Rasmussen <axelrasmussen@google.com>
Cc:     Andrei Vagin <avagin@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Paolo Abeni <pabeni@redhat.com>,
        Pavel Begunkov <asml.silence@gmail.com>,
        Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] selftests: fix a couple missing .gitignore entries
Message-ID: <202208191207.56B7DDE@keescook>
References: <20220819190558.477166-1-axelrasmussen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220819190558.477166-1-axelrasmussen@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Aug 19, 2022 at 12:05:58PM -0700, Axel Rasmussen wrote:
> Some recent commits added new test binaries, but forgot to add those to
> .gitignore. Now, after one does "make -C tools/testing/selftests", one
> ends up with some untracked files in the kernel tree.
> 
> Add the test binaries to .gitignore, to avoid this minor annoyance.
> 
> Fixes: d8b6171bd58a ("selftests/io_uring: test zerocopy send")
> Fixes: 6342140db660 ("selftests/timens: add a test for vfork+exit")
> Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
