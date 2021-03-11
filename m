Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BFB7337C78
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Mar 2021 19:24:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229483AbhCKSYH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 11 Mar 2021 13:24:07 -0500
Received: from mout.gmx.net ([212.227.15.15]:41513 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229883AbhCKSXl (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 11 Mar 2021 13:23:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1615486987;
        bh=SpnCU8DF8fceQcBGatEhurYgUxXjyn+Yh3rMYnZtpBw=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=EJGVOIR575wXcr5c6RRSlrapvOBsan8L+f6g86Oe6pPunBUxgE4Uxr3yKQsYvuF55
         Fk+OhstRBVDUiL5BP9azSbnTEAJAaL2YDxrGXgYab5j1zM1tCwPHuho67fkGJFNRny
         I3CMBI7vURJKEGu4DCemsRLl20UpoLgYi+fcWYn0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ubuntu ([83.52.229.153]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MatRZ-1lrI4P44J1-00cOpP; Thu, 11
 Mar 2021 19:23:07 +0100
Date:   Thu, 11 Mar 2021 19:22:52 +0100
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
Message-ID: <20210311182252.GA3349@ubuntu>
References: <20210227153013.6747-1-john.wood@gmx.com>
 <20210227153013.6747-8-john.wood@gmx.com>
 <878s78dnrm.fsf@linux.intel.com>
 <20210302183032.GA3049@ubuntu>
 <20210307151920.GR472138@tassilo.jf.intel.com>
 <20210307164520.GA16296@ubuntu>
 <20210307172540.GS472138@tassilo.jf.intel.com>
 <20210307180541.GA17108@ubuntu>
 <20210307224927.GT472138@tassilo.jf.intel.com>
 <20210309184054.GA3058@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210309184054.GA3058@ubuntu>
X-Provags-ID: V03:K1:G8f/cmLbzHC0nvOAJdH8LHg1kBQt5faDFzmpqz5385toUzzE7T/
 aBAqokU4PkqDSQJV80GvLHFPwvw5izfUOdKZo0dRxlGYKGeLzprDF4za3AuKGiSftYOsWZA
 miE6mjre9ithdQuNaeNBsIShWd524U0NwGLtlI/0nLPgFY3Gnem7CNFokvucxf3g7qGtR3L
 dYo6zcVtd9Nhoy9g6b9tA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:IuvjmF4wvE8=:k+Np5YEJ/gTxWhv5RAx2aR
 Naxj9IijaZ8D19fjm+4yscaHdBgu7pWkS0syoMyl5PgbGlKIHME1MWaLDyHw+nTW5ev4o28gM
 n82pmgZHDVYWbpfGjmWnQ31+Mej/j868cvItrSX00RjPyaCpDcRbzJ3K+rOcjtQnGlGcrA/qs
 HF1X+Yo9P7S4UsSvO9p9CKACZVZLqdzSrXJ5mDZ+gKxLu9IzN4bd8NvVoAOSz6Bo/ZDfav5pP
 7KJLAH0fA9FqQF4lU+r4LEnMU+3cJL01dswzOfE4LOOlZitGV830gVLIzKZ4zrw6Sm/Sb11Dz
 5p/AJbOWpeiuIFw9aByBtBhIQq/pTCxQNaj3Ex9eP2RlUCQXAe4Q6BwljSxyTcrRsMKgijXoL
 Qa634MLCQLMjBuuzoLgiZlHRN+nqmzw6aNw32B+CS1GIXD8yOye3v4Bu9azwDeM4uwY0kn2Mo
 dOVF7vKPAc7rU/tVFds+vkBP5bxemL7pU/YVEHZgxB1GXXR1IDfYL6ku7kpNzlnc+Bw0f7qiD
 0BELxF7+QUvGlepuAFeUO5AO257g4cTKcTK1n6FmQ6rg4TQkMwMtt9GfZWWKfrSLng6h4ICQ9
 TiSeezx3n/+kze3B9lSg4zQv2SumZB2qOIEn649sZUMFJXfcSRVL3cb2mYpYv7oMjde6z5a0Z
 42Y+SuykritmMsZhHreEx0fSuRr54R00t2sQd7kC9YblMm2Yy2mKLLFRvAQRWl0nKeMlsfJcu
 9HkF6CgCtD68r1MU2s0bK+FV3cWvICtDu/6hMHkS0DmsWgo7ZX/zsmhtfG/duSyluefLHUGAM
 HwJwt1O/E8L0NihOxV8aNOfKusr6CnHZ2tfnvoJu/lHuuVuMBVqD8m37xgUI7jWbDe1td8OQC
 DILVp6PlvjR8m/sRveeg==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi,

On Tue, Mar 09, 2021 at 07:40:54PM +0100, John Wood wrote:
> On Sun, Mar 07, 2021 at 02:49:27PM -0800, Andi Kleen wrote:
>
> > So I think it needs more work on the user space side for most usages.
>
> Anyway, in the case that the supervisor is init then the system will pan=
ic. So,
> I think that we can add a prctl to avoid kill the parent task (the task =
that
> exec) and only block new fork system calls from this task. When this boo=
lean is
> set, any parent task that is involved in the attack will not be killed. =
In this
> case, any following forks will be blocked. This way the system will not =
crash.

Another proposal that I think suits better:

When a brute force attack is detected through the fork or execve system ca=
ll,
all the tasks involved in the attack will be killed with the exception of =
the
init task (task with pid equal to zero). Now, and only if the init task is
involved in the attack, block the fork system call from the init process d=
uring
a user defined time (using a sysctl attribute). This way the brute force a=
ttack
is mitigated and the system does not panic.

I think that this is a better solution than the other one since this is a =
per
system solution. And I believe that with a default value for the blocking =
time
(sysctl attribute) could be useful in a generic way (for most usages).

The proposal using prctl will need more actions from userspace and it is n=
ot a
generic one due to it is a per process solution.

> What do you think?

Thanks,
John Wood
