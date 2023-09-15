Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 919067A1461
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Sep 2023 05:28:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231838AbjIOD2o (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 14 Sep 2023 23:28:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231571AbjIOD2m (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 14 Sep 2023 23:28:42 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7978E2713
        for <linux-kselftest@vger.kernel.org>; Thu, 14 Sep 2023 20:28:38 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id 3f1490d57ef6-d7ecdb99b7aso1663701276.3
        for <linux-kselftest@vger.kernel.org>; Thu, 14 Sep 2023 20:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694748517; x=1695353317; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aoetoUv4yUreIuSjYjk1T1X4tYlTD7mzIQaWPL4/I1g=;
        b=LsHOs+L8jiC9Z7LivNq0q5mi4FjZVq6K3J46xIrCsUXPTNaWKAvQiB/iHJ87HFT4Xz
         Bz/O7ILiGzNRROlV0YQjwi1He9JK1wbU6tkdwmwuHfTSEoIauqtV3G/ySx0jvtg2z6RS
         xKrL29x9A/tLxBnmOvKuAo3HmWIwHmYWqLFzR3nadjWVBmD1G8GpLrXz/cE60eoLO0n3
         kNa1EpHw4PBp5iDkcNLDvzm4DyMfLR9PWryAQhnXKykFAF7d5ca8pOO1ZtLG1LVBSXdl
         pYEXfgQr9OT3CJeFf5/zxeqV5NtutXAdICPTZ79mZbcDvWvy72KRYhHUL+L0vf/Br8a6
         r+pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694748517; x=1695353317;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aoetoUv4yUreIuSjYjk1T1X4tYlTD7mzIQaWPL4/I1g=;
        b=ua9O/ymQ5asgC0HZq/p2S5BP6fQMXRHrolLe/M5o8wo0e9zytYhwkYqvA4eg52exkM
         hV7H7YCxw9zEPurmA17hSP8rRPbfVgfwZuXSlwlRwlR6yBE10GyU/FiWGXg68c4qb67q
         xuXLJQsNqqa1hkH8DXKltMGIiEW4q+MWZ0SwR8xQ4JgsVjcjWpP4ssf3HXncdadJz3pR
         8e4KxhToskpZbuZ/TbQhfSFgpZc0ojhA+xJcLWQFjXOcqTJn8PJCIhmCPH8tQU8j+rFu
         vaKuZgrjikD5Y84rddzqFK23vVJ5CPCFCWiFckUsE4bg5jW4xsTCFE6c782M+JAXPCoM
         c4BQ==
X-Gm-Message-State: AOJu0YxMN0+e2SzSDwXBCFwX5Z8Tx3n9kRGIpXG7wOyuQL8hffuGk2hL
        RUdSyFIkYzfoTv8k4AW+kE6+tIbfhDzV8jtYct+ezg==
X-Google-Smtp-Source: AGHT+IE123J0ofC5tc7ux3uXbJpHdEduMMUnQ/jGJh8rlWi51MUY0HINvHjs43GbwySqu/kz9rZWjoPEa9FIqeMVCR0=
X-Received: by 2002:a25:5c9:0:b0:d81:5436:9896 with SMTP id
 192-20020a2505c9000000b00d8154369896mr384787ybf.2.1694748517385; Thu, 14 Sep
 2023 20:28:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230914152620.2743033-1-surenb@google.com> <20230914152620.2743033-3-surenb@google.com>
 <4F9BBE45-22D0-4F8D-BA56-CA3459998DC4@gmail.com>
In-Reply-To: <4F9BBE45-22D0-4F8D-BA56-CA3459998DC4@gmail.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Thu, 14 Sep 2023 20:28:23 -0700
Message-ID: <CAJuCfpGWkzDUL4+9evD-Kx5uGoc+=g808CXtc1hrSUdCRMtRgA@mail.gmail.com>
Subject: Re: [PATCH 2/3] userfaultfd: UFFDIO_REMAP uABI
To:     Nadav Amit <nadav.amit@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, viro@zeniv.linux.org.uk,
        brauner@kernel.org, shuah@kernel.org,
        Andrea Arcangeli <aarcange@redhat.com>, lokeshgidra@google.com,
        Peter Xu <peterx@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Hugh Dickins <hughd@google.com>, mhocko@suse.com,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mike Rapoport <rppt@kernel.org>,
        Matthew Wilcox <willy@infradead.org>, Liam.Howlett@oracle.com,
        Jann Horn <jannh@google.com>, zhangpeng362@huawei.com,
        bgeffon@google.com, kaleshsingh@google.com, ngeoffray@google.com,
        jdduke@google.com, linux-mm <linux-mm@kvack.org>,
        linux-fsdevel@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Sep 14, 2023 at 2:57=E2=80=AFPM Nadav Amit <nadav.amit@gmail.com> w=
rote:
>
>
> > On Sep 14, 2023, at 8:26 AM, Suren Baghdasaryan <surenb@google.com> wro=
te:
> >
> > +     if (!pte_same(ptep_clear_flush(src_vma, src_addr, src_pte),
> > +             orig_src_pte))
> > +             BUG_ON(1);
>
> Just a minor detail regarding these few lines:
>
> Besides the less-than-ideal use of BUG_ON() here, I think that this code
> assumes that the PTE cannot change at this point. However, as the PTE was
> still mapped at this point, I think the access and dirty bits can be set.

At this point we are holding PTLs for both PTEs (see
double_pt_lock()).  Can a PTE be modified from under us in this
situation?

>
> tl;dr: this appears to be triggerable by userspace.
>
> [ as for the performance of this code, the lack of batching would mean
>   that for multithreaded applications where more than a single page is
>   remapped, performance would suffer ]

Thanks for the note! I'll see if it's possible to implement some
batching mechanism here.
Thanks,
Suren.
