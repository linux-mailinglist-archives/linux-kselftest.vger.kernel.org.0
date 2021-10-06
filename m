Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FA2D424394
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Oct 2021 18:59:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231317AbhJFRBS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 6 Oct 2021 13:01:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbhJFRBS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 6 Oct 2021 13:01:18 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA41DC061753
        for <linux-kselftest@vger.kernel.org>; Wed,  6 Oct 2021 09:59:25 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id a11so2130696plm.0
        for <linux-kselftest@vger.kernel.org>; Wed, 06 Oct 2021 09:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mqaPyN17NjXVoG/gNUtKAvMoZ8+ulh+88z1SV9+12xE=;
        b=BYKN2VHaAmXZLVgq1UN36v7yVsoFefS8C8VigcuoqiYVw+F/O+VpFMRN2/tmiGKsHz
         GA4i5CaAQatPZ5+/aeltZMrsMXPipQ/AL/prvV34hRIlomT4vOw9Xhpz5yhRwNCt7ccQ
         +B0z0UdV8Wxiiph7VBpjxKg3uWIiChl39E6wk+MR/kEEEHiu1NhMp5YzvLUBcsbo6Qx3
         X1EPp23TGFE63ERTq5VXTGuv30SR3UYucP4aghl/kkMnWlj0J/+8jIGKphG2YWdlFQWc
         P9Fe9fJ8wSTPY37w0Qed1R2qpFP/XLNrmiaLTziUWqeP6sfWJw5I62EWiE3fNAWefWLR
         r4nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mqaPyN17NjXVoG/gNUtKAvMoZ8+ulh+88z1SV9+12xE=;
        b=FKkFq5WLv18gLVXdqJuhH8oOD3X8rD2Q+XgKlRKi0VEc4I/YGZnV9yZcSeioguNZqH
         8O2ZGMPaFXEONB1s5xFe000wEkTQrtWTG3Ylk5x/0VHrWRSc+Ws2aVAySsGeEBVd441U
         1WzrTUWgAez1/6pzi69rsoAiWjMej3fmSobgE33amIwyks8UTfbOdjqmtrHrnPXfg5VP
         uomwMmFGZvQicNyMERy4O+2FogpXVIjdu4XnqOBmfDNq/7gZVR2gu6LSPB8gXEEjxM38
         Wx3+xbDsfSG3hKS/ClWmHwVuOpjQ9dHEmqPYxOoZZgmLTMeHov4QJInZE1fEDSRfzLdr
         E25g==
X-Gm-Message-State: AOAM531BLZanMiKHM9iCzVjRpFTlp6/zCPxzGRYFYEGwsMaZiT7J0wD+
        i79WV72IOUhY9CjLv70IYpkmz+s4jVkJ8Hm3dbxqgw==
X-Google-Smtp-Source: ABdhPJyHGmwPIdRFgzcCHHwheumGZW4Dy27xvfU+aHThaSx5TrF4zqts49YF0ybB2RoAH0EbKWQOvdCrSQkJcTTQCdo=
X-Received: by 2002:a17:90a:e7c8:: with SMTP id kb8mr11974176pjb.95.1633539565107;
 Wed, 06 Oct 2021 09:59:25 -0700 (PDT)
MIME-Version: 1.0
References: <20210930222048.1692635-1-dlatypov@google.com> <20210930222048.1692635-3-dlatypov@google.com>
In-Reply-To: <20210930222048.1692635-3-dlatypov@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Wed, 6 Oct 2021 09:59:14 -0700
Message-ID: <CAFd5g44YUDhGaskMFGi5-LyQ5bzgArZSSwvLUcg+GgA1ssA6kQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/4] kunit: tool: factor exec + parse steps into a function
To:     Daniel Latypov <dlatypov@google.com>
Cc:     davidgow@google.com, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        skhan@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Sep 30, 2021 at 3:20 PM Daniel Latypov <dlatypov@google.com> wrote:
>
> Currently this code is copy-pasted between the normal "run" subcommand
> and the "exec" subcommand.
>
> Given we don't have any interest in just executing the tests without
> giving the user any indication what happened (i.e. parsing the output),
> make a function that does both this things and can be reused.
>
> This will be useful when we allow more complicated ways of running
> tests, e.g. invoking the kernel multiple times instead of just once,
> etc.
>
> We remove input_data from the ParseRequest so the callers don't have to
> pass in a dummy value for this field. Named tuples are also immutable,
> so if they did pass in a dummy, exec_tests() would need to make a copy
> to call parse_tests().
>
> Removing it also makes KunitParseRequest match the other *Request types,
> as they only contain user arguments/flags, not data.
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>
> Reviewed-by: David Gow <davidgow@google.com>

Acked-by: Brendan Higgins <brendanhiggins@google.com>
