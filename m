Return-Path: <linux-kselftest+bounces-37972-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A84BB1173D
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Jul 2025 05:54:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A297817A50A
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Jul 2025 03:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E8742376FD;
	Fri, 25 Jul 2025 03:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MnYW7iKB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9ADA1EDA1A;
	Fri, 25 Jul 2025 03:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753415639; cv=none; b=R4grjwx8nqBJepmytyxWH3MvS3QkvQ/LraCxfQrkmr6cP2ADoqiQtCFfmb9tGcEy6TUoRRNQnuFDhpHpPvayHgzoPzD6TpsB9aKqPsTaTfH/p21/iZIut2IkR1HaS+in5eoH9b9buZyJtIs+n0WWp8SKaWgj4YF4/uZcxkqqD6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753415639; c=relaxed/simple;
	bh=CCnUIhBvuNE3ssmHP0yUwtVB0bHHyEcOhPSZdLQk+O4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FirSZsbSkj5zIOiIys0uDHz1X4oT3pGixqlHrmmdCl4t1lhgqc6WoD321AFCnagq139drPY15bQ4z0PK8yZK6Gd7Q4LNMr4atm4KrMdYj4PapK5/7eSf1Om+x5G8lnNkDtX3c4vzITs6IbBpKa/ezHMoV+oDIU4gL/5cZCdUx3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MnYW7iKB; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b3aa2a0022cso1982430a12.1;
        Thu, 24 Jul 2025 20:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753415637; x=1754020437; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hW9AXQYKd37BK6sNBYGkdFC2KgxtfKeihilIUBQrgIE=;
        b=MnYW7iKBOWZSvEmQR+a3gWTtw1N6RbBi+atbq3DcqNGyqsRyJ3E9GnzszX0syCSEvd
         RIEAwqpK7wgrVDgLkezg0F2wZwtQmAxpPtvYbjcJ9nBGXU1fb8bQvneiJc8LywRiBJGh
         MQ8zRTNJJ+9p5jfh77iRWE7KUuQTlIzLDVIfOuNLGdbQCDOF55GHBOVJAs6jyiFqSNnp
         K40GGexVYdErzcN2NuqFhWmmjoyUH6DfiQvMkwmYm9VPzXpQmrnDj0/t/289u+gWABwf
         N5OKcVbXGY2ygeSTX1WmUEzL8p6eF8vBi+PNOK8ChACItycst2MfSplEjVpLHv0zby50
         JtqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753415637; x=1754020437;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hW9AXQYKd37BK6sNBYGkdFC2KgxtfKeihilIUBQrgIE=;
        b=LQNhmbJ/YYrKDwvMUYYAhGJjZ6i5mAblMcdqYzupF+Wr1gVH7rZE9V69GDiSDwTCO6
         0NZWq4FcC3HHYbb5Z01n4+GfKs39hEZX+8odpc6vvDEZ+r4SkXUAKDrVz5IP6SHBd2Tb
         6wheQGnne34ELvR+k3Jy287okvBTUH8KpM9IX4O9cFRbJK6LDDcGtAtdlVZCTXIGCbGo
         M3ESg+ivX8+MttjXUHV0AWLzXnEGDoE5W2ZTz2JCBYoQevd9xVfv6ahrNJoJulF9Af/x
         Qc/DCKaaxzg7saUj/Ie8zHAWCBQBO9Tg/6i6+Lu1fRp9RcCBgOGDpiiq1It7t1NMkgFj
         eMbA==
X-Forwarded-Encrypted: i=1; AJvYcCVwjQGaNJpAsXQGF6+Z8NBODwYfsnYY/Sp8/69YgTKeu+IZjqPBOzCyF+CMPkP31mCxJ1LBJ9hn@vger.kernel.org, AJvYcCWvfcWfHBkAGkDx9Qn0nW/DxwnywGbRGB2+XPkNplPI479ALYriqc+7EywarN/xhDG5pg579cJ210qSrK8fH0vB@vger.kernel.org, AJvYcCXv+e88P7WDGkvfAMnQ6m4zHyoy66C0x5Umj0f7khm95LDylom9hpvMrxgwhRZxu4PTvtlLqfLlI+MXKps=@vger.kernel.org
X-Gm-Message-State: AOJu0YznLuYhCYnzKzwsJ7fOPoGMgTu+QQqHwmrwyc/HJjYq0WhaoVID
	6iJu9ZOGWy08hGkmarGdkuApKy7/WxXQAzZoDLDTfs8gDo0nab6BAkvX
X-Gm-Gg: ASbGncsl3hn4JcWYEWyq+k5JLxZTKX1OcSOjRqx4Hp9JoUNovrWUaWF1/GNSB7aam3F
	8V3T+o4bsZ819XmEgnYpkoWlVoKVRBVWjnsX6k31ZqvzVWt/EtxBr2eyP4ohzer4OT7vJ2+NfR5
	2ql3jC6CmOobAbFCFz0F2go2EewFy5WlXyvUP28hw4KTWUXPzDDGZoUtPdsk7fnVP+Baon9fJNj
	QPbrBPY0qlAf7yqWDVDDyDZ54+580XpPH0u+rderuVcAd2hDIbZIavjNY9L0KwHXZpqv19D9Hb1
	s8HSs8j3V/fhtQkxMEeyWGq9B/YgosWdI+c3VYDn9Mg4aRgspIHpK4CjBiG8Av8goeMEbkq9GKV
	mJjqf8PtlcGDhJ2j9Vd1gx9fz3Ag=
X-Google-Smtp-Source: AGHT+IHvF9CWQBmtPvqxjtafnD0suZKb7Z0tVBD4hH4QI/HjjUoanfXRrgETeCN0uVUFNB6oIekj0Q==
X-Received: by 2002:a05:6a21:33a2:b0:234:8b24:108d with SMTP id adf61e73a8af0-23d70171b24mr462993637.22.1753415636902;
        Thu, 24 Jul 2025 20:53:56 -0700 (PDT)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7635561b64csm105688b3a.136.2025.07.24.20.53.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 20:53:56 -0700 (PDT)
Date: Fri, 25 Jul 2025 03:53:48 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Xiumei Mu <xmu@redhat.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org, Long Xin <lxin@redhat.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Shannon Nelson <sln@onemain.com>
Subject: Re: [PATCH net v2] selftests: rtnetlink.sh: remove esp4_offload
 after test
Message-ID: <aIL_zAGaP_8HDTS6@fedora>
References: <6d3a1d777c4de4eb0ca94ced9e77be8d48c5b12f.1753415428.git.xmu@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6d3a1d777c4de4eb0ca94ced9e77be8d48c5b12f.1753415428.git.xmu@redhat.com>

On Fri, Jul 25, 2025 at 11:50:28AM +0800, Xiumei Mu wrote:
> The esp4_offload module, loaded during IPsec offload tests, should
> be reset to its default settings after testing.
> Otherwise, leaving it enabled could unintentionally affect subsequence
> test cases by keeping offload active.
> 
> Without this fix:
> $ lsmod | grep offload; ./rtnetlink.sh -t kci_test_ipsec_offload ; lsmod | grep offload;
> PASS: ipsec_offload
> esp4_offload           12288  0
> esp4                   32768  1 esp4_offload
> 
> With this fix:
> $ lsmod | grep offload; ./rtnetlink.sh -t kci_test_ipsec_offload ; lsmod | grep offload;
> PASS: ipsec_offload
> 
> Fixes: 2766a11161cc ("selftests: rtnetlink: add ipsec offload API test")
> Signed-off-by: Xiumei Mu <xmu@redhat.com>
> Reviewed-by: Shannon Nelson <sln@onemain.com>
> ---
> Changes in v2:
> - add test results in description
> - Enhanced logic for rmmod esp4_offload
> - fix shellcheck warning: SC2086 (The quoting issue)
> ---

nit: extra ---

Reviewed-by: Hangbin Liu <liuhangbin@gmail.com>

> ---
>  tools/testing/selftests/net/rtnetlink.sh | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/tools/testing/selftests/net/rtnetlink.sh b/tools/testing/selftests/net/rtnetlink.sh
> index 2e8243a65b50..d2298da320a6 100755
> --- a/tools/testing/selftests/net/rtnetlink.sh
> +++ b/tools/testing/selftests/net/rtnetlink.sh
> @@ -673,6 +673,11 @@ kci_test_ipsec_offload()
>  	sysfsf=$sysfsd/ipsec
>  	sysfsnet=/sys/bus/netdevsim/devices/netdevsim0/net/
>  	probed=false
> +	esp4_offload_probed_default=false
> +
> +	if lsmod | grep -q esp4_offload; then
> +		esp4_offload_probed_default=true
> +	fi
>  
>  	if ! mount | grep -q debugfs; then
>  		mount -t debugfs none /sys/kernel/debug/ &> /dev/null
> @@ -766,6 +771,7 @@ EOF
>  	fi
>  
>  	# clean up any leftovers
> +	! "$esp4_offload_probed_default" && lsmod | grep -q esp4_offload && rmmod esp4_offload
>  	echo 0 > /sys/bus/netdevsim/del_device
>  	$probed && rmmod netdevsim
>  
> -- 
> 2.50.1
> 

