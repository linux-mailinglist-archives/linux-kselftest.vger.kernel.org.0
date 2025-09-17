Return-Path: <linux-kselftest+bounces-41763-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48E69B81B68
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Sep 2025 22:03:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00E751896A31
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Sep 2025 20:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D485266B67;
	Wed, 17 Sep 2025 20:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fs8seP2s"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28B111DF996
	for <linux-kselftest@vger.kernel.org>; Wed, 17 Sep 2025 20:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758139383; cv=none; b=gaqtVlQ8XV+ogTVLDiISK24WcQDdvPFUuwrw9S03KZByCMzrBcyeNGwI0SecUW38b1eN3u2pvHIh2744AmVCFscC+3OUeDW7CY6yNYXqq4ohrWYlcxJhG3b2zQx0DpIa7UaqPh9DuvdvVd03IhdkacRhYIjr6VFPIcaJIPFffZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758139383; c=relaxed/simple;
	bh=8RwCiCEqgS/oR9Wj+EYfIJapVjRPjFagO+/mW2BIcW8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=itJ+tNRwPXVBkQXrH1XjlNvcixkx9oqwG46V1/EeRNoN3Fz1KZNtLavMlkIfLRkKCps7Sz8x4pqEAhpE/YbCePovoW8lEYePVNpy89iSL9CwzCd6pIbfQL9wjciCd62ZGIolsuTuVyQcBPWiwk64TKhnt16w2R2Xde4pYuPj0mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fs8seP2s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D736BC113CF
	for <linux-kselftest@vger.kernel.org>; Wed, 17 Sep 2025 20:03:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758139382;
	bh=8RwCiCEqgS/oR9Wj+EYfIJapVjRPjFagO+/mW2BIcW8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=fs8seP2smajGErdccqfjm/qBI73OZR07YbZ7EB5CfTXvZMxu23c8ilwPL4tCTJLuC
	 AtWRwbNmXywMbpsZuIAjESMWLIlai3YyiQfX56Cyz+2s8gY33vqzxFHrORzfaGfAjL
	 ++X+iZxkRMSv7rf6tcDj35RVmpICwlz4NVrst+qzAkVTZdiyI3mxpDi2Ag1jb254/8
	 ffLwxGZuGXBZm/LXVQ8LlEaxjwJeYHEHjU6BxkwuE76T76LaTu9HQ/IId13djfD2/M
	 jlESXMx6dho/5icGZhfmQXmm9HeM7kxvYkdW5d+jbD2HZwe3PWnrbrOYvtl9YvlOlW
	 StWJBitBXOXbw==
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-827923a97e9so20887685a.3
        for <linux-kselftest@vger.kernel.org>; Wed, 17 Sep 2025 13:03:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWJZLLlhnsysZ7m0Z3xc0cI0Tg93W41pivLLPoTATuWHzoIpV4Cqv7cskYNo0Fot7uAJqa2HIDk/p69GHvzwnQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIpidpSIwU0EfLHVZNJ1jTu2Ex+dCTsMWp5RcgAvq5uauqs46q
	INXy+z+/X1sZbwuvgxMQo7VzuubLJxggEspA0H8XoJ/GxBdrCmzuDx3qRsttygAqsGZuqVgAbgD
	3lAJThivEHT+OYymSIWVkFMDJaWnJLMc=
X-Google-Smtp-Source: AGHT+IE//43LvVRRL9P+bNBPabqBCP+0kbkAEemFxudHgIYmZJyboCRGVcIniMVsONVy0SAWFjDYnlR/dKKofxkrt60=
X-Received: by 2002:a05:620a:7081:b0:7fd:6709:f08d with SMTP id
 af79cd13be357-8311801ddcfmr445536185a.81.1758139381472; Wed, 17 Sep 2025
 13:03:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250917072242.674528-1-zhaofuyu@vivo.com>
In-Reply-To: <20250917072242.674528-1-zhaofuyu@vivo.com>
From: Song Liu <song@kernel.org>
Date: Wed, 17 Sep 2025 13:02:49 -0700
X-Gmail-Original-Message-ID: <CAPhsuW47BVGsszGU=27gKa1XOYLH+de1FgrHPVL4mftB2CvX9g@mail.gmail.com>
X-Gm-Features: AS18NWBxIdANPrX03bLZsJtpTPm-ZgoF9PRFYS0o8-H5DTmZDbcviXZne_YxRys
Message-ID: <CAPhsuW47BVGsszGU=27gKa1XOYLH+de1FgrHPVL4mftB2CvX9g@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next v1 0/3] bpf: Add BPF program type for
 overriding tracepoint probes
To: Fuyu Zhao <zhaofuyu@vivo.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, yonghong.song@linux.dev, haoluo@google.com, 
	jolsa@kernel.org, eddyz87@gmail.com, kpsingh@kernel.org, sdf@fomichev.me, 
	rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	shuah@kernel.org, willemb@google.com, kerneljasonxing@gmail.com, 
	paul.chaignon@gmail.com, chen.dylane@linux.dev, memxor@gmail.com, 
	martin.kelly@crowdstrike.com, ameryhung@gmail.com, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	yikai.lin@vivo.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 17, 2025 at 12:23=E2=80=AFAM Fuyu Zhao <zhaofuyu@vivo.com> wrot=
e:
>
> Hi everyone,
>
> This patchset introduces a new BPF program type that allows overriding
> a tracepoint probe function registered via register_trace_*.
>
> Motivation
> ----------
> Tracepoint probe functions registered via register_trace_* in the kernel
> cannot be dynamically modified, changing a probe function requires recomp=
iling
> the kernel and rebooting. Nor can BPF programs change an existing
> probe function.
>
> Overiding tracepoint supports a way to apply patches into kernel quickly
> (such as applying security ones), through predefined static tracepoints,
> without waiting for upstream integration.

IIUC, this work solves the same problem as raw tracepoint (raw_tp) or raw
tracepoint with btf (tp_btf).

Did I miss something?

Thanks,
Song

