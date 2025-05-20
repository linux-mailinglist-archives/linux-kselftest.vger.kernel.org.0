Return-Path: <linux-kselftest+bounces-33409-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A9F9ABE0B6
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 May 2025 18:31:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D69F1B61013
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 May 2025 16:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A0A62627E7;
	Tue, 20 May 2025 16:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IP0xUmHy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA9E324E010;
	Tue, 20 May 2025 16:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747758674; cv=none; b=gidG3BwRIXsVCAvKTLNt9a6VxvReRbd0KPVOH3ArJb8vKjRSGGcav0LP+GIAlyBuWG2GrALFbPe6OX2p7fxsjTBukp0HzW5A1sTKNgB2mO4IVjNs1Gi+nJIRDOJ6LK0zgVlQ7vJEKV95DM9uueNlMLMwjxKvDDS5cmishndlEho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747758674; c=relaxed/simple;
	bh=A1uJoYur0CJnK5muRGxD+LMFE0Wmuv2z5f3tDoh1UVY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JbEBiG88kIMgSQYZJut7cumf8eIngOGd5EV6YybTpEburO5b7+FvWRRmNSdVOjVEFcg810zyNTTFN0cTEK3w55UuxtDJABRDxdKEZ3lVrldVz4nVFkwTukKcdQoc8GZJ21Ibzllais264IzXbo621wrCdSL+Yim5oM4X8R/1mGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IP0xUmHy; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-30ea8b7c5c2so3209614a91.3;
        Tue, 20 May 2025 09:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747758672; x=1748363472; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=U2t05IAhu5JS6yf2a0L1zsY+gn4NL8gR5pf4kfZkSQo=;
        b=IP0xUmHyxxhxDKJdzauRevns7e5KOJ4x/oEj9jKVEzFDwMue8nFY6dhU1qh70BSyYm
         kIvI8c4yr3cEpfbejY9BiysEgnIzjpSU6M3c/nxqS0PbTzB79AhmpjNI8WE/bSdgujsl
         7+ZMNOFUsqEGdTH2bO272HDMlUZubAKB0r14aya4w3FY17ftjleuojXrtQedc8inGIPG
         ri5Tprv2sQTlFF7kEX7KON/LTc882k0MNwRl5B1JZRaOs0UZjoNuxknuzpH1jTr39mle
         21yun3ane6NDYtSoqbgGHqu5jO6TP8oimUmROJXlzZARqyI8XzTAEfIo3knsAeX42gOh
         R/DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747758672; x=1748363472;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U2t05IAhu5JS6yf2a0L1zsY+gn4NL8gR5pf4kfZkSQo=;
        b=gvKXIlemUmK/6JvAvUad+VXU6Z9bw8wvWr5AdEVawMt4AWfe1BZXsrW4DVNOUX62+S
         HDhme5wQvXpfXkEku7lOi2lAHhjT/JW2KeurqCRy9Y1LNaSQMog4vz3ypd+CA8g2NMeW
         IHDV1GqWdXceaSas7smnuQT/081OdJSxPkqDRyLWT6CUArWKyXi4XNyPCeHWluK+Zk01
         EQ0amUBGWWXfEpz0nWaqp1fS4JVzFW8JMtYKS6RQZOvmKyRobwgVJszzHjZrZI8TSjdl
         ER6PwGgI39xIuFkM7YYqexX+5WBYfENVI1HGNj/pV2Zgx3u+H+ZwE+iNfQwEfZoLlfQp
         JHUA==
X-Forwarded-Encrypted: i=1; AJvYcCV3VZTpDpyQgm19VpaHFMYEUYFvQq/IwxAIa09Z+MnX5knH2IADL/ruEPQOwmfokp0iCOAJkpuJJEZKmNyB@vger.kernel.org, AJvYcCVgrBFtmQvFgRI4sYwWulK1Qcr0Z5lbLLU5VaC7Ab96kU2qsTEQ9lwACKNGsUKIXyRI260UheaO@vger.kernel.org, AJvYcCWSsbR5vJJPnzsKC/u7+xPTfmIz76c+1Sqc0GiIrbYm2dO/AWBMnr5tX9Yhoca1wQfLc+0=@vger.kernel.org, AJvYcCXc2XkNdfwU8BX+MbL4+5PAWtwLhu3WjN8HpLMovrk8H9hNzYObqYE/lsPHZberZKHcY7jGoda8BS8FFSw8Kv7W@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2o9MyYY4BP0vLX0sBMEzLs3+FXCKZ8DOC7KRc4Mq+M30coqSt
	a93X89RdIhwZgHXtT58FekGlq7fWu8bD9tvHFdfjxIuHvaAx5e7q+/4b
X-Gm-Gg: ASbGncuLSAzrhsypXGBLlxUxX6pT5e31cXhZlSFXLvJUwY6QtIx1IIXzxcftAmeTUUG
	YY8AKHUR5wUPd0z4wNgK2vek67Nxla7o+bUzSoY06RvNJB7QdhnJ+Kb17n9S2Atm5baAquyglft
	00dG+unfyn2V1fJfS9RLiLJlpQHxVksplpeDqQdbkR1PqxUWf/uLQJVg2XN5FAw3FngZSg6l8A9
	+bpaJ8ZEea5NMGZDWFa5Xox8NFfQkrWLSHWtDDbPFtWYiZYJB06KgD5R7QlhSlC+e6ELw40HbAp
	xxcsG5BTNXCaAVIX6mjlbucq6oqrPmc0+nYgVZJYLWrorxfmobxfuTaY617hfKW+uHlx0Dw=
X-Google-Smtp-Source: AGHT+IEtnb8aYdRjb2chzZc4KFgAuKLohjg+W8+FnvIkeyuCGBJPJPSMAMhgJm+kE/2axZm/rVc6cw==
X-Received: by 2002:a17:90b:570b:b0:305:5f32:d9f0 with SMTP id 98e67ed59e1d1-30e7d540033mr26297107a91.19.1747758671634;
        Tue, 20 May 2025 09:31:11 -0700 (PDT)
Received: from devbig793.prn5.facebook.com ([2a03:2880:ff:3::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b26eb0843d1sm8290669a12.49.2025.05.20.09.31.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 09:31:10 -0700 (PDT)
Date: Tue, 20 May 2025 09:31:08 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Shuah Khan <shuah@kernel.org>, kvm@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v7] selftests/vsock: add initial vmtest.sh for
 vsock
Message-ID: <aCyuTMNkRzCBMp1i@devbig793.prn5.facebook.com>
References: <20250515-vsock-vmtest-v7-1-ba6fa86d6c2c@gmail.com>
 <f7dpfvsdupcf4iucmmit2xzgwk53ial6mcl445uxocizw6iow5@rhmh6m2qd3zu>
 <73a4740e-755e-4ba8-8130-df09bd25197a@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <73a4740e-755e-4ba8-8130-df09bd25197a@redhat.com>

On Tue, May 20, 2025 at 12:58:18PM +0200, Paolo Abeni wrote:
> On 5/20/25 10:24 AM, Stefano Garzarella wrote:
> 
> https://github.com/linux-netdev/nipa/wiki/How-to-run-netdev-selftests-CI-style
> 
> @Bobby: AFAICS this now has all the ingredients to fit NIPA integration
> am I correct? the last commit message sentence could possibly be dropped.
> 

NP, I can drop it. All of the ingredients should be here, but I haven't
completed setting up an environment yet to test that integretation.

> Still it could be worthy to re-introduce (behind a command line option)
> the ability to build the kernel as per Stefano request, to fit his
> existing workflow (sorry for the partial back and forth).
> 
> Thanks,
> 
> Paolo
> 

No worries. I can add a "build and run the built kernel" option... it
should probably build the tools too to be all streamlined.

Best,
Boby

