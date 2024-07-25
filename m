Return-Path: <linux-kselftest+bounces-14190-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 34EA293B9CE
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Jul 2024 02:29:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE6B01F22513
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Jul 2024 00:29:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53E1A17C2;
	Thu, 25 Jul 2024 00:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xicpiue/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E994A4C74;
	Thu, 25 Jul 2024 00:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721867337; cv=none; b=LqjgwvwUOZhWEjKdPkQLp8+z5/4QOpjljXa7fYEkEBf0EM6IKMIgfj1v72f1avrqhQ26sKEoFu3i2Dnvo5uZyuf+DfjDSWftPm8GRYIxRHlC5kIGMlBFPVPzUUm5UGIAyV9Pz/d/SxJKrbk7INVAqgPgK2Vs2Q/uHoJ7NrXMrTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721867337; c=relaxed/simple;
	bh=JkRKP3Mdk1VobjdH3nzRIMyVgesirQABoN3SOhqDUJs=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q8jJkUQtU2YoEtrE1rEQR5dNhNmIAcQp894eEt4NnEcJg1vPlA31QqX+IugglLiVCsMC10sqsfjlvps8Q1aI1HnkYavniIYO3U1dw6GmA7KcL8zA5l/a/Llhy95cJ40GB1ZjQAvcKaif2Ktpz1nDZdD5qmHw4v715T/bdGASgJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xicpiue/; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-70d1cbbeeaeso301915b3a.0;
        Wed, 24 Jul 2024 17:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721867335; x=1722472135; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PmMNOgAp88bPv4E0FsOEIwTxi2FrufOzMRY/0z3SpRQ=;
        b=Xicpiue/bOxSBy4jPIcBXjfJw2xS3AGby+4DMzubVavkcvM4glTpEpxS2ibYlw527/
         UglcvUHEZ68O3E0VbDDBCgw3FGTS9G4S2WwHqnL4EUxg5D0p3dfiLdDbJxsu5NaO8/qF
         m9LY6oqW8e6HbRcF9dzLymPNXYTeQ7ygQK4TMfQlXx1BGh15vvrenINaTJDshT598Xwo
         9hMBBYQV+bYMv7xArZvfp5rVf+8+IH2Z5/wy0r/+XprzD8d+/vop/1qtFa4G+tRI2Yn+
         oJX1D7V+QB4OZ2GcIc3xkWkFCX5Gl+DHNyKrDxbWTDdg6vbz2fs6WKATFwjHNH7/bRHX
         RckA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721867335; x=1722472135;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PmMNOgAp88bPv4E0FsOEIwTxi2FrufOzMRY/0z3SpRQ=;
        b=YVyv41TbXPOaO7PelkqaQniVM5Q9uErkhZ0XkX4V0Qw9tWNEPR5I2GG5HgnQSX5u5o
         q6Iv3MdAGaLfnX/iINQ9YVU8Glh/sMx4+K0Pbvt+WNLd72ZTIfGDoJbKdsx1hZ8t+tcF
         vYKFCFmT8gATp19DPwuAMwZXQiZCE5vpsfaoCILjueRw2gASLULZfyENFYmC2lqLIJgq
         YPo2vdkRa27chCCizE/wuaoPzVM1VymCtcXkjJ6etfoTVLGHzVOTBl1TxKSP5pSxTP+r
         yEF2O0FMASMt4jDkjN3BlphMUgjLzcbYw1Ic6QRzQeKxJlOpp1QMjd+PpsZItoIZdeuo
         jRjg==
X-Forwarded-Encrypted: i=1; AJvYcCX6ZKNYvyyAmrD5CGRz4b8jjQpeMsNHwNrRPSqGBz0tX5TXh27RoqlWBAkjuslMn0dPuGrtalEcV+CEt6WfGxyBCaB/fqtWX9/F6m+GrVje
X-Gm-Message-State: AOJu0YxC7cVqD8ZWZT1q+3qMF+hZaZ3oKhat6VjdY9LJqbwbG1urxaa6
	DUsut5PW840M4WYXhFCG2c0sXrGfp6sW3awDwsp7Pd+H24tGZxu/
X-Google-Smtp-Source: AGHT+IGxrJqhwp9lOs+gmE4RlQUlh0tmFgwDAgfRLt8LJnNDC0aj2VErDsuRFSSkYmt8c4HvvUjyVg==
X-Received: by 2002:a05:6a20:2455:b0:1c4:2134:dd52 with SMTP id adf61e73a8af0-1c47b116f02mr252202637.3.1721867335091;
        Wed, 24 Jul 2024 17:28:55 -0700 (PDT)
Received: from kodidev-ubuntu (69-172-146-21.cable.teksavvy.com. [69.172.146.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7f1fb90sm1753565ad.182.2024.07.24.17.28.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 17:28:54 -0700 (PDT)
From: Tony Ambardar <tony.ambardar@gmail.com>
X-Google-Original-From: Tony Ambardar <Tony.Ambardar@gmail.com>
Date: Wed, 24 Jul 2024 17:28:52 -0700
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>,
	Shuah Khan <shuah@kernel.org>, Yucong Sun <sunyucong@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Kuniyuki Iwashima <kuniyu@amazon.co.jp>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	Dave Marchevsky <davemarchevsky@fb.com>,
	David Vernet <void@manifault.com>,
	Carlos Neira <cneirabustos@gmail.com>,
	Joanne Koong <joannelkoong@gmail.com>,
	Willem de Bruijn <willemb@google.com>,
	Yan Zhai <yan@cloudflare.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	YiFei Zhu <zhuyifei@google.com>, Geliang Tang <geliang@kernel.org>
Subject: Re: [PATCH bpf-next v1 00/19] selftests/bpf: Improve libc
 portability / musl support (part 1)
Message-ID: <ZqGcRGTo8xQxZy4r@kodidev-ubuntu>
References: <cover.1721713597.git.tony.ambardar@gmail.com>
 <CAEf4BzYaOVDitzcY+j=vpAqeNC+KZXk9pcTVht=npCmnPpoKmQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzYaOVDitzcY+j=vpAqeNC+KZXk9pcTVht=npCmnPpoKmQ@mail.gmail.com>

Hi Andrii,

On Wed, Jul 24, 2024 at 04:52:57PM -0700, Andrii Nakryiko wrote:
> On Mon, Jul 22, 2024 at 10:55 PM Tony Ambardar <tony.ambardar@gmail.com> wrote:
[...]
> >
> > Tony Ambardar (19):
> >   selftests/bpf: Use pid_t consistently in test_progs.c
> >   selftests/bpf: Fix compile error from rlim_t in sk_storage_map.c
> >   selftests/bpf: Fix error compiling bpf_iter_setsockopt.c with musl
> >     libc
> >   selftests/bpf: Drop unneeded include in unpriv_helpers.c
> >   selftests/bpf: Drop unneeded include in sk_lookup.c
> >   selftests/bpf: Drop unneeded include in flow_dissector.c
> 
> I squashed the above three patches into one, as they are the same kind
> of fix with the same reasoning. The rest at least have a specific
> error example, so I didn't touch them.
> 
> But generally speaking, I think it's fair to combine the same kind of
> fixes across a few files (for the future).

Thanks for clarifying this and reviewing. My concern earlier was that
squashing "Fixes:" tags could hinder backporting. Is that a non-issue?

> Applied to bpf-next, thanks.
> 

And thanks to Geliang Tang, YiFei Zhu, and Vadim Fedorenko for their
feedback.

Cheers,
Tony Ambardar

[...]

