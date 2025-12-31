Return-Path: <linux-kselftest+bounces-48032-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 77135CEC741
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Dec 2025 19:14:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CED64303091A
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Dec 2025 18:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 856F32FC024;
	Wed, 31 Dec 2025 18:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OfLzlWNU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C3892F9C39
	for <linux-kselftest@vger.kernel.org>; Wed, 31 Dec 2025 18:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767204843; cv=none; b=OgZNuI28EBEtwufIRO40aisKzSrNOdhITdHLpRvCGiHr15k/61QvjL7XssgZ5FrqRGzaDwQCMJDl6hXjAmRfTEN88G6ChhgzFOR6q5nRaaB4qtL7JNesp0b/+o0NgmjcMJrxecjg5uKY6/bC7IbXH2ZcHUeMBUXkWHpWTnAjihI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767204843; c=relaxed/simple;
	bh=l0LRvl1kqcmBpJ+oiXL+hUtJD8MnLQw7yRd+cy/68MI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CZC87ZB2YsBuFFXm/FAKxKhowgnO982o/QF9OP9YWMUHPDzDFxQnpf2wUubDxqsFHsS/xtLf4Z7Kpn51zaghJtMplfuzRaaS1SOiKUOrI9xec28JiFBJ8eTTmipiTWb5Aq+D9oPuyybTHbTT+1dLo4eebAFSVgTwrLiHc27nmZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OfLzlWNU; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-4327555464cso2833702f8f.1
        for <linux-kselftest@vger.kernel.org>; Wed, 31 Dec 2025 10:14:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767204839; x=1767809639; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=80wuQlyFH/FTtp28IkHfYhaeWqE7rS7z6vp3Trh+jc4=;
        b=OfLzlWNU9tNh19lSAgaTDAAozHeFHEju+uWNAjP9QTUwb8+5hd+Nq9C8dAiR0RPdYg
         J2czUTeqjfPVMQ4ePBDiPsfUjuCNlI2iAxFhljFDCeoTJ5vDlXEsrqi8GN7n0iQKa483
         YmLoaPgSHLGADSqNRv6rmSRSB+8oHnY6/hy3v82ss0yvfk6125AncvXKghhsQCzenEuJ
         drtwjRNp8bU1+aDi+7jqdM8/bS5plGkyolcMmSD9xvY/2jhlaG5q+eyFZ71S98AHJlmE
         uQwtrCw9PU9u8SsPUsfe7ZLdrwA1qQpB6YMJJPwY1HzSzWxPQ0CllxHFZ/sYcgwVaXVz
         J4wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767204839; x=1767809639;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=80wuQlyFH/FTtp28IkHfYhaeWqE7rS7z6vp3Trh+jc4=;
        b=hUYgBs+FLJ50U1bfhveQZigZbGNdcY2KktlVzzO1cf8/Hc/MCSSy8L+Mq+bqhTX7gc
         7Qp90aGX3XFXe/p3X60g0xkN+w/bo91NDkYP+DSDDApKBcA2Yqa8cuaYgoUMkncKALm9
         0Z4pVxMLAI0QtTjM/MmstBgeTwg6hz4r13uC21F0qClFLSa4oIgqX+WdBVno/KMqt4vH
         tCZ6CKuOPyqaHBspUHAxTmYGcSWFSsabnPqBn/q7sKornThgFxkdnfVHSnyYkoZnadCy
         KCK2unMiGZt0k+4IVNT4Ou2o+U3zWVZLER1A6ilrfcQLZ+Igp0x27GRGAtj+owXppS0Z
         3zMA==
X-Forwarded-Encrypted: i=1; AJvYcCWx9HXmEXgHwoalJN0m4+Gn8enB+ZrO7/Qapcp1OFK3fNODy+as9N7DCJWjWzoxP76CisHdt2CSIi6ii8D0hqY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+XuN37rQgihl9AZy1GZFuR9Arl3gukvW8QorDxm+caPWrQNsP
	unwDKMF1uHTwt0e139S5ns6sJFlrplzXm056Kyp4u2SjnXBmfBeHwMd2yKQ9xD1Gi8L9eam7xlE
	b3VZMkjMWTw6r0eGlIW3Nrg/ImAx3+d4=
X-Gm-Gg: AY/fxX6bnvF0bOJ8rkUlJXTqGPjySRYLeufoQmzolJmGG3YdDbc5b0CQRXdyAlDqBfp
	DpN3SNTAk+/v+IwqoWasuYjOHDAR/ZV0XNXewkWUAdGlDldtWjZzjPLu4D10kDP1n9+0Umii938
	tQuf1OZnXV6+jzt9AukASJB5iHK3+OA7Gnsvug01m/l89nxYakHCKpfWamWgQdTfz//Nngx0VD1
	+ys9iYi3a0Yiltj5LAuc8OBQINOhbZCnHZ6IeuHDx+XGstCH8yYI/TaxOpFh8luKLnRmHhM1DZv
	q82XS7eppc1hL/p+/KKCIPBkNuOy
X-Google-Smtp-Source: AGHT+IE7rn8UGO5FxmIqC7DPe8kHIdUtmNgCuEKioyalqiNjU4yifPpIQxEAl6/RRsYuU+/knbKXbX9dpW9nJ6ADD+Y=
X-Received: by 2002:a05:6000:611:b0:431:3ba:1188 with SMTP id
 ffacd0b85a97d-4324e4c70e5mr40336157f8f.3.1767204838828; Wed, 31 Dec 2025
 10:13:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251231173633.3981832-6-csander@purestorage.com>
 <e9a1bd633fb4bb3d2820f63f41a8dd60d8c9c5e3c699fa56057ae393ef2f31d0@mail.kernel.org>
 <CADUfDZpSSikiZ8d8eWvfucj=Cvhc=k-sHN03EVExGBQ4Lx+23Q@mail.gmail.com>
In-Reply-To: <CADUfDZpSSikiZ8d8eWvfucj=Cvhc=k-sHN03EVExGBQ4Lx+23Q@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 31 Dec 2025 10:13:47 -0800
X-Gm-Features: AQt7F2oHF_qxr3_KPJ-VT5eeYhG4tvvvWKJxtIn11KSC3ODYIcBGmV1QpWm3ri0
Message-ID: <CAADnVQKXUUNn=P=2-UECF1X7SR+oqm4xsr-2trpgTy1q+0c5FQ@mail.gmail.com>
Subject: Re: [PATCH 5/5] selftests/bpf: make cfi_stubs globals const
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: bot+bpf-ci@kernel.org, Jiri Kosina <jikos@kernel.org>, 
	Benjamin Tissoires <bentiss@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, 
	Changwoo Min <changwoo@igalia.com>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Benjamin Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, 
	Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, 
	Jiri Pirko <jiri@resnulli.us>, "D. Wythe" <alibuda@linux.alibaba.com>, 
	Dust Li <dust.li@linux.alibaba.com>, sidraya@linux.ibm.com, wenjia@linux.ibm.com, 
	mjambigi@linux.ibm.com, Tony Lu <tonylu@linux.alibaba.com>, guwen@linux.alibaba.com, 
	Shuah Khan <shuah@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	"open list:HID CORE LAYER" <linux-input@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	bpf <bpf@vger.kernel.org>, Network Development <netdev@vger.kernel.org>, sched-ext@lists.linux.dev, 
	linux-rdma@vger.kernel.org, linux-s390 <linux-s390@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Chris Mason <clm@meta.com>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 31, 2025 at 10:09=E2=80=AFAM Caleb Sander Mateos
<csander@purestorage.com> wrote:
>
> On Wed, Dec 31, 2025 at 10:04=E2=80=AFAM <bot+bpf-ci@kernel.org> wrote:
> >
> > > diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c b/t=
ools/testing/selftests/bpf/test_kmods/bpf_testmod.c
> > > index 90c4b1a51de6..5e460b1dbdb6 100644
> > > --- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
> > > +++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
> >
> > [ ... ]
> >
> > > @@ -1275,7 +1275,7 @@ bpf_testmod_ops__test_return_ref_kptr(int dummy=
, struct task_struct *task__ref,
> > >       return NULL;
> > >  }
> > >
> > > -static struct bpf_testmod_ops __bpf_testmod_ops =3D {
> > > +static const struct bpf_testmod_ops __bpf_testmod_ops =3D {
> > >       .test_1 =3D bpf_testmod_test_1,
> > >       .test_2 =3D bpf_testmod_test_2,
> >
> > Is it safe to make __bpf_testmod_ops const here? In bpf_testmod_init(),
> > this struct is modified at runtime:
> >
> >     tramp =3D (void **)&__bpf_testmod_ops.tramp_1;
> >     while (tramp <=3D (void **)&__bpf_testmod_ops.tramp_40)
> >         *tramp++ =3D bpf_testmod_tramp;
> >
> > Writing to a const-qualified object is undefined behavior and may cause=
 a
> > protection fault when the compiler places this in read-only memory. Wou=
ld
> > the module fail to load on systems where .rodata is actually read-only?
>
> Yup, that's indeed the bug caught by KASAN. Missed this mutation at
> init time, I'll leave __bpf_testmod_ops as mutable.

No. You're missing the point. The whole patch set is no go.
The pointer to cfi stub can be updated just as well.

