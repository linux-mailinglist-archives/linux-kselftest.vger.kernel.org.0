Return-Path: <linux-kselftest+bounces-47085-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E075DCA5880
	for <lists+linux-kselftest@lfdr.de>; Thu, 04 Dec 2025 22:42:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AEDD830AC99E
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Dec 2025 21:41:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CFDE328258;
	Thu,  4 Dec 2025 21:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iTbdRvc/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC36532720C
	for <linux-kselftest@vger.kernel.org>; Thu,  4 Dec 2025 21:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764884512; cv=none; b=Ztsw8MjsYGgwKewY+S+ESz5ondfOpjdSUqio5vz7cgjLVyAyn8KPfdEjSVUwoi5dhDZbXmkVK/pfRRMLpMaAtPU1tFCm2yEouHbt1oUPQBjkMhTtVwPKqPrxpZeQZNnozfkNPzPEmjVunfGZ/otahY8ZQriqnzYzc5D9LheIo34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764884512; c=relaxed/simple;
	bh=/QrZLSAfGYWyne6W/7vTkqoE2kr+Wpspna1gd9MCcdk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kCccHbGigfNivqAHHVHnDzljvTnbzlv4PvmW5CEQGM1SelybgkZxhuVNg79/IKw5epQoRxsQyF+oSQnysdAe2ZWsZ/E9nyQEnpsafvqusLQkT8bS5ER/bXQUl811uXMFUihlxJq8hfcjXOOCpHzWvhj+DnZWS1bYIIy4NKBSukI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iTbdRvc/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E8B2C19422
	for <linux-kselftest@vger.kernel.org>; Thu,  4 Dec 2025 21:41:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764884512;
	bh=/QrZLSAfGYWyne6W/7vTkqoE2kr+Wpspna1gd9MCcdk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=iTbdRvc/cJT6k+jAS1BGvX3Va0l2xZexmseYY29wYc3iA1JwjW9hrNGCVX5ySeb6D
	 WRtWp58Z6AxQ2j/dH/69DlfA7//W7DRb5Kg/RcDLJUYRJSj28aU4PT8I41HBspvKCx
	 DilV//p5tO5sadJD2OO18CKOD6aRuO51Hc3U4/U+6p6rjRFNTqMCU4yQCZDWooSYwv
	 u+L2LtMBKFzbbJgPLBEq+vIYALvKME1svCb1m0H+CHBwv7v1/MVYNXLP0Ccs/IMe01
	 H35/KOy+xw7o0260w5nPEeiiV9mPIa8HOTW6Vw2y1S0YLOEC4Bf45gaD/Xm3C6xI6s
	 4M/N9b7NyWK8g==
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-880503ab181so15310616d6.2
        for <linux-kselftest@vger.kernel.org>; Thu, 04 Dec 2025 13:41:52 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUZPw7coCETv7XfhqIE9KvZvCbbHtpbmUWT3lMS+E8UUOR5wZbg8FUr57vNfDWUwjhpdWyV96A2SmWGshq9ml8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRYCGI7oqT/WHiUSbSJgBJFD1ujkYNgNqvQKGLVhaRRLfFVq9M
	NvrYYi4yzXPbbb6cXlSUncrvbf/YHM4f80DtHe95RGiagWlGPOjK9GA/rfccrTnvid/GZ3LIQsi
	l6aUZcOT/oZzRlLDq2u7YVw6YlVSOfIE=
X-Google-Smtp-Source: AGHT+IE3nGx3czh5EurAK81pcc0J/Tbx/Ct8OP0As9YwgQkp/TrCSORZBNFtGCBDPpl8ekVfi5rdexTv1y5JopcyZ1U=
X-Received: by 2002:a05:620a:4016:b0:8b2:e5da:d316 with SMTP id
 af79cd13be357-8b5e7452418mr1102586885a.87.1764884511579; Thu, 04 Dec 2025
 13:41:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPhsuW6hmKjJF5gYvp=9Jue2N6oW8-Mj-LdFbGnQVwW1bTB=qg@mail.gmail.com>
 <20251204043424.7512-1-electronlsr@gmail.com>
In-Reply-To: <20251204043424.7512-1-electronlsr@gmail.com>
From: Song Liu <song@kernel.org>
Date: Thu, 4 Dec 2025 13:41:39 -0800
X-Gmail-Original-Message-ID: <CAPhsuW75em0udAv2kuL04wPfDD2AKeSCkcsHjfPSh6nuTjNqtw@mail.gmail.com>
X-Gm-Features: AWmQ_bm-31Dq2P5DA_rZrXN-sRpJgLoHODZOKBk2Ms6J77ek6UmcwUcpYGfI0J0
Message-ID: <CAPhsuW75em0udAv2kuL04wPfDD2AKeSCkcsHjfPSh6nuTjNqtw@mail.gmail.com>
Subject: Re: [PATCH bpf v3 2/2] selftests/bpf: fix and consolidate d_path LSM
 regression test
To: Shuran Liu <electronlsr@gmail.com>
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, dxu@dxuuu.xyz, eddyz87@gmail.com, ftyg@live.com, 
	gplhust955@gmail.com, haoluo@google.com, haoran.ni.cs@gmail.com, 
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, martin.lau@linux.dev, 
	mathieu.desnoyers@efficios.com, mattbobrowski@google.com, mhiramat@kernel.org, 
	rostedt@goodmis.org, sdf@fomichev.me, shuah@kernel.org, 
	yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 3, 2025 at 8:34=E2=80=AFPM Shuran Liu <electronlsr@gmail.com> w=
rote:
>
> Hi Song,
>
> Thanks for the review.
>
> > I don't get why we add this selftest here. It doesn't appear to be rela=
ted to
> > patch 1/2.
>
> The regression that patch 1/2 fixes was originally hit by an LSM program
> calling bpf_d_path() from the bprm_check_security hook. The new subtest i=
s a
> minimal reproducer for that scenario: without patch 1/2 the string compar=
ison
> never matches due to verifier's faulty optimization, and with patch 1/2 i=
t
> behaves correctly.

I somehow didn't reproduce this in my local tests. Thanks for the explanati=
on.

Song

