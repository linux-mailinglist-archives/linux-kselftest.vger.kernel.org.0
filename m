Return-Path: <linux-kselftest+bounces-41741-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FCA8B810A2
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Sep 2025 18:35:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0DAB720390
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Sep 2025 16:33:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD6892F83AF;
	Wed, 17 Sep 2025 16:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T6cnV/rF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E78B629A9FA
	for <linux-kselftest@vger.kernel.org>; Wed, 17 Sep 2025 16:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758126829; cv=none; b=I/d8t4uGUflNWGKOS/LJukTYdYB/bPoSUlyzXgSSzfIrUkJatPcQCsJX13ORZo0sGRhVmiDb+QirDC7O9mZv/T1b/2wJFZRSfLtlal5F4P5gzSgkmFlTEjiDwQQE4544koBaH4S31Jizx9Vj893v5n/PiQ8hBegErNx8feXjtYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758126829; c=relaxed/simple;
	bh=T5rlTmWWL8B+5YTFOLQue/O9Et9XFS1RiNWss6/XQ4E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EelDuPHB5SuEeN6sX7xLBQojcsSpe+/dWX3e2xGSMA02wqUhMtHu9csVJhqZvH5nZ2OR5F02qeUcoFeiCT6H0nFmLR4L0df1HL5lCPH72QePxtnrnZy82SLww4xbJ5qMEqm9xhbti7X7hiS4lYixFB2B9ESHCMbkjANOKFTJlLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T6cnV/rF; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-72267c05111so460117b3.2
        for <linux-kselftest@vger.kernel.org>; Wed, 17 Sep 2025 09:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758126827; x=1758731627; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=G8RlqH67o65j5zlsChBs5Q8TtBN1OWluyR+3o2WLBvY=;
        b=T6cnV/rFgXqt/niP2fM57gb+CLF2WZs6T4GqVWyC9DWxPy5yB5DIXwEtk/EA2yC0c9
         0PQb6m3EeiWNuPGw41KNOJKGH1B+Gxw3XtErDq8N+EpKg9dUnIVPoVV+LrNtfrTG7bDv
         l6As/7Cf9DhfTtH+Kz0AiLoCOdbFWsYLublGV2BMqjZQacHM3LRjD7b6KkJwL+oQsc7J
         60Q47It15vBvlfyUWta/IRfGh3ZtAZ40RLOe/6QtUm/M1cW3GeASWktY6Qyog33Sc9jY
         m56tERbOLqDzHNkr5AAu+lX/VGaBLlBlPpZTYoUxZ/OC0DGnGAesr7hX90PdM/oR0oJM
         5+Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758126827; x=1758731627;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G8RlqH67o65j5zlsChBs5Q8TtBN1OWluyR+3o2WLBvY=;
        b=O6O7SsWQTqClupXfGerkZYJG7y1G+Fy8uG/PPx0B7zIeTHQS6fq6GZmINJVEJQ26Y9
         6qENafNsW47Py1KTzXx2hRSXNPKE1OyrVhU3zX6k1kbiHaMBddwhNVSGv532kkMlP7Ps
         oTCxB3gOEe2hIYXkdgbzIrOeqeJW+v+Q+QoKd4np46518k6V8adtgbyKRYFN1Rh2n3r7
         iWiE+IajgvMNLrJ3eV1HxILXYsT7OQvfcfnECfqtAIs7Xw8v/tlIdAMI22CXRrBYazqB
         VMzPCVBvWX4ZkaTSBBaYOU20LQrwLNINXDYJ+rb3SAyxNqofRsBTpPA6kY1RSZqM+Ng5
         UD8A==
X-Forwarded-Encrypted: i=1; AJvYcCXVRscQqwizHwmSfS5SoIc+EYCLiM0R1BxBswOeUPQKH9jBUKNiskvds6xY+ePq2lZdQPUWDSJ+sex4eFnxPzM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMWFSovcYKTKWQMQSU05FQQYcInscAxN0oG90PgfB6l+nOdRDF
	XjtwcGJU/GDCRtxmt8P0l2TQEbaI0RB8CtqdmUbdk2/Ri2agN8nYAmZW
X-Gm-Gg: ASbGnctpV15O5PkOyuY8Q+qncBFNBN9mX4u6xE0d/VDwsQ9x2ndIETRufwcE0pvUPBD
	XxD6sBLLfTkvlYXeMMZNk8LcpC0QBQiIAqK3yTGubiPTJC5LYOGt3a+2UKCrr+IGLDQKaEyRVqf
	J9Xo1uE26IJyJlBssblzzI7vlgtij4BPa5N/Z24zzptaPCKnwY461YW7U0+8huIb1tfa7/uWn45
	0psH8K86VBAzRQX7/vJJ36YXNmM3z1VZXFHYFbN/4ZznwNwqTIVy4M5SyT0eGagvUTF//90BcTF
	isKesrrDLedsLb/EUeageVzQa9AGNrsNKNS4ztAyTGxJLyYQUsXWP2FSHOVcmrD5NI0AFXpqrUJ
	LmyMB9+MXlMAJX7zlLUpnRXUrTlAo13LTG+4kj2fJRtFkQWE=
X-Google-Smtp-Source: AGHT+IFLdAPsCemxYmXa54CmGTZ+ICmGT/J4SrrjoNdABQMevWtNWlVjH/3dQNMTr0HHKjs9ZEs8Vw==
X-Received: by 2002:a05:690c:64ca:b0:734:ee:200b with SMTP id 00721157ae682-7389304b317mr22927617b3.51.1758126826608;
        Wed, 17 Sep 2025 09:33:46 -0700 (PDT)
Received: from devvm11784.nha0.facebook.com ([2a03:2880:25ff:4c::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7389d32a27dsm5115687b3.10.2025.09.17.09.33.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 09:33:46 -0700 (PDT)
Date: Wed, 17 Sep 2025 09:33:41 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Simon Horman <horms@kernel.org>
Cc: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Bryan Tan <bryan-bt.tan@broadcom.com>,
	Vishnu Dasa <vishnu.dasa@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, linux-hyperv@vger.kernel.org,
	berrange@redhat.com, Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v6 0/9] vsock: add namespace support to
 vhost-vsock
Message-ID: <aMri5apAxBpHtZbJ@devvm11784.nha0.facebook.com>
References: <20250916-vsock-vmtest-v6-0-064d2eb0c89d@meta.com>
 <20250917161928.GR394836@horms.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250917161928.GR394836@horms.kernel.org>

On Wed, Sep 17, 2025 at 05:19:28PM +0100, Simon Horman wrote:
> On Tue, Sep 16, 2025 at 04:43:44PM -0700, Bobby Eshleman wrote:
> 
> ...
> 
> > base-commit: 949ddfb774fe527cebfa3f769804344940f7ed2e
> 
> Hi Bobby,
> 
> This series does not seem to compile when applied to the commit above.
> Likewise when applied to current net-next (which is now slightly newer).
> 
> hyperv_transport.c: In function ‘hvs_open_connection’:
> hyperv_transport.c:316:14: error: too few arguments to function ‘vsock_find_bound_socket’
>   316 |         sk = vsock_find_bound_socket(&addr, vsock_global_dummy_net());
>       |              ^~~~~~~~~~~~~~~~~~~~~~~
> In file included from hyperv_transport.c:15:
> /home/horms/projects/linux/linux/include/net/af_vsock.h:218:14: note: declared here
>   218 | struct sock *vsock_find_bound_socket(struct sockaddr_vm *addr, struct net *net,
>       |              ^~~~~~~~~~~~~~~~~~~~~~~
> 
> -- 
> pw-bot: changes-requested

Ah dang it, looks like I had hvc disabled when I build tested it.

Thanks for the catch, I'll fix this in the next rev.

Best,
Bobby

