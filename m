Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36E196A100E
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Feb 2023 20:04:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbjBWTEj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 23 Feb 2023 14:04:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbjBWTEi (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 23 Feb 2023 14:04:38 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC61D311DF
        for <linux-kselftest@vger.kernel.org>; Thu, 23 Feb 2023 11:04:36 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id e24so5591373ljj.3
        for <linux-kselftest@vger.kernel.org>; Thu, 23 Feb 2023 11:04:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gX7QhWX8iQivKPSPekH4AH3P6f8FH7Ng/txrWhsq3BI=;
        b=rryl29Z+VPN0/H7Xx2tRtQhAtWz+1bWdopkxj7YsNgAfMDH6XoykE2VF/qJrPvoQZ4
         wMaL75cdyFi4FlzTMfr5HMRkv1/WwyvWpShSRUkUqYRxAq6oW4JI38zpKMK5C7QUpCNv
         j2oLuOYmQU9htXpps+UCrDAEoxMzFD3jSf8RQREUl94z4DqMuPeij1KWClWB60QwDD3w
         PXFIHhmiwpIpN1oAQqZ8ldYUVsLTO2Yk9gJx5ORzahZ1fHhA+uNrDBk5a4l05PBanIOJ
         YGlNwKL073WNmbFWhZ7gxtPAG6fdzLEoNaaPHjTzmSS5EyOeGaorKpiFagra5jwCSpnj
         hY8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gX7QhWX8iQivKPSPekH4AH3P6f8FH7Ng/txrWhsq3BI=;
        b=PewwJtb7OwLEmNDVoX7j3fqH8k6PrI/rjREL9FCDMntNg15ToHrIJNUZ1GWRDmgjE6
         PkeYw9x7fwcXKL9j7tVgXxhBng9NqXQ+TwZI0OxfmQ89gnhIVtXPSExbGu/QWl+qsT/p
         V03yxEcynQogadG6UIBRfOTP0aAcFWE54tR6fX49sh5/e5YBEA32n5zFNB35IaKAwdQp
         WOsMfXhRvjgJM/PVU9ih77tcrGmORRZZKCKlfwdEguted+nbneNk1VkRLaornpnvRVLg
         dq+TnQ42BzRp4QtypM5Wa/Tz4esbQBqNdVG52t2PKAHHzrb4aHMZaLsH2ymzTR0+67/j
         Pong==
X-Gm-Message-State: AO0yUKVkXHCBPdMpHqziFdWdQ/G+dRZCKz4NRgXB8VBxvTlrwk8PzorP
        UcwUNU3n6/KEKzb/49qIy8n/EimtlvwaLYWPdg2NAg==
X-Google-Smtp-Source: AK7set/5wjxRhOgUKDeWCKEsXZ58YkdXG/NZo9H3PQT6/dkYtyZwIuorwOkoEgM0jcsygHkOtz30w9CMZYXtRMP7b/I=
X-Received: by 2002:a2e:aa1c:0:b0:293:4ed3:a404 with SMTP id
 bf28-20020a2eaa1c000000b002934ed3a404mr3984302ljb.2.1677179074637; Thu, 23
 Feb 2023 11:04:34 -0800 (PST)
MIME-Version: 1.0
References: <20230223005754.2700663-1-axelrasmussen@google.com>
 <20230223005754.2700663-4-axelrasmussen@google.com> <F3D3DA6C-0AEC-4947-9E2F-7A9773296A5D@vmware.com>
In-Reply-To: <F3D3DA6C-0AEC-4947-9E2F-7A9773296A5D@vmware.com>
From:   Axel Rasmussen <axelrasmussen@google.com>
Date:   Thu, 23 Feb 2023 11:03:58 -0800
Message-ID: <CAJHvVcj_NKp8wOUL5D2GX61xp0Rvzy6Z8gvL_G=qogsJreiGTQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] mm: userfaultfd: combine 'mode' and 'wp_copy' arguments
To:     Nadav Amit <namit@vmware.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>, Jan Kara <jack@suse.cz>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@kernel.org>,
        Muchun Song <muchun.song@linux.dev>,
        Peter Xu <peterx@redhat.com>, Shuah Khan <shuah@kernel.org>,
        James Houghton <jthoughton@google.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
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

On Thu, Feb 23, 2023 at 10:51 AM Nadav Amit <namit@vmware.com> wrote:
>
>
>
> > On Feb 22, 2023, at 4:57 PM, Axel Rasmussen <axelrasmussen@google.com> =
wrote:
> >
> > Many userfaultfd ioctl functions take both a 'mode' and a 'wp_copy'
> > argument. In future commits we plan to plumb the flags through to more
> > places, so we'd be proliferating the very long argument list even
> > further.
> >
> > Let's take the time to simplify the argument list. Combine the two
> > arguments into one - and generalize, so when we add more flags in the
> > future, it doesn't imply more function arguments.
> >
> > Since the modes (copy, zeropage, continue) are mutually exclusive, stor=
e
> > them as an integer value (0, 1, 2) in the low bits. Place combine-able
> > flag bits in the high bits.
> >
> > Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
>
> Hi Axel,
>
> I sent a patch a long time ago called =E2=80=9Cuserfaultfd: introduce uff=
d_flags=E2=80=9D.
> For some reason it does not appear on lore, but you were a recipient.
>
> It was pretty similar, but one thing that I preferred in my version is
> that it defined a different type to avoid confusion. Since =E2=80=9Cflags=
=E2=80=9D is
> a very generic name, perhaps you=E2=80=99d like to adapt this approach.

Oh! I must have missed it, or just forgot. I'll take a look and see
about making some improvements. I'll also be sure to credit you in the
commit message.

>
