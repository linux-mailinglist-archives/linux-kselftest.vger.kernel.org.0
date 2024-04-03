Return-Path: <linux-kselftest+bounces-7120-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 68EB6897B21
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Apr 2024 00:00:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D9B11C21892
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Apr 2024 22:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACA6A15689D;
	Wed,  3 Apr 2024 21:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1IVSAQ5V"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D5CA15099C
	for <linux-kselftest@vger.kernel.org>; Wed,  3 Apr 2024 21:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712181599; cv=none; b=lakQeJDz2CPZDOSJ5NNrWoQATK35ZXceRz2FQrPumHgnKxCjzh2ASz3LHTaSHryq10xgOhYFzE+tkPPfFsC6XRtE6n8cfYJcZ3RdNzWvjqTgdhbHIKmHOGO4UC2TDbfggYhDict1UJtSHoC8oOAWUViRswScNZgTpMvXiHR5bCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712181599; c=relaxed/simple;
	bh=J5cX4GqktbP0gID6yrJUxK/jCIdoAH/C/9xsI+yoDaE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qB/LaJ8qOjdZpwYb4gvK2LMI14/A+43PezeRQzkWTRpDmE0XjYlUraB0iWR/l1aZs2OrU2Gh7qgIu8wrnUUDcw59J3FxOhqvkFYLOk71gXbc6wE9YfLzDUHLjDXf6leNn20eXGpGgoYCBlYFd4PBfKTJ2EWP2exAgGBEbRTSsZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1IVSAQ5V; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-56beb6e68aeso1657a12.1
        for <linux-kselftest@vger.kernel.org>; Wed, 03 Apr 2024 14:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712181596; x=1712786396; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qTy7UZvOGfVzOyBfYCslewqivjbuSdMwhgF1qVbAn0c=;
        b=1IVSAQ5VFCMovnIRk+cGRDEWfEwK8iC+gQ7wq77X+DWJ0/O2F+rIzuAntdOROFV6/0
         HJpsjnAi48P5hBCYkokapjSLIfKYCWjnOXInpr9XMOdvfywFsmFTfGFD76Dn+UVJu/Mp
         N50VbviqV4I5DbiL85StfH0HJZSigFzPSTmOuEiGPo+9Hihzs+mV+p4FxoTrFwwAa5fM
         QKTseOEsSNws8Uyu7rYlHWAliAkPdRuYQHpxN3bRdsbzh7Sas3yu724Hf21HYGcDKg50
         vnABWme91nBIqMKfrb2vv+MEOu1YZpUmXU4v1CeFeJguRg/UyredijICSKOvoMJIXmI3
         pz2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712181596; x=1712786396;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qTy7UZvOGfVzOyBfYCslewqivjbuSdMwhgF1qVbAn0c=;
        b=qquEhi3x2OX5Z5yXoNlSItK3ONg8oppVf8GzgMS+ZUBpVEd0XtptDDyB9dTnsNVHwy
         hqTLwJu5fQWFvc/8YP8IWzr+9oQ3N7Mpraz7FhP1+Xl87yzXOhZwMXjcSJO95bWJXDSY
         lHEJk7ddndM8Hj8Vgg7F2jdxECgbJRuVZxGuH6HExVJ30uS30jhKVYCCd5DM2huqffcL
         XI37oNxljijgdlfLAK0SvZ0qv/t3VS3GDfKLJYQaaHZymYZT2zeVALWQVA7yrWGBO8s+
         ojchBbRxJ+UcT8jwooCF77cpGA24WxTCIiNLPyZo2gtyhj+UOEciyQ8MhNmyO5E5996p
         uy2Q==
X-Gm-Message-State: AOJu0YyVkIjONQvMGIiHLzRv8I+rcNvPyGu0/etDiVO4jMdexaPu5E0q
	rjpwGPbMHD8vZumAg5rz4LE1DdapjvNwMZ2DqnjXvTp9/qd97y9HiEU0JMsrOGIFurAI1zvkTWo
	3TSzOzft5dhDjX+dCdeki3MJx2uXpCJcfSzcr
X-Google-Smtp-Source: AGHT+IHTInqBsj+mNZa49X8OvTOGw8WohoVAZbNq1Rfczn2ElBMyortTXet/IJD1sZ4waCx5tYiTp/gANpZfOjPunrg=
X-Received: by 2002:aa7:cfd7:0:b0:56c:522f:6799 with SMTP id
 r23-20020aa7cfd7000000b0056c522f6799mr278607edy.5.1712181595529; Wed, 03 Apr
 2024 14:59:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240402125109.1251232-1-jackmanb@google.com>
In-Reply-To: <20240402125109.1251232-1-jackmanb@google.com>
From: Daniel Latypov <dlatypov@google.com>
Date: Wed, 3 Apr 2024 14:59:43 -0700
Message-ID: <CAGS_qxpBmmafnQnDXYf5RftPzxghd+i8Ly4CK=EkcpidpCPP6g@mail.gmail.com>
Subject: Re: [PATCH v2] Documentation: kunit: Clarify test filter format
To: Brendan Jackman <jackmanb@google.com>
Cc: linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Brendan Higgins <brendan.higgins@linux.dev>, davidgow@google.com, rmoar@google.com, 
	corbet@lwn.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 2, 2024 at 5:51=E2=80=AFAM Brendan Jackman <jackmanb@google.com=
> wrote:
>
> It seems obvious once you know, but at first I didn't realise that the
> suite name is part of this format. Document it and add some examples.
>
> Signed-off-by: Brendan Jackman <jackmanb@google.com>

Reviewed-by: Daniel Latypov <dlatypov@google.com>

Thanks!

I agree with your comment on v1, I think the extra verbosity is fine.
It's still easy to read and this should hopefully eliminate the
ambiguity for most readers.

> ---
> v1->v2: Expanded to clarify that suite_glob and test_glob are two separat=
e
>         patterns. Also made some other trivial changes to formatting etc.

<snip>

