Return-Path: <linux-kselftest+bounces-23856-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 07E16A007C4
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Jan 2025 11:21:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACDAA1642D4
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Jan 2025 10:21:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1037187FE0;
	Fri,  3 Jan 2025 10:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="P9PLbnVT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B98F17FE;
	Fri,  3 Jan 2025 10:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735899658; cv=none; b=bvKGuT/cEkeRgjPwoAKICq05H7SQwTU81w2eUoA/tlyY/+6W4L2DNWLPUKiEhbD9NWZg6hiT9YAR+d4ilpO26nnSTlnXrOpgjYKehS2MmKa/spRQwjpXJDOdEFoH6KI0Ld/sQA8XglSpeyaPO5TAphFqk5uy+0Zx31DDp8erS8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735899658; c=relaxed/simple;
	bh=iS5u4aJyT3kCI4r8MZtxXApyJfADRDqTmgkzzhsjupU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xl2zodh2lmKYhX4Iobbt0q7I5f6eVF6fIY95t8o+Rz6FFSau9WBzbhWsAfIj0WWB/bilexS9plaSmU8UN3MUnXBUMOMPfqkJqf8i61NDYM9IxvAwyBuYMz5oz+QFaLjVgaHVVmgmFzLbl9FnSZWg+1WoC9IRFFT8DcrcBG188dE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=P9PLbnVT; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3155720005;
	Fri,  3 Jan 2025 10:20:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1735899648;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hbPfjV4aPK7g/x5lbY/AQaGWZXRGEGC30D32KXQeOEM=;
	b=P9PLbnVTgSH5djpaOn8lwxGEMqGmLTWhnPtKdC54xeMrGX7Zdv7B0gpkPdLkHrOxk8Zy0s
	uz+G+7ySQjq9abHVa4ZVDPZBvG1k+KU38eSZQeKekWRUxCyuwU/6DbyIXCzbdB9toVAe2u
	bN0GfSljVu+Jvr3MdfHo24fcqpdentUYcfxHojQLuIJz3HXZHYi9U7frOwvPmAmeka5axQ
	llCuZVBcMViqR4EJbIzlJRZWMdSgQhpO+kKftnuHjJPjEiWR+pcG27+eWdkFeKf6W7/C/1
	DZgkrFNN8vExXUvJbrbecqvlFs/xxnc37OAQtNI+MC8uTG7g9Oj7ufBDjihpBw==
Message-ID: <d3bb87ee-705d-448a-b69c-bdeb650647d5@bootlin.com>
Date: Fri, 3 Jan 2025 11:20:46 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] selftests: bpf: Migrate test_xdp_redirect.sh to
 test_progs
To: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, "David S. Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Alexis Lothore <alexis.lothore@bootlin.com>, netdev@vger.kernel.org,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250103-xdp_redirect-v1-0-e93099f59069@bootlin.com>
Content-Language: en-US
From: Bastien Curutchet <bastien.curutchet@bootlin.com>
In-Reply-To: <20250103-xdp_redirect-v1-0-e93099f59069@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: bastien.curutchet@bootlin.com

Hi all,


On 1/3/25 11:10 AM, Bastien Curutchet (eBPF Foundation) wrote:
> Hi all,
> 
> This patch series continues the work to migrate the *.sh tests into
> prog_tests.
> 
> test_xdp_redirect.sh tests the XDP redirections done through
> bpf_redirect().
> 
> These XDP redirections are already tested by prog_tests/xdp_do_redirect.c
> but IMO it doesn't cover the exact same code path because
> xdp_do_redirect.c uses bpf_prog_test_run_opts() to trigger redirections
> of 'fake packets' while test_xdp_redirect.sh redirects packets coming
> from the network. Also, the test_xdp_redirect.sh script tests the
> redirections with both SKB and DRV modes while xdp_do_redirect.c only
> tests the DRV mode.
> 
> The patch series adds two new test cases in prog_tests/xdp_do_redirect.c
> to replace the test_xdp_redirect.sh script.
> 
> Signed-off-by: Bastien Curutchet (eBPF Foundation) <bastien.curutchet@bootlin.com>
> ---

I realize I forgot to mention 'bpf-next', sorry about that.
This work is based on the bpf-next_base branch.

Best regards,
Bastien

