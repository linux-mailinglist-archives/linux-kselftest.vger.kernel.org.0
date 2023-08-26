Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A6F1789561
	for <lists+linux-kselftest@lfdr.de>; Sat, 26 Aug 2023 11:46:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231514AbjHZJp5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 26 Aug 2023 05:45:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232358AbjHZJpf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 26 Aug 2023 05:45:35 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A841B5;
        Sat, 26 Aug 2023 02:45:33 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-31c6cd238e0so1737255f8f.0;
        Sat, 26 Aug 2023 02:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693043131; x=1693647931;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EcmeCq/32Wiyi3Ru6rZay2ig3zBVjavNEyIttUA3Hls=;
        b=chwHg8mGkspRC0bpi1AOT4+Xo82JletVcBQUGMJu1iMGLwh8xJs3KfV5mAM9xGQqXz
         daVXupwyuiVECSDFN/43DgShfgF6bPzGUEaLfuqgPKVYhq5pfzBTJaGG0ebhZFa5C1qD
         iGNBNjwA20ReXbAhzUmZk1NKbxIhuLyVQUKAbVuHO+hhFFzFz7sUYKJeIrCmb6nffMeJ
         dKTcLDSau51/EX3YkDm0NDttOOi9N5PBg4WQ4ITUf7codCnlTlMDEqyQzsCJEWyO/eqr
         pTNNxeLoebEsFHftK+CvX4mCidW5CIVegIKzGaDQ25ojJmQg70ipnBxiLZIJqc67/f2K
         yLMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693043131; x=1693647931;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EcmeCq/32Wiyi3Ru6rZay2ig3zBVjavNEyIttUA3Hls=;
        b=CPg1Qh/5Is/m8ys++ONJc8Pu1Jr2aJBoqJ4JsnCoIv3vrnNmR79Pzgu2imfFqxjIh5
         Iu9DnGugmuJ84+2dd2xI6HhNXjdchp14/pVRBVw9+kjFveGVl0uln22p//HBNa22Ud73
         HXEk+7GhtAYnYZkO02MA7sexf0wUKqIVSnCpfXnkDG01Yl/p9sS9APiufb2ry095H9tl
         y3lZaaA9r37AhN6P3qR5+ppw48rRGwVuT8BbzPvCiSQBv8ONGAaWFGhIfYFV0TAtCQrF
         sj5PpYI3C+9xxD2ixB/whO3Ynn+UoQcVI4uhVqNNUaLKi2yDuCRF0RvI23+QO/Y7MBli
         wfDw==
X-Gm-Message-State: AOJu0Yyqn4xScNTxJfErYcAB4W+N+jxNMNKTD1ze7vFGp8weCNiq/E2A
        Ct1vlgyT4hGueR4JAfn1oKo=
X-Google-Smtp-Source: AGHT+IGugDagkjN8l4cZ2iCV4RjulgnZxvwY3RYAOx3N3ArjiJDFmUO3gLNIyGsmg0LAwwuVbUP2CQ==
X-Received: by 2002:adf:ec8a:0:b0:317:de66:259b with SMTP id z10-20020adfec8a000000b00317de66259bmr16715345wrn.15.1693043131326;
        Sat, 26 Aug 2023 02:45:31 -0700 (PDT)
Received: from mmaatuq-HP-Laptop-15-dy2xxx ([2001:8f8:1163:6db:5fbb:8783:6dd3:4939])
        by smtp.gmail.com with ESMTPSA id x3-20020a05600c2a4300b003fe601a7d46sm7646174wme.45.2023.08.26.02.45.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Aug 2023 02:45:30 -0700 (PDT)
Date:   Sat, 26 Aug 2023 13:45:23 +0400
From:   Mahmoud Matook <mahmoudmatook.mm@gmail.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     keescook@chromium.org, edumazet@google.com,
        willemdebruijn.kernel@gmail.com, wad@chromium.org,
        luto@amacapital.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kuba@kernel.org, shuah@kernel.org,
        pabeni@redhat.com, linux-kselftest@vger.kernel.org,
        davem@davemloft.net,
        linux-kernel-mentees@lists.linuxfoundation.org,
        David Laight <David.Laight@aculab.com>
Subject: Re: [PATCH v2 1/2] selftests: Provide local define of min() and max()
Message-ID: <20230826094523.bl6kbcwelj23cydu@mmaatuq-HP-Laptop-15-dy2xxx>
Mail-Followup-To: Sean Christopherson <seanjc@google.com>,
        keescook@chromium.org, edumazet@google.com,
        willemdebruijn.kernel@gmail.com, wad@chromium.org,
        luto@amacapital.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kuba@kernel.org, shuah@kernel.org,
        pabeni@redhat.com, linux-kselftest@vger.kernel.org,
        davem@davemloft.net, linux-kernel-mentees@lists.linuxfoundation.org,
        David Laight <David.Laight@aculab.com>
References: <20230824202415.131824-1-mahmoudmatook.mm@gmail.com>
 <ZOjIHo2A6HZ8K4Qp@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZOjIHo2A6HZ8K4Qp@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 08/25, Sean Christopherson wrote:

> On Fri, Aug 25, 2023, Mahmoud Maatuq wrote:
> > to avoid manual calculation of min and max values
> > and fix coccinelle warnings such WARNING opportunity for min()/max()
> > adding one common definition that could be used in multiple files
> > under selftests.
> > there are also some defines for min/max scattered locally inside sources
> > under selftests.
> > this also prepares for cleaning up those redundant defines and include
> > kselftest.h instead.
> > 
> > Signed-off-by: Mahmoud Maatuq <mahmoudmatook.mm@gmail.com>
> > Suggested-by: David Laight <David.Laight@aculab.com>
> > ---
> > changes in v2:
> > redefine min/max in a more strict way to avoid 
> > signedness mismatch and multiple evaluation.
> > is_signed_type() moved from selftests/kselftest_harness.h 
> > to selftests/kselftest.h.
> > ---
> >  tools/testing/selftests/kselftest.h         | 24 +++++++++++++++++++++
> 
> Heh, reminds me of https://xkcd.com/927.
> 
> All of these #defines are available in tools/include/linux/kernel.h, and it's
> trivially easy for selftests to add all of tools/include to their include path.
> I don't see any reason for the selftests framework to define yet another version,
> just fix the individual tests.

giving the reviews seems that patchset is useless.
still a confusing point for me; after adding tools/include to the
include path of selftes how we can differentaite between  #include
<linux/kernel.h> that under tools/include and one under usr/include.
