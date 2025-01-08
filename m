Return-Path: <linux-kselftest+bounces-24051-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D839A05987
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Jan 2025 12:19:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6056D3A50B7
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Jan 2025 11:19:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89A461F893B;
	Wed,  8 Jan 2025 11:19:38 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 081981A9B25;
	Wed,  8 Jan 2025 11:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736335178; cv=none; b=m93QnYSd61TO9k8QrI5uW8ADjTAYCD2wivsEOYOGcaxjxYFIVuzH5UYLUYR3W6Td691ma+lqcOmM2m9kJSLiCJq6ROSl7EY8hFl7yxMVMTJDclGUH2gUCP5l7jb4LbxVlCyPAaaeICX2xC7QRAZmF7RUa7TuHWUMfxYuQ/FbtuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736335178; c=relaxed/simple;
	bh=yeUemPURzxnkOKE217P6sfksaBXEA5Ks98fHnGpHndM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E7ZEjwMYgP/f2zFyw2nuxJ5aQGCWg47KpylJTG/8lQowQKiZ9rALBDXphutstPsX9RQvGDybQdTVg6M6BHufwF7SJ+4/OQPFK0HQQoZQPTo7QH3+3AIeUbXniRNNaIpyCKtzYTSl+2w3aWQdOEPLsAQc+7Nxcr8gJSEQkz66xQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-aab925654d9so2924591966b.2;
        Wed, 08 Jan 2025 03:19:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736335174; x=1736939974;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qdZdR2vmY6pQ6CbeX0E/1eal93fC7L+t/jqfobGLHOg=;
        b=AC+0ZOzjeqaTbWK86jWMIbxvZmQUIO9/hID3kX/L8XDZCxFozL6zLjARuO6ghYxBpT
         ttdssqbcj6hNw6k7B27PNlifcx1lmt4q3GITBoam7I4VTTfHOkOGNhdn+jxoLZ0aaSNy
         XwtBjX6nCwjYO5mnfNb/YeFlZ3gwnW+el67JGtaCX3ErO5MJF8rXpTjkhzLC9uTpswAE
         SEXWvTwElQJnxaBTTMoaBJpajKGB92c2o1FPgQ76SDX35imZYs7tZibOVVZ8ibrSrSJt
         PXCeRyrDP97A2vVOLlNSBdBXXft/3O/17dYNzFkPGe19Q55lmkoVLW/udmrxBt1WBEx0
         +K5Q==
X-Forwarded-Encrypted: i=1; AJvYcCVrpaR7GkrRK76be3DBTZaJ3uGb4hHLbj5FB9IM2hXauM1decmMguIQEt1TVnS2yDzc48q76d7S9TfKSSg=@vger.kernel.org, AJvYcCWAhoEK5ftIFviR41r989gMlrV13Bv61wkRuvcAZCv4fz4tB9qjTnyxHNkYLBRG79IbFaV1FY8j@vger.kernel.org, AJvYcCXnvRZOiJabNH0rz2iyYjzJiranoUFFAjU6lXasBzlsmF+cMMwKADPGHUXOQ5GnfmNii2cD6lcm6MJSSU4e/Dl5@vger.kernel.org
X-Gm-Message-State: AOJu0YzDzFtKG/aXyE9DI9clEpbr6NT2uf8yqFAsSPzD6eHXgGNbcrr1
	cig7ML64Q+3sncnttl/tDdKP+lPuy7regbIqs8gazmz5sz7MeYCSHFXy9w==
X-Gm-Gg: ASbGnctQWHBYjXrRPZb+6gedfh0Zwm85dVYXz3C3xAsBdx4C+28LqPqGDHzET2Od/lT
	nBH7EpWrh3YurzVRHFSjP7y85oI1P08JRa4W7nN+CvDL2GHkEKR3ImPZUHUGpLOr3SVKicP+XKI
	YSQsxJR22xuOkutm6lA857r+q4WDWtWRIs47yBKa20j/mW9e+2a1C39aZ54iBNFCg/kW9Rhi956
	n9Ix0QM7NMRzVI7/5Si0k65RSAi6fCDkwRPsEJAsefz/1uZ
X-Google-Smtp-Source: AGHT+IHLUmbkBfm8XFo3JgVs6d0HcYccmRHZ8A9kTcesVdXpYSZN39A0Hhu5szytmk47QfjVcYnudw==
X-Received: by 2002:a17:906:f583:b0:aab:f124:cb82 with SMTP id a640c23a62f3a-ab2ab73e7fcmr171948066b.28.1736335174079;
        Wed, 08 Jan 2025 03:19:34 -0800 (PST)
Received: from gmail.com ([2a03:2880:30ff:70::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aac0f015ab9sm2463032466b.155.2025.01.08.03.19.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2025 03:19:33 -0800 (PST)
Date: Wed, 8 Jan 2025 03:19:31 -0800
From: Breno Leitao <leitao@debian.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	kernel-team@meta.com, Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net-next v2 2/4] netconsole: selftest: Split the helpers
 from the selftest
Message-ID: <20250108-hidden-wakeful-cuckoo-14a2bf@leitao>
References: <20250103-netcons_overflow_test-v2-0-a49f9be64c21@debian.org>
 <20250103-netcons_overflow_test-v2-2-a49f9be64c21@debian.org>
 <20250106160653.2fcdb192@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250106160653.2fcdb192@kernel.org>

On Mon, Jan 06, 2025 at 04:06:53PM -0800, Jakub Kicinski wrote:
> On Fri, 03 Jan 2025 04:57:50 -0800 Breno Leitao wrote:
> > Split helper functions from the netconsole basic test into a separate
> > library file to enable reuse across different netconsole tests. This
> > change only moves the existing helper functions to lib/sh/lib_netcons.sh
> > while preserving the same test functionality.
> > 
> > The helpers provide common functions for:
> > - Setting up network namespaces and interfaces
> > - Managing netconsole dynamic targets
> > - Setting user data
> > - Handling test dependencies
> > - Cleanup operations
> > 
> > Do not make any change in the code, other than the mechanical
> > separation.
> 
> You have to update the Makefile, we don't wildcard all files under
> drivers/net/lib, the lib support in ksft is not great :(
> 
> $ make -C tools/testing/selftests/ \
> 	TARGETS="drivers/net drivers/net/hw" \
> 	install INSTALL_PATH=/tmp/ksft-net-drv
> [... noise ...]
> $ find /tmp/ksft-net-drv/ -iname '*netcons*'
> /tmp/ksft-net-drv/drivers/net/netcons_basic.sh
> /tmp/ksft-net-drv/drivers/net/netcons_overflow.sh
> 
> .. your new lib file won't get installed.

Thanks for the detailed explanation. I found that the new lib was not
installed.

I will be adding the following to the upcoming revision.

/tools/testing/selftests/drivers/net/Makefile
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0

 TEST_INCLUDES := $(wildcard lib/py/*.py) \
+                $(wildcard lib/sh/*.sh) \
		 ../../net/net_helper.sh \
		 ../../net/lib.sh \

