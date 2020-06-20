Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F015A202182
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Jun 2020 06:46:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725991AbgFTEq4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 20 Jun 2020 00:46:56 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:33816 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726044AbgFTEqz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 20 Jun 2020 00:46:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592628414;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cpOSxPiI1KYeec1QChoOA1RlxZ9gaEWtDQPYjJ3Uh/Q=;
        b=Z0LfXs28N42/HAe/C9qi3OmcMThsfBhojTrO+fbJqx8KMe3vedaBGtbopQ/f+HnfADX4SN
        mfXxQain6avG1zGGYltp6r2PKP3PIsPsfX8vHzj/LjZSK+YlXTa6od4WcCL1YrFSq1Ezqe
        JmkJy8VSmYeTqHSszKUAY4DnWiZnQcE=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-46-fRSK17YHOcyECYzbUOXUXA-1; Sat, 20 Jun 2020 00:46:49 -0400
X-MC-Unique: fRSK17YHOcyECYzbUOXUXA-1
Received: by mail-oo1-f70.google.com with SMTP id v9so5650985oov.1
        for <linux-kselftest@vger.kernel.org>; Fri, 19 Jun 2020 21:46:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cpOSxPiI1KYeec1QChoOA1RlxZ9gaEWtDQPYjJ3Uh/Q=;
        b=nahcD5M7v0KisT0q2a5WbrtGPx33gdLD/4Vh0jlqBgmvbmq1G9PPUHqARnvexpfSU9
         FMGyTEOn62lmdTBCwPVg92HkXodGQaOOh0Uw5IazigqWxaR1fq6PBL1ccb9zgbeIu3Ac
         bmDulGHptkDKRdtIRI+rxSZJ7058H/ud+frUT68mcPSZGBGWVVEsfv/65IyQOQtwuvS2
         KWOcjKk3wO12j6nztrjfo5gw4DW+RjEoHtzmUxVlU7hvvNC0RowQ/+/oz+BjSZ41dKS1
         Kfnfg5J6amj9Fsg1D0+YRRDKOfnjslSZVTC3aWaOKgY02oHrDdUEshtoxQapt7QBClO3
         WrPA==
X-Gm-Message-State: AOAM532cNlU3ZQsw0BpbbTQ1DnUkpNxVPYMVywvaeKZQXwA0aIYR0yqH
        XVTC40JdMILUrn/Ye8NWdIkxFEQLlv1An4EeZYXfcFFMKqjTYT+NUGhGbrefIdZXGR8nCSVvV/d
        o1n5q5w/V10ZhJYyqXNV8qtlc0UpO/3jb7SoPyn8pK3Fa
X-Received: by 2002:a05:6830:2045:: with SMTP id f5mr6127768otp.130.1592628408791;
        Fri, 19 Jun 2020 21:46:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz+k7nkq8s0leGAi9usyqihm8af2gouczZXl6gi/s/0517ndhzSkWQjmZ3NO3KIHOPlzlQl/aImXWvxY+ERYuM=
X-Received: by 2002:a05:6830:2045:: with SMTP id f5mr6127759otp.130.1592628408595;
 Fri, 19 Jun 2020 21:46:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200527071629.63364-1-yauheni.kaliuta@redhat.com>
In-Reply-To: <20200527071629.63364-1-yauheni.kaliuta@redhat.com>
From:   Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Date:   Sat, 20 Jun 2020 07:46:32 +0300
Message-ID: <CANoWswkwYPmfMbh3U3NRc26JRMe3bkWHcfiMJ6fi-3fXT1OQLA@mail.gmail.com>
Subject: Re: [RESEND PATCH 0/3] selftests: lib.mk improvements
To:     Shuah Khan <shuah@kernel.org>
Cc:     "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, Jiri Benc <jbenc@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi!

Shuah, what about the patchset?

On Wed, May 27, 2020 at 10:16 AM Yauheni Kaliuta
<yauheni.kaliuta@redhat.com> wrote:
>
> Fix
> make[1]: execvp: /bin/sh: Argument list too long
>
> encountered with some shells and a couple of more potential problems
> in that part of code.
>
> Yauheni Kaliuta (3):
>   selftests: do not use .ONESHELL
>   selftests: fix condition in run_tests
>   selftests: simplify run_tests
>
>  tools/testing/selftests/lib.mk | 19 ++++++-------------
>  1 file changed, 6 insertions(+), 13 deletions(-)
>
> --
> 2.26.2
>


-- 
WBR, Yauheni

