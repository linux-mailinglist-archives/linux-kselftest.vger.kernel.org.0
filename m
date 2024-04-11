Return-Path: <linux-kselftest+bounces-7712-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6BB68A1B4E
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Apr 2024 19:27:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57A2A1F2177F
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Apr 2024 17:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CEEA7EEE3;
	Thu, 11 Apr 2024 16:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nSI5jQzd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B3E779B8E;
	Thu, 11 Apr 2024 16:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712851224; cv=none; b=Ij4+sQT1lUejkATpQ/qdEfyeH0eM34O7rVW2z5LlmK6QtP7mZRMOo6vrQGTtSoD6pV4ZjpU3gDETT02aHlmfx0OLDb6REymN/e/iIwgQiK03H5xqKktrSUnn4nGcqgnH6WGXEt4qFFlYdYQ7gLphsguW+yyrVPEIkyxV7xoTVjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712851224; c=relaxed/simple;
	bh=dXhrltalRw62K7XvGlgrj47pm8KOrn1wcWLhzBP8JSs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=JqPNADFIapYNEOtg7zKGGhYFocDTNvhiaj10koS2eDyJMXgfWYwu8oG4UxFrAwIyQp86EEsKwOOr8cRRIP+vZ8jq4V8kafIAzrlVLtAcsLo/cmlNLNpBTqdUfH4lN41PGC+TphtTSCAvdw4146CNAAfkBSPzkx8p+AwRBWj8SOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nSI5jQzd; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-41550858cabso64835e9.2;
        Thu, 11 Apr 2024 09:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712851221; x=1713456021; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to:subject
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r/wAtQmcm7RjskxIystx0q8y3lFVg7bjExxCxdXSxHg=;
        b=nSI5jQzdCqfxGS3rY5UuN8r//n9iAMAoRTHWQ/i+tqQiJMatmnlGXakGZ+WprZdJWK
         YsclRU/EkzeO0Rd+x4P90Z0ZaGqMC4u+3h6Gpb1ok8i7Rro4+Vj/oLghC/HcAlYPftNZ
         d1Byxjqd5n886srUQE9lr5yYpjwt6r5tVJZ/X4XUy6+FG1+RisnaCX8A9rcYjJnZRvTv
         dAHFl9QNgiOQBwCN7ssMnUrsCyVCj4JStQZvvUcRbJt/bqoDdyi8icKYekRqMcXlwSnq
         Nlvt7+6cWrhjVSY1ScgACP1iIU8tjTE9BshnKg5w4d93ASRoIy3F+6ucoufsTxeay8/v
         uiqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712851221; x=1713456021;
        h=content-transfer-encoding:in-reply-to:from:references:to:subject
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=r/wAtQmcm7RjskxIystx0q8y3lFVg7bjExxCxdXSxHg=;
        b=CwTXj/Kt4R39n7W1hDF+0jsZFAElYgHUlVo8SSJ7C81I9n2pe3v21pQHZk2L431mWn
         bnhTS2bEKoSWk61h6r/8QjiexI/Z1CFr8R8Qgok5lMEXtKhPETyv2FYm12Sd7l5Qe+Zr
         MtXh5v8pl2VEw/skyqE/XX2FOi3/tZKwHrJ5UMSRmhiiSPfLe1FeUNjiETxEWlYiU8vT
         w8kIbitbLDlUi14DWJaia5NgT9m4lWyu+PD3tJmS68Mfs5cvLU37V3b0VIGl3gp5JwyM
         P9PkLUnU892AjLskQ8+dDrBlb+GLGn5Z/k0V9v5SIILaeSn+TTASFkvxuECEJeo9wD0h
         IGeg==
X-Forwarded-Encrypted: i=1; AJvYcCWV24P/Qz3KuSlm+T7rS0gZFf4Yu52oUYLMEQV6/CWXRL/4ccvyqnU7LzpS3Zu07Iu5our7SsKLieMqHojnWdDLZ8vF48/1kIs0sK1luefzsB0YpWkWgjjH0rbTkxM6V8fxJfax7gTrTXlfeEGm9KSGGOEu2CyH/xKFfx//WdA/FRpzKk3j
X-Gm-Message-State: AOJu0YzjnRLoCwrNA9YlxoSOCSFeXgg2ZjpQDE+/jEp1qDg1KQztNdEt
	xpmyLt/Tafv+1KmSo2fj4Lp04g0/Fm52VauwGIn3Ab07x9wISTtS
X-Google-Smtp-Source: AGHT+IFIjozN+0Eh4skdyHP+pEB59g2kchQ0I/iku7FlI9TW9cy6qsLMFPLp/jU7nMA54TAA3FxFBQ==
X-Received: by 2002:a05:600c:45cc:b0:417:bc16:b8f1 with SMTP id s12-20020a05600c45cc00b00417bc16b8f1mr173706wmo.12.1712851221167;
        Thu, 11 Apr 2024 09:00:21 -0700 (PDT)
Received: from debian ([146.70.204.204])
        by smtp.gmail.com with ESMTPSA id p5-20020a05600c1d8500b00417e227f40bsm1603248wms.3.2024.04.11.09.00.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Apr 2024 09:00:20 -0700 (PDT)
Message-ID: <6c363e03-23e4-4ab2-b66a-aeb179cbacff@gmail.com>
Date: Thu, 11 Apr 2024 18:00:09 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v6 2/6] net: gro: add p_off param in
 *_gro_complete
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, shuah@kernel.org,
 dsahern@kernel.org, aduyck@mirantis.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20240410153423.107381-1-richardbgobert@gmail.com>
 <20240410153423.107381-3-richardbgobert@gmail.com>
 <6617493095ee1_2d6bc6294fc@willemb.c.googlers.com.notmuch>
 <66175ca5e3621_2dde6a2947c@willemb.c.googlers.com.notmuch>
From: Richard Gobert <richardbgobert@gmail.com>
In-Reply-To: <66175ca5e3621_2dde6a2947c@willemb.c.googlers.com.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Willem de Bruijn wrote:
> And the latter parse the network header for total_len/payload_len, to
> find their original offset.
> 
> It's also a bit of a hack. But a lot smaller patch, probably.


While producing a smaller change - this is a bit of a hacky code change.
My initial idea was to use network_offset added to the CB in the 4th commit
- making a very small change. (https://lore.kernel.org/netdev/446695cb-50b8-4187-bf11-63aedb6e9aed@gmail.com/)

Eric suggested it'd make more sense to pass it off as a parameter
throughout the complete chain.

