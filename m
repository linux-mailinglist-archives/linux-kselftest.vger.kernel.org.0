Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08FE2421A2B
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Oct 2021 00:36:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236131AbhJDWhs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 4 Oct 2021 18:37:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234726AbhJDWhs (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 4 Oct 2021 18:37:48 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2AFEC061745
        for <linux-kselftest@vger.kernel.org>; Mon,  4 Oct 2021 15:35:58 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id v11so5361374pgb.8
        for <linux-kselftest@vger.kernel.org>; Mon, 04 Oct 2021 15:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8uaE9HDTOUUo8BWU+rWF2e2nUlYz2tVlpUOAfTOuVBQ=;
        b=GH6CRGau4NhqYUK5sqfnr5nxv5YxfGeeZaU19MjLoQZkGUuJQovhIlmNY1IpmCpbxF
         2XSl57HPpD2qO+RZraMru4hFi/aOCBDijRY8s4zQFfxXu52IPUuWB2R6rOe6dacIHkUv
         /POGXwX5R6OUPhCjF5VpRDHEF0zT3BeMWdV0w1nRkj1mZuIlBtcLnQyJxN3dijPcu6wf
         c5ZiEGJIkJ4dooULlrc2JxFisu+Brnk+ZW+J1AI/tQYwAJq7vmhzmqCWGkkjcuz5qR12
         NwxELymWVR2ljAtgFW5MGJpwSnyTVZfdDhR/Xz7Iq+hnl/lLZDv8Rw9XuJRv6iCapl9x
         N2jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8uaE9HDTOUUo8BWU+rWF2e2nUlYz2tVlpUOAfTOuVBQ=;
        b=uX3i1yIcHrSGdpJTv30RHq9N3piX27lSkVJFdPj1/K7GahkXWxH2ojl+5UjUQ7lXYo
         rx9isOEsWKlUOIeVk003DDLdOj+6PxOrobXmUvkAcZcvjXXOwAYcPJoi8S7rHK+ZEhf7
         mWFqPEiNdaA2mMCKhwd48BxjMpCtXs9OSWhw3I7TZ+lthqaqB2VUP+tGOBswZT4MsPz6
         QuiOK94iP1QhF+S6vGadWKpB6LRaKBj3CGiuGBughFCGH/MUIIk0JZ1U3gCnhKZn2tcP
         PWAJQhdrveTDZGRTz/854qvGsTktU47hIBOUU7ABOf7WcDR48y7nJa6dVxV35u8natdJ
         qWww==
X-Gm-Message-State: AOAM533lbPc4Odgi9NR/duuLRdW9oweLHHOCAQ3Vh//iHt/XLcjnf2pu
        IxH+AyDdUIC961nrfR62YWYOQoEBu3OseoC6Eb7Koy3u3GWhVg==
X-Google-Smtp-Source: ABdhPJwHTHVaOx1oZOPMTKLHFdf51wqxg2fKFia4TvB8vmaDpMVNK0jvzYagvB/XxLhRfIBfp1Rb00PKqUYjgypntWo=
X-Received: by 2002:a62:1b92:0:b0:3eb:3f92:724 with SMTP id
 b140-20020a621b92000000b003eb3f920724mr27142016pfb.3.1633386957920; Mon, 04
 Oct 2021 15:35:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210928221111.1162779-1-dlatypov@google.com>
In-Reply-To: <20210928221111.1162779-1-dlatypov@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Mon, 4 Oct 2021 15:35:46 -0700
Message-ID: <CAFd5g45OdZ-u7Z4iy8DoEbEMVp5c6YkVf0L8yqUewZ=z+NcuNg@mail.gmail.com>
Subject: Re: [PATCH] kunit: tool: misc fixes (unused vars, imports, leaked files)
To:     Daniel Latypov <dlatypov@google.com>
Cc:     davidgow@google.com, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        skhan@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Sep 28, 2021 at 3:11 PM Daniel Latypov <dlatypov@google.com> wrote:
>
> Drop some variables in unit tests that were unused and/or add assertions
> based on them.
>
> For ExitStack, it was imported, but the `es` variable wasn't used so it
> didn't do anything, and we were leaking the file objects.
> Refactor it to just use nested `with` statements to properly close them.
>
> And drop the direct use of .close() on file objects in the kunit tool
> unit test, as these can be leaked if test assertions fail.
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
