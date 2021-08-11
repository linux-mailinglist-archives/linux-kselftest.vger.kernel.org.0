Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8541D3E9A19
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Aug 2021 22:53:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230089AbhHKUyA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 11 Aug 2021 16:54:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbhHKUyA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 11 Aug 2021 16:54:00 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DD42C0613D3
        for <linux-kselftest@vger.kernel.org>; Wed, 11 Aug 2021 13:53:36 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id t7-20020a17090a5d87b029017807007f23so11603125pji.5
        for <linux-kselftest@vger.kernel.org>; Wed, 11 Aug 2021 13:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4jEgkWCU9y4Rnu8kdS6birld0TkC6w5rnKBfpu8sNtc=;
        b=MuRdiMj2Ejckmk8D9amHgFMWIJInp4iTZhKV3yYTIPChZNbZGMRUmJbYW6smLGMlIz
         Q59DqgBwPLorE5uch8gp+1qvvpwG9hQ+Xp7ihF6AgSsfedTnv94o6aa/cuaFKtPVrtQs
         1PZoCi3Ts6+HM9AtvQbPLFFLkX80GaMGYm/nrhZn7tTeoQGdRK87EagdE1nSQonH91jE
         q/XpTetEVA/W5UC8w/EeMofZbNeKS3kf9RbFMwFZsfgEXNrRE+h1IF43n/El75/HvM0/
         53yiJrp+VAFWv5lCpb2UgSAgoGbY6wmC8t2ZVDLDdxOUDh0Oln21C5GAYolIb/tCbGrv
         buRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4jEgkWCU9y4Rnu8kdS6birld0TkC6w5rnKBfpu8sNtc=;
        b=Teu1eUbAx3R8T9K77jGLrTsx2IxrS52gBcPDbBmuKAe37QbM/dpoyCIyd6sPREN5DB
         H9MKBJKJy0dT7KoxeX7bQ91iF9cYbeSPcax3AlDUFGl9gHd56kbfk9iiydqYLg9ZffAx
         PagmgpnsgJtyH9S4WojTvT1kLCuf0qAJJnGgvE2OLvVPpC/bsE+dLBagNmBmm/WkXzs3
         lHIiRRSoeoE/EjveyQevW+Lh+Djnzaw2MD0IjS2najzwiiSFiAgSOWEcw2aZ8FSZRLDR
         38QHEnuK2cRy2mA7djtgby7SFf7S35CMLIHtT1JErYfVXKLAcC+YdM46UWP237V9+xi1
         yvzA==
X-Gm-Message-State: AOAM532Hd60SXhcDG5eIsZerPy1/C7DJ0C07rA6XJEa2IbAMEgKbZr+B
        pMTdUZm7XHhOFsAh+9gA/+wzSTPkmKY+Qn7sf1ENSg==
X-Google-Smtp-Source: ABdhPJzbB7mUtizyZfWEGecSDx8ABVAm/e76AFOlfpCjEWbKGiQaOmZWoZ3C6p7B77SQDOQ8EEP8uja+JWsSDCR+V8Q=
X-Received: by 2002:a63:f62:: with SMTP id 34mr582085pgp.159.1628715215272;
 Wed, 11 Aug 2021 13:53:35 -0700 (PDT)
MIME-Version: 1.0
References: <CA+GJov6tdjvY9x12JsJT14qn6c7NViJxqaJk+r-K1YJzPggFDQ@mail.gmail.com>
In-Reply-To: <CA+GJov6tdjvY9x12JsJT14qn6c7NViJxqaJk+r-K1YJzPggFDQ@mail.gmail.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Wed, 11 Aug 2021 13:53:24 -0700
Message-ID: <CAFd5g44x9i2KfuJTfRpd6doqsLEbEZS0Gj=e4DvPU8Z-L4ga1Q@mail.gmail.com>
Subject: Re: RFC - kernel test result specification (KTAP)
To:     Rae Moar <rmoar@google.com>
Cc:     David Gow <davidgow@google.com>, Tim.Bird@sony.com,
        shuah@kernel.org, Daniel Latypov <dlatypov@google.com>,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Aug 10, 2021 at 4:25 PM Rae Moar <rmoar@google.com> wrote:
>
> We are looking to further standardise the output format used by kernel
> test frameworks like kselftest and KUnit. Thus far we have used the
> TAP (Test Anything Protocol) specification, but it has been extended
> in many different ways, so we would like to agree on a common "Kernel
> TAP" (KTAP) format to resolve these differences. Thus, below is a
> draft of a specification of KTAP. Note that this specification is
> largely based on the current format of test results for KUnit tests.
>
> Additionally, this specification was heavily inspired by the KTAP
> specification draft by Tim Bird
> (https://lore.kernel.org/linux-kselftest/CY4PR13MB1175B804E31E502221BC8163FD830@CY4PR13MB1175.namprd13.prod.outlook.com/T/).
> However, there are some notable differences to his specification. One
> such difference is the format of nested tests is more fully specified
> in the following specification. However, they are specified in a way
> which may not be compatible with many kselftest nested tests.

Thanks for putting this together, Rae! I would definitely like to see
us moving forward with standardizing fully on the KTAP spec.

I am surprised to not yet see any comments here.

I was thinking that this might make a good BoF topic at LPC, but I
guess that depends on how interested people are in this topic.
