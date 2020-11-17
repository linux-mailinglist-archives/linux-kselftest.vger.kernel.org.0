Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D92742B5A35
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Nov 2020 08:21:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726338AbgKQHVH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 17 Nov 2020 02:21:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725943AbgKQHVH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 17 Nov 2020 02:21:07 -0500
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09D46C0617A6
        for <linux-kselftest@vger.kernel.org>; Mon, 16 Nov 2020 23:21:07 -0800 (PST)
Received: by mail-lj1-x243.google.com with SMTP id p12so23108052ljc.9
        for <linux-kselftest@vger.kernel.org>; Mon, 16 Nov 2020 23:21:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=80Js5MzpHp2BBoeVGpXRsYdQ6UcFRe8F27UXWyhna1Y=;
        b=AZI9q7Hh5V0M3ulX5rXXq94IdrHcPbKhKzMBw8pHrITVB6DhBINSuSLKZM56RV08Ut
         zePZpSkaopondOCx+ODPU34lvDF/Qa8tF2O3CDRuL36QlTT7cpy+xdRayULsVWPpwV/q
         VTu0648DGbdPC+1Gycuz14zyTF0aFXT3C7KHogy6bm8ZP8QBV+Sk9XWrSyCHB3afX+4f
         O417S8E0LRdNxUzquMgDuoWrcOsuEHEB64DYSWU3mHUQdS25kVEezV8KUCjIUbCPX6kr
         WuY9jLzfi42uTOpIJ0kXXEkSnf3Dt4Upw/vhj9JcSBNkt1TbhtlO4QK5HMZ4Y0HZYoLi
         Uzng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=80Js5MzpHp2BBoeVGpXRsYdQ6UcFRe8F27UXWyhna1Y=;
        b=PZiKZxP1+vBwhGeATD4MptGTlZdNUb7T45NodHEqVycc0EHlqypHYORkBzjFkxcSk6
         7BgU+qlpIU9SdQuYaJj8NeA+deHiYqgPV0evBG1LhxdJ+hzpMueOJaqXVDSKBxj10epQ
         qSpF5+/D/PaPWGuNyFQJkZuKzgQ++1shAkSVqoVsN+bokorGKqiw7VVT/qyrwaJAhu87
         OgfoxONse9znezFVQZyA/PeWwLHxolDeCjRAU5+C+omwO+iJfNFjCCQf8l8Tbpq95WMD
         kspm38UHnidqFSUdtbgZ5jUSjj74iAiS1LJ69It5UiaUzb99x25QmvnBNSfltZENe7d4
         7oYw==
X-Gm-Message-State: AOAM531mg1vwc+dXp/tmcO5SmAr3RH7rs1fzNx96A4gYd1wNErFQXb3U
        Zs9wSo3HixbwhCBV0VDa8AADBsYiYS46lj7jvuXqMw==
X-Google-Smtp-Source: ABdhPJywGgbQ9i2Pw0CnqEmzP1/KTa/qYi1ggHVULwNavreJq3J/8m6hrHchGZDgMVWmiB61tHAZNSCM4ssJCrw8kg8=
X-Received: by 2002:a2e:8504:: with SMTP id j4mr1204429lji.169.1605597665336;
 Mon, 16 Nov 2020 23:21:05 -0800 (PST)
MIME-Version: 1.0
References: <20201116054035.211498-1-98.arpi@gmail.com>
In-Reply-To: <20201116054035.211498-1-98.arpi@gmail.com>
From:   David Gow <davidgow@google.com>
Date:   Tue, 17 Nov 2020 15:20:53 +0800
Message-ID: <CABVgOSkoQahYqMJ3dD1_X2+rF3OgwT658+8HRM2EZ5e0-94jmw@mail.gmail.com>
Subject: Re: [PATCH v9 1/2] kunit: Support for Parameterized Testing
To:     Arpitha Raghunandan <98.arpi@gmail.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Marco Elver <elver@google.com>,
        Iurii Zaikin <yzaikin@google.com>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        "Bird, Tim" <Tim.Bird@sony.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Nov 16, 2020 at 1:41 PM Arpitha Raghunandan <98.arpi@gmail.com> wrote:
>
> Implementation of support for parameterized testing in KUnit. This
> approach requires the creation of a test case using the
> KUNIT_CASE_PARAM() macro that accepts a generator function as input.
>
> This generator function should return the next parameter given the
> previous parameter in parameterized tests. It also provides a macro to
> generate common-case generators based on arrays. Generators may also
> optionally provide a human-readable description of parameters, which is
> displayed where available.
>
> Note, currently the result of each parameter run is displayed in
> diagnostic lines, and only the overall test case output summarizes
> TAP-compliant success or failure of all parameter runs. In future, when
> supported by kunit-tool, these can be turned into subsubtest outputs.
>
> Signed-off-by: Arpitha Raghunandan <98.arpi@gmail.com>
> Co-developed-by: Marco Elver <elver@google.com>
> Signed-off-by: Marco Elver <elver@google.com>
> ---
[Resending this because my email client re-defaulted to HTML! Aarrgh!]

This looks good to me! I tested it in UML and x86-64 w/ KASAN, and
both worked fine.

Reviewed-by: David Gow <davidgow@google.com>
Tested-by: David Gow <davidgow@google.com>

Thanks for sticking with this!

-- David
