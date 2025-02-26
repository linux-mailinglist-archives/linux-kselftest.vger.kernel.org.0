Return-Path: <linux-kselftest+bounces-27643-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 83FFCA46A86
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Feb 2025 20:01:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EF6C3AD162
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Feb 2025 19:01:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0177D23719E;
	Wed, 26 Feb 2025 19:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PQ0TftWJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68C1916F288;
	Wed, 26 Feb 2025 19:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740596440; cv=none; b=j8qkpMYM75vbafzhyzYufV1XpqGehhAzfmx+eA7mUJbqytEIyyX8phdYbSzaDA5Uba24hh2LBe197so75qZyoeZ7j3AjPC+D7RXFPcPIWucCvCilnyXUXhG6lCNIw20W5IB5gPBnT0tOkZoe4ULDcoQgZBq2xQJUyNEUbS9Omu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740596440; c=relaxed/simple;
	bh=ilnvCzetpSwt81QzijU6ZPwvYZCY439qILLVWdJZsMY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=URtiZWEKTD/cqON43XjZgCMnbXZ91Go8wPj9tkPfPJwsQFIryJJg+rjeMyyrmxduGh9k6g3KMl7TQ8vAk+ZN+Q8tjI3NlQMpgSECrWMdsiyWnQA7FI7GAQjq8PhQSD7tt3TL8FkhM1qBn8p5sRPOOmNZCQk+WxGhg0+bcds1IjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PQ0TftWJ; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-22349bb8605so2039595ad.0;
        Wed, 26 Feb 2025 11:00:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740596438; x=1741201238; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=um3PjvaV3xemkSrnVeoxOKPhFWkje/02DmmZTZ1Ij9w=;
        b=PQ0TftWJZmmrneq5j4aC/U7kDi/qc+iPH+01jFLexMX8+SpwmG5wcvNwDPRC5amn/y
         ErY9ZUxqyy9u8nb66adfwl0xtjVRg7Ef7xPG+VO9ZcoFXmDFheZEtN6lELPFC26apwBe
         Ltk51wgVFPGOZJJSBlUZlCVelCKhDcd9KI/oVfbH0pxtxTT2B3LvnbFTJbMmmSGKDagr
         BW/Hdk0DVjDwPQj6H4VO+aBSpxJJS/0LxPSa1APzZDiKUU0rJR27RhdAliwtG5J2zgB3
         YpPqkG/enk17ZC3cmDv84bHNDWVe5NKVFSRuuvSHWsA6HASpoJiQPsSocJ7TFjyWe3yD
         MHLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740596438; x=1741201238;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=um3PjvaV3xemkSrnVeoxOKPhFWkje/02DmmZTZ1Ij9w=;
        b=WIZxjLmwCuBWnugpBLtZw6yd6ZnLB62Tbagr8ZE2d2+nXJISlsLFn/EqKNCZKNinB4
         tAK1A2yuwZKX9d/l4/q4afgMNhRu3K7xAsgTDb1FBf5c1yzsUiiDYEnUq9c502TtCLsY
         8klm4Sbwa26c1EKOqsHDhtPHNFdaF7q3dhugAWI4L+K0lI/Htihq4H07jdCPKAUD2LPa
         IvsSGHieFpREfGA1wdrlD9xijs398iUT6+L8DWYu01uNEVBAGKLLP1pUYJednQrvshe4
         m2+gyRRVhn/S6uERWuRK2/ckNbSc70q6u0J2nDauON2E5PjoZG0T/jonvtTNgbKKRKrc
         Fe0A==
X-Forwarded-Encrypted: i=1; AJvYcCUs3sQyyHsIPdwaKMhMeXQtgcUw7LDW/BCZMnHXI+d/EipUlqLfJC3iUsMUyfhuuiCyXkZagVoMYcvNndn/A0WO@vger.kernel.org, AJvYcCVvUOPZIDdWQ+c54wBj0cCyujb1K6pyLuNeuVExXkLsdtNmgcwaJNf9gac1y4pN2PfQdb3vHtlsFk25YjSR@vger.kernel.org, AJvYcCXbJPhowuz+J7BL8rfKdxBPhsV9cQWcrFE8B9FiivGFbJOQN+axK+5cUB62cBSCtz7ZTbw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGKxZGzQm9kZ4G62bleFKlHIa3p0H+4prxHjCjUuhQplG0kCge
	wp5hUB7PeBXgSp9yi0qreM+kCFwyIsx2iLC0dC2cTnj6JvNTg0g=
X-Gm-Gg: ASbGnctZIJ1hmYBeWn5ygNWfH+FPjOkILpJYuyTEq0fLv8v6e2rk4Z+FMtLhKAdnSbM
	g+c6d21wsODLvQPfeIZzQM39f8j41QoqOUQXNeQ4SxmyrZiskAkn+oF2fqMR+MSisFiUTEdyd8Q
	An5dSQno6rmoPtIuDp9W4BuHu6fC72nZTgRElz8IvVKsRc3TKYuNkhHyuiRPP1Ibfldb3mfikDC
	7lWK2F/gkAuRNl5IyH1pnLRTduaqThkSeWjXQafTWUxItzAS6rk6aTZrqHsaTfAAjsINdXsBO1x
	ShU/Hpk9GviFhzjn1G5HhBmMvQ==
X-Google-Smtp-Source: AGHT+IEXTCiiX7hd+vmSbpzizYEK0rijev1ZKtdKEhTs2LivmWOC4sXPFuIrmEnAwtEyjJANS3y/rg==
X-Received: by 2002:a05:6a00:99c:b0:730:949d:2d3f with SMTP id d2e1a72fcca58-734790c8cadmr13431917b3a.7.1740596436989;
        Wed, 26 Feb 2025 11:00:36 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-7347a81c57esm3969843b3a.136.2025.02.26.11.00.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 11:00:36 -0800 (PST)
Date: Wed, 26 Feb 2025 11:00:34 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Marcus Wichelmann <marcus.wichelmann@hetzner-cloud.de>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
	willemdebruijn.kernel@gmail.com, jasowang@redhat.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, andrii@kernel.org,
	eddyz87@gmail.com, mykolal@fb.com, ast@kernel.org,
	daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org,
	yonghong.song@linux.dev, john.fastabend@gmail.com,
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
	jolsa@kernel.org, shuah@kernel.org, hawk@kernel.org
Subject: Re: [PATCH bpf-next v3 5/6] selftests/bpf: add test for XDP metadata
 support in tun driver
Message-ID: <Z79k0vKn39XsZ-j7@mini-arch>
References: <20250224152909.3911544-1-marcus.wichelmann@hetzner-cloud.de>
 <20250224152909.3911544-6-marcus.wichelmann@hetzner-cloud.de>
 <Z7yo3VfHofK-W7EY@mini-arch>
 <165bbf6e-ca06-4eac-a9a2-2033314aa027@hetzner-cloud.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <165bbf6e-ca06-4eac-a9a2-2033314aa027@hetzner-cloud.de>

On 02/26, Marcus Wichelmann wrote:
> Am 24.02.25 um 18:14 schrieb Stanislav Fomichev:
> > On 02/24, Marcus Wichelmann wrote:
> > > Add a selftest that creates a tap device, attaches XDP and TC programs,
> > > writes a packet with a test payload into the tap device and checks the
> > > test result. This test ensures that the XDP metadata support in the tun
> > > driver is enabled and that the metadata size is correctly passed to the
> > > skb.
> > > 
> > > See the previous commit ("selftests/bpf: refactor xdp_context_functional
> > > test and bpf program") for details about the test design.
> > > 
> > > Signed-off-by: Marcus Wichelmann <marcus.wichelmann@hetzner-cloud.de>
> > > ---
> > >   .../bpf/prog_tests/xdp_context_test_run.c     | 64 +++++++++++++++++++
> > >   1 file changed, 64 insertions(+)
> > > 
> > > diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
> > > index 4043f220d7c0..60aad6bd8882 100644
> > > --- a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
> > > +++ b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
> > > @@ -8,6 +8,7 @@
> > >   #define TX_NAME "veth1"
> > >   #define TX_NETNS "xdp_context_tx"
> > >   #define RX_NETNS "xdp_context_rx"
> > > +#define TAP_NAME "tap0"
> > >   #define TEST_PAYLOAD_LEN 32
> > >   static const __u8 test_payload[TEST_PAYLOAD_LEN] = {
> > > @@ -251,3 +252,66 @@ void test_xdp_context_veth(void)
> > >   	netns_free(tx_ns);
> > >   }
> > > +void test_xdp_context_tuntap(void)
> > 
> > tap0 is already used by lwt tests, so there is a chance this new test
> > will clash with it? Should we run your new test in a net namespace
> > to be safe? Bastien recently added a change where you can make
> > your test run in a net ns by naming the function test_ns_xxx.
> > 
> 
> Ah, cool, I didn't know of that feature.
> 
> For reference, you probably mean this one?
> commit c047e0e0e435 ("selftests/bpf: Optionally open a dedicated namespace to run test in it")

Yes.
 
> As long as the tests are not run in parallel, the test function SHOULD
> clean up well enough behind itself that no conflicts should occur.
> But having that bit of extra safety won't hurt.

The test you're adding is gonna be running in parallel with most of the
other test cases. If you want it to be executed in a serial fashion
(which I don't think you do, running in parallel in a ns is a better
option), the function as to be called serial_test_xxx.

