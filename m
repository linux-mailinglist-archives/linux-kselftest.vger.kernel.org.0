Return-Path: <linux-kselftest+bounces-6391-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C647C87ECF7
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Mar 2024 17:07:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66680B20DC3
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Mar 2024 16:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 317FB52F8C;
	Mon, 18 Mar 2024 16:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cv4F5Bhy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A43EE52F86
	for <linux-kselftest@vger.kernel.org>; Mon, 18 Mar 2024 16:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710778037; cv=none; b=e52iZdw6g9T3vpYU2szDNvvDbjoNAFQJ3Wx862syTd5+qK2PKW1k/ULR4ETa4ntg7/68cawQzEskHmIzr6zy080EkqSzUDPBdfxsDly3tXdLRHc5fCy/MpX7KUw+zA7IzcdzUrPnIP2tKNkInmY1UW3JvGosrBjg7KpQYCbY3wU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710778037; c=relaxed/simple;
	bh=5PXmXrICF6GrxaIO5e63Q2oLbzQ0JOSVAmmok0aNVlk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SK5oOHW+sRN8JCaLy67U6lPfwoOsAFa3LMSJ51xEO7/trIwXSnit2CM8BlRN/MxAAf3zUTES25xNoQNekJGyFnwu0PgDaL0XPK9/idyY83OxgLUp6siGHk/uD9SYj8wqKoFpyIBPJ7XuaOrbuL6oZDfioG2P8zRbO5sB5k+xPBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sdf.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cv4F5Bhy; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sdf.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dbf216080f5so6892387276.1
        for <linux-kselftest@vger.kernel.org>; Mon, 18 Mar 2024 09:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710778034; x=1711382834; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=BRMBKkFLpx5UEPxApBmIvNsw7kmzwH3SFmSAn82Rk90=;
        b=cv4F5BhyCU09GcmXnKjRieiPGto6linO3+i0GGXAfvICcZ9WE92jF/w3g+l/iktX3Y
         yG/W4UK3R4/DyKJoCirdBjQTrXnh4UAghq+GQb+mnZAT1FqBlxt6qACmZ75/9bl7/SZN
         fRXevW3Tf6nUoTbYQOhflY6tmAJZ+SjMMgBxunTvLG5qNzpFVfQnVigTYNItY6Q+x4oN
         S54mRx5HCmy+yy95U1RioBZcwlFuEpgYleIf6oMAxBGHHJeYKiwjbdyWNP1C5TC2abyQ
         YBKLGq+BNIQoTUbuvFqZHWpdcKQSJ9/fxxAGuYun0ZcNUuNjCjxlicb3f7tVimgEjqR0
         Xgow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710778034; x=1711382834;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BRMBKkFLpx5UEPxApBmIvNsw7kmzwH3SFmSAn82Rk90=;
        b=MPAlGwXTPkEbXO2gG78gfnVvzk1Paq4FDfcta4qFtKEavwS8Ei5NTjLHDUU0/451k7
         ERM33aZ5apPXq1RmIqELUoINtAg2gFUWUbgZUzLmB1g2PALkgZ/fhog9r6H8/jxz0u9J
         kWGTjkcSkp1DmnI+mG8D+l+tOs7u/VlS/v+lkKD32kih9qpy3BQ34ORgap8wWgJstESc
         HlDUXdlpM/YWfEUyti7MP4T41+u6NgjiL7nughTKDNkM5EDz4/YkHiBrgC6VvJhk/XPJ
         jb1Qh7YekGCWNSYiDg7j06y4j7dwygMzdqPaMDO7OW559bWciDVbxDWkOhbHs1NiGTWK
         dUcw==
X-Forwarded-Encrypted: i=1; AJvYcCWgVIdRKTRhMlzM6EezWiG2fDBl8k3eHaPH/au0eUhf4pBERKVo2I0SlHynb/FkcN9TloKjp5lEoK3czhLgKJOavjy4n9BNm5AdJkn9cw/A
X-Gm-Message-State: AOJu0YxQyR4iUiwWQLycPXAXIIh6f3LjhJlI4nNDFtYNSMNQ8c8hwVMH
	aAYVG7V7HOfBapW+UAxD84w8xeG4oqGbIeWb5wyisiKF8/o4IN3yOH0LgxyOPrv17g==
X-Google-Smtp-Source: AGHT+IH5LNfmfR88tF1ClH5Z2TED8izBfSAYp4ik0sspQZmPUIP4mgDyRQxQVlVvUfOwjAEa/ngdslk=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a05:6902:1004:b0:dc7:5aad:8965 with SMTP id
 w4-20020a056902100400b00dc75aad8965mr3240384ybt.0.1710778034738; Mon, 18 Mar
 2024 09:07:14 -0700 (PDT)
Date: Mon, 18 Mar 2024 09:07:13 -0700
In-Reply-To: <20240316162241.628855-1-josef@netflix.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240316162241.628855-1-josef@netflix.com>
Message-ID: <ZfhmsVTIe-khu9uP@google.com>
Subject: Re: [PATCH V2 bpf-next 1/2] bpf: add bpf_task_get_cgroup kfunc
From: Stanislav Fomichev <sdf@google.com>
To: Jose Fernandez <josef@netflix.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Tycho Andersen <tycho@tycho.pizza>
Content-Type: text/plain; charset="utf-8"

On 03/16, Jose Fernandez wrote:
> This patch enhances the BPF helpers by adding a kfunc to retrieve the
> cgroup v2 of a task, addressing a previous limitation where only
> bpf_task_get_cgroup1 was available for cgroup v1. The new kfunc is
> particularly useful for scenarios where obtaining the cgroup ID of a
> task other than the "current" one is necessary, which the existing
> bpf_get_current_cgroup_id helper cannot accommodate. A specific use
> case at Netflix involved the sched_switch tracepoint, where we had to
> get the cgroup IDs of both the prev and next tasks.
> 
> The bpf_task_get_cgroup kfunc acquires and returns a reference to a
> task's default cgroup, ensuring thread-safe access by correctly
> implementing RCU read locking and unlocking. It leverages the existing
> cgroup.h helper, and cgroup_tryget to safely acquire a reference to it.
> 
> Signed-off-by: Jose Fernandez <josef@netflix.com>
> Reviewed-by: Tycho Andersen <tycho@tycho.pizza>

Acked-by: Stanislav Fomichev <sdf@google.com>

