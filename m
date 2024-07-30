Return-Path: <linux-kselftest+bounces-14474-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9B1E9415A0
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Jul 2024 17:46:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70021284689
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Jul 2024 15:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CFBB19FA87;
	Tue, 30 Jul 2024 15:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="UVBJt0pk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5690585628
	for <linux-kselftest@vger.kernel.org>; Tue, 30 Jul 2024 15:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722354387; cv=none; b=RivtZ+09QjgNCfBghQFzAnuWwzFclbuAVW9N6UONLFQwII+jDej/Uo7j6hZnl8XS4bIe5b6vUmmGRvdbIe6Ga7H2JL1Z6iCDEl6ydOqEh1cEexU5IaB3ORF1IUb2X9a02TxDXNbk+e29lrMCShMVP9v1NXBQ+1D6Q8rzRO0IfT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722354387; c=relaxed/simple;
	bh=yFVGl3IncTdtYdA43geU7rnxB9K1xpXsgvTVqUqWeq0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IzTO2ycu/75gZ4UcsA/jmSUtLRUXZ982qg0PFIGTHLMAzMAUwMFFZNJrsou17BMgc/wUliQ1QrYGazCBwx7GRQ1txE99lh09hf/Y3UIjMAnOO6+loMEIcTpyfP1C2WB+jcIfSpWKeijo+TI8fTWKaKR2XqVGCuUu/N8+DWJ7Z7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=UVBJt0pk; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a7abe5aa9d5so562220966b.1
        for <linux-kselftest@vger.kernel.org>; Tue, 30 Jul 2024 08:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1722354383; x=1722959183; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yRC8EpL8O0R6ThyQIF5jdND8pmO+k3m9i0jeg+m0dq0=;
        b=UVBJt0pkshaeV455lPh1bvwNp7A6yMY2tNh3383eGlCnw0qE9AgsTUY/MTk3bKwjKG
         6JlYv2VQYrHMXcMI+Nvb3557VBYKcZMJx7qGSZsr2103duDDRZofEA7A6MqtNCIolIzM
         /pbZxTmacmCWzr8zud33w2SIwJvZ37C93RAFh9CSeHfAdIAgBCw+nyA795sIePLdwFlk
         N53SokCT+VRH6qI6MDt6WGRm9EpR0Pv4FTg5/Z4AeBuVFMSaccXGUuLuoIhHAgzAXal/
         IbXjEWv1JwxCiV/kxW8ZNuCJ+q0sU1giaLEISTlfzI6Fa4/yiDQcv/SlX/vwL31l6isP
         /lKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722354383; x=1722959183;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yRC8EpL8O0R6ThyQIF5jdND8pmO+k3m9i0jeg+m0dq0=;
        b=oJSD5s5+HymYe3y+LvvDAuqyLB/2Mx2AZjpYNXDBkfzJFWh4eP/motreIYi6RtAnPF
         yUBi271nTdiLBVhJ12EXLMw7UNHX1T2aTh9o/Z+fOh7ls8fihhQKH+cAGChASHUaABep
         Eft6UhBK4mlVFlfxZSYto4BN8tb1oiOXZVk3Ao5pAqs8W7abHTbmW6B9EG+pDwP3uaxl
         M2V9LDUprvd0Gp6mcxq3vSVqrmD4/qSkRAot5xi5OD84azv35KTuB93bgkt40qKHtaqi
         eoSv3rBxeU67w+NLJRIDW+lvFL1/GQmGyVJ5gGPKAlaw5LB67lx5IMWpum5G3a44i0OU
         KgRQ==
X-Forwarded-Encrypted: i=1; AJvYcCWbbIeAvJXpHWg6ePbd+ceZJEhFoHb9+OXAymXVf6gMI0jv4ytAoagc9iFpt+f7mr8GwDS2ctgPfLfk/f1WHBoQK7sNivV/BVfQseOyezj0
X-Gm-Message-State: AOJu0Yxlq32yUfRxHepHjNLfE5z7MLDVGEqE/FKaV1AVQhP+bF61WC0K
	yl1rnzNC5YzGtJlaATmzMmVkO4rwWWO3/LuhrvgNw1fwNSVYV729vEOliMu75Wg=
X-Google-Smtp-Source: AGHT+IEfShq2dlD0DfRiwM7bhyC9H1giL0hs81+b3W/KP3MMitXJ+IPNIAfmGBJOB3tFyCz+0fCaCg==
X-Received: by 2002:a17:907:8692:b0:a6f:e47d:a965 with SMTP id a640c23a62f3a-a7d40064576mr768295166b.41.1722354383418;
        Tue, 30 Jul 2024 08:46:23 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acab23125sm659769766b.1.2024.07.30.08.46.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 08:46:22 -0700 (PDT)
Date: Tue, 30 Jul 2024 17:46:21 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: David Finkel <davidf@vimeo.com>
Cc: Muchun Song <muchun.song@linux.dev>, Tejun Heo <tj@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	core-services@vimeo.com, Jonathan Corbet <corbet@lwn.net>, 
	Michal Hocko <mhocko@kernel.org>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Shuah Khan <shuah@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Zefan Li <lizefan.x@bytedance.com>, cgroups@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v6 2/2] mm, memcg: cg2 memory{.swap,}.peak write tests
Message-ID: <arkcd6cjf42zq62maqsbjzvimxwozrkukusgxhd54v6eyd6ylq@aurn3mek6hr2>
References: <20240729143743.34236-1-davidf@vimeo.com>
 <20240729143743.34236-3-davidf@vimeo.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5y6eempyzjoj5ljb"
Content-Disposition: inline
In-Reply-To: <20240729143743.34236-3-davidf@vimeo.com>


--5y6eempyzjoj5ljb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello.

On Mon, Jul 29, 2024 at 10:37:43AM GMT, David Finkel <davidf@vimeo.com> wrote:
> Extend two existing tests to cover extracting memory usage through the
> newly mutable memory.peak and memory.swap.peak handlers.

BTW do the tests pass for you?

I gave it a try (v6.11-rc1+your patches)

$ grep "not ok 2" -B30 test.strace

...
315   15:19:13.990351 read(6, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 4096) = 4096
315   15:19:13.994457 read(6, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 4096) = 4096
315   15:19:13.998562 read(6, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 4096) = 4096
315   15:19:13.998652 read(6, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 4096) = 4096
315   15:19:14.002759 read(6, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 4096) = 4096
315   15:19:14.006864 openat(AT_FDCWD, "/sys/fs/cgroup/memcg_test/memory.current", O_RDONLY) = 7
315   15:19:14.006989 read(7, "270336\n", 127) = 7
315   15:19:14.011114 close(7)          = 0
315   15:19:14.015262 close(6)          = 0
315   15:19:14.015448 exit_group(-1)    = ?
315   15:19:14.019753 +++ exited with 255 +++
313   15:19:14.019820 <... wait4 resumed>[{WIFEXITED(s) && WEXITSTATUS(s) == 255}], 0, NULL) = 315
313   15:19:14.019878 --- SIGCHLD {si_signo=SIGCHLD, si_code=CLD_EXITED, si_pid=315, si_uid=0, si_status=255, si_utime=1 /* 0.01 s */, -
313   15:19:14.019926 close(3)          = 0
313   15:19:14.020001 close(5)          = 0
313   15:19:14.020072 close(4)          = 0
313   15:19:14.024173 rmdir("/sys/fs/cgroup/memcg_test") = 0
313   15:19:14.028517 write(1, "not ok 2 test_memcg_current_peak"..., 33) = 33

grep "^315 .*read.*4096" -c test.strace
12800

Hopefully, unrelated to your changes. I ran this within initrd (rapido
image) so it may be an issue how rootfs pagecache is undercharged (due
to sharing?), instead of 50M, there's only ~256k.

To verify, I also tried with memory.peak patch reverted, failing
differently:

...
238   15:30:29.034623 openat(AT_FDCWD, "/sys/fs/cgroup/memcg_test/memory.current", O_RDONLY) = 3
238   15:30:29.034766 read(3, "52801536\n", 127) = 9
238   15:30:29.038895 close(3)          = 0
238   15:30:29.043048 openat(AT_FDCWD, "/sys/fs/cgroup/memcg_test/memory.stat", O_RDONLY) = 3
238   15:30:29.043230 read(3, "anon 52436992\nfile 0\nkernel 1105"..., 4095) = 870
238   15:30:29.047379 close(3)          = 0
238   15:30:29.051491 munmap(0x7f2473600000, 52432896) = 0
238   15:30:29.058516 exit_group(0)     = ?
238   15:30:29.062992 +++ exited with 0 +++
237   15:30:29.067054 <... wait4 resumed>[{WIFEXITED(s) && WEXITSTATUS(s) == 0}], 0, NULL) = 238
237   15:30:29.067136 --- SIGCHLD {si_signo=SIGCHLD, si_code=CLD_EXITED, si_pid=238, si_uid=0, si_status=0, si_utime=1 /* 0.01 s */, si-
237   15:30:29.067210 openat(AT_FDCWD, "/sys/fs/cgroup/memcg_test/memory.peak", O_RDONLY) = 3
237   15:30:29.071349 read(3, "52805632\n", 127) = 9
237   15:30:29.075470 close(3)          = 0
237   15:30:29.075562 openat(AT_FDCWD, "/sys/fs/cgroup/memcg_test/memory.peak", O_RDWR|O_APPEND|O_CLOEXEC) = 3
237   15:30:29.079712 openat(AT_FDCWD, "/sys/fs/cgroup/memcg_test/memory.peak", O_RDWR|O_APPEND|O_CLOEXEC) = 4
237   15:30:29.083848 openat(AT_FDCWD, "/sys/fs/cgroup/memcg_test/memory.peak", O_RDWR|O_APPEND|O_CLOEXEC) = 5
237   15:30:29.083970 write(3, "reset\n\0", 7) = -1 EINVAL (Invalid argument)
237   15:30:29.088095 close(3)          = 0
237   15:30:29.092209 close(4)          = 0
237   15:30:29.092295 close(5)          = 0
237   15:30:29.096398 close(-1)         = -1 EBADF (Bad file descriptor)
237   15:30:29.100497 rmdir("/sys/fs/cgroup/memcg_test") = 0
237   15:30:29.100760 write(1, "not ok 2 test_memcg_current_peak"..., 33) = 33

This failure makes sense but it reminded me --
could you please modify the test so that it checks write permission
of memory.peak and skips the reset testing on old(er) kernels? That'd be
in accordance with other cgroup selftest that maintain partial backwards
compatibility when possible.

Thanks,
Michal

--5y6eempyzjoj5ljb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZqkKygAKCRAt3Wney77B
SRUAAP4/N9esJbrEK3Dc8W7fMPFhJO2vSYHkWLaM8DmxVvSNLwD/e6VjqMIAdSUh
SFcFj4YkO6Uy6D5wFhGyjPQbmHi3lwg=
=GgTK
-----END PGP SIGNATURE-----

--5y6eempyzjoj5ljb--

