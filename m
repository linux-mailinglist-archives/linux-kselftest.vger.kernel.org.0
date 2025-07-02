Return-Path: <linux-kselftest+bounces-36346-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A8F6BAF5E0F
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Jul 2025 18:07:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1AF41C4208D
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Jul 2025 16:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 100AB2D77E4;
	Wed,  2 Jul 2025 16:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZvB26W3B"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D5F274FC6;
	Wed,  2 Jul 2025 16:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751472469; cv=none; b=X7erveKL9c0aGk9rIY2IuwnMOw/U4FftkFJgB5LVgyDX+gPgTIIqQS36uMy51Mwzj2uEaO54434Uhw9rkRCpz2Rr5HVmx6y+uN+W/xFEiUyi/0v+JPygiPDFCKxvkG6MT1kJu7/7QnIl7SxXeTVwF0qTHSz98PJsRfDjoNJ/5bI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751472469; c=relaxed/simple;
	bh=HD+xgnYDji4Msf7wrsJXB90TJgJt6pJI4Z6MoS60Mb4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kKZr/K1tvFyiwEWt4J4EtcQ5W+845G0dVhWCdOpipw3yZjtRSZantyNysbGuzeQbvAhUPg2XUGKhs+UMqg/J9PoVqxlpiL35yKU6YFkD3vTfM62B4uSabI02f5Os8Rol+80sX1kikEzUvj2gE0pvmcagfuYDF2RwBAHY0OKArQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZvB26W3B; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e898de36cfbso161272276.1;
        Wed, 02 Jul 2025 09:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751472466; x=1752077266; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HD+xgnYDji4Msf7wrsJXB90TJgJt6pJI4Z6MoS60Mb4=;
        b=ZvB26W3B90ugNERZplI63eJ0T369q/8qp422VKvCVXLDydPczFYeC9+rKwWWLcLGgq
         emxZWMXqdJafsLgMGKghabY5XSy6BoGnr1oMfFSPEx7KnpUiaruioCeramFXOLpU7kg7
         eaDLusdkxzVvzJEql561l4qAk9ck4Xb9HKgqYeQGY7vxKrk4ZS4t5Irte129Fmd4ajY/
         aXEN4OixOeXBCLHGa96oxOB0jY+kzrPKNuTF7jHp1WQSVotS8E3+4vSmrtWeftX9qT6s
         wuzpfMFl8wgkwF4OXPR10qJPX1twawyYY1+UwU3OdvGF+aFE9F8FTg0XAvJGBEb3OX6k
         e2Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751472466; x=1752077266;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HD+xgnYDji4Msf7wrsJXB90TJgJt6pJI4Z6MoS60Mb4=;
        b=Xt+DbEUaMWz0m3KVU+krMqTaqh5wCcxUyc4/T8CRHJezynIYXRkEv2/Fki11Hg54bo
         yG9zIgWKZzvVcNqEjKMv46Ar1GTHnCshP9df45FJsL1L7SnrGDeACgqtjWKGTHLXZPzW
         8eb7eS3XFg19lZC0vumpprcAV0onNs5Y7gnRbeyQC/1SocSQLLv2BHWchgKSmmyBt8p/
         MM5Yb0IdEQ3LC+b4Y83StkIelbyIv30HSmX1E22ZhXaeSFD07RQikl/8JwojshO+Tfis
         mjZ0FXNNtVKlGD97D5JejH6eIx7R9zwd41TQVPHNfsYxNhNedTRcgE1FOB2eEXlSzWaY
         FrxA==
X-Forwarded-Encrypted: i=1; AJvYcCWqkVLLWMZ+MQY4yhKqDPDuWZIrfzcEZDdIbWIrWstRkTXe5k/ZTCoWp9MHq9dCTYygvtAYTIgNHiaxDb0=@vger.kernel.org, AJvYcCXoLU+wecQ+RcGU3LJxBILVoIVweeT2jP3BNhumlGUQaL9JfqSV3lXS4qPBew39gzafVlj0xdQMbcY0QgqeLcx/@vger.kernel.org
X-Gm-Message-State: AOJu0YxK3otYgPsaleXh5snaziJTm8zJsW93UJZ8QW0Sb4bX9Ix/jVpL
	8/T/fhpGM994gX9mYRgoGvFYj5aczZRUURh/KPrBWV3+75F4+/GMsL9u1eqv2yrCuJErAA0jBkL
	3oz3PhiCZGxjfrgbG61EBRVi5CJLOZ+4=
X-Gm-Gg: ASbGncu016puCO7GMhWtT1mDPrbvi6FotTBWbjSs2EKc/2v9bxtQGRdxKGMktnEah8Z
	XoA7+Wu8MOFMbS4xLrS+2axfCMT9uPOEYHU/7yNTSU9MUSWrNCsa6rGcVTXHWFynxH8QQ4Th7Dg
	5V9almyfEW82c+XVuxDV9LbIq2kmyj0lavPfdDtk3no7JIQKkzLXQ+Rl+OnNff/0PJNT9mnnzVs
	LI3zANyV6A8cXU=
X-Google-Smtp-Source: AGHT+IGJlgMebHeafPhpvXNEnuwrkCWG7XoVPlNbjrpQZw1BfOjYrG9vvzbLo5wAqGetaoboXNjnvUJBf0NJewO55f8=
X-Received: by 2002:a05:690c:fcc:b0:709:197d:5d3c with SMTP id
 00721157ae682-7164d2c7e12mr49580597b3.11.1751472466302; Wed, 02 Jul 2025
 09:07:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250624201438.89391-1-moonhee.lee.ca@gmail.com> <744bd439-2613-45d7-8724-5959d25100aa@linuxfoundation.org>
In-Reply-To: <744bd439-2613-45d7-8724-5959d25100aa@linuxfoundation.org>
From: Moonhee Lee <moonhee.lee.ca@gmail.com>
Date: Wed, 2 Jul 2025 09:07:35 -0700
X-Gm-Features: Ac12FXwoDxTwwqAXE8JcpNRXiozFERVYFVPE9rjvlkt3rV15dPoHwueD88FdyYo
Message-ID: <CAF3JpA72DWF8=2HF+_HMsH4DuOg5aVYZdgyhmJisDG-WxL=uYw@mail.gmail.com>
Subject: Re: [PATCH] selftests/kexec: fix test_kexec_jump build and ignore
 generated binary
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: kexec@lists.infradead.org, dwmw@amazon.co.uk, mingo@kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kernel-mentees@lists.linux.dev, shuah@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Shuah,

On Tue, Jul 1, 2025 at 12:53=E2=80=AFPM Shuah Khan <skhan@linuxfoundation.o=
rg> wrote:
> The change looks good to me.
>
> Acked-by: Shuah Khan <skhan@linuxfoundation.org>

Thank you, Shuah. I'll carry your Acked-by tag in v2.

> There is another patch that adds the executable to .gitignore
> https://lore.kernel.org/r/20250623232549.3263273-1-dyudaken@gmail.com
>

I missed that patch. Thank you for pointing it out.
I'll drop this change in v2.

> I think you are missing kexec@lists.infradead.org - added it

Thanks, I=E2=80=99ll add kexec@lists.infradead.org manually in future patch=
es since
get_maintainer.pl didn=E2=80=99t include it.

$ ./scripts/get_maintainer.pl --scm tools/testing/selftests/kexec
Shuah Khan <shuah@kernel.org> (maintainer:KERNEL SELFTEST FRAMEWORK)
David Woodhouse <dwmw@amazon.co.uk> (commit_signer:1/1=3D100%,authored:1/1=
=3D100%)
Ingo Molnar <mingo@kernel.org> (commit_signer:1/1=3D100%)
linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK)
linux-kernel@vger.kernel.org (open list)
git git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git
git git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git

Regards,
Moonhee

