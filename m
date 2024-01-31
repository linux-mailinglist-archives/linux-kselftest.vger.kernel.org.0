Return-Path: <linux-kselftest+bounces-3872-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C77D8844756
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jan 2024 19:39:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC96E1C227AD
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jan 2024 18:39:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E0D218B00;
	Wed, 31 Jan 2024 18:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ISi55TH+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AEA018634
	for <linux-kselftest@vger.kernel.org>; Wed, 31 Jan 2024 18:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706726388; cv=none; b=QJxXrXnB2R28ImHDQz0c4CEvAyMgHAUIbXrxNqSgckK7LkLKSjq3qAB+owIUXM+6TsdyJ7tjKyhBPgYjovS5sbVRfTPsrF7VDL+xV0aU39VZzmWxqkJib2qXcFO8fI5rOW3Blq7q4SqM4hi0y87M2FNv42b77u4GuU9++Gk3BOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706726388; c=relaxed/simple;
	bh=QUzq2Czc4JXRYqcyKeyFT2SLWZTNadaaPT4Rq2b5HPo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=a1s6E8+CmlX5NfAy/IK7L7og5c8x5Vwxh1fwTRnLcSpGqXHLhnhgcXyZ1vHs40sT24YZDIVUV8zypDKLAUH+FPZn8U1AMzGs0nDbWR8PF+AEG0sf33Zudv6CN92clXDGcDDT9/mRQQNOa6ZImOlg90ldVok/UYJ2lP1e0Ts0Uh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ISi55TH+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706726386;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=QUzq2Czc4JXRYqcyKeyFT2SLWZTNadaaPT4Rq2b5HPo=;
	b=ISi55TH+n9Mt+Rrn9SRFVrs8vxJVceZBiOs0l63FD/VjHdPYz79Z/Hvf1AiKCYqvn42Gm4
	PpVDFD7ytyv5vIIe/q9SfrplI6VD2yeUXsZhTB5Qxc4O7ChlFWHD4cLos4kTi5HrEDZ70I
	KO6S5ZYZeUGTtsCP5NhXGq6SLL6HKvU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-635-ohBZGuU3MsC9pTBS7VcRPQ-1; Wed, 31 Jan 2024 13:39:44 -0500
X-MC-Unique: ohBZGuU3MsC9pTBS7VcRPQ-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-33afc7484f7so11224f8f.0
        for <linux-kselftest@vger.kernel.org>; Wed, 31 Jan 2024 10:39:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706726383; x=1707331183;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QUzq2Czc4JXRYqcyKeyFT2SLWZTNadaaPT4Rq2b5HPo=;
        b=kkud/oYT/Lh8SWblIVwIPaUxpdBnDfaJqDGGQq5Wixo+pecw47z/fXMN+zAvdLlZsV
         uDMA/kNhx7RUHLdSGoJDY97ovRbpeZniZd4FgI0GDsbgrkJQ0MuLY1HrksZ5+/iDJffk
         iII/7GnwTN2loHR7ipGiY2AfhclVxBc/oq3on0PhhLuCdmTYMjlKcv+SsKl1EA/aLR10
         wnGT1QBMFlZMFoY3+Wz6MvpMhyRniGkCEd096bLNJjtWM7Kxdz8uXbDPYvrmErqAgHn7
         nNc1/9zkZDe2QrdI6dukdXDBsn4TVdIzZKjs9X10BOjnW4Ldt4196sFPFwB51f6WZ41k
         IMmg==
X-Forwarded-Encrypted: i=0; AJvYcCVGULwdkMN0fP4V/HKDCCy+2wEtJeIaEEUipQeqxVnpdIRJUbQ1f4qfO53DCfGH86lxylkDI1dxk7wRAgZI/SHauplvWphESV6yBkly4yoj
X-Gm-Message-State: AOJu0YxofhMkyIE0Z1AG/WkNJDpBU5JSr2ZqpdiJe2lwSUh3VxX54TWF
	yZ+35pXSS6HR38ReapdkUrxTjwZC6FTqYzsZrHtwbCEXuA3Sz/ZoySfNwt294WpD8yyYpnqegCj
	VSxZ9o4qVC0LNgsJZKGQf53VpBOXAgF2RZxnpr2EGyej11n7cG/XUuTExVdGDjiftog==
X-Received: by 2002:adf:a11b:0:b0:339:5946:5630 with SMTP id o27-20020adfa11b000000b0033959465630mr1785195wro.5.1706726383409;
        Wed, 31 Jan 2024 10:39:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFnVhUN1vEvyU/fD+U4MQb5QiST2Cr+Zg2aj12cMVIMHUbw+S0cD+PFaoYm1AHpFxnT2LWTPg==
X-Received: by 2002:adf:a11b:0:b0:339:5946:5630 with SMTP id o27-20020adfa11b000000b0033959465630mr1785189wro.5.1706726383025;
        Wed, 31 Jan 2024 10:39:43 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-236-152.dyn.eolo.it. [146.241.236.152])
        by smtp.gmail.com with ESMTPSA id n4-20020a5d4c44000000b0033aeda49732sm8708037wrt.33.2024.01.31.10.39.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 10:39:42 -0800 (PST)
Message-ID: <b8f675495a2c16cd742d1a95b3421ed15643aad2.camel@redhat.com>
Subject: Re: [PATCH net-next] selftests/net: calibrate txtimestamp
From: Paolo Abeni <pabeni@redhat.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Jakub Kicinski
	 <kuba@kernel.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	linux-kselftest@vger.kernel.org, Willem de Bruijn <willemb@google.com>
Date: Wed, 31 Jan 2024 19:39:41 +0100
In-Reply-To: <65ba61ea978b4_1699fd294eb@willemb.c.googlers.com.notmuch>
References: <20240127023212.3746239-1-willemdebruijn.kernel@gmail.com>
	 <20240130174736.03c79071@kernel.org>
	 <65ba61ea978b4_1699fd294eb@willemb.c.googlers.com.notmuch>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-01-31 at 10:06 -0500, Willem de Bruijn wrote:
> Otherwise I'll start with the gro and so-txtime tests. They may not
> be so easily calibrated. As we cannot control the gro timeout, nor
> the FQ max horizon.

Note that we can control the GRO timeout to some extent, via=20
gro_flush_timeout, see commit 89abe628375301fedb68770644df845d49018d8b.

Unfortunately that is not enough for 'large' gro tests. I think the
root cause is that the process sending the packets can be de-scheduled
- even the qemu VM from the hypervisor CPU - causing an extremely large
gap between consecutive pkts.

I guess/hope that replacing multiple sendmsg() with a sendmmsg() could
improve a bit the scenario, but I fear it will not solve the issue
completely.

> In such cases we can use the environment variable to either skip the
> test entirely or --my preference-- run it to get code coverage, but
> suppress a failure if due to timing (only). Sounds good?

Sounds good to me! I was wondering about skipping the 'large' test
only, but suppressing the failure when KSFT_MACHINE_SLOW=3Dyes only for
such test looks a better option.

Thanks!

Paolo


