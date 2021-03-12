Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31AAE339576
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Mar 2021 18:49:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232987AbhCLRsn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 12 Mar 2021 12:48:43 -0500
Received: from mout.gmx.net ([212.227.17.21]:39525 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232986AbhCLRsa (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 12 Mar 2021 12:48:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1615571277;
        bh=N7aaRYZfX/Hb6VlN8Wx+85FD6PVBAfrso1H+m3RhVgI=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=dqkbj0HPv6IV6VLmjL2AunUTiuhd3XZppUip+EU++Lv1CBjXMi0q1DIVd6E9PONkg
         yBaD5Abld3wV4pG9SHf6j7FAtb/U99bTalzVylotpn9vyknFOOpqDhHFn7JdoL5Mkm
         VtGT2OKRd22A+feY3HTTQQezJuH+nqlqpcFQCnHk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ubuntu ([83.52.229.153]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M7sHy-1lOdmI3LaU-004xcl; Fri, 12
 Mar 2021 18:47:57 +0100
Date:   Fri, 12 Mar 2021 18:47:51 +0100
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
Message-ID: <20210312174751.GB3103@ubuntu>
References: <878s78dnrm.fsf@linux.intel.com>
 <20210302183032.GA3049@ubuntu>
 <20210307151920.GR472138@tassilo.jf.intel.com>
 <20210307164520.GA16296@ubuntu>
 <20210307172540.GS472138@tassilo.jf.intel.com>
 <20210307180541.GA17108@ubuntu>
 <20210307224927.GT472138@tassilo.jf.intel.com>
 <20210309184054.GA3058@ubuntu>
 <20210311182252.GA3349@ubuntu>
 <20210311200811.GH203350@tassilo.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210311200811.GH203350@tassilo.jf.intel.com>
X-Provags-ID: V03:K1:IUthEqD1fZ9e0K8Z2cjFF7rovLU03kPvwTyh75j6PKDuHOoiQDU
 QEPH5uc4EbVEB5MQbG4jK0nNoUKsYW+xa8qKA3qSN3U0Oe/cUSyjP1QEXV8XyjnZb/QirhO
 maBhqRkbARdxEaucB1YV6TkiVH+V9g/iljzJXTgZjMHDAMhQponafjwjTyCwaaIFKRmzQRd
 5lHdpa2QoMcLV0Jg5MoEg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:MHKN75O+KwE=:qy5atky2c0DlG84lzjYs1m
 iHPrnxxMvxMmvLXO6PhxCzQl5IggF6i2ZAxG48eZM6hntijGVKhUK8w/yluHp2Rg7Ig8FU2Iw
 FG6qZdHgjyYI2loJ22t7dvUC/ius00oTQY82YLy+aPn3Y+WbIHJPujCCedLb2qApieTCQ0Cwi
 Owj2+gTujdzplUbuD0aAHutXzr54Iv0jfdXGG2ql2NLueCTzmz5ApSa77IApQthTTVtzGNQ4L
 FLkgINQebbs88KAx18x/BeFOfe/wAqxYF45qGFuBv0B/TK2cEHMiliSSnrUvmfDjlQ8B5FWzR
 0dbp8TY8c4UzTSb86uT+pz7JEFr11oddQpNHG3XPFQm+bsvn31uyfwV2GpGNJh1NH5xMfV1wE
 oDHOsRTGdxN1UIU5eoifRpqp4hwDoC26Y+/XEvuY0kKcGMUmSXj+st9hEKwPka+ZqbZneVe06
 O9VZCEXtf1/RhT2dGWAJH8Jf5bmsMAzyJQ0Ju0L4wiVfYYkxiteFUC61SONuCsKpS79XcOPHo
 vv7SmCWpEcDV/xFhVIm4C72XrKkh9aJIKOcDfmOPkG7O7DRd1X6Z/nX1aApPKR822pVelITug
 l+yDgfQPtnl7AZMIwm9q5sbBlS67ZSwYUuBgLhXaqMuN7nnPhN6tQCYl2bQ9zcg4sy1HpzSJd
 yfWMMzrf2NdDJgfnOugRhM1dLGWjoXNW9/FUxzSfa3R/8Y8EU7VPd+RiLgn++hb6ttBoGlmmd
 mcoU2I9+iqzrmEHjESnyAq0SQPSQGcTnekPwhZ8l3s/SiMTbdf5DlbtqTXq8U5OSlS0E1Ixom
 gXTzCWO0D7Srif0BAGtD9JEcL2OHNwntX07M4nvTkAly2e4LZEtIgs1puYjsICu4I8YJwwXVi
 6+DhvQHYDAuZtMt2/R3w==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Mar 11, 2021 at 12:08:11PM -0800, Andi Kleen wrote:
> > When a brute force attack is detected through the fork or execve syste=
m call,
> > all the tasks involved in the attack will be killed with the exception=
 of the
> > init task (task with pid equal to zero). Now, and only if the init tas=
k is
> > involved in the attack, block the fork system call from the init proce=
ss during
> > a user defined time (using a sysctl attribute). This way the brute for=
ce attack
> > is mitigated and the system does not panic.
>
> That means nobody can log in and fix the system during that time.
>
> Would be better to have that policy in init. Perhaps add some way
> that someone doing wait*() can know the exit was due this mitigation
> (and not something way) Then they could disable respawning of that daemo=
n.

Great. So, if we use wait*() to inform userspace that the exit of a proces=
s was
due to a brute force attack then, the supervisors (not only init) can adop=
t the
necessary policy in each case. This also allow us to deal with the respawn=
ed
daemons.

As a summary of this useful discussion:

- When a brute force attack is detected through the fork or execve system =
call
  all the offending tasks involved in the attack will be killed. Due to th=
e
  mitigation normally not reach init, do nothing special in this case -> t=
he
  system will panic when we kill init.

- Use wait*() to inform userspace that every process killed by the mitigat=
ion
  has exited due to a brute force attack mitigation. So, each supervisor c=
an
  adopt their own policy regarding respawned daemons.

I will work in that direction for the next version.

Thanks a lot for your time, proposals, guidance and solutions.
John Wood
