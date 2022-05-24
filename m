Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FCBB532BD1
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 May 2022 16:00:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237963AbiEXN7i (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 24 May 2022 09:59:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234396AbiEXN7h (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 24 May 2022 09:59:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2DF9287A01
        for <linux-kselftest@vger.kernel.org>; Tue, 24 May 2022 06:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653400775;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2Ff+pshfC1Z6E3EzI0y8JRQ1REVK5W8crSBK2MgvYz0=;
        b=CPY9tM8sOjSxfzwTh7DEsSuHWWLbrhLWX/iqRSn1MdNdt6EJxKhOSCoLqqSSl3gemhEHbK
        t3Dz7DkZWAEtTC7RfPioiOQfvQjjR1vUCQgtIpZoMW7n8QaM6Gmmn7lnqVZDCa0/9PhDhj
        KTzNspw7a0zwd+Armo35R/J0iFl1BhY=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-346-7zPLod8OMG-T0lO2-vEYvA-1; Tue, 24 May 2022 09:59:33 -0400
X-MC-Unique: 7zPLod8OMG-T0lO2-vEYvA-1
Received: by mail-qt1-f198.google.com with SMTP id m19-20020a05622a055300b002f940281f18so1989332qtx.22
        for <linux-kselftest@vger.kernel.org>; Tue, 24 May 2022 06:59:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2Ff+pshfC1Z6E3EzI0y8JRQ1REVK5W8crSBK2MgvYz0=;
        b=3d3iK09dmpWI/kzJwHzji+0kWlB3w2DGFtFQPDIVBB8GqxYbMjYMJsiE1lCTVhFx3f
         cq937tEjyM09S+d5kf7sKul7ff9XuH+ngTL6HGl+jbUGKOzffPz87eYFxsXida3efwsn
         FNtTuP8NKiyYN9eqdcZvUSo1bxXSVd5S5Wee/4jAdccTakHXHU/WchrnUJhUWsjgRo4y
         zMkMKXqrMVxmXDPHmkOO+1kVWRx6J/JDySYD2Q6nRz9bDRxRWR/HM+T1w9YYU7ypB/5u
         Xg9G8sSBgB0qH8mTw47ITAjCWdOkCmehrLBlMpluuhjLui+WafNpYS4GAkC7m0bhfjHM
         6shA==
X-Gm-Message-State: AOAM5330TstJzmGIii6HB0BVjqQ0i11T2LuO4OthUZtdmMVaFbF4r9za
        E3ryf295ns4D94ySqwPHJ1dPiw6l7ewy+cA1CN+ijNF3WMjWc/lmtffeTkCompD7cKGC2sothLD
        oPh3Im40Y1n7f9rjLDvBRTzSA/nm2cITRFHDW4qnClIg6
X-Received: by 2002:a05:620a:1981:b0:507:4a52:f310 with SMTP id bm1-20020a05620a198100b005074a52f310mr17389262qkb.611.1653400773147;
        Tue, 24 May 2022 06:59:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwqS+yZK5ZzpIED7qcr754PYpaiBLoHFNyuZBNAopvk3ojwwBfdu204lMoxiDpi9ZmkpuCv+gT3j6X+c8inrO8=
X-Received: by 2002:a05:620a:1981:b0:507:4a52:f310 with SMTP id
 bm1-20020a05620a198100b005074a52f310mr17389243qkb.611.1653400772863; Tue, 24
 May 2022 06:59:32 -0700 (PDT)
MIME-Version: 1.0
References: <20211029184500.2821444-1-mcgrof@kernel.org> <20211029184500.2821444-2-mcgrof@kernel.org>
 <87h75g0xbm.ffs@tglx>
In-Reply-To: <87h75g0xbm.ffs@tglx>
From:   Richard Fontana <rfontana@redhat.com>
Date:   Tue, 24 May 2022 09:59:22 -0400
Message-ID: <CAC1cPGz3ARW_H9cq6LY0_h3YXomMmSdVR1v1+xEYbshtK8Mvmw@mail.gmail.com>
Subject: Re: [PATCH v9 1/6] LICENSES: Add the copyleft-next-0.3.1 license
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Luis Chamberlain <mcgrof@kernel.org>, tj@kernel.org,
        Greg KH <gregkh@linuxfoundation.org>,
        akpm@linux-foundation.org, jeyu@kernel.org,
        Shuah Khan <shuah@kernel.org>, bvanassche@acm.org,
        dan.j.williams@intel.com, joe@perches.com, keescook@chromium.org,
        rostedt@goodmis.org, minchan@kernel.org,
        linux-spdx@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Goldwyn Rodrigues <rgoldwyn@suse.com>,
        Kuno Woudt <kuno@frob.nl>,
        Richard Fontana <fontana@sharpeleven.org>,
        copyleft-next@lists.fedorahosted.org,
        Ciaran Farrell <Ciaran.Farrell@suse.com>,
        Christopher De Nicolo <Christopher.DeNicolo@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Thorsten Leemhuis <linux@leemhuis.info>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, May 23, 2022 at 5:10 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> On Fri, Oct 29 2021 at 11:44, Luis Chamberlain wrote:
> > preferred. A summary of benefits why projects outside of Linux might
> > prefer to use copyleft-next >= 0.3.1 over GPLv2:
> >
> <snip>
> >
> > o copyleft-next has a 'built-in or-later' provision
>
> Not convinced that this is a benefit under all circumstances, but that's
> a philosopical problem. The real problem is this:
>
> > +Valid-License-Identifier: copyleft-next-0.3.1
>
> and
>
> > +11. Later License Versions
> > +
> > +    The Copyleft-Next Project may release new versions of copyleft-next,
> > +    designated by a distinguishing version number ("Later Versions").
> > +    Unless I explicitly remove the option of Distributing Covered Works
> > +    under Later Versions, You may Distribute Covered Works under any Later
> > +    Version.
>
> If I want to remove this option, then how do I express this with a SPDX
> license identifier?

Probably off-topic but: I think as things currently stand in SPDX you
would have to use an ad hoc LicenseRef- identifier to express the
entirety of copyleft-next-0.3.1 coupled with an amendment that sort of
strikes the later versions provision. This issue is also somewhat
relevant: https://github.com/spdx/spdx-spec/issues/153

FWIW, built-in 'or-later' clauses are actually common in copyleft open
source licenses; the GPL family is the oddity here. (Then again, the
whole idea of a downstream license upgradability option is sort of
unusual in the bigger scheme of things, but that's another topic.)

Richard

