Return-Path: <linux-kselftest+bounces-21726-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DDBBB9C2E04
	for <lists+linux-kselftest@lfdr.de>; Sat,  9 Nov 2024 16:07:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76E74B21147
	for <lists+linux-kselftest@lfdr.de>; Sat,  9 Nov 2024 15:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 681DA1993B8;
	Sat,  9 Nov 2024 15:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g/P/gv/8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA6951DFFC;
	Sat,  9 Nov 2024 15:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731164842; cv=none; b=G37X801NhC9O9v77bxeE0jrClU+YGpITWgr+95C9AkVu1tY9Wb8WCJx0/DcKNfsrybs0mgRcowJ716iLWsfwtoVOrKwxicur4PkYTKnrHzv8ECq35CVBqQk0pO6ZnyIgAfYCMsVMAULdIjBlidi27PzBncYAQ9EhsLWmfO0CivE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731164842; c=relaxed/simple;
	bh=Id2TaBMrzDI+7SgrR4QD7LYE/+MNn4P49sggGFT9324=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=s3T92ia+3OtjJ3K5jtusSCr2vpEvO1KjE9bXvT4kI5W6wMiS5o7fBzw3mvtmDrDl1NR8PXUW/8va3s9RWJU9GL3akDMH1r+WH+LhR2S1/lA6wLWSvxFqwXUGFFwavR4ke74l7Usy1IPPdWzc9NNCA86v2lmgVoPXpA74YUx/2tM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g/P/gv/8; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4609beb631aso23520971cf.2;
        Sat, 09 Nov 2024 07:07:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731164840; x=1731769640; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d7UTyqRrTKrSldjAfUOd5fR0L0k3y8bLbCdAZt/4Joo=;
        b=g/P/gv/8WzrGNan5xCfsqFrZ54HkelnLiYGnMUktcQfsiXOsOmLnmvQvbNhTGpmWBT
         p9bWnUFsNsuhw5mQ8VwVkw9TA2ueX16oDLIj/LW2V/ooxnJetnngTPvD4CATnlQ3ldxx
         ak6i9hVN4rL77fing+nyvfb9DgxkWVU71q2woXKAD2wYstzx0ScatjjlpHB8CsSGHbD6
         OnzViVKiUnnCdizbw4GRrCOuGiG+nvEotVNaIqLCEBpFOkAPJZ0JA/dnT8q4mu4jM5JQ
         8t981oPSDkgBrwjUDR30dUUj5pTdjoCB+zc6Bnrjj6UyExZEtkROWnxUCDEiZaDZZ4kH
         4kpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731164840; x=1731769640;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=d7UTyqRrTKrSldjAfUOd5fR0L0k3y8bLbCdAZt/4Joo=;
        b=nb0KBF+sqVonJe2CKaNJnOIScctQKQm/Bw88milfF6AGM3F6TfmU4PzGBsUnL0E7AG
         XjaxvQlLvaP4tRotPAPgtgyJLR8yMpuA93XyNi7/IFuHjhlboBd9WtNzqQv0GbqBEjnI
         +f96ICWV7IWJEB8hcG4s3FCrixJfkLaMnezaUK+gpxX+FvNX1RmBmt3n38N8FKtuD6C4
         obfXG4TPEUlANDqgCMVT/XwJeIJO2q4LPWOwspY4np7WhvTqDxLXLIcMOlX9/xbdkECO
         UhJ0Cw/pzBKC9HF7ezxUvzsX3m7QMx5stfTRY8V1aZsjeryauvZw/HxMcBeYyJZB23b3
         TzLw==
X-Forwarded-Encrypted: i=1; AJvYcCV1v00FkhJhN/heAxq5J/3Nv1jouMFKDbagHtlg/qREF0G/k43BaiXcSxGKagJM5gvmOvIwmHMwhL40xpQ=@vger.kernel.org, AJvYcCWisO4nWa2gemlKjJM0XqJjP/pUsyzMo+y0/YRDJ2+mPyNvqYqo22B0kJD1GoCdKg00A6qG4aJr@vger.kernel.org, AJvYcCWkICnyvEVk+7wfg8856wlsVAER10oZYRguh6Lov1ydtL7ajRYZMn8ANgoGI5EnLKyP7+yOFybNimQqxnKD+w2C@vger.kernel.org
X-Gm-Message-State: AOJu0YwfiNtwBjBaKf+L4ybR+0W5mRFHhHm4lJT1MlE8fC7B01N/rhY6
	VSY90sNJ4FPnFpJGGj+arkWel2KC6C9+8JHcFONJx4CUGfwjlmfi
X-Google-Smtp-Source: AGHT+IF68xP0ccbEj83xSaEav+tvpLf/chEjd+DqVyTlfe8QBOQ8yK0Zb5itugKECyaNWlxTNEtoQw==
X-Received: by 2002:a05:622a:2b4c:b0:461:48f9:44f1 with SMTP id d75a77b69052e-463092148d7mr85566391cf.0.1731164839674;
        Sat, 09 Nov 2024 07:07:19 -0800 (PST)
Received: from localhost (250.4.48.34.bc.googleusercontent.com. [34.48.4.250])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-462ff477014sm33723871cf.49.2024.11.09.07.07.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Nov 2024 07:07:19 -0800 (PST)
Date: Sat, 09 Nov 2024 10:07:18 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Joe Damato <jdamato@fastly.com>, 
 netdev@vger.kernel.org
Cc: corbet@lwn.net, 
 hdanton@sina.com, 
 bagasdotme@gmail.com, 
 pabeni@redhat.com, 
 namangulati@google.com, 
 edumazet@google.com, 
 amritha.nambiar@intel.com, 
 sridhar.samudrala@intel.com, 
 sdf@fomichev.me, 
 peter@typeblog.net, 
 m2shafiei@uwaterloo.ca, 
 bjorn@rivosinc.com, 
 hch@infradead.org, 
 willy@infradead.org, 
 willemdebruijn.kernel@gmail.com, 
 skhawaja@google.com, 
 kuba@kernel.org, 
 Joe Damato <jdamato@fastly.com>, 
 Martin Karsten <mkarsten@uwaterloo.ca>, 
 "David S. Miller" <davem@davemloft.net>, 
 Simon Horman <horms@kernel.org>, 
 Shuah Khan <shuah@kernel.org>, 
 linux-kernel@vger.kernel.org (open list), 
 linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK)
Message-ID: <672f7aa6accf5_3564c0294e3@willemb.c.googlers.com.notmuch>
In-Reply-To: <20241109050245.191288-6-jdamato@fastly.com>
References: <20241109050245.191288-1-jdamato@fastly.com>
 <20241109050245.191288-6-jdamato@fastly.com>
Subject: Re: [PATCH net-next v9 5/6] selftests: net: Add busy_poll_test
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Joe Damato wrote:
> Add an epoll busy poll test using netdevsim.
> 
> This test is comprised of:
>   - busy_poller (via busy_poller.c)
>   - busy_poll_test.sh which loads netdevsim, sets up network namespaces,
>     and runs busy_poller to receive data and socat to send data.
> 
> The selftest tests two different scenarios:
>   - busy poll (the pre-existing version in the kernel)
>   - busy poll with suspend enabled (what this series adds)
> 
> The data transmit is a 1MiB temporary file generated from /dev/urandom
> and the test is considered passing if the md5sum of the input file to
> socat matches the md5sum of the output file from busy_poller.
> 
> netdevsim was chosen instead of veth due to netdevsim's support for
> netdev-genl.
> 
> For now, this test uses the functionality that netdevsim provides. In the
> future, perhaps netdevsim can be extended to emulate device IRQs to more
> thoroughly test all pre-existing kernel options (like defer_hard_irqs)
> and suspend.
> 
> Signed-off-by: Joe Damato <jdamato@fastly.com>
> Co-developed-by: Martin Karsten <mkarsten@uwaterloo.ca>
> Signed-off-by: Martin Karsten <mkarsten@uwaterloo.ca>
> Acked-by: Stanislav Fomichev <sdf@fomichev.me>

Reviewed-by: Willem de Bruijn <willemb@google.com>

minor nit that ULONG_MAX can not be true with uint32_t on 64-bit
platforms. Definitely no need to respin just for that.

