Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D79BA2F6E27
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Jan 2021 23:26:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730724AbhANWZN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 14 Jan 2021 17:25:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730356AbhANWZM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 14 Jan 2021 17:25:12 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71E39C061575
        for <linux-kselftest@vger.kernel.org>; Thu, 14 Jan 2021 14:24:32 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id n25so4748294pgb.0
        for <linux-kselftest@vger.kernel.org>; Thu, 14 Jan 2021 14:24:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gRC5Pleb9dUxv3nJaqlApsE2Yyj1i5/5CS0p59ghBkc=;
        b=NuA3EJ3p4xB56QjPMOsEQQMUhXG3PQ0y8iWnVaCIXTapcQ7PX3/QSUg5osssQ6nGaj
         nXJUe4amtRfx6WBlML3wsytOVgXf5u3kqra+2KdixvTHv9z4lABT8g0mk1lW/SojZ+EK
         PkMKhJ1T1u6iB1YcKAH8AE+8Gu9QaZ+l2SS3rakd67ORcNMQNvVx9KN2dJBgTVTgrAK8
         JV11HngiDjErzuUzkePUoq+HBWMAR52Q6rYRdwVXEq/tpnvwFg8N9r0Ne1j8nKhdHvax
         m9qmj+a0tvXZHGHElR23N6c2euo8y2gB7BYZCAGbPbnESrxtBxA/D52GWNDgkwbgA+Jp
         u/FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gRC5Pleb9dUxv3nJaqlApsE2Yyj1i5/5CS0p59ghBkc=;
        b=BfXpfMNL2PFvpdJzRfkLF8aW5RNASSZnB1wEJ2Z9AUO/KAlWSYZPYut/uda2DeaYUN
         uiK7IMyJ5UURiwcIbFffk98+lpcCwPPqL8RQ5GVG5k66UsXgKzFKrQvyl4huFvWvU0u3
         +CAcf/IscS9id+PxErzQZYjs4n6jS7eWrtgyLh2co9IjnX/A3YRcJGIqyFUKkmeqfwj5
         a6dTnOkjcl1uUUjYMi0k3JX2JZ/gi5NGdgjB2Y9UntoJZuGsAf1lAC/IWeMnN2AzzrGS
         X48h53XhiF+hm9tvOzmv/bz4igPFkIn1yJJinBUpuTW44j8f1pHhvuyo5gScb5FVc30j
         0vmw==
X-Gm-Message-State: AOAM5339UWXwYkpB+xk5DanKEZm9JYnUNm9r+DzsGdxmYZHg8xjNuBv4
        ONMJPmFzIAbxzkR2BFm54UT6ZdBm19rV4rByRvXjZg==
X-Google-Smtp-Source: ABdhPJxY9okKFIOu7O3uhTD28hz1VT6/8eJsX891SLMhHJQ2T++lZwV0wgQ+6dCV2/GwDFou+QUuaN6E2MdsZSWNbcY=
X-Received: by 2002:a63:c84a:: with SMTP id l10mr9703913pgi.159.1610663071797;
 Thu, 14 Jan 2021 14:24:31 -0800 (PST)
MIME-Version: 1.0
References: <20201202190824.1309398-1-dlatypov@google.com>
In-Reply-To: <20201202190824.1309398-1-dlatypov@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Thu, 14 Jan 2021 14:24:20 -0800
Message-ID: <CAFd5g44+y-n3v_As8J2piVu+fyLCXCgHx1zmuo0mfb+VKkSUBQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] kunit: tool: fix unit test cleanup handling
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

On Wed, Dec 2, 2020 at 11:09 AM Daniel Latypov <dlatypov@google.com> wrote:
>
> * Stop leaking file objects.
> * Use self.addCleanup() to ensure we call cleanup functions even if
> setUp() fails.
> * use mock.patch.stopall instead of more error-prone manual approach
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>

Tested-by: Brendan Higgins <brendanhiggins@google.com>
Acked-by: Brendan Higgins <brendanhiggins@google.com>
