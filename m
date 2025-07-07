Return-Path: <linux-kselftest+bounces-36655-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F295EAFA987
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Jul 2025 04:14:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BFDC3B8202
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Jul 2025 02:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20C9A1A239D;
	Mon,  7 Jul 2025 02:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VOtskHLm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 612A2635;
	Mon,  7 Jul 2025 02:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751854469; cv=none; b=qe8BxHDb1kT55Py/ZtbyGr93rXollSEdem8phaPM6FnIE0/+TTnOH1Ib5aSmIbun6qzHSWw6CwTm+QjGVxGTHcaLMnSnCYt1WOi7g4yNNagLzTeFr8IHkLBBnLBhKZG7b1py9/jDtnCHRzMlYJJk9fOcEqbbXrY/XWnM9h26uRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751854469; c=relaxed/simple;
	bh=OJoh95gbE4LdK3oGqwH/Vcru0MsY8JuqxIR9GBqp780=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YUougx6HPpJ1ZTfnc8DiTq8rKc3Mhw8BDESTJP5bFE+xpwU0biAqYkrM73LNpLl6+jhai2szqFCPJNdm4vGp9CSTE5bkketi30in8lPlWX7VgYHfIXkwOO3H5jGHz4jwUsDTKCXf80ZnKPmq2gbYvMpz8vM7++P9mKDlWYln37c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VOtskHLm; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-311a6236effso1837761a91.2;
        Sun, 06 Jul 2025 19:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751854467; x=1752459267; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OJoh95gbE4LdK3oGqwH/Vcru0MsY8JuqxIR9GBqp780=;
        b=VOtskHLmWVdt4VsNzWoMNC/E0+EyKzrfR/vR4cC8DGJd/8+3kc1O/9DjRDCE9DPL5j
         kIzg0gcchfqG69Zg3OhQhnLqwIfHLrsh24NIBezxyknej0FoLjf9fuoGQvixVfHlL6DR
         jmti/y5rIf2Fy5Gi3jwPbPKHHawv8MTz4he8MB3gLQMLzi5wT0ghb9sDIrHiW3rSIqHI
         Klc1n8Jk0J6+tFO+fzb5kXFnIuT5f95meZO/REobDQgNZ5N/8NVtphAXlDk54HLFrlw3
         OXki5Fi+z1n5a7hpnAa0VymRmZiQDtcVeKIiA3ej7Si/hQc/F0nQkk0pgB6PfxxttVPH
         I1Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751854467; x=1752459267;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OJoh95gbE4LdK3oGqwH/Vcru0MsY8JuqxIR9GBqp780=;
        b=dgNO3Hk/Rx3mhFegGJGmMTcy2yOGibZmGELyaVK8TWAxSiIvfnVdjvHfd4dbKJ55MF
         5ReSoyurARwsvNZLdiB2BQZbQvq2WjCtIK/JplGO4W1xWclqP2yRr7JFUy94OfzUhpDE
         IP6Y1eWD8WRBTvXfIyTVIAn8Avp1vHIMG4SAYhWYmQsDWod1m6G+pAJIIEVE67LvnsJb
         JnNtEYjvFL5HvWpJWQV5Q/00j5LX8iqXoiu2Km0No1vXYu7Cpau655jP2MEEvpMGr+RI
         vX4EiRjBZ80jY0iG5HCCFXi1/sd++cB1BpUf1U67cSXq5QIHqJmqF8SCEsbGvDQER87V
         OH0w==
X-Forwarded-Encrypted: i=1; AJvYcCWx73Hs4jb5I5N+ZUvl768eqQphDshJLC01/kGsO7m8QNtaTDqOt3JLa244kPTthyEbxEU=@vger.kernel.org, AJvYcCXKpO2mNFGcbD+C+0m+neaChk1LAacw4EDxcCK2pQI8CW8jsYJLeTY3Et0d/IqFUtBBEZXwOaHFblPxbVR9rtkr@vger.kernel.org, AJvYcCXwsFc0bpHo/4NsfYbUyVtuEoS1p0FN249/Cg8+9ONyCdeIbfy0YblEd8ewVcqxFl7uKuLz9ybSvTv6yuPm@vger.kernel.org
X-Gm-Message-State: AOJu0YzXOmm1plceICs+dYe6nOUyKFrtIB3lpg83bE2wdnWVZYAHy6Oj
	+q/YGsOPIEgGy0sDvZ1EqubY573+i/ZyZjhDFLQoVxZQq248oINIuyt9
X-Gm-Gg: ASbGncvfKLOwk7C/7t6qLQtzfeBOfLZ4Avgs+zKpGOg178amKu4bg3I06KQPRPn5mrU
	gNAvgO8V5zW2bhNc6sDDX8cEFP9MEfYX4O0P3yau/5PHalqeBGMtXvo1hV7LcrCG7glMrl/fYdO
	YjaBCnwXSyeCGgG57mMBpTCc3ewu1z1XQvk5hQvcNWVcwPnu2T2JZaWf+5w0cgJnk4ZPjvYebD2
	j5v+Hr0ZotuuMj7TcCweTmEucuqEbZgB4sKw9f/wVidjSd8jKfv2YvzW5zJG2Wi41C84EMljlM6
	qbX3bGIqnlEZmBBS7998LP6k+dqKMyegBqvgJlQ+wySJzpmmxhvvuUP9Jw==
X-Google-Smtp-Source: AGHT+IFbRq1ASueuRtnzGQgbE+s+nwFqcOJFs6lnbWyRdkWwFRPAmHCLOCUE3sYOyOgLbFuWRpcMRg==
X-Received: by 2002:a17:90b:2d0e:b0:314:2892:b1e0 with SMTP id 98e67ed59e1d1-31aac5416a4mr11373751a91.34.1751854466565;
        Sun, 06 Jul 2025 19:14:26 -0700 (PDT)
Received: from [192.168.0.56] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31a9cc67367sm10742360a91.18.2025.07.06.19.14.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Jul 2025 19:14:25 -0700 (PDT)
Message-ID: <a0b112301f51e4ea2ff31c0e9c6e28b2b6535db2.camel@gmail.com>
Subject: Re: [PATCH bpf-next v3 1/2] bpf: Fix aux usage after do_check_insn()
From: Eduard Zingerman <eddyz87@gmail.com>
To: Luis Gerhorst <luis.gerhorst@fau.de>, Alexei Starovoitov
 <ast@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,  Song Liu
 <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, John Fastabend	
 <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev	 <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>,  Mykola Lysenko	 <mykolal@fb.com>, Shuah Khan
 <shuah@kernel.org>, Kumar Kartikeya Dwivedi	 <memxor@gmail.com>, Peilin Ye
 <yepeilin@google.com>, Saket Kumar Bhaskar	 <skb99@linux.ibm.com>, Viktor
 Malik <vmalik@redhat.com>, Ihor Solodrai	 <isolodrai@meta.com>, Daniel Xu
 <dxu@dxuuu.xyz>, bpf@vger.kernel.org, 	linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, Paul Chaignon	 <paul.chaignon@gmail.com>
Cc: syzbot+dc27c5fb8388e38d2d37@syzkaller.appspotmail.com
Date: Sun, 06 Jul 2025 19:14:22 -0700
In-Reply-To: <20250705190908.1756862-2-luis.gerhorst@fau.de>
References: <20250705190908.1756862-1-luis.gerhorst@fau.de>
	 <20250705190908.1756862-2-luis.gerhorst@fau.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2025-07-05 at 21:09 +0200, Luis Gerhorst wrote:
> We must terminate the speculative analysis if the just-analyzed insn had
> nospec_result set. Using cur_aux() here is wrong because insn_idx might
> have been incremented by do_check_insn(). Therefore, introduce and use
> insn_aux variable.
>=20
> Also change cur_aux(env)->nospec in case do_check_insn() ever manages to
> increment insn_idx but still fail.
>=20
> Change the warning to check the insn class (which prevents it from
> triggering for ldimm64, for which nospec_result would not be
> problematic) and use verifier_bug_if().
>=20
> In line with Eduard's suggestion, do not introduce prev_aux() because
> that requires one to understand that after do_check_insn() call what was
> current became previous. This would at-least require a comment.
>=20
> Fixes: d6f1c85f2253 ("bpf: Fall back to nospec for Spectre v1")
> Reported-by: Paul Chaignon <paul.chaignon@gmail.com>
> Reported-by: Eduard Zingerman <eddyz87@gmail.com>
> Reported-by: syzbot+dc27c5fb8388e38d2d37@syzkaller.appspotmail.com
> Link: https://lore.kernel.org/bpf/685b3c1b.050a0220.2303ee.0010.GAE@googl=
e.com/
> Link: https://lore.kernel.org/bpf/4266fd5de04092aa4971cbef14f1b4b96961f43=
2.camel@gmail.com/
> Suggested-by: Eduard Zingerman <eddyz87@gmail.com>
> Signed-off-by: Luis Gerhorst <luis.gerhorst@fau.de>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

