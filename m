Return-Path: <linux-kselftest+bounces-11425-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E2FC9900AE2
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jun 2024 18:59:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52DC8B24B83
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jun 2024 16:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0CF219ADB1;
	Fri,  7 Jun 2024 16:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G2AVTqpi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2932119AD5F
	for <linux-kselftest@vger.kernel.org>; Fri,  7 Jun 2024 16:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717779573; cv=none; b=eh0Q7GGqzfK5epzQlns0JjFMrVkHM6C8d7VY4jK5MAqZGhS5Ut0Lw8DHfhJxeE5h5a8jon1IwSoG2mmG1fL188jDtoCXw4kNoUMFh7zwQGHihLw4Yj61o4Si8m5vC4wIXKfvXEp/WKmTKEOMFq78e66g2RcFpMVIe1vATl//Osc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717779573; c=relaxed/simple;
	bh=b716fHLqA+q2jVEnF0wQCq5rwwcoiNDI2tYRdVxGBJ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oBScGNrlvTpYIXd7NEFfpZo3sxV/jPQ805fhdQZMC+9an7jhhULgqP+nixJzudzhbca2yi8G/FH/dSsgC+MWjiYB986pjprRcctQpL8yTCoguPfP1+eaolchtEgBb0vhITN2aR7OhiqH5FQiDbR0Aema3YwuCFVvikBocRB4CR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=G2AVTqpi; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a63359aaacaso366119866b.1
        for <linux-kselftest@vger.kernel.org>; Fri, 07 Jun 2024 09:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717779569; x=1718384369; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b716fHLqA+q2jVEnF0wQCq5rwwcoiNDI2tYRdVxGBJ8=;
        b=G2AVTqpij2cJhN5HRQo3ptWXB/TQ9YDh9RGrpGeXVnp1CnL9i2DHQgrabHfRJ+vI4v
         6rj8PhKQhbrqw08lFKhBQBeW3OEzxZgvZ0sM8DqYOCgzynh/TqX8zhUpecpLeveUgZe/
         4WO2raT386olPe7+CqYN3aB+/KVKBRO+MtAq0XGvPQZgecLr0Yv0La164s3HFQRW75Oj
         zZN4yPFMx3bgrVJwSDOEuMmEHfxotBiwl6JuetdpyYQLp0Ofu9L4f3YRHWKNySwxc9/Q
         JR8ZXjlMx3qbDJacaMfkf8ysfsu1jvPB+cyZ9tvZ8GL8kf1mEaJBMzprr6qo856Q0ny6
         yaFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717779569; x=1718384369;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b716fHLqA+q2jVEnF0wQCq5rwwcoiNDI2tYRdVxGBJ8=;
        b=Iz1bZlBoEZeleA/dTpYGWR2UUzAeFds8tEsfhoF7/OQ+6Q3ZJgi+DyhRk4Qxd/ULvY
         3kP+oQmeVdJNOt6AeZkN3s6/0ufRWwjEUYYTHPyGvYa76w4lEnzCoOUiNyoAGz8Jitv1
         pK/NI0niyIzuTm8VJe2vPOxbok2Q27TCcyVmSP7fq/0kdfSMxKxdTWI08onCjmzV7nQJ
         CORbBXP0y1etZLRMQD1AMBD7qh+iKa9XVRHODAw7JtEUShcTuOvndo9as7ZBRflZXRTc
         7BVRFBrZ2M26Etm61/kaVJIvukkdvYI4F2bCnYFC33HMWmM3fS/65l+4jqs8I8Ok6CdV
         c3UA==
X-Forwarded-Encrypted: i=1; AJvYcCWnxwXaSxVcFLQDbQH0E6k26XZ0toqoPIYzsXmv9xOwYxt36Dd1PPrUozxv/Ns/r/A+G4XfJbt2N3qJovY+wT3Z+OgaAOqtKcNpoGmlUd3A
X-Gm-Message-State: AOJu0Yw33aOutZ4euvudDfYHs5JBN8A+Q+w3p0mI8UJiCyF8IVouaRLa
	oB64io7SaHN/kSh33g/5mNzeJI8VO9FAS7d42pJy5NpaqpBKyiJqoSRLKxWcU1Hx9wsH4YPu5DA
	Ob4OED2Tz9zzTx7UC3jyj98COnvxuRUJ6Tj5y
X-Google-Smtp-Source: AGHT+IFO8pnZEEr0e5+OyIy57985L/vijoXMBq19GG2GOaDteqsHQMVykhBCrf2eEzDSRbH9iO1UMt7DJvGo0PZ4Mj4=
X-Received: by 2002:a17:906:12c1:b0:a63:3cd4:97d2 with SMTP id
 a640c23a62f3a-a6cdbd0d2e5mr206803066b.63.1717779569136; Fri, 07 Jun 2024
 09:59:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240530201616.1316526-1-almasrymina@google.com>
 <20240530201616.1316526-3-almasrymina@google.com> <ZlqzER_ufrhlB28v@infradead.org>
 <CAHS8izMU_nMEr04J9kXiX6rJqK4nQKA+W-enKLhNxvK7=H2pgA@mail.gmail.com>
 <5aee4bba-ca65-443c-bd78-e5599b814a13@gmail.com> <CAHS8izNmT_NzgCu1pY1RKgJh+kP2rCL_90Gqau2Pkd3-48Q1_w@mail.gmail.com>
 <eb237e6e-3626-4435-8af5-11ed3931b0ac@gmail.com> <be2d140f-db0f-4d15-967c-972ea6586b5c@kernel.org>
 <8f44ca2a-8910-418f-b4a6-ca1e051484ba@gmail.com> <a8df4459-30bf-4414-aeca-2f67c461adc4@gmail.com>
In-Reply-To: <a8df4459-30bf-4414-aeca-2f67c461adc4@gmail.com>
From: Mina Almasry <almasrymina@google.com>
Date: Fri, 7 Jun 2024 09:59:16 -0700
Message-ID: <CAHS8izNcYMsSpTNVSGRJHK6u+kDxnFab5Km1rYy8b++0FeUNgA@mail.gmail.com>
Subject: Re: [PATCH net-next v10 02/14] net: page_pool: create hooks for
 custom page providers
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: David Ahern <dsahern@kernel.org>, Christoph Hellwig <hch@infradead.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-alpha@vger.kernel.org, linux-mips@vger.kernel.org, 
	linux-parisc@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Donald Hunter <donald.hunter@gmail.com>, Jonathan Corbet <corbet@lwn.net>, 
	Richard Henderson <richard.henderson@linaro.org>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, 
	Matt Turner <mattst88@gmail.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Helge Deller <deller@gmx.de>, 
	Andreas Larsson <andreas@gaisler.com>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Arnd Bergmann <arnd@arndb.de>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Steffen Klassert <steffen.klassert@secunet.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Shuah Khan <shuah@kernel.org>, 
	Sumit Semwal <sumit.semwal@linaro.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	David Wei <dw@davidwei.uk>, Jason Gunthorpe <jgg@ziepe.ca>, Yunsheng Lin <linyunsheng@huawei.com>, 
	Shailend Chand <shailend@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Jeroen de Borst <jeroendb@google.com>, 
	Praveen Kaligineedi <pkaligineedi@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 7, 2024 at 8:47=E2=80=AFAM Pavel Begunkov <asml.silence@gmail.c=
om> wrote:
>
> On 6/7/24 16:42, Pavel Begunkov wrote:
> > On 6/7/24 15:27, David Ahern wrote:
> >> On 6/7/24 7:42 AM, Pavel Begunkov wrote:
> >>> I haven't seen any arguments against from the (net) maintainers so
> >>> far. Nor I see any objection against callbacks from them (considering
> >>> that either option adds an if).
> >>
> >> I have said before I do not understand why the dmabuf paradigm is not
> >> sufficient for both device memory and host memory. A less than ideal
> >> control path to put hostmem in a dmabuf wrapper vs extra checks and
> >> changes in the datapath. The former should always be preferred.
> >
> > If we're talking about types of memory specifically, I'm not strictly
> > against wrapping into dmabuf in kernel, but that just doesn't give
> > anything.
>
> And the reason I don't have too strong of an opinion on that is
> mainly because it's just setup/cleanup path.
>

I agree wrapping io uring in dmabuf seems to be an unnecessary detour.
I never understood the need or upside to do that, but it could be a
lack of understanding on my part.

However, the concern that David brings up may materialize. I've had to
spend a lot of time minimizing or justifying checks to the code with
page pool benchmarks that detect even 1 cycle regressions. You may be
asked to run the same benchmarks and minimize similar overhead.

The benchmark in question is Jesper's bench_page_pool_simple. I've
forked it and applied it on top of net-next here:
https://github.com/mina/linux/commit/927596f87ab5791a8a6ba8597ba2189747396e=
54

As io_uring ZC comes close to merging, I suspect it would be good to
run this to understand the regression in the fast path, if any. If
there are no to little regressions, I have no concerns over io uring
memory not being wrapped in dmabufs, and David may agree as well.

--
Thanks,
Mina

