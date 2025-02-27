Return-Path: <linux-kselftest+bounces-27813-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1DADA48B5D
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Feb 2025 23:23:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB584188EBFE
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Feb 2025 22:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5850F27FE9B;
	Thu, 27 Feb 2025 22:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bTfVVsli"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D85E327293D;
	Thu, 27 Feb 2025 22:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740694919; cv=none; b=kzKvoS7WgyPdXPp8FNPR5MQcrkbpSjadVP8gN2UllOAPuKmzgadu81WHxim7Q/gCdVk0jNq9eWPhCFaT6PUyRgB8gxvEtomBlbRg5t/QGv1hqrRCnWAGJvuHIpf55woV/Yy/ImqMYIR91GSQHBT6VM85iASNaGeuMaZXU7Ov0ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740694919; c=relaxed/simple;
	bh=S5+ogH025mo7D32RvO75nmwl4Ffkhe7ZHnPHH0WJv0M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XBfMbE1qHoT+HmwzJjBINUnYt37WEM6WmB/I2sm4/KwN6WkaLpBK8S/biZBr3Xf3Bdxwwy+zx2xn2eMteOt4Hpkknifo82xTa7Rd3xcQu5QU5KRCe6jMd7fIOYarlQENBjDYgKQYhIgJDohP0Rj0BHqbz2GiYwb/jD67iOYNb+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bTfVVsli; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-22328dca22fso24143485ad.1;
        Thu, 27 Feb 2025 14:21:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740694916; x=1741299716; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AGROt8SwJjPlhwT8ydym9pYHbVe2F/Hnh7fdrYWjI+k=;
        b=bTfVVsligIhJXvn1Ysfj7ikz2o7qh24s0aWHhKtK/RtZRj5nBdVfB7JXV2l/wu+HTt
         rAIoY6DNsLqoqUbGsiq7llsVViU9FXLIpI8exHCBJv6HmC4iBrQOqG/BrnWQflvTqBsS
         eKX+YVSQHyUK/1TcRVvRiyesBk1tIlVZfuDS2KzCUF4pEzGfKJqrtNRkfeScgUkQxpTU
         WmO05+YDKgiAmSAdjHDnQ2iQqK4zp8Z1KmIMocEczSmKYaP/yzo0PxfCaC9XIYlqIsm+
         ylJTNPoDXGQr/vMs8RyHV0FkdaNglcrxezgovJHoh3O25DNmhDMrjq91GvY4kzWAKYxu
         z/Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740694916; x=1741299716;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AGROt8SwJjPlhwT8ydym9pYHbVe2F/Hnh7fdrYWjI+k=;
        b=lWv1nGiCP90nSIkfaMdbHpVFh1ijP7G47pWFQ2Wj9DGbiuk01nN2x7hXEdyEul5Eh8
         DjGx23cioBNiRHmVZ8Y7YgLtX0LVJrgWzRQ/lFcBO1XWMTVQODklRBnDrzUBw+Od3+AG
         +Z6aV+4TA+BKlw/0tXuOEBBOHhG602WyoAxVAHkybZVle6h8H6ZNWMJuZ0vuOCtiAKvJ
         uUVDIV3CY3ToWpw6WQfUM1ASzfgVOLUWEVLgdPrGIooe0SN9KL0oXmgVsz+9YOxEG2ZC
         QNzztu3OmD8lg6F+88YMi4HtqT794bcXAd0deHFU8IVRRoz45AeftR1Z6kxH6FlcBREX
         79EQ==
X-Forwarded-Encrypted: i=1; AJvYcCVQbKbmv9l+xG8eL8mXWY0+nHPI+42vJxgyrx+TQuFbac1CpSoNmRdT3FUjEDzcbH+rsnbEA5JNjf11OS+6@vger.kernel.org, AJvYcCXjqQVN65MGkRBw1eXNf+SjiVAaohanNSrgPa93rdXgMcHYSEVkoHnajJ7pRw1G/B2gUe0=@vger.kernel.org, AJvYcCXq0gvaU+6BrDm+ir4HavqYh1UAKvcrNcfT9uCh5Dv3DlKjo4nz9XemekUlZej6ubGwdElmOMcZ6bc4pASG4ulD@vger.kernel.org
X-Gm-Message-State: AOJu0Yz84rvZsb3gLka+wArYg0H/gjzqo6ehcOsZWjhpcIFg0c/C0/ru
	sXit/tdMh3apo+i6uY6PB42WBkV5fJ4yZQrMvipMC7jbaS6GErI=
X-Gm-Gg: ASbGnctJgRjKfZUl1HMyPq3KeybFEDZVSsWTGcELDQbj0BlehjCNgLCrA39FK+CFD6w
	Tjvu4Pr2K6x3PLIyHU2nEpfCnw+XS4P7dD5CWcqUoFqAN23527lC5OYlRLyrARSrv83tU0lgs9p
	TuFFvLMqk+cCv6jgVGoIifs/N7l+Qs0WK7atSBcNvucHzPx84v4BdVjZo4ex5LUPQok2t3FpYM4
	sN/K0xmwW5KYHCYkkbYB4PdzTiV1tOKn1V4B02GN9SLP3SGz119QsqyXoPNhmMfCKoag15/tMlR
	Fm7zN0CwCD3zsJZx3fKGeVVpAw==
X-Google-Smtp-Source: AGHT+IGXco4uXMHtHXt7KMJNiHK1jygsRgqWvoJRYUrUimfGnZzf//Gu45O7incVoX3lI43/MEYKpg==
X-Received: by 2002:a17:902:d4d0:b0:21f:6546:9af0 with SMTP id d9443c01a7336-2236925f2e8mr11651555ad.44.1740694916117;
        Thu, 27 Feb 2025 14:21:56 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-223504db1b6sm20615405ad.161.2025.02.27.14.21.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 14:21:55 -0800 (PST)
Date: Thu, 27 Feb 2025 14:21:55 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Alexis Lothore <alexis.lothore@bootlin.com>, bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next 08/10] selftests/bpf: test_tunnel: Move
 ip6geneve tunnel test to test_progs
Message-ID: <Z8Dlg3RNglzb2bTN@mini-arch>
References: <20250227-tunnels-v1-0-33df5c30aa04@bootlin.com>
 <20250227-tunnels-v1-8-33df5c30aa04@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250227-tunnels-v1-8-33df5c30aa04@bootlin.com>

On 02/27, Bastien Curutchet (eBPF Foundation) wrote:
> ip6geneve tunnels are tested in the test_tunnel.sh but not in the
> test_progs framework.
> 
> Add a new test in test_progs to test ip6geneve tunnels. It uses the same
> network topology and the same BPF programs than the script.
> Remove test_ip6geneve() from the script.
> 
> Signed-off-by: Bastien Curutchet (eBPF Foundation) <bastien.curutchet@bootlin.com>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

