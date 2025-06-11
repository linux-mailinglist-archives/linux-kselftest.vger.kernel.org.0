Return-Path: <linux-kselftest+bounces-34742-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D794AD5A1D
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 17:18:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEF0716F8E1
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 15:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F73D1DE2CC;
	Wed, 11 Jun 2025 15:14:15 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ABBF1B6D01;
	Wed, 11 Jun 2025 15:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749654855; cv=none; b=cWWkogX2JB6nmyX2V/f1Mg0yWjYjesLgbaaYJdRWLNNpGRSyRYsGUM3Fw3Wm1dC4MSot4GQpJMcTY/o32r6JSx1QpDvFxpBmqQwDjLKSHeDag7IQRdtaT/+RNlhKh8uIkk7hR3ixFHvz2Z0p11wrfFWs0RTIGgfvr+yR21bxXHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749654855; c=relaxed/simple;
	bh=j4HtOeH+lQJTeLsbYvGMDZFJPCC7o1GI6t95ynQNJ9A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BRQLlGBv7m//Ir5O6Ja6c42/eU4AWpCiPZx3hgjxEyDDis61yj6QiTNiRfbz15EDCmMOxy6keN0Tv9RhFIWA6G6eZ1YC9J9yU0gK/wvjIOrKBF8uA1bFz/Om90NFSEYIRKSJQjTiwBfoHyzurbnB+wiGfu+10YhOqSbbOwELth4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ade5b8aab41so684202566b.0;
        Wed, 11 Jun 2025 08:14:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749654852; x=1750259652;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xxtjsYc5WzCsw0sWcakgTm1NCq+gnxfAoujY6jqX05Y=;
        b=k8XEMhkE3lEujU1Koaubi3uuOVM+kieDgrJSd489TimiI7mC7VZ8w/596ACH2I8BCj
         VX9jspf79zjWZ64Rl84QfjaNx4RvN5zccV/jcKM111qfKZNDiGuPpsACOz/UFlRfUNiM
         nRlOfkArYyD5c3XSzbkcFHjxNlrmB4s+g7EMy7YdBxUChO3Qo9eLab9B2Yn5vu8YslrF
         +V0DOz1IhvIHR5utf7iTGRO5XLw7hmW4AT8KMt9UZlhb3Ls24GyfTgHjF7usWkmmxrga
         LkLl8SkfGV9E6JCtWs1iTS2+B/HLAi1F/iX5CnhGvPSkLa8Dtcp2le/yIwliXujMtTQu
         v6tg==
X-Forwarded-Encrypted: i=1; AJvYcCVznSPwsJeBQ0WhrQCdYBrb0+AZmw6XCvia7pqsJvHkvP+IfVooKn+iRytrVmLafuQssnKsSI7Z4p/aHAOg@vger.kernel.org, AJvYcCWbKRu3tULiHWsV7R/7k1N11/Ie+z9PVruGo9/rsA8oDCwCn2B3KNhovgWAtK/8rle0YQmESKCe0ZM=@vger.kernel.org, AJvYcCWo9vkmNjxLvQ+KCSDyaAAcQ5mG4FwQJ4+XQY/FeI02xoD2cIOiHOaft4qc7EXwWRlJJd00zKpA@vger.kernel.org, AJvYcCXGgyNIBKIimzHGH1XNhViUCfTOKIq801CAXf1LyQCrIimXalh682PWw+xHrd0hg8coUnk8aHM5a4aUkdQNEwJu@vger.kernel.org
X-Gm-Message-State: AOJu0Yyj2pdMzY++zUhX8uNbm2RjDRqJRuBVAb11/QgoaNr8qwkDNG/S
	67LumXCH/yNhKNEVSmc8JFIesO29daPn705K+0n8y+dpgMSTqcyfCpHe
X-Gm-Gg: ASbGnct79JJnkqDOhS5MGGeIHsRNb5FeCMVknIvU45un489YjtOI1kN1eO4IsNAUucZ
	jAU6sG7QeWZHCniyNI+ulhDHPH7FapnpkHmxFiKOtR4ZYGXBi+wk+eylMOHHe0th4H4ayzaRZzv
	R4Y/hd4+c2x0hwuAi2HGO7jbInluEjNKEBJPPKPbdZEIVhT56yUfV0iLM0FSBm1trJkRn1F3/lY
	sjRw7TptYQcCAIPIfN5FuwfEg/cS0OocQm9CazLB02o3RnkA8QdPr3qbWVNGfCqWuM+yqTd76pW
	96UN8tAQCcLXRd/FT7UzXFGHbsjVOgkORulcoQo/vsr+N8fuMynSiA==
X-Google-Smtp-Source: AGHT+IEJvF/k6wW9sOP1mWvnvDvmZbJ83yqSoXHsvG5vRtSWUDSp4eE4+B2E5P14jKw4coIWl3JZ3Q==
X-Received: by 2002:a17:907:72d1:b0:ade:3bec:ea40 with SMTP id a640c23a62f3a-ade893e2b8dmr406508566b.10.1749654851743;
        Wed, 11 Jun 2025 08:14:11 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:74::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ade1dc3a241sm900604066b.135.2025.06.11.08.14.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 08:14:11 -0700 (PDT)
Date: Wed, 11 Jun 2025 08:14:09 -0700
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
Subject: Re: [PATCH net-next 1/5] netconsole: introduce 'msgid' as a new
 sysdata field
Message-ID: <aEmdQaxnlS4jbfSO@gmail.com>
References: <20250611-netconsole-msgid-v1-0-1784a51feb1e@gmail.com>
 <20250611-netconsole-msgid-v1-1-1784a51feb1e@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250611-netconsole-msgid-v1-1-1784a51feb1e@gmail.com>

On Wed, Jun 11, 2025 at 07:36:03AM -0700, Gustavo Luiz Duarte wrote:
> This adds a new sysdata field to enable assigning a per-target unique id
> to each message sent to that target. This id can later be appended as
> part of sysdata, allowing targets to detect dropped netconsole messages.
> Update count_extradata_entries() to take the new field into account.
> 
> Signed-off-by: Gustavo Luiz Duarte <gustavold@gmail.com>

Reviewed-by: Breno Leitao <leitao@debian.org>

