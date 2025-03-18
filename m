Return-Path: <linux-kselftest+bounces-29356-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B3C0A676C1
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Mar 2025 15:49:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CEEE3AE973
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Mar 2025 14:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AF3020E6FD;
	Tue, 18 Mar 2025 14:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KIvnBrBs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B05B3204F61
	for <linux-kselftest@vger.kernel.org>; Tue, 18 Mar 2025 14:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742309245; cv=none; b=Vakm67JiNh+BGmjxYSXK77aDikFKJucOmwrqikNnjNTTVtSOsuqr/PD7hu80b5GDwdKH/bJWXop46d6RwsWSh8hLz5uXQLmv0u6zKzCnQ1TemnAK1l9OYWqev7y9eC9mhz+mJWSDIPfKLDl87Jw8SwE/Elejg6oxWgXaVSTLXG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742309245; c=relaxed/simple;
	bh=2igutHsuDhyuqY+mS9Se6RVpng7XykRfcC0cv+45kv8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RhmnfeDeH6Hs/thEtUMrGfs4gVeam9xdhOHxEe+WJaq7k7SMp3nvsGqjenRJ8eAePJm+SYDjH+qkS9IbtgHob9KoGzNsyd2IkgpS/n+V0SoTw/QGvRCZ+xh9AcerQIPj0Y6oTvQkwxpkGNpdE9mj8dWNurZRI7fQR/9SY/c/KOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KIvnBrBs; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742309238;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R7O+pdl8v8v7EK7Wkd4nKpzLh6vnro4c8ShYrpyfa7w=;
	b=KIvnBrBsOAbY85vnZzsxPAezI8NCCiBDjU4rxP1OuvbYiuHHnbUHWZ6z/tims3QSQqTYs5
	0ygjLle4BLLS75WhpabkFro5WI31LWgfD/5vw0PRFWSV2wZMJyQMOYwSaLn5dnzci7RZKG
	sRl2a43yfny+nOywFvNv76/n4h/6qeg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-62-SgjSG_3GPJGbZVweybJgbQ-1; Tue, 18 Mar 2025 10:47:17 -0400
X-MC-Unique: SgjSG_3GPJGbZVweybJgbQ-1
X-Mimecast-MFC-AGG-ID: SgjSG_3GPJGbZVweybJgbQ_1742309236
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-39142ce2151so2658126f8f.1
        for <linux-kselftest@vger.kernel.org>; Tue, 18 Mar 2025 07:47:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742309236; x=1742914036;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R7O+pdl8v8v7EK7Wkd4nKpzLh6vnro4c8ShYrpyfa7w=;
        b=kBYHYwv82HAmNEl0WDw7aTIgRcKTWSz+DrLmLUS20zC7KHUmvhu2XRTyeSyx/mTFRz
         +fh2TVyyH9DJiSIHmdo5k6a9gvhRcByTIbwc0fG4Mq9VWWbCth92Bn7Bn5YUUGiSzsY3
         bRjC7/np3c5uq3k6ShaTiLXrqIbPNfIS57rk1oNKZiH3edKSD/EqbzRiiE1s+q3eZbTz
         Yhu8sNitG/r0HlBh2JJSKCZIEH45wx+ZVsfauckWL4RkGxWJPFWr6FdnsqC5us2Y34Wu
         nlQRhYWMc2Zw3+EQPLl4eeT6uFhmybkr+HZcSp8/dzE/0+ijYDmYEIa3E3Pv56H2GdIq
         iAIw==
X-Forwarded-Encrypted: i=1; AJvYcCUwm8xQo+/hPXC5rLg8FLnbVQ3ibaoY9aGtISjC9sUXk62iSFEQLz7BfP1q+gJc9q5hx6txKTuJiA3PdcpvMUQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwPTZG4MPB9t+qlVK/t5jdL2985UedXWxBOBvYWaXGApvXerJy
	HiigL6LnGE7cqdWslUkxGhWN7yZc1kPM5AI0FIkQRIwiVd6q2Tmp20XLefBfzyje4sxMSE3ueaw
	AXa5ZaZhnzMXGb7y/G3o1uZjcFSo38d2DhyqAY+wBhX+7I/d2lnCr+NCZR0B96nuJCA==
X-Gm-Gg: ASbGncsc6U9LZzVJFtoAsItVxQv0qKU+WPU7LvwDiJn7GTfDeaTafZKpYv6XccXTcEu
	xY81Sj+J06feVaZZjBMcn59fWzQ91xx6pjUtHHLiQkmlUnBN9gwJIoqD9h/b1FLz099iYGtpaaV
	46PJRX7l/E+o+md9i2KoFPMOG4whDxMyNuf7H+mKhC+4q9IsrARKdPfOOx18+3RMJ7PsM5e6pOB
	kavofYCD5OehR7ql3a+vuH65Y0RXiZN6mLxe+Chpg+lu97UE+8p2zzRIaWcWbIz24MSXuDzbFa7
	GwrTV9nZ3IXq8pm+EVi95sAsnou8pFQPL+i4DCRMOr8UsA==
X-Received: by 2002:adf:a197:0:b0:390:f6cd:c89f with SMTP id ffacd0b85a97d-39720398c12mr13493715f8f.53.1742309236015;
        Tue, 18 Mar 2025 07:47:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF1+6DV1Pcv1e0dGpotv5cbfi8peLombI/S233B67fHsuG9MRleiVbauAu9kTexCe5GwpJbpg==
X-Received: by 2002:adf:a197:0:b0:390:f6cd:c89f with SMTP id ffacd0b85a97d-39720398c12mr13493607f8f.53.1742309234992;
        Tue, 18 Mar 2025 07:47:14 -0700 (PDT)
Received: from [192.168.88.253] (146-241-10-172.dyn.eolo.it. [146.241.10.172])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395cb40fa30sm18491849f8f.68.2025.03.18.07.47.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Mar 2025 07:47:14 -0700 (PDT)
Message-ID: <a360fcbc-19e5-4ee6-9b80-2621fefd9ad6@redhat.com>
Date: Tue, 18 Mar 2025 15:47:13 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 4/7] selftests/net: Add mixed select()+polling mode to
 TCP-AO tests
To: Dmitry Safonov <0x7f454c46@gmail.com>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>
References: <20250312-tcp-ao-selftests-polling-v1-0-72a642b855d5@gmail.com>
 <20250312-tcp-ao-selftests-polling-v1-4-72a642b855d5@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250312-tcp-ao-selftests-polling-v1-4-72a642b855d5@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/12/25 10:10 AM, Dmitry Safonov wrote:
> Currently, tcp_ao tests have two timeouts: TEST_RETRANSMIT_SEC and
> TEST_TIMEOUT_SEC [by default 1 and 5 seconds]. The first one,
> TEST_RETRANSMIT_SEC is used for operations that are expected to succeed
> in order for a test to pass. It is usually not consumed and exists only
> to avoid indefinite test run if the operation didn't complete.
> The second one, TEST_RETRANSMIT_SEC exists for the tests that checking
> operations, that are expected to fail/timeout. It is shorter as it is
> fully consumed, with an expectation that if operation didn't succeed
> during that period, it will timeout. And the related test that expects
> the timeout is passing. The actual operation failure is then
> cross-verified by other means like counters checks.
> 
> The issue with TEST_RETRANSMIT_SEC timeout is that 1 second is the exact
> initial TCP timeout. So, in case the initial segment gets lost (quite
> unlikely on local veth interface between two net namespaces, yet happens
> in slow VMs), the retransmission never happens and as a result, the test
> is not actually testing the functionality. Which in the end fails
> counters checks.
> 
> As I want tcp_ao selftests to be fast and finishing in a reasonable
> amount of time on manual run, I didn't consider increasing
> TEST_RETRANSMIT_SEC.
> 
> Rather, initially, BPF_SOCK_OPS_TIMEOUT_INIT looked promising as a lever
> to make the initial TCP timeout shorter. But as it's not a socket bpf
> attached thing, but sock_ops (attaches to cgroups), the selftests would
> have to use libbpf, which I wanted to avoid if not absolutely required.
> 
> Instead, use a mixed select() and counters polling mode with the longer
> TEST_TIMEOUT_SEC timeout to detect running-away failed tests. It
> actually not only allows losing segments and succeeding after
> the previous TEST_RETRANSMIT_SEC timeout was consumed, but makes
> the tests expecting timeout/failure pass faster.
> 
> The only test case taking longer (TEST_TIMEOUT_SEC) now is connect-deny
> "wrong snd id", which checks for no key on SYN-ACK for which there is no
> counter in the kernel (see tcp_make_synack()). Yet it can be speed up
> by poking skpair from the trace event (see trace_tcp_ao_synack_no_key).
> 
> Reported-by: Jakub Kicinski <kuba@kernel.org>
> Closes: https://lore.kernel.org/netdev/20241205070656.6ef344d7@kernel.org/
> Signed-off-by: Dmitry Safonov <0x7f454c46@gmail.com>

Could you please provide a suitable Fixes tag here?

Also given a good slices of the patches here are refactor, I think the
whole series could land on net-next - so that we avoid putting a bit of
stuff in the last 6.14-net PR - WDYT?

Thanks,

Paolo


