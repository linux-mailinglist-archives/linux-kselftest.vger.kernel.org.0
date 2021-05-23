Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A3BD38DBA4
	for <lists+linux-kselftest@lfdr.de>; Sun, 23 May 2021 17:49:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231808AbhEWPu3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 23 May 2021 11:50:29 -0400
Received: from mout.gmx.net ([212.227.15.18]:49693 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231789AbhEWPu3 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 23 May 2021 11:50:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1621784884;
        bh=FrWraqxqE5YYa+m3D7qRmF+oGA519cjiJkwpYd5Z2+4=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=MlAGITup6S74CPUyUk7DrKXMFyKxhwmYjNVvZxacdvzyJnqweDEjwR10Uehfrq14V
         qNrqXwa0NC8gwyd1h6akEGEOFnys6LzF/WWLOknzdPYudg4UI6DkYARAGJVvIdCxVH
         KQ3ZVbulhSh7knPpHzoewt1P59a1mdE2NFpgSgWo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ubuntu ([83.52.228.41]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MAfUo-1lZnhs0rQ8-00B7XB; Sun, 23
 May 2021 17:48:04 +0200
Date:   Sun, 23 May 2021 17:47:49 +0200
From:   John Wood <john.wood@gmx.com>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     John Wood <john.wood@gmx.com>, Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Shuah Khan <shuah@kernel.org>, valdis.kletnieks@vt.edu,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-hardening@vger.kernel.org,
        kernel-hardening@lists.openwall.com
Subject: Re: [PATCH v7 0/7] Fork brute force attack mitigation
Message-ID: <20210523154749.GA3762@ubuntu>
References: <20210521172414.69456-1-john.wood@gmx.com>
 <19903478-52e0-3829-0515-3e17669108f7@linux.intel.com>
 <20210523073124.GA3762@ubuntu>
 <3d4ddd55-4f42-3ef7-dd68-a9f2bc33ba4b@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3d4ddd55-4f42-3ef7-dd68-a9f2bc33ba4b@linux.intel.com>
X-Provags-ID: V03:K1:YICGuZJa+XoC4UrRWY3G49f7Hh4z2qD02D0EnqYde0YwRyk9D5j
 Wi36QkvxyTc6zY4wywHFAUwaQ1T3kaxiU1axjO/iEG64lDNTsijLIp3jAAXP3TdsrJjI1JO
 DCtClcBdN6YqFvOlSJKBPLCjYzqW9K9ZYe4fB6b3v2dCemUVnRAXQGi2k3CWene6CaCzesp
 TKgy3Qcj7xt+rcaEUIorA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:uq0tE3o5F/Y=:1AswCfz2hpV+ocgmC9DNmk
 /kz64yOiY4gO1DnokRMAGVeJRQS/yTyKZy/NE472elXysojfgXyWIOlY4L0UY5S5IcDu6x/HX
 CRt09XC3r/Fm2nWKYJOjKLSohgd7xbjtd7C7R5f8MZWA971cLJ6vASeWBjnIWjwTThvZhzXIs
 taCDiwYzm5tClKLMvV4Xvi/QPOsErKYD1emaEo0yfK8UdtRofpl77Jo3NXJbGvJaKUW+9dZFQ
 3cFCplMX5ObbZRjk5w1tV6MwsA6IfEgfXln16uzePSMME7mZ4y1aIsAiZDb7sP6joSS5j4IUF
 WhOuRhLcFjXOUA/L1JT5rCznwrZZHbOcvhj9bYZQIDKSNA+fUhMZF+nW7z0djPQB/TKe646nO
 3y+CBp9DpND9EMK4xoe73jH1+mRmrFqjnaLFqu3tsRFx35QIQxo/9DX4MuxdEKhh6M4Fj6Vkc
 h2/J2b2ZA6erVioFDegM+i7AMyN7aA+7CL510SwijdrMCCuBp74pdz85pzU3lL1qt86aNRGMw
 W6B1STzAvoUfw//O+KT+jbmmbE3GE4F9pBFCH4gmxIgbREIeOrRG3JlR1Df6h2raiP8ngxGnm
 o4ps/wXTboUNZjIJfQs/sA0dYCNSTlNz5U4c3eQRXCPpb1xBeVsnAtfuXXt7LZhpb6fkuwMLN
 NzqUy0rHbaQzO7JKVhPRE/txaH8rtR894k/yE1u5J4n2dGdSTO2f6IXScTUa/sYBNiSkwbtdB
 tKTw4lBIc1Vvr288fFESsrjWvo1/hbN5YRPE4Va5tYJ5Mq5oUd+SsdTKPnVbH+kGtlBQsLVXB
 7vOEAPXDgkTjo8K7GMMVpHewriuji3cAGh/+pqIqekH1jRSd6o9D1WyQJGaUEBGxJ+wCeI338
 VkYlj7coGmjjn1yI+5rABltlGVtdr+XqodNbK7rDCJfKVX36txXOpNH9rJ5O8hgVaGH6c1P2n
 6MqnZ4n1z/9N/YdkMXFxAtnOlx4mbMWcK6iibM9erFrw1kqQJL/oogW4tez+1dNej096IbvI4
 ShmJS801cDSZVHM19J3BCKUEUvUk4vkGMh5xZAfHcPK38VnJcBcSYreHe/9oMFZGRCMk+IDPx
 QItNaiPbOVAxKGckD0t4sdEbuuRQl+9NAyQ
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sun, May 23, 2021 at 07:43:16AM -0700, Andi Kleen wrote:
>
> On 5/23/2021 12:31 AM, John Wood wrote:
> > Hi,
> >
> > On Fri, May 21, 2021 at 11:02:14AM -0700, Andi Kleen wrote:
> > > > Moreover, I think this solves another problem pointed out by Andi =
Kleen
> > > > during the v5 review [2] related to the possibility that a supervi=
sor
> > > > respawns processes killed by the Brute LSM. He suggested adding so=
me way so
> > > > a supervisor can know that a process has been killed by Brute and =
then
> > > > decide to respawn or not. So, now, the supervisor can read the bru=
te xattr
> > > > of one executable and know if it is blocked by Brute and why (usin=
g the
> > > > statistical data).
> > > It looks better now, Thank.
> > >
> > > One potential problem is that the supervisor might see the executabl=
e
> > > directly, but run it through some wrapper. In fact I suspect that wi=
ll be
> > > fairly common with complex daemons. So it couldn't directly look at =
the
> > > xattr. Might be useful to also pass this information through the wai=
t*
> > > chain, so that the supervisor can directly collect it. That would ne=
ed some
> > > extension to these system calls.
> > >
> > Could something like this help? (not tested)
>
> This works even when someone further down the chain died?

Yes, this is the idea. (but now is a work in progress :) )

> Assuming it does, for SIGCHLD it seems reasonable.

So, if there are no objections I will work on it for the next version.

>
> I'm not fully sure how it will interact with cgroup release tracking tho=
ugh,
> that might need more research (my understanding is that modern superviso=
rs
> often use cgroups)

Yeah, a new topic to learn: cgroups. I will try to work on this too if the=
re are
no objections.

Thanks for the feedback.
John Wood
