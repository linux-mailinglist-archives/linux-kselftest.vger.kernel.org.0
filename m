Return-Path: <linux-kselftest+bounces-2539-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 51AB7820BF2
	for <lists+linux-kselftest@lfdr.de>; Sun, 31 Dec 2023 17:27:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D444C1F216E2
	for <lists+linux-kselftest@lfdr.de>; Sun, 31 Dec 2023 16:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B348663B9;
	Sun, 31 Dec 2023 16:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S/LJlL9G"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 054328F4F
	for <linux-kselftest@vger.kernel.org>; Sun, 31 Dec 2023 16:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704040030;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=W9SZrZXQYhT7Sd91knQv7PNkQL8oY2rRS96yOdxg1Q0=;
	b=S/LJlL9G3DfwM0H3JBNqcgPWmcb5rr/VVagu6SYe1czGI+GWzXbpvCSD5qxew6QgeYkJap
	tULIuUP3WlRnZJErv7dZVISBpYXHDmzM6lykv5FlVZFcZVIMpmYbWWAyT9l6Cz/5vtNXYy
	N7PTWnqZCXI+WSbjvmuKDGmNx5dW8xc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-652-cx0-R3YhMRGiNkhV9iBvHA-1; Sun, 31 Dec 2023 11:27:08 -0500
X-MC-Unique: cx0-R3YhMRGiNkhV9iBvHA-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-40d3f53ca2aso42525955e9.0
        for <linux-kselftest@vger.kernel.org>; Sun, 31 Dec 2023 08:27:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704040027; x=1704644827;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W9SZrZXQYhT7Sd91knQv7PNkQL8oY2rRS96yOdxg1Q0=;
        b=XYppHBXvGsDmxyn9+dZtUuKAdAnon4o7iFL+thaBz706Lu2KwVFuGrLWJFfkDCr0VZ
         e2P/+G7UlV55mMzBHpDmUcq5pqo8GWAaRrQXJZRal9G/e9bAthmFBKoWHCff8IIYR9Ku
         dt8M93dnYsc9mWwqhOu1fdvM4lJenuAdD7UvUTh//jVHlWOVGRTqozYIF7n/KfHzhK2j
         rWka1h5nbbLUHxIjCVxJDVuEFfgUuQhxeBHgpUtS9eTeD7hjTvMguM8bYtmWIRxU20bB
         zyxCmJwXyTI81ko8u5Cm2peJF3lOXoJyf115vTeg7Q8HWZTXvfUscE+Czp0gRmuqrYL/
         WOag==
X-Gm-Message-State: AOJu0Yz7KWZmlgEx/Q4fDBzw9EitE04ap+O1MEQEY3lGIAQypAR1tVq2
	/HviKSb9pqKDnc4E+3t0QIpjdB7JVnMqpHr/Bs0w7vB96XUCQ+2UIcHPjF2B958otATCwwdYJ+B
	KaZBkOZC8pd0qEAQlp/X24+Je3TX4XjCrH0YG
X-Received: by 2002:a05:600c:1383:b0:40d:628a:1229 with SMTP id u3-20020a05600c138300b0040d628a1229mr2894706wmf.96.1704040027755;
        Sun, 31 Dec 2023 08:27:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG9b93ScSUl7ZhuJmGttFNJHej7gGjBgYPQSNbx8GJYzHGFQpUOA9OuiE3Dj4nmpqxVpP6n0g==
X-Received: by 2002:a05:600c:1383:b0:40d:628a:1229 with SMTP id u3-20020a05600c138300b0040d628a1229mr2894699wmf.96.1704040027489;
        Sun, 31 Dec 2023 08:27:07 -0800 (PST)
Received: from debian (2a01cb058918ce00b14e8593d3a1c390.ipv6.abo.wanadoo.fr. [2a01:cb05:8918:ce00:b14e:8593:d3a1:c390])
        by smtp.gmail.com with ESMTPSA id w5-20020a5d5445000000b0033660f75d08sm23926474wrv.116.2023.12.31.08.27.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Dec 2023 08:27:06 -0800 (PST)
Date: Sun, 31 Dec 2023 17:27:05 +0100
From: Guillaume Nault <gnault@redhat.com>
To: Yujie Liu <yujie.liu@intel.com>
Cc: netdev@vger.kernel.org, Hangbin Liu <liuhangbin@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	lkp@intel.com, kernel test robot <oliver.sang@intel.com>
Subject: Re: [PATCH v2 net-next] selftests/net: change shebang to bash to
 support "source"
Message-ID: <ZZGWWc9EuSUT52Z3@debian>
References: <20231229131931.3961150-1-yujie.liu@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231229131931.3961150-1-yujie.liu@intel.com>

On Fri, Dec 29, 2023 at 09:19:31PM +0800, Yujie Liu wrote:
> The patch set [1] added a general lib.sh in net selftests, and converted
> several test scripts to source the lib.sh.
> 
> unicast_extensions.sh (converted in [1]) and pmtu.sh (converted in [2])
> have a /bin/sh shebang which may point to various shells in different
> distributions, but "source" is only available in some of them. For
> example, "source" is a built-it function in bash, but it cannot be
> used in dash.
> 
> Refer to other scripts that were converted together, simply change the
> shebang to bash to fix the following issues when the default /bin/sh
> points to other shells.
> 
> # selftests: net: unicast_extensions.sh
> # ./unicast_extensions.sh: 31: source: not found
> # ###########################################################################
> # Unicast address extensions tests (behavior of reserved IPv4 addresses)
> # ###########################################################################
> # TEST: assign and ping within 240/4 (1 of 2) (is allowed)            [FAIL]
> # TEST: assign and ping within 240/4 (2 of 2) (is allowed)            [FAIL]
> # TEST: assign and ping within 0/8 (1 of 2) (is allowed)              [FAIL]
> # TEST: assign and ping within 0/8 (2 of 2) (is allowed)              [FAIL]
> # TEST: assign and ping inside 255.255/16 (is allowed)                [FAIL]
> # TEST: assign and ping inside 255.255.255/24 (is allowed)            [FAIL]
> # TEST: route between 240.5.6/24 and 255.1.2/24 (is allowed)          [FAIL]
> # TEST: route between 0.200/16 and 245.99/16 (is allowed)             [FAIL]
> # TEST: assign and ping lowest address (/24)                          [FAIL]
> # TEST: assign and ping lowest address (/26)                          [FAIL]
> # TEST: routing using lowest address                                  [FAIL]
> # TEST: assigning 0.0.0.0 (is forbidden)                              [ OK ]
> # TEST: assigning 255.255.255.255 (is forbidden)                      [ OK ]
> # TEST: assign and ping inside 127/8 (is forbidden)                   [ OK ]
> # TEST: assign and ping class D address (is forbidden)                [ OK ]
> # TEST: routing using class D (is forbidden)                          [ OK ]
> # TEST: routing using 127/8 (is forbidden)                            [ OK ]
> not ok 51 selftests: net: unicast_extensions.sh # exit=1
> 
> v1 -> v2:
>   - Fix pmtu.sh which has the same issue as unicast_extensions.sh,
>     suggested by Hangbin
>   - Change the style of the "source" line to be consistent with other
>     tests, suggested by Hangbin
> 
> Link: https://lore.kernel.org/all/20231202020110.362433-1-liuhangbin@gmail.com/ [1]
> Link: https://lore.kernel.org/all/20231219094856.1740079-1-liuhangbin@gmail.com/ [2]

Also, please add the missing Fixes tags.

> Reported-by: kernel test robot <oliver.sang@intel.com>
> Signed-off-by: Yujie Liu <yujie.liu@intel.com>


