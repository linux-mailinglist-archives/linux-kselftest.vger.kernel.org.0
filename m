Return-Path: <linux-kselftest+bounces-47311-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D8A69CB10C9
	for <lists+linux-kselftest@lfdr.de>; Tue, 09 Dec 2025 21:48:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A38863019D1F
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Dec 2025 20:48:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79BBE27F73A;
	Tue,  9 Dec 2025 20:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="cP5pvvnx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F6F2242D79
	for <linux-kselftest@vger.kernel.org>; Tue,  9 Dec 2025 20:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765313315; cv=none; b=DfSZimd/AawZqZhmTkGPzTTHlCGNQ+4W5ClLDGahHctzAjkJBX0avMcoMd5Z0xocLlbVlfqrrEPQrexlUfQuWWbM1XX2HWCSUhVWfcpzJDd9MO1A3WbZIvrAoFjOMmMtKw5UFlgNmBHTq7iC1oWEOqzGFCQvN88/dvRCM7HCujU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765313315; c=relaxed/simple;
	bh=rd2xZtg1TUqhPE9MjX+asDiZUF22CLDQ+9AXCBYKRVA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=be93wyuEQdbRq3tFCFEpSfwvLe/iwTI98bT+xwosGMxZxOUrXLUH/WNXVRn3+JYainRXQR8iVU7dFgIXUaVApENCRrhVFVpKeTyyYqJJ4kCPqaTr0k4S14VuEeGiL8E8eQ19AdHG2rGpiO+hUJlV2v2qOzOvv2kAEjOw1O5cCUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=cP5pvvnx; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b79d0a0537bso789872066b.2
        for <linux-kselftest@vger.kernel.org>; Tue, 09 Dec 2025 12:48:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1765313311; x=1765918111; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8qFu6Gyyu/IjR2ufdMGg+lZtY71e20af3aIOCWzwQgQ=;
        b=cP5pvvnxh1q5bwTzTSd7kOvrgecRY1pEnfuy4yZQsye8pPaXrvTlEYKcMiy5+ex0sy
         OEMhwi2+kX1vGlf9lFk7f6EJAvJ/bYNONvfI/wmSiWPyqIKwI7Fil36cXt0C7Pas34EO
         EukXCPgPrENwPtfnkQCtAjUtckQNY6vzjx/yc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765313311; x=1765918111;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8qFu6Gyyu/IjR2ufdMGg+lZtY71e20af3aIOCWzwQgQ=;
        b=WzzXdU72BEdRuuocqwm4PBTgHDBfVjJfMBd70FHabxnNjm2/jjCse/UdcayZY4Zszv
         5EGWvnXANPeHJR7oOdOoYgb9Q1sepMPqWhX0YiMNA9d7R+8a3ijmxwZcmhEZW4EGQYW8
         8j+lKsv3y2yDsZK8W6Rga1FgVrtfVwIibVQUBItuydGmonwEKfrrLfXf3tkQxKMKF9GQ
         EvWELS4WgaI4DIQS5+UETD/BSfkCDPSanQHN4hCCSWSntWKYRJwdUfYaYF0XZccl2ooY
         /xLbA24mrMbzPr3cNgA+BelpRv8AWFu7h889AD2ziCpbPpuJQQ7OSzka6q/bWoKw2qRn
         0+3A==
X-Forwarded-Encrypted: i=1; AJvYcCW8bT+Z/GyeGv1YBXsiwYC5/lJqwx6/XZeozV38NgFOdhMFS+gDCYurqgUrQ9JQ1FOBl/2FpxNI0OQdU/+mXFw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0wGccd9CYLxwioiEzO4cGyv4AIrPwOHGUQb+JP8iJD6Xy0/Fg
	Su00C/yttXKJkrXPmbOscZhePYpQogUpNdz/gk8RVDPwXsyw+FZtVjaHvypwHgVMLy2jazYpSc8
	RRRZ7MKLKeg==
X-Gm-Gg: ASbGncv/h4OXWh1cDD6aINBYFgPpSRh1qZgjPnUsbQSHEOQrJmVWr8gsj+g5AXGnvHe
	qCMw6M/Ox6qOQlnO15sMLHoMp2GITuNrk1xVlt51RF5n+thCC89/ClZSJxFBDGKHBzQQpvycCLZ
	ZgPmJljX8/txoyuBZUm4OkyiiXZM2j6SGm9YkPXeTpQjTTXM7z3fKqSaVOLYR07/S41CuDTxRLy
	3Asv2WCqS1Hka/b21shfQ32kvXvRk7DaH0fDCkk7VdZeiA7toeB/ix21dRfJy2PJHqxWyb/vods
	TSWJbEC6HDNJ+CxLeddZwqk1icwbEP1Hi8T05wYNkSle7k0g4N++cjCagFk3KiTSF7eyAAW8RnF
	QdsDuXxZdbVqCCmvAITFuJil5eYxRkizYzEIKsT1NcflCd5IsBe+kyZjMVP/pWJL/rsb6bCpMSt
	dS8u7g2C94YiIsdHT/v5ACpEl1rPgj5J80PAD6M1CdXKXtfeZTNwwVxiWEBC2e
X-Google-Smtp-Source: AGHT+IFXQdVUPD6RQ003S1jN9j3nvF8zmHOAjnc7Fdi1ovNCYEeEk1T123NaVisjYA5walvw+7v3eQ==
X-Received: by 2002:a17:906:2347:b0:b7a:5bfd:7fe4 with SMTP id a640c23a62f3a-b7a5bfd8200mr484426966b.18.1765313311566;
        Tue, 09 Dec 2025 12:48:31 -0800 (PST)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com. [209.85.218.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b79f4457a42sm1503145466b.14.2025.12.09.12.48.31
        for <linux-kselftest@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Dec 2025 12:48:31 -0800 (PST)
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b76b5afdf04so981731266b.1
        for <linux-kselftest@vger.kernel.org>; Tue, 09 Dec 2025 12:48:31 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWHoqeHNq8C/EITrvdeEM6EboFbqMqXBRbgtxgx/74HMPYu2+XFDtcEkTaEGfsK80fUC4W6UhSxu7kd0OHbxNU=@vger.kernel.org
X-Received: by 2002:a05:6402:27d2:b0:640:74f5:d9f6 with SMTP id
 4fb4d7f45d1cf-6496db38dccmr139683a12.25.1765312868177; Tue, 09 Dec 2025
 12:41:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251208235528.3670800-1-hpa@zytor.com> <20251209002519.GT1712166@ZenIV>
 <43CDF85F-800F-449C-8CA6-F35BEC88E18E@zytor.com> <20251209032206.GU1712166@ZenIV>
 <87F4003B-5011-49EF-A807-CEA094EA0DAC@zytor.com> <20251209090707.GV1712166@ZenIV>
In-Reply-To: <20251209090707.GV1712166@ZenIV>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 10 Dec 2025 05:40:51 +0900
X-Gmail-Original-Message-ID: <CAHk-=wi=2errb29CgwA4eSaLCEojo2Jq1d3ptDhxANfcKPH9xw@mail.gmail.com>
X-Gm-Features: AQt7F2qPCXJihSB0EifxcMqIJwZJZTW_3j7hMQ2OwASD92TgZWMxviusY-ovH6E
Message-ID: <CAHk-=wi=2errb29CgwA4eSaLCEojo2Jq1d3ptDhxANfcKPH9xw@mail.gmail.com>
Subject: Re: [GIT PULL] __auto_type conversion for v6.19-rc1
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: "H. Peter Anvin" <hpa@zytor.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Alexey Dobriyan <adobriyan@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Arnd Bergmann <arnd@kernel.org>, Borislav Petkov <bp@alien8.de>, Dan Williams <dan.j.williams@intel.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, Dave Hansen <dave.hansen@linux.intel.com>, 
	David Laight <David.Laight@aculab.com>, David Lechner <dlechner@baylibre.com>, 
	Dinh Nguyen <dinguyen@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Gatlin Newhouse <gatlin.newhouse@gmail.com>, Hao Luo <haoluo@google.com>, 
	Ingo Molnar <mingo@redhat.com>, Jakub Sitnicki <jakub@cloudflare.com>, 
	Jan Hendrik Farr <kernel@jfarr.cc>, Jason Wang <jasowang@redhat.com>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, KP Singh <kpsingh@kernel.org>, Kees Cook <kees@kernel.org>, 
	Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Marc Herbert <Marc.Herbert@linux.intel.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Mateusz Guzik <mjguzik@gmail.com>, Michal Luczaj <mhal@rbox.co>, 
	Miguel Ojeda <ojeda@kernel.org>, Mykola Lysenko <mykolal@fb.com>, NeilBrown <neil@brown.name>, 
	Peter Zijlstra <peterz@infradead.org>, Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
	Sami Tolvanen <samitolvanen@google.com>, Shuah Khan <shuah@kernel.org>, Song Liu <song@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Thomas Gleixner <tglx@linutronix.de>, 
	Thorsten Blum <thorsten.blum@linux.dev>, Uros Bizjak <ubizjak@gmail.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Yafang Shao <laoar.shao@gmail.com>, 
	Ye Bin <yebin10@huawei.com>, Yonghong Song <yonghong.song@linux.dev>, 
	Yufeng Wang <wangyufeng@kylinos.cn>, bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-sparse@vger.kernel.org, virtualization@lists.linux.dev, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 9 Dec 2025 at 18:06, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> BTW, speaking of C23 fun that is supported by gcc 8, but not by sparse:
> __has_include().
>
> Linus?  Seeing that I'm touching pre-process.c anyway for the sake of
> __VA_OPT__, adding that thing ought to be reasonably easy

It sounds straightforward, and I'm certainly not going to object. I'm
not sure how much we'd want to use it in the kernel: it might make it
slightly easier to deal with various architectures and the "if the
architecture has this header, use it, otherwise use the generic
implementation" kinds of issues, but we do have fairly straightforward
solutions for that already in our build system ('generic-y' and
friends).

So I'm not convinced it really buys us anything - I suspect it's a lot
more useful in "normal" projects that have to deal with non-standard
system headers and possible lack of libraries etc etc. Our build
environment is so self-sufficient that it's not nearly the same issue
for the kernel.

              Linus

