Return-Path: <linux-kselftest+bounces-22722-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DC1E9E12D0
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Dec 2024 06:15:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8101AB21B33
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Dec 2024 05:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE6C2166F25;
	Tue,  3 Dec 2024 05:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="do+0H8dL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73FA8817;
	Tue,  3 Dec 2024 05:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733202901; cv=none; b=kSnzObOUAxY0qjLJfydt0MqiBkcSl4c+A7nIGK4aVdKbQmTSrsBifqYDH3PFko2A07qOJgdr1j2AItAjuyv0UvfqSqlbi6o+a9+AIlI1sU6NLgSdtszQci0KsL3z6Tuec39rZ77NrFwxH1ZHNl9q6jbq4QRQoFBW/C+6psex12g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733202901; c=relaxed/simple;
	bh=xIaJa+NSbdE2QEly+jxjzNZXQhp1uMHwhx7F7u4wmrM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hYiST5tP23VW18C7+gs7n2dQuFhxkwPAYOcQa6piSRsl5fWRrlXWlLq3izUfZ/c92y48E4K+2MqeN3JD0hccxi97Sdxk/ZokruaBIztYsBeEHOhy1J7nvM9E4OX4Fz5GeGVndD2PdKvm7n7LcvPWUJ9qtBq4hpCdkxtCGZVKkRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=do+0H8dL; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-7fc8f0598cdso4295020a12.1;
        Mon, 02 Dec 2024 21:15:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733202900; x=1733807700; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OplFaKW8tTlpx6QNBTj6KxzPZVnj+b3RXvlOwwHvJEI=;
        b=do+0H8dLTeUnWtLOvW/X8/hV/D+SCLsy6X0l813Z1G32Hd7JwIixpxeZgDlD5sGnMN
         OjHjGZ++0ZbObw+UvGpiZuJZPF2WQrRQ8Sb3S14QdrPeZ9CwXNDam+30ETvtu/W9hWhH
         r7GgoEF6aJ+Fo4iQMQzWwSYY/rIkodZqQ9lua2ZlJ3LNWYolo/p5NFkxBNJ7VfPehA6+
         /OCPF1lA46DOiWzVkI5SUKYMI+p90UkkBfgfM79dQChaqBWUPvQvwmijDnjP8wCWMcAg
         98wyeGxO0RJCdxRjeWk5xX0PR2SLbLRREM2CUZ1UvfWH7XowmqjLpFpjYLpuyIartwjC
         ghRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733202900; x=1733807700;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OplFaKW8tTlpx6QNBTj6KxzPZVnj+b3RXvlOwwHvJEI=;
        b=AdVosX5Bt0wT7ll9AYPZg1387P1UUimof8Um6MtRI6EhcyJ3+OkdDWypj4vDbC78zE
         LMh6v8eK55vDn49dBd2yIf0jqO10XBl5qNCECCS1ZyLI32WR32oAf+nQQr6LR8vLNa0Q
         VmCuiBvBIrB+SxAU9Ufi+wjuVKEFb+jU9tW3ikSx2eDixICsn17+64FpvoUQkc0sn3w8
         JHdr99AkrwbLbrKRo29+d76b1Xv9ci7hSpfhT809ZHHaYA/UoHWwVd/ImY3VDFcCn4tI
         QImcWR7d4izlY825bnZ0Z/YRKEsuMkjSbwWUr5pPo7d7NyXhA7Mwd6tBELfgpgh4pnzr
         0+bA==
X-Forwarded-Encrypted: i=1; AJvYcCUY0pWXoy++LWIaNg0SCHSLNlsE3JYfKMCX0Zk/jqarSBulBN6Idxi+dXTdMuv36m2skEzFafYk26lKE4c=@vger.kernel.org, AJvYcCWUHDm8jfvg751ispxqQvs149RIbxh/dDFqfovvmpTMFPr8ZgIbi9iSfAhHbZ+4KCmA4GqYNNUCUgjyeggHvK1y@vger.kernel.org
X-Gm-Message-State: AOJu0YzVg+zVH5KZgEZzaDwfdHC2rXMpo+9dHw3IHDesC/7bO/J5zT6M
	fvf+dwEXgBdDe5/l7GxHd31LXRFIWWWcdH0fTuB6FqUyUZd5vGc=
X-Gm-Gg: ASbGncsq5Sr6a+/EMJEMMe2Ea6gIs7BelOBUigqWTs54NhReCElgI1+wXANXPOnikVH
	43hIARogZHZUTuj9g6R24F9FGvlotgJkH/uPnEioJs0dSk6fBz7WtScNfcRVhiGyJ7ufuLSAavp
	ZUuyPa/isfW8prQW7SeZ+U4imUBiSV5U5HznWK9EFWhSgd5C7ccxsoeSjrgw5eIkf0CUmwr4dbk
	NFZQeW//qqmn+aKUubmGauvg7TEuw43fmJojKheLXk/ZjQ76Q==
X-Google-Smtp-Source: AGHT+IE8SPLOiZpehFcsI6ZUD/w0ZxU5jUM5kP/XXZGKiuAIC2vpPfqTldbVHT7F4YhHODI05c2wMA==
X-Received: by 2002:a05:6a20:2583:b0:1d9:3747:fb51 with SMTP id adf61e73a8af0-1e0ec800265mr31292059637.8.1733202899598;
        Mon, 02 Dec 2024 21:14:59 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fc9c38585csm8825146a12.61.2024.12.02.21.14.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 21:14:59 -0800 (PST)
Date: Mon, 2 Dec 2024 21:14:58 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Joe Damato <jdamato@fastly.com>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, edumazet@google.com,
	kuba@kernel.org, mkarsten@uwaterloo.ca,
	"David S. Miller" <davem@davemloft.net>,
	Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] selftests: net: cleanup busy_poller.c
Message-ID: <Z06T0uZ6422arNue@mini-arch>
References: <20241203012838.182522-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241203012838.182522-1-jdamato@fastly.com>

On 12/03, Joe Damato wrote:
> Fix various integer type conversions by using strtoull and a temporary
> variable which is bounds checked before being casted into the
> appropriate cfg_* variable for use by the test program.
> 
> While here, free the strdup'd cfg string for overall hygenie.

Thank you for fixing this! I also saw them this morning after a net-next
pull and was about to post... I also see the following (LLVM=1):

busy_poller.c:237:6: warning: variable 'napi_id' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
  237 |         if (napi_list->obj._present.id)
      |             ^~~~~~~~~~~~~~~~~~~~~~~~~~
busy_poller.c:243:38: note: uninitialized use occurs here
  243 |         netdev_napi_set_req_set_id(set_req, napi_id);
      |                                             ^~~~~~~
busy_poller.c:237:2: note: remove the 'if' if its condition is always true
  237 |         if (napi_list->obj._present.id)
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  238 |                 napi_id = napi_list->obj.id;
      |                                            ~
  239 |         else
      |         ~~~~
  240 |                 error(1, 0, "napi ID not present?");
      |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
busy_poller.c:226:18: note: initialize the variable 'napi_id' to silence this warning
  226 |         uint32_t napi_id;
      |                         ^
      |                          = 0
1 warning generated.

Presumably the compiler can't connect that fact that (!preset.id) ->
error. So maybe initialize napi_id to 0 to suppress it as well?

