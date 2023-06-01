Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3998971901D
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Jun 2023 03:39:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230424AbjFABjt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 31 May 2023 21:39:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230361AbjFABjs (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 31 May 2023 21:39:48 -0400
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58C3D121
        for <linux-kselftest@vger.kernel.org>; Wed, 31 May 2023 18:39:45 -0700 (PDT)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-1a1b95cc10eso450226fac.0
        for <linux-kselftest@vger.kernel.org>; Wed, 31 May 2023 18:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1685583584; x=1688175584;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tMAT58qbQXF1B/aV0JXyDKL3tKS6p5XVrEhxiBvvom8=;
        b=QqnSID8TL++2yzRRDDuaMkHhVp8lsXcS+ymgGQb5lDd4sYMhG/oQFCl2NU1I8d59+b
         6e5ESL6nze+ez1VHvS6R/k/V3uRvZvufAgrj1cS/yr1tMkBARrKMK25VaRl7bEdsYe3J
         KAVU7aCxUJijFS63DKZwrheTh7hF6OQyZBKYo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685583584; x=1688175584;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tMAT58qbQXF1B/aV0JXyDKL3tKS6p5XVrEhxiBvvom8=;
        b=G4Eqt9EzdY7fNWFV9GBhcuIK9UPE7AXNjHVGbXoooOyqCDR2/0gYardxombB2D04U9
         FSDjN4FMdikeITjD0wMtuA8D5p76XDv30TQLxYZefumixqTl2mgWDUUe9B5uIprjbK4P
         1yWfHmOIuyAb4HxOomz5I1wBLS1Bp6QcW919gtj24AsO13fdh9harnV4nng01SJkzs4/
         WlIcUYy/IcO7oCauuzP6qcXMk4AibCHaVF5N1wGIkYAMLMFm5S3nU6D3wcfM+8gp9zWw
         6NQuXiGjvz1N6kOlFa8FtrorDc22T25ZSzHoX64SO5oSHCdYRZVTU/ypWG7usE/TSIIv
         J6YQ==
X-Gm-Message-State: AC+VfDwUNQp1eCAvaShBKZSzAMhV4EGzMlnBwV2TuuGu20Wu65lZ/PJ/
        7F4+5vfX7VpgK7CwMcCDhVttgVe3EIl4GLjC9Ij2fw==
X-Google-Smtp-Source: ACHHUZ6rQCmNsdIpMKJMXK5OdEAeSR/Lg451aSaAFhfhWDOg0vW1ZMH240lxWejfpSLYVnJNiBt9Y9Q9npi1VNxCgO8=
X-Received: by 2002:a05:6870:d411:b0:192:7111:d8c9 with SMTP id
 i17-20020a056870d41100b001927111d8c9mr5718936oag.42.1685583584692; Wed, 31
 May 2023 18:39:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230515130553.2311248-1-jeffxu@chromium.org> <2bcffc9f-9244-0362-2da9-ece230055320@intel.com>
 <CAEAAPHYdRyZEMp97919errF7SDuYBJoSrD5i1wrTx1sMdr_ZdQ@mail.gmail.com>
 <fbe53dcf-6e21-e4cf-c632-4da8369d7e83@intel.com> <CAEAAPHa=zYyjV5RqvPryRsW7VqY9cJC_-CJW6HKczY0iVsy-bg@mail.gmail.com>
 <d8f2d5c2-6650-c2a6-3a20-25583eee579b@intel.com> <CALmYWFsnGjniVseJKuhKO6eet10Onyk_C0=KNe6ZzXoCiBKZOw@mail.gmail.com>
 <b69f6809-b483-158f-8be9-4976fad918d8@intel.com> <CALmYWFs5Vgosz2JUYWkoc4YwDbiB0tT32MFpo-y6aX4kwuoz8Q@mail.gmail.com>
 <2b14036e-aed8-4212-bc0f-51ec4fe5a5c1@intel.com> <CALmYWFuSTc5Q7Hrra8FijE11+Y1KiROa=xCZWL1D3ifthrrDMQ@mail.gmail.com>
 <9d64c949-6d5f-06c0-47ef-caade67477e5@intel.com>
In-Reply-To: <9d64c949-6d5f-06c0-47ef-caade67477e5@intel.com>
From:   Jeff Xu <jeffxu@chromium.org>
Date:   Wed, 31 May 2023 18:39:00 -0700
Message-ID: <CABi2SkVmAw379G-o26sZnmt5p2FY8atoDfRMfKv0yFsfJOe7rA@mail.gmail.com>
Subject: Re: [PATCH 0/6] Memory Mapping (VMA) protection using PKU - set 1
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Jeff Xu <jeffxu@google.com>,
        =?UTF-8?Q?Stephen_R=C3=B6ttger?= <sroettger@google.com>,
        luto@kernel.org, jorgelo@chromium.org, keescook@chromium.org,
        groeck@chromium.org, jannh@google.com, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Dave,
Thanks for feedback, regarding sigaltstack:

On Thu, May 18, 2023 at 2:04=E2=80=AFPM Dave Hansen <dave.hansen@intel.com>=
 wrote:
> >
> > Agreed on signaling handling is a tough part: what do you think about
> > the approach (modifying PKRU from saved stack after XSAVE), is there a
> > blocker ?
>
> Yes, signal entry and sigreturn are not necessarily symmetric so you
> can't really have a stack.
>

To clarify: I mean this option below:
- before get_sigframe(), save PKUR =3D> tmp
- modify thread's PKRU so it can write to sigframe
- XSAVE
- save tmp =3D> sigframe

I believe you proposed this in a previous discussion [1]:
and I quote here:
"There's a delicate point when building the stack frame that the
kernel would need to move over to the new PKRU value to build the
frame before it writes the *OLD* value to the frame.  But, it's far
from impossible."

sigreturn will restore thread's original PKRU from sigframe.
In case of asymmetrics caused by siglongjmp, user space doesn't call
sigreturn, the application needs to set desired PKRU before siglongjmp.

I think this solution should work.

[1] https://lore.kernel.org/lkml/b4f0dca5-1d15-67f7-4600-9a0a91e9d0bd@intel=
.com/

Best regards,
-Jeff
