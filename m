Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38F69706A22
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 May 2023 15:48:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231528AbjEQNsT convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 17 May 2023 09:48:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjEQNsS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 17 May 2023 09:48:18 -0400
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B7CD1BFA;
        Wed, 17 May 2023 06:48:17 -0700 (PDT)
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-94f9cd65b1aso19247966b.0;
        Wed, 17 May 2023 06:48:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684331296; x=1686923296;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ktinit9wKE6dNmLgC8Q+hzsuqEwfbXOj0+wtuIuj7PA=;
        b=XBpzxd6w41aMmUzQOVx7M1JeAG6TU6klJCNM2ZFFJ64fWZqsixC+fuStxe+J0AhaHm
         p0AvsZzH01Y2dvXZ748Ac+LZVDdVoGBY2EyMFTvn3Ezuq10PW1hbopd+OUdbOmZ9X07+
         vHfX2XL5fJLzShFbdZykXnZvsqegs/KCl8a16rGx1Ljyp9eqtm8CbtfB5OCEIQgrT7w0
         p1ECYCmTpO+cs16M44DBOK2Hoc29btFMVKn+5HslgnnNEO+N/f3IbZiijW4DtkSprnEq
         CIlUiTz0mbK+HP9WkIvaIiqYYmPYmehH2LAh4GpIyn/wA4a/5xqY45CGK61+GF0hhEVd
         Qt7Q==
X-Gm-Message-State: AC+VfDxIMXLnCbk6CJZeM8b3nU/IXBIv83UG7Lcg2nCcIGRaY+4dilnJ
        /fGqxwe4tASXf6sDk/dnbYXzZefNa7QskcjAttw=
X-Google-Smtp-Source: ACHHUZ6M9EgcbaCbKF8EZaqyFXATppYniPvZEHcewZCPT/QYkFrutGUliTGcVVnKvC2nG18eSQY5J4nCD2m1yx3JtWA=
X-Received: by 2002:a17:906:778a:b0:92e:f520:7762 with SMTP id
 s10-20020a170906778a00b0092ef5207762mr2003855ejm.6.1684331295491; Wed, 17 May
 2023 06:48:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230517131102.934196-1-arnd@kernel.org> <20230517131102.934196-11-arnd@kernel.org>
In-Reply-To: <20230517131102.934196-11-arnd@kernel.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 17 May 2023 15:48:04 +0200
Message-ID: <CAJZ5v0h0spuxK-7LBJSU9BK2TEOUeMjf7hhKScadkxFN_RwStQ@mail.gmail.com>
Subject: Re: [PATCH 10/14] suspend: add a arch_resume_nosmt() prototype
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Michal Simek <monstr@monstr.eu>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Helge Deller <deller@gmx.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@redhat.com>,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        audit@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, May 17, 2023 at 3:12 PM Arnd Bergmann <arnd@kernel.org> wrote:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> The arch_resume_nosmt() has a __weak definition, plus an x86
> specific override, but no prototype that ensures the two have
> the same arguments. This causes a W=1 warning:
>
> arch/x86/power/hibernate.c:189:5: error: no previous prototype for 'arch_resume_nosmt' [-Werror=missing-prototypes]
>
> Add the prototype in linux/suspend.h, which is included in
> both places.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Do you want me to pick this up?

If not

Acked-by: Rafael J. Wysocki <rafael@kernel.org>

> ---
>  include/linux/suspend.h | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/include/linux/suspend.h b/include/linux/suspend.h
> index f16653f7be32..bc911fecb8e8 100644
> --- a/include/linux/suspend.h
> +++ b/include/linux/suspend.h
> @@ -472,6 +472,8 @@ static inline int hibernate_quiet_exec(int (*func)(void *data), void *data) {
>  }
>  #endif /* CONFIG_HIBERNATION */
>
> +int arch_resume_nosmt(void);
> +
>  #ifdef CONFIG_HIBERNATION_SNAPSHOT_DEV
>  int is_hibernate_resume_dev(dev_t dev);
>  #else
> --
> 2.39.2
>
