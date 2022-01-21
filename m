Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3193A495783
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Jan 2022 02:00:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbiAUBAw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 20 Jan 2022 20:00:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbiAUBAw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 20 Jan 2022 20:00:52 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5061C061574
        for <linux-kselftest@vger.kernel.org>; Thu, 20 Jan 2022 17:00:51 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id b13so36308037edn.0
        for <linux-kselftest@vger.kernel.org>; Thu, 20 Jan 2022 17:00:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=qvrcavduwvJQ107/U7y4f2WAZMKBIw7TGMDOsClD2es=;
        b=o5MgGa3IEPcw+i/fK2gpC1VcpHWGdOhAFpJEoEpIFVh2R0KFtNO7tVgfDQh2E9jJh+
         P/V8IoKvHwAUHt0eWRB89CdPa2izOoGnJCXk9T7Itbzqy8I2eq6xAPugzd4r6vOE9LV7
         ng+32CXwoDZPW2/NM5fnD69OPwxgsm5qq9Ed6h6gMqSycdga8zt00yTmY2wuj85LzWCt
         1BvNMfS2R5mQIrZudB/yFZC5XvgYqeMz8c6KnRNwTzIs2Hdfi/HekylYDM+i3q6cYfoF
         Tl6oLDM0wYrdx/L6aGIDZIZgGTi2uKPqMI5yBge7G+p1PuKFQaQp3dkI3rdSEPqluhn0
         i7Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qvrcavduwvJQ107/U7y4f2WAZMKBIw7TGMDOsClD2es=;
        b=U2Ic5T0uncB8n4tlXdUe/0E4BaFkTx0/NMRRQjWOb91CkfM9RBLAH4SH1cUAEZCGCr
         QvGXkhIlRy4DGss22GDPQDW2AMvqf9aPH80jH1tMjP/8+/OmUviyPJPIkVxVPfidpxye
         jWNQOOWAV06fEq4ntkPACTjRKUnRELWRoxbyNjAPlOcppFTb2PkXOw+9pMJfinmeAMpI
         5xEPYsBDjDIiOxdnU4LnzPayAL0VyMZ+AgUqS+TZOe//or4IfDM6dg5cbETFMelN6zqD
         vvjOn6Iuw7430hgjcDRHtTVpYYbFqYYZE64MzvbTSxy8mWCatyp9s8YUwnOUKTPrGXPm
         v4UA==
X-Gm-Message-State: AOAM532rGBiVP6pbfTMwbPjF9k7YgarOOYpiy3Tu1psXC1MN8b6V13bK
        ZLXUGUQ1QUGKO7IH7mFlfP42G94lBYEnNPW6/uAUj6pOXC94Ltwv
X-Google-Smtp-Source: ABdhPJybSFC7dbhNUzL7HJOrA6Rwh39AsAtnRqH3dM9c8VcGcj4oZT9LuhMAquJMwUZFq/xrv1cCl1cLEeAnjvwIF2c=
X-Received: by 2002:a05:6402:1693:: with SMTP id a19mr1850592edv.247.1642726850236;
 Thu, 20 Jan 2022 17:00:50 -0800 (PST)
MIME-Version: 1.0
References: <20220117232259.180459-1-michal.winiarski@intel.com>
 <20220117232259.180459-7-michal.winiarski@intel.com> <CAGS_qxo+Jeuoo7QQnEW883bT5z3HJqz2sCX=kzhra3UsEM9xOQ@mail.gmail.com>
 <22c46f5f-37c8-448a-6fff-2b0ec9d28fa9@intel.com>
In-Reply-To: <22c46f5f-37c8-448a-6fff-2b0ec9d28fa9@intel.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Thu, 20 Jan 2022 17:00:39 -0800
Message-ID: <CAGS_qxpt3uH4D=3pEa2pBcTr5UqtHbTGPEDFW67=6b2jrumvvQ@mail.gmail.com>
Subject: Re: [RFC 06/10] drm: test-drm_dp_mst_helper: Convert to KUnit
To:     =?UTF-8?Q?Micha=C5=82_Winiarski?= <michal.winiarski@intel.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kselftest@vger.kernel.org,
        Brendan Higgins <brendanhiggins@google.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Petri Latvala <petri.latvala@intel.com>,
        Arkadiusz Hiler <arek@hiler.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Jan 20, 2022 at 4:49 PM Micha=C5=82 Winiarski
<michal.winiarski@intel.com> wrote:
> > Tangent:
> > It might have been easier to do that if the kunit assertions returned p=
ass/fail.
> > E.g. instead of having to do
> >
> > if (!<long-condition>) {
> >    KUNIT_FAIL("<long-condition> not met");
> >    return;
> > }
> >
> > if we could do
> >
> > if(!KUNIT_EXPECT_TRUE(long-condition))
> >    return;
> >
> > or if there was a new macro type
> >
> > KUNIT_EXPECT_RET_TRUE(long-condition); // like ASSERT, but just return
> > from this func on failure
>
> This would simplify a bunch of other tests as well.
> On the other hand - EXPECT_TRUE returning a value is not something I
> would expect :)

Yeah.
It felt painful to type that out :)

But I felt the same need when looking at converting some other selftests ov=
er.
It definitely feels like there's room to make these sorts of helper
functions better.

KTF solved these by allowing asserts to `goto` or `break`, e.g.
https://github.com/oracle/ktf/blob/63c19dead80de9cd654b08120d28a04f24174f4b=
/kernel/ktf.h#L560

I had floated the idea of KUnit having a
KUNIT_ASSERT_GOTO/KUNIT_ASSERT_RET (return)
macro, but these would add yet another dimension to the macros (EXPECT
vs ASSERT, _MSG vs no _MSG).

But I have some patches out that delete hundreds of lines from the
assert macros along with some others I haven't sent out publicly yet.
Maybe such a thing would be more palatable after those land?

But for now, I think they can either just print enough debug info so
that the failures are obvious (like this does), or they can use
kunit_err() to print out additional info (like you do in other patches
in this series).

>
> Thanks!
> -Micha=C5=82
