Return-Path: <linux-kselftest+bounces-31527-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CFA4BA9A5C1
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Apr 2025 10:23:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC3A218817A3
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Apr 2025 08:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3740207DF4;
	Thu, 24 Apr 2025 08:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="MgB8nMK5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out.smtpout.orange.fr (out-16.smtpout.orange.fr [193.252.22.16])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2357B207A2B;
	Thu, 24 Apr 2025 08:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.22.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745482990; cv=none; b=eHsNgWzoWTeQyL8ceR3qD0sTMDzdWK8fEx3FtGpU1g+HZdsyRgkX/2lyW858ZIIfxG3bTl6zPwg2UKPCyo0tdisZGtqimjgH9iLls2kyenChEY4syD/ejwOCdVF3USRzeVMaCLMF0M7acvdT0RmQYDL2v0pEJU0nK4zzu519rng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745482990; c=relaxed/simple;
	bh=qnRPE/OjqDULD2P8NhZ9G/++7eMxpWckPTuemPzYeDE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M6rZuP4G0qV1kUWgaQbvC6lSxujCGOp6+HQw2DFWY6HRQZ8dqNe1DunXNkvEHZMzyXRIKIBgP4hXXrsiIxYFZpwviBmZb9iNQ4ym5rPAtOInmZR5v9l+MnechzRvaIV2KXxbS0IPSHiZ6oNGN0eQLur/gahD1xF7bINnO3KUbag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=MgB8nMK5; arc=none smtp.client-ip=193.252.22.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from mail-ej1-f48.google.com ([209.85.218.48])
	by smtp.orange.fr with ESMTPSA
	id 7rqCubwxvvSg77rqGuXwwe; Thu, 24 Apr 2025 10:21:56 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1745482916;
	bh=Qi0itqsQpWay2GuVwalqq2IwjGZETj75/Z4w2YScqHQ=;
	h=MIME-Version:From:Date:Message-ID:Subject:To;
	b=MgB8nMK55fXzCwcRiTZXUIwuKktqYavs7OO9YYaFUXjMNI24e/31L0w1Cgo04pNBA
	 IDGapSnOXlncr7xLJpT6SxulStwd0ojaHI08aq9PL3hJ7IzPh0hU9+PJfnAHyrDPIm
	 HwKJsXht//lrVmScoYYA+vmtbxEyo5HpH5JK1BGADxkZ4VnAUqr5p5bdoClkDw7OuY
	 BNwW6R3Wl+NVuGmzCDKsxRC2lX7K8GEqghThuEHAPHj0R/0WSADFxkOPC7589fv8Ok
	 87V6iC7QJT5Pur/NUL7uMSglJlRsnUpOgrAvt5vd3QRJbc2qRWL83eqOi7hBY6yPyz
	 21HrCicXXSACg==
X-ME-Helo: mail-ej1-f48.google.com
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Thu, 24 Apr 2025 10:21:56 +0200
X-ME-IP: 209.85.218.48
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ace333d5f7bso133525866b.3;
        Thu, 24 Apr 2025 01:21:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU+c75tGkvUtBZpza9i8iLAudf1qnLj0CRiHnX9v+WFQARzWkDEFrPMkZ26e08k26Xc0wkQDWehucM2QSIf+mb7@vger.kernel.org, AJvYcCX7GD8Xk5Mtu9NqnA9IWNV51a54ULwJLDfMjj3TrzkhFKnJPfDE8VDIOuYYhPum4IPPSzee5DlHbWs=@vger.kernel.org, AJvYcCXsq8IZD402gINaC39S7yFy9wnXqxYyvpAcqWgoVYy6xy8FSrKJmNggjN7GPzC8FqGTGQepvUVp@vger.kernel.org
X-Gm-Message-State: AOJu0YzHk3C03MKO+emjwB85D1RKvdFS/KpwrO4ZF71Osd8v/VExbXKj
	n6/GamuY5NhLb+FGnjhb91TLnLd4In1eD1YbgG2R4GwZzsbQS72ZkerSp3bfz3qTu8HDXs42gA5
	/d2hMZISXTv+i2npoeIWHFMA8Hd8=
X-Google-Smtp-Source: AGHT+IG0UHw7cStUnc5g3aVjgS9EvHS8GbZ/STZwvgx1+CuvS1aIGReEO/sw76SXPLW5pLvsQpjnpMm6tc6W9FpRgho=
X-Received: by 2002:a17:907:6eab:b0:ac7:9712:d11a with SMTP id
 a640c23a62f3a-ace572bd80bmr177134266b.32.1745482912754; Thu, 24 Apr 2025
 01:21:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1745323279.git.fmaurer@redhat.com> <710557cef8fb8472628862d9b65edcf7aeb32bb5.1745323279.git.fmaurer@redhat.com>
 <CAMZ6RqKcp=JNcbZjX6xSGo9Hyw=1nXbpS9Nc36xuDkbGG+=wtA@mail.gmail.com>
In-Reply-To: <CAMZ6RqKcp=JNcbZjX6xSGo9Hyw=1nXbpS9Nc36xuDkbGG+=wtA@mail.gmail.com>
From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Date: Thu, 24 Apr 2025 17:21:41 +0900
X-Gmail-Original-Message-ID: <CAMZ6RqKJd_qMEy3ohoLAXMgCq2s=AntD0VKCpVwxT1DWjd7KrQ@mail.gmail.com>
X-Gm-Features: ATxdqUFf81mWoiqNoCRhJ3HhKjTcNKKwIUAnAO_jBJPEy0HAn8kmfieQNcpj2yc
Message-ID: <CAMZ6RqKJd_qMEy3ohoLAXMgCq2s=AntD0VKCpVwxT1DWjd7KrQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] selftests: can: Document test_raw_filter test cases
To: Felix Maurer <fmaurer@redhat.com>
Cc: socketcan@hartkopp.net, mkl@pengutronix.de, shuah@kernel.org, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, linux-can@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, dcaratti@redhat.com, fstornio@redhat.com
Content-Type: text/plain; charset="UTF-8"

On Thu. 24 Apr. 2025 at 16:44, Vincent Mailhol
<mailhol.vincent@wanadoo.fr> wrote:
> On Tue. 22 Apr. 2025 at 21:03, Felix Maurer <fmaurer@redhat.com> wrote:

(...)

> > +       .exp_rxbits = (1 | 1 << (T_EFF) | 1 << (T_RTR) | 1 << (T_EFF | T_RTR)),
>                         ^                                                      ^
> Nitpick: those outermost parentheses are not needed.
>
> This took me time to process. Isn't your expression redundant? What about
>
>   .exp_rxbits = 1 | 1 << (T_EFF | T_RTR),
>
> ?
>
> This gives me the same result:
>
>   https://godbolt.org/z/cr3q5vjMr

Never mind. This was a silly comment. I messed up the operator
precedence in the above example, these are obviously different.

Please disregard my comment and sorry for the noise.

Yours sincerely,
Vincent Mailhol

