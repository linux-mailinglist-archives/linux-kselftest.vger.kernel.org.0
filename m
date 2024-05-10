Return-Path: <linux-kselftest+bounces-10016-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 348398C2650
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 May 2024 16:07:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57D061C21C08
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 May 2024 14:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37FAE12D1E8;
	Fri, 10 May 2024 14:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K4/BBJbr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C73D12C81F;
	Fri, 10 May 2024 14:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715349974; cv=none; b=jXGeho79vbS0pGWUBqYzxHZlBqc+TbhN18x/yhwv7ckPetluoHKaK2SDAT57yIU+UtOCmCjXE6F4ulVxP2MkQEVH4h+f48uVWpa0MnyQYN2980/Vz6QNPUtVstdm3NkCK1qxMqnPuxxtW9FIi0EIucYS2ZHkHc7a90nfY8tcZL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715349974; c=relaxed/simple;
	bh=bijg8uhnWEQekQWJ9OWl+WHmxr8G6KdwdXn7ukNViuc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A03OtflCeZa4H9xh5sCwekHA58YAbk823XF0HWykx7QNEiCbPxQyN2BzfZ3Vy1JcDBz6Z6guhaJf9GikdFHsm8JiShVrPx31KgwqE7zWybqroJ9ivxtbCqBur6a265yavkdUGti2hpzDjx5VcfSxJ1J95jADrSfu0Ca/xpbaZwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K4/BBJbr; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-34db6a29998so1448913f8f.0;
        Fri, 10 May 2024 07:06:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715349971; x=1715954771; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KtoGz6jfy1lPdHNSbF50tppsBzL53WmOBF6+e6OvgdI=;
        b=K4/BBJbrSC1LvrHLqb2vYcEp55XljMuoGsBj8NzIk6+EmnOg5fySrbFq2lejJGzTR5
         hZS7KMTcEe0HhaktSYvTKu2gxa4XemZTA3vju6OVOdzKrcS7LaSqHwU3BOWC8ZkS8BcX
         aUbwzf+ikMlo6tEwhCbmiMDhcBnZSgf6lTeYhBTrgSa8gFYyYqGk6Quh9IgxkDv5NPn5
         Wyk5KQZtC3yAtj10GVngd7fn7Zx0zDKkbqAcBxL9hv4DcYJf/b6UI5+Hn4bZPnu/s7ip
         AW9DwDE3ZluZIkizkFbSwEJPKCuW0MN/e6itB2R+ayiAbhGs2CdUz7CzsByPXiB9BLtg
         DHNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715349971; x=1715954771;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KtoGz6jfy1lPdHNSbF50tppsBzL53WmOBF6+e6OvgdI=;
        b=SzjCAdEgvYWw2H3aFFlaeMSAI8m0gLEncEOPeLlBTN1KbM+cclEK/jBIFDswZIlA2X
         L2NNADQMlKUvl722iweE26rus1yGR0q/DsHYbk6mJjK6EHtRpIjVPz7xIPIw7p6oNv7P
         DFuc0r/SXk6Ao1RUHw6c3Y1RhQV14Uc0+I9zU+LCGm88D80YYOBlNFsWmRdXp5kwGVz9
         aRC8q8hJV7VIaFEkAIrMuzBiCnLLpc2eJN6b8y+LMXBlUuzyIgCtT7Grrh+7eKl31MGw
         1/esIWZDCpbhptYyn3/gWDXYiM5JQmkI13ogZTQmA01dNN9SHrDRJrU7otDXY9cfmFrt
         FYjQ==
X-Forwarded-Encrypted: i=1; AJvYcCXaN1VV4igAcPJE3qiEvHjmz8ShHTLKMntzbEfzHnHzDNO3Uwl9whe6GCob3Ohq0g9PSHQDvfd60g7kIG9q4DmmM+3+c/2GHT1ayNc+lAnR+IGC8fSOTdINOpsk93syJDFCW0DsNzmYpx+XRn8s10jUIP2Vt2f9J7MmDJKrwfn0y7ZRmowNrEhjAzm6fTjhcOBdnU7FWlJViPNJ
X-Gm-Message-State: AOJu0YxBwKiQGzODbq5mUjEhOF0SMcRJY+7V19xg0arzjn07OZv6N7sY
	zWNk9xIR+v3cVeZ+xAA4ues+EZ9Icsv1gGC+baVutKsyoR3xzI8sqKg1Kg12A+4I3GWmbe8QOyZ
	W4zaQ1dfFISFZCCUZgwOc7O+Z9L8=
X-Google-Smtp-Source: AGHT+IEw0fZBaki+GPAhG2zc2JHOEQAQx5c4LqBi9+08YsH3bkf+8FlSjd6bJTK1i+3cGr8XCGXUcZPKfXAoGkabQfg=
X-Received: by 2002:a5d:4910:0:b0:34b:d659:7d0f with SMTP id
 ffacd0b85a97d-3504a731d39mr1927718f8f.16.1715349970455; Fri, 10 May 2024
 07:06:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240509-upstream-bpf-next-20240506-mptcp-subflow-test-v2-0-4048c2948665@kernel.org>
 <20240509-upstream-bpf-next-20240506-mptcp-subflow-test-v2-2-4048c2948665@kernel.org>
 <daf7ed61-e09b-439b-9cdd-b6d9aa003e27@kernel.org>
In-Reply-To: <daf7ed61-e09b-439b-9cdd-b6d9aa003e27@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 10 May 2024 07:05:58 -0700
Message-ID: <CAADnVQ+Tp8+Hhy__=uevSZsEetsWYommjhC9SqSfKEeBu51cKA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 2/2] selftests/bpf: Add mptcp subflow subtest
To: Matthieu Baerts <matttbe@kernel.org>, Manu Bretelle <chantra@meta.com>
Cc: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
	Geliang Tang <geliang@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Geliang Tang <tanggeliang@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 9, 2024 at 11:31=E2=80=AFAM Matthieu Baerts <matttbe@kernel.org=
> wrote:
>
> Hello,
>
> On 09/05/2024 17:49, Matthieu Baerts (NGI0) wrote:
> > From: Geliang Tang <tanggeliang@kylinos.cn>
> >
> > This patch adds a subtest named test_subflow to load and verify the new=
ly
> > added mptcp subflow example in test_mptcp. Add a helper endpoint_init()
> > to add a new subflow endpoint. Add another helper ss_search() to verify=
 the
> > fwmark and congestion values set by mptcp_subflow prog using setsockopt=
s.
> >
> > Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/76
> > Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> > Reviewed-by: Mat Martineau <martineau@kernel.org>
> > Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> > ---
> >  tools/testing/selftests/bpf/prog_tests/mptcp.c | 109 +++++++++++++++++=
++++++++
> >  1 file changed, 109 insertions(+)
> >
> > diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/tes=
ting/selftests/bpf/prog_tests/mptcp.c
> > index 274d2e033e39..6039b0ff3801 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
>
> (...)
>
> > @@ -340,10 +344,115 @@ static void test_mptcpify(void)
> >       close(cgroup_fd);
> >  }
> >
> > +static int endpoint_init(char *flags)
> > +{
> > +     SYS(fail, "ip -net %s link add veth1 type veth peer name veth2", =
NS_TEST);
> > +     SYS(fail, "ip -net %s addr add %s/24 dev veth1", NS_TEST, ADDR_1)=
;
> > +     SYS(fail, "ip -net %s link set dev veth1 up", NS_TEST);
> > +     SYS(fail, "ip -net %s addr add %s/24 dev veth2", NS_TEST, ADDR_2)=
;
> > +     SYS(fail, "ip -net %s link set dev veth2 up", NS_TEST);
> > +     SYS(fail, "ip -net %s mptcp endpoint add %s %s", NS_TEST, ADDR_2,=
 flags);
>
> I just noticed that this command is failing on the BPF CI:
>
>   https://github.com/kernel-patches/bpf/actions/runs/9020020315?pr=3D7009
>
> Is it possible that an old version of IPRoute2 is installed?
> 'ip mptcp' is supported since v5.8.0 (from 2020).
>
> It looks like Ubuntu Focal 20.04 is being used, which has the v5.5.0. Do
> we then need to find another way to set the MPTCP endpoints?


Manu, any idea?

