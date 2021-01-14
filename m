Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C6C12F63F3
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Jan 2021 16:13:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729125AbhANPM7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 14 Jan 2021 10:12:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729068AbhANPM7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 14 Jan 2021 10:12:59 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64BD7C061757
        for <linux-kselftest@vger.kernel.org>; Thu, 14 Jan 2021 07:12:18 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id k10so4831089wmi.3
        for <linux-kselftest@vger.kernel.org>; Thu, 14 Jan 2021 07:12:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kBGX+T/nUpbDAUJb5D4Xd4HLcz1wI0XbFT/wkU7AZ2w=;
        b=GUTI3PNCNsj+/QXxIkEVbWJCC9QMtvyaEjYn4bN5gNKpxMv0LLzadv1QY10cEEx7wR
         Q390OoA37uoZQ/cLz8pOzgQ4+QKmCcsQra/Y++yYY204JVbudEPwN+Os2Uoulr96RK1P
         IuVQI01B6Luoq5MtkvvtCIjbdeqpVbkUvLiMZf1j/y3IPGbpL73IvS8ZZ1dZlDCmQ3em
         KIfFF5UEIhb3xbKjblxsa539Gir80GLBFxADW3SKrELdrBlkplFlzvJ3ZRMiwoz+QOQ5
         eMwSjfsrsIqOeVDQWVHwKfOq80gIxHrN+Il6dpNpvrattLP0UxekMGhXrRSQlX34hDXJ
         Qhrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kBGX+T/nUpbDAUJb5D4Xd4HLcz1wI0XbFT/wkU7AZ2w=;
        b=hb3vVH2kYAaHeUi7HP2gIzRnHx5cmaoI0h7nrxpjEF61QDAkstSyqrkoKe+jBGwc40
         reCWVV+gOAOksjNKYmrDZpVDqBOFDYymqV9jAOgcgf0zpNalX9actc1dlbRk1jznD8Zh
         uachLZ4tgPJtimHmX+/2YqaGO7ySaWCaPOU+QEk6tSMecmJabO+0Sy90/OPV/WaxiX2P
         I893Q/+Mm+wTfrAlQIBupDYQ5EOY4lb4dq50dUaM7y1Xm1AmEM0ormxGdT+YyR+FH7+N
         Y67I5EmWWMpcfPTDXNHwj9/nP2czJA2TitUj+3FVGtNYgrFYjDayNwAHwpskdD+cqMws
         2YjQ==
X-Gm-Message-State: AOAM532za+aJv0L4zFRk6mg4amcB/O8xuVN3TpLM81xbtfflixycyLGB
        Vj1esJ60/uZ78cz4c8Rwvxb/k0/BPhGxpfNbXSRI8w==
X-Google-Smtp-Source: ABdhPJxD+gZQ18YWuLpswN7xfWgJaSU9o6zr4ikxgEjS0q8DG7825uh6yRHmP4fOBTKhgdT5PSNcs9bqCrCqSc4Q8gY=
X-Received: by 2002:a1c:46c5:: with SMTP id t188mr4409187wma.3.1610637137068;
 Thu, 14 Jan 2021 07:12:17 -0800 (PST)
MIME-Version: 1.0
References: <20210107025731.226017-1-warthog618@gmail.com> <20210107025731.226017-6-warthog618@gmail.com>
In-Reply-To: <20210107025731.226017-6-warthog618@gmail.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Thu, 14 Jan 2021 16:12:06 +0100
Message-ID: <CAMpxmJUok4oJHG169yAzREnu+hiMsf2Fx1oJGjzitWk3YS4VUQ@mail.gmail.com>
Subject: Re: [PATCH v2 5/7] tools: gpio: remove uAPI v1 code no longer used by selftests
To:     Kent Gibson <warthog618@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        linux-kselftest@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Shuah Khan <shuah@kernel.org>,
        Bamvor Jian Zhang <bamv2005@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Jan 7, 2021 at 3:58 AM Kent Gibson <warthog618@gmail.com> wrote:
>
> gpio-mockup-chardev helper has been obsoleted and removed, so also remove
> the tools/gpio code that it, and nothing else, was using.
>
> Signed-off-by: Kent Gibson <warthog618@gmail.com>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> ---

Reviewed-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
