Return-Path: <linux-kselftest+bounces-37805-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FE40B0D5CE
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Jul 2025 11:22:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40DEC1890BA6
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Jul 2025 09:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23F0D2DCBEC;
	Tue, 22 Jul 2025 09:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="X80OWRUn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D7EB17741
	for <linux-kselftest@vger.kernel.org>; Tue, 22 Jul 2025 09:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753176142; cv=none; b=PmU0X0lZxu2PINrfAvuNd26ZDVhMgN4yaC8abH8umh2jiG+gd9qpR0jO7Q3NgI4ioptdaDPautwg5lJ/7noyZVaxpWX6AxTrsJcrWgQk5WqwUGDxgGmc1t5xgF2dRjyPWgbcKroWt6ynsoSdXjQ61wQHaSEX7fl7YZMFVZrV1cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753176142; c=relaxed/simple;
	bh=uYr/vN/QU33ReSJvEevEB5MK/+NOdjeWQPyffLoa+I8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XuJeIvriXsDL0z7EHxZQeaUmYEHCm7p5/dmeGvrH7tjovhq1Agissu5VdUbkZJwkiYf1issv73pQtztZe2/SiVkE6ENjlmSP6TjItAkfVS1kq5er7DbjYvDu8+r561Uk3q+UBHpl1ERf68/QBADxO7B4MYC/mdntOqRk8aQhPYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=X80OWRUn; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3a4e742dc97so3276816f8f.0
        for <linux-kselftest@vger.kernel.org>; Tue, 22 Jul 2025 02:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1753176137; x=1753780937; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=68LTZPICfvpdeBNlynhA03OE6AbJLyW/A+yzTWLxPgc=;
        b=X80OWRUnsxH1FGHcf5NZWzUZuyf/aRV+Mg7HmAcm8+aaJee9ftRo/nscJ8K6udhYG3
         0Flexox+s9Ihpi1cF6g1woUQMXZ85bPh1ngGFHjs/MKK3CWp5dsMaLXFakLvw3plE1jJ
         LR2cZ4iIKGXkyqGTR3gW1AnKrHDMFPlr7W7PfB6osEaOe6lyzVyD28hByrw9x8xkga2f
         mLwMubqu45XatAyC/DLlINTquocnIN2k9SKQFEMWBMNuFlqBdkT6rkjicr9JKhJD0vwa
         c7p0++tImueIIC5bzOATFRnAeOXPJ5MmOiuiy3imX0ic84eNGreqmHoYW0952OUtKKGT
         0ZGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753176137; x=1753780937;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=68LTZPICfvpdeBNlynhA03OE6AbJLyW/A+yzTWLxPgc=;
        b=Q2Gn9Ryej5jFYFkNI7C4EIV/RjWrDIpllFjp30SlH5h02FnEh5YCWXqqUHRjk9h+HI
         mY72+ljRzinD53kN02jczENFAN7d+qGkqzV6yI2hathdx0Ce4Pdg/5edeagErDnzQ6th
         ktzOKqX9kAEzu3mJssY/SQRlABBfa0Z+JPHXte+bzN0EOEHPVRQKijnwcHdWlhT/G7Ov
         MDr9797PDKZX2QgpG9BhlsfEO3wFLkXr+DJV9b8wywNzRHtdG+1yr8QGsjsZdagu8nOZ
         kvB7XrxqHszyaMSw8MZ6Cmo1uG6llksNvZLA0LH8IyIzI7V1AwqBqTDq3HT+uy0EDO1L
         0RjQ==
X-Forwarded-Encrypted: i=1; AJvYcCUixNPOlIpctMVmW/BKM481ofINg7AxF5MTT69szb5Tiqt6ZkzMku+IeWauzFyl5tS66g/COKMWKdW/SJUfYaY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy08wJAjv2Sd56dHvlYwCt9XvN35g2eXUNfxXeJvscPAs576G26
	m0Ry86Zi3qqxg/jDLpEIuwve0gOolfgkjD8XV6SfMK2IAnHIjBTpPDlxwCgGWxc8BPY=
X-Gm-Gg: ASbGnctrT2WOO1r+TBS6LnuhjLep0j15uBOHILzkbO7C61IaBXaGbfuU7J7ubFhbyHp
	60ZsVk+JwAyoQ/rC6Jj1u+IaeQ+5ZAghnPD66v19pKxe/F/dfSnBpupRLL2S5DcUz74vViOX3C9
	w/LuZhpwbbUWiubbX3ed0TMNYqZ0p37oO0CHSzK6rvpFIK8kLvbBbz/64bhNGwY0sqk5ZdmyUvB
	U1tX7RT/LBbs2T6C6uZQl/JkGUL/tXRVYQi/Akt01zoBNJmyVkgJgwYF0yJ5iSZLHnfIF59clJx
	24yKOBUsc8vE6e2prKn91lAwyncz9Jq1b86Awu8jrZH5touOoNwcbKvQMLEPnEoBk5Q9ttFyvho
	PkZRVE0HIA6UXJq9raazbnHw5
X-Google-Smtp-Source: AGHT+IFVMdgI84AAnBBQz6sZmRWv62oz1HqGcw1SLKt4wi8dXsCWBwHYMMj3blV9NJZQxxpoW0Qdkw==
X-Received: by 2002:a05:6000:2012:b0:3b7:590d:ac7d with SMTP id ffacd0b85a97d-3b763488cc5mr2270468f8f.1.1753176136501;
        Tue, 22 Jul 2025 02:22:16 -0700 (PDT)
Received: from jiri-mlt ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b61ca2b803sm12548484f8f.19.2025.07.22.02.22.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 02:22:16 -0700 (PDT)
Date: Tue, 22 Jul 2025 11:22:08 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Donald Hunter <donald.hunter@gmail.com>, 
	Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Mark Bloch <mbloch@nvidia.com>, Jiri Pirko <jiri@nvidia.com>, 
	Cosmin Ratiu <cratiu@nvidia.com>, Gal Pressman <gal@nvidia.com>, 
	Carolina Jubran <cjubran@nvidia.com>
Subject: Re: [PATCH net-next] devlink: Fix excessive stack usage in rate TC
 bandwidth parsing
Message-ID: <vabulcn5q5hm4qhiol75cwuztq4wijcjkiw4oy4wjckaybbq5m@54xt4qxhwnls>
References: <1753175609-330621-1-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1753175609-330621-1-git-send-email-tariqt@nvidia.com>

Tue, Jul 22, 2025 at 11:13:29AM +0200, tariqt@nvidia.com wrote:
>From: Carolina Jubran <cjubran@nvidia.com>
>
>The devlink_nl_rate_tc_bw_parse function uses a large stack array for
>devlink attributes, which triggers a warning about excessive stack
>usage:
>
>net/devlink/rate.c: In function 'devlink_nl_rate_tc_bw_parse':
>net/devlink/rate.c:382:1: error: the frame size of 1648 bytes is larger than 1536 bytes [-Werror=frame-larger-than=]
>
>Introduce a separate attribute set specifically for rate TC bandwidth
>parsing that only contains the two attributes actually used: index
>and bandwidth. This reduces the stack array from DEVLINK_ATTR_MAX
>entries to just 2 entries, solving the stack usage issue.
>
>Update devlink selftest to use the new 'index' and 'bw' attribute names
>consistent with the YAML spec.
>
>Example usage with ynl with the new spec:
>
>    ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/devlink.yaml \
>      --do rate-set --json '{
>      "bus-name": "pci",
>      "dev-name": "0000:08:00.0",
>      "port-index": 1,
>      "rate-tc-bws": [
>        {"index": 0, "bw": 50},
>        {"index": 1, "bw": 50},
>        {"index": 2, "bw": 0},
>        {"index": 3, "bw": 0},
>        {"index": 4, "bw": 0},
>        {"index": 5, "bw": 0},
>        {"index": 6, "bw": 0},
>        {"index": 7, "bw": 0}
>      ]
>    }'
>
>    ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/devlink.yaml \
>      --do rate-get --json '{
>      "bus-name": "pci",
>      "dev-name": "0000:08:00.0",
>      "port-index": 1
>    }'
>
>    output for rate-get:
>    {'bus-name': 'pci',
>     'dev-name': '0000:08:00.0',
>     'port-index': 1,
>     'rate-tc-bws': [{'bw': 50, 'index': 0},
>                     {'bw': 50, 'index': 1},
>                     {'bw': 0, 'index': 2},
>                     {'bw': 0, 'index': 3},
>                     {'bw': 0, 'index': 4},
>                     {'bw': 0, 'index': 5},
>                     {'bw': 0, 'index': 6},
>                     {'bw': 0, 'index': 7}],
>     'rate-tx-max': 0,
>     'rate-tx-priority': 0,
>     'rate-tx-share': 0,
>     'rate-tx-weight': 0,
>     'rate-type': 'leaf'}
>
>Fixes: 566e8f108fc7 ("devlink: Extend devlink rate API with traffic classes bandwidth management")
>Reported-by: Arnd Bergmann <arnd@arndb.de>
>Closes: https://lore.kernel.org/netdev/20250708160652.1810573-1-arnd@kernel.org/
>Reported-by: kernel test robot <lkp@intel.com>
>Closes: https://lore.kernel.org/oe-kbuild-all/202507171943.W7DJcs6Y-lkp@intel.com/
>Suggested-by: Jakub Kicinski <kuba@kernel.org>
>Signed-off-by: Jakub Kicinski <kuba@kernel.org>
>Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
>Tested-by: Carolina Jubran <cjubran@nvidia.com>
>Signed-off-by: Tariq Toukan <tariqt@nvidia.com>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

