Return-Path: <linux-kselftest+bounces-7818-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD2DE8A3393
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Apr 2024 18:20:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC7E1B24065
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Apr 2024 16:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1F1814A085;
	Fri, 12 Apr 2024 16:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="gvijH1f7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1566D1487E4;
	Fri, 12 Apr 2024 16:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712938708; cv=none; b=KFI0tC9Wtr8a+oDKhhRgDv4P0ACtErw02pHdhlGno6uerv8C9WjiQ3BzpC3ToKxjzg9LUxpsjvQjHcMoWg2XFdLLZ8U/8tS4wWqXDJwtARlIoW1k01NFpScxG4Zq+RghsEBQrMPBV50YdTbFHQRIA5+G/YYcQTnKYNGt2qdksl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712938708; c=relaxed/simple;
	bh=H1fM5qZarUTqTbPcEiWO1kQWJYXX9Yqz5xJmMTOWlBo=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=XFEd2UeiSkqD/43zt/MwZml01FTmY9pGTuWN8yQ8f8V8ePbPf7qjoohB0B0iQ3zPaGoQRlaNV9YXyWsx1qGqVv/1uBf8rGpguXYDnUDIaNnba0GrC2CT6TbUkOXzrGWr/5qSk+hZZcpyBGMNsi5ZJ3JGXQvr9dHIfs63RFcB26M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=gvijH1f7; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=bA1H0J9aZpfqPqx5MnEP2Av7FJoToVyToQ8NSU4NpeQ=; b=gvijH1f72SJdDDxXvBlhF6M4ze
	9Z1Z/qnRzbjNaRnt7P5IkGiwYQYTVCQHtwaOtbDeIEBYC4SQauR93sMOeCQDvPRFmxU57lys1YqxQ
	JrQWJ+hVMuJ9zptkpp21DphWLnW7EXvRO6sr1ONKkZMJNg9m1E/32fdH/TmBX0HAn/y/aU+aMCEFw
	584GfxI9CFbfjtkN6a2F1+ZQwNxxxMLOczHzdaBbFJBUc7StYAjC8GYaw9GFut2Q5hObW7YWIwvOj
	jWTqngA3cVXClJLEKjYk7SXUOuH80h0ujw811hHQBPCptc7oFJCG6wGlqGJ4ZzzBarAgTIij/whL1
	PRmsY6rQ==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1rvJbU-0001jL-93; Fri, 12 Apr 2024 18:18:16 +0200
Received: from [178.197.249.56] (helo=linux.home)
	by sslproxy05.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1rvJbS-00HALU-2d;
	Fri, 12 Apr 2024 18:18:14 +0200
Subject: Re: [PATCH] selftests: adopt BPF's approach to quieter builds
To: Jakub Kicinski <kuba@kernel.org>, shuah@kernel.org
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, ast@kernel.org, andrii@kernel.org, martin.lau@linux.dev,
 eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
 haoluo@google.com, jolsa@kernel.org, mykolal@fb.com, nathan@kernel.org,
 ndesaulniers@google.com, morbo@google.com, justinstitt@google.com,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, llvm@lists.linux.dev
References: <20240411190534.444918-1-kuba@kernel.org>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <da485e3b-7b35-f701-45b4-9c3914ea6456@iogearbox.net>
Date: Fri, 12 Apr 2024 18:16:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240411190534.444918-1-kuba@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27243/Fri Apr 12 10:26:33 2024)

On 4/11/24 9:05 PM, Jakub Kicinski wrote:
> selftest build is fairly noisy, it's easy to miss warnings.
> It's standard practice to add alternative messages in
> the Makefile. I was grepping for existing solutions,
> and found that bpf already has the right knobs.
> 
> Move them to lib.mk and adopt in net.
> Convert the basic rules in lib.mk.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> If this is okay with everyone, can we possibly apply it to net-next?

Yeap, looks good!

Acked-by: Daniel Borkmann <daniel@iogearbox.net>

Cheers,
Daniel

