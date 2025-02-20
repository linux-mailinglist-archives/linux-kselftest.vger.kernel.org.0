Return-Path: <linux-kselftest+bounces-27091-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A11F8A3E13F
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Feb 2025 17:47:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D833861C28
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Feb 2025 16:42:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2296720C034;
	Thu, 20 Feb 2025 16:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=ps.report@gmx.net header.b="AAH6RtOs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B82A204F94;
	Thu, 20 Feb 2025 16:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740069773; cv=none; b=g8O3K+wD7VOUaWh94ZEnzzU0RaEm3TtVIO3G2rdPX+pQmiUpVawXFkqH5B0ALCoUyRZhcg/D9AFf8OOX9QediXdHmyUyZ/gO9sJwoEIivPjTERzRxphgj6xzg29L+LZkQ+MicPuu18L9ZH54r03KQAteu2w3QP2A8b6MRoOOUu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740069773; c=relaxed/simple;
	bh=TyF2ayKpMm46GfD1uhuhdbmEN9rqSGiJuim9sc9YwYI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h1NI0YvNdzO0sCeRVqSCxweOhG+dOm48lA8GeH2SnT3aTha6+lm8ilOCtQ+0ZMQppv027nph5jJkhhqAIFloIHxgjMLOMBUZOIddbtkQzB9SI3Uo3gsKoP3DJrx0IpSIutoKHQO68rZz4ueMjpDkNlfNxQ8ajvHZly7i7jY2NEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=ps.report@gmx.net header.b=AAH6RtOs; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1740069764; x=1740674564; i=ps.report@gmx.net;
	bh=3gIHR+1Hskw6PNg4oX6KHQBcDIh4fTIr6P2sgTgzBQM=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=AAH6RtOsjXxBJ5DafzdmNZKNGXj5RlL9hZ7dW/G1ZmOnXn3bCDH3AcJxxHsEbyOs
	 JWHNYEbjeTApONOeZqFpA0PL0kjAAxI5QHvMGxPWFicGkJT5c1tu/mBdo6wsD5aXi
	 IFKWsZknztFxRz1D0tfzIX4lS3Kbra2yo5g4vq/RrsyvhUlIFuPZAOvSr5KxDKkdi
	 3mIvM/KWXdZ6ws7pB/UtXSSNd/zjmzAXUYZ5JQOXjCIlLc7xoAAo/YrVmoYW5/Yzy
	 6VcFNpy4k4nnX8zFApqi8XhcRIY+zk3hG6m2TLjMDaQ8brNQ7/1+7mKo9AMOF33Gm
	 gM3Facv+GYfXGpU9eA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from localhost ([82.135.81.223]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N33Ib-1tLg8k47vZ-00u5U2; Thu, 20
 Feb 2025 17:42:44 +0100
Date: Thu, 20 Feb 2025 17:42:43 +0100
From: Peter Seiderer <ps.report@gmx.net>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Alessandro Zanni <alessandro.zanni87@gmail.com>, brauner@kernel.org,
 shuah@kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] selftests: pid_namespace and pidfd missing include
Message-ID: <20250220174243.3be95c89@gmx.net>
In-Reply-To: <f189e844-7d3c-4bca-9006-c949963e74b3@linuxfoundation.org>
References: <20250128170447.12918-1-alessandro.zanni87@gmail.com>
	<CABq9Dx53aaX1t2Jidi_zDtR6VDB4UvWo1LkO5GYhCnwfs3ycsQ@mail.gmail.com>
	<f189e844-7d3c-4bca-9006-c949963e74b3@linuxfoundation.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Y5a3ffvbeuM0UPQlpnbyR51Snw6JI+PydHLnCB/7kTGgj9yBNoP
 v0gnfaZpSkqQJ++wVReTkYPEBlCMQRpizo2oy8mAu40fpb6F0S6Dcsmi0wogwS/iCP/T5NB
 Ru/qq+lQFtDNn2yRhortBX09mS7JGTEiu4i+Y6vjYP1cWmqjmW92ofJgj23+Rs/HjFWkCRp
 FG9ku5ILiF8QfKP8ZqLMw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:R9KunLk4sUU=;pVGBljgvBmXIZUtuxbSjRzzMApJ
 pxt/ridXDCKnFGz5pNVzaFU6wXA08M9DavdJmFTkKbV0vkhbZ2W+aGm3Sc+frj4UedSThKZ8V
 /bSplENmXkRXSTIzGxb5l2QcGm3lGcWxftKG4rN3dnGf4bXsw0M9t88nYyX0CPW2KFS0QfZG8
 AXPZisSwasXN+LvqsAmow6bzeLhF3BPF4C6kSPmxK9rTAfLQ4YHuixd8yRntM/esZsklm7D6c
 +FBeaR5vU69oVkRMrEm0+xur1ZqxoWQcs6fE7ssd0Jto1KwycvCrGhPwrgDycxjhW04yX7UGn
 vknQOVCKKq5OkqEMIqQiObxoMfC3VpOUWuhAKeK+Z59en/iJ2911ubHhfZpJe+jeiquUBUWeU
 kcc0YPvRTHXCS2r0dPCZPy51STs77wOp0XitrtLVH+vS4iAwGqxPc4ipAyEFhizvp8U52h34k
 5GvC1utyZqVzCPbPxbCrBi6RLL2D2n50bTLYJpK2KMX+TyAItJYQ8hor6TplyYyGvluuFo/wL
 szMiNjWgDEGUVajxU5aJfIAuhNEybo5nsuYac4y7Ee+9L+mE2skvhZbhBB0var0BWSBJemiIo
 rCCFLMHypeSOGoC2ekv5ZaNzckytaEi8sr/VKXj6Kus2FnjEOtUy7Cvi04XLegDxRB5uz+0vC
 Y4uIIr6NxgzWdTJczDRIjo0WUa4gUWPL/LdMXgUKtqo9syUDWCsEMq0oHbaaDqsi8YF3lYBYB
 pXoij11Gh4YsWp0/tcqOseotzwAePbiWzDWg2ZZu42nrY3iQyWjp+XwP0hSoz/s3rCdOi8aJb
 DcGeKUSo1iJeFfJOMsKP6VrFAuq4Zcv2ISVcxnR5GTqCL9m+QIS9N5Ry7py3HddrsWRzpORSR
 KFQQ/Z+oTytORaIrG8CSVQ+VxxNv1Zl0rqHg7sSU7U1Uah89DjGbCm7QeHAtNdwZ8TVy7sn5s
 /sI6fmgHkkvxZ1Af7koBPqDknqpwC1oJqFgp3UqDNojZY56A/7XeSPqftKjzA2YZyoFOIOSLo
 gOXs4K8asRdThjXVIMSh9+b0+kE5x7LsIP9DJSIgSV+tBAHBAY44i3ACaicUcPQSkgZyqxIbw
 h9dxAabl0evBVQk8i7gplpK6Xhu1Ob/T7XiuFtH4rTMuE0miNKOimxR4ir45N5eHm2X918hok
 /5IE8Bz/wLC7kfbZ7xLOkYLnDA0dh5NAjvEIUZJUrbdoQrFu/ZyaDC7Wi9Rw884eB5ecgd0bZ
 R1YjQaxo3MQNWENUSxPGEz60q5fMad5aCOA8BUnCETJiR8eetXa8ev5O1iyDEAlDpSg/K93Ps
 RE5OaoUqxXyAUm4UAoZtYJPDxKPQ1yoQHHDjiUSOaAJJgHxTMVqEqq1MOCsGZt8Ltp1tN6IQD
 ep9oHvc+3hlcpt8DkQ9YdZAG5+KjaOBO0bHyzdK29Rxg2A2gywv2pYmlpj

On Tue, 18 Feb 2025 17:26:19 -0700, Shuah Khan <skhan@linuxfoundation.org> =
wrote:

> On 2/12/25 17:24, Alessandro Zanni wrote:
> >> Running "make kselftest" results in several errors like these:
> >>
> >> pidfd_fdinfo_test.c:231:36: error: =E2=80=98MS_REC=E2=80=99 undeclared=
 (first use in
> >> this function)
> >>    231 |         r =3D mount(NULL, "/", NULL, MS_REC | MS_PRIVATE, 0);
> >>
> >> pidfd_fdinfo_test.c:231:45: error: =E2=80=98MS_PRIVATE=E2=80=99 undecl=
ared (first use
> >> in this function); did you mean =E2=80=98MAP_PRIVATE=E2=80=99?
> >>    231 |         r =3D mount(NULL, "/", NULL, MS_REC | MS_PRIVATE, 0);
> >>
> >> pid_max.c:48:9: warning: implicit declaration of function =E2=80=98umo=
unt2=E2=80=99;
> >> did you mean =E2=80=98SYS_umount2=E2=80=99? [-Wimplicit-function-decla=
ration]
> >>     48 |         umount2("/proc", MNT_DETACH);
> >>
> >> This patch adds the <sys/mount.h> include in pidfd_fdinfo_test.c and
> >> pid_max.c files to find the variables MS_REC, MS_PRIVATE, MNT_DETACH.
> >>
> >> Signed-off-by: Alessandro Zanni <alessandro.zanni87@gmail.com>
> >> ---
> >>   tools/testing/selftests/pid_namespace/pid_max.c   | 1 +
> >>   tools/testing/selftests/pidfd/pidfd_fdinfo_test.c | 1 +
> >>   2 files changed, 2 insertions(+)
> >>
> >> diff --git a/tools/testing/selftests/pid_namespace/pid_max.c b/tools/t=
esting/selftests/pid_namespace/pid_max.c
> >> index 51c414faabb0..972bedc475f1 100644
> >> --- a/tools/testing/selftests/pid_namespace/pid_max.c
> >> +++ b/tools/testing/selftests/pid_namespace/pid_max.c
> >> @@ -11,6 +11,7 @@
> >>   #include <string.h>
> >>   #include <syscall.h>
> >>   #include <sys/wait.h>
> >> +#include <sys/mount.h>
> >>
> >>   #include "../kselftest_harness.h"
> >>   #include "../pidfd/pidfd.h"
> >> diff --git a/tools/testing/selftests/pidfd/pidfd_fdinfo_test.c b/tools=
/testing/selftests/pidfd/pidfd_fdinfo_test.c
> >> index f062a986e382..f718aac75068 100644
> >> --- a/tools/testing/selftests/pidfd/pidfd_fdinfo_test.c
> >> +++ b/tools/testing/selftests/pidfd/pidfd_fdinfo_test.c
> >> @@ -13,6 +13,7 @@
> >>   #include <syscall.h>
> >>   #include <sys/wait.h>
> >>   #include <sys/mman.h>
> >> +#include <sys/mount.h>
> >>
> >>   #include "pidfd.h"
> >>   #include "../kselftest.h"
> >> --
> >> 2.43.0 =20

Predated patches already available, see

        https://lore.kernel.org/linux-kselftest/20250115105211.390370-1-ps.=
report@gmx.net/
        https://lore.kernel.org/linux-kselftest/20250115105211.390370-2-ps.=
report@gmx.net/
	https://lore.kernel.org/linux-kselftest/20250115105211.390370-3-ps.report@=
gmx.net/

Regards,
Peter

~                                                                          =
    =20
~                    =20
> >=20
> > Hello,
> >=20
> > I'm reaching out to know if you have any comments or
> > feedbacks about this patch.
> >  =20
>=20
> Christian, would you like me to pick this patch up?
>=20
> thanks,
> -- Shuah


