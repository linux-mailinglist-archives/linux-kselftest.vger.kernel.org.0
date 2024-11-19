Return-Path: <linux-kselftest+bounces-22218-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F7659D1D4D
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Nov 2024 02:30:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54A5128276F
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Nov 2024 01:30:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 166D84D599;
	Tue, 19 Nov 2024 01:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="k8lzIUIs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E940347B4
	for <linux-kselftest@vger.kernel.org>; Tue, 19 Nov 2024 01:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731979835; cv=none; b=eJXEp5LAoPPYqhZJ/WGnCS7Wp2GnLnX7svDqqBmasUZHrkF9N8mp2NFh7bp8NGj3FAzpYk++2QbQo9rVtQzHRMk4LP8Q/KRxDzFX3/PzXra0SspemOn9SRUKrsWGoCrxbHDONVax3shFvHz60GkIxaEiWasuZVO4DKNoulb+dV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731979835; c=relaxed/simple;
	bh=dwhbrEEfePVbvJU2Ozddu2A4+flvh6qun9KERWZBa38=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MERQH5Eo1luiCuYSBPDoKsDEAQhFTy/w/C5uCDsFaebdkn5ye35iRKbhQpZi1Y9MbcPBJGccWYWlTfPAYk4fULjrSKPOhAbEUoT1YAuoiXpE9rvjdml/NPMANG+On1AaEsh68FWUZLU4BUDrEs2pfqEgKVWHAE4RPMQUnbC2O80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=k8lzIUIs; arc=none smtp.client-ip=209.85.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-856f7d1ee73so937484241.3
        for <linux-kselftest@vger.kernel.org>; Mon, 18 Nov 2024 17:30:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1731979832; x=1732584632; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dwhbrEEfePVbvJU2Ozddu2A4+flvh6qun9KERWZBa38=;
        b=k8lzIUIsmYElffpbh57rlY3tRxUBQ7HRQZILiWErsvaby4Cd9m5Y+ixX0pOAIwxI2l
         hMNomGeRJwFJKbhkwHbsRNBjw4hzfn5R5PCNTcoFkK6fVthKO3qRuOb2rU1QLV7Wgqps
         MPjmY7qjE10pmxF2MCLONbn0lz7+5gMQWekRntaCbhGWP2TBjnIKAAnNfWvZS6D618RW
         OPSb4YuDI1c0sQrKybSfkm25ptjvCJgvkgPcfU5oO+S8isODuIdUSm8inbfXJaRYqbzB
         KTf42sNiJBhJeuNMw/ntrBARMYfNDUhQfgMhb8CrnEBpvT0MtUU4ePeoBKRe0L55X/PD
         VlWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731979832; x=1732584632;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dwhbrEEfePVbvJU2Ozddu2A4+flvh6qun9KERWZBa38=;
        b=BZ/3E42WY+/2+1D04JYqjN1uU/JThfqEcCIuZbxJWE5I2Yc9pqyjCXc2z05HSihRly
         WFi+lB43LSiST/7befJT41u40BmTWObkahq62aBlEC6IyCHHR1MxXnoWSCs8QlTC+SO1
         +83NqMdU3CsY9fkm3wVWhlbgOLdaDAPe4zzQHmkEdSZ0MTeHEwD8hj3xhj+K+qQKbBhc
         WhEVXp9LHqGkvkg8dKB262JRcvymKkHmfBWZFMDEwwuOLxhvpeGlpFIhKOezn7JRZFMR
         XOydPMEZ1qYnMbyCEAcA8F8cuwDwMF+/wKt7zG2qW8ArCyklZ+95kVT3qzI4HYl3tl5x
         RNKw==
X-Forwarded-Encrypted: i=1; AJvYcCUc3XlBC0KUjibycqKNra4wktR91b/VZRSs4xoJJKPjiZIUi16AT39K6cTqjh8Lx1Xf1Zg5EFqumisbVEEMxec=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSGNGLK9xN7ucVU0Ass/ofWaQ6MmMmzkgB5lD2Qt3CUFzW9nI+
	g87Fsqm0LOVaPbLrBDhvqMC1UP/MPtS0Nm/VmZHboi+ytmxmlZaMyGay/DRPBS4Of4lPvI3aJq0
	PZq8ak5tskuhWxzbKiDg/6T+DTHNDtmjlgIyfLQ==
X-Google-Smtp-Source: AGHT+IEnblF5WP9b6MMjtXTC6Vjj1Iy7OkpDZ4PeMU+Uc4InANfSMt/pice9eNGMRdH2BcrKEejfz0Ajo3xoxrMqxY0=
X-Received: by 2002:a05:6102:3f04:b0:4a9:14:3ee9 with SMTP id
 ada2fe7eead31-4ad62d52711mr12363521137.23.1731979832190; Mon, 18 Nov 2024
 17:30:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241116175922.3265872-1-pasha.tatashin@soleen.com>
 <a0372f7f-9a85-4d3e-ba20-b5911a8189e3@lucifer.local> <CAG48ez2vG0tr=H8csGes7HN_5HPQAh4WZU8U1G945K1GKfABPg@mail.gmail.com>
 <CA+CK2bB0w=i1z78AJbr2gZE9ybYki4Vz_s53=8URrxwyPvvB+A@mail.gmail.com> <CAG48ez1KFFXzy5qcYVZLnUEztaZxDGY2+4GvwYq7Hb=Y=3FBxQ@mail.gmail.com>
In-Reply-To: <CAG48ez1KFFXzy5qcYVZLnUEztaZxDGY2+4GvwYq7Hb=Y=3FBxQ@mail.gmail.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Mon, 18 Nov 2024 20:29:55 -0500
Message-ID: <CA+CK2bCBwZFomepG-Pp6oiAwHQiKdsTLe3rYtE3hFSQ5spEDww@mail.gmail.com>
Subject: Re: [RFCv1 0/6] Page Detective
To: Jann Horn <jannh@google.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	cgroups@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	akpm@linux-foundation.org, corbet@lwn.net, derek.kiernan@amd.com, 
	dragan.cvetic@amd.com, arnd@arndb.de, gregkh@linuxfoundation.org, 
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, tj@kernel.org, 
	hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev, 
	shakeel.butt@linux.dev, muchun.song@linux.dev, Liam.Howlett@oracle.com, 
	vbabka@suse.cz, shuah@kernel.org, vegard.nossum@oracle.com, 
	vattunuru@marvell.com, schalla@marvell.com, david@redhat.com, 
	willy@infradead.org, osalvador@suse.de, usama.anjum@collabora.com, 
	andrii@kernel.org, ryan.roberts@arm.com, peterx@redhat.com, oleg@redhat.com, 
	tandersen@netflix.com, rientjes@google.com, gthelen@google.com, 
	linux-hardening@vger.kernel.org, 
	Kernel Hardening <kernel-hardening@lists.openwall.com>
Content-Type: text/plain; charset="UTF-8"

> Can you point me to where a refcounted reference to the page comes
> from when page_detective_metadata() calls dump_page_lvl()?

I am sorry, I remembered incorrectly, we are getting reference right
after dump_page_lvl() in page_detective_memcg() -> folio_try_get(); I
will move the folio_try_get() to before dump_page_lvl().

> > > So I think dump_page() in its current form is not something we should
> > > expose to a userspace-reachable API.
> >
> > We use dump_page() all over WARN_ONs in MM code where pages might not
> > be locked, but this is a good point, that while even the existing
> > usage might be racy, providing a user-reachable API potentially makes
> > it worse. I will see if I could add some locking before dump_page(),
> > or make a dump_page variant that does not do dump_mapping().
>
> To be clear, I am not that strongly opposed to racily reading data
> such that the data may not be internally consistent or such; but this
> is a case of racy use-after-free reads that might end up dumping
> entirely unrelated memory contents into dmesg. I think we should
> properly protect against that in an API that userspace can invoke.
> Otherwise, if we race, we might end up writing random memory contents
> into dmesg; and if we are particularly unlucky, those random memory
> contents could be PII or authentication tokens or such.
>
> I'm not entirely sure what the right approach is here; I guess it
> makes sense that when the kernel internally detects corruption,
> dump_page doesn't take references on pages it accesses to avoid
> corrupting things further. If you are looking at a page based on a
> userspace request, I guess you could access the page with the
> necessary locking to access its properties under the normal locking
> rules?

I will take reference, as we already do that for memcg purpose, but
have not included dump_page().

Thank you,
Pasha

