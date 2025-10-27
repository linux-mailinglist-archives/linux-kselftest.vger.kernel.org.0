Return-Path: <linux-kselftest+bounces-44134-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F533C0FD1E
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Oct 2025 19:01:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 420F019C7933
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Oct 2025 18:01:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11E66311C15;
	Mon, 27 Oct 2025 18:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NjRWcGor"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C7EB195FE8
	for <linux-kselftest@vger.kernel.org>; Mon, 27 Oct 2025 18:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761588073; cv=none; b=PAboEItNgCFJdwi7ENqG4ZX0MT36T84CG6jV3NAPLTk/ysSYJvdSNg9SvKMkT1bf9QUUHa3Kbdmlf0bIKaPugHr1NfwbOJCc9+25Ndwm3JzZJKT/Gl7NxkDXhHG/zIfkzwGGGVug+5D1PpTDY0EHaCcFNA5oIVRf9DEbE/u2loI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761588073; c=relaxed/simple;
	bh=dSzQwak3RBPC5y51ILTWEaSZmq/yqlFp0KvonW5s3MA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DLjrPjfGWz62OmeGzwTOUCL+AuJrQDQAl1mrEI/ckGrkC7XErzC3cEV3J7rVYS/t6P1D7GBv3Y4U7oubyaoac4beSWnNNBlqft4B2xjnzVDvU9kaLxkEXDXDTiMmhx/x6sSBNlSwmkRAL8u0CiMJWUSmwYUv4uMsQ/rWz5cCvaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NjRWcGor; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-71d60157747so47988017b3.0
        for <linux-kselftest@vger.kernel.org>; Mon, 27 Oct 2025 11:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761588070; x=1762192870; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OKDbmV9YEl1euYCGiiSOHAmi228vgH4DcrXIQXAImEM=;
        b=NjRWcGorYJ2t1TNHCJoSB0Z0ydloHtrfZ06gOJt1tG+ON1eWeTZo3TtgHGBK+DwJQa
         XUseEvwA9GsRWU5z/VR78PiXJStbuGjjPDQ+ClGtuCMdkwiGiZq4wH44Dt2dS+52D4E0
         bx141hMG7Qn87LKrn9WOMEI3gis6Zk7TBaBa8oI84quy1T6VEUcz3Q20z7zZjQMq2kZI
         NJC0rrGZ7l5kIGd2bSI9ydoA8Ll0+ZX/eQSJwyBLrKe+gMHlsBE74syQxM8T2EWJ0GQ4
         j6gENU6VPCZkiyHO7TcfziL9n/x1TIaVI1jZi8KvqoQMF1FADchbAssaAXQaxF9UiQDj
         Ko5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761588070; x=1762192870;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OKDbmV9YEl1euYCGiiSOHAmi228vgH4DcrXIQXAImEM=;
        b=QwDhJ+HUK4SP21mYiU7HnD16DzLQA5scyWE3KZ0ab4UCXAEKJOihgdhKMsXLvRtwFg
         VIW7QdxtsIQf8fvA0oNCpTEpxOYfHt2m7H7JDkdS41yYB98wLCQc60g+nb1QvW+ph0AF
         Gvq/Ti1jbAZZqI9w/noBEwNiwtit5wxMmBLBsBb4cAoCPeMwa+gLj9oVE+iQgL6/fFr4
         wFD3wKOD2fvzm4XVt2E5Al1mwx0nLp8qaXgoMiRS9ENAe5pRGyV7LJUFSEeiP9/vR9f4
         H2mzf7bZDiKz+8izRybuKdIh8A8VU68nS2StrsHSlPycyttzlo2OscpM+C9b7Nskr+sE
         lSKQ==
X-Forwarded-Encrypted: i=1; AJvYcCXnMD1vPsRXkgShGuR0Ux1usK85PBaNi+STqC0oy+m+cJNRiRYoNShGV65zXDoErtqWbgt6WzLQsn/DNG+rB2o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRDEi2V8VZtKkf9DKOuYxATszOHnsTr7Cqk3jnp02N7TUA9zrt
	n5yzlv1crqah/om2dqhxlHiCrKxv+F9FgOnwbqrkKj//XWEAicwUtibz
X-Gm-Gg: ASbGncs6OR7QPdULBFiFiAUuCHnYJEoPvY1CEZhGSMNV6K3JS4O0moiVBLrami5Tikn
	zz91x/4VkKEEQy0hpzEgD4yoFvPVYHyQ6nmBg8xHGAutNEjPYOEG54DkUL57ulvqtzYrJT2IPPW
	K4egcnJTrKp4A/koFf/qco2e41lnlhGhtwrfIKxUezSVH5UEmv7VhXXI3CfuFHBz62Uvcgzpk3Q
	PuzBXf+0pX/9cMM9Hz9aQDTGAgu7TlUTn0HcXUpHZSVYeWKrT/NdJb+wJUJ1XzlezLrE6Vi1UIs
	r7hSbabJb9M0fxecYA3LajXP8MPpfeWeFtX1QsV8mgSKz5UqHmyLtC1CGPojzeG4Vbk+Y49QlFp
	lmP//wd9rJqVoFQa4Kwrt5xEpF/CTy2JJd2ymrI/I/rzwvmjGmumzyf3mgjl1nnhcRXOnuuOdGA
	YWoiOuMTlxBpvWj/V2i6RxHZ39NsZc5tAqRRWComsfuO2qjYs=
X-Google-Smtp-Source: AGHT+IFWDCi2g1kdSTmc4R6F+QSoxN+p5e395OCPC0UeHMIqjdYpQhTxQQ2O31gfhQCi3Ezja/+T9A==
X-Received: by 2002:a05:690c:4d4a:b0:76f:8f07:4908 with SMTP id 00721157ae682-78617ea3e56mr6919087b3.27.1761588070172;
        Mon, 27 Oct 2025 11:01:10 -0700 (PDT)
Received: from devvm11784.nha0.facebook.com ([2a03:2880:25ff:5d::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-785ed1b24e7sm20674147b3.35.2025.10.27.11.01.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 11:01:09 -0700 (PDT)
Date: Mon, 27 Oct 2025 11:01:08 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Simon Horman <horms@kernel.org>
Cc: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, virtualization@lists.linux.dev,
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next 04/12] selftests/vsock: avoid multi-VM pidfile
 collisions with QEMU
Message-ID: <aP+zZMtf7FwwmqVF@devvm11784.nha0.facebook.com>
References: <20251022-vsock-selftests-fixes-and-improvements-v1-0-edeb179d6463@meta.com>
 <20251022-vsock-selftests-fixes-and-improvements-v1-4-edeb179d6463@meta.com>
 <aP-keSURBFPZvNA_@horms.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aP-keSURBFPZvNA_@horms.kernel.org>

On Mon, Oct 27, 2025 at 04:57:29PM +0000, Simon Horman wrote:
> On Wed, Oct 22, 2025 at 06:00:08PM -0700, Bobby Eshleman wrote:
> > From: Bobby Eshleman <bobbyeshleman@meta.com>
> > 
> > Change QEMU to use generated pidfile names instead of just a single
> > globally-defined pidfile. This allows multiple QEMU instances to
> > co-exist with different pidfiles. This is required for future tests that
> > use multiple VMs to check for CID collissions.
> > 
> > Additionally, this also places the burden of killing the QEMU process
> > and cleaning up the pidfile on the caller of vm_start(). To help with
> > this, a function terminate_pidfiles() is introduced that callers use to
> > perform the cleanup. The terminate_pidfiles() function supports multiple
> > pidfile removals because future patches will need to process two
> > pidfiles at a time.
> 
> It seems that this will no longer cleanup, via a trap, if
> there is an early exit. Is that intentional?
> 

Yes, intentional. We're trusting the vm_start() caller to do any cleanup
now. The assumption being that with no "set -e", vm_start() should be
able to return to the caller.

If that seems too bold, we could add some function like create_pidfile()
that generates the pidfiles and registers them into an array that is
cleaned up via trap.

> This patch also changes the handling of QEMU_OPTS. I think
> that should be mentioned in the commit message too.
> 

Sounds good.

Best,
Bobby

