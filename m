Return-Path: <linux-kselftest+bounces-5253-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4919385EE3C
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Feb 2024 01:43:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02183284EB2
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Feb 2024 00:43:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC89B290E;
	Thu, 22 Feb 2024 00:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="1WFKZv0p"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5513C12B7F
	for <linux-kselftest@vger.kernel.org>; Thu, 22 Feb 2024 00:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708562586; cv=none; b=WmlmTgq0/WkgGoBEQvTDiSloy4MJ6xAv31qIVI1zuUwhkuNGmo2ZiX91kZGhbrtxXErePL5sjETnSqFI+1qvtcN/wiySKPIRbMc9vNDvMV9s8mviyRAm9VcvOM2rs/z4UVbokOO3iIDqHUYx7YmaRhFaoJ5eh9brZ0NNUIVpyfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708562586; c=relaxed/simple;
	bh=70s578QhfI8VfYwqTA58Ok69jNRS8MFE5JRxsyKVwPk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kLEkc9qV0BzSrjanzZGp9xVYwF4HSJxWckfEz//r2S8LFbXDIADZsGJH0xg772I3n+ZFYitjESKreUeEa2clg1XyNPqynr2Kdbov1O+NSAzGeBOOatYu6ow0Si1IYoD+im31nCrPvKgVbixuTytgJjOXRjZOaSUBA0DzKPpLYEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=1WFKZv0p; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-53fa455cd94so5088155a12.2
        for <linux-kselftest@vger.kernel.org>; Wed, 21 Feb 2024 16:43:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1708562584; x=1709167384; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CR24aAbNKMU+aX5oJp3mmjRiDv2V+IvxS0ZLhqmyJiA=;
        b=1WFKZv0pAJBZfWvLdsKJB6k92Da4ZkbHRhMmH6TNJ3nFMgzqUzSvKPNmtWBdrWlO4y
         TltR+v3HZ8wcnoCcHckct0296eRkpvkrEFZw8XbUmMbnT/qvwkonqAh3LvWQ5Q3+8o4l
         sslqqSQTeiaxJxmXlhUWfgMdsgsy443CCK8sin/7EZNx7tjlGzz2Nv2Sy+5HIXN3yuC7
         ULVMK0KOb+TABB8I+oCuzeteXl9fDgWXwPw//jwgewZLEkC4/12DQfN7sfFILPAnfwZd
         eXeaXULuroei2yw5d0tPIHywO+liURlP0wX5GaT7ERWe3ZD+2Fto0itXynUtSWargjyB
         dFuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708562584; x=1709167384;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CR24aAbNKMU+aX5oJp3mmjRiDv2V+IvxS0ZLhqmyJiA=;
        b=msZE2PQt2JI2HAxdnWzhGOP1MoCngLew/HmYdRb+xr49woro1YmI3myIsV4nZZTlkg
         nK06VQzO3dq9wVJBNNXUUxvyFcpN5aTlhJo47DsiGu/kFdaUFe6FHBH+EgGMMMCqXgZP
         Oe/fGGHWUmvo1zj27LXIdgTnauy8g9x+zGasEMeNHV2RDGLRWbWwK1KHSpL+kSLJT3L0
         +IPlfIDa7PR3lEL8r/The+V4mfiWIsRMNWW3bM3+6vRE37pFrBcrFJvHBpfnOuhbNYXU
         6bC8/I5Z7ymhM30mSW2n3d0sMGwD2fAbsXLRAYtYL3KTayx9bSvQaNHnOseTC48kqryX
         xkGQ==
X-Forwarded-Encrypted: i=1; AJvYcCU44Tp0AQTNC5QeNuRkqK6mG1Gc8IuiZWletZM9bMK9gphBUxsuxGuI1E2+Op/1WMILm9qOlpI/xNOGf+MfXWjTdoMiF6qXSWgpHMe5L1j8
X-Gm-Message-State: AOJu0YwrVF6T8E7V3gpPJ5sTxFE1lLxv9p39ffbp5FOJ1m5eeljfhPKB
	5VCgeSZww1sRH4az/vvvFuEhaOmWdoMqoRqcgK3Jl0w7RWE0lryE0OeNN8QfCiE=
X-Google-Smtp-Source: AGHT+IED8Qc8cv5em+hY8R0laXHeLyNpZm08160QFNjQ7Gn8Te5H8kX7oc01tG3ELGqs1k3ZjWLKiQ==
X-Received: by 2002:a17:90b:606:b0:299:99f4:5911 with SMTP id gb6-20020a17090b060600b0029999f45911mr9465260pjb.29.1708562584637;
        Wed, 21 Feb 2024 16:43:04 -0800 (PST)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id bx12-20020a17090af48c00b0029a4089fbf0sm390177pjb.16.2024.02.21.16.43.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 16:43:04 -0800 (PST)
Date: Wed, 21 Feb 2024 16:42:59 -0800
From: Deepak Gupta <debug@rivosinc.com>
To: Mark Brown <broonie@kernel.org>
Cc: rick.p.edgecombe@intel.com, Szabolcs.Nagy@arm.com,
	kito.cheng@sifive.com, keescook@chromium.org,
	ajones@ventanamicro.com, paul.walmsley@sifive.com,
	palmer@dabbelt.com, conor.dooley@microchip.com, cleger@rivosinc.com,
	atishp@atishpatra.org, alex@ghiti.fr, bjorn@rivosinc.com,
	alexghiti@rivosinc.com, corbet@lwn.net, aou@eecs.berkeley.edu,
	oleg@redhat.com, akpm@linux-foundation.org, arnd@arndb.de,
	ebiederm@xmission.com, shuah@kernel.org, brauner@kernel.org,
	guoren@kernel.org, samitolvanen@google.com, evan@rivosinc.com,
	xiao.w.wang@intel.com, apatel@ventanamicro.com,
	mchitale@ventanamicro.com, waylingii@gmail.com,
	greentime.hu@sifive.com, heiko@sntech.de, jszhang@kernel.org,
	shikemeng@huaweicloud.com, david@redhat.com, charlie@rivosinc.com,
	panqinglin2020@iscas.ac.cn, willy@infradead.org,
	vincent.chen@sifive.com, andy.chiu@sifive.com, gerg@kernel.org,
	jeeheng.sia@starfivetech.com, mason.huo@starfivetech.com,
	ancientmodern4@gmail.com, mathis.salmen@matsal.de,
	cuiyunhui@bytedance.com, bhe@redhat.com, chenjiahao16@huawei.com,
	ruscur@russell.cc, bgray@linux.ibm.com, alx@kernel.org,
	baruch@tkos.co.il, zhangqing@loongson.cn, catalin.marinas@arm.com,
	revest@chromium.org, josh@joshtriplett.org, joey.gouly@arm.com,
	shr@devkernel.io, omosnace@redhat.com, ojeda@kernel.org,
	jhubbard@nvidia.com, linux-doc@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-arch@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [RFC PATCH v1 18/28] prctl: arch-agnostic prtcl for indirect
 branch tracking
Message-ID: <ZdaYk8XERnOtiR3P@debug.ba.rivosinc.com>
References: <20240125062739.1339782-1-debug@rivosinc.com>
 <20240125062739.1339782-19-debug@rivosinc.com>
 <ZcJas4tZNzOJv6hW@finisterre.sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <ZcJas4tZNzOJv6hW@finisterre.sirena.org.uk>

On Tue, Feb 06, 2024 at 04:13:39PM +0000, Mark Brown wrote:
>On Wed, Jan 24, 2024 at 10:21:43PM -0800, debug@rivosinc.com wrote:
>
>> To allow userspace to enable this feature for itself, following prtcls are
>> defined:
>>  - PR_GET_INDIR_BR_LP_STATUS: Gets current configured status for indirect branch
>>    tracking.
>>  - PR_SET_INDIR_BR_LP_STATUS: Sets a configuration for indirect branch tracking
>>    Following status options are allowed
>>            - PR_INDIR_BR_LP_ENABLE: Enables indirect branch tracking on user
>>              thread.
>>            - PR_INDIR_BR_LP_DISABLE; Disables indirect branch tracking on user
>>              thread.
>>  - PR_LOCK_INDIR_BR_LP_STATUS: Locks configured status for indirect branch
>>    tracking for user thread.
>
>FWIW the arm64 BTI feature is enabled per page of executable memory
>rather than in CPU state so it'd be hard for us to adopt this interface.
>I don't think that's a blocker, just noting it.

Got it, makes sense.



