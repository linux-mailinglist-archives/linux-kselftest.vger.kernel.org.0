Return-Path: <linux-kselftest+bounces-42707-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 99EEFBB6421
	for <lists+linux-kselftest@lfdr.de>; Fri, 03 Oct 2025 10:45:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 671DB4E6FC0
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Oct 2025 08:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07C622749E0;
	Fri,  3 Oct 2025 08:45:14 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58198273803
	for <linux-kselftest@vger.kernel.org>; Fri,  3 Oct 2025 08:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759481113; cv=none; b=tF3497eVkI0lzQgKC2tLfq03GynRrHDkt3zJEXzV7CPAmJMOKg4gHZKuI/vhqXbhhYTLGSRY5zNXA+jhnevdbsUpf7N83IaIUs0Wyrcf6Bc10Fmv4/efkXZLBIleIF+TDD9G6T4aEScB0m1vCqSmWjw5yraayvuMtDlVXlrKUh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759481113; c=relaxed/simple;
	bh=YB1ghMEOeQ5JFYWeY2ps8djFxf5/HuRtlXBeq/CH+jo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BA+rMgWoQN4XHWM4UubKM+rOMSTSfCUAqqRF7HsS0a8dcJecKIdOazxHs+jQy7KxJfTvyS5AjsmTTiqFHC6CR3XXg7dr2+PwOGukZp+Hm3njuEfFbaIlXTkkPqj6NjBO34UeepP3O7pO+HEPNe4UrO/wlP1J5RrKWZ+FD11p0OE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6318855a83fso4115855a12.2
        for <linux-kselftest@vger.kernel.org>; Fri, 03 Oct 2025 01:45:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759481110; x=1760085910;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lNchDiEzIDmBEztmo8oZmioyYgfq18ckj4ZJE8yTj5I=;
        b=DBrmj9LIYWi4zNrG7PQSKxn22ljOY7f5q4W9QTF2nOh07Po8VIs24XQb1qkRmmtp/s
         BZznovD5Cu+MKBNFV8OrsWY+vOgIpQF23SiaeDKZqcmzb94O5BaW29BTNRVgkC3cYCBn
         HEDSk8JIxmA7s7GE8Cr/3mvZY5XXBtnGYS57tuGLI6kssKICCyFZcwHF/d/IdLJmS6QG
         9G+tDP/jXIZfUGs1vlS8X6zZmhHAi2cCroXxNHwTicLIch3SaeX52BwcXzDjunWYTxSH
         WINhk5RoKxxQCWa0HhfisDV3ElWnh1qMEsvyidq8W9UV+a9y3iINuhisPNLe43fLs33C
         biXA==
X-Forwarded-Encrypted: i=1; AJvYcCWhYPMWsKLrIojGnP/SeIW8OknnAnV658XDMVURjo56QR+TMCUgwh3c5e5U/nr+V0Vw/wuM70W2k9cQZmEdFtU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVpJKpdp1l7Jw2mszqZ1dvopwL4SDD+mUKzAlOIEQDsdvyrgNX
	/bODFhyseQMgMcfEBAws0qSZAZ3MVGBfDsa6A0Uhtd6YQFa/FXrtnjgU
X-Gm-Gg: ASbGncuNcvehqCgiizTnny6SnTgFMUuB/yymxM6Wgp7oSyKcb6U4ME7lWU/8unwYVE8
	r5BWLZX3KNTIdKax0GAzEGFgOeAxeqbBEPNlBtvjq4Sm1WsD7A8ipOaB1UKm6DjGCGkfM3XoTla
	Z4bIkM6tLFnZ899744fzL1SUlPj9yBR348jvr0/TdHGByfq19etjCzIbt0cC/Kli0xenyr/1dNn
	RzGUKVtItl6gNs3oqxzQnvK4H9XXr6t+HoJ+NnFyUUFs2HX/QoKC62mvM3JMsO7VmzBprCfyK2a
	WfmiUvdEFv+llZalum6cGVOh02P5HwVpNAMuGGpkW/EdE3dzox0rjQnzCfH8REcrpeR/1qxPcmw
	H43uZm8B2fQskoGf3K9Y0mvSNc4RMbVgJbRyfpw==
X-Google-Smtp-Source: AGHT+IGjw0zmq2CU/sdA/VkxJILpqI/TtLALso31v4P2kiwd0BksUPICZg/6K3fI5iB1htfz3dZPgQ==
X-Received: by 2002:a05:6402:5347:10b0:634:5297:e3b3 with SMTP id 4fb4d7f45d1cf-63939c509b6mr1714584a12.38.1759481110436;
        Fri, 03 Oct 2025 01:45:10 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:74::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6378811f14bsm3554826a12.45.2025.10.03.01.45.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 01:45:09 -0700 (PDT)
Date: Fri, 3 Oct 2025 01:45:06 -0700
From: Breno Leitao <leitao@debian.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Simon Horman <horms@kernel.org>, david decotigny <decot@googlers.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, asantostc@gmail.com, efault@gmx.de, calvin@wbinvd.org, 
	kernel-team@meta.com, jv@jvosburgh.net, stable@vger.kernel.org
Subject: Re: [PATCH net v6 0/4] net: netpoll: fix memory leak and add
 comprehensive selftests
Message-ID: <s4lrro6msmvu3xtxbrwk3njvmh4vrtk6tmpis4c5q5cbmojuuc@pig4xhrvhoxq>
References: <20251002-netconsole_torture-v6-0-543bf52f6b46@debian.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251002-netconsole_torture-v6-0-543bf52f6b46@debian.org>

On Thu, Oct 02, 2025 at 08:26:24AM -0700, Breno Leitao wrote:
> Fix a memory leak in netpoll and introduce netconsole selftests that
> expose the issue when running with kmemleak detection enabled.
> 
> This patchset includes a selftest for netpoll with multiple concurrent
> users (netconsole + bonding), which simulates the scenario from test[1]
> that originally demonstrated the issue allegedly fixed by commit
> efa95b01da18 ("netpoll: fix use after free") - a commit that is now
> being reverted.
> 
> Sending this to "net" branch because this is a fix, and the selftest
> might help with the backports validation.

This is conflicting with `net` tree. Rebasing and resending.

