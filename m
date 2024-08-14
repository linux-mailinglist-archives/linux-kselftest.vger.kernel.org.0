Return-Path: <linux-kselftest+bounces-15331-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BC500951F71
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Aug 2024 18:07:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64DEC1F2287C
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Aug 2024 16:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A2401B86C1;
	Wed, 14 Aug 2024 16:07:53 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F06028DC3;
	Wed, 14 Aug 2024 16:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723651673; cv=none; b=JBQ7UdKc00RVRH4s452IHHIY3B3bvlPkokPgvMvr0u8CZXzBO7j7WTZmVnw6WScvE7nB9SrnSIfwjMehvgvqYDFYGa4367r/64otOVLJ8DWHuIfm6Fz1HZtVM6wzuthUkfmgMFv7Fs/EJXKuEKirgBaeydluKcObAhAkBa6obNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723651673; c=relaxed/simple;
	bh=vRqPIkdIHBdVxzhU5h0+EbYULZKLvrrnreeIG3lYDCU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NeHzi+8+Ehye5SyzfXmALPihRHzYtpc8S/4L/1HngDjOnK9tL+oUTG0/Lj140NE5TfotVhOwshBABXQ46sur05zv40NGFDzjyTBA+0488VqYEO3XZLojGNq3Mo6BUxKbLUxppEHgdcNIiY5KOgwj/usHQUBMySq2u8G6d+40kTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5b8c2a611adso119302a12.1;
        Wed, 14 Aug 2024 09:07:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723651670; x=1724256470;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/D24Yl42RVGhmCxoQ5g0FIFfYf6T2QUPv5Ei3NAhCks=;
        b=hktxFfGogGRqOavB+GgPoODpKgRnuXOyx4SM2e1Yjgr3iL2I6o0DEOuE4P6gZv7/2B
         OPCDXoLkLisBABorzEDzBLfo0Y351r9H+o3HuFMqFoxBUdmynamnKvNybU+bvUIE2dCF
         D/APQ5/rtn+QoTiAsMLkv7TxehKPI1t5mBSiEPSo4lN1asMrwCihtIlJ4ZaZDMrs9qXA
         yyZiDUhRJo3p9MhgNGUwLBDiqRDMpNFoUf/Vd+8Cw7Q93UxtbGWhSuD72+yntBNxbyFo
         uFnGM80hQ0akc9YONkXrDF4IFXQ8cK1dG+BTX69QTqfsb5u4zN6YpTp8nHyPy+FIe4wK
         I9wg==
X-Forwarded-Encrypted: i=1; AJvYcCXVXJZfvfvsHCw7wTdH3LuwXGpziXtkDPkV88dskeDYk8bxqWUFBnX+ieY2BfypSZe3jc46Nkjo2qs8oIcDbH5pdt7YYyLfgvxFkO62NPwb+SPqVHARRsBtTOte0Qf8hvYCybhKDJa5pEvjLvmbi/DrGwYYL91f7kHUV8uCeGPiW3lUKrnX
X-Gm-Message-State: AOJu0YzvlGhXLJho/I49KRnxcYg95n+DsOzENYZ672Cq9gMy7z9v5038
	IBu4hs0HuDAVyNxkUYZV4u03JTbIPfdiPc7gfUg9TypT8IRmAFls
X-Google-Smtp-Source: AGHT+IF+REZ+2INSPDwDp4WqYsoBUywOEBF4z8ulD1n402ji4MyEW9fs06hjPCi4UU9+IDKyuNzwHw==
X-Received: by 2002:a05:6402:90d:b0:5a3:a9f8:cf20 with SMTP id 4fb4d7f45d1cf-5bea1cb4babmr2249617a12.34.1723651669085;
        Wed, 14 Aug 2024 09:07:49 -0700 (PDT)
Received: from gmail.com (fwdproxy-lla-002.fbsv.net. [2a03:2880:30ff:2::face:b00c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bd190adc42sm3973995a12.21.2024.08.14.09.07.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 09:07:48 -0700 (PDT)
Date: Wed, 14 Aug 2024 09:07:46 -0700
From: Breno Leitao <leitao@debian.org>
To: Petr Machata <petrm@nvidia.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, Shuah Khan <shuah@kernel.org>,
	netdev@vger.kernel.org, David Wei <dw@davidwei.uk>,
	Willem de Bruijn <willemb@google.com>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	Hangbin Liu <liuhangbin@gmail.com>,
	Matthieu Baerts <matttbe@kernel.org>
Subject: Re: [PATCH net-next v2] net: netconsole: selftests: Create a new
 netconsole selftest
Message-ID: <ZrzWUg4SGJv7Byp6@gmail.com>
References: <20240813183825.837091-1-leitao@debian.org>
 <87r0arl5qw.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87r0arl5qw.fsf@nvidia.com>

On Wed, Aug 14, 2024 at 12:24:46PM +0200, Petr Machata wrote:
> 
> Breno Leitao <leitao@debian.org> writes:

> > +	fi
> > +
> > +	if ! grep -q "${MSG}" "${TMPFILENAME}"; then
> > +	    echo "FAIL: ${MSG} not found in ${TMPFILENAME}" >&2
> > +	    cat "${TMPFILENAME}" >&2
> > +	    return ${ksft_fail}
> > +	fi
> > +
> > +	# Delete the file once it is validated, otherwise keep it
> > +	# for debugging purposes
> > +	rm "${TMPFILENAME}"
> 
> Seeing the removal within the validation function is odd, I would expect
> it to be part of cleanup().

Thanks for all the other feedbacks, all of them make sense.

Regarding this one, I kept like this, because I only remove the file if
the test succeed, otherwise I keep the file here for debugging purposes,
as described in the comment above.

If that is not a good practice, I am more than happy to move this
to cleanup.


Thanks for the detailed review,
--breno

