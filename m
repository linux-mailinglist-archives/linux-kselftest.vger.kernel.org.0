Return-Path: <linux-kselftest+bounces-33905-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD97CAC5E38
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 May 2025 02:29:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E5794C0E86
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 May 2025 00:29:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCA851311AC;
	Wed, 28 May 2025 00:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A3xTTPGl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E1321367;
	Wed, 28 May 2025 00:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748392148; cv=none; b=jZ00bmgBs2PZH0GdmuxKtk37AwJcrrq/nM2WrhNevVPOT9K203iM2ms7WkCaKKb+IW91pLqOa666CSLSHw8KIqdDPnsSTrehwTOyf3eiDMUs3AtB0RelF9lj8c+Key/ry7faVbVMjCkNwPJXI9+i4jA5poP32iNE8gAit496oF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748392148; c=relaxed/simple;
	bh=nMSI5ZivnZZiPS/FxHmijcxahzyz2FLO5lWtTyhEHmY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ogaq70If2Yi2maalB8LGGy/TQ/zG2Po7n+qJdQD1Wd22q9CWOBwECxPHOD5LA6fBoHlGM41f2+vTE1OBsPu6f9FlgZjPiRS4Kxaluf8OWWLImuPcaqSroi8w+dRy0iwvzddccGPc+1ouABRLgkvns2a6kJE1IqjnLu58HPHZMfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A3xTTPGl; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-234ade5a819so10429115ad.1;
        Tue, 27 May 2025 17:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748392146; x=1748996946; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SdHZEyPpnejSK4kS7CITMiqXsuO0ubtElhjRk0W2zlc=;
        b=A3xTTPGlOsKR3cANTrsLabM5rSwq9s8RdQo5CereHgxs5/clmoVti/KRKI8vnh2ptg
         cbFOXLPdtgvut9VJAkZo7Z7+3i2vpWPUA4Vnk/EVaskS+TQBVm9wHDtaBXZFDrHntm+l
         uAgQAH+o2NP/SP0Of95VPXYV9M3Xjk8zZmCQSBDNYHr+ELKkt4v1ENaT4jbZFTWNC8nT
         B68Y4pjM+00xf44vqILhjGeYg9yHi6Hn1XB3zzMgZvikQs18nTrRCsp7kvR2O2fCrBYV
         BIiQZQy5emrFpUTrCCd+5ByLQ/h9CApJZUUfJyoZl18jb0Vh0qJqbR7ltL/s65h3ECjS
         KfeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748392146; x=1748996946;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SdHZEyPpnejSK4kS7CITMiqXsuO0ubtElhjRk0W2zlc=;
        b=Tv9eylSyPulQ2gUjZ3QpidGv9UIwZOrXws0rUS4nbG8AvBRJHMaAO0ZNt3uoTi0Mqw
         aDwIBz0uh9sMFVMaL0X+/e+72cbUPP5DJ+r1SP1QQyW8O4wyOGQcbvtndVLoZcW+RiLO
         g7KMIhIEl2chXl/+W2HznjQVVWwTlXwzn8OCLQ+hAiWIInhBsM713fpjgK/r9tbgApFm
         HObBgoMp2RT/u3SPTjhgv80Y/noeS9o/vz1VvCfAfn4ts3ut1cCFZMAX0S2KDm4bOt7U
         F1pUfpUk1AyiJXbhKk5lLUZBAoH1bhziN/EMVmyo23cMohiMzYpwVdlfNq08CcyJmeRg
         GjOw==
X-Forwarded-Encrypted: i=1; AJvYcCUcTKukE9SD51U17UbQsKSsvbJvwgbpQbZWgRjX7tJVfqokdCMiO2BGIaQ0c3qxxSlFY5aRUg51rqxKjlt4@vger.kernel.org, AJvYcCV49XwFb5IxcKHl71uPZEKQPzljYHHLbNmKf5ON6vVO4BCnsQrf83MdkuHMxLAY0fLKJ06qf4J2/0vWl+HhaVsE@vger.kernel.org, AJvYcCWYoO/0Ir3dAsnoYKbkaTsNrOe7zWu9lYBXknScHqBvawl6s7CrSVcNmQYdCsbES9rVblAY6mbb@vger.kernel.org, AJvYcCXrY/Air1FxhEnNLC+n/1sJLhLBtOPkABHpCrATFku2A9zLWXoR5KaZKv12bD64v27fFJA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcEInt9/mh4Dlq+DOZEIFaXS35lNJ5Qlnigq0MJL2/Cncqwk2d
	rym/4kaWEglG+yJSabDag/HU3rsai0x8rZQ0nbjY72QpRFCbcOSUF7XJ
X-Gm-Gg: ASbGncvGdNhiWjfxMSw0kQAaDvbPmYZt88CFGMcdwf7GbcmIcDHi+2lNyccEQnFkduB
	csDx9ABIOq3WidFldCQtmPXCHnpr/uaa/M/2teA0IqgeV19dwYY+PIF8rdvLGkg32VvORWeka0C
	LsHrhpZvKDMxuedL9danGGwhBaCT4WuupV4g9xR3dSRJ4IrYsMrORWhGnX76j0m3Wy35Rqaccbg
	8ovwvStr8bOyQfnNIbi0C1RYfTFDf85PeFwxgKB0qtUCq08m0gN9oRW5SDodN2nyAQr/jMtA81K
	UZZve5E9gPd8wc89njLXXYP9krCkSSgDRKqR4gVnDCcM7vbCb0kIwQBfe2zDvQzXyX1kf6Y=
X-Google-Smtp-Source: AGHT+IEXiNShvrkwb0WLAlppJy482Bihy90a51Ds7tKinQx6TREEDLNScb5DULzgA/mguTbEfCZWog==
X-Received: by 2002:a17:903:1a06:b0:234:c22:c65b with SMTP id d9443c01a7336-23414f5b33amr235147555ad.14.1748392146386;
        Tue, 27 May 2025 17:29:06 -0700 (PDT)
Received: from devbig793.prn5.facebook.com ([2a03:2880:ff:5::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-234d35bce89sm63895ad.217.2025.05.27.17.29.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 May 2025 17:29:05 -0700 (PDT)
Date: Tue, 27 May 2025 17:29:03 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Shuah Khan <shuah@kernel.org>,
	kvm@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v8] selftests/vsock: add initial vmtest.sh for
 vsock
Message-ID: <aDZYzxEOKKY5kKcD@devbig793.prn5.facebook.com>
References: <20250522-vsock-vmtest-v8-1-367619bef134@gmail.com>
 <ta2ub5v7txhobccgvpnwsz7cyzcnx6aw74cjlcviosjetuwfhh@7gdahptdpbnd>
 <aDXMhbqhhUAMe0Oz@devbig793.prn5.facebook.com>
 <tabqpll3r76jhx2ujayry25a7ujfsikm7tejv5sviayyojlmwz@amcchbc5xiqp>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tabqpll3r76jhx2ujayry25a7ujfsikm7tejv5sviayyojlmwz@amcchbc5xiqp>

On Tue, May 27, 2025 at 05:55:13PM +0200, Stefano Garzarella wrote:
> On Tue, May 27, 2025 at 07:30:29AM -0700, Bobby Eshleman wrote:
> > On Mon, May 26, 2025 at 01:18:18PM +0200, Stefano Garzarella wrote:
> > > On Thu, May 22, 2025 at 09:59:07PM -0700, Bobby Eshleman wrote:
> 
> Yes, that would be great, but anyway for now I would say let's go with this
> since we're supposed to support these current versions I guess, and this
> hack at the end I think is doable.
> 

sgtm!

> BTW, thanks again for this useful work!
> Stefano
> 

No problem, happy to help!

Best,
Bobby

