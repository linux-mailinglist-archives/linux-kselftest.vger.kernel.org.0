Return-Path: <linux-kselftest+bounces-35253-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4970ADE504
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Jun 2025 09:56:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94235179B45
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Jun 2025 07:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAA4627EFE8;
	Wed, 18 Jun 2025 07:56:41 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19FD027E071;
	Wed, 18 Jun 2025 07:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750233401; cv=none; b=McxygCEgp7X65jFSGyuXzndOVSKleoTC1cIVR4cHsPKYQ9gyBQiLQ3ycfYhf6EXmo9dqIZGievR+ZuoN6JfWJl0JwDeTLHEWOwOM1/prSzYcS0psANeHrvoSiK9kOR7G8SDLAYBeWEkfE+T0ZJ5opP1bVbaxYL90CYChLNq0Xdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750233401; c=relaxed/simple;
	bh=Bf099CFhMfpv3aG/dn02iN3VROCJPnC68ni3QLJgbnk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GdbynmkaQ2CIOMDbaRVdhEPFwCrf2wG8QUfIRj5ZjuAjFPt7VSKNGTfyP4SCYWYjh+v6fyQ42hlJhfBuJAE6CzL95ZELf9dNoTqeeql23SjVclTmJZB/ygQPVxY4xtc5MdB3VlM0W2+h3ozJbjAGI0l32ICAK24yjHMhwIq81p4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-addda47ebeaso1340363666b.1;
        Wed, 18 Jun 2025 00:56:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750233397; x=1750838197;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4UjBMk0LF0uUVft57uPM9nnGKNcd7U7chX18TbiWgGo=;
        b=OmYuvSgUHDCnRqhBFwN4B7fJWiwxjFKnRn6EcRF6u22Z+CDN2vzBWpSanOz5eKvsmk
         h6wMXG7Fc2dMVVaQvooSc+4uga2zRVPR2U41zMaz+bFhC7lohqZvXgzCqaOUVTRsAkFK
         oa0ZniF/16M69HWs85LGk2qRT2/gi584GKFD6ncEZkzeYQeViOy7DY9n+mYWt08vP64H
         C7KbzbDb3Sy1p7GsBP0/FGMUIzOI1Z2s7/0uu7zB+KX1+c1etH0qkocm9vS4S6cRKCJT
         oHwDNHLvJXTa4KRdynMrHAf8ziEze8SSCTI8+t5+gEwUNHgpQbNrpRRPnCjk8yByKJf2
         ajDQ==
X-Forwarded-Encrypted: i=1; AJvYcCUnEFCpUzhyD4ZyqQzpX4lPR7wlJHej2JRNbUPsJDOYrfFmNSeiO5YrDE5SzPjoNUYXDXhpLoLbbBc=@vger.kernel.org, AJvYcCW24y83ESEyh/f3N/vcDbaxmQur9d8pkO/GRzyAJYj1Tpa0OYYyQ86cV5JGhk1l83epWbLJfGbfJT4AT09Va9QO@vger.kernel.org, AJvYcCXGeKMe0sYpoCwiGVt9kUud9VKetEzAEmgSSAzDqXtx3LKva/5ZqgUqwMZk2K5hnnNAgKaz77yj@vger.kernel.org, AJvYcCXM8VbexYHo/82SOFvvpI1UdwXmtOTm8Ql0fLufB5n+HHMhMCuPyiRj9rFmYKoUVdxpuKtiGUhrJdjme6NT@vger.kernel.org
X-Gm-Message-State: AOJu0YxsATOmNWAPT4Fn2PH2RESQZKqdi+21V1tV54S75WyMlrYmHOtJ
	cIfJGsK7OUi9uWjGsQf1hzNPH/4awVTJnPrfUyzt61gG6ArwyipDKOFM
X-Gm-Gg: ASbGncuVqxkHXQBorwj+q2hu3vfDPiepNLXmlJSOKBc3b5FitMzQ2e1oH/eb8XrJh99
	qyleclEP4tqavoDZuKduF9cpuKdV7M4zMRI859M2TNZe0/CCYa5oCNK0aHAtIfwtpIbJH8Cl4+u
	c1wQ+5sqtsOlj9au/Gjs6x/RLmIokN6WydO9xFzeQZ7n03KlQMgveGJpvoBj+P74PbKg9mgfyWq
	lxxBzFvcIKSx6c7VkxF66QBTQ7qme6PcGxv1LxsfMsS623Uw/Qx4GxgnO9Ie1szOqRi3eNrKpVL
	3qAf7gJO7r/6siZWlMb3xVcgI7M0zqWTOxOqk7WyVLXfO1j6svWQmQ==
X-Google-Smtp-Source: AGHT+IFyXJhy8J1yET5nRJVLQ3OTObKlxUd+dALG+dYmVN96XwXu59sC/dvsET1bk3OvVk5TJbrBXg==
X-Received: by 2002:a17:907:3e93:b0:add:ede0:b9d2 with SMTP id a640c23a62f3a-adfad4ebec5mr1424772266b.44.1750233397009;
        Wed, 18 Jun 2025 00:56:37 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:74::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-adec88ff203sm1000120866b.75.2025.06.18.00.56.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 00:56:36 -0700 (PDT)
Date: Wed, 18 Jun 2025 00:56:34 -0700
From: Breno Leitao <leitao@debian.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Gustavo Luiz Duarte <gustavold@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH net-next v3 0/5] netconsole: Add support for msgid in
 sysdata
Message-ID: <aFJxMne9qzk99sBj@gmail.com>
References: <20250616-netconsole-msgid-v3-0-4d2610577571@gmail.com>
 <20250617184217.63c068f2@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250617184217.63c068f2@kernel.org>

Hello Jakub,

On Tue, Jun 17, 2025 at 06:42:17PM -0700, Jakub Kicinski wrote:
> On Mon, 16 Jun 2025 10:08:34 -0700 Gustavo Luiz Duarte wrote:
> > This patch series introduces a new feature to netconsole which allows
> > appending a message ID to the userdata dictionary.
> > 
> > If the msgid feature is enabled, the message ID is built from a per-target 32
> > bit counter that is incremented and appended to every message sent to the target.
> 
> Breno, could you review the last 3 patches? 

Sorry, yes. They all look good.

Feel free to merge them.

Thanks!
--breno

