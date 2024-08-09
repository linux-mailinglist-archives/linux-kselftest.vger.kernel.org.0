Return-Path: <linux-kselftest+bounces-15085-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4619694D549
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Aug 2024 19:18:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 779461C20945
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Aug 2024 17:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC6E41BC20;
	Fri,  9 Aug 2024 17:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FrJYO4Vm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF5E18030
	for <linux-kselftest@vger.kernel.org>; Fri,  9 Aug 2024 17:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723223931; cv=none; b=B8XdgTNz2Ulq4qL2+YxLvhqs84ktYcYNXoiQ8Yb9WMvOyQPT83/UFXCLf3k8amHmBzsnmLjodqdu/eydGjs0LEG6QnE2JqJtn1fLkgIoARCIr0qZpX55bVd3FEUhFjEtFtpNYj9O/O3VPQ1vkHAkYwjC5lBgkUz2y0kpcuGYxT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723223931; c=relaxed/simple;
	bh=eU/V0WG3k7qvYCKI9Pz0CIdZzILsRISdxx5cs6w+h5E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m+S2/6vrKY3uInxouFDe0gmX/4nplS6WFfpB9c4hFOMQjx09jADkXjJDGODlM8U/Df6JxWtj8GUwiXfG0FtHR931o4yTl03A+mEprvFVDPtoYXEtLXEIOGrKcUSPUCF4ygIRisadi1lBUXua6aNfTNR4jc7nVt27M4c01UY3iH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FrJYO4Vm; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2cb4c4de4cbso1762246a91.1
        for <linux-kselftest@vger.kernel.org>; Fri, 09 Aug 2024 10:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723223930; x=1723828730; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mQNv6RHAL17UVFT6ewQCSeThwMwGPvy4IlOPl0gqsAs=;
        b=FrJYO4Vm9hAaQCuup6HhWkAIoqNAUkCr629i6MtEZrIxHd5engGf/qZyUuevT7hyUu
         uhn67d4uYikAY2vuTFtshfsXkdd4JSzwb4RYaaeKh2FvUPWE7WJM41QGBuX7exxYYlsJ
         D2gPfTLuOLZVMl3JEVz/OHGOogC9cFGW1S0wycS3QWV2UsB14ALAcQPTrY4D56RECwwu
         CX4T/zqtJyHYoVpC7qFCd0k8HH3dH3TvTF56p6eMt3wdaBF5WgQhJeypEO1p9OMKbppy
         UpWxMz6fKRKPbHJbFHMHPJWevQvxSLXOFe0R9Ao3XD1Tj200kKnbbupoU6+b9x1tJlxo
         NPKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723223930; x=1723828730;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mQNv6RHAL17UVFT6ewQCSeThwMwGPvy4IlOPl0gqsAs=;
        b=EROen8T5/WlIbam8c5u97tNfDFzDEFYp8Qt/iTcZAM7hCykag6q6vt/Tk2vCwnsxFU
         TFbsip4XozicehGw098UkuRfdSRGEQsf1Uy1oiNXGCmmlNgBud3vrmjKwpubPoZF1SBH
         n4ZUN8epl9yoH1+gLN66n15//cCT1bDnOoDXzu7LMA/dVzikPAaQAbB+mk9bG0Njo54E
         W1bmkuSSvMV7NOIUUaUQtZlD0cX+mDuUl0LnLj0nf4TPuBWW/eKXumWzukXmYQrJMp7B
         sLgN2duExulv4IFTSrz8BKMZTzCn22DykSu3gmNyFQclrGLtL8TQ6zfP2OKUHjDMzeHe
         ZCHw==
X-Forwarded-Encrypted: i=1; AJvYcCU1LBp0+tovvbqed7TjlXhS40lYdmrnuoW5HO72052gf0oOlWBVmFdAIqD32uwTYO1/o3J74ZBGZ0uzYKUR0yl7PtcYTeDG6lThYj/Ck0/y
X-Gm-Message-State: AOJu0YxGT9Q8cVKjT54IQxxcXOjoZHC/p/NDXZamt8B9JWegH0NfB4Ws
	sH/WaI8caieR2qtkyZjv9PP3FoCAUBrBc0JlOr4EjrTurhlz35NkqvAqiEsBoRZrniliKmq7JVD
	lyE4toZUmO/9z+wvBqAWAFrYyNNY=
X-Google-Smtp-Source: AGHT+IH80LnmlNDqfhP7GIdmEETW8k6LzeVRl8YxNKVfIGSnbo1pE9qllqMg/A6v5klL3U/S4YSSVRRVVkG3SUye2Fo=
X-Received: by 2002:a17:90a:a783:b0:2c9:7cf1:83a4 with SMTP id
 98e67ed59e1d1-2d1e7ff7361mr2272059a91.20.1723223929830; Fri, 09 Aug 2024
 10:18:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <a5914541-be28-4232-99f4-7bb856e13c0f@stanley.mountain>
In-Reply-To: <a5914541-be28-4232-99f4-7bb856e13c0f@stanley.mountain>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 9 Aug 2024 10:18:37 -0700
Message-ID: <CAEf4BzYyRyhZ6r=tU+kPYx1zOL=SibvYXGFapP0B_kZpD_E9uA@mail.gmail.com>
Subject: Re: [bug report] selftests/bpf: add trusted global subprog arg tests
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Andrii Nakryiko <andrii@kernel.org>, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 9, 2024 at 4:32=E2=80=AFAM Dan Carpenter <dan.carpenter@linaro.=
org> wrote:
>
> Hello Andrii Nakryiko,
>
> This is a semi-automatic email about new static checker warnings.
>
> Commit c381203eadb7 ("selftests/bpf: add trusted global subprog arg
> tests") from Jan 29, 2024, leads to the following Smatch complaint:
>
>     ./tools/testing/selftests/bpf/progs/verifier_global_ptr_args.c:88 tru=
sted_task_arg_nonnull_fail2()
>     warn: variable dereferenced before check 'nullable' (see line 86)
>
> ./tools/testing/selftests/bpf/progs/verifier_global_ptr_args.c
>     85           /* should fail, PTR_TO_BTF_ID_OR_NULL */
>     86          res =3D subprog_trusted_task_nonnull(nullable);
>                                                    ^^^^^^^^
> This is dereferenced

this is intentional, it's testing that verifier will catch this mistake

>
>     87
>     88          if (nullable)
>                     ^^^^^^^^
> NULL check is too late
>
>     89                  bpf_task_release(nullable);
>     90
>
> regards,
> dan carpenter

