Return-Path: <linux-kselftest+bounces-16687-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ECCE9648A0
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Aug 2024 16:36:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC6381F280F1
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Aug 2024 14:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB6E01B0118;
	Thu, 29 Aug 2024 14:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XwG9lJaq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 650F01991B5
	for <linux-kselftest@vger.kernel.org>; Thu, 29 Aug 2024 14:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724942187; cv=none; b=sRtWHKAb0BtgbC4TP6nqw7vzEYWZWf3Wpuh3eSaXHSr+IAsv9GwiXJn4rlM2EzeYBgd8jZB9DGjmdc/2BTJhnPbOU2AjABC45m9YRUoBExRz01g1g6gxCk4kShAFBbDQPLduZy/dIIVr6rHpsy0AmGRRj5jDy4gFoeDXwyDJ+Lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724942187; c=relaxed/simple;
	bh=nulYTML2CQN3srodtgPbbRw5PaE2zNCVZgQPtBVymog=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=oIpl4/3x9l2A9gedBSMWvnr0NtMH1PJvtHcMPN3MHMAUQoQ9lLlPa/ET768CxgjMbXOalutlQSL7wK9yAIMlkDyamD9T/GQ8N/yAJSCAdkLKshQJXi8TwRydgfJg1wiMd3F80gxGzV1u+RQlq69cmTnY3MCDNuHdVgAaFHgWFOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=XwG9lJaq; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-26ffc596adaso77349fac.1
        for <linux-kselftest@vger.kernel.org>; Thu, 29 Aug 2024 07:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1724942185; x=1725546985; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nulYTML2CQN3srodtgPbbRw5PaE2zNCVZgQPtBVymog=;
        b=XwG9lJaqRcr7jIRZ74oMj9ZhZcABWBvyhJNpHpVJiO6ICkd7FKlDllrF7mJKIrY/x3
         4GRcMKsdOsuPiTk85TBeaWquMVtbzjkNiBpxwP+ZBUKt3bay/ci8AnRG1NEdgB0ykbjI
         XyfzJPTXmedajXF3fOsZ3KUoBCyhh8sMQI6+g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724942185; x=1725546985;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nulYTML2CQN3srodtgPbbRw5PaE2zNCVZgQPtBVymog=;
        b=AprgHrc366QTrLKxLoDE7WVZphLOFiXnzuZUElmJPSoRbgftYIPHfkWQ9Rb8euxGjs
         TS9kfleNazObUa4e9xKkJ5G6K55EXGvbqRsZ9e76HAd0q3tg0IJx/9uNBDmzembcdHXV
         BjJv8DFBfoDU86V1AnxFvTdoxBNose1Ig0qAq66+tALAIKuEUUHq2GhOijfTFq0Aaccg
         8xahFNUGgapjXX7kO1QaX1kHTWLg2GevMhQ+6QYv5JIKPcfc4FS78sAAqfjNC9WtY9y+
         4DWnklwUJycv6j7qzMeqxrCKTqUUHRzMvP+TEFco1+WQp4EGBzKrNfnPZtKd2MI1cZrd
         BZ1g==
X-Forwarded-Encrypted: i=1; AJvYcCUxeHb2el0ctJZLjN0dNPb2qYpZOs2GHQ0cU7+2sivdo7uj7spFMSVT46xQ0Ehv6cfIdtghAxFkCbtJs9f4Jbg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjPDgLTZFjpBv/c8uf50bAr2E7btJS/psleO1YQ/Hql+zo/c8o
	c/yktsOr7UYGArfbFeHoGHYCt59hAYK52V/YxwzHRioVlt+W3dLMGdcN7k43tQ1G5H3wQWI0Dxq
	ZxfIIgCUdMJ0+raNPt4UZTnr/+cZAY5yLRY9P
X-Google-Smtp-Source: AGHT+IFIGinZlY9HQPgLeWEPBjUQ0cUjWD7+XFfmJV7NnhhPhUf59zXN8PcA7MV/PdklBJuNqmJs0Hf+c6WnPDFNyY4=
X-Received: by 2002:a05:6870:548a:b0:260:f1c4:2fdd with SMTP id
 586e51a60fabf-277903b9f7bmr1468497fac.10.1724942185340; Thu, 29 Aug 2024
 07:36:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240828225522.684774-1-jeffxu@chromium.org> <jxov546uro5lffibw5asff3m25pfnondbp3nrqc3fde322h3on@ypkdkju4xaho>
 <vyllxuh5xbqmaoyl2mselebij5ox7cseekjcvl5gmzoxxwd2he@hxi4mpjanxzt>
In-Reply-To: <vyllxuh5xbqmaoyl2mselebij5ox7cseekjcvl5gmzoxxwd2he@hxi4mpjanxzt>
From: Jeff Xu <jeffxu@chromium.org>
Date: Thu, 29 Aug 2024 07:36:13 -0700
Message-ID: <CABi2SkXg3WBsDpTnYmG+Dj8m6-rSoL=FW8cBVrfvk=qwdMM4zw@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] mseal: fix mmap(FIXED) error code.
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, Pedro Falcato <pedro.falcato@gmail.com>, 
	jeffxu@chromium.org, akpm@linux-foundation.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-hardening@vger.kernel.org, rientjes@google.com, keescook@chromium.org, 
	vbabka@suse.cz, lorenzo.stoakes@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 29, 2024 at 7:03=E2=80=AFAM Liam R. Howlett <Liam.Howlett@oracl=
e.com> wrote:
>
> I will fix this in my series, thanks Jeff.
>
Sure.

-Jeff

> Regards,
> Liam

