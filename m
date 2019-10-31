Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B89BEAC8D
	for <lists+linux-kselftest@lfdr.de>; Thu, 31 Oct 2019 10:33:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727091AbfJaJdp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 31 Oct 2019 05:33:45 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40218 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727041AbfJaJdp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 31 Oct 2019 05:33:45 -0400
Received: by mail-pf1-f194.google.com with SMTP id r4so3970202pfl.7
        for <linux-kselftest@vger.kernel.org>; Thu, 31 Oct 2019 02:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UfGWBZAudfaqT290q3OdOipHzfk3TijoCmN+3Jz803Q=;
        b=XhDF1lefotT2UASMthSJUxNnb0mHTBcOYfkwpTSAY+w/HCQvebzTSdG9rU5FoZT5jB
         7yGt6KeTaVrur2O+wQU1bqQTugrJbB69piT163uph4YXe867ADk73jYvYgJdMCASsaqO
         jJoZ9FwT67M6PC6GOB7CEWQH/Vaam0LdsvMGqVy4R2FyYjny8XLnDljIsrzwlWUecIxm
         lAAUkGPSwFcHfQ42lhykC7lDHXvf9WRF8TUolfSlHkao3dOb5o/E4oz1kPLmbIMJMZph
         1nluWoVD9/ou08jb121tFfVKxG0vlpu9296vSX3JQpwJ0QYKoASioMWRqKHvSqwmsNB9
         Skag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UfGWBZAudfaqT290q3OdOipHzfk3TijoCmN+3Jz803Q=;
        b=kIsH+/oPPMrhIP6Hxf4NBSZFI8FR1BC7uq6TVrllu5NmWrg5WzDriYn7l9WDccgTgv
         hADMeSP59BisBhbfkKAaU/iusaXobJkef/3trZVPVrksiJXw8fAsy5JpVJdpQb02nOzs
         /Ce4Gz6fTweChFc5MeGsUztfi+wMUjk/IT9ODKZJ4vlmfi/dzgIUjHvIK1K2w6Rt14JD
         4Ej/MKNRhuxGrbtOIPSZRydbI3Nrc4qfVEzpEe1y0mA/spN11/wMAuVgtkbczYHp2PEM
         oJABXMAWoLShmkO5sdQDVUkQRe69UU4Xsu7h6Rlx+bgvCfpxgabXE7Xg6XV815LuAKxF
         hWew==
X-Gm-Message-State: APjAAAX/VP1kNWIozdbTDoGEZJbp8BTmQJnO/4/SE7Mpw744u+f6PTyB
        8R612sX7LvaQT+0qqe1/C9QdkY/iJU1L/4NYogPogQ==
X-Google-Smtp-Source: APXvYqwBk6uPqm3VmykJcnsaeX9RA5YnvlcvEM+HRhk1ugxAFt3mcM3t+eszNFAN+ts86FuqPlbKTwge7YK0Mt6Chag=
X-Received: by 2002:a65:664e:: with SMTP id z14mr5281693pgv.201.1572514424176;
 Thu, 31 Oct 2019 02:33:44 -0700 (PDT)
MIME-Version: 1.0
References: <20191018001816.94460-1-brendanhiggins@google.com>
 <20191018122949.GD11244@42.do-not-panic.com> <alpine.LRH.2.20.1910191348280.11804@dhcp-10-175-221-34.vpn.oracle.com>
 <CAFd5g46aO4jwyo32DSz4L8GdhP6t38+Qb9NB+3fev3u4G6sg4w@mail.gmail.com>
 <20191024101529.GK11244@42.do-not-panic.com> <201910301205.74EC2A226D@keescook>
 <CAAXuY3o31iCJwZ+WGHMaK1MgpC0qv=JkJWnzv8Lhym9TnZQvcQ@mail.gmail.com>
In-Reply-To: <CAAXuY3o31iCJwZ+WGHMaK1MgpC0qv=JkJWnzv8Lhym9TnZQvcQ@mail.gmail.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Thu, 31 Oct 2019 02:33:32 -0700
Message-ID: <CAFd5g446cyijzgap9r8nm_202zkUsfdZXrn5E1_Mfe-R+eFb_g@mail.gmail.com>
Subject: Re: [PATCH linux-kselftest/test v1] apparmor: add AppArmor KUnit
 tests for policy unpack
To:     Iurii Zaikin <yzaikin@google.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Alan Maguire <alan.maguire@oracle.com>,
        Matthias Maennich <maennich@google.com>,
        shuah <shuah@kernel.org>,
        John Johansen <john.johansen@canonical.com>, jmorris@namei.org,
        serge@hallyn.com, David Gow <davidgow@google.com>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-security-module@vger.kernel.org,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Mike Salvatore <mike.salvatore@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Oct 30, 2019 at 1:12 PM Iurii Zaikin <yzaikin@google.com> wrote:
>
> > Why can't unit tests live with the code they're testing? They're already
> > logically tied together; what's the harm there? This needn't be the case
> > for ALL tests, etc. The test driver could still live externally. The
> > test in the other .c would just have exported functions... ?
> >
> Curiously enough, this approach has been adopted by D 2.0 where unittests are
> members of the class under test:  https://digitalmars.com/d/2.0/unittest.html

Thanks for pointing this out, Iurii, that actually looks pretty cool.
I still personally prefer keeping tests and code separate, but if we
decide to go the route of mixing tests and code, maybe we might want
to use this as a model.

> but such approach is not mainstream.
> I personally like the idea of testing the lowest level bits in isolation even if
> they are not a part of any interface. I think that specifying the
> interface using
> unit tests and ensuring implementation correctness are complementary but
> I haven't had much luck arguing this with our esteemed colleagues.

So I think this is a very subtle point which is very widely
misunderstood. Most people write code and then write their tests,
following this practice along with only testing public interfaces
often causes people to just not test all of their code, which is
wrong.

The idea of only testing public interfaces is supposed to make people
think more carefully about what the composite layers of the program
is. If you are having difficulty getting decent coverage by only
testing your public interfaces, then it likely tells you that you have
one of two problems:

1) You have code that you don't need, and you should remove it.

2) One of the layers in your program is too think, and you should
introduce a new layer with a new public interface that you can test
through.

I think the second point here is problematic with how C is written in
the kernel. We don't really have any concept of public vs. private
inside the kernel outside of static vs. not static, which is much more
restricted.
