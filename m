Return-Path: <linux-kselftest+bounces-34299-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDEFFACDF73
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Jun 2025 15:41:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 559583A6BE1
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Jun 2025 13:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC27728FFD6;
	Wed,  4 Jun 2025 13:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l/3ojmF0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E0581C5D62;
	Wed,  4 Jun 2025 13:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749044447; cv=none; b=cuuh9PXHbf4/hcE8d7dA8pkMTpr2zTxKxjwunBxeH7AVDL9beqGVaw9TstDJrOeXMPfYbWb3ehfDodyRhSx4J5KziDmvssnCRWiMHwJflmUrWhhlX+G448Mz5/yolaFM7SKQBloGQ4IiJK9adIFWTgyFXgT15eCGhhmahPkiM44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749044447; c=relaxed/simple;
	bh=A/A/XRPZK2Ow/G52PCvJvLC3cGt06URNeJBNtQZj7TE=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=u1ng6DtmpmhWABQPhhe+tXkQ15lWMLxmnseFNtT5eJtGZHBIEmkWLovgv0Ofa2/nAkkUEIgosqbgela98ES/qqI/zMMEbjHReD5zCXZyIi3And/OErp/MEgCltQ+zLZn7Rktvc88y29wowS4YBTdcQntJajFgpFiitH7GGffWJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l/3ojmF0; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e817ac96e87so674135276.3;
        Wed, 04 Jun 2025 06:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749044445; x=1749649245; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V8M1w2wiiJxkH7le4VbH37yk9pxwXzzPAoNmR8z8ulg=;
        b=l/3ojmF0+d+gZoeoS0hF2TZlRyG30qEE+u+c7KTFtGL8xWfBxFw85OeJAW6RnBO+QI
         LI26AxRKd47lRdlOFb0goCeFtcdHBgu9JqAzliGr29spKxFf0Tvkey9ifeZmq5s4xnm3
         hfUTFaBJKOKM4tOUXiD74QE2pLevPRfXAzC2Q/8I1cpCOIqyDvUM5rn6QEOFYUSW7x13
         p2XQ8worq5B8Sby33O1Wkqd+4MLlV6JzYfDfJwn7DW3/lVIi/5l0bpMa+RJD5tsdVBsq
         dds8wp9eCWTTvmOvoeBD0PHDFHc0HZtW1Cy07+s6/ZDyGi3GpUyGLU8xrsQX18wM2RmI
         /MNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749044445; x=1749649245;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=V8M1w2wiiJxkH7le4VbH37yk9pxwXzzPAoNmR8z8ulg=;
        b=d9WN8DDVaZgS8goip8ze/3yZiTVkzjiHjlzWwyC2ZDpnVsen3V/R66t7NrVU+nEfOp
         e2Phx7RzAerfJgnqrkQRBx8hDUOG2SDx/1pOdbfOWh7ROI8a2coQLSY1Novx0g/2GdKb
         uWrzEJ3vjXFXjTL3q7zj3TdmFvv297oVGatdXUtPFcbX/5UIueQ1zCaLKYz7Mycmx5ad
         ppj0gvKwW6LnxAsvadxQ1s4/9Kj2zeUlqi3iPHbcoBp5lr8GSz54Kh0c/XW1C+HJ4u1n
         fJfKgZ+YA/LcOzvHZK5+3wWZy9AuHCF7it6USb6FdIDO2EshtlN8gUI5o2ghKyIm9dUt
         BX0g==
X-Forwarded-Encrypted: i=1; AJvYcCX6JAkM/vvUQ9yk3CyDryS8dBhR/eXUBwCBZM9CRbcvi99FwBPikYek55qtW4Q64DshwArbQ3xzjniZB+M/ISk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzovPO22H4ju984DcETxHR2dvKcQdqboZEzz7sHkK6ZzjRoYY+F
	M+sn4CJT8T5G1QRrGo3YzLpObDnkD21mJuzVLN8aXxEVdc09jlruenrN
X-Gm-Gg: ASbGncvFNVyn1JAtJzA11cIg9B20gOGtIwtMC5BtCp5BGi6d2xszFHnNF2pgcXgorMD
	WsMr/Q0M2bzlPvNKe2vVlVDjdHTIUj3sgJowytawIVzeawogxtjnomEVGaE2/zzYsfcyrmH9mN9
	tdhRqq77qUgOSKujBl7cdPHdM8q9dvHMziPEUZ1wW+xBCtrYMhwnZ6KxVNSOC7zJjb1rfeXhbEN
	RrESKAk2UHGjTzQffGXtPNaCklDHNlIbpeGcnkxEgZW2UqpFmMmcH7URQe6EU+LlPIu5uB4z1kJ
	O3M4LMmb23P3RKg9hzNG6qpbr9HRNM6KETaOwhi1m0Pm7Q1V07f8FXp4wAPdKVdhIN84hsPVPWV
	1YydfsCeLHkZAIHYzkNQ23oUUduXcenLiiQ==
X-Google-Smtp-Source: AGHT+IEoGkBWPRk/YwDESAqmOJLFtDdfmB35LLTY2mxUmae5Ny/l+OBIvWNJhVT1dojsiMp0toax6A==
X-Received: by 2002:a05:6902:102c:b0:e7d:7b06:c567 with SMTP id 3f1490d57ef6-e8179c30a40mr4107702276.8.1749044445065;
        Wed, 04 Jun 2025 06:40:45 -0700 (PDT)
Received: from localhost (23.67.48.34.bc.googleusercontent.com. [34.48.67.23])
        by smtp.gmail.com with UTF8SMTPSA id 3f1490d57ef6-e8183c6eae7sm107480276.29.2025.06.04.06.40.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jun 2025 06:40:44 -0700 (PDT)
Date: Wed, 04 Jun 2025 09:40:44 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 davem@davemloft.net
Cc: netdev@vger.kernel.org, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 andrew+netdev@lunn.ch, 
 horms@kernel.org, 
 Jakub Kicinski <kuba@kernel.org>, 
 shuah@kernel.org, 
 willemb@google.com, 
 linux-kselftest@vger.kernel.org
Message-ID: <68404cdc417f3_1e99f529483@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250604012055.891431-1-kuba@kernel.org>
References: <20250604012055.891431-1-kuba@kernel.org>
Subject: Re: [PATCH net] selftests: drv-net: tso: make bkg() wait for socat to
 quit
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jakub Kicinski wrote:
> Commit 846742f7e32f ("selftests: drv-net: add a warning for
> bkg + shell + terminate") added a warning for bkg() used
> with terminate=True. The tso test was missed as we didn't
> have it running anywhere in NIPA. Add exit_wait=True, to avoid:
> 
>   # Warning: combining shell and terminate is risky!
>   #          SIGTERM may not reach the child on zsh/ksh!
> 
> getting printed twice for every variant.
> 
> Fixes: 0d0f4174f6c8 ("selftests: drv-net: add a simple TSO test")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Willem de Bruijn <willemb@google.com>

