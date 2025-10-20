Return-Path: <linux-kselftest+bounces-43632-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id ECF17BF3FE7
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Oct 2025 01:14:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 76AD94E61D4
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Oct 2025 23:14:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98D7F2F6919;
	Mon, 20 Oct 2025 23:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jXW0Im8x"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9BF22F5328
	for <linux-kselftest@vger.kernel.org>; Mon, 20 Oct 2025 23:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761002088; cv=none; b=dnB+3cn7djHjG6jTk4hvLQmi5nZNSwHLlmyzojC1YwfAXMMMU7mOzdRGIHrwi8GZu7pdSq0Rb6YnzYwhC60NvOsOftA3L7kPSjUALOxlB62PFCw3PztH0dSL5RcFxK2b5pdHAmziOjbBlc2eJnZ5x8ORP7UYAZGdnBX8YA0CMcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761002088; c=relaxed/simple;
	bh=F9XmdbMoYNlCr4el47J3Bv0ZE391rmUeYD178V6unOs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DOrnsChq1k+p1J/Eptdl7nBbhbxUxs+W/D+dVmA9pZBpfxv2wp0zgmlryTtMqyLqsKFypVBz4eHhVgW/PK+iILL9KPN5bl2UlJNoet1qekuV5LJVJOWJyJ9Uk7C6+8+zKbSf1eJ0sG1myTIqp6GnrHiAruGo3/9cIbsmhn/t8NY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jXW0Im8x; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-47112edf9f7so22411165e9.0
        for <linux-kselftest@vger.kernel.org>; Mon, 20 Oct 2025 16:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761002085; x=1761606885; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GkTarXuXdqwnRmmvR/7gRtPxkDyx0bQrkvu8spcNQuM=;
        b=jXW0Im8xftFMOJXYzU0n6ULhX+irbQkpzeCfToouT9J0J7qOqlTcwNLv4rnrywLgkz
         KJvApIotTDEhiZ+GUAtDFGRAbJkN1unJWYSE+DtMND8UC+Ibs3Hxp1oIkJ6JMKfXBTuf
         +YZwR7vjWH016zf48z39EdNzOsfbaE7noDWuTTv/x/SAQbG2z4mrYKrX5E+eMbUcPjTS
         vtq6Cw98xkyW8C/oPHsxW1T1hDmoH6VDrGcVsj6wdJZ1sgEJGOSGW8ynU/GnksRzn6ue
         761rlNBKr85NI3CQAZdPS/S/ttPbTaMqb9M+9vbHw/qI7gQIRZyZboV4k6zTUjU3gF3k
         pYxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761002085; x=1761606885;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GkTarXuXdqwnRmmvR/7gRtPxkDyx0bQrkvu8spcNQuM=;
        b=ac9UzDK1UneEAhL6N5igiMq2HpD3yEapFQ3vcQPDffF7GI2oA0d1oXmEhk5FXo12M9
         /CwvOBgN9Y7VS/RwFUSacC2LSIexHEqlcW5mUZm/OWOGxhD3CpC3ZGc2m/ovdJBy7qx/
         C+6a04LbrK8mgDMtvTRYiImcI8UqSRjQ11amVT8pLVAaIUI6mPM8Et/LXyRcqAHhNbzS
         neeJT0UuAWevcJgilXh57YzAgjyjH5UO5uHHQn6p/im6wba5WN5ETveW9mYggn/oA4/W
         9pl9Pe5tKpmZrYTMo5/MrWiuHIhEBxDAiucmLcOYosKIuGcN92uwwD8+R5dJN17V9Ny/
         GseA==
X-Forwarded-Encrypted: i=1; AJvYcCWuwQThqKfubWic+Dgdu5uT4Cuaux/wQliuTE2udIVJhs4lpIGMwoy/37M9+OffZUHIf8QPl1na7SRnH8FPUy4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzk0xdKSywt6n7RIQCB1yTUyWfFUUQyxtK7Xd7ydFFknZDgNLgW
	JUQ8T6AOrm8a7308W5z2C/AoCAOTZkGGmuAgdtLnp+5caJTr/rtk3zEn
X-Gm-Gg: ASbGncsh2Pacja9n/9Ouh/bk3zOrTu8kigbWxQ4OZow9cPZ3w/gRVX/z9EwPsMiLMZM
	EWKBzs3iwfFiJv7EdCgdckxe9VcDl0w0Fn80WkXTiVAhbkDWE9e6Z4E27FcbUaRZGSPbzpZP4u+
	hoedO2xg7xiijngfI4oufxJrvDWJCuP5iZPEeG/r3BrtHj5U6TjRvEfqwSpDjfNZIrzXK4ohYQD
	4TwOXGVu3Z6ZhSy4p70gjd/3bioMw6W1oobs62nQGVNwTdTC5kTZ5ytodnF4UMg6FK3VrvHe1rY
	cFBwH5TZQ9lmQ1sQctPMuVrz/fPNRfze+LnfBpM0RmLZrdusK/u4G6IuOJPA6vsG5RbLEA7aLdG
	JmtE2M13CFYVVOZAotcy6Bszw7lzdfzy7d2YSXPQo/DpE4AqDLj3//yShNU592A/PU8l2VNcnvI
	mp37gkvA2+s/AXFKSsdA==
X-Google-Smtp-Source: AGHT+IEo9EX3KYMSBA1tzRcWECn+Ied0y6jeP/WpvATQ9dbq7Lz/7CbUrDecochWfyk3s8hotzootA==
X-Received: by 2002:a5d:5849:0:b0:426:eef2:fa86 with SMTP id ffacd0b85a97d-42704d83873mr10529691f8f.11.1761002084931;
        Mon, 20 Oct 2025 16:14:44 -0700 (PDT)
Received: from archlinux ([143.58.192.81])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427ea5b3c34sm17204706f8f.17.2025.10.20.16.14.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 16:14:43 -0700 (PDT)
Date: Tue, 21 Oct 2025 00:14:42 +0100
From: Andre Carvalho <asantostc@gmail.com>
To: Gustavo Luiz Duarte <gustavold@gmail.com>
Cc: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Matthew Wood <thepacketgeek@gmail.com>, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net 1/2] selftests: netconsole: Add race condition test
 for userdata corruption
Message-ID: <uaxu3wlt5jqhzibmhjy44sb5mlekdezqbt5b3p2e5zza25jcpu@uqxdynirj3lp>
References: <20251020-netconsole-fix-race-v1-0-b775be30ee8a@gmail.com>
 <20251020-netconsole-fix-race-v1-1-b775be30ee8a@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251020-netconsole-fix-race-v1-1-b775be30ee8a@gmail.com>

Hi Gustavo,

On Mon, Oct 20, 2025 at 02:22:34PM -0700, Gustavo Luiz Duarte wrote:
> This test validates the fix for potential race conditions in the
> netconsole userdata path and serves as a regression test to prevent
> similar issues in the future.

I noticed the test was not added to the TEST_PROGS in the Makefile like other
selftests. Is that intentional? 

You might also need to change the order of the patches in the series to
make sure the test passes in CI.

> +cleanup_children() {
> +	pkill_socat
> +	# Remove the namespace, interfaces and netconsole target
> +	cleanup
> +	kill $child1 $child2 2> /dev/null || true
> +	wait $child1 $child2 2> /dev/null || true
> +}

Calling cleanup before stopping loop_set_userdata causes writing the userdata to
fail. You might want to move the kill and wait lines to before call to cleanup.
Additionally, shellcheck also suggests wrapping $child1 and $child2 with double
quotes.


