Return-Path: <linux-kselftest+bounces-6224-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AC636878875
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Mar 2024 20:01:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11368B225AD
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Mar 2024 19:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 385B454BDB;
	Mon, 11 Mar 2024 19:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="INx9KZpz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16B30548E8
	for <linux-kselftest@vger.kernel.org>; Mon, 11 Mar 2024 19:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710183656; cv=none; b=u/vkVYIxOJleltNYq5gvEMwX7dT0lBgKLTKM8n/zgJl22F18gnl2HRtm7X/aZR5/jkbIY5CDlFa65RFgjDgCx4Gry3bsa0fxEU2/a3QkDNSgG1guJNCjrYozC/lQNGHsp14ACu0ADXK+zA4vkvRvGjty06lrxvuxX+dg7a9jOhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710183656; c=relaxed/simple;
	bh=KiRKGk/arM86qTUGeUESFhRIwoJzx+sYcCuNEYhGL7M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U80DpmiSZofCiajRF7XpmakyMs9cBm45oVFHQZk4yORWkA/8N8TaqSFrXgz+VKfUMvUy6eAc0Fa3jNZcJzSUSuxkFABd6j/WJkAHXsIZuOXtXF+qPBmlNgXOIHLkgYypU+48oX4Ol6m6wtyyw85nr42K8Sn5kYq4CfJmvNq1Qe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=INx9KZpz; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-33e959d8bc0so1261332f8f.1
        for <linux-kselftest@vger.kernel.org>; Mon, 11 Mar 2024 12:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710183638; x=1710788438; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=92UaEgw1QR+X2SR9bZcDvQ4N0TtiusowEqo+9QUTs/s=;
        b=INx9KZpzCbptIscpwPFoCe+gvFlXcXt0Jfm1cNUw/uF/3J/NxCGK/Fu+fOGPtN9lHc
         0+7tvwDhTTKJiTA1e7GXa14eDCP8eR35i/RFbdiozoqfWtC1T4B2KIFxMtznG7VyNYyH
         RCDaeTRi/IAUA9yfzDNq441kjQH5na643euAxf4q6H10+kaBwOD8qTbhqxJEgduWGTWt
         xCHHAiUVgXXeKCvljIBntxFEVKaUqND+sXS8xtB9ydZN6B6JmFOPMIZW2xaka1v2vskE
         gyviNBq5neI7cKaFDrTnbqrpW2951n9DfaEs8xgxuvd6GV/xQFBgHhNIABY57KTcYygb
         kAPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710183638; x=1710788438;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=92UaEgw1QR+X2SR9bZcDvQ4N0TtiusowEqo+9QUTs/s=;
        b=NZenH4kdi6Xuj/rjioayjC/vXsEq+gLG0StqKn0ixMPCvMuPTEPMqwmx2x8+4Z0hKA
         maRhHXpb3sJLpb6fX7SlNUstrGhOLTFLejcatAMVBudiNntFMYWK7IHqba8nXwkFDtrm
         uoX6H6oqa5rf06pOGj7taox6oAPrEb4d+yZMKV1X3O4UXdjeUrPQgqa2T+5TQ/grhuSH
         2ri+blpluSHeCeM3NrENXgQbJSwqihOHDZdXMLP8//WAj/ZDa2WDD/ODYGcFuHB1Mn2K
         8YErYFlLdZnUqXjW1XyfzXaBH7iGB8t12yaONJoGnuIjMwUIb/egp4T57i0pxET4bAAQ
         lAEg==
X-Forwarded-Encrypted: i=1; AJvYcCX9G625oS7/kNSDW0sYGNs5TL1THuAQlR/sQa9Hnps43K4WI/GWO5VHet7qVfRsMhM8OOXxCNBgLAuqHEAaBCbFhyvNAnZuaeu6KCffSDf4
X-Gm-Message-State: AOJu0YwmAtbCji6ZbvVvCZ8crS+AvqCcBgxFxQLaQuCtcSE+fRsK7coI
	FVeZW+yb3WwqpauoM4q69BxsdxIiTR6+d7dhoevZCQPSusJDMv6tt84EI2BPqH0/ZgZNAHk710i
	W3opF+/LLqZ3umxVXjZPnjkHDmoV1FiZToiF7vPuw5jPUtaEcgQ==
X-Google-Smtp-Source: AGHT+IFqA/7ZEdzACvv2yaoobZtZ/wD0lAiJnn38GnMJ/ie4F+pNJ4+7Jlih62ZraeCYFNkDvJBm2hN+zJgfEq0lXh4=
X-Received: by 2002:adf:fcd2:0:b0:33d:d82e:85c7 with SMTP id
 f18-20020adffcd2000000b0033dd82e85c7mr5519195wrs.47.1710183638305; Mon, 11
 Mar 2024 12:00:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <a9e3120d-8b79-4435-b113-ceb20aa45ee2@alu.unizg.hr>
 <4a5c8d28-7f73-4c15-b288-641f0ccc91c2@redhat.com> <Ze8Wr2qH8V0LMi_5@x1n>
 <b5ff4c70-6379-4cc7-8c92-778d80a6a658@redhat.com> <Ze8fYF5I4mlUGHd9@x1n>
In-Reply-To: <Ze8fYF5I4mlUGHd9@x1n>
From: Axel Rasmussen <axelrasmussen@google.com>
Date: Mon, 11 Mar 2024 11:59:59 -0700
Message-ID: <CAJHvVcie+N+4j60m_Dxh7QzbZLmsjnq2-04peuqE8VkkMq984A@mail.gmail.com>
Subject: Re: BUG selftests/mm]
To: Peter Xu <peterx@redhat.com>
Cc: David Hildenbrand <david@redhat.com>, Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>, linux-mm@kvack.org, 
	Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 11, 2024 at 8:12=E2=80=AFAM Peter Xu <peterx@redhat.com> wrote:
>
> On Mon, Mar 11, 2024 at 03:48:14PM +0100, David Hildenbrand wrote:
> > On 11.03.24 15:35, Peter Xu wrote:
> > > On Mon, Mar 11, 2024 at 10:31:41AM +0100, David Hildenbrand wrote:
> > > > On 09.03.24 20:12, Mirsad Todorovac wrote:
> > > > > Hi,
> > > > >
> > > > > Routine run of the test in net-next gave also this mm unit error.
> > > > >
> > > > > root@defiant:tools/testing/selftests/mm# ./uffd-unit-tests
> > > > > Testing UFFDIO_API (with syscall)... done
> > > > > Testing UFFDIO_API (with /dev/userfaultfd)... done
> > > > > Testing register-ioctls on anon... done
> > > > > Testing register-ioctls on shmem... done
> > > > > Testing register-ioctls on shmem-private... done
> > > > > Testing register-ioctls on hugetlb... skipped [reason: memory all=
ocation failed]
> > > > > Testing register-ioctls on hugetlb-private... skipped [reason: me=
mory allocation failed]
> > > > > Testing zeropage on anon... done
> > > > > Testing zeropage on shmem... done
> > > > > Testing zeropage on shmem-private... done
> > > > > Testing zeropage on hugetlb... skipped [reason: memory allocation=
 failed]
> > > > > Testing zeropage on hugetlb-private... skipped [reason: memory al=
location failed]
> > > > > Testing move on anon... done
> > > > > Testing move-pmd on anon... done
> > > > > Testing move-pmd-split on anon... done
> > > > > Testing wp-fork on anon... done
> > > > > Testing wp-fork on shmem... done
> > > > > Testing wp-fork on shmem-private... done
> > > > > Testing wp-fork on hugetlb... skipped [reason: memory allocation =
failed]
> > > > > Testing wp-fork on hugetlb-private... skipped [reason: memory all=
ocation failed]
> > > > > Testing wp-fork-with-event on anon... done
> > > > > Testing wp-fork-with-event on shmem... done
> > > > > Testing wp-fork-with-event on shmem-private... done
> > > > > Testing wp-fork-with-event on hugetlb... skipped [reason: memory =
allocation failed]
> > > > > Testing wp-fork-with-event on hugetlb-private... skipped [reason:=
 memory allocation failed]
> > > > > Testing wp-fork-pin on anon... done
> > > > > Testing wp-fork-pin on shmem... done
> > > > > Testing wp-fork-pin on shmem-private... done
> > > > > Testing wp-fork-pin on hugetlb... skipped [reason: memory allocat=
ion failed]
> > > > > Testing wp-fork-pin on hugetlb-private... skipped [reason: memory=
 allocation failed]
> > > > > Testing wp-fork-pin-with-event on anon... done
> > > > > Testing wp-fork-pin-with-event on shmem... done
> > > > > Testing wp-fork-pin-with-event on shmem-private... done
> > > > > Testing wp-fork-pin-with-event on hugetlb... skipped [reason: mem=
ory allocation failed]
> > > > > Testing wp-fork-pin-with-event on hugetlb-private... skipped [rea=
son: memory allocation failed]
> > > > > Testing wp-unpopulated on anon... done
> > > > > Testing minor on shmem... done
> > > > > Testing minor on hugetlb... skipped [reason: memory allocation fa=
iled]
> > > > > Testing minor-wp on shmem... done
> > > > > Testing minor-wp on hugetlb... skipped [reason: memory allocation=
 failed]
> > > > > Testing minor-collapse on shmem... done
> > > > > Testing sigbus on anon... done
> > > > > Testing sigbus on shmem... done
> > > > > Testing sigbus on shmem-private... done
> > > > > Testing sigbus on hugetlb... skipped [reason: memory allocation f=
ailed]
> > > > > Testing sigbus on hugetlb-private... skipped [reason: memory allo=
cation failed]
> > > > > Testing sigbus-wp on anon... done
> > > > > Testing sigbus-wp on shmem... done
> > > > > Testing sigbus-wp on shmem-private... done
> > > > > Testing sigbus-wp on hugetlb... skipped [reason: memory allocatio=
n failed]
> > > > > Testing sigbus-wp on hugetlb-private... skipped [reason: memory a=
llocation failed]
> > > > > Testing events on anon... done
> > > > > Testing events on shmem... done
> > > > > Testing events on shmem-private... done
> > > > > Testing events on hugetlb... skipped [reason: memory allocation f=
ailed]
> > > > > Testing events on hugetlb-private... skipped [reason: memory allo=
cation failed]
> > > > > Testing events-wp on anon... done
> > > > > Testing events-wp on shmem... done
> > > > > Testing events-wp on shmem-private... done
> > > > > Testing events-wp on hugetlb... skipped [reason: memory allocatio=
n failed]
> > > > > Testing events-wp on hugetlb-private... skipped [reason: memory a=
llocation failed]
> > > > > Testing poison on anon... done
> > > > > Testing poison on shmem... done
> > > > > Testing poison on shmem-private... done
> > > > > Testing poison on hugetlb... skipped [reason: memory allocation f=
ailed]
> > > > > Testing poison on hugetlb-private... skipped [reason: memory allo=
cation failed]
> > > > > Userfaults unit tests: pass=3D42, skip=3D24, fail=3D0 (total=3D66=
)
> > > > > root@defiant:tools/testing/selftests/mm# grep -i huge /proc/memin=
fo
> > > > >
> > > > > It resulted in alarming errors in the syslog:
> > > > >
> > > > > Mar  9 19:48:24 defiant kernel: [77187.055103] MCE: Killing uffd-=
unit-tests:1321817 due to hardware memory corruption fault at 4631e000
> > > > > Mar  9 19:48:24 defiant kernel: [77187.055132] MCE: Killing uffd-=
unit-tests:1321817 due to hardware memory corruption fault at 46320000
> > > > > Mar  9 19:48:24 defiant kernel: [77187.055160] MCE: Killing uffd-=
unit-tests:1321817 due to hardware memory corruption fault at 46322000
> > > > > Mar  9 19:48:24 defiant kernel: [77187.055189] MCE: Killing uffd-=
unit-tests:1321817 due to hardware memory corruption fault at 46324000
> > > > > Mar  9 19:48:24 defiant kernel: [77187.055218] MCE: Killing uffd-=
unit-tests:1321817 due to hardware memory corruption fault at 46326000
> > > > > Mar  9 19:48:24 defiant kernel: [77187.055250] MCE: Killing uffd-=
unit-tests:1321817 due to hardware memory corruption fault at 46328000
> > > > > Mar  9 19:48:24 defiant kernel: [77187.055278] MCE: Killing uffd-=
unit-tests:1321817 due to hardware memory corruption fault at 4632a000
> > > > > Mar  9 19:48:24 defiant kernel: [77187.055307] MCE: Killing uffd-=
unit-tests:1321817 due to hardware memory corruption fault at 4632c000
> > > > > Mar  9 19:48:24 defiant kernel: [77187.055336] MCE: Killing uffd-=
unit-tests:1321817 due to hardware memory corruption fault at 4632e000
> > > > > Mar  9 19:48:24 defiant kernel: [77187.055366] MCE: Killing uffd-=
unit-tests:1321817 due to hardware memory corruption fault at 46330000
> > > > > Mar  9 19:48:24 defiant kernel: [77187.055395] MCE: Killing uffd-=
unit-tests:1321817 due to hardware memory corruption fault at 46332000
> > > > > Mar  9 19:48:24 defiant kernel: [77187.055423] MCE: Killing uffd-=
unit-tests:1321817 due to hardware memory corruption fault at 46334000
> > > > > Mar  9 19:48:24 defiant kernel: [77187.055452] MCE: Killing uffd-=
unit-tests:1321817 due to hardware memory corruption fault at 46336000
> > > > > Mar  9 19:48:24 defiant kernel: [77187.055480] MCE: Killing uffd-=
unit-tests:1321817 due to hardware memory corruption fault at 46338000
> > > > > Mar  9 19:48:24 defiant kernel: [77187.055509] MCE: Killing uffd-=
unit-tests:1321817 due to hardware memory corruption fault at 4633a000
> > > > > Mar  9 19:48:24 defiant kernel: [77187.055538] MCE: Killing uffd-=
unit-tests:1321817 due to hardware memory corruption fault at 4633c000
> > > > > Mar  9 19:48:24 defiant kernel: [77187.055567] MCE: Killing uffd-=
unit-tests:1321817 due to hardware memory corruption fault at 4633e000
> > > > > Mar  9 19:48:24 defiant kernel: [77187.055597] MCE: Killing uffd-=
unit-tests:1321817 due to hardware memory corruption fault at 46340000
> > > > >
> > > > > At this point, it can be problem with my box's memory chips, or s=
omething with HUGETLB.
> > > > >
> > > > > However, since the "classic" allocations were successful, the pro=
blem might be in huge pages, or
> > > > > if I understood well, in deliberate poisoning of pages?
> > > > >
> > > >
> > > > Isn't that just the (expected) side effect of UFFDIO_POISON tests?
> > > >
> > > > IOW, there is no problem here. We are poisoning virtual memory loca=
tions
> > > > (not actual memory) and expect a SIGBUS on next access. While testi=
ng that,
> > > > we receive these messages.
> > >
> > > Correct.
> > >
> > > >
> > > > The "ugly" thing here seems to be that we can trigger repeated pr_e=
rr() from
> > > > user space. There is no rate-limiting in place. Maybe UFFDIO_POISON=
 requires
> > > > root permissions so this cannot be exploited by unprivileged user s=
pace to
> > > > flood the system log?
> > > >
> > > > CCing Axel
> > >
> > > This is pretty unfortunate.
> > >
> > > I'm not concerned too much on flooding whoever kicks off the selftest=
s, but
> > > indeed this seems to be able to be used by anyone to trigger such end=
less
> > > reports in dmesg.
> >
> > Right.
> >
> > >
> > > The issue with requiring a privilege means any hypervisor that will n=
eed to
> > > use this to emulate memory errors will also require such privilege, a=
nd it
> > > can be a problem.
> > >
> >
> > Yes, we don't want that.
> >
> > > Logically such "hwpoison errors" are not real so it is not needed to =
be
> > > reported in dmesg, but now we're leveraging it to be exactly the same=
 as a
> > > real hw error to share the code path, iiuc (e.g. on MCE injections).
> > >
> > > One option is to use a different marker reflecting that such hwpoison=
 error
> > > is internal, so we don't need to report in dmesg. That'll also requir=
e
> > > (besides another bit in pte markers) one extra VM_FAULT_* flag just f=
or
> > > such reports.  Might be slightly an overkill, but I don't see another
> > > better way; not reporting HWPOISON will complicate at least kvm use c=
ase
> > > even more.
> > >
> > > Or.. does syslog has its own protection in general for such printk fl=
oods?
> > > It'll be easier if that's not a concern to flood then, but I'm not su=
re
> > > from that regard.
> >
> > From what I know, flooding is considered problematic and we fix it up u=
sing
> > "Fixes:" commits. See 1b0a151c10a6d823f033023b9fdd9af72a89591b as one
> > "recent" example.
> >
> >
> > Usually we switch to the _ratelimited() functions, maybe
> > pr_warn_ratelimited() is good enough? But we'd lose some details on a "=
real"
> > MCE storm, though.
>
> Yeah, I didn't consider that previously because I thought leaking MCE
> addresses might be a problem.
>
> But now thinking it again, it'll be great if pr_err_ratelimited() works
> here (I think we'd still want to report them with "err" not "warnings",
> btw).
>
> I don't worry too much on MCE storm, as in that case explicit addresses m=
ay
> not be necessary if the whole system is on risk.  What I don't know howev=
er
> is whether the addresses may still matter if e.g. two continuous MCEs are
> reported in a small time window, and whether those addresses are a concer=
n
> in that case if some got lost.
>
> My MCE experience is pretty limited, so I don't have an answer to that.
> Maybe it can be verified by proposing a patch like that and see whether
> there can be any objections making it rate limtied.  I'll leave that to
> Axel to decide how to move forward.

I'd prefer not to require root or CAP_SYS_ADMIN or similar for
UFFDIO_POISON, because those control access to lots more things
besides, which we don't necessarily want the process using UFFD to be
able to do. :/

Ratelimiting seems fairly reasonable to me. I do see the concern about
dropping some addresses though. Perhaps we can mitigate that concern
by defining our own ratelimit interval/burst configuration? Another
idea would be to only ratelimit it if !CONFIG_DEBUG_VM or similar. Not
sure if that's considered valid or not. :)

>
> --
> Peter Xu
>

