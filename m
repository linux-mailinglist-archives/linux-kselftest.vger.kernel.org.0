Return-Path: <linux-kselftest+bounces-35852-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B39ADAE9B8C
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Jun 2025 12:36:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00E121664E3
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Jun 2025 10:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BDC8265293;
	Thu, 26 Jun 2025 10:31:29 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC01921A420;
	Thu, 26 Jun 2025 10:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750933889; cv=none; b=kkT4Tf+RQfflfn8g0Wthm4X/OweS3UHYFDfzNy09S7YNNBQiGY9ThFEugZHZ3/69rtFAC1ewnRI7ym5tCvUXGIO9e6Xt9dE8VGoIVTQqBMC97anUpJX40VOv3HZ3kPSvBGq1ShjyOfG8GxRSbv/Ad3ojfmWrcp8pX5ExAzw9ypg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750933889; c=relaxed/simple;
	bh=GnDNt+q5EI8c/ZXXdaO/Ry+x4SX461tey5/yPbMiUC0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PAui7yG2oIIE2VXShNn8fGdGcjEtBHcGuGsSrOgUxoZ9Ct/cUXz9MrGQJDRtjLph/ot+DG2X8WpKRO/1Te8znVT6/Dkt4jFY7hecOeyTC31KPLndAJmpwgoYf43Jh6QFJ0PSgpzrB3MA4dDFgvvsRSnyV1YtFcVh35m5GJvUDT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-60c4521ae2cso1513661a12.0;
        Thu, 26 Jun 2025 03:31:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750933886; x=1751538686;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OmpUdW5cO4HhOMld9+otLQ45frNnQ2stlAqm727cEZc=;
        b=n3TA+GithyQbldQXglA7C4d7Ohtl4YBFeT3l0Oes+qvaUz1lyvcJjw3fIGxegeJCsR
         5JcSP3Ro4q0SwjK/RN94QoD0Tu5Qlz3K29l/K5vSgGUxhGAwmUtVfKq8E+Hc+N1bBGJm
         De09VridrF6/m6rW4y5Kg1Gisg/3pkE/sv49C//0Utl6eNeNVXHfCDo2dbv0SDwFEkWN
         elwd6He5u7jzX0RA83/362B+p80H7dyddE/b+muVD6BeY0Qz9w1grSXToirJhTE33cfy
         r/jZSdNRk52x1A2CqJQXy8ZAzM4E2myuoLVuH2MnS7dubzIu4IF+a2Me+hTbbjGumLkt
         qUHA==
X-Forwarded-Encrypted: i=1; AJvYcCUEthHSbPY3b+TKGEyPecCc8F0aL01hCcWIRmkw0TrEhCxZZ47/hQKERGj2ML93mI4p0pqlLs3vrXCHdMYxZ8up@vger.kernel.org, AJvYcCUR5CkolATV/yP7Iv9YHbK/INJ11mjPS7k1PC75RB/Uqvsv1MrE3Jhs7yt2lna7rcQFfbk=@vger.kernel.org, AJvYcCVFexzgOpTZ6SKQCAc1B5cDm1Eq49TuLnpPictFotHJDkuK6jNZlErj/bvrkczw0ag4V4fJm/jHQEBCbdB/@vger.kernel.org, AJvYcCVjghlNcWQQ6SSvQCQ7/sFRjaDw8Ma7IcQJ6bB79wqD6VawxYsG+4jIZjeMclZ5r8jIQ49bgHvn@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+D7ihM0I63oL3WS+jR+f4x7hT0psVpZXtZIa0+/yIeDzO1mb6
	V5bFzdOPguATaiWRYMgtOp90f6jXY2bbCFAIXYsEmnB+G01oPnbqpJCQ
X-Gm-Gg: ASbGncstKuG4erZnD7Fy72ZW1gF4BznTVseyAE5/wRWtLv3csx9CerkWGEvgcnZwjuT
	BcmlOufIbGw61m6Ghoja2dbatCRzSwzgpwZFDHiMDTixH1dOfvUd+CZplvKswbbF0zgNfHVODr2
	EKgJIgrM5iitUq5Sp3Vbjkzz6WLqwc5ipJbSV6t/qJ5g1JlIhvR47XJL2QmAAWiN5lRqSLWAjDT
	icPtz6cdFVHWeAuoz62ms/53qUipHlL8gUXRG8DTv2erKjUw1UdhyV72b/GwzYM6ukBRmILMmcb
	6zCUO1mlEs1KA6DjxqHP6UvduuZNM9Xd6D1/gAuhqZM7p8YwMbIf
X-Google-Smtp-Source: AGHT+IHd9W2v8OJUTxiUy7PQcBOs9sxn8KJRAFWKIx4csWgVqOlg3SR9T44yg3x21QnhYH8gtFjLPw==
X-Received: by 2002:a17:906:f5a7:b0:ad9:f54f:70a2 with SMTP id a640c23a62f3a-ae0be88e5c9mr636284366b.22.1750933885862;
        Thu, 26 Jun 2025 03:31:25 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:4::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae0d4815f46sm126845666b.185.2025.06.26.03.31.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jun 2025 03:31:25 -0700 (PDT)
Date: Thu, 26 Jun 2025 03:31:23 -0700
From: Breno Leitao <leitao@debian.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	bpf@vger.kernel.org, gustavold@gmail.com
Subject: Re: [PATCH net-next v2 4/4] selftests: net: add netpoll basic
 functionality test
Message-ID: <aF0hes00SoHF8umw@gmail.com>
References: <20250625-netpoll_test-v2-0-47d27775222c@debian.org>
 <20250625-netpoll_test-v2-4-47d27775222c@debian.org>
 <20250625150919.7b06b436@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250625150919.7b06b436@kernel.org>

On Wed, Jun 25, 2025 at 03:09:19PM -0700, Jakub Kicinski wrote:
> On Wed, 25 Jun 2025 04:39:49 -0700 Breno Leitao wrote:
> > +    raise KsftSkipEx("netpoll_poll_dev() was not called. Skipping test")
> 
> Let's make this an Xfail. Looks like the condition doesn't trigger 
> in VM testing :(

Exactly, there is a chance this will not trigger it, and you do not want
this bothering you. Having it as Xfail will be a false positive.

I have a plan to make this consitent by writing some configfs hook
for debug, then maybe we can make it a debug?!

