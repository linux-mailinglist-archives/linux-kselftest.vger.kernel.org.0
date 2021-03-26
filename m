Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A79834ABB1
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Mar 2021 16:43:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230272AbhCZPnB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 26 Mar 2021 11:43:01 -0400
Received: from mout.gmx.net ([212.227.17.21]:46687 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230192AbhCZPmz (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 26 Mar 2021 11:42:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1616773315;
        bh=5eLgdU45K7E2wo8Ug5bX02jFCrshvXXHtRqXp9B6Ow4=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=h8SQ3C/2QwpQx0H0KY6KP+jiib7Gm5USU+lQNsEvBANLK8Smdnfid33h7KFB12x81
         J973x93ulLSa39BNO+pIsKe63b3zq5qjrZJSl5r8bnDMhUMY0ZaLcWqfkbNNOzqcsb
         n76DLt/OLQKTDbpkQPdF2Yd/qmbdd9MY2ZlVjXTY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ubuntu ([83.52.229.153]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1ML9yc-1l7jkH0lQw-00IAuO; Fri, 26
 Mar 2021 16:41:55 +0100
Date:   Fri, 26 Mar 2021 16:41:41 +0100
From:   John Wood <john.wood@gmx.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Kees Cook <keescook@chromium.org>, Jann Horn <jannh@google.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        James Morris <jmorris@namei.org>,
        Shuah Khan <shuah@kernel.org>, John Wood <john.wood@gmx.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andi Kleen <ak@linux.intel.com>,
        kernel test robot <oliver.sang@intel.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        kernel-hardening@lists.openwall.com
Subject: Re: [PATCH v6 7/8] Documentation: Add documentation for the Brute LSM
Message-ID: <20210326154141.GA3131@ubuntu>
References: <20210307113031.11671-1-john.wood@gmx.com>
 <20210307113031.11671-8-john.wood@gmx.com>
 <87k0q0l4s8.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87k0q0l4s8.fsf@meer.lwn.net>
X-Provags-ID: V03:K1:2ffp/O9iNnB5tOZJlOKbIBIElc1aB7tKPscALEmFt1EkyRNffNU
 wiPNw8U3ciTKoYxsVRf81yoQRo+H/hCZy/YRjAhdBHs3d0PuEgLHBhO3PnfD7k9tPPFojEM
 cGrMSsT0B1TFpWESJbnCsgDEso8ClCflg1zZj8nlYfUqt71TtWmomZBAxLP/erTm8BKsSQK
 seGzO+1FPZsNDkPT/lboQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:vchnW+PvK4U=:Kaw9IXbD5r2xS7sNA6OL56
 QE1/0MjKUGVmH5sEyhJqPw6vSvgHThqEtvtDYJZUOOOx/PiFtqjWxWcqPZYpfm6fAF26hbUyL
 dQzXBiz/3yLMAS810CnIcsi0OZeAvX2pe2c98w+koowqJVNgyvhnDatNlfCFsD7DjotBsCNjw
 Ek/8IIFJ0C5eOTQDBwUWwpgFNkjFBKEK+k7YJOl33byzzHjIg09gCeJjg5Qk/j/jth+t0Jp8g
 rDJfsaNv2horig5RmhCLYi7xfpv74AztymIxntOdxFs2b/4m4CpL7OXlHTGz5TWDE7yDNbdXz
 LTQGMcyqZHUnsiaN/bUEGiSpV7MA5B4kY/SF3CIU4bMBoH3W4rtGS93HJMFJEDrlpl95Ixry3
 WjGbM03IHwI2jJOcPceBGFru4tC4PwQIIDZt7yka/ujCKfliV8+l7bvxQR/Yb0N8FKSta9mYn
 wJMFcl5T+BIChZLYAqArTJe4aGFObBz3gmbeRgK6OXuxDUlFz7k58yhIxgWSme9sMrn5UX2M9
 KnoG1n0PkJBrTqxbZaxejWeBp5e1f/vtxjE8t+5FjQcyNfcKx1snzJxMUqzhtAwDlMRdICkFi
 O1RIW4vtfFH1C/5/Ppj9cMUz6D2BTooqzurmm19swoL12/uPVCO5WkvEhtij155ZviTMjFkl1
 EtPKV7SDFMeonS671j5j8P055AKpZbyKYA5xetqt7l0fzA2rJTie2rmS2c65kO8Gf4v+nC9AT
 kj7qg7C+oQR7uR1YJQec0Oi1ljqBKcERi4Axsd6vqVUmYhWRFF6A9jQSaxGrfS+bZ2irLenMN
 vT7NOFvhTzL7nZZXed5oi4GF2nWUW00nMMgkr+yXfJ/IbTsoGMwRQYWxOMdMzjLhCCPXak6tG
 5HUmVFEMKL6OrA1hz2PETgTBOEQ0EbY8+EoBUy1DrpVlSBhbSoC0wOjnbMqSKmN0ftRYspGyz
 IknRYK5luCxnOfAgKvm8T4oAlcCN8VZr8wEgfvEXk0f4fOc+5VhgN+wXvKbJB3w0H2qxh7mdd
 /3qNaBqWfeGSzPpgjskBhLeG8sxCeHvnyAQjxLPrB3IXryXyKXBEQfeITIVg5NwJcwqX+Zrjq
 QMy4mSh9VU9q/fgRaw7VWbjnXf576OgiDe8jrbQNjAP40LHgtxet2LPlJEfACu+P3Dc775l0b
 KiQ9ZMeMLa8xYiKNjOfvfRZHcpCykK9NEMIQk1XBD48HaVsli04WH179X88YsvSyiz4xE=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sun, Mar 21, 2021 at 12:50:47PM -0600, Jonathan Corbet wrote:
> John Wood <john.wood@gmx.com> writes:
>
> > Add some info detailing what is the Brute LSM, its motivation, weak
> > points of existing implementations, proposed solutions, enabling,
> > disabling and self-tests.
> >
> > Signed-off-by: John Wood <john.wood@gmx.com>
> > ---
> >  Documentation/admin-guide/LSM/Brute.rst | 278 +++++++++++++++++++++++=
+
> >  Documentation/admin-guide/LSM/index.rst |   1 +
> >  security/brute/Kconfig                  |   3 +-
> >  3 files changed, 281 insertions(+), 1 deletion(-)
> >  create mode 100644 Documentation/admin-guide/LSM/Brute.rst
>
> Thanks for including documentation with the patch!
>
> As you get closer to merging this, though, you'll want to take a minute
> (OK, a few minutes) to build the docs and look at the result; there are

Thanks, I will do it.

> a number of places where you're not going to get what you expect.  Just
> as an example:
>
> [...]
>
> > +Based on the above scenario it would be nice to have this detected an=
d
> > +mitigated, and this is the goal of this implementation. Specifically =
the
> > +following attacks are expected to be detected:
> > +
> > +1.- Launching (fork()/exec()) a setuid/setgid process repeatedly unti=
l a
> > +    desirable memory layout is got (e.g. Stack Clash).
> > +2.- Connecting to an exec()ing network daemon (e.g. xinetd) repeatedl=
y until a
> > +    desirable memory layout is got (e.g. what CTFs do for simple netw=
ork
> > +    service).
> > +3.- Launching processes without exec() (e.g. Android Zygote) and expo=
sing state
> > +    to attack a sibling.
> > +4.- Connecting to a fork()ing network daemon (e.g. apache) repeatedly=
 until the
> > +    previously shared memory layout of all the other children is expo=
sed (e.g.
> > +    kind of related to HeartBleed).
>
> Sphinx will try to recognize your enumerated list, but that may be a bit
> more punctuation than it is prepared to deal with; I'd take the hyphens
> out, if nothing else.

Thanks. I will fix this for the next version.

> > +These statistics are hold by the brute_stats struct.
> > +
> > +struct brute_cred {
> > +	kuid_t uid;
> > +	kgid_t gid;
> > +	kuid_t suid;
> > +	kgid_t sgid;
> > +	kuid_t euid;
> > +	kgid_t egid;
> > +	kuid_t fsuid;
> > +	kgid_t fsgid;
> > +};
>
> That will certainly not render the way you want.  What you need here is
> a literal block:
>
> These statistics are hold by the brute_stats struct::
>
>     struct brute_cred {
> 	kuid_t uid;
> 	kgid_t gid;
> 	kuid_t suid;
> 	kgid_t sgid;
> 	kuid_t euid;
> 	kgid_t egid;
> 	kuid_t fsuid;
> 	kgid_t fsgid;
>     };
>
> The "::" causes all of the indented text following to be formatted
> literally.

Thanks a lot for your comments and guidance. I will build the docs and
check if the output is as I want.

> Thanks,
>
> jon

Regards,
John Wood
