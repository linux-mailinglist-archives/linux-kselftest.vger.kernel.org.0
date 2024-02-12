Return-Path: <linux-kselftest+bounces-4519-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68A4D851BED
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Feb 2024 18:47:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24DD5B26FBC
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Feb 2024 17:47:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E46F3FB28;
	Mon, 12 Feb 2024 17:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UHgbx6Bb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3341C3F9CC
	for <linux-kselftest@vger.kernel.org>; Mon, 12 Feb 2024 17:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707760002; cv=none; b=DwH7voReyBgjcdoLH5WUxEMmOIMQGILix8xy2vP6dDtgUWnJnK14Ov5IOrG6QE4yPZusg/qZKYB8R1kbDHuJ086p3E/ZXFKWRCnAeyZogl/GNKCZjT7orOSQgeNGxhpYCIDUFVfeSKcujQj9Otzui3jYXu8FXFoER9oRawvIq3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707760002; c=relaxed/simple;
	bh=CVNLoBTpg3SuaSY3T7L6dyU4fC9xnaUQyseVWU7yx70=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UCo56D1ShFUk68iUKlfwaYzOLD8yV14eqM45dwzCXADbJoeobJ59QGqi2IXvpB3SQJrctU0+9ukHUVwgoZbQ+n5ROsRLHzAIPnBgBnLJ+7cLpKk1qjtO23T3X36zaDQPNAcI7BTbN9i6tcIJdI2Raz7HH1flHE4bT95kksolaOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UHgbx6Bb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707759999;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CVNLoBTpg3SuaSY3T7L6dyU4fC9xnaUQyseVWU7yx70=;
	b=UHgbx6BbnjbNYs+ohegzBhqpL6X+8W6y35iIfSpL92Y48XlaFO9oToLFsR/VYarVW9Xxo6
	DGg41vERhWLQikOYt2fHPrHqEbVZD1eH+Mgf80fNcZtd4Ybx2DsYb0kRI4uxg75U97Hw/O
	CcEEhEI1iMnokiAVYMxKbVmEkFMikVI=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-637-d0H8YAu4PAyjRC5-sdgTHQ-1; Mon, 12 Feb 2024 12:46:37 -0500
X-MC-Unique: d0H8YAu4PAyjRC5-sdgTHQ-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2d101f2e09fso5990641fa.2
        for <linux-kselftest@vger.kernel.org>; Mon, 12 Feb 2024 09:46:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707759996; x=1708364796;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CVNLoBTpg3SuaSY3T7L6dyU4fC9xnaUQyseVWU7yx70=;
        b=MAX+oARBlpPMcX1fXeH8Nii1ATDJhZsh1L8BdiNwztdrwYVrYzG/XutP3ABVpRUZhX
         BIxUJ+3CSVe3o/E8EiFeAdxNE7sIujZQqPAYJWEvbFR2EUpVBUBV/NBfIJ4dPV0sCLkZ
         sZz/7Y8qjbJNW8ZfB7fJSsS1L7LeUSym9NbUAxGOnDLtgaQj/M0+cPmYI5Kfu/WdOscX
         HDLJKFwhHYLFSezxxuItgCqjJohNxB6fK32HYfg4c8zk6CNumm84qp1Pxdbqtzow4ubb
         nqAY3kenzcquaSJgppP17/ghDxtUZGS/KoUDrmi/A4bxPkJdx4VbLdZ5/2CiB62OZ6CJ
         mazQ==
X-Gm-Message-State: AOJu0YyYNVdStD0buKUJ82oPkHM87Frp7johs1Bg69WQYvYn/jQXMKw1
	KIxQIbPsxoYbxS8PoVWs/lvgaLgWqpiorVmazRt5lavzAA6ftcbRaXU7uSmQR8skqXvhZT4LUAh
	P7LmfqWvFKyn3i/BO+JAxIzjk+bXRTvMcm2GkwhgnjL+O1NlvYmKk2AyywbC//DgY1Q==
X-Received: by 2002:a2e:96d7:0:b0:2d0:9f3f:7454 with SMTP id d23-20020a2e96d7000000b002d09f3f7454mr4537350ljj.23.1707759996101;
        Mon, 12 Feb 2024 09:46:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEDLaOFvqDM4HNn1dbpMZ9TA7ctF0dgjgp2YSVWd/JfhR1n+VdcVyLbB+7+AP3nkXqAaDCXgQ==
X-Received: by 2002:a2e:96d7:0:b0:2d0:9f3f:7454 with SMTP id d23-20020a2e96d7000000b002d09f3f7454mr4537328ljj.23.1707759995656;
        Mon, 12 Feb 2024 09:46:35 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXTyxnX7RzEvixrd6bUAlXbwyVs3W0zBmUf9jJ39surd7MmbJS2lkLYS5l0/+iB2U+XYD4n3sYblzbkOXb6S+oYnDg3wUkn6ciQ/6eX/w2chonC7hWY1TigDO15pkD9rstm2hi6AWK+fJu6IS9NiUi73JpwUEHHs9G2o5rU7P4xGS5Pb6enIHJEKx9rTArFhitByK9sOZHFpBe50yt1tGYcw5JtDsLNzadXE9jKs5ea5qllU79y9M5RNOvms6yWqxp6+fya2BsRzEMouWNFLCq15EOIKIl/ACTcCEXn4BHLnKCkTtM+RNPN9xFcpjyKuN5TFWsXAJVm2VSkyE8gsXJb27j0GtVOydZvbUvgcxyUMctXLeEj1ForVbvJ5FFQZUSngYvjsMGTuoAhz4YG/99py0ffM1Lhm5jRmSvI1Qtp2bvps1iacY+2huSS8dmRtxGX5FLZ4xHJ1jnYLdKQF1FcCFSq8sN1UL30PmURAv3S6tkHNplmWgPGypF6xdivX5XFa8cbmeGXs3e2//wdfKBIxIjAGbtXsRHJRaOKRr+hTrFtQ/Sl1QnSu3eV9JRBMnts2My0ZZCqOmMfl26hyhJB9bzGNhzoPi6AkI2XlCjAwcA/0/vpfHCwn5wuDso=
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id fd9-20020a056402388900b005607f899175sm2968463edb.70.2024.02.12.09.46.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 09:46:35 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 0396C10F55AE; Mon, 12 Feb 2024 18:46:34 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Benjamin Tissoires <bentiss@kernel.org>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, John Fastabend
 <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, Martin
 KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, KP
 Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Jiri Kosina
 <jikos@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
 <shuah@kernel.org>, bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-input@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH RFC bpf-next 0/9] allow HID-BPF to do device IOs
In-Reply-To: <CAO-hwJLvEGNRXc8G2PR+AQ6kJg+k5YqSt3F7LCSc0zWnmFfe5g@mail.gmail.com>
References: <20240209-hid-bpf-sleepable-v1-0-4cc895b5adbd@kernel.org>
 <87bk8pve2z.fsf@toke.dk>
 <CAO-hwJ+UeaBydN9deA8KBbgBiC_UCt6oXX-wGnNuSr8fhUrkXw@mail.gmail.com>
 <875xyxva9u.fsf@toke.dk>
 <CAO-hwJLvEGNRXc8G2PR+AQ6kJg+k5YqSt3F7LCSc0zWnmFfe5g@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Mon, 12 Feb 2024 18:46:34 +0100
Message-ID: <87r0hhfudh.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Benjamin Tissoires <benjamin.tissoires@redhat.com> writes:

[...]
>> IIUC, the bpf_timer callback is just a function (subprog) from the
>> verifier PoV, so it is verified as whatever program type is creating the
>> timer. So in other words, as long as you setup the timer from inside a
>> tracing prog type, you should have access to all the same kfuncs, I
>> think?
>
> Yep, you are correct. But as mentioned above, I am now in trouble with
> the sleepable state:
> - I need to call timer_start() from a non sleepable tracing function
> (I'm in hard IRQ when dealing with a physical device)
> - but then, ideally, the callback function needs to be tagged as a
> sleepable one, so I can export my kfuncs which are doing kzalloc and
> device IO as such.
>
> However, I can not really teach the BPF verifier to do so:
> - it seems to check for the callback first when it is loaded, and
> there is no SEC() equivalent for static functions
> - libbpf doesn't have access to the callback as a prog as it has to be
> a static function, and thus isn't exported as a full-blown prog.
> - the verifier only checks for the callback when dealing with
> BPF_FUNC_timer_set_callback, which doesn't have a "flag" argument
> (though the validation of the callback has already been done while
> checking it first, so we are already too late to change the sleppable
> state of the callback)
>
> Right now, the only OK-ish version I have is declaring the kfunc as
> non-sleepable, but checking that we are in a different context than
> the IRQ of the initial event. This way, I am not crashing if this
> function is called from the initial IRQ, but will still crash if used
> outside of the hid context.
>
> This is not satisfactory, but I feel like it's going to be hard to
> teach the verifier that the callback function is sleepable in that
> case (maybe we could suffix the callback name, like we do for
> arguments, but this is not very clean either).

The callback is only set once when the timer is first setup; I *think*
it works to do the setup (bpf_timer_init() and bpf_timer_set_callback())
in the context you need (from a sleepable prog), but do the arming
(bpf_timer_start()) from a different program that is not itself sleepable?

-Toke


