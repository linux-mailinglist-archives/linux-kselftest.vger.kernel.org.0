Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 394122F219A
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Jan 2021 22:16:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727016AbhAKVQI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 11 Jan 2021 16:16:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726266AbhAKVQI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 11 Jan 2021 16:16:08 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8891C061795
        for <linux-kselftest@vger.kernel.org>; Mon, 11 Jan 2021 13:15:27 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id j13so314716pjz.3
        for <linux-kselftest@vger.kernel.org>; Mon, 11 Jan 2021 13:15:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mS2w+DBB5fq5FWrKRFlEi4QLtkNj5g+2gEs0VX75X7c=;
        b=n9wWaEdHykBtIwCE4rgA2mQ2kNrhCBy2DCUqJ/kYfiJpUuXJ5WP/9o9mQJOo8QF96t
         SmuqaEfeYNkLVoh4oxeVC+7gGDg449euxtpqecjwXks0O0OB/RkMeTNmhbcR1ti6v6k+
         fRY4MxGv9Bx96adln74uEhMRyk7+Uyzv8OIB4UpcRkh2HabTkIYeUGVOxvddUg8XUMlG
         UD5UhvdLAHVyr6kUmxZzUtUaDAz9eaWB1o7g0UOCaLp3Vfko/aSqyjct1AgSu6FwBVuE
         amqPIvUWb+s/15N9WyXbYT7xw2vEu3NNJqPY2F22YOadO6yqIX8PgwTUATGWXKzHhS+F
         OcaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mS2w+DBB5fq5FWrKRFlEi4QLtkNj5g+2gEs0VX75X7c=;
        b=C9bN1zCmAqMWWXIvBpmCyS7AZeIGwZWC8lSPPDpSXLPtvKGVqqFhsai+tV2A2xDUJV
         A9oORuTr/COlxWAOCRYAe/eN1N4jLbHbeOXiNuoxX+EPfqrSC1fe7p09PigichtLPwSZ
         DRupbzpmrd2bAcNKhkMtJe8+lEAQ1PrIvE7MgRaKU9UXqhlc4X7KuOkBUZofwZBAYFrY
         S7CClsinnZ53wxEykw/AC8QN+/RVyrSecZ5w8mri485SkeWaGSfY0cxnmBK2PfS2976u
         RVgV8A5FIlqJg3m2NSS2vVM80cnk0R5CbD+ln4xAGjhIwWhdhnk8sTpEMP9q7A9PbOwu
         K9wg==
X-Gm-Message-State: AOAM531tEfyodqHHUhdgD7GqhRKLICZU98D5/fnUZiT4jPyVOvOLvWNF
        fAeMECn9UTV17SDK8/SkVXDM5SZKnxCq11BVFwrpoA==
X-Google-Smtp-Source: ABdhPJzE1mrw7DKtcQjeXzBPHlASp6nM1YDJMJYW41Elq59fts2qz6S0s858oobAohAIkz/AexgwIQwUcz+aE0pDOIU=
X-Received: by 2002:a17:90a:de03:: with SMTP id m3mr867055pjv.20.1610399727186;
 Mon, 11 Jan 2021 13:15:27 -0800 (PST)
MIME-Version: 1.0
References: <20210107234803.1096592-1-dlatypov@google.com>
In-Reply-To: <20210107234803.1096592-1-dlatypov@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Mon, 11 Jan 2021 13:15:15 -0800
Message-ID: <CAFd5g445jpTOThTaco3p9NGO8RaWK6tw2EZ8X-Czu0ErRo6EMg@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] kunit: tool: surface and address more typing issues
To:     Daniel Latypov <dlatypov@google.com>
Cc:     David Gow <davidgow@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Jan 7, 2021 at 3:48 PM Daniel Latypov <dlatypov@google.com> wrote:
>
> The authors of this tool were more familiar with a different
> type-checker, https://github.com/google/pytype.
>
> That's open source, but mypy seems more prevalent (and runs faster).
> And unlike pytype, mypy doesn't try to infer types so it doesn't check
> unanotated functions.
>
> So annotate ~all functions in kunit tool to increase type-checking
> coverage.
> Note: per https://www.python.org/dev/peps/pep-0484/, `__init__()` should
> be annotated as `-> None`.
>
> Doing so makes mypy discover a number of new violations.
> Exclude main() since we reuse `request` for the different types of
> requests, which mypy isn't happy about.
>
> This commit fixes all but one error, where `TestSuite.status` might be
> None.
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>
> Reviewed-by: David Gow <davidgow@google.com>

Acked-by: Brendan Higgins <brendanhiggins@google.com>
