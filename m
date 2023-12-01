Return-Path: <linux-kselftest+bounces-944-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3DAD80041C
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Dec 2023 07:43:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E1F5B2116E
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Dec 2023 06:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57ACBDDCF;
	Fri,  1 Dec 2023 06:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SmRRsryR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E6EE1717;
	Thu, 30 Nov 2023 22:43:38 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1d011cdf562so1815905ad.2;
        Thu, 30 Nov 2023 22:43:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701413018; x=1702017818; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0yddnFS992tMf8yGV+gCO+8OPk9UQIAfSEyGw6gN3Wg=;
        b=SmRRsryR6hj0rHJYcAK32p/YFzNMr0mqtojsO6Je8ZsvbygK3i0+JDijI9eQZs/otb
         1vtYIorx9KEGRasoqmVexN+v5b3kpvPHqIPbpEybzheLzkbaTL5psvwEgYred47FN2bO
         9I9DSBOqWeCuMDvNMd4H3dtSrBmvs48ZYAkprXH1DE+txJcjjoYoht29nV/4B7ig6Vvv
         f+MgW3oE/uLfJC+/wxVnfSozgnfZaYbJG3NeB7CAtEqcNqE+6E7i4Ul05UJoUPUvA3xA
         KBxcEj/XQFhxXmOEM5y6UVJ5OhOYNmrRnSrLNw6AHFekuPD66wrs51WK4pQIi5IjoTzT
         lq3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701413018; x=1702017818;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0yddnFS992tMf8yGV+gCO+8OPk9UQIAfSEyGw6gN3Wg=;
        b=PvMb7p1LWtghpLptWwbX9mDpcYJzIiv7eX971EELQKtS9tn5t/Jd/KFxaUe/Pq2WyJ
         7RxsrgniktdMuMQISps9T0DzB5W4BJ6MbngL/Zg7UBC7bMgcdhCyUmYPnjrqJHQIxj0v
         A5C3YrlPGjY5J5IkDZgFZZtPA9p400m/Akc7dnTRE4/O4jjEzzon9LD3Kdonk2kFENXa
         mfaM1jUpxX2eCKNsD+jAn20WpYSrh6Ohu41tXN03bX3vQGOxL4exio0recEbnBBFucan
         T+bz7obSTFaIgLFMJYHF7DuyrscdEIy31b3lE1DMNquJC1IPFC9L0iYVs2lpSoePmmGR
         74Ug==
X-Gm-Message-State: AOJu0YwqxVO2O9fDjGWoofa+/35u3vkXMrD1gGoKJZ2bUVXO1bRC1vP7
	ZnfyV9a6j+moJbiBUjOXH0g=
X-Google-Smtp-Source: AGHT+IFboOu7gJP78sklkMvQrBmjjz2znNFgUlTJUZhJQ7qyVuj7ZBA5CsHjP8pxCoVdxTaF2yz7kA==
X-Received: by 2002:a17:903:2281:b0:1cf:ea64:f508 with SMTP id b1-20020a170903228100b001cfea64f508mr14180802plh.2.1701413017955;
        Thu, 30 Nov 2023 22:43:37 -0800 (PST)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 13-20020a170902c20d00b001c737950e4dsm2526386pll.2.2023.11.30.22.43.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 22:43:37 -0800 (PST)
Date: Fri, 1 Dec 2023 14:43:31 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Justin Iurman <justin.iurman@uliege.be>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>, David Ahern <dsahern@kernel.org>,
	linux-kselftest@vger.kernel.org,
	Po-Hsu Lin <po-hsu.lin@canonical.com>,
	Guillaume Nault <gnault@redhat.com>,
	Petr Machata <petrm@nvidia.com>,
	James Prestwood <prestwoj@gmail.com>,
	Jaehee Park <jhpark1013@gmail.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Francesco Ruggeri <fruggeri@arista.com>,
	Xin Long <lucien.xin@gmail.com>
Subject: Re: [PATCHv2 net-next 10/14] selftests/net: convert ioam6.sh to run
 it in unique namespace
Message-ID: <ZWmAk9637Oo4HYOU@Laptop-X1>
References: <20231130040105.1265779-1-liuhangbin@gmail.com>
 <20231130040105.1265779-11-liuhangbin@gmail.com>
 <4ab6e843-fd60-4abf-a23f-c8032e617f5c@uliege.be>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ab6e843-fd60-4abf-a23f-c8032e617f5c@uliege.be>

On Thu, Nov 30, 2023 at 02:28:51PM +0100, Justin Iurman wrote:
> On 11/30/23 05:01, Hangbin Liu wrote:
> > Here is the test result after conversion.
> > 
> > ]# ./ioam6.sh
> > 
> > --------------------------------------------------------------------------
> > OUTPUT tests
> > --------------------------------------------------------------------------
> > TEST: Unknown IOAM namespace (inline mode)                          [ OK ]
> > TEST: Unknown IOAM namespace (encap mode)                           [ OK ]
> > TEST: Missing trace room (inline mode)                              [ OK ]
> > TEST: Missing trace room (encap mode)                               [ OK ]
> > TEST: Trace type with bit 0 only (inline mode)                      [ OK ]
> > ...
> > TEST: Full supported trace (encap mode)                             [ OK ]
> > 
> > --------------------------------------------------------------------------
> > GLOBAL tests
> > --------------------------------------------------------------------------
> > TEST: Forward - Full supported trace (inline mode)                  [ OK ]
> > TEST: Forward - Full supported trace (encap mode)                   [ OK ]
> > 
> > - Tests passed: 88
> > - Tests failed: 0
> > 
> > Acked-by: David Ahern <dsahern@kernel.org>
> > Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> 
> Reviewed-by: Justin Iurman <justin.iurman@uliege.be>
> 
> LGTM. Just one question though. Is there any reason not to use cleanup_ns
> everywhere? There is the following diff (actually, 3 times):

Hi Justin,

Thanks for your review. There is no much intend. I just use del ns for one
line change. And use cleanup_ns for multi line changes. I can make all
ns delete via cleanup_ns in next version.

BTW, I will use `cleanup_ns $ns || true` in next version as cleanup_ns
could return none 0 in PATCHv2.

Thanks
Hangbin

