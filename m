Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70ECB718EE8
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Jun 2023 01:02:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbjEaXCn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 31 May 2023 19:02:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230337AbjEaXCm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 31 May 2023 19:02:42 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEDC995
        for <linux-kselftest@vger.kernel.org>; Wed, 31 May 2023 16:02:38 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id 3f1490d57ef6-ba86ec8047bso169031276.3
        for <linux-kselftest@vger.kernel.org>; Wed, 31 May 2023 16:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1685574158; x=1688166158;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0nzIRRbGx22h7W4dzVmFren/95lkctbr3Uctdnt7nnU=;
        b=WmPDmQ1h0qMnUeHvgUMsjpTh6VPEpTtOoNQ11MIJWu8Yqw0fd3oAGLpJdpSMotScGS
         spn0YANEwG/lKK1g4Gi1omZBv815jXYv6S6kCYbkEuBs2j/MYKV3FUNEHcvO7f+QbHQM
         Z8eo/LSR+Uy2F4fCrZWf5thKAUw2VrOtPnSl4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685574158; x=1688166158;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0nzIRRbGx22h7W4dzVmFren/95lkctbr3Uctdnt7nnU=;
        b=fbEvuik9Y58gKoLPFipSr9y7v8GdAlmUQmxLv4/hcHeEDInlmA5D/tRF3Cw+s6j8Pi
         ytR6R9pc7cuPkOs0tA6TAemM3eTAGPEhU5mT6VkOyreGmVH9k2eT7mIktIuvlH5FVkfK
         2TpQdPh8XSgdV9dR1GI2osHyS/PvM9/zwIvbma7hW86+nC+1f0xuZUIe70iSWhv2DHsR
         Sn9nwDHX5px6ICRPfH8OzGFH6e+f080EneRiK6PIuRJ8do4wZ669A437I1XpW4aYIbd4
         KOqyYDtHnHpqRgwaEgKqC/WTttepTKtt6ZrB3rps9U0gQGEjxQqqHk8hOAZhFnZ127aH
         YRxg==
X-Gm-Message-State: AC+VfDyKI+pNdIl23q3USxHi9J32OuDkwh/tPfMPbdyJFute0j/tukuG
        DCALOQ/6PI6Qku24b4tkdR38t5A7oVfMgAWDIJK1ag==
X-Google-Smtp-Source: ACHHUZ5hYf4p5U4e13Z1TleOH6isd0dp1HozTXSttchtojblNVlRPE54CQdz6YsI5G/k0FTvb1SR8akrNc+ZPON09N4=
X-Received: by 2002:a25:7303:0:b0:bab:ab4a:83e0 with SMTP id
 o3-20020a257303000000b00babab4a83e0mr7718310ybc.26.1685574158132; Wed, 31 May
 2023 16:02:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230515130553.2311248-1-jeffxu@chromium.org> <2bcffc9f-9244-0362-2da9-ece230055320@intel.com>
 <CAEAAPHYdRyZEMp97919errF7SDuYBJoSrD5i1wrTx1sMdr_ZdQ@mail.gmail.com>
 <fbe53dcf-6e21-e4cf-c632-4da8369d7e83@intel.com> <CAEAAPHa=zYyjV5RqvPryRsW7VqY9cJC_-CJW6HKczY0iVsy-bg@mail.gmail.com>
 <d8f2d5c2-6650-c2a6-3a20-25583eee579b@intel.com> <CALmYWFsnGjniVseJKuhKO6eet10Onyk_C0=KNe6ZzXoCiBKZOw@mail.gmail.com>
 <b69f6809-b483-158f-8be9-4976fad918d8@intel.com> <CALmYWFs5Vgosz2JUYWkoc4YwDbiB0tT32MFpo-y6aX4kwuoz8Q@mail.gmail.com>
 <2b14036e-aed8-4212-bc0f-51ec4fe5a5c1@intel.com>
In-Reply-To: <2b14036e-aed8-4212-bc0f-51ec4fe5a5c1@intel.com>
From:   Jeff Xu <jeffxu@chromium.org>
Date:   Wed, 31 May 2023 16:02:00 -0700
Message-ID: <CABi2SkU9iDqpcXfPpwphEgL0-rBionphfT3+Zscq_Htx=ps+2g@mail.gmail.com>
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Dave,

Regarding siglongjmp:

On Thu, May 18, 2023 at 8:37=E2=80=AFAM Dave Hansen <dave.hansen@intel.com>=
 wrote:
>
> On 5/17/23 16:48, Jeff Xu wrote:
> > However, there are a few challenges I have not yet worked through.
> > First, the code needs to track when the first signaling entry occurs
> > (saving the PKRU register to the thread struct) and when it is last
> > returned (restoring the PKRU register from the thread struct).
>
> Would tracking signal "depth" work in the face of things like siglongjmp?
>
siglongjmp is interesting, thanks for bringing this up.

With siglongjmp, the thread doesn't go back to the place where signal is
raised, indeed, this idea of tracking the first signaling entry
doesn't work well with siglongjmp.

Thanks for your insight!
-Jeff


-Jeff
