Return-Path: <linux-kselftest+bounces-3979-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A3D8846689
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Feb 2024 04:30:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CD001C26AB7
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Feb 2024 03:30:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5E57C8EA;
	Fri,  2 Feb 2024 03:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="GYF6HEZy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BCF3D313
	for <linux-kselftest@vger.kernel.org>; Fri,  2 Feb 2024 03:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706844595; cv=none; b=kmjWKNlS89ARBAWWM6RfSiLdLb1RW9tUMb3Dj7qts2ZAAw8thRbSo1K3s+OWMb39tisyo17X9ila72irIdzWymKldOcOAectnpiE9g5hJqpkM3xeepgVlwVnkBgTUhm2sZw82mPaCiI4pJaNzYktymR0S8X4ZePgH+ED+mhA5J0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706844595; c=relaxed/simple;
	bh=FQPEDa1ZpskrfIY7Nl1IZ8DX+tkOt+NBh/6iZYeP0oM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cgSEE5ejVgZ9ci6QxGzaU+y5lH8VM2/77O3R1WqI3VrcaQx+QG9+ywVAJ9fJoXi6nIMH+pSSZIXFX82vUlf3NU3xW3M8KlYDa6D52V5YvQGN9WP9hR+65X/5ihgA/ThFmMAJMCdbdAAzrZAqQ40IdIfUPj9aYnYJRsVh+MnzPR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=GYF6HEZy; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2d0512f6e32so20369861fa.1
        for <linux-kselftest@vger.kernel.org>; Thu, 01 Feb 2024 19:29:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1706844591; x=1707449391; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qJx1hqlSbD14E0hZKRTCOkIDna5e/202U5M9wYP7Mg8=;
        b=GYF6HEZyywWHVD/NrHcSgXe2eP7YL3/Mk+MWgzmCPxb+uJqvcLmwXWazeguLwP64zX
         LxCYJxcENb+nVIZLU/3WlzkLJD7wNpp1NM3YMCpa0itovzhmt38yTvCp1ODkJzaX1qWL
         yaiJDf5UZxhPvB0E7xLcG649oG49FrLlKJtms=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706844591; x=1707449391;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qJx1hqlSbD14E0hZKRTCOkIDna5e/202U5M9wYP7Mg8=;
        b=a/LqvMq9NtCx0FxZIPHExWb+wZv/yybxIKTLRCXq3o4vWRWoF1ryckLdTU2bx4PYba
         BchmpfoHS+vlGxTmTr7FL2VYJqsNpAWoJ46mHxhjiK8uFPz8QtmPlBjL8NR2VvPT9qFa
         ZbEcbbWOD4l8rQ7dSamPlWoGI0D1Gime2B1OWPja0hhbfYD5TLWnu+msglS59IRO+BlE
         4c0tLnAX5z9d4umUX7CXAek2SV+sa0r2n/0/irZXJ4garmbZpaRgloA6WWsqD784G75N
         45v92k1xXMW2iOb3lxgURDLyNF4mrjML7QIc0n7r44mem+mb56u5JqqCq0OEfHwzPC7j
         rGGQ==
X-Gm-Message-State: AOJu0YyjcIYFEO2/cc/qUyjvgf7kT3ouN1y3U+B27gCy1sRqDopt7o6K
	YYclki0s/AHvE1iiLF1nKWJUO0+kLLq/4e35IqdoRKXn4XaoLvwhJ+Z8FVrwd8BWBiHqyy7R36s
	iX5kGsQ==
X-Google-Smtp-Source: AGHT+IFDRBMfDjHz/s5ay3jmnT2JwgJ5f/DfR/z31AVVkmVnzW98hyRUvTCNvf/zEIB/uq07S7J0Vg==
X-Received: by 2002:a2e:be0a:0:b0:2d0:8864:33fb with SMTP id z10-20020a2ebe0a000000b002d0886433fbmr140490ljq.6.1706844591501;
        Thu, 01 Feb 2024 19:29:51 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCW6J4Y6gPiNu5/ay+b9xaRmQM2iqBpaunq6mwJI8ezG3p4Qbsn38PrtA68dl/VTxwDsLKRUDhW4HRqkIixu9eYWt5CwL7IHiUl8ZIv48MRA
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id f6-20020a05651c02c600b002cd38676699sm120684ljo.66.2024.02.01.19.29.51
        for <linux-kselftest@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Feb 2024 19:29:51 -0800 (PST)
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5111f40b8beso2000125e87.2
        for <linux-kselftest@vger.kernel.org>; Thu, 01 Feb 2024 19:29:51 -0800 (PST)
X-Received: by 2002:a05:651c:1249:b0:2d0:87ea:a132 with SMTP id
 h9-20020a05651c124900b002d087eaa132mr159099ljh.27.1706844590714; Thu, 01 Feb
 2024 19:29:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240131175027.3287009-1-jeffxu@chromium.org> <20240131193411.opisg5yoyxkwoyil@revolver>
 <CABi2SkXOX4SRMs0y8FYccoj+XrEiPCJk2seqT+sgO7Na7NWwLg@mail.gmail.com>
 <20240201204512.ht3e33yj77kkxi4q@revolver> <60731.1706826280@cvs.openbsd.org>
 <2024020137-hacking-tightwad-a485@gregkh> <CABi2SkVb1goM95FT5v2K18NHbaLitLpK6fL+wE6Y47z8yvW0Nw@mail.gmail.com>
In-Reply-To: <CABi2SkVb1goM95FT5v2K18NHbaLitLpK6fL+wE6Y47z8yvW0Nw@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 1 Feb 2024 19:29:33 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjGGgfAoiEdPqLdib7VvQgG7uVXpTPzJ9jTW0HesRpPwQ@mail.gmail.com>
Message-ID: <CAHk-=wjGGgfAoiEdPqLdib7VvQgG7uVXpTPzJ9jTW0HesRpPwQ@mail.gmail.com>
Subject: Re: [PATCH v8 0/4] Introduce mseal
To: Jeff Xu <jeffxu@chromium.org>
Cc: Greg KH <gregkh@linuxfoundation.org>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Jonathan Corbet <corbet@lwn.net>, akpm@linux-foundation.org, keescook@chromium.org, 
	jannh@google.com, sroettger@google.com, willy@infradead.org, 
	usama.anjum@collabora.com, rdunlap@infradead.org, jeffxu@google.com, 
	jorgelo@chromium.org, groeck@chromium.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, pedro.falcato@gmail.com, 
	dave.hansen@intel.com, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 1 Feb 2024 at 19:24, Jeff Xu <jeffxu@chromium.org> wrote:
>
> The patch Stephan developed was based on V1 of the patch, IIRC, which
> is really ancient, and it is not based on MAP_SEALABLE, which is a
> more recent development entirely from me.

So the problem with this whole patch series from the very beginning
was that it was very specialized, and COMPLETELY OVER-ENGINEERED.

It got simpler at one point. And then you started adding these
features that have absolutely no reason for them. Again.

It's frustrating. And it's not making it more likely to be ever merged.

               Linus

