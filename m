Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AD6D780BAE
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Aug 2023 14:21:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352456AbjHRMVH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 18 Aug 2023 08:21:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376830AbjHRMUf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 18 Aug 2023 08:20:35 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EB3EE7C;
        Fri, 18 Aug 2023 05:20:34 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2b9c907bc68so13735051fa.2;
        Fri, 18 Aug 2023 05:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692361232; x=1692966032;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ub/I7oAE9mdMgYXjiwcngorSvPiNnL2dbcUUsmv0BaM=;
        b=VE39zB3hz+/hpT86z6kZOUoTGs5MqqSARYdAdgBz5CZh5WSlVQoy6wSdR5gKsBFN7a
         9g8hqj7CIhDUaYhsmdlpZ7qQ4QcbbZPoO/3+zewtJCDoxkrMjoa3JA/yA8sIaZKfhrHI
         0MnERjdQ3t9JzbeuRgB+KJqisopkWELf4ai1gRv/xshPNvoS6sFdF8tIxqDYzRPiEUxn
         2qbyQ7Ah+6Sm6RK2VoBEDcaJlMOyGgYd2/Q6ni7W9XyFLTR+ck7pbu/GMbm5vwXSLb0u
         JwLzvjvHABjeb/l4+lyuUdHW2hXqPXMNiTxU2pmASETn8NLVTar6DBcAcvnBEJM7sDoY
         ms7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692361232; x=1692966032;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ub/I7oAE9mdMgYXjiwcngorSvPiNnL2dbcUUsmv0BaM=;
        b=bUuw1sqDu1rVxHHI3DqzDXAlhKcZLEBoJka8tmEHcNtimWbvM5d+fZLRRanXzhioT+
         qWx/2jvonzp3CRWF3xdqyTjr7IRN3gl0c21lB02yFbKKHPVMvGLURIR/KMMoOgrPgM2S
         YdlX3SYJgNeG/ZZU+TPCGD5mZl84qhiD2UzwmACq5QuHZnbQpZY97mi0brdl/1FTC8oL
         8s8OeanqK9nwCXLB3+jCNh2MTQntpCP5D29T1Z+sKIx1i6nxtMfxjobiGXh2SxMuo2b5
         TLH1JQ8PKuBHkSv2pZ+vcQP1NJA5NkZ3t8JZR5Ua0/lp0z7VHSFp1EU+ztLE8ueYp8S5
         3wjg==
X-Gm-Message-State: AOJu0YxwCKB4seCUWXakzWoiW3d0tl2ab8Q8RljcInFCT/sBdO+eSbJr
        H36uM/BRbgYWOUK4YP5KrPF3i154K8s=
X-Google-Smtp-Source: AGHT+IHV52geStyhoBCayJBaDaML4sW80xlSCoF/9FKRxiUPiGgYa512JUA3YuFsbgb7NjJkzRhyKg==
X-Received: by 2002:a05:651c:216:b0:2b9:412a:111d with SMTP id y22-20020a05651c021600b002b9412a111dmr1720287ljn.42.1692361232222;
        Fri, 18 Aug 2023 05:20:32 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id d11-20020a17090694cb00b009934b1eb577sm1120514ejy.77.2023.08.18.05.20.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Aug 2023 05:20:31 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Fri, 18 Aug 2023 14:20:29 +0200
To:     Rong Tao <rtoax@foxmail.com>
Cc:     olsajiri@gmail.com, andrii@kernel.org, ast@kernel.org,
        bpf@vger.kernel.org, daniel@iogearbox.net, haoluo@google.com,
        john.fastabend@gmail.com, kpsingh@kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        martin.lau@linux.dev, mykolal@fb.com, rongtao@cestc.cn,
        sdf@google.com, shuah@kernel.org, song@kernel.org,
        yonghong.song@linux.dev
Subject: Re: [PATCH bpf-next v5] selftests/bpf: trace_helpers.c: optimize
 kallsyms cache
Message-ID: <ZN9iDSj3/vdk5pRX@krava>
References: <ZN3YeyMkgEg1IoKP@krava>
 <tencent_03EBFD524265EA7560341E91C5E04F083405@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_03EBFD524265EA7560341E91C5E04F083405@qq.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Aug 18, 2023 at 09:39:32AM +0800, Rong Tao wrote:
> Hi, Jiri. Thanks for your reply.
> 
> libbpf_ensure_mem() is in libbpf_internal.h, samples/bpf/ can't see it, do we
> reposition the function declaration?

I see, I had no idea trace_helpers.[ch] is included in samples/bpf

but it seems to have libbpf linked statically.. so you could just
include libbpf_internal.h and it should work, right? like we do
in selftests

jirka

> 
> Good Day
> Rong Tao
> 
