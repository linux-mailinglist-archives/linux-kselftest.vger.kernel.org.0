Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B71B27987C8
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Sep 2023 15:26:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243538AbjIHN02 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 8 Sep 2023 09:26:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238473AbjIHN01 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 8 Sep 2023 09:26:27 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB0C31BF0
        for <linux-kselftest@vger.kernel.org>; Fri,  8 Sep 2023 06:26:23 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2be5e2a3c86so37956861fa.0
        for <linux-kselftest@vger.kernel.org>; Fri, 08 Sep 2023 06:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1694179582; x=1694784382; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JtvG7vCoPjzvZ6xl4mQwiW30hYHrBTBAj9DoApT1P2w=;
        b=BYn73QHDStv9k1exZIKuf3DqEmF6+ZmY8FPKu5IEONwpwm9I6zJtaQdfu+5sMAMYC/
         aXmvh+o0Mq3ozChUsun7fffo7jT+zOl5hFiKfcz4SARdxjPA4f9BsKdYBLFz0wlwNI4K
         Bqq5wb5A7V3ASoiwJ3IPNVtG69/6JS+5RwDgU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694179582; x=1694784382;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JtvG7vCoPjzvZ6xl4mQwiW30hYHrBTBAj9DoApT1P2w=;
        b=Q8mowOtobVhMRMYa6fc/X3+vWaverDW6wHygbKJbErUq6KMok6wojEV7zALchufIMm
         m3A4olWUTstkQ8au9u5MZ5HgSibR8stTFlusLCVKgFJB1LclyrALAe4FaS+ymOD2+d9W
         iKTdXROBKZ2LWspzBG5OuKLHpAugEOEjodj666pMoJLSarK7xJwYcK1I10AF9lVA7ggo
         dJXU+R7aQ+Fvq33X/nwjnxY9OmTF5n90eALCbEO0k3oZQCc7ctcgKUooQb9KN9lSoF3P
         klau7qff1M42veuREmDg/1qF6rbIMxC6X/1qul3S5UnDVNg4ddUkyoBan0JVxc2Ij35k
         ifRQ==
X-Gm-Message-State: AOJu0Ywj2TmiTs8H9/yosqFm9oQlsrfF+ms/Obc1tQNi+4QofSfaYMwR
        rSdSlI/k6ih0uwOdEdWiCewHlbXzoODQYeXYkKnUZg==
X-Google-Smtp-Source: AGHT+IHXE6NA7384Ovya/IgVK7bR8Nri7iznp2hNET+Y6LuS6TLo2xz8tphlwO1rMJaX6yLUnlk6HxEqoKFut1VYR20=
X-Received: by 2002:a2e:844e:0:b0:2bc:d507:6ee with SMTP id
 u14-20020a2e844e000000b002bcd50706eemr912865ljh.7.1694179581822; Fri, 08 Sep
 2023 06:26:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230903151328.2981432-1-joel@joelfernandes.org>
 <20230903151328.2981432-2-joel@joelfernandes.org> <ZPscoU1l4HzP15sz@dhcp22.suse.cz>
In-Reply-To: <ZPscoU1l4HzP15sz@dhcp22.suse.cz>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Fri, 8 Sep 2023 09:26:10 -0400
Message-ID: <CAEXW_YQ1d2QK_dav59qVtj7zNrPLL+5zC8wGxAu7ZXC2Oou=6Q@mail.gmail.com>
Subject: Re: [PATCH v6 1/7] mm/mremap: Optimize the start addresses in move_page_tables()
To:     Michal Hocko <mhocko@suse.com>
Cc:     linux-kernel@vger.kernel.org, Lorenzo Stoakes <lstoakes@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        Shuah Khan <shuah@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Kirill A Shutemov <kirill@shutemov.name>,
        "Liam R. Howlett" <liam.howlett@oracle.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Kalesh Singh <kaleshsingh@google.com>,
        Lokesh Gidra <lokeshgidra@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Sep 8, 2023 at 9:07=E2=80=AFAM Michal Hocko <mhocko@suse.com> wrote=
:
>
> Sorry for being silent most of the time in this patch series and thanks
> for pushing it forward.
>
[...]
>
> The patch looks good to me.
> Acked-by: Michal Hocko <mhocko@suse.com>

Thank you very much!!

 - Joel
