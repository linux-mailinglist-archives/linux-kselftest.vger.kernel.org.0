Return-Path: <linux-kselftest+bounces-15302-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23C0795169E
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Aug 2024 10:31:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8CBE2864B0
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Aug 2024 08:31:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AC7613DDBD;
	Wed, 14 Aug 2024 08:31:33 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC767156CE;
	Wed, 14 Aug 2024 08:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723624293; cv=none; b=JsZcgSYFVYeZ+xG0ZAfQOg0GWHJssl3oZOTfRF+iuLd27M4+KlcykRLGwtL40haGmSOv2LFTozQHJ8Y7AnxnrlOiWSl3WVAmyX1eiEbea446UhFv2tJ3+wCi5hgVF2d5YDm6naNdOtGXGcyBs1QJxEFXomGnc/31xOx+HdPMeRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723624293; c=relaxed/simple;
	bh=qLgPMTD8brmUiPtdQTHvl3GL78o3cgeafqOFHMB+b5g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P+s4rq3ocGnRapapL1e7N9yJEm+6ZZOSZufS8NSXi1qKZpIppOuWsp6yeEMZIsDGFgPjBuAAYbYcOJETKNfBIlWPMwpBh/CXlFLM2t4Wyob43z5egBnwwwvkk0AY1BYcSQoVhuVvOe/zlPHcgRahO87IGDvGsKHN7n6Ok9veug4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a80ea7084e9so114458166b.0;
        Wed, 14 Aug 2024 01:31:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723624289; x=1724229089;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Var23HW/s7TX9giPkDbAte7j+80vM7UgNHHeU87uVfs=;
        b=JKElAPenb1uob6n0wIu/QvZXxlOf+Q87KemEqoJrW7jXDemsiLuZ4lnRBnT8DcSpUa
         KHgncYms8/uLbJMB1MEjS0XkH1hcuOJq4/u8HxklBPdB2CEfV627qFNG48AceHQ2+VxF
         lHcjpZro+5LRB8tu+CRqaWeFMRytNDJaWs8uWDdxHqTve3ZT/z+mnyFo5GLLiKz/VTyY
         ludrs/Wzfk4ckI+uDOx4EQCGqCNNGkv6HGaVjpDpTrN+XEr4p614AhpQbJQajlLWkUFs
         PK1Hj5jGnb93GtgkJkeWVRFyJQYln2Xn5j6da9WxLVVIsDlO7JE1hgeDZxLg8r7JdEI8
         L5rw==
X-Forwarded-Encrypted: i=1; AJvYcCVT++DelLPDqJdl65gLD7nKS1SNnrfShbKNc0PqZg6LqpOly+UCA86cM9iQezDTTVFNmDgrcEC5WIVUAznpcyffq3hcp19XluqcvzoIPN/bNDAFjpRRhLhYYpWa5QQdoy5/zPOr4ohxShSiYapoL9mzH2uNEl4lpbs7U8R9zpFLCZRMNzGY
X-Gm-Message-State: AOJu0YzSTOhoRUuokuZVDtJJRlJe7F7zKmgasNKsacQQexNXGqNKOy0h
	pANfKaWKrehA5Asahdw/TmpsDkxKHengxMJbm+UkGDT9oa2qJd9i
X-Google-Smtp-Source: AGHT+IHWllMk+HxVh1J0rYuGPzLBcwjU/JEdQ2TNEU86gkehBe+cCIHY0hOhGtnVu22GQFikgecexQ==
X-Received: by 2002:a05:6402:35c2:b0:5b9:3846:8ba9 with SMTP id 4fb4d7f45d1cf-5bea1c6aceemr1888435a12.3.1723624288778;
        Wed, 14 Aug 2024 01:31:28 -0700 (PDT)
Received: from gmail.com (fwdproxy-lla-000.fbsv.net. [2a03:2880:30ff::face:b00c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bd190ad1bcsm3696115a12.30.2024.08.14.01.31.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 01:31:28 -0700 (PDT)
Date: Wed, 14 Aug 2024 01:31:26 -0700
From: Breno Leitao <leitao@debian.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org,
	David Wei <dw@davidwei.uk>, Willem de Bruijn <willemb@google.com>,
	Petr Machata <petrm@nvidia.com>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH net-next v2] net: netconsole: selftests: Create a new
 netconsole selftest
Message-ID: <ZrxrXlU9+lluncm2@gmail.com>
References: <20240813183825.837091-1-leitao@debian.org>
 <20240813153716.76abf5ce@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240813153716.76abf5ce@kernel.org>

Hello Jakub,

On Tue, Aug 13, 2024 at 03:37:16PM -0700, Jakub Kicinski wrote:
> On Tue, 13 Aug 2024 11:38:16 -0700 Breno Leitao wrote:
> > Adds a selftest that creates two virtual interfaces, assigns one to a
> > new namespace, and assigns IP addresses to both.
> > 
> > It listens on the destination interface using socat and configures a
> > dynamic target on netconsole, pointing to the destination IP address.
> > 
> > The test then checks if the message was received properly on the
> > destination interface.
> 
> We're getting a:
> 
> SKIP: directory /sys/kernel/config/netconsole does not exist. Check if NETCONSOLE_DYNAMIC is enabled
> 
> https://netdev-3.bots.linux.dev/vmksft-net-drv-dbg/results/726381/4-netcons-basic-sh/stdout
> 
> Gotta extend tools/testing/selftests/drivers/net/config

Thanks, I've added the following changes in
tools/testing/selftests/drivers/net/config:

	CONFIG_NETCONSOLE=m
	CONFIG_NETCONSOLE_DYNAMIC=y

Then I was able to get the test executing running the following
commands:

	# vng --build  --config tools/testing/selftests/net/config
	# vng -v --run . --user root --cpus 4 -- \
		make -C tools/testing/selftests TARGETS=drivers/net  \
		TEST_PROGS="netcons_basic.sh" TEST_GEN_PROGS="" run_tests
	.....
	# timeout set to 45
	# selftests: drivers/net: netcons_basic.sh
	[   11.172987] netdevsim netdevsim407 eni407np1: renamed from eth1
	[   12.441965] printk: legacy console [netcon_ext0] enabled
	[   12.443049] netpoll: netconsole: local port 6665
	[   12.444104] netpoll: netconsole: local IPv4 address 192.168.1.1
	[   12.445281] netpoll: netconsole: interface 'eni407np1'
	[   12.446299] netpoll: netconsole: remote port 6666
	[   12.447246] netpoll: netconsole: remote IPv4 address 192.168.1.2
	[   12.448419] netpoll: netconsole: remote ethernet address aa:c8:83:a5:05:b3
	[   12.450646] netconsole: network logging started
	[   13.547405] netconsole selftest: netcons_GjLI0
	ok 1 selftests: drivers/net: netcons_basic.sh

I will wait a bit more, and then integrate this change into v2.

Thanks for the review
--breno

