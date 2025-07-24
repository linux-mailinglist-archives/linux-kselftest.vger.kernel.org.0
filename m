Return-Path: <linux-kselftest+bounces-37943-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D029B1088C
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Jul 2025 13:06:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C9A77B4546
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Jul 2025 11:05:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE6A826B747;
	Thu, 24 Jul 2025 11:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="iA9dw+XV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA5026B2AD
	for <linux-kselftest@vger.kernel.org>; Thu, 24 Jul 2025 11:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753355198; cv=none; b=LGguWKM6eE4uQXir5XhZe+lYuZ2nratIspz8i70f1UBSLdGxGDEx67TadrPHo+PRYuaViF/Ux7EJ7LGeojVbWP4QphAbEsaKZ4TDKC/dJh4wdJ5rzHuIOMLHlrDSf26TwobUGMHsJenMNzgUDjOzJgm5LxN1N6mMYlgH5uGbmLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753355198; c=relaxed/simple;
	bh=opm30Mzetdwrd7yWGQcLIe/0luJxPk8qFHzjfEF1aug=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=g9zdDmqzSlkQiqDcYJeC8k2Ahnfyz+baV8BlEtyUEmICxw0s962tH08HdvX3oAIjPbwjby4pcy475LCsZVYb9Cpwfe8G7K3xR8sCy+KDy58wdPg6dndXWYTplRfgU1VMiyP7mBgKrltQ8QqMb3QtnotKOpzZmm94pu0W0noXPkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=iA9dw+XV; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <94c81ecec7e0653705ba8c989ea4842783152232.camel@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1753355193;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tWpGthS9MjyXwtp3VTshonwOqfoau0taDH5LLAGEf+s=;
	b=iA9dw+XV++8/wyHEipuog15Fg6WUH8OAQvXjxWeuXg8SfjEVre/mhWhKC8eliNewXM0H0E
	kHp4Tt1Yge+Sl9oW7brQ8IeSPAK42HMWd9YN2n6RiUw0zkyMNuzGFx3wxnQbMCkUWQQsM/
	nppiSByRrILpas1x3pjbgJurWWRZoI8=
Subject: Re: [PATCH bpf-next v3 3/4] selftests/bpf: Add selftest for
 attaching tracing programs to functions in deny list
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: KaFai Wan <kafai.wan@linux.dev>
To: Yonghong Song <yonghong.song@linux.dev>, ast@kernel.org, 
 daniel@iogearbox.net, john.fastabend@gmail.com, andrii@kernel.org, 
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 kpsingh@kernel.org,  sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
 mykolal@fb.com,  shuah@kernel.org, laoar.shao@gmail.com,
 linux-kernel@vger.kernel.org,  bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, leon.hwang@linux.dev
Date: Thu, 24 Jul 2025 19:05:55 +0800
In-Reply-To: <af8ceac7-851c-438d-8112-c1586427f58a@linux.dev>
References: <20250722153434.20571-1-kafai.wan@linux.dev>
	 <20250722153434.20571-4-kafai.wan@linux.dev>
	 <af8ceac7-851c-438d-8112-c1586427f58a@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Migadu-Flow: FLOW_OUT

On Wed, 2025-07-23 at 09:42 -0700, Yonghong Song wrote:
>=20
>=20
> On 7/22/25 8:34 AM, KaFai Wan wrote:
> > The result:
> >=20
> > =C2=A0 $ tools/testing/selftests/bpf/test_progs -t
> > tracing_failure/tracing_deny
> > =C2=A0 #468/3=C2=A0=C2=A0 tracing_failure/tracing_deny:OK
> > =C2=A0 #468=C2=A0=C2=A0=C2=A0=C2=A0 tracing_failure:OK
> > =C2=A0 Summary: 1/1 PASSED, 0 SKIPPED, 0 FAILED
> >=20
> > Signed-off-by: KaFai Wan <kafai.wan@linux.dev>
>=20
> LGTM but see a nit below.
>=20
> Acked-by: Yonghong Song <yonghong.song@linux.dev>
>=20
> > ---
> > =C2=A0 .../bpf/prog_tests/tracing_failure.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 33
> > +++++++++++++++++++
> > =C2=A0 .../selftests/bpf/progs/tracing_failure.c=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0 6 ++++
> > =C2=A0 2 files changed, 39 insertions(+)
> >=20
> > diff --git
> > a/tools/testing/selftests/bpf/prog_tests/tracing_failure.c
> > b/tools/testing/selftests/bpf/prog_tests/tracing_failure.c
> > index a222df765bc3..140fb0d175cf 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/tracing_failure.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/tracing_failure.c
> > @@ -28,10 +28,43 @@ static void test_bpf_spin_lock(bool
> > is_spin_lock)
> > =C2=A0=C2=A0	tracing_failure__destroy(skel);
> > =C2=A0 }
> > =C2=A0=20
> > +static void test_tracing_deny(void)
> > +{
> > +	struct tracing_failure *skel;
> > +	char log_buf[256];
> > +	int btf_id, err;
> > +
> > +	/* migrate_disable depends on CONFIG_SMP */
> > +	btf_id =3D libbpf_find_vmlinux_btf_id("migrate_disable",
> > BPF_TRACE_FENTRY);
> > +	if (btf_id <=3D 0) {
> > +		test__skip();
> > +		return;
> > +	}
>=20
> There is a discussion about inlining migrate_disable(). See
> =C2=A0=C2=A0
> https://lore.kernel.org/bpf/CAADnVQ+Afov4E=3D9t=3D3M=3DzZmO9z4ZqT6imWD5xi=
jDHshTf3J=3DRA@mail.gmail.com/
>=20
> Maybe trying to find a different function? Otherwise, if
> migrate_disable
> is inlined and this test will become useless.
>=20
Okey, I will use __rcu_read_lock() instead.
> > +
> > +	skel =3D tracing_failure__open();
> > +	if (!ASSERT_OK_PTR(skel, "tracing_failure__open"))
> > +		return;
> > +
> > +	bpf_program__set_autoload(skel->progs.tracing_deny, true);
> > +	bpf_program__set_log_buf(skel->progs.tracing_deny,
> > log_buf, sizeof(log_buf));
> > +
> > +	err =3D tracing_failure__load(skel);
> > +	if (!ASSERT_ERR(err, "tracing_failure__load"))
> > +		goto out;
> > +
> > +	ASSERT_HAS_SUBSTR(log_buf,
> > +			=C2=A0 "Attaching tracing programs to function
> > 'migrate_disable' is rejected.",
> > +			=C2=A0 "log_buf");
> > +out:
> > +	tracing_failure__destroy(skel);
> > +}
> > +
> > =C2=A0 void test_tracing_failure(void)
> > =C2=A0 {
> > =C2=A0=C2=A0	if (test__start_subtest("bpf_spin_lock"))
> > =C2=A0=C2=A0		test_bpf_spin_lock(true);
> > =C2=A0=C2=A0	if (test__start_subtest("bpf_spin_unlock"))
> > =C2=A0=C2=A0		test_bpf_spin_lock(false);
> > +	if (test__start_subtest("tracing_deny"))
> > +		test_tracing_deny();
> > =C2=A0 }
> > diff --git a/tools/testing/selftests/bpf/progs/tracing_failure.c
> > b/tools/testing/selftests/bpf/progs/tracing_failure.c
> > index d41665d2ec8c..dfa152e8194e 100644
> > --- a/tools/testing/selftests/bpf/progs/tracing_failure.c
> > +++ b/tools/testing/selftests/bpf/progs/tracing_failure.c
> > @@ -18,3 +18,9 @@ int BPF_PROG(test_spin_unlock, struct
> > bpf_spin_lock *lock)
> > =C2=A0 {
> > =C2=A0=C2=A0	return 0;
> > =C2=A0 }
> > +
> > +SEC("?fentry/migrate_disable")
> > +int BPF_PROG(tracing_deny)
> > +{
> > +	return 0;
> > +}
>=20

--=20
Thanks,
KaFai

