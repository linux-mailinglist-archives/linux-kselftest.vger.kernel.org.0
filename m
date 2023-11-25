Return-Path: <linux-kselftest+bounces-601-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C9D7E7F8882
	for <lists+linux-kselftest@lfdr.de>; Sat, 25 Nov 2023 06:42:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 778281F20F7B
	for <lists+linux-kselftest@lfdr.de>; Sat, 25 Nov 2023 05:42:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E45B42115;
	Sat, 25 Nov 2023 05:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gaETjL38"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00C6710E7;
	Fri, 24 Nov 2023 21:41:51 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-6b20577ef7bso2216568b3a.3;
        Fri, 24 Nov 2023 21:41:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700890911; x=1701495711; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=J6wsDizGm2fEb2b/YB6rscBcaCVaKK3PX1bmONFcmdI=;
        b=gaETjL38x0XHQbyFk1BOf/2yK6TnP+t0xJEAIUckmWWM4jbipDgpLlyfaSxCxA12cF
         gTWEyMwIgz8p/X5+uAtnkPC8rJG6t7Jx3JpTLO11bwR/SHubVnMU9OdPl2iHgu1PYa1I
         oYlvnZtNgyvMuuU2xx6CMPUIrJ9Ppn6vJWvKG+rSTQfCO7DMlDaUFgqFit2FFBMsvjte
         pqbhsbSxzn3Kf5S9N4+lznu/iEBr5Slmpe5gupdj/jCrn5ENzgdgZjo732XYTCBD3Fhi
         g1bG+D/VFMBenKczz4vckeRkZVm3AdIQHQwDXPGxsVWGfbptfvz7+k+gaHcWagHYTu+w
         kRLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700890911; x=1701495711;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J6wsDizGm2fEb2b/YB6rscBcaCVaKK3PX1bmONFcmdI=;
        b=QQaO9vD1a8iGF9+9mAr3zfTjeOFrFXVd93oBa3zehvVhuZXvELt9MJ7VvJSqUaCIh2
         XNN7r9KbaOhOkRmR7SrA3/+aXXpt751EXGPtUEKVxQPU4LqEOHI09nfoDO0PuZrXVKK2
         rbqdeAbYffpKIL8ZewLok7o8xvpy9GLaBvcLgzVHGecHww9UIuqhQ+HVQhhHhjli/FE3
         D2bas+HA0Vz210RPsEWPV7YqKXi5O6sVOqbWIhgV+2ie9aDsaufGmSRiIYIGnojda0OV
         JUPHZdwYNH2iCEWan7H76KKGV7ZOW1VXs6pUodllsTTcKFX2661Nbh/E+AyXpE8a/pdk
         YxiA==
X-Gm-Message-State: AOJu0YxCUauil3RpKq8aVTEbJQk6oza2qIIeOz5hqVwdSFqk2Shi/FDA
	cuNSiRTlgnwyOh+DTUg1nABMNFfSBt4P+A==
X-Google-Smtp-Source: AGHT+IFW8tPa1iEy5x2mRcsuY8StfsJIz6cSo32hR86/aZxt1hfus86R5ZgFePlI39ZKOs8paxLLtw==
X-Received: by 2002:a05:6a20:c523:b0:18b:3122:f818 with SMTP id gm35-20020a056a20c52300b0018b3122f818mr5569616pzb.38.1700890911345;
        Fri, 24 Nov 2023 21:41:51 -0800 (PST)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id iy7-20020a170903130700b001cfa70f3a53sm2004702plb.271.2023.11.24.21.41.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 21:41:50 -0800 (PST)
Date: Sat, 25 Nov 2023 13:41:44 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Petr Machata <petrm@nvidia.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>, David Ahern <dsahern@kernel.org>,
	linux-kselftest@vger.kernel.org,
	Po-Hsu Lin <po-hsu.lin@canonical.com>,
	Guillaume Nault <gnault@redhat.com>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@rivosinc.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Mark Brown <broonie@kernel.org>,
	Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: [PATCH net-next 01/38] selftests/net: add lib.sh
Message-ID: <ZWGJGDV3TKYUsqqW@Laptop-X1>
References: <20231124092736.3673263-1-liuhangbin@gmail.com>
 <20231124092736.3673263-2-liuhangbin@gmail.com>
 <87h6lbfdnh.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87h6lbfdnh.fsf@nvidia.com>

On Fri, Nov 24, 2023 at 03:05:18PM +0100, Petr Machata wrote:
> 
> Hangbin Liu <liuhangbin@gmail.com> writes:
> 
> > Add a lib.sh for net selftests. This file can be used to define commonly
> > used variables and functions.
> >
> > Add function setup_ns() for user to create unique namespaces with given
> > prefix name.
> >
> > Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> > ---
> > diff --git a/tools/testing/selftests/net/lib.sh b/tools/testing/selftests/net/lib.sh
> > new file mode 100644
> > index 000000000000..239ab2beb438
> > --- /dev/null
> > +++ b/tools/testing/selftests/net/lib.sh
> > @@ -0,0 +1,98 @@
> > +#!/bin/bash
> > +# SPDX-License-Identifier: GPL-2.0
> > +
> > +##############################################################################
> > +# Defines
> > +
> > +# Kselftest framework requirement - SKIP code is 4.
> > +ksft_skip=4
> > +# namespace list created by setup_ns
> > +NS_LIST=""
> > +
> > +##############################################################################
> > +# Helpers
> > +busywait()
> > +{
> > +	local timeout=$1; shift
> > +
> > +	local start_time="$(date -u +%s%3N)"
> > +	while true
> > +	do
> > +		local out
> > +		out=$($@)
> > +		local ret=$?
> > +		if ((!ret)); then
> > +			echo -n "$out"
> > +			return 0
> > +		fi
> > +
> > +		local current_time="$(date -u +%s%3N)"
> > +		if ((current_time - start_time > timeout)); then
> > +			echo -n "$out"
> > +			return 1
> > +		fi
> > +	done
> > +}
> 
> This is lifted from forwarding/lib.sh, right? Would it make sense to

Yes.

> just source this new file from forwarding/lib.sh instead of copying

Do you mean let net/forwarding/lib.sh source net.lib, and let other net
tests source the net/forwarding/lib.sh?

Or move the busywait() function from net/forwarding/lib.sh to net.lib.
Then let net/forwarding/lib.sh source net.lib?

> stuff around? I imagine there will eventually be more commonality, and
> when that pops up, we can just shuffle the forwarding code to
> net/lib.sh.

Yes, make sense.

Thanks
Hangbin

