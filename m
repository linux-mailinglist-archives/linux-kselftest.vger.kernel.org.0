Return-Path: <linux-kselftest+bounces-35978-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36E4FAEBB7D
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Jun 2025 17:18:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 170633B5E17
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Jun 2025 15:18:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65B982E88A7;
	Fri, 27 Jun 2025 15:18:23 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8464D29CB32;
	Fri, 27 Jun 2025 15:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751037503; cv=none; b=g1yFq0603L+IQ0iAXLC9Wm7nQCXJyobObDMl5BW1kzOUC74KzQ5fCp4j8esE0wtzJBoON19KkZOOQWMXTTQFKnVs2l2dDXC/WqH/hfrPfAZi2VgRuztcnUKFv/QxS3FsE8x3ljeSR6j00gBNFuNRGMYTWsmVWtX945EKyRhGH9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751037503; c=relaxed/simple;
	bh=Lo6rxtxXikP2AtCNNMfquBOozIf7tym4pcl+50VV7uE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iTXBoMPyxUK3tSAqKnQXsMI4WB6yUYxpc8Po6SPltBMPU9wrTCgSVKR+aCzBViYR6zqmwitNcojCbpBJ8CJeFKIEKJS7g0hbCsHPa6v0x0mCJ44ppoma531kp7xoUEG23vATtnui3RD1wDZw0XvnhvlC9CwszbPFWLGjalrUBME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6088d856c6eso4357260a12.0;
        Fri, 27 Jun 2025 08:18:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751037500; x=1751642300;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U8lRgH1biUhQGTYL+02KD4lPFXqEZlC13nrrma5ZHLc=;
        b=MGWbKbHVu/OPdUlMDVsoWMQ5RnvIYP7djM8W61FnRndW9WKc6RlQHE1unK3yg8Zz1F
         kuMJPQpt1nriRZiSGhqHWL+iicetIduUoXDGmkCv0jIxLiXNAmqhTybPe0eP/m2NUmOF
         cIMWJpFXnKyYUhIx1i/PGuZTezfAIFOLuqAR0w2Rzi5U229SNwD+tbZZ3X6vCjWpLIB3
         iNhKVeKFbiX2x/7Ud5WbF0kcuKSd5eKHDKOoSVKmNECjzKMH77HWduI+cKUz3hwrHqsl
         vV5uR2Bslp0jNy1e/ewO1uQD4M6TCXpAX8pueYtKKBkIjVmF+Ut0nXd1/SStpz1OdpwL
         IwjQ==
X-Forwarded-Encrypted: i=1; AJvYcCUtl8LfujhA+PnqsFQg3CuS1h2AoNWuwvrK7xAS9KnxH0g4LlegZyPTOIyLpWbxDBVUGWrg8GGfi6VphaMLJv4j@vger.kernel.org, AJvYcCVMnFPXeqxfhJcAUJDujS17PEto4iWC+9w6F9v84P/Doe6LxiaoCtQFOeI60kN5zCk9XpZyYUlj@vger.kernel.org, AJvYcCWpImxPT0npn/pxw0ryzfYyLxtbNBLnXDD0AtgxbFRsKKPC3X++IpUkSUnMQ/jrPUocJmg=@vger.kernel.org, AJvYcCWutwK+Qn0o9iquXJeHd/4K1W5LvWxFaLA40bfq+lE+ic/uTnUsvdz4OMvI1ih4SFHNvnkoXJ5iq/WKe/C1@vger.kernel.org
X-Gm-Message-State: AOJu0YzykG6rylILlWkpC4GKAcLFH8gXwtT30XtuJ/tDa27Zqk894O+G
	Yv8p+zD8kHE8YuHDs6S0mIe2pFS4JEpeItf6U1t+kF7ngpE2d6i/M6s+P/Rqdw==
X-Gm-Gg: ASbGnctrnnT7zQ0KA89/TNkasKM/EN7p9eue+kp7qN4P9/2qBsWnQ693BLxYM+kLrqB
	+gc+fhdt3bXpeJXF98/EBeziSsTT2ASKMbZW9z0xtMvLeMzRxTmYPVJWqR9Eqlt4e5QOyTtoyi8
	WZpofNdwppcOOKAkg5s9ZbxoxV1S9p+7lv3AofExaWjF+pOvbRBwcxjFp8QRJon5SCeOBgOJF7Z
	bOQ+OoEU00YPpejOVwfD86Fm2pWnNqyiamPNsu8i+qNnxKxe6wjBmez5rSWsIojXlvbqL43/7i1
	8AictNBhm/fekxPY1LdLMOJK3XWzgvS+tyjs8Qc2HM7yewycvJIQ
X-Google-Smtp-Source: AGHT+IFwcvVo44k5qgoS0WsLBiImL5rqTNP/JLUzJdgdqGiCBpCnJx2Csuf9n7nfAII6kn6t9zizsQ==
X-Received: by 2002:a05:6402:4402:b0:607:20b1:7485 with SMTP id 4fb4d7f45d1cf-60c88b3c1d7mr3078372a12.2.1751037499401;
        Fri, 27 Jun 2025 08:18:19 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:4::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-60c828bb1d8sm1617361a12.6.2025.06.27.08.18.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jun 2025 08:18:18 -0700 (PDT)
Date: Fri, 27 Jun 2025 08:18:16 -0700
From: Breno Leitao <leitao@debian.org>
To: Simon Horman <horms@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	bpf@vger.kernel.org, gustavold@gmail.com
Subject: Re: [PATCH net-next v2 4/4] selftests: net: add netpoll basic
 functionality test
Message-ID: <aF62OJinqv+FVu1z@gmail.com>
References: <20250625-netpoll_test-v2-0-47d27775222c@debian.org>
 <20250625-netpoll_test-v2-4-47d27775222c@debian.org>
 <20250626082505.GA183673@horms.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250626082505.GA183673@horms.kernel.org>

On Thu, Jun 26, 2025 at 09:25:05AM +0100, Simon Horman wrote:
> On Wed, Jun 25, 2025 at 04:39:49AM -0700, Breno Leitao wrote:
> > Add a basic selftest for the netpoll polling mechanism, specifically
> > targeting the netpoll poll() side.
> > 
> > The test creates a scenario where network transmission is running at
> > maximum speed, and netpoll needs to poll the NIC. This is achieved by:
> > 
> >   1. Configuring a single RX/TX queue to create contention
> >   2. Generating background traffic to saturate the interface
> >   3. Sending netconsole messages to trigger netpoll polling
> >   4. Using dynamic netconsole targets via configfs
> >   5. Delete and create new netconsole targets after some messages
> >   6. Start a bpftrace in parallel to make sure netpoll_poll_dev() is
> >      called
> >   7. If bpftrace exists and netpoll_poll_dev() was called, stop.
> > 
> > The test validates a critical netpoll code path by monitoring traffic
> > flow and ensuring netpoll_poll_dev() is called when the normal TX path
> > is blocked.
> > 
> > This addresses a gap in netpoll test coverage for a path that is
> > tricky for the network stack.
> > 
> > Signed-off-by: Breno Leitao <leitao@debian.org>
> 
> Hi Breno,
> 
> As it looks like there will be another version,
> could you run pylint over this. The NIPA invocation says:
>
> 
>   ************* Module netpoll_basic
>   .../netpoll_basic.py:323:0: C0301: Line too long (111/100) (line-too-long)
>   .../netpoll_basic.py:27:0: E0611: No name 'bpftrace' in module 'lib.py' (no-name-in-module)
>   .../netpoll_basic.py:79:11: E0606: Possibly using variable 'rx_queue' before assignment (possibly-used-before-assignment)
>   .../netpoll_basic.py:79:21: E0606: Possibly using variable 'tx_queue' before assignment (possibly-used-before-assignment)
>   .../netpoll_basic.py:253:22: W0613: Unused argument 'netdevnl' (unused-argument)

Thanks for the report. I was able to reproduce them here. The next
version should be warning free. I hope. :-)

Thanks for the review,
--breno

