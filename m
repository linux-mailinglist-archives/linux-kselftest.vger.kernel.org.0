Return-Path: <linux-kselftest+bounces-2351-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D58F181C54A
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Dec 2023 07:55:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 822381F23F83
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Dec 2023 06:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A5B38C0C;
	Fri, 22 Dec 2023 06:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FSyIWE4k"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45259BE47;
	Fri, 22 Dec 2023 06:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3ba1be5ad0aso1054742b6e.0;
        Thu, 21 Dec 2023 22:55:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703228103; x=1703832903; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=d698nlU2iUgjYgke3iePr2VWfwvUHXPN7X414zt9vIA=;
        b=FSyIWE4k5EDyglpq3w6EGjC5fDYlg3tK9NRV1//MeqI3iTKU4RWZxq2v2+iQwE5Rr0
         l8qAOZfgLZV+jJd4zXjyVwS/I0wCfQFOaAlQs8ZISCyHppXWeP0/ibBRrnWXW8KunuBb
         e5KxVZlhoqiw2Fb3R7/iOZJBVy9BKEy8psZIkYk+ebAy+BvDcyMbi53+COVr8DZSX+RN
         1pbhjjxxujYBEvqoMms0kWn7b1X9aU8k9vnj4yB5ZKJ8MmU8Csq1wmpUQhgt2O5Z9dCd
         5qtyddDwdaTB2xZplRtpAT2CjkkBwPmEJR9CoObyFZW8JT6+gqh/JK0QQ7LB6IAwLkYC
         64hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703228103; x=1703832903;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d698nlU2iUgjYgke3iePr2VWfwvUHXPN7X414zt9vIA=;
        b=uGdMJQ4lC6z+T3uyadi9ax1PHqj9UE2vDWhumvdrJT9Fk91SLoSEeZgPSjeEQaTqSS
         Am3RKJwQ9ierqxiqJU5SkbWBZvCSYGUInZMdqjM/zS2NLHLR44gYHTIWJMkK/N6Z0/Rx
         XY5o75AeQ164YNltpRygU+EdG+xcKLbne00XNOSbF6+rOks0GnUkYaVbPrxtRGOM4tHe
         /a2PMUd/nADxo545wYLks6XeKmvfCvrW0AXjrUyNUvMqM5SK+Gw6p+hdRX9kPqejsDLS
         aFH7joP5O7MpUAtq8cmizz/1y9pPmoG9wzAK4LJxOLyX7Nyd04sOKxuiITLv9HfAmLrW
         zAaQ==
X-Gm-Message-State: AOJu0YxR86Ih6vvXfMUu1czBKOG2zgpOjK1lOz41vhKiye/0Ghf6mqWM
	Wo3qpca7lHrmrBTOu+A/nXg=
X-Google-Smtp-Source: AGHT+IG1uxrzDoVTrFa8KADgsjNavPRrqDfmm2ms1OBTpgh+Xd6di4fsgcUDhsoA/HGvc3n+c0xOZg==
X-Received: by 2002:a05:6808:2014:b0:3b8:b407:a988 with SMTP id q20-20020a056808201400b003b8b407a988mr981620oiw.13.1703228103249;
        Thu, 21 Dec 2023 22:55:03 -0800 (PST)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id y9-20020a056a00180900b006ce450f3e57sm2670071pfa.154.2023.12.21.22.54.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 22:55:02 -0800 (PST)
Date: Fri, 22 Dec 2023 14:54:57 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Dmitry Safonov <dima@arista.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	Dmitry Safonov <0x7f454c46@gmail.com>
Subject: Re: [PATCH net-next 0/2] selftest/net: Some more TCP-AO selftest
 post-merge fixups
Message-ID: <ZYUywVqBwRtWyrqs@Laptop-X1>
References: <20231222-selftests-tcp-ao-fixups-v1-0-39c73817c372@arista.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231222-selftests-tcp-ao-fixups-v1-0-39c73817c372@arista.com>

On Fri, Dec 22, 2023 at 01:59:05AM +0000, Dmitry Safonov wrote:
> Note that there's another post-merge fix for TCP-AO selftests, but that
> doesn't conflict with these, so I don't resend that:
> 
> https://lore.kernel.org/all/20231219-b4-tcp-ao-selftests-out-of-tree-v1-1-0fff92d26eac@arista.com/T/#u
> 
> Signed-off-by: Dmitry Safonov <dima@arista.com>

Tested-by: Hangbin Liu <liuhangbin@gmail.com>
Reviewed-by: Hangbin Liu <liuhangbin@gmail.com>

