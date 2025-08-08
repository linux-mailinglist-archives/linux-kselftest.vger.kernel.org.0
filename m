Return-Path: <linux-kselftest+bounces-38613-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CAC6CB1F04E
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Aug 2025 23:39:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86162724529
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Aug 2025 21:39:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D41D26B09A;
	Fri,  8 Aug 2025 21:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NcDrFcq7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E55C260583;
	Fri,  8 Aug 2025 21:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754689166; cv=none; b=FC32Kq+FnBehP6O6MM6MaEdFCFaoUhx6iZIHddgwFJ4JFgYNRJTys16QkEMyHosvYoHzTtEcFAFy2HxhjuBo3KkLMB+8M9cBktEeoNnMExcjw0zPCTxY9BAblB+Xoy13RVFCKkXfyy3FUdRL9nVFWbiNaSOcgkmpfHQCCnM46Tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754689166; c=relaxed/simple;
	bh=Jl/mXFEH1/52E85/DAIxE+557Qpji1PzTe7wyk4Fn/c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cB9ruHUUXMz94YYNoioq0Gw/hEoIqDW6BZ+H8X1kl27Ub2JxOff/ZerfvghPixPzdC+yWBNQugBOjs3SkbQfDlMFl3fA4KogrQrvhgWzbbjUZv2LZyQq9CxSegfJVnnsyrsBAkKYeo206j9es1i0v97ejtyRLFyGpOC5nrRlOXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NcDrFcq7; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3b786421e36so1348538f8f.3;
        Fri, 08 Aug 2025 14:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754689163; x=1755293963; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=55u7vH90l6d9M/e41IVEbxO/v4ORJzJ/yvveeKrIC+o=;
        b=NcDrFcq7X/oeqN8guNbEogGrPCXsC5YU58cGNJus5bNScm8PllM8L9lsLfQtrF39Dt
         X49JZsw/wv4kki/6YLK4re2emHDkwJ81KR+lWwnBwkuP8xjvI2tMaFDh7rFFT0Ay/GBv
         MD3ZmzvL7SjZRNsD6IRCpMR1JU2fqyqQ0JR5FWa4PKrPBOtr2hHWk3g8CvmrFyTbx01M
         JmbxZiYREX/JJWjlzl+bm0ygjP1Vf1yzY2TuRHrO5RLHPX2Q4yFGD2G8sqN7rJFVhfQX
         QU6Ggr3cb+wwJxiwVKGRDhpYCg/12ePzy4bWQ6fHCOZdpFREHwMFjcs5nOSQszzsfdIf
         5TuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754689163; x=1755293963;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=55u7vH90l6d9M/e41IVEbxO/v4ORJzJ/yvveeKrIC+o=;
        b=e+zTXxDllUBAZTdpEr1scz9sBEJyMDOuyXRExue5GGK5ol05V9Udw8Wz/RkxKnJxUZ
         NF9w3/wcLJqqjWB5yzLpV15d1T28U1Rt8PGORBpm74LKvQducuywjI8Xg6wVCaPbufqY
         LQSgPrNhZitXea5ceuPkHkEPZJZMOZyk5lJtRdbZz7qd11bucfHsJA/EYBWCg4d1t8PB
         B1bGoTJRUMGzXv5ZFpSVahsKGf0fTxsCcOPnoi87nagCEpepT+jX4FDkzY/LNoi7PuXM
         prfloOhs5N3h3tqpo0o9c9ofYuHIkVLVWLnRi7hzNR1lpM7k0CIeUuoC2UJWBOK10ANz
         ys1w==
X-Forwarded-Encrypted: i=1; AJvYcCU4kSUw3krpW+Uq7fLMPDeKZ4IbN5MparxQoKQkNRlJXdLJVRij/1cJColDCL2ZjsDQF2kWYVWP0irs5JI=@vger.kernel.org, AJvYcCVsXdi8eDub51Fzy+RfS6gMf5H7FFnj/rrpLI3UQIpI1+o0qdWD4wosE3JuhfGgju0cTYyoqjpmBCk4F4fBD0IL@vger.kernel.org
X-Gm-Message-State: AOJu0YxVEzYiu5vCNcvw402DW7D5QzwEkw4+nW+c/cbWJMZUnaXUlEfX
	KHxpayYjbV3KJ9ore1uyqti4jnvQmSlna0C0ODF7/eHzg3PvB/i35yIKtbRo8spKnSyYbM0kYX/
	3zViKgvzkXjl0wkv90bKJRP0ZRTYN0Wo=
X-Gm-Gg: ASbGncujfYxRmEJC4KJu2M1uZwUixo5QbkP94oV9g96VEGM4tH3tKBcrWBftJKQPvSu
	FLreHy3/WCTyIZ4tqJwUZ4/SLbe5cPiCTnBCUsyEwkVD6HqaFjk8UruPdDvvjSr7NKK0vNjlzdk
	/Z4h/sqdR7J5bSkJg3VHqEC+Tp9tOzPIaW2NWrecR85H/4zb2ShoK+tUDT5tFysMuafIUS2+KL5
	qrrRzHASlBbJGW5SUBZQdWzLcS5Ze0OK+Dt
X-Google-Smtp-Source: AGHT+IFDbe+XThdKFsROQjQ2xGQFub/eFOWxbr0Ha7MbydXuOTFgaoIOomkUiQsPv0iQeFmXojQxfNhv2GWQEHB1Hqs=
X-Received: by 2002:a05:6000:250a:b0:3b8:f358:e80d with SMTP id
 ffacd0b85a97d-3b90092cb16mr3865404f8f.5.1754689163196; Fri, 08 Aug 2025
 14:39:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250804022101.2171981-1-xukuohai@huaweicloud.com> <20250804022101.2171981-2-xukuohai@huaweicloud.com>
In-Reply-To: <20250804022101.2171981-2-xukuohai@huaweicloud.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 8 Aug 2025 14:39:11 -0700
X-Gm-Features: Ac12FXxdAOyqiumyweIK4syTyvcUnbL3-xjQaV4RJaVvhcSywE9fWGmnmZu_ZC4
Message-ID: <CAADnVQKC8HdoEnjL-Y3tDrfghJnpVddDoSsyDYxacvHLAJqFQQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/4] bpf: Add overwrite mode for bpf ring buffer
To: Xu Kuohai <xukuohai@huaweicloud.com>
Cc: bpf <bpf@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Yonghong Song <yhs@fb.com>, Song Liu <song@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, 
	Willem de Bruijn <willemb@google.com>, Jason Xing <kerneljasonxing@gmail.com>, 
	Paul Chaignon <paul.chaignon@gmail.com>, Tao Chen <chen.dylane@linux.dev>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin Kelly <martin.kelly@crowdstrike.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 3, 2025 at 7:27=E2=80=AFPM Xu Kuohai <xukuohai@huaweicloud.com>=
 wrote:
>
> From: Xu Kuohai <xukuohai@huawei.com>
>
> When the bpf ring buffer is full, new events can not be recorded util
> the consumer consumes some events to free space. This may cause critical
> events to be discarded, such as in fault diagnostic, where recent events
> are more critical than older ones.
>
> So add ovewrite mode for bpf ring buffer. In this mode, the new event
> overwrites the oldest event when the buffer is full.
>
> The scheme is as follows:
>
> 1. producer_pos tracks the next position to write new data. When there
>    is enough free space, producer simply moves producer_pos forward to
>    make space for the new event.
>
> 2. To avoid waiting for consumer to free space when the buffer is full,
>    a new variable overwrite_pos is introduced for producer. overwrite_pos
>    tracks the next event to be overwritten (the oldest event committed) i=
n
>    the buffer. producer moves it forward to discard the oldest events whe=
n
>    the buffer is full.
>
> 3. pending_pos tracks the oldest event under committing. producer ensures
>    producers_pos never passes pending_pos when making space for new event=
s.
>    So multiple producers never write to the same position at the same tim=
e.
>
> 4. producer wakes up consumer every half a round ahead to give it a chanc=
e
>    to retrieve data. However, for an overwrite-mode ring buffer, users
>    typically only cares about the ring buffer snapshot before a fault occ=
urs.
>    In this case, the producer should commit data with BPF_RB_NO_WAKEUP fl=
ag
>    to avoid unnecessary wakeups.

If I understand it correctly the algorithm requires all events to be the sa=
me
size otherwise first overwrite might trash the header,
also the producers should use some kind of signaling to
timestamp each event otherwise it all will look out of order to the consume=
r.

At the end it looks inferior to the existing perf ring buffer with overwrit=
e.
Since in both cases the out of order needs to be dealt with
in post processing the main advantage of ring buf vs perf buf is gone.

