Return-Path: <linux-kselftest+bounces-32276-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72827AA81E6
	for <lists+linux-kselftest@lfdr.de>; Sat,  3 May 2025 20:16:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D494E17C00D
	for <lists+linux-kselftest@lfdr.de>; Sat,  3 May 2025 18:16:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 555781DC998;
	Sat,  3 May 2025 18:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TkFfOwxi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D216E27E7D0;
	Sat,  3 May 2025 18:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746296203; cv=none; b=NXxs2Wv4GY06b/90OkMQUTrglHJsc8tVrIUiBQV1XS1ml1kGnLV/o2ArbqyaHUBd1wvkoy6bTGIIr7xjm70e1b+tipOklJjR0V2eCKiqKHFb8KcF1VZb2b045bQSPAids8dlaV1u3sC5DlZcaqhRnLlQUy/bvdUSW9ArD08wpkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746296203; c=relaxed/simple;
	bh=VtHQlaNPowPrjenRttkbRhF1+Y7CRiRxicklRpQMALM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WkcHLNrrj218bMAVtEs61FQAMbsa4RAD/DsPti+7WUleL8tDhCCZjGk3Xtm3LKQBRb3HSOqMrrFg/+6EjvzEb9B361Wk4wStDHlEpEQ9QlwSACoJ8fnnGZR8z1QVX0heJC/7DfUjoyU/WZu0bW7joy2IlUkvseaJsBZz1YY37jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TkFfOwxi; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2ff6e91cff5so3007503a91.2;
        Sat, 03 May 2025 11:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746296200; x=1746901000; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VtHQlaNPowPrjenRttkbRhF1+Y7CRiRxicklRpQMALM=;
        b=TkFfOwxifsOobNnIt/CAu3HIe6COxdcA2SRgiJh1Scq3nGe5C/VcpfdYO2UFZYiJsf
         LPeimwiaJQra0421rjUWZMKcZP6jkCN2/JZwGoJg2CXhCjZRyV2adzf2Z4H4IXYsuxbF
         rvQz/kZK/uzZXxmWEfdfesaSfyxSupFdKGmf7o5dz4O2hE1N7E/xwK2ig/v0gyyXgzAo
         ugXFTogIHuJPGuvgQwBfXN/2lKHQckytWI6CmCM3WpUWXf8dAV4gXsP7FzZsUN0i2hSW
         sc5WosYdYWM26gNYDB4I1itrpLNbCFuW+P9VeljlVcZ+rE0FPoIPal886PAEj1pbIA8m
         OeNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746296200; x=1746901000;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VtHQlaNPowPrjenRttkbRhF1+Y7CRiRxicklRpQMALM=;
        b=ZoPQ7H/k2rtIi5+xebRh6wzKHEoQXlPhfriHmasQkjISusECyaqNiI5gUihV0HFqXO
         zTOr3/MY3jI8YGHMo8LKJpgIRfhEzs+iS6M21yHfAbJcAZ8kP4nWhA5Yais/0LFUOCDT
         LLLurcb+fYKX69j9hm8FzANnfhx5thjgMW5yA1n76DKdX4tg52snE3maSsDtn1ytqtTL
         kZ0QqDoDKMr8az3J88UgzMsJD+zuQkGwjdfOvppGwd6V6M4qvDbWz5BGxFJXzgEW1mBQ
         HZSU0Jfg0x4KgljisZ5r+iTWzl+Uid+8pqerZXMLM/ac2gW8zAbjzxV6FsjKtDiwsu9N
         lElg==
X-Forwarded-Encrypted: i=1; AJvYcCUZcB0LYeAD/4tbepfTNU4O/lUj5JdxZFcFhVWwOIXHPg6218HhmjGX2SbeN6mMjakgUQJVYRLa1o27v7xdC/Mu@vger.kernel.org, AJvYcCX4Zko5jQWyfn/R9lWdTkgzg9WIolkzHKY4S7EBUJ6J2X3L61q9DlUC67EgkPQMWz4/uM8kVjm7GddnG+s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgXoD5P08GxP003qpxvuzoiVKo1HCWiR6/TT0xrzeS3RfxVPNM
	+TykaK3e1Rzqy3z2uizjWFtIwYYSMMp4MF5C+nuwv0PKSloqzAfXqO2BruGNppErsZ7GGECJZcZ
	Xr8lzIj07gwYRupTw48u6JSrMjw==
X-Gm-Gg: ASbGnctJ7t639bsnAzqtqF+4v3M3lkvt+4Xiiw5B/RDs+kZ/ifEqya3o4IAk8vJc2H9
	CfKF0RaqfbInzvDb2Tp44/emBysap3mWWpuMcIx+is5avvewx67rwWKWSqWLard3HYY7Eo7dHGb
	8wF8E8WOp+1kn1hyppykj8hg==
X-Google-Smtp-Source: AGHT+IHKsbCVi7HNnXXdlqdZjUr5DzRbIPrcHgFYMd4daXYxhrfynkAGlvyPIpnO+hHOAELtmlLVU9ygkbTMS+eyNcA=
X-Received: by 2002:a17:90b:1f84:b0:2ff:62f8:9a12 with SMTP id
 98e67ed59e1d1-30a61a2be01mr1983770a91.23.1746296199869; Sat, 03 May 2025
 11:16:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250501163827.2598-1-ujwal.kundur@gmail.com> <20250501163827.2598-2-ujwal.kundur@gmail.com>
 <D9LO1QI65D6K.NLDZ4RK2835Y@google.com> <CA+i-1C1x2TenH-WxkUnkx3-5XpkXOMMmZQTCBV3sHDV8WWN=oA@mail.gmail.com>
In-Reply-To: <CA+i-1C1x2TenH-WxkUnkx3-5XpkXOMMmZQTCBV3sHDV8WWN=oA@mail.gmail.com>
From: Ujwal Kundur <ujwal.kundur@gmail.com>
Date: Sat, 3 May 2025 23:46:26 +0530
X-Gm-Features: ATxdqUEF5U0na-NaAHmxH75iMW2eHSbW97C7umQp2QWaCy32V1BUA1KDKLjKI0w
Message-ID: <CALkFLLJ4CYRFuyR8sHi5Ah06QD_fDuF9v5eCyG7Xh+2kHPVzEg@mail.gmail.com>
Subject: Re: [PATCH 1/4] selftests/mm/uffd: Refactor non-composite global vars
 into struct
To: Brendan Jackman <jackmanb@google.com>
Cc: akpm@linux-foundation.org, peterx@redhat.com, shuah@kernel.org, 
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Thanks for the review and testing!

I'll push a V2 with the indentation fixes soon.

> this deletes the global vars before it deletes
> the references to them. That's gonna be a real pain for bisections,
> please can you restructure the series to prevent intervening build
> failures?
> (i.e. if I apply just 1/4, the selftests don't compile).

Could you help me understand this better? The selftests don't compile
either way if both 1 and 2/3/4 aren't applied at the same time.

--- Ujwal.

