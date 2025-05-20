Return-Path: <linux-kselftest+bounces-33410-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C31B2ABE0C2
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 May 2025 18:33:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10BBD1BA2D69
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 May 2025 16:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE4BC26AA9E;
	Tue, 20 May 2025 16:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GA6yiitB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52C604B1E5D;
	Tue, 20 May 2025 16:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747758789; cv=none; b=s62hZuX6gjvzvb3LxfXo26wPaQjdZM7kLpT1FgmvDylM0XzLRk4cNYaEBPTUtHUybWvs96nWSnAuKBav+ARMH0MnqY8mbRpv9b6x2iNgEYj59DCGWCpOCKx6Na1+O26p2Gbyxf+6ZqISMEnxgI8J/WJcgxKtb8XIM7xdeneND8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747758789; c=relaxed/simple;
	bh=9iywa8LxDBmIJmnFA0mWiRWkOXXa499m0kRd7LsL7ag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CILZL6uRGkoJQtJgmsgEQzFq8uqcaPSht9m6viTBcuer1/7wKxtbG9qYZg5sjfcPv7KOZNNZouApUF1gHtoh0IqSOETMhelZq9L8fcaX4rM/7R7P5DA6Qil7KUKf7G8cdwFMuJLX0n+DuK0vC/rnsJyQ/fwae2OvCaCBONnbxTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GA6yiitB; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7399838db7fso5528526b3a.0;
        Tue, 20 May 2025 09:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747758787; x=1748363587; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=N4J9GjT2DkNx9RKMdFilKV2qV6BHNi7N4nhhnVWjxkM=;
        b=GA6yiitBt6I5Rd95Do5zzbLjzJb0nj7Vw/LFeumfftUIiOVarMigpCicb698VT/wIE
         2nY37kIUll4gH8JXK61UJqRSWJJNThxW6UF0YskbLHQfs9X6x/42qQ4dMEpixNoLmZrV
         9vYJrOYfa5g8zR7nFotLguBfDwbcMu2w9qhxJKNv2Be0CxLrViSw3A5rKQlKj0pVcBCo
         Gy0LE9gzr1UrTXCPSFPdf2RIgT1se1eB1zR0Lh/d/8yMeNHpNjurjoQCmmGsIRIIbasu
         FaAnt2Hyojdg0yNr9z9KJdJip7VBsVTowzQcbR9jE9idxS+aoC9eH5nJL2bx8eGSghGa
         27iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747758787; x=1748363587;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N4J9GjT2DkNx9RKMdFilKV2qV6BHNi7N4nhhnVWjxkM=;
        b=hc1zSem6wVrQOJ5pPpI3773fY5VGa64rLso2SvLGpvte9Y+fB42XrSl2Kx43mbD0NU
         CPDI/Yozcu1d31L+hxU6doxmMFTYLrlu0femnnWcBqxo4ugJpowevBnjj8E0nim1mkDa
         vkUZ+OT68G9NXo5gehg4aBKnHQlfx3WWOaRez3m5j9y7VSjPIXlQJm87Fqym6G2p5IrH
         7O128l6+QdSODI5LH+fqKO4fXZvOtTqeiDO+1DF8e0JXkNsINQU9VnNIL2H0AO+IMFhP
         1LRIcB0shFmOiWsbFFGDZy2unHVk6tB0cIxlOCqPsirsmLXqMN0zA/9xhPv7gL75bMJx
         7E6Q==
X-Forwarded-Encrypted: i=1; AJvYcCU/z+7dIv9eX5Ng4KFXXXY7sCrSlD/kj1lC0n0qG0+5C6odjKs7Mr8yK/ydVewkrlCZ3Q6sNfpk0iVkgU3wWu3F@vger.kernel.org, AJvYcCV8Ys9VPzPe59MVXldyoa6fGcLAnqk+cR3d/51kkYEI6SsZ5O8Ebf/p9uFXl9/gRhgSohv9yMA6HiJLLScf@vger.kernel.org, AJvYcCWA+GaI7udbxBJQprH4UFfR90R2T2D5zz2jkWapTiI5kENq901ZsJUDWgZkx5jZdLm8Nx4=@vger.kernel.org, AJvYcCWvOcvTyBJrlX6qXlnZSPnlYkXT3TKnLsEzJawhoFltR6f2U7wFNfOAZL+yGPBgPKhPok8rLD7r@vger.kernel.org
X-Gm-Message-State: AOJu0Yyi3gtW8kxnqdJJetBjFbjA1VRtgR35yH01vpi0J2b9UTpJZlxx
	52h0+2PnyaqOpAKYSOzVaQxkWmQMk3mH5rUfkcwwQ3IjLaTHoEjytmTW
X-Gm-Gg: ASbGnctSmvmZWvO+hNL1+29OK/m9RJ5NbwdJY3iLZ7UvHvE9VWH140K5xYNkdfu+m3q
	66+oisJ3p/6fIMLo49DuZzMaV1gMDz1DzyJ4TAvUtFaJwNp0wvs3+O4Z8uAOYSj+CS5l1c1Piq0
	Ak3vSCTpNXzoYJHQUasYGuY2ara2f4tir7xYvBwooBLwYXX05SaDiTLJ8m2a0hsc7HsiIMrb+iR
	ndnMkr5N0RJF3+a9zU+k8mei8cg3XRtE7pyOAma1GRFQ2l3q6jxN2n58oaFaVsd2M53JM/pd7kT
	1PR8/PtxjTvPqEttUeIsvlSViV1RjHPhnI3LLuS1Pw/ZV7pFq0smrPXPbGpvMrBCtMMa5bY=
X-Google-Smtp-Source: AGHT+IFFEtELJ7CNY/gj67X7KGAeNhJCZbOLnPiYWwQ92Z9dI1v88DKGl6Pdba0V9ObimC+EYXJnbQ==
X-Received: by 2002:a05:6a20:12c3:b0:1f3:3547:f21b with SMTP id adf61e73a8af0-2165f641cf3mr29465576637.5.1747758787474;
        Tue, 20 May 2025 09:33:07 -0700 (PDT)
Received: from devbig793.prn5.facebook.com ([2a03:2880:ff:3::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b26eb081aa2sm8256782a12.48.2025.05.20.09.33.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 09:33:06 -0700 (PDT)
Date: Tue, 20 May 2025 09:33:05 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Paolo Abeni <pabeni@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
	Shuah Khan <shuah@kernel.org>, kvm@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v7] selftests/vsock: add initial vmtest.sh for
 vsock
Message-ID: <aCyuwa8x9ClTOM+Z@devbig793.prn5.facebook.com>
References: <20250515-vsock-vmtest-v7-1-ba6fa86d6c2c@gmail.com>
 <f7dpfvsdupcf4iucmmit2xzgwk53ial6mcl445uxocizw6iow5@rhmh6m2qd3zu>
 <73a4740e-755e-4ba8-8130-df09bd25197a@redhat.com>
 <w6aizeb2i5m52e2ifqcikgwdbrkkbc46sf4hx5b6jsm7o4drio@n3dzlatb426s>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <w6aizeb2i5m52e2ifqcikgwdbrkkbc46sf4hx5b6jsm7o4drio@n3dzlatb426s>

On Tue, May 20, 2025 at 01:09:25PM +0200, Stefano Garzarella wrote:
> On Tue, May 20, 2025 at 12:58:18PM +0200, Paolo Abeni wrote:
> > On 5/20/25 10:24 AM, Stefano Garzarella wrote:
> > 
> > Still it could be worthy to re-introduce (behind a command line option)
> > the ability to build the kernel as per Stefano request, to fit his
> > existing workflow (sorry for the partial back and forth).
> 
> If that's possible, I'd appreciate it (not a strong opinion). Otherwise if
> we don't, I'd say take the use of the direct script out of the commit
> messaging, because to me it's confusing if we don't plan to use it without
> the selftest infrastructure.
> 
> Thanks,
> Stefano
> 

No problem at all to add it back in. It's a nice feature to have for dev
workflows too.

Best,
Bobby

