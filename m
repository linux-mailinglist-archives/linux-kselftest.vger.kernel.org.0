Return-Path: <linux-kselftest+bounces-37504-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AD5CB08EF2
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Jul 2025 16:19:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 077D63B4979
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Jul 2025 14:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEF5729DB92;
	Thu, 17 Jul 2025 14:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JWNc4+Nh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 320332E3700;
	Thu, 17 Jul 2025 14:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752761936; cv=none; b=ZTuUafjg8GHZfKW4aSqBRY3h8no1t/CLq3oH9xfRneYFbzwgYQsdC638QTZP03MdS7awhdmNj5/G+QdEeZm7TS4hZfiFa9POYoaQ547rJ5GJ2rVywbBkf5IMMg9xZgIEHuf3CrT7PRLsmMtsS8lWO1ZIZcD+M3kDN0O5XXy3PJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752761936; c=relaxed/simple;
	bh=XctmZo9SvD03oJXci75LIEr7H5ii62ha/tjuZuMJEB4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mL2x5NmgdoFzUZcTT5xiVVRsMLPREnR6aH2IGB2C1io1R5uz2nit0LSNe0BTRPqUWJYG2w55FSWR0EW5cBoQigcmXgW3vCZOiwQusE3UDdStCrDdfuDF84KC80WpRtzi7p82hozT5ug75E1J6Hn/qYOp9uV9XcT3BncyPwefRrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JWNc4+Nh; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-311e2cc157bso972102a91.2;
        Thu, 17 Jul 2025 07:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752761934; x=1753366734; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XctmZo9SvD03oJXci75LIEr7H5ii62ha/tjuZuMJEB4=;
        b=JWNc4+NhzgVtgGoB8DpQ+rxQ6fS6el6WRgZPJeCEcuEbGOspoySukKzOVYLxY704ok
         dxYuFU+4SwWm7vcP8cCevPJroc6nu51W95JnNygl3+Ffn8RmSt6HnyoHo1I9tlf1qFBn
         Q51ziLQ2irRShBVIzv3kzPT5BcTxurvvoOrKFQdkX8emDhnINESL+jYWSQUJ455jPKYh
         0mQsSy6veQSR/qzmUrGe3qoqOnV4m8xBV56V8kbN6PRHjcWRrbihyHlPkhuugaSNxaE9
         WNsv/0K8VxXAm3JAqYmr+XysuSfAdfpbJoSrsBkN9Vt6WPEVXB5hDRPcEOoT5buei1Xy
         xFvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752761934; x=1753366734;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XctmZo9SvD03oJXci75LIEr7H5ii62ha/tjuZuMJEB4=;
        b=vsd5Xg3R7tMz0HLuYIkYgJ39w0Igs+e7aCCPn5tGL+LLKjvIRCWhvO69bvUtr/nVZL
         zh4Tyi5yByKPWHU67rme1y9BxPPxluA0hDFfAzZjhf6YwBNA8zxvMTUYYRxYEeo4ca3g
         ykzXpInGrgiwIrQ7g1DGpc5TAb9QCBwytOdU31+I60tYuUHHms3m2gYesrg0Upfa92Hr
         5u/+XQ1rmIWfgp/krecsAFlXmw6Ncvmrc3uQrJgIrNG6eiEurd0ZSTD6oZqc2ecQztzH
         sBfaSstpDBlLrJyjUYFWgB+4S7mGrkkSGu8tDEWSvOtjPIyIanXLFFWzYTNxpay/cR3K
         qEKA==
X-Forwarded-Encrypted: i=1; AJvYcCV7lyH/qzhSvJPLoz9/vb/YcUxVLnbAK+fpwNWdNJW9CGLk5oMAvXaPiOOU/8rb+YGuEeAAf+t5f5xhHFJ7@vger.kernel.org, AJvYcCXOeVZIlYIe8OIBZDg5gFXWcM8aNrhexoeAQw5u7eKOIfCUTHzjTFXGeGxhCr/1f7FLNjuJm5c8TXxTxhDje7pY@vger.kernel.org, AJvYcCXieiI0/beAiWtemFHda9P932yOrwSnEXUp/Pg7Opv8kxISV4XJSbrJk/kZATIQxpSRhs0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTj+8Oiei7O6q13M9CnbcQ5q7y4x/o4eUto5/75QO1gSukioU0
	GCbIVY4TDkDdce9ixWECeMXW7xIay7Sue8rlQFM65hXMiN5b8LrWaIdu
X-Gm-Gg: ASbGncswK7rwD7xCCe1hgInfFNar7eL2PEMzhMmgBN00ZcKGyDmrHB0smDhwaDVW8Pl
	m4KR6YWQBAk9GrQmfOlGCI7N3+Mm9RECy64dq+WuicCu9MomPt7H0wAtbtHNMhd6wmlWOFWs3Sn
	1W6X8CYHgzu8JhJxg9AaNph1OKkWiTTSupT1Bqc2oz+9IwxvPn3OQOcoifnN36eytcA4PWwRbnV
	CXVZ9GzohCVLBJivi0aWkAbeILdaZULqkOrykU+a/zZ5aG0JV67SRy7qf8lpQAPbsZq7auAjcuP
	nvTVZ8l/LSgMisJyHDWU9PEldjsnWdN3lmgAfhoi78LMDe8dlM/LojfQHBB8c/ZHSPmA60eVJYv
	skcZrsU74lnxe/95Q0eKT
X-Google-Smtp-Source: AGHT+IGuxnZt9hKB3LiaRFtAjSyz8kcQOd2eGpull1QNd1vam25zcF6spQZ/+RWeF3qGI3lE0gdePw==
X-Received: by 2002:a17:90b:48c8:b0:315:b07a:ac12 with SMTP id 98e67ed59e1d1-31c9e6f71b8mr11185576a91.14.1752761934264;
        Thu, 17 Jul 2025 07:18:54 -0700 (PDT)
Received: from [127.0.0.1] ([115.205.228.8])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31caf835438sm1662990a91.45.2025.07.17.07.18.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 07:18:53 -0700 (PDT)
Message-ID: <2a3a90e4672d497e430ce40d039a90613c4390c0.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 3/3] selftests/bpf: Add selftest for
 attaching tracing programs to functions in deny list
From: KaFai Wan <mannkafai@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>,  John Fastabend <john.fastabend@gmail.com>, Andrii
 Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,
 Eduard <eddyz87@gmail.com>, Song Liu <song@kernel.org>,  Yonghong Song
 <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@fomichev.me>,  Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>,  Shuah Khan
 <shuah@kernel.org>, Yafang Shao <laoar.shao@gmail.com>, LKML
 <linux-kernel@vger.kernel.org>,  bpf <bpf@vger.kernel.org>, "open
 list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, Leon
 Hwang <leon.hwang@linux.dev>
Date: Thu, 17 Jul 2025 22:18:42 +0800
In-Reply-To: <CAADnVQ+H6oHMFPvWkXuHv9oanHT57F_HrD_ZpxB0X=37vdAoyw@mail.gmail.com>
References: <20250714120408.1627128-1-mannkafai@gmail.com>
	 <20250714120408.1627128-4-mannkafai@gmail.com>
	 <CAADnVQ+H6oHMFPvWkXuHv9oanHT57F_HrD_ZpxB0X=37vdAoyw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.0-1build2 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-07-16 at 18:37 -0700, Alexei Starovoitov wrote:
> On Mon, Jul 14, 2025 at 5:04=E2=80=AFAM KaFai Wan <mannkafai@gmail.com>
> wrote:
> >=20
> > The reuslt:
> >=20
> > =C2=A0 $ tools/testing/selftests/bpf/test_progs --name=3Dtracing_deny
> > =C2=A0 #467/1=C2=A0=C2=A0 tracing_deny/migrate_disable:OK
> > =C2=A0 #467=C2=A0=C2=A0=C2=A0=C2=A0 tracing_deny:OK
> > =C2=A0 Summary: 1/1 PASSED, 0 SKIPPED, 0 FAILED
> >=20
> > Signed-off-by: KaFai Wan <mannkafai@gmail.com>
> > ---
> > =C2=A0.../selftests/bpf/prog_tests/tracing_deny.c=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 | 11 +++++++++++
> > =C2=A0tools/testing/selftests/bpf/progs/tracing_deny.c=C2=A0 | 15
> > +++++++++++++++
> > =C2=A02 files changed, 26 insertions(+)
> > =C2=A0create mode 100644
> > tools/testing/selftests/bpf/prog_tests/tracing_deny.c
> > =C2=A0create mode 100644
> > tools/testing/selftests/bpf/progs/tracing_deny.c
> >=20
> > diff --git a/tools/testing/selftests/bpf/prog_tests/tracing_deny.c
> > b/tools/testing/selftests/bpf/prog_tests/tracing_deny.c
> > new file mode 100644
> > index 000000000000..460c59a9667f
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/prog_tests/tracing_deny.c
> > @@ -0,0 +1,11 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +#include <test_progs.h>
> > +#include "tracing_deny.skel.h"
> > +
> > +void test_tracing_deny(void)
> > +{
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* migrate_disable depends on CON=
FIG_SMP */
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (libbpf_find_vmlinux_btf_id("m=
igrate_disable",
> > BPF_TRACE_FENTRY) > 0)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 RUN_TESTS(tracing_deny);
> > +}
> > diff --git a/tools/testing/selftests/bpf/progs/tracing_deny.c
> > b/tools/testing/selftests/bpf/progs/tracing_deny.c
> > new file mode 100644
> > index 000000000000..98ef834f0b6d
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/progs/tracing_deny.c
> > @@ -0,0 +1,15 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +#include <linux/bpf.h>
> > +#include <bpf/bpf_helpers.h>
> > +#include <bpf/bpf_tracing.h>
> > +#include "bpf_misc.h"
> > +
> > +char _license[] SEC("license") =3D "GPL";
> > +
> > +SEC("fentry/migrate_disable")
> > +__failure __msg("Attaching tracing programs to function
> > 'migrate_disable' is rejected.")
> > +int BPF_PROG(migrate_disable)
> > +{
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
> > +}
>=20
> Please roll these two tiny files into existing files in progs/ and
> prog_tests/
> directories.
> Every file takes time to compile 4 times, so let's avoid unnecessary
> overhead.
>=20

Okay, will update it in v3.

> --
> pw-bot: cr

--=20
Thanks,
KaFai

