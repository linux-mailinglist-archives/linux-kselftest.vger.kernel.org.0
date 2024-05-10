Return-Path: <linux-kselftest+bounces-10021-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC75A8C297E
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 May 2024 19:45:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76CD72830DB
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 May 2024 17:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D0901BF3A;
	Fri, 10 May 2024 17:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jfuFEdBq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9837518EA2
	for <linux-kselftest@vger.kernel.org>; Fri, 10 May 2024 17:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715363104; cv=none; b=biTeRX/5kaPZLjIYdjIpRLQgvmFqb/R6tVySU4+BnEgnGb5g6Y/Ydm5y491qIeNHrnver0Nt5UZGy1W+M3dObNMZseBsYC3tg0P59yqHb+98mN6L0eXhS+UD+r0t3vES94lPk+0wx1qfmOV6JbdcXaUFIxKQV4yNBW02XCwHXKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715363104; c=relaxed/simple;
	bh=77jCAZN4T1MnK/eg9Dn9s0HYNi5Gbz3bp+wgywtPJ8U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mATYWjhn1HZLsFGEPfxhCBU6MdGbfcOMl8o7zlaC9Gx3ka2x9nnzsghFmi50oGzOSmYm6WLt6mvGcBBtBo0sLQWy8JusvjM949wYO0B/9zrVBdj62NZZqmwSTE5TtIZnSPg1GHV5R0nVhVIE2B7EpJ1fVKS2SNf0pUuk8vJgiaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=jfuFEdBq; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6f44ed6e82fso2050125b3a.3
        for <linux-kselftest@vger.kernel.org>; Fri, 10 May 2024 10:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715363103; x=1715967903; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RH25751FQUD9IraRYi3Ng4hTjnmqYgAtJrim8UnR4Lw=;
        b=jfuFEdBq40eHLbgJonwdgyHWGexUVHfl/U2WW3h9qOJOjLZNjcnA4rmlz3LsW3PY9l
         lLHdaQ/U7kZ89eZzT6755BvDnteknBtwwOq7Ax64FoSWW4B+//LtSTSThtqsdIR8FVtB
         2SCa3WkY0z3T2hVv21Ck9YMQUsl+7up5H4s4k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715363103; x=1715967903;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RH25751FQUD9IraRYi3Ng4hTjnmqYgAtJrim8UnR4Lw=;
        b=RKRcE5jfTA8S4Zs3yozXfgj5Jme8yaDVUeGsS7gckcGdqVvzt4jJl2i8k5hXlupqyS
         qx1dkTGH7Ceu+fM+OL7wFK2cFIjdnMh58mO/DqLcmSH9fZTTJwyejeYuIpzb6axrPgvc
         iERD3M6/L6lN7yxV6qxgglc6iNbgIyU3pKiD6DUA+vugUtctqdj1pIXQBjE+xRfSm9/R
         VnM0eEsSfvbUE0eE/2oGzba2Esu6zKIh0qcT540j7swTV0TOldvSQfPfgEtPBFRQcO68
         iX0YoL886FVZl2kWw8soufe2j3mK1R+gYdWMn6ml6/o6SgrJA7u1lf1MZ+RJaPkq9aEf
         1wUQ==
X-Forwarded-Encrypted: i=1; AJvYcCX3VntkUnO3TiHeirat2Tf8MdrVbq1EvxnGjDvzTCIw5tMAFpAC+dnuR4cS97hKXf9KRbNbD55KBX8YZFCEYtJ8ZS8hPu9MmT9LsUdocGUo
X-Gm-Message-State: AOJu0YxhlNZEg6bO9dxJMNjOW/+9YBvWcRaejcXs2YyElCrpxwEmJ+1n
	2EZRWiqBLLjBHTaRR3jjlqah4ufosjK0po6q6cVZBsRI1z4X7Qv2zUQcH7pPeg==
X-Google-Smtp-Source: AGHT+IGGFWmKinmr/BozpgZxQxrIJHVGNpMfgrtBUBSomrJR7j5qbTiNJokxk2pPxp48vFhrBfY0LA==
X-Received: by 2002:a05:6a21:3405:b0:1a8:e79a:2b0a with SMTP id adf61e73a8af0-1afddf036eemr3785881637.0.1715363103156;
        Fri, 10 May 2024 10:45:03 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6341134706asm2937275a12.86.2024.05.10.10.45.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 May 2024 10:45:02 -0700 (PDT)
Date: Fri, 10 May 2024 10:45:02 -0700
From: Kees Cook <keescook@chromium.org>
To: Edward Liaw <edliaw@google.com>
Cc: shuah@kernel.org, =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
	=?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
	Christian Brauner <brauner@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Andy Lutomirski <luto@amacapital.net>,
	Will Drewry <wad@chromium.org>, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, kernel-team@android.com,
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org,
	linux-riscv@lists.infradead.org, bpf@vger.kernel.org,
	John Hubbard <jhubbard@nvidia.com>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>
Subject: Re: [PATCH v4 55/66] selftests/seccomp: Drop define _GNU_SOURCE
Message-ID: <202405101044.DB260BB@keescook>
References: <20240510000842.410729-1-edliaw@google.com>
 <20240510000842.410729-56-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240510000842.410729-56-edliaw@google.com>

On Fri, May 10, 2024 at 12:07:12AM +0000, Edward Liaw wrote:
> _GNU_SOURCE is provided by lib.mk, so it should be dropped to prevent
> redefinition warnings.
> 
> Reviewed-by: John Hubbard <jhubbard@nvidia.com>
> Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> Signed-off-by: Edward Liaw <edliaw@google.com>

Acked-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

