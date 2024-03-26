Return-Path: <linux-kselftest+bounces-6666-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE0F388CE24
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Mar 2024 21:19:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A50A62C6A3B
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Mar 2024 20:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5561E13D532;
	Tue, 26 Mar 2024 20:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1gm41FVZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 010B513D27A
	for <linux-kselftest@vger.kernel.org>; Tue, 26 Mar 2024 20:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711484377; cv=none; b=ZX+QWEVIpsAHUOZx2riQtxK0q5YptJIFCLDG9h5HaVc0yfvhtFdR4OLbzmD/uLz+sW7QWdNG3N1brEXv2B8zTOv+6PcV52UMpIN+tGRVgo7WqXlKScICnvcAW0ZJIYfs6ZZ0nIfbTE5elNGsm6FB0xfaK/6haRKELv5CrWT8tbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711484377; c=relaxed/simple;
	bh=/HolUtBGOSvO7vytyqHWVK1okzyRfH/uWmvtvWb27FA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VkpydVnmN0rU9Kv6NBAqSaOTly2U70IQmsEC+so+dhFwj2vPSCL9yEACN3sGwXVE6ivtGHcSb4972moCS8EdW8oyz6LXTrgktd7prrMo5F3JBhCakRNcExjKQIPFYRaEmEB3IMt0VBMAhsdY4WiBUPtS3jrkC/edYMbDi0JjwcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1gm41FVZ; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a46a7208eedso817615566b.0
        for <linux-kselftest@vger.kernel.org>; Tue, 26 Mar 2024 13:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711484373; x=1712089173; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/HolUtBGOSvO7vytyqHWVK1okzyRfH/uWmvtvWb27FA=;
        b=1gm41FVZkSn4Ai7WlX1D0mAvsiIhXcNKLG0Z0iVMbEyuhSc6lAFnYsQce/3uLx2VOQ
         F13pVTO9dMRWzS/d7sfOBXIkS3ngp/9f5y9jWOoAa6189WcyF2NonArWAQ719WFAi114
         zU2eBR/j4Sp8dRmx3JNiO0l7Z06mGs29qV6F7W7oAwBVZ4wOXL0SG4oZfOKMR4pofar8
         GukfmgjQtDxSyZ4EeIfkAX4mF4CDBv3LOIhV1e4bHqCsqkAZkHkXbxpNT7BTyqBDSwo0
         t6V0x1PQN7YCjKQ72LzuDlwkJ2sQ1fUKugFapN4Dt5u28GWEdnMNP+fAmqirbn6HeFth
         mCEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711484373; x=1712089173;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/HolUtBGOSvO7vytyqHWVK1okzyRfH/uWmvtvWb27FA=;
        b=ITDfA1Dd1oVW9TCKRa8v4Ij3UsWHvwvAtXYo/zp63QV2fM740W2QiTmzd3shOWpMAu
         IsNPufa+vyVLZb/BvijBDrYBp9SlxhMnvR9DjJd1nIY7hRmemIOtqi/ZpLpaXPSoVK/a
         d14C+c+O/YvudlyPgHakpTnRf6Z6oOR7M3Xam5a69J9v5GLZL494lrkKtW9kDs76l/7G
         o8WfUguP+HJ0YJFHLNEJgerczIi67ht1rWJcELNF1Xdfh9/k/JkEN86yBzIVWW9FOa1i
         DB/geGaEvr52Y+/XETIdB7A60wBuFnitA1b1BMDGec6vAnVqhiHU0ppJ6FmsRZp/UT8p
         jDMg==
X-Forwarded-Encrypted: i=1; AJvYcCV0iOnqZNlOTjCrxJK8zk1yqFJ8TXkjUan4/cJ7OZFZtZ0d1nGCnZm4/ZUDYB83RjB1CauoNhjROWHWv28737ffmNMxkR0BziHMMset438E
X-Gm-Message-State: AOJu0YxALiNrmyODwwwMtKdc6iHolaKQ9VQsEWp7QQ0uVsdlbigfKLWN
	Yc2Eu+l5yO1jdAoF2uw+/87wserEhsJHLA1IfzB7cPhtffR1TO0rTtQweboEfUfcJjRWXLT4u03
	nju9tt8asdpm07FfHdIFrmIv4mHQ0POyPTzXj
X-Google-Smtp-Source: AGHT+IFjAY/eoFDY4BwdVzDOePbePtoPltk1wuczOVWu/9VSVvPKPc9DWk1TgGZAdfUjGFfCBB9+wtsJgpHCZYEgPKU=
X-Received: by 2002:a17:906:2dc9:b0:a46:70d1:dda6 with SMTP id
 h9-20020a1709062dc900b00a4670d1dda6mr1426517eji.28.1711484372999; Tue, 26 Mar
 2024 13:19:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240305020153.2787423-1-almasrymina@google.com>
 <20240305020153.2787423-3-almasrymina@google.com> <ZfegzB341oNc_Ocz@infradead.org>
 <CAHS8izOUi6qGp=LSQb_o5oph-EnhNOuhLkPSfbQRU3eniZvbdA@mail.gmail.com> <ZgC5JoSiWAYf3IgX@infradead.org>
In-Reply-To: <ZgC5JoSiWAYf3IgX@infradead.org>
From: Mina Almasry <almasrymina@google.com>
Date: Tue, 26 Mar 2024 13:19:20 -0700
Message-ID: <CAHS8izO5-giYhM1bVCLLOXRXq-Xd0=pi0kPq5E1-R=3i=XihmQ@mail.gmail.com>
Subject: Re: [RFC PATCH net-next v6 02/15] net: page_pool: create hooks for
 custom page providers
To: Christoph Hellwig <hch@infradead.org>, shakeel.butt@linux.dev
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-alpha@vger.kernel.org, 
	linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Jonathan Corbet <corbet@lwn.net>, Richard Henderson <richard.henderson@linaro.org>, 
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Helge Deller <deller@gmx.de>, 
	Andreas Larsson <andreas@gaisler.com>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Arnd Bergmann <arnd@arndb.de>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, David Ahern <dsahern@kernel.org>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Shuah Khan <shuah@kernel.org>, 
	Sumit Semwal <sumit.semwal@linaro.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Pavel Begunkov <asml.silence@gmail.com>, David Wei <dw@davidwei.uk>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Yunsheng Lin <linyunsheng@huawei.com>, Shailend Chand <shailend@google.com>, 
	Harshitha Ramamurthy <hramamurthy@google.com>, Jeroen de Borst <jeroendb@google.com>, 
	Praveen Kaligineedi <pkaligineedi@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 24, 2024 at 4:37=E2=80=AFPM Christoph Hellwig <hch@infradead.or=
g> wrote:
>
> On Fri, Mar 22, 2024 at 10:54:54AM -0700, Mina Almasry wrote:
> > Sorry I don't mean to argue but as David mentioned, there are some
> > plans in the works and ones not in the works to extend this to other
> > memory types. David mentioned io_uring & Jakub's huge page use cases
> > which may want to re-use this design. I have an additional one in
> > mind, which is extending devmem TCP for storage devices. Currently
> > storage devices do not support dmabuf and my understanding is that
> > it's very hard to do so, and NVMe uses pci_p2pdma instead. I wonder if
> > it's possible to extend devmem TCP in the future to support pci_p2pdma
> > to support nvme devices in the future.
>
> The block layer needs to suppotr dmabuf for this kind of I/O.
> Any special netdev to block side channel will be NAKed before you can
> even send it out.

Thanks, a few questions if you have time to help me understand the
potential of extending this to storage devices.

Are you envisioning that dmabuf support would be added to the block
layer (which I understand is part of the VFS and not driver specific),
or as part of the specific storage driver (like nvme for example)? If
we can add dmabuf support to the block layer itself that sounds
awesome. We may then be able to do devmem TCP on all/most storage
devices without having to modify each individual driver.

In your estimation, is adding dmabuf support to the block layer
something technically feasible & acceptable upstream? I notice you
suggested it so I'm guessing yes to both, but I thought I'd confirm.

Worthy of note this is all pertaining to potential follow up use
cases, nothing in this particular proposal is trying to do any of this
yet.

--=20
Thanks,
Mina

