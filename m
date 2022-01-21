Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB7664967CE
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Jan 2022 23:25:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231282AbiAUWZk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 21 Jan 2022 17:25:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233273AbiAUWZk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 21 Jan 2022 17:25:40 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69550C061401
        for <linux-kselftest@vger.kernel.org>; Fri, 21 Jan 2022 14:25:40 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id n8so9933671plc.3
        for <linux-kselftest@vger.kernel.org>; Fri, 21 Jan 2022 14:25:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sNBwc+5YqBlwJAB9/ODxmCPz0rJm+XA1ilU6R9x1PgM=;
        b=rQiGZUqDkxyJ69HOcPLmXuswV62OiXkPDNj0gwExWUUpX9iT3CRxo7FtrfgQU35N+r
         2/pgTs5xQRZ7rZ8G9LQELkE+V+zcVsZLCH/Iaj8hU4nzhDuXAh2WXctCJHGHqWkRGr61
         oITivmeqQuDfbK5Aerojo5ulqWWYB+EynNHfEgbw/jFWZcoMSzjb+j4TSG89O5KL/5hA
         MPYhOIwB15hmcxs+4vyiTouSNteVj6B4S16171+9hEAiWNr45z45dgOCfHHFe9NPOc9z
         uY4ckShcAuLdMMF8pGD8mq4AXkYnm9KGPQHV5BUYeBwreyGbNoOkZckvqIfypAOKjQal
         Gzww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sNBwc+5YqBlwJAB9/ODxmCPz0rJm+XA1ilU6R9x1PgM=;
        b=f7r/eo+x7vjpK4XdSoNzgqOvjVW+8eAAjXydCo9/BQ+/zQNQ0Vm4mqUi5mNF1mfIUp
         +sCsG/sOt2m9lM9DC7SePd3Rws0D5UVc2eM3GrIKrlhCvV+zicQhwpVI46VRXMQiXZPi
         qtKIWUVHttWn3QD+CAWcmfXheD7SmkM08DDX+8MM7L+PJLyoSxev2XB3yf7IpR+NJIPp
         +9W2n8cCtyPQqa0BYbhvOigOj/9T585NwMSjhVTgKzazCClrGkuoWSNUFhsJFac5ewjb
         gOdilX2DDGbge4AANQ7Wk0HCIwvS144h8QasLEIGLLbZJ+MOzcRY77dlSrZfvHETvU2c
         F5ww==
X-Gm-Message-State: AOAM533RUrBz3J11QjAxbQ8GgLFjd3G5d6WCceit+/XAw8aNx5LDtD0A
        lTzkhRE+5uLp+IUeyWoaNnUH/VG8NR2WuJBJxOzAKA==
X-Google-Smtp-Source: ABdhPJzHA3d1pY1kgrKMo6XyeWNOcvUiJqPlsPA7Ahz+QHXJnk6CcIg2J3OkyLCZFU2LRMs/nbruSYgeBepvLTPBF4c=
X-Received: by 2002:a17:90b:4f4d:: with SMTP id pj13mr2681752pjb.63.1642803939628;
 Fri, 21 Jan 2022 14:25:39 -0800 (PST)
MIME-Version: 1.0
References: <20220118223506.1701553-1-dlatypov@google.com> <20220118223506.1701553-6-dlatypov@google.com>
In-Reply-To: <20220118223506.1701553-6-dlatypov@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Fri, 21 Jan 2022 17:25:28 -0500
Message-ID: <CAFd5g44ngF4Sr6AjQRUsF6BgGUtnHJTZUCGs8VmHjMraoAg1AQ@mail.gmail.com>
Subject: Re: [PATCH 5/5] kunit: decrease macro layering for EQ/NE asserts
To:     Daniel Latypov <dlatypov@google.com>
Cc:     davidgow@google.com, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        skhan@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Jan 18, 2022 at 5:35 PM Daniel Latypov <dlatypov@google.com> wrote:
>
> Introduce KUNIT_BINARY_PTR_ASSERTION to match KUNIT_BINARY_INT_ASSERTION
> and make KUNIT_EXPECT_EQ and KUNIT_EXPECT_PTREQ use these instead of
> shared intermediate macros that only remove the need to type "==" or
> "!=".
>
> The current macro chain looks like:
> KUNIT_EXPECT_EQ_MSG => KUNIT_BINARY_EQ_MSG_ASSERTION => KUNIT_BASE_EQ_MSG_ASSERTION => KUNIT_BASE_BINARY_ASSERTION
> KUNIT_EXPECT_PTR_EQ_MSG => KUNIT_BINARY_PTR_EQ_MSG_ASSERTION => KUNIT_BASE_EQ_MSG_ASSERTION => KUNIT_BASE_BINARY_ASSERTION
> <ditto for NE and ASSERT>
>
> After this change:
> KUNIT_EXPECT_EQ_MSG => KUNIT_BINARY_INT_ASSERTION => KUNIT_BASE_BINARY_ASSERTION
> KUNIT_EXPECT_PTR_EQ_MSG => KUNIT_BINARY_PTR_ASSERTION => KUNIT_BASE_BINARY_ASSERTION
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
