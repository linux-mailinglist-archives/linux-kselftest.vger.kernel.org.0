Return-Path: <linux-kselftest+bounces-7992-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20ED58A5667
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Apr 2024 17:30:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 522DA1C20362
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Apr 2024 15:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BC3878C75;
	Mon, 15 Apr 2024 15:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hOeQAxMw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0BB060EF9;
	Mon, 15 Apr 2024 15:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713195026; cv=none; b=DW+LXd0oqz6GIvcPJBFnV+s62PA5ucuHwcKeovjqKtWeSdWg7H7yHd7qXe4EJEyxt3htElNX6MVR6EsJRoEVuikrUiKh8LGRY96PgOWavSl8RKOJRCJHoR+/BaAgjyaEmVIVd/e5VMIHUco1yeYXMDwG2Rtwa1LclcHyAVwZkgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713195026; c=relaxed/simple;
	bh=ktv+ZmtscQwhZwbyPx9Aiqr0DfD94JVzFS5PJrNFwOM=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=FiayH0PbBT7CeQdwoiUXUdYNcEG2XaqIxHFRMa8EdM2vDACuzd0n4hK/1EYXMWGYJO64cu/9LKMfCeWD8cJLV7FMMYQK4lCIG0mV5IV353z08hAmnEzhdv6xVHYni3nske6huS6FngoUCN4HrFgoUSAPWds63G2TZ08ncdocrhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hOeQAxMw; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3c70b652154so750823b6e.2;
        Mon, 15 Apr 2024 08:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713195025; x=1713799825; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NNsBRT2806nZawRm7N64X7t9dzJa/NSF8sGld+4OCSc=;
        b=hOeQAxMwfZbEWOM51Ki59RRTzdvy49HfUC6xKIXHQCupwCKnvvOxR7GJGkCgOEWX0B
         uoV2lJFA+6rFgwKguB081TzkG090gg0jRzL6tHko0jUwaFkPabv7YkZxb5uFJuOs/l+q
         5fn+AUTvowdgNFpGrPVyOblK/D3Ka0N4uT2HPnEpGgz9XJU/Hf8sjLAh+aR+cj/TJmFO
         i4yWAoXe59aEzYXHwqLZNKEZUVSirL9p7b01DLtJVy5NtDVqRPxooc8TBhx/Q9rVmT2F
         QPq+YK7kvBYJt3BkTw3hjGGc9AbXZXqxqA4O8wMNNWmMcEDTd+V8w0Lp0L89FbpzF5Dx
         AZsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713195025; x=1713799825;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NNsBRT2806nZawRm7N64X7t9dzJa/NSF8sGld+4OCSc=;
        b=muFS7n79XaWZb6P867ErJ4oKWTMPIPImEGbl8NGxld5PLxbkyfkK+YIoq1/hKhW2dP
         J1LZfZ6zXfZt7JHehFBbkvA0bM69qMulvfRaHnn0p3+54q+6JlvV65h77b7+5nez05b1
         wRUu0FVbqF1ClET7dVYiAwl34melubHLcmfj/Eelbv1ud4O3zPaXJCuXGmEGdlVU8UsE
         fqidIwUi0Nb55d8fIaf0dg2fh8Q1TWmK0yxnrTz6hKp7d0Euk0qZ1cvb4LTSZO02Vups
         zuQ3QfVH1jFj5sVPztkpK+Y/OuPFIN9TaQP8QOpdjgRBam4AU8uu7Nqa39FHIKRIf0ed
         u75w==
X-Forwarded-Encrypted: i=1; AJvYcCWDqMWYJtZjiQwl2XCjqPNGctTgmotC9hzsg3pBKPcV4w2XEL/JRO81SLt5kIx3rISXNq3ByqYNqavexvX7M11V7J129X9jntuni1QXMkPx
X-Gm-Message-State: AOJu0YxZaC0CHhVyg4ZrUrE+gh+mCTFCmIp0mR9foPgQYhp7VtfG+ziI
	fd1bif3WZIuR8W8cfFlMSD7AeNVKzlayNfSTXNj226+88jXltWdX
X-Google-Smtp-Source: AGHT+IH+k8NvC5BmVqv1Cn6JSAUXDVUNwDZCy1LS5iXRzRF0clGyE/vuITD/I5gXgwC6cwE9+9EeAg==
X-Received: by 2002:aca:1809:0:b0:3c5:ebe6:1848 with SMTP id h9-20020aca1809000000b003c5ebe61848mr10436706oih.47.1713195024686;
        Mon, 15 Apr 2024 08:30:24 -0700 (PDT)
Received: from localhost (73.84.86.34.bc.googleusercontent.com. [34.86.84.73])
        by smtp.gmail.com with ESMTPSA id o22-20020ac85556000000b00434b1f4e371sm6119276qtr.13.2024.04.15.08.30.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 08:30:24 -0700 (PDT)
Date: Mon, 15 Apr 2024 11:30:24 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 davem@davemloft.net
Cc: netdev@vger.kernel.org, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 shuah@kernel.org, 
 petrm@nvidia.com, 
 linux-kselftest@vger.kernel.org, 
 willemb@google.com, 
 Jakub Kicinski <kuba@kernel.org>
Message-ID: <661d481024484_1073d29491@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240412233705.1066444-1-kuba@kernel.org>
References: <20240412233705.1066444-1-kuba@kernel.org>
Subject: Re: [PATCH net-next 0/5] selftests: drv-net: support testing with a
 remote system
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jakub Kicinski wrote:
> Hi!
> 
> Implement support for tests which require access to a remote system /
> endpoint which can generate traffic.
> This series concludes the "groundwork" for upstream driver tests.
> 
> I wanted to support the three models which came up in discussions:
>  - SW testing with netdevsim
>  - "local" testing with two ports on the same system in a loopback
>  - "remote" testing via SSH
> so there is a tiny bit of an abstraction which wraps up how "remote"
> commands are executed. Otherwise hopefully there's nothing surprising.
> 
> I'm only adding a ping test. I had a bigger one written but I was
> worried we'll get into discussing the details of the test itself
> and how I chose to hack up netdevsim, instead of the test infra...
> So that test will be a follow up :)
> 
> ---
> 
> TBH, this series is on top of the one I posted in the morning:
> https://lore.kernel.org/all/20240412141436.828666-1-kuba@kernel.org/
> but it applies cleanly, and all it needs is the ifindex definition
> in netdevsim. Testing with real HW works fine even without the other
> series.
> 
> Jakub Kicinski (5):
>   selftests: drv-net: define endpoint structures
>   selftests: drv-net: add stdout to the command failed exception
>   selftests: drv-net: factor out parsing of the env
>   selftests: drv-net: construct environment for running tests which
>     require an endpoint
>   selftests: drv-net: add a trivial ping test

For the series:

Reviewed-by: Willem de Bruijn <willemb@google.com>

I left some comments for discussion, but did not spell out the more
important part: series looks great to me. Thanks for building this!

