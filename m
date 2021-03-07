Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD2D233030D
	for <lists+linux-kselftest@lfdr.de>; Sun,  7 Mar 2021 17:47:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232452AbhCGQqc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 7 Mar 2021 11:46:32 -0500
Received: from mout.gmx.net ([212.227.17.22]:43785 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231314AbhCGQqP (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 7 Mar 2021 11:46:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1615135535;
        bh=m9XhPyfhUktKluj+d5az9WgQg1jKZwtAqzqW4H/daMA=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=YCYdzORzNOi6MnehCKw+A4Rp+5K1Try1iiZAU59Yrq0d+9iTHodgb7rOmrk83kLuO
         CI/Xj3SE4qFPdTzelLlDZzHUychoXZAlqxRfkD/pv/kwQVYArNT7KBr+1G9p5ljoj3
         g645m6Bo6TzYwhHEnzCG92Wt/kNHL7jq3vcT9K2g=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ubuntu ([83.52.229.153]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MORAU-1l7UUS3arG-00Psmb; Sun, 07
 Mar 2021 17:45:35 +0100
Date:   Sun, 7 Mar 2021 17:45:20 +0100
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
Message-ID: <20210307164520.GA16296@ubuntu>
References: <20210227153013.6747-1-john.wood@gmx.com>
 <20210227153013.6747-8-john.wood@gmx.com>
 <878s78dnrm.fsf@linux.intel.com>
 <20210302183032.GA3049@ubuntu>
 <20210307151920.GR472138@tassilo.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210307151920.GR472138@tassilo.jf.intel.com>
X-Provags-ID: V03:K1:Bpg8ecpXFdvHz2NTQ76aeUXnn3ebPIJR0iLA7tatogSidBfsxSV
 4SgSun31Mi/jnuNe7K1dWzD4qB3YzuQ7kXm9bcDBLxKE6V+JH2hFIflBXckaihD+V/HQLzb
 k6DMrnhRmpLRKPGHsTmOhtSCqMRNLvxKZPNWH9iZd+LBJcNzkmnB3C9vIN8wizSz4oP2fDN
 W6QzSlRLxi8hQXHomYE8Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:S4iu+TLq6+k=:cn7zr2cbd64QhgaHruVpDi
 92EY7RwkplFbzCm8vX7Qkw13ckEDjIumAzNCXHKM+NHSF9H/lkg5/bc8nH0oGi2+u1bElldOz
 +H4+XyCaTUqW+xn4uwI+HV4NrV/AM0AK1+E45BCtoabD5YHADGLg/R8xcGbqb82twuDOpWv0q
 egHw7y8F1A1xiy0r+TsSb5C9EJFgBIZ+CP3b/yP5x1FxgM1RRePGLbPPTQH52kaBs9/eOoCSC
 AeqrU+8mIKBUiNY4SYMWXVebNnW6d/e9N3i8PP/aEzCPSG8htmRU/7t0AolMFZ3X0pvJ4GCkg
 M3PSFiSGBAa7nYQy6OUxYDKwI4KnKvRf1nofEYaOFQu/oWzuqm85bNoQshs6eC1uhmHP76ycc
 VglZ+xK83QuDJ7jflF8jYkDDHaP9e/XGI91gkIOSpvLgvN8wLdn25M/obdui40EHFkRX4pr68
 Sbf2oUl4+Tc4+kv9EV8fDBa4ExEXHiPf85LjSb/Um/UcyniZbSzT6QeOTUZ/sLAW2xkH1incy
 4vz8N67HdHaoz6VIi/FPGDCzdskzGaT4aUZdioG89MiqQ0Nj0tMRpYH+/L8lRSQnvN3DCdt9/
 eJKj5JTmlXkP6rIZEhJ9THJTKcbFXpr8tt0fJfnF/Vfv5z6aU6YbAJ4nLNubFEoIc4Ptfy/7Y
 kPbaQx6crwg0GUCHTYb46STMdyrf7fP6XoRfpcsS8GXAfsQnvYxWe3lTs6OvyA2LRls5bvG2D
 TcpGKAeHXssIPxO0k9sjLhVh/0ErY6J75suV0l5hK9t1KCoE9XBPAlBPkgNSJ+6tNYDdMRPkS
 rTdIAllPsN80q3ZmuVvknlaykBQgCYx29gMjr9YAyTXsdSRqe8SD63beZhzLCNmfdW/dGnVF4
 +8YXLR6XHGIh4cqlQNAA==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sun, Mar 07, 2021 at 07:19:20AM -0800, Andi Kleen wrote:
> Sorry for the late answer. I somehow missed your email earlier.
>
> > As a mitigation method, all the offending tasks involved in the attack=
 are
> > killed. Or in other words, all the tasks that share the same statistic=
s
> > (statistics showing a fast crash rate) are killed.
>
> So systemd will just restart the network daemon and then the attack work=
s
> again?

Sorry, but I think my last explanation is not clear enough. If the network
daemon crashes repeatedly in a short period of time it will trigger a brut=
e
force attack through the fork system call. Then this daemon and all the fo=
rk
processes created from it will be killed. If the systemd restart the netwo=
rk
daemon and it will crash again, then the systemd will be killed. I think t=
his
way the attack is fully mitigated.

> Or if it's a interactive login you log in again.

First the login will be killed (if it fails with a fatal signal) and if it=
 is
restarted, the process that exec() it again will be killed. In this case I=
 think
that the threat is also completely mitigated.

> I think it might be useful even with these limitations, but it would
> be good to spell out the limitations of the method more clearly.
>
> I suspect to be useful it'll likely need some user space configuration
> changes too.

In the v2 version there were some sysctl attributes to fine tuning the
detection. The following two paragraph are extracted from the documentatio=
n
patch of this version:

To customize the detection's sensibility there are two new sysctl attribut=
es
that allow to set the last crashes timestamps list size and the applicatio=
n
crash period threshold (in milliseconds). Both are accessible through the
following files respectively.

/proc/sys/kernel/brute/timestamps_list_size
/proc/sys/kernel/brute/crash_period_threshold

However, Kees Cook suggested that if we narrow the attack detection focusi=
ng in
the crossing of privilege boundaries and signals delivered only by the ker=
nel,
it seems not necessary the customization of this feature by the user. I ag=
gree
with that.

>
> -Andi

I have sent a v6 version with the documentation improved.

Thanks for your comments,
John Wood
