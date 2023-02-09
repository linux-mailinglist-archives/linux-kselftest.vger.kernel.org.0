Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BF42690F83
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Feb 2023 18:48:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbjBIRsW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 9 Feb 2023 12:48:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbjBIRsV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 9 Feb 2023 12:48:21 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BE4D61B7
        for <linux-kselftest@vger.kernel.org>; Thu,  9 Feb 2023 09:48:20 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id o13so2822232pjg.2
        for <linux-kselftest@vger.kernel.org>; Thu, 09 Feb 2023 09:48:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=A7Fh9muBzjV/jBPZf9ed/gD/2z8b4VTj2N9ywQ7oXIE=;
        b=hwOPnENsSTD1u7F/uN5KoqfQltMbhwaSs+OkwQg79Dc4fjX99RGerO4UFthenfYkKs
         6FpKKnxFxQUoRynTJwF/qeh7UHDDQkZ235XiNRPYxKqtPCTN1hpLh0ORFcc27KauEwpN
         vt8kUG9LcoB5X2Vtuov+VvBiW6PaaTflH1wP4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A7Fh9muBzjV/jBPZf9ed/gD/2z8b4VTj2N9ywQ7oXIE=;
        b=ZbDPyhN8zmz6GBPqeQwM53vabC4aKI1pBSpbHTVsdLyl4Y1e2FMXhCZCdmCYiuSMqK
         Rrii+oq5Szc7eAIKt1zk8fzGfEkQ5aR56nwxipnLeV8PYck2ExLB+ksLGS4HYYki3zp1
         I54sAk6TPlmsUeugCf/YbkWTN7ztsFhBpuCn9HvJ/YDbJRs9f7tbXkU1Cg/JgHLzBji3
         hLAlr+ElV4JcY6vPpHj7Bn6VLZKGfierfANcX1GJtkR+GoODDXkP1Q4yGeFlU/xrL/UT
         6z2deBepuPEcsJG9TzYbjwMH3l6EVQST5RtANQ2YHbFl+P7Xz2eE8XOmAUpK/rXQpOct
         W+gg==
X-Gm-Message-State: AO0yUKUkqafiMOXATRH5GIrWsdbouUaaU3PIdT70IoLxebc440wRDCA5
        6d414IiVncuKkgoTQmTG1yDvCw==
X-Google-Smtp-Source: AK7set+vuTEpMUx524NdAoDq88GxFvcwbLo4pMMZw0NedqVHgpCM2khPDUn1V5m4Ngkb0Yhffnx97Q==
X-Received: by 2002:a17:903:2344:b0:196:5d8d:2d6f with SMTP id c4-20020a170903234400b001965d8d2d6fmr13527570plh.13.1675964900125;
        Thu, 09 Feb 2023 09:48:20 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id je5-20020a170903264500b00192fc9e8552sm1824914plb.0.2023.02.09.09.48.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Feb 2023 09:48:19 -0800 (PST)
Message-ID: <63e531e3.170a0220.3a46a.3262@mx.google.com>
X-Google-Original-Message-ID: <202302090900.@keescook>
Date:   Thu, 9 Feb 2023 09:48:18 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Stanislav Fomichev <sdf@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
        Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>,
        Shuah Khan <shuah@kernel.org>,
        Haowen Bai <baihaowen@meizu.com>, bpf <bpf@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] bpf: Replace bpf_lpm_trie_key 0-length array with
 flexible array
References: <20230204183241.never.481-kees@kernel.org>
 <CAKH8qBvqLeR3Wsbpb-v=EUY=Bw0jCP2OAaBn4tOqGmA1AqBZbA@mail.gmail.com>
 <63e14abb.170a0220.ca425.b7bc@mx.google.com>
 <CAKH8qBtX0HU4_YtnZ3hU4NhGHSQ9VU70niXFFoqf3k67a1+6aA@mail.gmail.com>
 <63e5210b.630a0220.c17be.27ff@mx.google.com>
 <CAADnVQK-sW51SsC7FYDqLaO8c5xj=MAgcu_6p8L-JN9kAsrzeA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADnVQK-sW51SsC7FYDqLaO8c5xj=MAgcu_6p8L-JN9kAsrzeA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Feb 09, 2023 at 08:55:23AM -0800, Alexei Starovoitov wrote:
> On Thu, Feb 9, 2023 at 8:36 AM Kees Cook <keescook@chromium.org> wrote:
> > This approach is, perhaps, the best way to go? Besides the selftest,
> > what things in userspace consumes struct bpf_lpm_trie_key?
> 
> Plenty of bpf progs use it:
> https://github.com/cilium/cilium/blob/master/bpf/lib/common.h#L352

Thanks for the pointer! Yeah, it seems the "data" member is not
directly used, but is expected to be there for static initializers and
offsetof() use. For example:

cilium:
        struct egress_gw_policy_key in_key = {
                .lpm_key = { 32 + 24, {} },
                .saddr   = CLIENT_IP,
                .daddr   = EXTERNAL_SVC_IP & 0Xffffff,
        };

systemd:
	ipv6_map_fd = bpf_map_new(
			BPF_MAP_TYPE_LPM_TRIE,
			offsetof(struct bpf_lpm_trie_key, data) + sizeof(uint32_t)*4,
			sizeof(uint64_t),
			...

All the others searches in Debian I could find were just copies of UAPI
headers:
https://codesearch.debian.net/search?q=struct+bpf_lpm_trie_key&literal=1&perpkg=1

-- 
Kees Cook
