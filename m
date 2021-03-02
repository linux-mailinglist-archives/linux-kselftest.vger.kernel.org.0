Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E562C32BCF3
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Mar 2021 23:09:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234829AbhCCPGb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 3 Mar 2021 10:06:31 -0500
Received: from mout.gmx.net ([212.227.17.22]:53411 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234298AbhCBSnL (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 2 Mar 2021 13:43:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1614710365;
        bh=yCkaUQfVe3q+lFu5gCVoEdjBCOmBnrzmeMXvU+zyOWI=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=Z93Ueahc/J52n8dNsCcueRlcuBftsHsUHJESjn3E/XsL8c9NqhJZVkpi1r0yMs7Ty
         /EyV+IWxCptf271B8cJjp6cYk2xUsaiybR42mtsGGr/P32nDzBJFoTO1FkZjcQ8M48
         YyhJIF0KGm/H5XxVOof62fsn+Re4h5jPUx8UkmVk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ubuntu ([83.52.229.153]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M5wPb-1lAJEN448x-007X9e; Tue, 02
 Mar 2021 19:39:25 +0100
Date:   Tue, 2 Mar 2021 19:39:20 +0100
From:   John Wood <john.wood@gmx.com>
To:     kernel test robot <oliver.sang@intel.com>
Cc:     John Wood <john.wood@gmx.com>, 0day robot <lkp@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>,
        James Morris <jmorris@namei.org>,
        Shuah Khan <shuah@kernel.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-doc@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        kernel-hardening@lists.openwall.com
Subject: Re: [security/brute]  cfe92ab6a3: WARNING:inconsistent_lock_state
Message-ID: <20210302183920.GB3049@ubuntu>
References: <20210227153013.6747-3-john.wood@gmx.com>
 <20210302054941.GA23892@xsang-OptiPlex-9020>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210302054941.GA23892@xsang-OptiPlex-9020>
X-Provags-ID: V03:K1:SMulKwKZ5mn8riOEfhU3TLcHfPC51QPIxJU6Nfk+e0ZTxy1gycj
 +pT1PyxKfSDHUS6yRCkNlhBhTK2i7ym2vK5iAwPAciZnAvrsX6yXN2LY3ccnJX9nKTSHOwm
 R5GsWhjSxYj4gmMdQEIhwmuPSFdxYdK+IqDsgRy6DokG0ZwpDAUbx+jy+XTZ7BNBGcJPJXK
 KP4CxRu/NsTu5nFs4ahiw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:MsUK9Gbt9OA=:WKsNNDYEj3dj2C0laVyeAx
 nygW/4H8c59CitOYyDWkw2sJYb9+fhSmH4WrpskkbVbKVoq2aLhJA/0684c+0H36N3T6lB66Y
 mzYVzk/cgmbIqKbghIWm8aqf3klcTbgQ45PFTUFs3egqWSXwjfdNiV+BS7bkoWFZI2qYbFpRy
 9co0WFmV3KzSrWF5fU0vvZrTLlfoUbFqPc8wfTAFG+0zyT2HRGSf/uztnX3CvyQp25Ja8yGRT
 DaCOrwNBlHujIyS3zPi85zZFbKEQuzeTL8aB7W1pA34paXW6dT7gnyc7P68hD6Uqd/0Jvp8R8
 A6rUYlV17FwX7vqCNHzqVyMnAOOntEVdkaD62uCRDzWZQfaIDYqvXtaQu2/nQveWJugyrPL0y
 XDxVe9jRya37FCn4asRTLyw05WM2YrBRRhBRvRc0cJIIErUoMzY+10C5/rus+ByeACJvJvFa7
 zacbiCXqyXAdjnDYmzy6W2l/38bYGRWIOGYJnAegZ0lGLr7CIVDuKnPtZQOm/GUCwVPVy1pxA
 TmqNpFQyynwAWCkBvqKFK+WFSb4eSEFXa/XXsRK5c7wpw8OPFgYqCdsUKgR6O0UTXMSuJC6pu
 ErTOlWlXnOPRch8v+d63AAtO9Tt4K/kRG6xkhO5j7Lg+KxVviXtNk7Qf94jQPl6BSwJpYeNCw
 q4aXm6MwAaIggA2O5PSpx0wn6AlmYmBRjPIbY6V04JjFOFywt8lT4NRD/S9DiZlSyWtJafDh2
 jMVm+OFCG07wOE3YHelm6FsTeq+KBCz/NO47Go4cZ0tEastaew43AOGHJAFM/13pgZTQLj9tW
 NuAd5J4EqCqABX/X/5/vHBzDZucpJqVcGw+80Wz5guyCgs5FRI9wGwMvgmFzVT2iFWqoRJ4bM
 mwkDtxx9Iyj/R2jOFSeg==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Mar 02, 2021 at 01:49:41PM +0800, kernel test robot wrote:
>
>
> Greeting,
>
> FYI, we noticed the following commit (built with gcc-9):
>
> commit: cfe92ab6a3ea700c08ba673b46822d51f38d6b40 ("[PATCH v5 2/8] securi=
ty/brute: Define a LSM and manage statistical data")
> url: https://github.com/0day-ci/linux/commits/John-Wood/Fork-brute-force=
-attack-mitigation/20210228-022911
> base: https://git.kernel.org/cgit/linux/kernel/git/shuah/linux-kselftest=
.git next
>
> in testcase: trinity
> version: trinity-static-i386-x86_64-f93256fb_2019-08-28
> with following parameters:
>
> 	group: ["group-00", "group-01", "group-02", "group-03", "group-04"]
>
> test-description: Trinity is a linux system call fuzz tester.
> test-url: http://codemonkey.org.uk/projects/trinity/
>
>
> on test machine: qemu-system-i386 -enable-kvm -cpu SandyBridge -smp 2 -m=
 8G
>
> caused below changes (please refer to attached dmesg/kmsg for entire log=
/backtrace):
>
>
> +-----------------------------------------------------------------------=
--+------------+------------+
> |                                                                       =
  | 1d53b7aac6 | cfe92ab6a3 |
> +-----------------------------------------------------------------------=
--+------------+------------+
> | WARNING:inconsistent_lock_state                                       =
  | 0          | 6          |
> | inconsistent{IN-SOFTIRQ-W}->{SOFTIRQ-ON-W}usage                       =
  | 0          | 6          |
> +-----------------------------------------------------------------------=
--+------------+------------+
>
>
> If you fix the issue, kindly add following tag
> Reported-by: kernel test robot <oliver.sang@intel.com>
>
>
> [  116.852721] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [  116.853120] WARNING: inconsistent lock state
> [  116.853120] 5.11.0-rc7-00013-gcfe92ab6a3ea #1 Tainted: G S
> [  116.853120] --------------------------------
>
> [...]

Thanks for the report. I will work on this for the next version.

> Thanks,
> Oliver Sang

Thanks,
John Wood
