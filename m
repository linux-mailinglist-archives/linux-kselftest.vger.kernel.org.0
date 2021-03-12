Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91B2F3392FC
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Mar 2021 17:20:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232229AbhCLQUO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 12 Mar 2021 11:20:14 -0500
Received: from mout.gmx.net ([212.227.15.19]:55471 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230302AbhCLQUJ (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 12 Mar 2021 11:20:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1615565977;
        bh=VZf1ffj/4RS89iXA7oEEQahAXYgObise/bJlm1SH0i8=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=IDV7wAHot5KJfxh/MckcvE9vjldhR0CievjD3XHItbuqmk3Mgazp/V4TGG8hFJ4ot
         AcGK9fjtChrCqo8k2Tb9nAYLvkbgueHBUbcR4YTv530Cm6hpD43Jfv6+kZ1xqivQiM
         l/4zsy1cHpzbtIxonrmjHTbaOdKx0Cn+YhR4wq5E=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ubuntu ([83.52.229.153]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N3se2-1ll74D1ksS-00zlRE; Fri, 12
 Mar 2021 17:19:37 +0100
Date:   Fri, 12 Mar 2021 17:19:21 +0100
From:   John Wood <john.wood@gmx.com>
To:     peter enderborg <peter.enderborg@sony.com>,
        Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>,
        James Morris <jmorris@namei.org>, Shuah Khan <shuah@kernel.org>
Cc:     John Wood <john.wood@gmx.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        kernel-hardening@lists.openwall.com
Subject: Re: [PATCH v5 5/8] security/brute: Mitigate a brute force attack
Message-ID: <20210312161921.GA3103@ubuntu>
References: <20210227153013.6747-1-john.wood@gmx.com>
 <20210227153013.6747-6-john.wood@gmx.com>
 <5419ebe6-bb82-9b66-052b-0eefff93e5ae@sony.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5419ebe6-bb82-9b66-052b-0eefff93e5ae@sony.com>
X-Provags-ID: V03:K1:nYmy5eaPQHj33hgRpiMxaTOcPMTYvN7xaS3wyLDazjP5V/YFb4Z
 znbqz2yNzZRPv4v+XFaAXX+Xy1YuYETB7K1FSzeSQ5md6tzqj4qkIMLy7qnvRGB+bUMKerI
 Hb/iKHMgrnztcYSIrmeJqfekU4XRdUE9KXDk+RiRNfCdDfNKDGpFrqbXTlRloURX604NGHh
 WMhhaIq892k+SuVCS052g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:TPWopnVyQWU=:NfpcNJWDWUL5ams7fHn7cV
 ejevW9rLBSX4FsFEKy6ZYk2l3BJjqw9L9bPFgiNcG5vYjf8STw/q8ZjDYW2KfCfQ1ko21arHJ
 RYhwPDvFE3biBT+p4shdN9vK3DdRbofwZbDS7bi0f3N3xAObXLJQc2RTBbDgMJ7xRePmhgHWp
 Lj3lRPRz0MgoWfwypkFBEeeaIZ5pyL38RWjuBE4TZ8YWS+qFZZIkSVsAOVUQpXZfjJ5bdM7ZP
 dyHetdrMr0M0pygmRv4I+TdELeTkMuAPueOYzj6jz1AtF0PtEn5EggjBAbcixayk7d2jgjWvS
 sG5ShaOHhwcT/bWSIHXdhIzlchVMIenECsj7+uGsZLt7IiICkDxBn5+FZ3FZQEk7udg47P5NJ
 P2MtDnfih+tSAqzN21jJL3n9nl7HsVU9JkOJC420kO+GMOO4vczoeYPGICqQVR3lZdzwskDg4
 zh14aHE05Ae/6C4dYTDFCU9Q15sNdtXUGg/QqhUgO6w74po9TgZHXR+w22Yeye8LYfoM8MBIO
 G9+f/VBz5GZ9bLgz4sYGzQMwSlbtTQX/Jcxlgc3P/8fCOnhRmOwaW8m+iU/2GHI1Msh5aoGRU
 5VwnXSQ4lH7KAqx38dpXxAqc0pOs0jpscBGramBdM0kGlx4gllHJIibak7rjvm0mGVLJxqxfd
 Evc1miLzs4bsq7AidaFvmEesGvz/F5OHVByQyu9IrshWTyAtYdt9sJ/JVZBiqY2xcbrhrSu+4
 WxheGmLZIF6QyumbTKczXdhYqWbGU0IlGSRCFHi0gb8y9cnTs3m6/t+Kb4RHYfkMVcv/Iykol
 +Xp0kfBwI1vcC8wrzEH8Ob8XPYok10MfY58kllIXt4gwGn4alrGRh9KAzcExFr5jXo1kKJe3A
 lbMbcTaQ6SqOoW0yNKBw==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi,

On Thu, Mar 11, 2021 at 09:32:47PM +0100, peter enderborg wrote:
> On 2/27/21 4:30 PM, John Wood wrote:
> > In order to mitigate a brute force attack all the offending tasks invo=
lved
> > in the attack must be killed. In other words, it is necessary to kill =
all
> > the tasks that share the fork and/or exec statistical data related to =
the
> > attack. Moreover, if the attack happens through the fork system call, =
the
> > processes that have the same group_leader that the current task (the t=
ask
> > that has crashed) must be avoided since they are in the path to be kil=
led.
> >
> > When the SIGKILL signal is sent to the offending tasks, the function
> > "brute_kill_offending_tasks" will be called in a recursive way from th=
e
> > task_fatal_signal LSM hook due to a small crash period. So, to avoid k=
ill
> > again the same tasks due to a recursive call of this function, it is
> > necessary to disable the attack detection for the involved hierarchies=
.
>
> Would it not be useful for forensic reasons to be able to send SIGABRT a=
nd get the a coredump?

If there are many tasks involved in the attack we will generate a big numb=
er of
coredumps (one per task aborted). This can be solved if we send the SIGABR=
T to
terminate the first process found and send SIGKILL to terminate the remain=
ing
processes. But I don't know if under this scenario we will get a core dump=
 with
lack of information (the info related to the other processes).

Another scenario:

The process that crashes is the last in the fork hierarchy and triggers a =
brute
force attack mitigation. In this case it it not necessary to kill the proc=
ess
that crashes since it is in the path to be killed. So, under this situatio=
n we
will not get a coredump (we don't send any signal). Lack of information ag=
ain.

Currently, we show the name of the task that triggers the mitigation, the =
attack
type (fork or exec) and the name and pid of all the offending tasks involv=
ed in
the attack (the tasks that we kill). If it's necessary we can show more in=
fo.
What info do you think would be necessary?

Thanks,
John Wood
