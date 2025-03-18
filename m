Return-Path: <linux-kselftest+bounces-29389-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8162BA68065
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Mar 2025 00:04:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCCFE17E5C3
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Mar 2025 23:04:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 094371EFFA8;
	Tue, 18 Mar 2025 23:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eCJGVl+G"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F0FD1C173F;
	Tue, 18 Mar 2025 23:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742339074; cv=none; b=KVlsovIJF0OX52RJpaQK9MWL1qoVANWSZotZCjeAhezuy3Wcp79tCfILo0ubmM5YoFGk0qg+k7TioT4tdaEQa2rlgJkK5ita+BQDECCKk8yGlGpcnSEMFvp5MDhWD4g6LOr1PHhIEJ8Z0lYdwPEoCEI2YKrU4O/4ZR6iXZhl4DU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742339074; c=relaxed/simple;
	bh=gmNZ6IPl9zXDBeh9ZjFNjg8N6dKW0ToBTEg5KCDWQGE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rnA69d2PNqIK4lpds2iuIH9Xv0L8+IjLRbiHKVd2jENGnKYFBbHvrzi3IUPI/x4WbSpHPPbCtC6ET+H3CQwzcpovw1pFeI9i/vzc6hI8jwTfwXe6TNko83gOnOTkv3/J6zBq0wCvjv2yu4la7aJ/x2y09AmzgqH6pBKDjw+EIt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eCJGVl+G; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2ff65d88103so7799775a91.2;
        Tue, 18 Mar 2025 16:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742339073; x=1742943873; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jILkdiZg4f6EaPJ9Z5bkECOAiyPcZ7OzGqb7BSQ0NhU=;
        b=eCJGVl+GA5P+9qfQ6ek4v7hKo+ru+3T/iLnH6LHYoSi1oopNIh8CA5sowUsswK9PiM
         H/NN8QnHLKF/zhesCNwGX39IlEBipH+fyJFn5txFHaoPwmFphnmIR1gT1MUzUTtUke6e
         JgZ1yMyHL50D9nihrDBXIGAQSaYMEobx2mpbVF/6lgFTRksbaujqCgZcLMN1dDjEK3Vd
         Q6vSG11p2rvGNb6tQu5mgDsPkGbRQreKvRtTLvK2qeE/r+gEZ3zztcB6TMiBRrzMr44D
         cQH+QjtLuxLEJbXw7UkbSm3QnQfdnyZUNPMoNk7DgeT9wYzYEwW3QLrL/7MA4oVD2fBJ
         JUOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742339073; x=1742943873;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jILkdiZg4f6EaPJ9Z5bkECOAiyPcZ7OzGqb7BSQ0NhU=;
        b=PhsEQkC9UeqJI7rno8nULdb7+khJ9zDkCDhSnlghr+VzX7L+8L6GEDRj0hgVkEbeI/
         yubmaQ0bgAA7qwtvhJLdpfLn/cMvTxz6wKMY4gWA5y6dP/ARcJGyU7lyJIiCUd4+8XA6
         n9/UKnEcGCATkMgt6Oup2qdtLsefm9OpyLnzzVofWXe76p48PcCzG3BACp9X2hah3h2m
         hOcNGyZEiD0vuziFy/W+8LhnKh1AAvjpM7s3p2oQiYEYo11q1o35Zp4b6d/5lyZRtdLV
         uS+unwgGcOFu3rMZ5T5iKRD52EdwaF8oWre3bQAUFbbyO9ds8/LkwfFhPatFxdqGnXrX
         yheA==
X-Forwarded-Encrypted: i=1; AJvYcCWtt/bio6XvBi3lbbWVthI0+ocXiKwro4X4f/roqKcZTHzmvgVh17Zbm40hnd1OXGzZnd78fslgKlgSdL0=@vger.kernel.org, AJvYcCX1VmqA9zFcd9/TuotqGYjZnGrywZEEjWyDgUxEw41WCWIX8ToBVNg3lYWSqH4oHbDvrztmc7q+ZdhnT+pONVST@vger.kernel.org
X-Gm-Message-State: AOJu0YyNjoEqZfM4feR9DBAqh9ZfAoIEL3MVTkJPSjlCf+eWbwtZO2u/
	hnA1SYvIuJ8n3WX7C6G1HLvTrEbSOhZ9KXqu1JclZHSbd03CPOKPKP0hhfQqaktRZrJfre5q6xh
	sJcP9s/Khx16OHRmjTdecWB2ybyg=
X-Gm-Gg: ASbGnct4l5k+0VuYuywpskLcr+45ZNQ1Le5pM6x0WMDT5wNW/7l6rK2W29yUVdMebm+
	K/hiG4kpCS/SskRHPl+eqbKl+4DfMWVL4ww7IsJffqV0E4ptme7ZehKPGPf0jyMn0ZQEyQ8hE4v
	qveuJ7fMCSSP5zPjRdzw76UdG3yA==
X-Google-Smtp-Source: AGHT+IFYxDuGL8Xq1/MOJ5b4LHTsE+r4dGJ3RiHYiz2UP8tBekZEr4CQjSL/OMc+N5QXXhutH//VLbYe4MfNCQ+cDiM=
X-Received: by 2002:a17:90b:4b89:b0:2ff:4e8f:b055 with SMTP id
 98e67ed59e1d1-301be2341f8mr791291a91.35.1742339072815; Tue, 18 Mar 2025
 16:04:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250312-tcp-ao-selftests-polling-v1-0-72a642b855d5@gmail.com>
 <20250312-tcp-ao-selftests-polling-v1-4-72a642b855d5@gmail.com> <a360fcbc-19e5-4ee6-9b80-2621fefd9ad6@redhat.com>
In-Reply-To: <a360fcbc-19e5-4ee6-9b80-2621fefd9ad6@redhat.com>
From: Dmitry Safonov <0x7f454c46@gmail.com>
Date: Tue, 18 Mar 2025 23:04:21 +0000
X-Gm-Features: AQ5f1JpIgHaJjfJ4-RofrI7tq5CHr1T5yKRwrlW_DVT5E6Q-iOZNnDL1famSOP4
Message-ID: <CAJwJo6bh1SnSs7OTPZ8YDn5eCkNRwWXSx=ckwttUxcXyg4f8GA@mail.gmail.com>
Subject: Re: [PATCH net 4/7] selftests/net: Add mixed select()+polling mode to
 TCP-AO tests
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, 
	Shuah Khan <shuah@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Paolo,

On Tue, 18 Mar 2025 at 14:47, Paolo Abeni <pabeni@redhat.com> wrote:
>
> On 3/12/25 10:10 AM, Dmitry Safonov wrote:
[..]
> > Reported-by: Jakub Kicinski <kuba@kernel.org>
> > Closes: https://lore.kernel.org/netdev/20241205070656.6ef344d7@kernel.org/
> > Signed-off-by: Dmitry Safonov <0x7f454c46@gmail.com>
>
> Could you please provide a suitable Fixes tag here?
>
> Also given a good slices of the patches here are refactor, I think the
> whole series could land on net-next - so that we avoid putting a bit of
> stuff in the last 6.14-net PR - WDYT?

Fair enough, let me resend it for net-next and add a Fixes tag.

Thanks for taking a look,
             Dmitry

