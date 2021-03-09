Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AF55332E6D
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Mar 2021 19:42:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbhCISl7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 9 Mar 2021 13:41:59 -0500
Received: from mout.gmx.net ([212.227.17.20]:57137 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230111AbhCISlx (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 9 Mar 2021 13:41:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1615315267;
        bh=KzFmPAXJ1zDKRM2mxpYfcPPElqy1VrJmd3MBZSmX/PU=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=VC87++wuAkCxnzJdXTGwljUEJMFJl77UpPZEj7NMTrg+QaSRIDxNyop0e4onuj9cO
         LAAHCcJc1HH/85O2x6aM7FZJJQ4lz8BWYJiPM8J/QNIxUZjmSZBEgEInxE8yrkzzWi
         E1SwhOKgt6xT5/1LyZcmHplGDIIkHX+ViN3Vd0bM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ubuntu ([83.52.229.153]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MY6Cb-1lG7Ju195h-00YNXd; Tue, 09
 Mar 2021 19:41:07 +0100
Date:   Tue, 9 Mar 2021 19:40:54 +0100
From:   John Wood <john.wood@gmx.com>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     John Wood <john.wood@gmx.com>, Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>,
        James Morris <jmorris@namei.org>,
        Shuah Khan <shuah@kernel.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        kernel-hardening@lists.openwall.com
Subject: Re: [PATCH v5 7/8] Documentation: Add documentation for the Brute LSM
Message-ID: <20210309184054.GA3058@ubuntu>
References: <20210227153013.6747-1-john.wood@gmx.com>
 <20210227153013.6747-8-john.wood@gmx.com>
 <878s78dnrm.fsf@linux.intel.com>
 <20210302183032.GA3049@ubuntu>
 <20210307151920.GR472138@tassilo.jf.intel.com>
 <20210307164520.GA16296@ubuntu>
 <20210307172540.GS472138@tassilo.jf.intel.com>
 <20210307180541.GA17108@ubuntu>
 <20210307224927.GT472138@tassilo.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210307224927.GT472138@tassilo.jf.intel.com>
X-Provags-ID: V03:K1:HfpvfEEiAP4shApLpqTyApLPQZeFliyub0f4Ir5fFC3RtuHsJJM
 Fj3lpm4nRiqKO0S+Sk7Cjb6osIJGmtNTHj9uiBSy4OQFFzCKqBQVHU/7KwMn9eGUFjiWRCb
 bI6lrJ5rcVUUze4r+0u6uFzlwlB4zNWU/l7lM1BRrugsgjp5H6cZpCeQrxNpg0bV5gcqTDP
 N/ldbPLlzIqloeJC/btSA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:YJmaCsKdOZI=:3wNHcDtg5j0QtDsVdhsHVu
 Y8K8xN5Y0jd88ggw4qX4lTA9Tq//EKjwYdACWWdyyjsbdRf+WnmQpoJAqCqNtoCgAwKIvDYlO
 Nzw++1xvfI+dPYDtdpU5lPQgiXMxyJA1dqHvmofWV+QFtYH3veALmNVwZkwkNLdt9Min91FVk
 tCDP7JBMw6TqcULmOIvokxFphiqCW7b05eGjuJ2PUdXyVB4HVCy1KYZMotj1e0CU0QhqFyoaw
 hWy961+XECjaPHLX49NwfCwmxJPjDBZHXFQzr8bNFdTOyazvjuV679vtk1qYt14FNn0Fg6yOd
 NxNm0piakn6Z9myQCmh/i9K8HqBAoiNJTAN8zIoVOJxpYDFDhU67WqcLqbew4dH/CjDihvZFW
 XB2l20iA6VzkGBQJIQvU+FeMReGm5hT/QWnjWMvx9nTDvwZJ/3TU8EbkLfayQSZEPjdyQq77J
 eRirBoXWuMVvthAuMfLaBdtp4zSDvjUoGj0Uy0Gw+FYTW5Zgc16bQd4mXLhgza5h3xDjcyDvG
 dHK/RXJkduhUOP6hcmbb+XLd6uh29g5/LvKsK4DWyv8gf120rpfhKcOZJZDAqtNMr/2ATbTzZ
 aThnhhyKoQVO8rYaveiMMcevD3fRqeta+N8FG/NdEQ9bfVLO+5EilTXxukZpphZFKf+paAjum
 LDL/LVhV+xdYHh7coRn25UTbBnoT/ThkTyo2SHfIwlsyBBtcutC5nhG2exg03HadZlr+Ihxnh
 S1dthiB1E3GjPGzs4G6BiYOEalKSfhCiu5dtt859qGukz1BIw+r80A5US4ecke8Fwe7hldiwt
 FdwpJCF3kPS+styCE+F84u8fj2V3jvaYF8nRM2Pk2XdyUG6X9TVL0mpayJXp/WN50IRJyxYKX
 5IuY0e9Aq18GHE6p5D5w==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi,

On Sun, Mar 07, 2021 at 02:49:27PM -0800, Andi Kleen wrote:
> On Sun, Mar 07, 2021 at 07:05:41PM +0100, John Wood wrote:
> > On Sun, Mar 07, 2021 at 09:25:40AM -0800, Andi Kleen wrote:
> > > > processes created from it will be killed. If the systemd restart t=
he network
> > > > daemon and it will crash again, then the systemd will be killed. I=
 think this
> > > > way the attack is fully mitigated.
> > >
> > > Wouldn't that panic the system? Killing init is usually a panic.
> >
> > The mitigation acts only over the process that crashes (network daemon=
) and the
> > process that exec() it (systemd). This mitigation don't go up in the p=
rocesses
> > tree until reach the init process.
>
> Most daemons have some supervisor that respawns them when they crash.
> (maybe read up on "supervisor trees" if you haven't, it's a standard con=
cept)
>
> That's usually (but not) always init, as in systemd. There might be some=
thing
> inbetween it and init, but likely init would respawn the something in be=
tween
> it it. One of the main tasks of init is to respawn things under it.
>
> If you have a supervisor tree starting from init the kill should eventua=
lly
> travel up to init.

I will try to demostrate that the mitigation don't travel up to init. To d=
o so I
will use the following scenario (brute force attack through the execve sys=
tem
call):

init -------exec()-------> supervisor -------exec()-----> network daemon
faults =3D 0                 faults =3D 0                     faults =3D 0
period =3D ---               period =3D ---                   period =3D -=
--

Now the network daemon crashes (its stats an updated and also the supervis=
or
stats):

init --------------------> supervisor ------------------> network daemon
faults =3D 0                 faults =3D 1                     faults =3D 1
period =3D ---               period =3D 10ms                  period =3D 1=
0ms

Then the network daemon is freed and its stats are removed:

init --------------------> supervisor
faults =3D 0                 faults =3D 1
period =3D ---               period =3D 10ms

Now the supervisor respawns the daemon (the stats are initialized):

init --------------------> supervisor ------------------> network daemon
faults =3D 0                 faults =3D 1                     faults =3D 0
period =3D ---               period =3D 10ms                  period =3D -=
--

The network daemon crashes again:

init --------------------> supervisor ------------------> network daemon
faults =3D 0                 faults =3D 2                     faults =3D 1
period =3D ---               period =3D 11ms                  period =3D 1=
2ms

The network daemon is freed again:

init --------------------> supervisor
faults =3D 0                 faults =3D 2
period =3D ---               period =3D 11ms

The supervisor respawns again the daemon:

init --------------------> supervisor ------------------> network daemon
faults =3D 0                 faults =3D 2                     faults =3D 0
period =3D ---               period =3D 11ms                  period =3D -=
--

This steps are repeated x number of times until a minimum number of faults
triggers the brute force attack mitigation. At this moment:

init --------------------> supervisor ------------------> network daemon
faults =3D 0                 faults =3D 5                     faults =3D 1
period =3D ---               period =3D 13ms                  period =3D 1=
5ms

Now the network daemon is freed and the supervisor is killed by the mitiga=
tion
method. At this point is importart to note that before send the kill signa=
l to
the supervisor its stats are disabled. This means that when the supervisor=
 is
killed its stats are now not updated. So the init stats are also not updat=
ed.

init
faults =3D 0
period =3D ---

=46rom the point of view of the init process nothing has happened.

> At least that's the theory. Do you have some experiments that show
> this doesn't happen?

Yes. The kernel selftest try to emulate some scenarios. Basically brute fo=
rce
attacks through the execve system call (like the case exposed) and also br=
ute
force attacks through the fork system call. Playing with the crossing of s=
ome
privilege boundaries.

For example:

In the tests an application execs() another application that crashes. Then
respawn the application that has crashed and this last crashes again. The
respawn is executed until the brute force attack through the execve system=
 call
and then the application that execs() is killed. But any other application=
s are
killed. Only the tasks involved in the attack.
>
> >
> > Note: I am a kernel newbie and I don't know if the systemd is init. So=
rry if it
> > is a stupid question. AFAIK systemd is not the init process (the first=
 process
> > that is executed) but I am not sure.
>
> At least the part of systemd that respawns is often (but not always) ini=
t.

Thanks for the clarification.

> > So, you suggest that the mitigation method for the brute force attack =
through
> > the execve system call should be different (not kill the process that =
exec).
> > Any suggestions would be welcome to improve this feature.
>
> If the system is part of some cluster, then panicing on attack or failur=
e
> could be a reasonable reaction. Some other system in the cluster should
> take over. There's also a risk that all the systems get taken
> out quickly one by one, in this case you might still need something
> like the below.
>
> But it's something that would need to be very carefully considered
> for the environment.
>
> The other case is when there isn't some fallback, as in a standalone
> machine.
>
> It could be only used when the supervisor daemons are aware of it.
> Often they already have respawn limits, but would need to make sure they
> trigger before your algorithm trigger. Or maybe some way to opt-out
> per process.  Then the DoS would be only against that process, but
> not everything on the machine.

Thanks for the suggestions.

> So I think it needs more work on the user space side for most usages.
>

Anyway, in the case that the supervisor is init then the system will panic=
. So,
I think that we can add a prctl to avoid kill the parent task (the task th=
at
exec) and only block new fork system calls from this task. When this boole=
an is
set, any parent task that is involved in the attack will not be killed. In=
 this
case, any following forks will be blocked. This way the system will not cr=
ash.

What do you think?

> -Andi

Thanks for your time and patience.
John Wood
