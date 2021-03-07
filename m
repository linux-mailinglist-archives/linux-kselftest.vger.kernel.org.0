Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 629F33303CA
	for <lists+linux-kselftest@lfdr.de>; Sun,  7 Mar 2021 19:07:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbhCGSHG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 7 Mar 2021 13:07:06 -0500
Received: from mout.gmx.net ([212.227.15.15]:58181 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230034AbhCGSGf (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 7 Mar 2021 13:06:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1615140356;
        bh=fXviFMVCmPLfOM96SZEY2PdxKTnc0Oa1TnqXcBuTsFM=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=fzAE7sxJqniAHokF4rTGp13dNVauF/H9d+NDi2dRJUaIqUj7DioqqsJpZXnDUL4yE
         XRKxGlyagZSyU8naaQC8Z3X61pIttOGsAvniQOqId91/5I+yM5v6hRk7SMMJBK4Ahs
         Avu98p+4zMXeYml+huXawIBiSezjjD+Ojs81OdXc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ubuntu ([83.52.229.153]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M9FjR-1lMW1r1dV1-006OJe; Sun, 07
 Mar 2021 19:05:56 +0100
Date:   Sun, 7 Mar 2021 19:05:41 +0100
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
Message-ID: <20210307180541.GA17108@ubuntu>
References: <20210227153013.6747-1-john.wood@gmx.com>
 <20210227153013.6747-8-john.wood@gmx.com>
 <878s78dnrm.fsf@linux.intel.com>
 <20210302183032.GA3049@ubuntu>
 <20210307151920.GR472138@tassilo.jf.intel.com>
 <20210307164520.GA16296@ubuntu>
 <20210307172540.GS472138@tassilo.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210307172540.GS472138@tassilo.jf.intel.com>
X-Provags-ID: V03:K1:Tc6cLpJESGY8EX+S4tB8PI+278/h1FQKr+17PoATGh+7RSoFzRe
 qksgh0OV182WQL3lOWFjSdloIis4zzwbzR6d60X6Tb8vcLrKH1GwxJm9B3OWZHFiXXG0C+H
 7XqouYKHa2I+hJPlfGPHcZvCZAUveGmTUyOrBvTznb32hMTioU/46G9hPjB8xcvbnDoIDcw
 61nviN3u1BnMvTwjjV/RQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:6SuibcDZgTY=:u4MjaxCbdSx0TXy21pRgOu
 Q0LOWqRcYa8wLLEDT+fxv1mlrOeMwUEHQnXIxkq24fsBRQpULY73SxqTth2pAWpZ569SHfQEp
 z0dtZNxkSZdTf6dDbh9NfmY6RPJUplLuMZ0gZ6woelmk4Aq4jIIA8xv3zjsaxYsjUHZGfApC4
 NOLXTDYHdg7MXK4y3J/xWkhipyuubflxnFA9aP7Bs20FsNrlUZ5EImKDJN/n8K+kVwND9QGmy
 LTIu6YopksQljVdeJyhiM+F8fds8U2n/+eyb/R2LcoYY7P545+r1kHTAg8Pb5DIR8RF5hvy3M
 ihdZ/HtkVpYE4++/VPG3Tj+Q8lU7ebo5WmSt8iZ3EICcpJ7/eC85kTXGO0e91/1LQYlPO8jhA
 tJP6l49LYNiII0PshqB5s3v/tQcWC8qkDLivssAIljBX8r95WFZUf4Zz3vFSdcopuSfCcmgPp
 JAVpW6fA/33NQUfZhuDgqGgFtfFB+m7LNvcCeo/9EG8saxIUbSJDXGXcmTOg2yjVaQ5IA15Eo
 SSpBBGckMioX6Pj/v1U9LKyiFK+BYmqBD65ufZQBV7UkDPCWctb+s0b87YanzFXhszn6RYONz
 UuLhau4zWYZKbX2w5oybSLM3+zSMVLIiUfPu5EO3DU7HFt/gzuYXX2k+DNqXBcMy2axefFBRh
 VQZEuWiZf7CGI+c+L+gQ90vM8PX+0SlNRfQTNmESn5RNKWJMY9MY8E94Sr3WCz81h+Lnaalji
 /+ROfcOXmfnWlChxoc1yJdRtVOP5cTeM1wtirmPrVp+P4CYQMoBASHB5mtoC6RnCC4IY591Nl
 C7zp2xvC3u2oNgnA+ErJ+3u2qmanvqAn3FvUgK1TdHm9TR+QLns7CImAhw83TGQ7zdOOOq11l
 fV98BuXVrOYyHOBXxneA==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sun, Mar 07, 2021 at 09:25:40AM -0800, Andi Kleen wrote:
> > processes created from it will be killed. If the systemd restart the n=
etwork
> > daemon and it will crash again, then the systemd will be killed. I thi=
nk this
> > way the attack is fully mitigated.
>
> Wouldn't that panic the system? Killing init is usually a panic.

The mitigation acts only over the process that crashes (network daemon) an=
d the
process that exec() it (systemd). This mitigation don't go up in the proce=
sses
tree until reach the init process.

Note: I am a kernel newbie and I don't know if the systemd is init. Sorry =
if it
is a stupid question. AFAIK systemd is not the init process (the first pro=
cess
that is executed) but I am not sure.

>
> > > Or if it's a interactive login you log in again.
> >
> > First the login will be killed (if it fails with a fatal signal) and i=
f it is
> > restarted, the process that exec() it again will be killed. In this ca=
se I think
> > that the threat is also completely mitigated.
>
> Okay so sshd will be killed. And if it gets restarted eventually init,
> so panic again.

In this scenario the process that exec() the login will be killed (sshd
process). But I think that sshd is not the init process. So no panic.

> That's a fairly drastic consequence because even without panic
> it means nobody can fix the system anymore without a console.

So, you suggest that the mitigation method for the brute force attack thro=
ugh
the execve system call should be different (not kill the process that exec=
).
Any suggestions would be welcome to improve this feature.

> So probably the mitigation means that most such attacks eventually lead
> to a panic because they will reach init sooner or later.

I think it is not correct. As explain earlier the current mitigation metho=
d only
works over the process that crashes and their parent. It not go up in the
processes tree until reach the init process.

> Another somewhat worrying case is some bug that kills KVM guests.
> So if the bug can be triggered frequently you can kill all the
> virtualization management infrastructure.

Well, we need to work to avoid false positives.

> I don't remember seeing a discussion of such drastic consequences in
> your description. It might be ok depending on the use case,
> but people certainly need to be aware of it.
>
> It's probably not something you want to have enabled by default ever.
>
> -Andi
>
Thanks,
John Wood
