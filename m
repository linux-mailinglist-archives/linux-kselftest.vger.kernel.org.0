Return-Path: <linux-kselftest+bounces-44850-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A801C383A0
	for <lists+linux-kselftest@lfdr.de>; Wed, 05 Nov 2025 23:45:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10E36188C80B
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Nov 2025 22:43:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20AF42F49EB;
	Wed,  5 Nov 2025 22:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rj9xuNqd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81E942F12A5
	for <linux-kselftest@vger.kernel.org>; Wed,  5 Nov 2025 22:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762382582; cv=none; b=FwAWLfLJqhW7Cc3TvCd4DFHZbGi0UI/BqTyTWEeKnNj31w4nLojxSNHDLUihCUg0asGx6HX2LXdMQN5OSDzKDZk7jF57nbtmO7sP+Hg6+/9bRDzZ1jG3xpBrrRnAEMOtayw41zNSYC5IUQeqJqv1o2ylJKHhL+uEnRk8n4Ouaf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762382582; c=relaxed/simple;
	bh=DDJcM3o308lRznvcKXTlIS/CWI9gWk3xwBcIeYBXdjE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=plJzGPb0dGJ0o++OIYjEWR29P46gVADg5ErZ4Xh0/Vt9XVd3acPA6ypl35jRDFw+uSZVDgC92AxP2X0g0/fcrMidsDeOoX3oOx26zcLOib2hB3bXIAarpum+/LmwLkzKx1BUWUraBbiaZmJNeOTxktGGS/hiltDjFgNwkQ5ok0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rj9xuNqd; arc=none smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-63cf0df1abbso389336d50.2
        for <linux-kselftest@vger.kernel.org>; Wed, 05 Nov 2025 14:42:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762382578; x=1762987378; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=F3I7J13Lm/TZktCvPBXUloQhziyL889846w5yNI4ZSM=;
        b=Rj9xuNqdQvDlG7CPylJcJWTerl4JwtQ7TF8/o/6FAkFhHTKzC304t/E46v4Rdd7/tk
         1qb6iqPby7wVdpQ7Yi7TgrdWNNMPnuKgtPIJJDlx1+MyaiBuYH7RAZUFmd8AvlIZcAN6
         DxcCLTI8c+4LZjnxXlnFd+75JShGtHtGbz01Tkmki/gpDDnXJF6A0ycYc1anhrP2unB+
         bEVM5grB6Ip/EFZTh0FgLeiR2u0u41TUtvx+aWcVjzjnaDOg6ju98Hz94sXfxn9XZhLl
         33ct00a+F1BxlVw8xjsepd5R5c6bykPdLgOkMqCE5PYvUGAiznJP0B+2BWoZy074Tkt5
         Ze9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762382578; x=1762987378;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F3I7J13Lm/TZktCvPBXUloQhziyL889846w5yNI4ZSM=;
        b=XsZsou0rGxcpmWSk5Cr1MMj0QKQe7LROt5Gb5PU2V+UdJjaq02rbnUfBb1ZJjXnseQ
         3U2czcuru5bgY2kb3U54mwZ7wbiQ29LgEVDdRoksPP3WsgoOfAerIumNZ10EYPuts6Sh
         dvvCGmA9SuGUTSmmT2eFItGfWc7SLAU5oGnhfzlCUrAZZDoNyHV+5kSnkpHOjXIi5OjA
         x3NIsnRcs/pK7ZcM2F101uxd0BC915i5RF7+QSuRT2L7X5BzLNScIlqzOF0hiIwa+dvg
         C2T41c69Ji1pwXCKPY9nzOFgJqOcP4dv21mvCU5S6UPBnVsAsroUbYdZijVBoSUsapxW
         pZzw==
X-Forwarded-Encrypted: i=1; AJvYcCUjOnylyzGxA2Ho6E+oOFudufHEaVHqWVoiqtwN077M7ZgS7/GAqqdH0AdNeAk0DZ0FOJGQfITYuXmN3a0Ofl4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yypv79DALbTuJ1nI80Gfal7hTZ7OyA2cj8g51DkoHYXHjz+EX+g
	0To32Jg6TVd4C3k7momZCjPO9vHWS3TKJQsWBNzuBsDCCiJLIy6MlQNx
X-Gm-Gg: ASbGncsbXP6pnUbRiaQokDx+jI597evfk+sWGHvSvFVx78m1vfuv3GsGTIMga1CrIQS
	dbYIlfRtRo4CWv+cYDaDYY9YfX2bQJ5eHM2bvxmIhYE9X3yXvay0dxmU2IUpF5UBACwZg++CRKz
	n30P3rECzDmk7ZTs24l/2B6xyhNsLkmalDXQ4rjeK1EyDWaCzBC56LQzSk9j7rxBpCnKHXG07Nj
	8w6OegEYcX0QKoAbBcZU8OjafETqH+JQx7Js9JsbOw1Vi1THSi4W8GpTBRoMV7W74yw+iMAsukH
	DFVKxURIcGYhTe4UIPRF439OL65jagMdmKtR/m3VzaFMihSKiR+4GDIriFzDRrKSCMeoaWscx20
	XMTcM6xRAQjGTCXB5qm+4qJjCx6O2eyQo2hc0q+zESTnBPCd8sExcrZkMzsASQkDbFahH/NrCvB
	kYVHvEjrnUNAW2WGjnCMdy4gZsUqhP2l8cGyxQ
X-Google-Smtp-Source: AGHT+IF4bH2tlcrxAWH8nMgSsZ+oa2FDYqK2kFDiy/QWN+ROxEWd8z1LH772DutB9P2i6rkfAV9wfA==
X-Received: by 2002:a05:690e:4289:20b0:63f:9a63:46e5 with SMTP id 956f58d0204a3-63fd34d6705mr3657566d50.28.1762382578383;
        Wed, 05 Nov 2025 14:42:58 -0800 (PST)
Received: from devvm11784.nha0.facebook.com ([2a03:2880:25ff:54::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-787b160e761sm2705947b3.57.2025.11.05.14.42.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 14:42:58 -0800 (PST)
Date: Wed, 5 Nov 2025 14:42:56 -0800
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Shuah Khan <shuah@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	Simon Horman <horms@kernel.org>,
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v2 04/12] selftests/vsock: avoid multi-VM
 pidfile collisions with QEMU
Message-ID: <aQvS8GdzrfhVOhgx@devvm11784.nha0.facebook.com>
References: <20251104-vsock-selftests-fixes-and-improvements-v2-0-ca2070fd1601@meta.com>
 <20251104-vsock-selftests-fixes-and-improvements-v2-4-ca2070fd1601@meta.com>
 <3osszz3giogog7jzs37pdqhakcrveayrqu6xduztuwrftkwrad@gjj3cyvmypw3>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3osszz3giogog7jzs37pdqhakcrveayrqu6xduztuwrftkwrad@gjj3cyvmypw3>

On Wed, Nov 05, 2025 at 03:32:18PM +0100, Stefano Garzarella wrote:
> On Tue, Nov 04, 2025 at 02:38:54PM -0800, Bobby Eshleman wrote:
> > From: Bobby Eshleman <bobbyeshleman@meta.com>
> > 

[...]

> > 
> > -trap cleanup EXIT
> > -
> 
> Why avoiding the cleanup on exit?
> Should we mention this change in commit description?
> 

Makes sense to call it out. It's removed because it just isn't needed
anymore (vm_start() callers now all terminate and cleanup the pidfiles).
I'll add more context in the message.

Best,
Bobby

