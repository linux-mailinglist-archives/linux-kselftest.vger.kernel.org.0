Return-Path: <linux-kselftest+bounces-3764-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD39D842D18
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Jan 2024 20:40:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C25B1F23587
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Jan 2024 19:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B264E7B3EC;
	Tue, 30 Jan 2024 19:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J61BwlvG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 323B37B3F6
	for <linux-kselftest@vger.kernel.org>; Tue, 30 Jan 2024 19:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706643652; cv=none; b=dgIF3mMVe4+ibvr8Bw/Zb71olXPIwkI1OpTcs/P/5zsnJ3b4EOSRttZwlyWjEeCbyEsbLnwD6ZUGir/XC66EOaTEnho4W6F1WojlitiU1NvqZegAEOv2CVbuTco/NZhhjH7ibPAeZ4L8+PRlcUJlA0itLRAOL8ltkXeFkESLMAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706643652; c=relaxed/simple;
	bh=iuTRs8pD5zQvTzuzah4xY/tENHEshzjnd6mwrqX22ng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lQkIlja8ug/eXeJJU889M6K8pFWtno4EcBnyb0su7QcteoMqwgnNnV6utuB2OJX8BJbxK7uiVk8tluJNYo20te+P/NdOB2kqLUX2TypscK/3SM5fjwXCDrhp5zCs3Av1X27B4LhZ+nxQywPdG1P0lGyX9n5Q5E9NLGY2Z24Y1rA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J61BwlvG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706643650;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vpJuEz0EuPaTrjfYgpnpRcO5lXRj3M+OefQiLWQnELc=;
	b=J61BwlvGx2TBJRgPw0XP3sujUCgMDkU7cj8D3oVi8eXCtefEuZktlnyD01GVhCklsD4omt
	ZiVMd1U+P7AZ/KsWKoHsvM8hB5lKn6V3YbObJw+hey7oUGRCfo5zPB1NAdIpT4khgpxV0Q
	c4luzb9/LpqHzZqQaNdkDEFHK7kTBxs=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-673-0XwH3GSFMyemAUA7-fuZWg-1; Tue, 30 Jan 2024 14:40:48 -0500
X-MC-Unique: 0XwH3GSFMyemAUA7-fuZWg-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-33af5879edfso819877f8f.2
        for <linux-kselftest@vger.kernel.org>; Tue, 30 Jan 2024 11:40:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706643647; x=1707248447;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vpJuEz0EuPaTrjfYgpnpRcO5lXRj3M+OefQiLWQnELc=;
        b=QkFKSAv70fRBy5JkweT1/W4gwP0RczgL0MihWBz246BT7TOxKh6HHSq9uiL2cuW2zt
         NXMl7YhzTuFxmL9TollLwNgIAjqbcJNaRm1F+ykNC7D6HZOHJGhBrW+rl/FmBBpuLJ8D
         TqPMCIayugTAAIhz+AWw6ELKYkUP3gjvjKiT+jVPIf+uw1Dnbvx2VPw5lCPbq5f9D/k1
         649UzqDUFfOGy6V/EAl0ougssqo+HCmsXb4ZWhikRgOrlj0xIvhSJdHJiq0POt/3rRf+
         ful4dWeznzy4Ah8YP6a/0DwAgI20RRT3fL2oS0jsxVj/zyfPwsojBeBcw+i+aORLhFho
         VSyg==
X-Gm-Message-State: AOJu0YyFND+H9NHt6OKe4h9XIL2RxYzWOiryQmy3Yt7VEkDAESx26Woe
	oq7x/MpdRjoqfh5pw9zXdBbtf781PUh9XJfmPhbt+XIHwZeHQWDb+B05YhNC8Phw8mlMnf4rNP8
	Rscxewida6DyaVlSLbtyZKow3F9y64jiE3GXdD5aMH8tGl3QVnKdYHJBZJneZRHUlug==
X-Received: by 2002:adf:ec8a:0:b0:33a:ea28:2bd4 with SMTP id z10-20020adfec8a000000b0033aea282bd4mr6260241wrn.4.1706643647507;
        Tue, 30 Jan 2024 11:40:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEF3t0vfnDSip2D0CHJlu2h4X4lIQQd+XkEWV/wTjfSUDh9ZS8uuhJAP+QPbw4Zo3obl8jyBg==
X-Received: by 2002:adf:ec8a:0:b0:33a:ea28:2bd4 with SMTP id z10-20020adfec8a000000b0033aea282bd4mr6260230wrn.4.1706643647255;
        Tue, 30 Jan 2024 11:40:47 -0800 (PST)
Received: from debian (2a01cb058d23d60036688fbd67b19d62.ipv6.abo.wanadoo.fr. [2a01:cb05:8d23:d600:3668:8fbd:67b1:9d62])
        by smtp.gmail.com with ESMTPSA id bh2-20020a05600005c200b0033afd34781asm1797370wrb.75.2024.01.30.11.40.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 11:40:46 -0800 (PST)
Date: Tue, 30 Jan 2024 20:40:45 +0100
From: Guillaume Nault <gnault@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Shuah Khan <shuah@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Florian Westphal <fw@strlen.de>, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net 3/3] selftests: net: don't access /dev/stdout in
 pmtu.sh
Message-ID: <ZblQvSCgTSs6FfQU@debian>
References: <cover.1706635101.git.pabeni@redhat.com>
 <23d7592c5d77d75cff9b34f15c227f92e911c2ae.1706635101.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <23d7592c5d77d75cff9b34f15c227f92e911c2ae.1706635101.git.pabeni@redhat.com>

On Tue, Jan 30, 2024 at 06:47:18PM +0100, Paolo Abeni wrote:
> When running the pmtu.sh via the kselftest infra, accessing
> /dev/stdout gives unexpected results:
>   # dd: failed to open '/dev/stdout': Device or resource busy
>   # TEST: IPv4, bridged vxlan4: PMTU exceptions                         [FAIL]
> 
> Let dd use directly the standard output to fix the above:
>   # TEST: IPv4, bridged vxlan4: PMTU exceptions - nexthop objects       [ OK ]
> 

Reviewed-by: Guillaume Nault <gnault@redhat.com>


