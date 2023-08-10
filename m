Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BCE67781A6
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Aug 2023 21:31:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236308AbjHJTbM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 10 Aug 2023 15:31:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236638AbjHJTa6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 10 Aug 2023 15:30:58 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D287A2737
        for <linux-kselftest@vger.kernel.org>; Thu, 10 Aug 2023 12:30:57 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id d75a77b69052e-40a47e8e38dso66021cf.1
        for <linux-kselftest@vger.kernel.org>; Thu, 10 Aug 2023 12:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691695857; x=1692300657;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qTpLyvzgH53OBSjK9r16H8W2zoDKFMFaOweQykQ1i2Q=;
        b=Jd0onYPoMWrLrJcrl+4baJAMA3fFU3mzHVw40Z6XLVS7IZN3kxUORnmw8qqBm3Nd+6
         fZjg04ErCqQyY/qrv6N8ZaHCGRRayDj4p1fXFrMOC0dsVL/PwVKGYHUEggzqYiZT63Gl
         bPaWhSbLfLPDtXBCrr4MqOdwpdSzsNiIXHVtUTvJMFa7Rem12Q6+Sq7uBND2sLjrIW2Z
         kTn9xV4prZ8ZHTWB+Nk0T+X/VLNx37bD0ZqsuBEPSf3XIb/Tq2YR7+xc/EfBHilIzZ7M
         6+RCZ6pK1klHm4jzz7k8oYwnF77tphhLyVD2HiT6GHVun7qkQdC9NXdEoU83SJauLCuy
         3AEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691695857; x=1692300657;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qTpLyvzgH53OBSjK9r16H8W2zoDKFMFaOweQykQ1i2Q=;
        b=RgZsjxBIRf3aNqPULmYAK7D5fLE9bnASKxMw4cePAvCwDQM80hd4/yhOt9Pz0Nu7UL
         5n93b6Qfi3piLSl9zQhKx/PZQDXHk+407EhAxr+q9N9Pq0ZzrBE8nHXodf1j+B8fM7zt
         YrDjGcuHjoDvyfJ+XLwaVhh27oPlNUOodqHiKERcY5BsceROQtsnOgV/ydjdvTEUOxsI
         GaOJvmKe+iAI4Td2xuM3fywyIcMjJeQbY/dIYFiHBq7tJyDxh1nJQlZMprKi6WQVuYBO
         d/ihROFOlpj3TJwaQ6p6Ybzukz1HnZRD9kWwK5+gzq+Kw52pg5WjqTdi/4FFMnrmFY8k
         LaxQ==
X-Gm-Message-State: AOJu0YzX3uhcuOJNI1BOr+AAlU0133ShRDO6Qjui9RHhBHl6CnRROEhI
        Mgyzas8/XCS4IcPErOeyaCwvJdE+h3kI7irUn6PEWg==
X-Google-Smtp-Source: AGHT+IFQwyV5vdBv3g4FI28KH2jTSacKQzB1wU2GpBf9QmLIuqeNpbksGrg9tW/xVtlmoiYoWmSC53nQVRaK/P4Z1Jg=
X-Received: by 2002:a05:622a:282:b0:3f8:5b2:aef2 with SMTP id
 z2-20020a05622a028200b003f805b2aef2mr51442qtw.26.1691695856840; Thu, 10 Aug
 2023 12:30:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230810192128.1855570-1-axelrasmussen@google.com>
In-Reply-To: <20230810192128.1855570-1-axelrasmussen@google.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Thu, 10 Aug 2023 13:30:20 -0600
Message-ID: <CAOUHufbPN2Zh53-YOJo8r+sRuXMt4Oav1Py6wWJgGA3aWRNvfQ@mail.gmail.com>
Subject: Re: [PATCH mm-unstable fix] mm: userfaultfd: check for start + len
 overflow in validate_range: fix
To:     Axel Rasmussen <axelrasmussen@google.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Brian Geffon <bgeffon@google.com>,
        Christian Brauner <brauner@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Gaosheng Cui <cuigaosheng1@huawei.com>,
        Huang Ying <ying.huang@intel.com>,
        Hugh Dickins <hughd@google.com>,
        James Houghton <jthoughton@google.com>,
        Jiaqi Yan <jiaqiyan@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        "Mike Rapoport (IBM)" <rppt@kernel.org>,
        Muchun Song <muchun.song@linux.dev>,
        Nadav Amit <namit@vmware.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Peter Xu <peterx@redhat.com>,
        Ryan Roberts <ryan.roberts@arm.com>,
        Shuah Khan <shuah@kernel.org>,
        Steven Barrett <steven@liquorix.net>,
        Suleiman Souhlal <suleiman@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        "T.J. Alumbaugh" <talumbau@google.com>,
        ZhangPeng <zhangpeng362@huawei.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Aug 10, 2023 at 1:21=E2=80=AFPM Axel Rasmussen <axelrasmussen@googl=
e.com> wrote:
>
> A previous fixup to this commit fixed one issue, but introduced another:
> we're now overly strict when validating the src address for UFFDIO_COPY.
>
> Most of the validation in validate_range is useful to apply to src as
> well as dst, but page alignment is only a requirement for dst, not src.
> So, split the function up so src can use an "unaligned" variant, while
> still allowing us to share the majority of the code between the
> different cases.
>
> Reported-by: Ryan Roberts <ryan.roberts@arm.com>
> Closes: https://lore.kernel.org/linux-mm/8fbb5965-28f7-4e9a-ac04-1406ed8f=
c2d4@arm.com/T/#t
> Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>

Reviewed-by:  Yu Zhao <yuzhao@google.com>
