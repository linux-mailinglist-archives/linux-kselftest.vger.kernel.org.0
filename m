Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A66E86D8B7F
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Apr 2023 02:12:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232642AbjDFAMi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 5 Apr 2023 20:12:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbjDFAMh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 5 Apr 2023 20:12:37 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E7A661AE
        for <linux-kselftest@vger.kernel.org>; Wed,  5 Apr 2023 17:12:35 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-4fa3ca41383so791530a12.3
        for <linux-kselftest@vger.kernel.org>; Wed, 05 Apr 2023 17:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dectris.com; s=google; t=1680739953;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QWqojSp8qeBF+mnrDb0v8Y1VEeoiQlSQ1yGGpxufYDs=;
        b=mmtf2AayBWm/z9sUCranjsDtUq8AxYpmX4yPfK4znmF2gMIODJ7tf13ZcvRf7XB84K
         AgOJLhfcSJpYEPHYwm5X0Fu3pt6ZBax5QjRsO69RzY2rTbyqiLNyDuId8qaErMGe3LMS
         iWF5PYWGarqFRVHJNktro71deVYVccaeWoaJw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680739953;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QWqojSp8qeBF+mnrDb0v8Y1VEeoiQlSQ1yGGpxufYDs=;
        b=Ldnnys9XhYDxVk5D+naReJYd8Euxy4xG+j6SYj0jLyqvenVPqbCWlIDR+K0k5AhTwU
         OU7/4n7MQt9N0ykyD30xJyb/+pn8uN4xHCAuISBXo03RShnu4TxH1Ff3DPyjkTFIapr+
         Dxf7odbKZbWhgvSc5+W7pEhBJmr0xSas1jPmHI2P1we1V+PJjtqrSwUBIsjv/r6x916u
         LJrB+mT/hFnkuzCgfYh0wfHnnoqA+0ZsAnQDaA+Kx9UnAeq+maPOTlrHMuccSb0qk/S7
         6JVIe9srhS8uyzDNNYfYsdIDM4UF6tTvMoJwBVLwGcxdxYYk5td/kQOr7LEsMRNKZOT6
         RXQA==
X-Gm-Message-State: AAQBX9eeQ/lDTYjQ3oZmqO0+b1lizLK9VwFpasGt6Se9//GClsD+XKW5
        5Ep6s2pf5I7gfIrBJtY6QWSbhWER/u9ycQ+vrUvb7A==
X-Google-Smtp-Source: AKy350bSg5cQf76vayF8cuTHt7hGbMj/aBgU/6HTmDSPmn/KXvw21Y1A4RFFgZK1jB9dW9Ud6Cu2kqEjEDgC+YjCXjw=
X-Received: by 2002:a50:8adc:0:b0:502:3c99:417f with SMTP id
 k28-20020a508adc000000b005023c99417fmr2041304edk.6.1680739953661; Wed, 05 Apr
 2023 17:12:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230405235920.7305-1-kal.conley@dectris.com> <20230405235920.7305-3-kal.conley@dectris.com>
In-Reply-To: <20230405235920.7305-3-kal.conley@dectris.com>
From:   Kal Cutter Conley <kal.conley@dectris.com>
Date:   Thu, 6 Apr 2023 02:17:13 +0200
Message-ID: <CAHApi-kRav_7jpkyTf+Ko7LJwx6_UO+1QydoAr-fMqeyBE=OYw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 2/2] selftests: xsk: Add test UNALIGNED_INV_DESC_4K1_FRAME_SIZE
To:     Magnus Karlsson <magnus.karlsson@intel.com>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Jonathan Lemon <jonathan.lemon@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> Add unaligned descriptor test for frame size of 4001. Using an odd frame
> size ensures that the end of the UMEM is not near a page boundary. This
> allows testing descriptors that staddle the end of the UMEM but not a
> page.
>
> This test used to fail without the previous commit ("xsk: Add check for
> unaligned descriptors that overrun UMEM").

Sorry I forgot to update the commit message with the new commit label.
If accepted, please change the second paragraph to :

This test used to fail without the previous commit ("xsk: Fix unaligned
descriptor validation").
