Return-Path: <linux-kselftest+bounces-19196-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15D5E993E29
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Oct 2024 07:06:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C16351F218DB
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Oct 2024 05:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB1AB7E575;
	Tue,  8 Oct 2024 05:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e1SPDENw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E687C23A6;
	Tue,  8 Oct 2024 05:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728363956; cv=none; b=h8Cj4DkVpFCh6AZFofspoNPKC3w/IHd+B27jA4/XNDpTbjCNWyrV5ZPXKzI6LC2LPjv8MzFlDRVsrNGZIjMPZ8156nnAedfru1+N2lawyh4L43a4PiLyQM/xvRIq/qgh8FbbXd+vB6yKGmRwj8JVZq92Z9ExnTS8BqoZLNcyMmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728363956; c=relaxed/simple;
	bh=GzqgHMmQW/zLl2NUoOcPLLAhpn2pNv8p/0ISc/fRhJc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mA9R5wppA67puQuZG5/tapdBA0HdfsEp5hAM0OalDed0OxixXdPDi71fbWHIDF4+03/V0d9s2g3D9Hi1urFSYx2GuLkJgUe0CbxjO96Qp9dUGRPQi/OQMDiWAl8367EW+cHHUebuAcCp2FXGGZF9lUks+KaZsacKEAQQoRzf140=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e1SPDENw; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-20b0b2528d8so58911215ad.2;
        Mon, 07 Oct 2024 22:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728363954; x=1728968754; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vJPaVyRilo4aUQXwNgV/yaJuQyIUzylhfjLuhOyZnOs=;
        b=e1SPDENwv1vv8ZlYsrxhrZVHq7E8dIkLUxc6ncsEvTeoMrq23d5z127sTT8flK5yK7
         KDfSKLU/edJdm9Cvq2sB0EemZoo521y/NriR+TNzF7raJIEyAjqhfafbdCCKapWiXPfl
         HfAZWEqtM3COB12kom3tFhfwvyhQG7eCJuNLFMdl8AuRkVF42sLCdiwFwQYHGv7lmxnL
         kvPPdLvYrwe5//RYX3cNJVf2O0G1uf6tt0bnwM6Apb9LwNc3xyHT8ABQzbeOBtOO/5ye
         beHW3M5x5hwCOmlDsqmIwjAEtwXjq68Byi+2OSAZNciTxllIAUbrqGqLhYi1pBWUVCxb
         IqAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728363954; x=1728968754;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vJPaVyRilo4aUQXwNgV/yaJuQyIUzylhfjLuhOyZnOs=;
        b=KvV93htVpNhRpwUjJT6TobeII5vndQm3fv1FUtn+TNhrycLGCzcCEt4q2gHsre9joq
         2q3XsmeKsjsWoLjGXq4EJu+TpFYRPYZ/aZqRfbK67cUE6TwoY7uZCnDcsgpp1xOCgUrs
         wfx3fBKgU6akELndAtN9yvW/5t/FR0yeiORQgWPtQXw0lWyKgtYk9a0afLa44cV8Qs6g
         fb8lhKl0VIg79FE4vlF7pygMwzYe6e2sik+54WaKxriQXwkTr0pWpYjy3bEmWaUJBFtw
         1Tqf6MSTwvPpxFPsQAey6iUsxzI/fMw4Ers6KX0P7ywnHMPNfC7IW/ycki70vhOS4Vyc
         TzVw==
X-Forwarded-Encrypted: i=1; AJvYcCVlXuyAQZthMUaZ9kUFGPpgJiX2HlNyV0WYj0AjANfQt+4U6y76UZhtLrmUOmSEz/hCdqZc0h9w@vger.kernel.org, AJvYcCWCfk/z+P2WxcTR08BNZB09LzUQqONOUbr6rSDMDsjuZi17ltL0MqetrNgioUwuO9C7fubMatQfquH97XE=@vger.kernel.org, AJvYcCWatuFmuFoogPv5DtKBhqdTkFzg3OwrSilhhVXJJ7jWnhBSfrR0vIU5ibFGSLn5qefd43Bu8rkTt3VdCRCjSm2Y@vger.kernel.org
X-Gm-Message-State: AOJu0YzwgjpA4QAkpzxXONtn8gYgG6aEPAokT9hodhFuodBZsHjR2emL
	MHndhMnwrBs218l4kuNJ+r4E0gFzX36h0vmUZkjs9zExUerjRGxT+zvALg==
X-Google-Smtp-Source: AGHT+IHNfiOqpN2OMHamtFVd/3dPEh6k1BxaJ4wfYQnpULCLQy2CIwF/qE+PtdV2qFyQD/2rHuA5Vw==
X-Received: by 2002:a17:903:2a85:b0:20b:9e14:c138 with SMTP id d9443c01a7336-20bfdff1a88mr241542855ad.23.1728363954203;
        Mon, 07 Oct 2024 22:05:54 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c138b1ad6sm47900635ad.31.2024.10.07.22.05.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 22:05:52 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Mon, 7 Oct 2024 22:05:51 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Greg Thelen <gthelen@google.com>
Cc: Shuah Khan <shuah@kernel.org>, Mina Almasry <almasrymina@google.com>,
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests: make kselftest-clean remove libynl outputs
Message-ID: <8edbf2aa-0101-4a6a-ba16-3e67806f34f6@roeck-us.net>
References: <20241005215600.852260-1-gthelen@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241005215600.852260-1-gthelen@google.com>

On Sat, Oct 05, 2024 at 02:56:00PM -0700, Greg Thelen wrote:
> Starting with 6.12 commit 85585b4bc8d8 ("selftests: add ncdevmem, netcat
> for devmem TCP") kselftest-all creates additional outputs that
> kselftest-clean does not cleanup:
>   $ make defconfig
>   $ make kselftest-all
>   $ make kselftest-clean
>   $ git clean -ndxf | grep tools/net
>   Would remove tools/net/ynl/lib/__pycache__/
>   Would remove tools/net/ynl/lib/ynl.a
>   Would remove tools/net/ynl/lib/ynl.d
>   Would remove tools/net/ynl/lib/ynl.o
> 
> Make kselftest-clean remove the newly added net/ynl outputs.
> 
> Fixes: 85585b4bc8d8 ("selftests: add ncdevmem, netcat for devmem TCP")
> Signed-off-by: Greg Thelen <gthelen@google.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

