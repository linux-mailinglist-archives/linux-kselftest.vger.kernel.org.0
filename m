Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4EF54E5A8D
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Mar 2022 22:18:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238753AbiCWVTu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 23 Mar 2022 17:19:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240628AbiCWVTu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 23 Mar 2022 17:19:50 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5820B657AC
        for <linux-kselftest@vger.kernel.org>; Wed, 23 Mar 2022 14:18:19 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id yy13so5423042ejb.2
        for <linux-kselftest@vger.kernel.org>; Wed, 23 Mar 2022 14:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z1Qm/xWajAQvpOZlmnrukkZ7JdrDgtUoxCQlGKyuh5U=;
        b=UbU3IchqOSbL8EEbMNtmXsuoC1/FTLGH6pO+dap0VXthIz6znxWEVr2M26nLce7okY
         oYmlfXSzaQnGa0o6S8KaNocwHTX693Ve2k95gxr8ek5Tceu/1tUWWzO2IKfVa4VUMS6v
         5ZiLHU6oN6vQss/42ZtYbWqYaOc89mQSSMzYWYojEbsvkbAl7HzdpngskSs4YRlPIvIu
         C1Ov3adXe5a1TSQ6PVBTYCZi0gVtBgVZP4n6a6p9aea1PsR7a6eqQSScjSvv80pDzTsO
         M8FQrnBg9SRPUQ5Vrtb1X3uNkcS3IVG32sbEwcVZCE3dq1ZtoY9zv1bbG/twCY3AJ8gf
         ABEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z1Qm/xWajAQvpOZlmnrukkZ7JdrDgtUoxCQlGKyuh5U=;
        b=Vj7eLWji1lXFNrb1e01POvA/T9YSDdX20/+glNGZE7h6Y6KBf41u1mggorEVSzQQPb
         tWzd6sLEX5LpH/krPzq4y7sZA5XsR8DzXdVfK/wt3aCW11/535+8Dn8mNMc+l2RGZBf0
         R1Jhk5u2QAjcomluuxhsy2d2d3x2i4V18VZiNFifBnPjt7fP0robmSZfaJNqAOiIKm/S
         e8LD2X1IK1BeI7q2EGmZ+0EhdDiuyh9AjGxqkijphpn/U26gXh8+qZYKi2PvMKpe/VwP
         /2DN4Aec0gXsYmtlWhrjSv9AiynLTJ6yhSSj4J1nP+McZL+WL9h7ZC4E9U/JaPtLw0dA
         IJRA==
X-Gm-Message-State: AOAM531XoP/6AS4naAumkLzJIUNsTfiHI+qnm7uQ4St0+3cFhvQwExg6
        m1TmIEn+abhckjJKWVLa/1EhmrX0Ag4d73SmfZ5HXQ==
X-Google-Smtp-Source: ABdhPJw8nWb+4OFsmiLRDXTmTdIAYxfmSuS8bITQobqBjeFvR0ILIVWZuoPKLxgIQ5kx+3LYeoXsO/0xMzQjx8Rz+aI=
X-Received: by 2002:a17:906:c14b:b0:6da:b30d:76a0 with SMTP id
 dp11-20020a170906c14b00b006dab30d76a0mr2199044ejc.279.1648070297760; Wed, 23
 Mar 2022 14:18:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220211164246.410079-1-ribalda@chromium.org> <20220211164246.410079-6-ribalda@chromium.org>
In-Reply-To: <20220211164246.410079-6-ribalda@chromium.org>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Wed, 23 Mar 2022 17:18:06 -0400
Message-ID: <CAFd5g44Rcb9bJyehjqW29wAvaY0hQyDmPWH+XJfN_Hu+=2Yrcg@mail.gmail.com>
Subject: Re: [PATCH v6 6/6] apparmor: test: Use NULL macros
To:     Ricardo Ribalda <ribalda@chromium.org>
Cc:     kunit-dev@googlegroups.com, kasan-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Daniel Latypov <dlatypov@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Feb 11, 2022 at 11:42 AM Ricardo Ribalda <ribalda@chromium.org> wrote:
>
> Replace the PTR_EQ NULL checks with the more idiomatic and specific NULL
> macros.
>
> Acked-by: Daniel Latypov <dlatypov@google.com>
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>

Acked-by: Brendan Higgins <brendanhiggins@google.com>
