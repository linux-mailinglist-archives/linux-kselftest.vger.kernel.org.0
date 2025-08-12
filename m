Return-Path: <linux-kselftest+bounces-38778-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 51F5EB22A49
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Aug 2025 16:25:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70E571C20C1A
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Aug 2025 14:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70C762C15B1;
	Tue, 12 Aug 2025 14:01:44 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A570A27FB3C;
	Tue, 12 Aug 2025 14:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755007304; cv=none; b=Wt8pNs1wrQ2gQuz0BOOeQbHfj2C9N8zLcnk7+vZkKTLGf7AgBXORE3jU8lIMoTslo/eokniY2tg26Td74V0/4VrINnY7JF5O+5jqVi1ZKUfEBzXgC+OZ1FJZljLp5WXYM/hns9rEJi26+mrAvnNA2cLa21KJ+Hun81GnQ2PmQq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755007304; c=relaxed/simple;
	bh=O9C/wcY67rV2aEoSMk6x+5amNV8Suj9IjEGddeF+ZsM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aodwuUW3hVJ8o/tXEuxP5+z7phZ0Y2apJeoiiDdoJVlQqgOEiUmXLQJ2RWAwc0Ery1iI0+E7IJpsrrFPjXjLIAwp3N4Nz/9n1Ri/yFXT4UzpWJANF+YiQQhPlcAclJKLbj6u7pnYAQGlQXqgjgQALGsC3bHJx55ufBMCkXUBcGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6182ea5a6c0so3360580a12.0;
        Tue, 12 Aug 2025 07:01:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755007301; x=1755612101;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z41WqqHm3jPsEAQSWV9ab1KvJqxC4OOJyS2SPlqXoDs=;
        b=LR1IVV88wpdG/i4vI1BfHbAVNL1/2NWjBgRNUqtz3QGKu9134KM9IUcLUsuZPJ4MDi
         PZ1UuVXMV2BXeKqSIGGpILqzwn64Ap0SMZRUNfVjxw2a/DzSpkGEFy9tlhafPL8OeDNa
         UG1xkkuLMn/wYHAr039Dy1X2x3t0oq6QN1l8pKO1LAJASXHPgiuVRfWKGGoGmOI57mR+
         OQ1/e1En+s0KdwJKpLsRPXTKES2TTtKjvdnIo2IoDQ10Zarm7HS7lpEkfguJsL6luiAi
         a+KulJPTfWqE0/LVu33vU6evR5PEk8g2ukvoLLxfGVt+YAm18PDB7lmRsFZDc3D1owyQ
         ulZg==
X-Forwarded-Encrypted: i=1; AJvYcCU2Nrf4iY0uZfJRYmadRiIYHbRzD2E3g6pza3ZEaAg/MjeLJ6/cLLGOO61XAqAolAedAHsTAP5E@vger.kernel.org, AJvYcCUOVZa8nFYWbe4n+nRoyyfuz9OxxC4k1/x0nL+tesyjTE+1RjzFT7M1Hfgn7lA70dC+dIHnrD54fDY41nM=@vger.kernel.org, AJvYcCVFtAgarxqovTk4h+7CAeCSjR46DP0ysCPOnlS53rFI3X2qfBi3NfeUtHXXS9zhdH7dNwuZ6UilTYw21JhhAwmo@vger.kernel.org
X-Gm-Message-State: AOJu0Yzlza7mhWMmZDMpnUHIzOc119dyP23qCjV4Arn2oUx7kg2gIbqK
	xJEQRe2gQ1N+7BmwLJoGS/8WOqy8uU3ZSwhdlXIVZnyBe86mT7t+/1PC
X-Gm-Gg: ASbGncudg489e5VmHeIoXu5HGpr5O/eHb1mp3c70PHEcz4DLEMSANLlgZChGGaknS78
	h99Bs5x2L1eMjKinoP3EBcZcVsmmwQ58Smvz4U5pFO3idoQHWuIrccMLGHLRwJR3H4+Fz08GoJD
	Nwy7/hiopC/Kx1sXZPg3tiWIhjcRLFAeypwAZqFObexbyRqdjYF01aSxkbnHY8U9iCtlzjy+Fsh
	0PYAQaiSPxEAtu4BLJY0L0oXGQ+mpzuAbATQ/BBydrMYjzwtktvUeOAno3CYAkDEAzKKm1MNEXj
	6taiZz2qJ076YcpGrepNLQwDdlO/MzTfQTaQF/43eZQpmt/eIHXq58dGjV8CblVPeYEkxfdGc5c
	SfAdnjxNPAXNhyTPGJJJb
X-Google-Smtp-Source: AGHT+IH2Oa1lZpGko68XQYM2zIeyG52WCG9HQvtc//L5c/9Ozf3V0rZMTu7ICB849s2Ogg6flGcIHw==
X-Received: by 2002:a17:906:6a18:b0:af9:a2a9:b5f8 with SMTP id a640c23a62f3a-af9c63c3370mr1564654566b.18.1755007300444;
        Tue, 12 Aug 2025 07:01:40 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a21c0e7sm2206121766b.114.2025.08.12.07.01.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 07:01:39 -0700 (PDT)
Date: Tue, 12 Aug 2025 07:01:37 -0700
From: Breno Leitao <leitao@debian.org>
To: Andre Carvalho <asantostc@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] selftests: netconsole: Validate interface
 selection by MAC address
Message-ID: <6gefv2nqfkxpjicu3ji6ljqwtr4sbjlrwee4ntpvr427qwv3qv@icuhokcpkl2j>
References: <20250811-netcons-cmdline-selftest-v1-1-1f725ab020fa@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250811-netcons-cmdline-selftest-v1-1-1f725ab020fa@gmail.com>

Hello Andre,

On Mon, Aug 11, 2025 at 07:32:09PM +0100, Andre Carvalho wrote:
> Extend the existing netconsole cmdline selftest to also validate that
> interface selection can be performed via MAC address.
> 
> The test now validates that netconsole works with both interface name
> and MAC address, improving test coverage.

Thanks for adding this test!

> --- a/tools/testing/selftests/drivers/net/netcons_cmdline.sh
> +++ b/tools/testing/selftests/drivers/net/netcons_cmdline.sh
> @@ -17,10 +17,6 @@ source "${SCRIPTDIR}"/lib/sh/lib_netcons.sh

> +# Run the test twice, with different cmdline parameters
> +for BINDMODE in "ifname" "mac"
> +do
> +	echo "Running with bind mode: ${BINDMODE}"

Please echo this message to stderr.

> +	# Create the command line for netconsole, with the configuration from the

This is over 80 chars, move the 'the' word in to live below.

> +	# function above
> +	CMDLINE="$(create_cmdline_str "${BINDMODE}")"

I don't think these nested double quotes would work as expected. Maybe
something as:

	CMDLINE=$(create_cmdline_str "${BINDMODE}")

> +	# The content of kmsg will be save to the following file
> +	OUTPUT_FILE="/tmp/${TARGET}-${BINDMODE}"
> +
> +	# Unload the module, if present
> +	rmmod netconsole 2> /dev/null || true

In this case, you do not want netconsole to fail to unload, otherwise
your test will fail, right?

You might want to remove '|| true' completely.

Other than that, the rest looks fine, and with the changes above, please
add:

Reviewed-by: Breno Leitao <leitao@debian.org>

