Return-Path: <linux-kselftest+bounces-22807-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E77C9E323A
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Dec 2024 04:45:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58B651648AF
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Dec 2024 03:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9119B14D6F9;
	Wed,  4 Dec 2024 03:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="YqOz8u5T"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A4522071
	for <linux-kselftest@vger.kernel.org>; Wed,  4 Dec 2024 03:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733283939; cv=none; b=dOP89siYfZR/JUQHNU5bPHViqy7DhCdjn6wPrIhYAQdnpHtaILni07ueK8ZH6a041sL1KCM0tVWp0luBQdf3H/88tXt6UDrHPCqGgXimhJvC4SV310vVvaNDfSm0c16Y5O2ohs34VZIbIy/M23AuYDaVRjJs0019suEqiGnY27E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733283939; c=relaxed/simple;
	bh=z1XbbGsUJBtc2zHLxA0NJaY+IxjwSMN+nIlUbS9g7z0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cBFzvMEIwMbko4gnq0TbKMJXkBiezG67aBVOdKW6TC7ESDAaR/ZFJgpONSM33NEZjlblzxO85KwrSGlNHt67fw+rcsY/EHiOP2qDSwRVT+jZ+TI5XsTYUaSPCpwtei/L/df+C1++/Gi6/69apQwChFRFHKm8vI17cW4EAOB92fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=YqOz8u5T; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e38938a55e7so5332401276.2
        for <linux-kselftest@vger.kernel.org>; Tue, 03 Dec 2024 19:45:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1733283937; x=1733888737; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z1XbbGsUJBtc2zHLxA0NJaY+IxjwSMN+nIlUbS9g7z0=;
        b=YqOz8u5TnRcqvD2j2R+fJYo5RYCCQmSjn6XkK5dm2c384gnHP9I0Qj8skbh1mjFbSZ
         sHFW8IOZezK9ANBVt8WDiuNmFhrTZXaH4kyPiCFQLqwPk7xIuSZqUiWIY2hijrI377er
         YvoHUL6Ig+2k44oxYur1LQFNvQ3XdkCQb8qPbB4w55gfHsXEvwdmN8esI+vN7DM4V2Ts
         cl8ZEPrm06ZDSnFvhcoUwNUi202XpbAwgQ5HdECrT02xw11znyq3pLZzjruog+KqIZm1
         8E6oti+kxHQUj7YhcOXHys861gjAUTwaNrD4pWfdABlKQLNHwXdmQcPQKSKggNoBJQCn
         gHsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733283937; x=1733888737;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z1XbbGsUJBtc2zHLxA0NJaY+IxjwSMN+nIlUbS9g7z0=;
        b=Zwy1b6AYkk2gmS/VQXTbKMZvWCLYB71bNgyer0BpqFM5O4uSo4tpNT0HMa/zkZMMr2
         9y4PhM3Ss41F51xVSisJ7ne6c2xrYZXTwvD+3GkNiCc/D1doMB09xuLul3VBNjpux7fP
         6YX9dOBVqA3ugt0rrzsYNp6GkPqo02cupcC3uiQTybfwD21kvVPFBOXCnP60drzlHcx8
         XqV7L9z73mMiPs0aTdSi1HaSRkUfas+phE0ZRp3ye/7XcOKQNb44oaFk8RrHJ/bIMUqp
         Qz7VyjLf1EfwJpNzpDScmEfoAbY3rsuw6jaM3h8fC1kuVBXKaBP5wigedSXFErxqXm8Z
         Torw==
X-Forwarded-Encrypted: i=1; AJvYcCVRYGaH8lUAEEj6LC3FDxxAEyIBmIODRUNR7m5FeDy9gmWJMkBjTasKaJWjSI2Jua37XHIR+KvJEYUy9FHPNEQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzddU8dhd+DXQpgC8CZlS8d4glS/t7LNrHUW0jh0FDCZeeou/+c
	+chNGXt09H0jxkT1o1BiLydG2audDJnwoCZfSJzhsC9PW6e0K45dvVUGulUXk5kUxYoxUU0DK9T
	z8v3LMC/CF3vsvNXhDXtJADGsRLaFgQYO7ixI
X-Gm-Gg: ASbGncucSo3i+cNbiYBrdGVzbvirts6pPS6Uhxo914sZEQzxndHaZi9ljcN4hAi6pXG
	G76Yd3o1WZkuq8xl3o2Y9/KJrvy7kGw==
X-Google-Smtp-Source: AGHT+IEnXWo1p3qjR3U8AU/4Sw7qLma2QQ0LRrci3nJqI5tWuNU5cRLLQ8tXAXSK+umt83Aaiyni6AwdQeANpibv2VY=
X-Received: by 2002:a05:6902:340a:b0:e39:6c6a:f2de with SMTP id
 3f1490d57ef6-e39d438d9bbmr4803300276.47.1733283937166; Tue, 03 Dec 2024
 19:45:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241112182810.24761-1-av2082000@gmail.com> <52cc8e51-9e85-465b-8ee3-63a7a0a42951@linuxfoundation.org>
 <CAHC9VhTJERn54qNDDOwNrJ09VWrmq5Qn+sPQV__LyeEUgSi5pw@mail.gmail.com> <e8e6824c-61d4-48f9-8547-628bbbd3063a@linuxfoundation.org>
In-Reply-To: <e8e6824c-61d4-48f9-8547-628bbbd3063a@linuxfoundation.org>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 3 Dec 2024 22:45:26 -0500
Message-ID: <CAHC9VhR5NVHOz84RBzi9L+h=kqpe3RfaEXDa+87BCLPAt+Qskg@mail.gmail.com>
Subject: Re: [PATCH] selftests: lsm: Refactor `flags_overset_lsm_set_self_attr`
 test
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Amit Vadhavana <av2082000@gmail.com>, jmorris@namei.org, serge@hallyn.com, 
	casey@schaufler-ca.com, shuah@kernel.org, ricardo@marliere.net, 
	linux-kernel-mentees@lists.linux.dev, linux-security-module@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 3, 2024 at 7:00=E2=80=AFPM Shuah Khan <skhan@linuxfoundation.or=
g> wrote:
>
> kselftest patches usually go through subsystem trees because of the
> merge problems you mentioned. I take them through kselftest tree
> if subsystem maintainers want me to. Some do and I pick them up.
>
> I pick up patches if I don't see response from subsystem maintainers.

Thanks for the clarification.

--=20
paul-moore.com

