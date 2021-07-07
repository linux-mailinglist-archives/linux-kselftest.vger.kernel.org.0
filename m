Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C2E63BF0B6
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Jul 2021 22:23:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231192AbhGGU0M (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 7 Jul 2021 16:26:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230120AbhGGU0L (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 7 Jul 2021 16:26:11 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AA58C061574
        for <linux-kselftest@vger.kernel.org>; Wed,  7 Jul 2021 13:23:29 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id x3so1719718pll.5
        for <linux-kselftest@vger.kernel.org>; Wed, 07 Jul 2021 13:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=CAEtVxPRpTfZqh5hqvBmB3c4I+JeBfEKCnxrY6RWA7I=;
        b=qeZAdJgXGEun76vW3du8kTjapq0Yddji6rd4o9kbPQBBkVPJy6fyxrTaslwRHAZsnw
         V619xp+nq44OfuuuY9ur5xyejrU3tCHLY+zasDD2VM06k0MBXcZ6j83xWJAkKC5b/jcA
         9qVfS5KySXF8XaVOHd54Rwvh1iWLukPdbYJ5QGnl79aUs1yCcXnLHEhZNe2zqoSNnvMA
         tD63Dq1kcjbUodN6ZNN+upDAH+PBVXOJBnM+XNX35qAcvaWERUlUdC742pEAH3yE2EsF
         ACzHjO28yCP8DeohyYRU3lctE5p5MkNhgTjSB8ZDogNCcXlMA7AXZ740ceLj3rDAs+19
         bKmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=CAEtVxPRpTfZqh5hqvBmB3c4I+JeBfEKCnxrY6RWA7I=;
        b=lp9JYkQFNdZHvw0h8dauRMThhhNbkSnjNWef7TsnGrCE01hRDg81CysDRl5gbgXuu4
         ydjKZ6QLdUQldndUNdYep0SrclJV3IudB7JWZ5WjEKM+2EsOjoCEeDF4wzkJm/ZGaTvI
         Z2NV3q4J16s5H+APA5KO4Z0L9sjo70jOGFtuPXkLSsm9397Ha5twXmKzOlNUFKmjYFIc
         FlqLKLLnT0feFu8DMjRk4wJUxq4N1zXEjNhbY2w2AlCy4nj23IyEwZnHYDkVailScN7G
         R9Jg43BxY510EYCEVxEBJ/A66ywjGCOHFXcOZZk/AD0G65VoeeSnzOGafVfAmahzXWuX
         bq2A==
X-Gm-Message-State: AOAM532HcoQs0usQyZ4QIAMtiBIt+H4AIdMyZHT1bKWmoz0bmjoifGZ+
        jXm1ZE9/zex5tyQ83tWQDVwiZCTJ3LuaAxLiDB8kYA==
X-Google-Smtp-Source: ABdhPJyvGJA54hO4xO7z7L9z2V7r4Symc8wcE41tma6CDJsvC3TRnrc9Zkdt0cFbO0gDJok2IeIEhe7IW8uWYQaFJ2c=
X-Received: by 2002:a17:902:d104:b029:129:1a18:c249 with SMTP id
 w4-20020a170902d104b02901291a18c249mr22366909plw.80.1625689408870; Wed, 07
 Jul 2021 13:23:28 -0700 (PDT)
MIME-Version: 1.0
References: <83ff3ed3-e004-29b2-b23c-a2ba4d5a3f7f@riseup.net>
In-Reply-To: <83ff3ed3-e004-29b2-b23c-a2ba4d5a3f7f@riseup.net>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Wed, 7 Jul 2021 13:23:17 -0700
Message-ID: <CAFd5g45rE4+ChY86KN7wPcjGtQAwUqQWccEMMWW-=7mz2oTwGg@mail.gmail.com>
Subject: Re: KUnit Hackathon
To:     =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@riseup.net>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        David Gow <davidgow@google.com>, kunit-dev@googlegroups.com,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, ~lkcamp/discussion@lists.sr.ht,
        =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <n@nfraprado.net>,
        Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
        Leandro Ribeiro <leandrohr@riseup.net>,
        kernel-usp@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Jul 5, 2021 at 1:41 PM Andr=C3=A9 Almeida <andrealmeid@riseup.net> =
wrote:
>
> Hello,
>
> We belong to two student groups, FLUSP [1] and LKCAMP [2], both of which
> are focused on sharing kernel and free software development knowledge
> and experience with fellow free software developers and newcomers.
>
> As part of our efforts, we'll be organizing a KUnit hackathon in the
> next Saturday (July 10), where we intend to help newcomers convert
> existing runtime tests (the ones found at lib/) to KUnit and maybe
> create new ones. Depending on the number of attendees, a high volume of
> patches may be sent throughout the day. We will do our best to review
> all patches before they go to the kernel mailing lists hoping to avoid
> wasting your time with minor patching issues.

That's awesome! I'm really excited!

> So we wanted to let you know of all this beforehand and give you the
> time to send any suggestions or comments on all this. For instance, we
> may ask people to add a special tag to their patches so you may batch
> review them all at a later time if you wish.

I wouldn't worry about it until it becomes an actual "problem"; too
many patches is a good problem to have :-)

> Anyhow, we'd really appreciate having your opinion on this.

I don't think I have anything to add that Daniel didn't already add in
his reply. Also, I have seen Marcelo around for a while. I have to
say, I don't think I have seen a student group this involved upstream.
I am impressed :-)

> Thanks!

Thank *you*!

I wish I could offer more material assistance, but with only a week's
notice, I don't think I can. I will try to be online periodically
throughout the day, but I am afraid I cannot promise anything.

No matter what, we would be somewhat limited with what we can do in
2021 because of COVID. No promises, but if this goes well maybe next
year we might be able to send someone in person if that's something
you would be interested in.

Best of luck! I hope it goes well!

> [1] - https://flusp.ime.usp.br/
> [2] - https://lkcamp.dev/
