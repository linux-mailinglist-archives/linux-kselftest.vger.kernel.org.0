Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C31577FED3
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Aug 2023 22:03:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351314AbjHQUC2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 17 Aug 2023 16:02:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354709AbjHQUCZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 17 Aug 2023 16:02:25 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCA75359C
        for <linux-kselftest@vger.kernel.org>; Thu, 17 Aug 2023 13:02:21 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id d75a77b69052e-4036bd4fff1so75991cf.0
        for <linux-kselftest@vger.kernel.org>; Thu, 17 Aug 2023 13:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692302541; x=1692907341;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZFt42+2gL2zS27EyJiumcQJzSPb9Kj8mX4pG71zx5cw=;
        b=JeEPJFThFtK7b6jYwe7zK72koT1k9KkeHpiFPJ1aRPzOL9oY6vKDr3BSOZoLEbtizJ
         Faulh/e/+MOgduHk0RrucQCigvVUys2uGZPsgkaKG7ggxeQ2Q6SIbiE3UFC0X5LSz6DR
         /3uvEDap0anA8Ibix8KixmMZl4KuKYTvn6avYKILdWvbhZPBnESwBXLjiqrS73/4uy6t
         4hqy8HdMOqKjbYhf+EbLjT1wqvs+yOGIJ6tXWJNOOG47x9iNH49Z1H7EhySv84DVy5hw
         JwShuWqZmI4uoPbF/i06RvThRAfJKnhDyoIORcVFFVDmMtjOruBuLioebzarH/PG9U4I
         ZWdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692302541; x=1692907341;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZFt42+2gL2zS27EyJiumcQJzSPb9Kj8mX4pG71zx5cw=;
        b=ilXvRNZ3GqPJbaaJPfQbyQOpj10JT2avNzEMVpODScE7EmQtcbp30KyuveDwPa43hE
         64STDKV6JJ03hWGaFUNONfRLJvnY8Ajx2TFooIwwV3YWmxD0LPEkfnfcyLmdvKKBXqKW
         4wJ3bjX+ozFPnSmxuDVwxFtQBYPPrzmoIepuw9PbvtJiPSc3kFusPqGx7FY4q4zcOjBN
         /dZlpCaWiv8Ai9S1TmTFn9n+GYv4xh6HLqobCCXCSkPLx4Cq77RE08E9oNMUJBnZi52Z
         rr5hXTwISfBd7lQq0EoBbFRErY0hQDQITBa4pSBwXtYxnPJPbSFWxG0paf3f+2kcZQAN
         niUg==
X-Gm-Message-State: AOJu0YzG0gZlf6tIcCSu11WAL/dKRiTf3HHbZ7S/E1eakrKD+nvCm8PD
        rGxBJpZ8l/TIGcjJPp1ByJbfiNC5BjytCXQZ3Tggkw==
X-Google-Smtp-Source: AGHT+IFKVDsEm40DpNxOCwSLvwnLvwZxtsNsrzNj7h+GuWaQru6FfNFZY2mW5my5vxT5y/BgsxrAAmWifVAAfGYJwNQ=
X-Received: by 2002:ac8:7dd0:0:b0:403:eeb9:a76 with SMTP id
 c16-20020ac87dd0000000b00403eeb90a76mr6835qte.17.1692302540780; Thu, 17 Aug
 2023 13:02:20 -0700 (PDT)
MIME-Version: 1.0
References: <bvrhe2tpsts2azaroq4ubp2slawmop6orndsswrewuscw3ugvk@kmemmrttsnc7>
In-Reply-To: <bvrhe2tpsts2azaroq4ubp2slawmop6orndsswrewuscw3ugvk@kmemmrttsnc7>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Thu, 17 Aug 2023 13:02:08 -0700
Message-ID: <CALvZod4C7+q+wF6UYRq5Ud75o8PevUExHVs_kFZ9sDbzQbqM3A@mail.gmail.com>
Subject: Re: [PATCH v3] selftests: cgroup: fix test_kmem_memcg_deletion kernel
 mem check
To:     Lucas Karpinski <lkarpins@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <muchun.song@linux.dev>, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Shuah Khan <shuah@kernel.org>, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Aug 17, 2023 at 12:58=E2=80=AFPM Lucas Karpinski <lkarpins@redhat.c=
om> wrote:
>
> Currently, not all kernel memory usage is being accounted for. This
> commit switches to using the kernel entry within memory.stat which
> already includes kernel_stack, pagetables, and slab. The kernel entry
> also includes vmalloc and other additional kernel memory use cases which
> were missing.
>
> Signed-off-by: Lucas Karpinski <lkarpins@redhat.com>

Acked-by: Shakeel Butt <shakeelb@google.com>
