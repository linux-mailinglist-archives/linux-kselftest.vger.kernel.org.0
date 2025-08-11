Return-Path: <linux-kselftest+bounces-38735-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B820B21997
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Aug 2025 01:56:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67263160384
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Aug 2025 23:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2740528D850;
	Mon, 11 Aug 2025 23:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="kYfCbCTq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0EA835959
	for <linux-kselftest@vger.kernel.org>; Mon, 11 Aug 2025 23:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754956561; cv=none; b=CWheESP8+ckatiwUAbrQxQ+o9W3cACwQx2kk+HWOqSdHM72ylNsPH7ibaDDMvKNARW45+Hvzqp3LECxp/1wVx5KmSt0ILDPtpMSkGt40sV5JJospx2dh/iHWwT3Qxtna52jveYZYCjg3QJBdtzSB/vBfpOfdA/rN6VbvjehH3EU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754956561; c=relaxed/simple;
	bh=ZSZH875hfmzEjtSo4B20i5Oa4she6b7rPraPJrCuigs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LL/eGjwFpbBI9ou5A3OnoXYqwwQjEanWf0pdn1PRF/9mvWZjeSGyq0ha9qajcGFNbR+DrvVvZchqjDX5VJn2h1J/+AN4ygzLyoIkHg6/WOIcLNYiacKrDOH2hRQ2yrqbeEgHGeIcL+OlX+6IuN0Tmp09oSIcW2+aEDK/4YmrG8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=kYfCbCTq; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2403df11a2aso32791345ad.0
        for <linux-kselftest@vger.kernel.org>; Mon, 11 Aug 2025 16:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1754956559; x=1755561359; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZSZH875hfmzEjtSo4B20i5Oa4she6b7rPraPJrCuigs=;
        b=kYfCbCTqJclEjDVdWv3+1zYghgWky0yULFRfUnkZBiCaUPNp4BKXYXDmg2HN/TsJla
         9uNM3+IDF/NKZipxs1QKWen1/Ok0HNKQ8LmYEj/4ZTgAu7iAn6CU8AP7piQTxAvOhEVL
         Js0wW1XJaNANnEuN0AiSWrJRH9nU8xnOK5TTkWcD7olyvdkJYNnnFxOIXRvlPdA7qdYX
         krZypjf9A5XckdxFQ9QOPv7ISOqB+llwDUfQXc6xkUIxxlDjNEpSxR8wDuvC5GlpZe40
         3oiE62ql0hncqUrH18JNmg7YQfYwg8osZCLBT7cga6J9ptlmeZop1+eMFi/AlGj9GzUO
         Hbew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754956559; x=1755561359;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZSZH875hfmzEjtSo4B20i5Oa4she6b7rPraPJrCuigs=;
        b=YKPlw5+TAsIITlfUB7AK2sJSqj4elyCYdq/qNieloPrEFsEfjfViP9i0aawuR0MJPW
         N64r3MZ+ZPMGTCItNLLMDC1QTM2S0sbpjJH4hdy2vAQRkTnJf/JFutcwhtL9bjfgm3ng
         MkcOrTQy59D/eqv0VKSV+7w7leAZRpc/J0FdwMkP3KFqHCrKI58fs3qzb9eNI78EHWnT
         6E6MctxtdNSZNz8aEjzMYwi+p0Ec8/rvKwYL89AfC9Ik6nhntIVM+/uibVqABUNvS77k
         ptKwwq8Mw30bL3jKj+3pcz1Cit9Nh2hqTK9j77EctjUlc8MHVymzyYiBex/29IM026Zj
         /glg==
X-Forwarded-Encrypted: i=1; AJvYcCV+6xTVWlx0Mdl/dpaKtEr5tOwJC3QrgnizepmCAMS76jbsz8kXxiNACOulYcTuBzUB87quuN4EIgm7SubRJaY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeZe6+jg2yohlOwxTRsUI35U6Qm+zW/VVxz1OpzaiVoMrX4ruB
	4XrX9rfQcT+ohFsgr//3sldT/XqWO5YwozTJUhJvU3FX60zPZOadaI6wF/Rj7mGfBnE=
X-Gm-Gg: ASbGncvDTt3AT92l546WN6LiBXXi8Ko+9kYwPKG3Ha9/spAtRIKsqOm2adBu1alyIoO
	Qkb7Foemc+vclSxcGfZdSywNaoRl8SzR0sUj4Estqhhds7Lr5JwrBzej5x+PME5MmOmemciJuRm
	TjUqaQWgvW3Mzti5Z5GOZ64ODshtm0H/3tw/DuZivJnm4NwH9xBXCycUimcLtxUWV9B6TB+aHzu
	bNsMyQTQS35SKZxKko91DaC93/Xct26/EONNlmzelOvwGwJapeI+UoQUDgZhBZLNuZdjWJEHf0W
	YbGD7uLrSvVrdsAWoMVRiD/OiPj+0Cxqz443/Jwb1+DK/ZVC2eWc9Jt2XauXmKsVuqrSI5i91pQ
	KF7zan53PQ9UyN+wrs3BlPRhd1UyKEj9PRw78I/LWwsNy8/otdZ8ziDSETBxSsfcMi/s=
X-Google-Smtp-Source: AGHT+IEO4F2oqpKV+JV93A292iPe0aRlvbeyH6lJCXqp41wK7PZo9M552zAFRviLOLROCmq3HYIhJQ==
X-Received: by 2002:a17:903:4b24:b0:240:9dd8:2194 with SMTP id d9443c01a7336-242fc2a5c3emr20038575ad.22.1754956559098;
        Mon, 11 Aug 2025 16:55:59 -0700 (PDT)
Received: from MacBook-Air.local (c-73-222-201-58.hsd1.ca.comcast.net. [73.222.201.58])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e8976a06sm283682825ad.81.2025.08.11.16.55.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 16:55:58 -0700 (PDT)
Date: Mon, 11 Aug 2025 16:55:56 -0700
From: Joe Damato <joe@dama.to>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	shuah@kernel.org, sdf@fomichev.me, almasrymina@google.com,
	noren@nvidia.com, linux-kselftest@vger.kernel.org,
	ap420073@gmail.com
Subject: Re: [PATCH net-next 2/5] selftests: drv-net: devmem: remove sudo
 from system() calls
Message-ID: <aJqDDIZxNAnZ-I8W@MacBook-Air.local>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
	netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
	andrew+netdev@lunn.ch, horms@kernel.org, shuah@kernel.org,
	sdf@fomichev.me, almasrymina@google.com, noren@nvidia.com,
	linux-kselftest@vger.kernel.org, ap420073@gmail.com
References: <20250811231334.561137-1-kuba@kernel.org>
 <20250811231334.561137-3-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250811231334.561137-3-kuba@kernel.org>

On Mon, Aug 11, 2025 at 04:13:31PM -0700, Jakub Kicinski wrote:
> The general expectations for network HW selftests is that they
> will be run as root. sudo doesn't seem to work on NIPA VMs.
> While it's probably something solvable in the setup I think we should
> remove the sudos. devmem is the only networking test using sudo.

FWIW, it looks like:

virtio_net/virtio_net_common.sh

is also using sudo... that said in general I agree on removing the sudos, so:

Reviewed-by: Joe Damato <joe@dama.to>

