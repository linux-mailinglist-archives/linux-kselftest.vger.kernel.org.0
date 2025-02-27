Return-Path: <linux-kselftest+bounces-27801-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 415FEA48A68
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Feb 2025 22:25:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 313BB3B61FB
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Feb 2025 21:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76682270EDE;
	Thu, 27 Feb 2025 21:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YSr4jJsr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E14A426F460
	for <linux-kselftest@vger.kernel.org>; Thu, 27 Feb 2025 21:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740691513; cv=none; b=G3SqkG8ubQQo1rgbaIzB2PhbNXcN8JJ8HD3aoI7DZ4npDzQIBfG98C/HHO1q6VwUT1IkWmV6cfKANlcuqbqRmKeBGtIoMQAEaWmF6oCUffDkKpVrySwG9TbPKSZNb8tAdNkHobvCIaPx6qEMHex2PY/rboLLPnoxIok9E10l4m0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740691513; c=relaxed/simple;
	bh=lzJuj68IPYELNEwepv8cKovi68A07a9ryFLZ7YUT620=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZaWxOENVMGTiZmoWR+Goevjm0R49VSlJuXxUjKNcmGlMkk2aNgDdAQPywsNABqV79I3GawXnCWS/yUBhw9i5lYMClf8MPbd6C4U66BszsmjToda0wdux5OIQTz7Vwxxq3IbWsvqFhMpGNi5uPIa6DH7cgi6YHjQCzW8Vo/Rk4TA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YSr4jJsr; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2feae68f835so1519257a91.2
        for <linux-kselftest@vger.kernel.org>; Thu, 27 Feb 2025 13:25:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740691511; x=1741296311; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LPasBJtfA1A6r+ygxWij1B6VOAarT8bcVJ1UsJBCOVA=;
        b=YSr4jJsr8f6wYqWFiRV9qNusW9GB8PWYQ5IN2Ei6+3NEAcV/xNUyfZ5V5S/9neJUSp
         TjTkexNn7u8LfMK79w8CnYZH8pBQNvC//R5ZYg2PUvGxZUHswPJz3CaTRjX1PNtn4SWn
         WlocuQq+svWCNk1QU14FCUO90LACbM1RYN45+jcusYPFcnCS1eVQJtP7y+9wS3TimkiG
         Z9rQJn3WvFYy6tFUe+DNAfLiHXVe15NU51mwUPRNwdbv9sY+DULQ3V2lyVnGcu4n7sFB
         NIx1alDu0ex7/COJwyOLF09e/k38fX2ZVDvcaDMkUxX+RzFjXHP5dhb66Y9M8RAi3STL
         FZqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740691511; x=1741296311;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LPasBJtfA1A6r+ygxWij1B6VOAarT8bcVJ1UsJBCOVA=;
        b=jJdN1B8wHoMBucdqwjl2LhbEABEf3ZcYcayb3g9n80hM4MPpkBXZGLRf8yNOhA1MzJ
         AlWcxvEJt3SuiTuGVRR8RD7hqyi3CWDXdYEQa4B8nbntjEUTkoMDy4a5lAAdrBkoHz/h
         8v9pzPWrtVp4bCpU0AMvVuHnsNaMUU+kwgI6F7/dyZItNMRV7Clld6eLsgMbaFgYWUXD
         b/dy7eYclXFykC+pqcCyGYKTIvRMhfmAbB8XgM8A54bT6ocfB5LIk25AljOt9Id1D4N8
         X7YdXOqzCCo80r2sTksJqEmC0YXyRA2niF/jmvMP0ui2Ekg3sW7Hf0u/dSX3UpGiW18m
         dmUw==
X-Forwarded-Encrypted: i=1; AJvYcCUJKbDNXiNfl/TA19Zq2mqL+LdqxGSA1iZcdP6mbKj7Bu7MwDLzOi4v742J4PuYZjYoatKq5ZU2u8maSy95Mrw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzItKN/AyxgLM/H8XNvcZJrzdG3m/lgxSFcBpfQ3XWvGPdwu/ln
	65ibyztih+aTAe7NQ8/84JR2BC/z9SJpOHmpi4i8bRK8wXb781LxvPEDsOVH
X-Gm-Gg: ASbGncvWNJRU+w9EuU9WlWpu37u3bLL7HqHXUhpg5+HnzIx12jEd2UeDZ+wpQL07Y8s
	AQS366D/esKMHsqTAm27LJ2ggu7hOVvqYWjdhyuhWPdBOXaKQrCKU191duNYU51N1F35TpjaFBY
	nGXiXDskQB707jxLARFqfxQTR3RGnvJvDzJzH9hCvxgYXOsMXwJPraBD9A15GxCPlOTquncXnky
	+5Xsm82m1kdFCqgfz0iLx8M2rsIu0EChXx4uRazaQlKpGtFOsXoNTBmhGgn+aq6XPDkcohEojaW
	UeN4gQbslK3O/Vzvl/1Zvh2akx1fRxfO1StGCO7VEDl7mKs9ImTcZhg1ug==
X-Google-Smtp-Source: AGHT+IGBHq1s0yxlGfMCWYPgfiqJIRDa3hS7rAXHcG6G6Vcvw1+v3Kh3nPvhIl0+ny6yu9e75zJzBw==
X-Received: by 2002:a17:90b:3803:b0:2fa:20f4:d277 with SMTP id 98e67ed59e1d1-2febabf1a7emr1399582a91.24.1740691510953;
        Thu, 27 Feb 2025 13:25:10 -0800 (PST)
Received: from google.com ([2a00:79e0:2e52:7:8e35:ae3c:1dad:1945])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fe825a98d8sm4299464a91.8.2025.02.27.13.25.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 13:25:10 -0800 (PST)
Date: Thu, 27 Feb 2025 13:25:04 -0800
From: Kevin Krakauer <krakauer@google.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] selftests/net: have `gro.sh -t` return a correct
 exit code
Message-ID: <Z8DYMBlzcK5sFG-M@google.com>
References: <20250226192725.621969-1-krakauer@google.com>
 <20250226192725.621969-2-krakauer@google.com>
 <67c090bf9db73_37f929294ec@willemb.c.googlers.com.notmuch>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67c090bf9db73_37f929294ec@willemb.c.googlers.com.notmuch>

On Thu, Feb 27, 2025 at 11:20:15AM -0500, Willem de Bruijn wrote:
> > ---
> >  tools/testing/selftests/net/gro.sh | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/tools/testing/selftests/net/gro.sh b/tools/testing/selftests/net/gro.sh
> > index 02c21ff4ca81..aabd6e5480b8 100755
> > --- a/tools/testing/selftests/net/gro.sh
> > +++ b/tools/testing/selftests/net/gro.sh
> > @@ -100,5 +100,6 @@ trap cleanup EXIT
> >  if [[ "${test}" == "all" ]]; then
> >    run_all_tests
> >  else
> > -  run_test "${proto}" "${test}"
> > +  exit_code=$(run_test "${proto}" "${test}")
> > +  exit $exit_code
> >  fi;
> 
> This is due to run_test ending with echo ${exit_code}, which itself
> always succeeds. Rather than the actual exit_code of the process it
> ran, right?
> 
> It looks a bit odd, but this is always how run_all_tests uses
> run_test.

Yep. I could change this to use exit codes and $? if that's desirable,
but IME using echo to return is fairly common.

