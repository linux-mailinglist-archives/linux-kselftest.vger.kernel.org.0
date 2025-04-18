Return-Path: <linux-kselftest+bounces-31138-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A2326A93A54
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Apr 2025 18:08:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D70233BCA14
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Apr 2025 16:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F3B521480C;
	Fri, 18 Apr 2025 16:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="OUc7G6LQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B0481DED51
	for <linux-kselftest@vger.kernel.org>; Fri, 18 Apr 2025 16:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744992525; cv=none; b=KkHsNAHMOilwqaB2e22E5LPb2SiS0wKiJAJPn2KRJu7BKBCxGqFWRwnsotL059DK/pflpyCmSD0BbzxgeMawLCKtBHcdhsWzPStmtiIB9Ekx4TAKMoBtLVVlseQRWk0qUGPkvUYAhuK0RXQErGp/0rrpoORb+9znU/aNl59ckGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744992525; c=relaxed/simple;
	bh=GTRsdQyPhwEI7P5aYqr8HqSfKQVDCSCnob+lAcXVoLw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=K1lpGzO6rUDTc+K/IKKFhNzcSKGNtf5Nd3edna6fRJxbr/hKn236G429/KapZtg6SbZfr7Xwskypk1AtK1Kc0OlijP/qHZZZVUnMs26RTRl0nbDWM7NCNh1tujh//01zapCXEKLKIznu+Y2Dw5i3z8duXNohRWpB3q+McMM4kAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=OUc7G6LQ; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5f62ef3c383so346444a12.2
        for <linux-kselftest@vger.kernel.org>; Fri, 18 Apr 2025 09:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1744992522; x=1745597322; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=GTRsdQyPhwEI7P5aYqr8HqSfKQVDCSCnob+lAcXVoLw=;
        b=OUc7G6LQ73mGB3DSetYq+jgZEbW4ByPEhGZOhVLDWDlIX11Khz3KdmAJaLD7k+vveH
         q8oOBBBvxNkk0J9aApAIkkhXudc7L+kKIPlwaaV4IPHmUJjnAGwhneydTEl69jaIB+OR
         z1bIt9HDDFLliHRvUMG85CID1HNVNR+pSNWgJu1vqrszyX7PpCLNi1Nclg/sr8wYVpOz
         rckvt6+U1/KJ3XqkdeXsLQPh1a2pD+I0SSTBuAMbrkhHfUfpy/PiZ354IzR6NqFFd6/o
         5ZUzB38NSdvc4a1Eawm3VUeV87ROkIF/Zl5oIwm08/8NQTaZWzbN4V1BivP7hpiyzCwA
         N2yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744992522; x=1745597322;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GTRsdQyPhwEI7P5aYqr8HqSfKQVDCSCnob+lAcXVoLw=;
        b=YjSZhyspQJ0zNdGsiyTflBZKgiuQ+uBiGIrMf8hzSA9pFdMk7ZBdoCOwJBzFtAh7X9
         y/Wg+Tf1tfXWnhFxfCqkGZJFHsWdcneAWG1Z/vDV47FSZnsMXZaW4rhHCzhF6TDIOF+i
         q5aWAtGW1GE9BeX+5Id5s/bA0WjflP1sh1CRtyTfJL0eANM3oqUHxR/98z9HvwlnBVbJ
         MjaAcFl4+LZks/QUUwKE4P+AwRUoqCBlYaXdEYHnLbLax3cCSqjh3A98aOPcY58ot5RF
         xKfiUtvKea++oUQ2a2rFz8YDcnN79BtoVH4AkNaLo1Oj6UjJ4ak0gkmaFeZgZOZ/5/xE
         ou7g==
X-Forwarded-Encrypted: i=1; AJvYcCUhSXDYTduG9OlKls6jMwPqrR99td5+OwV+vpC327rN4IQx1hziSssHHhyt9v1FZ1k3qVtaRe5ONatrX0tuAcw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzH9FL2g5336PAZpC1AefhJc8u03s6EYpQXEg8OlSkzrLARRcdq
	4MWauaw2WtkyB+vgKVZD2nUNQrN/m7oEUqB47PVs8mu0+b4W/szlXGu6EaBN1z0=
X-Gm-Gg: ASbGncsD/fZBg5d+QYkfrKB82axLPUaFXg/byKhsZPOGQpkjmU9addmyWDbyT1D7q40
	rzowoisIoUVZqQk2Qhzv2DTjDFSXYnjTjEwAzMbi9/qgb9FCqWRfDHtLZzSfpNRkOG2Ex4Dfkst
	KCC1+oORsz9ZjVlXkB9Ev0s/tjVRqPMSzVl/j8WUOR9VyTsah6kYztM95BfSDlG1wy1fXNLqFk2
	DxqPkXu/4elCnm+tKWdaij08nvyQueJO2jJvtrFsvI45OQzLZ1KKSfxil8geVvlHeVekKgGtxWn
	g6aKI7wUuif/We7d/ZhCHSeT7pkS2tELBAw8BEUg9c8a
X-Google-Smtp-Source: AGHT+IHa4TgX8s0MmpF8GB8R16O010Ve/qC4qv/99ZOSj9/ybMOt/qI/ikL+RDoyJZEPVnEbqnzHwA==
X-Received: by 2002:a17:907:3fa1:b0:ac6:d0f6:c85c with SMTP id a640c23a62f3a-acb74b36c70mr264464766b.20.1744992521672;
        Fri, 18 Apr 2025 09:08:41 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:506a:2387::38a:4e])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acb6ec51601sm137723466b.74.2025.04.18.09.08.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Apr 2025 09:08:40 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: Andrii Nakryiko <andrii@kernel.org>,  Eduard Zingerman
 <eddyz87@gmail.com>,  Mykola Lysenko <mykolal@fb.com>,  Alexei Starovoitov
 <ast@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>,  Martin KaFai
 Lau <martin.lau@linux.dev>,  Song Liu <song@kernel.org>,  Yonghong Song
 <yonghong.song@linux.dev>,  John Fastabend <john.fastabend@gmail.com>,  KP
 Singh <kpsingh@kernel.org>,  Stanislav Fomichev <sdf@fomichev.me>,  Hao
 Luo <haoluo@google.com>,  Jiri Olsa <jolsa@kernel.org>,  Shuah Khan
 <shuah@kernel.org>,  Jonathan Corbet <corbet@lwn.net>,
  bpf@vger.kernel.org,  linux-kselftest@vger.kernel.org,
  linux-kernel@vger.kernel.org,  linux-doc@vger.kernel.org
Subject: Re: [PATCH bpf-next v2 2/9] selftests/bpf: Add socket_kind_to_str()
 to socket_helpers
In-Reply-To: <20250411-selftests-sockmap-redir-v2-2-5f9b018d6704@rbox.co>
	(Michal Luczaj's message of "Fri, 11 Apr 2025 13:32:38 +0200")
References: <20250411-selftests-sockmap-redir-v2-0-5f9b018d6704@rbox.co>
	<20250411-selftests-sockmap-redir-v2-2-5f9b018d6704@rbox.co>
Date: Fri, 18 Apr 2025 18:08:30 +0200
Message-ID: <87h62la1vl.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Apr 11, 2025 at 01:32 PM +02, Michal Luczaj wrote:
> Add function that returns string representation of socket's domain/type.
>
> Suggested-by: Jakub Sitnicki <jakub@cloudflare.com>
> Signed-off-by: Michal Luczaj <mhal@rbox.co>
> ---

Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>

