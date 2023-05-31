Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD55F718F10
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Jun 2023 01:33:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbjEaXdq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 31 May 2023 19:33:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjEaXdp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 31 May 2023 19:33:45 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BDB712F
        for <linux-kselftest@vger.kernel.org>; Wed, 31 May 2023 16:33:43 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-5147e441c33so666321a12.0
        for <linux-kselftest@vger.kernel.org>; Wed, 31 May 2023 16:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1685576021; x=1688168021;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oC5kQss/K4YNkiA3t8ssQaf48GcVeZPJDAECVwcI7aE=;
        b=bHcrVWqLHuOGdNjqH4yHqFgc5fE5p3hGNrFpdHBIN9XpYxYCwLH5w4weJ4Jcp8uSQt
         fwlMBEXymH6kjT9J/Hmbip/2+32v8K+ITR44/uHh/Dt1o3tTrca12Rf5gNwA+qoq1M+Q
         aEuFDzU3ExSTfn3EqsvmRmgQL/Wnn+Kj858SQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685576021; x=1688168021;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oC5kQss/K4YNkiA3t8ssQaf48GcVeZPJDAECVwcI7aE=;
        b=UzXhmMPaOqoGDhwmABwXVRQAayDOz6vobso36NT3wxMTw80Ajr7GdxhkBxVm9KMf67
         Z92S8GTDVclqWdLdJqIVnCBeBGbksLUjFqQ9ClUR7YGI1D70wvqfDzcyaZC0Yv4t9XV/
         XXHiuV037vGym17wgrPLwHNge5fYAPjuWgrF03uaObIuWlU+qszo6iJHKyYhcZgKOKaV
         sCN0KHmObdSYZ2zh+0JPvqkRr0gNUhxrx8Yw3oup1OaHKgn6Ui1dW9JdbGshLRtpf9As
         tTdjTkpwT2yOSmxI4FfZuDmiPEcPpBJ/GdNA0saz7C6m0JWAEPnqXbOdUzmQ+Tbnmk8s
         Cigw==
X-Gm-Message-State: AC+VfDzPk4GdEUaMoCWZ6tjyhoIuTy04Id8UC5HHaoawAGB/LT/6gPXP
        C8Fkxo6i9mdrDtCnx+Ji+/qVXifThirH1NXmUeSVQl5R
X-Google-Smtp-Source: ACHHUZ6yc3G6rLlNyy94psyXOMymWJ4vGwM27rbiipG62tX8WdHRSymV9GwOwcFnMXHCMITiWXhdJA==
X-Received: by 2002:a05:6402:2713:b0:514:94be:323c with SMTP id y19-20020a056402271300b0051494be323cmr94950edd.10.1685576021478;
        Wed, 31 May 2023 16:33:41 -0700 (PDT)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com. [209.85.218.54])
        by smtp.gmail.com with ESMTPSA id h26-20020aa7c95a000000b0051421010690sm6528224edt.21.2023.05.31.16.33.40
        for <linux-kselftest@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 May 2023 16:33:41 -0700 (PDT)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-96fab30d1e1so67345266b.0
        for <linux-kselftest@vger.kernel.org>; Wed, 31 May 2023 16:33:40 -0700 (PDT)
X-Received: by 2002:a17:907:7f9f:b0:96f:5511:8803 with SMTP id
 qk31-20020a1709077f9f00b0096f55118803mr91233ejc.22.1685576020461; Wed, 31 May
 2023 16:33:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230531220807.2048037-1-joel@joelfernandes.org>
In-Reply-To: <20230531220807.2048037-1-joel@joelfernandes.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 31 May 2023 19:33:23 -0400
X-Gmail-Original-Message-ID: <CAHk-=wgumv=8d=CqEeoYMRgqgJXePk7k5q-yi_+mO+AkdZv3hg@mail.gmail.com>
Message-ID: <CAHk-=wgumv=8d=CqEeoYMRgqgJXePk7k5q-yi_+mO+AkdZv3hg@mail.gmail.com>
Subject: Re: [PATCH v4 0/7] Optimize mremap during mutual alignment within PMD
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
        Lokesh Gidra <lokeshgidra@google.com>,
        Vineeth Pillai <vineeth@bitbyteword.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, May 31, 2023 at 6:08=E2=80=AFPM Joel Fernandes (Google)
<joel@joelfernandes.org> wrote:
>
> Here is v4 of the mremap start address optimization / fix for exec warnin=
g.

I don't see anything suspicious here.

Not that that probably means much, but the test coverage looks reasonable t=
oo.

            Linus
