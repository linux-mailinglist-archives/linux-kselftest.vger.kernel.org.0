Return-Path: <linux-kselftest+bounces-79-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 78B7B7EAD71
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Nov 2023 10:55:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9F8D1C209DE
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Nov 2023 09:55:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C75BA171C0;
	Tue, 14 Nov 2023 09:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="STLJeDmD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7521214AB5;
	Tue, 14 Nov 2023 09:55:14 +0000 (UTC)
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1374A194;
	Tue, 14 Nov 2023 01:55:13 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-5bd6ac9833fso3380454a12.0;
        Tue, 14 Nov 2023 01:55:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699955712; x=1700560512; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dRCTQHNf+ndVVANEprGa5HyYqlhBNGtDrHdcK2WIu8M=;
        b=STLJeDmDtTaApqeuq+jK81SWyXdJodnToUi5Z81TLUF+DGmhOs4Nxn3G0sUNG2yKQP
         5ZXNa5ykn5bhL2kbnQw+2oSCFgY3aLASuWuVXVX0t1kcgmwq4NkzrmbhzY8InA4+cGpr
         PHveab4L9OxhCEsH/4bET9OlEsX0mSbfN7Bqx0WfLumvFDxfwbHPiixwr7W52ac+GDtu
         lsHuhQfYSWDk/jtHDjXvtbypHcqoqCfy4Lr2OastuYyIFmUWUl4PP3GUpby6kMhpaMCH
         xHV6wK188dVFHIig9NHDvJDUROIrfxJHjy40iLrQk/kMUuKjMnWxOwpB5Wn1A3X4IWhn
         QcrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699955712; x=1700560512;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dRCTQHNf+ndVVANEprGa5HyYqlhBNGtDrHdcK2WIu8M=;
        b=g0ysruRoQM8iurt8ZIBb/KNqiaPKsrZjsjqGd63OixZNO2zD0jm/58ppcWdVdTtKNL
         G+ZqME1xvIdhJfkfLbaSXvSXsz2AS8GU57A+d2orfNBWv2suytYVHIcmhPlTOLRjRvyr
         h9jaoXUT6nyh9FwqfCOywAT6iWh145oYVibi7dgYPKggl8dfYN/JcqJRPrOrVXM0woYm
         K/bsm/dpTOuwb1J/Cf2UbHu2iTIvA81S8tUThT47gGVb3Oc6qC6/PnpLpa7+2zV2WrCY
         MEoHc3eVyuScOkg6Bi3XZXOZQr053gy407FEHvDXsG/0qbBXmctWlWUKXHrdfLBP/5Me
         +utw==
X-Gm-Message-State: AOJu0Yx6JqUqbQwh8yths5F/lH4LB9BEKRTh4pl5zbPEy7venSEmW2aQ
	XkZRWNdsi8BcKWJn+rM/m5y3dtKIWlR3aA==
X-Google-Smtp-Source: AGHT+IEZHkkLwaT/b3h0NXABxPM/d6iwqXuwqppGiQvaWFJl28Ewcc0ddOqQw7Ie47d0LErDzkYC5A==
X-Received: by 2002:a05:6a20:12ca:b0:15e:a46f:fcfc with SMTP id v10-20020a056a2012ca00b0015ea46ffcfcmr8106665pzg.21.1699955712001;
        Tue, 14 Nov 2023 01:55:12 -0800 (PST)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id a17-20020a170902ecd100b001c9cb2fb8d8sm5328369plh.49.2023.11.14.01.55.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 01:55:11 -0800 (PST)
Date: Tue, 14 Nov 2023 17:55:05 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>, David Ahern <dsahern@kernel.org>,
	linux-kselftest@vger.kernel.org,
	Po-Hsu Lin <po-hsu.lin@canonical.com>,
	Guillaume Nault <gnault@redhat.com>
Subject: [Discuss] Seeking advice on net selftests netns naming method
Message-ID: <ZVND+e6RKLFudYQA@Laptop-X1>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

Good day! Following Guillaume's suggestion, I've been working on updating all
net self-tests to run in their respective netns. This modification allows us
to execute all tests in parallel, potentially saving a significant amount of
test time.

However, I've encountered a challenge while making these modifications. The
net selftest folder contains around 80 tests (excluding the forwarding test),
with some tests using common netns names and others using self-defined names.
I've considered two methods to address this issue:

One approach is to retain the original names but append a unique suffix using
$(mktemp -u XXXXXX). While this is a straightforward solution, it may not
prevent future tests from using common names.

Another option is to establish a general netns lib. Similar to the NUM_NETIFS
variable in the forwarding test, we could introduce a variable like NUM_NS.
This variable would define the number of netns instances, and all tests would
use the netns lib to set up and clean up netns accordingly. However, this
approach might complicate test debugging, especially for tests like
fib_nexthops.sh, which relies on clear and visually netns names
(e.g., me/peer/remote).

I'm reaching out to gather your insights on this matter. Do you have any
suggestions or preferences regarding the two proposed methods, or do you have
an alternative solution in mind?

Your expertise in this area would be greatly appreciated.

Best Regards
Hangbin

