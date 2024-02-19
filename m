Return-Path: <linux-kselftest+bounces-4932-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E97BF85A6F9
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Feb 2024 16:09:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0564285E1D
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Feb 2024 15:09:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAE0B3839B;
	Mon, 19 Feb 2024 15:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Qpz1bX9X"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F714438E;
	Mon, 19 Feb 2024 15:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708355212; cv=none; b=OGiFqJL1iuaGE0SQTiOC4AMulURVSt9VM+nNE1PSM0rSlR4FV/SJ88rg+sKVYujKUUDQri64BctCt5/GjIdqXBzvKjSYnPX3ZQFNMkIUFyr0XGf0yXchYBiFrGv2H+QJs6FB0EVJf2U6TYilppN06rrCsMnFoWEptAlMhj6h1Tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708355212; c=relaxed/simple;
	bh=wqP+GHbXy5y2dWwKO+f4tx8tvMyIzJowEbRtXjlanIk=;
	h=Subject:Message-ID:Date:MIME-Version:To:CC:References:From:
	 In-Reply-To:Content-Type; b=EiJPF2m/ClkDi551lLlXH1KZLTdO6w+8QeIdfcyyqGGLemdEouC0ZPzh2K/1XEgHpUNIBMp2aNfEcVxIuUZcHnWlPkdzuGfDuTxOJxmQbPpGNHnEiqZRrZ1BEUtOhCPYUZIaxdm6MC/zsQUnhYPRsDsxMFsoKJ8SlYELtcf4GcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=Qpz1bX9X; arc=none smtp.client-ip=99.78.197.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1708355211; x=1739891211;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject;
  bh=7cweU86/OrAPAkRsQreyys1w+cw8bobHEMbIMZ1Hpos=;
  b=Qpz1bX9Xl4aUbr0p5akTMO7hEsz5LitMy1eeQl6h6we6dZz/v+ufkk+n
   70mZHBhmDwsjJEmNJtzvI94LI8lpjhZh2X4XVv3h43DZXsCobo3esjmzE
   OQK4UlimmA+pYhB5ATL0T+FVBy2wJpi4yNo2UhuHI4jPNwNh3YiWTDH2d
   g=;
X-IronPort-AV: E=Sophos;i="6.06,170,1705363200"; 
   d="scan'208";a="275092583"
Subject: Re: [PATCH] selftests/mqueue: Set timeout to 100 seconds
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2024 15:06:47 +0000
Received: from EX19MTAEUC002.ant.amazon.com [10.0.10.100:5821]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.5.250:2525] with esmtp (Farcaster)
 id 210590fd-6fcd-4877-98d1-b8d96ef4e607; Mon, 19 Feb 2024 15:06:45 +0000 (UTC)
X-Farcaster-Flow-ID: 210590fd-6fcd-4877-98d1-b8d96ef4e607
Received: from EX19D018EUA004.ant.amazon.com (10.252.50.85) by
 EX19MTAEUC002.ant.amazon.com (10.252.51.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 19 Feb 2024 15:06:44 +0000
Received: from [192.168.11.164] (10.106.83.24) by
 EX19D018EUA004.ant.amazon.com (10.252.50.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 19 Feb 2024 15:06:43 +0000
Message-ID: <f7db39bd-d11e-4854-8b6e-2543aeec1d70@amazon.com>
Date: Mon, 19 Feb 2024 15:06:42 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Kees Cook <keescook@chromium.org>, SeongJae Park <sj@kernel.org>
CC: <shuah@kernel.org>, <linux-kselftest@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>,
	<Vijaikumar_Kanagarajan@mentor.com>, <brauner@kernel.org>,
	<jlayton@kernel.org>, <jack@suse.cz>
References: <20240209174243.74220-1-sj@kernel.org>
 <20240215011309.73168-1-sj@kernel.org> <202402161600.BF1D110BB@keescook>
From: "Mohamed Abuelfotoh, Hazem" <abuehaze@amazon.com>
In-Reply-To: <202402161600.BF1D110BB@keescook>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: EX19D006EUC001.ant.amazon.com (10.252.51.203) To
 EX19D018EUA004.ant.amazon.com (10.252.50.85)

On 17/02/2024 00:01, Kees Cook wrote:

> 
> Should it be 100 or 180? Either way:
> 
> Reviewed-by: Kees Cook <keescook@chromium.org>
> 
> --
> Kees Cook

Both options may work, I am more inclined to have this as 180 seconds by 
giving more time for the test to finish, this can be reduced later to 
100 or something else if we start hearing complains about the new timeout.

Hazem

