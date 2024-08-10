Return-Path: <linux-kselftest+bounces-15115-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A2E794DDD6
	for <lists+linux-kselftest@lfdr.de>; Sat, 10 Aug 2024 19:55:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C225B281D3B
	for <lists+linux-kselftest@lfdr.de>; Sat, 10 Aug 2024 17:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88C1416A925;
	Sat, 10 Aug 2024 17:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lnczJst0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1765C15F41D;
	Sat, 10 Aug 2024 17:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723312519; cv=none; b=TaurzAUBhN0aSqC/FNsMNs9puxqrZ222Y5/sk0pRPRqEWRlrAf94vvIL50ocwGPC9jAmDgVb/H+lq/gR9jgX5ybnULE4L+FjhDWcgrF4is2oNjc9Xbncvckn+4lDJWsjWrZr3FLpK+aRcLQY4u/6eQP9ooNq4t9lcwmiLYMgfd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723312519; c=relaxed/simple;
	bh=tdaviMc2TG3WkTjS6C7+l204PFwlWjyYpWMbyuQCMIM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Adrtnynks+zNzgh8vyMESycwe7/zr6LZSh59Pv5k8pftzB4RBSqqt8936BpxpP1am8vZZ9hxyHdJglyt5rzRzQYf5zcd/titPWrzq+C5hfesjN1BqnEPOJbRI8UoBww1NdYoIYMjAwgG5WeCgvDpy1ORve7+wyxTnsDTpL5wtLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lnczJst0; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-70d23caf8ddso2807431b3a.0;
        Sat, 10 Aug 2024 10:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723312517; x=1723917317; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cuMWPq3zFnrRfqIZyBDjzbfpHEka0Q64/eSHWhAQ05E=;
        b=lnczJst0etgqCzT4e6Cr2l1jdJOTSQYa3XEAQYnS7GVV21uPeqjpCxjG3PhCWGlYJk
         P/VAHSdzTpvQJze42IP2wowVNeJt/MtnIVeGo3oF3O0LdlDxGTx5OJeZ5NmOFjLo+pTF
         iSD9bozjXTkFBiUSbYZW+MR5V6gCdGbCi1iaB84/CkQ44/vBP730juVGIPmCJ0Uwx2Ih
         srcrQsGaFRmbV5pGU5F/EBlGeU2hroM03yPnISF4pkwDyj2ObbbLt2xroQILxIrs10JG
         PbZamYnyUIJ4sLxjmk5LGLQQSe2yG9IP/PPqB8G0auoX+RjxB10Lq/7AaxaVihfBeJ1T
         s5eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723312517; x=1723917317;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cuMWPq3zFnrRfqIZyBDjzbfpHEka0Q64/eSHWhAQ05E=;
        b=NJKpZ/47ED8wZgHkcoS8xNflqJG0cJFNTbrAev2Zy0RIsf0Jg+S0R7HRXVUjl5EAms
         o89JBTZYniWVIYFff5nmyFkJk37dYWFFOwGPvns7WM8ApWay54sIomGWBKi/n2OBAbYf
         Jf9p4OJCWbBSm+SfN5PMJDn08BC8Sla5fYsKrSneCvFi3rn9UBUVxXUXUIwqmM3JoCxF
         IHLMUod9CyVQoYaK1qPaTlYMNDtnZWay2QT5ym3j8mrgdmoTsrCn1YD7lOoNdMo6Qr1T
         GVKBtCZAgT7lCNJBtLh/0sQr2uT0Y1JMr19RhAETlpypSZzW1bO/kgwrG2PTUEQibbS0
         wiDA==
X-Forwarded-Encrypted: i=1; AJvYcCWpZ3HjkJkHKmrdJnab/dZxUdKSoOg/zBxq3EPIQZP/n9WNhPfaUO3iIOUczmmvqWy2KankazEPl2Hb8/6lhzchRlC+ECcXZ/RgRSiGg9hbMtmpDd90dHMIsNLv1oqzgHf5G5+x+rTYpsYo0CGvrOu/e7JBxI/EnaykQkM3g27qvAKKIXq7
X-Gm-Message-State: AOJu0Yyg9zsIpJT9B3jp7IFrxLMsTE5bpoZfLVx3BRbrL/lWLN4SfkXy
	PrJVnLsW7ztwTrt4CeoD02Qgm5aS+rc9cEF+h4FYmPdv3MvnHmtRWR3y+lAW
X-Google-Smtp-Source: AGHT+IHkec/yLGTRhkhmkBsz89ZalfED3kUVTPgt9AJXwwhzlR+HuPlHN6rMVXvOeKw0lqa/C4IFoQ==
X-Received: by 2002:a05:6a21:b8b:b0:1c4:818c:299d with SMTP id adf61e73a8af0-1c89fbbe138mr6716274637.11.1723312517242;
        Sat, 10 Aug 2024 10:55:17 -0700 (PDT)
Received: from dev0.. ([49.43.168.43])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7c3dbe12ff2sm1568868a12.33.2024.08.10.10.55.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Aug 2024 10:55:16 -0700 (PDT)
From: Abhinav Jain <jain.abhinav177@gmail.com>
To: kuba@kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	jain.abhinav177@gmail.com,
	javier.carrasco.cruz@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	shuah@kernel.org,
	skhan@linuxfoundation.org
Subject: Re: [PATCH v5 1/2] selftests: net: Create veth pair for testing in networkless kernel
Date: Sat, 10 Aug 2024 17:55:09 +0000
Message-Id: <20240810175509.404094-1-jain.abhinav177@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240809211911.1445c965@kernel.org>
References: <20240809211911.1445c965@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 9 Aug 2024 21:19:11 -0700, Jakub Kicinski wrote:

> > On Thu, 8 Aug 2024 09:23:09 -0700, Jakub Kicinski wrote:
> > > A number of checks now return SKIP because veth doesn't support all
> > > ethtool APIs.
> > >
> > > In netdev selftests we try to make sure SKIP is only used when test
> > > cannot be performed because of limitations of the environment.
> > > For example some tool is not installed, kernel doesn't have a config.
> > > Something that the person running the test is able to fix by fixing
> > > how the test is run.
> > >
> > > Running this test on veth will always SKIP, nothing CI system can do.
> > > Please make the test use the keyword XFAIL instead of SKIP when
> > > functionality is not supported by the underlying driver.  
> > 
> > Ack, understood. I will do that, one clarification though.
> > Currently, the tests are using either PASS or FAIL and no SKIP. Based on
> > the above suggestion, it seems that I have replace FAIL with XFAIL for all
> > the tests that fail due to functionality not being supported by the
> > underlying driver.
>
> Right, sorry for lack of clarity.
>
> Our CI doesn't fully trust the exit codes, so even though the test
> exits with zero the CI parses the output and finds the "SKIP: ..."
> lines. You need to replace those "SKIP"s in the output with "XFAIL".

I re-tested and found that currently only two APIs are tested, "dump" and
"stats". For veth pair, the only test that fails currently with a SKIP is
the dump operation.

```
# Cannot get register dump: Operation not supported
# SKIP: veth1: ethtool dump not supported
```

This is present in kci_netdev_ethtool_test function, please confirm if this
is the one that I need to change to XFAIL. The logic to incorporate
the failure exit code for dump operation (74) is already in place.

```
kci_netdev_ethtool_test 74 'dump' "ethtool -d $netdev"
```

I just need to change the SKIP in this function to XFAIL. In case, if you
were referring to any other tests that are failing (features on/off),
please let me know. Thank you for prompt feedbacks, really appreciated.

