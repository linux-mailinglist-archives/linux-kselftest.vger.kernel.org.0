Return-Path: <linux-kselftest+bounces-6204-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C9C7D8782F6
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Mar 2024 16:15:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED26E1C2122B
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Mar 2024 15:15:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3217E4E1DD;
	Mon, 11 Mar 2024 15:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N6oPkcks"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CD1C4AEEB
	for <linux-kselftest@vger.kernel.org>; Mon, 11 Mar 2024 15:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710169961; cv=none; b=GrYvgnxTgBttqT85dD7fvPPs73UayC3GwDn+9tPOhLIyHdGaqv2bl060zDwcmTcKxLJ1r7kIOCQex6li+/gFuPl/FOYDvVu5V30DUqLjRPgv9DaxMqqQOeLyxC/kXc4ZmEZc5H+gFVmyZ1dzsHlCVb143N6yUFuhyJCetp+jFkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710169961; c=relaxed/simple;
	bh=HMpsWkv6oR0Mn/wtHivc+mMHzHEDW9Er+SUgU1Du56A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pQjebnc7MqS9zmYMoQeKaZ4q4u0fL/yL9xuLC6i/Mo1Bm6uVLP+4wrpmTdeNIZwUDxBo/QLWgkGH84JLpKO7CyVPiVcU9rNoHWmG2Zx8Pt3idfloLmeYYDZlHEyvLY5w+M/zRaxJ9U1CIYlrGzwsIHXK6wa3vOfQp3t0J8XxpSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N6oPkcks; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710169958;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AFanvjXG3rXgRJ8bbFZLl5XUXc6amGVnuEQBqyJ9x9c=;
	b=N6oPkckse+6J4xzjqH+ki7Nfsp1NQW0JQfVkbvrY00JScz0O70NJnpMbMMr/Q+5DQdffxB
	EI/Us3bPV7FjHf7WfMhp5bDG/Jw8D5oyXysyt4NeO0Dfsd1KbLzGWpYFnLoDRiiDy1OHxY
	QHU7ggQiI0RpQHeRoOJpt6UabwKhAGc=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-60-fNTTV7NsPlSza6_CDgvw6w-1; Mon, 11 Mar 2024 11:12:36 -0400
X-MC-Unique: fNTTV7NsPlSza6_CDgvw6w-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-690ab2b0de1so14033946d6.0
        for <linux-kselftest@vger.kernel.org>; Mon, 11 Mar 2024 08:12:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710169956; x=1710774756;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AFanvjXG3rXgRJ8bbFZLl5XUXc6amGVnuEQBqyJ9x9c=;
        b=s/Y1gxOMk0Va3Qq4vEok91B1CL5pFMPhih9m3ykK9IMTtho4P92cfv+YSeviKxtz//
         Jj8JC8DNN54bntQw+pgHhs0yV8v7xqH6dAKZXfz++ppGWq9tOz5URxUjhwsYcYKcCXHR
         CSKBy1uDNTjT3oZHAi4swEylItYWKRncsDkn2ttnh2HcKosHlkewjg35DoqrXOUpu2xF
         YfmNwZNx8IvRpU/hrf20m+gI0plxnPD7VfvHmhIWm3pfklKcOD40NrrK1AIPhvKaqp2W
         Fa88K3hNTLH+hh7Z+z0CLiRI78/U54u0NsJM2oVJVp8Q0deWRV0J1jIO2lZ7i1Wx2dxN
         Uh7g==
X-Forwarded-Encrypted: i=1; AJvYcCVUieulxWGZBWfszpKZP5t9kveGmlSqop4pME4ClPJVqE2kt4gPmjFIN/7e6kP3EDRG5MjakezMxq08OD9rmDJxryqYcDZuvnpZm+JKf5iT
X-Gm-Message-State: AOJu0YxJjC/rCYrs9vz3rjCfu+2QTjRo15vsqU2ZM43StVb659kmJr+9
	Rw/JtL8Kobg0TiDt/4sa1yNcTA5AR5aiAy00zVsLDpQmJRWqUmX0Aa/TgnzQRwzEnl15ga92/Kk
	cgQlIikauI8zGdwaOD5RWKC+UMS8/c10G0dhUKXhgrtNz+xDF4z7XCrse0z34Evq0qw==
X-Received: by 2002:ac8:5f83:0:b0:42e:ddf9:9aed with SMTP id j3-20020ac85f83000000b0042eddf99aedmr9709639qta.3.1710169955897;
        Mon, 11 Mar 2024 08:12:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFgS0vpduQhbNU6Es5e7zITzendlncyrCParQzSDx1src5DiL1ZtFEh1SFUyLgdnb237oLtsA==
X-Received: by 2002:ac8:5f83:0:b0:42e:ddf9:9aed with SMTP id j3-20020ac85f83000000b0042eddf99aedmr9709604qta.3.1710169955433;
        Mon, 11 Mar 2024 08:12:35 -0700 (PDT)
Received: from x1n (cpe688f2e2cb7c3-cm688f2e2cb7c0.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id c18-20020a05620a0cf200b007871bac855fsm2767216qkj.47.2024.03.11.08.12.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Mar 2024 08:12:35 -0700 (PDT)
Date: Mon, 11 Mar 2024 11:12:32 -0400
From: Peter Xu <peterx@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>, linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Axel Rasmussen <axelrasmussen@google.com>
Subject: Re: BUG selftests/mm]
Message-ID: <Ze8fYF5I4mlUGHd9@x1n>
References: <a9e3120d-8b79-4435-b113-ceb20aa45ee2@alu.unizg.hr>
 <4a5c8d28-7f73-4c15-b288-641f0ccc91c2@redhat.com>
 <Ze8Wr2qH8V0LMi_5@x1n>
 <b5ff4c70-6379-4cc7-8c92-778d80a6a658@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b5ff4c70-6379-4cc7-8c92-778d80a6a658@redhat.com>

On Mon, Mar 11, 2024 at 03:48:14PM +0100, David Hildenbrand wrote:
> On 11.03.24 15:35, Peter Xu wrote:
> > On Mon, Mar 11, 2024 at 10:31:41AM +0100, David Hildenbrand wrote:
> > > On 09.03.24 20:12, Mirsad Todorovac wrote:
> > > > Hi,
> > > > 
> > > > Routine run of the test in net-next gave also this mm unit error.
> > > > 
> > > > root@defiant:tools/testing/selftests/mm# ./uffd-unit-tests
> > > > Testing UFFDIO_API (with syscall)... done
> > > > Testing UFFDIO_API (with /dev/userfaultfd)... done
> > > > Testing register-ioctls on anon... done
> > > > Testing register-ioctls on shmem... done
> > > > Testing register-ioctls on shmem-private... done
> > > > Testing register-ioctls on hugetlb... skipped [reason: memory allocation failed]
> > > > Testing register-ioctls on hugetlb-private... skipped [reason: memory allocation failed]
> > > > Testing zeropage on anon... done
> > > > Testing zeropage on shmem... done
> > > > Testing zeropage on shmem-private... done
> > > > Testing zeropage on hugetlb... skipped [reason: memory allocation failed]
> > > > Testing zeropage on hugetlb-private... skipped [reason: memory allocation failed]
> > > > Testing move on anon... done
> > > > Testing move-pmd on anon... done
> > > > Testing move-pmd-split on anon... done
> > > > Testing wp-fork on anon... done
> > > > Testing wp-fork on shmem... done
> > > > Testing wp-fork on shmem-private... done
> > > > Testing wp-fork on hugetlb... skipped [reason: memory allocation failed]
> > > > Testing wp-fork on hugetlb-private... skipped [reason: memory allocation failed]
> > > > Testing wp-fork-with-event on anon... done
> > > > Testing wp-fork-with-event on shmem... done
> > > > Testing wp-fork-with-event on shmem-private... done
> > > > Testing wp-fork-with-event on hugetlb... skipped [reason: memory allocation failed]
> > > > Testing wp-fork-with-event on hugetlb-private... skipped [reason: memory allocation failed]
> > > > Testing wp-fork-pin on anon... done
> > > > Testing wp-fork-pin on shmem... done
> > > > Testing wp-fork-pin on shmem-private... done
> > > > Testing wp-fork-pin on hugetlb... skipped [reason: memory allocation failed]
> > > > Testing wp-fork-pin on hugetlb-private... skipped [reason: memory allocation failed]
> > > > Testing wp-fork-pin-with-event on anon... done
> > > > Testing wp-fork-pin-with-event on shmem... done
> > > > Testing wp-fork-pin-with-event on shmem-private... done
> > > > Testing wp-fork-pin-with-event on hugetlb... skipped [reason: memory allocation failed]
> > > > Testing wp-fork-pin-with-event on hugetlb-private... skipped [reason: memory allocation failed]
> > > > Testing wp-unpopulated on anon... done
> > > > Testing minor on shmem... done
> > > > Testing minor on hugetlb... skipped [reason: memory allocation failed]
> > > > Testing minor-wp on shmem... done
> > > > Testing minor-wp on hugetlb... skipped [reason: memory allocation failed]
> > > > Testing minor-collapse on shmem... done
> > > > Testing sigbus on anon... done
> > > > Testing sigbus on shmem... done
> > > > Testing sigbus on shmem-private... done
> > > > Testing sigbus on hugetlb... skipped [reason: memory allocation failed]
> > > > Testing sigbus on hugetlb-private... skipped [reason: memory allocation failed]
> > > > Testing sigbus-wp on anon... done
> > > > Testing sigbus-wp on shmem... done
> > > > Testing sigbus-wp on shmem-private... done
> > > > Testing sigbus-wp on hugetlb... skipped [reason: memory allocation failed]
> > > > Testing sigbus-wp on hugetlb-private... skipped [reason: memory allocation failed]
> > > > Testing events on anon... done
> > > > Testing events on shmem... done
> > > > Testing events on shmem-private... done
> > > > Testing events on hugetlb... skipped [reason: memory allocation failed]
> > > > Testing events on hugetlb-private... skipped [reason: memory allocation failed]
> > > > Testing events-wp on anon... done
> > > > Testing events-wp on shmem... done
> > > > Testing events-wp on shmem-private... done
> > > > Testing events-wp on hugetlb... skipped [reason: memory allocation failed]
> > > > Testing events-wp on hugetlb-private... skipped [reason: memory allocation failed]
> > > > Testing poison on anon... done
> > > > Testing poison on shmem... done
> > > > Testing poison on shmem-private... done
> > > > Testing poison on hugetlb... skipped [reason: memory allocation failed]
> > > > Testing poison on hugetlb-private... skipped [reason: memory allocation failed]
> > > > Userfaults unit tests: pass=42, skip=24, fail=0 (total=66)
> > > > root@defiant:tools/testing/selftests/mm# grep -i huge /proc/meminfo
> > > > 
> > > > It resulted in alarming errors in the syslog:
> > > > 
> > > > Mar  9 19:48:24 defiant kernel: [77187.055103] MCE: Killing uffd-unit-tests:1321817 due to hardware memory corruption fault at 4631e000
> > > > Mar  9 19:48:24 defiant kernel: [77187.055132] MCE: Killing uffd-unit-tests:1321817 due to hardware memory corruption fault at 46320000
> > > > Mar  9 19:48:24 defiant kernel: [77187.055160] MCE: Killing uffd-unit-tests:1321817 due to hardware memory corruption fault at 46322000
> > > > Mar  9 19:48:24 defiant kernel: [77187.055189] MCE: Killing uffd-unit-tests:1321817 due to hardware memory corruption fault at 46324000
> > > > Mar  9 19:48:24 defiant kernel: [77187.055218] MCE: Killing uffd-unit-tests:1321817 due to hardware memory corruption fault at 46326000
> > > > Mar  9 19:48:24 defiant kernel: [77187.055250] MCE: Killing uffd-unit-tests:1321817 due to hardware memory corruption fault at 46328000
> > > > Mar  9 19:48:24 defiant kernel: [77187.055278] MCE: Killing uffd-unit-tests:1321817 due to hardware memory corruption fault at 4632a000
> > > > Mar  9 19:48:24 defiant kernel: [77187.055307] MCE: Killing uffd-unit-tests:1321817 due to hardware memory corruption fault at 4632c000
> > > > Mar  9 19:48:24 defiant kernel: [77187.055336] MCE: Killing uffd-unit-tests:1321817 due to hardware memory corruption fault at 4632e000
> > > > Mar  9 19:48:24 defiant kernel: [77187.055366] MCE: Killing uffd-unit-tests:1321817 due to hardware memory corruption fault at 46330000
> > > > Mar  9 19:48:24 defiant kernel: [77187.055395] MCE: Killing uffd-unit-tests:1321817 due to hardware memory corruption fault at 46332000
> > > > Mar  9 19:48:24 defiant kernel: [77187.055423] MCE: Killing uffd-unit-tests:1321817 due to hardware memory corruption fault at 46334000
> > > > Mar  9 19:48:24 defiant kernel: [77187.055452] MCE: Killing uffd-unit-tests:1321817 due to hardware memory corruption fault at 46336000
> > > > Mar  9 19:48:24 defiant kernel: [77187.055480] MCE: Killing uffd-unit-tests:1321817 due to hardware memory corruption fault at 46338000
> > > > Mar  9 19:48:24 defiant kernel: [77187.055509] MCE: Killing uffd-unit-tests:1321817 due to hardware memory corruption fault at 4633a000
> > > > Mar  9 19:48:24 defiant kernel: [77187.055538] MCE: Killing uffd-unit-tests:1321817 due to hardware memory corruption fault at 4633c000
> > > > Mar  9 19:48:24 defiant kernel: [77187.055567] MCE: Killing uffd-unit-tests:1321817 due to hardware memory corruption fault at 4633e000
> > > > Mar  9 19:48:24 defiant kernel: [77187.055597] MCE: Killing uffd-unit-tests:1321817 due to hardware memory corruption fault at 46340000
> > > > 
> > > > At this point, it can be problem with my box's memory chips, or something with HUGETLB.
> > > > 
> > > > However, since the "classic" allocations were successful, the problem might be in huge pages, or
> > > > if I understood well, in deliberate poisoning of pages?
> > > > 
> > > 
> > > Isn't that just the (expected) side effect of UFFDIO_POISON tests?
> > > 
> > > IOW, there is no problem here. We are poisoning virtual memory locations
> > > (not actual memory) and expect a SIGBUS on next access. While testing that,
> > > we receive these messages.
> > 
> > Correct.
> > 
> > > 
> > > The "ugly" thing here seems to be that we can trigger repeated pr_err() from
> > > user space. There is no rate-limiting in place. Maybe UFFDIO_POISON requires
> > > root permissions so this cannot be exploited by unprivileged user space to
> > > flood the system log?
> > > 
> > > CCing Axel
> > 
> > This is pretty unfortunate.
> > 
> > I'm not concerned too much on flooding whoever kicks off the selftests, but
> > indeed this seems to be able to be used by anyone to trigger such endless
> > reports in dmesg.
> 
> Right.
> 
> > 
> > The issue with requiring a privilege means any hypervisor that will need to
> > use this to emulate memory errors will also require such privilege, and it
> > can be a problem.
> > 
> 
> Yes, we don't want that.
> 
> > Logically such "hwpoison errors" are not real so it is not needed to be
> > reported in dmesg, but now we're leveraging it to be exactly the same as a
> > real hw error to share the code path, iiuc (e.g. on MCE injections).
> > 
> > One option is to use a different marker reflecting that such hwpoison error
> > is internal, so we don't need to report in dmesg. That'll also require
> > (besides another bit in pte markers) one extra VM_FAULT_* flag just for
> > such reports.  Might be slightly an overkill, but I don't see another
> > better way; not reporting HWPOISON will complicate at least kvm use case
> > even more.
> > 
> > Or.. does syslog has its own protection in general for such printk floods?
> > It'll be easier if that's not a concern to flood then, but I'm not sure
> > from that regard.
> 
> From what I know, flooding is considered problematic and we fix it up using
> "Fixes:" commits. See 1b0a151c10a6d823f033023b9fdd9af72a89591b as one
> "recent" example.
> 
> 
> Usually we switch to the _ratelimited() functions, maybe
> pr_warn_ratelimited() is good enough? But we'd lose some details on a "real"
> MCE storm, though.

Yeah, I didn't consider that previously because I thought leaking MCE
addresses might be a problem.

But now thinking it again, it'll be great if pr_err_ratelimited() works
here (I think we'd still want to report them with "err" not "warnings",
btw).

I don't worry too much on MCE storm, as in that case explicit addresses may
not be necessary if the whole system is on risk.  What I don't know however
is whether the addresses may still matter if e.g. two continuous MCEs are
reported in a small time window, and whether those addresses are a concern
in that case if some got lost.

My MCE experience is pretty limited, so I don't have an answer to that.
Maybe it can be verified by proposing a patch like that and see whether
there can be any objections making it rate limtied.  I'll leave that to
Axel to decide how to move forward.

-- 
Peter Xu


