Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D1C34DBB36
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Oct 2019 03:07:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404213AbfJRBHc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 17 Oct 2019 21:07:32 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:39248 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392283AbfJRBHc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 17 Oct 2019 21:07:32 -0400
Received: by mail-qk1-f193.google.com with SMTP id 4so3788718qki.6
        for <linux-kselftest@vger.kernel.org>; Thu, 17 Oct 2019 18:07:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=40ujc7RfVfNaPHECTGoUgnPQAhwikPah9moYi7g/hII=;
        b=IQ0rhGHCOcN65fgM9jLRHhcRbUVo76BZS6covsyuFs19ytBgbCpf1OvTmoDZlhXMsQ
         qArY8F/CyEfKYggx5jphPxMne4ZRtHXwkQfLqMEehvN8yA4hOgdTZ6hFY6y6mhGikySH
         zMe6pz3lHpl1CbunXf57+0SNjUsCMKd0LCVF0jTIBRQhA1kysuXpXiX+AcCgdq8E19G+
         LG9WVaJNtQq1Hyif4+yL6o/lNZJR3ULGJZgLhhaGaCDuUuybNVJGoNQde3G3yhr2LzaK
         4+si8BK0/IuwAzYjJPsDCkAFpt0Bvah+j8l7b58yRhEVUDuEGmwbqD/S2hs+NYxcuC+g
         I5sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=40ujc7RfVfNaPHECTGoUgnPQAhwikPah9moYi7g/hII=;
        b=QkZNfbx0pXEEmFdEERfCdDY5SZ/rlZPo8cAAHDHxXL3qmmqXNNE3AO7c8NMnHOATby
         WMxrfE+Wwp5qXiD1htCpxz97X2GFnjnnqF0i1GUTnBpQe7wZrQxPcuhPURcAUDqwIEIa
         YwbUE9q5C8M+jcysRouuISi4nstnfvK+6sGu5HsHa+nAdc+QnqWwZ5a4b3L0gxD0XXVa
         JA+omTQDGEocoZ2JDHwmHDrHfGuW37ag1Keoj36k4WNczDP+CBfVeVuBflQf0eYYDgyd
         ntb2nY2Rm8zyRYGVMS+Z/uh5SZa8IAU55n0J1L24cS7jkgp441GAd6U+sH1xuyOUQQ1N
         pGsg==
X-Gm-Message-State: APjAAAXIugIB8YRpzTfeyKCyt711cPfmvFatWy4VER4xVr5gMJtYrNgd
        Zy/whgBO4i09t/EDfHqnueGwgSFVLDIiZ1W7O6RceUjOsQ==
X-Google-Smtp-Source: APXvYqwUYq+GM5FlMqrVgUVGG7mU2ErtSDUVpG/WKsMiZgXMVLUVdkMUgFt5Rd9wjF7reoDD1BX8kcQJUZSCvzDCA88=
X-Received: by 2002:a37:348:: with SMTP id 69mr6234766qkd.28.1571360851118;
 Thu, 17 Oct 2019 18:07:31 -0700 (PDT)
MIME-Version: 1.0
References: <20191010023931.230475-1-yzaikin@google.com> <2f2ea7b0-f683-1cdd-f3f2-ecdf44cb4a97@linuxfoundation.org>
 <CAAXuY3qtSHENgy3S168_03ju_JwAucOAt5WEJGQ+pi5PfurP6g@mail.gmail.com>
 <CAFd5g46RcFV0FACuoF=jCSLzf7UFmEYn4gddaijUZ+zR_CFZBQ@mail.gmail.com>
 <20191011131902.GC16225@mit.edu> <CAFd5g45s1-=Z4JwJn4A1VDGu4oEGBisQ_0RFp4otUU3rKf1XpQ@mail.gmail.com>
 <1e6611e6-2fa6-6f7d-bc7f-0bc2243d9342@linuxfoundation.org>
 <20191017120833.GA25548@mit.edu> <957434b6-32cc-487f-f48e-f9c4416b3f60@linuxfoundation.org>
 <CAAXuY3r7Eu+o-td8MRvexGYmONPgd8FvHr+7mF84Q4ni1G3URg@mail.gmail.com>
 <40073fc9-1de1-9253-e2f9-9cf9ee4308d4@linuxfoundation.org>
 <CAAXuY3r7QKSuwVYDQhF8-zC75ZRVHr+4pzpGXeNbPaEdbM3h4Q@mail.gmail.com>
 <ECADFF3FD767C149AD96A924E7EA6EAF977D00C3@USCULXMSG01.am.sony.com>
 <CAAXuY3oS=fzH0hpdjUpp_tUyypfAs=TaJxtw9L2=feUkLH2sUA@mail.gmail.com> <ECADFF3FD767C149AD96A924E7EA6EAF977D013C@USCULXMSG01.am.sony.com>
In-Reply-To: <ECADFF3FD767C149AD96A924E7EA6EAF977D013C@USCULXMSG01.am.sony.com>
From:   Iurii Zaikin <yzaikin@google.com>
Date:   Thu, 17 Oct 2019 18:06:54 -0700
Message-ID: <CAAXuY3pkZuMXbeASjbiuzg8-j+7dV7yUrW1D7WhHqb1UyC0Dww@mail.gmail.com>
Subject: Re: [PATCH linux-kselftest/test v2] ext4: add kunit test for decoding
 extended timestamps
To:     "Bird, Timothy" <Tim.Bird@sony.com>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Brendan Higgins <brendanhiggins@google.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, linux-ext4@vger.kernel.org,
        adilger.kernel@dilger.ca,
        KUnit Development <kunit-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> Having a data-driven test can, in some circumstances, allow one
> to more easily come up with additional interesting test cases.
Let's try to break this request down:
1. You would like first-class support for parameterized tests, as they
are commonly called,
instead of the ad-hoc thing I did because this is all upstream KUnit has atm.
Me too!
2. You would like a way to pass the data to the parameterized test
other than hardcoding.
Depending on how parameterizing is designed, the input part may or may
not belong in KUnit.
As an example we have a test which has custom code that does
essentially "ls dir" and passes
the list of input files as the list of parameters to the test
framework and then each individual test
has the code to read the file passed as the parameterized test's
parameter. This is not the most
elegant example but it's the quickest I could come up offhand the
point being to demonstrate
what can potentially belong in the core test framework what can be
external to it.
