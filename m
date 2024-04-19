Return-Path: <linux-kselftest+bounces-8441-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 125148AB1EF
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Apr 2024 17:34:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E6A2B2126B
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Apr 2024 15:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69F7A12FB18;
	Fri, 19 Apr 2024 15:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O0kEpJf6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2B8682D66;
	Fri, 19 Apr 2024 15:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713540879; cv=none; b=Elup8KDTH7c964ikPma7CCPp5ZXYwNTGOgEA6vsotn+vJ5bf1/F5PqXYNrIXHOwN83vNZlZv3GhuVwIEi8kBV6wZXkxGeqrjtA9w1GJmrf1hUnvFRCP0JKpJx+V2EX85D640d0MhvKZ5nqY8ZOsHgbYaq5nk8xSq3yWmfjQTJek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713540879; c=relaxed/simple;
	bh=Fy3NveURe5w5uBQe770wnBgJqw9cuLqS7f+LkC2Xup4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C8mJpo8VvheqVk7Y+nb/tDiqVu6nW2mx1XJUhLsckgvuFe4y2nIlGh4Xwc6B699jaJ+c2Lr0lye2moPGWH77csi49SboaiDwpbWWbG7fsSkoUH52WRvgcx+7l5ChAkC9grC4dBDhWQZgWM+1Dpp9F5EmrdWIoATj6PcLH+Cpoto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O0kEpJf6; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a44f2d894b7so212008166b.1;
        Fri, 19 Apr 2024 08:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713540876; x=1714145676; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fy3NveURe5w5uBQe770wnBgJqw9cuLqS7f+LkC2Xup4=;
        b=O0kEpJf6g/at7LVZllH+K4v6tVGvh4UGtE3kZbQ+AxzJxBEmZ7PT3rRhDump4BUu4/
         ZRxq556Z0Vr7BTjxV9WmP3pJEM0Ww/AdMYC+ptXDO1Yjuvpc0WqeKCfc8xtLj7UcWL19
         +Ht+pHEAJqq8GEe33brM9tmA7kZAKWhyQooLdPb4lAA9uwweDLFZhUvae0xyigoEu4yb
         uft1z68hz7aHyEkQksYQNjzvrt5xsRLY+odNT6hXxqFh9dHOUY2a790ZZ8wv5hccX17j
         GT3/jYwrWBdRNFGOOY4RPkO1v5NCpICeFJY6dfB4Pb63UMl9gCl5mfF49TQ88Ka3+w1+
         Nm5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713540876; x=1714145676;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fy3NveURe5w5uBQe770wnBgJqw9cuLqS7f+LkC2Xup4=;
        b=sY3tp+SNpvpdsWkJvE6fyS+BZ2v/o1yPrQUgaIj7lSmHr0rxrc4SJNxSwex4ll3JQL
         koONjeLTV7zBbMD6eesDVVS68xjs+wzwuBJB39dfbibFjpipn355KLwGkUAi2blT9pEq
         ONsqBKq6nOfBf6983oeABX2cEspogGv6fQKn4lKE/nbjVs+0DxmzSnRZkfm54ir7QgmK
         3r653V6JRlPKI5ldHOyJ2egYCv833lc00JpXlWRwuuqZaQzOOfrgXXA6y/l65WTkpMyl
         Q7Du9T/yyjgHfnlTiHtTI3CmLn8LQOe/v/DqR7EFm4mncIMstDue8kFHvNaK19leuwJk
         to6w==
X-Forwarded-Encrypted: i=1; AJvYcCXhrtNLEI6XHjHFEJ4Hu7zg7YFi8ObElXXGdV9+Di7oi1/FTCUUDW6OjnWI8BqxGPKiyde1qZ9RQvIQlB9JiYJLk/bPQ8AfWbI0V9Bkun4xZtRk/rIkfbz7X32r5AgePt4c6SeJrltHXn76AP4s/p674WmdDLP5y2Y0oBKvmSPfN7OJ
X-Gm-Message-State: AOJu0YwZGPEpTzGs/eDTs+UnF9gPhVyi4orc2WpTKTPGn121FEPBzNT8
	kv8n0Dniu9sEBrPYiQW1m7rwP5aVh9IvRGe0w1pMRZI4mvF17I2M7or0saUgdGQ8b17SYg2vOeq
	ZHTAAJwc83A/mXnXRBBP2W4vL5NI=
X-Google-Smtp-Source: AGHT+IFCbVlKQPPmkqkmKImix65doOKuBzMyYvGPcOjPLaTao7TxtnWGuMjYGvzK7fLSO03J/NfMLZPbNCgYn1BMPO8=
X-Received: by 2002:a17:906:b31a:b0:a55:4378:9891 with SMTP id
 n26-20020a170906b31a00b00a5543789891mr1859696ejz.24.1713540876037; Fri, 19
 Apr 2024 08:34:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240416-bpf_wq-v1-0-c9e66092f842@kernel.org> <20240416-bpf_wq-v1-11-c9e66092f842@kernel.org>
 <f7awluzevpzqhqo5a65dxlfoo3dhkvbpntb4a5uueq2v7gjj7b@ddoyfpeymg3u> <tqj7biswz4ktars2mjrog35sijfgnm2nmvqrzbldphksbtj4kj@qd3digliqsjm>
In-Reply-To: <tqj7biswz4ktars2mjrog35sijfgnm2nmvqrzbldphksbtj4kj@qd3digliqsjm>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 19 Apr 2024 08:34:24 -0700
Message-ID: <CAADnVQKpC_11C3LNia6uGD5yAe5QeViYHD6TEHKBtEi3L6awLg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 11/18] bpf: wq: add bpf_wq_init
To: Benjamin Tissoires <bentiss@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 19, 2024 at 8:12=E2=80=AFAM Benjamin Tissoires <bentiss@kernel.=
org> wrote:
>
>
> It's something I added while adding the tests. And some tests were passin=
g
> in case I was having a non sleepable callback. But if we have
> bpf_rcu_read_lock(), we are all fine and can reduce the complexity.

Not quite following what was the issue.
Since the verifier is unconditionally verifying such callback as sleepable
the callback won't be able to access rcu pointers without doing
explicit bpf_rcu_read_lock() first (and few other code patterns
might be rejected), but that's a good thing.
Maybe next to set_cb kfunc add a comment that wq callbacks are sleepable.
I think bpf prog writers are often with kernel background,
so it will be their natural assumption that cb is sleepable.

