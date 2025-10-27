Return-Path: <linux-kselftest+bounces-44110-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61599C0F35E
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Oct 2025 17:17:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFFB6561CE2
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Oct 2025 15:59:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8968307494;
	Mon, 27 Oct 2025 15:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="flKOZA2+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1466E30BB85
	for <linux-kselftest@vger.kernel.org>; Mon, 27 Oct 2025 15:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761580607; cv=none; b=gKp1gxA5XIanBI2OWQLWCfuEOp4DdnumNKHr3TpXs5h7m2IXJbCjEEapAqLtt0kRZt9L+SzHk03Ysqv2yFOMKfzW6MgpM8uyMMHwklc6gpW5XMpgSpQAAFjBlHUuN9m7fGhseroNdthhEv9sOkFMwVbGJ7OAQxj8bX8HS+QzOK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761580607; c=relaxed/simple;
	bh=jiym7E4Dmqh94R6ZPzH9fLGO2aY5UFNCKNdF8kfE4Nk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s9cwcVL/o2+9fcnalYcIMuKiiqNaMF3Gl/xqmuhxEWh9Q5I2bzv4v0aIGx6+ieqYxCOR+5xfbtoZjzyYVNfj8mweJJ2y/oCCrFnLJvL5b2B2+k57rX7StmEMs/OhA1W1gTDRVfHH3SoqyF2YtxtuvY7udGUuVvUhpUH07AOtAg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=flKOZA2+; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-78112783d99so1545957b3.0
        for <linux-kselftest@vger.kernel.org>; Mon, 27 Oct 2025 08:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761580605; x=1762185405; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jiym7E4Dmqh94R6ZPzH9fLGO2aY5UFNCKNdF8kfE4Nk=;
        b=flKOZA2+TFHN8mVHaz+ipuRORQ7XJRibXSU24Zl1QIoHCzrrasv0XXe/A+PLqnOltr
         Gq+W5aP4Ln5hCBMsuPf6rRh7Vn+XfYEwflR3joFscfznk+UFZw/eFfe53YsK8UboPCQV
         Rp9vhaTLk8irNxzMWtewRQJ5P2qkI8Q5FQk6RF3Ah6VsiW23Ihe1DUKdkh2pV18u8usA
         fgR+mMTcnbBVly6v/CtPjEOkpO9tZj5I2zTlCRvxJXnH/MejN4cprHb6MQOHGYNFog9A
         wxiSdyOyVzmu2ZJ6RCKRwOGpvABt6gyP+VMK4Lic/WHnC+FSfp1NEFUx8h22gtsCYcHq
         DS8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761580605; x=1762185405;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jiym7E4Dmqh94R6ZPzH9fLGO2aY5UFNCKNdF8kfE4Nk=;
        b=Jn2PKoIA1O0OmljVR29LBSYjFSQhEqIvYVIgcI1GuYVSlpOyNP5EcwjKkBqCyNdEuY
         SXXMQZBCd6cVi/4xnERSup5ccBzfdNNRE+6zaVCl9IuEJ70PUWkxq32AOn5jH1vtjWwX
         3i5ukcM+0sn8asxnlTmCYSw03amz/MJy9YZRURILl12QPK0VcKMzgsw1pFqChlvGmdiO
         MW1+a1LxhZhEYBQPQjhXmXl5+nfqMB1g5g9cgoCwz3++cUr5UgMuYm7UeyPNcmgRpXS1
         dIg5mGLRX/rFjK+QWZaOPEpXoFOnM2DyPNDJFIBP47dO+b58tLrFEGADEqpLYob/6zxR
         eWyA==
X-Forwarded-Encrypted: i=1; AJvYcCWUqjlaHc6cmJGfLcggX/sLlRpURO0H8nv3+tT0Dapu3iCIUaOPywRITscGmML2Wwyhy8m8NGIx2lsYxHG+314=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzh7r27sHOrJFq9pW+TB+i0Omo8UyhqKZ8WNQj3rqWUDfMMHcCq
	9zTpXhs+gr1w1iwCz5ej7s54d7kStuTDdPT66O/TjNh/0nAzsatHhFErQ8vrzCSmQcMIDCoEgUK
	7MZFIXRRuRBiuWo+vXK8u4UQ+Nfjmo20=
X-Gm-Gg: ASbGncvXGDPuow+ZgNOsADdewEoz6bxllDgsh4yAukwJ1c3TEJbXdL9WkO0xF6/Y/ay
	2KrNoR8EhEyvIYohPNCX3lVH/BQi2GPM60XiPlVU8uIUN5prHgVNg5rP5P3j1Q7Ihiis9uISssd
	x6KISmlPG/4pdk4bBnt/iY6Oo62CbL3/SoxprY72BygkQzaJYKzgZnDj/S7BMDtlUkB3e1ASvV5
	TFwg1jBGwbKQXfQXug4PVjurPMSxaAfUOi9DfG/irEN6deUe4fdEkzu+MPEM9elT+1eXzjNb/sh
	x1cMQTM=
X-Google-Smtp-Source: AGHT+IFjOmYnS2xYaM0HCnIHZRcjA28iEqAsz9PYX968JpJQQJnvJYxUKIDW6M7qduZDcvbJ3707IkAmn+4FttWYgBg=
X-Received: by 2002:a05:690c:4b81:b0:781:593:edd1 with SMTP id
 00721157ae682-78617fb4d2amr1702807b3.7.1761580604915; Mon, 27 Oct 2025
 08:56:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251022-netconsole-fix-race-v2-0-337241338079@meta.com>
 <20251022180107.3a7d1198@kernel.org> <CAGSyskWm=jDOSPAh3LWEQQzjAxvc-Od7DkQyP7W9EynoMdDnMg@mail.gmail.com>
 <20251024164207.3062ea9e@kernel.org>
In-Reply-To: <20251024164207.3062ea9e@kernel.org>
From: Gustavo Luiz Duarte <gustavold@gmail.com>
Date: Mon, 27 Oct 2025 12:56:32 -0300
X-Gm-Features: AWmQ_bmFQCqeshpa-lYwQ-k8GODXN7uKyqnNwg-U_bm1yTiNYDMbv1R8W4iv7rs
Message-ID: <CAGSyskWwDqng6TFGrmr1jWDhS_-PExen+fCVEm-8vDBUEy1uLQ@mail.gmail.com>
Subject: Re: [PATCH net v2 0/2] netconsole: Fix userdata race condition
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andre Carvalho <asantostc@gmail.com>, Simon Horman <horms@kernel.org>, 
	Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Matthew Wood <thepacketgeek@gmail.com>, 
	Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 24, 2025 at 8:42=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> Frankly I'm not sure this test is worth the compute cycles it will burn.
> It's a direct repro for a very specific problem. The changes it will
> occur again for the same field a pretty low. Maybe just repost patch 1?

Fair enough. I will repost with only patch 1 then.

