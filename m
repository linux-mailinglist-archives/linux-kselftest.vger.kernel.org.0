Return-Path: <linux-kselftest+bounces-35252-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA282ADE4E5
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Jun 2025 09:53:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2106C1895423
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Jun 2025 07:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31B7425B687;
	Wed, 18 Jun 2025 07:53:00 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A9E7E105;
	Wed, 18 Jun 2025 07:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750233180; cv=none; b=A+/ydjmCjheJUPXsCYtg/U5TV0m7hSyPheIqFaEqw26wXaKRaptuEj2FKP72d49A+k+hiOjMzyJI0/WrnXYXR4HFtsfEnY13DCcpTbHuIHD9RJzgd+TNpl6b7cKw95s7FfKryDjC53rEM6IuEx4JLVw7dVDA1hGoFQfC0IZVyQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750233180; c=relaxed/simple;
	bh=BhDhfB0EHERvmRjIgnoNbnxG/iyNgwscUl+OqQOwjz8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dIwgdnHgSBD1hn4vznNCsX0Nm5mIVyjY91Gv6Xuzy7mdSz0mI0L7JDOGoG+729xzUowsK4bqVUVPwnDsVQmdVtHFe+fG2MgoD4GZf1IBWcm660wRSqr/ueGjUwU4fD4ErIQH2cIz2Hb49+h5bAaF1kYp56QXEG8CVeRjozXOxp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6097de2852aso3139988a12.0;
        Wed, 18 Jun 2025 00:52:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750233177; x=1750837977;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JYPJwRlvGFyO8GmZ8lgMNLMh8RXy2GtDgrAPOS61rlg=;
        b=nE8oJnoj1d3bZpKIDZCRE+dTx1RYJ0Wo/Q/T+1Oi5X+pwvMIE+RSkTRZy14ceur9rU
         iGx8T+h5rdp5ZbgcrWJ2uvKQ6cogA17roQnBQPuhquF2mGaVbic5/dt08jCLD9KzFstd
         pbIZsmMOjwonr5dk8Nrn7OYY8+4B/0y3hAlAeKPTBmhnb8qgYmQJFPQW0SwlQmUjuea+
         wuwJuCkxohI2lxEoMq9CfKUpFviHPDJmPPEytereXcabAZGDJHx1Xb9Kkd/b8n/5BbdN
         2uwZzWIhQO2AHKNA2Xg9VpxxyYYUjgPoLJh//xAvQq7+lusFD9tCw2nOdR+QKnAjfPIg
         Qi4g==
X-Forwarded-Encrypted: i=1; AJvYcCU1L01hqa5KzIIT3bn7RSRDPGprTnRX9bOYqvOA387vuR6Jct/SfKvjW5spPyolvJJ9C3svhxtIcCzV60viViT6@vger.kernel.org, AJvYcCUjoXWUW2qz+PXjBi2m+HoDXtRxxdFIHIdZOamjBNFzym3+G5QluzLNXePsUwl7SPd1nVIhGdFc6XctzBOw@vger.kernel.org, AJvYcCVdtIvnKjH32VlRI61BwDuQnt8l29XkMPnJbiehLrIzpvg+mcyHQsZ2aD3AcldoBBsY6xn9PTx1@vger.kernel.org, AJvYcCWNyUs9/0kzJ3sHiEd6ehlf57O7L5jxu6qGkdMOYXyWfr9T5mTS99FBWUQyQgqDQBiQGMK39Qbr4aE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxozW6uBzC69s5H0wLqqCRhanDDvYsxCWja8M3W21leJar/gz1Y
	IzBCGHOc2x4TlCxtreZEPbRCL9RZ9vos1Jhtx8Gn6BqAgYGumXAZ+WWNuhXrFg==
X-Gm-Gg: ASbGnctj5ELT+jFhtP18A4Sg9vVdcCOoG3OJw5JSrQlTW1oT4k6fM3sRofs84hSQOLr
	3GxSB9FdRg97AQ+fk9jBCA77fIiv2tnXkZgKwga67yd73iEZwgRdVMs327AIgpxckV4pQoKlxpi
	7NHbDM/oiD0BGibn66ZNLAqxjt7ySLiI6AFtPKxMZWSG3unMRA5gt4i7XGjV2crugqyu474vcWc
	mjPavfjIdC00suL5tidYHVDfXWE0oX3xU6+2tQnTMIH0SLTr4OlQajxu+BrxHz3u3Ex7a1BMP5S
	YmRGVnIFzJq3aBLjtbJvq7QO8u8mOpQ8h/7HQxRB5a62ZFnI8rKSZQ==
X-Google-Smtp-Source: AGHT+IFquzN0jTq3aWguPML5Ppdg3RWLEm95IqKfqZSkaLBrv73foyJdfdkjasK9HTDWDamdeHShmQ==
X-Received: by 2002:a17:906:6a0a:b0:ad5:372d:87e3 with SMTP id a640c23a62f3a-adfad36811fmr1515638366b.27.1750233176393;
        Wed, 18 Jun 2025 00:52:56 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:74::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-adec88ff06fsm1010988966b.102.2025.06.18.00.52.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 00:52:55 -0700 (PDT)
Date: Wed, 18 Jun 2025 00:52:53 -0700
From: Breno Leitao <leitao@debian.org>
To: Gustavo Luiz Duarte <gustavold@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH net-next v3 4/5] selftests: netconsole: Add tests for
 'msgid' feature in sysdata
Message-ID: <aFJwVXOwl0WRG3JZ@gmail.com>
References: <20250616-netconsole-msgid-v3-0-4d2610577571@gmail.com>
 <20250616-netconsole-msgid-v3-4-4d2610577571@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250616-netconsole-msgid-v3-4-4d2610577571@gmail.com>

On Mon, Jun 16, 2025 at 10:08:38AM -0700, Gustavo Luiz Duarte wrote:
> Extend the self-tests to cover the 'msgid' feature in sysdata.
> 
> Verify that msgid is appended to the message when the feature is enabled
> and that it is not appended when the feature is disabled.
> 
> Signed-off-by: Gustavo Luiz Duarte <gustavold@gmail.com>

Reviewed-by: Breno Leitao <leitao@debian.org>

