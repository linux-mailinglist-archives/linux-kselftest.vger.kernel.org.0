Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9D5A57BCBC
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Jul 2022 19:36:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234679AbiGTRgS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 20 Jul 2022 13:36:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241042AbiGTRgJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 20 Jul 2022 13:36:09 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA76DDEE2
        for <linux-kselftest@vger.kernel.org>; Wed, 20 Jul 2022 10:36:06 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id bu1so27122474wrb.9
        for <linux-kselftest@vger.kernel.org>; Wed, 20 Jul 2022 10:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=02lsKOmjymw0+voRSiZssITm3QnQDwCZm++EAm96eVk=;
        b=AXz4zLK1VM061H4lcJHGjYLvRNfx+YUTCIfw8oq3KgqGXfJomypHgHt+ZjUVjSpkw7
         ygfdWOTJN6EKqQPYnyG97Yc9pSYo4apVrs685dRj2Lis1r313+yLrAE4zAnyES49TN3Q
         lNcDBCtRLJFxz8TyiWl0yMv1RoxKjDusQIC6P579ng+zMKgK2gaZPeAdN3puFuuwlnS7
         HKHcJLtVxhvMvaIqoeeHrzwsR8KA6ih1ZB56OPQc98CikP+vqXQgFD/VuEH63RuvK/sa
         8WBl+IeOZ4d3hEpU00LbcHvGxvYwKYjFAuzwqdsEXJFfTblyeJv0cGW13ou6DV33hOXv
         Sw4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=02lsKOmjymw0+voRSiZssITm3QnQDwCZm++EAm96eVk=;
        b=oauMm/sbqt7rF1fVdVlnXex+zzACG9t+sNb3hOm31M4sZJ8WUsCQTFN5WpiCpBCLvb
         ew1tP0SEBnVyoVLUFJtroqcpg83122G9beqiFEVjuGNInBPfqMwpjEX/PGRHFYF3HSNe
         fBmCQ6RMoCGUVDdHR4gc7NmEMR+gWaP/KO0SN79t38bpYsHa82trIbURtlpaOIFEisZK
         2OVEdIZjd/rX4MgIW8OjaAt1Z3tMstjSUD+I/QLPq/vfaYDtEuzsWluRehd8bnKUkjOT
         Uj8u+r6zeqJJJ+oJaVHEt/Mx+4pmiRi8lraNHw5YUVTYIi67vstxJjR7YCr7HDlcrsGI
         xM+A==
X-Gm-Message-State: AJIora8ifNeLXhY7GdADONV3PuH9hV5bR4v7cfATSuz27C5Gg2z6RPje
        gGVz5+DUGIt2jhBFPcbNhQ7LMHaHKTjsGrchX+EZhw==
X-Google-Smtp-Source: AGRyM1sVDW8tYnXZDH5GAJtfDD0oKvvEaaIMt0UCdQWhpZMJt6LRZI0HjOnjkG0MNPv2hBnm38VQ0JCEOp4f1ZPH0dQ=
X-Received: by 2002:a05:6000:156f:b0:21d:887f:8ddf with SMTP id
 15-20020a056000156f00b0021d887f8ddfmr31271381wrz.534.1658338565332; Wed, 20
 Jul 2022 10:36:05 -0700 (PDT)
MIME-Version: 1.0
References: <YtZ9Yu6HSQ2sT+O/@kili> <CAJD7tkYCSY1C_iif4dxF9O3dAgZV4u8o9DFGsqeTyaq_FTT+mQ@mail.gmail.com>
 <20220720092918.GD2316@kadam>
In-Reply-To: <20220720092918.GD2316@kadam>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Wed, 20 Jul 2022 10:35:29 -0700
Message-ID: <CAJD7tkYV60TkgfL2NF2HspJ_j+MB4CuqKNzugrAZ9jtfhicmog@mail.gmail.com>
Subject: Re: [PATCH] selftests: memcg: uninitialized variable in test_memcg_reclaim()
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Shuah Khan <shuah@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Cgroups <cgroups@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>,
        linux-kselftest@vger.kernel.org, kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
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

On Wed, Jul 20, 2022 at 2:29 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> On Tue, Jul 19, 2022 at 10:27:36AM -0700, Yosry Ahmed wrote:
> >
> > Nit: keep the cleanup_* naming for labels to make it obvious and to be
> > consistent with the rest of the file (e.g. cleanup_free,
> > cleanup_memcg, cleanup_file/cleanup_all). See
> > test_memcg_subtree_control().
> >
> > I would honestly have one label to cleanup the memcg. Calling
> > cg_destroy() on a non-existent memcg should be fine. rmdir() will just
> > fail silently. All other tests do this and it's easier to read when we
> > have fewer return paths. My advice would be cleanup_file and
> > cleanup_memcg labels.
>
> One error label handling is very bug prone.  You always end up freeing
> things which have not been initialized/allocated.  Or dereferencing
> pointers which are NULL.  Or, since most kernel functions clean up
> after themselves, you end up double freeing things.

I am not suggesting a single cleanup label, I said "one label to
cleanup the memcg", which is separate from cleaning up the file.
Basically just merging the destroy_memcg and free_memcg labels to be
consistent with other tests. I don't feel strongly about this anyway
:)

>
> regards,
> dan carpenter
