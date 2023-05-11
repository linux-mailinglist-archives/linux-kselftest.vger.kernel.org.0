Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D2726FFBA9
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 May 2023 23:06:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238502AbjEKVGd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 11 May 2023 17:06:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239256AbjEKVGZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 11 May 2023 17:06:25 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE85A8A54
        for <linux-kselftest@vger.kernel.org>; Thu, 11 May 2023 14:06:03 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id af79cd13be357-7577ef2fa31so1619642985a.0
        for <linux-kselftest@vger.kernel.org>; Thu, 11 May 2023 14:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683839159; x=1686431159;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vCeq2xThlfZB3ptEpDOPv6geRdVGsuZ5n1puK00a7nI=;
        b=iEn7QA6soRHK+uXK3n4TqBcQlPoJaEX2jYbpTglsAhODvMazuXOFhfxfFwkiYGSmF1
         4bSBY1X9T+/L3ZH0Lve9uA91vW5G+q7lshvyEPyUI0B3bXviFnkMtjrYkHT/rNm1qh5F
         SZ6NU5/fWdIptlm7rZanFIuCaOI5efRp9kPDdP/WYTWTLe3yDNZbwUt0nJYXDr5d8HET
         FVdt8UNAKbRx6YwHMl2l4ZXa72qwyEiMduWdZCy/T0UigM//K/4b+KFG7c1UVBV84pKX
         GyZ1aH2R4CSXlr5lc+HBuHSLNI/4o9Ioy+qKnwdnAXER5sh5ZcKeCUThHS6BrxrVQTfl
         OejQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683839159; x=1686431159;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vCeq2xThlfZB3ptEpDOPv6geRdVGsuZ5n1puK00a7nI=;
        b=VKTPFFeLpAEm0qmF7EDcI3wGkBo3MF+uIfTzpxatd/QP794wr8NRJbD1nIx5xd5kNd
         aENcTByBWFJlZIaFo9+PCwK+1fcUsu+B0VmpZUkSfC4mmLbm90IQFvUq1JxvpyLBkBHB
         vly1ZRVjKhA6MSeKcD5AJ6wBWL+AxcgYQONSGUop1aYnsq7SFYhRZ1EKY0/XVpNjrhBt
         r+1twArELe4/iwBL1JHUHy1t6s7v10G+J8QMzcNEXFnWqATL7JJM41J5go77qsLP6N8H
         HWjJcB0O+eYIvxO4Jb9ikdSGFQTXlbvMapmapXNTif4UYGKDgNhZXKC3HNCb+f7OW8Ef
         Tfzw==
X-Gm-Message-State: AC+VfDzgtK7gmqoIhE1G7Uw4N0TK+bmON4x8X5pz2GFh4kzjgHqH0Ws1
        Q3bwNkCo5tPmKkqqEyV6s+5AAcHOLiq81c6EoetsXA==
X-Google-Smtp-Source: ACHHUZ6UOjBrmUdJjmc06SN4JEYsOAg4+qNDvJ7BZtuEAjoG8Ew4RgRjSuY6SvfemUya16xKcm0YOKF6TQd/gjyvVBM=
X-Received: by 2002:a05:6214:408:b0:5dd:b986:b44 with SMTP id
 z8-20020a056214040800b005ddb9860b44mr42769277qvx.6.1683839158749; Thu, 11 May
 2023 14:05:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230511182426.1898675-1-axelrasmussen@google.com>
 <20230511202243.GA5466@monkey> <CAJHvVcg+Sm-=F=Xhi-WVLRxDcDcYzD8AwLpHHoP8zLubOoX6TQ@mail.gmail.com>
In-Reply-To: <CAJHvVcg+Sm-=F=Xhi-WVLRxDcDcYzD8AwLpHHoP8zLubOoX6TQ@mail.gmail.com>
From:   Axel Rasmussen <axelrasmussen@google.com>
Date:   Thu, 11 May 2023 14:05:23 -0700
Message-ID: <CAJHvVcgkQK+YpWhpmHzjBGFUbHLLSoaq9jHfzCH052OEZAWs5w@mail.gmail.com>
Subject: Re: [PATCH 1/3] mm: userfaultfd: add new UFFDIO_SIGBUS ioctl
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <brauner@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Hongchen Zhang <zhanghongchen@loongson.cn>,
        Huang Ying <ying.huang@intel.com>,
        James Houghton <jthoughton@google.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        "Mike Rapoport (IBM)" <rppt@kernel.org>,
        Nadav Amit <namit@vmware.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Peter Xu <peterx@redhat.com>, Shuah Khan <shuah@kernel.org>,
        ZhangPeng <zhangpeng362@huawei.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        Jiaqi Yan <jiaqiyan@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, May 11, 2023 at 1:40=E2=80=AFPM Axel Rasmussen <axelrasmussen@googl=
e.com> wrote:
>
> On Thu, May 11, 2023 at 1:29=E2=80=AFPM Mike Kravetz <mike.kravetz@oracle=
.com> wrote:
> >
> > On 05/11/23 11:24, Axel Rasmussen wrote:

Apologies for the noise, I should have CC'ed +Jiaqi on this series
too, since he is working on other parts of the memory poisoning /
recovery stuff internally.

> > > The basic idea here is to "simulate" memory poisoning for VMs. A VM
> > > running on some host might encounter a memory error, after which some
> > > page(s) are poisoned (i.e., future accesses SIGBUS). They expect that
> > > once poisoned, pages can never become "un-poisoned". So, when we live
> > > migrate the VM, we need to preserve the poisoned status of these page=
s.
> > >
> > > When live migrating, we try to get the guest running on its new host =
as
> > > quickly as possible. So, we start it running before all memory has be=
en
> > > copied, and before we're certain which pages should be poisoned or no=
t.
> > >
> > > So the basic way to use this new feature is:
> > >
> > > - On the new host, the guest's memory is registered with userfaultfd,=
 in
> > >   either MISSING or MINOR mode (doesn't really matter for this purpos=
e).
> > > - On any first access, we get a userfaultfd event. At this point we c=
an
> > >   communicate with the old host to find out if the page was poisoned.
> >
> > Just curious, what is this communication channel with the old host?
>
> James can probably describe it in more detail / more correctly than I
> can. My (possibly wrong :) ) understanding is:
>
> On the source machine we maintain a bitmap indicating which pages are
> clean or dirty (meaning, modified after the initial "precopy" of
> memory to the target machine) or poisoned. Eventually the entire
> bitmap is sent to the target machine, but this takes some time (maybe
> seconds on large machines). After this point though we have all the
> information we need, we no longer need to communicate with the source
> to find out the status of pages (although there may still be some
> memory contents to finish copying over).
>
> In the meantime, I think the target machine can also ask the source
> machine about the status of individual pages (for quick on-demand
> paging).
>
> As for the underlying mechanism, it's an internal protocol but the
> publicly-available thing it's most similar to is probably gRPC [1]. At
> a really basic level, we send binary serialized protocol buffers [2]
> over the network in a request / response fashion.
>
> [1] https://grpc.io/
> [2] https://protobuf.dev/
>
> > --
> > Mike Kravetz
> >
> > > - If so, we can respond with a UFFDIO_SIGBUS - this places a swap mar=
ker
> > >   so any future accesses will SIGBUS. Because the pte is now "present=
",
> > >   future accesses won't generate more userfaultfd events, they'll jus=
t
> > >   SIGBUS directly.
> > >
> > > UFFDIO_SIGBUS does not handle unmapping previously-present PTEs. This
> > > isn't needed, because during live migration we want to intercept
> > > all accesses with userfaultfd (not just writes, so WP mode isn't usef=
ul
> > > for this). So whether minor or missing mode is being used (or both), =
the
> > > PTE won't be present in any case, so handling that case isn't needed.
> > >
