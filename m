Return-Path: <linux-kselftest+bounces-34007-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D1EDAC8127
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 May 2025 18:47:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A8237AF4AC
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 May 2025 16:45:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 694EA22B8DB;
	Thu, 29 May 2025 16:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aQilQXQy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B523378F34;
	Thu, 29 May 2025 16:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748537224; cv=none; b=lCseMTtIX+AhVf5feD6BNejj/oXvfm8ZXJK6WsHdxpOaL9I5zXx53WcblQYlCpMTNbxQ60/3s+HqDNW23fzl37mc11A2HLLf8+GUocYHz5SMltJyiuops+7pdQg4Qal/CfbwUjoNtuE6VSCvtytgUfBnuXnZRtsAS2xhWaMqzsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748537224; c=relaxed/simple;
	bh=IvWgcjpM+MG6FTrrPS5zXOf0K/wcnP/inkpyL761qmM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OZrXVTXZHqcdOJb2ooWHaFTm9AnNnGzEu949gwiciUCO/cxN2LR23UemCUZophaVYDg4VP3G3FO3VEd/BOcXhNRXjr/HPMab+drSUakxjhPFaMEZn8SkDVreC1Z/BrvpqGMn9xohMxXkc3bY0BeqdFsiGGPdIwhY5rm6Y+wjUE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aQilQXQy; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-450d37d4699so3392225e9.0;
        Thu, 29 May 2025 09:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748537221; x=1749142021; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IvWgcjpM+MG6FTrrPS5zXOf0K/wcnP/inkpyL761qmM=;
        b=aQilQXQydHyIVSU6QINEMMe+ASq4799MoT55DUVDRcKTLyrPjD9Rer0o5+eyszXL5A
         kWz7Zq7rBosDPCPkYtN4Yk0qQdOvmqAGL0CzOCoCa4/wVixPkP6W8+ahjyU8J97e3DsV
         Fhj3/PpaGgstNuUeitEbv7WnNQPDTrz4tzgtEDTfNkP2OMrcEQYOnXFyXXrYZvwhkLjJ
         H1fn10dFHfND98vuo3qBhacXOfZALjdZaRExaxkQti3nby5boZNfghS0vsX7yA4XwNrc
         S7LrNuuNdSGSSY35J78lFg0uT9c/s1VCTf7I/hiShf1SekLa5crECja4Pc6AdIoQre5P
         y7qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748537221; x=1749142021;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IvWgcjpM+MG6FTrrPS5zXOf0K/wcnP/inkpyL761qmM=;
        b=m718dhgbpP8tIGAroNRMpywW2gRNOB8pT9LaGqF9EDT21qY/8B2z8yq4Or9z6poNq/
         uef/pBRp8cByN/x3h+fnJSw6mB+BaIV52epXxF3OIqrx1n0jwO2xwuHoKNhmgQ5kKOJj
         x0C9lNGFe4pPSgPGNCXCb1kHQ9hIYqej8bsJmoH9bLZ8UO7r4AcSAk2V44y5S1etHRCT
         ICqvPbns7ZxjVJvmbnSIzHeZSMcN9jNbcLEvROqQ0DqJemh+yGeRqp2ouZ5fqnKHuWB1
         dHzoZtJ3dZ0JzuWfrt8Isle0HHY1JS7PvSgrFSUppZTTtoCWUoCxgv94tNy1RBk0d6gK
         D1sg==
X-Forwarded-Encrypted: i=1; AJvYcCVR3ojlzrfamjNS+5S/38ACulGTKwGaKNaSrYNOdr15TmOUkoDn+WTq5cCwt6KALP4NcCZGlOF08t40xJHN6mPK@vger.kernel.org, AJvYcCWcZEbqaO8ICKlW4MkvD+hO37reeTx3viOsBnO7sAOpcu35nEWTIv/Kd3UdCfNu89hwoIfyWqGisW2Rebc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxxa3xQqmhL6YZSBYDe9gegfRGoHuthtmK37ZqmLBYaUP1MYDP4
	FP8NJJHiQ0Tg27DdBAg29emeB905qubv1p8ePuG+C9yPBEK5z9F3VGr2i2BqAs+5+AIHpOPRiL3
	WSnHeZ78uY34+T3iOWld5ddEHG+48b5E=
X-Gm-Gg: ASbGnct8U3YixDXAl9wDOsk34ndmzdoqwFReaU1F2rM1B74YllgBwkVEJ2Qcl9bQ2/X
	HCm6NZbHs8YfkAEsG8z2KT1QG4n/6xQi+G73o60Ejr4Ljasbn/BZUc764CF3BdOvNu0WPNNHlJN
	NJIGh7xT4X2fH58Q3Ms/beuHya335mWhhiGrvjnTCmKDu2fj2IuathlU4PO5g=
X-Google-Smtp-Source: AGHT+IHQ+BRyC5kZfuSwmuc+jsFUskhxJSftVM0yFnsmSz4uOzMkH4dr5F8CYkhdw+m7CRwwAGJvX66cRIlLL+lbKNY=
X-Received: by 2002:a05:600c:5249:b0:43c:f81d:34 with SMTP id
 5b1f17b1804b1-450d64d3fbemr4950115e9.9.1748537220853; Thu, 29 May 2025
 09:47:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250528161653.55162-1-jiayuan.chen@linux.dev>
In-Reply-To: <20250528161653.55162-1-jiayuan.chen@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 29 May 2025 09:46:49 -0700
X-Gm-Features: AX0GCFv2fO_u7DrzrMdRbFgY7j1cPOxchmaXJRuhBASFjmjKWsCf7blknPJjxf4
Message-ID: <CAADnVQ+hP9xYH2f4hiUtEcG8NGETTO7BicbRfpd9zxMPnosLHg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 1/2] bpf: Restrict usage scope of bpf_get_cgroup_classid
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: bpf <bpf@vger.kernel.org>, 
	syzbot+9767c7ed68b95cfa69e6@syzkaller.appspotmail.com, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	Feng Yang <yangfeng@kylinos.cn>, Tejun Heo <tj@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 28, 2025 at 9:17=E2=80=AFAM Jiayuan Chen <jiayuan.chen@linux.de=
v> wrote:
>
> A previous commit expanded the usage scope of bpf_get_cgroup_classid() to
> all contexts (see Fixes tag), but this was inappropriate.
>
> First, syzkaller reported a bug [1].
> Second, it uses skb as an argument, but its implementation varies across
> different bpf prog types. For example, in sock_filter and sock_addr, it
> retrieves the classid from the current context
> (bpf_get_cgroup_classid_curr_proto) instead of from skb. In tc egress and
> lwt, it fetches the classid from skb->sk, but in tc ingress, it returns 0=
.
>
> In summary, the definition of bpf_get_cgroup_classid() is ambiguous and
> its usage scenarios are limited. It should not be treated as a
> general-purpose helper. This patch reverts part of the previous commit.

I think it's better to make it generic enough instead
of reintroducing a bunch of prog specific proto handlers.
See this discussion:
https://lore.kernel.org/bpf/20250528020755.33182-1-yangfeng59949@163.com/

pw-bot: cr

