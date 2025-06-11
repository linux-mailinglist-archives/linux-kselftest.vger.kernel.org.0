Return-Path: <linux-kselftest+bounces-34750-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E98CAD5D2E
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 19:24:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DA2C3AA322
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 17:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30CD8222560;
	Wed, 11 Jun 2025 17:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I2PWERXt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B50A2222A9
	for <linux-kselftest@vger.kernel.org>; Wed, 11 Jun 2025 17:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749662465; cv=none; b=NL+WO3LzzY9XeKGxivMVin78flXWCgtFi9UzoJtexVCVC3O7xEL0o/Jj9X0XjxkxHSh8obE4Ec3AsW841fhG3tqKKk6a8HHBPdFPfShV7HZhNeXLme0HlPqNXAc6m4bpdKw6cAxvIvqI3FmdtxM5XP5Nr9IErgTntoWFnwjHlr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749662465; c=relaxed/simple;
	bh=HpuX6uXXDdRqKGkUplqApGYf7n4pQ4n1YKaQS/Bqm1g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EVmgZ9uxVceJIg3lH8U+wq/YFB84KSrtkPnUyA9pj3/LqeuhziY/BHT2IXaYTCcVmGPlNXQTdNAqLk3LxNaWAvC55/7Pu5NvCVn+OuhDd5ZOVJT/seC0JVstsutr3O+lDDbaL9EIextI9OuY/ljgqlV0OPAVt0Y9nQJEYSApEPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I2PWERXt; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4772f48f516so12381461cf.1
        for <linux-kselftest@vger.kernel.org>; Wed, 11 Jun 2025 10:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749662462; x=1750267262; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HpuX6uXXDdRqKGkUplqApGYf7n4pQ4n1YKaQS/Bqm1g=;
        b=I2PWERXtiQRvwc1ZQUSZXkeEc+3TXbe48hlG/e60wj/yOaDDXDParCnA++hl4AsFCL
         8z+1GBsolupvYMtcqf0hFLKyXh/4+jygO7WePXtLtP0Fsat2ibjEC80ZbcXUvE2NeeLs
         l3TAmkLKtn33o1Ybf/HEchFBtrmoueu+YDZhOSaJSamaEG5/09O4fELSBTrOXKiBLU+v
         9JvfoHQjx/dv7xJUgc2ljgHJ9GGiB0d9675SUnr1WJYhiOPRi3wL/Pc7/+pgpBFrWr70
         W53pYRYO35mzW6w2Xig4sm/CSkurctWF1cbBYAT17rfrzsrG49TwKNa4QiFL33vf5pPC
         JIGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749662462; x=1750267262;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HpuX6uXXDdRqKGkUplqApGYf7n4pQ4n1YKaQS/Bqm1g=;
        b=HjlpaYkZX1zUlAjlUBcXhzzEoxmDyggaQzLI/cbrdu4Bc694HK+vVJbyiEBZ1Axh31
         W0aBVnArkmuCCRez1dSBr9vhQ0+37JF56fgkJ3/iD3eClx9sIkMA28G/C3ZPRzQjveJs
         G7jlozAWGpKCpVnYtbNTb4oQV9NaVYEqYFpBU/HXLcy3h7vkAoswfb4X1ymNfBn7Ala8
         kRXBm4q9LpI0oV4dK+9JpsQ7bHAN/b69uecVVLdBzx292hETatNy9SB6+ko84vBLXOCo
         VftcFTNakWhTNL1/iwKUJtAYMhrfisN6osixKE9tDE/KXQrc2rLk2UDqp5CQcaJNLaQL
         LpZA==
X-Forwarded-Encrypted: i=1; AJvYcCVRnehYFJ95yKyR26IsmCN02IpNMFKGu61hKf1CfXPvcIDbYl12NRnEQN5suxAuuzYq0CpYKt+YxGJT5e7tc08=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWkUCQFLcDzGFB9Z+feB+gCb9ErZLGY0BKmplqhXC70+xasef5
	/Gkrq3kPxkmryki1wa6/vlrsbPt9um5KtcjLIwbjA5WLPz/QORDIHg97ByLK9MptBfABh7EHL1r
	vVkKrghGf//w/R5i8yTrU00pAoNwRyRW5J1ffPDeYIdBArBLxDvZkII3e
X-Gm-Gg: ASbGncsdyUldRxc9X+49NKueIFgutlyWJQFFBqke50VAdGhFYNRBM5FBIRu5OPu10ph
	Q8L4yFBb2IIDDOm5v+SE0TQmlgPbJQk/QsY2qudNCyryLMACLaOk74433g30wMWZ7O+hvI3pn6u
	272dfqGy3p0RZ7lrRguED3XTp3F//9hXADe3fdICK9NCI=
X-Google-Smtp-Source: AGHT+IEhBRuN7B6LTZSzKYkY+Fjb2lZgXyxJ8Yl907OIMJvAVPiU/JV/c+cD9SxUr3eRy1O+wSBc6HX0nM4di6nPfvk=
X-Received: by 2002:a05:6122:2088:b0:52f:a0c8:263d with SMTP id
 71dfb90a1353d-5312dc2164amr411708e0c.5.1749662449580; Wed, 11 Jun 2025
 10:20:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250603203701.520541-1-blakejones@google.com> <aElbyWY-cIQNf4wp@krava>
In-Reply-To: <aElbyWY-cIQNf4wp@krava>
From: Blake Jones <blakejones@google.com>
Date: Wed, 11 Jun 2025 10:20:38 -0700
X-Gm-Features: AX0GCFs5Krou7gfrh8qKoaSovcVxAQ3oWFMVkI5FV16KOLRRiLHpznUaJBLq07s
Message-ID: <CAP_z_Cgo0mLn6+cObVSBu4dY2SZaDTO6HZ-0D=1uAhuoc+jQRQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] libbpf: add support for printing BTF character
 arrays as strings
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, Namhyung Kim <namhyung@kernel.org>, 
	Ian Rogers <irogers@google.com>, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jiri,

On Wed, Jun 11, 2025 at 3:34=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wrot=
e:
> could this be used in bpftool map dump? ;-) I checked, but it looks like
> bpftool map dump is using something else to dump data.. I admit I haven't
> spent much on time that

I actually started this work by looking at bpftool's dumper, and only
after a bit of time did I realize that there was a more general dumper
in libbpf. I suspect that part of why no one has updated bpftool to
use libbpf for this is that bpftool's dumper also has a "display in
JSON" mode which libbpf doesn't support. So yes, it could be done, but
it would take some work.

Blake

