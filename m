Return-Path: <linux-kselftest+bounces-42262-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CA499B9C5AB
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Sep 2025 00:27:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8477A4E1ACC
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Sep 2025 22:27:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B9D228D8DA;
	Wed, 24 Sep 2025 22:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FFlQdmEP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FCFD2405E8
	for <linux-kselftest@vger.kernel.org>; Wed, 24 Sep 2025 22:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758752824; cv=none; b=FZxMrvfYVrrkiJXRxX7oh+G6e0NbRQDtgs5qM2ApiGc7r0j+ZYsvM1n42cIPQ6RnlPIaSKmpU1LoK+LzAXRywznYdy7S3RiLP2AbhtMwIRRnOrzhu0xssaAO5So2p6CND4Z8SMW9rGRWTLj7/5Frw/cARtGchPTaAQIASvckZTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758752824; c=relaxed/simple;
	bh=VBgnju5e4OGNDrwtbMk9Nb6KcJuq+2o3nUneOsF+4fw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bUpc6hBP9NOo5IkLuWXDGIswCC1xqt2lUtCPoHZcnBjwar5/5YKuP02PHtDTwiaGSDFdK8vbGGf9hV6aJKzkF25rhLMToYt/SJlEnrmQ9pPvpZMpyEUOtFCP2wuxFU2ZYTio1GmBUiyUotZbXf2fH9QdPLetv06NT/6u/LucX3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FFlQdmEP; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-46cb53c5900so3019965e9.3
        for <linux-kselftest@vger.kernel.org>; Wed, 24 Sep 2025 15:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758752821; x=1759357621; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RAAiZ98FjXDGSsUxI+RC9o7W9RElQFrnGJPJA6Tg5jI=;
        b=FFlQdmEP3zBA0Ig3cLBs7dzAnj+LRMDffmWFS9e+1++lQOQ8gaQ/JmInO4DYdvMdWF
         l75JBo+adWKZGyG3yeU0iPBcknHBorfn+QB+xrt3JQkArTFB3LTaKZ/+9A00tLHlF2Dt
         uEaaga4oiwyA/S+QerDBQyfNMm85MTD1LAeR6m/rkD3Fy4oG8aGrfvSAHCqMNSVX3Mxk
         fWC253OvXLA2RwVW7/wYfXdNDgf1Iup5Om4QSEs+hNPkJMBxFk2Z2l3vsVLLHYyHkOSB
         KqBKr4dbDSVdHaHH605UiEmx5IZ2JUqwdJBDnsleQI6jQWdLE+jpUFV6FHyNrY43o595
         Gnrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758752821; x=1759357621;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RAAiZ98FjXDGSsUxI+RC9o7W9RElQFrnGJPJA6Tg5jI=;
        b=S1RXnejX6KiAEQ25ibpxbp5Qy9dVzTEYy5SxSt+q6nebL/71jLBh5MUcrXaa7mKkK/
         h2Q89aR/jGBRhEw9qIg+AQ/i/wdplE0d+CnbKDrfYMCdaNE6fWaRot9dW9wMupEQZ6Oz
         eW7I+0CqQEznPy9W3I84+8eFlB/2J3A/C2V/oYmkPYuSlQJWzPuDcdSJEkHXJjgpUGLo
         LZ/eUpKbiDGpHLbSF0fPAAfxCWOhATZe+2oLfrMTkPOp90t00PmjSJ5gBxBG+c3XZw8q
         EcBN+dIR3tJ04ITMEvKfHGlKTKmSTb5HVfw74N69mXTMUsggZQfd4rMOyFMs01kfP+tq
         IaHQ==
X-Forwarded-Encrypted: i=1; AJvYcCUJa0l1OlO6jmvVD+w7YUqY8S5WNqethCoyqFlzvjlUW8HEGOvpyv6nDT8EPy/iCIyTAd+ep5+KQATnAO5ck0E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPbufQSFT/5PgUZMjwBDHZnIPsncOJdWpEupUjobfxD6ca0XZH
	z79MtXRa80nz3g3RjWsdLACUcxkgh2w7b23m7HoXZMB3EYJxSwmVN85r
X-Gm-Gg: ASbGnctH7FTPcpNv9Woh0S+JfqPcZYPZm3xXRWa2kAYTgydnPgWiJFfWQomUWuOSRPB
	FvaVfzpa4illvbqEu1e6PLNpsH6q6HolEhKRJBr2fEdiocAqRuKQI4u+/0PcM3Apvtq+sZVikzZ
	Msss+TklgTLc6DmJnZ506misqAsxmW2ikftC08jyUOnycy+CuPGE0wbj80j2aiJtgKfL0uw8R89
	2RU8Colb8znWNV1xHRx3VKr7TEib0o2z81z9AUzi03uyXZN1HE0gdavI/qvmP5K3zFjzROys0kb
	mxlFSviH4+eQhl8wLxFVWmGkaVh1jHmzQRgn0HB0uYGM1lKslPmO+aWwBr6GLnP9LCRzT9PSe1G
	Kpti915p1enrI51HOspk=
X-Google-Smtp-Source: AGHT+IG6jyPPpkk8a3aExxGzaFJF8Lv9aP1QB30cWerzfjmW8E0fi6FRCuWa4wt/CAF/bg53qAh34g==
X-Received: by 2002:a05:600c:4187:b0:45b:6b57:5308 with SMTP id 5b1f17b1804b1-46e329a82efmr8699815e9.7.1758752820646;
        Wed, 24 Sep 2025 15:27:00 -0700 (PDT)
Received: from archlinux ([143.58.192.81])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e33be21casm2735405e9.2.2025.09.24.15.26.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 15:26:59 -0700 (PDT)
Date: Wed, 24 Sep 2025 23:26:58 +0100
From: Andre Carvalho <asantostc@gmail.com>
To: Breno Leitao <leitao@debian.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v2 5/6] netconsole: resume previously
 deactivated target
Message-ID: <dafma6drqvct4wlzcujoysnvjnk6c4ptib4tdtuqt73fcuc5op@efjjn5ajqwts>
References: <20250921-netcons-retrigger-v2-0-a0e84006237f@gmail.com>
 <20250921-netcons-retrigger-v2-5-a0e84006237f@gmail.com>
 <t32t7uopvipphrbo7zsnkbayhpj5vgogfcagkt5sumknchmsia@n6znkrsulm4p>
 <4evp3lo4rg7lh2qs6gunocnk5xlx6iayruhb6eoolmah6qu3fp@bwwr3sf5tnno>
 <aukchuzsfvztulvy4ibpfsw7srpbqm635e24azpcvnlgpmqxjm@e4mm3xoyvnu7>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aukchuzsfvztulvy4ibpfsw7srpbqm635e24azpcvnlgpmqxjm@e4mm3xoyvnu7>

Hi Breno,

On Wed, Sep 24, 2025 at 01:26:16AM -0700, Breno Leitao wrote:
> The other option is to always populate the mac during netpoll setup and
> then always resume based on mac. This seems a more precise resume.
>
> In this case, if the device goes to DEACTIVATED, then np.dev_mac will be
> populated, and you only compare it to check if you want to resume it.

This sounds good to me. I've done some initial testing patching __netpoll_setup
to always set np->dev_mac, changing maybe_resume_target to simply compare the
mac as you suggested and seems like this approach works. 

I'll do more testing and analysis to see if I see any issue with the approach. 
If all goes well, I can include these changes in v3. I'll report back in case I
find any problems.

