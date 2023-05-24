Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E5597101AA
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 May 2023 01:23:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236597AbjEXXXb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 24 May 2023 19:23:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231305AbjEXXXa (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 24 May 2023 19:23:30 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 170F699
        for <linux-kselftest@vger.kernel.org>; Wed, 24 May 2023 16:23:29 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-50bcb4a81ceso3172858a12.2
        for <linux-kselftest@vger.kernel.org>; Wed, 24 May 2023 16:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1684970607; x=1687562607;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IjfvWGxrDOW5fKfb30oP8LD/BgqVeZF9JPPMTcWyoW0=;
        b=PyGvbXNCuLE00GODAd9mW/JkI8NoPtC2g9w0ueTtjeuZD2mm9FaCKV3JZlWbeMOzRj
         Qw0Je89BQ10M7UBitfu86C6+/W3sI+Oc2k13an9qjrcgqMM+SVUUdrx6aUcZBoIbZHmO
         FEaZidIvvcn5mUKRtaxC8t0Oan8KihIQupnG8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684970607; x=1687562607;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IjfvWGxrDOW5fKfb30oP8LD/BgqVeZF9JPPMTcWyoW0=;
        b=S8TdAQvb7v+qbMhyHIb6HyFLJo/58kQ4DqNN/l2h8xorCEqFVlooeN7Ho1prXPZEdq
         6222Qk0QCtF3x3d68JHyUMeT+0h0BkAmNXnFY4+9emURue8TdLIqBUjDbzwl1PP3TNdS
         pmGfEFcg61C10LL7XrUIafMNiNTq4KKV3S4L3Eo48PJx49quGP2mDQLTtgoQl6GoL4GU
         mxv4S1ltY9lGNtgysqAhagYmUeFj0zez2ZFzjwhEsYsLVs9hysDQKw+/OUFZnaPFVtGV
         4SwMjvh3t3DgsJmvIjtSX0wXknf3R1FMKr65eYasv7k1PCLnxQQc6C03kWevnRuTEQdr
         4ZXQ==
X-Gm-Message-State: AC+VfDxp3TRlVsWfLy00V89woJUfdJyzj+uYbSVyoOJFwCMCsyqVZkIp
        ZwS/P652+uGaCOL1YJ7wg9q7E0Otc6PgKROTHtY8lijL
X-Google-Smtp-Source: ACHHUZ4ZSU68vjZdwbug+O4+rAckzghymQOgElNNJHkkPmEhqD472R3fwpNPYcXFkwTTaPll4e+2lA==
X-Received: by 2002:a17:906:9b84:b0:94f:5b91:7952 with SMTP id dd4-20020a1709069b8400b0094f5b917952mr20750345ejc.21.1684970607409;
        Wed, 24 May 2023 16:23:27 -0700 (PDT)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com. [209.85.218.42])
        by smtp.gmail.com with ESMTPSA id e6-20020a170906504600b00965ac1510f8sm10782ejk.185.2023.05.24.16.23.26
        for <linux-kselftest@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 May 2023 16:23:26 -0700 (PDT)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-96f850b32caso278517066b.3
        for <linux-kselftest@vger.kernel.org>; Wed, 24 May 2023 16:23:26 -0700 (PDT)
X-Received: by 2002:a17:906:974b:b0:96f:8b64:c0 with SMTP id
 o11-20020a170906974b00b0096f8b6400c0mr20082278ejy.39.1684970605797; Wed, 24
 May 2023 16:23:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230524153239.3036507-1-joel@joelfernandes.org> <20230524153239.3036507-2-joel@joelfernandes.org>
In-Reply-To: <20230524153239.3036507-2-joel@joelfernandes.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 24 May 2023 16:23:09 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiNUe7YjK9fmZk+2ZQhjLH-64WrkwnXO9813_iLuaFXuQ@mail.gmail.com>
Message-ID: <CAHk-=wiNUe7YjK9fmZk+2ZQhjLH-64WrkwnXO9813_iLuaFXuQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/6] mm/mremap: Optimize the start addresses in move_page_tables()
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, Shuah Khan <shuah@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Kirill A Shutemov <kirill@shutemov.name>,
        "Liam R. Howlett" <liam.howlett@oracle.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Kalesh Singh <kaleshsingh@google.com>,
        Lokesh Gidra <lokeshgidra@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hmm. I'm still quite unhappy about your can_align_down().

On Wed, May 24, 2023 at 8:32=E2=80=AFAM Joel Fernandes (Google)
<joel@joelfernandes.org> wrote:
>
> +       /* If the masked address is within vma, we cannot align the addre=
ss down. */
> +       if (vma->vm_start <=3D addr_masked)
> +               return false;

I don't think this test is right.

The test should not be "is the mapping still there at the point we
aligned down to".

No, the test should be whether there is any part of the mapping below
the point we're starting with:

        if (vma->vm_start < addr_to_align)
                return false;

because we can do the "expand the move down" *only* if it's the
beginning of the vma (because otherwise we'd be moving part of the vma
that precedes the address!)

(Alternatively, just make that "<" be "!=3D" - we're basically saying
that we can expand moving ptes to a pmd boundary *only* if this vma
starts at that point. No?).

> +       cur =3D find_vma_prev(vma->vm_mm, vma->vm_start, &prev);
> +       if (!cur || cur !=3D vma || !prev)
> +               return false;

I've mentioned this test before, and I still find it actively misleading.

First off, the "!cur || cur !=3D vma" test is clearly redundant. We know
'vma' isn't NULL (we just dereferenced it!). So "cur !=3D vma" already
includes the "!cur" test.

So that "!cur" part of the test simply *cannot* be sensible.

And the "!prev" test still makes no sense to me. You tried to explain
it to me earlier, and I clearly didn't get it. It seems actively
wrong. I still think "!prev" should return true.

You seemed to think that "!prev" couldn';t actually happen and would
be a sign of some VM problem, but that doesn't make any sense to me.
Of course !prev can happen - if "vma" is the first vma in the VM and
there is no previous.

It may be *rare*, but I still don't understand why you'd make that
"there is no vma below us" mean "we cannot expand the move below us
because there's something there".

So I continue to think that this test should just be

        if (WARN_ON_ONCE(cur !=3D vma))
                return false;

because if it ever returns something that *isn't* the same as vma,
then we do indeed have serious problems. But that WARN_ON_ONCE() shows
that that's a "cannot happen" thing, not some kind of "if this happens
than don't do it" test.

and then the *real* test  for "can we align down" should just be

        return !prev || prev->vm_end <=3D addr_masked;

Because while I think your code _works_, it really doesn't seem to
make much sense as it stands in your patch. The tests are actively
misleading. No?

                 Linus
