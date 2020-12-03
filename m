Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBEC42CCE64
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Dec 2020 06:16:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726140AbgLCFQ2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 3 Dec 2020 00:16:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725793AbgLCFQ1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 3 Dec 2020 00:16:27 -0500
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9B39C061A4D
        for <linux-kselftest@vger.kernel.org>; Wed,  2 Dec 2020 21:15:47 -0800 (PST)
Received: by mail-il1-x141.google.com with SMTP id f5so775634ilj.9
        for <linux-kselftest@vger.kernel.org>; Wed, 02 Dec 2020 21:15:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0T2UjYq4UBSUMGz6lYJAaVtZcmgm37SkhIDDNy2JsW4=;
        b=vu24cf5sKdq2mdtSxBorcawv5ZXvrwH7MlyE1gIoeQ9WJ2cjuZZPeYEDnrd5DKAiV5
         MOpi4o58Cru/Y4b+Vs/UpCKHWxSt/+uEnhsrclhm4G8Sw2wEjqbGyoG1T7EGSn5XZTsD
         +wPPlFbTPrByyHsWB34kI3r+ONgEfLXxDXJwuUD6n8SZ58cFUkiKBBPDNDSwsh7CqHcL
         1tS22zob33fWS/rdtG3yzILwJdOsdIn3XXMmi/fQGtQpx9rLgIAho6K4dY+jij46UMFp
         G+3m5fKJ3Ll7EMFIAF3v3yRp4frafMTHE3L6y3+Ub04ktve5qUjlMctu7ozWQnk1PCfw
         Yk9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0T2UjYq4UBSUMGz6lYJAaVtZcmgm37SkhIDDNy2JsW4=;
        b=iU38ivnOl0nHxbRqCD/mHQq3bDpJ9KNzRtxuHrrEJnrho2xyDg+ZvPa+ikZrEl9zZW
         FOdsAVaSpMrvtzZ27IQeVeVpnq1TvotBb0XCw11JvSCLDQx5QEjI/Jhz6lH+fGnumrIt
         7hB4dEYg8l+RJByEHL7zggqcFNFew5Wb5wPnkNwma4NfSH8KcjT6N6wIf9I5KVlCk4ba
         BRgnoPQ+ltL2Z1iTTZy3n/fuV6ZtIqDNoKXA/jc7WlvIZtIG8+KjHjmlC391r97ppUDP
         CCLQSiXiBTF9E3tPhX8rynLVYnWqYz1G1UgbyzWun9jDXNqhkvnuT5PGh6ZnXyqZ3cOi
         t0aA==
X-Gm-Message-State: AOAM533z3n3s0CAfKP3FoUbC8kVlc9yMUaood4U7A9R10uC0p6nbm+mP
        luhuda9kN5DutiMinrBXPletpG7wwsEYk3302US8Jw==
X-Google-Smtp-Source: ABdhPJxuiKVy82egd6udynKufvhTNmRoS1PPUdfYZA0eVelYJdnv0QGsRCGulblEB4IdDY366hWrg9QO8fliQGTV8to=
X-Received: by 2002:a92:297:: with SMTP id 145mr1538148ilc.133.1606972546057;
 Wed, 02 Dec 2020 21:15:46 -0800 (PST)
MIME-Version: 1.0
References: <20201202190824.1309398-1-dlatypov@google.com> <CABVgOSnqhes_Lu+4BRq74get5D3ya3S6XxMLqFKamqahU5-RRA@mail.gmail.com>
In-Reply-To: <CABVgOSnqhes_Lu+4BRq74get5D3ya3S6XxMLqFKamqahU5-RRA@mail.gmail.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Wed, 2 Dec 2020 21:15:35 -0800
Message-ID: <CAGS_qxqk_ez6hU4pO9yromMfTgamTjLmhgW_yWAZzueh9y6qZA@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] kunit: tool: fix unit test cleanup handling
To:     David Gow <davidgow@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Dec 2, 2020 at 7:05 PM David Gow <davidgow@google.com> wrote:
>
> On Thu, Dec 3, 2020 at 3:09 AM Daniel Latypov <dlatypov@google.com> wrote:
> >
> > * Stop leaking file objects.
> > * Use self.addCleanup() to ensure we call cleanup functions even if
> > setUp() fails.
> > * use mock.patch.stopall instead of more error-prone manual approach
> >
> > Signed-off-by: Daniel Latypov <dlatypov@google.com>
> > ---
>
> This patch hasn't changed since v1, right?
>
> It's still:
> Reviewed-by: David Gow <davidgow@google.com>

Oops, yes. It's entirely unchanged.

The only change to the entire series was a rebase + drop the second
patch in favor of revamping the test_data_path() one.

>
> Cheers,
> -- David
