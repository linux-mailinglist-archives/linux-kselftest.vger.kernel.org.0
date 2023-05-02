Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A6066F42DF
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 May 2023 13:35:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233513AbjEBLfd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 2 May 2023 07:35:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233120AbjEBLfc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 2 May 2023 07:35:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2A16B7
        for <linux-kselftest@vger.kernel.org>; Tue,  2 May 2023 04:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683027284;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lK9qsgMO19zBq82l3bg+w3WuX7IjfDeJ2uNZ+xfD+lw=;
        b=S9tF2JikkKIwOBO/WNkAWhpny34BOVEPQQ/gHqVJO1i4lRH+WJ7MZKdigAfxToMoTJWWS2
        urdNqa1PQLufL4vSchM2YjEydcS0IA82aVn7ljQ08vpogHndSks+CWIQfREh8LpOURyr9d
        Jn0UAOUg/AJqIbvWyLNLbSVTFZqeAWY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-371-B5nUjk_RP6irYbeafL3fvg-1; Tue, 02 May 2023 07:34:43 -0400
X-MC-Unique: B5nUjk_RP6irYbeafL3fvg-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-2f2981b8364so2148706f8f.1
        for <linux-kselftest@vger.kernel.org>; Tue, 02 May 2023 04:34:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683027282; x=1685619282;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lK9qsgMO19zBq82l3bg+w3WuX7IjfDeJ2uNZ+xfD+lw=;
        b=SqdbXUQpa0c4BC37KckIyIM9jb2bQPNXh46mD11xw//cMuWbTbl0VdsyEv640iwOCp
         1h+AJiA27ok19D4cbVZHxZC28OemzsTwVJzSZ2rXLi5hxmvtsbzT0jXvYyvImpsZ9or8
         jXKIyY+XW/GovBDt+yKM07cT1+C37/8GhaijR25wPaLL8xQ6oFe50Dd/iT9krzXHRYGB
         uC7c5IMUWxQ0+vvapsNo9+ldqCEugsnje8WMyW5bRDJwUa68qb3YY+9g5EN8/8Gz4dMH
         VSUsvCCVGampsSy4CI4XGFXkXf0dY+dCZvW5rxk17vLuhP1pmsyu5SWkyVkSftqT9mUs
         W5RQ==
X-Gm-Message-State: AC+VfDz9SZzfe8gtvTJ9rIm8leEm8TOf6Yx4YdO5rp+ZshPiXZS/63wV
        n9kGVIC1hiSyKwMpuJswI2a4AVv8/yDflZ9bk1LTRx6Wz7xWYZ+ywQyKNMXkB/bFZ8rcyreMYDg
        z1naZlsZNkr+zP+Ja0WytPpsPLA98
X-Received: by 2002:a5d:6a45:0:b0:2fe:fd61:6426 with SMTP id t5-20020a5d6a45000000b002fefd616426mr11687243wrw.11.1683027282202;
        Tue, 02 May 2023 04:34:42 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4RMusZykdrqpvGbSu8xbtR8yrdyW4pwr3uU+vuzXdiFHZ9djwSyuPHdmMLi+0c5JNiHQwJcQ==
X-Received: by 2002:a5d:6a45:0:b0:2fe:fd61:6426 with SMTP id t5-20020a5d6a45000000b002fefd616426mr11687229wrw.11.1683027281880;
        Tue, 02 May 2023 04:34:41 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id p17-20020a056000019100b002fda1b12a0bsm30895708wrx.2.2023.05.02.04.34.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 May 2023 04:34:41 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>, linux-input@vger.kernel.org,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] Input: tests - modular KUnit tests should not
 depend on KUNIT=y
In-Reply-To: <CAMuHMdWA7R7NrS-T8x4qA3tn59zmZS8w20f1UyTw-R53iryeTw@mail.gmail.com>
References: <cover.1683022164.git.geert+renesas@glider.be>
 <483c4f520e4acc6357ebba3e605977b4c56374df.1683022164.git.geert+renesas@glider.be>
 <87ildbx9or.fsf@minerva.mail-host-address-is-not-set>
 <CAMuHMdWA7R7NrS-T8x4qA3tn59zmZS8w20f1UyTw-R53iryeTw@mail.gmail.com>
Date:   Tue, 02 May 2023 13:34:40 +0200
Message-ID: <87cz3jx8z3.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Geert Uytterhoeven <geert@linux-m68k.org> writes:

> Hi Javier,
>
> On Tue, May 2, 2023 at 1:19=E2=80=AFPM Javier Martinez Canillas
> <javierm@redhat.com> wrote:
>> I've only been Cc'ed in patch #2.
>
> Not really, you're in the To-header on the full series?
> https://lore.kernel.org/all/cover.1683022164.git.geert+renesas@glider.be
>

Strange... I only got patch #2, neither patch #1 nor the cover letter.

For patch #1 as well:

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

Sorry for missing that bug and thanks a lot for fixing it!

--=20
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

