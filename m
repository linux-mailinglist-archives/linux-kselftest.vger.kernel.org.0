Return-Path: <linux-kselftest+bounces-3762-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8D16842CC7
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Jan 2024 20:30:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70B6B1F2655C
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Jan 2024 19:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E9397B3E9;
	Tue, 30 Jan 2024 19:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MYpq0ciS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A60B17B3D1
	for <linux-kselftest@vger.kernel.org>; Tue, 30 Jan 2024 19:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706643050; cv=none; b=rMfymumosmJy1akla9oIUpuIZl8RT1XLIvgkjswSV3kRvgua8DXlni14SJcdU/duSytsr532k/mio4ochp34y8nq2LHpcx8XR4267K9orO28hp0T/Bb/LDEhFeMttqRrag/en4hwiPNavcNiBAqpHESxE9uecb7UsIXGs16QBXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706643050; c=relaxed/simple;
	bh=MQApjYNzzqyTT2nYNKJ4oPe2xM02HP6SjNySa8/tJoo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WemB82pSEAnrFeBW7osJJgSBKpcU1Jck8t0otiRe7fFvWcowOFpGYJO98jSDDagROvsYbJdQrl04bjWxUCL8+36NeGTjW3PiIulzYhm9Vopnq2LxbMjn+xc/ugp8VLaPxq2PUX+eGTZ+NQGjm9Wv+46WsAgGxl0gQdbRCZG/qf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MYpq0ciS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706643046;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0ZwHIots52ZYL3YqcDDRzCxkz5l/w2pVJRjR0WqNjxY=;
	b=MYpq0ciSuQ2h6FIAFbXbHGbURXccU799esBpsAnRxpI0wmZ0QUPy6SOJ6sdRhbhXJxZs4g
	qmhoM2AqUHhn++MWdWF5+V0WAcqZPIHrCz0cfQ8BdC6x8YuGYKBod0HB+9Fx0JsyF+Cm8T
	gNmJ16IE+Up0leMxCyBazDK620f5dIY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-ndhAm-aTMFqr_Ka7v7EX8Q-1; Tue, 30 Jan 2024 14:30:44 -0500
X-MC-Unique: ndhAm-aTMFqr_Ka7v7EX8Q-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-40e435a606aso27691895e9.3
        for <linux-kselftest@vger.kernel.org>; Tue, 30 Jan 2024 11:30:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706643043; x=1707247843;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0ZwHIots52ZYL3YqcDDRzCxkz5l/w2pVJRjR0WqNjxY=;
        b=I8EZQR/tQrQJec3dzQ/SEY5iQqACTVNBgi+ASMGz8RGU+itHzilnxyAHr7ylEOF3/H
         peX28ooLNhuRjhR1k/IibnjvUi0oUsOalAahircPj1ANbmWjOSRInkW4XY6fS+E6d5uT
         ceWhKG4dT7ZTIkc6of5l6kmqDuhCYCmUgWHF0DoBi2SN0hvaNGSPZxqaQRmitLayOXLr
         z6kgFqY0AL1PjL9A2Q6A9De9EhsCEDoUa/hIE+GrUVTGPOeyVmmMqbuxnB1lnYNL76CN
         cbTfna83GTJlhyWVgvLIUZ0EmqYjHzm73WRlPEK9kJGJbv9qxlU7BcB0Md2pMVfpSqmy
         sCmw==
X-Gm-Message-State: AOJu0YwCBdF8R3sd9jgzbZFdRRZXrvf+BG+kLbk2VehIeUDV7rzeZRlu
	EQ/YONSeibtwKdr4TzoKiEWcyIusMKNBwMANHwOUjL3VkaqRENwQtZQtYR/PAxNamqCHQYO90MK
	gLW/18F4j/N1mwSP27PxLa408V40mfxvbYVbpc3git6k6edJZE+8LJoxGad6jAEv0NA==
X-Received: by 2002:a05:600c:1d0b:b0:40e:f111:f259 with SMTP id l11-20020a05600c1d0b00b0040ef111f259mr6874033wms.37.1706643043601;
        Tue, 30 Jan 2024 11:30:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFZ6rHSJ+UUtgSwFDXL1/Kd+JpDr01pM6qU7HUzLglzsZuSAelbNp80UuQLwuNT+5z2+xEg0A==
X-Received: by 2002:a05:600c:1d0b:b0:40e:f111:f259 with SMTP id l11-20020a05600c1d0b00b0040ef111f259mr6874026wms.37.1706643043312;
        Tue, 30 Jan 2024 11:30:43 -0800 (PST)
Received: from debian (2a01cb058d23d60036688fbd67b19d62.ipv6.abo.wanadoo.fr. [2a01:cb05:8d23:d600:3668:8fbd:67b1:9d62])
        by smtp.gmail.com with ESMTPSA id u16-20020a05600c19d000b0040e4733aecbsm13831493wmq.15.2024.01.30.11.30.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 11:30:42 -0800 (PST)
Date: Tue, 30 Jan 2024 20:30:40 +0100
From: Guillaume Nault <gnault@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Shuah Khan <shuah@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Florian Westphal <fw@strlen.de>, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net 1/3] selftests: net: add missing config for pmtu.sh
 tests
Message-ID: <ZblOYFvxZElGVl/W@debian>
References: <cover.1706635101.git.pabeni@redhat.com>
 <8d27bf6762a5c7b3acc457d6e6872c533040f9c1.1706635101.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8d27bf6762a5c7b3acc457d6e6872c533040f9c1.1706635101.git.pabeni@redhat.com>

On Tue, Jan 30, 2024 at 06:47:16PM +0100, Paolo Abeni wrote:
> The mentioned test uses a few Kconfig still missing the
> net config, add them.
> 
> Before:
>   # Error: Specified qdisc kind is unknown.
>   # Error: Specified qdisc kind is unknown.
>   # Error: Qdisc not classful.
>   # We have an error talking to the kernel
>   # Error: Qdisc not classful.
>   # We have an error talking to the kernel
>   #   policy_routing not supported
>   # TEST: ICMPv4 with DSCP and ECN: PMTU exceptions                     [SKIP]
> 
> After:
>   # TEST: ICMPv4 with DSCP and ECN: PMTU exceptions                     [ OK ]
> 

Reviewed-by: Guillaume Nault <gnault@redhat.com>


