Return-Path: <linux-kselftest+bounces-48639-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 87C68D0C9AB
	for <lists+linux-kselftest@lfdr.de>; Sat, 10 Jan 2026 01:11:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8E5713034360
	for <lists+linux-kselftest@lfdr.de>; Sat, 10 Jan 2026 00:11:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF36961FFE;
	Sat, 10 Jan 2026 00:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WF5/fIAP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3953D18EB0
	for <linux-kselftest@vger.kernel.org>; Sat, 10 Jan 2026 00:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768003876; cv=none; b=F0hM6J3E/31lJhR0ZoplKTefSLyPwd3H3Jncdy8KcOXO8q6mLY1OeB5ndYut3sDJmJw1qy2aqh5uS5LETXmJAm19Sh+pmE9Z+HjFvimpJY2XHjy3TgliU+hFF7/DWwYfjDZs/F8+PBfrVJR9iPfT7JQO5bb+OM30QWg/L1PQ7WM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768003876; c=relaxed/simple;
	bh=XszBXPJ18HkMpycCWMX0Y8i3Aoh/kyFsduWJiX9qSIA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QTM0zD74ipdRKCtpsGsNLMXxuTdEE1wq5tBEf2lYYQCDw20M2Q5dkqVzIe2Y3cYRbLLmoEqljPTD8PC2qelk/IXEDHeSH3hMQqyZDLXNheV5GiBNSDssD2PhXAtW4x9qVNOnpXuK/E7wS7b90VSb2XlxEB73gbEbeSVUYe42jdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WF5/fIAP; arc=none smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-6467c5acb7dso4633383d50.1
        for <linux-kselftest@vger.kernel.org>; Fri, 09 Jan 2026 16:11:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768003874; x=1768608674; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6N0A2c2LYMc0dJDgYzdUUiKfOdoal/WEyiilk+5HTkg=;
        b=WF5/fIAP4AEyO4f6KWSJP2rwaSy/sViblkfSeeU8EGHt4W8zcGu8GdInztygNBG+SI
         lFZMtf5mk92Bho0bl/kz0wrylefbq54djvfDKFetQZqFm4VltIFlMyuYZ3TYsee7EuPv
         cuFATTU+AojUbvwayi9w7OyNstSzzzIWEbhQr08urKNmtzyFQEASvw8VCOBtpjn1hEZ7
         /S6AXS4ADril+8pCuPrnQcp3DFjvjtLVBL9cCPyinaRd8F5C9kJqxbl7/LUxO4bKzb5y
         2VTvsnHADEUfrU8ytID59HZXZVXxMG6DT+qvAAEn0faaDEgjA/ym8ZI4sdu6WxDKie2G
         EoTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768003874; x=1768608674;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6N0A2c2LYMc0dJDgYzdUUiKfOdoal/WEyiilk+5HTkg=;
        b=gqEtROMmNPloIudj1KzC03+zMxceH3dRdF2dgDYcyn957g+67UWqq0paLHm7KBr1bn
         txsIhGF76JewoxADJ/Na9WM1F5m8hufAaJa6zsMFfkkAzivak1LHEWw8YtkpV+JJuE8P
         LCvMWQdQYnzIZS5U4RkjdWhKf0dzZHuNnTlzGw0xYymXgdHY3uGFZva9QatUdJT4lCnq
         OCpfmAob31eG7xczhaGuVguD9nUiPE5ddhGv/kW5zLO1nySSdE3Swukq7dIA6/VkdaRx
         FG+7x7mpyNek5VaRzD+Vj3b8uwO5834/4Isn8X9NM4hlClRz2k+DY6tMzLhtZR8xiyam
         VDEw==
X-Forwarded-Encrypted: i=1; AJvYcCWQCAlvLz///SG1iqe1j2vBvG3bcUjZKxSTyIwkjV09LtRrAGXqAKYMW/Z90yRjgbMhqFHZVTh3Nb+TWdpOlbU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjnuFuh/D8+93nsiQxlNZ9CL1dFr/MAsMR6Kkq/vmucgUs9tPc
	NkoGy+fexZX6TqoyQsEJt8s4I3UazV39DqqdlYUfEDFuUYJcVeP7KWAu
X-Gm-Gg: AY/fxX4RrDmZBt0qf/5wx1pvJmNgMq9Vj4YIgzKsLCIn60LAU3gxpk0XRIRt+IPiyf7
	zwAX4hd55Wtb9wH2QVLTQpijn4fdZKCeity7SNm7z++4SZ+te8wuucBIjqXKEpAs2Pyie6bpjc0
	5xRhFz9/sc07wudFmY65zLxiSZrAd5WTe2v9NNv8gncWGwPzA0OGxfvx3xlFiBBNYgDU4QS41XK
	ras/7XFR2dYls5iMXgTGLGfOUp1IKds5YjOxbvjadXROQ+o7HULFPZCpGepl8EIRa8nYpFbBZLQ
	JmqLTYobGkz1x79qjGjfA3C3DWZvZPmJqdguAYfwPXFZ3X5dd6BY/VzdFC8oAssVraeSDMtUtqw
	6hJVRZUe+e+nHo/TMC/uUsGfbJJoHZzg1tTQyk72RsuAZap5bn6Wdgxh/9nR0FL0fLztyAHMHA4
	p7bef+MP49KkAOdzZuhvq6Akv8bOorcJyfrA==
X-Google-Smtp-Source: AGHT+IE5CW/VP1bFR/Dosae0XD0Rb9scRJI8ZCC2GQQ5cF/xpuuKEVGU70q9buii5G2BZNROzhlUqg==
X-Received: by 2002:a05:690e:1611:b0:644:7712:ed72 with SMTP id 956f58d0204a3-64716bd7b38mr8182868d50.43.1768003873903;
        Fri, 09 Jan 2026 16:11:13 -0800 (PST)
Received: from devvm11784.nha0.facebook.com ([2a03:2880:25ff:a::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-790aa553ac3sm46524707b3.5.2026.01.09.16.11.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 16:11:13 -0800 (PST)
Date: Fri, 9 Jan 2026 16:11:12 -0800
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Stefano Garzarella <sgarzare@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Bryan Tan <bryan-bt.tan@broadcom.com>,
	Vishnu Dasa <vishnu.dasa@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Shuah Khan <shuah@kernel.org>, Long Li <longli@microsoft.com>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
	netdev@vger.kernel.org, kvm@vger.kernel.org,
	linux-hyperv@vger.kernel.org, linux-kselftest@vger.kernel.org,
	berrange@redhat.com, Sargun Dhillon <sargun@sargun.me>,
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH RFC net-next v13 00/13] vsock: add namespace support to
 vhost-vsock and loopback
Message-ID: <aWGZILlNWzIbRNuO@devvm11784.nha0.facebook.com>
References: <20251223-vsock-vmtest-v13-0-9d6db8e7c80b@meta.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251223-vsock-vmtest-v13-0-9d6db8e7c80b@meta.com>

On Tue, Dec 23, 2025 at 04:28:34PM -0800, Bobby Eshleman wrote:
> This series adds namespace support to vhost-vsock and loopback. It does
> not add namespaces to any of the other guest transports (virtio-vsock,
> hyperv, or vmci).
> 
> The current revision supports two modes: local and global. Local
> mode is complete isolation of namespaces, while global mode is complete
> sharing between namespaces of CIDs (the original behavior).
> 
> The mode is set using the parent namespace's
> /proc/sys/net/vsock/child_ns_mode and inherited when a new namespace is
> created. The mode of the current namespace can be queried by reading
> /proc/sys/net/vsock/ns_mode. The mode can not change after the namespace
> has been created.
> 
> Modes are per-netns. This allows a system to configure namespaces
> independently (some may share CIDs, others are completely isolated).
> This also supports future possible mixed use cases, where there may be
> namespaces in global mode spinning up VMs while there are mixed mode
> namespaces that provide services to the VMs, but are not allowed to
> allocate from the global CID pool (this mode is not implemented in this
> series).

Stefano, would like me to resend this without the RFC tag, or should I
just leave as is for review? I don't have any planned changes at the
moment.

Best,
Bobby

