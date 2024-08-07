Return-Path: <linux-kselftest+bounces-14999-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 58B6A94B311
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Aug 2024 00:32:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9E13282F71
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Aug 2024 22:32:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F3CA15444E;
	Wed,  7 Aug 2024 22:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uTzcFy5K"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F027A364A0
	for <linux-kselftest@vger.kernel.org>; Wed,  7 Aug 2024 22:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723069962; cv=none; b=nqkU+zVmeB9SS0RabZNDVwkexfV6A0J6q5t7CKoYEJUTz1aGdpG0mkRjpmyqkseMxOC/WvKq+z3qhoMcPixEOy0MBkM6sH97fKJUfjZmJM+55aYQ3yLtZgXrIAgWBuNJtFzfJnknr0o1BDVTnqv4feEuKUaT+PyX3wTIyFdPBcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723069962; c=relaxed/simple;
	bh=IDNMT6o5KfwYfTY17255Evt0lbZnm4CnEGRfht11BXg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Y3CiiLDj9P+H4dt5lzF9b4n+wqiruKbQyemDT2vX52ndDk0EFJgr+2Hzy9ycDh25PyeIauVcr5CPGRwFuNq1M2lAkdPfzZ64iIHuVw0EMNDRRi7HZtd6+QrjpjoISoAPIThbeRiGNhUUigoENXGRotu/B85s7vuC6ybQu7Lpru0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uTzcFy5K; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2cf93dc11c6so324261a91.1
        for <linux-kselftest@vger.kernel.org>; Wed, 07 Aug 2024 15:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723069960; x=1723674760; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=d/17UOMKe5oLrCx17iNXp2TK19+E7NavssE5gQNb1UE=;
        b=uTzcFy5KJ/o0wgVO6cwiMO95ampEkQU3+xrQTC3CK2uJvzJv8CXVzP4iCph9qZNEid
         Le8puIBl7KfQzgselIBYOujnNFujmYmrLqnOlZhyKb/F/bYHMQi0in0MedqkgfFmBKXw
         x8BfEHTNTrm9wpdemZZnOLyaCfFJO/BYIZnlz/7KyE6IamnXHdj2GHjxD42g9oKa3LtH
         MjLrUr6tEe4ZY8c/MrBMfm+6S7G47TcyLVp6yZhLsKTeQ6nPlrJ7v0Bc8R587p+fkjIP
         oB07UwIF2uSqtmKmgqg7m2J+L0nXtKgtTZeSBQZuhcIyxLNxyPqTIwmrAObThL1Lxb0g
         Zrvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723069960; x=1723674760;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d/17UOMKe5oLrCx17iNXp2TK19+E7NavssE5gQNb1UE=;
        b=b04jSj3U2O4Yu6Hsrv4vNJaCxqfZToH4a+9SY00nPUIloWoTaZm6iW833WCN/pktLT
         Kyt3iA0UosUTifHECgelNanZonzuHn2TCbeWEh+6HKVf2HRG6OkcsDV1D3y5PTwNwj5U
         GVtOyhtxqoowvdH1DcbXfAwrAy4HqMe1FCdccakRr9L54vbBpx19aT3FhCn+K310vV7G
         fHpkvriu4E5r+sV3rUjAqbyzAABDVjE8FgApxjdtVLwJQNpQxBPVobP3ETaej+CpRzJM
         qLx5YbaI0aNpQsLWhgxwk3AiIr+IFpxwEFIoPKFmcj9c0oiZ3YM6H6qLqsvQgSGcRpED
         UpjQ==
X-Forwarded-Encrypted: i=1; AJvYcCVR7ipLZSoKRDAkSlK9RRtjBKpwxMgv5mBZTBsRd3g7hmuGHiOziWifwQaxutOB4rlvbQP2sJ9Fv0s3jN1Iuaw9sBZTtqnCy6ft8wIl6gH1
X-Gm-Message-State: AOJu0YyuzuzB+Gib70NPtoffaSyFyMYjOrNLYW+8O+kMQE8xlBqxwHjA
	0eHjcmF/R5IiZf715b3wwPCEUgcXqTlnzsAnDSsE/1zVAEca8Ss4s/cYxGA+0hA=
X-Google-Smtp-Source: AGHT+IF6ltj6rd3uaMmAKqZ9lRxXF6GH8BM7xXm35nsHglv5MkLIzgBV5TQkDCcootMgdowWsa/ZAw==
X-Received: by 2002:a17:90b:1254:b0:2c9:96fc:ac52 with SMTP id 98e67ed59e1d1-2d1c347b2b5mr29119a91.26.1723069960420;
        Wed, 07 Aug 2024 15:32:40 -0700 (PDT)
Received: from localhost ([2804:14c:87d5:5261:6c30:472f:18a6:cae1])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d1b3b5a39bsm2102276a91.50.2024.08.07.15.32.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 15:32:39 -0700 (PDT)
From: Thiago Jung Bauermann <thiago.bauermann@linaro.org>
To: Mark Brown <broonie@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>,  Will Deacon
 <will@kernel.org>,  Jonathan Corbet <corbet@lwn.net>,  Andrew Morton
 <akpm@linux-foundation.org>,  Marc Zyngier <maz@kernel.org>,  Oliver Upton
 <oliver.upton@linux.dev>,  James Morse <james.morse@arm.com>,  Suzuki K
 Poulose <suzuki.poulose@arm.com>,  Arnd Bergmann <arnd@arndb.de>,  Oleg
 Nesterov <oleg@redhat.com>,  Eric Biederman <ebiederm@xmission.com>,
  Shuah Khan <shuah@kernel.org>,  "Rick P. Edgecombe"
 <rick.p.edgecombe@intel.com>,  Deepak Gupta <debug@rivosinc.com>,  Ard
 Biesheuvel <ardb@kernel.org>,  Szabolcs Nagy <Szabolcs.Nagy@arm.com>,
  Kees Cook <kees@kernel.org>,  "H.J. Lu" <hjl.tools@gmail.com>,  Paul
 Walmsley <paul.walmsley@sifive.com>,  Palmer Dabbelt <palmer@dabbelt.com>,
  Albert Ou <aou@eecs.berkeley.edu>,  Florian Weimer <fweimer@redhat.com>,
  Christian Brauner <brauner@kernel.org>,  Ross Burton
 <ross.burton@arm.com>,  linux-arm-kernel@lists.infradead.org,
  linux-doc@vger.kernel.org,  kvmarm@lists.linux.dev,
  linux-fsdevel@vger.kernel.org,  linux-arch@vger.kernel.org,
  linux-mm@kvack.org,  linux-kselftest@vger.kernel.org,
  linux-kernel@vger.kernel.org,  linux-riscv@lists.infradead.org
Subject: Re: [PATCH v10 35/40] kselftest/arm64: Add a GCS test program built
 with the system libc
In-Reply-To: <20240801-arm64-gcs-v10-35-699e2bd2190b@kernel.org> (Mark Brown's
	message of "Thu, 01 Aug 2024 13:07:02 +0100")
References: <20240801-arm64-gcs-v10-0-699e2bd2190b@kernel.org>
	<20240801-arm64-gcs-v10-35-699e2bd2190b@kernel.org>
Date: Wed, 07 Aug 2024 19:32:38 -0300
Message-ID: <87jzgsdkvt.fsf@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mark Brown <broonie@kernel.org> writes:

> There are things like threads which nolibc struggles with which we want
> to add coverage for, and the ABI allows us to test most of these even if
> libc itself does not understand GCS so add a test application built
> using the system libc.
>
> Reviewed-by: Thiago Jung Bauermann <thiago.bauermann@linaro.org>
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>  tools/testing/selftests/arm64/gcs/.gitignore |   1 +
>  tools/testing/selftests/arm64/gcs/Makefile   |   4 +-
>  tools/testing/selftests/arm64/gcs/gcs-util.h |  10 +
>  tools/testing/selftests/arm64/gcs/libc-gcs.c | 736 +++++++++++++++++++++++++++
>  4 files changed, 750 insertions(+), 1 deletion(-)

The libc-gcs test passes on my FVP setup:

Tested-by: Thiago Jung Bauermann <thiago.bauermann@linaro.org>

-- 
Thiago

