Return-Path: <linux-kselftest+bounces-22765-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01BEB9E2A71
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Dec 2024 19:10:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F4194B2A63E
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Dec 2024 17:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 878B41FA240;
	Tue,  3 Dec 2024 17:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zSahc4ZK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0862E1F8AD2
	for <linux-kselftest@vger.kernel.org>; Tue,  3 Dec 2024 17:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733246661; cv=none; b=Hdjx314xUMo7KtIGwjWjyeXlIaG3TmmX/gvBFHdc0XILHF4+xOAJVGfFJMacxeAd62I9tamEl54CR125yES3dXbc68UuknZy9xXsoekTuB1Y64LhD8Owwc2ToDatRps+IItehr54grpjHlxuJm7GIBHuIYacTM5PEiNrNpBP72w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733246661; c=relaxed/simple;
	bh=uHhOCluAWImlIGsIXn1ThfxKnnC7/xPE7QIUhoZLgQk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sJIgGnxZ//jJHjXJgIDg3CLI9EJ1icC8DYYNIX2/qRUSO5VveE7c4BJE6Xkd8lvBIWypGMvVCQg958gF4ac44wQmyA3k+akxp+R2NVeuL0oG4J8VychuabsKfS3tAQzqsTSAJGe01kCa0hwgkYxJsaCPXAewLrzem5wiMhDJebA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zSahc4ZK; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-515c79715bbso271804e0c.2
        for <linux-kselftest@vger.kernel.org>; Tue, 03 Dec 2024 09:24:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733246659; x=1733851459; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uHhOCluAWImlIGsIXn1ThfxKnnC7/xPE7QIUhoZLgQk=;
        b=zSahc4ZKmWqVMYt4+SUPdW82xrAOdrsaiVA07OWXcieX9HbYS4pJQdfQ3lLuVjqErp
         8IJFDNRnfo8zcIeASMsDzj/n8GVa/lCSkWDIsiynqXZcU78GjRpTTFVy+SFiR+iKbjtH
         XfGtD0wkMlVM1PELvkXGpnUXarepCXyIYL/cg25VwKjkv28ALx4hqWO2wp67k+1M1Hx/
         gHnq5zTUr0ucIt0ajYBUxstdb/zXg+sF0bn1Zlzmo7Jr1PIbZjW75S1dbiEPL9FLN+d3
         +jRPc9NPOrUQ81JIoOGcp2NH9GuKG4BWAEWL+NXnjCjTMGmT75Aw5CHC8M/qhoqom5gq
         18ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733246659; x=1733851459;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uHhOCluAWImlIGsIXn1ThfxKnnC7/xPE7QIUhoZLgQk=;
        b=k5RUdhEFR4AsqJQY8OQIaVpGxUIpYAMkzeSkqdQ1r73YUS6P0+1VMUh8mBaEhcH+AK
         3gU936IwcRXdDpJ9Sljh6jKy1NZy84iKpcEaeK22dvRJ9vxO5VUF0W/oMB4DzM1hJ3M2
         cAintRvN6gKPyPeoSHTp6M6hwFrd5Z250V2XnjrJUj3xg7n19d/yzZcNjji0DtV1zZwC
         /SgP2rAvLR8vwbwrWRtIuSWDfxGwY4GWfEJqD0sZKUIeY6AZ6pYhNO6hikbPihFunYHa
         hv5LyusyifkSMxBad/kAz5YpJB1hbkHIv/lvTUkz/PocszENNxDHzIyVLV4lZlOoLuI6
         9sCA==
X-Forwarded-Encrypted: i=1; AJvYcCX25qkUy6rNp/GwBHmmHm2NuJF8imVcYl7v3qyrf6eSVydXCmnIwHlCnNbNM72853Y81q8tCMKa+7rmTmjMa0M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdM8jzraniRNeqt9TIk3kd2Bj6Wetw+pSAUphs8dg/D9RguWu+
	CdjScWtQPl8bLsyJq7l2hS2Cua9JWBE6wgSi0rR11jPRbaCRdsGL+zd/n6GvCkEejf3At3qRxAJ
	OmkwQ4q1KeF9hA4ELNNO5YgOQFIOwhHTnDDH9
X-Gm-Gg: ASbGncuHSbUXlB3ZqP4+vNxFXengpC7MqYmBKX4y1moHBkHXyfQiUIdX9lCXlVxmZ7Q
	pVwXrkdsGsOEBQBd4yoGHutEXMd9Z1FGY
X-Google-Smtp-Source: AGHT+IHYXYoqonmkZPTMlbc42ImybA+UEjnRdgYrQbkXonBRpfG03UbuA+XwLsr71xscM4WaS2Sc80eQ5GXkKX6c0HE=
X-Received: by 2002:a05:6122:6593:b0:515:3bfb:d422 with SMTP id
 71dfb90a1353d-515bf5c0701mr4617322e0c.12.1733246658855; Tue, 03 Dec 2024
 09:24:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241202204530.1143448-1-leogrande@google.com> <Z05NhvyagBbHs8Gq@mini-arch>
In-Reply-To: <Z05NhvyagBbHs8Gq@mini-arch>
From: Marco Leogrande <leogrande@google.com>
Date: Tue, 3 Dec 2024 09:23:51 -0800
Message-ID: <CAD1qLz0UwaFsk3ZnQ9e5RG1XvJ2i=7FJhtf_9AB6KVZ1fbEh3w@mail.gmail.com>
Subject: Re: [PATCH bpf-next] tools/testing/selftests/bpf/test_tc_tunnel.sh:
 Fix wait for server bind
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Mykola Lysenko <mykolal@fb.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	"Alessandro Carminati (Red Hat)" <alessandro.carminati@gmail.com>, willemb@google.com, zhuyifei@google.com, 
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 2, 2024 at 4:15=E2=80=AFPM Stanislav Fomichev <stfomichev@gmail=
.com> wrote:
> Do you see this failing in your CI or in the BPF CI?

I see this failing in our internal CI, in around 1% to 2% of the CI runs.

> It seems ok
> to add wait_for_port here, but the likelihood of the issue seems
> minuscule. There is a bunch of ip/tc/etc calls between this
> server_listen and the next client_connect (and I'd be surprised to hear
> that netcat is still not listening by the time we reach next
> client_connect).

I'm surprised as well, and I've not found a good correlation with the
root cause of the delayed server start, besides generic "slowness".

You also make a good point - by calling wait_for_port this early we
"waste" the opportunity to run the other ip commands in parallel in
the meantime.
I had considered moving this wait down, just before the next
client_connect, but I concluded it might be less readable since it
would be so distant from the server_listen it pairs with. But I can
make that change if it seems better.

