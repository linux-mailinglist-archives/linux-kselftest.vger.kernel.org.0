Return-Path: <linux-kselftest+bounces-23986-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C888A04144
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Jan 2025 14:54:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 022963A0724
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Jan 2025 13:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2013D1F1319;
	Tue,  7 Jan 2025 13:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="OVhRVUsB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC791F1905
	for <linux-kselftest@vger.kernel.org>; Tue,  7 Jan 2025 13:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736258043; cv=none; b=k6TWBp7osh1jdqp1yMPBk0WcZoPRcN/vG52KpAiwU6BpiXLzCL8rzb18wFqoDW+4zjIF7NdsDNZYDNRuOQXWXgebPpq1sAszx1aRN57H8IxUHxAtatzZnKdXzAK62cXL7bcowzBhfoJlNYZTsV3fFtnIf1QE8tgt6DEL/SGNkIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736258043; c=relaxed/simple;
	bh=pnd9bWKcVvHpiCgHOsJ4SWIWT+1cRSGQBRl0dU4VEqQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RuoLswEXK7u1mm0wNCdCb9KudZedFNrTu14ZwM34pqG6ZpCixFANhsrzuJfspacxOjwt60ip1IrSkJBNtRqUqcW/2SPYVTVflaRstTRTf3K6e1wM7/TQVOO2y9YrUana7YSAphe7gsR4n7VVM6RueLxGaiBtXsIS1SPZn5LYCGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=OVhRVUsB; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43634b570c1so111569995e9.0
        for <linux-kselftest@vger.kernel.org>; Tue, 07 Jan 2025 05:53:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1736258038; x=1736862838; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mf8jPgXxGrIxQldgWVeV6hOY5gw0J6WWBBGrGIYnzCI=;
        b=OVhRVUsBSUO4Z4end3Cm3ZuYWVa6AEFelVPMXoF1tZeY8RiVfgvpmr02sm1xUtMKwl
         Z3AcP4l5hIafO8CiSkTgqXVpthkg99w8Wpr1fuNNFCMfrumUKd57ytAGqgDnLaDq/iJj
         rZPMjW3M/MEZEsdDHKeXY+zO1k4IM4yMFjFZpHdQE0D3tCrGUw7puobcOv4wPnGtC2uu
         kzAp2N2bRvOvyQHJvhrp3Sw2WEezriZraRGrsy5JxbVfzzrVxsXsVDePTcRPaaylYze3
         78VEzlXtrk2K8aDngfHZJS7uDtVqhr723i3bC8Snpdyb0PNoH1dKIMVYeqkC1YQs6JiE
         06Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736258038; x=1736862838;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mf8jPgXxGrIxQldgWVeV6hOY5gw0J6WWBBGrGIYnzCI=;
        b=rYX6E7WYBsmN/GXPtSoBMCMZ/pbeAsxdFfcrUsEpVaeMJMPNWv40+2eDxbJz3MC+hZ
         hnCJ6goZIgxrDhku6aOV8IKtYOG3PcRYPRhEwpSU6vlhyYnZaOBb8vJtRmeVufbiS4fL
         4ILzeOTPNmkg+fFFEle6WaRYzuEjfmdIPMpiKAHQRq/LDwMABFc2oVX9yEosSGV0ZM3f
         eAQPFniOk0ZepHAAzEDrBWUgBwB8HCFIe7U7W1s7gG0DPNev4iEhtMgXPr4s8ncksFjZ
         fgjTjcblIqswHF8P7/4cqAR5a2esgJXk2GadsDIws/3kd6BVmJwcrNSQbilIePBh7W8u
         wHMg==
X-Forwarded-Encrypted: i=1; AJvYcCVwd4CKsun1SyAjoux6rtMEqXWaWaItvEfZCmGJG8nvFhOXm4NxoxWAht2cX/4OEyuZH16ishSnKcmlLqp4dU8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQLyVJmtTrkXwzpAsrVM02j21TwBNHnMFpp3EJ80QAkQDLTICB
	Kp0xH32tTr1w2KPD5TZs641inA7HQxeDadf1kp2Bc8BSLxoXAB6H1aVnmG0BDOU=
X-Gm-Gg: ASbGncv1g92MlNAG8gZZZYvfrVK/3jZrHvL52N7gTCtVccodAKcLT0MDaZqsuDxhr+z
	NsvKsvyQclfm4hyGNA2zUrV4FB3XoozzPjs1x9K2dUSsBp21tyAxKCoT7EQBv3hFnF2Qev6kCZC
	z7QEWWwMJ9mNXO931zouUcXTvbfWo2GSx2ZEvLnwC6IOW4SVGEEtKU7HOwN8/mvuuwy4VyIljYh
	cTMzn+jKIrND9Gpn3gQaaV5onYRSmPekTMSbaFND3i+9vxF5nHlfSMhpg==
X-Google-Smtp-Source: AGHT+IHW4BnHQtKvg+t5fEHhOv1aqL7X3ZSZRzZ0YswHo0+Nhw3Utr/OEfOeHlBwJR5HS9U648DmSg==
X-Received: by 2002:a05:6000:18a5:b0:382:5aae:87c7 with SMTP id ffacd0b85a97d-38a221f9d65mr51455843f8f.31.1736258037770;
        Tue, 07 Jan 2025 05:53:57 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c8acb17sm49816223f8f.97.2025.01.07.05.53.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 05:53:57 -0800 (PST)
Date: Tue, 7 Jan 2025 14:53:55 +0100
From: Petr Mladek <pmladek@suse.com>
To: Siddharth Menon <simeddon@gmail.com>
Cc: shuah@kernel.org, skhan@linuxfoundation.org, mbenes@suse.cz,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 2/2] selftests/lib.mk: Introduce check to validate
 required configs
Message-ID: <Z30x83zTnBWNSxGH@pathway.suse.cz>
References: <20241220193536.13781-1-simeddon@gmail.com>
 <20241220193536.13781-3-simeddon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241220193536.13781-3-simeddon@gmail.com>

On Sat 2024-12-21 01:05:36, Siddharth Menon wrote:
> Currently, kselftests does not have a generalised mechanism to skip compilation
> and run tests when required kernel configuration flags are missing.
> 
> This patch introduces a check to validate the presence of required config flags
> specified in the selftest config files. In case scripts/config or the current
> kernel config is not found, this check is skipped.
> 
> In order to view the missing config options required to compile the test,
> set the environment variable LOCALMODCONFIG_DEBUG=1.

As I wrote in the review for the 1st patch, I would prefer to print
the missing config options by default. The LOCALMODCONFIG_DEBUG
variable is pretty non-standard and hard to memorize thing.

> --- a/tools/testing/selftests/lib.mk
> +++ b/tools/testing/selftests/lib.mk
> @@ -97,7 +97,14 @@ TEST_GEN_PROGS := $(patsubst %,$(OUTPUT)/%,$(TEST_GEN_PROGS))
>  TEST_GEN_PROGS_EXTENDED := $(patsubst %,$(OUTPUT)/%,$(TEST_GEN_PROGS_EXTENDED))
>  TEST_GEN_FILES := $(patsubst %,$(OUTPUT)/%,$(TEST_GEN_FILES))
>  
> -all: $(TEST_GEN_PROGS) $(TEST_GEN_PROGS_EXTENDED) $(TEST_GEN_FILES) \
> +TEST_DIR := $(shell pwd)
> +
> +check_config_deps:
> +	@$(selfdir)/mktest.pl $(TEST_DIR)/config || \
> +	{ echo "Skipping test: $(notdir $(TEST_DIR))"; exit 1; }

I would write a more meaningful message, e.g.

	{ echo "Skipping test because of missing kernel features: $(notdir $(TEST_DIR))"; exit 1; }

> +
> +all: check_config_deps $(TEST_GEN_PROGS) $(TEST_GEN_PROGS_EXTENDED) $(TEST_GEN_FILES) \
>  	$(if $(TEST_GEN_MODS_DIR),gen_mods_dir)
>  
>  define RUN_TESTS
> @@ -228,4 +235,4 @@ $(OUTPUT)/%:%.S
>  	$(LINK.S) $^ $(LDLIBS) -o $@
>  endif

Otherwise, it seems to work well for the livepatching selftests.

I guess that it might prevent running some selftests because of
too strict or outdated information in some
tools/testing/selftests/<project>/config files. So that it might
cause regressions.

But I think that this is the right way to go. I am just not sure
whether we should wait for complains from linux-next. Or if we
should be more proactive in fixing the various <project>/config
files.

Best Regards,
Petr

