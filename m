Return-Path: <linux-kselftest+bounces-39900-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E078B3524F
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Aug 2025 05:45:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D71E13B7D1B
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Aug 2025 03:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B19AD2D46DF;
	Tue, 26 Aug 2025 03:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UM4H15Lt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1EDB2D3A74;
	Tue, 26 Aug 2025 03:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756179919; cv=none; b=FOmMwjxph9KHEt5/cjJh+kes10iNF7R3Z6vFzf7uo1pHxkEMWMOSKZxDM2Utt2GjDkE6YVGSwkt4SvzBOojWEVmMuav+/QYBlAV7gywZJluWKHETF91fQ1udeFZQ81GdKmdr32wFK9dhltf1qoKtvS7NDX4getJ88qAYxyK/CV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756179919; c=relaxed/simple;
	bh=utj6oSW5ZUEG4vl432KrCTGsP3IUgv0f8EZL2SJZn+4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CYq0JQprPPYWWm+/cp2JyFfTxDruGjooxiboUP08OpTXnNe5bDbJYVT64p8yi7hogQHMc3YjHZpvfaRGYMavYYzsNPnYS6+BPBDAFe5l1VhMEXmdgzUhhI0SZIiLtk+PfAZL/Lt93a/RRM49BG1pqlgkJRfoQBk8yB9xnj0agQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UM4H15Lt; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3c68ac7e2bdso2142192f8f.2;
        Mon, 25 Aug 2025 20:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756179916; x=1756784716; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=utj6oSW5ZUEG4vl432KrCTGsP3IUgv0f8EZL2SJZn+4=;
        b=UM4H15Lt83y6wfTihF2h8kOYdMiuY7+ttGdRMouqPVt00ttXSZPr7zQX//eHE23IJX
         DB8HQYp6hk29auAAfnAJtTUhTmA0fkknti8t7fWpOeNl9iCm19/y8djqcfoQ+MLRVUvY
         NMk7pv+rZMqEIgQKiFm5JMHRzfYsPcOqSJPZHE7xvC4w5aIudYaBd+Wzjr7cU6lMmvc4
         UKD2UHyv8s+6VhZN8grTUj78wPc2SKFy2uXDo4CUJ8gM3y0LH6GoPSXk7FMbMX+91cKY
         +oGWp1hKN/lInlCuAnocg9Ma+PTRsziX6ngjHLY/Z4Hrwsu9tU9vP2zf/+0K64/22xFg
         +NDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756179916; x=1756784716;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=utj6oSW5ZUEG4vl432KrCTGsP3IUgv0f8EZL2SJZn+4=;
        b=ToUz0/PlowRaFNRH6AhtvB+0m4Rs54qaH33GZEw+ib4Ei5N5hsTzWhsQ1MmgPVzHSV
         Tl4L79PLS6HxSyZ6CmukfcO+e3icaDIsuOK3ZSFp8YNK/enHKMrzbguuIGYBN/vPhiJ3
         mAMqE8n5zzdygJNHtC8V6BcAwf3gj8sYF+jqlLseRMY3Y1/gy4JJi1UOpp6/AP3Djbh2
         ijca1ur4blBmXaqVtKuBBv74g8X/2qLNAFVxYZfCY3lIkmScr1F+6nPGtsHoG5166d5N
         RHw/HHg7GUl54Ihd2DM2lIArLVOsCvgLIcrl1Cy0K2x+ZOgdFOlNRX8kNVv3BE1hOK1e
         4xsw==
X-Forwarded-Encrypted: i=1; AJvYcCUlabPY6DxQRF57tSw2R9ZU/aZthjMN3xqtH+m7jEbMcXI3UivN/rQl3ZmRrgbOtUVbCC2TC7cwJF71waF3PCn/@vger.kernel.org, AJvYcCWko5o+B5+E1UJEmoRN6dwcEhqZevQmIh+0a2033wKpZ98FCyXnE8AIYkkg9dyTGpQ/3GKNs8GRmA==@vger.kernel.org, AJvYcCXZR+jyMaD5lK4+ZLfqGgSbSKqbNeWVvQXhUG+Ns/fbpJowtpbfcN80soaRCVIQZDghxEg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3wIZsh44rLJ+4NJtj03tzUYOtg376DgAhT3E4KfaQ7kW3CFqQ
	5IMcvhuRNVApPRBsTZ9dZD0sdyENfrNiy8UkZ13W9mCHFAyIiLrep5Gr5RfCUigPe/Q1EFpZSXW
	WL6nvtoNFVBL9+m9GKbOV13QEmviR/bI=
X-Gm-Gg: ASbGncu3k2OshdaeHsqoAhkunrBHkHNlif5xIf4UdPE8Kzvvk12ZyjclXY+8AHPlEUQ
	MBnNBPleU063mkQokBN+wKTKHxIwhJAFHqdG31kcOBqttKJld0LsZsjN41Wjk+RSyPC5XriwyY3
	77gVsEE82XOOvdhLphbmL2jEHrDmf8q8zuY6JlDb2Rs373KB2Ckra1Xkyfj6JtG6uVM3R+unZEw
	VOn7cRfLDpSBpygeKR2NVPMmnrqqsO1hUo6
X-Google-Smtp-Source: AGHT+IE8tAERy66ebNFyetXswIwytXMj5tlMnn6E3Bk3RgvAAqw155HhAxfdkCJZhRl67xjXw5S2DOxFATpXvb3zLro=
X-Received: by 2002:a05:6000:1a86:b0:3c9:8600:9a65 with SMTP id
 ffacd0b85a97d-3c98600a509mr4199606f8f.28.1756179915903; Mon, 25 Aug 2025
 20:45:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250818090424.90458-1-tixxdz@gmail.com> <aKNjkp5vR2ES-2Xw@slm.duckdns.org>
 <7d8af2a3-0649-44fa-abc5-17f2911b941b@gmail.com> <aKUhkIdCEsIqmvvV@slm.duckdns.org>
 <efa7d1ed-9cfc-4e32-936c-a2f7827da1c9@gmail.com> <aKywEsqVAHdgasZw@slm.duckdns.org>
In-Reply-To: <aKywEsqVAHdgasZw@slm.duckdns.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 25 Aug 2025 20:45:03 -0700
X-Gm-Features: Ac12FXz924wbgTHCTCL7hp8RP3qerz0FLZF7ncUo2N46yPEDEoRtgpi5W3ZnC6U
Message-ID: <CAADnVQL7Ps9u41jYSVEd0+u4M01q90jJCW6Op1H6Ypsc0ht18A@mail.gmail.com>
Subject: Re: [RFC PATCH v2 bpf-next 0/3] bpf: cgroup: support writing and
 freezing cgroups from BPF
To: Tejun Heo <tj@kernel.org>
Cc: Djalal Harouni <tixxdz@gmail.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	=?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	"open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, tixxdz@opendz.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 25, 2025 at 11:48=E2=80=AFAM Tejun Heo <tj@kernel.org> wrote:
>
> Hello,
>
> On Fri, Aug 22, 2025 at 07:16:15PM +0100, Djalal Harouni wrote:
> ...
> > I do realize taking the same usual path with write is the obvious thing=
,
> > but we don't have the corresponding open context, and faking it seems
> > more trouble than calling directly cgroup backends...
> >
> > Allow me please to do it again directly on cgroup_base_file[] assuming
> > it was Alexei suggestion and see how it looks.

It's been 1.5 year since v1. It's safe to assume that all opinions
have changed, including mine.

> I'm probably missing something but what prevents you from getting a dentr=
y
> from kernfs_node and then calling vfs_open() on it and then do vfs_write(=
)
> on the returned file?

Generic vfs ops from kfunc feels like a can of worms.
It will require a lot more thinking and coordination with vfs folks.
I'd rather keep things simple especially, since this thread
might continue in 2026.

> If there are some fundamental reasons that we can't do something like tha=
t,
> let's go back to the simple approach where we just have bpf helpers for
> freezing and unfreezing cgroups outside of fs interface.

I'd just do whatever version of cgroup_lock*() is necessary
from kfunc followed by cgroup_freeze(),
and limit kfunc to sleepable progs, of course.

