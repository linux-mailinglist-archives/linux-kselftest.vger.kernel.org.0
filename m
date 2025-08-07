Return-Path: <linux-kselftest+bounces-38425-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F493B1D0C6
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Aug 2025 03:58:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB221582988
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Aug 2025 01:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 579B114D2B7;
	Thu,  7 Aug 2025 01:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KThIkaMN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B01AC7483;
	Thu,  7 Aug 2025 01:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754531886; cv=none; b=rwPzGEaMRGBJnc7eJ6WSUMWCxfAgoJSFJccTdUjgSHlyNIpN2I3ALJlcuqxecsVhw9jzPIO+wNdz/sYxkPXY/28OPcfiSmIlRsvERcit8wt0+JYa0hQQAC2sUydKX203p3F9DvbKpmLGwmy1JNaWajWIGh3u9fSqBpCeNxUDegs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754531886; c=relaxed/simple;
	bh=8I9Gt1H0ZE5k1cffQXUAxhLrCOxZeM9nrDgBpbJx/qk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g7+mvAS9QQzq4Pvd1LoU88SPOPgWQSoFHzRcVuxw/nRySS+mfPnJCtnsBT5HE9xjjPIfZ+AJT3qKjRfadCi5yxgxYeNkyWetfi6diLx/t4hUd56zCX6uoOQi5CwKQZCn40/U0SQnVd/8Ee99MNEIlEvyB0X0hZhx692Z8gdKZfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KThIkaMN; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-af934d7c932so70217066b.3;
        Wed, 06 Aug 2025 18:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754531883; x=1755136683; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8I9Gt1H0ZE5k1cffQXUAxhLrCOxZeM9nrDgBpbJx/qk=;
        b=KThIkaMNcnfSB8E1R0N15A+FXC8feW6EcJbDa2ooxALjdRRIxUM/3VsuaO6PEVOpW7
         8kCrTOUNSBxnDz9pgcH+gTn7hpBHLnVQv7VSpiakjTadUXQsICsVM5y8+w9mviUOlYEV
         Ukb+8PJsNguENP+dpFw5YlplOT23xZTONlZr6FtfOKic3CswPtD4n9hTcmLaM1mZTxae
         AOvI02MUxj4X1V8WNrJoIEu4H4VBw2vf2uvmRUyQJZZBx9TyF9wazPgf3hcJ2zuzLE57
         AhAlLmL9dbhNahNhDl8ab2QofbRzSINXjXGMr1O85QNQmbtVUSjZZ36fW1mrZEwZvtXc
         JEdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754531883; x=1755136683;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8I9Gt1H0ZE5k1cffQXUAxhLrCOxZeM9nrDgBpbJx/qk=;
        b=O9hBGf9td1n0xbidNlLv8stv1hm3kDpt/V3+Xv3ragM6QYk6enQzjOCvoJDqcB5SxR
         ivYCBv65w8OshMeQGj8aAhGu9AlZ0ucWxCk4yY1yzyuM1wlcV2Y54tnqc2AIJpooQVW3
         aQ4+9aDQXWS7P6iUL1mimZP8133fBP49YRuhGU3dluGioZFf0WEmKUmbsVcfLyocViBQ
         mHNJmRzHqmRTQwIbslt/dWiOtfo+vPLsZvKHDyuicw2q1Mo7h8mf73zLt2mI8Xz8BwnE
         Eou+pM47SXlQzP7jcOvnz9va6L/bf7kMHb9pAzMQ3J1UbtO1EImcV7ZidnZkfYUDXzry
         UPIA==
X-Forwarded-Encrypted: i=1; AJvYcCUG4z3KLiFVDMV8cvcIdSphlu7kd+j8QU3w9eCn1Eg/IbI0Jk0un7ILbQU0cTQm0Si+S5cGBHPtyJEgtJvmXFCs@vger.kernel.org, AJvYcCXEOtk5dyspyl4bSdNWzvZae2HcuNBSBny/Nw5ae9P6wEuo7RUUVwj79ob1TRi5czcdsaFHP1nNMXsllwy7@vger.kernel.org, AJvYcCXH+948q9d/VcvkBoMcJ4y7HjOt9EmJBZnkZbkdzoQED2BYJ4u+SJULNM5a8yDYF4Rr/e4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyB8iq4xLGH/j7KqdEj0CDeulaDfRwZo8hQdCF1THZCRWTO+vec
	zIpj0MeQ4kWoB2swSxGw3XwZgui8Hhn4cQEfXS/tuQwh7Q8z2t8kS9B/UQcj26vzPiavj03b7yc
	PADwZVG71Lrifcq+MBvbaUtI4iakTWXc=
X-Gm-Gg: ASbGnctRwlgaCxLXzzMnj47TDLBoB5GubrDv2IWE7qHMMjbrYi4vStzm3oehLoerp+U
	TWPTDdjvlEHTu5i9vVH5LbYO08kk6onKO/IBzrRE+B2kiju4WqpMEXxSDHjLUcjsqyBZg14THG2
	lHPZ7hak0oQ/Ee2xyJglS5OMpOwcNtzTBoLArOBapTzRZJ21z8mnNQLoQzlZrhm8YbiafSutweV
	DHhCX9a3QUKlh3CVTVivHFsD1lxBK4CbQzW
X-Google-Smtp-Source: AGHT+IHdYsCOHfZq+TV3JC2/vuQihc0W7AMnb4Y0PG/YGEWgDibGpFXd9SkrCT9S9ENhafpS4JzWygZ4TgULy81H9U0=
X-Received: by 2002:a17:907:724c:b0:ae3:f16e:4863 with SMTP id
 a640c23a62f3a-af992a60dc9mr358536666b.1.1754531882814; Wed, 06 Aug 2025
 18:58:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250807015415.2406263-1-jiapeng.chong@linux.alibaba.com>
In-Reply-To: <20250807015415.2406263-1-jiapeng.chong@linux.alibaba.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 6 Aug 2025 18:57:51 -0700
X-Gm-Features: Ac12FXw4m4ezi8GQg7F0Kmfs3Ahtqd0_a5G-6CrUg7W-QgBI-8NK64mjOlikc8k
Message-ID: <CAADnVQKZ8GTrV1x7FH8ffbFkVpQA2CeqDWTMkKyO1bTE-tGQVg@mail.gmail.com>
Subject: Re: [PATCH -next] selftests/bpf: Fix warning comparing pointer to 0
To: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, bpf <bpf@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Abaci Robot <abaci@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 6, 2025 at 6:54=E2=80=AFPM Jiapeng Chong
<jiapeng.chong@linux.alibaba.com> wrote:
>
> Avoid pointer type value compared with 0 to make code clear.
>
> ./tools/testing/selftests/bpf/progs/mem_rdonly_untrusted.c:221:10-11: WAR=
NING comparing pointer to 0.
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>

Hey Abaci folks,

stop sending this kind of patches.
Use your time for actual useful work instead of noise like this.

--
pw-bot: cr

