Return-Path: <linux-kselftest+bounces-46933-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67E93C9EB72
	for <lists+linux-kselftest@lfdr.de>; Wed, 03 Dec 2025 11:32:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 921E43A6C35
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Dec 2025 10:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F35662EDD78;
	Wed,  3 Dec 2025 10:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DIXlDOcE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C8B12EC56F
	for <linux-kselftest@vger.kernel.org>; Wed,  3 Dec 2025 10:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764757938; cv=none; b=KqufBgBZvN0luOH/ut7NGpWekJ6teytKOSyuhVPqh0b6FatSvMDRcLpyrhqhc1xNfsqgESWl4tPUGc2K5gDLBkl7MFHvSE6zJmLLmzNoJvI6GOMZ2Hv2n6bqKFBRQSjFS5TLRovWx25XYEE46b4QlDs4plxwToKQXXDHE5D7cHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764757938; c=relaxed/simple;
	bh=2aOcCjl3M0B1t8QPIlt4/5AQoGR7I2VJ4KYXHNVnF9A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s2wM8sXg/g2xOMJzgysKrkLUXy1uTeTYgvRJzPp6B7iRyhjMAkDVZA0Bk3H85ekEsFOnJX9zOL7Da6fDMe49QQJZLzmJ4g4rp+n9lGOnYkoeAZAis2ttcDxGzzpA4IGndHCNm5ytmOrL2EEXN+Hj4QNT5Wg0Sg3iDNHwfFv14LI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DIXlDOcE; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-640d0ec9651so11613602a12.3
        for <linux-kselftest@vger.kernel.org>; Wed, 03 Dec 2025 02:32:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764757935; x=1765362735; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UcqkI9Xd4pMaIL7B+Xnf+RODe2LidpZwWFDHvB1Tt0o=;
        b=DIXlDOcE5HQbNqxjV4C6idorUyGEk13TCgo0TGRCxPjivECC8edEMe088iirAZxzyM
         sCkYRq06Eam5CaFltpP+Puz1Vv5odDAZOT/+RdIgW6r7bWaV3bU/UXiRN/0WblnUizv4
         OdhJMbyod0Nexs3Mutz+33KbOj6aIM6PgD0R9Pz0JoFzeNFXGMlDXcPM3c3soSAMZnH2
         v7QoRhFHimHqF6C+I+pUU/j3tjc8NWQ9HQev554/WkdOzXXOISB/CJTrB8ud1udUF48C
         ejj0SuZh1/3+ybjcFmxroHaQPSwqebPaKz5f41VDj/y+WJEukmSaK1F4TBE4NyTr4JXc
         yU1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764757935; x=1765362735;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UcqkI9Xd4pMaIL7B+Xnf+RODe2LidpZwWFDHvB1Tt0o=;
        b=FTRMtRqnKYdlN4Jg+ZW3q/Q3D5mBV9cfv9AIq2Q2tsndxsf1sD9xUIVV/3QQRFfzkN
         LE0uye5BMTS+FLW6h+aggGhdgKRyErSaJWt6givJ9EAkBJ9/V9EXKrHFQ1WfXoYO+e+B
         +e0vdKRn5YKSv3HMhlUplpPGxM7VhLPcs+m+zYevQGzGffA4ovivm9tD1VoafbQ4pUyO
         bF6U4/ojEwEaAqiuarg4lJVBN+SOX5YpQFmtZfm0CPnZVlIp2uMHKwO02UW89wWw+6SI
         o2qz8wfh4mdzCp6LV8vFez18fS0db8AWMtuk3fa3aFm+yQFKEQvg3MPOyEnExunRvCWm
         +9dQ==
X-Forwarded-Encrypted: i=1; AJvYcCXBLZOTsd4xNGzYlhu+4iHlvRITdeqtPjpl9eUBY1KgZdcvnz3nxAtZe+fTtjphnXMqmGA6WC+lKkt8w66DOQE=@vger.kernel.org
X-Gm-Message-State: AOJu0YznfqcmWNUge7OKU8Ds9T7+CNQjNH2BkFAVP0YWZ3I6F813Otle
	wKqF1SAQxy3CIoGBgMfVvfYHUr3leX4QBTHMXMLJT17gH7O+o0Y7o1VAi8OIbeJByA==
X-Gm-Gg: ASbGncs8QjzZDbN1a5/Hr3bI7E9NuI9LaFIEFWRzxng6Mi94F8AqupBOub2UEZ6hRqJ
	YWj1G7LEDMofgvoT91UNeizcqztP6TADMe/p0auyQQR2nfspCvpi6MJJvsMy/oiZZ+klMwfakkg
	DvG4dk2CElTUQykOPPXzCWFRtimse2NuArlXbdT6ITKdqm9sGGQdLppklKB0bMAhv3PRVd4M1T6
	8/Oxkvgt/Kw4pD7kHR+7H1g3fXIkfMqmPOl1keu6QOFouL68NpSvkWJjqBSn6buIx63iF3tds++
	rS6XQiTwHsIvKQWGmJQzTUKcPZTOhPz7IZhNtlv4QPR3UBWLtwXa9eqPc0WuZCBirIM2yhUgkTz
	feqDOZjazR4iE8+D/My2OyVFfnKhkPfp6IJ18i+bBXctRs/Dbo89GgNxscTxI3eVuzAWSwlFs7V
	+OpVABB+L7POzalWaGLz2g3TLMoym3fX7FYBFjN8dfABpChEvPLRRoNLBd
X-Google-Smtp-Source: AGHT+IEAY85Pq3Z+N4w3Oj4K17isL6Bl9lnWw+LXYqAqN863wp8c0ApWNgbwOUam/wsgef5nVp4zjQ==
X-Received: by 2002:a05:6402:1472:b0:640:80f4:3914 with SMTP id 4fb4d7f45d1cf-6479c4f6ff8mr1426286a12.19.1764757934636;
        Wed, 03 Dec 2025 02:32:14 -0800 (PST)
Received: from google.com (49.185.141.34.bc.googleusercontent.com. [34.141.185.49])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-64751062261sm20113764a12.33.2025.12.03.02.32.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Dec 2025 02:32:14 -0800 (PST)
Date: Wed, 3 Dec 2025 10:32:10 +0000
From: Matt Bobrowski <mattbobrowski@google.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Shuran Liu <electronlsr@gmail.com>, Song Liu <song@kernel.org>,
	bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>,
	Daniel Xu <dxu@dxuuu.xyz>,
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
	Shuah Khan <shuah@kernel.org>, Zesen Liu <ftyg@live.com>,
	Peili Gao <gplhust955@gmail.com>,
	Haoran Ni <haoran.ni.cs@gmail.com>
Subject: Re: [PATCH bpf v3 2/2] selftests/bpf: fix and consolidate d_path LSM
 regression test
Message-ID: <aTARqrMyC36CXa_L@google.com>
References: <20251202141944.2209-1-electronlsr@gmail.com>
 <20251202141944.2209-3-electronlsr@gmail.com>
 <CAADnVQJQj=mdFbPf7nmc0+qZVC4RCK5AbJvNQv2W--tvGyzzVA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQJQj=mdFbPf7nmc0+qZVC4RCK5AbJvNQv2W--tvGyzzVA@mail.gmail.com>

On Tue, Dec 02, 2025 at 05:21:59PM -0800, Alexei Starovoitov wrote:
> On Tue, Dec 2, 2025 at 6:20 AM Shuran Liu <electronlsr@gmail.com> wrote:
> >
> > Add a regression test for bpf_d_path() when invoked from an LSM program.
> > The test attaches to the bprm_check_security hook, calls bpf_d_path() on
> > the binary being executed, and verifies that a simple prefix comparison on
> > the returned pathname behaves correctly after the fix in patch 1.
> >
> > To avoid nondeterminism, the LSM program now filters based on the
> > expected PID, which is populated from userspace before the test binary is
> > executed. This prevents unrelated processes that also trigger the
> > bprm_check_security LSM hook from overwriting test results. Parent and
> > child processes are synchronized through a pipe to ensure the PID is set
> > before the child execs the test binary.
> >
> > Per review feedback, the new LSM coverage is merged into the existing
> > d_path selftest rather than adding new prog_tests/ or progs/ files. The
> > loop that checks the pathname prefix now uses bpf_for(), which is a
> > verifier-friendly way to express a small, fixed-iteration loop, and the
> > temporary /tmp/bpf_d_path_test binary is removed in the test cleanup
> > path.
> >
> > Co-developed-by: Zesen Liu <ftyg@live.com>
> > Signed-off-by: Zesen Liu <ftyg@live.com>
> > Co-developed-by: Peili Gao <gplhust955@gmail.com>
> > Signed-off-by: Peili Gao <gplhust955@gmail.com>
> > Co-developed-by: Haoran Ni <haoran.ni.cs@gmail.com>
> > Signed-off-by: Haoran Ni <haoran.ni.cs@gmail.com>
> > Signed-off-by: Shuran Liu <electronlsr@gmail.com>
> > Reviewed-by: Matt Bobrowski <mattbobrowski@google.com>
> > ---
> >  .../testing/selftests/bpf/prog_tests/d_path.c | 65 +++++++++++++++++++
> >  .../testing/selftests/bpf/progs/test_d_path.c | 33 ++++++++++
> >  2 files changed, 98 insertions(+)
> >
> > diff --git a/tools/testing/selftests/bpf/prog_tests/d_path.c b/tools/testing/selftests/bpf/prog_tests/d_path.c
> > index ccc768592e66..202b44e6f482 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/d_path.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/d_path.c
> > @@ -195,6 +195,68 @@ static void test_d_path_check_types(void)
> >         test_d_path_check_types__destroy(skel);
> >  }
> >
> > +static void test_d_path_lsm(void)
> > +{
> > +       struct test_d_path *skel;
> > +       int err;
> > +       int pipefd[2];
> > +       pid_t pid;
> > +
> > +       skel = test_d_path__open_and_load();
> > +       if (!ASSERT_OK_PTR(skel, "d_path skeleton failed"))
> > +               return;
> > +
> > +       err = test_d_path__attach(skel);
> > +       if (!ASSERT_OK(err, "attach failed"))
> > +               goto cleanup;
> > +
> > +       /* Prepare the test binary */
> > +       system("cp /bin/true /tmp/bpf_d_path_test 2>/dev/null || :");
> > +
> > +       if (!ASSERT_OK(pipe(pipefd), "pipe failed"))
> > +               goto cleanup;
> > +
> > +       pid = fork();
> > +       if (!ASSERT_GE(pid, 0, "fork failed")) {
> > +               close(pipefd[0]);
> > +               close(pipefd[1]);
> > +               goto cleanup;
> > +       }
> > +
> > +       if (pid == 0) {
> > +               /* Child */
> > +               char buf;
> > +
> > +               close(pipefd[1]);
> > +               /* Wait for parent to set PID in BPF map */
> > +               if (read(pipefd[0], &buf, 1) != 1)
> > +                       exit(1);
> > +               close(pipefd[0]);
> > +               execl("/tmp/bpf_d_path_test", "/tmp/bpf_d_path_test", NULL);
> > +               exit(1);
> > +       }
> 
> No forks please. They often make selftest to be flaky.
> Use simples possible way to test it.
> Without forks and pipes.

Yeah, I was also a little hesistant about letting this slide.

Shuran, change your BPF program such that you're attached to file_open
instead. That'll make testing from your test runnner far simpler.

