Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1D786E1C3F
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Apr 2023 08:15:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229476AbjDNGPP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 14 Apr 2023 02:15:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230062AbjDNGPN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 14 Apr 2023 02:15:13 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3B8859C5
        for <linux-kselftest@vger.kernel.org>; Thu, 13 Apr 2023 23:15:10 -0700 (PDT)
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 853B43F467
        for <linux-kselftest@vger.kernel.org>; Fri, 14 Apr 2023 06:15:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1681452905;
        bh=4x1ielA7OU/wWOjnJ79+3XpTDh/ue6rRtFlaiIdzFqA=;
        h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
         Content-Type:In-Reply-To;
        b=GXCNLZHMvI4+SJ5ycKDbBtnVAIkb8a78oKEusYu/i7DM7qSj1EOWx++hFP/ewWUtc
         8DTh7esZDz9NBFQGMWD/RqbKD+Dn77WBdbS4Xrjszb7xJnKBcJYaInX029nuO3DA4B
         FAuxxD/bhrtRJMwcyaNBmIvKVDghUos+cDmoK64OWAK9wqi/Nvb0WkfND5bWOADu2k
         d6GAvY8dbGHys0gYLwgOXGD5CjkPXmGz1bGyri3Uft0TlSXbTGHtls/kOmVlIrt3As
         VPu7RYYbVHfX5+nlD9YVGniCdHXLW3zDKApCgZR9mUGqcITf6PLMMJpsDFR8UdDz8D
         avqD+TAfA70rg==
Received: by mail-wm1-f72.google.com with SMTP id j15-20020a05600c1c0f00b003f0a83bf082so2086946wms.8
        for <linux-kselftest@vger.kernel.org>; Thu, 13 Apr 2023 23:15:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681452905; x=1684044905;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4x1ielA7OU/wWOjnJ79+3XpTDh/ue6rRtFlaiIdzFqA=;
        b=FPfqVHl71mqCfMxQACLN9CRdr48glrHrVWwUd+2FlOFydsVlo/8VPYx+5qUYH1sXn0
         Tdc/zl4nni6fWpcCLHW4xZd2W3TD3sCWA3/Ea5rBQCrWHKxJ55MEyFwMdaJ9XIXzLqUR
         9hLPhs/Ewn9Vn0+J/DHtCuwk8lMq+szHrA6KkDSVoPFvPErZCc6cPfJemRZtV8FqsgcU
         7HcntL9xeeulnXc4YOeuMuXb909GG82gv7mR0aW2CCqniPDnYi4v5h66oZtozcdk/2MA
         UfOCYnUDad8wFAVDNzdPwwOtiKz1gY0PatMctJFCFjfspjoJsQG3klX21Ki4N70lsxJj
         Xt7w==
X-Gm-Message-State: AAQBX9eyWU2W/ZyLUWydfPhFv/7x7CE7nb5SBoSNPpV5obwmEsJqLDDw
        RbhSe1dRuh4cAJUYbVjw4A6RK5PTqRv6yXRws9WALUB7zn06bCi8qg3Sb5a55XAJxAQUJNmwBoM
        nQaIY50eG9BN75UIYxGsBxG3SBc4sdsGf5aQKW6OrtPPWGQ==
X-Received: by 2002:a5d:4949:0:b0:2ef:b977:ee3a with SMTP id r9-20020a5d4949000000b002efb977ee3amr3214591wrs.34.1681452904876;
        Thu, 13 Apr 2023 23:15:04 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZMWU0obXURDtM8C4VH2fQ+FRH6qv3QJQSMmxiEYCANgKRxwrF1qmRXzaL3awQ3sa15QW1Pzg==
X-Received: by 2002:a5d:4949:0:b0:2ef:b977:ee3a with SMTP id r9-20020a5d4949000000b002efb977ee3amr3214570wrs.34.1681452904560;
        Thu, 13 Apr 2023 23:15:04 -0700 (PDT)
Received: from localhost (uk.sesame.canonical.com. [185.125.190.60])
        by smtp.gmail.com with ESMTPSA id x17-20020a5d4911000000b002e55cc69169sm2794289wrq.38.2023.04.13.23.15.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Apr 2023 23:15:04 -0700 (PDT)
Date:   Fri, 14 Apr 2023 08:15:03 +0200
From:   Andrea Righi <andrea.righi@canonical.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
        Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>,
        Shuah Khan <shuah@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Paolo Pisati <paolo.pisati@canonical.com>,
        bpf <bpf@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        clang-built-linux <llvm@lists.linux.dev>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] selftests/bpf: ignore pointer types check with clang
Message-ID: <ZDjvZ7mx7+IsSCCO@righiandr-XPS-13-7390>
References: <20230412095912.188453-1-andrea.righi@canonical.com>
 <CAADnVQJ00Npkp=+XYaTybzaPnrcfK0nKrePAktVNBt2-YqWdEg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQJ00Npkp=+XYaTybzaPnrcfK0nKrePAktVNBt2-YqWdEg@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Apr 13, 2023 at 09:56:00PM -0700, Alexei Starovoitov wrote:
> On Wed, Apr 12, 2023 at 2:59 AM Andrea Righi <andrea.righi@canonical.com> wrote:
> >
> > Building bpf selftests with clang can trigger errors like the following:
> >
> >   CLNG-BPF [test_maps] bpf_iter_netlink.bpf.o
> > progs/bpf_iter_netlink.c:32:4: error: incompatible pointer types assigning to 'struct sock *' from 'struct sock___17 *' [-Werror,-Wincompatible-pointer-types]
> >         s = &nlk->sk;
> >           ^ ~~~~~~~~
> > 1 error generated.
> 
> I cannot reproduce this and BPF CI doesn't complain about it either.
> What kind of clang do you use?
> Some special version and build flags?

I'm using Ubuntu clang version 15.0.7 (Ubuntu 23.04), no special build
flag (unless Ubuntu enables some different default flags, but it
shouldn't be the case... I'll double check).

-Andrea
