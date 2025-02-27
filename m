Return-Path: <linux-kselftest+bounces-27812-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B1605A48B5B
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Feb 2025 23:23:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 850607A29C6
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Feb 2025 22:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 715C927427B;
	Thu, 27 Feb 2025 22:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eZkAJqjA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC25E274270;
	Thu, 27 Feb 2025 22:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740694908; cv=none; b=tSsw6K7GstYvjxSpWInji1Fq9ERgZxWSLomk8ytCKho5ajndgnuq9WhLn1Nl2sVZBw/y0P1YMDixd2b2zcMNOs7o0peEWHjN20G3m9biQbWTanH5/lsYI2shO10yhrO6YRwxYDOQhWgl48/iPbZSWP+9o4PNJhPpYoXrP9SCL98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740694908; c=relaxed/simple;
	bh=9mrpVRh9LCe6Cx7DhW4a9O8r1znb4UUGRuzbaoZAdAA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bYUg+dqwDx3JbdvI5vG7FsO2gNnqcCEmgxjgJjRipEp2e6oLH5EZIQxDUfAieEoqf2jqa6jq6rbYM/k862sHD8UWsOX2vstHxfuECt8UOIarXC4DkENIhQL/XnAVvgNBTuYCVQaJNtJm/TGTG4i7wLUc16lGE92UelpYutvYmX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eZkAJqjA; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-220d132f16dso21617135ad.0;
        Thu, 27 Feb 2025 14:21:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740694906; x=1741299706; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fIcVrtq95e3d6hB6s4EQxlcOTWBSWsLA7dFATbPAJjk=;
        b=eZkAJqjA3ajWWlkI1tV98d8KLHbYcNHFSGVkgddnBx4Jmpy3XixK85Cqi3qv0/Fq0y
         o7/ChyeG4aXiw7sp0BXauUR5ea2JeXhhg9tv/Nrt40ftCoqZLoy8OQccOZaZJlEPy8r9
         WsDdtTbKlnhBMKPZVIHMq/f5que8bAXXN3YrbYmUnCtSxf4oJcB7Z2hARVZPMdrd7HX7
         uLtrlSALaYZDVZ6WGv8yAzXUmw4XJ/83k8L8d26cuiGpbrhZPDn1o7pcJX2HEx6JfIvm
         H4HUarSUmef9H7ETKRJkgrZCwGpl8/CaZ3NxN76oJcTNvL+BPZL6JELc+pTvECCBA4xS
         +zGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740694906; x=1741299706;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fIcVrtq95e3d6hB6s4EQxlcOTWBSWsLA7dFATbPAJjk=;
        b=gO1ANJ02zbRik3nf/KCDmUNiMcsXxr5ml515rVLEhpcy3pL1BCMbazZluMHY9G+zM0
         3+K+tOSrtcKgQsTxIMAInFzzGmUdFpeMrK7f/lHUCk/LmZmM5TwfbAQhWlFzhJg68GpL
         AkMMkXHrIxiIbDwAjCbioqikIrEpqV3+g3j38fTwyDemkOOOaRyCWLmvsxvX6Dw6b2eX
         AAviLBgQa8J+0hX4zpbyUNE0WPWuXQGFMkVbBXm5fTB4+9uRHO/d7xMKCy9drIoa5MbF
         pqui91F/sew65RikcV7tixKL2Z8tDUHi8HuJgiQ0X7ouIbmBIWMHqqy1H1RxphbEZUmF
         VPnQ==
X-Forwarded-Encrypted: i=1; AJvYcCU9XYrxesquhux1Iz4fTN68AqZYYR8M6jjC64no8d4KzgDT2Zu5fENqsmxg/olRwwun9csRRgrDyow7DIf/Wjgu@vger.kernel.org, AJvYcCWThfI/ThAT7IIRhF7ZtJ3yR8bVT9lLS50SxKBBo71R+xvg+Sd3BWbhLD2XBKYAp6gLDsw=@vger.kernel.org, AJvYcCWoCKg93CI1q33FEZbmKpG6192XNvLYf4YrWv+azLD8iADYECQxagpg8LHtzgvDsDUnuAC6ElNYYvrZt46A@vger.kernel.org, AJvYcCXssdBipy0rgCt9sifHLO4IWfDlWaxZXeUbUpWKbBEpf+A3YnaREJ5jrYZ2PesVnHU+9b8JhjWA@vger.kernel.org
X-Gm-Message-State: AOJu0YyG+2EExu0VQp2iRbPAtI7X0L+/mslxux33vPEEHoc0yemwO8o8
	p8qgPzIazcC3EY8XH2jIV2ud2RqnFp2iqetuzCqeVkW9baU2aFVW
X-Gm-Gg: ASbGncteUU7wz7ltDXC8f4s9V/Uy05YzUhxzUaV9+vNw8O2nfl9F4Ybq3n3Ri0uCUQj
	hSE3mytkLqT8L3qYBlXG6Vj21jYzQFASvkqhPzjVk4nf75sHec7kPcOOHn4k0HQKdYFosyQqlz3
	wo55+iKtBhMulqVLYz4s47CS2/sJKSg1CM2dyV1norJsm6VZAUNSyHgjSXP2EOiDVQyTse9F/ez
	96hlGzHgOJSN0k3t906KVBGVCMx7De237n0MWriK7CoTM862exRr/Qr8y86XpmfSsqyOwelxX1Y
	82//jkB1Bze80Hm7P6ClceWb
X-Google-Smtp-Source: AGHT+IHFDPtA7Rh1Tbm1AAknO5KNAPlcPWVIhUujcQtL3AbXorqi10ylyIaAaiPmb1x7jE/kaGHSrg==
X-Received: by 2002:a17:902:f60a:b0:220:e9f5:4b7c with SMTP id d9443c01a7336-22368fc0c0amr13191975ad.17.1740694906007;
        Thu, 27 Feb 2025 14:21:46 -0800 (PST)
Received: from gmail.com ([98.97.44.1])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fe8284f041sm4788667a91.41.2025.02.27.14.21.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 14:21:45 -0800 (PST)
Date: Thu, 27 Feb 2025 14:21:41 -0800
From: John Fastabend <john.fastabend@gmail.com>
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>, cong.wang@bytedance.com,
	jakub@cloudflare.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	andrii@kernel.org, eddyz87@gmail.com, mykolal@fb.com,
	ast@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
	song@kernel.org, yonghong.song@linux.dev, kpsingh@kernel.org,
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
	shuah@kernel.org, mhal@rbox.co, sgarzare@redhat.com,
	netdev@vger.kernel.org, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	mrpre@163.com
Subject: Re: [PATCH bpf-next v1 2/3] selftests/bpf: Add socketpair to
 create_pair to support unix socket
Message-ID: <20250227222141.mnvpmnvafisd2pjk@gmail.com>
References: <20250226132242.52663-1-jiayuan.chen@linux.dev>
 <20250226132242.52663-3-jiayuan.chen@linux.dev>
 <Z8DCZO8n39avsvnF@pop-os.localdomain>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8DCZO8n39avsvnF@pop-os.localdomain>

On 2025-02-27 11:52:04, Cong Wang wrote:
> On Wed, Feb 26, 2025 at 09:22:41PM +0800, Jiayuan Chen wrote:
> > Current wrapper function create_pair() is used to create a pair of
> > connected links and returns two fds, but it does not support unix sockets.
> > 
> > Here we introduce socketpair() into create_pair(), which supports creating
> > a pair of unix sockets, since the semantics of the two are the same.
> 
> Since it is only for UDS and only has effectively 1 line of code, how
> about just calling socketpair(AF_UNIX) in your patch 3/3?

If we run that test with more than AF_UNIX it might be best as is. I
think there might be some value testing that flow on TCP/UDP even if
its not related to the bug.

Thanks,
John

