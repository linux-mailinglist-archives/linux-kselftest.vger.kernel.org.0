Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D34EB7078CE
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 May 2023 06:12:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbjEREMg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 18 May 2023 00:12:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229982AbjEREMc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 18 May 2023 00:12:32 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B73435BF
        for <linux-kselftest@vger.kernel.org>; Wed, 17 May 2023 21:12:30 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-50bcb4a81ceso2739770a12.2
        for <linux-kselftest@vger.kernel.org>; Wed, 17 May 2023 21:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1684383148; x=1686975148;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XBiK7zqzCv4YO32S9qrBa6a2V7ip3iodPxLIsQgbycE=;
        b=OC3DpLAIgwgMaxu6536uxiVSMkMWAXUyAUvvt8zzh0qHAfQTnsw+BOdZRupUy8lRnD
         Hh20CVgnPKpn+PgPJWDcgb1QLr8gClJ+Dkc1pcPBYxq30E2BhVGtwuVOOlIi6LY8LHVg
         31i5lr+0NacNWWrKyG+0WMIzz3jqeTJ0jN/9k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684383148; x=1686975148;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XBiK7zqzCv4YO32S9qrBa6a2V7ip3iodPxLIsQgbycE=;
        b=Drur3xkgrzQ9oJQyjtKFONztzHaoSGO+bhfLYkQZZknEK8jYB6w6Pl33PjzOu8XD4D
         WEmfWKeT4GNJfsEs9hIjIkowjjQdn6+aR+LtY8wxDCK0a0PxbMlc1mKsyabuhy76S2tS
         rjFWsrvZ8Xl1CT4Cp4n8Mig1T0tV4PrdVC8HpZhODaGmCPVUeTv2ieNYd9zfj8EvytVY
         F2hzWQdP/WnYG0NXHYSPgCGQzyst1eHNSHmD1IdZjsfPV+wuiG6jJv1vZMgtORu+WuvP
         p1+8gX6OT+y7ExqCqViJYFD4hMyr95IHSxEGU2Gphpo2P3jvZr7yhcjFvbBvu9NSeh3n
         rGJQ==
X-Gm-Message-State: AC+VfDzwQfsJOm6KL3hyY1BoaLDAhs6l6Y5+mGXRcO8LHAcgbyJZR6K1
        CHHsx95W5MuNhrgeqGTvs1d31cv8uq2RzaAai26ncoQG
X-Google-Smtp-Source: ACHHUZ7fHaXJ63hxaUiuXrNY3TYyN31xBEJRwLCFE3HuFcuBM2leC3y3dLUutgG/SROswt2G9Sh1OA==
X-Received: by 2002:a17:907:6d8d:b0:96a:3e39:f567 with SMTP id sb13-20020a1709076d8d00b0096a3e39f567mr26348486ejc.47.1684383148325;
        Wed, 17 May 2023 21:12:28 -0700 (PDT)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id l7-20020a170906414700b00965d294e633sm408422ejk.58.2023.05.17.21.12.25
        for <linux-kselftest@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 May 2023 21:12:26 -0700 (PDT)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-510b869fe0dso2726936a12.3
        for <linux-kselftest@vger.kernel.org>; Wed, 17 May 2023 21:12:25 -0700 (PDT)
X-Received: by 2002:a17:906:da8c:b0:94f:7a8:a902 with SMTP id
 xh12-20020a170906da8c00b0094f07a8a902mr31637538ejb.14.1684383145429; Wed, 17
 May 2023 21:12:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230518021825.712742-1-joel@joelfernandes.org> <20230518021825.712742-2-joel@joelfernandes.org>
In-Reply-To: <20230518021825.712742-2-joel@joelfernandes.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 17 May 2023 21:12:07 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi20GzWeK=vUoreX6AXOEmeJKczou1McCOC9JytVO=TQg@mail.gmail.com>
Message-ID: <CAHk-=wi20GzWeK=vUoreX6AXOEmeJKczou1McCOC9JytVO=TQg@mail.gmail.com>
Subject: Re: [PATCH RFC 1/4] mm/mremap: Optimize the start addresses in move_page_tables()
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, Shuah Khan <shuah@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Kirill A Shutemov <kirill@shutemov.name>,
        "Liam R. Howlett" <liam.howlett@oracle.com>,
        "Paul E. McKenney" <paulmck@kernel.org>
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

On Wed, May 17, 2023 at 7:18=E2=80=AFPM Joel Fernandes (Google)
<joel@joelfernandes.org> wrote:
>
> This warning will only trigger when there is mutual alignment in the
> move operation. A solution, as suggested by Linus Torvalds [2], is to
> initiate the copy process at the PMD level whenever such alignment is
> present.

So this patch is actually simpler than I thought it would be.

But I'm a bit nervous about it. In particular, it ends doing

        old_end =3D old_addr + len;
        ... expand old_addr/new_addr down to the pmd boundary ..
        return len + old_addr - old_end;        /* how much done */

doesn't that return value end up being nonsensical now?

In particular, I think it can return a *negative* value, because of
how old_addr was moved down, and the "now much done" might indeed be
"negative" in the sense that it failed the move even "before" the
original starting point.

And that negative value then ends up being a large positive one as an
"unsigned long", of course.

So I get the feeling that it wants something like

        if (old_addr + len < old_end)
                return 0;

there at the end.

But maybe there is something in there that guarantees that that case
never happens. I didn't think too deeply about it, I just felt this
looked odd.

               Linus
