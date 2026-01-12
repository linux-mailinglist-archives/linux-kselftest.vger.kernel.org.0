Return-Path: <linux-kselftest+bounces-48798-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 99657D15D5E
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Jan 2026 00:39:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E75B23010CCC
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Jan 2026 23:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77F2929B8E5;
	Mon, 12 Jan 2026 23:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d7xncfja"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2FC0199EAD
	for <linux-kselftest@vger.kernel.org>; Mon, 12 Jan 2026 23:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768261181; cv=none; b=h4YDNgPp80zQnAI30p28W1Hyw3Z+FRXwPEXHBls2mWorMb9zHo292fL8AvzmlfR9FG6DqonPflDeMP10lvxdgu398hvYBUkyYbqhVQqwNB0FSeOxfe6UH/a0m+ncWCTx0rl1jRHfzIi+TvN/VUuY1y2u+FdbjmnrR0ADy5sCqEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768261181; c=relaxed/simple;
	bh=D/QOV+PvgeGDhnZ/ix6Fp2phNTxa9gFGlVxWZXZmAqE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cd2x0FDk+5n7HC7eiNmC+V1O0t75arAlQLYGBaxL8fqPsEn9x0UPnLcU8nfeGpvfGahwSEL0cLgfG4GpBvP/05g9dg7Q3VzY1YnTIigsbTyYBbXwcALchTon5QBknw83IWPJP+UI17MQIyFh7akSilkiFJLL3rQEa949W/pYS5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d7xncfja; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-8c30365ac43so655375485a.0
        for <linux-kselftest@vger.kernel.org>; Mon, 12 Jan 2026 15:39:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768261179; x=1768865979; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VrgEBLHMQ7w7z7OSk0+LmFxB5np8c3y6da/CYllo/d4=;
        b=d7xncfjaPlYGgAVN189xM8le3AGcP9UCam2ecLPl4eMo0apKePl+k/MoFfvTOESri9
         jpKEGW8OpLOehZ4WQxGeRc+iHkBT9wyZJdvfvlULMdSiX9F8rPkT6PgiEoJq4dHlhRoh
         qkv4dEP7IjphDnzvoWSqE+Edg4auIJy4Q6rk8vaByrnJKM86MbjVpaIS/FIjthkUqt0q
         DKNrLmOqjB+lFO4RWknzNtnoIyNk27PZTNQ9iQ5hqqKFJKC0/MN0LZqMRlF1yo+BTdMg
         MZIcWtsLEekQoTgRl6uZ1G6fg6psHqdVZP63GY/c+YWmY+7Fg22VNvHQ/YRS+oczPqml
         K6NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768261179; x=1768865979;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VrgEBLHMQ7w7z7OSk0+LmFxB5np8c3y6da/CYllo/d4=;
        b=IQpvivR96KizJScqMfgyys+/BXxEYb+pFewPfq/4enW59SKSLTO6MqyciQZdFLKAD/
         HBWtcG8WtijX1rQdz8e7zZrLLlJkMi5AMY8/rQU0zjIYb620CnRm3c6GXQgO4sYGOyQT
         dY8ZW7TP/vPxqBTnihVC8wi4zQTGpniHxfr6V7ILsZGRdYGLM1LuwjUL3/P8e/3+R+sk
         bQAf5HxJfMIckzwid208N0dXqD6HlsqdEWk/w75OaRR6QINleholPFDWV500/QH/dTuE
         2mkuZfDGVNj1YqiSeMmjpWcsE1o2DC/ik3caFAoNP6rXj3TFHsLVUhUKv67ib/owmHHW
         E8TA==
X-Forwarded-Encrypted: i=1; AJvYcCXGwA8siuRMAdjwapEHP3E/rxofqkyl585DKt+8QfXtMbP+IaBbN9/jIsg42DvYu1tp0R8xe5sGrDMupWpMzJo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXiyeLU8+6QYRvyZTKLN/5AJ52t+PmVGQJNIfiEcFNY+IfghlG
	PNI0HNYiX6PIirHgzj4XiQwKV85dgN3Z1tO1rWm7nFMZx1lXBlCyIFm6pf0GSA==
X-Gm-Gg: AY/fxX4gqT1VpdUcLJX7hPRX+RVQk/twNhWhjPhMRDyki2zeKZr7TdMYWau18UknMRu
	AviwoL0OakB02j1crMs9VXAykXvlKWIWLgs23Ou11HqlAJho3rgIE4xxd82Edo3NLYVOqEFLKFg
	g2XUxLdNCX7XMxAUWeyjMlg6QMiM3Lm5bkrv2jdwUNweyLaqJTKPVqwX+P1WOOfDrlz5ke8Pfdi
	R1PJKt/i+km19al1Om/1/G+gwLsn0eqQpRxVCCLVzf93XrNDaPNvog3SuA+tJXh5FgWMwCnLWYX
	XAn8mnvrwMx4wZ4osLY8XzRBGaLFQxDWjEkrkYimBb1z2OjRCedzVyvtMzb4/O21oJns17PhYSv
	PZhL4i8j0pf+hWCAYyS0p3QOe3KXnlpuJ71hk/C8mv9Y1zcKHZIzVbL9UD/PgOYsN08s8zNjVx3
	pPwrz2T8P5MCHJUMZ7NFhr8JaJ9uW+BYV2OISH0ZpxXjC/
X-Google-Smtp-Source: AGHT+IEEIChW46EWJZZzmGq0dv1aKbX23y4OJcSbpVgI4A7CpdyG+MDzyxvMqujhAfbDeFoADMp1dQ==
X-Received: by 2002:a53:e303:0:b0:63f:a727:8403 with SMTP id 956f58d0204a3-64716bd78d9mr12404043d50.38.1768254541320;
        Mon, 12 Jan 2026 13:49:01 -0800 (PST)
Received: from devvm11784.nha0.facebook.com ([2a03:2880:25ff:8::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6470d7f7c04sm8530959d50.2.2026.01.12.13.49.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 13:49:00 -0800 (PST)
Date: Mon, 12 Jan 2026 13:48:58 -0800
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Bryan Tan <bryan-bt.tan@broadcom.com>,
	Vishnu Dasa <vishnu.dasa@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Shuah Khan <shuah@kernel.org>, Long Li <longli@microsoft.com>,
	linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
	netdev@vger.kernel.org, kvm@vger.kernel.org,
	linux-hyperv@vger.kernel.org, linux-kselftest@vger.kernel.org,
	berrange@redhat.com, Sargun Dhillon <sargun@sargun.me>,
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH RFC net-next v13 00/13] vsock: add namespace support to
 vhost-vsock and loopback
Message-ID: <aWVsSq7lORhM+prM@devvm11784.nha0.facebook.com>
References: <20251223-vsock-vmtest-v13-0-9d6db8e7c80b@meta.com>
 <aWGZILlNWzIbRNuO@devvm11784.nha0.facebook.com>
 <20260110191107-mutt-send-email-mst@kernel.org>
 <aWUnqbDlBmjfnC_Q@sgarzare-redhat>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aWUnqbDlBmjfnC_Q@sgarzare-redhat>

On Mon, Jan 12, 2026 at 06:26:18PM +0100, Stefano Garzarella wrote:
> On Sat, Jan 10, 2026 at 07:12:07PM -0500, Michael S. Tsirkin wrote:
> > On Fri, Jan 09, 2026 at 04:11:12PM -0800, Bobby Eshleman wrote:
> > > On Tue, Dec 23, 2025 at 04:28:34PM -0800, Bobby Eshleman wrote:
> > > > This series adds namespace support to vhost-vsock and loopback. It does
> > > > not add namespaces to any of the other guest transports (virtio-vsock,
> > > > hyperv, or vmci).
> > > >
> > > > The current revision supports two modes: local and global. Local
> > > > mode is complete isolation of namespaces, while global mode is complete
> > > > sharing between namespaces of CIDs (the original behavior).
> > > >
> > > > The mode is set using the parent namespace's
> > > > /proc/sys/net/vsock/child_ns_mode and inherited when a new namespace is
> > > > created. The mode of the current namespace can be queried by reading
> > > > /proc/sys/net/vsock/ns_mode. The mode can not change after the namespace
> > > > has been created.
> > > >
> > > > Modes are per-netns. This allows a system to configure namespaces
> > > > independently (some may share CIDs, others are completely isolated).
> > > > This also supports future possible mixed use cases, where there may be
> > > > namespaces in global mode spinning up VMs while there are mixed mode
> > > > namespaces that provide services to the VMs, but are not allowed to
> > > > allocate from the global CID pool (this mode is not implemented in this
> > > > series).
> > > 
> > > Stefano, would like me to resend this without the RFC tag, or should I
> > > just leave as is for review? I don't have any planned changes at the
> > > moment.
> > > 
> > > Best,
> > > Bobby
> > 
> > i couldn't apply it on top of net-next so pls do.
> > 
> 
> Yeah, some difficulties to apply also here.
> I tried `base-commit: 962ac5ca99a5c3e7469215bf47572440402dfd59` as mentioned
> in the cover, but didn't apply. After several tries I successfully applied
> on top of commit bc69ed975203 ("Merge tag 'for_linus' of
> git://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost")
> 
> So, I agree, better to resend and you can remove RFC.
> 
> BTW I'll do my best to start to review tomorrow!
> 
> Thanks,
> Stefano
> 

Sounds good to me. Sorry about that, I must have done something weird
with b4 to pin the base commit because it has been
962ac5ca99a5c3e7469215bf47572440402dfd59 for the last several revisions.

Looks like my local of this is actually based on:

7b8e9264f55a ("Merge tag 'net-6.19-rc2' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net")

I'll re-apply to head and resend today!

While I'm at it I will try to address Michael's feedback and bump a
version.

Best,
Bobby

