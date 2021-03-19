Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02F623425F8
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Mar 2021 20:16:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230313AbhCSTPu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 19 Mar 2021 15:15:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230096AbhCSTPj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 19 Mar 2021 15:15:39 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 661C8C06175F
        for <linux-kselftest@vger.kernel.org>; Fri, 19 Mar 2021 12:15:38 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id m7so4338761pgj.8
        for <linux-kselftest@vger.kernel.org>; Fri, 19 Mar 2021 12:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=UhVshRutOq0lszJbq/YX4dDlC5l4aOjl7AUjxQMu52w=;
        b=bBKx+9uN8xnCc5sshFh2/XhWXlYamoIzo+jRJ+PEm23+wwPHDN30u21VYQIXFuEQpD
         w+w4KIEC/rk6vS+80NpNCv+5zSBGLevW+p8ahQVPa2S2k9ZqiIfInhQI3nIlyFhnIbyL
         FS7xcu7RdHUC6pgg3s5aV9vLgE7MofLySVDYY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=UhVshRutOq0lszJbq/YX4dDlC5l4aOjl7AUjxQMu52w=;
        b=N5BkoUiUWZYHqceeMzVWIZ+nPMKjeQaIboRuS1MNt/yBIAjzogsnbYMvMWi1ps3Wgd
         rB4hs4aijK74J8wW9T0oaA/UHrkxlmBA/PUy+R0FXtIHUByIsCqYHVntBSyBvS5+l1ZV
         7neitikzuksty+RZ294euk87bLz9iwOQt11nOpiGWRPdklELiL7PDT7n3/dkhZw87tdy
         ytfzmQWziNP5Fe0xo8zwA351E/gnZS5eGjgH8DmxGT2Azb4erP7/G4ihfslW2+E/bNKI
         4imhX41m1cNPhBOj0qkQLMXmWySGlVait6HMKoOJf7Ccml4R2MJMrnXCBh/sPY2Y+MuO
         IQ8g==
X-Gm-Message-State: AOAM533XjU4lrpIJd9bQeiMWr+qzuOLzxlYnBGcHiQvKwJyVim98dF4m
        HL/YldYWu0cfAZR3Qdkvc7Hcmw==
X-Google-Smtp-Source: ABdhPJyocwGZ+YCdp+AEKehahWsjJ+Q+SCbixvse5NoSiTvSwxOgE6bO6/4QIhmDO4axWxnOK6O7hQ==
X-Received: by 2002:a63:4761:: with SMTP id w33mr12829462pgk.118.1616181337860;
        Fri, 19 Mar 2021 12:15:37 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id e65sm6741175pfe.9.2021.03.19.12.15.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 12:15:37 -0700 (PDT)
Date:   Fri, 19 Mar 2021 12:15:36 -0700
From:   Kees Cook <keescook@chromium.org>
To:     =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc:     James Morris <jmorris@namei.org>, Jann Horn <jannh@google.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Casey Schaufler <casey@schaufler-ca.com>,
        David Howells <dhowells@redhat.com>,
        Jeff Dike <jdike@addtoit.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Shuah Khan <shuah@kernel.org>,
        Vincent Dagonneau <vincent.dagonneau@ssi.gouv.fr>,
        kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        linux-security-module@vger.kernel.org, x86@kernel.org,
        =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@linux.microsoft.com>
Subject: Re: [PATCH v30 02/12] landlock: Add ruleset and domain management
Message-ID: <202103191213.D6B1B27423@keescook>
References: <20210316204252.427806-1-mic@digikod.net>
 <20210316204252.427806-3-mic@digikod.net>
 <202103191114.C87C5E2B69@keescook>
 <acda4be1-4076-a31d-fcfd-27764dd598c8@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <acda4be1-4076-a31d-fcfd-27764dd598c8@digikod.net>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Mar 19, 2021 at 08:03:22PM +0100, Micka�l Sala�n wrote:
> On 19/03/2021 19:40, Kees Cook wrote:
> > On Tue, Mar 16, 2021 at 09:42:42PM +0100, Micka�l Sala�n wrote:
> >> [...]
> >> +static void put_rule(struct landlock_rule *const rule)
> >> +{
> >> +	might_sleep();
> >> +	if (!rule)
> >> +		return;
> >> +	landlock_put_object(rule->object);
> >> +	kfree(rule);
> >> +}
> > 
> > I'd expect this to be named "release" rather than "put" since it doesn't
> > do any lifetime reference counting.
> 
> It does decrement rule->object->usage .

Well, landlock_put_object() decrements rule->object's lifetime. It seems
"rule" doesn't have a lifetime. (There is no refcounter on rule.) I just
find it strange to see "put" without a matching "get". Not a big deal.

-- 
Kees Cook
