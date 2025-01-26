Return-Path: <linux-kselftest+bounces-25195-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C6CAA1C84B
	for <lists+linux-kselftest@lfdr.de>; Sun, 26 Jan 2025 15:11:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A18D87A047A
	for <lists+linux-kselftest@lfdr.de>; Sun, 26 Jan 2025 14:11:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2D081531C4;
	Sun, 26 Jan 2025 14:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="YnG1MiVt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27CCE4964F
	for <linux-kselftest@vger.kernel.org>; Sun, 26 Jan 2025 14:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737900707; cv=none; b=J7cZay7n0tnlMU5oaML5m7v2UQX96z/MD/Mc1P0W2u0ZJHraFw8yOvZfnj9enkWjd/qKDtD84woqVDe33YjvxxQvldCqrrQIHpZ/a9PFXS9oik+X307xTUlZiUnA5cstbPIuZqaTUqI0Qz73ghA2bfoiaje5U/+4OxfDe5aYKAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737900707; c=relaxed/simple;
	bh=12HzqKG7XNFsVb1EKgZbZZW8oeDZ1Bj4ACbSBWVyPFQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=snRRqtVa573vZjLVQR/39nP+mDnVhnfR0sz5V8gfvVQXMYcpWWjXXSKsYfy1ihnQLQxoET2IvOKGzibQbUylRlfZBiTSLHq/8sAZffzWkxpKWuSZ/CbxrmHez2X29bB0s3Vx0HULZHs7DnRO7riRC5HX4T3d56ttaPbfkQR0Yjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=YnG1MiVt; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-aaf6b1a5f2bso950124866b.1
        for <linux-kselftest@vger.kernel.org>; Sun, 26 Jan 2025 06:11:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1737900704; x=1738505504; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=12HzqKG7XNFsVb1EKgZbZZW8oeDZ1Bj4ACbSBWVyPFQ=;
        b=YnG1MiVtxyeJ9r3CsHAYBUzy6KfIIQIxoxtPSVTXES1p+HdITODLJiD5QC+y5BSJ7d
         KajWhHTVVXt3IWoyhJ8lAxgZwcwvXxHWtiZjyk9hAfsgDsHCWnf2AJyUzVsiVVm8ZaTA
         uZGcoHiSLNZla1Hr1K0aaAwlQqCvVRYdzApWQPV6rruZmtA1LwXS/EYurf2Lad+YKPVw
         9Gvp5+vd1rT53HD98Ki9zy2uOttRweItmMIgYfU52AcABSQw1PGdFS5S/CGKP4VpOwxd
         xbD0L4A3d1yJZFead6dE2ueuMWMf2kS/dnJYZ+yytcM4ThQjrwoW3cUel0n/oEayl9k+
         YIlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737900704; x=1738505504;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=12HzqKG7XNFsVb1EKgZbZZW8oeDZ1Bj4ACbSBWVyPFQ=;
        b=CxR/tCh+N3Up5hh3cXrWFn2facj4XGG5m8YESxZDTCrpaxjujFKxYtYJ98rXIbFUws
         7k8gRg7pAKAMfybNRJ8/RmvUjaKk61teKIUn5DR0fcNBTjJXs7P19uuUv3ryXB7VHIFK
         KSHYRl4K9Rbf933F8xSTsViHbi6PFvTOsghmaWWIU3wB/fQI8SA00/GaShYc2vBWs0DL
         aDWPOSkBu14uuqrBL9QIu67cMlxum3izPeNUn3qOZ7RHoAu2qDs5vdhIS3AJx7XoOOnx
         YkjGq3tDM40TqfYlwYhbk6APJeHtXZlLsp+0LavTzL8fLkbmtXuJGho6DvZnfk0W5fYM
         86BA==
X-Forwarded-Encrypted: i=1; AJvYcCVjUFXDHcRuQXPnRqhXZKHl0K1AedFHG4TE9w+mNzVRWfAe0+u9Ifda6T9A+G4v3YwVQKjfcRU13+ejk4O05cI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvNymseINBKKAAl3DnSRez9VM/ZR2ZIXxlWf92YnS3vWuYb1Yo
	Ni+6peqLBJbzB9j78jaOYA6egM0K9G63lGnbGuQl7zIdTgG6eRgAf3VTumOcHq0=
X-Gm-Gg: ASbGnctN6AmepsVUaz3fDVeKaijGQmad+RDEQbjtt7u7L1TFKg4aWG+YIz+kOp3yoNF
	KeXGAVg1CGxD7EogoVcOGRM/qX9h3oVVQzMfGctY9fBvDsm2IUujGSRnjq6e8fQ1d9vjhF4p0jq
	Gxeb4MgJtS3DRrIL9KJXBafH9TSLQNJlHMoOtS3vhjCwLp+KkQIhOWPzcbhK6MhDk9Mezgb5qfU
	/KaCOkssv9ynnJ33rdFQzKv0OtIO/e3ir8PSXDY7b6chDFewX0MnXveN7zsHMV2DehiYt7JJA==
X-Google-Smtp-Source: AGHT+IEKSJdD2dRwqzzBvy9ISrqzwSE8h91lW/SaOjyNpZpNcIf5gT5KiPiOM2vkBbUPwNzHl+oUMQ==
X-Received: by 2002:a17:907:3206:b0:ab3:a4f6:7551 with SMTP id a640c23a62f3a-ab674600f00mr739626466b.13.1737900704480;
        Sun, 26 Jan 2025 06:11:44 -0800 (PST)
Received: from cloudflare.com ([2a09:bac5:506b:2432::39b:69])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab675e64dc9sm420223466b.45.2025.01.26.06.11.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jan 2025 06:11:43 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Jiayuan Chen <mrpre@163.com>
Cc: bpf@vger.kernel.org,  john.fastabend@gmail.com,  netdev@vger.kernel.org,
  martin.lau@linux.dev,  ast@kernel.org,  edumazet@google.com,
  davem@davemloft.net,  dsahern@kernel.org,  kuba@kernel.org,
  pabeni@redhat.com,  linux-kernel@vger.kernel.org,  song@kernel.org,
  andrii@kernel.org,  mhal@rbox.co,  yonghong.song@linux.dev,
  daniel@iogearbox.net,  xiyou.wangcong@gmail.com,  horms@kernel.org,
  corbet@lwn.net,  eddyz87@gmail.com,  cong.wang@bytedance.com,
  shuah@kernel.org,  mykolal@fb.com,  jolsa@kernel.org,  haoluo@google.com,
  sdf@fomichev.me,  kpsingh@kernel.org,  linux-doc@vger.kernel.org,
  linux-kselftest@vger.kernel.org
Subject: Re: [PATCH bpf v9 3/5] bpf: disable non stream socket for strparser
In-Reply-To: <20250122100917.49845-4-mrpre@163.com> (Jiayuan Chen's message of
	"Wed, 22 Jan 2025 18:09:15 +0800")
References: <20250122100917.49845-1-mrpre@163.com>
	<20250122100917.49845-4-mrpre@163.com>
Date: Sun, 26 Jan 2025 15:11:42 +0100
Message-ID: <87jzahd5r5.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Jan 22, 2025 at 06:09 PM +08, Jiayuan Chen wrote:
> Currently, only TCP supports strparser, but sockmap doesn't intercept
> non-TCP connections to attach strparser. For example, with UDP, although
> the read/write handlers are replaced, strparser is not executed due to
> the lack of a read_sock operation.
>
> Furthermore, in udp_bpf_recvmsg(), it checks whether the psock has data,
> and if not, it falls back to the native UDP read interface, making
> UDP + strparser appear to read correctly. According to its commit history,
> this behavior is unexpected.
>
> Moreover, since UDP lacks the concept of streams, we intercept it directly.
>
> Fixes: 1fa1fe8ff161 ("bpf, sockmap: Test shutdown() correctly exits epoll and recv()=0")
> Signed-off-by: Jiayuan Chen <mrpre@163.com>
> ---

Acked-by: Jakub Sitnicki <jakub@cloudflare.com>

