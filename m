Return-Path: <linux-kselftest+bounces-6230-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 74B5D878A08
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Mar 2024 22:27:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A62DF1C20E95
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Mar 2024 21:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7449956B79;
	Mon, 11 Mar 2024 21:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nWhV9131"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97C2556B74
	for <linux-kselftest@vger.kernel.org>; Mon, 11 Mar 2024 21:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710192431; cv=none; b=a3xodZLcKbWhZjFVFG4Sx/gPDPkVcpNKLdl6zYaobAyabBLWJYltGWbbYsFaBSZxX9VieDRSg1VpIok3IAdy/W/FjJPR9HU/rRdouSwlTJBUn+JpYOxxDVzQcI+iG2X95xW0c1/G/lZ2m8XV0kab5VeGMscB5wUZgwoMObprfrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710192431; c=relaxed/simple;
	bh=3BnoVAabTHfz7RxiwPnAvsouS24/it3klbkmoAucGoM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BMIK2+YSPiyWrICyrEeTNNTaBIy38E4q0VKvfy+spIFpjywCEYHUNRJj82qzI/5JFF89BgcZDMtZ3R9IYY88+Ejluj1qV2gNThFWcXBj0zeLDNM1TxExgn6epQO928mVlZKfkKrrgT+9kET5C19Uqio5ez2OskOoaNP6sKBbQZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nWhV9131; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-428405a0205so26721cf.1
        for <linux-kselftest@vger.kernel.org>; Mon, 11 Mar 2024 14:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710192428; x=1710797228; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m48wge07cFCwEV0aIRK1/eMraB2WL2eyhOFlH9G55x8=;
        b=nWhV9131v0cWtSxiPRC8ON4MPk77pbwhQY79XEQ+N8t3NLjFTZ2rwWMvO+qjRe0TcD
         T5hwdgU19SnqMs56PcUrZjgAK6TCD2sytrxKBWvmRrr+CthMYV+dyboVjl1TZMTfY7DO
         Zmkh1gSkmdAWhIGve6KJVS1YMpHEu5/hT2XA4VxS/71oReM3BxskQvu44LWleuPCd3ou
         bzHGj4reDfI7qGgVSXfmCdoUp2NudmaRb01wsDuxk0yNF5+pG1rMmMuz0PpE0MPn4Lmp
         rZfyLbrblkVtjN+8WD/J8S+tnTWR3GV5Ls8AJEXfXjbdXBWTTzdJGPHSAQAeufs9zhNT
         fpkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710192428; x=1710797228;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m48wge07cFCwEV0aIRK1/eMraB2WL2eyhOFlH9G55x8=;
        b=pLml00URGvvKOeJzJes8NlVHO30Km/gYaY2wN9LtUzCTLKTWosJqJGUBSj2IR4IqYs
         1xaD7NE94rOZLqxwQsVB7byPLpuZKSinDc+DlqMZ+WAL6IR0Pm/m4M30lu7kZqyWE+6j
         pYiZLC3N0Aol5hLqukifP69uerKLXngh3zvITTQqT/TNcfdoyTDuhOV28DnqEb1fvhJE
         t2cLyQD7e6g8mWbhT82iDBDoPNN7ury0CxmvyjUVnSXL3nHAhaq9+exPlez2Mid9EA44
         nvAcByzv8oXSdo240WI1hLy9NqXmgwAAQvBWF9vTNnuE/7jZ2MNslUPFHXUyT6puXj6n
         zgmQ==
X-Forwarded-Encrypted: i=1; AJvYcCVwXXaH7SdDdvGehutOhTMCyjHRNo/TngBXF3mQvrOszdHCHTOxc1b3zk+vj1WAVpNscNeFPRSYPRO+5fK+t3+Md2lH3hyCaDkhRMK1sHxL
X-Gm-Message-State: AOJu0YyLX0FrqQkc3VsRXSV3gp3PU7Di7Fa4H2BQTSXPVqDn1HEugG41
	3OR1tm7boy0kbOzP8enEOl0yHpzVT84veNGA1hja5wxe6UzzbzJ0583ThG9Y8VHFrzWNFrXhA2V
	4jisGkAfGubYELliOY98iTWScIqPifDhnbcyM
X-Google-Smtp-Source: AGHT+IENS5NfjfXK7lN5Bkxy+P/3Qds/aQw6f0kFGWmkfLobVusHnbA/vMcsIs5jQjYU26B8DLKAFQMYIyJE+GAoPU4=
X-Received: by 2002:a05:622a:4481:b0:42f:a3c:2d4f with SMTP id
 kb1-20020a05622a448100b0042f0a3c2d4fmr61762qtb.16.1710192428294; Mon, 11 Mar
 2024 14:27:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <a9e3120d-8b79-4435-b113-ceb20aa45ee2@alu.unizg.hr>
 <4a5c8d28-7f73-4c15-b288-641f0ccc91c2@redhat.com> <Ze8Wr2qH8V0LMi_5@x1n>
 <b5ff4c70-6379-4cc7-8c92-778d80a6a658@redhat.com> <Ze8fYF5I4mlUGHd9@x1n>
 <CAJHvVcie+N+4j60m_Dxh7QzbZLmsjnq2-04peuqE8VkkMq984A@mail.gmail.com> <Ze9bWkrD6UBZ2ErV@x1n>
In-Reply-To: <Ze9bWkrD6UBZ2ErV@x1n>
From: James Houghton <jthoughton@google.com>
Date: Mon, 11 Mar 2024 14:26:32 -0700
Message-ID: <CADrL8HW59nt4ztY3x5G3VgpmaXQbXoXZeAjvzMp7SpsqxgDCxw@mail.gmail.com>
Subject: Re: BUG selftests/mm]
To: Peter Xu <peterx@redhat.com>
Cc: Axel Rasmussen <axelrasmussen@google.com>, David Hildenbrand <david@redhat.com>, 
	Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>, linux-mm@kvack.org, 
	Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jiaqi Yan <jiaqiyan@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 11, 2024 at 12:28=E2=80=AFPM Peter Xu <peterx@redhat.com> wrote=
:
>
> On Mon, Mar 11, 2024 at 11:59:59AM -0700, Axel Rasmussen wrote:
> > I'd prefer not to require root or CAP_SYS_ADMIN or similar for
> > UFFDIO_POISON, because those control access to lots more things
> > besides, which we don't necessarily want the process using UFFD to be
> > able to do. :/

I agree; UFFDIO_POISON should not require CAP_SYS_ADMIN.

> >
> > Ratelimiting seems fairly reasonable to me. I do see the concern about
> > dropping some addresses though.
>
> Do you know how much could an admin rely on such addresses?  How frequent
> would MCE generate normally in a sane system?

I'm not sure about how much admins rely on the address themselves. +cc
Jiaqi Yan

It's possible for a sane hypervisor dealing with a buggy guest / guest
userspace to trigger lots of these pr_errs. Consider the case where a
guest userspace uses HugeTLB-1G, finds poison (which HugeTLB used to
ignore), and then ignores SIGBUS. It will keep getting MCEs /
SIGBUSes.

The sane hypervisor will use UFFDIO_POISON to prevent the guest from
re-accessing *real* poison, but we will still get the pr_err, and we
still keep injecting MCEs into the guest. We have observed scenarios
like this before.

>
> > Perhaps we can mitigate that concern by defining our own ratelimit
> > interval/burst configuration?
>
> Any details?
>
> > Another idea would be to only ratelimit it if !CONFIG_DEBUG_VM or
> > similar. Not sure if that's considered valid or not. :)
>
> This, OTOH, sounds like an overkill..
>
> I just checked again on the detail of ratelimit code, where we by default
> it has:
>
> #define DEFAULT_RATELIMIT_INTERVAL      (5 * HZ)
> #define DEFAULT_RATELIMIT_BURST         10
>
> So it allows a 10 times burst rather than 2.. IIUC it means even if
> there're continous 10 MCEs it won't get suppressed, until the 11th came, =
in
> 5 seconds interval.  I think it means it's possibly even less of a concer=
n
> to directly use pr_err_ratelimited().

I'm okay with any rate limiting everyone agrees on. IMO, silencing
these pr_errs if they came from UFFDIO_POISON (or, perhaps, if they
did not come from real hardware MCE events) sounds like the most
correct thing to do, but I don't mind. Just don't make UFFDIO_POISON
require CAP_SYS_ADMIN. :)

Thanks.

